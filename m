Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F42F31DAE4
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 14:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhBQNpw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 08:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbhBQNpr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 08:45:47 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AFDC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 05:45:05 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1lCN8Y-0005mu-6a; Wed, 17 Feb 2021 13:45:02 +0000
Date:   Wed, 17 Feb 2021 13:45:02 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Samir Benmendil <me@rmz.io>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: BTRFS error (device dm-0): block=711870922752 write time tree
 block corruption detected
Message-ID: <20210217134502.GU4090@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Samir Benmendil <me@rmz.io>, linux-btrfs@vger.kernel.org
References: <20210217132640.r44q7ccfz2fohvxy@hactar>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
In-Reply-To: <20210217132640.r44q7ccfz2fohvxy@hactar>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 17, 2021 at 01:26:40PM +0000, Samir Benmendil wrote:
> Hello list,
> 
> I've just had my btrfs volume remounted read-only, the logs read as such:
> 
>    BTRFS critical (device dm-0): corrupt leaf: root=2 block=711870922752 slot=275, bad key order, prev (693626798080 182 702129324032) current (693626798080 182 701861986304)
>    BTRFS info (device dm-0): leaf 711870922752 gen 610518 total ptrs 509 free space 276 owner 2
>    <snip>    BTRFS error (device dm-0): block=711870922752 write time tree
> block corruption detected
>    BTRFS: error (device dm-0) in btrfs_commit_transaction:2376: errno=-5 IO failure (Error while writing out transaction)
>    BTRFS info (device dm-0): forced readonly
>    BTRFS warning (device dm-0): Skipping commit of aborted transaction.
>    BTRFS: error (device dm-0) in cleanup_transaction:1941: errno=-5 IO failure
> 
> It's seems this coincided with a scheduled snapshot creation on that drive.
> 
> Any advice on what to do next would be appreciated.

   The first thing to do is run memtest for a while (I'd usually
recomment at least overnight) to identify your broken RAM module and
replace it. Don't try using the machine normally until you've done
that.

   This looks like a single-bit error (a 1 bit changing to a 0 bit in
this case):

>>> hex(702129324032)
'0xa37a2b4000'
>>> hex(701861986304)
'0xa36a3c0000'

   Note the 7 changing to a 6 -- these values should be increasing in
value, not decreasing.

   The write-time checker is doing exactly what it should be doing,
and preventing obviously-broken metadata reaching your filesystem.
Once you've fixed the hardware (and only then), I'd recommend running
a btrfs check --readonly just to make sure that there aren't any
obvious errors that made it through to disk.

   Hugo.

> Thanks in advance.
> 
> $ uname -a
> Linux hactar 5.10.15-arch1-1 #1 SMP PREEMPT Wed, 10 Feb 2021 18:32:40 +0000 x86_64 GNU/Linux
> $ btrfs version
> btrfs-progs v5.10.1

