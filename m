Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65CD66797C
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jul 2019 11:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfGMJWY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Jul 2019 05:22:24 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:34673 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfGMJWY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Jul 2019 05:22:24 -0400
Date:   Sat, 13 Jul 2019 09:22:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1563009741;
        bh=oHqMzhhNBnvM3cse/wSobfL4WH5VV6YqeT06eSmQYnU=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=oKN8ZgEkkqB/kv7mHNBNeUPCmD9AmG1M6VyLyE+8EMXcKIoS8dd27dKTr+YCOYdMZ
         n1FJEOLN4U27J4oloUMJCwhaqxjrj2ZY7EyGlJWHF4iwHT6SO4AnnR+hETDGh+dYD7
         HH9S64BPPYhYVyvS5/f4YhoOBpq0xymGNzNWinJ0=
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   "R. Schwartz" <schwrtz@protonmail.ch>
Reply-To: "R. Schwartz" <schwrtz@protonmail.ch>
Subject: Should nossd mount option be used for an HDD detected as non-rotational?
Message-ID: <htetrjLP1jLMK9WTasfT2e5ZdkY1yV0iY3PHjVEDqCKIZ8d2VwdRTBRezsUAxzKawi_lsxBi5HYfOlvyByGPBwswTCKXSt_lbhRCAmQZ2Qg=@protonmail.ch>
Feedback-ID: bkDgnfjh8MsvyLj2Q6gYH7gJ_xhppUEW_38zMFhjHmQZrcjU44FunpgrBpP4HWGGznCn-ZE7GYZHi1bYU3WRNA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My HDD (one partition, BTRFS) reports itself as non-rational:

    $ cat /sys/class/block/sda/queue/rotational
    0

According to btrfs(5), by default, BTRFS detects this value and turns on
SSD optimizations for the HDD. Naturally, I'm puzzled...

My question is: should I use the nossd mount option for the HDD?

Following is more details about this HDD.

It's a recent Western Digital Blue 2TB HDD, model WD20EZAZ. Given its
cache size is a rather large 256MB, some people say it's likely an SMR
(shingled magnetic record) HDD.

Since Host-Managed and Host-Aware SMR HDDs support the `REPORT_ZONES`
ATA/SCSI command, I ran this test using `sg3_utils`:

    # sg_rep_zones -R /dev/sda
    Report zones command not supported
    sg_rep_zones failed: Illegal request, Invalid opcode

Therefore, _if_ it's SMR, it must be Drive-Managed SMR.

So is there a good reason why the HDD reports itself as non-rotational?
Does it have to do with SMR?

Additioanlly, the HDD is connected through a SATA to USB connector. I
original suspected it was an issue with the connector, but I tested with
other HDDs with the same connector and they all report as rotational.

