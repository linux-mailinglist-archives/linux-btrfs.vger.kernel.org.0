Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C83185E3F
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Mar 2020 16:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbgCOPoN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Mar 2020 11:44:13 -0400
Received: from mailfilter03-out31.webhostingserver.nl ([141.138.168.202]:44858
        "EHLO mailfilter03-out31.webhostingserver.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728535AbgCOPoN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Mar 2020 11:44:13 -0400
X-Halon-ID: d017ce39-66d3-11ea-9f46-001a4a4cb9a5
Received: from s198.webhostingserver.nl (unknown [195.211.72.171])
        by mailfilter03.webhostingserver.nl (Halon) with ESMTPSA
        id d017ce39-66d3-11ea-9f46-001a4a4cb9a5;
        Sun, 15 Mar 2020 16:44:10 +0100 (CET)
Received: from [2001:981:6fec:1:5c6d:3bf:b008:a656]
        by s198.webhostingserver.nl with esmtpa (Exim 4.92.3)
        (envelope-from <fntoth@gmail.com>)
        id 1jDVQw-009lXe-6v; Sun, 15 Mar 2020 16:44:10 +0100
Subject: Re: Howto take a snapshot from an image as ordinary user?
To:     Ferry Toth <ftoth@telfort.nl>, linux-btrfs@vger.kernel.org
Newsgroups: gmane.comp.file-systems.btrfs
References: <58ad5d52-425a-a89d-d042-e9941088828a@gmail.com>
 <d87f9e87-0e77-c758-aae9-f0d069b0e6da@telfort.nl>
From:   Ferry Toth <fntoth@gmail.com>
Message-ID: <8df0a5eb-79ef-db9e-4b9b-94fc9a8554e6@gmail.com>
Date:   Sun, 15 Mar 2020 16:48:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d87f9e87-0e77-c758-aae9-f0d069b0e6da@telfort.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SendingUser: hidden
X-SendingServer: hidden
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Authenticated-Id: hidden
X-SendingUser: hidden
X-SendingServer: hidden
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

