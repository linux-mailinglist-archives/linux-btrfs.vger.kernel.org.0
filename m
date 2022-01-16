Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944C848FBC9
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jan 2022 09:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiAPIsY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jan 2022 03:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiAPIsY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jan 2022 03:48:24 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB37C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 00:48:24 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so18386605pjp.0
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 00:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=2douapQcBw0dTMWjdQYC+iZvVQ7Mrh/bNb2bnZuq+GM=;
        b=C3/bqvGFc5XLawlGwYGB+UkSJwuWDk+utRYDrpRqaOAB+SxgJaxsYhWVoKJtOqNCAP
         yV8dws2KL0FzR1kSnQsLa22741Q0RTs3+zJgP1cR2nAZYd4peFWC7hUKKvNNl2aVI9Nl
         Ips13Mqq+6orFRN6wuOak+saUdGm8x8pGaZl+ZrLGNxW2vaFPWLPezbhO9auXFAbaw7J
         IMdNpq4ZqAiOLIFydDsra/tdG6kXm2tGqcoDiXKudIW8tCZlpgo5guuL0JpAbSaMLZr5
         dk2umD5PzHbPJ56oqoP4mKloOzswm4lKQigIfk13KfQ+dCaRFGJBodKgvS0mh7KhFDXX
         ZybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2douapQcBw0dTMWjdQYC+iZvVQ7Mrh/bNb2bnZuq+GM=;
        b=S9d6QVoQQsgNuPRR0OgUX9fvvR93DCRCzej80Noki36mDdlh0ItjR7kZjOe91f6U5i
         LM0FYhuGIQrswajseVbeVj0I01Z2wGcPLwLOoQ+BDmEIsWCOD03jPXxo/Wq4eEh7iHB1
         zpNUTwV8Noo9cZyMHFXZ1nwhxCBvfSS+ATN0wULzinVFjHd8VK8eqONdUIAOWYm0AQKY
         t10W/uVOPLvdhWqixRz91SA/wY50EC2+SYMDm+LOtAeRD5gs0RfifEHfPPeB6/wMLzlB
         MrgykASaO7VWw24n/buPgYTLL16yH7c/OBe4tdaIzJdnyScKnxlKXvqz+Jy0qbWllxfI
         Hdpg==
X-Gm-Message-State: AOAM532AQ9cAT6j+jBgiDvLzkkPaU51/3PZgkzldN9amhnM64xK32Vtk
        DpyXBk2WYNk3AfA3XAorr/4a344k+eEPyYWJ
X-Google-Smtp-Source: ABdhPJy+vq8KjbEiHIu/h7CoUYryFZqH/GrBSrRHXuNZ6hAO/AuTiPAlyUtJNS7DxG6VxJLxa/AucQ==
X-Received: by 2002:a17:902:7681:b0:149:bb15:c53f with SMTP id m1-20020a170902768100b00149bb15c53fmr17102098pll.159.1642322903212;
        Sun, 16 Jan 2022 00:48:23 -0800 (PST)
Received: from zllke.localdomain ([113.99.5.116])
        by smtp.gmail.com with ESMTPSA id s26sm5479978pgk.28.2022.01.16.00.48.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jan 2022 00:48:22 -0800 (PST)
From:   Li Zhang <zhanglikernel@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     zhanglikernel@gmail.com
Subject: [PATCH 0/5] btrfs: Cleanup BTRFS_INODE_NOCOMPRESS usage and extend 
Date:   Sun, 16 Jan 2022 16:48:17 +0800
Message-Id: <1642322897-1739-1-git-send-email-zhanglikernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[RELATED ISSUES]
https://github.com/btrfs/btrfs-todo/issues/26
https://github.com/kdave/btrfs-progs/issues/329

[QUESION DESCRIBTION]
1. There are two ways to set BTRFS_INODE_NOCOMPRESS, 
one is user command setting, chattr +m <file>, etc., 
indicating that the file does not need to be compressed;
the other is to set this flag by file system heuristic algorithm,
the most common case is after compression The file gets bigger.
We need a flag to distinguish the two cases.

2. If the user runs the command "chattr +c <file>"
and then gets the properties of the file via 
"btrfs property get <file>", the user can know the 
compression type and level of the file, but if the 
user runs "chattr +m <file>" to disable compressing
the file, "btrfs property get <file>" will return an
empty string, the user does not know if the file is
set by the property to not compress.

3. The user can set the compression type and level of
the file through the command
"btrfs property set <file> compression <compression_type>:<compression_level>",
but the compression_level does not seem to take effect.
Because the btrfs_inode structure only contains
the member prop_compress to record the compression type,
not the compression level.

4. There is redundant code in super.c and props.c
to parse the compressed string into a system flag,
so some cleanup is required.

[SOLUTION]
1. Introduce memory-only flag BTRFS_INODE_HEURISTIC_NOCOMPRESS,
which will only remain in memory. This flag should be unset
every time filesystem write to disk.

2. If the flag BTRFS_NOCOMPRESS is set,
insert compression "none" to the file xattr.

3. Extend the btrfs_inode struct member prop_compress
to use the lowest 4 bits to record the compression type and
5 - 8 bits to record the compression level.

4. In both the files super.c and props.c there is a function that converts
the compression description string to system flags(btrfs_parse_options for
super.c, prop_compression_apply for props.c), move it to compress.c,
my options are compress.c except for the compression type and level flags,
no Need to know the other flags about filesystem,
so I left the compress none property and the incompat flag in super.c and props.c.

[TEST PROGRAM]
After I add patch, it use following two way to test wether my patch is correctly
1.For BTRFS_INODE_HEURISTIC_NOCOMPRESS, to be honest,
I tested a lot of data, but I didn't find any data to trigger this flag,
because the condition for setting this flag is that the compressed file
is larger than the original after compression,
but I found that this function shannon_entropy has done the filtering Work.

2. Run chattr +m <file>, get the attributes of <file>, and find that
xattr compression=none.

3. First I test all compression types and compression levels,
I write the file to the btrfs system (print the compression type
and level with btrfs_info to make sure both values are valid), then
use diff <btrfs_file> <original file>, it tells me both file is the same.
Also, I compress the file with the btrfs filesystem version before adding the patch,
and then read it through the patched version,
the file can be read without errors and data corruption.

[TODO]
1. Extend btrfs_inode struct member defrag_compress to record compression type and level.

Li Zhang (5):
    btrfs: Introduce memory-only flag BTRFS_INODE_HEURISTIC_NOCOMPRESS.
    btrfs: Introduce helper functions for compression.
    btrfs: Convert compression description strings into system flags.
    btrfs: Synchronize compression flag BTRFS_INODE_NOCOMPRESS with xattr.
    
 fs/btrfs/compression.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/compression.h | 14 ++++++++++++++
 fs/btrfs/ctree.h       | 13 ++++++++++++-
 fs/btrfs/inode.c       | 27 ++++++++++++++++++---------
 fs/btrfs/ioctl.c       | 36 ++++++++++++++++++++++++++----------
 fs/btrfs/props.c       | 52 ++++++++++++++++++++++++++++++++++++----------------
 fs/btrfs/super.c       | 89 ++++++++++++++++++++++++++++++++++++++---------------------------------------------------
 fs/btrfs/tree-log.c    |  8 ++++++--

Yours sincerely
Li Zhang

