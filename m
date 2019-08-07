Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59C8F84E4F
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 16:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388067AbfHGOKH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 10:10:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:53470 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387998AbfHGOKH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 7 Aug 2019 10:10:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 06257B022
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Aug 2019 14:10:06 +0000 (UTC)
Date:   Wed, 7 Aug 2019 16:10:05 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC PATCH 4/4] btrfs: sysfs: export supported checksums
Message-ID: <20190807141005.GB28023@x250.microfocus.com>
References: <cover.1564046812.git.jthumshirn@suse.de>
 <e377ded65e4f2799776596ead308658710e4c8c1.1564046812.git.jthumshirn@suse.de>
 <20190730171904.GE28208@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190730171904.GE28208@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 30, 2019 at 07:19:04PM +0200, David Sterba wrote:
> On Thu, Jul 25, 2019 at 11:33:51AM +0200, Johannes Thumshirn wrote:
> > From: David Sterba <dsterba@suse.com>
> > 
> > Export supported checksum algorithms via sysfs.
> 
> I wonder if we should also export the implementation that would be used.
> This could be crross referenced with /proc/crypto, but having it in one
> place would be IMHO convenient.  Also for the case when the kernel
> module is missing.
> 
> Currently the hash names are printed as comma separated values so we'd
> need bit something structured:
> 
> crc32c: crc32c-intel
> xxhash64: xxhash-generic

I thought a bit more about it and it's not quite that easy as I would need to
have access to the respective "struct crypto_shash". For the currently used
checksum this isn't much of a problem, as I get it via "struct btrfs_fs_info".

But this sysfs attribute lists all the checksumming algorithms the current
btrfs version is able to use irrespectively of the currently mounted
file-systems.

So yes I can do it but I think this is for another sysfs attribute which shows
the used checksumming algorithm for this FS, not the supported checksumming
algorithms.

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
