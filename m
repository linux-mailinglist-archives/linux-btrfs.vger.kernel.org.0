Return-Path: <linux-btrfs+bounces-14948-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB74CAE8190
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 13:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0EC3ACCFF
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 11:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D3B25FA06;
	Wed, 25 Jun 2025 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oIgOdGwj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tyAIY60r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DC325EFB7
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851311; cv=fail; b=Pe1c+Lo4OjmynxD8eWF5BMnN8U/sVmjLX1aeeTXGCxasdHkwrX1phS2RGk73W39kzt/Nm200q7zrX8yxAegB9Sq/LS1GfolM8GtUyHlEb7Fb/6A7ZIq4KIbK9ok/y9sjqWoW2f8IpQWSWU+Nl5mUXnRhFR7ZDu/ZNi+WI3dFKk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851311; c=relaxed/simple;
	bh=51wDYf6AGs8AWLd0G+lf/mjbchbIaU6VM/zBBKoPWas=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CYVsic3eiQUTQ/KqMJF5pkPL3lFuHVepu+lggKBbfM2VfX3EmVgrPVX+LOYj9iOG4lamCWZNlpcZeCPC6hx6FiUP2lYalCFftJgE3QwN6V2isRKizV8ZhyzaYOD/wTPq3b1yG9fQ9Dep5x3/51ygMoKKw4O9t9J5CJ+SswQbowk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oIgOdGwj; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=tyAIY60r; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750851309; x=1782387309;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=51wDYf6AGs8AWLd0G+lf/mjbchbIaU6VM/zBBKoPWas=;
  b=oIgOdGwjQ7Wiphn44408MIx9nUI3zbTPlW7FWiC+JABGuNr3Um3bmAy8
   WBJOLJ73nBX5gFf1xX9hDzx9FSQ+zNOe4u4BXM4Big4dl7gG1Fvmf7nqA
   SYyxiS3X98dTcXwVdUISSkbgzbmIMINfmtIBhWXPQ4x1MRsYVVbPrHjFb
   HX3Z1L39kfyA0WFE39iSwvLPc+341b0oPOJzuz+d3mN8HMpR622u4jpBK
   jQVpiGJxyL1RIo2Oz867WfsXuqiLiXRgCBGopDDxPs82yJrCH6MS1aGEn
   fCeKREBs6jrKLrjZf4DN1fHhQ+8WvVcdaP79c4xrG4OIQVfk8niqK8kdc
   w==;
X-CSE-ConnectionGUID: R1CzXA3/Sx2pE2azaTxZlw==
X-CSE-MsgGUID: K+YBh37HSxKZZn3aTwdN8A==
X-IronPort-AV: E=Sophos;i="6.16,264,1744041600"; 
   d="scan'208";a="87198173"
