Return-Path: <linux-btrfs+bounces-4944-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4628C8C498C
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 00:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAE7287540
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 22:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380FC84A5B;
	Mon, 13 May 2024 22:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gatxA53P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7712C1A9
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 22:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715638503; cv=none; b=XHxMWdpokrFN/LckMZF4tA1Ljrs1sf0j1hpBxxnE1+h93dtWhHNxBxOWmdiQAQfmig/Z6sKNrZ6K2rSs/FVYk20JV5BH3cxH+c++PLNzQ9VUMa1dwzIf8MA98e0JZSdUSbZPbJCuH+hAReI6s7LoUZjREM66m7fw4hOz9Q8fffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715638503; c=relaxed/simple;
	bh=Phns/xcQH3aq0X2AlpMotbkxpNXCs9HWJpbVPkAo4Oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6So57dQ2AlSw7SFvNRj+sz0CpPLoiOrQeKf+IsrUoIw6CmPFy/uMyW3TKcmaf0Sh9/sIoOoSNHdtTrCdKLn8k7t1+DdOedDiaVzsVZPrsi/YbbbMBBplyh1v9WLcko3xRK9dD6pF0ihD/pr0xgcVO/hODMsRuxUm8J4YwVLyuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gatxA53P; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715638494; x=1716243294; i=quwenruo.btrfs@gmx.com;
	bh=K0GxX8L5xBgo/f6/bupn/d+ilGUgq6BG3ChZwFqVDkw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gatxA53P23lHhSMEaoAzFmPDhm5CCyWtstvjZcr/os+5WthAYcXma8rIAOEuyk3E
	 lO/HOGyxXJ6cecCamG/00X5xBC+/nEZnjgKMe8+coQiF+9rh+aKVeeaaUjgubBgE8
	 nu6T0GWHuPL9I8bBwhkGUClm3JBaFXXoOzxOleCeV5eLgqR4Qu3RiJIR7hnUoMSUN
	 vG5K9LKFbpk4a8EfiSufgD+ei33yJSQCJhRWT2JUsY9nQihhTXodofeIngbS8NpZS
	 5sPIwOZ67z5yBqnmoQtR4JOlBNsM25dx2uUUYdQa0PU47tsBieDAYA+yyHFd3mQSb
	 MmWxcT1hyY8JB20lMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MjS9I-1sqCJD3yzC-00ktmn; Tue, 14
 May 2024 00:14:54 +0200
Message-ID: <6e8925b1-c492-4f5c-8143-b14fd97a0e12@gmx.com>
Date: Tue, 14 May 2024 07:44:48 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] btrfs: remove extent_map::orig_start member
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cover.1714707707.git.wqu@suse.com>
 <f6a08d8298dc84e72834a9897a75205194d23c6c.1714707707.git.wqu@suse.com>
 <CAL3q7H5fTGX0zJzzWepv2LdVYf2Vb_fBbBUhVZhhc4v8cXe8NA@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5fTGX0zJzzWepv2LdVYf2Vb_fBbBUhVZhhc4v8cXe8NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Upiwz4t/kcx3J1D+O5TUCdDAcFxqzpkwTywWCMjLukywfn585rz
 6wwX/E6o87daX6J2sM2+JQk3H6FOFGQYaxJI6yRpne0rs4Sq17QPodhdl/IZnxM8jebcrgi
 TGWZDMoheFEV7HHE1N1LXfxsRugjluHE0eBEoaZwxpoLUVKuc/FtJj6nZUzfBkPzjz+4yxD
 8hR/keqUv4ryaDMuqIOoQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FuS3rIQ8xXQ=;XIIL7m2Ezj49BvC5YFdTgLk/qIg
 IqqY6Uu4NyZBfSIkCqP9fYPHzPX3X7u06nsC4xSpYL7Qs6luNldb2pFjCCReo4vGlr+lkzliM
 r5T2TL7EPpPkq/NPXq3O6BK5TSVSf9yDk5IZxhpsjS58gzLi+lXT6elfCD6pDHPC4w/mPepyR
 esoWkkQBRGixWB34fQXfaTxNDP9PJ57X90eCvLUAP+zX5MceGaqDWNM24tsSgIslVGyZ88q9G
 vNwZxiIKGiLWh0qbzpIpXIEa6To1PnAS8RSVQAy9Gn1UILUogKuE7rz2XD+lDTO8561WU0+hE
 F82VNYtC25kdnecS15ToASKFMBp4hLobn6jV0zxCbsh/+qIhsuPoE0CTKDIv8SVskAtjBHC1j
 MK8MeC2M88Ypdl9SmIERiK0b8ZQLVoWBc3R8cGNkD+3gjM0Y17j0VKxRLE+KXSXJotwyd6SGe
 Dq6lmviMciaRJnFgBWg/bZzxzj+hFCa81IQriOCbFEmcMMb/tWK4bsEqcUv+2vWut6P5rPqc9
 ZekXGgR0/kzW6YNCkQuXz9ZRalu+NnJsYqlk3bS4XcZmd0GVleYRU/mwxv7XJhHA23CGyhPac
 RHZKFMd8QPwQQZjwWf2BZy7BYn2WGsxHvN7zk3jD1L2CKw/L2Gh2S82KT8WTs0YL40ityADXp
 rWSciWwFQvKcRZkNGAgAKeaVZKelJRgiz+qNTZjQeUAmgwB+qqhasfveygWMCNefLe3b8EeH6
 rPz9jOkbZu7HAkeC4jPutfxxTd3UPMyyUQHaDvv8stcRiI4HttYSqOI54zx5UTzdaUgJKd+u5
 op/oTiJHZ8jjSQMNv6LV+tqbNghYFV8uZaIkSTMpiSXU8=



