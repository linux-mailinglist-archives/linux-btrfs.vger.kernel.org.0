Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2AC7A136D
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 03:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjIOCAA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 22:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjIOB77 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 21:59:59 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECEB26A4
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 18:59:55 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-56a8794b5adso1317820a12.2
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 18:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694743195; x=1695347995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BpFYzeBSV7BLSK6vX/5OOoybrcwN2yDHrgVnFoNl4L4=;
        b=1ZbFZkeehkIzv1dRMmtnEN4IEnAO3eQdCUNLgozpsp0T399o/La3VgOlKqMmUhHyVN
         93NrEBoxzBvq4JYhu2UCwPmcdNtfSAVREFizni7KDutcrS8EEycNRcMRMrQmnLlY9VA/
         SRLidGna/oVbhLtIJeXIlr2qKmlrgvbg+Qa5lZx9/29cE7Se7UgJjyeLnFzdej1kFyEZ
         cBws9SJxOZqw8GUNW36skcmBqO7Dwqkx9uW7YMfp7uhcGh0V9knOvm30aPrvb4AINOmN
         uvh+mq+jm9ldSCeoy5d+MvfSA/RDt6alS0LGFLGBXumU/ikQCx+vYPjOU8QWge2KCezT
         6LuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694743195; x=1695347995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpFYzeBSV7BLSK6vX/5OOoybrcwN2yDHrgVnFoNl4L4=;
        b=Ssso/ACUeORCz8bgNKqwOxu7KizSJBa1kLfE6pxeHzgH6XuiSXjh6n3L5B1jdwcxdT
         J/5k86VgxOxyaCOuhSGWTqi8wlVV062cDxDJAr3Ag6xKx6IwTjYgNJ4jMd+3xxsXpYg5
         zHl28GxNMBFqLyGq1Wa/BJRuvQGcxKgcB9Rb6GYCQ1xvVS7n0cuUmqSLzCn9OHI2JFLl
         v7XWczdNBRZBzpqh1CZnhSuNH1PfxNBblBL2GE8/USnp6ZGTkdTGYNc5PO1rObHQbYgU
         m//flYmBoiIJbZ8/QWszL7nG8rwlL+XSDG0ILkJPmh+BZZz7unQcoPCLyVeGMFLCRdDB
         c3HQ==
X-Gm-Message-State: AOJu0YyX4anxHWImPtvHWlARxStBPgc7x8dpGcQlvMoTXzvcVWVYcU92
        44QtBp5+203WniBM7u59RhNqfg==
X-Google-Smtp-Source: AGHT+IHArELVpzffLRMKIv4CrOmO2y06bOn64llScRTKf51KEYm01Ez6F3rH0F/Uijf7LKxlbpx2nQ==
X-Received: by 2002:a05:6a20:160c:b0:153:dff0:c998 with SMTP id l12-20020a056a20160c00b00153dff0c998mr651325pzj.6.1694743194670;
        Thu, 14 Sep 2023 18:59:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78298000000b0068be348e35fsm1923910pfm.166.2023.09.14.18.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 18:59:53 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qgy7a-000rIc-35;
        Fri, 15 Sep 2023 11:59:50 +1000
Date:   Fri, 15 Sep 2023 11:59:50 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        zlang@redhat.com
Subject: Re: [PATCH v1] fstests: add configuration option for executing post
 mkfs commands
Message-ID: <ZQO6lmjasMPY8wOQ@dread.disaster.area>
References: <9c6d36835c04f18a59005a8994ba128970bac20a.1690446808.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c6d36835c04f18a59005a8994ba128970bac20a.1690446808.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 14, 2023 at 11:07:43PM +0800, Anand Jain wrote:
> This patch introduces a new configuration file parameter, POST_MKFS_CMD,
> which, when set, will run immediately it after the mkfs command for the
> FSTYP btrfs.
> 
> 	For example:
> 	POST_MKFS_CMD="btrfstune -m"
> 
> Currently, only btrfstune's '-m' option is tested. However, there may be
> more btrfstune options, so having this parameter as a config makes sense.
> Additionally, there can be other commands besides btrfstune.
> 
> The mkfs helper functions in common/rc passes the SCRATCH_DEV as an argument
> to the set POST_MKFS_CMD, which may not be compatible with other configurable
> commands in the future. However, as of now, since those usecases are still
> unknown, we can modify it later.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

In general, we've put filesystem specific post-mkfs commands inside
the filesystem specific mkfs function.

See _scratch_mkfs_xfs() for example. If we want to test TB scale
scratch filesystems without requiring ENOSPC tests to fill TBs of
disk space, we set LARGE_SCRATCH_DEV. This causes the mkfs function
to do the post-mkfs creation of a hidden file that consumes all but
50GB of space via fallocate (by calling _setup_large_xfs_fs()).
Hence filesystem filling tests don't spend forever filling the
filesystem, and no code outside of XFS specific functions need to
care that this hidden file exists....

Given that the use case here is to issue filesystem specific
commands rather than generic setup commands needed for all
filesystems, I think it would be better to encapsulate it inside the
btrfs specific mkfs implementation....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
