Return-Path: <linux-btrfs+bounces-293-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3077F4E13
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 18:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F4928158B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 17:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D80C25772;
	Wed, 22 Nov 2023 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jCGclECB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1F2191
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:04 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5c8c26cf056so56369947b3.1
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700673484; x=1701278284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeAffNckkD9FXOxQ1acHKbqFC9hmQG2oKjxoNh8akn8=;
        b=jCGclECBK5xH4cq+w4vNZXm5AURbvxSpw8wcz9peBAEtSMahDmTAtzsmcXG8gcm151
         Xdjst78hZAl0GIgxs7EwTE8uqQKgH9TNCo58Ttx21VhJwYbRRReRPaow7n5EU0DwDIaB
         EF/MaxYQeJKsLdxSKoC5JwGJT5+zftuI0FgCGdHdrTZiY/NNetb0DgndvOW7c/MLbyHZ
         jDrmgtND7/N+aX6XOcuvRG2sF+UrsrxuudVRAdLFGDFQ+kRBUln6ZpE9A8muOpfdGe0Q
         ARQ1sT/yoi4ROefmFmSHdYVJ8Qibh4lKkIcfZMTpgtkoikNUNRbzIjRhFXvryp1k9UfC
         xyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673484; x=1701278284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeAffNckkD9FXOxQ1acHKbqFC9hmQG2oKjxoNh8akn8=;
        b=oH2b7h3I7ISH1FKIw03vtWm3FZNPGLUbWjMB32TWmepCsHEPzOq+Lv9Cf5/QM9BfG9
         y4ckHCoHETEG9jtltqKcgo0yFpbeEDHGqEf9gpmV/11DlAZ1zFTWGWiU3I3DpD+IHkzS
         R3Z1rjkUUM6hlYPROwv2Ug3CBPMMtKvgyuwKjhEauD+KqQnfwC7pw5NXfF7EinH8VgOa
         TQPh2eq2A3SqV3Y4rbrvbi6YfexMjvWveXdEJutoUC2Tep3tgVsZdse0lVmHZqDU1CJC
         +xzlR4brgkPN3udVm5eA4OCGzy0nx9zLG1XZ6luQWhgTx7m7ON/JmHI4DwQzNPJzgSeF
         4YQw==
X-Gm-Message-State: AOJu0YxKxKzrAA5oDYs0wM+dzQIvtOWjMKFu3ZyISz8tMnicOIekIA8q
	uCy3iaNMYlGPmk68vIHzDSTIQncmgf2tRVfIsTKUTD+u
X-Google-Smtp-Source: AGHT+IEng99RZT2mMcKItvu4HlbSVHqVIY5Lovfq5kXoFcicH5MGY3m+01RKxr34EjR5pXXvqY8zrw==
X-Received: by 2002:a0d:ed05:0:b0:5c8:7708:b86c with SMTP id w5-20020a0ded05000000b005c87708b86cmr2710715ywe.47.1700673483874;
        Wed, 22 Nov 2023 09:18:03 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id cc2-20020a05690c094200b005cb3510c8b2sm1508279ywb.96.2023.11.22.09.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:18:03 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 01/19] fs: indicate request originates from old mount api
Date: Wed, 22 Nov 2023 12:17:37 -0500
Message-ID: <2f5e68f38d45e51cc03c16ad7b94bcb9cfbbd8ab.1700673401.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700673401.git.josef@toxicpanda.com>
References: <cover.1700673401.git.josef@toxicpanda.com>
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
index fbf0e596fcd3..6c39ec020a5f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2875,7 +2875,12 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
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
@@ -3324,6 +3329,12 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
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


