Return-Path: <linux-btrfs+bounces-15452-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC4AB015F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 10:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBDBD1CA032A
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 08:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D960F23717C;
	Fri, 11 Jul 2025 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="b2zP2qUG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SSyqyrNG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D654236457
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752221792; cv=fail; b=S+AcuO3S82s+lCnZ3/oTGnxwo8SUKAempmhtmRlR4Ogr1J0PrI4tTZoLx4WLyUiL4wCu7rT0wE4bTSdOjHiFyQQqPhgPf/9LnHm5/UEIWFg5BPP3Fur4VXIOdOAIr2xBTTKIYtXU+DkRDj7NKKN/kapAsX6CWoRLle5ATRdobio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752221792; c=relaxed/simple;
	bh=FevsJQwrP8Gp/5KRfFBK7oELUdDsw8R35ACnY6NmPUs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IPY1qA5pOEoxScoANIDCoFqBM0I793k8Nv4StjuBbN10mJCVYACYbKS/e1kOllcXvNb1QibHIdfeYnYcf766+cTSJKWNW86wEwVbfgZ5l2zKstJWoUgeYXPhv9BGbdChEQNRknc/V1L3ny/Xj+oJEVDczpWa/MiMU64rgvzJmDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=b2zP2qUG; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SSyqyrNG; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752221790; x=1783757790;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=FevsJQwrP8Gp/5KRfFBK7oELUdDsw8R35ACnY6NmPUs=;
  b=b2zP2qUGTZmuu0YkWMjzrtX0XmRdcGtYHSCZtBf1inVv3WdtNiT1hw7r
   D94U+a0xaYZbNjL+BTV28OI7NjVBWwVD8B/NmhQmBO70/Hcz1VOU0T/b5
   DT7rQo9kc1zMQX/hS1YMapKf/gJbil1Go/reDkw1pdrGDmET642PGksvI
   EJdn+flQiwfS0r8iRt2wTKWEyETt0MBP13VPoPaUXwb0nfVuMl1irzMLU
   AKiwS3ZfR/kxf+CXiARxdL3VFZkVxC4/VDDzgmKzvL6mvNWkXlHoEonmD
   WZUSrBPAvQIkKBJJy+K3OQWFFjs3ibqhciYiSPnM5xD+KrrUZU2P3DKPl
   w==;
X-CSE-ConnectionGUID: TkAPsTboRd6fxIQlGE4ZAA==
X-CSE-MsgGUID: jLxiCtNKQE2GmFCP5ScAmw==
X-IronPort-AV: E=Sophos;i="6.16,303,1744041600"; 
   d="scan'208";a="86374164"
Received: from mail-dm6nam12on2060.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.60])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2025 16:16:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkpoUKHpIaeHxdT39hWqeV+YSVBJeZhXbTAa5GtMKaS1ibilWmn5iYfhDlPKG8Gi5PiX/pPHKv5cu3vCnvkM932K93LWCaDYf4G5C9PNALP2s3k2Y2DiW0tmpWZVmsQBIoMtgETHGX1ztTyyVZf26pXqiSnt6wUk2vRuTLBf3dCnsSkKSAttbmz3G8nxUR+QWwjHlW8ehSDryWJsMoHDW7eGOPRxKMfqHvrbMDRCrtTQRXvJTY6LZEz7BbDb1FeE5LTuApEJnB8xpv4518cr7wexVroWAGjlt0jIkCZB20xLObazX0tloXnt92Jvij46iTyNQblB47XrtflUAdJf6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FevsJQwrP8Gp/5KRfFBK7oELUdDsw8R35ACnY6NmPUs=;
 b=RLKokg9DG8yUDGyVQB4dMLOsulFK9LEjFbjgMg3FjQMy3jBJRCmMst9jz8nCl1wSI2Ocy5V7WhfINaP/qRLc+t4AZot+2BVrNXdPC1u0oFuqbF7RnzYVbwtTkPdS8c1a5Qz3MBSaWOq+KV+eHR0fJeEISDMdlAw/FsTA3r/xEva1u5d7mkGKviMNimXFPz3D/Fkfon+j4pafI/kaMwfsHG33o6L64u2xldpe/RqPn30bJGyx5RHlQAmrIKZ6Jb0P7wVhO9Ko91H4Q3hsZmRXplJdAnGPrn6N9HLadNbPp6jicwHCayQMOihaGDdxKHg+m15dG1YWzmSbfXSez5OREA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FevsJQwrP8Gp/5KRfFBK7oELUdDsw8R35ACnY6NmPUs=;
 b=SSyqyrNGBgnE/Y3PmdSidZoAXPGtYniYfpHfHbNbMQR/som/M94Eucl9PbOQW1zsVkwekKZurwYHeLRn12+3inHgMSk7mASA8pjZ+3ceCQBwmawtBHH7xxlVwiaSNSthNou9UQa42e/2NSEhM53BIju2/WEn+gIjtS5lNmx0E+o=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by LV3PR04MB9152.namprd04.prod.outlook.com (2603:10b6:408:27a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Fri, 11 Jul
 2025 08:16:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 08:16:27 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] btrfs: zoned: fix write time activation failure
 for metadata block group
