Return-Path: <linux-btrfs+bounces-18647-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD76C300F6
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 09:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6CCF4282DA
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 08:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6A1311587;
	Tue,  4 Nov 2025 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FqZ+grCQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A843D1B78F3
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Nov 2025 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245801; cv=none; b=Bcrz4v+bz3xm25D+Dp7/eRU0gIvcGhqUMTTX3fAFeo94FEZC3s4ZE+UDPdYIQWm11kqtCnHiG/N0D1ZLkYRWUfuqe6K4gO3eDHjSmKKKBwdbPy98weLAN9thgFGsO1WFGV72tnMWLx5r+c5dwRmJ4eYeCou/G7b112BxLIpOdZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245801; c=relaxed/simple;
	bh=oEpqgo6w4sem31KrNmcSIDyP0O9Mji7qPKVGxGe9g+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e96f+Bn7zorAgZPk19zqT2yby8MCPcH7x+BiVwEXe3qfO5oFthBmN9EBAXLcwAQ+gwdliXH65v7GAsm6lnMjq2UWxH2wZTSy67BShhhPuAuG6Xmv1JXDg6qgIj3V+b4jEgORIlu4fYDQHzopcdwbYME9e5qi3znGtMZb8aBISdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FqZ+grCQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429c82bf86bso2702758f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Nov 2025 00:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762245797; x=1762850597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z8OQg4vvlc5BcTYkkqIh24YPQrHZD74zjRaHktvoOPw=;
        b=FqZ+grCQtdDbquUCHGroV589Y/PJh4GWAE304StP4BmP/bVlELIy4Ax5H7oTbKKRbb
         UNhD33NHMrDf4DSx8+XzrtS9W4Zk72JVCzCt0nqFwLCRDcPdl2b6ssAm6y7G7JGpIYJE
         kbEICWb8hXfJpaPhZNeGExJCsB3/eTMy654/1o/R4CgWk1xSvN9mrZlDOWlW8QK/FywP
         xQAH5lH7b+gXX1WRVCS1kZL0TJCHLd/cQcgdkbByWUK5Hh1NubSY/BTBbCl58wTpQydO
         OsJ16N4FPG4vREaDw3bzjFcXHUh53BhaD5TAiFCbFcurhB9CFUQeEj+vmC6sGrh1R60H
         0jHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762245797; x=1762850597;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8OQg4vvlc5BcTYkkqIh24YPQrHZD74zjRaHktvoOPw=;
        b=lnjjmtmqAsfKBcRUj79ZLgk018PWWmOShogOwOoYlTMsrXq4RdSrgkw7XNTEYdfNFZ
         n8iEcBWDLkzr6uErlbaaxZFt3aY6fRzkzJFsaIcuWpqWdb1TnokB4nsZDWq9MbMn7fWW
         W1JdsDIxMymPGHmOdy6sRLPQOpNKS/3PVzpcb/V+zv4fUCFbdNzOmchWIkKOJfWfUeFV
         afpOg4o5bcxSK1SncTJx31sgbelkdmJRrABjj33UMdlO65vloxbuFYOdzHgXE6HeAvvj
         kaLf4cMa47inPxmQwyh9cwyaWNEKVcNcOro0c3D1vHhlAe6OUWXVzJYG/KRtMcRTgLxt
         ye3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjjpDCac0/uIn9WpDadDuJ33MoHvQlvNxIVkRAKPEksLj/35I4zgaHKH2fEN6yie9RTZQZeOQXAkxuyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxT41L/6Z2nSyJewSV77lBdr/h7SSHTUn91LFRpZHO0IbzWorj1
	jtYo4f0K4ihS3z5JCRxgbZSp+aWmYNTOHDw5xmD1nXGPNfguBldAyzm11QZLcDJZTKM=
