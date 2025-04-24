Return-Path: <linux-btrfs+bounces-13352-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B3AA99E89
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 03:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39E91943554
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 01:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787CE1E376C;
	Thu, 24 Apr 2025 01:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dUAURj8L";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ul5GCzIz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1113A20322
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 01:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745459667; cv=fail; b=MahyUHkbiqGKmyouOQj0XnRc/vvTL4GjXwwljOTCxTaONhG8q9r7smnI2ioHuQZl9StlixlYAYNrk+uIfJZXI+d8YsFbxi3Ra8iVUL3HqW1Py++D+HN21VdP2y6KhZ5OT0IyVSbdlERI6TW5Tn1lZb4iRwPWFN8V3Gp9hIIbyt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745459667; c=relaxed/simple;
	bh=sWeMWo2jhOuve83ouVHixheFPiyrjf1oiXlenddMFzU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QKKzduDzjWfoOTkTpuyPciHQgZttIFOENNKSGB8OJnkNK8ww77EplV80OPMom2DsQTXgwhSufly21LlFF3IhCZLXVYSB65oiGxNVE2Zw4DiZh+5FoECuy17nkIBp41yK3itLuEXrHbMUlAj/80F5CM1c3FFGSiD3JxkmaFuApwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dUAURj8L; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Ul5GCzIz; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745459665; x=1776995665;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=sWeMWo2jhOuve83ouVHixheFPiyrjf1oiXlenddMFzU=;
  b=dUAURj8LVdTT6lx8yAC6KTSU5xGSNYAY+YcgVNTkD2wHGGXkEXOxbtFP
   6Mwt7Ir/GmAlBKI/1KbUGtKFWucBbtDjUnjvwI02HZ2+bBjFrm1/UHdI3
   ooKEUeJF5dMN/9M+C7WSl5bnDDoULJjls2v7ed6uX/Cf53kzoYbCDplxO
   OP6aDTDYNRDcoXNiEX44ZBlGsdnXDBbcJrXClMSfkjzsTlRT+t7kK/Gx0
   2YSeSTGk74P8gdfmCcr0aetfon2EX8baOuOn2FO74SM87LwZVNRh7oCWK
   /WkkVUVgDJu8XUNCEZgO/aPzulMIeE4OAApIAE8fidnwRHzdlqN3dJpeJ
   Q==;
X-CSE-ConnectionGUID: 7UN87XY6Q+mCd9QFxhWkAw==
X-CSE-MsgGUID: vWvqF3BNTyewx2+/jAnBQg==
X-IronPort-AV: E=Sophos;i="6.15,233,1739808000"; 
   d="scan'208";a="83142302"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2025 09:54:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXIQueXiaFOm38WxPXZ9/uOrs35gqPwKsRm8aT+nc7+uKmqJT/sKjMkh/UqGPg9c4RBdb9Lgdtd5yiSyaQMhKQuQNdzdTa8+tsMQmRZ+lRzE0fcdJXrMIBIMl1kvdOYYfJ4L9CZp44brc63y2tzIlcEouPvc62HvCpt+DycAa2advfLccQGowX6J89En/olgexf5ARIFkLTK6MERiEzrXjJYylM2NZdlYrpDqFXbxKR2K5MR6TqDuFjMuNRQN6TGY09lpL/r2tq3FMElmbPHjRNiHGJG41qeEO77EhwuRDLonAsHQhBEpTdUUT6GL6CE6l1FYc4sGdar/oGvB8cTjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWeMWo2jhOuve83ouVHixheFPiyrjf1oiXlenddMFzU=;
 b=gZ5enOPGHqrxXmt/wZfHWGrrvCcVNDw+fPhhIz0zg26gk+PFCAiXF1SISoGe1wFe3mP0ZFJo9g0jTt5yhznfTJ7mILfFfqM1Xyxyfza9lGsQ4kS8uvbdKAWgLvVp5X4fxzVsAE8mslS6Xu2sAKCPz/b6GTHUglcLXKCiRFY2Upvp6dZiK7kv+X0Tnsf22AxFN2+3vTg1llxt3IzZVBLDPlbjzvbH1LTV0EfxM9TB/hmcKdkuxELUchpACSsGj5EipbiAiPOch4HHFk1UCqEuMJeYwnFOVHJzRUYxovgQfxPsd9aLsON7g1lMNYAfD6c6auhOc5V393J1ij637MZ6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWeMWo2jhOuve83ouVHixheFPiyrjf1oiXlenddMFzU=;
 b=Ul5GCzIzewWmIQCv3IV7/knGhTmu31mNoBwAUzkKmJEWa462T4vJE/Ou+/XmuxN1ObyvgErTOQ3933PN8wVeHsae0+Wkki4SrXhgeHD9HMPpmqaIS2wlfMujxePs8MeuD9L7lFIWs/a/F2HpLbQBiYMOwtCiFaosNeuEIIqT/4s=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CO6PR04MB7699.namprd04.prod.outlook.com (2603:10b6:303:b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Thu, 24 Apr
 2025 01:54:23 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.8678.023; Thu, 24 Apr 2025
 01:54:23 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] Bool return cleanups
