Return-Path: <linux-btrfs+bounces-4252-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED618A4793
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 07:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A144B1C213EF
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Apr 2024 05:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66E46139;
	Mon, 15 Apr 2024 05:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XBtOKg+4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oJcr9262"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB8F33C5;
	Mon, 15 Apr 2024 05:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713158693; cv=fail; b=rBfCztJ9u8V8pfYeFPdbVecsNOcxda+VsNU2YT6vw4LAfhWJ2mtww47WgofrLjnG+qGm15VRp3R5doSPcRjRrir0Bo1PLfEbdNLwjVrjvExr2X+qAGFYdaK7Ri3MYIijsucTkKXjp+3UxrMKDxWdk/0Kw+yldLpvA+oFHTWlDRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713158693; c=relaxed/simple;
	bh=lNnpa92EIjU9sfqirh/18ZrUd5TAIegk+zKI82EWsfA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E8uMRXsr34VDxsbB9UwaN7HIWfeXmjFHyBC4vgRdCvzJPc9HYOmis4mGb/4/6VzbWE2Ck5c3eka/gXovry4+ljrbLPeYXEc89QtlhwmLpOJLW48KwY2BVbpWOxnOR/ExauyB1Y8Mh7HrlRVkMQfuXnjo9Ha+dDaGnnJRt1Yd7O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XBtOKg+4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=oJcr9262; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713158691; x=1744694691;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lNnpa92EIjU9sfqirh/18ZrUd5TAIegk+zKI82EWsfA=;
  b=XBtOKg+4lKcJXShUQ5CVPnve8aYCLaJTeYWUgoTCnwTMuvH/JhAnJvji
   oY/A49mErpIj3zkJVOrCAGOjuUpOyjsUzV+aDoTNDHWKXacOeoK1auz1Y
   PMwWGMIlLrf3EEO1B8dJBBiZIEi4N79FlswkZ4yYGcAzO94LN+SHQ3z7N
   G0Ourg4AiT91xzVhvA7SLc5Fztlm5xa5GtD32hWr+Yjn9bOldjhbdpVYe
   HEaGnTXrpNEmwEh9vnJp0PSUYFmX16OqlEZ/5ZUSJzkdw6KqP+6GaW4Cu
   zSj/gRdvZur2NgIsKBFhUYgPN9RSSe4TpbtSgplCvPW5uJ68GxEudhYDP
   A==;
