Return-Path: <linux-btrfs+bounces-5610-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 021149023C3
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 16:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DABB1F21D44
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 14:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3867823DD;
	Mon, 10 Jun 2024 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZkFJq8bQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="We7rrlzY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B984115A8
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028791; cv=fail; b=UiaQm7mh0Y3Iw0ouXdBNWGVqfSsZ1I93+3Xee/HmYyBaWY2mi7ZSPIksHuL8kBclwohYIq+/Q6hbKXh1pMPPWBKxdiChBP8p+Pa6D987uUsfeh37DJRDgkDVS4uUSrFHGJqH26WUXdeP9/XCzmKz/lhYsesB74uPDMEkMncWhmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028791; c=relaxed/simple;
	bh=y/U7PThMgz3zryI83I6GCZD6nW+yRn0/yTOgS0PO0rk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AOuknHKojeaNf58XUQBpadn8kNsTuRQi7e+JFc52MImHlopqmz6+HHa15Rnw7ne7mFN7p1mGDEggHWSRxW1ulkznepVmUkcf+cFsRoiSxWVXb5Hv19SWyC/74/UX4A9WpF7HX0oEQb0Ec5d2oU/ApVN6XIaiIPdHO7w5liEuaRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZkFJq8bQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=We7rrlzY; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718028789; x=1749564789;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=y/U7PThMgz3zryI83I6GCZD6nW+yRn0/yTOgS0PO0rk=;
  b=ZkFJq8bQY/YBlrbHQcAq4AXmlxVIzgRSCsJS4DKtDXNYDNeGH+RbXw/o
   iMoa4ns3j5ncITrppXpoNFtAZvcCqDSQNvnkNrSVFNcY0eGDE9B8nBRSs
   fl9rEQKlxQBCJRgw5GRBvjVs+coJA+ePwl0miGxzVr+ypQqGm4uwhsXu+
   R+oqSPrDYjFiPWi6IpRd16W0QN8373Jbr68iiQRPC9RtrEhrUe73fj4LA
   0mjl5EnGH7jQLsmC9P+LAsMTwZQSGmL3BfPRHE/xUe2BGU89/IsCJqFM+
   s2A0n5NR3FlaLTKDVRQ6cLjAatG3VS8Po775eRcrPch2TkM+pxl7tOspq
   g==;
