Return-Path: <linux-btrfs+bounces-4625-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EEE8B5E87
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 18:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D06283152
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 16:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC49283CBA;
	Mon, 29 Apr 2024 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xfmeiMSJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YbCdvb8t";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LUmNnP/k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1PDKFeZ2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190A783A09;
	Mon, 29 Apr 2024 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406670; cv=none; b=Nn76MKAWq7DQuT2ZnFMeSEjxERCJj3UJl2q6gT+baCiwohgQAAQiXaXMJ4vNatBzDMw3K4LZAxFzh7lf8iwEsQdhsLVMPyKbRdMasSTuyjcXfmWjd3TVHqSsGrteTU2i27UrHoWjY+8deiL12WV6QiM9hfCI0M6rBk3zOPyxOKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406670; c=relaxed/simple;
	bh=jYdgcbHdxZHXUTE1iD8IOfdIkVdZtPlbGkDfjgc9Op4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2x3iTqdI9F61h78Z4EwHVxDoKX0H2rsnrXB5fIfpbgraB/VTkd5YwMvlvcum1OM71Psn3effJXwMt9IFuDVBbLWlWKnKwg7CWSbtxd5NSZtSJDaOy8yqPobJGvS8NQ4q8Qb00SfK58/fXjc1k72tCQuKUG8cYoglwCSww1CYdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xfmeiMSJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YbCdvb8t; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LUmNnP/k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1PDKFeZ2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 03DA21F458;
	Mon, 29 Apr 2024 16:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714406663;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FVgUd/9bYaxKsI1Mq3E7U6g1i8XvBLC12GPaK4k2gPI=;
	b=xfmeiMSJgPT+oI6RGnJ5q45/KhvRht8opQ+sQCR6OyhUP7LmAXm3SLFCxJS6Ml9jVpcrUo
	u/fQSAtqQwIm4u+3xUUV3lgZ6YC0Q3q04HAHXhV3SQLT94F126Wp3Upvod3V8Y2akn21BL
	71pjX7EOjYwcBbR5rmjMhzW2buhXWVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714406663;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FVgUd/9bYaxKsI1Mq3E7U6g1i8XvBLC12GPaK4k2gPI=;
	b=YbCdvb8t7/oPoWbfr+rah8I+6c8cFfIHwpb/IYEJHM1CYbjJ3DNVS68MwQUUvnKqaAa/NL
	FjYDbhNxir0/PrDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="LUmNnP/k";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1PDKFeZ2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714406662;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FVgUd/9bYaxKsI1Mq3E7U6g1i8XvBLC12GPaK4k2gPI=;
	b=LUmNnP/kbQihatczJD6mYPhsan4ZoaY7f6ThpcTtzpxP5Asu3RsddV/WGX0L8QCzR4N9VH
	WFN+PbvwRI6AbD4WdXpzzNf6SE95XfMnwHWmIQDE3Ie7EA/nBNNKF/FV5KcTpL/c7HiR/G
	orojxDKmlvkFR0KZulKKAbhBLALCNQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714406662;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FVgUd/9bYaxKsI1Mq3E7U6g1i8XvBLC12GPaK4k2gPI=;
	b=1PDKFeZ2Oo/MZwlGlKiX4k9paC/ZZa1x2yG8mGXiVI3puYgxgQHp78/zXlpNmGQ1n8JrvI
	qUt1Vrrvpq/KSnAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD0B1139DE;
	Mon, 29 Apr 2024 16:04:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QeiEMQXFL2YGKwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 29 Apr 2024 16:04:21 +0000
Date: Mon, 29 Apr 2024 17:57:08 +0200
From: David Sterba <dsterba@suse.cz>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	herbert@gondor.apana.org.au, linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org, qat-linux@intel.com, embg@meta.com,
	cyan@meta.com, brian.will@intel.com, weigang.li@intel.com
Subject: Re: [RFC PATCH 6/6] btrfs: zlib: add support for zlib-deflate
 through acomp
