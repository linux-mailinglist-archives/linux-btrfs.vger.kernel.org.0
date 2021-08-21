Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B773F3CBF
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Aug 2021 01:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhHUX0b convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 21 Aug 2021 19:26:31 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:39366 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhHUX0b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Aug 2021 19:26:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 10D763F5BC
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Aug 2021 01:25:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -0.001
X-Spam-Level: 
X-Spam-Status: No, score=-0.001 tagged_above=-999 required=6.31
        tests=[BAYES_20=-0.001] autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9XqfbaudwykB for <linux-btrfs@vger.kernel.org>;
        Sun, 22 Aug 2021 01:25:49 +0200 (CEST)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 18C4C3F57C
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Aug 2021 01:25:48 +0200 (CEST)
Received: from [192.168.0.126] (port=38974)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1mHaN2-000MGZ-E0
        for linux-btrfs@vger.kernel.org; Sun, 22 Aug 2021 01:25:48 +0200
Date:   Sun, 22 Aug 2021 01:25:48 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <afa2742.c084f5d6.17b6b08dffc@tnonline.net>
Subject: Support for compressed inline extents
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'd like to see the option to allow compressed extents to be inlined. It could greatly reduce disk usage and speed up small files by avoiding extra seeks.

I tried to understand why we don't allow it but could only find this reference  https://btrfs.wiki.kernel.org/index.php/On-disk_Format#EXTENT_DATA_.286c.29

"the extent is inline, the remaining item bytes are the data bytes (n bytes in case no compression/encryption/other encoding is used)." 

Is the limitation in the disk format or perhaps in the compression heuristics?

Not all use cases would benefit, and we'd have more metadata, which increase the risk of enospc. But i think it could be very valuable nonetheless. For example mail servers, source code/CI, webservers, and others that commonly deal with many small but highly compressible files. 


I did a quick test by copying all files smaller than 8192 bytes from my home server. The filesystem has 90GiB used. 

The result was 357129 files, 207605 inline. 792MiB disk usage, 1.0GiB data size, or 1.1% of fs usage. 

Zstd compressed them, which gave 295419 files inline. Total data size 500MiB. The size of the inlined files is 208MiB. 

Uncompressed the inlined files to see how much of the original data could have been compressed and inlined. 599MiB total data with 501MiB disk usage and 207576 inlined files. 

All in all we would save 501-208=293MiB, which is very good. Ontop of this we'd have savings because we avoid padding up to 4kiB block size due to inlining. Also my test only included files less than 8kiB. It is possible that many files larger than this could be compressed to less than max_inline size. 


Thanks
