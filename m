Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79EF910E3B0
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Dec 2019 22:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfLAVwV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Dec 2019 16:52:21 -0500
Received: from mail-40135.protonmail.ch ([185.70.40.135]:27486 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfLAVwV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Dec 2019 16:52:21 -0500
Date:   Sun, 01 Dec 2019 21:52:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1575237138;
        bh=frBCC889sO1CflQistjcuJcEXECJxM3IQHEFqnqvcdM=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=tHI6dca0BR8HvYxXhguhrn7xc/nQQzstVZ8kLjIUu9J8vJrUH8ZEZVCo5PotivAFz
         my2c/neYuJr5DF+/CIoK7lYTDZbzYp/pjr9qFABdMyISROcZ92WRmgT3r5LBdgHM8N
         Wp3ocGcj4c2O3UQJx7yXfrCLsmanRi7tJLQZV4Og=
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Fedja Beader <fedja@protonmail.ch>
Reply-To: Fedja Beader <fedja@protonmail.ch>
Subject: btrfs scrub's dmesg log is fairly incomplete (rate-limiting?)
Message-ID: <vUErpfAvw9qUQBdsnjSDPapkhGqQEiGTOQKkj-wi4gVFVTgR-GoTF2UhvaLFuX-IHk7jNXX9D4mOwa7rjXSGJ6wpUZjg4YKO7YCY7Bm5FUU=@protonmail.ch>
Feedback-ID: -L-TZdAWyKm9T9TlpFzSU8fKTYzKLGsXsnnbxE45IGOq-K3Q56ZjHKtfgfHprDH4K4Ol3x8Z6XXNVjs0u_owvA==:Ext:ProtonMail
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

Hello,

I had a broken hard-disk from which ddrescue recovered all but about 1600MB=
 of data. As a result, the copy of it had roughly 50000 uncorrectable error=
s as reported after scrub.

I have saved the dmesg log recorded during this scrub, parsed logical numbe=
rs out of it and finaly used "btrfs inspect-internal logical-resolve" to ob=
tain a list of files.

However, after manually removing or restoring those files, the subsequent r=
un of "btrfs scrub" still produced >45000 uncorrectable errors. Indeed, the=
 reported files that were again obtained with the above method, are damaged=
 (input/output error on cat > /dev/null).

It was suggested that rate-limiting could be the cause of this. I then reco=
mpiled the kernel with the (the, as in 4.9.24 there is only one occurance o=
f it in btrfs_printk) "if (__ratelimit..." conditional commented out, reboo=
ted and disabled dmesg ratelimiting with sysctl kernel.printk_ratelimit=3D0=
. Then again ran scrub.

The result of this scrub was 41000 uncorrectable errors. However, after man=
ually repairing all the problems and re-running scrub, 39000 uncorrectable =
errors still remain.


Is there more rate-limiting going on? If so, how do I disable it?

It was also suggested to me to run btrfs check --check-data-csum, but it se=
ems exceptionally slow (roughly 4 MB/s). Has this been addressed or am I do=
ing something wrong?


kernel 4.9.24
btrfs-progs v4.6.1


With kind regards,
Fedja

