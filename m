Return-Path: <linux-btrfs+bounces-18786-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3D6C3D703
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 21:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A53BF350ED7
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 20:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD813016FB;
	Thu,  6 Nov 2025 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VvWnVQ1q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4462D73A6
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762462709; cv=none; b=XH4N2hspi+swak4eVJOQq4VUZ4d+DS2aawIsfHNzSUgEeJ7Q/bKauiHfnjqeXz3o5R8zzCxdlEO1u0RBbpCEo6H4UEHATl1p4jAfAJ8bAzmUIYvON6h/K+Pz5vFp+awdGnAL1bTJgIKo+hWTG6HcAsgCziyajEqkPxIR8Jy1KM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762462709; c=relaxed/simple;
	bh=KZhz5eQ7q/AiEupzpsmWBnryb8pI1ssE1cx2mIkFWao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQwl+itHwcjl0GJlOGCAxZ1KnRZ9GHbG/81hkILODQiOd3DDQMsqVBOmRXk/+vlSdpLOdrGPuM44M4ia3zN0Oq26jn1Gl6lKJCfCwWTfZWp2/7AVJDx3QUZ4C77R+tsThFFTZSRd9lVSWOAPvrhfoFtgnCmhgo8ujY61Uel6tZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VvWnVQ1q; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429bf011e6cso52179f8f.1
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Nov 2025 12:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762462705; x=1763067505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ao8extSo5bmFO2zc5UKdNwzzn7TqD+9Bp3jkMJaiWb4=;
        b=VvWnVQ1qVq4Iwdx6jNpHf9aEkH8ntQ3TYnIgKK+n4xJcNNLnOy/MoJpvmYfx24cE0v
         1sM5q8EDtQ3LRE2oce29wcP7sHwQ8GjMAOjzw69ZVdXgsgOH1579b4cIsEoZpf/+5Wm/
         caHPsr9u94CW5NipyDFdGQtnEA5a9dCCOm8stxRF3xbTEi3RVpAlqJfPAKKZZaWlAtWk
         liaRTdJ4h2ffLfiSu9SawhYAzw7HmOOCEkc3M06aQ2sh1PgmJV1rrbcTWa6iUfBQbL3c
         RZISm/+FGklNxWGir3lelOMZuvIWhMC6k0IoJU3tEQ/GE412fUSDUS86luhRUVOvQKIg
         T76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762462705; x=1763067505;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ao8extSo5bmFO2zc5UKdNwzzn7TqD+9Bp3jkMJaiWb4=;
        b=js2D9NcA9rhmF+HCFg0vvgg+KatY1PhwEJw/K4dGIzjEq6TxN3qJ3vDyFA5ILtIgKF
         efQTvOeMzUwGYtYS4vo80lq9wVJMwTHrU1LJBGhcLW/ASlcD/6yEJiQ0Sn6rIwdTHlJy
         1gXARhHP8M3jGkTlOzJhprcbot+p45YDXNDAd/GpBESKDVX2DR/DqnaBjehjQr/oFFsQ
         m3Onw9oo9hZ17hVojj1VzRBafqNLAZohhbpU/MegvUZtBLyKY4Y2cC5oKWgYpiubqKfv
         Dg/XofU7YT3yngQvqPfs9rgfoq3B9f/P8mVBtRzPOI+OuPgxP3/yC/GyOcc9eUFkg85e
         jX3g==
X-Gm-Message-State: AOJu0YxvQtXWN5JPlYr91iJul6G1o+F+KZq5CH12FNyXjzk6SYbc3NaV
	xhDGGZOMrRoktbHCRqlqU/Irghtj08OGW8RpOvJpQ6KaDPAy4/XrcQRa1spPv22DTqo=
X-Gm-Gg: ASbGncsRULLjyMnt64zhA7k9g6sl0SbMtPSC9jXtvOe15/GBU3J0QSYOmshoVaQ0ufv
	q/iNB8qNNcYcEAZn5Nsglj0Yrl4lf8cCNPL39/HIh3t7yYx7dJDYHyB3vsis8LN78Sau6zSXSSu
	4N0UyZzWlcHqDPgwFVeezmwDz5Lrc1UbwaEn2vefLoPc+OunE65tbaFOJL8zSSlxW6ACDI47v9M
	8T3x0CS4K68DLqZ01Mk9VY25fE0JEQ6cWHwU6WwoXr5/vLW0QuR9n54HTjdoO+tUzz9wbo5nmQR
	Etea6Ajf/tskzjtfCPtDKAQYrI/s4V8IswfOeX3QLrJQtGBYm3AGaydK7dQk7MNP1sMHflist9j
	axhEvu3NZdtBznz0qYmaKi5aUx6kEdXA0J9VTr+aSpHQd7Lmbzy7ClwlgNe49PVoakflq66cXpr
	3MBAFyjS3N/6TKjj3EFxmpTbPB+Bo5
