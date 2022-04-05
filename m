Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFBF4F479B
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 01:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349268AbiDEVOP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Apr 2022 17:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359250AbiDEUQp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 16:16:45 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CE7B1896
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 12:59:02 -0700 (PDT)
Received: from merlin by mail1.merlins.org with local (Exim 4.94.2 #2)
        id 1nbpKP-0004Xt-Lx by authid <merlin>; Tue, 05 Apr 2022 12:59:01 -0700
Date:   Tue, 5 Apr 2022 12:59:01 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220405195901.GC28707@merlins.org>
References: <CAEzrpqdjLn51R++iX0_7-MRbxoNo7HL5GZFs4399KV6=RO3cyQ@mail.gmail.com>
 <20220405020729.GH5566@merlins.org>
 <CAEzrpqd6kePW6eiMB-R4DvMRvU=AK-jKpkBNUvSjttsSEsCwpA@mail.gmail.com>
 <20220405155311.GJ5566@merlins.org>
 <CAEzrpqehq1tt5O_6jarggYK4dvyWCJ8O=_ps_qXuQbVJ9_bC6g@mail.gmail.com>
 <CAEzrpqdjTRc2VQBGGRB3Dcsk=BzN2ru-fA2=fMz__QnFubR7VQ@mail.gmail.com>
 <20220405181108.GA28707@merlins.org>
 <CAEzrpqc=h2A42nnHzeo_DwHik8Lu0xfkuNm2mhd=Ygams6aj=w@mail.gmail.com>
 <20220405195157.GA3307770@merlins.org>
 <CAEzrpqeQ=Q8u+Kgy6r+axYdbrZKs9=9cvMwEfKr=O2urgZTXHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqeQ=Q8u+Kgy6r+axYdbrZKs9=9cvMwEfKr=O2urgZTXHw@mail.gmail.com>
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

On Tue, Apr 05, 2022 at 03:56:31PM -0400, Josef Bacik wrote:
> On Tue, Apr 5, 2022 at 3:51 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Tue, Apr 05, 2022 at 02:36:29PM -0400, Josef Bacik wrote:
> > > > Couldn't read chunk tree
> > > > WTF???
> > > > ERROR: open ctree failed
> > >
> > > That's new, the chunk tree wasn't failing before right?  Anyway I
> > > pushed a change, it should work now, thanks,
> >
> > It failed for one commands we did before:
> >  ./btrfs inspect-internal dump-tree -t ROOT /dev/mapper/dshelf1a
> > btrfs-progs v5.16.2
> > parent transid verify failed on 22216704 wanted 1600938 found 1602177
> > parent transid verify failed on 22216704 wanted 1600938 found 1602177
> > Couldn't read chunk tree
> >
> 
> Ok I think this is from you redirecting into your device, can you do
 
Sorry for being an idiot.

> btrfs inspect-internal dump-super -s 0
> btrfs inspect-internal dump-super -s 1
> 
> and see if they're different?  We may have to put your old super back.  Thanks,

gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs inspect-internal dump-super -s 0 /dev/mapper/dshelf1a > /tmp/0
gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs inspect-internal dump-super -s 1 /dev/mapper/dshelf1a > /tmp/1
gargamel:/var/local/src/btrfs-progs-josefbacik# diff -u /tmp/[01]
--- /tmp/0	2022-04-05 12:58:11.757530345 -0700
+++ /tmp/1	2022-04-05 12:58:14.769452304 -0700
@@ -1,27 +1,27 @@
-superblock: bytenr=65536, device=/dev/mapper/dshelf1a
+superblock: bytenr=67108864, device=/dev/mapper/dshelf1a
 ---------------------------------------------------------
 csum_type		0 (crc32c)
 csum_size		4
-csum			0xd3d00183 [match]
-bytenr			65536
+csum			0x70d015f7 [match]
+bytenr			67108864
 flags			0x1
 			( WRITTEN )
 magic			_BHRfS_M [match]
 fsid			96539b8c-ccc9-47bf-9e6c-29305890941e
 metadata_uuid		96539b8c-ccc9-47bf-9e6c-29305890941e
 label			dshelf1
-generation		1602089
-root			13577814573056
+generation		1602298
+root			15645253091328
 sys_array_size		129
-chunk_root_generation	1600938
+chunk_root_generation	1602203
 root_level		1
-chunk_root		21069824
+chunk_root		21479424
 chunk_root_level	1
 log_root		0
 log_root_transid	0
 log_root_level		0
 total_bytes		24004156973056
-bytes_used		15113376952320
+bytes_used		15144801386496
 sectorsize		4096
 nodesize		16384
 leafsize (deprecated)	16384
@@ -36,13 +36,13 @@
 			  BIG_METADATA |
 			  EXTENDED_IREF |
 			  SKINNY_METADATA )
-cache_generation	1602089
-uuid_tree_generation	1602089
+cache_generation	1602298
+uuid_tree_generation	1602298
 dev_item.uuid		8d4b0f25-0de9-47a6-a993-bdd301287f30
 dev_item.fsid		96539b8c-ccc9-47bf-9e6c-29305890941e [match]
 dev_item.type		0
 dev_item.total_bytes	24004156973056
-dev_item.bytes_used	15178439589888
+dev_item.bytes_used	15184882040832
 dev_item.io_align	4096
 dev_item.io_width	4096
 dev_item.sector_size	4096

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
