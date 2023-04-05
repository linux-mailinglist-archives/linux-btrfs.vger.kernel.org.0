Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C836D8A68
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 00:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjDEWLb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 18:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjDEWLY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 18:11:24 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5B47AA0
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 15:10:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so38757770pjb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Apr 2023 15:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1680732643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B//xqY4ihi9FjKHnI/3HItAd5zkVskGSEhbTE9KO+uM=;
        b=STgTGHnum63TLfzSA43g0jKvWgwzTlnLbiRBsWUDeVndg2q0Tgh+Q3SOrbj2o7vE8S
         OqWTQe02GPPEl+JqPtH+BqPfmvs//jeLjVwIl0XhMyQ3tek4wkSILn+nMJgz4Ucj0eU6
         j0kbTbgibsNwkwrKvah9VMelOuBXgvxgwHI0pALQfzh2rVeht1RKj8+pbzrOR/bp501l
         L/VGUA0YqBD4tzXgV0KmZb3YviN4H/dsXP/5STmaPKBN43t4NUaSN54t71hCcI0H1oaq
         zP9YTNcdWyFHeWlBYJ4HXGKqXy09Gf/KRy8kJqqXI11hkg8FYce95UQ1oCAGXdz0Kzst
         BsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680732643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B//xqY4ihi9FjKHnI/3HItAd5zkVskGSEhbTE9KO+uM=;
        b=lsvksW0/l+cl6xL3Au+VZWCDqA0FZ4KjW6zv2qcJlwPxjU5nnoMY/xxAvhks1C7LSV
         QBsh7zQO/hGADWWxnZnkbNteyHjxhEyjBJpFtQSpcMfu7mMtOPo2wJbljgBvccFDaDbc
         h8jtZvoxdW2mBG1uk0X5OAOyzwA9tBFXWjSewSX+0QvtgZrQiL1DN88J16MjsHo9UbC/
         tzaTgm/VREL77iV32nT1AjNHrPCVT/nLvINcl5duJqqt53EBas3GhnnLPX1ikUjBpry1
         E89D/8bvuULXw8+K7ovzSC+/15oEROWqdJQ9cqMKYCVbdzzi9Hfes5+NHyYFkczFwDBz
         OgmA==
X-Gm-Message-State: AAQBX9fCA2U8LNQGGJ29bSFz3MIF8gmqSks9sqhDo2/h3KMfD+M9Ydfq
        xeJSy2HI9OCj/tKtCc8cFIzkvA==
X-Google-Smtp-Source: AKy350bUfWmomBUgOSKakyDoihBlbriDnLkKr+maH+SmOymveI4bbkcZZJHlbNIaaMvcTwEjmj518w==
X-Received: by 2002:a05:6a20:b213:b0:e1:2d3d:6b11 with SMTP id eh19-20020a056a20b21300b000e12d3d6b11mr798344pzb.11.1680732643261;
        Wed, 05 Apr 2023 15:10:43 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-91-157.pa.nsw.optusnet.com.au. [49.181.91.157])
        by smtp.gmail.com with ESMTPSA id f9-20020a631009000000b004ff6b744248sm9594682pgl.48.2023.04.05.15.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 15:10:42 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pkBKx-00HUPP-6E; Thu, 06 Apr 2023 08:10:39 +1000
Date:   Thu, 6 Apr 2023 08:10:39 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andrey Albershteyn <aalbersh@redhat.com>, dchinner@redhat.com,
        ebiggers@kernel.org, hch@infradead.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev, rpeterso@redhat.com, agruenba@redhat.com,
        xiang@kernel.org, chao@kernel.org,
        damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com
Subject: Re: [PATCH v2 19/23] xfs: disable direct read path for fs-verity
 sealed files
Message-ID: <20230405221039.GP3223426@dread.disaster.area>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-20-aalbersh@redhat.com>
 <20230404161047.GA109974@frogsfrogsfrogs>
 <20230405150142.3jmxzo5i27bbc4c4@aalbersh.remote.csb>
 <20230405150927.GD303486@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405150927.GD303486@frogsfrogsfrogs>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 05, 2023 at 08:09:27AM -0700, Darrick J. Wong wrote:
> On Wed, Apr 05, 2023 at 05:01:42PM +0200, Andrey Albershteyn wrote:
> > On Tue, Apr 04, 2023 at 09:10:47AM -0700, Darrick J. Wong wrote:
> > > On Tue, Apr 04, 2023 at 04:53:15PM +0200, Andrey Albershteyn wrote:
> > > > The direct path is not supported on verity files. Attempts to use direct
> > > > I/O path on such files should fall back to buffered I/O path.
> > > > 
> > > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > > ---
> > > >  fs/xfs/xfs_file.c | 14 +++++++++++---
> > > >  1 file changed, 11 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > > index 947b5c436172..9e072e82f6c1 100644
> > > > --- a/fs/xfs/xfs_file.c
> > > > +++ b/fs/xfs/xfs_file.c
> > > > @@ -244,7 +244,8 @@ xfs_file_dax_read(
> > > >  	struct kiocb		*iocb,
> > > >  	struct iov_iter		*to)
> > > >  {
> > > > -	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
> > > > +	struct inode		*inode = iocb->ki_filp->f_mapping->host;
> > > > +	struct xfs_inode	*ip = XFS_I(inode);
> > > >  	ssize_t			ret = 0;
> > > >  
> > > >  	trace_xfs_file_dax_read(iocb, to);
> > > > @@ -297,10 +298,17 @@ xfs_file_read_iter(
> > > >  
> > > >  	if (IS_DAX(inode))
> > > >  		ret = xfs_file_dax_read(iocb, to);
> > > > -	else if (iocb->ki_flags & IOCB_DIRECT)
> > > > +	else if (iocb->ki_flags & IOCB_DIRECT && !fsverity_active(inode))
> > > >  		ret = xfs_file_dio_read(iocb, to);
> > > > -	else
> > > > +	else {
> > > > +		/*
> > > > +		 * In case fs-verity is enabled, we also fallback to the
> > > > +		 * buffered read from the direct read path. Therefore,
> > > > +		 * IOCB_DIRECT is set and need to be cleared
> > > > +		 */
> > > > +		iocb->ki_flags &= ~IOCB_DIRECT;
> > > >  		ret = xfs_file_buffered_read(iocb, to);
> > > 
> > > XFS doesn't usually allow directio fallback to the pagecache. Why
> > > would fsverity be any different?
> > 
> > Didn't know that, this is what happens on ext4 so I did the same.
> > Then it probably make sense to just error on DIRECT on verity
> > sealed file.
> 
> Thinking about this a little more -- I suppose we shouldn't just go
> breaking directio reads from a verity file if we can help it.  Is there
> a way to ask fsverity to perform its validation against some arbitrary
> memory buffer that happens to be fs-block aligned?

The memory buffer doesn't even need to be fs-block aligned - it just
needs to be a pointer to memory the kernel can read...

We also need fsverity to be able to handle being passed mapped
kernel memory rather than pages/folios for the merkle tree
interfaces. That way we can just pass it the mapped buffer memory
straight from the xfs-buf and we don't have to do the whacky "copy
from xattr xfs_bufs into pages so fsverity can take temporary
reference counts on what it thinks are page cache pages" as it walks
the merkle tree.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
