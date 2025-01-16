Return-Path: <linux-btrfs+bounces-10979-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BA7A13523
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2025 09:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF21166F53
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2025 08:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E43199931;
	Thu, 16 Jan 2025 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Tq2L/BbE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MTsilUux"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698A2148314;
	Thu, 16 Jan 2025 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737015498; cv=fail; b=TIYNTxJFMkhgk0W/zkPlXk0MsJeWDRvK0hkfaRoxUYZu3D1EzdOfJ0GEwWnu4TH2VjzXQztslnY9ioXqJ7dulrDVSWChcIctap9ZYVlEf2CDgtRh7mOg6hZHdSyoHPgZAh5/r8XCVKlBq+rN7UjGg4Tr20sd+m8zyN6kbq7YNaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737015498; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PASqWjWMPALugMzcSn2Nkq+bpcTh43Z6QlOf0houyKhprfS0jtzAp15plxvRJdxNGaCyXFujDJ9ScVT+Vj0VN2dWNSGhegogk1kw4xuoCdLlOrF3Ye9+oNcmvXw5KtN+/rfa8BCAe1oWbMOrmdTSSY0yjurq9DRJN/EwWRexzoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Tq2L/BbE; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=MTsilUux; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737015496; x=1768551496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Tq2L/BbE/ZgBESwLxgiM0uvBiTqSvv2dXShYeqkWbYn2xM1MF7WgL/bH
   vQ1u1BxHFfjIHuFHR/T/OusPjcyhc8XsW+S7YD9BVH+2e5v/htToMfXwE
   UDwu4QE5cSgENSqvs9jztX9/YDCgCneyq8tuDw1hDeJOhtVeK6RsbCdkU
   nDtODbVmnp7V19k15lhU7sBs5Z6F6NlxaMfIGsdBnl/6AR8tLLmFmE21o
   10zk/fH2KAS4l0LurIomTMdPRuMsvmXS6a3p3yZ3Iv1HgdM87Z8aeL76j
   IpibcjdmEW5yTDzzU7Y4uryz2uZsreiWE61OGGwO6gbr7t4uSJ40dmNHi
   A==;