> -- Journal begins at Sat 2020-03-28 20:39:35 GMT, ends at Wed 2021-02-17 13:15:01 GMT. --
> Feb 17 11:00:34 hactar kernel: BTRFS critical (device dm-0): corrupt leaf: root=2 block=711870922752 slot=275, bad key order, prev (693626798080 182 702129324032) current (693626798080 182 701861986304)
> Feb 17 11:00:34 hactar kernel: BTRFS info (device dm-0): leaf 711870922752 gen 610518 total ptrs 509 free space 276 owner 2
> Feb 17 11:00:34 hactar kernel:         item 0 key (693626765312 169 0) itemoff 15458 itemsize 825
> Feb 17 11:00:34 hactar kernel:                 extent refs 89 gen 592321 flags 258
> Feb 17 11:00:34 hactar kernel:                 ref#0: shared block backref parent 693646163968
> Feb 17 11:00:34 hactar kernel:                 ref#1: shared block backref parent 693628502016
> Feb 17 11:00:34 hactar kernel:                 ref#2: shared block backref parent 693614460928
> Feb 17 11:00:34 hactar kernel:                 ref#3: shared block backref parent 693603991552
> Feb 17 11:00:34 hactar kernel:                 ref#4: shared block backref parent 693527379968
> Feb 17 11:00:34 hactar kernel:                 ref#5: shared block backref parent 693490483200
> Feb 17 11:00:34 hactar kernel:                 ref#6: shared block backref parent 693444968448
> Feb 17 11:00:34 hactar kernel:                 ref#7: shared block backref parent 693442478080
> Feb 17 11:00:34 hactar kernel:                 ref#8: shared block backref parent 693438906368
> Feb 17 11:00:34 hactar kernel:                 ref#9: shared block backref parent 693433057280
> Feb 17 11:00:34 hactar kernel:                 ref#10: shared block backref parent 693408710656
> Feb 17 11:00:34 hactar kernel:                 ref#11: shared block backref parent 693387526144
> Feb 17 11:00:34 hactar kernel:                 ref#12: shared block backref parent 693350809600
> Feb 17 11:00:34 hactar kernel:                 ref#13: shared block backref parent 693310963712
> Feb 17 11:00:34 hactar kernel:                 ref#14: shared block backref parent 693304655872
> Feb 17 11:00:34 hactar kernel:                 ref#15: shared block backref parent 693283717120
> Feb 17 11:00:34 hactar kernel:                 ref#16: shared block backref parent 693280112640
> Feb 17 11:00:34 hactar kernel:                 ref#17: shared block backref parent 693241184256
> Feb 17 11:00:34 hactar kernel:                 ref#18: shared block backref parent 693224652800
> Feb 17 11:00:34 hactar kernel:                 ref#19: shared block backref parent 693221130240
> Feb 17 11:00:34 hactar kernel:                 ref#20: shared block backref parent 693214494720
> Feb 17 11:00:34 hactar kernel:                 ref#21: shared block backref parent 693201338368
> Feb 17 11:00:34 hactar kernel:                 ref#22: shared block backref parent 693192916992
> Feb 17 11:00:34 hactar kernel:                 ref#23: shared block backref parent 693186248704
> Feb 17 11:00:34 hactar kernel:                 ref#24: shared block backref parent 693182889984
> Feb 17 11:00:34 hactar kernel:                 ref#25: shared block backref parent 693161934848
> Feb 17 11:00:34 hactar kernel:                 ref#26: shared block backref parent 693155282944
> Feb 17 11:00:34 hactar kernel:                 ref#27: shared block backref parent 693153824768
> Feb 17 11:00:34 hactar kernel:                 ref#28: shared block backref parent 693068660736
> Feb 17 11:00:34 hactar kernel:                 ref#29: shared block backref parent 692958543872
> Feb 17 11:00:34 hactar kernel:                 ref#30: shared block backref parent 692930576384
> Feb 17 11:00:34 hactar kernel:                 ref#31: shared block backref parent 692899201024
> Feb 17 11:00:34 hactar kernel:                 ref#32: shared block backref parent 692855209984
> Feb 17 11:00:34 hactar kernel:                 ref#33: shared block backref parent 692851097600
> Feb 17 11:00:34 hactar kernel:                 ref#34: shared block backref parent 692817297408
> Feb 17 11:00:34 hactar kernel:                 ref#35: shared block backref parent 692784480256
> Feb 17 11:00:34 hactar kernel:                 ref#36: shared block backref parent 692772601856
> Feb 17 11:00:34 hactar kernel:                 ref#37: shared block backref parent 692772028416
> Feb 17 11:00:34 hactar kernel:                 ref#38: shared block backref parent 692760920064
> Feb 17 11:00:34 hactar kernel:                 ref#39: shared block backref parent 692725104640
> Feb 17 11:00:34 hactar kernel:                 ref#40: shared block backref parent 692684210176
> Feb 17 11:00:34 hactar kernel:                 ref#41: shared block backref parent 692645494784
> Feb 17 11:00:34 hactar kernel:                 ref#42: shared block backref parent 692630945792
> Feb 17 11:00:34 hactar kernel:                 ref#43: shared block backref parent 692599029760
> Feb 17 11:00:34 hactar kernel:                 ref#44: shared block backref parent 687203106816
> Feb 17 11:00:34 hactar kernel:                 ref#45: shared block backref parent 687162507264
> Feb 17 11:00:34 hactar kernel:                 ref#46: shared block backref parent 686923300864
> Feb 17 11:00:34 hactar kernel:                 ref#47: shared block backref parent 686904885248
> Feb 17 11:00:34 hactar kernel:                 ref#48: shared block backref parent 686888697856
> Feb 17 11:00:34 hactar kernel:                 ref#49: shared block backref parent 686870953984
> Feb 17 11:00:34 hactar kernel:                 ref#50: shared block backref parent 686841610240
> Feb 17 11:00:34 hactar kernel:                 ref#51: shared block backref parent 686831861760
> Feb 17 11:00:34 hactar kernel:                 ref#52: shared block backref parent 686829322240
> Feb 17 11:00:34 hactar kernel:                 ref#53: shared block backref parent 686772961280
> Feb 17 11:00:34 hactar kernel:                 ref#54: shared block backref parent 686738341888
> Feb 17 11:00:34 hactar kernel:                 ref#55: shared block backref parent 686724775936
> Feb 17 11:00:34 hactar kernel:                 ref#56: shared block backref parent 686712684544
> Feb 17 11:00:34 hactar kernel:                 ref#57: shared block backref parent 686700412928
> Feb 17 11:00:34 hactar kernel:                 ref#58: shared block backref parent 686610546688
> Feb 17 11:00:34 hactar kernel:                 ref#59: shared block backref parent 686571094016
> Feb 17 11:00:34 hactar kernel:                 ref#60: shared block backref parent 686548697088
> Feb 17 11:00:34 hactar kernel:                 ref#61: shared block backref parent 686484258816
> Feb 17 11:00:34 hactar kernel:                 ref#62: shared block backref parent 686453850112
> Feb 17 11:00:34 hactar kernel:                 ref#63: shared block backref parent 686293860352
> Feb 17 11:00:34 hactar kernel:                 ref#64: shared block backref parent 686257504256
> Feb 17 11:00:34 hactar kernel:                 ref#65: shared block backref parent 678611419136
> Feb 17 11:00:34 hactar kernel:                 ref#66: shared block backref parent 678592249856
> Feb 17 11:00:34 hactar kernel:                 ref#67: shared block backref parent 678442582016
> Feb 17 11:00:34 hactar kernel:                 ref#68: shared block backref parent 678360809472
> Feb 17 11:00:34 hactar kernel:                 ref#69: shared block backref parent 678333218816
> Feb 17 11:00:34 hactar kernel:                 ref#70: shared block backref parent 678081642496
> Feb 17 11:00:34 hactar kernel:                 ref#71: shared block backref parent 677925847040
> Feb 17 11:00:34 hactar kernel:                 ref#72: shared block backref parent 677779357696
> Feb 17 11:00:34 hactar kernel:                 ref#73: shared block backref parent 677647532032
> Feb 17 11:00:34 hactar kernel:                 ref#74: shared block backref parent 677620875264
> Feb 17 11:00:34 hactar kernel:                 ref#75: shared block backref parent 674987098112
> Feb 17 11:00:34 hactar kernel:                 ref#76: shared block backref parent 674838822912
> Feb 17 11:00:34 hactar kernel:                 ref#77: shared block backref parent 674455633920
> Feb 17 11:00:34 hactar kernel:                 ref#78: shared block backref parent 670742200320
> Feb 17 11:00:34 hactar kernel:                 ref#79: shared block backref parent 670300798976
> Feb 17 11:00:34 hactar kernel:                 ref#80: shared block backref parent 665072893952
> Feb 17 11:00:34 hactar kernel:                 ref#81: shared block backref parent 664798380032
> Feb 17 11:00:34 hactar kernel:                 ref#82: shared block backref parent 660387184640
> Feb 17 11:00:34 hactar kernel:                 ref#83: shared block backref parent 656855597056
> Feb 17 11:00:34 hactar kernel:                 ref#84: shared block backref parent 621816430592
> Feb 17 11:00:34 hactar kernel:                 ref#85: shared block backref parent 621725532160
> Feb 17 11:00:34 hactar kernel:                 ref#86: shared block backref parent 595295076352
> Feb 17 11:00:34 hactar kernel:                 ref#87: shared block backref parent 575936233472
> Feb 17 11:00:34 hactar kernel:                 ref#88: shared block backref parent 564631715840
> Feb 17 11:00:34 hactar kernel:         item 1 key (693626781696 169 0) itemoff 14975 itemsize 483
> Feb 17 11:00:34 hactar kernel:                 extent refs 51 gen 592321 flags 258
> Feb 17 11:00:34 hactar kernel:                 ref#0: shared block backref parent 693646163968
> Feb 17 11:00:34 hactar kernel:                 ref#1: shared block backref parent 693628502016
> Feb 17 11:00:34 hactar kernel:                 ref#2: shared block backref parent 693614460928
> Feb 17 11:00:34 hactar kernel:                 ref#3: shared block backref parent 693527379968
> Feb 17 11:00:34 hactar kernel:                 ref#4: shared block backref parent 693490483200
> Feb 17 11:00:34 hactar kernel:                 ref#5: shared block backref parent 693444968448
> Feb 17 11:00:34 hactar kernel:                 ref#6: shared block backref parent 693442478080
> Feb 17 11:00:34 hactar kernel:                 ref#7: shared block backref parent 693438906368
> Feb 17 11:00:34 hactar kernel:                 ref#8: shared block backref parent 693433057280
> Feb 17 11:00:34 hactar kernel:                 ref#9: shared block backref parent 693408710656
> Feb 17 11:00:34 hactar kernel:                 ref#10: shared block backref parent 693387526144
> Feb 17 11:00:34 hactar kernel:                 ref#11: shared block backref parent 693283717120
> Feb 17 11:00:34 hactar kernel:                 ref#12: shared block backref parent 693241184256
> Feb 17 11:00:34 hactar kernel:                 ref#13: shared block backref parent 693224652800
> Feb 17 11:00:34 hactar kernel:                 ref#14: shared block backref parent 693221130240
> Feb 17 11:00:34 hactar kernel:                 ref#15: shared block backref parent 693214494720
> Feb 17 11:00:34 hactar kernel:                 ref#16: shared block backref parent 693201338368
> Feb 17 11:00:34 hactar kernel:                 ref#17: shared block backref parent 693192916992
> Feb 17 11:00:34 hactar kernel:                 ref#18: shared block backref parent 693186248704
> Feb 17 11:00:34 hactar kernel:                 ref#19: shared block backref parent 693182889984
> Feb 17 11:00:34 hactar kernel:                 ref#20: shared block backref parent 693161934848
> Feb 17 11:00:34 hactar kernel:                 ref#21: shared block backref parent 693155282944
> Feb 17 11:00:34 hactar kernel:                 ref#22: shared block backref parent 693068660736
> Feb 17 11:00:34 hactar kernel:                 ref#23: shared block backref parent 692958543872
> Feb 17 11:00:34 hactar kernel:                 ref#24: shared block backref parent 692930576384
> Feb 17 11:00:34 hactar kernel:                 ref#25: shared block backref parent 692899201024
> Feb 17 11:00:34 hactar kernel:                 ref#26: shared block backref parent 692855209984
> Feb 17 11:00:34 hactar kernel:                 ref#27: shared block backref parent 692851097600
> Feb 17 11:00:34 hactar kernel:                 ref#28: shared block backref parent 692784480256
> Feb 17 11:00:34 hactar kernel:                 ref#29: shared block backref parent 692772601856
> Feb 17 11:00:34 hactar kernel:                 ref#30: shared block backref parent 692772028416
> Feb 17 11:00:34 hactar kernel:                 ref#31: shared block backref parent 692760920064
> Feb 17 11:00:34 hactar kernel:                 ref#32: shared block backref parent 692645494784
> Feb 17 11:00:34 hactar kernel:                 ref#33: shared block backref parent 686923300864
> Feb 17 11:00:34 hactar kernel:                 ref#34: shared block backref parent 686888697856
> Feb 17 11:00:34 hactar kernel:                 ref#35: shared block backref parent 686841610240
> Feb 17 11:00:34 hactar kernel:                 ref#36: shared block backref parent 686772961280
> Feb 17 11:00:34 hactar kernel:                 ref#37: shared block backref parent 686724775936
> Feb 17 11:00:34 hactar kernel:                 ref#38: shared block backref parent 686571094016
> Feb 17 11:00:34 hactar kernel:                 ref#39: shared block backref parent 686484258816
> Feb 17 11:00:34 hactar kernel:                 ref#40: shared block backref parent 686257504256
> Feb 17 11:00:34 hactar kernel:                 ref#41: shared block backref parent 678333218816
> Feb 17 11:00:34 hactar kernel:                 ref#42: shared block backref parent 678081642496
> Feb 17 11:00:34 hactar kernel:                 ref#43: shared block backref parent 677620875264
> Feb 17 11:00:34 hactar kernel:                 ref#44: shared block backref parent 674838822912
> Feb 17 11:00:34 hactar kernel:                 ref#45: shared block backref parent 670300798976
> Feb 17 11:00:34 hactar kernel:                 ref#46: shared block backref parent 656855597056
> Feb 17 11:00:34 hactar kernel:                 ref#47: shared block backref parent 621816430592
> Feb 17 11:00:34 hactar kernel:                 ref#48: shared block backref parent 621725532160
> Feb 17 11:00:34 hactar kernel:                 ref#49: shared block backref parent 595295076352
> Feb 17 11:00:34 hactar kernel:                 ref#50: shared block backref parent 564631715840
> Feb 17 11:00:34 hactar kernel:         item 2 key (693626798080 169 0) itemoff 13988 itemsize 987
> Feb 17 11:00:34 hactar kernel:                 extent refs 607 gen 594253 flags 2
> Feb 17 11:00:34 hactar kernel:                 ref#0: tree block backref root 309
> Feb 17 11:00:34 hactar kernel:                 ref#1: shared block backref parent 702108106752
> Feb 17 11:00:34 hactar kernel:                 ref#2: shared block backref parent 702041145344
> Feb 17 11:00:34 hactar kernel:                 ref#3: shared block backref parent 702000775168
> Feb 17 11:00:34 hactar kernel:                 ref#4: shared block backref parent 701916512256
> Feb 17 11:00:34 hactar kernel:                 ref#5: shared block backref parent 701889314816
> Feb 17 11:00:34 hactar kernel:                 ref#6: shared block backref parent 701882105856
> Feb 17 11:00:34 hactar kernel:                 ref#7: shared block backref parent 701794009088
> Feb 17 11:00:34 hactar kernel:                 ref#8: shared block backref parent 701782097920
> Feb 17 11:00:34 hactar kernel:                 ref#9: shared block backref parent 701646667776
> Feb 17 11:00:34 hactar kernel:                 ref#10: shared block backref parent 701482221568
> Feb 17 11:00:34 hactar kernel:                 ref#11: shared block backref parent 701340647424
> Feb 17 11:00:34 hactar kernel:                 ref#12: shared block backref parent 701271556096
> Feb 17 11:00:34 hactar kernel:                 ref#13: shared block backref parent 701188685824
> Feb 17 11:00:34 hactar kernel:                 ref#14: shared block backref parent 693603893248
> Feb 17 11:00:34 hactar kernel:                 ref#15: shared block backref parent 693591621632
> Feb 17 11:00:34 hactar kernel:                 ref#16: shared block backref parent 693588492288
> Feb 17 11:00:34 hactar kernel:                 ref#17: shared block backref parent 693562408960
> Feb 17 11:00:34 hactar kernel:                 ref#18: shared block backref parent 693543059456
> Feb 17 11:00:34 hactar kernel:                 ref#19: shared block backref parent 693460910080
> Feb 17 11:00:34 hactar kernel:                 ref#20: shared block backref parent 693436776448
> Feb 17 11:00:34 hactar kernel:                 ref#21: shared block backref parent 693417607168
> Feb 17 11:00:34 hactar kernel:                 ref#22: shared block backref parent 693319188480
> Feb 17 11:00:34 hactar kernel:                 ref#23: shared block backref parent 693299658752
> Feb 17 11:00:34 hactar kernel:                 ref#24: shared block backref parent 693290844160
> Feb 17 11:00:34 hactar kernel:                 ref#25: shared block backref parent 693281193984
> Feb 17 11:00:34 hactar kernel:                 ref#26: shared block backref parent 693275869184
> Feb 17 11:00:34 hactar kernel:                 ref#27: shared block backref parent 693262319616
> Feb 17 11:00:34 hactar kernel:                 ref#28: shared block backref parent 693243166720
> Feb 17 11:00:34 hactar kernel:                 ref#29: shared block backref parent 693189640192
> Feb 17 11:00:34 hactar kernel:                 ref#30: shared block backref parent 693185036288
> Feb 17 11:00:34 hactar kernel:                 ref#31: shared block backref parent 693181431808
> Feb 17 11:00:34 hactar kernel:                 ref#32: shared block backref parent 693168619520
> Feb 17 11:00:34 hactar kernel:                 ref#33: shared block backref parent 693168193536
> Feb 17 11:00:34 hactar kernel:                 ref#34: shared block backref parent 693144420352
> Feb 17 11:00:34 hactar kernel:                 ref#35: shared block backref parent 693137817600
> Feb 17 11:00:34 hactar kernel:                 ref#36: shared block backref parent 693137309696
> Feb 17 11:00:34 hactar kernel:                 ref#37: shared block backref parent 693133180928
> Feb 17 11:00:34 hactar kernel:                 ref#38: shared block backref parent 693112897536
> Feb 17 11:00:34 hactar kernel:                 ref#39: shared block backref parent 693047508992
> Feb 17 11:00:34 hactar kernel:                 ref#40: shared block backref parent 693041610752
> Feb 17 11:00:34 hactar kernel:                 ref#41: shared block backref parent 693041184768
> Feb 17 11:00:34 hactar kernel:                 ref#42: shared block backref parent 693014609920
> Feb 17 11:00:34 hactar kernel:                 ref#43: shared block backref parent 692995932160
> Feb 17 11:00:34 hactar kernel:                 ref#44: shared block backref parent 692972257280
> Feb 17 11:00:34 hactar kernel:                 ref#45: shared block backref parent 692960870400
> Feb 17 11:00:34 hactar kernel:                 ref#46: shared block backref parent 692908441600
> Feb 17 11:00:34 hactar kernel:                 ref#47: shared block backref parent 692808138752
> Feb 17 11:00:34 hactar kernel:                 ref#48: shared block backref parent 692787888128
> Feb 17 11:00:34 hactar kernel:                 ref#49: shared block backref parent 692753219584
> Feb 17 11:00:34 hactar kernel:                 ref#50: shared block backref parent 692732084224
> Feb 17 11:00:34 hactar kernel:                 ref#51: shared block backref parent 692729511936
> Feb 17 11:00:34 hactar kernel:                 ref#52: shared block backref parent 692726988800
> Feb 17 11:00:34 hactar kernel:                 ref#53: shared block backref parent 692726415360
> Feb 17 11:00:34 hactar kernel:                 ref#54: shared block backref parent 692725596160
> Feb 17 11:00:34 hactar kernel:                 ref#55: shared block backref parent 692646707200
> Feb 17 11:00:34 hactar kernel:                 ref#56: shared block backref parent 692629569536
> Feb 17 11:00:34 hactar kernel:                 ref#57: shared block backref parent 692613316608
> Feb 17 11:00:34 hactar kernel:                 ref#58: shared block backref parent 692613251072
> Feb 17 11:00:34 hactar kernel:                 ref#59: shared block backref parent 692591984640
> Feb 17 11:00:34 hactar kernel:                 ref#60: shared block backref parent 687173025792
> Feb 17 11:00:34 hactar kernel:                 ref#61: shared block backref parent 687134539776
> Feb 17 11:00:34 hactar kernel:                 ref#62: shared block backref parent 687098183680
> Feb 17 11:00:34 hactar kernel:                 ref#63: shared block backref parent 687019491328
> Feb 17 11:00:34 hactar kernel:                 ref#64: shared block backref parent 686975434752
> Feb 17 11:00:34 hactar kernel:                 ref#65: shared block backref parent 686955823104
> Feb 17 11:00:34 hactar kernel:                 ref#66: shared block backref parent 686742274048
> Feb 17 11:00:34 hactar kernel:                 ref#67: shared block backref parent 686736916480
> Feb 17 11:00:34 hactar kernel:                 ref#68: shared block backref parent 686695038976
> Feb 17 11:00:34 hactar kernel:                 ref#69: shared block backref parent 686570192896
> Feb 17 11:00:34 hactar kernel:                 ref#70: shared block backref parent 686503591936
> Feb 17 11:00:34 hactar kernel:                 ref#71: shared block backref parent 686486536192
> Feb 17 11:00:34 hactar kernel:                 ref#72: shared block backref parent 686463860736
> Feb 17 11:00:34 hactar kernel:                 ref#73: shared block backref parent 686451146752
> Feb 17 11:00:34 hactar kernel:                 ref#74: shared block backref parent 686449459200
> Feb 17 11:00:34 hactar kernel:                 ref#75: shared block backref parent 686445854720
> Feb 17 11:00:34 hactar kernel:                 ref#76: shared block backref parent 686343979008
> Feb 17 11:00:34 hactar kernel:                 ref#77: shared block backref parent 686343880704
> Feb 17 11:00:34 hactar kernel:                 ref#78: shared block backref parent 686317436928
> Feb 17 11:00:34 hactar kernel:                 ref#79: shared block backref parent 686314455040
> Feb 17 11:00:34 hactar kernel:                 ref#80: shared block backref parent 686211334144
> Feb 17 11:00:34 hactar kernel:                 ref#81: shared block backref parent 686179205120
> Feb 17 11:00:34 hactar kernel:                 ref#82: shared block backref parent 686164770816
> Feb 17 11:00:34 hactar kernel:                 ref#83: shared block backref parent 686150500352
> Feb 17 11:00:34 hactar kernel:                 ref#84: shared block backref parent 678499205120
> Feb 17 11:00:34 hactar kernel:                 ref#85: shared block backref parent 678492995584
> Feb 17 11:00:34 hactar kernel:                 ref#86: shared block backref parent 678349537280
> Feb 17 11:00:34 hactar kernel:                 ref#87: shared block backref parent 678258835456
> Feb 17 11:00:34 hactar kernel:                 ref#88: shared block backref parent 678194495488
> Feb 17 11:00:34 hactar kernel:                 ref#89: shared block backref parent 678167822336
> Feb 17 11:00:34 hactar kernel:                 ref#90: shared block backref parent 678147489792
> Feb 17 11:00:34 hactar kernel:                 ref#91: shared block backref parent 677907496960
> Feb 17 11:00:34 hactar kernel:                 ref#92: shared block backref parent 677688328192
> Feb 17 11:00:34 hactar kernel:                 ref#93: shared block backref parent 675389063168
> Feb 17 11:00:34 hactar kernel:                 ref#94: shared block backref parent 675308601344
> Feb 17 11:00:34 hactar kernel:                 ref#95: shared block backref parent 674464284672
> Feb 17 11:00:34 hactar kernel:                 ref#96: shared block backref parent 670436605952
> Feb 17 11:00:34 hactar kernel:                 ref#97: shared block backref parent 670381752320
> Feb 17 11:00:34 hactar kernel:                 ref#98: shared block backref parent 665171820544
> Feb 17 11:00:34 hactar kernel:                 ref#99: shared block backref parent 665169264640
> Feb 17 11:00:34 hactar kernel:                 ref#100: shared block backref parent 664973983744
> Feb 17 11:00:34 hactar kernel:                 ref#101: shared block backref parent 661157888000
> Feb 17 11:00:34 hactar kernel:                 ref#102: shared block backref parent 656306814976
> Feb 17 11:00:34 hactar kernel:                 ref#103: shared block backref parent 655110930432
> Feb 17 11:00:34 hactar kernel:                 ref#104: shared block backref parent 621981433856
> Feb 17 11:00:34 hactar kernel:                 ref#105: shared block backref parent 596014923776
> Feb 17 11:00:34 hactar kernel:                 ref#106: shared block backref parent 576450396160
> Feb 17 11:00:34 hactar kernel:         item 3 key (693626798080 182 575636258816) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 4 key (693626798080 182 582375309312) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 5 key (693626798080 182 596386414592) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 6 key (693626798080 182 622080770048) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 7 key (693626798080 182 622095450112) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 8 key (693626798080 182 622344650752) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 9 key (693626798080 182 622468972544) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 10 key (693626798080 182 641633320960) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 11 key (693626798080 182 655042756608) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 12 key (693626798080 182 655588753408) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 13 key (693626798080 182 656225206272) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 14 key (693626798080 182 656584491008) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 15 key (693626798080 182 660995719168) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 16 key (693626798080 182 664798298112) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 17 key (693626798080 182 664924045312) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 18 key (693626798080 182 664970412032) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 19 key (693626798080 182 665627983872) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 20 key (693626798080 182 670379737088) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 21 key (693626798080 182 670393073664) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 22 key (693626798080 182 670446665728) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 23 key (693626798080 182 670809047040) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 24 key (693626798080 182 671064178688) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 25 key (693626798080 182 674366324736) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 26 key (693626798080 182 674376253440) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 27 key (693626798080 182 674430812160) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 28 key (693626798080 182 674868150272) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 29 key (693626798080 182 675007086592) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 30 key (693626798080 182 675014262784) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 31 key (693626798080 182 675110895616) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 32 key (693626798080 182 675177332736) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 33 key (693626798080 182 677569216512) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 34 key (693626798080 182 677613715456) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 35 key (693626798080 182 677628493824) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 36 key (693626798080 182 677707546624) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 37 key (693626798080 182 677714477056) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 38 key (693626798080 182 677765513216) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 39 key (693626798080 182 677897224192) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 40 key (693626798080 182 677943115776) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 41 key (693626798080 182 677950570496) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 42 key (693626798080 182 677971869696) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 43 key (693626798080 182 678092718080) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 44 key (693626798080 182 678107758592) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 45 key (693626798080 182 678179880960) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 46 key (693626798080 182 678257065984) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 47 key (693626798080 182 678302597120) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 48 key (693626798080 182 678303973376) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 49 key (693626798080 182 678349242368) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 50 key (693626798080 182 678418710528) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 51 key (693626798080 182 678473613312) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 52 key (693626798080 182 678498369536) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 53 key (693626798080 182 678512656384) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 54 key (693626798080 182 678518669312) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 55 key (693626798080 182 678522290176) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 56 key (693626798080 182 678544687104) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 57 key (693626798080 182 678552059904) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 58 key (693626798080 182 678579716096) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 59 key (693626798080 182 686151434240) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 60 key (693626798080 182 686182285312) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 61 key (693626798080 182 686192148480) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 62 key (693626798080 182 686204059648) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 63 key (693626798080 182 686246887424) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 64 key (693626798080 182 686275461120) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 65 key (693626798080 182 686315077632) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 66 key (693626798080 182 686320812032) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 67 key (693626798080 182 686329495552) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 68 key (693626798080 182 686384955392) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 69 key (693626798080 182 686406811648) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 70 key (693626798080 182 686408220672) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 71 key (693626798080 182 686411808768) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 72 key (693626798080 182 686412103680) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 73 key (693626798080 182 686444363776) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 74 key (693626798080 182 686450655232) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 75 key (693626798080 182 686538997760) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 76 key (693626798080 182 686555021312) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 77 key (693626798080 182 686620655616) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 78 key (693626798080 182 686667661312) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 79 key (693626798080 182 686671970304) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 80 key (693626798080 182 686678704128) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 81 key (693626798080 182 686703149056) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 82 key (693626798080 182 686745108480) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 83 key (693626798080 182 686818836480) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 84 key (693626798080 182 686906097664) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 85 key (693626798080 182 686908866560) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 86 key (693626798080 182 686913421312) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 87 key (693626798080 182 686927413248) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 88 key (693626798080 182 686969372672) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 89 key (693626798080 182 686987526144) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 90 key (693626798080 182 687034368000) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 91 key (693626798080 182 687036907520) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 92 key (693626798080 182 687047393280) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 93 key (693626798080 182 687051309056) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 94 key (693626798080 182 687052455936) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 95 key (693626798080 182 687101083648) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 96 key (693626798080 182 687104180224) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 97 key (693626798080 182 687113666560) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 98 key (693626798080 182 687124185088) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 99 key (693626798080 182 687136669696) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 100 key (693626798080 182 687211986944) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 101 key (693626798080 182 692595015680) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 102 key (693626798080 182 692602437632) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 103 key (693626798080 182 692616380416) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 104 key (693626798080 182 692642201600) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 105 key (693626798080 182 692678541312) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 106 key (693626798080 182 692679622656) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 107 key (693626798080 182 692693221376) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 108 key (693626798080 182 692700151808) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 109 key (693626798080 182 692729757696) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 110 key (693626798080 182 692741062656) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 111 key (693626798080 182 692741996544) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 112 key (693626798080 182 692744404992) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 113 key (693626798080 182 692752580608) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 114 key (693626798080 182 692756398080) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 115 key (693626798080 182 692765081600) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 116 key (693626798080 182 692775256064) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 117 key (693626798080 182 692810235904) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 118 key (693626798080 182 692844167168) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 119 key (693626798080 182 692861665280) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 120 key (693626798080 182 692872052736) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 121 key (693626798080 182 692927971328) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 122 key (693626798080 182 692964179968) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 123 key (693626798080 182 692976664576) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 124 key (693626798080 182 692980989952) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 125 key (693626798080 182 692995391488) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 126 key (693626798080 182 693002485760) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 127 key (693626798080 182 693007777792) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 128 key (693626798080 182 693007876096) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 129 key (693626798080 182 693066104832) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 130 key (693626798080 182 693073805312) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 131 key (693626798080 182 693120647168) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 132 key (693626798080 182 693129543680) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 133 key (693626798080 182 693132148736) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 134 key (693626798080 182 693136670720) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 135 key (693626798080 182 693145288704) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 136 key (693626798080 182 693145501696) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 137 key (693626798080 182 693147418624) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 138 key (693626798080 182 693165441024) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 139 key (693626798080 182 693171781632) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 140 key (693626798080 182 693184020480) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 141 key (693626798080 182 693289779200) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 142 key (693626798080 182 693290369024) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 143 key (693626798080 182 693311504384) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 144 key (693626798080 182 693321302016) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 145 key (693626798080 182 693403254784) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 146 key (693626798080 182 693403779072) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 147 key (693626798080 182 693420343296) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 148 key (693626798080 182 693424472064) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 149 key (693626798080 182 693436530688) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 150 key (693626798080 182 693535490048) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 151 key (693626798080 182 701188177920) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 152 key (693626798080 182 701195632640) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 153 key (693626798080 182 701196795904) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 154 key (693626798080 182 701200400384) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 155 key (693626798080 182 701203857408) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 156 key (693626798080 182 701204348928) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 157 key (693626798080 182 701207822336) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 158 key (693626798080 182 701209296896) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 159 key (693626798080 182 701210656768) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 160 key (693626798080 182 701217472512) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 161 key (693626798080 182 701223927808) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 162 key (693626798080 182 701230383104) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 163 key (693626798080 182 701231759360) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 164 key (693626798080 182 701242605568) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 165 key (693626798080 182 701244260352) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 166 key (693626798080 182 701247717376) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 167 key (693626798080 182 701248241664) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 168 key (693626798080 182 701248356352) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 169 key (693626798080 182 701250863104) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 170 key (693626798080 182 701252501504) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 171 key (693626798080 182 701253173248) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 172 key (693626798080 182 701271113728) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 173 key (693626798080 182 701275635712) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 174 key (693626798080 182 701276815360) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 175 key (693626798080 182 701280665600) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 176 key (693626798080 182 701285220352) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 177 key (693626798080 182 701296902144) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 178 key (693626798080 182 701300850688) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 179 key (693626798080 182 701301555200) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 180 key (693626798080 182 701307092992) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 181 key (693626798080 182 701321969664) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 182 key (693626798080 182 701324673024) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 183 key (693626798080 182 701325524992) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 184 key (693626798080 182 701326442496) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 185 key (693626798080 182 701327114240) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 186 key (693626798080 182 701328474112) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 187 key (693626798080 182 701334044672) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 188 key (693626798080 182 701334913024) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 189 key (693626798080 182 701337845760) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 190 key (693626798080 182 701337927680) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 191 key (693626798080 182 701340041216) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 192 key (693626798080 182 701341384704) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 193 key (693626798080 182 701356359680) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 194 key (693626798080 182 701366583296) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 195 key (693626798080 182 701369286656) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 196 key (693626798080 182 701372514304) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 197 key (693626798080 182 701375889408) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 198 key (693626798080 182 701378052096) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 199 key (693626798080 182 701380984832) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 200 key (693626798080 182 701381591040) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 201 key (693626798080 182 701392371712) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 202 key (693626798080 182 701406478336) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 203 key (693626798080 182 701409558528) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 204 key (693626798080 182 701449519104) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 205 key (693626798080 182 701453664256) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 206 key (693626798080 182 701458743296) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 207 key (693626798080 182 701465247744) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 208 key (693626798080 182 701465264128) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 209 key (693626798080 182 701465821184) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 210 key (693626798080 182 701467901952) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 211 key (693626798080 182 701468327936) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 212 key (693626798080 182 701469573120) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 213 key (693626798080 182 701473931264) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 214 key (693626798080 182 701479108608) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 215 key (693626798080 182 701482024960) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 216 key (693626798080 182 701484630016) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 217 key (693626798080 182 701485449216) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 218 key (693626798080 182 701486252032) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 219 key (693626798080 182 701489872896) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 220 key (693626798080 182 701494034432) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 221 key (693626798080 182 701494968320) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 222 key (693626798080 182 701504012288) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 223 key (693626798080 182 701505912832) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 224 key (693626798080 182 701509828608) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 225 key (693626798080 182 701510008832) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 226 key (693626798080 182 701521330176) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 227 key (693626798080 182 701533814784) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 228 key (693626798080 182 701548576768) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 229 key (693626798080 182 701549756416) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 230 key (693626798080 182 701550444544) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 231 key (693626798080 182 701552246784) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 232 key (693626798080 182 701571104768) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 233 key (693626798080 182 701578166272) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 234 key (693626798080 182 701579444224) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 235 key (693626798080 182 701588078592) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 236 key (693626798080 182 701590126592) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 237 key (693626798080 182 701598613504) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 238 key (693626798080 182 701599449088) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 239 key (693626798080 182 701600563200) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 240 key (693626798080 182 701603610624) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 241 key (693626798080 182 701639983104) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 242 key (693626798080 182 701645635584) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 243 key (693626798080 182 701652828160) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 244 key (693626798080 182 701660446720) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 245 key (693626798080 182 701664198656) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 246 key (693626798080 182 701681074176) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 247 key (693626798080 182 701682909184) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 248 key (693626798080 182 701683449856) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 249 key (693626798080 182 701684989952) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 250 key (693626798080 182 701689249792) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 251 key (693626798080 182 701696049152) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 252 key (693626798080 182 701718036480) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 253 key (693626798080 182 701719838720) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 254 key (693626798080 182 701725016064) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 255 key (693626798080 182 701726228480) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 256 key (693626798080 182 701728636928) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 257 key (693626798080 182 701732323328) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 258 key (693626798080 182 701732601856) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 259 key (693626798080 182 701739057152) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 260 key (693626798080 182 701739827200) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 261 key (693626798080 182 701745872896) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 262 key (693626798080 182 701757669376) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 263 key (693626798080 182 701760421888) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 264 key (693626798080 182 701774839808) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 265 key (693626798080 182 701777018880) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 266 key (693626798080 182 701782851584) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 267 key (693626798080 182 701803151360) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 268 key (693626798080 182 701806919680) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 269 key (693626798080 182 701808902144) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 270 key (693626798080 182 701819109376) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 271 key (693626798080 182 701829562368) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 272 key (693626798080 182 701850419200) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 273 key (693626798080 182 701854973952) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 274 key (693626798080 182 702129324032) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 275 key (693626798080 182 701861986304) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 276 key (693626798080 182 701872832512) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 277 key (693626798080 182 701872881664) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 278 key (693626798080 182 701872963584) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 279 key (693626798080 182 701876682752) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 280 key (693626798080 182 701878484992) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 281 key (693626798080 182 701879173120) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 282 key (693626798080 182 701880090624) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 283 key (693626798080 182 701887873024) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 284 key (693626798080 182 701888135168) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 285 key (693626798080 182 701898260480) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 286 key (693626798080 182 701913808896) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 287 key (693626798080 182 701914038272) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 288 key (693626798080 182 701914775552) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 289 key (693626798080 182 701923164160) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 290 key (693626798080 182 701932634112) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 291 key (693626798080 182 701935337472) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 292 key (693626798080 182 701937909760) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 293 key (693626798080 182 701938417664) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 294 key (693626798080 182 701941661696) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 295 key (693626798080 182 701948067840) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 296 key (693626798080 182 701950623744) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 297 key (693626798080 182 701954211840) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 298 key (693626798080 182 701957292032) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 299 key (693626798080 182 701963796480) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 300 key (693626798080 182 701973233664) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 301 key (693626798080 182 701974495232) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 302 key (693626798080 182 701987536896) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 303 key (693626798080 182 701989224448) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 304 key (693626798080 182 701990092800) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 305 key (693626798080 182 701992796160) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 306 key (693626798080 182 701995925504) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 307 key (693626798080 182 701997793280) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 308 key (693626798080 182 702000480256) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 309 key (693626798080 182 702013784064) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 310 key (693626798080 182 702018863104) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 311 key (693626798080 182 702025187328) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 312 key (693626798080 182 702025613312) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 313 key (693626798080 182 702029332480) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 314 key (693626798080 182 702038622208) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 315 key (693626798080 182 702041112576) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 316 key (693626798080 182 702041899008) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 317 key (693626798080 182 702043111424) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 318 key (693626798080 182 702052843520) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 319 key (693626798080 182 702056235008) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 320 key (693626798080 182 702082596864) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 321 key (693626798080 182 702093475840) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 322 key (693626798080 182 702135222272) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 323 key (693626798080 182 702138810368) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 324 key (693626798080 182 702139351040) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 325 key (693626798080 182 702142840832) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 326 key (693626798080 182 702144610304) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 327 key (693626798080 182 702144757760) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 328 key (693626798080 182 702146396160) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 329 key (693626798080 182 702150557696) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 330 key (693626798080 182 702151671808) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 331 key (693626798080 182 702153342976) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 332 key (693626798080 182 702153490432) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 333 key (693626798080 182 702157602816) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 334 key (693626798080 182 702157963264) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 335 key (693626798080 182 702159208448) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 336 key (693626798080 182 702169972736) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 337 key (693626798080 182 702177853440) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 338 key (693626798080 182 702200610816) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 339 key (693626798080 182 702202658816) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 340 key (693626798080 182 702209392640) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 341 key (693626798080 182 702223826944) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 342 key (693626798080 182 702236819456) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 343 key (693626798080 182 702239391744) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 344 key (693626798080 182 702242635776) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 345 key (693626798080 182 705479196672) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 346 key (693626798080 182 705488175104) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 347 key (693626798080 182 705503215616) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 348 key (693626798080 182 705507852288) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 349 key (693626798080 182 705526366208) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 350 key (693626798080 182 705529020416) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 351 key (693626798080 182 705540030464) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 352 key (693626798080 182 705547386880) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 353 key (693626798080 182 705573486592) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 354 key (693626798080 182 705580007424) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 355 key (693626798080 182 705608351744) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 356 key (693626798080 182 705609498624) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 357 key (693626798080 182 705621016576) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 358 key (693626798080 182 705625915392) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 359 key (693626798080 182 705631911936) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 360 key (693626798080 182 705632698368) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 361 key (693626798080 182 705634402304) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 362 key (693626798080 182 705635270656) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 363 key (693626798080 182 705637777408) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 364 key (693626798080 182 705646936064) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 365 key (693626798080 182 705652293632) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 366 key (693626798080 182 705654325248) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 367 key (693626798080 182 705654521856) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 368 key (693626798080 182 705664073728) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 369 key (693626798080 182 705664172032) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 370 key (693626798080 182 705664876544) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 371 key (693626798080 182 705665433600) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 372 key (693626798080 182 705668907008) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 373 key (693626798080 182 705676771328) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 374 key (693626798080 182 705696825344) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 375 key (693626798080 182 705708638208) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 376 key (693626798080 182 705746714624) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 377 key (693626798080 182 705748418560) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 378 key (693626798080 182 705752596480) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 379 key (693626798080 182 705758658560) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 380 key (693626798080 182 705764704256) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 381 key (693626798080 182 705774223360) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 382 key (693626798080 182 705784266752) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 383 key (693626798080 182 705785823232) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 384 key (693626798080 182 705799176192) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 385 key (693626798080 182 705804763136) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 386 key (693626798080 182 705806663680) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 387 key (693626798080 182 705810808832) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 388 key (693626798080 182 705817509888) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 389 key (693626798080 182 705820901376) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 390 key (693626798080 182 705835499520) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 391 key (693626798080 182 705851473920) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 392 key (693626798080 182 705890615296) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 393 key (693626798080 182 705897807872) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 394 key (693626798080 182 705901559808) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 395 key (693626798080 182 705911783424) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 396 key (693626798080 182 705922039808) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 397 key (693626798080 182 705930756096) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 398 key (693626798080 182 705934557184) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 399 key (693626798080 182 705937440768) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 400 key (693626798080 182 705939308544) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 401 key (693626798080 182 705946992640) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 402 key (693626798080 182 705948368896) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 403 key (693626798080 182 705949319168) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 404 key (693626798080 182 706002501632) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 405 key (693626798080 182 706014117888) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 406 key (693626798080 182 706016968704) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 407 key (693626798080 182 706018213888) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 408 key (693626798080 182 706020900864) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 409 key (693626798080 182 706027175936) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 410 key (693626798080 182 706028257280) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 411 key (693626798080 182 706033696768) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 412 key (693626798080 182 706035204096) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 413 key (693626798080 182 706036383744) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 414 key (693626798080 182 706042691584) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 415 key (693626798080 182 706047082496) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 416 key (693626798080 182 706049818624) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 417 key (693626798080 182 706052571136) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 418 key (693626798080 182 706053079040) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 419 key (693626798080 182 706053816320) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 420 key (693626798080 182 706055569408) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 421 key (693626798080 182 706059698176) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 422 key (693626798080 182 706065825792) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 423 key (693626798080 182 706077884416) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 424 key (693626798080 182 706090123264) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 425 key (693626798080 182 706092285952) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 426 key (693626798080 182 706103836672) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 427 key (693626798080 182 706125152256) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 428 key (693626798080 182 706156314624) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 429 key (693626798080 182 706177531904) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 430 key (693626798080 182 706185396224) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 431 key (693626798080 182 706186051584) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 432 key (693626798080 182 706188525568) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 433 key (693626798080 182 706189295616) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 434 key (693626798080 182 706199355392) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 435 key (693626798080 182 706201845760) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 436 key (693626798080 182 706202140672) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 437 key (693626798080 182 706217803776) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 438 key (693626798080 182 706226651136) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 439 key (693626798080 182 706233368576) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 440 key (693626798080 182 706240856064) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 441 key (693626798080 182 706245083136) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 442 key (693626798080 182 706264793088) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 443 key (693626798080 182 706284584960) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 444 key (693626798080 182 706295922688) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 445 key (693626798080 182 706298609664) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 446 key (693626798080 182 706307538944) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 447 key (693626798080 182 706312241152) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 448 key (693626798080 182 706322563072) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 449 key (693626798080 182 706328117248) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 450 key (693626798080 182 706336260096) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 451 key (693626798080 182 706340700160) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 452 key (693626798080 182 706354249728) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 453 key (693626798080 182 706372517888) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 454 key (693626798080 182 706395045888) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 455 key (693626798080 182 706412593152) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 456 key (693626798080 182 706414460928) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 457 key (693626798080 182 706423095296) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 458 key (693626798080 182 706439233536) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 459 key (693626798080 182 706439577600) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 460 key (693626798080 182 706447261696) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 461 key (693626798080 182 706448850944) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 462 key (693626798080 182 706453536768) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 463 key (693626798080 182 706454306816) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 464 key (693626798080 182 706466529280) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 465 key (693626798080 182 706469462016) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 466 key (693626798080 182 706491760640) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 467 key (693626798080 182 706494201856) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 468 key (693626798080 182 706498101248) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 469 key (693626798080 182 706506588160) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 470 key (693626798080 182 706512257024) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 471 key (693626798080 182 706513649664) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 472 key (693626798080 182 706531295232) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 473 key (693626798080 182 706536275968) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 474 key (693626798080 182 710851313664) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 475 key (693626798080 182 710856081408) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 476 key (693626798080 182 710947045376) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 477 key (693626798080 182 710952468480) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 478 key (693626798080 182 711051231232) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 479 key (693626798080 182 711055278080) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 480 key (693626798080 182 711072186368) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 481 key (693626798080 182 711099858944) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 482 key (693626798080 182 711102906368) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 483 key (693626798080 182 711149568000) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 484 key (693626798080 182 711153958912) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 485 key (693626798080 182 711193214976) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 486 key (693626798080 182 711201554432) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 487 key (693626798080 182 711220150272) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 488 key (693626798080 182 711345389568) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 489 key (693626798080 182 711349321728) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 490 key (693626798080 182 711379419136) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 491 key (693626798080 182 711424098304) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 492 key (693626798080 182 711447429120) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 493 key (693626798080 182 711523647488) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 494 key (693626798080 182 711552565248) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 495 key (693626798080 182 711564525568) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 496 key (693626798080 182 711645528064) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 497 key (693626798080 182 711677132800) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 498 key (693626798080 182 711682785280) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 499 key (693626798080 182 711687077888) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 500 key (693626798080 182 711809925120) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 501 key (693626798080 182 711849295872) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 502 key (693626798080 182 711861223424) itemoff 13988 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 503 key (693626814464 169 0) itemoff 13001 itemsize 987
> Feb 17 11:00:34 hactar kernel:                 extent refs 607 gen 594253 flags 2
> Feb 17 11:00:34 hactar kernel:                 ref#0: tree block backref root 309
> Feb 17 11:00:34 hactar kernel:                 ref#1: shared block backref parent 702108106752
> Feb 17 11:00:34 hactar kernel:                 ref#2: shared block backref parent 702041145344
> Feb 17 11:00:34 hactar kernel:                 ref#3: shared block backref parent 702000775168
> Feb 17 11:00:34 hactar kernel:                 ref#4: shared block backref parent 701916512256
> Feb 17 11:00:34 hactar kernel:                 ref#5: shared block backref parent 701889314816
> Feb 17 11:00:34 hactar kernel:                 ref#6: shared block backref parent 701882105856
> Feb 17 11:00:34 hactar kernel:                 ref#7: shared block backref parent 701794009088
> Feb 17 11:00:34 hactar kernel:                 ref#8: shared block backref parent 701782097920
> Feb 17 11:00:34 hactar kernel:                 ref#9: shared block backref parent 701646667776
> Feb 17 11:00:34 hactar kernel:                 ref#10: shared block backref parent 701482221568
> Feb 17 11:00:34 hactar kernel:                 ref#11: shared block backref parent 701340647424
> Feb 17 11:00:34 hactar kernel:                 ref#12: shared block backref parent 701271556096
> Feb 17 11:00:34 hactar kernel:                 ref#13: shared block backref parent 701188685824
> Feb 17 11:00:34 hactar kernel:                 ref#14: shared block backref parent 693603893248
> Feb 17 11:00:34 hactar kernel:                 ref#15: shared block backref parent 693591621632
> Feb 17 11:00:34 hactar kernel:                 ref#16: shared block backref parent 693588492288
> Feb 17 11:00:34 hactar kernel:                 ref#17: shared block backref parent 693562408960
> Feb 17 11:00:34 hactar kernel:                 ref#18: shared block backref parent 693543059456
> Feb 17 11:00:34 hactar kernel:                 ref#19: shared block backref parent 693460910080
> Feb 17 11:00:34 hactar kernel:                 ref#20: shared block backref parent 693436776448
> Feb 17 11:00:34 hactar kernel:                 ref#21: shared block backref parent 693417607168
> Feb 17 11:00:34 hactar kernel:                 ref#22: shared block backref parent 693319188480
> Feb 17 11:00:34 hactar kernel:                 ref#23: shared block backref parent 693299658752
> Feb 17 11:00:34 hactar kernel:                 ref#24: shared block backref parent 693290844160
> Feb 17 11:00:34 hactar kernel:                 ref#25: shared block backref parent 693281193984
> Feb 17 11:00:34 hactar kernel:                 ref#26: shared block backref parent 693275869184
> Feb 17 11:00:34 hactar kernel:                 ref#27: shared block backref parent 693262319616
> Feb 17 11:00:34 hactar kernel:                 ref#28: shared block backref parent 693243166720
> Feb 17 11:00:34 hactar kernel:                 ref#29: shared block backref parent 693189640192
> Feb 17 11:00:34 hactar kernel:                 ref#30: shared block backref parent 693185036288
> Feb 17 11:00:34 hactar kernel:                 ref#31: shared block backref parent 693181431808
> Feb 17 11:00:34 hactar kernel:                 ref#32: shared block backref parent 693168619520
> Feb 17 11:00:34 hactar kernel:                 ref#33: shared block backref parent 693168193536
> Feb 17 11:00:34 hactar kernel:                 ref#34: shared block backref parent 693144420352
> Feb 17 11:00:34 hactar kernel:                 ref#35: shared block backref parent 693137817600
> Feb 17 11:00:34 hactar kernel:                 ref#36: shared block backref parent 693137309696
> Feb 17 11:00:34 hactar kernel:                 ref#37: shared block backref parent 693133180928
> Feb 17 11:00:34 hactar kernel:                 ref#38: shared block backref parent 693112897536
> Feb 17 11:00:34 hactar kernel:                 ref#39: shared block backref parent 693047508992
> Feb 17 11:00:34 hactar kernel:                 ref#40: shared block backref parent 693041610752
> Feb 17 11:00:34 hactar kernel:                 ref#41: shared block backref parent 693041184768
> Feb 17 11:00:34 hactar kernel:                 ref#42: shared block backref parent 693014609920
> Feb 17 11:00:34 hactar kernel:                 ref#43: shared block backref parent 692995932160
> Feb 17 11:00:34 hactar kernel:                 ref#44: shared block backref parent 692972257280
> Feb 17 11:00:34 hactar kernel:                 ref#45: shared block backref parent 692960870400
> Feb 17 11:00:34 hactar kernel:                 ref#46: shared block backref parent 692908441600
> Feb 17 11:00:34 hactar kernel:                 ref#47: shared block backref parent 692808138752
> Feb 17 11:00:34 hactar kernel:                 ref#48: shared block backref parent 692787888128
> Feb 17 11:00:34 hactar kernel:                 ref#49: shared block backref parent 692753219584
> Feb 17 11:00:34 hactar kernel:                 ref#50: shared block backref parent 692732084224
> Feb 17 11:00:34 hactar kernel:                 ref#51: shared block backref parent 692729511936
> Feb 17 11:00:34 hactar kernel:                 ref#52: shared block backref parent 692726988800
> Feb 17 11:00:34 hactar kernel:                 ref#53: shared block backref parent 692726415360
> Feb 17 11:00:34 hactar kernel:                 ref#54: shared block backref parent 692725596160
> Feb 17 11:00:34 hactar kernel:                 ref#55: shared block backref parent 692646707200
> Feb 17 11:00:34 hactar kernel:                 ref#56: shared block backref parent 692629569536
> Feb 17 11:00:34 hactar kernel:                 ref#57: shared block backref parent 692613316608
> Feb 17 11:00:34 hactar kernel:                 ref#58: shared block backref parent 692613251072
> Feb 17 11:00:34 hactar kernel:                 ref#59: shared block backref parent 692591984640
> Feb 17 11:00:34 hactar kernel:                 ref#60: shared block backref parent 687173025792
> Feb 17 11:00:34 hactar kernel:                 ref#61: shared block backref parent 687134539776
> Feb 17 11:00:34 hactar kernel:                 ref#62: shared block backref parent 687098183680
> Feb 17 11:00:34 hactar kernel:                 ref#63: shared block backref parent 687019491328
> Feb 17 11:00:34 hactar kernel:                 ref#64: shared block backref parent 686975434752
> Feb 17 11:00:34 hactar kernel:                 ref#65: shared block backref parent 686955823104
> Feb 17 11:00:34 hactar kernel:                 ref#66: shared block backref parent 686742274048
> Feb 17 11:00:34 hactar kernel:                 ref#67: shared block backref parent 686736916480
> Feb 17 11:00:34 hactar kernel:                 ref#68: shared block backref parent 686695038976
> Feb 17 11:00:34 hactar kernel:                 ref#69: shared block backref parent 686570192896
> Feb 17 11:00:34 hactar kernel:                 ref#70: shared block backref parent 686503591936
> Feb 17 11:00:34 hactar kernel:                 ref#71: shared block backref parent 686486536192
> Feb 17 11:00:34 hactar kernel:                 ref#72: shared block backref parent 686463860736
> Feb 17 11:00:34 hactar kernel:                 ref#73: shared block backref parent 686451146752
> Feb 17 11:00:34 hactar kernel:                 ref#74: shared block backref parent 686449459200
> Feb 17 11:00:34 hactar kernel:                 ref#75: shared block backref parent 686445854720
> Feb 17 11:00:34 hactar kernel:                 ref#76: shared block backref parent 686343979008
> Feb 17 11:00:34 hactar kernel:                 ref#77: shared block backref parent 686343880704
> Feb 17 11:00:34 hactar kernel:                 ref#78: shared block backref parent 686317436928
> Feb 17 11:00:34 hactar kernel:                 ref#79: shared block backref parent 686314455040
> Feb 17 11:00:34 hactar kernel:                 ref#80: shared block backref parent 686211334144
> Feb 17 11:00:34 hactar kernel:                 ref#81: shared block backref parent 686179205120
> Feb 17 11:00:34 hactar kernel:                 ref#82: shared block backref parent 686164770816
> Feb 17 11:00:34 hactar kernel:                 ref#83: shared block backref parent 686150500352
> Feb 17 11:00:34 hactar kernel:                 ref#84: shared block backref parent 678499205120
> Feb 17 11:00:34 hactar kernel:                 ref#85: shared block backref parent 678492995584
> Feb 17 11:00:34 hactar kernel:                 ref#86: shared block backref parent 678349537280
> Feb 17 11:00:34 hactar kernel:                 ref#87: shared block backref parent 678258835456
> Feb 17 11:00:34 hactar kernel:                 ref#88: shared block backref parent 678194495488
> Feb 17 11:00:34 hactar kernel:                 ref#89: shared block backref parent 678167822336
> Feb 17 11:00:34 hactar kernel:                 ref#90: shared block backref parent 678147489792
> Feb 17 11:00:34 hactar kernel:                 ref#91: shared block backref parent 677907496960
> Feb 17 11:00:34 hactar kernel:                 ref#92: shared block backref parent 677688328192
> Feb 17 11:00:34 hactar kernel:                 ref#93: shared block backref parent 675389063168
> Feb 17 11:00:34 hactar kernel:                 ref#94: shared block backref parent 675308601344
> Feb 17 11:00:34 hactar kernel:                 ref#95: shared block backref parent 674464284672
> Feb 17 11:00:34 hactar kernel:                 ref#96: shared block backref parent 670436605952
> Feb 17 11:00:34 hactar kernel:                 ref#97: shared block backref parent 670381752320
> Feb 17 11:00:34 hactar kernel:                 ref#98: shared block backref parent 665171820544
> Feb 17 11:00:34 hactar kernel:                 ref#99: shared block backref parent 665169264640
> Feb 17 11:00:34 hactar kernel:                 ref#100: shared block backref parent 664973983744
> Feb 17 11:00:34 hactar kernel:                 ref#101: shared block backref parent 661157888000
> Feb 17 11:00:34 hactar kernel:                 ref#102: shared block backref parent 656306814976
> Feb 17 11:00:34 hactar kernel:                 ref#103: shared block backref parent 655110930432
> Feb 17 11:00:34 hactar kernel:                 ref#104: shared block backref parent 621981433856
> Feb 17 11:00:34 hactar kernel:                 ref#105: shared block backref parent 596014923776
> Feb 17 11:00:34 hactar kernel:                 ref#106: shared block backref parent 576450396160
> Feb 17 11:00:34 hactar kernel:         item 504 key (693626814464 182 575636258816) itemoff 13001 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 505 key (693626814464 182 582375309312) itemoff 13001 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 506 key (693626814464 182 596386414592) itemoff 13001 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 507 key (693626814464 182 622080770048) itemoff 13001 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel:         item 508 key (693626814464 182 622095450112) itemoff 13001 itemsize 0
> Feb 17 11:00:34 hactar kernel:                 shared block backref
> Feb 17 11:00:34 hactar kernel: BTRFS error (device dm-0): block=711870922752 write time tree block corruption detected
> Feb 17 11:00:34 hactar kernel: BTRFS: error (device dm-0) in btrfs_commit_transaction:2376: errno=-5 IO failure (Error while writing out transaction)
> Feb 17 11:00:34 hactar kernel: BTRFS info (device dm-0): forced readonly
> Feb 17 11:00:34 hactar kernel: BTRFS warning (device dm-0): Skipping commit of aborted transaction.
> Feb 17 11:00:34 hactar kernel: BTRFS: error (device dm-0) in cleanup_transaction:1941: errno=-5 IO failure
> Feb 17 12:27:12 hactar kernel: Bluetooth: hci0: SCO packet for unknown connection handle 257
> Feb 17 12:27:12 hactar kernel: Bluetooth: hci0: SCO packet for unknown connection handle 257
> Feb 17 12:27:12 hactar kernel: Bluetooth: hci0: SCO packet for unknown connection handle 257
> Feb 17 12:27:12 hactar kernel: usb 5-1.1: reset high-speed USB device number 3 using xhci_hcd
> Feb 17 12:27:13 hactar kernel: restoring control 00000000-0000-0000-0000-000000000101/10/5
> Feb 17 12:27:13 hactar kernel: restoring control 00000000-0000-0000-0000-000000000101/12/11
> Feb 17 12:32:10 hactar kernel: usb 5-1.1: reset high-speed USB device number 3 using xhci_hcd
> Feb 17 12:32:11 hactar kernel: restoring control 00000000-0000-0000-0000-000000000101/10/5
> Feb 17 12:32:11 hactar kernel: restoring control 00000000-0000-0000-0000-000000000101/12/11
> Feb 17 12:54:34 hactar kernel: usb 5-1.1: reset high-speed USB device number 3 using xhci_hcd
> Feb 17 12:54:34 hactar kernel: restoring control 00000000-0000-0000-0000-000000000101/10/5
> Feb 17 12:54:34 hactar kernel: restoring control 00000000-0000-0000-0000-000000000101/12/11




