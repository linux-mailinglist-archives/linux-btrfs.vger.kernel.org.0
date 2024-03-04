Return-Path: <linux-btrfs+bounces-2991-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C472786F931
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 05:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AEB1B20BF5
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 04:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2A063AC;
	Mon,  4 Mar 2024 04:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LlAJnLhu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA62B539E
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Mar 2024 04:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709526475; cv=none; b=XICVAXf96c/W89qF9sqzvLQWqo7ZqfeiWPMTFSTMn01NVgumq7yWtrHTWqyZMCY737xIJ3iNck+/s/FKZBHM5LGwRLi4wI7bjWomYnqmJVjAR8kDE5jEdhRukvyZpHC7WQMCkOkHSxYB9JHAaWY0nlYybKBoOP30vafNs3pDPKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709526475; c=relaxed/simple;
	bh=dDrtp7s5XeEXWiZ+eg07vO+ITwVKrMv0ZbRHjGHHqvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tc4NNZ7GkgcS/ui7m80xsf792kOs103FaHXhwooq/JZSVM8WPXzfocNh5y7hSMawvlF+23q9eU3zO0omRTJiDkYGuuhUCpqJlAAR56r9HuRRJ3tbs3Kxwauk4tq+0AnZen2+3hEYxlYNUmM97vxWUL2bXid8x9zLpIhH+ElS0rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LlAJnLhu; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so46228011fa.3
        for <linux-btrfs@vger.kernel.org>; Sun, 03 Mar 2024 20:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709526471; x=1710131271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vgpb2OR0Jsq77PkKrQhrp+jbKirsWQYnihmKo6Ts6sk=;
        b=LlAJnLhuR/pED78mn2I667dJwRj1oK94A9r/z4DSch7/awwo+6OXX+DV6EmXNmxUyR
         ghvi8aqyp/n4V0+pNyHd5A3DExLGmueUN+9+hyS7ETqGHWolS2c2BZtHzB1WHJsgfbWF
         a32fQDnZs3Yv16X27lk51+pwsyl8RBOTRgF+j+8dxQzVRjr3VHEYsuyRiZfdD+hiswnV
         4rTv6clbT6qn0SYs3e4kUQQ+ZHaaSMeEqMSy8WQeZgSmNa388b7/ZHU6f8VuOmcD2cvL
         hWo8AdcnHyZnFuYp2JkbHb8JWTbV7nWrlpDs8BdGjjnv3kx6F53bNS1H0lAM55wsSgEI
         nD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709526471; x=1710131271;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vgpb2OR0Jsq77PkKrQhrp+jbKirsWQYnihmKo6Ts6sk=;
        b=v7Xa35CdfoqKojsD+6FS4jTLoF7xoauk+/o5BfizDRAdqEUMT4uk+n1CuHXZdqFRVp
         9SKg0XK6tIIZCMgj1Vx+WdkVda8ZioJKpWFqNWbfjPSiHYu2V4z5l7XLGErFBMCjidTh
         jf2BuBjDmmcawldO26bYlBaLc69TFAadI8/rwPujpAiBDbl+lIj9TShen45XujpBLnUj
         Kde8cZWEXfOglOo87c7EHi5t2BKPVzA7o+XejO2osAXvpixmcKA0AbAgyS4/2QEbCJoS
         zuxzFc/7ov3JkVkvSgDovhQssE66klT7GK+EHoCZwcEhENmJYEwvC7SYGVFdMuGvEPGY
         Iz5A==
X-Gm-Message-State: AOJu0Yy7lE2gYnT4xwSMJcKU0bKLhyMAc9t+Hc30/b547PatsnysoXpl
	xoA9t/1KVGVMU3TQp6MnZMjrRxKOpAWGfetq5LjKS+eBBawKWjEU7VcxQHNdjoo=
X-Google-Smtp-Source: AGHT+IFOLi7PqbqTjCTlzjTb4yZyXxxy4BFELFfelgzPs1TFuTzFxobOo3DhtxGWPTXXNo5shK2L/A==
X-Received: by 2002:a2e:968a:0:b0:2d3:318c:7651 with SMTP id q10-20020a2e968a000000b002d3318c7651mr5150493lji.44.1709526470857;
        Sun, 03 Mar 2024 20:27:50 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id im22-20020a170902bb1600b001dcd00165a6sm7506289plb.208.2024.03.03.20.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 20:27:50 -0800 (PST)
