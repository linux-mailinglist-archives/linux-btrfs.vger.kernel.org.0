Return-Path: <linux-btrfs+bounces-1228-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECF4823CDC
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 08:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89AC9B20D42
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 07:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB47200CC;
	Thu,  4 Jan 2024 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TdmPISCf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O26NeO1B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D2C200C1
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jan 2024 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403MLgRL012053;
	Thu, 4 Jan 2024 07:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Y0XBi1IKT0/6E9uGTwMK+9SR1/rCRTOndZ5rlhiqCbw=;
 b=TdmPISCfO0ty9Vhezkdxc4UV5zGKhDThhCx6eqVKJPRyqhItGq1zaDisUGvEHaBVu4Na
 42deW0gpQf5XFfGE6hy7fj1IOivltNWjnrruF15vsHlxZ61zsFOBdwjC9m/ffQA0HSM2
 NTvRM27r+b3LaNeGXu+JB5znEB0HS/Meiq9BV0VJEvuPj4Qw8Iq3tSVHCjFEOHNosVEL
 37765vAAnDxfr/Fp+88lkGLsvKIzQSvovAj9Gtyyi+668h0y2fLyuNuaFA8h2ovLhVAd
 6bVdl4FxU6485BgQRQwsY7FlJT2Tjv/zzPrRlJbzD337TnWjaZEEGkqmBwOYi3OPY9gf 7g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vabrv6ja2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 07:42:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4047Xwkq004888;
	Thu, 4 Jan 2024 07:42:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdrd68c0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 07:42:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQ7c6qAsiA/5DDelTKuzpixgFdIIBz90U3iaIO0zkfOSvi6SJGpryNptIsxmAGsWSEXcXDAS9bt+TkXU6CbperXU2oB8vilHVCy56oN4CgPHTe5yz0PfW55XlKpGhic5V9dzR8cdkXOkByEe9mDDIlK/w+01S6txBkti0+5MxOXcT0ZayhhBlc+7XTKtymA4seWJi5GDP+jzK5lXunupLsa1lWh0LzuSkWJpmolKK/VuFOZvmhK/+CzmL2yh4A222D3M+U7ORPX7zUHZ0qYxZNPu+nrfwvbq1igV4hBAYohFhDOQwTkTnk4rBLUDH0X5PcFkiZo4zPdQQW4wp2RIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0XBi1IKT0/6E9uGTwMK+9SR1/rCRTOndZ5rlhiqCbw=;
 b=XC9E3FeNbociYZmgOOWbAszARolpXyBOALFxHU19TFeo62KyDWARhiTbUBAF6MNkc0ru+i1Y0adIFRN4MqeUqtmub7poo+WoOaIv2ASdVtamZaCPj+h+z+hgUGyfbLqFM2j6spSz6i5Znue+Q7w6B35duEdoiOjJ6QXE0jwagDY+8Lba1eBz1WcJHtGRdtHke0hFTyINaNGfSkqYcbKYT62GTiO2KMy1de+BpNTf7bTecPl/VPwUQ8/zJXi8ZF0F7Rlr/HJR4Wc6B7180kt+F5yKiqGbXp7itPqPt/u7tsvj3D6Vf+pkNhs1QkCWiwC7FLIVfwNI2+LDLBwWDsZHRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0XBi1IKT0/6E9uGTwMK+9SR1/rCRTOndZ5rlhiqCbw=;
 b=O26NeO1BHUKCp/gWdbRa4idLIAUfNbRlc/258NrMt4Us2y1Y6enwxgJGWPX4Q+7Fdubki3sdrLjiLNuPANXJAwI59wk/NCHjHlmIZz0kbqOTMc3OKy+ZreVtIEmVeC6LoZojKT9aSyhT826ai+U9hR8fELKkyirje7qAUC8dDsc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4223.namprd10.prod.outlook.com (2603:10b6:208:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 07:41:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 07:41:34 +0000
Message-ID: <5bb6f80f-f32e-dad3-be48-76bc3775709c@oracle.com>
Date: Thu, 4 Jan 2024 15:41:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] [BUG] btrfs-progs: btrfs dev us: don't print uncorrect
 unallocated data
