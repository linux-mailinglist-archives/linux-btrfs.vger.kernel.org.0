Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA3F222D5C
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 09:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbfETHrv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 03:47:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:46610 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728551AbfETHrv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 03:47:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82D7DAF31;
        Mon, 20 May 2019 07:47:50 +0000 (UTC)
Date:   Mon, 20 May 2019 09:47:50 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Diego Calleja <diegocg@gmail.com>, dsterba@suse.cz,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/17] Add support for SHA-256 checksums
Message-ID: <20190520074750.GC4985@x250>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190515172720.GX3138@twin.jikos.cz>
 <2947276.sp5yYTaRCK@archlinux>
 <20190517190703.GA6723@x250>
 <20190518003808.GA17312@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190518003808.GA17312@angband.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 18, 2019 at 02:38:08AM +0200, Adam Borowski wrote:
> On Fri, May 17, 2019 at 09:07:03PM +0200, Johannes Thumshirn wrote:
> > On Fri, May 17, 2019 at 08:36:23PM +0200, Diego Calleja wrote:
> > > If btrfs needs an algorithm with good performance/security ratio, I would 
> > > suggest considering BLAKE2 [1]. It is based in the BLAKE algorithm that made 
> > > to the final round in the SHA3 competition, it is considered pretty secure 
> > > (above SHA2 at least), and it was designed to take advantage of modern CPU 
> > > features and be as fast as possible - it even beats SHA1 in that regard. It is 
> > > not currently in the kernel but Wireguard uses it and will add an 
> > > implementation when it's merged (but Wireguard doesn't use the crypto layer 
> > > for some reason...)
> > 
> > SHA3 is on my list of other candidates to look at for a performance
> > evaluation. As for BLAKE2 I haven't done too much research on it and I'm not a
> > cryptographer so I have to trust FIPS et al.
> 
> "Trust FIPS" is the main problem here.  Until recently, FIPS certification
> required implementing this nice random generator:
>     https://en.wikipedia.org/wiki/Dual_EC_DRBG
> 
> Thus, a good part of people are reluctant to use hash functions chosen by
> NIST (and published as FIPS).

I know, but please also understand that there are applications which do
require FIPS certified algorithms.

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
