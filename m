Return-Path: <linux-btrfs+bounces-14305-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED29AC8CA9
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 13:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68C897A9810
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 11:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20108225A3B;
	Fri, 30 May 2025 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kopKgofR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CvQM/C0B";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ElRg9oMw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/jq/DkcK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB1B19AD70
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 11:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603514; cv=none; b=E/+qKN3KWz+WHfaXDnCvK9Iyogm+G3ztx/HKSe1N79C9w1EnG9GcNvXLgH9mEPp2rwfdaAJZPFvwPZzNdGU6Q/9hR0Psl3Jqpv5Bow1/AlYrZBMO7AKXIX8txT8udP95VOMoh5UA2NebWNzWB+0NZxU+vza0U3qbEpQSuNhWK6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603514; c=relaxed/simple;
	bh=5JcUo6okZeZC+h/Bi+Q/0Imc+I6piX/Z/mSj1UbHcjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loyAsr5l0FKrN82PvCQWr7DxYJ2a6J3SIcPSnubcwZk0RMHy1Soguidt3T5eCu/ovYV5EkjxD/PlBkI8S/gjT2UcyvNnJQaG/Wbe/rSEWE7AXgpzTRn8eM/wTGAOcODAV2fbAhv34dOcj4Ihdzi/CPBqnGbY31QaXZCl/YxubTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kopKgofR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CvQM/C0B; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ElRg9oMw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/jq/DkcK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DEC901F7CE;
	Fri, 30 May 2025 11:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748603511;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aDSlYKQgVJCRYW4ZLw/1iFaQhW8MhkmbKQvZLCZCJIs=;
	b=kopKgofR1R7Tsf4SVb/TkyfGeUhUAcSQjnKwGft/VasCiDjSETcNnWHJ0qnj+7RrP2566X
	vvcOYPxVnTssW0GRxVhTSZPucm7qE0RZa/3GVjQfJKNeOGBHaijZmCn/I2ei2QiUEN9Us3
	JvekMDgN3L1MR+ojdWlYSSX8FIRsGLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748603511;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aDSlYKQgVJCRYW4ZLw/1iFaQhW8MhkmbKQvZLCZCJIs=;
	b=CvQM/C0BiVnfshCXLrdyEMmev2L9QZMq3TTgNL4s4kcfM/gCHWgnz5wqcQZz2CfI1PxI+X
	NAjezvhZLomDuWAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748603510;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aDSlYKQgVJCRYW4ZLw/1iFaQhW8MhkmbKQvZLCZCJIs=;
	b=ElRg9oMw1opeAOTSAbk4/r6+Uo1/7GIVNKa3uPUzU8sSo6TaV10j6Y3MbN+k8D2i4o/eoS
	tgiZ1Ij8pZLtnDRBsAxPJgSoG7RDqH7Mky1cxL+wqZvQkDh4AOZfiWeg9Ub3Kl+j7jq1tY
	Sln9Syhg6StstAs/PYnaq6obwxAtRDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748603510;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aDSlYKQgVJCRYW4ZLw/1iFaQhW8MhkmbKQvZLCZCJIs=;
	b=/jq/DkcKAeHnCgkcxohP62VIwPlIwv9cClimBnUpi3nInHrAIMAbmKc2F4sag16If/chmx
	qV9H91iiZ72xTbCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEE3313889;
	Fri, 30 May 2025 11:11:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rDlnLnaSOWi2EAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 30 May 2025 11:11:50 +0000
Date: Fri, 30 May 2025 13:11:41 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/6] btrfs-progs: fix a bug in btrfs_find_item()
Message-ID: <20250530111141.GR4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1747295965.git.wqu@suse.com>
 <7c72856dd5939761a9dd34a4554fddf94389090d.1747295965.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c72856dd5939761a9dd34a4554fddf94389090d.1747295965.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 

