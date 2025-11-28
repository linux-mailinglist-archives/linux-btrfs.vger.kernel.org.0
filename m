Return-Path: <linux-btrfs+bounces-19411-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A5DC9266D
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 16:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 548E64E3026
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 15:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1D8329E48;
	Fri, 28 Nov 2025 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d+1gR/DM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="G8Gay6FC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE9B22D7A1
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Nov 2025 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764342401; cv=fail; b=JAIlMUa7C2UVGVCoJijDN5rWlH76bPfDQNEjXdr4hWAV4RFm9Eq828mWB8UY6QXbGGD2KSFZ+PPGDGcCMvrgFP3/5eaWqpOMRLgX5hjUzY+cIGYwqzApYCaKUieTXPmblKLwZMEcnVtd90q67gAnJQItkHRYOUwABoghcZOAFSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764342401; c=relaxed/simple;
	bh=TogOvM1NwstG/Vyz83ME46sco67xO2TcqOesWgMv79o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kC5v+GnKcz440WfSxMXcc5ch3Zr9s7uby0rtL55tsLw0PDyYEePU8hNpojAgiwqkKc4Q+Xx6NYsQymj4qya+l2RVwgkhlqyJelbFe+ZnrmAHDwNZe7I6iPSpP6dpEwpNWCEQU/EOpVQANrK2iGVD0WTLmEXpF+HHJk5Voxr15OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=d+1gR/DM; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=G8Gay6FC; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764342399; x=1795878399;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TogOvM1NwstG/Vyz83ME46sco67xO2TcqOesWgMv79o=;
  b=d+1gR/DMiqDcRa62RM/b4hXY57z2+VIkYqWx+HookizCxADh71zBLJFs
   Qi1q9nZHSU6lQ8A77pJ67M1uCafXhnsJ3ShyaOiYML5Bxk0mKv2i1u1m9
   0tVesL6bftgt4miLpWjPTO6SY60CwskrVcPEbjO5Y6gDeWeKfOfMj23WW
   2AKKvFzBV6Z1V274EOsd89Hi+mlwz0fZ8SiAh/pb+up9ZwplscSXxD4R6
   E/zlbIxB+1DsHVbJmIhmCdrvlKdNIDca47lNVkqeKVLR7MVNMtWBbhzQF
   RiLvDV48O95Omij9DjbklscXteXAbmqt2t7BnqLXhorJTT5ftQV7eTOy9
   g==;
X-CSE-ConnectionGUID: +S8XnMORTeC5odoGzUJDNA==
X-CSE-MsgGUID: qWXuM0mMS/yEUHXEOueyWA==
X-IronPort-AV: E=Sophos;i="6.20,234,1758556800"; 
   d="scan'208";a="132905829"
