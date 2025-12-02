Return-Path: <linux-btrfs+bounces-19464-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCE6C9C5D4
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 18:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9669B3466B6
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 17:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B7E2C0271;
	Tue,  2 Dec 2025 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSaONty5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2851F91E3
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764695870; cv=none; b=eUK9t0v6wpryBQmXHp4HmPDelz2/39CBaV+abtjld2bVJ/QPZ+WeB4TDjHubd5p/I8C9c4xdOgFPTL2Nlc/wI32u44tHDKAcmjrAcIrbfvp6Ms40fNSO0hJMdM5XlIHoXbBcuVZ0KHMX2EVTgwiL5RjRfhlHA+46g74B9kuGxfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764695870; c=relaxed/simple;
	bh=e37SN+aToRVyC6n1zkZmulujPisP2nXDQSMcfkqxLY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CsA0c8Ud9xC+kgAyFjN0ly6ZcF0I4vVuIemeoNMfdNofkPnjDy1HFnf5fhqLiwL/TnCVAgpSN/HUZkJnI6MgKRYC9Yro7KdQmJl7QB/4B6heJg2O7tZ4BsfXaxeBkrArBhqzG/BrCicgNIK57mkkyA62lDuYE3t0msaoPzMkwBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSaONty5; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-641e4744e59so6007127d50.2
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Dec 2025 09:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764695868; x=1765300668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8QlVTXiL4fK7xIfQtCmFRQsL7zA4OuWCxdMWpV4kkE=;
        b=bSaONty5aT5muOIMYOcyUQF+6kKOrktNRPQ4XXJ/ltkyxtio87plPSRlGH34E61mMD
         r38Rlv3J/ciK9lWksDvQyg+sZS4rGVVjiFj7Y9wIowzWwqQTrsqzXG/XlS/Oh+Cr0qZ/
         oVcFbA8GThn5uxPg5CrW+vMqLF0XCqFJ1SPN9eQnN6547bRtg/Qo2XWsqjFDTGeLvyYU
         HXG7ogcluGmCg6H6r8urWViuzja4N6gsCA+S8spUYMZ5mH/05GKNaB5vPFTGwtB4H+6Q
         JVNvmn1r+YMbeuNxEvAx7Pqx53D0s5WUq2dsFm8Y8D2g0j77nTm/WgAiwHxaq7qVMtxB
         2w8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764695868; x=1765300668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q8QlVTXiL4fK7xIfQtCmFRQsL7zA4OuWCxdMWpV4kkE=;
        b=DCj9RRLVXM0+3NufvB5utcCqMmc8smVotswuj15EICrSIJdoEnhcQ2ZBQi+v494p7I
         qtbrKBiDOXG+yKHjI9BNoNkKfyAT669YH8uVI4yuHXQ2YHyX8FHigAHdrUCcyII1XUux
         M+XzZqaSEefdRz3Byb9Yd9+CNChnBYkZz7RXicsTcJaxKSz2QNxOnDnq30o7vMc3+KJE
         rKNZVuqA5cTtEOWQTo49dDAsWqY1H79agPcrLyfdtpeuoTo4daLG6PyEQn15ayrqpSfY
         wJ5JFCZbJjATUJG91onaCHpaZ/pnobyWo+CCy4Hf10T3OqMuoGRcOr1xGIkKviDUADFD
         OfPg==
X-Forwarded-Encrypted: i=1; AJvYcCWwkcIzq2vm0hetcCW+1MGCLRtR8E5NU3dW41236sYutZ3Bh02ujR4zbEudnP1lxqs9hlM+xTKBsyxgGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMj05/PgHUNQDzLbZWxDFQbkSvamTmWiih+s9gfWqYRIQoi2Iq
	wAulG/uB6vLeN2RmPHhBeTOLB5d4mdtHm6rz8/V24Do5rU4zKYN5facF
X-Gm-Gg: ASbGncsIkpWO+KJ/mhW23TXYy0VFBlmVSC+9zqzVvNeQtui9HHUntSRpL+1VZm+VCVA
	vVFllYA201cdPpm2cZM3feakq/V+OXuocjTcskGdZ5hQFH+2cqb9p2VGDlj4NmtWbakOfKyE0N/
	o/cB13ncpIrviw5rOqa1xXfyo19KA1sMAypZIdxUpU4QvWrAjMRHFLSzaC0wxf5cT4NvgI3V11o
	mf2l+nE9QBafsnjJP9XiamLGXtu3ZzSnVdK8wtkacA32/RgcE8T8fcPaPwnwDGvz2m0J5kT8mP3
	XyR1BwTofZ9TwyCd/LLxhGXcIyo7ki4vYDGgjprBKTuTH/861YTYW+yw6tYpVRCmZtn0ZUJKhmJ
	lhPSYAMFtikNgLTKOamJt87zDfH6mdZH3uxwiwfmPtMAVEeK6MGjJunEXNMnpGIko9xx32YahVF
	Kwp/J25PWsEiVADzC+
X-Google-Smtp-Source: AGHT+IHdKu4hpE/8f2eE+4lPs0EO9wbGhycCa+sCjZHw1sF1sCEgg+Iae1BCxPfWRTEdAx3ecTHilw==
X-Received: by 2002:a53:c052:0:20b0:640:d0d4:526d with SMTP id 956f58d0204a3-64302a2dc80mr25410432d50.9.1764695867800;
        Tue, 02 Dec 2025 09:17:47 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0d82295sm64124477b3.25.2025.12.02.09.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 09:17:47 -0800 (PST)
From: Leo Martins <loemra.dev@gmail.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Oliver Sang <oliver.sang@intel.com>,
	oe-lkp@lists.linux.dev,
	lkp@intel.com,
	linux-kernel@vger.kernel.org,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [linus:master] [btrfs] e8513c012d: addition_on#;use-after-free
