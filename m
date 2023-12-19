Return-Path: <linux-btrfs+bounces-1060-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9827B818CB0
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 17:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F08D1F22735
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Dec 2023 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5693D0C6;
	Tue, 19 Dec 2023 16:42:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A243D0A7
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Dec 2023 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-82-FKW1q9CCNcWyoepqEPSr-A-1; Tue, 19 Dec 2023 16:42:27 +0000
X-MC-Unique: FKW1q9CCNcWyoepqEPSr-A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 19 Dec
 2023 16:42:11 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 19 Dec 2023 16:42:11 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'David Disseldorp' <ddiss@suse.de>, Qu Wenruo <wqu@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] lib/strtox: introduce kstrtoull_suffix() helper
Thread-Topic: [PATCH 1/2] lib/strtox: introduce kstrtoull_suffix() helper
Thread-Index: AQHaMbPBRujg17A2g0aXH8N7pLP0+bCwzl3Q
Date: Tue, 19 Dec 2023 16:42:11 +0000
Message-ID: <8095c6ae5f8d412d8e6ff95707961a08@AcuMS.aculab.com>
References: <cover.1702628925.git.wqu@suse.com>
 <11da10b4d07bf472cd47410db65dc0e222d61e83.1702628925.git.wqu@suse.com>
 <20231218235946.32ab7a69@echidna>
In-Reply-To: <20231218235946.32ab7a69@echidna>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: David Disseldorp
> Sent: 18 December 2023 13:00
>=20
> On Fri, 15 Dec 2023 19:09:23 +1030, Qu Wenruo wrote:
>=20
> > Just as mentioned in the comment of memparse(), the simple_stroull()
> > usage can lead to overflow all by itself.
> >
> > Furthermore, the suffix calculation is also super overflow prone becaus=
e
> > that some suffix like "E" itself would eat 60bits, leaving only 4 bits
> > available.
> >
> > And that suffix "E" can also lead to confusion since it's using the sam=
e
> > char of hex Ox'E'.
> >
> > One simple example to expose all the problem is to use memparse() on
> > "25E".
> > The correct value should be 28823037615171174400, but the suffix E make=
s
> > it super simple to overflow, resulting the incorrect value
> > 10376293541461622784 (9E).

Some more bikeshed paint :-)
...
> > +=09ret =3D _kstrtoull(s, base, &init_value, &endptr);
> > +=09/* Either already overflow or no number string at all. */
> > +=09if (ret < 0)
> > +=09=09return ret;
> > +=09final_value =3D init_value;
> > +=09/* No suffixes. */
> > +=09if (!*endptr)
> > +=09=09goto done;

How about:
=09suffix =3D *endptr;
=09if (!strchr(suffixes, suffix))
=09=09return -ENIVAL;
=09shift =3D strcspn("KkMmGgTtPp", suffix)/2 * 10 + 10;
=09if (shift > 50)
=09=09return -EINVAL;
=09if (value >> (64 - shift))
=09=09return -EOVERFLOW;
=09value <<=3D shift;

Although purists might want to multiply by 1000 not 1024.
And SI multipliers are all upper-case - except k.
=09
...
> > +=09/* Overflow check. */
> > +=09if (final_value < init_value)
> > +=09=09return -EOVERFLOW;

That is just plain wrong.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


