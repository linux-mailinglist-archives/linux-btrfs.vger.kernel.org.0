Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC315220E8
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2019 02:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfERAiO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 20:38:14 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:39372 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfERAiO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 20:38:14 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1hRnMW-0004r9-GQ; Sat, 18 May 2019 02:38:08 +0200
Date:   Sat, 18 May 2019 02:38:08 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Diego Calleja <diegocg@gmail.com>, dsterba@suse.cz,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/17] Add support for SHA-256 checksums
Message-ID: <20190518003808.GA17312@angband.pl>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190515172720.GX3138@twin.jikos.cz>
 <2947276.sp5yYTaRCK@archlinux>
 <20190517190703.GA6723@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190517190703.GA6723@x250>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 17, 2019 at 09:07:03PM +0200, Johannes Thumshirn wrote:
> On Fri, May 17, 2019 at 08:36:23PM +0200, Diego Calleja wrote:
> > If btrfs needs an algorithm with good performance/security ratio, I would 
> > suggest considering BLAKE2 [1]. It is based in the BLAKE algorithm that made 
> > to the final round in the SHA3 competition, it is considered pretty secure 
> > (above SHA2 at least), and it was designed to take advantage of modern CPU 
> > features and be as fast as possible - it even beats SHA1 in that regard. It is 
> > not currently in the kernel but Wireguard uses it and will add an 
> > implementation when it's merged (but Wireguard doesn't use the crypto layer 
> > for some reason...)
> 
> SHA3 is on my list of other candidates to look at for a performance
> evaluation. As for BLAKE2 I haven't done too much research on it and I'm not a
> cryptographer so I have to trust FIPS et al.

"Trust FIPS" is the main problem here.  Until recently, FIPS certification
required implementing this nice random generator:
    https://en.wikipedia.org/wiki/Dual_EC_DRBG

Thus, a good part of people are reluctant to use hash functions chosen by
NIST (and published as FIPS).

BLAKE2 is also a good deal faster on most hardware:
    https://bench.cr.yp.to/results-sha3.html
Even with sha_ni, SHA256 wins only on Zen AMDs: sha_ni equipped Intels have
superior SIMD thus BLAKE2 is still faster.  And without sha_ni, the
difference is drastic.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ Latin:   meow 4 characters, 4 columns,  4 bytes
⣾⠁⢠⠒⠀⣿⡁ Greek:   μεου 4 characters, 4 columns,  8 bytes
⢿⡄⠘⠷⠚⠋  Runes:   ᛗᛖᛟᚹ 4 characters, 4 columns, 12 bytes
⠈⠳⣄⠀⠀⠀⠀ Chinese: 喵   1 character,  2 columns,  3 bytes <-- best!
