Return-Path: <linux-btrfs+bounces-19988-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69212CD880B
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 10:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 202F0301CC6B
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 09:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1FE30149F;
	Tue, 23 Dec 2025 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fhWvu8SZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8529820E00B
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766480729; cv=none; b=gmIZdBW+w47AHP708Gx1Ynm5rJ38YRfx18EY1IoPwwzL8CboApyNqLBxTs0EjFi/hH4JVvHe5udx445Yrz8kMha+QIDsRyLFVRw02Qrr+Mj0Qu0/xk9HvgmTl5nn9NZ0LxZEU/JxdzHrMdkgiJLCOe4a9M8Zt+rZehHci/pCCxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766480729; c=relaxed/simple;
	bh=EfsI0nt3Y6hKNDQojcIy+tIjQQUxiMeXQeU/eqrCJTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h3ad/Fyr1Vr/bOTFsPPudxhv56T409J5d4fIzZnOhw6dGPZIMJNzX/kMp5x1g0O0TNzrlED3CR9WvXTBNZ22oLp/1Yx8MALT8eeJD4Ox1CCzraDac0ffnTxZTrMiL/eyblHMR3aAGRVl8VqwG61TuBtpxV51Zyk5FvxX4iDe/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fhWvu8SZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477a1c28778so54716585e9.3
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 01:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766480724; x=1767085524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4Vgf3RF6mGPrb4nMAYz4F4hCKBOGIwsQPHPGgAIMiV8=;
        b=fhWvu8SZbsZJ9i5W3DQuT4KahaqLbe7xdGrFYtPYLFMzARQpXP/xH/EoBO7KfLA8GG
         5OL+TAPI53zlx88cPM9sLOCle4OHa2pnHce0XlaE5j9E/0v3vvdpuV+r31YfjqNoNGHK
         vRjgkY6ws1oNJy2zpE9j1U8PnefFAgFhcDDksd0PRSw6s8BmdD9S9VYt4olTcqKEcZx0
         xOynNKGKcyR4Up2TXehx91MmaCqgpfGWNeu0B9T6iovzVyH9gR4Kv2CiWs2pHuivx367
         +BFTZEu56vuaRxb4JlV6FPQJq6O/nw6ldxs2yNiHI3yKM7fofSaSHALwyZk1AAtbQ09n
         TWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766480724; x=1767085524;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Vgf3RF6mGPrb4nMAYz4F4hCKBOGIwsQPHPGgAIMiV8=;
        b=vdOtPFMQVNVNLdr/2nk4rV3uj7X6svU2/J1LMVjcBhuYwt+WuwqktBlYbwOOeM2769
         YH9nyqhOBzL0DUcygK+HEXyTbYj4uVHhDFpTYEPBqrj20wjdajw31u1mq8KHc0gs7IZk
         C5WrCpjHL91gaD9aX44PuzJrlwZbpVy/02eSym616lFKc2iXJmZ4yN6IeECGlTPREVps
         kz86pllL/VnEegVtevU4z77bprW7VeM9g5fmTjeFGE5L8KFknuSwDwn5o1t1SDenxUyk
         Ly+HCmaofV8VU9YwC5M8IGFljTj3noE1GnjLGGrrPPv2dBSTisOwBOVoFmcGE5WtZDgh
         aRWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+zBkcxej7ZRPldBoHVH0VeEYeHQBW5TKzMh+RGCYe/uynHHLqOmhxmxerJegQS3EYXNV1RUYU3+80mA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7EfBcMIcG9id1aPro4+/xIw7QW9chydNcTOL6v59jXJpxR/Bo
	18AZbE6kD/nulqVs+Gk2hO7B41LeMGllDPy6EOIYlbj8yrnjhqc0ypZ7JzwJECZHDBHZeUi0pw9
	2Eg7F6RQ=
X-Gm-Gg: AY/fxX5QUBXcAaeRIILgD5SbcxPmOmzMN5kOcUtj2aRi9CWovg317gUiX7/63VMmImy
	4gNehakhvcuLFI+HsWjLIAXLq1weWPN6lqoqMeTp+cqEyeGYCF92WVP7+MXfkudX47wy3wP9wOi
	VLkwuSSLCcZeGz6yvObspYKy3/tiYIKhdLWhL3IestwYGfxn5tWrfKbtL8z6C6+/tjDQr6I9PUi
	bTDw0lNu+q9ZlkfQcEfavrG8LvrAVrnYWQxTosLGNxO59aNwLV6cdrTB2/eLnWmEBNPd6jtPTfi
	fMNXOsuY9ZQ5UwxHXWeTsSV/e9+n8ByEFykiOoMht6gZM1KmfSwBiNnfCGhaypmR+3awOwWeE/D
	sWvPWNZpLpC3OdGBVnP+sBSaXaOtuGxOHvHO2AG13ak+Sndjc1aV80H4l0wBxllPTnNpbR85t00
	X5YsuhjaVNjjKD+nNC5iCa/dZMpajnoxDn52cXRzE=
X-Google-Smtp-Source: AGHT+IEOrmyjLwtwEsCbh77L1JxqL32ocjNmYIkvKxXsQrijTwgUZlwB4rC79tva6iSzmbi6dsONXg==
X-Received: by 2002:a05:600c:4fc4:b0:477:5b0a:e616 with SMTP id 5b1f17b1804b1-47d1955b392mr142893025e9.5.1766480723638;
        Tue, 23 Dec 2025 01:05:23 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7c62637bsm11488115a12.30.2025.12.23.01.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 01:05:23 -0800 (PST)
