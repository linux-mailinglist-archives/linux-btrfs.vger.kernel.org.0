Return-Path: <linux-btrfs+bounces-5623-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F98902D7E
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 02:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A814B28555A
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 00:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22E0EDF;
	Tue, 11 Jun 2024 00:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MpE3V2kY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vUAveDQi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247988485
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 00:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718065280; cv=fail; b=IZUiHgxTnJc+T682KX0/ZI6GQVF9ATWUfMgACZHPTJ0e4YpbCoRLsfOQ/LwjIuTjKcRiuXvJf2wtbZ8U+qjtw3MM1LkypjhE4PmCo5lTB4SKC3fmMHkge9tUI1a/0D8e2XTmvmwpGoZLCXO0eIu5x75Vxbi4zPbvxi+5uhsQauE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718065280; c=relaxed/simple;
	bh=KCPYcOfnmBUg0yxLLs6a5B+Z1VYHivtRMmb/gJXo95M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pvivO+9f46ua9NeHcdSQhV+pwuOvBZ0qWbUT1ZJJuwOz7E5OGTe8QQVkWwJPJJGVxvkY5vE/BNbkaNVU2M7q/oO+Tjm67j1sUA3nisMO2NG4z2lCKb+tOfJJUa8hVrTFRJ6Yaq02N6NE3I9h9Vrtr4xZ1hp8EqsiZal772Z4QhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MpE3V2kY; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vUAveDQi; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718065277; x=1749601277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KCPYcOfnmBUg0yxLLs6a5B+Z1VYHivtRMmb/gJXo95M=;
  b=MpE3V2kY+4w8NOQadlAK9GbMCbVbxnhnrzZ7CIcLn/DsxRkxKNiHw+5U
   7b2DRIY7ziXLSaP0wRFG+AhIjPZygGVTGUc4ZhDU40QmaTMNFKpJNbg5v
   AFbT9Pzz1QzsvhcSMYLfpFR4jZ7fzu0prjbGu5TUJ0Yxn24m94UB+3a8l
   Czpy/ZPcj9K9ZmuBCsf4jTKhNALoOYgshCYT3DlJiOJbujq998oQ92vD9
   r1ue9Om/a6crM2Yc9ZijI5Isn+8iN49oHA+52/MqHNKtK89vpaWK6Pc94
   YA81dvt+6jEsnp/IvSvEljf3XjMAFk5Xe8yFTLFW+A8JxsGAo0sfNxrP3
   A==;
