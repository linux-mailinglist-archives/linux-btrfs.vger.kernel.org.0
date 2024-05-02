Return-Path: <linux-btrfs+bounces-4685-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CEA8BA255
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 23:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59815B233AC
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 21:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DD51A0AFD;
	Thu,  2 May 2024 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="fXnienSo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFD3181313
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685239; cv=none; b=Kpq5XYDPHdnohweoCSmjcxmIecsiOGm28HmHOOltTvywGJL80ZAe0KsPhLxPlrs23ZM+IU45ppNO4AgJw0Tm3z6c7GPMO31EWp3caVXsyPR6VTUVSte+aygPpQegj5D9cWqRV1D4nzQBhuyx1mNC1L5V1ueObM4lCHdKjLwgmX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685239; c=relaxed/simple;
	bh=bxk8dXlxuZiRI7FHKtSd5kS+6GVFc1KACiTW4X+ZM8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gc07gCXRrUv7E3J2tO/96gNm4r25C21mFo6M6peQ9/BkYN+mfz044N4b61/xHxvgvvBPnR2kZDPqo1ckWdiRGrKXWSJ1lpXrg++IylxaQEZDhYBi/QxjFIYBl7DdNNVZfnLPDVXAQ1NAd5/i08krjbwaU9ZYmbHzPt9tjttSv0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=fXnienSo; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1714685230; x=1715290030; i=quwenruo.btrfs@gmx.com;
	bh=IT8ivJLXYilJdothllFHsf6vNZrQxE8FoHix2ibJ7qs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fXnienSorOdhZc1YW/aarb85L2ElvM1DYno6EZd7zBO+0mFJHlLBQYASOdetAQdr
	 771whuW6+0r3BMqil3fonGYF9gpM3/oVynlQCJe1owtLcvgn+EoQdyoTOlEL5/jvW
	 EA/koRW6Jn1VbpPH4M6XtsfP0DXSFy6mNTDnr+Qv0FhK3mP+A9EQtL0D2msoowqU+
	 QgktzMEXphs2sa3dvgGfOCLX3tX5N92ZgGIP4kqIPDaOxkGchPFXmPpDxijC3Qfoq
	 DvwbJ/A90XHcqGWDcj6Z3CodskBRkxPLquFBGIKlfWGqNmN0W2WRri2wjbaPir0DM
	 nXtVME80rj17GRcBIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2wKq-1s3kPp2JO0-003LQy; Thu, 02
 May 2024 23:27:10 +0200
Message-ID: <bf2b6975-6930-4676-b5ef-de553a2f82cb@gmx.com>
Date: Fri, 3 May 2024 06:57:03 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] btrfs: automatically remove the subvolume qgroup
To: dsterba@suse.cz
Cc: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <07e54de6747a5bf1e6a422cba80cbb06ba832cf4.1713519718.git.wqu@suse.com>
 <20240424124156.GO3492@twin.jikos.cz>
 <598907d6-77e0-4134-b709-51106dcfb2f8@gmx.com>
 <20240425123450.GP3492@twin.jikos.cz>
 <9df817bc-f3a8-4096-aabc-12044447a900@gmx.com>
 <20240429131333.GC21573@zen.localdomain> <20240429163136.GG2585@suse.cz>
 <f8d3bf56-0554-44ec-ac1a-2604aaf37972@gmx.com>
 <20240430105938.GM2585@suse.cz>
 <4a83b326-9cde-45f5-8a53-da7b62c45619@gmx.com>
 <20240502150056.GR2585@twin.jikos.cz>
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
In-Reply-To: <20240502150056.GR2585@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lgTLiv8enJDncnEGwQ/g0bKUT9qrnpUR3aqgkHH1l65Z8zoV8n7
 /jEOmJ7awW9r0H1uowF9SQu+LbHTiIPXE7w/RJ+k5RPotfcHdVe3UW17SA1+0oq4KRfj0MH
 CNZIAMU3bVnHxgLE5+wCY84++EaZQryW3xJqk3kWeAXXw6qw2moTVjNdg2dyOOa2+fS8K+t
 MdFWKKTz+ESCmlgCZmU9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oHXl1UR/xLA=;P5i9C/thIrGcIuuCiQHc+EPvXCT
 OjJffW/zXuziyZjCKF/y/qZLmTBXnnAVs5bM/GUmgvlGxQ3v88/bgzNewRXs8I+q5crjjKcNc
 me/wamQb6dKx/ECoeg3pF7QHxmqmpqNYk/7sUuaENi3GvAphADiwKIn9cSRBXFXZfW0jbb0oh
 zww4xM6xpafy1cUXEtjKr5S46TR7AoDccqo6KyiiOgJOqT8GhQbRy7HeVY5ErV4++h2pyYiNe
 On/4TnDJqh72mx/G8ZxEi+ly0DiJIjscUOTEQV3HXpo5kmKMNB0LGcsC+go/9JquI3JauX1rW
 q0Wo9ppdj32Cs879iRKT4YrwPf4DmrGwOUqUT5FbrS0NEDf1fWvzQN5uS7O2LIf5AZPlxbyY1
 31s2UOChWa0B3mYPgHmilH/kDTsjYOCvm0d51rt1OEgXm7zX6wM1b20XBu4Ra50QTk96jvRvT
 dw62a2GZy5aJDkH+Ay15NduLIKRZvr6cRl3Mm/n7MGzryYeO+ONYFNkt7hi5yLFPc7NN9w5D2
 y9k/ABUGf9qYhKI929VzfF12++iJ9MvNhZfcJU3l6CwMJ+hXs4Dqo+pwgty+8FzHbq6m6WhHY
 oeKZbva4BqEPh1vkb2KwWjHC1u9ufdQLOMU1W9xTfM2j4Rq+G3mOFEecxUSQ/KyqlYxF5m67F
 hwN/UxIoyMCggGwH2q2W4N7UrtmejeWW6ggOQAM7LFkaoHnNOBhlD54XkVSSj/smQeI54C+Uq
 CiiPYO8/gVjCaYIG6TbdcLeRHaYGlhIKaqegKJDPbbPYNInR1D3NGq1qr6v2nENWpHhabXwq9
 ngTtalHDBGucNT9RM5bPT9TXl84JYf4y1r9XVA7fOSRL4=



