Return-Path: <linux-btrfs+bounces-9488-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A78C9C4E12
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 06:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B87C2887E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 05:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C8E20A5E4;
	Tue, 12 Nov 2024 05:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IfXri57j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F3620A5D3
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 05:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731388449; cv=none; b=ngl/+cCXvU6D1+GIzg3/5J8Gdl764tqVOQrDoLiwxNGrX++cptaKAsmFWGRQO3+H4Gz3tEVrjsIFtMphKji2x/V17criMF0wYntQj15NMbhgmZ7XF/liQf11PdaFuOlVT1smwfxSbjhEfe7r4R4pgvRZ///uVZ8Z6IMffJzcAlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731388449; c=relaxed/simple;
	bh=UVEZKpcKg9QCj/okJxJAdN+0jfe4PiYu++peCVwSkRo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=pyRKP+o+86QU+GxjGsFsPUxeda9AhEvhLN+lofivRSH14F69OdiHb2guAAfCqsHxh4QgMR+NaYMVixvn0OLPp5C4v/zBYJeE47PAx3zGYHkNfOWLBUv+QszrlOAXyL6K/yOJNMefvd7KXA4/nxOukSZgwkO11hFhfZ11xBZriBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IfXri57j; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53c779ef19cso6197819e87.3
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 21:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731388445; x=1731993245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hd0WkmLd9kzYTvtTQK7D8ZgWKJFvfwWeEsC/5QB0mEM=;
        b=IfXri57j7PCn4XJRK0TeUAGbx1nc/eTMmp28bmvcdfYpU3IRg1DaHgZ6M00ANdRsFh
         ObMDzPh7lff/3f1nsrRhHlRnvSCAveJF3SDtznbSOR129gbd5//WxYcwmPutrZ/nL3jw
         R0swb6ErKqOhciYIUSzcpHNql+A/b24GDhxBpt+2m09o/ffymgi5Kld0whJU7UssBjbd
         rjmFHQKzXMBjbyfNhZJIPOKuXIeO+INYfr7xZM+WzgzHvv2GWWaiZ2hgVZ7OycK1hd1r
         ysfViOpAQbAozyPgkH2bXIFlR7I2oiqd4mfyohfq5rQQum6tpWltesP4N4YtWRM0/KX/
         qUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731388445; x=1731993245;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hd0WkmLd9kzYTvtTQK7D8ZgWKJFvfwWeEsC/5QB0mEM=;
        b=rwJsqj2JgZdOxrv60KZ+eDSwQ/C8q+KXW5VtmqvLA37SM2I/RWzLDiophcypJR4JWF
         osvVr0Qb4MXOnfzfmHWan+WIk/4FX0kExzoROUIElG6dqsJWfC93q/EKpAOpxjgLKKfW
         EAiAGB4OmLTbGd52/aIjC0gXm1SYR3Ed1zO5n8ujjrLBzRPhdoSISLeHbSiso537mu3c
         6Sx9SaS93mjTcInBgPKlYfAwxmMdU+j09i2MwdsYRMbHfZoR3CndGUgmS+GzvZZqWGTA
         LV/3POnKBKzqGW4d8iYbty0iw6OzPnpDYHcG6W9vUxiG/5LYT9TWl9DaX+YZLPu7ABo4
         9sLw==
X-Gm-Message-State: AOJu0YyhtiXEjjHfPvrXW6XwFHd9MZNDqgGLi06oGx6QNXB+OrSp8umb
	ai+siLlngjGss9Olnd9fx02w/WIq1bl3zAhgOrNRFFiVYHuiX/TgS7W2X0fAycOo6fgxdJa6YyC
	M
X-Google-Smtp-Source: AGHT+IEXnqHW4+Ek52zimsJLcvepmwzquh+E5iuwO/DWvtCanwp8ZSDOWJIERcxEjPpSZWE6+tVQAQ==
X-Received: by 2002:a05:6512:b93:b0:539:f689:3c30 with SMTP id 2adb3069b0e04-53d86289e48mr6818187e87.20.1731388444655;
        Mon, 11 Nov 2024 21:14:04 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc835fsm84917375ad.41.2024.11.11.21.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 21:14:04 -0800 (PST)
Message-ID: <e718febc-a73e-459a-8716-f0d70495eabd@suse.com>
Date: Tue, 12 Nov 2024 15:43:59 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntfs3: remove a_ops->write_begin/end() call backs
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org, almaz.alexandrovich@paragon-software.com,
 ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org
References: <ec1574d80e4b98726e6005a31f3766d84810ca6a.1731387379.git.wqu@suse.com>
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
In-Reply-To: <ec1574d80e4b98726e6005a31f3766d84810ca6a.1731387379.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/12 15:28, Qu Wenruo 写道:
> Currently a_ops->write_begin/end() helpers are only called by the
> following exported functions:
> - generic_perform_write()
> - generic_cont_expand_simple()
> - cont_write_begin()
> - page_symlink()

Please drop this patch.

There are two more exported callers:

- __generic_file_write_iter()
- generic_file_write_iter()

And ntfs3 utilizes __generic_file_write_iter(), so the write_begin/end() 
call backs are still required.

Thanks,
Qu

> 
> NTFS3 doesn't utilize any of the above functions, thus there is no need to
> assign write_begin() nor write_end() call backs in its
> address_space_operations structure.
> 
> The functions ntfs_write_begin() and ntfs_write_end() are directly
> called inside ntfs_extend_initialized_size() only.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/ntfs3/inode.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index be04d2845bb7..6b4a11467c65 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -947,9 +947,6 @@ int ntfs_write_begin(struct file *file, struct address_space *mapping,
>   	return err;
>   }
>   
> -/*
> - * ntfs_write_end - Address_space_operations::write_end.
> - */
>   int ntfs_write_end(struct file *file, struct address_space *mapping, loff_t pos,
>   		   u32 len, u32 copied, struct folio *folio, void *fsdata)
>   {
> @@ -2092,8 +2089,6 @@ const struct address_space_operations ntfs_aops = {
>   	.read_folio	= ntfs_read_folio,
>   	.readahead	= ntfs_readahead,
>   	.writepages	= ntfs_writepages,
> -	.write_begin	= ntfs_write_begin,
> -	.write_end	= ntfs_write_end,
>   	.direct_IO	= ntfs_direct_IO,
>   	.bmap		= ntfs_bmap,
>   	.dirty_folio	= block_dirty_folio,


