Return-Path: <linux-btrfs+bounces-12429-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7BAA695EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 18:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A6C3B478E
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 17:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FAB1E130F;
	Wed, 19 Mar 2025 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b="MDFPIxIF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17D01E22E6
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404053; cv=none; b=KwtMRNBIW0+nSnLinkujhAnssMUIAGmB12GxRe+K+VdGANZjvEy0uOSeeTrux4JaGRUAbJDVPey2DsgkXyZKMcI7ziDheNqcYTZE60Zf7BWSSz96v9HFU+OCPRrjPdqFyBwIENmA5oLG7q+ygs8cH5wiRoJJR/KUL2Mq4oQ36Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404053; c=relaxed/simple;
	bh=WCZlzBEr4ld+KVmFRACHp2CA4khGIQWbG9umivwvnXs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Yk+X7EzccNo9OiPugIrpeQ5iqUgGEwD7gwAusa5+WfMYMZ5IjZkF1qPPbKS3+vSspI1v+QqkCO6z6zyVqCK01u+o8082RUjY+ixTnorU0TZIWncKVuzZ/OePfYCf6QzI3tP4ubgchRjY1UbyhRHA/f3ikWbAi+NKOhcDgFdYNCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=jimis@gmx.net header.b=MDFPIxIF; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1742404049; x=1743008849; i=jimis@gmx.net;
	bh=CLZykzjXbLyBGPb3Wp/Y6IlxamyXqlo+NiuNFFLfGsA=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MDFPIxIFEMunCjEdhDVJ2M4A9/+/1LGKCmpMdWk+R+lWJ02yTV1z+Pi0g8iaZ23c
	 fVbSuHG3WZcq619mkDvo+7m6ehfOq6Pa2RqmMDKsqBvcjoq5vxFLxdEpbwBQyEtpI
	 kJi1KQ/xevLa1996zhC+gDk2CbqtGU/aKzcezxfoxczOdG0ZEyc8SDNiLY5Bx2Xwt
	 ib7nlLd82zUNSlsVnXiSEDY65l1s2nI40WHUFbSyzPY5RDKQ3awgL2UjV5daxcLja
	 H9b139kEslC1oOC7S44O9n8RJQ418R1LFBpP6aigxr/T1/emDVdxruvDHJtqmpFGs
	 4jozZc3TERz76JapkQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.9.70.81] ([185.55.106.54]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bSj-1tCR7b3BBb-0186eP for
 <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 18:07:28 +0100
Date: Wed, 19 Mar 2025 18:07:25 +0100 (CET)
From: Dimitrios Apostolou <jimis@gmx.net>
To: linux-btrfs@vger.kernel.org
Subject: mount compress=zstd leaves files uncompressed, that used to compress
 well with before
Message-ID: <2f70d8f3-2a68-1498-a6ce-63a11f3520e3@gmx.net>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Provags-ID: V03:K1:DYQE88fdoPlVhYe6SRl34Wf+7BtE6c/JFniDyOZxoApDDIuSilz
 8PFK0wv419SV2MrgucHcxxvJfijMqEVi5R2dT/uS1o8cnpBKe3a2bstxg5zv/oxJeXnvgJU
 7wHddNXeI/azAlwQ0NqMN7EqN0M6t+I5CH//zxPK54YRe2K1tyjljf912q7PdX7CIxGcl63
 ltIK4rPt2sRMSjwWj5ddA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VvR1ODPyr9M=;iRvYQtmQ7l8KLeOFzN3CwNMZ5Ya
 XRQKG+VcVpNDVUs8F6D0qn+3TmhsHh4E0m4LgetVCMJAwtJQsoXCEgJOmVKieDpL7a/6bY6ga
 8Vz84ToOhdCWepORxS+86IjtAkh86JDS1hW8Gx6oOrHCsfYvkMHyvslLWsqshMPMZ2HxaHRI/
 la29AcBw5zJeM708GK3vtQArmqnOeA4zy99XFTiL8zN4vWMi/132JvSk5zAME5i0fYHy5mz0L
 oHyhw5Yqffens+LSJ6wtNcrX2Zy7LoMxSm/jardRMBPnlBwAuTNMlS5WbbnDYVDAamGWZmsTe
 sEdcWKs2nY3ElqjJAgp+y8hUt/G9Br5tvlwtkoZ54MNf5XPDHa6uGx1SoAYyat4wmq/Jd70zy
 kkPWkAcnmJzDAXxCyT1tikWq/SeLz3HcIlUGYjVKZYXPy8Qq0XFub9hgZ28wmsYWGjFmdcP1Z
 em+xlGeGlgLRuDL1VxndmWPeE//awJAQdGa5k4VPxhIkeeok3o1RoHGFq+jkisVauDLKoXiYs
 Ie2tdu5/IKHtm+Caz12WUc8PWBP7Z2U/z3ALIVJDsq7509l51QeHg5Ggv5tnLSSRkmjDn1MbA
 VdZCmhooWMMvqZandFNm39Fjfp/Tn/ZTfiIB5MLkxXyk3FQKSjFYUphnefdqIIeZ0Vtz1H8Ox
 Sxem008/kNzrCT2ck7X5xXfaeUIkh7VdRUiJxGoAJqzbDRJUV+IiJtvUhPaHCSHLSwvNxM9+B
 r9PmegIFSzRXv3eCVCeGEXhibmJcVDcpBGJRAkSUqHJWlDk8RzTeIyNlXAbO2gntHRr2XJx8o
 nqRcfUQsseUwGdssCxE5NCeu9qatZ26b2NICBfjq/xcHGxRDZqX6LjHSPAgiwtVhcpxempnkK
 rBqPVyTAtU/puJ0CcQxO2zeDYyYzxJpQGBnnP5u96boYJth47fx9nOePUAuKpihn4I/gZM618
 hYKWkB7qjuxiBGmSU60MBmsME8lNzhv85bEbUsQ+7zRVI10BZkXWcCrxEQm0Z7HVMjX0wivPb
 pwDkJf2cljaRygsIzRAWT33nEYRP6HrtBnOkxGuRNYdN5HRLfeuEdGPhsU1NwVOzKCT6BhFfN
 oAhMo96vBq2DSH2IxAO2IglsfOjF7Yxvf5jrPgZAvmQ4DzZZiCt/wtWTbUDeT8qYxCa+jcgR7
 7qiCXD8JlWpbycnML5Oxmc1C0VFzIJCNioCkDEizgnXdnJDh0PdTZzknzcrkei1pXcLbzZVa/
 h3+T6Wgf7mr0STxZvQANruHKHbTguFJdYBy97VBHDVjjWfjTjQEzFcnu5FgnySNEffpwv1ufb
 CqQFoOg5ob0lUyYUtk+it4k3j7vQ6j3spuM8MfRXnhDb8pViOPrXY1daqi0fBhd/p9SbnwlFI
 oKJnolwH+EOktzsivSBAOjQ5aLu4kHkfK/UsxE01DrV2AzjKR1tGM0GoOw5x17KV990FhyMQN
 ml1u9tVwTVcrGW55O5oxZ+inBBq0=
Content-Transfer-Encoding: quoted-printable

Hello list,

has something changed lately in how btrfs discovers if a file is
compressible?

I am moving a database (pgdump|pgrestore) from and to a compressed
(compress=3Dzstd:3) filesystem.  And while on the old host (kernel 5.15) a=
ll
the database files were highly compressed with almost 8:1 ratio, while
doing pg_restore on the new host (kernel 6.11 with newly created btrfs
filesystem) I notice (using compsize) that most files are being written
uncompressed.

I have to issue a defragment -czstd command to fix the situation, and I'm
contemplating whether I should change the mount option to compress-force.

Thanks in advance,
Dimitris

