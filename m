Return-Path: <linux-btrfs+bounces-14000-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A41AB6902
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 12:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C453B2900
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 10:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FE2270572;
	Wed, 14 May 2025 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UoEb5bEE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BAE1C3039
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747219114; cv=none; b=ZfcOKQtGAkfmXzyVlXUSQjEVDK93/+3UH67MKnn4ERV+fx3rZpwc2vyuK/zin+JzkXl5126f/RUN1eTYNDTU+dQM0Ekc2HyyOqiKZe4SBPmSy6WCarLPUzmcbaWMlYF9Em+Z6r9Tzm/yuKBVQJJlfchM3N/2JWLR4chlnfFl9kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747219114; c=relaxed/simple;
	bh=YLkAFewBnEqhi2WJcrtP9mcMB4jKpCMzD7esG2bAiPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TxTYn5w0RGhnztPIrFIcuVc3B2hQlD6V4M7R6HW2rw/91CALsnNd4MqWsmsbedzsBhU2oCAAuph6TDxa+DYyxHVXHNfB1xUxF31Jyz33TGUojJ2MSwYG0fIfzeKliCvqok8WjcPGROlYNCiG981eBjfXZDt1TLHDpHfYA9npn3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UoEb5bEE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a0b646eff7so5733342f8f.2
        for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 03:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747219110; x=1747823910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VCx3frTqDdMtOTFlXWmpS2+SPgfXepQmjJ37oZP+u0k=;
        b=UoEb5bEEhk3Ti1fNBn//oztUlTqikw1XSseT7dor2bFjMbl8+IXxtYxDZgVrBANR6i
         Ag++R+f49hHGEpEi9A16PKFi+Yo4ldkT9gja15rA/d+Vy6H4imQch1C67m6BdwMv7/rX
         A/hJF7eIJWGBncUpnLbVALVfUctnMaBcgTz2tOPIydorPvX29x5e5jhV+1JPrsSHJvdz
         a8zQAzA2q8Yk6SCDBI3IyK57ZSfsfLMYnkFIkJguIhw6G7rsuO/VMj580VmDVmzab3cR
         YzitCuUudpivsVpSaEZfAdV69argiztwCljapjoXrhoX0K5/a62uQ63eFDqnPEA+YiH/
         dkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747219110; x=1747823910;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCx3frTqDdMtOTFlXWmpS2+SPgfXepQmjJ37oZP+u0k=;
        b=QKlOXsnZ4+MQFrWsGjDKFFncQC2IDxR53atdyhdi3mWjrGSOwVVTAbCLGhE1gIyFXN
         qwa6qUiPsaMVvH/2k2Be7+D5sEzGtrHYYzxaBkqJM44te2EUEAHd66l8m0ccQOV3oIea
         wSwppRdJVJPIB8U1y6FSu2b8fdMYrtcNGx/uVIvhgu7czU+HTvDTC++6/etHQS476Kcy
         H3LL0Qn7iTuZZGDmBFLlNqbkneHxXfai6qFU0pfRlsUthRKpZDcgBeS/fta/bbvdZ2FE
         y0JaL8MfEc1bp4jxQnExtc4tV9VF07t4V+fuoiDuY25pg6Q0EXJhppgMiWiuexPzUwL7
         jjcA==
X-Forwarded-Encrypted: i=1; AJvYcCXgyckzwXMn9Jfl7vk9+MlK8eE/M0sGEd7+Yeyp24LyaVXajHzrfvlstngSgpzSxZbqfntB9MqRwrgGeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsT53AF35qIIh77VBQVJkRW402A6I/RMoFSQ3yGraOOSQTPiP9
	Tp97aVrGDPt3et3CUu3MwI8kC72ff4G+eIWQJHqtOltuWqZ8QP0ts0VrDJMOurc=
X-Gm-Gg: ASbGncu9QgWbZ6XjpWsFNnzH1vKbaex1QnfaoxN229bR3d4Lc+fEfJ+RPV4G8DDLN+I
	kcYoamBDDZlx9k3+Zh6nesNY+FvNuaTyx3SKefHaVTpn+m/hePk7feaVtyVWAbt51rCF3Mzk3Oi
	COCTI3FJkIFq66lqUNAZKopzWOlnBHreg4whEKvBCpkyzSEUE1BT4IgoIaj0EB+hveL/2578dRT
	yMJoIzHAWNZlMR9eQsxM+XU6ui9Y316aUOVwXHHOriQwNNd1ZP1xs7iPknRGH+EIHdRUmYbVvWY
	+WM/AHYmzpQN6eXQgTLgUA+GWg5fdIHvi88esuZReIqoIyNnDLutjxgkbxRo6EkuG+pLDhVm4Bf
	p3r8=
X-Google-Smtp-Source: AGHT+IEIvdCrUMetbRuioUxA5W/qovD7Si5RS/2KsyRzEsN3PZjsNqSOFRr0fGTGy2DE+Cl+650RUg==
X-Received: by 2002:a05:6000:178b:b0:3a3:2aa4:6f6b with SMTP id ffacd0b85a97d-3a34968fb49mr2406686f8f.1.1747219110340;
        Wed, 14 May 2025 03:38:30 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::c8a? (2403-580d-fda1--c8a.ip6.aussiebb.net. [2403:580d:fda1::c8a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc82bfad1sm96637365ad.250.2025.05.14.03.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 03:38:29 -0700 (PDT)
Message-ID: <fc07ef6d-fbec-4708-a0ca-10259530298a@suse.com>
Date: Wed, 14 May 2025 20:08:20 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs: fix wrong start offset for delalloc space
 release during mmap write
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1747217722.git.fdmanana@suse.com>
 <79efbad28a262a6dbe07decd0f49b5a91a167c15.1747217722.git.fdmanana@suse.com>
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
In-Reply-To: <79efbad28a262a6dbe07decd0f49b5a91a167c15.1747217722.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/14 19:59, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we're doing a mmap write against a folio that has i_size somewhere in
> the middle and we have multiple sectors in the folio, we may have to
> release excess space previously reserved, for the range going from the
> rounded up (to sector size) i_size to the folio's end offset. We are
> calculating the right amount to release and passing it to
> btrfs_delalloc_release_space(), but we are passing the wrong start offset
> of that range - we're passing the folio's start offset instead of the
> end offset, plus 1, of the range for which we keep the reservation. This
> may result in releasing more space then we should and eventually trigger
> an underflow of the data space_info's bytes_may_use counter.
> 
> So fix this by passing the start offset as 'end + 1' instead of
> 'page_start' to btrfs_delalloc_release_space().
> 
> Fixes: d0b7da88f640 ("Btrfs: btrfs_page_mkwrite: Reserve space in sectorsized units")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just curious how did you spot this, by pure eyeballing or you have some 
tool exposing this?

Thanks,
Qu> ---
>   fs/btrfs/file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 660a73b6af90..32aad1b02b01 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1918,7 +1918,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>   		if (reserved_space < fsize) {
>   			end = page_start + reserved_space - 1;
>   			btrfs_delalloc_release_space(BTRFS_I(inode),
> -					data_reserved, page_start,
> +					data_reserved, end + 1,
>   					fsize - reserved_space, true);
>   		}
>   	}


