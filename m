Return-Path: <linux-btrfs+bounces-19679-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4A7CB77F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 02:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E5FA303750B
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 01:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496261A2C25;
	Fri, 12 Dec 2025 01:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoKEhhR6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F3524728F
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765501312; cv=none; b=r/+Vd4n8rsq6O73+G7RWN3hnkt0X+DVn7cB86rw4eKjaTyckjmPObktnsKH4+cWmf+wBu82H6+8JR8GGXgMQRuPsT0tv5vcKb109VH2r0mD49ensOX9gwYKlnTtF9Ju530wLpjuKDDziNwUIEl+VpLZrScUOjbl29NNTQoLbdJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765501312; c=relaxed/simple;
	bh=a1GMHmFzwwEAx7sboMSplIhv519DmtqIw1OM36bV32w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnmcMiQBAEYk5x5hSKewkHpng1EHnmh+8fkmN8EJOyvRS6ZOdq+V2C2xWriVOjhLbbXoQE9z9CMyiEuK2Qkd9yMsUKpjp+k5niSgPA8bOx8ZpjNL9pp97s2ptWt8N/qteE/HVBeV58PpQ4GSWbOnL11zp8gO6SK8JCHBXl7BybA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoKEhhR6; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-78c696717dbso7375757b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 17:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765501309; x=1766106109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ywo+WU4grpTfsc/fiA3o+f5Obg/vtrUf2iWFZTntu9k=;
        b=PoKEhhR620i0So8UFz0jgF7RcMW2H0ewUFqpWVxg9t9+CKL4OffO6atCB1g8DXrQd0
         K4pss2yH5kxOrpL/yZSCT0tV650w90+Ad+JMXAOXaupYDphqwrP4WfyJBUUb0oGgjcC9
         j4hkMgsPgqOITuY3TH5fwzBj5Dd6Ssfew0m+U6tgaF63zu1rblQHbj0MX8LpiuuumN5S
         jgoxOZ1/tPVn80n8IRciizOJqHYBq5ABrjAOOn9UN84LV0PlQ4/gcpFiWtkP8lL+d8yh
         rJm6OI/Y1Zpmh8RAR3cOYzVhnfZ8Gbs91HsdHUAk3RaiNYdrMrJ5dLX1sBXbkBeEGEr0
         cwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765501309; x=1766106109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ywo+WU4grpTfsc/fiA3o+f5Obg/vtrUf2iWFZTntu9k=;
        b=OsV8Rs85XWDIIpJ+3QZoo/C2PZ+mbTVr8diVAjVCWM9UlLm/Q37tLerseFqQUg7/zZ
         FlM2fzyVJ1+UkeNTevy/jlXnwWGcbv6TJcGcgpzcZ66zSAFHDP9bbZWPyFB3IYqkhGQI
         LULXmVrS66XvnSEPJFC1axa/vrHjKy63t65PCtgZDVoRweTLqcNggfV1CJBoD0PaJqgk
         Y1xCWCGpQDPxkYH4nUjiTFzHbaVfu3A8Sg/tCl/mNeQSkA1hYghQo/LxZf7zQpU0Rzx3
         +tCWSPpqK0Hftes6+jkLO7rYVYSWh1Nx3R3R8flcSjPIQQWMkXCtVfYV//PjzVIEdwN5
         Qybw==
X-Gm-Message-State: AOJu0Yx0cslgR10qkOYYG1HfIq3Ni3gExkEK4XhqVdOAai66/h5OC5uF
	u0B96dgzd0TD5sQSger+GqDynyFidQBAfgfYH5yhqCIxdjCsi3mDbkEm
X-Gm-Gg: AY/fxX5PgzRBt1RDMt+dNLfVf8wSVIcJyMdk/2FzsuFz25T9LMEkn/YIJPopYA3MBgZ
	segQiP7lx4zSF9kBztIj8o2yDRnOYZU8QxyEvZQ7RjVhqezqmiU4AxPw5UA0DVYryz5eIW5jqKe
	DBERWu2ljRb5KQpsVlJQqO+8M+aBktA0nGFV1I/X0gTok5dPDcqStATbgQ0AMjTo6AyoBCVmqk3
	zUmzAXJNn86fSMF8e07fPC6oAh+DAzEAgQ2fm5Tbg+e9lTESazrfrcge4w04sUPfSxpPcaqV2aU
	bvFoyHKabXK503NN8loaz9IZ0+WrflcmpYYjJtWwkCWY/0DA05SkcNvpQB6lWilc1rjTXj+dgNA
	WwfTmAcVzB8ePbfr0RwfZxeL+qpviFMbI5HPh35X+Ih8pLmPflxJNawMhyYI3cHr7eZKAfBpaRJ
	tBlZFph71PvVOIpc5Q/+YoQxzEJiUE
