Return-Path: <linux-btrfs+bounces-2380-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A45A2854D82
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 17:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32471C275BA
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 16:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B1A5DF1D;
	Wed, 14 Feb 2024 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e1QbKGs7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xME8s3JR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465C05D91A
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707926420; cv=fail; b=FLSs8iKsqLFxz3pRP1zZD8OicwWoiZndJoc06EQ5KxKpbNBaX1GKyrpVehj3PelNdDBoMqrLnLsH9JJlxXDLigJCUvLO/k65QzKYsB4nEGt7e4nNbXf2Y5atdT8OmJItsFMB9nk3H0OyWZAexcSP4ARxElnIZbOhckGUMyp/aU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707926420; c=relaxed/simple;
	bh=NHaJX6YBrslA+IrV+cXRti7kZ6avOzdkFAhTXLQZlpY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G0CEXcaB5nhaQ3HJ7ggTfY4BNQ2RYgsmVrPKxRvzFD8TEB+aQR1lmK42W7QHKgy8bTYKwQQ9mtxFk/IdHMSLGgkAGlFrpy1Ej2foSQLBisIQgRg8hlfwPeRc7IO8AUqt1XqRULOxS1Y91IySJQ7T+kWyTI7qNg0AIv7172YSZU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=e1QbKGs7; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=xME8s3JR; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707926415; x=1739462415;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NHaJX6YBrslA+IrV+cXRti7kZ6avOzdkFAhTXLQZlpY=;
  b=e1QbKGs7EFizwHMGXYuRacRCcVS6FOQ2W0Fx1oFP31dUnCD/PETvm3Jk
   j2nXt+VXu/TYnmCx+Y/q1pCpFGby2CgOgQG1QtrdIAUWxf4TvTSTfuj3B
   LuSBDL9/UO3Z21FZbrUP/4D04W/8Wbt6CRlGiZ5DuUlx7wmpTC9vmrQca
   CsKEHeN2IzfkAQBeiTAZKlpUWqG7Su3Ati1FaOYIswdQDoIMxRWnfcL7q
   R92CJqDYkKwwKCleN7Y46zeiLyDYji0b5KncIbeEFniBgFBiD3mEcGINz
   /2ROY0lRwI5e8RYLl1kRrH/p7mgbM1O/csUi3A8UyxltIF1xEWTre0Png
   Q==;
X-CSE-ConnectionGUID: E25gQpFwRauaDMK39MCOcg==
X-CSE-MsgGUID: MZANCo6MSqqP255fBTqsGQ==
X-IronPort-AV: E=Sophos;i="6.06,159,1705334400"; 
   d="scan'208";a="9241968"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2024 23:59:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAMqAX8t0cFZJ+63hd4pC1aXYVzGqQ0e5bgqiKgWFdKhqxqvB7cqbE8t+ywkrvM26CmmG6fAzqP2xyKujJepedpsc6ZjCod2FgEJt/GEeReb90za1E2WurDLQ2x2YE06STPuyJ0dyt1LLFoeoi4Q87ZEJ4KOj6xiQzR3srkwwmDY1FSlTu4dNewjVADkldWaxuklzvm1NL9zOIulCnELpAlHuNp5Zr1z7U3EcDma5ET9CVb/R1wWNyKxHpyvgAglCkyap9/WaP3sXjrWFeI8pXt7ncAPcN5asL6t4OLO/thX54cDCVAVeClYnNsiRuT+V6NzcFx5JmIQ3OXjSFCJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v49T0SOVgz/wZgXCnNqDC1Z4MTfTs+gGUyo80mDYaWQ=;
 b=MGXv9p8owLz+msODotrMhhA52j8ixzX3jBAPiuuq35A854RDOPBpeM/AZkr00yvHA3Pe+P+apgDGWI8qenaQ195JiuufiT2zPQjk3Qk0B0gjl5+N+JiEMbdzKB4eptBMs1pdsKGONcnVuwNBVhLI+NBpJjbq3hrckqdnyk00O7y0UpCsp0lDUqGAMewkwUNGx/A3eCrD8JcjWp1YpD28bLJS+rR/zWRshRJH6gzZx7l/EHoAXN4UPm9CBRtmsKXo5YBkUJ1ozPXlToxMBwe6j/qzq6YzGjUnX0/qCzYTOZkQjrMh6dVVZP3+Ro/Apa/wSwdGpJdGYCfXQaAL33p/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v49T0SOVgz/wZgXCnNqDC1Z4MTfTs+gGUyo80mDYaWQ=;
 b=xME8s3JRftPHV6KFCL26LBR77ekbnCHnU0XwZJxtGXbFTDuqZRa00kMTCa84jEsSIB1zTQCwfGmSmzRoaOcUj11jtm3uZyHpWqmPRmddwaRhLnuPjbnWETRgQgRCCXm9G7pO9IdzeUQC9tEMtDB1y0oQp6qG0VjiwH+f9Awm5y8=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SN7PR04MB8478.namprd04.prod.outlook.com (2603:10b6:806:354::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 14 Feb
 2024 15:59:03 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf%7]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 15:59:03 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.cz>, Qu Wenruo <quwenruo.btrfs@gmx.com>, HAN Yuwei
	<hrx@bupt.moe>
