Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083F859F734
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 12:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbiHXKOI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Aug 2022 06:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiHXKOH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Aug 2022 06:14:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E915351A3B
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 03:14:05 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27O7fq8W017945;
        Wed, 24 Aug 2022 10:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hKtjTIEL8VUC39wZ3YTVJVRSBgAe03rzSGU00SIOeko=;
 b=MYo2RLh1L5osYAhbOWbp/2qMmBuR/zS9IEUYHxJAmoChUrKkGocEoQuNCEM8cZUzQMHg
 zWhfY/RTkvcgXQbFhbpunjCSsKGTQlVni7MJntZiNFXajv5zoswcS8AuAkCdG1tM4VQ7
 vBbFHY6EUz/fcVlfKdUucJVc7fx3r4bGBoUkY0URXSPgOPoorhO6hKn1tyNdXGtiQacx
 LOkOoE4v0ytDc9jJFZSPpC/2JbS+3IYhhSKv/1+5SppUS3VZFjhH3AaeAX9enQev12Xd
 yahXBYZ2fVei3OvidR222dxiafbf+ppSxuUejvfsYBSu7fss9Lz75Jj8gLRrbxzOUrga eQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55ny9dmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 10:13:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27O8OLR5037133;
        Wed, 24 Aug 2022 10:13:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mkjhf7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 10:13:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAP68+CBAHYpWDUBf0815IjY2gGEkTBntooqR5LoVLF8iobsh5D/h0rxq+GTfRLhKt/PUQt+Fe/7xMjkmzY0tHMCEsblPxkNX0r6ry9IZPXu8J6nYwYp17pbG/f9AD2w2xBgE7rRiQzarnZxMjWDLVjSl3RiO6maGKGRBA9kaGp0AZHFtP/bZHoNuTAqF8c0E/la+a4ZRwTCjtruOA968sVmQ+rixOnWCAiFE2hF5OpsAxkPo87n5RPYfojKBkWBAnTUbMiEHmnAh0eR4BVFyFMLJslj3rTbdNgMcIlGg/ee6lLHrOaabZo6A/G6Ei1CPKtA0mpNSxsUeonFN1fOIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKtjTIEL8VUC39wZ3YTVJVRSBgAe03rzSGU00SIOeko=;
 b=Pydrbk29q1yPjlZ3ngIE9QFq985Xx9ub0eZMPmscyVI+96JVqhdAY2tqOLZfWNr5ddsakvRsNK7V/sXC+97/J92M1ldLBPlnZWxHrkPYjU7WuyE73yAK6ttG4/OwmlG++/wlfF3t7ZEC1DtEhdnTEQj4aHf0dDaIN48eHIJXmAZ6Sb23kYrdiZlaaOVYXoaFjFcJIFDbt8xCyVzC0GjhJpHYETQiWpnaDFbNnKXQ1dXeRz7Sn6Okrn7gyGV47ARnxaok2D+pnfh1/zEvpZ40B22v4qs+lWIJcvGh5LgkctlT8JL9M6yookv/nm1ZnaxUxBjVsx4fbEnkjRBubi2O/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKtjTIEL8VUC39wZ3YTVJVRSBgAe03rzSGU00SIOeko=;
 b=qJxlbyhOlbztb5tRvvMkCPUZQWkooAEapbR1yHlzdyY2/frgdLQ8JSx6TekbW6OPgwCxoOyeCUkJW2SwwMf5Vj780rpb1m5C80b/BWzh8QuhT3+9HSnswufpvGP3Q4Z3Wxz1r4Fjb5y0bmoYE4I9D0/QVRtJQIuIRp6rxxszwws=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN6PR10MB1619.namprd10.prod.outlook.com (2603:10b6:405:5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 10:13:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::f164:f811:6e47:b7cd]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::f164:f811:6e47:b7cd%2]) with mapi id 15.20.5566.014; Wed, 24 Aug 2022
 10:13:55 +0000
