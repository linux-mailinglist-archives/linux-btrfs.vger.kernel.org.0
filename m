Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2607BB165
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 08:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjJFGJi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 02:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjJFGJg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 02:09:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA39EB;
        Thu,  5 Oct 2023 23:09:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B51AC433C7;
        Fri,  6 Oct 2023 06:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696572573;
        bh=G8Hr61XyhN48LY0zEnOoUC94uGeFK6xXfyuxpr5bh48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eFSUCjrtC5llgPDm9VHh1Ws37662AZ3RO5wLwoHKOSUCyv8Nozj+z4aOVuSbmfdi9
         Mw2dsH9897hSyVWuPdjFgmQmzasYl2nkJLzidLme7KB2Rl2hSqYIec84MRA2FGZXFA
         NDiyg0HvKT9E85r7NVreEMSPnIQ0A5JjSWku+WW0RlQvpnmFByRRu3ky29xF8s34uN
         lT5FglM174S4preFHR2DDdr7O6p4OU0HU1kEJU1FXpf4EhkB9lmS4/vxJwZJi41ffo
         qSRdPEoJEZs/H/gdS00LyI25GJMnFpdC17FhUTaivX30VmPe785QcWlgsN+4CR/4sA
         GJCdvXViq3MFQ==
Date:   Thu, 5 Oct 2023 23:09:32 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, david@fromorbit.com
Subject: Re: [PATCH 2/2] fstests: add configuration option for executing post
 mkfs commands
Message-ID: <20231006060932.GD21283@frogsfrogsfrogs>
References: <cover.1695543976.git.anand.jain@oracle.com>
 <eff4da60fe7a6ce56851d5fc706b5f2f2d772c56.1695543976.git.anand.jain@oracle.com>
 <dfc4cece-d809-4b5b-93f7-7251ba3a492a@gmx.com>
 <5485cd32-2308-c9c5-4c97-9ff6c74c64dd@oracle.com>
 <0a8d40fc-501e-4d85-903a-83d9b3508bf5@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a8d40fc-501e-4d85-903a-83d9b3508bf5@gmx.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 28, 2023 at 05:10:25PM +0930, Qu Wenruo wrote:
> 
> 
> On 2023/9/28 15:04, Anand Jain wrote:
> > 
> > 
> > On 28/09/2023 12:26, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2023/9/28 13:53, Anand Jain wrote:
> > > > This patch introduces new configuration file parameters,
> > > > POST_SCRATCH_MKFS_CMD and POST_SCRATCH_POOL_MKFS_CMD.
> > > > 
> > > > Usage example:
> > > > 
> > > >          POST_SCRATCH_MKFS_CMD="btrfstune -m"
> > > >          POST_SCRATCH_POOL_MKFS_CMD="btrfstune -m"
> > > 
> > > Can't we add extra options for mkfs.btrfs to support metadata uuid at
> > > mkfs time?
> > > 
> > > We already support quota and all other features, I think it would be
> > > much easier to implement metadata_uuid inside mkfs.
> > > 
> > > If this feature is only for metadata_uuid, then I really prefer to do it
> > > inside mkfs.btrfs.
> > 
> > Thanks for the comments.
> > 
> > The use of btrfstune -m is just an example; any other command,
> > function, or script can be assigned to the variable POST_SCRATCH_xx.
> 
> The last time I tried something like this, I got strong objection from
> some guy in the XFS community.
> 
> Just good luck if you can have a better chance.

As another guy in the XFS community, I also don't understand why this
can't be accomplished with a _scratch_mkfs_btrfs helper that runs the
real mkfs tool and then tunes the resulting fs.  Is it significant for
bug finding to be able to run an entire separate fstests config with
this config?  Versus writing a targeted exerciser for the -m case?

Is there some reason why the exact command needs to be injected via
environment variables?  Or, why can't mkfs.btrfs do whatever "btrfstune
-m" does?

I suppose the problem there is that mkfs.btrfs won't itself create a
filesystem with the metadata_uuid field that doesn't match the other
uuid?

--D

> > 
> > Now, regarding updating mkfs.btrfs with the btrfstune -m feature,
> > why not? It simplifies testing. However, can we identify a use case
> > other than testing?
> 
> For consistency, I believe all (at the ones we can enable) features
> should have a mkfs equivalent at least.
> 
> (And can get around the the test limitations for sure)
> 
> Thanks,
> Qu
> > 
> > Thanks, Anand
> > 
> > > 
> > > Thanks,
> > > Qu
> > > > 
> > > > With this configuration option, test cases using _scratch_mkfs(),
> > > > scratch_pool_mkfs(), or _scratch_mkfs_sized() will run the above
> > > > set value after the mkfs operation.
> > > > 
> > > > Other mkfs functions, such as _mkfs_dev(), are not connected to the
> > > > POST_SCRATCH_MKFS_CMD.
> > > > 
> > > > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > > > ---
> > > >   common/btrfs | 35 +++++++++++++++++++++++++++++++++++
> > > >   1 file changed, 35 insertions(+)
> > > > 
> > > > diff --git a/common/btrfs b/common/btrfs
> > > > index 798c899f6233..b0972e882c7c 100644
> > > > --- a/common/btrfs
> > > > +++ b/common/btrfs
> > > > @@ -690,17 +690,48 @@ _require_btrfs_scratch_logical_resolve_v2()
> > > >       _scratch_unmount
> > > >   }
> > > > 
> > > > +post_scratch_mkfs_cmd()
> > > > +{
> > > > +    if [[ -v POST_SCRATCH_MKFS_CMD ]]; then
> > > > +        echo "$POST_SCRATCH_MKFS_CMD $SCRATCH_DEV"
> > > > +        $POST_SCRATCH_MKFS_CMD $SCRATCH_DEV
> > > > +        return $?
> > > > +    fi
> > > > +
> > > > +    return 0
> > > > +}
> > > > +
> > > > +post_scratch_pool_mkfs_cmd()
> > > > +{
> > > > +    if [[ -v POST_SCRATCH_POOL_MKFS_CMD ]]; then
> > > > +        echo "$POST_SCRATCH_POOL_MKFS_CMD $SCRATCH_DEV_POOL"
> > > > +        $POST_SCRATCH_POOL_MKFS_CMD $SCRATCH_DEV_POOL
> > > > +        return $?
> > > > +    fi
> > > > +
> > > > +    return 0
> > > > +}
> > > > +
> > > >   _scratch_mkfs_retry_btrfs()
> > > >   {
> > > >       # _scratch_do_mkfs() may retry mkfs without $MKFS_OPTIONS
> > > >       _scratch_do_mkfs "$MKFS_BTRFS_PROG" "cat" $*
> > > > 
> > > > +    if [[ $? == 0 ]]; then
> > > > +        post_scratch_mkfs_cmd
> > > > +    fi
> > > > +
> > > >       return $?
> > > >   }
> > > > 
> > > >   _scratch_mkfs_btrfs()
> > > >   {
> > > >       $MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize $SCRATCH_DEV
> > > > +
> > > > +    if [[ $? == 0 ]]; then
> > > > +        post_scratch_mkfs_cmd
> > > > +    fi
> > > > +
> > > >       return $?
> > > >   }
> > > > 
> > > > @@ -708,5 +739,9 @@ _scratch_pool_mkfs_btrfs()
> > > >   {
> > > >       $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV_POOL
> > > > 
> > > > +    if [[ $? == 0 ]]; then
> > > > +        post_scratch_pool_mkfs_cmd
> > > > +    fi
> > > > +
> > > >       return $?
> > > >   }
