Return-Path: <linux-btrfs+bounces-4291-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FA58A617D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 05:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985861F2104B
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 03:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861341804A;
	Tue, 16 Apr 2024 03:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aeXCAvkC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h/20i5Og"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B647112B7F
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 03:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237511; cv=fail; b=Uo5mYODhLmO62WwhEAcEa3DRQHu/tpmUfuB1AcViYmiy8YN6qTvKazLC/56/yFNNB8/BpMPjpus4tBS7Jz6l+HpvOoBjuPlSCOHm41QcGiNpSZuBVh1NVlfy8TdfkfHkeJ6TzfQATjvUYMiqc3vauA2NbebIt7J6J5doxXmzQgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237511; c=relaxed/simple;
	bh=zg3DUBASheTXZEsmwTude8qRFeqBuCJPhyNi6yE2dZM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sdz+IzwhoIHnJo3Gb92Tump9sf92Hv7ni9QBaSqFGSlEUbAqKVv4/aYURWgatX6uYX98klRIRUvCyN00NNkaD47LV0+w68qCc3R2LrZMGQGeivqIDoeMBLx5c2gBQ47Br0K5XnhjZQrjc+70LYb/3nOJfjcHoUZUAxuiyjsRtuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aeXCAvkC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h/20i5Og; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43G2n7up021690;
	Tue, 16 Apr 2024 03:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=2rHDaeBq4HClwx0rdnF3aV1q4ZT73ixoPEm9PrBZ0/A=;
 b=aeXCAvkClsdyy5J/QMdLbVgPlxfek17NfvkIZj6vu7sVVZ34XoVPluET0P3R2kauMcjv
 ohYlhZBvl6cUfIzRpBzizUeG3rrgQ/yJna2HEsWh10vYUPwS9opCqtmBmPj+6EvysBSa
 Q4X+SiNKX+OVh9IOHhG4uVJ7OsiRTRS+CwIAQoScayFm3Hcn7QqnOcysDMk/ikyO3ypi
 jfrB8YinEz42ZVZnVzY/v+ezwiru3bFfa//VmqvERZ3coJL3N2/iXxNRAUfk6ts8IUyB
 6KTcfO6tOspgwO+L4BCW0/FFktOR4Enz4DjGVJ+u/dd3pcOdxHa5eeEAMUU4xqgXNcRU VQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgffc96f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 03:18:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43G20FgW014246;
	Tue, 16 Apr 2024 03:18:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggcvf86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 03:18:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeOe7zKtPXAE8ZZb9YT/66MPagND8dHEA4aJA2VgOQMg1pYbMc+cpK4X9R2qXVF9jNxJeNiUABuOWAa1LZxECxEN2SoulJnl2cMvTCPppFQNsmvsx/ChqO6YumkHghym6GZtmkITPtnypdyZiJaf4hmW/8p1tPGfUNr/dIdf1oWglWVAIiCew3yp+CSnj4KWEUGIt/tyyrdsjtjMvDUgluHoSOElp+zMZWpW7ed8IFOthT8gLeoIKhe+JWQbbXLR/kjXb2TvKwMQe5mOb7C3Bw5j7fcfWskFOgKzn3VPzPd7Sjv2AAT0HDuP7C52J7t8P/CoqzqYD/220A5+O4MhaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rHDaeBq4HClwx0rdnF3aV1q4ZT73ixoPEm9PrBZ0/A=;
 b=R/HMBCA9kAnKC5mxnfzUuVO6KvsVWkX5NZx3o1haz2/AGgEj4z2HQkM1v5Pktg+sfPPuZrsg+E9OJm3utCpHll3esrK/3V5r7jBaQhpN3oSvd9GokWuLURozHaa2ZtHnNXpGjy/mpvxa3+hJ2zQY5B325pxfE8PJcdw6vo6J1e+nxoMuaaozeMIv0jxWRrhjSxOrkuKFwD3q/RApkcaWnJAZDxEeO8PiyXLdgif57VVBQn4HWlfXVhQ8M7c+UfV7kATlAheu+4BQ5O+wAsDNRBTq5NhQx22YT3Iws7HhI2cxXsqUmriZw8StcfVTuUIwQC7Q6oBHqU23qE8zA37cNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rHDaeBq4HClwx0rdnF3aV1q4ZT73ixoPEm9PrBZ0/A=;
 b=h/20i5OgEhoaPllZ+xYShN7w/ATk7awmdhmHzIrMJ7NoLOO48Sx5Kc1SkTy0j89OeDfI6dv99y1rtlWw/zYcaHJvpe8PPpbPpnb8ftpzeFfB+TWQff/Fi/z1clOhDMFVwmUEoh5DImdLVfNg4QvyUdPT4l2STAUgzzsJFQ2nauk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4599.namprd10.prod.outlook.com (2603:10b6:510:39::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 16 Apr
 2024 03:18:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 03:18:24 +0000
Message-ID: <d02581ec-658b-465d-9681-17039cfb46f3@oracle.com>
Date: Tue, 16 Apr 2024 11:18:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/29] btrfs: btrfs_write_marked_extents rename werr to
 ret err to ret2
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <cover.1710857863.git.anand.jain@oracle.com>
 <14bd267ea479d4c4d104966d4dae2d88ff403a99.1710857863.git.anand.jain@oracle.com>
 <49b3228a-469b-45af-879d-88e637dd1823@gmx.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <49b3228a-469b-45af-879d-88e637dd1823@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4599:EE_
