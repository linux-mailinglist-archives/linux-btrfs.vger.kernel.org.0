Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF0467A872
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jan 2023 02:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjAYBgu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Jan 2023 20:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjAYBgt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Jan 2023 20:36:49 -0500
X-Greylist: delayed 965 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Jan 2023 17:36:47 PST
Received: from mail.fsf.org (mail.fsf.org [IPv6:2001:470:142::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BFA4A1DE
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Jan 2023 17:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fsf.org;
        s=mail-fsf-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:references;
         bh=EITsFOQnRidzl62nGQCBtzhSfSaEUV7enXNWNgU0vDk=; b=Vt5i7akMfMCmgQC+NclfH51/f
        O5aCtWc/X+xZVLLvGM2byoyPf6M4im8FGoNBXupSOqkpvR+Jp3p313WUZKm5YSPCaG91f82TxUN48
        AdQG2/CEZ8x50GHj/Nb5CPukiQWVgYqvmgkTbJyOsSFERlNG8N7Q85HFJ6U/ADXVdN0/Qplx4Phi2
        g/SPJTbzOZa/JtrcQCUeTGxUWYaJbdC6vB4LfYeZyugibqlooKQfKVl9TTT+SbzZ2lR7v2qvFcstL
        lkZive+7P9p/bJTh4jHgNqxYoWFFAINS3Z4lGTatsur+ErDqpBfMonW1sYqHyZT7DHJss42p7+TZM
        BwRwAe8Qg==;
User-agent: mu4e 1.9.0; emacs 29.0.50
From:   Ian Kelling <iank@fsf.org>
To:     linux-btrfs@vger.kernel.org
Subject: balance stuck in loop on linux 6.1.7
Date:   Tue, 24 Jan 2023 19:43:24 -0500
Message-ID: <87a6271kbg.fsf@fsf.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Jan 19 11:48:50 frodo kernel: BTRFS info (device dm-13): balance: start -dconvert=raid1c3 -mconvert=raid1c3 -sconvert=raid1c3
...
Jan 22 05:03:23 frodo kernel: BTRFS info (device dm-13): relocating block group 80026774405120 flags data|raid1c3
Jan 22 05:03:48 frodo kernel: BTRFS info (device dm-13): found 41 extents, stage: move data extents
Jan 22 05:03:57 frodo kernel: BTRFS info (device dm-13): found 41 extents, stage: update data pointers
Jan 22 05:04:06 frodo kernel: BTRFS info (device dm-13): relocating block group 80025700663296 flags data|raid1c3
Jan 22 05:04:29 frodo kernel: BTRFS info (device dm-13): found 71 extents, stage: move data extents
Jan 22 05:04:48 frodo kernel: BTRFS info (device dm-13): found 71 extents, stage: update data pointers
Jan 22 05:05:10 frodo kernel: BTRFS info (device dm-13): relocating block group 42827839111168 flags data|raid10
Jan 22 05:05:24 frodo kernel: BTRFS info (device dm-13): found 1 extents, stage: move data extents
Jan 22 05:05:42 frodo kernel: BTRFS info (device dm-13): found 1 extents, stage: update data pointers
Jan 22 05:05:55 frodo kernel: BTRFS info (device dm-13): found 1 extents, stage: update data pointers
Jan 22 05:06:08 frodo kernel: BTRFS info (device dm-13): found 1 extents, stage: update data pointers
Jan 22 05:06:21 frodo kernel: BTRFS info (device dm-13): found 1 extents, stage: update data pointers
Jan 22 05:06:29 frodo kernel: BTRFS info (device dm-13): found 1 extents, stage: update data pointers
...
Jan 24 19:48:19 frodo kernel: BTRFS info (device dm-13): found 1 extents, stage: update data pointers
Jan 24 19:48:35 frodo kernel: BTRFS info (device dm-13): found 1 extents, stage: update data pointers

Since the ..., all the lines have been repeats.

# btrfs balance status /mnt/i
Balance on '/mnt/i' is running
6650 out of about 7480 chunks balanced (6651 considered),  11% left

It has been stuck at 11% for the last 2 days and I assume since the loop
started.

I first experienced this on an earlier kernel so I canceled it and
upgraded to the latest but it is still getting stuck.

# cat /proc/version
Linux version 6.1.7-gnu (rms@mit-oz) (x86_64-linux-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.40) #1.0 SMP PREEMPT_DYNAMIC Tue Sep 27 12:35:59 EST 1983

# btrfs --version
btrfs-progs v6.1.2

If this is a bug, I would like to help the btrfs developers solve it. I
can run whatever commands needed to get more information and try out
patches. But I cannot provide a copy of the filesystem because it has
personal data.

If I restart the balance, it will take about 2.8 days to get back to the
stuck 11% point. The balance is still running, but I'm going to cancel
it morning unless I hear from the list that there is some use to letting
it run since it is wearing out the mechanical drives.

-- 
Ian Kelling | Senior Systems Administrator, Free Software Foundation
GPG Key: B125 F60B 7B28 7FF6 A2B7  DF8F 170A F0E2 9542 95DF
https://fsf.org | https://gnu.org