Thread-Topic: [PATCH 0/3] Bool return cleanups
Thread-Index: AQHbtHBdoY8N/Aei6Euw+WQFeQDgqLOyDrgA
Date: Thu, 24 Apr 2025 01:54:23 +0000
Message-ID: <D9EHT7DOWGHX.2NZO4C0PPUUHU@wdc.com>
References: <cover.1745426584.git.dsterba@suse.com>
In-Reply-To: <cover.1745426584.git.dsterba@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CO6PR04MB7699:EE_
x-ms-office365-filtering-correlation-id: bffdd001-9e88-4853-58de-08dd82d2efd5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VWpoeFNDMVdENDl5ZWNGTDU5NWN6UzBENjBoVUZ2bktPZE9XVFdaUGlDYjJZ?=
 =?utf-8?B?Um1VYldJZzZXQkk0S1JLTHJoSUxuanRNbUVUZTIzbGR5R0JIWVlPODRwbkpi?=
 =?utf-8?B?Qnp2ZTBBWWdMaGYwenJucHNzNGlyVkdVVFB5Yk1KcDRUM29lWkhOTjZERURU?=
 =?utf-8?B?YTV3N24xcTV3RmN0dHdtU1hEWGNTem1YOHZiUzBEdUJ0cGl1dmVLYzFlZldk?=
 =?utf-8?B?SXJvNkVZNUJXc0VBMEVZdFgxY3pKUkdNN1ZvdWdQSVpqWlFZT3ZXRVJzb0Fl?=
 =?utf-8?B?Mk10L1BrZVFyUi9vOG1naU1ITURNN1RVWnd2cWFvbmZKWDJad21rS1c0MG41?=
 =?utf-8?B?bHR0L0VVWFd4alVxakVmcjlzNTU3NWI5ZnNzT3czdGlONlNQM2RMNmNRc2g2?=
 =?utf-8?B?NFhsMWpBOUttZ0lYaGUzTURLelBSelZKbUdCbU9Rb1I4dXFSdzd3ZnpPOGtR?=
 =?utf-8?B?R3JBODB3dS95UVB3cFM1ZUFJZUgvbkJqQ0x5STgyR05KUkdtODlyZlErOWt2?=
 =?utf-8?B?ajI0WlZNb0g5cnJwQkwzdm5IRTBrc1RDSTU5ZXk2OEk2NndqWUVqZzNQOEwr?=
 =?utf-8?B?eTl0TXNieWQxalFJandTSmRwZU4rdGR3LzJnbE5ZR3p4QkQzK092bVRFRDM1?=
 =?utf-8?B?ODdIeXFDalZGcjlSdlRXZTJrL010MzBzcktQWnJvQitTWDJKdFVyTUNRc3VN?=
 =?utf-8?B?U1h0WWNCUEpieHRSYy9vb2tHMGE3OXFPWnBkMGlob0ZOTVRsMGlUbXBXVXdX?=
 =?utf-8?B?K2lCOU9wVzNJUkpqUXR2RVNxc0k0WVQyc3JWaTM0UVhaOVNVWUU5YURXK3Fu?=
 =?utf-8?B?M1NtaE9SU25XOUlGNEhLUHdIWWhYRCtNdzluUlhmcmZtZVBlU1FPaitpaGx4?=
 =?utf-8?B?VFEwQmlwNGQxV2VIYjJnclV3WTVzOW8zSzhKY0Z3WjJPRzZTV0N6YncvM0Nm?=
 =?utf-8?B?S2tGQ2ZlOGM4aEdLcVZxSXNqMDE2MnA4ZVNDbWduaWRFNjNtUzRIWXcrWnNy?=
 =?utf-8?B?dEVlWWtkUW9sa0V6S2RaUkg3MVNDS3dPQU9UR2UxOW1ZWlRMdXpOSXJmaTdm?=
 =?utf-8?B?eWF2blZEend0UTFlZ0s4MHVpWCtBSnNCYjlMaWw2WWNkc3RJMDV6TjhVNVk0?=
 =?utf-8?B?NlFtN1hQVkZraFk3WmEvdnJ4c2U3ZjBOZzZOelVzcFM5UmNaMmg0b1hLRGVF?=
 =?utf-8?B?dG92Um03cHJiekF2NU5sYnd6cnlPSDFCN1FuelpQOWhuRXQ1ZkJtNVZseEh5?=
 =?utf-8?B?TTg2ZjArZzVFNUlqZG1CeERUOUZRRURScHRRY1VqcnllWVpNZXI0VFhWbWtt?=
 =?utf-8?B?dHVDTzFQd3FPUzVMc2ZpM1BFYndiZ2FBMVZDZzUzQzhRdlhaWTBpZkl6ZWZp?=
 =?utf-8?B?YVNXaDZTbFpXb0FqZ0QxVnRLdDJKZVJKdkJFWndIbDl4SGtMd1ROTDNkNWFE?=
 =?utf-8?B?N2M1aDc5cDgrQkNTOVBtZExyOTdha2xLU0ZmeCs4c1gvdzA4ZVU1L2x2QzNI?=
 =?utf-8?B?L3gwY1VteHlyUXhwb3ZUc2Z6N1BsaXBEbDkxZzRjMER4Ylloc2pGaUxSQ3dU?=
 =?utf-8?B?MTlpRXcwcFRXS1pMb0E4elYrcWlUdTJ6VWNobHVzZnJGSk5kcFYyN0tpT0w2?=
 =?utf-8?B?M0VRcHhTeVl5N25TbDhsTlo0YmZJcUJZWmltbzBlQUxmRlYwcGpVT2l5T1M2?=
 =?utf-8?B?Y3U3MVc1TEM3WCtBMWovb1kyRmlvUTVCMUhoVmNMSG1ZdURVdC9LbGRuc2Ro?=
 =?utf-8?B?dHFPK3FaR3hRNktjd3VtUHovdU9LY1FzYUNCQmVCemtIbm9jSk5aUldqYU85?=
 =?utf-8?B?eFVVdlRIaG85WFlVNThJNW1uc0R6ajNNeDdyaVF3MXBEbXlFNEVkMUdDVVli?=
 =?utf-8?B?TjBHU28xdkw1eXU3RFYrem0xdEZlUzV4RXNqWWlnOUh3RDlSK0syOWY3QW5X?=
 =?utf-8?B?MkJ3UVRuVnVTckJCSjc0TWJxbnd5ZFNlVTE0ZjJ0cnpYeW0yYndjS1VGeFZL?=
 =?utf-8?B?ZFdkSm1NNTB3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MzZhRHRYNUVnQ0hRYkZ1Q1FhVXFCUXVNUlZvRnFGb2tBWTdoWkFSTUE1S1dn?=
 =?utf-8?B?UWNOUzg3WkFjVWlPR052amZaWXY4REFSNWlDdzVFL0gxS1QvcUJ4MUF1cjhG?=
 =?utf-8?B?cm1xRTgzM2NZRFR6WDRYaUs0c08zWlFSdmRFU0xjTEJiZGEweGVHWDNhVkUy?=
 =?utf-8?B?SDNtWi8zZUZYVitwRm82dHJ2NWtIUXlqWVZTWDdlL3lqdUlTYUhkcGYxeW40?=
 =?utf-8?B?YjdIRC9FZzBGd0tHVWI4MTg0djUvMGRwMWdCNFFzSlJrSjZ3SnlRL09aY3l0?=
 =?utf-8?B?MEQraUNRV2hNcWU3aDh3SjVDSWxXcjJ2Z2JsSSt6bXdLOHAyb3puNWNNcVlq?=
 =?utf-8?B?RlE0OUxCd1RrTURTeDRMenltbnlWc0c5Tmd6LzBoMERaKzZEY2ZyTWp3d0hp?=
 =?utf-8?B?UnRzbEZQS3dOSWV6cGRpM3ZJMFkydEVGaDljQ3VZM1A0OTJ3K0dTbkIyanp3?=
 =?utf-8?B?MFh6ZTFJZDhCWGhVMW92bHdnN3VVQUtYcEdxOTdyV1F2WUJKc1JnL0U2N1lk?=
 =?utf-8?B?N0grV3AzZ1ozR2haK2hnbk9TcVlXVld2N05wZUdhalh4VHd0S3M1NTlNdVAz?=
 =?utf-8?B?NVFLSXpjSkVXeWdyNTMrZHZySDZLc2FiTkxYMlRZYnFDOFYzaFVTU0g4dDZy?=
 =?utf-8?B?UWxCMXZqVHhxRGQwUWJ4MW52azBiWmFReWZpL1Q3OFhRWmU5RTEra2dSTTRW?=
 =?utf-8?B?bEJrYTR3NThvMnNGUHNOaUJqb2pIOXBVYVJPcG5tSDFBVUsvMDlpdHU1N1Jo?=
 =?utf-8?B?cW1WTmNGN0xuL0NCemVJY1lSaXJuN1NxTllBdUlTNHd4aTVEdmNwaGFBbHcv?=
 =?utf-8?B?RTlyOS8vQ1h6aGhRbjQ1WlNQdm00T3RXZ3FlOFROdlp4R1ZXZ2ZIaXB2MDVW?=
 =?utf-8?B?OGVBVTB2YjIrVUUrMW56UkJ2aFI1ZXV2MmpDWmd4NlV5TG5lZk8rdWhrRElv?=
 =?utf-8?B?SkU2bG5UczZ1aDZ2WEQxUXRXYmFYYjRJSDMwNjl1WWZIVE1Ya3FrWFU3OFlJ?=
 =?utf-8?B?SkdrSUViRk9UbFUwVXVsMWNXME41a2tYWlVBMko3WXc5UmJKdEZRcnBnQmR4?=
 =?utf-8?B?OW1peEpUMWZSb3p0K1RWSW1YWVBtemNrZXlkZXYxTUZ5REF6eHhzZEtUYjNl?=
 =?utf-8?B?YmFFU2MrcjhrN01WMXRob0hhcEpjdk1heDN2WkRRNnYvUGJVZzNqdzJTQ0dS?=
 =?utf-8?B?NTdHYjRHVTdXTWpuQTVMdDJwN1ZnU1JDTlp3NUtLVEVGZEhvMVNhNnpiSzAx?=
 =?utf-8?B?MTJRNHBJTHJXOVZKRDM0bzhWRUZxa2dRaXRvRFpKMkhWNzRoMGdqUU5XbVVs?=
 =?utf-8?B?UWZzVUY3MWYycGpsN0QrRFZBMFNMUTc0dnpEWGVvL3NVc3lvQ3JaZ21tODZV?=
 =?utf-8?B?ekdsY3pGWVV3ZEdyd3lNaDdYNlBPMDJBcEt5UDVVUGlOSlUzdjljR0JRY3d5?=
 =?utf-8?B?WDBsdUQ0N01VbnFVN0EyWjNVektEZUIrSWpGNmJTeDdBQXQ0RE5oSFlZK3BX?=
 =?utf-8?B?c2h3Zk5mQ21Xd0dBSUFOUHg2RTZFby9ydGNWWURrMEo0ZENxWU9VMGZQQThk?=
 =?utf-8?B?RlpOalpWeHo5Skk2aW9nN0lIekpTWjFmNlpCV2lTU2prU0hFRkVxSFlaU2sz?=
 =?utf-8?B?T0VlVVNqaVRFc2ZaTmxRaStwVjBoMDhPNFJ4Ulg4MGdiMXlrbUhzSUppVEpU?=
 =?utf-8?B?b3JYUGNNQisrekJFYXp2QldFSmZSLzMrYk5SQzh3b1FBa3ZwZ01JRlN2NTQ0?=
 =?utf-8?B?ZmJ3Y0xLbzBNczhmYTJ1U0cvQ0haNU1TdldMM3NIcjMwdHN5RFJvRm9hQno3?=
 =?utf-8?B?WlFUTjBCa2dOZEFMNXNmZGU0VHpmVlkxdm4xdWgxcHRtb01rLytSQk94dXNl?=
 =?utf-8?B?UWRCNXRHajJ2ZDRwekFldlFhblc0TTN4ZVZrWHFmalJiTWxLYWl5VGNSNjNS?=
 =?utf-8?B?N2EyTmpaU1dMQ2YvNmd3clBCNXJGWFNnVHBLMFNrZG1na3F3L2I4Y0dUZkF3?=
 =?utf-8?B?d0pnR09GVVp4Q3Eyb3VjY0ZjdXpKL2pTZ3hxK2dvS1E2a0VIRTlMTTJpZ1Ju?=
 =?utf-8?B?cHcrT2YvZjZwanhHTWZIbXc5T2lUS3I0a2lKNmhiMXVlTGZvZytDQWZlZjZK?=
 =?utf-8?B?bGE1R1htNVBaSkNLbEtWK1BYbnVMWkdZeTFsZUQrbmUxV1JzT0lVOFl5WFFZ?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35399021953E204E98E0E07BDFC2F1D0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Yzs9cqJZEcc/j9axMvIM4MCopuIHz55pXyYBh8H7IHnxZuopgCsrpZ7q6h2jP1aJo5D2KVcFQHFzHll+iZ7TS0dbKk1oozecC8oPRMIKqpTTQME3eDTCCdoDNGGGJ5MP6DXw4CVtPqe/GvZuwQ7HQp7UvYJ7C3+QInSH22ZlrgFiewoRo3X2G7l7ZB2De2nbRW91+9l/iUPvSdaSYGDQis8jj977XSwov150IzmQvSvCfX/CohfTxqzdF0+U4j1xtuyMaQPDK0Qp4A0DyTIwga1L4ogDLrugFSofVwQECRojebBUJqPhJgaA9s3ndzjm0eJ6QcmCHk1E0hYZYOPCxjH9+eekcIN1UvUT1dYtGBHv926BOkwAMtWepoiB97Am5Q8zEM25D/4MINMlNZrx/RcpgFXqIn/7k3JELCzGpCCazi/0E85vC/jH0vcXcytDOGtFvXD9y4qWembcHp4rVRnbbOsvfz+0zkZ2AHQEOYvcHfKWKTMeG5J42jH2iVSiAWYoLfd7w19Tse1Z6WRq9TIJA4YAwnZKGh8Xg8Uqnk75ICEtGXOiRf0AsInBiDoPmusRqpsom2A/HOsv7TJ4HrhwAxk9BH752iIDCV58ZLDXkK/ShSx9kL6fePjTalJT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bffdd001-9e88-4853-58de-08dd82d2efd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 01:54:23.4432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dHJkcGW7lmaKraXcz1sIjmQhOernXI4YWKljc1EZpFcPAoTsRwX3wzHMOJoqzsT3VOR+u2THqxVSrX18osjwLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7699

