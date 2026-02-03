Return-Path: <linux-btrfs+bounces-21317-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLBBLvgEgmmYNgMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21317-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 15:23:52 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 36035DA864
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 15:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A61BA30B44C4
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 14:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64173A901E;
	Tue,  3 Feb 2026 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R5AwYuoT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="A1lv+AIF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26923A9017
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128562; cv=fail; b=lTPDNAgBHx9d0hTlefc8LZBeFre2gPkkL5A8YlXqhfK2pLpaMFBzjfGt2mn5Nq3Bmk9pnUkKteE3BbdaH+hiWJ5bO5loWgXhd9dCBcZ/Ut5wPNrbh38hehLB4U3sfuCejk4Ky0VVyxcgC5AbbG5YBIDEH+lnrFJNcPxG4oY+qII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128562; c=relaxed/simple;
	bh=PDfyxvaMQQprhiwtoFPtZOJXRwH6MQDQ0AVQ8WNi7Co=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZuKOGLENNOT2bYfY5dnzYJdHapwlR4bv1yCspaJ2zpJnjsZ3y4nyr83D0xN2AHrI1E++wkZIvVZibs9c/gaD0mH9cULMpyUtSg8jwBnhTl3F0MF3Y6Hcd7DnhDDNhMKuj2+NeGMf/km/1imINVLmCvMEOzRYuwi2ZiTnf3V0VSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=R5AwYuoT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=A1lv+AIF; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770128559; x=1801664559;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=PDfyxvaMQQprhiwtoFPtZOJXRwH6MQDQ0AVQ8WNi7Co=;
  b=R5AwYuoTNfBbZOELLpLwQtP5WG1WE7O58XHIIJwHbKYD5Wcb6I5nCxmJ
   NRU9/Vd80nu8ST+PmkPwbrQy69LE2psXSKKXkoc7/tkzGJoNwVSMs7DTr
   7Y9XuPM3pgksdhEhlflpPIHAgZ1Zg5g2Pyl6HakmydXABRLCT/YzKpMHS
   MESPUz15m+qfLrZVond2aXXZXg8Q5E8etBYEsgUAyvpyhW4CD7LUpWo9b
   AH6BKygESNsZQYw417+eqs2TeM6SNO+HhmxrX3UqrvsvqsdRmLWFspQBR
   3Q0wriZySB4KcgWcy+K0zwCT8190H9dViepc+LzxhMXA1ZvgY8rpyhvrm
   A==;
X-CSE-ConnectionGUID: 7/E9M+6TSkmp1+i1Rj5b+Q==
X-CSE-MsgGUID: uXD5Kh2uSaWKFpkIXYR4mg==
X-IronPort-AV: E=Sophos;i="6.21,270,1763395200"; 
   d="scan'208";a="140010590"