Message-ID: <20240429155708.GF2585@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240426110941.5456-1-giovanni.cabiddu@intel.com>
 <20240426110941.5456-7-giovanni.cabiddu@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426110941.5456-7-giovanni.cabiddu@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 03DA21F458
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Fri, Apr 26, 2024 at 11:54:29AM +0100, Giovanni Cabiddu wrote:
> From: Weigang Li <weigang.li@intel.com>
> +static int acomp_comp_pages(struct address_space *mapping, u64 start,
> +			    unsigned long len, struct page **pages,
> +			    unsigned long *out_pages,
> +			    unsigned long *total_in,
> +			    unsigned long *total_out)
> +{
> +	unsigned int nr_src_pages = 0, nr_dst_pages = 0, nr_pages = 0;
> +	struct sg_table in_sg = { 0 }, out_sg = { 0 };
> +	struct page *in_page, *out_page, **in_pages;
> +	struct crypto_acomp *tfm = NULL;
> +	struct acomp_req *req = NULL;
> +	struct crypto_wait wait;
> +	int ret, i;
> +
> +	nr_src_pages = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +	in_pages = kcalloc(nr_src_pages, sizeof(struct page *), GFP_KERNEL);

The maximum length is bounded so you could store the in_pages array in
zlib's workspace.

> +	if (!in_pages) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	for (i = 0; i < nr_src_pages; i++) {
> +		in_page = find_get_page(mapping, start >> PAGE_SHIFT);
> +		out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);

Output pages should be newly allocated by btrfs_alloc_compr_folio()

> +		if (!in_page || !out_page) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		in_pages[i] = in_page;
> +		pages[i] = out_page;
> +		nr_dst_pages += 1;
> +		start += PAGE_SIZE;
> +	}
> +
> +	ret = sg_alloc_table_from_pages(&in_sg, in_pages, nr_src_pages, 0,
> +					nr_src_pages << PAGE_SHIFT, GFP_KERNEL);

I'm not sure if the sg interface allows to use an existing buffer but
the input parameters are bounded in size and count so the allocation
should be dropped and replaced by workspace data.

> +	if (ret)
> +		goto out;
> +
> +	ret = sg_alloc_table_from_pages(&out_sg, pages, nr_dst_pages, 0,
> +					nr_dst_pages << PAGE_SHIFT, GFP_KERNEL);
> +	if (ret)
> +		goto out;
> +
> +	crypto_init_wait(&wait);
> +	tfm = crypto_alloc_acomp("zlib-deflate", 0, 0);

AFAIK the TFM should be allocated only once way before any IO is done
and then reused, this can trigger resolving the best implementation or
maybe even module loading.

> +	if (IS_ERR(tfm)) {
> +		ret = PTR_ERR(tfm);
> +		goto out;
> +	}
> +
> +	req = acomp_request_alloc(tfm);

The request should be in workspace, the only initialization I see
setting the right ->tfm pointer.

