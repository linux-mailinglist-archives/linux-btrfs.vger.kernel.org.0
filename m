Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D71735FB23
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Apr 2021 20:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhDNSyZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Apr 2021 14:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhDNSyY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Apr 2021 14:54:24 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AE1C061574;
        Wed, 14 Apr 2021 11:54:02 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id n12so23280678ybf.8;
        Wed, 14 Apr 2021 11:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=flmIDluCNeh75YeiVOPif0ZTE+n5s/nCyOwAZlpQU7o=;
        b=kekdDeOjmHaMG2fuZJyLFX5hme1rCH1Tdsme1LNpWtdEAw2Pgtl48jeDVEDfhr75st
         SCl9q0WjhPR+SDZfbO/tCseQn9B384gU1QGqu7hJgmDi3wyzdAdTu61oolRZ1ul7IkMq
         EbKZpP6wE9m9YWFO0XW8L6i7S5vA0KmX7MlCeswOoWHhvb0YGKdruCdo0QAsqyxnfDBK
         qGbkTib8gzxtXVvgYVPbkpGzhLJsV1Gsq5BI1wLZN9Sbx20AbBn+mNkanZip6rBPA6+H
         aN/w0f/DCnVpuTwtoBcvAdyMp6BDkoeSQDGDuioOXGVlSDQsJsycqP9psTE1sdhqLY4G
         9iHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=flmIDluCNeh75YeiVOPif0ZTE+n5s/nCyOwAZlpQU7o=;
        b=LVcacozwWAfEJfoDC+S2lIBHfrpbq26Vuut6VVsMezxcN8W/ifktqWjWA9BDUnz2vf
         Q1XvugK1OVHKKon6VfooEMDCztEljyLJwqJc24d0KW9OK405DZ0AneZ2vkGGV/wMklQZ
         Ffiex8qLKE+tP4u3wZdy/I6dKpfRaH5Syjayc7PlRidfKjJh3CDHIn1C3PYP8l+W3wxj
         GqxVFxDlM3dhNCB+VnHRdkS+EbGVZ/KDLuoBbOqdFNTzABZARwXXSh/w+KoHLB/69fCo
         U8O5Vi4bgUKevDhtMncRP5RL4GUPeNcqMgfWD9GZVXMVBKhqWHlp0CRTinn17m14z4mX
         iW6g==
X-Gm-Message-State: AOAM530l9enXTs9gkTO6xtlWziD2KV+U1hSSHDeHWHHn6qBg2VeqYdW1
        3hplFoMHKPmaNL8mZJk+pW2+ZIeCAqwp4nQH58hI7MZmjjk=
X-Google-Smtp-Source: ABdhPJyrW3O8NO3th8zugZp2JKtf2V5GrYLoUcTLB9FXu+ENrG2LNJFpEF3qEdvn+wO3N1wM0QysC8QWV4luIxIw/Hk=
X-Received: by 2002:a25:becf:: with SMTP id k15mr41711527ybm.83.1618426442030;
 Wed, 14 Apr 2021 11:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210330225112.496213-1-nickrterrell@gmail.com>
 <CANr2DbfL2B5Tx+k1AwVh-5dQZ+fNpucJKu9QVQat7QVvK-5AbQ@mail.gmail.com>
 <CANr2DbfZ+fV+GN7CfDi1AFmfsdnX+kGnTA6kayEchtGwfoAE-A@mail.gmail.com> <YHc16rz4Y/PkzNH1@gmail.com>
In-Reply-To: <YHc16rz4Y/PkzNH1@gmail.com>
From:   Nick Terrell <nickrterrell@gmail.com>
Date:   Wed, 14 Apr 2021 11:53:51 -0700
Message-ID: <CANr2Dbc+2rS7seuXGtU6Y+x0Qv+hrtwz71r+akKeQUXECZaJZA@mail.gmail.com>
Subject: Re: [GIT PULL][PATCH v9 0/3] Update to zstd-1.4.10
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        squashfs-devel@lists.sourceforge.net,
        Johannes Weiner <jweiner@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        Yann Collet <cyan@fb.com>, David Sterba <dsterba@suse.cz>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, Petr Malat <oss@malat.biz>,
        Chris Mason <clm@fb.com>, Nick Terrell <terrelln@fb.com>,
        linux-crypto@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Kernel Team <Kernel-team@fb.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Niket Agarwal <niketa@fb.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 14, 2021 at 11:35 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Apr 14, 2021 at 11:01:29AM -0700, Nick Terrell wrote:
> > Hi all,
> >
> > I would really like to make some progress on this and get it merged.
> > This patchset offsers:
> > * 15-30% better decompression speed
> > * 3 years of zstd bug fixes and code improvements
> > * Allows us to import zstd directly from upstream so we don't fall 3
> > years out of date again
> >
> > Thanks,
> > Nick
> >
>
> I think it would help get it merged if someone actually volunteered to maintain
> it.  As-is there is no entry in MAINTAINERS for this code.

I was discussing with Chris Mason about volunteering to maintain the
code myself.
We wanted to wait until this series got merged before going that
route, because there
was already a lot of comments about it, and I didn't want to appear to
be trying to bypass
any review or criticisms. But, please let me know what you think.

Best,
Nick

> - Eric
