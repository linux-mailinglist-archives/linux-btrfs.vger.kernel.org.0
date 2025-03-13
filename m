Return-Path: <linux-btrfs+bounces-12245-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB4FA5E9E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 03:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D4C18992B6
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 02:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4307C126BF1;
	Thu, 13 Mar 2025 02:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZrVJN7mI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bbp1N+M3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0D3747F;
	Thu, 13 Mar 2025 02:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741832653; cv=fail; b=MRvRlgVU/9mciKhrH8b0vIAhVruIBquQ/TTQ220eF/+WpOWsPPeEnvSI8kK0XJud8/GfpDeT7OQCYVkpyesPMqS/41ivXNprlVHy3/5pYSTi/4195i7XvToWtggkeCMC/vQ28AIG9fWFYF7xiB/+wgvFcBL8z4UPJDRibISn33s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741832653; c=relaxed/simple;
	bh=0YndiM0bMLEZ7n75xW3J2rgYq0C8mGedkLsOheEXp40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M1PDJFXXPeCU/eQjScaaTXMd4J4MAckSnTugbsWmjo5k4R1HeoRXIapCYeejiyu/kZLYa9VkCY3CvPhJFmUfNAZwBb0Sn+q+6QPeRu3wmJfwyMSF/bFchWhkUyF4LL7+RWisa9HJHE3sxkvoBUE7Met6pMsRFXTgtERivihqCx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZrVJN7mI; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bbp1N+M3; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741832652; x=1773368652;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0YndiM0bMLEZ7n75xW3J2rgYq0C8mGedkLsOheEXp40=;
  b=ZrVJN7mItd/ulsBAgpiROwLbdsWJthlFgNigGyZ8Z7j56mznR8luB/p6
   uBNpzjCaUiWSpAhChKqP4L6I0e7woj3OxGRFntPvuLD5Sg5OFSj+NyhAt
   6EJKSK58zLc9c9TXvhIjIFuliH/pIC4d6F7zwXqZUCC6hG4WzdR2fS/pX
   JZ0f9XoT/wYTHvsX90qx7GXOKaj1ZupzwOMHQsvpFRvBlVIjmqf+FyDQs
   7GDlpIYmuR4oqyMdgFjsDsNfGiRfgH1nPIRQAQPZ1psRsPEXniIY41tH1
   GP3niw4GO/2hmvYQQoC23kBpQXvfUQDZ6MP4T41XvnqSuyK/gMU2Q2SJ0
   g==;
X-CSE-ConnectionGUID: 8ko5xGTISBq3iMaHgAmT7A==
X-CSE-MsgGUID: lBl0QDj6SHi1NdyMFanJDg==
X-IronPort-AV: E=Sophos;i="6.14,243,1736784000"; 
   d="scan'208";a="47577448"
