Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853C75B9B37
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 14:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiIOMoM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 08:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiIOMnt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 08:43:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28899AF87
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 05:43:21 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FB1rOW009352;
        Thu, 15 Sep 2022 12:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=L0XH/+Sh6zbeh/M0S6GwjyKmOjJrkqx3Nq6HgozUYkI=;
 b=FZ1Q1xhML87ulR6fqdvWhUHIu4aRXryvl4mUwihO18YJWX+Td72wYek2YFLXIJf6acRb
 UPdM3MHLiLQ3w9auMdM4q3knN5uAYR9Pwx+goqFEpUXi8V2R8ljHoGvy7QUnR6yP3lOw
 mQXZZExrjPDTEUouxTSaW8q3Y9VLnUtNbldalajFv3xc0CHNeTHMRowlJU/Ec6v6FAgo
 EvvquFdLAfsXyXHlUvi0BlWhHvb9Pf+X58ukN7hFDu5S121Y2hSAQXCr5gNZ9D58T9kH
 1+KMXNGvgSLKuq/hEZZJ9Yfqv7gLn2wQS4khKk41ecQihqptrcmJOjg3eMudFq+FK8qp rw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxydw3wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 12:43:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28FBUUxb027724;
        Thu, 15 Sep 2022 12:43:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjy5fdmur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 12:43:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izGc2dIP+6W2wHac/1mmswymuRhqHrw5EsG2IxO/ChJnIDRX6p8BxuIM7aRxwrZ+jafSLoQ/lAvXyFQxrKO3+HJkb4DVZJTSSIezXASDRqp2/jK/ahK6kjFxXJlp0zw8U8aHRk7Owlf3QUdXELrJwStXr8gsrzRFDB7HuCHYw5r+tcNZEhgdk4LehO4QF4nRj8o62WXNyUMEG99dFN2aLat2KQjCszkUZXNYr/qvy/gN5N9GHndHIYN2hOorzhIRwODbHLiY3GCPp/2Cq712Pf4qyZw8UNXlRGJvq1d3ySvtbQc6crhNZH54mkUgzddYUVyhKbRKXZlKbDRq9OzkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0XH/+Sh6zbeh/M0S6GwjyKmOjJrkqx3Nq6HgozUYkI=;
 b=RFtUfVqp60aZgBiNzU5s/oSgzGpvRUbGqt+6gYJVSbgbRYi3STMVnUa58owtX93MMF2+oh1RB0U0SEAM4UINeG9oCQIXUcvC274uvG4niI92O6rT3Lz2D5tvcYmYf5Ec1/8JuR2xsocEsmJz2Ojmwjnb8mhH5ZadmCc3EJPZ0mSjakaFm+4xPhdxtlA9JtvyUhUnEc6dinSktL8RnNL3OryH4niD6345Xw+2qi1NKWz3Q6XMn04Z/RW2QxcXKEMMvmfsoMWOa+Y9BmquRyJjwrdLSBOMaxFmK52rmRYOSbzbD+GO9g8DB0TA8WrEESNHRpYRcumxSp/V0Q9ozJ1LWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0XH/+Sh6zbeh/M0S6GwjyKmOjJrkqx3Nq6HgozUYkI=;
 b=LngL559ItdW4g+00MQUMD70MtDDnn2Z9pkLhDU2/tp7dVNiRO9pQIhLfHZeETuFqRm2ubiPN711dpmXZaJle+wAbfax8My1v/8VcgiT3zSwEX+1ivv5KvWp7uoJpt4E0FZkUCjGwlTirfOxwihwh6SrmqZOAA+fSkFlr4x42sDE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Thu, 15 Sep
 2022 12:43:17 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 12:43:17 +0000
Message-ID: <bdc408f8-ec94-2966-ebbb-08969ad23884@oracle.com>
Date:   Thu, 15 Sep 2022 20:43:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 13/15] btrfs: delete btrfs_insert_inode_hash helper
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663196541.git.josef@toxicpanda.com>
 <36293c3f222b706b007147efbba1f793793ae0cd.1663196541.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <36293c3f222b706b007147efbba1f793793ae0cd.1663196541.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB4901:EE_
