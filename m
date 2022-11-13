Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31494626D90
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Nov 2022 04:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbiKMDPn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Nov 2022 22:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKMDPm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Nov 2022 22:15:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C65612A8C
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Nov 2022 19:15:40 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AD3E4Rd004968;
        Sun, 13 Nov 2022 03:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=IBiI8BkkPNkq7tPuhD0WjsaS3jdlsxyoOVDtvm9djb4=;
 b=PmSZqtNjuCJW+LIuDCrcbW5uWBTqtlwKttmfa7XkO2MM8bXm7uoSYCPhcIdV+83QPs6O
 LhBJVP0wB6/ljMsp+bsuiqnoKj1A2RQiN4SYtq4uuRkfyOyyySnQMrX9655oyI8n5Jpk
 ZHl2nSfhsLvd3ZRvpxLNo/g65bLyRn/fz8oVPMy7v3LBjl3LVyED0cd5vx/vs5T50NbD
 L5Eatw6T2B7GXyYp4mh9HyMldLYlde1Rh9a3YJ8vRCOdIpJS1pjI3dLoPElFvmxUcalT
 twIQa2HhKgvcjMx7+D+B2obAGLzsgyjih99r1gtqWqAQ5+SZCk+i2c1bhu7J1bnJYimg aQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ktr82r081-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Nov 2022 03:15:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ACNmkTg016199;
        Sun, 13 Nov 2022 03:05:45 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x91n76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Nov 2022 03:05:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6zJWyNaKrRFZgvXCzeGrF/ajyHOXRy/nuMgDZPXIVURpqVobI3eWFKTQO73ZJK0UVKalMFgbisMklZuMg3Iz5AqSwB4rxH4xncwQyc0ty+6toz3RWp2piSnndtd96XSAygITCNXYeMz/fn97319FukiWVVF5snHEPpylkSbkqj+wSrFViDs3wxShQuARzUazhhRJMOLC4EKNV9wPLT7qITLrNG6Qvs6DXoN+YdzGtDq33rWkAKxpRAXhNcfsU4/k4iUb7y8KZGYSD4EJ1nsSx8qSxkBtuqi2xIBCTPrvSADMS02DyB0Teo29SjHCtOISIMXTprnObCyyyRrVbpy1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBiI8BkkPNkq7tPuhD0WjsaS3jdlsxyoOVDtvm9djb4=;
 b=AZey8EOaLpE6q1ipawGqCS9FnuF0HxJQCj3NUmzIxvFWvx36n4MLUKQgBr0uZN248Tt1bsFLU5l+3YF+C6fcoW1+jhYJFp8xmhdhtKskMSIo2trYPZKdiKsgEZ1iadvD2TfbFFspM8gtGI4FvDfEBSzPaG905irUDAFqG1biRmvx6ilSj3da26WteNpDSzHKWxzlZE1M+7wH3HQk9UcJ4o84gJyIy3crGKFvmtkJfDdqr+Z7Lq3n68B16s33svryhVrjbuJhXGr9+4xK+ekKA6Eo4aQ01jPlvdDGa8X7bpn+QcK74NRQr4CKZ7pD0+24DRLS6kSjdbvtHbe23QyxEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBiI8BkkPNkq7tPuhD0WjsaS3jdlsxyoOVDtvm9djb4=;
 b=qXM5C8mrsLAB1RxbputDqaYV9aO+cDR1Iz7CJNbDlzXnN51Geph2Jo8v/9aYZLM3VR1QFvn2W5EOrKq6HyMI3PBOR46C4PahxrFyYLBAoEKl4mTRBEWLs4OBaerFMAwkM/uxPgpYYfBP/wA+00wlDyZcnaSm/HOedCNepdYskmU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Sun, 13 Nov
 2022 03:05:44 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65%7]) with mapi id 15.20.5813.013; Sun, 13 Nov 2022
 03:05:43 +0000
