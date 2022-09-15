Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1335B9B8F
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 15:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIONGW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 09:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiIONGV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 09:06:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E709239BA1
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 06:06:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FCENqB014898;
        Thu, 15 Sep 2022 13:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=qc9b5j5YTNOjPHpdC0zWUuhVoclQsIik7CKvaNEbxA0=;
 b=jkBaXHozGPEO8yQCZsIGQ8CfrB2hVKjruiLWsljn5dxUsz7xKXE107Ax34cxmrrCQe7P
 z6YiEwzdxsvBppfgAi6WQ+ltfEcJlESXfqcwOfiGvFLV6q/rlsHS/HaRzaUi57wqWHrn
 3edRYkmtcwQaH9Hjjd6AyrrfGE58I/pkAZjSPcRsejfBhdsQylrnFzUMf6mUG/HVQT5t
 y3gF7pZcU+1mM+dh12StY9biefeaP/Uo1tA0mWVWnQqdend8NZ7rhI/EE381WQKhu1uS
 d+OA0Xz6eesL6hMuRzKAJQhTwPKgVP1xDatByP9CM/h7Hkf9ggEpzzx9kagcHlGypFT/ ig== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyr5d60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 13:06:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28FBUTBg004911;
        Thu, 15 Sep 2022 13:06:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjyee7mc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 13:06:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTM0vuxaae++GnkTrXUmED+0cqHoVblHBuUni5MIpMrZ5eqTae1n25s8td8hUzqtYBM0h61yOSsuz7YhE++yq2+pEhYJ2HSgdU+jb3Oq253QPY32Dinvr+7lgo/yP/fYPPfAP1VBS/oWGDZnZ1hcY2cbUO7mych1ZP7flaXMH+RBMVSv4JBqaK1euKoF+3Zu8SOZfUhLZleW8zXgwKZ3yTeqVwoP4vHEEjhyvIk/1NZUtfjsIQ1A21WAFXgri7V4vKXW0C09+8HGNLtBNztQtsQyJJBXeMD32oGbbnwgmkO24OQRmXDPMOO0O0w6eljlS+ypE8OgGjt922bqUoeuDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qc9b5j5YTNOjPHpdC0zWUuhVoclQsIik7CKvaNEbxA0=;
 b=NP2FEhmAXKeVBaPRWdQYSZyx0xeQn1Rzq1Y8rsV7VpV6j3TbxrIHyQohklWa8RK6MEJZry07/E4zUM5CKPkMceA/NJX+uGlcsyD8B6Svd+7olqMqGt3SL74oddEzGSJdB7gL+2UYi4YHMPKdK1BsTJPFrxoTFOGueF6qMfjRk+jAZ6Fksc0qjugZdCAAxPXHgNrYtDgHEfGfajSPN9Vn5IvMbRwd5VRQcn6hfiPntOMwW88Hl6uDBJRC1+HSoZEZycbfBWCkk4ZrZbClo92NkPWE69DObioDMZs/FGIcRhgLU+qvhPC8DHmwF7YHZxmq6hS4cQwnLh185qllLkFNaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qc9b5j5YTNOjPHpdC0zWUuhVoclQsIik7CKvaNEbxA0=;
 b=XrH+OPyJLLzlCVTM6IDHeawvqV7WSCVH+3uzbJ68UnNhk/gp0uURQB505q2C5SL9G10KqC5UqBImnlfTiJs++DnSmY7zdXVpBa8ACFPMb9Gfd3V2vLL7CRYyN595MWrkGI65K+V2945xQ+bm0AbUz0xBRUoJIaPmCe/CpRdK6HY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB5677.namprd10.prod.outlook.com (2603:10b6:303:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 13:06:14 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 13:06:14 +0000
Message-ID: <d523766e-786f-8b2e-3d04-cfcfb97f2351@oracle.com>
Date:   Thu, 15 Sep 2022 21:06:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 15/15] btrfs: add struct declarations in dev-replace.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663196541.git.josef@toxicpanda.com>
 <aea129f8e5420561d3f5fbeaa0de297b7122e815.1663196541.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <aea129f8e5420561d3f5fbeaa0de297b7122e815.1663196541.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: 508c3851-7c6e-44e2-1dd9-08da971b1177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1T1I9I3mzUVlZI4C0f878TBSR0AUHKanU2evYaETNTf+GbJgoRtOtu/EGfcIaKY1Khx7SLT2MZNNU5RuB/+veBxNzprFhlO00smSHTFNDJGTzN7T9LrKUUr8gWRDCMWx67PO3sfmE5QsDaMcy1xoi6rxsB+l5yPd0jzepqD+JE9nojlErqNoFmegH5VBYco3oMCPcEAtUk3lYeXrqE0GCUn190VgSSNR+AZxBGJz9RCsrk13yU/SsmhQ0eOdG4PfqfI1UNZJLAuhI8fKDuYk8l7xTccWphJm45OZV//k0pFwBhV6U2TShrLE1QD0odLGUZ/UosOetUSiXDtt4IdIVeWaRAvgMRPDiO98MAufkBBPdH8+vgr2L37zTDjY/SrvEx8IQnlAjyoAV4IBllj+ZFZaNcrJpAVoYaCUO7JDlLoZbblo+XicDNoooG1cCBcttRShAjIvvFQNWqPcoY1eeYCS8J7Sf1hzp56PWdduDRQFe4zefoQglHoGr7g3J6RFWFXQ/u1pBCT7W6F/pKgw+bFmdMCoSDArUOzRlxXt0L4iS36rNuORrfZH113bF4cqictQPiIBPjaNDm8U3gs0qqFJIhSgDR/q7NshssNiRt3ZLcCZlo8cFApIBw+QByQTVAHkSdABGN0KxxwDPrdM82iNdk7WY/GETiDiWRJ+3GsJMPEAfC62DrwXmlQX833c7pUSOlYSZuX9g8vvchdCt2hxe4POLg/quyYCO9jIyuWCfTA826kdKMNhxMkbdrfeoNq2EE60J2OjmnxV2Pq8sCl0sx1NgvmoBEWKkip48sE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199015)(36756003)(8676002)(66946007)(66476007)(66556008)(316002)(86362001)(31696002)(6486002)(478600001)(6506007)(8936002)(83380400001)(53546011)(2906002)(44832011)(4744005)(6512007)(186003)(5660300002)(26005)(2616005)(38100700002)(6666004)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUNKL1huOCtERStNUXFUNmg0U0srNnhTWmhaRUdjdlVFZ3JvUjRIMC9Iekpz?=
 =?utf-8?B?OWdxd1dJOXJXd3RrRFlGaFFCNHBGbWV6MWY2bmljUTdZaVNlTWU4VHBKS2dR?=
 =?utf-8?B?R2c4QkdFampQTzRGTlZMaVdWWDlxdzlHVHVYeEw5MWxPczd2WWFERW1qUGJT?=
 =?utf-8?B?ZDVHdGY2N05rb3Z4VGk4V0d0c1pSTXlLRlJlalltVTlMb3hoQXhHUFFxRXZE?=
 =?utf-8?B?NFZnZjdVZnIvMW1lbTJKMFZReUpoTHpqYmVxdXBlRkdCaTh5UmJQTXJ2eE52?=
 =?utf-8?B?T2Z4V1plTEZIdG1rWUNDdW9Od09na2hrOUxzUXBlVDVBQ2szOEpWRVBZWnZo?=
 =?utf-8?B?T3RMajAxVW9xdzh1MzF4MGJ0QllNd25MMnVZY3VnQ0c4YWlsRGVaZFlnMFZy?=
 =?utf-8?B?d3R0NEY1VUM2cTQxczliamdrREFTSVVPejZ1cExSZFpSbWFKTy9FRTZodm5h?=
 =?utf-8?B?RW5VNkZBZExtWWxVQjlmbkg1clp3R1htWkxjYVorTVp3eFJoNHN4MkYyQ0NX?=
 =?utf-8?B?YWRqaDduS3ZkNjFYOURnTFNHTTIxN1ovdGNQbS9OZFhZWmRoa1NmQ2ZDK2lV?=
 =?utf-8?B?RUJpZlh6elBxN3NHNWM4cGVuUGl6ajNkdm45TWJCdmVIUkVETG1YdklnQ3pZ?=
 =?utf-8?B?bytFdUdIamI1NGp3MVpOUWNwU25PUEJnZXhGUVUzZ0xKckpiMCtpZENMZjR0?=
 =?utf-8?B?Zk1hRmd2cEY5SFdxSFV6NUlJK1Zad2xCWGxLR2tjUWxPangxUG5IcUgwQkpH?=
 =?utf-8?B?OXhabjczMER4aVo5TjN0dkUrcHpYcHpVb3FFRGtxMi9ka0QxaHowTy96T1VD?=
 =?utf-8?B?MEJMSnhzYVJURHByWG8yd3IrQkg0dDNaTjU3SGNoODBHUUpET25IVkJtajZq?=
 =?utf-8?B?YzEvVTRGNUNMd240a0VXRzhPUGRyZ01tZm9XNXppKytrZUdlY1Q0dGtWN1hB?=
 =?utf-8?B?bmpIZjZ4M1lONW1TSHRtL0ZaUFI2U0FOaUFxQ1ZUb240RlhSU1lZTldGY0w0?=
 =?utf-8?B?REFObng4U3hwanR5MFVZaE0wWlVmV2t4dDFaZzRISXlVdEdyWEVvb2N1QlU5?=
 =?utf-8?B?aGNDdzB5VG9UTHRIREp2S2c4UVNSSUs1WkVCcERYYStMcnBydnpIRVR1UlJq?=
 =?utf-8?B?bTNhRDV0NUZvWTIvdjlzZGtjSWJlalg1czBjVW42NGwzNWNaSWxKZHFsdEJ4?=
 =?utf-8?B?VnBPWDdSY2NrY0VUTjZnR3ZwaFpjWEFNN1k2VFZWQmV0cFF2UWtxWmxFRklw?=
 =?utf-8?B?Q2lncFFxSUdKVUtzbDRtcjNQeXZLVjZUa2VtbkRpdkw4OGRBQTBPRHB1a1Nr?=
 =?utf-8?B?Qmk3VXc5cmxWWVhZZGpBVmYwcXNiRTlXQ2x1WGttZmF6ZzBTSFN0QWZQMm82?=
 =?utf-8?B?dG55VW5BV0s3Q0FzWHFLbm1BVzNsYU1lQmFDdy9tR0puOHFrRGE2bkFFbDVI?=
 =?utf-8?B?OVVyMnJENE0vREpNbVQvOVFwUXRkR2M3SUwyUnVKR3pKUHFkRHJCcnBmV3Qz?=
 =?utf-8?B?RWx5SVpGTU96MXIxVjVSdHN3MmxweDNsZEg5UnllRXFsQjZBNDU4SkhlL0Nq?=
 =?utf-8?B?ZWxZWkkrcHZ1SG9PRDA4NGxFbFNHM280WGVZVVBtUE9kNGI1ZWRYcmNleE0v?=
 =?utf-8?B?OTZWZWZyNzdJeXFsa0VzNkFiaFBZQmZNWEx4cHdTWGt1bVRBQzR4K1VaMFI3?=
 =?utf-8?B?eEd3TnZGc2hIQ29RZi9XdUs5VnB0UW1TN1ZpcTdjTi9hWnVFR3phS0VTVWRs?=
 =?utf-8?B?bHA3dHFjblNFRTZSSUtRNGFkNWU3Z1d1VFI1VThnRVRUcnIrRjl2eXQ4Qk9q?=
 =?utf-8?B?Q3FNazl0bm9nNVEzMnZqTkhWS3hNTjl3bUNuUjdWbGZuWVRMSlQ3b0pkdFR2?=
 =?utf-8?B?Uk80aFA4OXlzL0l0K2lMVXR5SFI2OEs1UDRRaFYwaWRZYW0zdURBQjFzK2dP?=
 =?utf-8?B?Rk0rc1RyYi85aTh1aGFoYkVsVzVWQWhvdTBrT1ZpQ3pVbUZNeGQrTlNzS0RY?=
 =?utf-8?B?QXRwL0VxR2wyN1VVTjVTVkNickcxNVV5c1RqaUQ2cVkwbDVBYWRWYnB0Ny84?=
 =?utf-8?B?T2pVSitzT3o2YVpvSERFa25EYkExZTNpWHRoZExxUkc2SlZZa2lUd2pOS25N?=
 =?utf-8?B?TExQRVEyMktqMEh1Rk5aNmVnS2s5aEVGYVI5a0xySjhwNkJJWm1PRkgrcXkz?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508c3851-7c6e-44e2-1dd9-08da971b1177
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 13:06:14.2401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fvpg42O4pV3m+xRq9Ke3gbNK2QHfDji+duHuG7TAXcGu9lyWJFKBBpq5aBt4pwCjp2ckGQJNnx9recl5zIWuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5677
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_08,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209150074
X-Proofpoint-GUID: ifnpqx5tk6Z7bfdlhREhAH5gpQ8x0ptd
X-Proofpoint-ORIG-GUID: ifnpqx5tk6Z7bfdlhREhAH5gpQ8x0ptd
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
> dev-replace.h just has function prototypes for device replace, however
> if you happen to include it in the wrong order you'll get compile errors
> because of different structures not being defined.  Since these are just
> pointer args to functions we can declare them at the top in order to
> reduce the pain of using the header.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>