X-MS-Office365-Filtering-Correlation-Id: 248b3226-3928-4a90-19d0-08dc5dc3e040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RNnNIbSiDRW3QZ/7nRxillXiKQ9JigP1kOE/BExnpGuonYYc7w/MOFtIW84T/3Wk27WWMO6LKhOIU3hwmYbnKwnAgTxQaU7FlElVmtvQvmE/5ex5Xfhl3jLd7mF6qFAuiMGLZ2qAHvMzKZQ35FWA0wwy2+TLdm55R1wht461T68eNakqIEd74+ifoWOrWqOeqSVzn/IK8BFqG9sB9SawRU72b8XGooRPtrbrhiLA9X8iCVPOyDerk5YkxHgNz6K5vc4WCSnq5cx/2iVKwQNBZibp4qUv7iPS1GJf/YeomoupY7WxL8rblwJTDUIf3HUZnycRk2nX8KOCqmZ6Y3xep0zyHKJwnDyVP4DBsNvRT1ymDWjSXYMbddHdPUBQ5JQ+wzL9DS1pxwS8NRCKTEOL+2pV2FtwBuSiXNY0ZI6c2EHIUaGKmO3Od9c9LOaS0qt3MFRdudjxMKLxJRvXFPvOYPTmo5Ef5fkVAjPMpyT5PwLzrz+HYeP5RQaxgYBf5sugmRwGoh3+p5+2BpGn/EKFoDkNYlKimOxfUkFlGy/m86A1NVSCPipGakIqYITVv3J9ezS5ms+0EZuuO77JwKhKoAfxbjfJlmxH3GdavtxM/ts=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RFNxVTY1RmV2WCtEbVIySFJheUk1bHNiN3FLUTh0bHMvZlRGVWlXUk9uM1Ay?=
 =?utf-8?B?NGdvVXNWL3RiK3l1NEVST09waHZqSnBXellTUUhJNTZCMTRrRFdFSFFxS0N2?=
 =?utf-8?B?bHBRU2JZVHBmM1hpYTdSNmd5UVRFbkFMQ2lEYURQY3BzVDJ0YTBMbktaMzZD?=
 =?utf-8?B?SCtpN0RUa1ZCNm1RSmkvN1RKWjhIbk1BL2EzaWl1NlRLY0VvZGxjelJsVndu?=
 =?utf-8?B?OGhKMnNQR3ZIWFg3MFE2VDFqQXNEMWQ4R2ZjOWlqYkZOU0txMndHZU1BRCtQ?=
 =?utf-8?B?RU5xSXU3THdleWJqbHk4MjZDVHp6RmMwWXV3U1llTDVsYnN1QW1WNloxNnVw?=
 =?utf-8?B?bTFXNzYvL1QyWm1QN1pnWVhadWg5dWlBWnlQb3dMTzZvTE4reXRIVHhzY2lj?=
 =?utf-8?B?aTBra01kUEFia3FQNm5Nb3hCUkNSVEVFMmFSRDZuTVg2ZnZXRm1Qa2NPWmZM?=
 =?utf-8?B?RDhwSDg2VWN4ZDFlSTlqOS9Gb1dPYlB1bHJSU3B6dXVReHJBVEg1YlNHSXJ0?=
 =?utf-8?B?UDRiS1hLd2lNQVBrUktEODJqUWZ1SHRwMm5qbldYZFl1bllIT3ZZSHpQK2NQ?=
 =?utf-8?B?ektFMW8ySnVLV1RoTWRkbi9tbVZqSHBNQWhQUFVBN3RzdDBYSXB6N1VjY3VV?=
 =?utf-8?B?dEZVcEcrZ2F0ajdUdlA5NjBwUjZMajBXU1pNbFQ1R3piM0hreUd2MTdjTm1U?=
 =?utf-8?B?Ri92UlBCWkthcXRXQUNTREFzWkQrSjRLKzlvUXgrZmFPKyswaTFJMWJ0blln?=
 =?utf-8?B?WmgzaWZZdE1pNXdoSkYya0dVQ1NDV000VGlIVm9zWUplOTJVdHFGVTdqVmFE?=
 =?utf-8?B?d0poSGQ1SEpuektmdW92Z1F4RXhwN3NTcy9CT0tsN1JYYjRKdHBTZ3Jlbm5v?=
 =?utf-8?B?QXUrVFVEd2tlZlJ0bXc5eDdaRUdnVWF4RzNsb2h1S01IZmFhZjdsZUR2bm9P?=
 =?utf-8?B?WXBERW95dG5Qdjgvekhmc2pkVUJ1dTM5WEh2YmV1R0FUWnlYYnpJbWY3b2Mz?=
 =?utf-8?B?Si9NT0t6ZlFFQ1Y3eHhMMnlpbG9MQVA0V05vK2ZWVHA0U3dBcmZReTU2eDFG?=
 =?utf-8?B?WEp3RDhVTkdiaFN0em85NzBmQ3NldHpkSVNPcHg0VzZjN2lPaVZ1eUt2T05L?=
 =?utf-8?B?TmlGdGtYdWt1MXcvN3RIV3dPZXAwcmRLbnA0WE9lOHlvU2p6WnErUEwzd1NN?=
 =?utf-8?B?V1l6Ujc5Zlk4VnBEeEtkZFRaSVlOUERmMmlITGM4b3c2RC9kTUhoYmNKNmc3?=
 =?utf-8?B?cEprWWhrakRiUTN2QmhyeXlxOTJtM1lneHczZHRnclpIWlZIUkdiS2IrSDZ0?=
 =?utf-8?B?RUtES0ZZSUJ2ZHEwSEdyTGowVmp3Qmh0Vm9leXRoTWg1YXhJRkdLaGtYUWcr?=
 =?utf-8?B?NTgxNm5aRjFjMmFzSGlvYjJtYWpUVXkrZWxMMXgxcGlPQkVlMHFPc3R4V2tM?=
 =?utf-8?B?SjlVUHZ1MkFWTG42N2tFbW1vZjBtbEd0UituYThvUlJVYStiNFJENEN3TjBR?=
 =?utf-8?B?VndqcGM5bzJYdXY5Z2NDNzhtZzUyeG83NTF6YWc3ZDRRd3M0WWJ4N0gwRlBq?=
 =?utf-8?B?aUdzWSsrY3Q1cDN4NE5JUHYybGtjS1kvVGV0NWQ2MSthTFl2UW5Xblg2b0Nv?=
 =?utf-8?B?YVFjWGZPQU1zZzN4ZXUrbjZTd0NxNHp2NXBvSGQ0Wk1BMTJoeHlrSnJxbjNR?=
 =?utf-8?B?aTVKb3N1a2xXWEN0Nmh0ZW45MWF0VkNIQkZDck1zekdTRGZuMHVVRXdhcXVF?=
 =?utf-8?B?aHpiU3hTTGhzOVB2V2hiVlZBSmd2b3piTkVUZGtVZ2FkelFDdjhIWmo5cGl3?=
 =?utf-8?B?bmdWdFJkTHM5RzF0N2ZsVVZhVHFJNTlmOHVtUzVnbHpqV3lmc2RmYndobGRN?=
 =?utf-8?B?elRuM3Z6Q2VOZ2I3NlhUQTVYYkhVelN4TFZhbFJiVURJYmIxNllMNFR3U0Z5?=
 =?utf-8?B?VjdGWGtVeEF3cEh5QjFxdVNvalhCcnN3U1N2YStLeVRzTjBMVStVVFZLN3Zr?=
 =?utf-8?B?WUZuVDdhcDRCTCs5RXFocVN0K1F4NERMQVhjVFh2QU1FWTV6ZnNRUnBBbnMx?=
 =?utf-8?B?OTNXTzUzWmsyNC9TZmFBTmRMSkpwWTVyZmY3Y0RRcXFSb1gvSFU2UThDYnBK?=
 =?utf-8?Q?tS7NdxaLupCG8Hc+VL6e+FXCy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vlrHMlDeVl8oVjCQWDvAbsogAVFyoTPdh6VcgFMG8U7wwnyNWe4W20wV/bvIG+y3dJPYB4pnFHZoxfKufh8n6/G3oB9K6GoBuldEwlzBS7sM0snQHACTaLWCzcxC9KlxNiPyTpSgupkNCS7huRyh55BiI9MdDLt9UWHgjoYmAqpIB0E7xAmF2b8kKYIAQRGGPqmTQhwJji0Rh2QmR0oG85WkHGWeC0hmEb+ifnYoxvfXLsnnqUFDO1BRKAYtgBWFCr0/EruZWNNO3yDJKSPZLhNs6WVgjJ5oUpqPWgj5pYvRY9pI9fOpYdPkMwRtDma+qunm0y5PXOEYHXriTHYGWGEY2NJgGalinVQaztBwz+HbGvqo+S1X6HMLjU33H8xBsssZ8KOuU0No2Z8vHtJShL2Ez4fDaan8Gfa8uoumVi5TMOAf5CQPl895+90I2oCnrhYpaGZ3jtr//DnCx08Bp3Q3rrWbOi5NEps0A/mSKKO0dxJyDi67OtHDccPyd6F+eac5jV2rEhjTUmtte1tBnuLjt40zMjJaVoIK65RbcA6yZhiOaytC5l1k1/GzkFral7h/yLxvlVSdfbGLnQ/P+MxRBW5lh+9n41jm2G5Z2S8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 248b3226-3928-4a90-19d0-08dc5dc3e040
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 03:18:24.4960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GC39hnjqRvKsbSLGpAnhygwxPBnAcofrOp/AjUDpN65HMWEVfdhGavoKM/DlcvfClZEq2vVoKZ7xo/zqD4caFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4599
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_02,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160020
X-Proofpoint-ORIG-GUID: 1y4Dj3kk7lXSQdDzlTUREdDz8yiOuW_J
X-Proofpoint-GUID: 1y4Dj3kk7lXSQdDzlTUREdDz8yiOuW_J

