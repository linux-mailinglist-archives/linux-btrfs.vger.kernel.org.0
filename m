Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C434415935
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 09:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239638AbhIWHmt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 03:42:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41770 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhIWHmt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 03:42:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3E9C922258;
        Thu, 23 Sep 2021 07:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632382877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Va0RfLjYPfM29YuV/5nEmvugb+zXgyXJReuOuBESdY=;
        b=X6lWz153f0e7Om/5lY7O6YmTclpBYNo7SdGOMvwC9FUi8cWk/4FcsD8Ts6w9A49UmFu1NK
        IDK1U+yoRIWGPJI/LISDYJb2B873g3C8OLwhw7XzJXWAqbut9dcPmyxrae3ijWCNcCefys
        CXiI/MBXYRCg3EEPOSPnIxfXZgtkfAs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D10613DC6;
        Thu, 23 Sep 2021 07:41:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w914O5wvTGFqAwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 23 Sep 2021 07:41:16 +0000
Subject: Re: [PATCH] clear_bit BTRFS_DEV_STATE_MISSING if the device->bdev is
 not NULL During mount.
To:     Li Zhang <zhanglikernel@gmail.com>, linux-btrfs@vger.kernel.org
References: <1632330390-29793-1-git-send-email-zhanglikernel@gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <5679da1e-2422-69c5-b4f8-326802363f7c@suse.com>
Date:   Thu, 23 Sep 2021 10:41:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1632330390-29793-1-git-send-email-zhanglikernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22.09.21 г. 20:06, Li Zhang wrote:
> reference to:
> https://github.com/kdave/btrfs-progs/issues/389
> If a device offline somehow, but after a moment, it is back
> online, btrfs filesystem only mark the device is missing, but
> don't mark it right.
> 
> However, Although filesystem mark device presented, in my
> case the /dev/loop2 is come back, the generation of this
> /dev/loop2 super block  is not right.Because the device's
> data is not up-to-date.  So the info of status of scrubs
> would list as following.:
> 
> $ losetup /dev/loop1 test1
> $ losetup /dev/loop2 test2
> $ losetup -d /dev/loop2
> $ mount -o degraded /dev/loop1 /mnt/1
> $ touch /mnt/1/file1.txt
> $ umount /mnt/1
> $ losetup /dev/loop2 test2
> $ mount /dev/loop1 /mnt/1
> $ btrfs scrub start /mnt/1
> scrub started on /mnt/1, fsid 88a3295f-c052-4208-9b1f-7b2c5074c20a (pid=2477)
> $ WARNING: errors detected during scrubbing, corrected
> 

THis seems it can be turned into an fstests rather easily, care to send
a patch for it as well ?

> $btrfs scrub status /mnt/1
> UUID:             88a3295f-c052-4208-9b1f-7b2c5074c20a
> Scrub started:    Thu Sep 23 00:34:55 2021
> Status:           finished
> Duration:         0:00:01
> Total to scrub:   272.00KiB
> Rate:             272.00KiB/s
> Error summary:    super=2 verify=5
>   Corrected:      5
>   Uncorrectable:  0
>   Unverified:     0
> 
> And if we umount and mount again everything would be all right.
> 
> In my opinion, we could improve this scrub in the following
> way, i personally vote the second method
> 
> 1) Sync all data immediately during mounting, but it waste IO
> resource.
> 
> 2) In scrub, we should give detailed information of every device
> instead of a single filesystem, since scrub is launching a number
> of thread to scanning each device instead scan whole filesystem.
> Futher more we should give user hint about how to fix it, in my
> case, user should umount filesystem and mount it again. But if
> data is corrupt, the repair program might be called,  in case of
> further damage, user should replace a device and reconstruct
> ata using raid1, raid6 and so on.
> 
> Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
> ---
>  fs/btrfs/volumes.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 464485a..99fdbaa 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7198,6 +7198,11 @@ static int read_one_dev(struct extent_buffer *leaf,
>  			set_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
>  		}
>  
> +		if (device->bdev && test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state) && device->fs_devices->missing_devices > 0) {
> +			device->fs_devices->missing_devices--;
> +			clear_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
> +		}
> +
>  		/* Move the device to its own fs_devices */
>  		if (device->fs_devices != fs_devices) {
>  			ASSERT(test_bit(BTRFS_DEV_STATE_MISSING,
> 
