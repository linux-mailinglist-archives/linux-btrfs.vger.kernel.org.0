Return-Path: <linux-btrfs+bounces-12514-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F8BA6DCAC
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 15:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFA23AFCD2
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 14:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5AF25F96A;
	Mon, 24 Mar 2025 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b="m9poWi8M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48FC1CD1E4
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Mar 2025 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825700; cv=none; b=YuFITN7Kfqn+ypQr/uUp4kf6jxKiOwt9t6di2rTz69FpSPBZWdKKhCbFgd9tj4b/0kW3jzdSfXi4pWpR3GH5vEr2DalhOs+dcb1WOMqRoeduo39/r65aJA5awuTWAH9KebabpWfhym15hpM3sIYCYeVyHUX9lwJXdAz+gt+rsbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825700; c=relaxed/simple;
	bh=FjxDywXSA6/kxO6EoFhguKA1l9XsTTpSalYwSKaehBA=;
	h=Date:From:To:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Dz06pLk51MCobYT6pjtFQwQlo+nz8Nu8eUMXHqR3skAp97E4LQ8onUXdOxpGz9sJiP2mwXyPCFSYkybYUbda/oSy8tfOpeWrRHEHexAjjAH+ngdpXrjyq/JGQNIEc9EMdMW87+kiwzSgkA9l1uSqx7aSDZOtPi7pLP8sYXql4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b=m9poWi8M; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1742825695; x=1743430495; i=jimis@gmx.net;
	bh=1XcBo3BDbLHAbqFl5RNvEnlmDuaYRj2wHiDKNgD61tk=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=m9poWi8MB4+4bkJVNxKjcOtziaY8mo8zY4PFpErkYvAXoW8tAuPaPDhsYl3NX6at
	 sajMxK570CfN5Fry4S3TZXURknF1jR8RMlyi9jfaYUlep01bunx7VbOu3gUgqR0hg
	 F8mXIvW+zmKde2ZRwU+hQgztEwnm0+zGosCOanxc/QRc77mAyXFKLcVzGrzcZr/KS
	 3lWlyg9smmPRdUw/yMCVkG2OQkE7z5rRinfqvIgvziYCMTVC7m1jj8KNPXOfr4sNr
	 SFjurPLM5wtcPonB2SopFl2cpd4hhUoniRt6/Z64vPlTjNF0+lbRVsD905pQ8RCcc
	 jHDbk17stW7OmEnyqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.9.70.81] ([185.55.106.54]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4QsO-1syoP32n4w-017m82 for
 <linux-btrfs@vger.kernel.org>; Mon, 24 Mar 2025 15:14:55 +0100
Date: Mon, 24 Mar 2025 15:14:52 +0100 (CET)
From: Dimitrios Apostolou <jimis@gmx.net>
To: linux-btrfs@vger.kernel.org
Subject: Re: mount compress=zstd leaves files uncompressed, that used to
 compress well with before
In-Reply-To: <2f70d8f3-2a68-1498-a6ce-63a11f3520e3@gmx.net>
Message-ID: <d1c2f041-f4f5-9dad-511c-117ed8704565@gmx.net>
References: <2f70d8f3-2a68-1498-a6ce-63a11f3520e3@gmx.net>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Provags-ID: V03:K1:2OPiJzxsM9HvTvVoyt8qkigif00hIU3xDaMvqKEx6y90TL7/kux
 Qu41LR1nkAzYp0tsFD3yYkuzJ2Ca2HZNAubu5BMY39EMkILv6Wx8tvBqXx1dLw7uTwzwzFv
 Vv6ECaFg6sBinbIsZRKVcpkXW07ii0Rm0e+/fNm7YR44qhODLKiBgY9Li8PdtHWoP7mUade
 1jhgOb+pde2KNTq/sGQBw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FRC3v1c1hQU=;pGbH6YPBLRys80xTvJcEK5PdVIb
 U5GZZTAjlX/61VzCE9vIWHByTx2r8/hNoyF68KvI6MXCdtNhrC9BLetpOKgrKnCAUl3qvwHpt
 Ivs9wsDSP38b6HjYpKY47gri4J3YVU5xj5BWJYOlAYLrYZOr5MPcWsTqJWEbkJzNlykd6UgDn
 VCwZ5ydFI5HMNy+phULGDTVonXxE7pnoCQDYgHW5G4bz8aM998JXKTXCaadZvMXgAuiXdMiK2
 2d2D2BolPxljFcVLD59e465OVSenvKN3HM4l2lNZQ2tgXDvtgeeK1qBPso8FBtxjQ7q0W592y
 rB7OrkqoqknzFzprVoHnat1TuD1U7bft0crp2qcwBIBkjv03Aac07lGBCDhA/XNBhMg31M/Nk
 go6lr0EwgGSvHJGdcz3opiM56gOShdeNCS6YA2S80a5SEE7SgkvkZKU+1cMzL3fADebAeByCL
 4/a0J/JvzEQ7zF8RjDsYdYRcxryh9sqwadGcr6Ir63riCsy7ZUpMzCsyaEnOhEMtT5wvYNKx7
 6n5sbzKrDjdIwoyTsUOP0qMb/6OF6FcX1qrdxwvuF3yRNuf+reCWv2EwcMwdkNPCvua/j2RPK
 Z3rWjb2CwCWbmcCsbBCPoL5vtZFQk6J3PTjcm+jjCl9CoXZDWNNESA4NF48tB89S/3qKmlq3O
 qFko+ttVcWK8HMqE2MZRRUfkSk6zGZwJdP+DTs9ibEBP5hicYvdXyxgbwI9VQSDvW8wefcCq+
 JpllFmmjND19ybJes1yPI71CBSx7aNhwQvMm6ErF/SdAGpZBvET6vM3Mn+Z0qd1ulr+NTo21x
 OM/zbkYMCHhY32KQUYYcH5K+2z5CZIFLj83gdRWo5a/9Pz2/vVV2eVz5AwGX+kzt4pNCYtPdn
 qZSdcyGHzZNxeq/pYwPK7rh0p3vde2iu0xMbKMrnUZNIwbG74crSI/BgEW1fMfhGnXib1ckyh
 yJ83YMzDhQPk5LWXNzJLOPnYIbhrwBixKhDYtBfns3kXAiQkqsX0WqtiRnA+OePD73nKuBum8
 khOTGgMcpvBwdJEthZvlgYofzh9zYID2i/J+yjBCLO3ZrtQ8XSDeZs5UBoXFYnAyjmR7b8eXd
 MOTr1bKijcSTAlVYjdXzqRrNnfy06HBFMDJVQxC3TOijnzvEZ8OQ3Q3Rs9r1/Ok/OHPj/lDFf
 uMh15z0+aYFH0Ese4M949BA+iqsoVOdNq7ED65dH2Rai5qo8Ply7fzPv60nxUz7UT2SqR5aeR
 NbHbM/nUrv4A/UyzSTsXD0qeW2yozL9uVVkeXfaGOrpoYE3omSKb6+TXomOy2C8/yzKrfRumH
 NH5gnINYRCVuPLJaMa44fxBjbS4PnAjlMTCkwfld+9kl5RwjpxI3ToEdaBOFZL6aZ8Ry1pMRm
 NAt8caie4FoX/PXbLIqYlT3Kzq/q2xBzIhX1ZvsNNDj2PxgTAZ3074GHhIKgATTMZKOmL8DKB
 SdCQAWXddnt8OzCyEfh1fyOWJb8w=
Content-Transfer-Encoding: quoted-printable

I keep seeing the same odd behaviour. The database files are not being
compressed despite having compress=3Dzstd:3 in the mount options. When I
issue a defragment -czstd command, everything gets compacted very well.
And then as files are being modified by the database, uncompressed extents
start appearing again.

This did not happen before. So has something changed between kernels 5.15
and 6.11 regarding how btrfs detects if a file is compressible?

How can I debug this further?

Thanks,
Dimitris




On Wed, 19 Mar 2025, Dimitrios Apostolou wrote:

> Hello list,
>
> has something changed lately in how btrfs discovers if a file is
> compressible?
>
> I am moving a database (pgdump|pgrestore) from and to a compressed
> (compress=3Dzstd:3) filesystem.  And while on the old host (kernel 5.15)=
 all
> the database files were highly compressed with almost 8:1 ratio, while d=
oing
> pg_restore on the new host (kernel 6.11 with newly created btrfs filesys=
tem)
> I notice (using compsize) that most files are being written uncompressed=
.
>
> I have to issue a defragment -czstd command to fix the situation, and I'=
m
> contemplating whether I should change the mount option to compress-force=
.
>
> Thanks in advance,
> Dimitris
>

