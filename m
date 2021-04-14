Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D4235FADC
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Apr 2021 20:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352913AbhDNSfq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Apr 2021 14:35:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352552AbhDNSfp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Apr 2021 14:35:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74AAE61131;
        Wed, 14 Apr 2021 18:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618425323;
        bh=lzR8WlTx9NeavpRLEGESjSFqtohhbfUn3GpyluskFDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ULSIl11+GjxuP+oKZFolsYNThiCyEGN64HnLfll6nqCuLk2ssqR1aZ+4/YEr6NBwb
         nAC4+rdEyw7sv6/SrtDr+zvtiviyB2PFgmmOXR/fvEOyg994MPKVd3NM+MUi4IZKA+
         rHoNgGS9ldz1Y+9Vp/OpHGDmh9Mx2IY9wRgGnFQoqBYYEJ+axduqsMszyrCg4Z3gF3
         0ovICWzsNaQjLNLBDgZeJga7eTNT3XhhjjsGhxi/RfGZDKiGI3Wbl5vyptKqRpuZRK
         NH86GSrDDV8UPGcLpOHWDtFhBxQHHHh9d7REx8wHN7rC01XVGW8wZYAQZeyxAipv0E
         eniq23B+fe37A==
Date:   Wed, 14 Apr 2021 11:35:22 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Nick Terrell <nickrterrell@gmail.com>
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
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Niket Agarwal <niketa@fb.com>, linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL][PATCH v9 0/3] Update to zstd-1.4.10
Message-ID: <YHc16rz4Y/PkzNH1@gmail.com>
References: <20210330225112.496213-1-nickrterrell@gmail.com>
 <CANr2DbfL2B5Tx+k1AwVh-5dQZ+fNpucJKu9QVQat7QVvK-5AbQ@mail.gmail.com>
 <CANr2DbfZ+fV+GN7CfDi1AFmfsdnX+kGnTA6kayEchtGwfoAE-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANr2DbfZ+fV+GN7CfDi1AFmfsdnX+kGnTA6kayEchtGwfoAE-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 14, 2021 at 11:01:29AM -0700, Nick Terrell wrote:
> Hi all,
> 
> I would really like to make some progress on this and get it merged.
> This patchset offsers:
> * 15-30% better decompression speed
> * 3 years of zstd bug fixes and code improvements
> * Allows us to import zstd directly from upstream so we don't fall 3
> years out of date again
> 
> Thanks,
> Nick
> 

I think it would help get it merged if someone actually volunteered to maintain
it.  As-is there is no entry in MAINTAINERS for this code.

- Eric
