Return-Path: <linux-btrfs+bounces-14962-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D799FAE9033
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 23:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C14C6A05C3
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 21:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E360C2144A3;
	Wed, 25 Jun 2025 21:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bbLk1qM1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E67142E83
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750887056; cv=none; b=j1kweLf/01M9ZjO21Hu01tAJYw70bHIpi9Z9j8zTuKLNery3AxSkUmawpDCmUCIxzTqk2OlUSs+J4YzIodA/t1CvxNKsLyvD5FtUmQ70RLM756Da6UumFpn7KAVILSBwzE15/P6CVl73NH9eEJIbSN44dbc0cmvoWFTg1s2J4Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750887056; c=relaxed/simple;
	bh=WkoLKbARPRXvcKVRAzO2b6uFnh+qcS9oV8IVl4aWvPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=upkvGg4YCMUEegY76rfurwM1NGJmQCRuxdfkhK5Ny3o2PZSc1w8kF/VIZQb7OnmjpdjnvSmGclNpGGrtU7DTYIkMOpELKBg8kUvleEIb+tnfwf1V+s2EFeLRlUt5Z5IwjSpZg9hcOOpI7HC3T7Fizd790reAa69F/Rb8mHZw5Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bbLk1qM1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so190406f8f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 14:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750887052; x=1751491852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=75enP5MtHDzPQYgeV2bRJ7KHer5alWtMbc/+KvUWf4s=;
        b=bbLk1qM1FKKKHqESR2lkKOOlkMVYlS/YYbkuQm0j/pGdrkfnaN99i0l4IGO7rBpWOI
         PW80pyaFE8vNiuhQr8eZLQnG8BhjbzOb//JrmbxjoTHrHWq5YiQF/qxG6oUlNm5J+QPJ
         zIs/hXxXDEaDfD6xFx/A9gzEFLbxdw7b6wyfYJ8kP26687nFB92X0vAadLQoCl9b412j
         vtgwBk2lX80SisZT0Ebf2PokT3jEnQYSjtsm5/5oP32A3SPr4fOOVkojA017InAh62G9
         EEjMuXECPE0wNAKu6XhWgRQjEBBqTFl7BvrEcMcGtedtNHkSfoz5d8lzak7zKJtztnnt
         kmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750887052; x=1751491852;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75enP5MtHDzPQYgeV2bRJ7KHer5alWtMbc/+KvUWf4s=;
        b=Obg00ZHA31ODTnn3U74+METIbXrfyPFifuxcokZAxH7q61RwV16bK7FRkNBdNAgyz2
         BMFwKqp4mkveQJhJDSjlWexMJiWT3G4mVcMzPceuD38t+EVxZNnZShg/AlP8h7iKMR1V
         xsVYjtULtvCgPfiRw1j6evKLvALLPXE+xlfL5NYPk+3Y8Tt3lY8xHCdAYXpPd7tCeYf7
         hmTr2Bk1WGRy4EnoixdA/WXcWG/o5OiknDKO3TVGAOFJSPQHtQkaoMKfxhhGUfgS1kGd
         /hOvbm4yIw/uI73SBupEvsaUk4WGxQy4R/TEE6MVByqsKatQoybvxV2XG6u4e5M4GIM1
         Sulw==
X-Forwarded-Encrypted: i=1; AJvYcCWWP3Sz7cGhUCx1gLnAiTdlzakPuhwTCSIM27VDas5LgELqroVCpgH6ZydoTc5nTF+M79MhgYOP7SOFEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEZof/F3FT6k47xArC8ma0KrFpwbtjOhdR30ZFen8zz5gxC6wk
	sviRLujJl437sNP1pzUDsuTuV6y87/LyZKTSE9rPUPDVhlqKcL4PoPy/m5z6M5BqK/Y=
X-Gm-Gg: ASbGnctop8gu0ib6N8EnKGFm3at7tEZoPTxyDDJbblDS3Zk214udcpJcmiVLlh3D+we
	TsIqvdvoJqaKea2iRy1wJ07hMDfoY0WxOtlP4Gki+pXJXIorKZDOUrgTAytvacs15600t5MeA9i
	IBz6nnCT+CyhDDqY1BhgUQDcsEO2Y2YDoso4puid0BzXGIFUpKjOjbhyABMkP+unEpdSAg0yBAA
	SZscemsY77+6NRIjow8XSvB13akaTpxL8Y5QMNYbeyDN3nB1WcXkOI9AwFPviGUurn0qEDUxXxD
	Du8bj+uLANP2jD3widGLbVAgNMoWtKHGTFMArjzEGQwqqvgkfu2zECCOGlt52W5pLBAY+5Txnpi
	X3n9LgW8pIl/JTg==
X-Google-Smtp-Source: AGHT+IEjtQeeXiBxD07cfTlhP+BdDNBCRM/72qUcHevX/hGMkkLP/9RS+HSc/oT91ORfuOQsE1UGxQ==
X-Received: by 2002:a05:6000:41d3:b0:3a4:dcb0:a4c with SMTP id ffacd0b85a97d-3a6ed5d6238mr3660326f8f.12.1750887051765;
        Wed, 25 Jun 2025 14:30:51 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c882cec9sm5326563b3a.75.2025.06.25.14.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 14:30:51 -0700 (PDT)
Message-ID: <32477af9-c75c-4262-8087-3dd6ca350083@suse.com>
Date: Thu, 26 Jun 2025 07:00:46 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: qgroup: remove redundant check for add_qgroup_rb()
 call
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <4017a6e8b1a7b5a839f0552916cc2c281286210a.1750867517.git.fdmanana@suse.com>
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
In-Reply-To: <4017a6e8b1a7b5a839f0552916cc2c281286210a.1750867517.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/26 01:35, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The add_qgroup_rb() function never returns an error pointer anymore since
> commit 8d54518b5e52 ("btrfs: qgroup: pre-allocate btrfs_qgroup to reduce
> GFP_ATOMIC usage"), so checking for an error pointer result at
> btrfs_quota_enable() is redundant.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/qgroup.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index e38272ac808d..afc9a2707129 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1161,11 +1161,6 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
>   
>   			qgroup = add_qgroup_rb(fs_info, prealloc, found_key.offset);
>   			prealloc = NULL;
> -			if (IS_ERR(qgroup)) {
> -				ret = PTR_ERR(qgroup);
> -				btrfs_abort_transaction(trans, ret);
> -				goto out_free_path;
> -			}
>   			ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
>   			if (ret < 0) {
>   				btrfs_abort_transaction(trans, ret);


