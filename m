Return-Path: <linux-btrfs+bounces-4340-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DF68A81CD
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 13:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2EE28766D
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 11:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1011A13C836;
	Wed, 17 Apr 2024 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KRrDVbOb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sAxXUQzA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A646A02E
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352451; cv=fail; b=umBq1i3rt5Nx2P5DLE2Cm1ADQaxoDHNgGkBEqSVvKBcALcjLfWTdjpQcGE7IHyp+yGSz+zIaZmDRderVZzo+VdXsEi/mXg9BTMYzYgmcXOEbUAC0epVEIHN0GtU/LeQwlJnmv0budGQqaoIVZbH+k1ElftJD6iP21HZcAf4xn4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352451; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qjxUYTyxT+1T+Hb1NlkkSX9vT65UtwIZ/Hg2zwmMgfxZNlTg09f3IbNSp/wMw+pe8vupy0orfhwEcdxO+VTAAqtPWYsgOScODy2nZVAfL/tDh6vYPw6lJ7lNudmSuwpSf+QFh9yrAfM7aWAooFVaeBKCaq5qtBW7/frWOEEiSec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KRrDVbOb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=sAxXUQzA; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713352449; x=1744888449;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=KRrDVbOb3oTgmIN7mm5q2gThStAxvCW3uK8fEQCSokOu2qJ9Auq46/KO
   Wgz7vwTjD+SAKx8nLUeytn3r490K8n0DO6lJyO/YRJW6ayvtI9UWVlRkP
   cgUOT7WMeD0kHJvn4H4uaQqLwF/OBhaR7fTdd216QsIIy+xSmoS5Fa3WV
   v7GTnCf03Y9is+yRiFMNGZhPNLGKx9GD4f3Pqy/hFV9jZUfdcK5uWHAoA
   ZGtaSc40e6BYdfwfBQIzfClF/nlACRQw+f+6gDnyfMSQvTQvINbkkobcS
   /VQfE2Nm1UVJSPvPf/VppNl1wh95RE8jytAcVckDy5RiAEdE9zjq8qrCv
   A==;
X-CSE-ConnectionGUID: To4d8mXAROG6zvAcP6uQGQ==
X-CSE-MsgGUID: qSjL7mzoTXWaDFFOI8/DFQ==
X-IronPort-AV: E=Sophos;i="6.07,209,1708358400"; 
   d="scan'208";a="14916172"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 19:14:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGfbDEuXX3SXHMJGM8znB/iOe5SH+x0+EikYVggc9V8rFgQ4ZFe+7Df3thmtGVUlJaJ+zic8efL9VYBU3Myu5ajAGBH0OJ1n6HlfmoWndPaYRu44NyW+jeE3UAiJw/LsN9QvFS93JTdgUcMqYJO9h72BHT/f9LWrQiIyWRyhio41/+ljjmUxN1jJYhbGcbXaVkyWuwp96xaQY88xneUDbp0NPAJJ1D+D+UtoFKbCDSzPvm7gJkpCPuYUAGLgFyJMEoL75fokeqBjcTO0WbjGA2QCMwEp0GGNAu6F7Z3mjpgUDx5tNHSVjSqqwine89JACiZ39K3g+F3eah5AQjEFVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=QHUW+rlTjoQQ8As7B0uK/M52Dd8JhdkDcB1WvOIUCiaUCtJ5iwNqHvpjteJ1fsFxspDCQq6NCAgDGkqQ0R+0AyEGnUKDK23hy5e5GQHqM6BRFtb3QlPXgujxw0le8oD/cLZ4AjK8EUuSe0aRxahLB1UwlHMP/jAdCfT5Wy+LFnJ65dyRKyWMzMALsU/lhviYPsTh7Gjv7YxlfagrnkOeIG1UaJSde9+XcQbNDwNXeb60zCPqT3iPClmxkkq/KJL4DBkGrFXYfRHjuaGlFtbBtro86UptjzEOJaDzg+s4kqtldrP6PJ97XWHT/rjvIqUAK8tOw44aN2JdAFHr1/VFdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=sAxXUQzART+q6K3jxZpkeLOmhNVwYNrnDbJ5wovntVWXjsKAP3e4Km8jvYK3NabduT9I2byBT9uSc0EyyXpqUv9xFF97ZemGVsiwFRoaIPNUDwb9JXrG58wP/0B45Ln/Ar7vigeERVQm3/vzEasObhEpza68PR2myaBWOM14mxY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8453.namprd04.prod.outlook.com (2603:10b6:510:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 11:14:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 11:14:06 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 07/10] btrfs: add a global per cpu counter to track
 number of used extent maps
