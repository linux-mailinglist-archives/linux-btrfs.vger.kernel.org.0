Return-Path: <linux-btrfs+bounces-12867-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C342AA80C1F
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 15:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31F25053A2
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 13:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C146116F858;
	Tue,  8 Apr 2025 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b="W+AkoiGA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B8D12C7FD
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118291; cv=none; b=B02LpmLNyk9iN6eTi/OmJxxlyZxEuqGfMWJiOkaeFgVdC6bs0UNvOx0wojtQMADNgtnf+du6bcNTkPQFFgpAi+AHVSrnZPnvSwIt8O/f1J9ZGZCCp6d1thZ6H+/1F/rfq4ApX2TsSU6h+Q0+6NWUfu/XLkt9TH/6sRt2RuokGr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118291; c=relaxed/simple;
	bh=Y2ivjMHZc7Mn6gZHuSnUf7OFVlir1OI6Jqi/EM9VSrg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qvnRvB2gfZmCNW1pwy+8eARjjHnfCD+gLQhvWLb8i1OYICHikjeZ66IB836jjuFr54c8lD4xGbkzQfvNyoMN+QyiLYnicB83gbmMJyHjws47KQ7wRkYnAYM8pUo0+7KYI8s1q+S9dNqtLth7WFmYYE6tjfhHcWjaz2v4XEz1f8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b=W+AkoiGA; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744118287; x=1744723087; i=jimis@gmx.net;
	bh=or3/WR7pLcDZlhWe5RYv/eN/NIJXfE7e0nGRgvBtQ2s=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=W+AkoiGA1iPfCKqA4pimSnDR3RrMg2tK9rDd1JFo41CJhGTaBGuYj4UyDjvdmJ9L
	 seobGrvLD6gctTpZ7PS/aZjT0Qn650dZZZgSHXFzTh3T6M7QCkJEjm/Pn6O9FfX8/
	 pdAB/k2oZoy93W2guWO2ff/h8XITRETkeOMkeNYz+B8yGVA3V7QTc5XLRyJwvcDZT
	 U9IAr+PzciKXSk/91WDSqjm27usI+c0VqrpQ/wxTFE/QtT2YiKYnIJxj5JxFf473r
	 g1gvj4baTD8FcwfDD2aoN1HSoLLCTNBXEtJADnu/Ps30g/mqiDioG/wrtlpeI/KoO
	 BryvlTJIAF71lHsa/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.9.70.81] ([185.55.106.54]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgesG-1tPoPq3gjc-00etAr; Tue, 08
 Apr 2025 15:18:07 +0200
Date: Tue, 8 Apr 2025 15:18:06 +0200 (CEST)
From: Dimitrios Apostolou <jimis@gmx.net>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
cc: linux-btrfs@vger.kernel.org
Subject: Re: mount compress=zstd leaves files uncompressed, that used to
 compress well with before
In-Reply-To: <29339223-1c02-4617-9013-66f4c1754d7a@gmx.com>
Message-ID: <d72ba6d9-0b2f-e82e-b2c3-b197f58093c2@gmx.net>
References: <2f70d8f3-2a68-1498-a6ce-63a11f3520e3@gmx.net> <d1c2f041-f4f5-9dad-511c-117ed8704565@gmx.net> <8aaba46c-f6d5-4f3a-a029-f564b8a6a9ff@wiesinger.com> <2858a386-0e8c-51a6-0d8a-ace78eced584@gmx.net> <2b33bf94-ec1d-4825-834d-67f4083ea306@gmx.com>
 <ba2a850f-6697-7555-baa4-32bc6bf62f81@gmx.net> <b9f7b83d-5efa-4906-9df3-a27f399162fb@gmx.com> <d6abe471-8144-3f13-1002-d55cf7d3e672@gmx.net> <939a6f4a-837b-4613-8761-b03f8d4809ea@gmx.com> <b338d808-f691-9969-9e48-d4a9f0363af3@gmx.net>
 <61996eb1-de0d-4d9c-b1cc-b24145985d38@gmx.com> <5c7978e6-ba04-9aaf-e32c-788f1607254a@gmx.net> <29339223-1c02-4617-9013-66f4c1754d7a@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2092428343-1744118286=:67797"
X-Provags-ID: V03:K1:rLXBiYLAxdOjOQlk6wzFbGUmzNKuYI0M9ykyjjJeOQfbBvy3Bn8
 KDLVG4vp0Fum6M0xFmob5eOVZD9ac2W5Eq/Q4iwrNvkSrIqfOPuHtoUYmTRopnAMBUvlRwV
 Nt1wc5yVOTLFoChFfhcGduuSHz8NtmjNSPTbU0h218YbVe5R/O9WNmHDLmLJDjU/cpm4NgL
 oe+7Cj+2hAI6rWCXXbn2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FeGac8TyIFM=;X6hIfKotQH4dIcZflXI0r+LCHjA
 K6GwxdlRIGBcWrd1DtqGCqIDvMEMr2xx4LjYsttXzf9lBN3ppA5zRH6OL9yBTefAYMUbyJ9XY
 0kbyPZcL12xcozeaLSJN9q8TuF39E1KTctwDzdbywv5OzOTPFZd9Uiyl/TlT7VJx+6z0QdqTV
 zmekchQNhvIjIUnErw+N5/2tEQAYvKWckUWOkQMQeLB43LwPuU3AewMQeE948hZ9VFgFyqr1C
 DpWw94sQmHmylKSWtE8Nn4wxZIMiMzfecZsK5qzLKBk9uqMJxLfaU9fCQTpkHqmRhvsl9QXYW
 yyylaCAp++dWfYHxOCiTeIK3pcFbxBHDQtqXx1MGHU6UcP7v/LI55RBKFV6IYzcC5gCqE3/nc
 HVknlYMddVoCwZCMXTPhUQPE8mss0nmCdYhqAAgxIvT97OjYAwc+Stt1wCdCFw8sVxsdmXR0d
 GpsAauByMTtqLek50aKphQ/OsuimTo824GW1BLA3M0Yyyoq7Ph2pZ41Z+2JpWkVDhKNzYSjuF
 baZyQQX955ckZe+55itWcLYiNoqf/LuytVCwdk9aCZ/H7WZC6XEwLPctxhYecfwjVdyazonpu
 v6aNcijkcCGhVtPmnyFcoBRugsWQdpJhM94VdQdPEEaE7U/GUpdoyLflPFRzdkHvnqRXKIzxC
 /vBxycp1OTKMLWIxp+HTw3PL9P6+6dVdnvfvsGSM733CVa0gwjGra/ykNDfmFrCD2eBGHyaXB
 PaixxbZN9wNsnLFrtjvOv4hjrOnLIdSSZl5yy8r2Xh94/Q1TnJFb73dbPdsyQFHSkKl2wvf/+
 nBQEmXs27UmCkgGk03p9BYhvAYU3eRTetqs0vgdxvKKymb4tUo/qw15xh8Mktjo3sWCjjLk1S
 WzkFudoWvfMULixUkVtKcKXuc3X6WtwYm4z3TsQsQ7BfOXfgEjiDMmO/yG8ybX5i2KBQWRSRd
 kb8I0fD3CAYfxzQcX3MF/oOUdY6yIRUe8SdTSqTuBVdqxeW1O3rWQIMa3dVmrNS3V+EaDu/NI
 QPPO/hiNLbSaH6xNJrQ2Zc0TuRe927wTHO0d85UIjUum9JVPwGwx08AsOaDidiHJoXrjMQBNp
 K+zjvXhVETOMnPGfDSnc0IWVA6e7HHlZPy3iknXmorrhlZvcAjdErShnO6s/zjidrUz0jfGmI
 13cxoC3gqe5kJoVTQVMq3MoR0Xl/AZyHQoO+yNWNXgQQur0eniyNAmcBjDbsoFgeNYSLrA4Ex
 IeZN//9Wu1b8u5SzPm1QzD5eyYhwdB+q6xFv+Gxe5rGQrD2D9B5Yc//36BUSIJcYGKkhWfGyt
 rYIBkgPpcPgt6gdYdI5MWn3TINoxlTk3/gqZgRKZGNFoJQLywukgrc9O6aLB9jSg4IGFv0sVi
 StMsTksjQPgmNGbh7WzVjBTHDl4NH+2kbNLbYuAQB10PtR/g5yOFZnfnSizh3mlIH2jlhkl25
 ARWDmEebIF9SMoZlGUWoY1BWVVZxBOoqFx1R8U3wY3R7ZVYYAi/XhN8tfHGRsHkmKIa+/Gg==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-2092428343-1744118286=:67797
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Sat, 5 Apr 2025, Qu Wenruo wrote:
>
>
> =E5=9C=A8 2025/4/5 03:47, Dimitrios Apostolou =E5=86=99=E9=81=93:
>>  On Fri, 4 Apr 2025, Qu Wenruo wrote:
>>>
>>>  Looks good to me.
>>>
>>>  Feel free to submit a github PR or both patches to the mailing list f=
or
>>>  more review.
>>
>>  Forgive my ignorance but I thought I did what was needed. I notice now
>>  that maybe the subject is wrong. Do I just send an email with the same
>>  attachments and [PATCH] in the subject?
>
> Oh I mean using git-send-email to send the patches to the mailing list,
> that's the common way we do the review in the mailing list.
>
> Some examples:
>
> https://lore.kernel.org/linux-btrfs/cover.1740542229.git.wqu@suse.com/
>
> Although it means you have to setup your mail box to allow SMTP access.
>
> Thus the other solution is to send a PR through github.

It got a bit overwhelming to send by email, so I ended up with submitting
a pull request:

https://github.com/kdave/btrfs-progs/pull/976


Thanks,
Dimitris

--0-2092428343-1744118286=:67797--

