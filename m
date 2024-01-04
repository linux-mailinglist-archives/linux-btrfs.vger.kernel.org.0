Return-Path: <linux-btrfs+bounces-1211-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F26823B51
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 05:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762A928846B
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 04:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FC118EBD;
	Thu,  4 Jan 2024 04:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="exPIA51o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IA398IUq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1151518647;
	Thu,  4 Jan 2024 04:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40433Sf5017997;
	Thu, 4 Jan 2024 04:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=TEo2pZke/rxnckz8zzy3ExU8lwf3MtCnWa5fy8/GOUU=;
 b=exPIA51oMcBpZ7eor3zy+4WBKc9uP8zwYP7j1S8yGzILe1SQO5g5I1+NqtNu2GkyvkOB
 PL7+IOFvuMrT0P2AP4ukfjcBYwXzEOq/eWq9FPeJkwn2BjXlQ0tPQgHj6MbNmhizgCDJ
 L2l4IjDU5LyvjegCiY9xZqWeFeQINESZ0c2rMRsJfeJ3vQFRXo2JfWgtNDBZtH7qFUmR
 JpNXXViGvaeQkf895/i4kiNr9FRNwKj5mWKn2rnkSheUXB17v/Uq5dotJgKLmOKvIH4/
 FNIihAs6Np3ijS3izRzNr0Ubyz/6riZwxwVuzgtkWldXQt2AETSv0Ws+leeA3WudG32d mw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vaa4ced6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 04:02:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4043sVsC033378;
	Thu, 4 Jan 2024 04:02:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vdmvn18pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 04:02:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iznehXsX3pB2YQ+0uRe5Tf+NkwQvX8BiRdr7J4Cblz/HCMKG+/wCl4hSX8OEZEjqfLUb7+kOfaDmLnwTJVzRszt1DwXjw8hk70qafK4ptQ8lvA554AMZbpA5rrdgH3InnXHaEADIl0wpT2+sbxa2Sduk5K0UTtJfDdAG7OBsqv8a6BzrbGaECs5sSdkDwniJoRMfOpzudh9I30wREfx6aG32PaiRM+wBuFfU+QpBWmnYlLhdUk2Bwa4I8BMoNKAbci+5BeSmGLI3RXYIFlGrlMlGzedVCtT2X8kI3slU57lIJwwLqMcxyculc/mh5D8KTTMT1mftJv9Dj4K87BLn4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEo2pZke/rxnckz8zzy3ExU8lwf3MtCnWa5fy8/GOUU=;
 b=FDXcHOeRKMTxYcDnSvJEq8ZdqHLb1cKp2hhkSljnr0yPrwz9Ghj1fNllu9o5t1aOFIE3kD//JVTmAnQPM9aoSe2B6nI6ljvQ5yWpLJdVgWrSHQVRpRGh93SnnSR95LwZl6OdPAe7naudxJQvkhEQuPxbyeD8RThmjZWMausfsUQ0TPATZ8/wC4EHZdVI8uZnawZDwll9VpEHjvJvuqwFz9lBKaOedgK01VJqUHmykrRA4a4mIE5Ly6K+ApUmMcxXJ6n9QAc9Eklqne1MWcH1YmphR9GaDbKV/jxAOj6Mj4BEZbdfPrPwCMjmY22kmhjdjHd/tTEkg7gqlvK8uige8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEo2pZke/rxnckz8zzy3ExU8lwf3MtCnWa5fy8/GOUU=;
 b=IA398IUqME2S1cp9w+2PQu4kPAtrnN5FG/Z2kCLwSZk98KywVCVFVQagLJXCFruFWqY5mUwOL0Menlent1r6E/Fo90srgSrAvd0yJyJI0qqry4VTU4KaKkL/RP1iXnYJ+buDfYwsFfmSjo/2qSLYjFHBHtuNEEi1MuoecM27pZg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6774.namprd10.prod.outlook.com (2603:10b6:8:13c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 04:02:57 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 04:02:57 +0000
Message-ID: <e152ee3b-48a7-3e91-c5aa-c698386b62ea@oracle.com>
Date: Thu, 4 Jan 2024 12:02:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 05/10] common: add _filter_trailing_whitespace
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1703838752.git.anand.jain@oracle.com>
 <cf58eed9c9b9134b94fb6872d37b75a0c0bbe914.1703838752.git.anand.jain@oracle.com>
 <CAL3q7H7C10hZKyKgP=6H-+umNVawUn=vwJ6-gqDA8s0QZNFVTw@mail.gmail.com>
 <0cf6e6a1-c347-4dd9-98cd-4a95f36c84eb@oracle.com>
 <CAL3q7H5MyiJLgB5Pu5UxG9gNzTo0xJPKYSfqDAeLdVuEFOGTFQ@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H5MyiJLgB5Pu5UxG9gNzTo0xJPKYSfqDAeLdVuEFOGTFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a7d6a5-dc58-4038-60ca-08dc0cda08b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pnL0O+6gYRVkVQ0BRxbJKLe+zlpIndQjVHNn3cNgdb804rlEZpjFSu+1xyA1SsHwiCkCbiJwiOtYDE++2mScmipC8ZNaEimIBTDcPzSwQoswwVEOzDlEu9ipBmlrU2Ev/DGMAgu1afsTABU4OMhp2KLMXSGixN2+diy8cvrdjFvXn511PPqtD2gdTxT6epTN2vleKuXqwnV33+s8sbL/10XwhJP2n/lDGRo31ni6hFGtSbV7o+7xN2EzzUrvjlawG5eYOpVP+j/xvAmjH5OiGf2/pHsObPrCbHHjCMSuSYcyMUPPZmCn9zzABwUQVe9MzmlS2ouNITAkVj7vGP2RwKdGBFV88oXKLMu0J3eoP0pomXBvNf3eaCzqdCmO5jm62GhIxadl0lQQXzob/ssc9K3Z+7swldldMKDpS0bKss724uhgazZC4TjoPD7wjFsVf1RZJjyS57DlMJ+ES6RH80mcnZ2UdOiigwQR7IOUFPR6VUrPpqnBC2v7aU+PJeeemuSSez0LKYHxkJQDxUC9R/NSPKRckySbFwOdJpKtx8vGsAT97eWjWDfQFJMs9H+8VFDLoy1R5iLtu69hsyDipNlJSBJrTC/MrFabJcHr0F6kwEOfspXFvO0w+v0eSzExEW8Wxb4BnGDUYbrL71/Nzg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(366004)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38100700002)(26005)(2616005)(4326008)(2906002)(41300700001)(5660300002)(316002)(8936002)(478600001)(44832011)(6666004)(8676002)(6916009)(66946007)(6486002)(66556008)(6506007)(6512007)(66476007)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NTNnOEd0emhaR2RPUzFoTjg2YW0zOW5NWWtwNlQrdVhtc1FYbXdTSE1pSERt?=
 =?utf-8?B?VlRFdlA3anVSaDVISmxXVFRLQ05XdkIxUlRoU1pmYjU5eW1Fa0lXOCtmRTZi?=
 =?utf-8?B?bnc1dnJPUUdLV05IeGxtUVRDV3ZDUHRJRGRBS09Ncm1zL2NNb3N5Q2NzQ2J3?=
 =?utf-8?B?SmZEQWdOSVhRelNJeWYrcjRPN3NrNkNPTEQyYmZlVzN6T2dqTXNHK3MyZVgy?=
 =?utf-8?B?WkZVNjZnOWVHSWd2QzI0RUNWSHlDZGs1U2ZkcG50YU01UHowckRLVXloTUs4?=
 =?utf-8?B?TFZRcm9UU3YxNytPN3JpbEk4aW5UNW0yWlI2VG5BK3dEZjJPM0IwTmxrQUE0?=
 =?utf-8?B?TWtpOHRVcUkzOXJlRG1VUFhodWZYa1FJTUE3V2M3UFc2SXR1MURrcWdoOW9m?=
 =?utf-8?B?aGRBSjcrUUJWZlhheHVDV053MExNNXp3YlFENlM0bVVGV0NxV20xNlJrTEIw?=
 =?utf-8?B?M1Izcmo3SUlaRFFFcnFSS0tPYTBheTMvcjNDcXdFTTBnRzlMckZrVW5Ua0NX?=
 =?utf-8?B?RGhBeUM4eXcxbVJiQ3hGQ2tyazk2aDBqeHUyaWNiM0IwaUZFaHhwWktKRGNo?=
 =?utf-8?B?WVdYbExlelQ3TGhrWnRaSnBGL3gzTXVpWjYzcmJpSklLZng2Q2Q2RXZDMUpG?=
 =?utf-8?B?RjNOVFRWNVRteTgyN0tXMUY4Yzd1Mi91OExxNFI4eUUydGpNRG0rY0hiKzJq?=
 =?utf-8?B?czU0ajdwT1JRcmx0S29RSUU4WmlwQWRiUCt0V2hPdmE0L2s1ajN6eFAwU1p2?=
 =?utf-8?B?RThVRzdCWldRdEtreFhqR1lmRm9SemZCeUFXR1RucG9FSXd4N0JIWk5kdlYx?=
 =?utf-8?B?bE9MbnJSWWpkdGhFTEZTUlhQNEo5WnVNSHF4TElwTUNGaEN3RklZUldKZ0J1?=
 =?utf-8?B?UnQxS0UwV3FzR2o4SXZGTlhTVVNIWTd0WTREck9namgvZVowYmRJelQzZmlI?=
 =?utf-8?B?QlNzYW9wYWt4bnBqNnJrUHFFVXQ2MWxmaUFOc2hKaFZxU2w4OXIveDIyNlhv?=
 =?utf-8?B?YnNuOWRhL0haYVI5NVRQeTNCMlZCaFFjTms1eEVCV3F0dDlLcElFSWlwSHdq?=
 =?utf-8?B?cTJjd2lTY1hnZ3dyNTBTa29jcXBFOXdVWXlaRUlvcjJWUFlVZDI5VFFZUTVU?=
 =?utf-8?B?U0haZDZGOEpxSURCZWFhM2twcy9mM1Y3V0ZsRDJqbEpTZm1pZmFXVTY0R1NU?=
 =?utf-8?B?ajMxbDEwQ0N3UTBtZktFTUlJR29OWk1KZUMyTkg3d1N2WWlwS0hJb0dFTjNX?=
 =?utf-8?B?Ni9Wakh5UTZhak9OUTZ2OXZFQjJCR3VQUUpUaHVFQXh1dzRGNlJyYUNEdTNC?=
 =?utf-8?B?TWlQYnRvUnhYRjF3WHFXd1JvenhjT3ROcGlpaU5Pc3FsaHF6NkZrVjRyRHVL?=
 =?utf-8?B?a0JTSWh3Wm1DNG1nT2dpVHFUYVFteE5jbURmT255YkkwQVA4UzdWRjVjalA1?=
 =?utf-8?B?ZzJnZUxDbE5jUjg3dE5zOTZHdGZhZEhqNFJVTGxHWXp0YmpZM2FxK2xyVU9D?=
 =?utf-8?B?Z044dlp1eGszUUVReS96RHdyNnc5cWVReitqb3NieFVsNXpLT3p4aUlwTzh5?=
 =?utf-8?B?ZjQ0VGpDTUFRN0MzYStvWDFmQjZNQ0JiNDQxOUw3bjBxS3Avcm0wa2ZRMGNm?=
 =?utf-8?B?bmZSSDB3UXZLTkl6eUVXNDVIRXZVVmplOGlqZFZiekxJcVdYYWJESUlKZm5n?=
 =?utf-8?B?aUI4TnlRK3N6MVAybFRuNFdJM1dHTDlaYUUzWGVnYlhuSlcvai9SZTN3L2Mw?=
 =?utf-8?B?Z1V3amxIaTZYRTRKQ1NEUEt2MG9mT3djdmN6NzlXRTRUTzJrMEhhRms0YWRj?=
 =?utf-8?B?bk05N25pb1pjWEd4Y3RIdFVSZFlTL1R3cVNSdUJKVmF4VDZ5VnVoekszeHFw?=
 =?utf-8?B?M3dPalQvWTZNZzQwL1lOVUtLaU1TekdTYlVoczVnRmZVc2lyT2JBSGJEY3ZN?=
 =?utf-8?B?Q25PekxvTnFhc3UwdklFZHY1aVZaOEpjc0JXc1B1MWpmWXp5eG51eXUrTUtt?=
 =?utf-8?B?elBaUG9SVVk5NkxGN0xxNUNEVGVSd2pxd0sxaFlTcjRJR3c4bFlRRFpFbWo4?=
 =?utf-8?B?SmVjczVuTzRTMGNKWWtXRk5JN0JiWTBjUjB6Ly90Q0h0N3ptK01FZnNlSU03?=
 =?utf-8?Q?jN87j5TScAvS4ie6hYcLsdRp9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pN2aSGLyOGCW6GJUwCzl52Bhq/JqqVISrZxceJdpHe5jQwqgXy8as1HT868P7XgYc9HVJI3PX5CoJHdk4Uum/kJGq4naCbdrig/f5XjtJ9YpNTBHgajmopgXiiWsBVS7SmLl4kQWBVDGsKtAO+lv6heID3AjmlcB7IkIkGlZiPiSUFdJOudHhcoVuPWsKN2+Lc+cK3DUgIS6KqAKcPFbCH9aJhiFF07gBz4evBCvlLKo8ge6mr97+d6OnM0DAvg0TcozQEXaBU1hled2F9T5mk0NzEI4Rc1ACNRPHxhoINny+toPFXHNGBDT1vK6Tj1OX0Knnv4LQYaAfL/PMsZyORdLNp6o2m2Be27dQwUclcAo3Dqj1s1L7ngZZhGoy80b2YNiCXEvP6G8unHwi8odTvxeLO9EsxQRuK8gCuLmB2Bob5LlXBIyH46ijDsEEj3/anQXEOmmqcMTgfVugb4M0MKS+eNLx0ehjamMnRZZQ9pTsmH/fWEnN/W95guYuoj3DPpmr6bdwqyYGnva2Ra7A26oH8/DtvKMJH6K71mfA0g6GaHaPrYCCBpkLnsESjbfpCuEBw+SDvy2MddKywobOZRhF+YNMsa9rM+Ekw2vsSI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a7d6a5-dc58-4038-60ca-08dc0cda08b0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 04:02:57.1332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqFAH0rNCEB4aafxDfgMUX0zk4uNG6pJEXvuSv0FVGEjC9lLHjGxiQHWC0aYj4npVAxYphaKfSRXCnMwfwCOFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_10,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040024
