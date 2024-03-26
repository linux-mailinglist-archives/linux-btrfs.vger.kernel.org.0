Return-Path: <linux-btrfs+bounces-3615-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8024A88C9D3
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 17:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B44BB267B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 16:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DCD12E75;
	Tue, 26 Mar 2024 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d0xGUJHF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="swkT/jgZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD4814A82
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471856; cv=fail; b=J/tYwtHaJ8uQcC1IbtBcbtHs7ODyEJfV+6x33cwNw72IEi9znFRazRRyoXdZ6Kd66+hQhMWcmfEyGWs4ZBc/1TEGb2dA8tKuMsnW2BDJtKalnn7+EYq1SlWFuwesaxSLydl5V9eiX9jyTb3TROkilRaiiVtKgS84ycEdGjHPv1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471856; c=relaxed/simple;
	bh=OSlY+2zfvyokAaln3OSjOjG83wBh9CixS+I6oy8g/N0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=czC6Po1oVIsTVQR/W7QzbJ4xjegmQjLjKGHReIu5P+BKwcYwG1ydXKXjhz5xF3x/ddSmu9Oq62sMZRiJAAE0Hs24rjvtvoChRak8GOaKaSAE8695uFpSlLGtYumyGsV3UIBmJW4DoLyOmvUX42nPgdshvNlO6aILf5RFgZhOvcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=d0xGUJHF; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=swkT/jgZ; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711471854; x=1743007854;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=OSlY+2zfvyokAaln3OSjOjG83wBh9CixS+I6oy8g/N0=;
  b=d0xGUJHFRIC0hj7uy6+bjR9zjd9gbP4Sbm/invLL9zAjXsqLqZUmq59W
   TRHVPoFKazlTWlMoaQSyP4GT4y8MoL4VZzuMdRupD3r05BI1NvrJqjzwV
   DZVKuQuu9JA8ZhRMC3VUFllIO1mb3wBE+bqh6nnrXOdUkznm9d8lWhfbf
   1Srb0htep24thV3W98L88uskmLiKXJgS2gM1/K7ki7Zw5q7nc4a03J9BF
   v296D6AXwa2Z+dYvHpEYyFBUmTJMiLJN2aFnep7/OaDzvn6rrr2+p1lz5
   wqy4iRSPHj6VjB1ko6jTgcbDXZU/1kSZRHns3a1bV/kVeF/yzUnpqTEXQ
   Q==;
X-CSE-ConnectionGUID: iqobjsaQQfepqDJmjrsQWQ==
X-CSE-MsgGUID: rQcUWLdXQpaF81OAVXQ4wQ==
X-IronPort-AV: E=Sophos;i="6.07,156,1708358400"; 
   d="scan'208";a="12534180"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 27 Mar 2024 00:50:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzZ/Tlizmw2c+pJnI1UQpYmiMXkbOpCoEfLuM1abcp4noYOI0JnfNSeW8HTvakFuPcfenMtqxO9sWjrYwGTY/ddZKMCIFXovtlB3/OWG7KcU4nr+XKe7Qx0IHQza6Q2ie0ZH5P6wfBpdCJttSaGxCM7BxLxkGRUqXrIM0/9PopGdlpMsEYKQWDNm9/44ZK+XrYeBTYJ6p4ukoqAkRQ+Ke5pcymXusutvZxuDcgqP63vnfn3AZ7wxHp52A9pxCRFCXnO+LtQXyeWnCeK8itgA0MKxkzEgQaXMPBGnMg64WnWAGqyx763DC9JcOEQ4YdBfjSbF88qogL+NSPqujqnZdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSlY+2zfvyokAaln3OSjOjG83wBh9CixS+I6oy8g/N0=;
 b=T8OCB/qQodh9MzQZvOo2O45p6vimlcGdL7MgJF0J7Zc7NrbTrfYr2CODW2uJclunyOeP5Quzb31lJ52Ha2GCJTzRi0HfjXme+3jrDzF8UOo3hsW61r0LZbpupuXoYD1rVH3pcGVo8tQNzOCwCu13ooWuNDTS5PAYqYWU8ch4GxEVtUOVB5gzwSyn+IoGWmwqSVZm7tsG/OyRPetSA6m0WctSKjGLzKhhDa3y+fIfhZ08QQlcuAugeh9OQzoZ0bPJAJDyPzwMSbu+1cAsnC43bcg+hyYlvxw12O2KM9jXjuw526pHUK4I6GLX2hnL1dqdDkU/MBILgAWbX3CFlq32Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSlY+2zfvyokAaln3OSjOjG83wBh9CixS+I6oy8g/N0=;
 b=swkT/jgZP/CMLfseXUF2H6W1BFae8bCT4WWxSH1Z5SOzcNPAkAOCeyUGNB98zwPP1U2pXW9pM3dHdT1ztMgKwcJLE5iWdrJIvOGzhJKDLGu/Z6WKFhuyX8UeJ2Uv04mQNpN6JK19wzUTNEHzWNr4bl2zvIEb0Fkrp+0VNslhsGY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8067.namprd04.prod.outlook.com (2603:10b6:610:fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 16:50:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e%7]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 16:50:46 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] btrfs: zoned: fix EXTENT_BUFFER_ZONED_ZEROOUT
 handling
