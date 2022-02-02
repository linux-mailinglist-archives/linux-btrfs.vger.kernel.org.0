Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DA24A76BC
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 18:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244343AbiBBRWt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Feb 2022 12:22:49 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:48360 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244506AbiBBRWt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Feb 2022 12:22:49 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id C76191BA86B; Wed,  2 Feb 2022 12:22:31 -0500 (EST)
Date:   Wed, 2 Feb 2022 12:22:31 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Ross Vandegrift <ross@kallisti.us>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: unable to remove device due to enospc
Message-ID: <Yfq917NcKDq+yiKW@hungrycats.org>
References: <20220111072058.2qehmc7qip2mtkr4@stgulik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111072058.2qehmc7qip2mtkr4@stgulik>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 10, 2022 at 11:22:05PM -0800, Ross Vandegrift wrote:
> Hello,
> 
> Hoping someone can help with an enospc issue.  I'm converting a single 8TB fs
> -> 2*10TB raid1.  So far I:
>   1. added the two new devices
>   2. rebalanced single -> raid1
>   3. tried to remove the 8TB device.

> The balance in #2 failed with enospc and left 35G of data in the single
> profile.  The remove in #3 sucessfully moved everything but 35G off.  

Balance, resize shrink, and device delete all run the same relocation code.
If one fails, so will the other two.

> There is 2.5TB unallocated on the new devices:

> Overall:
>     Device size:	          25.34TiB
>     Device allocated:	          13.00TiB
>     Device unallocated:		  12.34TiB
>     Device missing:	             0.00B
>     Used:		          12.94TiB
>     Free (estimated):	           6.21TiB	(min: 6.20TiB)
>     Free (statfs, df):	           5.15TiB
>     Data ratio:	             	      1.99
>     Metadata ratio:	              2.00
>     Global reserve:	         512.00MiB	(used: 0.00B)
>     Multiple profiles:	               yes	(data)
> 
> Data,single: Size:35.00GiB, Used:34.98GiB (99.94%)
>    /dev/mapper/backup	  35.00GiB

> Data,RAID1: Size:6.46TiB, Used:6.44TiB (99.60%)
>    /dev/mapper/backup_a    6.46TiB
>    /dev/mapper/backup_b    6.46TiB
> 
> Metadata,RAID1: Size:19.00GiB, Used:17.71GiB (93.22%)
>    /dev/mapper/backup_a   19.00GiB
>    /dev/mapper/backup_b   19.00GiB
> 
> System,RAID1: Size:32.00MiB, Used:936.00KiB (2.86%)
>    /dev/mapper/backup	  32.00MiB
>    /dev/mapper/backup_a   32.00MiB
> 
> Unallocated:
>    /dev/mapper/backup	   7.24TiB
>    /dev/mapper/backup_a    2.55TiB
>    /dev/mapper/backup_b    2.55TiB
> 
> Creating a new 4G file worked fine.  Rebalancing -musage=0/5/10 worked fine but
> didn't help.
> 
> Very little is printed to dmesg, but enospc_debug produces tons of output.  The
> error/critical messages are included below.  I have the info level messages if
> they'd be useful.
> 
> I'm using linux 5.10.84-1 and btrfs-progs 5.10.1-2 from debian stable.
> 
> Thanks in advance,
> Ross

> [200706.753360] BTRFS error (device dm-16): allocation failed flags 17, wanted 1769996288

That allocation size is larger than a raid1 or single block group, so I
wouldn't expect it to ever succeed.  The question now is where did that
allocation request come from?  Do you have files with huge prealloc
extents in them?  Is the filesystem more than about 6 years old, when
kernels would allow extents to be excessively large?

Grab the python-btrfs package and run
'show_block_group_data_extent_filenames.py' on the failing block group to
see what files are there.  Look for files with extents longer than the
maximum size of 128MB.  You should be able to copy the offending files
and delete the originals (make sure to get all the snapshots if any),
then relocation can proceed normally since newly created extents will
respect modern extent length limits.

I don't know if btrfs check will notice this, but it shouldn't.
Technically the on-disk data is correct and long extents are still
relocatable with some raid profiles; however, in this case relocation
will require a target profile that is striped with at least 2 data disks
(i.e. raid0 with 2+ disks, raid10 with 4+ disks, raid5 with 3+ disks,
or raid6 with 4+ disks) to accommodate extents over 1GB, so it won't
work with single or raid1 profiles.  That's one of the issues the 128MB
extent length limit was meant to address.

