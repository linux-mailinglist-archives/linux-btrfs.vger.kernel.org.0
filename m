Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B4562A467
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 22:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiKOVp4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 16:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiKOVpy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 16:45:54 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4B2AE75
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 13:45:52 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 2570432009B3;
        Tue, 15 Nov 2022 16:45:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 15 Nov 2022 16:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668548749; x=1668635149; bh=mfkXEqCKRm
        dKebgqwYLZsioHxKBGkN1gDBb6/kyLCzI=; b=lRJ9+DJhouiQ6Y5Bw+4CudU48q
        G9iqWv1tFdb5I8CfiGv0f9Ci7dPoRY+q8g0lBfqF8yVqwyCJSEdMwFj8v8PVDOk0
        dS4aug7XcRXIEQCUCihd+8oo3aaNfPek2CKzHsHAebtlIhDZE/gBAZdvbby8GBpc
        8x3s7JU1+mU1cAqtsPQXYYtMkbJrOrWHWB5TU0tTC+RdscsstYizSj/PDMQ+/I3E
        ZxNDetQXubL0avZ8dI4fTjsvGFOVBnPVHCplsnezqqUYzOvvZVRAGcrpMEAuHnDl
        Knq5qVyr84n0E4jR2w/+YJTCfSVEO3F7n/0d2XBYpYw2D0Ky9E9eK+yoahYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668548749; x=1668635149; bh=mfkXEqCKRmdKebgqwYLZsioHxKBG
        kN1gDBb6/kyLCzI=; b=BvayyRgjppJSdqjWqcSRIRxblA9CusARJm0AiNrUCk8g
        3Y3lMND8agzrPkCcdDBbYJdvQCVFE2irkxdLsqax1AiFWcBYt7U4pIwNGD8tlLp8
        rlJYyWKXlnGdSvBBeAqThoAqkaBzZYX62JiCSVLl/uDOs82+GWOhsE59bubKXpXK
        mhlXaY5j8CLLjV8UujDue3JRGJfjPSXM2PmiFdRczoBN2E1oTXpOkr9PkbAQ7cXz
        3uSTK8A/Vf+NRlU4Vla2Uv2jLc1sfYTzdc6KPRgth69Xe4yF54HMEiBzG7AqozvA
        +26lXqhpxVL4JGYX5osYD0tD6a9C/x5KSDEoqHSqnw==
X-ME-Sender: <xms:jQh0Y_9Feg39hY5pu0Smj2UGhG0k9GTvq4P2QHohHT6ED1qIgsQy4g>
    <xme:jQh0Y7sD_YjkiWMiUW0W2mlOXoS1FIIWsl4PnZ6dsR1FMf8H8JB0IBuDHddX5Nrvf
    egaD36FMG6DGbRUaFY>
X-ME-Received: <xmr:jQh0Y9Dw2DYTS8CkCP3VaCOxyA9qlHyPZ8e4ntTHFjtPs1PqEzsvNozg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeeggdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhephedthfevgffhtdevgffhlefhgfeuueegtdevud
    eiheeiheetleeghedvfeegfeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:jQh0Y7fUXOej37bzDbasdzmnP6ABQknzsbLC9eI2LhikxNWfKPtTzQ>
    <xmx:jQh0Y0PAmvDvBJl1xoQ9EomCLgfFfVsSWb8ripeLhCnmjCxikvKrbQ>
    <xmx:jQh0Y9mqSlP0_wGv9PdijNkOIzm0vnVpjLUOPp2M4g0F78fJuMAYdA>
    <xmx:jQh0Y-VX5fVMupxYercUKf9bJDOQjnAHAXJ--XBTBa9sK-YRMN6f_w>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Nov 2022 16:45:49 -0500 (EST)
Date:   Tue, 15 Nov 2022 13:45:47 -0800
From:   Boris Burkov <boris@bur.io>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: avoid unaligned encoded writes when
 attempting to clone range
Message-ID: <Y3QIi+7mn2HD7tfT@zen>
References: <1eb4a70a884ed958177a5164aadd11f9a1d8ac52.1668529729.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb4a70a884ed958177a5164aadd11f9a1d8ac52.1668529729.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 04:29:44PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When trying to see if we can clone a file range, there are cases where we
> end up sending two write operations in case the inode from the source root
> has an i_size that is not sector size aligned and the length from the
> current offset to its i_size is less than the remaining length we are
> trying to clone.
> 
> Issuing two write operations when we could instead issue a single write
> operation is not incorrect. However it is not optimal, specially if the
> extents are compressed and the flag BTRFS_SEND_FLAG_COMPRESSED was passed
> to the send ioctl. In that case we can end up sending an encoded write
> with an offset that is not sector size aligned, which makes the receiver
> fallback to decompressing the data and writing it using regular buffered
> IO (so re-compressing the data in case the fs is mounted with compression
> enabled), because encoded writes fail with -EINVAL when an offset is not
> sector size aligned.
> 
> The following example, which triggered a bug in the receiver code for the
> fallback logic of decompressing + regular buffer IO and is fixed by the
> patchset referred in a Link at the bottom of this changelog, is an example
> where we have the non-optimal behaviour due to an unaligned encoded write:
> 
>    $ cat test.sh
>    #!/bin/bash
> 
>    DEV=/dev/sdj
>    MNT=/mnt/sdj
> 
>    mkfs.btrfs -f $DEV > /dev/null
>    mount -o compress $DEV $MNT
> 

Nice fix, confirmed that it works for me.

FWIW, I was curious if this fix would result in the "opposite" problem
if you reflinked less than the full file and needed to finish the loop
to get the next big chunk to be aligned. But reflink fails if the end
is not aligned, so every variant I tried with foo size = 32K and reflink
reflink size <32K worked in a good, predictable way resulting in encoded
writes and such.

Would it make sense to add reflink + send/recv tests like this test.sh
to fstests?  I can do it if you like the idea but don't have time.

>    # File foo has a size of 33K, not aligned to the sector size.
>    xfs_io -f -c "pwrite -S 0xab 0 33K" $MNT/foo
> 
>    xfs_io -f -c "pwrite -S 0xcd 0 64K" $MNT/bar
> 
>    # Now clone the first 32K of file bar into foo at offset 0.
>    xfs_io -c "reflink $MNT/bar 0 0 32K" $MNT/foo
> 
>    # Snapshot the default subvolume and create a full send stream (v2).
>    btrfs subvolume snapshot -r $MNT $MNT/snap
> 
>    btrfs send --compressed-data -f /tmp/test.send $MNT/snap
> 
>    echo -e "\nFile bar in the original filesystem:"
>    od -A d -t x1 $MNT/snap/bar
> 
>    umount $MNT
>    mkfs.btrfs -f $DEV > /dev/null
>    mount $DEV $MNT
> 
>    echo -e "\nReceiving stream in a new filesystem..."
>    btrfs receive -f /tmp/test.send $MNT
> 
>    echo -e "\nFile bar in the new filesystem:"
>    od -A d -t x1 $MNT/snap/bar
> 
>    umount $MNT
> 
> Before this patch, the send stream included one regular write and one
> encoded write for file 'bar', with the later being not sector size aligned
> and causing the receiver to fallback to decompression + buffered writes.
> The output of the btrfs receive command in verbose mode (-vvv):
> 
>    (...)
>    mkfile o258-7-0
>    rename o258-7-0 -> bar
>    utimes
>    clone bar - source=foo source offset=0 offset=0 length=32768
>    write bar - offset=32768 length=1024
>    encoded_write bar - offset=33792, len=4096, unencoded_offset=33792, unencoded_file_len=31744, unencoded_len=65536, compression=1, encryption=0
>    encoded_write bar - falling back to decompress and write due to errno 22 ("Invalid argument")
>    (...)
> 
> This patch avoids the regular write followed by an unaligned encoded write
> so that we end up sending a single encoded write that is aligned. So after
> this patch the stream content is (output of btrfs receive -vvv):
> 
>    (...)
>    mkfile o258-7-0
>    rename o258-7-0 -> bar
>    utimes
>    clone bar - source=foo source offset=0 offset=0 length=32768
>    encoded_write bar - offset=32768, len=4096, unencoded_offset=32768, unencoded_file_len=32768, unencoded_len=65536, compression=1, encryption=0
>    (...)
> 
> So we get more optimal behaviour and avoid the silent data loss bug in
> versions of btrfs-progs affected by the bug referred by the Link tag
> below (btrfs-progs v5.19, v5.19.1, v6.0 and v6.0.1).
> 
> Link: https://lore.kernel.org/linux-btrfs/cover.1668529099.git.fdmanana@suse.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/send.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 6950d3f9cbc1..5a00d08c8300 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -5935,6 +5935,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
>  		u64 ext_len;
>  		u64 clone_len;
>  		u64 clone_data_offset;
> +		bool crossed_src_i_size = false;
>  
>  		if (slot >= btrfs_header_nritems(leaf)) {
>  			ret = btrfs_next_leaf(clone_root->root, path);
> @@ -5992,8 +5993,10 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
>  		if (key.offset >= clone_src_i_size)
>  			break;
>  
> -		if (key.offset + ext_len > clone_src_i_size)
> +		if (key.offset + ext_len > clone_src_i_size) {
>  			ext_len = clone_src_i_size - key.offset;
> +			crossed_src_i_size = true;
> +		}
>  
>  		clone_data_offset = btrfs_file_extent_offset(leaf, ei);
>  		if (btrfs_file_extent_disk_bytenr(leaf, ei) == disk_byte) {
> @@ -6054,6 +6057,25 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
>  				ret = send_clone(sctx, offset, clone_len,
>  						 clone_root);
>  			}
> +		} else if (crossed_src_i_size && clone_len < len) {
> +			/*
> +			 * If we are at i_size of the clone source inode and we
> +			 * can not clone from it, terminate the loop. This is
> +			 * to avoid sending two write operations, one with a
> +			 * length matching clone_len and the final one after
> +			 * this loop with a length of len - clone_len.
> +			 *
> +			 * When using encoded writes (BTRFS_SEND_FLAG_COMPRESSED
> +			 * was passed to the send ioctl), this helps avoid
> +			 * sending an encoded write for an offset that is not
> +			 * sector size aligned, in case the i_size of the source
> +			 * inode is not sector size aligned. That will make the
> +			 * receiver fallback to decompression of the data and
> +			 * writing it using regular buffered IO, therefore while
> +			 * not incorrect, it's not optimal due decompression and
> +			 * possible re-compression at the receiver.
> +			 */
> +			break;
>  		} else {
>  			ret = send_extent_data(sctx, dst_path, offset,
>  					       clone_len);
> -- 
> 2.35.1
> 
