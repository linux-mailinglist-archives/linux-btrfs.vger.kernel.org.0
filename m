Return-Path: <linux-btrfs+bounces-4542-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2D88B160A
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Apr 2024 00:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D801C2120C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 22:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201FD16D329;
	Wed, 24 Apr 2024 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dTGKG5EY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00CE13AD0D
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713997167; cv=none; b=HHOiAGXYRXMhMxFDyqsQUhLHzNZAzoaZCvQMUsNjBdJKRkF4F1Ad9S65lIkXCZ5wbb1/2CRvu9VCEF2+I0cMLLmupWCtIbEYGYVAHEldAxL89VFWVTTKYZa2AJtx/DKWOibbu44FWyPrzYbfmeCiRw64dyv+ZscSHv3herNXzQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713997167; c=relaxed/simple;
	bh=Bsuf03xLCK/Nz6k8TyVhRbGcEp+8+BEGsIHV5CexEKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3ldZOE39vqwMLU6bQhCeb+1C9BLXLMGz0VjLkFsyxUgqJTzph8Y47jraJqkNBjNUj4fgLJRapNNAGaVvVYnvRJKr9fahX2QmVvHxW5pwWQU+S6pDlwx8f4q8rPapo4mb9kYwL5v5wsl6bG2stF9uvPC8mat9hXrunENMHTd5cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dTGKG5EY; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1713997159; x=1714601959; i=quwenruo.btrfs@gmx.com;
	bh=+ESbLeX9xqKxdQnTZnsOKMClrQvApYzNT4iVhpdyVyU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dTGKG5EY9W+YIc53oNiqseHYDkzKIHzCG2afD5Z4mJJdglRuhLWfTtmmLvQVvPWZ
	 4OcsldIUhZTbUrqE1p2LNWslyrucK6JuKY1KrAp2kRxljsfXHUPGwsve+zTpol1Ru
	 9BHj0E/kEoP8oYicu7F0Tpy/otarlz8iEksMtoil1uGRhHMV3t8TPtCKB//cwVNbx
	 31+ZG8mZPkNK8eLx/Gv0J/z8t8qzgcZcYTtf6IwGY6i30jblxP7ahzSFsTx6qtc08
	 069JJU9a1GqkpImBTgx8glyF6Vz8wSY38xglg9Bbnln5OL6u8MmicciXB7ShK/P0n
	 ctwkCu54I9HsP8o37w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MORAU-1sLIUK0jZm-00OR8X; Thu, 25
 Apr 2024 00:19:19 +0200
Message-ID: <598907d6-77e0-4134-b709-51106dcfb2f8@gmx.com>
Date: Thu, 25 Apr 2024 07:49:12 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] btrfs: automatically remove the subvolume qgroup
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, boris@bur.io
References: <cover.1713519718.git.wqu@suse.com>
 <07e54de6747a5bf1e6a422cba80cbb06ba832cf4.1713519718.git.wqu@suse.com>
 <20240424124156.GO3492@twin.jikos.cz>
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
In-Reply-To: <20240424124156.GO3492@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LMVIdDq0Nqc66wwoHv+9oEK2KubLjxZM4neBwC0KFZom2A/fWuu
 XQE1bnCWUPSTAWF8JWdGVCjlwKsw/BJkR5Asnn6qQxEatqr+o+ZIOf9w0Hh/xIh45DX2VGi
 Kvzyoy2CLwQeiEr+W24VsAU+0jK0rCV3gKQ58ZYy7cUavim/bWkyAuVWxyLdEUtBi8QAFcZ
 HUI9sCSCqBa71puLjX7Gg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PZ+UTUQVChs=;kWVE8b8E3qi0BqXUCmqYfNYeKac
 wuPvqMj12lq3pME3lyK8+8TPSzKpfiZwmlUCG9vjA8Ef5KHCKF6eECwRRE4xQKmGXBfzbjOXo
 BBn9cdWc5e/i7K13di8K2zaUerQdBy4geMRxAMPA6WXzovObVUOrnhZZgTUt4rWNGgUBDOzC1
 qlPloqohe12fwyGp2OUbuL8GN4tUWt4KWQwJGfBFMqzrXQ5Th6YCFlByIH6luMYhdWuQF0iW9
 Mk+syhxirGeXtt6qHn3hw8mHCDAQBrd6rj5Y9Nj+j0YxhCBE8EEITxWJso3TUe5FlncbEy01T
 ovFF4XLQ4RYdraeHetO7TeArkfetCIntWygrIYp+2J3hFSwCPVs0E2MqHnCH42cr04sd3hJT/
 1CLnsjnZ8mY8YBD/Wp8BEOgnAuYAtwXojMVcLgZAAmPA1QWu+6pffp2lsRlEZoWdAbRFKL9bX
 Shoc6rodmR79UUBA0gPrmyhSElY8XFTeZ2X3AOrBI6Zc8gxzG3+H81ScFqBP/QzeCFf1l8ntQ
 jb0pE/pkvNY2luZlh+LAKtjt0Y+kEdViKAPK83BZ0ELdiN0bmmpRimFIDW6pET4cJ2c3fEfCv
 +3uwBmVh8ZKaAM3Oe8wM7j5zX2D8Rz/IcyxlQ33fmt9p4MHgDzalPQ7AkEA5/hvtzMfXME6i2
 /+wjbUIToAP9UTeenQjG3nxgh6bTjhb0zqGbExAd7O8w9IcAebOyl1oYJdlfgvJR9CO8U7xOJ
 0+Ly9IgNeUjcgwO+EmvVgxOcKNtNIdUgHdOlsNG/CINLqfKYAxgsuSyhpPSRrUBi0YUAVOtPJ
 OP/suOGKUNB1wVhVcwDrswcoj01nU62MY12XQ6GCiNYCM=



=E5=9C=A8 2024/4/24 22:11, David Sterba =E5=86=99=E9=81=93:
> On Fri, Apr 19, 2024 at 07:16:53PM +0930, Qu Wenruo wrote:
>> Currently if we fully removed a subvolume (not only unlinked, but fully
>> dropped its root item), its qgroup would not be removed.
>>
>> Thus we have "btrfs qgroup clear-stale" to handle such 0 level qgroups.
>
> There's also an option 'btrfs subvolume delete --delete-qgroup' that
> does that and is going to be default in 6.9. With this kernel change it
> would break the behaviour of the --no-delete-qgroup, which is there for
> the case something depends on that.  For now I'd rather postpone
> changing the kernel behaviour.
>

A quick glance of the --delete-qgroup shows it won't work as expected at
all.

Firstly, the qgroup delete requires the qgroup numbers to be 0.
Meanwhile qgroup numbers can only be 0 after 1) the full subvolume has
been dropped 2) a transaction is committed to reflect the qgroup numbers.

Both situation is only handled in my patchset, thus this means for a lot
of cases it won't work at all.

Furthermore, there is the drop_subtree_threshold thing, which can mark
qgroup inconsistent and skip accounting, making the target subvolume's
qgroup numbers never fall back to 0 (until next rescan).

So I'm afraid the --delete-qgroup won't work until the 1/2 patch get
merged (allowing deleting qgroups as long as the target subvolume is gone)=
.

Thanks,
Qu

