Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F67C3FE92A
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 08:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbhIBGRZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 02:17:25 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37360 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhIBGRZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 02:17:25 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9C5332256F;
        Thu,  2 Sep 2021 06:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630563386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IypWERUZsMlyJDXseLXxWLVmBJY5SdVm5GtAnaUjPps=;
        b=ZNZBkK/EPISmH8GeLKjE8224spgUurBfASHVfuLSBkk7FhjpKxWuHsfGTmJ/Lw3sn0RylM
        gwdumAFCg5CfwylY87wYAWLl+R/MzB4nkBFp3Zc+sBdtHqsbsT30SOVQryutx97jrj+vAC
        WT9FWRrL3e89dPgM40R+2QiwsRSARS0=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6DAC51389C;
        Thu,  2 Sep 2021 06:16:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id KlCyFzpsMGGfKgAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 02 Sep 2021 06:16:26 +0000
Subject: Re: how to replace a failed drive?
To:     Tomasz Chmielewski <mangoo@wpkg.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <b0bda3d5dba746c48bb264bea8ebc1cc@virtall.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <b3270059-07bc-8a9e-eec0-551ffe98f9fd@suse.com>
Date:   Thu, 2 Sep 2021 09:16:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b0bda3d5dba746c48bb264bea8ebc1cc@virtall.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2.09.21 г. 1:07, Tomasz Chmielewski wrote:
> I'm trying to follow
> https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices#Replacing_failed_devices
> to replace a failed drive. But it seems to be written by a person who
> never attempted to replace a failed drive in btrfs filesystem, and who
> never used mdadm RAID (to see how good RAID experience should look like).
> 
> What I have:
> 
> - RAID-10 over 4 devices (/dev/sd[a-d]2)
> - 1 disk (/dev/sdb2) crashed and was no longer seen by the operating system
> - it was replaced using hot-swapping - new drive registered itself as
> /dev/sde
> - I've partitioned /dev/sde, so that /dev/sde2 matches the size of other
> btrfs devices
> - because I couldn't remove the faulty device (it wouldn't go below my
> current number of devices) I've added the new device to btrfs filesystem:
> 
> btrfs device add /dev/sde2 /data/lxd
> 
> 
> Now, I wonder, how can I remove the disk which crashed?
> 
> # btrfs device delete /dev/sdb2 /data/lxd
> ERROR: not a block device: /dev/sdb2


Actually can you run

btrfs device remove missing /data/lxd ?

> 
> 
> # btrfs device remove /dev/sdb2 /data/lxd
> ERROR: not a block device: /dev/sdb2
> 
> 
> # btrfs filesystem show /data/lxd
> Label: 'lxd5'  uuid: 2b77b498-a644-430b-9dd9-2ad3d381448a
>         Total devices 5 FS bytes used 2.84TiB
>         devid    1 size 1.73TiB used 1.60TiB path /dev/sda2
>         devid    3 size 1.73TiB used 1.60TiB path /dev/sdd2
>         devid    4 size 1.73TiB used 1.60TiB path /dev/sdc2
>         devid    6 size 1.73TiB used 0.00B path /dev/sde2
>         *** Some devices missing
> 
> 
> And, a gem:
> 
> # btrfs device delete missing /data/lxd
> ERROR: error removing device 'missing': no missing devices found to remove
> 
> 
> So according to "btrfs filesystem show /data/lxd" device is missing, but
> according to "btrfs device delete missing /data/lxd" - no device is
> missing. So confusing!
> 
> 
> At this point, btrfs keeps producing massive amounts of logs -
> gigabytes, like:
> 
> [39894585.659909] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr
> 60298373, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.660096] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr
> 60298374, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.660288] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr
> 60298375, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.660478] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr
> 60298376, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.660667] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr
> 60298377, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.660861] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr
> 60298378, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.661105] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr
> 60298379, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.661298] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr
> 60298380, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.747082] BTRFS warning (device sda2): lost page write due to IO
> error on /dev/sdb2
> [39894585.747214] BTRFS error (device sda2): error writing primary super
> block to device 5
> 
> 
> 
> This is REALLY, REALLY very bad RAID experience.
> 
> How to recover at this point?
> 
> 
> Tomasz Chmielewski
> 
