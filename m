Return-Path: <linux-btrfs+bounces-11078-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5656CA1D64C
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 13:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6486018875BB
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 12:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689CF1FF5F5;
	Mon, 27 Jan 2025 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n6RamM1Q";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fCEd5WFl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EB318D
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737982713; cv=fail; b=KCiuaevrCz13zSqk15i1wp8dN0BskWIFAjXdmIHxcVYPaEio2iptvLmLQ4mFN7nYi7tVysblpv7+e3o+BGT3i7SyjlgOt31fHZauo6XDzC3RIFxXKz3zmF/CuqpHVkTBHd4oVZvzu834QnaGDLTMQUhjEL0ireVYD5npCbevq9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737982713; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FRmBgB1vpHkKI6r4HekacZcfI3d/GGnIxVZN6zLmmyzBoVoSWHKE8ZKyQriTC2ly20GUE6kZeenQN5CoMvfiKVh3Q5LZCfa23Fyik6nnEMEqK2ZzQvgxKkhCsynyCosjHMMk0wN4L/4q9oxjFNymJr1FqKVT8wyyqeq1r7juANg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=n6RamM1Q; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fCEd5WFl; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737982711; x=1769518711;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=n6RamM1QEfs9EZilPSDdfNwp9I6jrUs7R3NQXXMM8ZzHDZFkb9BHtgr/
   cNVYJ3rGw22Etf2yml5BIynqzxD34O4WDby1fYKix5LyjjJWw8ZCxArgd
   PnyudCt7ecDrtRIJwqiUvvHRo6IZNC7WeIVYOzaD0Lt/w2YS9opzGHGK5
   RZkdzwZ1E4iR9DLdIHSPWH4nAGvpJJ0DTHNCzCyOBVy2Q4sSKEo69jZek
   +mCNRzIrMUdO6a/PYTcs2Fxa8FSi8FO72t3R91wmYk38dVeg/TQ0PQ9py
   Zr6LfQubnwdjNJorXcbLr3if2gpp0OkehK8Vqbruf51RWqOtn7xdQrCZ/
   Q==;
X-CSE-ConnectionGUID: WD5R+4z9RbKgmsSPBKR9+g==
X-CSE-MsgGUID: 6v8ybxkiQgeGe7j9IHJs1g==
X-IronPort-AV: E=Sophos;i="6.13,238,1732550400"; 
   d="scan'208";a="37429172"
