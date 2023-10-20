Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621847D0FAC
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Oct 2023 14:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376956AbjJTMbA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Oct 2023 08:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377175AbjJTMbA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Oct 2023 08:31:00 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46542D49;
        Fri, 20 Oct 2023 05:30:58 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a8ada42c2aso7762647b3.3;
        Fri, 20 Oct 2023 05:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697805057; x=1698409857; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=po603pLa6+WCSRfB+kSK68fxdf9syke8GemdI09pYiI=;
        b=TweTCJmWt58QJ7k5GsMn9IadDX1CerCnT3A+hwl+vEzMtCDu3kzuq7TH4t9QlnMRc4
         six2o5MvuoaWvz4uX2LnlfZ+DuSIzVH2hkLahj1IoGTSkGqMgTZhBghdG4kvI75gba1e
         YfWC3hDFv+Nu7BeNO+mgihl0RNmGPH67/UIPE9WCXWqt0xLHAhYH+q96vPe+v8D5gm9L
         XIU0i1PSP6KsYdj7JwLJvUWgkZ/VhI4Kc0IGLNz1JB673YZx6LF/XrMff9hKMVHbAhus
         NJZL5Docy8NojZezpvn+jlk1CTgW/fQ16A3NjeQtES+BugVj34Arl+0L4Zuh281MVPWq
         DxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697805057; x=1698409857;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=po603pLa6+WCSRfB+kSK68fxdf9syke8GemdI09pYiI=;
        b=MkwtQsBAjSq+wUOzCO50p03KezTzlKsGmhht1mWcHEFj9Ur0s0A72d9pkovdQMqrzw
         5srzuxdy2R3eF++0hf2cRppvVByEMjmB9sjkXiaakvyb0x2jr0HNZRnou2Sdv27kk1OP
         ausBWtHynB5oZ6GNLyfx648exc6ZXfWXyCm6EpbtyKqk45v5/sHZMvLcFVt73chdQQ8Y
         uBwwuG7j19f5Tx/f6PuFxYt19VshZyZPh1BO9jahu80aIZwdw8uulq2b5WTtSxxN8SG9
         4PlaxtSaWLRQ6FT+VVd0TydV8Sjdg59to5mIYnuDwfnoO82HkvZIGD/kYmHcAv8FJzSb
         u4zA==
X-Gm-Message-State: AOJu0Ywrf7wwYFWSBbxws/i+/geabpZTMI60k8PW4Fwiy/gqLTXCWx+x
        RC4Rqj9TAYK41YW2SimMcnU=
X-Google-Smtp-Source: AGHT+IEOIarenbX043L5oIbX6lbvtuAP32bTGnwRaigZvMyalrTwJO+TskT/MUvUAG4FNXSH60Yzgw==
X-Received: by 2002:a81:4f57:0:b0:5a7:b8d4:60e1 with SMTP id d84-20020a814f57000000b005a7b8d460e1mr1817405ywb.9.1697805057406;
        Fri, 20 Oct 2023 05:30:57 -0700 (PDT)
Received: from localhost ([2607:fb90:3e1a:8bc6:bf58:5f88:bb90:604])
        by smtp.gmail.com with ESMTPSA id v77-20020a814850000000b005a7daa09f43sm641359ywa.125.2023.10.20.05.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 05:30:56 -0700 (PDT)
Date:   Fri, 20 Oct 2023 05:30:55 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dm-devel@redhat.com, ntfs3@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/13] ip_tunnel: convert __be16 tunnel flags to
 bitmaps
Message-ID: <ZTJy/7PMX/kGw2EL@yury-ThinkPad>
References: <20231016165247.14212-1-aleksander.lobakin@intel.com>
 <20231016165247.14212-12-aleksander.lobakin@intel.com>
 <20231018172747.305c65bd@kernel.org>
 <CAG_fn=XP819PnkoR0G6_anRNq0t_r=drCFx4PT2VgRnrBaUjdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=XP819PnkoR0G6_anRNq0t_r=drCFx4PT2VgRnrBaUjdA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 20, 2023 at 09:41:10AM +0200, Alexander Potapenko wrote:
> On Thu, Oct 19, 2023 at 2:27 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Mon, 16 Oct 2023 18:52:45 +0200 Alexander Lobakin wrote:
> > >  40 files changed, 715 insertions(+), 415 deletions(-)
> >
> > This already has at least two conflicts with networking if I'm looking
> > right. Please let the pre-req's go in via Yury's tree and then send
> > this for net-next in the next release cycle.
> 
> Yury, Andy,
> 
> The MTE part of my series will need to be reworked, so it might take a while.
> Shall I maybe send v8 of
> https://lore.kernel.org/lkml/20231011172836.2579017-1-glider@google.com/
> (plus the test) separately to unblock Alexander?
 
You better ask Alexander :). No objections from me.
