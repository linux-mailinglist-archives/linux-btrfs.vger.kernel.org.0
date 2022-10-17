Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BCE601601
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 20:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiJQSJP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 14:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiJQSJO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 14:09:14 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E11A74B99
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 11:09:13 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id l28so8224893qtv.4
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3cc6jsxqqom26J3UHai6hkIYjH/NZHIa5Vhjw2Z/HcQ=;
        b=3Jy788aPY9Wt5dWLDSmhPN3x1+g0QbgjdoRk7/arM/DQ8xsyBu3xC4T0v8Yp1m09XT
         OGJ6eMJ3t8MV7mnUtmhGvj0d/ad378R+EUX8hdBB0XtmC2hbNC/GeWtUVprt+AYviFv/
         ThxpaWV1jyhvsjOOeNx4pvXJZ93XWdZ+HzfUDtymYOLk3U1khcsqqcq9HRsAZptx4NcS
         Y3kXMbMcYrcC5L7MthPs7K/EsvNJECLet8DqAicFEoZwYaAhy2rhUvzcomItd7Sh6sB6
         uYlw89gmF7R/WdzRwq57HTw68jCaDTD2lWOn3KTS7S6Zbi1DJQn9zNDcJ7aAMkAhdiHm
         /Ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cc6jsxqqom26J3UHai6hkIYjH/NZHIa5Vhjw2Z/HcQ=;
        b=GQO3EiuYYM4LDTkMt+kFMCnNzeJxhADgTNy/GGIp8GOwpBbbbBRruLJANzBQ9d29NL
         vobaJ+pfxmbsEoW0YSergpmGUiVbT2KE2jSwFQOKxXQtxJAEakqdC9+yev5XlRGsM6YW
         v7leS4LZmsSeiAieLJGl4GZ63BsB2nY4w4SFg0bcgDXwWg/jwOKovb81dsHPVe5MrCej
         yQDZX2+Qw4IXO3ww/RrJUaUbr1U/pSOKumHXm4P0T1qaVWOSkPamgPqH4V+zWJQaMZkx
         y8yYcmtbIeiqwUd9LW8R+9AumomVZE2jq8kkZvf2FPiiixuLITqCA4bWyGh9lIfMIvj1
         qwYw==
X-Gm-Message-State: ACrzQf3zx7DLsgXZ7uh9HrTT48IS52ssykWzhKhQ6dXqxwILm1XhEldR
        KFAtuuZ90gNE1P3+yqEMIp//BA==
X-Google-Smtp-Source: AMsMyM6e4qoz9SyYCot7bKnMefQva3X+slDAiT+HoJn6wFotl4Xbe8fb48WQNligwrbf0n5NVknaqA==
X-Received: by 2002:a05:622a:130b:b0:39c:c95d:e3b1 with SMTP id v11-20020a05622a130b00b0039cc95de3b1mr9844335qtk.275.1666030152423;
        Mon, 17 Oct 2022 11:09:12 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id ch8-20020a05622a40c800b0039cc82a319asm270959qtb.76.2022.10.17.11.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:09:11 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:09:11 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Filipe Manana <fdmanana@kernel.org>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: fix tree mod log mishandling of reallocated
 nodes
Message-ID: <Y02aR4/PyHR/SCuA@localhost.localdomain>
References: <bc2187c559e2c2787a9de1423ab2d8176bd09ed5.1665751923.git.josef@toxicpanda.com>
 <20221017133144.GO13389@twin.jikos.cz>
 <20221017134347.GA2561014@falcondesktop>
 <20221017135112.GP13389@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017135112.GP13389@twin.jikos.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 17, 2022 at 03:51:12PM +0200, David Sterba wrote:
> On Mon, Oct 17, 2022 at 02:43:47PM +0100, Filipe Manana wrote:
> > > > Fixes: bd989ba359f2 ("Btrfs: add tree modification log functions")
> > > 
> > > Are you sure it's caused by this commit? 
> > > 
> > > The code was added in 485df7555425 ("btrfs: always pin deleted leaves
> > > when there are active tree mod log users") and slightly modified in
> > > 888dd183390d ("btrfs: use the new bit BTRFS_FS_TREE_MOD_LOG_USERS at
> > > btrfs_free_tree_block()").
> > 
> > The fixes tag is correct.
> > 
> > Not dealing correctly with extent buffers that get freed and reallocated
> > for multiple root nodes is something that exists since the tree mod log
> > was added.
> > 
> > The commits you mentioned were for a different problem, pinning only leaves,
> > while Josef's fix simply changes the logic to pin any extent buffer - it's
> > the simplest way to fix the bug regarding root replacements.
> > 
> > If those commits didn't exist, the fix this problem would be the same (just
> > pin any extent buffer if there are tree mod log users).
> 
> Ok, thanks. I'll tag it for stable 3.3 then but we'll need a backport
> for <= 5.10, ideally applicable down to 4.9.

Once you ship it to Linus let me know and I'll do the backports.  Thanks,

Josef
