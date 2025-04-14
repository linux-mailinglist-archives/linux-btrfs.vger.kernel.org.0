Return-Path: <linux-btrfs+bounces-13012-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BA9A88F30
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 00:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1713B305F
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 22:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49A51F3BBB;
	Mon, 14 Apr 2025 22:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mjNyXwM7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E21E1DB128
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744670243; cv=none; b=kPCVo/uDNMjpJGl5bW/eP6EZgKxBbS2hQZUzU1GQ3NX4mKqsmDN2LrGu15RoTNVuRrnWoFL+c2yvNdEizrboJtvcQOHiv+lvhwm43UXJ+PqwfYsVmtSF3uAmgei3x+KC2+d4c19nlyV9LWIP1aIpAaBspLojSCj4VdRi12bBITY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744670243; c=relaxed/simple;
	bh=LLV288hS27rlGUHA4et5VQ74nP52Kd63VRywyhSwRMg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=BwSJIyU8TRtaS0Ea50hRUIl1fuQ9O4niisxhwsl+X9b4qmi71QbpXDTpgfEeJEyNlA4tTiDLObSlKxB5MQ+zbnZiFe+q2w7v1VRnOJnemCMx/+FYxTpSABdPK7G3ifRc40xGSSrZYHi5ohEm3wfSDD4kW2u8cEUZbAYRTq+wjak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mjNyXwM7; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744670231; x=1745275031; i=quwenruo.btrfs@gmx.com;
	bh=xqj+h2/guYd1OKrrrMeKe3FUJdBYyVhFRJgHakliKiY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mjNyXwM7ZTzqL+Rq8owKgk34fCcyTwboT9wVNZ+2LCjOoJSECF11nP0ibQsenNK7
	 UISxC7bXf8it6r2shDZjeDqOjIAtRNxxVsXlgHPA2vFYSIstcLrBnxaJcKu8XhEUJ
	 3CmJlS9M2gZq2dspL25pdnXVwdsj21RdGe8KDaRwzFT8Rr8whEz0oyaZig+t1Rjgb
	 Cx8FxfwsnJiDYAF2CtlKQ3heukHTs7m6RGwBsTOR5cvVd9P2nbbFZe9Q9kp10xzXj
	 7erEkpdqbPJ2VcQh5yqzndUGv4HN1Ek2N2J0a7LnApghuIaAtSAK9sWWPIitwm3a3
	 0IMnXBS/hefxDjTreg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2O6Y-1u1h0L1Ypq-001iEH; Tue, 15
 Apr 2025 00:37:11 +0200
Message-ID: <27440332-2afb-4fb8-9ebe-d36c8c33a89a@gmx.com>
Date: Tue, 15 Apr 2025 08:07:08 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: adjust subpage bit start based on sectorsize
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <0914bad6138d2cfafc9cfe762bd06c1883ceb9d2.1744657692.git.josef@toxicpanda.com>
 <7e863b3c-6efc-459b-ae25-cf87734dc38f@gmx.com>
