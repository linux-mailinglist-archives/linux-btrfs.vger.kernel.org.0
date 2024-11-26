Return-Path: <linux-btrfs+bounces-9905-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9D79D9068
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 03:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F52028ABA1
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 02:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947E0179A3;
	Tue, 26 Nov 2024 02:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="B7bUZTV8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D47E9454
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732588422; cv=none; b=uggzk95JWG8rsgllZczM2zN8JB4F5k7RneYFS+ET79eLbRW51HQolfAfcLyQPW3P6Fp59fHtmy6ox2xwxprD3jGpSfHLUom7MCAJpD5RVBdSrJtNSOWGEzjxfhDezGYfPyuthUrE7CzzcHDnN8wGI0B2rfuOK/SBn8jDXxuTclU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732588422; c=relaxed/simple;
	bh=WjzjuYMgwMVGdkms9NxXWJB+RMeqJmOwyyNW+LDiQ0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SzUJw/6SlB8c4QHdVlBJcfSlcejqcrwXxBR9OZ/wvhCEJx391BeERA/iXIilp3eKsoKWVAe1cET7/LRMrdqjnhONML784sUh0jelpyR/+EghYdGCBgeTqERb8xGeN+mw4HRLenwvZI3aqrINZ5RFoITfLnASqcQzstfZtrCeatk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=B7bUZTV8; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1732588407; x=1733193207; i=quwenruo.btrfs@gmx.com;
	bh=d5k3qtw1MI21e+zoQcMo3i26mGPfNrdo+fTZkiamrLA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=B7bUZTV8Ofm0bV3rCFinZw5d4/vDefpxAI1dG9MTB63Kx9VR+k7iwc3YCoCamtEO
	 07V3FWBl/A/OO84vAO5NTSNxIwfSX93XPLwYAWvr9sVZ1NpuER6029JxIgssJIdP+
	 pHuhPliO7V/QF+mma6n27xNPE323M9x9ktAHGBUx/W5LE8PYska3rAjI8BkRGAURW
	 m0HWh3flLu+qSMNjaa3njojIlEtKaCkbrndIAqKcF4FkfeGKkh565H6Y3T9mnFhHu
	 nj5RHN1C2F85hOoY7TJljmXjMIeJu0p7+keY1s8ps+cKLWdxNE4SVWXVqfVSt06Nw
	 MB9ah/Ar6ReI7SzLJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mnpru-1u50Em3QQU-00qf9R; Tue, 26
 Nov 2024 03:33:27 +0100
Message-ID: <74048e24-dd8e-4162-ac08-2b6e799393bd@gmx.com>
Date: Tue, 26 Nov 2024 13:03:23 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: reject out-of-band dirty folios during writeback
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <2bbe9b35968132d387379dd486da9b21d45e1889.1731399977.git.wqu@suse.com>
 <20241125161128.GC31418@twin.jikos.cz> <20241125162552.GD31418@twin.jikos.cz>
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
In-Reply-To: <20241125162552.GD31418@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UgI/AaOt7MBZlObe+4kgLopeQsnzVyoQhbyebVl9nbXx8/M1wZm
 4ojZ+Fkz9lE/lIaAvJJ9cd+s9Scxbj5VRwV1ng2k2qUPXI8erfX61Nmb13ylYxShNEywBDt
 rhWBlk8g2QnmHpJM77m7+UZen3RL6wjleW8fb+Di3MAD/FbbIFYMyzk6k3bPuqYBTDJSz9q
 /uxqK2Y6j+lHbu1R7OJPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mT0WeNpo69s=;MZCpnXSfv8vsLPjf8bzuCU9Mile
 Rmo2ywYSiVxpm5XNcC/0tVTpFhS0s7AK/z3PmDRfCnnK2AHR3UzN96pk4cwI65dzErUqUcOIT
 3n/DA36iP3vUcmiK47ju7P2Rn2qkBAdD9fHDrGT+ciJBJAEzVpsTCiiu+qZZFoGoM2+Cglggq
 ZudlZ2QBNn5w2VHVTGUXRkSZBM5Ip4mIElmLP4L0t25HCKNOBddFoRLQ0vRtn4iKLTwNkVv2M
 TtxVX/lSeQCFyBXxmgLpA9di+PgUNvjPzjGf5mDI9VtnNlsaxtIS9I0NIAG9GAA/jK0c8hsPt
 4SL0YHnjGJ6ekWrEODbeNidaDdl16swQgbw48IEpyZ8QUkAQHYPM+z2I6MADup9JNEYQVo3hM
 PM5kQDKL6DfSy0qhbEqoSU6TI3B/u8Clwf9nKgG3Je1Xe6WHDcE8nyJqwYEaktrrUlSULiqvO
 Rw0IkQC9gRNJvJ0PN8sbOXJrukwwMd2kJKLeIKUSbg6HkGwzJ5qk2P7LvAW/xtEHXkChNszOK
 BbDTmGKE4nLZ3Dh4I5BvMp62OfRmFjQqaj4Kapgn8xVIgNqHsX7aKVkV330uvP17N9iBZMTPC
 /VXa9VqC7DfK0OjjbRxcz2wwMUt4op/g3lzJtT9N/FqmSxHQdWYikg6S1uxWOiHXuPgQGYDNj
 /ilTIX6aE9sdMHP/D6QJSThJ1mBhX9n1ngidMXiotYaNFLqtm7zT5sX9osk54A6vgt+vbFer2
 s+FPp6MY/bLOol9/vqddN+JqMZf0CKw40IVzX+HgXaqXe9HrM4Zq8vRHh7FM5xY3VubcI1L7z
 I51q0iNCfIum49cspX/c3E3cEb+/67LR1gT6//YFlppC/kwbddofyqIk3SOYPVCZrNoYz2x4c
 /hgsSncNT9mHf9fh1SfWGzGHC/TMplfSJIeteSCWhHXmxeHIFNTRb8hlpwYCGst+zlZDeWnuU
 61qd6lOlR1YEaXq1wRWTeg1Q/zwlzHh8/ypipkjNfX8kFq1Rt++tgwLRBs84fqv4Vb+xvi7+n
 QEQrWILB6W4ZC6888zcksUrmVZH34Ge4cEmlw+FO//WSPM7dwDKadNvQwHLelfn8s5bmEn337
 q43ZZEld2dkAhmO1NW5UdnXDd6fc3Q



