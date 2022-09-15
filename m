Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCCB5B965A
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 10:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiIOI1o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 04:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIOI1l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 04:27:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061878E4CB
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 01:27:39 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F5WP1R021818;
        Thu, 15 Sep 2022 08:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : cc : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=EsCQE0aItO27rYJTqngtnlDXEGwD7SuXZNJvbxNWEcI=;
 b=fh2pSeT3Vfn4qPo7+Pd4eSoLtWDpB5VKNFEP6YXEmnSi/WjFXKkJ3SINo2OZ6kLgfn7b
 ZosSyJ2HOlzj5To1qWal8qFfd3u9WyTl1KMpKfjOujXM78HrXPOhBiI0NdCbbwiNeehA
 SV8Pe66KYoBIkSD83nhcmj1NwTGS0xaYINDBEBQX7anaEkQIdRybWHOQtAC1jUtF3K4N
 aYQCC8ZVq9SWerlia8cnz/X+NLzWGK9LYWRnaQE//G6CFyG8PUi0NMDewlx7kPSnpsy5
 I9W1YsI8VTGVHcRMkMgMrPS1ZlwrhoOza1dGhgDmDjII1RsX1YNk0L8TX9jCSbfQ72RI xQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxypcgg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 08:27:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28F7qHbh007321;
        Thu, 15 Sep 2022 08:27:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjy5f2dy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 08:27:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1uQxrHiAk833ksRZFpjjSq3/3VhYbkGRU9l53SLqwPQVqoBLVJG8QvZ6lcVUljsvlszpOlso6ouF1ZterT2oFwy53f9Eojn1VgaWI9isB9IfEyl/LlFBC9g5f0h49nf8RrWJ/L1vje3I/rgAx9XRQ9Ck2M3GDjpkkRlXOPHU130K5+/m4lje7QT5v1VFE+rRkDsvBnhqLDzvpZ0PQDnrB96v5vBcCumALJxmRlpyriB9v7tIlegy+3epnfAGmDtGOkfQ8Tb9dvysTqG6B5L1Hq12JNO/iYaZUN+XhcQFdWb/XKr6ErDztyrlohdo3bjhWWteiLs2Ce/eRoKP6/8hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EsCQE0aItO27rYJTqngtnlDXEGwD7SuXZNJvbxNWEcI=;
 b=Gv/JHBZqm4ihefHx0AiK9xrEt+HqbYS9ZzGRMnBd3HPMegST6feS6zI3e0Nlf0dl2Gf/RZXhC8yW90ZUiJb9lr39VbG1FiqaYhCiCdqUamf0cRyyovk4RuWnphhibCslsWocYtB+2w4p4OdyPutAT0TqfZ/zHZ7QDKjdeKQVdnxyd6Jcv1rt0AxMoPs3YU8kf+0/rJ22ukxm5PCearuSP3BgIhxlsqfv35hExO+3essJBMWrcU14fTsopqquxOalDj5dDD7YeDnAVd4UCA2M7CwZeZ4zun8aKZ33yEq/0gx1ceBjpbThKR5XQPekSJEO9NNJoEqBb/xzSdOsOEhK8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EsCQE0aItO27rYJTqngtnlDXEGwD7SuXZNJvbxNWEcI=;
 b=KafLmHb6j+mFNn+cIz42UN1dXfUy+L4O9ONB8g0EeBb4jo6g6tb/W/1mJ4Sw1t7SAIvUY8KMRwg2Yx7UntaQJk8Tcum29a0vg58ATeDCDxS/sqNrHSqTNQ+P9/l5miMBu33cCNH7uU4Kbu3VnWa+vHlOwFBiTfax9aoB1kMN6tY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB4877.namprd10.prod.outlook.com (2603:10b6:5:3a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 08:27:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 08:27:34 +0000
Message-ID: <ae0b8a5b-4c99-6faf-a117-5a878b63c08a@oracle.com>
Date:   Thu, 15 Sep 2022 16:27:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 16/16] btrfs: move accessor helpers into item-accessors.h
To:     Josef Bacik <josef@toxicpanda.com>
References: <cover.1663175597.git.josef@toxicpanda.com>
 <fbae95250ef7879e8b60fcf2b7fe81d42e0456b0.1663175597.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
