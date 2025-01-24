Return-Path: <linux-btrfs+bounces-11053-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D79D4A1B03B
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 07:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776423AA55F
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 06:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B926C1D90BC;
	Fri, 24 Jan 2025 06:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="LVVSsweW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBC31E495
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2025 06:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737699122; cv=none; b=f8/O19rzPP1eeT1x2H4iiqbNE5I1K1WtM8MTnzG9+4neoUyLagFtCmns1yw0y1Ko7g/oARMjdXJz6R02li5c668mqzv7xeNsm3EQ2HnICFFUd2rUzBuInEuMkORPSF+kOA56GIy8WkLkVbXiaRe2qri71ht+YKyUQYsHHZ8NJZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737699122; c=relaxed/simple;
	bh=R2yx+EJ8SXOhURz/VrCpKWYzYF6DXlVwjLqjF5F2xUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmrmKz/sAHcoewjMMkhlAqLJWN8ZfHK7QvKAiYvafya9Rndikb4NZ9+Yy7PpVO94JpgmxeXSY4CIepRhS7Zke+WS0VouvrumCnb05+x/l5HdilFf5f9prvug8aHZT5oAtANFAFZTqkRVHl5gHev8nDLEkSNeP/th6ibpJx0EhXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=LVVSsweW; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1737699112; x=1738303912; i=quwenruo.btrfs@gmx.com;
	bh=JfqobUuED/xbu2+xJQmX15uV1pXL7lbp3B7lK7RONxY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LVVSsweWLMOB0y19U66ZfowlU4MhrcW4MkHFXh7OO//zXE2wnCM3MPEW5pkG4Yff
	 3A5xuT2lIijd0pApKbmvPONBoW7Fl2mpSh4AIhQUVLsR2rKhgLwcrgTh0SMa76kOb
	 f2nqytDqKZk6hWDfoLKEFdogTEwQzXfZ08Rfl00XbSMbx9pGOSJZ/97TDiSewEzWq
	 L20X9n8wbRk9o6/8bn5qdmr37LKEAcC8rs6JVuTueFAzDtiU9B8n+GvG8RJ2jCuS/
	 ue+g212e3UCNGhSuGmDInJuyOnhvJYhViseKTDT2JGzWgWYHVVWpt2o6/KNF//XFm
	 3ZWh0Sn+dNb6yzNtoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPXdC-1tnwNp26U6-00R8xr; Fri, 24
 Jan 2025 07:11:52 +0100
