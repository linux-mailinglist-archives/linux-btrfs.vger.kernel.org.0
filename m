Return-Path: <linux-btrfs+bounces-16556-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8123FB3DB8B
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 09:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3205E17BE8F
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 07:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091D22ED84C;
	Mon,  1 Sep 2025 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOem4fm6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024C02080C0
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Sep 2025 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756713299; cv=none; b=S6VAkIf1yXo5C33dkBWZYJ07vYOi6SHlhHYCNCugMTQUIz206fKOncfUoL5PAEYvQ1Q2tnuRrOC9uw0rbDQepZKCFF2N4ZdBLX0IG7jbhdLsxNJEmKqCvf/FcdPHqf1j/AfpoeyN+sZAwHMIKog/6JnyQ9ApQLt6yMZdpMxST+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756713299; c=relaxed/simple;
	bh=QQ2m52eMA2T/rb6eWLQ0Jv5yZGRboSqgJ7dS6xaqD7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=tvmO1WHREf5Cxq4+8wsqJU83W8n/IO8Qm8Lf1+Watc3voeQbLWPbjJkeOoFyMUYoW5Tnv2d/it3MFc/vB/QY41DZLUxdvsgItzUYB36nCqzqLuy5j/7wr7zK2AydyiWc3gDiqyuhdvYtkTZtZaLJoGZeNF8AFvsKB70G/YUF8gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOem4fm6; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-76e2e8d14a5so174815b3a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Sep 2025 00:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756713297; x=1757318097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gc1yeYerXnpStiB629ef++lGWKxb0D28veXkiYo3Ugw=;
        b=eOem4fm6cSAASWuPssBDCPJuKnJWegCrRHKHu5a7OD3+WhR2Ly9ML98OiLzpxjGcVr
         4m3kZ4KDj4+dOvHzfcS9KBZDZuZc2nLvxPiSUZqHR81i5IXasaCoCqE+C+cjrBs8ISIp
         zcwZpbBZn0i21iCTWrKB6YMWumYoyATKkKudBYIwuVyIHdD2QlxsAR2GIeCZp0p/j1c4
         A6wIxZQdvHnjnPZMNQeyi+ZyGsDOM3e7ENVh/dpxNxRFxoscABadusrHTa/LywD3jhhT
         jjGYqAa3A9zDDWhY4I8RO/UQBy5fuZnxEBZ9Q6f7LVqjnm0fxiUi4z0pKvuypPkL1w4S
         QS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756713297; x=1757318097;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gc1yeYerXnpStiB629ef++lGWKxb0D28veXkiYo3Ugw=;
        b=U4gSaOk7yAThFy0WvttKEOUs1BReNjY8Nf3VWgMbF4X6ZEytbZLL/LIAZNG4kBx/H5
         IYm66T3HbmVHUpzG5O2K1CnwMIoepeGSR67CRTwp8YaHoZvi4XevRtnqr9Yr0dxgo+TF
         P4rXVYZv8Z7grlE5Gm11zy7xGCW9WTc712YkuEpqz2y0TzTTrtdf99BpAY7REAtwj0Y7
         WWoAdXr5w4QluIZpz6rAOWVWVEDWhM6rYcTMeKb6Ey9m/BZ8DbFe/vQepll1yP88VTBe
         nw7kCTf478Doj3YKnmCEDjYew1pF2ygrnm5TNGVNY2AYxfxwJ0iFaEPo1zuduidgmUuh
         dFgg==
X-Forwarded-Encrypted: i=1; AJvYcCX8/7m7IX6xZr5na+zV1sqpdnVOqPohllNB0uwcOyRhNBJJTVUj8xnHBNT6ke6o/P7xQgNQLTMEYDVpBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUSxE1KFLc2ZMYucTeN9NiJGj6tF5oseYL/4qreebbiGYv11ay
	ekxSQhCD7u2Fbsx042QI+iMeQOn3fN3Hu9U1eMsmf3BP+4uOVNqZjZJr
X-Gm-Gg: ASbGncvIp4Sx2yJ4useupQWNL6H6SMT2W7mY3P5v1+e9LreRWn8DrFo+j8PhjRokrzh
	Xecig6t5F6bwJxi4411YCdlFLbr/yuvkzk4mHvU5FN/JGbywTi4faL44P7nj7wtIOT0fS5OuWAy
	fQAbEh++2muYlAE4s2ejSo4z8TjIJoLQnlYvAZEHZmTH4+vj6QhTiBKgqJZqaQlwhcl3hY1zbjo
	lRM2bQnWctyn1ZmRxSa7Q1REsu6/3DtjgAw7EbGkKO4D/bx8iRWRxUEpPRDT+MMcu5yWJdhUz5e
	vqigD26l+6Q9P9NCuTnsk5QXxMl4taMHebj8IQWAroRxrhhCG+uUDBA530yO6mQjYsQ/gr2gELr
	4crdYvADBpf1CXz4OQ4lK5zur64UDKgxJxhTmauVfzENm
X-Google-Smtp-Source: AGHT+IF3axmA9B0S3fZbfEMHEjDfyMiPTrkQSz+DzEWHUHSXD+Dm4NU4XmNApiy/S15853H0CXUz7w==
X-Received: by 2002:a05:6a00:844:b0:772:2a74:f532 with SMTP id d2e1a72fcca58-7723295c62amr5348983b3a.5.1756713297094;
        Mon, 01 Sep 2025 00:54:57 -0700 (PDT)
Received: from saltykitkat.localnet ([154.31.112.144])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1ca7sm9766886b3a.71.2025.09.01.00.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 00:54:56 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: quwenruo.btrfs@gmx.com
Cc: sunk67188@gmail.com, dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
Date: Mon, 01 Sep 2025 15:54:50 +0800
Message-ID: <2386271.ElGaqSPkdT@saltykitkat>
In-Reply-To: <5923969.DvuYhMxLoT@saltykitkat>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> My bad.
> 
> I mistakenly removed some cleanup code without converting it to use
> BTRFS_PATH_AUTO_FREE. Thanks a lot for catching this.

Given the number of code lines, it's difficult to identify exactly what was 
missing, so I wrote a Python script to help verify the patch. Hopefully, we 
haven't missed anything this time.

Here are the missing parts:

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index c7f7c55b7c28..d1f5f6c42ef3 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -130,7 +130,7 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, 
struct btrfs_root
                      *item)
 {
        struct btrfs_fs_info *fs_info = root->fs_info;
-       struct btrfs_path *path;
+       BTRFS_PATH_AUTO_FREE(path);
        struct extent_buffer *l;
        int ret;
        int slot;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index b32e2f2e5436..06d45890df85 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1717,7 +1717,7 @@ static noinline int fixup_inode_link_count(struct 
btrfs_trans_handle *trans,
                                           struct btrfs_inode *inode)
 {
        struct btrfs_root *root = inode->root;
-       struct btrfs_path *path;
+       BTRFS_PATH_AUTO_FREE(path);
        int ret;
        u64 nlink = 0;
        const u64 ino = btrfs_ino(inode);





