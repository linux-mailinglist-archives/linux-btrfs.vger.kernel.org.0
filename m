Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753A837EE23
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 May 2021 00:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346088AbhELVLC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 17:11:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:54670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383634AbhELTxS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 15:53:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 178B9AC6A;
        Wed, 12 May 2021 19:52:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D4311DA7B0; Wed, 12 May 2021 21:49:35 +0200 (CEST)
Date:   Wed, 12 May 2021 21:49:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nick Terrell <terrelln@fb.com>
Cc:     Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Sterba <dsterba@suse.cz>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Felix Handte <felixh@fb.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        torvalds@linux-foundation.org
Subject: Re: [GIT PULL][PATCH v11 0/4] Update to zstd-1.4.10
Message-ID: <20210512194935.GY7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nick Terrell <terrelln@fb.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "squashfs-devel@lists.sourceforge.net" <squashfs-devel@lists.sourceforge.net>,
        "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Felix Handte <felixh@fb.com>, Eric Biggers <ebiggers@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, torvalds@linux-foundation.org
References: <20210430013157.747152-1-nickrterrell@gmail.com>
 <B093B859-53CC-4818-8CC3-A317F4872AD6@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B093B859-53CC-4818-8CC3-A317F4872AD6@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 11, 2021 at 08:53:41PM +0000, Nick Terrell wrote:
> Pinging this series. Is there anything I should do to help get this
> merged?
> 
> The use of zstd in the kernel is continuously increasing over time,
> both in terms of number of use cases, and number of users that
> actually enable zstd compression in production. E.g. Fedora is
> making btrfs with zstd compression enabled the default.
> 
> I would love to see the zstd code updated to the latest upstream
> and be kept up to date. The latest upstream brings bug fixes, and
> significant performance improvements. Additionally, the latest
> upstream code is continuously fuzzed.

The btrfs community and I in particular have interest to get zstd
updated but also there's the patch 3 that goes against what kernel
requires regarding patch size and logical split of changes.

That the update is so large shouldn't have happened, it covers 3 years
of development, the syncs should have happened more often, but here we
are.

Other points that have been raised in the past:

* new wrappers - there are new wrappers changing users of the API, the
  new names are more conforming, eg ZSTD_decompressDCtx -> zstd_decompress_dctx,
  sounds like an improvement to me

* high stack usage - mentioned in patch 3, slight increase but bounded
  and upstream now monitors that so it does not increase

Other points that are worth mentioning:

* bisectability - the version switch happens in one patch, so the
  effects before/after the patch are only runtime as there's no change
  in format etc, so ok

* will be maintained - no such huge update should happen again

So I suggest to merge in current form. I'm not sure what was the
original plan if it was supposed to go via Herbert's crypto tree, but
that was before Nick added himself as maintainer.

I think that Nick can send the pull request to Linus, perhaps with acks
to all changes that are in the non-zstd code (patch 1).

Cover letter v11: https://lore.kernel.org/linux-btrfs/20210430013157.747152-1-nickrterrell@gmail.com/
