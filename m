Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7452F62A342
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 21:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiKOUpW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 15:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiKOUpV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 15:45:21 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1A26424
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 12:45:19 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 149693200488;
        Tue, 15 Nov 2022 15:45:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 15 Nov 2022 15:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668545115; x=1668631515; bh=qt02BGOl8m
        limZbjhcH23LTlySPBtav8BRAu5ZHB/qA=; b=etlxdvlTEOjmhI5gX6TbF24GP3
        8gq9+M8Pr5BnQCB1+3jCB3habBI/Il935FA76kgUZaKBZWctYDCYd2tx8BpUz54M
        SiVYs2ZXHD+H7ld3j6857mGKH2mQsM/CACmbVYGIwDTYZ79409lit3SM9w0nPp9N
        ohesMDXABd1TnuIosKXDapAXa0crWPRAMEGygwRGrcZB7OnHLa/nfi9rqfJPUkcO
        WkF1vLm+Ilc3iwOnFuFs93RkKvKQhJhHb+mqMyp8iKzH5E59R5p0QOq41Z1jchl7
        H5huIw3Zyy3zga6ZEPp+tX8q1fn5TnQccx1OYVpQrdGT2154Sl3iA/ykQtfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668545115; x=1668631515; bh=qt02BGOl8mlimZbjhcH23LTlySPB
        tav8BRAu5ZHB/qA=; b=sShZGXH7sbuuMC2zmMILDRGwkFtOjzxjNi6m/xO5PLqh
        NYjigWI7uW9HvXNCr8tR3aXvBQNHHjK0/2pPLpmgzkm8WeYfvONNlDgouGgESntn
        jtPU+/hEKcY9UyFvzzwUsZaPZut8kgk72KYQW1b9nbP7HPqM63RlgS4YgtYGrIBJ
        /U7aKDVlThqdCxO/+ahRuQV5XhE/Xyx+iK9ZStkPXDK+YvLoYLbZ7/kE2u1xnOxq
        boNzWMrNCC+/GikMQFgXPVOoegoMjDOo1+Coy3WTH95yBPGXQrJVcEHU2TqmxHbb
        C1wdu7hSXRShjTP0Hu8rzPhyMItg6mGQE++fE36zJg==
X-ME-Sender: <xms:W_pzYwXBWckdABMSl8CUTw8MxjaJR7A3ZHg_IGFLhnMXGk8iZ8fl1g>
    <xme:W_pzY0nJM-2e6t7aAds4JCZ0lhSgYvHqyhNjqoK5IQOMqNdOf7joWMGIMGOFaN2V6
    d6rsso637IVown7w9Q>
X-ME-Received: <xmr:W_pzY0aikFq_NIeg0Y51ILJ367B3fnJK8J1-TXbxVTWRuuuxlJVZmZsc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeeggddugedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvve
    eiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:W_pzY_VnyxKQ4zR_VKeY41XDjLkqd-8AQ2qHHqiip7m6Rkq_SH1-vA>
    <xmx:W_pzY6klIUhg7NCRbx9cypevqhxkQzfOnWm9C_ewRzFWYmzGcAhT8Q>
    <xmx:W_pzY0d7pURcCeX5PAtKFkV_OjlBKxva6EfCH8LqVDlfkqqWtfBaFQ>
    <xmx:W_pzYxuC2ZdqmmdSJXriNHHXw4UAaILnI-63klSWtcupWY-oNo4NRg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Nov 2022 15:45:14 -0500 (EST)
Date:   Tue, 15 Nov 2022 12:45:13 -0800
From:   Boris Burkov <boris@bur.io>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs-progs: receive: fix silent data loss after
 fall back from encoded write
Message-ID: <Y3P5vyh09FSzuos4@zen>
References: <cover.1668529099.git.fdmanana@suse.com>
 <59f1b932bfd1549f777d18b814feeaabef0860ee.1668529099.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59f1b932bfd1549f777d18b814feeaabef0860ee.1668529099.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 04:25:26PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When attempting an encoded write, if it fails for some specific reason
> like -EINVAL (when an offset is not sector size aligned) or -ENOSPC, we
> then fallback into decompressing the data and writing it using regular
> buffered IO. This logic however is not correct, one of the reasons is
> that it assumes the encoded offset is smaller than the unencoded file
> length and that they can be compared, but one is an offset and the other
> is a length, not an end offset, so they can't be compared to get correct
> results. This bad logic will often result in not copying all data, or even
> no data at all, resulting in a silent data loss. This is easily seen in
> with the following reproducer:
> 
>    $ cat test.sh
>    #!/bin/bash
> 
>    DEV=/dev/sdj
>    MNT=/mnt/sdj
> 
>    umount $DEV &> /dev/null
>    mkfs.btrfs -f $DEV > /dev/null
>    mount -o compress $DEV $MNT
> 
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
> Running the test without this patch:
> 
>    $ ./test.sh
>    (...)
>    File bar in the original filesystem:
>    0000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
>    *
>    0065536
> 
>    Receiving stream in a new filesystem...
>    At subvol snap
> 
>    File bar in the new filesystem:
>    0000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
>    *
>    0033792
> 
> We end up with file bar having less data, and a smaller size, than in the
> original filesystem.
> 
> This happens because when processing file bar, send issues the following
> commands:
> 
>    clone bar - source=foo source offset=0 offset=0 length=32768
>    write bar - offset=32768 length=1024
>    encoded_write bar - offset=33792, len=4096, unencoded_offset=33792, unencoded_file_len=31744, unencoded_len=65536, compression=1, encryption=0
> 
> The first 32K are cloned from file foo, as that file ranged is shared
> between the files.
> 
> Then there's a regular write operation for the file range [32K, 33K[,
> since file foo has different data from bar for that file range.
> 
> Finally for the remainder of file bar, the send side issues an encoded
> write since the extent is compressed in the source filesystem, for the
> file offset 33792 (33K), remaining 31K of data. The receiver will try the
> encoded write, but that fails with -EINVAL since the offset 33K is not
> sector size aligned, so it will fallback to decompressing the data and
> writing it using regular buffered writes. However that results in doing
> no writes at decompress_and_write() because 'pos' is initialized to the
> value of 33K (unencoded_offset) and unencoded_file_len is 31K, so the
> while loop has no iterations.
> 
> Another case where we can fallback to decompression plus regular buffered
> writes is when the destination filesystem has a sector size larger then
> the sector size of the source filesystem (for example when the source
> filesystem is on x86_64 with a 4K sector size and the destination
> filesystem is PowerPC with a 64K sector size). In that scenario encoded
> write attempts wil fail with -EINVAL due to offsets not being aligned with
> the sector size of the destination filesystem, and the receive will
> attempt the fallback of decompressing the buffer and writing the
> decompressed using regular buffered IO.
> 
> Fix this by tracking the number of written bytes instead, and increment
> it, and the unencoded offset, after each write.

Thank you for catching and fixing this.

> 
> Fixes: d20e759fc917 ("btrfs-progs: receive: encoded_write fallback to explicit decode and write")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  cmds/receive.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/cmds/receive.c b/cmds/receive.c
> index e6f1aeab..0db66ee5 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -1155,10 +1155,9 @@ static int decompress_and_write(struct btrfs_receive *rctx,
>  				u32 compression)
>  {
>  	int ret = 0;
> -	size_t pos;
> -	ssize_t w;
>  	char *unencoded_data;
>  	int sector_shift = 0;
> +	u64 written = 0;
>  
>  	unencoded_data = calloc(unencoded_len, 1);
>  	if (!unencoded_data) {
> @@ -1209,17 +1208,19 @@ static int decompress_and_write(struct btrfs_receive *rctx,
>  		goto out;
>  	}
>  
> -	pos = unencoded_offset;
> -	while (pos < unencoded_file_len) {
> -		w = pwrite(rctx->write_fd, unencoded_data + pos,
> -			   unencoded_file_len - pos, offset);
> +	while (written < unencoded_file_len) {
> +		ssize_t w;
> +
> +		w = pwrite(rctx->write_fd, unencoded_data + unencoded_offset,
> +			   unencoded_file_len - written, offset);
>  		if (w < 0) {
>  			ret = -errno;
>  			error("writing unencoded data failed: %m");
>  			goto out;
>  		}
> -		pos += w;
> +		written += w;
>  		offset += w;
> +		unencoded_offset += w;
>  	}
>  out:
>  	free(unencoded_data);
> -- 
> 2.35.1
> 
