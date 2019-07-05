Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 423C5606CE
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 15:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfGENrb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 09:47:31 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:35455 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfGENrb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Jul 2019 09:47:31 -0400
Received: by mail-qt1-f170.google.com with SMTP id d23so11220215qto.2
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jul 2019 06:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hio+u+jqK6MgSqFmIbRs+zohyKr6PS0UQrav2nWlzz8=;
        b=nMa3JYeC3WTey6IyMo/LYZ3xA6A+yihr5AOJwCIc6NuDVRlY3V0ociDrKrJKjUEG9L
         TUwcH7hZzjTF1K7ytvyFo7uCRm9zKSwAOR8lBOTUFKDNNt9TUNBuAOaQX83fDzEG6IcP
         wnCfY5tF7VSAFa2XVHCX++HvaFv4lZt1Te8L7NQmGH/NI822TI59S1lsSsIfid2tJGi4
         2LvB/mtdbzylGg+8PCVpqT0cIxZ+1O+u55NkuSJDCa5SOOb1ySY8sLFaACR0aqCtK0oF
         h/U01Ek20KQK3jb70X/W4iPKF0mBvIF2Y36D/lTfOLU2rvYYXGzFZsQOiiL4z7LZj680
         JZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hio+u+jqK6MgSqFmIbRs+zohyKr6PS0UQrav2nWlzz8=;
        b=uHIFCfE79DJwhf/HxriWnGKr/BtY9PpyzmCMQOCbGqRdirWyg3qL+Qb7n6UmeYbGvn
         CJL+H3ZeWD0ta/zcj8dnGJ1j6+2KZVAWSZEXznfi1CJ+MakG7OwNFe234NfP0DaIS9Z5
         0iQuzP6tXSq7dhOTlJE+9LSenWtlE6MO//ba1m8/pYT+iVB+fRgC7jUEkGj4EpQ5xVjH
         /8Jcfzstl2S9KYOQJb6Ue2mZ6NnoQdt+P4XbFwqPCpMzuHILRDatXa6OD6N36h81ZyRa
         nP1aMkSW4VTM5Z7o9G9gxDLKbZPn4vxPdSwPFur1keGj4YWWs59zDOFjYPT0+9pGSm3V
         0QpQ==
X-Gm-Message-State: APjAAAVIU+WA1RstufsRCgi/QoMbZcpbDhu6rkaYYf5HtuTcaur008QD
        ggG0f5CUEEJKeivTUu4ba30+Sg==
X-Google-Smtp-Source: APXvYqwK3ONqDEZwiwZZMqf8zC0k6gbwcxezKlx5NcIrDTPR4ZjDywCVCBu0sxk6Mgfn0wwrfbvowg==
X-Received: by 2002:ac8:428f:: with SMTP id o15mr2652892qtl.210.1562334450531;
        Fri, 05 Jul 2019 06:47:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1d8e])
        by smtp.gmail.com with ESMTPSA id s8sm3548880qkg.64.2019.07.05.06.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 06:47:29 -0700 (PDT)
Date:   Fri, 5 Jul 2019 09:47:28 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, mingo@kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: Need help with a lockdep splat, possibly perf related?
Message-ID: <20190705134727.q62geiy4sniol4gg@macbook-pro-91.dhcp.thefacebook.com>
References: <20190703135405.kwzg2am7voldx7ac@macbook-pro-91.dhcp.thefacebook.com>
 <20190703211210.GJ16275@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703211210.GJ16275@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 03, 2019 at 11:12:10PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 03, 2019 at 09:54:06AM -0400, Josef Bacik wrote:
> > Hello,
> > 
> > I've been seeing a variation of the following splat recently and I have no
> > earthly idea what it's trying to tell me.
> 
> That you have a lock cycle; aka. deadlock, obviously :-)
> 
> > I either get this one, or I get one
> > that tells me the same thing except it's complaining about &cpuctx_mutex instead
> > of sb_pagefaults. 
> 
> Timing on where the cycle closes, most likely.
> 
> > There is no place we take the reloc_mutex and then do the
> > pagefaults stuff,
> 
> That's not needed, What the below tells us, is that:
> 
>   btrfs->bio/mq->cpuhotplug->perf->mmap_sem->btrfs
> 
> is a cycle. The basic problem seems to be that btrfs, through blk_mq,
> have the cpuhotplug lock inside mmap_sem, while perf (and I imagine
> quite a few other places) allow pagefaults while holding cpuhotplug
> lock.
> 
> This then presents a deadlock potential. Some of the actual chains are
> clarified below; hope this helps.
> 

Thanks Peter, that was immensely helpful.  I _think_ I see what's happening now,
this box has btrfs as the root fs, so we get the normal lock dependencies built
up from that.  But then we start a container that's a loopback device of a btrfs
image, and then that sucks in all of the loopback dependencies when we do the
device open, and then we get this splat.

I'm not sure how I'd fix this, the blk_mq_init_queue() has to happen under the
ctl_mutex I think.  I could probably figure out how to take that part away to
break the dependency chain between that mutex and the hotplug lock.  I'll stare
at it some more and see what I can come up with.

Thanks again for looking at this, I was very confused, usually my lockdep splats
are a much more direct "uh, you're an idiot" and less a complex chain of
dependencies like this.

Josef
