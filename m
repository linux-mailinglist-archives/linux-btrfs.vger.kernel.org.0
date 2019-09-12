Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 438D9B109A
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732409AbfILODg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 10:03:36 -0400
Received: from hawking.davidnewall.com ([203.20.69.83]:57765 "EHLO
        hawking.rebel.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731816AbfILODg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 10:03:36 -0400
Received: from [172.30.0.109] (ppp14-2-96-129.adl-apt-pir-bras32.tpg.internode.on.net [::ffff:14.2.96.129])
  (AUTH: PLAIN davidn, SSL: TLSv1/SSLv3,128bits,AES128-SHA)
  by hawking.rebel.net.au with ESMTPSA; Thu, 12 Sep 2019 23:33:32 +0930
  id 000000000006518B.5D7A5035.00006301
Subject: Re: Mount/df/PAM login hangs during rsync to btrfs subvolume, or
 maybe doing btrfs subvolume snapshot
References: <933c8585-c0f9-b9d8-c805-caca0eaddae0@gmx.com>
From:   David Newall <btrfs@davidnewall.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
X-Forwarded-Message-Id: <933c8585-c0f9-b9d8-c805-caca0eaddae0@gmx.com>
Message-ID: <b4994446-b352-e78d-b2d3-805276b28623@davidnewall.com>
Date:   Thu, 12 Sep 2019 23:33:32 +0930
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <933c8585-c0f9-b9d8-c805-caca0eaddae0@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Qu,

Thank you very much for helping me with this.

On 12/9/19 4:35 pm, Qu Wenruo wrote:
> Would you please check how fast (or how slow in this particular case)
> the related disks are?
> To me, it really looks like just too slow devices.

I discover that you are correct about the underlying storage being 
slow.  Nikolay suggested that, too.

Although I mentioned that the filesystem is encrypted with luks on the 
VM, I didn't say that the underlying storage is connected via multipath 
iSCSI (with two paths) on the host server, and provided to the VM via 
KVM as Virtio disk, which should be fine, but, using dd (bs=1024k 
count=15) on the VM, I'm seeing a woeful 255KB/s read speed through the 
encryption layer, and 274KB/s from the raw disk.  :-(

On the host, I'm seeing 2MB/s via one path and 846KB/s via the other, so 
I think that's where I need to turn my attention.  (Time to benchmark, 
turn off one path, and speak to the DC management.)

> I see all dumps are waiting for write_all_supers.
>
> Would you please provide the code context of write_all_supers.isra.43+0x977?
>
> I guess it's wait_dev_flush(), which is just really waiting for disk writes.

Sorry, I don't understand what you mean by "code context".  Maybe the 
question is now moot.

Although it's now apparent that I've got a really slow disk, I still 
wonder if btrfs is holding a lock for an unnecessarily long time 
(assuming that it is btrfs holding the lock.)  I feel that having to 
wait tens of minutes to find the device names of mounted devices could 
never be intended, so there might be something that needs tweaking.

On 12/9/19 3:58 pm, Nikolay Borisov wrote:
> Actually when the issue occurs again can you sample the output of
> echo w > /proc/sysrq-trigger.  Because right now you have provided
> 3 samples in the course of I don't know how many minutes. So they just give
> a momentarily glimpse into what's happening. E.g. just because we saw
> btrfs transaction/btrfs_show_devname doesn't necessarily mean that's
> what's happening (Though having the same consistent state in the 3 logs
> kind of suggests otherwise).

Again, it's probably all moot, now, but I did take samples at about 
20-second intervals during 20-minutes of the "hang" period while rsync 
was running.  See https://davidnewall.com/kern.5 through kern.62.

Thanks to all for your help.

Regards,

David

