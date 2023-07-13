Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DF1752BBF
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 22:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjGMUhJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 16:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjGMUhH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 16:37:07 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD01B2119
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 13:37:06 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-57a551ce7e9so10671397b3.3
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 13:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689280626; x=1691872626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g+Rf2Xy4kX66VX5h8ovv98VvVDb9FBF99bAbUPo1n0E=;
        b=1SMgpCFhOmQFZbNQ62MDE0OZ3dDYm/jIjEFM85Tu5yYa1jAew5T5hHTxGjwXE4ivg6
         a+wq1aCQgShCvKJaBePtxD+8p5lIbMEn32aIBD7k6NcHJWzqpja3UbB9t9MvQ0Un7IMv
         IwbbBGtq3YrKoLSPflsaSQZJO1U/OoGZYW113FXs7LzWZsmR0mmEyGVt5Rx7L9v+gxFS
         zPzj63cT9mpvog1S1IzlZB3+BR6xYLbqquXzD9NOqFWAks53jTyTJB/FVAz4hebfrY9H
         mCxkIenjTDQEJhRcFL9wWW5rOb23Q4JhvGgu817RhVVe/bE3EyXoV3cwYhLvZJzvI7ik
         aPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689280626; x=1691872626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+Rf2Xy4kX66VX5h8ovv98VvVDb9FBF99bAbUPo1n0E=;
        b=j69vE64fQYrx8Eze1gBcn7JN3lAVdVdc58df6JNSym05RnZrB3NNAZvvnz3N9XP+cQ
         nNBIFc3oGktOO4jGueEPyKivRMleVKy3fzDvqi6mbTAn2ZoGPaGti9KQt44S/ktl0EFu
         eXEYuFgcwwJXDY9mBO3q11nugCtYMaZkRBrpjWb5DDVDuk8Dps+1rXmjIl02d8edhryK
         YAwvlyIHvCqsufyOSwBv4tGX5MZU1vms8pNX/AdMb9oRaxclmUjaHO9EX0aNGgQanFfn
         EHemvf75cMEVvXS/TiW2814JqQ/W7X6pIOBP5ojcQWw+7bsVcpvdmWaiQ8JgGhq7W1W2
         f04w==
X-Gm-Message-State: ABy/qLa4KeQ6cvt6q0m78Oi4y1DxJH1RGGFWFmuLnA93zoz1h9ndN8uT
        qXt18GkzcZfL8bco9IVZhagl7W6GrG9YdGmHdEyB6Q==
X-Google-Smtp-Source: APBJJlECIfYgpOnjuQn9U+GLdJ8ibSA35YCfKK6iIaB1+Le+dnP329aPzNds3e4i/evc7ORNQz7XMA==
X-Received: by 2002:a81:488e:0:b0:579:e374:c915 with SMTP id v136-20020a81488e000000b00579e374c915mr2945996ywa.37.1689280625854;
        Thu, 13 Jul 2023 13:37:05 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id s126-20020a0dd084000000b0057a918d6644sm1925266ywd.128.2023.07.13.13.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 13:37:05 -0700 (PDT)
Date:   Thu, 13 Jul 2023 16:37:04 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 07/18] btrfs: create qgroup earlier in snapshot creation
Message-ID: <20230713203704.GB338010@perftesting>
References: <cover.1688597211.git.boris@bur.io>
 <5aff5ceb6555f8026f414c4de9341c698837820b.1688597211.git.boris@bur.io>
 <20230713142600.GG207541@perftesting>
 <20230713190042.GA2626930@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713190042.GA2626930@zen>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 13, 2023 at 12:00:42PM -0700, Boris Burkov wrote:
> On Thu, Jul 13, 2023 at 10:26:00AM -0400, Josef Bacik wrote:
> > On Wed, Jul 05, 2023 at 04:20:44PM -0700, Boris Burkov wrote:
> > > Pull creating the qgroup earlier in the snapshot. This allows simple
> > > quotas qgroups to see all the metadata writes related to the snapshot
> > > being created and to be born with the root node accounted.
> > > 
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > >  fs/btrfs/qgroup.c      | 3 +++
> > >  fs/btrfs/transaction.c | 5 +++++
> > >  2 files changed, 8 insertions(+)
> > > 
> > > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > > index 75afd8212bc0..8419270f7417 100644
> > > --- a/fs/btrfs/qgroup.c
> > > +++ b/fs/btrfs/qgroup.c
> > > @@ -1670,6 +1670,9 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
> > >  	struct btrfs_qgroup *qgroup;
> > >  	int ret = 0;
> > >  
> > > +	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
> > > +		return 0;
> > > +
> > >  	mutex_lock(&fs_info->qgroup_ioctl_lock);
> > >  	if (!fs_info->quota_root) {
> > >  		ret = -ENOTCONN;
> > > diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> > > index f644c7c04d53..2bb5a64f6d84 100644
> > > --- a/fs/btrfs/transaction.c
> > > +++ b/fs/btrfs/transaction.c
> > > @@ -1716,6 +1716,11 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
> > >  	}
> > >  	btrfs_release_path(path);
> > >  
> > > +	ret = btrfs_create_qgroup(trans, objectid);
> > > +	if (ret) {
> > > +		btrfs_abort_transaction(trans, ret);
> > > +		goto fail;
> > > +	}
> > 
> > Newline please.
> > 
> > How is this ok with normal qgroups?  We weren't creating a qgroup at snapshot
> > creation time at all it seems, so I don't understand how this is ok for qgroups.
> 
> qgroup_account_snapshot calls btrfs_qgroup_inherit which contains a
> separate implementation of qgroup creation.

Which it still does, so I'm confused as to how this is ok.  How do we not get an
EEXIST when we do the btrfs_qgroup_inherit?  Thanks,

Josef
