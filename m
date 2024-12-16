Return-Path: <linux-btrfs+bounces-10435-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 175AD9F3CAD
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 22:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA43C168148
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 21:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDEA1D63ED;
	Mon, 16 Dec 2024 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QwxJBKNW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1171CEADD
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734384048; cv=none; b=CIvN0CRJOufr16Omn/IosgKZiRxgVO/47ZtcSiLVTSsk1jd7eRnkEY1vGpQYRTl+DccfWbFENcGZgfKAznvRBcsgfnnUVjvcb3U85att6Q7OcdJe9a2MwxpeBzCkeo4cIZktZDJL8RK4zE7dszkkXOK8QRZL8+cfxXioMHm1Tq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734384048; c=relaxed/simple;
	bh=lG7FQaxVOxsnXHRWfGocTmeta6stMZ8lsQuGmgndH3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eFZ+QeLFUMpk4US6BJEO6ev/TolXNbEubNmfMhqrPeXaw7fx21dUX39jWPrXf5L9iygEZ+G2URW6w3YeIdjsdBKzA/5XYQCnT+07GEwoVedZabAQXdIo0XG793I0YVOp5IE8d0TZAn9Pt0ZlvD2dGR8tWrnb0LO4uRA3y3q09dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QwxJBKNW; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734384043; x=1734988843; i=quwenruo.btrfs@gmx.com;
	bh=rfbD2JN8aRJAY7lNVuPL7roe4z8qvaS0A1AgeTa41ww=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QwxJBKNWFAuoGNYOdzSH3He/lKNP/N0+T0cjKsWf2Ujpkj7JR2GvpN1eCCjYX/1T
	 dOnCfpzXdZfwOTXjhMH+MfG6j3ZId3d56t6H+lS3FCJih7kbXEm8vfycF+xIqG8Px
	 Wj95+aiY1e3T0OFC+MouPnzULb1yVUVeegQPMkabFu7pN+zuIt/YQRjPzQ+83ujSU
	 qvjxENIoy1f7nXBft+4FS1m2dZ7FYgzi2Zr3s+MDunrcTy1aX9T5chxvLJmyJeqKX
	 0cW4fGIvaDE6BXASjEmFN/h695eoOn5/7qcdgAy2LRn8Bkqrlki9T77M98i+rhXfI
	 3Yj+aWiuwcQJvvshjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfHEJ-1u3l0i1IM7-00ncB9; Mon, 16
 Dec 2024 22:20:43 +0100
Message-ID: <5b02e350-8c28-42b2-8ccf-8ce76b4ca683@gmx.com>
Date: Tue, 17 Dec 2024 07:50:40 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] reduce boilerplate code within btrfs
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
 linux-btrfs@vger.kernel.org
