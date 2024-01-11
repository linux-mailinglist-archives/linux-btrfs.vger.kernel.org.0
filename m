Return-Path: <linux-btrfs+bounces-1388-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1317D82A7F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 08:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CCF61F2402B
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jan 2024 07:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A846AC0;
	Thu, 11 Jan 2024 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Hjo1jNv9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317486AA1
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jan 2024 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1704956505; x=1705561305; i=quwenruo.btrfs@gmx.com;
	bh=f7qRwqby8tXX00vYhmin6IcV1wB76eBqla/Vmrse4Ig=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Hjo1jNv9cngycQ93N3eRGz06XHWt8ORvrcBKN4npLofagztZTmBvd9txOKRDiHjQ
	 tLoh1Q0JIdTjZyR0ZAeId7oGR2/R/2pi7kb7Tw2d+mQihWWYIyaOS1ojoW7Ur34Ue
	 0tm5Zq51026zmX+jaMmpnJusPqPqgbNxJQG/L9BywdfKBFGhyC9gKUDjGG7DjLo09
	 9yUiZDSvdrq9YBNFlKJqsMAPFF/pmeQGNMzES6gbXDARbL4N1NnlgLSuSHCPahAWK
	 q653z5lUTcEAixmpRAk84NYdAl4QP4UePIFs34eih8xFj1ifot0sZlrrq1Qnz0p+P
	 PwyKerlPbrwKeNf/kw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.153.88] ([49.178.149.31]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQeA2-1rZQR42mZi-00Nkcf; Thu, 11
 Jan 2024 08:01:45 +0100
Message-ID: <5bd47d44-17a9-4c50-98a4-d9bc32b641f2@gmx.com>
Date: Thu, 11 Jan 2024 17:31:42 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: don't unconditionally call folio_start_writeback
 in subpage
Content-Language: en-US
To: Anand Jain <anand.jain@oracle.com>, Josef Bacik <josef@toxicpanda.com>,
 linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cd8e40a516d86d1c58a221fa8d964a04bc226891.1704924693.git.josef@toxicpanda.com>
 <755c30fa-a601-4ba6-8263-601439f1bceb@oracle.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <755c30fa-a601-4ba6-8263-601439f1bceb@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8Y71N08rElxAf/5WklC6DxSujJH6qYnEedRDbiUf68HlFnZfEfz
 VysuwfPNziZt7ou7uEfugHhOaEGKBdkB7pd30k7nlUP2jjHc2ZfmXQ0Y0CBYkj6M5iirz/X
 yieYa9A3+v4CFENeZ/nrvfc/fo6jN1KCUQgcqGpCrWKWX50H7K3ITKIOMduTG91GhW31SXI
 A7Z+G6xlsyluk3rmdDJOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wzoNHwuK5JQ=;HCXJ3YaalhRphs49VMyJ04Uf3Ez
 ETkMUs7HOTUGkcsv6ovPS2msa3hD2JZ/86xy/AD9WPCn8beT66Csv806McYGT7UlGMb6er1ln
 sJQ7XyPhKejZLKAWaxe2PFHituvYhNJYiAAFTNV6putg7/vEwm8iDnp9b+DlA99GBL5BK269G
 C0Kru8N5irboxUUwgZYkxgpmwTtN3Lhyk/Iy8ugsR2uM7CmlI6fHChH21QwM/GE1i3hG9DWZv
 zHw/tevpwig8U6Lyw4w1HyeCiGyhbBQEVE18emPjAPupf1xIhXhUU2U9HS4xMxhfUiIMILR4m
 l2yhWunif+1ecM2k2jdqElKaI7TagK+oFR5hRukpTJkpTH3UqIHMTZ1rKaNU8DOVzAKWq/q4h
 Qk8HNTL0gosbmSglcWCH43VEnXSxZCte5jf3Vhwm+vWaqHbkOvmd3v0slO2sBzJJ6rW9M003H
 oC37rsq4W6d8F1zVX74EIiFLYGa8Mrx2BYFUPacS0r9x0ufMtUs5FHOV4etPlFDl4wjKhCUJ5
 cZWNE80WDAMuVQWpxY8InOCJlRg/GTZGgU9DCTEZA+WK4w/fYy2RD21L2+yRP3RrufWPtlfJt
 bHb8S1ZK0E/ANJmIC/I7TElOiE8qyoS4mFAjy4xuDo2uWQB1aiR65jsiQYPsjLC0Yp7Su+MQA
 vhu5Pttc1Kjcw1/heHJRY6FtF5z3LJQGY9QM4Zo0caLWJjGFnipk7NIq5rgTL527/AWZAawB8
 FTFlC/Wq1LEsHZQya95d3plAOlTQ+9QNxdiSD14mPzgZT9ThVA72bQQ5X3qTBh3F3wCu9boKz
 q+c2r/d8EdK8ymoCMRfDfPDb9yjm/N1ui11zZadqplHhd1sMVe5yLazNscnGq9ELtkpWcDmWc
 r/7KOE+aovXCukrXQ5Cbs2kUh5Kx/kD9BtDq7cclfRcQN27rizuZB3k+FCd6Yjs+/hcFpWLJ+
 2RPYYP/tnaJ6d3hwTwK3kEk8bk8=



On 2024/1/11 16:27, Anand Jain wrote:
> On 1/11/24 06:14, Josef Bacik wrote:
>> In the normal case we check if a page is under writeback and skip it
>> before we attempt to begin writeback.
>>
>> The exception is subpage metadata writes, where we know we don't have a=
n
>> eb under writeback and we're doing it one eb at a time.=C2=A0 Since
>> b5612c368648 ("mm: return void from folio_start_writeback() and related
>> functions") we now will BUG_ON() if we call folio_start_writeback()
>> on a folio that's already under writeback.=C2=A0 Previously
>> folio_start_writeback() would bail if writeback was already started.
>>
>
>> Fix this in the subpage code by checking if we have writeback set and
>> skipping it if we do.=C2=A0 This fixes the panic we were seeing on subp=
age.
>
> The panic stack trace in the git commit log will add more clarity.
>
> Can we fold this into the commit 55151ea9ec1b ("btrfs: migrate subpage
> code to folio interfaces")

I don't think it's a good idea to merge a bug fix to a pure refactor.

This is really some conflicts between us and mm layer.

Thanks,
Qu
>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>
> If not:
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>
> Thanks, Anand
>
>
>> ---
>> =C2=A0 fs/btrfs/subpage.c | 3 ++-
>> =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
>> index 93511d54abf8..0e49dab8dad2 100644
>> --- a/fs/btrfs/subpage.c
>> +++ b/fs/btrfs/subpage.c
>> @@ -475,7 +475,8 @@ void btrfs_subpage_set_writeback(const struct
>> btrfs_fs_info *fs_info,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&subpage->lock, flags)=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap_set(subpage->bitmaps, start_bit, =
len >>
>> fs_info->sectorsize_bits);
>> -=C2=A0=C2=A0=C2=A0 folio_start_writeback(folio);
>> +=C2=A0=C2=A0=C2=A0 if (!folio_test_writeback(folio))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 folio_start_writeback(folio=
);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&subpage->lock, f=
lags);
>> =C2=A0 }
>
>

