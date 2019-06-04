Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35F303408C
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2019 09:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfFDHlh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jun 2019 03:41:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:56146 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726637AbfFDHlh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Jun 2019 03:41:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 74A4BADD5;
        Tue,  4 Jun 2019 07:41:36 +0000 (UTC)
Date:   Tue, 4 Jun 2019 09:41:36 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     waxhead <waxhead@dirtcellar.net>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v4 00/13] Add support for other checksums
Message-ID: <20190604074136.GB4225@x250>
References: <20190603145859.7176-1-jthumshirn@suse.de>
 <78fb639b-3f2d-7cb5-77b7-fee7339a0449@dirtcellar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78fb639b-3f2d-7cb5-77b7-fee7339a0449@dirtcellar.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 03, 2019 at 09:56:06PM +0200, waxhead wrote:
> 
> 
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
> Howdy , being just a regular user I am in fact a bit concerned about what
> happens to my delicious (it's butter after all) filesystems if I happen to
> move disks between servers. Let's say server A has a filesystem that support
> checksum type_1 and type_2 while server B only supports type_1.
> 
> If the filesystem only has checksum of type_2 stored I would assume that
> server B won't be able to read the data.
> 
> Ignoring checksums will kind of make BTRFS pointless, but I think this is a
> good reason to consider adding a 'ignore-checksum' mount option - at least
> it could make the data readable (RO) in a pinch.
> 
> ....actually since you could always fall back to the original crc32c then
> perhaps RO might not even be needed at all ?!
> 
> I openly admit to NOT having read the patchset, so feel free to ignore my
> comment if this has already been discussed...

If you create the filesystem on host A with Algorithm X and try to mount it on
host B which only supports Algorithm Y this indeed won't work yet.

Thanks for pointing this out.

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