Received: from mail-bn7nam10on2065.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([40.107.92.65])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2025 19:35:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCX/5j5qcZ2Q/OlkXb3vsAx/nWfE+rTfyJyA3sHwZ91HcHxwAN9MEyWzucfob06WS9wKob3l5id29CmCKe4f2Ees15Ch8liCRIS7OvZojbCqiIsqLF0vx05cwJ8jh7YY4O+1cdH6ykYCH7U09/etU4kmshdWK3RcUDOaed7RAM2rLG+sLMNWkFYwVlFH9oDXSByrH5WyS8ZlJnyiRm7GBNbtYp6WwcmwGBvPfHNM10+gWKbd0l12WQOYxhSn1oMdxfaSH6yQMUlqtKka1SDi8Wf94CmZ360xFX1W1JpWG8vIota/j6AE8+imUyCr62Q5klwP+HIc+PciV3uP/rB0YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51wDYf6AGs8AWLd0G+lf/mjbchbIaU6VM/zBBKoPWas=;
 b=UL1fahETztehVs9ASC+XDlefblG9FFyFKbTwUTlQoleMVMKPUoQVfQKse2X8T4Ypdsqct2kAuItpm4cBgA0ecPtg/I7OtWHwXPDj11OPS7GDaBwNgXnLCuNnRLlRlQjJt7HujTlktl5b1KDlaSt8HBimaUQVGCfiHWWYE3LM3oUU8hUsplWhpsygdsrwKaD2rzs5MoUNuHZgh/WNYpSn/RNftKAL3J2lN/Zh0mViSP2ampX4I0sMlfC4Yio555/xfUBbwgZTPIAgjMrUJpEqiW6u0VDCHpWYHeV8Jc3wemC6pGDYoBVR8j2oIxUk97IN1dJHGJ6EUV1Kv2+wJx/X8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51wDYf6AGs8AWLd0G+lf/mjbchbIaU6VM/zBBKoPWas=;
 b=tyAIY60rJzB5qY77ruO3F/3+AB7Ib64RqyBLMFR3oI9VsSn1c2gN0gQe3lltPbzO8WsC2s9ulEJGKURpTTsOQ+gDB6LgANGchAAE7IC7+EYx36Dijx4Fb6EKdfNRZ904l5DaOaS3TlpnFD6BSu3TyvnAa8sHHoQPdEtxWqEDS5A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6857.namprd04.prod.outlook.com (2603:10b6:5:249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 25 Jun
 2025 11:35:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 11:35:04 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 10/12] btrfs: split inode rextef processing from
 __add_inode_ref() into a helper
Thread-Topic: [PATCH 10/12] btrfs: split inode rextef processing from
 __add_inode_ref() into a helper
Thread-Index: AQHb5Rghpz/RmLWSK0O0lioCtaYKJ7QTwDIA
Date: Wed, 25 Jun 2025 11:35:04 +0000
Message-ID: <c6de293d-e194-425b-b87a-53805bf7b7fc@wdc.com>
References: <cover.1750709410.git.fdmanana@suse.com>
 <77fb4fa12feec93ced283745958274bf33747104.1750709411.git.fdmanana@suse.com>
In-Reply-To:
 <77fb4fa12feec93ced283745958274bf33747104.1750709411.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6857:EE_
