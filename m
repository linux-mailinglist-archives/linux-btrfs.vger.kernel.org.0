Return-Path: <linux-btrfs+bounces-17107-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D9EB949C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 08:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36703BD73A
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 06:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8832830FC11;
	Tue, 23 Sep 2025 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="D/S2r/iE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C14530DD24;
	Tue, 23 Sep 2025 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610030; cv=none; b=WFNZYcM4v0YqwvEV2CBEVy7rmAN8ZSqo8lc0w/ZKJungEWIFf5cmz6sKCJBFtEf7ZFhqMbYs4jVAv155EGm0YOLv3mNN/y6tJoUChdoAPF1EDxvVHU2tHEGVn0WzDFMPnG8q4+LuDGZ3wyqPHaUodnq4MAC6Wz4fNkmypn1rFjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610030; c=relaxed/simple;
	bh=EW3NUNiTT8i8gnsy0gjvw5m0QkwQYXS1kHxLCy5GdAE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=maJtvqH1hqerWmSxTNXCgGTtJtS7nWWy2gXsblltrQhNOuNSUtB3T+MJeyzEbk+OIe7fNWO5V+rI+dlN203EZWBwqM0Gh7/lezs9c6SjOEV8RnMnX9AESnxy+I8Tigcho2AsHUxg4j0T8ALHaGMQgaI0im4nrrp1lPnqHqnoHEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=D/S2r/iE; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4cW9WQ3rLHz9v9l;
	Tue, 23 Sep 2025 08:46:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1758610018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F6L4EvFW+aECL2zUjzzTRJoU54n+F1awMjkRVh5Mh/4=;
	b=D/S2r/iEiG+sMZHbuBJ3I12wpuEn/W2pK3U2FYSqeD020f2ZAAXkMj/CN5rcfQjVjtqsNp
	fDGq+aq2CEfZmHNClEgg02CwGQOVWOB3En2VuAtPpK2j9Y9L7IBI+q0FFMRJUyK9vB9Xmw
	dzCZZIPmBO7YEOiFySZJm3yGbb+0L9FutnLyowfnAdbEdJKj4Urxbzs6WaTdCprLPZs0nw
	jwxZC1PoN+Su2wx5ICCkrJz/t1uvU1E7LobZt3AdmE5FEaPID7VjB0RFqctVjqTvpVeKOs
	A63PTjOUqm19crqcAmO8iHbFdt5e9w7Mcwa1AHLmcSIWwp630oSJF6vUdy30Lg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::202 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org,  clm@fb.com,  dsterba@suse.com,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: Prevent open-coded arithmetic on kmalloc
In-Reply-To: <20250923061144.GS5333@twin.jikos.cz> (David Sterba's message of
	"Tue, 23 Sep 2025 08:11:44 +0200")
References: <20250919145816.959845-1-mssola@mssola.com>
	<20250922103442.GM5333@twin.jikos.cz>
	<20250923061144.GS5333@twin.jikos.cz>
Date: Tue, 23 Sep 2025 08:46:54 +0200
Message-ID: <87plbh4qe9.fsf@>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: 4cW9WQ3rLHz9v9l

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Sterba @ 2025-09-23 08:11 +02:

> On Mon, Sep 22, 2025 at 02:51:15PM +0200, Miquel Sabat=C3=A9 Sol=C3=A0 wr=
ote:
>> > On Fri, Sep 19, 2025 at 04:58:14PM +0200, Miquel Sabat=C3=A9 Sol=C3=A0=
 wrote:
>> >> The second patch is a small cleanup after fixing up my first patch, in
>> >> which I realized that the __free(kfree) attribute would come in handy=
 in a
>> >> couple of particularly large functions with multiple exit points. This
>> >> second patch is probably more of a cosmetic thing, and it's not an
>> >> exhaustive exercise by any means. All of this to say that even if I f=
eel
>> >> like it should be included, I don't mind if it has to be dropped.
>> >
>> > Yes there are many candidates for the __free() cleanup annotation and
>> > we'll want to fix them all systematically. We already have the automat=
ic
>> > cleaning for struct btrfs_path (BTRFS_PATH_AUTO_FREE). For the
>> > kfree/kvfree I'd like to something similar:
>> >
>> > #define AUTO_KFREE(name)       *name __free(kfree) =3D NULL
>> > #define AUTO_KVFREE(name)      *name __free(kvfree) =3D NULL
>> >
>> > This wraps the name and initializes it to NULL so it's not accidentally
>> > forgotten.
>>
>> Makes sense! I can take a look at this if nobody else is working on it,
>> even if I think it should go into a new patch series.
>
> Thanks, it's yours. Yes this should be in a separate patchset.

Great, will do!

>
>> Hence, if it sounds good to you, we can merge this patch as it is right
>> now, and in parallel I work on this proposed AUTO_KFREE and AUTO_KVFREE
>> macros in a new patch series (which will take more time to prepare).
>
> I'd rather see all the changes done the same way so it's not __free and
> then converted to AUTO_KFREE. Also the development branch is frozen
> before 6.18 pull request so all that will be in the 6.19 cycle anyway.

Got it. Then in v2 I will drop this in favor of the later patchset.

Greetings,
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmjSQl8bFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZVb6EAC9TI/b07YUlJDdxmLecJGf9gFKhAqRBrnyiQGyCMZMfxI0QJx7efKHbE1i
SZx7/jOIvCTaYq4Z55x7rYcp3vFRVzIikHYCVf56mJjWw9H6O/ZzmuuzaIELIVWA
G0nNPyE+w9Vgjyvh00ml4dCxNr3jYCmDnY6tP2Q/W2HaHtZmBiMt97F9Jx6Jt0FG
XKUnLCIub7rEJyp5Poawss/JEOshlSUO+5cU1zvvqQV76oJ5utMc8IjcEYYVIieZ
CnOucf1xvBr6IN1ws0EqtBieC0qcBH3CF3nkC5hu+WIRIqGMVPsoL12hynMlOiwD
CjrzCxxemEbyAyq/oc8lCNEc38OYR6oMRhg80jJlz5oAXSgJGQiVbbwE2v0lKIP9
KoRn3H+xhKUNewweu9n0C1shqOO/aT8+fDAHro61UWFGBq9o3herTHyrrZPoNbov
W7n4EBPGRFj2oMhwATngBtzg+nWlluCatdGAT4x4MOn/scOeho2uQCNkFyB0ewMr
6UXOtn68ZPqgLsVXKBMHjOBnW3GYdVExhJKaA52O4rxpOrziDIIlOiKayb6hyCxh
V1Tc2EvmVVwLpfXAnXmMDrdkb0KWvH9FM07I+u6CB8OO+oNpQFToNCcVfyTgVomu
vQQ0ve+ZkdQaAxIwzOZaCW3jaJwRyXCLafXOHf9ARbUf1ysGzg==
=kooB
-----END PGP SIGNATURE-----
--=-=-=--

