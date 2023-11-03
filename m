Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70527E0403
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Nov 2023 14:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjKCNwT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Nov 2023 09:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKCNwS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Nov 2023 09:52:18 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ADF1A8
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Nov 2023 06:52:16 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7d9d357faso24767347b3.0
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Nov 2023 06:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699019535; x=1699624335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xYuO/C9GpkkIoAS96l7iTjBNNJrZplioBHxrTK6U3XE=;
        b=dk1h9cNBh1W9FqTuMZuI2D0JBe7KJ+vLJeznsnXFlC7z+YZFtQBFRLZTbIRb4T22mI
         q/RvoSWuiXUB4elvCZtkW2f9SEJSxcXOlmqckM7yRDEVHN7jR94n3i3GvSUyfW1+HiaA
         cpHDa/uuA8NGHIOBrUf66o9vbi3uGjh6h0rAYHgY/B6GKo0BFbn3EUt1AV1TEOH7fbY+
         so9tln8LLXAJKT/RFK1bk/2eUNSOj6m4UGxhi5Dy7tWIoRZSaaFqUFkVwlBIGbwUA6l7
         6fTKDM9ySxsmoZNTxqS9MuXICzwzSpib8KeqoL5nwKGnzNpmkz4TDy9q4y2vqK1GAdmX
         bRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699019535; x=1699624335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYuO/C9GpkkIoAS96l7iTjBNNJrZplioBHxrTK6U3XE=;
        b=wneGyCQLeRwbEDFttgYOgXXHQHol53YKAYnX5yqbZBKKfFqyfbR12neokLrJgv7IEh
         MA4rQ4G7tOLZt3CcjXo5/ron7cQgMwvhKO2W0/yDMA2QCGnntTdefDeUiXwnhUz6b2WY
         UTKO1e+M6kiyVvsNN8cEHQIC5XCPOSn5riPFXHTAqjlEurQkoTe3JlOONQM+hjx3Ijc+
         B5aDyIzOHMqFiUuW2aH21n0Dem98fve+t+b3CAy55qey9KgoHql7oV00Gt5LOF2nAZmd
         1N6DtB8GGfN58u/Qay0zyAGr+ZDYwlNK7GjgYtBBnpnOyNLHDuuYb/obPItVuEOS5lml
         a7eQ==
X-Gm-Message-State: AOJu0YyOH5gCqFITz4v6Lz9ynLHTYa2jr3H395t6m7RItMiU6+lY+M7x
        uWgNqcIP5WKbHr48KYVtIRRzGQ==
X-Google-Smtp-Source: AGHT+IHhtlG6mXXeKlDlSKrT7t7a1BH00I4TCPHzCkDtKR3roMulinT3ZCPDhp1InU1VBskXXsP6aQ==
X-Received: by 2002:a0d:e6cb:0:b0:5a7:b8d4:60e1 with SMTP id p194-20020a0de6cb000000b005a7b8d460e1mr3241045ywe.9.1699019535272;
        Fri, 03 Nov 2023 06:52:15 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id s10-20020ad4524a000000b00670c15033aesm734910qvq.144.2023.11.03.06.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 06:52:14 -0700 (PDT)
Date:   Fri, 3 Nov 2023 09:52:13 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231103135213.GB3548732@perftesting>
References: <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-ankurbeln-eingearbeitet-cbeb018bfedc@brauner>
 <20231102123446.GA3305034@perftesting>
 <20231102170745.GF11264@suse.cz>
 <20231103-wichen-shrimps-1ddd9565d6a6@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103-wichen-shrimps-1ddd9565d6a6@brauner>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 03, 2023 at 07:56:39AM +0100, Christian Brauner wrote:
> On Thu, Nov 02, 2023 at 06:07:45PM +0100, David Sterba wrote:
> > On Thu, Nov 02, 2023 at 08:34:46AM -0400, Josef Bacik wrote:
> > > On Thu, Nov 02, 2023 at 10:48:35AM +0100, Christian Brauner wrote:
> > > > > We'll be converted to the new mount API tho, so I suppose that's something.
> > > > > Thanks,
> > > > 
> > > > Just in case you forgot about it. I did send a patch to convert btrfs to
> > > > the new mount api in June:
> > > > 
> > > > https://lore.kernel.org/all/20230626-fs-btrfs-mount-api-v1-0-045e9735a00b@kernel.org
> > > > 
> > > 
> > > Yeah Daan told me about this after I had done the bulk of the work.  I
> > > shamelessly stole the dup idea, I had been doing something uglier.
> > > 
> > > > Can I ask you to please please copy just two things from that series:
> > > > 
> > > > (1) Please get rid of the second filesystems type.
> > > > (2) Please fix the silent remount behavior when mounting a subvolume.
> > > >
> > > 
> > > Yeah I've gotten rid of the second file system type, the remount thing is odd,
> > > I'm going to see if I can get away with not bringing that over.  I *think* it's
> > > because the standard distro way of doing things is to do
> > > 
> > > mount -o ro,subvol=/my/root/vol /
> > > mount -o rw,subvol=/my/home/vol /home
> > > <boot some more>
> > > mount -o remount,rw /
> > > 
> > > but I haven't messed with it yet to see if it breaks.  That's on the list to
> > > investigate today.  Thanks,
> > 
> > It's a use case for distros, 0723a0473fb4 ("btrfs: allow mounting btrfs
> > subvolumes with different ro/rw options"), the functionality should
> > be preserved else it's a regression.
> 
> My series explicitly made sure that it _isn't_ broken. Which is pretty
> obvious from the description I put in there where that example is
> explained at length.
> 
> It just handles it _cleanly_ through the new mount api while retaining
> the behavior through the old mount api. The details - as Josef noted -
> I've explained extensively.

I think Dave's comments were towards me, because I was considering just not
pulling it forward and waiting to see who complained.  I'll copy your approach
and your comment, and wire up a test to make sure we don't regress.  Thanks,

Josef