> [200706.760288] BTRFS critical (device dm-16): entry offset 19390197350400, bytes 1884160, bitmap no
> [200706.760374] BTRFS critical (device dm-16): entry offset 19391244304384, bytes 28672000, bitmap no
> [200706.760447] BTRFS critical (device dm-16): entry offset 19392130379776, bytes 216338432, bitmap no
> [200706.760519] BTRFS critical (device dm-16): entry offset 19392346718208, bytes 1073741824, bitmap no
> [200706.760595] BTRFS critical (device dm-16): entry offset 19393420460032, bytes 1073741824, bitmap no
> [200706.760668] BTRFS critical (device dm-16): entry offset 19394494201856, bytes 1073741824, bitmap no
> [200751.592832] BTRFS error (device dm-16): allocation failed flags 17, wanted 1278898176
> [200751.594738] BTRFS critical (device dm-16): entry offset 19390007873536, bytes 191361024, bitmap no
> [200751.594763] BTRFS critical (device dm-16): entry offset 19391239421952, bytes 7766016, bitmap no
> [200751.594784] BTRFS critical (device dm-16): entry offset 19391247450112, bytes 1310720, bitmap no
> [200751.594806] BTRFS critical (device dm-16): entry offset 19391249022976, bytes 23953408, bitmap no
> [200751.594827] BTRFS critical (device dm-16): entry offset 19391742320640, bytes 604397568, bitmap no
> [200751.594849] BTRFS critical (device dm-16): entry offset 19393378516992, bytes 41943040, bitmap no
> [200751.594870] BTRFS critical (device dm-16): entry offset 19394403696640, bytes 90505216, bitmap no
> [200751.594892] BTRFS critical (device dm-16): entry offset 19394494201856, bytes 1073741824, bitmap no
> [200751.594913] BTRFS critical (device dm-16): entry offset 19395567943680, bytes 1073741824, bitmap no
> [200751.594935] BTRFS critical (device dm-16): entry offset 19396641685504, bytes 1073741824, bitmap no
> [200783.297520] BTRFS error (device dm-16): allocation failed flags 17, wanted 1398403072
> [200783.300081] BTRFS critical (device dm-16): entry offset 19386613215232, bytes 262144, bitmap no
> [200783.300119] BTRFS critical (device dm-16): entry offset 19386614001664, bytes 524288, bitmap no
> [200783.300154] BTRFS critical (device dm-16): entry offset 19386615574528, bytes 786432, bitmap no
> [200783.300190] BTRFS critical (device dm-16): entry offset 19388754931712, bytes 262144, bitmap no
> [200783.300225] BTRFS critical (device dm-16): entry offset 19388755980288, bytes 524288, bitmap no
> [200783.300260] BTRFS critical (device dm-16): entry offset 19389828870144, bytes 1048576, bitmap no
> [200783.300307] BTRFS critical (device dm-16): entry offset 19389830180864, bytes 1572864, bitmap no
> [200783.300343] BTRFS critical (device dm-16): entry offset 19389833326592, bytes 177954816, bitmap no
> [200783.300379] BTRFS critical (device dm-16): entry offset 19390011543552, bytes 2621440, bitmap no
> [200783.300414] BTRFS critical (device dm-16): entry offset 19390015475712, bytes 183758848, bitmap no
> [200783.300450] BTRFS critical (device dm-16): entry offset 19391267905536, bytes 5070848, bitmap no
> [200783.300486] BTRFS critical (device dm-16): entry offset 19391395487744, bytes 951230464, bitmap no
> [200783.300522] BTRFS critical (device dm-16): entry offset 19392346718208, bytes 1073741824, bitmap no
> [200783.300558] BTRFS critical (device dm-16): entry offset 19393420460032, bytes 1073741824, bitmap no
> [200783.300594] BTRFS critical (device dm-16): entry offset 19394494201856, bytes 1073741824, bitmap no
> [200783.300631] BTRFS critical (device dm-16): entry offset 19395567943680, bytes 1073741824, bitmap no
> [200783.300667] BTRFS critical (device dm-16): entry offset 19396641685504, bytes 1073741824, bitmap no
> [200783.300704] BTRFS critical (device dm-16): entry offset 19397715427328, bytes 1073741824, bitmap no
> [200783.300740] BTRFS critical (device dm-16): entry offset 19398789169152, bytes 1073741824, bitmap no
> [200785.369302] BTRFS error (device dm-16): allocation failed flags 17, wanted 1350565888
> [200785.373327] BTRFS critical (device dm-16): entry offset 19386613215232, bytes 262144, bitmap no
> [200785.373408] BTRFS critical (device dm-16): entry offset 19386614001664, bytes 524288, bitmap no
> [200785.373465] BTRFS critical (device dm-16): entry offset 19386615574528, bytes 786432, bitmap no
> [200785.373523] BTRFS critical (device dm-16): entry offset 19388754931712, bytes 262144, bitmap no
> [200785.373581] BTRFS critical (device dm-16): entry offset 19389829394432, bytes 262144, bitmap no
> [200785.373638] BTRFS critical (device dm-16): entry offset 19389830180864, bytes 1572864, bitmap no
> [200785.374561] BTRFS critical (device dm-16): entry offset 19389933727744, bytes 77553664, bitmap no
> [200785.375224] BTRFS critical (device dm-16): entry offset 19390011543552, bytes 2621440, bitmap no
> [200785.375656] BTRFS critical (device dm-16): entry offset 19390014427136, bytes 184807424, bitmap no
> [200785.376287] BTRFS critical (device dm-16): entry offset 19390828380160, bytes 444596224, bitmap no
> [200785.376630] BTRFS critical (device dm-16): entry offset 19391272976384, bytes 1073741824, bitmap no
> [200785.376966] BTRFS critical (device dm-16): entry offset 19392346718208, bytes 1073741824, bitmap no
> [200785.377370] BTRFS critical (device dm-16): entry offset 19393420460032, bytes 1073741824, bitmap no
> [200785.377803] BTRFS critical (device dm-16): entry offset 19394494201856, bytes 1073741824, bitmap no
> [200785.378356] BTRFS critical (device dm-16): entry offset 19395567943680, bytes 1073741824, bitmap no
> [200785.378743] BTRFS critical (device dm-16): entry offset 19396641685504, bytes 1073741824, bitmap no
> [200785.379052] BTRFS critical (device dm-16): entry offset 19397715427328, bytes 1073741824, bitmap no
> [200785.379348] BTRFS critical (device dm-16): entry offset 19398789169152, bytes 1073741824, bitmap no
> [200785.379645] BTRFS critical (device dm-16): entry offset 19399862910976, bytes 1073741824, bitmap no
> [200785.379974] BTRFS critical (device dm-16): entry offset 19400936652800, bytes 1073741824, bitmap no
> [200788.633576] BTRFS error (device dm-16): allocation failed flags 17, wanted 1221955584
> [200788.636981] BTRFS critical (device dm-16): entry offset 19389927698432, bytes 6553600, bitmap no
> [200788.637703] BTRFS critical (device dm-16): entry offset 19389934514176, bytes 786432, bitmap no
> [200788.638527] BTRFS critical (device dm-16): entry offset 19389936087040, bytes 75194368, bitmap no
> [200788.639271] BTRFS critical (device dm-16): entry offset 19390011543552, bytes 187691008, bitmap no
> [200788.639989] BTRFS critical (device dm-16): entry offset 19390668996608, bytes 603979776, bitmap no
> [200788.640663] BTRFS critical (device dm-16): entry offset 19391272976384, bytes 1073741824, bitmap no
> [200788.641431] BTRFS critical (device dm-16): entry offset 19392346718208, bytes 1073741824, bitmap no
> [200788.642352] BTRFS critical (device dm-16): entry offset 19393420460032, bytes 1073741824, bitmap no
> [200788.643071] BTRFS critical (device dm-16): entry offset 19394494201856, bytes 1073741824, bitmap no
> [200788.643751] BTRFS critical (device dm-16): entry offset 19395567943680, bytes 1073741824, bitmap no
> [200788.644409] BTRFS critical (device dm-16): entry offset 19396641685504, bytes 1073741824, bitmap no
> [200788.644980] BTRFS critical (device dm-16): entry offset 19397715427328, bytes 1073741824, bitmap no
> [200788.645399] BTRFS critical (device dm-16): entry offset 19398789169152, bytes 1073741824, bitmap no
> [200788.645716] BTRFS critical (device dm-16): entry offset 19399862910976, bytes 1073741824, bitmap no
> [200788.646031] BTRFS critical (device dm-16): entry offset 19400936652800, bytes 1073741824, bitmap no
> [200788.646367] BTRFS critical (device dm-16): entry offset 19402010394624, bytes 1073741824, bitmap no
> [200788.646800] BTRFS critical (device dm-16): entry offset 19403084136448, bytes 1073741824, bitmap no
> [200796.045036] BTRFS error (device dm-16): allocation failed flags 17, wanted 1442840576
> [200796.056107] BTRFS critical (device dm-16): entry offset 19389955985408, bytes 55296000, bitmap no
> [200796.057973] BTRFS critical (device dm-16): entry offset 19390011543552, bytes 187691008, bitmap no
> [200796.059855] BTRFS critical (device dm-16): entry offset 19391244427264, bytes 28549120, bitmap no
> [200796.061797] BTRFS critical (device dm-16): entry offset 19391608520704, bytes 738197504, bitmap no
> [200796.066223] BTRFS critical (device dm-16): entry offset 19392346718208, bytes 1073741824, bitmap no
> [200796.070718] BTRFS critical (device dm-16): entry offset 19393420460032, bytes 1073741824, bitmap no
> [200796.075088] BTRFS critical (device dm-16): entry offset 19394494201856, bytes 1073741824, bitmap no
> [200796.080202] BTRFS critical (device dm-16): entry offset 19395567943680, bytes 1073741824, bitmap no
> [200796.084313] BTRFS critical (device dm-16): entry offset 19396641685504, bytes 1073741824, bitmap no
> [200796.088272] BTRFS critical (device dm-16): entry offset 19397715427328, bytes 1073741824, bitmap no
> [200796.092162] BTRFS critical (device dm-16): entry offset 19398789169152, bytes 1073741824, bitmap no
> [200796.095321] BTRFS critical (device dm-16): entry offset 19399862910976, bytes 1073741824, bitmap no
> [200796.098308] BTRFS critical (device dm-16): entry offset 19400936652800, bytes 1073741824, bitmap no
> [200796.101281] BTRFS critical (device dm-16): entry offset 19402010394624, bytes 1073741824, bitmap no
> [200796.104485] BTRFS critical (device dm-16): entry offset 19403084136448, bytes 1073741824, bitmap no
> [200796.107606] BTRFS critical (device dm-16): entry offset 19404157878272, bytes 1073741824, bitmap no
> [200796.110495] BTRFS critical (device dm-16): entry offset 19405231620096, bytes 1073741824, bitmap no
> [200812.740718] BTRFS error (device dm-16): allocation failed flags 17, wanted 1563734016
> [200812.758891] BTRFS critical (device dm-16): entry offset 19390172180480, bytes 27054080, bitmap no
> [200812.759241] BTRFS critical (device dm-16): entry offset 19391214616576, bytes 58359808, bitmap no
> [200812.759600] BTRFS critical (device dm-16): entry offset 19391533023232, bytes 813694976, bitmap no
> [200812.759964] BTRFS critical (device dm-16): entry offset 19392346718208, bytes 1073741824, bitmap no
> [200812.760390] BTRFS critical (device dm-16): entry offset 19393420460032, bytes 1073741824, bitmap no
> [200812.760863] BTRFS critical (device dm-16): entry offset 19394494201856, bytes 1073741824, bitmap no
> [200812.761213] BTRFS critical (device dm-16): entry offset 19395567943680, bytes 1073741824, bitmap no
> [200812.761562] BTRFS critical (device dm-16): entry offset 19396641685504, bytes 1073741824, bitmap no
> [200812.761912] BTRFS critical (device dm-16): entry offset 19397715427328, bytes 1073741824, bitmap no
> [200812.762261] BTRFS critical (device dm-16): entry offset 19398789169152, bytes 1073741824, bitmap no
> [200812.762610] BTRFS critical (device dm-16): entry offset 19399862910976, bytes 1073741824, bitmap no
> [200812.762942] BTRFS critical (device dm-16): entry offset 19400936652800, bytes 1073741824, bitmap no
> [200812.763283] BTRFS critical (device dm-16): entry offset 19402010394624, bytes 1073741824, bitmap no
> [200812.763583] BTRFS critical (device dm-16): entry offset 19403084136448, bytes 1073741824, bitmap no
> [200812.763948] BTRFS critical (device dm-16): entry offset 19404157878272, bytes 1073741824, bitmap no
> [200812.764210] BTRFS critical (device dm-16): entry offset 19405231620096, bytes 1073741824, bitmap no
> [200812.764465] BTRFS critical (device dm-16): entry offset 19406305361920, bytes 1073741824, bitmap no
> [200812.764717] BTRFS critical (device dm-16): entry offset 19407379103744, bytes 1073741824, bitmap no
> [200833.899584] BTRFS error (device dm-16): allocation failed flags 17, wanted 1769996288
> [200833.917517] BTRFS critical (device dm-16): entry offset 19389960699904, bytes 4096, bitmap no
> [200833.917837] BTRFS critical (device dm-16): entry offset 19390171942912, bytes 1286144, bitmap no
> [200833.918118] BTRFS critical (device dm-16): entry offset 19390176268288, bytes 106496, bitmap no
> [200833.918399] BTRFS critical (device dm-16): entry offset 19390176636928, bytes 1048576, bitmap no
> [200833.918716] BTRFS critical (device dm-16): entry offset 19390197338112, bytes 1896448, bitmap no
> [200833.918999] BTRFS critical (device dm-16): entry offset 19391247810560, bytes 25165824, bitmap no
> [200833.919317] BTRFS critical (device dm-16): entry offset 19392130379776, bytes 216338432, bitmap no
> [200833.919608] BTRFS critical (device dm-16): entry offset 19392346718208, bytes 1073741824, bitmap no
> [200833.919925] BTRFS critical (device dm-16): entry offset 19393420460032, bytes 1073741824, bitmap no
> [200833.920300] BTRFS critical (device dm-16): entry offset 19394494201856, bytes 1073741824, bitmap no
> [200833.920790] BTRFS critical (device dm-16): entry offset 19395567943680, bytes 1073741824, bitmap no
> [200833.921134] BTRFS critical (device dm-16): entry offset 19396641685504, bytes 1073741824, bitmap no
> [200833.921419] BTRFS critical (device dm-16): entry offset 19397715427328, bytes 1073741824, bitmap no
> [200833.921699] BTRFS critical (device dm-16): entry offset 19398789169152, bytes 1073741824, bitmap no
> [200833.921975] BTRFS critical (device dm-16): entry offset 19399862910976, bytes 1073741824, bitmap no
> [200833.922261] BTRFS critical (device dm-16): entry offset 19400936652800, bytes 1073741824, bitmap no
> [200833.922532] BTRFS critical (device dm-16): entry offset 19402010394624, bytes 1073741824, bitmap no
> [200833.922807] BTRFS critical (device dm-16): entry offset 19403084136448, bytes 1073741824, bitmap no
> [200833.923088] BTRFS critical (device dm-16): entry offset 19404157878272, bytes 1073741824, bitmap no
> [200833.923359] BTRFS critical (device dm-16): entry offset 19405231620096, bytes 1073741824, bitmap no
> [200833.923629] BTRFS critical (device dm-16): entry offset 19406305361920, bytes 1073741824, bitmap no
> [200833.923942] BTRFS critical (device dm-16): entry offset 19407379103744, bytes 1073741824, bitmap no
> [200833.924310] BTRFS critical (device dm-16): entry offset 19408452845568, bytes 1073741824, bitmap no
> [200833.924611] BTRFS critical (device dm-16): entry offset 19409526587392, bytes 1073741824, bitmap no
> [200867.661574] BTRFS error (device dm-16): allocation failed flags 17, wanted 1278898176
> [200867.668241] BTRFS critical (device dm-16): entry offset 19390007087104, bytes 165904384, bitmap no
> [200867.668880] BTRFS critical (device dm-16): entry offset 19390173253632, bytes 25980928, bitmap no
> [200867.669477] BTRFS critical (device dm-16): entry offset 19391239421952, bytes 9699328, bitmap no
> [200867.670034] BTRFS critical (device dm-16): entry offset 19391250694144, bytes 22282240, bitmap no
> [200867.670567] BTRFS critical (device dm-16): entry offset 19391742320640, bytes 604397568, bitmap no
> [200867.671052] BTRFS critical (device dm-16): entry offset 19394452258816, bytes 41943040, bitmap no
> [200867.671654] BTRFS critical (device dm-16): entry offset 19395477438464, bytes 90505216, bitmap no
> [200867.672201] BTRFS critical (device dm-16): entry offset 19395567943680, bytes 1073741824, bitmap no
> [200867.672586] BTRFS critical (device dm-16): entry offset 19396641685504, bytes 1073741824, bitmap no
> [200867.672926] BTRFS critical (device dm-16): entry offset 19397715427328, bytes 1073741824, bitmap no
> [200867.673254] BTRFS critical (device dm-16): entry offset 19398789169152, bytes 1073741824, bitmap no
> [200867.673582] BTRFS critical (device dm-16): entry offset 19399862910976, bytes 1073741824, bitmap no
> [200867.673934] BTRFS critical (device dm-16): entry offset 19400936652800, bytes 1073741824, bitmap no
> [200867.674302] BTRFS critical (device dm-16): entry offset 19402010394624, bytes 1073741824, bitmap no
> [200867.674644] BTRFS critical (device dm-16): entry offset 19403084136448, bytes 1073741824, bitmap no
> [200867.674966] BTRFS critical (device dm-16): entry offset 19404157878272, bytes 1073741824, bitmap no
> [200867.675361] BTRFS critical (device dm-16): entry offset 19405231620096, bytes 1073741824, bitmap no
> [200867.675685] BTRFS critical (device dm-16): entry offset 19406305361920, bytes 1073741824, bitmap no
> [200867.676011] BTRFS critical (device dm-16): entry offset 19407379103744, bytes 1073741824, bitmap no
> [200867.676368] BTRFS critical (device dm-16): entry offset 19408452845568, bytes 1073741824, bitmap no
> [200867.676685] BTRFS critical (device dm-16): entry offset 19409526587392, bytes 1073741824, bitmap no
> [200867.676989] BTRFS critical (device dm-16): entry offset 19410600329216, bytes 1073741824, bitmap no
> [200867.677276] BTRFS critical (device dm-16): entry offset 19411674071040, bytes 1073741824, bitmap no
> [200897.996534] BTRFS error (device dm-16): allocation failed flags 17, wanted 1398403072
> [200898.000014] BTRFS critical (device dm-16): entry offset 19374801260544, bytes 262144, bitmap no
> [200898.000455] BTRFS critical (device dm-16): entry offset 19386611118080, bytes 262144, bitmap no
> [200898.000842] BTRFS critical (device dm-16): entry offset 19386612428800, bytes 262144, bitmap no
> [200898.001160] BTRFS critical (device dm-16): entry offset 19386613215232, bytes 262144, bitmap no
> [200898.001448] BTRFS critical (device dm-16): entry offset 19386614001664, bytes 524288, bitmap no
> [200898.001735] BTRFS critical (device dm-16): entry offset 19386615312384, bytes 1048576, bitmap no
> [200898.002104] BTRFS critical (device dm-16): entry offset 19388754931712, bytes 262144, bitmap no
> [200898.002752] BTRFS critical (device dm-16): entry offset 19388756242432, bytes 262144, bitmap no
> [200898.003173] BTRFS critical (device dm-16): entry offset 19388757028864, bytes 262144, bitmap no
> [200898.003662] BTRFS critical (device dm-16): entry offset 19389828870144, bytes 2883584, bitmap no
> [200898.004080] BTRFS critical (device dm-16): entry offset 19389832278016, bytes 524288, bitmap no
> [200898.004525] BTRFS critical (device dm-16): entry offset 19389833064448, bytes 99090432, bitmap no
> [200898.005404] BTRFS critical (device dm-16): entry offset 19389932417024, bytes 28282880, bitmap no
> [200898.006185] BTRFS critical (device dm-16): entry offset 19389961224192, bytes 266240, bitmap no
> [200898.006740] BTRFS critical (device dm-16): entry offset 19389962539008, bytes 50053120, bitmap no
> [200898.007432] BTRFS critical (device dm-16): entry offset 19390012854272, bytes 524288, bitmap no
> [200898.008164] BTRFS critical (device dm-16): entry offset 19390013640704, bytes 786432, bitmap no
> [200898.008682] BTRFS critical (device dm-16): entry offset 19390015475712, bytes 183758848, bitmap no
> [200898.009054] BTRFS critical (device dm-16): entry offset 19391248461824, bytes 1183744, bitmap no
> [200898.009449] BTRFS critical (device dm-16): entry offset 19391269351424, bytes 3624960, bitmap no
> [200898.009858] BTRFS critical (device dm-16): entry offset 19391395487744, bytes 951230464, bitmap no
> [200898.010245] BTRFS critical (device dm-16): entry offset 19393420460032, bytes 1073741824, bitmap no
> [200898.010601] BTRFS critical (device dm-16): entry offset 19394494201856, bytes 1073741824, bitmap no
> [200898.011034] BTRFS critical (device dm-16): entry offset 19395567943680, bytes 1073741824, bitmap no
> [200898.011441] BTRFS critical (device dm-16): entry offset 19396641685504, bytes 1073741824, bitmap no
> [200898.011891] BTRFS critical (device dm-16): entry offset 19397715427328, bytes 1073741824, bitmap no
> [200898.012489] BTRFS critical (device dm-16): entry offset 19398789169152, bytes 1073741824, bitmap no
> [200898.012932] BTRFS critical (device dm-16): entry offset 19399862910976, bytes 1073741824, bitmap no
> [200898.013354] BTRFS critical (device dm-16): entry offset 19400936652800, bytes 1073741824, bitmap no
> [200898.013713] BTRFS critical (device dm-16): entry offset 19402010394624, bytes 1073741824, bitmap no
> [200898.013996] BTRFS critical (device dm-16): entry offset 19403084136448, bytes 1073741824, bitmap no
> [200898.014371] BTRFS critical (device dm-16): entry offset 19404157878272, bytes 1073741824, bitmap no
> [200898.014698] BTRFS critical (device dm-16): entry offset 19405231620096, bytes 1073741824, bitmap no
> [200898.015045] BTRFS critical (device dm-16): entry offset 19406305361920, bytes 1073741824, bitmap no
> [200898.015428] BTRFS critical (device dm-16): entry offset 19407379103744, bytes 1073741824, bitmap no
> [200898.015757] BTRFS critical (device dm-16): entry offset 19408452845568, bytes 1073741824, bitmap no
> [200898.016126] BTRFS critical (device dm-16): entry offset 19409526587392, bytes 1073741824, bitmap no
> [200898.017020] BTRFS critical (device dm-16): entry offset 19410600329216, bytes 1073741824, bitmap no
> [200898.017414] BTRFS critical (device dm-16): entry offset 19411674071040, bytes 1073741824, bitmap no
> [200898.017733] BTRFS critical (device dm-16): entry offset 19412747812864, bytes 1073741824, bitmap no
> [200898.018135] BTRFS critical (device dm-16): entry offset 19413821554688, bytes 1073741824, bitmap no
> [200899.342527] BTRFS error (device dm-16): allocation failed flags 17, wanted 1350565888
> [200899.352369] BTRFS critical (device dm-16): entry offset 19386611118080, bytes 262144, bitmap no
> [200899.354133] BTRFS critical (device dm-16): entry offset 19386612428800, bytes 262144, bitmap no
> [200899.355872] BTRFS critical (device dm-16): entry offset 19386613215232, bytes 262144, bitmap no
> [200899.357468] BTRFS critical (device dm-16): entry offset 19386614001664, bytes 524288, bitmap no
> [200899.358959] BTRFS critical (device dm-16): entry offset 19388756242432, bytes 262144, bitmap no
> [200899.360442] BTRFS critical (device dm-16): entry offset 19388757028864, bytes 262144, bitmap no
> [200899.361720] BTRFS critical (device dm-16): entry offset 19389829132288, bytes 1310720, bitmap no
> [200899.362991] BTRFS critical (device dm-16): entry offset 19389831229440, bytes 524288, bitmap no
> [200899.364383] BTRFS critical (device dm-16): entry offset 19389832278016, bytes 524288, bitmap no
> [200899.365732] BTRFS critical (device dm-16): entry offset 19389933727744, bytes 27762688, bitmap no
> [200899.367043] BTRFS critical (device dm-16): entry offset 19389961752576, bytes 50839552, bitmap no
> [200899.368447] BTRFS critical (device dm-16): entry offset 19390012854272, bytes 524288, bitmap no
> [200899.369752] BTRFS critical (device dm-16): entry offset 19390013640704, bytes 185593856, bitmap no
> [200899.371186] BTRFS critical (device dm-16): entry offset 19390828380160, bytes 421265408, bitmap no
> [200899.372708] BTRFS critical (device dm-16): entry offset 19391249907712, bytes 23068672, bitmap no
> [200899.374305] BTRFS critical (device dm-16): entry offset 19391272976384, bytes 1073741824, bitmap no
> [200899.376455] BTRFS critical (device dm-16): entry offset 19393420460032, bytes 1073741824, bitmap no
> [200899.380683] BTRFS critical (device dm-16): entry offset 19394494201856, bytes 1073741824, bitmap no
> [200899.385031] BTRFS critical (device dm-16): entry offset 19395567943680, bytes 1073741824, bitmap no
> [200899.388924] BTRFS critical (device dm-16): entry offset 19396641685504, bytes 1073741824, bitmap no
> [200899.392118] BTRFS critical (device dm-16): entry offset 19397715427328, bytes 1073741824, bitmap no
> [200899.396041] BTRFS critical (device dm-16): entry offset 19398789169152, bytes 1073741824, bitmap no
> [200899.401660] BTRFS critical (device dm-16): entry offset 19399862910976, bytes 1073741824, bitmap no
> [200899.405432] BTRFS critical (device dm-16): entry offset 19400936652800, bytes 1073741824, bitmap no
> [200899.409217] BTRFS critical (device dm-16): entry offset 19402010394624, bytes 1073741824, bitmap no
> [200899.412292] BTRFS critical (device dm-16): entry offset 19403084136448, bytes 1073741824, bitmap no
> [200899.415587] BTRFS critical (device dm-16): entry offset 19404157878272, bytes 1073741824, bitmap no
> [200899.418548] BTRFS critical (device dm-16): entry offset 19405231620096, bytes 1073741824, bitmap no
> [200899.421321] BTRFS critical (device dm-16): entry offset 19406305361920, bytes 1073741824, bitmap no
> [200899.423764] BTRFS critical (device dm-16): entry offset 19407379103744, bytes 1073741824, bitmap no
> [200899.426425] BTRFS critical (device dm-16): entry offset 19408452845568, bytes 1073741824, bitmap no
> [200899.429094] BTRFS critical (device dm-16): entry offset 19409526587392, bytes 1073741824, bitmap no
> [200899.431199] BTRFS critical (device dm-16): entry offset 19410600329216, bytes 1073741824, bitmap no
> [200899.434034] BTRFS critical (device dm-16): entry offset 19411674071040, bytes 1073741824, bitmap no
> [200899.436703] BTRFS critical (device dm-16): entry offset 19412747812864, bytes 1073741824, bitmap no
> [200899.439669] BTRFS critical (device dm-16): entry offset 19413821554688, bytes 1073741824, bitmap no
> [200899.443639] BTRFS critical (device dm-16): entry offset 19414895296512, bytes 1073741824, bitmap no
> [200899.448720] BTRFS critical (device dm-16): entry offset 19415969038336, bytes 1073741824, bitmap no
> [200900.311260] BTRFS error (device dm-16): allocation failed flags 17, wanted 1221955584
> [200900.314540] BTRFS critical (device dm-16): entry offset 19389927960576, bytes 33529856, bitmap no
> [200900.314908] BTRFS critical (device dm-16): entry offset 19389961752576, bytes 50839552, bitmap no
> [200900.315554] BTRFS critical (device dm-16): entry offset 19390012854272, bytes 524288, bitmap no
> [200900.316237] BTRFS critical (device dm-16): entry offset 19390013640704, bytes 185593856, bitmap no
> [200900.316691] BTRFS critical (device dm-16): entry offset 19390668996608, bytes 580648960, bitmap no
> [200900.317038] BTRFS critical (device dm-16): entry offset 19391249907712, bytes 23068672, bitmap no
> [200900.317377] BTRFS critical (device dm-16): entry offset 19391272976384, bytes 1073741824, bitmap no
> [200900.317692] BTRFS critical (device dm-16): entry offset 19393420460032, bytes 1073741824, bitmap no
> [200900.317992] BTRFS critical (device dm-16): entry offset 19394494201856, bytes 1073741824, bitmap no
> [200900.318279] BTRFS critical (device dm-16): entry offset 19395567943680, bytes 1073741824, bitmap no
> [200900.318563] BTRFS critical (device dm-16): entry offset 19396641685504, bytes 1073741824, bitmap no
> [200900.318836] BTRFS critical (device dm-16): entry offset 19397715427328, bytes 1073741824, bitmap no
> [200900.319187] BTRFS critical (device dm-16): entry offset 19398789169152, bytes 1073741824, bitmap no
> [200900.319527] BTRFS critical (device dm-16): entry offset 19399862910976, bytes 1073741824, bitmap no
> [200900.319801] BTRFS critical (device dm-16): entry offset 19400936652800, bytes 1073741824, bitmap no
> [200900.320077] BTRFS critical (device dm-16): entry offset 19402010394624, bytes 1073741824, bitmap no
> [200900.320337] BTRFS critical (device dm-16): entry offset 19403084136448, bytes 1073741824, bitmap no
> [200900.320610] BTRFS critical (device dm-16): entry offset 19404157878272, bytes 1073741824, bitmap no
> [200900.320871] BTRFS critical (device dm-16): entry offset 19405231620096, bytes 1073741824, bitmap no
> [200900.321131] BTRFS critical (device dm-16): entry offset 19406305361920, bytes 1073741824, bitmap no
> [200900.321378] BTRFS critical (device dm-16): entry offset 19407379103744, bytes 1073741824, bitmap no
> [200906.873224] BTRFS error (device dm-16): allocation failed flags 17, wanted 1442840576
> [200906.891338] BTRFS critical (device dm-16): entry offset 19389955461120, bytes 57131008, bitmap no
> [200906.891651] BTRFS critical (device dm-16): entry offset 19390012854272, bytes 524288, bitmap no
> [200906.891993] BTRFS critical (device dm-16): entry offset 19390013640704, bytes 185593856, bitmap no
> [200906.892418] BTRFS critical (device dm-16): entry offset 19391244427264, bytes 5218304, bitmap no
> [200906.892702] BTRFS critical (device dm-16): entry offset 19391249907712, bytes 23068672, bitmap no
> [200906.892977] BTRFS critical (device dm-16): entry offset 19391608520704, bytes 738197504, bitmap no
> [200906.893258] BTRFS critical (device dm-16): entry offset 19393420460032, bytes 1073741824, bitmap no
> [200906.893540] BTRFS critical (device dm-16): entry offset 19394494201856, bytes 1073741824, bitmap no
> [200906.893821] BTRFS critical (device dm-16): entry offset 19395567943680, bytes 1073741824, bitmap no
> [200906.894177] BTRFS critical (device dm-16): entry offset 19396641685504, bytes 1073741824, bitmap no
> [200906.894451] BTRFS critical (device dm-16): entry offset 19397715427328, bytes 1073741824, bitmap no
> [200906.894724] BTRFS critical (device dm-16): entry offset 19398789169152, bytes 1073741824, bitmap no
> [200906.894998] BTRFS critical (device dm-16): entry offset 19399862910976, bytes 1073741824, bitmap no
> [200906.895331] BTRFS critical (device dm-16): entry offset 19400936652800, bytes 1073741824, bitmap no
> [200906.895775] BTRFS critical (device dm-16): entry offset 19402010394624, bytes 1073741824, bitmap no
> [200906.896154] BTRFS critical (device dm-16): entry offset 19403084136448, bytes 1073741824, bitmap no
> [200906.896423] BTRFS critical (device dm-16): entry offset 19404157878272, bytes 1073741824, bitmap no
> [200906.896714] BTRFS critical (device dm-16): entry offset 19405231620096, bytes 1073741824, bitmap no
> [200906.896984] BTRFS critical (device dm-16): entry offset 19406305361920, bytes 1073741824, bitmap no
> [200906.897295] BTRFS critical (device dm-16): entry offset 19407379103744, bytes 1073741824, bitmap no
> [200906.897563] BTRFS critical (device dm-16): entry offset 19408452845568, bytes 1073741824, bitmap no
> [200906.897926] BTRFS critical (device dm-16): entry offset 19409526587392, bytes 1073741824, bitmap no
> [200906.898219] BTRFS critical (device dm-16): entry offset 19410600329216, bytes 1073741824, bitmap no
> [200906.898477] BTRFS critical (device dm-16): entry offset 19411674071040, bytes 1073741824, bitmap no
> [200906.898752] BTRFS critical (device dm-16): entry offset 19412747812864, bytes 1073741824, bitmap no
> [200906.899186] BTRFS critical (device dm-16): entry offset 19413821554688, bytes 1073741824, bitmap no
> [200906.899556] BTRFS critical (device dm-16): entry offset 19414895296512, bytes 1073741824, bitmap no
> [200906.900113] BTRFS critical (device dm-16): entry offset 19415969038336, bytes 1073741824, bitmap no
> [200906.900548] BTRFS critical (device dm-16): entry offset 19417042780160, bytes 1073741824, bitmap no
> [200906.901112] BTRFS critical (device dm-16): entry offset 19418116521984, bytes 1073741824, bitmap no
> [200906.901560] BTRFS critical (device dm-16): entry offset 19419190263808, bytes 1073741824, bitmap no
> [200906.902003] BTRFS critical (device dm-16): entry offset 19420264005632, bytes 1073741824, bitmap no
> [200920.265637] BTRFS error (device dm-16): allocation failed flags 17, wanted 1563734016
> [200920.271580] BTRFS critical (device dm-16): entry offset 19390172180480, bytes 27054080, bitmap no
> [200920.272350] BTRFS critical (device dm-16): entry offset 19391214616576, bytes 58359808, bitmap no
> [200920.273068] BTRFS critical (device dm-16): entry offset 19391533023232, bytes 813694976, bitmap no
> [200920.273748] BTRFS critical (device dm-16): entry offset 19393420460032, bytes 1073741824, bitmap no
> [200920.274357] BTRFS critical (device dm-16): entry offset 19394494201856, bytes 1073741824, bitmap no
> [200920.274955] BTRFS critical (device dm-16): entry offset 19395567943680, bytes 1073741824, bitmap no
> [200920.275721] BTRFS critical (device dm-16): entry offset 19396641685504, bytes 1073741824, bitmap no
> [200920.276644] BTRFS critical (device dm-16): entry offset 19397715427328, bytes 1073741824, bitmap no
> [200920.277603] BTRFS critical (device dm-16): entry offset 19398789169152, bytes 1073741824, bitmap no
> [200920.278346] BTRFS critical (device dm-16): entry offset 19399862910976, bytes 1073741824, bitmap no
> [200920.278880] BTRFS critical (device dm-16): entry offset 19400936652800, bytes 1073741824, bitmap no
> [200920.279363] BTRFS critical (device dm-16): entry offset 19402010394624, bytes 1073741824, bitmap no
> [200920.279724] BTRFS critical (device dm-16): entry offset 19403084136448, bytes 1073741824, bitmap no
> [200920.280272] BTRFS critical (device dm-16): entry offset 19404157878272, bytes 1073741824, bitmap no
> [200920.280769] BTRFS critical (device dm-16): entry offset 19405231620096, bytes 1073741824, bitmap no
> [200920.281156] BTRFS critical (device dm-16): entry offset 19406305361920, bytes 1073741824, bitmap no
> [200920.281451] BTRFS critical (device dm-16): entry offset 19407379103744, bytes 1073741824, bitmap no
> [200920.281715] BTRFS critical (device dm-16): entry offset 19408452845568, bytes 1073741824, bitmap no
> [200920.281971] BTRFS critical (device dm-16): entry offset 19409526587392, bytes 1073741824, bitmap no
> [200920.282253] BTRFS critical (device dm-16): entry offset 19410600329216, bytes 1073741824, bitmap no
> [200920.282591] BTRFS critical (device dm-16): entry offset 19411674071040, bytes 1073741824, bitmap no
> [200920.282839] BTRFS critical (device dm-16): entry offset 19412747812864, bytes 1073741824, bitmap no
> [200920.283066] BTRFS critical (device dm-16): entry offset 19413821554688, bytes 1073741824, bitmap no
> [200920.283295] BTRFS critical (device dm-16): entry offset 19414895296512, bytes 1073741824, bitmap no
> [200920.283534] BTRFS critical (device dm-16): entry offset 19415969038336, bytes 1073741824, bitmap no
> [200920.283759] BTRFS critical (device dm-16): entry offset 19417042780160, bytes 1073741824, bitmap no
> [200920.284064] BTRFS critical (device dm-16): entry offset 19418116521984, bytes 1073741824, bitmap no
> [200920.284569] BTRFS critical (device dm-16): entry offset 19419190263808, bytes 1073741824, bitmap no
> [200920.284869] BTRFS critical (device dm-16): entry offset 19420264005632, bytes 1073741824, bitmap no
> [200920.285111] BTRFS critical (device dm-16): entry offset 19421337747456, bytes 1073741824, bitmap no
> [200920.285357] BTRFS critical (device dm-16): entry offset 19422411489280, bytes 1073741824, bitmap no

