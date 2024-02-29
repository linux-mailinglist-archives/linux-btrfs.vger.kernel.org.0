Return-Path: <linux-btrfs+bounces-2945-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BC486D3AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 20:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15A51F21110
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 19:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BB913C9F4;
	Thu, 29 Feb 2024 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kWU7YDlp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF914AECD
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709236226; cv=none; b=lmBAo40MTtQ711UHp7kdh79iSce3hyLdfFiTHruaPLJapI8jAieqpo1tlwvlXbHM0C/jnLCQfyxhoPwgdHwBxnBzBeNd/6/7J0zwRglWjPsvgY21WmifOLwKbUk1dMpIfE192WgM3aVmUDd91qjr8ioBJK/kBdQDWMVEcJPH1jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709236226; c=relaxed/simple;
	bh=ihXptnIjXLrHyliIE/SGOYnux9r8rl4+S/Hn2bxvYGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=joBHeLXz2IvaZ7AbEPEaGSVeoc0s4jSEs36VEhuFoJ1fzopHhNVHpCeuPMak+h2ylrPCuzQ6F+TrNlTJnvB3QRfjezN/FOkMzMNjz/YAQuiYw0u4PqtrsCzat157a7sYO75VzD+u9rwRuldPy3L8+LahyJXD2HXb7h/QR4OdNGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kWU7YDlp; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1709236168; x=1709840968; i=quwenruo.btrfs@gmx.com;
	bh=ihXptnIjXLrHyliIE/SGOYnux9r8rl4+S/Hn2bxvYGQ=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=kWU7YDlpZx+WEhITGNuja+TlBhHJhkho+m17d5I/5eriint2qNlJVg9V3hirE0Wt
	 bW2r0ID7NTouM3/yyJMIYxz9gvqEdtOsDyEC5Uvt4xtdE4radwdSjevIvRG/9YTNE
	 9n7/gzxCR577o0xoUYfC+k1RA9LDiAgdkuItdEfwNhu85DIOmtIRR+uFpgZmC3OIc
	 vNC27USNgeErFA20lbSak6D7J0mZof1EQVo1TI5SOAZaeX/vwB/epkfT4Kp6fgoCJ
	 p/O7HCU0394bDYo+uLDO2QXNm11zdSBZSiYk1la3jxepniEVwQWQQkcRsC4JiGt1P
	 hmJwYiCu5+1kpt5lfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MtwZ4-1qs3y00A6m-00uKTA; Thu, 29
 Feb 2024 20:49:28 +0100