Message-ID: <b90a8c51-8ae2-5b65-7514-3c17ef34fc4b@oracle.com>
Date:   Wed, 24 Aug 2022 18:13:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] btrfs: check the superblock to ensure the fs is not
 modified at thaw time
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@libero.it>
References: <8032f0bba42927fb4d87909060e03a647bb60c32.1660200417.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <8032f0bba42927fb4d87909060e03a647bb60c32.1660200417.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbc1a1a9-271a-4325-678c-08da85b959e0
X-MS-TrafficTypeDiagnostic: BN6PR10MB1619:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KPDrtGr5q/HrpoGh3kQWxnglyshpoVvVYuXj39Z1UH0w1BsGMxFsLZmdITPEGrMjd6AR4AeVwzg0V7B2y0u7DzTCpW5wi42o/Alh3IzpNIbNczH/qjLXd9HXaQ5B2TAlfhkGndFw03AGyovEvaQyHhUtU9JpV6VBgPbqVLu3U21z7ucCe3pW8L4a1UZ5d635oyMHbTRSFTn9oOftnKdTuH+eZiut8kptpYPm2CmHQjeG1HUpVG+U43h5RY85uUkW/sMVlnP5eCHzaK+rrZ7THp67TCpF51bWqikBqxfvVcR9qFICj433qM5mh99EMfpQ1OqG9qBYACf9xnbF8q/Kf/G4x91sdzMdG4M8B6PxNJ7cNGyJuj/pL+V2Us+DSo2K8bcG/oGo2pGa+mz1m9Cd1MVfyl25aP5Zo1LkFZdIT46ayDZMi7oOSkzbsWA+6zklWIWtuSyMO19gSdCnrXeMXBSB6KDVTZonZeUdQOzzok+yi2wni3nWJXk9uL2BnwGvZWiQnWXUwnOzlQwvcY15n6LyXscQFuhsMfVCdG6sFqRdnswykjV8FjTcIxjGOHpYlrn2ApdelOoth0M4bUo95UQ9ZPV0tRlY/FLzvmfa7zCucFC0O6YWEXsxeJMqImVpMgIlR4THDbvkqYtqtNzxqWqgVF01j9RB5J5hHJeOXyidPUZAXndBLwOUrIvID0wLuLBAY2YpPfIPViUbXiaa8VnVZcbZE9lpLdOrzTmAeEBOidlpbH0WgJxvHqccLkgoVcSDbIWyv627WHX8iKSiD2VjDh127jbaIJxmov5n19+gHcK+WPpIs85jRPqGqcHWki+/2kaoR/q8MfOgj3ChZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(366004)(39860400002)(136003)(376002)(41300700001)(6512007)(6506007)(6666004)(26005)(53546011)(86362001)(36756003)(83380400001)(31686004)(2616005)(31696002)(186003)(6486002)(966005)(478600001)(66946007)(66556008)(316002)(4326008)(8676002)(66476007)(38100700002)(5660300002)(8936002)(44832011)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmpuajYzYVdlK01hb0Vyemc0TzZoS3UvSWNHU3pZU052T2ZHUmRpZ3FFekto?=
 =?utf-8?B?c1FlRXFtb21aemFjamlXM0ZzRHFoSjBETEJ3cDhrRzZyZjVJVnRxV2dPc0V2?=
 =?utf-8?B?VlFBVzUvaVVpK0VxcVdST1JsUWl2MnpjanZmcnk0SXhOY003TFdKRW8xMUpG?=
 =?utf-8?B?YzdnYUlEZGdUWjUwZDMyajQrOEI5OENaVmlYRkQyTXBCNmk4elMzTk00ZHFQ?=
 =?utf-8?B?NjdwTXkvbzMwYjF3WTFoTjFPN0g3WDRtQUtZdGVvQzdnTDlQWFNMNTI3OEhF?=
 =?utf-8?B?TVhHNmIyZVZtd25GWVM4dkFXeTRRSXM2TEVLVlltL2xDNVNlNDNDTTA1SzdR?=
 =?utf-8?B?UTJXZGRMYmREZkJoVWxOQ2NJd3cxQm5sRHZiVUZYRnBOTW1CLzJYWnBDNHIr?=
 =?utf-8?B?aTYwN2MwbGVhUjdjak9qVU1YTFRyaFNVRHZ2WTdKVVEwWDdFNHppL1hPeUF6?=
 =?utf-8?B?M1Fha01WcUFDRG5nNExmemU5UEhUdjJqMGkxMEZRYktyUzd5b0pJZUU3SFp2?=
 =?utf-8?B?dmtZZkg4WnhiTXpRZUJsbDZIQjV0MkJYWFFkQ09xang0VlNSY2V5akFLRHpw?=
 =?utf-8?B?Q1RtV1FiRC9HWkhwakJtSFhIUlg5Y25jRHhGaHAyKzJ5aDZnSE9MRm5pMUhi?=
 =?utf-8?B?eEcxZkFiY29kWEcyYVNFb0FYVFJtZTNNSU5BN2NsQnI2Z3BJQ2YydWxXV0xt?=
 =?utf-8?B?K1FWU3ZDTERCalljZGVzTGRIT2NvVVRIVkpWUGNVVkl4dXZvNmc2c1RqQXhE?=
 =?utf-8?B?OC9xWkRLY3FnbVBSUU8zcjRtWDVjN1NHMEpvK2dkS25RTlMwL01QSUhyRjUy?=
 =?utf-8?B?cDJFVXVOUGwrUnNMYmNPeWdKVUxya0UzKys5alI3bHlGQUtUZXV1bCtPdUlN?=
 =?utf-8?B?NHNJUkc5MVZGSFQ4dXZvTUdxbmhOaURKZ25OSzdVNUpvWDFORE5nY0ZMdTM2?=
 =?utf-8?B?TkdZOFlHYS9hK2p5bjcwZTAydUZpMHM2YlU4a0NJTmd5MUxZencxWVlYWUxi?=
 =?utf-8?B?UzlicEhPcTdpOUxEMy9zSmk5bVV6YWlXMEgyQUJaZmxrSHlEa0FBY3hIWkxM?=
 =?utf-8?B?SWljQ1prSzU0RjJ1c1V5RXdpeXg4ZFp2T09hdG16OWZGTE94RG1sWFFyRHdG?=
 =?utf-8?B?R1dlRFlzUDNtWkJLcFVLaC9PM1FwK29XZFVaQlhDYk9YcVJCREVvNWtWaW5P?=
 =?utf-8?B?dmI0cGlpanY5MER3YUpXRWtTSGh2K1JnakViMGhWN0k1ZnhnSUx2YWx6TkQy?=
 =?utf-8?B?RmtQQWJuVjRwSlNMaHN6bUM3cTc5WVdtT1RhWkdLWnlLZmMzZ0JSVUZRM2gw?=
 =?utf-8?B?SzlqMThTSGJjK1ZpeDdDTFhPb3ErejZpKzQwR0x6clhYdXZ2U2ZabnVoZGc0?=
 =?utf-8?B?RXdEdEpLVHk4RGRmNDVkSi85YWthRTZSdElpOW9VUjJEd0plc1FxQWhJbU5w?=
 =?utf-8?B?NVNXenJrSmFXcElJMFc0a0FNRW9GeGNvcGFRMmdqUVNqZnBTMlMrUWpwd2kr?=
 =?utf-8?B?ZFBWMmlkRnJ6Yko4MjQyaEZQdFEwZFJWby9JTU9sdGlidjFDSTN3MWVEcWpy?=
 =?utf-8?B?ZTAreExBOGkyMmhXN1ZuSzVxeGJ3YS9wNkd3T0NtcHZvRCtKejRVakxWaExx?=
 =?utf-8?B?YUU0bkF1L1hNUFd2ZDFWcVhMVjY3a0MzajE0T3RpczRlMkhuVGRLKzZSMi9j?=
 =?utf-8?B?TXdWcVU5TlRHeVN4MmJUT3g2UWJLZUdiYVNtYzdYQWRCTmF5OXlEcVlEN1JW?=
 =?utf-8?B?Ujh1RVk2NU1qclJucS9xa2VaSnNpK3laY3ZQZXRvRk5xbkRlODdnY2lEa243?=
 =?utf-8?B?a3lNajNUcEFyZDJQY0U5MHF4K0F5UnBGUHA3b0NjSjJzSG53a1JNelo1WGhh?=
 =?utf-8?B?eHdzdFpHQ1hrcURIaEtpQm1xYVl2N2JxVWhUbDVDZXpleSt6aCtkOUI3N29q?=
 =?utf-8?B?UnZ6UmpsVDk1VnZ5dkN0Z2xWR3kwM2EvMUt1b0VFbTFTdithaDJiOUJXT1dk?=
 =?utf-8?B?QUpkV29wMlpuY0cvQ3h3N0pTNEw4WWh4U1M3Y21GNEpFRnZoZ0N2WFBCRWlJ?=
 =?utf-8?B?SHBNdklXZmFUbEFFNUhsSkhRWmRnTGExSjFESDFUOGFXblhjR25yMWJFSGZo?=
 =?utf-8?Q?4MPRfpO6Co4w0YkkNLELQgH//?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc1a1a9-271a-4325-678c-08da85b959e0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 10:13:55.2325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9MujHnk+y0xTrq31vWaH2zBfpIXBUK2lB0g3xqQPceCpF0gvXgGFX71xOoEev7HO1oaztb1jjGil2E94/rcPKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_05,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240039
