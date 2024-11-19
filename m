Return-Path: <linux-btrfs+bounces-9764-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FDF9D2B89
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 17:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23589B31BE3
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 16:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7F31CF5C7;
	Tue, 19 Nov 2024 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lLeInjF8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="d6qhQGTU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACEA3C463
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732034306; cv=fail; b=I/BTTJrLvq0jpHRpBDiERNkmusW6KkodXGw+wegP5n67px/avmKRidRiyLCpwpVWYG4CXkv3RYd8bWj26FBB+XjDCxcN04WQc9estPlT3BBMOWyu9vMhrHw0SjOsb09dPC2d7StLp3kxb4oDaAxLSamL4IR43gFx0VrE886KdXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732034306; c=relaxed/simple;
	bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lihX2iO8lD8aINPniza8IA5cYKx433ucGDQWdachvOXZ6EiXe49tdVk+XWLAI51rtUYlsFQOru3H86qGoG6Wu5g16F//T6JSNEWI8hAowikJfNiSm4LbfzUWa5ZvgFLaCX0AaUnAQrc5xoJdoaACgMdT8ypVzdf5Mwix/65jYJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lLeInjF8; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=d6qhQGTU; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732034304; x=1763570304;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
  b=lLeInjF81dy9UptyfCs1JZno+vdV7y2du/rJyB87ZvLrpCeLmi7cG7Nj
   /lLxLh3UOO6LINlUn120FdORc5ulkHhr+Xe4rTLOQpQDzTEfAkMIZ/MIu
   +LOmUbxZqpvWIHqzoJY+89kAF/Ti3mK4po/jp5oV5wTCcsvPHkEgNAGog
   JAoHrcGpTSN/Yxz3Mn/3LzG/8nyWsMQs7c06uoR9NtpmtOCntfAbYXYi8
   LCWMV1VRavNiHuEFZnfzvmK6IpRy1zXeP6LhytiwOmbT3dQTb9IiEDXX2
   53iiFVdDcMdy7r+VmwInyit8+u54gV74/Nu6X0By1TO/Q6DacPKpQIiQa
   A==;
X-CSE-ConnectionGUID: 5NAEAJzoQgSKwzIp0lC6Sg==
X-CSE-MsgGUID: Y14DGsXBQnGlPaDZGdT+sQ==
X-IronPort-AV: E=Sophos;i="6.12,166,1728921600"; 
   d="scan'208";a="32919128"
