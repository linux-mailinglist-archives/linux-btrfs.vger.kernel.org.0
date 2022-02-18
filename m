Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251F14BBD73
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 17:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbiBRQ2i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 11:28:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbiBRQ2h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 11:28:37 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9172613D
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 08:28:19 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id d84so8473224qke.8
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 08:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+PU5MeTaQX1dJMoLtP2Ikcx7jjkf6fnAB9gzOl7JjRU=;
        b=7ZotEPQn5kvBQZsQIY2XGD9zM7IAPo9I17PSNl4s8Pe/ltOUgtAEAYlo5g9C+X8h+Y
         8VtZsGy3xc6CO6eXYvuXoIu4JD5Rj82f2QL9WznXJNCjqLsDgR8WXm/v55xK2eMCWoq6
         Hhz1SEzOiisz/eFJruorYk9zZM4oHL9j37iZaVSx20CeLxBfJ/Ze/ODCKCcUSQXmGyJy
         OvKDZq9CL5jz24qyxhJwP69HpzKEjvtXmDSZBRV/93kJMkHR8Jwa5XJt/CQgaWT1Fjkt
         GA+KjJE8Ze7N63NosH8eWSsGgokRqsD9LMpOck4Lygt49dggxOCOprG8e61avvS3k65C
         A1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+PU5MeTaQX1dJMoLtP2Ikcx7jjkf6fnAB9gzOl7JjRU=;
        b=yQMsmsKIrxrMCBB8sgCXhlmnWB3PLEM66ipCr8lk37BDLBGgOWhsMNPKRIIZTWqWiI
         GXCD+lnzY9KbI2kIw41+9E1GDNlLn7iXQWTYbkbXMgY/39UhG16ZJq75I6nS3d/wcTPD
         hm7xlpdMJCTsdxqsQUb3sflHLPjLCubR5OPuaSA180zVqjyqW6v9JLIj05GZSE41XUdc
         N7QpTqLShd51GCGPWA3hbpqyE8wfasloOPsDAqRejpbmZgp9KMsS8j20wscCi8kiTeGb
         GVBlj02DxXLk+wQlefo/o+zbW5FsVYwLwSFxs9+z4sI9xisaFtmC/lmurmkHu1P+BBiu
         ngxg==
X-Gm-Message-State: AOAM531XGOAVOXPfWCEpSURDPiVCyPXuTegSsjLQvs0SE5oMqbVTBbaj
        paaIfJkZCdq/54a59c9m5WoZj05hjmnzr9LR
X-Google-Smtp-Source: ABdhPJwrSwtDVhfADoOhwN8RJX4uSKRlNQi6/kSPTDh9qVSSxJHhZCxziPiNt3SRt4vX7DYWSFCgmg==
X-Received: by 2002:a37:95c6:0:b0:60d:d417:37f6 with SMTP id x189-20020a3795c6000000b0060dd41737f6mr5082600qkd.482.1645201698757;
        Fri, 18 Feb 2022 08:28:18 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x17sm1962187qtr.69.2022.02.18.08.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 08:28:18 -0800 (PST)
Date:   Fri, 18 Feb 2022 11:28:17 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/8] btrfs: handle csum lookup errors properly on reads
Message-ID: <Yg/JIVB6vhUZJzGa@localhost.localdomain>
References: <cover.1645196493.git.josef@toxicpanda.com>
 <5b9da7cdf4f3bb6edbf6e52313f8451be10f56a6.1645196493.git.josef@toxicpanda.com>
 <20220218161706.GY12643@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218161706.GY12643@twin.jikos.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 18, 2022 at 05:17:06PM +0100, David Sterba wrote:
> On Fri, Feb 18, 2022 at 10:03:23AM -0500, Josef Bacik wrote:
> > +		/*
> > +		 * We didn't find a csum for this range.  We need to make sure
> > +		 * we complain loudly about this, because we are not NODATASUM.
> > +		 *
> > +		 * However for the DATA_RELOC inode we could potentially be
> > +		 * relocating data extents for a NODATASUM inode, so the inode
> > +		 * itself won't be marked with NODATASUM, but the extent we're
> > +		 * copying is in fact NODATASUM.  If we don't find a csum we
> > +		 * assume this is the case.
> > +		 *
> > +		 * TODO: make the relocation code look up the owning inode and
> > +		 * see if it's marked as NODATASUM and set EXTENT_NODATASUM
> > +		 * there, that way if there's corruption and there isn't a
> > +		 * checksum when we want it we can fail here rather than later.
> 
> Please don't add TODOs to the code, that's the best place to forget
> about them, we've had some unfixed for years.

Do we want to just make a GH issue for it?  If you want to yank that bit out I'm
fine with it.  Thanks,

Josef
