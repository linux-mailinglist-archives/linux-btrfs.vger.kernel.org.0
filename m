Return-Path: <linux-btrfs+bounces-3895-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7109A897B96
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 00:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B0D1C27B5D
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 22:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C93156990;
	Wed,  3 Apr 2024 22:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Tesa4RdH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95FC156980
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 22:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712183029; cv=none; b=gTcul8frWhedYYXduSERy/Un6QbKR57X4xzzKyMMgvQgIK3KW43zWJy6mhXXsWbLNBUemqnFg05j32/u6iEgYNbkBSnW96PEM8KyPTLB8bQjo8lwZi2BzNIrsFI+970jr1qxtSb4K0A07SxvKjmrK/OHmVByoSKAh1lQgXr7qQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712183029; c=relaxed/simple;
	bh=1rpryuIjs8PDSIx3q4RvjTXqrhaqtw7x9aQisWh//Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BJIkHsDAMymAolDZsf4MwMvdfjJSjj1s1pctrAypRvSoWS26gg81kZrSadhBz8h+uHLHKLnjqDF8Cz56Jv5ngbd8m83M7QdzvJNeSMqp8A/5p2VP79Y0vljL7ImYsF52gsDP/KVEd4KQS3Rtakbih1YN0PLqV2m1hPD32qXdNvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Tesa4RdH; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712183021; x=1712787821; i=quwenruo.btrfs@gmx.com;
	bh=5aKiajEp0AVU1Yf8+z1UQHvtfq3njTAjlSPqNHJKJhY=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Tesa4RdHk6vPMmzyAkS9qcuplKgT2WoBtnfPrhqYnBCLWo0901ZZqFGGvHpVKZ++
	 MtibjW8p3H7REaZrdWOeF9vdSLFMDAXpWb3H1HO2QrYqVS7tg7u1GIIywgBastFqQ
	 DrFfLqC/ZACrdJ3tqagnzy0vwcBwleqfI4wWzy06sO0yXIWZFBHshhzSPzJxh3HUM
	 eZmvAwk5jHuOUninMTtDaKARx3Mn81GgfQsGHZTc8xeL2BCsrSZq2ByGwJkiImGbQ
	 0wLOZlmGBIstXddpU8CusGFRH8CtmFG80zfs/BXKiMfKSOeDcDk3GFLWHwCTBz9Nw
	 k464BRnlDrvW1whcRQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N1OXZ-1speNj10nL-012q55; Thu, 04
 Apr 2024 00:23:40 +0200
Message-ID: <f6627e67-9a6b-4102-b788-7d4bfeec1f67@gmx.com>
Date: Thu, 4 Apr 2024 08:53:37 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs: remove some unused and pointless code
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1712145320.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1712145320.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:66ptLxuTjot2w8EyzO4FFsdElgzhbSSKD1ZSenBLEs8DWg6rSX9
 Jdaj3n8XLILF/DfVEfWCT6PyeH1GkJe8bJLf3YqRBo3vVkZZtSBGFrolJj6p7kcayFLEYUI
 2js5oi1ezTQqyWJYI8ewsy3fsM4A7aztxwjvb2ymQzaY8e+x11MknjsUpRFG9/wlnP53UrR
 HE+LtatzQOHeiVyUApTrw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/aZQEHfy5Io=;YtGILuF7kGKnH91/k1VA2mubaPu
 zGMI5Q+x0rYhgcjqIZhwW/af99CYqwhZELVul0qehyYUkxnV1vZq4SIO5qgVpWS+3ge1i013Z
 BauNDbBohk4s2TVadmq+0t6fwK/neBmCFyjpSSje6ZFCPeSJrekVwAApQKelyyJuDgMYlKLr1
 aBKvYcuXHjdgQF65XawhaBIGr3cD6k0C44s08V1XO9bsrGOmGc+20SVM/fxzsHSPPUqej+SDK
 QTdpeBQFeGOp0Lsbm9MAiKolUcXeD13M/Jt8aUgDne8B3T91kqsEBjgQka/FDSmJ4664kkEW/
 aEr8FLZNNRvVIa5S37AZyZKm65eqBkVnmeFzPFpFid+/eKivpDDEn7+D5ivIMrfX3uLR+0DW5
 ICc6VVzvviqpeSYE2Bbike0N6cbo+JHSybdsnIOi+FEWRvypOpayMPAEh93Mtl4jzDSXcLfZf
 HDtqXUHwL8/shlsc5n8h8+BMW+z8Q5Gan50/ZORjZLERbGuFb3NAWQ8tNtc6EwUBnZI94Iwi4
 8RRjBLCJMhCoJSZ8TXqUFJpAGqKJbKFwVQ6iQK8voM+ZZROOs6pXOVa/4bhJgJPaOKIsFgJRY
 KdvZtbfzKKPUqxxVgA9L2l3ftkVsaO1uLOmtCw9EI03ai2xmmFnnjpk7nWnKzZlc94r3oNOG2
 NQcH/a9CLXFPJ0/WNaWpXGBYSIhaltv+jT1Rvb1G9bwZht+F+qPuOHNFyJyTtRzwmSZ43GF+0
 JnsNx6mUjoJ8f4UtqfVt/wIp23RjHtUet7wffrfliDSxFq1hXpx6DEr3CYKLtxrWOInziTx61
 pJJVggEL4H6WU0cEHSSEfR27Ia4TU+3oflind1+o49/XA=



=E5=9C=A8 2024/4/3 22:35, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Details in the change logs. Trivial changes.
>
> Filipe Manana (3):
>    btrfs: remove pointless return value assignment at btrfs_finish_one_o=
rdered()
>    btrfs: remove list emptyness check at warn_about_uncommitted_trans()
>    btrfs: remove no longer used btrfs_clone_chunk_map()

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
>   fs/btrfs/disk-io.c |  3 ---
>   fs/btrfs/inode.c   |  1 -
>   fs/btrfs/volumes.c | 15 ---------------
>   fs/btrfs/volumes.h |  1 -
>   4 files changed, 20 deletions(-)
>

