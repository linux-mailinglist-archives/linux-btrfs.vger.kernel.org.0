Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC977CB242
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjJPSWB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjJPSWA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:00 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F8FA7
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:21:59 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7740cedd4baso347848085a.2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480518; x=1698085318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9dqjoMSn+7T+gtB15gD5H7naTL8GFoazbK/o6+nI2Y=;
        b=qU9cgfRiBpyUIiRIPlQyaJ72dz/i1lNTvlKEtXEdnm6/zBrPDJsvg6Gd/jb8Rk3yTL
         0dwGr2LliEpBvNtoch2uCD1T7ItyZrYV3TqTCoAe1yNPbQQ5yjmyO4VkrxPew6zqbRYn
         wO1ba4NOf57E+KskwqmAl9TLTY7QAVpVNkO9jPTzZhBLGF3XzwR/OLd07fFcoG5q5ltJ
         LLiPPE2gFaqN9H7j4gvxhVaCLbwkK3zJS3VAwzjNp6FmG6oNN3AZ80DQBsK/nRV1uhn6
         EcII0+pJUd7TM/6RArfFTYjPpc7Z40iTSirVmsn4/vbt1/OsIzIHEuf0SDwtBU8cZ8Fi
         KQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480518; x=1698085318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9dqjoMSn+7T+gtB15gD5H7naTL8GFoazbK/o6+nI2Y=;
        b=UntAY0JhiRZal8JcImF8JgcoYd0XYW0x1pzlC4Msj7AMNi7Je7urxi3nBuKNsIPHHx
         l31ob7CaiZY0s54SeNeoy3CqNl74fwAyXp/IjydxuZciA7Rj5KkBax7TIxSU2Yo7RZJb
         yzcJs9RRXpBvVnxYxG+3P7bhKwrX58qEqz3qDh+hHHLQfRZsa6/bXHirkADzvMQvbiBI
         ngr+LGxbqkqRD8+Yxt0sI5Uqp6QLPORCSxKJNi6Z2ffCRRBzVYlpmEFxAQLQtyM4jzQG
         9NGUOaxqYrYNHInc4njg0p8AsJkE0mIZW1SfFqOgUEaMCGMgBGY8HB+/1+5GUlfB5jVR
         s5Ig==
X-Gm-Message-State: AOJu0YyhYNBxBV6zDw+BMF5sM2B5VqxmM1hR4VIWj5eQCbFCTYhyk1vl
        cfzU50TPvc58AiRXlfl/k/XPkhYQz3RAQ1naXRRBWw==
X-Google-Smtp-Source: AGHT+IGS84wINT58/lIm8Nr/aBJKF1gDSOpO8vvWpVCKS6EnziGgpgTp7Ecn4mBwd8ewsUN00PdN6A==
X-Received: by 2002:a05:620a:2aea:b0:775:ce5f:95c8 with SMTP id bn42-20020a05620a2aea00b00775ce5f95c8mr37866558qkb.25.1697480518608;
        Mon, 16 Oct 2023 11:21:58 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id a26-20020a05620a125a00b007676f3859fasm3194789qkl.30.2023.10.16.11.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:21:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 02/34] fscrypt: conditionally don't wipe mk secret until the last active user is done
Date:   Mon, 16 Oct 2023 14:21:09 -0400
Message-ID: <ec8bcd516777519ae25c23e66aae79a93e8c7e5e.1697480198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697480198.git.josef@toxicpanda.com>
References: <cover.1697480198.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Previously we were wiping the master key secret when we do
FS_IOC_REMOVE_ENCRYPTION_KEY, and then using the fact that it was
cleared as the mechanism from keeping new users from being setup.  This
works with inode based encryption, as the per-inode key is derived at
setup time, so the secret disappearing doesn't affect any currently open
files from being able to continue working.

However for extent based encryption we do our key derivation at page
writeout and readpage time, which means we need the master key secret to
be available while we still have our file open.

Since the master key lifetime is controlled by a flag, move the clearing
of the secret to the mk_active_users cleanup stage if we have extent
based encryption enabled on this super block.  This counter represents
the actively open files that still exist on the file system, and thus
should still be able to operate normally.  Once the last user is closed
we can clear the secret.  Until then no new users are allowed, and this
allows currently open files to continue to operate until they're closed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/crypto/keyring.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index f34a9b0b9e92..acf5e7b3196d 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -105,6 +105,14 @@ void fscrypt_put_master_key_activeref(struct super_block *sb,
 	WARN_ON_ONCE(mk->mk_present);
 	WARN_ON_ONCE(!list_empty(&mk->mk_decrypted_inodes));
 
+	/* We can't wipe the master key secret until the last activeref is
+	 * dropped on the master key with per-extent encryption since the key
+	 * derivation continues to happen as long as there are active refs.
+	 * Wipe it here now that we're done using it.
+	 */
+	if (sb->s_cop->has_per_extent_encryption)
+		wipe_master_key_secret(&mk->mk_secret);
+
 	for (i = 0; i <= FSCRYPT_MODE_MAX; i++) {
 		fscrypt_destroy_prepared_key(
 				sb, &mk->mk_direct_keys[i]);
@@ -129,7 +137,15 @@ static void fscrypt_initiate_key_removal(struct super_block *sb,
 					 struct fscrypt_master_key *mk)
 {
 	WRITE_ONCE(mk->mk_present, false);
-	wipe_master_key_secret(&mk->mk_secret);
+
+	/*
+	 * Per-extent encryption requires the master key to stick around until
+	 * writeout has completed as we derive the per-extent keys at writeout
+	 * time.  Once the activeref drops to 0 we'll wipe the master secret
+	 * key.
+	 */
+	if (!sb->s_cop->has_per_extent_encryption)
+		wipe_master_key_secret(&mk->mk_secret);
 	fscrypt_put_master_key_activeref(sb, mk);
 }
 
-- 
2.41.0

