Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19542528900
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 17:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245398AbiEPPg4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 11:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245342AbiEPPgz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 11:36:55 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49ED240A3
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 08:36:52 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:50644 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nqcmC-0005ZN-4J by authid <merlins.org> with srv_auth_plain; Mon, 16 May 2022 08:36:52 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nqcmB-003dWH-Uf; Mon, 16 May 2022 08:36:51 -0700
Date:   Mon, 16 May 2022 08:36:51 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220516153651.GG13006@merlins.org>
References: <20220515153347.GA8056@merlins.org>
 <CAEzrpqcZQVWwt1JSDg6z44dBYKW6fmmXmOTFoXiDWpoGXxufwQ@mail.gmail.com>
 <20220515154122.GB8056@merlins.org>
 <CAEzrpqc6MyW0t1H9ue_GQL-1AhgpWfumBfj3MK0eGstwJ3R1aw@mail.gmail.com>
 <20220515212951.GC13006@merlins.org>
 <20220515230147.GD13006@merlins.org>
 <CAEzrpqdbjeTYEy16KbzJ39bBkd8rkNTHA2n53UXHG-CdeUo6xw@mail.gmail.com>
 <20220516005759.GE13006@merlins.org>
 <CAEzrpqfMbB-sGLZUjGHjxHt1Gga+uULGkoZTqjXHwKnzsjP5aA@mail.gmail.com>
 <20220516151653.GF13006@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516151653.GF13006@merlins.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 16, 2022 at 08:16:53AM -0700, Marc MERLIN wrote:
> On Mon, May 16, 2022 at 10:50:42AM -0400, Josef Bacik wrote:
> > > > btrfs-corrupt-block -d "1,204,941709328384" -r 3 <device>
> > > >
> > > > and then you should be good, unless there are other dangling dev
> > > > extents that need to be removed.  Thanks,
> > >
> > > Is that bad?
> > 
> > Yeah, means I don't understand my own filesystem, use -r 4 instead
> > please.  Thanks,
> 
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1,204,941709328384" -r4 /dev/mapper/dshelf1 
> FS_INFO IS 0x55e58be9e600
> JOSEF: root 9
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x55e58be9e600
> 
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1,204,941709328384" -r 4 /dev/mapper/dshelf1 
> FS_INFO IS 0x55e239055600
> JOSEF: root 9
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x55e239055600
> Error searching to node -2
> 
> Means it worked?

Could you update the code so that it says "deleted"?

I'm doing repair again, and I now see:
Fixed 0 roots.
[2/7] checking extents
checksum verify failed on 364637798400 wanted 0xc3ba5144 found 0x30a5fff1
checksum verify failed on 364637962240 wanted 0x91d33e8a found 0x00890be7
checksum verify failed on 11970891186176 wanted 0x6b46adfb found 0xe40e4cbe
checksum verify failed on 12511729680384 wanted 0x41be9fa6 found 0x01f06e9c
checksum verify failed on 12512010420224 wanted 0x365027e7 found 0xba73f602
checksum verify failed on 12512303677440 wanted 0xc08fc7a0 found 0x3cb30242
checksum verify failed on 13576951021568 wanted 0x9511e976 found 0xd8fe35ea
checksum verify failed on 13577013624832 wanted 0x76bbe220 found 0xdfabbbdb
checksum verify failed on 13577013919744 wanted 0xafb37267 found 0x69504e0d
checksum verify failed on 13577113485312 wanted 0x049c1e5a found 0x0ddcba27
checksum verify failed on 13577170976768 wanted 0x9585372b found 0x048e24e3
checksum verify failed on 13577420161024 wanted 0x6d37d200 found 0x45f7a0b8
checksum verify failed on 13577490890752 wanted 0x426c3628 found 0x35008768
checksum verify failed on 13577726541824 wanted 0xc3089b25 found 0x426c57c7
checksum verify failed on 13577776611328 wanted 0x50eba933 found 0x4f0ec122
checksum verify failed on 364983844864 wanted 0x3a556bff found 0xba7431e0
checksum verify failed on 364986433536 wanted 0xa2ee2364 found 0xc0023b14
checksum verify failed on 364986449920 wanted 0x55bf9ee9 found 0x9cda5c9f
checksum verify failed on 364986482688 wanted 0x5421a4b7 found 0x37ac4734
(...)
checksum verify failed on 15646006722560 wanted 0x760a06a0 found 0xb44fcd95
checksum verify failed on 15645319872512 wanted 0x3bfb10c8 found 0x2be82f60
checksum verify failed on 15645980491776 wanted 0xe1e674a7 found 0x0fdfda2c
checksum verify failed on 15645526884352 wanted 0xc2d409c1 found 0xb3eee8d2
checksum verify failed on 13577013936128 wanted 0x4ba00b03 found 0x64614751
Chunk[256, 228, 4523166793728] stripe[1, 4531228246016] is not found in dev extent
Chunk[256, 228, 4524240535552] stripe[1, 4532301987840] is not found in dev extent
Chunk[256, 228, 4525314277376] stripe[1, 4533375729664] is not found in dev extent
Chunk[256, 228, 4526388019200] stripe[1, 4534449471488] is not found in dev extent
Chunk[256, 228, 4527461761024] stripe[1, 4535523213312] is not found in dev extent
Chunk[256, 228, 4528535502848] stripe[1, 4536596955136] is not found in dev extent
Chunk[256, 228, 4529609244672] stripe[1, 4537670696960] is not found in dev extent
(...)
Chunk[256, 228, 15362624061440] stripe[1, 14782241439744] is not found in dev extent
Chunk[256, 228, 15363697803264] stripe[1, 14783315181568] is not found in dev extent
Chunk[256, 228, 15364771545088] stripe[1, 14784388923392] is not found in dev extent
Chunk[256, 228, 15365845286912] stripe[1, 14785462665216] is not found in dev extent
Chunk[256, 228, 15366919028736] stripe[1, 14786536407040] is not found in dev extent
Device extent[1, 11503033909248, 1073741824] didn't find the relative chunk.
Device extent[1, 11595375706112, 1073741824] didn't find the relative chunk.
Device extent[1, 11596449447936, 1073741824] didn't find the relative chunk.
Device extent[1, 11597523189760, 1073741824] didn't find the relative chunk.
Device extent[1, 11598596931584, 1073741824] didn't find the relative chunk.
Device extent[1, 11599670673408, 1073741824] didn't find the relative chunk.
Device extent[1, 11600744415232, 1073741824] didn't find the relative chunk.
Device extent[1, 11601818157056, 1073741824] didn't find the relative chunk.
Device extent[1, 11611481833472, 1073741824] didn't find the relative chunk.
Device extent[1, 11612555575296, 1073741824] didn't find the relative chunk.
Device extent[1, 11613629317120, 1073741824] didn't find the relative chunk.
(...)
Device extent[1, 11422503272448, 1073741824] didn't find the relative chunk.
Device extent[1, 10616123162624, 1073741824] didn't find the relative chunk.
super bytes used 14180042272768 mismatches actual used 14180042223616


Ok to continue?
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
