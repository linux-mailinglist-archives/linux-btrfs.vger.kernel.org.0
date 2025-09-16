Return-Path: <linux-btrfs+bounces-16863-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D0DB598E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 16:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790B11BC1513
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 14:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3EE32ED36;
	Tue, 16 Sep 2025 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3nhuz8Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26892368094
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031212; cv=none; b=UkBAiWPQy1Y7CUd92V+GSSZoKvpQb5TsBNQaiX2u5b5SZ5VhwCfrlW6ZtU0coSvhCZtQBHMJClM8ucb8yPOQsvK/A5w2YRtrLSjwXnM6RcEbiUwdUfVWF81zJyfb5EMxGSAd5I6FzFd9JRURSpLB90v3A07QZf8hu1685GAWrk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031212; c=relaxed/simple;
	bh=QCGFM/cnMeWMX3htX5p6eryZx4ChTW6raUZie6Xkq4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sd+3eLIcAZBB5UHAGPjUKxNo2FTAkBaE6NTsoJ8QrPPo8sLrrxq5iSi71QjFATFT5Bq7WqlnlAzue8MTMfocjoOrDr2wOcW5Cl7xMiazwpx0M1sm/trX0Gl7wec3f/oz2Ef3qK9tIuvtUKHRIXoubuUhG2HE9N6oeBEYRE9t5o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3nhuz8Z; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso55140135e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 07:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031208; x=1758636008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3p/HZf12MlzeyzMfr2O5f/PDaT3y6+eiNIS1WtKNH8=;
        b=L3nhuz8Z9oR2kJSqns3xH/4NNgB63DxIRTaNe5oIxa1VLEVdkRdB/o3wev4JT9FNev
         eYpTXmtMWdeLljSdxJ79OLMkhJkiqrc6h7LHAZW+X5s3QVxcasSgLD7hAUeJrGRLubrB
         rulGsgIDFkzQK+2p9g4U8tVgIq95EgJGWBcjRk5IWOXboTPeJq5Wl8CIcLDDTCttURg+
         Z/kpRYpJML9Zm7dCljBFAix9m7eNOll6G7VSP+j67BxEW1aC/WZ7ZjSMe8UMq+FpcsCJ
         Gpseb7IWms7Lemr8sJ3X2y84OXx4aqfDuLL8yMdr7v3hdlC3zgsgY4glFyVdW2zXXK2M
         b5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031208; x=1758636008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3p/HZf12MlzeyzMfr2O5f/PDaT3y6+eiNIS1WtKNH8=;
        b=ioW2YoiJlJG+lUPDJa2XzRdEBHbMYelvUHb3XEGz31RzZu+qo22UlzDQWv72lHl4BC
         rpgtyAUaMaNiFLb+vBUbjhzH98ZiEdH+je/Cmlds8sSvN/hEEOKVV+44RvIB2jf/PzvY
         J1UyhhImBG+jiyCyjopXz0sYa4qJJm+SBt6hqOl5G5qUR0CrpdBEw+fS/oPognBdsF8S
         XKvZ+wnkm9YHlTrjP+PGw+snDgysQFgHsLO36s9FwNKbfXY3IDxBU/heNCqFWciYFi4i
         G6RNrxKh9uF3cBfZlXkJETQQnVmCiHN3kUsJKzHlIkXWBLgONwvpzxsUip8w5E8gI8nd
         jdyw==
X-Forwarded-Encrypted: i=1; AJvYcCVvE2hxoCHjvtP7xsb/cAR+Xvx34d5zGanTK4DCI5loDz0zIb9o3k9CkEFnjFOk+F2/NI1GkyIR754IvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yww7nvNUZQ2ZFff2QdppHnqQ2FlqtMdL4d/a1VMMCl/Vti2FO4y
	R+sstKpzISkmjtGCjh1rj59Qvw8SCjnOZAUnKNr+OVdAiDqoXpVVNJt/
