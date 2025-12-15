Return-Path: <linux-btrfs+bounces-19763-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C97ACC0131
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 23:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8633B3011EF4
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 22:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DD32E54DE;
	Mon, 15 Dec 2025 22:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mikkel.cc header.i=@mikkel.cc header.b="oQvUhKBW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BF71DED63
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 22:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765836200; cv=none; b=biGPxQBxs0cUrR9NqMm4WfrtZoxLCpLXR59d4CgFtviD6eejpNqG6HU7nqHujPvJ1ZH1J86IGONNnyELrBetemvHHTBU30HMIWWS7coqpFpUzHtjBw4osRxEpsCyVYLjgN8fQGVcTOowrrs+jKVO9dHfRuAnOco4S6R55A6Xu9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765836200; c=relaxed/simple;
	bh=a0VAVi3hwl210QgY2ZTAJrY05i1ZF0kxQxaoBmZaKTI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=nODmXJeGOfcvBd2O0ae2HDe020E4nL0TUkLvkAAUv6gz3xSAx2xmkB7CkqJbMxsbn/JSn2/Tjjxf+cBhtAh7oTC+gx4I5PN/E8is0Y+Rgd1YpaNdO2E4h3gt1G154IOzL0UVu/QXjbzBSCcGjUJrbUy+sr7kkhteaI7r8Kg8/cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mikkel.cc; spf=pass smtp.mailfrom=mikkel.cc; dkim=pass (2048-bit key) header.d=mikkel.cc header.i=@mikkel.cc header.b=oQvUhKBW; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mikkel.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mikkel.cc
Message-ID: <4977489e-067f-4a8d-a750-1d395d01b471@mikkel.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mikkel.cc; s=key1;
	t=1765836194; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MS8sdRWsLXBzUE3y7SADzFGWHl/BGYgmN+CB89Cc5LQ=;
	b=oQvUhKBWnUfKOm+4u1Lk4WogswYqoZ78ou8a1GVwagA/mTP4A4N0n0/EwphBSJUm1fYyay
	b3L6/2oWLVKV4KUyTSvlDZxiSZ/BAO6eCcz8ZUvNJ9lFzYB577oYGz08u0i0pYy1Hllx/m
	b9vr4YKkcutL7kbsnoI6Edv92ZT74b1dMMC67OLAcpBaETdkBj2DR5y50XVc1FztPtK0r1
	FQmv1zSXctj/GBKKns43MScKaK0KPeuWCIW/hxz+x/+XtS1s/APXLg7lhE4tWZ2TngGSYm
	F6pK/rDd4/hxeyboRLxe428v8zdeeHIIa4xddg2teD1ZD81yLQfLQp/00a+bnQ==
Date: Mon, 15 Dec 2025 23:03:11 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: lists@colorremedies.com
Cc: linux-btrfs@vger.kernel.org, quwenruo.btrfs@gmx.com, wqu@suse.com
References: <3187ffcc-bbaa-45a3-9839-bb266f188b47@app.fastmail.com>
Subject: Re: kernel 6.17 and 6.18, WARNING: CPU: 5 PID: 7181 at
 fs/btrfs/inode.c:4297 __btrfs_unlink_inode, forced readonly
Content-Language: en-US
Reply-To: mikkel+btrfs@mikkel.cc
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Mikkel Jeppesen <mikkel@mikkel.cc>
In-Reply-To: <3187ffcc-bbaa-45a3-9839-bb266f188b47@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi there. Affected user here :)

On Monday, December 15, 2025 3:47:13 PM Central European Standard Time 
Chris

Murphy wrote:

 > ...

 > >> Looks like --repair changed from "errors 4" to "errors 6"

 > >>

 > >>

 > >> [1/8] checking log

 > >> [2/8] checking root items

 > >> [3/8] checking extents

 > >> [4/8] checking free space tree

 > >> [5/8] checking fs roots

 > >>

 > >> unresolved ref dir 1924 index 0 namelen 40 name

 > >> AC1E6A9C763DC6BC77494D6E8DE724C240D36C9E filetype 1 errors 6, no dir

 > >> index, no inode ref>

 > > And repair again?

 >

 > No change.

 >

 > sudo btrfs-image -t 16 -c 9 -ss /dev/sda3 fs_post_repair.img

 >

 > https://paste.mikkel.cc/gNwpLmyw

 >

 > > If after repair, readonly check still shows error, I can craft a quick

 > > fix branch for the reporter.

 >

 > I'll check to see if they still have the file system. I asked them to 
make a

 > btrfs-image before starting over. Thanks Qu!

I installed a new F43 install on a different SSD, so I still have the 
affected

file system/install available for any testing.

Thanks for the quick and good responses to this! :)


