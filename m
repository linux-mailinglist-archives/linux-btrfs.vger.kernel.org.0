Return-Path: <linux-btrfs+bounces-9330-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3506D9BC531
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 07:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595261C20B75
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 06:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6DD1BC077;
	Tue,  5 Nov 2024 06:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k9wiyb9O";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ttBbPem7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B3C1C2324;
	Tue,  5 Nov 2024 06:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786474; cv=fail; b=FbMZz8Dzoj6OwNnrC8SsLf8kPlrVDF0B4SNMFNMoXEsAUIHayCYPg+YtjBKa6QU0x33v+CYOPBPhQaAwBRnsDPzE3LzfUERrxXQ3Bt/vvXt2gfAZ4bL4mCDKqQjuwlUZImmuR8RJPIfdP7U9ZE8aWar3QMATg2gEZ8mg42DgElA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786474; c=relaxed/simple;
	bh=ruMTCP9utBgj09MJfkaUYv/Ci06Ky8u64OlelW6wiEg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qVHmaho9JsF/yQBMofmaUYal9/F1tO9H1DnEu3AQS85hYU4X7tpjAGud+9Djw5tenVcgw0P3CoHHcn/4hITd9O4iDH48E62rzZFlnl3docQXg/HlrAC1SDs669p6fzF5SL7CemaFBikv7hDoK5f0YBwVZoYI4diR/2WnTGUJmhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=k9wiyb9O; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ttBbPem7; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730786472; x=1762322472;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ruMTCP9utBgj09MJfkaUYv/Ci06Ky8u64OlelW6wiEg=;
  b=k9wiyb9OMXtN4BAXn2BPaLj37CgaQMrfI7rHD/HBrREl4zq7QXTJtKy0
   xI0wqXpHM3GpWr0Py+CBdL9y8SGY9Tu5DnuNRxNlcJLH36oHBE0oDX7S7
   xHoVtf+IDMCAl+sfRRDD7IPFCuWklO37VJoJUnU82gc3YzNfTVSbglqXN
   tmfEu9/27SIfA6S0sb3E2kVS4iHgM+tQG4ptFWlG8x+reMsTf0vpm7OC2
   mxExK0dn3M2gOk4gU0KIte4mwBuIITqUCJ9wJwZ7iRCk9yy1DKMTFtTui
   WlUxLJWUhylcq+PhZCM/ix6S0noo/0AaTpnxrNGolEj/ZAhi3V4rLQE8j
   A==;
X-CSE-ConnectionGUID: tza2Nu3gTfe4tsF9C3Iz8Q==
X-CSE-MsgGUID: PRLsX4waSTqpVXP/Lqs4mg==
X-IronPort-AV: E=Sophos;i="6.11,259,1725292800"; 
   d="scan'208";a="30045417"
Received: from mail-westusazlp17012039.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([40.93.1.39])
  by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2024 14:00:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxM09yMypD7ABLpJ8+9UaLSLn60MheNTcHBh5GgzChHei1YjmPcwlwwdXWUABLa+x61WoGuTUbFhHqXqoSMJ9DRnZmCmUx13BYOd7reqOns9VHgQYbv7f6rJkYSK23xpgkc5qK0O8ARX0O2kf8HeSo7QDwaMZobR2YX3nxOCB4LNn0+1vUm7SJx9VV47SSmrQpzF9gcL4+S8WLCWas+FTF89posEC4OCLNiDt9QX/7OJj74/0wERIvBv3Nk0aWWZ3dfXLkIQtGygrOgOLuBa1tD0n7FOSw+8CtJaNfQ8B4E+cIvLIkBdn9xhblGFb8P/RQWP9CwrOPf3IWanoDfb1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvlrStArZeCe2oE6OCLDU/kgYfB6TrOpFfpabpGQMRA=;
 b=PywFPdvcE2ftUU2KUtvQOlKSZFWNgkGCl/+JNRdCrZze8ECcpYANgGb3KyQUCdIPY1PjzJMLG9s0yl0JzTIBPKHbmBeH5AuzMRMsQSVBdfoN/jDHE/hEl7PiHqn9X6Rkc7xPw1OexUv0Xt6YhdVnWQhGT506tsq+T/gNwmW9P89KaB4hnFsPq8ysZe76rjPLuvA+NfPpQx2Ki8AepLpC2kgBJmZWF576QjzHmY/Tha/AnFy1HoDnmCBaLqTpSK9xykEcEU6miZSGilNygxO7t7xQF+zxitNXFwHpwuQoWyN/tr/NHWfdsrX98rTwadvAoRQnRquBC9OargqE/EruEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvlrStArZeCe2oE6OCLDU/kgYfB6TrOpFfpabpGQMRA=;
 b=ttBbPem7QPLeUpetfksbn3v8iumVH5TJM21YjQVOWjfx/kZd8+Q/qx59Q7hHqGEGZuqiPcczSXUt+KPEzF4FId+p2TLIxE0ymJZFRm1ihHGzDaLs6bLcaqxoekAFiL2ySxsZ36ahBLUfMYQd3ZD17KwixEo1uxRm+MiYnodBo20=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by LV3PR04MB9489.namprd04.prod.outlook.com (2603:10b6:408:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 06:00:00 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%5]) with mapi id 15.20.8114.015; Tue, 5 Nov 2024
 06:00:00 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: hch <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Damien Le Moal
	<Damien.LeMoal@wdc.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/4] btrfs: split bios to the fs sector size boundary