x-ms-office365-filtering-correlation-id: a6705b88-1572-47bb-d819-08ddb3dc5495
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eHpSWW5CUjhiSHpNUHpZU2VNa201VDBRTXNta1l2MGZuVzdlZGJHdXkzbHcw?=
 =?utf-8?B?NS9SUzE0aHVrajVTcEVhNFBLU09DNDBUV0wxbEtQOTArZkdpeXJBTWJ1UzJ1?=
 =?utf-8?B?RUE2cjhENzVoQytmcTN4Uy95bUZrTFR3emRtQnNNaGZTZzFVMksrZ3J6R2VM?=
 =?utf-8?B?NlU1T1RBVkx4ZzczcTJmV05SSUFtNTFOT3NsWFdpaE1NSjdZUms3c2N0d2E1?=
 =?utf-8?B?SUlYc0tmdjFYQ2hwRDlDck1RRjRFVWVsZnI3REszTFFnYWhaU1hFNUR4SGh6?=
 =?utf-8?B?eDRUc0FoSExqeC9tTGdNU3FGQkF0dVM5cDJkSTBFZDY2dGtYc01mazYvZnM4?=
 =?utf-8?B?bWFPZHRMNExiZ00vSTFLYURkM1V1RE83d0NoWEtGejRwc3RKRGMycGEvN0h1?=
 =?utf-8?B?c01YUWlVaUJwdnd6Y25FL1E0S21BMTM3RXZ4R3VBRHJ0Q2JyNTFxcSsvdXRU?=
 =?utf-8?B?UG5Da3Q0eW1lMlFZTHM0V2NQWE5uVzlPUlRDNWl4SE1WbDhFS2VsYVl4WFgw?=
 =?utf-8?B?NkNTVFcyVzhRZk5KSGRSOGFaaXBxd01IWm94UjhqT3V2bXUvcytEQXp3Q2tN?=
 =?utf-8?B?NVdoQjJMekNjd1JBTk53WHFGelZkeFhVSTdPbThiYjZWZTJ0MGhzalJuVDhP?=
 =?utf-8?B?Qkoya0Z1YkREVlpMeEYwY3Y1SURwN2JNQ2ZiWUZvOSt2VXFKY3A5OTVPb1FY?=
 =?utf-8?B?MlNZR25uR2R3N29HNFJkZkdXVFRiUDRLMHExZ293WXlkSXcxTVhtd0RlOFdP?=
 =?utf-8?B?c2xBT0xTYWN5Y2NYRDZWbFRIRlNDbFF2MHhmcVVqMFRKSXRsQXJ1OHhXaEFH?=
 =?utf-8?B?d2Rrb01DRitIK2N1U2ROeDFaRGxENFNjWUhRNDZwUlJ1RTBOTW56NTFXR0Ja?=
 =?utf-8?B?Y2xMbTgvTUpjNVM0c2lnUEt6c3Nxek51YkplWnlBMktudHZBc0s0TXhtb2JW?=
 =?utf-8?B?b3dLTE9FSTFwRmRuaWdlYTRBTWFBR2hTdlR4RUdBd3R1NVY4UFdsNU1CcjM5?=
 =?utf-8?B?djh1SGV3QVhJT3FCVDhUMkdSWDlUTmVjdW9abkI3ZjdqV0YxT1lpdmZlWExh?=
 =?utf-8?B?ZWdLeHdvY0FIWnVkbjRSd3B4LzVoS3ExT3VwaDdZb0x4WTkvRTJGVTJtQ2g2?=
 =?utf-8?B?eGhMYTdPR1F1SXc4a0d4TTliaXNtV1gwc1VET1pFTnM2bDdHc0xCaUl6aVlT?=
 =?utf-8?B?UE5aeit3UVBHRFF4NjVuUkhOZzNlZFRPWDI0VE84WE9iVmk4ZDdqNXZrRC9v?=
 =?utf-8?B?bnRQSGN3QlV2L2xPMW0ySWJxbm9CYkg0QTNBSllzNHFBUi92UFdkLzl6aHRk?=
 =?utf-8?B?bXR1dXY1REFwYUNWMTM3RGZTWVVaNm8xSDliUWFUWS8zWTZITHFVcGUrMGF3?=
 =?utf-8?B?VXpFTzdMSjBGOFJ0NUxTMk9qVE8xY0p1aXF4b25DVXFpcUx3NXdvSjRkU2pO?=
 =?utf-8?B?SHF0ZHpRTDdaamdTK002ZHhBWlNOTW9xcTVTN2FZOURGUUc4cXdCcG9rVm1m?=
 =?utf-8?B?YldYd2J6eVBVM2pBeVl1WXQ1amxOMHZaeHg1Z004VUk0bWxGSFFHeGJGbWtw?=
 =?utf-8?B?QXl2OXhyL1VTUWtVb0g3RkVyeUpXM2JBNVJDMWwxUUh2Q21XTktVTzk5ckUz?=
 =?utf-8?B?WjZyQW9Fank3SE5tK1ZSM2RjejBOZUJNQUhheHBtMVJ0a0t5d3BlVVEvZkpQ?=
 =?utf-8?B?ZThpZzcycWoxbDk1ekN6enRvV254N3RiQUt4YlQzcmlHbUJxa04vSmlFRkJv?=
 =?utf-8?B?ZkNFK1JRWlVlcktKYzQreWZoczNMeE5BRDNiT3RDQ2R3V05CS0tHQzI2eVJ0?=
 =?utf-8?B?U2FWd2NXM1EzRlY5eHdtYjJ2UFJkcGQxdWZBbTNLV202a2tWQ0NIUDJONk1Z?=
 =?utf-8?B?bXFPQklVMFBnWHlndTBMZUdldFd1Y3d4RDNQTWRsS2g3Y01Kd1piYlVicnJ5?=
 =?utf-8?B?TlVtR2g3TExaNzRuTEVaaUVwZ1dDMUdhVTJrK0N5WU9sS2h0TTZSTmU2dExw?=
 =?utf-8?Q?PrgpBDv9A2nT0PIThlcv4oOzg2TSmA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1lndm1PdjNqdnduUWxsRDNhTDlZVDBGMHdzcWJSeWwxWUJ4SHQxVFRmcGJP?=
 =?utf-8?B?Z3NLbEdSanJWNHdUZ004VzFFVTZ5QWZubktHaHI4QXRyZC9SWFlsVjE3RExX?=
 =?utf-8?B?L2laa2NlYnBiWEdZSmN3b29SZVVEbU5oUzl1bUh1NVYwdE9OU003TmVPZWVl?=
 =?utf-8?B?VU5WUW44TDFUQnNSQUYzV3dTMlhYSFg5eGVJMWlWNDFMNEVNbWtCVDB3Z1kz?=
 =?utf-8?B?SmY0QmJxN21hWFdJQkF0ZVJDVWJTb0xNaGV4Y2h6NWtxUHZVUFd6aVVzcFpN?=
 =?utf-8?B?eEFiRGIrdzlSTXpYZ2lMaUdRbTROV01aNlR1MU5WL3lZU3ZpT0UvSi8rZEpI?=
 =?utf-8?B?YkdiQXNSVkFaU3NHaHRoVmNNVmNjMjVOQ1VYREhJdEM4bzhxVFVtbUJ2bzhL?=
 =?utf-8?B?RXJKanc1c2hLeXY0U29udDVHRCtvazd0a3llOGFaeFNaQzRGWElZQVZmMEZo?=
 =?utf-8?B?TndqNUFqcms2Y1pPbi96bmFNSmlnUnZGamZqSW1hcktWZG1KWDU5ZjVSODh6?=
 =?utf-8?B?cnlpUU1vZHNKaERMeG5vOFgxNXcycTBaU2RhMDFhNE1sa3BIZFR4UHBQYkRH?=
 =?utf-8?B?TzJtekNIaEpSS3REYytFVGxsYlgyN1NodVo4WlhoZGVORjBiSDNGUk56NWFl?=
 =?utf-8?B?RXVTVTB1aGxyUHNXenByMUJQNklVdjRIQzRUbnBna3Z5REIrS0xYUGQ5VGU1?=
 =?utf-8?B?UENoSmVLUk1mYmZxZ2RyWWhpblpTbzJsR1RuMFFkaXJVMVZ6ZENvank3NG1X?=
 =?utf-8?B?clhGTGhYREh5TjlQdjBkZ2RPMFJlb0E3eS9uU2R6RWRoV3NLYXl5VVRnQ0pE?=
 =?utf-8?B?aUo5OGNod1NhSlpGWlR0V2ZUdU5Kc0VOVk1KeVRLeW9LdzhpdHVzSURXSWlO?=
 =?utf-8?B?dldoTWNQbGlaOVpqam1ab0lLV1E1czJNMXlSenBKSlJudlZPK2MvdzFTVk1r?=
 =?utf-8?B?bXBYQzhzOENOOEFVclRGUUpMcFNYUkpOZUtTakdZUGRLaXVSRzRJUGhVR1h6?=
 =?utf-8?B?QWYzNFJuVUN2clFjSU9LbGp3NmtyOXp0SHRybldvcTUrbG9zaUhUK244Z3Fv?=
 =?utf-8?B?VkE1TU5RSGlaU3hORmFVSkt1SmNoYWI0Y25IWEErTjExS1UzcElmdEQ2OHNx?=
 =?utf-8?B?UktCV1dNQkQ1NmwwZFZiMjFVSVZKV0RHQmRHRXhwakdXSWREWHBDZDdGZzJE?=
 =?utf-8?B?bUNNbm9mY3h6K1Y2eHN4bUd3S3pleThVdk9XUXVaYkNMeE4wZFIxZlNwQk1E?=
 =?utf-8?B?NFJLbkJRTzFGSi85c1plU0dBb2ZQQWVCSFl0dE5mSVlKak5sN2o2V1g3RTVj?=
 =?utf-8?B?cWszcmRuU1cxa0d0a01pdGI2ZFJDcysvQ0N5S1c0VEc0YUhJYTlzUEx1VTJs?=
 =?utf-8?B?YmZyWXlhdWZBWFRNNHAxb0V5cGd4OXM2dUVWMUxPb24vbHE3UXFEc0xuTlFR?=
 =?utf-8?B?dDFBam9BUC9MZjJFTVlBMGFDdzNqdnNuTjl1TGsxM2d2WkhOZTZwd2lmdjlM?=
 =?utf-8?B?NFE3cE5wVHdiSXNOSUh2akRiUmV6OFpoYzdHdG5YaExhRXJCcTBOWlVhRXZS?=
 =?utf-8?B?UlNxWEVaOFJXV2R0UW5GR1JxSG8vL0I4djVoT2pETkVhcG5SNGRHSCt4SHAy?=
 =?utf-8?B?Rzc5QUJPR1M3YzJXL1duQXVONUNZUmt1U1UxMksxMU5GV2p5VlpqVk5tQWp1?=
 =?utf-8?B?QkxiYjZFZjI3VnRna1hNaXdXVkgxL3hIK0k1UjhXWk1HWXg0VGV1cGMzTWFk?=
 =?utf-8?B?YXhmYWVhVjFHa0JvaXV5VWYrcWNMZk9aeWVWWUpONTBEQVpyeXR4ZzNhQkoy?=
 =?utf-8?B?NVlDUGQwS3ZKSlh1Tkc1aC8wOWxHNWpCREhwRmlDL1ZYZE5XN3ZLVndVNHRm?=
 =?utf-8?B?Z3kzYnRBRUh6bldUK2Q5SVcwdjAwRllKbmNtc3d0UjhyTklJY0RERHlpTCtG?=
 =?utf-8?B?ci8rWFR5amY3bHJSbHBNVFcybEFjL0NGeTB4REd0SU9MN2VhVVpHSDJOM2pu?=
 =?utf-8?B?bUpSSVhJS0Y4UTJKbm81YzdiVU5SS2tsVWhLcXZLbnBlL2NFYkxzb3UzV3hF?=
 =?utf-8?B?c3N1YXYwdWR0NjRwNHBodEZ3U25uYmovV3E4MXFmN3dDaHJja09qSFYxUzNw?=
 =?utf-8?B?eXNKRmhxRHp5T1Z4a05ORVkwZTBOVEVZdFlwS1V0Zi9SckhCMkJvZ0RnQ29D?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06AAE431A47530418B2DC2CFB774945C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g5QPr1aCJLqffPf3HvVw8ZJ24ZNnM9Hvsui1nNVzQvUt6u1JAMgeRIHbuVTKvZuFnoF6ycKzwmcBNoJPI8Ixpenevd+m2+Y6/a5ckzBw0vkLCpV92GaTxaaAutWP3JwzjDXfPyJrWkX9QfNzej2rYzeGujurTd7IPRccwU6q/xmyzuz5UnUbkT1DlXH2sTwM05sa71yfgu/RksuKAudnbDoXxIIIWI3LO2mxV64exNLY3ZRjUbE6tpMQOHTb8l3GnTRRbmGSqSmlMtwOaylXQaPglVdODiPdDwOLV4mnAIfMBRjSVnz/Mv4tCr9+Zn8qiKBzYHtmV+oMT+QxCYUhKbMStnMRPJYhOU3MuQcfy06sp38ngoNEhdIqVpl2bxW8eAZy8vdoHT7qLfyk9xnFcUBg2EkRocUN/QFa3lB54FinrReobcAYFeGMTmMjaETAWbyP+9Qwnl4w5hTvX/2IZkkQetHtDOzBHiknQ4/hlauIcE2XfAiOu8mpQ7ak5R79y/NWgjnR/aq3L65kdMVC3BI4sMndEbOxtklnVJ0L5DVJPwMR0qh4uwPDj97JHg9Tg9CLlU2PovdwxnlUPvuCklo04kK8OgS6uCWIpjnv3z6FuRwaKUJYLNs/hKDwzCNA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6705b88-1572-47bb-d819-08ddb3dc5495
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 11:35:04.9724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJleMKdDGqaYoDzSNguPtM909CAvmlxU1WB1bZc+39AXy2bbIhhuHyL9wUCdDHSF4mryeudp83GvBiJ+MU5TVBcuVzGGH9zIOPJKVFnPbUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6857