=E5=9C=A8 2024/11/26 02:55, David Sterba =E5=86=99=E9=81=93:
> On Mon, Nov 25, 2024 at 05:11:28PM +0100, David Sterba wrote:
>> On Tue, Nov 12, 2024 at 06:56:51PM +1030, Qu Wenruo wrote:
>>> An out-of-band folio means the folio is marked dirty but without
>>> notifying the filesystem.
>>>
>>> This used to be a problem related to get_user_page(), but with the
>>> introduction of pin_user_pages_locked(), we should no longer hit such
>>> case anymore.
>>>
>>> In btrfs, we have a long history of handling such out-of-band dirty
>>> folios by:
>>>
>>> - Mark extent io tree EXTENT_DELALLOC during btrfs_dirty_folio()
>>>    So that any buffered write into the page cache will have
>>>    EXTENT_DEALLOC flag set for the corresponding range in btrfs' exten=
t
>>>    io tree.
>>>
>>> - Marking the folio ordered during delalloc
>>>    This is based on EXTENT_DELALLOC flag in the extent io tree.
>>>
>>> - During folio submission for writeback check the ordered flag
>>>    If the folio has no ordered folio, it means it doesn't go through
>>>    the initial btrfs_dirty_folio(), thus it's definitely an out-of-ban=
d
>>>    one.
>>>
>>>    If we got one, we go through COW fixup, which will re-dirty the fol=
io
>>>    with proper handling in another workqueue.
>>>
>>> Such workaround is a blockage for us to migrate to iomap (it requires
>>> extra flags to trace if a folio is dirtied by the fs or not) and I'd
>>> argue it's not data checksum safe, since the folio can be modified
>>> halfway.
>>>
>>> But with the introduction of pin_user_pages_locked() during v5.8 merge
>>
>> I don't see pin_user_pages_locked() in git, only
>> pin_user_pages_unlocked() but that does not seem to be the right one.
>> 5.8 is quite old so there could have been changes and renames but still
>> the reason why we can drop the cow fixup eventually should be correct.
>
> Well, it got removed in 5.18 again, ad6c441266dcd5 ("mm/gup: remove
> unused pin_user_pages_locked()").
>

My bad, the more correct term is just pin_user_pages().

It's also mentioned inside the core-api/pin_user_pages.rst, and it looks
like the CASE 5 is exactly what caused the original out-of-band dirty
pages. (get_uiser_pages(), write, put_pages()).

Now it requires correct handling with pin_user_pages(), write,
unpin_user_pages().

Thanks,
Qu