Thread-Topic: [PATCH 4/4] btrfs: split bios to the fs sector size boundary
Thread-Index: AQHbLB4XUCGvrzdc5UGS4E2akpDrlrKoN5MA
Date: Tue, 5 Nov 2024 06:00:00 +0000
Message-ID: <trjfltvagx7ycbjxi4kbwspzeei5nitubbi7wuvkcceag7iy6c@je5yxz25i6nd>
References: <20241101052206.437530-1-hch@lst.de>
 <20241101052206.437530-5-hch@lst.de>
In-Reply-To: <20241101052206.437530-5-hch@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|LV3PR04MB9489:EE_
x-ms-office365-filtering-correlation-id: e946a881-ad83-41dc-47e4-08dcfd5f1591
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lvovj3ZfS2TI4ZGk6vaoy2qZEjGNvA9Dj1tYddph30I/FzzWyLzklP/2udak?=
 =?us-ascii?Q?ixOfZW5Dv+1pNoiovzZAx6mCwD3UE+p7MLpYbmbAW0hYyfGPRzX2kXp3ieDU?=
 =?us-ascii?Q?jQU0mlJcFUhqA38CH5B5fdm+vyju4m7uPTCjHJtX/MrIXlD605ANlHlw8DJD?=
 =?us-ascii?Q?PHKWuDunFBD8r62vEiwYtzezToR8Xs2/hozsjfoNDH76t8+FG+/ylSjK/VxQ?=
 =?us-ascii?Q?GpGSVadYO7KQvun3bIzCvdug3vA0DVYEyKJwPuSYx0QBHGw1JZADnID+JbcO?=
 =?us-ascii?Q?+hQ3CoAgqRlse5Xq+Jss0WDHrOsRy0EFlz4aPtnef0sq0+CJ4tasZxMX4xTU?=
 =?us-ascii?Q?GlF5HiD/Ba3+xyCrgQLWnpBxLRjkmFJBRhgt4j2stLonR2o6Rh5sw5yN1urp?=
 =?us-ascii?Q?dUOKfG7nPPqY68IZZJCvOBjgXpI2Q7xtmBf1d9vdnkcaGePTLobrX439yHd9?=
 =?us-ascii?Q?EWgYmcZKMDvYclbznCOpXVU/kILYrlP7c62Z/LYSo3ZvSdizUkGQ+fNWKUta?=
 =?us-ascii?Q?FBIr5iUlnYsrVnNE20UYw57dVe4oXCjmkYzkdCQ6Yyo3NW6tp/KjMkAfq4PU?=
 =?us-ascii?Q?5MR52qUmg5XQvz1BgWhgk/uX64J+NMG4ZCg9KXhD/VyYAOdbDjroiSbOC/KN?=
 =?us-ascii?Q?XLITXyvbbZgf740HaFsMVdaT4vEc/0SKk+YfwbN/p+4yOcZ18LVBm/yoe+sV?=
 =?us-ascii?Q?J/EBfyxXuqnAIBZ8cNz0KxuBOcf3C7nb8cGVqsEceOXZ7R1e/vr4Af2HUL8I?=
 =?us-ascii?Q?L3lplODVH81h0ZRUcaXKyrpHdRfB0E9hkYJnr18bF9TDWmOFV9dpRfVvcxSZ?=
 =?us-ascii?Q?Vqnb6XSByIYD3aAhNTyO1EBsux8/gi76Q9fNC/cWt8oh2gxHDNZXY3yUEfDO?=
 =?us-ascii?Q?2hOx/KeWXgOWfxUWSbSPz0FlnKzHhXJaBuVh7sMjERJd6W+L2uJaMwEMHXQV?=
 =?us-ascii?Q?pg+xAG2QHJPtbb8WyUgA0QNiJdWcYrWej8VW7+4IrRJLN3I9GRPQg/sKsYPH?=
 =?us-ascii?Q?myy+As1bgQ/xxjaBcHwHRR3v7J8/wUVGFWMzCA4cAJsqyDrjxtffcgah62gH?=
 =?us-ascii?Q?Dfc69OPCCoIobKufXE1hN08ewgetPS9YsyPHYmfh5/hNX7JPhg7lWUJNIAyV?=
 =?us-ascii?Q?3DJZUxpxfHhEP+iMC5ThETfw1aQmHXMeVLiffMj8aj29sSMJRFQrC8VdIfM8?=
 =?us-ascii?Q?R41N4yFzN0Ci7WNDXPmKOv6bx99pXbfBHr6BUstbvywhnM++RM+AQzNAXJlf?=
 =?us-ascii?Q?woFlNDPbwkrHBnXb99FMrWH/l1r+v9gcK6m//5rnTShM5aexXl+hxcfSop9v?=
 =?us-ascii?Q?NXWTvQoWYmvvGAj+90iUVkAtFGTniqhML35/wjMqonxVCFq6nixJduA1gqRZ?=
 =?us-ascii?Q?oMmUEzQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vXW1B/896yGrXNr09Qu6Jo/dp5s8dvZmLZdC3fNAZdRne/IgkVmI+YZX/A8n?=
 =?us-ascii?Q?lUcj+w63FlL7bzs9KgvdALnclXQ4pOrB2PRjHuI6lT/jeWvRtE4zvsJL9jWH?=
 =?us-ascii?Q?4Dl4KoYiB6IXlgMwieMNrJGugoXJmRVeDjYexckgRlAs8rE+S0kFvwPVjmQH?=
 =?us-ascii?Q?cfuiOBjg/gVOkrWWU6LakQQrh0atDNFyZm1ufK4401dSo4mwAgIUHdkPEdp6?=
 =?us-ascii?Q?QrHvSmylyjtUn1Cr4dr3vCvoZdYL5mFa9UeY1lR5PRzlzFw1ZdGKgHokr2jk?=
 =?us-ascii?Q?rTjMmnvA+phXeBqZgg5zeBucN7hHie5XKlflRF2fJZp70pXMzdWKev0AUMAv?=
 =?us-ascii?Q?juUgxNSZ9bz9uEhbytBiB0XaN6eIxwkAwkx1WKxIXC43l6Xh8uYRa6PbPx0I?=
 =?us-ascii?Q?P/aJ5lo7bhJXdWguS5vMR6cmkCnhNzmAW/NLyA33MXjvvDDnKjyZbnyWJJK3?=
 =?us-ascii?Q?S2KQNTh3iEdfke4tGHmB+EkFvvuzomvToJhjeM9mQFHYl9FRWd4EFeYP2TpT?=
 =?us-ascii?Q?pazSL8gGRX1kF3uqWmcxwfkCFOBny5zO3Ek7QwiuSzl1BQ46LvcoVkQ9PpZ3?=
 =?us-ascii?Q?A46r+wlpcpZKta/fTWvz+4akRKQCoiKlP0f/s8udmW0ZRnHH1nfx8tQKunZP?=
 =?us-ascii?Q?8zEu1hkhr4mutKh7f0U7XkfUB2Pm7KMFONl2wocJWA8BxhYvuNpf1YxiSNEN?=
 =?us-ascii?Q?EPX6uNc19n4O7RBXDeL899C2Ro71YeZLcPGWwTlgys4xtrREODzOvu0iCPDT?=
 =?us-ascii?Q?Mp9RzaZEjol/GW94R/I+VxTpGjyKFU64V3c2GEKZ1zmftmNqNytbKlSVg9Yz?=
 =?us-ascii?Q?gVWOWlhYn45UT/OBZpJ9T7bnUFX5dJeSAkz5o047C4Py9x6QH+I+ovIcKQg3?=
 =?us-ascii?Q?TLYFu196uM11MVxoN9mqOd8p7lP+Zl/O8E42TOLSqsK0I6WClq6uYdckS9sA?=
 =?us-ascii?Q?idmlGt0RAmQiICBhsHPOqhZgoUCjFcSDvO/1Mw4s1ISWXnC/CUKWVvo6n1xC?=
 =?us-ascii?Q?Nx56xvs9ZadBkYTOks2xl3TE5Sbz5gLE63Wf561OlIJF7vRMkCcvFispXmaX?=
 =?us-ascii?Q?7Qt+RSp/R4SBGWK9H5mHdl6WOZNGpiHksXLEPqTRWOXPY5Cwdfpgf7yKp9ri?=
 =?us-ascii?Q?g2fQ6xDiJqPcOSPzycCUu65x13w86+lO3GWafrNsSHK/fcQiqwIpDDrD9GSp?=
 =?us-ascii?Q?RjwucqFM12+Rh5XDAuIXkaAnVcvVYZmJVpT+vf8LS8C2Ov9mbphygvYCV8S7?=
 =?us-ascii?Q?omrdZAkLeABEOdYHCFn2v+71kSC01uPVHzIZ5nPZqnXx9BxqsQuIwo4aBfzi?=
 =?us-ascii?Q?yaZVPUsrwPHW8vglfwAHkf71kfSR/Vpa6FWMD1JeccMmCg/X3R4Bmg6cZnMv?=
 =?us-ascii?Q?/3gYclsVpung2EEn0skZCYqq1/7m0wciyKrdELTnvBZchPugENvSkQDMKRT4?=
 =?us-ascii?Q?8tPQWWs+VcEStmrpg1tLLxC4isHjs9WjyAZoTEY672HY8g99c7fJTKGJzo4z?=
 =?us-ascii?Q?RJMAz2FFmPtbcs9EDnOpCNbdp+CRbuHpMJZucZ+37Zehv4ykGf70cYOyQ2hz?=
 =?us-ascii?Q?sCdZxsmXKuAryCdru2R3mOYzeBQeeus4KmIVGvzY4SP6+Qb/Ux4A+lzz/kcQ?=
 =?us-ascii?Q?sQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18202D646E10F44CBD63386AF20B9DEF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ditTIkk6LkUpMZb7tKh2/FQrX4vjPwjrgbqyy0dGruL1qUlSV/Beo4lzBWjxA4j92lyV4ZBxX52Axj/PXTYuEvJW8bs5hFs6fT3565ijUSHHbuMR1mph00vPcLlPX/p9LxQe3GIS/WWsGnrrt+8w4qW/L80iewxtCGUCUkAyvWpXycGc92CdU9kaGXwWwRGiPpuuUeonWweb4txjWWas3DKRssntW4HZUKCtMbSpmrUX8iuAiMtlNqVrL1u6WW8qH1WIZ7FmR7j4nRgX4IfI6v9uMtT3jpqXX9NlldRpTDwED+ukpRz1kFnRJ5IvGH4D0GkNixs+YBAJskTr9lMjoZuLH9XMi9KOA4b7xa3L1bqFJtUiWefshKVLxp78uByIuPmkFiD/VojMqtCN8h5EZgmak7O6AsdktYaTL5ngeXvPRcjaY6Qv19TFvuVv2sQ3b/KnGGVT8kP/aBuOUcCyx2NIMJwU/IPuhg7uxjyslPoOYLlCroxfZbt2WdpNLYmOTvPlsD2vQ+Fs2EILx+tYFO4nr50OXQMpmLM6USoarJNne8lEwDNZ6HFp565I+hq1pjvj56tcoxehanrhUP7cU9WmNiXiiojuYHbePoI+6vmzNziZEDTqxtLikKEcxenT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e946a881-ad83-41dc-47e4-08dcfd5f1591
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 06:00:00.4708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 34AUtyPDDvdclLSlKdCBJ5ja6TTbNgJUDNkUpX9MvQMprxhsocxSJP7KJaRXaYikw8J/NbQUcDnUQGOB6POb5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9489

On Fri, Nov 01, 2024 at 06:21:47AM GMT, Christoph Hellwig wrote:
> Btrfs like other file systems can't really deal with I/O not aligned to
> it's internal block size (which strangely is called sector size in
> btrfs), but the block layer split helper doesn't even know about that.
>=20
> Round down the split boundary so that all I/Os are aligned.
>=20
> Fixes: d5e4377d5051 ("btrfs: split zone append bios in btrfs_submit_bio")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/bio.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Looks good to me.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=

