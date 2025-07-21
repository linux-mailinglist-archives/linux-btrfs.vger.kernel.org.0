Return-Path: <linux-btrfs+bounces-15594-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FFDB0C7CB
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 17:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF0E6C1D68
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 15:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405E32DE6EF;
	Mon, 21 Jul 2025 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Y8E6eqV+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ik8oQAf8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7F8DDBC
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112301; cv=none; b=qzkK6BcOfCNMzyGifZdQOM9dlMT8rmlBg/DBm/PIFRUyfhnwtO9+iEEPQkM7EIrNbt8EW6xnm3gSLsj77D7Upp9GNypPDlYMZsU5zqEc70GRnESnXEeXowYJuKlc28tcPJ+GdkEYyLVLkzDB+Mfz3ZJwvD54QYZV1wkQzU7SvsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112301; c=relaxed/simple;
	bh=3hwRQKcdOVisMrqPBNvEhgYrPLligAokxX+g3+ZPQvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAdWur1A+HXXAdSR3xKbSe/WHdf4+++T4YjfTz4EruAvgGD3GJP+jFe32ysWrAmq4l5yd7kf0XpnP2/EA4WM7linVHIqopsb0o303bj3Fu6einhx1AnMPZn6HSJuggl27pXz3omAsfeFBaJkuJ6ZNZXbQWrm5mXtAoQOZf4jNOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Y8E6eqV+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ik8oQAf8; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id ABAB61D000A2;
	Mon, 21 Jul 2025 11:38:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 21 Jul 2025 11:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753112296; x=1753198696; bh=sHDsdwk9zl
	mPLUvNnZZoNyn2o9727acG2U3g/hZomQI=; b=Y8E6eqV+atgx0uLxem1tpWlRXb
	rq1KKG7jEg4i2m5NxwJ5WnH52/630/MhJ3d+iUJA5ZfbqI+uv643QWrOcDBwWxoN
	ciYbMpaTte3s2G7SleQ4vh4LrG8TDNgOtqqipKuLrV4LjAo6lgT0lCa/P0AbQGe/
	Dnz02wYwY9KMJYJ4Yw4Vc+iDJE9/1YLqWfndUrbAPr9C9ZsAHTj/Qf84CXsecddv
	ZKwSTxo5tykbgESp3HvVIWRfN3j/+KU3sFxuFDt9kqTMD24VMO4alvLIVxMX4VqF
	9lAplV0/+oxEFyTdj/3PI8O2YDJvRRpr4Y1IVu5r27NLHCK4qOopbFq4g+XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753112296; x=1753198696; bh=sHDsdwk9zlmPLUvNnZZoNyn2o9727acG2U3
	g/hZomQI=; b=Ik8oQAf8biqVY1OahEJZFSqeEdbu+us5VQSJC90Q+/nx0f6iODe
	6ld1GS0NKt4oiMw3k5c/AxAuEueylU59QNqGV1wSAbtDh8Y5ak2tRleVqPmgFd6X
	l2Isq3sBLC5vrjf9v9wWY8rTSOLLbMMwV1yGE28g2fmOk4kvfbronKO9TlkVzPrj
	cut86BbumdscqEMy6BlbOCeATjJp2ce0fmPjxcbNaaRVBrroq1ln2dEhpLXAkHkq
	izlTxHxtqu6iDr/aieT/iYKxMKokuoSEHELIAY+xzdF8AnjtBPMkAqKTT7QaQIth
	FFKgRJEDFDlal3hMk//tJrsMEFJeuZF163g==
X-ME-Sender: <xms:6F5-aAPchU5HOSde_Hp8RIU28qgAQNabNENQka02c3TyyIWRCat4pw>
    <xme:6F5-aHJVtlPgp8z04NiluQQ3ggjysLfMrEgeG1jB8nsgRgwT2rT1VyIppO9PCKciE
    THeHmDJE0n3XFx_jXU>
X-ME-Received: <xmr:6F5-aJEWWT4EHa28HATSTUUMn76e7_drFsmaMCDyk88pEIyDxe7ISZeaI5eguctEjZT-TTZsNX16Sx4PECQ1gt9aqs4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvke
    ffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    peifqhhusehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6F5-aHRfpwufQcxA4Hy498CZSfbGZ9bIXVxTp086mUpMa11jHAWjFw>
    <xmx:6F5-aNHHjYpXtFRJ8mIbyT5HGA7rfadYyG7LLxei80_JDKaGp7kExQ>
    <xmx:6F5-aL-MJK6T3s7ryv8T_KFoEfVYHR5wNC-TpPOJbfpCV1ULUohCjg>
    <xmx:6F5-aPJ-6Q82osWioy6zkNkzRRGvDyvwXtoqhmlZiML707U05WDAJQ>
    <xmx:6F5-aLccRLGKT1gHNnw2ob6d4fxDKKbvBDBEjMHBYu2iNoPQ0ZPptmMX>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 11:38:15 -0400 (EDT)
Date: Mon, 21 Jul 2025 08:39:41 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove unnecessary xa lock for
 btrfs_free_dummy_fs_info()
Message-ID: <20250721153918.GB87532@zen.localdomain>
References: <a7028fb9bc67996dd7c1c547e66ffbbea8485183.1752879168.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7028fb9bc67996dd7c1c547e66ffbbea8485183.1752879168.git.wqu@suse.com>

On Sat, Jul 19, 2025 at 08:27:34AM +0930, Qu Wenruo wrote:
> xa_for_each() is utilizing xa_for_each_range(), which in turns calls
> xa_find() and xa_find_after(), both are already taking RCU lock
> internally.
> 
> Although RCU lock is not enough if there is a concurrent entry adding,
> but for btrfs_free_dummy_fs_info() there won't be any concurrent entry
> adding at all, thus we are safe to remove the xa lock.

Do you have an argument for why the eb is not being protected by RCU as
we discussed on Leo's patches?

We take the eb->refs_lock in free_extent_buffer() here in the loop in a
pretty similar pattern to the non test code.

Intuitively, I would argue having the test code more closely mirror the
real code feels valuable, even if you can prove that there is no race
possible with how this is called from the test code.

Thanks,
Boris

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/tests/btrfs-tests.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
> index b576897d71cc..e4cd3970e893 100644
> --- a/fs/btrfs/tests/btrfs-tests.c
> +++ b/fs/btrfs/tests/btrfs-tests.c
> @@ -169,13 +169,8 @@ void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
>  
>  	test_mnt->mnt_sb->s_fs_info = NULL;
>  
> -	xa_lock_irq(&fs_info->buffer_tree);
> -	xa_for_each(&fs_info->buffer_tree, index, eb) {
> -		xa_unlock_irq(&fs_info->buffer_tree);
> +	xa_for_each(&fs_info->buffer_tree, index, eb)
>  		free_extent_buffer(eb);
> -		xa_lock_irq(&fs_info->buffer_tree);
> -	}
> -	xa_unlock_irq(&fs_info->buffer_tree);
>  
>  	btrfs_mapping_tree_free(fs_info);
>  	list_for_each_entry_safe(dev, tmp, &fs_info->fs_devices->devices,
> -- 
> 2.50.0
> 

