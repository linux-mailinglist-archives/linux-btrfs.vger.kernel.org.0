Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30C14CE8C6
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Mar 2022 05:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiCFEpI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Mar 2022 23:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiCFEpH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Mar 2022 23:45:07 -0500
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3A473FDBA
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Mar 2022 20:44:15 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 2C58F23657B; Sat,  5 Mar 2022 23:44:14 -0500 (EST)
Date:   Sat, 5 Mar 2022 23:44:14 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     ov2k <ov2k.github@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: FIDEDUPERANGE and compression
Message-ID: <YiQ8HgWVNAnBFjVj@hungrycats.org>
References: <CADwZqEvZQmwnY7e5LcUmgQ7EMmMx1XV-znnQMJG3D_fKtpDcdw@mail.gmail.com>
 <YhMzKeX3FvJPvtmR@hungrycats.org>
 <CADwZqEts39gdoLKCN2t18UByo_WnLmoRPCbja61wVwSt3wvuhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADwZqEts39gdoLKCN2t18UByo_WnLmoRPCbja61wVwSt3wvuhQ@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 21, 2022 at 05:31:13PM -0500, ov2k wrote:
> It looks like btrfs coalesces adjacent uncompressed extents.  I'm not
> sure whether this is done by FIDEDUPERANGE or FS_IOC_FIEMAP.  I think
> the problem is that adjacent decompressed ranges (defined by #3 and
> #4) within the same compressed block are not coalesced in a similar
> manner.  Is there a particular reason why this isn't done, or is this
> simply a case of nobody having done it?

It hasn't been done because FIEMAP can't produce results for compressed
extents that aren't nonsense.  The interface can't cope with compressed
data.

Adjacent compressed extents occur when all of the following are true:

	first extent #3 (decompressed start offset) + #4 (decompressed
	logical length) == #6 (end of decompressed extent)

	second extent #3 (decompressed start offset) = 0 (beginning
	of decompressed extent)

	first extent #2 (physical start offset) + #5 (physical compressed
	length) == second extent #2 (physical start offset)

FIEMAP doesn't have access to #5, so it can't evaluate that condition
(and neither can anything that uses FIEMAP).

Suppose you have two adjacent extents, 128K and 96K that are compressed
to 64K and 48K respectively.  They start at physical block 10000 at
offset 0 in the file.  Then:

	Extent 1 starts at physical 10000 and ends at 10063.
	Extent 1 starts at logical offset 0 and ends at 127.

	Extent 2 starts at physical 10064 and ends at 10111.
	Extent 2 starts at logical offset 128 and ends at 223.

FIEMAP reports:

	extent 1 physical 10000 offset 0 length 128
	extent 2 physical 10064 offset 128 length 48

How would you be able to determine from this information that these
extents are physically adjacent and contiguous?

Lets add extent 3 and 4:

	Extent 3 starts at physical 10112 and ends at 10127.
	Extent 3 starts at logical offset 224 and ends at 239.

	Extent 4 starts at physical 10128 and ends at 10127.
	Extent 4 starts at logical offset 240 and ends at 255.

FIEMAP reports:

	extent 1 physical 10000 offset 0 length 128
	extent 2 physical 10064 offset 128 length 48
	extent 3 physical 10112 offset 224 length 16
	extent 4 physical 10128 offset 240 length 16

How would you be able to determine extents 1 and 4 are _not_ physically
adjacent?