Content-Language: en-US
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
In-Reply-To: <7e863b3c-6efc-459b-ae25-cf87734dc38f@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:032vDbrCWvJhUBhMsQ4TLT7R0kgbo7ALVWfAqbnFHpuEjRLNVZj
 V1Tkrc2LgixuFVqCbDgM9Ez0nYW/aqKeMNO1hbtUju/2hPW5W6IavLt4XvfiqGBGWZxLhrL
 EE1PbucaLAYsgSQTH97KgZlsiTRwujXisZjf4121Z6o30qxEXD8pGgJyyRX362jr0/JLmXl
 0XgjcQquR+g+Wy0bIU0tw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:73Y5G+E/YaE=;YsyWbR2gJmjnYUI1WW9OWD0jivq
 EQjHal96p5gwEdbmGYbMuE9lRePQdIUcq+lUVcFmc1XMgKAPGGdjImRBInympvP9FiLt0jm15
 ljb3Ylz5E8VLIVUUJVT0pthHQZjR28oEidEK1OwvboooQyCPy4syz0nD7Rtvp5NIlctcs/nRW
 a2TJggCkoozVPPtvhPCj9F1aOvGZy36vNMKPtIfP8N3gpZjNk51cXCr04cWbBsaEdb2rsMJVS
 2R8zbN3R2TDWj5O4dtZWbjHElTLseePSpsHMdu95I/mK0jzK9mqB0pUbApR+pHmLOUgMrNAU6
 3HGkfFiNzhnXfsuqZOBaK3Ug4E1P/SNRUHrbSQcaD1sDlPWOpvniUyf7T4a/f6N8z3+aIfF8c
 u5LjTUmV3MQ4Oflch3A1GEzMKkGgrKtRVJYCxAQAtYBkHmJRpOkI/ytVFN/dZDSkAV7dSH3Hv
 AbeAA2OcrvRlaN84Prjj5vq2XZkBdlYOo6hmWhn3kIJXtyVHUBbZfbwONcDGDjK3WBiN6fUIw
 ShVh3nKR4unnz7DkSi2Uhy8hfKIfxMVMnXPC0sW9ZzpAEnP0c7SxQZh1rb5JcPZBD7ov9LbGn
 ylTh0Rb08J1oOm38Lk75Q09KanVsJNVjlso+lMD6l068OOG+pqwn3S5w013C/DymgRh53cQMl
 xfGwhHQPuoBRiDzUXGuDRY+UK8KeQYlAPA5o69T/+A1QcAC1f2nGSoBLx+EHZDBz+6pmKJptH
 oxxxX4y44tnLmO76EeKL87bf/lZHGKwsOk+WIojorRgR3feQ20pPtVA/hy50hSPu/QbNbkW1Y
 8+R7+tJFsZBq4Ov0/XR2utGD5JBCiM7AZCoAGdO5lUu10jGyzZxipHDhbTzkESjeZKve1yYmg
 gAw7Y0aL6c3xxTAKG/rZCsEF3F2RECOcf5XAugvxtcYnWdYZynwsMqvwP0ZqoTPVkGVieemxj
 au70gFhL+uQgNnUcA2kjLpNCo0LQLn/oYdYxyH3w2DOnZqAscsrhS3ObrzsX2C3WMjEuZTkqw
 XviqR2Yyte5VwQFDOn5Dr5RSklbF1nHUjU7rBQl3135IW2NL093NBbsZZYgEjkv4axOEfKNRv
 R5IbdTtT5cdpG8t8vQR2CBByf6EmkIFfVap9KLK8jHvdlWXprV8BfBKfzk8oKTMJAvNafYdai
 tXz3PlIO8j7etmXS4oP6v3EZVoTGKbhRjccZi+cbShOOQgXJL5DA26M0C5HIKnizajERCCVGm
 xQ+DAVNm3c+KiZ2Dx3DfFAchXjDxwDYvmWNj5OGT2dSKtz4Zf4qBaHDu6Y/lH5cm2mlcFyiSg
 QXHpMUvukCOVm4twkjW9U0tj6M1ip/HM4Ja7PXE9h38YGaXs4B3svOtcUCsN9BdDoc2WQxrBe
 klG23IZY0lEfM6LEwC2dzPOh9I27GWdXW/EHcAGiFFSBFnpLUcJ5QHh/fIMs+D//aC8bilebq
 Yk0GzMg==



