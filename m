Return-Path: <linux-btrfs+bounces-21258-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBVBJMdlfWkNSAIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21258-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 03:15:35 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B69C03EE
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 03:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39C38301F7B6
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 02:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C1B3321CA;
	Sat, 31 Jan 2026 02:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TS8e5H9M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E718B35958
	for <linux-btrfs@vger.kernel.org>; Sat, 31 Jan 2026 02:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769825715; cv=none; b=t2++zHAGKs++1/Ch6HiuQiRkscuB2u8lvyMU1SVHWl719/Wy4XEk2Tq7CBQ8se3ZwykB39e6BHjQVSEb2ySQ4Gxs+zfvkiHHARuA2VL7A8H2p/g3LHLzAREBVJuQow9BT3tJUMeddS+ifuzfsooU/DgLorGgDrtTogwHGzkErGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769825715; c=relaxed/simple;
	bh=hUllYlPnt0ETxaZQcsufWpl77nldp+7uB7MyaAkvns4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DGRDYaocapeh/D/A/YjL6+A0cDUrAX4GyeVPtKtE7o2Pjv4KcjiykKA7SF4f7X9RcMZrvs6VZqyTBm0flYcNexuflVMn6lqMUjdIPQN9zBd4vy7TIlEM4A4DwT2d5gONFE26j90VeKQ/ahRfZuCQ9I5L99x0TdO9Kl4bhIJDGbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TS8e5H9M; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47edffe5540so32831155e9.0
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 18:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769825711; x=1770430511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0Y+WdaoToPK7fv1Sjt6lzrlUiy1kAIw2XidJEunnL2A=;
        b=TS8e5H9MVddHyjoCize5FyxBLejkcydL8krDQ4JVzI0p9gaC5PddRSfdznb1sHR2kY
         /IL0+k0F2YFZn3onrudUVb8sHNeMBcCfLafUtjCIBX8PlrNvm/FNNu5hrN0vx+rwZUmS
         qgljQTvvJlPm4TvOlcyO/fRXXzU2148qvqYbiJhYzr6zhDl/PrzJM/+gxUyprJfydY4v
         Lhg5syQCqnQJQuK4EOZD210N/SV1Wu23nfY4gPJmqnFaIDHLu6zmn/whmtHBbBYJKd8Y
         Fu2ebe2pOyO9wbrInK5Go4zvBs52qGqw6k9c4bhmCNHOx3kQdoR5pDKl2Mi5DwiD9lA6
         RiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769825711; x=1770430511;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Y+WdaoToPK7fv1Sjt6lzrlUiy1kAIw2XidJEunnL2A=;
        b=IeeCR9KYdHL4NoXr+gN/zPMmGMeXQX/fVLoecxjuJf0WQUMxP/nF9j+pu4jivDjKhs
         rf6ym0eTunJnsZL1/8XiTJewtuexkjdB2hvtmwUjk8qfVdxAvNkYRqWjzY/30ke7PQps
         A7oiYH/2GPd4v63pFAunJg4urSpct6IxzlYbijWmK16KlKipubqfUN/SLib1Rw/N3GhM
         zrVYYrf/rTRHVoAUxb2tfRe0M16RXVaql52F8qHvgcbtLSdDrkngjspcL/oeGthYvmda
         YBMTzHwfxQHmZ4gc5HHD71TNqV8kxSFOKntW6CVX1INnRORQo3e8IL6usvfqG2yL0S1f
         jQrw==
X-Gm-Message-State: AOJu0YzT97o1CxBb6QseQNk/KwOBLLPok1t1EZM3ISdnTfnDLwyyVS8s
	c8xG/UmJJ9Olp5xHYg3+gDB4jMb8dJpb8hddNxag3xaoOueT9Ml7yQCq/agNc/1FnXc=
X-Gm-Gg: AZuq6aLhhdvRW1gc70HvqGaB5PNIq/tOV81o5/BD1+IvWX3v4z930TudiJavvb6QCXu
	mqOASEZL7Qa36XguNkuJOYKQYKDSg/yX91o8ADZWy256YC0ShcpRFd6PcWZ+yD0Moyw9ulApYPH
	PugHNqbP0mXqvrEouEv0zZ0pmYWW+km8eURtmP1sgIPRWMhe2f880ZzDTTwVhlMPHQ1p1IPWv1L
	xdCwzlOrWxBNiny6N1IJRJUuU7Mmna3ivZFl7CbTxBniSwnJQwal+mUV7Yq5LOMZ6w62LmfMPLI
	DdwDWUT5dE3FRpxDoZ71fJzKIF2g56NRSj0vbf7wY4u1vHrS4XlivDNB90ZyGzJ1JH2XuR2xeS1
	wGY6sSjdunJVKcacoVNHP/s1+Yjh3RySxlz1rwFRn+Wavfp8V14kEPTgwMpmfcZSEj0E4DtHSFw
	P/Ovzrwoa1nz7GZnTgq0pH9qhO9vjqUYv3uVTG5W8=
X-Received: by 2002:a05:600c:c4a3:b0:480:6c75:ddce with SMTP id 5b1f17b1804b1-482db49da16mr66399755e9.33.1769825711050;
        Fri, 30 Jan 2026 18:15:11 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f17955asm9038511a91.0.2026.01.30.18.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 18:15:10 -0800 (PST)
Message-ID: <9e1bf022-730d-4b93-872a-259490eb4946@suse.com>
Date: Sat, 31 Jan 2026 12:45:05 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: guard against missing private state in
 lock_delalloc_folios()
To: JP Kobryn <inwardvessel@gmail.com>, boris@bur.io, clm@fb.com,
 dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <20260131013438.286422-1-inwardvessel@gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
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
In-Reply-To: <20260131013438.286422-1-inwardvessel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21258-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,bur.io,fb.com,suse.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 01B69C03EE
X-Rspamd-Action: no action



在 2026/1/31 12:04, JP Kobryn 写道:
> Users of filemap_lock_folio() need to guard against the situation where
> release_folio() has been invoked during reclaim but the folio was
> ultimately not removed from the page cache. This patch covers one location
> which may have been overlooked.
> 
> After acquiring the folio, use set_folio_extent_mapped() to ensure the
> folio private state is valid. This is especially important in the subpage
> case, where the private field is an allocated struct containing bitmap and
> lock data.
> 
> Failing calls (with -ENOMEM) are treated as transient errors and execution
> will follow the existing "try again" path.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>   fs/btrfs/extent_io.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 3df399dc8856..573b29f62bc1 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -332,6 +332,18 @@ static noinline int lock_delalloc_folios(struct inode *inode,
>   				folio_unlock(folio);
>   				goto out;
>   			}
> +
> +			/*
> +			 * release_folio() could have cleared the folio private data
> +			 * while we were not holding the lock.
> +			 * Reset the mapping if needed so subpage operations can access
> +			 * a valid private folio state.
> +			 */
> +			if (set_folio_extent_mapped(folio)) {
> +				folio_unlock(folio);
> +				goto out;
> +			}

If the folio is released meaning it will not have dirty flag.
Then the above folio_test_dirty() should be triggered and exit with 
-EAGAIN. We will re-search the extent io tree to re-grab a proper 
delalloc range.

And if the folio is still dirty, it means it must still have private set.

Thus I'm afraid this check is a little over-killed.

Thanks,
Qu

> +
>   			range_start = max_t(u64, folio_pos(folio), start);
>   			range_len = min_t(u64, folio_next_pos(folio), end + 1) - range_start;
>   			btrfs_folio_set_lock(fs_info, folio, range_start, range_len);