References: <cover.1734108739.git.beckerlee3@gmail.com>
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
In-Reply-To: <cover.1734108739.git.beckerlee3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FiapYHNUCfDUdHraibtG4l6DQxUoXcUoYi7cxs1NcfNJ53xPHZo
 qzmdzgzdJtmC5f1moERKJOjj+4b4khsEIEPkzVx9mAxSXsmij6iAu4bldKe4epIr0tQsh8p
 JNg6VfqqDvww/lHXtmu4nxWx5OUjhvDZUw1UbDwTqrsk8DjsELVroWFH1czteIS3DwlXgp+
 N7Z4ame96ZFJbb0AwFSpA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bjs2XJDskmc=;5zZDKgDKDjhx0v0yh/YxBuaoF3r
 UnORQbWy+YJN4aSvRiwHchtelwRm7ig17lQO3XnE96fiHsbI/K5QWZqE5CvpvynXB9B7cn0Sx
 bxSNdp+DFxDBXlWQiyP54xHz8a78MP4amE+43682XzC9MJtUqooPRtxZlKRCLu0fpI9SKeLnZ
 fAsywOlMYpAYfNrYpv8Oe1wEuJrc18if/D7ur7CTSee5SmNycxb2XYgdhf8YqX9Y43ME+2Zld
 Tm2OdcW0pUG/lMV2QU4vjyhUenvoipBZBqcRLEtCn47THfywTWs0WtW4nvgs7H0TxSYjzGNRx
 Y7zXumCf76TKaTtmbuhbp2Mb9zMY13qrOt8ajMp7UGlatdsEGZwiyaMMFWXQnNhQF3PYNQmD0
 5Cqzl30WfpkEsHKKTAMxkgCld9IKFxtwiNANkHUjJE+VsAQFGd3owFmj1u0K1jeb4pMf3eOZe
 9lW+XlMFW1P4b+mRQA+pUuhOvRLnsr68OMkfSdBOngfWyeFx+Z8pbkQlJnqYq5W2j0Z9sRuVx
 0zbUQsuYhsluGd6nP7edZTpWRAxBRSRpmG04D+6TnBk098ARGhdWadCO897wDx7T5kq5At3t0
 4IPHljiQPlGWv1Iteemyp1cehFqfXoyCLag/fEJpiVxuWRw69xLBKLLeB5FYBa5lnjsIfy0bi
 n8PP0CLmMjrldd4503G2PHaoeWV4UpMrw2BA9wPFhE8ovSqAK3xYiVGiPxfAgyGLM7OmWFATQ
 4UVkpK9WRnjPA+1nBT58B+X4T5HQZGSq8m89aJ0WjELApLySkmfqpiwP/0O82nnHUxAyxlxtr
 FoEO4ypbjFL+hLEOnDmq2eXChb1OSkGv2Onb1Cx+EA+6m9GAdQY1iy64lYwhS3kEPJ1//v1b6
 1dWnZxTIxIe1FKmwtAN138JYycpv9ixhU/kYGFYl8qoEQhlWBhtTXYuQIEtGRRAHMDZOAHyRz
 FQRyVjA4bFSd3afvLi3YMhMk7GSfM/0Ka9RmO5ENCiGlFlodUICZeq7EjUCznLz9lnrdv8t9z
 D9YAHzgHIsuxiYujByo0SGd7NHdfk84cRfCE58+dyLkLDjaBWZsNdCkSVfZVe2svfGywfF1Ey
 SEl6hGBv0HX6Og3BDbO3ben85ZFLDm



=E5=9C=A8 2024/12/16 01:56, Roger L. Beckermeyer III =E5=86=99=E9=81=93:
> The goal of this patch series is to reduce boilerplate code
> within btrfs. To accomplish this rb_find_add_cached() was added
> to linux/include/rbtree.h. Any replaceable functions were then
> replaced within btrfs.

Since Peter has acknowledged the change in rbtree, the remaining part
looks fine to me.

The mentioned error handling bug will be fixed when I merge the series.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
> changelog:
> updated if() statements to utilize newer error checking
> resolved lock error on 0002
> edited title of patches to utilize update instead of edit
> added Acked-by from Peter Zijlstra to 0001
> eliminated extra variables throughout the patch series
>
> Roger L. Beckermeyer III (6):
>    rbtree: add rb_find_add_cached() to rbtree.h
>    btrfs: update btrfs_add_block_group_cache() to use rb helper
>    btrfs: update prelim_ref_insert() to use rb helpers
>    btrfs: update __btrfs_add_delayed_item() to use rb helper
>    btrfs: update btrfs_add_chunk_map() to use rb helpers
>    btrfs: update tree_insert() to use rb helpers
>
>   fs/btrfs/backref.c       | 71 ++++++++++++++++++++--------------------
>   fs/btrfs/block-group.c   | 41 ++++++++++-------------
>   fs/btrfs/delayed-inode.c | 40 +++++++++-------------
>   fs/btrfs/delayed-ref.c   | 39 +++++++++-------------
>   fs/btrfs/volumes.c       | 39 ++++++++++------------
>   include/linux/rbtree.h   | 37 +++++++++++++++++++++
>   6 files changed, 141 insertions(+), 126 deletions(-)
>


