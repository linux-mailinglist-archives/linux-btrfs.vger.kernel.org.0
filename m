Return-Path: <linux-btrfs+bounces-5140-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 501298CA742
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 06:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B161BB219BA
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 04:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FE221A04;
	Tue, 21 May 2024 04:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ieBbMMl9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ma7ABwTC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C861DA53
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 04:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716264846; cv=fail; b=C/IZAhWvmpgnaEpbw7ztvj9x56kPJ535H8ZOnqJ5BWuPNf2vmoGfFB5gajBwdreeUF4RXRy/oTomgmR7kmO12DYGCG+S7vh1ZSt/m3/LYLy+NMps7+BtYFFMPnKrOWaB93Z+KvI6rmi63PMKe+yCJLo17TETFkw8UL/TJR89maA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716264846; c=relaxed/simple;
	bh=y/hRWG9CbIG/rrOULARMPvN8rCvAD7G+uyDwZjYZq04=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GE+3ZW855YOepNkx9jlVMbbMPtNWbp1x1gqxNxMErq21wjIMDh4JjvLWXAw/XFnfILhpQGq3dgBDwBKGYPhJSkFg7cIoyYscrW0Surp7295pdbSAbSwqSUVxkP5MuH+esuQ3Ncu5A9QX0Yf6ejyAkQt3htFg75qVJl+kjs4DFjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ieBbMMl9; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ma7ABwTC; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716264844; x=1747800844;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=y/hRWG9CbIG/rrOULARMPvN8rCvAD7G+uyDwZjYZq04=;
  b=ieBbMMl9+U6QFmbBAdxz2f026R/wZC2irnfwXFh1FmgcnXBvY+5312BK
   Pq687n/3AVzDbgFcFlyxrtVB1AfWgB2/xJ1pAG0WyglUVTw9fQU+eXO6i
   QHzfynRyYVEI13M7QdJhKbZYgS4GUauKZ4Wmt1MJ14rMSNBj1gxdu8yRI
   Cr++KtWTUpusg/zW4cYRRD0hbqKH8puP+sUuTepWAdv0Rx5tWSTTqWedB
   5Q/l8o97OOiU9pVUc7np3+MkDHOnhw2QDKs+07QpPhiW5Ej8bM333cxg6
   ydjCqiIg/2jf+mr+S7nwAkzTveDWT9MVf4ydGMnCM+fBYh+PTkloNBgeU
   w==;
X-CSE-ConnectionGUID: HgeHcEFIQyiMLULcrfiXvA==
X-CSE-MsgGUID: 05V1AzliSR2K2LcKcNAlXg==
X-IronPort-AV: E=Sophos;i="6.08,176,1712592000"; 
   d="scan'208";a="17645493"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2024 12:13:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljyKuETf9QNthJo9aETdw0sPP7BKpVAmcEZd1O/DcVSX8RRCsb8Eyj+i5fxezr2119itzQdP7upIzDM+u0ExMlgUXVz2kvzcnSaxBZGtm0FG/HSy/p5WlyejUwo+9cIwdREm9+VIq8fUyA9WXmZcpV2L8B7jLgY6Cs9z+zbK+4xYe3vV8iYHCuMkSEAZjDYWQXIAFFDuEu3sXi6cJz1KcnLptlKa/4r8VIMRtLJ/5J3XFWeItN6VMeWDsm3ubpbZZLiTX/WKhXYr2JwiR135IV27gGKd9erBMaTAoTuaOqkqhukBeYzUW8GHolezgg1SiXWqirzk6Lx34cslsO2FdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6iWliaweyqRYwmOlcGpg9nAZ4aV83gLdeYy2SFTttA=;
 b=Ev2DDE2oqZmw8tyimi8qi4Wpaip4LwwkHMHEUaFb7dXW3vjSi1fcRXJuK7rTPiXEUtWWucWGFm48IgROqDLEWnzvfyDxq7Z7rYN5AbjzOuumlP9poQjLkoSxEi1S0QKdddnJklWo77p9t8ZZLGZ4mHiB8OAHFVJA1jLZBZFWDLvHYNQhubkv078IwvqYngeH7YPHDBNzTyeUeMul1AwBc4vwOULS0hWoW5GugUQy7uaRt9NPTmrBSvYdRnPSEPmbAUmt1+qH/VmeNky5fYvVb0N0bvql3lNK5UN1WNUepQzQuQwnGxTjeFE/ZuGdw4Uv8faAcUmc8+QStCHhPTyeoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6iWliaweyqRYwmOlcGpg9nAZ4aV83gLdeYy2SFTttA=;
 b=ma7ABwTC9KztQZFG1/7Jkg+GbTj2XjeMkGLZcBOkUhQx79y28mp+XBwyh6UM482+70QZWvNFtHbMNz2YrUsUlR+/SYGe1aZh26oQjXW/DP5//4XOOMRxMnXw9uDYtSuAyexy1d+uOQ/8znG+wsEi68QfKQQvq+QQuDDoXt6rleI=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB6345.namprd04.prod.outlook.com (2603:10b6:5:1eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 04:13:54 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7dd0:5b70:1ece:6b57]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7dd0:5b70:1ece:6b57%3]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 04:13:54 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: David Sterba <dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/6] btrfs: use for-local variabls that shadow function
 variables
