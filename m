Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2456E522826
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 May 2022 02:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbiEKAIW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 20:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiEKAIR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 20:08:17 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D6F29821
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 17:08:16 -0700 (PDT)
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:58518 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1noZtn-0007Sp-MN by authid <merlins.org> with srv_auth_plain; Tue, 10 May 2022 17:08:15 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1noZtn-001iDX-Fb; Tue, 10 May 2022 17:08:15 -0700
Date:   Tue, 10 May 2022 17:08:15 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220511000815.GK12542@merlins.org>
References: <CAEzrpqft3qwSdNYsNbjXDZmjO8Kg2L4zoo8qJzbnCcEDT3tMRA@mail.gmail.com>
 <20220510021916.GB12542@merlins.org>
 <CAEzrpqf9hy0_oZm8kQMK9PwESFcey0aOO3LUFTMDsCP+9t2JRQ@mail.gmail.com>
 <20220510143739.GC12542@merlins.org>
 <CAEzrpqf7As9tL28+Rb1kVqeO4G=MqBPQw0fKF6Mwa=_4fzsjSQ@mail.gmail.com>
 <20220510160600.GG12542@merlins.org>
 <CAEzrpqfYJDPdxxrw9TMFdF9GacYKMwc8=yFB6wt3=TMDt6Bung@mail.gmail.com>
 <20220510164448.GI12542@merlins.org>
 <20220510211507.GJ12542@merlins.org>
 <CAEzrpqe41JYFKE2tZFjgZ4V_YqO+K8m4nzF=R3Sti6hgv5snuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqe41JYFKE2tZFjgZ4V_YqO+K8m4nzF=R3Sti6hgv5snuQ@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 10, 2022 at 07:38:37PM -0400, Josef Bacik wrote:
> On Tue, May 10, 2022 at 5:15 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > I have
> > ./btrfs check --repair /dev/mapper/dshelf1
> > on hold (^Z), waiting for your ok to proceed.
> >
> > All good to continue?
> 
> Hold on I'm looking at the code, I'm very confused, we shouldn't be
> finding any extent tree errors at this point.  Let me work out what's
> going on.  Thanks,

Ok.

I ran check without repair, at least it completed. 2.5 million lines of output
but I think they mostly look like this

Opening filesystem to check...
FS_INFO IS 0x555b2100de50
JOSEF: root 9
Couldn't find the last root for 8
FS_INFO AFTER IS 0x555b2100de50
Checking filesystem on /dev/mapper/dshelf1
UUID: 96539b8c-ccc9-47bf-9e6c-29305890941e
[1/7] checking root items
checksum verify failed on 15645954129920 wanted 0x085fc24a found 0x941acdde
checksum verify failed on 15645954195456 wanted 0x6c1c72a4 found 0xb06d5dd9
checksum verify failed on 15645608116224 wanted 0x31706547 found 0x314fad1d
checksum verify failed on 15645262413824 wanted 0x3affbd35 found 0x96d53d25
checksum verify failed on 13577199878144 wanted 0x6e9e8bc6 found 0x61063457
checksum verify failed on 13577399156736 wanted 0x2869b8c7 found 0xbb1119e1
checksum verify failed on 12512437698560 wanted 0xca43b3f8 found 0xd7f6db69
checksum verify failed on 13577503686656 wanted 0xd81b7702 found 0x95a3c9a6
checksum verify failed on 15645781344256 wanted 0xb81e3df4 found 0xb5c70846
checksum verify failed on 13577178939392 wanted 0x2cb83118 found 0x63f0b6bf
checksum verify failed on 15645419667456 wanted 0xde0dab28 found 0x3ceddd16
checksum verify failed on 13577821011968 wanted 0x9a29aff5 found 0x2cdff391
checksum verify failed on 15645781196800 wanted 0xef669b11 found 0x46985a93
[2/7] checking extents
checksum verify failed on 364637798400 wanted 0xc3ba5144 found 0x30a5fff1
checksum verify failed on 364637962240 wanted 0x91d33e8a found 0x00890be7
checksum verify failed on 11970891186176 wanted 0x6b46adfb found 0xe40e4cbe
(...)
Device extent[1, 11416060821504, 1073741824] didn't find the relative chunk.
Device extent[1, 11422503272448, 1073741824] didn't find the relative chunk.
Device extent[1, 10616123162624, 1073741824] didn't find the relative chunk.
data backref 743381753856 parent 782895169536 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 743381753856 parent 782895169536 owner 0 offset 0 found 1 wanted 0 back 0x555b2d253630
incorrect local backref count on 743381753856 root 11222 owner 55083 offset 31752192 found 0 wanted 1 back 0x555b2d4b1bf0
backref disk bytenr does not match extent record, bytenr=743381753856, ref bytenr=0
backpointer mismatch on [743381753856 24576]
data backref 743382028288 parent 11651792814080 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 743382028288 parent 11651792814080 owner 0 offset 0 found 1 wanted 0 back 0x555b2d3d6b30
incorrect local backref count on 743382028288 root 11222 owner 55241 offset 917504 found 0 wanted 1 back 0x555b2d4b1eb0
backref disk bytenr does not match extent record, bytenr=743382028288, ref bytenr=0
backpointer mismatch on [743382028288 12288]
data backref 743382425600 parent 11822453374976 owner 0 offset 0 num_refs 0 not found in extent tree
incorrect local backref count on 743382425600 parent 11822453374976 owner 0 offset 0 found 1 wanted 0 back 0x555b52540af0
incorrect local backref count on 743382425600 root 11222 owner 55259 offset 0 found 0 wanted 1 back 0x555b2d4b2d20
backref disk bytenr does not match extent record, bytenr=743382425600, ref bytenr=0
(...)
root 11223 inode 1403275 errors 1000, some csum missing
root 11223 inode 1403276 errors 1000, some csum missing
root 11223 inode 1403277 errors 1000, some csum missing
root 11223 inode 1403278 errors 1000, some csum missing
root 11223 inode 1403279 errors 1000, some csum missing
root 11223 inode 1403280 errors 1000, some csum missing
root 11223 inode 1403281 errors 1500, file extent discount, nbytes wrong, some csum missing
Found file extent holes:
        start: 8192, len: 4096