X-Proofpoint-ORIG-GUID: Fp-xsVQeThDHgubBHsUMVDO5gcDqX9d0
X-Proofpoint-GUID: Fp-xsVQeThDHgubBHsUMVDO5gcDqX9d0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/08/2022 14:47, Qu Wenruo wrote:
> [BACKGROUND]
> There is an incident report that, one user hibernated the system, with
> one btrfs on removable device still mounted.
> 
> Then by some incident, the btrfs got mounted and modified by another
> system/OS, then back to the hibernated system.
> 
> After resuming from the hibernation, new write happened into the victim btrfs.
> 
> Now the fs is completely broken, since the underlying btrfs is no longer
> the same one before the hibernation, and the user lost their data due to
> various transid mismatch.
> 
> [REPRODUCER]
> We can emulate the situation using the following small script:
> 
>   truncate -s 1G $dev
>   mkfs.btrfs -f $dev
>   mount $dev $mnt
>   fsstress -w -d $mnt -n 500
>   sync
>   xfs_freeze -f $mnt
>   cp $dev $dev.backup
> 
>   # There is no way to mount the same cloned fs on the same system,
>   # as the conflicting fsid will be rejected by btrfs.
>   # Thus here we have to wipe the fs using a different btrfs.
>   mkfs.btrfs -f $dev.backup
> 
>   dd if=$dev.backup of=$dev bs=1M
>   xfs_freeze -u $mnt
>   fsstress -w -d $mnt -n 20
>   umount $mnt
>   btrfs check $dev
> 
> The final fsck will fail due to some tree blocks has incorrect fsid.
> 
> This is enough to emulate the problem hit by the unfortunate user.
> 
> [ENHANCEMENT]
> Although such case should not be that common, it can still happen from
> time to time.
> 
>  From the view of btrfs, we can detect any unexpected super block change,
> and if there is any unexpected change, we just mark the fs RO, and thaw
> the fs.
> 
> By this we can limit the damage to minimal, and I hope no one would lose
> their data by this anymore.
> 
> Suggested-by: Goffredo Baroncelli <kreijack@libero.it>
> Link: https://lore.kernel.org/linux-btrfs/83bf3b4b-7f4c-387a-b286-9251e3991e34@bluemole.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Remove one unrelated debug pr_info()
> - Slightly re-word some comments
> - Add suggested-by tag
> ---
>   fs/btrfs/disk-io.c |  9 +++++--
>   fs/btrfs/disk-io.h |  2 +-
>   fs/btrfs/super.c   | 58 ++++++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/volumes.c |  2 +-
>   4 files changed, 67 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 6268dafeeb2d..7d99c42bdc51 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3849,7 +3849,7 @@ static void btrfs_end_super_write(struct bio *bio)
>   }
>   
>   struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
> -						   int copy_num)
> +						   int copy_num, bool drop_cache)
>   {
>   	struct btrfs_super_block *super;
>   	struct page *page;
> @@ -3867,6 +3867,11 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
>   	if (bytenr + BTRFS_SUPER_INFO_SIZE >= bdev_nr_bytes(bdev))
>   		return ERR_PTR(-EINVAL);
>   
> +	if (drop_cache)


> +		truncate_inode_pages_range(bdev->bd_inode->i_mapping,
> +				round_down(bytenr, PAGE_SIZE),
> +				round_up(bytenr + BTRFS_SUPER_INFO_SIZE,
> +					 PAGE_SIZE) - 1);

The 3rd argument is the offset to which to truncate (inclusive), and it
looks correct.


>   	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
>   	if (IS_ERR(page))
>   		return ERR_CAST(page);
> @@ -3898,7 +3903,7 @@ struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev)
>   	 * later supers, using BTRFS_SUPER_MIRROR_MAX instead
>   	 */
>   	for (i = 0; i < 1; i++) {
> -		super = btrfs_read_dev_one_super(bdev, i);
> +		super = btrfs_read_dev_one_super(bdev, i, false);
>   		if (IS_ERR(super))
>   			continue;
>   
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 47ad8e0a2d33..d0946f502f62 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -49,7 +49,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info);
>   int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
>   struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev);
>   struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
> -						   int copy_num);
> +						   int copy_num, bool drop_cache);
>   int btrfs_commit_super(struct btrfs_fs_info *fs_info);
>   struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
>   					struct btrfs_key *key);
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 4c7089b1681b..913b951981a9 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2548,11 +2548,69 @@ static int btrfs_freeze(struct super_block *sb)
>   	return btrfs_commit_transaction(trans);
>   }
>   
> +static int check_dev_super(struct btrfs_device *dev)
> +{
> +	struct btrfs_fs_info *fs_info = dev->fs_info;
> +	struct btrfs_super_block *sb;
> +	int ret = 0;
> +
> +	/* This should be called with fs still frozen. */
> +	ASSERT(test_bit(BTRFS_FS_FROZEN, &fs_info->flags));
> +
> +	/* Missing dev,  no need to check. */
> +	if (!dev->bdev)
> +		return 0;
> +
> +	/* Only need to check the primary super block. */
> +	sb = btrfs_read_dev_one_super(dev->bdev, 0, true);
> +	if (IS_ERR(sb))
> +		return PTR_ERR(sb);
> +

> +	if (memcmp(sb->fsid, dev->fs_devices->fsid, BTRFS_FSID_SIZE)) {
> +		btrfs_err(fs_info, "fsid doesn't match, has %pU expect %pU",
> +			  sb->fsid, dev->fs_devices->fsid);
> +		ret = -EUCLEAN;
> +		goto out;
> +	}

  Just a fallthrough is fine.

> +	if (btrfs_super_generation(sb) != fs_info->last_trans_committed) {
> +		btrfs_err(fs_info, "transid mismatch, has %llu expect %llu",
> +			btrfs_super_generation(sb),
> +			fs_info->last_trans_committed);
> +		ret = -EUCLEAN;
> +		goto out;
> +	}

  Here also.

> +out:

  And the out label can be removed.

> +	btrfs_release_disk_super(sb);
> +	return ret;
> +}
> +
>   static int btrfs_unfreeze(struct super_block *sb)
>   {
>   	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
> +	struct btrfs_device *device;
> +	int ret = 0;
>   


> +	/*
> +	 * Make sure the fs is not changed by accident (like hibernation then
> +	 * modified by other OS).
> +	 * If we found anything wrong, we mark the fs error immediately.
> +	 */
> +	list_for_each_entry(device, &fs_info->fs_devices->devices, dev_list) {
> +		ret = check_dev_super(device);
> +		if (ret < 0) {
> +			btrfs_handle_fs_error(fs_info, ret,
> +				"filesystem got modified unexpectedly");


  btrfs_read_dev_one_super() may return -EINVAL and the error log will
  miss lead.

> +			break;
> +		}
> +	}

  I checked if device_list_mutex is required, but as we are in a frozen
  state, you are correct no device_list_mutex is required here.


Thanks, Anand

>   	clear_bit(BTRFS_FS_FROZEN, &fs_info->flags);
> +
> +	/*
> +	 * We still return 0, to allow VFS layer to unfreeze the fs even above
> +	 * checks failed. Since the fs is either fine or RO, we're safe to
> +	 * continue, without causing further damage.
> +	 */
>   	return 0;
>   }
>   
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 8c64dda69404..a02066ae5812 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2017,7 +2017,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
>   		struct page *page;
>   		int ret;
>   
> -		disk_super = btrfs_read_dev_one_super(bdev, copy_num);
> +		disk_super = btrfs_read_dev_one_super(bdev, copy_num, false);
>   		if (IS_ERR(disk_super))
>   			continue;
>   

