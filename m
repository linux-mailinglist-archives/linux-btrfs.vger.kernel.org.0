Return-Path: <linux-btrfs+bounces-16378-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DDDB36E2F
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CBC367418
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FF7303C91;
	Tue, 26 Aug 2025 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="q3nfGKKA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DF73568F5
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222870; cv=none; b=UCcA9Nw2EXhVx5Rmlvny+nwZpIPB1hyMX/6MmyJAod/AMaaW9HhaiCVncw99qy8KXdjTgTsrxZoxBjKcPoevb5FKbkSgaNTmbsrmg2j5NvXuWYncHQF2RMpdXZS161jruPQ5Mw7iJOmdvV53NS2sqc4gaSRIzSLTIGYmkjHbbHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222870; c=relaxed/simple;
	bh=nmdvl9jauNYDtI954LQe8Lq2K6dYkRbi47i+ppOrCYk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eh0DtAN6EE9jrUhO8oPbbk1GFziK4EJoBeeasByLbZKw9H6oA+Ea638MoNi4K0iTqppo+PDnxUydSx+km9bslDX2xc6FxMXARLAv4mWIkanU9zBIqi3CdwLTLGULs7Dy/NE8YohFcchx8rEmH8zDr0TZgOqu5jJBlixt5HUL31U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=q3nfGKKA; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d603a9cfaso41261337b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222865; x=1756827665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+H1oFX30E0HNNRPQLcGTuC/g8Ntf7m1XHDxknfLx+E=;
        b=q3nfGKKAZ9sC0To7VQ+4dnl4vSnn5AndB/eo/ehq0nfeX0TA+WPKYtWxQ0K3eE+p/D
         4oGjW5WZeeFKvMwDUcHG/gvFVrp7Guet6BIdjns6yDOnD+OYcDlGXcSbQ9DhJqV4KIcX
         Wfq3xP1lHv8KhQXyVgpl4D2yuaftpcHXRIRAvP5tLyY4lM8//6gyHmmeLZJb3311RtHL
         UyfzooKIO22PCH8q3XUjQ3dT2vehBYGbdiAA5WtK+uqgxbnHnE9bIsqA2tgL3EB4Pl5z
         fER4PX0iAemjmygv0NazK+WZZBcG81qnJt2qlveFpP3k/OhsUvBF5CMDQil4jn0Yt/US
         b8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222865; x=1756827665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+H1oFX30E0HNNRPQLcGTuC/g8Ntf7m1XHDxknfLx+E=;
        b=K0RRf1BiGqLOACW9DfZ+73sVEbcI99xv+I6OfAL1ELizDG8+De2NhhdO1MLumcewl+
         VxFItXiJ5CnWjVpaglGh9WdTjIdiSSVvICVDO+sc+++mo9yQFEzuFglEssNojXd4t8DV
         bQW2acbNiTiHCKaMVEdTyg3TjxYOox6WE/oKvKO/onTBna1F56GUeL0vxt1RlfKhl0DY
         Lc2RG+eQfFSmIZQjzstAXYYRRRyXtvcUqHQGG1Mg3zUZ9g0HkS0kC6ViYnaaZ69EXKQh
         usItShqKvj/dkbQiZUKQxP4kVY0R8Ei0pb/FWI/WPeuKVu4rYpH+xUiRlgGHSbn18zvL
         Expg==
X-Forwarded-Encrypted: i=1; AJvYcCWeCroUFnMFN39H5v5rsAU+dnVk5RW4YHcFRkMEtKC5REMqVoSLeMpzTX7nfKoiIzrG+SwDOknwrNOp2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq/SSHzoEL9tOXh35vHBe1pfhC9OQPId6eQNu9wQYoB3cppvxd
	yR9HNlg32CKItk0X/V6XPKufCeBaE6sh1AHF6394eP7GImZ2yNLP0/blQUS5llpkjHU=
X-Gm-Gg: ASbGncuZmWNEAQltms/L28qqAlD8+VbOmXltAcGPP+NjbVW33Df/3Wu8m1kXfFQ0qeo
	1fTi6gxlxBRYeU+KubnHCUsJcLBYC9S/Qed/8aQnP3h9KSTcNbtIgWjFV02nHNUhW2LgCHdZLdh
	okr7JwDfoHsnR444fkYiAgzxQt/28lCULB0CAtdyGqg7x1mD/huNPaGAj/7eQd4OpDgaskssH72
	NymliJuz08xKyvCbzpqOkBOgx6a697DTTmYQvpM0lecZYNwW5YcQvW8kFifnmQ1qkXB/tOpLqjI
	AAqffhGaR0r2/OIBCiYYtHbar/pdb31ZSkqv/W0W8m5gdzRdynU45xIpv1chV6kOItgqgH/3flo
	vYPlKVGv9BebEzUTrrRJPst4ot9ZnFbaTI6ZTmTQ6lArS2qhfURtHQujm9M4Sb4qjahtP3Q==
X-Google-Smtp-Source: AGHT+IGf/vXHdzIVCUBDcyspP6L3gezeLKadrkozOYbpyFddznFi3iBWOvI6XcY42p18ka0bO6bSFQ==
X-Received: by 2002:a05:690c:680c:b0:71e:7e24:41e1 with SMTP id 00721157ae682-71fdc3db18fmr172652127b3.32.1756222864568;
        Tue, 26 Aug 2025 08:41:04 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18b3794sm25075497b3.63.2025.08.26.08.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:03 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 11/54] fs: hold an i_obj_count reference while on the sb inode list
Date: Tue, 26 Aug 2025 11:39:11 -0400
Message-ID: <f5f18f2d7275128e742ef97c7be13de46e65019d.1756222465.git.josef@toxicpanda.com>
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

We are holding this inode on a sb list, make sure we're holding an
i_obj_count reference while it exists on the list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 0ca0a1725b3c..b146b37f7097 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -630,6 +630,7 @@ void inode_sb_list_add(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
+	iobj_get(inode);
 	spin_lock(&sb->s_inode_list_lock);
 	list_add(&inode->i_sb_list, &sb->s_inodes);
 	spin_unlock(&sb->s_inode_list_lock);
@@ -644,6 +645,7 @@ static inline void inode_sb_list_del(struct inode *inode)
 		spin_lock(&sb->s_inode_list_lock);
 		list_del_init(&inode->i_sb_list);
 		spin_unlock(&sb->s_inode_list_lock);
+		iobj_put(inode);
 	}
 }
 
-- 
2.49.0