To: Goffredo Baroncelli <kreijack@libero.it>, linux-btrfs@vger.kernel.org
Cc: Goffredo Baroncelli <kreijack@inwind.it>
References: <3ab02bc2189617b9d60ec6de924f60ee3899babe.1702831226.git.kreijack@inwind.it>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <3ab02bc2189617b9d60ec6de924f60ee3899babe.1702831226.git.kreijack@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::21)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a325f7-74aa-4805-6406-08dc0cf89375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	P8xtlfxMrGjLi1s0btvM/8T5FNnPVin2d8SFeGTlDPsr49m1XvIXEMhWNeXcQkv92/28Lf7O5NzNQ4EKQ+RvKCgqJbHFPPmNyMz6aM9aEvPQBthMmM0SOI5bHF+y9uAlUFvGTgoSQMN3VrUopsyc3CoW4aAsI5HniQO00OOBuzSngqVN1I3vTgAIVWbl5YY7mb3OryLw13TWU5e+GF+MUTvMCr2S/S+5tp27KwL06jyYO54wGlVx07bjwfEWZQd96zY+h3XCUyCSeTSpgN8kGwJnlaZNW0li42vIhzELKHzvuMsGAEBjJxXdgjW1iQ3HP+nGaf3yKVSyavjMxO9gKbfH3oEIFCoRelTB5gSSGjM/bbdbSecapwCvrPNiznaJHWP66cp+EMQh1Cpw9ymv/ggEjX2yvBWcZW2jQR0i6H5fhNsUnUyZkQEl4rejPzlB0zxUPI1s3O8UrEpyS2oi87AEL0iMaDWrGLfn+Hh7981M08VBQ/Ug+Ii/t9F1gcSRIfTrJKNxiRkfpIN+bxNiIOU7aFJuVkXlGIzOF2fu+ZD+KcVQxWwBOOwDHKGnrBzXvjjldxN2rp1cJoUuEpAoXNT9hu/S62JCoSOq8VqAIwh7Mh8QShL7eqR2k8BKWq0PBOQOXmD8wCdN8gRs1aE41w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66476007)(66946007)(66556008)(4270600006)(2616005)(19618925003)(558084003)(478600001)(36756003)(6486002)(26005)(31696002)(4326008)(316002)(6666004)(6506007)(6512007)(31686004)(41300700001)(8936002)(8676002)(86362001)(44832011)(5660300002)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N1RnMG1uL01yODlvWUdib0JSY0dIRDllZVRTVU5tdnBKNlgzOTUxc3FoMmZ5?=
 =?utf-8?B?Rkp4SlE0NjVTTEt4RWt0M3MzVHdLeVg0Nnpka2g0alZ1VEltTXpQMitCRjJx?=
 =?utf-8?B?bXM0OWcwTnozZ2ZzdjQ5dWovMnhSWlo5Mk5xclFreHl3NzRrVE1RNE5uVFFS?=
 =?utf-8?B?YXVZcmYzRGwxWDAvblhGMXZsRDlyNm9vL0VJejU2WkU5ODEva296QU1ScDFh?=
 =?utf-8?B?Nm5YdWV3R1oxeEllbDVtMnQ5bzBqeitibWRTOXFVa2NnZHQ4bVI3TytPcE5S?=
 =?utf-8?B?QUNWSzAyZ0F0TE9YaHBPQ2hQelYzU0lkclNpbTJVWVgzaDU0THRMYVpSSm53?=
 =?utf-8?B?Zzk5dFl3T3VpaVVsSWh5SE10VWZXc0wzUC95L3VHNERzcDdRb2Z1d1JoZHZ3?=
 =?utf-8?B?enNSYjhKRnFIL0NxazZ5Wnh4SHdMVW54YlBXdXVUSXpSdFNsNXVOWFR2UklJ?=
 =?utf-8?B?WndGTVhBTWlIWFMyL1NtMjVrbnBzUHBBQjFpaS9Id290RXM5VExEREFvVFh0?=
 =?utf-8?B?N2o0Y3QxSXRjTzUrTnNzYUd0MFQ3c1p1dWU0VkhlUEhRakVYbFc1enBNYnVB?=
 =?utf-8?B?QzZWL3BuZE5CZFlRdXpsbUM2bThDZXVhMjBES3d2Nm5tOTk2Vk9RUFZMdkti?=
 =?utf-8?B?cVZRd1p2Z2tlaG1kejRKTTVXVTc3aEt3Ym9sMll3MWtiV05aU21YNDNCRk8v?=
 =?utf-8?B?MTROcCs4Tk96RHcwNnZraW4zVVBWNEdNT3haTmxsNGlqOHBKbFpFcWp6NlJR?=
 =?utf-8?B?dXBXU0ovRGh6cUQzRFdYTHFIOW1iZ0xYLzB5NzkrUGZuelJEWHU1REd2S2tm?=
 =?utf-8?B?VmxTajlZZ2tDK1JHR2dXYUZVa1N4SzU3K29ZaVZ1aXdrcGhjVm9tWExsMnNR?=
 =?utf-8?B?R0p0YXM1cGdUQ2FrZnhuZzlZY1JnKzI2Si80L1dXYlB0cCt6aDc0SUpPcStF?=
 =?utf-8?B?ZUoxR1V6Z3V1V2lsUFFiVTFaVXpIQmJjSTlQTXpZbHZzMGFsZUtoK3B1dWJ0?=
 =?utf-8?B?ZHpmbHNwUXNnUG9Qbk5FUkNpTEJISm50dU1veGJjTkZ6MUdDeU9CdTU3VkZo?=
 =?utf-8?B?T3hOSE5iWTdTWDhDZHNrSWZnZllUVHJvNHFnaE1tQkRVV1J6M1l2d0tEOXJi?=
 =?utf-8?B?aEV1WlF2K1FBQzIzTUxiQStRS3hWVDVtVFhpY3lQN2VwRjg0TmNtZnZEQXBB?=
 =?utf-8?B?UmVWK1AyNUR1NVBnbmM3VWczZ2dwanZKWkt1a1dHb0ViWEQwcnc3dkYrSjEr?=
 =?utf-8?B?Z0dIMDIzdGlCdEh4ZHZmNUNTVXhWZWhyRWFmU0dhWmluUW43VG95VGR2N0gz?=
 =?utf-8?B?QVh6Rk1yNXROR3NOaFJjZzI5RUF5YlFHci9DWnl0YzhuclJZM2ZvNkxXaFVw?=
 =?utf-8?B?RzJ6RGFJYWFlSWdUcHhvWG42dlBwNHVDaUtJNXJVYUlCdjU0emVvU0VEa3Z0?=
 =?utf-8?B?cW83T0R6UVJhdmlTQzc3cy93ZVVNTDFYZnh0cUc4S2FSYlpwRGtWS0J5cnVl?=
 =?utf-8?B?Y0IyRm9jT0s2MmkyTFJwWXBSeUpVQnZjUmZLYkNlVzRVUEJmUGdZYUU3RnR5?=
 =?utf-8?B?R1JEbUduZS9MT0VWUkNmRzhEK09uWlJwMjJ1QXBIYzlabmttWitzeUEwb1Jj?=
 =?utf-8?B?Q05Dd016Rm5McTh5b1d3TkdacDh5LzhEZ0dldGtIWWJxYzJmTUltL2lIVnFW?=
 =?utf-8?B?andEK1JjWU5qSmFDRjBNOHQybStVY3BwWG4rRnE4aGdCNXg2TEk4VCtYYXpq?=
 =?utf-8?B?b2xHdFpMMjhLZzIvdEtyNGdrQTZTQVJTVzRRUEMrNlRUa0FRem02ZmN0NmdM?=
 =?utf-8?B?RmpmR04rZm56bnhYWk1vanVhMEdZcUpYNVcvbEQ5RlhyT3VwWTF2STQ0TEli?=
 =?utf-8?B?ekh0MDI2bkcrSTlQSkM4cGo5ajlpbHR5YlhBQTN1WnMrUmNuWmp0blNDOHFl?=
 =?utf-8?B?cDloMERZUCttKy9ESmFHQytTZTd6bGozVlZ0SVpmTjlrY2wwWDl2cU4zMnJy?=
 =?utf-8?B?cVdrQkQwM2xEVmhpVXBXQVNrd1NUNldyY1dpWjRob1pxRDZaY1B2U0hTUDgz?=
 =?utf-8?B?MkJKQW1ZOTNnNGFHWXVvYVlNZnYvNFhyMmZrVkJ2Z212Rks1YkRmVWsySXdT?=
 =?utf-8?B?TzRRdDBxQ1prTUo5eWJnRGdqWUYzTko1YllQWU9oUXZUMUVwUUN1WFhpaFNL?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	29We04VjeYIKb9wz8ye5qcQ2BN2BXg6/01ni2bXWWRndQlKMEjHhU5ZqU7blTBokRwZFfebc2LzNtfYsEXaouvJ552qocxrWvmVT0KZvRhvUzDwPADOcC8sEO7GRqvV7CHMh+OsUw1rjgazVtXqu4SMMH92i/LIeC/Em6oGBOxfBtXPjD28Z56bDTyqvH1NxG/VfyHqhPjIRb972ZLRIV+8LdVrlNVUoR5Ustno7V/hGBwub61touUdCelYgOpm0NNaS3cnCH7xfwSOp3kANkpm4r+n1tGTLtfwhBrlUsf8HSmObgtRC3TBSkt4QN5j2vltm0tEGCaO2z+4PXe2OG+HsPRbTm9c2CoOGBg6Yh6o3mxEv2ByUZq6h+eNM6X2VmXUb1mRcMIqck/vxRoaYeXpLXpaOq4IT/z39XLL8LQKkXwZNlpn3tQ/o2/BvjTQoZtm6b1P7xUIqPD/Nu2HSg4mP4oIxxynrIJt41CCbHvZCw0aPl0RL7fZ1RSCQo843FSQbdJXs2CAFQXo1i3WBOL/PqmAdWJ3bv6vVGgFO2aJJv12wFlQSdOLJ+xBK/ZUtAt/oOS//g4m69zuynZZR9Czy+uiZft/iixLUoOWJMn4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a325f7-74aa-4805-6406-08dc0cf89375
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 07:41:34.9018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejxZL2A3BlPKednjzDIYrt1whZuk+decBQAU+mDtHXF18mjf3KKjm1wuKmoGVhM/Bz8B+1vJqgTPe51Xil36Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_03,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=828
 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040054
X-Proofpoint-ORIG-GUID: PoEQ6GXYNQnSiETpC01saUQLAIEVFpoh
X-Proofpoint-GUID: PoEQ6GXYNQnSiETpC01saUQLAIEVFpoh

sob is missing.

Thx, Anand