In-Reply-To: <fbae95250ef7879e8b60fcf2b7fe81d42e0456b0.1663175597.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB4877:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e994c21-64a8-4414-93a5-08da96f4239c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fsEWOwjk90JaH8dkydXfMzzDSJAL0Jr+o3mCY75ABo3PCCORjKgT/SMX3EHdFZFYuTMd+/qyAVCrdCeFREG14ljy105XKqhdFMAnsqhDW9iIhU3aA7BR6BeCkqsOLDI9+D0j32nUSzMnRomuakfKiwdzMxqf3Gc6ACzPQzTE+4eKEhsGrDpMn7Wg7pNgzGFH9qeivi605TgKkxHSF3YbTzSNgewMrdBqtHjGlojDCDTpyw2EjtyoPUuSpu8qYCsQtwrn29/MhKSq3cT6ZpWkBL4fLM7JBfGJeQnFdJ9pznR9yi6SAjK2yR/3q4jjswSW1JcbZydvgIhAtPDnUvIW6nLsV+VAoXBMla4d+hdXXYVIwF1pUUoG3fn48acMXK7BdpsqIAj/U8eDzpPF0Rpgg8tTs9SrCQWXs5cqY8wCwGvduNK8MPiqwIiUHZYloUbI6v0gxJct5d+AbOiBPaUE/65x+0ijFK2oKbVJCAfH/3XtcEbdWOsoTPOfTWxhokVxpB1ZdEogQMs1eFNtzpK2EPEGdnUOY6/BNwKVMIqm5KAjh7roqpN5bXA1TaSwevoujWHRWO5dGa6M8eNjzIgTVVcFp2vlbYeWCSAZOrDKhFjHRD6AcnuJff01rsKpOvLma+38IAYSxVW3whGeJEL3jewe4lU2bdDRb8r/HPxqLcr5KXnVJ+1AdG+hGEneE7PmxHJRY2mAnrDiYR0lnaGl1FPvI8CdQCcj/wzlyQUeUvl4JTVepupaiFSZuEDnXvUBNrQts/jGXhmy67r77/jpkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199015)(66556008)(66946007)(66476007)(4326008)(36756003)(2906002)(8936002)(41300700001)(6916009)(316002)(31696002)(86362001)(8676002)(6512007)(26005)(53546011)(186003)(2616005)(6486002)(83380400001)(38100700002)(478600001)(6666004)(6506007)(44832011)(31686004)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjlKenV4Q2ZiT0dFM0wyR21md3dFaDI1QlhkcU8vd0kwWEJuR0R1WDFFc1lk?=
 =?utf-8?B?T1JRV3lkZGVxZTlIQXRDWFA2R3FUdjJadEY5Wks2c05EaDFsZzF1SkpOWUd2?=
 =?utf-8?B?TnQya2dLbUpqUXlOeWxYZkJVN3hvdzY5NnRpbzV6NUhKMVJLREdORWhtWWd0?=
 =?utf-8?B?NEpsbDl1UVZoVi9oNEdrT3ZkMG5xZ0xTNnVieE54UExWYlBER1pJQTlrZEpX?=
 =?utf-8?B?Z0RkNFRPeWVjc1VaT2YwMStGN20yVmFMY3hVWkpFY0lCVG5TM2ZIbzVzMEp4?=
 =?utf-8?B?VmNXWmx5ZjgyNXpIWW1CY1JNWnpkVHZtSVJhdmR4Ri9NV1lFNW4xcWZRUTQ2?=
 =?utf-8?B?Rk8xekNQcVp1RDJJT0FTK3BwdGJPOWFnQmpDbGR5SGIwMDA4bjUvWk1QeXpU?=
 =?utf-8?B?VHkvOUcyUElYTWdHVFkwNUhNNHNWNmp0ZWwxdm9TL3dVZ0Y1QnN6ZFo2VnZ1?=
 =?utf-8?B?TktxV3FjbnZ6M1ZHMkRwM2NweFFPTTJmU1BKdld5cHVqYkJLNEx0cVZzWGJH?=
 =?utf-8?B?U1RHdkVJcmFSREliQmNkSktmU0VGcUExMm1rWEc3THNodVVFTUxHbVlZK0Z6?=
 =?utf-8?B?K1EvYjI5M3dWM3N1dVp6bmlUcFMzV1J3TnRDQ2dPeWZqekJQYUNLUjNyYjhJ?=
 =?utf-8?B?Q1pjNEZ4ekY1UWk0czQ0TUc1dmhYaUpWdDdVbmdCZUpIbDRIVEs2ZGVrZDdu?=
 =?utf-8?B?T1pYcHpsbE5ZYnk4TUZIWTJHdWREMGltTUYxeTNBOHNFc3lzSjFoaUJVa1pS?=
 =?utf-8?B?eDM4UTY1dXZsQWtNcXZtUVBIK1FvYzRxY3FHMXVoUlQ2MlZIb0FlcjFTbjBp?=
 =?utf-8?B?K2JYZzZEVUYrelVTZzlaYi9xMUtpV29sRCsvY2JZRm9LQU1Ib3M1TUFTYnJx?=
 =?utf-8?B?RFYzZVVrYlRjZGYvL1g3SjBFVE9EcDNKUWlDUHlTQzBhcjZrUUlDbkhkRkVk?=
 =?utf-8?B?UzVSTDhuRy9CNmtWMGZmbXRkRzFOdDFBTzMvM2FMY1YrbkZzdzRPclJXVThl?=
 =?utf-8?B?K2F4M0ZWVTRHMklNZXVITk54NUVsOEFVNHZqUVIzVU4yaVVpeU4waTNoU3Q5?=
 =?utf-8?B?dzhTN1BCOWRqQlVrK0RuWVNzT2QwVjZVYkRUNExubW9wUXhBZEs2Um12R1E2?=
 =?utf-8?B?SEJLbVdzbDVJZC9zeGd3ekxRakRGcEY3NWlBYWhlM2ZrbHk3L09KQmdJSHVz?=
 =?utf-8?B?S0dtdGFGZTVnMDhnY0dudkZOT3FtcWpPZTZwRG1WeGFvdXJvalFQUlJuUWtu?=
 =?utf-8?B?WVhiRzloY2hpblZvbG1pMEtZaW4zQUZxUTRyWnFnZ01nZE1XK1ovckRjSzFh?=
 =?utf-8?B?amFsdlZNbUtvTktTU1ZvVDR5d1lDUXlMWGlYOHVhcnBOR0ppdmNXejZiUFhS?=
 =?utf-8?B?bUFvZENWZlV0YTZFZXBtbG12WExCTC8zSHJsZGNHQUlBNGVLVzZPZ0VZaFhn?=
 =?utf-8?B?VGRBVTBWMWUyK1Nhck04STltSjIyWHMwTGYremtKM0NGUmJ2dGVzWVBqUE1n?=
 =?utf-8?B?aXRSNllyMjRuMHdnY3lqdHV4TkJvdnRROW1xZkdiTGNLQzVNUENlcW5UYjdV?=
 =?utf-8?B?bnhmM0s4Uzl4OWkwOC92SVh3SkdHMk5OS2ZyZVk4RHo1WkJaWlgxckNyRkJI?=
 =?utf-8?B?T2xWZU5zN0tPRVZmQ1QyaDJha3pTd2RucmFzaTNtR2xKZ0RGU243d0hoRVJH?=
 =?utf-8?B?YTl4bytYMitoeERFYWRWK0RZMmRlM3FvUThRS1E1SXc2dFVCc2lUaG5oMW50?=
 =?utf-8?B?OFNpVHRGSlo5SCtBOE84MHFKcUVpak95dklMZXZZWDU3YXFhcWdwRjB4dEVP?=
 =?utf-8?B?eWplQmI2cU4wSlVpN3Q4QkxLNlFIdER2ay9MeWcwbVREZ2c2aXhQSlJvLzZp?=
 =?utf-8?B?R29pKzFqY0t6MGRXUVRMc2FNWXg3THVPa0Y0aVdPZXFuMGcxbCtET3VFbmQ2?=
 =?utf-8?B?dHd3alpXRzdOZFdqSXFtNnQ1WVU4cit0OVFzdU5zWGRYZ3FyWGF3TDJWcXR2?=
 =?utf-8?B?dWV2RkxoMkVjREhJRlp1bm5tUjRaQTh1eEp0dzZVZ0xRZzc0Q3p0dVJGaENl?=
 =?utf-8?B?Y1FXSXFnV1dQWGV4NGdwVWMwbGJuYkhUVjNHbmFnK05sdndGSk5ZL0xiTXdz?=
 =?utf-8?Q?XEscQUcIqFBJ7HG782b+hUW6h?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e994c21-64a8-4414-93a5-08da96f4239c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 08:27:34.2965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gXa8hE4KmsOfJarfBVXgpjqQrP/DCykHxTYKmdXBd9jnFsw8i2ydBXFIN3t9PxC8ScphBUSWTwWofpe38IHhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4877
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_04,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150045
X-Proofpoint-ORIG-GUID: GDwaNmKfcyZ3Ue74_k8cQY4qoDzwGISf
X-Proofpoint-GUID: GDwaNmKfcyZ3Ue74_k8cQY4qoDzwGISf
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2022 01:18, Josef Bacik wrote:
> This is a large patch, but because they're all macros it's impossible to
> split up.  Simply copy all of the item accessors in ctree.h and paste
> them in item-accessors.h, and then update any files to include the
> header so everything compiles.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Josef,

I hope the patch series dependency is correct, which I understand as below:

------------
[PATCH 00/17] btrfs: initial ctree.h cleanups, simple stuff
[PATCH 00/16] btrfs: split out larger chunks of ctree.h
[PATCH 00/15] btrfs: strip out btrfs_fs_info dependencies
[PATCH 00/10] btrfs: clean up zoned device helpers
------------

However, this patch compilation errors out:

-------------
/Volumes/ws/btrfs-devel/fs/btrfs/locking.c:98:52: error: implicit 
declaration of function ‘btrfs_header_level’; did you mean 
‘btrfs_qgroup_level’? [-Werror=implicit-function-declaration]
    98 |                                                eb, 
btrfs_header_level(eb));
       | 
^~~~~~~~~~~~~~~~~~
       |
-------------


It can be fixed by the below diff:

--------------
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 9063072b399b..aa7aec25672a 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -12,6 +12,7 @@
  #include "ctree.h"
  #include "extent_io.h"
  #include "locking.h"
+#include "item-accessors.h"

  /*
   * Lockdep class keys for extent_buffer->lock's in this root.  For a given
-------------

Thanks, Anand

