Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8114BD643
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Feb 2022 07:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245364AbiBUGhy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Feb 2022 01:37:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344581AbiBUGhx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Feb 2022 01:37:53 -0500
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90675388
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Feb 2022 22:37:30 -0800 (PST)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 52545203A3A; Mon, 21 Feb 2022 01:37:29 -0500 (EST)
Date:   Mon, 21 Feb 2022 01:37:29 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     ov 2k <ov2k.github@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: FIDEDUPERANGE and compression
Message-ID: <YhMzKeX3FvJPvtmR@hungrycats.org>
References: <CADwZqEvZQmwnY7e5LcUmgQ7EMmMx1XV-znnQMJG3D_fKtpDcdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADwZqEvZQmwnY7e5LcUmgQ7EMmMx1XV-znnQMJG3D_fKtpDcdw@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 18, 2022 at 10:14:20PM -0500, ov 2k wrote:
> FIDEDUPERANGE does not seem to behave as expected with compressible
> data on a btrfs volume with compression enabled, at least with small
> adjacent FIDEDUPERANGE requests.  I've attached a basic test case.  It
> writes two short identical files and calls FIDEDUPERANGE three times,
> on the thirds of the file, in order.  filefrag -v reports that the
> destination file has three extents that each reference the first third
> of the source file.
> 
> To be clear, the data in the destination file remains correct.
> However, the second and third FIDEDUPERANGE calls do not seem to cause
> the destination file to reference the expected source extents.  I'm
> not actually certain whether this is a bug in FIDEDUPERANGE or
> FS_IOC_FIEMAP or something deeper within btrfs itself.

FIEMAP's output cannot correctly represent btrfs compressed data.
In some cases you may be able to identify logical blocks as belonging
to the same underlying compressed extent, but not with enough precision
to infer data content of the blocks.

The physical location of a compressed byte is a two-dimensional
quantity--one to identify the physical compressed extent, one to identify
the byte's offset within the decompressed data.  The length is similarly
two-dimensional, one for the physical size and one for the logical size.
Since compressed bytes are a different size unit than uncompressed bytes,
we can't add a compressed offset or length to a physical position and
get a number that isn't garbage, so we can't fill in distinct values
for physical location of compressed data blocks that make numerical sense.

Try 'btrfs-search-metadata file' (from the python-btrfs package) for
an accurate description of what's going on with the extent references.
It uses TREE_SEARCH_V2 and the underlying btrfs file extent reference
structure, which has the fields that FIEMAP is missing.

Underneath, the compressed extent is an immutable contiguous region of
storage, identified by the bytenr (virtual address) of the first byte
of the storage.  Each reference to the extent in the file refers to a
contiguous range of the extent's logical blocks (after decompression).
The fields are, in no particular order:

	1. the logical offset within the file (seek offset) where
	the referenced data appears in the file

	2. the extent bytenr (extent identifier for reference counting
	and backref search, first physical byte of the extent)

	3. the logical length of the referenced data (the portion
	of the compressed data referenced at this offset in the file)

	4. the logical offset within the extent where the referenced
	data begins (after decompressing the extent, where to start
	reading the data in memory)

	5. the physical (compressed) length of the complete extent data
	(how many bytes are used in physical storage)

	6. the logical (decompressed) length of the complete extent data
	(how much RAM is required to decompress the extent)

Only the first three of these fields are available via FIEMAP.  FIEMAP
provides only one length field, so it can't handle compressed extents
which have two distinct lengths.  FIEMAP provides only one integer for
physical position, so it can't handle references to blocks that are
not the first block in a compressed extent.

TREE_SEARCH_V2 provides all six fields, so you can get accurate logical or
physical extent boundary information as needed.

In simple write() cases, the offset fields are zero, so FIEMAP appears to
work at first:

	1. seek offset is some number, FIEMAP returns that number

	2. extent bytenr is the FIEMAP physical start of extent

	3. logical length of the referenced data (#3) is the same as
	the logical decompressed length (#6).  FIEMAP gives #3.
	This value will change if the extent is partially overwritten
	in the file.

	4. logical offset within the extent is 0, since the extent
	was created for exactly this file data reference

	5. physical length of the compressed extent isn't reported in
	FIEMAP.  Tools like 'filefrag -v' which try to compute extent
	boundary adjacency won't work--they will use the length in #3
	when they should use field #2 + #5 to compute physical extent
	end boundaries.

	6. logical length of the compressed extent is the same as #3.
	This value never changes until the extent is destroyed.

In the test case, FIEMAP reports the same number at #2 for all extents
since the same physical extent is referenced, but the referenced data
location is actually a function of fields #2 and #4.  The second and
third extents have non-zero offsets for #4, and the length at #3 becomes
different from the length at #6, making any computed values based on
these fields nonsense.