Thread-Topic: [PATCH v2 2/3] btrfs: zoned: fix write time activation failure
 for metadata block group
Thread-Index: AQHb8jTaIYS8EMlTRkKQiVLzOTbOBrQsk8iA
Date: Fri, 11 Jul 2025 08:16:27 +0000
Message-ID: <8d296e0d-940c-4f4e-86d8-c074cabda68c@wdc.com>
References: <cover.1752218199.git.naohiro.aota@wdc.com>
 <aefabcddbc2038246813704a1c8bb29a60eb1e9c.1752218199.git.naohiro.aota@wdc.com>
In-Reply-To:
 <aefabcddbc2038246813704a1c8bb29a60eb1e9c.1752218199.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|LV3PR04MB9152:EE_
x-ms-office365-filtering-correlation-id: c1b5693e-938e-4a75-5eb0-08ddc0533bcd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yk5GRThYMGUrdkF1RWdUSHFiL2I1WDBlS3lHaklSRS9kVEhObkEwQTdEeEN1?=
 =?utf-8?B?N2NzSDVpL082bndIK1pBMlV2amJTeHlRVTIrNklPVThDSEFHOVJBZVY3MGl4?=
 =?utf-8?B?alRWRVMwWGJIVnZiTDZBRG1GN3dvNHZBdmpKejNLMVE2emxzUzVwRTN3K1A5?=
 =?utf-8?B?WjJkY21RYWUzd3I3MnpSd25adDg2RFZJZWJtWTlWaGRqOVZEMUE5Q3FIYWRS?=
 =?utf-8?B?dTV5ZXNGQjlVUkVSMjI0b2pMQzJrMTZqb1ROWUl4RzB3NGIxeWRUWU96YW5h?=
 =?utf-8?B?cE4wQ0IyNldEN1hmdDFGczljYzFhMzlFS0Y1S1BZaHpzTFN0NnFYVUkvQzZa?=
 =?utf-8?B?NFVDdk1zWWViK2puMjB3M05FeGdUZGlZcXVIU3NIdWlSYzRrcjR0SjdwMVJv?=
 =?utf-8?B?VFZVRWllMzlZWTNBRmFIYWoxSGZrTzRUTmpCdnpNQWlNYU5xU1RrZHVIVTdN?=
 =?utf-8?B?U1BoUjJ2YUxZK3dDR0E1QkkwTHg5RmZzQUppamFsQklrSjBOOVhTZUk3VUdw?=
 =?utf-8?B?dTJzVm1uM1hjNnhBMXRld2pQN2VZMDdKY09Tait6bXJUQ3NQSElDL1JBNmRH?=
 =?utf-8?B?eU10emdTbktBUVppUXdIbkxVQlFob2tOYjRNTnRIT09mc1AvYzFHcUlZYzVR?=
 =?utf-8?B?ckNMVlJFR01ZQkUyOUJPeFkzMzRMU3M3cHIzdWhhQkdNQXJRNEY5QnZyeGZs?=
 =?utf-8?B?T0FSOFNlQTlJS3M3WGZqekNJRjU3OGxUQnlPRTBMUHNuRkhrSWtpUDBKd1R2?=
 =?utf-8?B?OFJid2tyQ05jNW84ZEw1eklhZUU5cFYyVmY4dTJmSnNpTEc0NTZkbG95R2NR?=
 =?utf-8?B?amM5a05DYTNsdWx1YWRZUGJQbkx6VjhjcHBHTjN5RE1WVFdkUlJYS3gvakpQ?=
 =?utf-8?B?bzVWSHo1eWJlaFcvbnlSOEVndFRCS1FncEpWaHZLYWlybUlzNExNcnovQ2xZ?=
 =?utf-8?B?aUc1dFVXSE1YQXZnNGNiNjRzMEhMaTlPaGFxOHN2VEwyM3VCUUVjZFYrWGh1?=
 =?utf-8?B?alQwQTdtam9IK3h6V0d0UDhjY0E1TEhMT2pTVTlXbTNDT0dqbW9jaUNBYStw?=
 =?utf-8?B?TkhsUko1OWVXT3Zyd2FiMUJQYXdKRElIOGlKRzNqSU9FaUhhcFluVnpTelpp?=
 =?utf-8?B?aGJ4Y1RzUkY4OElrOUh1QU1yWjlFcmNrblZEbEQ4VjFuK21BaW1IZTlBUUth?=
 =?utf-8?B?WWVlR0thMFVrNnE3L2o2SWE2dEtSTGxERmorMlF6SGROU3NkMnFXSm53UHg3?=
 =?utf-8?B?b2ZMV0xxcHVoVnU2Z2JSeGFxK0FtRXRpM2JCUVBBbTBtMTB2b0tPeVdjQ2xN?=
 =?utf-8?B?ZU9oLzl5V1JrbHp5Q05qb2NKQkRGUXVGUDlWck1HcGNZZnEvckl6ekFrQURi?=
 =?utf-8?B?MVRLbmhpUlFYM1NWWjA0d0RGSnQ5WVZhY0Q0MFRNRzdGZ2tabkhyOGN0bWFo?=
 =?utf-8?B?MVV3anU1R0JYclhuSTNKdUZjQ0RNTmpxTE9oaUxIUytmT282TUhhRUtyNlE1?=
 =?utf-8?B?ZThtaFo2VzIzSWgxaXpNRjRic1JPcDRGeHlSQmlYUFZEaHQxZnhnWkpaRCtU?=
 =?utf-8?B?eCt1eVJCMWlJWUprd0pHUnZpTUY5YnpBaFpJMDhHTTNtb0hDY3N3dUZ4NmRN?=
 =?utf-8?B?UVM1U24wQ2ZPU1AxKzVYeks3TkR1dGhvbzFwanZPaWxUSFBnR1NZd3pCRGp4?=
 =?utf-8?B?eWRVWTg2WXloSkw0bnE2Q2wrSUY0bzJEbjVXdzBTYU53YUFPbjVjbVVsb2hK?=
 =?utf-8?B?WEJwM0xEbDlUMkdQcmRLOWE0UnF1UHptT1BXV2kvWDViUlR2TzhvTHFuTG45?=
 =?utf-8?B?d2piN084dFg2cmp5VE1zaXc4ZGIxUmdGS1hSUEpLenhxRDVkYzA2ZHB5NDZQ?=
 =?utf-8?B?cXFFL2tmT1c0bXg2c1puNFIxRWtsWFlBTEF4WFQvN0RpZFF2NU5LeXA1QU5V?=
 =?utf-8?B?SnRYTDlGQVF1WDJxdnBpVFZPS0FsUTQyayswUVcrVWhzcWtJYnBKSmR3S0ds?=
 =?utf-8?Q?iMzvQzR8Wt/fw1S9SOUd9VJxTYcPJ0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWRKZnlac056WFBSaWN4dW9jcllaQW5oMzhpNHo1UWdIVWZoS3orLy80MkJp?=
 =?utf-8?B?ZVIwcmpvWmQvT1Y4VktmaUdxRzJoRVRJUkMwS3dTOWYvbFNObTliSkwyL05k?=
 =?utf-8?B?Y25lU3BKTkR0OVdHOEJZVUpWMWZXaVZhY2Q3WDNURnAvSVRYYXhoSlZ6NjJS?=
 =?utf-8?B?azUwNWFPWS96MTVzcG4xL1VUcFlwZ2o3cHBFenM1dnc3L1pZbklneE12Ujgv?=
 =?utf-8?B?NHo4bk5XRDhyVTJlTGFxOGxOVFAycnpTamZBM0h5czFaS0J1d0ZkSVBWSVky?=
 =?utf-8?B?VHpJbnVnbG0zQ3VGNldoSXlURjE2ZUFseE95ZDV4djlCcVFNb3A1cG5ra1pk?=
 =?utf-8?B?VlRkcFpqeTc1OWYxR0tuYUJnekZzc0NhZ242dXdCZDk5b0pubWpXV3dNZVVs?=
 =?utf-8?B?ZlRrZk11dUFjdEhWYURPMGxPYXBSYk5oeElqd05OY1NRN2xHbTBqaTk3c2Jm?=
 =?utf-8?B?REswM3RJT0NYWkNtcXJkTk0vbGc0aGtwVDNUM2l3VGozUWFGZG9SRHBPMlZK?=
 =?utf-8?B?ZlVYYVBmejBQb2tpa0grRjc4M01jQTlMRDhRY1pFcWFFSDJIc1FBc25scHJq?=
 =?utf-8?B?a3pYdEx1dVZNR21BcFl2bnMxcVBoUkM3cUU4YnJwOHJsWnloYmppNHhEMWtm?=
 =?utf-8?B?L0xGeVRnMWcvWmJuOUp3RkNJTUg3YTh1UGVDUzN1VVZkank3Vk9uOEhhczNT?=
 =?utf-8?B?WFRuYTgwTC9nV3B2cGM4UWFHREhFdjVmVHFiWlYrdlJJV0lTQmQ0elg0elBl?=
 =?utf-8?B?dU5ram5FWXR1MzZualM1ZWhpMTB1dkhCV0wyV3JEa045V3N4a01xQS8vUXhZ?=
 =?utf-8?B?Wm9sZTYvcXJQaDB6OGN6aXg1VTBzdDVxcEhmaDdWWktTVUNBUW9jWElYQTY0?=
 =?utf-8?B?UkN6c1QrWElOUGtaL2lUc1BLRUFVcmxmQXZsNGJpQng3cS92UTA3RVFkc2V2?=
 =?utf-8?B?bWtyck9PNkhmVFFjbmE4aDhVNXRJekQ0MlREaXJDZSs2c2JJNStjUTBSZ3BH?=
 =?utf-8?B?bFFvbDBLd3ppZ3VyRm13S2NIWjUzQW93Tkx3NUorVXh4dUdzd3l4V2dKNnd1?=
 =?utf-8?B?VmFVTjUzUTNkb05IT2g4ZkpwVkZNU2lXeS9KdjlwTloxNjMraHYyRFY5ZE5D?=
 =?utf-8?B?TUhMei8yalpjcDJPSWRML2dKN3l5SUNLUHJjdUYzSUgvUWthOWpoUHB4eFNE?=
 =?utf-8?B?OHlmOWF4VWk1UzBkR3JLK1dWSkI0TVkwQ0c4ZzZ4SHJVVWswZklXdEhuakhY?=
 =?utf-8?B?MEV6UmJHYmFrN2ljR2Zqa2tXZWxtc042bjkxVHZiMFlVemN3ZTNLclhSaitX?=
 =?utf-8?B?UGREbjFqTGpnV2V1QjZFSGd0V21aU3A1Yk9uR2RnU1puVEU5b3lxY3hYS1N0?=
 =?utf-8?B?VTdmVzR6TEtEV25HNk1qbXZjSmhLcW1VNG90VGNveXg1YzlEZEVyUmlGTE9B?=
 =?utf-8?B?a25HbDVhUDdCOEJjMk5HeGpNcnRmU0Y1ZlVXNXlDeVozTlVCU1M1T3FwVDE5?=
 =?utf-8?B?eUlvZVZjUnphZEZqZDJTZURwTjk5Z3hzZjhNWE5Mc282NWhicnZZejg4dEUz?=
 =?utf-8?B?S3YrMEx3RnVYdXdFUUJ4WFNPZkdlVFlmemxIM01iWGE4Z01wRURuSENybGxt?=
 =?utf-8?B?cExkS2tJck1FbFRiNWMvbHVPK0xpazM4aHIvdUE0dGFDY0FnSFhzMXF2SWRw?=
 =?utf-8?B?MWJDYlZRQWIyL21QdGpwWjBaREVLQXFmWm9TaWh6dUlvTEl6Y0k0Tk9aOElz?=
 =?utf-8?B?aTl4QmhzZm8zbmJDZ2cwZ29LemY2QjNGSElKelc0NVdsZXV6Y3ZOUVpPL204?=
 =?utf-8?B?MU5NbGNHeHIveXhtaDU3VmxwZ1RuVEJ3bVYxOEw0SS9peFZMSGYrRHp1VWtH?=
 =?utf-8?B?YUFFUGtzOFRLb0FncnArYmp0WmJ5VWIyUXNPVDNRQzF1UWxhdnNEUFRHYmV4?=
 =?utf-8?B?TlZPa1Zta1lvdEVuYzVXcEE4VEtKL2dxaGwzcWZMeWZ4bVViL1ZlN3A0dmd1?=
 =?utf-8?B?UU5uSms3RkpPN3BVOXhiNStrVmthMjFGREx6RTN4QXMvRXVlTDJHMjJ0MTFi?=
 =?utf-8?B?bGEyRTg5UExjN3k1ZFpkbXFqOHU2MENZdG9UZ3NNSDlSUzI3QnZHejRaMm9p?=
 =?utf-8?B?VnpzYjh1Ny9PWU1ueklic09GSmM2STBmV3V1bWFkM1hFdHp5Mm9zc2lhWGw0?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <133BB25E7A68114FA0BE504E4499D159@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bnp3IrUfdOkICNgnjsLbH4y+n7uB5FpXKlxE9ya+HrWkS1PySjkWvcEDVUXH97tLhXbBb2BFy/E9CkZGfMgbXycdi9mV3lCfC/iaWLl4xf63oQWCVIXj4mIN1Gh1rJsiTQROHL3JEr2uMfFWPWF6jrrS2FAIsnc0wIyV7wKWBIoGdgloBfBOOp09zCYm0g3uZs34AHtWBZkvPL3uBxXXmjssAr+wpQZmhBimnk24766PUgePB8QY71qH8F/HOtncZSFPOUz6Mg9wzgO0rX7gIYi5seD+CJMFYJ+NdwdklcKzlRk7leFRAwHMHkVZt9UXx2EpmBk0qrhzTjUJ4SPhFvQ4IJTHJ4xCP0LQIiVuzYEAr5G4d46fnIaBperWayz1IxukmrbhtTSBfnLjNEcDivdm72czklzahvuEGoHxzLhPkcpDByAehQfNayo1EAa8ycFmCXPV6F+pAm1sBWcmJaz3M7dgZ+o5nKiEqAM/OFYf9crV/tc9i3NLwce0VOn7CxTgKmCKA6kPTMt6nSLadXa+fQSxCM01/mpgwj59QCio6zHUPdtO56Z6wjQl0mXJ7A9LPnTd0tBh0MS9vkqLy8/7SOw1kA57wIeuPx+p++XsPrJrwXlm5VZofLpxEC2j
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b5693e-938e-4a75-5eb0-08ddc0533bcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 08:16:27.4226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+mmBX8ijuGCnuU/rZeRTkGnVQjSJ+rDaiE27eqSeU89Bvbls2xCoOq7SSOM1b0kxOnGakwFFSFJ7R2Rsj5RXop/7YZvzw6v4u3o+pNukxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9152

