Return-Path: <linux-btrfs+bounces-16588-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FC4B3FCAF
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 12:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B4A487D2A
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 10:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8F42F3638;
	Tue,  2 Sep 2025 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aOxTmXln"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7592F0664
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809397; cv=none; b=fCTo/csGifKg8Z2Z9cxz7Ac/1fMtoWQNnDmGtD+b9RezpgGwniZj4ZJMuw8Hr/Of5lmnFlA/Fvt6mv/z7ldFNjIXi4nMsShUDdH5EpvvrjRdub2MGSwlUsvu9cRvc5zPu6G2JDUMnfhYt5+Q/Qg37R2frLpa1ya8UQa0EC00RvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809397; c=relaxed/simple;
	bh=Y5SqdVUlIA6JSkwR+7lmG9g4tl/DqbEwODPxdfkJik0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hI1DE2gJgOAU4/1HFcD27jdg763PVruuP+WJl4eDuHjq4SV0kAZWnGcYxtaqjdqX6b6dLGlF4CXTEvqCCKjmEbm2XOWK7IMe3wO50yMt9ikHrBeFXwtnXaGFfgaNYoeQQbvi33tApFVKOvuD1wCFbIRVPfU6VvaprMtFRBk0uSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aOxTmXln; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3dae49b117bso369791f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Sep 2025 03:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756809392; x=1757414192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8A0RDzYq3IQEb+frFky78lxKGKo/VzNS/f3kpYf8pR8=;
        b=aOxTmXlnnNuH8XuFRbmF3YoerKal3jTeN2144YbhUMyhcGLQXBzptZTYygYnG5Id2Y
         9ko9SWFHZtfuIOxwUFzE5TQC1MKFSrDDHI9r8P34GqNgt3oVf57Y7egfYwj7Hrt5nC17
         NrFWbw5J9u9wV+2JvfYdLwrXDlVd4kLfvPo5E6WUITV8sx7L+qEQOITOqhwl/j29nf0j
         Nwh+Ugnj35oqWbYFT2mDvdezslo+1DmoQQ86Fb/9dxUeyI2cBCroMK82yrT0rG8Nf7/C
         UVb3Z4xggdEKmrG49kSYiXuBMkWRbTgTRcT6M6JstuaZfnGt/eT5fS7184ObEhj4KdJ4
         HriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756809392; x=1757414192;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8A0RDzYq3IQEb+frFky78lxKGKo/VzNS/f3kpYf8pR8=;
        b=chjzHjA+Q7qsw/WUIP1piY9YBWs21PL4izvRfzPSE+bne7rkwqn09cfgJAiqdoEqxO
         0XL93c1mZ2O4x0X8/sJgkgwGG60ToJ1v860SWmp8IfF3ThdNhnYzS4XSjUJI5MXxqfQM
         BTJHQD4L9L4tg8ykZrQ1+WlGZBDA9xI0puWfmCl/T6GQ4ftghi2gkZP9X5Cp8kcaYuOa
         cxvL/a4cAoRllLVjFt9F4unQzirGSRn2LpIV1Ei7LZk6WEBFlMoDfOK6rnD1eUy/PkCv
         ZDZYkh49F85RP8nB0kcwj22+EbY/I0DwkNDLnEApXyhT4sQhWLh7FEVWch2ZOdvk9AJI
         ck4g==
X-Forwarded-Encrypted: i=1; AJvYcCXovOb8ZV4HP9vrTUQ3PbPjrUrLgq+jDRgUNFJjcT4jw8NO7B4R5w1jTKz+admAnyW1FNaNAQYvhGfmmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVfuRQAlKY/IF1f8yOEd5mbH/3rggS16Djmiz6MU59zIQ+3vy7
	fieoEivyjbxtmGHrlPFHZ2U8G/RIv2kDUYsXC4xRV6SV+07LVOqZ6qcjAbr0l7apqPvLJ/ujI4H
	f3HZG
X-Gm-Gg: ASbGncvuPa7xaCpJbPZKPCSTo9nsu/40BbMjyD33FYzMb/RD9rqx2Tzvg4mRVXOkDiq
	JOZpcGlZ4PBDdU3s/uv5QSattseOyX/VD4amGvK9PMUYpuvUES1mZTObYqIlnG3z9eZq+qME94L
	JjUmYYxecdfzrTuVCmLfgh3tJwWLnuYk3aQwk/jy7HrWnvNxI9wzMoQi4KQ5s17iOBhw4duEeI3
	VtPeU2BIsBTBzhqa7tddxSDl0LnQCEDR5mE83XvxMCbBzuF2ipw0FQnd+VIwPQEVw5C70WAQFHl
	lmZl6pBguaDa5aqVSyNypDXzR3q3ZNBJZUQ8XZKImc5KloNgS0BTFnZPUh5JpGp3WaPQOTlv8dR
	ccQ/43NBXUvmXmlzQln0HcmFCxxSJByVuK9aVSRIh+P6Kg+g/dt0=
X-Google-Smtp-Source: AGHT+IGfrNxkSFT+Mi49X+gnAAmd4lsb62XUTu3jcDiYanonZXWrbOFsRofvDBctvpehdOhxwoqLeg==
X-Received: by 2002:a05:6000:1a8c:b0:3d1:2163:ccb3 with SMTP id ffacd0b85a97d-3d1def66e7bmr9177803f8f.42.1756809392037;
        Tue, 02 Sep 2025 03:36:32 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a5f7a9csm13185114b3a.91.2025.09.02.03.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 03:36:31 -0700 (PDT)
Message-ID: <bd460fa7-69aa-4e10-adb7-330204113674@suse.com>
Date: Tue, 2 Sep 2025 20:06:26 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: don't allow adding block device of less than 1
 MB
To: Mark Harmstone <mark@harmstone.com>, linux-btrfs@vger.kernel.org
References: <20250902103421.19479-1-mark@harmstone.com>
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
In-Reply-To: <20250902103421.19479-1-mark@harmstone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/2 20:04, Mark Harmstone 写道:
> Commit 15ae0410 in btrfs-progs inadvertently changed it so that if the
> BLKGETSIZE64 ioctl on a block device returned a size of 0, this was no
> longer seen as an error condition.
> 
> Unfortunately this is how disconnected NBD devices behave, meaning that
> with btrfs-progs 6.16 it's now possible to add a device you can't
> remove:
> 
> ~ # btrfs device add /dev/nbd0 /root/temp
> ~ # btrfs device remove /dev/nbd0 /root/temp
> ERROR: error removing device '/dev/nbd0': Invalid argument
> 
> This check should always have been done kernel-side anyway, so add a
> check in btrfs_init_new_device() that the new device doesn't have a size
> less than BTRFS_DEVICE_RANGE_RESERVED (i.e. 1 MB).
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/volumes.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 63b65f70a2b3..77a371f92ec0 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2726,6 +2726,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   		goto error;
>   	}
>   
> +	if (bdev_nr_bytes(file_bdev(bdev_file)) <= BTRFS_DEVICE_RANGE_RESERVED) {
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
>   	if (fs_devices->seeding) {
>   		seeding_dev = true;
>   		down_write(&sb->s_umount);