Message-ID: <6206360a-545d-4842-b43d-1855f78d7da5@gmx.com>
Date: Fri, 24 Jan 2025 16:41:46 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs: Fix two misuses of folio_shift()
To: dsterba@suse.cz, Matthew Wilcox <willy@infradead.org>
Cc: Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org
References: <20250121054054.4008049-1-willy@infradead.org>
 <20250121054054.4008049-2-willy@infradead.org>
 <33fa9947-cead-4f38-a61a-39b053f37a03@suse.com>
 <20250121161011.GG5777@suse.cz> <Z4_gmbY6_sTVAeIL@casper.infradead.org>
 <20250122152450.GJ5777@twin.jikos.cz>
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
In-Reply-To: <20250122152450.GJ5777@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NeaoBslG5z+/fzEG/Egjs5r9ihHmws3/PC6rp4RxSk+EOH0+jXq
 sBOt0FuwtdGPesi65YEaYfAwc1bRgMAqXowsSGT7GtbicK0G16kdMe4PNQz3FCDezdVKMt8
 dYs5/s4XxS/orPy11sqGrVaPhC++cJRR8pWaLPgZ3wPPRhO6xWbePFz5WuyNq3+snv7cBDx
 V3NlnwNfiR/p/vKU4tPNA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uOL/cdAXvmk=;6JiH0gmE30hRXDJJkt14+8tDB8S
 WFQ/9F3V+JH5Z66tzhlH/W87cG9ICEc/T4AQEEVsDTrbOsZdkOTX5YpGhQJZD1Mc6NXfSszZ5
 3VR9qBEbqfXoWwZ8gOaF9ByuMgFpGFDDyixizt9VG/j4BnXAbOsEnTak7jylXSS4CslpZbJrY
 qvC5rn5DYS6relvuDRQMix8RgLPIJJRgq3mtAjEmfLAqGO+Dutk+JfbZ9sRrCLamxlFhnEJKn
 7Ii8cDGPcSWEVqTRLAoEoOOjHxrGRvwXEhLo77f8dYuBOMUVxPb08Wy+LnxUlVkseGprFZvJ6
 dxieI8EQgKjUUKa492FBpgCUOfSAh2vimHEf+dis/EmqyKkr2z+8JS5UaMcS8OFmao5gWdHoF
 yBD6Exv+nh7Ok6YPSuqasbnpMuvQH/5ilGry836w1hVdaPbydm1iUNXN/AvUtF+StWURSXNcq
 WhfquwyLNAzZ9ng5jIhMSg+Fg+ZEt9hEuIDziF7Xj+4oVhbIBMF/9U8efbT3mHGQgNxwrbg9D
 MUbvrMQSfPjDJw+N1a0yOGva8uNoch4aheHjVFTCf06Fx1H4uk+qpRaDArG64u/IG7Ytwtp2t
 5OIPEbUg76UKqbyzLyUjZH41L7cS4YZAseJaY+Pu0qB2k2z/GNQSG7dx2TEBQLcr7GgC5qTRg
 iWDH2Ep1YFSs80+Rt02mnwS8SxIqUY7F7+XKz8kOP9RA1h5m2K2eMToh+wu2HOAY7RrtkS0sC
 p+bcphV4/Kb8oOiJzlgBaAIl6h6I5Uk6xwLznUJ9yvq3VYkUtTXZvNERVHzOMdPU/w1n8nGsk
 evf8qMh6JhPDkrXMVxg+z7o98faQZNigq41NOAkKUED7kaJJx6k0stjlkpzAx5wEGfntQfn0f
 vYXCw9aPbvzpiC4vtI4qwv7ezgABKOihgveMR74udNwVS9kiFDhcM40TBtq9LTNMM9Sh404jK
 F2jB0YpoeqDDEEMbj0j+bqOOPBe9gPwjHIccNGZGQSXUGvR/qonGXCvPwltAfXfm4O8JdH4NW
 vBHITsQeUySwYfeGAiT0yCRa0v/W6ZZOP6pWqSnZoaPglHtj/RNBf8XbGIeIIVnppjKcviIqA
 c7p7mH9Mdh26hPV9w0u6V1WhqstNxDLp4S4RzdXbyPK6oduiQr9Q9paxsb6dLm8kLirAMbKj/
 UQPgfsj5xer8kX5/Hew5VYm7uJAgKSsTyg+q3a5uh+w==



=E5=9C=A8 2025/1/23 01:54, David Sterba =E5=86=99=E9=81=93:
> On Tue, Jan 21, 2025 at 05:59:53PM +0000, Matthew Wilcox wrote:
>>>>> +			if (folio_contains(folio, i_size >> PAGE_SHIFT) &&
>>>>
>>>> Although folio_contains() is already a pretty good improvement, can w=
e
>>>> have a bytenr/i_sized based solution for fs usages?
>>>
>>> Good point, something like folio_contains_offset() that does the corre=
ct
>>> shifts.
>>
>> I'd call it folio_contains_pos(), but I'm not sure there's a lot of
>> users.  We've got a lot of filesystems converted now, and btrfs is the
>> first one to want something like that.  I've had a look through iomap
>> and some other filesystems, and I can't see anywhere else that would us=
e
>> folio_contains_pos().
>
> Ok then, we can live with that, but please keep it in mind for future
> folio API updates. Thanks.
>
Then the whole series looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

And since the whole series is reviewed, should I merge this series into
for-next now?

Thanks,
Qu

