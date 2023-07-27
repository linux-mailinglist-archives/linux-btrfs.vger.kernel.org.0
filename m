Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0BD765594
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 16:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjG0OJo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 10:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjG0OJn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 10:09:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2B830E2
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 07:09:38 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RDL9eP005181
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 14:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+ckkWbzUA2Zhfg7vdF65BXOPASa/uqUuXfEZnN4VTWM=;
 b=Z7J0zuB+dW3j+q3IwENBODogha+dYbcG2+8R1Z6wTcFKUMXp/liT+BNWAao0hErKjqQ8
 6YPw5OlI9HlNvzJu0BISxZOtkdSGTUlIAm2VkJC2qWEIGpz0Z5AkQkYXYdALkwflJlGG
 Vgk5w5llAvvrsm81LmPPsSm1sob0av+Yflk3RhdRWnXKxNFr3Zjo35f4Rc5VSqAp3RWz
 xe8vM73YQ79s8YM1//YADbaiTdmLVYeckmk8Vk7f0A9oKZEH0y7+LiLkXRGh4RZfb2fk
 xBhSo8QucqOMTGkejGQfaP/o52OlQDqKhehI9lUtXvhrX1fBlxIncD1WiI8Hl4tjSIdV 3A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s075d9wbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 14:09:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36RDdE05022970
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 14:09:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j7pbct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 14:09:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFGuoJO6kfvTzKUwhxu0viHVmUFVsNu3Gpca2kCCamP+7iH0vpm1Q3pQRUezGfrkb/VpNF+AnvsK6P3yHji414OuHaK40QZUiB+DmXQ/dAUtcUIxcZKuJqSbmETlq1Eq1e9l61ciw0KoTfM9JII1CcnTAZAspnI8UJ9mmkmg0l5K5C+a8KxoQRS3ncnXR1d2vWhEqGVY9QJwajQMeTjJo551qMGX3GrPYcNzmLA2IYf6LfhhqW4d3628k4P5+rHuV9kaQhLNcxlo0sXSk1gd3tv/h9aRxV7nSGOFwNuT+KyetKWKHmjyZFywkYYtM4CombI/tWnDg/D9AgtbMydWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ckkWbzUA2Zhfg7vdF65BXOPASa/uqUuXfEZnN4VTWM=;
 b=OR/MUushiZzYSn3wATARABM2za/ES5VuknzaDJ8vYnXPJ/6SiKWjtsFYQ+L/XrkT5+bIKZusWY4QIWlD0quchfPRdcUbnsOzGJsVKzHQNpz5SWjrUftUh2It4KMcH9+kGbZHownCvSSCk/xwFekv7As+SQtg7DFYuaP+S6xFnLgFPzg/Du3jea31NSKbIe8tKDfS71K26dQoK8HUDMPSwLQBNLf7TmYrPl3pCrlTErQTnQGMTrgz86rASZSZTXRYQZsnwKYkIvQy5f0Zeq+xMvHcuxR9GN89kz8cHZcXCM3bY/IDD1PyzkQGEuA+Dl0mwrDFKKZ6lbP29ctouF6M4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ckkWbzUA2Zhfg7vdF65BXOPASa/uqUuXfEZnN4VTWM=;
 b=I7+j9GT2bCidvzdoRLtkBKyCKaDuSm3H7OMOFhzNOQlLPgU37q0wHhFeg97th9/8IBJKcn/tFzDS3PBPyQVNmN5KCexHxaNHieIrKnTnK8Qt+leFDwsVv6idZoMsglejZz4prOca0Aj3ji8VbOQP83wcBB9GsC5GBM1yDgE4EwU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB5237.namprd10.prod.outlook.com (2603:10b6:408:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Thu, 27 Jul
 2023 14:09:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 14:09:31 +0000
Message-ID: <5c423aa4-140f-aac1-f97e-a60e29b3f8e9@oracle.com>
Date:   Thu, 27 Jul 2023 22:09:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] Btrfs: improve message log due to race with systemd and
 mount
