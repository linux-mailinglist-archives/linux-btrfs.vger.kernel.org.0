Return-Path: <linux-btrfs+bounces-21012-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF7oHj3XdmmGXgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21012-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 03:53:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B649883980
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 03:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A9F130057B2
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 02:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BE628E59E;
	Mon, 26 Jan 2026 02:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AqUIg6nR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1E517555
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 02:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769396020; cv=none; b=A3BtO/1gE04s3NeFoxvMdgvU6qU1aYQYJav7gl9sbMuN1f75dOn1SDRTKIRuv0LoDCV834p5gfn4qszsnzzL83UGu0lAk/GmR3ZEsFEQIQDRjB7kML/WAzPQ9YLVQdFFg3XQubt/8VEbFTmUNaRG26kbWthp+v3P1ubWcDllR/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769396020; c=relaxed/simple;
	bh=fg9jBBdx5SgpjbeO6ry/SVQGvUueK4SGp/QH2k6/SVc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=T7CT/WfvtGDPAoPxYZMonA5H2UqTb/qWGkxJJ3HNTMpSxj5Mld48m2pxrguCCA2XAzh5Qo5pUmQsxMkt79YaVqAvtox72TE9skwBXSKf2tQyI9aJqnbP0w0nyBuB3GvxswhqEPoptfXWQHAu+xHuYihBZssBmH/jHXAnobrLa5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AqUIg6nR; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47ee4338e01so22703895e9.2
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 18:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769396017; x=1770000817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cw5VP4R3YC/vblNqxmzqfKqPjJjDXb8UBNNLwwQSgFU=;
        b=AqUIg6nR90ILmfOg1w9drul36ZHt8jbIiy8pC8gh1VGi8DGQImveL2mmxid4pk9SNr
         QFYd4TNzU1/tnrin0Cqg1vKoOfLfBKnLD46sZhcTThA7xqHGBQsjHk7kJ1MwEtCtfjwc
         Qs8pgHQsjQwYRvhQznaoiew0sevouwLEqYSDRJdjkZYMYjFV2PwavI1VLDjmv6EcZ4De
         hedDFAtxjkipjVrCnRQebPC2kwVZeGq+WC4tNR4y8J5pHB7q/DDZfnP+05TPEDoFForw
         n13hqqr1YB5OJclitstYRnJI0w0hxo1Cxi+xSzQNTKXWUzWQZfhGhWlR1yAB3zdyXSlA
         +4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769396017; x=1770000817;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cw5VP4R3YC/vblNqxmzqfKqPjJjDXb8UBNNLwwQSgFU=;
        b=maqnH0LoZ9b9+znCdo8EYukd7fY/TpS8Bg7b6e86l/feV7F3cDXRFn/3gTUhQgO8pX
         FHYrJ2G+KiLaWCKAZROxKm+Yp5Ga+BAcQT0vMQ8znhqtK1/l9dAFMvo9nEMMn3ptz6ej
         5rpxZmUWEOpaMdjyBN/rvMQrtPWXLoeJF9Zmd6j/iU709pYdlzs7phs7ejbzYE8RLugW
         w/fEiraNO8UBXVgId/vFa60XGXJHcZwhogkMwLLMbkOzX88/5+IhYc1KhZHwx9F8EHWW
         coXwWxLjeUm+cIupvT1iTXfeojKdoNLshD/iQ+9xp+O4UvyE4e3Rir7NdgfHLDpqCdiC
         vIYQ==
X-Gm-Message-State: AOJu0YyHai6DPSFAR0tAkTuaFrIbF3o5ugUkUoFv7OuM3klzVrLVKfLv
	sxuoPbrz78wRM0qngTsNIpPD1BsH8Fia1S2g0tgQpWn+fvxQVpmmCyhziiDKJbF0Mj4g7yQm0Q1
	Vc2rwS2c=
X-Gm-Gg: AZuq6aJcXESNnXrz+1Ql+79Siu1wN56G44nc3p1LX1P1gNbqljCDqhBpO4GVavAZ9nm
	CJpt0+29tJggN+a5rewh+7y7V2RB+ZV3WhnwvX8VwbHxP7uwPTf8BxRAplMS6XyIgMg41keLKaz
	iFyorRGvYogCIgOPJp99t9VePsE/eW4YIq+GHmcnkkLXEsRq9lZP/XRryKeybfjk23iNrHTaeTG
	Vm7vAs/OjmN/4jYSzYrHHQIII0DKkk2qzcE7a3rPCMwlQ68Wcqxup7Bj43VbdRbGvzIvCUjv6Xc
	W35Vaucn8RWISYWXA6JKPSlM01JlHdHzJgIpwGQnKupukggnskLnWypegxWgO42Wcv+sa8pwAJm
	8OTief1FHiiqEnHSSsnNLSKwx6pjQuoKmCkVpI9g/S10Nja5v50sGBPe88vJiXBlM9z7E2z6hPu
	CP8Sg9oaveGLbT4NZNtF/NVUrvYxK1bA8KjA6N9KI=
