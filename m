Return-Path: <linux-btrfs+bounces-9079-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C599AB836
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 23:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16DD2824EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 21:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCE41CCECC;
	Tue, 22 Oct 2024 21:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GVgcO6yF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358961CBEA6
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 21:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729631344; cv=none; b=hPOaeOR5fbKlHPQ4UiLXxdxG+gNkJhEo69SVbn1dOKkW+JdopLU/S/3zhNundERVwn+PiX+OfFBiZkmahNAOjE7txiQtxeikF40jjw0GQmIfSiUpbQgmuWBSx9t2aLz+uNcAa9JZPULjQYzGRrpjTs8hw8VrDs73n0ianTIx2KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729631344; c=relaxed/simple;
	bh=MtVqIS2QbrxYA8FDlOgo6uWJuXUYu0gvlgtBlH4dr6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NvptvH7hOQzyTIanudaPJvSFPHvp9VPeMxhU+2QzLDVARMYxFSV99sRdyq56oOkiQI0iVME3Pdt7YSlIiWzTCE1b4Ozuzrw5mBVNe1BFKHrakbvicq2dyOuwa/NHI3M4RHKduImW0zmeWKrBD2EEsz7wChhlYhVgYZnySG6tBxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GVgcO6yF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43161c0068bso47008765e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 14:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729631338; x=1730236138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W/kL7Mjpko1fOCPD2ZaGdCaVKt/L/g60HuhmNf7NGpY=;
        b=GVgcO6yFT3FOQKZMLMwPBjlXr8fnpQWnn2I9c6MXXG2IxaWPC+gCa8t7r2QWlCcq61
         xfvzM7iU8ozNi/ksnxHUOSFJFpTMo2a/F1vJtxbkEjwHXCCzjA2CQnnjuV9OKHs5XmH5
         Lg1PHh1bkawZ/fo4Bvhy12WxwQ/3aLsPfD9be0siVNWLwkWIRrqRo6qsP/VEDs/JUaTe
         rhYTdAxNa3jn4W6/JxY0FFHvobT/+7MLlllLMdZOcOMcwC4SqZhkim1EBUb/4vNoCCwn
         Z2Wc419Ot4NG9fumWPLPpVdAJxtozq7yOdh9cE+FOtgIdoTtNbXhtCOF5dRWo7EuDCMR
         l1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729631338; x=1730236138;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/kL7Mjpko1fOCPD2ZaGdCaVKt/L/g60HuhmNf7NGpY=;
        b=jvxcIbpIyX0MYHiWlN7xBzpLWuVpqbjsFi1WM2OvgSgzdhAsaqdm0nsdemjHb7zcc0
         ws9V6QyRltezfy4tdZu5SpPxQIuMpzYJVvnlBYxcGN0RKLP7TCzAxHICrAvMMpjziYrK
         hhFpAAAvYGYakyLuqtg7L0WcHzhxgmWjZhFtGO848tF/F4I2wYARA7jyR5TT+lCcN/k6
         93tgSYoiUHNdvSZGGJK4vfR8v17GjKs51/R2Ghh53E6KqC6fEAn5fKcRd0EDe4CF2Uyw
         bTmqsXqun8TONDmfzb1dB1Hr+4DZSvAs0SEeKDRnJKoTOw1EfF5piacUwykgkFJgzEtD
         PXaw==
X-Forwarded-Encrypted: i=1; AJvYcCVv3RJUwS+tptMr8PYTPCQya2ia9yneYQAGq2sLOKidP2ku/0s/X9TmkmETkr+Q2OsrxKAMJJTtd6bu8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrKTO0poQ8ol9CcUIxANA6YJRqlwDGEhkfmvFKeISByT3Izr1u
	3nhs17oD1EE4q7SqVBU29aXk03ZbCiHf/bMows6YquDSZi3uwW5jS9M4yd6B1k4=
X-Google-Smtp-Source: AGHT+IEGuznmtZoDbnmUv5NZ5s0QKaHFy0WD+fiiZYcKukzGTynCYwMHXPCuFaqe2PsULOwBSOvLMw==
X-Received: by 2002:a5d:5747:0:b0:374:ba23:4b3f with SMTP id ffacd0b85a97d-37efceee7camr168880f8f.9.1729631338069;
        Tue, 22 Oct 2024 14:08:58 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad3677b2sm6680927a91.20.2024.10.22.14.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 14:08:57 -0700 (PDT)
Message-ID: <47f6b493-3eac-4c00-9ce0-5b24a5776867@suse.com>
Date: Wed, 23 Oct 2024 07:38:53 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/002: fix the OOM caused by too large block
 size
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
 fstests@vger.kernel.org
References: <20241012071824.124468-1-wqu@suse.com>
 <8f1a88d5-3199-473f-881b-1844c4f1cfe2@oracle.com>
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
In-Reply-To: <8f1a88d5-3199-473f-881b-1844c4f1cfe2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/22 21:54, Anand Jain 写道:
> 
> looks good.
> Nits:
> 
>> For 64K sector size, the BLKS is 512, and BLKS is 128 (one 64K sector).
>                                              ^^ NBLKS
> 
>> $FALLOC is the correct value of 64K (10K rounded up to 64K).
>>
> 
> Not sure what you meant here. More below.

I just mean the old $FALLOC value is 64K, which is correct.

I didn't see anything confusing here, I was explaining each variable 
involved.

> 
> 
>> diff --git a/tests/btrfs/002 b/tests/btrfs/002
>> index f223cc60..0c231b89 100755
>> --- a/tests/btrfs/002
>> +++ b/tests/btrfs/002
>> @@ -70,19 +70,14 @@ _read_modify_write()
>>   _fill_blk()
>>   {
>>       local FSIZE
>> -    local BLKS
>> -    local NBLK
>> -    local FALLOC
>> -    local WS
>> +    local NEWSIZE
>>       for i in `find /$1 -type f`
>>       do
>>           FSIZE=`stat -t $i | cut -d" " -f2`
>> -        BLKS=`stat -c "%B" $i`
>> -        NBLK=`stat -c "%b" $i`
>> -        FALLOC=$(($BLKS * $NBLK))
>> -        WS=$(($FALLOC - $FSIZE))
>> -        _ddt of=$i oseek=$FSIZE obs=$WS count=1 status=noxfer 2>/dev/ 
>> null &
> 
> 
>> +        NEWSIZE=$(( ($FSIZE + $blksize -1 ) / $blksize * $blksize ))
> 
> 
> Please add extra ( ) otherwise it is very confusing.
> 
>     NEWSIZE=$(( (($FSIZE + $blksize -1 ) / $blksize) * $blksize ))

I didn't see how it's confusing.

It's the very basic round down, and I didn't see any kernel code doing 
extra () just for round down.

Thanks,
Qu
> 
> 
> 
>> +
>> +        $XFS_IO_PROG -c "pwrite -i /dev/urandom $FSIZE $(( $NEWSIZE - 
>> $FSIZE ))" $i > /dev/null &
> 
> 
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> 
> Thanks, Anand


