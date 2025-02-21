Return-Path: <linux-btrfs+bounces-11707-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AF9A402C1
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 23:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990A73BF8B4
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 22:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F6D254B1E;
	Fri, 21 Feb 2025 22:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FUFfPmJA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04968253F1B
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 22:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177192; cv=none; b=C5VjtqyagTEt6XDlaZejGLNNF0d3PjGyhJSAa4BF40JsSulnkMXLqocNfggzOGeIzs3VpA8MbYkk1FnOSW9pX6udhB1NyObs+wryF59uQ6ddg91vhBndXJWSvsHRkgRj5NCCcem4W3CE0YeQKZYU9IXBqzk9LVIxJbx/iCoOuxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177192; c=relaxed/simple;
	bh=cTIE0VErG3LWS2XhVJMhDdYWAaoCFFt2fPna1caNaU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rZnjWuNxkPKPx9LL6Fbn2UOlYF4A5VO4cpcOVx0jZAMOgyxMA9Q7wyKMeveelfgUI8AQq6cKsjrsZIYl5aCpwpOaQlKL0rafEbccWPUdgFYgBjocKfZSH2jrg9zHq3e/Yq9XZeLfFdNn7R2EyC0FijAqEXTHNym2LZ/nyiuh44A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=FUFfPmJA; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1740177187; x=1740781987; i=quwenruo.btrfs@gmx.com;
	bh=GZYw9WzWHcJrHyVa6iPfswBTFk8vPGPk10UpyuAhpO0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FUFfPmJAvuWn14Xh0DWP7eJVzw7n50ADtNnWMHziDKd3y2B85Wl0KQxtx+/vCncu
	 Hi4xGl13V1I4Qu1JvoJC9lsk7c01vfAA5q+tOMG10ziSXndsOKXNa2bECSHQTT5rR
	 OqbQOi+V00z2isUWa6vNkAkU9d8DlSvIKB3sIG61AOjTxD8FlHT/+VYMV774oU8a9
	 IBX3hb/vk9KjEVHFmBlUuUc0+FZhyLQ3UUlslMnVhr4jNXjICL/utuk9sdptUey0w
	 UGFYQMA7vp7OU/zsfMrUig2Fn2rmDXM0LHrxCS6jO09lq84fkC7a6NOW10QlLBIGl
	 3b1ljSvYDn/TVPYXrA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M59GG-1tmhVe20fc-00EVJd; Fri, 21
 Feb 2025 23:33:07 +0100