> +	if (!req) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	acomp_request_set_params(req, in_sg.sgl, out_sg.sgl, len,
> +				 nr_dst_pages << PAGE_SHIFT);
> +	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> +				   crypto_req_done, &wait);
> +
> +	ret = crypto_wait_req(crypto_acomp_compress(req), &wait);
> +	if (ret)
> +		goto out;
> +
> +	*total_in = len;
> +	*total_out = req->dlen;
> +	nr_pages = (*total_out + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +
> +out:
> +	sg_free_table(&in_sg);
> +	sg_free_table(&out_sg);
> +
> +	if (in_pages) {
> +		for (i = 0; i < nr_src_pages; i++)
> +			put_page(in_pages[i]);
> +		kfree(in_pages);

Pages returned back to the pool by btrfs_free_compr_folio()

> +	}
> +
> +	/* free un-used out pages */
> +	for (i = nr_pages; i < nr_dst_pages; i++)
> +		put_page(pages[i]);
> +
> +	if (req)
> +		acomp_request_free(req);
> +
> +	if (tfm)
> +		crypto_free_acomp(tfm);
> +
> +	*out_pages = nr_pages;
> +
> +	return ret;
> +}
> +
> +static int acomp_zlib_decomp_bio(struct page **in_pages,
> +				 struct compressed_bio *cb, size_t srclen,
> +				 unsigned long total_pages_in)
> +{
> +	unsigned int nr_dst_pages = BTRFS_MAX_COMPRESSED_PAGES;
> +	struct sg_table in_sg = { 0 }, out_sg = { 0 };
> +	struct bio *orig_bio = &cb->orig_bbio->bio;
> +	char *data_out = NULL, *bv_buf = NULL;
> +	int copy_len = 0, bytes_left = 0;
> +	struct crypto_acomp *tfm = NULL;
> +	struct page **out_pages = NULL;
> +	struct acomp_req *req = NULL;
> +	struct crypto_wait wait;
> +	struct bio_vec bvec;
> +	int ret, i = 0;
> +
> +	ret = sg_alloc_table_from_pages(&in_sg, in_pages, total_pages_in,
> +					0, srclen, GFP_KERNEL);

Any allocation here needs to be GFP_NOFS for now. Actually we'd need
memalloc_nofs_save/memalloc_nofs_restore around all compression and
decompression code that does not use GFP_NOFS directly and could call
other APIs that do GFP_KERNEL. Like crypto or sg.

> +	if (ret)
> +		goto out;
> +
> +	out_pages = kcalloc(nr_dst_pages, sizeof(struct page *), GFP_KERNEL);
> +	if (!out_pages) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	for (i = 0; i < nr_dst_pages; i++) {
> +		out_pages[i] = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
> +		if (!out_pages[i]) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +	}
> +
> +	ret = sg_alloc_table_from_pages(&out_sg, out_pages, nr_dst_pages, 0,
> +					nr_dst_pages << PAGE_SHIFT, GFP_KERNEL);
> +	if (ret)
> +		goto out;
> +
> +	crypto_init_wait(&wait);
> +	tfm = crypto_alloc_acomp("zlib-deflate", 0, 0);
> +	if (IS_ERR(tfm)) {
> +		ret = PTR_ERR(tfm);
> +		goto out;
> +	}
> +
> +	req = acomp_request_alloc(tfm);
> +	if (!req) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	acomp_request_set_params(req, in_sg.sgl, out_sg.sgl, srclen,
> +				 nr_dst_pages << PAGE_SHIFT);
> +	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> +				   crypto_req_done, &wait);
> +
> +	ret = crypto_wait_req(crypto_acomp_decompress(req), &wait);
> +	if (ret)
> +		goto out;
> +
> +	/* Copy decompressed buffer to bio pages */
> +	bytes_left = req->dlen;
> +	for (i = 0; i < nr_dst_pages; i++) {
> +		copy_len = bytes_left > PAGE_SIZE ? PAGE_SIZE : bytes_left;
> +		data_out = kmap_local_page(out_pages[i]);
> +
> +		bvec = bio_iter_iovec(orig_bio, orig_bio->bi_iter);
> +		bv_buf = kmap_local_page(bvec.bv_page);
> +		memcpy(bv_buf, data_out, copy_len);
> +		kunmap_local(bv_buf);
> +
> +		bio_advance(orig_bio, copy_len);
> +		if (!orig_bio->bi_iter.bi_size)
> +			break;
> +		bytes_left -= copy_len;
> +		if (bytes_left <= 0)
> +			break;
> +	}
> +out:
> +	sg_free_table(&in_sg);
> +	sg_free_table(&out_sg);
> +
> +	if (out_pages) {
> +		for (i = 0; i < nr_dst_pages; i++) {
> +			if (out_pages[i])
> +				put_page(out_pages[i]);
> +		}
> +		kfree(out_pages);
> +	}
> +
> +	if (req)
> +		acomp_request_free(req);
> +	if (tfm)
> +		crypto_free_acomp(tfm);
> +
> +	return ret;
> +}
> +
>  struct list_head *zlib_get_workspace(unsigned int level)
>  {
>  	struct list_head *ws = btrfs_get_workspace(BTRFS_COMPRESS_ZLIB, level);
> @@ -108,6 +305,15 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>  	unsigned long nr_dest_pages = *out_pages;
>  	const unsigned long max_out = nr_dest_pages * PAGE_SIZE;
>  
> +	if (crypto_has_acomp("zlib-deflate", 0, 0)) {
> +		ret = acomp_comp_pages(mapping, start, len, pages, out_pages,
> +				       total_in, total_out);
> +		if (!ret)
> +			return ret;
> +
> +		pr_warn("BTRFS: acomp compression failed: ret = %d\n", ret);
> +		/* Fallback to SW implementation if HW compression failed */
> +	}
>  	*out_pages = 0;
>  	*total_out = 0;
>  	*total_in = 0;
> @@ -281,6 +487,16 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>  	unsigned long buf_start;
>  	struct page **pages_in = cb->compressed_pages;
>  
> +	if (crypto_has_acomp("zlib-deflate", 0, 0)) {
> +		ret = acomp_zlib_decomp_bio(pages_in, cb, srclen,
> +					    total_pages_in);
> +		if (!ret)
> +			return ret;
> +
> +		pr_warn("BTRFS: acomp decompression failed, ret=%d\n", ret);
> +		/* Fallback to SW implementation if HW decompression failed */
> +	}
> +
>  	data_in = kmap_local_page(pages_in[page_in_index]);
>  	workspace->strm.next_in = data_in;
>  	workspace->strm.avail_in = min_t(size_t, srclen, PAGE_SIZE);
> -- 
> 2.44.0
> 