Thread-Topic: [PATCH v2 0/2] btrfs: zoned: fix EXTENT_BUFFER_ZONED_ZEROOUT
 handling
Thread-Index: AQHaf0APJwuamYBO80uJClLt0WK+3LFKPP4A
Date: Tue, 26 Mar 2024 16:50:46 +0000
Message-ID: <7a93db1b-f851-4577-9635-f5c1f61710e2@wdc.com>
References: <cover.1711416290.git.naohiro.aota@wdc.com>
In-Reply-To: <cover.1711416290.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8067:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GhYNv0sd2goswpLNXLadAUGGua/AdP3jn03IlUNuIoWqd5CWFT4jsUWyWu+g4uDXJ/gDg3acBvDbwmm16ETO71L4uTUYeHaBjnZvC+c7J2xp+T53dSKfCdc7FQEl4xV+JoPxUoEBnt0ehLnxe4wW45g1gA61IHtOh5qjFArVqTT6aFnamLVJa+klNMDiuD/39wLnARBxubE2kMgRsEy1+3NQeTfXuLLwCdNUbXSJ686qXV69Wfod1UqIy9IyI7E79rGvmjRhvgCuQiVoDAAXgmztoij04/kgn5obKLo2vdSxc63moYpTNv5QLEKLhgrfqDrZSk2x/Qz/nrE3CvpGHZz9S/fjAYKFdirG8T99dEuehh3jHZbEYwnxnrMlrxXM/kCFpehtbIoFCcqRdMNNENyFZQCSb4XLmHQxrCXA/L9mYeiwjhrqZgqEGHsn5nKaagU6ltNH7EmQDuVA900j+F4go/CBKFxcX7H5DGm1ND0Tt9dI2yB7Zz1u8PrlszV9cb/8Pt/uGRAjPeW0NMKQ4atLDapD4sOTrL7t6DiVPNeyTzF75RJ8wrbftKtmqnoqwi9xg6NiYomFJExr9ntavkQE/Q/yxdexCov9Vzvjtw0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXhzV3ZaUVcwK0QyREwxd3k4M3JUalJMN0E2cEF0bGUzZFdZTnF1bFc3ZkNv?=
 =?utf-8?B?K1R1NkJyZWdIWG1NU0d2citrUDNUaDArMHpBR3FYMWxyQk95ZlloNSttcUx2?=
 =?utf-8?B?V3NNT2Z5VldyR1dSMGVLeWhMeFQ4dS80eERQYnFUOU9sK0FUMWI4V1dBR1lt?=
 =?utf-8?B?SnJZb09BalRFRjFYRm5jRnUwK1FxajljMUxyTFM5djl0UVpjeVJlY0ZSeG9n?=
 =?utf-8?B?RHZZRlZaMDA1Y0ZPc1YxcytJSGFKNUlPd2hQc1M5UTJ2VVN1c1dhcG9UdGxo?=
 =?utf-8?B?TnJQTGhtaUx0R1RJb2lPQTZUeFJxN3R2WTZSWHVPOWJkNHBPREhuTytRUkR2?=
 =?utf-8?B?VTJCNHpZM3o4bWJKc1BuOHBDaVJRSjJWZEk2SjRTTk1OKzZ5anJyNU5wQ3ps?=
 =?utf-8?B?N1lNb2tzY1lrb0NzNVppVXk4cTRwdDBuUHlLRTl4NkRpNllta0RabzMvbmZB?=
 =?utf-8?B?a250cHJBVitUMGpaSk1tLzhtY3AyVmx3dGI1VXJJTi9rNlQyNkQvRm83cjQ2?=
 =?utf-8?B?RG4xbW5qWDRYd0pVSTU2L1dxSGErV29IU3VwNFFaelR4R2J1dFpzaGxDcHhY?=
 =?utf-8?B?TFJ5SFZQbEovdXdDSHRNd3NTVm4zZXVUQzBsVjl2V0pHVTNBSmVXYnlqMGJl?=
 =?utf-8?B?SjhYQTF6eUtCazd2TEZyQlpOdk5zaUxaMzE5cHZVUHE3MHlVY214UVNxOWRZ?=
 =?utf-8?B?b2FydDBkV241QUJxMlhBZmEyR0l5UjZ6cnc2MnNMVXhDVG1NQVRBei9PYjli?=
 =?utf-8?B?ZGd0NytvdHhCNVlqT1I4YTZnRTNmRUoraWtiM2plaEIwNkJ0N0ZTZUFzYi9C?=
 =?utf-8?B?QzhoV2tnbkIvL2xEM3JSU1REQldJTFZTREtIYUJFTXl4Vk1ML2Y4V1hmUzdo?=
 =?utf-8?B?S2hWVTVCeHJNbHJFeUlrQW1QOUJ3azZucE1pSmtjOXdMRUtnQzJlTmo5TjRO?=
 =?utf-8?B?dVhVd3NlOGk3S3YvNXpGRHFhTTZhaUdkWlJaaTRmbzdyMzRJN1JlMHp2SE9E?=
 =?utf-8?B?UkI2M20yUFVnbUNvODJOb2NzYVk5dlNKV1lsL1cwWWpHUlgvT2FmSG1BUU1M?=
 =?utf-8?B?UVhHN3d5SkZVOG45TzJNakt3aGdrakUyb0VER2RhNnlhcG5mNkJ0RTVjUHQ0?=
 =?utf-8?B?S0RYN3RhUjM3Y1lvYnhTSzkvWVlwSStMdCtjYVJTUjNrOWordzRIRFExbmdQ?=
 =?utf-8?B?MUhSNjJPb1F6WFZIbXRwNUR2ZldzSk41TWIvQkxYZkVwekx0bG5OZVlucXhk?=
 =?utf-8?B?R3FXV1BobXFrc09oNXppZWhVSHdmYnA3QWE2MUkwNU9DL2JLYlQ4U2k4SzBG?=
 =?utf-8?B?Z2pNcGlYcDhLdStSOXJhS2xTYU9XSHRPbC9aQ1ZNLzBPdjYyYjRMc3pUUHRP?=
 =?utf-8?B?UWkxOHBjeUFTSm1TaFJtak9aQS9XVUFLREpCcnI0L0JFMWRHcngwR3ZPWVdY?=
 =?utf-8?B?YmVubHpTdVNqT0VxdlBmSEdvNDYvTDJaclNrMXhMdG9iUXF0UFVnL2xNWGFs?=
 =?utf-8?B?bWRxbmg5RDVVUS9DYnVNN0xGd1ZvQStDNmxtcG8wNk1teUE3V1dzVUQwRDd5?=
 =?utf-8?B?Nmtna01kby9iODN4Z0syR3FEeGxqUWVpYnVHZTVxUzVsSm1MNk9WS2pQYVlw?=
 =?utf-8?B?ODFJRy9pTHlLdUtubm5hZzk3MkhxMU9zSlZVMHlQc1F0NXVZYUpXa2Zrb3ZF?=
 =?utf-8?B?dkZKT2VmTG1hWHAreDBWYlk3cGMwZmJaeXVPYWpvQmdzZElXYnpFVkVTUm1M?=
 =?utf-8?B?ckV0Y01pYzUxUnBRM1VyVXk1dExJdDNaVUNsZmEvZEo4b2xHa0MzYzZxN2Rn?=
 =?utf-8?B?UU8vR2FRR2V3TDJXellWT3NyMlI0VDVvS2xWV0VaT0JHZnhSZlNDZWJHUytP?=
 =?utf-8?B?SURKblVxTjB6NFhqNlFUOVNLSStmblFQNlloNEprRXhKSmtvVzJ5VzRycVNJ?=
 =?utf-8?B?WTFnYm43UHBPRGxNY2dSbEVFaFAyN2ZUTTExQ01rMjlETFYzVEZkMThFOWtB?=
 =?utf-8?B?ajJvNjlKRmhwYWh1dXdmRThiWFBXZ1NreDF0Uy8rOEQ3NmJCaWVhWUo2WlB1?=
 =?utf-8?B?NEt4dCt1Z292UXlTWmFuUE1oYVdva0MyamNPc0gwZ2c0Z3JNcDF5TjZQVHR6?=
 =?utf-8?B?aUJKOHFYTm9maTlJbFdPMW9RS01wRW9SdnRZYUFjdUxudHk5NHZyNWk0WjFi?=
 =?utf-8?B?R2FxVzQ3SE9IMWVBMFFNQ0RjYUgrc1RGaGZOOENPeEd5b0xGWDhLVlhJeTdL?=
 =?utf-8?B?YWVXUlJGQmZPeHkvemFCMHVoSlFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA6407AC0D326F438968B29F7022C169@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dQIAbspwUI0QlUChfSvT6IaC0Y0JSAOCMSYb7ELfTD1QCziUBxu5keVOECzlTfUj1Avf3vxFMTc1KyzFPhBuVlo7Og6QUAUg13ZzIll2mxmmUfp+ekga7AJq+BgjDsMFUy839XtVut3lQLNBq+fdZQ4GMMfTpWR2LBn6VMeJarOlTAojflVk3oUvFHZ6Mbns0fn1AUxFxuye/FYfa1mLSgszVvi9U90xnflgqFUmaFJpYDGYtpNzpiV4aPJco2PJE9ljRI3/TLfjtzKjsRi7szOcaJ5x3C1+DBat9UW2fhZ59Pg4YHSx5RW7OzqoNV0B9pryWk2zU+G7eFBJDnPxbO00ieHn1VszWKSGMMM2MXLpBay3kw/v79VHBCbKkV/2sQQ2McAa+CyVhRLFZcphAPG5A51QPWrOBV422z8fxWJp+Ru0oTkpFniyFYMzD7yo2srxTbupVPBxSl3+aQOtv+colbfq9+f9f46UTX6533oOCE6JlyLHpIupq6r8nkuBEykwo4k0zRxppYRxoanNLkruWbu3nB5ZRViXbXJEpInk/UlKp7ta2enVKPMAAfIhzO/UP3aVwO7cGWXQfQyUjdOS+lILREYsd5t3KN41tF/tyLXhX11vLMGOS99uZJ80
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887fec93-2c0c-4ad8-b382-08dc4db4e279
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 16:50:46.8471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5RFyrCunVAHnu2WqeQai3gCeOzv13N8hcS4YU1dg7VkBG69HjGYqmIGy1Ku9Le4KnOOx7Mn4OkG4R87C/cAw8RvBaeyUwfDpBTebMDpNOao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8067

