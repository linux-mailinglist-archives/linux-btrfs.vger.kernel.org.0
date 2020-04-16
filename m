Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157061AC5AF
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 16:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409899AbgDPOYt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 10:24:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:52062 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394232AbgDPOYr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 10:24:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 15680AC37;
        Thu, 16 Apr 2020 14:24:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6AA7FDA727; Thu, 16 Apr 2020 16:24:05 +0200 (CEST)
Date:   Thu, 16 Apr 2020 16:24:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>, jth@kernel.org
Subject: Re: authenticated file systems using HMAC(SHA256)
Message-ID: <20200416142405.GM5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, jth@kernel.org
References: <CAJCQCtSLOgj7MHKNeGOHu1DPa=xC=sR7cZzR88hN1y_mTYRFKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtSLOgj7MHKNeGOHu1DPa=xC=sR7cZzR88hN1y_mTYRFKw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 07, 2020 at 12:02:30PM -0600, Chris Murphy wrote:
> Hi,
> 
> What's the status of this work?
> https://lore.kernel.org/linux-btrfs/20191015121405.19066-1-jthumshirn@suse.de/
> 
> Also I'm curious if it could use blake2b as an option? It's a bit
> faster I guess.

I don't have any objections against the feature but I don't find the
specification complete enough, and there was no response when it was
first sent. The feature itself is not something trivial or small-size so
feedback is always welcome. It's happening now, which is great, and once
we have the missing bits I'll go and merge it.

My checklist so far:

- blake2b needs to be supported as well
- the HMAC must match the kernel implementation
- naming of the new checksums (hmac-sha256 or hmac-blake2 should be ok)
- key specification via mount option
- all progs must work with filesystems with the keyed hash, so how to
  specify the auth key in a consistent way

Usecase questions:

- what to do if the key is not available, allow read-only mount, or
  provide rescue= option to ignore checksum failures?
- support seeding device?

And also document the the expected usecase and guarantees in case we ask
somebody to do the crypto/security audit. As long as we use sandard
primitives or components (eg. keyctl interface) it's the high-level
usage that needs to be checked. The paper
https://github.com/morbidrsa/btrfs-integrity-paper covers that, so that
helps.
