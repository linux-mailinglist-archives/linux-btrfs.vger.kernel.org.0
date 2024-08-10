Return-Path: <linux-btrfs+bounces-7088-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE4294DF31
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 00:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6C6282742
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2024 22:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135A6142629;
	Sat, 10 Aug 2024 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="WirB4m1Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC01A13210F
	for <linux-btrfs@vger.kernel.org>; Sat, 10 Aug 2024 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723329636; cv=none; b=Eei+SnYfqFO5/N9dz6o8YOgIc4acwv5bkG2Ol0t9W6tntaMyNsueRsa5aGNEaBL7YC94mQNsPWCeJwNvEfnOFESJnFIz2upRj8OwVVuZAJt/IKhdxYQOIpAFo0aECtfyw7ii46IuDVNHSBxaO7fjhuhn1oJcBwUcOkJC9YbZhRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723329636; c=relaxed/simple;
	bh=w2lmWjGxykStF8SPSIUGckd/aKLXMGlv3ybxtbsX8d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVnIEXXZgDQlU0RkUn2pbgrJSf+e03v7a5EiLtQd6ib7iTNVcXvNyiCItl8DNac8FgcrS7DR4qk7vmakrmcRZkswFlGbJ38w0Ww1F7n9J4fD23YEHnmzzyczn1A3XYyOoG4Rlud1cxwR+DWlgn5oPAOybLzBd4O+4jIuDV2pUBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=WirB4m1Y; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723329628; x=1723934428; i=quwenruo.btrfs@gmx.com;
	bh=w2lmWjGxykStF8SPSIUGckd/aKLXMGlv3ybxtbsX8d0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WirB4m1YAhS99Ocw5aYW6NxZ44IGrRv48Xm0Vn8slyE7U3i9xNm6XS5I/1xUuBE1
	 4yPdn0L0u0cqEmN3xpF72TS9driiklrYvNsBs/vkqrUD+pXRQ5T6oWABgrOwENpae
	 /zwjpV0ozyMoEUACp+Y/jRotW9yKukaWQiJEPln2jWGxbYdBmII4qgXZRfkXkgJUz
	 pN2jTPK8+te4ABmh2E1xkcP7CXa7vuZUSVv0mgDTaE19tFCN1C03CZp64lyeqduJ0
	 OR0c/3uwCLHvlxPmy0k0NYzoNknz6WV3n3kc0e2f2P+8w0Vu5thlKzrxyoexugNbF
	 feI1oUZye0Ktrjd/mA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mkpex-1rv0lg2Cpr-00jJMs; Sun, 11
 Aug 2024 00:40:28 +0200
