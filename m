Return-Path: <linux-btrfs+bounces-20647-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A998D38A39
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jan 2026 00:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20DE93020FD6
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 23:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A1631327A;
	Fri, 16 Jan 2026 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="HaseZe9i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LmIQWF5P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD0419E968
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 23:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606314; cv=none; b=r+1Fo3Q7Er4AiGG95Xa0OjIlzLCQY9pHm6sZm8+F3QCSp1WqEi6x0tIME/cI+T0L1X1Qns13UIbsORssSmFibH3ls9C6rX2qzC6vSFrLnj8bFbA0Y4C2thw+lb4TKxtyPpTPKZJemc7i1SvVFyIXUTe8ki/Fhc7Jh+TE7fCFEmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606314; c=relaxed/simple;
	bh=PURq7Ww3vwIMB9U0eiKbZYzqPMJUXQlR3jksag9FkLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ql+NbRFeu1+w1+a+1067dfHKCwtBfMryjyDyJ6GvJxbFRCuOFuOywuK91RbEZbk2UnDlsiF/o0PK2PIkp7CCs3FCmPiS0it5iR2PaTS+FMkxAIlGPBVBspm5KHktH74fwkHCMy0XrFmEZr/suRqpwlTqDR7KJnaRM/jsRQpgmiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=HaseZe9i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LmIQWF5P; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 849541D00063;
	Fri, 16 Jan 2026 18:31:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 16 Jan 2026 18:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1768606311; x=1768692711; bh=6U9Geowceq
	dvgHkiChbHFJyCHuRUQfWwRCrJ5uXiOuQ=; b=HaseZe9iznwiqf8fstbDuAJeLQ
	0we/OfNtnO9gHHde5vJN8xKlDZ9rsFb/6K6qem9pGEshdpF2Bn74vI80eynSCdJP
	DDw7pyt9/41IVHQS6e2WkCiWEyIewPPgWBJoaVepcitEKimXgfJWFYDKDCtCDa2j
	BbX+58rnhcsjPolRaA6v0TuFvnbxayqkKZtw81Lv6YwmALQrVdhWSD1Lb8+hp7YZ
	JGXELf1RL3ieom6j8s9Lzns3MgZvzs4nM3Zz+XL+0pq94zVXVZIOGnbDD6Li5WaS
	k8pFAnb8HQgTisz/Bpx3SWkwkYTjiHAu00xtBfMOAuriaNM+N4/POXILX/Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768606311; x=1768692711; bh=6U9GeowceqdvgHkiChbHFJyCHuRUQfWwRCr
	J5uXiOuQ=; b=LmIQWF5PTexv0eedSVG/mHJBWAqFIF6KflnewHa+In0fiIKWe7k
	9U8tiazBUD+3fDP84Rzr1iQ8oZCWyckUfg6r4OGuU9Xz0rthlqdcxky61LPRDLse
	jHSr6n6cFgFbKS56UMsBtZf9iZilo94Xmf9k003ipbTZeLhgUptJFjtrH9ZTinF4
	myLfnlevPLKxg7cFN1yBUJEfodLVouhXRXYQgRJjpHmfv8b8DViqt+Atlp9KHwGk
	3TVG3MbAgISzbzuxt1HdUm1LIDobtuNNhRH3KeHhq3woqzGD2airq5f+Lp3aPen+
	IT4KR2UJndfgGb7uo/Gndoz5JMLHjO/fZcA==
X-ME-Sender: <xms:Z8pqaZ3J-Aa90yZXKM-dPEMn8A-bl-ki55HmaM7z9MirTVmtAfd_sA>
    <xme:Z8pqaXjdnjFajzbQuGhC4_rohyhs2_K5IGPOPdxzHk5S9mMTugS5zWqJy0-63Tdt0
    RoSDl9T7an-LgVCLdjH6-_4y7unhPRNVdFFCCSGEXI2V0RaEkapBt3M>
X-ME-Received: <xmr:Z8pqaXQkvEoLTDbRmGwvQHPNS4NmdDyN8uCLUNNjDrZZu9tWA9KqS2o_jnXC24UdmSYl2Z8t0QNXsXPWE8nFcWtF7rY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufedtvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtkhesshhushgvrdgtii
X-ME-Proxy: <xmx:Z8pqaQhBlvaU5sVOdChbsimmw_R0zZ0ftbAvoRL80fPLe4RWvkYWGQ>
    <xmx:Z8pqaf5bKEr-5xLotLF9z-UOunwDhNlWKl_8ShIycERmtX1TcNHYLA>
    <xmx:Z8pqaVDgjvIDuLZYGIK6NbzML4wBx8SGfPYSJfBSGSvfqg9_OdFAfA>
    <xmx:Z8pqaeZr8Dv4E37r9FX8VkJjzIwFWKI1uvxZfUbAaVKWy0KVzPSaGw>
    <xmx:Z8pqaXM9fu3GFCfoPr-pCQcDH1Vro13gT8y-gvOPVjpzu48twleSy6vK>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 18:31:50 -0500 (EST)
Date: Fri, 16 Jan 2026 15:31:45 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] btrfs: do not strictly require dirty metadata
 threshold for metadata writepages
Message-ID: <20260116233145.GA2693568@zen.localdomain>
References: <6a6b5f2bb0d3cbcdd0d3dc6ee46c3ebfc4ce63af.1768605742.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a6b5f2bb0d3cbcdd0d3dc6ee46c3ebfc4ce63af.1768605742.git.wqu@suse.com>

