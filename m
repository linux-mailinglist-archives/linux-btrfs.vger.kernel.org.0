Return-Path: <linux-btrfs+bounces-21404-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB/qMeBjhWl3BAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21404-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 06 Feb 2026 04:45:36 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF60F9D45
	for <lists+linux-btrfs@lfdr.de>; Fri, 06 Feb 2026 04:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F031F300B9F0
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Feb 2026 03:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997A833342E;
	Fri,  6 Feb 2026 03:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gtuNXHze"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EF324291E
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Feb 2026 03:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770349532; cv=none; b=a4pTHQkrUPdbq3KqiiiPiGftJgAs2m4X6aIWzDzHFNozs3mzwZJBf1qIHLHhreykiziiEUbXLg1gMsKRIhVZpkzxaAZFnnUobvgM2obenfSCu9rW2BP02vKPt0tqJYU5iPCCQ+ThX4W/475jB6l+UgZQMn5o7pd5jfy411KxW8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770349532; c=relaxed/simple;
	bh=/aqZISRhlyI5R3pL5ILKE7gZIYWsBrpkgLR/qM0oITo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhE2Yay/82QKNfTeEAY0lp3ilypyMlpWg/oqPI1AjlnPonSd7t4A8m3R/5Ul+uALu6xJKWHJJZmlgpjUxCZrRkQ0lne1ZifOJwPmt+QQ7LFibq3p66B20Z5nZFNeayCJ3B0RzXc5M8mcbO7hLxu+IExdWmrKUVQJoQQgs2Zs2Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gtuNXHze; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806fbc6bf3so2728945e9.2
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Feb 2026 19:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770349530; x=1770954330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mhC6qJsAt2Hedf/XEk5n3oMb7i8b0v7Agn7I6ky97cw=;
        b=gtuNXHze73gXF0GUwt8DR79V0diiO3RiTgLZmY/y/jN92T8j4YU4Vx7DnU7gEPeN0h
         nUyOoO2u88Y+DHyq/I0+6wSsZxG0FRncrxTCRf4XT8hIf+x9hbiPvLri2+ZynA9rwBi0
         79tGXSCxwgJ3rkXggM0xxvamVywNjj2PId5xqkjRkqE9PhcZ+zoxmtu0R62N8LTppiye
         MmDw0ucHaGSjTpc4zpOlmrL5+GAdVNa3gvfZa2lupZzkfmE8xJW1o6ImASSWQD2frczF
         XUsh+jjc+ebjU1E2XHCx3UzMA/rIliFZukXIFQBAgqu4yUSsIuNTZBkHXnJXUfYH/7fC
         jndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770349530; x=1770954330;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhC6qJsAt2Hedf/XEk5n3oMb7i8b0v7Agn7I6ky97cw=;
        b=ntKVApoBlPQO2aPzeCXwWJdL2kk7TPOflHnvBm4bTP6HZNg/9ZhnXuWMC/ezI4/nMt
         XIUNrodTYoB3jlWvPwKwsvt0CbN6nPfENtzklOWH19d1Owy2SkjyCOM1M2Qu7/jrPQfc
         SkwIs9j+8aYc2uOm73zS/qYWMbiDa2kZLjWyJ/mofcts8pEa8/qv+PNpFNEaxSeD4v35
         JLkMcjJsiCd76W9pEEC5Vf6Wk/3B//qcVbWDg8p/fxO5iWeaaWcgpKlkZ/NANCga6f0V
         as3NEzcNcY410h2KgBKeYd9rbIFIJph3vsFfI5EtiSBDXTbawU8WsRg2VyIAs6ww16Mu
         7yzw==
X-Gm-Message-State: AOJu0YyLERD4Eg+xJ8RJPaGhuYIgGO3LquiEFTQgxai2nOP42AhZ+XDC
	whMDeVIEqYLt3GeY+R5L35RSjYhZ8ITdFTbNYXm6cfopp349lNcOSY8oe67USL2Zu/UuxG/qfJq
	FXLcvEPQ=
X-Gm-Gg: AZuq6aJPN2pDpmvhNsRPIrjE8mMz2+2/CUideIb2mukXeDjUmqBoUq1eagUMFM/2BB2
	KfMqwGlNaocUnPi5Pf0l/cgB+nRIFeq0ZXVZB6ZaqTqawt4IrJ17mKgU2Lvz5rvFmYI3waP2z5D
	tTTsgTNF3G1f4A/wR/t3wF+nZGSipn3hvIvkjDtuOoVXRqfkRk1bXld3jou3bK/g5edJw3i3OJN
	LMADwNDCnABZgPVLbn9qYVCH5TaimEk0K+2d4nFivsJfy+B/dPkIF1SsHVM6AGAolaRWuhIq21i
	ayUy29Vxk/bV5/VG7McqVOd+wQtydk72ezMsuS7GA/iYGbVeSjmnvjYS2HK+Zcfn+zpqnvbTdbf
	OWE/aHmA9wr1ZQhnJbsZlg2fNQT6eExjVJGJH+cU8MOhNcYyvii1Jf03rQjPYDD0fmBwOxsGkg4
	50jHlx1XFuKD/HA5hEm6VY1oW5dj41kpP+RSt1Rhk=
