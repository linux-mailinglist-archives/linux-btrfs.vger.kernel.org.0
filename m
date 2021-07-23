Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA8E3D3C11
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jul 2021 16:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbhGWOOr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jul 2021 10:14:47 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com ([46.30.210.185]:61889
        "EHLO mailrelay4-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235412AbhGWOOq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jul 2021 10:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lithops.se; s=20191106;
        h=content-transfer-encoding:content-type:mime-version:message-id:subject:to:
         from:date:from;
        bh=NUgR8GXbOVQG/csu+Y5eYxxQZxkQLAaRPPA8Nj0ylys=;
        b=WLTL4eU+Gw1VnqyyLuqRkksSc0ZY0c881rRZeti9Aq+0WMlOjxw2byIM0xKDVZg3Vb4ZyQdEwYwr0
         I2S/W0aZoDslYwcp9ZLwnonPG/a9gOu4x73aCrDz/kcWZgg3w6X7eibX4l7HhEVh0drxB7uNCLVeaT
         I+58ogo7G+fPoK/Uo7e9QXwaJM8Z3Tc6BJbG8NNyE6ODanlR1famWF0w7EKI77X2aTZm0eOHGz6ZFi
         9QJh5UkI9rnUJArVbncLdq1TEm0YrnIF7094DXMj2rnBfHnkFkUU6iqZt7bQ6YKH9GZCcyZ+w01nlA
         cL3F53tbc8pq47A7jFmh3h9UzMUCXNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lithops.se; s=rsa1;
        h=content-transfer-encoding:content-type:mime-version:message-id:subject:to:
         from:date:from;
        bh=NUgR8GXbOVQG/csu+Y5eYxxQZxkQLAaRPPA8Nj0ylys=;
        b=Loh54lV80SzUaUAPmA4UXy9gHT7Bn7w4b2UIqaDBGiWHu5oiraUyqzp3VI90ObBsBKj0TZgVJKoMp
         zdA9U66nHswf2WvwSRJs5rb+1LJQlYma9t7JgTq5EAnVzTaNIpRy5ayFKHnDA/b6Tx/RWQsFaPhrIG
         e5j/zXglDzuV7U+q5c0nmAqlugsM2nVMqlMm/RPbtnPCcnKZpgkZ3b086u2AIVlfEpSLoTDtxaYENl
         zn9fEAKpQgkVlT+2IB+ENscMRIjS3lR97MdMFaeq093N+wMBnUtD2O7Ecb4ljFxgmOsIVmGnA/BkSd
         xLQPVxMx/MO+U030jkXXERlWUQLZxGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=lithops.se; s=ed1;
        h=content-transfer-encoding:content-type:mime-version:message-id:subject:to:
         from:date:from;
        bh=NUgR8GXbOVQG/csu+Y5eYxxQZxkQLAaRPPA8Nj0ylys=;
        b=cUl6gPuhVO1gIA9brTZLXvfifaTKPmgeA87Wq1bFShVdixAUqf38wfPZVkCSTG462XxdNjCGRNGan
         ynhoSXLBA==
X-HalOne-Cookie: f73648e50a9151f77b7db6df3903a0b471265c13
X-HalOne-ID: fea1403e-ebc5-11eb-adf8-d0431ea8bb10
Received: from poirot.localdomain (unknown [178.255.113.211])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPA
        id fea1403e-ebc5-11eb-adf8-d0431ea8bb10;
        Fri, 23 Jul 2021 14:55:18 +0000 (UTC)
Date:   Fri, 23 Jul 2021 16:55:17 +0200
From:   Jonas Aaberg <cja@lithops.se>
To:     linux-btrfs@vger.kernel.org
Subject: On the issue of direct I/O and csum warnings
Message-ID: <20210723165517.2614d1b4@poirot.localdomain>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hi,

I use btrfs on dm-crypt. About two months ago, I started to get:

--
BTRFS warning (device dm-0): csum failed root 257 ino 1068852 off
25690112 csum 0xa27faf9a expected csum 0x4c266278 mirror 1 BTRFS error
(device dm-0): bdev /dev/mapper/disk0 errs: wr 0, rd 0, flush 0,
corrupt 349, gen 0
--

kind of warning/errors on my laptop. I went a bought a new NVME disk
because I'm rather found of my data, eventhough most is backup-ed up.

A week later, I started to get the same kind of warning/error message
on my new NVME. After half a day of memtest86, resulted in no memory
errors found, I gave up on my otherwise stable laptop and started to
use an old laptop that I've been to lazy to sell instead while looking
out for a decent pre-owned newer laptop.

Now I'm just about to install and move over to a newly bought laptop,
when today my old laptop started to show the same warning/errors.
My old laptop does not share a single part with the laptop which I
previous got the "checksum failure" warnings on. Therefore I have a hard
time to believe that I've gotten the same hardware failure twice.

Then I found:
<https://btrfs.wiki.kernel.org/index.php/Gotchas> and "Direct I/O and
CRCs".

Which I believe is what I've ran into. One of the affect files is
a log file from syncthing on both computers.

Some people might have been quite pissed off having bought a new
NVME disk and another laptop in vain, but I'm a relieved that I
think I've found the root cause of.
I've used btrfs for about ten years and together with the "btrfs"
tool I find btrfs a very pleasant experience.

I have just one humble request, please do something about this
checksum error message. Just add printk with a link to:
<https://btrfs.wiki.kernel.org/index.php/Gotchas> and the issue of
"Direct I/O and CRCs".

Maybe update the wiki with:
`find <mountpoint> -inum <ino-number-from-warning-message>`
would be a helpful as well.

Thanks.

Best regards,
 Jonas Aaberg
