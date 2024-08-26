Return-Path: <linux-btrfs+bounces-7484-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0721395E7CE
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 07:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542D22814FE
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 05:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F025058ABC;
	Mon, 26 Aug 2024 05:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZYuVECIk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="umkZjYt8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C60E376E6
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 05:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724648561; cv=fail; b=Ny5p00ZZigEO11SvdFaLr4qDftapTpdakBEoKq8bH/bhPyB8MD5MOs+2qd91Yxi4rnXyv6qAKpz9h6UbOxqETUlDhMq9vnZatR5Uadg2MxiWZ2P7fVH84Bhemxd+5KjSXbYGGKBWWMZ2rD8ao+DA30ORmdAw1Mzru2CHgG1oFZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724648561; c=relaxed/simple;
	bh=i5AiYQbV93qU9JfPQYz93R68yNxEy1s/nX7qNUT2F5M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c9z/DVtQ/JZKNJT9CzidxnnNec/RNf5qOmsim87kpjdurpHH7U3QWoKJZ0fNP7MyJxDSCLPmofhePorW59Tg3AthSSD18+IvaQ6yuMEeRURrTRxfVxk6w1gaL//OrM+wqiRiQsgCp33gWQwBeNRxvbKgBHLqz503nHsMrl2hVRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZYuVECIk; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=umkZjYt8; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724648559; x=1756184559;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=i5AiYQbV93qU9JfPQYz93R68yNxEy1s/nX7qNUT2F5M=;
  b=ZYuVECIkR/9J4HeniX8LhS3w/e3u38UVtNMLg3xzNvdTcUPoyuj8wHIW
   GSvB/LpS1+YWV7mZQ3d69WAR8H/QjQBzeEhE2PZkndPOtbComHrr8ZSVI
   +TEIITvVqabnqFkyUJbnu6SWVBXQc1nEW5Oz3lcMzq7L1GtvhgnkKc/P4
   /+r1+v+cfuSPnoimr8buSgl+iWkap07/eqLeDw4kNhCil0lUvXeTvydf6
   jaXHfavIRjH3B0DCsfGX2LwfMOomuFP4/htrzpt7ubuoBo8LKx369Rbdi
   /0XGTwn5H3XONkDpGfpJpswTCaUXRH04x7W1Q/mmGjKv8cINZn9IZtCFR
   g==;
X-CSE-ConnectionGUID: x1FfnwQNS2izEqIPtYZFcw==
X-CSE-MsgGUID: t1NwB5PkSaWerC/YOioj3A==
X-IronPort-AV: E=Sophos;i="6.10,176,1719849600"; 
   d="scan'208";a="25494545"
Received: from mail-centralusazlp17011027.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([40.93.13.27])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2024 13:02:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HK3ZVojZBobcvS8AkNH3pe+GsHGe8zftJvU0K7pM+cSMUjn2uMn6+GDs3UmfCFdiYG0FiDJE02E4vjwwOWcM7K5DXTLyN/198olemg6KUfXv7Vl/Hal/mm//yi4kfxR+sweuITFfXyGwnMZ23EzCYO9/AGsqF9aS88OHjzySFeO7YS+h5rd6zpBow/jPEgKj1ph9I4GKFDjS67lBYmquBGtu76/D+vX/7D2l5iq41VK6GKMffKQdgR8mGStaOyTKnTMdjtab4C0Bv6PKdelT3FvLyKmcB57rmZpU/e+TrzL9oYko+iXoHjSrQxT0xVkz21bG9AJ2G2Zx53nvfNMZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhRJ7dYd03UfjMS1ly2qbZTvV/o5gW6yhYOSSWk7+e4=;
 b=XrIV8tA0prUOWZeEwR8yQpIZZGJRnFnmJvndxV92t9j7yPVXnd2Hgq6N0c/+F+TVD/JrZo7toVsTH5lRbYZH1HF/UXMgWJPhVafvEcMtotypbMYSUanX+/cNGSnmeMpHQvD/P5gQNNDqSHwwjuREx2CjNaGN8Ar/EkppTQYTlx0DUbm9XZIYcN9Qcz1cXBmTIXxXhtiBwsnqwiznHLT01/BPusjr8wfMt/Ykhv0h3AQpymN47weXZvcaLm+xkmU7B73wudIVQ/O/pYgZzWSm+LpeG5Vm4YNLprBeit9DFqSAYA21TSjtpPxDl2Xb+QH4NVzxl8CGwU1QdL5nh1H5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhRJ7dYd03UfjMS1ly2qbZTvV/o5gW6yhYOSSWk7+e4=;
 b=umkZjYt87x1cpQVoKnfZU3MtBYTMtWh18z4SVGZfWHZm9v3VBIkyeqZ05QqlnCRJ9jIh6An3VSdaX2cBaIhcVt+wWv1UKqnZrHI9OXISGpHIWzxa65u8RcGfp5ZESZ+VoZcYpdi1hBb/Wln6UtmzZGVBStNLBJtS55YbyNlJXnU=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DS0PR04MB8742.namprd04.prod.outlook.com (2603:10b6:8:12a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 05:02:30 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%6]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 05:02:30 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Xuefer <xuefer@gmail.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Qu Wenruo
	<quwenruo.btrfs@gmx.com>, HAN Yuwei <hrx@bupt.moe>, Johannes Thumshirn
	<Johannes.Thumshirn@wdc.com>