Message-ID: <32d13c5d-68f7-41fc-b94b-fa1f793fb2bf@suse.com>
Date: Tue, 23 Dec 2025 19:35:19 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Issues in man pages of btrfs-progs
To: Helge Kreutzmann <debian@helgefjell.de>, linux-btrfs@vger.kernel.org
References: <aUpSM2MZ7JahHX-p@meinfjell.helgefjelltest.de>
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
In-Reply-To: <aUpSM2MZ7JahHX-p@meinfjell.helgefjelltest.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/23 18:56, Helge Kreutzmann 写道:
> Dear Btrfs maintainer,
> the manpage-l10n project[1] maintains a large number of translations of
> man pages both from a large variety of sources (including Btrfs) as
> well for a large variety of target languages.
> 
> During their work translators notice different possible issues in the
> original (english) man pages. Sometimes this is a straightforward
> typo, sometimes a hard to read sentence, sometimes this is a
> convention not held up and sometimes we simply do not understand the
> original.
> 
> We use several distributions as sources and update regularly (at
> least every 2 month). This means we are fairly recent (some
> distributions like archlinux also update frequently) but might miss
> your latest upstream version once in a while, so the error might be
> already fixed. We apologize and ask you to close the issue immediately
> if this should be the case, but given the huge volume of projects and
> the very limited number of volunteers we are not able to double check
> each and every issue.
> 
> Secondly we translators see the manpages in the neutral po format,
> i.e. converted and harmonized, but not the original source (be it man,
> groff, xml or other). So we cannot provide a true patch (where
> possible), but only an approximation which you need to convert into
> your source format.

Thanks for the report, unfortunately we're not dealing with po format 
directly, but rst (for older versions there were ascii docs too) for the 
ability to generate both html and manpage targets.

So for certain errors, the fix may not be that straightforward, but we 
will definitely try to fix them all when possible.

> 
> Finally the issues I'm reporting have accumulated over time and are
> not always discovered by me, so sometimes my description of the
> problem my be a bit limited - do not hesitate to ask so we can clarify
> them.
> 
> I'm now reporting the issues for your project. If future reports
> should use another channel, please let me know.
> 
> [1] https://manpages-l10n-team.pages.debian.net/manpages-l10n/
> 
> Man page: btrfs.8
> Issue 1:  btrfs-convert(8) → B<btrfs-convert>(8)
> Issue 2:  btrfstune(8) → B<btrfstune>(8)

Not an expert, but the original rst is ":doc:`btrfs-convert`" and 
":doc:`btrfstune`", which means to be interpreted as a doc type 
cross-reference role, and I failed to figure what's going wrong in the 
original RST docs.

> 
> "There are also standalone tools for some tasks like btrfs-convert(8) \\"
> "%E<lt>E<gt> or btrfstune(8) \\%E<lt>E<gt> that were separate historically"
> "and/or haven\\(aqt been merged to the main utility. See section STANDALONE"
> "TOOLS for more details."
> --
> Man page: btrfs.8
> Issue 1:  btrfs(5) → B<btrfs>(5)
> Issue 2:  What does the <> at the end of the string mean?

The ending <> seems to be a bug in the generated man pages only.

The html version looks working fine:

https://btrfs.readthedocs.io/en/latest/btrfs.html

So this along with the previous bold formatting problem seems to be man 
page target specific, will need to dig deeper, but unfortunately not 
familiar with RST, thus this will take some time.

[... Same problem skipped ...]

> --
> Man page: btrfs.8
> Issue:    The proper way to write the link: E<.UR https://btrfs.readthedocs.io> Text <.UE>
> 
> "B<btrfs> is part of btrfs-progs.  Please refer to the documentation at \\"
> "%E<lt>https://\\:btrfs\\:.readthedocs\\:.ioE<gt>\\&."

The original RST code is a correct hyper link:

`https://btrfs.readthedocs.io <https://btrfs.readthedocs.io>`_.

This maybe another manpage target specific problem related to RST.

> --
> Man page: btrfs.8
> Issue 1:  The programm name itself must be in bold, e.g. B<btrfs>(5)
> Issue 2:  What are the <> for?
> 
> "btrfs(5) \\%E<lt>E<gt>, btrfs-balance(8) \\%E<lt>E<gt>, btrfs-check(8) \\"
> "%E<lt>E<gt>, btrfs-convert(8) \\%E<lt>E<gt>, btrfs-device(8) \\%E<lt>E<gt>,"
> "btrfs-filesystem(8) \\%E<lt>E<gt>, btrfs-inspect-internal(8) \\%E<lt>E<gt>,"
> "btrfs-property(8) \\%E<lt>E<gt>, btrfs-qgroup(8) \\%E<lt>E<gt>, btrfs-"
> "quota(8) \\%E<lt>E<gt>, btrfs-receive(8) \\%E<lt>E<gt>, btrfs-replace(8) \\"
> "%E<lt>E<gt>, btrfs-rescue(8) \\%E<lt>E<gt>, btrfs-restore(8) \\%E<lt>E<gt>,"
> "btrfs-scrub(8) \\%E<lt>E<gt>, btrfs-send(8) \\%E<lt>E<gt>, btrfs-"
> "subvolume(8) \\%E<lt>E<gt>, btrfstune(8) \\%E<lt>E<gt>, mkfs.btrfs(8) \\"
> "%E<lt>E<gt>"
> --
> Man page: btrfs.8
> Issue:    I<\\%btrfs(5)> → B<btrfs>(5)
> 
> "For other topics (mount options, etc) please refer to the separate manual"
> "page I<\\%btrfs(5)>\\&."

Looks like the same problem related to doc role cross-ref:

:doc:`btrfs-man5`

Thanks,
Qu

