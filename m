Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABD27DFB96
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 21:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345719AbjKBUcu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 16:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345100AbjKBUct (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 16:32:49 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFA01A1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 13:32:46 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7781b176131so75153585a.1
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Nov 2023 13:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1698957165; x=1699561965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=34CPHx89bwh8qwgk3q1mguUkvTQjj2rMimJifw5cT9U=;
        b=xoN5XwRHizRVuDGtxHnUGiYF1iLNL7fuXG/VIXZAPfXcV4XA3EDE9kwHH5ByjKXK4P
         5nHKIIrrzkgA97BJWkoa059SQnaiSb501sBz4HnxGOZC4VCIH63rBiEtHvsuENTyny2K
         KnP3/MUTgHrcosu4MsxjTwEa0qruDbM72ewCN2U78ZOYj3PrqydVuIkZm5OQbsJ7wTc2
         d+s5+shd229oJKWSwxlUQIFwAoFGX3aRjmeBNkz4kECdMQ0Gqd95onkCnkEvLLhN8WDQ
         HI/uLf2eTRbnk5GrDES45prHq/ZrY1EtJy6uOwFIyeTyuuxebI39kQGnKdVr7sE5Kjlm
         e7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698957165; x=1699561965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34CPHx89bwh8qwgk3q1mguUkvTQjj2rMimJifw5cT9U=;
        b=S1o9Ntiib+Jl1XhOu/Ds5Vc7aLlNpY2TBUtYB76hiRSqQSCUyS6YdxAtBb2knyiTQa
         iYNr93Q4M2KAm+td6/eyb7RIiEZ+XOHsjnHOF9qI57FDPdHL/8TBY4XjKlWAWNvdtoCq
         D7YzX31jWRgt0nWQdsRZLQol/HOXlg7TYAQpOusTcEEn2jBGaUNYGE4V2G9kAY0+1m3K
         FdWjGG6lmufMFIWru4BD/EFwmqOkbsyMBIgsdA0wZhdDdcJ+XroYd+mbmHNAyBOfW3mm
         LoqYwJVT2hYpGz0zXNBCH+16RfBN+OYvAG42BbPMAYZn8ECIdOH+s5QwB0w/6QOJYWWD
         JA8g==
X-Gm-Message-State: AOJu0YysfMo9zaui4RnPntS++RI6xmOgEl5/5mJXA1Spn+gsmyoDGNM6
        5NWY+uUxH/xz23qPGfncpiKBpA==
X-Google-Smtp-Source: AGHT+IFIQplKj+X0E7szuk90OCKyxC+AYKJdaylmw5GUDC4mFzLeB8eRJWkAA9eAYLGe6Fu3s64l2A==
X-Received: by 2002:a05:620a:bc8:b0:77a:5112:c1ef with SMTP id s8-20020a05620a0bc800b0077a5112c1efmr5966040qki.1.1698957165464;
        Thu, 02 Nov 2023 13:32:45 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i10-20020a05620a144a00b0076cb3690ae7sm91589qkl.68.2023.11.02.13.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 13:32:44 -0700 (PDT)
Date:   Thu, 2 Nov 2023 16:32:43 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231102203243.GA3465621@perftesting>
References: <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-ankurbeln-eingearbeitet-cbeb018bfedc@brauner>
 <20231102123446.GA3305034@perftesting>
 <20231102170745.GF11264@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102170745.GF11264@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 02, 2023 at 06:07:45PM +0100, David Sterba wrote:
> On Thu, Nov 02, 2023 at 08:34:46AM -0400, Josef Bacik wrote:
> > On Thu, Nov 02, 2023 at 10:48:35AM +0100, Christian Brauner wrote:
> > > > We'll be converted to the new mount API tho, so I suppose that's something.
> > > > Thanks,
> > > 
> > > Just in case you forgot about it. I did send a patch to convert btrfs to
> > > the new mount api in June:
> > > 
> > > https://lore.kernel.org/all/20230626-fs-btrfs-mount-api-v1-0-045e9735a00b@kernel.org
> > > 
> > 
> > Yeah Daan told me about this after I had done the bulk of the work.  I
> > shamelessly stole the dup idea, I had been doing something uglier.
> > 
> > > Can I ask you to please please copy just two things from that series:
> > > 
> > > (1) Please get rid of the second filesystems type.
> > > (2) Please fix the silent remount behavior when mounting a subvolume.
> > >
> > 
> > Yeah I've gotten rid of the second file system type, the remount thing is odd,
> > I'm going to see if I can get away with not bringing that over.  I *think* it's
> > because the standard distro way of doing things is to do
> > 
> > mount -o ro,subvol=/my/root/vol /
> > mount -o rw,subvol=/my/home/vol /home
> > <boot some more>
> > mount -o remount,rw /
> > 
> > but I haven't messed with it yet to see if it breaks.  That's on the list to
> > investigate today.  Thanks,
> 
> It's a use case for distros, 0723a0473fb4 ("btrfs: allow mounting btrfs
> subvolumes with different ro/rw options"), the functionality should
> be preserved else it's a regression.

I'll add an fstest for it then, I could have easily broken this if I didn't see
Christians giant note about it.  Thanks,

Josef