Subject: Re: [PATCH] btrfs: zoned: don't skip block group profile checks on
 conv zones
Thread-Topic: [PATCH] btrfs: zoned: don't skip block group profile checks on
 conv zones
Thread-Index: AQHaXlTvy9X02weupkG5lS4J3sYGH7EKAK4A
Date: Wed, 14 Feb 2024 15:59:03 +0000
Message-ID: <xedz73yk7lmrlajyfszpmchsla3df4vlvfk73liiov3zm42ooc@h5alehp2nuv4>
References:
 <0cd08a6b0f5285498811504d3713ced3afe3b8d2.1707812175.git.johannes.thumshirn@wdc.com>
In-Reply-To:
 <0cd08a6b0f5285498811504d3713ced3afe3b8d2.1707812175.git.johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SN7PR04MB8478:EE_
x-ms-office365-filtering-correlation-id: d2990977-a826-4006-0102-08dc2d75dded
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9hjkE0Ez6H0qxcbAMkYAkidI5qxXWZ9VuMy6SuYdGE2epeDaiqs4/DZ2nCVMPjE93bhE4SzF8gQ7R5H0a5NqY3b82hrMUdUkR6+i8UWvSKfyCDsXVCjlTsmgbNrASg8iCyAsQps/0eGuWH4iMiC0pb7ALLgkkS15afNzmLfpoeexZKRla0c0xKQ4jkgpAjEW84sayoh7K2NyDNEI9TVTWrWftSj5iFPMLgFrphbjrLoeupNGEZEtnl2TE9jC4Y1Nz4Jrri9YSopgwCdniUM4RmljHAy+fhXNxGbEcJ4FYySfhGfnPCkoGlsLmpUbtxMerw+JKLADgT4d0RXKIl2zHxk3fien0h2RhsuveIoVBs/0oIK1+zfxpq2DuRzXHLDwBrDR1giGPMISbCDxdxkIx2KMu2q+EKU7nXwkcIsZz6miJX/OfnmSRVz9xt+nY3jiDh1SsTX6rILPYATOh7gpcO5VgitbsUAbQ+9VUGGsXW1Q+sUZJbyaLKYKFKho3ZMlC6gjZZEpqxyUydMhknA0/T8X/Yvz5j4LgPY2Y5BbuGO1kemJB3m1cVYQF9MJY4+47Zfj2HJBkEkAuHpTwY3raY1AsJl4qcPGnBckXWC2u0wEmJMwdcPMT1uqU9uTrGRu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(4744005)(33716001)(2906002)(41300700001)(71200400001)(6512007)(6506007)(478600001)(6486002)(9686003)(26005)(38100700002)(122000001)(86362001)(82960400001)(83380400001)(4326008)(5660300002)(8676002)(6862004)(38070700009)(76116006)(64756008)(66946007)(316002)(66446008)(66476007)(66556008)(8936002)(6636002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RsenkbWk+L2blEeiSlZVNesSHHnrDzHoOPBb+AIhZL5yIYmZDuNgoJ1SLg6a?=
 =?us-ascii?Q?00LKi1YvUVE0CG+p+NpxFapGp3kfDN4tLWcUwfpipHNZZfVBxKwAs8+g4Jyn?=
 =?us-ascii?Q?4ViLLCeIqazyJRjNOAi6OVHuaOgglf8DVeoI+4e5eEwyclP0U5FGC7xQ1XA/?=
 =?us-ascii?Q?8HJBxL8UzdFMMsfp0+9oxBUNs0yS0ADYCW3XdnQAXKdRUSzZF+9061hAlrsi?=
 =?us-ascii?Q?h5OWOlR6zsl4+Km2rm/tdoQL0vRackZf2N+vaXOV/E+Ti/DfL+rVizbCa3J0?=
 =?us-ascii?Q?CfmElbf9negKeRCvTzlZb8Tlp2xTFGwuJO+JSi2pL8aSfyXhVYo4KeriifCy?=
 =?us-ascii?Q?KpTlmPDd+P/PGr+phLnnaY9/B8hZH021fXzaNDckT67FVE3raNvGICVPG0gw?=
 =?us-ascii?Q?xtyKmSDJmcdxIfOMIlSAgBNLAYID1q0dWN8LWf21I4atJ8O0V0z+g5jZ5+cX?=
 =?us-ascii?Q?KNLCsH23syCSnTOJijf0LgDoS5nQNF2BLNej6ZUpP0G1eRYNSwYtVfkcny3A?=
 =?us-ascii?Q?RbfRzBetjHjDympfysecqFw2MCeyVdFZ/gEDYwfn4FdEIp8hMOpODoWxLsb/?=
 =?us-ascii?Q?XNzl3US7xv4NxbscRsT1Iy1QznPGuM+y4n5Qr2V7u/M/WD6gKPD9R1ya3eRN?=
 =?us-ascii?Q?+pTFnyCLVfia91l0owtNJjDBeBEvTtVFj9kcf7Loh0mAxU99HjSVa2luwGy7?=
 =?us-ascii?Q?6gqhHAUVNMoMququgBs+Dq/mGt6xLJ/4Y+okRRBSoqgGqDJwyQvv6FVX239l?=
 =?us-ascii?Q?s8cervyYJVQSM4OQikjCniTNs+k5tGcsuoXqm74p3WJBccVj5GLCjrJfyXya?=
 =?us-ascii?Q?2occnlp9u6MTzc4A7kvai/Ec5Hj7WZC2tOgkPRifUAMhQjWPNUw8tg+GyOPA?=
 =?us-ascii?Q?B43KTucWL7vx0EoaJepk1gO1cQ2W8UXL/DSKVbEup2ikjWavtULEM4kHYVJ7?=
 =?us-ascii?Q?wrxCnu2ksKQSBLdB2fZ8J9uHPidskGJU6xMaZnPKBaRgCqlFR4SQ4oEQjp0W?=
 =?us-ascii?Q?p8kwVLswrZMUebSnVMO3KPl04vLiC5kgOHDGp7IsCzC0yqobS0rGyA81WrEe?=
 =?us-ascii?Q?NztnQXTIIWLLg0A5WDCt69JkCn//Ae+3kbgTyPqk2EfXUi3/cwGVKZmzqdJp?=
 =?us-ascii?Q?y9J5Il/z/zz12Em3l4ak0yzl26g1thSet99SlRbrC3Mv1Y5MFjyGxGJAZKlO?=
 =?us-ascii?Q?7hGKsxn7A68fw0sPVH6S3pyDjg7nOcAJnR3T1E8ZDRHgI7BK4nY28uE80ZUq?=
 =?us-ascii?Q?ogDrjEfFalwwHqrcClI/zgb2slGhDOHM6YlJTzYfEudFsMcni3hsCmxn/916?=
 =?us-ascii?Q?S/8pBT5iCqHWP0nvhi+rnWAUnWTqUAtAuK0juIfogQXNpTz+Cj41F7DSVR+Q?=
 =?us-ascii?Q?jxvYh7ldwBHhwr/1bfpL52rEux1VTCrLJAldVHHRELc02dl00ekWhopdfJ5i?=
 =?us-ascii?Q?Z8Y3foJwFNsAWZdKf/uKeU5uhVwmrY+MwmownME35lYieExUh4gsC2zBE+Na?=
 =?us-ascii?Q?DqtAGf2Q6xGH8l1mp3nMEckh1IUFQOoKLcfh/EssLIU7p0xtM6B47xiWE0oD?=
 =?us-ascii?Q?FaP7A1tdNOr8yKSVDlEKQnxNzYl7W3X/WyhVZQu3dGmvfiL0jFeLBm2WAI2A?=
 =?us-ascii?Q?Ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B13EC3CEBC9F8F48922C24DB74144D66@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SGIIPbSONrKojiZS49nfUiK3FdZAZxaEO6+pZH6IFCE4KPFQYK4cU9FRuF91Ce9Q1vKoekb/7Yx7YLvtN1Blg2OFQt1r7PNPh9jHmLw9C8+7GeycUU/T1psKl+97xv4WoAw91omY2xPv24fbKwwENpy6psRFK1vBZhJSMBXYyANyotqHhfr7PoxOHImr45W8YQta9gJlJG6UkJKd+UFXm5Anw3ALRPKqPv7pBhO2OButO/7zfavOVpVQCRLvAyOpwNZz8T6l/PP8UB7GxR+IeLiavzm3pIpUszia2YFOHAdFAvQJpo7ssSI0iun2dV7okUN63ANLMOyNxhyvLGicqecolP1g3nIqCip4enFBMgy5tL7MDKMBIu84CaOEgtriRAYzH/GMsugfI0/aAJ2WspMQpXGM1LuGJdwdezGmGAkk8kFFRC+fuU2Bk1EloiY8RxEoWt6eKvIyYNbAyoP9hob8It/eawOBAf+ZI9yB57vsTmp9tGuSJa0/3E8snniv2rFVPPMrQ0f3ywoP6/7atfdJXcm+G+HpNPMKXx1pBdGDXuStrsxr1FBXTsIYg5pH2V4XRSSCb/Q3gKSHdmE/IUGihgHnHWVx/3qG+efZK7vY/PPzBOdxRWFS+IjLoDjp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2990977-a826-4006-0102-08dc2d75dded
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2024 15:59:03.7214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5fnI5DPAq9zY9NV2RdHUpMEiUU0DsuqWuEhAmwzidCpqU7dqwr1JvzDBumYBi1NpZYUIzjbmtJhS7Wc+kEgBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8478

On Tue, Feb 13, 2024 at 12:16:15AM -0800, Johannes Thumshirn wrote:
> On a zoned filesystem with conventional zones, we're skipping the block
> group profile checks for the conventional zones.
>=20
> This allows converting a zoned filesystem's data block groups to RAID whe=
n
> all of the zones backing the chunk are on conventional zones.  But this
> will lead to problems, once we're trying to allocate chunks backed by
> sequential zones.
>=20
> So also check for conventional zones when loading a block group's profile
> on them.
>=20
> Reported-by: HAN Yuwei <hrx@bupt.moe>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> ---
>  fs/btrfs/zoned.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Looks good,

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=

