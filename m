Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7574B49DC7A
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 09:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbiA0IYB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 03:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiA0IYB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 03:24:01 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABBEC061714
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jan 2022 00:24:00 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c4c8:1afa:4649:d034])
        by baptiste.telenet-ops.be with bizsmtp
        id nkPy260042MCa5R01kPyFP; Thu, 27 Jan 2022 09:23:58 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nD04T-00BaKx-QD; Thu, 27 Jan 2022 09:23:57 +0100
Date:   Thu, 27 Jan 2022 09:23:57 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     Josef Bacik <josef@toxicpanda.com>
cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix 64bit mod compile error
In-Reply-To: <139a265095afb1b3103d58bd3c8e19a89014db13.1643230494.git.josef@toxicpanda.com>
Message-ID: <alpine.DEB.2.22.394.2201270913080.2760701@ramsan.of.borg>
References: <139a265095afb1b3103d58bd3c8e19a89014db13.1643230494.git.josef@toxicpanda.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

 	Hi Josef,

On Wed, 26 Jan 2022, Josef Bacik wrote:
> kernelbuild test bot complained about a 64bit % operation in the patch
>
> btrfs: add support for multiple global roots
>
> Fix this using div64_u64_rem.  This can be folded in to the original
> patch.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Thanks, this fixes the build error for me.

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2452,6 +2452,7 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
> static u64 calculate_global_root_id(struct btrfs_fs_info *fs_info, u64 offset)
> {
> 	u64 div = SZ_1G;
> +	u64 index;
>
> 	if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
> 		return BTRFS_FIRST_CHUNK_TREE_OBJECTID;
> @@ -2460,7 +2461,9 @@ static u64 calculate_global_root_id(struct btrfs_fs_info *fs_info, u64 offset)
> 	if (btrfs_super_total_bytes(fs_info->super_copy) <= (SZ_1G * 10ULL))
> 		div = SZ_128M;
>
> -	return (div_u64(offset, div) % fs_info->nr_global_roots);
> +	offset = div64_u64(offset, div);

On 32-bit, this is not implemented as a plain division, hence gcc is not
smart enough to notice that div is a power-of-two, and this can be
optimized to a shift.

Hence please make this explicit:

     if (btrfs_super_total_bytes(fs_info->super_copy) <= (SZ_1G * 10ULL))
             offset >>= ilog2(SZ_128M);
     else
 	    offset >>= ilog2(SZ_1G);

> +	div64_u64_rem(offset, fs_info->nr_global_roots, &index);

Does the number fs_info->nr_global_roots have special properties,
i.e. can this expensive modulo operation be replaced by a shift, too?

> +	return index;
> }
>
> struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *trans,

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
