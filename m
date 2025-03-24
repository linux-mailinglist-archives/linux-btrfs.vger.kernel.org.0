Return-Path: <linux-btrfs+bounces-12517-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40801A6E321
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 20:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71C11686EA
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 19:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3B0266F1A;
	Mon, 24 Mar 2025 19:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b="UkfDQItU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35A478F24
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Mar 2025 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742843555; cv=none; b=CyN34LWIOZhvBfLPEY+J1jc7gyQlfgW9SSxxAf5DEz2v1Rm+AO1gp8QDbuvtTMs/f8YHaO9T+T58FCcXp65BWMCyhxxTCPZ3AZhcks9TDtujTXXtu22uNacDCMsK4ohjaksizGkuDfVmLb8fCUh6rEcko64iT85Yxdfvk6mBx3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742843555; c=relaxed/simple;
	bh=dVy7nNaJLD8mqi+COsCCdY6R4mKDKvNzz8lgJSQHyJw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jIzVdJa4ruNE1j26mAf+R8aTuG3Yb9qwoT2rO9RCYZ/V/n4nGxNc1Wb7QSGTJmTinPXBMSeUs8uSUYwUA60SrkCSpDWj1VMdKgDCzR3eWqJU97nQmBxOarWQkr6YvOh6HkD1CsdPs6aYg2Hkw35ym+GSZXFmJfn2WCoCI9HhEyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b=UkfDQItU; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1742843487; x=1743448287; i=jimis@gmx.net;
	bh=dVy7nNaJLD8mqi+COsCCdY6R4mKDKvNzz8lgJSQHyJw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UkfDQItUCR8cqT8ldH7dKiHIHuvR8E0/+gqIk2jdp4ByinVyPHd17nsCvVBNXx2a
	 biQ3cLdX2JTzAGszEdxHb3Vu7h54YOTbibqSweUibgV8wd670EWk+UvQeic5rHR2U
	 l1/Z0c3SalHWS6orw/kill5XtCdmkCv6rJnmUgRlMlsbydlrxZOnKCUMPpdqL3W/4
	 Bfw3jCymzYIUYHbPce4Eud8lrhoxOxWxrTGdZFMEC6Qe6LH+RjRqRjgqMr6QU2W3A
	 NXRWRXIh7EE8ZQvDGXsdQXNybyc69/A7awvnjl9G4mjnJPd2vsPPzwMA4MJPjByC0
	 mMA3DqiUgDtegzxCfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.9.70.81] ([185.55.106.54]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5fIQ-1u3ws11eV0-00FAFJ; Mon, 24
 Mar 2025 20:11:27 +0100
Date: Mon, 24 Mar 2025 20:11:26 +0100 (CET)
From: Dimitrios Apostolou <jimis@gmx.net>
To: Gerhard Wiesinger <lists@wiesinger.com>
cc: linux-btrfs@vger.kernel.org
Subject: Re: mount compress=zstd leaves files uncompressed, that used to
 compress well with before
In-Reply-To: <8aaba46c-f6d5-4f3a-a029-f564b8a6a9ff@wiesinger.com>
Message-ID: <3ecd06ed-a1f1-595d-a7ce-c1018bc15baf@gmx.net>
References: <2f70d8f3-2a68-1498-a6ce-63a11f3520e3@gmx.net> <d1c2f041-f4f5-9dad-511c-117ed8704565@gmx.net> <8aaba46c-f6d5-4f3a-a029-f564b8a6a9ff@wiesinger.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Provags-ID: V03:K1:lesC1rakB4C2OCV6IMzg+vQBnM4g2BVXtHzbfyU3IpSAZOWnrwP
 TfUehnj7aMDgFqrO5kICrd88Av1C/Uqa67gGEX0QL6hoelwH97wI3ztrYGso+nt+hDA0b1a
 9H0PG4iVUDIqRd5Xn3/nFZD3ogIyvp2/uLCoJgpiwkjLVmYmZpVoxEsorxTSpncqpxb/Rg/
 MvHJOqf0OePKDystPG/rA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AvAz9RV31GY=;gmpYa5M3FpBcBJOGIDZS6snQQu9
 YoYNWyr04o8uDntaHibnlRo+pNfJUU9di4FL8OTY8gzU7bKqI9DnEwW4zmeO8K1MQ+Wl/eLSO
 nJFke/tPxe8ZgmTtFO1chi5EYiWVVEccUnYNc572hbBQTlh3eAs3Rs+MOyQruYnWhQJPsPSzV
 QickGq7WsJ7Ijn2VBsTxgV3l0DdSsDoamxmAbAY3x9ivCiKjQzo03yyUucXdP9Fo/KHYiHCVr
 cCCfeQAWThMHGeAEMt2ULHRIfpqgiBFi4pIgw149uZz8ze2kuOIjgEsWEhamckTasN0VycuBh
 W1ZnyTQ/6TIR3G1ozdme7EgQ+pJt1MaFEYqkieLgxaK0eGxsmSccFJpDW8Olc8UZ7vXZWw7r/
 bNAbp26YOHNFoCEieCGHqfCf3hOZEioo87V79kah9wcHKOLlkeuUcDbZa9KUOHtBZDkYpZU+6
 +ysLVJ8/9S5B5zCm/DCFcADppZGOf08/MH8uaqb7cEQjTXcDvs2czeHTFSXZm5DPdSAGFK5Yf
 UGNKMvifW7Qx475DuXq6VXgG5PaJNXkHoprT8B14NKt8KjhsV+8HTWDXConRBIVWaVJfFmPAr
 0Us9JK7Mx9xKHxu1z8R7H0bsSlIMsFZu8vqmyOmmSefHPLPqcuX7qvtS9y8q5AKT3BPVzO6wi
 eS3j5SNWbF3NE7ABQ+oDyIeaBrmMiX+aBDO7w/Av0sHZIPxmSm4LKWFbIm5KdCoIs/y1vCqzU
 gLwDDbH0sLHccJpIxtjTmV12MpESfk4NyuHZU+uoqIJvAJ+1dRfDmBcHuRo9BYHvEwzDMds/k
 bq++yCYKzFpaeL1sM70++WQ9n/30eUQM5I3+FavMkBmOzEgjtGF5Pny+gp7c7IPW2dtdFRO6r
 u+39kYGFoPLQL0nSeQ4HJbu61w0Q2PyVvVnGuj66j6eKeTNguHPUgR/+Ade4WLEZuKX7KXfK/
 RTjjvzLHjTeArSn+3NkQc7n90dHtpn74LgiJtzjKu2CY5J4eVjiFg2mxR+q2lYit3+MCs6dY+
 fb/GC0FWBaRszyZ2p0YZJ9PMfON37GTGBm1cd++nIeTST/8PAW1Nm7oHJL2rfHCYXuilnPo0f
 6ne4q2jWPPvY+pz2yvuruzz76ye8gbbpGc7yk0F9oAnV78Zf/GFJ9jM6uL3BKmu6fv5iQVe1u
 8PS/MAQbXH/YtnipXvXJrWEk44hKdBTnmcBsw6Zj2oGFOf1qC+OB2NjKguEwHSd1SGhOkfaht
 JTPo61iU+NMWfC8QdWT6FWFwP/5X2/XOBZdcxTA3BAFxlk8xGtw1o0rv6L4bDvywGEcDauADP
 cGmhc4iekZHKfsfVzwNJFfjT4XKB+w2EwZ96QT8Qxz0rf2C2mbYVcnFB4KUaWVehI7jjRaTIz
 7nozPPihOeYWqMf8HpPupP+FhTVpI8rwe2HERaJnC5Vfv5rnVTSEgaDkKIgx5lgiKem4/Oz5f
 AgjT2f1HlPdve8WQk+AhtGM26bqratFmTa8Qkvkq4OmdTuwSlY+cmKXT+4on5h4nJaiBlOQ==
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Mar 2025, Gerhard Wiesinger wrote:

> Hello Dimitris,
>
> It's a known bug I also ran into, see the disucssion here:
> https://lore.kernel.org/all/b7995589-35a4-4595-baea-1dcdf1011d68@wiesing=
er.com/T/
> (It can't be easily fixed)

Thank you Gerhard, it seems we are facing the same issue.
It's a pity I read that force-compress does not fix the issue.

This "preallocation" mentioned in the thread, how is it achieved in the
application level? Is it with posix_fallocate()? If so, I definitely see
it happening in PostgreSQL:

https://github.com/postgres/postgres/blob/0e3e0ec06b995f6809f315752cbf5ff6=
7902e095/src/backend/storage/smgr/md.c#L575

Relevant commit:

https://github.com/postgres/postgres/commit/4d330a61bb1969df31f2cebfe1ba9d=
1d004346d8

I can see this code was introduced in PostgreSQL 16.

Maybe a workaround is to recompile with -UHAVE_POSIX_FALLOCATE.

> I guess you always had the issue but you didn't notice it.

I definitely didn't have it with PostgreSQL 15 on Linux 5.15 (Ubuntu
22.04), I don't know for sure if I see it after upgraded to PostgreSQL 16,
but I see the issue with PostgreSQL 17 on Linux 6.11 (HWE kernel in Ubuntu
24.04).

I see in your message that you are on Linux 6.5, but what is your
PostgreSQL version?

> There is also another issue with BTRFS:
> https://lore.kernel.org/linux-bcachefs/kgdutihyy6durmrtqi5dfk7lhl2duzm4w=
nf6mlyneiuphf3cck@fxulfyg2ugjf/T/

And then there is the issue of abysmal performance for buffered read(8KB)
from compressed files:

https://www.spinics.net/lists/linux-btrfs/msg137200.html


Thanks,
Dimitris

