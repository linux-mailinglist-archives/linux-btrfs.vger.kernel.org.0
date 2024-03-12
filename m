Return-Path: <linux-btrfs+bounces-3205-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A6B878C3A
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 02:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC641F221C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 01:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A6F6FB9;
	Tue, 12 Mar 2024 01:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QFtomXvB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kqIOa5nx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C7E5CAC
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 01:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710206535; cv=fail; b=OMrWMBr7At/VL2vUdf1MJ63T+Y+ChY8Gql1LLP9gcElLiccOaDmffUJnU6wu5QTFug+3MtiJs3Obd7um8uSYrZ1Gn7zIBJ3g4ItiaeA+FwRhZsGV8ur6sGOAcP4BbuOQb1NIkhcF2E7sZRt/AF5wAlT4ZB2Jp9K5W8/8mTWzNBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710206535; c=relaxed/simple;
	bh=ryGBm/tNrBnaWFF3NhQse5fFGYxMXmsDLP3wwTeBeUg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tn/RSAe3Dr27HCYlehvDeTwJmfd4XY1AfmfUadZ0oLLcQqL0E1w5l/GUCS9ilTTVJH9FdnDMZQImhdVleVzlbyUdRNwpMJ4iX79xmbn46QReqi0qmV/zUh2q53Q1IkK0ZaHEw44mD4vNst+ABK8BITgSMXqZwFAqriOOcNYT7Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QFtomXvB; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=kqIOa5nx; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1710206533; x=1741742533;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ryGBm/tNrBnaWFF3NhQse5fFGYxMXmsDLP3wwTeBeUg=;
  b=QFtomXvBSYTrGIPGbDJ6Lj2THo2zsCsZ+brVWK8RD18Td+8wx/rMWqyg
   i6W3puiaw60tY/Lf6/nvkChh9CrVIf22IGtqk14bw7xrmyaCkDjWOK9pB
   Trz95LxgwLd4GumvLshr6aVHCvp3s0rW7h0XTS/r/KocUaTAN+IbmBJeE
   tlgL7l8M9mV8hfun3d3EYgT2Zso/sOYlx++rS4tLuSqec28b6avu9DikD
   ppXNX6a3g+VEkV97pA3EC5pkvGY4pQ2Y9SoQmAhbAF7lDnW8Btukd0g/9
   fbk8XW1gk1Vw88EjjW2CYbZbcJv1hKuv3LYaf9ZeuCTavmlpT3agX1GW9
   g==;
X-CSE-ConnectionGUID: ZcmqK9T2RSGJ9MIaS10G7A==
X-CSE-MsgGUID: XpPIkhOSSv+ga7jntO9a/Q==
X-IronPort-AV: E=Sophos;i="6.07,118,1708358400"; 
   d="scan'208";a="11331795"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2024 09:22:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEzerZht7BHwzqI2Eszdl057zCTrVgdJAwaQuvuEabEBOIlUqlsiub6s+QxO8Wr6WZfFkR2yZn37O8IXexyWI1t+V7XuGM5VyGDHf53TQG2v8VUu9JAO56kJ1HPtULEP72qODJVDz/qFr2XpjV4ScLdTc1cEQXTqqYXY9breGfrVRAuikXOVQEC5FaDcv7Hfe/1w2IdbqdnS9IoR7ZADv7OtgM8oUgm4nEjkxQ0n6cbnPxQrWxEmsAIku05wP0kfgeYR9QpYvPn9gUNs8T3TJGjJb8Z1knbV3UYtPe+I1Da7ql0eQsFAWm44dbEeQ1a+/Pu9EqakhNpaRpFH3wdo+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5IITwllngPFXGeuaXaLEwi7WyxRvQsZIdql5iMnyTk=;
 b=Sc7TiUXPERGUKOteglgTyMmvCdVTNTY5tQyxXqwc5UDmsXMOOQaC3ue6foXVtEBrD8vKxmUoN4NRS3GS/kusYBlhwXIFxaK1V27edwFmYNYlGOo48RIqk8zjKYBl0ctw1QnFnzMfUFPFFLk20XWMoB/smoUVKriXb7sWi7jkfmy0+na3nSLfkfwFOEgxToY1hbjaitjJgssapuFbPCfH4F5H58tOE7mDa6/8yQHVCFBOFrAC96ZBcV76f2lVrePOE3Yxlpqq7SPDVFt/gk+mtu3gVAj2k1tUSLDaucaMdIGycS+YplqAgQIXdJZl9WSTEXcfiKSxUoYGWsIolpTqpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5IITwllngPFXGeuaXaLEwi7WyxRvQsZIdql5iMnyTk=;
 b=kqIOa5nxObq9Ww5SAbd3xO6fcDonaTpcYkcNk1GTr8+cA/nnBMFtp80jefu2cahwLz//uuo57qn+T89+kNWO0FsUBlRiD0JSSR1JsPZpO9eZeVTmVI+n26LqeLcZ0xotuL8xFcczNV4rMhn2M4swqBz09V7sntnJmawWMoyjjkM=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CH2PR04MB6743.namprd04.prod.outlook.com (2603:10b6:610:9f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 01:22:03 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 01:22:03 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, WA AM
	<waautomata@gmail.com>, Qu Wenru <wqu@suse.com>, Johannes Thumshirn
	<Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v3] btrfs: zoned: use zone aware sb location for scrub
