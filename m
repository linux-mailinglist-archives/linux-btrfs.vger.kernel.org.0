Return-Path: <linux-btrfs+bounces-387-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA9A7F9EEC
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Nov 2023 12:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6ABE2813E3
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Nov 2023 11:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4061A730;
	Mon, 27 Nov 2023 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fHyOTHVr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JTB2TM5f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36777101
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Nov 2023 03:48:47 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARBj9j3010640;
	Mon, 27 Nov 2023 11:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=NGoQbMibiSPIk3morxK6+6ksaDpnfS0iWqS7/IO26bw=;
 b=fHyOTHVrTis9FSY5ixJcNekgwrGupPZaynBvi+7fuYsinpSuVAVo6lKYzV7mNunGlofI
 QIGp2qZg9uYtzwtHfMRkkGK6d44XN6bdRnrgP5fRMgJzS/gkSkusFXMGCSR9ulT+u/qY
 bQKPJABwcEr5un1lE+IzjXt8XGutk70ELQayM5RFn4uWJuwJSKTjQCHaRc0uVdpi5AHa
 qEs50GrCSWcWwZHrG2pMADbqVlgr2/6Dw7v/DpSDcwe/wzelc9OLMxX43lS7ZbuV7xGG
 q5Dh1vbpZ+uz1s+JQ4kIfqYtKn4eI/pL5DxV06mXKxFHlzyXbtx34MmZoquDTmwexm8+ mg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7ucjrnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Nov 2023 11:48:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARAYx8S013476;
	Mon, 27 Nov 2023 11:48:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cax55g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Nov 2023 11:48:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMKdGZ7qi5O+3Xmo5L/Pr05rh4MKeufkIwG4zvfbA7Klg4928RDm+7uDJCSWAkJsyYdm5N5puUGxcNB5FEBdBXXmxaronWHBOHg3frrJ9ipQ1K9dJqZ7NcZWwNkSd4/3f0M6vIAW0WyowHqJ2HiHS82RwmJPQ60J/VIAKzp0PywISWdYyRBdEXStwxeyPx3uj/P6HZWWiijZ0qXNtUDqHrPqaVfRELdZ6Chb0aEssKZb0SA6xbinv3OpHRHdo0ZWQIP56/wbYAQ2MDmUbpgIgiReSUArPgCA03IwRploIkSCPSZW3nojBQesyqYHLIveykmO6Ylw6YOkM7zN4voetw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGoQbMibiSPIk3morxK6+6ksaDpnfS0iWqS7/IO26bw=;
 b=NYgXUJNgPmuzMuqj1zQx+i6vEWqGB2P0pmIc5iu0bW3/hLzenezQ5Q8UFdjAghKNPieH6w+PSPOFwqFiT6h8pniqeseZfFXIDwLGrqo3jHJnuh0eIFWgup3MMcdcAyWQ1gmTiF82uXOa1rNznK/cXmOwD2edkfEeNN31CA8gsVSssn5lCGMfkdqcEfEA7OTeAxJkXZyhx6axYy8tgnEE/fzugh3lLvtmpsYHrnlROYy+i3gxOaQY9iNNnsVHTzCS6mw4A3UfX/aChgHJ4RL8Q6ef6q5RTzBnr1LEa/xQ2JmB+qebyJ8y8jrZRT6uIclxJeiuRI/yUgaMSRo7iCbMuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGoQbMibiSPIk3morxK6+6ksaDpnfS0iWqS7/IO26bw=;
 b=JTB2TM5fWYao+5Txf2zwCctZocrrBN5F7oXjYNzr2PKBu/qREc4rRgkCRHElSzx/U5XNd6C7YfodPPA9sYZb+oLJ7B2tSzLCpMJ/8Soid6cBNQ/lWVv0nGhi4ACNNrE2ElePrm2yppmBaoPMZzQ/F+OofKbEbgh8g2sr4kwg3Mw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB4980.namprd10.prod.outlook.com (2603:10b6:208:334::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 11:48:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 11:48:39 +0000
Message-ID: <589d8650-26e8-4c0e-a602-bdb5ce427ed5@oracle.com>
Date: Mon, 27 Nov 2023 19:48:34 +0800
User-Agent: Mozilla Thunderbird
From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH RFC] btrfs: pick device with lowest devt for show_devname
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <85226cf68d7a72a034f0c0895b96b2557169755b.1698917826.git.anand.jain@oracle.com>
 <20231124161906.GE18929@twin.jikos.cz>
 <36171811-ed49-4427-a647-e052ec70faa0@oracle.com>