X-Gm-Gg: ASbGncuxN8hJzm8SI26ymtaX6z3H5AWfgt9WR2izVHgKb6PMQpZBhR1EJUYvJt5rL13
	VCAkAfwI/lXMiRfN10GvSnvxzbhdah+u5rv0fbMbw/a424IzjHQ3ou0qleRCfLbrvT1z0PK5XSE
	LEPJ2nWGeixofq6Wu33Lyf6sWUBImJmts4qapydiqN/tjl8mj9fJSFH2uM7onpnN+l4k0rCcDwl
	F5TYaAgD9vRRvXHOVrBxggK4N7b+yYOTujX2mFArp78+FlpFN2OOHwhwwxPm8nJkzgXB2KFyTkp
	tLUOt+OSBvCFQqUE3R2vaj1ShnAAjtyyhE8FBfTxbdHqpPck8D0P6RrANUmQjCGDKuMvySKlObj
	y0yd87K2Ec4kmxtZ2BURw2JjkTLd9myzqgvc1h6qCwkUgWkhU9wd7DIJAyGY7AbevdyphR/Nc
X-Google-Smtp-Source: AGHT+IG3ojTnTVy1hdNr03FmdV6E3sTeXWaDybJz1f1E1nvEGmI8CA+2Pel84ZsC9/O7zHxZywZmtw==
X-Received: by 2002:a05:600c:5246:b0:459:e025:8c40 with SMTP id 5b1f17b1804b1-45f211c8aa9mr181401305e9.10.1758031208380;
        Tue, 16 Sep 2025 07:00:08 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm16557991f8f.42.2025.09.16.07.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:00:07 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4 12/12] fs: make plain ->i_state access fail to compile
Date: Tue, 16 Sep 2025 15:59:00 +0200
Message-ID: <20250916135900.2170346-13-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916135900.2170346-1-mjguzik@gmail.com>
References: <20250916135900.2170346-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

... to make sure all accesses are properly validated.

Merely renaming the var to __i_state still lets the compiler make the
following suggestion:
error: 'struct inode' has no member named 'i_state'; did you mean '__i_state'?

Unfortunately some people will add the __'s and call it a day.

In order to make it harder to mess up in this way, hide it behind a
struct. The resulting error message should be convincing in terms of
checking what to do:
error: invalid operands to binary & (have 'struct inode_state_flags' and 'int')

Of course people determined to do a plain access can still do it, but
nothing can be done for that case.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 11eef4ef5ace..80c53af7bc5a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -782,6 +782,13 @@ enum inode_state_flags_enum {
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
 #define I_DIRTY_ALL (I_DIRTY | I_DIRTY_TIME)
 
+/*
+ * Use inode_state_read() & friends to access.
+ */
+struct inode_state_flags {
+	enum inode_state_flags_enum __state;
+};
+
 /*
  * Keep mostly read-only and often accessed (especially for
  * the RCU path lookup and 'stat' data) fields at the beginning
@@ -840,7 +847,7 @@ struct inode {
 #endif
 
 	/* Misc */
-	enum inode_state_flags_enum i_state;
+	struct inode_state_flags i_state;
 	/* 32-bit hole */
 	struct rw_semaphore	i_rwsem;
 
@@ -906,19 +913,19 @@ struct inode {
  */
 static inline enum inode_state_flags_enum inode_state_read_once(struct inode *inode)
 {
-	return READ_ONCE(inode->i_state);
+	return READ_ONCE(inode->i_state.__state);
 }
 
 static inline enum inode_state_flags_enum inode_state_read(struct inode *inode)
 {
 	lockdep_assert_held(&inode->i_lock);
-	return inode->i_state;
+	return inode->i_state.__state;
 }
 
 static inline void inode_state_add_raw(struct inode *inode,
 				       enum inode_state_flags_enum addflags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state | addflags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state | addflags);
 }
 
 static inline void inode_state_add(struct inode *inode,
@@ -931,7 +938,7 @@ static inline void inode_state_add(struct inode *inode,
 static inline void inode_state_del_raw(struct inode *inode,
 				       enum inode_state_flags_enum delflags)
 {
-	WRITE_ONCE(inode->i_state, inode->i_state & ~delflags);
+	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state & ~delflags);
 }
 
 static inline void inode_state_del(struct inode *inode,
@@ -944,7 +951,7 @@ static inline void inode_state_del(struct inode *inode,
 static inline void inode_state_set_raw(struct inode *inode,
 				       enum inode_state_flags_enum setflags)
 {
-	WRITE_ONCE(inode->i_state, setflags);
+	WRITE_ONCE(inode->i_state.__state, setflags);
 }
 
 static inline void inode_state_set(struct inode *inode,
-- 
2.43.0