T24gVGh1IEFwciAyNCwgMjAyNSBhdCAxOjUzIEFNIEpTVCwgRGF2aWQgU3RlcmJhIHdyb3RlOg0K
PiBXZSBoYXZlIG9sZCBjb2RlIHRoYXQgdXNlcyBpbnQgaW4gcGxhY2Ugb2YgYm9vbCwgdW5pZnkg
aXQgdG8gYm9vbC4gIFRoZQ0KPiByZXN0IGFyZSBjb2xsYXRlcmFsIGZpeHVwcy4NCj4NCj4gRGF2
aWQgU3RlcmJhICgzKToNCj4gICBidHJmczogdHJpdmlhbCBjb252ZXJzaW9uIHRvIHJldHVybiBi
b29sIGluc3RlYWQgb2YgaW50DQo+ICAgYnRyZnM6IHN3aXRjaCBpbnQgZGV2X3JlcGxhY2VfaXNf
b25nb2luZyB2YXJpYWJsZXMvcGFyYW1ldGVycyB0byBib29sDQo+ICAgYnRyZnM6IHJlZm9ybWF0
IGNvbW1lbnRzIGluIGFjbHNfYWZ0ZXJfaW5vZGVfaXRlbSgpDQoNCk90aGVyIHRoYW4gc29tZSB0
cml2aWFsIG5pdHMgb24gdGhlIHBhdGNoIDMsIGZvciB0aGUgc2VyaWVzDQoNClJldmlld2VkLWJ5
OiBOYW9oaXJvIEFvdGEgPG5hb2hpcm8uYW90YUB3ZGMuY29tPg0KDQo+DQo+ICBmcy9idHJmcy9i
bG9jay1ncm91cC5jICAgfCAgMTIgKystLS0NCj4gIGZzL2J0cmZzL2RlZnJhZy5jICAgICAgICB8
ICAgOCArLS0NCj4gIGZzL2J0cmZzL2RlbGF5ZWQtaW5vZGUuYyB8ICAgOCArLS0NCj4gIGZzL2J0
cmZzL2Rldi1yZXBsYWNlLmMgICB8ICAgOCArLS0NCj4gIGZzL2J0cmZzL2Rldi1yZXBsYWNlLmgg
ICB8ICAgMiArLQ0KPiAgZnMvYnRyZnMvZXh0ZW50LXRyZWUuYyAgIHwgIDEwICsrLS0NCj4gIGZz
L2J0cmZzL2ZpbGUuYyAgICAgICAgICB8ICAzMyArKysrKystLS0tLS0tDQo+ICBmcy9idHJmcy9p
bm9kZS5jICAgICAgICAgfCAgNTEgKysrKysrKysrKystLS0tLS0tLQ0KPiAgZnMvYnRyZnMvaW9j
dGwuYyAgICAgICAgIHwgIDEwICsrLS0NCj4gIGZzL2J0cmZzL2xvY2tpbmcuYyAgICAgICB8ICAg
OCArLS0NCj4gIGZzL2J0cmZzL2xvY2tpbmcuaCAgICAgICB8ICAgMiArLQ0KPiAgZnMvYnRyZnMv
c3VwZXIuYyAgICAgICAgIHwgICA2ICstLQ0KPiAgZnMvYnRyZnMvdHJhbnNhY3Rpb24uYyAgIHwg
ICA4ICstLQ0KPiAgZnMvYnRyZnMvdm9sdW1lcy5jICAgICAgIHwgMTA0ICsrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMTQgZmlsZXMgY2hhbmdlZCwgMTM2IGluc2Vy
dGlvbnMoKyksIDEzNCBkZWxldGlvbnMoLSkNCg==

