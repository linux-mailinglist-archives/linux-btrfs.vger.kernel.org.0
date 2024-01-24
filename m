Return-Path: <linux-btrfs+bounces-1686-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6832C83AF84
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 18:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9500286036
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 17:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650EC81ACB;
	Wed, 24 Jan 2024 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="YAdKCVoh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D947F7F7
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116768; cv=none; b=h6dmdHG16glzXYXF0dmhJ/+UfL+Vng2QFgliDzuGez0scdQCqCr6H7+e2qjACUIFCBkJSacNofCw3OHq9kEnm4047rELeGn3kCiFQBtYuEhTsdk2YhOrIRaY/RsW8H98Be6sAnsOBgW1BkeyUf7N8K1pZ+pTSRUDriUwRF/2qfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116768; c=relaxed/simple;
	bh=fsTRPzPPNtADwe6bMkzvE0XnuvVM4nS8InZWr6g3/kw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adbt/Z94f/Fn+p7GNNaEwCaiSabetI7jUifnKMTMZDqHyGoA0SiCwfKafSqPWQcm9QozrrRCHYDWiTGZGoJ5ZFf4FeZrtEJIBW6rJC+WWQvDIAt4Qm5ohijrUnLb0fD9o3VW/A1YEV2oRQp1v7sTJBndRznC7qtWD8GGN2OkwuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=YAdKCVoh; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5ffcb478512so29554247b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 09:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706116766; x=1706721566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=czRmVICY/IIfuBtDU4yq6xRU3DL72lqTeE0pFRDLv1I=;
        b=YAdKCVohh8p+cHBK2gWx8hNHN8ocDz0TgE4YcI/dEGrHXOkt0Xe+huehEEbJgkjuk/
         cM9nDcbKQ1o+hxODzLGAv8PdINK0duCxxAl1Mz3CeqR3etn0HRpl8S719dfPD+GhqaHp
         IWlZObR0hRCydHyIGMRDZqSyiFTkCofJb3Sb9pPRf+r0B++ltBDeHBDF62xU9ry4Zw97
         j1ev1hBUpJ5QfSJcXwdhyHs6fKO8mceELpQPAwInvHAAKxUSThgK3jGfMDr8w5XhaB4X
         hjkaBZ8jTvR8+i/JTxxTYNX51THk1r541Kc+xLOd+s1BV6FYVyqX/pAqguscVpUlqCQb
         RIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116766; x=1706721566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czRmVICY/IIfuBtDU4yq6xRU3DL72lqTeE0pFRDLv1I=;
        b=aXurbZxklyLZmwZhln4r9bM18KWDPZDXgjRYB+zE/kQ6yw1EqtRXZytjfGcXbXP7a3
         0gdtAkGFVVDfRrHt7VQQT1bkp/R+tu1nm95ngpLxdKumkT60Nd2j0KQg2qZbDvHJnouL
         61FsYvdSsjLz3bmZKfAQbhNbMqul8Q0NGrgyRnS5JwncmbRhGSfWdp23qxf1wXjYQhoL
         3aSJMF9xKJlAkJ2Ax6QU6W1kslSzsTNtqzWInqZe6gqXWvnFEB51J7ahkS9S2pkpHSqp
         OtJRmdRRibedTfbGgjIfQY7qJtxLYYFdojJ7Z9IyP1eaIUm/kfI6000mqMpBpOFloKRO
         vAtQ==
X-Gm-Message-State: AOJu0YzD4IKWrkcBzXKtSA5WGN4EHvB9EEFbXQCRviCMEmZDI8LNM44C
	QCkDU02oX8aZ467jcck8W49/ektECf7QhFAfsXwvEEiHp4gDASfhLXK5OEUCgYXRNGWOWck0wfj
	z
X-Google-Smtp-Source: AGHT+IG2q3uIfW5neemMIBAqY88UPjOUEqnpc2G0Gyg9+doF+gvEIMsSFkHq5TcvedBXp6RkUyxckw==
X-Received: by 2002:a81:ca50:0:b0:602:a429:72d2 with SMTP id y16-20020a81ca50000000b00602a42972d2mr745366ywk.22.1706116765784;
        Wed, 24 Jan 2024 09:19:25 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id cd8-20020a05690c088800b005ffd0571b06sm66013ywb.4.2024.01.24.09.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:19:25 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v5 04/52] fscrypt: conditionally don't wipe mk secret until the last active user is done
Date: Wed, 24 Jan 2024 12:18:26 -0500
Message-ID: <5f28e46ce99d918a16f5bf4d8190870d0fffefc4.1706116485.git.josef@toxicpanda.com>
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
index 0edf0b58daa7..b38b72544453 100644
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
2.43.0


