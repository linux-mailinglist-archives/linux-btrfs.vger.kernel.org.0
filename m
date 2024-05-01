Return-Path: <linux-btrfs+bounces-4660-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90F88B9044
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 May 2024 21:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898B72833E2
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 May 2024 19:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D8216190A;
	Wed,  1 May 2024 19:54:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.lichtvoll.de (lichtvoll.de [37.120.160.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978FC37E
	for <linux-btrfs@vger.kernel.org>; Wed,  1 May 2024 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.160.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714593274; cv=none; b=qWIvGARV9JHLBii5Z3MiwLHJX3u7hnlRF13dIJS1eChVSrQf86cGbpliAJStosxLjaaoWmSDQIikDIRSR0jjK2pCHRj9/2ib0vhRYywbgbBiGvfOjWs0WjeW9UpjAFJkhciMUxfPMsH4Pu2Fr9YQGwL6jam+JhHcNzfZcS3Y0PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714593274; c=relaxed/simple;
	bh=//3bUKCofx6JxQNpLytpeV8ziI7CwIxshXg5cjYWxWk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAvod/vA936jkdHAPIQSMxp+x1FUNrWKqRZ7WnPtdjC8vx3o4K/BTBf8qJenFRhtzUH8OFHKdZaYr/0/UNr3QpJsqgao+2q4IIUxUx0fwtTUW971B2hqNmzDDz4PH4KFeSHwlJIhuKtICFVu7bEwuflQVjzvVG49FjETKS9Du0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=37.120.160.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id B17891940A;
	Wed,  1 May 2024 19:47:45 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Linux BTRFS mailing list <linux-btrfs@vger.kernel.org>,
 Ulli Horlacher <framstag@rus.uni-stuttgart.de>
Subject: Re: 2 PB filesystem ok?
Date: Wed, 01 May 2024 21:47:45 +0200
Message-ID: <2183753.irdbgypaU6@lichtvoll.de>
In-Reply-To: <20240501181903.GB393383@tik.uni-stuttgart.de>
References:
 <20240428233134.GA355040@tik.uni-stuttgart.de> <ZjJOuiu0o1PqV3jA@ws>
 <20240501181903.GB393383@tik.uni-stuttgart.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Ulli Horlacher - 01.05.24, 20:19:03 CEST:
> On Wed 2024-05-01 (16:16), Tomas Volf wrote:
> > On 2024-05-01 10:50:12 +0200, Ulli Horlacher wrote:
> > > On Mon 2024-04-29 (12:34), Johannes Thumshirn wrote:
> > > > I have used 2PB filesystems in my RAID Stripe Tree test
> > > > environment, but for practical uses, I suggest you to enable the
> > > > block-group tree feature during mkfs time.
> > >=20
> > > I cannot find such an option in man-page for mkfs.btrfs
> > >=20
> >     $ mkfs.btrfs  -O list-all
[=E2=80=A6]
> > So I believe it would be `mkfs.btrfs -O block-group-tree ...'.
>=20
> root@fex:~# mkfs.btrfs  -O list-all
[=E2=80=A6]
> root@fex:~# btrfs --version
> btrfs-progs v5.16.2
>=20
>=20
> This is Ubuntu 22.04

Too old.

See here for minimum requirements:

https://btrfs.readthedocs.io/en/latest/Feature-by-version.html

Kernel (and I bet) btrfs progs 6.1.

I bet there is a PPA for newer kernels for Ubuntu. Whether there is a PPA=20
for never btrfs progs, I don't know.

Best,
=2D-=20
Martin