X-CSE-ConnectionGUID: WzFkXfa0SfO6dJoYyiagXg==
X-CSE-MsgGUID: wrEquk42SNSxjB19JdLB3w==
X-IronPort-AV: E=Sophos;i="6.13,208,1732550400"; 
   d="scan'208";a="36065026"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.9])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2025 16:18:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIP4J0xdSUqeJGtiCacPpIdDSX/9r1To6glQX3ZicHr29/nTU4kqyt5XIb5F0rpiyUdkIY7/4B9CI7yJvtXt8bdccxPplI+x6Ftnxvx1Qoai3hZkZyZ9mU+wY1gMQ4uWp/jC7sxq2HRnJm8krlGyO5qIuEDP+jVdYl5pkK5vulMMnFUca9+ZTK/16so8lfysi/mWGYdNIS68ipPt2crE1ly0Za2b+03gkIrbJTcqh1SPwFVqP0v1w7GzMMBO1HJcP/nFAZMdvJJzF6kRWzLJGHmPnRaJWrB1ZvP16ks8Udmzn9M9PPFm2ed+WoI4CWwoSGH7AUWxdYw5H3Aq8tlzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=DHUglRMWQ+x9wdVTcFHZ2QOlUvQgxxIr3QDAv1d8iUf54+yamj8f/s4ogl2uWVDOFz8I1/KVGSna2/fm+uHM9EdcY5p4/2gUVBt+3DsJZu1CEAr1TD26SBMmIbWJZsJrC9tcVo1j9PqyIi+uk24pdEa7PEEn+F2+j16PivWrwsp7ZYACsuOZCmaXvHbvkDTeiz6ycV7FgU9OMO/Q1iCgQ7l7bZwKQruJaFg/UaqA9PFYP0RdO6VKcl+YgP6gGBF1hDYUvZK3Y7LFPZeGjMm/T1TzWkjSxo8vmBFQLxtAr14RIniMMVRd/kp7SqgUjPghje0wjz0n46Nf1XpHmUS+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=MTsilUuxL7lWmADp4at+bSN5SnxOh2S+jQVMEWnd1FclGy/pz5hc/7j7cwV7zkLYNd7ehSE2aNhJu3HqEv09KFAJc+FwRDv0oudIXQrGqXunkmcjGtcGo216rgAI9GP0OEMxN4vzEOIKxQtXG3C3ErEo90hxk4F39v4UF0ShyNQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8098.namprd04.prod.outlook.com (2603:10b6:610:f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 08:18:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8293.020; Thu, 16 Jan 2025
 08:18:10 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: keep `priv` struct on stack for sync reads in
 `btrfs_encoded_read_regular_fill_pages()`
Thread-Topic: [PATCH v2] btrfs: keep `priv` struct on stack for sync reads in
 `btrfs_encoded_read_regular_fill_pages()`
Thread-Index: AQHbZ2HAIhc9v8kbl0ORkym/l0S+ArMZD5aA
Date: Thu, 16 Jan 2025 08:18:10 +0000
Message-ID: <7846020a-8864-4f98-95c0-892142166799@wdc.com>
References: <20250115152458.3000892-1-neelx@suse.com>
In-Reply-To: <20250115152458.3000892-1-neelx@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8098:EE_
x-ms-office365-filtering-correlation-id: a079f048-67e1-40e6-bd52-08dd36065062
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RkYvaTlVU2VtOWRSUy8zR3JzNWNXT0JsNmlqUHgyWmVOdDFLc2FDYXNhaWw4?=
 =?utf-8?B?N3dGUFI3YzgxZHlrYTNSOEZqSTNZaHlObXlMdUp2RXlnZU1GVHNDRlBUYjZB?=
 =?utf-8?B?bnpKVUg4T0N6SzdTRnRIbVRBRlN4cGZSajIyRzBBcFR5dGNmNkhGNGRJaWds?=
 =?utf-8?B?VjFXU3JKMVBHU0hQbmkrUXVHYmgzK2Y3ek8wTGQ2L0F5RW13azRMNmVGdFRn?=
 =?utf-8?B?WHBrN1lEeWE0U1dzczUxeDFPaGQ1aStHTmU4THNmdC9KV1g5WkxoZmJabExr?=
 =?utf-8?B?UFZqT0tKN0FnQmFFY3BFQnBlWUxaNGd5dVlWOWlpaHl6NEtuaW5FbndGQzJr?=
 =?utf-8?B?QUJiQ0puRjdHTGNDeEphZzdzRWVkcEU4Q1lpMk1jMXhWT0NINVdWWlNiYUV0?=
 =?utf-8?B?dGNCaDZ6RjRTQ1JKY0xpMGxubjlNdk9hdEI0SmhoRHlqZ1I1WG9rT3o0aXow?=
 =?utf-8?B?Y0RFSk4yUjc0NUVVK3U5Q3BudlFyZG5ZT2pGeG5YdVVhZTE2UzdKd05GY1Jo?=
 =?utf-8?B?LzBpM1FUenVCK3dLRU1RMHBJMUhtWGU5cVZCYldobUtTaGlldW1iV1BWTVFY?=
 =?utf-8?B?bDlOaG5YZEJleGhVYXJxS1Iya0NtU29YT1FSTHErSDVaNC83bjhyK0lGZ1BY?=
 =?utf-8?B?TFRyYWRnWkhPVlJ1NGFkRTE0UzluTVAreDg3b2k1TmxmdnRKSzFEWURyWG9a?=
 =?utf-8?B?U2tTc0tXdFpzenllZjJ5VkRnZDhhSDdHS016Wi9BQkdCQTlVUlBQa1ArVlR1?=
 =?utf-8?B?SWRFS0dqT29qZHpaMjVxYktlV2pNL01Ma1lkU3FKMVIrRjlKYVNwUHloazdZ?=
 =?utf-8?B?KzlXbFJmUWNzSEJKZmpNa2FDWUF4ZVB3MU9MZjIzdkxLR2xjUFZYK01lUTIr?=
 =?utf-8?B?bitwNWpjWDcyQXZ2YXMyV3JUSk0waUZ5eVFiSnRrblJDellHcjc1UEdZN284?=
 =?utf-8?B?SzAwRENHcDVkVnF2OFdWUHZXMEtycnB3YVpvRXdaM2thTU1sY1BjWDF4b0cr?=
 =?utf-8?B?cEpOZVJ2MDB3emZ0WERJVEJ2SkpIOG9DcDk3YWlCQVAzREdTTG1KYTIyd29T?=
 =?utf-8?B?dFIvZjRvRVVsWTdkSk9Mb2t3UkJzWEVKYjIvWnd1cGx0d3pnVGhJUThScktR?=
 =?utf-8?B?UXJKYTlydXk1bzF1dWJtamxSamhURXl1TEk0TFNnaDk1Yy9wdWJhRkVCYjcr?=
 =?utf-8?B?YWxta1Q4cmRYejV0VWRFdVBXS3MzdDRtYmkyL2JySnplRGlGdW0ydXBsRUNw?=
 =?utf-8?B?aHNMa2xxSzhjd1JsNnFRWnI4T21rY1RtbWJJQnB6REhFTER0ZENVWjVWZmNs?=
 =?utf-8?B?MzRPNmQ3YmEwK2ZTZG4vUk1rQU95YUUvMXhYcHVNREhPd2xzck5rbThmZ2hE?=
 =?utf-8?B?Q3ZlZHJTSDBKYk51MENneGhtYjN4UkdZOFR2bmlEVGtBRDdHbFJFQ0k3UzZQ?=
 =?utf-8?B?eElHdExmazN0eGEzZk04OGc4Y3EzejlnV0NwSnBxRUpaay9xaVpsYnJ6ajBV?=
 =?utf-8?B?dkRWNVB0dkpmN1AyTHRqQ1ZDTS9sbkE3STNLeXR2NTRxSXE2MGhBRUZ5QWFT?=
 =?utf-8?B?Qms2d1EvTlQ0c2hTTkRabEx6V1V4UnFvNmtCK2hnNWczeERONkFwVmRyR25I?=
 =?utf-8?B?QWlzTlU2WWxNeEdOQkJteDNTT054d3NZcnNjOWJvWkE5Y0tPZGRqcGZYbjhi?=
 =?utf-8?B?NXBseDl3SWFWcGR0U3l2STFzUzI5YjZJMjBPSTAxUmlGTDhIQkk4NnRHejdE?=
 =?utf-8?B?N3R6SEp3UUQzNzVQMDRBdXBZVkxodzRXZTVaSUc2SERKcnlYamUzcXhNNDFX?=
 =?utf-8?B?MmE4MndtSUZ3cEtXcUNtTGlMV1ZaNEFiZmVScEdZOGZhMFpab1drbnkxTlVR?=
 =?utf-8?B?aS9uU0l0bU1nV1puZ2NESFdnU2hCMWVVQ3FuV1ZYM3dGeUpzbWwvekxiK054?=
 =?utf-8?Q?LxSNh3vRQRVxUhc7S8bDGH5u1qgpv45C?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cCtmRHNGOUtqQlpUaVZUd3NwYkROekczQTN0N0l2ZklzSkVrbDJvbG42V0M2?=
 =?utf-8?B?OXp0UVFLZW5DN0VZSVNSdm02Z2J1dXR3c3Y1aUxoWXdXb2hzU3IyVzkzSHI5?=
 =?utf-8?B?WmlhSjNTV0gyb0lWNzYzTVBKMmRBMmNGcW5VcTVCWVFwMm9JK2tXVzVEb3B0?=
 =?utf-8?B?MGZndTJPZGpiRmkwV24vTHNzOHBFRUlUSElIRHlZMEhGSjh0N2pvQU9jWWEx?=
 =?utf-8?B?ajJqdXpoSXVCd3JDZFdGZDhQMnZHd2FoUjVHVVdwb2tvRzhjL0lhbDk1dXFz?=
 =?utf-8?B?dXJUMUtrSFFEM1ZvcFEydi9ZYmZleTYwTjQ0Y0IyNW5tR1BEVWFwT2hucUtn?=
 =?utf-8?B?eGNrd1V3dmNiVG95YmkwT1JBdGs1WWFjcVdZRG1NQ2dsTEZOdXd6Y0VUbHE0?=
 =?utf-8?B?clpva1NYRjVYNktyR0NvbngyMTZlVWdFdytJYUhCb0xINSttYzliakxkTmty?=
 =?utf-8?B?Rnd3dDlTQmo4S3pZQnR0QW5IUUp5UU1WS0JoODQ4Q1NtVkRlNG5lbkJNcnQz?=
 =?utf-8?B?U0FDc2hOcVNWb2FwcGNTcjhuMUxSL0hpWTNGYUZ4Q0Z3YUp0Q2NxdEp5ckpB?=
 =?utf-8?B?TFZuczdpM0Jac0Zvbk1kRlljS3hFQy9QZTBjOUFsQ0QxZmRQSVV6QWpmOWp6?=
 =?utf-8?B?R0pNRHZCUEROclhVMHlBQU5nMTArOElsZ1ZyWlE3T2ZlT2FxT1ZUdlptTklx?=
 =?utf-8?B?eHhmU1ZPZlVIMU1yT0xlcjA1WGNuTm92STFVZXByWW56SVcwditJamlkYVlF?=
 =?utf-8?B?UU42VUJSeWM3bDc5V0w0Y0NYdXFYZWNQT3RsbHFnQVVLSEVsMU1uMGc4WUYv?=
 =?utf-8?B?NDQ0WWVRWXBXYTI0Y0wwbDZrMExlUVlZSDZ3Y0lGSlNoM3NqTDV2R29YYy81?=
 =?utf-8?B?OTkxQUNqT2V2b2gzQVBVY25vcXZnOHljUldnWGs4Z3FKUzlSMm5WODY2VTh5?=
 =?utf-8?B?UjU3SStzTjYrWjFVSUtmcVlYOGhxMWhzMXBPSzVXck1yVG1aSW9VZkNvTGdQ?=
 =?utf-8?B?R3BvZ2VFM25LVUJZYkFRZ0JXcSt2Nm8rN2EwcTcxd1hFb3hndzN2MTFwYUJO?=
 =?utf-8?B?cXRhKzRkTElyMXVjQVVES2g5Y2xEaC8wcHZQempGUGg4MmFVSlFmeTdHem1E?=
 =?utf-8?B?cFNuc3dCMWd1N3gwd055eHZnU0V0dkN5UHpOLy9HUGlEYjhqOXZ2SkRlT2lz?=
 =?utf-8?B?U09QSGVHNGZ6TmxQV1VSdjZscVNhNmVSNkFpbHUzcCtXclBEOXp4KzEzSTFi?=
 =?utf-8?B?R3pIMVR5eXVMNjhoTW1rNTZYejhOdjN0aUV2Nm1MWUhLUU44NEoxaXhySllz?=
 =?utf-8?B?SGdHcUl0VEUxTUlKdGVTdm5wYWFSL2xoaTdFUmVuWGQ3WWxpRnhwZzhjZ3Y1?=
 =?utf-8?B?RFpRZWJtTk1tVUJOdktYUDFlNWNMRFVwbi9pdFNyQ2U5MHBINE5mMGxYUE5G?=
 =?utf-8?B?aTNmMjczTEVCRWtONWhYdXV1MVlheXlNZ0pXZlNZZDJLY1dUOE50MjVqcit4?=
 =?utf-8?B?VWU0ci92YXNVREdIRlFCQjBpTmdRczJXa2RjdmxxbEEvSkRLd0R3QjNaZTlD?=
 =?utf-8?B?eXlsQVJiWEFiS2FtSExYSm5ZUUZ0czhqU0NaZ2VPLzJ4SlJCSEpDOWp3STVT?=
 =?utf-8?B?UGFYRHQxTWNUcVhhWTZBb0tMckpWNkZJbXpvNVArSVFIeUc4cURKbkJTbmVL?=
 =?utf-8?B?L0o3Z2I4RFlYNjVlZ3hTaldvRDlXdzBXZFYrQ2lsUVhXQlp3dEtMWWM5cmRN?=
 =?utf-8?B?bGQ5a3BJb3pQSjByQ0h1UDAwa0QvQzNVSnlWWkJySXVNVnNBVjdyOUtYc3Q3?=
 =?utf-8?B?L01Ma3d2enZNRHMwaEJZRWF0SWVSNDVQTXJnN1MrM0RJVFcrSkFPMk5zRnJp?=
 =?utf-8?B?OEMyUWptMGxYK2VVK3JBTGhzU2QySVR2aW5kZ29LVVJxUWV5OW54SkY1UWNi?=
 =?utf-8?B?cHlhbTIrSlJYMHZLNFB6eGxRTjZCamJ6U05KQ2FsMXF4RStBbWxBY0N4czNW?=
 =?utf-8?B?SUtpKzlPZFhPUm02Y2hRYkdIS1dUY1BUdkZuOEtEcWk4emFDVHdMYnJFbU5k?=
 =?utf-8?B?SFBQaVVQRWdVZTdmNG1IS0orQVVWYzNzNmYyMzdHbnZKNlVUVmdPZVBZaWpI?=
 =?utf-8?B?YW8ySXk1eGprNXJnS0hZcks3VXlwRjNGbUhGTUpYWVE3S0FPNy94UlhjNUxs?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4AD37F065FBFA449070E85945D415F0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	83gpeaDhvBV7po/0epxxq4TPBe9dUu96xhov4ezcolnKnpS9kP7U3v/MxeVJ/YutslJ82kmJ/6hpdvb+5/SWRqmVsGon1q9nRQu5H0j8bLVliOlYbgiQJuzIdZnNs4HIAtzKo4Y4ILo/IwkINE1HZVH+kbYBxEZzcti6T64Oonu1AGnnXb7Fdq0e7C5PeHCrowywOcDGLl01Bm9i9uK8ozEF/QuLNLxnRlUhaxpzehM2MW3vqSk0xnquD+BLp3PlKl20TuPGiCPubxqy3T7YL3fA7W6MZd16iYa1bTue8vU9rx2jZra+2H76ZTyBm48AFcC34dIp7pZbtH8kJL4NMSX6lGarr6UcWvd47L/YDt6PAWyimnxJmEWx5hxONky9o3w/GvI7RbTZox2NAT9W6PF2hvK121b0VnuBOz4ASXZuZsHc2qLyxZ7MEBfvmhFX4lG/KuHXX2DzXHXKSJt8pbiwNd7oClNDCeikOCJLCrV99pM0KPPGcYanrcwzJT5IoY/Lm3ipjSw4+kC8vqFZS8+YC1eADKUTzEeLjgPAA414wOd+p/RIyhXtjxKpXGpDPa3kMh2VhJTwJ5Vtx7zSu+d4xf4EOI/mokxsi1oP5a+ko4RepQVVe+flkbnr/WJG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a079f048-67e1-40e6-bd52-08dd36065062
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 08:18:10.2659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2yDF3e0hoFe5jzZqBt+hbSRnm6sUfm3qusCL3gsNbyaEvYCFC1t7UDwBrnjo7f8VrA0258c6kgINYKdApN8NbrfXymWYFPTwvxajtOLA7rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8098

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

