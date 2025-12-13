Return-Path: <linux-btrfs+bounces-19703-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1933ACBA27A
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 02:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAF33300AC73
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Dec 2025 01:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8965B1DF247;
	Sat, 13 Dec 2025 01:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh1Mteqc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5A51DC9B3
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Dec 2025 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765589314; cv=none; b=oQ5M7I/OcSjJKYHRgFJaeK3nZJgIoO02Wkh7G7S6NdaSMyKNyQ/rabWmpo5CpsaUotugMJ+OTzc3Yg83GOkSgcw+9DlZ2VUDb1agRg2om4RxdCjNEF+BPGrCNLFydL7Pn6PC7+cVcg6E9Tkfm2sXTvTp16rV+Dr9Ofa62OSzc9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765589314; c=relaxed/simple;
	bh=xUdeZ/sUcavKjTzwvpZDtJ+HEL8G2SmAxD4+UqXlcBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bjU8nhfiITgrloUANLSemQBfUaoXry7HdpZi4b91AH1Is2m4YS/sBz/7j/NNxVSYJbFGLBYk9tMYgpygftAsjxElyDWiNvSfqZxjvSvUz5dAgc0JwG2H8mgMJjC9v4/R/9pGHWFj6Xjs21EdAzehIIdvTbrMrT5GbhkMt6+qQ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eh1Mteqc; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-63fc6d9fde5so1627452d50.3
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 17:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765589312; x=1766194112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdlghsKpfZ6efPza8UQomcVJeufb2CYK03ro0JJjv0k=;
        b=Eh1Mteqc2CLga43FrHkqsU2xmFrG9PYKpn7qu5aynhF6HJfqcAo0h5F+YZZuCNA8Is
         EHWChIGFZkpmls6zTY4PFCstkzZ22tqhn7PMpjlLsuGeUXJi4QX0H1fhTnoNyvzCoTQF
         Sp3NiteeJcGTW+GDf4OtTZfnlz0GriwGBtdYZhGd3S8YRuxs0Wkg9gtfps3eqeodXYV4
         /674wBcVGxlkjFB5t0JC9BmYcTae2b/AG+a4X0gkwE3/h/hc89chSDRAdJmN738MT7Cz
         ch7LmKExrA0E4aM+wQOdquLiN6/7u7UI8evxk5Do/U21RfBejG3Dihw7dy619jr4JCKk
         VerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765589312; x=1766194112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OdlghsKpfZ6efPza8UQomcVJeufb2CYK03ro0JJjv0k=;
        b=se7cPTVlkF3EubZb2V6pNbwAy2z5Q17uKkIAE/yp2rCnPA3ucFD6IC7IOa+9j9k6Ma
         DT7HxiUqrd2SMW9rAxGhXhNsNhoAHi4/35axumHgpkjYoGOJMCIz+pb0bDlNBmoMfT/r
         VHDTHjI6+6Mek3StOpFs1P2/jSHDf+JFYR/CuPcNNYG84QZrWpGpRPxC5tk5ljOxwGd2
         zbi3nC3jBl+0dFd+J/xRIQFC+S3etWA1ah+iWEfPb/OaIC99pvVHy8cYaCLL/UoHorm7
         hSzH2Pj3U2tJ+8RX+/ErA8XdEGSg880AS9B31ioroX2m+GmBiaK4suIiEbYU10yRfJyZ
         QcoQ==
X-Gm-Message-State: AOJu0YyLz8ADenNOBhEkoodtRX1gsTo2N65gWHG/fVAnYRG7vGcsF0sX
	hGxYcy9tV9Hmy+li7RfTkuIXqJhq6JTf8liaC6qMXoAmjFJp4Y+qjOs3ZJblcSys
X-Gm-Gg: AY/fxX7pvZzRllXlXaPVNp77d8GrtJq9QPv063uFT4uUIqDBkvoCoC15ztfGNoL69od
	REKk6je9JfR0r7LnrfUw17FxignD73ZgBheJUKBbXVwBunzOutfI99lVA+siCR1lyOneIhk/yIV
	pMD1xbKOyRYZW80KQGMZmczqfgRnwtM4EQPYut9+BEOY3mkvzwHfE+9HykaXqpoD4Jup9S9e67Y
	SpXqxlS+/cmqSQaac57kiFa4YXTpKUh/62LXE4HcNBu1itl1M+dKFGHVL0hlNGA0u3rn5EQ1pCn
	eDIhqG5OshX/2NT2HoH7QEjQ4jTdHJlTd0oSiMBncL1NWzPtI5mYvOb0BzGgYGbn8FHpjMzvcdc
	HvIz49ENlTxcV5fvmkeKGA1XzTag7lJuCBuHYb3+JRSFELHHgJs/WNGuYDDq63Sc49SXjg/dRkg
	bIT5IVqg3o7iX7Ktqo1uacwpcJY0s=
X-Google-Smtp-Source: AGHT+IGaIaFzIOxgLbtI9yp2QI7HV0uuflqeiLW5sj15yhmeWMl9YNp6mEUlWyrgkbkT0lRdMFKglw==
X-Received: by 2002:a53:b60d:0:b0:643:79b:fb1b with SMTP id 956f58d0204a3-645555e8e9emr2610147d50.21.1765589312124;
        Fri, 12 Dec 2025 17:28:32 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e74a43c4fsm2457667b3.50.2025.12.12.17.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 17:28:31 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2] btrfs: fix use-after-free warning in btrfs_get_or_create_delayed_node
