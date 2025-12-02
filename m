Return-Path: <linux-btrfs+bounces-19471-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828CAC9D004
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 22:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618C43A639F
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 21:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE052F7477;
	Tue,  2 Dec 2025 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FciMMJ/v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364D0221F0C
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 21:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764709416; cv=none; b=HfNfxCFSAYLPNimbtROMBBd4k6PzvXKjAF+L4yJwaIBF1cEB6rHsRfUkxUJ9U89lidYl9mliqwMpJDlphcgFZxnvxwWOMztTUH3FlrVjF1xy50BWjx6XVsuICaOF8KEsudOsJsY5eo+6Aexch6UCex1ED0zfXR8Mrw244DICJyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764709416; c=relaxed/simple;
	bh=nsE1dcVItFIrKkgY5iEvi5+Y+OLRs1VB0cezp8E3BWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDBVvW4k9JNMolZmOpoUe4LJz3DoeYqk6+gYzSHj8ytOO9IwyirSBOpYoUblXUtuJ+8YGtuG8maV5hGqaIGRN3e3x4D/XrJet02sBcnohDgQ6c5V1P/unqErwEUkwwkhSruneFqCHn/DhH57SmDBWVmrTNanQLVJMYyAvFIpagk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FciMMJ/v; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-63f97ab5cfcso4909639d50.0
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Dec 2025 13:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764709414; x=1765314214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHqo10RPrXoBjpQijgSJaVgvodoRgdMooXQI8Kn+rbo=;
        b=FciMMJ/vWs8rZZUTcn2Q5p8fcXMLyY+pTIl14tfOZvXrfunvsA3Qdfl1cUncqp53t4
         jRc8k/V7IEkTFDq4VNDzGjj+UG2EOI92etFkvb97eOPzImeVK1gRJrOD9ud2J0RlirK9
         kQDqk8GXJ4sswx+gI7sYrJejGhr80ISKRcvwjmI1umN2PDYVkJHPdyqLo4fKQd5TWfiN
         DQ1LK7hLVp4bTfCpnJYitP73BD62Thf+jkaeecjL1wPRLy0WM2w35dtrcdexJeKzPohx
         RSu47oR3U9SA9eiVwfHPLCPgtQI//IwbgUjFKd5cXxN9zSIqRxCrrFyf5kk3MQh5JDdc
         5a1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764709414; x=1765314214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qHqo10RPrXoBjpQijgSJaVgvodoRgdMooXQI8Kn+rbo=;
        b=g9uyskadExodj2xfseOg2tKNlw6ktbtxagnmf6mysQPmuz1lHy0220s+tgojqrX0H2
         zZ+/gSSwTJkp4QZU3qFxPUZ79krpiWoBRZWszOZwH8JxzVWlS5L0KH4P05wjDcnxvw3b
         BD11Cr65LUtGOR3MDeLs7Y2cZDfEwWwxoui2nLdF7jfNCZNyPK1PDYmwLXLtzdyR2slE
         1vMV18GLVaVbqWWiLJocRwNZA3fbrTR/zDiEiBh4y6PEmbPYC3i4JQAG7U04GgNyl0d9
         gKrNwts617KkV2ZzxP0UJTLbO2YCz3SgCu661OMPn9H+JeMZ1cZ+N45U0K05uOjs+xhr
         bGhw==
X-Forwarded-Encrypted: i=1; AJvYcCV2PcdWEtDc0tRV1Vi3zlRox0k4QzEif/1fq7g9bsveEEvrNFmAZZOA9iMizx06PYivUxNcGw3cjnqX+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwikowmirDgW5eJmEgLaZGpgsArX7IwfAaS6fgTGDSCK1JkLNh8
	GQzBvvCdCNbvJPazncOvdSA9iPlIsJP3+c4RQMQYiPLklqAWpUluI321p8QiQU7p
