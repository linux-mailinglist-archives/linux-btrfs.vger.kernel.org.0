Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3A436CE7A
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 00:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbhD0WMV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 18:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbhD0WMU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 18:12:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B63C061574;
        Tue, 27 Apr 2021 15:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=8S51hkxlGcSMjLm7YwZm1jMdNJla3qEcWOkEj52n5Mg=; b=TJ3lx1bhRLgSaWyeCUnhNQzcHi
        trKFahM2pKL7Twf30KHwsodJCQDar8WQxdynQbhOUI/zcj26Muje6vDEMC45KyxDkXHb4v9Oj7S3x
        /YNuiThGs0H8I5dcCEFLjD8SLCLh7+2dBbxEuGg7yqRdU3DwYVZ7EnqJ/E7MO5dMW0X+GoivUK1HV
        bF70x1WWyQDkLSOib+IbR+KCXi+I5gtqIyfAsn4pTgpKCEiwZNtLyExaQIs8PipmE85oG7Rafgt2g
        8hDWfAjT9W0z00dUDJQ0ne+g1yYp8AjDK39UZl2KiHMDxJd8Rh6Md7RgKkoA4MKJ8W6jRhFFGAov3
        H/fAyK3w==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lbVuA-007Tyw-P8; Tue, 27 Apr 2021 22:10:13 +0000
Subject: Re: [GIT PULL][PATCH v10 0/4] Update to zstd-1.4.10
To:     Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Sterba <dsterba@suse.cz>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Felix Handte <felixh@fb.com>,
        Eric Biggers <ebiggers@kernel.org>
References: <20210426234621.870684-1-nickrterrell@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <10397ef2-119d-b065-2e82-cac1d800dfd0@infradead.org>
Date:   Tue, 27 Apr 2021 15:09:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210426234621.870684-1-nickrterrell@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/26/21 4:46 PM, Nick Terrell wrote:
> From: Nick Terrell <terrelln@fb.com>
> 
> Please pull from
> 
>   git@github.com:terrelln/linux.git tags/v10-zstd-1.4.10
> 
> to get these changes. Alternatively the patchset is included.
> 
> This patchset lists me as the maintainer for zstd and upgrades the zstd library
> to the latest upstream release. The current zstd version in the kernel is a
> modified version of upstream zstd-1.3.1. At the time it was integrated, zstd
> wasn't ready to be used in the kernel as-is. But, it is now possible to use
> upstream zstd directly in the kernel.

Hi Nick,

Several of the source (.c, .h) files use comments blocks that
begin with "/**", which means "this is the beginning of a kernel-doc
comment" when in the kernel source tree. However, they are not in
kernel-doc format.

During the automatic generation from upstream zstd, please find a way
to change /** to /*.

This does need to slow down the acceptance of this patch series IMO.


thanks.
-- 
~Randy

