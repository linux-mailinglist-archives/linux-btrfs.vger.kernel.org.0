Return-Path: <linux-btrfs+bounces-19944-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75183CD3FB9
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 13:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4193B300BBAC
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Dec 2025 12:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA352F7443;
	Sun, 21 Dec 2025 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="fGNZePcB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AEA28A3FA
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Dec 2025 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766318524; cv=none; b=F1W56kxWJvgb55kFiGAVJ41yjqNs76QuODKXGqhftfiNkGgZsjImofSI92m5II2hM+/9hDA6XgN6Evwiuznv8QmqFzSBa/xvFFSuQ2X0UXM7bJQQ+hGniah74kV/3Z6UAZ1M9mTFdMxBiAmxrjkvZea0+wYCAoe50lhg6cQfbM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766318524; c=relaxed/simple;
	bh=M2AiEtwpFL5Bt0BfPeNxPOLws/Pj+JCumAL6243DCSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=REaR2D2ExpuqX7RokCoXK2XvzK0pyahzWqMdo/SW0watPBkulLeRTxwRYjnyjg+ADcYHOzG/di39Vuvywqc6J3n68EL5dIW4caBOr2bOVEicUY3TVEWTosxn5qckKuBz3cRsT8YpzaHXzLib7OuBZ9RsBfg93M5Q+KP8OKgkW0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=fGNZePcB; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7f1243792f2so2162638b3a.1
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Dec 2025 04:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1766318522; x=1766923322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c/iRjByD4MzaTOAdzKo4Fg6NvrM9NFqznEjpAk7mN14=;
        b=fGNZePcB0sDKPrnuzNgF3LgNm2Mr1WsibWKUw2wpTIL+LSor6jrcJA7Uw/yoIvmlwK
         bFfa+Pdsh1W3OWfGS9AsM8hDws6NHr0Rq9+6eSEkFu6PW/+c6aubAHWEatlSdU3TaMTq
         EROlOzDAqyKRwoR56o2UcHgnixim0tMC4q/aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766318522; x=1766923322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/iRjByD4MzaTOAdzKo4Fg6NvrM9NFqznEjpAk7mN14=;
        b=DDzaSfvrB8ko0LRSWPz1QEaKFHWNx/FFo3jd+gyEgvIi3ggVR88weyPqI2qquZWxZk
         aJ++m5w3EIM3ZXQWeaccaXJV2Gu5BZgf9tJRUDjizJ+E98LNtZz9aK46PVudObE8qvNo
         TFs62Xh211aO4OMsugTeiTmuSeTX4rADyRPKNN6iaew6NHolry6JX8I5TfcltfJDpzfR
         poGSBdD44FfLS2zMm0QJ8iZ+KI8z4c0AAMm9EO67nuM/EXp3WLcXcljCVMQOoF2Q80+b
         GpgTFbUKSc2tYOy+p9leXqBmeqah5nCK+jJigHwPD2dCHGqkIrclOLy8vZ8pTP7qiOeS
         gS2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOanJi8J1joWPRPNvnAKMDFxNhlq8JiywPGt44B++DqCA7GaVcwE6XqNdSovnhXR5rWqO+oTsRpacT/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtWQaQ+r80Nin5bV55NbbHFqJori+6Y/3OFkTd2lGqVAyUj2vH
	zbUshDGv7F82tI9B/H9sSzlEwxKBK1ES0MQxcHmOx8Rxt4CVpdoSzjmt8nyeqBIEZPI=
