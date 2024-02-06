Return-Path: <linux-btrfs+bounces-2142-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3893884ACF8
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 04:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5C8EB21B48
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 03:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CF6745C3;
	Tue,  6 Feb 2024 03:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/rAwrD2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6D42CA4
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 03:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707190692; cv=none; b=Z1LSRz1THYDCFnRlGDxDL1TD0xPiZOKzmvR+dzhzhQRroDZ0ZBN0RwcZZkK/WU0Z6uR6urbX+tU1GyYXSZqsHjr2bYi/zLX9mCQxedr2GX+4dqqIEcJi33pW9k60Uq1iVfzSqoPVikUVKNqW3bie8goHzJS4w1Ow3j41+2KwUKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707190692; c=relaxed/simple;
	bh=3VwCrw/Bte9GaRu9iii+KLTMiBP7LS7ahzhN2YL+b1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KL+jCFxOtk8NFgHkliIWbkIkBBcTBYISErFf9Y860FWfW2ouhT9WStt1eEgaRrRX2egOy3RCiIJrlvliBHC7OeZ6GrZ8EbmTkqLx5boi8v5gJkluPFOVXKWS6Qi6qsoF02VAqvnbVNRgoZIxAzZ72gohT9/fndcjvtou9MsAuug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/rAwrD2; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42ab4f89bdbso30148371cf.0
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Feb 2024 19:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707190689; x=1707795489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/pvCCGPvF69Icbx0MLw1xzXyOzHLF4q1+YpudWq1Nw=;
        b=R/rAwrD2d+8N2W+wUR9YENKx/itXTJwi5FnmjEPCE+Y9lk7Wll4Pzsqa1PFKD8gc2g
         yPMHQPRf24TgNKooad5BtudIU9MIRuRLbh9mYVtaoi65exPULeqo+ECFOZ8NfxvYIBTj
         B8nKGKhneis09xYV9dr+zktjkHIKp5xTOj22xD2Bbw5fEka8ETxg1nD/v3EJMJIVXUn3
         79XtVhrgHMqq/8woidP2oly3XBGZdVx5aFOaDenwKqyaCBhp8nPnFQc+pFkyXA3rBSwy
         ZtwDS2rWci0X7cgaYI5MYezyk/sq89gxTebBuEdGwUC3Bm1/i7sAJ7sovz5szlTS9sjk
         qvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707190689; x=1707795489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c/pvCCGPvF69Icbx0MLw1xzXyOzHLF4q1+YpudWq1Nw=;
        b=GUwNsvKwT3YZElb4TjNA8irf5XZbKsq/QWQE2vndnlrO+s8AyP/iCAPYgUSMZfqZF2
         tH4X2Y4FPOoYnN/+5ItRpQA3Z3QH3jbzWR8qZ2tDtu9zP+ZzUBHlm6/q23xCcbj1iYYa
         ZxwZ9JvIpW3e5/EWveDqwsj/PHohWs4S7ac4ajPiUsxpxUVJcdxYqcXvc9Tcl5kcZP1X
         h3arWbdZ7lLEfBdQF1dLcQEmZFPs74SwllyixsZQlmczYD02vGfj3+2wiSuZm27ZzYVT
         zcgpJjNqp2CCWB0a94xKywpB9D0js1A2j0nukTUBSaud4I+H7X4fnJVnRFdtfVyu+qGJ
         JU6Q==
X-Gm-Message-State: AOJu0Yz/ukz18pHeTwKJRWl6GshmAHQQaixNmFeRsHMTGej0ku9J3enP
	TNtP2V+KAIWYKNG5AZGeq5d8Zs1/tG9ImIMgA+Ll/Kf8HE/nsTxOQgb+O+NM
X-Google-Smtp-Source: AGHT+IGeEOrNtF7PO7uvfSmiRwBmhOvae6Qodg+wB+RJ+eTFgm9gF4cxqGucxSnIvsT7tWVjYKnnlg==
X-Received: by 2002:a0c:dc14:0:b0:68c:9023:6319 with SMTP id s20-20020a0cdc14000000b0068c90236319mr1277985qvk.22.1707190689212;
        Mon, 05 Feb 2024 19:38:09 -0800 (PST)
Received: from tachyon.tail92c87.ts.net ([192.159.180.233])
        by smtp.gmail.com with ESMTPSA id lb25-20020a056214319900b0068ca3929a5asm625895qvb.85.2024.02.05.19.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 19:38:08 -0800 (PST)
Sender: Tavian Barnes <tavianator@gmail.com>
From: tavianator@tavianator.com
To: wqu@suse.com
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tree-checker: dump the page status if hit something wrong
Date: Mon,  5 Feb 2024 22:38:07 -0500
Message-ID: <20240206033807.15498-1-tavianator@tavianator.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f51a6d5d7432455a6a858d51b49ecac183e0bbc9.1706312914.git.wqu@suse.com>
References: <f51a6d5d7432455a6a858d51b49ecac183e0bbc9.1706312914.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 27 Jan 2024 10:18:36 +1030, Qu Wenruo wrote:
> [BUG]
> There is a bug report about very suspicious tree-checker got triggered:
>
>   BTRFS critical (device dm-0): corrupted node, root=256
> block=8550954455682405139 owner mismatch, have 11858205567642294356
> expect [256, 18446744073709551360]
>   BTRFS critical (device dm-0): corrupted node, root=256
> block=8550954455682405139 owner mismatch, have 11858205567642294356
> expect [256, 18446744073709551360]
>   BTRFS critical (device dm-0): corrupted node, root=256
> block=8550954455682405139 owner mismatch, have 11858205567642294356
> expect [256, 18446744073709551360]
>   SELinux: inode_doinit_use_xattr:  getxattr returned 117 for dev=dm-0
> ino=5737268