Thread-Topic: [PATCH v3 07/10] btrfs: add a global per cpu counter to track
 number of used extent maps
Thread-Index: AQHaj/85Sr1Puurc0kmt/WJ/rk1Pp7FsULoA
Date: Wed, 17 Apr 2024 11:14:06 +0000
Message-ID: <97c84148-d6d6-4f51-97cc-6142248f7bcb@wdc.com>
References: <cover.1713267925.git.fdmanana@suse.com>
 <5148d35a4b3dac4e02f963e59f2154c56edaae29.1713267925.git.fdmanana@suse.com>
In-Reply-To:
 <5148d35a4b3dac4e02f963e59f2154c56edaae29.1713267925.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8453:EE_
x-ms-office365-filtering-correlation-id: 2ceedc29-a845-4b05-c5ff-08dc5ecf7f5c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oqrd1+JFt3eXcCicFeWUQLUBAo8QUTwCj/rp/wvt48jr2cnxU1dHl75ImSuOGzB3rxkAsMUwMqA9Wpy0akjy8RPIN9/u/FKnwHSGuCVGsQ9Nj02VaChKuUjf8Q3r5GGfVJnOFzVFZyGQdPh9hqlrHtetL7RDbqXyEHIJ5wr4elfeY4WBKrF8QyUJMi9nCZPYGMShMKHYhUXTJMznEoMziznhrwH+UyonmL7RRZk7ObM8MlH9h/tHtijYhCrWelB7CIZusX5Tm0xoQsRnSp+qy+IACdcex8CaZa0Cz4uOzaXqeA3tB3DlAphp2bZTB0SkN3HdMJXsnZem3OFr+AKXGv0SXtVSvE7TLGDeTI/rGW1lG8fZ5pSLvsGbzeHq2CrKAVcTLMLucvlcA6gV8dir2dvSaJkil/ZzWmpWKXBCuAfL9uTgoTGZrwrqA0y9xtmaYzqP3IRneGA64cZE5muSWjp6lK89Id3ydShMyRN7FmzAu11Gb91jGcl+KQUT3cdXzZ2qKF1GVfFyQJdRqou0mpKrzZwu/TzvmStevIaU28TbpRe8cUWkPXPz0AJIIzcxY+Oj8WCbWdBTQA4N9yIcUwKYEMxeUdaYFu2+CQvHcQS6dizKs+1CIpMYJ+W9B6H5/Yt/VU4kI5xboeiGsb/ZbJ59r2zL8xzt0AeSBj05HHQ6C2+4V9KuGyPOv/a11riAVqPhFbo/mpO2KPtgw3OzOTnE38PdSFI5gf7HS/byklM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWUrLzEzODJLVCtjNkhSZ0VSd2FRdFkycU1qUGJJZ0tLdnJ3MTI1L2o5bHo2?=
 =?utf-8?B?YWxlbkJ4US9LRkgrS3JuQWRPRVFMZjhLclFsSXYydDRsNTh6U0ZDbXV5Sk9q?=
 =?utf-8?B?L3lzbWhMbHBtNjhjQk1NUktYQ2VSMUp1VUVEU0dLQTRYZkE2V3F4bmxrYzJp?=
 =?utf-8?B?aHZWWHhncGhmWGlIOHhvVXZqMWNpVHkrMUpQNHkvL1F3dmhNY3JwMmhtWkZO?=
 =?utf-8?B?S1Uzb0tvYmNwbUR1Wmt2V0hndlZCdU9Fa21GaDc5RHROK0pObkdQQ3lpcEFW?=
 =?utf-8?B?bUx6WUsvU1ZJdzJ6SDBjQ1RybHZ6M3ZDSG9vaG9ycWNvS3IvYk9HWEhyY0Fl?=
 =?utf-8?B?UEp5ZHVGbkpKdW1qaGlHWkpzWE5CQU1CVUtwMThmQW03U2ZQRjNZMTRQb3Qx?=
 =?utf-8?B?c2JNWnJ3SDVnOHdTS3FleXE1WlUxVnA4eG5aeklKQjlLVkVSbDJyV1ZQSXhy?=
 =?utf-8?B?emZORzRhWUMxYnVQUi9lUDFGQ1BJVzZHYXg4N3NEWlc4TzlDdlVuWDNhdS9Q?=
 =?utf-8?B?OUp1TzNSSzY3WlFDMHordGh6Qmk0Q0JibTRsUmN2bEQxdHdGR1B3b2FpOE01?=
 =?utf-8?B?R2w5bkJGaThaQ3RhaGk5VERKZ0xJRGNJRHQ1SmJ0YWlVUkFiQjdNWWRMa2l0?=
 =?utf-8?B?UWticmEreVBLRnlSbnNhTmc2a3NJTnJ1K3plb2gwQkhmTWZJWEt6UU5XTFc2?=
 =?utf-8?B?K0J0bXRFMW9sclcxdVhVVmxCWnc0ZnA2Qm40Z1hoNTJiSllIbW5SWWVWdkor?=
 =?utf-8?B?Q2NZc1FaUkM1bS9rVGROOWxQbXlsOWpaOEFpbGpMVGtlSEMxME9LNWU2amlR?=
 =?utf-8?B?S0JISVJQd2FWdVRJM1cvck1OSEh5aDM1akRuK0creXZmeFlIQWxYNmk3bUpQ?=
 =?utf-8?B?Wm1pMXh0dERRWXhXT1VsejVmTnpjaW1hY2IyNDJRT1lDTnlPS0xCak44RC8z?=
 =?utf-8?B?anBoRFB5VzZBQXd4V2h2aVBVYkpweC9CWlNtMVhmNlhDblAzTnBlNzdVenRT?=
 =?utf-8?B?MGpJelMzemFFQkhpMDczWWUwbGppUjZJbWQra21oTGdHQlVkZUpneWpBM1dq?=
 =?utf-8?B?T1JVbmVHZjRBdzA3ekxyMk9HbjZCRXI0VklRaENZcDhWZHRLUlZObEVwWkRV?=
 =?utf-8?B?M3crTzNFVmxCUTByVURqRHBoRlVkdTNqS29TOFhZcnFzUUFBald6KzRRUUw2?=
 =?utf-8?B?dkpnbWVZekFhZVUyWjFPSUxwMXlKUjdId3lwM2d3NURLTWQxV05BVEN6eThC?=
 =?utf-8?B?UFZ0ek9QWjhDY3JmclYzQ2JBV0FwTTRmS2RKd2hLd1F2dGk3Mm5meWFOUERh?=
 =?utf-8?B?TjRGYXFjaWdKeGZ4NStGanBTNXEwSTFab2pYSkIrK2h5UVJneUcvUkpoZC9D?=
 =?utf-8?B?MEZXbnBDZ3lQV0gzcFZMTGR6b1B0OUY1TEZSTk9LNTRzM1p2S1lES2xiU2gw?=
 =?utf-8?B?U0tPbW5NYUdOS3RiUGFzdE1DZ042eDZrU0kyMmZodWZuZUJ6R1c3bllJdGlj?=
 =?utf-8?B?YTVaN0twUzZwZmZKckxvTlRmVWRodWEvdnZUd1pIL25jc28yc0xJTmRhUWNI?=
 =?utf-8?B?eCtDQVI2SWJDKzd5UVROSFJCU0c4Q1lVZE5kUjRjRHBKYmdhNlc1cHE2N3ZX?=
 =?utf-8?B?dGVqbUE4eXhWdFdObEgvMGs0Y0ljNHJQN1dhVTJWWHRNWjJZYjdFdW53Y1hU?=
 =?utf-8?B?a0xWejJtSFRrUms2d2lJRmdEMzAyZE5SdXozVGNDL3ZWSDJSc3g3L3p6UDFx?=
 =?utf-8?B?dUUrdFZBMWg0TVpQelk5VXZkYmUvZVA1RWliM2FyTmNSWXBJV3h0MGtiRWpx?=
 =?utf-8?B?WXhwbnVDZDM5VExnTFZMSlRTTVNnMmlBRWRSaGI2dTg5RXhiU3puSE96cXo2?=
 =?utf-8?B?Z1NndjRjV3dKODdWWVdtQXBFTHRBVG9TMXE5cHZmLzBtek1GNllRaEJXdzY3?=
 =?utf-8?B?NXNxZXMvSEhWTjlyQWtBK2tHSWczdk1ZUzU5dUVhdjhNbGw0UXltbzNmM2Jq?=
 =?utf-8?B?NDd0TmVlaGdzM2JteFNRQ1ZuZVQreldIVXkwOEJwYXpGSXJhNzMwckJKZm1B?=
 =?utf-8?B?bWREaEhyMmZLK1NNaFUzSnNhb1ZUWEFNRWM3eWQ1NC9qS01wYXo1NGllM2N2?=
 =?utf-8?B?TE4zVU9EZ1VkcnZsd1RUOTlLOEZzWXlacXhBbkFtY0FZWUNYR3RzQWRwMXVq?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <592E27AC9B6D2D4DA0445E73BFA22860@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cdzsfUacUoip60acpo0s4UTCASALh3XLjGfzQrZMnp+v3V6ik+ZCSMs7Q+Ipo7Zg60lPtw80rbLMX2e6F7va7SNexvHCnbR0QhXoEHLDbhk2oLjVhvPd0RI32cL6QKoWSpQV6DcztRPpgavAZeG+S45B3eR353y+k1TOfcu+Y98pxp3/T1zCRXWZD17n7NTYGM0wXM8VAU/UMIoO5OxWnbwDgVTuhut4IbwDAGG7VTL6oHhWIZvu475T29qCYosaNmTz0UZM4XoolWpZKrPwXe+aD02HyJP1qWcOtQRK//sRstOq5FAyeDwQTg8juv4MWsLeTzW35RCPqTUf2ohJzJ4jfiq5C9gnnl39Ck5gIOZUYm0FsziD1owQaCOaSA6s07oHGJyf76GUvSkQhg75uZX9nkWgiK8mw0L+7TdmVILlh+z/fMLGO/rAjjrgKI3aJLoVDpQ/8xnNisLjKKJgQlvfaENvOgyLZchszqQk7VuBSD1t3q7dMDbB/n8CPKy8mjhd2RyQir8IJ/ghZPNqgO3QLhh37jZj4xjXKPJP8jKmMvoNpRkMHLtTf3LI5xS/i0wc9Xinues1JtQn5STGsNXAz0eJ49XIPO9Go7LnaWuHpjCHBsLkahlCYIqLpr4F
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ceedc29-a845-4b05-c5ff-08dc5ecf7f5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 11:14:06.7338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 17Ux5sF6zxRL+UWjFFyruaqk+kv/E1LqMsxwMPqMGQg/Re5+4Tv9GWRwHV7va0EOT9+BLWme0qQg+c8uHFE0rhZUBL5i/d07eZwTTFMyWgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8453

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=

