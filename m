Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72B07989DF
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 17:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244574AbjIHPYA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 11:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244559AbjIHPX7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 11:23:59 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F41D212E
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 08:23:34 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-6535b9caa1eso16180956d6.0
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 08:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694186613; x=1694791413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9QXbEbd8jFAd37eMpkCBWjfvRjiFVOeiVrW04g0mrH0=;
        b=3EJEbJwRjljZad+hh6LRQYjBWFV6c0WTBpDiOlaT2zKkWaimI7YYWaAlZo1fNuKLhz
         FAQRFp4SqiXhcC/LvGDDMlPMWzHpGz5Aal2zSXikOorvVB4xVFHKOXmRdh+1xb3pyMte
         5o46C+p0qsuZBqQBOE4WQoca2s4ceQfAdYg6A6QbMd9hvFUaVIUM7a7ShdRYaZfAvi5e
         EH6wpThSOHHIu6R/MkF7bRykFYsplgXksKgotRWasa3+oWU23zuO2188R/cJS4yxMatz
         V42XigJiogP9uOfkEVJ8EayRN3EF8bS43HV7KQt83QhGSDDabU1Www6kVQFra0oc+eYM
         M23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694186613; x=1694791413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QXbEbd8jFAd37eMpkCBWjfvRjiFVOeiVrW04g0mrH0=;
        b=NYEHDw6We8lIFSThqH5gsU1MN2RORPQ61jHGIfz93eQYrQgr7/wVahA5KCscXQMfSr
         6Gwmdyo4dFrFODFT7/NcTur9ozMa2StTnaytBvM4iU5Dif0+FAWEhYCnYnjZbyHOjT/O
         tbve/AB7tLUFxHbg51Q7EgKK1aPQr9aISml2NhUZBuTddPGUc/FLK1/HayqBRujgpohE
         BMlZEPDN3lsTNI41mtrEeC+XRdjb+FrUEdw1+Rnx0gdMVcVULV/5Sv01Wgi2IPh5g/4f
         0pr9hEKvOWkKdkurTVYSCbeuQahhfY6fPK79TxSCqi79TT03/AsuWHvnPpS2j0MdwpWn
         fpKg==
X-Gm-Message-State: AOJu0YyB/HSr7XI2Zuz9smtfsNZivqM6/68z5bPxJby001FfMf3fT8tN
        ScIKUN5b7vsBwmPeT+dS+8UAbYkXpUSseyQVPhaeXA==
X-Google-Smtp-Source: AGHT+IE59I7p4/ajKWLiep6ZhPv/AGRwdKiZh/KaXBKLk3JWmlGciFs/+UeSevwvwnMSEmZbou7TVg==
X-Received: by 2002:a0c:df01:0:b0:647:3346:1289 with SMTP id g1-20020a0cdf01000000b0064733461289mr3343511qvl.11.1694186613506;
        Fri, 08 Sep 2023 08:23:33 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id cx19-20020a05620a51d300b0076f12fcb0easm659986qkb.2.2023.09.08.08.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 08:23:33 -0700 (PDT)
Date:   Fri, 8 Sep 2023 11:23:32 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 18/21] btrfs: reserve space for delayed refs on a per ref
 basis
Message-ID: <20230908152332.GT1977092@perftesting>
References: <cover.1694174371.git.fdmanana@suse.com>
 <5a882a00e4a3f39ecb6c2389ebc749acefadf1ab.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a882a00e4a3f39ecb6c2389ebc749acefadf1ab.1694174371.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 01:09:20PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently when reserving space for delayed refs we do it on a per ref head
> basis. This is generally enough because most back refs for an extent end
> up being inlined in the extent item - with the default leaf size of 16K we
> can have at most 33 inline back refs (this is calculated by the macro
> BTRFS_MAX_EXTENT_ITEM_SIZE()). The amount of bytes reserved for each ref
> head is given by btrfs_calc_delayed_ref_bytes(), which basically
> corresponds to a single path for insertion into the extent tree plus
> another path for insertion into the free space tree if it's enabled.
> 
> However if we have reached the limit of inline refs or we have a mix of
> inline and non-inline refs, then we will need to insert a non-inline ref
> and update the existing extent item to update the total number of
> references for the extent. This implies we need reserved space for two
> insertion paths in the extent tree, but we only reserved for one path.
> The extent item and the non-inline ref item may be located in different
> leaves, or even if they are located in the same leaf, after updating the
> extent item and before inserting the non-inline ref item, the extent
> buffers in the btree path may have been written (due to memory pressure
> for e.g.), in which case we need to COW the entire path again. In this
> case since we have not reserved enough space for the delayed refs block
> reserve, we will use the global block reserve.
> 
> If we are in a situation where the fs has no more unallocated space enough
> to allocate a new metadata block group and available space in the existing
> metadata block groups is close to the maximum size of the global block
> reserve (512M), we may end up consuming too much of the free metadata
> space to the point where we can't commit any future transaction because it
> will fail, with -ENOSPC, during its commit when trying to allocate an
> extent for some COW operation (running delayed refs generated by running
> delayed refs or COWing the root tree's root node at commit_cowonly_roots()
> for example). Such dramatic scenario can happen if we have many delayed
> refs that require the insertion of non-inline ref items, due to too many
> reflinks or snapshots. We also have situations where we use the global
> block reserve because we could not in advance know that we will need
> space to update some trees (block group creation for example), so this
> all adds up to increase the chances of exhausting the global block reserve
> and making any future transaction commit to fail with -ENOSPC and turn
> the fs into RO mode, or fail the mount operation in case the mount needs
> to start and commit a transaction, such as when we have orphans to cleanup
> for example - such case was reported and hit by someone running a SLE
> (SUSE Linux Enterprise) distribution for example - where the fs had no
> more unallocated space that could be used to allocate a new metadata block
> group, and the available metadata space was about 1.5M, not enough to
> commit a transaction to cleanup an orphan inode (or do relocation of data
> block groups that were far from being full).
> 
> So reserve space for delayed refs by individual refs and not by ref heads,
> as we may need to COW multiple extent tree paths due to non-inline ref
> items.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
