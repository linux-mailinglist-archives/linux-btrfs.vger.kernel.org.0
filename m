Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272A169382A
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Feb 2023 16:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBLPoh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Feb 2023 10:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjBLPog (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Feb 2023 10:44:36 -0500
X-Greylist: delayed 385 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Feb 2023 07:44:04 PST
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBBF1BC9
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Feb 2023 07:44:03 -0800 (PST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4PFBRy2Ttsz1sB89;
        Sun, 12 Feb 2023 16:37:34 +0100 (CET)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.84])
        by mail.m-online.net (Postfix) with ESMTP id 4PFBRy1GrNz1qqlR;
        Sun, 12 Feb 2023 16:37:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan3.mail.m-online.net [192.168.6.84]) (amavisd-new, port 10024)
        with ESMTP id tqU9JEgFWK8R; Sun, 12 Feb 2023 16:37:33 +0100 (CET)
X-Auth-Info: SzxaXsaWkEXLE2YChfRjm79kSZQolyZpw5xMp/lpce2JAYpJDBqJ8f2a8SSDSxi7
Received: from igel.home (aftr-82-135-86-52.dynamic.mnet-online.de [82.135.86.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 12 Feb 2023 16:37:33 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id E47192C17DA; Sun, 12 Feb 2023 16:37:32 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        Sam Winchenbach <swichenbach@tethers.com>
Subject: Re: [PATCH] fs/btrfs: handle data extents, which crosss stripe
 boundaries, correctly
References: <57ad584676de5b72ae422a22dc36922285405291.1672362424.git.wqu@suse.com>
X-Yow:  There's a lot of BIG MONEY in MISERY if you have an AGENT!!
Date:   Sun, 12 Feb 2023 16:37:32 +0100
In-Reply-To: <57ad584676de5b72ae422a22dc36922285405291.1672362424.git.wqu@suse.com>
        (Qu Wenruo's message of "Fri, 30 Dec 2022 09:07:05 +0800")
Message-ID: <87ttzqsxmr.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Dez 30 2022, Qu Wenruo wrote:

> [BUG]
> Since btrfs supports single device RAID0 at mkfs time after btrfs-progs
> v5.14, if we create a single device raid0 btrfs, and created a file
> crossing stripe boundary:
>
>   # mkfs.btrfs -m dup -d raid0 test.img
>   # mount test.img mnt
>   # xfs_io -f -c "pwrite 0 128K" mnt/file
>   # umount mnt
>
> Since btrfs is using 64K as stripe length, above 128K data write is
> definitely going to cross at least one stripe boundary.
>
> Then u-boot would fail to read above 128K file:
>
>  => host bind 0 /home/adam/test.img
>  => ls host 0
>  <   >     131072  Fri Dec 30 00:18:25 2022  file
>  => load host 0 0 file
>  BTRFS: An error occurred while reading file file
>  Failed to load 'file'
>
> [CAUSE]
> Unlike tree blocks read, data extent reads doesn't consider cases in which
> one data extent can cross stripe boundary.
>
> In read_data_extent(), we just call btrfs_map_block() once and read the
> first mapped range.
>
> And if the first mapped range is smaller than the desired range, it
> would return error.
>
> But since even single device btrfs can utilize RAID0 profiles, the first
> mapped range can only be at most 64K for RAID0 profiles, and cause false
> error.
>
> [FIX]
> Just like read_whole_eb(), we should call btrfs_map_block() in a loop
> until we read all data.
>
> Since we're here, also add extra error messages for the following cases:
>
> - btrfs_map_block() failure
>   We already have the error message for it.
>
> - Missing device
>   This should not happen, as we only support single device for now.
>
> - __btrfs_devread() failure
>
> With this bug fixed, btrfs driver of u-boot can properly read the above
> 128K file, and have the correct content:
>
>  => host bind 0 /home/adam/test.img
>  => ls host 0
>  <   >     131072  Fri Dec 30 00:18:25 2022  file
>  => load host 0 0 file
>  131072 bytes read in 0 ms
>  => md5sum 0 0x20000
>  md5 for 00000000 ... 0001ffff ==> d48858312a922db7eb86377f638dbc9f
>  ^^^ Above md5sum also matches.
>
> Reported-by: Sam Winchenbach <swichenbach@tethers.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This breaks btrfs on the HiFive Unmatched.

=> pci enum
PCIE-0: Link up (Gen1-x8, Bus0)
=> nvme scan
=> load nvme 0:2 0x8c000000 /boot/dtb/sifive/hifive-unmatched-a00.dtb
[hangs]

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
