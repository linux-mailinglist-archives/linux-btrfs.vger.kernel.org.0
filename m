Return-Path: <linux-btrfs+bounces-15674-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7155EB1238C
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 20:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC36AA6960
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 18:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C1B28AAE9;
	Fri, 25 Jul 2025 18:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="hr+D3cOv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iITNTglw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4973548CFC
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466920; cv=none; b=lX4S2bBFO3GBTYyfo77a9kt1aMsV8sHMzZBzVxaOLCPVbTfBw7wT5Tj5osIMoFD2u5hl0y0FXYBfrhrPpbx3tHUWsw8Gk7Zcchj+T1ZbyO2GKwe4j0XHiNqpcI1RHJLZHoVa+592IkGTd8cwUcP4IkN8vNHDZoWPVhFQ2zI8b5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466920; c=relaxed/simple;
	bh=8rY1mlHiWeYSRSQBZCtzEmhYJqMa4zEODpaY6H0xnyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nL3dtH6C6/h9AltRcJf1Zpg3BusDeLjEAQ62JNkPfsjjUcY4YI+KXN2jh3KLbtZ3TlxhZlGMt8TmMDl8efMQdDLaXS6J1ZLlwMJiWK3pwx24V0vDY9r+t+fsh7k7tLa8KEmMLBNWw/3kZJWSH8S9HXrge4YcQQJL8m+vE+k1bpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=hr+D3cOv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iITNTglw; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F3F307A0AE8;
	Fri, 25 Jul 2025 14:08:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 25 Jul 2025 14:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753466913; x=1753553313; bh=02uxrzw2EZ
	x5CHme6g54ChVhX6Qr2QNlVLOAReVa0BE=; b=hr+D3cOvEzzKoINgzETN6STzMN
	pqfMcepfj92SfWeli+jPPG/vIdRM98BN74eZwtvnsDl9M3r+NheXyEVx5ACjX4Ek
	hOVtC7OlLeggnnHYNcgmYAo19CXr5kKbw8IG5hfpFswKPFrPrei9ADxD9fHPcGBU
	8xYguOqAlS7XdZLP3obmnpNNbJEFgMvDhpqrnlJAe5DUlEUG6J9Co7xfC4VCqyRw
	V6J4f65FWlMTKDIol67qL3zeV20TV/Wxfq7pUTGjq9bub+KjjPuP+52PIGtPbgs8
	NeLOZmT4gwKFP9dWz8C4aLWr7PbMfoo79dUbxA2Kd+i+xfGCbriupysXxxVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753466913; x=1753553313; bh=02uxrzw2EZx5CHme6g54ChVhX6Qr2QNlVLO
	AReVa0BE=; b=iITNTglwohruE+VH+B5By/7H+6/SM7mN9WVxydxKzC1yktXm4/j
	KYkl9qs3BKW9NsWt5GHBGqE6pM97uYtXy/az4rJmdKzLbsDI4S+d8BBi4z93eIhn
	Eu87yo0d67j2mCO3wJKzsoyRdva4LLQ24+LkKTRibdgSxt3gC7ENtmpkky8sAZdB
	fN5n6zyECpOCsQPWDK7IFA0jVLVF/V89b2iItyDALxeVuecXdTVLAvIKNTvJiXPd
	K2+Ko0hxZrbHXwoCGfKeWyXZCGgts7zkOkyRC6owp5SRqxyRnr8FYkVkyCTGguFM
	8hinw2MwCOFSMBFD6RbgB6+3bHVVhLHXSsg==
X-ME-Sender: <xms:IciDaIJHMCzinJsYOWvsK-yfjY2EZ52oZW8zjqD1HZpulgvyaUj-NQ>
    <xme:IciDaIU07gx1JTsZDAkTnv4EA5x2MY_MxHqT2RSCppnMQSaK2ntuXa1EP699RDGLA
    DSG_q_6Ij3Y4Alz-MQ>
X-ME-Received: <xmr:IciDaKgjEm3p0CxXziuUYr1D7_1LaZ_tEirtwqAa3mmbMsauev4vQF62DOfEahA-qKLtlxs_zPItMdCELmcYvOqwHAY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekgedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvke
    ffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    peifqhhusehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IciDaD-caDU2dsK24dZPRk3XAy-tF8V0AQNvC4g5rYjisJyN-1-xAA>
    <xmx:IciDaEAMlwPd-Bj25fWt3EYR-NqFcMsUuTP_4j0hZ95F5Sm3UVCBng>
    <xmx:IciDaAJq5uLwOqwXwWW3529Ltf3gx3vpsrehIg3CVLsUReAOtLOt2A>
    <xmx:IciDaHnmAseOeMSHMmOduQo-kb3WFF4vL9xce619aLCxFi9pLLzQwg>
    <xmx:IciDaG5BL3XwV5P0Ci4fUHoaKX8beBi7VQJbRoGgdOyGSB8HiW-peuzY>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 14:08:33 -0400 (EDT)
Date: Fri, 25 Jul 2025 11:09:50 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs-progs: check/original: detect missing orphan
 items correctly
