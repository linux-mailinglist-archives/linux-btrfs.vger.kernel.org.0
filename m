Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24576C5CEE
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 03:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCWC5I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Mar 2023 22:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCWC5G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Mar 2023 22:57:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A4110F7
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Mar 2023 19:57:03 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MJJ1q8016258;
        Thu, 23 Mar 2023 02:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ivArG7QpZkkMrowUTWvsaw/Bz3crDJpH4hs7d009i/Y=;
 b=dcHtCX7DraX3/oKzoCBaG5hk2DxlC6WqsvoOlz8NJniNHw+Vcz0DxoiSb0/tYAqDFvE+
 6RNeYnncuxJg5tKr7s/Jn3/z1zMXWjmmCJMOCuT/k4w5QVRjkl8IJHX3XEjPuV1peFHI
 IG0jKAfY+aIPhuXZ0kJrfflcCZhIKapOuun3GcuUqft8a9l+28F9EYWuyw7AwnQyirI9
 uSsj/t6oLZX1iJcn0RBmNSNAILj/A8qi1DrjYTT25ralCouImfTQvbHsUKOB2M4OjjKu
 4D37O0E4/ZlaOXtfey3YHrQGIwOWPGhx8GhNcyqpZQIl/tAx0+rzv5b4IKUJ0MCzP8CR 9A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3qdte5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 02:57:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32N1rnAl031973;
        Thu, 23 Mar 2023 02:56:59 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgdgphera-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 02:56:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/WQPPIY/jXkmFFBklTFIOg7oNBOhghCaqXKSpkC7f6mPE36o+bQpj3JixdZ/zruJr47GZDRTXmZOofhz4k/4RoHUVUfJq63Tj24Jdcl6jgJJZj6QlvChcZMafPU72YNwkS8BbK30PExwXMuJ4tRv0CpSwWzKTANZRIye0zOvgEhV8Gl9T9a7qt1jjmBozgGtnbY4Wc172uguefvhnf7auc2Xmo62iv1VDTwD3RSrTQjLFdaku7vEIk3L16ThdPlMIZnEphYU2rPNXVh2zwN03jMPIRMYza0qbflTzwRPOs/wrGHN5s2TFpENe2X2KdFyEWCfMkpXw1aYWZJyJgTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivArG7QpZkkMrowUTWvsaw/Bz3crDJpH4hs7d009i/Y=;
 b=Q6iJllIfiXueu6unjRLbwKkrcchUDFiNUTsIPbcT8Rpja6pp90gb3EqSgn8imJdB7A1lpxTSNeTqNwV2q8Km3yY+E4JU9PpeIPeWk9zv2G+bRAbKFR8MON86S0sQ2qle2C9LIrMp+SVGftnXh5S2U9Z0DLr7YavKgv8qgfkm7BMQcHAYZNvucHoNZl3y2UBQ6xgoHm9Pk1mv07quVUna3I62aCTSwpS76KVSTTvgPqbjCxIeI6/Un48m/zmWL4hAwoND41d07irm6nmUjpYaiiiLRoUish6RtcSOCqR5ZkDnlgDNElJZj0QGTJNXhT9xjTAMqZcQ1BiWJfiM+tSKpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivArG7QpZkkMrowUTWvsaw/Bz3crDJpH4hs7d009i/Y=;
 b=w69Mz9DY8UbRmgrirqhOL2udSjyH/RqyAzGgtFDr/cjXf4bLD6GkA7j/7p+/uOIjrAz0/7Ht2MRipQBpqcoBVT5THLw6WW6lYYqx6Oo5HFN9siqyE2dvudhkEUWmsh8apZ0AWirwIXQ5Z4yQCswhcR9RQ/Paf+mHGcGZA887TYc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4238.namprd10.prod.outlook.com (2603:10b6:208:1d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 02:56:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 02:56:56 +0000
Message-ID: <1ebebb48-4796-66d4-35ff-8d1c1eab492e@oracle.com>
Date:   Thu, 23 Mar 2023 10:56:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCH] btrfs: remove struct scrub_stx for superblock
 scrubbing
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <10d0f55b196d4dc949f0ac29f2f0af023eaa7523.1679376183.git.anand.jain@oracle.com>
 <35929eb4-7467-6cae-3d5d-3f6b239c11a7@gmx.com>
 <601f517a-2736-0f35-fde7-965de0daf36d@oracle.com>
 <24d97721-6906-7633-4fc8-c5d9b0b35b3e@gmx.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <24d97721-6906-7633-4fc8-c5d9b0b35b3e@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:3:17::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: 741c5edb-5450-4a50-947b-08db2b4a438a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xjIsuQyCbb8vY9mwkvQWTFJZILsXp+qgyNaNYgV//A38xkXI2Tx0aDESUtVNXdjLFie4ced3Hh7Vi6S9aWzA5yXs4ILZEpyyiu8u/S+D93uCEVYvz2+yq+TL5jgWuq0Pl/TnDoq9XvnfHLXwcEV4PRquvIsiZJpwD6cP9+vnOw4SlICad/fziiMqIC8hGGf7BPPrGlSEqQQUtRAK7Qw23FSP/WILAPo3r80+u5Z9jkAD2iIP+B4ECbye3Xc5u4GPKkk3vJQpqbwAoQsl/ZkQldMw/7HcmxPcAP/3TqxHY5bvSkxGiYS07ayNL8b7LdU46VxNdSyIqXQcDcQJ2EHs1RWaXAglDdtZxx4qttXhnJXlw168T47xqWJi0uPvjxCtGBEjAcuPZA4rPxir2HFCl3EgBallivi4OzBZrnxb9fDzrnw9vMHrEjjzAiKjfWOnocQrB/v57aEhmroGeexrm70aoHnMgffOdgcCBSkQsasczZxuDE4X5Ry9C09fvwIsjQjhciYSTPlqx96XdMagfulVnQcMhC97tkEKK/J8YpIk5PIDtgrMcy1n6AkALVDp3xv3gNC3shRqMZivIQG4I2KDTWWvmVmUUMMNmqX5sS5YTASw5zhBr1xZtk9ysEHRHhSBZjwBjSnRiOZR2np6z51JFDC1T69MDDQllj5/GinSadiVKAedITrrdQsQxEU+1hvcscGbhalnjvJ9BgKb9Gg1IDq3KiM/oUpGE0sDEX8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199018)(38100700002)(2906002)(31686004)(83380400001)(478600001)(6486002)(2616005)(26005)(186003)(31696002)(86362001)(36756003)(6666004)(316002)(66946007)(66556008)(66476007)(8676002)(8936002)(53546011)(6512007)(6506007)(44832011)(5660300002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2Z0dzdSUk01MjZtN1FJdnFRUmhLcVBWS2hEMUg0SmNpNk0zV0YybjJtNk5N?=
 =?utf-8?B?SzI3T3BHY0hBM3lqYjdiS3lubWRMTnN5R25CeGZBOU8xNDlTOW5PSGZpc0sx?=
 =?utf-8?B?NCtEcDJiNXVxM1FCNFBZd1F3MWVic2VmOXVrbW84NUV6RkRtWFl2ZTlDc2hF?=
 =?utf-8?B?eG5nZnlwRTdoQVI4V1JsNzNYWFdsc0ZocS92cE5uOXlDOXF5eWpSZHZ1RTRl?=
 =?utf-8?B?NkdMNERpcmVMWUZ4LzlPamFPT2NBcldNd1NNaDNkRWRDbUo4WFZkSnhiWjla?=
 =?utf-8?B?S1JsMlI0Y3VLbldVKzFUYTBlb3RSWXFsMnBFRGlmVytVbTRUVHlCcGlMNVNC?=
 =?utf-8?B?Nng1eWtVcFRRK1c3VzZkdnRhbDZPQlQyOHFvNWc5UTFWdUoxNXVlZlhQUnJa?=
 =?utf-8?B?RVhCdWRWRWt2SUFyMmlmaklPYTNIZFFWNVVFMFlQOEMwcU94SG5hSXp6S0R0?=
 =?utf-8?B?ak9vbndBT29ZS3RSOVdWLzRUU2YzaFFjbExMcC9xQ3Iyd2RuWUtxQVFpUW5K?=
 =?utf-8?B?QS9pS09NallRS040UVJQQjlKVnV6VHZ5Mjd6VkJzdDk5SUpYSGY3NGVZZmhO?=
 =?utf-8?B?QVhYa1NvM3k0RndsNGhIVVhZenpoMW42WmpsSmM3aHE4MG1rZnNuMitIUmR6?=
 =?utf-8?B?bVcvSkJEUzQ1cU4vT0gxTHJjaFZKTmlscGpWWWQ3eXdNTmhIY2FtR3BKYXBD?=
 =?utf-8?B?ZHdGaDk5RlVHeTZ1Wjl2RU5QMDRvYU52OVdGemhmeUdta1RLeVIzYkMyNnQ1?=
 =?utf-8?B?SlJWL3V4OVpscTdieEQ1WWJXQ0g2Y3FPc1ZNOW5pa2cwRm1GNW5ScHdNY1d5?=
 =?utf-8?B?dXFrOHFNRFBNc1ZOUGdsendRdFdmci9oeXJtUVdibUdUWW94WktGckZxczlH?=
 =?utf-8?B?NzNVWUJzb1JodFJUUDhiRVJDOEtCeEFRRjhTNk5hNk1VdGE5cFc3VGZtNUd1?=
 =?utf-8?B?VGg4ckVFeElKQTFISEUxeUtUL0pOcWxsV2Fsem1aeUVzNk5hNUtZNTFrSGM4?=
 =?utf-8?B?TFdPQ2lFcmxDNjZBU29CVUV3NTR0MkJwNmRJOUN4OENCc2F4VENuLzJ3WnU0?=
 =?utf-8?B?ZUwya2JaYURoSDdMN2tRMjRHRGFKd2tXR2VDMlMyajZhZFJ4ZzRyVnBUYndU?=
 =?utf-8?B?a1dxUDgzR1dDeTl4RFAvSUVNUzhCRkxnVEx6K29FaVE2VDJmVkYyblRpcGRF?=
 =?utf-8?B?THpnNytBckUveUsreUpRM2YyZWhMNnZqZ0tiR3RPK1g2QlNWTE9MVTFTdFda?=
 =?utf-8?B?Y2NxVmtQc0RtanlJZk9xL3NDZ1l1UTRWOUlYcDRsM2VjQmFsK09lUjBOU0ZE?=
 =?utf-8?B?MzlBek9zU2dSY0RHbmJML1NoY2dYU0MzaVJ2Z2FXWFZkajRNQWh6bmZqNXM1?=
 =?utf-8?B?em9oV0V1akdOZDlESTlqUTBHLzl6Z0xWNXlQaENaN2JuSWZyVGF2aE9MY2dS?=
 =?utf-8?B?OVpIUWt6QnY4dVcwRjllZlVnYmRoMkFtWjE5ZFFrTXZuTy9CeDBNUHFESjYz?=
 =?utf-8?B?QytoZWpIUUdUdjZ3MlpIbW1aZjRRblpTYjRDSVlqaFBCcURobTk3dDkyMFpE?=
 =?utf-8?B?clBUTlBpT2xmRy9BQkdHTVd6R09Sb05pMEFCMkkyZVJzYkxXSlhEdG5FZlV4?=
 =?utf-8?B?bjRqdXd6UU5nNk1Ta1hQYjdQb3drZmJhL21PMHBjNzRlME5xcHBMaFp6OVg1?=
 =?utf-8?B?RXM5YzZvRE80dmNPbzNEU091aUVMekl3TERYNlpCTGRHcEVxUW1mUE5wcDJ3?=
 =?utf-8?B?dEg1bnAvNUsrbFhoQjBnOEpqT0dxNTBqSmFzYXdLQmlVbzZvK3JhTHptY0E3?=
 =?utf-8?B?cXMwY3BIK0ZIWWVRVTNDWUxXR25TWElvMkF0TW1vcnY4cWlRckRVQ1FwRm1z?=
 =?utf-8?B?N2NCb3RWVjNEcm9wQzVOM2dHcVYvdmhraXZKT3U4QjhrU0s3MFhhMjVVNGlk?=
 =?utf-8?B?djluaGJtQzY1WTU3NldmWjVZTjFzZWFoRGh6VSthRExnd0ZzL2w1RjFESi9j?=
 =?utf-8?B?dDY3em53VEpjbmE3ME5ORC92T09QMXk3ak12QWdWcUZLbWRHRFdVbUxQUlhR?=
 =?utf-8?B?WFJzRWtDZlppRHFyRTljWVRHaHdLcXRuZE5ZYXN2Zkhna2dRU2tBNFRLT2hD?=
 =?utf-8?Q?bkJ6jnxDDmfYyDrdjcYmx+HDg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ayLjhYd0EEoK0ZhoQCE3drePK7256szP8vUE9FKRF5CwmdIigtHM5M+4mRE2/MTx5/BcMw1cYcniyjOuLu3tRz9JsplKlD1Wkgp5isRHh6ogco5Q6kJ8j3Iaght08D7prLjSH2tv0v9Z3CKkkKZw+8s+H4o3ZWz+qe/kYncGxMs37kE6AdsVuFX1dRzmIto6Pqt+lpCcOoKF3VqR1pK2SUz/JJVq9PC4ZS8QcZ6Zuzd+qEWGkhVaGi2S3Tho/pZpBLHQ2eljrjdfu9kV+8znEjBqEloqKh9REmPaZ2rT1ij/PJxdhBcIPRUJvq/roA5Ww3qJ8OuvP26tST8MHv40jxMBo3mDdzPDcXwntuYQFOpCUarVf9x+6QkOE7IFdO4rJgdj/M3ctkVTwOSZ/m8P3FypUAV3wMle2a2+iABgc8pOd9/PBuQdh/Y82uJtU2IffSyi4PIVsEjPVrEM8S/QtRm0lxFe6CChc987wN8JYCKRngxAdsljJrE4rftig/PVzl80BIiQB5jsN5Y44eMGmxW9f1RnjOoGYQ5KNBdlKmqg+AzgAeFpk6xKtuDBJr3Y3eEtAQN9FKCkZEkKVKI/xV16ZGCmtkhkijCPOe0nh5HmFUgExMi5RxmZsYPRwHpI05ip8Yj6JKksECS1Nq7r+Cqd9769AV21aNvl14I2uf+K4B1CuSJ6m2L/jNUaSNzMa1RRkFkQHBMuCkVylH9G/TrZgwDtesrumU8IOVc2UJ1MhSlNt8Hirg7YAbG/GSWdSt3y/VI9EVstSReX648g74qtV+tsIICqGID2RIDQMxE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741c5edb-5450-4a50-947b-08db2b4a438a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 02:56:56.7395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZrmde6nbFwKcemw/ao2zRSrOLsdQGYQz6WxNAC+8fnMXOWKfG9FIIjrM9ZFSskN+kVOrVqqIwOShiDLmAu4FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4238
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303230021
X-Proofpoint-GUID: XWqhw-LH-ByzoQv2Yh3kCXtwFE3KjnAQ
X-Proofpoint-ORIG-GUID: XWqhw-LH-ByzoQv2Yh3kCXtwFE3KjnAQ
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/03/2023 09:13, Qu Wenruo wrote:
> 
> 
> On 2023/3/21 18:11, Anand Jain wrote:
>> On 3/21/23 15:26, Qu Wenruo wrote:
>>>
>>>
>>> On 2023/3/21 13:23, Anand Jain wrote:
>>>> Following the patchset that implements reader-friendly scrub code
>>>> made the struct scrub_stx is no longer required for scrubbing 
>>>> superblocks.
>>>>
>>>>    btrfs: scrub: use a more reader friendly code to implement 
>>>> scrub_simple_mirror()
>>>>
>>>> Therefore, scrub_ctx does not need to be passed as a parameter,
>>>> (unless there are other plans for it).
>>>>
>>>> This patch cleans up the code and is built on top of the above 
>>>> patchset.
>>>>
>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>
>>> Looks good, if you're fine I can fold this into the offending patch 
>>> in the next update.
>>>
>>
>> IMO, this patch is a cleanup rather than a bug fix, so there
>> isn't offending patch. If it is folded to the patch 1/12, it
>> may be too many objectives in one patch.
> 
> The cleanup is only possible because of the patch "btrfs: scrub: use 
> dedicated super block verification function to scrub one super block".
> 
> As the old code relies on the scrub_sectors() function, thus needing the 
> @sctx parameter.
> 
> And it's indeed my fault not fully cleaning up the parameters.
> 


