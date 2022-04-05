Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBE94F4787
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 01:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243254AbiDEVMo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 17:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358506AbiDEUuF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 16:50:05 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9627862A2D
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 13:24:27 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id t4so400922ilo.12
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 13:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a7zU46dIIYLz+0rZD5Swv0n04z5EVkv57j+hpFLVKd8=;
        b=iwSmE1xsAYvP1N+EzvwtWAi5qXT7hhLbY8eKqqno93qNeFh7EHrRK7BFcGi3U+46q/
         sRg9yY1+oGYDwMQ4MUKtV1yhnL53uvO/gb7XeAwyIN4byG8URGIo6pK2IctTiXZswXHp
         Xw02HtVVf/B2OZcia2YpvtcYIr2ISRYQxtEXeGOnPWq1wNt5hLZa34PFI5mEByusfjXa
         bD8p+exALBX02yCgCPhPS8s90Am0IqBJC2HjuFW3Qx5yEwN3nIfIVwGADq5Ju09AXYAO
         dAReHvwS/0VRH2W8NZDkEZ5IM6woUPh+b/sQZVNhwyGu6i6LGoT2g/8hi48SOuwRtqID
         kqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a7zU46dIIYLz+0rZD5Swv0n04z5EVkv57j+hpFLVKd8=;
        b=4f5MJOZI7ZxuT4a9Le1oPixMLiLaGBRYQ0+fX+ofz4fnu75PFQxONVP2mENV+8J0jR
         8cWO9xH/tAShHO4Y6xED/VUA38Qn1SZfMZFkAhiSx/QSuVOTSM+9vYAroen28jM6kZBW
         SehSlGqx2MmolKrpGCD7ysvYUiBYITfnfRmbZME6EIkB+33VeJI4xxMLpRJmaeSP/Gu9
         rpFskze+ficMqJsGTnaabFgFO6eD3XELrPM4yHSR8jgcQIutHpyKKdrlSdmEjHwa3ZEt
         1MWMoVFjdfKQpIlkKsB94b3hE390xUYk/+HZzGPG18PpPPmbxHPOAYwo60PVd3qH4bLJ
         uF0w==
X-Gm-Message-State: AOAM532QUf6OIqx2/2mxvUmVRkk/O8VEHBgkVZ6jGzOb1eSc7M6NkiTp
        28CKu1eZi8uAyA8sGKdfWv32sAudycdxMIF4lS1F1ovFcCJR2A==
X-Google-Smtp-Source: ABdhPJzN6wHpojhUaKSWdY6VJpv7QfytLN/ZBVwL9kAU1hfMDlZlO6F1A7BmzxtxvlLc/PBIa4uw01Sz8ZsFlpRk7l4=
X-Received: by 2002:a05:6e02:b4d:b0:2c8:45ac:66b1 with SMTP id
 f13-20020a056e020b4d00b002c845ac66b1mr2776120ilu.153.1649190266903; Tue, 05
 Apr 2022 13:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqd6kePW6eiMB-R4DvMRvU=AK-jKpkBNUvSjttsSEsCwpA@mail.gmail.com>
 <20220405155311.GJ5566@merlins.org> <CAEzrpqehq1tt5O_6jarggYK4dvyWCJ8O=_ps_qXuQbVJ9_bC6g@mail.gmail.com>
 <CAEzrpqdjTRc2VQBGGRB3Dcsk=BzN2ru-fA2=fMz__QnFubR7VQ@mail.gmail.com>
 <20220405181108.GA28707@merlins.org> <CAEzrpqc=h2A42nnHzeo_DwHik8Lu0xfkuNm2mhd=Ygams6aj=w@mail.gmail.com>
 <20220405195157.GA3307770@merlins.org> <CAEzrpqeQ=Q8u+Kgy6r+axYdbrZKs9=9cvMwEfKr=O2urgZTXHw@mail.gmail.com>
 <20220405195901.GC28707@merlins.org> <CAEzrpqe-tBN9iuDJPwf7cj7J8=d6gtr27LnTat9nZiA7iVERNQ@mail.gmail.com>
 <20220405200805.GD28707@merlins.org>
In-Reply-To: <20220405200805.GD28707@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 5 Apr 2022 16:24:16 -0400
Message-ID: <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 5, 2022 at 4:08 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Apr 05, 2022 at 04:05:05PM -0400, Josef Bacik wrote:
> > Well it's still the same, and this thing is 20mib into your fs so IDK
> > how it would be screwing up now.  Can you do
> >
> > ./btrfs inspect-internal dump-tree -b 21069824
> >
> > and see what that spits out?  IDK why it would suddenly start
> > complaining about your chunk root.  Thanks,
>
> Thanks for your patience and sticking with me
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs inspect-internal dump-tree -b 21069824 /dev/mapper/dshelf1a >/dev/null

Ok well that worked, which means it found the chunk tree fine, I'm
going to chalk this up to it just fucking with me and ignore it for
now.  I pushed some changes for the find root thing, can you re-run

./btrfs-find-root -o 1 /dev/whatever

it should be less noisy and spit out one line at the end, "Found tree
root at blah blah".  Thanks,

Josef