Message-ID: <ada345b6-f1fe-4502-a520-13b6a2f1e883@gmx.com>
Date: Fri, 1 Mar 2024 06:19:23 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to repair BTRFS
Content-Language: en-US
To: Matthew Jurgens <default@edcint.co.nz>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <cb434383-5dfb-4748-8039-1496e09a2a80@edcint.co.nz>
 <e18d4a17-12ed-438a-bceb-b1a2e10d15d4@gmx.com>
 <be5917ba-4940-4800-9fbf-c1a24f4d82be@edcint.co.nz>
 <7382a5c8-726f-41b3-9cbf-b2c67f0a5419@suse.com>
 <0dd56988-e191-45c7-a3d7-60f43fc4b7fd@edcint.co.nz>
 <2b2d37d2-d618-44eb-97f8-549b99b7b4d1@edcint.co.nz>
 <4e2faa16-3021-4d53-9121-f41d86b428fd@gmx.com>
 <cf9db9ba-96cf-440c-8ce0-d1caf7afa1c9@edcint.co.nz>
 <09cfb22a-597c-4fbe-939f-aa10d8d461a6@gmx.com>
 <706e9108-fd37-497d-9638-44cfb64e0365@edcint.co.nz>
 <ae2bae85-40b1-467e-b467-18632e0e0cfa@edcint.co.nz>
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
In-Reply-To: <ae2bae85-40b1-467e-b467-18632e0e0cfa@edcint.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/Mv/COmjW5c7UT/p+8g+AhpovJbucMOuXeifdLZGtfRMHGIiIp8
 9LTsPsU4fpyXe+JsCJygSQJODqH9ei5fgXj0IxthE8DK7yEYTlwftPCVcc05583xsGd7uIT
 91RgSJtDnG69KOtnSF6w3GCUd28yb/UidwyXdmpod3jRk3d/d9Qza1uSJNeheKGekImwpIU
 xbaciOHSvyzWFxVLApk1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A0plEHE5Aps=;KBMkxt+WBLcBnRogSTQqHotZMW1
 v1xUE66QQ42jmffOUO34rONUdfZFHk84xYJ3O8kaHywUh3dUaXfjbFX2bS2dN/P1iUUtD+xJa
 yYAY1N9h5Vm/1ZZjyUV4zv+qg6+ogwAoKsX/mEAq71kpnviIe2vjEXPihDBmi0QhM2VdYhmzz
 hgJIWQMFJezXHeHZDaJw+dtv/dod4oZu00SvpozdXIeV6VxcPcSKr903mNOtAeqdvlnGRB3E6
 jHis63bvVHomcRVBv1Q47kjYwRy4w/7iEVaziu6w4ZLUwTpTNEG4dekPLy1dA6AIxuMQLRaRm
 AgHgmugOP1en8do49U74Jf2O0lz5iXuM7Fpa1xo8J80c3G7yQqEn7ArDI7ruWf8vsNziVdpxa
 SRHCriB4WhRalmtWc6UXY+QiNRphc2+NCG0kJmB4zReOVTx+7dZn0yE9WwTvDAL397oMJHB8E
 Rdnyf2I53iJaF+9unu9TzRRLSZBo8ipKE2NEQSkSGKwV198oZhfppwxVueSFrmnnnmW8teKoN
 dW2qtdVj/5s0EVJ6YYCcxiWVvtXP0cyakwgnlLDwd3jv1hG4Gv6CZeMmuInF0RTapZB2MZRrn
 0g57+Z5nQmtA+Sli6M7UINUMEZWDoC1cyRsINZGAYqIbBqlGSwDsTE5wnmntxuAeKufI6MqHK
 eDo6h9/+53FxJjQ94wjJHXk/CivGnn1AcbL55U6gPxgy+M12tDEs+37gZJUTW2aFqL+4AR1vj
 g8BMnbX3h935JG2oG1n90MO6FNkWNmQ6XqqdRtc9BS/ixxGG1vhhKLs+LvNF8Qj4s0SsPqcYi
 5QGEAocbsfoPZM530l9C7hmvngB+bERE3Alww2XS6M0RY=



=E5=9C=A8 2024/2/29 21:31, Matthew Jurgens =E5=86=99=E9=81=93:
> Repair has been going for many hours now. I take it that even though the
> repair looks like it is repeating itself a lot, that it is expected?
>>
>> Sample below:
>>
>> [2/7] checking extents
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> Csum didn't match
>> owner ref check failed [20647087931392 16384]
>> repair deleting extent record: key [20647087931392,168,16384]
>> adding new tree backref on start 20647087931392 len 16384 parent 0 root=
 5
>> Repaired extent references for 20647087931392
>> super bytes used 4955205607424 mismatches actual used 4955205623808
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> Csum didn't match
>> owner ref check failed [20647087931392 16384]
>> repair deleting extent record: key [20647087931392,168,16384]
>> adding new tree backref on start 20647087931392 len 16384 parent 0 root=
 5
>> Repaired extent references for 20647087931392
>> super bytes used 4955205607424 mismatches actual used 4955205623808
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> Csum didn't match
>> owner ref check failed [20647087931392 16384]
>> repair deleting extent record: key [20647087931392,168,16384]
>> adding new tree backref on start 20647087931392 len 16384 parent 0 root=
 5
