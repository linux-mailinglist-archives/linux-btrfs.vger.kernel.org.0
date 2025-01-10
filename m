Return-Path: <linux-btrfs+bounces-10912-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C311A09EA3
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2025 00:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734F43A97F6
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 23:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B45E21D590;
	Fri, 10 Jan 2025 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fo2ow8aQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C324B24E
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736551046; cv=none; b=olHAEyPcRR0jeC8fstHIdMiBrto/FuIbfFw6KLbfFq3bu6ObMVayBMwfqxdqi0Un2qLiLPAjrT8lRzOso8aP01+MeLbZakEM8Hx9nlIPCmUWOF6F4ZUfff1nDoPC6S+q2n737epFjzAl+zCrXJJ6Ehha8gMVltgqZTCFuFTH+vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736551046; c=relaxed/simple;
	bh=79frzVcnYJWgYuIq8k1fx/+A+iExtAIJ61slyiv50Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVODXMKPdlowwHBT010WaANJaezCxQzPYMI0LMh2IiTzwIrjA3TxveA4elQiT/4ecNMDX7MxNeAPxaNkiU31Lv39dXoEhq9aBjBXT1SF1zodHAKBx+Se9MwGwzSnDxia+Z9GzDNH5TkuABdLWakKU1DgaX/+SyuVUvq88z3a2cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fo2ow8aQ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaeecbb7309so469149066b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 15:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736551042; x=1737155842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4RMevCDRpCeeHgAkncGk3rbcGkgqIY6BOdNMMJSCXHQ=;
        b=fo2ow8aQf6J24L6HvZaPEQ+HLgefwSSbQH5HzjUyY7tCcWyfWKH5ndO49rtgJwsrpk
         7+WBPM3xw2anpJ5fchVqcn1W/LQfTghhKHZZza9zmW+/LNXSkpR6UPv8AV8NHL0zvjqu
         M4X6cO6ZoecyBTF4UBiOIdrRwsQjel6WBF0kS5CZABtKLSJyMbzSjYNRDLznsUocMU3s
         uIw2KagN7d/YU7wr8/PUrSyRdj/jyKNzaIqhFoPxlDtezMWYTTEE7JZht4x/cozAjlHj
         XNZVBuf9sQXTPAR6nqi1kN2IX+FXuTxKC6htgElgLan7G0ahGVyAj8up6IkNxHyA5jm/
         SByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736551042; x=1737155842;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RMevCDRpCeeHgAkncGk3rbcGkgqIY6BOdNMMJSCXHQ=;
        b=d7dLnAiOXfXLWlp9mj7JdMeR9mDiHs+wnmKOdUsS3tuqjSDZ0ZDh8ZXZ8MJj0WelbI
         VywvDc0xBlWzvWvzjvFkH9hvoTXM3gLYspxVrd8qmA5jIF2FnmJ8pVVwySMgEOW1BgPO
         dwHvG0grR+3geUJvMTteywuZY7iisjA3bmhmPZ9W1TnQ5yS/XM+Suw1s+ufxFjnflj2B
         XrLFwIpShqcKQryqf77TtSJFJbhj07mnFLnO/SEZlv+KbwbJxu2ibGyDngU/xmJc/gfE
         aIh1IhnPDsUVpEGW7FKDHik2G0rZjUblGCuRpdeF6EcsK9vVYbMFkbSXUozNqDgAG170
         LG8A==
X-Gm-Message-State: AOJu0YwfwNrTAtDQhDGNJI8WvJFzAWUyjxaUMOyw+mAytUfe2BhG3KaS
	L5CxTenkrcZo3+nn5/xIXcGlE3t/ek9YETsBYUs1AQXZvVN1uPLPJywoxr/KCYl6CVENokRPlDS
	2
X-Gm-Gg: ASbGncsbiB9ESh2ha+xVQ5i22xJBG/7bKVkluoTKyrJUzZx5ahmgKzSYUx5hfyDPkYq
	PXlglZZpmJE1h5z1c8Br+B3d5hpSxULe/UKH/hTKVO3t8FMC0N0D50UyeaNbvuhsOCQGtQ+pKwD
	5KFfCABvK/Bs/f2oCAKY+kNwUDVIsM9qUnqsDvdPvykgs9gGDunMWD88rWSgcRx/BEARq51EHPb
	drXRcN7tnj2EuXT1kZVYGLdnmIT95mm8FqiSb8UTnv1XCmCwma8T+U+G2ReP1NOEIVnh0/Rpj6H
	3Y4Rd7Ga
X-Google-Smtp-Source: AGHT+IHjkXFkD+Lue3BHNaFCHJhBdyMAVD2tV1HTcrNjRaztVNA1Pk8GYhU43YV5+cgxITOEwGbYEw==
X-Received: by 2002:a17:907:9805:b0:ab2:ea6d:8749 with SMTP id a640c23a62f3a-ab2ea6d8c80mr232030666b.8.1736551041919;
        Fri, 10 Jan 2025 15:17:21 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40680e5csm2090432b3a.143.2025.01.10.15.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 15:17:21 -0800 (PST)
Message-ID: <2d9824d6-7379-4bc4-8bb0-e61d56660ad2@suse.com>
Date: Sat, 11 Jan 2025 09:47:16 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] btrfs: add extra error messages for delalloc
 range related errors
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
References: <cover.1736479224.git.wqu@suse.com>
 <ac9345c0d31fc1b669ccfe436e49883ed998ab07.1736479224.git.wqu@suse.com>
 <20250110162058.GC12628@twin.jikos.cz>
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
In-Reply-To: <20250110162058.GC12628@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/11 02:50, David Sterba 写道:
> On Fri, Jan 10, 2025 at 02:01:39PM +1030, Qu Wenruo wrote:
>> @@ -1561,6 +1570,13 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
>>   				  PAGE_SIZE, bio_ctrl, i_size);
>>   	if (ret == 1)
>>   		return 0;
>> +	if (ret < 0)
>> +		btrfs_err_rl(fs_info,
>> +"failed to submit blocks, root=%lld inode=%llu folio=%llu submit_bitmap=%*pbl: %d",
>> +			     BTRFS_I(inode)->root->root_key.objectid,
>> +			     btrfs_ino(BTRFS_I(inode)),
>> +			     folio_pos(folio), fs_info->sectors_per_page,
>> +			     &bio_ctrl->submit_bitmap, ret);
> 
> I've merged my cleanup series, and there will be a minor conflict in
> this hunk,
> 
> @@ -1565,8 +1565,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
>          if (ret < 0)
>                  btrfs_err_rl(fs_info,
>   "failed to submit blocks, root=%lld inode=%llu folio=%llu submit_bitmap=%*pbl: %d",
> -                            BTRFS_I(inode)->root->root_key.objectid,
> -                            btrfs_ino(BTRFS_I(inode)),
> +                            inode->root->root_key.objectid, btrfs_ino(inode),
>                               folio_pos(folio), fs_info->sectors_per_page,
>                               &bio_ctrl->submit_bitmap, ret);

Thanks for pointing this out.

I'll resolve the conflict when merging, along with the usage of 
btrfs_root_id() mentioned by Filipe.

Thanks,
Qu
> ---


