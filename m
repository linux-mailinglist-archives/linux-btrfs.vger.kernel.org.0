Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAB85BAD6C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Sep 2022 14:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiIPM21 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Sep 2022 08:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiIPM20 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Sep 2022 08:28:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F04CB1B83
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 05:28:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28G8oHT0014472;
        Fri, 16 Sep 2022 12:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7rDSyNRBnzHbH9BMyIL7AqIzPL4bKusnVUjHu4wmW3U=;
 b=z1gnXT9rPJQtB/xGBKNL51hx4aRlDrDD4ofNnawu00UBSKVspMmrh572xKn0c6QdhL9f
 3MoypmKoZ1mkZCQJkPgKZxKrjL+HrFmSG0D0hoM/Ffx6BR8tYGyeijw+5zKYGnkbvg5y
 P/36H1JfpDqQJBPA9Tu92WJEcZ8X8e3QscXgjvIaeTHKFz/lK9Sb3wVCNV/y/fhT3gLy
 D6VMnN9oJBzAvdp2x5O+bnTyRqnjdRBEZWW/fBJ9NVYFQb0uRFpvVEVzXxcEDkz2Z+NR
 /0ndReFDZwOJ1e6obbv/5zTgMGz4+bSQ+8zE/pu+VJ2aUUyJx+7frzmsY4VRhpYfndct vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8xbaega-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 12:28:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28GAtJUA019970;
        Fri, 16 Sep 2022 12:28:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8xfxxm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 12:28:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fv9Uuxf7dky5RmOLr2TsMgLdaD5C1SLd5KbEZokZWXEvzr7Zh+LiNnwV/bnh0ia8ouMqaZn01w+ivN4De7AAeBspyYhhJ11o75zqzGUNym+eR1TL1ZryxEVcSqbenZiCwC0o/SmL4InV3I7bqK1ogRs+dEOoOg87vFvfFYa7W/Hp28ancSm3DzVSgF1BhnjC/5l/gMP6vH1xq88DfNBPU9DBNCqIlT6rD3MAZugs4bhQaMMxGoo5tHpIQGO3yfyPecLfT4sG6qwxzznE4uaLxAVBvx130PkwfC/uIWRa9++GXgzrCzdmXOD4PFVycxtBlqu7mDcJXO9Vfz/YCdtfwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rDSyNRBnzHbH9BMyIL7AqIzPL4bKusnVUjHu4wmW3U=;
 b=aPXMONiEMe+sR+yrcz/hYyeHN8fiFZhu6OuQI3s2NGSSbymh49qeKbOtoYgU8VMrgVQPmqXFwS/Undh7JP7nvFhB0UH4Zn8plsPhlGc9Xcih7ReL1smPSS9c8kM1nQmXhpNnJX62oL/Za3laf78lNWtno3sPhvURCC3EpzhmDsIQcwnM5Pp9JvFz1TFqBN4l/NlOhsivlY4WVFstDlNG4UdITluxJ5BlEsyXsq+TP7DBajHylUt3FDcZW2oUibIGS1z/dXRf5ExsCPzenUIi/FgVJAFUNgk+AnghiIxhBeJDSxbnLWtmlezz700sxqr4rsxm6rLjXbjbsivIzzMsqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rDSyNRBnzHbH9BMyIL7AqIzPL4bKusnVUjHu4wmW3U=;
 b=MsYycgcbHBSISzoCNiKkLgKVLBDqV8NT4usHPD3cuWkeGOaICPZKe6wiHjR8Nb8TgZraBLtfSHBbNkNNt9eQhWe1x+x7Cccqw86Iy1uGi8mz6zCyedXibALcCrjF9vuAjO4/WWzTszrO4j0DdGf9zFWD8LHAQN/Uc2vcYK+Ep8M=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN0PR10MB5909.namprd10.prod.outlook.com (2603:10b6:208:3cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 12:28:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Fri, 16 Sep 2022
 12:28:20 +0000
Message-ID: <63c42b65-6035-742b-d926-a371aeaaa6fd@oracle.com>
Date:   Fri, 16 Sep 2022 20:28:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 04/16] btrfs: push extra checks into
 __btrfs_abort_transaction
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663175597.git.josef@toxicpanda.com>
 <6a4275319be8321bf3d87c2259a427ebdfa6d7cf.1663175597.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <6a4275319be8321bf3d87c2259a427ebdfa6d7cf.1663175597.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN0PR10MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c6ba18-0093-4f6d-cfc2-08da97def03d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZPwxNCU16eeq+PxIoGdpXbQ10DKXxuQAFX+ftQkYK7zzd4/ena9gC9tjJucCIiY+oW0Pr7aXEmhI5A7Jojl+AYoO6gJ7kw3eqNhvIuuoVvraKmzC73l+xhxXX3Ms1FejiqrpXhUvTITrqTrLrWI6KHvvzYSpL+Zl3Q4bXEz5BcAGpOVmQpgH3qc4gCPvIpRTdGahGCTjaIUzrnvPwnfymnRcej0rZ9FVbXXPUnAzgft0e4HlnqvpjipahTT3zWD9eeYmpns1qU5c681uNg7wEjTGHu3o5GAL/Dnik7AWbENA5+/8fmhONV4laTTbpBIyK5v8Ro5taCf4KO3Q6kn2ruLFJ7sTJmb0GTDiYDafQtFe8oxKQV/PPaYhjRZdfScrt5I2tfXiLSEicQwAtJLCLBGBNm+Rcm7XMeJQKdeuC9up1JqbjOsWtoViuYFLkDjFA60ZxgMCip5ssjaJu1Zl+orEOd1+Mjt1rGtAUWR19M/XV+oqHgGXl/PdKlqU3tbQ4l2hceOiv7iCHbCr8ZzN5qvV/IoJ1fGUf5/PdASzYcykABCY9j73Xm351m0MU6rpOBuNGexfQiHu6AM8YPakCa2UfLVo5tNZROjPD9wZsIdGZBA2wqtkLNxQ4kh9uq/9lfsnBsFfp1mUaMvM+sBseAoII0B30vGp/oO0yxs4/KBMtpGVlwmSGU6g1VCn2FLOYlfNvMVRKUGlsxxW2fTiqLbF61O3Yift+HMIJajwTeHacJazC7CXGYkh8gZob3R5MsTr8u2XtFUCZil1o1F47CTsKGF3cheHrShihgmnQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199015)(6506007)(31696002)(53546011)(4744005)(8676002)(186003)(6486002)(6512007)(8936002)(2616005)(41300700001)(478600001)(6666004)(38100700002)(31686004)(66556008)(5660300002)(66476007)(44832011)(86362001)(36756003)(2906002)(26005)(316002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmN4UEIzWW15czJmajJJOWIyQ0RTSkFTeGZCZW9SbG5VS09sbERvTUxuR1FD?=
 =?utf-8?B?S3hZRk44K1FnU3lZWkV0NVB3aXU3RTh6bkYvNXRhOTBMdnhMTEVua2lzdHla?=
 =?utf-8?B?RGYvbzIwOTZmeG1BZDJDd01XbTNPTlpIMVBVL25NU2VIWDM4cHMrOVVjaUtK?=
 =?utf-8?B?SHRVM3Rob2t6a0paRHlROGtRUU5XcDE4eWNlNzh0VjN1ZDZzeks3M3pjaHR0?=
 =?utf-8?B?S2JvdVRyc2RxY0dJTjhZYjgzNFVtTkxyeGpPMnltQ0hGYVcvQnM0ZmpoeTFh?=
 =?utf-8?B?VDIwcFNyd2F3RU5HK3ZFWFVyL0pjVy85alE4L2VROGlVVEc2QnArcFBLSjBV?=
 =?utf-8?B?dHJIeVduSW82UmRsUDFKQUdON0MzZVJzWWkyNVJDMWpWN3kyRkU5UjcxZlpr?=
 =?utf-8?B?NXpJeWlNUFpBWDkrNWdrcGFOTGdBWlc0aU9idVg5cjc0aXFiaE93T3c4cHQz?=
 =?utf-8?B?TUdQT1RUVnpudTNkT1ZEN01YNUduRll6MmdyRmQ1VzFSVWdWSlJaSXkyWWdR?=
 =?utf-8?B?QUh6N1BHV0hVV1c0M2FoVU1UVFk3d0x2VXFTeldEcmRhdDk2NHd0RzJiVmVB?=
 =?utf-8?B?dTZSUWlFQldkcVF1Snl4RldkOHZEU0pwSmFnOGV3TVVySmNCbzQwR0hRZGE0?=
 =?utf-8?B?Y0Qza29CdmpCazFMWGZ2cGFETUo3OFBpQnNnMHVaQ2l6cXdGeGhLVUdVL3N2?=
 =?utf-8?B?M3JWVjBzNXNsbDJJWW85VjhBaW1EeGc2NFdBeDB0QXhLSkpITnREQUQ1QWhR?=
 =?utf-8?B?MHZJVmhqdFVidmhkajlKZlJjUzhKand0eXIrb0xXWmdKejFTRlVmSU1HOFFw?=
 =?utf-8?B?cUk4akZYWUcvWjhpdXNyRktIUjVmRHhyTW84dWMxeHBXLy9YMmY0ZVRNd0M4?=
 =?utf-8?B?Y29PY0ZWK2J4ZktERW16ektrbm5CZlFTSzZEZnFaRkdpcFJzZjR5eExsb1hr?=
 =?utf-8?B?QUpKaStSTUlYWXErVnlqVnE0VWFaSDR6L1Yxb2pjZFJHeTFnZEVCS3dJOEJO?=
 =?utf-8?B?V2tEMzdUNVczNEJlMUNSWGYrWGtabXdDdENnQ3Q5T0RWQ3VGQTFBUnZMem9C?=
 =?utf-8?B?RUFTT01wa3d1c0pYNnAwNFl4R2dNL0FDSWl3NEFaUHVsaWxySGlNMUdXUEVP?=
 =?utf-8?B?VDNsNHMwNzRRdTR1dVQrTHR3dXBZUkRoQzROMXIrYU5DT2hPUHNlMG9EaXFn?=
 =?utf-8?B?VnV3aURJTll0ZDd0SU9ZbG9GN2V5emxZcE8wbjZ1RTFseTdkYmtacE5sTUlp?=
 =?utf-8?B?N3F2RWZkTXBCY1hMbjBicWhwUjl5NW9kMjFWNDB3L0VzM1BmVEdnaUJaSlRn?=
 =?utf-8?B?ZGxBdjhETjM1MmdUbWRhVzlNSzBjS05Xcm9XTnAvRFVGaUJBS1dxYXh4alZX?=
 =?utf-8?B?MzY0YVNQY0lmTUVMaDNKQS9wOEJOU2lNK0hBUExmYnZmYmtLVGhxVEZVVGZY?=
 =?utf-8?B?SmZ4U25mNitOYTJPdlJLdU9qdkNkQi94ZENaTTV3U2RIYUZzQTVjTjdjdzRI?=
 =?utf-8?B?K0cwMkxpY3pwejBFNHh2OStKY0YvcyttbXg1OGljV0VDTCt3ZVEwWlMwKzB3?=
 =?utf-8?B?azVxbDA2ajJqZHVuSXpuMGw2ZFZDR1RtY1pwRDUveFhad2tFd1ZHOU5DV09s?=
 =?utf-8?B?MDQrdkx1ZGh1SEoyOVRRNWFDSE4xSlRZd0lSbTAxM1hibGt0UDgzM0xhUkdt?=
 =?utf-8?B?ZEdiUXJCZEhnaUZwcGQyNDZPM05RVXg3RUlVTk85MmttVGI0UXltOHdRMWRY?=
 =?utf-8?B?QjB2aEFIMEI4UXR6akkzT3JjWFI5QUdBeHIwc25USVA4NUFGNG5KNHNHVHc0?=
 =?utf-8?B?ZmVpVXlPTWNaNXpnc1hhTE1vYjd2U21qYVI4aHo5WFpIbGlQUVBSQUZXZnQ5?=
 =?utf-8?B?Q2dsSkpSVE9KK2lnRDcwQ1dCYTFhell3bEhjMStoVWd0U3BqcThiUDVMVGg3?=
 =?utf-8?B?eEo1dXpKOWFrcER1dEdMYkNQTkVFN2J1UWNINDd4MG9leUl1aDVpNHE4c0hV?=
 =?utf-8?B?WlI1aWJ0MUtISmZlY3RCcGRCT3RDbDR0SElEV2VUUWlIelZSd0JRSnF5ZWRZ?=
 =?utf-8?B?NGgveG50N05xVG5LOVk3bWYxeWVPTUZqUmhOZTlNckJZWVF0c1Y2WVVSSmpH?=
 =?utf-8?Q?dEyhezYYm+H+O2S+g+d0MY41W?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c6ba18-0093-4f6d-cfc2-08da97def03d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 12:28:19.9368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zJzDyMQAnBBC6XLORAMQbmEG//QoG3WoV/7wcyYNb7c64+T5HBGFq0sMW7uqpQsVUJpOToMVAOEupZgsCt0Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_07,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209160091
X-Proofpoint-ORIG-GUID: o1lWTox3mrfJZvRK6OTA6_Wz4HdgpwvU
X-Proofpoint-GUID: o1lWTox3mrfJZvRK6OTA6_Wz4HdgpwvU
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2022 01:18, Josef Bacik wrote:
> The btrfs_abort_transaction() macro uses quite a bit of flags and such
> that aren't local to btrfs-printk.h.  Push this code down into
> __btrfs_abort_transaction to allow for a cleaner header file.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

