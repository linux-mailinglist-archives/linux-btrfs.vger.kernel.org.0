Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D2DBDF74
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 15:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407087AbfIYNxJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 09:53:09 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32982 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407078AbfIYNxI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 09:53:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id r5so6644511qtd.0
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 06:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZF84i4CGU3CtKKBNF3niOR3REIcPYNptYnGn87PU/1I=;
        b=ztoJ47muMu4kNqCazLQ4VcFSZb2+1d497jc3ovJTEBzGC64vLRTtcY51FHG/nQb6bv
         gVXe+INQa4QL6eKnpKrwpRuXY7qA6xSTMYxO/j3RwoZafx4q5zsvr5ZJwZoA2hAvjNg1
         5gEcfxffAC4H7tk/9AcaZKVF0jjlTLSnsMxgdBE005k0aoO8EPzSiGAJLP6BdVBeaqLo
         gCgiylKhb4hvSoVuzlinFD2rkiwkCYD6xqWxHUFZhQpexlPcfWyjLsGKLbIzXj72/Hvi
         tjF87DQVMKNZMVzAbaFvpuAJeI9KB4z1vW4djDMqPzm2LKdpMsQlw3+JpeuZEcElA8G4
         GFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZF84i4CGU3CtKKBNF3niOR3REIcPYNptYnGn87PU/1I=;
        b=cigGYZ1Z0t0z5LtVzYrxmYx4fDn1+g2LcTcRC+YepgKSKyz1P4XAhxtARq0865vOtU
         jmhjomfzfssZDisVz8xy8QtrcFINmzp1Zd6zDfzDL1PkUTXLs+z1ZoUNh7bye88z3h8J
         XtT//3UDZIga8TMKaO+RDb/ZnJHRmh2O4tytCgnYoM+utmlp1Z+ReRZM17SukZrceCXm
         SROTXR63vN2DzD7sYq+wljzcpq2is75rxq74YR8CJ+ROI/47UsK+z/spv3AJHxQuwcsN
         WHjsLUd0HC7RlLm8LMdF7fVR9Bq9+zq978SAg2suPkmE1NdkVdGCGQWW109A71MGCVNU
         GC1w==
X-Gm-Message-State: APjAAAXKw/lNFKUojwZCHyoDwZfEMCR7gu75ZdCW7WrBEfrL5cpoOuAf
        MJxwHtU2QYMNeK2J1FXCO3VDJQ==
X-Google-Smtp-Source: APXvYqx+8UL5T/sdJmhrDjGhHsBehF4oBgG0FTIR+hxA9aDUifkyuPPdhnq58jIkg4l1Zcm7bs/5fQ==
X-Received: by 2002:ac8:7604:: with SMTP id t4mr8911055qtq.34.1569419586345;
        Wed, 25 Sep 2019 06:53:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::db91])
        by smtp.gmail.com with ESMTPSA id 62sm3275075qki.130.2019.09.25.06.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 06:53:05 -0700 (PDT)
Date:   Wed, 25 Sep 2019 09:53:04 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/4] The remaining extent_io.c split code
Message-ID: <20190925135302.wyv5foxhy5tku6li@MacBook-Pro-91.local>
References: <20190924203252.30505-1-josef@toxicpanda.com>
 <20190925134747.GG2751@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925134747.GG2751@twin.jikos.cz>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 25, 2019 at 03:47:47PM +0200, David Sterba wrote:
> On Tue, Sep 24, 2019 at 04:32:48PM -0400, Josef Bacik wrote:
> > Hopefully all of it makes it this time, if you want you can pull from
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/josef/btrfs-next.git \
> > 	extent-io-rearranging
> 
> The size of the exported patch 1/4 is 109066 bytes and the diff itself
> is incomprehensible to even see what code moves where and what is new.
> 
> I'm still thinking if this is a good idea to apply a monster patch, even
> it's just moving code around. The previous series splitting
> extent-tree.c were better so I'd rather take that approach again. Some
> of the functions belong logically together and won't break compilation
> and would actually make it possible for a human to review.

extent-tree.c was way different because a bunch of things had to be renamed and
exported.  Also extent-tree.c got split into many more files, so there was less
bulk being moved around.  extent_io.c is different because basically everything
is exported already, so it's really just move definitions, move code.  I
literally just split vim'ed, cut and paste between the two files.

Things like this are going to be impossible to review.  It's a one time pain for
more readability and better decisions down the road.  I did my best to keep the
logical changes to their own patch, but the fact is we have _a lot_ of code for
each of these different logical things.  I can turn it into 45 patches moving
one function at a time, but who's going to go and check each individual patch?

Josef
