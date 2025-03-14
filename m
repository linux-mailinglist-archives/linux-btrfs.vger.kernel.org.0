Return-Path: <linux-btrfs+bounces-12288-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E43A61F66
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Mar 2025 22:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 128C919C3813
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Mar 2025 21:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50E92054ED;
	Fri, 14 Mar 2025 21:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FUdqXc3L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800CB1C8631
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Mar 2025 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741989052; cv=none; b=r1x/8v8oJVfdCW6fqsjFwZfjFp+vNmfKqfsKIpHcatN7bPN3TKCuiU5nrZBpFJD3mYbf5TDRGt1rPNUGbkrMDVsNvdeSR+37EeivqoAH9+qjvV6kfCtgYBB50Pz9hrXhqMZ4egYQUX15yiEf/Jg4PGY1npi5gp6Eu9ybI2twGpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741989052; c=relaxed/simple;
	bh=G67DU5mFMHZl2xnIeaaZPPU2LvW1Na2hFmwiF4joBi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1ijRKWh2EyRa1LPl4yZV3z16XTCUpaAqPKyP4SDtcKVEEGoK6DBMUeSyMu0d0QtJG4+Nbliem41z7JtFlTdwFWqpmWkkRSA72MUa4J/nlpNLOq16eUPidZLAfzzHBoHvaQDmQKTqwljbAp+cTaR/dIyXyPFTU2TGviymt7boj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=FUdqXc3L; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1741989047; x=1742593847; i=quwenruo.btrfs@gmx.com;
	bh=Wu4Yr/J7wf8ANsomc61m90ej1YUH0VbVqYihF8vVsjc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FUdqXc3LkkxQxe8Jz5vs4y4BAWMiZGe7RzxmZPhKVk1ABhMUnurqtniJdllqUzFM
	 /86VNP+bvmPp2VvaLjqj+lq2GgkWuhIhLbA5sRyeBVYlJtzR6lPoJXS9gW29709qF
	 PyM5Soe2srHqoFmoSxsvG0pXbIJP6rLMwDCyObZOEWhlRAvM+tEH2phX6YPtOIzdF
	 iqWfs4/i4GDc3TNbNxZCFniufpTq2ftgmhrebLu6OCnrHDZ1JHwYYJR6AbsbjcQqx
	 1Mi21oJrxzrXh4EJG6ehNE7HETSZpsmB3PyjKLzn9fAZv5T0I004R3A2KQzWCyXLX
	 +ekiERbuA7mOg6CO9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzQgC-1sxxXK3eHg-017jOO; Fri, 14
 Mar 2025 22:50:47 +0100
