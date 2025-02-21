Return-Path: <linux-btrfs+bounces-11694-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3F9A3F3EC
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 13:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255A23BB930
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 12:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01703209F4B;
	Fri, 21 Feb 2025 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KCg5OFsD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vxhKHBe4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945AF205AA8
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139975; cv=fail; b=YHToZxIzsxtbOgx/fpKqDuE4rrbMIH7bAo+A3ZSnT4fEzyDZDcnpoZ8ST19G37nq/731gGy7fFYjUjPzi66/1NgJKtSIkOJoHod6l6jbj+r3okLmZ6QSva8nv8oZKjE0yxsbn9/hPuM1hTYedHQIM9AV/hWtchcMjFhOSnpR5zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139975; c=relaxed/simple;
	bh=CYQNiW6ZGf7isHMJRf8JhXsnmfihWBd/y2jBILsJB8I=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dxfnf8Dd1Di/Wn87agQlN/7E484QkoCQZnissmA0cDohYN30eijJ0S2Y5cooDaChflAbhckpOMZ7/2Ch50pODdmAWt0iRCDRZoeolPNF+Fo871lyvEwvE54BFTstkZz+v4kiCEiZEHnZ+IdBfrIyQbPeRGKNn5IBwMFtKgEoBgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KCg5OFsD; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vxhKHBe4; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1740139973; x=1771675973;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=CYQNiW6ZGf7isHMJRf8JhXsnmfihWBd/y2jBILsJB8I=;
  b=KCg5OFsD7pJ9ZQAFWAGRGxi2pUgxzh75YF/avi4KNP5DMrUeRW1CotwC
   SDwE+pQfSMvX45tGl3jMonv+gk5kCYr9JYSfMCDVXWVBuywL77k3m6w3o
   NyKfokqHH7HatRTZOVIZmiMWe6tzQrOqAxJ+A1Bw/ydsDN17xSGtC6ZeJ
   MclUhNtakIRfWbBfpf1uQunF/gOXr6gSuxoQWxPGm4TUYrjkRyRp79ChL
   kX7xXxWkfl5sg40rOatq1o+1oskZKWb2N18HcwIEs0w7MlFPwl4vg4lOL
   xoRH5WCBq6mQsmfbrJ+3Y/+3MZXLfGCbwKDIXKsI4Z9qo3fkQmVhs8qO7
   w==;
X-CSE-ConnectionGUID: Op6ik7nNRDS2W7BIwYqTWQ==
X-CSE-MsgGUID: /Olr7s30SluQL9t2VHIuDA==
X-IronPort-AV: E=Sophos;i="6.13,304,1732550400"; 
   d="scan'208";a="40366315"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2025 20:12:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwkMzJ6wTF50lyeZupCR6dysbTJ4YpJrySmU8ugKZNfuOJxqnBPOcgw1ysY+psY6TSUrN+C9lw7GcpNf5jks3d8PSKkcC+W7q30h3HKLwNMPQcyOLBNQCPjTlSyWSseCHFl6khv1citIOtLZP3gr2kn8CfgdVBFFmW5SH/wcHXQ0tMo68J1fBAL2Lx93x+w8K/Ze0MUfLEAMcHjemrnr5v4WuNlvto6OGeeW9Nh9ErcFG/mxJW7dO/AENviqe5A+WRXRXVmwfffrTAPez2b5dnO8uw6EONMHcx39sLe79FCfm8xba67DD7HMnJBzkH/XZ/EQsBynToDc6R71ZWFo/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYQNiW6ZGf7isHMJRf8JhXsnmfihWBd/y2jBILsJB8I=;
 b=nI9S5dfZ8Dfwm2iCYNQvdp2ax+oLY3H1HhV1gYzgO43tNCSgPpqbQkCXo8pWIiexGmofmthirBJRhGDteYETIz9DglN7z1yRb4dPeihPitHOt3Tuyr6xn86A1oSCBpgnEVfASUcJX6Wp66F/dK3P8bIkaeYGdjHUvttv8FQIzlbpaJAuzv0nYYF3gJghD+GImnOQwC3S5wRiJXLKfthWM8G2XZI2tMVQH458jA5Yonz+wjCxZ73xgS2T+va7wkLxKAz8SpesP8SEPyI8+51V7SvAQWwsjckakVqppaI8Hsw/+k5vO4uhN+B4IQBvika+4OHfcqH/IG/OzYtCGG3kbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYQNiW6ZGf7isHMJRf8JhXsnmfihWBd/y2jBILsJB8I=;
 b=vxhKHBe4hRKCqzJ8R/S786tVjO3fAiaZ9iY/7xpJaihGZmyVszMjAVvu83UJ3uM++H8Vk8tKPwIDWnrM0h6Ri+N/g+7HQGrE+2Cj32tmmrAshGGsEDZFzX2km9G0RZUePbo+BV8EpJLucYXAUVEmtLClN7XJSLE8Bbiuk+Uf5us=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6373.namprd04.prod.outlook.com (2603:10b6:a03:1e7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 12:12:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 12:12:48 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/5] btrfs: prepare extent_io.c for future larger folio
 support
