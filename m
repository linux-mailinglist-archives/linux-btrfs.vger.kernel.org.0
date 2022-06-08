Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAC0542335
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiFHFGd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 01:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiFHFAA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 01:00:00 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C3A2C069E
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 18:34:09 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id s23so17394259iog.13
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jun 2022 18:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UqLGuRndKu4zf8uhmNsxGKaG3S9bJlYQazZ8R/zyVs8=;
        b=wjgF7yv8KDKuAGePG7QiqCXsTZ9a59fDWPGJ4ay0JSdYl0poBd7w9khtZzEJAkbyG2
         gs47vjSAxvpNQxBfEAQ5Ng+xvdYBBqurDbZLHEOhodp4iIpw9GRJgVTHDnToyYxpLgTS
         vDf95KTbYvCvwzv2rKSSGbKGqeNY38iAgZm+SZ7Oe1RtEx59n7dgEO0WALTfLDm8ClSC
         5Z5CVeT7c7QQ9brijTEgA6r5KBn45qoNsuBxFPGJ1u1eyWSvcAnsj5vse9cZK7GiDBX3
         rDjvvVONNxXk6A7NGSQ4/Z5uwUYE/keBgpPrtAAIgm4sjRwkY8nirkBe/fZ9izMnmhWj
         mudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UqLGuRndKu4zf8uhmNsxGKaG3S9bJlYQazZ8R/zyVs8=;
        b=3sW7DM0IjhSqKfaNcw2XFKz5Z2+uvZ0Q6Nf1XbeWiv9zkjO6i2N7HNuZ+N6jviOSeK
         84aKIsgloIh2qjxxLmOsikTuwebt+XPeQvAEjoE6yzh4EeM8WD3B6wQNaYSAsTiCTe+I
         pMtJImn8hNBuClqxB8M7Fi4hpwfz+Xg3coTThUvPSBEvoyzwuVRu2ZZAnJ6Y1PaMJTxp
         Ay5jvssSJvnhIDlblicJ6LZjuen7yg5Cr7lqd8FuUvO28YOmhuvG0q+IWJ0JtHQHQ3LR
         T8DDEzqqYqjiGpw43sAkk3QQPeSKY9FW3qB39YEmvTszZAix9CYvlfbUMTbM4+vKSs+C
         GcGA==
X-Gm-Message-State: AOAM532bICUrj5jW8FMWl53SODsHGZtBBor3HgDa4acwl8bwXq0O8bfJ
        OLhs62NMkNaf7O2qhQStPShZ+KtafYWAYe47aR9rkRUUnI4=
X-Google-Smtp-Source: ABdhPJyX+q71Cwqil5QFDhHGFqdTR4nbMN1Zg56OEsSOhHc7/r7lX4yjxpx8pknwhsaq8AFGP/fBaBLeGTr/aECzugc=
X-Received: by 2002:a05:6602:1695:b0:665:8390:fcf with SMTP id
 s21-20020a056602169500b0066583900fcfmr14913030iow.83.1654651899226; Tue, 07
 Jun 2022 18:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220607195744.GV22722@merlins.org> <CAEzrpqdp7JUPvpGrbctiLQY_qZpks7HyOSg4eNY=5xifErzy3A@mail.gmail.com>
 <20220607204406.GX22722@merlins.org> <CAEzrpqccYbdBNs6gYDzZRw17D1O6tPU=9w1vLvDVOjJeMDuazw@mail.gmail.com>
 <20220607212523.GZ22722@merlins.org> <CAEzrpqex0PRGZA3_gaoUhpPb-7cpi-gi_mo1S3F=0xxKNptpEA@mail.gmail.com>
 <20220607233734.GA22722@merlins.org> <CAEzrpqcVO99HbrhmtABUENRCm4HEsyg3+T3oK33DZFuXamwqgA@mail.gmail.com>
 <20220608000700.GB22722@merlins.org> <CAEzrpqe79F=-0T7Q3dqb62J6+kcisOjnWP+aLkkY0z+EJY-m9Q@mail.gmail.com>
 <20220608004241.GC22722@merlins.org>
In-Reply-To: <20220608004241.GC22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 7 Jun 2022 21:31:28 -0400
Message-ID: <CAEzrpqdq8zTBQaw_VneL4rfZn0JseUiwvtfwXQx0jq=DYBCFFw@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 7, 2022 at 8:42 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Jun 07, 2022 at 08:32:33PM -0400, Josef Bacik wrote:
> > > processed 622592 of 108838912 possible bytes, 0%
> > > Recording extents for root 164631
> > > ERROR: failed to insert the ref for the root block -17
> > > wtf
> > > it failed?? -17
> >
> > That shouldn't happen.  I reworked the code a bit and added some
> > debugging, re-run init-extent-tree please.  Thanks,
>
> processed 196608 of 63193088 possible bytes, 0%
> searching 18446744073709551607 for bad extents
> processed 16384 of 16384 possible bytes, 100%
> Recording extents for root 3
> processed 180224 of 0 possible bytes, 0%
> Recording extents for root 1
> ERROR: commit_root already set when starting transaction
> ERROR: error starting transaction
> doing close???
> extent buffer leak: start 11160502779904 len 16384
> extent buffer leak: start 15645018308608 len 16384
> Init extent tree failed

I swear first thing I'm doing after all this is updating the shared
code.  Try again please,

Josef
