Return-Path: <linux-btrfs+bounces-16607-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 409EFB41005
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Sep 2025 00:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8CB48825F
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 22:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0673A2773FA;
	Tue,  2 Sep 2025 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wc2qtjjv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA6A275AF5
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756852043; cv=none; b=YXeSoWmfEhOY+lBjsX2W5xuyU2AAit4eKIm9MNlcAudzpuNOht26KxKDc4kzMILip0Zzd50Du7zBC69hX14lm4t5rL1sw1Xl7wvdz1PM+lbnwsVPoI9bYfD1M3hMo67F1ZLcmwPNc7wIgmuoeDg2+7hchHuCoeXtn5Ev2KlFQZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756852043; c=relaxed/simple;
	bh=VhzDwRXislpuhfxl5JmOC+7U1fmkTLC3CFWXYF7yvUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GrHDHaJEPB2jHTlXfH8JoysEYUUXi+CpPnTCu0zAf6V2lP4+M9QNpR0Xgk26RzjpBfdo4MkiIT6EOS2DNtZNxmHCZmX+/h3sE6BzGgsn7gZaehCniO/smqfSRo8RnRiqWU/2RDGkdTNNkZCYe2DDcBsckTX83TDrbXn/Rk3Kqus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wc2qtjjv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3dae49b117bso1052819f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Sep 2025 15:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756852038; x=1757456838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WzD65PaAJkA8qRlCZYXV02FKe4apg2z1HYBuuXVayLw=;
        b=Wc2qtjjvz2wB8SyTn6dynB43V56tuomWy8LWQ6bM0o1ERdBQ+Je9B1OAU3fdhuLCQD
         TqjNDBo/hHWH1umZ6EzIqGlsctD4TtsVBt4jVwn0dRcx5AcubwVIUqNJ0wtW38LMxdMa
         vFlIQ4oAUNdaLCQfU20oqJenDf1KSZCHvjk68sjqt+mVBwseuZCQIZ0EZnFtCmVI9iGH
         +Ks6ki6jn6uURwH+b6MqSYS5qFnALIUkcJ492gGRGAc/QThExwuWALb6XNfp+P9CRFI6
         99M/PNSPsnmy0EEuVDvGlajwr8RICddNZv+cvx4n984Z+3pbfnNgw8l2fCXXUBfMpD0Q
         f3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756852038; x=1757456838;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzD65PaAJkA8qRlCZYXV02FKe4apg2z1HYBuuXVayLw=;
        b=fW2ylTjfSlSfaZvs9X7UMqGgXBidCuTWyQ8frK58WJjFe8jIAtPYOwUTDSEeDYFtmr
         FN8mXmXuZn84fdTg5/nUbmAQMt9OBwj+ZPEF8DL+uAFQc2l4zfhTa3LCEZEO8Nk1HHP2
         HZWIbkau4E0pfPoPHYRDAsW7Txj8e0Kqu0Z908a634OLmxFHUZn2+R9nkUgF6IrKQtXe
         j8D4tElCI7LER4Rq2WlEpbQ+yq7jzuxxukQg2kohjWTwHuAKPpSzQLpj5qkA8Jkys+BF
         FVte5zKgUMoaQnMB+C3g26r7A+xoJAhVraYO06+lBx2L3ng2ZnlOIJWC0BsLDkjajSCw
         IAlg==
X-Gm-Message-State: AOJu0Yy2t0wbsjmGp1LVB3nzzI3zBeJzpuf9aOIyzc5Cd5bhYLv0Eao0
	7TV69Gd0AyicnyqSVjmNft5xWjD4Ml2pALwHsbefQOUneE9yMaFfIX5O7KncjaLlmdw=
X-Gm-Gg: ASbGnct4ntiLmsKHKG4zjj3WWOnOAKhOISKgrqXjVWUwCd6H9FASmaRkfJKG/OyMHia
	yR3cKSMlwH5naAOPmHC4sYZeDrS/MOzR60e6/yPG6BGLblB5dm/sS7tosCDCaviP7mx8sIZxKKO
	0crRfE5kn8uxKoQsJWPUNICfajEcJellq+WJZHAgEOW7j1u47M3uzeMfDP1Vm6ok+Woh2eQrywu
	GcVtbGkv0lEoGU3l/JjtwfbZrR9dFaP6D4uiWvZnrz8iIoAC6TFPpIP+DYlPe5UaCA5R1j9hzLw
	y0qC9EDJB/0ZtqcTBNtACO5m+QbTHxMNVZPddVGBK0mc3GwRs4zs2TSPfeNCzn4MWKCWsHL2uhg
	6Zygt/+bS+dcoYyRkKYWvT2PN7x5KO8XL6cP8f2zn9gW1fkmnAYe/VAywVrkooQ==
X-Google-Smtp-Source: AGHT+IHsjiNRH3/3m6/0auq2GXXY0wRA+grJoi8LQiE038AvG4VVzHR9N1oqZso390zsQFCpGcQ2Qg==
X-Received: by 2002:a05:6000:25c6:b0:3cb:c173:86e8 with SMTP id ffacd0b85a97d-3d1def69b6cmr10712292f8f.47.1756852038440;
        Tue, 02 Sep 2025 15:27:18 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28ad188sm12802364a12.26.2025.09.02.15.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 15:27:17 -0700 (PDT)
Message-ID: <a32bfa7e-4873-4abe-96c5-2fa4e35b7ce2@suse.com>
Date: Wed, 3 Sep 2025 07:57:09 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: add commit IDs for kernel fixes already merged
 upstream
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <c2806ea741c0f0d185930c30dbc334bc1fbbfbd5.1756823100.git.fdmanana@suse.com>
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
In-Reply-To: <c2806ea741c0f0d185930c30dbc334bc1fbbfbd5.1756823100.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/2 23:57, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Replace the commit ID stubs for btrfs/301, generic/211 and generic/771
> with the commit IDs in Linus' tree.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/btrfs/301   | 2 +-
>   tests/generic/211 | 2 +-
>   tests/generic/771 | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/btrfs/301 b/tests/btrfs/301
> index 7f676001..f68ea03b 100755
> --- a/tests/btrfs/301
> +++ b/tests/btrfs/301
> @@ -19,7 +19,7 @@ _require_xfs_io_command "falloc"
>   _require_scratch_enable_simple_quota
>   _require_no_compress
>   
> -_fixed_by_kernel_commit XXXXXXXXXXXX \
> +_fixed_by_kernel_commit 7b632596188e \
>   	"btrfs: fix iteration bug in __qgroup_excl_accounting()"
>   
>   subv=$SCRATCH_MNT/subv
> diff --git a/tests/generic/211 b/tests/generic/211
> index 6eda1608..f356d13b 100755
> --- a/tests/generic/211
> +++ b/tests/generic/211
> @@ -15,7 +15,7 @@ _begin_fstest auto quick rw mmap
>   
>   _require_scratch
>   
> -[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 6599716de2d6 \
>   	"btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents"
>   
>   # Use a 512M fs so that it's fast to fill it with data but not too small such
> diff --git a/tests/generic/771 b/tests/generic/771
> index ad30cc0a..ea3e4ffa 100755
> --- a/tests/generic/771
> +++ b/tests/generic/771
> @@ -25,7 +25,7 @@ _require_scratch
>   _require_test_program unlink-fsync
>   _require_dm_target flakey
>   
> -[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 0a32e4f0025a \
>   	"btrfs: fix log tree replay failure due to file with 0 links and extents"
>   
>   _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"


