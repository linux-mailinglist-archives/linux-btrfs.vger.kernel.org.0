Return-Path: <linux-btrfs+bounces-19465-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F88C9C5DA
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 18:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3FBD349722
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 17:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246782C029F;
	Tue,  2 Dec 2025 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkrQ3S3r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B284287503
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764695914; cv=none; b=e9qDca2eqRI6OiUAQDU+Coplocl4KLMpua6CHgI5txk9WlPrDX0cfGPSdgCsUU1xwrbAwcN6HExcwlSQ47rPLf+Ft+1Bqpkxln4ymUB4bQCfpmWBVsNX1xm0zg5kXBMqoa5u4DVZGIgGsSl2Zavl8ONQDyQ+QMDN8Lp3KTMLPUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764695914; c=relaxed/simple;
	bh=FNcV+fQ2FJ/6fR1xamE0UqXW+gIsszWN9DiUgsZWmgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJzcY5BPi19/8d9C/cnolMpPDsQ0L2U+7p3/66a6zr4kQYavE5pNSOyOaJ3m1LrUS/stZVn5jZMXzq1FoS2HwD35eVse53XTG0Upq3cnm3lUsg74QcZb3udwyocIgVt5bNKDaIj/ktRRSSEiyhw1Df3AhBl503KqhmhxQYysfy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkrQ3S3r; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-63fc72db706so4744106d50.2
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Dec 2025 09:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764695910; x=1765300710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tb1FFGYQqdLQ0662L1eRve12KQNukjBRWLfM48Fx3Gg=;
        b=WkrQ3S3rT2k9XzBycc0S2014D9T7uBg1YBIMVN/FNMgBMDCrFdtwPkYX8qTAmu5O90
         87hf/N+M4K0vfnvINgg5AKAj7KgA6wu5B7QdfRpZ+a8P8CbMlGB8lvTsApLB1eUdsnbp
         /jtxYRbmlGa4oIzaNiEl+wF/qF3/QvOU7m/Py5Cpxqb/agsI2H1Tu4mVcNals42innp2
         jnyXTPUblHhiAI7mZhq9aibryiNCZlQspNUtM1+ZjreQ3APU5oP3kHWtqvZy+WeQsetR
         VJSSfE17hAqAUXCjki5ckZ0DJc/PUQ8mJ8YvWnHrTZcz4TzfmQvELZORrUuPtU7tHb03
         /L0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764695910; x=1765300710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tb1FFGYQqdLQ0662L1eRve12KQNukjBRWLfM48Fx3Gg=;
        b=MOpLXYZsuAQQD6W956HYTo8yEq7dwYjGkJcKSmRskNUQ0kx+8DQD8+Jt+ZbDnpPcfh
         IXv0SmKUkRkDIH+f9iziQImBkGpuqQE8L5+NEtnne5S6StG/wtxF1rrTIM1ZG5zGpZXD
         c3aKYNgkgFyyhEtw8veFKJwWrg913DoBWY6MdcfZTn5g7CPzcXuxO2TYVh2twG5TpzO9
         p7bkdGmayCHv19GD79kytHANLpfyaDth9Ia9J/tvHy9S4+HZ6Difc+g/zearX67Q/hq5
         jU+OPgeZuT+gfRyxaShW/W2E54whIECkw8qup+DNfQkSSsCyi9eUV2qUbpSuCYBCD5uf
         YEyA==
X-Forwarded-Encrypted: i=1; AJvYcCVgYxdCNJDckvWx2ZpOE//tOZNYGlR9pQv5HoVN+e3P7wlBdd1+3cTIKkGdsKbe7q/rGvM/pj6zbtDDaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy79YI+7ZEXP0XDfChShahdLwAxaUvGwfC+xfNR3Ut55qIGWrRB
	fDcD93m/muSygBUTN0qEhHUMsfb3nljTTbS44NNA7y/YWvUhtiRRgyof
X-Gm-Gg: ASbGncuh0uEUdBJTpOrkbhA52JI/bosX4rkvwN5l0VDlX5yGTWyO2Fy0YOqOdgYsJcU
	WKWvpiIOm9w4fvj1mjijSZnYDIeRAviSLMbTHziVXZqkaDGzgv711KMXJMjBOTA7cmA3emDEIct
	ZRjtDfx9Horx9kf2IQwL0M6W6L4tsHeahQD1z3HelbgcRhKLsG18BWdiWZmXOFPZB4LWCwWDfQg
	cQAcQfz+PPrv46+ijKtT28sW+qYnbCG6Dz0fwwhddwuZK86NTs/f4jswM3A4KP1YzXg1pT1Xjva
	pbv/M5fKtZSyZY2Luzba5WLd9OCUjn0BfN6PLlD2QusOtfOL1q4Bhdc6iP7DOPsTL/NjFh//U7B
	uG/x6SUN9HmO+260EDoAqagHfZKNHBqUcuC0CVyuXyN22Rci5w4uTeZzJ4grb6Hh2gSYEhr3O4H
	3YXfIQedjQmXRcMC6+8w==
