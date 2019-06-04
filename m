Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1E103432D
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2019 11:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfFDJaI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jun 2019 05:30:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:35638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726877AbfFDJaH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Jun 2019 05:30:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8C3EAE1B;
        Tue,  4 Jun 2019 09:30:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BC34DDA85E; Tue,  4 Jun 2019 11:30:58 +0200 (CEST)
Date:   Tue, 4 Jun 2019 11:30:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     waxhead <waxhead@dirtcellar.net>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v4 00/13] Add support for other checksums
Message-ID: <20190604093058.GW15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, waxhead <waxhead@dirtcellar.net>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
References: <20190603145859.7176-1-jthumshirn@suse.de>
 <78fb639b-3f2d-7cb5-77b7-fee7339a0449@dirtcellar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78fb639b-3f2d-7cb5-77b7-fee7339a0449@dirtcellar.net>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 03, 2019 at 09:56:06PM +0200, waxhead wrote:
> Johannes Thumshirn wrote:
> > This patchset add support for adding new checksum types in BTRFS.
> > 
> > Currently BTRFS only supports CRC32C as data and metadata checksum, which is
> > good if you only want to detect errors due to data corruption in hardware.
> > 
> > But CRC32C isn't able cover other use-cases like de-duplication or
> > cryptographically save data integrity guarantees.
> > 
> > The following properties made SHA-256 interesting for these use-cases:
> > - Still considered cryptographically sound
> > - Reasonably well understood by the security industry
> > - Result fits into the 32Byte/256Bit we have for the checksum in the on-disk
> >    format
> > - Small enough collision space to make it feasible for data de-duplication
> > - Fast enough to calculate and offloadable to crypto hardware via the kernel's
> >    crypto_shash framework.
> > 
> > The patchset also provides mechanisms for plumbing in different hash
> > algorithms relatively easy.
> > 
> 
> Howdy , being just a regular user I am in fact a bit concerned about 
> what happens to my delicious (it's butter after all) filesystems if I 
> happen to move disks between servers. Let's say server A has a 
> filesystem that support checksum type_1 and type_2 while server B only 
> supports type_1.
> 
> If the filesystem only has checksum of type_2 stored I would assume that 
> server B won't be able to read the data.
> 
> Ignoring checksums will kind of make BTRFS pointless, but I think this 
> is a good reason to consider adding a 'ignore-checksum' mount option - 
> at least it could make the data readable (RO) in a pinch.

That's a good idea. The availability of checksum modules is
unpredictable so we should provide some way to access the filesystem.

> ....actually since you could always fall back to the original crc32c 
> then perhaps RO might not even be needed at all ?!

The checksum type is per-filesystem, so write support cannot be enabled.
Theoretically, switching checksum should be possible with scrub that
will switch that on-the fly, but this needs to be tought out due the
intermediate state.
