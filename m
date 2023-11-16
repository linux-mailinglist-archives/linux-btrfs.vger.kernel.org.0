Return-Path: <linux-btrfs+bounces-163-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0587EE8DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 22:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB065B20A5B
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 21:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAF7495CE;
	Thu, 16 Nov 2023 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=georgianit.com header.i=@georgianit.com header.b="me0bHFHu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uot4c5/r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173E6A7
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Nov 2023 13:42:32 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 6D7FD320093D
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Nov 2023 16:42:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 16 Nov 2023 16:42:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1700170950; x=1700257350; bh=JXyQBftx4mpVEv8UfZxoq4mAPg5yscgE5CZ
	FOxOgTUc=; b=me0bHFHuv8l2DGVWOgtVzKrb+w0lesHFNZxs9NGDo2cBRer2hxy
	bIgqgmGvzk63/y6RHGh6u3x1YjlvO7c4FFI+XEcc7V2JW5AsjpmAaGbFWKNm7PxG
	t+QzcO5/2YnW19qIB1Z9Rvc0l7i1pV037s8IHUZkatSlWzgwzD/XNbGHUQTOlRL3
	e39FVrNtqfEq7YtDlLXL5Z9rhrZu+hs0TlJR8RamtrufkWCBZoKbwLDxQ4wSxD1K
	B3k2PFb8FYkKsXH9bdY8HDOpyOCo4rfredr0dMJnh7me78bVLqdDBFwEXDM+7k4c
	Auu97QazdIC71IXKiiAIdOVV5/uGPWAwqdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700170950; x=
	1700257350; bh=JXyQBftx4mpVEv8UfZxoq4mAPg5yscgE5CZFOxOgTUc=; b=U
	ot4c5/r5sTsKgMzu0Qt0C8mEsgxY5nDV4ZT9hQIyYBhY3c6onTd7ll8F+D3/Fd5/
	ZUQsL096n8Q4sRwS5SP0nOACof9Cc9VAv0crLfe+XdkVuPUVxOcHp97bjJXTjV2O
	mZ60C7FlLQIqe38xJJ2YqaY+0AG7oEIxjQR9Rso5qBr/LzfPvZeynMXap22jj6ws
	ALqRz7GTZKm/FUOZTld6nydwF8TA+1jytRIZze3Y9akrh5iXZO0zI8a/vX/BB6bi
	WZt3vS3lGhH8V70AAOhSuUcfltNfXyEoUFzcyB8ibFFaUQz3iXDfBrJyCs8exlFg
	G85QaxMxechED8kF6wqdA==
X-ME-Sender: <xms:xoxWZZa5Jsgd8UAI5vwfJZX1Ty2QAVwT2T-Dash0VHoCOV8z1I3O4Q>
    <xme:xoxWZQbld3WRBwZgfe259jaPk0ZseQxlCp0x5rIa9_kzXMs3ic0ChF0idiD8yUZao
    fKlgJLRILPrt6_56A>
X-ME-Received: <xmr:xoxWZb8_uAhMJuzrPPuO6l8wpFTCAtZd8Zb7PH5ardrDZGExXK6F594J8JiLuNqJRPj2DLhRnmeUV6dSjcEtm2MDOeI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefkedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepvfhfhffukffffgggjggtgfesth
    hqredttdefjeenucfhrhhomheptfgvmhhiucfirghuvhhinhcuoehrvghmihesghgvohhr
    ghhirghnihhtrdgtohhmqeenucggtffrrghtthgvrhhnpedvffekgfdujeeiuddvvdevtd
    evgeeihfelvddvgfehhfevgfelieduvddtudffffenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehrvghmihesghgvohhrghhirghnihhtrdgtoh
    hm
X-ME-Proxy: <xmx:xoxWZXoqsOrURkCr_zJ8ZZdISgLsmbL-ciF9HvEWslQ4nnL6bDIROw>
    <xmx:xoxWZUp252MlQb9mxdDIHr3hhTFOo4hG-AaiKfjPKbJtM__2AKVxZw>
    <xmx:xoxWZdR18jZLSCXmOfo8wg2kQgN9OmCtSo5E9vaekz3qqW-n2QthpA>
    <xmx:xoxWZaFyVd9cKDgVsZzdjwnQBaRBtDpk4vnEzQdnbcM5f54ziTWuEA>
Feedback-ID: i10c840cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-btrfs@vger.kernel.org>; Thu, 16 Nov 2023 16:42:30 -0500 (EST)
To: linux-btrfs <linux-btrfs@vger.kernel.org>
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
 <47f08d62-3fa2-4baf-9425-17d1f119ef8d@datenkhaos.de>
 <fa4814bc-6f59-46f8-bd1a-d79f4020a2fa@gmx.com>
 <5f6ff1cd-dd64-b88d-e814-39ba3b23395a@georgianit.com>
 <5e33baee-80ef-421c-9e88-d1d541461469@libero.it>
 <59b6ad3e-c16e-4a29-abd4-4d6f57047155@libero.it>
From: Remi Gauvin <remi@georgianit.com>
Subject: Re: checksum errors but files are readable and no disk errors
Message-ID: <65b3acc5-0aff-a7e8-142b-4ad40c60f3dd@georgianit.com>
Date: Thu, 16 Nov 2023 16:42:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <59b6ad3e-c16e-4a29-abd4-4d6f57047155@libero.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

On 2023-11-16 4:12 p.m., Goffredo Baroncelli wrote:
>
>
> If we remove the COW (and thus the CSUM), there is no guarantee that
> the data
> is sync between the two copies in case of unclean shutdown.
> In case of dis-agreement between the copies, there is no CSUM to help
> to understand
> which is the good copy.
>
> The metadata are still COW and CSUM protected.=20


The Complaint I have is the reckless disregard with which BTRFS allows
(and as in this case, is often suggested) to use BTRFS Raid 1 *without*
Cow.=C2=A0 in the case of an unclean shutdown, if there was data being
written to a NoCow file, it is very likely that the files writes will be
interrupted at a different point, resulting in the two Raid copies being
*different*.=C2=A0

By itself, BTRFS does not detect this condition.=C2=A0 Even if you were t=
o
manually scrub, it *still* won't compare the two Mirrors to ensure that
the file contents are the same on both copies.=C2=A0 The exact data that =
is
read back will depend on which drive is being read from.

If this is still the case, I would suggest that a workload that requires
disabling COW on BTRFS, it would also be necessary to replace BTRFS Raid
with MD.





