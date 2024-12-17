Return-Path: <linux-btrfs+bounces-10459-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F48B9F458B
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 08:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315157A4312
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 07:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4251D5CFE;
	Tue, 17 Dec 2024 07:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UCnObrBE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26633179A7
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734422087; cv=none; b=DkyDHsSFYYi71XGPOKLOCwqMm76R1YwhzlNm1PQXY+fTZtd3VKvGX76EU5jP/VzcrYBIalT20s1Z4lSRGxCXd+gfcDZcHoLok/TO5bCVqgyC7tHqu41VJZ0AVIQKqwmbggs9pFXz8l5as2TPXXRKhOyRGF60EuQODFzs/oN5vdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734422087; c=relaxed/simple;
	bh=9pkKONfZPK/zCFwyWDjSWheCpP5U08dPtjoJEwFW4GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KI8rztm+h1RQ89VVu0jQ9w/C1bHdWMTR9k/Gj0y5FyBX7f3OOdp1pXqb7ja0S0YWxPxdBd4gSlU53Ovr/Nh48OIuAupi1vUFRThPLgl3BPhWALh+6ugpCM9K4qUUZouT/wmSwVST6WZfbJKuEAfnSed8r/YWxeBv5qL63UBZu6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UCnObrBE; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so2413806f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 23:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734422083; x=1735026883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wIexqEXLx24aTDZtw3vT/5R0XqKEKqj3/7Bevxa9akc=;
        b=UCnObrBEQjY81CDl7zWUmCve/cDPaQc3ofgMryNsxpteXKIjzsLNhv9GlAt65bCeb6
         rYtRpoSjntbxDWtIFNJcouyvPXksh18lR5KdQ7mq6p6FBJCegPjzxadGr4iFkpiFj0/w
         FDmO/2CM23bGy2YslyMROr4XCZcqaH7dYy9JheZUlrniNMRNs62ei+nstavXckHgXWPM
         ZAoAhUf0R65jht8j86lXpFo+dMMxzNfu2x3kqklJPQ6222AG5Eod/niDBGs2R45lOvoT
         k+NON2IgseOhTMxBwxmU/IBH1h3iVOC3FaiutM8+vlVWJVB05yUxO5uWCLma9XJpHAXX
         v6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734422083; x=1735026883;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIexqEXLx24aTDZtw3vT/5R0XqKEKqj3/7Bevxa9akc=;
        b=GP+wnI3X4o8kjAyK/3dYe21zZa/cdn6eQiv8/2DOT5c6bZ2OiZBLzLjwyQ8XF7HSl6
         YqMj4Bld8XDEUVIfj927h+cEn7MtGiv33tSHrnFrUdgi5sYj1gqQbYEGweZJJDeRnuT9
         47h76dw7HDbJ+Z8e3WiCzugDe3i6ZsmrbNdJJV8yFHf8eSvjjFxbjOVsAOKFTHzcoCFw
         /Zq12tp1r1vMJ4AXppaNdwPQUxVkQoxTdEFrp30QStVxkD7BIhM+9Ntm4T1zRsLsavHN
         RuPZ/62+1PpGGpprdpNv7uz2MpNqmuTmVtwo2K5UA3ocnl/cRqO9YJrFL3aD4I0DRKkk
         qHpA==
X-Gm-Message-State: AOJu0YzeJIYItgcHtRa81loOuYd5XHMwwVtU44AfOraUFc7TTaXgn8k7
	VxOROL2JW5aWTW7rcn77KxMcd+UWQQuktFOD3vvFA+ZjMds+roaynfvgoNjnfDbnUSSOWljQlIm
	U
X-Gm-Gg: ASbGncvLppLzyIn2AJ55UERpncrvjbeEdUjZtWEd2RhmZZ976q7xuP+d5yN7w4bSlrF
	oO2p+7ntbtsEY35W1hpPreF63syjrL+snazTIZh8Co54MMMXb6p0pFflpBfIET9ct0byXqcnhGw
	odwKUuk78dond3MQJN+h9X5swzqp73kzSQ0v5uRdBsXgzKdLAMKwhgT/yI6TPsmwtTD5AFWBxuZ
	9YqNTpzP/2ccL2VPO/v3Lx5ZhEC1kPWdCC/kfLAy0QaoKhdatcIvvPrmVabgy7i80jxJmIxzNLV
	Bh/93zyh
X-Google-Smtp-Source: AGHT+IERNNUXKI4qhDyzg0XI5iH6RTIa+5izaO5xIW039tDeLfuArFYVT9GqftBtcuIqWhBDdtdIPA==
X-Received: by 2002:a5d:5988:0:b0:382:450c:2607 with SMTP id ffacd0b85a97d-38880abfca5mr10290909f8f.4.1734422083265;
        Mon, 16 Dec 2024 23:54:43 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad5ac5sm6237789b3a.67.2024.12.16.23.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 23:54:42 -0800 (PST)
Message-ID: <3926d40d-6d1b-4c57-96b8-eda2053e0e6d@suse.com>
Date: Tue, 17 Dec 2024 18:24:38 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/142, btrfs/143: fix dmdust device names
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, dchinner@redhat.com,
 Filipe Manana <fdmanana@suse.com>
References: <e890661f90bde3b8119bd9a533760b2c8e162cfd.1733852020.git.fdmanana@suse.com>
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
In-Reply-To: <e890661f90bde3b8119bd9a533760b2c8e162cfd.1733852020.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/11 04:03, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> After commit aaa132777476 ("fstests: per-test dmdust instances") the
> dmdust device names are no longer a plain 'dust-test', they now have
> a suffix matching '.N', where N is the test's sequence number.
> The test cases btrf/142 and btrfs/143 are still using the old device
> names, so they fail. Fix this my making them refer to 'dust-test.$seq'
> instead of 'dust-test'.
> 
> Fixes: aaa132777476 ("fstests: per-test dmdust instances")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/btrfs/142 | 4 ++--
>   tests/btrfs/143 | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/btrfs/142 b/tests/btrfs/142
> index cf7e8daa..0ab0f801 100755
> --- a/tests/btrfs/142
> +++ b/tests/btrfs/142
> @@ -58,8 +58,8 @@ _mount_dust
>   # step 3, 128k dio read (this read can repair bad copy)
>   echo "step 3......repair the bad copy" >>$seqres.full
>   
> -$DMSETUP_PROG message dust-test 0 addbadblock $((physical / 512))
> -$DMSETUP_PROG message dust-test 0 enable
> +$DMSETUP_PROG message dust-test.$seq 0 addbadblock $((physical / 512))
> +$DMSETUP_PROG message dust-test.$seq 0 enable
>   
>   _btrfs_direct_read_on_mirror $stripe 2 "$SCRATCH_MNT/foobar" 0 128K
>   
> diff --git a/tests/btrfs/143 b/tests/btrfs/143
> index 5da9a578..490f27b5 100755
> --- a/tests/btrfs/143
> +++ b/tests/btrfs/143
> @@ -65,8 +65,8 @@ _mount_dust
>   # step 3, 128k buffered read (this read can repair bad copy)
>   echo "step 3......repair the bad copy" >>$seqres.full
>   
> -$DMSETUP_PROG message dust-test 0 addbadblock $((physical / 512))
> -$DMSETUP_PROG message dust-test 0 enable
> +$DMSETUP_PROG message dust-test.$seq 0 addbadblock $((physical / 512))
> +$DMSETUP_PROG message dust-test.$seq 0 enable
>   
>   _btrfs_buffered_read_on_mirror $stripe 2 "$SCRATCH_MNT/foobar" 0 128K
>   