X-Gm-Gg: ASbGncsjEJF4uvEWb/xIpYCDfaiJTGwts06fj+rIGDUCRDdWE3r5CJguG8TV0ciPRM5
	L48XR5+xOrfcIUCvByDoE/5t8gChYrXD5Q6oXu9B500NmS/KLS6BKY4fKNG5bvc9SGw7DnfdoB3
	lfO4y0FW9IKNt6ovIB2/ZBMlqUNkdYp/dsD9W08w/RS486bvVB8suO4elXrrvDY+EZTRmpVNME8
	mDQcQQEVtbgT23C44U9G1w78q3yTFDNi/iaXTNA0S5xUZagtCrrXp6K/DzW2YmLLavUGnfkz9ES
	pk7YCNc8HZXalml45YzzFccPJTMW/ujnSWhFhTTXSJr48q5j+Q+pafMceC7kBe3r3Ia+7IUO3iO
	fPN+WMzYERIrCF2k8Yl6N3EtFj/X8mwj1MytAhF7O6Bkj9hlyxru7zYdriS76Hs3tqN1y0vo1Ib
	XnGzRz+JLvF+E5TVoSeZB93m4ByTD6
X-Google-Smtp-Source: AGHT+IHcxVMLEjsCN3tP3SOCmhMrXVcx1aq4U0rFYWNl4ESqrNLr0Wbr2a7xCOUr/03qng5mxWtUpA==
X-Received: by 2002:a5d:59c5:0:b0:429:c66c:5bc9 with SMTP id ffacd0b85a97d-429c66c6504mr8548058f8f.27.1762245796719;
        Tue, 04 Nov 2025 00:43:16 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd6823f78sm2034186b3a.63.2025.11.04.00.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 00:43:16 -0800 (PST)
Message-ID: <414a076b-174d-414a-b629-9f396bce5538@suse.com>
Date: Tue, 4 Nov 2025 19:13:04 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] fs: fully sync all fses even for an emergency
 sync
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 Askar Safin <safinaskar@gmail.com>
References: <cover.1762142636.git.wqu@suse.com>
 <7b7fd40c5fe440b633b6c0c741d96ce93eb5a89a.1762142636.git.wqu@suse.com>
 <aQiYZqX5aGn-FW56@infradead.org>
 <cbf7af56-c39a-4f42-b76d-0d1b3fecba9f@suse.com>
 <urm6i5idr36jcs7oby33mngrqaa6eu6jky3kubkr3fyhlt6lnd@wqrerkdn3vma>
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
In-Reply-To: <urm6i5idr36jcs7oby33mngrqaa6eu6jky3kubkr3fyhlt6lnd@wqrerkdn3vma>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



[...]
>>> On Mon, Nov 03, 2025 at 02:37:29PM +1030, Qu Wenruo wrote:
>>>> At this stage, btrfs is only one super block update away to be fully committed.
>>>> I believe it's the more or less the same for other fses too.
>>>
>>> Most file systems do not need a superblock update to commit data.
>>
>> That's the main difference, btrfs always needs a superblock update to switch
>> metadata due to its metadata COW nature.
>>
>> The only good news is, emergency sync is not that a hot path, we have a lot
>> of time to properly fix.
> 
> I'd say even better news is that emergency sync is used practically only
> when debugging the kernel. So we can do what we wish and will have to live
> with whatever pain we inflict onto ourselves ;).

Then what about some documents around the sysrq-s usage?

The current docs only shows "Will attempt to sync all mounted 
filesystems", thus I guess that's the reason why the original reporter 
is testing it, expecting it's a proper way to sync the fses.

> 
>>>> The problem is the next step, sync_bdevs().
>>>> Normally other fses have their super block already updated in the page
>>>> cache of the block device, but btrfs only updates the super block during
>>>> full transaction commit.
>>>>
>>>> So sync_bdevs() may work for other fses, but not for btrfs, btrfs is
>>>> still using its older super block, all pointing back to the old metadata
>>>> and data.
>>>>
>>>
>>> At least for XFS, no metadata is written through the block device
>>> mapping anyway.
>>>
>>
>> So does that mean sync_inodes_one_sb() on XFS (or even ext4?) will always
>> submit needed metadata (journal?) to disk?
> 
> No, sync_inodes_one_sb() will just prepare transaction in memory (both for
> ext4 and xfs). For ext4 sync_fs_one_sb() with wait == 0 will start writeback
> of this transaction to the disk and sync_fs_one_sb() with wait == 1 will make
> sure the transaction is fully written out (committed). For xfs
> sync_fs_one_sb() with wait == 0 does nothing, sync_fs_one_sb() with wait
> == 1 makes sure the transaction is committed.

Then my question is, why EXT4 (and XFS) is fine with the emergency sync 
with a power loss, at least according to the original reporter.

Is the journal already committed for every metadata changes?

Thanks,
Qu

> 
> 								Honza


