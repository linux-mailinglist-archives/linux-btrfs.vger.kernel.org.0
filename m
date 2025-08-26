Return-Path: <linux-btrfs+bounces-16402-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDE2B36E66
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B01D17A6111
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FA636C078;
	Tue, 26 Aug 2025 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="d+q91+Ln"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E6E369982
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222902; cv=none; b=NkpScByhDoZqAce5nh5Lv8OzilED7qRjVyGEL2KFeLGt8RpVXm0Bye3nwed+NW17pe4/WAVg7s/dMd+tLMCBNG280KkJjWlc8//eI2Xd82q5sTF4f+t+AOoqoW3clfOPvFF+Ok1rx78wJUNT/EL8pAL9qx1seQZW84p2MAQ5uz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222902; c=relaxed/simple;
	bh=x4c2iqAV39w68dzaJaOLDjwZ1CiAhVhup47lgo1+0KA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaKUVVk4CQn/rjFsZ65DIJU/vcLFMmdDNz6LLpKehiPSwOIIlH+HnQSGP+aSpcz/OfW09oeQNjHIg73XAcFLWutHQ3b5+YRT5o2ZWSy/ZHKYCuvQIkjUlcc996dlZpYtaAghgc63hnQBZ3CtlhG4f/wmx7rFEzw03+teNPfQp2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=d+q91+Ln; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e96e3094fd9so699249276.1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222900; x=1756827700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zphqo+knfBd/U7e2ug3JbW5SVnXfGmWeCnfWX3NqVkc=;
        b=d+q91+LnZeCKIF5NP27wS8hZQE7/PoR4R7ofsaefdHGnVzX4/dD1sKQYT3oudmq/nG
         2JLwDYxzIB5l+1yqc+nrTTC85GCEruVOxvDsD7KCunzaoII1Kv5sdQKsM4AM9YzwGuCn
         kxeMnaQrCB1WYInMXpR22ENyNiAmi7jiuuwFgAI5ikmEenVncS4nIjK1+SvOMNtQOtEk
         rMXjcv+pL2+sraPzhCzF/mCjw9A3/sHvRMPVvjLNv02cIbKROWKyNgghLKoV75POgbJ5
         5cNsRz0LjYOHPj5bZmIy7I3FqFUUyAZrIhPh9mZ2poJyxftf9/i1WhqzKoXb4nCepC9D
         N2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222900; x=1756827700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zphqo+knfBd/U7e2ug3JbW5SVnXfGmWeCnfWX3NqVkc=;
        b=UnKvF0WVx1FKpZy/v69i7iCNJaD25iqMKPau5h6w/ZkWJ7oRF2QRjc6F54OSO36HPZ
         H4NXkEz4E52x31G2AjOORUTxIv9JElH6EVrVS5JEq5CLqoarpw5JxrrmPJTthaKnTQOG
         3v9fHvJvxJ+MFXsQGiP6I5dc1RDY5MpX54HE/wZgL2/0ZZMWDdEReN07rVGHtKtMCogD
         bUAR3gcqBef6QmNnSjBMWn34woO6hvajUNAPdfPubHd/1kd3ObV+eYHg/LgxwWqo7mzq
         LDLqbYkbyOsvzHf50lQJcUQu4gob1xZTWjQorEDJsrSXhQYZjClhZ9ftMU3Ik76l3+8r
         EZsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRurR2aObBV12X/zGWYPTTaSnxDWQNSrekxKclnEFaXYrLn8pJJj/CxLQPQ+bCjglyRabxM4PEjY3NRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0VcVfpUcIGzUrhYiK/rWXUIj/eJY1/YNVhSHMU4Du3obY2TE5
	hKK0iY8pH9qQ568fs5MFRcH8N3VX/yzIz+OwbMIOR7zuR1m71AFR73YCxA/V6FIKs/U=
X-Gm-Gg: ASbGnctVEFkPSLiol8JI7JmC6ak8xjllLgNXcydX8YswVvhcTAIXquz0zagT60zJwwV
	sJpB5IolsUNyHLtTreH6xIDe53cW9RerdJozi+8IujswMIJjgbHYwBA+K4f6xsUN9TJuEbP3ymE
	4bP0Oc6Irl+ZAYwYUn+HhK7S6oIBKUMTGmqtH7536oDjpA9rW7afpy+VbTR+r6+rFRlvyD7oneO
	eFTUuDppGH0zHpFacw6WO2MuE0R2ey6CvfCo3uNP126e8WsGi3GtSPbszNo/PfDtHnQnoe8mQ3V
	gLtKI/zg2mvkxmTIgH+uej8+4paWR/h9QKLd6TwweEQWabAwR4YU6H7PHUfn9MQHnGoxGprl+Ew
	bY2ICYPViruyMYht3THsO9PoHt4NbwJl32Px1oOEzG0lkv4Kl8iTmqNcnfRE=
X-Google-Smtp-Source: AGHT+IH6IljKhKMKAzfBvsIF2UqCk9sa/1rQsNeda0irdzGfCJ90MbR5GskvJ+4DVKKxRao85tvYhQ==
X-Received: by 2002:a05:690c:ec8:b0:71e:7ee9:839a with SMTP id 00721157ae682-71fdc2f17e3mr171930987b3.2.1756222899935;
        Tue, 26 Aug 2025 08:41:39 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff17354cdsm25393337b3.20.2025.08.26.08.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:39 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 35/54] fs: stop checking I_FREEING in d_find_alias_rcu
Date: Tue, 26 Aug 2025 11:39:35 -0400
Message-ID: <8077a41a37c9088d3118465ca7817048fac35f90.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of checking for I_FREEING, check the refcount of the inode to
see if it is alive.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/dcache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 60046ae23d51..3f3bd1373d92 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1072,8 +1072,8 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 
 	spin_lock(&inode->i_lock);
 	// ->i_dentry and ->i_rcu are colocated, but the latter won't be
-	// used without having I_FREEING set, which means no aliases left
-	if (likely(!(inode->i_state & I_FREEING) && !hlist_empty(l))) {
+	// used without having an i_count reference, which means no aliases left
+	if (likely(icount_read(inode) && !hlist_empty(l))) {
 		if (S_ISDIR(inode->i_mode)) {
 			de = hlist_entry(l->first, struct dentry, d_u.d_alias);
 		} else {
-- 
2.49.0


