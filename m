Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939B1435460
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Oct 2021 22:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhJTUNz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 16:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbhJTUNy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 16:13:54 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8C6C061749
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Oct 2021 13:11:39 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t9so308307lfd.1
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Oct 2021 13:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2mjyTuiMt0G/NI9j2uGhr176LQ8tHUDaZsPCBpnXywo=;
        b=JNYtSv2gblmlTKXiqtL4y6TtoOuGzc68cZHueN9cP+lj++0rs+VLST38HhlFDoPg2f
         q/iXqIc7waXQwRes5r5w9NeAF++++Ur7bf/OJfMU2qanF+BgkZ215gZA/vba1jIbqtrg
         YKY42GAegLHMretczDWyIsPvSaAr/LVgePt/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2mjyTuiMt0G/NI9j2uGhr176LQ8tHUDaZsPCBpnXywo=;
        b=or9Y0SRm4hxDK5YR6ANl6uQ8XOcnogMRMhewrASTIflsvrBYcvOsWwLDrAm2Th+V0o
         k/H8Zr/kG/DKoH1TEWjG1Lhf1d+QDgd9Wy9kZcSm2imKqUcZ90eQYpNVuXm0JbZtiSTR
         X+p+71VUxi19pkZBtd2/YiQBg/5/EEIyZZvYqGQfWY1G41wJfuX7r4yIp+OzYx4VmIkY
         6+CCC2V8MMD0XcykTH7Ay+66z53vgdVqJZs7KnGSdDU4rZJRewzT+tVLKBb6ieiKnSWi
         wWREW/wzLuTMfImnPIqLxKoK+rC1YmvJBTukRdmJidWKaMXHuXAkWMKn6HAZ3BSSFcKS
         hWWA==
X-Gm-Message-State: AOAM533+ZwEdytVWZKkaVFDRXhmHBFslWsRwTigFLpiLFpALtrt/IXGx
        Mr/bhZkWzn0u3j9toKnl8X36m0ZzJpKu1Xke
X-Google-Smtp-Source: ABdhPJxT824/tISXoHHZRTsug/GMxuyvXIzGJAdXKLTw6JL/kRvsD3GcTOvM9+TbsP/X2VCvxqHsCw==
X-Received: by 2002:a05:6512:4dd:: with SMTP id w29mr1348676lfq.588.1634760697606;
        Wed, 20 Oct 2021 13:11:37 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id i13sm270660lfb.45.2021.10.20.13.11.35
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 13:11:36 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 204so35427ljf.9
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Oct 2021 13:11:35 -0700 (PDT)
X-Received: by 2002:a2e:9945:: with SMTP id r5mr1210626ljj.249.1634760695569;
 Wed, 20 Oct 2021 13:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211019134204.3382645-1-agruenba@redhat.com> <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
 <YXBFqD9WVuU8awIv@arm.com>
In-Reply-To: <YXBFqD9WVuU8awIv@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Oct 2021 10:11:19 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgv=KPZBJGnx_O5-7hhST8CL9BN4wJwtVuycjhv_1MmvQ@mail.gmail.com>
Message-ID: <CAHk-=wgv=KPZBJGnx_O5-7hhST8CL9BN4wJwtVuycjhv_1MmvQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] gfs2: Fix mmap + page fault deadlocks
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 20, 2021 at 6:37 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> The atomic "add zero" trick isn't that simple for MTE since the arm64
> atomic or exclusive instructions run with kernel privileges and
> therefore with the kernel tag checking mode.

Are there any instructions that are useful for "probe_user_write()"
kind of thing? We could always just add that as an arch function, with
a fallback to using the futex "add zero" if the architecture doesn't
need anything special.

Although at least for MTE, I think the solution was to do a regular
read, and that checks the tag, and then we could use the gup machinery
for the writability checks.

                Linus
