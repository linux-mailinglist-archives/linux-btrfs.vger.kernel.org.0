Return-Path: <linux-btrfs+bounces-9150-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F319AF2C1
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 21:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB841C21971
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 19:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CCE200BB6;
	Thu, 24 Oct 2024 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AUi5NMcg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hTdfQF8Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D09F1FF02C;
	Thu, 24 Oct 2024 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799048; cv=fail; b=Hj8SFw11mwNuRapZoLwk9mwvoCS1Kcj3D9WLIVEiHs6CjzxLPbZEpF35vK1S+saSjcp0O6uJvJ5erlkoKSiwe2gZbTlV1VnL69aOUjCKO+19y3ShWls42UbuCztppiyoaJhPuARXeVQrACAofuDv3dKrSifepUByCfB6hLOMxfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799048; c=relaxed/simple;
	bh=C0eX0ESB8GjOBy30a3yxIYoKbEeLGAYIc6725LPrO8Q=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q//nbAAEp0AKShR53XYPquVMGOng7mZgl9lkzZShUMhV9aPiUT36jV4CUlalG8ANnrCvydjm5ziT4sDc6knbErXjfuYcEO8m9htJTX29TPLOP5JtBtglj4yKOtsC5Q5lmiZN2p3sSuQKOqvsZ0wHOh2zOoPDp3cajFsAJ8gaIfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AUi5NMcg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hTdfQF8Y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OHmZdq014321;
	Thu, 24 Oct 2024 19:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=c16z3tr5zBhJl0QX+uhtRFeQpMctt6SsKMo1Oa4gyG0=; b=
	AUi5NMcgZGQONtytNf+1EIHDEzhOJvutzHzTeqb0Q6UXJOGZcDbHYEvDh1uZOGUX
	bMMFCuye26a8wCWA61Zk5N/LpDqZKST66zNmxgAlVYOqZ1kIL8N+xdFOsoEJTycQ
	6F0GikrLZw22y9/b582PNSEmTD2W81rfsI4hiidEAYi3XV6D6BW4z3enLmWl5LR4
	j06JtmFHZPRUajgKpQQ4xWlvYLsdg0DgHq5dE0/YQrG6DXDf+vuimEnyckYuMGvH
	xFB00KeZSJRH2cFeoYMd6PTlUQalHeI+Gx3K0qDQElaHbri2nKIfFWQJorj6GLIU
	hOWZ11LB9ul8cS7gV6sOVw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c545bmvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 19:44:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49OJ2OK5030883;
	Thu, 24 Oct 2024 19:44:02 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh3e4vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 19:44:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCC+IYlCS7ySB8IjaGv8QESgcbQD0kPcU+8xUXpT90XQg0F5R66vEVDHMfeh1S2UVcfYyfqHIS0pIQPMcfn75yZeUdv9XmN0KPGo4FqfdicTWfLmabcPsTb43uS1/Fh8POQERqyyB9+AIYrbqG0/RVsmcb81jtIFHMSkHv3h8Hl8BxWGBDsJzaTr/aRmtxYk3pUGuBbCHGOSrof7Q0MlCHrnjRbTaFNCywa9OPbXriKXRNfXxPeRcIeQlG8ScHsBLUi0TKQ0NtLsnGbmoqKvlgOU6u5Qyx2p9llldXqRh5vjA7xg/1Exhu0b6+Pg4V3tWJ2T6HxqOlQU4OYDsrrXig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c16z3tr5zBhJl0QX+uhtRFeQpMctt6SsKMo1Oa4gyG0=;
 b=RWEYa/sqqJe7eVHlSUSEUFBu4AnpJOfOKNOjYKSKz3X1cI4T9jIpEUD+ndvw0kAG4ZxckmIpG4sf8RWrxB4o8XwgwO7u1JdcTlBstlcoJA+rCV6YZsmaw/9nl/roEoaMgX3rjP5kYA3of+NkMq0K1qKSQVLv5vsfqCfJL75gWLDXenrZ/vpv+xAIvZqSnMNk3HY0nycMDJSDglBkyDBtTU1AJ2dzSSIJi9ZfcWF53kdMya4pMSRwqpP1iFv2Iykck9FRnxbP6OLS0qUh3N7RSwliw3xxURyfgy/XdVxDM7qzrwYP6/UFFVEo9NUW86R+aPh2DT6hXkTh40r+/gFbpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c16z3tr5zBhJl0QX+uhtRFeQpMctt6SsKMo1Oa4gyG0=;
 b=hTdfQF8YFPggZRHsIYy3hqjZ67JDmdrhsKATR6t84vnaHzZmWkV04hzXhSVqTRvJhqdUjeQzWEiqmU3UddR8AHWm8V21Wy6fP3Z4rilWnRWRgW8WBk52vFI03q5FuXHSzLZK0MIYHb8n4m9I5XLltL7mpeTJTbaSpvIjLsWm6hE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7149.namprd10.prod.outlook.com (2603:10b6:8:dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Thu, 24 Oct
 2024 19:44:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 19:44:00 +0000
Message-ID: <9d4ebb7f-82e8-462a-a9d1-93574f8032d7@oracle.com>
Date: Fri, 25 Oct 2024 03:43:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/330: enable the test case for both new and
 old APIs
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <65378a46dd8e00ddc6a485335a5ac43cfe7aba3b.1729764240.git.wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <65378a46dd8e00ddc6a485335a5ac43cfe7aba3b.1729764240.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ff95bf-8de1-4dd5-9991-08dcf4643431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clRDTUYzeEpoUnJpOXBDU01NV2hndTBuaGttRHJwRXVNeXM0WC9SVFFJdGlo?=
 =?utf-8?B?YlJRS3prR2R0NEM1bGVTRmNJWW1DSUc1dEYwSGZrOUxzM3pyY21UV1psVldS?=
 =?utf-8?B?and1c1lCRk52aXZwZm1wY2JlU2hRMjFWNG56M25OSUdCMHZ1MUdGN3huSVJ3?=
 =?utf-8?B?NHpvMUtKTUNlNyt6ZzlTUDdUSGVMRE9mNjltTDNhRXkrRUJWN1VxSEEwSnhx?=
 =?utf-8?B?NHhaTWdxckVuekluUVQwanBYbFYrZCswdFYwelJVQUpoRzFBZjdzbzV2cEtU?=
 =?utf-8?B?QkFRQ3hTOGJRNURkNG54TG5Cblo0eXIwREFIMmVmVWF0RjlsYjhHM0Rza1lW?=
 =?utf-8?B?MHZlWDRHM2JFcEg2SHdtbHFmdklrZDhIUk5haFRxb3FIenJ4TDJEejJsVDhw?=
 =?utf-8?B?K1J5K2NURzRoYjNscmVyQXVrUkkzRDBZTW5vdkxIWjVoWTRWVUZFcjdGNUR4?=
 =?utf-8?B?Nlk3YXFwd2MxMVZHN1QwS3NVVkNMZHNkclJTQjlGWU9BNWZQR3JtOFVmbkkw?=
 =?utf-8?B?NWpXQ3Z3UlFzQm41WDZ2NkRZdWQyMmdOSXlGTk1mWUVvTjV4a3M1Y3R3V0U1?=
 =?utf-8?B?Z1BzM3g2YTd1d3hPbkZVdkVLSDVqdGJyZllmalZWdkNpNGxLRmcvOERaM29s?=
 =?utf-8?B?Rk9aUjNqVzlPajQvZ1Z2RklaWkkwYmFvK0p6bk5CZmhJUUcxYm1uWnd2N0ZD?=
 =?utf-8?B?SFlMaVR6S2lUR3Y2MU05MFJaaEdLT0M4YVA4TlNMNHhjcmVQRFpVK2VYdFhQ?=
 =?utf-8?B?aHZhR1BFYi9XdGVhUHZUYTlOdjF5SUtHMGZya21EazBlY3pFRHZGbmU1V1gv?=
 =?utf-8?B?M2lZSlBkejJXanBwVUlBM2RUTmYzczBMTnprc1pwQWp6cnRNSG9mYkhNamgz?=
 =?utf-8?B?T1BFZ1BVY2RObHgwUlEwNWhjN2NMdGZWOVdibUdmamk5RnBYaXU5QWlDUU9x?=
 =?utf-8?B?MHlqOTRDcUoxUGcwNGtyUGZQRkhnS09lVjJvUmIyOUlLeUJYSXkvZVVjdmpw?=
 =?utf-8?B?cFRBa3YyRE9peHVsMzIvZE4wa3gvZkU3UFlTaWJMMG16dEdPc3YyRCtOM1FI?=
 =?utf-8?B?STl4L3NTMk1EUWdsT2Exa3JiYm1WeHZCQmlQa2RpVG5FUnVJeWhXR2NwTWZM?=
 =?utf-8?B?WFVEbk0rOUpQWXBub1g1RzdlZUxGYXROb1pDbFptNVFLOW1RK1dWajc1YVBn?=
 =?utf-8?B?YU5jSmRSTmNGbE16bS9jZzUrSTE5bjM2Nno2OVdQTG82aXVqRkNOOXhpSW00?=
 =?utf-8?B?dGk0eWpJZjhIL1pFeHNiaTZPemZTTU5WVGZicWp1ajR5UlBlc3UvSWZycXBM?=
 =?utf-8?B?OUQzYzFUMnJna0JUTE1MWnFvZDhQMFhDYnMrbHBPWWlLWDJBOTJyd2JxUGNE?=
 =?utf-8?B?czlxbzlhTy9XTG0wRitJcE14U2pTclJjZktzUU5HVnEvMkxaTStpU0Z0RGdX?=
 =?utf-8?B?K09Ua3ZYZUJaUXFrcEdsMmQ1Q3BXUDBkNVo1Y3VYSllRK2FLOXFsZUVKSHN5?=
 =?utf-8?B?SHQxWnE1bkkxY1RDVWNrOEpaMkREeTkzU0RLTE10eDBxbkVzb29RYmd0SzVE?=
 =?utf-8?B?TXF4N1pvV2w4cjJLODRKSGpGMTFHODdBM1NhQUxhSVRQWnVWV1cyMnREVnNl?=
 =?utf-8?B?TDFJQ0FvSmtqc1laTjBkUTRrL2JLYTNOeFdsaGdreFgvUHVBSjg0MlFoZmZs?=
 =?utf-8?B?OXRVRmtIVTZWc0Y0QWJrYVhjUjg4dm9laFJ3QmduT3VHc2ZxZ1Y4bVNaZTE3?=
 =?utf-8?Q?8cdz87BXI2HxBekRID5atHzkzBOqVyjmWoEJwoI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2RWUDY1OUxaQURLYXdOWkYrZkxCblNHd1RtalFMeGt6M3JvbGQ0d29hMUpO?=
 =?utf-8?B?LzYrY1EzOW9LMjIrM1poelI0emVFUDRJazZXcFcvTng2VTJ1V1kxMDBFR1BG?=
 =?utf-8?B?Zk9JMCt0YTRMeTdiS3Q5MThPdEtXTzNDbDR2bktzMkg2blNxa0VqVnIwNGFm?=
 =?utf-8?B?bjVYOWJETnpwck1IWWoreWQwbzlpbEhhZVZEKzNkS0k2SkQraG82WFgycnZs?=
 =?utf-8?B?dVpLRXFPNzdzcFV2eUY0ZUVNSks4SldkU093S29rODFRS3FrMlhhWlFrM1Nj?=
 =?utf-8?B?YlFoRVRDcU1QL2ZzWHdkWDkrOHhrcGZuK1VuNmxYUzZRdTZIMUZZZ0hiaEU4?=
 =?utf-8?B?N1VCSkx0UjVGcElEUDl5Uy9WV3g2eUFEUTNuZjQ1NW5YQWNGTWsxQ2VReG03?=
 =?utf-8?B?U0MwbXhuelZib3d0WjFTdzdiYUtYd3Fjd1ErSFBhYVhjeXZhZnhjV2wvVnRt?=
 =?utf-8?B?bTVMaUlQL09MLzFTSklmM05DcmpqU2lqU2w0TXE0VWFONU9paFh4T0RlQmpZ?=
 =?utf-8?B?TlZZVkdwOUxSQVdYRVFsT3pZcC9abFkxazRRUDBrTzFFZlBwcEJ2TjVFYXZ2?=
 =?utf-8?B?YkJKNkJtY0tEbHV4YWdqa044eUk1L0VCUjF5T2tHZFNGOTdTOHhJWmUvZEVP?=
 =?utf-8?B?RkduNjlYNkViL0NkZkxMUlpuci9xeWhxdW50R3M4cTVERW1WMkxqOEt3VFF3?=
 =?utf-8?B?Nm1tNHN5RUR4eFplVkt3VTJhd3RMaUgxdGFvRkRVcCtjRHRiQUdzZjJnK3dY?=
 =?utf-8?B?OEtlazNiK1NlQXJrVGNIRFRwTXdQMXI4TUQ0ODdSdzV3b3BGM1FhVW1JS0Z5?=
 =?utf-8?B?Z1J2alhpWFRGTGI3WjJGL3I0WUphcU43cDVncmJTTUZVeS9nTVRTVnlWSmNZ?=
 =?utf-8?B?UFY1QkY3eVE2N0s5cXJBWnNkR1pyZ3dhYTUxQ2VuNnBpbG80bm9KTjQ0Ty9B?=
 =?utf-8?B?K3czcFJWaGJCaVRCR0l4WEx4S1czVGVLZm5hbkRqajlsd3lFclZIeUdtRTZh?=
 =?utf-8?B?SmNxbE9tUExrN3pHTWFtMjY4TGN0cWZFTE1meThwTEpZb29aQVM4blJSZlhp?=
 =?utf-8?B?OUw3Nmh1eWhScHZ4MXU3N0VCZndxZktSUFQ4NThNWnBGM0JXK1NKUExtU3ZV?=
 =?utf-8?B?U3ZIZFNmZHJYNEZkTlZ6WXZkd2ZpeWdNZW1WbkxKcWN1QnJaek9PWkJ6Vjdo?=
 =?utf-8?B?bVVvUGVtY3dOTVg5Vm5aSDJid1N1WnV4TytaeGhjZWhMWWk1TWpwTXYxZERz?=
 =?utf-8?B?akxiV1RaSEh5RFI5SVVoRGIwbkhDY3dtbTZXQTl4aFg3eG5nbjhUS09mZFB4?=
 =?utf-8?B?ZGtTMkZ4QU9XV3ljQWJsNUdpT2IydGlsbnF1OEhIc0hINGU3Z3ZpK0V1L0VW?=
 =?utf-8?B?bHIzTXpJTVJIcHZSN28zdzVTMCtYSmJwcGJHa1FEa3VIYnhYdE55Q1VON3Mx?=
 =?utf-8?B?OExDMDZVdHIvVlIxSnZ5c29qVkVxSWdmMGpvc3c4QmhnWXNjaXRrQ1JwUi9X?=
 =?utf-8?B?L0dabTJERzZxblpodjhObnZCTmk1c0JSTTdLVzdDM08vUis4ZTUzV2Q5bW1P?=
 =?utf-8?B?N0grellwOUJvRjV4QjEzK2F1MENSQlBnNXgwcHJmd3BBOWxCK0xxYmdDNTBB?=
 =?utf-8?B?TGMvZk1CZVo2a095TWk4anNFS3FzaEdxNDFIcXFVSWtFMkJwMTZXK21nY3N5?=
 =?utf-8?B?Z1FSdXhGZjNsOHkzalB4dFE1TEE3ekVCWHB3cGVQQlRhdDNGY2tKckFVcjds?=
 =?utf-8?B?UEtzNGlkMno0WDJCRTRTNEE2SUlDY1hxMnJDamhnWHZGNC8rbWFzNnRETHpx?=
 =?utf-8?B?THNyQ2kvdEc2WGUxR1kwbnkyeFZRVkdsNit4UDRQVkFYQk5IVFAyRVlxcHJX?=
 =?utf-8?B?MzA1TTVSS1RpSDVlcnVTZ0gzeFc3bVdubnRyaWlBR1I4V04reUVjeDdkRis3?=
 =?utf-8?B?dm1sOWR6K3BGNkdXVmRZTEpNcXVwTTFnVUY1Y1lHdWk4bm1GTWs2b0gxZlBV?=
 =?utf-8?B?dDlNOHpXcGZIQkNBSGFhLy9vc2gwYS9oTVhsY1FDODMxeUNMUnlXQ0k4MFBM?=
 =?utf-8?B?Z29kMHIxNXNHbzM5cnhHbnJXclNTb0VsSEpIa1BFN1VhYTlYYlRKTzBDQ1hY?=
 =?utf-8?Q?CUYe+ofyX51Ejd1gXpiPzoXcS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gZojP138BiQ7wXrxKZQV7AV1+WyUl4fRlxKlB8qmISB3BEJILRJikwkMdGMoNMKDEGbKXE8JS6NifTaj+DrLquBcb9/HvZw0C+xauRXPvpEN2SYZ+PaLuVfEH9DTE3Cgtlge7QMvFy4cmvMZSo5VxvqvqCnZczjUIEbSDfLJTEi9F25qzJnmyJEktYEe1Ts0Gzlyw5xhh9Ryi457A3GS9dDBZvvXFbI3Gl8AeVNCwL599zZzQ7U2+WB7huliAkSepiIQwY/z/yziZJ0ockE+zjBcxaTDr9C9iVDrJ2NK+R8D7fuv67VLzE8p7Ct2MrjNXKAkp/Cp1czYWOM7jokhHCBB+6/UnZZYVzyXTyI8lsbfakCJh1sBTPH0oersScAVhdYxHyPYjqq5YqYdv/SdTY06unz+LAat9ZXR6KxznzBmFSwjaVzHyVduigaRxVuMzRLRbdgtw97Z2Ck9eFBdJsxxbr/6JACc7PQ89vhRkmQKH/xvq9O3Zmo80ihXjJzko19fMOkXow/6x41z3poaqPoVgXmkyYWa9nPGopkJYz55utk0flSjmvXr+oZu7UIl1WI0pW8kPLb0GLKUqiCb1dCzaqs6cciBbQSyPs5iLPs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ff95bf-8de1-4dd5-9991-08dcf4643431
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 19:43:59.9944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMkixu3qfuvfnMBwbhYsHDCk4pqt7S2L5kmBjjQYHt8Lji2tM2pFbUon48xKBI3Y9EE81Q1b+6vg9csZpq/Flg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_18,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410240161
X-Proofpoint-ORIG-GUID: 7P-C6tfrlY9RLlrN_hH8UgmpBQAHTTqi
X-Proofpoint-GUID: 7P-C6tfrlY9RLlrN_hH8UgmpBQAHTTqi

On 24/10/24 18:05, Qu Wenruo wrote:
> [BUG]
> If the mount tool is utilizing the new fs-based API
> (e.g. util-linux 2.40.2 from Archlinux), btrfs' per-subvolume RO/RW mount
> is broken again:
> 
>    # mount -o subvol=subv1,ro /dev/test/scratch1 /mnt/test
>    # mount -o rw,subvol=subv2 /dev/test/scratch1  /mnt/scratch
>    # mount | grep mnt
>    /dev/mapper/test-scratch1 on /mnt/test type btrfs (ro,relatime,discard=async,space_cache=v2,subvolid=256,subvol=/subv1)
>    /dev/mapper/test-scratch1 on /mnt/scratch type btrfs (ro,relatime,discard=async,space_cache=v2,subvolid=257,subvol=/subv2)
>    # touch /mnt/scratch/foobar
>    touch: cannot touch '/mnt/scratch/foobar': Read-only file system
> 
> [CAUSE]
> Btrfs has an extra remount hack to handle above case, which will
> re-configure the super block to be RW on the first RW mount.
> 
> The initial promise is, the new fd-based API will not set ro FLAG, but
> only MOUNT_ATTR_RDONLY, so that btrfs will skip the remount hack for new
> API based mount request.
> 
> However it's not the case, the first RO subvolume mount will set ro flag
> at fsconfig(), and also set MOUNT_ATTR_RDONLY attribute for the mount
> point:
> 
>    # strace  mount -o subvol=subv1,ro /dev/test/scratch1 /mnt/test/
>    ...
>    fsconfig(3, FSCONFIG_SET_STRING, "source", "/dev/mapper/test-scratch1", 0) = 0
>    fsconfig(3, FSCONFIG_SET_STRING, "subvol", "subv1", 0) = 0
>    fsconfig(3, FSCONFIG_SET_FLAG, "ro", NULL, 0) = 0
>    fsconfig(3, FSCONFIG_CMD_CREATE, NULL, NULL, 0) = 0
>    fsmount(3, FSMOUNT_CLOEXEC, 0)          = 4
>    mount_setattr(4, "", AT_EMPTY_PATH, {attr_set=MOUNT_ATTR_RDONLY, attr_clr=0, propagation=0 /* MS_??? */, userns_fd=0}, 32) = 0
>    move_mount(4, "", AT_FDCWD, "/mnt/test", MOVE_MOUNT_F_EMPTY_PATH) = 0
> 
> This will result exactly the same behavior,  no matter if it's the new
> API or not.
> 
> Furthermore we can even have corner cases like mounting the initial RO
> subvolume using the old API, then mount the RW subvolume using the new
> API.
> 
> So even using the new API, there is no guarantee to keep the
> per-subvolume RO/RW mount feature.
> We have to do the reconfigure anyway.
> 
> [FIX]
> The kernel fix is already submitted, but for the test case part, we
> should enable btrfs/330 for all mount tools, no matter the API it
> utilizes.
> 
> The only difference for the new API based mount is the new
> _fixed_by_kernel_commit call, to show the proper fix.
> 
> Now it can properly detects the broken feature.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/btrfs/330 | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/btrfs/330 b/tests/btrfs/330
> index 3545a116ecea..92cc498f2350 100755
> --- a/tests/btrfs/330
> +++ b/tests/btrfs/330
> @@ -17,10 +17,13 @@ _cleanup()
>   # Import common functions.
>   . ./common/filter.btrfs
>   
> -_require_scratch
> -
>   $MOUNT_PROG -V | grep -q 'fd-based-mount'
> -[ "$?" -eq 0 ] && _notrun "mount uses the new mount api"
> +if [ "$?" -eq 0 ]; then
> +	_fixed_by_kernel_commit xxxxxxxxxxxx \
> +		"btrfs: fix per-subvolume RO/RW flags with new mount API"
> +fi
> +
> +_require_scratch
>   
>   _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
>   _scratch_mount


Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx.
Anand


