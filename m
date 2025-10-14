Return-Path: <linux-btrfs+bounces-17787-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4DABDB5B8
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 23:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F38D192713E
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 21:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E24530C344;
	Tue, 14 Oct 2025 21:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lfw1zTrq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03131FBEA6
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 21:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760476123; cv=none; b=bZrPXZ6yCo2LOHRrJ7RrKqP6kUqPG8rmp8v8lufaOynkXx1/jNpBt41YtEtLQhQhukDKt7Y1kqLwEaiG8xtUU9XB7aPKniGtmEpFp6DDw1fS25IvhLCOhAw9UHLXi2QJwZlCys8SjtJpEpMb7XT2WPJx6Z+qW6bmUfHRfnB5aOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760476123; c=relaxed/simple;
	bh=cnJtV5UStc6Ve+q6PTyQ+wuRR2r/C1//Qxh9geDvSXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QpQeTvVZdf/t3C3+IuulSneFtZ6MOhWoe+/vDpp2lsrARExBqIKCdCukedp1cZlSJ5muJuAtaAijezWhJrXqPntjJw/lSWAPgy5NcyYu/Bu/9d+dVSypuvIgDhvN/cUEbgVHpYqv1cAJC3oLd86dVS9TKQ4JShqz62tebiMXLLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lfw1zTrq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso244411f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 14:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760476120; x=1761080920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=siBEdSXb+TOq19NSx1UjT5CHbXYzR/FE6uFr7iLMMvY=;
        b=Lfw1zTrqg30dCP1eGdjNWY1Sg+fLzbbnCj2N5NGwOLbjEQH3ttPTbko59Y/Dm7AqC3
         8Az4V4TIVgwIf9OjHF7tACJhT6HNTkOdq/8UwZXkKv4vNmABEYfHbVQRLVVkhIr/SZEF
         9Bkl/jurIDeDJ9TZUkZb07rFBjelYmG04ffr+lSduAlrXyn+oUDyydpibupUaaEPLb2z
         /9ZKbWURBaP3hsVK7AZVL9KFBBq5Rl82rV7czuwyF2GLS3cFSUXSfO93VF2aqAIW9QdL
         H1eftBtweRms6ZTY/VTz9tHN8JSpkPvepNFbg7bmyOE62pEBpGvz403YvkiQIzi9zOvj
         defw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760476120; x=1761080920;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siBEdSXb+TOq19NSx1UjT5CHbXYzR/FE6uFr7iLMMvY=;
        b=oQQeOL0/zrOfRDG9rUbL3pM4WiYSJOfo+gmzhjPQqzYDkHijkglaXjfd4QgwQqO6kI
         YSshWA80amTv/dMnkbxRYQZVXirJUYfwGxoO/DowSXHf+zJp5zEjlUhNDHEaPfPPPsLn
         ujMQxFlpDeVq6v0YO9Egb6AMLBlNVZLwrAZh4u6+puPBvYp89GZkD1VHZ1cGbRByurtB
         PpHDexmfPIr1iEpmyf9pwaxFrLhyPnr31+NX0sGkmsWpcyzmAjgjdpKtAWsftarAT5Hm
         4zQw3ShoWn0hp9XW60W+cNCk8xhwEzM3GkGFp+9oz20QO0jJv2BDbbh7j5VNglCjI8ec
         EDtA==
X-Forwarded-Encrypted: i=1; AJvYcCW1IP5Ou7HAI18Ne5Q/diE0HN8hopvdxu2IFGrM2fEUzdWubUqC+dX9VQWczwDy8tbTV16iQM1GtuD0lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTmba+HY9Wu7EC1v1hItPTJ5imGU7OQ0vCcgT94aGnisBq1NPV
	QUuJlWSkQixoXzQP8uxSWwpdc3oePBZI9jbaIzdMskcXkmR9IKHFvXZ3HMhOz/Q/6QA=
