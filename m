Return-Path: <linux-btrfs+bounces-10182-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8488C9EA79C
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 06:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AFD31888F58
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 05:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A622E1D9A40;
	Tue, 10 Dec 2024 05:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kmcqPUgQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xbcLC9hi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FC0433CA
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 05:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733807797; cv=fail; b=WPJZu4FNW9PSFUWY1ce6aYGnTl0JyoeoyKNZIpyxcGvCWH2OsPUix4qNppcsfA3ykF7q/LRs7GoOg7lv/9hhDkYk2Y0ng8MIboxvZ9julYNnsMzpWaxiK4jyu/MLj3OJXQWua6JYF4ue5RjuKSJAuUErEqXh3d7YrrR00JlR198=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733807797; c=relaxed/simple;
	bh=Vj++y6tnFpG/lxDL1O4PWjQcYQtKOlfrSk3K+0lwq8g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HgNUsfd2bybQwSXJRMdH/6csc0cSieXMOZrE8BR/Eu5U6TjQ7I+kkJ8zmena2H/fljwaIt49vu5ST5ssI/NHq2vEaHm8XAkrUY+8gAb8fjjmyal0M8QmYkqUW+kYPlYeBdN35Jc3lL8f734wVhs85OBj3Mjwh0J6T2XjCPUpwsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kmcqPUgQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=xbcLC9hi; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733807795; x=1765343795;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vj++y6tnFpG/lxDL1O4PWjQcYQtKOlfrSk3K+0lwq8g=;
  b=kmcqPUgQdo92k0F/ceIJkbzQBaLS126LS8BEel/3i2UFExNY0qr58XeN
   QU1kXj1T7pLEE4W2DEnvN5zLPNQ953fVcDlEZfqM6qxAFueetByp+8WUE
   pRxOJ1fbaBbLhtPGlzinkXxgi7CDd+X4IkzjqojKxjagT4/46rcOLvTc2
   HcYZXl0wzzTG2tMenBDSuZd0HdknjyYe+aNl9H38b2igtRtgyeWN3u+LJ
   MuK6S/rKZb0PemAt+mKcsFG6uouswI0AtFdh+rWSjybMaxkdtsAwD6kwb
   0LQSVOxRFFnNpT8Ev29gjZsowGHlhr+oU/69AscoWvEbd9gsvXHGOF0bO
   A==;
X-CSE-ConnectionGUID: calJ3kFwTYiQgc5JsVoqYg==
X-CSE-MsgGUID: WYOr4WLQRJG48QcqJxckHQ==
X-IronPort-AV: E=Sophos;i="6.12,221,1728921600"; 
   d="scan'208";a="34574764"
Received: from mail-centralusazlp17011024.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([40.93.13.24])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2024 13:16:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klYAlM3owcNS357hKk21xUeUDGUtpDsA2ZmEHWCjmyBVCmZyhUupe8L1zxzDi39l6/DIkiK2SPgjH6eeyo4zH1MYLEBibsPLEJnM9CxJ0PwSwp2tbuKtmRIRTOMTiA71zTJ8wHEJP10h74Bk6b/7KRgOnDKrFv3dvzIf95hEHgcS3OVNb+bM6yGmGF/NoiekBuQxoaNz5zzbJ3zxJocCvn/dPd7NtUvpTMDoqPYnL9szpOQeEiMyfkO7gTUUwJcsSWz5Khm/iuupj6sCBikQhdSHx/sJSJbEgjaO52NBfocapmQgztaAiZQVDBYIvahCud3tgBAvuHpOn810Sritew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj++y6tnFpG/lxDL1O4PWjQcYQtKOlfrSk3K+0lwq8g=;
 b=UNI4Ws1j/8KWvvUbppbQPkrnWZkhyOBYVF7TO7mFnkzPFY3dZEyh82Qn/M81sf0kUsvz5XNHcf3YSbFLSGQUFYt5Ye1ufByVzP52Psr+q7+kMeeYyEHmyp4TPV0epBjZQ5qwJv+xovy2wJ0hK4qg0m/zauBE40Oz+5sSvN5lRIZpJN5+Uf/B1m8iwfr7sJxN/Kdq6vxafOuJkNORlVwoilWfG8WLaxu0aTZ/PBWFakHzubKkziRPBu63WLHIGoggxAlzvOysfkNuPv+u1uY9uxBf8QEFN6+PHn5qUiWulEdFGjZKP+u58IU8MvM+3V4u9+NgIuirbP7w4FbE/j5cKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj++y6tnFpG/lxDL1O4PWjQcYQtKOlfrSk3K+0lwq8g=;
 b=xbcLC9hihfsFfvbKqaWld8syazpa9qX/9zEOKI5S176pa2IzWfqxL83KacUVwieCwrb5P3nRa8v4pcZ0rijTm6/aE/Xoh5iacEaCSOhqnzx9m32coId+BbDcW0wziYy85ZVP8YnE98AdBHVVe9hNNA1k9uMVHsOuTa+ddxQoDCo=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by PH0PR04MB7224.namprd04.prod.outlook.com (2603:10b6:510:16::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 05:16:27 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 05:16:27 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/11] btrfs: factor out check_removing_space_info()
