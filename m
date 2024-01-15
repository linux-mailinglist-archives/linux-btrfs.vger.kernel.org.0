Return-Path: <linux-btrfs+bounces-1445-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9332C82D6A4
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jan 2024 11:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0E5284C61
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jan 2024 10:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C01F4FD;
	Mon, 15 Jan 2024 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="XCTNZozL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EECEF4E7
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jan 2024 10:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1705313032; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PEGAFHtnJL5enD+g6/wUk9ORnmzWtjff1LVmCDq+4Gvl8SnIMlScyWs9XmL9OdJhmpyrb17v9vJrSSh0SDfWSKlWbrwVpkmJHDObNfmoGI+zVtk4tooZRQyP0M2m3UboMMavz3oZxkSBr/CgGYwqdfncIAdlR1xKnTB8lAkbVxs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1705313032; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=iYxO94MgBxnaStR3YmNm4fJ2cymWYovrBVWJVySs7/s=; 
	b=agepqxLmTDtj4IVEQuAt/4VV8VYE45oK3zgju0x3rv2EkM6hN9wGckqdb5fFKw75h0KoeGLtjxAOr0JsMrD+4HIQLIi4cDgmp9pZIbNWB/uCOzsp5VVA9a7Q0nVLmM3VT1dHFhfhZIwe6Zzia/3Ilvdpf8PBkORfHXtZCktJ4Lo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1705313032;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To:Cc;
	bh=iYxO94MgBxnaStR3YmNm4fJ2cymWYovrBVWJVySs7/s=;
	b=XCTNZozLstLkj1wqGAddgKRLBecXBbmqgb+Ksvzye25da94FMU9PKg6Fb3wBSDov
	qCunkTaqhpUC3zkV/Uwav4tUNkltEhJMFzW5fLJpDCpIkXEJXZz95lE/JECTJmtHfKB
	Gl8hnmf4I4GYc76lz5YXDmbjH/U3RXYIHa7pCQ64=
Received: from [192.168.8.156] (149.248.38.156 [149.248.38.156]) by mx.zohomail.com
	with SMTPS id 170531303102755.11796926264742; Mon, 15 Jan 2024 02:03:51 -0800 (PST)
Message-ID: <faa3ef680b68bc8facb1f0c4714f4722162bd691.camel@rong.moe>
Subject: Re: Scrub reports uncorrectable errors with correctable errors
 unrepaired, but all files are fine
From: Rongrong <i@rong.moe>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>, 
	"linux-btrfs@vger.kernel.org"
	 <linux-btrfs@vger.kernel.org>
Date: Mon, 15 Jan 2024 18:03:46 +0800
In-Reply-To: <8a89a5cf-8d10-4737-bebf-f60f89dacf9b@gmx.com>
References: <8bd12a1ee60172f53ee0c27374f41c3ec9976be8.camel@rong.moe>
	 <27fb4ed5-c3ce-4ab7-a3fd-d77dc8dd4fb2@gmx.com>
	 <b10d90cc5eb4f49eabfe3cc0df92ef40b64428b0.camel@rong.moe>
	 <794c3085-c5ee-417f-aeaf-d6c0ebd7d96f@gmx.com>
	 <f8999f0745b2cddb42d3fbc16fdaf346b530c848.camel@outlook.com>
	 <1b4f45c0-da2b-4817-8cdf-a07fd405ce9c@gmx.com>
	 <50e1a0a0cf29f361426c0eb7005d389e4dd2833c.camel@rong.moe>
	 <2e275902-dc1c-41b1-b1fb-998f7fd16de3@gmx.com>
	 <0de1265ff914ff0fa772fad548c329c6d7f280b3.camel@rong.moe>
	 <31a6c044-1540-4345-9504-2234f93aa150@suse.com>
	 <3e0ba2b7-bbe6-448f-b4d2-2e7dde291735@gmx.com>
	 <8a89a5cf-8d10-4737-bebf-f60f89dacf9b@gmx.com>
Autocrypt: addr=i@rong.moe; prefer-encrypt=mutual;
 keydata=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
	cMTsfqztU+orM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Sun, 2024-01-14 at 12:34 +1030, Qu Wenruo wrote:
> Hi Rongrong,
>=20
> Mind to test this branch against your image dump?
> https://github.com/adam900710/linux/tree/scrub_beyond_chunk_fixes
>=20
> For this branch, you do not need to apply to patch to disable blk plug.
> As the crash is caused by bad scrub read endio (which can not handle any
> unexpected bio split, thus leads to use-after-free).

Scrub errors, oops, kernel bugs and slab-UAF all vanished without
disabling blk plug. Cheers!

   Scrub device /dev/vdb (id 1) done
   Scrub started:    Sun Jan 14 21:57:30 2024
   Status:           finished
   Duration:         0:43:59
           data_extents_scrubbed: 21561913
           tree_extents_scrubbed: 313432
           data_bytes_scrubbed: 1128612171776
           tree_bytes_scrubbed: 5135269888
           read_errors: 0
           csum_errors: 0
           verify_errors: 0
           no_csum: 0
           csum_discards: 0
           super_errors: 0
           malloc_errors: 0
           uncorrectable_errors: 0
           unverified_errors: 0
           corrected_errors: 0
           last_physical: 1994106359808

   [    0.000000] Linux version 6.7.0-rc5-x64v3-dbg+ (icenowy@edelgard) (gc=
c (GCC) 13.2.0 20230727 (AOSC OS, Core), GNU ld (GNU Binutils) 2.41) #13 SM=
P PREEMPT_DYNAMIC Sun Jan 14 17:42:36 CST 2024
   [    0.386759] kasan: KernelAddressSanitizer initialized
   [  311.624759] BTRFS info (device vdb): scrub: started on devid 1
   [ 2950.646598] BTRFS info (device vdb): scrub: finished on devid 1 with =
status: 0

So,
Tested-by: Rongrong <i@rong.moe>

> Thanks,
> Qu

On Sun, 2024-01-14 at 07:53 +1030, Qu Wenruo wrote:
[...]
> Although I believe the root cause is the same for the uncorrectable error=
s.
>=20
> And IMHO, even with the patch, as long as you enable KASAN, KASAN would
> still warn about the use-after-free.

That was what I had believed until I ran scrub (which blk plug disabled
and KASAN enabled) twice on the original dump image without seeing any
KASAN warning, kernel bug, or oops.

It's confusing, but I think we can just look ahead as the
scrub_beyond_chunk_fixes branch has been proven to fix the bug :)

[...]
> Thanks,
> Qu

I have some questions that may or may not be off-topic:

- Is there any other disadvantage of having a converted btrfs with data
never balanced?

- Furthermore, the fact that the bug was introduced in v6.4-rc1 and
reported only after v6.7 had been released hints that a converted btrfs
with data never balanced has the risk of running into edge cases.
Should we recommend users to run a full balance (currently only
metadata balance is recommended) after the conversion, if they would
like to make their fs "more stable"?

Thanks again for all your detailed explanations, helpful suggestions
and the fix.

Thanks,
Rongrong

