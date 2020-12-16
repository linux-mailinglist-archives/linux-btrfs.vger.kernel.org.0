Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7E22DB7AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 01:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgLPAGG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Dec 2020 19:06:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbgLPABM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Dec 2020 19:01:12 -0500
Date:   Tue, 15 Dec 2020 16:00:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608076832;
        bh=SMdx46Co4JVowwroGILEbnCiRoajuP8+Xelb/U43yRM=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nby56K462/a5pb6JiyVx6iGyF5q9dI9fujCkY3Zfc0Dn0DsHQFYlDHxMzFcjr7005
         FHzppVUvkQaZO5lLwYvgPibaok/OmBhJjKDmDQm4TRRk0wIUWizhq5aFfwqqBJlYzq
         jDYVqjAIfrC4qhBrFGB/2vV0qxGhmRYiwBTIL5qzm5TrvZ+sdd1H2l2VLEoZ5UZ8/P
         60ZVcBiqgwYdHT8Z9rp7AM8pWcpKXaHvQFPPoic9oeUoKZD3/242x+P2EqNtue+NJO
         G5MgakcIi8KVeI7S0gS5Z3y6EVRbeJQJQke+st3fukl0XIZiAPzX+4wuYZinlU36JV
         XZp4H3Ej/6bqA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Nick Terrell <terrelln@fb.com>
Cc:     Nick Terrell <nickrterrell@gmail.com>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
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
Message-ID: <X9lOHkAE67EP/sXo@sol.localdomain>
References: <20201203205114.1395668-1-nickrterrell@gmail.com>
 <DF6B2E26-2D6E-44FF-89DB-93A37E2EA268@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DF6B2E26-2D6E-44FF-89DB-93A37E2EA268@fb.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 15, 2020 at 08:58:52PM +0000, Nick Terrell via Linux-f2fs-devel wrote:
> 
> 
> > On Dec 3, 2020, at 12:51 PM, Nick Terrell <nickrterrell@gmail.com> wrote:
> > 
> > From: Nick Terrell <terrelln@fb.com>
> > 
> > Please pull from
> > 
> >  git@github.com:terrelln/linux.git tags/v7-zstd-1.4.6
> > 
> > to get these changes. Alternatively the patchset is included.
> 
> Is it possible to get this patchset merged in the 5.11 merge window? It applies
> cleanly to the latest master. Please let me know if there is anything that I can do
> to drive this patchset towards merge.
> 
> Thanks,
> Nick

Well, it's too late for 5.11 for patches that weren't already in linux-next, so
you'll have to aim for 5.12.

It looks like you're asking Herbert to pull this into the crypto tree?  If he's
interested in doing that, that could work.  However lib/zstd/ isn't that
strongly "crypto-related", and it doesn't actually have a maintainer listed in
MAINTAINERS.  Perhaps another path forwards is for you to volunteer to maintain
lib/zstd/ and send pull requests for it directly to Linus?

- Eric