Message-ID: <2cebed11-d454-b2f4-18f2-dcec194600fd@oracle.com>
Date:   Sun, 13 Nov 2022 11:05:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: use btrfs_dev_name() helper to handle missing
 devices better
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <071d7f1c5f10d185146b83dd665a68ae5a4c9303.1668303064.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <071d7f1c5f10d185146b83dd665a68ae5a4c9303.1668303064.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a4c64a3-8b1d-4d08-9ba7-08dac523f3f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6cAaszrpijI7/HFSnrUSCT5pMAIQVU2Y5bLD/pwUmeU+F+N63GrbfNscq1UEw8PMbwGapqE/s+GvPS2hC7hhknpDLLWpyrnL+xBaGCaz9dz+ut9h+q9XwYq3JvQfiydMFwhGLo5K2blui5XaADBphTVFDNyxberw4SKjskui1g2G76Xsdvfi4lQQ3b1SEhYB79+Ifwrp4pjVRix9cmzKFZfHyv32Qhc0qou0eAx4IlxDevd+5MCHVYOi0GXyj5NDlhdzrTfEFvFHmsGe7ykJmq7qIU14YZ7gdzbFKYXY4tUmfzWhmrswnjrFujz+NUqVMG8AXxfbZix8e0GXBtNyuEONSzEsJrCDA5tVh8vxLlNft28D7G2CuF1nq3xaFQXu9pd01meQd9MwDp7Dbgd+BoHIbgxaroN2nXBmMgtdREj1UmPHhiAVW3M0fvkOHpQuypNvNoHK77t5YxgXlDE3XuVFHD96G2OEQhrBzNrckjWICDE6GrXqTImvnjhxxDngN85paN/KfudDbhGFP/TFJNkFKJ+x0EDLrHKcDFycTIBszx6oYNVA4vYj4ygQNUCQGLzxEn75kZL+S+wkGiaWQtasSOcUFeva7WCMPTNH+dTBDOwKO0yfB/B2XnmYu7gU5PZFlfq4p3YF6cg8/sK7iPk8EN8y0cWdHnVQwXDZQKt9t1z4noQyJoyHX8+Por5yjh3bL8NYP8qhbXJC52W/lmWnBJDGplhgbgfLaQ55Ck7Ti1NsbnlWNcFYwa9/8HznXJqUxSNqRWcUkXowPqPdPOXJ4hiVqj6EbyX3wc3wE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199015)(36756003)(31686004)(86362001)(31696002)(38100700002)(2906002)(44832011)(41300700001)(66946007)(5660300002)(8676002)(66556008)(66476007)(6506007)(53546011)(316002)(8936002)(186003)(2616005)(83380400001)(26005)(478600001)(6666004)(6512007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWdrOUFZMUgxZ1V4T1FWSGNON3NadVFEb1U2RDJIQkJ2R3lWeVhQUFV1d0pP?=
 =?utf-8?B?eGlEOVJDczdWcy9tcE5vY0hzVHNzQzB4RGFSZVBEdFJqdGlkQVdoUW5pdDJ4?=
 =?utf-8?B?UjlwYWJXdDVHVzhXZXZ0SzlJa1FyMVRETFVJcklHVVJxNVZvdzVERmdUUmRy?=
 =?utf-8?B?aWY4ZEYwMWxKaU14TkdBUFJrdDl6Q1JPWWVrOXZ2VDRmZlIvRFY3YkFaMk9E?=
 =?utf-8?B?c3FiR01YcDhPeHJ2MnlFdkw5NGpQSXcvZGYvZU9XSnlyWmUrYk5kTzNFTDlo?=
 =?utf-8?B?bDBxUDRZWVorYm5qSzVFRW43N2RNamRpQTNYaFY4S3J3QzMrL3VOblM0OEhG?=
 =?utf-8?B?Z0RiNkdlMnFIWG04SXFXbFcxd3EweTJKVFFOSWFmUUNJQUxSWlloNVUzTDkz?=
 =?utf-8?B?MThJZy9nYmQ0NzJqVEQvbEFyR3FkLzRwVk9wV0dLdHd1Wkdacjl3V2dUUmJo?=
 =?utf-8?B?SVhHWVN2MGpwcTJnd3pReFhQckJNKytNWVltQ1Z4N0E4eFd4V045YVBKbGVx?=
 =?utf-8?B?RnJpeTVyMzR5eXFBZDExcDJtOENlRlBka0IyUkRRbmxPMmhuZ0ZHZ1k2MGJP?=
 =?utf-8?B?MkhDTE93UDVQMXhmWTR6R28yOEVad1dMbEdoRnRiVmRTblJRZ2RIUm5sS1g3?=
 =?utf-8?B?ZE53SnRUNVRSMkNIWksyK2UzbEJhRGpCR2xsN2R2cnlWbDRRTzRJNEYzLzV1?=
 =?utf-8?B?bm16dVRkK3VML1YwSVBoTU5uS0tBWStmVDFNS3htOHFtQ3QwMGxrRXQ1R0Vt?=
 =?utf-8?B?MlhhZDVBY1Y0YUJoNWh6RVVZbGpFMkY0QXdzK0QwQjRrTmhUTS9zeENDWm5r?=
 =?utf-8?B?a3BuREJSNWJtM2dqeDdHQXkvYTgzcjdwUGhRK3pOclBoc2FMTkpUK0IrbUlV?=
 =?utf-8?B?SHAyVExDcEx0cnpaK3pRRnNXZ1dnd1orTk50L3lVNkNFRzVmSzNrTzNxM1Y2?=
 =?utf-8?B?Q2dSUUVnQWZQNHdESW45dFUyeEplQ0VybDNLT1JoN1g2YWFhTFE5QW1BdS9H?=
 =?utf-8?B?bGpDTSthYTdkSW9UbG9YU1B2WE5wQit2ZFBoZGtOblgxbHl2aFFGakVGVVZy?=
 =?utf-8?B?a3JUZ21vbkFjSDV6MkVNeEplVzlWckNtYTBMTUN5NFdvbnduSEpVdXNmMnQz?=
 =?utf-8?B?Q2pSM1ZrY2kzc0VRMFZXMS9HZzNjZVRDbDZlT3pVMktiYXVXY3N3S1hBdGpJ?=
 =?utf-8?B?blJ4SkNycGRYb2RBRFFScnl3V3lGdzZJOEo2eXltK1ZPRWZ0K2ZlVXBvV3VG?=
 =?utf-8?B?R1hSelRQYm1NZ2lPQ1Y5K1g2SEZ5ZDFJVUFEaEg2ZFRBeGdpVXZBQVh0OXlD?=
 =?utf-8?B?S21QK3J0OHMwWlloeldHMFNobFFMUU00ZndIV1hONkgrU0NLVzZTRzJhdkpC?=
 =?utf-8?B?Nzd5YXcvSkQyWXZtRldOYUowMjVWVyt0cExhSmR3d1hsbHp3MUpndktHeHBu?=
 =?utf-8?B?eURHdlZoZFRYSit0QStKTm11WnNPVEpIVHJSbFIvNkFIYWU1OU1uSUpNNC9U?=
 =?utf-8?B?eWhYZUQyWFRnRnNQWk5yazF0R2ZyQy83WGJmdDQ0eFVwZjk2QkNWQU1TZlpK?=
 =?utf-8?B?TzRjR1grTTFIbDNUS1JGVFFtOVRLWllXOUpUVWVZb2tFMlB2alJsTjdINFg1?=
 =?utf-8?B?TEVtZU9ReHJuM1RMb25GYXlYaEFuUlZNd05FbEJYbHJBNTg5OHRyYjJVOGhC?=
 =?utf-8?B?MVh0UkdNVGlzODRrSnd5N29VV21RcS9WY0FYNnBvQVhRREJVNUw4NTJOd0FE?=
 =?utf-8?B?NXFqVmI0YmYzK0trc3JuTlZtTFhKVXZwdE5lUElIZXpoMlkxT0F3UGlla0dl?=
 =?utf-8?B?dVVtRi9lN2RVS2RYb1BCaWlwM2hkS0RNSjZveGVleERISmg1bXhIL2tQWnhk?=
 =?utf-8?B?RVkweGM5VDZmdGxXYlNkK1JWd2IrZlkzUkZMOUprOEtLWnJaNTdTa2pVTFFO?=
 =?utf-8?B?RkpZMzEyR2Uvd1BoUmZUVlJzVTVZZmdOcng3aVBwQksyc0V4emlLMEtGMHBI?=
 =?utf-8?B?WGtLYm83K2lENGpCd3hWbU41NmovT3A0V2JZTzdtTzloSWFLTVQ3UHQ3Vnd3?=
 =?utf-8?B?L2hCS1dxd2owZ2RnNWtBcU9sRlZVSkxoNmdUdGc0YUZZU1ZrRTFnOGEvSENn?=
 =?utf-8?Q?i9sSaJ/Lf5D+Mah2BmOmYUOf+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nBb1vHx9I6WdYqwPMD9v+7lQ8VMkcuE83Su+l3765giiHmQIgk2y4sivzOeBrJ0H5Q0plOgWpQsBNSYp/3zqaaRE/WWH88FM693q9YOD79MdC21F++Ejb8BRCA0vJFs+gXvl+53p0RpYBkDtcxblpZdY/TGgMEfIBNhl37j/no4woG2JhHTRiLMUWp86F6itl491cZdR6BE/p50D5+jXzp/MLVWO3FOq61V5tTiarl6pIiKyGFv0EzO4ysPuQg6z/mSAOCHsTNYfoxf0ycsIecew6m48cdRHiWYIvmaD/BoUHeJwVwRgKoyf6BQPFe9Wk5rf+psy/4FAwAE6YTRH7oo2Lk5My1WaMB1FwtTl4MzFM2oqPsXGSuEdF/qNLey+DQGk7y6c5AYzwZjU5IOfOdZDKzhAWc5SNqrQCjRa+6+cnBErXVOZ0n9zvY85cRsQQKID9V008/52spP1oyYw9puoxtuq3m81co4wA0O723Jng8AXp8vrZCbSrx6oxdza7dKdtgLBmvGko4Lr37PXE1wj+hWkKO85CXbkb9rAHnRohQ+KmWPuCZC1CPMT/gg6+n0uEaL3xbcM/9MkINMQLSzEUsNWfNAJ0FLLPpDcNvpn7DxjG0CeHN9YaEFQmIJBmnYNIYIJtDl1KWXasGj/2LD1GU/5V+22q5HQPlSCaaKUrICMmDsfOMgrVDam2dsPLCTXpM9Fqcdth3lML6JHCPCi92tMHQVH2tKqXoR166Kxj4dVFVZCNWiNv8QPkxmgFISoRMg4Y0dVfjqXLpifulhmKmh23wuZb+/63Coq254=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4c64a3-8b1d-4d08-9ba7-08dac523f3f0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2022 03:05:43.7724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1Nde8pKCmFTFOO9s5KbUYCeLEA3kxBN4nkrPeFXFRp13vXg+r4gheaOveZhZjHtCoMcTAhy2dcakC9R4Vylmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-13_02,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211130014
X-Proofpoint-ORIG-GUID: onK_Kpi5daRgYH2hUoJLnHi0FusfOBQm
X-Proofpoint-GUID: onK_Kpi5daRgYH2hUoJLnHi0FusfOBQm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/13/22 09:32, Qu Wenruo wrote:
> [BUG]
> If dev-replace failed to re-construct its data/metadata, the kernel
> message would be incorrect for the missing device:
> 
>   BTRFS info (device dm-1): dev_replace from <missing disk> (devid 2) to /dev/mapper/test-scratch2 started
>   BTRFS error (device dm-1): failed to rebuild valid logical 38862848 for dev (efault)
> 
> Note the above "dev (efault)" of the second line.
> While the first line is properly reporting "<missing disk>".
> 
> [CAUSE]
> Although dev-replace is using btrfs_dev_name(), the heavy lifting work
> is still done by scrub (scrub is reused by both dev-replace and regular
> scrub).
> 
> Unfortunately scrub code never uses btrfs_dev_name() helper, as it's
> only declared locally inside dev-replace.c.
> 
> [FIX]
> Fix the output by:
> 
> - Move the btrfs_dev_name() helper to volumes.h
> 
> - Use btrfs_dev_name() to replace open-coded rcu_str_defref() calls
>    Only zoned code is not touched, as I'm not familiar with degraded
>    zoned code.
> 
> Now the output looks pretty sane:
> 
>   BTRFS info (device dm-1): dev_replace from <missing disk> (devid 2) to /dev/mapper/test-scratch2 started
>   BTRFS error (device dm-1): failed to rebuild valid logical 38862848 for dev <missing disk>
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


