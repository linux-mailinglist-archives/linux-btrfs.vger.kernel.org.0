Return-Path: <linux-btrfs+bounces-10460-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650DB9F4590
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 08:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9299616C7BE
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 07:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DC51D63D9;
	Tue, 17 Dec 2024 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HTbqDamM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97359A29
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734422237; cv=none; b=UnjMJ1J390y3NsFNRYn4z3JI2HyIbY5YDuQtTs/ESPu5rfcOxQPwCaausQjFve7fmbpqgZsBGwzbzc8FUDx6VP5Uc0KuQc1R4eRA5Umxz5ZEaGrBF6jNC3kNDlk1UkcW1zVmAqrjUQV+Pd0wkjUlfUmRoZP4dzJ6kBWMGsPSS6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734422237; c=relaxed/simple;
	bh=sWbvi+MRtRX1F8yn0PK5gs+eI2z7rl8lDc2dHT9rrZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQKjxN7jNT+bPUPA+Lf2qdXkflRxoMuiyOP7SOTcydH/C43GGALLq1CyyAzeV11CQftzFzXfPEgO6J2y8GQ8iISboD5H0qGqSqMPaPiqzFvqZrh8dkiz8vMNyQSy1SXsNrCBLhhFMcoQgnVo7q3TR6Jai6eYzrpAGJ86XeGzaLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HTbqDamM; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3863c36a731so3546841f8f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 23:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734422234; x=1735027034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TPgeOsepUL8NaDFFwx9ywxpWtq67Qj3d28D247T6wjg=;
        b=HTbqDamMRVHgVzMYt85DnyUkr0pfsFife3iASdb2bnl4wse/Uk5I7P5yZ9zZAjd7cZ
         oRSMmJ1q1DUxXwSqmkgmjH2Mcqe21XO+PsRPUKvMZZ8G60k/uwNpmixLQknRI8L8gHta
         jJASMYyQF7zUOYXw+rUydwMP8vEmgZDosiIvDnrMbdFaZxX/hbkqMmjGvsNTU0zDDCqw
         ImDpgY6XWWE+fHh58CCh4DCofZMi6+UkPowxmnlsgTjF/QoddhpjPAtqsXu3KxrJ9fP3
         rORTdwW/VbJxDlTDZPldCLKYl0EWD19xBQEOte3sblycbumVi+5m3+EAtfx4/dBg4EqF
         9LYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734422234; x=1735027034;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPgeOsepUL8NaDFFwx9ywxpWtq67Qj3d28D247T6wjg=;
        b=M+3cEI8XlXZcAvr2fZn8rw8tfDJLFiS7P+AGQpTaX60nG7abi4zzDaSiTVIqZ52nqu
         XUKd1+mNdaqN6BgLHs/eUXngPczpvZqApnpm4ml5c57pudM7oQgCoIS5lfBmLsJznGR5
         q207+JxInwlGN3HjUqlPPdkxrmdKXM42S4GvqDe1OSPbNITUkVRuqB04z/w57SHrqpZm
         RQh9VN2I0l0XcfS2LxR8dFA2dfWMJAwq99dlGd5l1fO7hCdhbrxvRsKfF2t1m64KfttT
         10HoMkv1H73oFFuKZ5yX8S+ktFeUJ0zlYQIPalC8cgYlzvG4HWXJhfk/1yavn9PebOMw
         BgVQ==
X-Gm-Message-State: AOJu0YwDQ3J/P9UCkjFioN6K3FYAghQGWA6Hc00nB3G/ehXE5je3sw3t
	LHECW0sy1Znk3ePJbGrl+gLUw6Qs6LeW8WjafeBGixrVTayCM/lBrvfJKetuVXI=