X-Gm-Gg: ASbGncsk4YrnhmeswbqiL8pXDdDUqI3Dw1Pa6uD7nFRTGu6OBjpYLGeEZ0fbAMLDnpc
	xz4MjOElvWUatwrE79r6S8tK0nt3bK8LobTuTZHjL68h7it2qmcOcfbiHtZ+cv4xoL+gCCbowVx
	Vpum5AQ3ELOv5pNf2QQ+SRCieFr0X/VO06bo9TOFCvWjEMZjf7lysSDdeghaZaFFrX92sSp4Ois
	jABttYYl8F1K1kNUz8mW05rEsm5SNQtVoNyXRl8YOd4eIp+onaUm0wZei1BUq/TD1q5/esdKaH8
	IJoBWBgWgeNLPRgAN/6qvvoNgxw+KQjZNOMxFn5ELXKoN9t108UK2fZEeGXpXhwMy6RuOwlXzGB
	6vHvKOhyU0W/M9NlGW+izgHbQ4FHiuLHYJdS3FCQA7hOiYcCge2Q7LjNeRK3JBsNhurXD24LNQA
	fxcFZVxU6/C/DJXnlMiw==
X-Google-Smtp-Source: AGHT+IEyRfhMsBmjvsOtgMQ3MW/jmJCsdUgV3EbIDt1I1mGrcnMfQfROj52ogueWWJwWVhxsmp5c7Q==
X-Received: by 2002:a05:690e:1909:b0:63f:860f:feda with SMTP id 956f58d0204a3-644370439d3mr114471d50.63.1764709414045;
        Tue, 02 Dec 2025 13:03:34 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:42::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0d3f5f3sm66735887b3.8.2025.12.02.13.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 13:03:33 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Oliver Sang <oliver.sang@intel.com>,
	oe-lkp@lists.linux.dev,
	lkp@intel.com,
	linux-kernel@vger.kernel.org,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [linus:master] [btrfs] e8513c012d: addition_on#;use-after-free
Date: Tue,  2 Dec 2025 13:03:25 -0800
Message-ID: <20251202210330.2705156-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAL3q7H6q-j8Xo_SHGyY0+pHj=BQHezTwxbP9VKQxgLruqxQdow@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 2 Dec 2025 19:19:05 +0000 Filipe Manana <fdmanana@kernel.org> wrote:

> On Tue, Dec 2, 2025 at 5:17 PM Leo Martins <loemra.dev@gmail.com> wrote:
> >
> > On Tue, 2 Dec 2025 15:04:51 +0000 Filipe Manana <fdmanana@kernel.org> wrote:
> >
> > > On Tue, Dec 2, 2025 at 8:40 AM Oliver Sang <oliver.sang@intel.com> wrote:
> > > >
> > > > hi, Leo Martins,
> > > >
> > > > On Mon, Dec 01, 2025 at 04:51:41PM -0800, Leo Martins wrote:
> > > >
> > > > [...]
> > > >
> > > > >
> > > > > Hello,
> > > > >
> > > > > I believe I have identified the root cause of the warning.
> > > > > However, I'm having some troubles running the reproducer as I
> > > > > haven't setup lkp-tests yet. Could you test the patch below
> > > > > against your reproducer to see if it fixes the issue?
> > > >
> > > > we confirmed your patch fixed the issues we reported in origial report. thanks!
> > > >
> > > > Tested-by: kernel test robot <oliver.sang@intel.com>
> > > >
> > > > >
> > > > > ---8<---
> > > > >
> > > > > [PATCH] btrfs: fix use-after-free in btrfs_get_or_create_delayed_node
> > > > >
> > > > > Previously, btrfs_get_or_create_delayed_node sets the delayed_node's
> > > > > refcount before acquiring the root->delayed_nodes lock.
> > > > > Commit e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes")
> > > > > moves refcount_set inside the critical section which means
> > > > > there is no longer a memory barrier between setting the refcount and
> > > > > setting btrfs_inode->delayed_node = node.
> > > > >
> > > > > This allows btrfs_get_or_create_delayed_node to set
> > > > > btrfs_inode->delayed_node before setting the refcount.
> > > > > A different thread is then able to read and increase the refcount
> > > > > of btrfs_inode->delayed_node leading to a refcounting bug and
> > > > > a use-after-free warning.
> > > > >
> > > > > The fix is to move refcount_set back to where it was to take
> > > > > advantage of the implicit memory barrier provided by lock
> > > > > acquisition.
> > > > >
> > > > > Fixes: e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes")
> > > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > > Closes: https://lore.kernel.org/oe-lkp/202511262228.6dda231e-lkp@intel.com
> > > > > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> > > > > ---
> > > > >  fs/btrfs/delayed-inode.c | 34 ++++++++++++++++++----------------
> > > > >  1 file changed, 18 insertions(+), 16 deletions(-)
> > > > >
> > > > > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > > > > index 364814642a91..f61f10000e33 100644
> > > > > --- a/fs/btrfs/delayed-inode.c
> > > > > +++ b/fs/btrfs/delayed-inode.c
> > > > > @@ -152,37 +152,39 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
> > > > >               return ERR_PTR(-ENOMEM);
> > > > >       btrfs_init_delayed_node(node, root, ino);
> > > > >
> > > > > +     /* Cached in the inode and can be accessed. */
> > > > > +     refcount_set(&node->refs, 2);
> > > > > +     btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
> > > > > +     btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tracker, GFP_ATOMIC);
> > > > > +
> > > > >       /* Allocate and reserve the slot, from now it can return a NULL from xa_load(). */
> > > > >       ret = xa_reserve(&root->delayed_nodes, ino, GFP_NOFS);
> > > > > -     if (ret == -ENOMEM) {
> > > > > -             btrfs_delayed_node_ref_tracker_dir_exit(node);
> > > > > -             kmem_cache_free(delayed_node_cache, node);
> > > > > -             return ERR_PTR(-ENOMEM);
> > > > > -     }
> > > > > +     if (ret == -ENOMEM)
> > > > > +             goto cleanup;
> > > > > +
> > > > >       xa_lock(&root->delayed_nodes);
> > > > >       ptr = xa_load(&root->delayed_nodes, ino);
> > > > >       if (ptr) {
> > > > >               /* Somebody inserted it, go back and read it. */
> > > > >               xa_unlock(&root->delayed_nodes);
> > > > > -             btrfs_delayed_node_ref_tracker_dir_exit(node);
> > > > > -             kmem_cache_free(delayed_node_cache, node);
> > > > > -             node = NULL;
> > > > > -             goto again;
> > > > > +             goto cleanup;
> > > > >       }
> > > > >       ptr = __xa_store(&root->delayed_nodes, ino, node, GFP_ATOMIC);
> > > > >       ASSERT(xa_err(ptr) != -EINVAL);
> > > > >       ASSERT(xa_err(ptr) != -ENOMEM);
> > > > >       ASSERT(ptr == NULL);
> > > > > -
> > > > > -     /* Cached in the inode and can be accessed. */
> > > > > -     refcount_set(&node->refs, 2);
> > > > > -     btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
> > > > > -     btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tracker, GFP_ATOMIC);
> > > > > -
> > > > > -     btrfs_inode->delayed_node = node;
> > > > > +     WRITE_ONCE(btrfs_inode->delayed_node, node);
> > >
> > > Why the WRITE_ONCE() change?
> >
> > Since there are lockless readers of btrfs_inode->delayed_node all writers
> > should be marked with WRITE_ONCE to force the compiler to store atomically.
> 
> If by atomically you mean to avoid store/load tearing, then using the
> _ONCE() macros won't do anything because we are dealing with pointers.
> This has been discussed in the past, see:
> 
> https://lore.kernel.org/linux-btrfs/cover.1715951291.git.fdmanana@suse.com/

That is what I meant. Missed that discussion, thanks for the link.
I do still see some value in using WRITE_ONCE which is for the human
reader to realize that there are lockless readers, but that's pretty
minor.
> 
> >
> > >
> > > Can you explain in the changelog why it's being introduced?
> > > This seems unrelated and it was not there before the commit mentioned
> > > in the Fixes tag.
> >
> > I'll send out a v2 without the WRITE_ONCE since it is not directly related
> > to this bug and send out a separate patch updating writes to use WRITE_ONCE.
> >
> > Thanks.
> >
> > >
> > > Thanks.
> > >
> > > > >       xa_unlock(&root->delayed_nodes);
> > > > >
> > > > >       return node;
> > > > > +cleanup:
> > > > > +     btrfs_delayed_node_ref_tracker_free(node, tracker);
> > > > > +     btrfs_delayed_node_ref_tracker_free(node, &node->inode_cache_tracker);
> > > > > +     btrfs_delayed_node_ref_tracker_dir_exit(node);
> > > > > +     kmem_cache_free(delayed_node_cache, node);
> > > > > +     if (ret)
> > > > > +             return ERR_PTR(ret);
> > > > > +     goto again;
> > > > >  }
> > > > >
> > > > >  /*
> > > > > --
> > > > > 2.47.3
> > > >
> >