X-Google-Smtp-Source: AGHT+IExRG50AHGEIVgOTfq+taFlV+Kpst4pEoluJ5nM4cJYECo+EAJdvA/dnSkUlryHkrka1XU2qQ==
X-Received: by 2002:a05:690c:6a0a:b0:78c:57c1:70d9 with SMTP id 00721157ae682-78e66e0bf15mr4572607b3.37.1765501309458;
        Thu, 11 Dec 2025 17:01:49 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:46::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78d69da35desm14847987b3.32.2025.12.11.17.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 17:01:49 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2] btrfs: fix use-after-free warning in btrfs_get_or_create_delayed_node
Date: Thu, 11 Dec 2025 17:01:41 -0800
Message-ID: <20251212010145.4002230-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAL3q7H6_9wZeTOti72jpM=6iCCpQa-U5pNyekToEq0AfCfWmqQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 3 Dec 2025 10:50:17 +0000 Filipe Manana <fdmanana@kernel.org> wrote:

> On Tue, Dec 2, 2025 at 9:21 PM Leo Martins <loemra.dev@gmail.com> wrote:
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
> > Tested-by: kernel test robot <oliver.sang@intel.com>
> > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> > ---
> >  fs/btrfs/delayed-inode.c | 32 +++++++++++++++++---------------
> >  1 file changed, 17 insertions(+), 15 deletions(-)
> >
> > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > index 364814642a91..81922556379d 100644
> > --- a/fs/btrfs/delayed-inode.c
> > +++ b/fs/btrfs/delayed-inode.c
> > @@ -152,37 +152,39 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
> >                 return ERR_PTR(-ENOMEM);
> >         btrfs_init_delayed_node(node, root, ino);
> >
> > +       /* Cached in the inode and can be accessed. */
> > +       refcount_set(&node->refs, 2);
> > +       btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
> > +       btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tracker, GFP_ATOMIC);
> 
> Now that we do these allocations outside the spinlock (xarray's lock),
> we can stop using GFP_ATOMIC and use GFP_NOFS.
> 
> Otherwise it looks good, thanks.

Did you want me to send out a v3 for this change?

> 
> > +
> >         /* Allocate and reserve the slot, from now it can return a NULL from xa_load(). */
> >         ret = xa_reserve(&root->delayed_nodes, ino, GFP_NOFS);
> > -       if (ret == -ENOMEM) {
> > -               btrfs_delayed_node_ref_tracker_dir_exit(node);
> > -               kmem_cache_free(delayed_node_cache, node);
> > -               return ERR_PTR(-ENOMEM);
> > -       }
> > +       if (ret == -ENOMEM)
> > +               goto cleanup;
> > +
> >         xa_lock(&root->delayed_nodes);
> >         ptr = xa_load(&root->delayed_nodes, ino);
> >         if (ptr) {
> >                 /* Somebody inserted it, go back and read it. */
> >                 xa_unlock(&root->delayed_nodes);
> > -               btrfs_delayed_node_ref_tracker_dir_exit(node);
> > -               kmem_cache_free(delayed_node_cache, node);
> > -               node = NULL;
> > -               goto again;
> > +               goto cleanup;
> >         }
> >         ptr = __xa_store(&root->delayed_nodes, ino, node, GFP_ATOMIC);
> >         ASSERT(xa_err(ptr) != -EINVAL);
> >         ASSERT(xa_err(ptr) != -ENOMEM);
> >         ASSERT(ptr == NULL);
> > -
> > -       /* Cached in the inode and can be accessed. */
> > -       refcount_set(&node->refs, 2);
> > -       btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
> > -       btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tracker, GFP_ATOMIC);
> > -
> >         btrfs_inode->delayed_node = node;
> >         xa_unlock(&root->delayed_nodes);
> >
> >         return node;
> > +cleanup:
> > +       btrfs_delayed_node_ref_tracker_free(node, tracker);
> > +       btrfs_delayed_node_ref_tracker_free(node, &node->inode_cache_tracker);
> > +       btrfs_delayed_node_ref_tracker_dir_exit(node);
> > +       kmem_cache_free(delayed_node_cache, node);
> > +       if (ret)
> > +               return ERR_PTR(ret);
> > +       goto again;
> >  }
> >
> >  /*
> > --
> > 2.47.3
> >
> >