T24gMTEuMDcuMjUgMDk6MjQsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gU2luY2UgY29tbWl0IDEz
YmI0ODNkMzJhYiAoImJ0cmZzOiB6b25lZDogYWN0aXZhdGUgbWV0YWRhdGEgYmxvY2sgZ3JvdXAg
b24NCj4gd3JpdGUgdGltZSIpLCB3ZSBhY3RpdmF0ZSBhIG1ldGFkYXRhIGJsb2NrIGdyb3VwIGF0
IHRoZSB3cml0ZSB0aW1lLiBJZiB0aGUNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHMvdGhlLy8gfl4NCg0KPiB6b25lIGNhcGFjaXR5IGlzIHNtYWxsIGVu
b3VnaCwgd2UgY2FuIGFsbG9jYXRlIHRoZSBlbnRpcmUgcmVnaW9uIGJlZm9yZSB0aGUNCj4gZmly
c3Qgd3JpdGUuIFRoZW4sIHdlIGhpdCB0aGUgYnRyZnNfem9uZWRfYmdfaXNfZnVsbCgpIGluDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKyBjb25kaXRpb24/IH5e
DQo+IGJ0cmZzX3pvbmVfYWN0aXZhdGUoKSBhbmQgdGhlIGFjdGl2YXRpb24gZmFpbHMuDQo+IA0K
PiBGb3IgYSBkYXRhIGJsb2NrIGdyb3VwLCB3ZSBhY3RpdmF0ZSBpdCBhdCB0aGUgYWxsb2NhdGlv
biB0aW1lIGFuZCB3ZSBzaG91bGQNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzL3RoZS8vIH5eDQo+IGNoZWNrIHRoZSBmdWxsbmVzcyBjb25kaXRpb24gaW4gdGhlIGNhbGxl
ciBzaWRlLiBBZGQsIGEgV0FSTiB0byBjaGVjayB0aGUNCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHMvLC8vIH5eDQo+IGZ1bGxuZXNzIGNvbmRpdGlvbi4N
Cj4gDQo+IEZvciBhIG1ldGFkYXRhIGJsb2NrIGdyb3VwLCB3ZSBkb24ndCBuZWVkIHRoZSBmdWxs
bmVzcyBjaGVjayBiZWNhdXNlIHdlDQo+IGFjdGl2YXRlIGl0IGF0IHRoZSB3cml0ZSB0aW1lLiBJ
bnN0ZWFkLCBhY3RpdmF0aW5nIGl0IG9uY2UgaXQgaXMgd3JpdHRlbg0KICAgICAgICAgcy90aGUv
LyB+Xg0KPiBzaG91bGQgYmUgaW52YWxpZC4gQ2F0Y2ggdGhhdCB3aXRoIGEgV0FSTiB0b28uDQo+
IA0KPiBGaXhlczogMTNiYjQ4M2QzMmFiICgiYnRyZnM6IHpvbmVkOiBhY3RpdmF0ZSBtZXRhZGF0
YSBibG9jayBncm91cCBvbiB3cml0ZSB0aW1lIikNCj4gQ0M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcgIyA2LjYrDQo+IFNpZ25lZC1vZmYtYnk6IE5hb2hpcm8gQW90YSA8bmFvaGlyby5hb3RhQHdk
Yy5jb20+DQoNCk90aGVyd2lzZSBsb29rcyBnb29kIHRvIG1lLA0KUmV2aWV3ZWQtYnk6IEpvaGFu
bmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=