Received: from mail-northcentralusazon11010015.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.15])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Feb 2026 22:22:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ee5rPpFxz/PvyYnEK019A5LNyihLZ4Jaz8Itp04T84GOWTnDcvqA16lP6VNAkxmPd7I1iP4BzR3pXItaZLn9frtFmoIDPdCBcw5Q805+A/qTlBWPb1JutPy9w5LSZ2e6+NAI7G3f53CXu3gN7oeP9wC/34H6gcoafOJqUzjs8AJOmd2rrQwagGCCOwgQSdnsBv9an3jF8xyvnROgDbVf9hVcXh88pGQLSurIzYGp04GXS5uncF8RBwm8xZdQ1swxzyYkKn1pNubPAl8NzfP8tPrYVwK+BlIVNYxt3ZqVagGy0+d+cFtdvwKlV2fdTCsnASOMxHgGzTZSxH1OJBqjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDfyxvaMQQprhiwtoFPtZOJXRwH6MQDQ0AVQ8WNi7Co=;
 b=KeSdm4Ae69wv81ccpolHI1WTs5y+ePDZPQSNryQWI63HIz/+xLidCmy6I2bfmuBHt6/tL4zdL/1UvoutU9Ee/KVkWpQr3qL8tLn9JoepUx+z8TPpXa/8V7itGr7/YQIVTno/LIKqO3tIIM0WmuvH2KDYTOdMVNkYEKdtjYFJyBVo20fX3vkR4C7JkuWy0MPsAg3QOauvtKr+H0qaahcGOwm+brV7Rd++flrblJlI/Vm4/Vxx8CRETyts59myxtTmBp0eRrXFCpyhGvja9LlfSWYP9wvceY175prTqyHg8wa4Z40bLRlzx4d95ft2s0YAtHntpQvxgfk5F2p8Nu23zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDfyxvaMQQprhiwtoFPtZOJXRwH6MQDQ0AVQ8WNi7Co=;
 b=A1lv+AIFSrUAtF/3VMktvikvsKeJUR8SMGk9wSKtTGM/K++Mk5sGCJw8kJPqzxqTpuGlXFh45Ofyb6hBw5ry0DXdOtQxhJz9U4l4UYUcNYwtb/Q20iN9QjzifiZGC2pCSydPtkL8mZErpQPo7OqVp8LZuPFlyk+sK7CWAzyhFNg=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by CH0PR04MB8177.namprd04.prod.outlook.com (2603:10b6:610:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 14:22:32 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%3]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 14:22:32 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: HAN Yuwei <hrx@bupt.moe>, Naohiro Aota <Naohiro.Aota@wdc.com>, linux-btrfs
	<linux-btrfs@vger.kernel.org>
Subject: Re: [BUG] 6.18-rc7 cannot mount RAID1 zoned btrfs.
Thread-Topic: [BUG] 6.18-rc7 cannot mount RAID1 zoned btrfs.
Thread-Index:
 AQHcYFs7ICy2wYW+6UypQP3O7Xqwx7UIL5GAgAAJswCABB3sAIANCT8AgADaJoCAGSCBgIARdXCAgAILKYCAJ0XUAIADTtaA
Date: Tue, 3 Feb 2026 14:22:32 +0000
Message-ID: <9d0b0e19-f08a-407a-8708-e597ce29e6a9@wdc.com>
References: <0BED8C36F63EBD8F+f61c437e-3e5f-4a1c-9c18-17fd31abfcd4@bupt.moe>
 <e865d52c-8f07-431a-8fff-907bd6cfb0e8@wdc.com>
 <F24595B65EF81413+dddb8a6c-9da6-4480-b168-fcfa20d3c296@bupt.moe>
 <8bd72651-bad5-4e27-8972-1aa00ceead0a@wdc.com>
 <3BB597E0959AF3E9+275dc513-febd-4497-a73a-61707d2d9e90@bupt.moe>
 <99066be8-992b-4476-9a22-8c1ff6f5cff2@wdc.com>
 <36718DD03AD165EF+c4b42ca9-02f2-41e9-9c43-1ff360a6e73e@bupt.moe>
 <DFH8LGFH8LD8.39G3E2X9L5318@wdc.com>
 <D61E098DC9397C2B+268b627b-a7c7-45e6-b388-c05dec782bb1@bupt.moe>
 <905AE41129A9BED2+b999eeea-ad95-4326-8207-effc149eeae6@bupt.moe>
