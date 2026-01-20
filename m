Return-Path: <linux-btrfs+bounces-20786-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPRmEVAJcGlyUwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20786-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 00:01:36 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4244D6A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 00:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC43994D426
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 22:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684AF3D34A4;
	Tue, 20 Jan 2026 22:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O7TdXsoD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9BF3ED128
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768949576; cv=none; b=hsapRX7KV2O+HVl+KhRQZrUF8OsKQrgfHxpnmF0tIp+vtTkaugJQPic6Vk3FZmKgN5C1QQDbI6Ro+tsUWdHCMxRGY0g8ZcX0GGQFVRLdiiTIg6tu43awWJr7jX9EicZtdbkufSqJxjhiw25NOn3bICHmzbGSZz53Yk4+9AfPpr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768949576; c=relaxed/simple;
	bh=qD/j26TG8QB/fvfqN+5aQUCl7c2plCaXil2V0bd2omE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=X+/TL1gydgFxvAdZ5TD5aTUGXFqBSepH4asbhw8PwXSdMVDQ8RxVh1AfUEPmTaemc2lsnGKDHgj+TJ6dI/IiQpwRzumU/uDBfd1KH0kFzc7QtwwNjSOVU+xwIbwvGj99pXV57ir0eldBB5+37KS3e2uewtgS7YTfea8uChzMD+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O7TdXsoD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4801c314c84so38585815e9.0
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 14:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768949571; x=1769554371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S4KjfyJdWQNEIqVWGJNO+4LCq8tlO+7CgBGNqDLqJz4=;
        b=O7TdXsoDSgf5/wS0w90/6Rq2mOajxhVz7XgLcJVAbWpYSeqzL8khoxytg7CC/2VcE4
         fg0vX9pPy07anYnnkD3oMavnlQv13XZ4NNJv6sxXikTFNh2KmElOZ8Zwy1a0MYq0Kew0
         0aKfUxlZmHaB1wpjHQIriTfxgMm0PV5E4sJ0+5zDCZD00J/3w79yXOaKkSIPMdGdskPh
         X8Onf+762IQSHyzBWOZ48qhljl5ZrMEH5S0zWX1kTpyTY5Qw1Qp2dj17Uz9y6yyiVQz5
         OrxWfMvmZdcAy/729ngHuktgoyNM4XlwxZYppwWoL9APa+6mlxE3W1ZxWq2roZXu/CAO
         fEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768949571; x=1769554371;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4KjfyJdWQNEIqVWGJNO+4LCq8tlO+7CgBGNqDLqJz4=;
        b=Ku/iJ/o4Op+7tuW4DM2KwHoTy4lOO/O51aTuQyMVuVwL0iys5YQa4G9GGU20Doowbv
         kaZwwSL+9BnLUkDu4ANgNdiMsjPHsxVtdPiylmrU71xxMod6b4JSrRwj1WTYwD4HLaYA
         GBsjtr02foneTWyj7sZEhLs/wMivhaoFv0LLmjcF7jt09lzwHf+rxS/BrTV2VvYIwlPk
         SEU0ROKuff99xAqyrGNgUtuBXA+kvlaWkd8/13+MPq4xYH+LGVtIMCsJAQLqKtvDYVum
         BwMVWqD030cfre5gxa36PEq4TEIK8lftJAo2RO7n1OH06UQjbt7K1IFVcW5XXzHAdhe7
         DOVw==
X-Gm-Message-State: AOJu0YwjUUr92vL9TltjYoedT5BSly13u6oeK/C4QNIq/i1BOKQSVnNi
	UmnNMIh9QFjOU07U+SlUKReOctORLYBUI0S55MrvO9TFTOUYxX5S2JKjCajdgMWAq2ZVZKpXZC+
	OGGaw
X-Gm-Gg: AY/fxX7s5qNDJ5pHjOMDSAEZveCbMjs0WnYp9rI+/DHELUASLVQkHHtqQoaPk7kGNM5
	iAtOMbHKs04K4IqLD8y26BhsmmfTkoyM/zF0REfiKu6r3kvKkDLN88ja3Z22Is1ZU5EBui2O/0k
	5+W6PcfNYCFhlOrRPjM+n3U2pO+Heaty1AGB8zu6p3GkJw8SeNGpfwviiIjZv4qMYs5Kk/WXw5n
	EYyzgHYYPEv+PWwLw+Ka4Rh8FblOoVn+CVT5JR7y7u3SLn1M5f8n/86/E5wWx4aTbX6ieZlgOQw
	iynQHSdgHC7hLv5/Tf10oL48YfTUHSdWjV7KqmIeyOa1UAPL7NR0KbfIx41d4wn7RPFyENakH2P
	Z5ULmi+6f9peImp7zszvAaePIaufy5JeS3p3bj3Fns+/YmR46G7xl0KICayNcMUZ/PA6JKwqNDK
	6/q+no3R0ApEiC3lTsX91qHZjk8pVNia/Y8bUpqBs=
X-Received: by 2002:a05:600c:c178:b0:477:a977:b8c5 with SMTP id 5b1f17b1804b1-4801e34cd0emr235686375e9.31.1768949571510;
        Tue, 20 Jan 2026 14:52:51 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf355ca7sm13058529a12.27.2026.01.20.14.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 14:52:50 -0800 (PST)
Message-ID: <1218d786-ad7a-4971-9cd5-273232f62d79@suse.com>
Date: Wed, 21 Jan 2026 09:22:47 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix the folio leak on S390 hardware acceleration
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: linux-s390@vger.kernel.org
References: <bcf36edfb7ac3caf3373174e741bb29c0feb268b.1768802004.git.wqu@suse.com>
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
In-Reply-To: <bcf36edfb7ac3caf3373174e741bb29c0feb268b.1768802004.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20786-lists,linux-btrfs=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: DF4244D6A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Adding S390 to the mailing list, I got the incorrect address in the 
initial patch.

Much appreciated if S390 people can give it a test.

Thanks,
Qu


在 2026/1/19 16:24, Qu Wenruo 写道:
> [BUG]
> After commit aa60fe12b4f4 ("btrfs: zlib: refactor S390x HW acceleration
> buffer preparation"), we no longer release the folio of the page cache
> of folio returned by btrfs_compress_filemap_get_folio() for S390
> hardware accerlation path.
> 
> [CAUSE]
> Before that commit, we call kumap_local() and folio_put() after handling
> each folio.
> 
> Although the timing is not ideal (it release previous folio at the
> beginning of the loop, and rely on some extra cleanup out of the loop),
> it at least handles the folio release correctly.
> 
> Meanwhile the refactored code is easier to read, it lacks the call to
> release the filemap folio.
> 
> [FIX]
> Add the missing folio_put() for copy_data_into_buffer().
> 
> Cc: linux-s390@vger.kernel.orgaa60fe12b4f49f49fc73e5023f8675e2df1f7805
> Fixes: aa60fe12b4f4 ("btrfs: zlib: refactor S390x HW acceleration buffer preparation")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/zlib.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index 6caba8be7c84..10ed48d4a846 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -139,6 +139,7 @@ static int copy_data_into_buffer(struct address_space *mapping,
>   		data_in = kmap_local_folio(folio, offset);
>   		memcpy(workspace->buf + cur - filepos, data_in, copy_length);
>   		kunmap_local(data_in);
> +		folio_put(folio);
>   		cur += copy_length;
>   	}
>   	return 0;


