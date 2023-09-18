Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B59E7A3F2B
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 03:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbjIRBTC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Sep 2023 21:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbjIRBSo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Sep 2023 21:18:44 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A76127
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Sep 2023 18:18:38 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c1ff5b741cso37517225ad.2
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Sep 2023 18:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694999918; x=1695604718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXRC1PQ3GY1eexkScHMq0QjKrpYm4dzHrRMoy1/YPyM=;
        b=aqxJT2JZHDvnNaM+OHyNNC/EqJ6Vn1PlYq73qWiiznas705VDbs1u0qBaZp3RLcvg/
         1Q3F5l19/wYcHUW1OAQX4FfCUFjsRJXUc/1pq5v/PJz53eB/J7ycEgV4QvDQ9dSBtJVB
         7zFB5KUYBIbkcD9UXvXybT5uqyr+XOSRnGbWOJPGYVCt4mNPxWfEMpJJILm9mJArs9iT
         TsLBYFqJNSCvYqLuRDrxhF7TSdwEb467+BkQZLefdN6deq0XhOF6cmPAkWwj1hSFyQJ/
         TQPlov6t5OMfCJVFqFdJHcxcLz0CarkgvPKUrdgfZ9RDb/b+phWWrfPxv0YYvjDjau0h
         8F7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694999918; x=1695604718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXRC1PQ3GY1eexkScHMq0QjKrpYm4dzHrRMoy1/YPyM=;
        b=t1/uI32L8mqWEHitzhcZaEUykQ7oQxnVujcHTg6m3GLs3V1fmIhY+qnHoLJKrafobG
         enyHLh+0e6uIM61oM/DGhJXfVAWvohR976PY06kAqlev+mOGxQo2Nw6HhIz8RaaCbtoZ
         yEqosgb69/qiyqZB/xLy/AaK4aBDouzhni+EffiYr6buvEUyVBxn5BtgAxDcGMzxQ6td
         irOqGQRWuVPFvtr+DWbkJEqbyOREp1Y2w0y4rUmSAWMOJkKEO9VWV1x52RQws35lq9/l
         prq9zqx/8Q3ngtfFdWLhfRSa7zcHkhKrySkHlUGAGMSX9wfbkY+bAb+aPwsh7v28hUQM
         RqhQ==
X-Gm-Message-State: AOJu0Yz8gXFewvFyYKpCqgp+tVxBJjbwXGL6KlVf3fXUA7idYm3svGLU
        AQt790TCDeXDBzXLpCkz0FA3rA==
X-Google-Smtp-Source: AGHT+IErcYyrcnbLQ/cqmK++Xn5ptpR5jKfTcNxZptMvKdAl/aYPErqRxsPGx0eI1m7EztBhEPs5/w==
X-Received: by 2002:a17:902:f7c2:b0:1c5:64aa:b961 with SMTP id h2-20020a170902f7c200b001c564aab961mr1972359plw.50.1694999918170;
        Sun, 17 Sep 2023 18:18:38 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902d38600b001bdb167f6ebsm7214871pld.94.2023.09.17.18.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 18:18:37 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qi2uI-00291T-37;
        Mon, 18 Sep 2023 11:18:34 +1000
Date:   Mon, 18 Sep 2023 11:18:34 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        zlang@redhat.com
Subject: Re: [PATCH v1] fstests: add configuration option for executing post
 mkfs commands
Message-ID: <ZQelaoVEWPPQ1SD/@dread.disaster.area>
References: <9c6d36835c04f18a59005a8994ba128970bac20a.1690446808.git.anand.jain@oracle.com>
 <ZQO6lmjasMPY8wOQ@dread.disaster.area>
 <87f9bf67-f407-e0b5-c29a-825eb4712392@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87f9bf67-f407-e0b5-c29a-825eb4712392@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 17, 2023 at 07:58:11PM +0800, Anand Jain wrote:
> 
> > In general, we've put filesystem specific post-mkfs commands inside
> > the filesystem specific mkfs function.
> > 
> >
> > See _scratch_mkfs_xfs() for example. If we want to test TB scale
> > scratch filesystems without requiring ENOSPC tests to fill TBs of
> > disk space, we set LARGE_SCRATCH_DEV. This causes the mkfs function
> > to do the post-mkfs creation of a hidden file that consumes all but
> > 50GB of space via fallocate (by calling _setup_large_xfs_fs()).
> > Hence filesystem filling tests don't spend forever filling the
> > filesystem, and no code outside of XFS specific functions need to
> > care that this hidden file exists....
> > 
> > Given that the use case here is to issue filesystem specific
> > commands rather than generic setup commands needed for all
> > filesystems, I think it would be better to encapsulate it inside the
> > btrfs specific mkfs implementation....
> > 
> 
> 
> IMO, making it configurable and generic would also benefit other
> filesystems. For instance, the XFS filesystem could set it to
> 'POST_MKFS_CMD="xfs_admin -p"' or something similar ?

That's basically no different to setting up the same filesystem
config as using mkfs to do it. And a lot of the things that
xfs_admin can change are always set on v5 format filesytsem and
can't actually be modified. e.g. "-p" is such an option that is only
ever added to old v4 filesystems, and even then it's been the mkfs
default since 2013.

As it is, it can't easily be used for things like LARGE_SCRATCH_DEV,
because that requires multiple operations to create and internal
fstests knowledge that large devices are being used.

> The design choice here is to create an open and configurable command
> variable. This is because we have several commands and options that
> we need to test, and it wouldn't be practical to hardcode them.

I'm not suggesting that you hard code them. I'm just saying that for
filesystem specific post-mkfs changes prior to mounting the
filesytsem fo rthe first time, the code should be located in the
filesytsem specific mkfs functions. You *must* be doing filesystem
specific things here because the filesystem hasn't been mounted, and
that greatly limits the generic things one can do with such a
command....

That is, you can still use environment variables to specify the
-optional- post mkfs changes you want to test, but doing it from the
internal _scratch_mkfs_$FSTYP() function allows the implementation
to be specifically customised to whatever sort of complex operations
you need to perform for that filesystem type without needing to care
how that may impact other filesystems....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
