Return-Path: <linux-btrfs+bounces-11090-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D919A1FFD6
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 22:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DCBC1887504
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 21:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB2C1D7E54;
	Mon, 27 Jan 2025 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="LIm4+7jL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6BE18FDD2
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 21:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738013575; cv=none; b=LrBlduak0qf+LOVDzP+IPRY4AmyyIzM9W2VHo26gE2Uq/Sz4zr8rmvmUs288Y+v/unoexHBfKqM/JdzOs+l+MQl+0++auN67cQ7gI4a0+Bb8nibukROCHt9Wq6ahNXIo42m6kM5trpNz+HqJ9usD1VP+wEvO3URiAQnDmTMfNtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738013575; c=relaxed/simple;
	bh=17suldc12iiD/RaaILgYbPC8f4PiKjzvkHjobUnV9/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nReKluNYNvQ9+UcVhD50HbHM/l5QaE0xv1hNtFPrUjZ2xPpHooR2kGEOPLduNtw4W2lrCI/ipdk9gzR/OBrpGQTK8F3rpqWwY3/yhJ3K0YzYcaLPpZufZ3LEj0YbgOfB53r6WCo8ZjSuZH4W7CAlcdwp/fwcmhhhqASW6u2kCdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=LIm4+7jL; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738013570; x=1738618370; i=quwenruo.btrfs@gmx.com;
	bh=qfCSez0yyCrAbMZ0p2zCToN8/fvR+cyEoYuotJpNKIA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LIm4+7jLV19eoPtJ8IsbIL9+uW3nS/LWitNk42KuwEJlq/kAeXbv/b7RLPjnkUco
	 YhEDxWtdCA8tc6nq1olsdVYiwgOpQ8A9RwGKwn6zmZtqqC2cImQ9g7ppVbT8ylBq/
	 sDE5/kQGUgZN4jyU4EjSgc0ZQBu4fbQzgnyh8JDktnTo5CNWNs9MwK2zL+9XXzpUx
	 wwzNuNuVS/m9CDWxTZ8QxXhrXOyD/aPdmyPQJJqSJ505xQOwTokNfblLQNTeVll0/
	 oDcwLt8dBZwxR8evRzdauTN7dBjwPb2Zwg6n0ULWl+PZnqbdWtUEiushe42IM95RO
	 39uhL5XK6nEsxcIUuw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVeMG-1u1j7e0RSm-00QlcS; Mon, 27
 Jan 2025 22:32:50 +0100
Message-ID: <ee3482ba-ced9-4833-b6fc-9b0e9fbb46c7@gmx.com>
Date: Tue, 28 Jan 2025 08:02:47 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: some questions to quota and qgroup
To: Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>,
 'Btrfs BTRFS' <linux-btrfs@vger.kernel.org>
References: <PAXPR04MB855864623B37A9E3F25267EED6EC2@PAXPR04MB8558.eurprd04.prod.outlook.com>
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
In-Reply-To: <PAXPR04MB855864623B37A9E3F25267EED6EC2@PAXPR04MB8558.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j01oAP5yFqoS7Joq9z6L34d4sW2226w6F1q6/04DbhnE6mkTaNs
 NUlGKSZGBD2EuDHqvlCfRW4nBO0/+IH1NLEX4Nh+rN+w0JKvA1B6hAF3oApzZO9WgZ0I7+w
 HSXZv/pyIGGv/IRDCjcE9u95gIC4VVvnIGc5w8vwt2cvQRaV03lDSCwyvoIxGtezUphegdu
 hep0T5HZXuNqPjhmwDygw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ppPMXUbX2+Y=;qmKRpA6A6Cb7UfN8lbP8+stj8Px
 6LSKC4AEsCu0tzZvNKQcNWJHKWYbuHJF5gOYWqhX/kgd6GDFzTlx6iwr8hKZSYobMEy670LhT
 BJkKijToO4J/WZcoqSda42i9+E7aHeFMcrqBM/Q3gnGHgQGgr+VmeLnYnX6i1rvEhfzHcR7Hq
 QmyDCObKh64ozTDSUUlkvcbvADMp9xecH4VN0idt/NWzEF4gy2OVsZ/5I8KJ1XYS/4ICRi7i6
 GuWUWzgWWnwCjjkOkOLIA32enlKx5i1Paf3chZ4y/iX/zmz5DayAkghJVwf0F8HlMu0UplmE1
 uk++UWaO2lggfvOYCTypaFMFueEGAlBNF8/cTrMFOarRLfDpeWtcYM0u8hlqZDAe3ZBTENMWx
 j6r1FY+4lM9UsEd6JnmJlaeY5a+qqf3VQ4cE6IFr6WWmauYG0BhZIVWXEk9NZzIk2bxQJmL13
 T4qqAJUfaoMAitRCFYDS3oDLWQtVKalwSkTB/HM25MDOKNhxk6M22ydbrVmVQ0e4at3isLpYg
 g7CG0YS9CfL6Amjj0PSN2lATJQX+HNJ3hCVqgTQ0r1Jf4ia7Jug1cYLs0yYq1fq7GKZAWsLZh
 DKj8i0X3R99HNG7MAThiLEVh1yIM5lbIsR2L6g7rFbsfe1MT+1GTeQGRcrI1wkh3AuQa7nDoW
 uUU95YsPZnx5MV3fZwSJ3XstzdvA8Ni5Exug7a66X08gjCVTJThqjXE2ZyajeHInWtWJYBi6F
 iKTmQxoZzcxRsE2YeqINGYqoXlWUQsNch2AdyhGwU81kzyib9ATfQIgoAJ7VYq8h6fwkfDh0+
 G9NYmM7oKn0hVW5znAL5lMijEa9vG0MOlr5MekJu1x8yFklyFw61hOe0zDz88h1RETbOmw3nF
 v12UmFW9uEilE6NmU6kaMP7/q0zxCyD5Ckdutwhi7Nn7CsvcAAXAu3YvY3yl2vo8GeMzAXOa3
 qCSHhYMsP3Adg4G08QkJCBE5XP+zXY6P/UuIzZlm6JaPhWAPrhmmJU1YT/krz+Wzvn0/bUInm
 DcnX691Sfie+iCf9TxKOER/uO8UqBuEkB5Lwofg9tBHTkCDZFT2MjieGTyGx2rXskoLDVVk2a
 B5n31MNyCfNoYCzgI3QD3XZfu0/fJT8Yr9spcJfLrrxuJM+bN6CdVd1k5Ykmxp0vHk7pkmBvS
 CQ8v7Vi27dIgrz7zHN78zxCTfwsDNfMXAfLUra4rn7A==



