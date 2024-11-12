Return-Path: <linux-btrfs+bounces-9500-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BD69C4F6A
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 08:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB57283014
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 07:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C377620B1EA;
	Tue, 12 Nov 2024 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PDfaGPbH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0735E20A5E6
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731396374; cv=none; b=qQqXlCY7S+i1Jj54yG+FrOPBlZBMJ5M/RqsfSnumML64EoQ9J9trHs5MKXx2RjcHxLrh8otG51gpGhzYojffKx7ME65rdG30L/3SmkuJ0g1gbOcxD/8qf3hod61HKZRQZfbMGeRxLdpBZTH2IptYHfQMP9w8THJ3WVlv+pippXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731396374; c=relaxed/simple;
	bh=kl5AkelSEMCLQLGOFC1unm7fXiqJUq39W4/hS6jhPfU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=c6SpKchaCF43hHg2ePY3LuwCY8SSLCLqlbltLHwM8hH4e5xqKyLVHMw3obTIdCyT9IR1pBxeKVNYTMYiKxfVk7vJ66uUDt+9nLu0j7wlrUDBjDPNASBQCqCH+DBOPmnazeSaUh0FXcWqfd7TQHOChYIouNmCyUeQA+g3rhgYP1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PDfaGPbH; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53c779ef19cso6311770e87.3
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 23:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731396370; x=1732001170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HJVEVcNg2VkKPJQ/t+786XfT9BwwygD6TB7bkJuh+BY=;
        b=PDfaGPbHFY/FrCz3/MBPQgd85RtqDN2Zl7rAi6z0NkMlQ/+R0ZPF8VkMAv8pWiO/u/
         wfQN39WMqJJaHgDK6ghzgHp++OnexJv0RStBTd9pu47A5E48bpV8RcOvJM35676bKesZ
         FRwE9ot41Hb+TkGAy7ge8JMdsqGYalw3k919mYy0oIiMpO06CGtOpdY37dLkenrJ9tr0
         UBbv9FoOJXspgJWBy2bOWFtKTzb6r2H7s7e+5U1aNpNjRfK3xceJZqscMPoRVFNNi5hn
         V/6KDXohaT4BfkEzVmqEvKjm+EOZbYl5hhcgnW1xiOTX0jugoCp1rKmlA+RbPHt5LAGj
         Jy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731396370; x=1732001170;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJVEVcNg2VkKPJQ/t+786XfT9BwwygD6TB7bkJuh+BY=;
        b=dio0/AQSKtKw3iNX+Pcx+iyAVmh2rUac+bisn7FemkdooC0GqYZXIK2rKHYZrlKNyb
         JwyCZ/IDQvT/4r9H5JyXdnNmpgz8Adg4G+Icc0XA0A6suUuLRmghpg67gKbvVUMgqPef
         oA2F9UdCG+8jAgSACPrFKzNlBPFBubcJgeY9OmkDRaJJ/lS6erPLJQ5tHGRVIgq7G2cU
         mpFOgneE0RhreEHjGYUz0/Z3B7SvHCLQIEPj6J9IvFOE2p6yklQASBqSqxUGAQTcQdxL
         eUsJzCWVkAuK8lf8A+oZ1BJktnPXMlPAee44HeTCAWgShPbnj2Z419z/yF3yLgMGhBn2
         ieBQ==
X-Gm-Message-State: AOJu0YyoWsj/hzST1+u4OgqomNPf0o7jg2PVsl7FQUVJ8yHeXx1/UwCr
	cxiUTZkLcUik6dWhIzD4Ok1fo80MvdNu9TW/dt30uJmESO0EFP6ErmKkY//Eu0sSHtJDezKK+/Z
	M
X-Google-Smtp-Source: AGHT+IFvIVfEVSoUzIhgcgA6flR0u9vVkc53I0/umldYoBQWjTPh2eVlriWhViSuN02e5RBMogKoVA==
X-Received: by 2002:a05:6512:3e01:b0:539:9720:99d4 with SMTP id 2adb3069b0e04-53d86296bb0mr5636155e87.28.1731396369850;
        Mon, 11 Nov 2024 23:26:09 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dde2ecsm86612355ad.72.2024.11.11.23.26.08
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 23:26:09 -0800 (PST)
Message-ID: <69c81dfb-a3d6-4e89-ba2e-66064a62c731@suse.com>
Date: Tue, 12 Nov 2024 17:56:06 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] btrfs: btrfs_buffered_write() cleanups
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1731396107.git.wqu@suse.com>
Content-Language: en-US
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
In-Reply-To: <cover.1731396107.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/12 17:53, Qu Wenruo 写道:
> This series is to cleanup btrfs_buffered_write() so that it's more
> aligned to iomap_writer_iter(), and makes later migration a little
> easier.
> 
> All those changes are inside btrfs, and the last 2 should improve the
> readablity, and prepare for the migration (since everything is now done
> inside the loop).

Changelog:
v2:
- Change the migration target from aops->write_begin() to iomap
   Otherwise no code changes


> 
> Qu Wenruo (3):
>    btrfs: make buffered write to respect fatal signals
>    btrfs: cleanup the variables inside btrfs_buffered_write()
>    btrfs: remove the out-of-loop cleanup from btrfs_buffered_write()
> 
>   fs/btrfs/file.c | 90 ++++++++++++++++++++++++++-----------------------
>   1 file changed, 47 insertions(+), 43 deletions(-)
> 


