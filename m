Return-Path: <linux-btrfs+bounces-11920-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C502A48CE0
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 00:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D333B5695
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 23:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09174145A05;
	Thu, 27 Feb 2025 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jahK4ybh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F6A276D23
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 23:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740699598; cv=none; b=eATJMqXqcdWTR4q9JmQbMZW05n/Y0ZMAKae/UgFzGLE5maHURJmciod4c6fJb5FoqTz3nUXKSdlZsZL7eNPvvhAFlM5SO+Qr5POfhI/LXZbFT0XqwpFsYyB1CSwmCJSbliyOEMAD4nrrasnJ+om8fWVl7CinDqumMeKzKxM8hXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740699598; c=relaxed/simple;
	bh=vhLg9bb2jLXF7Ijvfr3LDCSerfrPNZPHRgo4XFRZe68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dpih+gNXK7wA3Bp+x6IxeOtTsJdp0gTeQYybDDZ1Vv+tH+rBspOKzOmwbmSy74hmEIf2auydQaq5mS2LeVgjiv90EjWNsFrTTrFbEK0sKYpQu1cakhVkarJ7lKvXQSldleuFbb0UbuN/DP3kvim+dM4N3vLOWkYHH5kulPipCb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jahK4ybh; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1740699590; x=1741304390; i=quwenruo.btrfs@gmx.com;
	bh=vhLg9bb2jLXF7Ijvfr3LDCSerfrPNZPHRgo4XFRZe68=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jahK4ybhgV5tf3QPQBeoYKnnysVItwkbUPAOTcjw3/oh7Yr/JY4LDlyCP3593pSp
	 pk6hN54fFJOdoV8Il/GKEcnUAsvoNFJncI+QJsKlAAyGUIFFORLYHwkky4t96xo2Y
	 B1OsMRiM7QwR8dm4zDB/e0mGv4AYH5eQE2Fs7jRa6MhYMnJwzXAGJkeryAnWmNpj4
	 aLNb6qxxrDO/O80v7FqiRYdF1Nn5yJErl+cXHbHj9lzyZGvb+SE/kphr4qiJjamj9
	 a/8shTpKLEYGZFrmfnhCmKYoLFQ5UFkChgmbBOe8zlAVj7+SRdGGgj6IREIisfNKm
	 bv7qQeiy/A5X4nSzkQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgvvJ-1tMQDg3XPZ-00ff1j; Fri, 28
 Feb 2025 00:39:50 +0100
Message-ID: <3586594f-f24f-4307-abec-3b20b3437cdf@gmx.com>
Date: Fri, 28 Feb 2025 10:09:46 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] btrfs: fix inline data extent reads which zero out
 the remaining part