X-MS-Office365-Filtering-Correlation-Id: 357b0aae-15aa-44cd-49ea-08da9717dcac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afQ1x1/ZUcRBqE74AG4l1Q+OR6jea2KjPLxdeMk5KFyKUNhWlHYrpk0yhUFuipSfR4ArcCl5ChdleFGdaRyqH/voXjp8L6AzYixxhme5uR96106Fhc8caJMNw301Y/zt4mSUmwAwATMLkSJKJW+OKTBSEiKNw9DmRdYG5mWxqkY+gQwguxogGyslsvTp7Z3TtfXaXBNLBEciHU+3KaMTbGY9YTRF+5Y5qcs4fATbMBamLTFzm+23xJt10wD3HKnNJkOSLwbxqMVa6CVUtVBM11hHdu4pjC/W/RyleU8Mw4m50QxNMB0h6kbc9OaU06nc7mhrVQ2l3gYWqxRbrUJZmaG/wYxyhtssDySWoHJIVWyk8qlXX19gVjSGR3uL/T6O69MOaywAfS+vqSpxCR//1bHg74mE/4I3/GWJTrCMFdjtxd+gGEtXmp/ZpsL5GpL5igVFySopeTfbv9/wXi7kW6OM2i9mijA8XAD82pu4MFjFKkiba9MqNxRnRXDN+vo4kCQn7+yfRZ+naS/Rb5fcbUHNc8xSbB1GLa9p+yGxgdNB9zn65RiwQECR+evJ9EA6vqs0/YfmtO0qOsYmVecPT7CPq3Sp36JCB4Sj9g4IDNQI2mnd20mbCnmNSN868SKSwN7a04MKlLVBT0h3igOS/OGTIRXZ1MPkJtpH1DSgt4FgMYtYiD6q7qdS/cA/RHQ1sSRRqHInqzNaAZmfhbZYGVmkqx3gcpXY8V3dPsKrwiLktetJcw9G9NU6tpm59+X+ob58oJiM0IsvP5Zcr8X0hdxGJVoNY1m1SPeXU8Oas6E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199015)(6486002)(66476007)(2616005)(6506007)(8676002)(31686004)(31696002)(36756003)(53546011)(2906002)(6512007)(186003)(86362001)(83380400001)(4744005)(38100700002)(6666004)(8936002)(66556008)(44832011)(5660300002)(316002)(66946007)(26005)(478600001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXdVYzV4QmtxNFBRdmt3bEZxcUdxdFd6Q0xWVTdkOGZHL0lNOUk4U0pLKzQ0?=
 =?utf-8?B?VElGRVJqaExzdjB1L05MZGlpb2thd2Yzdk9qTFVnRlhjRzQ1ZWY2MEpEYXQx?=
 =?utf-8?B?ZU8xaGxVUkdnMGJaZ2VxTU9MZHhDZEpLMTlQc0kvbTlHbWRSZ0xKMVlvdkF6?=
 =?utf-8?B?Y3VDYTdUTjVSR1JPRXJLd3Fjam14eFNtMGl4c2g5c0g2K2hzOEVBL3NlZ29p?=
 =?utf-8?B?Wjd1SnFZUUY4dXRWWk8rblBFdWJRSlBrckhlT2FtVi9FMkVJN1JZWXJ1bGhM?=
 =?utf-8?B?L3RsdU9WOXNuMm9ZUGJIQ09FRktJN3Z5TnBUZGdXcllLOVZxd0E5anJIbU0x?=
 =?utf-8?B?QnA5ZHpkdHJFZ0I2V0hobFpoZXV5SklVNVZFd252WkRIQXZLQzRuangxbjhh?=
 =?utf-8?B?UWFZc1lQclZmb0FkZ3NCeHJhc0hXaExkKzVlWnpyK0tKWVhpNi9naFZlYWs2?=
 =?utf-8?B?N21xbUZtbDRVeUY4OGVPcHU2QjFiSVBDWTlWcWpMZDhZY1pkaExrdktjam0w?=
 =?utf-8?B?YTc2NkkwMEtJTExXYVJabGNTMU1CSzNHZlRRdEk1SU1xRnJDZW00KzJoRS9G?=
 =?utf-8?B?dzVzTlZEYmhDOUhMaEVMZElYZkdCeEJHc0hIdWN4ZnRBZHdJUDlVbjNBbVox?=
 =?utf-8?B?WW9hYnRXZ01jWWc1L0Z2OCs4TllwdzA4M2lyU3F1cXNNTldBN0FNVS80QXQv?=
 =?utf-8?B?Z3N0U0pDZEIwaVBOZFBlRXJabDZhNlpRZG1vTTFJTDZwVHh4ZDRKTFlJUUlV?=
 =?utf-8?B?dWtWRFU1dC9aVkJXNHd2UVJYUmVaNGMvOFdHMHNpelhwS296MDIwaFI3SGlT?=
 =?utf-8?B?dzZwUXo4K3NyY3dsMFRkcTNrdzJ6a1RKRlZFUWhlL3FIVjB6Y2ZmSDJoSkxu?=
 =?utf-8?B?L28yR1NYTXRNUE1oYjd6TFhRZk84Nk1HMnhrT0dQS0RtellkMmdxM1hnUmIv?=
 =?utf-8?B?YjFUT0JwdTFtVlB1THNud2FGb0FXV2pkNUducDdWTW5rYUFxN1MvMVV2czhN?=
 =?utf-8?B?bWJPRHBGbFViekpPVkNNaG12NGV3a1NYOTBqQlZKcHljM2tvdGljRWk3K1h0?=
 =?utf-8?B?STVUVU93NjN2R2laR09rWnBkK3dZdUd5MmViWEZNOS8wZ1YrNVRRQWJFbExs?=
 =?utf-8?B?SXF0Z0piS1piYzB0b3lKSENSZHZ6YS8wYzRBb0VhbWNpR1VZZXRYNjNvcjJz?=
 =?utf-8?B?QkpnN0ZDMlQ4dUF5VHlrT0pMc3lFZlkyYi8zVzlPdm5vU1F3RngzeHZLUTcr?=
 =?utf-8?B?aHBXaG5QR1JNSjFkQWo2R1JqT2ovV1RvQ1Y5dmEwc3JCT3FWVlpzWFZsMDNQ?=
 =?utf-8?B?U0o4R3ZLMGEyaWVFdWlxTW9BV3RyME1DTk0yMmdpZU9RVC9wTitYNkhOQVF5?=
 =?utf-8?B?dVpRbllVL2xkSzR4ZlhNZklWelNmcm9NWWNwNHR1ZUJyWUNzQWwzOHZXd0c1?=
 =?utf-8?B?MUhEa1h4OXU0eW0rR0lUcHZZWWFyNnRmd1BYOFlhbFhWdkZHU2V4Q2J2TjNW?=
 =?utf-8?B?MkN1b09LdWdBSTYyc29vdUhlTmpnQXhuZjlRYkZVODZtakVVT3RENGxNUCtq?=
 =?utf-8?B?eXlDTTc0SFZPRlpSRG9uWi9yZnhMS2hhTHE1MHVEVmI2TTNHOE1PVndmTG9Z?=
 =?utf-8?B?UlZ2MTlJbExpQnBpOXhKeEdpZ0FhYnpycmU5OVZHeFJ0UXZwUWI0UHJZRmdz?=
 =?utf-8?B?WUx5a3BlUFVPZGlsSjJja1NFWmlEWVpHYW9CM0hyVmxtRHNWOHNSYnBTVTRy?=
 =?utf-8?B?RlJoSk92RkREZkNqVmhqODBLUDd2bjF3SU1nNGNReks1WWlvWXZyYTFJVHQx?=
 =?utf-8?B?SDAxNkhVZEt3R0xKMk14NGM2MVZWZDdvQzdYbW9MOTFCSDBsOFRERkU2OHdQ?=
 =?utf-8?B?dDNOVkxPdElJZ0JhOVRPUjNOV2RyMUtsYWNRc0V2QUUwWlc1TkMrVXcxU2c3?=
 =?utf-8?B?YmEzQ1dYY3JrS1Z1RERuU3FsSHZxZmNJd0RZQWdoZ0Z4aTRSd1BsYlBkeTE1?=
 =?utf-8?B?T0pBUDVHNDdHNXlqTHJ6aTVXbGdoMVZpMXpoZU0wM1dtTDJSWDlHcU91VUM4?=
 =?utf-8?B?ODVMNTd2cVFYMG9NcmE1bTlwMWR2Ry9SL2RvNTFyRGlrVWMvS0poWElUendr?=
 =?utf-8?B?U1JCb3RkZ1Jmd3orWDN5eGtxczl0WEUvcEduVnZ0ZGQ1bk9UWnBkYXVuZHFE?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357b0aae-15aa-44cd-49ea-08da9717dcac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 12:43:17.2116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6apQ5gyQuE4oUdwIEA07YimpmynzVzRCaU7lgmaNpDazROIPN1XAJ+hw3C3lzeHac5FiexAVnoDToe4BTpzOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_08,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150071
X-Proofpoint-ORIG-GUID: p3Jcg11LhfLO_QeLpOxyy7Qv9N2ftbTf
X-Proofpoint-GUID: p3Jcg11LhfLO_QeLpOxyy7Qv9N2ftbTf
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2022 07:04, Josef Bacik wrote:
> This exists to insert the btree_inode in the super blocks inode hash
> table.  Since it's only used for the btree inode move the code to where
> we use it in disk-io.c and remove the helper.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

