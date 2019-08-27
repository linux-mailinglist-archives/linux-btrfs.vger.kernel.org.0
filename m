Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 926549E732
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 13:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfH0L5o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 07:57:44 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39093 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfH0L5o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 07:57:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9so20941887qtu.6
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 04:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0X6o7gbR6ko7sC9vpbBi+61Y1CKy7UjfaTsp2dcx3sA=;
        b=W035m7ciKijUgn07NTvtm21hIOxXdVGwfPvK4eAuEYcLkOZ4CBjMlsXOssRPy09khn
         BM0vk56eIn6XzlPdpMCJgNmbj8QEYPYU12xgzCFeAAbcLLcbAmZk7290AhRr0JEkfOUN
         3gvQ+u5lgJFlBz04b0Rsv0Pa3AUsH1LTTGPGV7gVp9/GLAiHZcestv33lBxr/RQjx2zP
         Jw3fGlEUVv7WaR8kGRZdBfwEwrWELcTIVQaxGWhB9Y8eFrgc1gKGjWFMn+LP/xKHmtw8
         56JJmr4mziMLnD8/qb5B5s4uOLZ3YIcDHYLMytTXPMPlAcGJn4uyhO8b799Xv85gl19J
         DZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0X6o7gbR6ko7sC9vpbBi+61Y1CKy7UjfaTsp2dcx3sA=;
        b=NBEX9n9GrQ8iTfzJQhFnQA6cme0KD71YFoICVzVmpwSw3Lgi3T7Jyw2jKy/KJGqAUk
         S+kJf7Zb++jHsgMT/G581Ke0A1xFa6mAkpbXBziLqfYijgfbRLPqVJLbbR2hX3e358Ch
         iMMEQzeGSA0UUsmI68NY8/Y2rLrm22NHt4lLOWk0AEgksZJftcOevX5prLSiks9gdhCC
         LUImOihsZgcympv8kLbxxMarILqLy0AAaYryfl+tiAAR0z6fZ8uqCGdTt2SkvMKkqB1H
         vRHFpGwSyZPiJkHYb7CCRlGeyEfvYzO4Z+FzYI6nVQhLDTMWuMxilTz3KwXB7atQp9Vi
         rmZQ==
X-Gm-Message-State: APjAAAV9i/iXuvoIk1OjUjffguYf/4DcKzYXg7NBJ1MB9zgIADxgMhvN
        QAaTGU/nZe1fTYiT5so0M0IWTA==
X-Google-Smtp-Source: APXvYqyOkGJDMBXuim7niRySoDKT53CXbSMRFJWnxYzbVcHeTFWtD+WRHixorMckjRxyegRF7lWOGw==
X-Received: by 2002:ad4:45e6:: with SMTP id q6mr19778715qvu.13.1566907063366;
        Tue, 27 Aug 2019 04:57:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::50b4])
        by smtp.gmail.com with ESMTPSA id x68sm8325785qkc.16.2019.08.27.04.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 04:57:42 -0700 (PDT)
Date:   Tue, 27 Aug 2019 07:57:41 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] Btrfs: add ioctl for directly writing compressed
 data
Message-ID: <20190827115740.n57xrl7i7pshjkey@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1565900769.git.osandov@fb.com>
 <78747c3028ce91db9856e7fbd98ccbb2609acdc6.1565900769.git.osandov@fb.com>
 <20190826213618.qdsivmmwwlxkqtxc@macbook-pro-91.dhcp.thefacebook.com>
 <a9c8436c-ca94-081d-d83b-25360ebb8cb0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9c8436c-ca94-081d-d83b-25360ebb8cb0@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 27, 2019 at 09:26:21AM +0300, Nikolay Borisov wrote:
> 
> 
> On 27.08.19 г. 0:36 ч., Josef Bacik wrote:
> > On Thu, Aug 15, 2019 at 02:04:06PM -0700, Omar Sandoval wrote:
> >> From: Omar Sandoval <osandov@fb.com>
> >>
> >> This adds an API for writing compressed data directly to the filesystem.
> >> The use case that I have in mind is send/receive: currently, when
> >> sending data from one compressed filesystem to another, the sending side
> >> decompresses the data and the receiving side recompresses it before
> >> writing it out. This is wasteful and can be avoided if we can just send
> >> and write compressed extents. The send part will be implemented in a
> >> separate series, as this ioctl can stand alone.
> >>
> >> The interface is essentially pwrite(2) with some extra information:
> >>
> >> - The input buffer contains the compressed data.
> >> - Both the compressed and decompressed sizes of the data are given.
> >> - The compression type (zlib, lzo, or zstd) is given.
> >>
> >> A more detailed description of the interface, including restrictions and
> >> edge cases, is included in include/uapi/linux/btrfs.h.
> >>
> >> The implementation is similar to direct I/O: we have to flush any
> >> ordered extents, invalidate the page cache, and do the io
> >> tree/delalloc/extent map/ordered extent dance. From there, we can reuse
> >> the compression code with a minor modification to distinguish the new
> >> ioctl from writeback.
> >>
> > 
> > I've looked at this a few times, the locking and space reservation stuff look
> > right.  What about encrypted send/recieve?  Are we going to want to use this to
> > just blind copy encrypted data without having to decrypt/re-encrypt?  Should
> > this be taken into consideration for this interface?  I'll think more about it,
> > but I can't really see any better option than this.  Thanks,
> 
> The main problem is we don't have encryption implemented. And one of the
> larger aspects of the encryption support is going to be how we are
> storing the encryption keys. E.g. should they be part of the send
> format? Or are we going to limit send/receive based on whether the
> source/dest have transferred encryption keys out of line?
> 

Subvolume encryption will be coming soon, but I'm less worried about the
mechanics of how that will be used and more worried about making this interface
work for that eventual future.  I assume we'll want to be able to just blind
copy the encrypted data instead of decrypting into the send stream and then
re-encrypting on the other side.  Which means we'll have two uses for this
interface, and I want to make sure we're happy with it before it gets merged.
Thanks,

Josef