In-Reply-To: <905AE41129A9BED2+b999eeea-ad95-4326-8207-effc149eeae6@bupt.moe>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|CH0PR04MB8177:EE_
x-ms-office365-filtering-correlation-id: 3ca7c7fa-1b9f-4c68-b99e-08de632fab81
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aVlRMTFIQm1CRDBtYUxFVisrYnZnNC9KYkUyS3dMSU9RamRhZ2JlYTAveTBB?=
 =?utf-8?B?VXl6Ni8rTkoveXJxYlFRT014KytRbnJQWnhHRDA0SnltVHdIOTdFUGRsM2tW?=
 =?utf-8?B?NmJXYk43a3ppY0RoKzE4TW1UMW5kUGJ5RHJ4NXNqMW9kYVNyV3Y2ekdJYWN4?=
 =?utf-8?B?RElxUGw3ZHZDR2ZEVzJxUUpLNklkNUlTRzJ4MlVpWHJkOVROT1M1bUVEdXNz?=
 =?utf-8?B?M1ZqcFBPT0lTZTY0ZlhwSUFRbTdsQ3JHcVM3ZElLTStuNU9UanhrREVpV0FF?=
 =?utf-8?B?ZVhpWXdDaDNhME9kNU1CYVVEUGU2aEhDWXp1bDRLbk5rVEdZWlUrdFF2Nkt4?=
 =?utf-8?B?STBhaTMweXNLMzQ4cmIyMEY4Y2ViZ3QxVTBqTW5HNm43dUhYeWVIVHJ2K0NK?=
 =?utf-8?B?Q053bWV1QWtOb016L0wwYUlDWGNjVUs0eU9LZ0hXeE5MT2NQWWo5b3MyU25M?=
 =?utf-8?B?ajdIOVlGMzJtTUJlNnpPckJnaXYyUC8ydkkvcmN6THk2eE5oQ2dWaXZKTXhq?=
 =?utf-8?B?UUNiTzFmcy90V3NUdVE5TkJXcVZVNHBDeTFaTHRBNGhFbWMxSUR1aU1KdG5U?=
 =?utf-8?B?NHNrcmZTWlRtaEFtczYwMEFjcEhvdE80V2ZIc1M3U0pXT3FNWkdKdEZlNXhh?=
 =?utf-8?B?U2tzUmpHRGVOTXJLNkhpQVVHcGgySGliNkt0MW05V3pQaURiS1RLZjJud1RY?=
 =?utf-8?B?Ni9od1lDTkpieCtKRDVJZmU1aXU2NHBacmJuOW5nTklzZUs0YnpVL1Fyc3NJ?=
 =?utf-8?B?b2Vyd1pPaUNkOXNzdjlrK1pjMjF0b1hzNHhDRXk0ODAzSHdPbU9HU3BuaFdy?=
 =?utf-8?B?ZHdJM1hXdDl5YkRobFJTUHNRV1E5U25veS9INWkvM0VxUE13ZHhkQ2Q2UWlI?=
 =?utf-8?B?TjR2bUtvTUxMVm0xV3NIQVRUTzFCTzlUcHB1QVo1MklTczhvZ2VYeExwTmVr?=
 =?utf-8?B?THE1eHp0ZUQrQWZiVElPSXEwVjlmVFVJQ0pHTjk5b3RMOVZ5QlhxMTJWOHpl?=
 =?utf-8?B?RUpQVjU1YkJicEpsTmdwYURvdThJaElCZEVuTFN2a01qOFo5bzRmVUVUKytx?=
 =?utf-8?B?ekU0YWlXSHBtNFF6VmhEa0I2TUhlcXA3QXpYOUNORnNTOVRGZlhPNGRvSjlD?=
 =?utf-8?B?YmtmaVRWUjIxaU5xYlZmRXhFelY3RWlZVlVmUXVISGxQZDZIU3JZdUM1WDJB?=
 =?utf-8?B?aXFzeGV5dzgvVjNxTGM0Z2JzUERrMUU1R2dZR1piWjhZaG5jaDMwYmg4THV5?=
 =?utf-8?B?NFR3UHd1cTcybzB2WFV2UlBhelRYWEl4R2FYamlVMjRFOVdrOURKSUh0WTN6?=
 =?utf-8?B?V0VKQTFkUHowL3A5UTc2R0VPaFBYNFZEWnhqaGhHSk9ZbWlxbzM5WFdwaGFS?=
 =?utf-8?B?eG0xSUc0bkIzQWhpL3VieUtpVm9KMjdPMEpIYUhQWlRCeVVsdFBTNVR6Rnll?=
 =?utf-8?B?bnhIUHMyRkhIbE5TRTdyaFgwYlVEYWYzeHNCL0dZSkJSdjVDdFhFc01jMGt4?=
 =?utf-8?B?RUNhdS9WbzQ0OVlneVNsNjFIRmdmR2pSdE9Ob29GaE5QM3gvSlFHYkpxNTFF?=
 =?utf-8?B?M1ZRNkVoMHVCUER1WUQyM1F3YWhCR1luNldhSmFta05uVVZvOTUvU2dUUG42?=
 =?utf-8?B?TC9pUkNVaHVob0FTbm5ybjRyWStXN1RwbTZjWEZWTUlLSWFWMnpjcE9razJN?=
 =?utf-8?B?YVdneUNSQjJpZEJzcTBwbmhZNk9FYWMxZWhCZ003aFFnOVNGZWY4OEpRNEth?=
 =?utf-8?B?b1c2M1NRRGxSdUd0YmhUUlBqT3ZEcE9zOTA0NlR3NGN0MEVSbHpMYk90QkpC?=
 =?utf-8?B?bmp0bGFXRVlnMlQzUzNaZlBGQkxtWEhFUFF4TWlrQ01FdENpNzBxcEZYNU8y?=
 =?utf-8?B?ampmb2c1TDBVajJJZDU1R2VWbDRYUW9JTUdjQXA0bkRlUmZDZTJGR3VVbjkw?=
 =?utf-8?B?L1lvSDJ6YVBIYnE4c2c4UlZxaU04RFE2d1JqUTl6eHJVYXlwcEI1ODhOaHhy?=
 =?utf-8?B?TVc5NkRuY3VUWk5VMXc3WlJ5R2YwWXlHbFdRdGE3QmVoREhnNnhmY2ZUSWpE?=
 =?utf-8?B?ajNQcDd5aUphQzIxeHpDbWlZRk5BUHRWUThOZHFrSWhWTE1maHVIWlQ5ZllJ?=
 =?utf-8?B?UjhQSTdxMDN6cHhUMTJpemgyTjhTa3dpMTJLT2RraWtqV1FCdXArZTJPM3V1?=
 =?utf-8?Q?+qurc52XM97r9IKThrCmiZU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rkd2OU5RdlgzUmhlaEh0WG9qL2JEMGtOTEdFaGMvTUdvMTBDYmdtK0toR2hQ?=
 =?utf-8?B?OVFqNUM2N0Y3a0lDSEdlZVgzTFdMM004ekUvSnZBM3Izc1ZDUlRZQWRsRlpV?=
 =?utf-8?B?Z2R4UEZDd0U1WDFva1B1YWdwWHh1MWZyM213NitzUVBRREtWb21Yc1VtSnBV?=
 =?utf-8?B?VmcvcWFFU0k4ZzRmV3FhdVlPWnhiSjRoTHpqeFZzR28zV3ROdHlHaDZEaFla?=
 =?utf-8?B?em1mVVkyNS82Q2gzazMxWkhoMHJmRGJoQnlCcUI4dEFzdHd6akt0WGwrSGNu?=
 =?utf-8?B?SC9OL0htQWkyaE5PYTlXV1JjTnJ3REwrbVQ4M0c3RXllMm9RZmcyWXI1QXlC?=
 =?utf-8?B?ZlVBQU03d2IwS2c5V1B3TUM3Vng3OU9Oc0FhSzN1bVlML01nbXZDN2NTZGt0?=
 =?utf-8?B?NjU4RTNERVFCcWxYcmUrUjgzaDNtVGlMdHJBWGdvbmlGMEtVWDRHVVQzUkR5?=
 =?utf-8?B?R3E2dGhJQ0F1dExPQlhCa3VDTmlTNER5RWJ6RjdqNTNBMjMyelhWb3EyRStU?=
 =?utf-8?B?OG9mdTM0VGxHd0FYZkpzMzBvVERDMTN4QjRqVmh4ZElxYmhXM0ErY3cxRWVi?=
 =?utf-8?B?Tkg0UUZaeGEzelZNWFRuWlBUTHk2U0c5dGM3NHRJNDQ0bER4bnRvdE5IM0Q0?=
 =?utf-8?B?NlpFNWV1emJCLytjbFdQTHd2N2VyKzJxbEdPYXpCdldUa2tnQWN3L1dmeVEx?=
 =?utf-8?B?TGJrZHRUNTBYVzNYeStmUFVUM2IxV1ZsWElXc0ZkZjVNZzd0SWV2UDVYUStx?=
 =?utf-8?B?Z2tyRzJuVGRFRWNYcjZtTFMyYjFqWWJVQjF0K3NRK0JuS05VME5QK2lydDNK?=
 =?utf-8?B?eElCRVlybTFsL1B2S2I1VUQzZm9sNGFXYzVlak5SeWE3MHFYQ2ZVNFAxT2VH?=
 =?utf-8?B?bUh1WVNFb1ZFOHVVMTdWeG5nTGJtVm9SNEpLejB5SzlINEhUVlRYSXJmazBP?=
 =?utf-8?B?VEtYTTA0amxRa042eXBCb1VYMXlrcDFsQVJURTMvYUltM0V2eFFhV0pnWCtX?=
 =?utf-8?B?NmRhMmxINTdTTDZ4dzhFWUpkdlNZMVEyNzF1RTJPY0o2OEcvTldZdUxaN1FR?=
 =?utf-8?B?SDhFbmp0K0YrazhUYUo5TWxMSkxJSEt3RXFxdC9DVDBaMWFJQU1PWWQxRXow?=
 =?utf-8?B?emY4UVNpQ3RyZk8xZHV5bmlvVVN4VUdSY2VDTkxFMkhrRTVqR1hDbDZiOWgv?=
 =?utf-8?B?NklacmxvMkJRcDFoMlQ0dXlTRjdxeWtST3p0UnlkT0YwM1M1NFpVTmhidlBy?=
 =?utf-8?B?RVNpZi8xZ3paMzFjTGdMem5zT1ZueWI0cnV5WVdUV1hsekhCNEV1ZUhyL0FW?=
 =?utf-8?B?dTZwSzAxZkxEZmNsK0JNNWFWVENBT0cvQWgrR0hmQ096RWFyYzdRN1preXJN?=
 =?utf-8?B?YXUyb3NrdlVWUXZpdFFHVkRheUlseHpNSm5EOFo4bC9vM205TVJHZHVCVVgr?=
 =?utf-8?B?MWxURi8zdGVqSWN2ZjBoNjlla29MYmRvcGlESXYvdHE3ckNUN3hhQkxJUVlM?=
 =?utf-8?B?WHdIYzBmQ3RWZW5OdXBDVVdsMldRLzVGMCtsVFFmQVpKbmtQRktzbTFsU25V?=
 =?utf-8?B?YWtXREw3WlhXZFcycXJhTC9kbC80d3UwT0tYRWV3a1UwOEZHak1VMjFhTDBx?=
 =?utf-8?B?U1pOMHMvQ1YwSzU3eVRDdmhBTnJrYmhQMW9RMW50TW5YTFY4ZnlZMDJ4NFdv?=
 =?utf-8?B?ODRybGZZNGVERTlyRDNHVjJQZVNCNDJPdXZzWElPaVlzaVR4ZmdCQzZEUTlj?=
 =?utf-8?B?LzBNM0pPeFVGdytjcGFwbEdxUU01NWFIZ3hZc1hxVUxHRGh1djdVanI2dnph?=
 =?utf-8?B?ZVZackJ3RUFpMkZhOFpGSVBuV3lCTk1kRWZITWl0OFVQU2crR2QxT01hcks5?=
 =?utf-8?B?aisrWUc2UFVHRUI3NTNwQ2N5SDNCVUZXNFJhNTZZNVk5bTZQa1V0eWNIbXZL?=
 =?utf-8?B?UlNWd2RhSDJ0a3RmeXIrbVVDbW9SbEZYdjdQdVF0OUJrY1c0ZWZCK2NHTnl3?=
 =?utf-8?B?d0JGaUNqWTFoLzhMQWJvazkrYUtXTVNnOFZVblBHOUlzY3NJSTl5cmt0M0Ex?=
 =?utf-8?B?RG5tcHU4Q0UzOGJMTysvN2JZSlkyamxCcmw2SWpCWFh6ZUtQL0RuKzgwRmJZ?=
 =?utf-8?B?NGRnWnZzZ0pVem5PSFI2S0dJL08zTklpSE5OT2FBV29LektWa3RrMytOMlJQ?=
 =?utf-8?B?dnVyb25GZ1Q5a0V1cDQ1WkFrV3o3bGJkNkJta3I2Q3MyNWIvVXhCTXBpV0pt?=
 =?utf-8?B?TTVsbFdud1Zzd1hGdk16dkFXcDh1dTNZYnJ2WTd4S1V5b0d2a25ydXdhQmJ4?=
 =?utf-8?B?eXVRUWtGNGRJbEl3ek1mUHNtYTZkYXZuTXlaRDlpeUM3ZFdGa0lsZHowcDZS?=
 =?utf-8?Q?XN6jOhKdwmxhvbAVA9nFI1gBC2UsHgg9TJzyttFuu6COF?=