Subject: Re: zoned: write pointer offset mismatch of zones in raid1 profile
Thread-Topic: zoned: write pointer offset mismatch of zones in raid1 profile
Thread-Index: AQHa851JwKMXuqVv/EyKWitBbLVZw7IxU7YAgAevV4A=
Date: Mon, 26 Aug 2024 05:02:30 +0000
Message-ID: <jywgl3ougsxaz46vclwm5qabse7enkv7ekymibc7bpgdt5kj5c@urffk6muph4a>
References:
 <CAMs-qv9NM6gWTe1oV01XVENhhJ=agFZqb1qJXoLjGoRVS5AXQA@mail.gmail.com>
 <CAMs-qv96=m2=E1GTvz6yuW5i5Zf6Ng-=0RZQ_RNk6QBrF0aX7A@mail.gmail.com>
In-Reply-To:
 <CAMs-qv96=m2=E1GTvz6yuW5i5Zf6Ng-=0RZQ_RNk6QBrF0aX7A@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DS0PR04MB8742:EE_
x-ms-office365-filtering-correlation-id: d1ac219f-c8c0-4266-5f9d-08dcc58c49e4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NaZ5nBii01szTyniDi16yN9uiXkSpmh1vbgmqLJliSMJPowbtF2HFWiX4ACA?=
 =?us-ascii?Q?7wX08JwvrzBD/LaE/lbhuGdF70l7urgZM4QBgVFDeZX5A55tvpPYrGacnlQu?=
 =?us-ascii?Q?6qjoiY39U+9rfm0rrybv9SqbqcV8B3kEewloGSwhekGcUO8LlsSkR0ct8DtI?=
 =?us-ascii?Q?3En5kTNOi93Wocdh0c5agtvHjRrM7pAN7wOjPIN0sjDO+0mjmZ99nmOycF5K?=
 =?us-ascii?Q?2N4mb7ztkfw2t4ptStXnj90TvIm2ZnvnrZlVPpZz7oOc+Beb9d51hKQ/uof4?=
 =?us-ascii?Q?ejiksEY1rwtGRevDtGTlCX18YsS0HVjyTGOhP7NRGTVjPYjEn28mgI2aGWvX?=
 =?us-ascii?Q?n11RcX4Q40NVTJ8F3hkzqV3zwcbjA7gLad4jglGlC8o/RBPj8i/zUsAb6vA1?=
 =?us-ascii?Q?ktGW5utNMhrTz4CMDt5J1zOVpkFhe0D/4wJdrWS+65nzKet/CvuRzaunwwV3?=
 =?us-ascii?Q?xIyVdsXY4iES2SKz9mCGK4mGCPbwdVtqH1e4Go2YIRhKUjFXfFQhBZzUgeFM?=
 =?us-ascii?Q?NE15+OA7/woCje3EwaVigVDYFGoLuY4VoX4Iw+FDY0Diz7zmJYTLKg7+seH0?=
 =?us-ascii?Q?3oRZh2/p3XJNR9kRI8z0iM4hmdMyoiL7lGpB7gs/R9bAtmwbpfAhRJ4es7Qf?=
 =?us-ascii?Q?uEPUv4gn2BAaeI7W2NHhj5RLEAxeJr7LH3s8xsgWpluHTmGmDvrdgvmZIyHD?=
 =?us-ascii?Q?AjymXwbyaH+n+PLqcGfAOmpSHSWQ+VOsAN+6sPiJ/1Q4kIUXZe/3AyQF87Z2?=
 =?us-ascii?Q?qRw8zbj+cWQRM0HJA5ohFdhbduVdDech6WIBepeSvmDiCXG92SOErofYOr5e?=
 =?us-ascii?Q?wwbE+Ypy5I3A9JdOThN/CxA+MeHKmv41sHF6/It0N13TqgQIMv1gPCbllkgw?=
 =?us-ascii?Q?UtForYuBqaazVswgxuv9Ev57TNEH2vlSTGtW2vS5jC7q0KyUyuXD3t8hk074?=
 =?us-ascii?Q?Vigt7+ipE+FSAi+V3mSuy9tk4Z/bGE8zpa+b13leD3/YRAxa+TBlqlhoaQLM?=
 =?us-ascii?Q?+UaDbBLJyT9tBljBT2mSR91ixghXwAsUOGc13prBJQYVk3isYm9F3gjq3wEd?=
 =?us-ascii?Q?0vVKLylcj50Qap0SKnlpJUHQaFlnsjO17uVDY6yLHU9sbvThjSpXl1r2CxZN?=
 =?us-ascii?Q?pRz+n9xAkDZ5TUPW3J0EfSI3BYr3TlbXkdUXlydex25w9PHafnzWWm6duaSE?=
 =?us-ascii?Q?oGBjp7UEa03xaLfJDcbnWvS0twR9/kOJeUKZsgPr4AbtOaGt4i66/HlYourd?=
 =?us-ascii?Q?EfO1KccJ9If2o36s4liXpM/k+8i/tW6eUFuy7zi5mozr2tqDmDk+mhKzAyAF?=
 =?us-ascii?Q?MFmIrdH+7kYagZJqNr8RLeTOzhfaOjZcfTlLWHQ79DXSZV7xWct2c31eBVUp?=
 =?us-ascii?Q?C1XWPJw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gT9Ss23Wl2DmCirqumfvYZL5tuaxaqsZu37qXWXpuEmnMEkv8Dg4Ea86cEi3?=
 =?us-ascii?Q?AVNvzJMwUTcT0YNuPCW0g4hj8jKJYTsJPT3Bw6qNmz9og0YpCdnr7uNTz0Sg?=
 =?us-ascii?Q?geqYyYzHJwyoJ2UshvcZoEdhkpoMZk7nm/O/Xfuxy4dgZVVPVej3cqxLvwax?=
 =?us-ascii?Q?3fgZeDlZdBK0FCXu0qmJTkmSU+VfLlW7Xv2zVmbqGYVSM2wWyyNopC7N20ko?=
 =?us-ascii?Q?W75FfdGltMkswJ5uyCCMLRwAEgN5ssMQ+ok13WTpyASjoEHNlW5QZsh89rev?=
 =?us-ascii?Q?CI04uh9Qq6gh6Cl1+WJUZ/bijog/4oNSP+BtoS0p2YJ7MOUEpUmWc+HN9UMv?=
 =?us-ascii?Q?L9+glTNEQ+qRiNx3DmS5Km6Pp7f5Hhf+9Tf9rxPptkbnsgvABpC8HDo8EV3W?=
 =?us-ascii?Q?yOYiDLn4gR6fx50GbF3ttd997rpPStwWHriCA961qhFIErLw7KbdLWo29OC3?=
 =?us-ascii?Q?ytgwe/FLUrWh0MAvxdFqE2UXzgXkZjCBvkuYLBGUFo1kFHJjFRr5Ka38EsVk?=
 =?us-ascii?Q?shCdLSwNVtSuMy+e0GBFfaDmuq7g2B+7q/Zh67S13Tv34MifgMUTJJa2I6QW?=
 =?us-ascii?Q?bdEDlosCfl7KI6H2dRt50ygx+r5ckSqGeKDDrFjWlrWuppgFYC5G+jV4ZZRd?=
 =?us-ascii?Q?nNnUsNisPOkBICJzyELXMuUBuNNDbuEwyv9e7xgS8wxCuXtqboD3OBvQ/HOn?=
 =?us-ascii?Q?fx/i+8z6na5vA2FDw+0U4FqDK+OIC2hHTnIRfWNRy0yuLGd89jj57YLRGYaY?=
 =?us-ascii?Q?6JDY59GtjBZiov9s/9bY8mfItuqJgoQ7i2k3qyVx8khUElVV0NX0oI/3TJwl?=
 =?us-ascii?Q?57SNEUdI6VFlouKU1hyKOH38iHqyF/oAsmeHCAwt0xWjmsCRpi6SqCZNi1VJ?=
 =?us-ascii?Q?ZK1AAP1cQa28UBgqqXwwRu4Pu5E9MGiTTxfI9d8DXc68II27TuDYcmKAUQjU?=
 =?us-ascii?Q?bRYD7mBL335MUuNoitELgMhFExRHaWiFFw21ky5grEl+vr5bL7b8V3QpHPvY?=
 =?us-ascii?Q?OrB7mGMMIn11iEaM86iKIXcQId4wy4tRc7fTUuI5GymG6gVsZWi4LWefY/BB?=
 =?us-ascii?Q?4+BZxKwcHopGa0r+Rk9as4+j+SqYxEyMfMB6gbmoFA1l5Yc5BMulgyPQYSWx?=
 =?us-ascii?Q?aPpXLiwCrn9s8HncaIAayqw69OIPw6eKdDpe7oz5QsNhKOg7sZx0CNNNA0zJ?=
 =?us-ascii?Q?da8ON4pYG5WDYjcltSshoCAEgzfJYDdfZj7eCUwa/059pExByIverVHiVUwk?=
 =?us-ascii?Q?ibD8nZsPnQbulHjhwIowPuKCn20qpbiC7J+yoHwBOMQmBJVdvg/lG/ilTOVp?=
 =?us-ascii?Q?yRqyLZ9rqhLkaWNeLfENij7s697/z0aZmoIIFzJJagNgDBg2W+qttLpNDn7q?=
 =?us-ascii?Q?t82hn4d/niIQkvw+LjOxq6ih5v334+fs9zfk1TCYa3yVaPHzNVv8VC0BcshE?=
 =?us-ascii?Q?hXvmtDvfFNdf3qoEEwpKtWfQVi6fm7db5O3GPQKdPQENgG4EHP0eJQzHBB8A?=
 =?us-ascii?Q?ePRSSX8DzZPtM9ehgz7Dwfhb4iF8eQLKLlh8nFgIkyq8kSlqGW9lKRXbY/mt?=
 =?us-ascii?Q?pVSe5MH8mfyzTS9iFX8CtYSAhhUXDOWIaiYDVHBcPekChlYdtv8bjTtG4Hgr?=
 =?us-ascii?Q?bA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C3AD0A5AB3BCC94CA03D163C760AD76A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v2TBc8vdSpl0fHljP7mPfnNLbQcxkMQ3DzcFSuDQ4pJ6IefSPqb37eZjwnXZmfTW5+cVmWnTic5LpOs3idA3H/UFlEKK9o0fK5llgG3BHTcwtL26v3hlEQGupMFrOMu2q4Osk1KfvEE9V6Rt/pSYCf3mNbF9DxxGiB/ouk2qTvMR1SveO7EvaQZaIEdw0CBTBcpah407j5Pg7YY+mL0SGpTNnBGPcDhXMA0AHORUS9DMy3OpSXd0Ps0g967lYRDzqXgTxFnVHzVf1FvwPHAJ4JLCvsJ89zlr/tnPEddbx/6m6yGAU+3DKgPRv9EUPEnDlnILo+82fdeISAHsEvABkQVIi/6kcBN+KCovMuHuGA25TcgxkUM3yukZqU5KSWtA07K2gI3UfcL8jZGor7rawx+XOtFboHY53jTmHn084TkYbz+iQGf2E6cJ1YHRWEk9L1Qv1C8Rr52ONizUOphPOawLoUAgbz7PfuKyhoxi+ykCxAtgYVzANLokqtjUHMG2lMv24oC2LFzoUmBNLAqIQf4q3fbrJq6ottOpGk1hsFkPzuyjSMYtiFLqc8ThtN46M0AtapVocjS4O9Bz4Ub5n+Mvwl2xae4XBp/A1W+OFhWel8sKhlbZm2NvuelFudlf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ac219f-c8c0-4266-5f9d-08dcc58c49e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 05:02:30.5291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cx1JzmMrs6lAgBVwBkd70APbATsxhdIJOKAYIe8j/oPNCQh5Ps+/PwYIQt/KfOIMGoawYs8KudspcbIyaoW/xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8742

On Wed, Aug 21, 2024 at 03:41:02PM GMT, Xuefer wrote:
> I'm hit by the same problem discussed  in
> https://lore.kernel.org/all/pidc6y4h62zt44c5m3rdwqbfauik5xtjbijoe6oqmqnke=
ig2ky@wfxoqxp6rvt7/T/#m0b3cecbe1fd8d9555471eb8239da139f293e2971
>=20
> Can this issue be brought up to schedule?

Thank you for your follow up. I'm working on a fix, which makes the buggy
zone read-only and let the mount continues (and possilbly start relocation
to fix the zone). Once it go through test cases, I'll post the patch and
let you know.=

