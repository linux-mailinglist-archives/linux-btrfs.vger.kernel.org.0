Return-Path: <linux-btrfs+bounces-7401-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C87495B34C
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 12:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFCCF1F23DE0
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 10:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB83183CB5;
	Thu, 22 Aug 2024 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KaogCv3K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B19D166F3D
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724324363; cv=none; b=SPhyj4uFzuja/lcjc4REqGCPySHQ/xGyMX2v8q7nfxBACRAXXCAVs2wljmWr3O0vnIUvk63DGcvmqVfqWlwC8HrMCwXyyi4J5gwQ7VVZGjj9Sj6BGhW7hhIkHk3gX7XMJMm52f+jJmh/CoqmH9DDnDLiLE/XlRLgMD/Hzr5hjG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724324363; c=relaxed/simple;
	bh=+84YK6+zwFvcumX3A0QOLsb1YpQCG2WSgvCLDPYt8Fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGmu1nbJb4Zwmnn0+t4ztftO4qB7UdLBqV0ecgg+ygpqqp27jbGAiAoS5YKypUZOBWDJbUG+IBhl01aere9gh0ullH54Ye5CRs5m3QMrjbtUrJBHZ9yE3bUDLUzAlcJ8sDwBCDzClR0p1DW4/SDhBSmGYS0fi8gKaonsK8U5TV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=KaogCv3K; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724324297; x=1724929097; i=quwenruo.btrfs@gmx.com;
	bh=z7bsh2q22Pgsp59libq4MfKgK1dNZBn4pNAk8Le00aA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KaogCv3KJROMprj1/OqnmP91/56PhqjfDJshEDdSa+47ut3lmYAGaarB6wtpCJ1R
	 es+ChW2fcHtdXE+wJkSzelimtg9nFOX6kqwrV4sIyiwILtuAfkJPoKe5+2vqTNqq5
	 kPyr3f26GTcQrTWcQaMTLm2SMfcIPIamKsljVHzsd4jX6R5xMMMYyCzkRFezYaBzL
	 3ZUQdN87o2G4+jLzBSLOpVV4JU3+ZitT4snnxWyPCb7rkIUnXt7ZRxGm/CObKQXTL
	 BIQtwFmIJVHVqOjDtxPuS6aBV4s2GR7IH0Xez3GJ0f8E1SfItk3xe8j8H7EVC34ue
	 7Q/JJJeqOomFroVwXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mkpex-1sH8Ip2yid-00jpL5; Thu, 22
 Aug 2024 12:58:17 +0200
Message-ID: <0f643b0f-f1c2-48b7-99d5-809b8b7f0aac@gmx.com>
Date: Thu, 22 Aug 2024 20:28:09 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] btrfs: convert get_next_extent_buffer() to take a
 folio
To: Matthew Wilcox <willy@infradead.org>, Li Zetao <lizetao1@huawei.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, terrelln@fb.com,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20240822013714.3278193-1-lizetao1@huawei.com>
 <20240822013714.3278193-3-lizetao1@huawei.com>
 <Zsaq_QkyQIhGsvTj@casper.infradead.org>
