Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 607209692B
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2019 21:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfHTTMc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Aug 2019 15:12:32 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32799 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730088AbfHTTMb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Aug 2019 15:12:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id v38so1710qtb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2019 12:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=k63u3B7AhoOTq5HSdjeUreax738FiWQeFg9CY+QxMlQ=;
        b=dN027u6IW2XikH+ra0mc1E8WtAd51XS6Dx4UDpTTqCZGFYRUTZ9UDZwPto5HteUJIW
         rrFS8kHwv2m05NpAcUsa8IpAccZ4U1/AT5gxQUrzHH5rCS+YZOzShHR2abcG1HrRNVXc
         XMKoEqLvv7JbsuT76RnY4/sbh0lPEgSsh4wje1tapW51TRRs1cPGBqsU+TnlEYVIatbG
         gqpMLBkuURY3R1mdLLYYl4aof9fx3taSycBcuJyBGO9oY/V31DhaAcgdqRrJmtS/tD9B
         bdfIzLuZzKliyZ7MU6n5qosEi1NcfSD6YN+YWOd4aBLWu980lBW5ft9N2csSt6NjmeCQ
         Yk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=k63u3B7AhoOTq5HSdjeUreax738FiWQeFg9CY+QxMlQ=;
        b=gVqf1sFyMrxIp8FiSDZYnd4TSsPhac+tPREoiG7hOh9dkePjhN5qaBk2CZfKWIiiSZ
         1tbAJWeRayqlssqbFqjZEpH+tHuuuNOhUEi2tVdX6mZyYXXKfk8+I12otmXp/x40Qc5R
         m5lesaz7bfayBNfW5mYuP2v0xjiFArX3kF8WYO7rfopbhMD2iaw1OjS+BvNrz79qGxdf
         iY1bsqznfdhupJ6NO1VegoGBBygpJsZMGnthowTT4URtFyfNVUr/UzoLAhKl2L/9SCaA
         9SIGAwloBlWPbFCwj4NMIyhQ1QK/jiOAicj22ZZMRIBWjhO0jPDBOuzg2alQ+CmLwSDI
         R3cg==
X-Gm-Message-State: APjAAAX96jA1p4PP9Tnza+gyqcJ9zmAo6aKkF7/VPXV79QV+xhNYuARr
        LKRqf+aJqzI44ppUKCbRCP8bCA==
X-Google-Smtp-Source: APXvYqz0DnL92PeZS9bAeGTzIIBmk8rmTvpjhW6ZXVuhPIGP0Lg3BngE7JXGaiUlqUqG1g0yveHg5w==
X-Received: by 2002:ac8:4117:: with SMTP id q23mr28197120qtl.305.1566328350398;
        Tue, 20 Aug 2019 12:12:30 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u45sm9434391qta.13.2019.08.20.12.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 12:12:29 -0700 (PDT)
Date:   Tue, 20 Aug 2019 15:12:28 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/5] btrfs: change the minimum global reserve size
Message-ID: <20190820191227.xukyhs3idfemila2@MacBook-Pro-91.local>
References: <20190816152019.1962-1-josef@toxicpanda.com>
 <20190816152019.1962-2-josef@toxicpanda.com>
 <761ca884-2f9a-dc44-65db-d9a4db61bf78@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <761ca884-2f9a-dc44-65db-d9a4db61bf78@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 20, 2019 at 04:45:15PM +0300, Nikolay Borisov wrote:
> 
> 
> On 16.08.19 г. 18:20 ч., Josef Bacik wrote:
> > It made sense to have the global reserve set at 16M in the past, but
> > since it is used less nowadays set the minimum size to the number of
> > items we'll need to update the main trees we update during a transaction
> > commit, plus some slop area so we can do unlinks if we need to.
> > 
> > In practice this doesn't affect normal file systems, but for xfstests
> > where we do things like fill up a fs and then rm * it can fall over in
> > weird ways.  This enables us for more sane behavior at extremely small
> > file system sizes.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/block-rsv.c | 22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> > index c64b460a4301..657675eef443 100644
> > --- a/fs/btrfs/block-rsv.c
> > +++ b/fs/btrfs/block-rsv.c
> > @@ -258,6 +258,7 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
> >  	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
> >  	struct btrfs_space_info *sinfo = block_rsv->space_info;
> >  	u64 num_bytes;
> > +	unsigned min_items;
> >  
> >  	/*
> >  	 * The global block rsv is based on the size of the extent tree, the
> > @@ -267,7 +268,26 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
> >  	num_bytes = btrfs_root_used(&fs_info->extent_root->root_item) +
> >  		btrfs_root_used(&fs_info->csum_root->root_item) +
> >  		btrfs_root_used(&fs_info->tree_root->root_item);
> > -	num_bytes = max_t(u64, num_bytes, SZ_16M);
> > +
> > +	/*
> > +	 * We at a minimum are going to modify the csum root, the tree root, and
> > +	 * the extent root.
> > +	 */
> > +	min_items = 3;
> > +
> > +	/*
> > +	 * But we also want to reserve enough space so we can do the fallback
> > +	 * global reserve for an unlink, which is an additional 5 items (see the
> > +	 * comment in __unlink_start_trans for what we're modifying.)
> > +	 *
> > +	 * But we also need space for the delayed ref updates from the unlink,
> > +	 * so its 10, 5 for the actual operation, and 5 for the delayed ref
> > +	 * updates.
> > +	 */
> > +	min_items += 10;
> > +
> > +	num_bytes = max_t(u64, num_bytes,
> > +			  btrfs_calc_insert_metadata_size(fs_info, min_items));
> 
> For ordinary, 16k nodesize filesystem, btrfs_calc_insert_metadata_size
> will really return 3.4m -> 16 * 8 * 2 * 13 * 1024 = 3407872 bytes . In
> those cases I expect that the code will always be doing num_bytes =
> num_bytes.
> 

Right, generally this will always be num_bytes = num_bytes.  This is mostly for
things like xfstests which start with empty fs's and then fill up the fs with
data, so you only have like 200kib of metadata ever, so it ends up being the
btrfs_calc_insert_metadat_size() amount.  Thanks,

Josef
