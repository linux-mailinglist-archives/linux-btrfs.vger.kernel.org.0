Return-Path: <linux-btrfs+bounces-9029-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C1F9A6E8D
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 17:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12DB1B2322B
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2024 15:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6214B1C8FAE;
	Mon, 21 Oct 2024 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZbkSJErm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HYyeMjf1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6614B1C4603
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2024 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525503; cv=fail; b=h0NIh844pe0rIdTlyWOe/mK7/gaYYJei6AHTOTA/2aycZaOnR5oQNjdERLR220GnPw3tURj9GDSb8H3Jf2sq9dV86ZfmPeJGTb4Y4P3OV9NPyxabCXE/4zVUHMoM7qBhC/iH3S/Wsf7HVS/ebvR9Kgx3m3DZIOIaTjs0QFayM0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525503; c=relaxed/simple;
	bh=aRFURtqN92vW7hJu3XBHpcPikWcPP0LxBsd4JmTkF5A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SnXfC1rYJ5sA0Kou7Aa1lMVX900SPOWY4w3V5eHWSecxeJv8w4lmgLAwbWaTlWuNwQ2WS2vd6YGb4hxqscKGnAQb5FGGEU6K+mrcUg0ltzlRV+ZnnPv9raIn8YNNab/EjfqNICGP21IVffqGgf7y0muyhrcoV5cF8jx/l/JmYNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZbkSJErm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HYyeMjf1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LEtjZn009342;
	Mon, 21 Oct 2024 15:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lgjfNIm89Gjqi4iYxtgtdSoUP5EmsYOP9u2Fx3qm30A=; b=
	ZbkSJErmwQtf3W5e7DpmEfVEIQWIv0NFxp2F/3bdOBhiaTen4ejJyvKAl/dyk44s
	70J9QR31TBxTusf0Au8TbJjsoAJHZ54BlR4XT0medjliTS/r27Oti7eZ6VBYnNex
	OEQ8aV4kS/eQlfeVKvVTSVXONV6FpC+7lFLh0DLCGZLzMvjTOivahUuAOY2AzUrM
	HY2Y47PKbg2ntruRkIfMSqYVeoJwx5gW5QBg/0Hc6/cdcYStnI9TqZL58a+0ywnW
	ER5ndt7AiUOkbxB8aV6ij6Z5vawU9/dK+JF95RJ38zAdlDdLUJ5zLMmNunR8heto
	xAgZk+VRrW62ykw71ICi4Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkqts04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 15:44:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LEcKfs012298;
	Mon, 21 Oct 2024 15:44:49 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c37696x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 15:44:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1JXlTu5Ahkr83/mHnBAvXc+mqTXSeviJzprcE8LYxbsIIcuP2Q49KPA9ILyfE6HK8DkY1WwPJfiMRIKakqdKAmSa1SJgrliBUX86c6Dc6+CknJ/J8ATFS04ljy6189LUvWNzgoWmEuZJDA6L7I4MrbHvl4DJWx4EubkjIrz5a1AUVqiH/8MzM83xYMIHkT65/hwnKAhx4ibngYTI1O8OJkDNRJsVqBGXoq9QwbAs7kYcNfCrrGtfHk+Uw+O7e/W1ljhzQ6yXKtxcXSx4FJ38tkZCIXp/9Cc1N6+1jF7RThnpM5+RhyR+z2FoYMQ+WNk09Wwz+5aBw+oIH+ZdAPzRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgjfNIm89Gjqi4iYxtgtdSoUP5EmsYOP9u2Fx3qm30A=;
 b=stRcRrDJeRXbiy4u1Mg6OkMlVBLN9tQOYqttIok77CBA6X/0TDRBdPEWvjxRUcpgS7CRiJlE6d+n8w94QSRNr4ZzlbH+Q+ZzupJx7tvey9rv2Svfq5KphzVVvDzc3hzVVobJsJpG95qepmL36T8qVt9lUrwoMt0qiDJx7pTjDRr4tVbnyHyO/N/1W2FpjuhYxi2xW/Hn8Yp7Xw3EzHQZ1NMuCOvWMFSe7xLOK//x2KSP3B/YX8b3+yru6aF0W5IHQcyeCauvvF1+jQz32lLajLwyAqxB6nmxFzWcVx1w/QaWIYToZnB2NoXkeK7KWJFSolx+vaeL6BYNXjMAulfzGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgjfNIm89Gjqi4iYxtgtdSoUP5EmsYOP9u2Fx3qm30A=;
 b=HYyeMjf1UkoIzrNsIEtNPUG+31TVeO7rr7lEmFmv2+30f5birydOawoQCv/NpmhodXJV7qm/bZuHYAj3nxX0q26MSlKLXIhLMONDsWl0H8OnLy4gM7keIj6DFdXU5/X9y5t0436Vq4zBDvT7epBMpYsuPTvQJ0AiO7oX3v23K5U=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB6867.namprd10.prod.outlook.com (2603:10b6:208:433::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 15:44:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 15:44:46 +0000
Message-ID: <b38111e8-6b62-40a7-96b4-3f512c55c82d@oracle.com>
Date: Mon, 21 Oct 2024 23:44:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] raid1 balancing methods
To: waxhead@dirtcellar.net, linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe
References: <cover.1728608421.git.anand.jain@oracle.com>
 <09a3eabc-5e03-3ec9-d867-f86d4b40e2da@dirtcellar.net>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <09a3eabc-5e03-3ec9-d867-f86d4b40e2da@dirtcellar.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 70fd2ade-d7f7-4e4b-28ec-08dcf1e74a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkNDQ1JCWXRyQ0xNZ3I1cTV5c1ArbzNGLzVXNXUrK1BMUWRLVDRRQmxkWDJV?=
 =?utf-8?B?UnBHVGFDNm1WcVM1aWk0MU9XOXNYcDRUWitsVEFyTEY1ZFh6azUwRWh2VlpM?=
 =?utf-8?B?UnZkZmpnTG1DSmNwYTlETlVNbGpnSDIvMVhySUtkdGh2YW9kRExJYmVvQW1j?=
 =?utf-8?B?by9MOEhQa2NhWGdMclJKbytuWFVwWlYycU10SGlObmJCZmNieVJJVy8xK0Nq?=
 =?utf-8?B?OU9JbzlzWlJ3N2JVUnM4cVkyVHpZaWoxNmFUVXhveVQwbDQ3VUxOV1VWR2VK?=
 =?utf-8?B?Y3piL2VFR093VWFFQzE5ZVFDSW8ra0I4eERMeU94cFV6M3ZHbG5HbThRMnpw?=
 =?utf-8?B?dzNaY1lyS2hOMXhsYlU0eVVUa1JzSlNoTHlXUTZpRlhhOW5QZjIreEhiUVY2?=
 =?utf-8?B?SkwyTXRuem9OaWFhYUxqdjI4aURKdXkzVW82N1F3dVZrb2lqWU1qeU5uclNx?=
 =?utf-8?B?SkU2TkxEekxJZ1NvaWI2d2FrMEN6MzZpaUgzTzUzN08vS3YvTk5wUG1EV2ZB?=
 =?utf-8?B?VEVMWGpuQW1ydG5WTmNSUGFNOFRKa3hjYWRUaDI0U1F5Tm42ZVl2OFVwWiti?=
 =?utf-8?B?L25JdnN6eUZKQTByNlNuN3JnWkZNSHNPRHJNK2p3UlNTc2FOUit3akdvNDVE?=
 =?utf-8?B?d015OXhZeWJhTlJ3L1FXZ1V5RGh0bmxnNVRlOVUxTWZJTllkRE5tZEkycHQw?=
 =?utf-8?B?cHZqR3dNVVAwNmN5bC9pZXB5R0hXR2lyOSsxR1puYldlMi81cjZRVnVXSE1i?=
 =?utf-8?B?alpjL2hCNDQ0dGJ2S25ZK2UzVEJtYkVrTTZPUVlrdGJSYlJxRkdnaS9JTENu?=
 =?utf-8?B?dnF5RStNcnlPSVVOZGlJYSttVHMwT3F5cCt6c2xCQ1A4WGZXVkNCY2VLdy9q?=
 =?utf-8?B?SXRockh5R3g0UFgxbFI3WXFXR0hUMU51MlBmSWlvSCtCTklIWjJaNlBrT3Bz?=
 =?utf-8?B?VFNGR2drNE8rdncyekgrS1F3cUtqei92MFh6WDJyWHhpNGhmYzVaM0VlNkxI?=
 =?utf-8?B?Tkp2ZWFhZW4wOCtQU2ZXL3dWUkE5NzNWN2R5MXViVVU5UXIzUGNvRDZuZ1BL?=
 =?utf-8?B?S2J4TkNwWEJqZTdJQ3V6NjF6VEczT2lUTUdrZGp3MUNBNmZVNEpVWDlvdTVO?=
 =?utf-8?B?T21ZczJnaFlJRHVlWFkxNGdkS0hySkFXZkg3MkpYVGR5dUhoOVo0WlFNWk9w?=
 =?utf-8?B?NjlrYVYzem1xM0x5MWNqV2s5eEZqRExvVVdUK0JBZHhiR3g0WTNmT2hzME5H?=
 =?utf-8?B?d1J4S0JYeDVDUmtFNTByOXRyUmZ3VFppQ0xldk9mMDhWR1FFWTZGNCtma29D?=
 =?utf-8?B?TkxKVFZISnNMRUxmTHh3OEFBOS9Ndzd2RzFXdzUvd253YmE1UVRxRVgvbTEw?=
 =?utf-8?B?MStKdHJxZEI4akI0UHF0WEF6dWx3bTVpNUY3UmtuT3ZrMTRoN1dHOHVIMEpF?=
 =?utf-8?B?NFRwR2ROT3VJTUhzTGgvRzBkcWhqUk1aclBhUzUwSCtCbi83OTJqcXVBTE5U?=
 =?utf-8?B?SXdhcGlYOHBhcXpwQnVQckdtQ29QV3FHc1doYlBDekFoc3huOEZ2a2dNbUtX?=
 =?utf-8?B?QzhZUGVQbjBVVmVUVjVtbFRnMEpwaTR2aGY3UFpXSzV2NlEzczJhQnpyNzVH?=
 =?utf-8?B?clJkMnpkTHJuWUs2YytXSjFCbmJ3UVJDbGY0M2xERlgrblFaQzBEUDdvRWF3?=
 =?utf-8?B?WEZ1ZFZhelFvMGN2bzVBMTVLZ2lhWXM2eHlCSXVQNDh0UUxQM1lTMWh4b0xH?=
 =?utf-8?Q?kgKTGCgXxO2dU7U/XOHV3A7obmXjJOn+OuZAPyI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnovRkx4R1hPYnpha1pBblZZeVN4Z3p0ZGJUWjZodWxld29mUG5xTTdVbUN5?=
 =?utf-8?B?WUdleDA2NDlLZmR2R0JnM0NseWtCR2dUZFJVRDhaVkswd0x0ZTVVc2FDSFFL?=
 =?utf-8?B?aitwWUI3MHFYVW1RbVR4cVd3WVJaZEpEdWxZb1RpcFNLeTFiaXJpV0FRV0Fl?=
 =?utf-8?B?cnVJRVR2aE1uZGJpazRoamErSGtEZ1dORHRRanJuSXpFMm9CQlpiOVlqWUpG?=
 =?utf-8?B?TGhsUG53UE9EcE51dFJEK3pBM1VXb1JkMXdMV1FNZ2xPWXhDSTZ1Q1l5bGZU?=
 =?utf-8?B?cEJXTTFHUXltQlRESVBEVnVnQm5DQUFGNnBtUHBBNklYSnMrNE9pbzNZbWdH?=
 =?utf-8?B?dkxqR1loWFpISnN1U1ZiYVpzbStSTjFBeVB3NzlMQ0ZYUHVtZ09mTHloZWRZ?=
 =?utf-8?B?c0hsQnFUQ2JjSzdRZE83NUp3MWNQNFpnODVuUkk5SmdoSXZDZld5SUs4WmR0?=
 =?utf-8?B?NGs2WGtCd3RnMzQ2MlJkY1pDZENqSlY0bmd2MERteHQwd08zeTB3TkxtTVhp?=
 =?utf-8?B?VURXYkM1akxjL3NRV0FOOVZwVEcvSjVydkVlRUthZkhvMGN2L2RZR2U3K1li?=
 =?utf-8?B?amMrVTBzaTdvY0xzRDRZSWdxV1RPSHViL3djM0JwcFBYMVBkQ0doWjR6RTRC?=
 =?utf-8?B?elBrZmk1Z0JXZitUT3BGOHRwMDZOWlRBN3MwQmNjSk01UkJjbVI0dUV4UFg2?=
 =?utf-8?B?c3ltMW9MbGU4c2wveTVOa3J2dlRnN3dVK2xrdXJqUW04OWhoaW5lVW9mN3Er?=
 =?utf-8?B?ZDBSelZ6SFRWZ1BQUEtZRTZnZkE0RjVIbDFJSDI4eklJWmYrMm1LOEcwalFF?=
 =?utf-8?B?OE9jSkFKR2NXUG9IUnd1QUdKYnBldzNJQVpsVC9rbzd4emVqZWhxOEdzYm5P?=
 =?utf-8?B?eGxuUy96amNydjlKQlU1VnJIVFR3VjU1czQ5bEZuS2Q1NzVBWFBYOGJBUGJu?=
 =?utf-8?B?dTdOZTFRNTFNNWxERU1XeStqekxXTXR0Z1JyOFMrQlZPWFRESGtUR2Jub3l5?=
 =?utf-8?B?QnlobjNiM0JiWmpKaFNzVVdzLzRmL1dXM2RDUVVsSXd3bVRpRkU5RlFFZWMy?=
 =?utf-8?B?STN5NlhQWGxyZXBiTmc1aFM1cFgzMitTQmVSMnlOU3JtTWNpcGtwa0RuTWwy?=
 =?utf-8?B?UGE1ZWJqeVQ3MDU2Rzc3SjIvVmI1NUk0UGRseVpvT0F0Q0hrWDJOMEF2cEFD?=
 =?utf-8?B?QWtSY3ljOUpsbUlQcmxKTHpxREtYZHIxUGJHZjRHalRQQVZnNHdTMGZXNkl6?=
 =?utf-8?B?b1A0SHkwRGtUYTVXaUtaWmM5eG5FTndRcWdmaGxDR1Y5NjYrWk9CU3JQSUEz?=
 =?utf-8?B?TzYrTnpZaU9RcWk2RlpWK0NIUFk4aDE2TitJQm9nVXpPUmUyUVhhY0hIVmor?=
 =?utf-8?B?M1RDMTJSdGdlREhRMm9tK1I3N1FSVWxHaDFnWGh4eUwzWXNtTXVQK2w3b0lZ?=
 =?utf-8?B?Umc2ZEZHZldsNC92OU9QNENFam9RNGcwaEdNbStmZnFCVGtIa2FpZ0drVWdi?=
 =?utf-8?B?NXZwUEZmSmtNM2pub2JiTm90dGxyVjZxTHh0M0ZoUG01VXRlYlg5UUI3UGlt?=
 =?utf-8?B?TTM2Z0VhR0xuSEFjTTlxM2lHYXVvK1Q2OC9XNHQ4cEh6a3h2SnlkRXJyR2wz?=
 =?utf-8?B?Z2JwajBmMzNwVlFQM2NJZWt6K3c4ODgzSURpYzl3TjFEYkZGN0cvUktqQllj?=
 =?utf-8?B?WVdSZ3BaZVhxZlA5QnN0aDllQUpqbHFncTZ2NnRCai82ZWdzblF1S210OFdr?=
 =?utf-8?B?NmhOYmxDSE1VQlFkZlF6TmlLeXBISC9PbDkxWkpwZXhDU3lhUE5DclJSbVRG?=
 =?utf-8?B?UzNEdWZQTmZZV1I1Q09UY0NkdzhKWVVwVEIxajVRNml5SkF4QU5iNCtKU0JD?=
 =?utf-8?B?Zm5nMkczL1VTWmxqakZmb28rcVFLcnpnL2JyaUhITlJ4S3NjRDd2VVZMRCsw?=
 =?utf-8?B?WWpzZDJCcGNWWU1PaG14SkFvall0M1NQOTZtSEx3WVZwOW1VVldMaWZndkE4?=
 =?utf-8?B?cWtSVnQweXJLWlNoeWQ1TTFXcnhxbkhDVmdYQ0hJMEpDMThVUm5QWGtNN2JV?=
 =?utf-8?B?VVpKWmFicmh0bWhVTjJPWXZGK3l1d0JyOVBGZm5xbXZBWmVnaTNSY3RaZThw?=
 =?utf-8?Q?dGIYR+5vN+KQhmtUvc40Srngp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kSos4F+ZwVRfs87WIQWkW2IlNFKGyoT2YqDQHk93BIKDxyiEuKTBxvmdm1Z2gE4KODJTSw+9biXuNaZt/HCD5WvC1RJYawda02qzeb1VngUBfMOQ2oFwxRb1o5oQ+jn0qmFRhlpToi1wkjdL439zOb6Vj9F9jB+iDdGT6ttyOxLyQCMosw4uoop0179d/TjZoy60hVakqt5zbNidp1KbAjELYtDx8nTQC9IvIrda0UsaVzoFH37EUuoYtn/dojtgq45p7oAKfgakunv4XGuTskeb2OtMJUlqJfSNASax2wlQiAfhdSxjQaGThRirGjmQLpjrrCrSR+WKPOoC0OXzoDkG/aljNRrcGrsI5WM9y7YlcMnj0z6qvvtfLVGPzQCkvFsqS1YmJziggoG2w88aOOfJvR9WmetQevYpMp04uCLtIf2G5VU0oBn2GxSXCPllAEOGHl2NfMO+z8Zctyupxo8gI5urc67dmog6aeMIgr97SEEI8lY70cpzCUHdRRaF7SELWk8jPB+8jeyMgV5Z0j4yj09by2eGTvxV4Y6qxpo5f6tK+1NWMAYiF6wV+ssE/dDbVWqnrwZQpBYFiX+jUk838cPIm4X4X/PyU/VIwms=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fd2ade-d7f7-4e4b-28ec-08dcf1e74a0e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 15:44:46.5446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WrHHddg546w88I4yPOmHvKegq6hxhMASDFJjL1ycNpWSSUSlo0gJBvl2kGwnbb9aX8krwKmBtEcfaopKqQZCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6867
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_12,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410210112
X-Proofpoint-GUID: qAL04uDVx4dlwCgG4Z35QT7tBqIGPYYq
X-Proofpoint-ORIG-GUID: qAL04uDVx4dlwCgG4Z35QT7tBqIGPYYq



