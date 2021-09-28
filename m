Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC2441B279
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Sep 2021 16:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241434AbhI1PBf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 11:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241265AbhI1PBf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 11:01:35 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F479C06161C
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 07:59:55 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y28so93230246lfb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 07:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fInY95no8O0JEStBsdbpcymzt287B66Fcqaxhkug+c=;
        b=FfNByYfUegGHsII+I3f5TVFbSZkKQ34sMp4OH9feQ01FDoaO1JVJtg1jZ8hbAyyE3h
         +o/QtI4Gycrr4pn0Wb6Q9HuBgnVKu37zPHCYNw6PKfpAmVP4trKhCICqVexk61OjymcM
         ajE+rrWyYiEaYRePBmCieqMzw5ekh1Vxny2gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fInY95no8O0JEStBsdbpcymzt287B66Fcqaxhkug+c=;
        b=xzgdLLD/FbkhNr43oC0x7Q9wBlIOSAUsG7wKOYO4VVJQxedOWIPOPHJhEl2gsjro50
         Pupj632PCIeFoKQU4V63h1s1XQ4Q3X47jHEIVi0q3gawBBh8kAsPY5CoxDtO6+fPj6fK
         4qpluGEoDSOwVzNuzFDiHflw4MvtYxfnICB58V7H+juaX7TwH/7IXN7er7INfbIshMyj
         RwMaQmaF3gelWRo+KJIZEd25CUh21gwPb2ZQrxZ7JBIdzX4nR7WA8Rnxb+uWjoUe98Mg
         pjvT128Zb+z7FieetfWPiyaarlztsEsvYGiweTkvlIsFfYdavv312HrQOy9Vw4i7uGBP
         l/ig==
X-Gm-Message-State: AOAM533XLC6j1a404vikCFxZoGK2hI7On+kZOGo0kx99I7jd2gcJMJqW
        PTsR3Mb7s3jGYK/r4snPM1zvJO7ncF0dK3px
X-Google-Smtp-Source: ABdhPJzhdOCeTJScf1uPrtcu+xAp88+ae82nfDTQUhES0EsyxkqtbCnp54aNNZYpGRHc/xzB+aQuQg==
X-Received: by 2002:a2e:8011:: with SMTP id j17mr397854ljg.145.1632841189241;
        Tue, 28 Sep 2021 07:59:49 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id v28sm1945338lfi.22.2021.09.28.07.59.48
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 07:59:48 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id x27so94123383lfu.5
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 07:59:48 -0700 (PDT)
X-Received: by 2002:a2e:3309:: with SMTP id d9mr387530ljc.249.1632841188299;
 Tue, 28 Sep 2021 07:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <YVK0jzJ/lt97xowQ@sol.localdomain>
In-Reply-To: <YVK0jzJ/lt97xowQ@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Sep 2021 07:59:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibMN-Bixbu8zttUoV1ixoVRNk+jyAPEmsVdBe1GFoB5Q@mail.gmail.com>
Message-ID: <CAHk-=wibMN-Bixbu8zttUoV1ixoVRNk+jyAPEmsVdBe1GFoB5Q@mail.gmail.com>
Subject: Re: [GIT PULL] fsverity fix for 5.15-rc4
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Burkov <boris@bur.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 27, 2021 at 11:22 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Fix an integer overflow when computing the Merkle tree layout of
> extremely large files, exposed by btrfs adding support for fs-verity.

I wonder if 'i_size' should be u64. I'm not convinced people think
about 'loff_t' being signed - but while that's required for negative
lseek() offsets, I'm not sure it makes tons of sense for an inode
size.

Same goes for f_pos, for that matter.

But who knows what games people have played with magic numbers (ie
"-1") internally, or where they _want_ signed compares. So it's
certainly not some obvious trivial fix.

Pulled.

            Linus
