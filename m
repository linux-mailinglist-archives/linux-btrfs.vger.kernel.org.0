Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627432DB80C
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 01:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgLPA7S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Dec 2020 19:59:18 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:52834 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgLPA7S (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Dec 2020 19:59:18 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kpL8p-00049r-2J; Wed, 16 Dec 2020 11:58:08 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 16 Dec 2020 11:58:07 +1100
Date:   Wed, 16 Dec 2020 11:58:07 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nick Terrell <terrelln@fb.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Nick Terrell <nickrterrell@gmail.com>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        Christoph Hellwig <hch@infradead.org>,
        Yann Collet <cyan@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Petr Malat <oss@malat.biz>, Chris Mason <clm@fb.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Niket Agarwal <niketa@fb.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Johannes Weiner <jweiner@fb.com>
Subject: Re: [f2fs-dev] [PATCH v7 0/3] Update to zstd-1.4.6
Message-ID: <20201216005806.GA26841@gondor.apana.org.au>
References: <20201203205114.1395668-1-nickrterrell@gmail.com>
 <DF6B2E26-2D6E-44FF-89DB-93A37E2EA268@fb.com>
 <X9lOHkAE67EP/sXo@sol.localdomain>
 <B3F00261-E977-4B85-84CD-66B07DA79D9D@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B3F00261-E977-4B85-84CD-66B07DA79D9D@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 16, 2020 at 12:48:51AM +0000, Nick Terrell wrote:
>
> Thanks for the advice! The first zstd patches went through Herbert’s tree, which is
> why I’ve sent them this way.

Sorry, but I'm not touch these patches as Christoph's objections
don't seem to have been addressed.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