Received: from mail-westcentralusazlp17013078.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.6.78])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2025 10:24:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6el0DngFVBqUprK9GHX5Y9ul9vvXS0K4TXftUnpfFV5xnLwXqxEqG+h2qQde800J/vpkkOmuAcUR/TWW6H0nRtAsYn6tmtmnlgfn5jed/WUOA5zVI6WBWsgMjr4QZa3H1JR5+R1P2nBT8imqz1rdrPzFdaDf9LcEeGdRNwIXGdweUHIorzRuMsRYxOi1hr2SfukN7/6KubQSvUHElIEVYgRrojiN/AToZTE64TpTLtyrZlfmc8GVdnwXzX3+8GqcqxBYjrmLanb5+dfe2LhHyOZfOiEhFar+oikkLYZXK1Nsz4SFREMEUMeFyhQDXYBwpGIPk2OmRSwosvPCIMFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YndiM0bMLEZ7n75xW3J2rgYq0C8mGedkLsOheEXp40=;
 b=ih3z6FkhDggYw8ELeWxjF6A2PA1eezYYtqEOOBj1Yp+kqE5CknmLoY87uSiIJYwv5zqbT2XXKw1c1r+EH5l3Sq+EjFsrR1OP20d7PcFXe6BsSpo8AfmupteHLEdlZRtow2IUjN1OyPiyxCV2pBlrm03UEYp02YmFVjYmxNKAk8l+UGI1q55GB/vR1uQbFpbwBQXPDPEZMVQApFNmcH9Of6i3JE9n+u/IHs+nAZr4lCTyvWKqRulpcvlxdIKXAzKLm0XvKT2hp5hU2XuGxA7PbXEocQtcN6BX0zu+OTIFrxzLmReoXj73auOQd8k+aGSQYKpzD0T4TJCvCOlxZHKMDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YndiM0bMLEZ7n75xW3J2rgYq0C8mGedkLsOheEXp40=;
 b=bbp1N+M3qA2m6DPStdnhoN7wdDOSsKBETi5GsjRElkEYdwsHsunJCMCVTThyz6b0HhlE/SUm7bS8YrBimFwvOVrJwNe51UszOhJGnqWQVJdATCKgRtaXD49AWd5Zx/rvU4VhVYUesfh5BYpbQwXi6GVcDp1NaPE/fUf1c7BW6cw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CYYPR04MB8837.namprd04.prod.outlook.com (2603:10b6:930:ca::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.28; Thu, 13 Mar 2025 02:24:09 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 02:24:09 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: zoned: skip reporting zone for new block group
Thread-Topic: [PATCH 2/2] btrfs: zoned: skip reporting zone for new block
 group
Thread-Index: AQHbkvAK1+SkGk7OkEaaH1iBPIiOTrNwWB8A
Date: Thu, 13 Mar 2025 02:24:09 +0000
Message-ID: <2fxnsafqy7zrbu4jykwpblqhlvcygsbiusi372a3miepqc2evc@kpemcjiyreb2>
References: <cover.1741596325.git.naohiro.aota@wdc.com>
 <ec6b55668686f77593f12c579832886294fc7310.1741596325.git.naohiro.aota@wdc.com>
 <ba23e5fc-bf55-4e2c-a839-56d2d87a2529@kernel.org>
In-Reply-To: <ba23e5fc-bf55-4e2c-a839-56d2d87a2529@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CYYPR04MB8837:EE_
x-ms-office365-filtering-correlation-id: b7939d8a-b41b-4184-8291-08dd61d62315
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aVoSart5ZLWuw3KfRKygQQdTstUVEmOmKPK9RGmGVl6XDR3qOV/4NieO4Y8/?=
 =?us-ascii?Q?ap5gxE+3CeGyLHbwl86PMQs7eKexK36KU2VABCKeUia7P0Oa64FCl3bdt1vV?=
 =?us-ascii?Q?F9OElv8VgqBm51dTPhaf/xMvYK594YEChIv0TA4sFdwrQiTLrnRhUbTx+sGG?=
 =?us-ascii?Q?zi/5R22QXLZqklSoLsz+CEDh9Yq7UgRtcfbcboiyyhardPZD/xDTG47RzVCM?=
 =?us-ascii?Q?MgSslaYIoSvcXk8orSN4FBj1SQn5p+nhcAA2vTXpweTBYyvZJRcrIkJu2KeL?=
 =?us-ascii?Q?6nP7Pr4RYDZpvZKyOBeal7FwHFpsIsMrN/elW/jkAw8um/8Yy9OVZ8aRRMO0?=
 =?us-ascii?Q?cuiRw1H3nBabBdFVV9lEy3q+ekf8HvhVQyIHdJfxRoWpTUbyENWL4kQzhm9M?=
 =?us-ascii?Q?luYLaLiV2st9P87XlTbY/JSTsibgcSi0QqQA0xWe7X31uAWuJE/FKY2sGKnX?=
 =?us-ascii?Q?wSqKmGFRq5fYTQ/Y3mZhhM1lXLzh/PwXkb8w7v0hoWMbZJKEiukAUeLna6Xn?=
 =?us-ascii?Q?0ot9J+vc7ljinnWZr0bsNWE60ujLhN4dhWBJf34l2z3gG/Q4lNimEhBnKh/J?=
 =?us-ascii?Q?BdqnC8haCNZcKxf5FPIQ8I1YyE1GZINAoGp3D0v1bOWbeZeLmF+j3Vk/wGd7?=
 =?us-ascii?Q?0wXWQJFQ0+UQxfDsukyrUvTC/4zvk/KvNUJCZ7vIcMqLYG+wH1ljTX4p2Ubv?=
 =?us-ascii?Q?ejF5rome6WUCxShvtliWDDL/PUZNE69q81y71QSooE5ZHJyH0t7qeSVvn7K9?=
 =?us-ascii?Q?+s2qIbNfrbIo2EyIuBwic4mnqJuEge29SvL04deLSbKugQX2iBmH99jK05Az?=
 =?us-ascii?Q?aCtUSf/XPITIAxRXGN7cP5hF7CIb/m7PEyBHRFLi6/kdIDnztsykhO+GFlXt?=
 =?us-ascii?Q?y5xc9lJEYqY3MERmMiDmiOhKiIU75nbcXg7IQIZ9X6e+4lKk5Q1QhHMXxRs6?=
 =?us-ascii?Q?jiD+0H7yTVi3L2drocXE3h5GzQp5D1Ieejp68YaRkiPK2qzfvTCwFwDWEmEJ?=
 =?us-ascii?Q?RXfl3fKver2az5ySGBVUTA2cebN2YCzK6g0WjJBCbnOttak83vmMfWOaV75k?=
 =?us-ascii?Q?3Yrjo/FzdTD3xgIJaHKB+sH3zB/u1BqyRxKNNfePfUh1z9STtxpEimPkevt0?=
 =?us-ascii?Q?Zm0MFFOYV4wwRSe4d1cjipYKHzbuYHlyrmqzjxGRK/JsN6TLqBeUg5pjyUPk?=
 =?us-ascii?Q?uzt6WAYTsCxDDI5SEOc1wdfvzbOaWu6f8FLnS5lqejWvdGPQePL2DdM20Wyo?=
 =?us-ascii?Q?1CLhJRQ+BDP9tX6EX1FfGBVcBLBkkocM5I6EMvg1IIX+FUP6aL/ionbUJZLh?=
 =?us-ascii?Q?W1/e5BXu2jdmfuzqWdyC9znJIhbYnbdSeEIqVyOxLMPz5gcK0IxBg7UWaiWb?=
 =?us-ascii?Q?v5qmMyC2OySt/0MquiwMg+5bz+Bs7x/jhTdelo9Eunv11UaRNQ/RiZbWd92W?=
 =?us-ascii?Q?lcSOOOCETm4s4o/MkjaLZVlo/5AbtvPK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ndz3Gwvj+iYWogwfEubvmJbTTBwWcgvM6fS+kl+0hM3LKD8DzJzawzY1mLeR?=
 =?us-ascii?Q?4zVLCdCeJ/w9ZT6U12OrVav1W+M4k8tx3bSSo2wXy6s4oajvOGy6ptC0vXr8?=
 =?us-ascii?Q?jQaFH6ix3dBHXgNzzCMsvjw6Yp0xyah+AvQ1v+YyWGb+KrbG6/rL/YaKHBZF?=
 =?us-ascii?Q?beSQ2fT18xhSK0eybc+MAt6tS92dk4zP/NXXJH48AGJx46rx62ZhkcZuwp0R?=
 =?us-ascii?Q?z2SnT2JUYhstY0A5kGfdWL1ImCh84D0o5tsbwPuR6bks8m8c+9U/Z73dXmUB?=
 =?us-ascii?Q?PJgR3Ug13Nll9yQm15bJ2rSY275uCRz3U6CFJ2vOPOVullnvCs4fx6SUD0KN?=
 =?us-ascii?Q?ghvvhK7jwJGiVPBWDkSn26rbIjPSIy8KAtZmCWnGoBT8r38IVCE7+D2BwCLY?=
 =?us-ascii?Q?X5ZfV/2ODscf6H6QPl7ccjs/b6IojPY/sHyKz8DG0QSkdDY7VjgUFhw+D1bR?=
 =?us-ascii?Q?q7Cp2oPzuzr+WI4hpn/Wkt8+zKj3DQELnC0ZEZE5aV2RtbP4lCKP3XSctlSG?=
 =?us-ascii?Q?hqfZchIdLEmpb0DNlxUdES3MRZAsvaw6fUhsRzDqMlj2Ml+ElFErhrMBNx82?=
 =?us-ascii?Q?kvWh/4VlbTOYeYsfi+kbhEhXD68wuETIAV7eU27ClIOJBNnBiyIdy8jhjBEr?=
 =?us-ascii?Q?o3cKJrFDzNAR2CxPcCSKgaDtZqwDTgtVwoHQmjBfWackLqrM+zTOzuhkpiJi?=
 =?us-ascii?Q?BhvRezhNbPp34iSCrTwSgfUb/dzwUjEchKY11CHo1Ix1V1u7C/YClidORJwk?=
 =?us-ascii?Q?Xr0LBS18iTgQWLG5VTmFthqBzjbkHtb6NescYzASqmFgRg70ZZJFoL0De34N?=
 =?us-ascii?Q?k7myAwXM5PWraIbgp/OqP/RKfd5zNALzb71eS76RtmesFQNTXQQ7hR8ZAnYs?=
 =?us-ascii?Q?QhR8K5yeiPmw+nYRa1rnBRH4KEJmtEijufKkzM/R2dPX/DKSXzJd2+BOe+x/?=
 =?us-ascii?Q?Y6e0jwyAhEinD6jia2NomEKXbQLdnVVzhz0XNpjPLxuvhICfWFh+gtv9Zthq?=
 =?us-ascii?Q?L20TfND1Cq9IAYHm4JPB+zLYrX+NUHH12S7hoJq3ButTZlgpNYisAhSwMLxO?=
 =?us-ascii?Q?+yHBw5mXQaNajysdomy5/Ob2t76xkwO1bF0Xk9NmofsbixIZk0mKF+loWgxH?=
 =?us-ascii?Q?7c9bjH+yWJInl5ap5cfaXkxA7eu+yoqB5OymFsaedJEU40dTBXAx0hmJVnHs?=
 =?us-ascii?Q?CsuQOWDILtWzrVv5Zm44xzmAqUVWfiP228GpRXtpQ/73oxM3ZovhLke4qgh+?=
 =?us-ascii?Q?l9wwXF44MqKAGKJud9z13VCg0i/yUyWSoephVrgnJ9JRiVz55CMjaj4vUtnF?=
 =?us-ascii?Q?R53G23W0frVhYSpjUCygEaTeVu08XLM9f3yAQqkfMYbQkfZrdtn692gdTTx6?=
 =?us-ascii?Q?3G3tPqQejY4DwsxXSVTIcOp4g17OLsaEnd8PkkXQWLbh1o0dUl8isKe4qOGq?=
 =?us-ascii?Q?Z9+YhKhWv0Mz1nZBnamED5bnQ2bjUfVS0WoEImeqngcpmRXN3XkYB0qzqgXj?=
 =?us-ascii?Q?fdAe6YzlvSwjR+EbJcCjHBRbXxCl2dMlz0r2d/jRuSm/ZVLVMbczJ1PkeOO9?=
 =?us-ascii?Q?cJ9tGOoIguNi+eE82M0CuZUTWlKYPT8XKcT+Y11ElWwIwE5D5XKWQcwyNO49?=
 =?us-ascii?Q?BA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C8083ED646158F42B356ED6ECF88DE88@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QMPGXO1pbmafwQ5OP9q9joWZX7wgrIH91z2KsruDgyQAlmeMlKwwjefkwVyt5ltlbeRHEUpqUuqtmMm1NTaatvD+wW7giUFL7BzQxgbSXVDVlGz3JHyB/Aca0aJdfJfo0SI5bQ8CMau8fUHZJupiCQ6YjzzmYoSBcEXu8YUVocn55J32hd/Te5ntqs78cPIKCkZxByYXg9NlZWtoeuE0QWIugPM8g4ivmEx8gPLUhB1q/90ZqY+22pCUZJryTvh6mCLWUJV8gCecJl4Li7HHqIC6e25JNNLXGBJpo8zGKB2YUuAvoqmtsrnweyueezoiip9I9O1RX4f1LZh9mAeTWLnpceOqCsAkdtDK2b64qgSjlKxsaIzqJ5Nm/HYqfvLSqiF4UG5t5WXgOCZpw66VCSc5XpE1bfjMxvY06SjQyzCxJfZa3c1HnhIenBqFPO22f4Oc7OwLUbJAv1Kc9U5k1DRR5/GQxbSqkwejpWyaqMYlHk4IZ2wCTup+OnlnjeNs6U1rZq6jacpINmS+2MT7gkWFoO46vw9zDivQD6leHxV+1qxDqL76fD/iLU1oUeHmT2LPgNr9+dJ8qA8VdqE0mOCrnD1oFRMh+g5f0wqqF5yLJZCr9p2TGu27RhwudxgC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7939d8a-b41b-4184-8291-08dd61d62315
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 02:24:09.5712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LO3d3Y6C21F/M3EiVEmLd3x6m9qoe4sL1hwjOPvyTOTPC/3vva9O2ojS9bcPOUDnzs1hs+giWS4LN8PCiy9t5cML/8k+TfLDwoolET5ASkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8837

On Mar 12, 2025 / 10:42, Damien Le Moal wrote:
> On 3/12/25 10:31, Naohiro Aota wrote:
> > There is a potential deadlock if we do report zones in an IO context. W=
hen one
> > process do a report zones and another process freezes the block device,=
 the
> > report zones side cannot allocate a tag because the freeze is already s=
tarted.
> > This can thus result in new block group creation to hang forever, block=
ing the
> > write path.
>=20
> +Shin'ichiro
>=20
> blktest has a failing test case due to a lockdep splat triggered by this.=
 Would
> be good to add that information (with the splat) here.

I confirmed that this fix avoids the blktests zbd/009 failure I reported [1=
].
Thanks for the fix!

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

[1] https://lore.kernel.org/linux-block/uyijd3ufbrfbiyyaajvhyhdyytssubekvym=
zgyiqjqmkh33cmi@ksqjpewsqlvw/=

