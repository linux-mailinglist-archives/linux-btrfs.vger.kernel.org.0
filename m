Return-Path: <linux-btrfs+bounces-7803-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F23996AD40
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 02:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B9B1F2501B
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 00:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD92410F9;
	Wed,  4 Sep 2024 00:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PJHWIr9M";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mJMbFx7Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B686C391
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Sep 2024 00:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725409170; cv=fail; b=UrLgaLsCKz86FcCvLAJdzpKZGwF5XFwvbQRTWfquuD8+CKLdhe/4rz9QQ2jfP0H35BPSw3r7ZwQXZRYc5PRDSiVjLLP2WbtaPgrfG6AkGyOKDhMyZsxW0deXgd3OX3xqzPZAijLgDLfmZ3tjsohHRzIn1EXZp65fmdpKMbjhVwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725409170; c=relaxed/simple;
	bh=hm8T6KAHd659pXYpRXoVJORmqyI4ea6sj9boxiYRP6E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jTkttOGmdVMXm4xGEaIVqn70OqwMmuy/z1ZigfYGIK4GS+oKou7GLPZ02t3X91t8AVz7npjCmsBH56CsKYHKuD68KoB0KbVtuEeV3kAMuZmA0LDqbWQWvXsahge7CsdJrz6bmM1G7GTeGa0fwPN5Q2vBYxK1jbhOIy6RMDOpTfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PJHWIr9M; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mJMbFx7Z; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725409168; x=1756945168;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hm8T6KAHd659pXYpRXoVJORmqyI4ea6sj9boxiYRP6E=;
  b=PJHWIr9MOEQuCc0D+0bj7w2TSImSsRJlj0UM3B9OMgvRRni2Si/t5aUP
   oxPcdKeFSHHZecTd9mavr6lnqSEppyUQ4S9oN6T3qzR0WLPdidglUN2Mb
   i8kixCKFoywjh078a5V0MxzcvorsQVMz3RsIBnfi44SM7isO9H1SxKqdM
   3QjHxsg+H2+p6/YbrYPjyyBdzbm2476o5g7aPAsaRhgdLdcFYnQUedivF
   2AJeZQtxTvnjb5vwnBBgHdOf33naqYbeKQYdqFfjb7dqgYfFSqNBjlQ/a
   tXDrPyNhrQXQt7ELgRBSsR5G5IJkcvX/aR/mv8UntXmwRPXiTrd/ooE67
   Q==;
