Return-Path: <linux-btrfs+bounces-21654-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bTCvFhtBjmleBQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21654-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 22:07:39 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EF713120D
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 22:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6507D309348E
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Feb 2026 21:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCB4329C66;
	Thu, 12 Feb 2026 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ws30356k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1BF63B9
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Feb 2026 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770930362; cv=none; b=JrHWHMTAmFbcxCKLeEP9WsTSqvkwkrAhWvIni7ObG88xWq1SDJwxG2EIqS9ykpRB9u36f1wUHPHoUs2Pnf5gj4wDU5qmR5Ca6BjSDEEMbEvyhBIooDY+Awo9w88d79dcWCHnJn3Wtm32Q6czpd9vpdxrZ9ICeorXTi8S0P1GiRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770930362; c=relaxed/simple;
	bh=Ya+CGTJLrEsA5sJn5yXU05k9CEnmFuK5qm9N962RkiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KiIzk7RR1XtqMS2xEoRM5SehUK/S1I07gJvMZ9OKBUScmTp+EhK7U0XxLRfyTgRc0V9VSefF1Fs7HFBv/4Hst9zsPis/NG7tnt+3VPesNwRu6f1jeePXUcEknoUZ0UeDFe0xhORMw1u6PcoldVPK9kNX+7JKpLrCnLI5q462pfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ws30356k; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so2091395e9.2
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Feb 2026 13:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770930360; x=1771535160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ADy427avKCLRuNPr+99fOoTmdbxhgZXkgFfd8ipl3Es=;
        b=Ws30356kNHYma1xCGDeouDMp1Z6vRs11jfZnkPl5vhxcNJUZXKyWrys4h3EwrhBr41
         fmQ2bndQgzD7Tk0ZsMxVCX6e5lwTGPQK0rufTtelTwRhlNdAbGKsw+x8CAn3jwz34Ayc
         U+M++N3cb12uKLcpox2lzOqd6FzW0R3If1DlzmR4s8F+KW9kvpH+4D7S4Lc0EpOWoIDQ
         ZB9C6OpRg/1qnxdgL7uOQp5CzZUJwW7mn/uVoZ3mAxOHoa1tDjK1/msrIS0MFq32u+Yr
         ajMUnBVPc0CnmFZKrmuv7sWTMNCdMxexp6ODQDduYjagnilv0qfoHG5e/TZEobgbVYne
         OBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770930360; x=1771535160;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADy427avKCLRuNPr+99fOoTmdbxhgZXkgFfd8ipl3Es=;
        b=B4sfzYyVWW8jbQI/bTyo5rBgyqHPq8n/1HSztrqfsbEpfxG3DhMqfDCPg+oht44KUr
         tIO/lcQVI9GKX2HfWlf7n5/KAHDM3kP6FFnGu/RoDJ4A1mb6Z2tatgcpOaYYRzc1EQt3
         aVyocb9/kUUgSEU9vvf746rM+b+SXO0nyNV67lFoCA2qNnTH4KABo1FgYDMvmHm8rgeh
         rlR1Cl4oCgEX9jG5EuC+iF6RvodizWttqC0f7BpB1OHh83R0BbXAqyaNQhLjeUNb67sb
         l2+qzlHyHQrExFlgBM+EjwunLvuOPm3SlfPVt150z6RsPZKFRDnpKysATfn7MI6lLZpr
         O0Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXeERLth4Vl5HnVP6YNcHbeAk+l4KRlKbQPz3fxilaL+QovzEoYtyhtrI23ICgmOj919t7YzBXH8ce/jA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyMPK5uGxTx2EJPL80L5smQt2rBwzpAXvIU5lLaaEcfZ/+ZBIZ
	BkxU23bIDKuOHXdS/IInqRqUnebSN0B82hWD77F40WzsuKRMiIPjkuUmhEU4xeCXNF8=