X-Gm-Gg: ASbGncscA3F8J4kOwc9LfD2oXduQaSz7611T64+oaj5vMoyE8EDGxDvjr1Yg+gbpSa1
	7VlTMwHR+0VUN5mNRudP/jCJZ15RMrh9dws+M9cLI1P1nr2YWbwGkz1Zdv1CFu4sAmPnur4o07V
	i3ba5CtfNAPBpupa2/URg1X25GKloHKgYgTfhwmkQMA9qa4aI0/Z1UGCcQxO2nOer/JEzTroX6/
	PG0ItTMud2Cy+hFPWMUqfLknYYF7YJvLpYuvw104rufLxlic9OETMXz26CAd64Mo12EJ7ZBAWj+
	q6T8c00rKUa/+2aUq3FUu+3VkZ6vfM1YsVY2N1IHvRS+LedMnvfYN+fjyTJaSA5dGNRl01sIhDo
	81B0Y1vpHiJ1riHN2hbrfhwvlS7hIRJZJwJmvtTvKHS4obPrsmrBnSThprHJPVyCMujmC+dA7U9
	DCIswf
X-Google-Smtp-Source: AGHT+IFIANIwScg+5GHJALy/pEalv764AKxh+pONr/MZ4Z/a40QUVzKfGvCzQ2ZGEWok1LqkLwNKLw==
X-Received: by 2002:a05:6000:4284:b0:426:d30a:88b0 with SMTP id ffacd0b85a97d-426d30a8fc8mr10165982f8f.22.1760476119851;
        Tue, 14 Oct 2025 14:08:39 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36738sm174176085ad.87.2025.10.14.14.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 14:08:39 -0700 (PDT)
Message-ID: <6982bc0a-bb12-458a-bb8c-890c363ba807@suse.com>
Date: Wed, 15 Oct 2025 07:38:33 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] ovl: brtfs' temp_fsid doesn't work with ovl
 index=on
To: dsterba@suse.cz, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kernel-dev@igalia.com, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>
References: <20251014015707.129013-1-andrealmeid@igalia.com>
 <20251014182414.GD13776@twin.jikos.cz>
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
In-Reply-To: <20251014182414.GD13776@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/15 04:54, David Sterba 写道:
> On Mon, Oct 13, 2025 at 10:57:06PM -0300, André Almeida wrote:
>> Hi everyone,
>>
>> When using overlayfs with the mount option index=on, the first time a directory is
>> used as upper dir, overlayfs stores in a xattr "overlay.origin" the UUID of the
>> filesystem being used in the layers. If the upper dir is reused, overlayfs
>> refuses to mount for a different filesystem, by comparing the UUID with what's
>> stored at overlay.origin, and it fails with "failed to verify upper root origin"
>> on dmesg. Remounting with the very same fs is supported and works fine.
>>
>> However, btrfs mounts may have volatiles UUIDs. When mounting the exact same
>> disk image with btrfs, a random UUID is assigned for the following disks each
>> time they are mounted, stored at temp_fsid and used across the kernel as the
>> disk UUID. `btrfs filesystem show` presents that. Calling statfs() however shows
>> the original (and duplicated) UUID for all disks.
>>
>> This feature doesn't work well with overlayfs with index=on, as when the image
>> is mounted a second time, will get a different UUID and ovl will refuse to
>> mount, breaking the user expectation that using the same image should work. A
>> small script can be find in the end of this cover letter that illustrates this.
>>
>> >From this, I can think of some options:
>>
>> - Use statfs() internally to always get the fsid, that is persistent. The patch
>> here illustrates that approach, but doesn't fully implement it.
>> - Create a new sb op, called get_uuid() so the filesystem returns what's
>> appropriated.
>> - Have a workaround in ovl for btrfs.
>> - Document this as unsupported, and userland needs to erase overlay.origin each
>> time it wants to remount.
>> - If ovl detects that temp_fsid and index are being used at the same time,
>> refuses to mount.
>>
>> I'm not sure which one would be better here, so I would like to hear some ideas
>> on this.
> 
> I haven't looked deeper if there's a workable solution, but the feature
> combination should be refused. I don't think this will affect many
> users.
> 

I believe the root problem is that we're not fully implementing the 
proper handling just like other single-device fses.

We do not use on-disk flags which means at least one fsid is registered 
into btrfs, thus we have to use different temp-fsid.

If fully single-device feature flag is properly implemented, we should 
be able to return the same uuid without extra hacks thus solve the problem.

Thanks,
Qu

