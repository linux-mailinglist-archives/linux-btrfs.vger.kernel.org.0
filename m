Return-Path: <linux-btrfs+bounces-22272-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIYlEVVaq2mmcQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22272-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 06 Mar 2026 23:51:01 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD2C228667
	for <lists+linux-btrfs@lfdr.de>; Fri, 06 Mar 2026 23:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43E27304EA9E
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2026 22:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9A835E93A;
	Fri,  6 Mar 2026 22:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="PRNmG00T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA9B2F361F
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Mar 2026 22:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772837452; cv=none; b=hgPiV8EVUrIgg/0DQIZlCjq67ZkZaTUl3PhAn9dlSVVatYB8r7N8tZKEJMumTYP8dfbNC94v9T3fOEey+wM7v2gK+ohIlzVKajG4DegwPqTQquvs6kkaokApMPt0XYXLa/FlDoH8+y6dKqIBEACj7FBPV/7vozdyo/RoQjaSHrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772837452; c=relaxed/simple;
	bh=cnjhMJxOU60kj+JSpHWbE/UdYJSo3LvyAeidz8pqEDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CG1Kh8CzSx5qlrhif47z2+PYgaRuODJFM39Q6lLPeZ/L38iWaZ/5YyLPwUBk40MNA6BTctmeATV+XSXQaxptK6+5pupJ1LN+WTA311Rh8iW/ExtukUA+QiL5OXOy+wws+sXUzLKpKSiQgoiAEspU9aq68xoAgaZc9Mv1e1Kdm38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=PRNmG00T; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1772837444; x=1773442244; i=quwenruo.btrfs@gmx.com;
	bh=PWNtRC4jkIk0VoaQSZgN4oe0aVxAW12UxL/vb8IY9Fs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PRNmG00T1GdCmPjCEtUQahE5zQI1devzIL83wlgaskyIagFKVVQNkPni3YpsPr3v
	 m0gGq9e4eo+JyQGG+IiniaGBAPurgfG/mIrnPBBmlyntB6P+490X1SLXcQvGfHvLD
	 Rau14ml3BX2gWMyRAvzOkQLecLlTZOG8oe3PkTDweUrN3Hn2GxF8slEWtZ+y3iXaI
	 tPld7aGHnOm2IDGUWqdgHxG1UnQ9snD+F9ji6bz2LlFb3amoEsoTHi8aBKRpbkf2c
	 +97Pme8faWNfRrQlvVadIkJ89P0STNdIVSawsA5feGeMJ1GhpKiGsRQvdh79IaUUo
	 3g9TdqQn3F+dzJ2t9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MkYc0-1vFABZ1I1m-00ZMnI; Fri, 06
 Mar 2026 23:50:44 +0100
