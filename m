Return-Path: <linux-btrfs+bounces-526-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895CE80161C
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 23:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60931C21024
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 22:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32726709F;
	Fri,  1 Dec 2023 22:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xlYeo6ze"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410ED10D0
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 14:12:52 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5d3c7ef7b31so18905307b3.3
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Dec 2023 14:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468771; x=1702073571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G65+p44mGmrcw3g1ylziU5NRee9dMbEGAa4uRdfp8o0=;
        b=xlYeo6zeg6wvHGuyfMi6+kUoUr36OpIiUzbo6jF4dRRUb612Z0GBkiFqCtsLQ9EsLU
         iSlkXZw9+AkieZ4VIcLIemcf+VIQJWo1plVAJ/U5zQJ4SYliLFe+FGqgGmq6W2O/2onf
         KUdMXBTls6kgKsixpPIuGSSF5TwuiksnlyL9tfRIcyh+5AXEho1wwW6cEyoHKT48LeKj
         kwpdx7fqLnKRA6txVhxcHNYNa2iRNMEgF8awX/ZkXsfg0E42EExcaAUwkMZKqoMM9hFm
         oUlgFpOqsIsdZxl9nrZw4ffAnjNMp6blLZu+kX/Ud2yoo3A4jk5OnasBiAgLet8W66ER
         //tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468771; x=1702073571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G65+p44mGmrcw3g1ylziU5NRee9dMbEGAa4uRdfp8o0=;
        b=c4gLuvqEE4UVNAfNAlivCnbqhY6GxwpkWDjuCMnRC71RyPdichcFv6KHHWDpKo5+mA
         lr5Q0ypNF0d6rYzCcqsLQZeTZ1dABpnX4CnTafNSBO1irxpxKsFntZMCF9UBz4C4/JDY
         99e5pW3HKLTX0dRlZ+XzHPvSoeMzjT/v291t2ydXiRsyxxwxrUxD09/Gjl96Hg0fItK/
         xKtb2bNN6iJaIk5oaxuPlLFDdt2ulxHcMCAKwTTraQNhm+hI5VCB2bXJWMXDcUxvCmSn
         z8LqfLtOoa76Rp0ADarb6UbsDb9n/BUpE7Z75sdU4eJWWJ/4UaAuaVgJc4IpBPNkOowE
         cruQ==
X-Gm-Message-State: AOJu0Yyc0iTSWmzu5L5KMMxM+a0Raq1SWOkbuyoS8EWZKYAMblg1F0LA
	yD9Xqps8wE20aNPQlswjlqC99CbCIW6pztGSIVJQRQ==
X-Google-Smtp-Source: AGHT+IGMXu8ydshCa8rJ4v/ERWlHQ7MaV6TkNFrUdf8axRijnNw6x9bzA6o3POz87QqdoN+lC3Ssrw==
X-Received: by 2002:a05:690c:3381:b0:5d7:1941:356d with SMTP id fl1-20020a05690c338100b005d71941356dmr196783ywb.84.1701468771338;
        Fri, 01 Dec 2023 14:12:51 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id r20-20020a0de814000000b005d39c874019sm1143201ywe.66.2023.12.01.14.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:51 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 44/46] btrfs: deal with encrypted symlinks in send
Date: Fri,  1 Dec 2023 17:11:41 -0500
Message-ID: <4ef9ff7d8238e0ed0995ae4ed65e8de276ebcbd3.1701468306.git.josef@toxicpanda.com>
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

Send needs to send the decrypted value of the symlinks, handle the case
where the inode is encrypted and decrypt the symlink name into a buffer
and copy this buffer into our fs_path struct.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/send.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 3b929f0e8f04..ee5ea16423bb 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1732,9 +1732,8 @@ static int find_extent_clone(struct send_ctx *sctx,
 	return ret;
 }
 
-static int read_symlink(struct btrfs_root *root,
-			u64 ino,
-			struct fs_path *dest)
+static int read_symlink_unencrypted(struct btrfs_root *root, u64 ino,
+				    struct fs_path *dest)
 {
 	int ret;
 	struct btrfs_path *path;
@@ -1800,6 +1799,48 @@ static int read_symlink(struct btrfs_root *root,
 	return ret;
 }
 
+static int read_symlink_encrypted(struct btrfs_root *root, u64 ino,
+				  struct fs_path *dest)
+{
+	DEFINE_DELAYED_CALL(done);
+	const char *buf;
+	struct page *page;
+	struct inode *inode;
+	int ret = 0;
+
+	inode = btrfs_iget(root->fs_info->sb, ino, root);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	page = read_mapping_page(inode->i_mapping, 0, NULL);
+	if (IS_ERR(page)) {
+		ret = PTR_ERR(page);
+		goto out;
+	}
+
+	buf = fscrypt_get_symlink(inode, page_address(page),
+				  BTRFS_MAX_INLINE_DATA_SIZE(root->fs_info),
+				  &done);
+	if (IS_ERR(buf))
+		goto out_page;
+	ret = fs_path_add(dest, buf, strlen(buf));
+out_page:
+	put_page(page);
+	do_delayed_call(&done);
+out:
+	iput(inode);
+	return ret;
+}
+
+
+static int read_symlink(struct btrfs_root *root, u64 ino,
+			struct fs_path *dest)
+{
+	if (btrfs_fs_incompat(root->fs_info, ENCRYPT))
+		return read_symlink_encrypted(root, ino, dest);
+	return read_symlink_unencrypted(root, ino, dest);
+}
+
 /*
  * Helper function to generate a file name that is unique in the root of
  * send_root and parent_root. This is used to generate names for orphan inodes.
-- 
2.41.0


