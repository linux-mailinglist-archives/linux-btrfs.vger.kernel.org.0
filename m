Return-Path: <linux-btrfs+bounces-17909-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D03CBE5D00
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 01:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9311D19A7218
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 23:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0684B2E62BE;
	Thu, 16 Oct 2025 23:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ic7noC4i";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Mc5OtzQ9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD20334690;
	Thu, 16 Oct 2025 23:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760658603; cv=fail; b=UTqK9n7uCfbDkEJdUhmwIZ5m1XUKNdtak3LU2W2nbaWbLG61+aRQg8xsYV8FGIllnshaT88gagFLBl6Z81antZg+FjFdVReifLNVv4NuZGBS4MGvAxx+oIL4h5b7dm8P8S4ZoDl5kqx0bSK42ZqYV4cEYeX9v7Iu/hNmIqtllVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760658603; c=relaxed/simple;
	bh=vGDPQoLLiNG6wieaUSmw87cUNl5R5a7xzEkpFH4oIfk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ByeCN9HOOMb6NflQ32wxe9Zglx4QcAajK+AMlVwGSuRJ240VeXrtZ5gua//KhfW5/plrdiZ7vW2jQryv5mqWts141KFXBK6Wz6coitR5MWY8ekp77ZNyi2WA5sgrn5fKg+SG2D3f9+teut5jwq/ARGb9ewXFVNyeemRasBeLccg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ic7noC4i; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Mc5OtzQ9; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760658601; x=1792194601;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vGDPQoLLiNG6wieaUSmw87cUNl5R5a7xzEkpFH4oIfk=;
  b=Ic7noC4ifHX6cAmLdZaBSyNwByEvhJnT4b7ObgfZM9wWi5FSN4vvmusc
   zf8Cv5FbyHrnXrJzJ9YzOheSEqR7MxMb83yweINxY8tCA2sO/qCtMaddu
   LX2oaG01bxpf7g+5+24uWGi7s2exgSGHwSsuGtNVfovrshZyd7LqmwNcr
   b1GnUGg8b3MCodG9yoI5LeyY3UjnbMlE9npZN/mspavrhD44Bsu26MGgc
   w8Y7wLwKcM/6CMS6dcfRQuWv9rQxZy+/GC2XAybMgQGKhF/dObq7W3ix4
   NiAy8+PyIRX0iryOfuvgv7Sz5Bir3r0Q/9bgFf4hBDkJKOcHRG8LnwX53
   A==;
X-CSE-ConnectionGUID: saE88gIUTcq1jZaxfl5huQ==
X-CSE-MsgGUID: DZGaoaI8R8um3LA2lxJzjQ==
X-IronPort-AV: E=Sophos;i="6.19,234,1754928000"; 
   d="scan'208";a="133275669"
