Return-Path: <linux-btrfs+bounces-5141-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 528DD8CA74D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 06:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C085A1F211D2
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 04:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8E42AE6A;
	Tue, 21 May 2024 04:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BSjHQN68";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="l5YTkwH4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD3C210E4
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 04:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716265326; cv=fail; b=O+RLEa+XUo9uimMOfIzTk8JqWqUJxvXrLmeosQtvVdc3PaRGh9NObccRJjgGofKHxrarHHopNlD4g1AkyJM/w7uXbat3TycUoEte/MPba/ZPMhQ1qW7HBse3cKSIGg+mCow4s5H/PyFlJ7zpfHhOP2iWq98KNP5LX9UDGMafMLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716265326; c=relaxed/simple;
	bh=tOLta7iE5mfcfTozTNV2o5rYPAm1eIuHE0T/D/5sT6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qwH4RGJutqBvyXiqKO+uULZ/3QarVwBus1F3/kX96oCsQrUaypwikfYIbyGamUvMOiJufCgTnah9O0+5Rq6Hd22qnScMoWPBZV106yoMvmAyaJARkpvAYD+8R4v5n3ygHCI8cN7EJpy/SDi+fWsd4jQQPflLo9rEUdGVRo+4rbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BSjHQN68; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=l5YTkwH4; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716265324; x=1747801324;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tOLta7iE5mfcfTozTNV2o5rYPAm1eIuHE0T/D/5sT6k=;
  b=BSjHQN68DOArCGSQTwpS0Kj9a3KMEfKrPv93yuZNQXLUojMjcWkyqkLa
   AvSeWeNK53BEK3ZORBpYISYs0dR16DdNyLPZzYtL6aZBnMmVvas0a/6PC
   p6oZq6EsTqGQwJ4gONSUzjr8D+9x+1DXs2KZWzu6Y9ogwruO5SwGSI/qK
   JScTJsv9BknuIZLuRfyrKGiCu4W3vknhpy4+3Bg3eEVXZE72b4KAp41A+
   kenYqDMCFuWnUYBx/ltq4uB6DeyacSFAVluyY+RjbkyKNoKW2lCEePYUh
   SvTB3MmMEZ0P3BPATsZI4Ytdj7/Gn+Hxtoio8TWU7+UKIu0hAP6UoKkyv
   Q==;
X-CSE-ConnectionGUID: Nt8Gx/ExTUKTmpMndCAaqw==
X-CSE-MsgGUID: b3KIDyewTE2n330LyKry8g==
X-IronPort-AV: E=Sophos;i="6.08,176,1712592000"; 
   d="scan'208";a="17057412"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2024 12:21:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEclM4K8uGCy7KIGvn4KvD8uXAejZQyh0Zw0fnKL8vcci45GG73fHeBKwhDl1hN15BjxLsXYyJkQOBdOYUJyfWFKTwVX1fCPBQafOdFYgd7Wg2LN/VRdXsp0uYgHIY1NS36eS3/Pcv2QqQidxGcClduaeatvs/I4CIeMkHyRANN5mGMxWtHRjY9Wht68FhEfANTwfQIa0XoCaEHr78g+YB8e4cCD+vui/p6rgnf3w9vPUrdfLinEAhylOsmBfJmi3tedxxcAhYmQJTUayhTy85yO1roEWCXGbP0wFhYwl1mwZoMaPxcVP6qCeCBUuNZ33aBK/hek8tofHPTataSdbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SO4KXun6LtbHR7todD1pVAgxyo+exE+ZLxY61p2uKHA=;
 b=ajldNTdoBiRAhvszltrofOeJYHiMhK9LvOFZQplm3LoMc/daWgXG4V8gyg2kfB8SS4LxoYS1uitg1PoXQelaDH7zHhLK0iSDwPT3VXogPaCR7W6pozHHBbdQhRhB5b7anaphGZvmY54dOOwNt9Mq8nKQgjLb/pF5kzhlwjKErIWiEhGlhIO+ACUJwMmI7krN6gA4MnvsDbzBlHZOEWSY9wWxiFjFTY6CfATQjbRhyagFOHL0tlxv/tod9SRdGNXQbDfrdQLubnjB0Js7bBodWEo7zKyhVmRGJ7js4xoCeyydrbse9rvG0iEFWv90SGaU98G/NXN8d3TE/sflB5dUuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SO4KXun6LtbHR7todD1pVAgxyo+exE+ZLxY61p2uKHA=;
 b=l5YTkwH465tF6kmhGQHHuVXV9B31NhevO2It0hyVrA3akMQY/PWgBuT+qA5JLcsBfnnyeDDznLu2XLUZVNzwYGMb8E01jYjCxHsEmh/zlsKjXvfanuS2D5EMFwuVQM/Ltzp7JD4OKSl9b2L01qfzoCykqXVRNB8szvPeAZxHoBA=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MW6PR04MB8871.namprd04.prod.outlook.com (2603:10b6:303:24c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 04:21:56 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7dd0:5b70:1ece:6b57]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7dd0:5b70:1ece:6b57%3]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 04:21:56 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: David Sterba <dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/6] Cleanups and W=2 warning fixes
