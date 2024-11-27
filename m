Return-Path: <linux-btrfs+bounces-9944-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236CB9DAE88
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 21:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24A7280F0B
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 20:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE2E202F84;
	Wed, 27 Nov 2024 20:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DFpBdsZY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCF816132F
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2024 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732739468; cv=none; b=IzFbi99FZuMUGahKivBrCKqbvQ0PqAQJ5LDRIsViqVL4jdQLK+bSAgsPyEZGXf3FS8hnXPLFT7OLaXmBRTeTb4PZbahaZkuvhmIt62/xPXwFuu2oxtsOIVqU+vdahRKaeQuOGLmkdczM5n7I+jTTJRhIb8itm7C0TVHSqIDZbG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732739468; c=relaxed/simple;
	bh=38UsigH+j/fHUPuPn4V54gFPVPPF8EnfHErjM7gE7rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8nVajVXSBJ5lNV+lXZf/jOqTpN6a+nc6aZ5JomEmRmWhVLAu4ib8r6kBgE/ip0Ks0RPWJLYpFyR5CwVsl1RuLPpPelpaHZ+7Alvi4SU1s+1awFrHOTvTEL1LEBN2tvgYNZmaSdWXOsSSQWf3qopGFGWgtUK8yHDqx7l+MlKxVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=DFpBdsZY; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1732739462; x=1733344262; i=quwenruo.btrfs@gmx.com;
	bh=OlpoXje3zOnIy7QskJMYuyOQ6nhcp6FebDYK10s0t7I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DFpBdsZYE3hXJkgUZ6gClVQE74481xJckYEnM4UesD+oZhZ36Spvne0ZASsY5dsO
	 5UIk5rTfNI/zOtkkUfJuQ3kwKnw3ay255+XvjcR3RBpBK0+I7bScP16tdm3GvhLn1
	 bD1Z2SDwiTxiVaZtjKcF9KPk4bki8a/fJkU+QHoxH+9b9brUhsc6+LNOEYRfOFRwn
	 4NOXl8VlawgIQIsNkbPVn3EyfRuv3T8LQIKkGpu2nkJftkqVkTYBd5e+2YeHJ0kZY
	 v/K85os/i6sgFn4LpezAtcThgqrxG8j64G4OoInRoc7D2e7meNtfA9D2Rt/JyrVYM
	 vxxb+4EqRIvRwi0wfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYeMt-1tBIJS2XnX-00WV2v; Wed, 27
 Nov 2024 21:31:02 +0100
