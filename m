Return-Path: <linux-btrfs+bounces-1690-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7AC83AF87
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5AB81F26C2C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F352982D76;
	Wed, 24 Jan 2024 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="th51FyVG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3708823B6
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116772; cv=none; b=Ar8rwcPnWjQSCQ9w9T1lYWvARAFDbunChAZ20RFnNVWBRk24xnldH04/cZUmjFEEwgkeGmWFO9Bj3IwcAc5TA+E1ZJG3ELzJ9BEo6oG5B5lJ4Bm81s9CObNUGVtTEiCZaM4d6PfaMEAq47fTH6GZjc4KIBLa2+xC3845IFoYOG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116772; c=relaxed/simple;
	bh=1unsrFxzdWyc52oIzARPeb8T+L3Ofl84YwZcEuDqfE4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJwA5JGbagGaQtWdwW+duX5N3f8QVUKH7del+R+q2GAcEeblS0bFwgT+VeQA+10fs+z/7TO9STED3VpG/sO8hw2JD0jxCUZs6Cn9s84UW2tA5U7CcnyPC7EM2SpANBc49K/y2mWmUWv95dddweAS8qK0UF5VKjCd7EECQn0IUeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=th51FyVG; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60036bfdbfeso23999687b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116769; x=1706721569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sW2iDvsXcgI5hN33rhcxkjxObmQ5zKHgm8H4uzuR/g=;
        b=th51FyVGCvpYWj6Ivntw7KX894aV1vraFyaF2vdbRZVJrl/ukCeeUlgT5A85T0a0Cd
         UqweQjHbQroV4qzXEwc9KTL10bx43jCMHx41rBJd1aVRTTKZryCfUoDaSCEYlYCsiKey
         A2S9SImWczl88/Yt7a1taOWFmxe47idJmAkeNMuos8jrUfrVs8RhPC36USeN3EqKpEvC
         mX+4y+BRxeT5Xio0Bw67P1Ghf05zfPV6sQEFAvkLxZmuetdJjJkOgoCYZ4HSZ0n6fq64
         gNM4RMXgiw6UYKx0dXZ4dgNGqleThyoe+1AiONG3UteiBItS7r5aLfxjLr87k6LiJ4NY
         XsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116769; x=1706721569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sW2iDvsXcgI5hN33rhcxkjxObmQ5zKHgm8H4uzuR/g=;
        b=QK/5KMSoZSkTS3u9Z7Gw+ooAqppJBrrdEdDeVx1eSenGaHwC1nhzjgbxNnus4xz6qW
         geEU+M2TLSn6tpl81wybnXaNYQW8M0AQ5uThreXQxgI2WkusXAjg13IbobhxqEdQ/AYw
         KTfq8c4Fd+OtkOnh8EU4Owig+UO79FLNyuPJJJcRxOjIaZ4S+shnlNihmTj3OcVgZZJ8
         wjrcF0n8JLbWC18lOjORBkO36r7q9F3ottQhreJHPTagKGMsdYLUGWIt2sx1qt4CF7gC
         ZNqLIWgSBI+/j4G82I1vvA1LdNb5MBP+bp3i8H33dPaNMEwUJfMEKVSFtMJHTzXC5Ymg
         +8FA==
X-Gm-Message-State: AOJu0Yw/sXeEbQo0zfofwTuxGM95mmG0xZnMJo8xldBv3CgivCaJJL+m
	TEFZ337KjBCXQG8IWY7EMZCeIvBSiPjQtKb6rgPmywOlcZXqJ8bowkvIs290M46pw3PVfXOAT03
	8
X-Google-Smtp-Source: AGHT+IEeFzUDVojL6FW41YhfVqE+xto/neDRrcVM4vDbD+4qMBh2cd4g/z3ssIimIuounyNBec5N3w==
X-Received: by 2002:a0d:e687:0:b0:5ee:7a7d:fd11 with SMTP id p129-20020a0de687000000b005ee7a7dfd11mr1128940ywe.21.1706116769703;
        Wed, 24 Jan 2024 09:19:29 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id a2-20020a818a02000000b005ff7f3a9c0dsm61493ywg.119.2024.01.24.09.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:29 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 08/52] fscrypt: add documentation about extent encryption
Date: Wed, 24 Jan 2024 12:18:30 -0500
Message-ID: <7b2cc4dd423c3930e51b1ef5dd209164ff11c05a.1706116485.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706116485.git.josef@toxicpanda.com>
References: <cover.1706116485.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a couple of sections to the fscrypt documentation about per-extent
encryption.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Documentation/filesystems/fscrypt.rst | 41 +++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index e86b886b64d0..4421c43a3fcd 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -256,6 +256,21 @@ alternative master keys or to support rotating master keys.  Instead,
 the master keys may be wrapped in userspace, e.g. as is done by the
 `fscrypt <https://github.com/google/fscrypt>`_ tool.
 
+Per-extent encryption keys
+--------------------------
+
+For certain file systems, such as btrfs, it's desired to derive a
+per-extent encryption key.  This is to enable features such as snapshots
+and reflink, where you could have different inodes pointing at the same
+extent.  When a new extent is created fscrypt randomly generates a
+16-byte nonce and the file system stores it along side the extent.
+Then, it uses a KDF (as described in `Key derivation function`_) to
+derive the extent's key from the master key and nonce.
+
+Currently the inode's master key and encryption policy must match the
+extent, so you cannot share extents between inodes that were encrypted
+differently.
+
 DIRECT_KEY policies
 -------------------
 
@@ -1395,6 +1410,27 @@ by the kernel and is used as KDF input or as a tweak to cause
 different files to be encrypted differently; see `Per-file encryption
 keys`_ and `DIRECT_KEY policies`_.
 
+Extent encryption context
+-------------------------
+
+The extent encryption context mirrors the important parts of the above
+`Encryption context`_, with a few ommisions.  The struct is defined as
+follows::
+
+        struct fscrypt_extent_context {
+                u8 version;
+                u8 encryption_mode;
+                u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
+                u8 nonce[FSCRYPT_FILE_NONCE_SIZE];
+        };
+
+Currently all fields much match the containing inode's encryption
+context, with the exception of the nonce.
+
+Additionally extent encryption is only supported with
+FSCRYPT_EXTENT_CONTEXT_V2 using the standard policy, all other policies
+are disallowed.
+
 Data path changes
 -----------------
 
@@ -1418,6 +1454,11 @@ buffer.  Some filesystems, such as UBIFS, already use temporary
 buffers regardless of encryption.  Other filesystems, such as ext4 and
 F2FS, have to allocate bounce pages specially for encryption.
 
+Inline encryption is not optional for extent encryption based file
+systems, the amount of objects required to be kept around is too much.
+Inline encryption handles the object lifetime details which results in a
+cleaner implementation.
+
 Filename hashing and encoding
 -----------------------------
 
-- 
2.43.0


