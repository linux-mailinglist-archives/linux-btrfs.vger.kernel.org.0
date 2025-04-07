Return-Path: <linux-btrfs+bounces-12830-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1A7A7D3B1
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 07:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4967F16DB80
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 05:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C832248A0;
	Mon,  7 Apr 2025 05:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qNVxjaao";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eOs1bqDc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71F9224898
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744005399; cv=fail; b=hj63M5wCZliOP+vskpOnvSe9hw20I8etKS+qaLEcB5IIS8NaO19hRYVCXOVodQhVLXRrHc/wxFbG8fxoyoiqdn5adM4LYORlsLpP+osr5TAE4QvuimVNf4zy9aZqcrZA7pLS2nkKbgmNFUyvkHXHkZMCLjGnRssRKyoxvspuY/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744005399; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bLMbvoWsb8b1LKjRmqr/Sx38dZz10F28abPcMtSrRn+cFE1SlU9e61s/kaRSS/GoQJcslgLiMSYjq2pMSTVvnunhFGFJa0RbnGMNVE1enaq+14oo3m1KNk4e/FHtDMUs0DHJfxfX4u0+heaRCsYa1SjcmBLR6OXs0TxlaSSzdrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qNVxjaao; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=eOs1bqDc; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744005397; x=1775541397;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=qNVxjaaowsqKOPgiKeHP1TWE2/Wpb62ehuzwxrkk/Cfgt1woxQv+D9vN
   Mk3OWTz8I8cu+GAzZxUS2bZ7A/jL/zwDIyPIUONVIBPU9yduaBTbm0KMd
   oHAfpof/zvxcMaYzFFjgXtSrjmq6dLL3hJNwmzxLW3Ziho7A1xPXiQ2YY
   1UZSIBa/IkfPU+hFfEoMTSdVE30/4l7SbuhLO1FJkwjKgBT3v6E2AIdsj
   vTiJtwxt6HRYkLksDt2Rs3kRe9w13aWm/QQJUZfuJlAmrr53R3ofoADwR
   Y02ifkcBdEtFapcq3LDNRc6Pp9BXarzQnThwYums3Lr+BWcsdZBFvOTMF
   A==;
X-CSE-ConnectionGUID: VeTKbobeSOalgK1A5zXfeQ==
X-CSE-MsgGUID: oYKC/SbXSNSxaEMLy9rQvA==
X-IronPort-AV: E=Sophos;i="6.15,193,1739808000"; 
   d="scan'208";a="71915873"