=E5=9C=A8 2025/1/28 00:57, Bernd Lentes =E5=86=99=E9=81=93:
> Hi,
>
> I'm using BTRFS since a while, but now I want to use quotas.
> Why ? I installed snapper, and snapper creates quota-groups for the snap=
shots.
> I'm using Ubuntu 22.04 with kernel 6.8.0-51-generic and snapper 0.9.0-1.
> Reading the man page of quota I stumbled across:
> "PERFORMANCE IMPLICATIONS
>         When quotas are activated, they affect all extent processing, wh=
ich takes a performance hit. Activation of qgroups is not recommended unle=
ss the user intends to actually
>         use them.
>   STABILITY STATUS
>         The qgroup implementation has turned out to be quite difficult a=
s it affects the core of the filesystem operation. Qgroup users have hit v=
arious corner cases over time,
>         such as incorrect accounting or system instability. The situatio=
n is gradually improving and issues found and fixed."
>
> How is the current status?

Depends on the kernel version. At least the latest upstream kernel,
performance wise it is much better.

But the cost is, more frequent inconsistent status.

This implies the following problems:

- More qgroup rescan is needed
   The most common situation to result inconsitent status is dropping a
   large snapshot.
   Other situations like creating a snapshot with higher qgroup will
   also mark qgroup inconsistent

- Limit and basic accounting will not work until the qgroup is
   consistent
   This means qgroup limit is never going to be a hard cap.

> The host will be used for computing scientific data.
> How big is the performance hit?

Depends on your workload.

The qgroup performance depends on the following factors:

- Number of modified extents in a transaction

- Number of modified reference for each extent

This means, if your workload contains tons of snapshots and reflinks,
the impact will be large.

On the other hand, you only use subvolume but without snapshots, and no
reflinks, the impact is small and you may not even notice.

> How stable are qgroups?

There are still corner cases that may lead to some minor accounting errors=
.
Thankfully they can always be fixed by a rescan.

And maybe more corner cases related to the inconsistent status handling,
again will only cause accounting errors, and should not corrupt your
data nor crash the kernel.

Thanks,
Qu

>
> Thanks.
>
> Regards,
>
> Bernd
>
> --
>
> Bernd Lentes
> SystemAdministrator
> Institute of Metabolism and Cell Death
> Helmholtz Zentrum M=C3=BCnchen
> Building 25 office 129
> Bernd.lentes@helmholtz-munich.de
> +49 89 3187 1241
>
> Helmholtz Zentrum M=C3=BCnchen =E2=80=93 Deutsches Forschungszentrum f=
=C3=BCr Gesundheit und Umwelt (GmbH)
> Ingolst=C3=A4dter Landstra=C3=9Fe 1, D-85764 Neuherberg, https://www.hel=
mholtz-munich.de
> Gesch=C3=A4ftsf=C3=BChrung: Prof. Dr. med. Dr. h.c. Matthias H. Tsch=C3=
=B6p, Dr. Michael Frieser | Aufsichtsratsvorsitzende: MinDir=E2=80=99in Pr=
of. Dr. Veronika von Messling
> Registergericht: Amtsgericht M=C3=BCnchen HRB 6466 | USt-IdNr. DE 129521=
671