Thread-Topic: [PATCH 3/6] btrfs: use for-local variabls that shadow function
 variables
Thread-Index: AQHaqu9RZvCvHEvw8keG2Sbkw0TQ1rGhFLaA
Date: Tue, 21 May 2024 04:13:53 +0000
Message-ID: <dpysu5cfgcwuqwvfvqzmraunfkt2n5bih3ushtyrx264mz76jp@wfs2eb5whhqq>
References: <cover.1716234472.git.dsterba@suse.com>
 <6cebc0c327002303ed351b262396aefbf68cff1b.1716234472.git.dsterba@suse.com>
In-Reply-To:
 <6cebc0c327002303ed351b262396aefbf68cff1b.1716234472.git.dsterba@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM6PR04MB6345:EE_
x-ms-office365-filtering-correlation-id: eee9b26f-8a0a-4615-0bf6-08dc794c6d6c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GIyqbi2eBgkxtQ8empHDC/GoC7JC9ZDHnBRBEQB7bgYjXmQS6fKIs4bplL/j?=
 =?us-ascii?Q?sUvWy4CqKd22ULRwgDrkh+0ENfJ1GM/gBb/NWS3v7xnj1N6YKO1Z0ezEZY1e?=
 =?us-ascii?Q?Sg1Pq71n9tTIy7eDTdhp/orralG47S779UfEUIVwLv2fiPxbju1incMcqkn5?=
 =?us-ascii?Q?ta9jWr+vfBvQ5fQhzOjV3Ggh+NfoURWWxR4ZzJauNbOO5oMJsW9IJLCeL3cn?=
 =?us-ascii?Q?eD695UHWql4SJ1RzCpNudtmhxVkWrr+fOiyeGZxPn7wQzPokQHIzPAJFVOMs?=
 =?us-ascii?Q?g4aODPl8OWldMCctl/8szAJAXBromV4of4wtqVkdoL/0AzXbHHjucVPAiI1i?=
 =?us-ascii?Q?ak3Rvq0d+px6GNiZvv36XckXbsPmeasjB4a0iuZ0j6oiUKg8Ejl874SxNRSd?=
 =?us-ascii?Q?5kF9i3LmxZf2RVrmwVEbJw+iNdBT3+WZ2l9gtpnwcCz2QSMmv4NP5rslksKL?=
 =?us-ascii?Q?0ElLwssFpak7KKJ89OtYRdHyOTH/sR0RDZkpENikp2em8EvkJns1kDuIDQ/j?=
 =?us-ascii?Q?zACUkRwB0+0hPvXrg4qzMMC14Y+HFsZNXPIp77ULvmUiNgxX1K4ogoAl3GFE?=
 =?us-ascii?Q?aRWqlHLtvEBzCHe642/N3aLtPvyd8uddktM7N0XUkSfbS7cwBLYqVavDI3Xg?=
 =?us-ascii?Q?py9gI2+Ex4h+YzJhuoek92EmT4JpVhZbuyN59UyAwOG/gFk7q2bCTKzNAYJv?=
 =?us-ascii?Q?gOwg95uRM6kSwk+uHoLzg6UKEyIXH+IVW3Px3BwucDz+Il8+lPyMkb1mCWxD?=
 =?us-ascii?Q?w+eLbRs4mAsFrerr40+ITOufUtr/wX78vDUEn00SdOcDJhO0c7ouuroRuZTX?=
 =?us-ascii?Q?CsWQpnUAF8MSwog3tyI/NEtpgzbXAOFmn1vGuvpm/T/VD6TdYuaRGObng+yX?=
 =?us-ascii?Q?eo8QLNBoJ6xideURNUu0alD26b+63ZE8mPt60GEUKkBNBB9TJltTWzBt0qy/?=
 =?us-ascii?Q?PIPxkA2xYZmlyBSJthLIG/A35dCQCGuj/nYnZzfUFPXzVQYrVzP4hHZDdENp?=
 =?us-ascii?Q?yrCkffC6WZLLYpUWQgcZiBV/Iq87WAhm1VHBTMU6jHc/yKp9Pw+24xPK/EtD?=
 =?us-ascii?Q?MwsAijtmNjSuQWnlbH+pRDgoZ7CZ4ft7gS0/FjzsRRob+TZmnBGA0DDV15GQ?=
 =?us-ascii?Q?slPAX3yys2dCdDt9NPUpGWYIWC9jX4JvUlRYUkWiatlwQ5mg0JmSYAU/2Fwy?=
 =?us-ascii?Q?OTvQ1oWUd8MfPo3n4y1PDwcR2eP5zwvGFVvVpaCJxzw2JPG92q3uP26U1A//?=
 =?us-ascii?Q?ffhBi/NdUpURYe3V5lLAtpKmsEDfc95mgyHsj72wB7DU2ZrFKD2cN7NDZuGY?=
 =?us-ascii?Q?A9oinFDzY+mzQyg3LN3larxFy98v6S0K5Mx9XmwtLUjl1w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?o0EdPq6AU0zrpR7kbmlwlzJimARG2fLHKwYer4LQZITHIdZrrtI2xUdKSf2A?=
 =?us-ascii?Q?SLA9tUQbO3rBdtxFNCS8wISY74omKslUgZ2yfcfsd8XiT5cIBmmJ0Xse+Et2?=
 =?us-ascii?Q?8QNrAR5NTiGqHjlt3vq+V0KeseFDAevoHwZpHPUT2gmjL5VPJizVlCMb67o2?=
 =?us-ascii?Q?3PlwxKFgEkVCSlcI/1b546kasKT0L7D5AuR2FEvJUVkqCA630fSdmnJyFpDj?=
 =?us-ascii?Q?PUvzTs9c6THtWft4T+zV+Wz9f2OS/6fSw/iGaBngG1RqbkTVpU4pZzBJbf8h?=
 =?us-ascii?Q?u6AihZmDoanoEMNwKchz0ovvuyA5tcPjWWeArbr7a4ZSosEwsHYbvzgaD1yF?=
 =?us-ascii?Q?jlemRyrI+vabmNlO933wSsHqcVWvuJs00tD57jvI2pvvj1Yoh7QesD8Hx0m8?=
 =?us-ascii?Q?dlhSLrsbq/Q9kBudDHj3mcDltW+rxrGSDcfUUjO/R0VYaZpOxOAl6cuw2CeN?=
 =?us-ascii?Q?Mi/OfU7kPp5QxUE394ehFV5FTEJrM6ed0zk/U8sP8APxqj6GqR45/vhSUShZ?=
 =?us-ascii?Q?KdtmdLWbIhUFpg4FR7QCQ5+xz2nEM9M2EQe35wzGw/65GUwAVnL7ne/7xtnP?=
 =?us-ascii?Q?X2jlwt1YC8Bx6rx0kFiyCjz2dAxMBKSpwiAW0hy+A6fZiMoyUHG/VSx8+C4o?=
 =?us-ascii?Q?pQ3wdtKiPGn0YNnzyOJ3j7fy/MNjmV7J3Fazt092rsN2DmQuYWiuKWjRh8Yt?=
 =?us-ascii?Q?ZZG1Uh4uK91DS1PBLkplwapBW/IF+qFjU3EW3WMyKNjCaIoMJXymhs3zOt6N?=
 =?us-ascii?Q?zN7/ec02vYgBYeGwx/zgPGsepbbJKOQ8reh7Kdx+0NyUbg0VHYPT/kiqf3Q4?=
 =?us-ascii?Q?hFXfZf5A/Aza3A+InKPsJ+cpDJA3jggh8+/GzNgo1JXBn5PDlNwWai6/Lp5Q?=
 =?us-ascii?Q?3gCbspnt3sT38kPRDc9iesCsRU2jowAAhTYtFLJD19A/uuz5FLdh0GIYtDI9?=
 =?us-ascii?Q?5MR2YriLZX1N7v3koDp2X3wGGVF3lYZzG1QjzJ0Jr/lUoX4qemkxQOntsElb?=
 =?us-ascii?Q?laEFSzi38eCd8vjpkj6BCUbuqXqydj2gcVKhtElgnQ6cF7P7YxTf+cxwNB4C?=
 =?us-ascii?Q?+qsD953i9k5Ba3mcSReo5Unbic5dgyszKTxLqNHUaG8HpLb1CSlT8DA6URnJ?=
 =?us-ascii?Q?vgO6/RJdf52vV2q+qelDw7XX4oWWdUTTsUyiAEdgyCnUml8+18GGizfEC3bj?=
 =?us-ascii?Q?Oaqc2MKpH3aO7CYTRKtCqPYhN4lR0io11V8xaJtIvOTNE7RbP79X2qfTggMa?=
 =?us-ascii?Q?726hW6jZMoBQxF4hRRoOxGkAstadWNn6tYqzxK1JsY1VfKJURWn+PlzFjmNY?=
 =?us-ascii?Q?Ae7PSIeUnU/ZoYbkArZg00POqIaH8o2WQnGUNeOQlcO+vIZB6Tt3eIxj6OsZ?=
 =?us-ascii?Q?9c6lz2+NrbPV9BDuNFXXcl6NRFdVdfC55hddlk2n4RZX8eIDOp8WfQoiZmTm?=
 =?us-ascii?Q?O12XMU+cURNHnSnxYUbDbkzZSleuUb3Y6JWBiYdpTl5Og3dQvJNBDMqPysY7?=
 =?us-ascii?Q?kh4WwgRhk9A1ga2yAjo5Mg9ZLHApU39imC1qrwQ4b7duGerofMZok5Zkhwwo?=
 =?us-ascii?Q?YV8TmwPzT5jCXDvZmJcz0EaxGGQ3v1WUt1oZLu8evjUwCQPegimROv+1Jhat?=
 =?us-ascii?Q?Ew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1A21EDB17E38FD41AB43C2B7A5E1DFE4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g6T3rHlt9t9orUS4JoyZZ+qxWuq4LeYY+1H8gNsSwH7YcpV0UMkGUkTQqPOOrlJZUl/ckFgBMo2uBsUEAL74ubEhpcPuSRi8ch6C55pFge09MhXh9WBQ/0WhCkHQWGXqcJ7xN3fKNM9aOb65H0TBYZmqoJ6sClJEPgI6RtRM0E9XafY/6/dNISEuqzF3CwoZ7P2AqXHZMEpEM3/yOjGQNxBMYm1eTILCvGL3szytWJl2Rd4nr1DkKHchSoTSfy7H4LtTcQ7E9x30Vy/axOxmJNcLkbSZ8x+A6gTtji/lQC17yjud2xME/gMSYkYtSTs9xoH1LWSRqQShphO7iH5COsnfO0BcQwMcDvVjhVp5E3fGhhT4++dnLLOp48FR2nE6c9fiWXgJKxbVu4vhzr4NWD6f7Jd1J/yW6xwSypxOsQMYDt7FKeTVf8U5z8WzIYMIo6vyNoO98Kr6BZ29NHYAnStM77gOm09tQsmgkQq5VBnpXPK0eZigGEoHjC+nFOnmQIHXdxXfpgfhp4gbvBEogTpOGlB+0fa0aO6uZhY6GRUwojICGQNgbiJKe5vE7FgYqHREUA/HSl0JzZ6zdjgqRG1iuqDtuJLll43jan3+PecVpJdR9eDUoSOGdahW8SSB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee9b26f-8a0a-4615-0bf6-08dc794c6d6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 04:13:53.9945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oz8svcmU3cY95YjGWfy8pdCjgGMPbLeE/IdCd2JAaJXUwSDS8JU8F4f5VfFEtJZNbgfhXndFtDGsYI91DK8diA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6345

