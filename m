Return-Path: <linux-btrfs+bounces-11823-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC375A45123
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 01:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B0C189A3A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 00:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6609E23BB;
	Wed, 26 Feb 2025 00:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RTCIcVQm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AA0382
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 00:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740528253; cv=none; b=NyQBjQLi822XDV+wgXJklW6Z94KUiwANf/4QtfUQk+kspEI7VhDbXaOhEdskYha5lBsyJ7+WlN383BtEfB7AvPX6Izztv31FMMlcfa6QPLAsO17wsuWC2GbvtbbmGGahmUSy9rO4AH94TlaL8W3+cLuAA244e2krDC8owNxhpoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740528253; c=relaxed/simple;
	bh=7og2M1gEDUtHUckpdP1jd5z3sB8K6WmW6Y6pwicub6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLiRO6CWcZsoW5hPZK/5e0CG4T2lJ7HNhxGgOZ8/gXg+oQVxQ51YM+B75UXcocBnJEBjEidTO0QZ/M/SnU/vEV9KMaeJ9zDTDMtCPBzyn+/uQ+GXlM7k3D0lMbykQpqqkb1j6ddd83gBOObByQeN9Xxo9f+UFfLEkMFV+zK4Ct8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=RTCIcVQm; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1740528245; x=1741133045; i=quwenruo.btrfs@gmx.com;
	bh=XRhciFiAToDSl+SFLRS1vBmFGFvR1RE/0b1jhm0YPpk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RTCIcVQmnK9d1rS6EOxivOBu5ORPv+PU2WLiS1DUmsYm8mLpfnhsd441uMNC0OWP
	 FXZKzrEOIa7fNigpJCtLVJT9/HGyfBeTI2mGdkaKpu65ZFYTL3rn04Z+0mercc8h6
	 wXFyiA3vTtZMsSXJDBhiJyYqotRQOPn82YQrWb+bRDOyAS+ivPp0IBQ6OTV48IiLI
	 KoRqriXtmPVPdHJc9pdpji+kS/NSM/c2HHaCaaTVR9tzV2OVPW6esIz2k8qwaIdBT
	 gYnx/BfkyZ3jy95Z/TlrIOCAxvQT/wCgFqCxrxOffMHvGFycH+Ergi7GfNmrcZ+GE
	 vIufsc2oUeupMJmUgw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3lY1-1tmnn40OF1-006tge; Wed, 26
 Feb 2025 01:04:05 +0100
Message-ID: <41726b65-3b69-4aa3-a3e8-257d2bd3680b@gmx.com>
Date: Wed, 26 Feb 2025 10:34:01 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] btrfs: introduce a read path dedicated extent lock
 helper
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
 Linux Memory Management List <linux-mm@kvack.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1739328504.git.wqu@suse.com>
 <1b6921a745547f352f5b7e266ef28e864f2ce056.1739328504.git.wqu@suse.com>
 <20250225130018.GO5777@twin.jikos.cz>
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
In-Reply-To: <20250225130018.GO5777@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4QXS2jfV/V9mli/krZhcuf9UKQ3+R7exFd94Xrico5Ugk0AuiKg
 n13ek5Kna1x2I7TTunqgabeBGQFx74VqzpF0iIP6Cmx0key6ltA6xNTMioWXlWuJ6ur+xfk
 vng6K/+BRvAy/sTx7Hvhfw8S+qAPnm6p/LMHfQK6EXaVUiX/fxrxvP1bYt7Vh97LusSIb13
 bgnIqyjpBAmTo55iL2eLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OH8T+oxFBsE=;9MOPRkSd2Jpy/JeqOc5WsdZfCfl
 j5ejgoXcmzjcC0trvQIUqoi3rz5clXN+/J5orG4vISGPTyr2CBjQ4SmssF1WL6q5op8d21U4B
 /xb4P8y8bIy/1NukGgmS9dFbi/SOabOqM9KBGEuWohYq5Mm/hTRa4obFQ1dg3XOXG3k8EZS6c
 0aMTg/ExQ7Lo/Z/Kq3O9gJ/wGHuwbt88f4U3eUNa6hxUav7oIdL4L4+Yz5jK28CFX6UjQdMiI
 tTnLTn/A4VGbaFi1fBOGIhXOi8Qs1m8/E1e4WKgZbyHiJPIWDtcjOERUhmQlS1lJc9mJJ+WkD
 J+pRu877ZOj74sJX8hCR6fFJX2dXxv76ZvOJ7A3sVc4PT23ZGDRev6MNuUnVGy8hUC4OPyrFE
 nc1XK2ncnKetsMq9Iu7mrOrO3atJcTWiZqEroaYTk8YSoOpmgIJLAAhbt35hPlCrbySGuqb38
 I3tCA7cowo2+W2CsN3IAhmc4031EapSJ1yJLF5uTOMr1WcJV7AAhBFPsctw79y/34fyxZJMZp
 o6wCAaB1efuE7Opdm0rnYEMIwhYVceEjN4vsJ9BhyFM34un09pul8BDXe7vhmCJM8eNVJyn4l
 5H/I2xKHN4HNag9oqT/tSA9P13iVweqh7T+pQe/sf2OkbtWR1JHvTu+9HpfiIMCdyUIXdt4w4
 E/3mVo2TV0A64IVg2cfVgBYUTmNK9ZbAFRJZEzQS0hAD4WRSQoPIap8lImWpvG/9q2C84ULNx
 DWmTvyhjNtLUfFY5Wr+40FhfkgXBFuA+sqa5ERKqD8aPkdg7aGCJEBwkA0kwi4qXwb5S6Yb18
 fuAGJx61vZFo2GojILQC/zSlx6HGFWUWx+6pXrBqs7M31DpSuBKyjvNDto/R0z2P9n/xNSJg7
 +pndpSwY0Os2Y+KTalUVcCK9w/r/cWkPEYQGQkHN4aPwhbs/tWqp96PL4Bjl1dKgCczhlT8hT
 LJyZjSmyKg0+czRU5wHxYTbhIETCJkZ6WGLGUjuK9zzNqX3ALr6yObJ56T56S4quLQ3aVH1Up
 ovcYgF6ZsgDXHFtLpdOCDxe5ObrscujpspTR/c993DnTDGqdxUSrDFT96UEuNUKOZ9JqjmkVJ
 v8dZHZe1cJS+nXFfU+/D6i0AzALTOpvQc19gxSCmIYXO6UAW2C7cjVXCsSXMj12Dy5ye6CSIJ
 eRkFi4GTMbduDsQfApwgbVNv2Yj9cQhGOMjhEt+F3PaNCnZ5qDxfSLbBYEsmMHSAc/ezfQUPW
 dCWY+W7cWlyc/dSIML4Nmj6p5VMzcZZ9IXeOpifbQw2PtKr0c6XMRXzd4eMyyWKjHD/VKYgJT
 qQc7+jy7DPTIXqDb7BcBanvh2EJYa3YvmsOpLNnZvA0G4ri/h83kNAE7VEjrHFoChsXlh7f/2
 Z/YveMV3cuBcF3t+/s1lGrgApIzQrcRKkz+eXWZjpL0fTsIsko+Ek/Cqmu



