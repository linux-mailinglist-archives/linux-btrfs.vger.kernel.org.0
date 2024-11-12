Return-Path: <linux-btrfs+bounces-9490-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E34B9C4E55
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 06:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75652847F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 05:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C535204932;
	Tue, 12 Nov 2024 05:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JSnaAZGA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFAA17333A
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 05:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731389906; cv=none; b=CGG87rk6mrUPIDFGLhUYkp9IH1uaD3LZzpWmRsjybsm34A4YMrjeOCKpio7MNrP1LyID+LVzizl7/odXvKTjqeoC5sZrer6xhllMENovGy4GqSdLhYnErjzL1e8U4r4zetFmSPHMcS1Ee5hvagRUwPyJRrNifF02h64y3LjXdXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731389906; c=relaxed/simple;
	bh=9HV3iNNTPVgtZSAjVOSzOJwpeFE2kci9ER58Lz4J2IM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=keg/5tHT6L5JsEst39h7g8RVvDMFFKDXdRg9rdCTs/GhLhV19GhTTs+nud0YObxEPq1rVLoWZZMXdRpZdDbqY8xHBwJ0k00lCw3y8SAweAmokN4NUFlTYT/HdkElqy2NQERLCg4oUI82hb8L8SSltbNUDdhfPSRIx+nKETu/xnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JSnaAZGA; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ed7eb07a4so3444943f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 21:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731389902; x=1731994702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rb478XpnMHJ/BhK8APqEX254OPTzM9eVdZ+QtHo89ow=;
        b=JSnaAZGAID8lG0cfng4licNMMfvdEmkIFDI8vXxIkMOkPzcnG0KCCNrABzbBR0/WWX
         UmZELgaLdgxlyNvxo2bNsKyuEVN2eZw4RdaJrhrgoPFzdBmixyouyMqAbwa7f1hFipUW
         Exv1xpcm0fuIYgXWapjAU4Kn8Kw6DTeymvFDGFgDcUmp0BxJvhc6PSfA2lTjIbIwhydO
         jRbAfdUq+2nDt8MWd7JZenRgXHIQ4uBcYaXkSZJNG+TYpJpcsPxMTwhTl29RCpdF3B/q
         1jypru6VmNDRf6RiCb8odFHl2GrLjTxIGqe/uDURZT+ylOkQCCJj/zhBB31NqT54ymx5
         rGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731389902; x=1731994702;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rb478XpnMHJ/BhK8APqEX254OPTzM9eVdZ+QtHo89ow=;
        b=L3VyHrDgevhC/GUQQFro9Or0QOoMIzIAPileyQ/o7We1pdxNJDZq7byufSfd1bNvzy
         FEddypSs657AyP7mymwECz3qCtz2NIylE3q2blVF2ghfYVy44PdcAj/1sWeoo5qFzNgo
         8qB+JoelTG6GT0lgPwopqsf7iXgwHa319QL9ps+k6CJ+Tj3CnIvjnkKmGgMi76/i/NrU
         xBdqzuvTUTwGHe21EuWCa+ZHHnP1pArzDHkIBiXBIJh4hS/hWaD0thfT+w6AvXOHcDC5
         74RNLnAJsum0EzowntAVX6orCFc6ptNiSN0d4fiw4fJk4cHv6xoVY3TUizOugdbjBr22
         wQ5g==
X-Gm-Message-State: AOJu0YwPXHPqWHex/kxnE0hwrjlqSwJCmzJyDx0cHDjvhwfqWKjcoLwF
	rudTE69g7dHUeDOrYpdobi+82vA8qKjDabI76uwibVVooE5SlY4olxG9/JuEDol527JxohoFTZX
	A
X-Google-Smtp-Source: AGHT+IF/YRQAhCZHtRhn1PWwY6RQjPef5sHqLZzfvq1M9JVTTKQme5yloPTUnt+hLPZMTcwuz6GC7w==
X-Received: by 2002:a05:6000:4009:b0:382:424:94ff with SMTP id ffacd0b85a97d-38204249572mr2806456f8f.18.1731389902217;
        Mon, 11 Nov 2024 21:38:22 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a4f9796sm11669196a91.4.2024.11.11.21.38.20
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 21:38:21 -0800 (PST)
Message-ID: <4e23efa0-09d4-46ed-ae2c-82b3e8ff4aa4@suse.com>
Date: Tue, 12 Nov 2024 16:08:18 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: btrfs_buffered_write() cleanups
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1731297381.git.wqu@suse.com>
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
In-Reply-To: <cover.1731297381.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/11 14:29, Qu Wenruo 写道:
> This series is to cleanup btrfs_buffered_write() so that it's more
> aligned to generic_perform_write(), and makes later migration much
> easier.

AlThe generic_perform_write() is kinda deprecated and we should go iomap 
anyway, so there will be no such migration.

But the improvement on the readability should still be worthy, thus the 
patches are still good.

Thanks,
Qu
> 
> All those changes are inside btrfs, and the last 2 should improve the
> readablity, and prepare for the migration (since everything is now done
> inside the loop).
> 
> Qu Wenruo (3):
>    btrfs: make buffered write to respect fatal signals
>    btrfs: cleanup the variables inside btrfs_buffered_write()
>    btrfs: remove the out-of-loop cleanup from btrfs_buffered_write()
> 
>   fs/btrfs/file.c | 90 ++++++++++++++++++++++++++-----------------------
>   1 file changed, 47 insertions(+), 43 deletions(-)
> 