X-CSE-ConnectionGUID: QrbN0netTEyVX3Xyy4lfxg==
X-CSE-MsgGUID: jMhdQH1/Qg2XcmMfJuJRNg==
X-IronPort-AV: E=Sophos;i="6.08,227,1712592000"; 
   d="scan'208";a="18790002"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2024 08:21:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKy/DPpSBX9GJetZkh/UY1ONjaZVUbISUzo9QBQ7OhuFoB68tRcOzeoX7kB5RzBrlQwr+bPWUaCjJmhQa8BN2YagPUmOELsPvCmHyGqwtuD7OvELywUhn45evw/5gJ4R19HQbXgeXfdHktbqJSi0L0PCJqTWIlkSnhm/gMlyESKkKPxoOA5qHm061XnuUTXJgAuPovyJjX+0c3Qo3E+SOhEAEVramvCU/OF5z1XDFH0GGAT2hx6XM7SnbiqosBOSsSwnaAoQCY4XZHVmPT5lNQTBdGUuWriBdpLq+r1Lph1S3IJsymQatNwysYsSN0Qc6o0cR9nojqY5Nyb3SUBJuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvExjb1MZSP7RlTaLzOioKlCZpwAMRjMuFnxkJH0hNI=;
 b=a1xZo94fAJRwrz8tG3q2ostygQ8APZ+QaisGBQ3vI8O9onDLX4nPO3Ak4cJ/hMGGSW4BxOT6XOghUolaO197z5Wzv/eq8zG3r/NcKRvTmC+wsJJGe8l600dcjnrzIrQUlFziX0xmGWE5Cf7sWx/WwEP+vUIeka3Z0JdR/eFzEOhiqLTo+OmPlmwo7ceRrK4qqxdK41TMZ05gjsGkt/ulXF/SKdGXvJDntG6aooo55DOy31cW6hFfPJPtlmE97er0VDVY71KS3JmfUcG4eKaIfIV246ns2zgJV1Bc5vKqn4KU/KynIT7jWLAIZ9A9HL+ltp2q9m4KNLU5iJS1UWKc/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvExjb1MZSP7RlTaLzOioKlCZpwAMRjMuFnxkJH0hNI=;
 b=vUAveDQiuUBrfzmvMsVIxQKVNTv95amY9VRbCH4CsIe2i8/HlMmgzrZh+LhVBw+3jrnyZzsXy8GreMkIq5PL1mO3jVpXAO6hkj3MiDFAA5RdyrFoLHpEflXT+Wo4F7XsdDqGxLKk5MRDyoRVjMwQvaV5Dfk5IOOVBuKao7SCEf4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6603.namprd04.prod.outlook.com (2603:10b6:610:34::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.36; Tue, 11 Jun 2024 00:21:14 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 00:21:14 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: allocate dummy checksums for zoned
 NODATASUM writes
Thread-Topic: [PATCH] btrfs: zoned: allocate dummy checksums for zoned
 NODATASUM writes
Thread-Index: AQHauNBjiAAbvCHrw0mTM/rxpZrFN7HBuOeA
Date: Tue, 11 Jun 2024 00:21:14 +0000
Message-ID: <tukozofp4qyegqa4btbxisw4slvalulyegzc37en2ogeu3n3qx@5ee2xvtp5erw>
References: <20240607114628.5471-1-jth@kernel.org>
In-Reply-To: <20240607114628.5471-1-jth@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB6603:EE_
x-ms-office365-filtering-correlation-id: 6a1c4d6a-6758-40aa-1365-08dc89ac679f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZrY0gOVDFX0C2H+rTKeKUoDCC69DxcMhJxKhT7Ey1cW+Ovv8HGldJt0d+82D?=
 =?us-ascii?Q?QCLOaaXbhdT0q0s6ZWuf1Snx9YNxiUwfgiUxHxR8L2AAcBkPcYM/FeZ+d/B4?=
 =?us-ascii?Q?Tw5PWb6Ir0/4Ct39eNmtpUP+yzep/gTeBMZhj8i7QGT9MWE2VkyFQQRIxvK+?=
 =?us-ascii?Q?KDJZAIXyiAI4lSAzK8co82Qrpec4WdqW1bvo2E1OFfTYC8Knkmqxd8wPB5Op?=
 =?us-ascii?Q?ppMMlKm940CbEDoQEtTd0JkDmafoFjJd9McD3HZUBpGPJLuGOuFj7yIx1eHs?=
 =?us-ascii?Q?b1gO7nCnVxApzhJHvMnskWycrtcXBRV0FzOhIqcIqnBLJyodnyT2PSxcKPQr?=
 =?us-ascii?Q?HnqQcRbElqUipuWBvg7w2LystRDPJCEbv0AQQI24aoBAgFozWUdUWpooJ5zG?=
 =?us-ascii?Q?tcET5VM2MfhUCQRQ0eIXXuKojz6br0OdeFRsgZHIHN0GnQsDmKsWIMtgbgi6?=
 =?us-ascii?Q?n240aXpl9Zc1De47Dvj0+5vtUcb7f0I36IUmoLO9SQdWM3k8upOoh+ZRc8y/?=
 =?us-ascii?Q?GBwIzjN4noFdoTtTy/gUSa+ZWJGG5T50egXfLx+UxYid8BLywG1cAW35Ym5U?=
 =?us-ascii?Q?6uHf6h0KTSWr7bp7kdGMsp/p/ct0tDb+fVJHJXeYCatzgqKSjI84x/VwdCzz?=
 =?us-ascii?Q?h94UXsCIFt8hmSmTQERfa6J0MjMBS5hf/gR5ziRKrdBZMTzp1rtExAvSqIjr?=
 =?us-ascii?Q?y7pcm/1FP1r1MVdmu73+px93OQeOQMBvgFUA62vDvkgjVabKXGuvt5Hj5wph?=
 =?us-ascii?Q?UdEME7yJ9srvsCvRJi4aJen+YpEzcB9cMHA/oCv2GT0XqV2HtseGAmK16BIG?=
 =?us-ascii?Q?Lt0tLv5MdJj6J510KZqtxriKcp1590/V5APm3toZph1OJ7MfZ7wXAoPF/auo?=
 =?us-ascii?Q?fKZ2gRb5YWUOLoIQhzF+eAsn/kkC/Lus7Q47i/ESd7kvrahLga94cSROXq0P?=
 =?us-ascii?Q?2BzvszXyjYP154cAvRbYlycdHNa/ZOnm5Xe+ifa5jUjQYsxPGvtUWxV/4ieY?=
 =?us-ascii?Q?MKwteoZINaLZG0DQl9IkpPZgwIWZfGq6MfGH1DX1XV+ivPalP/itRDhwOng2?=
 =?us-ascii?Q?qW4uOd3bvSXmD8uvREb3QWlBl0YiYS1jZn9ggWOFP14Lhuynn2wSApV5RRDc?=
 =?us-ascii?Q?bWrK4VxL73NBSBNgk23Fj/FCXRXk0vSoVZte1lSp8AF4Qt6rs500yFqhMxmN?=
 =?us-ascii?Q?ReHKf3m6GyX0DvouluC9AWbBH57ukXbkT1g1XVd2p7j9FwN3nqvR0HxK8WXS?=
 =?us-ascii?Q?4vywNW9q9eUFUAKjFJ1M2pM/vTAjqzKsJ0THQoZzdV+B1Zan6mjpF9KZM/4Z?=
 =?us-ascii?Q?K1prVurfc2N15UTySNtGM9TxhKIGka5d/LKD3Bc6MnAeh4WuMTbNmw/nhlbd?=
 =?us-ascii?Q?rTYEE10=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EKiMjqx+mpOYQev2gHVel7OKCRp1QLNR++eT6g2zBY+fLjbe5JsnvRPOcTiI?=
 =?us-ascii?Q?LVc4kmD7UriNq9VDNRMzpgCbvBF5iqRDYzxt+DEB67+AqaULk7ZWw/RjawbB?=
 =?us-ascii?Q?cvqwLmT8+d26lh4lkNDqOROn+8kBfbrtLQ03pvOaBkRDeVi81OxjW9MA6smO?=
 =?us-ascii?Q?TiZQ5GMMN7CGAWFs2dbkK7TP1yo1Coiqzdmb5urGefvgyAbskr9A8xl7xyhH?=
 =?us-ascii?Q?7EHYIh1RSXF3910dUkA2m/i9QO+qXvGbbmqPMwL5ni7ayM7HIaXjYbz/1Lo2?=
 =?us-ascii?Q?UyhfPl9fGePpjAlgq0hpyuSKYrH6qxFgvrX3OLrF1YUFTawJya3nEImLxLWY?=
 =?us-ascii?Q?DzUzjy5s8JKJoilFq2CC+swJB60gDi6pNM4MSkDlVHT7hXtMJR0XaqM9sWmw?=
 =?us-ascii?Q?Qa/pm28WdtHGowJyOVrYrTsdK3aefKtMJR4qs7d6y4fKBiAWn0T23CUfs5VL?=
 =?us-ascii?Q?Tu3SfK9qatp6ppl+ztijTPglKxwGqmDuwX5mgOe1tp65i/vzrST1ESsDYs+u?=
 =?us-ascii?Q?qWc6GMxwVh/OvrciBrhr6/wUKF5FTBl1uHzHoHn6+Z1Gk+YVR1zGou2Bq3ZJ?=
 =?us-ascii?Q?rSKHjAD6n4wyeUPV0MAnzgtYRINAUtQha1SimC0acSre5sp/dm17+QNSy9dV?=
 =?us-ascii?Q?gFvbCz2KLzJvXJ3/BHtMiTf5V0ECJ7DQNB2GUv1EuWaZElS5pszJUETkm0WM?=
 =?us-ascii?Q?H6+nXxrK1Wht0LY9yPWh6HPLUF9DkKNIrtGcDkjWvdX7lCNw9kA/Axqs0NRI?=
 =?us-ascii?Q?ku7K/LseLzZ9LgHZLnfjZOAcZSKheP7p5UibS5Qv+NIRUHYN/myWh+Yt4Tzr?=
 =?us-ascii?Q?V5npm15VZJTaC/F74bQX8kzQjsPmU+GZ+/DlE0ZjErhKVIdzDnLGLiWvtzeZ?=
 =?us-ascii?Q?BV8LQ+Uona9qGwsbeapdpnpT5gWhlMwWRHsxoosXtSvo0Fz5haaNdTl4uI+v?=
 =?us-ascii?Q?9Q0jMvHGSe6Gb/G0clmChSZVAcIF2sqS2JwdnDKcGpDWuTNnKni2dwimtO5+?=
 =?us-ascii?Q?lHfC5Zm1HsR2KemFn4X56yRqKHIFc7jsROOOM8rteTP9PD88KmXQZcJnc82z?=
 =?us-ascii?Q?me64/q73XeLWx0EKKKhLMhIYX7Jhj0tsQZCIIHt2U+BLJ8Qq+raWWKkLooh4?=
 =?us-ascii?Q?2cy4btFF4snQP8bTWmXzHermBcAvzGGzEUjd/4mjDklieSd/e+A6MFG1PuAA?=
 =?us-ascii?Q?cfB/Cv6kUblGIwFEu+vIVNXUheMz5a5eQ4UpOGzBk/tJdQQ1RYvXibKy+J5C?=
 =?us-ascii?Q?VERMqEJnKo+nKZsvEkkyv05aKAfjfqDPXoxXXiaZlxzqV1SoLh/ERsak0sw7?=
 =?us-ascii?Q?PLeIwevJgFqc5ACXOmQtxKyxGZUnWmgNBFOyOwQTsoltqwG5rNx2CrnvWL1X?=
 =?us-ascii?Q?PKXZccEcuKIdS1pOc32czRMFV9hv+PBYbyryyNU8DUcMA4SvAQ0yXzI97hT0?=
 =?us-ascii?Q?sBE8cxbelE5SI1sLaX67Z8JwgTw7ouA7YlWErgDg4rWiW17avA68HYdBiWVe?=
 =?us-ascii?Q?6Hdob24zrHTgvKHr0D+Yrmhe01RVmphzXRumTgmDiZI/fnwcsqKXIm0SYJGr?=
 =?us-ascii?Q?QgPBkXgegLxHJtsGB1J6JUQoOYp7cfPtRSiv+R4qqQYGe8+PPLC8l+0gBy7n?=
 =?us-ascii?Q?Brl/t1yMZX3sWeWzYI+6+6E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6BFFE41EB08A5340A6266CB08798CBA3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oOd36gBq8Kaon91VsectZ0fnXYDQa0I8Hfvq4v2SVGE307LZI6EwXjDO/zasdmZCblec46teFQFDmlEChwdUfOKpbqZJF7Xgt+iQ8YxWFoEg32+GXhtSU4vqdD+qZYIW1R0p3BujuWC5T4itBh9Vziu7sSjWC7oCykcWIwdCV5c1PTximPNZHxcQ37IY8Wlo/mKSa1e3IBS0AWCk6z6jYnGO2LGQzNKmqwksoXQpdmDt3q86+EqXg0vwPvg1gGNTlnlKfdU3keG8VhtkTEzbTDAMyqRHTKmLcvjE14obLF5+08A5K1um75UCmrqE68ypLf3CRoBtsf6a3qepxd7foK4ZNJXJkZDGRKJk6PDhsL6O3o+jK8tdYoZ+DyclMlIvMIf9PE8EOjIRc17Id8qtuVB8ujhtZnv4nPePtrwgsbeG4GKAUA88eElBnKWXU8t4I8O5fs3+afWpgJhltLcEWXR5LAMeV/R0qE/Mw2OfqQQxvG8kXjmEolGaYKaunjiR9cFdlWlsBVWhRcylCgdRN9B/8Gn+nCyo7W2RCWe6sElGpspgaRVJmAD/BaSKpQknSzq2YIF8n4Oqikd4JauIYpqJymMbTno6UUJWv2EzSurJJBrwNWgf2qDN9U0Reep4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1c4d6a-6758-40aa-1365-08dc89ac679f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 00:21:14.5369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UqxMN+MAbyOiKpIKJDm2NXj4b6zr1pda17ra5DxXVYDtJYdLnRCt7st0pMEnAhRmOWLgLbnZUp5bmASg+zXJ6lLqBG2NLF1rDe1x1czge18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6603

On Jun 07, 2024 / 13:46, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20
> Shin'ichiro reported that when he's running fstests' test-case
> btrfs/167 on emulated zoned devices, he's seeing the following NULL
> pointer dereference in 'btrfs_zone_finish_endio()':
>=20
>  Oops: general protection fault, probably for non-canonical address 0xdff=
ffc0000000011: 0000 [#1] PREEMPT SMP KASAN NOPTI
>  KASAN: null-ptr-deref in range [0x0000000000000088-0x000000000000008f]
>  CPU: 4 PID: 2332440 Comm: kworker/u80:15 Tainted: G        W          6.=
10.0-rc2-kts+ #4
>  Hardware name: Supermicro Super Server/X11SPi-TF, BIOS 3.3 02/21/2020
>  Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
>  RIP: 0010:btrfs_zone_finish_endio.part.0+0x34/0x160 [btrfs]
[...]
> As zoned emulation mode simulates conventional zones on regular
> devices, we cannot use zone-append for writing. But we're only
> attaching dummy checksums if we're doing a zone-append write.
>=20
> So for NOCOW zoned data writes on conventional zones, also attach a
> dummy checksum.
>=20
> Fixes: cbfce4c7fbde ("btrfs: optimize the logical to physical mapping for=
 zoned writes")
> Cc: Naohiro Aota <Naohiro.Aota@wdc.com>
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Johaness, thank you very much for the fix. I confirmed that this patch avoi=
ds
the KASAN null-ptr-deref as well as the hang at btrfs/167. Also, I ran my z=
oned
btrfs test set and observed no regression:

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

