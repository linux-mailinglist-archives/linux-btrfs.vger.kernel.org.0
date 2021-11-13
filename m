Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00F444F193
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Nov 2021 06:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhKMFpF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Nov 2021 00:45:05 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:56684 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhKMFpE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Nov 2021 00:45:04 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mllna-0008U5-Tf; Sat, 13 Nov 2021 13:41:58 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mllnI-0005S4-Mh; Sat, 13 Nov 2021 13:41:40 +0800
Date:   Sat, 13 Nov 2021 13:41:40 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nick Terrell <terrelln@fb.com>
Cc:     nickrterrell@gmail.com, torvalds@linux-foundation.org,
        sfr@canb.auug.org.au, linux-crypto@vger.kernel.org,
        linux-btrfs@vger.kernel.org, squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel-team@fb.com, clm@fb.com,
        oss@malat.biz, cyan@fb.com, hch@infradead.org,
        mirq-linux@rere.qmqm.pl, dsterba@suse.cz, oleksandr@natalenko.name,
        felixh@fb.com, ebiggers@kernel.org, rdunlap@infradead.org,
        paul@pauljones.id.au, tseewald@gmail.com, sedat.dilek@gmail.com,
        jd.girard@sysnux.pf
Subject: Re: [GIT PULL] zstd changes for v5.16
Message-ID: <20211113054140.GA20916@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7A1FF8B7-CB5B-415A-9203-1A0DAA1FDD9B@fb.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
Organization: Core
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Nick Terrell <terrelln@fb.com> wrote:
>
> 2. Reaching out to Herbert Xu—because the first zstd version went through the
>    crypto tree—and other relevant maintainers who have been
>    involved, and trying to get a word of support for adding me as the maintainer
>    of lib/zstd in this thread.

Actually I don't think I ever merged lib/zstd.  I did take
crypto/zstd though which is the Crypto API wrapper around the
lib/zstd code.

Since the current contention is with lib/zstd I think it probably
makes sense for Linus to take it directly.

I think you should certainly be the maintainer of lib/zstd since
it was added by you and mostly used by you too :)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
