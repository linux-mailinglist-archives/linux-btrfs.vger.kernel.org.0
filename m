Return-Path: <linux-btrfs+bounces-36-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4270B7E5E37
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 20:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7263A1C20C2A
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 19:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6943437166;
	Wed,  8 Nov 2023 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="bUagwmPJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD7D36B0E
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 19:09:16 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB5B2110
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 11:09:16 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-77891c236fcso591285a.3
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Nov 2023 11:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699470555; x=1700075355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BN/A4uIT6ZK9prEkhxKzpA8qYY+Ll7k4xslWTGCzc38=;
        b=bUagwmPJ7fqwgdhWyv4PGrHiaonCf/KdRoXpaAlfconW6KvIZElaqMJiZ6drLOui0Z
         AeZXIZrG1xpXtKjd2KDB/E4gYcDn1RIdo++VIf7y998Dnyuni1mzk0I7pJ27Vd00zJu+
         t9hZ+yPeKbhkROYDuDvAcVb6JLwoFJobr5XHjpgP05jMkOcSMfJGLYBCjPp8lKePL4am
         Rqeb7QfSVJ7MoQj37aNiCMr0f/lu9y/q6brdPjklvqSHjdF8EIHQqRmzMdBETZcJhpfo
         rvM8d+vSZL5rPHrgEqt/ZAXemn2SNecS9hU0X06c4LqTSDXHqD/pMcIy48kxQ+g0rpz4
         XCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470555; x=1700075355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BN/A4uIT6ZK9prEkhxKzpA8qYY+Ll7k4xslWTGCzc38=;
        b=nXaMDfi+oct2LD+M+ToVdlMGh/RqQ/Hpqw9P0DHG07ib5wyZqUMSyvh0p7OMvyVF1E
         fY9sJ1PwkaeJ+syHbsjlvNwyyQQaUJYAQAGgpp6lpqrcAwGCedF5+gPmVuOihFrxF7XT
         QyexEUjjY3rEKTtEsoOZCpuyi0BjPTCqrHadNI/4PEA7L2PiqEMpvBoLpx3dlBYTdLvc
         CdwpvLQKYUastK60g3uTJ6wqa4sU8SAm5ZyP8AlF7fA92cx/ervToU1LigmuDhLLX0xn
         E2i428bztg2+TYJXqueGeYorFmTwbdG1gQcEd9ao7f6XLllseBbclSwxx5Ms2SvBSL6J
         jmmg==
X-Gm-Message-State: AOJu0YzgZoM/lfgW6EeRSU4vm/ojGC3hTHATu3Afi+NCoYfKTlJZDIbF
	DNL3UUaHM6HmimtzRKsHwaWHA8ygv8yIbri61mXXAw==
X-Google-Smtp-Source: AGHT+IED454ObjuDy+olL7P3HIYGyc0aVS+mpP474dUYZbjzqUrvqTvkwpglJyEKYvm5jikIENuilQ==
X-Received: by 2002:a05:622a:446:b0:419:7e82:9190 with SMTP id o6-20020a05622a044600b004197e829190mr3190599qtx.31.1699470555532;
        Wed, 08 Nov 2023 11:09:15 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v12-20020ac8728c000000b0041cc25a75e5sm1176774qto.77.2023.11.08.11.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:09:15 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 01/18] fs: indicate request originates from old mount api
Date: Wed,  8 Nov 2023 14:08:36 -0500
Message-ID: <c279b1f82085fcecd6c62e63276f0a2c64f00dac.1699470345.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699470345.git.josef@toxicpanda.com>
References: <cover.1699470345.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

We already communicate to filesystems when a remount request comes from
the old mount api as some filesystems choose to implement different
behavior in the new mount api than the old mount api to e.g., take the
chance to fix significant api bugs. Allow the same for regular mount
requests.

Fixes: b330966f79fb ("fuse: reject options on reconfigure via fsconfig(2)")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/namespace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index e157efc54023..bfc5cff0e196 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2873,7 +2873,12 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 	if (IS_ERR(fc))
 		return PTR_ERR(fc);
 
+	/*
+	 * Indicate to the filesystem that the remount request is coming
+	 * from the legacy mount system call.
+	 */
 	fc->oldapi = true;
+
 	err = parse_monolithic_mount_data(fc, data);
 	if (!err) {
 		down_write(&sb->s_umount);
@@ -3322,6 +3327,12 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 	if (IS_ERR(fc))
 		return PTR_ERR(fc);
 
+	/*
+	 * Indicate to the filesystem that the mount request is coming
+	 * from the legacy mount system call.
+	 */
+	fc->oldapi = true;
+
 	if (subtype)
 		err = vfs_parse_fs_string(fc, "subtype",
 					  subtype, strlen(subtype));
-- 
2.41.0