On 21/10/24 22:32, waxhead wrote:
> Anand Jain wrote:
>> v2:
>> 1. Move new features to CONFIG_BTRFS_EXPERIMENTAL instead of 
>> CONFIG_BTRFS_DEBUG.
>> 2. Correct the typo from %est_wait to %best_wait.
>> 3. Initialize %best_wait to U64_MAX and remove the check for 0.
>> 4. Implement rotation with a minimum contiguous read threshold before
>>     switching to the next stripe. Configure this, using:
>>
>>          echo rotation:[min_contiguous_read] > /sys/fs/btrfs/<uuid>/ 
>> read_policy
>>
>>     The default value is the sector size, and the min_contiguous_read
>>     value must be a multiple of the sector size.
>>
>> 5. Tested FIO random read/write and defrag compression workloads with
>>     min_contiguous_read set to sector size, 192k, and 256k.
>>
>>     RAID1 balancing method rotation is better for multi-process workloads
>>     such as fio and also single-process workload such as defragmentation.
> 
> With this functionality added, would it not also make sense to add a 
> RAID0/10 profile that limits the stripe width, so a stripe does not 
> spawn more than n disk (for example n=4).
> 
 > On systems with for example 24 disks in RAID10, a read may activate 
12 > disks at the same time which could easily saturate the bus.
> 
> Therefore if a storage profile that limits the number of devices a 
> stripe occupy existed, it seems like there might be posibillities for 
> RAID0/10 as well.
> 
> Note that as of writing this I believe that RAID0/10/5/6 make the stripe 
> as wide as the number of storage devices available for the filesystem. 
> If I am wrong about this please ignore my jabbering and move on.

That's correct. I previously attempted to come up with a fix using
the device grouping method. If there's a convincing and more generic
way to specify how the devices should be grouped, we could consider
that.

Thanks, Anand

