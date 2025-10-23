Return-Path: <linux-btrfs+bounces-18229-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF53C036A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 22:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9660C3AB099
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 20:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450662BE05A;
	Thu, 23 Oct 2025 20:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Eg0lvF2d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ED8223702
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252291; cv=none; b=r34c1DWvFVHWG1l/6+8/FSd6NjCL33puwyhGDe2II/AncxeIYDC/7Igg/kmubn6qhRm/Iz3E7P6iLafDQMrAowmLpkdwOla+599B46JpmgI78IaW10n57hWXRtRzZste03p96qi0O5DnUODuoXWxZkcGLcxawSrBQZJ0X3Hd+HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252291; c=relaxed/simple;
	bh=lnlUByvGOB5AT7NgpJx+u52080m/z1DKMMWIk2WQ4dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=de8Iy4q+xmKOJQ8NUNdL4tU/ZegerM1ARRY3S7z2UWnSr4jFq4fji5KjwdsSDI0q5Tx+hegdfNIA81+g71aP8P6WdFWv02+MQRUFHHwJ9A9AmU5SlzWSm4N3Dh0flLUpZgQvWaKiTHI7D4v4dRpHIQKXwIWCUxU7OAlfQMJGGsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Eg0lvF2d; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-421851bcb25so803046f8f.2
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 13:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761252288; x=1761857088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TFe/5+ugCp5OUNH2EVdwN/pvPbU7Hl4sb9Y5bzVIjgc=;
        b=Eg0lvF2dOpO8KCUnbtDCf8eZGujcEupQdJMM9MfFsdHLmLrk3xN6OUTTk7xJi7mIeF
         YDOgucIDDOXQxGIK8z9IcVmBqd0JXNWMtzWwc7FHIued3nDoYP+nM/zN6vQByithA4BF
         VFT/SSGmHCcZVH0RpOpb+7DkOcxMP03iKZh5rYFt1otFMW12ZtE0+RrsbQSHRAszOL8F
         abiCYOh6icijEHi/i5zRFvyGHb+34P0ucJ7bjDNsNsN3deJzevdgm6RTdetQ/wcHqBDp
         LDgAWifbefZYv52/hDknZPo4KjfCztVjTN3zqPdRi/FJErG/OS7wmbQ85c+ZJ3utQCUS
         Jm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252288; x=1761857088;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFe/5+ugCp5OUNH2EVdwN/pvPbU7Hl4sb9Y5bzVIjgc=;
        b=boe3bJeV/kmNNII6giLNCqbUQ+mAlkcSnhS0YlxYIB0c5sjH4fjhmkdavp4drXegGg
         KN2sOupDuRO6GAqfoUybVlzLtLbXD+kCg/XKg96ibhnWSzP/pLq8XP5QUdx44FQvDbyD
         P2gJH6FVS4JcUneIXgxReNZPWZluNnu+g4Xb+dEf9w4x2imkXhxTvnAwfczTcxt21dpm
         W9L0FGMNrmLFru5eFgHPFPsw/sijliVYglXSo7qDnJq6cG4SpAwMziWYq5BtEn52r2nW
         Ejl5CJ2IwNq5gmDfeDio2qSrXkpRHFkAiu/QyOWwFVQQSFrJT32Foc3BZQjv5dh0QofN
         sZ8w==
X-Gm-Message-State: AOJu0Yy7uawJYwoAhQSxKjjuVSI06AR04h3y8r/qajwwb2AxxY7R6Vjc
	1Gx+zNLSKCOuZ7+Be4mkp1hWjK56RtDngqmz5jpfhVxEDny5dDp3fk6K1pYYXQqJVPPY6HHv13r
	V6Tct
X-Gm-Gg: ASbGncvx0exO8VKh37F31y7NtbtlD1CznyXbGeF/QhLG3AIoqqdlVgmPDOytM/4V3Ti
	jV5lTDwV8Eb6BIvhZhw5Mw9w4/6MQjTqfwrXnUiOx+QKz4IFJhp/jF2ErHtbFFNdOEN7bv+1DWC
	ShfsA12kax46Dvw2HCCsr1PofyjT3qHagcf8evxNMiNrNyyS74ABhtLVomvtsWVe6PkRgUxkyfG
	qBRu0VThTYctvQOy+APdcF4nVmU2nZFBkfIyBs/ez4vvIx90PAI80NBYvCLrLeCbyqM25w0RUp4
	xP0NiYaUq3ey0T00sgUwokAF4I/aaMk1Pbj+vgpcheXp1seEYx2ESnMkEmtX0HDMopl9yNQXsHE
	r6jklWcGQjfL1DuborcE7DuD50xMf0/elm4gzgOO3VkICA0xerNhJTB+zHrTvoOf7oEWd/7uDm3
	mFw09qS7pw71VDGllSDLfy0YbrDgO/cz+ooFIfoZg=
X-Google-Smtp-Source: AGHT+IECZtRV6zKvPACNVgQTNZPSgg5wDhUunvVVvRaILaT6OO61aMyxnhIzLPVKE3Fkk64Ev9UTDg==
X-Received: by 2002:a5d:5f94:0:b0:425:856f:70ff with SMTP id ffacd0b85a97d-42704d99cf6mr20426076f8f.45.1761252287770;
        Thu, 23 Oct 2025 13:44:47 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dfc12a8sm32638645ad.57.2025.10.23.13.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 13:44:47 -0700 (PDT)
Message-ID: <6f36e8d0-630b-4cc3-a780-11be4aa0a65f@suse.com>
Date: Fri, 24 Oct 2025 07:14:42 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: make sure no dirty metadata write is submitted
 after btrfs_stop_all_workers()
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
References: <2059d92d64eb181f1d37538d1279ed5b191ce1ab.1761211916.git.wqu@suse.com>
 <CAL3q7H7KmObsE2JURpKLVRT_ufa_2v4M2KAFahUndq5Jqxwnow@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7KmObsE2JURpKLVRT_ufa_2v4M2KAFahUndq5Jqxwnow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/24 01:56, Filipe Manana 写道:
> On Thu, Oct 23, 2025 at 10:33 AM Qu Wenruo <wqu@suse.com> wrote:
[...]
> So two suggestions:
> 
> 1) Move this into btrfs_error_commit_super(), to have all code related
> to fs in error state in one single place.
> 
> 2) Instead of of calling filemap_write_and_wait(), make this simpler
> by doing the iput() of the btree inode right before calling
> btrfs_stop_all_workers() and removing the call to
> invalidate_inode_pages2() which is irrelevant since the final iput()
> removes everything from the page cache except dirty pages (but the
> iput() already triggered writeback of them).
> 
> In fact for this scenario the call to invalidate_inode_pages2() must
> be returning -EBUSY due to the dirty pages, but we have always ignored
> its return value.
> 
>  From a quick glance, it seems to me that suggestion 2 should work.

Yes, that's the original workaround I went with, the problem is we're 
still submitting metadata writes after a trans abort.

I don't feel that comfort writing back metadata in that situation.
Maybe the trans abort is triggered because a corrupted extent/free space 
tree which allows us to allocate new tree blocks where we shouldn't 
(aka, metadata COW is already broken).

Thus I consider delaying btrfs_stop_all_workers() until iput() is only a 
workaround, it still allows us to submit unnecessary writes.

I'd prefer the solution 1) in this case, still with the extra handling 
in write_one_eb().

Thanks for the review and suggestion, will follow the advice of the 
remaining part.

Thanks,
Qu


