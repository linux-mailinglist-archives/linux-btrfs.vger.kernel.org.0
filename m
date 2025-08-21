Return-Path: <linux-btrfs+bounces-16224-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8406B30680
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49451D02040
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C8638CF88;
	Thu, 21 Aug 2025 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="N+MAJGxJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCD038D7DF
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807652; cv=none; b=PGsNMS/HEa9UkyyMaVcraXIglkDIMu5VGj8N3zwyZxKDhOqh9e/HpjPK+44Y1hnZaqgwoQK3NU6lwoHxMjErUaUFoW9wVj4/YkrkkfLP2giafXU+Oc457mWOlT7XCaNL7/HWapA+iD8c+Uxk+E74JHX7seEQmxIaIylXiOlrD4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807652; c=relaxed/simple;
	bh=sjFh0mGnBKewmEu7ZBywUO603QDbf9VVtuxS1iHS3kk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YO7eA5AW07xkFba9Mk+KvwpFhi0uIgHfaoJgYY7T+SsoSYZ7U4rP6+rts/S8Kt7StIIYtXe5A/+IcXqKhE/1kQHu4OGpmOjEsahoxBBbyX4AnliaILrnG4uPleEP9JWuvU/0bT8BCtwrmlS2HdHs/ylLjNWM+dpycv1PDrPi5OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=N+MAJGxJ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d6014810fso13117917b3.0
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807650; x=1756412450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hjHCUvozywJVec5GzUlQUBVDNE1xIxaP2hRXA4Ep30=;
        b=N+MAJGxJfTVSv5keiL5UKcNhJcQPSc4prVDQwLcPAj1459CD+ebOxUSqLa7tsh/57O
         isB2WPfAyYk7D3u6TWkQMIbx8DaCMzCWxP3z1yafrWJM2ocQOY/hLuDfXHEUgReZUFmF
         2jrtrZht+L0NZnpijNKnIbF+cA2NV4dZab912RaftofRB0mc0QeSqhdMtxU45mux35tu
         xbpsJAQwaYA4gx/hJJF8mMkap3ovm3yonjJsLYh/p3VqOL+VGIc2IiXhlfGCQNKjk2n5
         tEE4nWVMYhK51djz0SNbbBbG1HGIev8fhFNVFCVblb67t2lpmWsoVpkdjxVGOoArOp0M
         z0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807650; x=1756412450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hjHCUvozywJVec5GzUlQUBVDNE1xIxaP2hRXA4Ep30=;
        b=HtidPDHrhcNwNAu0+er7BTdpWk5j+1MTtX/Fo+b5dXc+s7JybNNVpbh1pBNzedGfO3
         3xhZUelxkggyqB6aiRtsFV3m2cpCr86qk9ifaXtYAdnWndn2Nq3G3DfSQ6MT0rjmtHB0
         2X30Ks8X65CVPFC4YRl5Rk59moG3phOEaGL/FvFFFf59nrY8ySDkwGaYk05kQS23pH7s
         VhlYwWmFGm5YIeiVosXZOYO43MetGA7h2pBuLzozat6VzJaac0Y62fHyPNIqB1D1mF92
         QXKY7iTUn7oZUPP3r4k2HEhYWPy6ReoOf+Gx4eKPAuexghAQTwE2HprqyhjoIR06C8xc
         ACqA==
X-Forwarded-Encrypted: i=1; AJvYcCUgijexUkN5sBNeF+JsqbI17xSu9u2yeVhVEmmVV6rwaAXCYx00LvlezgP+IwDpAxOkjkd1svTVKD+RQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxX9daw6C8BxeBDhd31gkgvv2R7HMtfZguiHJRpxvGdQPHYqsZg
	s8CsEsqz7JBRJ0h2ku9gLpEQvI3Qj5fxeD+l2rRYVgbDReQZN9mqjHmPO5ajRdBMJhU=
X-Gm-Gg: ASbGnctZtez3F3MDCineiM8ASBjnCXcbOR6vkiKTh5Kmv5hG7GTmbzeKkVGa8652m6M
	jX5Y9pUgeKt3OyXHbrv0firACM0O4QAUjjWKqKnkmXQA33CSxi+wpfRLlSHdOsuPF7AezBlWn1d
	NmR4N09KQx5QhpZbhJBq1ufK/4j2ShFop6srlYT1ljpwMDJd4ZERGSDX6UgtaHjV7TK+OVpnaCD
	32OGgWa/b9O2Hln0+ptnZvxT2iB7ZUnmfK5R/Q9fx2/wKEvKO2Tv/BvJdseSk4S5vcDLWA3Zbob
	GepaOKk8ZBUIY+QYX3G715B+jxZVRO5GchFO6xeH/DLzyEUy+du/wIrPwcgxxpebQQVmeMNcaB4
	VMolMty9qbQbIjb6+WgpYPbYhd4j2Xn6s3S+e1GlOWdTjS0PYsM5FjLp4jRzU9ZOrUdF6+Q==
X-Google-Smtp-Source: AGHT+IEkPg2uY+pXs4XweETSWm+kP/bcnOO1B2iny2nX044cCwAOn3B/brJlOgYBup4PziSrybkXoA==
X-Received: by 2002:a05:690c:9a03:b0:71f:9e46:835b with SMTP id 00721157ae682-71fdc2b147emr5716127b3.7.1755807650043;
        Thu, 21 Aug 2025 13:20:50 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e05bf0asm46252867b3.54.2025.08.21.13.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:49 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 23/50] fs: update find_inode_*rcu to check the i_count count
Date: Thu, 21 Aug 2025 16:18:34 -0400
Message-ID: <73ac2ba542806f2d43ee4fa444e3032294c9a931.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two helpers are always used under the RCU and don't appear to mind
if the inode state changes in between time of check and time of use.
Update them to use the i_count refcount instead of I_WILL_FREE or
I_FREEING.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 893ac902268b..63ccd32fa221 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1839,7 +1839,7 @@ struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
 
 	hlist_for_each_entry_rcu(inode, head, i_hash) {
 		if (inode->i_sb == sb &&
-		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)) &&
+		    refcount_read(&inode->i_count) > 0 &&
 		    test(inode, data))
 			return inode;
 	}
@@ -1878,8 +1878,8 @@ struct inode *find_inode_by_ino_rcu(struct super_block *sb,
 	hlist_for_each_entry_rcu(inode, head, i_hash) {
 		if (inode->i_ino == ino &&
 		    inode->i_sb == sb &&
-		    !(READ_ONCE(inode->i_state) & (I_FREEING | I_WILL_FREE)))
-		    return inode;
+		    refcount_read(&inode->i_count) > 0)
+			return inode;
 	}
 	return NULL;
 }
-- 
2.49.0


