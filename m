Return-Path: <linux-btrfs+bounces-10867-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352FCA07C07
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF642188469D
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B4B21D008;
	Thu,  9 Jan 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CoLAnB65";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="0OxBRYeN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117F5249E5;
	Thu,  9 Jan 2025 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736436675; cv=fail; b=SehSobZzt/49OG2qpgAGREsh1N7tJhktMxx95Fc2s+iUe8r7dMdyYZ36grONgD+XwSYN8gFcZ6+WQ975dzy151e39UOG48akEeYtWX7RvC4P19Odgyb3d0sLUKAKcxau/R5H8goSXAltxW48NRYGm83GqDzf4+oPiwChReEuVCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736436675; c=relaxed/simple;
	bh=gpu23V0L3KuySSwf7Z+tFu4J8wojMQkek/9oSdQfUXk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DW1HOKF88zgrut7Rh8YgnlnbwIeb/FpzGON9/QN1+ij/Da0ve/RN2USchZR4Us9dAtsXawYvO+B+E6y24qw7e6aYj4EMEnk5yNurLnuxulvVQEKGMN8Bcz5gXNNSEUqPH07eRAkEWwionPps2XM0xW+TmSOlWbj6IJa23CXOnhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CoLAnB65; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=0OxBRYeN; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736436674; x=1767972674;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gpu23V0L3KuySSwf7Z+tFu4J8wojMQkek/9oSdQfUXk=;
  b=CoLAnB65+7Fb6hIHjP5YX+UuyJUIE+Ss/it1VAHtNW/Q69gtyFFj7UiW
   tXklGpQiJD+CTE5w22eCW0PApeCRf0YLaSpJCJwZs3V4VfbNhhpy2Rhes
   s0goMrrkrI5Re+gua2pLLTamnJtpFnwP40f1UrUdZN/ShhjNIlzEHWFE/
   NrYa/fTF+ykssHhvR2CGunga8SG66Aww9xNrq44INT2lxWGmbqbGGq4TW
   zPcdHuImDX7B1Q5awPZCkv+mecIq5l7ITwikWBCl3dVnOZL+TwtKknsjl
   3Huhei2kuyFVam5CbGwfYUM4pBEPt7UIspIzPnkFqK+B0sYII3vEjQioR
   A==;
X-CSE-ConnectionGUID: V5cGHvIiSSyWcZJEAQS44Q==
X-CSE-MsgGUID: daO2loNnSxiFWSb7I4jq/w==
X-IronPort-AV: E=Sophos;i="6.12,301,1728921600"; 
   d="scan'208";a="35577977"
Received: from mail-bn1nam02lp2047.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.47])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2025 23:31:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ez2bgQQJZRFNZzFGePkleCWO+qtMotMpG3z7ROwAgGcajV+9SFYk8DL4yA2xGtsnRo+kHXu33nzwOxi4rzusOYE2TrWCKhD6d7vktApYUrCeFA0s/0drgiEcZ5KXEKUNvHAUYhEAFXlGeCGB639IaV9IUnToBHouKk7yQcamy4kOzOWMb3xC00kJOdXruXdLm1OCHK/Q7nN+ICdIQihR5eV0/MvP6GVSUlmbVFCivIN4ISJfP0EQAUoKiip0W9Wg2XIfY8mdN1kZM7aM/XUiHniI+A7XBK1w81PoWalwVe9jSqLsdzP+JUZQIhDKcqz1V9nXPIKcZ34PVStnSldR3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpu23V0L3KuySSwf7Z+tFu4J8wojMQkek/9oSdQfUXk=;
 b=MYfvL9ulZPEkA1vC/HrRdYwWyjLC4JGCFRNA21eOMybGCBhYpwnaozzs2qy24stGLgYuSci0JKf0HFqTRRXOpl8604ia11wTImEjh/YF/+yvQhT7p5GvM6SKwj0qudOoOIKTzqjSIZmQuCL3EzErahBg/jH+/N1IjaKfFKYwAwcqaAstlLUjEjdf4cDem5QXb4b1q9ss0p5W5UzVq/lXkX8zITFcBA8Dau0K1Xff/YHm1x1tbpoxYx1MH1KkLIU3A+/dWqb0kyxdT1KWHrF2lGWzOM07fzpEyz5tq97ecgsQL9Zdg1swg6Ml6E2Uv0OOoKdzRKnQGKuw4xlwNMdmXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpu23V0L3KuySSwf7Z+tFu4J8wojMQkek/9oSdQfUXk=;
 b=0OxBRYeN/o6hFMO0c1ANnYZ3JCSASNesxmJo0/C2H5YXtVey6p6uUK8taLEw0BP3drb6Gsx7VCDqEFRQG+aZsATPBTxdrbec/hC9auE6mAlKARcFPcLfkDKMxxFUzs6PmSaKABS2Unvh3NbRgJaiMUzF0SHn+9HHf9W/rZgKlqo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7434.namprd04.prod.outlook.com (2603:10b6:806:ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Thu, 9 Jan
 2025 15:31:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8293.020; Thu, 9 Jan 2025
 15:31:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
CC: Filipe Manana <fdmanana@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 01/14] btrfs: selftests: correct RAID stripe-tree
 feature flag setting
