Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1A19DAAE
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 02:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfH0Ad1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 20:33:27 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:49522 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfH0Ad1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 20:33:27 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1i2PQE-0007Ah-4Z; Tue, 27 Aug 2019 02:33:18 +0200
Date:   Tue, 27 Aug 2019 02:33:18 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     Paul Jones <paul@pauljones.id.au>,
        Peter Becker <floyd.net@gmail.com>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Support xxhash64 checksums
Message-ID: <20190827003318.GA25412@angband.pl>
References: <20190822114029.11225-1-jthumshirn@suse.de>
 <ed9e2eaa-7637-9752-94bb-fd415ab2b798@applied-asynchrony.com>
 <CAEtw4r01JMFqszs0bBeeU3OXLqbT5+cU+4ZP282J3cvYzALgZg@mail.gmail.com>
 <SYCPR01MB5086F030FA4FD295783638B99EA40@SYCPR01MB5086.ausprd01.prod.outlook.com>
 <SYCPR01MB5086BAB60D850EBC8FE046E49EA40@SYCPR01MB5086.ausprd01.prod.outlook.com>
 <20190823170845.GD17075@angband.pl>
 <69ac4340-c782-aa92-246c-3106b1611eea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69ac4340-c782-aa92-246c-3106b1611eea@gmail.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 26, 2019 at 08:27:15AM -0400, Austin S. Hemmelgarn wrote:
> On 2019-08-23 13:08, Adam Borowski wrote:
> > the improved collision
> > resistance of xxhash64 is not a reason as if you intend to dedupe you want
> > a crypto hash so you don't need to verify.
> 
> The improved collision resistance is a roughly 10 orders of magnitude
> reduction in the chance of a collision.  That may not matter for most, but
> it's a significant improvement for anybody operating at large enough scale
> that media errors are commonplace.

Hash size doesn't matter vs media errors.  You don't have billions of
mismatches: the first one is a cause of alarm, so 1-in-4294967296 chance of
failing to notice it hardly ever matters (even though it _can_ happen in
real life as opposed to collisions below).

I can think of a bigger hash useful in three cases:
* recovering from a split-brain RAID
* recovering from one disk of a RAID having had a large piece scribbled upon
* finding candidates for deduplication (but see below why not 64-bit)

> Also, you would still need to verify even if you're using whatever the
> fanciest new collision resistant cryptographic hash is, because the number
> of possible input values is still more than _nine thousand_ orders of
> magnitude larger than the total number of output values even if we use a
> 512-bit cryptographic hash.

You're underestimating how rare crypto-strength hash collisions are.

There are two scenarios: unintentional, and malicious.

Let's go with unintentional first: the age of the Universe is 2^58.5
seconds.  The fastest disk (non-pmem) is NVMe-connected Optane, at 240000
IOPS.  That's 2^17.8.  With a 256-bit hash, the mass of machines needed for
a single expected collision within the age of Universe exceeds the mass of
observable Universe itself.

So, malicious.  We demand a non-broken hash, which in crypto speak means
there's no known attack better than brute force.  An iterative approach is
right out; the best space-time tradeoff is birthday attack, which requires
storage size akin to the root of # of combinations (ie, half the hash
length).  It's drastically better: at current best storage densities, you'd
need only the mass of the Earth.

Please let me know when you'll build that Earth-sized computer, so I can
migrate from weak SHA256 to eg. BLAKE2b.

On the other hand, computers and memories get hit by cosmic rays, thermal
noise, and so on at a non-negligible rate.  Any theoretical chance of a hash
collision is dwarfed by flaws of technology we have.  Or, eg, by the chance
that you'll get hit by multiple lightings the next time you leave your
house.

Thus: no, you don't need to recheck after SHA256.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁
⢿⡄⠘⠷⠚⠋  The root of a real enemy is an imaginary friend.
⠈⠳⣄⠀⠀⠀⠀