Message-ID: <74f1dd2a-3ec1-4f02-98bc-091e097eee07@gmx.com>
Date: Sat, 7 Mar 2026 09:20:41 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Troubles translating root tree's logical to physical address
To: Robin Seidl <robin.seidl@fau.de>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <7e9c5666-645d-4b4f-9608-a521353c54b0@fau.de>
 <b5bce92a-f1e8-4137-ae9c-df6980702095@gmx.com>
 <59b45b35-e67c-4f54-9710-fe91fe9b0be0@fau.de>
 <5b0d277a-68b5-43c0-a292-1f43ab30d207@gmx.com>
 <b5e287ab-0979-44b3-b919-4d26189de520@fau.de>
 <DA85C45E-E46C-4E7C-908E-72A4F3592F90@fau.de>
 <348efe08-a9e6-499b-a283-17eb90978e91@gmx.com>
 <25cec577-3e4a-4fe6-a94e-8ecdea3736ec@fau.de>
 <3da8df9d-bd8c-4194-a416-94f3450fd38d@gmx.com>
 <55ae2781-de81-4ccd-8bd1-7af4449ebb15@fau.de>
 <39e1e1af-69a8-4591-8310-2a659dc1e03c@fau.de>
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
In-Reply-To: <39e1e1af-69a8-4591-8310-2a659dc1e03c@fau.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RfFTtbF35MA996Y8TN8umEO2vTO0tDD9TuKkS+C5rAU00qQx/0q
 pLd+KLjB6OrrEiQQymopqpyJWstA3K3stmgf8sFlcVPmFQIt1cKH5D50geve5mDC+E2Gkhn
 1FaVdzv5PlALXEHE+70SCZVkM3YVq/5sgqxY4exZANKfOZVPEsll8WNMnyvE8vSQM9V8K/t
 P5hO192DXxV2Rx4r5wi5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tSTjuO3mtoQ=;gDL+yvFNMrYpLIMtS0MS1XBiCZQ
 2TnWAqnJQdZopK8CP15A45CdCtLbq1mASeRJv9eYYN69tSlsIOJI8SpZbvGtGP8z3z49HSTJ+
 iaBvA2WDPDOoIkZgyEsvJZZ1+xfTlP4t6K694gmdotpKM+uyc9myVElmOxq5wfVohS9BSVGQY
 B+C26++7e/7Y/68RGkgHVjkhuhJxdm+zqpkaZ2D0sT5UTnsEISAmW6rX2PMTi8qnHeLYqvvI2
 ht+e2J7X/bVf2yEf7Agpjxx2ELJJByzJSU1sBk4x5eYx+KVuOrNk8t7CKdHc+74B1/xaDW6we
 jMgTdIC8qyvAgdCndohDEfdDv/FEa029BV1qlx6SWQq1rdJwmZinnNu9R00dgqiUq7A2kd67y
 VCDq6Q4RrRt2Nw6h88qlU5tb8ujedbvyJlCMo/x+JZ3av8oCQOZtffgIeGOC/JY54yyTzMA+2
 VE5DDcvECVOh89FBpAnxGoVFkLqd3DyrlKq5ZAaNtgRPY8ZsszGM02rc2fwS6TRbPiJmvBxpF
 qfie8N3tOIxBn9/XrFSbh1ygk7pz1jokako+KaqpHjJJkyqwhXCXt47BeWxDTAvLmyymPlExJ
 Lbf3WsVq7sp3aPsP43dwjCAlxyf+tm9vx+e1zVfE6AvKX1fWtFrC+3KhorCWWzpsutHng6B8a
 /MO5VgdgPjdev2eZBjzdCaoDp99+YYQXxqtB1vchppnadi/wWr/J83C/QIpIDC/tBvJtC/z0I
 bfnJxbDMJ5odi5V9lYaTfsp7KLPmUHgAUNjA0+Z1J8Km2Ol70Fn9mx6J0mM0jZoC8pZqFCNUf
 MWPnTKtVTGcy0m5OAwzNFQGb3428dGHIQFEyGjTeuJhzOnW5qYCbYnhXPlXMvu4LuA0MiQ6JL
 gyafMt+XPwrMceslHQBsLW6N1HMHJZdzNYuRWtpO5UyvBkCmYkp+rMnSa3qFL2zNrLeqRGmqj
 kGGnpUF20SCxepZlbUj6Ti//wXYi5uRF5UMyGyqz9ORe/1ER+muclVF93NFCuxZr2VFGFrNhM
 SMB5ci60ccdYHjOjtqAOec1//Ib8vf6qbTzaSkpsvQI7Nji1X4Dz+mCBGkHxXauHZIOrfoTLk
 NoWqjmyPCMQqEJw+Fb6VHT+Pxzw9JO6XMYr1YLjkfhT/2J76iolXiqj5XspwwRbsWA2GDqRuS
 1Ca4L+v2Y2ATipOIHHTq8HOX0mkoAcqsUM7RUHcSGe2K1+wcnYPLG3dQBzQdAyjlgh0Nq02c7
 XBfK8Agut/dSPcFpRYiAC+L7fZqGq+lZD6ECGn3JdwMBCpgEXfU6iCp6BuYMCtP8zZhU99aeB
 CxGZGj8S/bRawwjrSYnGqC8ZduxelxVdLPVGyHQF1aIfyK0avTvBzJX6A+p04/QZZU9oCJDTK
 /wNDz9PGUksLZU4pbK0s2iAC4aQ5TUGI5hceEmcCl+lgGEiz+KDuS5k1vR6kcLy5CTkdYmG9h
 x2hZt1bGx89Le1ZQCrLRMxfwWMcb0JMoSanErO0CuBQQddCRoRvFyZUknM5MBeOzK8YdrmE+y
 IE5998tZPAPp3mWAWnLy1cuDQNinF9l/UzKFrrmY82WhENW7VzCQl9YNbyrSIWK7AITr15I9e
 lL1tKNz4ZTGQaTBbbyUEu9Six8ea4n9ZojoE8mUktYRt19QlazQrGk1oL0a+tn2bd7ln993Kd
 6ZysqB++anTTfs48R6OxxlFSPOn3s1f749E4FqhSGhgdHOLS6LxTfVA+PNPg9DY05TpuIZJFJ
 pAmussY7t3hcvX1Y6aZsTLizrb+TamnkWpmqaO8oZjtcGy6xmh3CtfUsiqgP1KEU0o7K36PyH
 g1ETUvSkx1twt+GWhqfpMKf04HpiiFO3hbxtkDZHf6b6m4AAqO0T12IMASJBf0ekmX9snagxO
 C+b09myZeLPjuYNMILHRnjfB1tRnEB45zyBC8KZI8UPNbIK4iPj6cwP9cDdrTerqQ4UwwEtIK
 jbw1C4rlv143NGkj2O4RDoFIIexR6flwjhspey/9U2pTUTg798XlU01pntUiDuJ9+xggbWEoZ
 6HHd5uvVODUeUN9IIznqJh+zgBLCoGBbJRlrqX2i5/FsGfYV31hAUrdb/a7uglOHVWQcFvtM1
 Yy4UWU7bkYLSET/z5H8Q3qOdD62BGPbSoU3V8YJCuouHum7Lq6TzDpK0Qs3HqX6AOTS2ddVs9
 7M2p5frhvKcK2nvXUZvQOms1yutZcboOvh6hIm5Vgo55K8zBdTxjZF1Ewt7C4beEmAl7S+fpW
 cGjUd5/Q2Nqb9QdbKSbZ/w09ai3HP0PI7aWuA0FYNYsJFZVI4LTlzBT7JhU21QtU480ZH+z2F
 ICoI8fdGaQHurIjf8f6ftUgl+f+gY4frmS55e+dahwbv/zIeeMxS9jW9SFEXIIw8DZh2dRim3
 O9tbvgoDqBx6WKs/OY8RgqVXDwwLfGuW+1thXDBuwl34ihfZTwtUygBqAAAOhx+AH4zB0BLzu
 M683BWCP1QhLmvnJ0y1KETcyTTv+X+jHzh4HBCX25RG/CAuA9ZELE+mvT7wcuN6rlEXCF44ot
 wbM00tmIw0vnsmuN2wZP3KLQekrxUMuWhAvDG8iF4CsKkwMxYB2o6Zxb6uSQ7GdtM950B0UAf
 jsD/q7KcRL6e62L48mMgP7/DzvV9TA25FGMf4cOzuL86t3dAIBZfzEFxpBuVTjYRrO4xTSNf9
 7ZsPGmfOyOwNHo3+x0wKo31XUTjl+s7fH0SwplDPQm/MFTq3/wbf9YNwUymcZCCc8uHQzWHv9
 xSnLVc+LeulmTfiW55bVIMVAAnSjnRe/cmyKiY9fgNLIDWr0KwrtJM0Kvx7xDCTZ5ayhlZEJ1
 dGsSoqWw6MmEu8xaDcIE1PnKdJNS8g5LZso87AqJ4AR9ONUnR2blssll5XkisFDUS6FBePDSW
 P1q976+14BDTmR1pvVDL5H3hOTSTR8d5CEhVHqtDsxn7pgUujO9w2HgKQ1AVLPSBKHJcpTQGZ
 t9uBIbFet/brjJjTFEtKT4hkgdBTQ7P0maid98lJou4nkVNnkLNFFfiESiuYVxhPGMEHVxwG5
 Fk8/LKeIN8xVJU7/iqA/EcVfQCoXBkIuLsHbhPc2BMxuwvA58Kc/0VRH1Wfs5q3gdEfGDd8oO
 QZHUhk/KkxcoHsFCUUHmxGCb0L+3dLTBK3Qx9TYR0SiS/lQAI33u9Liq82jiyhaGRAUt93h0L
 NfyxMTN//Igo7dtBd1RF281siKvm7o6cu30r5UIQYhR+ad8V+/Px1RDmb09NstuM4hPBsYVRb
 1weLdC8SdYHznX0iMInHPwg8zNyFLsrLTvXp6r5Do+GOs6i4uvnxyoHy7KTCJYqoUYcB67d8b
 mlEJ6D3N9xceq2GQ0ciQ2+v41TzQnRTkSWb8A0qsdevOSBTRnlhtzaGQci+K4HfAXcVxAxXuO
 q1PRIUtiSHxKM6tdvZ3K+nfjYgHDXWCA4XsPm14GdWq7/9f4JMooP0s+M8tVpWerF7JGzaEBW
 Oo2+MObMAafJxEuYr/SmG48KIU7DZUObMScO92CqC8XYNusR2+vwFehWj+uCc5wbibi/ayqlw
 MwGTHexvqkD+veseTs9JUxD7z6PkctdiyRRDL8PCRK+VluI6+d91cTlA5p5kEMaJGpvFO5/7A
 +Ngghs+k/FVb4FNVMuR/uxneBZ7iAUw93RO4jPsYGoUvaXGWpjJblKhpv5l4wk4SBbIoc9mCU
 6pZmvr32/LxIHlUZPwZdmNjTfmaqUqDoTicU3VFZ7Ngh3pV3A1gW1iPUfZCPHmbulTvQRXZAd
 LPaWPbO92bC0s14ARG0JE5J0Kl7JerPiOj82sdVgQ3/Wl5m4F08CkwFTy7W/ybS6l1F9lXrgV
 dgw3/qZYx14gkPnoz0iSDOKT5vWv52M2Hh0uvypwSe2EoWnVxeT+YO6VAbwZpzQu7IVdrN+Dz
 GIWjdZyUoYJH3/wErm1SBVc0zrSsU6UqCGmgYQrKd1Cjahtb5xpbDnFffe8FQ+QCfBFTvYKt1
 ViZ5xOM7EpOPMsBxNzSGFvyk2L8dchS22gPNNeCnGRvGxi/gywVQsNIoL1vEMrdugPi3uMxt3
 CbJMkLxhdDnUvXzAMmu8St3PvFljujywipqnl7SGIOrKwcI1eZlIt6Y/baY1aitFPx0ZnU6dQ
 D+eyPu1qBHihhBzp14C1lET/2bQCGJkAx7BD7I6j5kpa1ypGDYtSWMJGkM9gDgVL94PFNn9vJ
 TV+VPVtOAaCwW8mViDSvbDDgrsvWMiMVAp9YaTUZ3AL7CL3HNx9JwyXk70wZrIQaKgkbddBVA
 gu3l8kjGcXyu0SsAJFdTOuSyHFdzqsWhPau8MuUMg0WkgkFb982VL8VxuyggZe/E6zHJtAFHh
 unGBu4dbtJW9sRuK1Vbu77+YLEDcYVi5ErUpxfmE9ms/WFPyuwLGRzNqHPc3a7UfkIKMQXf32
 3AKxXft25CRz0f6TGUqPXnffGSLsMkfxmDQKFUZNx7k/E3kpUeDk8orswb8zpfzQusqIev36n
 ATCOcIXnDAt+urZBY6X1VbSSNLK0c+sBUoq+lrhMFN1up2ehjas9MfprjuLLjCBz7TFZSl5E3
 DVDH3nmJaFd8lwKuqio+DeppSgis4a+03J4q5L+RTg0ifHMV9J2HnS3kiqpF/FskkTQGSWEC+
 sUGr/xXVotFzFKrGQSm1jQyXaleK3104QRsEMwPQP4BMN1HJmPMTyemj0tJxm3FM+SFxp3kqf
 eIgd2G8j5XmNG0dT+qnyZ/f+sW+4kEZM8hoc0dafeabU0oIpez0VTx62NdppaucVK6F94CVdQ
 UlIqPOv6mppbDGFjz3g/XPV5usmQ39YBiL22HwyBOlXFcp7Tv6gThiCRtmjU83cWd/7cnc7Tw
 d4FlkxLpDYxdeM7lgBqktRqxzayIZXQdPXGTVGYfQebtFYoQBYfjW4whfbxyWbJAkkweL0d9P
 CEj1OI5ply72/mKG0Tfk99blPg+CIyBEjDqkS6JeSOGVYg5pAVx8U6jwkTHuKpy8+PP6xjaaU
 lYimHE6a3zC7UgZra4wonIroLMiIoP9tZwHwxqQi+2dtQEXCDjhTGQp3Rnp/BZUswHCpjbvcX
 tyVTBXxt5eQue92pwhBBsYE7h5maahhkZzvghGdnd6wTquBGZ0JtvBoEhQr1vhJC0mogahIqh
 JELTjf3Ja6K11l26BE08wlTZ/xayYzAlnEZ7siTp3YIBFMlrArhJGlqYCteuNqQpzoxVCDQom
 a1yvGz3aABCWMPKZFh/NikUyDADhJ