-- 
Hugo Mills             | "There's a Martian war machine outside -- they want
hugo@... carfax.org.uk | to talk to you about a cure for the common cold."
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                           Stephen Franklin, Babylon 5

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE3YTVWJ2B3e6TDSBUWF4UdeKrHeQFAmAtHdkACgkQWF4UdeKr
HeQHDRAAvWUsrWbV4Vt79uPW7+Z/Yjr5ur9RwntC9TcbwoEycLU3uQQPmvptVjYd
RnQkgKTxfOjrb1O4BImM0UHH3/vi6xf1rx2Qpuueqfdd3XIoB+n//Lx4QZalZ5Fx
am+GiTkYlp6AVGVXTv6TFHJHcEKcsxfh5sJaDLyjP5iLCdt0OTraapjC68db6U6I
RleKDedWyRB0YYbckxTpqLiIZlURAam4SP1uxXwoeY3PA9dYsb1BHBeX3hHaSjqA
wpzzN4Y7e7eILcVaaynVCIiSlyDIbpRGe8lKkN5WqFud6X80tTQcfKRLl5fO7yad
sl6+LdBDXKd4GQc+NMTCtDIK72nVupSNXXh6zh6mrLh0Bmrv6gyePQ/ganQVeO3E
9ed4qmzktsE9G4IXMRJwsioUUIro6qi7Qmk87bhYaE94D6bZlti6jwkbHAnkhTZv
lI6ObgByms1ILSIiVZhQ+TVLKFGvIu0YIqTckgVCGYSx4kZAeB4eXiXqL1a3ZcqP
WhOBrsNEnXgkKEz0IVKNhDK5u0aSvVkAlr8C+UJJuPJ78NnTi1nsKURTHMhD65F6
YPmYVX3fBcpVsxyEWMzgsq7JeRBYOd3WMDNQR9FkWAx57ibG+MMhQStjIJBqP/I1
kWBUXIGNs+tyVmGgcha9KgHptCAtsZwzUq94tpNY5g56zS6ZDec=
=VDlg
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