X-Gm-Gg: AY/fxX6WDch5vIEiv1q4xBUfDRbReDbHb+FnP1vylbzxwQ7Rh9QbqyICaZE3H7tPedM
	/OEFIfqnHWZu9QuRtCSn+p3UTT1XA6jL2Tq7V/Tba+gH+qkiKemOY6s0de6Qhvh+de2GGaG3l6T
	Vb8oJjlqIEFk/sXRfRmPfzlGZ+1BWkd/dRA7cJmqTaTuLaA6/YLjRnNtx12BBOFqvXMXXpnplyO
	7rfs0788kHk/JGTuNSg7pZOnqn04DUCfAtcOUo3PT/W26dKg0cbNPcos93/3v5yVMDJ2VH/rdvS
	ycAEpGpPKIzoBYS7BiXr9QgVa0+4N7b8asIVpAVSROYhRdbpWIIlUnzFu88QIofc2UEow14CKO0
	hTGSTN+90kSRVaQLj7M6aSxcbMB0Hc+htlo4DR1tZRx4rIoz3Pr7FWUlDZ7LGT9XzPLxasAGpUT
	z2vvEqiwn3nBOZYB+xjzT5N46NwXF9DrsmduLYJnhz7Z/qxtqujg==
X-Google-Smtp-Source: AGHT+IGB4sJiYzHzP5dWDP6fuxUU7A7UkVkSfOihLi/fm3p8R67y5Lcj/ddzJZe9YwtMLlrkZIkECQ==
X-Received: by 2002:a05:6a00:1f14:b0:7b7:90de:e191 with SMTP id d2e1a72fcca58-7ff654b812amr7349198b3a.23.1766318522530;
        Sun, 21 Dec 2025 04:02:02 -0800 (PST)
Received: from sidong.sidong.yang.office.furiosa.vpn ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7aa32916sm7461719b3a.8.2025.12.21.04.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 04:02:02 -0800 (PST)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: David Sterba <dsterba@suse.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Cc: Sidong Yang <sidong.yang@furiosa.ai>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] btrfs: ioctl: introduce btrfs_uring_import_iovec()
Date: Sun, 21 Dec 2025 12:01:45 +0000
Message-ID: <20251221120146.19131-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces btrfs_uring_import_iovec(). In encoded read/write
with uring cmd, it uses import_iovec without supporting fixed buffer.
btrfs_using_import_iovec() could use fixed buffer if cmd flags has
IORING_URING_CMD_FIXED.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 fs/btrfs/ioctl.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d9e7dd317670..0653e9c7d617 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4722,6 +4722,28 @@ static int btrfs_uring_read_extent(struct kiocb *iocb, struct iov_iter *iter,
 	return ret;
 }
 
+
+static int btrfs_uring_import_iovec(struct io_uring_cmd *cmd,
+				    unsigned int issue_flags, int rw)
+{
+	struct io_btrfs_cmd *bc = io_uring_cmd_to_pdu(cmd, struct io_btrfs_cmd);
+	struct btrfs_uring_encoded_data *data = bc->data;
+	int ret;
+
+	if (cmd->flags & IORING_URING_CMD_FIXED) {
+		data->iov = NULL;
+		ret = io_uring_cmd_import_fixed_vec(cmd, data->args.iov,
+						    data->args.iovcnt, rw,
+						    &data->iter, issue_flags);
+	} else {
+		data->iov = data->iovstack;
+		ret = import_iovec(rw, data->args.iov, data->args.iovcnt,
+				   ARRAY_SIZE(data->iovstack), &data->iov,
+				   &data->iter);
+	}
+	return ret;
+}
+
 static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
 	struct file *file = cmd->file;
@@ -4795,10 +4817,7 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 			goto out_acct;
 		}
 
-		data->iov = data->iovstack;
-		ret = import_iovec(ITER_DEST, data->args.iov, data->args.iovcnt,
-				   ARRAY_SIZE(data->iovstack), &data->iov,
-				   &data->iter);
+		ret = btrfs_uring_import_iovec(cmd, issue_flags, ITER_DEST);
 		if (ret < 0)
 			goto out_acct;
 
@@ -4950,10 +4969,7 @@ static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issu
 		if (data->args.len > data->args.unencoded_len - data->args.unencoded_offset)
 			goto out_acct;
 
-		data->iov = data->iovstack;
-		ret = import_iovec(ITER_SOURCE, data->args.iov, data->args.iovcnt,
-				   ARRAY_SIZE(data->iovstack), &data->iov,
-				   &data->iter);
+		ret = btrfs_uring_import_iovec(cmd, issue_flags, ITER_SOURCE);
 		if (ret < 0)
 			goto out_acct;
 
-- 
2.43.0