Thread-Topic: [PATCH v3] btrfs: zoned: use zone aware sb location for scrub
Thread-Index: AQHacTsakT272unr3EeVmOmJOgar4LEzVOkA
Date: Tue, 12 Mar 2024 01:22:03 +0000
Message-ID: <kugi7fun34vzbvcdwkojohiz4q4heneout7ukfjg6ui3ge4nbs@s2egym54mcht>
References:
 <4d3e8c5cd6ba3e178a1e820c318d96317ac12845.1709890038.git.jth@kernel.org>
In-Reply-To:
 <4d3e8c5cd6ba3e178a1e820c318d96317ac12845.1709890038.git.jth@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CH2PR04MB6743:EE_
x-ms-office365-filtering-correlation-id: 2eed8626-5a31-40f9-98d1-08dc4232d2e5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OxV6QvE/pQc1/bvHrc3PUYoXRr0JKZJvJvibgXLlqxTMhIylAoPLXl0XEwFkxnEaMrM2SvlGYgTJpjBVKccn1tHreJF7MtmuXOoHs1bynGUHJo8MxutVbp6RI1YrAa2MNAheO9SXQ9Qa0Wppdr9Bnqx5vGyxFhBtAvANMYPN/buhug2AGOAfShU5Vwr/Nd79LiBbQP1EB09h052DsndgJIh25WCHd9fIBsxlrkya3gNiC93ThIYn39PgCPfuAwRic6GiJL8Vc9dD4CfQu8MW/s423HagGgEgKfDSlJ/pLn8IRWK3FEgjjDsgdcEbRyTiSf6QOsf1B3NbNQ5TW3zpiSG1U5K+h2/yeHMzOT4f89VfULUgXoE8/EZgBQ/pvYBcA3GrxXafEh57/tOtT1llq1KW8I3LXotVPANCSL+xJhrM8ifWGtgYjmuNvftnzBU3yR+92YKs+u1ZYR1D/NWpFuyG20ynsXGVE4q9ZzbcmglPpQ162kM+SGaG62uX7LXWHItbh/ae8rDTdRwu31YmAhE2CdAoFi7oH638byroAWvs8VqolIdlm1qJ2fOmpiHvFC/6TV/0dM6vFG3XprHkWzd8mhoLzKIQpTTHyq0GVz1/fZGeEDRvbnZz7vuq+oSj4i0eKIjNGBYYem5lhjFun5zMGkcP1oK1CoxB3tt/kTg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iMJuu/ZxigtKkYiZJXgqBO/YJZa+aQJwSqeslI4obxMA/e8n5U5lSsMhTW+U?=
 =?us-ascii?Q?QZoRiKSXw0SirEhWNTSXkJpPPsgewJwCebVpByBy/dPsu7SPegQnNFrJaAFW?=
 =?us-ascii?Q?zDs+4B796Ch7vHvPaP/tzetJT6mG7te6BO6r9Lgzmqg3BHYhCOx1thRUExbi?=
 =?us-ascii?Q?fjjIwlbikpcCaC6BJ71JuJjCMngco37fKDVoQn4dqNkkPDep+AL552nqTXd7?=
 =?us-ascii?Q?SbsRUaY72eP6YcFMUj/xXkEqBvvtEWbMZ+aBoixwSIsAk8tOOomGAJW4hKNL?=
 =?us-ascii?Q?chgouayAIJnIu6DrMtWNKxuVmyY7chx3//3Dfw4O1da7ZLnwmmklitu7c0ha?=
 =?us-ascii?Q?WW3l6WRrXkQsM5Nwbt+t//40SQbnv1E1Ur9tETrwZTjgYUFX2P6TUNLqtsNH?=
 =?us-ascii?Q?HK5d32btvBufZ7Jhta04hemjtomoRrCrklqtNlXpXiYfJnCcAb+tpzvURTIu?=
 =?us-ascii?Q?/SydlyExcnZP2nsMDG31zK5qfk8lmChjQuwl9gl+wlvpITuX2Db43AhPYzr2?=
 =?us-ascii?Q?4/sdbIChwK9jDHcjhA8FG74pVkEE6jtAXt5NSWC2QNNMdAMW1VUHVgZkqdFs?=
 =?us-ascii?Q?dXPeHs9FZArfQy3YC3OLGRze8LZ8le7/XEHTH92YrjyarbkOOvJar+IiYX0Y?=
 =?us-ascii?Q?ixg6VHqcEsIiCcznm3oG8dfQie8i1jjFMA+QqgfcbmzVTdvUpiT1HqbQ7G2L?=
 =?us-ascii?Q?6i5r+909UjwJ5XLrCwkD/ni0jw5Q12Zqg5NUsGn2TFQPBFswc1mv+YEV07XG?=
 =?us-ascii?Q?mVySoZtufzNcAYsvxG7SW304I/oVdw+rtUSiPk0VoCclH0V33982al8p30N/?=
 =?us-ascii?Q?qa1hhZyxNTXVrlZpE02+bDkIU8V+DPZZ3o+npSD6HAcnAFoJ6O1EdlAx+DKJ?=
 =?us-ascii?Q?zg7BRjzhkfD8t2+3cuGyd0KGNxB6AG2TIlkt+n3t3bVNB2KLX2oJSB65BXWs?=
 =?us-ascii?Q?4KGg9VpyWjl8tAyYIuialalEBUOaqPgIXV61gq8ahWb6EMjDG9j2J1Rg1RiU?=
 =?us-ascii?Q?7/DZA/nBPgElL9oaIno8fc7jktw0ihflz4ocIZ+Y50qAf6hTUyM9H6+rzJIH?=
 =?us-ascii?Q?zJr4eheURoTCBvLAI37Z0HDmnX06TrJz58qGcR3yef16DeN+E9FMcpwRt7+Q?=
 =?us-ascii?Q?U7XgeJUh8cPlF7UV+eC4VK0UD0PAlofihptNkZiVzztqAkB+79Fz2gceYvCm?=
 =?us-ascii?Q?VbXAh+2fJMwBJXVCMWs8hBUZLppWs7PGXYtGGS1aS/cQe0eVoupWKeUXsFwi?=
 =?us-ascii?Q?K6HnVoZsEzryCBZ0mGWhP5lOcrTna2qI2urqBC/5bNaVMabwJSsYawiyg9XQ?=
 =?us-ascii?Q?mVVtncYxuOU4X7q1l3GtMLPewDZ9It8zluhb83BagUtqUAcYmm7SNlNGlSn8?=
 =?us-ascii?Q?bTt70xbUJOHEHAg2uokkhtXSGSFiqql1dg1hbGOdjkECaYopFwSlRaomUQP1?=
 =?us-ascii?Q?uAr12Sjs3Eq2lZZe8stE98qu/zvvlR96gZVkOtl1fKI5HXqk7m1wdLAUgG3g?=
 =?us-ascii?Q?N2AvTZRPC+QVZPz8A4BHQer+3L4j8k8X7KOENX80rFZwot03K5mLFr+3pxAe?=
 =?us-ascii?Q?dPCyao+JzS/kn9ENtYArH/4C6TAb2DGozXW8Ixy0Jj/VXwpPOmMd57wTuQjZ?=
 =?us-ascii?Q?RA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E9ABD91E1A6C984EBF4D54722388459E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eTuCibAr8boR8kPFOxmEps3C3+PlNU2fi7GWagcA5itVZeKQ7nPDRiEaFiHQp5RAL1dF2O2bOsXnI6Jdx31I74OvjwXmOzcXzSgDKP0n/IeyDo/NyHCwJtVgJLHaT8GpFAt4bu7e+Bx3Sm3dCnptCQPnWpmxkqD5RyyxFmhD6M5LzbdHlp/jbd6tSUxuucij4t9EEqIbRIWJwRVcsAScvdfdOgQMfi+DRsVNvr8mMVXIeNwwxhbynzAnt+XMA8R+pwbx2CbCH0prdiceTHmXlGPig/gz1DLbUY1zaLFGHeT2SN/FkoC0ltwLDHQ8klrHMWo6Nnx1dm967Jd80Iy/fWURq9zFXCvkkcnEGBCm7pz/hm1RSOB/zGtXEnMDTC4zzX8U63yv8M7tLYfd+gUBIXJ5L74bdaLSduEwMRRQDKWGUwZkB+U7PCRd200E89zRhsrJpC+2RM4NMPOS0pyeLBghGq0ng4ZTzbsu1s2Rj/LlnxiRLxrf5MHAEyPPyitVo43qtzGn9lxUkywb+i1rLnX6DN1u2XXGoHID1Rw/cwSlBfU9LDRXfvG9oAmcqzmRK1qmQENelWCpaF1bVTHDrNAvVk/xvjctGNJwqFSM1cbyS6fTdm7EKdKUfe8ODyVi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eed8626-5a31-40f9-98d1-08dc4232d2e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 01:22:03.3598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v+Q9ip4p5g45OwvfUfDLmOrqvTOQClBXYjJBreIyRpm5nr/kmvSiZlX/lZrM9P4NkZmgt0yCluY5cP74pu3roQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6743

