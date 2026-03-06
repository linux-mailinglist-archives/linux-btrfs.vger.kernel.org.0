Return-Path: <linux-btrfs+bounces-22264-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF10Eh+jqml6UwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22264-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 06 Mar 2026 10:49:19 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0159D21E36E
	for <lists+linux-btrfs@lfdr.de>; Fri, 06 Mar 2026 10:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE5D93019152
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2026 09:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C684734A3C9;
	Fri,  6 Mar 2026 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Cb3P6FId"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38052DF134
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Mar 2026 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772790517; cv=none; b=oyTs7AUFemlswUOKLpjdzEZTg9TJPDpEC7fiHex4/H0PMoUUiQAUcrKHuZqYPeDIgv4ddaAU4g1v+vBnTXr294F/AynUw/Kxc26rLB0JH1bmoJ/1dUx2nZ0qhkHiLzV0SkQ/h9D5w63+EvbpCj8oQJNydrjxt6yDftHWW0TD0uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772790517; c=relaxed/simple;
	bh=hLgE1vbadUrmtpG0IpiFGB9UqdqGXFOyNHT09CKyNXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=socztdbA2kzUw91QC4lODd1vaOg6A2n/y7vaITVe2mDtduGC6XoN4dMHPj2UiMz3AfG/YIP7JArAiMjp7tBcJ4KhSbLWf3Xd6iAoNJ/XCLbqNBbn31QgzqgTxjg3H+62JOSGD3sMBJ2mdpio8YX6G7F502/1X+iUJ1UepftOif4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Cb3P6FId; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso98297145e9.0
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Mar 2026 01:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772790514; x=1773395314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LnbCXnhVRMYJgIjMb62TyOwMasEqzN2MIUietSO74W4=;
        b=Cb3P6FIdrZ6vGTfPlPYwIo7kecOP4pkATopgCEEk+JPhYtz4X7sJHr/S0NxFhy5BPm
         JDlyU/8ZA1B5IQsC2pltnFNWpDPbTfk0dwncBECByZYCKKeUjz2jaONAeK77kVbOYEKv
         qpdsbK8udZ84lQj3Ko60Pd2kfxelkkT2+HUsU2XTLopifXX4lpsF1HwSYnBkd67O+ZkW
         Y/v27ybhjXDicFaWfMrKZ+AaEsi2y8iE9fRXGAn6q/2J5im9zuZLnEy+3LUCNbS2oTQz
         C/0GkBM0whQHOn03pKKlQU8I1Vzr1lbOKDghu3+rzM8GaD6IRe1URCnG/yIrmkYd8mwK
         Swlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772790514; x=1773395314;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnbCXnhVRMYJgIjMb62TyOwMasEqzN2MIUietSO74W4=;
        b=upfpEeVrxM5+RSamwT36gE8188HxccpKecOTTuQDIkwQkrhMOO/o8HwIHGmBpU9xVK
         ZJn4n6jw5DWZP/DuzqpJ7K54ZreOQMkG+secb0+sjqohu6Bp+X8mIlbrbtX7e0/TNbP7
         EENuWWxL406Ax3YCnqWIv/L7duqhVvKrol8gMKc0s6KaNpuAorIDKeYhp8saYAqN40EM
         bTJSnFAV+Ggs7PxScumjo6vN4+Uk69INbXJ5sWx2Y7VDSUylYnZoi8C2K+pvxVlMCIRc
         q9dSRTpyaKUGtszBSCIfH4u+OGY8rn6Qe4u4bhAxFu3qtfBmlrl/f7uQFxojgz5/m7/O
         iVyA==
X-Forwarded-Encrypted: i=1; AJvYcCW0K3JopkfZaLLL6iNXBYPVlRCSwAzd916CPRUie8uRpOv/2MU/jj8alvjR4fEnOJOTnj5edv2ZZV3Vnw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqni/iRwvdiKK4wz+SUAj+bG2r2iznxO72Y221VPqYRO43bdDz
	vNujqzwuEHQ0hX8vjEcCJo2O9Eco2mKtvtgutDDTrnFv3tl6bbfiLIwDRSWozqePoaI=
X-Gm-Gg: ATEYQzzoQHTlTaXnReHjgujTabxHfvKYZqdcQQZM8420PkFzPZ3G+nAceNI10Coe1ys
	qUBA8cc3BqcykeEHwLl8YpsxCTUzlbasiDJdVnATQrZQ9RdH5LNy6T8m9o7rfxKNS0ObQ0xwnuv
	cQ1Mv/zyAVSsK0kSM/KO7rzT+x4+pE5J7FlEg8V7VV8m72zxi8DbXX+bgAiNc4jRlmBjzRQOHyQ
	XKX5u6ybX1FPjnI06cXLpuiD5ryaY2V5WgKQE11DUma4vPuEJjfd/PueEUSDlFsjYgiZyLvb+U2
	NfAHkB7LxUJb2iwoSyRkh21cGNdKOeukWqwbzaDztO0VyBbTCZVaRmrDvODeZSDs5nxfek7WKtI
	0QMknBWHd7fDUqg9udaxfoojoKySMOOP7LeI0q5D/kkF0PX9pjpghtN+jszJcLnV8pPbS9L7ce8
	mh6V8hf4qcywk/zAwbuZVKOPIz8fzPgq+61cCac445j8bdopVYEj7mZ9rjZWTvsg==
X-Received: by 2002:a05:600c:4591:b0:477:9b4a:a82 with SMTP id 5b1f17b1804b1-4852697969fmr19875355e9.35.1772790513927;
        Fri, 06 Mar 2026 01:48:33 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359c01541a2sm1300301a91.9.2026.03.06.01.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 01:48:32 -0800 (PST)
Message-ID: <c78d4c9a-4c6a-449d-b548-890d6f5ae700@suse.com>
Date: Fri, 6 Mar 2026 20:18:28 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel BUG in close_ctree
To: =?UTF-8?B?5p2c5LmJ5oGS?= <duyiheng@tju.edu.cn>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Cc: syzkaller@googlegroups.com
References: <ACwALQAQKKJNZcvdY35lEKpy.1.1772788011237.Hmail.3019244382@tju.edu.cn>
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
In-Reply-To: <ACwALQAQKKJNZcvdY35lEKpy.1.1772788011237.Hmail.3019244382@tju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0159D21E36E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22264-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action



在 2026/3/6 19:36, 杜义恒 写道:
> Dear Linux maintainers and reviewers:
> 
> We are reporting a Linux kernel bug titled **kernel BUG in 
> close_ctree**, discovered using a modified version of Syzkaller.
> 
> Linux version: ccd1cdca5cd433c8a5dff78b69a79b31d9b77ee1
> 
> The bisection log shows the first introduced commit is 169aaaf2e0be615ffd4a12adc02db5eb86e8eee1

Totally wrong bisection result.

And do everyone a favor, Cc it to the proper mailing list, other than 
syzbot.

That commit is allowing the damn fuzzed image to be mounted, other wise 
it won't even be mounted.


[...]
> BTRFS warning (device loop1 state CS): transaction 9 (with 12288 dirty metadata bytes) is not committed
> assertion failed: !found :: 0, in fs/btrfs/disk-io.c:4188
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/disk-io.c:4188!
> Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> CPU: 1 UID: 0 PID: 35067 Comm: syz-executor Tainted: G S                  6.17.0-rc2-gcf6fc5eefc5b #3 PREEMPT(full)

Try the latest upstream first.

6.17 is not LTS, and it's already EOL, you're wasting time of everyone.

Thanks,
Qu