To: Daniel Vacek <neelx@suse.com>
Cc: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <cover.1739608189.git.wqu@suse.com>
 <4e0368b2d4ab74e1a2cef76000ea75cb3198696a.1739608189.git.wqu@suse.com>
 <CAL3q7H5yrvxK5QFeCmfU+_sMmxpFyfcL_W8CALcCPLjkbbJHLQ@mail.gmail.com>
 <64782982-20d5-41e7-81d0-6960f3b5c0ee@gmx.com>
 <CAPjX3FcqrQ-0PF1OxMzr=rNNwdz3M3vq5VQGGZFC-ndhdfSc7A@mail.gmail.com>
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
In-Reply-To: <CAPjX3FcqrQ-0PF1OxMzr=rNNwdz3M3vq5VQGGZFC-ndhdfSc7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4/0GpTNjB3Rl4PsfAF7VFbZV77vEhLh4MtlyuYekKuOQXG/HuAH
 2gUPZ9pzevSaW69FL/5s4EfSIzo4Fk5nrWr2K8duVqTwhAn9Ru7rUW9gibEL+kJ6DWDVW33
 FETnLE7AjQRXVBZZceQPM6EpJ7FKENDFS0rPxCb25VXkRA/VF7i2SgfdFM0AAAX5n0Rvzxn
 sut/O9FcOflgw8Oy268Ww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KhSED9Zx/18=;QDu8j8IUAhpxM/OVW/t7i5ATxyp
 hi6zgZXKpwiTN4tKOo0TIIhc6+7uEoYjbYoJQOD8AZYRtuSIOE/QXBrXvXqmj4ytBDMAxpFjB
 bZMC+NXrTp9DscHA2FMbh8W6+90HRUPU7EpHmSqKsrgCw39jNclJsD0n8gP1iPJcnqprBNlRZ
 VcAnKw09YDtY3KTQNyUgnqjd7zjymPXOVdjYApQ65o+TDyN3wrqegZLAOpdVWRWZnHk/JN7tp
 5x7lXLqpZyfKxHvV7Rrg9IRhURomdx18I27Dc/RcINYnUo6gfeZdLIcro9lx2tF4mLJnu8SK2
 T9TYhd9YcU5dtrFB0e7LzgSPsEnfwGdjtB72RcFOz4v7Ok58alXOgKpiCCwpX1b6Ix/GOiGxX
 bi66lSyAOnIjJ7jNUh4Tv/auZgmMbV2fW1FndXNAMNwk6B4Hu02J3ZUUw55PLJqZZxbDXY2Ph
 +nzf1IpzIeCqDsecTpYVj8Rs8pOU0GvAdcK5hHxpiHj3WSuFMHUmIvZZ4oEn+KzMu8gGXu2Vb
 xc+dLcehrplJuiPHnINvj4l4hcY+P6nOoslFJi61kModS7DunG7W8mYB60u4jdykSYOnJi7mu
 JNtxvSTUE5Z/4RopseVUxvA0/cDX6o9YkrOGR8D27ziSNqqRE9lI+U3IXJtH47gSc2DQ/2S8d
 PqcflfjprprT1QrWToBP9SGWqMGdySghUVikJSuBZNUmaHk3PrM15FqbOko1p628CmXPPop1U
 /O95pXp/DfuAXvI5JRMHlrmurUsD8Jsq2X7mOOHRN0atrhRPEgpjAeKJZEvtOCNZu9Z8mkOrW
 Zt8FzxOuaA7FKLmfpkN0/ubGz79brh7F31aRt2n1LKsvqoiiJAS2Lej9Vgo7uxdGdlXT7fraB
 Cua1kU1cHpnfvFdPlUOeE6noSeUvSe2lIuXu8u/4qnfPouEpOhoAdqwY6NtcSczDLwq3djzS9
 72A2LGi3+JCfiWqaUfUbSbqD46pUm8SpTw3ivDS/+1aFTdE4cSAUi9rJ8GJgaVI878tkP4AuX
 qZ83A1EhRbnoLB6Sf/oIolS0ppmJf1cZzwMW/FPNAbAnewCmWoqEichoUKmLu+PtvwryNyXNG
 Sg8gyK/EIyOnClVoDEg5BuCVRighhy6xtUTIKfoo3iUqfu2GQWm2K5UAMdlhbh6ByheK6TUt6
 ErbJVCHT/FqZUKjYsvOO5HHk3IWTQijzmpMCaDLETjagsgN7IzsIpV8STbYVdCTNv0kpyCV5n
 3xC9tjyPZ3RaDMOER3U4xYjdbeaB2sXSxrHiHd50m+8uPdOX7+g9OuE+QOBRSvvhUIFKxR51T
 czUH2mnHF7uuJG+KGHgrw/Uf1BidjR6GyvTqFLQ/eMxVeaY3y5y0CC8UyJlvdv9h8lEhs/JbZ
 6d+UVVMqriFakKumap6seirgUngFweRftk0dk=



=E5=9C=A8 2025/2/28 01:06, Daniel Vacek =E5=86=99=E9=81=93:
> On Fri, 21 Feb 2025 at 23:39, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
[...]
>> Any good suggestions? Especially I'm pretty sure such pattern will
>> happen again and again as we're approaching larger data folios support.
>
> Perhaps an fstest which fails having the later patch without this one
> would help?
>

BTW, for the backports I really mean stable backports, not someone
picking up those out-of-tree patches.

And for the fstests failure suggestion, it's already covered by both
generic fstests runs and a dedicated btrfs specific one.

But unfortunately it's not the first nor the last time that stable
branches picks some patches without their dependency.

So I guess what we can do is really just checking the stable patch mails
and manually reject those incorrect backports, at least for now.

Thanks,
Qu

