Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC1252999F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 08:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiEQGfU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 02:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiEQGfT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 02:35:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C9D43EF7
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 23:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652769311;
        bh=Ia2vxgwkAwrfQddgHV5O+oZjBlU13uOHRIR9aNkRb5I=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=a+JC9NFyyGcNaQm5OLbCPOSQ6GW+bnWa9mCvVH+4DoH750ZzUfQoXcBlBQr2ASFGg
         9iRGwx0vqBYgVhRfdJ6Vv+ZYBoRFOqnOE49RZu+8dG0r89dm3ZIqQbzLl1oEL+nFzU
         jO7V/AUi3kCzEY2szUVNmvocwd5sFLAntVz7zbFE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2O2Q-1ntbwu28X0-003yps; Tue, 17
 May 2022 08:35:11 +0200
Message-ID: <50994099-b70e-8307-dd41-ac88784e552c@gmx.com>
Date:   Tue, 17 May 2022 14:35:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] btrfs: send: avoid trashing the page cache
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1651770555.git.fdmanana@suse.com>
 <41782eb393b3a3ba47f4a7fce1cbb33433c3f994.1651770555.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <41782eb393b3a3ba47f4a7fce1cbb33433c3f994.1651770555.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LUgZU/zjt2OaZzn4MLB8O6zQ3yJ4qYF+XVBqedcUZghec9u66YM
 HTz/YIaVqhtwHDVF4qwgKN2OZGAd1jT1JTNzYNKMcIq2QzJFSESXmj5uSiLH+poa62uEMC3
 MHrEoFfvCpmh1V+ccOIo3fmCW9K0WBJesQX1NG/Qx3f9Ic0Emqk2MXCE0RjNUT+7IsCk6Mh
 1Y0sOc42SNLrMk1lgSeCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yG3pVTiIRPQ=:6RwcBBex25IKVhmvF9t148
 OWj1BFf4DjbDqJ5Qgo9fipnRAweR4JEiUNIJ+2LoCeRzqAO0tyFQ3c0bdStjG5ZXLP/iwZC6G
 K2teqsGOYB2zBNiqZ45JAJ+EPyKrkQ41lhgtCZZ7Raq3UFZDYLfLNBSk1bff6F8mkeWMOWXwR
 ofzYNiZNAiN6iLYahSxYFhiDSMMh5ydaLsFeRmwi5p0EKixhOew+j2dW8dKg6vS/KLRw+lgnS
 z9rA3epVY38bmRFGfH/OHNN3+g4UI0m2mYV7NwUr+CRJkf/lMASV9EEiQ+7HQ37SRztbFJo6X
 08RdmzAAsf+m53IOjOMJKrJQ5WDVI5wkwwrmRxulaNM+abNTfk167NjAtKC00XbM1tDgb3yOK
 eXdEZ1qa6+15Jbiees+CRkBRrB7O1C6B/wqDoWAIIYvTs9CERIUu65wbPLhZTPKKcofk8Nwui
 Nv/s5nIyo6qzM94gKgViUZgiN2JkSM5DLLKotuHKguCDLb7LZpcfjDt8Jrc8KuhEBuPjJEPGd
 CfxYPVZnRZGGjY0YOZqbUQr4J9L36gCJgowcxcpZNmvPTgZMDYsYj3GawtFbvCfJF0mnt/9mU
 yLMMwpZbtbD2bzifE+MXW2ojQ+aWsWm5bDwMzMFbwZJWt32NW4lrTzULvIUQbM0AeLP4c2zrN
 PpgAKvlAdPL7KAqZuGbIzR1N1zXI5RluQsdVf9/L0jSrOk8iSJXxiU4OmVubpy1XNTAXmVOk2
 +n4kXm7RwA6aqrOd66a3XYn1cr4/VskRP8uo2rnRNtZ4jyiVCmxbDRWk5JeGK3JhJUQ217Ncn
 BlWQHvJrL5XaqiaIgil5/2ogsmuTTQTADrsk8iKV0iwnn0KKG4XaHwNrb7ksSbprNqsBpL47Q
 0SimByladTd8FTEvRS1K1E+TziREzaeFW9+8IySdf05ZoXqCQkv/OgoRfRbZDZQxHqvUC5Tab
 AjeJrImLVULfe/PYWFUN3OUc1LEcUpai+kg6yk/yyJ2sHI5IFTEPrW9buxTiWdvUjscGzWhpR
 BPlBBKhGwi12O8ZNo4IBx67L8niJCNB+g2dUWFDG8OojfDtg9tTP6ed2f0Srqz7vBmB6NNQCm
 8CpkeLmj+Rf76DlwFaFmUH8eB6dWqliTfQCkKBCvBTMz2UCKwEfZIt1fA==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/6 01:16, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> A send operation reads extent data using the buffered IO path for gettin=
