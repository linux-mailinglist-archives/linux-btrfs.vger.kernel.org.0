Return-Path: <linux-btrfs+bounces-17760-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B01BD756B
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 06:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D8C04F7EAB
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 04:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8653230E0F8;
	Tue, 14 Oct 2025 04:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IVGS5Vgd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C16C30E0F7
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 04:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760417743; cv=none; b=Y6IvZmtPUSmaoos60tmd2AxfVHDaqreFv5cW803teZr8RurX4uX/DJvm7Kw1eAmpJuIt+5cVyDqAglU/my1B8BD8q9v6Me/A/36Ddg1zTY4w2OdrcDApfFEAcX9MRwdoa8seu2PZqtAlgOxvyrefBc1c7nnGUtrtXtOLJpmjpuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760417743; c=relaxed/simple;
	bh=VPhpVFbQBsJa0uDcQCZ2WXYujh2s2dYEdK+H07NdtnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahV+xJzNwifdgIKWYDlClJbYkx1IKV1Cd10kkXwrZ5CimBQOJm3oZ0K/jdtzKiK2Lvd176IxevgRdGeQTH/GMU0seqD94uwYdVjnfVRiXH1wK9Y0T9eTWf1t8MXbFzbWoA3bEwatvMkHZMZitFexcIEgJu73rxsOxwSYVN8xqig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IVGS5Vgd; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee130237a8so3866098f8f.0
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 21:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760417739; x=1761022539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OuRR4HM/Tq0zE9Q9qfR9j2/5ZKN0yyFSQeDH1SzScS8=;
        b=IVGS5Vgdr12vtM7vsNo8FR+YqlCkkuejL96xS5WDmiH00dbNpwrUemCVhEdUqExLJm
         3O6HcztmtZQ5oSfRposEo8zeCOPHmo3AOQTMUo+4LLIikwWs7Q7pTp3aEeTQa7COThVj
         B1d0B3wSmwhTej2ZrCVuXRbwiocCg6LQcn1OKFd1s4s2/rBLwD/ai0ISiLL4bB/kBXO/
         2HUSFKTVYvf7qCE737sIZtQhNTu9wKRiNOqpOICojSsc4Xd2c/NZKTD9urJChJVqMTye
         4Y/SSkzKyuAEI6upPNQ89X7qAedtvFJRLsan5x+YmuMdWqdExdScf2gf7CLk6Fxzt3WT
         W0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760417739; x=1761022539;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuRR4HM/Tq0zE9Q9qfR9j2/5ZKN0yyFSQeDH1SzScS8=;
        b=Xi1q++f1eW9zsE6moUQzpTPWCEEZetiTwFjnUkH77HKJCrm+YSDhPd6vld6PgP0lPT
         tG+8O2zm6okZOSpiXBdczY3bfMQavsWH4E9vHf/mDoTMdD25df7UqmVWHv05ZDUmu8/X
         IKd3SfDLDvh+QSXMGgwRJKPqdW+eXDdOqLvE70micSTOCSKzcKHpCIIUGaWodGQg6lTE
         gXagF1cdeK2UDFhOokbNqcAbll8S65z+5g+qIwjIpIYrsl3sPXpkAWmgp2xC8DlS7g+O
         FA7AHTjwu8/AJbeXpboiQNUbP2IJlH61bqCLt0eiFVzVrgMNckuSFLaW7oovsYATG1hP
         70+w==
X-Gm-Message-State: AOJu0YwJh8vkx1f1KpctuKwGYgr48e641W18iTLUmBeqRO/wBUqboo2R
	cEIka13ctfrdSz1srFLSHNd070XRL6kbxgiC7a8VvtmRbauir9DvpRTS3PLVAduEvxU=