Content-Language: en-US
In-Reply-To: <36171811-ed49-4427-a647-e052ec70faa0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096::28) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB4980:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db98ea5-a05d-41f2-ebea-08dbef3ecc1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Rk1LHC3lL9lgjTvrSueogS9Ye1dhi0Xw8cF3A1dCLRUDnhZSQMNyGIklZ6FvXhbO/pIsKZjpThkc1y0y0s3CIqxgofsF6daBqOtjmCTERTOk+nVv7z+fO/Tj66dEz70tmwCqtMoYxnbmLKGTG8c/8+G6kN0G4kKeZ+MKbfGASn7XyLZ/+IE/G9epU2IRcrIpcPxjWFePPWDcQ1SmF2m11V3b3QnczARpqW4qd6ulnH8Yi2qZZaSWk+zX3AucxnaCw0CufQUH0DcRbHcgD4I58p4MLynSB/9NDSE8KtYBJt30hVEd3fmGbplQpEmNFWXCvGTs5eVHnuM7O7dVgBOjd+kHj/hSM6cNae3f0trWV2dr7XIK1Yy51NHZ/Hbh0JH7QTSjp6YkmsxGvittvpwdBnlJJgCAT2yEmg2a4VcTGDj9Am4R7Vus8ytAtsdFlnl0yLGK/GzKCecyO7dLVmhvEKOCzEjXOaD2qX7wgSqE3dj8ItbIJB0q1LW+WGN3CsH8ghDKQXUsyfhPEkuWiMCPIU1lf6UCadfY7H+YIlR5QNOPuewJHdA/3Hm5iDqKjcDqBDTgxZQ0RF6vJ2S7whte5TjHkxwUryH99N1Eg6t5pWROHYK+5f9xK4VUHeDw2us7SuFZ9vi64Jth9NvB5fmiUw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6666004)(8676002)(4326008)(8936002)(6512007)(31696002)(53546011)(6506007)(66476007)(66556008)(66946007)(6916009)(316002)(6486002)(478600001)(2906002)(36756003)(38100700002)(41300700001)(31686004)(86362001)(26005)(44832011)(2616005)(83380400001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WHpRTnJ1RitLZ3Rzb1FqUmliREljTThKVkErMk04V0NuODNpMTgzOXRhczF1?=
 =?utf-8?B?YjJySCtLRWdaeUg5VWI2S1NHazQ5RC9yUlRScndkd2t3SDRCRzR0ck5ydnUr?=
 =?utf-8?B?Mkh3UTAvTFJhZGcrMmJzNE15QzIrSC96MkplNUk1VC9CbWZYM3huQmM4R0Uv?=
 =?utf-8?B?ZmFoSHJYb2I1QUFoSlhKR3NTRS82aDBvYzZRTHVSa3EwM0pLbkpWeFR4aVBS?=
 =?utf-8?B?Z1oxcEh1c1c4aTJrQWkxRVJWWGh0dkxLdTFDcXUySnRCOC91VmxwTHVLZmdS?=
 =?utf-8?B?OUlIdENxOS95Q0FvRndkRWFJS1FWajRXcWd3WklkZmRoY01pdHpCN2pSUW1m?=
 =?utf-8?B?cTU3TzVhdGRXNVdkdEh6MU85TkpXVmpQaEhmR2h0QjB5RDJMVW5Wb1FkRlNH?=
 =?utf-8?B?a1BUajVqb3gxdVdsd2NGSmtCTFdiVmFSL0szd2FyMWVxdVNoR0ZGRkcwY3hJ?=
 =?utf-8?B?cjZsTXNraklnMXBpclJyeGg1M21DMng1WVJDcS9TdzVOdklzZG05OUVVai9T?=
 =?utf-8?B?VVNLdXQ5TmQ4OEFOUzlnaFNZaXF0dXM2VXdweVNVc0wrRXIrL0NEV3A5SVRy?=
 =?utf-8?B?OHRkY3JqSXpWMmpjeE9VNXZZeHpVaE5Odkg1dnJ6TFJDQ2NqVGlUeFQvZVEx?=
 =?utf-8?B?YXJSQkRPTWlFTUdRWDRWRXJjWVZqMnVxSU5nRkJrUFp2SjhONmh6MWRyREJY?=
 =?utf-8?B?THAvMVMveWFUOHZ4YnI1akU0WDdSZEdsbjFSR1duU0YrdzlEcnRScWp6OVJX?=
 =?utf-8?B?YUJrZ3VQR0RtdmZiV2pqMHZKZG03U2JVbDBJQkxpNE1TNUVkMERsMGRFMU1D?=
 =?utf-8?B?QVAvWjRDSmEycFdBUksyc2x1QmhUR3BzTWhEc3ZKVWxDdWZheVRDRUtHYW5Z?=
 =?utf-8?B?cDRUTlVRWE9YUmxMbDE2U0lMOEhzR1pEeSt6cHFUUVlaUTNRMGZOZGRheWtS?=
 =?utf-8?B?cFNiZWJaSnRrNXRkZkhvSTFpZVBQV0ZSUGpHZ2tSbEhiN0htRGFHVlNEa252?=
 =?utf-8?B?NmM0NmlNNHFrWFFxQjBVcllna3lkZEJ1Z2JaRkIxL1o0ck0vbmZZNlBBdE1M?=
 =?utf-8?B?M2xnOEJMYkpuU2o2UFR2b1BuZXVEV1UyOVF4VWI3ZlZLNVlVQmhjTVBHdHFQ?=
 =?utf-8?B?bnpuazd6YlpLdHFLNWx4TWhBclpvQk5pVm5XcUZtUG9wUkd1dGYzS0Y2UEtL?=
 =?utf-8?B?ZzJjdDNtOVJJWDdVUER0N2VPRHF1VlBMU29RSjlJcXpkNzUzUENVL3EzTDlC?=
 =?utf-8?B?ZS9lSHdCS3IrU0FNYVpwQXl4czBQUlU4MXd4RkNrS0gwa2xFUllYcFI0ZXJI?=
 =?utf-8?B?OUQ4ZHZLNlNjb0VxZ0c3YW42dy9udW5qdTJtekNGRVF5cElOMnNmMXFqS2pn?=
 =?utf-8?B?K0JDeWNEMEIzay9ud1RDbzE0MHFNNnU3ZVdiODd0N0JjOWNTSEZpZnRiMkxx?=
 =?utf-8?B?bWxmNkJ6K3dUaVpsUndQeWVFTWRra2JZa2xFa3NyRkVqWHpkbVh6L3dYT2Mv?=
 =?utf-8?B?R3pPRWRJQjAybWtoTFU2Wk1zc3JwK1RFREVZNmY0a1p2SDNQZ29PQkNZZ2xQ?=
 =?utf-8?B?eHFiMWFWSUxmR3lyMi9KN3gxbTdzd2IrUGJ1WHhyRXVnL3djQ2t6NzIrVGtU?=
 =?utf-8?B?TzltbEo4cHNMeTFUdmc5SlZFR2sxUTAwQ1R6aEdLdWN3Si80Z2l5MC9qa1Zi?=
 =?utf-8?B?TkduNHlEV1VVTXNDSWxtMlN6RTkzVUJxY1hBTjN6N1RjQVVQejZDMWlsakRU?=
 =?utf-8?B?a2FKWklUUUg5eWMrN210RGxOY25rd3pVVmZYaTM1eU9KMnlscEppMldSOFV2?=
 =?utf-8?B?OW5taTkxVUg3Vkg3dmwvejlzbGNEWDVTcCtEVkhyNkpsNUkzOTRBclF2ZjRZ?=
 =?utf-8?B?MlhoclBzQ25DZUt3cnhNSWhCak9jbGhQREJwbkJlVnQ2dU42TW0rV3VDVDIx?=
 =?utf-8?B?UlBrZ3htMDV5L0ZmV3R5Q2FZYlo0eFNldEdXb3dHTlo1U0lMQjFxZGZZaGtK?=
 =?utf-8?B?dExNYmRLUnBweW5vakt4K05qdHg2ZnFFNTBHY3hKVXpsSGJCMXpMS0szUkpD?=
 =?utf-8?B?Y0ZaN1dVMk1LS2RsMXNnUlRWTGlDd0VuVGZzYzFOemgyVzQvMU1sc0U5d0ZE?=
 =?utf-8?Q?E5mXgLERHUpBxUIexzQfUkVIe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	O+2kTVStmn0NJ0kM76Hbe+IYI75Y4VDYhIsCnxXGGNtDQUlZ0jBHZ4g5te9ZK9SzC2t+xyFsHWYx8fFFnpH4V9znf/5DjeR/8wmHJtnw40dLjkZnP63QJ9judACfQmoH8qbYNUcX7HdIK6NXiwk0Ao9c36Rsu1Z0WPawPF+jIsOwt3U84334KvA+tNucDcHbYEbXj7JR/thgIA3yKdpfI41zZo6xj5eGhliJjq+2qt+/uE/X7B/7wMA66JraPWV9pJyO/b83xCWjjE8lKtnyNH6gpvJhQObVyyfbrICWL0F9Pi0KPFIJNyfaHpd771b+lCcACmMxEodOAGxHcUQCevw0/JDiV7r7KFrJQbO93g4YIqlO0MCQcoQvYyBR2m47ic9UCFQvz/E2dY6KEKI1QsegLg/u19WViI191yx3OgHiNtrwFPIV0LavsczBQgtqdEL1JyePP3i7hWqMEhrtQroEoDLBenIjdIvmQZAAucMDX8iCzpUvlKG/eMnSCAl4hptvNw5IcwHA6JWiNibPlC/7rK//TXLdZhKejvKgooqFHzcH07YWO6R+WXLGKog4XWxaXIWn6Ewljx83Y4GwQZumZ0LMJwYvVyHp0JMcQTW6PDbZGbyZDtlyhI/JvkCOQjUXRNKTffVwION25JtmsiF65hwlIwZKlXcCdn6i4cdHthBE1RZGj+1kP+jBa0/EuDF3ejezfwzUfKozj4IFn21a7NRXoXfDUTQSyHgUnPuwt83+E2ItoGbExtNVRSM7AlJe98TzlELOUPLN1vd8LshHNje2d1HDiA+nSNElTRY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db98ea5-a05d-41f2-ebea-08dbef3ecc1a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 11:48:39.7959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kelo/wkNwL1TQfCSHXTlgRRrciIwYnP8fusQ3tLKBOuvnMWoA7eQ0L0bLhcWJemSJc6GhifPL2RUPEnw7GJSgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4980
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_09,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311270080
X-Proofpoint-GUID: BlNJG_RwapjqXdK5eSaGdEd1YcSNiWcF
X-Proofpoint-ORIG-GUID: BlNJG_RwapjqXdK5eSaGdEd1YcSNiWcF



On 11/25/23 09:09, Anand Jain wrote:
> 
> 
> On 11/25/23 00:19, David Sterba wrote:
>> On Thu, Nov 02, 2023 at 07:10:48PM +0800, Anand Jain wrote:
>>> In a non-single-device Btrfs filesystem, if Btrfs is already mounted and
>>> if you run the command 'mount -a,' it will fail and the command
>>> 'umount <device>' also fails. As below:
>>>
>>> ----------------
>>> $ cat /etc/fstab | grep btrfs
>>> UUID=12345678-1234-1234-1234-123456789abc /btrfs btrfs 
>>> defaults,nofail 0 0
>>>
>>> $ mkfs.btrfs -qf --uuid 12345678-1234-1234-1234-123456789abc 
>>> /dev/sda2 /dev/sda1
>>> $ mount --verbose -a
>>> /                        : ignored
>>> /btrfs                   : successfully mounted
>>>
>>> $ ls -l /dev/disk/by-uuid | grep 12345678-1234-1234-1234-123456789abc
>>> lrwxrwxrwx 1 root root 10 Nov  2 17:43 
>>> 12345678-1234-1234-1234-123456789abc -> ../../sda1
>>>
>>> $ cat /proc/self/mounts | grep btrfs
>>> /dev/sda2 /btrfs btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/ 
>>> 0 0
>>>
>>> $ findmnt --df /btrfs
>>> SOURCE    FSTYPE SIZE  USED AVAIL USE% TARGET
>>> /dev/sda2 btrfs    2G  5.8M  1.8G   0% /btrfs
>>>
>>> $ mount --verbose -a
>>> /                        : ignored
>>> mount: /btrfs: /dev/sda1 already mounted or mount point busy.
>>> $echo $?
>>> 32
>>>
>>> $ umount /dev/sda1
>>> umount: /dev/sda1: not mounted.
>>> $ echo $?
>>> 32
>>> ----------------
>>>
>>> I assume (RFC) this is because '/dev/disk/by-uuid,' '/proc/self/mounts,'
>>> and 'findmnt' do not all reference the same device, resulting in the
>>> 'mount -a' and 'umount' failures. However, an empirically found solution
>>> is to align them using a rule, such as the disk with the lowest 'devt,'
>>> for a multi-device Btrfs filesystem.
>>>
>>> I'm not yet sure (RFC) how to create a udev rule to point to the disk 
>>> with
>>> the lowest 'devt,' as this kernel patch does, and I believe it is
>>> possible.
>>>
>>> And this would ensure that '/proc/self/mounts,' 'findmnt,' and
>>> '/dev/disk/by-uuid' all reference the same device.
>>>
>>> After applying this patch, the above test passes. Unfortunately,
>>> /dev/disk/by-uuid also points to the lowest 'devt' by chance, even 
>>> though
>>> no rule has been set as of now. As shown below.
>>>
>>> ----------------
>>> $ mkfs.btrfs -qf --uuid 12345678-1234-1234-1234-123456789abc 
>>> /dev/sda2 /dev/sda1
>>>
>>> $ mount --verbose -a
>>> /                        : ignored
>>> /btrfs                   : successfully mounted
>>>
>>> $ ls -l /dev/disk/by-uuid | grep 12345678-1234-1234-1234-123456789abc
>>> lrwxrwxrwx 1 root root 10 Nov  2 17:53 
>>> 12345678-1234-1234-1234-123456789abc -> ../../sda1
>>>
>>> $ cat /proc/self/mounts | grep btrfs
>>> /dev/sda1 /btrfs btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/ 
>>> 0 0
>>>
>>> $ findmnt --df /btrfs
>>> SOURCE    FSTYPE SIZE  USED AVAIL USE% TARGET
>>> /dev/sda1 btrfs    2G  5.8M  1.8G   0% /btrfs
>>>
>>> $ mount --verbose -a
>>> /                        : ignored
>>> /btrfs                   : already mounted
>>> $echo $?
>>> 0
>>>
>>> $ umount /dev/sda1
>>> $echo $?
>>> 0
>>> ----------------
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>>   fs/btrfs/super.c | 15 +++++++++++++--
>>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>> index 66bdb6fd83bd..d768917cc5cc 100644
>>> --- a/fs/btrfs/super.c
>>> +++ b/fs/btrfs/super.c
>>> @@ -2301,7 +2301,18 @@ static int btrfs_unfreeze(struct super_block *sb)
>>>   static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
>>>   {
>>> -    struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
>>> +    struct btrfs_fs_devices *fs_devices = 
>>> btrfs_sb(root->d_sb)->fs_devices;
>>> +    struct btrfs_device *device;
>>> +    struct btrfs_device *first_device = NULL;
>>> +
>>> +    list_for_each_entry(device, &fs_devices->devices, dev_list) {
>>> +        if (first_device == NULL) {
>>> +            first_device = device;
>>> +            continue;
>>> +        }
>>> +        if (first_device->devt > device->devt)
>>> +            first_device = device;
>>> +    }
>>
>> I think we agree in principle that the devt can be used to determine the
>> device to print in show_devname, however I'd like to avoid iterating the
>> device list here. We used to have it, first with mutex protection, then
>> RCU. That we can simply print the latest_dev is quite convenient.
>>
>> I suggest to either add a separate fs_info variable to set the desired
>> device and only print it here, or reuse latest_dev for that.
>>
> 
> I got it. Thx. However, I am still thinking about the fix. more below.
> 
>> Adding a separate variable for that should be safer as latest_dev is
>> used in various way and I can't say it's always clear.
> 
> 
> Libmount and libblkid use the device path from the mount table and udev,
> respectively. These output gets string-matched during 'umount <dev>',
> 'findmnt', and 'mount -a'. However, in the case of Btrfs, there may be
> more than one device per FSID, and there is neither a master device nor
> a consolidating pseudo device for public relations, similar to LVM.
> 
> A rule, such as selecting the device with the lowest maj:min, works if
> it is implemented in both systemd and btrfs.ko. But, this approach does
> not resolve the 'umount' problem, such as
> 'umount <device-which-mount-table-did-not-show>'.
> 
> I am skeptical about whether we have a strong case to create a single
> pseudo device per multi-device Btrfs filesystem, such as, for example
> '/dev/btrfs/<fsid>-<random>/rootid=5' and which means pseudo device
> will carry the btrfs-magic and the actual blk devices something else.
> 
> OR for now, regarding the umount issue mentioned above, we just can
> document it for the users to be aware of.
> 
> Any feedback is greatly appreciated.
> 

How about if we display the devices list in the options, so that
user-land libs have something in the mount-table that tells all
the devices part of the fsid?

For example:
$ cat /proc/self/mounts | grep btrfs

/dev/sda1 /btrfs btrfs 
rw,relatime,space_cache=v2,subvolid=5,subvol=/,device=/dev/sda2,device=/dev/sdb3 
  0 0

Thanks.