X-Proofpoint-GUID: LDWKsxWa7im-WDswhEqF5aEE8C5pw_yd
X-Proofpoint-ORIG-GUID: LDWKsxWa7im-WDswhEqF5aEE8C5pw_yd



>>> Also, since this is so specific to the raid stripe tree, I'd rather
>>> have this filter included in the raid stripe tree filter introduced in
>>> patch 2, _filter_stripe_tree(). That would make the tests shorter and
>>> cleaner by avoiding piping yet over another filter that is used only
>>> for the raid stripe tree dump...
>>
>>    I kept this as a separate function so that it can be used elsewhere
>>    when needed. Doesn't that make sense?
> 
> Not so much if there's only one use case for it... specially if it's
> such a trivial filter...
> 

  Hmm. Yes. Also, a completely avoidable coding nitpick in btrfs-progs.

> Even if we had multiple cases, doing this pattern in the tests:
> 
> $BTRFS_UTIL_PROG inspect-internal dump-tree (... ) |
> _filter_trailing_whitespace | _filter_btrfs_version |
> _filter_stripe_tree
> 
> Is ugly and verbose. The filtering could be done in
> _filter_stripe_tree() by calling "_filter_triling_whitespace" there...
> And mentioning that, we could also call _filter_btrfs_version there,
> since it's always wanted and to make tests shorter and easier to read.
> 

  Yeah.

> So in the end it would only be
> 
> $BTRFS_UTIL_PROG inspect-internal dump-tree (... ) | _filter_stripe_tree
> 
> With _filter_stripe_tree() as:
> 
> _filter_stripe_tree()
> {
>      _filter_trailing_whitespace | _filter_btrfs_version | sed -E -e (....)
> }
> 
> Or:
> 
> _filter_stripe_tree()
> {
>      _filter_btrfs_version | sed -E -e "s/\s+$//" -e (...)
> }
> 
> A lot more clean.
> 

  I'm fine with either way. Since there is a choice here, I will keep 
the former.

  I'll send a reroll.

Thanks, Anand