Received: from mail-northcentralusazlp17012053.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.93.20.53])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2024 00:38:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+slalCFsufcSFjWw/LPF9u5cbbKwAXLwoYFmf6GnGmC9dpsRIi++Clnp4nt0CJjhvASupTegGCvuhVcvEo8esowXkJ70XcTu6astg8FM0gYtAwRoCJofmQTHEiS8s3nL+U7JeH1PlLZfXMH2j4Y+NUqx0DzcdbFv20m0G50cPcYxsvE1XwaVHrC3cRXQsnJOI3w5DDQ5Cn5zWw+AL17ULAYE9mPF9m/5LHzTV04rRfbXXy4UNb+fCXCa5oblioVQM13A0/D2653DvFEDYkBmqxWP1ClcUl+FRcyIY2mmWhsH8UMs655jGeNNSN23VPnJBy7rKfPI8D4pznrWGG/fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
 b=n6y6xKBX/37hpuw5ccsKcpXGGZkLhHelxgY9ljAuWRKsbZnZDyHbjpi1RnKVoM1dFqWRsiIVvay9eoSv9qcFmgQY0D39gVrte4VAKkYDjWpAqpWjO4jNeuadXVAoR6fN4wW6bytj5OsfMbhtVF+ME3mUZ6iBahkgBY3inc5InD9vmmMG++0mPwFoXkr9VpXM2GUi4ZjOYCr/0OMjpFucbqdjabDgwp39hMiAADfXa+3YhoSx6D56aWTWqGIzHOAiBZVgjSYaGgaJUT6VOk8giLWQw6g7PwPgvmK5qtHXYD6r77umoNWzsEM4t1TYWMyajCeemifFeDojgBf0ha6mmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OULjwvA3neUG1sHmKwW7kKV848AllbzgwDzP8DFs31M=;
 b=d6qhQGTUx38ePS5UU4qcIJ+VjEI+x1h136qGYu3yYkFerjhH6hPGisIj3qHRusyp+JPGFu3UN/zUrEeuErxIWTlW2IwhxO0UMpWIjFPsiRb0ZDq1RTksk6KNqaZlRh+NCfltAdampH9Ov7D+aX52dbVk3wDWEC7of4D9pXmupDI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN6PR04MB9381.namprd04.prod.outlook.com (2603:10b6:208:4f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 16:38:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 16:38:15 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: ref-verify: fix use-after-free after invalid ref
 action
Thread-Topic: [PATCH] btrfs: ref-verify: fix use-after-free after invalid ref
 action
Thread-Index: AQHbN1OY1ua0I/DPNEa4wYac08qE0rK+1DWA
Date: Tue, 19 Nov 2024 16:38:15 +0000
Message-ID: <b7e1985a-49a4-4a71-917f-466d6495fed9@wdc.com>
References:
 <445fecb5586ce0bbe3f1a42417858d1b3df6819b.1731670907.git.fdmanana@suse.com>
In-Reply-To:
 <445fecb5586ce0bbe3f1a42417858d1b3df6819b.1731670907.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN6PR04MB9381:EE_
x-ms-office365-filtering-correlation-id: 9443aa8a-1bf6-4e74-79ae-08dd08b8911b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MDRtVEtJVnJOMkg0Y1RqZ1hEZkZvN2dzM1RJMkVadDhtNXM2VW9RMzNEdDJq?=
 =?utf-8?B?dm5yczRGV3RyL21nWXlEY0t4emY2TTROSkYvVU40RlJ2b2tnL0swZkNEdlU5?=
 =?utf-8?B?eDh2bnYxYUowUXVHZjVsS21paWxBTEg4OUZtZ0hkc1Z6NUhuQzdvLzVZOVlp?=
 =?utf-8?B?cm5lek0xZzRyUzF5YU5PbU40UnczdEl5OEx5a1BleG0zUGhKc3BWaUtOWlBu?=
 =?utf-8?B?ekFHQVRBS043S2NVeEpVcnd5QUIrN3Evc2hyd2tJaTRjL3FpeEkrZmR0UndW?=
 =?utf-8?B?cEFqa1NvK3hJeWJLcVNIbFBQWWdVWmRHRXNwV0JoUmYyOE04dmdwY3QxWFdj?=
 =?utf-8?B?dEpHa0V2TE91bEtoMGcvZDJlSlVGS241OU1aZDBKcjVoZXFUTGNVT2JtQlFz?=
 =?utf-8?B?L1J4RFgzMkhLd052SURoeXRTNWlHaUdSazQ0ZEVGU3p5NUpzdzQ4YlpBVkJI?=
 =?utf-8?B?T1hHcUJXOHViVng2a2d6b1dmVk9SbTZYU3REaGRvVzFWYmpTWFFMMVYyMUpt?=
 =?utf-8?B?ZVVYTWxHQ05VeGJtdVQwb3lHZzhqTURtdmMzRXJ0U0JHdWpReTEyd0Z1UlNK?=
 =?utf-8?B?ci9BbTE0TGJyU2lZd0VKb0EwbVE4cVZDM0lWRTh2aExVWFBsR3BCSG00V2hB?=
 =?utf-8?B?cmdMdjJscyt3WStQREY5Zm1BeXJ4a1BHNFl0VkFPRGJBSVd3Z1d5Z1JBREJ4?=
 =?utf-8?B?Q213UzQ5T29ITCsyNG80dVlkZjdvMVc5Z0wwek81MFNyNHlWNzZubzVrcTlv?=
 =?utf-8?B?dVVQNnI0dlJhbjYrMjlpTGV6WGhadVdaTndZVSttYXdadGJ4akJuNzE2WDNo?=
 =?utf-8?B?eDhrQmR1N1lpMW5qbTd1VUVEN0ZObEJFZkl1U2c2UkJiLzg4bnlYLzNZOFVh?=
 =?utf-8?B?THVIYzZHeW4rdVZjbnVDVXR1ZENZcHRxNFlEMFNvM0poK3VsZ0JEaXBvUlBk?=
 =?utf-8?B?Z2pCalJPZW8vVzczMXpPbitwcGtGQ3BIYTNCdS9Mckc5RXU5bmtNSU1tM2Ur?=
 =?utf-8?B?Zlo2dXRmWkZlOUNabkxMN3p6ZHoza0lnSjY3WXBNQUF4Z0RKZitBVjlCZ2RH?=
 =?utf-8?B?c1JwaGQ0cEgrWTJRWmQraHp0cUVtTGZWd3BPN0FmMTA1M0lWWmYvZis3ZXJZ?=
 =?utf-8?B?KzVlTXpROEFydWVPU1BwTDRCNzNocHc4TElnUitMNk5TMnVYTWtqMGhuSVZO?=
 =?utf-8?B?VWtEMktCWkNtMkpDTmtaZm9pZ2RGOGUzQWhFRnhQTkdrNThOWVphWTFhWlpS?=
 =?utf-8?B?Y0xjVmhwdnBnWWdqeDE3ak9yUFBNRGRXNzY2L1dkL1p1dTd4Ty9VNlU3d2RS?=
 =?utf-8?B?Q2w3N1ozOGhsV1ZiRXREazdYb2RySi9LU25pbGhKdmpXZVVYd1BMOTJGYUFH?=
 =?utf-8?B?WXE5L3NFTWFnSjhtYWZ5WmJ5dEgzeHoza3ZLSDdKd3N5SEZPMUFHR2x5ZE1G?=
 =?utf-8?B?d09MWkY4RWFSVnEzZHVDazV0WHdLalpOWStCbUs0MVVyNDRMaVhON3ZzTUxF?=
 =?utf-8?B?ZUtEcDZJZUZ0dGhTdXhFdkhMQTB1eWxVMDBQek1OYklxRk9ocU5UNytiZEN5?=
 =?utf-8?B?SzJ1KzVYWFkxMnRZQ1hmVm1GcWRpQ0gwZTlzNUpwMHJIOUZyenoraDRRQ3F6?=
 =?utf-8?B?TEsvMWdzWkJEYWF4dWlsMmVXMU9qYVRvd1I5YmpOV1AvS2wzYmRGakhBOUpk?=
 =?utf-8?B?V1RGTlk4WWtOT3dIVGtTL0RjM0J0QjZMZEJPNHM4bEtnMkdXTXhXUi9iREFJ?=
 =?utf-8?B?emRGelV4U3liYnJYeVl1ZVUxcWdMaWtHYkk1dVRnbC8vR3o2dXpMcjdLS21y?=
 =?utf-8?Q?myYe+fyjb3Z8mwGMlpd5wHA5u4986q/xtBGJA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3dBbU5zWmpVUE5IeU5QOVJqMkkrK1htVUFLNEE2SFlTSEtDKzZxQ0J0RVFI?=
 =?utf-8?B?NnRYYUphQXQwRVhpM1UzMzZyY3RsLzA3b3VjTmlhVVN6QmpYWVpwZ1c1OU1M?=
 =?utf-8?B?R0xlWDZiUy8rZmpBWEtacytmL2pUZEx2eHdOQWhTVFBqS3RPQ1RHL0ZjMUZa?=
 =?utf-8?B?WGZ3d3A0UWFVcEpZcy9iZmxKR1k0dTdXQnJjMytybE5CMTBYSzE2YkdKcUo5?=
 =?utf-8?B?OW1VcE14VWFaaXdvR1JHTGhlSGt0RmUvbFdFYnlGTmpoV2Q2WUVScEVrTVNh?=
 =?utf-8?B?MnhnQld5ZEJNVmlsTThMQm5NNUY5OFM0NGE0Z3k5VlQxMFJHc1doUUtxdmlN?=
 =?utf-8?B?czd3VTFuVlg5cTFCSTZabTlKQW1LNUU1TVEvUTN4bWlQN2x4MzdwTm53SmZq?=
 =?utf-8?B?S0puMURRSEYzR0xpRzlyMG41aHluaTNuMTdxUE1rei8vMUw1UEZHNzFOZUti?=
 =?utf-8?B?NzFma1paMXpXQlJlSGp2L2ZJUnltNVk3RFk5Y0ppeTJ4dXpVWllqRkdrVVc1?=
 =?utf-8?B?OEVtbVFWVWE2MkZXTFcyZjErQTJFemlWcWp1UmVnM2l0ZjFIMUJMN0Y4NGFO?=
 =?utf-8?B?b0dFN2hGcXlVNHNMVDM4OVFBY2VOK09ISXNkby9zeGV6MEt0OHBzd0Y4bnRC?=
 =?utf-8?B?Qm9ZVHZMQWtTT1R1YUZwYjNHQlREelZ0YzBvZ2t2U0k5Wm5jZEFiamlTV05X?=
 =?utf-8?B?ZmdOZTVBMjZhUTJXcjBrVTY1NWdZNlFVU2docjN6bFRnY20rd1N6SXNiV29x?=
 =?utf-8?B?em9mT0hmNE5JOTVhM1FRUEpVSzI5UWUxS0g5aSsyT25WWXNtSzVWYmx2V2lY?=
 =?utf-8?B?ejZGUGxhM2wrRGtYTVpkS2JiZlNXRWVBZmk1YWhHd0FzdjJNRkpaWGJQSnds?=
 =?utf-8?B?T3QzL2Y3UWJLUU9FZ1BMY0JCRExSdFhGdGFSRTNUenNFWmN3U25VbG9DUXhu?=
 =?utf-8?B?Q3lBeWtVd3IzM3IwQzA2S0h2ZXdFN29jR1FjeDB3THNuN3R4YzAwUjBJVkM1?=
 =?utf-8?B?UkdDd3JiWDR3aFYzbHVBUVRIUXlHL09OZ1U4TThSSHJKYnlpNzlWSC90Vm5E?=
 =?utf-8?B?N0hsYmNwSU5tTzNzQWVzcmFrOCtyQTJIL2lTdHJ6ZEQvK0hGZW5wMi9rakhJ?=
 =?utf-8?B?RkVxeXZ4RDJFdEQ3QTFQSWRkVFdxYjU4aDQ2dzdUUTRtaXNRalZCNGxCY05m?=
 =?utf-8?B?R3phNmlHbmhQNnd0V3BhM1NTL0hnVjlrSVpJaEQ4MWVSWXBkQzNlN1ZCSDZZ?=
 =?utf-8?B?VG9PZU1nZFJCdUxtSkFxOW5sNGQzc3BzRmt4UE90ckovRlhPYkFlaEgwK3l5?=
 =?utf-8?B?RFAxbmVSOEpsdUh2WTgrL1kyYVA5RTMwYUxUZ0FhK1NyM0tXM0xPbW5tbjdO?=
 =?utf-8?B?eFRTS09kZzlmVG1JSElqeGlMZ2hZOHJ4ZXFxa3NqUFFtUE1KZkdyaXFpWXU5?=
 =?utf-8?B?bU03UWJCYUNGL3pPOEJVSVV4Um1JZzJ5Yktka1ZUWXZTcVpGY0I4VUpuZURl?=
 =?utf-8?B?QktndERBa05OakdVUlNZWUhrNmdqSk9FblJ2azh2UUViT0wxb3BwcHZvSzEr?=
 =?utf-8?B?SlhwQ1FGZDdWWGhuQU1zdmpCVzZxaWJUQVRoK0V1Ny9xRmtCOTZOb1lwUSt6?=
 =?utf-8?B?VlozRWlhb1Z6Z3ZWV1VWMXhlUGo1a3U1ZkRseUswdFBQUW1lM0prOEJaYUJ1?=
 =?utf-8?B?NlV2UGZjUjRlMmRMYWc1K1J6STZwSTBVVVFGQlpZVXhEWnZROWVXWUdwVUpo?=
 =?utf-8?B?a3ZCMEJhaExWNUl3eUpxUjJKdmxhQ3AwV0IvTTROdjZwSWVRNjRKV2Y3OS9B?=
 =?utf-8?B?NGNqY0MwK2RLK3FxZHhpMGhzV3cxSnhRbHF6Y0RZdDBxVFFoTlBod1daOEhS?=
 =?utf-8?B?V3NKUkdEbWhTdkhIZmNUSjRYSVBhTTk4UFlYU3hEWWxKR0hmajhXZ2VEQ0dp?=
 =?utf-8?B?b1VSTzRLSXNNTjNEdDFzL0t4NEg2TWtkZXI5RTkreFFTemlrSjdXMUpSbEFr?=
 =?utf-8?B?R1d1S1pRRWFEUTBLNUxMRVFjVUd5OTMrb0VxenJISDQxbDV5Mi9MbmxUUGtR?=
 =?utf-8?B?ZE9xOGlkT3NmMG1NdmtqVWtUaVczTktDeU5aV0tFSzQxd21yOWxTNTdFMXhN?=
 =?utf-8?B?eGhRM3ZhUThBaEhVLzYzNHZrcVA4cFJZYUNteitldVJIbUY5K3pjR3UrQW8v?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1CA2034EBAF5F4C8CD123973CA89F03@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ItHMLlOsQQVP0yNb4JD9BouJeESLbdKMfuUhFNS9EPdQmJnZ/Ml6idnP/edJT80suqZ2z9OzsnOpBp1RWn6MRfYoUAa2Nu2nBdjh4OKlNi6OaodUp19Ds8GIrBy+GYQxOitt6jhpr8s5Ir+notpQzVw1WnHn0HbW6F7uifQ8hzNl4KZfycmPsoqxyxO9duRdPVycTIr4wq11qivWzdIF7TBG3E3FwqE0vlMlSjvG1npukiJanJuPd3iw7Z39BJ3czhAIXWJvwhl7Co4LM9vI+JFgTLu8cimQmlaygoO1zrHi2mHKorifrn0XucpcZ356Iy0DpjdLR7g5fKnNquHNMKRomFRtHYEYhjcBAhJa2bKfS/zHfLXpYEg7bpEfz3+eORe3FLVw7qWlbEKQDBGXtwsEJgpbwXvCcP5BM5QwjBYtOvzTgsXMh4ua30OZCzHXFY0iQ0pgphwe91mRkHZjhrpQVS68v18pI3F+3loyTvr4DXXQg6++hME9KNIwffxndht/P5AoapbcV0uNpYCa4eZ76lheO1uwNJg8xLcu5+72UOS2Ppkt3BWeoKV3krSIodgVgqFY0/wbQ48wwtcmC1cRYZb0PweHa3mMuG30TKUuoLXVIK0EveKQWOvmpaQI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9443aa8a-1bf6-4e74-79ae-08dd08b8911b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 16:38:15.7899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PaxsaUtq1IR1syEqdQLwInH3mFzjgVSiY6oXEUX8VkH4Daf4QkTu4Fxc66qOyWDICk877UU3cmKNk6vJVV0D2nZuLq9CRfpOcNoCRuPjYIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9381

TG9va3MgZ29vZCB0byBtZSwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFu
bmVzLnRodW1zaGlybkB3ZGMuY29tPg0K

