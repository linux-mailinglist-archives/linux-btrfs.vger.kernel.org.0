Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390C17BB124
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 07:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjJFFR0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 01:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjJFFRY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 01:17:24 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424EAB6
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Oct 2023 22:17:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-58907163519so1264978a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Oct 2023 22:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696569443; x=1697174243; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6ulEDdz8AZk6BitB20Er0SVz9TiuW+ROKRm6CoZ+yRY=;
        b=iHAVvd+zHY5p6RiaiPvCIh5NV+6yVAVaU5fcxHrRzL0DxFUQzUigctQB4+gLhT3SE4
         gDRUltTyZXhNJlSQRYHDnPSrZe/C28WRBEvrGyumDYPQ+sEuuKgGdMaZv6xyYDyYad8o
         V9D+QfWGwibU11fUpHIKzyKNHtOYwj5WIbHQVJIsvCuDB68sABzw6xYFOul5LSCFbsXM
         iil/ctpt2bv+ag8Sf1zHLu4reyi7WUfKeq4dCEIvJ1llRbFxQvHCapsIWwXfMDV3i2ta
         aSJsc2KukVcZlhY4IaAe6d/UJg9SDV+Ne+1WuNeRbEz5LHMWkXp6Ryi/DoKubHbTRXl2
         V2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696569443; x=1697174243;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ulEDdz8AZk6BitB20Er0SVz9TiuW+ROKRm6CoZ+yRY=;
        b=OXyEmBVS/M9IgJjFTdiFQiL7WZv4UdtMOnXz88yvq32utaBZXPMU0JMvJwlo5dbUYk
         nUuGXbVkCmz6XC0eqI5tpj7Crw549D99wUGjkOXD4ieVfG+Ectz9lHr7qtdWzk7TfvSH
         7m91MlNUqyFTFPfM6yBJ9JE1nFpemYugHPDAs7C6hS8yShIrAYYBtJMvQbyJW3KKZZce
         SQiHlzQOUdywauZdy+qcsqAETEhJqZZAyUZfobd7a5wNONK2Gx4HSsWC+3QGjcU+qbDO
         x/pTqcHTWKQiQxff2wE0aLS+f7p6eAY9+rTNbaO9m4nBuS0LeF365dwMz0aElQfy6ztR
         m77A==
X-Gm-Message-State: AOJu0YxxtL2wFQuL7qL3L/Koar7WNV3arR77ZJoE1UBU+lKCZjnXS1Yh
        q081H6ZZ/BfuHOrTwEAS1RQRr4cW7jGXpYiTctM=
X-Google-Smtp-Source: AGHT+IEoX7wo9B9uTd4XbcyhCw9+r4IQS1YcDjOQsGvgNycLkbkxrW5aT/HJxIM1jiGoo02r6j2MhA==
X-Received: by 2002:a05:6a21:7892:b0:12c:2dc7:74bc with SMTP id bf18-20020a056a21789200b0012c2dc774bcmr8440979pzc.46.1696569442689;
        Thu, 05 Oct 2023 22:17:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id ju8-20020a170903428800b001c72d694ea5sm2752815plb.303.2023.10.05.22.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 22:17:22 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qodDD-00A5Ev-2x;
        Fri, 06 Oct 2023 16:17:19 +1100
Date:   Fri, 6 Oct 2023 16:17:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] fstests: add configuration option for executing post
 mkfs commands
Message-ID: <ZR+YX6whnmZlnFv4@dread.disaster.area>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 28, 2023 at 05:10:25PM +0930, Qu Wenruo wrote:
> On 2023/9/28 15:04, Anand Jain wrote:
> > On 28/09/2023 12:26, Qu Wenruo wrote:
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

That "some guy" has used fstests for 20 years, not to mention was
the maintainer for ~4 years and did most filesystem functionality
separation work that enabled fstests to become what it is now. 

Maybe, just maybe, that "some guy" actually has good reasons for
suggesting that the functionality is done in a certain way.  Both
XFS and ext4 already have optional post-mkfs functionality triggered
by environment variables (XFS dates back to 2003, ext4 back to 2013)
implemented in their filesystem specific mkfs functions.

If the configuration requires more than one command to be run, then
it can't be encoded easily in an environment variable.

Indeed, we shouldn't even be encoding fixed commands in environment
variables; environment variables should indicate functionality that
needs to be configured, and the fstests code itself implement the
commands that do that specific configuration. This allows multiple
configurations to be mixed and matched independently and without
needing users to encode complex commands into environment
variables....

That's the architecture we currently have: filesystem specific
configuration operations done at mkfs time should be done in the
filesystem specific mkfs routine.

> Just good luck if you can have a better chance.

Bad attitude doesn't win you friends or influence people.

> > Now, regarding updating mkfs.btrfs with the btrfstune -m feature,
> > why not? It simplifies testing. However, can we identify a use case
> > other than testing?
> 
> For consistency, I believe all (at the ones we can enable) features
> should have a mkfs equivalent at least.

That's a btrfs development problem, not a fstests issue.

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

Ideally this should be something like:

export SCRATCH_BTRFS_UUID='<uuid spec>'

btrfs_tune_dev() {
	local dev="$1"

	if [ -n "$SCRATCH_BTRFS_UUID" ]; then
		btrfstune -m $SCRATCH_BTRFS_UUID $dev
		return $?
	fi
	return 0;
}

_scratch_pool_mkfs_btrfs()
{
	.....
	btrfs_tune_dev $SCRATCH_DEV_POOL
	.....
}	

_scratch_mkfs_btrfs()
{
	.....
	btrfs_tune_dev $SCRATCH_DEV
	.....
}	

See how different it becomes when you stop thinking about filesystem
configuration as a generic post-mkfs command and instead think of it
as just another configuration option?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
