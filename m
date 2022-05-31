Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F009539A05
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 01:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348663AbiEaXXM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 19:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237601AbiEaXXL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 19:23:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1AC994F5
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 16:23:10 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VKrwmF026995;
        Tue, 31 May 2022 23:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AtUmPafH4zUzAWSqjdomoUMgAxiz2q4fzriRPVxFEjU=;
 b=gNFLgu/gUdJpFnShg1eqLt3qZeeXBvr/rUcwEGj7UJN4CRh3KHy63ydef9blPyygeIPe
 FbzshxeFX7uZ83zKcVtRkopqDBP6CBe1rcfxPY7uS4ExKO5Q/zTv6/Mfuuz/2Uquosr4
 Y4zNRmcZlyJexJmzQbzT/uzLo2tIYWqeZqT4V1SXamOACgkhKUEyoFDHSF52Z4NCLPWa
 NLqvHFSCF3U+quYa+qjbcY2L9LehpGAL6tSRdgXf6q4t56lAWXcwXeO6lKS/IlV7Nx9n
 Q+XEJh1C/adiZbI9f2+iUy/DQhSzFCvRt4QSsuQcV1z66Uofz2dHK3NIQ7XAwTasrK/h Vg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc6x6eb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 23:23:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24VNFSiq019534;
        Tue, 31 May 2022 23:23:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8jyabbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 23:23:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAwjaT9fhcsbMrhrPozGrFV9n+5aKrtzKaRVYT4SEUxsPr7m9gw+7ksXVoML2jz9DNFm3lJCKBCm7htLtoWMRxylhBVgsgz9Ewzb7grktSldNp3YZr6u8uyxvbhp5g2s0i9hqppy1vV2vlmQ84sXYD+/0A+flqG/BW75+8TxShMiB0lkvmTug/89KUhc204W9L5stEXYC51zoPpsyOXKqIA5KogGkPtO2N6f5pgXqz0ziNAiMZk9VGkwTpktXj79qgOp77ViTDUHjbWT9LfH7zoeTZutCpAsTnU0Hj6n0nMJQ7DR9hFj84QwwbtvkPb52EfC8MYCQF6SgeLrqALwGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtUmPafH4zUzAWSqjdomoUMgAxiz2q4fzriRPVxFEjU=;
 b=KnxTIZURCzTgbvQ38fk3jH7ItYGqTHgcOMz/fnsPmh7mFmxWShIQudxDJUdWlFW2h8vtE7ygNB5kH8sJVFbPgoVpaAJtqO3vpr3UisOxy4US0SPZGMEdVmb2nVlRrmYQ7EV+ouLLnzMHctHzvwn0gShce0hXk6YfYsfoTo2dftA67C+Tn4EP4D7U5Fab3IDHvG1lyjfHtVxtdv4n0u3aBM3J8x+rWbvXiWbsm2+hKgtgH0LCeHrTWinjqlmKyJlXOgYGCEtrkZsqfbabIDxcLbBbxcoLzW2ML5P0ITa5pvwXdIM7+CeHeUYdFExmBzeELSy5DYoCXX+sqz6o/j2S/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtUmPafH4zUzAWSqjdomoUMgAxiz2q4fzriRPVxFEjU=;
 b=glDCua8azsddLpL5nXG5V8wgbgIzcX84QTZpW96FlEp/8uFY350VmxXTuH9vIdkH4x1RT/heqECDWxKdUfiFbHSlpdw/3vPiMrP5V4ekfW+gyxBWBRIykXQoyGjIYoINyjb0hcsZnlYSpMmCEZ3eC/Ovfzyol1+kzCZUISns0iQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB3801.namprd10.prod.outlook.com (2603:10b6:5:1f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 23:23:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::138:2847:c75d:b5cf]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::138:2847:c75d:b5cf%3]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 23:23:04 +0000