Message-ID: <25153f23-a1b0-41b1-9cb7-4f18f08d659b@suse.com>
Date: Mon, 4 Mar 2024 14:57:45 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/121: allow snapshot with invalid qgroup to
 return error
Content-Language: en-US
To: Zorro Lang <zlang@redhat.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20240303065251.111868-1-wqu@suse.com>
 <20240304041840.rfn6mhkk5a6mlxnf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
In-Reply-To: <20240304041840.rfn6mhkk5a6mlxnf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/4 14:48, Zorro Lang 写道:
> On Sun, Mar 03, 2024 at 05:22:51PM +1030, Qu Wenruo wrote:
>> [BUG]
>> After incoming kernel commit "btrfs: qgroup: verify btrfs_qgroup_inherit
>> parameter", test case btrfs/121 would fail like this:
>>
>> btrfs/121 1s ... [failed, exit status 1]- output mismatch (see /xfstests/results//btrfs/121.out.bad)
>>      --- tests/btrfs/121.out	2022-05-11 09:55:30.739999997 +0800
>>      +++ /xfstests/results//btrfs/121.out.bad	2024-03-03 13:33:38.076666665 +0800
>>      @@ -1,2 +1,3 @@
>>       QA output created by 121
>>      -Silence is golden
>>      +failed: '/usr/bin/btrfs subvolume snapshot -i 1/10 /mnt/scratch /mnt/scratch/snap1'
>>      +(see /xfstests/results//btrfs/121.full for details)
>>      ...
>>      (Run 'diff -u /xfstests/tests/btrfs/121.out /xfstests/results//btrfs/121.out.bad'  to see the entire diff)
>>
>> [CAUSE]
>> The incoming kernel commit would do early qgroups validation before
>> subvolume/snapshot creation, and reject invalid qgroups immediately.
>>
>> Meanwhile that test case itself still assume the ioctl would go on
>> without any error, thus the new behavior would break the test case.
>>
>> [FIX]
>> Instead of relying on the snapshot creation ioctl return value, we just
>> completely ignore the output of that snapshot creation.
>> Then manually check if the fs is still read-write.
>>
>> For different kernels (3 cases), they would lead to the following
>> results:
>>
>> - Older unpatched kernel
>>    The filesystem would trigger a transaction abort (would be caught by
>>    dmesg filter), and also fail the "touch" command.
>>
>> - Older but patched kernel
>>    The filesystem continues to create the snapshot, while still keeps the
>>    fs read-write.
>>
>> - Latest kernel with qgroup validation
>>    The filesystem refuses to create the snapshot, while still keeps the
>>    fs read-write.
>>
>> Both "older but patched" and "latest" kernels would still pass the test
>> case, even with different behaviors.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/btrfs/121 | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/btrfs/121 b/tests/btrfs/121
>> index f4d54962..15a54274 100755
>> --- a/tests/btrfs/121
>> +++ b/tests/btrfs/121
>> @@ -24,8 +24,14 @@ _require_scratch
>>   _scratch_mkfs >/dev/null
>>   _scratch_mount
>>   _run_btrfs_util_prog quota enable $SCRATCH_MNT
>> -# The qgroup '1/10' does not exist and should be silently ignored
>> -_run_btrfs_util_prog subvolume snapshot -i 1/10 $SCRATCH_MNT $SCRATCH_MNT/snap1
>> +# The qgroup '1/10' does not exist. The kernel should either gives an error
>> +# (newer kernel with invalid qgroup detection) or ignore it (older kernel with
>> +# above fix).
>> +# Either way, we just ignore the output completely, and we will check if the fs
>> +# is still RW later.
> 
> The explanation makes sense to me, just ask if you might want to output to .full
> file, to save some information for debug if the test fails? I can help to change
> the "&> /dev/null" to "&> $seqres.full" if you only need to change.

Oh, that's very kind of you.

Although in that case "&>" would overwrite the .full file,
">> $seqres.full 2>&1" would be better IHMO.

Thanks,
Qu

> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> Thanks,
> Zorro
> 
>> +$BTRFS_UTIL_PROG subvolume snapshot -i 1/10 $SCRATCH_MNT $SCRATCH_MNT/snap1 &> /dev/null
>> +
>> +touch $SCRATCH_MNT/foobar
>>   
>>   echo "Silence is golden"
>>   
>> -- 
>> 2.42.0
>>
>>
> 

