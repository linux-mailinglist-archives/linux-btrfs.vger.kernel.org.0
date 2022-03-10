Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8564D3E05
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 01:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbiCJAUB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 19:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238962AbiCJAUA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 19:20:00 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6FC4BB83
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 16:19:00 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id c16-20020a17090aa61000b001befad2bfaaso3763885pjq.1
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 16:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ESNAFpth/q+vFU1tL8N5Z9SmkwtTBZzVsQ3eedEqtGI=;
        b=niPNWEIyV4J9se5ukrEgoRWu7Tv8w/9v5KHTF4VUPJgvoUTUbFpcW28gEXs/fDjiFL
         NYdzl2eAVe53S2An1B7cf42/kXjYJh2PlWxat0kcHBQC62gcgYKh/kyRKHwltcUp8OXq
         TwS1tMibwhWCaf2dO9PI9buV07oZxhICqLf0bj2TBKXkxrbP40hirbfiVnwj3gkk/Dxx
         BbbBldN9nyo/Q0LbpzYzE3mHYKUBrCfkSGotJ/hDDIvdcShB6J9Jc8w7/XIVGGCPxtz1
         FrDU9hJtX0Dcweaxqg9LqknN3eLFp5hBoCKu/g+dBHh4OcygZzQTQBZcjVICR62fu5SI
         tYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ESNAFpth/q+vFU1tL8N5Z9SmkwtTBZzVsQ3eedEqtGI=;
        b=CQKBqQ7D76s7ns2uL2Pv1IrzuxrWmTTJjrz+n406gaiP9bXf3kDUo2Or+ZIgaLxSz+
         tt8cfzYhv8LS0p/jrBtg0J430NYitd2QOzC36wqXBL03BWyLbiWfOzYQm5apJMP5JwQW
         56e0zh9v8Ss1e/WXvRDskalPC1Kez9oc4QHm62ugu5IF5y2sS/a76weEcPr157kcIHwj
         yfTLgVacG1AuE6herYIbhmIhdCTVSkpvPflsVXL2lUHromvgc+IEaaw/7M3SCaQEbvQs
         A2MmrUvQIvF+1rE2VqLwybA7SH7gKJ2xdVHHhQbbNuivZ7ZZYGH75bRMLTnJjyHqiUgo
         kA9g==
X-Gm-Message-State: AOAM53178K7xnv9fzfM6YaxIx3ggvaye7fjKYyhuPzQDXU2q84RbLBQu
        ROrkp5jMsZgfoQp3Ctj5iJpZgw==
X-Google-Smtp-Source: ABdhPJzts6jLA8+8X8/I/bHBUt48O7Dr8qZ6SkhgqpN9+BEWTXYz9JLUketeoor7qBxJACXIObrsGA==
X-Received: by 2002:a17:902:6b4a:b0:14d:474f:4904 with SMTP id g10-20020a1709026b4a00b0014d474f4904mr2291558plt.122.1646871539558;
        Wed, 09 Mar 2022 16:18:59 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:8b4])
        by smtp.gmail.com with ESMTPSA id y20-20020aa78054000000b004f6f267dcc9sm4118612pfm.187.2022.03.09.16.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 16:18:59 -0800 (PST)
Date:   Wed, 9 Mar 2022 16:18:57 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 12/12] btrfs: rework inode creation to fix several issues
Message-ID: <YilD8XM77fCvzvQV@relinquished.localdomain>
References: <cover.1646348486.git.osandov@fb.com>
 <c7edee49c1935f66c07c5c2c1aa98a599e4a11ad.1646348486.git.osandov@fb.com>
 <20220307122803.GC12643@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307122803.GC12643@twin.jikos.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 07, 2022 at 01:28:03PM +0100, David Sterba wrote:
> On Thu, Mar 03, 2022 at 03:19:02PM -0800, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> 
> >  fs/btrfs/acl.c   |  36 +--
> >  fs/btrfs/ctree.h |  39 ++-
> >  fs/btrfs/inode.c | 801 +++++++++++++++++++++++------------------------
> >  fs/btrfs/ioctl.c | 174 +++++-----
> >  fs/btrfs/props.c |  40 +--
> >  fs/btrfs/props.h |   4 -
> >  6 files changed, 508 insertions(+), 586 deletions(-)
> 
> Can this be split into more patches? All fine from 1 to 11 and now this,
> it's just too much code change and I don't want to take risk by yet
> another rewrite.

Yeah, at first I thought it'd be too hard to split up the last patch
further, but after you and Sweet Tea both asked me to, I managed to
split out another 4 patches. The end result is almost identical, but
that'll hopefully be easier to review. I'll send it out once xfstests
pass.
