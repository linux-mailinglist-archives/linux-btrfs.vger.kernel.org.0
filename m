Return-Path: <linux-btrfs+bounces-10520-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AF09F599D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 23:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5E9F7A3FAE
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 22:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719B91DFE29;
	Tue, 17 Dec 2024 22:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hkIXszwU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE678EEB2;
	Tue, 17 Dec 2024 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734475067; cv=none; b=MbVd7p8SR21Offo0IhQp1tw7vRvLXxlhdeE6KPJtGVtm6rvIlm1HzIOo392+3VQJ8myNKlberLY8Hzn7whtJnc3TWqni3x1kjz6uFj1F+hWLYDYpz3uoZJPo/aCBnzYIFUDzXR9H9Ubjm8SWfcn+cpJgwbgpEsaAspAm8m6PigU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734475067; c=relaxed/simple;
	bh=asXCfO7YoUV/btjDDxM4eTqDzSbAkk4MP0KuHvOv53I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/BxNzMl0Mwuk1eCGoBzt2WPTSkiSLj+PGnL/TgPgyiEVXtGWCJM+Uu5++95Uf5nbFKemj/5iCRJ5LiEfD4GFlXbtHTF3Ite3B+Y49VmkE0r5hwqeIsx6Gl0C0NY43cdDicsxod3av8nVKNsvxTnP2dKGlhuE2pBMKHavg69toY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hkIXszwU; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734475050; x=1735079850; i=quwenruo.btrfs@gmx.com;
	bh=b1LVVcguxZLKZtRGKBScvD512zdSDiPLs9YR6RUVmDo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hkIXszwUo02pHKkG2Y2OvOYumseDluawUW40MlXDmLh10zDDVdk6EqAQuE3huBo9
	 WpCmfiRM3Ouhvwf5H1yGpyCjEXIM48AWOpqPIp5RfQQuITbCHSoOo0+AwpQmxsRK3
	 gVsdfM2wHVazM08jzzKlPIKMmLEPsHGk2fp/g1shK9CLWfIiT0SX6T3bOm8AS8WSs
	 ssOC8AKuBEVWiVgdnRLT4LA3h+p8cCk6B3WHYxlmJ8e/e8+XKPoYIUSVghXkNabRD
	 8TU9r1XAkDzA7cCeMxhn/GPOAqtZrlkJlwIfek6ZYcPcvezYWnizfFkwpN+Yyh/TN
	 9QXbpQE90kDlgYNqiQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlf4c-1toSUN2zRq-00k5mh; Tue, 17
 Dec 2024 23:37:30 +0100
Message-ID: <db59d0b2-6542-41e1-abf7-0c38b91cdf4d@gmx.com>
Date: Wed, 18 Dec 2024 09:07:26 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic: test swap activation on file that used to have
 clones