T24gMjQuMDYuMjUgMTY6NTYsIGZkbWFuYW5hQGtlcm5lbC5vcmcgd3JvdGU6DQo+ICtzdGF0aWMg
aW50IHVubGlua19leHRyZWZzX25vdF9pbl9sb2coc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAq
dHJhbnMsDQo+ICsJCQkJICAgICBzdHJ1Y3QgYnRyZnNfcGF0aCAqcGF0aCwNCj4gKwkJCQkgICAg
IHN0cnVjdCBidHJmc19yb290ICpyb290LA0KPiArCQkJCSAgICAgc3RydWN0IGJ0cmZzX3Jvb3Qg
KmxvZ19yb290LA0KPiArCQkJCSAgICAgc3RydWN0IGJ0cmZzX2tleSAqc2VhcmNoX2tleSwNCj4g
KwkJCQkgICAgIHN0cnVjdCBidHJmc19pbm9kZSAqaW5vZGUsDQo+ICsJCQkJICAgICB1NjQgaW5v
ZGVfb2JqZWN0aWQsDQo+ICsJCQkJICAgICB1NjQgcGFyZW50X29iamVjdGlkKQ0KPiArew0KDQoN
CkFnYWluIHBlcnNvbmFsIHByZWZlcmVuY2UgSSBndWVzcywgYnV0IHVubGlua19leHRyZWZzX25v
dF9pbl9sb2coKSBoYXMgOCANCmFyZ3VtZW50cy4gVGhlIHByZXZpb3VzIHBhdGNoIGludHJvZHVj
ZWQgdW5saW5rX3JlZnNfbm90X2luX2xvZygpIHdoaWNoIA0KaGFzIDcuDQoNCk9mIHRoZW0gdHJh
bnMsIHBhdGgsIGxvZ19yb290LCBzZWFyY2hfa2V5LCBpbm9kZSBhbmQgcGFyZW50X29iamVjdGlk
IGFyZSANCnNoYXJlZC4NCg0KSSdkIHN1Z2dlc3QgbWFraW5nIGEgJ3N0cnVjdCB1bmxpbmtfbm90
X2luX2xvZ19jdHgnIHRoYXQgY2FuIGJlIHBhc3NlZCANCmludG8gdW5saW5rX2V4dHJlZnNfbm90
X2luX2xvZygpIGFuZCB1bmxpbmtfcmVmc19ub3RfaW5fbG9nKCkgcmVkdWNpbmcgDQp0aGUgbnVt
YmVyIG9mIHBhcmFtZXRlcnMuDQoNCk90aGVyd2lzZSB0aGUgY2hhbmdlIGl0c2VsZiBsb29rcyBm
aW5lLA0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJu
QHdkYy5jb20+DQoNCg==