> Thus I believe it's better to fold it into the mentioned patch.

  Yes. Please go ahead.

Thanks, Anand


> Thanks,
> Qu
>>
>> Nonetheless, I have no objections if you still decide to fold it.
>>
>> Thanks, Anand
>>
>>
>>> Thanks,
>>> Qu
>>>
>>>> ---
>>>>   fs/btrfs/scrub.c | 15 +++++++--------
>>>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>>>> index beccf763ae64..bc87277559d3 100644
>>>> --- a/fs/btrfs/scrub.c
>>>> +++ b/fs/btrfs/scrub.c
>>>> @@ -4909,12 +4909,12 @@ int scrub_enumerate_chunks(struct scrub_ctx 
>>>> *sctx,
>>>>       return ret;
>>>>   }
>>>> -static int scrub_one_super(struct scrub_ctx *sctx, struct 
>>>> btrfs_device *dev,
>>>> -               struct page *page, u64 physical, u64 generation)
>>>> +static int scrub_one_super(struct btrfs_device *dev, struct page 
>>>> *page,
>>>> +               u64 physical, u64 generation)
>>>>   {
>>>> -    struct btrfs_fs_info *fs_info = sctx->fs_info;
>>>>       struct bio_vec bvec;
>>>>       struct bio bio;
>>>> +    struct btrfs_fs_info *fs_info = dev->fs_info;
>>>>       struct btrfs_super_block *sb = page_address(page);
>>>>       int ret;
>>>> @@ -4945,15 +4945,14 @@ static int scrub_one_super(struct scrub_ctx 
>>>> *sctx, struct btrfs_device *dev,
>>>>       return ret;
>>>>   }
>>>> -static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
>>>> -                       struct btrfs_device *scrub_dev)
>>>> +static noinline_for_stack int scrub_supers(struct btrfs_device 
>>>> *scrub_dev)
>>>>   {
>>>>       int    i;
>>>>       u64    bytenr;
>>>>       u64    gen;
>>>>       int    ret = 0;
>>>>       struct page *page;
>>>> -    struct btrfs_fs_info *fs_info = sctx->fs_info;
>>>> +    struct btrfs_fs_info *fs_info = scrub_dev->fs_info;
>>>>       if (BTRFS_FS_ERROR(fs_info))
>>>>           return -EROFS;
>>>> @@ -4976,7 +4975,7 @@ static noinline_for_stack int 
>>>> scrub_supers(struct scrub_ctx *sctx,
>>>>           if (!btrfs_check_super_location(scrub_dev, bytenr))
>>>>               continue;
>>>> -        ret = scrub_one_super(sctx, scrub_dev, page, bytenr, gen);
>>>> +        ret = scrub_one_super(scrub_dev, page, bytenr, gen);
>>>>           if (ret)
>>>>               break;
>>>>       }
>>>> @@ -5172,7 +5171,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info 
>>>> *fs_info, u64 devid, u64 start,
>>>>            * kick off writing super in log tree sync.
>>>>            */
>>>>           mutex_lock(&fs_info->fs_devices->device_list_mutex);
>>>> -        ret = scrub_supers(sctx, dev);
>>>> +        ret = scrub_supers(dev);
>>>>           mutex_unlock(&fs_info->fs_devices->device_list_mutex);
>>>>           spin_lock(&sctx->stat_lock);
>>