X-Google-Smtp-Source: AGHT+IFHcVJzzaagDsHs40VrJpFOzNDss7CJSvNCmGQc5E9CPtHRyOOC64xPABVwREDrLH5tK2gC/g==
X-Received: by 2002:a05:690e:12c9:b0:63f:a856:5f90 with SMTP id 956f58d0204a3-64329212a6cmr21208837d50.4.1764695910441;
        Tue, 02 Dec 2025 09:18:30 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c484722sm6352297d50.23.2025.12.02.09.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 09:18:30 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev,
	lkp@intel.com,
	linux-kernel@vger.kernel.org,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [linus:master] [btrfs]  e8513c012d: addition_on#;use-after-free
Date: Tue,  2 Dec 2025 09:18:24 -0800
Message-ID: <20251202171828.805011-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aS6l5hildWAimd2f@xsang-OptiPlex-9020>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2 Dec 2025 16:40:06 +0800 Oliver Sang <oliver.sang@intel.com> wrote:

> hi, Leo Martins,
> 
> On Mon, Dec 01, 2025 at 04:51:41PM -0800, Leo Martins wrote:
> 
> [...]
> 
> > 
> > Hello,
> > 
> > I believe I have identified the root cause of the warning.
> > However, I'm having some troubles running the reproducer as I
> > haven't setup lkp-tests yet. Could you test the patch below
> > against your reproducer to see if it fixes the issue?
> 
> we confirmed your patch fixed the issues we reported in origial report. thanks!
> 
> Tested-by: kernel test robot <oliver.sang@intel.com>

Thank you, for the help!

> 
> > 
> > ---8<---
> > 
> > [PATCH] btrfs: fix use-after-free in btrfs_get_or_create_delayed_node
> > 
> > Previously, btrfs_get_or_create_delayed_node sets the delayed_node's
> > refcount before acquiring the root->delayed_nodes lock.
> > Commit e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes")
> > moves refcount_set inside the critical section which means
> > there is no longer a memory barrier between setting the refcount and
> > setting btrfs_inode->delayed_node = node.
> > 
> > This allows btrfs_get_or_create_delayed_node to set
> > btrfs_inode->delayed_node before setting the refcount.
> > A different thread is then able to read and increase the refcount
> > of btrfs_inode->delayed_node leading to a refcounting bug and
> > a use-after-free warning.
> > 
> > The fix is to move refcount_set back to where it was to take
> > advantage of the implicit memory barrier provided by lock
> > acquisition.
> > 
> > Fixes: e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202511262228.6dda231e-lkp@intel.com
> > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> > ---
> >  fs/btrfs/delayed-inode.c | 34 ++++++++++++++++++----------------
> >  1 file changed, 18 insertions(+), 16 deletions(-)
> > 
> > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > index 364814642a91..f61f10000e33 100644
> > --- a/fs/btrfs/delayed-inode.c
> > +++ b/fs/btrfs/delayed-inode.c
> > @@ -152,37 +152,39 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
> >  		return ERR_PTR(-ENOMEM);
> >  	btrfs_init_delayed_node(node, root, ino);
> >  
> > +	/* Cached in the inode and can be accessed. */
> > +	refcount_set(&node->refs, 2);
> > +	btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
> > +	btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tracker, GFP_ATOMIC);
> > +
> >  	/* Allocate and reserve the slot, from now it can return a NULL from xa_load(). */
> >  	ret = xa_reserve(&root->delayed_nodes, ino, GFP_NOFS);
> > -	if (ret == -ENOMEM) {
> > -		btrfs_delayed_node_ref_tracker_dir_exit(node);
> > -		kmem_cache_free(delayed_node_cache, node);
> > -		return ERR_PTR(-ENOMEM);
> > -	}
> > +	if (ret == -ENOMEM)
> > +		goto cleanup;
> > +
> >  	xa_lock(&root->delayed_nodes);
> >  	ptr = xa_load(&root->delayed_nodes, ino);
> >  	if (ptr) {
> >  		/* Somebody inserted it, go back and read it. */
> >  		xa_unlock(&root->delayed_nodes);
> > -		btrfs_delayed_node_ref_tracker_dir_exit(node);
> > -		kmem_cache_free(delayed_node_cache, node);
> > -		node = NULL;
> > -		goto again;
> > +		goto cleanup;
> >  	}
> >  	ptr = __xa_store(&root->delayed_nodes, ino, node, GFP_ATOMIC);
> >  	ASSERT(xa_err(ptr) != -EINVAL);
> >  	ASSERT(xa_err(ptr) != -ENOMEM);
> >  	ASSERT(ptr == NULL);
> > -
> > -	/* Cached in the inode and can be accessed. */
> > -	refcount_set(&node->refs, 2);
> > -	btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
> > -	btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tracker, GFP_ATOMIC);
> > -
> > -	btrfs_inode->delayed_node = node;
> > +	WRITE_ONCE(btrfs_inode->delayed_node, node);
> >  	xa_unlock(&root->delayed_nodes);
> >  
> >  	return node;
> > +cleanup:
> > +	btrfs_delayed_node_ref_tracker_free(node, tracker);
> > +	btrfs_delayed_node_ref_tracker_free(node, &node->inode_cache_tracker);
> > +	btrfs_delayed_node_ref_tracker_dir_exit(node);
> > +	kmem_cache_free(delayed_node_cache, node);
> > +	if (ret)
> > +		return ERR_PTR(ret);
> > +	goto again;
> >  }
> >  
> >  /*
> > -- 
> > 2.47.3