On Sat, Jan 17, 2026 at 09:52:31AM +1030, Qu Wenruo wrote:
> [BUG]
> There is an internal report that over 1000 processes are
> waiting at the io_schedule_timeout() of balance_dirty_pages(), causing
> a system hang and triggered a kernel coredump.
> 
> [CAUSE]
> From Jan Kara for his wisdom on the dirty page balance behavior first.
> 
>  This cgroup dirty limit was what was actually playing the role here
>  because the cgroup had only a small amount of memory and so the dirty
>  limit for it was something like 16MB.
> 
>  Dirty throttling is responsible for enforcing that nobody can dirty
>  (significantly) more dirty memory than there's dirty limit. Thus when
>  a task is dirtying pages it periodically enters into balance_dirty_pages()
>  and we let it sleep there to slow down the dirtying.
> 
>  When the system is over dirty limit already (either globally or within
>  a cgroup of the running task), we will not let the task exit from
>  balance_dirty_pages() until the number of dirty pages drops below the
>  limit.
> 
>  So in this particular case, as I already mentioned, there was a cgroup
>  with relatively small amount of memory and as a result with dirty limit
>  set at 16MB. A task from that cgroup has dirtied about 28MB worth of
>  pages in btrfs btree inode and these were practically the only dirty
>  pages in that cgroup.
> 
> So that means the only way to reduce the dirty pages of that cgroup is
> to writeback the dirty pages of btrfs btree inode, and only after that
> those processes can exit balance_dirty_pages().
> 
> Now back to the btrfs part, btree_writepages() is responsible for
> writing back dirty btree inode pages.
> 
> The problem here is, there is a btrfs internal threshold that if the
> btree inode's dirty bytes are below the 32M threshold, it will not
> do any writeback.
> 
> This behavior is to batch as much metadata as possible so we won't write
> back those tree blocks and then later re-COW then again for another
> modification.
> 
> This internal 32MiB is higher than the existing dirty page size (28MiB),
> meaning no writeback will happen, causing a deadlock between btrfs and
> cgroup:
> 
> - Btrfs doesn't want writeback btree inode until more dirty pages
> 
> - Cgroup/MM doesn't want more dirty pages for btrfs btree inode
>   Thus any process touching that btree inode is put into sleep until
>   the number of dirty pages is reduced.
> 
> Thanks Jan Kara a lot for the analyze on the root cause.
> 
> [FIX]
> For internal callers using btrfs_btree_balance_dirty() since that
> function is already doing internal threshold check, we don't need to
> bother it.
> 
> But for external callers of btree_writepages(), then respect their
> request and just writeback whatever they want, ignoring the internal
> btrfs threshold to avoid such deadlock on btree inode dirty page
> balancing.

The new version is really well written and clear, thanks.

I guess my last comment is that this is really a fix for a bug from the
past. Like I said, I don't believe this bug will surface in this way
any more now that btrfs doesn't account btree_inode pages to the cgroup.

If you reproduce it on a kernel with AS_KERNEL_FILE, I will of course
eat my hat on that :)

I still think it's a reasonable change and support landing it, I guess I
just feel it's sort of misleading to call it a bug and a fix on for-next.

At this point, IMO, the only motivation is just simplifying
btree_writepages() and avoiding any weird cases on systems with tiny
ram. It really hinges on how likely the dirty page limit is to be <32M
without cgroups involved.

We probably do want to send it to stable trees predating AS_KERNEL_FILE
though?

Thanks again,
Boris

> 
> Cc: Jan Kara <jack@suse.cz>
> Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Update the commit message to include more details about the
>   balance_dirty_pages() behavior
> 
> - With that background knowledge explain the deadlock better
>   It's between cgroup where no more btree inode dirty pages are allowed
>   and all involved processes are put into sleep until dirty pages
>   drops, and btrfs where it won't write back any dirty pages until
>   there are more dirty pages.
> ---
>  fs/btrfs/disk-io.c | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5e4b7933ab20..9add1f287635 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -485,28 +485,6 @@ static int btree_migrate_folio(struct address_space *mapping,
>  #define btree_migrate_folio NULL
>  #endif
>  
> -static int btree_writepages(struct address_space *mapping,
> -			    struct writeback_control *wbc)
> -{
> -	int ret;
> -
> -	if (wbc->sync_mode == WB_SYNC_NONE) {
> -		struct btrfs_fs_info *fs_info;
> -
> -		if (wbc->for_kupdate)
> -			return 0;
> -
> -		fs_info = inode_to_fs_info(mapping->host);
> -		/* this is a bit racy, but that's ok */
> -		ret = __percpu_counter_compare(&fs_info->dirty_metadata_bytes,
> -					     BTRFS_DIRTY_METADATA_THRESH,
> -					     fs_info->dirty_metadata_batch);
> -		if (ret < 0)
> -			return 0;
> -	}
> -	return btree_write_cache_pages(mapping, wbc);
> -}
> -
>  static bool btree_release_folio(struct folio *folio, gfp_t gfp_flags)
>  {
>  	if (folio_test_writeback(folio) || folio_test_dirty(folio))
> @@ -584,7 +562,7 @@ static bool btree_dirty_folio(struct address_space *mapping,
>  #endif
>  
>  static const struct address_space_operations btree_aops = {
> -	.writepages	= btree_writepages,
> +	.writepages	= btree_write_cache_pages,
>  	.release_folio	= btree_release_folio,
>  	.invalidate_folio = btree_invalidate_folio,
>  	.migrate_folio	= btree_migrate_folio,
> -- 
> 2.52.0
> 