Message-ID: <816969c1-6d1c-4d60-9d2d-18c506c86963@gmx.com>
Date: Sat, 22 Feb 2025 09:03:03 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] btrfs: prepare for larger folios support
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, WenRuo Qu
 <wqu@suse.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1740043233.git.wqu@suse.com>
 <c9e1a407-6562-4564-a87a-e449d36b4b97@wdc.com>
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
In-Reply-To: <c9e1a407-6562-4564-a87a-e449d36b4b97@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p0eEf997CIr574Kv915XjOgkQV0roMvquDmomsPsvch5jX0fBDV
 9mtaJjUIdPT7nXYGLCiJnn10Rt5O2NgGY6c8QFOe5f5ankw0rFvBBgGkIK7QaI6IfGWcX/c
 +d6iEa2um2lYiZBqLW5w4B+OpKnE6dP2tfXjm0PeN2nMOwdxk0tdEoj/wUbsdoJI/kGhSX+
 Pe/frIJZdsZUwmmuXu5mQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZbXlIbb7PQo=;pJXV5EA+5zI9YCtQAN9SCXD9lsP
 4Mf7YIGEzGhOnEZPER257FZ32TtvR94L1akQTTsAZfBzb62HstsnmphQuyewqrpLohiAprp1J
 Tb9ToGbPlUS+lcC9U6xZW8+gb7c621zspMeLPj5OoI07x8ehecEJ1PlbfqCWqdqCz4NhC2M1k
 KVcrnfJnysQc5hoCNGLvV4BMWFDzwTd15RctZ918uxhxDf8A3E/oXKZXnDMwjRi8Sc/oz17XM
 lQTS0RKfmhIOyr+4V5Bg/bMqaDPeCUBITprlSZa97Iz+qjsIc1BVYkiXJMCU7zauoxHFTHF2s
 wiyUXW3YzZCX0INAIiN69MoaGSyG9mL9VevM3lGVyzVioaDyjOrNHJIRfOYBmDjQ8KMPnce5+
 7TVZLNhetRqgl39+uARgN6lHcBvEtL0mC19mgOz+bpyakMlLA0bSeO/JfFd0nDW3W+nImfv0D
 czpAaOGVUipSBca8Tsi48sKiEHdjRDCq7ZGHAxdcQbEF0uMRgp5UtC8GdWBWjRlKfdKmk1a1n
 dNH+AGnGRvk1uzYkIc2cGIRjVzKp77yl1b/G+oTeFhX01n7tMlMhYMTw6cZk9sGDtMrt6GE1M
 DxHSvNlmEhY8Uosx19NoHsCvvDBxJca8Z67aPXRLg3E6c13N19ElsyDO7bSyNVtSgvugR0t4J
 OVKSyhp/bFQQDkd/mnEs+Eu2Tq0pmIGzZZBcAIBN10dGWmHjwgrAB4jyqhPXxAPUz9nfC3CeK
 kNM5nTsGno9vWiexiQzD9iPJ1tJq9/j7GFC2/6D7tEdrtbm+j8aRV8F9z4XLIygjPzvPFE0bl
 bURtZo+YZC9mAlqikU1+PLQyBGKImLR/k0W52xpc4UctQLyUdLVIzydznKMTIntqDvArA9EWf
 sByVcxO5ighD2VhV7lg03eRvAPi5VjWtNVi7HrEL6Y3fO9VkyAKL9kV+rB4SvrhiEcujT9b9I
 laSeJAIgMx6hcABrG6UC4pNCuVltZMqqEUeB0+WN951KkDM6zlzrngkhnVWtMqiFOwg0TpArw
 FaBsuPpwcKmEqEHEcv0xlfL8HriSGlV9BaEHj3FHeGLiG3oMPnLFEkd3UB/J+tm2vs7TY/UnF
 m8c3MYXYHY7W+k4SXEXr2d++zyoPKhy0AjPHpzOjMKsjW/RVmQhWm9xRIVSzFwx2qqTVv6SW9
 gPZT2lYBNdZz58yzD5Z6Jma8TDCUvOYXPha/q1Og4rT8nwKEb3JSVzXENLDF3OgKgmPW4HHgr
 aiyDx4VR2lHRhR0TXUMeowzJS6HwbuBjQkgCvr/tG95+YQnBk836fIV8EPcCpaulWD2DTsKS3
 gRWklHq839toabgjOp8IDFBdJtAhS6jbAGiMSFxAKUha1CF6OP60C4OghhWEtD20/CmClKj92
 jXLbYlEVWa+8aPIE23cxa5n6KQUR3S09b9yr20/VMJ/UqCUHmlEBBEWMNy



=E5=9C=A8 2025/2/21 21:53, Johannes Thumshirn =E5=86=99=E9=81=93:
> On 20.02.25 10:26, Qu Wenruo wrote:
>> Qu Wenruo (5):
>>     btrfs: prepare subpage.c for larger folios support
>>     btrfs: remove the PAGE_SIZE usage inside inline extent reads
>>     btrfs: prepare btrfs_launcher_folio() for larger folios support
>>     btrfs: prepare extent_io.c for future larger folio support
>>     btrfs: prepare btrfs_page_mkwrite() for larger folios
>>
>>    fs/btrfs/extent_io.c | 50 +++++++++++++++++++++++++-----------------=
--
>>    fs/btrfs/file.c      | 19 +++++++++--------
>>    fs/btrfs/inode.c     |  8 +++----
>>    fs/btrfs/subpage.c   | 36 +++++++++++++++----------------
>>    fs/btrfs/subpage.h   | 24 ++++++++-------------
>>    5 files changed, 69 insertions(+), 68 deletions(-)
>>
>
> Hi Qu,
> What am I doing wrong?
>
> Applying: btrfs: prepare subpage.c for larger folios support
> Applying: btrfs: remove the PAGE_SIZE usage inside inline extent reads

I believe it's missing some dependency.

In fact it looks like it's missing the following patch:

https://lore.kernel.org/linux-btrfs/4e0368b2d4ab74e1a2cef76000ea75cb319869=
6a.1739608189.git.wqu@suse.com/

I'm sorry but there are too many pending subpage patches, thus it's
harder and harder to properly trace them...

Thanks,
Qu
> In file included from ./include/linux/kernel.h:28,
>                    from ./include/linux/cpumask.h:11,
>                    from ./include/linux/smp.h:13,
>                    from ./include/linux/lockdep.h:14,
>                    from ./include/linux/spinlock.h:63,
>                    from ./include/linux/swait.h:7,
>                    from ./include/linux/completion.h:12,
>                    from ./include/linux/crypto.h:15,
>                    from ./include/crypto/hash.h:12,
>                    from fs/btrfs/inode.c:6:
> fs/btrfs/inode.c: In function =E2=80=98uncompress_inline=E2=80=99:
> fs/btrfs/inode.c:6807:41: error: =E2=80=98sectorsize=E2=80=99 undeclared=
 (first use in
> this function); did you mean =E2=80=98sector_t=E2=80=99?
>    6807 |         max_size =3D min_t(unsigned long, sectorsize, max_size=
);
>         |                                         ^~~~~~~~~~
> ./include/linux/minmax.h:86:23: note: in definition of macro
> =E2=80=98__cmp_once_unique=E2=80=99
>      86 |         ({ type ux =3D (x); type uy =3D (y); __cmp(op, ux, uy)=
; })
>         |                       ^
> ./include/linux/minmax.h:161:27: note: in expansion of macro =E2=80=98__=
cmp_once=E2=80=99
>     161 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
>         |                           ^~~~~~~~~~
> fs/btrfs/inode.c:6807:20: note: in expansion of macro =E2=80=98min_t=E2=
=80=99
>    6807 |         max_size =3D min_t(unsigned long, sectorsize, max_size=
);
>         |                    ^~~~~
> fs/btrfs/inode.c:6807:41: note: each undeclared identifier is reported
> only once for each function it appears in
>    6807 |         max_size =3D min_t(unsigned long, sectorsize, max_size=
);
>         |                                         ^~~~~~~~~~
> ./include/linux/minmax.h:86:23: note: in definition of macro
> =E2=80=98__cmp_once_unique=E2=80=99
>      86 |         ({ type ux =3D (x); type uy =3D (y); __cmp(op, ux, uy)=
; })
>         |                       ^
> ./include/linux/minmax.h:161:27: note: in expansion of macro =E2=80=98__=
cmp_once=E2=80=99
>     161 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
>         |                           ^~~~~~~~~~
> fs/btrfs/inode.c:6807:20: note: in expansion of macro =E2=80=98min_t=E2=
=80=99
>    6807 |         max_size =3D min_t(unsigned long, sectorsize, max_size=
);
>         |                    ^~~~~
> fs/btrfs/inode.c: In function =E2=80=98read_inline_extent=E2=80=99:
> fs/btrfs/inode.c:6841:32: error: =E2=80=98sectorsize=E2=80=99 undeclared=
 (first use in
> this function); did you mean =E2=80=98sector_t=E2=80=99?
>    6841 |         copy_size =3D min_t(u64, sectorsize,
>         |                                ^~~~~~~~~~
> ./include/linux/minmax.h:86:23: note: in definition of macro
> =E2=80=98__cmp_once_unique=E2=80=99
>      86 |         ({ type ux =3D (x); type uy =3D (y); __cmp(op, ux, uy)=
; })
>         |                       ^
> ./include/linux/minmax.h:161:27: note: in expansion of macro =E2=80=98__=
cmp_once=E2=80=99
>     161 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
>         |                           ^~~~~~~~~~
> fs/btrfs/inode.c:6841:21: note: in expansion of macro =E2=80=98min_t=E2=
=80=99
>    6841 |         copy_size =3D min_t(u64, sectorsize,
>         |                     ^~~~~
> make[4]: *** [scripts/Makefile.build:207: fs/btrfs/inode.o] Error 1
> make[3]: *** [scripts/Makefile.build:465: fs/btrfs] Error 2
> make[2]: *** [scripts/Makefile.build:465: fs] Error 2
> make[1]: *** [/home/johannes/src/linux/Makefile:1989: .] Error 2


