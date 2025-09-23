Return-Path: <linux-btrfs+bounces-17108-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 034F5B949CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 08:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0604B190206C
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 06:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68E330F93D;
	Tue, 23 Sep 2025 06:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="U3D2+rBC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2868828A73A;
	Tue, 23 Sep 2025 06:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610065; cv=none; b=BJUR1tOyirhi+stue7TOkObdzuXQ8y7tU1Da3i3dMuWRV2VwrLvlGd6X1xD5YfcL/HuD2ur5EqL0kJkB/+YfF6gjEFblcI9LOLaf1TCJy4iOkDel5LPHYVOjiIug/slnC4Rbi8K9rpA5R877KdJY36RkU//K2y2OKYraAbDqck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610065; c=relaxed/simple;
	bh=AJwDIQh4P4pGox3htLAHN4DDLUXf37DWgaODkPPGWOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I1VFnv0Dy8zoC3JcIDe8PxPK+6AqJCTmyQ/veROd30Ddre8H69zKS2M8ViTp/Ofayyw35CWkopFEc4KIOMBT7rpyEtDeznGWUdXj44LY+ozuRouqimBRPK7oHTw/fgPOapypubj49tI+lAnOSIcvrwQ8fqrhs2gFGVqEBbgk8g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=U3D2+rBC; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4cW9XB4Rv7z9xxd;
	Tue, 23 Sep 2025 08:47:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1758610058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AJwDIQh4P4pGox3htLAHN4DDLUXf37DWgaODkPPGWOg=;
	b=U3D2+rBCTUFhRhUmF3tgLc2clp9xvM45ry5llIwxug6KO+1CGmDWLrnnmwF5KXgMvvnKdy
	JbW0mwU1YtGkMZoeBKb/yzGxgz1+mlwkoAhDiIL57r3Dnf77ArOPTU4RkJ+zZC7eigZAG/
	WURGSBAA0SGvn6djSQv5anc6m93D+epnK0I9JChlFAo4cpd4CEn/TEZBKtYufIkYA/uZYA
	453cC6T1m4NwiAkpZ6BnMhn/V7FF3Ro8tM7R4NJQjGxaouxBug2kfmi1w2h0W+gcWT4VID
	g8x0S40C26mD8ApdP+XFt7Kb6WCtw86FvXjasmoWRdKIpPpS6smp0NIdqBMAWA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::1 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org,  clm@fb.com,  dsterba@suse.com,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: Prevent open-coded arithmetic in kmalloc
In-Reply-To: <20250923061344.GT5333@twin.jikos.cz> (David Sterba's message of
	"Tue, 23 Sep 2025 08:13:44 +0200")
References: <20250919145816.959845-1-mssola@mssola.com>
	<20250919145816.959845-2-mssola@mssola.com>
	<20250922102850.GL5333@twin.jikos.cz>
	<20250923061344.GT5333@twin.jikos.cz>
Date: Tue, 23 Sep 2025 08:47:35 +0200
Message-ID: <87jz1p4qd4.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: 4cW9XB4Rv7z9xxd

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Sterba @ 2025-09-23 08:13 +02:

> On Mon, Sep 22, 2025 at 02:47:13PM +0200, Miquel Sabat=C3=A9 Sol=C3=A0 wr=
ote:
>> Hello,
>>
>> David Sterba @ 2025-09-22 12:28 +02:
>>
>> > On Fri, Sep 19, 2025 at 04:58:15PM +0200, Miquel Sabat=C3=A9 Sol=C3=A0=
 wrote:
>> >> As pointed out in the documentation, calling 'kmalloc' with open-coded
>> >> arithmetic can lead to unfortunate overflows and this particular way =
of
>> >> using it has been deprecated. Instead, it's preferred to use
>> >> 'kmalloc_array' in cases where it might apply so an overflow check is
>> >> performed.
>> >
>> > So this is an API cleanup and it makes sense to use the checked
>> > multiplication but it should be also said that this is not fixing any
>> > overflow because in all cases the multipliers are bounded small numbers
>> > derived from number of items in leaves/nodes.
>>
>> Yes, it's just an API cleanup and I don't think it fixes any current bug
>> in the code base. So no need to CC stable or anything like that.
>
> Still the changelog should say explicitly that it's not a bug fix before
> somebody assigns a CVE to it because it mentions overflow.

Got it! I will submit a v2 and make this more explicit.

Thanks,
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmjSQocbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZflsD/0eESI7rIzieHW/1dCgxTEQ+0Mce4FwxQ5ke5ZZiXSk6o5dGiyabApHLGEM
XQ0wGf9HvHVXlUQKGvt0SVULw/y7OhxtiyGAetGAuVblnvHd6aU2KYpAYrqeVA19
jvhazcswAr2sBP7Kz05pwxwdK5xjryVnG0zzrMxTVyLrsx/BBmhppTDOQA0oGtgD
0ZojUwzJmOs9ZP602mhEREJ8NQtg0iAT2ApAcuyGK3SGYZE4yrSa8dwONMnkJpiN
O4JOo4N7eYXHI4PwHd5D9wJBkIvAT/5UzADFuJUluO8lLgM1SFG3LNPu27cadfH+
RRUabIYFNuxAcc6pDAcb2zlpWpSANzvunm37qVkyGWSFDQpGBSn/ulZsF6qlfE7J
nllxZjEFC4PtK/EU9IwwW2iTLzdn5JD3rirqTTEG9byIDeNnc2SJMLwZWqf4lVXX
AFWQMVueLlw1V39DuUHBlz9Tg05JBgiXBnEJoGrmhoU5luVhYYkWt58SnNZEpiV1
yz/vV37HD9gDVMP7DpwIFLaVMZeqNEiKOR7cVzJ5BP8dWZ5IoGn4vm4+OsBqsq6i
c4EI+gO4i/y33QwssOjuXEcXvghERPds9xrc/s9j/4UwEaOvEo/lG/YHzznUcBZN
h3z8oa0cGqtFzzKZJnqkuUKs9q3gVOlY0u/S/I/GyjTi8ChuEg==
=tsB8
-----END PGP SIGNATURE-----
--=-=-=--