=E5=9C=A8 2024/5/13 22:39, Filipe Manana =E5=86=99=E9=81=93:
[...]
>> @@ -861,7 +857,7 @@ TRACE_EVENT(btrfs_add_block_group,
>>                  { BTRFS_DROP_DELAYED_REF,   "DROP_DELAYED_REF" },     =
  \
>>                  { BTRFS_ADD_DELAYED_EXTENT, "ADD_DELAYED_EXTENT" },   =
  \
>>                  { BTRFS_UPDATE_DELAYED_HEAD, "UPDATE_DELAYED_HEAD" })
>> -
>> +
>
> Unrelated white space change. Please avoid that.

That seems to be caused by clangd lsp server.

I have no idea why it automatically cleaned up the whitespace problems
every time I modified the header file.
And IIRC it's not the first time it's doing this.

I'd better find a way to disable the auto fix.

Thanks,
Qu
>
> Thanks.
>
>>
>>   DECLARE_EVENT_CLASS(btrfs_delayed_tree_ref,
>>
>> @@ -873,7 +869,7 @@ DECLARE_EVENT_CLASS(btrfs_delayed_tree_ref,
>>          TP_STRUCT__entry_btrfs(
>>                  __field(        u64,  bytenr            )
>>                  __field(        u64,  num_bytes         )
>> -               __field(        int,  action            )
>> +               __field(        int,  action            )
>>                  __field(        u64,  parent            )
>>                  __field(        u64,  ref_root          )
>>                  __field(        int,  level             )
>> @@ -930,7 +926,7 @@ DECLARE_EVENT_CLASS(btrfs_delayed_data_ref,
>>          TP_STRUCT__entry_btrfs(
>>                  __field(        u64,  bytenr            )
>>                  __field(        u64,  num_bytes         )
>> -               __field(        int,  action            )
>> +               __field(        int,  action            )
>>                  __field(        u64,  parent            )
>>                  __field(        u64,  ref_root          )
>>                  __field(        u64,  owner             )
>> @@ -992,7 +988,7 @@ DECLARE_EVENT_CLASS(btrfs_delayed_ref_head,
>>          TP_STRUCT__entry_btrfs(
>>                  __field(        u64,  bytenr            )
>>                  __field(        u64,  num_bytes         )
>> -               __field(        int,  action            )
>> +               __field(        int,  action            )
>>                  __field(        int,  is_data           )
>>          ),
>>
>> --
>> 2.45.0
>>
>>
>

