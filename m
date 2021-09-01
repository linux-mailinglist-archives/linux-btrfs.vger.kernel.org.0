Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F253A3FD503
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Sep 2021 10:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242875AbhIAIOf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Sep 2021 04:14:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30598 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242766AbhIAIOe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Sep 2021 04:14:34 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1816CYJX018949;
        Wed, 1 Sep 2021 08:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ndfsczrw8tH7r3f3mK1qIIUchyirOU5czbHMyIXu8Wg=;
 b=TYB8i7c8Ucv7dnLbn4WTEiXksw/+dbXOKLgBR1m25kNCl8/DPdWTosuAxMVTS8xyE7zA
 R6fruzgtyQWJaoWd8i5c0KoIsviXC09VWQr4iqVg5zljdhbzf4st2Yo1kq9Ee+UFlNFr
 KF9qOzZ2A+TMb7iER5Ki87uuC3YVC5PbfKd8NG7PjsZBCBSAa+qcCV/oyozQYDLhicwi
 s/bFnI8BEelP889Hr5xWDC3eEKgiCIDTXvyPwZvUWXDZwJ0clHZ4z6uD1ZQyyCx28EQI
 V7wa30IgAjULE3fLvqWXf8g+Kw9Ftw5DHkxr45FF9lcj8Lq6LMfU/ALv5ULErG0NLa41 TA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ndfsczrw8tH7r3f3mK1qIIUchyirOU5czbHMyIXu8Wg=;
 b=bXOcC1epF1JHtmH+z/6izyDsXNyTe8y2M/a8wbvqxIaR6n/+SFONa8W2vqXXT0Q4RdkM
 cfWZ+ILvaMe3imCfnWXc0S+bsi/yrId5Kl0tAxI7g+BGS+60HITllDlXAhXmzitx9cwR
 ll6K+CknpKjIQlUN7YoTOWfWP/RPG6AEXS1De3iGpk5kAPtmR8nQvTBCMQJwLHnYBQW7
 JGbBiYNLfzbus/fzF0pYcpNno8060KgSUFdLsy+C3iLjMSgok2U9Rfa0Azpkw4n8nQl/
 Te4SP+KRYSbdcYUJ6Mj7gSGXxp5cYtK97qwPxgTLiGwCRXgnqRg1EZCG3Db1Kn+SZDhc 6w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ase02bu3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 08:13:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18189mWX120076;
        Wed, 1 Sep 2021 08:13:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3030.oracle.com with ESMTP id 3aqb6fd43y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 08:13:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgKZCb847qvCsKpvsRyoyvX6q/XrA4A3HPhnOtZXqNpZuNgEHWyDSIV+QiihIghbanwg6/DvfoZ13zAv6Li+W0GwsurqOfWbjOz0CsyqDH7wd290837JRsahhRNPg3zK0YPHWN4UF25nH1O/2iLTj32DXBAFrxV+8WRmjaPVug+lMDyws4iQrY/0t9RPG2vrETJ7MD65++M6ZohUZro8EEjG8PGsWH7BU1LDm09ACo6FponL3Ms2VVs+JiedilIWk7iRr7HmwtCrAJADRVmB7j/grA3VwSYQcCST8iZBW0S8oLBFQNV1HokAPHvNYvHDiRfRpf2DHbq/35GVip20VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndfsczrw8tH7r3f3mK1qIIUchyirOU5czbHMyIXu8Wg=;
 b=K4NEhcTOuhgCT+ihww7Spb34vBGxQ8aT1Fz7Yv5ib05F8NQnvicDrgiiXyQJeJQyZbTCIzU/GM93l7lvHPXUs/cUHdSYYuQdkSs+0agFTJjsaDiqQgDHcw0rLsddFGADt1AkU3sESfSHgNAn/hPrpx6N6dYV+QGmMfzi9b0IrkTwYGXKLD3hHL+q3uzgMHhFjViL0BdBQ22ug2YInrhNYwDerENAm/j6mmhrm/3JCnTtojZPvxSOiRpNljCHvixEe5tixE3h+/fUmoATJiAqCZ2GoYMAHlM9my6xeMhKX5kNuP2xw/1W77IQs/slvQPEH3OVqFvB9XDClyIOW+fWrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndfsczrw8tH7r3f3mK1qIIUchyirOU5czbHMyIXu8Wg=;
 b=vxg8boDpkLeJgI3gmt3oRRJlqf86aT3FPe5YAOeTuNfkKqh+A9hVDnu3oENRLnNML2YupJpo2ed5dkxpxs4ipu5LU2ag0rVg0ij3R2DlNa57ue5OtzJ4cp35QoKIe0Qh/dmp3jsBddoVxALQJivyqFAr4h+pSWSrDv//WmNuVrA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB4123.namprd10.prod.outlook.com (2603:10b6:5:210::10)
 by DM6PR10MB2490.namprd10.prod.outlook.com (2603:10b6:5:ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 08:13:30 +0000
Received: from DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::99af:5f7e:6cb7:922]) by DM6PR10MB4123.namprd10.prod.outlook.com
 ([fe80::99af:5f7e:6cb7:922%8]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 08:13:30 +0000
Subject: Re: [PATCH v2 1/7] btrfs: do not call close_fs_devices in
 btrfs_rm_device
To:     Josef Bacik <josef@toxicpanda.com>
References: <cover.1627419595.git.josef@toxicpanda.com>
 <27fa361288b46bcc0f4b1225f7c76c96ce6dbe5f.1627419595.git.josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <649d8f42-49db-69b4-45df-d0d502d7db7a@oracle.com>
Date:   Wed, 1 Sep 2021 16:13:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <27fa361288b46bcc0f4b1225f7c76c96ce6dbe5f.1627419595.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0204.apcprd06.prod.outlook.com (2603:1096:4:1::36)
 To DM6PR10MB4123.namprd10.prod.outlook.com (2603:10b6:5:210::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0204.apcprd06.prod.outlook.com (2603:1096:4:1::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 08:13:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7afcf4b3-4ca1-4e8e-9713-08d96d20621f
X-MS-TrafficTypeDiagnostic: DM6PR10MB2490:
X-Microsoft-Antispam-PRVS: <DM6PR10MB24900E7D83BB6AC0FA4FC036E5CD9@DM6PR10MB2490.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jKxcg1iLGvGZOspxbY9g17un38y7umBGEuBeQSIJL1hmsNtZCfrwfFN5ymAdFyKmiS2UjdjpbLU4lNqPPk21nNUAx6CPh49QIazRt1o9DBIQ+3BfRQ6TNlCOXy0PKXobPaHccvVIstb7CNtgjoO6rfihVz++TeJSc2bWYd9ftXn0Rc+jO76eFrejVe4lOFrJJR9PYrgw0b+j67XG3BDnrtAy/XsCLlhFr4lWtMK0gzon77CyoSqdqOsUmm4eaikYK7xw24qq3d+3ITOHpoE5fMo0RKQ9zxQVyElMVmgL0ZUEY3BkEQkQXAKuIc8qsph1P7zfHIEwk/dvNvTfYAyJn01IVBTwkQ9xRoCo4SMB2T90CsavCAo6PQrbLLuaz69wQ7DOIWLiVaKrUQ+GyGonka/HH5ZEOjWRIkG/bgfKFzSiADaPQZv+OWJifIop3259YishFdB/76KIFyU/7lNel5OfJcYuXHmrklbKC+AoUb3+ZtFI8vhQ/PI/FTMulr+viq0yhgemSFzAXYVbg3mN50DUWc+RiMfXgsGS720P/HYMXz8cSNK8SytHDX9mVJ0gWbZlQqIw9r4JheD/bnEEFOLFBdSOMUq0q2n2m7Rt9h1HLdOqWCwvWJi30lXU1Gl/z6aSGo961qNx2+nWqjSFlnvL45K8fce/M9foLeO7U6iGkW9h5NQOCuNCS08LwbAgz0EiBRNjYuh1/r8DIJkQYj3Lv/TqIfOUUiZTR15ctmDuA/cSEjy5gytTMxww2EFpk1uzF+EsTGDS/n2usEbklOJKdL/Vk5wgTzuScOM6QlqelUbbpBiza49ob8PmJdZZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4123.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(4326008)(16576012)(5660300002)(38100700002)(6916009)(36756003)(86362001)(66946007)(316002)(2906002)(66556008)(966005)(6486002)(31686004)(956004)(83380400001)(2616005)(26005)(31696002)(8676002)(6666004)(186003)(66476007)(508600001)(44832011)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3hlYkw1UnI5aDJ0dFJJUnp1cmxVZlFLb3JNenc3MGhpSGNLTGRqNVV1a2Q1?=
 =?utf-8?B?emJiWHQ0RlVtU1E4V2lHVFBvNC96UjJpUGxTSlhGS2FPVG5aVytLWTlJR1FP?=
 =?utf-8?B?UWZKbFI2THpGNUdIVEZUQlZrMnZQLzlJaGxMci9GcmQrbytISlRIMSs3eXl6?=
 =?utf-8?B?SExGa0RGaFFjeGVLaVZCeDZxM2Zvd2xwd0ZZRlJhVXBveGNtYTBSYVZOQ0gw?=
 =?utf-8?B?d2tuS2hZRWxSaEx0ZUJ3dG9peTNBUmtIcHpBU3BDTDVlSzE3SDEzY3cvQVV0?=
 =?utf-8?B?RU55eXpVWVI1TWFSTjBKdzJQTUpDeWdYRmFmZURJcmJ1N3RzZC81SWRHcDVS?=
 =?utf-8?B?VDBlUUFjUEZ3K25KMFF3dC9vTEl4a2o0d1JCMklHN3FwOHNxajlkeWkvVkxw?=
 =?utf-8?B?dCthUFJ6bjJlamFBbU9FMDU5UWJrbHloZmV3V3VwVDJUMlRibVJDTmtRYWVp?=
 =?utf-8?B?aDd4VEZ2a2RLeEQ0SWJoQWw0aDF0YytSNDQ3RFpvTHBrdHR2S3FXc1FTSkZo?=
 =?utf-8?B?YTBEUEpjYk5uaHZWZjAvVFJmWFRoYUFmd3I3Rk8wYzl5V0JYTnkzN0RuL1d6?=
 =?utf-8?B?VnQrUzc5dUlpOVQ4Q2I1a29HSjJselZRdGVFZEdpanVIaHpmMlVkQ3pQV0dT?=
 =?utf-8?B?MFI2c3pBbzNueG55QTNEc0pQU2dSb3B2RWxvQmUyMmVRUFNxYmNGb0xSRDNk?=
 =?utf-8?B?SGtFdVYyd3JXSGVoWWNpYTZxemtMQm9KQ3ExZENZNWhnbEIwbHpuZ3crbWdQ?=
 =?utf-8?B?WU9KRmZ6VlJ5Qythc1FNSjF2NjROL29RbWJsbXZwM0RTemxFWXcvenVtdnl2?=
 =?utf-8?B?T0hiQ29GdW5jaHQrUW9vaHBOODRsZ2FzdERWTkdNaFcxMTdncFBmV2Y5U0cr?=
 =?utf-8?B?bWc0R0lvSk1say94N0krV3p4NDhPMTI1cWpjOTgrbXNnMFRteDhJb3o1bER4?=
 =?utf-8?B?bWgwNi9mKzB6UlVyRE1yV2ExQ1BGWnI2RGlWTUpub2xlYXYzVCtWNE5PRVhm?=
 =?utf-8?B?MDBoMStrT3VvZDJOcVpPbUJWTFpaODJOSnE1UzYwQkhhSHpiaENNMGU2ZjJQ?=
 =?utf-8?B?VHRTTWx0MEtFcFNITUtUWGdndkxodDhQS0diK1pTdUkyVXp3czhXdHM3TkFx?=
 =?utf-8?B?bENUZUJxaDBNUmFvSXRQTXJjdHhPc0JON0JhRnZNZENiR3dyNFpBclZJNzdh?=
 =?utf-8?B?WHhWN3RLUVBCMXo0VXNGcXNPOVV6T0FTQm1oMWkzVlhWSXp4dkdZT3pUeE1X?=
 =?utf-8?B?WU1xQ01nanhkeTB2RG5xSVdlNlNDVnJFU3NmQVVuUFc4ZGx0S3ozRkRpQ2FY?=
 =?utf-8?B?SDF5dERpZXN1SjJuajZ3UUNYdUVVSDlLZ1hmeUdiS0pMSWZHVnN3OHc4WGh2?=
 =?utf-8?B?NGtvUGZWQXhhdkw5YUJYb2dXRW1VMEIyTW8yTEpUSUxNb3AvRW9Tc2tsSWdD?=
 =?utf-8?B?ei9vNWZWaTVtSnFaL0FYREVTTmhjUTBGQXh1QVMvQjBiOWl2c1hERUlhaTNH?=
 =?utf-8?B?T2RwYnkzV01Hb0pXam5oeDZaYUJIM0FMVGozNVpxZ1pHa1l1RW9Vb1lSL0Vl?=
 =?utf-8?B?T3gybjBkNFVPV0JFbmFyd3JhczJVTTNDUVFXVTk1UWlKWjB0N1RpYkw4OXNV?=
 =?utf-8?B?VlZxQ1FqR1VicEpJa3N6MWxwRGszcjdUdU9nYnhxUFBuZ1RzMG1ocjEyNFpF?=
 =?utf-8?B?UzFhV05IcFc2ZkRRbm9NUm9scXlVeGZGeVJZYU5rY2k2RTFQbzZjL0FRVjVa?=
 =?utf-8?Q?CZUiEEXdnEJNJn8QRvaI7DbibvMISDDpqxnDpMA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afcf4b3-4ca1-4e8e-9713-08d96d20621f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4123.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 08:13:30.3747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmkp7AcdirjyqKgWYsCtuVIVkd/iEVMgxZ8jybfDMEKrAOa3naHHMBpRxABM8cGg4BTGRFGp7dyKL4ajNh09hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2490
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2109010046
X-Proofpoint-GUID: 2NqK6Z4HBbbGBhSmrqCiMgp1pe6ePOmX
X-Proofpoint-ORIG-GUID: 2NqK6Z4HBbbGBhSmrqCiMgp1pe6ePOmX
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/07/2021 05:01, Josef Bacik wrote:
> There's a subtle case where if we're removing the seed device from a
> file system we need to free its private copy of the fs_devices.  However
> we do not need to call close_fs_devices(), because at this point there
> are no devices left to close as we've closed the last one.  The only
> thing that close_fs_devices() does is decrement ->opened, which should
> be 1.  We want to avoid calling close_fs_devices() here because it has a
> lockdep_assert_held(&uuid_mutex), and we are going to stop holding the
> uuid_mutex in this path.
> 
> So add an assert for the ->opened counter and simply decrement it like
> we should, and then clean up like normal.  Also add a comment explaining
> what we're doing here as I initially removed this code erroneously.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/volumes.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 86846d6e58d0..5217b93172b4 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2200,9 +2200,17 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
>   	synchronize_rcu();
>   	btrfs_free_device(device);
>   
> +	/*
> +	 * This can happen if cur_devices is the private seed devices list.  We
> +	 * cannot call close_fs_devices() here because it expects the uuid_mutex
> +	 * to be held, but in fact we don't need that for the private
> +	 * seed_devices, we can simply decrement cur_devices->opened and then
> +	 * remove it from our list and free the fs_devices.
> +	 */

>   	if (cur_devices->open_devices == 0) {

  We should in fact use cur_devices->num_devices == 0 here.
  Sent a patch [1] to fix it.

[1]
https://patchwork.kernel.org/project/linux-btrfs/patch/d9c89b1740a876b3851fcf358f22809aa7f1ad2a.1630478246.git.anand.jain@oracle.com/


> +		ASSERT(cur_devices->opened == 1);

We don't need to assert(). free_fs_devices() has a warning for it.

         WARN_ON(fs_devices->opened);

>   		list_del_init(&cur_devices->seed_list);
> -		close_fs_devices(cur_devices);
> +		cur_devices->opened--;
>   		free_fs_devices(cur_devices);
>   	}


With the above two fixed.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand


