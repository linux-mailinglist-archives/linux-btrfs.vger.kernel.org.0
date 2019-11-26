Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB2210A395
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 18:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKZRw2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 12:52:28 -0500
Received: from a4-6.smtp-out.eu-west-1.amazonses.com ([54.240.4.6]:45918 "EHLO
        a4-6.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726005AbfKZRw1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 12:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1574790745;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=tIHAO3NC6wqZAg7Rp/LNP5Uj60gHnJYcJ96609QKhLk=;
        b=JsFT/hV+Ms0kyN7C0sg1lK4jxPz4pz02/lsRlUKZwKyM5ZcjaTMz2pY6meM8dCjs
        vq5HKoQr/OkQ8g4lhCGDBtUPKnxyGttNbXanAt07RrQlJoQcwlT3Ire5Gku8sxBza7N
        0hXgB5QJUmjisWuHOsNEkt7+xTHy4u8baPsi6mQo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1574790745;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=tIHAO3NC6wqZAg7Rp/LNP5Uj60gHnJYcJ96609QKhLk=;
        b=JHDiH2ErHoZWeDDDuuOAek099Oyf9lufJEM1l8snoLQI8cpuSUPyUqA2P/ttu/ai
        gNDLGiYCyyg9h65TCKvRrEYJ4JBU8q9cSVuHiwwddc+lMDDGabmyB6lrIg8uE3t07S8
        N5+9ux/k90HaM2K9vDTzgUe//VN1LS4Ftoj2H1Vc=
Subject: Re: [PATCH] Btrfs: send, skip backreference walking for extents with
 many references
To:     linux-btrfs@vger.kernel.org
References: <20191030122301.25270-1-fdmanana@kernel.org>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102016ea8d7cba9-e4f3d553-317c-4a83-9ad6-c161fcdd0e7f-000000@eu-west-1.amazonses.com>
Date:   Tue, 26 Nov 2019 17:52:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191030122301.25270-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.11.26-54.240.4.6
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30.10.2019 13:23 fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> Backreference walking, which is used by send to figure if it can issue
> clone operations instead of write operations, can be very slow and use too
> much memory when extents have many references. This change simply skips
> backreference walking when an extent has more than 64 references, in which
> case we fallback to a write operation instead of a clone operation. This
> limit is conservative and in practice I observed no signicant slowdown
> with up to 100 references and still low memory usage up to that limit.
>
> This is a temporary workaround until there are speedups in the backref
> walking code, and as such it does not attempt to add extra interfaces or
> knobs to tweak the threshold.

Thanks for the patch!

Did some further deliberation on  the problem, and for me the best short
term solution (apart from your patch) for the send clone source
detection would be to offload it to userspace.
I.e. a flag like "--no-data"/BTRFS_SEND_FLAG_NO_FILE_DATA that disables
clone source detection.
Userspace can then take each BTRFS_SEND_C_UPDATE_EXTENT and look if it
is in the clone sources/on the send target. If it is a dedup tool it can
use its dedup database, it can use a cache or it can use
BTRFS_IOC_LOGICAL_INO. Another advantage is that user space can do this
in multiple threads.

Only problem I can think of is that send prevents subvol removal and
dedup during send, but user space may not be finished with the actual
send stream once send has finished outputting the metadata. So there may
be some issues there, but not if one has control over when removal/dedup
happens.

>
> Reported-by: Atemu <atemu.main@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CAE4GHgkvqVADtS4AzcQJxo0Q1jKQgKaW3JGp3SGdoinVo=C9eQ@mail.gmail.com/T/#me55dc0987f9cc2acaa54372ce0492c65782be3fa
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/send.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 123ac54af071..518ec1265a0c 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -25,6 +25,14 @@
>  #include "compression.h"
>  
>  /*
> + * Maximum number of references an extent can have in order for us to attempt to
> + * issue clone operations instead of write operations. This currently exists to
> + * avoid hitting limitations of the backreference walking code (taking a lot of
> + * time and using too much memory for extents with large number of references).
> + */
> +#define SEND_MAX_EXTENT_REFS	64
> +
> +/*
>   * A fs_path is a helper to dynamically build path names with unknown size.
>   * It reallocates the internal buffer on demand.
>   * It allows fast adding of path elements on the right side (normal path) and
> @@ -1302,6 +1310,7 @@ static int find_extent_clone(struct send_ctx *sctx,
>  	struct clone_root *cur_clone_root;
>  	struct btrfs_key found_key;
>  	struct btrfs_path *tmp_path;
> +	struct btrfs_extent_item *ei;
>  	int compressed;
>  	u32 i;
>  
> @@ -1349,7 +1358,6 @@ static int find_extent_clone(struct send_ctx *sctx,
>  	ret = extent_from_logical(fs_info, disk_byte, tmp_path,
>  				  &found_key, &flags);
>  	up_read(&fs_info->commit_root_sem);
> -	btrfs_release_path(tmp_path);
>  
>  	if (ret < 0)
>  		goto out;
> @@ -1358,6 +1366,21 @@ static int find_extent_clone(struct send_ctx *sctx,
>  		goto out;
>  	}
>  
> +	ei = btrfs_item_ptr(tmp_path->nodes[0], tmp_path->slots[0],
> +			    struct btrfs_extent_item);
> +	/*
> +	 * Backreference walking (iterate_extent_inodes() below) is currently
> +	 * too expensive when an extent has a large number of references, both
> +	 * in time spent and used memory. So for now just fallback to write
> +	 * operations instead of clone operations when an extent has more than
> +	 * a certain amount of references.
> +	 */
> +	if (btrfs_extent_refs(tmp_path->nodes[0], ei) > SEND_MAX_EXTENT_REFS) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +	btrfs_release_path(tmp_path);
> +
>  	/*
>  	 * Setup the clone roots.
>  	 */


