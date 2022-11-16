Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B41862B904
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 11:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiKPKhw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Nov 2022 05:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiKPKfo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 05:35:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0415C165A3
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 02:28:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B12BB81B92
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 10:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAD7C433B5;
        Wed, 16 Nov 2022 10:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668594531;
        bh=wDxf3WPNPPoRMnZ1O6ryfWS1HfUSGag38vrqlS/wYJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ReglaEQcglpBSf30EF9f96pimx9FksCawl8wUwHG9hHJCNXizORzOqTvUfM71Qk8x
         c7CsIKIchuj86Rr1HgSMqVFVuTaL0PovhvVCyOTb3YsSEdqN6KC1R54ZfwKfFeXu6Z
         IBa54SCr7NLj19MWWNJtv8QVMh80dvierS+2WiQfYIcOTPcAgaFhE9S6FI2pJMCa5C
         sR38LkZqZs51e2O8FvRTQQHP3yaaO4JrqRYFF3Itr9WnFuSF6odZPnK5/23zWEZ9y9
         tduZNceVTwpHWlgmMh1yPLTCh6iT//F+sOFkxwIBA7RVZJYarXpKKesU1zbiG9+9Q9
         T5Wk75GYuUNDw==
Date:   Wed, 16 Nov 2022 10:28:48 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: avoid unaligned encoded writes when
 attempting to clone range
Message-ID: <20221116102848.GA85999@falcondesktop>
References: <1eb4a70a884ed958177a5164aadd11f9a1d8ac52.1668529729.git.fdmanana@suse.com>
 <Y3QIi+7mn2HD7tfT@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3QIi+7mn2HD7tfT@zen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 01:45:47PM -0800, Boris Burkov wrote:
> On Tue, Nov 15, 2022 at 04:29:44PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > When trying to see if we can clone a file range, there are cases where we
> > end up sending two write operations in case the inode from the source root
> > has an i_size that is not sector size aligned and the length from the
> > current offset to its i_size is less than the remaining length we are
> > trying to clone.
> > 
> > Issuing two write operations when we could instead issue a single write
> > operation is not incorrect. However it is not optimal, specially if the
> > extents are compressed and the flag BTRFS_SEND_FLAG_COMPRESSED was passed
> > to the send ioctl. In that case we can end up sending an encoded write
> > with an offset that is not sector size aligned, which makes the receiver
> > fallback to decompressing the data and writing it using regular buffered
> > IO (so re-compressing the data in case the fs is mounted with compression
> > enabled), because encoded writes fail with -EINVAL when an offset is not
> > sector size aligned.
> > 
> > The following example, which triggered a bug in the receiver code for the
> > fallback logic of decompressing + regular buffer IO and is fixed by the
> > patchset referred in a Link at the bottom of this changelog, is an example
> > where we have the non-optimal behaviour due to an unaligned encoded write:
> > 
> >    $ cat test.sh
> >    #!/bin/bash
> > 
> >    DEV=/dev/sdj
> >    MNT=/mnt/sdj
> > 
> >    mkfs.btrfs -f $DEV > /dev/null
> >    mount -o compress $DEV $MNT
> > 
> 
> Nice fix, confirmed that it works for me.

Not exactly a fix, I see it more as a performance improvement.

It works around the bug in receive for this type of scenario, but the real bug
is the fallback code at the receiver, plus there are more cases where it needs
to fallback to decompression + write, like passing --force-decompress to receive
or the kernel at the receiver simply doesn't support the encoded writes ioctl,
as well as a few more cases.

> 
> FWIW, I was curious if this fix would result in the "opposite" problem
> if you reflinked less than the full file and needed to finish the loop
> to get the next big chunk to be aligned. But reflink fails if the end
> is not aligned, so every variant I tried with foo size = 32K and reflink
> reflink size <32K worked in a good, predictable way resulting in encoded
> writes and such.
> 
> Would it make sense to add reflink + send/recv tests like this test.sh
> to fstests?  I can do it if you like the idea but don't have time.

Yes, the goal is to add it to fstests, and I'll do it. In general if you
see me pasting a reproducer in a changelog, you can assume it will end up
in fstests sooner or later. Nowadays it's more later than sooner, as with
the new fstests maintainer things flow more slowly and the test should go
after the respective kernel patch is merged in Linus' tree, so there's some
delay.

Thanks.