To: "Darrick J. Wong" <djwong@kernel.org>, Filipe Manana <fdmanana@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org,
 linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <dca49a16a7aacdab831b8895bdecbbb52c0e609c.1733928765.git.fdmanana@suse.com>
 <Z2Ey4yQywOEYqEOI@infradead.org>
 <CAL3q7H4Age-k0ifGh+n4QwExC1vTgWGd3NROcX40vQXKRipBqw@mail.gmail.com>
 <20241217172223.GA6160@frogsfrogsfrogs>
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
In-Reply-To: <20241217172223.GA6160@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nChD0PMkvjYXmO04NXuRx1EEYRBEn0LAIEohth+RaTSv3XDy0//
 +n3QD44g4famiq7VMZr7GUgcz/D9t7IOHxSeEp9qCf/el9OwJahRApoWOLxeo0+dlEt/uWD
 VRdW4uqGqOgFh5C+MjI35FUOtHTXehNZdjgGMk7p2QFKYGjGqzKjvG0uvO+y+IfSg0wxJKc
 ySehAkFYDah9aiwhxd6QA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ScDRxlnQwI8=;oOi6rvA3jJq3s9V/JLevLj41RIy
 duXMDSxXDLZMhdblOGg1iIYFifmSwVGgNsVYaxvIFBUalS7OdPj/KRLJicwmiMwA9FIgEj9jf
 FSHcpai7o8weZKyH6ospYXiZAL5oienLA7s1w0XWX73oseX2uaCRmph3mbt1eUMD9eLpKa/io
 pYmrxf7yuVX6js9GsE57XuF8+mDnAsd8kqf+X2iJxXZSayPpUT7x1Umc1R8jSQ+tPE9bHmbbo
 5NFhcY1lnla1v9d1OfsIywmP2om2LfF1Fmw5xGrn6hcnjw569jmL+sjY8En1qNanWhvQPrbHw
 v/iRui6pALSDJwelMbQthELDpu21M/5kpYWDQZgzcuBYhd1WfBlk1Uod5mmmzVLt6NqI/Vlz2
 Mu+VwCtv8HghasuciBnZiWL423fVFchInow+nzAOtIQNshRPcaZlJX6rjPxYVQZvNyky07fcB
 fH8QUA3Nq6hdfGHOK9QS0p5tYgicpUcFcVO2EWtCQMSlpEVs5QaX4G0i1ICmttGXMf9CQCI3I
 au+L51vy0bbST8p4JqKpfBckB/alffh7sa8xninLv1MEBLBPn1gm2imeU2n/J3sZ0+zCNACfg
 oswyttLb2LOJcV5nGQHt5YmcDaYLtqK7gE2j1YNdM/qOhWGr3qGSR5yVj0Iuw/rwdtYBwDvCi
 76YCnd34zeWTFlWtXfm39z0iMhhqVwvgZkENfJyIypiIfVtd6gIdsKfPOq95JnXOKNu6Ielqo
 vYpAfx1+BIxefdUq34lqBB049G9aC9v0PaXu82KGoEP/DjERimHk4IQMYoBQc+01kUL4yYYzB
 LnI6v2nkw5aJrybODRIY6tAml9wl8Ty3HpiA8exKqdUOUykYebYalQ1xLId2a2zj96JbgsPrT
 tNF70KvlDqboPAUXKFwJuAcD/ZkBijXTJ/U4NMJWdlbTsqWpzYN+TAcQ7+ZCQfqGFmna6MxF5
 I9HTBG5aqPg6bSGopEeUuP/CKrNUbxIwBtce3lVwcYyDN86Oy66PxhJo3im+LhoyFyxrexe0b
 hXF5Pg3TSGC9J8ruJvvsOrNFixaFysriO3yThhJ9su+UofE1bTFLbVFw5rIHw3XhE6ifCnyRD
 r2mdEl8f5Kd6/MK9Mz8jtlbD0MKMGD



=E5=9C=A8 2024/12/18 03:52, Darrick J. Wong =E5=86=99=E9=81=93:
> On Tue, Dec 17, 2024 at 08:26:33AM +0000, Filipe Manana wrote:
>> On Tue, Dec 17, 2024 at 8:14=E2=80=AFAM Christoph Hellwig <hch@infradea=
d.org> wrote:
>>>
>>> On Wed, Dec 11, 2024 at 03:09:40PM +0000, fdmanana@kernel.org wrote:
>>>> The test also fails sporadically on xfs and the bug was already repor=
ted
>>>> to the xfs mailing list:
>>>>
>>>>     https://lore.kernel.org/linux-xfs/CAL3q7H7cURmnkJfUUx44HM3q=3DxKm=
qHb80eRdisErD_x8rU4+0Q@mail.gmail.com/
>>>>
>>>
>>> This version still doesn't seem to have the fs freeze/unfreeze that Da=
rrick
>>> asked for in that thread.
>>
>> I don't get it, what's the freeze/unfreeze for? Where should they be pl=
aced?
>> Is it some way to get around the bug on xfs?
>
> freeze kicks the background inode gc thread so that the unlinked clones
> actually get freed before the swapon call.  A less bighammer idea might
> be to call XFS_IOC_FREE_EOFBLOCKS which also kicks the garbage
> collectors.

I'm wondering why this GC things can not be done inside XFS' swapon call?

So that we don't need some per-fs workaround in a generic test case.

Thanks,
Qu
>
> --D
>


