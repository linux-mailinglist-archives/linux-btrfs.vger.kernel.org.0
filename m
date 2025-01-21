Return-Path: <linux-btrfs+bounces-11026-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BED74A1797A
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 09:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA8F188C3D4
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 08:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A711B85CA;
	Tue, 21 Jan 2025 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FM/x19LR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mZ+IZGpO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3D1188938
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2025 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737449271; cv=fail; b=SeQCyN4FWr8/6m952HFjfd5uHtabiZvBmDPh/zgRh5NKWyTAFg5MKL42E1mBbxo21YA07YxxYr+/UTuB6rSMpW1oeUGPjPl/HU879wt3aOYc7/PFxFaHgRDr/9l/k/7ychWmiHaWuoLxztfiA3CvmTnpY/XCXrzzDmjdof5z2zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737449271; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RjoYHNiI657Da937LMw4TW7WpCBj5amG9mhZezu6WVmcmw/Q2bMNGgeZkssbLF+bp2fS0T5RD/5mywvRFOOmcX0JjYGcSmhBs6EtQCO88w+XvaZ3Qp3M0UfwoX5JHY0vrNRTi3H6XYVSicVpSbkgYIYG6ovtzPSx22igG8JNeiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FM/x19LR; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mZ+IZGpO; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737449270; x=1768985270;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=FM/x19LR2/sucVWLzIaQwqLc4C/orQuERsecZ+4q7kkPewbITpX2S6l5
   hqbG0OAHFYBrstaX4HszmZzUBMDxv8DnLKcLDR+2wxR5t6DW3mFPCMmtx
   cnVcL9nB+Dqx4zRLU2EVXsWyILxHG5txHiT+HvfHynDqJcHmM8m/WVrex
   HQkXs3pwvB8W27mmTPoLDM2JCEIstipGhdLeORBllKz/E2KoohgxcTuPn
   71Kee1Hc3RtUXK5TXjPD5nRd0RenRhtbFB7WBrKt0mnm3DF5Y0ASE8QyT
   RSUxeq2acE9m4MGMR7Di2T1nwfI/w8hjAYud8B7L4DIhv/VRybH4ie0mB
   Q==;
X-CSE-ConnectionGUID: V7xlnfbRRYqkPVDVe3Fe8Q==
X-CSE-MsgGUID: ZCvzyICnSCufQ9wkZgvpkg==
X-IronPort-AV: E=Sophos;i="6.13,221,1732550400"; 
   d="scan'208";a="36409293"
Received: from mail-eastus2azlp17011029.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([40.93.12.29])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2025 16:47:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQjeS/x02q364tUAx+4vvDnQmgcdYPD0VW+yIKJ764hVI0QczvpjTJA0UwuWfmZdwAQeK6nRLIOZtM1/LXuNKPemYCjTwrixbtTssfEZrDDbnSErvCGb0/PkPD3UYglEPVOMOdx//3CuYlp7pPdWoCdSTj7D+HcOKEAtvAJMMizv+u7wnHj+9i/MZXe0N/KktLUQZGfDQB68gtEsVaUpMAelYZY82Gx49Yk8pyUKkgABJTPINGQ2Qs1lRry7JMqrmun4VayDvvp8uvqtnd8iaYuGaoCI5AQo0fcb2DeWb2Hmd9cfAR1WjLZkdBDOqPfcna8SEIOq9CJX9L3FgTZOHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Q9j4RuDYEeVH8oQPBxmgY4iwue2v5wzTgfco91KqWTgMJvaX0HBAr+0oZaqjJrvFEmYMmnOdNq9dvQH47qHdYfIwlb2KFRjYdfBvwZbCmWyTVIkT+CyvzBqXLAL4/pbi/O/FGM++G+92PiWBTohGhXmVrPofQD+MLY29xqgYQnAQu/m7GUVpvxEmoHH/Un7rOH/KhgNIcT/fvRNz9n1xb0zmD4/ztx7U6QrRdCBPIf317s0YrzPhypfJMVaSkVfzg5DXJRYSmuPvCmTQbAqadIOmqxlYYJRlGLjepV5HQiPpkf1gRlAcRk1JdDugvzgyS4AdAVnXb3rl2Lz7ueR+oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=mZ+IZGpOZqsc06pZLaZ16lWJ7312keBme9xWL6ZybejblzVZC2ZqAuA+D1HjxoGZn+h4VDH8onR29Ju/kFnyWyli/v3bUz8QAGDX/FyrQiX7VMGKgjNNRbNpvGqgVJsr/NJPflX6DXDb+C0bOj4SENXZY0EaljScqbGE6iiFGn8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7581.namprd04.prod.outlook.com (2603:10b6:a03:32b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 08:47:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8293.020; Tue, 21 Jan 2025
 08:47:47 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: "dvyukov@google.com" <dvyukov@google.com>
