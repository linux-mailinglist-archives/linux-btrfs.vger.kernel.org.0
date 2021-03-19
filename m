Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581C23426B3
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Mar 2021 21:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhCSUNL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Mar 2021 16:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhCSUMs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Mar 2021 16:12:48 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378E6C061761
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 13:12:48 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id o5so4249539qkb.0
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Mar 2021 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2L5XeWgBJ+XEPLrrdKtx3vbv3j5UBuIU/axgHtMtD1U=;
        b=FfCjiLegZS6r4KqBXwc8QkZcVpvnzC2a/NYJraJfXH6WXfF9DPn/gU+cQt0jUxhy1n
         ugBHxqRKaKNn4SMLPHyMFYXxcxWfOuUDD5zn/aT43iFPr4p0RoBytr5QDLYtSz08Onvf
         oSX+3/EtMLJ05rkVPMP1NSdBkMMHa3luEPLA+VWBsvXA+EPRT/cR21UVrYj3o7nlMyw2
         xOGGwaGIi1evIa5TwMQ8y4uDMkU/4Ll3An1rGVi2n1h0a9M4g928kwyTn8Cu6OVP25I6
         CXcMixC1Bdl4MRiKdV2u5BaoZHHbisJK879qg5lTACrXT4saQ/qfHHr6h1kU3TaIIRjU
         24AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2L5XeWgBJ+XEPLrrdKtx3vbv3j5UBuIU/axgHtMtD1U=;
        b=e4mSH4c0PZMsJi8rKXWxLiUtwoMV3ffFrlCNO6UTXxHR4ExaAhCd2pHpwLFQ5aKlLu
         U8x0Pu+gCa7thskO1+A4Vn2pJoKtosQWmKpEZ6F+cg/B1zV8Bw/TuzDeM10FrM0rudbv
         jzJy0HChj3iGtPmCsSXfKgkXIp4IfL1ScHUk1Alp0Y42pcuZ/pOTzdN236LnlXo+pmT8
         SIXyaWLYo5y3rqyCAVr3b3G3edrQG+R/bDLcPxLYsNodsUdacTCv9Kc6kZPT3mjbMAtR
         rq2tOj6wYYLQwadZoju38lcSEfkqcC5b4BQV4ujDZDTiKPmS/QbX2MViqpITgkyYLJSH
         WG6g==
X-Gm-Message-State: AOAM533+CWSxE7VZSeYwl0b8T9f4e2uIhNWTnab99wKDQ7pbUndPwAjQ
        SRylnET67W8JLRk7rmOTN4w62A==
X-Google-Smtp-Source: ABdhPJwxGI2geq5FeY/Q8HkTPU1B8WtSBqZShlZnvAWHlpeKa6DACRduzDhLIVYsjubqNLPWXBw5vw==
X-Received: by 2002:a05:620a:14b3:: with SMTP id x19mr353016qkj.384.1616184767115;
        Fri, 19 Mar 2021 13:12:47 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s133sm5375476qke.1.2021.03.19.13.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 13:12:46 -0700 (PDT)
Subject: Re: [PATCH v8 00/10] fs: interface for directly reading/writing
 compressed data
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Omar Sandoval <osandov@osandov.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <cover.1615922644.git.osandov@fb.com>
 <8f741746-fd7f-c81a-3cdf-fb81aeea34b5@toxicpanda.com>
 <CAHk-=wj6MjPt+V7VrQ=muspc0DZ-7bg5bvmE2ZF-1Ea_AQh8Xg@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <58866f31-029f-3f70-55b6-8bda07ed6442@toxicpanda.com>
Date:   Fri, 19 Mar 2021 16:12:45 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj6MjPt+V7VrQ=muspc0DZ-7bg5bvmE2ZF-1Ea_AQh8Xg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/19/21 4:08 PM, Linus Torvalds wrote:
> On Fri, Mar 19, 2021 at 11:21 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> Can we get some movement on this?  Omar is sort of spinning his wheels here
>> trying to get this stuff merged, no major changes have been done in a few
>> postings.
> 
> I'm not Al, and I absolutely detest the IOCB_ENCODED thing, and want
> more explanations of why this should be done that way, and pollute our
> iov_iter handling EVEN MORE.
> 
> Our iov_iter stuff isn't the most legible, and I don't understand why
> anybody would ever think it's a good idea to spread what is clearly a
> "struct" inside multiple different iov extents.
> 
> Honestly, this sounds way more like an ioctl interface than
> read/write. We've done that before.

That's actually the way this started

https://lore.kernel.org/linux-fsdevel/8eae56abb90c0fe87c350322485ce8674e135074.1567623877.git.osandov@fb.com/

it was suggested that Omar make it generic by Dave Chinner, hence this is the 
direction it took.  I'll leave the rest of the comments for Omar to respond to 
himself.  Thanks,

Josef
