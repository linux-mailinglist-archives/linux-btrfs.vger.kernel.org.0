Return-Path: <linux-btrfs+bounces-2549-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E468785AFF9
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 01:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94EE928431D
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 00:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C61A259B;
	Tue, 20 Feb 2024 00:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pwNi3ZJ5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cl70JdVB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6E723C5
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Feb 2024 00:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708387959; cv=fail; b=R7wnvdsg1FUwOyZ9IPRsGMHQlb4tDpSOkAw78QyrVPiJ5P3f8o6E5n7mV34cmhqfVeqxqx6ydioRT6by57ZnN3kLI59EiBq3bA8qglywFVVSah5Y3jsfa/jHvNq+Aon80ZmPnjJ2mHVyDoDER6GEoxATzb0jk9o1Ype2WwP0NtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708387959; c=relaxed/simple;
	bh=zNfEZNaEQrkfSTPlqAUm+p09SaHgPA4t9JU78oQVP64=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BGdWFPLAPtuWL9Hm8i9ZuTusHGsawLE2YEr6CRdqKFg16SvNxYMxStsDtnj/ODbMZX2RvtO4shCDxOdp2ALYiTqI6t87+4KT3B5sdAGjuTjPiipDP8iXxR1Zs04rs6YYUKq94d6dqMba6FThra5Gx9GFNxJpOy/heyX0TOL2bIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pwNi3ZJ5; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=cl70JdVB; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1708387957; x=1739923957;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zNfEZNaEQrkfSTPlqAUm+p09SaHgPA4t9JU78oQVP64=;
  b=pwNi3ZJ5gRhkNw+bpa8VYhetlIOMq3ez/BRCrds0vDdTEg1v3aGcdW0U
   SDyoDezniWsR4QPuo9npn6Yl20Am+hN8CuWTKWU80pqKj46AhuM2Th+41
   M0x92pAfrXWvCYDnC4vf6XhMXQir/3+u27IrYZT7ExQttSfBky0KJi/Z2
   AodJ74zt5JD3kAUUVG40b88EQGxy1S4WAvqUfimZDJA5UWZKoAIyn8gq6
   L4Bb5EYP7QFnBbsdvvE/uPMDLACQfG5ZyCPbpRCeIZKMhcyaqH2U3h3Xn
   adIACGhRhvDXOWz3c7llsgIcy8FFY9fEj5bhHo9DYL3JBMu3RpupzwBaA
   g==;
X-CSE-ConnectionGUID: D8yeUguzTSexeSXzmJDZCw==
X-CSE-MsgGUID: VDT7RfgnRESBYXyhWDjrtw==
X-IronPort-AV: E=Sophos;i="6.06,171,1705334400"; 
   d="scan'208";a="9284423"