To:     linux-btrfs@vger.kernel.org
References: <41c08d979d1d994803317fbfd98fe91c1e9f6b9e.1690465916.git.anand.jain@oracle.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <41c08d979d1d994803317fbfd98fe91c1e9f6b9e.1690465916.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB5237:EE_
X-MS-Office365-Filtering-Correlation-Id: 2653543b-48e0-49ea-bbb8-08db8eab18fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSU/VAFOdxc2sP+8aJzvZT6uYZDr+1+VT14/zMQITzS44HJ+0KBWl8RV7YDicCYpUqSqWfPtbgEdsMdgvYY1VMrvOAS/+B3B8OEPMeF9qcz1CNVuLsc6FVq63Z4+3TAG8LAiihYbGZxYt79ReZB6We9KCohDUV1giicawq+HJDOUYVDHk0lfrfQlSz6FqXqdLfFZOVbvJlVoO0SEd33FqQzYULU1iAQjKsMZdc7d4UBv3glyz0vmZGLD+pmLkbH2fnvJNIjzx0q1QsBLdvJ+80RrDK3SVGr/d59qJ2p7Sr1S4VUTAy+n7uCLEbXNJTuOoUG0vHxMPSn4PYREZ6cYejat4kaHocIi57fNhNLqZLFPDoNWr+VBnozb/26ocDjrwTXOJPLGUvLeUu1/1nOdjCIvXfXs+Shz6YE3f2wFaS3MNtwgVwuTI3ZaeV3Jnk08AZWmL0h5/c/PShziMfGkhiA+gMfXXM568NwH66qI5w3G4sL6Kb15ALnmwAj7QqBF98Jp2ux/I+sPNBLDu/GY+PiEaRmjSwBir5KdUjiaPhlP6aeYcB0QV2iIaxROpL377+F1joA0Kv3eEkwLfOSk4GanyzkXmJJ0XTEIiZTCPg21ST1LWfhcccoUaShiM2mpwcoGQtpBQpi8FzcIa0GlMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(31686004)(186003)(26005)(6506007)(53546011)(6512007)(478600001)(6666004)(6486002)(83380400001)(2616005)(66476007)(5660300002)(44832011)(41300700001)(8936002)(6916009)(8676002)(36756003)(66556008)(86362001)(15650500001)(2906002)(66946007)(31696002)(316002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejhRY1c5eUpMREpsaE41R0h3VXpQemJ3c1RJb0tUR1JWZWZ0d1VNaTM5eGZX?=
 =?utf-8?B?bjgzNU8xUHkxSlRKUm5STHdwa0xaMDUzM2VrWnBBTlNPUzBLMXJab1QwbGx2?=
 =?utf-8?B?bXk1SXZ5N3JEU1htN0dRblRmQUI5alB1a3VzZjlEcVc1MkFLUTVraG9YOGhY?=
 =?utf-8?B?NnZLaVRPeWpzbWFGc1o1cjZXbmdlbWFpU1RJUFUwSUNiUXYvWTcxZk9za3pw?=
 =?utf-8?B?RGNMcTArcjdjT1crRFpDM0dOTURqdmVZVDVKbzJ1QXZvWmJFWHpFT3F5NStX?=
 =?utf-8?B?YjRXT0dVSXhxNEliREkyQkgrazQwS0pkdVNBNDVkbUtiemgrQ2QxMXF4UWs0?=
 =?utf-8?B?Yjc4cmdCOEtQWlErYjRxNkFwNkp4WS9VdkxwWm5tckgrMkJuUW0wb1JBSVJX?=
 =?utf-8?B?N3ZYaDFzcjMxWm52RmxZMC9aSktrVERJNjUrQWtxOElVekdXa1NleVlIeGpW?=
 =?utf-8?B?R0hLYUJwSXpoaWlaVTNkV1NWMDVVZGNQeHNOSFRaNFNhQ0tvaHRVdXNNRnpZ?=
 =?utf-8?B?ajhGME0wUlRYdGFOK09DWjBJSGtNRUdiNU5YdWRkdlMxN2loVUZVSzZ3aTh3?=
 =?utf-8?B?OGlIb09FOHhDUDdlNXpST2N0SnVETG0wdVBOWjRvUWwvZjlyckFQQmZYYTNj?=
 =?utf-8?B?aE05V0oyMXhFaTYxWjZzWkJiUzZ3ZTgxOVpNbU94d3pJQkNidGtJQ0IwWnF5?=
 =?utf-8?B?ZjB5SW1JTW1scGF0OUlackFHeXo1UGM4TjBBcW9iRlU2R2dPMmxuS1lyd0FR?=
 =?utf-8?B?MUlNRmNLb2kzSGMyS2JJK0lwU3AzMW9YMU52RndPSVc4TTVadUVudC91djZj?=
 =?utf-8?B?UFVkZC8vRVcweHJTRjdIa3JUOFBiVzd2NytVc1pCbFhjaVp6alRCM1E1bTNW?=
 =?utf-8?B?V1hqTUZhLzdaZjRMaXl5VEhGb3RoeTRGRUhGS1hQMTA3Nk01QzNURUluY21t?=
 =?utf-8?B?RTVQR0hwM0FRZjZsbngrRkREOGhaLzdub3NMOE9NZVRQUU4vR3k1d2sxTnFB?=
 =?utf-8?B?K1JWdGRVRkNrSi9GSnBEWmF3cFVoWHNDZElJZ3hYUXlnL2NKQk55WCs4NWo5?=
 =?utf-8?B?YStsTjRXZGNYRkx6VWc3VTRGMjRXWFBNUUgrcmVhYkE0OFdhV3hXTFBVSlI0?=
 =?utf-8?B?YU9FeGNBNkx1ZzQwaVUrMGorYkVUMFdVanNoNmFxODJ2WGdSYjBiR3p1bWdP?=
 =?utf-8?B?QmVEUFBlNlltYXB2NVlHS0pBSktKdnoxSGkyN0M1VEoyYkJHTzZ3Qnh2Tlhu?=
 =?utf-8?B?SDFEcHFERU1xbEpQdGNRWGp1dUlSd3NZYlZkQUo5bGJQc2hJOVRjOWI2cjhq?=
 =?utf-8?B?SmkyZ3hVcUQ4cjlFU0tkRytZc2lXZXovYlhzdFJpUnVGc3RCYlFEUXBxMkNk?=
 =?utf-8?B?K1BaeEtLSjJOcE5IcmNFdGZSRzkwdlNjeThlemcxR1RJbTR4NVhKdHNrV3I1?=
 =?utf-8?B?aUpLWnZMR0haSXUvN1RPSkJVNG1SeldKRHFpdjE2UzArMXpVTmRJV0NqMVp2?=
 =?utf-8?B?c0o4V2pZRTM5U2h5SDdNc0UrN0dxZ3lhVVkrUXFFKzNQWVNuOWk5L212Rytz?=
 =?utf-8?B?aTErMzJncHZGaHNrSDZmVkxtSmpGaUdGMkh6R1pkVUxOdHBRSVV5ZkNYd1ZV?=
 =?utf-8?B?TkNqSkYxWUNua05sQTNiclhzOWNsZ2JYZEdpczh5M3hwcFhia2tTMmtJS3Zm?=
 =?utf-8?B?cDZ4WUpZNUhQL2lSb1ZKNHcyOElNUTVSZzRGWXkvKzV6Q1k2ODkzRTczd0RG?=
 =?utf-8?B?TGZyY0VQRWtjZU5sNzRwZFVrQ0hXSlZoWklKMXVjNUd6WkRlWHppUjM1U29n?=
 =?utf-8?B?M2grcDdySHE0YnFRbXNybVlJYVJtQm82ZDF4WWZrcnVpSkxwU0dqaGF5SFlU?=
 =?utf-8?B?ZzlCY0tWbWl5Y1FqZ09nY0pRNVJRb1lOVVZLTHN3UWRDQkd0ZmUwNGNwL0xy?=
 =?utf-8?B?RUh2THFKdzZrUStGWmFkdmlTNDVBMndqNm1iK2RpVGxOK0RuN25lN1E4TUJC?=
 =?utf-8?B?ZTFtMGN3V1FmS09tNHJObXBQTjMxZFcvWlFMYjM3YU94M3E0d3lFRW51WGxW?=
 =?utf-8?B?c1pRK2pkcTJrVmNDWTdzV0RNdm8xVXFCY1lDV2lvWk9jODJHd2lVS1U1b2cy?=
 =?utf-8?Q?qWzQCv9QoXdfHbBlTno8rifms?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bvIb5vYFlht0teoX5PbD5eHpEcB3rV1L2xrpj+IRSFWD4dxn1T7nNtPjeTk0o4rBAjepzHYA2VF08GFCZCoT4Cs/ys/nsb/ASi7IuuAEJs1mxKJVQpaCDvGdUkAnchBWYxkoAyra/l7myRJoPmgf1U+hD7/ndzCaNWkYdpedRpi32vp60tQAA4bUNKDm4DZ8uDH5XnIOuzYLnQIo/kA29wIWwI00AdAq2MduyyExPOprXW01xXme1Ptj6Kiox9uq1T6RVGpWEtPbmNMkxN08z/2JUpwCPki1aF2v05gPJVRs/RqbdI73WC6gl/+w05DFj4/BTwpcLaLSToWUuzUN5RkHckbfF4JfiMLTi2Po9Oz95unqhnMRKEIClIf2jOUNhuWopvNQTUgR/nVNvap6gHXRyY1fPnzt0TGd7oethiA9eItZd3Iw+jpHMrLvRP493j1dWxq7r2LCA6QgKqnEiKw7ebLzxNebs7H1dkL3C1q4F3JwA3XhegoJo+VsODuGId69NNApVaH7KH3aTsUlpnQ5CzyTBNJGm9G//cID5irk7XgX7wLBbDB8/SFDZJ1ERB6OOktKx039efops6vEk4W+AO9gkoZUewXbSS17PhekmkjieR+OBNuIJDlsRCwncYAT4MrqCYG+ufOo3Pz6QzJ24eNStAy3cQe+GmBLlE03xKEZD1nVea7n05KAyhcuvRB/h9jzhDLO3Jd7o8k8/iKEfNiDqlKAVmt6zSyruhq9bLv6pIrHgY4b6hzlHXDRiVwJrAB69BWIM7AUn341UQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2653543b-48e0-49ea-bbb8-08db8eab18fa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 14:09:31.5657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GVZW+JLFnJ3JYqvLvdyntZq7vArgpluRA/p5G0DLFt/L1BUpuEWvaVhxvyldalIzVaMCPd6BCywIObER1zqAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5237
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307270127
X-Proofpoint-ORIG-GUID: qSl3hqIzHgYSlxFN-PzX7EvwOfIdGaGE
X-Proofpoint-GUID: qSl3hqIzHgYSlxFN-PzX7EvwOfIdGaGE
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 27/07/2023 21:53, Anand Jain wrote:
> There is a race between systemd and mount, as both of them try to register
> the device in the kernel. When systemd loses the race, it prints the
> following message:
> 
>    BTRFS error: device /dev/sdb7 belongs to fsid 1b3bacbf-14db-49c9-a3ef-547998aacc4e, and the fs is already mounted.
> 
> The 'btrfs dev scan' registers one device at a time, so there is no way
> for the mount thread to wait in the kernel for all the devices to have
> registered as it won't know if all the devices are discovered.
> 
> For now, improve the error log by printing the command name and process
> ID along with the error message.
> 
> Signee-off-by: Anand Jain <anand.jain@oracle.com>
        ^d
Strange. It wasn't manually created; git -s did.
Can this be fixed while merging?
Thanks.


> ---
>   fs/btrfs/volumes.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 1ebf8c2222ab..82ac9d3d0981 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -851,8 +851,9 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   
>   		if (fs_devices->opened) {
>   			btrfs_err(NULL,
> -		"device %s belongs to fsid %pU, and the fs is already mounted",
> -				  path, fs_devices->fsid);
> +"device %s belongs to fsid %pU, and the fs is already mounted. Scanned by %s (%d)",
> +				  path, fs_devices->fsid, current->comm,
> +				  task_pid_nr(current));
>   			mutex_unlock(&fs_devices->device_list_mutex);
>   			return ERR_PTR(-EBUSY);
>   		}