Message-ID: <44eeb8b2-e826-4aa0-56dd-5ec90e157018@oracle.com>
Date:   Wed, 1 Jun 2022 04:52:54 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 02/12] btrfs: free the path earlier when creating a new
 inode
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1654009356.git.fdmanana@suse.com>
 <b3c7ae5b6d09c442fc7546660dd5535302d11a7e.1654009356.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <b3c7ae5b6d09c442fc7546660dd5535302d11a7e.1654009356.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0125.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3be7b6b-6b03-42ab-839d-08da435c8303
X-MS-TrafficTypeDiagnostic: DM6PR10MB3801:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB380127434C50B007E7FA726CE5DC9@DM6PR10MB3801.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hgiW87jVq0FvrlcCjoZUSEKeSnIW+33WKHXF1kO0DC7l+JHnHC/T/oznhONxjh8MqTuaCJyshVPKgXyX8EmqsWOe0rgiHh5Iz75xG2aoxf1Nmv6s5vRGNlDVLzo1hdaOLgP+7fn28TlWhWb2qOADg3cjwJ86b8LSIz3dj0JSifTf+MhR6abYG+GEOsod4b+oO0tEstjug6XZInW92ZLHHYFzR7AKgx1ah5kJCZnBvYWeE2O7KYK/fdc86Y3Scy6ucMORTwJoWzoCbiN2m02dm+S2AWDhg6y0FTaoOr4/tg+GEUWs/YAifagm09nqGwprM9AkyCiBeA0oOrzeHTEs2oRC0O9ZEipfNeS9vVV86KZ3migLe1Kd402Xgea8I2yMKTAPXKPJSq7DjWqODxljEwDSALJbjt4lQoEuc6UFdj/h33gjRKsLLt3gsQv4lTSkHQAzxvKWuNiimpeiC9rdVC9cCNTzYA3nv4J0dSnXAsG7Yr8nY3dgkGhp035zdGzH/nnfB30u2zzydaA8NP27/D48pal2PQu9mUAbUIuOzRRly/akGKc2+DCbhSbxUgMAkCKjLvfCRE6n0eU2uwVrB/O5a8INbB1xITehZAxFpr3fFzW6z0RkLI8qgBwVDlbzH2BNvvFoXC1uQsi7I0d9Ytm8ZyypevrC+/SQ/I2ZuQ8z/ujuxhvBF8Rbrz0v2ePrzXp2on+1V1hbzFX3zEEROnoP8qCyycwcq3Yl68mmQK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(66946007)(66476007)(86362001)(8676002)(66556008)(6666004)(38100700002)(83380400001)(316002)(36756003)(186003)(31696002)(6506007)(5660300002)(6512007)(508600001)(6486002)(2906002)(44832011)(53546011)(2616005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3laTkpOZFA1eWl1Q2phSlNFd2dGc3Y4NUlZZjVIK2E2M2JHVGM3V1QwQmsv?=
 =?utf-8?B?TUZEN1pQdktSREZ0ajUxMW9VZ3FLVmNyTmlpZWMzSnVCM2NmR2FQdWhsbGlh?=
 =?utf-8?B?bUczWjZ2QUl6U25rR3lmSVFCOHZXMWNaSEgrY3lpU05FTDJ6N3F6TmJ6cFdT?=
 =?utf-8?B?K3hNWlZqaWJGLzRWTHRlZkpjSDFzZnZRRG1LZDN5SVlIbmRyeWhtY0VYSDlC?=
 =?utf-8?B?MExHSllHOEF1TnFIWW1vTXQyUWV6UHpNZUJtY281VHpVZitaVUt3R1V0aURL?=
 =?utf-8?B?am01QjlrbmoxWjgycjl2SW5LRG5pejg0aFQxQTRIbTZBZnRmK0lUK1g4ajNF?=
 =?utf-8?B?NTJNZ2RvY3hWY09Sc25LdWRxZnZZblJDWVMzUmJSNlZFVjBKbWJpUi83N0Fs?=
 =?utf-8?B?cjdWdU9zQ00zdEJRT1JHZURPR1VoWUUyN3h6Z0o0bFVRMXBQRitXTy9XcGhy?=
 =?utf-8?B?VGhpZ3JTWk14ZHl5dkJDdjhRWVp0WGczNGJ3OHJQdG41S0lVWjRkWm1ZN2lh?=
 =?utf-8?B?KzVRNTZwK0JHRlhBMEtqcGI1TG9JdUt2T3lMSHpkWkUzUEVZWUxMWjExZUZJ?=
 =?utf-8?B?amlYQUdkSGlURXhmU1VuS0E4MVI0Umo0aVQrZy9qaHlzMGtiWnpkTXlCbG0v?=
 =?utf-8?B?V3d6aFpRcmIwZzQ2MlNnL1hLV1FFTFM0QWpBSWdEVVdjb0RkUFJPRlNONVA5?=
 =?utf-8?B?eGF5UktRVklvRTNLdDJtVWY2RjIzb1dZZy9qb1ZvMnB6Q3I5MWtzVW9TeWl5?=
 =?utf-8?B?bU5aN1lhZGlzakFROFpKTHdWUjFPb05SZERZT0tmcSs1NE5kK2dLL1FzV1pn?=
 =?utf-8?B?YmV4NUtxUllud3A1bEdrRDZIYjdPTW9aaXd2czlqa01DOWtKT2RTVllDaGE3?=
 =?utf-8?B?ck5aRWF5UXJBZEpXYlROSWVESkxtVlE4bFA2dURiSklhWjVvN0tYTGg2RUZC?=
 =?utf-8?B?eVN5T3plZ29VamZ1dDNJdDVML0N2N3RxeWc5N3l3K2J1Yi9jMHVQN2V4bE1N?=
 =?utf-8?B?cFdaWHlUaEVEVjZtQXhMcG5Kd09NZVdCZ2dDM05IUTVuMDNmVEJtdXhONHJG?=
 =?utf-8?B?SlJTNTBkNUp6VEpkc1U4UU9sMVdWMTQ2TWVjd3YzZWpIa0UzbDk2MUpCb0hk?=
 =?utf-8?B?Ti9zSlZVSFc3K2h4V3VOOWprVXo1NEhuVS9ZcVduMW1LRUFYYnRyUWk4VDhk?=
 =?utf-8?B?aTMvMW5KUFNCVTlvaG9CQTdtQmJadUU0WWJwdEY5R0VXMjdOWGJNaVdlYUM3?=
 =?utf-8?B?cVY0REFDMWtXbDBsTmhHVEpNc0h4T2RhUURuT1NtT05yNkZSWUQ4UmlWTklL?=
 =?utf-8?B?akNhdUdQWHN3MHBEWGlvNEQ3WDFqRUVRUThpMVpLZjUyYzdiNjBUTVpFOXI2?=
 =?utf-8?B?VkVxbUhpRHl1RUI4dU15TWxQeU1mWVhBanZWSHc4QU0yNDUwUmdzeE9xcTNi?=
 =?utf-8?B?Sm5UTzVVZ0hOeGR3WW9JSU1lNUdUL09GZndET3MyZklFTCtmRmc0aTRvOHBS?=
 =?utf-8?B?TUFvOWRHdDBHS3E2MXo1WGJudnFZTG81c3YvT0lINXp6UTgzQ2p2OStOWlVT?=
 =?utf-8?B?UUJwSTd1VkNvWnhaS1dpTExCVTkzY0NaVC9ldy8rOGFuNktyNmFuNnFmaEww?=
 =?utf-8?B?UEZKRy9PMUJ2bUhNUWNzdkFjVGY0OWQvOG1TajE2N1hERnlCa0tDc3duZ2tM?=
 =?utf-8?B?dFlTNUFIWlJCajRseTI3WGp5NW5MZHNrbVlOdFcxUHZoZmlJb1ZPSElYWlJy?=
 =?utf-8?B?L3ozNFpxTFY2QmlwTHNNaW0yNkR6WTh6cGVHcFdwaFdkbURtYW02eExLdTQ0?=
 =?utf-8?B?cEVhb3dQQkpmYmRGWXVYajE5MitRZ1l1dmgzd1dnaU5JblhrNUQ1VFlTZjYw?=
 =?utf-8?B?c0dXZ1lMVk9ITVpBbURxVGkraTVONXlkZ0s0Q29YWUFYbml2bHI0MUVXeHNs?=
 =?utf-8?B?cDkxRjM1LzhjY24rRmVtUVZYdkVPR2hHTWJwcnFSM2hOd3MwbER5WFBxajZv?=
 =?utf-8?B?dnE0T1lURTA5NVFVQjFBMVBUekx2cWdNcTBUK0xPUVBpNStiUHdnTHpwZmdT?=
 =?utf-8?B?Uk5GZWMydnlVY2dGZHVDZzA5KzBZYzMxdmsra3VNREpncW5WVlp1ZFR3OW1Q?=
 =?utf-8?B?aEdvdmp5cUNMQ2NMNlhLMmxha1hwdkFOTDkvWVAzbDh6ZWNka0Zyb1VINFM5?=
 =?utf-8?B?UXJOUGJWYWl5bWZuZjRVY1hQWmtOZ3RTV1ZpNTdwWklXLzQyeDRmdkdzK3kx?=
 =?utf-8?B?Y25HeEhGbjhzUDNOQ09LanpnbUk4Q0psejJSU2hJTzI0RElYY3ozRmFheWJT?=
 =?utf-8?B?anVlbGFlTldNWXVkUURhNCtacFE4WjRIaUdMUG9pbm5UeXFobWdNYjZjWDVk?=
 =?utf-8?Q?BK4lH2MrO1AzTbDSb6jFu1K0FdE4xRGBGQjyMOvBQqNna?=
X-MS-Exchange-AntiSpam-MessageData-1: qG84nd0Y6EK26M3OvroN3MHMgHkmgW1XuhA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3be7b6b-6b03-42ab-839d-08da435c8303
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 23:23:04.4350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJDuckCZnpY8TGiTUkxp7L7PFbbagENU2FB92l3oTA7RVPm7LpmAFh46SbIK95toi2f+W53NXoiYVRkdxBnP2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3801
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_08:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205310101
X-Proofpoint-GUID: P1epIqEEe_2VLIQZ7L7HLD1YE12mFuaW
X-Proofpoint-ORIG-GUID: P1epIqEEe_2VLIQZ7L7HLD1YE12mFuaW
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/31/22 20:36, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When creating an inode, through btrfs_create_new_inode(), we release the
> path we allocated before once we don't need it anymore. But we keep it
> allocated until we return from that function, which is wasteful because
> after we release the path we do several things that can allocate yet
> another path: inheriting properties, setting the xattrs used by ACLs and
> secutiry modules, adding an orphan item (O_TMPFILE case) or adding a
> dir item (for the non-O_TMPFILE case).
> 
> So instead of releasing the path once we don't need it anymore, free it
> instead. This way we avoid having two paths allocated until we return
> from btrfs_create_new_inode().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/inode.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 06d5bfa84d38..3ede3e873c2a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6380,7 +6380,13 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
>   	}
>   
>   	btrfs_mark_buffer_dirty(path->nodes[0]);
> -	btrfs_release_path(path);
> +	/*
> +	 * We don't need the path anymore, plus inheriting properties, adding
> +	 * ACLs, security xattrs, orphan item or adding the link, will result in
> +	 * allocating yet another path. So just free our path.
> +	 */
> +	btrfs_free_path(path);
> +	path = NULL;
>   
>   	if (args->subvol) {
>   		struct inode *parent;



> @@ -6437,8 +6443,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
>   		goto discard;
>   	}

At discard, we free path again and leads to double free.

Thanks, Anand

>  > -	ret = 0;
> -	goto out;
> +	return 0;
>   
>   discard:
>   	/*