>> Repaired extent references for 20647087931392
>> super bytes used 4955205607424 mismatches actual used 4955205623808
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> Csum didn't match
>> owner ref check failed [20647087931392 16384]
>> repair deleting extent record: key [20647087931392,168,16384]
>> adding new tree backref on start 20647087931392 len 16384 parent 0 root=
 5
>> Repaired extent references for 20647087931392
>> super bytes used 4955205607424 mismatches actual used 4955205623808
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> Csum didn't match
>> owner ref check failed [20647087931392 16384]
>> repair deleting extent record: key [20647087931392,168,16384]
>> adding new tree backref on start 20647087931392 len 16384 parent 0 root=
 5
>> Repaired extent references for 20647087931392
>> super bytes used 4955205607424 mismatches actual used 4955205623808
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> Csum didn't match
>> metadata level mismatch on [20647087931392, 16384]
>> owner ref check failed [20647087931392 16384]
>> repair deleting extent record: key [20647087931392,168,16384]
>> adding new tree backref on start 20647087931392 len 16384 parent 0 root=
 5
>> Repaired extent references for 20647087931392
>> super bytes used 4955205607424 mismatches actual used 4955205623808
>> ERROR: tree block 20647087931392 has bad backref level, has 59 expect
>> [0, 7]
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> Csum didn't match
>> ref mismatch on [20647087931392 16384] extent item 0, found 1
>> tree extent[20647087931392, 16384] root 5 has no backref item in
>> extent tree
>> backpointer mismatch on [20647087931392 16384]
>> owner ref check failed [20647087931392 16384]
>> repair deleting extent record: key [20647087931392,168,16384]
>> adding new tree backref on start 20647087931392 len 16384 parent 0 root=
 5
>> Repaired extent references for 20647087931392
>> super bytes used 4955205607424 mismatches actual used 4955205623808
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> Csum didn't match
>> owner ref check failed [20647087931392 16384]
>> repair deleting extent record: key [20647087931392,168,16384]
>> adding new tree backref on start 20647087931392 len 16384 parent 0 root=
 5
>> Repaired extent references for 20647087931392
>> super bytes used 4955205607424 mismatches actual used 4955205623808
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> Csum didn't match
>> owner ref check failed [20647087931392 16384]
>> repair deleting extent record: key [20647087931392,168,16384]
>> adding new tree backref on start 20647087931392 len 16384 parent 0 root=
 5
>> Repaired extent references for 20647087931392
>> super bytes used 4955205607424 mismatches actual used 4955205623808
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> checksum verify failed on 20647087931392 wanted 0x97fa472a found
>> 0xccdf090b
>> Csum didn't match
>> metadata level mismatch on [20647087931392, 16384]
>> owner ref check failed [20647087931392 16384]
>> repair deleting extent record: key [20647087931392,168,16384]
>> adding new tree backref on start 20647087931392 len 16384 parent 0 root=
 5
>> Repaired extent references for 20647087931392
>> super bytes used 4955205607424 mismatches actual used 4955205623808
>> ERROR: tree block 20647087931392 has bad backref level, has 116 expect
>> [0, 7]
>>
>
> Sorry to reply an old message and mess up the thread but I am having
> trouble with my mail client or my mailbox or something and I can only
> see replies in the web page archive. I can't even see messages to myself
> when I am directly addressed. Anyway, you said
>
> "I don't think btrfs check --repair is really able to handle mismatched
> tree blocks.
>
> Thus I recommend to go "-o ro,rescue=3Dall" mount option to salvage data
> first.
>
> Thanks,
> Qu"
>
> In reply to that:
> I have already salvaged everything, so what now? Are you saying that the
> filesystem just needs to be rebuilt and I have to recover from backups?
>

I'd say, make sure the hardware is handling flush correctly.
It's pretty common for a lot of sdcard/mmc not handling them correctly.

In that case, btrfs is especially vulnerable to incorrectly handled
flush command.

Or even if you rebuild the fs and recover from backup, it would be
doomed sooner or later.

Thanks,
Qu

