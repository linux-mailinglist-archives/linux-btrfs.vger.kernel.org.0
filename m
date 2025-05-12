Return-Path: <linux-btrfs+bounces-13888-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3874CAB3B83
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 16:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95EB53B84A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 14:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663A3230BC3;
	Mon, 12 May 2025 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QHnBnkyi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CnNmj5RE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OznkKH78";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NULLBWhj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD081E32D7
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061985; cv=none; b=QV0P8uA/a4QP+ht0Dfw9EfXb+BtXUHoqFpEOhk6Ws1f27J0rZzus51dcy8JNDfKqOqMfqoRK2rloa5Ug05SrXkrkpvCtzzOm4MgFc+zsDUrfImU3KsTU8Vn/AUadUJCyBHyb9icQ7ChjlWwEiHGUb5IgT6vczFshaLJRVJO/RgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061985; c=relaxed/simple;
	bh=dKaHkNWSoJU+HaYGY/kztHdFDDn1RUC5zI4rkiiAgms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEU81w2OsnUXKuXo1d66RMbfLQbxUYEpMnjlE0M043eVTE+a31vOmZdDsUZ5zSo3AZ64dguESMI6dmFSK818AZfz3JvD8qabdCGOniVsMoqYpuEINT+WNKHtIsFBCXWVUcDhsnWxoqZDM2FOq5V3X9U+8LqSTWuaP+cLsSIDfZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QHnBnkyi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CnNmj5RE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OznkKH78; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NULLBWhj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C267D1F7C1;
	Mon, 12 May 2025 14:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747061982;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0QDSiPJnpykzQqqZbqZB0oYQkHkitoFpixhSnGm5Zc=;
	b=QHnBnkyiIgPlT71JEPWbQIQEQmu6APy1z31FO33+KDI933jbY6dgDLxqqm2XL7NPQYeBpX
	yz7qRLvt3cR9T4TEZtSf4fnnGas1ep5qm7vAy3nj6/Tl3R0gagOUBIk8vfvxBY9o2P7pGT
	KubCZbpHrgj8KL2We0yqNBs+W+h1Ncc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747061982;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0QDSiPJnpykzQqqZbqZB0oYQkHkitoFpixhSnGm5Zc=;
	b=CnNmj5REWGr7hrH7XV4flx9CQJBbT2nLTqphwBO+JXw3T02K/FK31Kv3nS/g1n4h+FNIrL
	NAJVsosJ2VUZckBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747061981;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0QDSiPJnpykzQqqZbqZB0oYQkHkitoFpixhSnGm5Zc=;
	b=OznkKH78msUoTnRN2tC4tl2qcR9kFKE/iiuQxTAi2/uLgaxDw0JMnIpQPnJrIJFwAFdCDm
	U74EBkU/0WqKSwpJ///syQvmJcqeDRx61/h1CBrN1EwTGkfaXISr4l4UcVpoi9Wi4SX4zS
	H44SsFdHLNdpk3V3/b2d5I7usDF76Ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747061981;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z0QDSiPJnpykzQqqZbqZB0oYQkHkitoFpixhSnGm5Zc=;
	b=NULLBWhjDZpFc0fUBQCKRSLv/tD+wgHlfXzwBsKKqrxHBFXguNLvT54sFcig4gsboP/9dD
	J2m8IpIl2/JNPcBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C351137D2;
	Mon, 12 May 2025 14:59:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dnznJd0MImiYRwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 12 May 2025 14:59:41 +0000
Date: Mon, 12 May 2025 16:59:40 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fdmanana@kernel.org,
	neelx@suse.com
Subject: Re: [PATCH v5] btrfs: fix broken drop_caches on extent buffer folios
Message-ID: <20250512145939.GL9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <78713bfb50cb72321bd6026dd2e29cfef0b2b047.1746549760.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78713bfb50cb72321bd6026dd2e29cfef0b2b047.1746549760.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]

On Tue, May 06, 2025 at 09:47:32AM -0700, Boris Burkov wrote:
> @@ -2852,9 +2850,27 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
>  	return eb;
>  }
>  
> +/*
> + * For use in eb allocation error cleanup paths, as btrfs_release_extent_buffer()
> + * does not call folio_put(), and we need to set the folios to NULL so that
> + * btrfs_release_extent_buffer() will not detach them a second time.
> + */
> +static void cleanup_extent_buffer_folios(struct extent_buffer *eb)
> +{
> +	int num_folios = num_extent_folios(eb);
> +
> +	for (int i = 0; i < num_folios; i++) {

You can use num_extent_folios() directly without the temporary variable,
see bd06bce1b387c5 ("btrfs: use num_extent_folios() in for loop bounds")

> +		ASSERT(eb->folios[i]);
> +		detach_extent_buffer_folio(eb, eb->folios[i]);
> +		folio_put(eb->folios[i]);
> +		eb->folios[i] = NULL;
> +	}
> +}
> +
>  struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
>  {
>  	struct extent_buffer *new;
> +	int num_folios;
>  	int ret;
>  
>  	new = __alloc_extent_buffer(src->fs_info, src->start);
> @@ -2869,25 +2885,33 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
>  	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
>  
>  	ret = alloc_eb_folio_array(new, false);
> -	if (ret) {
> -		btrfs_release_extent_buffer(new);
> -		return NULL;
> -	}
> +	if (ret)
> +		goto release_eb;
>  
> -	for (int i = 0; i < num_extent_folios(src); i++) {
> +	ASSERT(num_extent_folios(src) == num_extent_folios(new),
> +	       "%d != %d", num_extent_folios(src), num_extent_folios(new));
> +	num_folios = num_extent_folios(src);

Same.

> +	for (int i = 0; i < num_folios; i++) {
>  		struct folio *folio = new->folios[i];
>  
>  		ret = attach_extent_buffer_folio(new, folio, NULL);
> -		if (ret < 0) {
> -			btrfs_release_extent_buffer(new);
> -			return NULL;
> -		}
> +		if (ret < 0)
> +			goto cleanup_folios;
>  		WARN_ON(folio_test_dirty(folio));
>  	}
> +	for (int i = 0; i < num_folios; i++)
> +		folio_put(new->folios[i]);
> +
>  	copy_extent_buffer_full(new, src);
>  	set_extent_buffer_uptodate(new);
>  
>  	return new;
> +
> +cleanup_folios:
> +	cleanup_extent_buffer_folios(new);
> +release_eb:
> +	btrfs_release_extent_buffer(new);
> +	return NULL;
>  }
>  
>  struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,