X-Rspamd-Queue-Id: DCD2C228667
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-22272-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.904];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmx.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,btrfs.readthedocs.io:url,gmx.com:dkim,gmx.com:mid]
X-Rspamd-Action: no action



=E5=9C=A8 2026/3/7 03:32, Robin Seidl =E5=86=99=E9=81=93:
> Hello Qu,
>=20
> I'm having some troubles understanding the chunk allocation process.=20
> Could you ellaborate a little bit on how the size of a newly allocated=
=20
> chunk is determined? If I remember correctly, the maximum sizes are 256=
=20
> MiB/1 GiB for metadata/data chunks, but in smaller filesystems those=20
> sizes vary a lot. What are the rules used here? I'm especially=20
> interested in the metadata chunks.

Although the chunk allocation is going very complex recently, the=20
overall workflow is described in btrfs_create_chunk() where the core=20
functions are:

- init_alloc_chunk_ctl_policy_*()
   Which gives the basic limits like max_chunk_size.
   However the max_chunk_size is initialized elsewhere, it's
   calc_chunk_size().

   E.g. data chunk can be as large as 10G, and metadata can be as large
   as 1G if the fs has over 50G writable spaces across all devices.

- gather_device_info()
   Gather the free space and the largest hole of each device.

- decide_stripe_size()
   That's the 1GiB limit comes from, which only applies to a stripe of
   the chunk that's going to be created.
   Thus for multi-stripe chunks like RAID0, the resulted chunk can still
   be larger than 1GiB.

   And also where the 10% limit comes from.

