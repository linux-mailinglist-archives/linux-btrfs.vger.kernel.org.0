Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6A67D0FDF
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Oct 2023 14:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377389AbjJTMqR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Oct 2023 08:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377437AbjJTMqL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Oct 2023 08:46:11 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21A610F0;
        Fri, 20 Oct 2023 05:46:03 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a81ab75f21so8124947b3.2;
        Fri, 20 Oct 2023 05:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697805963; x=1698410763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jps82JBDACzoR3tUfyIbEtBbVZCxrcf9ApmwOX34umg=;
        b=laXN9bG1zVF8AtIP8UkdsW4iRjoCMsoW78sUky8pqGfIcUCKqVF3FjUMaqPVB0aEIL
         ku62I1LU5ZzawW4qAepATyBTtIpAj047WXFJ2Rk67D3TnSRHuGhKP+1IF9HsScbgq3ZF
         LlLL6M/td5VDMMdOm5eWny9ezycVrh/AYKwnN6g8uBfkldhZAwetXX6HmhKkyZ56LwFb
         4zFtVi5Nk8hiKI+xlolDk5yPwcLx783Gk25bf55nY4VoGR+EDnSNWpAPClKNMJ1VpxiU
         z0G5SdkX3fdaVud8BbJGZbXNGgrLeQf1OXj9iAu1BxZpsQ+g9Mt4x3nQ8yGfOn0pqNsx
         kDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697805963; x=1698410763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jps82JBDACzoR3tUfyIbEtBbVZCxrcf9ApmwOX34umg=;
        b=qhuh/oRxJJJgUOCEPj+/kKXMzOgkjr7fL9gBRn6SAElBVOWH858SZblwIGsgmkiaxA
         +Xszia2hqTZ6i6y81L2LLECOnYmDvJzB1Pm5ctrvy71+ZcmlhpzqfQAsdrljlNcD8rjK
         T0aGk0GpJQUVcTll1KvBXUYn24HHtLmgSBBiU3nymeAx736cTTBSXz/FEuAn+Cv2aOQu
         j2H/jvtSaslQHVqwm4Yk3kxFSEied0IXl8tIFccV9NQyHPSbzgVXRZCrtF3zJXPIq5TU
         ln2ITDKAZJU3VrTCmkwxvNVzlB6qD6HOA7DQRPBVQMP+Q+o6Iyk2nq4yjj9tkohWa1qJ
         idXw==
X-Gm-Message-State: AOJu0YyU70G84/rrY/EOfaMmxuxuAOeVssndcSr1hKLOcMFnSLrfQFyR
        W+1mZRGhwQvdvkrr8y+JZMQ=
X-Google-Smtp-Source: AGHT+IE6t/1v27h+fcqmTdO36JdundJNToc6FICMQ+l92k0VypVbJHWYvo6kei8XbZDOyOkNc3/wwA==
X-Received: by 2002:a05:690c:dc4:b0:5a7:aa54:42b1 with SMTP id db4-20020a05690c0dc400b005a7aa5442b1mr2232055ywb.28.1697805962604;
        Fri, 20 Oct 2023 05:46:02 -0700 (PDT)
Received: from localhost ([2607:fb90:3e1a:8bc6:bf58:5f88:bb90:604])
        by smtp.gmail.com with ESMTPSA id m205-20020a8171d6000000b0059af121d0b8sm654571ywc.52.2023.10.20.05.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 05:46:01 -0700 (PDT)
Date:   Fri, 20 Oct 2023 05:46:00 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Potapenko <glider@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-btrfs@vger.kernel.org, dm-devel@redhat.com,
        ntfs3@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/13] ip_tunnel: convert __be16 tunnel flags to
 bitmaps
Message-ID: <ZTJ2iKk3sBFzVQJl@yury-ThinkPad>
References: <20231016165247.14212-1-aleksander.lobakin@intel.com>
 <ZS148saIsG7WY8ul@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS148saIsG7WY8ul@yury-ThinkPad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

+ Stephen

On Mon, Oct 16, 2023 at 10:55:02AM -0700, Yury Norov wrote:
> On Mon, Oct 16, 2023 at 06:52:34PM +0200, Alexander Lobakin wrote:
> > Based on top of "Implement MTE tag compression for swapped pages"[0]
> > from Alexander Potapenko as it uses its bitmap_{read,write}() functions
> > to not introduce another pair of similar ones.
> > 
> > Derived from the PFCP support series[1] as this grew bigger (2 -> 13
> > commits) and involved more core bitmap changes. Only commits 10 and 11
> > are from the mentioned tree, the rest is new. PFCP itself still depends
> > on this series.
> > 
> > IP tunnels have their flags defined as `__be16`, including UAPI, and
> > after GTP was accepted, there are no more free bits left. UAPI (incl.
> > direct usage of one of the user structs) and explicit Endianness only
> > complicate things.
> > Since it would either way end up with hundreds of locs due to all that,
> > pick bitmaps right from the start to store the flags in the most native
> > and scalable format with rich API. I don't think it's worth trying to
> > praise luck and pick smth like u32 only to redo everything in x years :)
> > More details regarding the IP tunnel flags is in 11 and 13.
> > 
> > The rest is just a good bunch of prereqs and tests: a couple of new
> > helpers and extensions to the old ones, a few optimizations to partially
> > mitigate IP tunnel object code growth due to __be16 -> long, and
> > decouping one UAPI struct used throughout the whole kernel into the
> > userspace and the kernel space counterparts to eliminate the dependency.
> > 
> > [0] https://lore.kernel.org/lkml/20231011172836.2579017-1-glider@google.com
> > [1] https://lore.kernel.org/netdev/20230721071532.613888-1-marcin.szycik@linux.intel.com

[...]

> > ---
> > Not sure whether it's fine to have that all in one series, but OTOH
> > there's not much stuff I could split (like, 3 commits), it either
> > depends directly (new helpers etc.) or will just generate suboptimal
> > code w/o some of the commits.
> > 
> > I'm also thinking of which tree this would ideally be taken through.
> > The main subject is networking, but most of the commits are generic.
> > My idea is to push this via Yury / bitmaps and then ask the netdev
> > maintainers to pull his tree before they take PFCP (dependent on this
> > one).
> 
> Let's wait for more comments, but I'm generally OK with the generic
> part, and have nothing against moving it, or the whole series, through
> bitmap-for-next.

I put this into bitmap-for-next, and it caused build failures for
Stephen:

https://lore.kernel.org/lkml/20220722191657.1d7282c2@canb.auug.org.au/

I can reproduce them too. So, removing from -next. Alexander, can you
run another round with all found issues fixed?

Thanks,
Yury
