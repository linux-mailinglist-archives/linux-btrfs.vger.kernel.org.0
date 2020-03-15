Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3116185E40
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Mar 2020 16:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgCOPpF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Mar 2020 11:45:05 -0400
Received: from ciao.gmane.io ([159.69.161.202]:48704 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728535AbgCOPpF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Mar 2020 11:45:05 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcfb-btrfs-devel-moved1-3@m.gmane-mx.org>)
        id 1jDVRm-000R2o-A6
        for linux-btrfs@vger.kernel.org; Sun, 15 Mar 2020 16:45:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-btrfs@vger.kernel.org
From:   Ferry Toth <fntoth@gmail.com>
Subject: Re: Howto take a snapshot from an image as ordinary user?
Date:   Sun, 15 Mar 2020 16:48:09 +0100
Message-ID: <8df0a5eb-79ef-db9e-4b9b-94fc9a8554e6@gmail.com>
References: <58ad5d52-425a-a89d-d042-e9941088828a@gmail.com>
 <d87f9e87-0e77-c758-aae9-f0d069b0e6da@telfort.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <d87f9e87-0e77-c758-aae9-f0d069b0e6da@telfort.nl>
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Op 08-03-2020 om 16:39 schreef Ferry Toth:
> Hi
> 
> Op 07-03-2020 om 22:21 schreef Ferry Toth:
>> I am generating a btrfs system image using Yocto.
>>
>> I want to take a snapshot from the image preferably inside a Yocto 
>> recipe. The snapshot I can send 'over the air' to the remote (IoT) 
>> device.
>>
>> Now I am able to loop mount the image file using udisksctl as an 
>> ordinary user, which mounts the image under /media/ferry.
>>
>> However, the owner of the mount point is root, and it appears I am not 
>> allowed to take a snapshot as an ordinary user.
> 
> To clarify, I know that I can chown the mount point after mounting.
> But to do that I need to sudo it.

I found a way to own the mount point. The procedure is:
1) create an ext34 file system with
EXTRA_IMAGECMD_ext3 += " -E root_owner=`/bin/ps -o user= -p $$`:`/bin/ps 
-o group= -p $$`"

Yocto runs the image generation under pseudo (alternative fakeroot). The 
above allows to create an ext3 file system with the root owned by the 
real current user.

2) btrfs-convert the ext3 image to btrfs
3) take the snapshot

The final step (btrfs send) fails with:
ERROR: check if we support uuid tree fails - Operation not permitted
ERROR: failed to initialize subvol search: Operation not permitted

It appears it just can't be done currently as I could have from:
https://webcache.googleusercontent.com/search?q=cache:oZR58gPBVRkJ:https://www.spinics.net/lists/linux-btrfs/msg31188.html+&cd=1&hl=en&ct=clnk&gl=nl&client=ubuntu

HOSTTOOLS += " /usr/bin/udisksctl /bin/btrfs /bin/btrfs-convert /bin/ps"

# we are running as pseudo but we need ownership of the root as the real 
user
EXTRA_IMAGECMD_ext3 += " -E root_owner=`/bin/ps -o user= -p $$`:`/bin/ps 
-o group= -p $$`"
IMAGE_FSTYPES += " ext3"

python do_btrfs_snapshot() {
     import subprocess

     # convert the ext3 image
     cmd_mkimg = 'btrfs-convert  ' + 
d.expand("${DEPLOY_DIR_IMAGE}/${IMAGE_BASENAME}-${MACHINE}.ext3")
     ret = subprocess.run(cmd_mkimg, shell=True, capture_output=True, 
text=True)

     # mount the converted ext3 image
     cmd_mkimg = '/usr/bin/udisksctl loop-setup --no-user-interaction -f 
  ' + d.expand("${DEPLOY_DIR_IMAGE}/${IMAGE_BASENAME}-${MACHINE}.ext3")
     ret = subprocess.run(cmd_mkimg, shell=True, capture_output=True, 
text=True)
     loop = ret.stdout.split(' ').pop().split('.')[0]

     # find the mounted partition
     cmd_mkimg = 'lsblk -o MOUNTPOINT -n ' + loop
     ret = subprocess.run(cmd_mkimg, shell=True, capture_output=True, 
text=True)
     mount_point = ret.stdout.rstrip()

     # take a snapshot of the partition
     cmd_mkimg = '/bin/btrfs su snap -r ' + mount_point + ' ' + 
mount_point + '/@new'
     print(cmd_mkimg)
     ret = subprocess.run(cmd_mkimg, shell=True, capture_output=True, 
text=True)

     # btrfs send the partition
     cmd_mkimg = '/bin/btrfs send ' + mount_point + '/@new/ > ' + 
d.expand("${DEPLOY_DIR_IMAGE}/${IMAGE_BASENAME}-${MACHINE}.snapshot")
     ret = subprocess.run(cmd_mkimg, shell=True, capture_output=True, 
text=True)
     print(ret.stdout)
     print(ret.stderr)

     # unmount the btrfs image
     cmd_mkimg = '/usr/bin/udisksctl unmount -b ' + loop
     ret = subprocess.run(cmd_mkimg, shell=True, capture_output=True, 
text=True)

     # delete the loop device
     cmd_mkimg = '/usr/bin/udisksctl loop-delete -b ' + loop
     ret = subprocess.run(cmd_mkimg, shell=True, capture_output=True, 
text=True)

     return 0
}

addtask btrfs_snapshot after image_ext3 before do_bootimg
>> I think it is obvious that I don't want to run bitbake as root.
>>
>> So what is the recommended way to generate a snapshot without becoming 
>> root?
>>
>> Thanks,
>>
>> Ferry
>>
>>
> 
> 