On Fri, Mar 08, 2024 at 10:28:44AM +0100, Johannes Thumshirn wrote:
> At the moment scrub_supers() doesn't grab the super block's location via
> the zoned device aware btrfs_sb_log_location() but via btrfs_sb_offset().
>=20
> This leads to checksum errors on 'scrub' as we're not accessing the
> correct location of the super block.
>=20
> So use btrfs_sb_log_location() for getting the super blocks location on
> scrub.
>=20
> Reported-by: WA AM <waautomata@gmail.com>
> Cc: Qu Wenru <wqu@suse.com>
> Link: http://lore.kernel.org/linux-btrfs/CANU2Z0EvUzfYxczLgGUiREoMndE9WdQ=
nbaawV5Fv5gNXptPUKw@mail.gmail.com
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> Changes to v2:
> - Handle -ENOENT return from btrfs_sb_log_location
> Link to v2:
> - https://lore.kernel.org/linux-btrfs/75f3da872a8c1094ef0f6ed93aac9bf774e=
f895b.1709554485.git.jth@kernel.org
> Changes to v1:
> - Increase super_errors
> - Don't break out after 1st error
> Link to v1:
> - https://lore.kernel.org/linux-btrfs/933562c5bf37ad3e03f1a6b2ab5a9eb741e=
e0192.1709206779.git.johannes.thumshirn@wdc.com
> ---
>  fs/btrfs/scrub.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Looks good,

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=