> 
> >    # File foo has a size of 33K, not aligned to the sector size.
> >    xfs_io -f -c "pwrite -S 0xab 0 33K" $MNT/foo
> > 
> >    xfs_io -f -c "pwrite -S 0xcd 0 64K" $MNT/bar
> > 
> >    # Now clone the first 32K of file bar into foo at offset 0.
> >    xfs_io -c "reflink $MNT/bar 0 0 32K" $MNT/foo
> > 
> >    # Snapshot the default subvolume and create a full send stream (v2).
> >    btrfs subvolume snapshot -r $MNT $MNT/snap
> > 
> >    btrfs send --compressed-data -f /tmp/test.send $MNT/snap
> > 
> >    echo -e "\nFile bar in the original filesystem:"
> >    od -A d -t x1 $MNT/snap/bar
> > 
> >    umount $MNT
> >    mkfs.btrfs -f $DEV > /dev/null
> >    mount $DEV $MNT
> > 
> >    echo -e "\nReceiving stream in a new filesystem..."
> >    btrfs receive -f /tmp/test.send $MNT
> > 
> >    echo -e "\nFile bar in the new filesystem:"
> >    od -A d -t x1 $MNT/snap/bar
> > 
> >    umount $MNT
> > 
> > Before this patch, the send stream included one regular write and one
> > encoded write for file 'bar', with the later being not sector size aligned
> > and causing the receiver to fallback to decompression + buffered writes.
> > The output of the btrfs receive command in verbose mode (-vvv):
> > 
> >    (...)
> >    mkfile o258-7-0
> >    rename o258-7-0 -> bar
> >    utimes
> >    clone bar - source=foo source offset=0 offset=0 length=32768
> >    write bar - offset=32768 length=1024
> >    encoded_write bar - offset=33792, len=4096, unencoded_offset=33792, unencoded_file_len=31744, unencoded_len=65536, compression=1, encryption=0
> >    encoded_write bar - falling back to decompress and write due to errno 22 ("Invalid argument")
> >    (...)
> > 
> > This patch avoids the regular write followed by an unaligned encoded write
> > so that we end up sending a single encoded write that is aligned. So after
> > this patch the stream content is (output of btrfs receive -vvv):
> > 
> >    (...)
> >    mkfile o258-7-0
> >    rename o258-7-0 -> bar
> >    utimes
> >    clone bar - source=foo source offset=0 offset=0 length=32768
> >    encoded_write bar - offset=32768, len=4096, unencoded_offset=32768, unencoded_file_len=32768, unencoded_len=65536, compression=1, encryption=0
> >    (...)
> > 
> > So we get more optimal behaviour and avoid the silent data loss bug in
> > versions of btrfs-progs affected by the bug referred by the Link tag
> > below (btrfs-progs v5.19, v5.19.1, v6.0 and v6.0.1).
> > 
> > Link: https://lore.kernel.org/linux-btrfs/cover.1668529099.git.fdmanana@suse.com/
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Reviewed-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/send.c | 24 +++++++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> > index 6950d3f9cbc1..5a00d08c8300 100644
> > --- a/fs/btrfs/send.c
> > +++ b/fs/btrfs/send.c
> > @@ -5935,6 +5935,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
> >  		u64 ext_len;
> >  		u64 clone_len;
> >  		u64 clone_data_offset;
> > +		bool crossed_src_i_size = false;
> >  
> >  		if (slot >= btrfs_header_nritems(leaf)) {
> >  			ret = btrfs_next_leaf(clone_root->root, path);
> > @@ -5992,8 +5993,10 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
> >  		if (key.offset >= clone_src_i_size)
> >  			break;
> >  
> > -		if (key.offset + ext_len > clone_src_i_size)
> > +		if (key.offset + ext_len > clone_src_i_size) {
> >  			ext_len = clone_src_i_size - key.offset;
> > +			crossed_src_i_size = true;
> > +		}
> >  
> >  		clone_data_offset = btrfs_file_extent_offset(leaf, ei);
> >  		if (btrfs_file_extent_disk_bytenr(leaf, ei) == disk_byte) {
> > @@ -6054,6 +6057,25 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
> >  				ret = send_clone(sctx, offset, clone_len,
> >  						 clone_root);
> >  			}
> > +		} else if (crossed_src_i_size && clone_len < len) {
> > +			/*
> > +			 * If we are at i_size of the clone source inode and we
> > +			 * can not clone from it, terminate the loop. This is
> > +			 * to avoid sending two write operations, one with a
> > +			 * length matching clone_len and the final one after
> > +			 * this loop with a length of len - clone_len.
> > +			 *
> > +			 * When using encoded writes (BTRFS_SEND_FLAG_COMPRESSED
> > +			 * was passed to the send ioctl), this helps avoid
> > +			 * sending an encoded write for an offset that is not
> > +			 * sector size aligned, in case the i_size of the source
> > +			 * inode is not sector size aligned. That will make the
> > +			 * receiver fallback to decompression of the data and
> > +			 * writing it using regular buffered IO, therefore while
> > +			 * not incorrect, it's not optimal due decompression and
> > +			 * possible re-compression at the receiver.
> > +			 */
> > +			break;
> >  		} else {
> >  			ret = send_extent_data(sctx, dst_path, offset,
> >  					       clone_len);
> > -- 
> > 2.35.1
> > 
