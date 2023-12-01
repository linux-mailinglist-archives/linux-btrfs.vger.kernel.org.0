Return-Path: <linux-btrfs+bounces-527-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB5080161E
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 23:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968F51F210C0
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 22:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AA8619B1;
	Fri,  1 Dec 2023 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="eXSmI8Ob"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF38128
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 14:12:54 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5d4f71f7e9fso10521277b3.0
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Dec 2023 14:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468773; x=1702073573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJQANW9MIFcPX8D7eKOvMwDwipmxgT+JsIthXMaRo9o=;
        b=eXSmI8ObEOYIHci6CSQDiLPxnG7aJ+lotlVP2RinbrS+D7UbGHrmHbrtAB8YtkVXue
         5mLeELpN/VMc8O7KcwFkJ4S3w5+mHPw8Wm7LwVuoibO6+MAJb4z0Refyefnfh4OfRT55
         JBZJoQse21kAnplCSIPG6CHvMyQpPMS56hqOKGuhN9Pn5A3Tnjvji3Ddvqx6nUd8LTZL
         po4wotH/iqXyDr8BKzkHAp9sXN0NPagDLRvxQnKoJPEnklvek98e8ilXEV/n15rLqgSg
         5FVL3ITwmR8AjrqrBcCadOMgA2ruAH18y5AyiuwLfZcyhKJhY+68lsgV6WClel5fV0U4
         qNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468773; x=1702073573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJQANW9MIFcPX8D7eKOvMwDwipmxgT+JsIthXMaRo9o=;
        b=tYKO/2s3hujZcelK5Su+/SG3bXoLPuozvfHGvkHuAytY3N1Z9OHYYJ/XuFfkJ80zGY
         0MezIic0EsBQvDtyplEogmDP2CWroARqkKjTcLViyFwtI/KLgY/saMbCll2t4c9ark9U
         6b9PM5U2qNiF1l3Ep9SdoW4e5+lP4NO/aicVLgpJeEOxriNGApfCmSy9kB1FnaqZA5tl
         wYppl39t6/h7pCoRZhqCvH7Zx7j3AOQj36DaGQFA8yx62x1iFZmRN0N7uxP+/31uj5eB
         rG7uy46sTJtlyzBf2hspTpVXOWsQWocXfwY3I+89CLDiFXESdseAinxtwp8zax+OPDaP
         gUdA==
X-Gm-Message-State: AOJu0Yw2JjnUtMsDoL67knfe0EWAmODnuLMVUjNJe8XBW+RWU+aRF1k4
	bfdikIMKCW1bY0kUdMhG8Lievu0rGPxZrZs2sI37ag==
X-Google-Smtp-Source: AGHT+IF9G1WFmCesqs2EQp0J9KXdyomJKnzntzpVggcdssX2aaGBN29uWVBdrRVM3IVVaBt+6+rkjw==
X-Received: by 2002:a05:690c:d8f:b0:5ce:aad2:3d6a with SMTP id da15-20020a05690c0d8f00b005ceaad23d6amr267494ywb.14.1701468773395;
        Fri, 01 Dec 2023 14:12:53 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id o188-20020a8173c5000000b005d647048e54sm504048ywc.111.2023.12.01.14.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:53 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 46/46] btrfs: load the inode context before sending writes
Date: Fri,  1 Dec 2023 17:11:43 -0500
Message-ID: <99694dd7249ea1edefcf13b9842447e530fc3f6f.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For send we will read the pages and copy them into our buffer.  Use the
fscrypt_inode_open helper to make sure the key is loaded properly before
trying to read from the inode so the contents are properly decrypted.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/send.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index de77321777f4..3475b4cea09d 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5392,6 +5392,37 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 	return ret;
 }
 
+static int load_fscrypt_context(struct send_ctx *sctx)
+{
+	struct btrfs_root *root = sctx->send_root;
+	struct name_cache_entry *nce;
+	struct inode *dir;
+	int ret;
+
+	if (!IS_ENCRYPTED(sctx->cur_inode))
+		return 0;
+
+	/*
+	 * We're encrypted, we need to load the parent inode in order to make
+	 * sure the encryption context is loaded, we use this after calling
+	 * get_cur_path() so our nce for the current inode should be here.  If
+	 * not handle it, but ASSERT() for developers.
+	 */
+	nce = name_cache_search(sctx, sctx->cur_ino, sctx->cur_inode_gen);
+	if (!nce) {
+		ASSERT(nce);
+		return -EINVAL;
+	}
+
+	dir = btrfs_iget(root->fs_info->sb, nce->parent_ino, root);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	ret = fscrypt_inode_open(dir, sctx->cur_inode);
+	iput(dir);
+	return ret;
+}
+
 /*
  * Read some bytes from the current inode/file and send a write command to
  * user space.
@@ -5415,7 +5446,9 @@ static int send_write(struct send_ctx *sctx, u64 offset, u32 len)
 	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
 	if (ret < 0)
 		goto out;
-
+	ret = load_fscrypt_context(sctx);
+	if (ret < 0)
+		goto out;
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
 	ret = put_file_data(sctx, offset, len);
-- 
2.41.0