=E5=9C=A8 2024/5/3 00:30, David Sterba =E5=86=99=E9=81=93:
> On Wed, May 01, 2024 at 07:35:09AM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/4/30 20:29, David Sterba =E5=86=99=E9=81=93:
>>> On Tue, Apr 30, 2024 at 07:35:11AM +0930, Qu Wenruo wrote:
>>>>
>>>>
>>>> =E5=9C=A8 2024/4/30 02:01, David Sterba =E5=86=99=E9=81=93:
>>>>> On Mon, Apr 29, 2024 at 06:13:33AM -0700, Boris Burkov wrote:
>>>>>> I support the auto deletion in the kernel as you propose, I think i=
t
>>>>>> just makes sense. Who wants stale, empty qgroups around that aren't
>>>>>> attached to any subvol? I suppose that with the drop_thresh thing, =
it is
>>>>>> possible some parent qgroup still reflects the usage until the next=
 full
>>>>>> scan?
>>>>>
>>>>> The stale qgroups have been out for a long time so removing them aft=
er
>>>>> subvolume deletion is changing default behaviour, this always breaks
>>>>> somebody's scripts or tools.
>>>>
>>>> If needed I can introduce a compat bit (the first one), to tell the
>>>> behavior difference.
>>>>
>>>> And if we go the compat bit way, I believe it can be the first exampl=
e
>>>> on how to do a kernel behavior change correctly without breaking any
>>>> user space assumption.
>>>
>>> I don't see how a compat bit would work here, we use them for feature
>>> compatibility and for general access to data (full or read-only). What
>>> we do with individual behavioral changes are sysfs files. They're
>>> detectable by scripts and can be also used for configuration. In this
>>> case enabling/disabling autoclean of the qgroups.
>>
>> I mean the compat bit, which is fully empty now.
>
> Which compat bit and in which structure? What I mean is the super block
> incompat/compat bits but what you described below does not match it.

Superblock compat bit exactly.

I didn't see why my following description doesn't match it.

We have 3 compat bits:

- incompat
   Huge on-disk format change that older kernel can not understand and
   affects older kernels' ability to read files.
   This is the most abused bits from the past.
   A lot of features like skinny metadata should go compat_ro.

- compat_ro
   On-disk format changes, but older kernels should still be able to read
   the fs/csum tree etc.

- compat
   Not utilized for now. Older kernel can still do everything without any
   problem.
   Thus this should be the best candidate for runtime behavior changes
   that doesn't affect on-disk format at all.

Thanks,
Qu
>
>> The new bit would be something like BTRFS_QGROUP_AUTO_REMOVAL, with tha=
t
>> set, btrfs would auto remove any stale qgroups (for regular qgroups tho=
ugh).
>>
>> Without that, it would be as usual (no auto removal).