Thread-Topic: [PATCH 0/6] Cleanups and W=2 warning fixes
Thread-Index: AQHaqu8/jsBvDC51s0y/T6GLRYYv47GhFvMA
Date: Tue, 21 May 2024 04:21:56 +0000
Message-ID: <pj5qmimzy2cbfomoflha7ybcttr3kduholqn65zlweim5cbavf@xc437kk2yuoa>
References: <cover.1716234472.git.dsterba@suse.com>
In-Reply-To: <cover.1716234472.git.dsterba@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|MW6PR04MB8871:EE_
x-ms-office365-filtering-correlation-id: a9903baf-5af7-4f13-19c7-08dc794d8cc4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TmG7WAFkZ1JHwFVJ0I7wMUeF4wNLrR5+SBh8Uro05dQPXlrhPyeMFlCG6Az6?=
 =?us-ascii?Q?GYL0RturFaPFGuZKvyYcataYkYrhdHVGI6zRDP55XMHoEfdczX9imBj9iinE?=
 =?us-ascii?Q?cVdF5qGqSLKtvEVsuSjW76fsFHcBcE8GZhHgCgtIZZbQgJtL9Dt1bwf/Eory?=
 =?us-ascii?Q?1Uw9SDY2zBK92RgFIbkyuRFHxiaUQVxGqvxjkjD4lOXGlcbn8baaMZCVKEJ7?=
 =?us-ascii?Q?TuVKI3J/dmjHSxMp152ew2P32zhWK4M+O3X0MaLDeSl5ZKJUf7ViBAIa0++5?=
 =?us-ascii?Q?ebNit1PSf5rqUSOWTyIRUXZcOgMTkdR54hE7el4eInCJEI5l8D7Sun23a125?=
 =?us-ascii?Q?M3Bub9dKJSnJMti4Cv9cr6Gzg6jtkz8Y7M3P+ZbFy203U4+s/czvKG+eI7oQ?=
 =?us-ascii?Q?wR2G0owOxqA5YGWaMkBqF05nYJrm9Tp+NG+tU3knromRrY2OEDJIiyS2KWud?=
 =?us-ascii?Q?Sb+/jckJo5lJ35Dsh8CazWJ6NEMYkSgdlUZ4Bqr9qrCAK7mSiHYa3PXty995?=
 =?us-ascii?Q?IVqaw0XocUTF9fQ2jGv96oaz1llhVdmQVTpRs5JRciqnEmotTk33HMpadquA?=
 =?us-ascii?Q?aAEJe9q9FDv8pGavlp11K5E24RrJo16wLb+JgoNn4/Dp9W+pTUbowjersSNx?=
 =?us-ascii?Q?O5UUZEFDn20tJqKFTt7K/OWZFtUgVONf4tmKGPWBj79htDyO3/n5qKEXfjyQ?=
 =?us-ascii?Q?gKii9ejiQZoKw6r2Gymb/orIRv0wIQZjGRVouhD2FH3fFk/zdn0NHfZx6BKs?=
 =?us-ascii?Q?4ltWaxUolozR96yKEzQUGGgiYHRyykBZeqqdnnUm+zv9KQ9+XM1fFSJPriJ8?=
 =?us-ascii?Q?D1Rgpw6zvXkvJ3bYXM2zf7dEuHAWB3NO4HNgUt7qDTE8qMxYJ1jIrHgyqLnk?=
 =?us-ascii?Q?tG6OBpj2zqEJuoyaNsPM8Y8FKxbdnBvyyi456NjJd1liY1Zs9ytcGttyfd0c?=
 =?us-ascii?Q?vlwlJ+COpUYIHlR0xwCiek/0Lx8NYD9NrAljeFquHKDV/EPi90q1OMqmyAHL?=
 =?us-ascii?Q?BLR7rPfkHbVpWGYak39MXWsTgffm43dMjF96UCLT1/SFuzuRyXZZToW2d2RA?=
 =?us-ascii?Q?V9CDBTF4WfWwW3YNW1PcySLavMhVDDAzWjj2V0cSldAJU+Nl5DtxsiMs7qmM?=
 =?us-ascii?Q?oG2hdt/IXNPe451XVV8sc0LNllm06l53/e0dBQDIjHWv9w52j5583npWi+nk?=
 =?us-ascii?Q?UbIZWCq6N67r/TCgmurG1n7dP9ZMJeiMf8q/DoS+GztW5+ToQGbdQvxrs+JB?=
 =?us-ascii?Q?1s8+uI3kLNyjI6+1QQl9XHvZaBGafw7YLjqTf2OFF2dC+SqNWJAj1Q02qDrG?=
 =?us-ascii?Q?k50NWGcOBhyDIKSNMsbM2m1M3yRw7oNDOUIoYDkxIXvCdA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?w3JWqB859kcTKq/Wl6jVjsN3u7ir35vXa4mHyFveepYL5ecbuScpc41t3tNW?=
 =?us-ascii?Q?g8LXFKax6pdJKs36wq7fc1XN3b5aq53XeJ2aCsyHge3YehUhojf75ftgqPpY?=
 =?us-ascii?Q?999H1u/znkc37iLEJ9ttS+fOReNWg5i7sk2GIV+Kg8njcrUuNjYh6dfId+iH?=
 =?us-ascii?Q?MoiM5vTESJrZK7oN+FgL7FBqm8AkjDVJCmfHEwdYB2oLnR3mvzgEE/r7SbnI?=
 =?us-ascii?Q?u7Uu8k91gGKR1NNPZL/p+73Ud1TLY0qT3MN/fwTFoDIaOWAGkaUz6EytJ2TL?=
 =?us-ascii?Q?41fymZuSb9ChGx2rsdyiR2UYxw+UmyvPM4eNPt32E+zESjt9GOTmwUh+pxZG?=
 =?us-ascii?Q?yNdGQA3JKPtFZ9EmCm/qRHyDAYdeSfXZYp6VdPfO+zChlINwc89lEwMUgWkV?=
 =?us-ascii?Q?uKk9D8Mz1yJtoaA8BTEGhtnbsVdRGeTiJG7wkpRcUzYfN0TgEKH8/NvJQKir?=
 =?us-ascii?Q?ffTxc2A2Puqhy7O2vrC1b2m5zA8tSTVJSSiQ0Il2j7jnKaIupseiLDpnQyBY?=
 =?us-ascii?Q?Gd++0jUCp/GW6/lZNqRDkEiw89yK/WDun7Fd1uGbTn0QhHffJv3KRSUehb8x?=
 =?us-ascii?Q?8miR/KaUlXYRzP8kusKnbsFJY5IMiA74eFpU8wcEgnz3jnXf5+SxvliBgmWI?=
 =?us-ascii?Q?J4weJQ+Q4cD+C2+zeH9opj1DyJJWYM3wkuB0874VFEax2wq6c4FB/DiitaEw?=
 =?us-ascii?Q?mBwMjvyzzhz2yYv8GXMSHt4xhfVXu5vLiYG4AzXhaRdio40W88k3yQ3sRT1G?=
 =?us-ascii?Q?xJjSoNq8NhZm/YZlPX86KhozpuUHck+9D5NpQdmLvA7t9tL3f9mNC6tvfYlu?=
 =?us-ascii?Q?otLgBwFNAq1NVGJYHSWyil2QYG1ijV1RVRCmSljWW3cOqfZrugIg82rCyCaL?=
 =?us-ascii?Q?WhflH5QTCwVYhw1oP6H0fMbQvAUT64+o5sYqZxRL2ugYcy2ScDge8TLrCr7z?=
 =?us-ascii?Q?IGZ1ffLsJSVih5G0Nkvh6cfln34N70mnqGchrtov21/RWpmcRRkJjKK8AT38?=
 =?us-ascii?Q?g40GY4G1poy1p3rhSwSZU3l5e7cxg8yVSdB3yr/iBgAeFGsBzGPFBP/r5E0n?=
 =?us-ascii?Q?n86alHewpxhlaXKtE9npktg7HHKIH3CnTBocw3YJEjd8mTgKWiOKar8N0V3k?=
 =?us-ascii?Q?KHY0eMobdymzfEizvrkV5rLYaqWJeoY3SsXmtqKOMs7CZ7OOCz8r5QiKNcHO?=
 =?us-ascii?Q?fMHlhQ+BeTN07EAeMJh8uwQmAevKFDv2ycMCV6WiGijkZQYoSGtDM+Ss8pY2?=
 =?us-ascii?Q?GDEk8oH0lJS3qgnpImbLaGssw2CmZLpo/4kmmqdfJqHwU5p6wyxcgx1l9PjI?=
 =?us-ascii?Q?Kg7yn+crk/vqCE4dG8wBKjYfUC9tCWHbgFyyby0inOU7oqZZSNkph8zqiFLW?=
 =?us-ascii?Q?bOAm2XsB0QFxdzY9Wi1+biXaSAO1/x+QyZcrnI6tPXl+03yUVCTOVe3tgHGi?=
 =?us-ascii?Q?Zb15I+Wh6PrkEbJmEAiSlOYOWOh2ql8e4+2fDgxuanp2o42U6F6vtXoSPQuF?=
 =?us-ascii?Q?mOD1xkFrA9zg2kGcIABAP85D+S28Df7uhjR59+Lg3A5K/JjAWxxfQhy6xBhI?=
 =?us-ascii?Q?yKNrkUm/DCYYhGACbcotdHEsLDej2/Jjpe8yNrT+YVY9CR3YivrZQi2PIngb?=
 =?us-ascii?Q?fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <699DD0D96C97E44A89E903254D5FC261@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lYdZzZk/KOpy3yOOLSl6B3VrOdvmgCzUITUbKFLhrISTbeXLzVXg9EZbWft4uahxjqfg1nANp3RZ2a0pEkgEZ1bNcGGIDFn+q3/bTeWmK+BeVj30DCldLgt1U4vdmtpbLHj++TXYg7PZ8FbLFqMOq+cH5LpcdkPc9m61m+7DCFqHavegK6glBmrkoAVYCRYKshehjnlS5sGygUwkz4YRwb5ze6V8XjfNpTa6joOndmT/LURUGzIxGt39glUboHQRE59IOdKu/uK+dJVeKfMS/WIegbfDTSBy0BFYOQAKxq1ru4fNhJ/MfUMwQvCAVW9nrsgzH3yyJZ89HPmfWJA7ZHkocaLGZBVStCOVlmZuiufH5Q/Ae8Pjy91ouMwAMDxwI2D8te0o7WsEw+Cskq6eQzeYpVJwOLZyft6qk1kwjv6h/w7x0GdZcIy/+ZDSCGujql/poUkiEc68q6Wr1NuqsTUR3GPnGyN0O+6YUw6YDZE96VlWrPjp6hs1K/KqcS5yXxZlcp2gJsYhsa/c0lcFA/J+WE/o8BpuFvIfMdDlvtuY3G85pgx8fbpsPTGXR5ASjIYPCg3TSpSOvorsGQGoGzT0v6nk9a/Cvihe2RHvu3tMWh9aK4ufndcMfUh1tC72
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9903baf-5af7-4f13-19c7-08dc794d8cc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 04:21:56.0524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3AbKh92sZbik9zjXSlNDLVu7Vi25lT5QHaHyXE1tPxlL6n4/g77Zqt8QAvWltOFPD0q25Fc0KqlnEYPEtrlK0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB8871