Message-ID: <20250725180950.GA1649496@zen.localdomain>
References: <cover.1753414100.git.wqu@suse.com>
 <24cda813cf05892afb67f62f5c68cd28b478ec09.1753414100.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24cda813cf05892afb67f62f5c68cd28b478ec09.1753414100.git.wqu@suse.com>

On Fri, Jul 25, 2025 at 01:10:41PM +0930, Qu Wenruo wrote:
> [BUG]
> If we have a filesystem with a subvolume that has 0 refs but without an
> orphan item, btrfs check won't report any error on it.
> 
>   $ btrfs ins dump-tree -t root /dev/test/scratch1
>   btrfs-progs v6.15
>   root tree
>   node 5242880 level 1 items 2 free space 119 generation 11 owner ROOT_TREE
>   node 5242880 flags 0x1(WRITTEN) backref revision 1
>   fs uuid ff32309e-4e90-4402-b1ef-0a1f9f28bfff
>   chunk uuid 6c373b6d-c866-4c8c-81fa-608bf5ef25e3
>   	key (EXTENT_TREE ROOT_ITEM 0) block 5267456 gen 11
>   	key (ROOT_TREE_DIR DIR_ITEM 2378154706) block 5246976 gen 11
>   leaf 5267456 items 6 free space 2339 generation 11 owner ROOT_TREE
>   leaf 5267456 flags 0x1(WRITTEN) backref revision 1
>   fs uuid ff32309e-4e90-4402-b1ef-0a1f9f28bfff
>   	[...]
>   leaf 5246976 items 6 free space 1613 generation 11 owner ROOT_TREE
>   leaf 5246976 flags 0x1(WRITTEN) backref revision 1
>   checksum stored 47620783
>   checksum calced 47620783
>   fs uuid ff32309e-4e90-4402-b1ef-0a1f9f28bfff
>   chunk uuid 6c373b6d-c866-4c8c-81fa-608bf5ef25e3
>   	[...]
>   	item 4 key (256 ROOT_ITEM 0) itemoff 2202 itemsize 439
>   		generation 9 root_dirid 256 bytenr 5898240 byte_limit 0 bytes_used 581632
>   		last_snapshot 0 flags 0x1000000000000(none) refs 0 <<<
>   		drop_progress key (0 UNKNOWN.0 0) drop_level 0
>   		level 2 generation_v2 9
>   	item 5 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 1763 itemsize 439
>   		generation 5 root_dirid 256 bytenr 5287936 byte_limit 0 bytes_used 4096
>   		last_snapshot 0 flags 0x0(none) refs 1
>   		drop_progress key (0 UNKNOWN.0 0) drop_level 0
>   		level 0 generation_v2 5
>   	^^^ No orphan item for subvolume 256.
> 
> Then "btrfs check" will not report anything wrong with it:
> 
>   Opening filesystem to check...
>   Checking filesystem on /dev/test/scratch1
>   UUID: ff32309e-4e90-4402-b1ef-0a1f9f28bfff
>   [1/8] checking log skipped (none written)
>   [2/8] checking root items
>   [3/8] checking extents
>   [4/8] checking free space tree
>   [5/8] checking fs roots
>   [6/8] checking only csums items (without verifying data)
>   [7/8] checking root refs
>   [8/8] checking quota groups skipped (not enabled on this FS)
>   found 638976 bytes used, no error found <<<
>   total csum bytes: 0
>   total tree bytes: 638976
>   total fs tree bytes: 589824
>   total extent tree bytes: 16384
>   btree space waste bytes: 289501
>   file data blocks allocated: 0
>    referenced 0
> 
> [CAUSE]
> Although we have check_orphan_item() call inside check_root_refs(), it
> relies the root record to have its 'found_root_item' member set.
> Otherwise it will not report this as an error.
> 
> But that 'found_root_item' is always set to 0, if the subvolume has zero
> ref, this means any subvolume with 0 refs will not have its orphan item
> checked.
> 
> [FIX]
> Set root_record::found_root_item to 1 inside check_fs_root().
> 
> As check_fs_root() is called after we found a root item, we should set
> root_record::found_root_item to indicate this fact, and allows proper
> orphan item check to be done.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  check/main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/check/main.c b/check/main.c
> index b78eb59d0c50..1536c1bbbccd 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -3728,8 +3728,7 @@ static int check_fs_root(struct btrfs_root *root,
>  	if (root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID) {
>  		rec = get_root_rec(root_cache, root->root_key.objectid);
>  		BUG_ON(IS_ERR(rec));
> -		if (btrfs_root_refs(root_item) > 0)
> -			rec->found_root_item = 1;
> +		rec->found_root_item = 1;

This change feels like an improvement to me, but it does seem to
implicitly reduce the fidelity of the root ref checking. Like if the
root refs was 0 but a ref existed, then we would suddenly miss that,
where before it was an error. I think it would be best to check that
refs is correct (i.e., store the found refs and add up the refs we see
and make sure they match), separate from the "found_root_item" logic.

>  	}
>  
>  	memset(&root_node, 0, sizeof(root_node));
> -- 
> 2.50.0
> 

