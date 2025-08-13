Return-Path: <linux-btrfs+bounces-16067-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA8EB25233
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 19:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895E1886400
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 17:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7CE284B37;
	Wed, 13 Aug 2025 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNweAgui"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA86EB665
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755106915; cv=none; b=W9lV3a8Lui/QkS2EtoYgbzBQ6E26hUnZZTsxn7eJTJhXzMjtdBai9pk1w7ln7yvN+TSrjIROdC5SCLy7MYdwhNG9hnwms1jPhk4SlopEq6LHBi3q/Hzuiyo3SFXKDQif4eiRVVBu4+6TAjcWWNVCcQlqtt8dIFSEh006tfqeokQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755106915; c=relaxed/simple;
	bh=GLRgJrUzs+Z8RKqWsfKTU34oO0JHvwsi/J8jVvrnPFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFXUFJActfFypY/Yy8MbCVdUGtRLS9WnjGQMtDwzHDjiAcLspu5DJ2S/fY/m+rHbPwGrjYNuZXcDt6DdY1xninbN46WR9mKxQ/bQ4OsWdq9zjcpXxBFzKv3nGe2KO4uky7difZkliqsjUIc1MgSQsz76cirjX0INsBfxzlXlcjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNweAgui; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-71d6014810fso1561647b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 10:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755106913; x=1755711713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6YlGqvPTDk/RbH7Yniica7XVYjfM8GkdijpZfApyHs=;
        b=DNweAguinKYR7KmiOuYLLntv+kYvXwVMdfeb6IL8ALrwCcnmUa76m14cwO6oSTz1dO
         6qaTW/rLP4UjhTbYvo0dTL92/NNuZruXkVvSoVFmVyBTy/BCc3pdeA5tdQAkq+Yv5uyj
         sfDbT0uPuyfR16oim/4a3CWMeCTu8NJ+YhPuod7rFHg3wFqzo06X1Bgh3qsS1/1wqQxi
         klU5wktbloQaOV72uf+fnJjesDvScfgdzNJTPswtRp6vEvPvrBgaEvKNo/Stsb0+M51j
         3GLgDG9gV+3R6Dgklqo7j6xSse8dxfEpmUFooLawkrQi5YjTrsu6etTUXGNgTFMn386K
         thVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755106913; x=1755711713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6YlGqvPTDk/RbH7Yniica7XVYjfM8GkdijpZfApyHs=;
        b=ujCB64O9KHP+Ctsin8ecR+BQ9F/CzlGRWQ/elgosqa73esaDqhvZiPB7SHg0fgRz9M
         iSWZe3Fi9OYZwjY9yRek/bSYoBQ89MY0HLzChMteHGF0QHX1iqK+OrLwjCwPXnZefA4M
         Y6gV3hOEKED4ywoVyJ4nM82XtzJI1fxQuq/OFoURdaDUqj9L7VL27G7r+VZUmJ2F/YDn
         UPyP5tnKOCB8IywWsj3lgWn3Nstb2323V9Qb4p5ptuv/kN8fqeGJCEA+RTCXk8eNdiGd
         ZBX/Oqh2hyeOBBU/t+9xuGZ02eNm1JgxldP6IKwcV04sR7mqFf9f0R+0/zK++PEOifxs
         XpsA==
X-Gm-Message-State: AOJu0YzqE7YmDCPHjtvPADZVeY9eqrrZdIYnqi7ksrZiQCP6dgUI18ZV
	IWtz9tWO5CZEobuEIkbK9zrLE6kGCwfM7xT7bIdnsUM1aoQyw0GpKhtR
X-Gm-Gg: ASbGnctPlxdnwSp+bxm1Ww99QGChGjmaqlxfrbGqKLUd9LYZIg2vZ+8urj2wMO7PYJp
	SJNx/vzWGWG/8WHPSSq7bS03LNXjxUqOJAV6nQCuA8sMQbCrJ/xiMm+HBHRxOM1P95+Rd3U0uR8
	8fbgcQTxKbLyg0VVyApzveLdhrWIOHJsKF7RbWts3V7lKnCfYni5MR1OuUmPOWJxID91+Uj6nu4
	xAmov4cdKaU17pLgeaBUr1Io4xGH1/S0yxOWPtsikj8ahLfqxy4WIquX7DLU66+6ORYgwSDInrK
	6hNtTPlTN6WDeeQOyigw8yDyirVeQlm+KwQyra3G5hbAl8GIrYkl62HHAO9oVHCBXGQlXkxaSNp
	zmlhxgz8Q40ssTc+XuAuipJI8CqPD
X-Google-Smtp-Source: AGHT+IEGcMiXaJqmiIdcXYXOen7RXqY9qqE1UT7VAxWpgMPCSZ5QXepf5Paos2Bp++lD+iMtjTVTmw==
X-Received: by 2002:a05:690c:d8d:b0:71c:1673:7bb4 with SMTP id 00721157ae682-71d4e5b40ecmr51285637b3.38.1755106912354;
        Wed, 13 Aug 2025 10:41:52 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4d::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e931d56db95sm39594276.19.2025.08.13.10.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:41:51 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v4 1/3] btrfs: implement ref_tracker for delayed_nodes
Date: Wed, 13 Aug 2025 10:41:15 -0700
Message-ID: <20250813174146.1159027-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250813125052.GC22430@twin.jikos.cz>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 13 Aug 2025 14:50:52 +0200 David Sterba <dsterba@suse.cz> wrote:

> On Tue, Aug 12, 2025 at 04:04:39PM -0700, Leo Martins wrote:
> > This patch adds ref_tracker infrastructure for btrfs_delayed_node.
> > 
> > It is a response to the largest btrfs related crash in our fleet.
> > We're seeing softlockups in btrfs_kill_all_delayed_nodes that seem
> > to be a result of delayed_nodes not being released properly.
> > 
> > A ref_tracker object is allocated on reference count increases and
> > freed on reference count decreases. The ref_tracker object stores
> > a stack trace of where it is allocated. The ref_tracker_dir object
> > is embedded in btrfs_delayed_node and keeps track of all current
> > and some old/freed ref_tracker objects. When a leak is detected
> > we can print the stack traces for all ref_trackers that have not
> > yet been freed.
> > 
> > Here is a common example of taking a reference to a delayed_node
> > and freeing it with ref_tracker.
> > 
> > ```C
> > struct btrfs_ref_tracker tracker;
> > struct btrfs_delayed_node *node;
> > 
> > node = btrfs_get_delayed_node(inode, &tracker);
> > // use delayed_node...
> > btrfs_release_delayed_node(node, &tracker);
> > ```
> > 
> > There are two special cases where the delayed_node reference is "long
> > lived", meaning that the thread that takes the reference and the thread
> > that releases the reference are different. The `inode_cache_tracker`
> > tracks the delayed_node stored in btrfs_inode. The `node_list_tracker`
> > tracks the delayed_node stored in the btrfs_delayed_root
> > node_list/prepare_list. These trackers are embedded in the
> > btrfs_delayed_node.
> > 
> > btrfs_ref_tracker and btrfs_ref_tracker_dir are wrappers that either
> > compile to the corresponding ref_tracker structs or empty structs
> > depending on CONFIG_BTRFS_DEBUG. There are also btrfs wrappers for
> > the ref_tracker API.
> > 
> > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> 
> There's some witespace damage that fails when the patch is applied by
> 'git am', it can be fixed manually but please fix that next time.

Sorry, totally my fault, did not run checkpatch before sending out.
Will fix next time.

> 
> > ---
> >  fs/btrfs/Kconfig         |   3 +-
> >  fs/btrfs/delayed-inode.c | 192 ++++++++++++++++++++++++++++-----------
> >  fs/btrfs/delayed-inode.h |  70 ++++++++++++++
> >  3 files changed, 209 insertions(+), 56 deletions(-)
> > 
> > diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> > index c352f3ae0385..2745de514196 100644
> > --- a/fs/btrfs/Kconfig
> > +++ b/fs/btrfs/Kconfig
> > @@ -61,7 +61,8 @@ config BTRFS_FS_RUN_SANITY_TESTS
> >  
> >  config BTRFS_DEBUG
> >  	bool "Btrfs debugging support"
> > -	depends on BTRFS_FS
> > +	depends on BTRFS_FS && STACKTRACE_SUPPORT
> 
> How does this work? If STACKTRACE_SUPPORT is not enabled then we can't
> enable BTRFS_DEBUG?

That's correct, my understanding is that STACKTRACE_SUPPORT is something
configured by different architectures based on whether or not they
support stacktraces. Maybe it would be better to do something like

select REF_TRACKER if STACKTRACE_SUPPORT

so we can still use DEBUG on architectures that don't support stacktraces,
though I can't imagine they would be very relevant.

> 
> > +	select REF_TRACKER
> >  	help
> >  	  Enable run-time debugging support for the btrfs filesystem.
> >  
> 
> > @@ -78,6 +95,12 @@ struct btrfs_delayed_node {
> >  	 * actual number of leaves we end up using. Protected by @mutex.
> >  	 */
> >  	u32 index_item_leaves;
> > +	/* Used to track all references to this delayed node. */
> > +	struct btrfs_ref_tracker_dir ref_dir;
> > + 	/* Used to track delayed node reference stored in node list. */
> > +	struct btrfs_ref_tracker node_list_tracker;
> > + 	/* Used to track delayed node reference stored in inode cache. */
> > +	struct btrfs_ref_tracker inode_cache_tracker;
> 
> Some of the comments have mixed space and tabs in the initial space.

Sorry, again.

> 
> >  };
> >  
> >  struct btrfs_delayed_item {
> > @@ -169,4 +192,51 @@ void __cold btrfs_delayed_inode_exit(void);
> >  /* for debugging */
> >  void btrfs_assert_delayed_root_empty(struct btrfs_fs_info *fs_info);
> >  
> > +#define BTRFS_DELAYED_NODE_REF_TRACKER_QUARANTINE_COUNT 16
> > +#define BTRFS_DELAYED_NODE_REF_TRACKER_DISPLAY_LIMIT 16
> > +
> > +#ifdef CONFIG_BTRFS_DEBUG
> > +static inline void btrfs_delayed_node_ref_tracker_dir_init(struct btrfs_delayed_node *node)
> > +{
> > +	ref_tracker_dir_init(&node->ref_dir.dir, 
> 
> Trailing space.
> 
> > +			     BTRFS_DELAYED_NODE_REF_TRACKER_QUARANTINE_COUNT,
> > +			     "delayed_node");
> > +}

Sent using hkml (https://github.com/sjp38/hackermail)