X-Google-Smtp-Source: AGHT+IH5MGpGQM60OmxnprGDqam5Y8Wv/zgFMjhf9oztcy5xq0ofEfq8Ahm1sFIq06k6wV7CQuNr8A==
X-Received: by 2002:a05:6000:4282:b0:426:ff46:463d with SMTP id ffacd0b85a97d-42adc68ab4amr520425f8f.2.1762462704888;
        Thu, 06 Nov 2025 12:58:24 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccb5c3d4sm453464b3a.61.2025.11.06.12.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 12:58:23 -0800 (PST)
Message-ID: <fb616f30-5a56-4436-8dc7-0d8fe2b4d772@suse.com>
Date: Fri, 7 Nov 2025 07:28:19 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Why generic/073 is generic but not btrfs specific?
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
 "frank.li@vivo.com" <frank.li@vivo.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <92ac4eb8cdc47ddc99edeb145e67882259d3aa0e.camel@ibm.com>
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
In-Reply-To: <92ac4eb8cdc47ddc99edeb145e67882259d3aa0e.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/7 07:10, Viacheslav Dubeyko 写道:
> Hello,
> 
> Running generic/073 for the case of HFS+ finishes with volume corruption:
> 
> sudo ./check generic/073
> FSTYP -- hfsplus
> PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.17.0-rc1+ #4 SMP PREEMPT_DYNAMIC
> Wed Oct 1 15:02:44 PDT 2025
> MKFS_OPTIONS -- /dev/loop51
> MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
> 
> generic/073 _check_generic_filesystem: filesystem on /dev/loop51 is inconsistent
> (see XFSTESTS-2/xfstests-dev/results//generic/073.full for details)
> 
> Ran: generic/073
> Failures: generic/073
> Failed 1 of 1 tests
> 
> sudo fsck.hfsplus -d /dev/loop51
> ** /dev/loop51
> Using cacheBlockSize=32K cacheTotalBlock=1024 cacheSize=32768K.
> Executing fsck_hfs (version 540.1-Linux).
> ** Checking non-journaled HFS Plus Volume.
> The volume name is untitled
> ** Checking extents overflow file.
> ** Checking catalog file.
> ** Checking multi-linked files.
> ** Checking catalog hierarchy.
> Invalid directory item count
> (It should be 1 instead of 0)
> ** Checking extended attributes file.
> ** Checking volume bitmap.
> ** Checking volume information.
> Verify Status: VIStat = 0x0000, ABTStat = 0x0000 EBTStat = 0x0000
> CBTStat = 0x0000 CatStat = 0x00004000
> ** Repairing volume.
> ** Rechecking volume.
> ** Checking non-journaled HFS Plus Volume.
> The volume name is untitled
> ** Checking extents overflow file.
> ** Checking catalog file.
> ** Checking multi-linked files.
> ** Checking catalog hierarchy.
> ** Checking extended attributes file.
> ** Checking volume bitmap.
> ** Checking volume information.
> ** The volume untitled was repaired successfully.
> 
> Initially, I considered that something is wrong with HFS+ driver logic. But
> after testing and debugging the issue, I believe that HFS+ logic is correct.
> 
> As far as I can see, the generic/073 is checking specific btrfs related case:
> 
> # Test file A fsync after moving one other unrelated file B between directories
> # and fsyncing B's old parent directory before fsyncing the file A. Check that
> # after a crash all the file A data we fsynced is available.
> #
> # This test is motivated by an issue discovered in btrfs which caused the file
> # data to be lost (despite fsync returning success to user space). That btrfs
> # bug was fixed by the following linux kernel patch:
> #
> #   Btrfs: fix data loss in the fast fsync path
> 
> The test is doing these steps on final phase:
> 
> mv $SCRATCH_MNT/testdir_1/bar $SCRATCH_MNT/testdir_2/bar
> $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir_1
> $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
> 
> So, we move file bar from testdir_1 into testdir_2 folder. It means that HFS+
> logic decrements the number of entries in testdir_1 and increments number of
> entries in testdir_2. Finally, we do fsync only for testdir_1 and foo but not
> for testdir_2.

If the fs is using journal, shouldn't the increments on the testdir_2 
already be journaled? Thus after a power loss, the increments on 
testdir_2/bar should be replayed thus the end user should still see that 
inode.

To me this looks like a bug in HFS logic where something is not properly 
journaled (the increment on the testdir_2/bar).


Finally, if you're asking an end user that if it is acceptable that 
after moving an inode and fsync the old directory, the inode is no 
longer reachable, I'm pretty sure no end user will think it's acceptable.

> As a result, this is the reason why fsck.hfsplus detects the
> volume corruption afterwards. As far as I can see, the HFS+ driver behavior is
> completely correct and nothing needs to be done for fixing in HFS+ logic here.

Then I guess you may also want to ask why EXT4/XFS/Btrfs/F2fs all pass 
the test case.

Thanks,
Qu

> 
> But what could be the proper solution? Should generic/073 be excluded from
> HFS/HFS+ xfstests run? Or, maybe, generic/073 needs to be btrfs specific? Am I
> missing something here?
> 
> Thanks,
> Slava.