Date: Tue,  2 Dec 2025 09:17:40 -0800
Message-ID: <20251202171745.798946-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAL3q7H5L2Yc3aNCfffuimET6LLup9iB2T4_1caJkgV+c8avRMg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 2 Dec 2025 15:04:51 +0000 Filipe Manana <fdmanana@kernel.org> wrote:

> On Tue, Dec 2, 2025 at 8:40 AM Oliver Sang <oliver.sang@intel.com> wrote:
> >
> > hi, Leo Martins,
> >
> > On Mon, Dec 01, 2025 at 04:51:41PM -0800, Leo Martins wrote:
> >
> > [...]
> >
> > >
> > > Hello,
> > >
> > > I believe I have identified the root cause of the warning.
> > > However, I'm having some troubles running the reproducer as I
> > > haven't setup lkp-tests yet. Could you test the patch below
> > > against your reproducer to see if it fixes the issue?
> >
> > we confirmed your patch fixed the issues we reported in origial report. thanks!
> >
> > Tested-by: kernel test robot <oliver.sang@intel.com>
> >
> > >
> > > ---8<---
> > >
> > > [PATCH] btrfs: fix use-after-free in btrfs_get_or_create_delayed_node
> > >
> > > Previously, btrfs_get_or_create_delayed_node sets the delayed_node's
> > > refcount before acquiring the root->delayed_nodes lock.
> > > Commit e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes")
> > > moves refcount_set inside the critical section which means
> > > there is no longer a memory barrier between setting the refcount and
> > > setting btrfs_inode->delayed_node = node.
> > >
> > > This allows btrfs_get_or_create_delayed_node to set
> > > btrfs_inode->delayed_node before setting the refcount.
> > > A different thread is then able to read and increase the refcount
> > > of btrfs_inode->delayed_node leading to a refcounting bug and
> > > a use-after-free warning.
> > >
> > > The fix is to move refcount_set back to where it was to take
> > > advantage of the implicit memory barrier provided by lock
> > > acquisition.
> > >
> > > Fixes: e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes")
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Closes: https://lore.kernel.org/oe-lkp/202511262228.6dda231e-lkp@intel.com
> > > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> > > ---
> > >  fs/btrfs/delayed-inode.c | 34 ++++++++++++++++++----------------
> > >  1 file changed, 18 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > > index 364814642a91..f61f10000e33 100644
> > > --- a/fs/btrfs/delayed-inode.c
> > > +++ b/fs/btrfs/delayed-inode.c
> > > @@ -152,37 +152,39 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
> > >               return ERR_PTR(-ENOMEM);
> > >       btrfs_init_delayed_node(node, root, ino);
> > >
> > > +     /* Cached in the inode and can be accessed. */
> > > +     refcount_set(&node->refs, 2);
> > > +     btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
> > > +     btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tracker, GFP_ATOMIC);
> > > +
> > >       /* Allocate and reserve the slot, from now it can return a NULL from xa_load(). */
> > >       ret = xa_reserve(&root->delayed_nodes, ino, GFP_NOFS);
> > > -     if (ret == -ENOMEM) {
> > > -             btrfs_delayed_node_ref_tracker_dir_exit(node);
> > > -             kmem_cache_free(delayed_node_cache, node);
> > > -             return ERR_PTR(-ENOMEM);
> > > -     }
> > > +     if (ret == -ENOMEM)
> > > +             goto cleanup;
> > > +
> > >       xa_lock(&root->delayed_nodes);
> > >       ptr = xa_load(&root->delayed_nodes, ino);
> > >       if (ptr) {
> > >               /* Somebody inserted it, go back and read it. */
> > >               xa_unlock(&root->delayed_nodes);
> > > -             btrfs_delayed_node_ref_tracker_dir_exit(node);
> > > -             kmem_cache_free(delayed_node_cache, node);
> > > -             node = NULL;
> > > -             goto again;
> > > +             goto cleanup;
> > >       }
> > >       ptr = __xa_store(&root->delayed_nodes, ino, node, GFP_ATOMIC);
> > >       ASSERT(xa_err(ptr) != -EINVAL);
> > >       ASSERT(xa_err(ptr) != -ENOMEM);
> > >       ASSERT(ptr == NULL);
> > > -
> > > -     /* Cached in the inode and can be accessed. */
> > > -     refcount_set(&node->refs, 2);
> > > -     btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
> > > -     btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tracker, GFP_ATOMIC);
> > > -
> > > -     btrfs_inode->delayed_node = node;
> > > +     WRITE_ONCE(btrfs_inode->delayed_node, node);
> 
> Why the WRITE_ONCE() change?

Since there are lockless readers of btrfs_inode->delayed_node all writers
should be marked with WRITE_ONCE to force the compiler to store atomically.

>
> Can you explain in the changelog why it's being introduced?
> This seems unrelated and it was not there before the commit mentioned
> in the Fixes tag.

I'll send out a v2 without the WRITE_ONCE since it is not directly related
to this bug and send out a separate patch updating writes to use WRITE_ONCE.

Thanks.

> 
> Thanks.
> 
> > >       xa_unlock(&root->delayed_nodes);
> > >
> > >       return node;
> > > +cleanup:
> > > +     btrfs_delayed_node_ref_tracker_free(node, tracker);
> > > +     btrfs_delayed_node_ref_tracker_free(node, &node->inode_cache_tracker);
> > > +     btrfs_delayed_node_ref_tracker_dir_exit(node);
> > > +     kmem_cache_free(delayed_node_cache, node);
> > > +     if (ret)
> > > +             return ERR_PTR(ret);
> > > +     goto again;
> > >  }
> > >
> > >  /*
> > > --
> > > 2.47.3
> >