Message-ID: <df13dc7a-88d5-4769-b028-3c5c28c29698@gmx.com>
Date: Sun, 11 Aug 2024 08:10:23 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] btrfs-progs: add --subvol option to mkfs.btrfs
To: kreijack@inwind.it, dsterba@suse.cz, Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
References: <20240808171721.370556-1-maharmstone@fb.com>
 <20240809193112.GD25962@twin.jikos.cz>
 <f9492406-1fc4-4801-a74d-890353a34e3e@libero.it>
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
In-Reply-To: <f9492406-1fc4-4801-a74d-890353a34e3e@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1gTXNvKdsBTvBFtkuZ3NB9PwJSKTTZRvmd2jYasL7CaXSXvGJ9z
 LCMKgdiU6V8rWgMcrcYTrMELf2sxxB5se26ybEAahbOIEqFr0zu1ChcWJCNWumFimwuPOyK
 Dg/dH5Xf/jbfh0UbNzEe7U3zmUemJsyod/5e/rstMrk7PHo6c9dTSfFnN/QYFfmMMafRG42
 6ak0ostjbXVcGDhBa/+Ng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SvsnYoyl75Q=;e7eieq4qpfR3Y6WgcXgpR4pbFoO
 pbq+j/ezyfvVBy6zTgYhZT1Ip4+51uqYt057tU1cddN8WsE5hYXOYUF/Vtrdsvy+wO9JTLr7b
 vkj8qJZR8cgqmMRPQ3npGYR4AZ0mAM+ia/RNJF9JkwvcHOREmA2M7jvtxnY2VUy+/v4/XiSyG
 3QCnNEFo4dUD3vA98ULAejnk+JMidI1UuZCfpHxZlVVau1U6tqJjAWWipF3jDutL4fpJEj09T
 cpJfVKRFRuWYOLF9BlAGWaxQv72dVJpYZx388BoicKtebyOUT+hm2jLYa7HYy6Id3WEV/14DY
 axnZgQMG9DgeDihOFDLgyYHTcUxo+a7WRBeMF4/yhNNtn/ezCpue3JeERGCJjzbrqQR95bX+9
 42y0TVkOhc955KybtOJSpnUqCHzlyasrY0v4nefMo84eX1U3UB3eH4feM1Grd5rMoERbR7VeM
 344q31b+t4SGHsa3o9JVcSKRX1pxqBX02DLr35MERq5xH8bKizY8kcovp1Cb+IkZYT19Fj8mo
 4CP5yTRI1vH0LODHj6Y0cLRR20jZG30KMMt6+h5lmOuAjxV7YyNqkM4GnXGlSNjyFQUvjG1Ib
 wxZG8DCBAcSVy3/05SsdFcwbczF1sbfZHyO1C/QH15Ey67OEncm0ByLkVt3zsTHwoC1AG1sTY
 R9lOUhP6DLxj04qz3Vv4RBrvLQLe3QyJGEKD9yIrYRlRK8VX8jVtSTP+R8ctFinm+zjid9PI+
 qQk63xuzlfNa2yJiD3PCXUPQyb36iYY5toXR4zeaybnz1BvdGWF3R/uzQmnC04u/9N5S2E41H
 ZylVzHmbErYd4HI6/TuMKygQ==



=E5=9C=A8 2024/8/10 19:23, Goffredo Baroncelli =E5=86=99=E9=81=93:
> On 09/08/2024 21.31, David Sterba wrote:
>> On Thu, Aug 08, 2024 at 06:17:16PM +0100, Mark Harmstone wrote:
>>> This patch adds a --subvol option, which tells mkfs.btrfs to create th=
e
>>> specified directories as subvolumes.
>>>
>>> Given a populated directory img, the command
>>>
>>> $ mkfs.btrfs --rootdir img --subvol img/usr --subvol img/home
>>> --subvol img/home/username /dev/loop0
>>>
>>> will create subvolumes usr and home within the FS root, and subvolume
>>> username within the home subvolume. It will fail if any of the
>>> directories do not yet exist.
>>
>> Can this be fixed so the intermediate directories are created if they
>> don't exist? So for example
>>
>> mkfs.btrfs --rootdir dir --subvolume /var/lib/images
>>
>> where dir contains only /var. I don't think it's that common but we
>> should not make users type something can be done programmaticaly.
>
> Can we go a bit further ? I mean get rid of --rootdir completely, so
> a filesystem with "a default" subvolume can be created without
> passing --rootdir.

Personally speaking, I would prefer the current scheme way more than the
out of tree subvolumes.

It's super easy to have something like this:

rootdir
|- dir1
|- dir2

Then you specify "--rootdir rootdir and --subvolume /somewhereelse/dir1"

This is going to lead filename conflicts and mostly an EEXIST to end the
operation.


 From my understand, the "--rootdir" along with "--subvol" is mostly
used to populate a fs image for distro building.

If you really want just a single subvolume, why won't "--rootdir rootdir
=2D-subvol dir1" work for you?

If your only goal is to reduce parameters, then your next question is
already answering why the idea is a bad one.

>
> However, this would lead to the queston: which user and permission has
> to be set to those subvolumes ?
> So I think that we need a further parameter like "--subvol-perm" and
> "--subvol-owner"...

Nope, the current code is already handling that way better.
The user/owner and modes are from the rootdir.

Meanwhile your idea is just asking for extra problems.

Thanks,
Qu

>
> BR
>

