Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B2E4CFEE7
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 13:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbiCGMhC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 07:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbiCGMgu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 07:36:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ABB46662
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 04:34:21 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 227Bsdim006681;
        Mon, 7 Mar 2022 12:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=U00L3G3AsR6Vm8jVHvy4ojDPM8+0B57trfkGUr3ZCMM=;
 b=P2yLmI4PHXWKO+N3IafUhyXostol2Z3Rdhh3Jhr5cHN+FVkzR2G5QO3SCX5l0xXfIaAx
 r3sSNyil2q9PmM05jRX8FfpekUMOU+QWVYw0WGEt/eeoKlS7cAN+lAF22SOC+sTeD6YL
 xuvDp4ffpC/BjK0afbKGIJsI+D9fL6K1DtLLb+L0/fPvZGufh34xoCwbgg+KCdyi5WGx
 eDCrY2r9OidWiGY8P0446b16e+Q6fDbeDFQ2y+XnEGnaKuBcRY5qy3wtlMOqDV6vzhOi
 oghEXdjNpvU/tsugQNaxdmRVA+OKg7Jtt0eYjy+O8fivxzsqcFtjl8KnhlOKv6hj52/A YQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2bnng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 12:34:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 227CWIWE071132;
        Mon, 7 Mar 2022 12:34:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by userp3030.oracle.com with ESMTP id 3ekvytfa41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 12:34:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJBACcZAXH9pVExDBXrkbui53eAktBgpxitoODxK7kQb6fSquE+9bBcmlxTEl4sC4NvdJap/8AEdoeRhn2XnUc5tPZO6QcSOPlZyzRCaoYdZm97z6L4NfSYQSbkWMr72VOUV2+MH4hEblLZqXGs2YPQaZmctalFPOn1eeeNz8pyQOP6MGQzlUC+Hw7BCwB+JksS1LlGW1SRktd/XwqC5Rgs/ERfig0vFbonx7fyuMRTld4w6lTFLFoxVmgRI/4Pz+x4a+Bz4RTsfHWSdmlFutNUs+u+9wUInQIwLlUYUPJqXshmNmlh/0Wg8FsWMiCeNwceI3EeT6vpWifwycP7xmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U00L3G3AsR6Vm8jVHvy4ojDPM8+0B57trfkGUr3ZCMM=;
 b=aM2s9vgCzfCFMbIopg8FdXljGClQB1n+eIgXExBjLqKk09ORBNNwlNPeH89GgV8MoUB2/CkwFsazy6y4lLVGyJK9Ut3Zv+ETK2sSQANStV5Qfu6PV1RNytB9lO2Q+aiIOPvdDT3S6Y+QLBC0Rs2qeZhkNO8Zrow/Ni7E4gsnCM3f2FjUFqqCzUm7JWV24SzNayn+463eUcdcXPMwqSsdkN64P7aw6eYQNCRGOuOQz7PvDRY2dJkC5zf32nBM2KhUkWww42GQ8D1bSgCg9iw3I0LShr+bGArjvR95dMQ/49VkJFadq6TyjD2u885mregDz7gHw+VsTUbPbP0O7yMCDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U00L3G3AsR6Vm8jVHvy4ojDPM8+0B57trfkGUr3ZCMM=;
 b=FSL0xj+NRg/WHkq5m/hfU+L0h4WiQAuas/7BL98Ce4cfdIPqAyzv6C14T+Yu2CyrN7dVwibu60i0KeRKQZQfLl6bPwKyLsc64Ilzbcrmx2DkFkRQ4KDlE8gtaXrSyzLkOdGSLzi4eOKXB86gnsGGOmLwov1NExO733FQnHqCP9c=
