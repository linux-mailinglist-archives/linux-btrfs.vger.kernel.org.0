Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2079944B
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 14:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388164AbfHVMyU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 08:54:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:45410 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbfHVMyU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 08:54:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2B0B9AC8B;
        Thu, 22 Aug 2019 12:54:19 +0000 (UTC)
Date:   Thu, 22 Aug 2019 14:54:18 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Support xxhash64 checksums
Message-ID: <20190822125418.GF4052@x250>
References: <20190822114029.11225-1-jthumshirn@suse.de>
 <ed9e2eaa-7637-9752-94bb-fd415ab2b798@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed9e2eaa-7637-9752-94bb-fd415ab2b798@applied-asynchrony.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 22, 2019 at 02:28:53PM +0200, Holger Hoffstätte wrote:
> On 8/22/19 1:40 PM, Johannes Thumshirn wrote:
> > Now that Nikolay's XXHASH64 support for the Crypto API has landed and BTRFS is
> > prepared for an easy addition of new checksums, this patchset implements
> > XXHASH64 as a second, fast but not cryptographically secure checksum hash.
> 
> Question from the cheap seats.. :)
> 
> I know that crc32c-intel uses native SSE 4.2 instructions, but so far I have
> been unable to find benchmarks or explanations why adding xxhash64 benefits
> btrfs. All benchmarks seem to be against crc32c in *software*, not the
> SSE4.2-enabled version (or I can't read). I mean, it's great that xxhash64 is
> really fast for a software implementation, but how does btrfs benefit from this
> compared to using crc32-intel?
> 
> Verifying that plugging in other hash impls works (e.g. as preparation for
> stronger impls) has value, but it's probably not something most
> users care about.
> 
> Maybe there are obscure downsides to crc32c-intel like instruction latency
> (def. a problem for AVX512), cache pollution..?
> 
> Just curious.

It's not so much about the performance aspect of xxhash64 vs crc32c. xxhash64
has a lower collission proability compared to crc32c, which for instance makes
it a good candidate to use for de-duplication.

HTH,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