X-Received: by 2002:a05:600c:470e:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-4805ce3fc24mr48314715e9.13.1769396016519;
        Sun, 25 Jan 2026 18:53:36 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802fae2c3sm76432515ad.69.2026.01.25.18.53.35
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jan 2026 18:53:35 -0800 (PST)
Message-ID: <6d415ebf-5eac-4412-9c50-c5c76813e17d@suse.com>
Date: Mon, 26 Jan 2026 13:23:32 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] btrfs: introduce zstd_compress_bio() helper
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1769381237.git.wqu@suse.com>
 <efe53eea681b366ea20bd38268fbd29d0343e733.1769381237.git.wqu@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <efe53eea681b366ea20bd38268fbd29d0343e733.1769381237.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21012-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B649883980
X-Rspamd-Action: no action



在 2026/1/26 09:18, Qu Wenruo 写道:
> The new helper has the following enhancements against the existing
> lzo_compress_folios()
> 
> - Much smaller parameter list
> 
>    No more shared IN/OUT members, no need to pre-allocate a
>    compressed_folios[] array.
> 
>    Just a workspace and compressed_bio pointer, everything we need can be
>    extracted from that @cb pointer.
> 
> - Ready-to-be-submitted compressed bio
> 
>    Although the caller still needs to do some common works like
>    rounding up and zeroing the tailing part of the last fs block.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/compression.h |   1 +
>   fs/btrfs/zstd.c        | 186 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 187 insertions(+)
> 
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index 4b63d7e4a9ad..454c8e0461b4 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -172,6 +172,7 @@ void lzo_free_workspace(struct list_head *ws);
>   int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
>   			 u64 start, struct folio **folios, unsigned long *out_folios,
>   		unsigned long *total_in, unsigned long *total_out);
> +int zstd_compress_bio(struct list_head *ws, struct compressed_bio *cb);
>   int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
>   int zstd_decompress(struct list_head *ws, const u8 *data_in,
>   		struct folio *dest_folio, unsigned long dest_pgoff, size_t srclen,
> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> index 737bc49652b0..ae3e6e937718 100644
> --- a/fs/btrfs/zstd.c
> +++ b/fs/btrfs/zstd.c
> @@ -585,6 +585,192 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
>   	return ret;
>   }
>   
> +int zstd_compress_bio(struct list_head *ws, struct compressed_bio *cb)
> +{
> +	struct btrfs_inode *inode = cb->bbio.inode;
> +	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> +	struct workspace *workspace = list_entry(ws, struct workspace, list);
> +	struct address_space *mapping = inode->vfs_inode.i_mapping;
> +	struct bio *bio = &cb->bbio.bio;
> +	zstd_cstream *stream;
> +	int ret = 0;
> +	struct folio *in_folio = NULL;  /* The current folio to read. */
> +	struct folio *out_folio = NULL; /* The current folio to write to. */
> +	unsigned long tot_in = 0;
> +	unsigned long tot_out = 0;
> +	u64 start = cb->start;
> +	u32 len = cb->len;
> +	const u64 orig_end = start + len;
> +	const u32 blocksize = fs_info->sectorsize;
> +	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
> +	unsigned int cur_len;
> +
> +	workspace->params = zstd_get_btrfs_parameters(workspace->req_level, len);
> +
> +	/* Initialize the stream */
> +	stream = zstd_init_cstream(&workspace->params, len, workspace->mem,
> +			workspace->size);
> +	if (unlikely(!stream)) {
> +		btrfs_err(fs_info,
> +	"zstd compression init level %d failed, root %llu inode %llu offset %llu",
> +			  workspace->req_level, btrfs_root_id(inode->root),
> +			  btrfs_ino(inode), start);
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	/* map in the first page of input data */
> +	ret = btrfs_compress_filemap_get_folio(mapping, start, &in_folio);
> +	if (ret < 0)
> +		goto out;
> +	cur_len = btrfs_calc_input_length(in_folio, orig_end, start);
> +	workspace->in_buf.src = kmap_local_folio(in_folio, offset_in_folio(in_folio, start));
> +	workspace->in_buf.pos = 0;
> +	workspace->in_buf.size = cur_len;
> +
> +	/* Allocate and map in the output buffer */
> +	out_folio = btrfs_alloc_compr_folio(fs_info);
> +	if (out_folio == NULL) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	workspace->out_buf.dst = folio_address(out_folio);
> +	workspace->out_buf.pos = 0;
> +	workspace->out_buf.size = min_folio_size;
> +
> +	while (1) {
> +		size_t ret2;
> +
> +		ret2 = zstd_compress_stream(stream, &workspace->out_buf,
> +				&workspace->in_buf);
> +		if (unlikely(zstd_is_error(ret2))) {
> +			btrfs_warn(fs_info,
> +"zstd compression level %d failed, error %d root %llu inode %llu offset %llu",
> +				   workspace->req_level, zstd_get_error_code(ret2),
> +				   btrfs_root_id(inode->root), btrfs_ino(inode),
> +				   start);
> +			ret = -EIO;
> +			goto out;
> +		}
> +
> +		/* Check to see if we are making it bigger */
> +		if (tot_in + workspace->in_buf.pos > blocksize * 2 &&
> +				tot_in + workspace->in_buf.pos <
> +				tot_out + workspace->out_buf.pos) {
> +			ret = -E2BIG;
> +			goto out;
> +		}
> +
> +		/* Check if we need more output space */
> +		if (workspace->out_buf.pos >= workspace->out_buf.size) {
> +			tot_out += min_folio_size;
> +			if (tot_out >= len) {
> +				ret = -E2BIG;
> +				goto out;
> +			}
> +			/* Queue the current foliot into the bio. */
> +			if (!bio_add_folio(bio, out_folio, folio_size(out_folio), 0)) {
> +				ret = -E2BIG;
> +				goto out;
> +			}
> +
> +			out_folio = btrfs_alloc_compr_folio(fs_info);
> +			if (out_folio == NULL) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +			workspace->out_buf.dst = folio_address(out_folio);
> +			workspace->out_buf.pos = 0;
> +			workspace->out_buf.size = min_folio_size;
> +		}
> +
> +		/* We've reached the end of the input */
> +		if (workspace->in_buf.pos >= workspace->in_buf.size) {

There is a bug in the in_buf.size comparision, which the old 
compress_folios() code is using @len, which is the total remaining input 
length.

This results early exit of input reading and error out, thus zstd always 
fail and fallback to uncompressed writes.

> +			tot_in += workspace->in_buf.pos;
> +			break;
> +		}
> +
> +		/* Check if we need more input */
> +		if (workspace->in_buf.pos == workspace->in_buf.size) {
> +			tot_in += workspace->in_buf.size;
> +			kunmap_local(workspace->in_buf.src);
> +			workspace->in_buf.src = NULL;
> +			folio_put(in_folio);
> +			start += cur_len;
> +			len -= cur_len;

And @start @len are both updated, making it much harder to grasp what 
we're comparing to.

In the next update those two variables will be updated to constant, and 
the old current input file offset will be @start + @tot_in.

> +			ret = btrfs_compress_filemap_get_folio(mapping, start, &in_folio);
> +			if (ret < 0)
> +				goto out;
> +			cur_len = btrfs_calc_input_length(in_folio, orig_end, start);
> +			workspace->in_buf.src = kmap_local_folio(in_folio,
> +							 offset_in_folio(in_folio, start));
> +			workspace->in_buf.pos = 0;
> +			workspace->in_buf.size = cur_len;
> +		}
> +	}
> +	while (1) {
> +		size_t ret2;
> +
> +		ret2 = zstd_end_stream(stream, &workspace->out_buf);
> +		if (unlikely(zstd_is_error(ret2))) {
> +			btrfs_err(fs_info,
> +"zstd compression end level %d failed, error %d root %llu inode %llu offset %llu",
> +				  workspace->req_level, zstd_get_error_code(ret2),
> +				  btrfs_root_id(inode->root), btrfs_ino(inode),
> +				  start);
> +			ret = -EIO;
> +			goto out;
> +		}
> +		/* Queue the remaining part of the output folio into bio. */
> +		if (ret2 == 0) {
> +			tot_out += workspace->out_buf.pos;
> +			if (tot_out > len) {

Another victim of @len usage. The @len here is the remaining length of 
the input, another location causing zstd to exit early.

> +				ret = -E2BIG;
> +				goto out;
> +			}
> +			if (!bio_add_folio(bio, out_folio, workspace->out_buf.pos, 0)) {
> +				ret = -E2BIG;
> +				goto out;
> +			}
> +			out_folio = NULL;
> +			break;
> +		}
> +		tot_out += min_folio_size;
> +		if (tot_out >= len) {

The same here.

All will be fixed in the next update.

Thanks,
Qu

> +			ret = -E2BIG;
> +			goto out;
> +		}
> +		if (!bio_add_folio(bio, out_folio, workspace->out_buf.pos, 0)) {
> +			ret = -E2BIG;
> +			goto out;
> +		}
> +		out_folio = btrfs_alloc_compr_folio(fs_info);
> +		if (out_folio == NULL) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		workspace->out_buf.dst = folio_address(out_folio);
> +		workspace->out_buf.pos = 0;
> +		workspace->out_buf.size = min_folio_size;
> +	}
> +
> +	if (tot_out >= tot_in) {
> +		ret = -E2BIG;
> +		goto out;
> +	}
> +
> +	ret = 0;
> +	ASSERT(tot_out == bio->bi_iter.bi_size);
> +out:
> +	if (out_folio)
> +		btrfs_free_compr_folio(out_folio);
> +	if (workspace->in_buf.src) {
> +		kunmap_local(workspace->in_buf.src);
> +		folio_put(in_folio);
> +	}
> +	return ret;
> +}
> +
>   int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>   {
>   	struct btrfs_fs_info *fs_info = cb_to_fs_info(cb);


