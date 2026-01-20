Return-Path: <linux-btrfs+bounces-20782-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eACXCWH3b2m+UQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20782-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 22:45:05 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CE84C741
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 22:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7F9FAE255D
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 20:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833F33B9601;
	Tue, 20 Jan 2026 20:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WNacecVo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C76E33F8D9
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941687; cv=none; b=pZZgFrJHhMyj3puh+4W5aJ3MBjbHa2587fkatsUVEjjUkf5UOAmUMoi6TPH4vuOimcjfV4fCHukQSeRTjs64hUBmH2+bCx3QY5M2LAkKZZYr97ZOZio9npeZe/AbG21DpTzDynAYUlycTI9OE0pwHbJataQfRk3QPznJPfk5iVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941687; c=relaxed/simple;
	bh=n10RyeV++C0mtORvNytJYwQXEhAYHvMoaS2DXcl0MUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8FEVWdgZ3xfPzwdfL7QQes6IaSbBEArwSos9UmpnzJrHMCiu/73s2+OKPoTEZG3wPe+vBcHON0o/5UYLsiroJJu6mT7aIOh9XFTMo/kq+J5iAleKqAPlKQrFwz57QEbz5O8+3fVmxBjmS0n9HavxlMCXJ8g6zND/YKwZx1JwT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WNacecVo; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4801c731d0aso35107295e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 12:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768941683; x=1769546483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=97J+J+Ded9/ugj5JxI6/IvoXzZvXaJySNpRhM+gV3VM=;
        b=WNacecVoeIhMIaLbSZXPpeB7hfooO5NdupwhPRLgaRRFdFj9DwgMCLjzV++eelF9Id
         f1sFRJa6mRJTPuLFFGNruvCLizcYDo8ddswrVbOTJi85epgQIPHG16fPZG+NrcAGPtFd
         lKQl77/E1gsP0Crmen2ipg3b2ttdcw81SVEepbt2MEbBzpiBaKp1tk2WYFoar0bc5LRC
         KWJE9Vtyp3pkwYOTsB7Du1KFJ0MLk6MpXbFmL0411EipBU75suZnU3jVJdkCGyIJu8EW
         cXOF47P3464ZC6Rd02PmJmGnTGU9J1gtR3Fi3A5yRP7oayBq78PUXR96ME6Og7lmdBuu
         Ibxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768941683; x=1769546483;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97J+J+Ded9/ugj5JxI6/IvoXzZvXaJySNpRhM+gV3VM=;
        b=NJ/mloBiIULL3QMYi1Ky7Qh86ohaG6sQY0K3HCeG+Yxat5mpsJkcSSGhXTUKfOjvjq
         ijGWVOJbAKsn9GRlgNMLmxmyyn0YR0SPnBYzKtIeJJ9488eabhnm+SSIH5iAeP+uCaQn
         gYygseHR3LO/r52nFLE5ESxfUs73B7H8dYABRo+UmgYWwWO5MG0ktND4/TAMbehdnDOi
         HiopznWXC1lnTNG/MVDCMDof7+aTEgG/Q0RJTscznxUFr665XdyLuBMdddAsXMYe6mqN
         4l++joUhuMU3TDyJIkdGSMr4GQFY7Yc4ObaN91vNt7urlCBKwJgSR8SXTiAo6szYztgq
         jQRw==
X-Gm-Message-State: AOJu0YxRLW9zUZfekA1UMHiiljXTNR9OiiV+l/42NC/Je5vtrkvxfdNh
	8HV4aU/igUTmlASeMJxFbiB1ZSp84QUj7n2vtW+gecUs0f5GJQVTcA//PAFrrO8klAhDU6Cei24
	SXGjk
X-Gm-Gg: AY/fxX6YkLrO0RX9C9AwbQxj/76+C6UjlQWrOVeltVtpR6auOP0qTcwgx2BTEvW5A/h
	E1hHuLfEatdGSHS7wS0MXRE3qZVPFkTM7g9HOAMS9S+RNDRWj7/tSebLcKaci5Q8lkF1asoPi9c
	udarA9ovr9S60R9ZL4LV9BJ+M8K2g1rgtuRhoY9L0ThhbT5l1XroxhC9M+wPd9jQ2wTe3R4TqTZ
	fGo3jBw6RsJLUVYpMapiFIjeL8ZSCpmyWWUbSKftNe6L2Wh6+eR7TgxkWBxLWLeYIWolfJkoqgC
	v8hH6kixdERKg9beumZKYIzs92KCuBwQFCnBzZ0GSRBK8hZbNuyrb/n/Fm3vytGhNz8NeYl2Zdg
	cTdtcr7WKxHnNCZbwisRrUYY+5T69vT+Yl9eDBTc8XWBSHKUW/3XIvyqGyvGRbhx3gPwDld+06I
	x1IpiXheaNWT+fgZqrNOLar8YJ7RhYj3HTkcU/ySc=
X-Received: by 2002:a05:600c:5493:b0:480:3a71:92b2 with SMTP id 5b1f17b1804b1-4803a71968bmr87344715e9.26.1768941682553;
        Tue, 20 Jan 2026 12:41:22 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ab921sm129838835ad.8.2026.01.20.12.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 12:41:22 -0800 (PST)
Message-ID: <62e58040-033d-42f3-b0b7-be50f2567310@suse.com>
Date: Wed, 21 Jan 2026 07:11:18 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: get rid of compressed_bio::compressed_folios[]
 part 1
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1768866942.git.wqu@suse.com>
 <20260120172942.GH26902@twin.jikos.cz>
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
In-Reply-To: <20260120172942.GH26902@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20782-lists,linux-btrfs=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: C3CE84C741
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



在 2026/1/21 03:59, David Sterba 写道:
> On Tue, Jan 20, 2026 at 10:30:07AM +1030, Qu Wenruo wrote:
>> Currently we have compressed_bio::compressed_folios[] allowing us to do
>> random access to any compressed folio, then we queue all folios in that
>> array into a real btrfs_bio, and submit that btrfs_bio for read/write.
>>
>> However there is not really any need to do random access of that array.
>>
>> All compression/decompression is doing sequential folio access.
>>
>> The part 1 is some easy and safe conversion on decompression path.
>>
>> The part 2 will handle the compression part, but unfortunately that will
>> require some changes all compression path, thus will need some extra
>> work.
>>
>> And only after compression paths also got converted, we still need
>> that compressed_folios[] array for now.
>>
>> Qu Wenruo (3):
>>    btrfs: use folio_iter to handle lzo_decompress_bio()
>>    btrfs: use folio_iter to handle zlib_decompress_bio()
>>    btrfs: use folio_iter to handle zstd_decompress_bio()
> 
> The change makes sense, however there are some low level effects that
> are not desirable in the compression callbacks as they're deep in the IO
> path. Using the folio iterator on stack adds 40 bytes for lzo (144 -> 184),
> and for zstd it's +24 (120 -> 144). This can be fixed by moving the
> iterator to the workspace as we're not using the full slab bucket size
> for either (lzo workspace is 40, zstd is 160).

Although we're never going to be that deep into the IO path.

Since commit 4591c3ef751d ("btrfs: make sure all btrfs_bio::end_io are 
called in task context"), all btrfs_bio::end_io() callback is called 
inside a workqueue.

So end_bbio_compressed_read() is now inside a workqueue, pretty shadow 
stacks, thus the increase of the stacks should still be fine.

Thanks,
Qu

> 
> The code increases by ~2800 due to specialized cold versions of the
> decompression callbacks but other than increasing the size it's
> acceptable.