Received: from mail-westus2azon11012041.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.41])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Nov 2025 23:06:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OM3Go0OUYWGwNpRANWrYFiOlEdoljqBGdOYxbgxYSVfAuDJEgzcumPMPGq2GJR/pRf/htmDiQMDnjorDtcDZfKlWwmYTbbJ3kSCVkDbCo28Od+eu5yBC12RUjl6PxOfF8Zi1mxe6R+Y/tN49W4Ockm4SA0+jml4RQUa6BaMZTgXqnBIjcbk0t0oRPqpjvrYCp4g8lJkbipDo7UiZwDDWpcxDn7s4kG7c7YhF/PbQLH68aDyqvkOz0R6tWxZTe4wms89N3TXgMNgrRc4OMqGDKQGmk4AU6tDok+5piE5LAKnGOGzjwQSN/w+bQnpze66Ln053ejLAdZQmhX/hNlFMrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TogOvM1NwstG/Vyz83ME46sco67xO2TcqOesWgMv79o=;
 b=l+Id7h+vpM6shxNtENLp7VFGe1AVs9cFaTKxSYK+IibbhtFOBXMrzeKh1Z+iP2P6RBlqIA4BbZPKeuyBOiHSfsGHv5cSBAIEW88PU2+rnZvZlFG/F0gqViQqBu9UXzxznRib1Y6ak+m0gG/eEzCBH82+uIAJQ6W7pI8fYz5fp12cbLFlWwd5uCwugp318mlmUUgL8nmjc+bRQPBdwQoSJLbGZELgRSu3MM6VIN2XAtexbxHdtS/gchy8jyF5bkL7o2PgbwqgrvCzvv4VOJRyM3YWAFjOhQA/Pwsp4TvFamjNIKCiygLb/uA/jcHOPcuYmBGBNV68uFij+TXX6FTQFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TogOvM1NwstG/Vyz83ME46sco67xO2TcqOesWgMv79o=;
 b=G8Gay6FCB3dJ11W8JPcuIa469c+2aFxNZ/aHfrsKyPqnpqVgK82uqPJlwVBsp57NnqSgJTtPDOdL454QprpZuYlsPME4JsuPPzGSORo2gMHIU4TvtLSTm+2ApjTMMWHtpLm3kQ/CNcPLOZ+ZwmVp3stqCZJAqsbvv485xmXTvbg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6686.namprd04.prod.outlook.com (2603:10b6:208:1ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 15:03:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 15:03:24 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: HAN Yuwei <hrx@bupt.moe>, linux-btrfs <linux-btrfs@vger.kernel.org>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [BUG] 6.18-rc7 cannot mount RAID1 zoned btrfs.
Thread-Topic: [BUG] 6.18-rc7 cannot mount RAID1 zoned btrfs.
Thread-Index: AQHcYFs7ICy2wYW+6UypQP3O7Xqwx7UIL5GA
Date: Fri, 28 Nov 2025 15:03:24 +0000
Message-ID: <e865d52c-8f07-431a-8fff-907bd6cfb0e8@wdc.com>
References: <0BED8C36F63EBD8F+f61c437e-3e5f-4a1c-9c18-17fd31abfcd4@bupt.moe>
In-Reply-To: <0BED8C36F63EBD8F+f61c437e-3e5f-4a1c-9c18-17fd31abfcd4@bupt.moe>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6686:EE_
x-ms-office365-filtering-correlation-id: fe627624-43b5-4bd6-42f7-08de2e8f4712
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UVZoLzUwb3hhRTBwbm43ODJCNkNlSE85QkVoOVdNR0RlVUtsZDdvQ0NKTVd4?=
 =?utf-8?B?NXBQNEd3ZzdISThOWGc3T0w3ZE9OSmw5NXJDZmFPNGlsNHlPa3VQSTFTb2dK?=
 =?utf-8?B?V0FIVmlTbDRMYlVad1JKeThES0NBN1VWZDZwYzlJcVRCeGZtRzVtVGFUMktN?=
 =?utf-8?B?UDNqVWpKdnNNYkVhMXdmNmRDVFVhOFlqUkg5L09ZUW5HMUIrRGNXUGJicXVB?=
 =?utf-8?B?UENTUHZxem5xTzZ4VWVmUmJEV1UrZlhRSEJqMHE5bEZzVXpzYTY4bFR2R2Ix?=
 =?utf-8?B?VFpSQWh0bmpNRHRWSWk3VlBPdHlFaytiR2xrT3RIL2FuSWhCTitiNEhvQ0dJ?=
 =?utf-8?B?aUVtVG51U3I3NzFSZDVzbGFKbjhmUlBoWGw4QlNIamtXRk1NbnFPZzF3R3N3?=
 =?utf-8?B?V2ovV0FyRk84d3ZFN1gwcnFtMDF0QnlTMVdqQ0JUYTdpZEFGN041dU52R09s?=
 =?utf-8?B?UEhzRWtZNTJMUk12NS8yR092N3VJVkpoUUJLdDdjSy9QQWFMYjB2eXgzOHZx?=
 =?utf-8?B?RUJiditsZXJ6NEFzUERydWZVTjgxU0h4ZXVJbEFyQWxhVDYxZ0ljZ3cxRnY1?=
 =?utf-8?B?SnZ0ZTh5ZHdybkt3VVR1Mk5aY0ZrT1RlbUt0Z2ZhL3hLK245T29LZ2hWWWJo?=
 =?utf-8?B?OFVGL2pReDRNaDRyRitacENqKzFYbkV4L3pxZzFYNEtDeUhiZE9xRHRhMWFL?=
 =?utf-8?B?VEVpa05UVk5hSEtNZ1ZKY2ZJY2V2WGhIWGE0cldnVXB2ajFQMDlTVkIyZnNr?=
 =?utf-8?B?QktCUzJwUENuZHRzazVvV1NhZVdQR0hqbVE3VXkvdnIvVlUxaWk5MmZwRTBi?=
 =?utf-8?B?RkpWdEJQRkVmeDhKOTZpYUMzNkVxNERuZDFlRHNISCs0VTJXWFllVHR4SURC?=
 =?utf-8?B?WCsraCswbTk0a2dRWmhEdlYxNVhlZ2JOMVRPNVhkYUkwZFNaZkFVMFFGZVQy?=
 =?utf-8?B?RmlkMXR6SHNFcVV5MmF3dS9PR2c1eCtRWVBXR2FCUlJqc3J5OTMvdkxGL0RR?=
 =?utf-8?B?cHhlYzdjMzgwb2VXVnQ3RktCY0xteUxtU3dhREpVa1pjSldZZER2UVROcDlP?=
 =?utf-8?B?dTQyYkpNV1J1V3gwQ2hmSGJweUhUK0tzc2V1QTVuUDU1MWtNZWxMSm10ZnZo?=
 =?utf-8?B?OFk1WnQ2Q3JrZGRWYmNzSjQ1SUtlVytyTGlHVUo4R1ZvaklFZ05BWFdUZnRF?=
 =?utf-8?B?eUVCaXZiazBBN2dOVDlnN1BuNWlvYVpLUXNzYWhWNi9MTFhxODdHeWc2Mlc3?=
 =?utf-8?B?bCtWTzA0MkxIYlcyUFh3MEZQZ05qUldNSmUyblJkTFAxZkE0cmdQamdwQkcy?=
 =?utf-8?B?SlZjNHUzdll4ZEh0SzZaWkY4QjVFZk54aERYbC9jWWc3MU5MNEYxVTBGUVd0?=
 =?utf-8?B?Z2ZJNU1lSS8za1ZqQndSRFFsUUkzT2dlSmhUL0t4dEtHTVJLK05HSFNBem4y?=
 =?utf-8?B?Rm9BYXhqMG03Ly9oY2ZIRmdDZ3gzRE5YUEN0RVlpVzlCT2h5bXJaeVBpbGJH?=
 =?utf-8?B?NjhJM3NOUWwyWnlaMkFZekdXU2lzbVUrbnZQeml2RVBtcHBhTXJTN09zaXlL?=
 =?utf-8?B?M3QxZjRJWDlqNC91TmQ1WGZ5RTlVSnRodHl4TlJVQzBTclFMM25MTDVZNmxz?=
 =?utf-8?B?MW5DbkFJOThrR01aLzI3VkNzc3V4WGdZQ3pHWHNrNnZ4azlrdWdlbUFtNllz?=
 =?utf-8?B?QmRVZHN0WE9lRDlydTdnYWN3YnlTTTRjZHVRVDhTVHpTSDlNWHlWMkJyT1o1?=
 =?utf-8?B?aE1SU3BxUkE4Um9EQWE5VXlqN3JpYndmUHVOa2FhWmg0TTVCTUhBQ3E2R1hJ?=
 =?utf-8?B?bG1EMEF4STlpZVdBYmh3dHdBcmVodU9MK2lHQlRmMDJxREcveEVNS0c4Tnlv?=
 =?utf-8?B?c3NIRGNnQlZMclBpa1kyU2grbkdwWC9KVmJJWDhBSTRCNHMrMlpzTmZOTjlL?=
 =?utf-8?B?NlFGVkxyOGRoUmRMb1ZHU2ZDN3RjNTZOaU9yQVd4SFAzeHNkSThWL2c5T3RM?=
 =?utf-8?B?Tm1nUDNOc1NsWWxIQW9lVGIrV1VQYS9hc3ZjeGQvSTVPUlEvcE5pelY2dFln?=
 =?utf-8?Q?vPN4c6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0hIUklZS0QrZFovVXh1UGRHbkw0aGJWVHlVV01MMzJJdS9SdjdtUWhkYVJP?=
 =?utf-8?B?UnRyV1NXZzI2YURsejRRMEVWeXl6S0V4YTJUdnZ2Y0xsZ1ZuelJOM25rWERn?=
 =?utf-8?B?Z01uQ0NPMHZHekY4VTlzR0twMjk0ZFlodzdESzJHdkxuczU1aVBsbEQwOW9F?=
 =?utf-8?B?aGIzbkM2bnRoMDJFSWZRdWNBcHhxK1QxS0lmZHRGZzE1TCthNWg2VkowUjJr?=
 =?utf-8?B?U3B3cWZRbDl1bjhvQldSeGdMY0FoQnNGZEttNmNCYWxYY203cS95UVYramxN?=
 =?utf-8?B?Y01UL0dMUWJFS3E1b3BtdEg0OGdnVC9ST3NWYTJ4SDFOUkJrNlArKzZoTVBt?=
 =?utf-8?B?QmJ5MHdram9DMktUbExFaDZnRW90QUk5eHVJUVMyaklLLzQ4QzZvODRuUFMv?=
 =?utf-8?B?eXJORlF5NWVTd0c2V2w4Sml3Z3lNSHdkK001WkNRR0lEV1FGeHJrVHlnQmt1?=
 =?utf-8?B?Q3NMVUl5akNzZ1kyV0Z3ZHhsbVRlVzZhdWNuMW1waUw5d0kxWFZiaExhd2lX?=
 =?utf-8?B?aTlPNk9tRzFCVzhpblBybm5Gc0U2TjhzYzhXUmxZU09xK2dCdXpOcVp1S0wx?=
 =?utf-8?B?QTc2RXZLREV3a2JUcDA1UmFyeW1OeEJCL0JTTHRTTVp5SzFzUjNSMjVYUnkz?=
 =?utf-8?B?Ukl5Qk5jWGFjdE4vcUlEb0dMdVBMT25zcXlFUnl6UnBwUXpaUzZyOXpmNGYv?=
 =?utf-8?B?K01iV2ZKZmdXeHd0N1ZhbXhmNzBZcDlNZjlwOU5GNEp6bGIybS9nbloyYTFi?=
 =?utf-8?B?VzJOTFdOZnMrQzRNanRQZEllZWw0c0tueWJBSnpwcmRqc1FXdERZeTI1bFJ0?=
 =?utf-8?B?STJRV1BkbXk0QStQZjVGSVhqbUNNOUZqMUlBQ25aZC9VVEhKd0hVSm0vN09Z?=
 =?utf-8?B?TnNTZFBibUxOckRGcXcxUndZREgrRG1VL1FGU21jaGZHK1c0MU1jNEYzNERy?=
 =?utf-8?B?TDJpcVg0TXpXcUZ3TlZaaTBiNEVSWnFISDdQcVd2OURycDZiM3ZJY3JhQkdo?=
 =?utf-8?B?Rnl2SE5OYW02VW5JZWpodzQ3ZkdPWURwWUorOCt5RVNobGFCeFNTblFhWkFD?=
 =?utf-8?B?cUhWMU9kNWJ3eE0xNi80S0xGOUFSOTlQcFhVYjR4SzFCck1lR1paNzNiaXFR?=
 =?utf-8?B?MnhSaHFOOCt0Y21UMGhLQzhNWUhvMWNVcUdxREFUVjI0YjV0dE9Ld2VwVU5V?=
 =?utf-8?B?bDBna1Fscng1Vk1iME1xdStWVVkwWFZoQnBFd01BbjY4UVMzYm43SitNV2VK?=
 =?utf-8?B?N1B3TUhYOGRQSEw1R3R1UVZLUlhiVU90UDhaZksxc2pVZ0Y2UVdVUFRVNUNm?=
 =?utf-8?B?S3ZXTTQ2R0tFWFZ4WnRoTHk4OU1IQXJBWHBLSkdQeDJrQy9XZXgzVGF1UkNy?=
 =?utf-8?B?bVZXYW44UG5hTGpoRXE1Z1pKMGJwc2xucE8vcHdOYUdhcEhNQUlYVk8vcjQz?=
 =?utf-8?B?S3l2SnlSTUlUQUxya2lFTnduZ3N5OWZXQU1wQTlBa3NTUk5pamdNcE5Wa2g0?=
 =?utf-8?B?V1dXL015N1o1M0FVQWdRbHpXbk1VbzVWS2xsS0YyeUd5cEU5REw0UzExNG1O?=
 =?utf-8?B?OVBGU0NITlM5dlhRWHJHVlhIU21qaWljZmpIM1BKdWk3RmRQek1KN0U3TDhz?=
 =?utf-8?B?WHBKSWZrK1hDdnBjcnBvRzB1THlkdHQwRVR0eHNDMEtOcUpzNE1leUFxaDE2?=
 =?utf-8?B?YW1EUGxtRVZ4a2syTzROSWs2aG5nV0t5ZUlTUDJmTU9GaUFVMXh0TGo5ZXpK?=
 =?utf-8?B?cHRqTE1aK2VSTy9xelg1RXoyc1U5SWNlL0VBYjZlZ0VObE1udEp2OEUrVFFj?=
 =?utf-8?B?bmh0ZzZ5c0k3RzlNZFNhU2NJS0J0ZnRhZVJLL0FyNmJsWXVMaHhiWjU3cGpx?=
 =?utf-8?B?Q0R0SDhVUjlVRm9FcFF3ZlZyZGh3ZmMvTFk1ZXl5LytidkFyMExGRlRBa21R?=
 =?utf-8?B?dTBDbUNXUWJzU3lYWEZWWWFSTXdGWi9ydWtsa1FOc1VLMWQ4a1NxV1RTK2U3?=
 =?utf-8?B?QWtrRDZ6dG9VbDRhVjNmdTRZNU94VkxGTERiYjNiRlNTMzV6dDZvVGhKR0lL?=
 =?utf-8?B?b0lCMlRlOEN0eVNtaFcrNWxBOGFVUkZUSkpPTEFIeExkeUJwUUFuUDhVbVV6?=
 =?utf-8?B?YWJPYjlVWk1IS014Mm5LODRJRXhmdmEvTERyQmdpRmwybGdUNDdWYmc2RzlC?=
 =?utf-8?B?VEMxZExxemtPUEZKTW9oR2tpWGxvYk94NWljS0JZQjdkdmhnTEdPemtXR1Vk?=
 =?utf-8?B?YTBxak14NzBxRkJoWnJnUDQ1akl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C2C97C3286EAA428302990D69A5CCA6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zjQqnXCbiiEvZCGrA6gxlvtsmzUsK+MIFACx6NHZR5x6aiVej0WhPNC0MUSosxGgBJb3IamOemXQQTwK3IDwYd4xdG89GFkO/vC9Yt/JIARKbg2WO9fUzeRd6YnSzrycpO8kBZSI9binn2Io2lNFr+XpTpwx/K3OdMZH3WJpfaqvfY9G4lXKVgUtILifpTg3oLrWVevZRW5rRicIY6ckuMv5+XCubciyU5gOeOnaX2fMJ2dWHX17TmqmRWAW1GkZwTuqf8RroBuNboLSx96Og4TlCCXqLMe/FJaRMVZfEUW3yVgXJSY3+uQer+rlZh36HVv8ltjgLGSd3+gUxpLILIk/c4mNLH9xFti5PtTtfJACWI9vpoR617+9BKNc6ZGltaZWoIDXC8XJ92bcaGAw4pPtyaC8eY6emiaQmgxZKf2vBmqkDAO0AlDwspY0C/j3+YXl2VPx+4HNVbRkXF15k7CkN9GXvUSi2ora63Cf8RsIcAM1Y/2Mn2Ug0R8750tD2V6Ea2cIMkw3XlO4Pgb8loLIH/doyACYx8OEoguo12icJr7NU4jzQK+4TRQ2wdYyWT1Px/wnSEr3ZCCTIygtYYwzUvgNEjHBIXiJ2tm/dgerz56QPk3qrgaYxR/nHNQc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe627624-43b5-4bd6-42f7-08de2e8f4712
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 15:03:24.0698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WDjYk5iH/DIn/LFIqkyODGBow8awow8rO7W8OBJssfq4l/+VCosrEmBm5NZbb2z7ErbMWqI3lgk33QRGdWEEU9FNuaAv7lAYJajEpUrJpDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6686

T24gMTEvMjgvMjUgMTI6MzYgUE0sIEhBTiBZdXdlaSB3cm90ZToNCj4gL2Rldi9zZGQsIDUyMTU2
IHpvbmVzIG9mIDI2ODQzNTQ1NiBieXRlcw0KPiBbICAgMTkuNzU3MjQyXSBCVFJGUyBpbmZvIChk
ZXZpY2Ugc2RhKTogaG9zdC1tYW5hZ2VkIHpvbmVkIGJsb2NrIGRldmljZQ0KPiAvZGV2L3NkYiwg
NTIxNTYgem9uZXMgb2YgMjY4NDM1NDU2IGJ5dGVzDQo+IFsgICAxOS44Njg2MjNdIEJUUkZTIGlu
Zm8gKGRldmljZSBzZGEpOiB6b25lZCBtb2RlIGVuYWJsZWQgd2l0aCB6b25lDQo+IHNpemUgMjY4
NDM1NDU2DQo+IFsgICAyMC45NDA4OTRdIEJUUkZTIGluZm8gKGRldmljZSBzZGQpOiB6b25lZCBt
b2RlIGVuYWJsZWQgd2l0aCB6b25lDQo+IHNpemUgMjY4NDM1NDU2DQo+IFsgICAyMS4xMDEwMTBd
IHI4MTY5IDAwMDA6MDc6MDAuMCBldGhvYjogTGluayBpcyBVcCAtIDFHYnBzL0Z1bGwgLSBmbG93
DQo+IGNvbnRyb2wgb2ZmDQo+IFsgICAyMS4xMjg1OTVdIEJUUkZTIGluZm8gKGRldmljZSBzZGMp
OiB6b25lZCBtb2RlIGVuYWJsZWQgd2l0aCB6b25lDQo+IHNpemUgMjY4NDM1NDU2DQo+IFsgICAy
MS40MzY5NzJdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RhKTogem9uZWQ6IHdyaXRlIHBvaW50ZXIg
b2Zmc2V0DQo+IG1pc21hdGNoIG9mIHpvbmVzIGluIHJhaWQxIHByb2ZpbGUNCj4gWyAgIDIxLjQz
ODM5Nl0gQlRSRlMgZXJyb3IgKGRldmljZSBzZGEpOiB6b25lZDogZmFpbGVkIHRvIGxvYWQgem9u
ZSBpbmZvDQo+IG9mIGJnIDE0OTY3OTYxMDI2NTYNCj4gWyAgIDIxLjQ0MDQwNF0gQlRSRlMgZXJy
b3IgKGRldmljZSBzZGEpOiBmYWlsZWQgdG8gcmVhZCBibG9jayBncm91cHM6IC01DQo+IFsgICAy
MS40NjA1OTFdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RhKTogb3Blbl9jdHJlZSBmYWlsZWQ6IC01
DQoNCkhpIHRoaXMgbWVhbnMsIHRoZSB3cml0ZSBwb2ludGVycyBvZiBib3RoIHpvbmVzIGZvcm1p
bmcgdGhlIGJsb2NrLWdyb3VwIA0KMTQ5Njc5NjEwMjY1NiBhcmUgb3V0IG9mIHN5bmMuDQoNCkZv
ciBSQUlEMSBJIGNhbid0IHJlYWxseSBzZWUgd2h5IHRoZXJlIHNob3VsZCBiZSBhIGRpZmZlcmVu
Y2UgdG91Z2gsIA0KcmVjZW50bHkgb25seSBSQUlEMCBhbmQgUkFJRDEwIGNvZGUgZ290IHRvdWNo
ZWQuDQoNCkRlYnVnZ2luZyB0aGlzIG1pZ2h0IGdldCBhIGJpdCB0cmlja3ksIGJ1dCBhbnl3YXlz
LiBZb3UgY2FuIGdyYWIgdGhlIA0KcGh5c2ljYWwgbG9jYXRpb25zIG9mIHRoZSBibG9jay1ncm91
cCBmb3JtIHRoZSBjaHVuayB0cmVlIHZpYToNCg0KYnRyZnMgaW5zcGVjdC1pbnRlcm5hbCBkdW1w
LXRyZWUgLXQgY2h1bmsgL2Rldi9zZGEgfFwNCg0KIMKgIMKgIMKgZ3JlcCAtQSA3IC1FICJDSFVO
S19JVEVNIDE0OTY3OTYxMDI2NTYiIHxcDQoNCiDCoCDCoCDCoGdyZXAgIlxic3RyaXBlXGIiDQoN
Cg0KVGhlbiBhc3N1bWluZyBkZXYgMCBpcyBzZGEgYW5kIGRldiAxIGlzIHNkYg0KDQpibGt6b25l
IHJlcG9ydCAtYyAxIC1vICJvZmZzZXRfZnJvbV9kZXZpZCAwIC8gNTEyIiAvZGV2L3NkYQ0KDQpi
bGt6b25lIHJlcG9ydCAtYyAxIC1vICJvZmZzZXRfZnJvbV9kZXZpZCAxIC8gNTEyIiAvZGV2L3Nk
Yg0KDQoNCkUuZy4gKG9uIG15IHN5c3RlbSk6DQoNCnJvb3RAdmlydG1lLW5nOi8jIGJ0cmZzIGlu
c3BlY3QtaW50ZXJuYWwgZHVtcC10cmVlIC10IGNodW5rIC9kZXYvdmRhIHxcDQoNCiDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdyZXAgLUE3
IC1FICJDSFVOS19JVEVNIA0KMjE0NzQ4MzY0OCIgfCBcDQoNCiDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBncmVwICJcYnN0cmlwZVxiIg0KIMKg
IMKgIMKgIMKgIMKgIMKgIHN0cmlwZSAwIGRldmlkIDEgb2Zmc2V0IDIxNDc0ODM2NDgNCiDCoCDC
oCDCoCDCoCDCoCDCoCBzdHJpcGUgMSBkZXZpZCAyIG9mZnNldCAxMDczNzQxODI0DQoNCnJvb3RA
dmlydG1lLW5nOi8jIGJsa3pvbmUgcmVwb3J0IC1jIDEgLW8gJCgoMjE0NzQ4MzY0OCAvIDUxMikp
IC9kZXYvdmRhDQogwqAgc3RhcnQ6IDB4MDAwNDAwMDAwLCBsZW4gMHgwODAwMDAsIGNhcCAweDA4
MDAwMCwgd3B0ciAweDAwMDAwMCByZXNldDowIA0Kbm9uLXNlcTowLCB6Y29uZDogMShlbSkgW3R5
cGU6IDIoU0VRX1dSSVRFX1JFUVVJUkVEKV0NCg0Kcm9vdEB2aXJ0bWUtbmc6LyMgYmxrem9uZSBy
ZXBvcnQgLWMgMSAtbyAkKCgxMDczNzQxODI0IC8gNTEyKSkgL2Rldi92ZGINCiDCoCBzdGFydDog
MHgwMDAyMDAwMDAsIGxlbiAweDA4MDAwMCwgY2FwIDB4MDgwMDAwLCB3cHRyIDB4MDAwMDAwIHJl
c2V0OjAgDQpub24tc2VxOjAsIHpjb25kOiAxKGVtKSBbdHlwZTogMihTRVFfV1JJVEVfUkVRVUlS
RUQpXQ0KDQpOb3RlIHRoaXMgaXMgYW4gZW1wdHkgRlMsIHNvIHRoZSB3cml0ZSBwb2ludGVycyBh
cmUgYXQgMC4NCg0K

