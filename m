Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73FB5BAC19
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Sep 2022 13:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiIPLLt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Sep 2022 07:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiIPLLZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Sep 2022 07:11:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16E42AE3D
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 04:11:15 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28G8oGOT020485;
        Fri, 16 Sep 2022 11:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=q0sYmSxxjWDjvoN4gaJkWatt4i1peu7vQTLniXfmjgs=;
 b=H0DCnZzH5axcDwA/2Dyn/8BdWe9n/1MEq1r1vdpBFu8a7aLeha6bf5etkkAfK46+erx8
 hBtkW2Vxi6XjHG3OEouvP7AlyBDL66XfcpMITnvfMZMPrlB99bKAzc9p2Ex4fm08bX6/
 o/CZg1ziRgoyT0Oovl2sfpRSG0pANY8iSFAf4ZScYsM4YvbrU2fCUDs3zwI7tiJSV7l0
 3dM4gWmlTSvD/vBuoJ/r7TnpZ6BgXu0+oDDUxKrQi9ZmuAQeBaXNQucLEiI2H8VGb0Q7
 hhpEzpHBqSnfBi42tMqOVP2wcs248/XP/LDHTfAHxVhUa8szYeF1yEZtVDtUDdiAE6ms Qg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8xaj31w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 11:11:13 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28G7o3eQ015898;
        Fri, 16 Sep 2022 11:11:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8x93e9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 11:11:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcaxhYtAjtuHeJQxEyg0CeVBJdKk+QnbQIkb3JO6YOWW61nRaVwT6KRNRdee1Sz6PFzZI+uNkR1phlSFKf6d2k2pjYSQYs+gGA3ndf7mPzDn3LwQRCvqKUESLOvgk+aYOjlhL0BIQPAPO/XN2RwSXr2krkt6Ly/LebYf/ohoPYEmr0GAKCnF/1XK+ViAHrNbAyLh6F+5YDitdd64kGiVqJFs3taXMWuY6LZVxRYgR/8l0OjGBOwtxUgFilxkro0gq5mwWaEiJ9rV/6XIVzY2lDl92rBZc1OyyCcSWUqyAVH1lpEUqaIxdn0WNslXkI1nkM8AX/CvP1SeHk91md9uzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0sYmSxxjWDjvoN4gaJkWatt4i1peu7vQTLniXfmjgs=;
 b=KOdDqqNJMntKABvU5YmFtz3Zk81KtWJ2XWes26vzS+TTqWf0XZeqGVg3qZaRm1rH+r3SZBOxU28+cokq7atBBaCJzRTUY6YxYI3FNYHVF2MqkvB/Gnax/92by2ysmPadyv8Y6gwTG/zYvGdp1nFk1DULZpJ34jvGwNfRWcrs/4NAkGPDq0NmNGOmgYuqC5beUeIOfaWJFL9p8RJTKn5KLT9r8WsHcr5uyfvuw7K+Yg+gPYwvQ5BUsE2LSXzEVCsJUzN37JAm7Ik9jmgAA+BZGcDx48MHsifZMOva2xcHCGGILxmfXnlDQzFvZMrGazg+4FzlI0P7MkQ5GwC/AsQGAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0sYmSxxjWDjvoN4gaJkWatt4i1peu7vQTLniXfmjgs=;
 b=UGzih8nGQDVHvqw6TrjuXZ5KUVMgI5R5ixsqdWL+8uq8PPFuzn6h30jiJO99bd3AL96xJoP1uhV5HS0PGZ/MEQ4lFgIZiiZ0GSUSWoad8vz4mPj0OSRSBTcgPwxEzOGAgQjm6LYq5YBGwyfvvKxKUKjPucOCI8tWsdoXq7w40MA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN0PR10MB5982.namprd10.prod.outlook.com (2603:10b6:208:3ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 11:11:10 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Fri, 16 Sep 2022
 11:11:10 +0000
Message-ID: <2ccd2670-56ba-da73-9261-a0ed1b685ddb@oracle.com>
Date:   Fri, 16 Sep 2022 19:11:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 02/16] btrfs: move larger compat flag helpers to their own
 c file
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663175597.git.josef@toxicpanda.com>
 <92a20e2cd0cbf74630be86dfe0998aa3e711529c.1663175597.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <92a20e2cd0cbf74630be86dfe0998aa3e711529c.1663175597.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN0PR10MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: e54c22ef-400b-4c78-15b2-08da97d428b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3YcC15QVEBT7pVbumTh3FyS4kHZJ7ykoT6WXLrrX7Sn+/k8i7kSTZp9l6hXMHxilgzchRdjrmLAyo7wkl15vJH9Akq1J28/aluHZG1nXer2ezrkhhaoB6iBvnIz9R2rUQMkkRfJEF0bB+CvG+xW6XaNp9gmnjtnzAUvG1Xn+tGCaKmhtJVa8wox6BzSSotk7vZLtxhipv5kp94n0rchtUNEG3Nlhu4BAomnrydQTC5ubdaD1hefr1oUozv/0SQ0LJ7JmWgB09CiqcR+cJWJs/X1bufRA0ZZfNkKbqDxgBiIy3RFDj3Synd9+oY/wkIxAkFVJ/qR3EPx+xPEAUoLzf8vYRrY9n9Ia+nTi3f9dK4H2quOc4p0Q0ti66/ypQ7Q04wX5/SURRJhnyv5DWbI/i6bqC6T8svg9Z1/3/MKI+jdYqUb3kw1hm6/ZS4S1MYWxrP0PDRK0adr+E9DVEucLfSvgR2FXtVlUObKfp04LVddaryCAY+Cr43fOH6xv1Ps48zLoV7MWmm05QOu42TtMQ7ooF4jL/UX/JQ4QfeqWVuYjZ/oEuRGq3VIjIOVzzb7vFhM/Z+97OwTF/eZbBd96PauAd8jOcutbt8dO2yHUDC+I9UaJElE0gVHPSi1lTnmQWuhi/G5+XR/FfRc/w4dQPvR9iB3mcT10NlDeCpF0PXUUDkUPk7QUS1kUUlAoHc4YTXm7AXeAVYnd6pnciclFibt9KeUbb0nVsofL3ak1PfE1UI+7z6EUrfpnphboGLDb8hAQrMedUOP+dnEDnKcN9an7Fg6GBxxUMouM4OiDKp8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199015)(66476007)(36756003)(86362001)(66556008)(31696002)(66946007)(31686004)(8936002)(44832011)(38100700002)(2616005)(186003)(316002)(478600001)(41300700001)(26005)(6486002)(6506007)(4744005)(6512007)(6666004)(8676002)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3l0TE5RaTh3dGUzbXRCYUxMeHVGUUU4dDJIaHdYZi9nQ2trNVM1ZVhEakJ0?=
 =?utf-8?B?MzRUbHppR1Nidkp5ekhBQUFsOXQ0MXIxbTByQzdYY1ZCZ01wS0FsRG5BcGth?=
 =?utf-8?B?V01rczM5NVZnV1orZDdCUzBoRFBHYWg0RFVaZzlkMUpMU2NkNVVpRDJMOXNK?=
 =?utf-8?B?THJpK3ltRnE0SmdWbHQ2VW01TzNVeWJ6ejZrZXc3dDg5UGJPUmNqdXFGSW0x?=
 =?utf-8?B?RTYwcDBhN2Z1eFpoL2FhNXFUMkZ6dXVQSG1UU2dJRVc3VTBtWGp4VEM2TmF5?=
 =?utf-8?B?V1FVYTJsRDVFc0VPRTlRYSs3Nm1lcW1DMFFmNnZKSDdjZ0NnMjQvN3hldkRj?=
 =?utf-8?B?azBOcU43bkhUYUIyWURCMjlSL2hhM0o5OVI3bkhVSDNXeFQvTzhGS0V0OTFI?=
 =?utf-8?B?VWZ6S09LR3hoRDU1aXJvaFI2OVBMSVVhQXMvRDBOdnJJT1ZZNHBjbTNHVEt1?=
 =?utf-8?B?ZEEybVpHc1VTTElXUFV2Nm5tVnpnSFE3eXYwWEY0emVTSUJwZDY2QUVMenBD?=
 =?utf-8?B?Z1dEWFBWaXA5OHZ2cW1UQlYrc3BxaVBQZVFlUzJrUCt1UUx6SjkzMHZGWXEr?=
 =?utf-8?B?amcxTVhqOHpNKzVUbDZmd2RDNTVOYTRjWityQUE3Y09CTkgxcWU4MHorQk1t?=
 =?utf-8?B?czgwVjg5R09mRGpxcVV1akUwR3p3ZVJwY0RzdGVkOTVRT2VzaWtXVnFHMHlw?=
 =?utf-8?B?blBGeGpteVdNckxxV0R0clM4SlZRbXVKVGN1eldEcW1nZkJ3d2puRXpoL0hR?=
 =?utf-8?B?TmdqNkdpOG5vMU95RC85SmZBalUwR3EzSVB0UUd3bmJmekx4dkpJeUNvNlZk?=
 =?utf-8?B?bEt1SC82a2duZkNYdEJQTGZSRmlIQW16SjNtODNWZThNMG5rNGYwaXNNdlVP?=
 =?utf-8?B?TzlSd3BUVm5kNWMrWWhSV0JnelZqaW9hK2dEdUFzRE5rQ25qWWUwcXVKYlMy?=
 =?utf-8?B?UEg5VExVOUYxZTdGVGFib3ltcnE2N1JleFAxRElPOXI5NVpyT1RRVjUrMWFG?=
 =?utf-8?B?ZE1ZZEZUeEl6QVZBVTlWeDNQaWVFTVNGZjBPYjVZYnh3VUhVandQR1dsbmZy?=
 =?utf-8?B?N1lJU1Zka3c0V3lGUFFXZmh1SVRtS3dwdFc1ajRnL1ZVeUp2UnM2eFcwbHl4?=
 =?utf-8?B?Ukp1ZjB4TnQ5Qmx3R1g4eG0xcFplSXo2UWxZSnB3a1lqcHcvZGlEbVhDT3NF?=
 =?utf-8?B?cTVBWEZ0TVU1SFhaSnhURkRKRHhSVzRrdGcyN0NSM1gzN1FVSWtZTS9mQ2FK?=
 =?utf-8?B?VERrVHRUSTJobmhLclhFTS9LV3V0dTBJQklGYUNXSFNVdEZKZm0wUkJXZ25k?=
 =?utf-8?B?VHc4bDV4cTRXS1B4dHBLVi8xR2wrM1Ricmg4bmxEdkYxMlF2QWtNMnZJTHFp?=
 =?utf-8?B?aVBLbjdjSWNhK0VVb2k4Q2pqb0xpMVZIbnZsZWVwTFJHR2JrbFZXSXVaYlZX?=
 =?utf-8?B?bXc1R1A0Mjk2bEZub1RkYlFiQnMrdVFCdVJRY2I3OXkxQjNJNExaTDRxb0M4?=
 =?utf-8?B?K0hpem5ldkc3OGxIUzh4b1V4MWFPVlhaNm5hSVEwOGdqd2VFWEtjU004UVJ4?=
 =?utf-8?B?Yy9NWWpuQ25BTVBOTHNsaWx1Zy9EN1dGb29xMjRvdTVLS3A0L2ZyNGdPSDJN?=
 =?utf-8?B?R3pWQ21odmhqQjRqRXgxZ00vS2FtWStHVFBEb3ljNVhwaGJxU2RyZFB1bjVn?=
 =?utf-8?B?U2FzZVBBbzkzOG4yQ3lsQzdwR0R1NStUU0FjNTRqdVY4WEZpdlVwTEpFbE9v?=
 =?utf-8?B?U1QzcWJvZ3VRM1B1WGpWcXNpRGY2eGJVMUVEd0xqa204TWR0RkVVZHNzYzNk?=
 =?utf-8?B?MWdETWpQdFhTaVZWZURhMmhFMGlIZi8wNTAxZXhyNHhhdzhESFJQdG1RYkpK?=
 =?utf-8?B?d2dUZXY4TGl3STA4Mmpib3lMWlNjRmgvSjdKZUszakJvOUltbzlTZ3NwT1Mw?=
 =?utf-8?B?bW5hY29lRGRhVm04THVqS0VUYnJiMExTcWt2akltMlFKOFFMWFBUSlI5dTk5?=
 =?utf-8?B?ZmNzV2hwdVdrQ1g3em5TZkRLVTlHd1B2ZUJGWmk3MlNteDNkVHhxWlVkWTZt?=
 =?utf-8?B?dHhyenAxNm9PRlI4aytpTjN6cHNvZllyT2Fka3dwandHeTR2NTVueDBRMFJG?=
 =?utf-8?Q?4sjOk2I50sqcB4lYHDUnmjfgX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e54c22ef-400b-4c78-15b2-08da97d428b7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 11:11:10.1106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84oGBzIa5bnq0mXPJkJ/CEr5c9iTvVOf3HKpRv6uZfXuxm/yRHd42AXqFo3vNc6EGx5oj7pFZ5eFjtbE7Fpopg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_06,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209160083
X-Proofpoint-GUID: nGZEBvWJ2BKHyMSUIjbTGScegIvYK0Et
X-Proofpoint-ORIG-GUID: nGZEBvWJ2BKHyMSUIjbTGScegIvYK0Et
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> +void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
> +			      const char *name);
> +void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
> +			      const char *name);

  There is an extra definition here.
  I think David can take care of it while merging.

  While here, I would prefer to have functions arranged.
  Like, first, set-function and then its related clear-function;
  it improves readability.

>   
>   #define btrfs_set_fs_incompat(__fs_info, opt) \
>   	__btrfs_set_fs_incompat((__fs_info), BTRFS_FEATURE_INCOMPAT_##opt, \
>   				#opt)

  Further, the #defines are in the middle of the function definitions.
  I suggest they be at the bottom of the file.

Thanks,
Anand
