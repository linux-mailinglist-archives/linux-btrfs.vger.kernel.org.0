Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AFE4A03D7
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 23:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243110AbiA1Wmq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 28 Jan 2022 17:42:46 -0500
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:54218 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351800AbiA1Wmq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 17:42:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id F2FDA3F490;
        Fri, 28 Jan 2022 23:42:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Y-tAu-_Z3Lju; Fri, 28 Jan 2022 23:42:43 +0100 (CET)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 8B5523F3EA;
        Fri, 28 Jan 2022 23:42:43 +0100 (CET)
Received: from [192.168.0.126] (port=46362)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1nDZx4-0008Vg-GN; Fri, 28 Jan 2022 23:42:42 +0100
Date:   Fri, 28 Jan 2022 23:42:41 +0100 (GMT+01:00)
From:   Forza <forza@tnonline.net>
To:     Remi Gauvin <remi@georgianit.com>,
        Kai Krakow <hurikhan77+btrfs@gmail.com>,
        piorunz <piorunz@gmx.com>,
        linux-btrfs Mailinglist <linux-btrfs@vger.kernel.org>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <a97f0a4.adaf382d.17ea2dae568@tnonline.net>
In-Reply-To: <5e8303e3-64bf-f19a-6d42-e18ae62fd721@georgianit.com>
References: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com> <CAMthOuOg8SVYrehoS4VS=Gj4paYyobmqX85bKzGxYcG-2oJBDA@mail.gmail.com> <5e8303e3-64bf-f19a-6d42-e18ae62fd721@georgianit.com>
Subject: Re: fstab autodegrag with 5.10 & 5.15 kernels, Debian?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Remi Gauvin <remi@georgianit.com> -- Sent: 2022-01-28 - 17:05 ----

> On 2022-01-28 6:55 a.m., Kai Krakow wrote:
> 
>> 
>> Database and VM workloads are not well suited for btrfs-cow. I'd
>> consider using `chattr +C` on the directories storing such data, then
>> backup the contents, purge the directory empty, and restore the
>> contents, thus properly recreating the files in nocow mode. This
>> allows the databases and VMs to write data in-place. You're losing
>> transactional guarantees and checksums but at least for databases,
>> this is probably better left to the database itself anyways.
> 
> This might be critically bad idea combined with BTRFS RAID,, BTRFS does
> not have any means to keeping the Raid mirrors consistent *other* than COW
> 

I agree here. Btrfs default mode is cow and csums to be consistent, crash-safe and protect against bit-rot and other underlying corruptions. It probably is not a good advise to disable these features without clearly explaining the implications. 

The first thing I would do is to actually see if there is a big bottleneck at all, and if there is, look at tuning the application for Btrfs. For example Innodb (MySQL/MariaDB) employs double writes per default. This is unnecessary on Btrfs. With SQLite there is Write Ahead Logging (WAL) mode than should be considered. This is an append log with periodic merging. It is much better suited for Btrfs (*). 

If application tuning isn't enough, I'd look at changing underlying storage; HDD->SSD->Nvme or enabling wider raid modes. I'm hoping that the metadata on SSD patches will make it to mainline soon, as they also improve things a lot.

As a last resort I would go with nodatacow, while understanding the risks. Remember that even if you use snapshots and Btrfs send|receive, you don't get protection from csums, which means silent corruption could get copied to your backups.

With regards from csums in databases. You still need a way to check and verify backups. Not all databases can repair a damaged table without restoring from backups. 

* https://wiki.tnonline.net/w/Blog/SQLite_Performance_on_Btrfs

Thanks