X-Gm-Gg: AZuq6aI+2I003ljrUUbL95zvajqJHDtPE74ebr8XH7C7fHsCD/jPUtzq5rJvRvkiNey
	DkkMXMVNF5a8Ly224CJhJN4Sq+ati5W2qhbK/OnQsxYZuGt+W2Hzsl30GKZzPf7HmFqa31L4dWb
	W39OnJ+5lTyqmHAJGAYTZ1t7mmNgwvEgdvSY2aBDq//8t9iZzxsgIDt80cLygKnXi7UKxuPPMiT
	CCK2QPR47BsY7YggWsQx7F64h69+fPGG8ytZR1UjbZ9OJqakKkY0DtSUjPZtmhXlmPj7eHNeiLa
	9lrlIrI8GTk6XP2kMU8n3CR9+rlKqLwPysCugZFfRHd6dBt9oPo9faQOYRaUQr4hNOVgl7NGmaL
	w9FCprTvfR6svS+0d4bXKnsG8sNTTfbDSuIzpWjE5c3fmzlyvcOp9CbVafXmcBcL0QexpV6eWwx
	Cpowc4gISEqIa3LV7jAwbVsKec98euY8C1XUI55Etbavu8xrirZ0Qy1n4lLpmJgQ==
X-Received: by 2002:a05:600c:1547:b0:477:6d96:b3c8 with SMTP id 5b1f17b1804b1-48371085837mr6027235e9.23.1770930359475;
        Thu, 12 Feb 2026 13:05:59 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d5e1csm5735387a12.22.2026.02.12.13.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 13:05:58 -0800 (PST)
Message-ID: <f95f0d27-5bee-4363-b0f0-75e95b2a470d@suse.com>
Date: Fri, 13 Feb 2026 07:35:45 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Orange PI 5 MAX: very unstable using kernel 6.19.0 and 6.18.10,
 6.18.9 perfectly stable
To: David Arendt <admin@prnet.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-rockchip@vger.kernel.org, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <8ebe4d76-eb07-499b-b140-1f300c1b8d7e@prnet.org>
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
In-Reply-To: <8ebe4d76-eb07-499b-b140-1f300c1b8d7e@prnet.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21654-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: C2EF713120D
X-Rspamd-Action: no action



在 2026/2/13 06:41, David Arendt 写道:
> Hello,
> 
> I am using a Kubernetes Cluster with 3 Orange PI5 MAX nodes. The data is 
> stored using a btrfs filesystem as backend. If using kernel 6.19.0 or 
> kernel 6.18.10 I have experienced many crashes during high IO load on 
> all 3 nodes. Reverting back to 6.18.9 solves the problems completely. 
> Unfortunately the crashes are spontaneous reboots without leaving a 
> trace in any logfile, so I have no stacktrace of them. After the crashes 
> I have sometimes incorrect btrfs csums for a file but these may also be 
> a result of a partial write due to the crash. On one node I had a btrfs 
> error logged without crashing, but I am not sure if this is the root 
> cause or a result of a prior crash. A scrub after reboot returned no 
> error with 6.19.0.

The offending tree dump items are:

Feb 10 13:31:07 opi02 kernel:  item 92 key (13218356101120
Feb 10 13:31:07 opi02 kernel:  item 93 key (13216208642048
Feb 10 13:31:07 opi02 kernel:  item 94 key (13218356162560

Obviously item 93 is smaller than all its previous and next item keys.

hex(13218356101120) = 0xc05a36b8000
hex(13216208642048) = 0xc05236be000
hex(13218356162560) = 0xc05a36c7000

It looks like something fliped, "0xc05a3" -> "0xc0523"

0xa -> 0x2 is exactly one bit flipped.

So either the memory hardware has something wrong and resulting a 
sticking bit (always 0), or there is something inside the kernel 
touching memory it shouldn't.

And this exactly matches the symptom, changing random bit of your 
kernel, crash always expected.


Can you run a memtest to make sure it is not hardware problems first?

Thanks,
Qu


> 
> Unfortunately I don't have more information at the moment.
> 
> Thanks in advance,
> 
> David Arendt
> 
> 