Received: from mail-centralusazlp17011028.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([40.93.13.28])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2025 13:55:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reBwYk8hckTQ2eP3hud6vKsWF4nTh0vEKGlprCBRC2FxxXTmbQkOKIWQBGtYDsF6kvi7dxsDghFuJmafbkHrz87pfWCpANtN0kuGf0V7EDkJBaLxPi/hTc3YdcgwJuDcWa6Kqn7DBIhSdlDN962AsQS2eUnkL9ZmRk5rBbS8tYmIQeiNNaEj+DXUjjB0wsTdckLX2qn4BAunivOtPKy1A+QrsPTj7ONbX4Ub0oC28O3zoeEFcx6tcWj0msXuogCQGYgGGxOsd35E9xdXh6aCVKkTVRtxNyMjrJC5BWkHfbvi89zPgm1P4muYLjXgi+aDNQFzboHMSABOabDRVlLuWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=GVHEwRzq8HSxCxBCXW6eCCd3+k1aPGOKQlvy0XNv48rKKnXdQQYgxdFNHlxNfe6wyAF0hhLaMS0tFYAtWW5fiFy+0Une0Wug6FLJWFpUxtzvltmW5R9tKHWosg8KXG8CB/E+7snj+ILOR1su2OvN2GfuNWWBGruQqxyh6hOLaGR0Z7kdub1YXpPxJPwB1AFs88hvJ1XJHUNXUc0Ko90RUJWb8n60lgH91q1Gxhi54rAKKPYyDrRDqmshBXlqtm9DcJr4BzlnGNqmvlhq0fi7W2QnJ1Y25xTzsPUcOy+hUzCSwK647Uq3/ErGHZlqr2wlOa5Y0ihIWjtTbE+VQmnNzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=eOs1bqDcV6814RxhXePosBCKxoPQqaWMstCKAZ+djCzWsODB+xF/rli1lg4uD0gYYniKbudo/X3ltofc9hpA3vCvrsQoNWwYhWmBOn+GG/n6Zg9VAjm+xNFnZXlHAhz1edlnNd47F86QXcykk1myKszyhbeCnmeto3VRk0fIhB0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7845.namprd04.prod.outlook.com (2603:10b6:8:33::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 05:55:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 05:55:26 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix invalid inode pointer after failure to create
 reloc inode
Thread-Topic: [PATCH] btrfs: fix invalid inode pointer after failure to create
 reloc inode
Thread-Index: AQHbplNqax7uB0L5WEWQ7IGDhOtCxLOXtqoA
Date: Mon, 7 Apr 2025 05:55:26 +0000
Message-ID: <acd8e56f-c178-4a9d-9420-1a35dea6946d@wdc.com>
References:
 <9ac220a55a540ad22f7cb198856b689079f3e8c6.1743875430.git.fdmanana@suse.com>
In-Reply-To:
 <9ac220a55a540ad22f7cb198856b689079f3e8c6.1743875430.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7845:EE_
x-ms-office365-filtering-correlation-id: 32e47db1-d4b5-4cae-93a0-08dd7598cba6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cHpYQ1NlMHgrMUxrcG42bUxDNGFaSVpWb0RHdFRZQVdxcWs4Z2JQSDVNL2xj?=
 =?utf-8?B?V2dSbHcvaFljYllWaHgwNE9tUTNXK1I3dmZkM294SjlNK3FTbHFpYXVpejBD?=
 =?utf-8?B?WVJCQ29Ca2RWVllPMzBNM3NJWkhVZmpwejBhSk54U1pvRUlGVnpZdnN3bC9D?=
 =?utf-8?B?WjFycFEvRm5XZG5WR1UxVC9yOHhUVFEzbVpZWjcvOWdoQXNFUGZqZzNGcURO?=
 =?utf-8?B?VExXNkYvRzQyZ3JaOGdScWhtTHVCNjZST1IzdWtESHdJZDFGMy9qVVFYMzZV?=
 =?utf-8?B?TzhUK2RQTUlpbjRHS0Z6WDlHNDFNNUhNakoweTlrM1QyZU1VTzRPSnVyVXZo?=
 =?utf-8?B?SVpmaHFtQ0Q2VHdUdWxlMUI5QUV0SWNmVHA0WnJadG96eFd4bW53SDJmRzFk?=
 =?utf-8?B?K2JFdzd2Y055V2FKcFRqYWZRQ2VJbTlEWjM2NTdSS0loTHZibWl5cTN1Q1JI?=
 =?utf-8?B?Mk43cFpGQlpYdzJaK1cvdktpajhKQnd4RUMwcm5nY3hmWjR4VXVHVExqVmgz?=
 =?utf-8?B?LzY5ZXBmZDhtZ05xS284L0FlN1dCRUI1c3FiQlZFaUkzYmRsQ204WTlzUjI1?=
 =?utf-8?B?ZzM4TFlHQ0YwT09rVk5tcFFRZUJubTRCbmNkNDR0UVNDaVBoRk4vZDZqcERD?=
 =?utf-8?B?RkVPRnhqTVlTZHNBcTJPRXFwTU1UTTYxNDZ3K2VLZG00NHJkWUNRSnJTUmp6?=
 =?utf-8?B?RU9kNWxjb3ZwQnBKbUo0QzlldGp1anZLUG05cTRJYlVJUFZ4b2YzVkU3VGRF?=
 =?utf-8?B?cmcyRTUwbmd1TnJ2eGtDR0Z4SlgzKzNDWnQxeGdib2JVNkN5VG83VVB0SGdV?=
 =?utf-8?B?SThSVXpuekVHRDFQdVIzazMzWUgyNWtjK0w1SjVqTGl0VFErZWNibkMvdHg3?=
 =?utf-8?B?R3ZhZ1FuRmhxYVpMUmtvQTBGVkxab1dTZ3M0V1pnZXlFdDBmRUZxeGZnWTJO?=
 =?utf-8?B?NFJ4RER2Mk9HTUJad3l3YXp4NGFHNkxtQXNlZDgxMkRteVBIeEIwZERFSytl?=
 =?utf-8?B?MEtFWi9mWUdpcHc1RkpZRG1mckVHaXpqcnV5TGJ3NjBibG1HQ1lvTnNkZ21O?=
 =?utf-8?B?emlBUVlnY1c2MFczVEZva05DRXlmR1BHYlE4M1QzKzlwNlIwUVUwVy9EYnk0?=
 =?utf-8?B?RHNTdUJVUzJGZUlUOEZpSERPTnowVjV6Z3lZVmduTWVoTDlHcU9xNEp6TkVS?=
 =?utf-8?B?aXhqd2p5cHpHRE5Jbzg3ZFVEWEpFWTNLVWJmQnJnOVpFV0ZwQnI5amdpVHVH?=
 =?utf-8?B?SDdNV0dDa0FZYTlzSVV5MExKbjBPTmlaVTdLdXF6cktzZGxMUUNrTVFWUTBN?=
 =?utf-8?B?VnNvTFFaYnIxSkNQR1JNcFoxdmgrcUVMZS84dVNPenZudTRTY1l3RitycEpk?=
 =?utf-8?B?ZG1yOU91SjVwL0piQVo2MW9reE1pYnkrME4xTGkzV2NHaWtVUllJK2d0VTRM?=
 =?utf-8?B?L0laOHFMaVdJWTBWQXFNRGpnZzdMU3FqUkMrOEdzZnppVjRsT2xtajB1NEU2?=
 =?utf-8?B?U0VoQXIzSGdvMjFnajZGejg0WEFMSHpYakRzRXp6REtSZFF0a2dISWduU0Rt?=
 =?utf-8?B?YmE2dXI5dnJIaGFRL2Y3ZVZrVnBvN1IxQ0RDcG1TY2pTdWV1RGFCSlhBVW15?=
 =?utf-8?B?WmlVRHZmRzY5ZWNRdnR3VWYrWGF3bzZPY2J1MTFVZGhkTHF4eHJLS2NqNXNH?=
 =?utf-8?B?Mi93SjIyNFp2NG4rV0szVm0vcE1wY0k3Z0dzcERXUVd0WGJkeVBrZy9DWTJR?=
 =?utf-8?B?ZHo3Q2k1c0hKVTF0MGlSZnpFTDQ1T2J3WVJYQWlLZDhsVUlqVERaV2o2MFFi?=
 =?utf-8?B?UjRKSUlIRWVScDJsSGl2SEV1bTcvc3cwckFqbjlKNGMzbjh3ZE1ZeVFNcjYr?=
 =?utf-8?B?bkJxSHVEY0hXQWQ4NGNXVit0VDVuNmx3TVpuOVZweEMxdjdjaE1peWtFSzhl?=
 =?utf-8?B?b014SXJOdDc2T09rbU5yZEdMNkN4akhQeURJcDZZdlNSeWZmbVdvQjRaWG5r?=
 =?utf-8?B?NGFOUFYvUCtnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDIwWlNJbmNQNUd0Q1RMd3ErUEtLNmxPWXpxbzFTaThQSlg1NXFGcHlQOU53?=
 =?utf-8?B?ellmb1hmb2VxVDVPV09GaTF3RXlyM2JWa3B4amZwcmVzQXloeVpzUlQyai95?=
 =?utf-8?B?NWk2QWx5R1BrQ3Rrdks5NEVWRTJPMHpVa3k0aVR0ZG4zVUhQR2ZMWktvZjVk?=
 =?utf-8?B?T2pnS0VuMmlnZFVNV240ZUh3aDFwWlBYKzAyekFrekc2bmtkMGNjUXE1NUhO?=
 =?utf-8?B?N1FEcS9UZUkvQ0x5RjJlYzdFbGdvRWZkU2ZaaEg4MUZmSlJWZTdVM2Y5ZVBX?=
 =?utf-8?B?elowZ3h1cHBZYWRPTDNWaFhOaHJzZlVQWGhpNGpGcFNXZmlKakl5ejc5M0cw?=
 =?utf-8?B?VmNmemljV1NUSURvYjZpMlg1d0FObXlrc2hDMldYcFVkYlpDTzMrMmNoSGZH?=
 =?utf-8?B?bytxaS9NN2hkcjU1VGZGYTdnN01mSGtud0N6cktqdkJYSXVFMWk2cGdDUmJu?=
 =?utf-8?B?emJ3SkR1a3E1bjZqcDcrUVkzVFZpd2NURCtaVGF1Z01zWWpwWXZjOFB4WTd5?=
 =?utf-8?B?VXk3bDQ0NWlCSnpmV0ZHcHVSbm9sSnFTdkR2RDZvZE5NK015SXFhNDVKL1Vj?=
 =?utf-8?B?bDNwbm0wUW1EeG85SUZmRE1xT2FlcUJjL1FUUTVjTEhwU2JieENBOG9sUzJn?=
 =?utf-8?B?endJQ3dpRTEwS0xRNEJDSVdHS3B3RDJreTh5dk9sbk1JMTdCQVNiTkY0NDFs?=
 =?utf-8?B?SFBaWXpGaFJsSnZzOGdCS3ZZV3NaWnp2V0QrZjA0TlpmaFZ5QXZNR1JCQmhY?=
 =?utf-8?B?YnBvaDY1b3VOVDBhUGJVcFFrQ3U1TGQ2Uy9Fb2lTUTdSRzFGK1ltNUh4bzNK?=
 =?utf-8?B?bnpBVGZOTEZZMmIrZVppWHJESFRiZXRpeXpWbVpCQlB2bHBIbXd5V3dqVFFV?=
 =?utf-8?B?Z3Zub0NrbkY0R2Z1dmU5eE9adnZaUDVPZHA4c2RBR3Q1c2JWYnpGeGxSUTEz?=
 =?utf-8?B?U2htWTZLcXhWZTc0anhGMjl6MVR5b3dNeWpTc2UvU2R1UlcrOGxIeFErK1JT?=
 =?utf-8?B?QUVJM2hKUUVKcDBxVjMwYSszakREeFhGVGMxMVJLQW55N2pnQUF0V0hyMk9Q?=
 =?utf-8?B?ZmxEQTVGeHAwMmNaa2NsVlNHcFp4K1RkcDU4VXBxVDUxL2lTMWx5Q0Z1bk9Z?=
 =?utf-8?B?bnRWdFBXWE11UlFIam9DOTd5WVo3cmd4Y0Z6OGd4aGxFYUtyeEVvcStxc0xP?=
 =?utf-8?B?Ujd2ZGRjZkZaV0FjR2haWkFaUXEvVVRYWVVRWEFjVmpudzF2OENORVo3QmVm?=
 =?utf-8?B?dUFKUVFMWGZsTW9GSWU5ajY3M3NrNG5mN2kvV09xc204YkVrQmZRVzg4OHRS?=
 =?utf-8?B?aVRCRzk3TGJXYzZvektYVnFiVEdBS2xudWMvQlhzYk5MNVRBTmhBeFBuNDRP?=
 =?utf-8?B?aWluU2Z4ZzZxRkNLb0xZbys4TkllZ0QwQXZrNGdMNEUvUnpqM1QvNEFUdy93?=
 =?utf-8?B?QkpaTmk5L0FQR09Bb1gwUzYxSDhHcCt2WkQ5WXJMdUZSZllEckh1QnU0MktQ?=
 =?utf-8?B?bklGb0tZVXFuZTd4WVJrdFpCRDFXZ3ZFVEdZQnB1U0xqdmY4bE9yQTBWMTB4?=
 =?utf-8?B?SHZLRzR0RWVmUWRSTU0xYUxjQWhTSVIyaWZqTDAreEc3NytzbDlQYzRiS3hi?=
 =?utf-8?B?d05sK1FTWHNMdzBDUXREOUIxQ3dPMUl4Vmc5RHphSlhzWjZqREZpWTVKdWc1?=
 =?utf-8?B?cXRXc291S3dISVBHS0dHT0w5WkNkTkVBWGdrcml2UUZFTUViaGJKNkI2VDQ4?=
 =?utf-8?B?dS9sbTlrNGU3ZUFkNHV2OUc1TU03UjFSSkpuUmZQd0VmVUs3UlU0UG5MdGhw?=
 =?utf-8?B?OVN0c0tWNmlEMEh4U0YxdnlET2hZK1JoWTJtMk43ejArUXRsSDVoTnlDZzRk?=
 =?utf-8?B?dWkvVjZ0R2RIcG9lUmNHZis2ai92cGhyekxTa2EzZS9MN0sxcElmNzJJaFB5?=
 =?utf-8?B?cWZoVExGWlh3Z2crTGw2MnRCbHcvNjE0Q2lPWHgwaUdBbW83ZWRjR1dZMW1X?=
 =?utf-8?B?WjVxbFQxbWtWbFVyMjV3aU5zQU04Q2ZGOFl0a1JWRWQ0RW9KSGpWQ1d5ckw2?=
 =?utf-8?B?NGY3dXgwdmYzMGZVTks2dG9qS3ZoTm5aUzJ6cFBQVHZoYUdMVDFwVmxtU1M0?=
 =?utf-8?B?cU93Sng5QWFjTENCYjRqVmpKVGJsRUNoc3VHQjFDZDBSVUxRZXJFanpDOWJ3?=
 =?utf-8?B?UWVOM2FLTmVFZk5jc0d5SVkyWDZOTi9rS3hneG1iR2FVd21rZFhCZnk1NDJH?=
 =?utf-8?B?aFdBRkdLNklpMUFXL1E4NS8zYUpnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA59C7E3D0079A46AEF09378337DB92D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4AHgWbOfIqd6nmErxVilZtnbmPChlRsTNYGHRdKLubcxVwzB98wOnLBUPn/QugdwTNfEOd9dJMIq0pfUIua2SXz9Gzi1X17QQYLYhoMn/+M14UDeICLfzw18vI3bN9e5bptOLHv9UzPC33AyfSg0ylK834Lbx8/6QMn1V0iVtV7jxcx2QXsC8GxBHgXZaDIStkHXQxItskO6EspylMsuZRcnXkP/a+BLGZGJKV8N2XYM3L5dBO2Z8+0a+LEnCBY6rNQNKT7Tr75xRWtQWIaswJJnTbaj5koPvcP84emRIwHFsQ9xOtIH36PAsz/iJHfLyQmoPzZQj4E550OCT0Uckkt+OYxwzjb6b7/JNFMSvoO0IHPpR8MHUrN7FBkdh828Sbuk0584o/tSZrfoXwb/qKijVk372Mivrs5shVBcGW7cQsgkPQUm2V+JpDKA0/6X3ZctN54eaflKgaLmrt1Xxxa3r8UnYR85pJ5PyypTTtIVC47OiOM6+cczoMuK2q/53yXjz/gWblEznxP0Ai8j2r6XJ9mYKwWXAmVPTRdXI3wvF1FMEJujMugcc8XSCmqj6efjDfVfb7uPt3hq5cxOkHU7HnEaHp+fju9Q6bmxZAxBEVivwigMctzLnbmymIEz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e47db1-d4b5-4cae-93a0-08dd7598cba6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 05:55:26.8118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBEwHQhjoq5BDHlLj+TtxWywUQWEaxLybptjkaXIHzzobTUegm/cI+zaCVdnjp9RomF6AcdNo4QiQ11RdlJyUX07YQrSxjfGBqH3hfm3V9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7845

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=