=E5=9C=A8 2025/2/25 23:30, David Sterba =E5=86=99=E9=81=93:
> On Wed, Feb 12, 2025 at 01:22:45PM +1030, Qu Wenruo wrote:
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
[...]
>> +	folio =3D filemap_get_folio(binode->vfs_inode.i_mapping,
>> +				  cur >> PAGE_SHIFT);
>
> Should this be folio_shift?

This is the biggest trap!

The filemap_* helpers are always using page index, no matter the folio siz=
e.

The filemap can be considered as a super large array of folio pointers.
(Implenmented by xarray)

For the current folio size =3D=3D page size case, it's straight forward, i=
f
there is a pointer then there is a cached folio for that index.

For larger folios, the overall idea is not changed, just we can have a
larger folio covering multiple slots, no longer one folio one slot.

So when doing the search we should always use PAGE_SHIFT.

And that why I hope the MM guys can provide a fileoff based
filemap_get_folio_by_fileoff().

CC MM guys, will a dedicated helper reduce such confusion?
Or it's just making the currently very simple filemap_*() helpers too
complex?

Thanks,
Qu

[...]
>> +again:
>> +	lock_extent(&binode->io_tree, start, end, cached_state);
>> +	cur_pos =3D start;
>> +	while (cur_pos < end) {
>> +		ordered =3D btrfs_lookup_ordered_range(binode, cur_pos,
>> +						     end - cur_pos + 1);
>> +		/*
>> +		 * No ordered extents in the range, and we hold the
>> +		 * extent lock, no one can modify the extent maps
>> +		 * in the range, we're safe to return.
>> +		 */
>> +		if (!ordered)
>> +			break;
>> +
>> +		/* Check if we can skip waiting for the whole OE. */
>> +		if (can_skip_ordered_extent(binode, ordered, start, end)) {
>> +			cur_pos =3D min(ordered->file_offset + ordered->num_bytes,
>> +				      end + 1);
>> +			btrfs_put_ordered_extent(ordered);
>> +			continue;
>> +		}
>> +
>> +		/* Now wait for the OE to finish. */
>> +		unlock_extent(&binode->io_tree, start, end,
>> +			      cached_state);
>> +		btrfs_start_ordered_extent(ordered, start, end + 1 - start);
>> +		btrfs_put_ordered_extent(ordered);
>> +		/* We have unlocked the whole range, restart from the beginning. */
>> +		goto again;
>
> This is a bit wild, goto at the end of a while loop but I don't see a
> cleaner way without making complicated in another way.

I have fixed this in the one submitted the mail list, by introducing
another layer of while loop (in another function).

Thanks,
Qu

