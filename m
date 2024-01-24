Return-Path: <linux-btrfs+bounces-1709-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A27E283AF98
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3801F29920
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92D486AFE;
	Wed, 24 Jan 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xpOhk+Cf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC8486AEB
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116790; cv=none; b=BnyglE3CMV5zs4PXYE23MuYro5jZqfHpkwB0MRSQvVxR5cTcAR+c7huENVPpfsaFa/FHggaVCG+Qx67v9gn6L374NQjEVFYPCEwx5lQBYaQRMiZmUqkz1o0+4HOG46ibZA4OjSpiiLATkJpf2OP1MCkA5VAE7yL5aJjh98uKohI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116790; c=relaxed/simple;
	bh=95Qk5i8acrftXlTC0r7+bzVkmi3Fu2KE62AGDWA7wKE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4oEEN5Trr4FX3xr1y9bMRIQr5jt9SqM7IXlSG7Z/NaGTRcFt05Pz6pduUhRMSDbUVGUVNlUVb5SQreJAKR9t+ElaJKYSJwWU2M/g/GgNYkejvv3vnxQy7gbK/jRY/jMndZpy5SXt6N1Ktve/ItsepDTqgPR/yjZRiINracmotY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xpOhk+Cf; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc239f84ba4so4803048276.3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116788; x=1706721588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jt2GJJZzDgpNmUkvzvr/Jr8FhWJjECt1Wk9RZ4YRcTI=;
        b=xpOhk+Cfn636U/NwNAAb8XSBHBbaBFrdTATBsqwK3CWl8LDnWP4JIlQqEClaxySEW8
         kr5OrymQNRm1fCpjcsc1Lbh/v7IF+Pcs1pm+5Ta9X09QoaturvqhwYz2zDAxs4eMiGC3
         eQyv1SxXMtfEQfV6bcacc2+3z0hBIoHJhJzz5LGkFG9QtgDZt+cd28CFK2/+9R8SXE5o
         /1sBiCKEhgGcFRjLAUc5HrMYhxAHbJsuM3Kd44UE3PnfH7q2EGnj2jd7viii9n2iUyam
         dRgRMLagSKimZ8Jlcl7tcWiiRVVkI9CTxcX4F232lLWBCCa2vuSXEiJlhSHfnsItzp/M
         9cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116788; x=1706721588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jt2GJJZzDgpNmUkvzvr/Jr8FhWJjECt1Wk9RZ4YRcTI=;
        b=RuPOgO+319skiRJ5qe3rsZUxZ9Lg5Q37tZNNa0SuRNqkns03v75zeKlYdoMJW92/MB
         1Hm2H2OJxupyznAIUjYUIzuwiXEDRphfi/ALiboLItf4fFp4A8OU1cTEi4W8NpWFc6JT
         tNubjtmq/h+6DiCbumyyp95cZ6XaJWfcT4hNfWtMt/teCTOv58lrcwl/23SVkm+8ysH4
         zrZvW+CSDW0HrtIB4fELCDACdJj8hgsKJm663OUp7aI+Itwz6/AgQIN3mrifJbQkrx6s
         mASDjr8hPgT7L0VSjtgm+Il6cVbbjh5hlOq9j6yZJpeULh4LXpb280Vp4hP9Hf1kU7Oe
         qPEw==
X-Gm-Message-State: AOJu0YymIjTFuGQ77ykeSMLwqqUYp9tfETFK8Un+7bIHefaiKtkX9eKb
	ESIVNpHtI0ZiPYhOAZXiayqj3fJcTY038xG44jf3IO1Wwau4Ns5TispYdpJaFXlcSCR43mi7qW2
	n
X-Google-Smtp-Source: AGHT+IF7ToRDh9GddqLGCSOWgvnKvOWrNF/gCms7NBD+kqcSzqUNWu/upZ7HhrDJEljVttj6gBXcJg==
X-Received: by 2002:a25:aea5:0:b0:dc2:73f3:2ad9 with SMTP id b37-20020a25aea5000000b00dc273f32ad9mr941183ybj.80.1706116788488;
        Wed, 24 Jan 2024 09:19:48 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id l11-20020a25bccb000000b00dc2366900f9sm2831539ybm.65.2024.01.24.09.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:48 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 27/52] btrfs: keep track of fscrypt info and orig_start for dio reads
Date: Wed, 24 Jan 2024 12:18:49 -0500
Message-ID: <acf3d79bcd72a4447b2993e78d9742fa5a05397f.1706116485.git.josef@toxicpanda.com>
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

We keep track of this information in the ordered extent for writes, but
we need it for reads as well.  Add fscrypt_extent_info and orig_start to
the dio_data so we can populate this on reads.  This will be used later
when we attach the fscrypt context to the bios.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7b3ef349661a..cabcf03fe01f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -83,6 +83,8 @@ struct btrfs_dio_data {
 	ssize_t submitted;
 	struct extent_changeset *data_reserved;
 	struct btrfs_ordered_extent *ordered;
+	struct fscrypt_extent_info *fscrypt_info;
+	u64 orig_start;
 	bool data_space_reserved;
 	bool nocow_done;
 };
@@ -7767,6 +7769,10 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 							       release_len);
 		}
 	} else {
+		dio_data->fscrypt_info =
+			fscrypt_get_extent_info(em->fscrypt_info);
+		dio_data->orig_start = em->orig_start;
+
 		/*
 		 * We need to unlock only the end area that we aren't using.
 		 * The rest is going to be unlocked by the endio routine.
@@ -7848,6 +7854,11 @@ static int btrfs_dio_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 		dio_data->ordered = NULL;
 	}
 
+	if (dio_data->fscrypt_info) {
+		fscrypt_put_extent_info(dio_data->fscrypt_info);
+		dio_data->fscrypt_info = NULL;
+	}
+
 	if (write)
 		extent_changeset_free(dio_data->data_reserved);
 	return ret;
-- 
2.43.0


