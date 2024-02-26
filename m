Return-Path: <linux-btrfs+bounces-2767-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFB6866B9F
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 09:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0855B229B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 08:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211351CA8E;
	Mon, 26 Feb 2024 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fgm/64c0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F185C1CA81
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708934501; cv=none; b=Imnt3L7tkVaqqDL+Ym4hCzYHzibuQhDuy0j8qik99btEsMgRxgN7fEtpWPCY8c8RXTwrLg7cVw+TqFMuRy2mc/KTa8niIgJBG3GpS1M9RwQ4nhzRYcnxRlBzp2DkVrqgkJTm4eLVeb2lKYrY0HiYKtuEvToeduLfPoPhAR3/vfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708934501; c=relaxed/simple;
	bh=ChlTkJdoRIcTPEm5INNJMu+ECH3w0pCZC/rM0eTbZ4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dMxG1TM7nHpfK+upDabBfQeI82BoqhVjl/Sxc6TdVa2pUuONEcbzVIG5tbgRFRp9aVC/jus90Bn132f84bD+LtuvbuaAZ3e6TQJ017wJVeM5uiJNyOzI/Div+jL8+HDri52JsS6VJStwS78iwXBJmTjynE+3iBcz4C0HveTVFbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fgm/64c0; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512bce554a5so3382066e87.3
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 00:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708934497; x=1709539297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1wOgetBj7kTlzEZY9MZ/bv98My8Au0BZDB6BD5byc9o=;
        b=fgm/64c0w0KzeD5aXMESlUOLnVSITTDiyG7yi1gWUg6m3Bk7Js+LFDwkUhjIjgLlNa
         VJS5CDQK2PGzPHsSlcwWJIqL6wq5NLY1g8TcV9UMdMG5bh3nIjMQvZqLbHAqRpnQcNBU
         qOLTuRDjyltBjN9ncd+W4qAsMtqsG6HhokuAPfqTUJ3ibT6rV4CEEhaynBh9s220fPeR
         asMMwNz6hhXptBPprLJFwhovXKu7AmWxQNH2swbw+HVmy23eVP3E2jdvqsoxnZ3Zm+u+
         Z93WxubDBjh2/fQ2a+/P/H45ComOAm8KoHvt2uif3V7iwYkEupl2vBP+DjY/5xzOl8cz
         RQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708934497; x=1709539297;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wOgetBj7kTlzEZY9MZ/bv98My8Au0BZDB6BD5byc9o=;
        b=REyel9/SGkdI27SsUh6chAocE2OzkEvrCZ4VKweCigMsy/QJYL0hQxtMzMhoUBLqFX
         nGxR2msRQBhXx5IGMKeeU34reNFjmd02sUl+I0qk6+fZJyROzeaQcRWoEwTw+RYju7dV
         NUPRhNHvbFeF39gbI6y5YOmW+aQGJxEHLx39/pl+nnXQYuzhd/7tTtVeac07m0FR7eps
         jVzqGjszjnDvT4Ya9lQ+oOEVezhxSYMD3vKwRYxL+UBjdcYvqQdfhG6fSYgkayyJICQA
         sB9llYdAwXHSp7cmY1R5tba28TebkwMZX2eHRxHkG9ILelXndkCg8qebXMBrC5EB9FsN
         lQDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeo3Pe3aYeutYhmYg1GuwAn784eio/3rOhtO1Dr02a6Ptt1SM30RcKLmp2UjP2xeCXlYgZfh/w/Qp0ciInlzk12PxLKoc0nvovBy8=
X-Gm-Message-State: AOJu0YyVmR6n5iwQ51s8Z9PIFFjGRcsjYc93YmRQXysjAVvUFbXvyv/a
	z3zU4Z5BfOq+BkuufjLP5O0umWCfZwtCsGshoOYEDZSEV7QzWkh+6Jp8A6D4jHc=
X-Google-Smtp-Source: AGHT+IG5lgF+BKQjMgKPZQzUq39O7D+KNOnPQb8jPVcS2mbNCEouaP1WuRNfXcHFWTJR3ZDOvi6FKw==
X-Received: by 2002:a05:6512:11c9:b0:512:fab6:6df6 with SMTP id h9-20020a05651211c900b00512fab66df6mr1611451lfr.4.1708934497107;
        Mon, 26 Feb 2024 00:01:37 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id o7-20020a63f147000000b005dc9439c56bsm3414673pgk.13.2024.02.26.00.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 00:01:36 -0800 (PST)
Message-ID: <57068435-f797-4eec-ab7d-79161269cd0d@suse.com>
Date: Mon, 26 Feb 2024 18:31:31 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/224: do not assign snapshot to a subvolume
 qgroup
Content-Language: en-US
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
 fstests@vger.kernel.org, Sidong Yang <realwakka@gmail.com>
References: <20240226040234.102767-1-wqu@suse.com>
 <e4703a32-9b16-48c2-b5ea-9477be071a9b@oracle.com>
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <e4703a32-9b16-48c2-b5ea-9477be071a9b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/2/26 16:58, Anand Jain 写道:
> On 2/26/24 09:32, Qu Wenruo wrote:
>> For "btrfs subvolume snapshot -i <qgroupid>", we only expect the target
>> qgroup to be a higher level one.
>>
>> Assigning a 0 level qgroup to another 0 level qgroup is only going to
>> cause confusion, and I'm planning to do extra sanity checks both in
>> kernel and btrfs-progs to reject such behavior.
>>
>> So change the test case to do regular higher level qgroup assignment
>> only.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> looks good.
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
>   Applied to
>     https://github.com/asj/fstests.git for-next

Thanks for the review and merge, although I'd also like to get some 
feedback from the original author, to make sure there are not some weird 
use case.

Thanks,
Qu
> 
> Thanks, Anand
> 
>> ---
>>   tests/btrfs/224 | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/btrfs/224 b/tests/btrfs/224
>> index de10942f..611df3ab 100755
>> --- a/tests/btrfs/224
>> +++ b/tests/btrfs/224
>> @@ -67,7 +67,7 @@ assign_no_shared_test()
>>       _check_scratch_fs
>>   }
>> -# Test snapshot with assigning qgroup for submodule
>> +# Test snapshot with assigning qgroup for higher level qgroup
>>   snapshot_test()
>>   {
>>       _scratch_mkfs > /dev/null 2>&1
>> @@ -78,9 +78,9 @@ snapshot_test()
>>       _qgroup_rescan $SCRATCH_MNT >> $seqres.full
>>       $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
>> +    $BTRFS_UTIL_PROG qgroup create 1/0 $SCRATCH_MNT >> $seqres.full
>>       _ddt of="$SCRATCH_MNT"/a/file1 bs=1M count=1 >> $seqres.full 2>&1
>> -    subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
>> -    $BTRFS_UTIL_PROG subvolume snapshot -i 0/$subvolid $SCRATCH_MNT/a 
>> $SCRATCH_MNT/b >> $seqres.full
>> +    $BTRFS_UTIL_PROG subvolume snapshot -i 1/0 $SCRATCH_MNT/a 
>> $SCRATCH_MNT/b >> $seqres.full
>>       _scratch_unmount
>>       _check_scratch_fs
> 