On 3/20/24 05:25, Qu Wenruo wrote:
> 
> 
> 在 2024/3/20 01:25, Anand Jain 写道:
>> Rename the function's local variable werr to ret and err to ret2, then
>> move ret2 to the local variable of the while loop. Drop the 
>> initialization
>> there since it's immediately assigned below.
> 
> I love the local return value inside the loop, but I still think we can
> do further improvement.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/transaction.c | 22 +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
>> index feffff91c6fe..167893457b58 100644
>> --- a/fs/btrfs/transaction.c
>> +++ b/fs/btrfs/transaction.c
>> @@ -1119,8 +1119,7 @@ int btrfs_end_transaction_throttle(struct 
>> btrfs_trans_handle *trans)
>>   int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
>>                      struct extent_io_tree *dirty_pages, int mark)
>>   {
>> -    int err = 0;
>> -    int werr = 0;
>> +    int ret = 0;
> 
> Can we rename it to something like global_ret or whatever can indicate
> that variable is our final result?


@ret is the actual function return variable and is consistent with doc:

  https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#code

Thanks, Anand

> 
> 
>>       struct address_space *mapping = fs_info->btree_inode->i_mapping;
>>       struct extent_state *cached_state = NULL;
>>       u64 start = 0;
>> @@ -1128,9 +1127,10 @@ int btrfs_write_marked_extents(struct 
>> btrfs_fs_info *fs_info,
>>
>>       while (find_first_extent_bit(dirty_pages, start, &start, &end,
>>                        mark, &cached_state)) {
>> +        int ret2;
> 
> And @ret inside the loop.
> 
>>           bool wait_writeback = false;
>>
>> -        err = convert_extent_bit(dirty_pages, start, end,
>> +        ret2 = convert_extent_bit(dirty_pages, start, end,
>>                        EXTENT_NEED_WAIT,
>>                        mark, &cached_state);
>>           /*
>> @@ -1146,22 +1146,22 @@ int btrfs_write_marked_extents(struct 
>> btrfs_fs_info *fs_info,
>>            * We cleanup any entries left in the io tree when committing
>>            * the transaction (through extent_io_tree_release()).
>>            */
>> -        if (err == -ENOMEM) {
>> -            err = 0;
>> +        if (ret2 == -ENOMEM) {
>> +            ret2 = 0;
>>               wait_writeback = true;
>>           }
>> -        if (!err)
>> -            err = filemap_fdatawrite_range(mapping, start, end);
>> -        if (err)
>> -            werr = err;
>> +        if (!ret2)
>> +            ret2 = filemap_fdatawrite_range(mapping, start, end);
>> +        if (ret2)
>> +            ret = ret2;
>>           else if (wait_writeback)
>> -            werr = filemap_fdatawait_range(mapping, start, end);
>> +            ret = filemap_fdatawait_range(mapping, start, end);
> 
> This does not follow the regular update sequence, we always update the
> local one @ret2/@err, but here we directly update the @ret/@werr.
> 
> Just for the sake of consistency, can we only use @ret2 for all the
> functions calls?
> 
>>           free_extent_state(cached_state);
>>           cached_state = NULL;
>>           cond_resched();
>>           start = end + 1;
> 
> Another thing is, we can move most of the writeback code (aka code
> inside the loop) into a helper function, and make things much simpler at
> least for the caller.
> 
> {
>      int global_ret = 0;
> 
>         while (find_first_extent_bit(dirty_pages, start, &start, &end,
>                          mark, &cached_state)) {
>          int ret;
> 
>          ret = writeback_range();
>          if (ret < 0)
>              global_ret = ret;
>          cond_resched();
>          start = end + 1
>      }
>      return global_ret;
> }
> 
> Thanks,
> Qu
>>       }
>> -    return werr;
>> +    return ret;
>>   }
>>
>>   /*


