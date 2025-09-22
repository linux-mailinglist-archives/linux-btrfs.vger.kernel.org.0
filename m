Return-Path: <linux-btrfs+bounces-17086-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AC5B913D1
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 14:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D13D4254FE
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 12:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAA93093C7;
	Mon, 22 Sep 2025 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="haXU5Doe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BAC2AD20;
	Mon, 22 Sep 2025 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545486; cv=none; b=kQN1RSEDqNDulGeFrMs91NGvQLZrPSvY58Zm/hz0pNJrqZYdWxPt20AaBAVZ8CzWoyn/5wP/I8WLZCrmW5ey7XiSupPFEcgY2jnNK/jDPBETOZe8MS5v0qtpHitFP6XD1Cd8gc8yjS7gSEmwtHCjwxS1H7jt6LHHb5fxb/itdiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545486; c=relaxed/simple;
	bh=Iz9UZgNJKyNMc2OfTRs4Qobm5C+M7qBf/0bvJog+Lzw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ncHNaJ4erqGE6no84xpezethEn4I8nKIeQgNyQqJ1ftT+4S25TTZZ3Az+0gEBX6YmSQCk7MUZ8RrcP9rS1HZfP0SNX30qpJrptw2U2Yo4GMf0mwzTqUHei8RiSLtJxs/QdGKi92WRLUJIgLkhHTj6e9NhMLWxNmYRQ1rZZTpibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=haXU5Doe; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4cVjfG4wzczB0P9;
	Mon, 22 Sep 2025 14:51:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1758545478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K1dXOwMIZsJBnAC+87S37o9PpbrQcwWEFVTNEZoIX7k=;
	b=haXU5DoeQf/+m2Ut2EbLBHUxXxp5xKCvXqkaEHHNFfTrXDURHrifykdfUAKOTT7Y8vJpcP
	dZhz3Ctc95tZt3c9j0MM8KfFgMCawE7S2vMpJdyh1jiXzpcm6CEOGkEhERx44dfHn+zxkF
	qiiIG/YD8AFxKuqbz9yRNc4LLsq7BJhzrUATxyHA6YRcH6eonLw7F/J6yGuzsXYlKnxGpq
	yKxzkeOSwy9GI6B2qqYgqRVYmv0X3lS5gTYI9KV1f2vKd4VrodeHPWLkuCMqbtVJo2B4RG
	JF9GgJ62o5tYfhmPRH8dlJ0qQUuEn+VXityJArbFLMG6rvtXv3Xm8qDJpdMYrg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::1 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org,  clm@fb.com,  dsterba@suse.com,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: Prevent open-coded arithmetic on kmalloc
In-Reply-To: <20250922103442.GM5333@twin.jikos.cz> (David Sterba's message of
	"Mon, 22 Sep 2025 12:34:42 +0200")
References: <20250919145816.959845-1-mssola@mssola.com>
	<20250922103442.GM5333@twin.jikos.cz>
Date: Mon, 22 Sep 2025 14:51:15 +0200
Message-ID: <87bjn24pmk.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: 4cVjfG4wzczB0P9

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

David Sterba @ 2025-09-22 12:34 +02:

> On Fri, Sep 19, 2025 at 04:58:14PM +0200, Miquel Sabat=C3=A9 Sol=C3=A0 wr=
ote:
>> The second patch is a small cleanup after fixing up my first patch, in
>> which I realized that the __free(kfree) attribute would come in handy in=
 a
>> couple of particularly large functions with multiple exit points. This
>> second patch is probably more of a cosmetic thing, and it's not an
>> exhaustive exercise by any means. All of this to say that even if I feel
>> like it should be included, I don't mind if it has to be dropped.
>
> Yes there are many candidates for the __free() cleanup annotation and
> we'll want to fix them all systematically. We already have the automatic
> cleaning for struct btrfs_path (BTRFS_PATH_AUTO_FREE). For the
> kfree/kvfree I'd like to something similar:
>
> #define AUTO_KFREE(name)       *name __free(kfree) =3D NULL
> #define AUTO_KVFREE(name)      *name __free(kvfree) =3D NULL
>
> This wraps the name and initializes it to NULL so it's not accidentally
> forgotten.

Makes sense! I can take a look at this if nobody else is working on it,
even if I think it should go into a new patch series.

Hence, if it sounds good to you, we can merge this patch as it is right
now, and in parallel I work on this proposed AUTO_KFREE and AUTO_KVFREE
macros in a new patch series (which will take more time to prepare).

Thanks,
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmjRRkMbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZdXmD/9aKfcwkUP8/3YhELwG+Pj6gfzY/EsKaTaYhLErAZ08HxPpyAgpf/qxVsuj
TrtwICvOqVE2DYnrdooyTn9qYYr9iLBbkKiGf+YdN6mCMKxpxhw8oKpmpWTsZjUo
tStFuaDUU6/PPwL/x1QcOS4nJLrUT+HMGx0bhNgoP06qOH/VefoBxNPzF7bjNpRK
A81JCCvx0kdvSYh4Wc6qkuN9puba42Fp6Jzqn4eaJkjyyAV8TED8SbPl1lH1wEl5
WdXuNdzk0rebNwulILFBOiOPWAEZ6zGSfi1Nh/K3+YqLQ4gCN5b1fZpRWLWer8lU
tL4yJpdTr8B1agNJEycJ0AhkRwC+i19V6UGIkeJQxgeeqyYS+pBJDWRT1mtbzVn4
Uo0l3CRNRZmTTZFrp6Cka8Qju0jwFej577uIn22l11zsYh5+9goFRnzPO+Hjucba
DwfcVwKP5r8VE+pduDmo/dyz7FikPlwka4XWkxqmimaggk6C39RdeuzTL/d2BUan
ObsoID5MDMK2xWd2O7IwqEAj8Dm19SdwzHVDJ1l5ACXAEtNEPdNoXlUh9Wd2GTm2
7mfiRPshZ3LFuB6yjWM6I3Z9JlnCaO5aO6N269gl8DRwpBPrpLLklzLrV2om7k7W
QXQrqcaSoCUGG22EMZErCuh6FINkZSkzieEvmZ+LIHR5mRM8pw==
=ogjZ
-----END PGP SIGNATURE-----
--=-=-=--