I can reproduce this error.  I applied a modified version of your patch,
against v6.7.2 because that's what I triggered it on.

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 50fdc69fdddf..3f1fc49cd4dc 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -2038,6 +2044,7 @@ int btrfs_check_eb_owner(const struct extent_buffer *eb, u64 root_owner)
        if (!is_subvol) {
                /* For non-subvolume trees, the eb owner should match root owner */
                if (unlikely(root_owner != eb_owner)) {
+                       dump_page(eb->pages[0], "eb page dump");
                        btrfs_crit(eb->fs_info,
 "corrupted %s, root=%llu block=%llu owner mismatch, have %llu expect %llu",
                                btrfs_header_level(eb) == 0 ? "leaf" : "node",
@@ -2053,6 +2060,7 @@ int btrfs_check_eb_owner(const struct extent_buffer *eb, u64 root_owner)
         * to subvolume trees.
         */
        if (unlikely(is_subvol != is_fstree(eb_owner))) {
+               dump_page(eb->pages[0], "eb page dump");
                btrfs_crit(eb->fs_info,
 "corrupted %s, root=%llu block=%llu owner mismatch, have %llu expect [%llu, %llu]",
                        btrfs_header_level(eb) == 0 ? "leaf" : "node",

Here's the corresponding dmesg output:

    page:00000000789c68b4 refcount:4 mapcount:0 mapping:00000000ce99bfc3 index:0x7df93c74 pfn:0x1269558
    memcg:ffff9f20d10df000
    aops:btree_aops [btrfs] ino:1
    flags: 0x12ffff180000820c(referenced|uptodate|workingset|private|node=2|zone=2|lastcpupid=0xffff)
    page_type: 0xffffffff()
    raw: 12ffff180000820c 0000000000000000 dead000000000122 ffff9f118586feb8
    raw: 000000007df93c74 ffff9f2232376e80 00000004ffffffff ffff9f20d10df000
    page dumped because: eb page dump
    BTRFS critical (device dm-1): corrupted leaf, root=709 block=8656838410240 owner mismatch, have 2694891690930195334 expect [256, 18446744073709551360]
    page:000000006b7dfcdc refcount:4 mapcount:0 mapping:00000000ce99bfc3 index:0x8dae804c pfn:0x408347
    memcg:ffff9f20d10df000
    aops:btree_aops [btrfs] ino:1
    flags: 0xaffff180000820c(referenced|uptodate|workingset|private|node=1|zone=2|lastcpupid=0xffff)
    page_type: 0xffffffff()
    raw: 0affff180000820c 0000000000000000 dead000000000122 ffff9f118586feb8
    raw: 000000008dae804c ffff9f1497257d00 00000004ffffffff ffff9f20d10df000
    page dumped because: eb page dump
    BTRFS critical (device dm-1): corrupted leaf, root=518 block=9736288518144 owner mismatch, have 1691386650333431481 expect [256, 18446744073709551360]
    page:00000000fb0df6cd refcount:4 mapcount:0 mapping:00000000ce99bfc3 index:0x7609cbdc pfn:0x129e719
    memcg:ffff9f20d10df000
    aops:btree_aops [btrfs] ino:1
    flags: 0x12ffff180000820c(referenced|uptodate|workingset|private|node=2|zone=2|lastcpupid=0xffff)
    page_type: 0xffffffff()
    raw: 12ffff180000820c 0000000000000000 dead000000000122 ffff9f118586feb8
    raw: 000000007609cbdc ffff9f231de92658 00000004ffffffff ffff9f20d10df000
    page dumped because: eb page dump
    BTRFS critical (device dm-1): corrupted leaf, root=518 block=8111527936000 owner mismatch, have 10652220539197264134 expect [256, 18446744073709551360]

Hope this helps!  Let me know if you have other debug patches to try.

Here's my reproducer if you want to try it yourself.  It uses bfs, a
find(1) clone I wrote with multi-threading and io_uring support.  I'm
in the process of adding multi-threaded stat(), which is what I assume
triggers the bug.

    $ git clone "https://github.com/tavianator/bfs"
    $ cd bfs
    $ git checkout euclean
    $ make release

Then repeat these steps until it triggers:

    # sysctl vm.drop_caches=3
    $ ./bin/bfs /mnt -links 100
    bfs: error: /mnt/slash/@/var/lib/docker/btrfs/subvolumes/f07d37d1c148e9fcdbae166a3a4de36eec49009ce651174d0921fab18d55cee6/dev/ram0: Structure needs cleaning.
    ...