root 11223 inode 1403282 errors 2001, no inode item, link count wrong
        unresolved ref dir 1403235 index 48 namelen 7 name spdif.h filetype 1 errors 4, no inode ref
root 11223 inode 1403283 errors 2001, no inode item, link count wrong
        unresolved ref dir 1403235 index 49 namelen 10 name speyside.c filetype 1 errors 4, no inode ref
root 11223 inode 1403284 errors 2001, no inode item, link count wrong
        unresolved ref dir 1403235 index 50 namelen 11 name tobermory.c filetype 1 errors 4, no inode ref
root 11223 inode 1403285 errors 2001, no inode item, link count wrong
        unresolved ref dir 1402760 index 19 namelen 2 name sh filetype 2 errors 4, no inode ref
root 11223 inode 1403291 errors 3000, some csum missing, link count wrong
        unresolved ref dir 1403285 index 7 namelen 12 name dma-sh7760.c filetype 0 errors 3, no dir item, no dir index
root 11223 inode 1403292 errors 3000, some csum missing, link count wrong
        unresolved ref dir 1403285 index 8 namelen 5 name fsi.c filetype 0 errors 3, no dir item, no dir index
root 11223 inode 1403293 errors 3000, some csum missing, link count wrong
        unresolved ref dir 1403285 index 9 namelen 5 name hac.c filetype 0 errors 3, no dir item, no dir index
root 11223 inode 1403294 errors 3000, some csum missing, link count wrong
        unresolved ref dir 1403285 index 10 namelen 7 name migor.c filetype 0 errors 3, no dir item, no dir index
root 11223 inode 1403295 errors 2000, link count wrong
        unresolved ref dir 1403285 index 11 namelen 13 name sh7760-ac97.c filetype 0 errors 3, no dir item, no dir index
root 11223 inode 1403296 errors 3000, some csum missing, link count wrong
        unresolved ref dir 1403285 index 12 namelen 5 name siu.h filetype 0 errors 3, no dir item, no dir index
root 11223 inode 1403297 errors 3000, some csum missing, link count wrong
        unresolved ref dir 1403285 index 13 namelen 9 name siu_dai.c filetype 0 errors 3, no dir item, no dir index
root 11223 inode 1403298 errors 3000, some csum missing, link count wrong
        unresolved ref dir 1403285 index 14 namelen 9 name siu_pcm.c filetype 0 errors 3, no dir item, no dir index
root 11223 inode 1403299 errors 3000, some csum missing, link count wrong
        unresolved ref dir 1403285 index 15 namelen 5 name ssi.c filetype 0 errors 3, no dir item, no dir index
root 11223 inode 1403301 errors 1000, some csum missing
root 11223 inode 1403302 errors 1000, some csum missing
root 11223 inode 1403303 errors 1000, some csum missing
root 11223 inode 1403304 errors 1000, some csum missing
root 11223 inode 1403305 errors 1000, some csum missing
(...)
root 165299 inode 95687 errors 1000, some csum missing
root 165299 inode 95688 errors 1000, some csum missing
root 165299 inode 95689 errors 1000, some csum missing
root 165299 inode 95690 errors 1000, some csum missing
root 165299 inode 95692 errors 1000, some csum missing
root 165299 inode 95697 errors 1000, some csum missing
root 165299 inode 95698 errors 1000, some csum missing
root 165299 inode 95699 errors 3000, some csum missing, link count wrong
        unresolved ref dir 76854 index 28 namelen 23 name gmapsupp_micronesia.img filetype 1 errors 3, no dir item, no dir index
root 165299 inode 95700 errors 1000, some csum missing
root 165299 inode 95701 errors 3000, some csum missing, link count wrong
        unresolved ref dir 76854 index 30 namelen 24 name gmapsupp_osm_NZ_Topo.img filetype 1 errors 3, no dir item, no dir index
root 165299 inode 95702 errors 1000, some csum missing
root 165299 inode 95703 errors 3000, some csum missing, link count wrong
        unresolved ref dir 76854 index 32 namelen 19 name gmapsupp_osm_AK.img filetype 1 errors 3, no dir item, no dir index
root 165299 inode 95704 errors 1000, some csum missing
root 165299 inode 95705 errors 1000, some csum missing
ERROR: errors found in fs roots
found 14180032409600 bytes used, error(s) found
total csum bytes: 0
total tree bytes: 2083700736
total fs tree bytes: 1891270656
total extent tree bytes: 188317696
btree space waste bytes: 334201707
file data blocks allocated: 14814349185024
 referenced 14828266401792


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
