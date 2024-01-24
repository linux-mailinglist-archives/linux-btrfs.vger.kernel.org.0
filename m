Return-Path: <linux-btrfs+bounces-1674-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B566683A152
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 06:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6451F28D63
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 05:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF61EE575;
	Wed, 24 Jan 2024 05:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jhGJRm+9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814EADF4C
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 05:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706074081; cv=none; b=FJy5T9Ie/s9Z3lV42YDUJaxqFdfglj5DWYqCheaZeF/ZMJqyX1sCfC0y7loGpGorRK+KEJZud4H9jvk9oIAV7QMIimf7yQnbnLKYyyU4+AhZEBf74lsLO/cyn28IJNreVXR6t+j8KSF7DFOEHAJbCV4niDc0KXa6K9UlAyrGmyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706074081; c=relaxed/simple;
	bh=ynYUTBvX8W8k7MwK/6igyFgtF5Ze8dq802LskizxSsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Be43Px+fV2RfEH6E5vxc9jKkk8DBx7UmoseFBGRkHadJC792JDsPo5SeaxDUSTNLUfzWJzCatspsrok6milmD4esi0lyo8zurDMc0N9LXU9Hk2fv8f+JK1tmDa8mTqSVWYle9Hv7gI7DPKXDO19rGLpDaBYNw5148LTFGMdkVEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jhGJRm+9; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706074064; x=1706678864; i=quwenruo.btrfs@gmx.com;
	bh=ynYUTBvX8W8k7MwK/6igyFgtF5Ze8dq802LskizxSsQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=jhGJRm+93qSLB8ncD9Aw4QVhsU1r3aS97lTAearm62xaaaQQ2LJA1chq/cpAfhk/
	 CyJ6JDZEBAyW1MTSUrhCt2/L4jGlFi6e07I4647avFyeJJH43oA6Lyfb13yfP2vK0
	 JxW74xueXpVnm/o3ui/kgXaJjlyRKZ6qXG6pydfSkRkMd1HX3TVeQQUZK5G4pFeSa
	 iq9A/Gtm2ge7M5Cc48XZanpMN/B8P/bX3+GK26Msu0rdl5FmO2uDJlKIi89GUSgRw
	 gEPUHUm4i/+KQLLTRwiZPXfK/iMEhS7fiGev2FXKi1ZtadNuuiTbnbwvmhvaiOKC+
	 m2O6poMV1Bx57iaoZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1fii-1r4Gmt2moS-011xil; Wed, 24
 Jan 2024 06:27:44 +0100
