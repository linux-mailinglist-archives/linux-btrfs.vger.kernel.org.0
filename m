Return-Path: <linux-btrfs+bounces-18028-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6552BEF9D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 09:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B63618883DC
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 07:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4572A2E8B78;
	Mon, 20 Oct 2025 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mCgz3Hs2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="X+OTAUX4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E272E7BA5
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944279; cv=fail; b=CprxrXfOgDhAFiaMnoQcQHpbb2wtrvcHZ+INyxKf6M04i99wx+iWzCXEsEST6+S1KagealeudYpdain2yVLuNLh08C8fsq+zAx6CTkUtGf5fYRnBIw2g+KTqtjAXOkovW5T3WjfxjUopEAlnAZjOhAbXu1cdsz7BbEkLXOkfPpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944279; c=relaxed/simple;
	bh=nv+IGVo/ZiUFnaoUs2tqe+E6M+rDPixItOkI5vxeHz4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LlljtaijrXTj2y0HQECCuu07o1F4dwt0dpV3nsPuhF1JME+ocEAw8lH2OreSVgabAcIzDNdBbrm1pquRyxvz9ef3nKY5cqlWmM9z8h5FYekfOQkq3iI0GAvu1H6ykPJ3TupiD6CdW0u5lpwRqcGBFnP3mn2sl60ToJLS7NI7aro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mCgz3Hs2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=X+OTAUX4; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760944277; x=1792480277;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=nv+IGVo/ZiUFnaoUs2tqe+E6M+rDPixItOkI5vxeHz4=;
  b=mCgz3Hs2AhEefvBBPpqbTTzUjvl6K20WAfkTFmAH01urdbf3CuLZ+9jU
   yDAScueeg0WVpr12mYDySUu1AI7EUC5Hyu/0eqMDDJcOzgfNvEZoMVw13
   L0ly7XL0sSZAIIjKWzqwuIhIA1wlhKLqEQrU4TNUl2pGOzAShwA0y0i0I
   1JbiJJzXCSeIYxiYIFIb1N7p5F562WumliWvpe1MKovoZEa72KagxPiS7
   ch7ocu8J4PGqsoA3f1AKNudpfJcrv8jr9Z/QJppu1ozbY9L2ngjFplb3G
   C/uQH28zXD2CTvYPTmzmuXWWmtL/QJdzmwFiiQh77PWeYgzaY4kkZP+Qs
   A==;
X-CSE-ConnectionGUID: d5WXgKqhRM+YxSdOujS2XA==
X-CSE-MsgGUID: pbipyi8zQDme0FCj9dSvXg==
X-IronPort-AV: E=Sophos;i="6.19,242,1754928000"; 
   d="scan'208";a="133224207"
