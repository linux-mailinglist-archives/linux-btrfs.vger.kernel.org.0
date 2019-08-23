Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4B189B52C
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2019 19:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732817AbfHWRJU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Aug 2019 13:09:20 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:52454 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732783AbfHWRIy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Aug 2019 13:08:54 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1i1D3N-0005nZ-SX; Fri, 23 Aug 2019 19:08:45 +0200
Date:   Fri, 23 Aug 2019 19:08:45 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Paul Jones <paul@pauljones.id.au>
Cc:     Peter Becker <floyd.net@gmail.com>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Support xxhash64 checksums
Message-ID: <20190823170845.GD17075@angband.pl>
References: <20190822114029.11225-1-jthumshirn@suse.de>
 <ed9e2eaa-7637-9752-94bb-fd415ab2b798@applied-asynchrony.com>
 <CAEtw4r01JMFqszs0bBeeU3OXLqbT5+cU+4ZP282J3cvYzALgZg@mail.gmail.com>
 <SYCPR01MB5086F030FA4FD295783638B99EA40@SYCPR01MB5086.ausprd01.prod.outlook.com>
 <SYCPR01MB5086BAB60D850EBC8FE046E49EA40@SYCPR01MB5086.ausprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SYCPR01MB5086BAB60D850EBC8FE046E49EA40@SYCPR01MB5086.ausprd01.prod.outlook.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 23, 2019 at 09:43:22AM +0000, Paul Jones wrote:
> > > Am Do., 22. Aug. 2019 um 16:41 Uhr schrieb Holger Hoffstätte
> > > <holger@applied-asynchrony.com>:
> > > > but how does btrfs benefit from this compared to using crc32-intel?
> > >
> > > As i know, crc32c  is as far as ~3x faster than xxhash. But xxHash was
> > > created with a differend design goal.
> > > If you using a cpu without hardware crc32 support, xxHash provides you
> > > a maximum portability and speed. Look at arm, mips, power, etc. or old
> > > intel cpus like Core 2 Duo.
> > 
> > I've got a modified version of smhasher
> > (https://github.com/PeeJay/smhasher) that tests speed and cryptographics
> > of various hashing functions.
> 
> I forgot to add xxhash32
>  
> Crc32 Software -  379.91 MiB/sec
> Crc32 Hardware - 7338.60 MiB/sec
> XXhash64 Software - 12094.40 MiB/sec
> XXhash32 Software - 6060.11 MiB/sec
> 
> Testing done on a 1st Gen Ryzen. Impressive numbers from XXhash64.

Newest biggest Threadripper (2990WX, no 3* version released yet):
crc32      -   492.75 MiB/sec
crc32hw    -  9447.37 MiB/sec
crc64      -  1959.51 MiB/sec
xxhash32   -  7479.29 MiB/sec
xxhash64   - 14911.58 MiB/sec

An old Skylake (i7-6700):
crc32      -   359.32 MiB/sec
crc32hw    - 21119.68 MiB/sec
crc64      -  1656.34 MiB/sec
xxhash32   -  5989.87 MiB/sec
xxhash64   - 11949.41 MiB/sec

Cascade Lake (0000%@):
crc32hw 1.92× as fast as xxhash64.

So you want crc32hw on Intel, xxhash64 on AMD.

crc32 also allows going back to old kernels; the improved collision
resistance of xxhash64 is not a reason as if you intend to dedupe you want
a crypto hash so you don't need to verify.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁
⢿⡄⠘⠷⠚⠋  The root of a real enemy is an imaginary friend.
⠈⠳⣄⠀⠀⠀⠀