T24gMjYuMDMuMjQgMDY6NDAsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gQnRyZnMgY2xlYXJzIHRo
ZSBjb250ZW50IG9mIGFuIGV4dGVudCBidWZmZXIgbWFya2VkIGFzDQo+IEVYVEVOVF9CVUZGRVJf
Wk9ORURfWkVST09VVCBiZWZvcmUgdGhlIGJpbyBzdWJtaXNzaW9uLiBUaGlzIG1lY2hhbmlzbSBp
cw0KPiBpbnRyb2R1Y2VkIHRvIHByZXZlbnQgYSB3cml0ZSBob2xlIG9mIGFuIGV4dGVudCBidWZm
ZXIsIHdoaWNoIGlzIG9uY2UNCj4gYWxsb2NhdGVkLCBtYXJrZWQgZGlydHksIGJ1dCB0dXJucyBv
dXQgdW5uZWNlc3NhcnkgYW5kIGNsZWFuZWQgdXAgd2l0aGluDQo+IG9uZSB0cmFuc2FjdGlvbiBv
cGVyYXRpb24uDQo+IA0KPiBDdXJyZW50bHksIGJ0cmZzX2NsZWFyX2J1ZmZlcl9kaXJ0eSgpIG1h
cmtzIHRoZSBleHRlbnQgYnVmZmVyIGFzDQo+IEVYVEVOVF9CVUZGRVJfWk9ORURfWkVST09VVCwg
YW5kIHNraXAgdGhlIGVudGVyaSBmdW5jdGlvbi4gSWYgdGhpcyBjYWxsDQo+IGhhcHBlbnMgd2hp
bGUgdGhlIGJ1ZmZlciBpcyB1bmRlciBJTyAod2l0aCB0aGUgV1JJVEVCQUNLIGZsYWcgc2V0LCB3
aXRob3V0DQo+IHRoZSBESVJUWSBmbGFnKSwgd2UgY2FuIGFkZCB0aGUgWkVST09VVCBmbGFnIGFu
ZCBjbGVhciB0aGUgYnVmZmVyJ3MgY29udGVudA0KPiBqdXN0IGJlZm9yZSBhIGJpbyBzdWJtaXNz
aW9uLiBBcyBhIHJlc3VsdCwgMSkgaXQgY2FuIGxlYWQgdG8gYWRkaW5nIGZhdWx0eQ0KPiBkZWxh
eWVkIHJlZmVyZW5jZSBpdGVtIHdoaWNoIGxlYWRzIHRvIGEgRlMgY29ycnVwdGVkIChFVUNMRUFO
KSBlcnJvciwgYW5kDQo+IDIpIGl0IHdyaXRlcyBvdXQgY2xlYXJlZCB0cmVlIG5vZGUgb24gZGlz
aw0KPiANCj4gRml4IHRoZW0gYnkgc2tpcHBpbmcgYSBub24tZGlydHkgZXh0ZW50IGJ1ZmZlci4g
QWxzbywgdGhlIHNlY29uZCBwYXRjaCBhZGRzDQo+IEFTU0VSVCBhbmQgV0FSTiB0byBjYXRjaCBp
bnZhbGlkIEVYVEVOVF9CVUZGRVJfWk9ORURfWkVST09VVCBzdGF0ZS4NCj4gDQo+IE5hb2hpcm8g
QW90YSAoMik6DQo+ICAgIGJ0cmZzOiB6b25lZDogZG8gbm90IGZsYWcgWkVST09VVCBvbiBub24t
ZGlydHkgZXh0ZW50IGJ1ZmZmZXINCj4gICAgYnRyZnM6IHpvbmVkOiBhZGQgQVNTRVJUIGFuZCBX
QVJOIGZvciBFWFRFTlRfQlVGRkVSX1pPTkVEX1pFUk9PVVQNCj4gICAgICBoYW5kbGluZw0KPiAN
Cj4gICBmcy9idHJmcy9leHRlbnQtdHJlZS5jIHwgOCArKysrKysrKw0KPiAgIGZzL2J0cmZzL2V4
dGVudF9pby5jICAgfCAzICsrLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiANCg0KTG9va3MgZ29vZCwgdGhhbmtzDQoNClJldmlld2VkLWJ5
OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KDQpPbmUg
bWlub3Igbml0LCBjb2Rlc3BlbGwgZmxhZ2dlZCBhIHR5cG8sIGJ1dCBJJ20gdG9vIGJsaW5kIHRv
IGZpbmQgaXQ6DQoNCmpvaGFubmVzQG51YzpsaW51eCAocmV2aWV3KSQgYjQgc2hhemFtIA0KY292
ZXIuMTcxMTQxNjI5MC5naXQubmFvaGlyby5hb3RhQHdkYy5jb20NCkdyYWJiaW5nIHRocmVhZCBm
cm9tIA0KbG9yZS5rZXJuZWwub3JnL2FsbC9jb3Zlci4xNzExNDE2MjkwLmdpdC5uYW9oaXJvLmFv
dGFAd2RjLmNvbS90Lm1ib3guZ3ogDQogDQoNCkNoZWNraW5nIGZvciBuZXdlciByZXZpc2lvbnMN
CkdyYWJiaW5nIHNlYXJjaCByZXN1bHRzIGZyb20gbG9yZS5rZXJuZWwub3JnIA0KDQpBbmFseXpp
bmcgMyBtZXNzYWdlcyBpbiB0aGUgdGhyZWFkDQpDaGVja2luZyBhdHRlc3RhdGlvbiBvbiBhbGwg
bWVzc2FnZXMsIG1heSB0YWtlIGEgbW9tZW50Li4uDQotLS0NCiAgIOKckyBbUEFUQ0ggdjIgMS8y
XSBidHJmczogem9uZWQ6IGRvIG5vdCBmbGFnIFpFUk9PVVQgb24gbm9uLWRpcnR5IA0KZXh0ZW50
IGJ1ZmZmZXINCiAgIOKckyBbUEFUQ0ggdjIgMi8yXSBidHJmczogem9uZWQ6IGFkZCBBU1NFUlQg
YW5kIFdBUk4gZm9yIA0KRVhURU5UX0JVRkZFUl9aT05FRF9aRVJPT1VUIGhhbmRsaW5nIA0KDQog
ICAtLS0NCiAgIOKckyBTaWduZWQ6IERLSU0vd2RjLmNvbQ0KLS0tDQpUb3RhbCBwYXRjaGVzOiAy
DQotLS0NCkFwcGx5aW5nOiBidHJmczogem9uZWQ6IGRvIG5vdCBmbGFnIFpFUk9PVVQgb24gbm9u
LWRpcnR5IGV4dGVudCBidWZmZmVyIA0KDQpBcHBseWluZzogYnRyZnM6IHpvbmVkOiBhZGQgQVNT
RVJUIGFuZCBXQVJOIGZvciANCkVYVEVOVF9CVUZGRVJfWk9ORURfWkVST09VVCBoYW5kbGluZw0K
L2hvbWUvam9oYW5uZXMvc3JjL2xpbnV4Ly5naXQvcmViYXNlLWFwcGx5L2ZpbmFsLWNvbW1pdDox
OiBidWZmZmVyID09PiANCmJ1ZmZlcg0K