Subject: Re: [PATCH] btrfs: fix use-after-free when attempting to join an
 aborted transaction
Thread-Topic: [PATCH] btrfs: fix use-after-free when attempting to join an
 aborted transaction
Thread-Index: AQHba2OHmH6AvFGK3kCKDXzk2jwVtbMg64EA
Date: Tue, 21 Jan 2025 08:47:47 +0000
Message-ID: <36ec7186-2754-49a2-8ce5-3ee97c4b53b3@wdc.com>
References:
 <f81151ae971c956f9b7e496a92bb67222452aee0.1737395071.git.fdmanana@suse.com>
In-Reply-To:
 <f81151ae971c956f9b7e496a92bb67222452aee0.1737395071.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7581:EE_
x-ms-office365-filtering-correlation-id: 8e6e54ad-5755-4889-eca2-08dd39f84784
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Slg2TkIyYWRLa0NuVDh0c2pwelIzc2YxMHVsMHV6N0M4SW1xdTR1bFVSTERS?=
 =?utf-8?B?N0Rzd1U4eHVBdnhzb2QvYVVNWVljVE5YVzY3WEZhTDRvWE5QN0RETThWcWN5?=
 =?utf-8?B?KzBiWFhXUll5em05VnMrMUtPZjdvekttVUlUMHpXbC9GN281b1lETXJhTzc0?=
 =?utf-8?B?UEhRNm5ncFB1UTZTZXFVZU5nMlgvVzErNXdnWlhkRGN3YkMvSXJKN3oyMXU3?=
 =?utf-8?B?ZGkrOFQxcWYybXl2cG9CSkpQWTNhbTlWQUpQTHYzc3pxZ1MvS3pRN2ZTVTVW?=
 =?utf-8?B?MFpmQlhHVzRtSjYzTTFVK0E1QkI4TktRNkxVNHFsYXJjSHZ4Rk5iLzI2dzdU?=
 =?utf-8?B?aWJrMEp5SWpVZmx2Y3JxTHRVRVkxSHJoUlVFZjd4ekpEMFVxNVNnOHFRM0JH?=
 =?utf-8?B?eVVKWTdmSTVZYUxkem4zeStTUEYvcTZ5RDFvTHlYbXRCY25sd2t3amYxU3JH?=
 =?utf-8?B?cm1rdGpiQWh0ZXZqcTBuZmNQNEw0MERLWnFKTERxQUFnOVkrSmo4N0Z0WEtK?=
 =?utf-8?B?WXVVdG0wcFNHWGZJR3NiekJzQXBJRjJWNFJBSXhVNkJXalAxUWlyYXJwZHlp?=
 =?utf-8?B?ZkhiS29iYzZPUFhHclVadmRCMW1jNE5uTXNLRElqVmp6N0NLWFU1NW1zYXZs?=
 =?utf-8?B?UWtXMXhFWnRZK3lyMmJpZzZrZHkwTU9DUzdCdEJjZ2RSbW5TL3NRT1c3Q2Zl?=
 =?utf-8?B?Q0NNblo1RzlLQ0FjSGt6TWFSeU10aU02MDRZdnhpSTg0SUpzd3dlT1QwV0Rk?=
 =?utf-8?B?MDNuWEZXTjJTTFo5TVB0NUxsUFkxQ1lXTS9QL2hncGxoVXczZGZBOFFidFRN?=
 =?utf-8?B?MG4xbVNScHNIVG9aNFZNczlSeEZtbzdxaTV3TGlQM3o1L2hNZXI1bUJqUUk1?=
 =?utf-8?B?NVJOZkMvTlhvSGE4RUZJd1htWnZack4vYzAvOHc1cytLRWhQWHNXT3BqZCtk?=
 =?utf-8?B?U2F0TjFVZmJRU1hnZFlzK1ZOUm1nS0w4eWszeGRNS1pzbmp6SVppQ01EWHVC?=
 =?utf-8?B?OVZ4WHFyMnVZMythdGwzbXJpSG9hZHZ0VWgwTS9VZ01sT3N6T1VHS0tLdXEy?=
 =?utf-8?B?aitRY0dIcVFOa2kxbXZCZFBiNEJIa2FmTmFYcGh0Wk1JbEYrejRCb1d6U2Zo?=
 =?utf-8?B?Y0VXWExSUml4QWZBa2hSL3JZNGVrSGFhWHQ5TFNXRVZFd1Mrd0txMW1DTXRr?=
 =?utf-8?B?dkhuaWhnQTMydll3WFNLSG15QXFleGM2bk96d08zY2tqSVFGODlad2psaUk1?=
 =?utf-8?B?a2h0SnFmcXVzVVpGZndQazdsWGMwaEZlM2NmVlFzbkNXa0MyYTd3NTRQM2th?=
 =?utf-8?B?OE52UVgycUVCRkhDb1pHbU93REEzZWdZbWZrYUJpczB6TmRManFJYnFDSmp1?=
 =?utf-8?B?VGxLY3dTWFdDSytGOGorME5TUVhPcFBpYWJJZndrNVNhdEt1djJoVStDZFU1?=
 =?utf-8?B?amxOaW9pZTBSeVhGbCs2QzdaSG01K25PekhzOFFmTjhvdW9Tc1NucVFkNEcw?=
 =?utf-8?B?K05kckx0d1YvMm5IUis4aHpnNUVlNkZkZWZHNmsrcURUbmhWL0x2SmwvSnFt?=
 =?utf-8?B?NW5QN0RWTUdVVThnWU9sbmhzUW9JcUV5dVNNSFRhQk8rK1FMem94Nk9qK3dz?=
 =?utf-8?B?NE02RmZKVkJDRmxZeTZmaUE2Z1R1dVpBRmhKY3FrWndYSVBiVkJmaVQ4dWZQ?=
 =?utf-8?B?cWVGOFk0cXVFck5oVU5KbEx6dVFwZjFEeitVak55NWZJWHpER3djRGs5R2dw?=
 =?utf-8?B?aDVXWTVPSnFrRFhJMVlkbUEvTnNwYllMZzFEdEhDZzdxTGdFSzdaMXNvV2Rx?=
 =?utf-8?B?ZS92L01XbHFCa1Q4RHBEZmhjNFJ2aHNkZ3ZuZStIWG5YM016N2U0OE9IZTNt?=
 =?utf-8?B?ODR5YkdiMzBpU0pHdUZxRzhsR0dVQjdlQ1c0NCtYWDBDMmVQcGlMSTVJYjMy?=
 =?utf-8?Q?ovM6guk0Bxn/1zOZfQ6LMRVamC9MZos/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aHAxbTRLU1kwODIyRVVIMXRQN3JMQlpWaFlYVWh3YU9ieGZTcWZjTmp5ZnI5?=
 =?utf-8?B?QnA3YXFDY3ZYS0pkZmRNcnN6UktWNEI1Z0MwekF1aFQ4MWV3bnZVNjBBU1Z4?=
 =?utf-8?B?VDBLNm8wU2lSZEhMQzE4UFVIdEVrWFJQNkwvbkxqeTVSNnpITktTcTBzRVds?=
 =?utf-8?B?N08rNjh4OC9WTGEyTVpybFIzK1JhbkVJNkptMnJnUnhDSEV3elRTQWdybXBm?=
 =?utf-8?B?cEF4b0ZTQUNvY2ZUTEVPb3RRSmhuVGY1Q04wZzQwcXIrZ2JZVDA3UytwTEpo?=
 =?utf-8?B?eXhTVmlmeVFkTXVTN3hBMFFTRWFLRktHVUdVV0JkMHJVbTRLMzhJcit5ZE4r?=
 =?utf-8?B?dm0yeHkrSXVXaEJyK2c1UVg3TzlBWHo3dEdyMzRyYlErS1hMQ1FETjAzRFpJ?=
 =?utf-8?B?b3VHQ2pwWjJ1ZTlSajBJVUg1OGhWa3Vhc0RBSTRZbElDdmpkQTZESGc1eUZD?=
 =?utf-8?B?cGd3RjQ3MXYxSnF6QzVnZGc5MWd6WlVhVGtBZUh0S3g3ZU5WNmVLMDYxbnpE?=
 =?utf-8?B?NGRYYStuU1pVUXBVUFRpZ01SbHNINDdPUEdQSkNKUlJyQ2Y5ZU5lNXVJNVhE?=
 =?utf-8?B?VDRTNUN0YmcrZElSWlhtY3dpeG5xR2J1UXpxQmdJUzhNVjlVSkhBbVgxaTA5?=
 =?utf-8?B?NmZWNW1NNGw4YjM2Q0txUXRKY0JIMDN3bGRPcWZCZm9YcHI4bDQ1b29oYU9k?=
 =?utf-8?B?U09PbG5XWjNaaWw1dVFnK2U1Q1Q4clpEQSt4TFNDc0hlQWQ4U3Z1SU9ManJ0?=
 =?utf-8?B?VUZiellyWWRaWnRUcVdKWjBPVXlwTzlKVjA5ZGROYU5lV1VmWlJuL0d3V3JO?=
 =?utf-8?B?cjF5KzFLbDYyWGxRWkNhTlViemphTHZydUlJY21ucmZ5M2lDT3hmd2J0Z0Fy?=
 =?utf-8?B?eUJYTzRZaWp3VGNHQ0RGTW9razQybGtqLzczcSs2dW8rQi9ONUE3YlBic1N6?=
 =?utf-8?B?aWNMTGFFeUg0dDJSME5DT1lhK3pzZEgxRU1Zenk1RVJrQ01ablVMUlB5Ykkv?=
 =?utf-8?B?RER6V0VuUGxEc3BTajlvb285WWJ0OThwNGo0VlhTbis0eFFGWERtV0xvSUNk?=
 =?utf-8?B?TWduaWdaVno4NFVSQ3ZrZWtVRVNRMU9kbzM0dkNCUm5oWk92UFVTbEYrMGZv?=
 =?utf-8?B?WHpOK0F6anh1cGNIaXAyeGV5MzlldXptSzRydFJ5WElGNVd2UXZlcVRieVRR?=
 =?utf-8?B?bXJpVTBhaU1iV3pqeEpSaWhtbUwwb1BGNk8wQ25ySHdGWkMxMTFvL3hHdkUy?=
 =?utf-8?B?RnNwZVRyWXp2VkpBYk9aajdlNW9OeW5IdmZjY014Z2hEcStlOVVDQlpleHAv?=
 =?utf-8?B?eWFKd0djcVlpdmhPcUdLa3NZS0Z0dFJxWC9hSjFiUTNUNmVGRDFmTGc3Rm5k?=
 =?utf-8?B?VUZwYTU5S1BmZHFLK0pEM2s3WklCN0V2aXc0VWlHRy90cnlVK1FHN1hlamZK?=
 =?utf-8?B?d24zQ1BTbTl0ZmdWRTFsTjdBL1A3ZGdGakJidm5pWE9HNDB2WVRSUHdSZ3Zj?=
 =?utf-8?B?c1JTdnBmeHBUU1FUWURob0I1WkNNY1dkcFNoNy91YUM1bjRWU0IxdTFMejZo?=
 =?utf-8?B?bFhmdHBCaXZNdzdsLzRGVmpPeHVSNk1zVkg0MEF1R0l1bitkRFJVLzVxWVQy?=
 =?utf-8?B?c0hOSkp6MmtPL1IydUdzNE1jLzVnQUVwdkJWMmdrcmlSeHh0RmxVK0F4TGdJ?=
 =?utf-8?B?blB0WVJENXF6TFVHZkZUWFNYNnRmQlBuVHZnQXNhTXVlVmQzN21jWXdiM2Yv?=
 =?utf-8?B?Uk4wcW5uK01FMTMvUEM5REUyRDJRdFgyUDJrQXFWaXpDaGFzQ2lrd0ZrVGVw?=
 =?utf-8?B?eGxlNWtSMDFqc3B0VHpaVzBGSGFsbGdiZDNvbFBCdFpLUVVtK2ZCdVlGSHNN?=
 =?utf-8?B?MlR1Kyswbng3RjZ2NEtIcERvWE9MM1VLM0tzZjVDK09nMzlFRE8rdVZmR0t6?=
 =?utf-8?B?V1ltaGpoeUZ2c01wVzE2eTVQZGpaRk5PaDhJSzZPeHVodUFUdkk4WVhiLzZM?=
 =?utf-8?B?bzhtcGJoczVMTHZnNGZvZGpqYTNrV3hRQktNcUJTRnRMcEpIU3F6dm5JWElZ?=
 =?utf-8?B?bHhIV1I0bHZrN1FPUExxKy9EOEVqOTRaWFJ4b2lpa1RZNVBpeHJYQ29hN3Zk?=
 =?utf-8?B?M1hkaUZBTW1kWXQxVForQjVzMnNCU2VaS3RFR1dKK25yMjhicUIvcEwwWWIr?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEE156941E4C9A43A268B4D8F24989C3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/2cQedBZ2l5Cg2yniKR7JzpCuUZVukfoKLBRrApLwFPPyXCzfQzAO65ixczIE7jIYD85TdQhMK2hT3bTCCuHkn+N10ivAhNNJKYPOofhDB3ML2fY260ViKRwskshkcUV9hwHsSS9MdL9bzjNomsY4yFkaxTM0l1q5dDBMLbd66cUFWawPYZ1zmqO6WmE3rP6PYrcJxdC5vhlOKwojZ+V06rjxXE1Bc8WNdNrGAdqZTp6/xFCR3D8d6LFOHmIAirLPP2Ib55fgNcOx+7Gfab6JPtubWSSDbO5xZmcweOtEdzYTg2JUBX2yvRho6f+mt7IkEwdzt16cYkY12ZtO1FJwzd0XuliOpfsdivrF13sIYYn1yIFF2b0ao++gE+trKabHxTkGToFAOaKiYPdgF7JLSNiR3f0vXh01Qt8TCsyvmApJIxZYfH5BAzBu4Wo/sYUd23Rexv/jX5Fczwu4Zr2rKOJTPMWsxtKz0KTbsMjjNeUOdqnromyKbXhOynTbiRtvhuCnvF9FEWhglRB/bBYPqXqNrOpMecWi8YcwFXX/mpfEaKIhy7LWvExL9tMyqpT4zWEMsAgUzTmIRjH6yVul9M8qBAigy+gyIA3SjBFO4BHGql4vJBgOvlrkQjNmSIl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6e54ad-5755-4889-eca2-08dd39f84784
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 08:47:47.0434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hjMeDXFRz/cZABiVH9Z/EIvVlxxD/2kFslU+VkMDuN4BtvxL+HdT7OEcasM/qfeEIzv6AQmU4IJMwc9T9F05f6COCiBp8lJsKxl10u+oIVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7581

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