X-Gm-Gg: ASbGncvvUwV5cXUolJYHQKd14nuktrxtTOCDolO/h5H6iuZDQxp12dIt5IIQdFil7oo
	QZaI3O6365j3r8dDKg2wi7oPWE6eILx7GVV6lHhnrbMETwenDH64dcRYLtxapTxPEXqDcmwqugW
	BIg7JZfn5NEQBWS4x3bKDlDcsEcPoDFe+oMnM6iytnHraIEMj6p5ZnhXqmaNfaee6+ZRtYZJa3U
	n0QWe11i9hfrBFwd4JCa7VB3K1WvBszCIsNw2vBK+pUr8dUvDV5HIecfnunEe/3MSD4PFl5MusU
	g4VaYl3P
X-Google-Smtp-Source: AGHT+IH5pP8/M924hmvMrlYhjcMGfu6RkLF9VaxaKL0S7iN+FPzgLEN+3MwZDa1oCbQR3sJ3+mRw2g==
X-Received: by 2002:a05:6000:470b:b0:385:df6d:6fc7 with SMTP id ffacd0b85a97d-38880ada7e1mr11566149f8f.25.1734422233624;
        Mon, 16 Dec 2024 23:57:13 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e500b8sm52660245ad.123.2024.12.16.23.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 23:57:13 -0800 (PST)
Message-ID: <3dc2706f-d0ed-4190-b385-8bce19d7d6c3@suse.com>
Date: Tue, 17 Dec 2024 18:27:08 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/146: fix failure due to missing test number
 argument for fsync-err
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, dchinner@redhat.com,
 Filipe Manana <fdmanana@suse.com>
References: <5200182586d153054cbfc2549dea4b862c65e9fc.1733852046.git.fdmanana@suse.com>
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
In-Reply-To: <5200182586d153054cbfc2549dea4b862c65e9fc.1733852046.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/11 04:04, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> After commit 88c0291d297c ("fstests: per-test dmerror instances") the
> script src/dmerror now has an extra argument, corresponding to a test's
> sequence number, but btrfs/146 isn't passing that argument so the test
> fails like this:
> 
>    $ ./check btrfs/146
>    FSTYP         -- btrfs
>    PLATFORM      -- Linux/x86_64 debian0 6.13.0-rc1-btrfs-next-181+ #1 SMP PREEMPT_DYNAMIC Tue Dec  3 13:03:23 WET 2024
>    MKFS_OPTIONS  -- /dev/sdc
>    MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
>    btrfs/146 3s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/146.out.bad)
>        --- tests/btrfs/146.out	2020-06-10 19:29:03.818519162 +0100
>        +++ /home/fdmanana/git/hub/xfstests/results//btrfs/146.out.bad	2024-12-10 17:19:40.363498130 +0000
>        @@ -1,3 +1,4 @@
>         QA output created by 146
>         Format and mount
>        -Test passed!
>        +Usage: /home/fdmanana/git/hub/xfstests/src/dmerror {load_error_table|load_working_table}
>        +system: program exited: 1
>        ...
>        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/146.out /home/fdmanana/git/hub/xfstests/results//btrfs/146.out.bad'  to see the entire diff)
>    Ran: btrfs/146
>    Failures: btrfs/146
>    Failed 1 of 1 tests
> 
> Fix this by passing the test's sequence number as an argument.
> 
> Fixes: 88c0291d297c ("fstests: per-test dmerror instances")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/btrfs/146 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/146 b/tests/btrfs/146
> index d6d2829a..c1243757 100755
> --- a/tests/btrfs/146
> +++ b/tests/btrfs/146
> @@ -57,7 +57,7 @@ _require_fs_space $SCRATCH_MNT $write_kb
>   testfile=$SCRATCH_MNT/fsync-err-test
>   
>   SCRATCH_DEV=$old_SCRATCH_DEV
> -$here/src/fsync-err -b $(($write_kb * 1024)) -d $here/src/dmerror $testfile
> +$here/src/fsync-err -b $(($write_kb * 1024)) -d "$here/src/dmerror $seq" $testfile
>   
>   # success, all done
>   _dmerror_load_working_table