X-CSE-ConnectionGUID: fyutBs0lTR6CIr7SQ42+vQ==
X-CSE-MsgGUID: plsT9vp6QH6XmOdizL/KPA==
X-IronPort-AV: E=Sophos;i="6.07,202,1708358400"; 
   d="scan'208";a="13976160"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2024 13:24:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzbXYTnAbe0JrrpfctgDW5N717lfkcZsqV9Qh3gDKUDnQNoeAmEwyL3pB+YPwB3NA0fM9IoePNiM2oIwCaKwW6UgXRWb5lDpLGTbHq055byUHqXw231L6F75zklXpKeaciRignyf/LIoy6wHT+8tqavo3MChUwadEPHC+p2IGgACCDjdNWxPhO+jAaiH4AcrHWJQDSz0P5u+PRVl97yJ9ulFzyUVYJHIV9Aftyo2hUQv5KAh3AlNZnH8uq39OtpC6w+ewcekCviIlWTmp3f0mMZYCMHhZsOkkuRQzQSpsEwu7ZlY4c0jVzOnuq3wq9PY62F7ppVCv9jHEbJShmQB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNnpa92EIjU9sfqirh/18ZrUd5TAIegk+zKI82EWsfA=;
 b=WKXVdEqkXH3qmPVJOCIIiQ+KYNap5xXLS9AL9nQBwKvLCMY9rbMuvUp485Oa4R4NgjaPKdvS48qLxw5i4/zTH0haiH1yDZkqY0qHcSsBp8lF9G/4ftuTUYTu6ZmNgCbZEKCFLG3Uc1VZn8e94Wk8w+77pR/BxuP4LfSgI8pZVxLcDKuXFPGxIjk69o1bcxDF1yzChmAeib443x0MDexlWGsLeTMjsbDPaNzpPVKQ5YBrPwi4tOLWyDrsqDnkxD3m83FKN5w9o/qww34HLLsYJHWhKaMDMGHyIFkGEM5ZenS3r1/3b5lC43egbPQgfVU3LT5cO4PgRIu/yjMhcoT3vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNnpa92EIjU9sfqirh/18ZrUd5TAIegk+zKI82EWsfA=;
 b=oJcr9262iFO4Kj2slP1GSwjjalvLYExFRdPhOfLbpuUhnrhbUTq141r8TqvcnGpsAX3lV18p71+yUEMZj1qPQGAjubLhYqNlKXUAo5Y+A8QpAOozMKJWTehb2oDNXQ7kEPnvu06B85D7EU4KAJ8I5aKpCQBJ3xbTAK6cQrdanfI=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM8PR04MB7926.namprd04.prod.outlook.com (2603:10b6:8:4::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Mon, 15 Apr 2024 05:24:43 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 05:24:42 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
CC: David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Hiroshi Takekawa
	<sian@big.or.jp>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, LKML <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: btrfs: sanity tests fails on 6.8.3
Thread-Topic: btrfs: sanity tests fails on 6.8.3
Thread-Index: AQHajulvzM78/SQ7+UymYN5WynqSQrFoyNuAgAADwgA=
Date: Mon, 15 Apr 2024 05:24:42 +0000
Message-ID: <igqfzsnyclopilimyy27ualcf2g5g44x3ru5v3tkjpb3ukgabs@2yuc57sxoxvv>
References: <20240415.125625.2060132070860882181.sian@big.or.jp>
 <bd8492f4-a12e-48ae-8ea6-a9d4596a6f72@leemhuis.info>
In-Reply-To: <bd8492f4-a12e-48ae-8ea6-a9d4596a6f72@leemhuis.info>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM8PR04MB7926:EE_
x-ms-office365-filtering-correlation-id: 47cb501a-5c83-4ae6-6c73-08dc5d0c5af5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UbSrKYgYqqtLD/lQVHfIQ2w4U3+W4oVxoZceMfGmynLVmaouBi59uYjn31k4qLpBpfrn/6/xf2OKzxdnRA1egcVsj/lis1jlJ7jUWvM2LVgu4CL+w1uPTJiTsJVobbl0JH/a2nBpfOclw/vgcg3rW1UhFBKRjEwMfUVtI+p5F0znG9488TbL/JWtLGfrhmJKh4NRbUEAaBmPeGzaZIS93xlJZFtyYizgO4sc2wRzEZLqVhUFeAr3vM9bqjYYEc9b5u4JenWmMIzPaPxQNe54f8BEZUAfXUc45UVL/7JkQl6zBfKN8ZwVFKp8gXwJC8qQeGRaoMfjhLmsiDDQRY1dUanf0aPomilyEqRxkXSSq/q9IeQTh9bSdOyNkXB4UPCmrvWeM2xGL6SgsK+scbaIfZDqROfKxTYaTvO+b0IJ9/bMqWXUFXMskXf5KUi4W+u8tkwKiKkCLIzqpeN9iNNiotEAZkLYElPRZ9pEQzEKQqz43W4WcXDXVeVzX11vT7wU2sq1sjqIocMmaAJu7xx/2QB+1XunvnvOI93Rle23Qy+qB7lUveR6BO5qkwS3Ip/p5rNyLAVM8hWFYJBC5K7Ogib1Myy3JIgQcTsIg8a2SgJ4k+z+qMcKBv1EiQFPKivlYoiyZ+vYvqRJb+w0DWWaBG0Bris3bShwRrE3OYvw6e1KwzUUF0F9eC/HrGE2DSK65uikc1CoSnLRcn2qI5QYs2j+udlb09sDyXFrLglVuLU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BPIJESZGcY/D3ZXbCPrFuhYNSdxz7cvbPwTwZwKmChTJwyyNzwgkb706Rgea?=
 =?us-ascii?Q?3D9q5UtiKD8tKikOTLkTBlR2Y9QJkVnYOmYFvrR/DZ0Inc2jGC9oHSOGjXpX?=
 =?us-ascii?Q?Z7z4mSQ3bM3/V/+SavpvriS+97HnJnEVDdw2HlP8VXx9BTFAktnsScGZEiVD?=
 =?us-ascii?Q?p+cQwnafKN7znw8c+ay2IR5kgCZfDwnmparjKIBV5iO4SEHCHMp6UDkz77he?=
 =?us-ascii?Q?ZRS0NBYjpkYf10pR3tmUvVNum+5JmKuBG54gXfcqpJUUXJgpQwrR9xvLY/o+?=
 =?us-ascii?Q?lChjntosZufpeNPLpRvDYmEBpukpQlyVIDWzeG2rhHtYXWY57ietEqW7xkvT?=
 =?us-ascii?Q?XE9NedQHabJfhGoS+InovVSiqcoAS86w+T/k8kWaFANyOkatDrWpiFpGCQ5o?=
 =?us-ascii?Q?ke/QMuJNT9uJMlHCjux4HQLbyhVjE6Gx8nH/wZq8udhf83j9Hgk6qPoWVcLn?=
 =?us-ascii?Q?JlVtPug/+BeQeZ9oojYVHST+bly4BE8tjg/nSqnTnuaaU/pMzp54Q+UTk5xT?=
 =?us-ascii?Q?mFmSlMKZpDbjqo2YXtKfnoLgtGCkQu+46Hzp0a48AwNDglYhqP3JyU9lAOuC?=
 =?us-ascii?Q?Vm0job/aIYaB89CbXfYNtm3j8RWIsq+aOPPtVSBNZnT8NMSN0pey8uiT5vtd?=
 =?us-ascii?Q?i00sLEx5JPMytwdpbOuaG+ncZnWxt2jMtSsXe+Q75/mt/iw9RDojYRsnyRWA?=
 =?us-ascii?Q?p+MTrqtrVNAP5W8nw1JhKDacbz/jAjvvIS97jdDPl+8FRCDetmpDiNgorcbD?=
 =?us-ascii?Q?/zjBQwAPC6FlIPlVT4yQXFQdlIAX2wlJaBU6p49pG4FOQpEJIuPFM9IEb+iL?=
 =?us-ascii?Q?yLCdQ/EPr9+rSmPQW2tIDUDVP7NT5COEhXx2AcP5iJz6fszHZePPwOkvsYVp?=
 =?us-ascii?Q?zQyB5WpbzhCVSwf+gjF52oYrseuPYbJvC8C1RB2r7Dqmpr9g+MQMJR+lmP6f?=
 =?us-ascii?Q?JiOTSSnzf15CN1XHgYTb26zF87oDC+GbHfrqHUjGAZN6JMeHGTbOPz9fR3uA?=
 =?us-ascii?Q?McPHTAco4r4bcfLL4KSfjVUBTjQ2Ap6+WA3xQFs5ayQuZyBLTh2zsm+l/K8N?=
 =?us-ascii?Q?1jTeVAPlIoZrN2olU/3S04EoTq7RlK0tf0k6wE6NYS2+RN6h2SPGqOdJGKp8?=
 =?us-ascii?Q?nodo09RYBCGmvYvRdG/8Wwfw5dxEiyJOb3XFHZwxnjjhNe48fBpO32P3svxa?=
 =?us-ascii?Q?E0k8OrBaHIVPIzPLJ/ncX8Dp6DsL/7/hL34aglU7v4XCotXNrSj0iqVTXcM/?=
 =?us-ascii?Q?YKNK4WcnYcOGjgPjaTbQARWVfRJGrdjBzfEI9oRACsfE4EcBk+euf9n+PT0x?=
 =?us-ascii?Q?OVf2TR4oByZe9OdjkGMd0WdnLOcqmtCB+SXvJtkdt/r22cuSM7NwvhtvOJXg?=
 =?us-ascii?Q?3COgKA/jtIWtQf8TpowwrYs4/sSDCf7I87zytfWISlQV699uO9ReaLLLuH2z?=
 =?us-ascii?Q?3XvBJlbmEJueq3bP9cNeT74suwQxZV2+OjBjdNS8G8X3IcB+L/FD8g5SHjFz?=
 =?us-ascii?Q?O6EUIhc4LsfQV4EGNo/oBgGtU+lcIU1YJIOmJRdR6iEMATY7T7k5+aFgVGDM?=
 =?us-ascii?Q?CcbT8lqndBgBby8oV7xkIhjWi4vOapIUFksgiLnZn2Ih+zDdi64yejKc122o?=
 =?us-ascii?Q?VA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5E15175306DAAC4183F98E3DF4B5E07F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lmOBow6GW4RA9b2e5I09Q6kSgZbvuI3BPcpo98Kk6O7Ged43LKfqQTo1I/thoRpRp1C3qQfMmevA2F9tVTB6OMkw7T5TZO1azntTf7WL1KAr768Z5HMpAAARlY+XA3gpRGhhMJOPR8ggZWzV5c922iCo9EYYy3A55G0zeDSSaPrKiCo4MWmr17U6cv4HIQ1tnzjcmnrHilox1eGOqMZi+AqsFLYSZ1KD5tKHueiZRM0+QpSgGxDxWNRsdEkMA88UHyRUsVflR5vXtgnIjyxtjOxEBF+wfKtN+Z32T4OBnL8QosMQFNvz/MV6Ql62Kia+N6I7M67yrijCMJJSPrzsZp6Zww3+zgtdrW49wSEJo2d8feuuMzL0PEhd3ibkwhwUErJSxv/PoJ5SQBGEpbs6ZfH2pHRPe1dY8WMMx3vjMYrvczy16pPy6smUYJppSkx9HOdi2D145B32CYENDJyaVKwifeAUWmO/CNdHvGh4CpWdRv/EwcQb8fSsROYpr64TRkPXDsNF0AC1/Cucbgs5WuDnAFkogkTzKEpTOh4Xn0Gc9hhc4W36Wy5WD7oCB6ER9N2200VkquuxLZhiJU4mXfifWgKXUy9zqHgPOx5AaSiQxh5B1Yjw4FvHE0FT0ysP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47cb501a-5c83-4ae6-6c73-08dc5d0c5af5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 05:24:42.6254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UzDC6OjLpjQCkGxw0oqHIXCJzOrMv0iX627aQaZQBUWn0sgiQeFxVYbtAjIJlxLtUZcQJJg71gK2bfx8u1rTog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7926

On Mon, Apr 15, 2024 at 07:11:15AM +0200, Linux regression tracking (Thorst=
en Leemhuis) wrote:
> [adding the authors of the two commits mentioned as well as the Btrfs
> maintainers and the regressions & stable list to the list of recipients]
>=20
> On 15.04.24 05:56, Hiroshi Takekawa wrote:
> >=20
> > Module loading fails with CONFIG_BTRFS_FS_RUN_SANITY_TESTS enabled on
> > 6.8.3-6.8.6.
> >=20
> > Bisected:
> > Reverting these commits, then module loading succeeds.
> > 70f49f7b9aa3dfa70e7a2e3163ab4cae7c9a457a
>=20
> FWIW, that is a linux-stable commit-id for 41044b41ad2c8c ("btrfs: add
> helper to get fs_info from struct inode pointer") [v6.9-rc1, v6.8.3
> (70f49f7b9aa3df)]
>=20
> > 86211eea8ae1676cc819d2b4fdc8d995394be07d

It looks like the stable tree lacks this commit, which is necessary for the
commit above.

b2136cc288fc ("btrfs: tests: allocate dummy fs_info and root in test_find_d=
elalloc()")=