X-CSE-ConnectionGUID: S/qum8ttROi4xfT6ZFOcKA==
X-CSE-MsgGUID: y1tGcqp2RMys3GgjLFUjyw==
X-IronPort-AV: E=Sophos;i="6.10,200,1719849600"; 
   d="scan'208";a="25233476"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2024 08:19:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKhbM7nfZ+ddN2TSHEKofqpNUG4rmy44fb+srsWPc6wFydCKJSa7EIR5kARB2YCKkW5RIOzI2N8P/hUUeJVNTNxHDMDTFmVvB2l724QnvSKlsKT6J8G1NvNyIZr8vJw/8fzW/vwjkZXoQug2Dd9+Ti41Zm5GvTDFwPt87YjhsofjynEA7rsX/bR41WG4WYAQVtZWIaKu1v7uZgJfejqLKxfAbPn/GCKQgV1WNS2yV9Ep2DYwMeXXrkOaB41BqgKXdezPFPt2B2Yw/8SCKHpfadHsAbK+J5I3qg+hU7jlSku95dm3/Lf6FX4GEBGn+AkToacD0iczOaky5ak67GCeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmM+cS+Qt9NspI4ftFSBM8HggjeJPrCRL/lDV1zvKWU=;
 b=N6DVu76wG8366eUwMGZnTHnMxFiAsMt2pppun5ZL6zvOcxkw0tcA6jsYx8KvNxqpVxGoDSiWHiX6QremO+8Ly4skTnbnbUmaan2EfnTzEQEcNzzua3ppRzqrZLeHZ75RitpLTs1LHnAZR9TuYYOd899uXnTY/hhnBq+PCTh5vzUNaCcNH4AkUSOSvpcO0GR4L7ku+eox/YhHoyatudvervtLACZ5BU14By9qgYDMQEeY5uf1UnO//qpLHNNmRTwEEI7NbUU4B+9NyZ7N6dFCv1aKU4MpVFV8ZLYCAPBTNi9up2cDTXVYYZuVgupS2+51hhYR09M5/CZIm/gxUrZPmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmM+cS+Qt9NspI4ftFSBM8HggjeJPrCRL/lDV1zvKWU=;
 b=mJMbFx7Zs6tZsbcYCBzayupHEi7gIkeV4F/JAWMYR1fzJisvKTi/Shnp1NzndL6/8rBoO3Wl+WmdHQoz9hYnWjrA1NLNJIBc7eUC5AOzbj9ymTKjOyVQOuihKQryL6AIvmbrxZKg+lxntf/h7W+X6uEGlEINipPbKG1IOJw7Uuk=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MN6PR04MB9684.namprd04.prod.outlook.com (2603:10b6:208:4fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 00:19:24 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 00:19:24 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: David Sterba <dsterba@suse.cz>, Xuefer <xuefer@gmail.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: is conventional zones used for metadata?
Thread-Topic: is conventional zones used for metadata?
Thread-Index: AQHa/U3SVQcIEt+pC0CywxJb2n3ZCbJE6qGAgACPjwCAAPqRgIAAUJKA
Date: Wed, 4 Sep 2024 00:19:23 +0000
Message-ID: <p3uy5u6mcxz2thyrazvkm2sxcc3qpbwweqw7vept3aeh6tkmbs@2kpxtze7cx53>
References:
 <CAMs-qv_QuHCA2pU4w4fiQbqnvo2PikmhM=AE+YrNzLsKxQ149w@mail.gmail.com>
 <20240902195929.GA26776@twin.jikos.cz>
 <CAMs-qv99kdgrWeqN+piJpDSnWRCGT2adqka2eTUnjk09WphHQg@mail.gmail.com>
 <20240903193007.GJ26776@twin.jikos.cz>
In-Reply-To: <20240903193007.GJ26776@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|MN6PR04MB9684:EE_
x-ms-office365-filtering-correlation-id: 82bd79da-4d1e-48bd-80bc-08dccc773ad6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XYUQxZ9xVDn2RDUq8xM86Wbh/WKgUnKHILRKL7BS2zW3OCx/Hemej7ja6E8k?=
 =?us-ascii?Q?LFipD4aUi1sLShvdggjDDq5PJ8jUq2j470o9bRwBz/90ee7jy8RTjUZ+zX/I?=
 =?us-ascii?Q?W6mo3aRv0QIQNdhkIlviC3XERFF2EP6stcYnaRyeFJdD/GluO/7C7TUFzOvB?=
 =?us-ascii?Q?vfiE3y+rbSWQ2Cl3o83s7TWQLw0/9n30AtaDDShjV1Z4AVy9lzkJ6zEY2xnA?=
 =?us-ascii?Q?bjrhq/Bzch2NUPr04HWPBlAknsB/jtyPk24NKFPaHMlmn9pcsZV75s2vrk3A?=
 =?us-ascii?Q?U7jdyGCtHciddrbvz/GyMqskNdNyicvBUI7RNA0p08NW9KP9p7+Nix2bsR6K?=
 =?us-ascii?Q?FD+sfvX62ZX3jqpGYvmaKpkgzSGS7fZlmxbMOPR7i/PGrslx7jCLzSAZ7Ii9?=
 =?us-ascii?Q?mfbc6Cm4cmo1ngxU9XT5p3iY+9Mu3m+oK/muelR7Wu/161VuShqsITqy8yDi?=
 =?us-ascii?Q?hLo3mAHXfc5gT8I1+lvI8LOG5kHjyCkE06sGdTDxk4TeZARy3HP5yUVg7XvC?=
 =?us-ascii?Q?46OMyxXpcY9SAVq6nwyqgWHokjahKSf5jfsBjCrVK5Bbw1NOoG9BX1RauorR?=
 =?us-ascii?Q?P7bqOAhNSsxZWbTl+7CZIq0LAnGc/Re5EFOOlaK9SQSdFRIQqKZMlhNfv9Kk?=
 =?us-ascii?Q?NWEpeBGJTW488NpkXbZieWlgDTc1JC8VEiTyVxN9WZaSMUHH5pnS1fu9i0Z5?=
 =?us-ascii?Q?OFDneGUUnsYAJwtwBZLQvDDDtKbzJRkZ3xqa7fvfLKzPAZp3boj3eJnQbnbk?=
 =?us-ascii?Q?LIVqHtF5dZwnjPL22KmuQ5dqzgwUte29vgMk8FyHXHwBEAZdzHa6mnB8PhE8?=
 =?us-ascii?Q?tj+0AUddBjhX7AprHMO5citrMA5O6f1ISu6+w/xOLAXfzyFaGVBubss2XP6P?=
 =?us-ascii?Q?tgdrTLBnIjRUMHoSuUqHGHxGfZ3YQFTVp557E4oTblZi6zhHuFRWPsNiMuy5?=
 =?us-ascii?Q?FSmnTsZbDbzw0c2FTvxT2Lp/KJEZg73BAULRJadbtVJwBDvEh9K2nJq3TSS+?=
 =?us-ascii?Q?+EbQUOHzvwkSgeS8Vh5+DTOJOUh875kMSQx2flQ38JnBAGaVTAuYDUSLxnxX?=
 =?us-ascii?Q?gLzu/y88taJzpf9fag1Os7834UWW/oTHZEpEUpt6IX52BgHq84K2KsTQHkWp?=
 =?us-ascii?Q?xNhvNK7bas66/7jL+gnDFsfeuIOiMrqEAx0gKH1dGOT+P2YyEB763lfTaZ8V?=
 =?us-ascii?Q?AU3pyC9MGXJEJ1X5akjZg5HxnLjnL8VzUAwitCnzqvY4QOzUO8lBY468tc36?=
 =?us-ascii?Q?CZbmy2jqZUZzyBuItGLHtQ22X/s2I858BjpIo7VDdRDi1h5ixS7v5TW3z+Bp?=
 =?us-ascii?Q?dJmdjJminRzo/RzsBzmP+EHD4qmiglveTmX2zdWTJFEN5Uv+M1T6loAB8q48?=
 =?us-ascii?Q?ndeWyeva51pdXWkDTm9jLFh+K2jY2KHH7RZxLpQIUsP0k4nzhg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8yUef1qrFur33YFcVhmghNUZvOnCGTEH0ZUJfSC4JghMInyNkV5rdQtXLJ5W?=
 =?us-ascii?Q?DY5MMsLvkE0revqqI6kebpwpkL8Gx0Dn84mTgrL7uwDCuaF8OZBgf6NFfIYg?=
 =?us-ascii?Q?M/Tzd+M/1WzK/x7/8IZZn1WrcsU2DK4i08QkzfiF0flutYqjaZXsxggfmccL?=
 =?us-ascii?Q?ddBheLtdjy0Q2pe+a+LGQ63oEePowR50LHtvV8LEb/B0oiBK3eqowOKMFlPA?=
 =?us-ascii?Q?RuO+QjX9HQwfxsl6GwRZx2L2NJ7uSGwDHP/dfdBwP+jafnnOejt4Dk6L0n3P?=
 =?us-ascii?Q?Be+OCfOc/PEFlDFwEAFrLfBK7uefVYnKD8U6YL62JcxPQrd0qVJxNf74NtCI?=
 =?us-ascii?Q?awGveW7PtM2i7iTmegETnqIK2hQFAWE/6tYZAfMvlW0VNxsPmo7ZNoNk3d1X?=
 =?us-ascii?Q?NsgA/zbqEvkFZZawbECE7zxDfSx76Rvj+J74mZTY3I2je7bMLythTltjTYdh?=
 =?us-ascii?Q?cLD9Zi06VimGDaAMG1V3UzgoaWZ7cCHdkfL7mc3pAnJrxbVysItbTZVDh7E8?=
 =?us-ascii?Q?VHtN2fbheGeuesqPpDpZqDZcTgG/lu2qoU6b8wW+pHwGWfz/DeMiD0sOaz9b?=
 =?us-ascii?Q?7vqKfiLIQYfbDF2THQJAyxUkte9UyfJHqooGS6lXFk7b07hBi0FHqDkk5fDa?=
 =?us-ascii?Q?FDuiHaWrzz1UX6YEijCPwxh0pdy+kimkrbCUmnZFIKA5giBiiWE12jvzkFhG?=
 =?us-ascii?Q?+hUOs0yQIlcnD6hq622miH4780sO7qHiyXxcmvANTe2nu4uVp4LNyWpD5Gj7?=
 =?us-ascii?Q?VaJ7hKXXIT0l4HTMtj9JmcG7rr3XIZRyu9Dam8HWxEf63ye8gjDxy2A7dvP6?=
 =?us-ascii?Q?lixddiDs7UhzqFHHl+bc59ltfNLHmVGhG8lEmO6tthOuCsjO6i1KU8P4K260?=
 =?us-ascii?Q?/oYtcfXdOA6rKzUMkXA1E7mUn3C2SSj4J2sFTdpEUGJN2E9IpatKkQwQbQML?=
 =?us-ascii?Q?1frOYUqKn5b/FfhzcgcXv/BMGBvN4s9I4+n8u16GP6TM8B4CK9kTWqvqOfNN?=
 =?us-ascii?Q?RO/q5lP8zxq20qAyBtR+zBW/qWP5wGSBRavV8D3umsVbf291G9/30e9j62FA?=
 =?us-ascii?Q?xeivyAEuXnCVl0281OxVvY/DU2smSisneWbeLLaHfNevsXSBScFH2sUmWG4l?=
 =?us-ascii?Q?GqaGawUvyrSkmR2YrILF2Nsfm0e1H75C2ZMDalSlJa6F6ZYnTq9d1VmLiq7u?=
 =?us-ascii?Q?DbZkJBMEeTTAK1xL8TOVKgaaair8Z8zuzAw8J5L5RFt3jBvYyI4863aVAXJy?=
 =?us-ascii?Q?WU1rSmj6nSRADORRkMbsVLbMpI6BsLW+mpdmHBZ0c5U3zgstHxyTjbgNhuyH?=
 =?us-ascii?Q?ulX1wKJm/lXQ7wHTd5wFar2Eg6QQvvZpsLKtBmUoNylazfNuQ67ouPHmzdEv?=
 =?us-ascii?Q?ueel6UeCtV9nCpWWsnD8i1uRTX6JeMGsCX1vpMNr9H9CgolH0+rB9By4y1di?=
 =?us-ascii?Q?plM3qvlbWtYgANK6WXk8OuFd4XjmX04Qcbz92MTvIABeOZN81enb8+ARKjtB?=
 =?us-ascii?Q?xoCi6uD9UpAGA99cWwxLy1YiydVZkCFPFZY+ngUnyd+HOv2942k0RkTIMMeD?=
 =?us-ascii?Q?BsG17fkZeZHQw3+GkBCLzrUGqIJLzu2ywRoP1+st?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E1A09A07D124864F953D67593CDD1C28@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2hlQWr6T1TOKUPly4F1ozmj/V+qovMWkEoOsTJgmbfMJNsY4zntVW2eL0LHFcRv4Z/KsH2JuZ4CG1jqlzQesUpAXfQ4zTDOsC5yhx47X5GftY59nM4qUt0D108uSDeEbFphEiMzcgdODFav5VfKPT/its6zeXatjyyIFb8CXYtjW9WlCmQGYzlcLMKjkRXQrI8hHX8blpAz89ZmN/eBAeekXiA8jAZVapEAqKlTmX8qBj6315Sb35rAroWgtPWtDJGcJOKHB2YEVri/eCDh9pH5bMoTFEemc6I7kk9khApJhx0ts0Ro4FxVgXfLAkNwGpm7SUe0qDsTVDeVfkyCavjpRr5STyDuYIIAwyKDI9o36aixbFSU/Umk9jkuW7+4XVopbb0kYntPVA49J9jVu1TpS+XI/HWh4XxOWeZO/mFWDLa2PdFyKhgctIAMYs3zHhtxOnPy2nq84xmRBdW2pLLZH3p6gVln0TrlxNUdwCrj4ZhxNo3AJkC/LzW5BSppg7cX7GRRf5UPJM1Qk4uRHR0ozW+vxMlWH8TkbuZ6RnpjYqz4QGTPmeCMzVewUcWk8XhjFufpPXTxTZLJZ7xse3PdmygzJ2L8KjEQANlT+fEGS6n4qUiHWvpogjhOw675D
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82bd79da-4d1e-48bd-80bc-08dccc773ad6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 00:19:23.9513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WtSyAB4LlXtwbRs23+AXEZqP94NB53qzU8Yrg5PIBI/iq4wfHgrSs2q76bKJySDuUW9oao67w+1okB+MSFICUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9684

On Tue, Sep 03, 2024 at 09:30:07PM GMT, David Sterba wrote:
> On Tue, Sep 03, 2024 at 12:33:18PM +0800, Xuefer wrote:
> > Thanks, that explains a lot for what I saw happen and what I read
> > about emulated write pointer.
> > about "intermediate step", it may be true for compatibility and
> > migration, but conventional zones are IMHO really good for metadata.
>=20
> Agreed and it could be implemented, but the question is if it's worth
> given the number of existing devices.
>=20
> > regardless of the idea bout advantage, there's a bug about conventional=
 zones
> >=20
> > sdd 3:0:0:0    disk ATA      HGST HSH721414ALE6M0   L4GMT10B VFGH8XBD
> >       sata
> > strace -f mkfs.btrfs -O zoned,raid-stripe-tree -L bak /dev/sdd -f
> > ......
> > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) =3D 0
> > [pid 12871] munmap(0x7ffff71d3000, 266240) =3D 0
> > [pid 12871] ioctl(3, BLKDISCARD, [0, 268435456]) =3D -1 EOPNOTSUPP
> > (Operation not supported)
> > [pid 12871] ioctl(3, BLKDISCARD, [268435456, 268435456]) =3D -1
> > EOPNOTSUPP (Operation not supported)
> > [pid 12871] ioctl(3, BLKDISCARD, [536870912, 268435456]) =3D -1
> > EOPNOTSUPP (Operation not supported)
> > [pid 12871] ioctl(3, BLKDISCARD, [805306368, 268435456]) =3D -1
> > EOPNOTSUPP (Operation not supported)
> > [pid 12871] ioctl(3, BLKDISCARD, [1073741824, 268435456]) =3D -1
> > EOPNOTSUPP (Operation not supported)
> > [pid 12871] ioctl(3, BLKDISCARD, [1342177280, 268435456]) =3D -1
> > EOPNOTSUPP (Operation not supported)
> > [pid 12871] ioctl(3, BLKDISCARD, [1610612736, 268435456]) =3D -1
> > EOPNOTSUPP (Operation not supported)
> > [pid 12871] ioctl(3, BLKDISCARD, [1879048192, 268435456]) =3D -1
> > EOPNOTSUPP (Operation not supported)
> > [pid 12871] ioctl(3, BLKDISCARD, [2147483648, 268435456]) =3D -1
> > EOPNOTSUPP (Operation not supported)
> > [pid 12871] ioctl(3, BLKDISCARD, [2415919104, 268435456]) =3D -1
> > EOPNOTSUPP (Operation not supported)
> > [pid 12871] ioctl(3, BLKDISCARD, [2684354560, 268435456]) =3D -1
> > EOPNOTSUPP (Operation not supported)
> > [pid 12871] ioctl(3, BLKDISCARD, [2952790016, 268435456]) =3D -1
> > EOPNOTSUPP (Operation not supported)
> > [pid 12871] ioctl(3, BLKDISCARD, [3221225472, 268435456]) =3D -1
> > EOPNOTSUPP (Operation not supported)
> >=20
> > BLKDISCARD is not supported for conventional zones on my disk. I'm
> > afraid the emulated pointer is not reset to 0 as intended
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D219170 this bug may also
> > be related. the ending result were the same: failed to clean btrfs
> > signature on "btrfs device delete" which sit on conventional zones

This is, at least partly, intended behavior. While conventional zones on a
HDD does not support discard, conventional zones on other type device may
support discard. So, we need to try to issue BLKDISCARD. EOPNOTSUPP is just
ignored.

Also, the emulated pointer is calculated from the extent information
(extent tree) of btrfs. The pointer is placed at the end of the last living
extent of a block group.

As you said, for the traced linces, the superblocks on conventional zone
kept intact when BLKDISCARD returns EOPNOTSUPP. But, I think they are
cleared anyway with a later call of zero_dev_clamped()... Let me check
that.

>=20
> This looks like a case we should handle, though. The null_blk devices
> can be set up to emulate conventional zones (but I don't know how
> exactly this replicates the real device behaviour).

You can setup conventional zones by setting null_blk's zone_nr_conv
parameter in the configfs.=