Thread-Topic: [PATCH 05/11] btrfs: factor out check_removing_space_info()
Thread-Index: AQHbRuo2vdd4Mdb5G0uWLyf1neVggrLaqNSAgAROigA=
Date: Tue, 10 Dec 2024 05:16:27 +0000
Message-ID: <q35hr7tprhkuzeyvpr2mohudpndyprzvgcosyst4zlvcncmbux@pqpqkjws2ap5>
References: <cover.1733384171.git.naohiro.aota@wdc.com>
 <f4f89b4574df77147cffb21e5f74fd033a8dffbf.1733384171.git.naohiro.aota@wdc.com>
 <4d51d335-ad2e-4ed4-b100-51f45fb3be20@wdc.com>
In-Reply-To: <4d51d335-ad2e-4ed4-b100-51f45fb3be20@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|PH0PR04MB7224:EE_
x-ms-office365-filtering-correlation-id: e4a61b12-6f05-46b5-53c9-08dd18d9cc68
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FGyC0wvS7NCnHL2qh9jpKSmjfh/nigvKxKOVnjzcJ5C2KKEH5mprRrnbXSey?=
 =?us-ascii?Q?pzOW5WqbuWvFvnkOTHMhpuj3BXv86EqGzRpKqPRMDZR2iHruFZKpvO94zU4s?=
 =?us-ascii?Q?LdxAjZ7zvO/uYUdpwwWdWNJFpvkaoDpS+KrmD2kU2SViepLHl3PRgVbs7h4z?=
 =?us-ascii?Q?vVghi5ghDkGmY3IdaNkARk8rqsPVVZQKGzC25yc0mZ559vr5u230ih0T7kst?=
 =?us-ascii?Q?54NRlfsdNUojuERKKByfR8rrvPhaA8i0b+9p+KsW84Q+GUNhtVoGYl63yCqG?=
 =?us-ascii?Q?BJTLIKuZZtZ3vPqM24KPqp4AV/E1NiBlMCjuWPGDAyKKjr6j+f11YYuXjAFa?=
 =?us-ascii?Q?cVUoM682XL6o1aDqWyvUXnzWGN/VNPy0QZRd0r4dOD0jwuVHeiOvSeIRbDbg?=
 =?us-ascii?Q?OzQEdP+eU9elE7/EyXswyYqAkV0vYOfF9AVxAqru10KB+i1O0e78cFGuGP0f?=
 =?us-ascii?Q?WrYfo4qmSobi45Qk9X1gaZU5bMZezLVoYQ484wc585IY/cDy5NEhYkOfTe+y?=
 =?us-ascii?Q?JD7YBNfruWWDe0LbrEfa9pimZkpziP2zlU73z8FDt3Ul9mkmk6BFB0c2Ugze?=
 =?us-ascii?Q?LM+GB82I3LYZzMBGRwOnp6X/Hq+zaLOBKqXbJeRDFMoV7xYZGANaioNJEzCI?=
 =?us-ascii?Q?1/72z+llJlG+2/S8NzzEH/5oh7XmFCWfdeYdspkYGmSpqLTJzfCKE0+L3sgr?=
 =?us-ascii?Q?Vq2X7nHP99tob0db22HlYMJBZ56AnHSVLADRw6UbF/gbo7feoSBq5LodZOSv?=
 =?us-ascii?Q?PIFc0oB2P5qOrdGhwkfCCORg1EddN8Dz4hFky25iegtVJi8Xz5VSHzmTF/+d?=
 =?us-ascii?Q?R4S5V4Wy6iuQlWEB+NKg3Mec1RZ7Sk/wKVaf+YPBeQxzwL9itjsBZxTP1ink?=
 =?us-ascii?Q?VaqQ54vFyERoDwNV32GwLwndSTG6R8NVTWF+6G7IMvVH5hMnAc0HDcCj4RA/?=
 =?us-ascii?Q?99L5wkM80jUsvr8A7RtTY6NOTK4bkJ3NzeYrXNnxz6llotTpcRB2X0Bmc8PY?=
 =?us-ascii?Q?eqN2Tu83jvD4LLuYF7HO0A7NUtFpBj5uY6qC8rDxDBA+t1OCk8lEOmAXYPOm?=
 =?us-ascii?Q?XqZI0xXvnSy2PsuJ+KzZVSLtQgg+R4eo+xAob3Pt7itIZ2ylpF1JrpqgdP4i?=
 =?us-ascii?Q?t6drbEeQVRqpf1xpjrIyaAUcvLfjj1khgZq8BPDgzR8I7k97un5VPGF//8xe?=
 =?us-ascii?Q?yacCTIMJORr09cH/+YcHiLG+xXRTtjE2kQuKKNM7J2NV7D1gWa81E1EVcw1b?=
 =?us-ascii?Q?fQM5RQBXLy4Jdfx6dCdE0hjn+6gT0/w2NlF2/+DvCyXVw1ogWcI48jpwK1+L?=
 =?us-ascii?Q?EyAI1Px+CbKyTri35radDGiDAb+/LCRLual+3pcJXNF67X3XVxl0g1OfcleE?=
 =?us-ascii?Q?C/plqRYsciuiNRUhDAJqbwwHXBlxzI8TjTu8njMefGkJ2NefYA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?S3WnzXfyQH/r6skBMBsEbs7M6SanMt6Ni5fyt9gJ4lj1vL9dK3g7tG3mRr1z?=
 =?us-ascii?Q?LN3QQGnjA5e++LKckc9rBZ9yFb21EkgC5s6Ezho0BhIqgpWJRQJ4A3qVm1N/?=
 =?us-ascii?Q?tnBGrPbHI8uDEMJeulHGkw5CJGxuDlJ5TT1Bda+AzfVfGJE4M3QYw8YUYtqs?=
 =?us-ascii?Q?faLXCT+Bt/qI9UcYftNL7yrLCeZr12W1pRWGnHk7/WoyxDMsT3x2xugJVdm5?=
 =?us-ascii?Q?adttPUckcsw8zeFj9IDiIsbJ8XGznPsQLE3g10R9hcjAiJ3HjMyFconb/Afo?=
 =?us-ascii?Q?oIrHTQcrZ9Wq6Fsv7TMrVlgEylyGW1OZuIiWGRrXR9C+TWcxOFdgpm0KuWPc?=
 =?us-ascii?Q?UQjlscu11hPNOljrwbEVfoVCrxr6np+R28zGECofBZKTJfmtEOdaqe82eS4x?=
 =?us-ascii?Q?UjVVyRAe7JwcvA5xcHCEz20ENsXQhg5+piZJPi/Cf4wt/vJoxLJQ3zyndRrE?=
 =?us-ascii?Q?XoiuDO9S59DwIHk8u4M9PpMCrxitvIic7uoUavzrHavJtz6DpmSyx5UcQtSk?=
 =?us-ascii?Q?A4DHzV26aMgJAhUfuDW7UTTo2/YeW7HbY0lE8PVkm/Lc6+CGwtazoYi9Of0v?=
 =?us-ascii?Q?M935lOheDon/yoHDe2rrISF1nN//IQvLP7/zD5GMvSftB2uXojkGObafK7OI?=
 =?us-ascii?Q?zc3HEDRhEDQJQEJCeOKJet8r7pLOxIVVxxofZjrXeelTefhRgVFZQeQFtqUe?=
 =?us-ascii?Q?V7iexQntuQQEipC7PYNuekZyPP12N0/GSZNzR4AGi3Y9y0kNa57+iTcNofDK?=
 =?us-ascii?Q?tI25Z+aGWEu8eiwnMvCDQOP1//KBL1H7a6zieA3k2qUznb82dvPhnmIFMEeh?=
 =?us-ascii?Q?oIk9n8vhHlaVCLWmXJALAjPq/QuPjaN77DXSgP7kMz5qzw5LagagI680ag1e?=
 =?us-ascii?Q?iNpdaqZcsI5jPur8ZYtRqeawnVLlswVTJyfigE4aIrcAAvLMuQuU8cnozMop?=
 =?us-ascii?Q?uIRn4BMfhwYOZPkoChN13dAt9DfKIiXmCIzv9H4uitXXauDDIOAQ90GKLo//?=
 =?us-ascii?Q?ZU+GS08muSfUU9qz1Ygdp2jSVi3QYY1xCByCeffDHHLiOhQcPtZOzQZRlBKG?=
 =?us-ascii?Q?MPIq5qXb3nmybyAyqR/0pbAz0EUKzoC3cGD5hYlyunDZY0/lH7FP7V1QVoxy?=
 =?us-ascii?Q?b15d+Bh17jDlmvVZoNJISBKtEdjMGHvvAvHAv7u5JunPQB7GqchP/+oORHNC?=
 =?us-ascii?Q?eySVg/95jF+YfkWiNCFlDt/0pA6lLsOfxy73BWYzkj25PFSQQpOUNIukkeix?=
 =?us-ascii?Q?dBxWkYo/0w0rjWBjWd14r/KwpvlHOxiZC1HrvWE+3+iRznGxaDGd8a7rb0Rn?=
 =?us-ascii?Q?5i40GVdPf10rTpR+xJlVUMXqUgd4z2S++QJOxQ35xRwCI0fr844iz3HXK/jN?=
 =?us-ascii?Q?pbPLDkcCDHzq/ZFFj6PVweBFJC3DiLOidOgrNuIaS4nPmihWbdM+hAEoLesa?=
 =?us-ascii?Q?DYiXb5eC+Le35U5Q6z1ONKinsdtrItDMXNJmQd7dsc90L/372XzszA1WOvBz?=
 =?us-ascii?Q?qR+54tjlSSvfrVed9C42PsmuXeq7f5EsCXnWk8RibUDcGy/G+pOsXwcdL8pA?=
 =?us-ascii?Q?r+Ga60MYKFnnhSrt9FFUgCHwzsUzEZ6VuDJL0C8Ld+uYuS6XtrgTcuEOjsrW?=
 =?us-ascii?Q?sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2B5B5C35FDA92647B8387C9FB792FE58@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MpM2v8HHvCzL8PzU7mR8IkksbT7yp8WowKHt7QtgOe+WwaaHSdCKJKBjwAfEs6Y9PHrQNyok7AhYqy7I0gW8uCrvV+eyMdCOpCQP5VZmoeb9hVzCIsumW2NruLYOyNNmR65LrBfrk2OAXGcAc6X0kZuK8HuQN5UabY8TQzw2eHYUwMFYloL61CmhNDpxRlWOZdV9u8FMlTyN3s6qx4cM2+/Uo/u7bljBpy6yjeBSohEO6AEyY+mGIAyYWRElWP1pVsTZ5HFB7AzaztaHR2+Oi3W8EzlWe1VI8lNMRKeX5/hzpCZkG9G3dI6ojlrIyOIxV6MIPBBIOcglGSiJf0dLSrgJzvc/IELHcs9mWdYlg5YBB5Q+3IVCB1e/F80aUVcpiR5ktrb6lzOvaVveUaCByu67lLITVctXEJA8XYymKZ1TxC743IrCI+T/94EzwYxWoWrjcUWJtzoFQ4BQi3OI+XojNv3hEv3FtZKvSkWgRioSc35JLatZXWkvCV2l1w4XqR1AursNeoa3RB/aFHwe9QmkaAPPqq/uEPNgZh+TQOSPX5wvvxHudh+W5DUNjlJ/Wv6k5PPrp/UYnxQW2EuO6nRXRy9MOHC7+6xlTtP+qCBDxTdrFxY/LG3F9B8MFrEm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a61b12-6f05-46b5-53c9-08dd18d9cc68
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 05:16:27.2215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FFDsnA7ggYT73KgZY3H4yXbz3pFey5C0kkaqamR6mRfimG3q9Lmr/tgCIeT+Pc9HnSzG6/pP/hq+xd+I6VNH3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7224

On Sat, Dec 07, 2024 at 11:29:51AM +0000, Johannes Thumshirn wrote:
> On 05.12.24 08:50, Naohiro Aota wrote:
> > Factor out check_removing_space_info() from btrfs_free_block_groups(). =
It
> > sanity checks a to-be-removed space_info. There is no functional change=
.
> > ---
>=20
> This is missing your SoB

Oops, I'll add it in the next version.=