=E5=9C=A8 2025/4/15 07:38, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2025/4/15 04:38, Josef Bacik =E5=86=99=E9=81=93:
>> When running machines with 64k page size and a 16k nodesize we started
>> seeing tree log corruption in production.=C2=A0 This turned out to be b=
ecause
>> we were not writing out dirty blocks sometimes, so this in fact affects
>> all metadata writes.
>>
>> When writing out a subpage EB we scan the subpage bitmap for a dirty
>> range.=C2=A0 If the range isn't dirty we do
>>
>> bit_start++;
>>
>> to move onto the next bit.=C2=A0 The problem is the bitmap is based on =
the
>> number of sectors that an EB has.=C2=A0 So in this case, we have a 64k
>> pagesize, 16k nodesize, but a 4k sectorsize.=C2=A0 This means our bitma=
p is 4
>> bits for every node.=C2=A0 With a 64k page size we end up with 4 nodes =
per
>> page.
>>
>> To make this easier this is how everything looks
>>
>> [0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16k=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 32k=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 48k=C2=A0=C2=
=A0=C2=A0=C2=A0 ] logical address
>> [0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 12=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ] radix tree offset
>> [=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 64k page=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ] folio
>> [ 16k eb ][ 16k eb ][ 16k eb ][ 16k eb ] extent buffers
>> [ | | | |=C2=A0 | | | |=C2=A0=C2=A0 | | | |=C2=A0=C2=A0 | | | | ] bitma=
p
>>
>> Now we use all of our addressing based on fs_info->sectorsize_bits, so
>> as you can see the above our 16k eb->start turns into radix entry 4.
>>
>> When we find a dirty range for our eb, we correctly do bit_start +=3D
>> sectors_per_node, because if we start at bit 0, the next bit for the
>> next eb is 4, to correspond to eb->start 16k.
>>
>> However if our range is clean, we will do bit_start++, which will now
>> put us offset from our radix tree entries.
>>
>> In our case, assume that the first time we check the bitmap the block i=
s
>> not dirty, we increment bit_start so now it =3D=3D 1, and then we loop
>> around and check again.=C2=A0 This time it is dirty, and we go to find =
that
>> start using the following equation
>>
>> start =3D folio_start + bit_start * fs_info->sectorsize;
>>
>> so in the case above, eb->start 0 is now dirty, and we calculate start
>> as
>>
>> 0 + 1 * fs_info->sectorsize =3D 4096
>> 4096 >> 12 =3D 1
>>
>> Now we're looking up the radix tree for 1, and we won't find an eb.
>> What's worse is now we're using bit_start =3D=3D 1, so we do bit_start =
+=3D
>> sectors_per_node, which is now 5.=C2=A0 If that eb is dirty we will run=
 into
>> the same thing, we will look at an offset that is not populated in the
>> radix tree, and now we're skipping the writeout of dirty extent buffers=
.
>>
>> The best fix for this is to not use sectorsize_bits to address nodes,
>> but that's a larger change.=C2=A0 Since this is a fs corruption problem=
 fix
>> it simply by always using sectors_per_node to increment the start bit.
>>
>> Fixes: c4aec299fa8f ("btrfs: introduce submit_eb_subpage() to submit a
>> subpage metadata page")
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>> =C2=A0 fs/btrfs/extent_io.c | 2 +-
>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 5f08615b334f..6cfd286b8bbc 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -2034,7 +2034,7 @@ static int submit_eb_subpage(struct folio
>> *folio, struct writeback_control *wbc)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subpage->bitmaps)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 spin_unlock_irqrestore(&subpage->lock, flags);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 spin_unlock(&folio->mapping->i_private_lock);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bit=
_start++;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bit=
_start +=3D sectors_per_node;
>
> The problem is, we can not ensure all extent buffers are nodesize aligne=
d.
>
> If we have an eb whose bytenr is only block aligned but not node size
> aligned, this will lead to the same problem.
>
> We need an extra check to reject tree blocks which are not node size
> aligned, which is another big change and not suitable for a quick fix.
>
>
> Can we do a gang radix tree lookup for the involved ranges that can
> cover the block, then increase bit_start to the end of the found eb
> instead?

In fact, I think it's better to fix both this and the missing eb write
bugs together in one go.

With something like this:

static int find_subpage_dirty_subpage(struct folio *folio)
{
	struct extent_buffer *gang[BTRFS_MAX_EB_SIZE/MIN_BLOCKSIZE];
	struct extent_buffer *ret =3D NULL;

	rcu_read_lock()
	ret =3D radix_tree_gang_lookup();
	for (int i =3D 0; i < ret; i++) {
		if (eb && atomic_inc_not_zero(&eb->refs)) {
			if (!test_bit(EXTENT_BUFFER_DIRTY) {
				atomic_dec(&eb->refs);
				continue;
			}
			ret =3D eb;
			break;
		}
	}
	rcu_read_unlock()
	return ret;
}

And make submit_eb_subpage() no longer relies on subpage dirty bitmap,
but above helper to grab any dirty ebs.

By this, we fix both bugs by:

- No more bitmap search
   So no increment mismatch, and can still handle unaligned one (as long
   as they don't cross page boundary).

- No more missing writeback
   As the gang lookup is always for the whole folio, and we always test
   eb dirty flags, we should always catch dirty ebs in the folio.

Thanks,
Qu

>
> Thanks,
> Qu
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 continue;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>