Thread-Topic: [PATCH v3 01/14] btrfs: selftests: correct RAID stripe-tree
 feature flag setting
Thread-Index: AQHbYqlQ5e5aU2dTiUCt2qY1W0d6V7MOkaoA
Date: Thu, 9 Jan 2025 15:31:05 +0000
Message-ID: <b4921674-df1f-4c49-9587-25bb810534f2@wdc.com>
References: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
 <20250109-rst-delete-fixes-v3-1-b5c73a4b2a80@kernel.org>
In-Reply-To: <20250109-rst-delete-fixes-v3-1-b5c73a4b2a80@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA0PR04MB7434:EE_
x-ms-office365-filtering-correlation-id: 7d26c0a1-dde9-4691-ec76-08dd30c2a1b9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0dZWlJiemNnYUdPU1g4eHhGbXhPSEFiRytIMVRLd3lieXRXVUtKbGxNbG84?=
 =?utf-8?B?RExvWkJIdnNDZk12c1hZaXp6TWt5Zk9IcGdYalNEb3lCaXdsejl0LzU0TEVz?=
 =?utf-8?B?V1BHRm1LeUlMVWxLcUQyQUkyeU9xaVZlZ2FDTWFHOUZWQ056SG5EU3F0QUpM?=
 =?utf-8?B?THlTL1ZLdytQR01PWU8yTU1kQkNBb2hQcWdKOTRqdXVKZ1g0RW5abzZOS3gr?=
 =?utf-8?B?c1hURTFEczJyUDZPUVFxZXJVWE1PajNqMGJlWlhJZTJFWjhhd3RHcmExRHBa?=
 =?utf-8?B?bzZPZkRLbjZiZU5pWjRQalJ2dm9pR2Q5YlJCV005NmZZUkJWL29aTXFzMEZ6?=
 =?utf-8?B?L241emxHclpoRCtiZkk1ellScDAyQlZjU1A5cFhGNlFXUjBUTWh5Uk1OM3Q3?=
 =?utf-8?B?NitFQVZwS0JXTzhYVzBHS0lyZ1dLR3k3aHlyb2hNM0kvK0JXdDlUSnlmZkNJ?=
 =?utf-8?B?UURHZ2d6bVZRRmdSQkpnS2xDYW9DK0hmM2NzdGNtTmJKTlVCcTB0c2laM01F?=
 =?utf-8?B?ZURFU01hNzlQVDZ5Z0JrQjZ2cEl1bk9rQ2l3blpPQ3NXNmRrSnREcElmaGlB?=
 =?utf-8?B?UjJaYmNCa2h2K0Z0dW5hS0xna1FlNzVSSEZWeUF2NWJxQUwwK3ZoRnZvMjFk?=
 =?utf-8?B?a0Y3UW0wUXBoWFUrY3A2Qkt6WEFEUHZWYWZBUjhmUXpSSi9DWTgvN2FJZHZk?=
 =?utf-8?B?aldPU2tpOUF1TWZ0Y2ZCZFRqU2VtelpsRVN1ZTVGYlZhKzBsbFdvbjBLanlG?=
 =?utf-8?B?dHVtU0VUV1I1L2NXakZBUlF2MEUybjR3T2REWTA2R2c5UVNlODZLS0RBT05H?=
 =?utf-8?B?Vk9lb0FkT0V0L2MyOGp3NjVRUi9obmxJUFE4a1p4VjhPWGhjQ0JlTHVGQ0dM?=
 =?utf-8?B?aHdQOFJ0enh4eHlROXhUclJNTUpWdjlDbldCWFpsbWpIYWdVZnJwdERiNU5x?=
 =?utf-8?B?TUx0MitXNjNDTHdrZm91MURzTGtxT0ZoWXlsSTY0K3g2ZWhCZzY0SHFKUXd6?=
 =?utf-8?B?WEJGMWVTUFh3TmFPR1NpU08ybEJKTjNjbzZSZDVid2FYMWtDdXFMNkhIaldR?=
 =?utf-8?B?RzhIU2YxLzRtdWw1akxIMTFRQWlOdFlSSEtFNGRFWnRqQy9ucUdvYTVkL050?=
 =?utf-8?B?ZXVDeG0ydXNmZjZCenMrRE5oMStXMnFlWlczMUMvZkZzOElnSFpWZFc1akx5?=
 =?utf-8?B?U2lzdUFEM3QvbnVwbW9nSHFqUTZ0ZkVqTy9vVU1vVzF0aDk2djR3UmhKdy92?=
 =?utf-8?B?Z09ud0pMZE1LMVZjSzQxYS9MRnovekNVc0dZeS8raVJ3TU1GMjl0Nmw0TEZx?=
 =?utf-8?B?N1dWWDhielBXS2FSblRBRnd2b0lQeEpIRWZoWVlhS0RLa2s3MmUyUkt6TjV6?=
 =?utf-8?B?YktsKzYxemlSeGtyRm1ONndMUllpWWV5QVZYVVgrZ3dXZTFtNER2T3kyR3gz?=
 =?utf-8?B?aCtxdzhkNURoZFhQeHZ5Zm8wVFhzalNkcXlpRE16N21FUFByM3IrZjlYUHJQ?=
 =?utf-8?B?NzdrM0Q5QmVtTDJSaUsyTnVNYTJVeGdJMG11VnNlU0RNMnBBdGR4UDY0YWdh?=
 =?utf-8?B?THJZQzVvTHo5WXgvMzRCSzh1djg2MXJuak1UNHdPc2RBSlFlalZwZnZpU2Jn?=
 =?utf-8?B?TG1ZWnltRlg1M2FjMG9NRS9YV3NMbDNPWS9WZWtMc0psNDIxTGgvaXhFSjYy?=
 =?utf-8?B?SUNaaU94S3NLMmNPSkpKOVVqVG9ydlJHYStzZ2hjZlhJU0JnWHJMYW1XTkRr?=
 =?utf-8?B?ejlNYnhQWlBZalNJakNIaFZaVjdNdSsyQkZBbkg3OFpOVUh0dHNCOTNKR0l5?=
 =?utf-8?B?UGxLYTMrM0M0bW1QNGZuckxtZUhQUzFRUmdyRjZ1VHl2Y2VOVDRuemI0NGxt?=
 =?utf-8?B?bmxaNWJjM0ZUOGl5TmNHTzhyeWJnUnhPS1lEbFJYNkVscWVnZ1JTb2dIaDZZ?=
 =?utf-8?Q?SsBYuGubo5beffH6grWSdDKoEJEKJ32G?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnRPU2NGM0FhOE4rQWFlTFMrOUVjeEpudzh1UkVCWHhTSFF1OUIramp1Y092?=
 =?utf-8?B?bWRLU3N6U3orQVJRcUhsdHVhQ1Z0ZnJ3Z0xkR0FnU09jQW4xb0djcUFHNU9N?=
 =?utf-8?B?WmN1aDR0S0NmOGF0NUpRQ1ZqMktNY05pbXh4bjdJTGNMazR3OVNBRW45b084?=
 =?utf-8?B?MndyNUVKVVRmOCt5Wi8xNFV4N1dBbjRxbENPT25KV2UyN2ZrOGhmYmRKKzZy?=
 =?utf-8?B?NWd4OTRZUzNhSHNCTHNDT0RhdzA0RFBueFJzNEZUWVl2Z29nUllMUjJPc1Br?=
 =?utf-8?B?aGxvc1N3aWFxUUFnbUJnNGlsUUVuM1NBdVZSUjQveVd5NTBSR0FvZjJEU1kz?=
 =?utf-8?B?VkxaZ2lFc2J5YnBmZEVVRE5yR2ZrcWhFTEZVbG5yL2hvY3c4T2dsT0tvMTFC?=
 =?utf-8?B?ZVFYRmc2WUpLenRmQjA2bFlGNGdSY1E4MTNhdHhkUkh4WjNwemVjVUJyak1w?=
 =?utf-8?B?bUdhUGM1L3RQZnUrWVM5d05wcE13VTNVRlhobUh0bzNhSGRjWkQ5WW96UUpI?=
 =?utf-8?B?azBucHYzSEx2RERCclUvSm4zeDRkZUhFME82amhXSXNLUjk0NW5XMk92ZnUw?=
 =?utf-8?B?bGFqb2JUd21wVndFMWQ3SXRMVHpjcXZ5ZGtJRCtSd3hzQ1liSi9zMEJPdG43?=
 =?utf-8?B?SkFmZitiaFlvaXZWV1NVYlBnSHZWeENZYlowelVRS20vSElLbkVpT285SmR1?=
 =?utf-8?B?ODE4MkxyT2dwUlFlNk5nQzNXMVFOa2hCR21xdXkyVGFvbEhMclByZ0hHQjJh?=
 =?utf-8?B?azFrWFIxQVdyeVpreFJqTGlZZys3TmowSDNjb3owanRUaGdoZkgrQjg4dUQ4?=
 =?utf-8?B?ODI0cmd6ZzYzQjVWRkM3TXpHTWV6MzNVVGdEaGlWZHVRQnMvSVZnYThaRTYw?=
 =?utf-8?B?dkxveEFuSDJyZ2xaMG1DTWt4QURLWldVa2VtVXFyQlBnRlA3SmxLN0JMUVdZ?=
 =?utf-8?B?NUpOLzQ4N1NsRUMwRVdmZE9kRnArOEYxcHdiR0JRQVNkVk0zTFlGdnpBWW1q?=
 =?utf-8?B?NWJLdGxMK1RCeG1xM3QzSExkcFJFeURwWjZoSElmZ0huRnZJVmUweW9QcGRZ?=
 =?utf-8?B?Q3dmM3pIT3pyYW10dWxWeTM4ZGVKYkZ5V0tTZllGbVA0MS9PdEtiMllHQkQx?=
 =?utf-8?B?UlY0MmFMN2NET0dTd3NMV0FMVHdObEFlT0o1NzVYZGVCZGg5U2xUOVhnbXhK?=
 =?utf-8?B?VUk3ZTJ4N29pZmo0WWhjdllqbGJzbjFQclgvWVJqSUZScnVkNEJzZUFEM1hn?=
 =?utf-8?B?M2dUR202MmMwTy9oamkxNmdmZTJBdW1TclZpb21IUG5KRlBDY2hTTFRqQVRu?=
 =?utf-8?B?R0VyTVQ5eHdXZUhtNzNqdG5KZkhJbjNVaHdPYUVJdEJUTHZNZlBqeXE3SENz?=
 =?utf-8?B?K2pXMkx1VGdXNjVjUVNlNnBnNVlwc2lmRW4vdGM3UXcrbGNlalJlOXpSd2w0?=
 =?utf-8?B?d2MxWnAvejdBdWdOanF0N1VYY3VCdWptMzJFTU9jYkN3eHBPeSt1OVdwck1B?=
 =?utf-8?B?SkZ3UzV6elA4UGhXaXhzdW92WCt3eWJhV2JtR1NIZnhLYzZFMlhseFpVcHVz?=
 =?utf-8?B?ZE02OVVHRThhY2JoL016RlFBbWdSVU5IVFVNNTV6V2MxYlVxeXhxdEFzNyta?=
 =?utf-8?B?RnRGOTEzSEdpT29TR2pXcENtWE42UEl0VUxGWDdTT21lVWNjWDIvK0FjMnJM?=
 =?utf-8?B?bm1Yc3VuRVNQNlF1a25VWkVBcjdBTEswSHhmd3dsWnloTzYwQ1NJTTFubzFk?=
 =?utf-8?B?Vm5kTWd0MkJJc0piTUlOdVdmZUF0a1Rna051dTVnR2JqRFJ2dnBYYnN6M1hI?=
 =?utf-8?B?L1RiTjNQNUMwM0VrTk15ek5McSs3TkVYZEYwSExORFd1NEF2RUg5S1RpUWQw?=
 =?utf-8?B?WGZyUnhkVzdsUDJqWTUwa2NWWUM3MmQyZU9NeUFXSmZIRG9QeXZjb0NKYllW?=
 =?utf-8?B?Y1FIUEk1OWtjUUs3anV0WEFhell4TU9DdnpxemFKMzNCT1J4NkRLZysxZFVP?=
 =?utf-8?B?T000UVhsdHZNTDBnaWdhOCt5cDhnaTJLVVJubnluWXBHR2lISjFoMTladmUx?=
 =?utf-8?B?UDB3cmw5RGpuNkhqKy9uWkIzdEVGSnhYZ3JWYXprOEFxSWgrYXgvb1RKMi8r?=
 =?utf-8?B?Ti93TVh2WndPcDA2WUxlWjdIbVFQM1FGaVlhMUcycUV2QUhsSms0MEYyMmVz?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88F11612B21ADB4FB1382946F5D5DC2C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PJczZgoQZ5u9HSkdIdRmBkGC4YQ0RXOyJF/lBmtcu3I/K976exQgGgC7ZgD6ob43xnsy/rQ4JOaxHFzEO3ArU3mJJsTiqu4kZg9oOyODKwKIYk0azEvbhrHwhCed6LxzmTz+tEj0FaGGAk+5sUaz9wFYKOa0cVfsPSUJAe/rcJCYo1NhfVHWGUIAT6B22LHhTpIPuq2dky+IL1iSKhsfar9GqGHThhyqEHj5PElfn2Ed7atDID77nlY/DYYfc9Y0+LA3h/2nLB0m3TlMqNe7n1pdE6Ds/7h8GbaSThbljWYuVS7yXmbsSwORaNXlEnnnIT5phFCallXXOHYQ153NDN4+X74udW348qQEjHco0tEc1Rd+PmYbJ00hD5lLuurfZg/mYGiy2ox2EfvNMRTDiD982YgPpM9c+5XgauiLIF+K7Sz6wC3mUbi8ComHmYkYPU9rjb48BRF02GZh5v817hnLX8jlRgKQYyBPdUgct1FsBbTlczCwe5f2lmYihSkLDB9mrGF+2W0KTd+BRvojL+R4znA0Vwf+GWREFGAFZBhb8Ljos1sblV8At2vU+Vww4BLHtza6Zxjh/GQVKSAGgvcBhBKHAdOWJY2BLu0wY00aZy1DQHPQ8P3BOitsPW6E
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d26c0a1-dde9-4691-ec76-08dd30c2a1b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 15:31:05.1476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Ydu64S40RVn6Z7Uyf/TOUjvaenjQ4wyivFXqa8aEHM8dgWnqyIlgTM+OjmxNRlcUdhzx57IvcvaXsFUN6aMI9OumvRxIbRcVQolP/HAvYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7434

