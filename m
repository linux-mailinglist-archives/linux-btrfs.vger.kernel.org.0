Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CA31E17EF
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 May 2020 00:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbgEYWwJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 18:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgEYWwI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 18:52:08 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E04C061A0E
        for <linux-btrfs@vger.kernel.org>; Mon, 25 May 2020 15:52:08 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q11so6396041wrp.3
        for <linux-btrfs@vger.kernel.org>; Mon, 25 May 2020 15:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hnyfs6+Mbg42qMCQ3twfFV4iqWFCiAIXvsyRg0mCWrM=;
        b=Ge/7SdWQywV5nGkvkIN4Gbu+DwGxnzwKdaKC+SWcFwIcPfAM9Xa+n9x1DX+qVbAAfZ
         1RcSQ15LbMVs6W3VKXrE08K4mc2XWdQNT/9WCOXqQt5aVPGfPwBtQxHeSaIQ1I3D10lc
         Dp78qzgGwOM3+MWy7ckNK6kL81FG192d1sQ3l4xW4mmaoaiY8rvgHC83w2S2c6vPc2ds
         +n0Dr4fOMH9dTX4rV5N4S0X8aU83xHGI+UYdIeu9SSAm5O0NvLfb5To+M1/5c6JPV2ON
         W6+83rNZ2WLdm8lOIgjewMQC16tONbr6JsydZOoYl33PWzAlRoFUMf8JbZukkAO8GxR2
         InaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnyfs6+Mbg42qMCQ3twfFV4iqWFCiAIXvsyRg0mCWrM=;
        b=Udy2qYY2ZhGsDHhoHyN96sQyk+VMPikctC44FFOQGbWN6fzUbEb+UkzRnGSbvCFTs3
         T9AJcaJmRzbKk28kMSlO55xrRq13p7jhPisup5PHkWWiyPYNv7lk86zpsDQ1oHLd3KmI
         D1IavWjSvbQNjaHQ6I++UBIP35lUJNnvzoYxuRqpaRRujlhdBEdAF86x6p7VYE5z2GHq
         1onrlwYfE7vKP8jalKOlxcubLPFFzBwG7ZXf0Cyv4DN1L0Sl4Qd4sjHTaCQblWf2taWf
         jPP/oSABvaUrPxwRsfcdZdhjvxIAJhlgUUvBOzvRuVofyZScgp9kgZHpmlv1+OBmMCUU
         mnTw==
X-Gm-Message-State: AOAM530TDNp+DyIFXHGfv+k81jkTLBo1DBUlqm51GyHwCliEdzePyYBf
        xSJ9CFcVFtIfjge9y1md0pWomtTTW0FGa0XdBAKqYA==
X-Google-Smtp-Source: ABdhPJzqpDt5J1jzLp0RRzdHDMEQ523aQqZD4nniYsCzbF6D2YPFWT2hX3hLIqXf91vEA0h/DKZFO6Bf7KEY4DIiKXA=
X-Received: by 2002:a5d:67d2:: with SMTP id n18mr13995348wrw.65.1590447127097;
 Mon, 25 May 2020 15:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200524213059.GI23519@merlins.org> <CAJCQCtTWkRijC51qny+gLqFO=z-Jek4mbKN0O6udLKzzeNe_vw@mail.gmail.com>
 <20200525201620.GA19850@merlins.org> <CAJCQCtSqdJnVCPQEEeE1W3ux48tWerQuu-2_rySUdYM7GZJR9Q@mail.gmail.com>
 <20200525203916.GB19850@merlins.org> <CAJCQCtQgeYE3XPFACru08qhSOTxv5N9icj4xV27rG81UeaVa=g@mail.gmail.com>
In-Reply-To: <CAJCQCtQgeYE3XPFACru08qhSOTxv5N9icj4xV27rG81UeaVa=g@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 25 May 2020 16:51:51 -0600
Message-ID: <CAJCQCtQaN+4TY4_Y-CwPBQTtrJ52E-cc-A1+Nt2jOsyTrkX9fw@mail.gmail.com>
Subject: Re: 5.5 kernel and btrfs-progs v5.6 create and cannot fix 'root
 204162 inode 14058737 errors 1000, some csum missing'
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Marc MERLIN <marc@merlins.org>, Su Yue <Damenly_Su@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Su Yue <suy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 25, 2020 at 4:47 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Mon, May 25, 2020 at 2:39 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Mon, May 25, 2020 at 02:24:03PM -0600, Chris Murphy wrote:
> > > OK I didn't understand that the problem is with only the sending file
> > > system, not the receive file system. And also it sounds like the send
> > > did not cause the problem, but it's somehow a pre-existing problem
> > > that --repair isn't completely fixing up, or maybe is making different
> > > (or worse).
> >
> > Correct on all points.
> >
> > > So I guess the real question is what happened to this file system
> > > before the send, that got it into this weird state.
> >
> > That too, but honestly there are a lot of variables, and it feels like a
> > bit of wild goose chase.
>
> Maybe. The story arc on Btrfs is that check --repair only fixes the
> things it knows how to fix. It's gotten better but still has the scary
> warning, and lately has a 10 second delay to really make sure the user
> meant to use it. And regardless of mode, it's slow and just can't
> scale. Neither does "wipe and restore from backup". So the problems of
> inconsistency need to be understood to avoid the problem in the first
> place.
>
>
> >
> > Basically it looked like the issues with the FS are pretty minor (I was
> > able to cp -av the entire data without any file error), but that btrfs
> > check --repair is unable to make it right, which will likely force me to
> > wipe and restore.
> > I know chedk is WIP, and that's why I'm providing feedback :)
>
> What about finding inode 14058737 and deleting it? In all of the
> listed subvolumes? And then unmount and check again?


Before deleting it, can you check if chattr +C is set? Or what kind of
file is this? Because there's an old loophole in older kernels where
chattr +C could be set, but if defragmented while mounted with a
compression option, it would get compressed. And btrfs check complains
about it, but it's not actually a problem. Newer kernels don't do this
but I'm not certain about the send error's relationship with this.

You could try just making a 'cp --reflink=never' copy of the file. And
delete the original (and all of its copies in all subvolumes). Now
'btrfs check'.


-- 
Chris Murphy
