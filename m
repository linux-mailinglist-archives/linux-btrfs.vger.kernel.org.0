Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA5172B151
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jun 2023 12:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjFKKVi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Jun 2023 06:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKKVg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Jun 2023 06:21:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8D61A4
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jun 2023 03:21:35 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35B4uf3x020550;
        Sun, 11 Jun 2023 10:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=yzE0iszS42V1UldcMJVH1WhIpHoJLjN9m/KENSZXeNY=;
 b=jxWp/gYmFu1IIHryC6e6kk40Wht3imYdpNWV/lsentXopvej03ULbI/VqZhrNzGge/XP
 800avyoaGRQNPGZgSlaDQn97VVyb/1Qvlbs0XV+wYGA/nvjfCB9CkOfUK/XEE/Z6rFhD
 zvRyoNIorARq7SXdOnMXpC4AyshqIZM5fqUZlGFh0Kscp+IFAtT0DEueKwxVclCARcnm
 L2bfYo9k8J9psY95A3B0HNmU4mBu4RxK0j0sUI61hSauY79UgYXMqK5K5JKd0iZ3kVq4
 PzWdqGnLMNjafKfcBvRJg+7UDjue9G+090ref3PwUJGKCEIIMir7qZTOYNkfzA/hCcwC 1g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4hquh72r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Jun 2023 10:21:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35B8T76b021624;
        Sun, 11 Jun 2023 10:21:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm1u3cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Jun 2023 10:21:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxP4zxtreTcI7rwt4IVx9G1HNqvrWm6wI5REQbE2E8Urw1Sm/aSYis3+bPBPf4PyjeQ3WXEBTOJTrqyIIMZfPS23piFLpgXHhH6jdU7NZfEXm6ZY3WH9ySMg15Z2JJapk1sMGkGJUjVJb4XECzg+4mbk/apI/ZmtjVrPO5DaldCZmJFdrLxUDURinjDNYmzEkJFl0sAgg4zRC7VTK0IWXWKpek6eBZqON1M7q7nZGq+H7fjNa67R6GvLrJ7LUPxfYv58aznhEvFDUQm6/pX3y448nHiSaztgdB1Oh75m7OqAZ/QsncswbWgTFaZi+EfBMIJKaAHGuaTyrnwNZyBAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzE0iszS42V1UldcMJVH1WhIpHoJLjN9m/KENSZXeNY=;
 b=HPCIl4pO25j/Q86WMAo6jILpvDa4H5iIQMjWvMZIdlPgPtQhRcSa+wjwckAxvG6e/AGKmEqVPaOag4FWIGVtmirIz7+JTYsRboA/jrFUg6bZapPIkUydZbt1q8rIlLTZgd2yesHzbjaDFbTA4p2YDXk8QDhqkUVn2h0BudyuDp1ZZaAZvyzhWOze7JGvFp4dKxTRptqWWecHlgF3e5tODXjpbxPCrOJdSnSDltPxf3Z6QdCEdsFtgzas63G8S7ZlrRCdJBN5dEEI5EqE0WoXxkAX8NGsRQCdKKd9Zaureyem5uNKcnFtPc510BGWy+jmEr8MC8HRQGOShIPA7Adilw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzE0iszS42V1UldcMJVH1WhIpHoJLjN9m/KENSZXeNY=;
 b=uhR8inLJwzTqaQoOQXqUOYzguAKrQ2gcScg8C2du081wZH+i9d4k397ssrcxk2P0aOQnlJhAm5w1PgjBJjlS7wZLhvrliFLC1Zf5kDIDAS4qoUj4qo//+pvAV98cMk1vzotZqz6E1uFZAUfRB4zxYa9/znrxvuveBpB6juWbWQY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB5887.namprd10.prod.outlook.com (2603:10b6:806:23e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Sun, 11 Jun
 2023 10:21:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6477.028; Sun, 11 Jun 2023
 10:21:28 +0000