Thread-Topic: [PATCH 4/5] btrfs: prepare extent_io.c for future larger folio
 support
Thread-Index: AQHbg3k+Xh6z51yRB0q+AYtH6edVArNRrOOA
Date: Fri, 21 Feb 2025 12:12:48 +0000
Message-ID: <c68a0824-493c-4049-9050-6e270793c44f@wdc.com>
References: <cover.1740043233.git.wqu@suse.com>
 <19dfc0e42dce6416b66df114513d18d93b830d17.1740043233.git.wqu@suse.com>
In-Reply-To:
 <19dfc0e42dce6416b66df114513d18d93b830d17.1740043233.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6373:EE_
x-ms-office365-filtering-correlation-id: 6412db51-b382-4f42-35f6-08dd52710ea5
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QkJWNTlQWkc0T1F3UDI2YnMwdEJ0LzFmNkJmaDRCWUpFa05JOHdGOG5kK3hw?=
 =?utf-8?B?SXZUY1dPaGRMdS9xdFlPTXk1Y3R5Ly8rbzRwc1gwY3NMbnZHblExNjl1UmYw?=
 =?utf-8?B?bmYrSnBPR3pjOW9tdFVKS3N4SjZ3aFlSWWNNZGZZbnR1Znd0MWVwbUVoeXBl?=
 =?utf-8?B?M3A2YXBLSm8ySkNkSW1rUlZycGJ6NTBvcGdrMS9zWnowbTBxVWJyNU5tbnlY?=
 =?utf-8?B?cGdWSVc1bEJnTXZXbmNvcUhXZ3hUU1lSN0FpV0JBVURiNXZrT2gxRzFMZDUx?=
 =?utf-8?B?cVh1RDQ2amNLeEVJaUZGV0JpUkJmRTk2ckxqdUNsekIwcWduMmxoUnpVS0dj?=
 =?utf-8?B?VklHVDZWSHZxN1laRWN0eWQyZVNRazFTN3JKbnYvYUgwa05RZVkwUnMvdk91?=
 =?utf-8?B?SVdxWThQeG96Y0xkdDlISkg1eDZhWE0xbjV3L04wcW1UOUJFNGV4RUFDRWZU?=
 =?utf-8?B?ZzAyQklJakU0bmltUHFBWndFa3cwRndVWThaTkVUaktPTXpKM0NHeGZiRUtP?=
 =?utf-8?B?R1kvaWRaOWxjZGFBd2hxMm11ZWQydTRQWVlpa0pDV1pBWjUvcDVaaHBJN091?=
 =?utf-8?B?NjlySlRNaVozMTF2ZXVJV1FvMnhDYmRYK0xwbTBYS3RlSTErY2ZUODMwYytv?=
 =?utf-8?B?UzR5eFY2WHNUUHdTL2hoOTY3S1pydFVjYy9maGQxVVVQV1BXZUhEdlJFbm5s?=
 =?utf-8?B?OERxdnNDMzd4Z09Ja3BGS045cFg4WG5aL1JoTHdHc3ZxblpWenV0S3lXeFpU?=
 =?utf-8?B?UEQrdW82dE1Mb1VxbUk2RldiWlJXNXV1dzJhQ3VOVWtmRHUyRlFJT2FuS296?=
 =?utf-8?B?WEJOWUFCSHVhWnJadnNBL01uRGZlcnEvbzFQVzZnYnhleVFHS2RsWldnOVRo?=
 =?utf-8?B?N0JIUmo4ZTlvcnhMVTdlYXRidjlWN0RvZ1RXdDkwTDljWjhUdUVHRlFWUDk1?=
 =?utf-8?B?SzFiMHlhdCtuNGtJR2creEpIdm95VHZLTk03RldvYThiQ3hKVWp5bG1TUmpE?=
 =?utf-8?B?cjd5OXRERmlYVm1SSVE4cU1BeHBoejV3VFJpRjlnLzFXd1NObDZhWkQ1VXFI?=
 =?utf-8?B?VWs3SWlqMTZUNWw3NTRCbldmMzVReG1aVzFha3d5aTFwcUxiS2E4dTNOYVVr?=
 =?utf-8?B?WUVyTEg3M2Q2ZDhLVGxZY0ZrL3lCOXlHWE5vdkFsZFZEdmhDU09GM0ZPc3VQ?=
 =?utf-8?B?cEVFUTNVTjIrMjRzMHdFTGVQc1BqNjdsNnBlRzNYeE42b1N5UHF2SUFhWkZv?=
 =?utf-8?B?K2pUWEVmNnVMZkpQU2ozRlM3UDdYeDlEc0FKU25Bek81SUdtNm1oMWR0TTNu?=
 =?utf-8?B?VkFONUFhcFBmN0hDczM2bERwRlFxVHFLYUU2MnFJek9hS0YxU25paFZJR3hX?=
 =?utf-8?B?STN5VzI0b0Zidmd6TFZTMklQcFQwckhKSFdZNGtzNWtZalZjcnl3NnNPdEdv?=
 =?utf-8?B?R3hTSmphbmcvMU1GTGw0THdXR0Nuelc5Ui9BVkxxb0VpWDE1eFI5SG5TVlNv?=
 =?utf-8?B?c2xYc09GZEc3TzRlVEoyd2xzbE9kbWJUUCt6bFBDSjludzFJSmdxd3hEOU1i?=
 =?utf-8?B?Z1dpV1JhVFhMTUVIWXFUS2FMYTJkUC9lcHRqc0VvWmdNd2xsWVV2ZTBBcFR1?=
 =?utf-8?B?RDVQWEVFcGNoMEZsajFCZkdYYWJtUTVjNld3RzBQbXc4TFR4T1FnQ3pHL1hQ?=
 =?utf-8?B?SlV2c0g5UDFHWEpNSGI0bWM2SmlPVUZmaStxRHB5YlZiSDNkNmdKeDhPVUR2?=
 =?utf-8?B?S2JESHNZVGNCOTNlcS8waTFzYmRDdnJvdnNpaTRVQlAwekJGaU1IOG45Ym5U?=
 =?utf-8?B?dmtXbVRtWGRKT0hraGNsc3pJcFprL0xmMEFQN2EwcmgrczloQ0FHbHU2ZGRF?=
 =?utf-8?B?VEp2OU02MEJ2emx6UE45NjlXRGdnLzhySWJGU21CKzdoWkN5eFBTNEJzek44?=
 =?utf-8?Q?HpmuAweX3Azzmf4iL8kyPRkJlzGOIRmj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDBvYThoekpEMXJOdGlMMGpOWkRkMExGbE1hYUNka2RzVFZkR3VDYXdhMi9h?=
 =?utf-8?B?YnRKQXB5TGcxMmxUUlkrWTBKUi9RODBqYjlHQXVLMVVMRUFFVHR5TUMwdVZr?=
 =?utf-8?B?OUhndFROMlBFdE5xKzlVTmRIRnIyc3FncFJqTlJQcW1ZQnZick9ZeUNPQnRx?=
 =?utf-8?B?VjE0ZVZOVlJRRzllSHhiZjM4a09YT1JneXhyNUtiQnZNaHRDOTFSOUdUeGo4?=
 =?utf-8?B?RVBNMmNMNFpNZTVLNlBGc2UyYS9mTm93NWRtT0J2Y0VnV3RlZ244UENBSzFF?=
 =?utf-8?B?OXZ2MGROblpjWmhOWEl4bkJ5b0VoWHRUWjl6UU91VnVjVzhmRTNKRG9vcWpL?=
 =?utf-8?B?dUdPOXRlamsycHM1S3JSUk01ZXNmK21zQXFRUGxQbVovdnZPMXlXTzg1eVdw?=
 =?utf-8?B?NUVCK0xZR3dXelJyV2VRMjcrOVhlcVQvQURsRDBEbUd1NUdmM2tBdkxCdklM?=
 =?utf-8?B?RFhsL3lURWlHN0V3SlRPRmFWMEl2Z0lrcmM1eTFZNTNmWThyZ3JFQ3o0MmQ5?=
 =?utf-8?B?K1BxRWtDNzlVZ0dQVFNNM28rZVdKRUtxSTdqN2ZvZU15ZStGTmMzOWs3Nk9B?=
 =?utf-8?B?dXZtQjQxSDZlamtHMDNFWU9RUWZyR3dERTZpK1NyS2ovYlc4aHhHdWVtNmpa?=
 =?utf-8?B?Q294RTNLUWJYWi9JaVZHbkF6Qk05NGNXQzZDdzdSc2VhNEpNR0duYlhzMis0?=
 =?utf-8?B?ZXhqY2hjdGU0bjNTTFVhaHlYNWVTR1RBWWlyK1lPZDV6YTdacjFYMDFTVVcw?=
 =?utf-8?B?aUpoSzBjQWswK3N3Vk9uV1lVaVhwVncrZk9jNjh3bDVOb1p3Y3Z6K3FoRjV0?=
 =?utf-8?B?dFdIdHdpSmsvekNGcmpoeWcydGdFcTI4UmRYc3NTMU1kV0x1R2gxaXRxYTVz?=
 =?utf-8?B?Z3hSOGNRaGZsalk3a3YvcEVkUnltVml1VUQ4d1Z0RnVGK3VpbWtyQTBhK083?=
 =?utf-8?B?aURNdjl1WmJBcXVBRm9ZV3FrSDRURy9SV3hPbVVxYmltUlI5Y0l3Y056ejho?=
 =?utf-8?B?YnlPNmoxVFNYY2lxb1pEQjMrYmZhU2ZsU0VUSmNuOUpjaWpWUUtRVllRRlZr?=
 =?utf-8?B?bndrb29Wek9pWmhEWG1MTGRYb04rSXd1YW5meWlVQ2FadWJGM2d6SUIwUHFi?=
 =?utf-8?B?M29mMjlMc1lOejk1QVk4TjZTQ3BQTTFmUFlYRTVzL1RTNjhLMUI4MEpCa2pB?=
 =?utf-8?B?dlV4Q3lGSXFBbGtTb2pXSklpaGhnR0k3TlNRZ2pjazF2aFByMGRveVU1ZzFX?=
 =?utf-8?B?Wm9uRHk0TGkvejZ3QmF4UFJ2anhKV3JYaUNNT2tCTllqUC9JM1Jjc0NMdXEr?=
 =?utf-8?B?d0l5eHNzYmxUVE5PRkMvcnEvZHBOaGwxM0paSnZMaHRMSG1tS3I5MldJVlV0?=
 =?utf-8?B?WUQ0U2p6OGJuS2xjN1VRTVVSSS82N0Y0SEJ0bUhWQ3JkbnhOUkhsbWtISFU1?=
 =?utf-8?B?aC9FM2Z5WStTalBsWDFsYmVnMFR5eittT2lON0x6VUdlbGF3aVJDWUdneEtQ?=
 =?utf-8?B?U1IwazRGaXBydHVzZjJsa2FpNGtOelFGazBzNERiWklmU0xnd1ZJN0UySTRH?=
 =?utf-8?B?amNFSEdoSGFsSEpqbHRYMFFTTHpWV2xOdm41SDNvU1pDdjBrdENqd0RVbXJH?=
 =?utf-8?B?d2NuSCs3aERKUVR4cVpvVDZHZzVnNUhjTlhOZnZtSWVPUVdZOEJXd1RGblAv?=
 =?utf-8?B?aXZFb3RJUXhSL01pVnVUK0RYOFBQWThPRC9sZE04dmJMeHJvTEhVb0VObWpi?=
 =?utf-8?B?NlZSL0ZESlJoZm9zUWhUWEZIRkNpejlvaGpybkV4MzRtS1RkekV6ZmZSZHRQ?=
 =?utf-8?B?a2dKWFJzQXQ3NHM5MERhcU9TeGo5T0llMDJJcTMwSFhWVVJCVktuNHFiaE5P?=
 =?utf-8?B?cUtFdm9iaTdHTWllUzlvUlFTUFdLYmtJRlpsV1BQZXExTUZCbVA2MDhhSzNh?=
 =?utf-8?B?RTQ2VFQ2VkI5dzR4Sy9zYzJqemZ1YnQ1STRuNFRld1crMzhuYi8zcU5WN083?=
 =?utf-8?B?Vmd3OGp1OFZnU0Zua054cUZvaGpLVVZFMlAxSUFZUVdsKzgxRGNJOTg1Znhk?=
 =?utf-8?B?d3lnSE9UTDJYTG9tang1K3pYeVU0NmViUVg3UVhQTTFzM0lSUnBPMVdDUExD?=
 =?utf-8?B?QXRDdnFNT1JXYWsrZW96eXRZQVQxMlpFTnoyOEh6VUJDaVdGUUl6WUY1U0ZS?=
 =?utf-8?B?dkxkcUpyUmFYdGQrU2g4N29reC9sVmtQVHRvVkVVSjJJS1prcnFac3d2WTlS?=
 =?utf-8?B?ejYyU1A0MFhubktaOFV3Zk9RNWdRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E736198D9F7F2846994430B11699DA73@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3U/2DqHfCaq3UNolpnBB0RNSoC6kHrPoujvyfBLWILhwEJN7J2XKhQQcfq5Gn9E3qiHDstnXCAACOUzLz1wDsvxI7Oq1+rgBS2HZI+2hVv8BHdgCUsrJxYY4f9fqVOMelqQjx1ZzV8hmLVjwcXfhsv+LiZYAKEMIy8rMEf/bFdTY65j8nmJenYRj/xSndhRe14cjAUhcvXh609sf+/lgjhP0W1UQOiKuIm6L2DjZEjOJAwwSutgwJtliHog3PlnVorFdb7vacJWbloX4eP9lcf+OyBLwe9wlf6vcIZAleOr/R1uht4F8eURj7EyFmAK6blBNik40UaSI/Qnpi8LEDiWBBR6c/IPYA63uYG1duJAND7g7njZdiyJK/AUSzK5VFhtSCwRScV1q/0ahjhxJgU1nLVkmARGzwZn1g03Ng2aPQx0Pc247+eSSeomicfhgEPte8zGv+Tz9MccuPDFls+AoifWMlTrn6Mk4/xq7zxfS723U4hM/ThU3KICzcsgeLuyCNQRHFRwYkJVaFsKHcJ+RYMpRONl5Ic/ALmoiyjFX9gIbewdwUVI9+gknbhP+VhdasENIr5ECT3oU/XF16d3PkzDnIB6NajDfarj/uXIOxPj1s8kxhbSi0Z1vmXcU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6412db51-b382-4f42-35f6-08dd52710ea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 12:12:48.6547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iSDxlwsyUVdoBI+pB/xdEMeYg9mfqMY5WAQh+PfioTgeJIdj9xoMC3M6bMF6Dl2+dq2+hwqXkKKl7Kon11mY+hNyr2ZaWAf64+qgxEn8tR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6373