Received: from MW4PR10MB5702.namprd10.prod.outlook.com (2603:10b6:303:18c::22)
 by DM5PR1001MB2170.namprd10.prod.outlook.com (2603:10b6:4:2e::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 12:34:14 +0000
Received: from MW4PR10MB5702.namprd10.prod.outlook.com
 ([fe80::7543:2a:a4b9:e209]) by MW4PR10MB5702.namprd10.prod.outlook.com
 ([fe80::7543:2a:a4b9:e209%3]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 12:34:13 +0000
Message-ID: <57d23926-12d7-b8b8-ca76-15dd12f802a7@oracle.com>
Date:   Mon, 7 Mar 2022 20:34:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 1/2] btrfs: zoned: use rcu list in
 btrfs_can_activate_zone
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wwdc.com>
References: <cover.1646649873.git.johannes.thumshirn@wdc.com>
 <b1495af336d60ff11a0fac6c27f15533e9b82b31.1646649873.git.johannes.thumshirn@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <b1495af336d60ff11a0fac6c27f15533e9b82b31.1646649873.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To MW4PR10MB5702.namprd10.prod.outlook.com
 (2603:10b6:303:18c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7627d28-a384-4fe8-d6c6-08da0036c935
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2170:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2170CAAB1AA20AC5AAEB490DE5089@DM5PR1001MB2170.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z3G69OoMTQCdiGSyyglwyMwfmLCMNy7nJijAhg0RQMtIwNfKMR0IEcNimhGtDbrKN8+i3TQhX2M3WVtUPpPYR4KKFQ+k/RrgF3TqXnPZDaNNmQBwdq5K5knjLjRKC9ftfRriH4zJ/tnJCcUOAXSYv8TjSn/XdRVdYrSLmgEi8CGzlKIz5iXZs05k5P2fVPFhTr2K40cd9axJobapZ7wn+E6DXxKRfy9Dl7cksRx3mQL5Oii4wQFIbQzHoAk97MkGzbJ4eqKIVSRkqCfo29esmx30oC+UXNdBQCvcANoGQ0xajKb2/rJaNOCkWw1PfxvmU9kYjGsQqs9alT9v75zG9AZKtvrScBN3X4kDqdik/6Xex6mkjgSxEmIv0EphyZQMhB/lV/5lhoB54T7hKvTfbQXED5BMWNkA/pF/xddeHT4Vs1FzbNH3/2X6+dmAU3Y6CKyl+tlKhMl5exh8awBev2upGwIAgQK8KDDxNy0iPsCWYOEAU0nD8imXAQUwufYnBd7MT4L05dcxN0Ampaykz3zllitZt2QGxWC4TT5s4nntqEV7YntKZndO11nfT62iDcOMnhhiRkI2wxjnzojv0J82YW3bzDjGulHwp0mHkQ3RtOPJKrYgcnuDM2JbZwuwpjiRzq7pA5gsKU14ym9ubM2S65kspoyPjTgIkOJ1bcNgB8musykYpK8z3/H9hhCVolJPZFIhIYW1nEnWE2x+3IAPWBkkLgJ7cUwRd92dnLI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB5702.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(186003)(508600001)(31696002)(31686004)(38100700002)(44832011)(6666004)(6512007)(6506007)(110136005)(86362001)(5660300002)(316002)(36756003)(83380400001)(53546011)(4326008)(8676002)(2906002)(8936002)(66946007)(66476007)(66556008)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVhpSXpiUXVZNEEwNUVVSDJsRTNESTJYaEdDMkMxaTJ2ZVFvOVpqSTNoNzQ3?=
 =?utf-8?B?eERaYzN4STd6VVNZTVJNUHF6UVFzOHFTSjlYVWNjT1VOZ0dPU3RFTkZqTndl?=
 =?utf-8?B?ZG1Fb29kU0ZmR0d0M3pQRG9tdXRzaEJ5ZkpkUythY1JUNXFpY1R6bHZaNlVY?=
 =?utf-8?B?ZkJTNlhZaDJnZ212amgrWWRwNlBRWGRQTFJxd3IwMXJNYkVlL3FhZUpoUE94?=
 =?utf-8?B?VGUzQlQ2ZTc2U0w2dGEyeXRRU0g4d0dHK3htSzRiYjNJb1I0aTBDT3poZlQv?=
 =?utf-8?B?U21lU1dpUTVnZk0zOThuaFdtRDNGSGRzRUd4Snk1R0xoUlJFdHViV1RjOTND?=
 =?utf-8?B?b1prRlc1VUhyL3dxYlA3RnM5eUFrUUlCRk55N2Q4ZUlycGF6dGNsUWJteXll?=
 =?utf-8?B?RVBLRVZTMVNmdm5TNzUyNmJyMkswNkV2eG94TlhRL1lCdjlxVE01WXBqMEtP?=
 =?utf-8?B?cmF4REx2b09kVTZFVVJ6ck5NRWd6NFFHU3lSOFIwM3J4ekpSU3NzeGlnUTY1?=
 =?utf-8?B?ZklRRC9XMFIySHhYeTJIblFmQWtCY0dVZjBSbHMvelYxbTF1ZmFEK0FQbWtL?=
 =?utf-8?B?eE5iS3lteWN5TFRLOXBpRlF4UzFUVEtEMTBoOWpBc0ZSYUpaTWxwQ3FGZlFD?=
 =?utf-8?B?aC9zYkJTbSt0ZjRyYXZ5Yi9ER3NiM1doNzJlN0gwbllhdWRaVmpBMzg5cXl5?=
 =?utf-8?B?YjFIVVBoY3I2aXE4dDQxbUg2dS9IRmM3Z2ovVXVTOTl2SUQxb0t1cU9mSmVj?=
 =?utf-8?B?RjlORFJqU2tqTUcyamVsbzQybGJOb3I4K3FBWlVyc0hyYUFGVVJIYVZSSmlH?=
 =?utf-8?B?NVdKNGxBSjZxbnBwdGVSc0oyamFua0lEL3RaYUIySTJjNzRGNTJPaVgxYldo?=
 =?utf-8?B?WU9tRHRxZGVvOEwrMVkxcVlzNi9rZ3B5R3ZtK3FodWdJK3RPd1dPTm5yL1A3?=
 =?utf-8?B?TVJkaUFNWVVtcjJia25WUE5QaktQaHM1ZXBOQTZObDdsRUtJbkF2TmF1RFMr?=
 =?utf-8?B?ZGU0ZnlaaVNyTVBFUzRudWE0RjhyTGl6UzdZY2d3RTJWa0xEMlc5SnNHMjNI?=
 =?utf-8?B?RUtTcm1Td0RVMG14djI1QTZVYnJ1eElzS2orWTFRbEJJM1FrNG1sY0RmMFgz?=
 =?utf-8?B?ZG4vTWRmNUVXY2hsdmZ1YVhDRWI0T0d0QkpHNkJwNFBvV1NlSW1jRXgrRWds?=
 =?utf-8?B?RnExZzlSeWs3MzBwZkNXNlA0NVlzRUp5RzhUZFpVdXdhWnZYL004dmxUSTlh?=
 =?utf-8?B?WkJJQkFPOFJzZFR6cndTalVBZG1xVm0vbXRLcldHNnN3RkZadGlPeVB3cTdI?=
 =?utf-8?B?K3JMbkhBMHRhM3YrcTU0YVFoYndZdFdRTjNZb0cwT2lBUi8rSVprdmZnWlVp?=
 =?utf-8?B?bzN5eVVranFUOEF0aW1HT1dHNDNSTGJ1S0hBSWxDQXVkME5tUjN4REoxZzl6?=
 =?utf-8?B?ZkNiaVpESXlDa1RCalpvcWxmVkVJNHNrS1V1dy9pYVhhY2V1akIyaVdKc1BZ?=
 =?utf-8?B?b3duTmN4dnpBSzVGTFBMb3o2WTl6YnVqWTZEc01JSkdpRkpGZGhzU0dkeDlG?=
 =?utf-8?B?YTJkekx0THo5blc3bEFzY0lEYjd0RUVoMjJseVFlOFlucW9ya0JOSEhFckRq?=
 =?utf-8?B?RmJDOUxlOEU1SnpBb3B5bFpEdFdFVEtyeGVQUnROTHl3RFV5a0tpRlRKTXZx?=
 =?utf-8?B?d0tKeXZId0pTQTNuWTk3c0VobGpWT2hxaVlWTUF0bmdxa096WnUxd3NLeDlV?=
 =?utf-8?B?YUlkc3FGNUNYSE9kSTROUzY4bGJNMEhOMVViNWwxSy9qbDF2RS9IdWlURHRD?=
 =?utf-8?B?YjFmK1htcWxoMnZpYzdsOEh1UkVXWXEybDN6VzhSNGNNZXZwTWF1YnBHMlNw?=
 =?utf-8?B?SkQ4a3JLYmZWcWlIWW1mOWlJcW9kRjAxK1ZhbE5TZHp0emc2cHY3b3FCUUhl?=
 =?utf-8?B?azRwWFdTMTRZcys0RkxsR3hCMnMybjhyK1RsK0RobjZGcUE3Wnh3VWJtUE1X?=
 =?utf-8?B?V01TTTJ4MzJNYzlRNmZZRm9NM3BZblp4RmJzUmJFSGJ0UnpEVWJVbklrOHJa?=
 =?utf-8?B?ZGJRSXQvZUsxdTdLbUVZS2JneHlyZzdtUEluQ0ZWbWhEaWUyeW95OWhCc04w?=
 =?utf-8?B?c1JHRFRiZ0lGUStwZlRHSzlFSUdvbnhUSDJERE1pM2pLZWxxUVpLU1JFWDJB?=
 =?utf-8?Q?dNNkVj/dl//I3RghurIwIhI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7627d28-a384-4fe8-d6c6-08da0036c935
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB5702.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 12:34:13.4848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmfUUq3PHPMDevGbid43Fw+S6HGORSZ9ZBY8WBrfMgVHUe7ruwbk/oZREw5hJpBIZ8b6whVAE5il1zyKsvdcCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2170
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10278 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203070072
X-Proofpoint-ORIG-GUID: 6yWKSsi1K9rKefgkXua7a20evOvmBVpO
X-Proofpoint-GUID: 6yWKSsi1K9rKefgkXua7a20evOvmBVpO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/03/2022 18:47, Johannes Thumshirn wrote:
> btrfs_can_activate_zone() can be called with the device_list_mutex already
> held, which will lead to a deadlock.

Could you please state that thread? I tried to trace it back and lost it.

Thanks, Anand

> As we're only traversing the list for reads we can switch from the
> device_list_mutex to an rcu traversal of the list.
> 
> Fixes: a85f05e59bc1 ("btrfs: zoned: avoid chunk allocation if active block group has enough space")
> Cc: Naohiro Aota <naohiro.aota@wwdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/zoned.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index b7b5fac1c779..cf6341d45689 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1986,8 +1986,8 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
>   	ASSERT((flags & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0);
>   
>   	/* Check if there is a device with active zones left */
> -	mutex_lock(&fs_devices->device_list_mutex);
> -	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {
>   		struct btrfs_zoned_device_info *zinfo = device->zone_info;
>   
>   		if (!device->bdev)
> @@ -1999,7 +1999,7 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
>   			break;
>   		}
>   	}
> -	mutex_unlock(&fs_devices->device_list_mutex);
> +	rcu_read_unlock();
>   
>   	return ret;
>   }