Received: from mail-bn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.41])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2024 08:12:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNQ6hQNLhzdyvCOx8tLUkL6Qn7HxSvpwnay0wilW3w2w8xoWZ2ZUOk0thdpeJmPuqpsY3jzu9W469GGR96s47I7zPzuA9gxZ/9Qv8fl2GMFkQye5Q/Y1A4L8RpLmIGlVhFdNMWIJnReNHI1FfzJ22cb7jZGVNjSQhpDUxm7cek8AR0+McwUcDYORZpffW5nw7MH5yeZLErTJTNCZC/decDC5nUMHe+oTfpyUx0h0T6t3uAW3UQoh9/szrnSx2TJblXAXhYP4CTmO6uwdLtUWBB0guW1M8RmSJrz42wvOjtVhlk+hdxgftiAVkGAKeJAF2NHRBjPSpLXXtZMfteQqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvpspHcQf6211HCqYmDrH13CH8vxKWefriLHi0VkMwg=;
 b=aIWZ/1ATUr9+KIwGcz5uOe+sGcz20KPtgNEA8P0PPLCWw2p5RUu6h4xEMPxHaW/3b2laGAA2ZlEbaLxQ0n71hsKNgULAverBQhnVdFiJU2K+cUbdJXVYN3QNB/qb7lYpG7wSa5VqWJ4aMSFCetjm2/U0Ym7EulL9vCI0lvLvnIdXfLk/2m3kHS3bMMdbcmpnM9X6wx38WrMLtXMdjGe6iGQKa/NDZTnQxxiyt/zDFjXtmpDdknH4j3p7gN/9gd8HWclDiAfbZZv4JP0Vs+IU4BM7j/QmGQi5SDi4XUB0fZgzj6+1HrRSec0vDvzpd/8mJWDzzdwMHp7DbSwuFXrNtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvpspHcQf6211HCqYmDrH13CH8vxKWefriLHi0VkMwg=;
 b=cl70JdVBSnXboRIImVwdBo9MPYua/WN/KCUr+olzpBjvblYzjf27s4wh9zkRImX0jgI7R+Ef9uiXkEO3YWnmDzZyEcPkwH0IvE1Ux6oCVK6qDHGYE1N1wg0Q20OA8saX7XD5xUV6CDwkUiM4QuhzEPR7aoJ8mli8acCI1TqP6Nc=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MW4PR04MB7137.namprd04.prod.outlook.com (2603:10b6:303:66::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 00:12:33 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 00:12:33 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: avoid unnecessary ref initialization when freeing
 log tree block
Thread-Topic: [PATCH] btrfs: avoid unnecessary ref initialization when freeing
 log tree block
Thread-Index: AQHaYzOhuEZoQxM/JUWL48JxwmvZLrESXHeA
Date: Tue, 20 Feb 2024 00:12:33 +0000
Message-ID: <nic72dxrievc4q5w6i7q7eousi6ieek6lesdydwbwzaexgrb4h@5xgrt3wlxuh4>
References:
 <06acd07b61968eaecded7c22d07cd72030fbef6b.1708347488.git.fdmanana@suse.com>
In-Reply-To:
 <06acd07b61968eaecded7c22d07cd72030fbef6b.1708347488.git.fdmanana@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|MW4PR04MB7137:EE_
x-ms-office365-filtering-correlation-id: c1e40d96-6a4d-4bce-0beb-08dc31a8a2ab
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iqgnf6rfSxhlNEaLtYCFjjPUcS80ywc66tGuXtn/naDUL4gj9sVrxnPyy74hVSs+GyoGOOfPWG2li7+gmK1nK/KraExFQa8d/wfnDuhD+twpa3xrDXLr64Jf8GSBhHWLWMAbdq7IqsX1cqKgaQuO4iQmCvionJFbJOI8abGqmSxhrDJXMY0wWy4uFM56SS/IIcrGiRxGxZga2n7+gAqR1xkJnup7odYXA61ZC7ZIz+2MDFpn6nVnEc14P+SoGBxCnxPbj1+JTz8oiQCMC0zuV1i1QxFcpot+YULFfo7dwBKIoZuPkZVcm73AR90Dmba4J2bUy7+LZA4yNU38u/SdBNgEytAsehEscuM2FkJZC6T/JXNtOWC9ERw0MtClzYxZI9QcT7XgKqp+BT0mwNxAZF2QX4oHf3pM3CY0z0eZxg8at+fKO53qj9bpjcgK11ttRNgphQMXMd8L5RjRppOH7bnsKr/fJ7jkuzEJoaYiBVlQScOu2J+6EgSEsF/n3TBfMaBk/5HNCNI/yeYf3islvQ1JJN69lIrlAKdjUJNU4RGD2fc4fSydCDopfj98qOH89MM6Lz5XQH8Nn0SyIrFcqyPu4QUruWuwXbXc5zl9XIAIXIfMkERchha+SUIMqjzV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?umRI9QZ79HDJ2g6h3B07phSwC8GkQa92FcbZrvYXTzEOiX3x59fVomKmV6DN?=
 =?us-ascii?Q?SCCxTIxKyeGXUzLXdYHTSUGEYu3xU3fG3Kc7Vp6YJa1I6TyOuTOUVlcEld2Q?=
 =?us-ascii?Q?FldPTdObUze07Iu499svfGomoFViZbfEVqDoxz/PG9UzIJHywZK+VnrCaZO5?=
 =?us-ascii?Q?Xti5agrGK7rGe8f02o2B2je5CvmdfBVT3Uw4HMCPW1WKcvv1+TbuziAomnGS?=
 =?us-ascii?Q?XdihCYKoQj0y+OiodWNUdZ1z3y5wYs1gZ4TQsvViAEdyTRiCaq3KTEXHib/a?=
 =?us-ascii?Q?bQfXf0eUDoWG7oYxFEbo6b6Hc9PlgdsOFfVRT01mVuAvRShvVIMd9tPDxVik?=
 =?us-ascii?Q?iauFG5QDX20cjA/xhRAh0p+ptAKo7Lb1LwIbWY3mBfrrrfbNfFRa7+MvvWaC?=
 =?us-ascii?Q?2ESvr3X+DLtX3Hz0FhfTI0rOFEPBoQLZOTO2UFak2UGA9q6wBJCBydcZ1NaH?=
 =?us-ascii?Q?IdE7U0Ej0EjpD0mGFICfZ572MNzQvCKpYQV67vuUKv07J4fotPtjKc10l64V?=
 =?us-ascii?Q?RuOYEDOgep7bfQDJ8fgzYxEXR6dHzgzGvf95XBSS01vog2wbbhndMjjjekH5?=
 =?us-ascii?Q?7YCMOP/LSf5c2dS9Jo7e1d+GSfC70lYLEYDdK/53AlqalEd5CooPIOMc5LV2?=
 =?us-ascii?Q?51MOu9ZFKozkPVvv32k/CYB1e3DdTYkZ+RZ+qVmD0LhLmhZE7u7YjyQwKzh0?=
 =?us-ascii?Q?rCE4swQ3U/tYh2mCh1Yaro6O7dJDcy1ZQqOSMsv7jaI6F3QS1W5ezIiJ9XgO?=
 =?us-ascii?Q?73RiTmeJyEPscFsOAxkzlODWBVOTfKkVzQJ8Eziak47yPlW14lzcfzNtFIyq?=
 =?us-ascii?Q?83MUWyCfWXY2+6WGMTYFlmaxopXmESyJgHdCvzA7JBWCN1B3CZH7EJf6mqYI?=
 =?us-ascii?Q?3lvmuELBSBlZqApdsQk019P/wumJJcRIsBnUHZBu15BeSp5W9yltCzjLUsC0?=
 =?us-ascii?Q?1InaTsycCzYZP6D1/dRQdgKVpvri0UXSUHxxDA+lvLLA4Q6a2+qWeEN1uHeP?=
 =?us-ascii?Q?fuG1qQbKzFgE/XNQVcyVnJn0ihULd0+7RjF4r0G/UIJOLeBxmFFkKYr+rwWt?=
 =?us-ascii?Q?21QLS0XX3z5L3SAm7DTjhGHupPBl2EvpbrWEdcMq2HbviyxzC0CZ+b6KsgLk?=
 =?us-ascii?Q?puHRbsJLN+eb6TUisNest3GFnRZ+6aqBqohND7zMBpNS1BTfFbvMfuE5kLbx?=
 =?us-ascii?Q?n2R5Fr0Nc+baHzd9BUqlBwdSe42nMjwQqS4iVY7Qsi5sqSDM32PyVgCzWUZX?=
 =?us-ascii?Q?4m+x3sBHdT+g8txrAyBZE4pHgIZbPtDcb+aCBn/E/c1JLoM/j//J/s1Eqnld?=
 =?us-ascii?Q?A/NPXvAEmFViKnEhO77s7wYEDCcCcDeUO+j8iucS6Kv3knKdhPpkXBn8e75q?=
 =?us-ascii?Q?UcO7BuOG43puAO/TH4YLBWRB4p+j9vJVLgJ5xL8BtmSJ2HoJu2dV0s+XIEsE?=
 =?us-ascii?Q?g3A5PMPltLvRLQG1ArMnGtEpYrtSvrvj7l33PypSneqqsXjSLoqjLxyHeFAD?=
 =?us-ascii?Q?8I+lGW483OBPnV2scAde5cHY2D0FZ6+Iel5SoM5CjVAc0sFm8aZIZiZmb3sv?=
 =?us-ascii?Q?vRkLyynf+okcUAijmmldgtBSY9ULBCGJ8ELi4Q6OkkcC5h3RkeM2K67Z/Xnu?=
 =?us-ascii?Q?Sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <00F8AA9C470FEE479B105EDCE600B78A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5kQcxSmfyiIneUBh4+Vzh76AOUXM7WFJZTSBGQzcgdeym28TpB2bmh30juvTLZTjRsppprR0NjagpjKpv1AI7J/JHDnpvcMfPsxkBjxFrFsp0QWjgOrw/g8u1b0b1YUNA29D6srn5H/Xdd90U5vFPVLVXwhgvQgf1LtaaOW6GG61lGr3oFhcyVx32449r68TX+8EJ5lkWnKTQIabsdxCFhxT6dxx3gVydBnJzNJzFLdkWHaSIYRU690c/gzxWop3j7BJULlplpHdwE0OZgEga/Xub5SugYFK2fbvBc15/ykuIy9/S8pNuJNb/7nCW7jnzwNuudIR5uSKIWnJTfj7eNZHbyKZQlTXOZY5OTzX923j15BCJHLyXXOcIDNctdrCHciGnPToUjl6c0CTQdDe8ykZbFGAT4qySmVA+XNLZjYN5NqVp6qBmCqKrXEESIRhpiRs9jwuYYLLSwJh1jouZwwuWsfM4u4WLLlfCM4ybXDDhvvSEdlHHALLmpTtcBLSzzF13J02yOSP5D5mZk6X+pc1yYI7PncYUU/O7Il4lb9a0jTxXj5ANEqwIfhePhobR0KA0ZRmPvgiKeuKkxl8994N2p6kxsykAhU5Een8pP6tHqIsROzkKHYC1usPKJQP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e40d96-6a4d-4bce-0beb-08dc31a8a2ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 00:12:33.2903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7V7eScLIq+HK3wdVLhgbsJPUrO7/sc+1WPwz3o6IMPRdkp52eo7o0dKar9/8XmAecMXBOPICAonu2OTcXOiSBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7137

On Mon, Feb 19, 2024 at 01:00:22PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> At btrfs_free_tree_block(), we are always initializing a delayed referenc=
e
> to drop the given extent buffer but we only use if it does not belong to =
a
> log root tree. So we are doing unnecessary work here and increasing the
> duration of a critical section as this is normally called while holding a
> lock on the parent tree block (if any) and while holding a log transactio=
n
> open.
>=20
> So initialize the delayed reference only if the extent buffer is not from
> a log tree, avoiding unnecessary work and making the code also a bit
> easier to follow.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/extent-tree.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Exactly what I also thought while debugging around this function.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=

