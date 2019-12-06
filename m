Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD0211540E
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 16:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfLFPRm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 10:17:42 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41037 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfLFPRm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 10:17:42 -0500
Received: by mail-qt1-f193.google.com with SMTP id v2so7429815qtv.8
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 07:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g1N0JPNJVJWsJJaFy1FOBFkR1++V4jh8Zz8NIhenl0A=;
        b=JGb1dMRAo40Zy7bRzhe7D0gO567VBmoCHe1tsnOtkopjuj8xrZ4bbfURX5zuPZ6ZPW
         HGLbIgEj5QszH5EzQdA+NhbjaTCNsY0cAcwI9wGNBmHbyH4LNd4YLSM+cKCLuXnmDes0
         xWSRSlRI5PaoU9rJHTwuBIhw4R9eCY+h9A1HkfznCS0o0QeSVeC2W3FBBQdaOO1lJhhx
         mpyn0Awf06B5Oj90V6nNg8YOaLakmk2U9UVs6e9id7th5/KbutQ6OOh3K/xRc9AZcF3A
         Ugzki8+HeMPAOOHZsL3RTQ+2oyQdYZsKfe09CeNNaElxXuxvubfOG5AKzZ5kBrgS0MoZ
         PL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g1N0JPNJVJWsJJaFy1FOBFkR1++V4jh8Zz8NIhenl0A=;
        b=sR7qJhvafDq1hwJLvvWd3f5fRa/uiXRSGBrJ619p9ZSKEr6Jf78iCzE9h4z4/cDaKs
         hG9OabBpZRa3BWuMTS5AQ6s+JVP/LRPnR1OqflSsarcymgwt1kkfUX4I88VuiDJVBeZJ
         1U8bRHLu49MqflMdHQkK4LBW74aUfi2WRz4Il2N+FPmqnEZq8VpQCETJfFJC2PWAoV7p
         lCMOAHNS7/z1owccP7uHMZivbFQ9D04dTKFSAxIfu4HRkSpWNDj4i9AQG1ZqOYNFwEwh
         Uk175tbC2IVI1gC+VypI+KpBPk9LOnseZHZSEGOk5/IZwoPop4xxfwSJ8iABQspJvJCH
         v2QA==
X-Gm-Message-State: APjAAAX/3xY1E6UmqFDZp/XnJazChUheKIcMe/kGp9AUl1nny/SjubT8
        obVcT+qcfSi9YUKW+CSacnrwrg==
X-Google-Smtp-Source: APXvYqyigy4HuR1WDzvgTAnHVOg59lIDWcjWBLtWQpfs5ty/b7Q3Z6M4FcAvOIUkkxqdh4jKqQQ2Zw==
X-Received: by 2002:aed:2a74:: with SMTP id k49mr7080064qtf.289.1575645461258;
        Fri, 06 Dec 2019 07:17:41 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j2sm5826624qka.88.2019.12.06.07.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 07:17:29 -0800 (PST)
Date:   Fri, 6 Dec 2019 10:17:28 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH 3/5] btrfs: handle ENOENT in btrfs_uuid_tree_iterate
Message-ID: <20191206151728.pba2exthz5uxnmne@jbacik-mbp>
References: <20191206143718.167998-1-josef@toxicpanda.com>
 <20191206143718.167998-4-josef@toxicpanda.com>
 <CAL3q7H6BfCF1fN8Wtn=k2-oWFoqojiGjkKZ5q2O=wWXbuEyfYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H6BfCF1fN8Wtn=k2-oWFoqojiGjkKZ5q2O=wWXbuEyfYg@mail.gmail.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 06, 2019 at 03:13:21PM +0000, Filipe Manana wrote:
> On Fri, Dec 6, 2019 at 2:38 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > If we get an -ENOENT back from btrfs_uuid_iter_rem when iterating the
> > uuid tree we'll just continue and do btrfs_next_item().  However we've
> > done a btrfs_release_path() at this point and no longer have a valid
> > path.  So increment the key and go back and do a normal search.
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/uuid-tree.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
> > index 91caab63bdf5..8871e0bb3b69 100644
> > --- a/fs/btrfs/uuid-tree.c
> > +++ b/fs/btrfs/uuid-tree.c
> > @@ -324,6 +324,8 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info,
> >                                 }
> >                                 if (ret < 0 && ret != -ENOENT)
> >                                         goto out;
> > +                               key.objectid++;
> 
> Why not key.offset++ instead?
> By incrementing the objectid it seems we can skip the key for another
> subvolume with an uuid having the same value for its first 8 bytes as
> the current one, no?

Oops you're right, I had it in my head the objectid was the subvolid.  I'll fix
this, thanks,

Josef