Message-ID: <45066165-3d2d-4026-87d3-2cfe3369a86b@gmx.com>
Date: Wed, 24 Jan 2024 15:57:39 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] btrfs: defrag: further preparation for multi-page
 sector size
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>
References: <cover.1706068026.git.wqu@suse.com>
 <b521e943-ae86-4a6c-a470-072268b254a0@suse.com>
 <ZbCWi98hWKnIW1zq@casper.infradead.org>
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
In-Reply-To: <ZbCWi98hWKnIW1zq@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sdRr7enkzJUnUrfC1ucxKu4e0z4cpg3Uw6UgzndZ+7iXIZmkB78
 HOwowTq3jnzEua4Lrji6ikk+PPbV1WMOtQ4k3fT9ebH09g9g7VhPNa2Bsxei2PrGSG0sQ+Q
 vCvlKaId/jq73PL0QY/K9sTv+GEa3BYWPLuZiEA/U34ju9ZGaLII0QIK29RY/sQv2ou+y/+
 /ATh4S3yU4NpnB2Jb3FrQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q5CsCIr2egU=;jvQwTsCnm694ZhcG0vwACfb7H7B
 MyA/BOiZ5tmtWZlr5M4mxxWdogIudNa54ybrIemOPL1d0cP4maAf2QIPn9lX8KsBT98WTzdSR
 Y5yV2Y4P8YoIjBTqHyxp4OYa/FVzVgVlgjzm05JR/nrM9pjpBjgCatwClLrjDg9pFrKBJ+2SH
 WhoaH/2NtE2AH/1i5JZivxN8U24uqWgWizJsvAdw+hK3Tzsk9WvzV0m1r6BpCcy7TznfJ5kWR
 kEfSj8vEmYfm9GMG61rFGoDuti6smjqf9HwUtudscC+hLKqsvXl1Xkcv4LeVyKasulReSuf+g
 O40DmZLE6NrivFMn8ocPQXjy/q6lKQbM0SeKLf+c+Qn/UzBAopFwe5qzfu6K4vyCrhGvAt74h
 6UuyRGYsWXFncFFDV79dWQNbOlFGrSRRUv+shhISWWsIaN19+chrBUoTi+ao/tv2k4szlhhkv
 qLzt/9BdeFl1zSrQaC5LcGsefGCnsQXIRIX85cXxMshZ0sBsK8lXwATH9184yR2VsQ3ukBpMn
 zhWAJuy7K3xhpXmOJEvLVTCTgQVfPM6X8xbPnu10kKjxBv2dKFN251dQ7N7LVHdddgLeRay7H
 Qo7wY0cZzZbYhUya/reAWwquVAM5s3tm3k9oLwCg/rT7of6efwiViTDsCANT0anpn0fNt+akQ
 zuRy165JOK+Jtr0GbS+kYNJzBUMHzPZyKukUKv1u+bsuZf1ZuruHdutxTaI3P4bSuhxC60I2P
 Fn3Wu+RhhUIR89v3M4tB8dd8e16u3sY4/i0s5h25bZ6xjBaVR8Hf/xxOeamPG7oX8woumTK8B
 PJuIbuyeyG2FjXdDbP8CjuFiZdFit7BRwT1c8I0UCDsRpjOVC6vyKCOwHS4vhLbVqqz9c2zxT
 laBZ9SJjnlCVF5Ez3N8mz9uPdIBx3oXJDM0w8hioHX3yPmlNQ/C8gl1f6/P+sfL9ubiW+chcg
 TghLa2sz5hIIrI38myS1rI43oYQ=



On 2024/1/24 15:18, Matthew Wilcox wrote:
> On Wed, Jan 24, 2024 at 02:33:22PM +1030, Qu Wenruo wrote:
>> I'm pretty sure we would have some filesystems go utilizing larger foli=
os to
>> implement their multi-page block size support.
>>
>> Thus in that case, can we have an interface change to make all folio
>> versions of filemap_*() to accept a file offset instead of page index?
>
> You're confused.  There's no change needed to the filemap API to support
> large folios used by large block sizes.  Quite possibly more of btrfs
> is confused, but it's really very simple.  index =3D=3D pos / PAGE_SIZE.
> That's all.  Even if you have a 64kB block size device on a 4kB PAGE_SIZ=
E
> machine.

Yes, I understand that filemap API is always working on PAGE_SHIFTed index=
.

The concern is, (hopefully) with more fses going to utilized large
folios, there would be two shifts.

One folio shift (ilog2(blocksize)), one PAGE_SHIFT for filemap interfaces.

And I'm pretty sure it's going to cause confusion, e.g. someone doing
the conversion without much think, and all go the folio shift, even for
filemap_get_folio().

Thus I'm wondering if it's possible to get a bytenr version of
filemap_get_folio().

(Or is it better just creating an inline wrapper inside the fs to avoid
confusion?)

>
> That implies that folios must be at least order-4, but you can still
> look up a folio at index 23 and get back the folio which was stored at
> index 16 (range 16-31).

Yep, that's also what I expect, and that is very handy.

Thanks,
Qu

>
> hugetlbfs made the mistake of 'hstate->order' and it's still not fixed.
> It's a little better than it was (thanks to Sid), but more work is neede=
d.
> Just use the same approach as THPs or you're going to end up hurt.
>

