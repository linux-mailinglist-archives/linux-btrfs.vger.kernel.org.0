Return-Path: <linux-btrfs+bounces-12604-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12367A7337E
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 14:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1ED189A59E
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 13:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B2B21577E;
	Thu, 27 Mar 2025 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b="dLSf2Nnn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F82628D
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743082875; cv=none; b=NDkoOH+YKZgYNpPUiT3OO+lbAwc4CHUPPb0ILW1FwrStbEJYFDit1WYuX77pigpqokFojYpt4VG/inCdEfBkU05J7qjcDcPsDOHoRVcUaYzabKRhB2ECmi9RAJUQo3mpihua3c2+IOfGYxj179iKdIxHI03e+zQESNC7kxBwsAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743082875; c=relaxed/simple;
	bh=mmFd/QZgCvHDCyWboEA5DKJ6fb3mxSiy5aTpkIeY8RQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Xrw+MmfAEuyL0oj9T3xuBjxQY6azTx27KHeUta8pNt73JD/hNMAK+659W6KD4+rKdFagxL8CxE0tYVVMFKtgoFgeKJvWZbOix+I8o2E8yotsyeY0CiHOFPvfE1S4XJcTthaoKpln+RwqDRrlUiBpXsGN/nipKWIRZxUYMEqHnnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b=dLSf2Nnn; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1743082805; x=1743687605; i=jimis@gmx.net;
	bh=aTpqXBEFnvrRyeA/dA1xj/GziBSwGY/wzwl2gwGzfig=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dLSf2NnnPgcOhm/+6vj0UvZ4ApqBhuAIHa1qP80uWRJ7qzx4nyyOPymlNJcewZNQ
	 b5+Bxf9eUTwaHWIe0KXq1JTJ2Xr3aMo0I5Uay4lPBahBce9UCWOyovT/Ugw6Bp1Z7
	 +l9Ura2e17SvW0wL0xBGFKKkC5e8IxuzmMKBiGtH0L5ai//t6KWZgjbGg9GofTTlv
	 PPitkaIAWMSEJB5oHIitdb/g+HBzw0/H+5qf0oQMjZoIBWHVNk/fL3Usjn4BqzOYQ
	 O6zN0sDu/eTlihMAlA5CiXvJJzDH1pl5QOvEN0eDWM6XyO7ifWC53XBKqTsKwV64T
	 UJs4Nx/lMMRHhfRBKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.9.70.81] ([185.55.106.54]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHEJ-1tVbW33RDX-00c49y; Thu, 27
 Mar 2025 14:40:05 +0100
Date: Thu, 27 Mar 2025 14:40:03 +0100 (CET)
From: Dimitrios Apostolou <jimis@gmx.net>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
cc: Gerhard Wiesinger <lists@wiesinger.com>, linux-btrfs@vger.kernel.org
Subject: Re: mount compress=zstd leaves files uncompressed, that used to
 compress well with before
In-Reply-To: <2b33bf94-ec1d-4825-834d-67f4083ea306@gmx.com>
Message-ID: <ba2a850f-6697-7555-baa4-32bc6bf62f81@gmx.net>
References: <2f70d8f3-2a68-1498-a6ce-63a11f3520e3@gmx.net> <d1c2f041-f4f5-9dad-511c-117ed8704565@gmx.net> <8aaba46c-f6d5-4f3a-a029-f564b8a6a9ff@wiesinger.com> <2858a386-0e8c-51a6-0d8a-ace78eced584@gmx.net> <2b33bf94-ec1d-4825-834d-67f4083ea306@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1150519174-1743082804=:1515035"
X-Provags-ID: V03:K1:NkFL+WUzRXghKsVc8HbzcVxAYwSYfO9GC/ZqjiZIwKUoSBWdmhq
 /GitRqcNG1RMUu3CUTzCE5By/eBv9AX0Hfyy/50SZLvKLz8BcnRoqEMgtc/4Cl7Yia5aFTv
 tP2OTU1JD9o7Efcc22vVbQZqg4kXqefO6YA044Nm2fwcRCysyf+GYbvmg43sIPvWmMAbC3D
 sv+U2zFJVZnnKEP2oNnpA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k9PB+iGTg3c=;68YqxArqqbIoNxvvJU9BGE5yvu5
 zwVT2/JRy0BRX5Q6KtDwuLjJONhElcCgFpneQ3fu+4DVsioOg+hQzSkT5ba7ywWj/aUa3/U4H
 0pzHH/1t2hwKa80sx9B7ZOnVNtMtBBmEOWSjReBpMSQ0O5kkOWwEBmRySKAZWNp6u7sebY3t3
 hzm/rLzA5AS7wCpaquGOimaExZaHwtVaL/Y6aZj5KEeqP//zG+hisqXLLxxqcLViU/1KbVFQc
 CINeJE0hGv0/teCvHO6zMyi2C8EPfdxN/xKty99FdNZeCnpuUnlSbEwYy0N9XStxgEOkSRLZh
 61febVm2lOyT1+uSbkuvoQvtitWW7to3f87wv/kMl5Su9gAhz+w5o46Czt09+6phEP2zm9Rt4
 WNlTUjZMmzHLvRvNx7r3Jc6KpzqvH36GnXFqH8gJyuynG1aidLXdEZqipvsmHNKs93vVzjcME
 Uqfz+3ts8zMqWGwNvARCF01zCXVt8MxTtcpgoW1ZTOo2QRgshZ7nMwcle7C8+vBAuvdS3Zgsz
 5ShmQ9Y2+BJ97srEBNCJXD4htviW5lCBS0PCAG7JXp5x0YQ361ikz1qsTqgnHkBxMGlQdWipo
 zO1tn+zBMbv7GTLPuSKQGz3sKuUImxxDXgZH/Xj5wd8ERe87C/N44kgpPD6y91FkH02LDotdj
 5QQbFBWRbRORI7UpFND/XKq7KZMi6zOw4PmEb5UsqRdnXnktD02GHo+Wol1TJiSf5L4OfFNY9
 ZKJ1Sm9FUk4lmeDKe8I7QQxT+PMfS70hODAJBiNXY+7GiZHS7eF0BoHsE9BI2rTZrC1W9upPo
 6kKoMqMgkw8Gp06iki8u8L7bbQLpp3OP0AXv5BFbg5XiRXRIKrIOyEbP+0Cnj+ahitNbLXOUH
 Cf6FdemRoErwMIoTAkpKpGdHLcsZt2nHZfeFF7xteQbbr2Prmqy008l6OoZxOYDUXw3de5dA8
 Q3moCMqOTkpdpl6oVN2TW5ry1KpC1v4f01Z1rhSZOxAqhc8lF9ZFgI0GIKtr0S7OCVWyk9UqG
 R/nwIqrKBnYLuOpbGxlE/Rx/ke2YdTM/btqNU5+l5KEQuMVU0zv+OOfAuQWFiFuD2RFi0OFpi
 HJKUGF0CwXJmm3Ek02H6j1VXfXUFhwOzgcyLt7QBs4UqIy8ZMtnEsgU1h5CmvZ2QMXXum9B0k
 jsbH89DlvjJiWkcpZa4oc8Oew8tqss7MMwC9oNYcJb7lsoxx5MnIDY49FSkqEKfksfVAGSd8U
 RqZmencpKiWS1IXVpnZlBcfbgz76RVFn+HnRavHuMhH3sWOh4mkIXxVe7886cipKBttX4L/0M
 Nqth4nau/HNhvnijqPWs7Exfvg1ZTgh6JqFN2TVBQN5z20XtzWHMdlqkqiJ6Xi8nQbxOTZde/
 JOFyf4BiLRA3aLjO3FqB8yuOHi8boLqVstIG1JaOMq+t8PblPVkQnoCDcClohPcNoBTET4yhg
 sgPbvjvXTMeS23fMOY2gUv/uENf9bbh37YbZra+qpKlJ96R5fwDD2rkL5SupD+GCPY/WOQQ==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1150519174-1743082804=:1515035
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Mar 2025, Qu Wenruo wrote:
>
> =E5=9C=A8 2025/3/26 22:45, Dimitrios Apostolou =E5=86=99=E9=81=93:
>>
>>  Can't the solution/workaround be way more simple, or stupid even?
>>
>>  * Either have fallocate(2) return EOPNOTSUPP on a force-compress
>>   =C2=A0 filesystem, and leave the work-around to userspace,
>
> Unfortunately fallocate has higher priority, not vise-verse.
>
> In most cases, compression is a good to have feature, but even with
> force-compression, we can still have cases that won't be compressed.

Do you know of other cases besides fallocate?

>
> On the other hand, all major upstream fses have support for fallocate,
> and although I understand preallocation is no longer as simple as
> non-COW filesystems, not supporting it would still be a big surprise to
> a lot of user space tools.

I checked what openzfs does, and here is an excerpt from the commit
message that added support for fallocate:

   Since ZFS does COW and snapshows, preallocating blocks for a file
   cannot guarantee that writes to the file will not run out of space.
   Instead, make a best-effort attempt to check that at least enough
   space is currently available in the pool (12% margin), then create
   a sparse file of the requested size and continue on with life.

The whole commit with some discussion is at [1], while a long issue
discussing alternative is at [2].

[1]  https://github.com/openzfs/zfs/pull/10408
[2]  https://github.com/openzfs/zfs/issues/326

It could be the solution for btrfs too, to just check if such space plus a
margin is available and return a sparse file. We lie to userspace about
guaranteeing that write() can't fail, but as you mentioned, we are already
lying:

> Not that easily either. Fallocate itself should mean the next write into
> the fallocated range will not fail with ENOSPC.
>
> Although that assumption itself is no longer correct on btrfs, (e.g.
> fallocate, then snapshot).

Anyway,

>
> Although emotionally I agree with you. Fallocation on btrfs is just
> looking for extra problems, and if I have the final call, I will be more
> than happier to nuke fallocation support.

=46rom a purist's perspective I also find EOPNOTSUPP as the best solution.

* Better for the kernel: no complicated workarounds, no lies to userspace

* Better for the application: it gets to know that there are no guarantees
   on space allocation

* Better for the admin: the files get compressed as the mount options
   mandate

The only disadvantage I see is breaking the applications that don't
implement fallback code to {posix_,}fallocate() returning
EOPNOTSUPP/EINVAL.
I have to ask here, is posix_fallocate() mandated by some standard?
If not, it's an application bug.

Maybe the best tradeoff is to add a mount option fallocate=3Doff.


>
>>
>>  * or fill up the holes with compressed zeros, basically implementing t=
he
>>   =C2=A0 work-around in kernelspace. I suspect this would be very cheap=
 in a
>>   =C2=A0 deduplicating filesystem like btrfs, since all the zero-filled
>>   =C2=A0 compressed extents are essentially identical.
>
>
> But doing compressed zeros means we got nothing from the old
> preallocation behavior, and still waste space on holes.

I might be misunderstanding the terminology. I thought a "hole" is one
block or extent of zeros. If that's one block referenced (deduplicated)
multiple times, then there is no space wasted, right? It's just a lie:
btrfs allocated no space for the hole.


Thank you,
Dimitris

--0-1150519174-1743082804=:1515035--