X-Received: by 2002:a05:600c:19c7:b0:477:639d:bca2 with SMTP id 5b1f17b1804b1-483201dc507mr19184505e9.4.1770349529854;
        Thu, 05 Feb 2026 19:45:29 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824416952e4sm777563b3a.21.2026.02.05.19.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 19:45:28 -0800 (PST)
Message-ID: <572f0ac4-90f6-4c56-aa4c-2a64e365d526@suse.com>
Date: Fri, 6 Feb 2026 14:15:24 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: We have a space info key for a block group that doesn't exist
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
References: <f3574976d7b5bc8f05e42055d85d4b61263bc5c5.camel@scientia.org>
 <c07b6fde-03a3-4c97-9f59-866c81e78b85@suse.com>
 <31615495f428dbe499ae5f5a109cc6c74c8979ca.camel@scientia.org>
 <fc2f1d31-7f2c-493f-be42-2cb8c1fd5a17@gmx.com>
 <84b22b2cc7534be60eb423973336101c9e9b9ad3.camel@scientia.org>
 <b681834e-7b0f-4606-8c52-f2b4dafba246@suse.com>
 <4e6ad7ef198de72edaf890a2257bf63864984197.camel@scientia.org>
 <cca8b4ea-97ef-433e-9db9-4eca67b89576@suse.com>
 <f1aaada378adad0da020bd679531c7f503ad6f93.camel@scientia.org>
 <914a6a60-6bb6-4255-a8cc-ea6f28e7a9cf@suse.com>
 <a75537dc77e5b6fac922a97409ca4636805147dc.camel@scientia.org>
 <fff60222-0b9f-4f09-b3a6-d415aa64b6d7@gmx.com>
 <18a87dd4f3155bb1d9c9884f39dbf53c802a10cd.camel@scientia.org>
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
In-Reply-To: <18a87dd4f3155bb1d9c9884f39dbf53c802a10cd.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21404-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 8BF60F9D45
X-Rspamd-Action: no action



在 2026/2/6 10:26, Christoph Anton Mitterer 写道:
> On Fri, 2026-02-06 at 07:18 +1030, Qu Wenruo wrote:
>> The only explanation I can come up with is some downstream patches
>> from
>> Debian. Would appreciate if you can test with an vanilla upstream
>> kernel.
> 
> Uhm... that’s at least a bit of an effort (not because of the
> compilation itself, but rather because I’m rather security conscious
> and have no trust path to the upstream kernel sources)...
> 
> 
> Before doing that, would you consider the following as enough
> "checking"?
> 
> I’ve downloaded the (Debian) source package for my kernel:
> $ apt-get source linux
> 
> Debian puts all distro-specific patches in ./debian/patches (and
> applies them to the original upstream tarball when extracting the
> source package.
> 
> Looking at these patches, only two contain btrfs at all:
> $ grep -Ril btrfs linux-6.18.8/debian/patches/
> linux-6.18.8/debian/patches/bugfix/all/fs-add-module_softdep-declarations-for-hard-coded-cr.patch
> linux-6.18.8/debian/patches/debian/btrfs-warn-about-raid5-6-being-experimental-at-mount.patch
> linux-6.18.8/debian/patches/series

So it indeed means no changes to the space cache part.
Then it's really weird now.

Or you can try this btrfs-progs branch, which provides the free space 
tree repair functionality:

https://github.com/adam900710/btrfs-progs/tree/repair_fst

However I won't really recommend that, because you have to run the full 
btrfs check --repair, which can be very time consuming for large fses.

And there is no dedicated repair tool yet.

If you have a somewhat small fs with the same problem, you can try it first.

Thanks,
Qu

> 
> I’d say none of them touches anything that could explain the above
> behaviour, but you can look up these patches yourself:
> https://salsa.debian.org/kernel-team/linux/-/blob/debian/latest/debian/patches/bugfix/all/fs-add-module_softdep-declarations-for-hard-coded-cr.patch?ref_type=heads
> https://salsa.debian.org/kernel-team/linux/-/blob/debian/latest/debian/patches/debian/btrfs-warn-about-raid5-6-being-experimental-at-mount.patch?ref_type=heads
> 
> 
> If that’s not enough, tell me and I’ll compile it myself.
> 
> 
> Cheers,
> Chris.