T24gMDkuMDEuMjUgMTY6MTUsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gRnJvbTogSm9o
YW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4gDQo+IFJBSUQg
c3RyaXBlLXRyZWUgaXMgYW4gaW5jb21wYXRpYmxlIGZlYXR1cmUgbm90IGEgcmVhZC1vbmx5IGNv
bXBhdGlibGUsIHNvDQo+IHNldCB0aGUgaW5jb21wYXQgZmxhZyBub3QgYSBjb21wYXRfcm8gb25l
IGluIHRoZSBzZWxmdGVzdCBjb2RlLg0KPiANCj4gU3Vic2VxdWVudCBjaGFuZ2VzIGluIGJ0cmZz
X2RlbGV0ZV9yYWlkX2V4dGVudCgpIHdpbGwgc3RhcnQgY2hlY2tpbmcgZm9yDQo+IHRoaXMgZmxh
Zy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1
bXNoaXJuQHdkYy5jb20+DQo+IC0tLQ0KPiAgIGZzL2J0cmZzL3Rlc3RzL3JhaWQtc3RyaXBlLXRy
ZWUtdGVzdHMuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9idHJmcy90ZXN0cy9yYWlkLXN0cmlw
ZS10cmVlLXRlc3RzLmMgYi9mcy9idHJmcy90ZXN0cy9yYWlkLXN0cmlwZS10cmVlLXRlc3RzLmMN
Cj4gaW5kZXggMzBmMTdlYjdiNmE4YTFkZmE5ZjY2ZWQ1NTA4ZGE0MmE3MGRiMWZhMy4uMmU4MDgz
ZjFkMGQxODRhMjMzMTdmYWNiYjU2NmVmOTQ5NjM5YThhNyAxMDA2NDQNCj4gLS0tIGEvZnMvYnRy
ZnMvdGVzdHMvcmFpZC1zdHJpcGUtdHJlZS10ZXN0cy5jDQo+ICsrKyBiL2ZzL2J0cmZzL3Rlc3Rz
L3JhaWQtc3RyaXBlLXRyZWUtdGVzdHMuYw0KPiBAQCAtNDc4LDcgKzQ3OCw3IEBAIHN0YXRpYyBp
bnQgcnVuX3Rlc3QodGVzdF9mdW5jX3QgdGVzdCwgdTMyIHNlY3RvcnNpemUsIHUzMiBub2Rlc2l6
ZSkNCj4gICAJCXJldCA9IFBUUl9FUlIocm9vdCk7DQo+ICAgCQlnb3RvIG91dDsNCj4gICAJfQ0K
PiAtCWJ0cmZzX3NldF9zdXBlcl9jb21wYXRfcm9fZmxhZ3Mocm9vdC0+ZnNfaW5mby0+c3VwZXJf
Y29weSwNCj4gKwlidHJmc19zZXRfc3VwZXJfaW5jb21wYXRfZmxhZ3Mocm9vdC0+ZnNfaW5mby0+
c3VwZXJfY29weSwNCj4gICAJCQkJCUJUUkZTX0ZFQVRVUkVfSU5DT01QQVRfUkFJRF9TVFJJUEVf
VFJFRSk7DQoNCkFzIHBlciB0aGUgb3RoZXIgdGhyZWFkLCB0aGF0IG5lZWRzIHRvIGJlOg0KDQor
CWJ0cmZzX3NldF9mc19pbmNvbXBhdChyb290LT5mc19pbmZvLCBSQUlEX1NUUklQRV9UUkVFKTsN
Cg==