T24gMjAuMDIuMjUgMTA6MjQsIFF1IFdlbnJ1byB3cm90ZToNCj4gQEAgLTI0NjgsOCArMjQ2OCw4
IEBAIHZvaWQgZXh0ZW50X3dyaXRlX2xvY2tlZF9yYW5nZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBj
b25zdCBzdHJ1Y3QgZm9saW8gKmxvY2tlZF9mDQo+ICAgCUFTU0VSVChJU19BTElHTkVEKHN0YXJ0
LCBzZWN0b3JzaXplKSAmJiBJU19BTElHTkVEKGVuZCArIDEsIHNlY3RvcnNpemUpKTsNCj4gICAN
Cj4gICAJd2hpbGUgKGN1ciA8PSBlbmQpIHsNCj4gLQkJdTY0IGN1cl9lbmQgPSBtaW4ocm91bmRf
ZG93bihjdXIsIFBBR0VfU0laRSkgKyBQQUdFX1NJWkUgLSAxLCBlbmQpOw0KPiAtCQl1MzIgY3Vy
X2xlbiA9IGN1cl9lbmQgKyAxIC0gY3VyOw0KPiArCQl1NjQgY3VyX2VuZDsNCj4gKwkJdTMyIGN1
cl9sZW47DQo+ICAgCQlzdHJ1Y3QgZm9saW8gKmZvbGlvOw0KPiAgIA0KPiAgIAkJZm9saW8gPSBm
aWxlbWFwX2dldF9mb2xpbyhtYXBwaW5nLCBjdXIgPj4gUEFHRV9TSElGVCk7DQo+IEBAIC0yNDc5
LDEzICsyNDc5LDE4IEBAIHZvaWQgZXh0ZW50X3dyaXRlX2xvY2tlZF9yYW5nZShzdHJ1Y3QgaW5v
ZGUgKmlub2RlLCBjb25zdCBzdHJ1Y3QgZm9saW8gKmxvY2tlZF9mDQo+ICAgCQkgKiBjb2RlIGlz
IGp1c3QgaW4gY2FzZSwgYnV0IHNob3VsZG4ndCBhY3R1YWxseSBiZSBydW4uDQo+ICAgCQkgKi8N
Cj4gICAJCWlmIChJU19FUlIoZm9saW8pKSB7DQo+ICsJCQljdXJfZW5kID0gbWluKHJvdW5kX2Rv
d24oY3VyLCBQQUdFX1NJWkUpICsgUEFHRV9TSVpFIC0gMSwgZW5kKTsNCj4gKwkJCWN1cl9sZW4g
PSBjdXJfZW5kICsgMSAtIGN1cjsNCg0KV2h5IGlzIGl0IHN0aWxsIHVzaW5nIFBBR0VfU0laRSBo
ZXJlPw0KDQo+ICAgCQkJYnRyZnNfbWFya19vcmRlcmVkX2lvX2ZpbmlzaGVkKEJUUkZTX0koaW5v
ZGUpLCBOVUxMLA0KPiAgIAkJCQkJCSAgICAgICBjdXIsIGN1cl9sZW4sIGZhbHNlKTsNCj4gICAJ
CQltYXBwaW5nX3NldF9lcnJvcihtYXBwaW5nLCBQVFJfRVJSKGZvbGlvKSk7DQo+IC0JCQljdXIg
PSBjdXJfZW5kICsgMTsNCj4gKwkJCWN1ciA9IGN1cl9lbmQ7DQo+ICAgCQkJY29udGludWU7DQo+
ICAgCQl9DQo+ICAgDQo+ICsJCWN1cl9lbmQgPSBtaW4oZm9saW9fcG9zKGZvbGlvKSArIGZvbGlv
X3NpemUoZm9saW8pIC0gMSwgZW5kKTsNCj4gKwkJY3VyX2xlbiA9IGN1cl9lbmQgKyAxIC0gY3Vy
Ow0KPiArDQo+ICAgCQlBU1NFUlQoZm9saW9fdGVzdF9sb2NrZWQoZm9saW8pKTsNCj4gICAJCWlm
IChwYWdlc19kaXJ0eSAmJiBmb2xpbyAhPSBsb2NrZWRfZm9saW8pDQo+ICAgCQkJQVNTRVJUKGZv
bGlvX3Rlc3RfZGlydHkoZm9saW8pKTsNCg==

