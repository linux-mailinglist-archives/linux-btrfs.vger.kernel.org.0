Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530582DC6C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 19:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732364AbgLPSxO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 13:53:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:45844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732361AbgLPSxO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 13:53:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C406AAF0B;
        Wed, 16 Dec 2020 18:52:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CB5A8DA7B4; Wed, 16 Dec 2020 19:50:52 +0100 (CET)
Date:   Wed, 16 Dec 2020 19:50:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Nick Terrell <terrelln@fb.com>, Eric Biggers <ebiggers@kernel.org>,
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
Message-ID: <20201216185052.GL6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Herbert Xu <herbert@gondor.apana.org.au>,
        Nick Terrell <terrelln@fb.com>, Eric Biggers <ebiggers@kernel.org>,
        Nick Terrell <nickrterrell@gmail.com>,
        "squashfs-devel@lists.sourceforge.net" <squashfs-devel@lists.sourceforge.net>,
        Christoph Hellwig <hch@infradead.org>, Yann Collet <cyan@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>,
        Petr Malat <oss@malat.biz>, Chris Mason <clm@fb.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Niket Agarwal <niketa@fb.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Johannes Weiner <jweiner@fb.com>
References: <20201203205114.1395668-1-nickrterrell@gmail.com>
 <DF6B2E26-2D6E-44FF-89DB-93A37E2EA268@fb.com>
 <X9lOHkAE67EP/sXo@sol.localdomain>
 <B3F00261-E977-4B85-84CD-66B07DA79D9D@fb.com>
 <20201216005806.GA26841@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201216005806.GA26841@gondor.apana.org.au>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 16, 2020 at 11:58:07AM +1100, Herbert Xu wrote:
> On Wed, Dec 16, 2020 at 12:48:51AM +0000, Nick Terrell wrote:
> >
> > Thanks for the advice! The first zstd patches went through Herbert’s tree, which is
> > why I’ve sent them this way.
> 
> Sorry, but I'm not touch these patches as Christoph's objections
> don't seem to have been addressed.

I have objections to the current patchset as well, the build bot has
found that some of the function frames are overly large (up to 3800
bytes) [1], besides the original complaint that the patch 3/3 is 1.5MiB.

[1] https://lore.kernel.org/lkml/20201204140314.GS6430@twin.jikos.cz/
