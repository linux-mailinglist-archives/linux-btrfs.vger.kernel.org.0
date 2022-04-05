Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9824F21C1
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Apr 2022 06:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiDECkw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Apr 2022 22:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiDECka (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Apr 2022 22:40:30 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833DA558E
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Apr 2022 18:43:27 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nbXnc-0001AP-1i by authid <merlin>; Mon, 04 Apr 2022 18:16:00 -0700
Date:   Mon, 4 Apr 2022 18:16:00 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220405011559.GF5566@merlins.org>
References: <20220404234213.GA5566@merlins.org>
 <CAEzrpqft7WzRB+6+=_tTXYU4geBB_38navF1opr6cd9PXiWUGg@mail.gmail.com>
 <20220405001325.GB5566@merlins.org>
 <CAEzrpqcb2jHehpnrjxtNJ4KWW3M5pvJThUNGFZw78=MBNdTG5g@mail.gmail.com>
 <20220405001808.GC5566@merlins.org>
 <CAEzrpqfKaXjk7J_oAY0pSL4YPy_vw5Z0tKmjMPQgQSd_OhYwXA@mail.gmail.com>
 <20220405002826.GD5566@merlins.org>
 <CAEzrpqeHa7tG+S_9Owu5XYa0hwBKJPVN2ttr_E_1Q4UV8u0Nmg@mail.gmail.com>
 <20220405005809.GE5566@merlins.org>
 <CAEzrpqfjTUoK9fi43tLZaJ9mkBewAqcUH77di7QipH9Vj6AB0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqfjTUoK9fi43tLZaJ9mkBewAqcUH77di7QipH9Vj6AB0g@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 04, 2022 at 09:06:01PM -0400, Josef Bacik wrote:
> On Mon, Apr 4, 2022 at 8:58 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Mon, Apr 04, 2022 at 08:39:14PM -0400, Josef Bacik wrote:
> > > On Mon, Apr 4, 2022 at 8:28 PM Marc MERLIN <marc@merlins.org> wrote:
> > > >
> > > > On Mon, Apr 04, 2022 at 08:24:55PM -0400, Josef Bacik wrote:
> > > > > > Binary identical after rebuild.
> > > > >
> > > > > Sigh time for printf sanity checks, thanks,
> > > >
> > >
> > > I'm dumb, try again please, thanks,
> >
> > progress :)
> 
> Ok, lets try
> 
> btrfs inspect-internal dump-tree -b 13577779511296
> 
> and see what that gives us, the root we think is ok is missing the
> part with the actual root items.  Thanks,

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs inspect-internal dump-tree -b 13577779511296            
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
parent transid verify failed on 22216704 wanted 1600938 found 1602177
Ignoring transid failure
FS_INFO IS 0x55de98e14470
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
Ignoring transid failure
Couldn't find the last root for 4
Couldn't setup device tree
FS_INFO AFTER IS 0x55de98e14470
btrfs-progs v5.16.2 
leaf 13577779511296 items 201 free space 1149 generation 1602242 owner EXTENT_TREE
leaf 13577779511296 flags 0x1(WRITTEN) backref revision 1
fs uuid 96539b8c-ccc9-47bf-9e6c-29305890941e
chunk uuid 7257b24b-3702-41e5-8b61-6f6ea524255a
	item 0 key (747913936896 EXTENT_ITEM 16384) itemoff 16230 itemsize 53
		refs 1 gen 1453690 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12953489408 count 1
	item 1 key (747913953280 EXTENT_ITEM 4096) itemoff 16177 itemsize 53
		refs 1 gen 1453690 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12953620480 count 1
	item 2 key (747913957376 EXTENT_ITEM 16384) itemoff 16124 itemsize 53
		refs 1 gen 1453690 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12953645056 count 1
	item 3 key (747913973760 EXTENT_ITEM 20480) itemoff 16071 itemsize 53
		refs 1 gen 1453690 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12953776128 count 1
	item 4 key (747913994240 EXTENT_ITEM 12288) itemoff 16018 itemsize 53
		refs 1 gen 1453690 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12953907200 count 1
	item 5 key (747914006528 EXTENT_ITEM 16384) itemoff 15965 itemsize 53
		refs 1 gen 1453690 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12953985024 count 1
	item 6 key (747914022912 EXTENT_ITEM 20480) itemoff 15912 itemsize 53
		refs 1 gen 1453690 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12954083328 count 1
	item 7 key (747914043392 EXTENT_ITEM 20480) itemoff 15859 itemsize 53
		refs 1 gen 1453690 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12954214400 count 1
	item 8 key (747914063872 EXTENT_ITEM 4096) itemoff 15806 itemsize 53
		refs 1 gen 1453690 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12954345472 count 1
	item 9 key (747914067968 EXTENT_ITEM 9043968) itemoff 15753 itemsize 53
		refs 1 gen 1467378 flags DATA
		extent data backref root 11288 objectid 38180 offset 413532160 count 1
	item 10 key (747923111936 EXTENT_ITEM 36864) itemoff 15716 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 11 key (747923148800 EXTENT_ITEM 36864) itemoff 15679 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 12 key (747923210240 EXTENT_ITEM 28672) itemoff 15626 itemsize 53
		refs 1 gen 1539316 flags DATA
		extent data backref root 11288 objectid 72889 offset 169021440 count 1
	item 13 key (747923238912 EXTENT_ITEM 131072) itemoff 15573 itemsize 53
		refs 1 gen 1486211 flags DATA
		extent data backref root 11288 objectid 39190 offset 0 count 1
	item 14 key (747923369984 EXTENT_ITEM 4096) itemoff 15520 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5733089280 count 1
	item 15 key (747923374080 EXTENT_ITEM 262144) itemoff 15467 itemsize 53
		refs 1 gen 1472819 flags DATA
		extent data backref root ROOT_TREE objectid 1377 offset 0 count 1
	item 16 key (747923636224 EXTENT_ITEM 53248) itemoff 15414 itemsize 53
		refs 1 gen 1509130 flags DATA
		extent data backref root 11288 objectid 49146 offset 0 count 1
	item 17 key (747923689472 EXTENT_ITEM 57344) itemoff 15361 itemsize 53
		refs 1 gen 1509130 flags DATA
		extent data backref root 11288 objectid 49147 offset 0 count 1
	item 18 key (747923746816 EXTENT_ITEM 8192) itemoff 15308 itemsize 53
		refs 1 gen 1509156 flags DATA
		extent data backref root 11288 objectid 50588 offset 0 count 1
	item 19 key (747923755008 EXTENT_ITEM 8192) itemoff 15255 itemsize 53
		refs 1 gen 1509156 flags DATA
		extent data backref root 11288 objectid 50613 offset 0 count 1
	item 20 key (747923763200 EXTENT_ITEM 4096) itemoff 15202 itemsize 53
		refs 1 gen 1509865 flags DATA
		extent data backref root 11288 objectid 70849 offset 0 count 1
	item 21 key (747923767296 EXTENT_ITEM 77824) itemoff 15149 itemsize 53
		refs 1 gen 1509129 flags DATA
		extent data backref root 11288 objectid 49044 offset 0 count 1
	item 22 key (747923845120 EXTENT_ITEM 53248) itemoff 15096 itemsize 53
		refs 1 gen 1509130 flags DATA
		extent data backref root 11288 objectid 49148 offset 0 count 1
	item 23 key (747923898368 EXTENT_ITEM 114688) itemoff 15043 itemsize 53
		refs 1 gen 1484194 flags DATA
		extent data backref root 11288 objectid 39120 offset 2883584 count 1
	item 24 key (747924013056 EXTENT_ITEM 36864) itemoff 15006 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 25 key (747924049920 EXTENT_ITEM 36864) itemoff 14969 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 26 key (747924086784 EXTENT_ITEM 36864) itemoff 14932 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 27 key (747924144128 EXTENT_ITEM 8192) itemoff 14879 itemsize 53
		refs 1 gen 1590235 flags DATA
		extent data backref root 11223 objectid 1823997 offset 0 count 1
	item 28 key (747924152320 EXTENT_ITEM 8192) itemoff 14826 itemsize 53
		refs 1 gen 1590235 flags DATA
		extent data backref root 11223 objectid 1823998 offset 0 count 1
	item 29 key (747924160512 EXTENT_ITEM 86016) itemoff 14773 itemsize 53
		refs 1 gen 1508916 flags DATA
		extent data backref root 11288 objectid 40988 offset 393216 count 1
	item 30 key (747924246528 EXTENT_ITEM 114688) itemoff 14720 itemsize 53
		refs 1 gen 1508916 flags DATA
		extent data backref root 11288 objectid 40988 offset 524288 count 1
	item 31 key (747924361216 EXTENT_ITEM 32768) itemoff 14667 itemsize 53
		refs 1 gen 1508973 flags DATA
		extent data backref root 11288 objectid 41258 offset 0 count 1
	item 32 key (747924393984 EXTENT_ITEM 28672) itemoff 14614 itemsize 53
		refs 1 gen 1508973 flags DATA
		extent data backref root 11288 objectid 41261 offset 0 count 1
	item 33 key (747924422656 EXTENT_ITEM 16384) itemoff 14561 itemsize 53
		refs 1 gen 1453686 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12942655488 count 1
	item 34 key (747924439040 EXTENT_ITEM 16384) itemoff 14508 itemsize 53
		refs 1 gen 1453686 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12942786560 count 1
	item 35 key (747924455424 EXTENT_ITEM 196608) itemoff 14455 itemsize 53
		refs 1 gen 1482902 flags DATA
		extent data backref root 11288 objectid 39004 offset 2231795712 count 1
	item 36 key (747924652032 EXTENT_ITEM 53248) itemoff 14402 itemsize 53
		refs 1 gen 1482903 flags DATA
		extent data backref root 11288 objectid 39005 offset 131072 count 1
	item 37 key (747924705280 EXTENT_ITEM 36864) itemoff 14365 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 38 key (747924742144 EXTENT_ITEM 36864) itemoff 14328 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 39 key (747924779008 EXTENT_ITEM 36864) itemoff 14291 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 40 key (747924815872 EXTENT_ITEM 36864) itemoff 14254 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 41 key (747924852736 EXTENT_ITEM 36864) itemoff 14217 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 42 key (747924889600 EXTENT_ITEM 36864) itemoff 14180 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 43 key (747924934656 EXTENT_ITEM 28672) itemoff 14127 itemsize 53
		refs 1 gen 1565039 flags DATA
		extent data backref root 11288 objectid 75169 offset 6160384 count 1
	item 44 key (747924963328 EXTENT_ITEM 4096) itemoff 14074 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5733220352 count 1
	item 45 key (747924967424 EXTENT_ITEM 4096) itemoff 14021 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5733351424 count 1
	item 46 key (747924971520 EXTENT_ITEM 4096) itemoff 13968 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5733482496 count 1
	item 47 key (747924975616 EXTENT_ITEM 4096) itemoff 13915 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5733613568 count 1
	item 48 key (747924979712 EXTENT_ITEM 36864) itemoff 13862 itemsize 53
		refs 1 gen 1597228 flags DATA
		extent data backref root 11221 objectid 414410 offset 0 count 1
	item 49 key (747925016576 EXTENT_ITEM 36864) itemoff 13809 itemsize 53
		refs 1 gen 1597228 flags DATA
		extent data backref root 11221 objectid 414410 offset 131072 count 1
	item 50 key (747925053440 EXTENT_ITEM 36864) itemoff 13756 itemsize 53
		refs 1 gen 1597228 flags DATA
		extent data backref root 11221 objectid 414410 offset 262144 count 1
	item 51 key (747925090304 EXTENT_ITEM 36864) itemoff 13703 itemsize 53
		refs 1 gen 1597228 flags DATA
		extent data backref root 11221 objectid 414410 offset 393216 count 1
	item 52 key (747925127168 EXTENT_ITEM 36864) itemoff 13650 itemsize 53
		refs 1 gen 1597228 flags DATA
		extent data backref root 11221 objectid 414410 offset 524288 count 1
	item 53 key (747925164032 EXTENT_ITEM 36864) itemoff 13597 itemsize 53
		refs 1 gen 1597228 flags DATA
		extent data backref root 11221 objectid 414410 offset 655360 count 1
	item 54 key (747925200896 EXTENT_ITEM 36864) itemoff 13544 itemsize 53
		refs 1 gen 1597228 flags DATA
		extent data backref root 11221 objectid 414410 offset 786432 count 1
	item 55 key (747925241856 EXTENT_ITEM 155648) itemoff 13491 itemsize 53
		refs 1 gen 1509071 flags DATA
		extent data backref root 11288 objectid 46649 offset 0 count 1
	item 56 key (747925397504 EXTENT_ITEM 86016) itemoff 13454 itemsize 37
		refs 1 gen 1509093 flags DATA
		shared data backref parent 12512079577088 count 1
	item 57 key (747925483520 EXTENT_ITEM 20480) itemoff 13401 itemsize 53
		refs 1 gen 1509156 flags DATA
		extent data backref root 11288 objectid 50590 offset 0 count 1
	item 58 key (747925504000 EXTENT_ITEM 36864) itemoff 13364 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 59 key (747925540864 EXTENT_ITEM 36864) itemoff 13327 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 60 key (747925577728 EXTENT_ITEM 36864) itemoff 13290 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 61 key (747925614592 EXTENT_ITEM 36864) itemoff 13253 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 62 key (747925651456 EXTENT_ITEM 36864) itemoff 13216 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 63 key (747925700608 EXTENT_ITEM 4096) itemoff 13163 itemsize 53
		refs 1 gen 1590235 flags DATA
		extent data backref root 11223 objectid 1824000 offset 0 count 1
	item 64 key (747925704704 EXTENT_ITEM 4096) itemoff 13110 itemsize 53
		refs 1 gen 1590235 flags DATA
		extent data backref root 11223 objectid 1824005 offset 0 count 1
	item 65 key (747925708800 EXTENT_ITEM 4096) itemoff 13057 itemsize 53
		refs 1 gen 1590235 flags DATA
		extent data backref root 11223 objectid 1824007 offset 0 count 1
	item 66 key (747925712896 EXTENT_ITEM 12288) itemoff 13004 itemsize 53
		refs 1 gen 1553656 flags DATA
		extent data backref root 11288 objectid 74580 offset 0 count 1
	item 67 key (747925725184 EXTENT_ITEM 4096) itemoff 12951 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5733744640 count 1
	item 68 key (747925729280 EXTENT_ITEM 49152) itemoff 12898 itemsize 53
		refs 1 gen 1484713 flags DATA
		extent data backref root 11288 objectid 39130 offset 0 count 1
	item 69 key (747925778432 EXTENT_ITEM 57344) itemoff 12845 itemsize 53
		refs 1 gen 1484739 flags DATA
		extent data backref root 11288 objectid 39131 offset 727973888 count 1
	item 70 key (747925835776 EXTENT_ITEM 32768) itemoff 12808 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510516736 count 1
	item 71 key (747925868544 EXTENT_ITEM 4096) itemoff 12755 itemsize 53
		refs 1 gen 1590235 flags DATA
		extent data backref root 11223 objectid 1824014 offset 0 count 1
	item 72 key (747925872640 EXTENT_ITEM 4096) itemoff 12702 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5733875712 count 1
	item 73 key (747925876736 EXTENT_ITEM 4096) itemoff 12649 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5734006784 count 1
	item 74 key (747925880832 EXTENT_ITEM 4096) itemoff 12596 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5734137856 count 1
	item 75 key (747925884928 EXTENT_ITEM 4096) itemoff 12543 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5734268928 count 1
	item 76 key (747925889024 EXTENT_ITEM 4096) itemoff 12490 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5734400000 count 1
	item 77 key (747925893120 EXTENT_ITEM 4096) itemoff 12437 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5734531072 count 1
	item 78 key (747925897216 EXTENT_ITEM 118784) itemoff 12384 itemsize 53
		refs 1 gen 1484194 flags DATA
		extent data backref root 11288 objectid 39120 offset 3014656 count 1
	item 79 key (747926016000 EXTENT_ITEM 114688) itemoff 12331 itemsize 53
		refs 1 gen 1484194 flags DATA
		extent data backref root 11288 objectid 39120 offset 3145728 count 1
	item 80 key (747926130688 EXTENT_ITEM 36864) itemoff 12294 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 81 key (747926167552 EXTENT_ITEM 36864) itemoff 12257 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 82 key (747926204416 EXTENT_ITEM 36864) itemoff 12220 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 83 key (747926241280 EXTENT_ITEM 36864) itemoff 12183 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 84 key (747926278144 EXTENT_ITEM 36864) itemoff 12146 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 85 key (747926315008 EXTENT_ITEM 36864) itemoff 12109 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 86 key (747926360064 EXTENT_ITEM 20480) itemoff 12056 itemsize 53
		refs 1 gen 1590234 flags DATA
		extent data backref root 11223 objectid 1823985 offset 0 count 1
	item 87 key (747926380544 EXTENT_ITEM 4096) itemoff 12003 itemsize 53
		refs 1 gen 1590235 flags DATA
		extent data backref root 11223 objectid 1824015 offset 0 count 1
	item 88 key (747926384640 EXTENT_ITEM 4096) itemoff 11950 itemsize 53
		refs 1 gen 1590235 flags DATA
		extent data backref root 11223 objectid 1824020 offset 0 count 1
	item 89 key (747926388736 EXTENT_ITEM 4096) itemoff 11897 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5734662144 count 1
	item 90 key (747926392832 EXTENT_ITEM 36864) itemoff 11860 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 91 key (747926458368 EXTENT_ITEM 4096) itemoff 11807 itemsize 53
		refs 1 gen 1590235 flags DATA
		extent data backref root 11223 objectid 1824030 offset 0 count 1
	item 92 key (747926462464 EXTENT_ITEM 4096) itemoff 11754 itemsize 53
		refs 1 gen 1590235 flags DATA
		extent data backref root 11223 objectid 1824032 offset 0 count 1
	item 93 key (747926466560 EXTENT_ITEM 4096) itemoff 11701 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5734793216 count 1
	item 94 key (747926470656 EXTENT_ITEM 4096) itemoff 11648 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5734924288 count 1
	item 95 key (747926474752 EXTENT_ITEM 53248) itemoff 11595 itemsize 53
		refs 1 gen 1483072 flags DATA
		extent data backref root 11288 objectid 39029 offset 0 count 1
	item 96 key (747926528000 EXTENT_ITEM 4096) itemoff 11542 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5735055360 count 1
	item 97 key (747926532096 EXTENT_ITEM 4096) itemoff 11489 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5735186432 count 1
	item 98 key (747926536192 EXTENT_ITEM 4096) itemoff 11436 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5735317504 count 1
	item 99 key (747926540288 EXTENT_ITEM 4096) itemoff 11383 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5735448576 count 1
	item 100 key (747926544384 EXTENT_ITEM 4096) itemoff 11330 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5735579648 count 1
	item 101 key (747926548480 EXTENT_ITEM 4096) itemoff 11277 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5735710720 count 1
	item 102 key (747926552576 EXTENT_ITEM 53248) itemoff 11224 itemsize 53
		refs 1 gen 1482894 flags DATA
		extent data backref root 11288 objectid 39000 offset 1179648 count 1
	item 103 key (747926605824 EXTENT_ITEM 57344) itemoff 11171 itemsize 53
		refs 1 gen 1482894 flags DATA
		extent data backref root 11288 objectid 39000 offset 1310720 count 1
	item 104 key (747926663168 EXTENT_ITEM 53248) itemoff 11118 itemsize 53
		refs 1 gen 1482894 flags DATA
		extent data backref root 11288 objectid 39000 offset 1441792 count 1
	item 105 key (747926716416 EXTENT_ITEM 53248) itemoff 11065 itemsize 53
		refs 1 gen 1482894 flags DATA
		extent data backref root 11288 objectid 39000 offset 1572864 count 1
	item 106 key (747926769664 EXTENT_ITEM 32768) itemoff 11012 itemsize 53
		refs 1 gen 1482894 flags DATA
		extent data backref root 11288 objectid 39001 offset 524288 count 1
	item 107 key (747926802432 EXTENT_ITEM 4096) itemoff 10959 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5735841792 count 1
	item 108 key (747926806528 EXTENT_ITEM 4096) itemoff 10906 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5735972864 count 1
	item 109 key (747926810624 EXTENT_ITEM 4096) itemoff 10853 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5736103936 count 1
	item 110 key (747926814720 EXTENT_ITEM 262144) itemoff 10800 itemsize 53
		refs 1 gen 1474024 flags DATA
		extent data backref root ROOT_TREE objectid 2566 offset 0 count 1
	item 111 key (747927076864 EXTENT_ITEM 16384) itemoff 10747 itemsize 53
		refs 1 gen 1453686 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12943011840 count 1
	item 112 key (747927093248 EXTENT_ITEM 16384) itemoff 10694 itemsize 53
		refs 1 gen 1453686 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12943142912 count 1
	item 113 key (747927109632 EXTENT_ITEM 8192) itemoff 10641 itemsize 53
		refs 1 gen 1453686 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12943273984 count 1
	item 114 key (747927117824 EXTENT_ITEM 32768) itemoff 10588 itemsize 53
		refs 1 gen 1602242 flags DATA
		extent data backref root 11221 objectid 414456 offset 0 count 1
	item 115 key (747927150592 EXTENT_ITEM 36864) itemoff 10535 itemsize 53
		refs 1 gen 1602242 flags DATA
		extent data backref root 11221 objectid 414456 offset 131072 count 1
	item 116 key (747927187456 EXTENT_ITEM 32768) itemoff 10482 itemsize 53
		refs 1 gen 1602242 flags DATA
		extent data backref root 11221 objectid 414456 offset 262144 count 1
	item 117 key (747927379968 EXTENT_ITEM 229376) itemoff 10429 itemsize 53
		refs 1 gen 1482585 flags DATA
		extent data backref root 11288 objectid 38979 offset 5445386240 count 1
	item 118 key (747927609344 EXTENT_ITEM 32768) itemoff 10376 itemsize 53
		refs 1 gen 1482590 flags DATA
		extent data backref root 11288 objectid 38979 offset 9466732544 count 1
	item 119 key (747927642112 EXTENT_ITEM 229376) itemoff 10323 itemsize 53
		refs 1 gen 1482593 flags DATA
		extent data backref root 11288 objectid 38979 offset 11495415808 count 1
	item 120 key (747927871488 EXTENT_ITEM 32768) itemoff 10286 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510516736 count 1
	item 121 key (747927904256 EXTENT_ITEM 524288) itemoff 10233 itemsize 53
		refs 1 gen 1483575 flags DATA
		extent data backref root 11288 objectid 39051 offset 524288 count 1
	item 122 key (747928428544 EXTENT_ITEM 36864) itemoff 10196 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 123 key (747928494080 EXTENT_ITEM 4096) itemoff 10143 itemsize 53
		refs 1 gen 1590235 flags DATA
		extent data backref root 11223 objectid 1824033 offset 0 count 1
	item 124 key (747928498176 EXTENT_ITEM 4096) itemoff 10090 itemsize 53
		refs 1 gen 1590235 flags DATA
		extent data backref root 11223 objectid 1824036 offset 0 count 1
	item 125 key (747928502272 EXTENT_ITEM 4096) itemoff 10037 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5736235008 count 1
	item 126 key (747928506368 EXTENT_ITEM 4096) itemoff 9984 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5736366080 count 1
	item 127 key (747928510464 EXTENT_ITEM 8192) itemoff 9931 itemsize 53
		refs 1 gen 1553656 flags DATA
		extent data backref root 11288 objectid 74580 offset 393216 count 1
	item 128 key (747928518656 EXTENT_ITEM 8192) itemoff 9878 itemsize 53
		refs 1 gen 1553656 flags DATA
		extent data backref root 11288 objectid 74581 offset 131072 count 1
	item 129 key (747928526848 EXTENT_ITEM 110592) itemoff 9825 itemsize 53
		refs 1 gen 1477712 flags DATA
		extent data backref root 11288 objectid 38340 offset 3955474432 count 1
	item 130 key (747928637440 EXTENT_ITEM 32768) itemoff 9788 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510516736 count 1
	item 131 key (747928670208 EXTENT_ITEM 4096) itemoff 9735 itemsize 53
		refs 1 gen 1590235 flags DATA
		extent data backref root 11223 objectid 1824038 offset 0 count 1
	item 132 key (747928674304 EXTENT_ITEM 8192) itemoff 9682 itemsize 53
		refs 1 gen 1480427 flags DATA
		extent data backref root 11288 objectid 38887 offset 0 count 1
	item 133 key (747928682496 EXTENT_ITEM 8192) itemoff 9629 itemsize 53
		refs 1 gen 1477753 flags DATA
		extent data backref root 11288 objectid 38401 offset 2228224 count 1
	item 134 key (747928690688 EXTENT_ITEM 229376) itemoff 9576 itemsize 53
		refs 1 gen 1482583 flags DATA
		extent data backref root 11288 objectid 38979 offset 5248192512 count 1
	item 135 key (747928920064 EXTENT_ITEM 32768) itemoff 9523 itemsize 53
		refs 1 gen 1482590 flags DATA
		extent data backref root 11288 objectid 38979 offset 9702588416 count 1
	item 136 key (747928952832 EXTENT_ITEM 262144) itemoff 9470 itemsize 53
		refs 1 gen 1482580 flags DATA
		extent data backref root ROOT_TREE objectid 5552 offset 0 count 1
	item 137 key (747929214976 EXTENT_ITEM 16384) itemoff 9417 itemsize 53
		refs 1 gen 1453686 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12943327232 count 1
	item 138 key (747929231360 EXTENT_ITEM 16384) itemoff 9364 itemsize 53
		refs 1 gen 1453686 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12943458304 count 1
	item 139 key (747929247744 EXTENT_ITEM 4096) itemoff 9311 itemsize 53
		refs 1 gen 1453686 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12943589376 count 1
	item 140 key (747929251840 EXTENT_ITEM 524288) itemoff 9258 itemsize 53
		refs 1 gen 1480794 flags DATA
		extent data backref root 11288 objectid 38927 offset 1572864 count 1
	item 141 key (747929776128 EXTENT_ITEM 196608) itemoff 9205 itemsize 53
		refs 1 gen 1482583 flags DATA
		extent data backref root 11288 objectid 38979 offset 5799989248 count 1
	item 142 key (747929972736 EXTENT_ITEM 65536) itemoff 9152 itemsize 53
		refs 1 gen 1482585 flags DATA
		extent data backref root 11288 objectid 38979 offset 6808727552 count 1
	item 143 key (747930038272 EXTENT_ITEM 65536) itemoff 9099 itemsize 53
		refs 1 gen 1482586 flags DATA
		extent data backref root 11288 objectid 38979 offset 6901035008 count 1
	item 144 key (747930103808 EXTENT_ITEM 65536) itemoff 9046 itemsize 53
		refs 1 gen 1482586 flags DATA
		extent data backref root 11288 objectid 38979 offset 7791390720 count 1
	item 145 key (747930169344 EXTENT_ITEM 61440) itemoff 8993 itemsize 53
		refs 1 gen 1530100 flags DATA
		extent data backref root 11288 objectid 72155 offset 367656960 count 1
	item 146 key (747930230784 EXTENT_ITEM 61440) itemoff 8940 itemsize 53
		refs 1 gen 1530100 flags DATA
		extent data backref root 11288 objectid 72155 offset 367788032 count 1
	item 147 key (747930292224 EXTENT_ITEM 8192) itemoff 8887 itemsize 53
		refs 1 gen 1553656 flags DATA
		extent data backref root 11288 objectid 74581 offset 262144 count 1
	item 148 key (747930300416 EXTENT_ITEM 69632) itemoff 8834 itemsize 53
		refs 1 gen 1530011 flags DATA
		extent data backref root 11288 objectid 72146 offset 0 count 1
	item 149 key (747930370048 EXTENT_ITEM 61440) itemoff 8781 itemsize 53
		refs 1 gen 1530025 flags DATA
		extent data backref root 11288 objectid 72148 offset 367656960 count 1
	item 150 key (747930431488 EXTENT_ITEM 131072) itemoff 8728 itemsize 53
		refs 1 gen 1482583 flags DATA
		extent data backref root 11288 objectid 38979 offset 6275604480 count 1
	item 151 key (747930562560 EXTENT_ITEM 229376) itemoff 8675 itemsize 53
		refs 1 gen 1482588 flags DATA
		extent data backref root 11288 objectid 38979 offset 8650186752 count 1
	item 152 key (747930791936 EXTENT_ITEM 32768) itemoff 8622 itemsize 53
		refs 1 gen 1482590 flags DATA
		extent data backref root 11288 objectid 38979 offset 9860608000 count 1
	item 153 key (747930824704 EXTENT_ITEM 196608) itemoff 8569 itemsize 53
		refs 1 gen 1482582 flags DATA
		extent data backref root 11288 objectid 38979 offset 6011453440 count 1
	item 154 key (747931021312 EXTENT_ITEM 65536) itemoff 8516 itemsize 53
		refs 1 gen 1482585 flags DATA
		extent data backref root 11288 objectid 38979 offset 7213383680 count 1
	item 155 key (747931086848 EXTENT_ITEM 94208) itemoff 8463 itemsize 53
		refs 1 gen 1477873 flags DATA
		extent data backref root 11288 objectid 38444 offset 262144 count 1
	item 156 key (747931181056 EXTENT_ITEM 20480) itemoff 8410 itemsize 53
		refs 1 gen 1477873 flags DATA
		extent data backref root 11288 objectid 38444 offset 2621440 count 1
	item 157 key (747931201536 EXTENT_ITEM 114688) itemoff 8357 itemsize 53
		refs 1 gen 1477874 flags DATA
		extent data backref root 11288 objectid 38444 offset 113442816 count 1
	item 158 key (747931316224 EXTENT_ITEM 16384) itemoff 8304 itemsize 53
		refs 1 gen 1477879 flags DATA
		extent data backref root 11288 objectid 38444 offset 848715776 count 1
	item 159 key (747931332608 EXTENT_ITEM 4096) itemoff 8251 itemsize 53
		refs 1 gen 1477880 flags DATA
		extent data backref root 11288 objectid 38444 offset 848728064 count 1
	item 160 key (747931336704 EXTENT_ITEM 12288) itemoff 8198 itemsize 53
		refs 1 gen 1477883 flags DATA
		extent data backref root 11288 objectid 38448 offset 2752512 count 1
	item 161 key (747931348992 EXTENT_ITEM 8192) itemoff 8145 itemsize 53
		refs 1 gen 1453686 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12943601664 count 1
	item 162 key (747931357184 EXTENT_ITEM 229376) itemoff 8092 itemsize 53
		refs 1 gen 1482585 flags DATA
		extent data backref root 11288 objectid 38979 offset 6740770816 count 1
	item 163 key (747931586560 EXTENT_ITEM 32768) itemoff 8039 itemsize 53
		refs 1 gen 1482590 flags DATA
		extent data backref root 11288 objectid 38979 offset 9932337152 count 1
	item 164 key (747931619328 EXTENT_ITEM 36864) itemoff 8002 itemsize 37
		refs 1 gen 1592383 flags DATA
		shared data backref parent 15645802905600 count 1
	item 165 key (747931656192 EXTENT_ITEM 36864) itemoff 7965 itemsize 37
		refs 1 gen 1592383 flags DATA
		shared data backref parent 15645802905600 count 1
	item 166 key (747931693056 EXTENT_ITEM 36864) itemoff 7928 itemsize 37
		refs 1 gen 1592383 flags DATA
		shared data backref parent 15645802905600 count 1
	item 167 key (747931750400 EXTENT_ITEM 36864) itemoff 7891 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 168 key (747931787264 EXTENT_ITEM 36864) itemoff 7854 itemsize 37
		refs 1 gen 1592254 flags DATA
		shared data backref parent 15645510156288 count 1
	item 169 key (747931848704 EXTENT_ITEM 4096) itemoff 7801 itemsize 53
		refs 1 gen 1590235 flags DATA
		extent data backref root 11223 objectid 1824046 offset 0 count 1
	item 170 key (747931852800 EXTENT_ITEM 24576) itemoff 7748 itemsize 53
		refs 1 gen 1539342 flags DATA
		extent data backref root 11288 objectid 72973 offset 327155712 count 1
	item 171 key (747931877376 EXTENT_ITEM 4096) itemoff 7695 itemsize 53
		refs 1 gen 1502140 flags DATA
		extent data backref root 11288 objectid 40707 offset 5736497152 count 1
	item 172 key (747931881472 EXTENT_ITEM 8192) itemoff 7642 itemsize 53
		refs 1 gen 1453686 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12943663104 count 1
	item 173 key (747931889664 EXTENT_ITEM 65536) itemoff 7589 itemsize 53
		refs 1 gen 1482895 flags DATA
		extent data backref root 11288 objectid 39001 offset 370343936 count 1
	item 174 key (747931955200 EXTENT_ITEM 65536) itemoff 7536 itemsize 53
		refs 1 gen 1482895 flags DATA
		extent data backref root 11288 objectid 39001 offset 853999616 count 1
	item 175 key (747932020736 EXTENT_ITEM 98304) itemoff 7483 itemsize 53
		refs 1 gen 1482897 flags DATA
		extent data backref root 11288 objectid 39001 offset 1256620032 count 1
	item 176 key (747932119040 EXTENT_ITEM 32768) itemoff 7430 itemsize 53
		refs 1 gen 1482897 flags DATA
		extent data backref root 11288 objectid 39001 offset 1269202944 count 1
	item 177 key (747932151808 EXTENT_ITEM 139264) itemoff 7377 itemsize 53
		refs 1 gen 1509071 flags DATA
		extent data backref root 11288 objectid 46650 offset 0 count 1
	item 178 key (747932291072 EXTENT_ITEM 122880) itemoff 7340 itemsize 37
		refs 1 gen 1509093 flags DATA
		shared data backref parent 12512079577088 count 1
	item 179 key (747932413952 EXTENT_ITEM 12288) itemoff 7287 itemsize 53
		refs 1 gen 1453686 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12943728640 count 1
	item 180 key (747932426240 EXTENT_ITEM 262144) itemoff 7234 itemsize 53
		refs 1 gen 1472827 flags DATA
		extent data backref root ROOT_TREE objectid 1376 offset 0 count 1
	item 181 key (747932688384 EXTENT_ITEM 262144) itemoff 7181 itemsize 53
		refs 1 gen 1482897 flags DATA
		extent data backref root 11288 objectid 39001 offset 1145307136 count 1
	item 182 key (747932950528 EXTENT_ITEM 40960) itemoff 7128 itemsize 53
		refs 1 gen 1509030 flags DATA
		extent data backref root 11288 objectid 43699 offset 0 count 1
	item 183 key (747932991488 EXTENT_ITEM 53248) itemoff 7075 itemsize 53
		refs 1 gen 1509030 flags DATA
		extent data backref root 11288 objectid 43700 offset 0 count 1
	item 184 key (747933044736 EXTENT_ITEM 69632) itemoff 7022 itemsize 53
		refs 1 gen 1509030 flags DATA
		extent data backref root 11288 objectid 43701 offset 0 count 1
	item 185 key (747933114368 EXTENT_ITEM 77824) itemoff 6969 itemsize 53
		refs 1 gen 1509030 flags DATA
		extent data backref root 11288 objectid 43702 offset 0 count 1
	item 186 key (747933192192 EXTENT_ITEM 262144) itemoff 6916 itemsize 53
		refs 1 gen 1550304 flags DATA
		extent data backref root ROOT_TREE objectid 57451 offset 0 count 1
	item 187 key (747933454336 EXTENT_ITEM 20480) itemoff 6863 itemsize 53
		refs 1 gen 1509156 flags DATA
		extent data backref root 11288 objectid 50591 offset 0 count 1
	item 188 key (747933474816 EXTENT_ITEM 262144) itemoff 6810 itemsize 53
		refs 1 gen 1550313 flags DATA
		extent data backref root ROOT_TREE objectid 57448 offset 0 count 1
	item 189 key (747933736960 EXTENT_ITEM 262144) itemoff 6757 itemsize 53
		refs 1 gen 1472802 flags DATA
		extent data backref root ROOT_TREE objectid 1368 offset 0 count 1
	item 190 key (747933999104 EXTENT_ITEM 16384) itemoff 6704 itemsize 53
		refs 1 gen 1453688 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12949532672 count 1
	item 191 key (747934015488 EXTENT_ITEM 16384) itemoff 6651 itemsize 53
		refs 1 gen 1453688 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12949663744 count 1
	item 192 key (747934031872 EXTENT_ITEM 8192) itemoff 6598 itemsize 53
		refs 1 gen 1453688 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12949794816 count 1
	item 193 key (747934040064 EXTENT_ITEM 8192) itemoff 6545 itemsize 53
		refs 1 gen 1453688 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12949843968 count 1
	item 194 key (747934048256 EXTENT_ITEM 16384) itemoff 6492 itemsize 53
		refs 1 gen 1453688 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12949905408 count 1
	item 195 key (747934064640 EXTENT_ITEM 8192) itemoff 6439 itemsize 53
		refs 1 gen 1453688 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12950036480 count 1
	item 196 key (747934072832 EXTENT_ITEM 12288) itemoff 6386 itemsize 53
		refs 1 gen 1453688 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12950093824 count 1
	item 197 key (747934085120 EXTENT_ITEM 4096) itemoff 6333 itemsize 53
		refs 1 gen 1453688 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12950089728 count 1
	item 198 key (747934089216 EXTENT_ITEM 20480) itemoff 6280 itemsize 53
		refs 1 gen 1453690 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12954370048 count 1
	item 199 key (747934109696 EXTENT_ITEM 20480) itemoff 6227 itemsize 53
		refs 1 gen 1453690 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12954501120 count 1
	item 200 key (747934130176 EXTENT_ITEM 4096) itemoff 6174 itemsize 53
		refs 1 gen 1453690 flags DATA
		extent data backref root FS_TREE objectid 1003 offset 12954632192 count 1

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