X-Gm-Gg: ASbGncvjwsZ2Hn4Jp2lI57VitTTYz0RSMLOKzRyYJMy2RFKH3tQLLcv3niPOPbZMVgw
	+56IZNOUIpqKdcQ2mxeLC1u7iXVnDW91u9UAKupq0TfIAynRYgCiGz+j2Fe+ip4sYFJOBQXgtm+
	f9b4WBa9yGi2QegxVRQW2wm2v5JDjwL+Nj/hz4aBbqh3T5gpoO1kBicc7eRPSIb4JwIIolJj4Db
	tBdls40LdIttToD0RZaePODI/tKinTORV6fQF09gjcyEoqGJCTz2Au6x9czf8l+ktVK4lC+o0j9
	sRI3FboobCq16UmoJ6dSZ2KzD/kUYk9WQO6drGMwxTo0lOtK0T7W4ZyT2tp2j0iyYdBzJYZqnEg
	E7c2dLQD/2Q9ijxNeo+zP66KOd2vZizO02LqIg/u4u+gPfsSQ55E7hhMKaZHszBKglr47QRdgzE
	U5uInT
X-Google-Smtp-Source: AGHT+IEa6oT+J6JgllW/T27rHWkHsP9KH7yULtWakf1OtcsDunxs6VTM1FzatF4Amm77K/fp3Jm9GA==
X-Received: by 2002:a05:6000:41cc:b0:426:d55e:7229 with SMTP id ffacd0b85a97d-426d55e78f2mr7606823f8f.17.1760417739463;
        Mon, 13 Oct 2025 21:55:39 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df8ea31sm10650897a12.42.2025.10.13.21.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 21:55:38 -0700 (PDT)
Message-ID: <5a9e8670-c892-4b94-84a3-099096810678@suse.com>
Date: Tue, 14 Oct 2025 15:25:31 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-btrfs@vger.kernel.org, brauner@kernel.org, djwong@kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <c78d08f4e709158f30e1e88e62ab98db45dd7883.1760345826.git.wqu@suse.com>
 <aO3TYhXo1LDxsd5_@infradead.org>
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
In-Reply-To: <aO3TYhXo1LDxsd5_@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/14 15:06, Christoph Hellwig 写道:
> On Mon, Oct 13, 2025 at 07:35:16PM +1030, Qu Wenruo wrote:
>> - Remove the btrfs part that utilize the new flag
>>    Now it's in the enablement patch of btrfs' bs > ps direct IO support.
> 
> I didn't really suggest removing it, but splitting it into a separate
> patch in a two-patch series.

Oh, sorry, I just kept the btrfs part into the enablement patch, and 
that enablement patch requires quite some other code that is only 
submitted but not yet even merged into btrfs development branch.

Thus I didn't really want to send it right now.

>  We could probably even move everything
> through the btrfs tree for 6.18 to get the fix in.

Unfortunately that may not be that easy. Either we merge it early, 
meaning just this change + using the new flag in btrfs.
But that means it makes no real change at all, as bs > ps direct IO is 
still disabled.

Or we wait for the btrfs sub-block checksum handling patchset merged, 
then with the full bs > ps direct IO enablement.
But that also means we're waiting for some other btrfs patches.
There are already too many btrfs bs > ps patches pending now.


I'd prefer to get this merged through iomap tree, then utilize it in 
btrfs tree later.
Just like what is going on with the remove_bdev() super block callback.
(VFS change is merged in v6.17, but btrfs will only merge it through v6.19)

Thanks,
Qu

>  It's just important
> to keep infrastructure and user separate if you have to e.g. revert the
> btrfs part for some reason, but we have another user in the meantime.
> And I plan to use this for zoned XFS soon.
> 
>> +	/*
>> +	 * Align to the larger one of bdev and fs block size, to meet the
>> +	 * alignment requirement of both layers.
>> +	 */
>> +	if (dio->flags & IOMAP_DIO_FSBLOCK_ALIGNED)
>> +		alignment = max(alignment, fs_block_size);
>> +
> 
> This looks much nicer, and thanks for the explanation!
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>