X-CSE-ConnectionGUID: +rLIG+yfSYGlB05ziVpxiA==
X-CSE-MsgGUID: gSr3EJXYT9ydusKNQkRavg==
X-IronPort-AV: E=Sophos;i="6.08,227,1712592000"; 
   d="scan'208";a="18748433"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2024 22:13:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KloTce+Fb2HeDlyUanzEpx4+GR0PGJzB4W0JUNL+Wl1Oax4H6SXa/RDouGBqhjIG00GRNz6+mCwqexSYHFZxrrtxeRlWTprjigaCzulyTxX91zeJ58B+CYmIYKzfVDVChtPMIWxyOQCHxF0dvS6eId5sCwuuAi4jutpPy0aczeaH5nTnUbmxKFlpPkD0DFQUq9hAyo0PD5T7uCHHL1Mr7GNvPgRAZXhErH4RBrqop4egfGLg8Fy+KqYhjWnvzmpLDBHkTIDnStBExw9EisCH0J5dkMMYJWeE/4B7C8fe5g58EUz7sdn3f25hLb6l+d50VuqU4IbdhWo+r5yK7WNiTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/U7PThMgz3zryI83I6GCZD6nW+yRn0/yTOgS0PO0rk=;
 b=UWThsKkNgyX9quZLdAcmzEvy94ohup7PBj5+S3qRzX/wz05RmSB88OlurSVtqdyaGJQGii9ub7gzLdYtYUKoem2h6obqihwMYQCgPdmyysWWlE6CUj+s5eEGfYn8OIP9BXvZ0ROErsGVj5VHtAq/gqf2zabhvHYgo4Au8qmnc3z9q3XUNfDZJoRqXTqH5KqkRL6gG71ILFYyjgHxu08u88IZ1OVNVCC71WjJDyDGL3z5KTodKIaPw395Eu7AlttM5uko6oTx674uAxnppmJeVosSH+icMfranRS8D4ozGkGne04x7+xE/2sT+Kaihq7JCFg4hMhdXZ6LuHvgHlIe1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/U7PThMgz3zryI83I6GCZD6nW+yRn0/yTOgS0PO0rk=;
 b=We7rrlzYHOUlU6Im0Pv+KbvEOk+6FGPijyiF2af5PCvxZGFmeCsfN8rx/+XbEKxuIDTVRhHrK7wtSkjo35YndpEQHKJ1N1vNqMZxji08KziWnm4YLsfslOOp36/NcrB3LN8dHsji989ufSUzKkBlHA+qP0T1pQykPG2owh5S+os=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by PH7PR04MB8610.namprd04.prod.outlook.com (2603:10b6:510:242::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Mon, 10 Jun
 2024 14:13:03 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 14:13:03 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: HAN Yuwei <hrx@bupt.moe>
CC: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [BUG] unable to mount zoned volume after force shutdown
Thread-Topic: [BUG] unable to mount zoned volume after force shutdown
Thread-Index: AQHauhQsmv0fbKENMkOXQ7kamM5KpLHAszgAgABBXYCAABfeAA==
Date: Mon, 10 Jun 2024 14:13:03 +0000
Message-ID: <pidc6y4h62zt44c5m3rdwqbfauik5xtjbijoe6oqmqnkeig2ky@wfxoqxp6rvt7>
References: <CD222A40B0129641+992beaf5-2aa9-4ad4-bb3f-ee915393bab1@bupt.moe>
 <ab92f3bd-c1ca-496f-bcf7-d806459d9ce7@wdc.com>
 <2112398B543F8373+1a8c3746-b3f1-436a-97b1-debe2682cbf1@bupt.moe>
In-Reply-To: <2112398B543F8373+1a8c3746-b3f1-436a-97b1-debe2682cbf1@bupt.moe>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|PH7PR04MB8610:EE_
x-ms-office365-filtering-correlation-id: 1ca3f035-cc8b-43d0-5690-08dc8957712d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?aTQ0WnM0cCs5dU9VRnV5UmNQeDRaUWdrNnc3dk0xVjh2a2NET0xzY1pkYnRD?=
 =?utf-8?B?allEL2RhYjFhSC9xSmlNZS9aRXdzWTgxSnQzTmwzeTFmS2pXWU4zVkdZejY0?=
 =?utf-8?B?dnhERTRZdXN4QkFiUlR2SlNSV2ZVUEN3OHdVWTByYTkvMzNac0dsbUNJN3RH?=
 =?utf-8?B?MG1va1RBa3prZ0RjaFlheGZIcmM4bmlKSm1TSm9hRG9ZaEdPU2tqd1VZT2F3?=
 =?utf-8?B?NHV4b0JadFB2VFdKZTdkRUtXSjNTRnVudmZkOC9DQVBSUHNISjhheVN0QmJQ?=
 =?utf-8?B?TFRSSmQrQStLRzcrMHk1bVZ5WUoyUEluR1cyWk1ERnFZQUs2MzZVMm5DNTNw?=
 =?utf-8?B?YnBVZFdiNzlFd0kzdnVtNmNXUDR2ZXJQeFZLdGxzQVVtbTE1eVhobVZjL0l6?=
 =?utf-8?B?bWltUzNrd1dLVFByTFFoN05acVIvSDFVL21aU0NtbFozdTBHR2ZvY0JLd0V5?=
 =?utf-8?B?UFNUaWJydnFOR0QyRXBHWUltWFdXOVplQzBtakZMWmxsRzJaYSs1WCswalpG?=
 =?utf-8?B?UFFQY2x2OFdGRytYYXhhVWdhak81aVZDMFlESGxtV3MvUHVMczdzSU9jdWd6?=
 =?utf-8?B?VWMzZVZuU0VYZ2ZMODRDRldGWjM4U0hsaXdGbUJMZTJGV3g0Wlg2RC91RHR4?=
 =?utf-8?B?c1NZR2QxaFhxNHUvcStvL1Y2dEpCWkNXNElzQVRhbkFtVDhPZHRiVkY1WWNs?=
 =?utf-8?B?SytncUNjeGxrYWphUFh1WUVGY2ZPYlUrZEtkOTNRZGVFeWgxbHJNNk05QVNs?=
 =?utf-8?B?T2U3UEJaRXRjVUxqMTlxSG1CQjZTYnZKY2hsMTE1VTUwaHg2THpobE5VaVZl?=
 =?utf-8?B?d0pTS2VyV2xkNDJ0QVFvZzNIRGNnVnpaOE1xUUd0MzlUUFBmMEhkcWZvWStS?=
 =?utf-8?B?YUZwWDlxN21YcVFLd21PL2twMGRJemx5S2tVS1h6alNheEdERDBmSWZKWW1V?=
 =?utf-8?B?dVA4dVBkTTJjeVliakFnNGl5WEpvM2dyeXp6TnpHNFdGeFpiaXMrTk1td1ZZ?=
 =?utf-8?B?aU9ZczFqYkd4UWdkQnhMazIveTE2M3RuMTlGTUhjNUVidko5TDk2SkhieXBz?=
 =?utf-8?B?UkhHangvWFdtbnRlU2QzNVR5MU5hMkt5VWFLQU0xTXlOaHN1ODhXMVBUWVo0?=
 =?utf-8?B?eTFTT25haWJJNXRUSzlZbVJLYkFQYjlPdnEzQzZHS0JFOEhrTlBrTGw4N29h?=
 =?utf-8?B?a2JVYTdDK1VRNEpnUmdtZ2NzUjZMajJKc3RTMXh4aGhuWTJrejJQeHozY3Vy?=
 =?utf-8?B?eEtJWFJuZU5xMU53eUdQSTlxTm9ieEV1NHZndkx2M0JrWnpDOVJYMXBUREVN?=
 =?utf-8?B?eUw3anFVcGtOdzJjZXpTdjJJSHVQd1lTR1ArS1VNUmhMYmRRVS9lOWI4MW9B?=
 =?utf-8?B?RGxtcHZCL3FyT2FCMjdlN21WcFFyaFZYNmU0ZTFmNzY2cGxvRGVJWUlDcUg0?=
 =?utf-8?B?WXg0VkNzaGN2UVNWQmI3eVlSRURZcnhSMHNYYy94WmZYQnNYaGE4azlwNkJp?=
 =?utf-8?B?clpOMjUvMEhsanZrU0RqRy9hS2JpNnRGRUZiUEF5cFl5dEI4cmZsbXQxclhz?=
 =?utf-8?B?blhoWkdOWk5XVXRYSndvanhGd1FYN1pRaG05RGJ2QXc4Uzl1QmtQUWZYTlRU?=
 =?utf-8?B?UVRtS2NrcmtQbnF3NXRyZjdaUE9sYU9HYnZLRDVGQUZLd2t3bm8zTG43YXRZ?=
 =?utf-8?B?TFZNR2lITHJmWDYwNEZubW93Z3JiMWpsdXk0OG00WElzY2xrRGhZRjV3UFND?=
 =?utf-8?B?bWZwL0hkOFFXSmNESWFaN3ZZUk14elk3dXV1UWF0NGNGdjVEWGFFSGludEdv?=
 =?utf-8?Q?8t7/U2/VXsOXYOBouJ4VoiSzCoFLcUTYebvg0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ai85RzdwMVJZbjF3R1M1Q2hJWVB1UFI5VEpLZElxVFlGalBNUE11TUU1dWo4?=
 =?utf-8?B?dytmRitkS1I5UlRBNWNCVDFGUkFESXJrUjZKSGlSOGp0TW5OS00yTXF1R0ph?=
 =?utf-8?B?ZDRVa1FWNExpZGlPTE9EVzJqM2xOYXIvZDNNMEVkU0NYK0NrNXNWWVRLclhj?=
 =?utf-8?B?UzRlNjVsUlRYVTMvSEhmWkI5Qm9xaEh1bWt1Q01Gd3JkSWhaZ2FLZVhweXBl?=
 =?utf-8?B?R3UvZklBcnh6cm8yZ2dyekFJSkYzZEQzTEhic0p1a2VjdndCSTBqY2QrVi9X?=
 =?utf-8?B?eWl4TUZlZU82d01DWGZOZ3E0eXJrdmEyd3FKWVRucDJMS0xVNkVtT2tsTHg4?=
 =?utf-8?B?VjN1ajdhcU54YkdzU3dqZ2V6MGtlSll6cWF2SDczemlLVDFjVzVidFJJYlJs?=
 =?utf-8?B?eXNpcmN2cytyV0FPZEhDTHhmV0U1ckhzL1ZIR2oxTEFpTkRNenJleTRVT1ZK?=
 =?utf-8?B?NkZiT1N0U2Fzdk8rdkdrNjFlMmNRTS9ORVh2U1ZIOExhKzZrWmhnaFhlcWpI?=
 =?utf-8?B?Rld1amJUaDdCNURZYVBIWkpuSzlpWHBueWNIbXVjQmV3Szc5ejRqeFN5UDFu?=
 =?utf-8?B?KzAvM01XbzcvYzJpMFNNclJXbnpBbzliWXBvMjFjZ1graU8zckhDak5PZnd3?=
 =?utf-8?B?UkhIb3NQTVBxWTMvWWlZLzU1ajR4VzZ2eDdTZFFQeGU4U1MxNXN5ZFpsdlEv?=
 =?utf-8?B?czhUNXUyUXd3VFlWSG12SlFVcElzNmVrM3BXbC9UekpHV1FGdHBVcDRWS2hH?=
 =?utf-8?B?T2FBNFd2MVBFWlFVOVk2UWlKc1YyeE9oWHdmUm04bFhwR2tvU3pRbUtkelY0?=
 =?utf-8?B?WU80eFRQZ3BLN2V5eVVTL1I1TkRlZFRaU2VFUW11TlJYYnIzM0dzSGZSUUFV?=
 =?utf-8?B?U1VnUmNPem1VdWRsRHIxMENjd09CbXdCeWZ4cmtDS1hzQWJVNEpjelpQN2Zo?=
 =?utf-8?B?STZyeEFGNXlXL2czOFdDbDhyaW9wMGQ3bmZHZWNlTUM3Q1F0QmdVR1dJeFpq?=
 =?utf-8?B?K2tqb3gyQ1U2dThuTzZlNnVHdU5pVk9SRjF3U0tpdkUxTFVMQzA3Zy9qbnA1?=
 =?utf-8?B?VjdnY3FCZHdYSW5URTZSWHl3VWJEM2FFKzg5UkxMY2U1L29ycWlCSFQyWGIr?=
 =?utf-8?B?bmNXQlpUTXo4dElGMTFYMlFpZUVUK0tieEZIWXZmT2wrS2RSUTZ6ZW5jNHdJ?=
 =?utf-8?B?elhqUkNKOG8yUUJESVg3aW9UbXQ1T0JIL1JuOXlzalBnNXRldEVVK2I0dUo5?=
 =?utf-8?B?WlpsYkdPTnR0aU11bzdvaFBNakRpWVlGOU94VFdzS01GbVBzSTFaWTZJakJF?=
 =?utf-8?B?d25XVUhkTVhDNE5ZUUlZdEdXOU5qa3lVL0loU0IydzROYkhQQkoyUjB3TVUv?=
 =?utf-8?B?b3JMODNEN3ZKbEZPRGd3N3lSeXd6WDJpbUJGRThsTm9Kc1VKalBtclVIUnA1?=
 =?utf-8?B?N3MrNVFSdHppZk82V1d4a01aT1RWZXNDNFgvU1JkRDRCTUFGb3J3dllJQkQv?=
 =?utf-8?B?OUZoNEk2aVVlSUp3ZEg3Qzk2Z0R6b3RWalJkT1U1bllKL3hoTjhEQWo4T3ZX?=
 =?utf-8?B?Z2dGUVE0dG9iYzg4YWo5eGpnU3dHczZtd0wwUjZUQ1J0Tk1MbmhseEJ0b2J0?=
 =?utf-8?B?dGkwMWcvZzNYSXNoZ3NtN2ZmVTBSMmdSbXdMbTVmL21hYS9kZ1hNdFh0b2FR?=
 =?utf-8?B?NzlDYlBubVlESWpaYkhDeE0zSkNsT0N6VUlVcjIwYzNkQVNsZktWa1ZWNUpW?=
 =?utf-8?B?cWJiZHdUUURLaUc1Sm5lZm1LWXY1ak1iNEFCM0xwTWIxckduRnJWTnJISkp6?=
 =?utf-8?B?alpIODlReURCcDVsUHZ4dEUzdmwwTjVTZDhFYjhZMHFEc2xwWGltNjY1eHND?=
 =?utf-8?B?S1RQU25jSFhqUHJWZXNHSmwzMGlaMW5IanRzbk5MZjE3WmsvSVRSMXRZZnl4?=
 =?utf-8?B?ZTRJVnRraUE0U3hKUzlPMm80S0pTN2pzMzNrekR2UlAwR2RQQXdtTDUyNVBU?=
 =?utf-8?B?V1B2ajVkT2NESytLMWpMTjEzaDRLL25aQVErY0RkNys4QVVrWkl2dlhsUTVq?=
 =?utf-8?B?c2c1ZHBtSjZ5RUNRTUlDOEF5T0xlTlAyQkZKR2tHanNCbnE0Ky9MMFVkMFQr?=
 =?utf-8?B?M2E1TGhQS01QSGNJSElUdVZIT3F0eFpIVGh2bmpxZFFZcGg0UWU4U2xHT2RS?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD53AF18A9CFDC41B86150AF0CE61958@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kPjsE/U8ArsS06K4BLGkSJlPZrOH+iSdlT/tEi9Scd0cYP6eqvTwyu+1dNAaFlj2pAIoJbDPqW5+sv90/bWMno+RJ8X7sfA39HpyjQzgTj85jYIhG7mTOdxJXWHZuQWeIijIqu5T96dz0/bVxEFYwkOHggQXZh0oZE07bCEOlaYpNuBZG7GinF8pb1h9Q0F2wMG9Ns0y4ooqUHiK10ZuwKGAjWlDaGuoHnNDiXFembjpfGQivTztahrzfgqu2nqRnjFCjRKjcjWEH6TIT+6bdm6ksfW2/fXanVswilyCQDrDZsCcksJf08jnIkilyl3+r6EGPWrgYzUZGq80sol2qveelZHNQGWH315x/Oh92M+tCEhKgwgW4BExljA0quvdrgHluudepHL3Tbl1cY16Petyd4DuvRn+pmBPXEdxE2CWKX4L/gfP+dpSPOHvgDXn22jgIru1czwRM8AF4kKPglh9j1f/4qAeUdWllkpqWfETDJA9uaqC8eURPLGVQ2idjfYmCxLDHsdJvpz2Bl7Sdzq8C3xNiqsxHh9muaYSZkwbzSo2Xf4ZzPf+t2Vkj/vDSd33372UYLWc7jDN2qHvziJ8l5Y2pQW93BpMjXqX0v65dO04avUhADxlm+jx7iL5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca3f035-cc8b-43d0-5690-08dc8957712d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 14:13:03.3108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N2SkocAjn42XBdnrPdpDoUdNQBdgaXQOqLXCRRlpiDJYRkT0C+5kLrn2syf+dpnw4a8b4io0G3++JR/74FzK/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8610

T24gTW9uLCBKdW4gMTAsIDIwMjQgYXQgMDg6NDc6MzdQTSBHTVQsIEhBTiBZdXdlaSB3cm90ZToN
Cj4gDQo+IOWcqCAyMDI0LzYvMTAgMTY6NTMsIEpvaGFubmVzIFRodW1zaGlybiDlhpnpgZM6DQo+
ID4gT24gMDkuMDYuMjQgMDQ6MjQsIEhBTiBZdXdlaSB3cm90ZToNCj4gPiA+IEkgY2FuJ3QgbW91
bnQgdm9sdW1lIG9uIG11bHRpcGxlIHpvbmVkIGRldmljZSB3aGljaCBkYXRhIHByb2ZpbGUgaXMN
Cj4gPiA+IHNpbmdsZSAmIG1ldGFkYXRhIHByb2ZpbGUgaXMgcmFpZDEuDQo+ID4gPiBJdCBleHBl
cmllbmNlZCBtdWx0aXBsZSBmb3JjZWQgc2h1dGRvd24gZHVlIHRvIGtlcm5lbCA2LjEwIGNhbid0
DQo+ID4gPiBwcm9wZXJseSBzaHV0ZG93biBvbiBsb29uZ2FyY2guDQo+ID4gPiANCj4gPiA+ICMg
ZG1lc2cNCj4gPiA+IA0KPiA+ID4gWyAxOTYzLjY5ODc5M10gQlRSRlMgaW5mbyAoZGV2aWNlIHNk
Yik6IGZpcnN0IG1vdW50IG9mIGZpbGVzeXN0ZW0NCj4gPiA+IGI1YjJkN2Q5LTlmMjctNDkwNy1h
NTU4LTc3ZThlODZkZjkzMw0KPiA+ID4gWyAxOTYzLjcwNzgwMV0gQlRSRlMgaW5mbyAoZGV2aWNl
IHNkYik6IHVzaW5nIGNyYzMyYyAoY3JjMzJjLWdlbmVyaWMpDQo+ID4gPiBjaGVja3N1bSBhbGdv
cml0aG0NCj4gPiA+IFsgMTk2My43MTU1OTddIEJUUkZTIGluZm8gKGRldmljZSBzZGIpOiB1c2lu
ZyBmcmVlLXNwYWNlLXRyZWUNCj4gPiA+IFsgMTk2NS40OTIwNjZdIEJUUkZTIGluZm8gKGRldmlj
ZSBzZGIpOiBob3N0LW1hbmFnZWQgem9uZWQgYmxvY2sgZGV2aWNlDQo+ID4gPiAvZGV2L3NkYiwg
NTIxNTYgem9uZXMgb2YgMjY4NDM1NDU2IGJ5dGVzDQo+ID4gPiBbIDE5NjYuOTUzNTkwXSBCVFJG
UyBpbmZvIChkZXZpY2Ugc2RiKTogaG9zdC1tYW5hZ2VkIHpvbmVkIGJsb2NrIGRldmljZQ0KPiA+
ID4gL2Rldi9zZGMsIDUyMTU2IHpvbmVzIG9mIDI2ODQzNTQ1NiBieXRlcw0KPiA+ID4gWyAxOTY3
LjM0Njc1OF0gQlRSRlMgaW5mbyAoZGV2aWNlIHNkYik6IHpvbmVkIG1vZGUgZW5hYmxlZCB3aXRo
IHpvbmUNCj4gPiA+IHNpemUgMjY4NDM1NDU2DQo+ID4gPiBbIDIwMjYuMjg3MzU2XSBCVFJGUyBl
cnJvciAoZGV2aWNlIHNkYik6IHpvbmVkOiB3cml0ZSBwb2ludGVyIG9mZnNldA0KPiA+ID4gbWlz
bWF0Y2ggb2Ygem9uZXMgaW4gcmFpZDEgcHJvZmlsZQ0KPiA+ID4gWyAyMDI2LjI5NjQ0NV0gQlRS
RlMgZXJyb3IgKGRldmljZSBzZGIpOiB6b25lZDogZmFpbGVkIHRvIGxvYWQgem9uZSBpbmZvDQo+
ID4gPiBvZiBiZyA1Mzk5ODQ3NjMyODk2DQo+ID4gPiBbIDIwMjYuMzA0NTc2XSBCVFJGUyBlcnJv
ciAoZGV2aWNlIHNkYik6IGZhaWxlZCB0byByZWFkIGJsb2NrIGdyb3VwczogLTUNCj4gPiA+IFsg
MjAyNi4zNTI1NDddIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RiKTogb3Blbl9jdHJlZSBmYWlsZWQN
Cj4gPiA+IA0KPiA+IENhbiB5b3UgY2hlY2sgdGhlIHdyaXRlIHBvaW50ZXJzIGZvciB0aGUgem9u
ZXMgbWFwcGluZyB0byB0aGlzIGJsb2NrIGdyb3VwPw0KPiA+IA0KPiA+IHRoYXQgc2hvdWxkIGJl
DQo+ID4gYmxrem9uZSByZXBvcnQgLWMgMSAtbyAweDI3NEEwMDAwMCAvZGV2L3NkYg0KPiAjIGJs
a3pvbmUgcmVwb3J0IC1jIDEgLW8gMHgyNzRBMDAwMDAgL2Rldi9zZGINCj4gc3RhcnQ6IDB4Mjc0
YTAwMDAwLCBsZW4gMHgwODAwMDAsIGNhcCAweDA4MDAwMCwgd3B0ciAweDAwMDAwMCByZXNldDow
DQo+IG5vbi1zZXE6MCwgemNvbmQ6IDEoZW0pIFt0eXBlOiAyKFNFUV9XUklURV9SRVFVSVJFRCld
DQo+ICMgYmxrem9uZSByZXBvcnQgLWMgMSAtbyAweDI3NEEwMDAwMCAvZGV2L3NkYw0KPiBzdGFy
dDogMHgyNzRhMDAwMDAsIGxlbiAweDA4MDAwMCwgY2FwIDB4MDgwMDAwLCB3cHRyIDB4MDAwMDAw
IHJlc2V0OjANCj4gbm9uLXNlcTowLCB6Y29uZDogMShlbSkgW3R5cGU6IDIoU0VRX1dSSVRFX1JF
UVVJUkVEKV0NCg0KYmxrem9uZSB0YWtlcyBhIHBoeXNpY2FsIG9mZnNldCBpbiBzZWN0b3IgdW5p
dCAoNTEyIGJ5dGVzKS4gQWNjb3JkaW5nIHRvDQp0aGUgZHVtcC10cmVlIG91dHB1dCBiZWxvdywg
dGhlIEJHIDUzOTk4NDc2MzI4OTYgaXMgYXQgIjE4MTk0NTU1MjA3NjgiIG9uDQovZGV2L3NkYiBh
bmQgIjE4MTk3MjM5NTYyMjQiLiBTbywgImJsa3pvbmUgcmVwb3J0IC1vIiBzaG91bGQgdGFrZQ0K
IjB4ZDNkMDAwMDAiIGFuZCAiMHhkM2Q4MDAwMCIuDQoNClRoYW5rcywNCg0KPiANCj4gRllJLA0K
PiAjIGJ0cmZzIGluc3BlY3QtaW50ZXJuYWwgZHVtcC10cmVlIC9kZXYvc2RifGdyZXAgLUEgMTAg
LUIgMTAgNTM5OTg0NzYzMjg5Ng0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW9f
YWxpZ24gNjU1MzYgaW9fd2lkdGggNjU1MzYgc2VjdG9yX3NpemUgMTYzODQNCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIG51bV9zdHJpcGVzIDEgc3ViX3N0cmlwZXMgMQ0KPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cmlwZSAwIGRldmlk
IDEgb2Zmc2V0IDE4MTkxODcwODUzMTINCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBkZXZfdXVpZCA3NTRmMjkzMi0zOGU1LTQ2YjQtOTNkMi1kZDY5OTA3
Njg3OWUNCj4gwqDCoMKgwqDCoMKgwqAgaXRlbSAxMDQga2V5IChGSVJTVF9DSFVOS19UUkVFIENI
VU5LX0lURU0gNTM5OTU3OTE5NzQ0MCkgaXRlbW9mZg0KPiA3ODUxIGl0ZW1zaXplIDgwDQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsZW5ndGggMjY4NDM1NDU2IG93bmVyIDIgc3Ry
aXBlX2xlbiA2NTUzNiB0eXBlIERBVEF8c2luZ2xlDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpb19hbGlnbiA2NTUzNiBpb193aWR0aCA2NTUzNiBzZWN0b3Jfc2l6ZSAxNjM4NA0K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnVtX3N0cmlwZXMgMSBzdWJfc3RyaXBl
cyAxDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Ry
aXBlIDAgZGV2aWQgMiBvZmZzZXQgMTgxOTQ1NTUyMDc2OA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl91dWlkIGVlNjY5Yjg1LWY2NDEtNGQ2YS05
YTY2LWRhMTM5MDdkNTViMg0KPiDCoMKgwqDCoMKgwqDCoCBpdGVtIDEwNSBrZXkgKEZJUlNUX0NI
VU5LX1RSRUUgQ0hVTktfSVRFTSA1Mzk5ODQ3NjMyODk2KSBpdGVtb2ZmDQo+IDc3MzkgaXRlbXNp
emUgMTEyDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsZW5ndGggMjY4NDM1NDU2
IG93bmVyIDIgc3RyaXBlX2xlbiA2NTUzNiB0eXBlDQo+IE1FVEFEQVRBfFJBSUQxDQo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb19hbGlnbiA2NTUzNiBpb193aWR0aCA2NTUzNiBz
ZWN0b3Jfc2l6ZSAxNjM4NA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnVtX3N0
cmlwZXMgMiBzdWJfc3RyaXBlcyAxDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc3RyaXBlIDAgZGV2aWQgMSBvZmZzZXQgMTgxOTQ1NTUyMDc2OA0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl91dWlkIDc1
NGYyOTMyLTM4ZTUtNDZiNC05M2QyLWRkNjk5MDc2ODc5ZQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cmlwZSAxIGRldmlkIDIgb2Zmc2V0IDE4MTk3
MjM5NTYyMjQNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBkZXZfdXVpZCBlZTY2OWI4NS1mNjQxLTRkNmEtOWE2Ni1kYTEzOTA3ZDU1YjINCj4gwqDCoMKg
wqDCoMKgwqAgaXRlbSAxMDYga2V5IChGSVJTVF9DSFVOS19UUkVFIENIVU5LX0lURU0gNTQwMDEx
NjA2ODM1MikgaXRlbW9mZg0KPiA3NjU5IGl0ZW1zaXplIDgwDQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBsZW5ndGggMjY4NDM1NDU2IG93bmVyIDIgc3RyaXBlX2xlbiA2NTUzNiB0
eXBlIERBVEF8c2luZ2xlDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb19hbGln
biA2NTUzNiBpb193aWR0aCA2NTUzNiBzZWN0b3Jfc2l6ZSAxNjM4NA0KPiANCj4gPiBhbmQgZm9y
IHRoZSBvdGhlciBkZXZpY2UgYXMgd2VsbA0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiAJSm9oYW5u
ZXMNCg0KDQo=