On Mon, May 20, 2024 at 09:52:26PM GMT, David Sterba wrote:
> We've started to use for-loop local variables and in a few places this
> shadows a function variable. Convert a few cases reported by 'make W=3D2'=
.
> If applicable also change the style to post-increment, that's the
> preferred one.
>=20
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---

LGTM asides from a small nit below.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

>  fs/btrfs/qgroup.c  | 11 +++++------
>  fs/btrfs/volumes.c |  9 +++------
>  fs/btrfs/zoned.c   |  8 +++-----
>  3 files changed, 11 insertions(+), 17 deletions(-)
>=20
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index fc2a7ea26354..a94a5b87b042 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3216,7 +3216,6 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle =
*trans, u64 srcid,
>  			 struct btrfs_qgroup_inherit *inherit)
>  {
>  	int ret =3D 0;
> -	int i;
>  	u64 *i_qgroups;
>  	bool committing =3D false;
>  	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> @@ -3273,7 +3272,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle =
*trans, u64 srcid,
>  		i_qgroups =3D (u64 *)(inherit + 1);
>  		nums =3D inherit->num_qgroups + 2 * inherit->num_ref_copies +
>  		       2 * inherit->num_excl_copies;
> -		for (i =3D 0; i < nums; ++i) {
> +		for (int i =3D 0; i < nums; i++) {
>  			srcgroup =3D find_qgroup_rb(fs_info, *i_qgroups);
> =20
>  			/*
> @@ -3300,7 +3299,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle =
*trans, u64 srcid,
>  	 */
>  	if (inherit) {
>  		i_qgroups =3D (u64 *)(inherit + 1);
> -		for (i =3D 0; i < inherit->num_qgroups; ++i, ++i_qgroups) {
> +		for (int i =3D 0; i < inherit->num_qgroups; i++, i_qgroups++) {
>  			if (*i_qgroups =3D=3D 0)
>  				continue;
>  			ret =3D add_qgroup_relation_item(trans, objectid,
> @@ -3386,7 +3385,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle =
*trans, u64 srcid,
>  		goto unlock;
> =20
>  	i_qgroups =3D (u64 *)(inherit + 1);
> -	for (i =3D 0; i < inherit->num_qgroups; ++i) {
> +	for (int i =3D 0; i < inherit->num_qgroups; i++) {
>  		if (*i_qgroups) {
>  			ret =3D add_relation_rb(fs_info, qlist_prealloc[i], objectid,
>  					      *i_qgroups);
> @@ -3406,7 +3405,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle =
*trans, u64 srcid,
>  		++i_qgroups;
>  	}
> =20
> -	for (i =3D 0; i <  inherit->num_ref_copies; ++i, i_qgroups +=3D 2) {
> +	for (int i =3D 0; i < inherit->num_ref_copies; i++, i_qgroups +=3D 2) {
>  		struct btrfs_qgroup *src;
>  		struct btrfs_qgroup *dst;
> =20
> @@ -3427,7 +3426,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle =
*trans, u64 srcid,
>  		/* Manually tweaking numbers certainly needs a rescan */
>  		need_rescan =3D true;
>  	}
> -	for (i =3D 0; i <  inherit->num_excl_copies; ++i, i_qgroups +=3D 2) {
> +	for (int i =3D 0; i <  inherit->num_excl_copies; i++, i_qgroups +=3D 2)=
 {
                           ^
nit:                       we have double space here for no reason.
Can we just dedup it as well?

>  		struct btrfs_qgroup *src;
>  		struct btrfs_qgroup *dst;
> =20
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 7c9d68b1ba69..3f70f727dacf 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5623,8 +5623,6 @@ static struct btrfs_block_group *create_chunk(struc=
t btrfs_trans_handle *trans,
>  	u64 start =3D ctl->start;
>  	u64 type =3D ctl->type;
>  	int ret;
> -	int i;
> -	int j;
> =20
>  	map =3D btrfs_alloc_chunk_map(ctl->num_stripes, GFP_NOFS);
>  	if (!map)
> @@ -5639,8 +5637,8 @@ static struct btrfs_block_group *create_chunk(struc=
t btrfs_trans_handle *trans,
>  	map->sub_stripes =3D ctl->sub_stripes;
>  	map->num_stripes =3D ctl->num_stripes;
> =20
> -	for (i =3D 0; i < ctl->ndevs; ++i) {
> -		for (j =3D 0; j < ctl->dev_stripes; ++j) {
> +	for (int i =3D 0; i < ctl->ndevs; i++) {
> +		for (int j =3D 0; j < ctl->dev_stripes; j++) {
>  			int s =3D i * ctl->dev_stripes + j;
>  			map->stripes[s].dev =3D devices_info[i].dev;
>  			map->stripes[s].physical =3D devices_info[i].dev_offset +
> @@ -6618,7 +6616,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, =
enum btrfs_map_op op,
>  	struct btrfs_chunk_map *map;
>  	struct btrfs_io_geometry io_geom =3D { 0 };
>  	u64 map_offset;
> -	int i;
>  	int ret =3D 0;
>  	int num_copies;
>  	struct btrfs_io_context *bioc =3D NULL;
> @@ -6764,7 +6761,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, =
enum btrfs_map_op op,
>  		 * For all other non-RAID56 profiles, just copy the target
>  		 * stripe into the bioc.
>  		 */
> -		for (i =3D 0; i < io_geom.num_stripes; i++) {
> +		for (int i =3D 0; i < io_geom.num_stripes; i++) {
>  			ret =3D set_io_stripe(fs_info, logical, length,
>  					    &bioc->stripes[i], map, &io_geom);
>  			if (ret < 0)
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index dde4a0a34037..e9087264f3e3 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -87,9 +87,8 @@ static int sb_write_pointer(struct block_device *bdev, =
struct blk_zone *zones,
>  	bool empty[BTRFS_NR_SB_LOG_ZONES];
>  	bool full[BTRFS_NR_SB_LOG_ZONES];
>  	sector_t sector;
> -	int i;
> =20
> -	for (i =3D 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
> +	for (int i =3D 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
>  		ASSERT(zones[i].type !=3D BLK_ZONE_TYPE_CONVENTIONAL);
>  		empty[i] =3D (zones[i].cond =3D=3D BLK_ZONE_COND_EMPTY);
>  		full[i] =3D sb_zone_is_full(&zones[i]);
> @@ -121,9 +120,8 @@ static int sb_write_pointer(struct block_device *bdev=
, struct blk_zone *zones,
>  		struct address_space *mapping =3D bdev->bd_inode->i_mapping;
>  		struct page *page[BTRFS_NR_SB_LOG_ZONES];
>  		struct btrfs_super_block *super[BTRFS_NR_SB_LOG_ZONES];
> -		int i;
> =20
> -		for (i =3D 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
> +		for (int i =3D 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
>  			u64 zone_end =3D (zones[i].start + zones[i].capacity) << SECTOR_SHIFT=
;
>  			u64 bytenr =3D ALIGN_DOWN(zone_end, BTRFS_SUPER_INFO_SIZE) -
>  						BTRFS_SUPER_INFO_SIZE;
> @@ -144,7 +142,7 @@ static int sb_write_pointer(struct block_device *bdev=
, struct blk_zone *zones,
>  		else
>  			sector =3D zones[0].start;
> =20
> -		for (i =3D 0; i < BTRFS_NR_SB_LOG_ZONES; i++)
> +		for (int i =3D 0; i < BTRFS_NR_SB_LOG_ZONES; i++)
>  			btrfs_release_disk_super(super[i]);
>  	} else if (!full[0] && (empty[1] || full[1])) {
>  		sector =3D zones[0].wp;
> --=20
> 2.45.0
> =

