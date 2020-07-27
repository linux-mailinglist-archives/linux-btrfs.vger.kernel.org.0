Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E222B22F698
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jul 2020 19:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbgG0R1P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 13:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgG0R1P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 13:27:15 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41281C061794
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jul 2020 10:27:15 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c12so3795610qtn.9
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jul 2020 10:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Y6S1pUsrWqelpgs7R4nTyMt8j3bJix9SonbAbOgq9Fw=;
        b=kIzQ+aYlVJggLEWM6K6JK2T495HpxqjKiPnFsocjQmsCldRuV4VReqtPmGk8Mqbf3y
         xlziDX23f+PVOsxVG/PGJ8sDZfGhYml7ao7AtNe0WKWt/Pqch9NFtSPxignHnxyiRVeL
         9AgH/Q74XZY62XYWwF2LkfUUu1MUvcZiwAq5l+xILozybDo4uMj78+p2NCspNJwSdgsF
         rPDdrjq8P3oeL3o8M8unO8L2SUjDS+jawQUpj7fL8mGVQSxbnqFSAzSno6B/X6JamLbn
         KfPREu42fgfzeaLcObltN5LzqEY4pNykaFOuXlD7l8sCevOKLjtGKqVdj8cPL7Sb3qBx
         w8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y6S1pUsrWqelpgs7R4nTyMt8j3bJix9SonbAbOgq9Fw=;
        b=gJSs8m+mYcQ627/6Cf4tai28IWK+wbbA8hjs+JAh07kuEgKAHCvLh2fd38oA9cEgy5
         U3IyqyRw3+mQ2WxTR4S6Wi/16YbRbZUdBKJktYTkZXUW2r0/rt0q6M7iPfAyG54Vq4iV
         TAFWSUreszRlw3OfRRfXaDuNlxkU1b72ImlkrsgQzI9VMOuNtPKJD2NCsb6oh41IpDY8
         aHmuipFCOSpD2Ui1j9KXwgD8pES2yQvjYdbXxNo3Mn6aYpl443GeOl4ExDk8q2w2r6Ci
         ibtzwU5UWO3Ws+4wtFbGJkakeMVzKVynUhlOUwZHB1KdUb8shAvIYs0o3fFAETWrvUkP
         tFNA==
X-Gm-Message-State: AOAM532XhjWJxRMrdk1es/LRV2UUwG1fL2ZWkuUnD3a2DNszAynHXzkD
        /y8ejfYNvkImfajhOl5V9dg6UQ==
X-Google-Smtp-Source: ABdhPJxNztjAQ6i/SgY0kUJizXKP2PfMhRLUO15cezrziNfkVGcIJtbgkvaoo6Vxs6DzvK/ihWHMkg==
X-Received: by 2002:ac8:7698:: with SMTP id g24mr23188712qtr.217.1595870834317;
        Mon, 27 Jul 2020 10:27:14 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u21sm18488564qkk.1.2020.07.27.10.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 10:27:13 -0700 (PDT)
Subject: Re: [PATCH] btrfs: do not evaluate the expression with
 !CONFIG_BTRFS_ASSERT
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200724164147.39925-1-josef@toxicpanda.com>
 <20200727165501.GQ3703@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <429f7cc2-4664-440d-6151-8e371f08ff47@toxicpanda.com>
Date:   Mon, 27 Jul 2020 13:27:12 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727165501.GQ3703@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/27/20 12:55 PM, David Sterba wrote:
> On Fri, Jul 24, 2020 at 12:41:47PM -0400, Josef Bacik wrote:
>> While investigating a performance issue I noticed that turning off
>> CONFIG_BTRFS_ASSERT had no effect in what I was seeing in perf,
>> specifically check_setget_bounds() was around 5% for this workload.
> 
> Can you please share the perf profile and .config?  I find it hard to
> believe that check_setget_bounds would be taking 5% overall. Also you
> said that this was with integrity-checker compiled in so this kind of
> invalidates any performance claims.
> 

How?  It was a straight A/B test, do you think I'm making this up?

> I've been watching perf top for various debugging and release builds for
> some time and this one makes it to top 5 but never #1 or #2.
> 
> The function compiles to a few instructions and the hot path is
> correctly predicted by compiler, so I'm really curious what's so special
> about the workload that it needs to call it in 1/20th of overall time.
> 
>> Upon investigation I realized that I made a mistake when I added
>> ASSERT(), I would still evaluate the expression, but simply ignore the
>> result.
> 
> Vast majority of the assert expressions are simple expressions without
> side effects, but compiler still generates the code. In most cases it's
> a few no-op movs, so this leaves the impact on the function calls.
> 
> Making the assert a true no-op saves some asm code and gains some
> performance, but I don't want to remove the check_setget_bounds calls as
> it's another line of defence against random in-memory corruptions.
> 
> Given that it's called deep inside many functions, it would be
> impractical to add checking of each call. Instead, we can set a bit and
> do a delayed abort in case it's found. I have that as a prototype and
> will post it later.

Then make it configurable, because with ECC memory the performance overhead 
isn't worth it.

> 
>> This is useless, and has a marked impact on performance.  This
>> microbenchmark is the watered down version of an application that is
>> experiencing performance issues, and does renames and creates over and
>> over again.  Doing these operations 200k times without this patch takes
>> 13 seconds on my machine.  With this patch it takes 7 seconds.
> 
> Do you have that as a script?
> 

Yeah, you can find it here.  It was written by somebody internally to illustrate 
an issue they're seeing with their application.

https://paste.centos.org/view/f01126bf

Thanks,

Josef