Received: from mail-westus3azon11010053.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.53])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2025 15:11:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjajQVoEdnHVkrlH0zL/m5Mb9F4cjFReQFHjRPVSbHMF2QgylCcEKgURg7toOLzpWjPWBM/uyc7UZEMO9HR+oqI3xgPNckEH1JT7KpynyWtkSq96hJPj2LeG85+o1iqSmXAb6/l9KTvz92uVemIPOcSCHUhslc6Ahy8ByJpHzzD3Q0+UuFhoYrm+v21cZzX+m6pEUAVerhwRENfkn3g6MW7IXDybET/nAeNLmkIv91c58gut+AxkgvbMIAKM05WWUcab2Fa7XmMApRp0zDUqEo5Cg0/lma3xMMlJy+mP6S+CI/J7wY1iN3K/irRAM8wdOZn+Fe1VJLvdraUoVq90bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nv+IGVo/ZiUFnaoUs2tqe+E6M+rDPixItOkI5vxeHz4=;
 b=BDji2yKRfSOYYibe/ooAYJOzf5Us6zW+ci8MIhLp9JqTrSoI8rYotIxcn5OOgTYNY6Rhae2Gam/i0sJBTiLb+sgqNQK7E95m0Fo2H/B9KqPwR8wNsOWRVhJsJH1WlSgw/Vsi5iPplUCyVpQu/fwAedh2Ll0mrdyaNxGGmbhEIWHlALhBmiEqEli+i+4Q7lIu0P5STUO2ZXZjsMWb25imiTAIDxwm5Z1wzWc6WETYt6aHzGOff+F0PbSTdvLI1ccWb/wmHiJrr6qhWzxaMJOS996u+OS575oKnukHfwNQwO5zAbcn/1N+nlQTBqBavbOyZ/XoEwwVFN8TwfpvkZlO9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nv+IGVo/ZiUFnaoUs2tqe+E6M+rDPixItOkI5vxeHz4=;
 b=X+OTAUX4lKImPs60mUJW3RoqtPXQ9rWnd2XWNqWJw+cQroslbFwiUVpyYKA4UyGNvlCFcq/0BSspIyC33emdw8TRqwrwagXRual97W/oLgSHX8vFcvZXyo7GhBRubHYC5v11J0yL42jb8LgJU5nkI4zNTtidQ7jIlyPR62JObKs=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by MN2PR04MB6975.namprd04.prod.outlook.com (2603:10b6:208:1e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 07:11:09 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 07:11:09 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: get rid of btrfs_dio_private
Thread-Topic: [PATCH] btrfs: get rid of btrfs_dio_private
Thread-Index: AQHcQYaLtLzaQh9HCkuQbro+XksRjbTKnlwA
Date: Mon, 20 Oct 2025 07:11:09 +0000
Message-ID: <d5b9e358-cb02-4f8f-b669-770a2014319b@wdc.com>
References:
 <c5f3f2c9e1d5a3754ff61b3569191b31d13b9bda.1760939793.git.wqu@suse.com>
In-Reply-To:
 <c5f3f2c9e1d5a3754ff61b3569191b31d13b9bda.1760939793.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|MN2PR04MB6975:EE_
x-ms-office365-filtering-correlation-id: 95181ff9-2f80-421f-e7dc-08de0fa7d804
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|10070799003|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aFNqUzM3WVhYVEN4R0tYUzVXVC94S3ZsTGRNbnYxNHkvMHpkVHFvaFhXNGU1?=
 =?utf-8?B?VUZ1ck1pUHp2WXZFOXpaeG5mcDhSV3JlMGkwNGI1aUJLenVkZXBhcmRKbFd0?=
 =?utf-8?B?QWN5N3JQdy9NMUdTeVR5VDR4T1RqWlhCNGU0Wnk2dUJiRWNSaEhTU3RtUWR5?=
 =?utf-8?B?VXN5M2k2cHhmZGR1elVPeGJTcGJPQVZSUFVGb0Z6alNjYUhQSzEydzRiNVNN?=
 =?utf-8?B?NXVmS21nZ0QzamovSUx4WFNtQmQ0bEFSVFpaRldmSnU3VE1VaVFxSGRrRTI0?=
 =?utf-8?B?czFsUGtON0hBdGk2UDNrNUo5SWZoeFc1bVMwMDFUZkZqdCtwMXNidkZpVCtW?=
 =?utf-8?B?WjJuTnpKaXptMlg3aVE0aVlucWI0MW9OSlEwTjVOMlhCeXlGbVlqVDJtNVdR?=
 =?utf-8?B?TWxjQzY2UW5CS2tSUGVxWUVDMjZyZFNmMiswaDdReEc3S0NJeXpqaCtYbUQ2?=
 =?utf-8?B?MVFSbFFaWFVrRlE5ZzZLRERsN0U3djVQNmhTRnYra1dtK2RpcFhmeVZqcmR6?=
 =?utf-8?B?UUV5TDJsbVZJLytpb0o0dGYyVGEzM2VLemJ1d21ObFpEbHF2S2tIS0gxZGFr?=
 =?utf-8?B?NEV2R1RxN3dSeDZ2VWxrbEtGeXAzNHFSOWdIUUFzdXBPOXpOUTJ0UmtCRzVa?=
 =?utf-8?B?ZGZ1K25sQTN5TFI3S0Z4UFFDMUtsb2ZqM1lHcTk4dXplZjR1SEFEZnA4TCs0?=
 =?utf-8?B?eG5xVjRaeHg2OUpJc0tkQjFwd1JLeWJybW9WTjdvcFRreUdqanNMODY4Smh2?=
 =?utf-8?B?MzNZeXplcVJBdkpxenJtcDlyNTZ4cHJyaFJVcDAyZ2lFalVQa3lYaXMvUUVM?=
 =?utf-8?B?aEg0Z3orcWppMk5wSjZma1pwd0k3YUJPTWNCTzQ4M0tNN2dScE5kMDNLN0xj?=
 =?utf-8?B?c2ErYUpaMTg1aGpJaXl4NjZta0c4Yzh1YmlHMUVYUEc5TWNXa0RBT0xrNWZC?=
 =?utf-8?B?WkttVmplcnRLeDNDU2lrdUdQUi9PR29obDFGMUI0N0NGakxyUWVtVVVvY0FN?=
 =?utf-8?B?djIxaVhEMVFsRmhxZDZrZVNnL3VVYjJ3bkZtcWpPUEtTaFpyQU0wQUlQYVk2?=
 =?utf-8?B?c2pmRmoxMVdwVnZOVzdxTmMrNzVoWk8yOEkzTjc0am1yVnRIQS95aTdYTUxM?=
 =?utf-8?B?RUhiVGhjR1FCK3RqQ2tvOUFUOGhPNVAzME83YjZrVjE2SEQ2Z2hpUmlJa2JP?=
 =?utf-8?B?NTBLL09MZjZlV3lsL2pGdUMzb2I5Vk54R0pGWTUrN1pnQ1pzWW9JME9lQnZP?=
 =?utf-8?B?R24wRm5XbVRoUlN5WXlqWXp6WmJnRXBwMU8zeW5JUVZBYzk3ak0rdzVLZ2Z6?=
 =?utf-8?B?REh4NHlvWkxWblhRK1NrbVRHTTZpVnZyNWliSTZ1bzBNd2theG03b2hCckU2?=
 =?utf-8?B?bG5lUXJtai9EdG4wYkNTYVZRY1Jtb3pmcVZwcVA0eDZXZVZIL1lVRVZKSjI0?=
 =?utf-8?B?REtQaXdTWGlUU00xR3hkTVg0c2ZSVzVKdi9MUHpJZGZ0cHN1ZmVlUlFxcndE?=
 =?utf-8?B?enFITWZkUXNoVUlzUFNpOFptUzlWM2NNTWp4c2JhNlZQTk5JSDFwWjRMNUZ5?=
 =?utf-8?B?SzkvWW5vektLK1hETm1Ebzd2NGVISzV5MVJKUzJlM0Z3Yk8xZDhCYlhyTmhX?=
 =?utf-8?B?UzhFcy95bFFoT2NxNDB2MWlqRWhORm9CS0pjYzd4Y3UwamhqTG1OeFM2eXEv?=
 =?utf-8?B?OHhQQzQ5TFQ0Y1V3VkRaTVB4TEVTTVhocm9McW4wTG1lZmsyWFlPWlNkUVVX?=
 =?utf-8?B?QnNpUkkwUmRTbGQzVm9QVkRSU1dPOEFkZ3dUWk5ncFY1M3duTmN1UU1TdHZ5?=
 =?utf-8?B?N0tzQ2RqTENCVHJTbzkwZ0V4YjBISmVaZnhhUU1sSFpLNHZjcnhTdlg1V1Nt?=
 =?utf-8?B?ZW9jblRhRlp4d3BBNk50OXh4Qmd3RjZCZ2lRM2Z1L0ViWC95Q0dJRHRyeGhm?=
 =?utf-8?B?eC9kRjlGUFFXNGhROGNyVjRkYjI1NWVSQW9HS0Q4eVN2bjlLbVNhazZWOXZC?=
 =?utf-8?B?L2tVZzkxL2o1Y3RNR3hkelE3dGF3V1lONmtCbmV4Z2cra29ycmJzVXFWeDRK?=
 =?utf-8?Q?KgQCDM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?amNVOW5QcXczUXBpazI2QVB5cUVQNWplVi9BaGJveXlidlMwMUZiL0J3VkdJ?=
 =?utf-8?B?UU5PMTdSMGU2T3QxVFVWeUNuUTg4SVpCVWlvU2tQdnAwWGhYMm5MUUZGYjZo?=
 =?utf-8?B?eHlKUisyNFkzTVhXRlg1WlRwYmJJNXlXbUlkOHBwUTdndW1aRHhXN2Y4WWRN?=
 =?utf-8?B?a25JM3djVG9HbEs2aDJwbE81QW9Bc1Z5SkV5SGxjYzJML29SL01aZTROZ0Zr?=
 =?utf-8?B?VXFZQlVNbDFheC9wdEdtc2VXY1pSZGlPaC96Unp0Mm1EbXJteE82RkY5aWtj?=
 =?utf-8?B?TUlNL0RGekJBU21RQkFJZjNvOVk1dmsxc0JMaU1vcSs2UGp3Q0VpMnU5RHdh?=
 =?utf-8?B?SG5IQkFqOFZSdjZZY1VJOXYzT3Nncm0wbk9rZndoZktvQUdtNWo2RUVOd0d6?=
 =?utf-8?B?YThRRUJ6elhyUW9LUzJiTGd5SkFKRGNmbUh4MW5mVmVJRDVoaHhwVEltVGh6?=
 =?utf-8?B?MVJqY010QkoyL0Iybks5OTRadmJQcGhPV2tyVG1rN1VXNXJDMnRteHg3THNF?=
 =?utf-8?B?MU5oKzlHYm5DQk53QWFySnNXdmxGTXdjWFBNWkF1YS9pVmp0T09ISXJaUVpj?=
 =?utf-8?B?ZUVJU2ZCRzFzTjczUUJiN3YvUHN4dGZJM0ZBZ1I2UWlPUytOcXg2c2tBQlVv?=
 =?utf-8?B?M1RBRjBCa3V3ekVHV1Q1VjZyR3JUK09Fd3NCNVFGcENOdmlnT3R5UHBEQXlH?=
 =?utf-8?B?bXQ5UE1LZnFhZUxaUkZhK0J1aE11KzVlZ0ttNXAyT0JaalNLTHJ4bURMY21W?=
 =?utf-8?B?UDhVNHdLQm5PZ0Nua2RkdDZYTmVBcTBobXFmSWZ4NDBUMHVlSExVaUZHaC96?=
 =?utf-8?B?ZEtJUU1PUm5HYWhrUVlWVFI4bjNXMCtkc2YzQ043dWNqclNva2FNeS9Ub3VT?=
 =?utf-8?B?NlR3ZnZWSmFkcVJrY3RNRVQyN3FaVEZaZFhxVm9GM0dSRXlVbjVxR01LeVJY?=
 =?utf-8?B?N3BrN2Ryb1VnR1VST3g3L3JselNGRWpzSE1zMHc0VjlvdGlxa3V5SVBleTEv?=
 =?utf-8?B?OXhDc1B2VStBNkpKN2F0bzVFZUNtcVZpRzc3TUNGelVyNitER0w1aXFQeXpU?=
 =?utf-8?B?ZjBTUEdQRVpTa211SjYvbFpKd3NGZFBtdGNWdzgwOFhMVEYrWWVrT25UWnll?=
 =?utf-8?B?U3pkK2xTYWpLZlRXRjFpOUp6czl4allOcjUyektPSHJqeGJCTHZqaXdHcTVK?=
 =?utf-8?B?WWprWUxRZ1poVGFuaGxORmxBNFBpcEhFVG1DZ0pKUmFvZzNkMGpCVlpJSUQw?=
 =?utf-8?B?b2lnQ2dsZjd6ZnVwcmlwSFlYcm41U1NBV3lQeWF1R1ZqS2J0cVRkM1gzMmxU?=
 =?utf-8?B?UHFYMlQ0RlNqWDhEU0kyL1VZYWszVTNOMyttdndJQkZ5d2dyZndkd3JSY1Za?=
 =?utf-8?B?YUh2S29NU3FpdHpESHZQUCs0QnM3ZWdqSUQ5TS9jUmpUM0dwYWZDU1ZiMVRR?=
 =?utf-8?B?S1E0bnNsMkxZd213ZmI4NEtyQ2ZNR1gzK2tFUHBtL0xaNWFoTzJ6bjF3TmpB?=
 =?utf-8?B?MWl0YW9ZZzhJakM5TlpnQnlzL1Q3dko5SFBpWlVZemhHcWd3Y0Y1ZkdvVjNO?=
 =?utf-8?B?MnNlZWtGSDcxYThzNnlHNE1JSU1WOE9HK29nRDJlZm9TRkswR1dhUUxwOURF?=
 =?utf-8?B?aXFzZEtha0IwVnBNdWRKbEs5NFpHbm9FQ3Z6ZHJ1WjNQWU52bDQrcXh1YjUr?=
 =?utf-8?B?OTdPM2pkMnU4Q0hjVVk3d1ptNVgvNEZTVFlXS0F3b1NqT0xBK3h4bHd2QU5s?=
 =?utf-8?B?VlpFejZHc2JaQVByMUlkK0FacUhJUlJRZDVhcDJ5THB6aUtDaHFEQWQrTVZ1?=
 =?utf-8?B?T05TR3pOMFArQ2xnVjRkZVRVUlRMdzN2c25sQjdJUzNDcmRQdWZNZ2pWcnFp?=
 =?utf-8?B?d3g0WVpYSVRqMytrMjJpZmVERko1TjVuKzZZREhsbmNTNzZreUx6ME5LNnVp?=
 =?utf-8?B?SGE3SGc5VDYwK3lEdGMwQTlGWVR3M2dGbC95V25vejNTUXhqMElCVEd4NWNU?=
 =?utf-8?B?TE9JdDdhTFUyNW5hYmYzU3hCek9PN0lsNzJvZU81NjJjdlVXeUMyQW56N08v?=
 =?utf-8?B?cURQZUFPbVdLeEg2T2ZxZGVGN0xxWjdwbHRZMlcveGlXUWh5dFhwZ0RiS2lN?=
 =?utf-8?B?bFZtY0ZhRDNsaEVPcjdnclpLaERwWnB5NXN5R3ErM05ZOUwwMVEwbWRrdTZ1?=
 =?utf-8?B?dXFrU1lkVnFrV0RrdEg1dzZYRFh0YkF2d08vaG9OKzc4bDdBL1VVRGhpSGdN?=
 =?utf-8?B?eTh5WXh2TFpINDl3R2Fqd1J4UjZnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11501CBA3F99AD43B7F56EE1AA68B1BD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QAv8Hfcsh7jFkXXQPSR6Pe9Ps403IBlfEFIaMjzZu10J7fXGjZsYfLkG89oSjxCq8El1gKaDRkvs2nmssBsNb4KvO4/8KFykO77rNwFMPHzWSoOBDBuPypbkaVIjwCd1ZYVKgHavi55uu1sWmRyjhRcbChr/9aSCZISrHskg4bROVU3aLZsHevZlgsDpzKnVuagFOVDQ0m3AWLHV9X2YlhdOJBBrQyhMo1kTxfGCLE+xOQ9H+5kObDwMYDBo8CC/btILOgtpr8UPKuBGbiX9w20wpt6tErn0+dfYH73zE5+9g8wtvL65NGq1Xt5R04sXz/JvME3eKTEx405quhdSj9pV3oas/nreQZzhnicp+qNcoQJZf2csCZMKJlHG+UhtiAVs0WD/LqyW5TNtNTnQvFY4rU+qwIF5W6/kv6XPju5iafVQLZ9HYx6W8Fuohy94QChfu0L4RBp8sJCayoQXuibOiqJgwyvaFvSoSbwjAuGD7d8OGmKMyDH8NpJztl6lnzPcK4zC2q7z8IfsZdpQR9Pa7IY+LAStFwW5Y6qgmUknljsd2cfQnup/W3pgk0XJV9S//EEwHBy0wdlc78onDGtWQ383DuO5NVgBPlpYjX39FXuifzvA+QtWZwQS4A4s
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95181ff9-2f80-421f-e7dc-08de0fa7d804
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 07:11:09.0852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FJsf39sr9wxhQHwVZcWUoQsPteMWSZRHU2csP5S4zOktU2yOxrU6usR9hNN0WT8EnKU3VAdpAkA0yevJOD4IQ4bFDQzojYFSMR6k4qnuhTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6975

IMKgIMKgIC8qIHNpemU6IDMzNiwgY2FjaGVsaW5lczogNiwgbWVtYmVyczogMTMgKi8NCiDCoCDC
oCAvKiBzdW0gbWVtYmVyczogMzM0LCBob2xlczogMSwgc3VtIGhvbGVzOiAyICovDQogwqAgwqAg
LyogbWVtYmVyIHR5cGVzIHdpdGggaG9sZXM6IDEsIHRvdGFsOiAxICovDQogwqAgwqAgLyogZm9y
Y2VkIGFsaWdubWVudHM6IDIsIGZvcmNlZCBob2xlczogMSwgc3VtIGZvcmNlZCBob2xlczogMiAq
Lw0KIMKgIMKgIC8qIGxhc3QgY2FjaGVsaW5lOiAxNiBieXRlcyAqLw0KDQoNCldlIG1pZ2h0IHdh
bnQgdG8gc2h1ZmZsZSBzb21lIHRoaW5ncyBhcm91bmQgdGhvdWdoLg0KDQpBbnl3YXlzLCBub3Qg
cmVsZXZhbnQgdG8gdGhpcyBwYXRjaA0KDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJu
IDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0KDQoNCg==

