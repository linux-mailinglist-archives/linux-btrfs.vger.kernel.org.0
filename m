Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08DD35189C
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Apr 2021 19:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbhDARqK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 13:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbhDARkd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Apr 2021 13:40:33 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02819C02FE9B
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Apr 2021 09:05:43 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m12so3580261lfq.10
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Apr 2021 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iP5XcIUiB65F0LLqCoqPxiX0Svs4vaWqQzfjqgIZ9Cs=;
        b=FPeG12D75gTLYSxzhBVuCFWZ7afdxQScJL/saT72QoEEkvkmu4OPQw4w4cozkk1n20
         XGxo2yvy2/NQ44qtUM+WNWfgCPAl37mw1L1LrAe/r3PRY8uK8TbAN3gNKWlLrgAsry3t
         3RGscXoiWR2M5XVNZ7QurRIJZkl+KHhoU2ZaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iP5XcIUiB65F0LLqCoqPxiX0Svs4vaWqQzfjqgIZ9Cs=;
        b=pGRpgNaGyNVJf7m8+Ollf2n6gQhwuyfQhzcakES6uZa/H23FQkS9MfKLHD4RjgwpoK
         0g4IjlUhj5OSdC9z6AIBFjbq744oNEVcDEps2TDNIumu5Tt2pjJy2pCbaesfzCuviHxd
         8EiToiOdFJ644vBpcNR5rcoYhN49NjfAzTsb83mgFCqGaFPG4lko2EY40APrEadsxNVt
         lwehuOCrS4JF51fKD/vYCExc7inZW9PMLKUzmeFKdPtKEOCgSsxISG0h1PFTIqxi/JwG
         QCqcTTwhoD8AVsbPqeNzNKc1lH3Zn67c8JsHCi8ES1n3WiE6EZOI4JHZ3RfyQERq0VnX
         GjLw==
X-Gm-Message-State: AOAM530lZDDAq4RaQanmKKxiDPLKhigouhnzZxNbBf/D+tzzL6Fu2K2c
        fyqPq6bNEVoDdPXq6C24EBsI68fZvicY6A==
X-Google-Smtp-Source: ABdhPJwnURi5ghalsFvo0Be8jV6wKwv90h20RQI59vxHxYBlErhsST05N7cXxeKBCnh6rHNFTsYYKg==
X-Received: by 2002:a05:6512:3484:: with SMTP id v4mr5766337lfr.137.1617293141162;
        Thu, 01 Apr 2021 09:05:41 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id h10sm581790lfc.266.2021.04.01.09.05.39
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 09:05:40 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id u20so2779449lja.13
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Apr 2021 09:05:39 -0700 (PDT)
X-Received: by 2002:a05:651c:3c1:: with SMTP id f1mr5836522ljp.507.1617293139746;
 Thu, 01 Apr 2021 09:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617258892.git.osandov@fb.com> <0e7270919b461c4249557b12c7dfce0ad35af300.1617258892.git.osandov@fb.com>
In-Reply-To: <0e7270919b461c4249557b12c7dfce0ad35af300.1617258892.git.osandov@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Apr 2021 09:05:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpn=GYW=2ZNizdVdM0qGGk_iM_Ho=0eawhNaKHifSdpg@mail.gmail.com>
Message-ID: <CAHk-=wgpn=GYW=2ZNizdVdM0qGGk_iM_Ho=0eawhNaKHifSdpg@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] iov_iter: add copy_struct_from_iter()
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 31, 2021 at 11:51 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> + *
> + * The recommended usage is something like the following:
> + *
> + *     if (usize > PAGE_SIZE)
> + *       return -E2BIG;

Maybe this should be more than a recommendation, and just be inside
copy_struct_from_iter(), because otherwise the "check_zeroed_user()"
call might be quite the timesink for somebody who does something
stupid.

But otherwise this new version (still) looks fine to me.

            Linus