g
> extent data to send in write commands and this is both because it's simp=
le
> and to make use of the generic readahead infrastructure, which results i=
n
> a massive speedup.
>
> However this fills the page cache with data that, most of the time, is
> really only used by the send operation - once the write commands are sen=
t,
> it's not useful to have the data in the page cache anymore. For large
> snapshots, bringing all data into the page cache eventually leads to the
> need to evict other data from the page cache that may be more useful for
> applications (and kernel susbsystems).
>
> Even if extents are shared with the subvolume on which a snapshot is bas=
ed
> on and the data is currently on the page cache due to being read through
> the subvolume, attempting to read the data through the snapshot will
> always result in bringing a new copy of the data into another location i=
n
> the page cache (there's currently no shared memory for shared extents).
>
> So make send evict the data it has read before if when it first opened
> the inode, its mapping had no pages currently loaded: when
> inode->i_mapping->nr_pages has a value of 0. Do this instead of deciding
> based on the return value of filemap_range_has_page() before reading an
> extent because the generic readahead mechanism may read pages beyond the
> range we request (and it very often does it), which means a call to
> filemap_range_has_page() will return true due to the readahead that was
> triggered when processing a previous extent - we don't have a simple way
> to distinguish this case from the case where the data was brought into
> the page cache through someone else. So checking for the mapping number
> of pages being 0 when we first open the inode is simple, cheap and it
> generally accomplishes the goal of not trashing the page cache - the
> only exception is if part of data was previously loaded into the page
> cache through the snapshot by some other process, in that case we end
> up not evicting any data send brings into the page cache, just like
> before this change - but that however is not the common case.
>
> Example scenario, on a box with 32G of RAM:
>
>    $ btrfs subvolume create /mnt/sv1
>    $ xfs_io -f -c "pwrite 0 4G" /mnt/sv1/file1
>
>    $ btrfs subvolume snapshot -r /mnt/sv1 /mnt/snap1
>
>    $ free -m
>                   total        used        free      shared  buff/cache =
  available
>    Mem:           31937         186       26866           0        4883 =
      31297
>    Swap:           8188           0        8188
>
>    # After this we get less 4G of free memory.
>    $ btrfs send /mnt/snap1 >/dev/null
>
>    $ free -m
>                   total        used        free      shared  buff/cache =
  available
>    Mem:           31937         186       22814           0        8935 =
      31297
>    Swap:           8188           0        8188
>
> The same, obviously, applies to an incremental send.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Unfortunately, this patch seems to cause subpage cases to fail test case
btrfs/007, the reproducibility is around 50%, thus better "-I 8" to be
extra safe.

And I believe it also causes other send related failure for subpage cases.

I guess it's truncate_inode_pages_range() only truncating the full page,
but for subpage case, since one sector is smaller than one page, it
doesn't work as expected?

If needed, I can provide you the access to my aarch64 vm for debugging.

Thanks,
Qu

> ---
>   fs/btrfs/send.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 77 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 55275ba90cb4..d899049dea53 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -137,6 +137,8 @@ struct send_ctx {
>   	 */
>   	struct inode *cur_inode;
>   	struct file_ra_state ra;
> +	u64 prev_extent_end;
> +	bool clean_page_cache;
>
>   	/*
>   	 * We process inodes by their increasing order, so if before an
> @@ -5157,6 +5159,28 @@ static int send_extent_data(struct send_ctx *sctx=
,
>   		}
>   		memset(&sctx->ra, 0, sizeof(struct file_ra_state));
>   		file_ra_state_init(&sctx->ra, sctx->cur_inode->i_mapping);
> +
> +		/*
> +		 * It's very likely there are no pages from this inode in the page
> +		 * cache, so after reading extents and sending their data, we clean
> +		 * the page cache to avoid trashing the page cache (adding pressure
> +		 * to the page cache and forcing eviction of other data more useful
> +		 * for applications).
> +		 *
> +		 * We decide if we should clean the page cache simply by checking
> +		 * if the inode's mapping nrpages is 0 when we first open it, and
> +		 * not by using something like filemap_range_has_page() before
> +		 * reading an extent because when we ask the readahead code to
> +		 * read a given file range, it may (and almost always does) read
> +		 * pages from beyond that range (see the documentation for
> +		 * page_cache_sync_readahead()), so it would not be reliable,
> +		 * because after reading the first extent future calls to
> +		 * filemap_range_has_page() would return true because the readahead
> +		 * on the previous extent resulted in reading pages of the current
> +		 * extent as well.
> +		 */
> +		sctx->clean_page_cache =3D (sctx->cur_inode->i_mapping->nrpages =3D=
=3D 0);
> +		sctx->prev_extent_end =3D offset;
>   	}
>
>   	while (sent < len) {
> @@ -5168,6 +5192,33 @@ static int send_extent_data(struct send_ctx *sctx=
,
>   			return ret;
>   		sent +=3D size;
>   	}
> +
> +	if (sctx->clean_page_cache) {
> +		const u64 end =3D round_up(offset + len, PAGE_SIZE);
> +
> +		/*
> +		 * Always start from the end offset of the last processed extent.
> +		 * This is because the readahead code may (and very often does)
> +		 * reads pages beyond the range we request for readahead. So if
> +		 * we have an extent layout like this:
> +		 *
> +		 *            [ extent A ] [ extent B ] [ extent C ]
> +		 *
> +		 * When we ask page_cache_sync_readahead() to read extent A, it
> +		 * may also trigger reads for pages of extent B. If we are doing
> +		 * an incremental send and extent B has not changed between the
> +		 * parent and send snapshots, some or all of its pages may end
> +		 * up being read and placed in the page cache. So when truncating
> +		 * the page cache we always start from the end offset of the
> +		 * previously processed extent up to the end of the current
> +		 * extent.
> +		 */
> +		truncate_inode_pages_range(&sctx->cur_inode->i_data,
> +					   sctx->prev_extent_end,
> +					   end - 1);
> +		sctx->prev_extent_end =3D end;
> +	}
> +
>   	return 0;
>   }
>
> @@ -6172,6 +6223,30 @@ static int btrfs_unlink_all_paths(struct send_ctx=
 *sctx)
>   	return ret;
>   }
>
> +static void close_current_inode(struct send_ctx *sctx)
> +{
> +	u64 i_size;
> +
> +	if (sctx->cur_inode =3D=3D NULL)
> +		return;
> +
> +	i_size =3D i_size_read(sctx->cur_inode);
> +
> +	/*
> +	 * If we are doing an incremental send, we may have extents between th=
e
> +	 * last processed extent and the i_size that have not been processed
> +	 * because they haven't changed but we may have read some of their pag=
es
> +	 * through readahead, see the comments at send_extent_data().
> +	 */
> +	if (sctx->clean_page_cache && sctx->prev_extent_end < i_size)
> +		truncate_inode_pages_range(&sctx->cur_inode->i_data,
> +					   sctx->prev_extent_end,
> +					   round_up(i_size, PAGE_SIZE) - 1);
> +
> +	iput(sctx->cur_inode);
> +	sctx->cur_inode =3D NULL;
> +}
> +
>   static int changed_inode(struct send_ctx *sctx,
>   			 enum btrfs_compare_tree_result result)
>   {
> @@ -6182,8 +6257,7 @@ static int changed_inode(struct send_ctx *sctx,
>   	u64 left_gen =3D 0;
>   	u64 right_gen =3D 0;
>
> -	iput(sctx->cur_inode);
> -	sctx->cur_inode =3D NULL;
> +	close_current_inode(sctx);
>
>   	sctx->cur_ino =3D key->objectid;
>   	sctx->cur_inode_new_gen =3D 0;
> @@ -7671,7 +7745,7 @@ long btrfs_ioctl_send(struct inode *inode, struct =
btrfs_ioctl_send_args *arg)
>
>   		name_cache_free(sctx);
>
> -		iput(sctx->cur_inode);
> +		close_current_inode(sctx);
>
>   		kfree(sctx);
>   	}