On Mon, May 20, 2024 at 09:52:08PM GMT, David Sterba wrote:
> We have a clean run of 'make W=3D'1 with gcc 13, there are some
> interesting warnings to fix with level 2 and even 3. We can't enable the
> warning flags by defualt due to reports from generic code.
>=20
> This short series removes shadowed variables, adds const and removes
> an unused macro. There are still some shadow variables to fix but the
> remaining cases are with 'ret' variables so I skipped it for now.
>=20
> David Sterba (6):
>   btrfs: remove duplicate name variable declarations
>   btrfs: rename macro local variables that clash with other variables
>   btrfs: use for-local variabls that shadow function variables
>   btrfs: remove unused define EXTENT_SIZE_PER_ITEM
>   btrfs: keep const whene returnin value from get_unaligned_le8()
>   btrfs: constify parameters of write_eb_member() and its users

A small nit added to patch 3 but for whole the series

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

>  fs/btrfs/accessors.h   | 12 ++++++------
>  fs/btrfs/extent_io.c   |  6 ++----
>  fs/btrfs/inode.c       |  2 --
>  fs/btrfs/qgroup.c      | 11 +++++------
>  fs/btrfs/space-info.c  |  2 --
>  fs/btrfs/subpage.c     |  8 ++++----
>  fs/btrfs/transaction.h |  6 +++---
>  fs/btrfs/volumes.c     |  9 +++------
>  fs/btrfs/zoned.c       |  8 +++-----
>  9 files changed, 26 insertions(+), 38 deletions(-)
>=20
> --=20
> 2.45.0
> =

