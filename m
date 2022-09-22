Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F685E67C2
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 17:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiIVP4q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Sep 2022 11:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiIVP4k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Sep 2022 11:56:40 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD22EE5F99
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 08:56:38 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c24so9193610plo.3
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 08:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=TZpRIJCCMZKyVUgNnwboEjnHYpEIRQBSXZlSwc7OZ+0=;
        b=lKwDDBjvYm/0Jleq+GCxBaTtwnHH7tK+nJ5dJ9Mroo7Wx2WiOGB/Kmka/kC9bYFq8z
         aE3zrV852KZPixgDhOan1L1Vq5Tj1ydcVjIMjp+7gLHmlIsooLMnRpZ01jzKR4yf16m5
         6AQEJMsyFTKj/8+82bO+4x4lXyaSTMa1R26kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=TZpRIJCCMZKyVUgNnwboEjnHYpEIRQBSXZlSwc7OZ+0=;
        b=XlUWZIuk4WwoW8m4IMRG9L4b/GHl1myqInbaexBoeaBmV6tv0G6aBoYxVTGOAHMRkl
         P3Z0JYp+bi8CswlQXRpmpH/VKy54mArSeurtXs6cEtcIezTtr+t7zX+XxKvWV132XrX9
         Gc8e8mkDEQNpMoJ2iz/7S2Qm47SLwzB+dKz7sYFGBsKlG/w7cT5/jlp2POvNCWszP4wC
         7RYeSvga1BQwEmS89mCX9plOkCWmNj2SqiWAHYhqiVp68bs6ZDW3UtX1Vkl/Oc6CImSR
         W5yEBYBnBInos0nV0KZyLjbwoUAX5mkZJxvLnrIpRUpT3cD2rXvIhHQMknsTRJKQeff8
         V9yw==
X-Gm-Message-State: ACrzQf2Y5GyRv/r7P43BIlDJEKxHnxBMgG0odwv5qz0f0WfXJeMmHgcp
        rqcpeISncQqqJ+CD7CM0IthY0A==
X-Google-Smtp-Source: AMsMyM6wj70ZRZNEGtsTQjOpU6Y4OkbiX+0Wag8Z4tUWxe6CdbDk3WijTof+igifPO84VXufZHizeQ==
X-Received: by 2002:a17:90b:4d8e:b0:200:73b4:4da2 with SMTP id oj14-20020a17090b4d8e00b0020073b44da2mr16393990pjb.197.1663862197527;
        Thu, 22 Sep 2022 08:56:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d50500b00176ca533ea0sm4327600plg.90.2022.09.22.08.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 08:56:36 -0700 (PDT)
Date:   Thu, 22 Sep 2022 08:56:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Hao Luo <haoluo@google.com>, Marco Elver <elver@google.com>,
        linux-mm@kvack.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Yonghong Song <yhs@fb.com>, Miguel Ojeda <ojeda@kernel.org>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, dev@openvswitch.org,
        x86@kernel.org, linux-wireless@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 11/12] slab: Remove __malloc attribute from realloc
 functions
Message-ID: <202209220855.B8DA16E@keescook>
References: <20220922031013.2150682-1-keescook@chromium.org>
 <20220922031013.2150682-12-keescook@chromium.org>
 <CANiq72=m9VngFH9jE3s0RV7MpjX0a=ekJN4pZwcDksBkSRR_1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=m9VngFH9jE3s0RV7MpjX0a=ekJN4pZwcDksBkSRR_1w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 22, 2022 at 11:23:46AM +0200, Miguel Ojeda wrote:
> On Thu, Sep 22, 2022 at 5:10 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > -#ifdef __alloc_size__
> > -# define __alloc_size(x, ...)  __alloc_size__(x, ## __VA_ARGS__) __malloc
> > -#else
> > -# define __alloc_size(x, ...)  __malloc
> > -#endif
> > +#define __alloc_size(x, ...)   __alloc_size__(x, ## __VA_ARGS__) __malloc
> > +#define __realloc_size(x, ...) __alloc_size__(x, ## __VA_ARGS__)
> 
> These look unconditional now, so we could move it to
> `compiler_attributes.h` in a later patch (or an independent series).

I wasn't sure if this "composite macro" was sane there, especially since
it would be using __malloc before it was defined, etc. Would you prefer
I move it?

-- 
Kees Cook