Received: from mail-southcentralusazon11012012.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.12])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2025 07:49:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFynA69W4n3Ee/mRNfD5V/zZ5JHExzcN34AESvP1LpUttmx9iqhzH/M7pqIofqI+kVD2OO9ZyWmBor4eM9s6GT1/yyb6ODXMQtcKJYhoFsPerGT76xAosZnTQQQj+Et3XR+2ICT/7o2vMATzBoBo33CIkvhA/sWTsFumILHkQjkw3kEqImR6g6XBfcAdB1TxbVvt7H9h8ctO8DlFwOkA23u0mszWI/G0wX+qDYvpnhs9xo9/KZ5i50GsKrjfLkNGNUAj2ImbcTXuGsJKTObU0A3k8rlJFokTakCQ8yMmXmAdXpVM6rs8j6fuvauzD3KGu8h6U1f1rgR0FjF67scO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGDPQoLLiNG6wieaUSmw87cUNl5R5a7xzEkpFH4oIfk=;
 b=xN05qJKxZlDgyWkWhd4b+m3mY2qxw+l6KBbvW2UZSUXZm0De/x1VqIQ29O7Ba5ICnxlckrQgBZXneJpiise3brGeQEk0v0akIj/PWExrAbtmlrXCZ06mV2mwvH/jmsjnR3CfjwxfgVFXS97Bu0zaXDWlUP1bfJPbMe9GVG00KQitHmXmgcyavBE3IbCMmWLAx/caD3CniD4e7KsAM42D2s0W9IQVx13GT+L534cvDIGRSaIkoXEwakcaNrvIKNnL+Gd1gLVGj4FcOpygeZWFg/+kpG8WyWEKIJAhOhKKAiqUfudk0vqmDpLDc8kjy7s/Vusmv6d65QPLBVSlQzVcfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGDPQoLLiNG6wieaUSmw87cUNl5R5a7xzEkpFH4oIfk=;
 b=Mc5OtzQ9bKBRBENT5RJCtNf86MqkA9oI6Hu3zzUP/ImHfoXG/Kf9ebuuHBMD/Jp/TwDT4ajOjI13RsDIas+1+Y4n4/I63Y2eligzZhDhUp7G/CwRw+3bXDdmaQABeBW1NcGOUXsokxx4UxRfsu6mdWqN4h7hY6Dn91yOG3DGBN4=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM8PR04MB7848.namprd04.prod.outlook.com (2603:10b6:8:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 23:49:51 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 23:49:51 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Zorro Lang
	<zlang@redhat.com>
CC: hch <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, Carlos Maiolino
	<cem@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino
	<cmaiolino@redhat.com>
Subject: Re: [PATCH v5 1/3] common/zoned: add _require_zloop
Thread-Topic: [PATCH v5 1/3] common/zoned: add _require_zloop
Thread-Index: AQHcPrB04lc+Hb1FBEeUXMlJpHhToLTFcb4A
Date: Thu, 16 Oct 2025 23:49:51 +0000
Message-ID: <DDK5DQIZVAZI.2PV0HKAGIXMK2@wdc.com>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
 <20251016152032.654284-2-johannes.thumshirn@wdc.com>
In-Reply-To: <20251016152032.654284-2-johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM8PR04MB7848:EE_
x-ms-office365-filtering-correlation-id: b2ef276e-6dfa-4400-d754-08de0d0eb2e9
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?KzZXeWluVVp2VlpwRU94SmZnMXFmMlBOakdkc0s2SU1TSTdFRE9kcEZYZk8r?=
 =?utf-8?B?ZWxXVXRDUHVzbmdLeDFhblJwcVVuaVpseFNRQjZTOUNVUjZhZGJielU2a2ty?=
 =?utf-8?B?bVJyell1Mjk2OWJPaTdZR2ppNDFpNnNTMW1QNVk4U1VmWVBFL3BWYmtnZXY2?=
 =?utf-8?B?eHh3R0hrM3Mra3pMTmxuWTg0eXYxbnJSZGFqYSt4RVg2bjMrU0Ixdit2T2dG?=
 =?utf-8?B?bUtXTzAxL3NNbTNUNnpoejRxN3VJZituTlE2NHlhMytVOS9uV2xrRHFkNkpi?=
 =?utf-8?B?K2JvRzJhaW51Q2xwY1p0WE0rUGE0WnIrOTF4c3kvRCtlNmM5NElPaVFXVU9V?=
 =?utf-8?B?d0lSbTZic002Yjh3RGZNQUlZZVFkZm5ZWFB6RHRGTnh4MXZ6QzlHOTNFWSta?=
 =?utf-8?B?WUN0aWFxY0xuK3V4MlB4NGNJRUtvTFdBUzhkYmZpQ2JMeE1nQTM0QVlwRSto?=
 =?utf-8?B?cnJwMGVMZDVFSkVhcnhKcEJ2cUowTDFGWFRJb2ZuN3hFcDMrcHhPdXlZcjV1?=
 =?utf-8?B?bzhKeFU1ZmM5Y1dUQ2FOblplUzd0TjB5eElFVHV5eFEzMWtyanB0dE56U3dW?=
 =?utf-8?B?dUVRbVY5VitZWlltNFpPQzhHbnJTM050emZ0YnFCMFVyd1JVTU5nZzFjanRW?=
 =?utf-8?B?cUI5bHhoajVQNklPd1VNQW1Wd0hGcHhsK1VEOG5aSFhqbzRhaTVudzRRa3R4?=
 =?utf-8?B?MjBOckFML2s2b2EzR05wb1BPY3JMRXZ1Z2xCVi9aSTQ3NE42VFl6aDl3S3Fh?=
 =?utf-8?B?MDgxd2tQRkFnUE5oOHh0Vi9kc1VxU0RiYzdkc052Nk1zMkFKeHU1ZElYMjMw?=
 =?utf-8?B?NjI3ZFVZWkZKNWRuaDlBU3ZNVG9qREt5d1BUTWdnKzFwbkFMUVA1ZWo4OGhI?=
 =?utf-8?B?bGN5OFU4RWFYRTQ5ZXZhZXBGSHJKZ3FlZlJQUTVFUytyRDY5S1NUUVBING1K?=
 =?utf-8?B?MEZ3YkpIMGhVS0NWUzlTbzlhbDRTOXBGbFJiZFNidGFCOTZ0ekJCV2Vrd2Vu?=
 =?utf-8?B?T243SEVYaEZ4TjAveDhFOGlqSGIySVkxL1dOSFl6R0F4TDl0KzhaME14Qy9H?=
 =?utf-8?B?WE50RjdSNEVZQ1IrS3hodjMwdUFiekhmRmdZeTljc0ZsYXN2dERMbUVHeXd3?=
 =?utf-8?B?NkI3RUJmYVVxWlFNclNlZmlQTGpqSFRCUVVVVnpXKys0ZjdJK3R1UDNlNW1o?=
 =?utf-8?B?cDdiWXJVVGhMeERRa3FTREZaWC9rRGpqcFJlU1AyMVdoRW03RUJYU2tNZkVx?=
 =?utf-8?B?TzAwMDM5Y3lkeTRKZjd3ZXk0WEZlUGJaNU9vZGRMUE84eG9udkJsMzBZUkg5?=
 =?utf-8?B?ZWhYbENkK29yQy9kR0p5M2hOSVpmV3Z5V3BBMUFnc0pYY1pqWnRtT1VPc0RN?=
 =?utf-8?B?TjR0S3VhOTZNOEdHOFd6ekZUWHNXYkdYREkwR0IvSTJOQ1F6QjJRWm15bUVR?=
 =?utf-8?B?NUp3ekR0TDYyMFFOeHRWckhUWXZIWGZ2N2JtSnFCb1pHOG1YcEkwazRZN0V1?=
 =?utf-8?B?TnNSbExVWlYxOCtTTitYaVdRdmxManN0M0lxZzVkRlByK2FRYlNrZWw2RDhL?=
 =?utf-8?B?TGE4OFFJQ2hsOHI0andhU0poSDBqWGdZUHNMVUdaZTlvbVNBQmdBak5EUGIw?=
 =?utf-8?B?VWxKUTlwUXIwTDJTalJKWENUaGhkTjJVN3ZLU3ZhaG1hM3pwWnhCd3h5Qmhn?=
 =?utf-8?B?OHN5a0Z0ZEFIclhrbm9hUVJlWEFHSUpxRkFQVXRuWE5jU2x6Tm1oajVqMWNh?=
 =?utf-8?B?MnUzUCtUZU0wUmRLZExKMXBhTGhTS2dUK0tmUXcrWjg3VzY4MjBkZjRRYnNK?=
 =?utf-8?B?M25SUmpFZzlUb1JPMGd3ZnYyalRRNERSbWh1aUxmYmJUOVUwMTBnYjJrWkdr?=
 =?utf-8?B?MXNMdk0rWXpDVWZUNHIrY2dWWnRocGdFNTc3aFI1dnVOa0tjclR3VmdzZDlR?=
 =?utf-8?B?a0RhSm82WFpYWVM1Rm5HM3BISG1qRENwTFdjMHM5Q1Jxd1dmdlE0L0VybUNt?=
 =?utf-8?B?LzF6UVVXWW1PYXY4Tm1kU3AwTm5RM2tRa1Q2d0J5dlFOVlo0U3EyeDBVV0Jh?=
 =?utf-8?Q?9ZJOY4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OVBSR3QycmE3Um9CeTNMWHZsRXFMbGNndmlMQ21wMzMzdVFTb2JRVWRXWFdT?=
 =?utf-8?B?djZJWmZOQ2VScURZRklFR3NaNWNKQzNST25Ta3pXR2JpdlQ0QjNwOHZyUGRM?=
 =?utf-8?B?UTFJdlFGRzdPcWt1RkVqbjN0cE9ibEN6YzI0cHBhR2pHbzB5NnZpK1FYSGw1?=
 =?utf-8?B?ZXZHZDVFYXVrRlB4NytrZFQ4WWlrM21KWnlDZGYrWTQ3M0RaLzk1dmxiRzQz?=
 =?utf-8?B?ZHgvVnU5b3N3ay9BWXhzdHNQbEJ0eWVlY3hyRGVuLzlxRm8wb2RRTFZhMWdR?=
 =?utf-8?B?WWhKclBsTGpJSzJjNDJQT1JGd0plbjVaditnUkw0THlXYW9wSGJYYXVkcUhj?=
 =?utf-8?B?bFByWFpwQ1RzQTJwUHJFa1BiY3V5V1ROQTBuZDBiR1MrZ3AyUjJRZEhwWW1M?=
 =?utf-8?B?bm4vcU9WYzFGbGlHVlN3TGdoMSsrazhHVHJ5SlRWc3UzTDYycWpJam1hL01N?=
 =?utf-8?B?T0dPR2pGLytFSXc2N2hpNlRjemUxUFN1M0tGUWFQUmNva0FNUnRHZGlldTFu?=
 =?utf-8?B?em80c05iM24vRlBPK2ZJOTBHYWkxM21oVlFrVGs0TDhXN2orWFRDdVQzRWls?=
 =?utf-8?B?dFVBaW1YVEZmWklPbnNEYUVZZEpOVXp3SXhFd3g2czBZTXQ1S2xGYUNtK0Zm?=
 =?utf-8?B?elFnRGswUThEV0lrWFJHVVd4OVNrZGt6RkN5TEFxanVuOTdaVmhnUkZWRWgy?=
 =?utf-8?B?ekdtRVNDVmFXZ2NISFc4cytVUnArM0kwNXNzQmk0U1NQNGhjMFNYTldrUG1Z?=
 =?utf-8?B?NHR6bDZSYXBoU0FBQUpYZ1NES2NYWWgxeWZpWGh1K01ZNzM4RHJNNXBoT2x6?=
 =?utf-8?B?VlhLRlJCcTJ4SGQzV1p1ellWeGdRN05QemdIdTNuQlRhQVUwc3ArLzM1KzJy?=
 =?utf-8?B?NWhidElQTGdpQnRHdlJkNTN1YndPS0VlZU8zUmZXbjk2eW1JVkNYaEtta3lX?=
 =?utf-8?B?aWx4VzFFRUlhM0dhVVBSaFpHVVpNeVI3WjVrNEwxcWtoNVhwZ0RIZktBTUYv?=
 =?utf-8?B?MkVWVnpIZWowVkpMTzE0cTUvaGxQbmpiOE9zWUJ1eGo1c1N3T1FhbnZjQWNH?=
 =?utf-8?B?b295V0E2SVFrblFLdldmRWg4Z0FkY0tOMzFxVDMzSHovZU5LOVgycGxBb3V1?=
 =?utf-8?B?cFVMbjZpN2JEZ2NlVTNnM3ZURWhicjYweTFwMHhKMHBuTVpvV2J3elFnWFFn?=
 =?utf-8?B?a0dMQjUyTWM4ZFBYSWhtM2E4V0VIaDduSlVSUDBOVDE4UVFYcG9BWmRZVHNP?=
 =?utf-8?B?TEhJZGRhVWg4cThKQlRoSk9DV05JUWgzaHZ2cHgxTGdiV1JjSXljOGZwWElh?=
 =?utf-8?B?OXVONzVnTWxZSG9ZcjNLd0QwV3FjTDQzeEpSWUQzRnNmd1g1WW9ERzZoSUV4?=
 =?utf-8?B?TDl6eThZOFZjUE4wM2RrcDBMNzN5cy9TMXhCZzlpRVNEZ2FYRWRKa2tkaC9R?=
 =?utf-8?B?SnJyWjBoQjJMR3ZNMytXcUxGUTd6cURDaDh6QkhkY3gxQVkrYmlxMkZrdlln?=
 =?utf-8?B?S2trTHIwU1Q3SEI2d25xMVdSVUIzclRxMDRkamd3UDVWeU9SMENpcEVSWHZJ?=
 =?utf-8?B?SXVvUUFoaVpmb3J2LzkvZ3Z2NHhuc1c4WkV1eXJrOTdXUG9ObzhPMjRVd2dv?=
 =?utf-8?B?clgxMmZBYmJER2ZRV3hESzBCVEdrc2VSQVI5TmdPcjVnTWZDTGdRSDNTT1hk?=
 =?utf-8?B?MzJLVlN4cEhHRXE2cjlCb0tQUEFMdnVVR3gwYWdiam9zWDIzREozeGtFbmlk?=
 =?utf-8?B?Wi9XVzMxemNUbm9ab0JPRGRnbE9GcGFjalN3cnI4czBsZndDWm9mZHdodHRl?=
 =?utf-8?B?Z092emUyQ1kwVmk5Nm1VekFRL3o1dXpqcGJSamVNRnpIYXVSQ3phV2x5c09Q?=
 =?utf-8?B?b2VlTllBQ0Ixck9NQjdIWDIrZmxBY2tGY2NLNVhPRm1rSEx1dEpKTU5hcWo4?=
 =?utf-8?B?SFJlc1ZMR2lMcHpZKzN5dmZ0VEV6V212Q290dDJXSkRJbHFYTEI3VjVqOW1X?=
 =?utf-8?B?QkwyZTVodnIwNzZLa3U2THNIODRoTk5pcFJWc2VXeXU0Tjh6aTlhaXNJUkF4?=
 =?utf-8?B?QVRLdnZQYWtoVk5mUlNUbnk2N2pVcUZOTkx1dDUrT2RhTGYweC9rUVJ3UVlP?=
 =?utf-8?B?ZVZGZjZaUVRlcitXSXUrdEZpcDBCQjVVaFJpZ0NzZzhMeVdkZjl3aTNZK2V6?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89962E2B0E585448B7AA110C71345E77@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6eBwKcY9Kqmkaq8QJtBmxirX22Gxnum7o97LgjKyfJEkAMfy/WLs/7UsNuRIWXY6SFBt94NJLB/2JBJcOh95wzYn/NmAWrAzK4UNpogsRmHPmwogL1Kt5wsIWYdioOwSFc79Jk+oWdJ02I0uHl5rjPPMNUIVgha/8rX8Ir+5HbdO8mxWwwUI5elhMWIgSqyn92KjvSkr+lH7KtIyC5x22HkBpA1QXibJ94PDT/Vhbiht8hILa+V62lxF/A4rbV1wBZPib3cssw368+Nn6XtuA1PyhmXOvaAN1ZBDxYFYyTMcxNj+GRWLU9z3+nAHG4qsXbPjtlDQcOzY47eMAxGr1o49qPVU/YguQiWzlBZp36XfTZjYKq0YJG9/u97p7sECMRWKHchzaJYAb2VEMQp2ZCb1CejP9HY8FRtLIKKEvJBldoOnsBbX4ElGIS+2/eTo+k3PxrZAjiWWcaaVtJdyAWdsY4oCPizAcJ88WucQgz1k51p6H/TcJy5xN2EkMTo2tjreB/wHMMA366Jry6dx738fl/F5GqV4uOda1cwVlCI55LlkQBsTK+L/P3FSfbm+PKSK5SkR/LuSdikGjEmIm058ytm/VaYE5F13TTE1BAoHdXbRQ/ujDMPauG7F/qAO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ef276e-6dfa-4400-d754-08de0d0eb2e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 23:49:51.5368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4mVI+dxCWILvyY9REcTduu8OOOxwD5GBzwlzFRK8oQIgQrEnu+AukbLqY2wJbLsRVUZQ06TQ1txM3xNWuUrjLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7848

T24gRnJpIE9jdCAxNywgMjAyNSBhdCAxMjoyMCBBTSBKU1QsIEpvaGFubmVzIFRodW1zaGlybiB3
cm90ZToNCj4gQWRkIF9yZXF1aXJlX3psb29wKCkgZnVuY3Rpb24gdXNlZCBieSB0ZXN0cyB0aGF0
IHJlcXVpcmUgc3VwcG9ydCBmb3IgdGhlDQo+IHpvbmVkIGxvb3BiYWNrIGJsb2NrIGRldmljZS4N
Cj4NCj4gUmV2aWV3ZWQtYnk6IENhcmxvcyBNYWlvbGlubyA8Y21haW9saW5vQHJlZGhhdC5jb20+
DQo+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gUmV2aWV3
ZWQtYnk6ICJEYXJyaWNrIEouIFdvbmciIDxkandvbmdAa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9m
Zi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0K
TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IE5hb2hpcm8gQW90YSA8bmFvaGlyby5hb3RhQHdk
Yy5jb20+