x-ms-exchange-antispam-messagedata-1: Cfa1oabsu2CdJUB8mrby9bInEExgMkZdojs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB1DC70648C5984FAAA315FA264D1614@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eZF5WdlzkjatBkJHCqzTqzVIVAdmjjuL3CBfj6OCNVEeOVirfwW/J6SUoe4VMrm5ztWNHlV6gmFbS6F0HFS2U6XxsrHmjXqZuO1W+ebNm+GEuxP9HvnlMPTub7Hs/QbReznumMvCnBaGJaQYipzDVNwSkwVg8wYksEkqABB5/07s6kiZxPZVjDjlEqJTm1KCJYXk40DFUEQzl68mvntah2DCltUO5hv6UBX7z89Ly2kEjznjjIGcymq3Mq8gpkwUKaTjTlRuru4niwQOzcoGg5Dud8hWM7DsTvchyb0BA/5MeO80X/WS+hiidOK3kpSTbKn4Z2fpZdaIkOxdpWB6oHCudmOmdE23iqRIXv1eZxk7+Rl1O3H4jM6X5aG8PjseFpSYmQJyI2em+n4jS2PViwr7W1VN+SJplEanzNoZSBTe2eQ3HubZD5ov7mjyy6NLdolcGVPRMjuwEL/g8UkxXlb2LPipfZEveNiIjsJFlIQ8COXiHJTf/OF3UCVGQlBcJ0Pb+N67n+ALwaFzZbK8y/tQTnip47cGdBQBk56u6DbaUWGI0qyWFx/hrKy8G2Vne4erHGSWvou3YkVbHb9yyVRWLErfmtnj/M7QAb+REtyvsMjpPmNEPwfcw7VWsVQ9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca7c7fa-1b9f-4c68-b99e-08de632fab81
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 14:22:32.4965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ROv9Ie3+mPg/PGG3ZwNbzti3l6BdmOamGSZgZlxEnDGt0Omu5XTFg3/vYSO9DF9+C35b6NVvy1oxMWmXcmzpwzRKzGtZdbHuJ5bvCGwvkHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8177
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21317-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sharedspace.onmicrosoft.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 36035DA864
X-Rspamd-Action: no action

T24gMi8xLzI2IDEyOjUyIFBNLCBIQU4gWXV3ZWkgd3JvdGU6DQo+IGJyaW5naW5nIHRoaXMgdXAg
YWdhaW4uDQo+DQoNCkRhdmlkIG1lcmdlZCB0aGUgcGF0Y2ggZnJvbSBOYW9oaXJvIGFkcmVzc2lu
ZyB0aGlzIGlzc3VlLiBJdCdzIGxpa2VseSANCmNvbnRhaW5lZCBpbiB0aGUgMXN0IG9yIDJuZCBw
dWxsIHJlcXVlc3QgdG8gTGludXMgZm9yIDYuMjAuDQoNClRoYW5rcywNCg0KSm9oYW5uZXMNCg0K

