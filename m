Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B1E6D8052
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 17:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbjDEPDA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 11:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238598AbjDEPCy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 11:02:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3657365BF
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 08:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680706915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ijdR/MHnRs9yin6C5jhmGmV2EeFx7fyGP+HaH521iTo=;
        b=WUTYMNAHwT9P6DLyzlLvQwky1xOg890lbUA/Z4uFCTdqjsYP4w6zRJeDUFZbqKMflg9hvo
        0b8Rkh+JQSY1HMj/vYgtFSTPhf7FAP7BTGcIlny9e4oeZTc3MRwG9sTYYDZJ2CIU3RM7yD
        VRGpMfOWgGQ0uUkkVaOTQFx2nvxusPQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-wfhvb-9EOaOY8EZuIYA8zg-1; Wed, 05 Apr 2023 11:01:54 -0400
X-MC-Unique: wfhvb-9EOaOY8EZuIYA8zg-1
Received: by mail-qv1-f72.google.com with SMTP id q1-20020ad44341000000b005a676b725a2so16322317qvs.18
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Apr 2023 08:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680706911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijdR/MHnRs9yin6C5jhmGmV2EeFx7fyGP+HaH521iTo=;
        b=tfmdaIQMTis4Lzgpp2VIa344xmP50uOowTb2CzJASYrwWlezLZ86lyXaWJpfIhxz3m
         a+uRkpgGVd65aavRJzWkYoAQu7s/ePwGcxj0G+M2PCLp+qCAsOMo6VcXktPKvOr5ArJi
         u9PLJCuHGPZ/aC/2jmVsIinAIZx871IbKywnRPZAY3l1zbFfQHcgHRa+oqwWXm7DvdO8
         NFrSrZ6vW0p9D3XpYdrtEhKS+/ebnMf9oaQQU5Ae9N6U9iDEbxqQTam6UpT4m/Gn7/8U
         tlsqgwljAnKY8c/jbhImGz/JtC1Uhz18/xt5M9HUvd7r5/OHJPEhKH9QtU2Yy52EZcPg
         qrIA==
X-Gm-Message-State: AAQBX9ep8I6zs+qHOOk/VYfVhc27JnkfUNozmUYTW4DjogxqaNqPxopw
        iIM9AqaWjzORPe0bmPtmhiZUv/9u0A454nhFzVN5C2yGi1PApZ5Uk/EZimIXl2ZtvbOaueccLfV
        gG47PTlBYcPO/mgOUPVeV9w==
X-Received: by 2002:a05:6214:2504:b0:5a3:cbc6:8145 with SMTP id gf4-20020a056214250400b005a3cbc68145mr11557262qvb.19.1680706910925;
        Wed, 05 Apr 2023 08:01:50 -0700 (PDT)
X-Google-Smtp-Source: AKy350YVeAhEKCJSk+gIHwjGx6PP08vlMKC4voUohfc6ezEBe0HN6HJNbkVZpy9LxJ1aS1g8D9uc0g==
X-Received: by 2002:a05:6214:2504:b0:5a3:cbc6:8145 with SMTP id gf4-20020a056214250400b005a3cbc68145mr11557235qvb.19.1680706910656;
        Wed, 05 Apr 2023 08:01:50 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id o8-20020a0cc388000000b005dd8b93457dsm4236165qvi.21.2023.04.05.08.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 08:01:49 -0700 (PDT)
Date:   Wed, 5 Apr 2023 17:01:42 +0200
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     dchinner@redhat.com, ebiggers@kernel.org, hch@infradead.org,
        linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
        rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 19/23] xfs: disable direct read path for fs-verity
 sealed files
Message-ID: <20230405150142.3jmxzo5i27bbc4c4@aalbersh.remote.csb>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-20-aalbersh@redhat.com>
 <20230404161047.GA109974@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404161047.GA109974@frogsfrogsfrogs>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 04, 2023 at 09:10:47AM -0700, Darrick J. Wong wrote:
> On Tue, Apr 04, 2023 at 04:53:15PM +0200, Andrey Albershteyn wrote:
> > The direct path is not supported on verity files. Attempts to use direct
> > I/O path on such files should fall back to buffered I/O path.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > ---
> >  fs/xfs/xfs_file.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > index 947b5c436172..9e072e82f6c1 100644
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -244,7 +244,8 @@ xfs_file_dax_read(
> >  	struct kiocb		*iocb,
> >  	struct iov_iter		*to)
> >  {
> > -	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
> > +	struct inode		*inode = iocb->ki_filp->f_mapping->host;
> > +	struct xfs_inode	*ip = XFS_I(inode);
> >  	ssize_t			ret = 0;
> >  
> >  	trace_xfs_file_dax_read(iocb, to);
> > @@ -297,10 +298,17 @@ xfs_file_read_iter(
> >  
> >  	if (IS_DAX(inode))
> >  		ret = xfs_file_dax_read(iocb, to);
> > -	else if (iocb->ki_flags & IOCB_DIRECT)
> > +	else if (iocb->ki_flags & IOCB_DIRECT && !fsverity_active(inode))
> >  		ret = xfs_file_dio_read(iocb, to);
> > -	else
> > +	else {
> > +		/*
> > +		 * In case fs-verity is enabled, we also fallback to the
> > +		 * buffered read from the direct read path. Therefore,
> > +		 * IOCB_DIRECT is set and need to be cleared
> > +		 */
> > +		iocb->ki_flags &= ~IOCB_DIRECT;
> >  		ret = xfs_file_buffered_read(iocb, to);
> 
> XFS doesn't usually allow directio fallback to the pagecache. Why
> would fsverity be any different?

Didn't know that, this is what happens on ext4 so I did the same.
Then it probably make sense to just error on DIRECT on verity
sealed file.

> 
> --D
> 
> > +	}
> >  
> >  	if (ret > 0)
> >  		XFS_STATS_ADD(mp, xs_read_bytes, ret);
> > -- 
> > 2.38.4
> > 
> 

-- 
- Andrey

