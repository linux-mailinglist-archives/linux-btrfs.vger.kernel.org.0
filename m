Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1E735FB4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Apr 2021 21:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhDNTFF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Apr 2021 15:05:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232347AbhDNTFD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Apr 2021 15:05:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2758F61042;
        Wed, 14 Apr 2021 19:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618427080;
        bh=gwzQcRwbOgaN2/pzYunq2zGc557r7YyWb4fDr1lKMWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e6qnGByFvXV9VYanDYyrfo3Op2Qw3WPOuIw6m4nBoRdH78TMm5J07FTuZb7xBN/F3
         +gmhwMhJW+bcamgtEbdcaQxHpg9EYvFJLvASLGuQXlzvqbswKpjQbTaDyeG3gVlUvo
         fsBoVvMtenSLfi306gn5/M2KhyjleNqmFqYxXTUpZjbJ4/cEGUhR0SqX54cegyrBPD
         QKooXGHCiNK4hWwFqLEQ0J0QAtNfNa+BDh4D28Bgw6qymymoHSh2yPGTOJbo/xz81b
         IomMV3BQNBcHs6FDUTvcyVs5B8ImydLV3N3qNEloL3KnBJOFSt98cjV6VSIpNvE3ab
         SZMgGVoShVL5w==
Date:   Wed, 14 Apr 2021 12:04:38 -0700
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
Message-ID: <YHc8xtmzKaazC6kP@gmail.com>
References: <20210330225112.496213-1-nickrterrell@gmail.com>
 <CANr2DbfL2B5Tx+k1AwVh-5dQZ+fNpucJKu9QVQat7QVvK-5AbQ@mail.gmail.com>
 <CANr2DbfZ+fV+GN7CfDi1AFmfsdnX+kGnTA6kayEchtGwfoAE-A@mail.gmail.com>
 <YHc16rz4Y/PkzNH1@gmail.com>
 <CANr2Dbc+2rS7seuXGtU6Y+x0Qv+hrtwz71r+akKeQUXECZaJZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANr2Dbc+2rS7seuXGtU6Y+x0Qv+hrtwz71r+akKeQUXECZaJZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 14, 2021 at 11:53:51AM -0700, Nick Terrell wrote:
> On Wed, Apr 14, 2021 at 11:35 AM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Wed, Apr 14, 2021 at 11:01:29AM -0700, Nick Terrell wrote:
> > > Hi all,
> > >
> > > I would really like to make some progress on this and get it merged.
> > > This patchset offsers:
> > > * 15-30% better decompression speed
> > > * 3 years of zstd bug fixes and code improvements
> > > * Allows us to import zstd directly from upstream so we don't fall 3
> > > years out of date again
> > >
> > > Thanks,
> > > Nick
> > >
> >
> > I think it would help get it merged if someone actually volunteered to maintain
> > it.  As-is there is no entry in MAINTAINERS for this code.
> 
> I was discussing with Chris Mason about volunteering to maintain the
> code myself.
> We wanted to wait until this series got merged before going that
> route, because there
> was already a lot of comments about it, and I didn't want to appear to
> be trying to bypass
> any review or criticisms. But, please let me know what you think.
> 

I expect that most people would like to see a commitment to maintain this code
before merging.  The usual way to do that is to add a MAINTAINERS entry.

Otherwise it is 27000 lines of code dumped on other people to maintain.

- Eric
