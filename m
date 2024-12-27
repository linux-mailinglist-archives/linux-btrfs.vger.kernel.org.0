Return-Path: <linux-btrfs+bounces-10647-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A1D9FD7F5
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Dec 2024 23:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ADFE163F29
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Dec 2024 22:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F31B1F76DE;
	Fri, 27 Dec 2024 22:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Hk1XsJfb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047F8139579
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Dec 2024 22:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735338091; cv=none; b=mpVLP6IGL8ObWJcJ/nL0jAEBHDOZk9Ht8VinK1ODZ+9tylY4uMVskBHG9EcBjszpA9h/S838sJxJUuklG6WaLCYIUpp6qnaxjg/3UT1hJDDEdogWi7kDnfQWiXU20gFkXeo/iV6wvwFrbqH2JTM9vFhmxaE+5Z3rtEOUoe5m9B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735338091; c=relaxed/simple;
	bh=MGqz6m9WmrwyytWdIfkcgcIGJVH1ExsuU5xUMV8PYu4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C7YdlQ2W2nW+KS2trY+ZO5JNppjdjSTmEV81wVeyxkaKnYntE1cIrti+8zocC4yPASk5GWyBnAxia6wQjb5l2QYOu3hNhomnTmXZTSoPvSaWVntphWssfRj58Gr3lrvXJE9SdhgzDLJF8jw9mxeUAOLCa803m5e9gY2TzB9uf1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Hk1XsJfb; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=4fjfcDlo6Xg8PhV3x8DYKrpCBmTUwk7RhKU6MbkBZ9k=; b=Hk1XsJfb2lD6nWPg2Y7vqjmnJU
	1l+LVNgS8alEa1xSSnm6SqpEOONU42QZjRVidj5EsXRdI/nH76uOp6Z0s6vdbMH5GaTzoaAkwVmg1
	A9qI+z3zN5LurFUMqNwFu5/qg/cJYKzqSJJ+dhxfHqqCIX/HoG3a45n3nkeleGoYis0Ud3Nq4NABr
	A33mWgWvUZbJ915prK0FM4icHf+vB2JBePyWaHX4N647tvCIIpU1k4Ie24MrpXvC2IVKTCL8fKScf
	H4LtEecXSxQTnVasTQ0FVciY6/rExUsuWKl3SjIFMb2fd14+B/LnvjUIsAAAxf7KYkce64TWzsl+m
	GsnISxdw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <sten@debian.org>)
	id 1tRIhy-003nL8-CC; Fri, 27 Dec 2024 22:21:27 +0000
From: Nicholas D Steeves <sten@debian.org>
To: Andy Smith <andy@strugglers.net>
Cc: Andrei Borzenkov <arvidjaar@gmail.com>, Btrfs BTRFS
 <linux-btrfs@vger.kernel.org>
Subject: Re: Copying a btrfs filesystem from one host to another, reflinks,
 compression
In-Reply-To: <Z1ErVJYZJKMiFJb0@mail.bitfolk.com>
References: <Z1DWkM8wjak50NrG@mail.bitfolk.com>
	<f6470c12-6601-4776-a738-cf073e3bcffa@gmail.com>
	<Z1ErVJYZJKMiFJb0@mail.bitfolk.com>
Date: Fri, 27 Dec 2024 15:21:17 -0700
Message-ID: <87y10022ea.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Debian-User: sten

Hi Andy,

On Wed, 4 Dec 2024, 23:26 Andy Smith, <andy@strugglers.net> wrote:

> On Thu, Dec 05, 2024 at 07:11:59AM +0300, Andrei Borzenkov wrote:
> > 05.12.2024 01:24, Andy Smith wrote:
> > > rsync or tar | ssh | tar are not going to handle reflinked files,
> > > are they?
> > >
> > > Should I be using btrfs-send?
> >
> > btrfs send/receive has better support for sharing data between files,
> yes.
> > It is not guaranteed, that destination will have exactly the same data
> > layout though; btrfs send may decide to send full data instead of sendi=
ng
> > clone request. I am not sure about exact conditions, IIRC one requireme=
nt
> > for cloning is proper alignment.
>
> Hmm. I don't mind if the destination has a  bit of a different layout
> but I would not like if a significant number of the regions on the
> source got deduplicated=E2=80=A6
>
> I guess I will have to try it and see what happens (time-consuming,
> given the size).
>
> If it expands too much
> > > Source host's kernel is 5.10.0-32; btrfs-progs v5.10.1 (Debian 11).
> > > Destination would be Debian 12 so kernel 6.1.0-28 and btrfs-progs v6.2
> > >
> >
> > According to man btrfs-send, --compressed-data should preserve
> compression.
>
> Looks like I would have to install a newer btrfs-progs on the sender as
> I read in:
>

https://backports.debian.org/Instructions/

You can use bullseye-backports on the sender to install a 6.x kernel and
btrfs-progs versions from bookworm (Debian 12).

Whether it works or not, please consider writing to the backports mailing
list, and maybe CC Alexander Writ, because you have a compelling use case
for keeping at least a subset of oldstable backports active longer than
they're usually kept active.

I hope these backports save you some time!
Regards,
Nicholas

