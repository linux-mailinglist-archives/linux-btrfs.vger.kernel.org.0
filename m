Return-Path: <linux-btrfs+bounces-14943-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 044E1AE805E
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 12:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78294175B27
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 10:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03689270EA5;
	Wed, 25 Jun 2025 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JG4Hi8zV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zg2KcT3X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8282D1907
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848877; cv=fail; b=ZdMp5u3TrILEXtA44pih3eVVlYMwsE4hv4bAMTAm3/klrHHjTlFLKl2OWUam8rPPPsbuu/WJvMV1nd7r6xAd4o2odXdiHOB5Off8r2BJTBgcgQJGLm73wKZ9DUbWmWvjzMPq1rnPzLuTbl+QjcwtNHp/5d27k/4IOpvdhGKPXtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848877; c=relaxed/simple;
	bh=UJL3ZLI9aqrI5s8YWaPi5uYTsf7aerZ75lAY10xU8LQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=my72F/XwanIe1nMrpJq8yoUlWMpIEnfbf6Y9zuv5oWnHFdIWt3fAkoQytQNDESipzUgRkQQ7IcI1dPmuhIRBCeMZ0KarMo2CgU/+E+5asYcqL/gq7p5M+AdV1kK7Y1DyA+wKfAsDyEBc8W8AYDj7+5INTR5OlzlRdJuNVM9A4HU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=JG4Hi8zV; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=zg2KcT3X; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750848875; x=1782384875;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=UJL3ZLI9aqrI5s8YWaPi5uYTsf7aerZ75lAY10xU8LQ=;
  b=JG4Hi8zVAa+dt6h19mv5+m4FKX7TeSBOJ4rT3WlO2Ox6TdNUJfK0esK6
   9OJcZF/9tgosjmih9rA5oOibUxwfoWp6b9PRXipfhLTbkcBCtNx8ScTuW
   3VEUbix3LqvMjOLX5OcGIpHBDd8wA2kszpClGf8eN3jTrFhmu4fP0jWKR
   /p7Ag+SyvvAkWa59JRG7X7Gt4Qq3yfrAmBEOn2bAvsOB4r9MOXgsOhX+f
   ojqjx57hA2RGno9JAYgqjbyvDUfWKeTGMmvNxiSLn1GBcrm4SIdk5nqEW
   Uy3kxiIW3QcwNMePnUOwWx3z8faD4zrgWIL9kh41S2u+oTbbgwv9/EQSh
   A==;
X-CSE-ConnectionGUID: tXlS7rtbQve5LNCYVO7Agg==
X-CSE-MsgGUID: GGeJJpa1SMCmVZXGyNYAvA==
X-IronPort-AV: E=Sophos;i="6.16,264,1744041600"; 
   d="scan'208";a="87196434"
Received: from mail-bn8nam12on2063.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([40.107.237.63])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2025 18:54:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7ifcABPweD9exUAsT3h+eVMYR9y4Qnq4xpxcxL2N6PG0Bz7Naoa5RTNfTXRdfMba+ERBxF+KGZbj7zjo15rPLiEQDNYuVV4J28GUAn0ofyYN1jDAU99LSViIkTMDixHUzDKlfkX/8cBjPqQ6/7Uw/q7hSp68ne9nGthN4WvfKWrxkrQHnnUNtviJBORdlIn7OrUhsaT4rDxgUxV14BYn2sWlnIgqIgkN51znq3BkSvSS9lCdqKDrINrk7Lx0VPt1T3qTHnpQpndabNod8pQsiNE20lqplenahGUgdp5Jc2cSTxWM7+I11Spj6pDvvers8c0T6fVZtQiQL6wAs4zaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJL3ZLI9aqrI5s8YWaPi5uYTsf7aerZ75lAY10xU8LQ=;
 b=T0m2xD9XW99axbcARSLl8f8Hlfw0k9I29Lt+zVyuGpAfBBNQefxqIhC9NNGkqLRrhRiV/1tfOGz6P2oOLUhrQ5KL87R5vilc59dHNtrPJhZJmXzob5yD+I1ADy1hrwduoLx/1byEvxiDVNnqgjFRPC7+YfK3SID4gXlf0xTODDEsiZAWSV8hrrEWAUe5G5UndBiVXMlUcH14S4tlNxDLJ7eBBipFK95FeGk9nK2M45M4UNFSejb2o0QZImRk0iQCrodlVGd1uYNG/7USH02EQlW61VB8dzJANEB0UGBj+enj95UVztnOKAckAP+hHtJ5gXURBzSoPBK+l4ugMpAcZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJL3ZLI9aqrI5s8YWaPi5uYTsf7aerZ75lAY10xU8LQ=;
 b=zg2KcT3XrTujHMrKm/AxS21aPvCW2H09yzKf2utNw+XXlXEBVG1Lo7L/KhI+jcqOFCLgfOAJoMIHEZrKcnJti2+jeMX5QH+uZHUIXDx4KyY61AILnLdoKPp2ChjtS64QTDjYCnlGTIcXLG7PeAUBVMDt7QW1+S1v+w4MiYu/3v0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6806.namprd04.prod.outlook.com (2603:10b6:610:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.31; Wed, 25 Jun
 2025 10:54:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 10:54:27 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 08/12] btrfs: use btrfs inodes in btrfs_rmdir() to avoid
 so much usage of BTRFS_I()