Received: from mail-northcentralusazlp17010000.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.0])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2025 20:58:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5MiqU7hF8YvIF1GTuQoPegJAxw11FjVc7eQwPDaht4qPefNzR4CEpHV1zVTW9I3/4z8s5u0tdJLHcQN+kfQG8keXOYH8vPFJnMmH9D8f28fXx32HaMSyQ8+4jb1x7zZsZs5WnJk0NwYNxlJOqgHORvS92+q+Ph4vqK2okg1hcrQdr6428/ahU9dLwpFtJva4IosR0leKWHbQ2+fC6H/UF8cWKqc6VBsH+ZzG4lOpUsTB5mlRaztf+3KF2Wy/cf4YdQEhvOAl9QBy0fLbx5xpwIFiQiFv6GzwTRKof7dj/HS3JdGErJxZLNyxxMWhu/MtYvhW/pvmrSeYhX3GgZz8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=It8GfnXSieJrREn7Oe0OU+OnPqTMEBTXLRo/kj1C5Gob9+LZRrdXr6J7eSwqwQe7kLH1Gddkh2hImkq1PBgvk08M8s7KOAaSa7TXj/DgSD/U+wSrQSdL+pkCZUvzp9KFMPb/auo1oYQEW7tY3In5UCr6a0vzUE0r+PCfUNMdVGKa9esgie3GfI5jNYnPNc0Ec4+NhfZnPC4VLSYQpZbdaA0vlmMQN0Dj3WusZpEcb9ig75N70Wd4d0uVPBBlMjgbndQC9LNxcaVLIK1UFi8hnEyXR8wkevE2w7Xq8qL1EPJ5khMmROfqW+gAkJEMuTqk/DP6Ha1JaV8g5ipClsbQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=fCEd5WFl98dX3BZpGsWhYUuR9wCxlKiOWaG8zUMxlzzdlMmqu4jsorFJgDlapWH6yPza3+nAeFeiN2tvCeplOCVqS58ANvQJPEyYIusCd4MeHqxZkh+jF8FDqKJEoBE/l+V36fRc9Ifm9zbbD3zTklIJaddJbpeqEPNq/RKRAsM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8161.namprd04.prod.outlook.com (2603:10b6:610:f5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 12:58:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8377.009; Mon, 27 Jan 2025
 12:58:28 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove duplicated metadata folio flag update in
 end_bbio_meta_read()
Thread-Topic: [PATCH] btrfs: remove duplicated metadata folio flag update in
 end_bbio_meta_read()
Thread-Index: AQHbcJbZVXCz+yaAFkeUbmoezgEg97MqlSKA
Date: Mon, 27 Jan 2025 12:58:28 +0000
Message-ID: <cef1118e-24cb-49ed-9d7d-96e47eea508c@wdc.com>
References:
 <06ecb80cf50feba2a430f5c819376cddd8a9cca9.1737967048.git.wqu@suse.com>
In-Reply-To:
 <06ecb80cf50feba2a430f5c819376cddd8a9cca9.1737967048.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8161:EE_
x-ms-office365-filtering-correlation-id: 680959e6-d2c4-453d-3bc8-08dd3ed24b33
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFZlMUNSRURYSUJnK3hCbjFnNFl3dkxWbi92b2RQUFYxdDA5VTB4Nmk5cUtq?=
 =?utf-8?B?b251eEZZUWlRUlpzbjlaOEhsMnFSWHFqYzV6cE5HSXU5Zk1Yc09jZGpqT1la?=
 =?utf-8?B?VTk1QjdRbTNqREZ1NzlwL3JwUW93aXk1UVZHazgwRHFvOEhSYWJYdEl4clMv?=
 =?utf-8?B?ZEN1c0xodGc3Z1VES29iWVNyRVRzSko1Y0pQREVHU21aM0FBZFhnazkxeElm?=
 =?utf-8?B?OXNxZk11cE5UdnVRZWlMZHVTc3VIUGV2TzRpVENkZ1k2QWwzenYxRW5La3Jm?=
 =?utf-8?B?bVJlcFdPZHhtMUMzUnhrSlliUE1BTGtzS0l6QUhQTFZaa0hIY3RncCtXRUlO?=
 =?utf-8?B?ekRTdkd4dGQyTDFNL3BkT3d6TCthUm1tUFJCUXhDVWt3c2J3bmViR2xNbWpE?=
 =?utf-8?B?S3kxOUZwMTJNYzhNemU1QUoyUjBZTmJFRXlaT2ZnTXkvT0wzUEIzM1JNVXk2?=
 =?utf-8?B?VkV0Ti85SmFoTk40VTVqWXN5Y1pjQ0YxMWpMb1JwUUNac0w2YmliNFVubGJD?=
 =?utf-8?B?cmhDclZIZzIxRFc4ZWtBK3BFeWo1ZXF3Q21QcFBjU0Q2VGNqTEtkVVg0U2U3?=
 =?utf-8?B?SFArd3RFd0daNFpuQnlqS3ZtTnRHNFFGVlUvMnl3TE1GQ3NGSW1rT1JVZzFu?=
 =?utf-8?B?NytGbEpVL2dtcXJqTTc1VjJhQzlidTM4QXJxSkw0Q1V0aU05amRuL05rbzdN?=
 =?utf-8?B?S3hQN2V4S3lPa1BlR1Qva1hPZ01MUGt6Vm1NK2hYa1hsY1haSk14ZjNNS0lC?=
 =?utf-8?B?bkNQRWVUaEdHTGxoZkNCZytaekVwbWpRLysxL0lTMWxYR1RoNzRoZHU0a2hM?=
 =?utf-8?B?N0N1c1puUlN6cEd3QW1sdTFrdWtkd3FXa1N1Q1JnZ21mVmRGOGcrSU8wcFBh?=
 =?utf-8?B?VS80bkR4QWZPdUlkUDRUdTJMSkh0NndXMmVnbUIzYU9JVjB4cDlxekorcVIz?=
 =?utf-8?B?aTlJQURXUUpoUkp6WmtWOVo5bExzKzZCTHgrcVhiQkt6dDUwN1RKbHR6VG5H?=
 =?utf-8?B?Z3pacjV0M2ZWQ0paWjVmUFN2bVQ1ZG5MOWY1Z2ZHWUpGWEZSV1IvQ2JxeWo3?=
 =?utf-8?B?UjVMNVZMNUphRFR3c3J5OWdsb1VaRjBaamYvc29ITkR5dlR4QiszK3NBU1JW?=
 =?utf-8?B?ZEFJdTFIaHlqcmQwWk9IaE9kSWZGTGZ5dDg5UjBDV2lVcHRNeThHODkzbjR2?=
 =?utf-8?B?WW9PMkY4cXZSSktwY0hwa1Fid3NzYTNZc1VsaXFBenBndGxhRU91YjNxcEZX?=
 =?utf-8?B?Q1JEUldqcTFGOFpmY3hxNmFPMFdYZlhDbm80ZHZvSEVvNDRUV1dDMnEvd09S?=
 =?utf-8?B?T21lSjZmVHJhR0NPbTJkbm5paWFLM0tWS1gzcHJydm9KaXdZY1QyblQ0YVVY?=
 =?utf-8?B?U2dic1Bjcmh6bStBbWJUemd5cXNFLzF5SDdhZzlKaWhsQ0hDZmJtaWdKaE9t?=
 =?utf-8?B?VUx0dGJTeW0wZFFCNzg1bWxhRkJveEc3OXFITFNEcjY4aFVxTWd2QWZQVi8y?=
 =?utf-8?B?bGdZZlJDWWNhVGx5VlBGdHlVT0J1ZUVRQUN0OE1VQk9rd2QrUGhmTFJkSlkz?=
 =?utf-8?B?YURUa0UzVk05TlJzN0N5NmhxM25IUzhhMVFHY0RSMWdmRHNPYWRLVnVsZ2Vx?=
 =?utf-8?B?aGVxK21DekVNZHViTmNiNnJkMDJFcHhUS1FQd2lvSDF3Q0xubEVNTzNRbVpE?=
 =?utf-8?B?WGMvQm9LbjBpNFFJd1VRU21mRlVrYitOaGFVeVNLbWp4QWh4aHlyR3B6c3pz?=
 =?utf-8?B?QmRublFmQ1BUMmFDZFJFTHpyZFBIVWMwdlpDbE5SOHJpWGc5OVlJS3daRGhu?=
 =?utf-8?B?VVR0MVRWTUNOSXc0YkNXRjY2WDNBMTk0N0loVjZvYjRxYW9tUTN1clJROFJP?=
 =?utf-8?B?cTVFanNqbWx5anZsUC9wT0MxOFFydnczTHc1eC9TbTNlUDQxb0FtV1lycFlu?=
 =?utf-8?Q?p711K27ZrxUucDTUqFY2kSfTw2Ssv/zI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWVhVWZtbHo5Uy9BM0NqNTY1OW9KcGRzMEN4Ui95VmlZbm5Gb2Rwb3dZTmtP?=
 =?utf-8?B?cC93SnliQkZZUkVLTHFsbVI1Y1g0SkxrRjd4akcvcHZTcmtXRnlJcWF3cUJL?=
 =?utf-8?B?Q1A0elVad1llSEpodmswOUV4TEJhd00zWVp0VWxnd2lzNWdkdWlSTjkvK2M0?=
 =?utf-8?B?Q3Jwb0x5U0hlNnZRL240R1RObm5DNzJGamNRTys1d3ZsMFE1Zm14Y0hoeVUy?=
 =?utf-8?B?eWFGT1lIZTM0aEFFbC8wK2lCRkFZbldZdzQxcjcvUHNCK3Y2b2hLMmhFSmRL?=
 =?utf-8?B?dUlPcGF2LzFrS1lTVE1NZEZUNGdtU0sxbnQxaDVtMWVRUE94UDdRaFZhbE9M?=
 =?utf-8?B?R1lCR3kxdW53eWcwc1FWQXFhUW1qeCtqYWNyVVdwMG51VkdSSDZoMzBMeEtM?=
 =?utf-8?B?VWVrWmF0ZlI3OGs5VndIMGVmNlJYSCs3VVBERExLSFBLaGlISGQrVGo1OFR2?=
 =?utf-8?B?MnBTVXc5Y1kybWNXOWxhaXZpZmMzdEwxdTRsS1lxYW5xaC9oc1Jqc0FZNkRv?=
 =?utf-8?B?Y0lERW1oR0VaWkxLbTl1UTVIbHl2dmdRNXhlTTFpSHkvU3laeU5ENCt6cTdF?=
 =?utf-8?B?aUNMUjVoNnUzYWZKQmJoTHZBeEMxNml4MGNKZkZGaTFSTkpTWFd5ZE01RUJ4?=
 =?utf-8?B?RDB4ZllOVE4rWjNPUUswUW9oOFVBZVVuT3lVei9uMXIxbkhNWU1jNEtkQ3Fl?=
 =?utf-8?B?RTV4N1A5RkdTUkJ2bGdLUTErUnR3Q28rTEt3SVlua3VLVHRoakVyTWNVUVIz?=
 =?utf-8?B?NWo5SkFpa2RWREFxTExWNlRJME5jQVlyaEhZTlFEYmlmenVRMWdYbUxLQzlW?=
 =?utf-8?B?ZHJ3RElTQmNLNGlFd3cxSEsxY05CR2RTY1Rqc2lvVXIrM1plUE16Nm5hZnpT?=
 =?utf-8?B?Sm1Pc0ZuWjVmZ0grODduc0JKSk5nTndRNnpZQUhYWWE5MVFJVTVzc0FuZk5i?=
 =?utf-8?B?RWd4dForYUJvSEZUMGNLaWs2NzAxd2o3RW5JbTMvdGtMOU9pSDJtaVdRU3FS?=
 =?utf-8?B?SmU3NmE1Rm5uZUpVUDlKS3IxNSs2WG44TFIvMEJlRlFMN2hEVkIrUzJ2RGRY?=
 =?utf-8?B?d1RVL3hWeDhEY1RpRFdpQUZxYlZhSWtuem5hMjRobU0zZmk1ZXdOVnB1SVQy?=
 =?utf-8?B?M0s0bUhZN1UxNExENm1ac2NKaktKeWx0TFNpY2FzVWFLUU96OGhULzNsbGtm?=
 =?utf-8?B?OXlrdzQ0MkxmZEFlYXFXbHdVd1dLMG0wdktaNHcyRFZoSm5uR3NNY0pxMU1W?=
 =?utf-8?B?NENPcjIvOHFKc2huWVJkN1R1K0gzQURiaklPQ3oxL3RidWxDZitwM0xOR1Nr?=
 =?utf-8?B?dTd4SUloRkNNQVg2V092MFdHdHpoY1NUcHJ4TWxHd29jT3R6NEJZNUdRbnBF?=
 =?utf-8?B?NDVLUFRXMjZRazlvS3k4U3pjaEdZUzdZNUxGZXRqRmhJV2VHNllzR3FocDBC?=
 =?utf-8?B?Z1lSVWphY3FTb0wrS1JtSW5UeExSR1Y2N0V3Y015aU1hWjhUNzlielpYZ3BF?=
 =?utf-8?B?MldLV3l5Wk8xN2Nwa2FDTklNZnhsZ28rUjBBOHNVU1ZIMDUvZVVPSTA2UFFw?=
 =?utf-8?B?VkZpZnhyeUVKNHpCYm43N3E5WmtaVVFRVG5GMlZyMDNFb3lhcTg1bjFXZk84?=
 =?utf-8?B?UGhPVDE2bmNlR3lOT3dnbnZqMHRVQ083cmFTMEY4SUNKYmJVeDRucTNIK3A4?=
 =?utf-8?B?RWpvaW8rTjhxNHo5L2RiUE1kMmhXVk9VQUs0VUhYQmN1dXBaZ25jYVNRNDZ1?=
 =?utf-8?B?NjFtTzN2ZTdIcExvSkZ4Y3VFK0YxY3UyRjFBWmQ0Slk5VXNyU2picFltcTll?=
 =?utf-8?B?YjUzYkhCL2x0bmhGangvS0p3RzgxbjB5ZjIzVE9nSTB0aXFrdUdHaDB3N2FS?=
 =?utf-8?B?clpmanlNWjIrS2FHZ04vUzRvUW5NbzZpMktudHltREVXN25kZ0NqVjhVYmRJ?=
 =?utf-8?B?MzJ2ODJxVXdBeklZWGZIUXFzTm53dmJha3MxMldJMkJiRUVRZ2VydWhWandK?=
 =?utf-8?B?VjNpL1E4NkZVSUVjMjVvRjhhOEFSQXcrTjBMRkhQNGwvZlQ0Umo5YVRidkVN?=
 =?utf-8?B?cXJpbTdJbm4wRTJXdi9sKytjb2ozeHFwVDRwT0pkc3FiMU1yK0tyQlNwbkZC?=
 =?utf-8?B?ZG0zSHIzOUFOUDd5MzJlZHdKMytheGZPUHRyU0w5R3AxeitWTG95R2Rtb3Ay?=
 =?utf-8?B?ZVpXbzF6c3Zac2hidzRiUEV4ZDR4WTFtNHkrYXRDWnljanNUYXNHWDNMUmMr?=
 =?utf-8?B?NElqVTErV2tvWjJ6cUJLdFFGU2V3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C42D70849A8F34CBAB40225867500C5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gOnfWL05IUAo8C7OYV8S0hpcueT7e3/RkUgtNa9IIOtd45LDInRq3+7hRyP2KvKR/iYObo2oOe9SffC8R8+nkwM+ai8GXGGhiDC89btqD4yKoedmNFnvENmQgT9hXK2+Rjf2AiTXrME7TtKcdYzVnSk71m+b97uN4FrU4l0HL7T8f5ndeP6EaUMHcn8ZfNGanPyzA2M4GgvVS8fmOV8lvlvP0Tm3hhOz2nw3xcefDzCoI9W+KvJ+O/a9Co4xxPubopr2+GFiX7IdCvCZqyBlAdCeJ/CiCxuNm9l01TWtIqcn1IdjwhOuV6tJmgKefK/phl0BZQRBLpUFqvkW3jVDVnzmhQFzrY68K3Emwhh2PpTjmWpPp/aJ5han45+EVma/DAbNALZdOEoMTXfDBgVhY07gxcGiGFrOtZCAhejnAcQNKgFwCgu++4z4Yjt6wYbyL9G2X/QRJ57byM6zxcRgmuMSYe0uEPVD9HyVtaWtl/9nD6oY/NUy37w2PZ3JLvLfTglDvvmlfKNaYnC1Oz2PLUhBcdYEYDZrXS5IBA9qmtvxdzTiVoLV38haYt+LJ+Lq8U5LiEB4VUAxI/oygUcowKOq3ZbAW3yifWhTAYQcJ/B6qYPwuH+QfPBBc8YgWIvF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 680959e6-d2c4-453d-3bc8-08dd3ed24b33
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 12:58:28.1929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HTKWOilsZ5kC3SepULkqSjnuGy72+Jl3RPfh2Bl0S98xHdRmbbZbyt7jeL/a+8A6mbECV95+Ip6Ru+UCRKTTZOa4RLKt8APCNPgsFOsovI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8161

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