Message-ID: <09d0450d-1f4c-4d48-ab95-fc7c2b78c0ec@gmx.com>
Date: Thu, 28 Nov 2024 07:00:58 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: extra debug output for sector size < page size
 cases
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1732680197.git.wqu@suse.com>
 <20241127153039.GO31418@twin.jikos.cz>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20241127153039.GO31418@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B9Ow35L59JTYr+CxqUY5nMBKI6BaAgOaReHIiykWo53Qs6VUgvB
 nlk7TL703w5p5290IaONbrwtvtg4Ivy5wb8j/i23IMcmiN72/164jq2WMl27zWH++T9Rc/t
 0v4qPBMgg0dQj1xErnP/7BG4lkic0TMUhoOY51+gE/8+ItZi8nbhUpMfyUvdQR67V3YkmtR
 dxAoDhETiP9odB9dW/EnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/62INs4y3b0=;QN/z9WB+yCo++HakXGRBv6CcCDE
 iNRQrH3KbVpAXLxIfeojlozJqFLwpj7yJmQTO/uBQ47oG2N/QNRdL0thyZ3HL9pXHjoVu+C+e
 TCf6L/ldXqWU8a/3FWDLTvEfhfGGI/UWRGPby0H5sLDpQtKz2VEDjivuSXivakgM97ZVnSDmZ
 GcuLE6HaSYEYGtQPfUCkePJhM+st8Bo9LFPQldWLtx3BeGoBXFEiy0vx4H7G5gr3NY/MQKlBn
 BPmeoQTwGeUr9iCdsd8n4VKQ6o0aAfRfRsmiqaxNxzc4/AwclzaSQtYxZhRgcXcO0gp3ZDw+r
 kuehYrClpJvTDAg77cVdalsXJDBYUraUpehzK3sChtig8ue3odY20o9pZAEWxf9rnGdSc9bbn
 medCZhLLFk1V6np9+Wnq22fHY+1MtUSPOtgOB/rrDTsJa/gFrQJBF7mptGlvLzyQmLgScyDkm
 7tzUX0FtmnLWAcpYQKQ1LeJfQk0NNTZ99wu+cWePdcqwDfRwPJBOlvVept6inTabnTiyNJy+G
 rvuhMl3LoMGuoDIOtJrefEl/jur08Fj8ZW9sXLNWOREgLzgtZhG8XKbzqmFaBPmZLd70VXAgE
 n3kr4JfAa+pnuAeEiZYLvSEXJLuEPh1obWxooCGMR7fH2sMCMrp3GOIy8IrU4dEy+5yvdnm4g
 E7r7JHukdycpBxohyG24BILemXpUJ4aB1xtNXjmWlj4Nsxc5nDsrek+8Q1EkXaTdWisl0oQlp
 e9ot8iuFY6RrFDnrZlEBg6q9fhtA5R1ygZDYC7M3zovzOD0CgYO5fgdGF91x9MJKz5gLs0A2p
 VJuqX2ZtOpd2PMJJR8IpWSzwlzWnilSn5wH+tKIG4aEbmj4bjzIbL1mTfURe/tXO0cO+PHkCn
 awbi3hv+ocoCO3jSD9Qk+gQyjcOc7Af3sdEx15CDqwMEkPNGGmddGGcFGiBbzlgkUSkr/PycQ
 wbvnf5avc1V5gtKDVNRp9+kT3acWHsrph04RZkYJAvPqsXEtbsRioJB+uZQgn27u8jx1OFu3I
 lTD1nYQrkvI/JTRbge5wqHDCwbJEmXpzfPCoI5VMFb//ycRNATvMMHduMgWQ2tmxvTZKQm3w+
 ZzFS4JZ2BY86ofKu/nqvXfyw2Dwk4r



=E5=9C=A8 2024/11/28 02:00, David Sterba =E5=86=99=E9=81=93:
> On Wed, Nov 27, 2024 at 02:36:35PM +1030, Qu Wenruo wrote:
>> The first patch is the long existing bug that full subpage bitmap dump
>> is not working for checked bitmap.
>> Thankfully even myself is not affected by the bug.
>>
>> The second one is for a crash I hit where ASSERT() got triggered in
>> btrfs_folio_set_locked() after a btrfs_run_delalloc_range() failure.
>>
>> The last one is for the btrfs_run_delalloc_range() failure, which is
>> not that rare in my environment, I guess the unsafe cache mode for my
>> aarch64 VM makes it too easy to hit ENOSPC.
>>
>> But ENOSPC from btrfs_run_delalloc_range() itself is already a problem
>> for our data/metadata space reservation code, thus it should be
>> outputted even for non-debug build.
>>
>> Qu Wenruo (3):
>>    btrfs: subpage: fix the bitmap dump for the locked flags
>>    btrfs: subpage: dump the involved bitmap when ASSERT() failed
>>    btrfs: add extra error messages for extent_writepage() failure
>
> Reviewed-by: David Sterba <dsterba@suse.com>

Thanks for the review.

Although I'd prefer this series to be merged after the double accounting
fix (which also affects non-subpage cases)

The problem is in the 3rd patch, which is touching the code just after
btrfs_run_delalloc_range() returned.

That area is also where the double accounting fix is touching.

To make backport a little easier, I'd prefer make the fix first, then
the extra debug patches.

Thanks,
Qu

