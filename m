Return-Path: <linux-btrfs+bounces-12800-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBBFA7C242
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 19:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 409877A6E84
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 17:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404FE20E01B;
	Fri,  4 Apr 2025 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b="WaqgvHh2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45171D9A79
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743787057; cv=none; b=pqVWUxrPvXHPZfXbw1Ty6pSNrHAkx67tgOErfU+zyVXd01VB05QCFxRUNlOksmeHaxc7fObcpnI8VxBZlThFee/fG2ivfbUt4MsEmZWbjl5koC34QZHOecmQApiJUwwnO8jphpwCG5d+IfSDBUep8lRD0AMy0ht8Ib5oiGZ+A/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743787057; c=relaxed/simple;
	bh=Sm8Uz9+CxFokI5O1lpb8XokPQyRH9AWSVr1+qRcSwlA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X0Q9zrHJRRyDqB3oXa9LbVcXPSh0uafKgtyh3bqTLiY5xWJEIPbe1SxvaYYMstB7opb2jm26N8ETD6+eGERoSxdZr2cFeeLLo0QM8VKoQvElhLWeT0/k6LsCDFMnKLvxxCcunNUAo8w8h1ZxJ/4KJzM/lrvIcTI1baaZEFzgx+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b=WaqgvHh2; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1743787052; x=1744391852; i=jimis@gmx.net;
	bh=Sm8Uz9+CxFokI5O1lpb8XokPQyRH9AWSVr1+qRcSwlA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WaqgvHh2h9QE1Ez3zGaip5n4FMMpvzmqYFX7n/4RjksnJPx3IofdfiKfvEnJHwqu
	 A/YDVkSZleWX9wNfOgoxWDSZ8aOkFvXaA5HuA6m1KQIEgcyQk/evvEchuJ23fml/Z
	 Olt5EPiYsifEmAebZfBAFXjYs0YuPoSDVbFax2J4G9UakPgzjDkGJamwm4YvtnYq5
	 isC66OzAbM8giCFn4IdE2GXRxYWSBag0Tq5fEggaT5dL89/p77hJ47Jw7LxV3yZS1
	 Y27jdjpQZB+XlNLPXUJY+cWSJXZp/aaNnxyt1todiaQun8SNJcAk6jaiZXYDvY3tr
	 GP3YXaUNkaneWAK69w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.9.70.81] ([185.55.106.54]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2V0H-1t5Ws72j5L-00rjGm; Fri, 04
 Apr 2025 19:17:32 +0200
Date: Fri, 4 Apr 2025 19:17:31 +0200 (CEST)
From: Dimitrios Apostolou <jimis@gmx.net>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
cc: linux-btrfs@vger.kernel.org
Subject: Re: mount compress=zstd leaves files uncompressed, that used to
 compress well with before
In-Reply-To: <61996eb1-de0d-4d9c-b1cc-b24145985d38@gmx.com>
Message-ID: <5c7978e6-ba04-9aaf-e32c-788f1607254a@gmx.net>
References: <2f70d8f3-2a68-1498-a6ce-63a11f3520e3@gmx.net> <d1c2f041-f4f5-9dad-511c-117ed8704565@gmx.net> <8aaba46c-f6d5-4f3a-a029-f564b8a6a9ff@wiesinger.com> <2858a386-0e8c-51a6-0d8a-ace78eced584@gmx.net> <2b33bf94-ec1d-4825-834d-67f4083ea306@gmx.com>
 <ba2a850f-6697-7555-baa4-32bc6bf62f81@gmx.net> <b9f7b83d-5efa-4906-9df3-a27f399162fb@gmx.com> <d6abe471-8144-3f13-1002-d55cf7d3e672@gmx.net> <939a6f4a-837b-4613-8761-b03f8d4809ea@gmx.com> <b338d808-f691-9969-9e48-d4a9f0363af3@gmx.net>
 <61996eb1-de0d-4d9c-b1cc-b24145985d38@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Provags-ID: V03:K1:WBrkO60lhi+RWeSV4dYoFsEmkEQFbzEfqSWa72P/M3Hk5yqDj+p
 lZPAdAXoHrmxkJ/pDBRwtyqBblsTRFeBxfwL8pP34C+mFxZXb/PEXhvSHHK1UKwKK+mcoDX
 FV5IW6KeEAcn63f8vSQXgL+lpwNnvY9ksbYLMfmvSfsRmmlKRIpo7zTRA/bkf7ARTpHSeM7
 V6qN+elMpQNWf0bJBwbcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rUkTkVcW5JI=;iSu/Yoy+vibbNytPSoUQddA2PVc
 xL9+0W+JNXwrgoHrpo1CLSDi1JJiMswm/R9hfacZ7Nw28oUoWqvYyxra2letaQK39LgJaHNL1
 Xnqd91UTYn1A65bnSW8N482PjcsMPgnlAF40tRT/ytvVd2GrCyVOe21IhHkaj9J9He2S71y8S
 lL5Waxh12StzQUfPFsJzwrNLBEuGhzMfQlFgQBP2CSrikG8psQPsNwugDjuTiDoul/mRW4Rv1
 +2tcEQSoeCDc4FSYUXXK/JI502AOIJHtZL9byBdDsOtIrE9WRZFgAloH4RgYCB4eeZW7K8Q9U
 7Il7eOTiLoXl5ndMEFYIinWtENA3KL4PLIw9nYNwTDNTBD5xVNzN1i9ONhfd0fHyD5dIKItaM
 /vVSY/TrW0Dws97IwVi8oaR90txRvdbh87+WV9AWMd9Ve6OcoxrI5XX0K4MR04JZtyF8i2FYb
 tBBW5idZtOkshLgg4fCSJSax4ei8Z/dIWG4K5osTcbrIAzn9u/xb0yOZfUF52Cr/3IRrttD69
 n/NcwDLGeQaCb7k/pDOkXZYl9fDHrb2in15CCsId+OCL1lGk8DeT0M4NxFIP2uTSCoWHrPn0Y
 6EoIChLhauxFLNREiyvzwewnKgOtW1q5ugfttzx/YAJlMPpVOefA1+G5QaMzRZyUZ+h37sLib
 Ua3ASJ1BdGSAh/IjV52IXpcYBifxIgH9SBK1/0IXJxTKUAuMSryDKH9kQBGwDl1aFlSg2rBYQ
 TthwI9KBiHtdS1CBCe/wtL1FJpWRU7UUa6iQGOm5WLyeytg3uygSYpZ3/1OlySV3Mh1WS4O6O
 X6VPsM4TsOQxfRusB6pBiQef7QYn++JXX1bqZEnYABJ/nDkrUhbY6YxkGwXPa8vwRfpTu3oOf
 vSOYhhC9yzENCY4k+Z4cDlFpzBxZqkFZwGs/JU21iUQ8+CCVKZtfYeQvURirIonaxnariHlZI
 RJLrjofThXzmd9wYkv/+HGW6+rvl3skxIYXTwy6ZQt9svnHRW8KMGaelv/OZLqCqZxoaNt2F0
 MVYrx6RWvX8L31xhKHRflEvXtlmDb2QXWJS1S7qm9OLeJ9j+ugnaOewnE3bWdKVueNO6mNg0Z
 ZTjSAP3gScUgwRzD+B/ZIOVmapxhUVP/Qfce9EJQG6Ew+EOzUOHLYvH9pRWO0BnxQSgINy5iD
 q+2r0t7x6rFcgHvc0v1lHsEVa1jnj/HNDIxnp+q3xLiJpfaaLXjw++svX62Yk55/Zzd31lQTI
 kHouuKtOAT+0JwKpdqTjc2Wsu152tD0srjrCZTOxB+6kiV9EnxRxXUuj6FdphkSHzYbOrAu8T
 nT4V9aSsrQpvfC8FcqUqw18qF3sQ0IYBcVMUQCHGK3XxM6bazL0ZsPLaJVKYZKkPy0aqma/9l
 pdKvEbRetbLFqfwU4X6+YqKK3VmRyik7nkLiM3q0KXzQQXwXu9kK8gpM/tL/U93TMUInleFys
 0/JK26w==
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Apr 2025, Qu Wenruo wrote:
>
> Looks good to me.
>
> Feel free to submit a github PR or both patches to the mailing list for
> more review.

Forgive my ignorance but I thought I did what was needed. I notice now
that maybe the subject is wrong. Do I just send an email with the same
attachments and [PATCH] in the subject?

Thanks,
Dimitris