Date: Fri, 12 Dec 2025 17:28:21 -0800
Message-ID: <20251213012829.89988-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAL3q7H7h0=3ombZ9L0L++RHhTfymEKroTVFvW33eRb9ZjWAWKA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 12 Dec 2025 09:32:06 +0000 Filipe Manana <fdmanana@kernel.org> wrote:

> On Fri, Dec 12, 2025 at 1:01 AM Leo Martins <loemra.dev@gmail.com> wrote:
> >
> > On Wed, 3 Dec 2025 10:50:17 +0000 Filipe Manana <fdmanana@kernel.org> wrote:
> >
> > > On Tue, Dec 2, 2025 at 9:21 PM Leo Martins <loemra.dev@gmail.com> wrote:
> > > >
> > > > Previously, btrfs_get_or_create_delayed_node sets the delayed_node's
> > > > refcount before acquiring the root->delayed_nodes lock.
> > > > Commit e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes")
> > > > moves refcount_set inside the critical section which means
> > > > there is no longer a memory barrier between setting the refcount and
> > > > setting btrfs_inode->delayed_node = node.
> > > >
> > > > This allows btrfs_get_or_create_delayed_node to set
> > > > btrfs_inode->delayed_node before setting the refcount.
> > > > A different thread is then able to read and increase the refcount
> > > > of btrfs_inode->delayed_node leading to a refcounting bug and
> > > > a use-after-free warning.
> > > >
> > > > The fix is to move refcount_set back to where it was to take
> > > > advantage of the implicit memory barrier provided by lock
> > > > acquisition.
> > > >
> > > > Fixes: e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes")
> > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > Closes: https://lore.kernel.org/oe-lkp/202511262228.6dda231e-lkp@intel.com
> > > > Tested-by: kernel test robot <oliver.sang@intel.com>
> > > > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> > > > ---
> > > >  fs/btrfs/delayed-inode.c | 32 +++++++++++++++++---------------
> > > >  1 file changed, 17 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > > > index 364814642a91..81922556379d 100644
> > > > --- a/fs/btrfs/delayed-inode.c
> > > > +++ b/fs/btrfs/delayed-inode.c
> > > > @@ -152,37 +152,39 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
> > > >                 return ERR_PTR(-ENOMEM);
> > > >         btrfs_init_delayed_node(node, root, ino);
> > > >
> > > > +       /* Cached in the inode and can be accessed. */
> > > > +       refcount_set(&node->refs, 2);
> > > > +       btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
> > > > +       btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tracker, GFP_ATOMIC);
> > >
> > > Now that we do these allocations outside the spinlock (xarray's lock),
> > > we can stop using GFP_ATOMIC and use GFP_NOFS.
> > >
> > > Otherwise it looks good, thanks.
> >
> > Did you want me to send out a v3 for this change?
> 
> You can make it either in a v3 or as a separate patch, I don't have a
> strong preference for this.
> 
> Either way:
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> (Applies both to this, a possible v3 and a standalone patch for
> replacing GFP_ATOMIC with GFP_NOFS).
> 
> If you can't push to for-next, let me know and I can do it.

Just sent out a v3. I can't push to for-next, if you could that
would be great.

Thanks.

> 
> Thanks.
> 
> >
> > >
> > > > +
> > > >         /* Allocate and reserve the slot, from now it can return a NULL from xa_load(). */
> > > >         ret = xa_reserve(&root->delayed_nodes, ino, GFP_NOFS);
> > > > -       if (ret == -ENOMEM) {
> > > > -               btrfs_delayed_node_ref_tracker_dir_exit(node);
> > > > -               kmem_cache_free(delayed_node_cache, node);
> > > > -               return ERR_PTR(-ENOMEM);
> > > > -       }
> > > > +       if (ret == -ENOMEM)
> > > > +               goto cleanup;
> > > > +
> > > >         xa_lock(&root->delayed_nodes);
> > > >         ptr = xa_load(&root->delayed_nodes, ino);
> > > >         if (ptr) {
> > > >                 /* Somebody inserted it, go back and read it. */
> > > >                 xa_unlock(&root->delayed_nodes);
> > > > -               btrfs_delayed_node_ref_tracker_dir_exit(node);
> > > > -               kmem_cache_free(delayed_node_cache, node);
> > > > -               node = NULL;
> > > > -               goto again;
> > > > +               goto cleanup;
> > > >         }
> > > >         ptr = __xa_store(&root->delayed_nodes, ino, node, GFP_ATOMIC);
> > > >         ASSERT(xa_err(ptr) != -EINVAL);
> > > >         ASSERT(xa_err(ptr) != -ENOMEM);
> > > >         ASSERT(ptr == NULL);
> > > > -
> > > > -       /* Cached in the inode and can be accessed. */
> > > > -       refcount_set(&node->refs, 2);
> > > > -       btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
> > > > -       btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tracker, GFP_ATOMIC);
> > > > -
> > > >         btrfs_inode->delayed_node = node;
> > > >         xa_unlock(&root->delayed_nodes);
> > > >
> > > >         return node;
> > > > +cleanup:
> > > > +       btrfs_delayed_node_ref_tracker_free(node, tracker);
> > > > +       btrfs_delayed_node_ref_tracker_free(node, &node->inode_cache_tracker);
> > > > +       btrfs_delayed_node_ref_tracker_dir_exit(node);
> > > > +       kmem_cache_free(delayed_node_cache, node);
> > > > +       if (ret)
> > > > +               return ERR_PTR(ret);
> > > > +       goto again;
> > > >  }
> > > >
> > > >  /*
> > > > --
> > > > 2.47.3
> > > >
> > > >

Sent using hkml (https://github.com/sjp38/hackermail)