- create_chunk()
   Creating the real chunk and its block group.

So overall, you'd better read the code, with some experiments inside a VM.

Furthermore, if you have any other questions, please also send it to the=
=20
mailing list, as I'm pretty sure I'm not the expert on chunk allocation=20
and may be wrong. In that case other experts can definitely provide more=
=20
helps.

Thanks,
Qu

>=20
> Cheers,
> Robin
>=20
> On 3/5/26 10:59, Robin Seidl wrote:
>> On 3/5/26 10:51, Qu Wenruo wrote:
>>>
>>>
>>> =E5=9C=A8 2026/3/5 19:32, Robin Seidl =E5=86=99=E9=81=93:
>>>> Hello Qu,
>>>>
>>>> I made good progress since the last time we wrote, but I just=20
>>>> stumpled upon a question I couldn't find an answer for:
>>>>
>>>> After the creation of a single-disk 1 GiB FS, I dumped the=20
>>>> superblock and found that the `bytes_used` (147 456) and=20
>>>> `dev_item.bytes_used` (132 513 792) don't match while their=20
>>>> `total_bytes` counterparts do.
>>>>
>>>> 1. Why is that?
>>>
>>> I didn't remember the detailed explanation of sb.byets_used, but it=20
>>> should be the total logical bytes that is utilized (aka, all data +=20
>>> metadata extents, before any profiles duplications).
>>>
>>> Meanwhile for dev_item.bytes_used, I'm pretty sure it is all dev=20
>>> extents used on that device.
>>> And one dev extent represents one copy/mirror from a chunk.
>>
>> Thank you, that helped a lot! With that you answered my second=20
>> question below, too.
>>
>> Best regards
>> Robin
>>
>>>
>>>>
>>>> 2. How do I have to modify each of them when manually (doing tree=20
>>>> manipulations myself) allocating a METADATA extent (i. e. how much=20
>>>> do I have to add to them)?
>>>
>>> For metadata, you can allocate a new tree block, but overall it's=20
>>> complex and you shouldn't do it directly.
>>>
>>> The easiest to bump the size of metadata is to create a lot of inline=
=20
>>> extents.
>>> Inlined extents are stored inside a metadata (tree block), that will=
=20
>>> bump the size of the corresponding subvolume tree very easily.
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> Thanks,
>>>> Robin
>>>>
>>>> On 12/6/25 04:56, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> =E5=9C=A8 2025/12/6 05:52, Robin Seidl =E5=86=99=E9=81=93:
>>>>>> Just a quick update: I figured out, that the offset field is the=20
>>>>>> first field of `struct btrfs_extent_data_ref` and thus they are=20
>>>>>> overlapping. Is this correct? It seems like I get correct results=
=20
>>>>>> with this method.
>>>>>
>>>>> btrfs_extent_data_ref::offset is not always utilized.
>>>>>
>>>>> For TREE_BLOCK_REF_KEY and SHARED_BLOCK_REF_KEY types, the offset=20
>>>>> is utilized, and needs no extra structure.
>>>>>
>>>>> For SHARED_DATA_REF_KEY, the offset is utilized as the parent=20
>>>>> bytenr directly, then followed by btrfs_shared_data_ref structure=20
>>>>> to show the ref counts.
>>>>>
>>>>> For EXTENT_DATA_REF_KEY, it's the offset is not utilized directly=20
>>>>> but as the first member of btrfs_extent_data_ref.
>>>>>
>>>>>
>>>>> This is not easy to grab, but unfortunately btrfs has a lot of such=
=20
>>>>> usage from the early days of btrfs.
>>>>> E.g. btrfs_file_extent_item, which only part of the members are=20
>>>>> utilized for inlined data extents.
>>>>>
>>>>> I hope one day we can move away from this stupid partial structure=
=20
>>>>> reuse, but move to a more structured layout.
>>>>>
>>>>> E.g. btrfs_file_extent_header for the shared members of inlined and=
=20
>>>>> regular extent, then followed by btrfs_file_extent_details for=20
>>>>> regular ones.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Robin
>>>>>>
>>>>>> On 3 December 2025 16:08:39 UTC, Robin Seidl <robin.seidl@fau.de>=
=20
>>>>>> wrote:
>>>>>>> Thank you very much.
>>>>>>>
>>>>>>> In https://github.com/kdave/btrfs-progs/=20
>>>>>>> blob/745e510b6c82829b9345699db323b9a615a9f539/kernel-shared/=20
>>>>>>> print- tree.c#L565 the `offset` field of `struct=20
>>>>>>> btrfs_extent_inline_ref` is used to determine the pointer to the=
=20
>>>>>>> `struct btrfs_extent_data_ref`. As I don't yet understand the=20
>>>>>>> underlying extent buffer you are using, I wanted to ask: relative=
=20
>>>>>>> to what is this offset (in other words: how exactly is the=20
>>>>>>> `offset` field of `struct btrfs_extent_inline_ref`=C2=A0defined)?
>>>>>>>
>>>>>>> I assume in https://github.com/kdave/btrfs-progs/=20
>>>>>>> blob/745e510b6c82829b9345699db323b9a615a9f539/kernel-shared/=20
>>>>>>> print- tree.c#L578, the `struct btrfs_shared_data_ref` lies=20
>>>>>>> directly after the `struct btrfs_extent_inline_ref` which is why=
=20
>>>>>>> you do the `iref + 1`, correct?
>>>>>>>
>>>>>>> Best regards
>>>>>>> Robin
>>>>>>>
>>>>>>> Am 02.12.2025 um 05:27 schrieb Qu Wenruo:
>>>>>>>>
>>>>>>>>
>>>>>>>> =E5=9C=A8 2025/12/1 19:21, Robin Seidl =E5=86=99=E9=81=93:
>>>>>>>>> Hello Qu,
>>>>>>>>>
>>>>>>>>> thank you for your last answer, it helped a lot!
>>>>>>>>>
>>>>>>>>> I am currently trying to understand the structure of the extent=
=20
>>>>>>>>> tree in more detail and have the following problems:
>>>>>>>>>
>>>>>>>>> According to the documentation, the main items in the extent=20
>>>>>>>>> tree are of type `BTRFS_EXTENT_ITEM_KEY`,=20
>>>>>>>>> `BTRFS_METADATA_ITEM_KEY`,
>>>>>>>>
>>>>>>>> Those are the basic ones with inline items.
>>>>>>>>
>>>>>>>> If an inlined extent go too large, there will be other items for=
=20
>>>>>>>> the corresponding types:
>>>>>>>>
>>>>>>>> BTRFS_SHARED_DATA_REF_KEY for data backrefs, and=20
>>>>>>>> BTRFS_SHARED_BLOCK_REF_KEY for metadata backrefs.
>>>>>>>>
>>>>>>>>> and `BTRFS_BLOCK_GROUP_ITEM_KEY`.
>>>>>>>>
>>>>>>>> And where you can find BTRFS_BLOCK_GROUP_ITEM_KEY depends on fs=
=20
>>>>>>>> features.
>>>>>>>> If the fs has BLOCK_GROUP_TREE feature, then that key will be=20
>>>>>>>> moved to block group tree.
>>>>>>>>
>>>>>>>>> The documentation also states that, depending on the flags it=20
>>>>>>>>> contains, a `btrfs_extent_item` is followed by additional=20
>>>>>>>>> structs. I assume that these structs are referred to here:=20
>>>>>>>>> https:// github.com/kdave/btrfs-progs/=20
>>>>>>>>> blob/745e510b6c82829b9345699db323b9a615a9f539/kernel-shared/=20
>>>>>>>>> uapi/ btrfs_tree.h#L815-L839. Is that correct?
>>>>>>>>
>>>>>>>> Yes.
>>>>>>>>
>>>>>>>>> However, I cannot figure out which flags would have to be set=20
>>>>>>>>> for which struct and in what order they would then be written.
>>>>>>>>
>>>>>>>> You can check the print-tree code for that.
>>>>>>>>
>>>>>>>> https://github.com/kdave/btrfs-progs/=20
>>>>>>>> blob/745e510b6c82829b9345699db323b9a615a9f539/kernel-shared/=20
>>>>>>>> print- tree.c#L500
>>>>>>>>
>>>>>>>> For metadata btrfs_extent_item::flags it has=20
>>>>>>>> EXTENT_FLAG_TREE_BLOCK flag.
>>>>>>>> Otherwise it should have EXTENT_FLAG_DATA flag set.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> What also confuses me is that some of these structs appear to=20
>>>>>>>>> have defined key types (https://github.com/kdave/btrfs-progs/=20
>>>>>>>>> blob/745e510b6c82829b9345699db323b9a615a9f539/kernel-shared/=20
>>>>>>>>> uapi/ btrfs_tree. h#L237-L251), which would imply that they=20
>>>>>>>>> could be identified by their keys, like the main items above,=20
>>>>>>>>> instead of by the set flags. However, a quick look at the=20
>>>>>>>>> output of `dump-tree` did not confirm this.
>>>>>>>>
>>>>>>>> Please check the print_extent_item() function, which shows=20
>>>>>>>> exactly how those key types are utilized for inline case.
>>>>>>>>
>>>>>>>> And just around the callsites of print_extent_item() inside=20
>>>>>>>> __btrfs_print_leaf(), there are other print_extent*() calls,=20
>>>>>>>> that are handling the dedicated keyed cases.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Can you clarify how exactly I should read the contents of the=20
>>>>>>>>> extent tree?
>>>>>>>>>
>>>>>>>>> Best regards
>>>>>>>>> Robin
>>>>>>>>>
>>>>>>>>> Am 17.11.2025 um 11:01 schrieb Qu Wenruo:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> =E5=9C=A8 2025/11/17 20:05, Robin Seidl =E5=86=99=E9=81=93:
>>>>>>>>>>> Hello,
>>>>>>>>>>> I'm currently working on reading the BTRFS structures without=
=20
>>>>>>>>>>> mounting the filesystem. I am now having troubles translating=
=20
>>>>>>>>>>> the root tree root address to a physical address:
>>>>>>>>>>>
>>>>>>>>>>> I did the tests on a freshly created filesystem.
>>>>>>>>>>> At 0x10000 the superblock begins.
>>>>>>>>>>> At 0x10050 the u64 logical address of the root tree root=20
>>>>>>>>>>> begins. It is 0x1d4c000.
>>>>>>>>>>> At 0x100a0 the u32 size of the chunk array begins. It is 0x81.
>>>>>>>>>>> At 0x1032b the sys_chunk_array starts.
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0 =C2=A0 0x1032b to 0x1033c is the btrfs_key.=
 The chunks logical=20
>>>>>>>>>>> start (u64 at 0x10334) is 0x1500000
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0 =C2=A0 0x1033c to 0x1036c is the btrfs_chun=
k. The chunks=20
>>>>>>>>>>> length (u64 at 0x1033c) is 0x800000.
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0 =C2=A0 0x1036c to 0x1037d is the btrfs_stri=
pe.
>>>>>>>>>>
>>>>>>>>>> This can be done using `btrfs ins dump-super -f` to print a=20
>>>>>>>>>> more human readable output of the system chunk array.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> When the logical start of the chunk is 0x1500000 and the=20
>>>>>>>>>>> length is 0x800000, then the logical end of the chunk is=20
>>>>>>>>>>> 0x1d00000. This implies that the root tree root adddress=20
>>>>>>>>>>> 0x1d4c000 is outside of the first and only chunk.
>>>>>>>>>>
>>>>>>>>>> Just like the name, system chunk array, it only contains=20
>>>>>>>>>> system chunks.
>>>>>>>>>>
>>>>>>>>>> System chunks only store the chunk tree, which stores the=20
>>>>>>>>>> remaining chunks.
>>>>>>>>>>> What am I missing here, how do I translate the logical=20
>>>>>>>>>>> address of the root tree root into its physical counterpart?
>>>>>>>>>>
>>>>>>>>>> Tree root is in metadata chunks, not in system chunks.
>>>>>>>>>>
>>>>>>>>>> You need super block system chunk array -> chunk tree -> the=20
>>>>>>>>>> remaining chunks to do the bootstrap.
>>>>>>>>>>
>>>>>>>>>> If you are not yet able to understand the full kernel=20
>>>>>>>>>> bootstrap code (it's more complex and have a lot of other=20
>>>>>>>>>> things), you can check open_ctree() from btrfs-progs.
>>>>>>>>>>
>>>>>>>>>> The overall involved functions are (all from btrfs-progs):
>>>>>>>>>>
>>>>>>>>>> - btrfs_setup_chunk_tree_and_device_map()
>>>>>>>>>>
>>>>>>>>>> - btrfs_read_sys_array()
>>>>>>>>>>
>>>>>>>>>> - btrfs_read_chunk_tree()
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Qu
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Best regards
>>>>>>>>>>> Robin
>>>>>>>>>>>
>>>>>>>>>>> PS: In the wiki (https://btrfs.readthedocs.io/en/latest/dev/=
=20
>>>>>>>>>>> On- disk- format.html#superblock) there is a typo regarding=20
>>>>>>>>>>> the start of the sys_chunk_array as it claims it starts at=20
>>>>>>>>>>> 0x1002b.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>
>>>>>
>>>