Message-ID: <ed152181-7586-03c8-d978-eb1445ea72a8@oracle.com>
Date:   Sun, 11 Jun 2023 18:21:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/7] btrfs-progs: check_mounted_where: pack varibles type
 by size
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1686202417.git.anand.jain@oracle.com>
 <20d70d9b1ab791c796c73bfc84c23abe956af52c.1686202417.git.anand.jain@oracle.com>
 <20230608123833.GG28933@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230608123833.GG28933@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b935a28-0578-4471-2c97-08db6a659e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rM/EaYbXbDEsKI9VTPMnW+dw4LWf1iymHCKcl9Y11X7IAd6rs792de2et+NC3MTl8QBfjsDFR8bCTXj5eGuSuBFp8ktXcFnivg0xc3Qhwq7ZIX4Nlj4JYlrjzmwBorFUUCYaA0+dcriYz5psT2j4GpCTACLvk+VotSiqCoLJhObSVX1zlQWHtDMcQ4QARlGS3RUnyUUl/sOr5T02vVE/OMesyl+LaQEjbFVyNFL+aNJn1hfULLOTxzlDurbXlVQUm3eKzGGvs6GlSuOSn35vQ/F5fbUM8zd+c7RVmmbbf6W+eghRNsUy9FkWyGUvqiL8vneEidwp9SQh2alnH8yZmst+dKpyuTUIyA4rd3vZOUSdLjmXXt5nheYwM2o2LTxCaIVuNnuRdmdYMzvgaCUB73l40iE5vzXN5NQnLpriIMl6yruELd3BZObQX66dKtc6G58mRdtxCIKAm1Zo/GFp3binJLv2htvCoYF/v4mPsZh6q+ZiCg05So4JoHpKJsCngxOqU2hw/LQW2hxXeamK5WICtq93jHMTyGOXMVCwRsb8B1o0y7HSpaYibFzY6KSdBNkBwgdb/KJVH3zudc1JtsGyHRo1qKpdKQMbCvsXjDjjcmdaBMUrAF7EqxnpcB+GgfrsH3GlmwLTy0MkQxHB6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199021)(86362001)(31696002)(6486002)(316002)(8676002)(41300700001)(83380400001)(5660300002)(26005)(38100700002)(6512007)(53546011)(6506007)(6666004)(8936002)(44832011)(36756003)(66476007)(66556008)(4326008)(66946007)(6916009)(478600001)(186003)(31686004)(4744005)(2906002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emFoV0ZFTk9ndkpPZllUd2hEaGZCbUdjOHFWZnNKaWZac0VqQy9zQW1pSEM3?=
 =?utf-8?B?Ti95K3YyN1ZYWUNsc2NsekNxYVdVZCs5Ny9NYUxwMEtHdWIrWWZTVkJNcVUz?=
 =?utf-8?B?OC9DY1gxSjE3OVBtOGdRa2ZTamM1cWxXYm9GQXVrMUNUWnRwSkVaSUNSQ3I3?=
 =?utf-8?B?ZEsrTjBGMUhncDVEcEV1cENsbGUyYVBJMFlycXFwbHVjeDFjd010anpVZ2hH?=
 =?utf-8?B?YXZIWHlnRkpuditJK1hvSWtPalFaR1FKY2xEVVFRK2pUQ2VXYTVVQk5yaERa?=
 =?utf-8?B?Y3YrSzFTTXd4YldKSXEvWndJemI4QTdKNnl1RWNSMW1sc0dPWU5MUTh0aEhz?=
 =?utf-8?B?VENIaVVnbkFTVys5bVU0T2FlRWoyRHE5dmt4S3hLT3podGpMaVh3c0xzTWRO?=
 =?utf-8?B?Y04zZWc5SkRJU1VJQnovTnd4NHp2b0pBZk5pNUZHb2xPTWpMVi9mZ2ZBYUVp?=
 =?utf-8?B?eHdLdmMwMTdTV01kYjFrS2VLYjdxQTBsWkg3RFRPU3o3WXJudHRpM2VsWkJI?=
 =?utf-8?B?UWg2STRZa2ZDeWU5Yk1NTDRuT2hialpkelh0V29yU2FOK2t0RnVYUk0yb1kz?=
 =?utf-8?B?dGFpd3kwb00wREFHOEtBUTdtY0tPaHNuL08xQUR6K2hleEc3akhHdjh4WG16?=
 =?utf-8?B?blRjK0pDK3h4Y2U1NU9jOFJheUU2bTRRMHRVQStpU3l6MlpJS1NLZE1jWVc5?=
 =?utf-8?B?UWFVamZXbURNTXczSTdSZHQzYWFRMGFnc21NbmpIaUNHeDkzZngyR1RzamJp?=
 =?utf-8?B?SEJzU0ZSRjhDYlJ0L3dkZmZJVDdZakdoQmIwS1JPSEdoU3p3L0F2cTNhb1FY?=
 =?utf-8?B?c0FITXpUaXU5bUtkQ05xUnZiSXdLMUxscFBzOURkSXNZK1FheFZyL2lKajNM?=
 =?utf-8?B?VWxTSHRkUGc5OUUyVmVmY0FZMXdiVWZJNG8xMWExWDlXR3RzT09zLzRsZmdH?=
 =?utf-8?B?bW40Q2NSSTUzMllrZzBScGZkSjRRbUdxSzE2N2xTaFlJdUM2QWJQaUZFOGh3?=
 =?utf-8?B?OU11T05YbVIvWXAwdjdhejZIYVgzbWk0Q0hGdTZ5YlRXNjErenF2N1FUcm5T?=
 =?utf-8?B?ZVhsUHVJUWJWdHFHOTJCRm5RTGxWTVFmSGNyd2g0WkZ5cDhsS3FSSkE5MG1O?=
 =?utf-8?B?MnF3Q1pESDZ4SEVjOENoMU5zSmdLcXExV0tEajVjWFZrZUVoeGsvUEJrSjBv?=
 =?utf-8?B?MUQ0YUVPZVhiamZOcnk5Z3dWeXJSUTNUK2ZjWnpBQzRqRE03blVoZjdJcmp3?=
 =?utf-8?B?VU44czU2ZHZGaE5taTRkbXF6ZGwyenFQdHZIaEFydC9IcEZRc1dMazV6Z05a?=
 =?utf-8?B?aVRoQVZ5Mk5xK0NxSG80VzdEUHNXYjYzN0psWFFMd1pkOUJjd2tqSnJqM2pk?=
 =?utf-8?B?R1VENE1GNzUzNXJRczZoZVljSUZBSVFmY01uQkl4cXYzRTEycUlhSlhpNXNQ?=
 =?utf-8?B?NjlJZGFJQ3VPcFVMcUpDN0ljRFYyTkVjOWhmM0lseEUxaEJRd0JSZW1yK2VP?=
 =?utf-8?B?MytUL1pvRVpUYjk0Y1hLZjRPczhnWTcwb045UDVtL1ZDSDN1M3ZldnEyYlNa?=
 =?utf-8?B?V3UxcE1Zck5oYzBqVnhUcjNSZGJKeGdINHVQdkxPUjJjV3A5NGRGSHFHZUVO?=
 =?utf-8?B?VlVXM1FCN0tYMXNpcnBETHlybFZTa0VQZ0RTekdHUXhDUlNjZGUybkR6Tm56?=
 =?utf-8?B?NkQ4bElRR0xaWVNXayt3MU1jZk5WVGVwRzl4U2twZVhiWFdNZXcrT0RRQ2tX?=
 =?utf-8?B?TUwrQUs0RThodXpyZS9tSDYvdzAyNUhCTUNNZUhEMzB1K2hRQkNqVUNLT1Yv?=
 =?utf-8?B?WmhWNVFlUERtUDhvYm1aTVNrNHhWeDFKSjgyVkxBaHJuNm43dkxiSUhkNDdI?=
 =?utf-8?B?eVdKbDgwSzZQWVN2aHBxRG5JRVFMTnUvenUrdnl3d29vUjlXdjdPa3hwQU9s?=
 =?utf-8?B?Ly9ITHVibHFaY2h6eGUyaGR5dnFYOEMzVDlsMnVHQkVTOTRGclU2MDg2UUxi?=
 =?utf-8?B?bzMzQUlLeTBoQjNIVUJxZWs2dllOS0xXSVN5aWQ1dng4bERycWU4QkFtSzJO?=
 =?utf-8?B?ekdaTzZWdzF5L3lHT2pYYjRFL3ZjTDlLMHRRNCtQenBRSG1CWGlnMEwxUTg2?=
 =?utf-8?Q?7CBtPv2FOVUM4HYbD1Lg5Wxp2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: f2vueY36OTKfdxb4d2rLmU5kQTraevvteWexen1muZFpfoEXid3kdBnR7xQFdy5lzU1lcTWVCa0Y1KDX0AMvuuDk5kCN3J0buxs76BGwNxYGQpUQ46XAvBKfPcbgVrM9h5FtFYqUMfRhJ7j0Ipul8UrZBzW3knMWTZyqeZb/YRu/GVdUm5xi6QPYND9fdU39cVRko9rCsyLpVhJ9lLI0apAkuUNpQP2cHWL2OMvueuLY5fZkIK5v/ZvoAvJ88m52xaKwuJCXUhH6CZ3nAuo0wrlDB9FLXKbRKD0vo6js/eYDt0VpDv+iCk5+c0RJ0FaykYYe99F6J44BQ+7gs10IBPebGXE2m3I9PS/FKcX0xVk0L+gss//f0Z2apHt6B5nM0JlH3FrCLbxKikPGoCkCz20BwSx6An/3qgXu6fj1n4yra/+KfOlWRDpykd8aj27LnEcSRl+abMggqYkrlfcWE4BkBUtDnF6KxniSOiiypW5qV5WceHNo0OgDSujKwMUzlm/q47DdYQOhwST2tPyn5Xu6TjEJeUc7ZUW1cFPfVGHBFVexP7kwu3gouiVavMwXpYHphrrB46R6O0tzHGew2i6ffGDi+zDz5mtgUzaMWWR8JIRtxAt80Umz/szz0PFqj80a+t9L8uDyxSSR6IztzF/0+DG9R0MAQASNLryjB8yNuVjAlGsTDdwUbpRBuxEebKDxqD/+O/Fstm7wrpp9dA97VpNSld9BjIUBu2OxS3yI7T4yN4sQ5klYWP87W8fLvDAL90Cz48zf6o+9kEj/j7WEI+6VU3FGu5weD8eKN1o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b935a28-0578-4471-2c97-08db6a659e13
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2023 10:21:28.2321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVKUvKlI7DPONoIAMhYLW0ehF4nzzvG37qPXwgDd34XWUWGxCxBdXlRJhxHp+LOlJxfHjNBzZHWOkAN1qpp9Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5887
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-11_07,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=804 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306110093
X-Proofpoint-ORIG-GUID: MOWORSf2y0nuFl3_Nqnzfn04cM9zmESo
X-Proofpoint-GUID: MOWORSf2y0nuFl3_Nqnzfn04cM9zmESo
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08/06/2023 20:38, David Sterba wrote:
> On Thu, Jun 08, 2023 at 02:00:59PM +0800, Anand Jain wrote:
>> Pack variables by their type; it may save some space.
> 
> AFAIK compiler does not stick to the order defined in the sources on
> stack and is free to reorder variables or completely optimize them out
> so I don't see point in doing such changes.
> 

  Oh. I don't see any point in packing them.

>> Also, fixes a line
>> indentation.
> 
> And we don't want whitespace-only patches unless it's something that
> really annoys us. Argument formatting is mixed and as long as it's
> readable it should not be changed. Acceptable styles are one or two tabs
> or align under the openeing ( .


  Got it.

  I will drop this patch in the next reroll.

Thanks.