Thread-Topic: [PATCH 08/12] btrfs: use btrfs inodes in btrfs_rmdir() to avoid
 so much usage of BTRFS_I()
Thread-Index: AQHb5RhQlnC3JA+jz02UOJlnJo9OYbQTtNgA
Date: Wed, 25 Jun 2025 10:54:27 +0000
Message-ID: <ef0c6bb1-a2e3-4cb9-b24e-1aaaedc7e6cf@wdc.com>
References: <cover.1750709410.git.fdmanana@suse.com>
 <461dd2e6771f1000bab3948e841c24be84b74966.1750709411.git.fdmanana@suse.com>
In-Reply-To:
 <461dd2e6771f1000bab3948e841c24be84b74966.1750709411.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6806:EE_
x-ms-office365-filtering-correlation-id: 18a36961-c1e2-4777-bec2-08ddb3d6a77e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VWdGTGFkN0lGQ0ZoWndJdUZwSFUxY2VMVTQ3QVhBNHVQQkdVaURlaHBBZ0JO?=
 =?utf-8?B?Y0RHcUREU2JhOE1vTVd3ZUIvcVJRS0IwMENCYVNBdzlBN1NvenlvTENLM01V?=
 =?utf-8?B?YlJTOERRb1RlL3ZhOVlHTFh0dTUwMGxjeWtia3hkY2UzTTJMOUtuT2liTGhw?=
 =?utf-8?B?cHN4eGVSNXhwU0RZVGhCQ3RGTmhZUEJ6SVRmU2dpbEVBUDNvb0N1L1dnSkkv?=
 =?utf-8?B?SjBZWFBIQXlOVHJVQzJVK1hmOUdSeU1Ga2pMeFd1emRhcnJBQnFqWVRpM2xS?=
 =?utf-8?B?RXAwZDhwVWV4QXhKRGg3UllWYWs4WlZ0cHFBSzlGN2x1T0tYNFoxaG1xWWdX?=
 =?utf-8?B?UXN5Rm8vb3MyUTlTNkRMWFhyY1BuemFJbStrdDNWeDBsT2ZLb3c5NndMZUhh?=
 =?utf-8?B?eHM2Vm9oUW10SWNrZDJuQ0tpZ0ZhUUtISnh0Mmw0OVpFK2YyRzlKSEZMVGFW?=
 =?utf-8?B?ckxTVExOYmEyVVFoOGtXL05Wd2FsckJmWlVmbGZyUG1sODJGU3hJQWVmK0VG?=
 =?utf-8?B?L056R2ZleUU2S0h1UFBvUGZUUXJMbHN6SWcxdDdPS1dYcjVpVjN6T3FRSWRj?=
 =?utf-8?B?R2ZPRm52ZlVEdGpEY0tZS25Bc2g0RWdwQVdZbVl1NkxUZm5McUgrMG9ocU9W?=
 =?utf-8?B?dnIzWGJGZENkdC9XQnczT2o2c3grTEZFeDE0ZDR6TTF6dXR3YVI0dmx5RzE2?=
 =?utf-8?B?VE1laGUxWUg1QnZUSlJJMnNDK0dyK2ZIYkp0TG9ocGJrY2pHWm9hdytvZG9h?=
 =?utf-8?B?UDhrTzluNjdGbE9HbXJuTms5QURkOGpSM0JWaTA4YzNheUpLTVVHTUZqNnBL?=
 =?utf-8?B?eFIvYjRJK1FqWXZjT2lGa2VQSUVwUjZ6eDRhTTlPNFJwVE1HQ1NTaUM2Nmgy?=
 =?utf-8?B?U21EeVN0UTdRNmI3SUFnbCtEZ2tZVkR2bTRNNE94Uk9HVy9Zcklvd1I4amM2?=
 =?utf-8?B?MXBjalQ1eWE0Q2RZZ3p2VVZCYzdac2E5bFZwLzNZdXJrbG9SSTh3eVk0ZTVE?=
 =?utf-8?B?ZnY5S3BJNXp3SWxiZjFwK0tyNXRod1V5bnY4R241cHhjM1lKaS83d1dNNHpT?=
 =?utf-8?B?TUY0ekhXdjBRU2thSitIS21FTVZkUS9rNmVZRTZrRkRiSllFNWYyNVlCUjBz?=
 =?utf-8?B?SDhFKy9Va0xOQy94ZHNZTGhMUE5JT2U0NG8xaTVwbXlCRXpwSFlXOXpSdDhG?=
 =?utf-8?B?c1lWR0lKc2dFamFsZVNhY1NxbzZxTDF1c3JJekg4SFo1cnVXR0h6NVRmRFlD?=
 =?utf-8?B?U3dGQ08rRXB5T0N2M1h0czljbVNhT24rTVJNc2t4dnpCQXF6OU11bUQyUitl?=
 =?utf-8?B?enp6bkxGTVRQRitQV01obklKY2RRWkRaVm9oYzlUOExHWXI2SHg4TjF0YTNV?=
 =?utf-8?B?QVZIK0tDOHpYbDdYcjhQUDRuM3VDQy9VRm1xNmZJWExYK1dMaVRETWovTUxN?=
 =?utf-8?B?RzJEYS9BQjNZNlBuc2ZrM2ZLNVVoTHZ6dDZveDhKY0wrSjIyd3FaTmZ6NFNL?=
 =?utf-8?B?ZnYrTmxlWXV1UjJVTnNTN3FyWGc5cHNSWFl1bERoMk1ZVFlNNUF4TmVSNGRU?=
 =?utf-8?B?WGxoMU9teE9CSERJZkMweXZLV3lHLzYwbFhQQTUwZzZsUTBBR3RVbEs3ZVJY?=
 =?utf-8?B?UTQxa0thcjRMYUxWYWpuSGJnd3ZnVFFWOC9iZjR1N0kzYWx4eDZTQmpwU2Jw?=
 =?utf-8?B?eEErWTcrMkZ1ZUFFYUZIYkN5dFRyUm1DdnJyTWtmY2JhakFuYWpkTEZpdUV5?=
 =?utf-8?B?SEFzUXVqOUdvazhXajYzb3ppdDRFR0JtdHR3VUtSS1EzNWl0T0dST3p5b3dp?=
 =?utf-8?B?VVVrdWVPVU9mNlJQUUN6bGxueWU4b0lSQnAxVmxMV1p3Q3VSbEZBT2tuYmtC?=
 =?utf-8?B?SEJQYWZPdG12bzNBVWhvMGJxNnZHVGJYK085VnEvR0pUZWpIZ3IrSnVtQWdi?=
 =?utf-8?B?TU9wTHJ2VmFuUTh0TWphcnNxS0JVK0x0R0Z5Yno1bWlnUVB2eWE2ajFBMFFv?=
 =?utf-8?Q?LIhlNepxdlu/amkYvMDuVRfdia2mBE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UGZkSkJtSzhLTHpnendGTFJCYzFyWmxxVW9jbTdZbmZNZVQxRk1nQ2ZjRGs1?=
 =?utf-8?B?WGtGNG5nSFJtQkhKTm1tS21kNFcvTUt1cW5WT25FUWYyL3VmMkdMMGozZi9P?=
 =?utf-8?B?aFFHaWl0WWhRVFhieGJXRysrMmdjcUVrZE9zeHlhRDdsektrZDM0ajI0Vzh0?=
 =?utf-8?B?cUppWWZVZk5ERW84d3VvaDJ0d3hTRU9uNXIrTnVzOUk1bzJBT0JOZDFKVTFK?=
 =?utf-8?B?S3BxUTVnQXNOZFVmNndmblRPNHU4c3RlT1Ficlh3Nnp3bCtjb2t0bzVsRGlH?=
 =?utf-8?B?OGVjaUhBL0k2SlNnYkNveGdTa3NhVEFDTEw4ck9NMzdwM1VXRHErZnhCc3JF?=
 =?utf-8?B?RFQreFlxKzBLMU9KUk5LVGVybjFOcklWNmhyWmdqSGdEY01MWEZIZ0lGd0J4?=
 =?utf-8?B?Tm9hMWpOVmR1NnZsQk8ydGpMSWhOdDNFYXlOc3hXLzB2cnJNUElmczdkbmND?=
 =?utf-8?B?T3l4dTF5dGtrTDFzU2x4akVuNUtGVjdnL2lWV3JLZTNEb0FmdE5KblhyTUNG?=
 =?utf-8?B?ME9sYUJLZndZU0s5d0svK09uVVJaUC93a3FDTHViODZzSFArYWNjcjlucHdZ?=
 =?utf-8?B?OWM3Y281N0tVMGg4U3k0WWwxamlHVTV5R0xJbXRjVU1kdmh2MWp5WjEvd0R2?=
 =?utf-8?B?SHZabmdOakNkMW9kZ084QWttZW0yelNHNUhyNWpUYXRGc2Zqc2FtMXRQRmJx?=
 =?utf-8?B?M1BCTXBLcHVjUVo2cVl6cVMrY05zNURObk1RYmFiOWZVRU16ZUlGMDNVV2RZ?=
 =?utf-8?B?Tlp3UXl3Y0RkRGw3eDJIc1BZcGcrVEF3TW9RRnZWa0RzY3pjTk1NdzNIOXB2?=
 =?utf-8?B?M09EY28rQm1MR3JNenpEMFUyNW5GMHg1SDViWkkxQThTN3h6OGpBK2FuMzhr?=
 =?utf-8?B?YStNdkgwV05lNDduUWlIMjhvSk5GZDFjNmVvU3R5Y0FZa2p3dmdlL1RKYkF0?=
 =?utf-8?B?TERybUUxQzRqT3dydGM0eUQ3dFpwNHZ3REtQcmZ1aDRXbDVvRWFFUTVHMlZY?=
 =?utf-8?B?QUtkSU1GQy9ab2QyRFNuMElTZXV2TlBteEo0bmFJV3lCYUF4ckxscVBLb0Jp?=
 =?utf-8?B?b2EyWUl0TU9xU0VGampRMXBMamRCN2dsdXo1Q3V3TEo5TXRBYS80cEx2cFFN?=
 =?utf-8?B?RHRNeVJhWlRDTU10ZUZ0cURRc1RSb2JCejd0Umd0WUVONWNQUDg4WXU0VmNm?=
 =?utf-8?B?Rk4vNitIMWMvWHRTb3ZETTVmZ0YvVmlmblRDUlI1YjNmQ29kNW0yK1NWaTRQ?=
 =?utf-8?B?UkJkYzdYbGZKdEF5SFVGSXNCaFV5NmFQMHpCdExFRktyVmRtZkQ0VGlKc1FZ?=
 =?utf-8?B?ZlFuMWRQQmVLY2EvZGV1UVFKc1RVb24wQzlZSWF5OGdwcFFnS1VkdHNqL3JU?=
 =?utf-8?B?Z2t0cFNCNVFBcURSaVVnUmNUaGhqWllFaU01VzdxOGVnb3FHTkQzelZUNDVO?=
 =?utf-8?B?SUVNa0k1VnNOQkx0NDZiNCtTRWVOUFc5K2liWFkzOWQxdFhDamJvaUdNZVp3?=
 =?utf-8?B?UzE0MlE4SFJkTzJiMkw2TTRNUXN2MktjN0pPVjdZRElEdklpUDNzN0s0bXdD?=
 =?utf-8?B?cVVRZnRPaEwzVTFRRkd6cFhSUTVjZmRLZis0YzRQSDYzRlpSdVVQK0lFdlhN?=
 =?utf-8?B?QU9EaWFmZFgwRWVNNHBraUVoTUZNdFRKckFNN0ZOMFYwbkFVZWY1RHNHZnVH?=
 =?utf-8?B?elorMUpxbXAwOHk3NHVJdjJlb2hFSE5teWk5bWxneElnOHU4Ylc0UGV5Rnpr?=
 =?utf-8?B?bFBNeCt2cDVlc2FTK1hsYklRakdmQ28rQW9pZ0VzemtDTUhMN2d1WWh6bFh5?=
 =?utf-8?B?NEo0Z2tHQnJwcG9NOGJzM1J1WVlYZ0dIYS9oMHowK2NyWXRLays0ZGQzMWwy?=
 =?utf-8?B?VG5KSGFRQjRyaEdCN1oxQzRiLy9GSnc1Wit6dlA1S0tackk5T2g2dU9tZndw?=
 =?utf-8?B?bnJXOGhIbkpaYzlUUGpjWDRWWnFrNVVwTS9GdjJYUklKZzlmOHo1b2dPeHI5?=
 =?utf-8?B?SElXVWZmeXYzRlhWM2ZVZDZjaEhwZUJaVTc1V2I4RXk5VGVINkxuSnYvdVZx?=
 =?utf-8?B?NDlRN0xSUUVOR2Y0cFNUbDMzWGNNeUJYbzI3djNwNUJEUVl3MmRqdytKZVlx?=
 =?utf-8?B?R0tSeTErV1ZDM2xzVUE2VzcwSS9Gb1QybEtTZElaRzE1ZjZRcjM3SE9jUW5O?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF75EE544156FA449475E01D2CE928DD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zhhxpgOt13q1PeU6G+iEGUd07ZlkUhR5uMgwpX88P464XzBDxdqLldoFLDq3OVeRKX2Y1f69JDqxW1T6nTx91RlQeU2od7Yq8MFuut0gsXsWyXqYFPVyh6Ss8YLYa6IKmp3HaFiV/s/pOa9fHknIYrdQA6OaxJDapAkHtK72noNfmbewY1arxZazQ0YyYM+B4+t0cn3T6/ZgJlziNWdCNA5I/52M6yDE1Ip7wqsEkms5TpzvxM1qKSlgwIVVlzYLrIrDqBnTFqNPnVmeg8OhM1LkSQ15mmN2ICVFP8HsZYavSsN8iAQjzPgID4SLfKbLm3h2Clt9SEq4p1jlhHSA+7BqmsJFZPtlFC33CynNzyQGh00QdHBUT+lzMRK//43KqAmcJrSzWFldmg/46nrcTxMkeZNgTTug/toGXcJMaCLaybwTnaEWbXOpNZ0SKblKdglKdosBROMmYILMVFphri7cF6sC889zXxdrJC2zKy5nVdtsN5/f0P6wBkMrmopEtJbQrKgbNGOGy4KELoNROm/tu+URv3RAUQh0BkNwrsKGS43ttC64IovEXyKR2cc1stQmD9WnEg7dot2tGoarl9KHXrvdmqo/kW/+R0RxfQVPrbXbQ3HoQN36N4+A9vfG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a36961-c1e2-4777-bec2-08ddb3d6a77e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 10:54:27.0881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Keqt4Qdid1UsiPSboSD0vBEw2AZzo+t+PrZvPNUw0HYiRthfim7k/M3HxYoIi+6Pe1QlbR0M5gI7iF2FU2k3dN4L18vklSM1T7fU49OOGJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6806

V2VsbCB0aGVyZSBnb2VzIG15IGNvbW1lbnQgZm9yIDcvMTIuDQoNClJldmlld2VkLWJ5OiBKb2hh
bm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0K

