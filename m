Return-Path: <linux-btrfs+bounces-17113-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C20FB94E48
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 10:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6843B236D
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 08:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7C22F39A9;
	Tue, 23 Sep 2025 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="DUbrfQM4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009C334BA3A;
	Tue, 23 Sep 2025 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614431; cv=none; b=q3qccmhsJk+fXqGyY5A+RL6EKod3jIzIRGeLXBUWpyVh7Ev7CjM3/ADWubGZZQ/aRN59UBkQ3c/V+uNq1KA2ac6F/xDdKcwc4Eu+bSNmHWc9KyuUFUU696D0AZcfTlVywEGVk3qsXBLyw++1OrrSyyDtGe+lNtRtU84E3wo6lQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614431; c=relaxed/simple;
	bh=AJfBtZtT8NZXOdsCO5wEFf8E47DsOJgRE6j12CymBbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lSwSQATZHHJtMvQS+i8ZYyo5IDR8r3TT7IshxVgYvU0gM2LVemHygoBBUuCdx4U8gYblpwRRMUYwnFt+wC2JaPHxwdHo91Pwcu6FFBv1UZCN1x2UriNWQ1nfDrj6Qwr6Xl6P/HWapreIWhL0+yOoUEAeD415j0WqorHaROJghFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=DUbrfQM4; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4cWC891zC4zB0XK;
	Tue, 23 Sep 2025 10:00:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1758614425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AJfBtZtT8NZXOdsCO5wEFf8E47DsOJgRE6j12CymBbk=;
	b=DUbrfQM4ugovnBbknvFGNd4NJQrHtJx52kARqT+ZMSJbKNF5Uonbw1ze5NOGvB/n23GGaE
	kMwnUnhSDHpmrnMgaoKQgx3a3MQZqiIdHKTw820c5mx70w9DFcu0kQgElqD2uuuUdqE6aQ
	AfxF38DvlOUHb8vfhuGpkNW3NTLXNQpHlncdyxFLknqUNef0P3bZ7YR0Me2bR11aJ/V9y7
	MsrVa+LY74dyk8NgIQW7srcaJPkWhozMmJrrHWjCUsJt898Og+i0O9N/ticiXuABs1MBdg
	LImBLs5uGjZzfPRuIiouLzrXu5p8S73xPENVtJccJ0QdOK6oGnFRbVrsW69UBg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::2 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org,  clm@fb.com,  dsterba@suse.com,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: Prevent open-coded arithmetic in kmalloc
In-Reply-To: <20250923070045.GU5333@twin.jikos.cz> (David Sterba's message of
	"Tue, 23 Sep 2025 09:00:46 +0200")
References: <20250919145816.959845-1-mssola@mssola.com>
	<20250919145816.959845-2-mssola@mssola.com>
	<20250922102850.GL5333@twin.jikos.cz>
	<20250923061344.GT5333@twin.jikos.cz>
	<20250923070045.GU5333@twin.jikos.cz>
Date: Tue, 23 Sep 2025 10:00:20 +0200
Message-ID: <87ecrx4mzv.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: 4cWC891zC4zB0XK

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Sterba @ 2025-09-23 09:00 +02:

> On Tue, Sep 23, 2025 at 08:47:35AM +0200, Miquel Sabat=C3=A9 Sol=C3=A0 wr=
ote:
>> David Sterba @ 2025-09-23 08:13 +02:
>>
>> > On Mon, Sep 22, 2025 at 02:47:13PM +0200, Miquel Sabat=C3=A9 Sol=C3=A0=
 wrote:
>> >> Hello,
>> >>
>> >> David Sterba @ 2025-09-22 12:28 +02:
>> >>
>> >> > On Fri, Sep 19, 2025 at 04:58:15PM +0200, Miquel Sabat=C3=A9 Sol=C3=
=A0 wrote:
>> >> >> As pointed out in the documentation, calling 'kmalloc' with open-c=
oded
>> >> >> arithmetic can lead to unfortunate overflows and this particular w=
ay of
>> >> >> using it has been deprecated. Instead, it's preferred to use
>> >> >> 'kmalloc_array' in cases where it might apply so an overflow check=
 is
>> >> >> performed.
>> >> >
>> >> > So this is an API cleanup and it makes sense to use the checked
>> >> > multiplication but it should be also said that this is not fixing a=
ny
>> >> > overflow because in all cases the multipliers are bounded small num=
bers
>> >> > derived from number of items in leaves/nodes.
>> >>
>> >> Yes, it's just an API cleanup and I don't think it fixes any current =
bug
>> >> in the code base. So no need to CC stable or anything like that.
>> >
>> > Still the changelog should say explicitly that it's not a bug fix befo=
re
>> > somebody assigns a CVE to it because it mentions overflow.
>>
>> Got it! I will submit a v2 and make this more explicit.
>
> No need to, I've updated the changelog at commit time.

Ah, then ignore the v2 patch set I've just sent, which simply changes
the commit log as you suggested.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmjSU5QbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZcSND/9NgqjcqgTXu05GyxVEzTrHSfb+MSILGrQi7+2DUCw+bcw6KSKb1uFag7Qh
FoBxC/v535r7Gen1H/mc2PjHzY0Gf4aqwOqXqf3xZvynJnqiw4GjToyNISo/1oiG
KZt+8/ojJcqfkQqXy/MrdtVIKhrX2NFgub+EuYhsQVMGEw2u083LZdLC3n4uhO21
JBrs12oTSfrRYNv02pGWX68bZ3WNzD07w37nyyJQ+IEOFp9q7+0RvTh6j3dWCPQz
wC2987AyeaBWFO6BqbOysXvAqM5HJDOWtJIprQVSI02lolpHw03pna7ZlY5CnyZp
i7SlCp08uoziC48IprIgQEznh42hyJrzFpXyPbOk7boEwW21FC96fzkwraNswzSC
SjiAgcMb61HAMG+ME2uiviNLHcyZUIT/EMwxEsPqCZMuelNb5bxiP8Euf80/X7H8
Wdn61kKOYGLQHQIe2ochYJ/fLlWCsabfCBDvgY+LY8gNwWulGbVkBb/zb9uLfkdD
QvJ8mP6iPqP8I+S/r3WOlL2vFJMMc8Qcem0eOkKZG91IMLpwJ77lEyhASYNz/rxc
tfbMBwdCEy3+mgASXOra9COSDyp5HRWKnE76lv0CgPdoeY3rcVFo6GRtD8pU1heI
1nkstGcxd8hTujOf3AyX3QcgxHgojbEtWBmo2E0uyR4vaHgw1A==
=3lts
-----END PGP SIGNATURE-----
--=-=-=--