Message-ID: <78d2f543-1ffc-4454-830c-e52a6eae024c@gmx.com>
Date: Sat, 15 Mar 2025 08:20:43 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] btrfs: send: remove the again label inside
 put_file_data()
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1741839616.git.wqu@suse.com>
 <ab9bc3e04e0344667b72edff9127e3fece6c4ab6.1741839616.git.wqu@suse.com>
 <20250314165253.GR32661@twin.jikos.cz>
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
In-Reply-To: <20250314165253.GR32661@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gjKgdDdUJ+MoMRaBM4j9QUdAfwVCzVsxxowZ1rY2m7iGJSOmgNS
 BAkuOspe1gZRjqrDwIHg7VDiMhSGnvuHz8QCMoBM1m+p49CO3WeSW8PdgejxxP0PhoZv1je
 bcALhX+U+DGBxHfB8vkeZoi3DzOn9Ra3lB4BlMVGR/rq4/M5dQBmPa5bRrHPfUqYw5xi7zY
 z24+hmU2bJaELif3od6qA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:djHaikmrZXY=;ewDuUKSctC/M7m6jnjRnUjREKOt
 Jmu+gOpUaUb2ztpZ983Xq32S2rFHqaF7Ag5BbgOVnBpo01j1nAyScRB+tHi8gHpGEyANwp2o1
 ZoamupDqI7Y83VUjpr54gb0XOf2PFjbJbLRO456mXq3o9/R4PMHEsVjKZkCe2iV3HtqulHWS1
 gHQnBSIKmnShZ46fQUPtowPLkY/g2E0wuE/AJc6zmvgtNeMsahXzocN5ARXGNwKLgQxSQr/v3
 rL8B147A/453jSWsPR3m4mgSTv/U5VgxiKL7TGF0uwnC+jInTUXjrcV+ttMOHRnsEiXY+YY8A
 F+WIMZpYWwFc72UNWLGCSOhaYzwiM9nDHFE27K4YkBw4wZ7DjDDM4RJIG2ozWa0NhSMNnQaok
 9iIeO887fU6tuHo0iDdgtpRRY+UCchyNbO5oCL68tH17VobRHH3bcwqd0zf+tJ0xU5QFuB4/U
 6csAaqE7O5xxfQ2m7NJk6XPx4ZNt6Pfm4ZbDw3i0lMQkhQ5i3YskPaP+qx04B4pvb+zCivF6O
 jYk8JWj//oUsFBsIy9dQH9E0JCyhAwH//KOu3sjDt1+bX2RwiZrSGF9tLzRW1VkVOo8gWu/6q
 opH/EWlRxwOxcNdW2Vjo/3Km918N6TveE82yFYIm99fNblAsajhYYPDIra5QIuiI8CXS5yp+3
 P/nEbE1sI9IWO94YRMocaCHSoi7R1R1xEeB2WwtsFYP+C2nGUmGEfzCuagZ466ZnN/fp5ApgS
 XFKxUBTwsFXjIULoVe/gg6zHBxdzI/4QoAztpRCU2942gVkxP3avRKFLSCKjyFhEPvVvsv2JN
 bzomp/tII6QQMrvmpi7EGYxxvZ9WnTVXhT2KnAjk0N5Ho33BaOayCfhPhQSgVsPnYpAm8bgxb
 HyPoR7atRVCi0Ia1fKEVTrLg0aK6itfAOqJLdvk16sZVSicDlCebNIrGHHKES4i5nHp6U4yql
 WHQkMDIDhG4jDi1SVi1DE++3hqj9JmA50QEVzxg8LLOBwbzMkDnXEac0YUMWQqCw09tG2GGYc
 3w1kUSgDgEzI3fQn8z7X70kMEHb2oNJhEyb8C3r2+wiGW9oXG6gnP2wujn+1RKw0oyYJgMhWW
 kxzXLKlO5QsySKtEtbrz5BSdmcUVa9aiXPXuHTg5y34dzwixb4ZVqCQg48rt6nZzZZn3mT22t
 znficaPhYeZN3bU/juieGkse3UBPTAfVCZbnp9p1PxldwGMo8a2jcE6hPp2sUqu9L7Gv7H2ue
 Dop25nD0ovu+Zurs/f+kTYpjaHAx6CWbVzu7jdpzBh7YVgHoRqiuwmfYTCqdTYEUlDnIPQnvA
 gYVTSPEQWGgxe8e4LbcaDhVzV5LoRMolSXRVmVrjDcWbiBHI/Go89ltnY0y0SgSmFhLxbAHis
 g9GMSIDBGNsy0DawDWHhcM0zCB+ywyA8HYE76sIX9NhbUPZvAVLcER3n/yI8kZgnW7hvMQDIH
 x1btq3Q==



=E5=9C=A8 2025/3/15 03:22, David Sterba =E5=86=99=E9=81=93:
> On Thu, Mar 13, 2025 at 02:50:43PM +1030, Qu Wenruo wrote:
>> The again label is not really necessary and can be replaced by a simple
>> continue.
>
> This should also say why it's needed.

Do you mean why we need to continue, or why the old label was needed?

Thanks,
Qu

>
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/send.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
>> index 0c8c58c4f29b..43c29295f477 100644
>> --- a/fs/btrfs/send.c
>> +++ b/fs/btrfs/send.c
>> @@ -5280,7 +5280,6 @@ static int put_file_data(struct send_ctx *sctx, u=
64 offset, u32 len)
>>   		unsigned cur_len =3D min_t(unsigned, len,
>>   					 PAGE_SIZE - pg_offset);
>>
>> -again:
>>   		folio =3D filemap_lock_folio(mapping, index);
>>   		if (IS_ERR(folio)) {
>>   			page_cache_sync_readahead(mapping,
>> @@ -5316,7 +5315,7 @@ static int put_file_data(struct send_ctx *sctx, u=
64 offset, u32 len)
>>   			if (folio->mapping !=3D mapping) {
>>   				folio_unlock(folio);
>>   				folio_put(folio);
>> -				goto again;
>> +				continue;
>>   			}
>>   		}
>>
>> --
>> 2.48.1
>>
>


