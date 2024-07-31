Return-Path: <linux-btrfs+bounces-6911-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F271943134
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 15:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44469280F76
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 13:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2D91B29A9;
	Wed, 31 Jul 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="rUcLQHb1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EA61A7F9D
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433553; cv=none; b=Q+PVDSx6G4+2nPtgCGZOcN+S0aDrOvrn2rn6wnEJYlqbvqvKi88+56cX2V5tQMiMKWjKXOC6teskV4RZpDfpwoKC4jj6Wvtdo2F81J1wGqfs0dfNNlnvBfQ/IERFi0WLhASjUENHjgu9uOnV5RL6M7USGSstnMJRsA1t0rH6+0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433553; c=relaxed/simple;
	bh=hXQd9C7HYrLm7GbcHWIFRZmovEP5MgIKeBzhOvqYO04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeVfiBIb1t9W60qwngtNkqSHa3lm6Sa6qE9V9PwZKYn1KTFO10Yl7nAk6QOkiiqjxRFvDTyIYQKruiQpF2gdebJnQVUfkEbNFAX3YShgOQMjRxsByqt0m7jaWHP72bVBq3BQULXSmSRLQ7n0W7H0yNz7K7jD1jVZKsVT5cB0TsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=rUcLQHb1; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44ff398cefcso31627891cf.0
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 06:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722433550; x=1723038350; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6rHIOlaodnbC/RexBlhzdkz8Ph+8L3UQTAUEAijrV1c=;
        b=rUcLQHb1QBjRXhr5X2JRr/muNYnAL4BtvL3aueiQGyFpJ5hrovglhZat3booWv+Ixi
         WytJI3+H23Y5ef6y/Rtafn1Aw/y2GsaysAOEJth7WjaT0jkOPH1HjgorpwqtF1KFC56F
         6TMQTbUpvEI2BsoSnq3HA7uxJgG/gKhtqJzatSSNoibD6Risq7yZ5Ms7gwpXUwhIOUQY
         oOoobRxWCYzUcpOl5odiMWxZ1PlbP+2XcYnGJ32J3R6B9pj91aX26TJRq4OJLcw9F2EJ
         7CTZIfRLeu/wfMW8wAWopwHmlb3BS56XPk3CKeFDieY0ccJb0P2dmXc/AENSuD+m9Zw7
         cPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722433550; x=1723038350;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rHIOlaodnbC/RexBlhzdkz8Ph+8L3UQTAUEAijrV1c=;
        b=LnBmdBocHeaiKUkg0ZNpvgc4OqYWmZquziRMRlkPXVlK+FPE2uBkF8BxFrB5axIS2d
         TfFGfcJGDG476jG+Zj7yG4F5RUnB+KjwLx/PvupSC0dF/VWDYPXwQu+C+hmboKivDtjr
         j/dxqMGMrS6EvYSrDKIlDjjI6U90XoI1nFdz/a92CR/Lb4f50X+sxiCcGLdSPh3Aldzb
         7hDeQ03F4WbDV30cNL/qWaFsf1i/uLdBnRMXzI02WuqRpInw3tsDPnA0o/lENv8+4g+E
         4LBUrxgIP4Yvsel/ZBLP58uB97mIeMoi0OOOdnt6s4bB4IrGqSzJAK5OsyVmKbwMt7js
         M6bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrUC7k83uRLb2KLg9CpTXj5htU/5iohQQcI+1a4/ceWoCKFWeXgSxbNEIUp/Ub4In23rXVzuXO42GhryzhaVX8Ngj1cz2g1qe7POc=
X-Gm-Message-State: AOJu0Yx1uG+DpAQPaRGpHEivnB8PkBXy8lmctL8GwMinS5d6u7AnlXe5
	vzUZA07rFeKouP3XNbL20wt12CvpWUNs3fSHrPNzYnSty8D05+vRfCVpsB5Qg+c=
X-Google-Smtp-Source: AGHT+IFV5OqnmKrwHHT8skO5IC3p5gNPZW0Y/PTuf8qhzatYvXo9IipwtEUS6+2XjUwmqkKJ0ZyWUg==
X-Received: by 2002:a05:622a:15d1:b0:446:5864:33b1 with SMTP id d75a77b69052e-45004f2e050mr176012591cf.40.1722433550437;
        Wed, 31 Jul 2024 06:45:50 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8201775sm58800311cf.75.2024.07.31.06.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:45:50 -0700 (PDT)
Date: Wed, 31 Jul 2024 09:45:49 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: add --subvol option to mkfs.btrfs
Message-ID: <20240731134549.GA3908975@perftesting>
References: <20240730093833.1169945-1-maharmstone@fb.com>
 <d67ca8a6-9b5f-4ba1-aae3-70e1cb22ecda@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d67ca8a6-9b5f-4ba1-aae3-70e1cb22ecda@gmx.com>

On Tue, Jul 30, 2024 at 07:25:29PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/7/30 19:08, Mark Harmstone 写道:
> > This patch adds a --subvol option, which tells mkfs.btrfs to create the
> > specified directories as subvolumes.
> > 
> > Given a populated directory img, the command
> > 
> > $ mkfs.btrfs --rootdir img --subvol img/usr --subvol img/home --subvol img/home/username /dev/loop0
> > 
> > will create subvolumes usr and home within the FS root, and subvolume
> > username within the home subvolume. It will fail if any of the
> > directories do not yet exist.
> > 
> > Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> 
> Unfortunately I'm still not a fan of splitting the handling of subvolume
> and directory creation.
> 
> Why not go a hashmap to save all the subvolume paths, and check if a
> directory should be a subvolume, then go btrfs_make_subvolume() and
> btrfs_link_subvolume() inside that context?
> 

We don't have a hashmap readily available, and btrfs_make_subvolume() has to be
done before we rebuild the UUID tree, otherwise we won't get the UUID entries.
You're asking for a good deal of work ontop of an already relatively large
patch.

<snip>

> > diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
> > index 2b39f6bb..e3e576b2 100644
> > --- a/mkfs/rootdir.c
> > +++ b/mkfs/rootdir.c
> > @@ -184,17 +184,58 @@ static void free_namelist(struct dirent **files, int count)
> >   	free(files);
> >   }
> > 
> > -static u64 calculate_dir_inode_size(const char *dirname)
> > +static u64 calculate_dir_inode_size(const char *src_dir,
> > +				    struct list_head *subvol_children,
> > +				    const char *dest_dir)
> 
> And before the --subvolume option, I'm more intesrested in getting rid
> of the function completely.
> 
> Instead, if we go something like the following, there will be no need to
> calculate the dir inode size:
> 
> - Create a new inode/subvolume
> - Link the new inode to the parent inode
> 
> As btrfs_link_inode()/btrfs_link_subvolume() would handle the increase
> of inode size.
> 
> As long as we're only using btrfs_link_inode() and
> btrfs_link_subvolume(), then there is no need to go this function.
> 
> Furthermore it would make the whole opeartion more like a regular copy
> (although implemented in progs), other than some specific btrfs hacks
> just to pass the pretty strict "btrfs check".

This is legitimate follow up work, but this thing exists today.  We have a long
standing policy that gating peoples work on cleanups and refactors is generally
unhelpful and demoralizing behavior.  I agree this needs to be reworked, but
that's out of scope for this particular patchset.

That being said this will be the next thing that Mark tackles.  Is that
acceptable?  Thanks,

Josef