On Thu, May 15, 2025 at 05:30:17PM +0930, Qu Wenruo wrote:
> [BUG]
> There is a seldomly utilized function, btrfs_find_item(), which has no
> document and is not behaving correctly.
> 
> Inside backref.c, iterate_inode_refs() and btrfs_ref_to_path() both
> utilize this function, to find the parent inode.
> 
> However btrfs_find_item() will never return 0 if @ioff is passed as 0
> for such usage, result early failure for all kinds of inode iteration
> functions.
> 
> [CAUSE]
> Both functions pass 0 as the @ioff parameter initially, e.g:
> 
>  We have the following fs tree root:
> 
>   	item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
> 		generation 3 transid 9 size 6 nbytes 16384
> 		block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
> 		sequence 1 flags 0x0(none)
> 	item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
> 		index 0 namelen 2 name: ..
> 	item 2 key (256 DIR_ITEM 2507850652) itemoff 16078 itemsize 33
> 		location key (257 INODE_ITEM 0) type FILE
> 		transid 9 data_len 0 name_len 3
> 		name: foo
> 	item 3 key (256 DIR_INDEX 2) itemoff 16045 itemsize 33
> 		location key (257 INODE_ITEM 0) type FILE
> 		transid 9 data_len 0 name_len 3
> 		name: foo
> 	item 4 key (257 INODE_ITEM 0) itemoff 15885 itemsize 160
> 		generation 9 transid 9 size 16384 nbytes 16384
> 		block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
> 		sequence 4 flags 0x0(none)
> 	item 5 key (257 INODE_REF 256) itemoff 15872 itemsize 13
> 		index 2 namelen 3 name: foo
> 	item 6 key (257 EXTENT_DATA 0) itemoff 15819 itemsize 53
> 		generation 9 type 1 (regular)
> 		extent data disk byte 13631488 nr 16384
> 		extent data offset 0 nr 16384 ram 16384
> 		extent compression 0 (none)
> 
>   Then we call paths_from_inode() with:
>   - @inum = 257
>   - ipath = {.fs_root = 5}
> 
>   Then we got the following sequence:
> 
>   iterate_irefs(257, fs_root, inode_to_path)
>   |- iterate_inode_refs()
>      |- inode_ref_info()
>         |- btrfs_find_item(257, 0, fs_root)
> 	|  Returned 1, with @found_key updated to
> 	|  (257, INODE_REF, 256).
> 
>   This makes iterate_irefs() exit immediately, but obviously that
>   btrfs_find_item() call is to find any INODE_REF, not to find the
>   exact match.
> 
> [FIX]
> If btrfs_find_item() found an item matching the objectid and type, then
> it should return 0 other than 1.
> 
> Fix it and keep the behavior the same across btrfs-progs and the kernel.
> 
> Since we're here, also add some comments explaining the function.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  kernel-shared/ctree.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
> index 3184c916175e..f90de606e7b1 100644
> --- a/kernel-shared/ctree.c
> +++ b/kernel-shared/ctree.c
> @@ -1246,6 +1246,17 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
>  	}
>  }
>  
> +/*
> + * Find the first key in @fs_root that matches all the following conditions:
> + *
> + * - key.obojectid == @iobjectid
> + * - key.type == @key_type
> + * - key.offset >= ioff
> + *
> + * Return 0 if such key can be found, and @found_key is updated.
> + * Return >0 if no such key can be found.
> + * Return <0 for critical errors.
> + */
>  int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path *found_path,
>  		u64 iobjectid, u64 ioff, u8 key_type,
>  		struct btrfs_key *found_key)
> @@ -1280,10 +1291,10 @@ int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path *found_path,
>  
>  	btrfs_item_key_to_cpu(eb, found_key, path->slots[0]);
>  	if (found_key->type != key.type ||
> -			found_key->objectid != key.objectid) {
> +	    found_key->objectid != key.objectid)

This fits one line. We don't have perfect 1:1 line matching with kernel
so the style can be fixed.

>  		ret = 1;
> -		goto out;
> -	}
> +	else
> +		ret = 0;
>  
>  out:
>  	if (path != found_path)
> -- 
> 2.49.0
> 

