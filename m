Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4625746A5D8
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 20:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346520AbhLFTqp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 14:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245156AbhLFTqn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Dec 2021 14:46:43 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA59C061746
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 11:43:14 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id q14so11957473qtx.10
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Dec 2021 11:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hck5NYz7i1HPLriEmXz/tYCkKkls7Pe94ganvBcjk2o=;
        b=AWqLXNTVW5gHas/jV4ETf8/CnKtVzoGzAHJiz+vpsDw5Vq2rY+XK1GW3TVPoOcjj5B
         R1SHHCHDX4lpoukXSTqdJPRx5tjwZ1+fqS1srmzTuajCv7QZk7WK/FUx6fWPbBFXNdS7
         gxCIZvyll+X+Or1PElc9WU87Hd7u+CzhYZgFXcD7ReXGFg/ttT8D6wzwH+C/YAMri7cB
         2C8Czgt9PqhkRgB+D8gI3VN5J/7SJ640/e+HKpQnZj7XUlvcC9XbwNDyguFgt695soC8
         Q9TrLZOkY2kv4Ej6tDwvL/oj4IXXuiACJPOl/JLGLkyNTrXHtHrBM6QsjH+5slcU0YWv
         SMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hck5NYz7i1HPLriEmXz/tYCkKkls7Pe94ganvBcjk2o=;
        b=04fW9r0pVA8Nuupi8YxJZBf5Z++QA6ktDFiszTSWErP8FQZU8iIbFjtWOAeMrn0jOb
         vDEF2fP2YyxU7AwEi7X9+M1fSd4l/CgSwE6qxq5qXA4wkGNocL9Lm4fjkXd4juFtrBFN
         Fa1z7qPv/SBcfYzQYphBiI9Ry+dCWFJ/QsDiYMEuwo9HEPyK3x3Ph4FYvCJu16NZvUBF
         wQDesKRSWJFIXrNuaf35t9Y/PNDNmxkQM4GenDWju5Uw+i+4j2jyv0RscchVM3YEcEz3
         b4K5LNulGNvfHhnQ1HwMFhDEVCdDlggOktlv43s7Qse+syEBiDImwMVNQqAtcAH7Bhdn
         skjA==
X-Gm-Message-State: AOAM5305OUE1jaixzxS1XooQlY7D7MsbiOVGwN48l0L22VJnKVQMwJUB
        obOFfWZEv/ottVeUB/YTEmx57w==
X-Google-Smtp-Source: ABdhPJzmwDdQdJZYkqMgCmzJ797OU0IIxWxvObAsJTwZG25k6szK/iaUAY/XlxJUzfyic3/AZJaLJg==
X-Received: by 2002:a05:622a:103:: with SMTP id u3mr41722950qtw.187.1638819793415;
        Mon, 06 Dec 2021 11:43:13 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e20sm8095321qty.14.2021.12.06.11.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 11:43:12 -0800 (PST)
Date:   Mon, 6 Dec 2021 14:43:11 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] btrfs: reserve extra space for the free space tree
Message-ID: <Ya5nz3NiSdWuU3xE@localhost.localdomain>
References: <cover.1638477127.git.josef@toxicpanda.com>
 <18b2ae0948a035aa809ba38641439e2d4167ca29.1638477127.git.josef@toxicpanda.com>
 <Ya3po87VEgtlwdwD@debian9.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya3po87VEgtlwdwD@debian9.Home>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 06, 2021 at 10:44:51AM +0000, Filipe Manana wrote:
> On Thu, Dec 02, 2021 at 03:34:32PM -0500, Josef Bacik wrote:
> > Filipe reported a problem where sometimes he'd get an ENOSPC abort when
> > running delayed refs with generic/619 and the free space tree enabled.
> > This is partly because we do not reserve space for modifying the free
> > space tree, nor do we have a block rsv associated with that tree.
> > 
> > The delayed_refs_rsv tracks the amount of space required to run delayed
> > refs.  This means 1 modification means 1 change to the extent root.
> > With the free space tree this turns into 2 changes, because modifying 1
> > extent means updating the extent tree and potentially updating the free
> > space tree to either remove that entry or add the free space.  Thus if
> > we have the FST enabled, simply double the reservation size for our
> > modification.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/block-rsv.c   |  1 +
> >  fs/btrfs/delayed-ref.c | 22 ++++++++++++++++++++++
> >  2 files changed, 23 insertions(+)
> > 
> > diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> > index b3086f252ad0..b3ee49b0b1e8 100644
> > --- a/fs/btrfs/block-rsv.c
> > +++ b/fs/btrfs/block-rsv.c
> > @@ -426,6 +426,7 @@ void btrfs_init_root_block_rsv(struct btrfs_root *root)
> >  	switch (root->root_key.objectid) {
> >  	case BTRFS_CSUM_TREE_OBJECTID:
> >  	case BTRFS_EXTENT_TREE_OBJECTID:
> > +	case BTRFS_FREE_SPACE_TREE_OBJECTID:
> >  		root->block_rsv = &fs_info->delayed_refs_rsv;
> >  		break;
> >  	case BTRFS_ROOT_TREE_OBJECTID:
> > diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> > index da9d20813147..533521be8fdf 100644
> > --- a/fs/btrfs/delayed-ref.c
> > +++ b/fs/btrfs/delayed-ref.c
> > @@ -84,6 +84,17 @@ void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr)
> >  	u64 num_bytes = btrfs_calc_insert_metadata_size(fs_info, nr);
> >  	u64 released = 0;
> >  
> > +	/*
> > +	 * We have to check the mount option here because we could be enabling
> > +	 * the free space tree for the first time and don't have the compat_ro
> > +	 * option set yet.
> > +	 *
> > +	 * We need extra reservations if we have the free space tree because
> > +	 * we'll have to modify that tree as well.
> > +	 */
> > +	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
> > +		num_bytes <<= 1;
> > +
> >  	released = btrfs_block_rsv_release(fs_info, block_rsv, num_bytes, NULL);
> >  	if (released)
> >  		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
> > @@ -108,6 +119,17 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans)
> >  
> >  	num_bytes = btrfs_calc_insert_metadata_size(fs_info,
> >  						    trans->delayed_ref_updates);
> > +	/*
> > +	 * We have to check the mount option here because we could be enabling
> > +	 * the free space tree for the first time and don't have the compat_ro
> > +	 * option set yet.
> > +	 *
> > +	 * We need extra reservations if we have the free space tree because
> > +	 * we'll have to modify that tree as well.
> > +	 */
> > +	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
> > +		num_bytes <<= 1;
> 
> Don't we need to bump the minimum (limit variable) number of bytes at
> btrfs_delayed_refs_rsv_refill() as well?
> 
> I don't see why not.
> 

Because refill is about adding more space to keep up with usage.  We're not
adding space at that point.  These things here are to make sure ->size is
correct.  Refill is about making sure ->reserved == ->size.  In this case we're
just trying to add the smallest unit possible, min(1 items worth of
modificaitons, ->size - >reserved).  Thanks,

Josef
