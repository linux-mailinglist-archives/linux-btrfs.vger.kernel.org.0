Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A808F4EC909
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 18:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348496AbiC3QFE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 12:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347537AbiC3QFD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 12:05:03 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964C2223224
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 09:03:17 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id j13so20809474plj.8
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 09:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ABS5RaDizOOxxZFwl9O2FRDLc7MT+a0LL7KHwTVFfs=;
        b=wbEAVtmOaNk8ULWhkU3abb9TRZoVeC7dF/LvVJaJLjuqC975dusSyXqcE7NoSHArTX
         SUiv/VzTSAHIYUXXHdsE36zXOzQv/McUvL3wCdaV4TT0CUrQz50id7uGglrwgHyZf2nS
         QZpTRW/R/nKOKZt6UAn4l/hkQJJVtYvy7iKfvgTMBSKCm0xA9V5KWHzvkNo4UWb1YK/Q
         tkX6Eqp6QyrCBcmeGwJ7GeaKsELD+5SkUQ68xdPFhc4FvXkpFRYZoP3udJKcH8NNY5CR
         nyKV8js9JHs/lebhROAbpmFhfyK6lboevmutBN6UT37Vi5c9qaykRftfzU2bw6DBlHhs
         2j5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ABS5RaDizOOxxZFwl9O2FRDLc7MT+a0LL7KHwTVFfs=;
        b=rfw3g7UuI/WtVeCVg17xskrOueX0zvddsdMsY4JReJiQjzijTq0eJGi6uRgUvbdmSq
         L3sGojyQKZ/M+StCy1Gq2gffARvWU7MTjEycjft7KsNo4iZKFVqjCCYr/2OpDDf4VaWg
         qmkarohv5Tzv9w2bHMqLMYM0hF7CrxAzwo1dqQDMhcHEM23AfjQKMjBUkazaQOjXtCN0
         TTvm56/LhsxpykgLtR1TFZSZXzN03fST4bSU4BCILYxi+wEXz1ejTbC99jikHqHv9C7l
         L1/HX21Qsisx/1eVmqRls9qDL/pbsX/3KBBbTn+v5JhtoHmhkZt8dAyR0qCWL8me+Ch1
         8k/g==
X-Gm-Message-State: AOAM530SCIUbAYPi3yNpUWUMWbEWyGAgwtGs6Tdl34GQ9a532AlbyTe5
        ni5pa4zNFxvpo3hRtVoTVs0zwg==
X-Google-Smtp-Source: ABdhPJyNP+ko8653MxRYs+qCjoycO5v/hMO9ctN6MYYLdfFjR2NL/EtY2W76uFHVc1M4sgqCwuI33Q==
X-Received: by 2002:a17:902:ce8e:b0:154:2ebc:8d49 with SMTP id f14-20020a170902ce8e00b001542ebc8d49mr269232plg.135.1648656196988;
        Wed, 30 Mar 2022 09:03:16 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:3897])
        by smtp.gmail.com with ESMTPSA id a11-20020a63cd4b000000b00378b9167493sm20084837pgj.52.2022.03.30.09.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 09:03:16 -0700 (PDT)
Date:   Wed, 30 Mar 2022 09:03:14 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v14 5/7] btrfs: send: allocate send buffer with
 alloc_page() and vmap() for v2
Message-ID: <YkR/QuBrKPYTwIFt@relinquished.localdomain>
References: <cover.1647537027.git.osandov@fb.com>
 <4353fe7122eb0aae24e3c9ff2399f2b58b74f79e.1647537027.git.osandov@fb.com>
 <fb73fe9a-21a4-0744-2a61-bfd3602a0f20@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb73fe9a-21a4-0744-2a61-bfd3602a0f20@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 24, 2022 at 01:53:20PM -0400, Sweet Tea Dorminy wrote:
> 
> 
> On 3/17/22 13:25, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > For encoded writes, we need the raw pages for reading compressed data
> > directly via a bio.
> Perhaps:
> "For encoded writes, the existing btrfs_encoded_read*() functions expect a
> list of raw pages."
> 
> I think it would be a better to continue just vmalloc'ing a large continuous
> buffer and translating each page in the buffer into its raw page with
> something like is_vmalloc_addr(data) ? vmalloc_to_page(data) :
> virt_to_page(data). Vmalloc can request a higher-order allocation, which
> probably doesn't matter but might slightly improve memory locality. And in
> terms of readability, I somewhat like the elegance of having a single
> identical kvmalloc call to allocate and send_buf in both cases, even if we
> do need to initialize the page list for some v2 commands.

I like this, but are we guaranteed that kvmalloc() will return a
page-aligned buffer? It seems reasonable to me that it would for
allocations of at least one page, but I can't find that written down
anywhere.