> On Mon, Feb 21, 2022 at 1:37 AM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > On Fri, Feb 18, 2022 at 10:14:20PM -0500, ov 2k wrote:
> > > FIDEDUPERANGE does not seem to behave as expected with compressible
> > > data on a btrfs volume with compression enabled, at least with small
> > > adjacent FIDEDUPERANGE requests.  I've attached a basic test case.  It
> > > writes two short identical files and calls FIDEDUPERANGE three times,
> > > on the thirds of the file, in order.  filefrag -v reports that the
> > > destination file has three extents that each reference the first third
> > > of the source file.
> > >
> > > To be clear, the data in the destination file remains correct.
> > > However, the second and third FIDEDUPERANGE calls do not seem to cause
> > > the destination file to reference the expected source extents.  I'm
> > > not actually certain whether this is a bug in FIDEDUPERANGE or
> > > FS_IOC_FIEMAP or something deeper within btrfs itself.
> >
> > FIEMAP's output cannot correctly represent btrfs compressed data.
> > In some cases you may be able to identify logical blocks as belonging
> > to the same underlying compressed extent, but not with enough precision
> > to infer data content of the blocks.
> >
> > The physical location of a compressed byte is a two-dimensional
> > quantity--one to identify the physical compressed extent, one to identify
> > the byte's offset within the decompressed data.  The length is similarly
> > two-dimensional, one for the physical size and one for the logical size.
> > Since compressed bytes are a different size unit than uncompressed bytes,
> > we can't add a compressed offset or length to a physical position and
> > get a number that isn't garbage, so we can't fill in distinct values
> > for physical location of compressed data blocks that make numerical sense.
> >
> > Try 'btrfs-search-metadata file' (from the python-btrfs package) for
> > an accurate description of what's going on with the extent references.
> > It uses TREE_SEARCH_V2 and the underlying btrfs file extent reference
> > structure, which has the fields that FIEMAP is missing.
> >
> > Underneath, the compressed extent is an immutable contiguous region of
> > storage, identified by the bytenr (virtual address) of the first byte
> > of the storage.  Each reference to the extent in the file refers to a
> > contiguous range of the extent's logical blocks (after decompression).
> > The fields are, in no particular order:
> >
> >         1. the logical offset within the file (seek offset) where
> >         the referenced data appears in the file
> >
> >         2. the extent bytenr (extent identifier for reference counting
> >         and backref search, first physical byte of the extent)
> >
> >         3. the logical length of the referenced data (the portion
> >         of the compressed data referenced at this offset in the file)
> >
> >         4. the logical offset within the extent where the referenced
> >         data begins (after decompressing the extent, where to start
> >         reading the data in memory)
> >
> >         5. the physical (compressed) length of the complete extent data
> >         (how many bytes are used in physical storage)
> >
> >         6. the logical (decompressed) length of the complete extent data
> >         (how much RAM is required to decompress the extent)
> >
> > Only the first three of these fields are available via FIEMAP.  FIEMAP
> > provides only one length field, so it can't handle compressed extents
> > which have two distinct lengths.  FIEMAP provides only one integer for
> > physical position, so it can't handle references to blocks that are
> > not the first block in a compressed extent.
> >
> > TREE_SEARCH_V2 provides all six fields, so you can get accurate logical or
> > physical extent boundary information as needed.
> >
> > In simple write() cases, the offset fields are zero, so FIEMAP appears to
> > work at first:
> >
> >         1. seek offset is some number, FIEMAP returns that number
> >
> >         2. extent bytenr is the FIEMAP physical start of extent
> >
> >         3. logical length of the referenced data (#3) is the same as
> >         the logical decompressed length (#6).  FIEMAP gives #3.
> >         This value will change if the extent is partially overwritten
> >         in the file.
> >
> >         4. logical offset within the extent is 0, since the extent
> >         was created for exactly this file data reference
> >
> >         5. physical length of the compressed extent isn't reported in
> >         FIEMAP.  Tools like 'filefrag -v' which try to compute extent
> >         boundary adjacency won't work--they will use the length in #3
> >         when they should use field #2 + #5 to compute physical extent
> >         end boundaries.
> >
> >         6. logical length of the compressed extent is the same as #3.
> >         This value never changes until the extent is destroyed.
> >
> > In the test case, FIEMAP reports the same number at #2 for all extents
> > since the same physical extent is referenced, but the referenced data
> > location is actually a function of fields #2 and #4.  The second and
> > third extents have non-zero offsets for #4, and the length at #3 becomes
> > different from the length at #6, making any computed values based on
> > these fields nonsense.
