Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3A04AAEFB
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Feb 2022 12:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbiBFL0a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Feb 2022 06:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiBFL03 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Feb 2022 06:26:29 -0500
X-Greylist: delayed 441 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 03:26:26 PST
Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0D2C06173B
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Feb 2022 03:26:25 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 3E2263F6B5;
        Sun,  6 Feb 2022 12:19:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.911
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id u4AqhxfOFFGF; Sun,  6 Feb 2022 12:18:59 +0100 (CET)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id D68BF3F5EB;
        Sun,  6 Feb 2022 12:18:59 +0100 (CET)
Received: from [192.168.0.20] (port=62014)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1nGfZS-0000Y4-9K; Sun, 06 Feb 2022 12:18:59 +0100
Message-ID: <2fa6e081-cccd-d3aa-456c-f31911a42bdd@tnonline.net>
Date:   Sun, 6 Feb 2022 12:18:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: btrfs RAID1 upgrade
Content-Language: en-GB
To:     =?UTF-8?Q?Max_Splieth=c3=b6ver?= <max@spliethoever.de>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <bfd8a745-3480-70c8-155a-3ee7f5200647@spliethoever.de>
From:   Forza <forza@tnonline.net>
In-Reply-To: <bfd8a745-3480-70c8-155a-3ee7f5200647@spliethoever.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On 2022-02-06 11:23, Max Spliethöver wrote:
> Hey everyone.
> As the available space on my BTRFS RAID1 setup with 2x 4TB drives gets a bit low (a little over 10% left), I plan to upgrade my setup. The current idea is to add a single 8TB drive to the RAID1. The RAID is not used as system drive, but is merely mounted as storage. According to [1], I could simply add the new drive to get 8TB of raw file storage in total, with the data and metadata ratio remaining at 2.0.

Do you mean you want to end up with 1x4TB and 1x8TB? This will only give 
you 4TB usable space in a RAID1 configuration. If you want to add this 
8TB drive as a third drive, then you will have 8TB of usable space in a 
RAID1 configuration.

> 
> Before I do so, I would like to know whether there are any problems with such a three-drive setup or I misunderstood something, and it isn't actually possible to extend the RAID1 in this way.
> 
> Also, I would love to get some feedback on the series of steps I plan to execute to extend the RAID with the 8TB drive:
> 
> 
> 1. Stop all applications depending on the storage.
> 2. Unmount storage device.
> 3. Mount storage device degraded at `/btrfsmount`.
>       ```
>       $ mount -o degraded /dev/sdX /btrfsmount
>       ```
> 4. Add the new drive to the raid.
>       ```
>       $ btrfs device add -f /dev/sdY /btrfsmount
>       ```
> 5. Run a full balance to fully balance the data including the new device.
>       ```shell
>       $ btrfs balance start --full-balance /btrfsmount
>       ```
> 6. Unmount the raid and remount it in non-degraded mode.
> 

Assuming you want to add the drive as a third drive, there is no need to 
unmount the existing mount points, or mount degraded. It can all be done 
live, while your services are running.

Simply do:
$ btrfs device add /dev/sdY1 /mnt/btrfs
$ btrfs balance start -dusage=100 /mnt/btrfs

There is no need to balance metadata.

> 
> Lastly, if there are any other "best practices" one should follow when doing such an extension (apart from backups, of course), please let me know.
> 
> In case it helps, below is the btrfs filesystem usage output:
> $ btrfs filesystem usage /btrfsmount
> Overall:
>       Device size:                   7.28TiB
>       Device allocated:              6.43TiB
>       Device unallocated:          871.98GiB
>       Device missing:                  0.00B
>       Used:                          6.41TiB
>       Free (estimated):            442.47GiB      (min: 442.47GiB)
>       Free (statfs, df):           442.47GiB
>       Data ratio:                       2.00
>       Metadata ratio:                   2.00
>       Global reserve:              512.00MiB      (used: 0.00B)
>       Multiple profiles:                  no
> 
> Data,RAID1: Size:3.21TiB, Used:3.20TiB (99.80%)
>      /dev/sdd1       3.21TiB
>      /dev/sde1       3.21TiB
> 
> Metadata,RAID1: Size:5.00GiB, Used:4.31GiB (86.19%)
>      /dev/sdd1       5.00GiB
>      /dev/sde1       5.00GiB
> 
> System,RAID1: Size:32.00MiB, Used:480.00KiB (1.46%)
>      /dev/sdd1      32.00MiB
>      /dev/sde1      32.00MiB
> 
> Unallocated:
>      /dev/sdd1     435.99GiB
>      /dev/sde1     435.99GiB
> 
> 
> 
> Thank you very much in advance. :)
> 
> 
> -Max
> 
> 
> [1]: https://carfax.org.uk/btrfs-usage/
> 