Content-Language: en-US
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
In-Reply-To: <Zsaq_QkyQIhGsvTj@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7mJ/c2TSUe7ALlg/F/jsxHMl5yUnUZOzvtsePpbl8j9Tgi8Z+Uc
 RdKVWi4eOMccC0EPginzcTHe6Ga93ofgbjmOaEBSGEY+zvWLpVGPl26soN+dq420p4tPpRc
 4cq2al3tap77XWwR2+bWUr/r2Nqowd3hRrg27djBftxTKFTb2U0COGa73wjaE0K1du4DHOk
 KLaO3oFCjUYzQOSpFVMrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WQ2j5eHUrqg=;lzfUnnLzgJ/gd/5x9OeFiO3zLn6
 3eOeHmD4TtIMkS+Psz9XyNUWsUcCEfAvYkDrWsBFjPRgNBU1kHUNtJOhl2E4MhoeCDWvBgXfP
 nkdR3oB6JNpYwiJgMXTwQKy/nbZ/EnUMToQQnulSxXU8PqQFFrV17WzfYIAXQlOQigLhfLh+G
 bv1MP4c9u5BPtYEBEeO/VMsijST3jywKnhGAwEjDNxHRf4cPRYbzBMkhm8fOfMXHaG+uaJEEF
 nFmMD33QUe/PsYSSTzA272r1cJxoAiONYvHeeOjOJnaezvsGmQYRcoPHOwRRmrt59oC7YPB8B
 Yorg3LTQH5vjDt+iHzonUcjZhWodUNkPe9qEL3wvTfxrLc9m9TmODaHMEnD6r/Of0Xz01KJOh
 EBykOPt5iLadJzHS9+wj95hb4De10z72yqi1zztTK7VczeZqoamAcLnLM1wJRL4DuwCdPMLoP
 o6hRhDfhtIA3OAzCSNNe2FxGJwEohieFlnWOv0Or9BUF0bnpnIQzXP7+8Y5lpAk+v4d/NqADV
 7seRQwtOAAzY695k4ejXSb9yxgnCAIr4dA+M55KuoGEa0SYstY6qkEJp48rM3vDNfd8kYw9st
 cTF/JKUaxGs729yKaWbrDIRHBbXIr94RTIBV8ZKNIk6qNy/e5CcomOpcAcjnYgjm9q9NgQ3TK
 p14rBY2evekgqPz2PV1E7HTkEEJT/tOSF72Yw25wsi6L8AcWJSxASMbQWF/xfHbrvTnojM0PE
 6AbZM0mNu2DHZsfDgTUzpBSMg9/BwkH50hYXLCFRguz/Hl1LYpc0EOPdJdyMS0IWymjAG4nno
 sc4vuswZYMDpvKmD3sn0f4NQ==



=E5=9C=A8 2024/8/22 12:35, Matthew Wilcox =E5=86=99=E9=81=93:
> On Thu, Aug 22, 2024 at 09:37:02AM +0800, Li Zetao wrote:
>>   static struct extent_buffer *get_next_extent_buffer(
>> -		const struct btrfs_fs_info *fs_info, struct page *page, u64 bytenr)
>> +		const struct btrfs_fs_info *fs_info, struct folio *folio, u64 bytenr=
)
>>   {
>>   	struct extent_buffer *gang[GANG_LOOKUP_SIZE];
>>   	struct extent_buffer *found =3D NULL;
>> -	u64 page_start =3D page_offset(page);
>> -	u64 cur =3D page_start;
>> +	u64 folio_start =3D folio_pos(folio);
>> +	u64 cur =3D folio_start;
>>
>> -	ASSERT(in_range(bytenr, page_start, PAGE_SIZE));
>> +	ASSERT(in_range(bytenr, folio_start, PAGE_SIZE));
>>   	lockdep_assert_held(&fs_info->buffer_lock);
>>
>> -	while (cur < page_start + PAGE_SIZE) {
>> +	while (cur < folio_start + PAGE_SIZE) {
>
> Presumably we want to support large folios in btrfs at some point?

Yes, and we're already working towards that direction.

> I certainly want to remove CONFIG_READ_ONLY_THP_FOR_FS soon and that'll
> be a bit of a regression for btrfs if it doesn't have large folio
> support.  So shouldn't we also s/PAGE_SIZE/folio_size(folio)/ ?

AFAIK we're only going to support larger folios to support larger than
PAGE_SIZE sector size so far.
So every folio is still in a fixed size (sector size, >=3D PAGE_SIZE).

Not familiar with transparent huge page, I thought transparent huge page
is transparent to fs.

Or do we need some special handling?
My uneducated guess is, we will get a larger folio passed to readpage
call back directly?
It's straightforward enough to read all contents for a larger folio,
it's no different to subpage handling.

But what will happen if some writes happened to that larger folio?
Do MM layer detects that and split the folios? Or the fs has to go the
subpage routine (with an extra structure recording all the subpage flags
bitmap)?

Thanks,
Qu

