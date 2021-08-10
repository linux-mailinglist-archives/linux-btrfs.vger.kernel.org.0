Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09FD3E7CEC
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 17:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238762AbhHJP6V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 11:58:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58670 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237009AbhHJP6U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 11:58:20 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17AFulvh011141;
        Tue, 10 Aug 2021 15:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=askaUBA6WZ/FerM3AUyynOITlt+brCLn/Sm/6ToTTvU=;
 b=on80YoMwfecD7G4XLPDoX2CHKPE9Ob+OSED8q+tQ8sr9Daj52AsdqPdpG1aiGgS+mrVp
 99UQX2WYtrlJ2rqu5/ry6Opl8h3eu2AC5FjVZtrPnmZ+0vBX6eDvyHG1j+xEZKQ1ZDFx
 mY+xZMZETXXKgf939Q5ORwbDF7YRoOHVF0YR9c6mn7HAXzU7pqqIOOhDun2XRQRxC9ei
 Yz021WzXTCrapcttBeLWgo6mFrzbeDArmXI3Tsu9LvEM2mgjE6uH5j8FG+JSBFJ1IolD
 PdCWa4OLf5CUdbzggozBeGzZUWlmPWnUsV3CvLQ5AUFnGDsr+iF8mXixQxhuej7Vpapv gg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=askaUBA6WZ/FerM3AUyynOITlt+brCLn/Sm/6ToTTvU=;
 b=PWUf+I1uT4FvMllOJPSAtK0ZqTr+pkhLTLmlArIRdS6h2SDy25giZmJCmoyWbTKRqJRh
 Q319omxTY0KQeAj4r9vaGIGouSDYbFpuX6rweLJJ6TUCuiRWK1mMgvQLhaNT0dbUwoxY
 NRXjBnBdts6wIDbPUoIgWW4ygvZpL+OT0UnH/FlniBimK2v1f36w+cZr1A1AHiNGdls7
 MN6OxMcZAE9Y3o5cFbiP9KJBJjmTdm8R4l7b0eCsp75xU8CQiPZobc9QcmBc0RP0exeg
 VZ275l52i6cxGvBG4ldEdh0uEMJUc2g8gkoaBIUnuKVkApNOvo1bcyHw+A3AXzHDSI6Z /g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ab01rc19k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 15:57:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17AFuMT9166544;
        Tue, 10 Aug 2021 15:57:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by aserp3020.oracle.com with ESMTP id 3a9vv4xmx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 15:57:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlWvxFvWZ91mf6QZV6Ku6fVEAVSDS0myhdcOJiiRQz064/2Sb4189UeBjetYMyMrG318R4R3rE3UvmseoytdkZZTjoU0yipqyO+8TsnQbVAiSkoZkZn6BOLyn8xr32OkSKS6h1H5SptVXjakPtIuuwOYZQ4R1KZItvYQ934V/6iAPBd7cDXVhwznOy8zJFQoHNFJ64O1slTWo0/LIROLWzaR9UpdUHNBkl/7eldxqX0Mivjv5eziGC2zRu/sZ2JF5VOkZgBahoGfOxCIEag4dEjkuYI9FEz5jdiT8/aDlAA/VDovuNqucL2YBFa8Q1Wij0KRQ2FPli5JtGyf/MFMWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=askaUBA6WZ/FerM3AUyynOITlt+brCLn/Sm/6ToTTvU=;
 b=a3vf6agPJlG3e61RDFmZCdLW2FjQWVbA+1MW8tevQG2KeLsL4ydHeT1laN84wk6ns77PlAlP6tm6NutDafI9+57nUciL3Ji+Sna6hqNSL/fe/1pLi7arHiiuDOQfn7KZbM7vp3zBqesTeZYXQT/24S8ilBGyAPv/Vvk397Dlvo9VGkczdPYUuykCECPUKFjHjofpdC5N+uFJaralJWsQDp0RL3oL8AFzkHPZfSOEQRDrmaUZ98bi9wXFtGw585ETWTUhTAaOViXT11idQlZZxDUdh0chkg9xSoNQJJp7+wGJQoUamoPaci4R+63KmYXmoYW7EASizR449vkpOww3Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=askaUBA6WZ/FerM3AUyynOITlt+brCLn/Sm/6ToTTvU=;
 b=sOz81zv6QPG302kjOpHl9bd5gbRN9uBF7RkIVrPMLYNr6ndsDCpFncZ4QANECM4vkn3vTeVh4/fpZ1bZkQl4RXRrGjef43KuMyK8uVOW7HXAJJ/YEMWYhdh5QhZPJ/QmFwr2huOEI5+3avnBDQ79RJ8XpT167DcNzpOEeHBPQXo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5153.namprd10.prod.outlook.com (2603:10b6:208:330::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 10 Aug
 2021 15:57:49 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%4]) with mapi id 15.20.4394.019; Tue, 10 Aug 2021
 15:57:49 +0000
Subject: Re: [PATCH] btrfs: fix NULL pointer dereference when deleting device
 by invalid id
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     butt3rflyh4ck <butterflyhuangxx@gmail.com>
References: <20210806102415.304717-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <11e300f5-b3b9-be51-f3d8-b0d830300bc7@oracle.com>
Date:   Tue, 10 Aug 2021 23:57:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210806102415.304717-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:4:7c::36) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR03CA0108.apcprd03.prod.outlook.com (2603:1096:4:7c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend Transport; Tue, 10 Aug 2021 15:57:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29e3bf43-2d03-44be-f59a-08d95c179a48
X-MS-TrafficTypeDiagnostic: BLAPR10MB5153:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5153CDDF93585297FC61E847E5F79@BLAPR10MB5153.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sv2mTtBoh35a+7vGJk0XtT/XJPYxUb68TpQAc1Fta2nBXi42KFgo55XuN3VhZnbk1PngCn0Wy5+ym60kAheXuh2UbzImx6rU+tM5pkHY/ncqx7YRbNFtYGbmyMJ2Extm+97xeLqEvgFTsJdUsw4s5YDk1I2NP49lT0Bezj5eA9zKF4Eq423M57TXIYB8GpyNP+cG30ZBt36GsSB8b9QRvq/dCntm2xw8/SYHmDYYv5ABv18CMdTDn/0vM/fqCgqe6YuPo+b3cmXj4SaVQV+Uj12pU5PGa/BHVNIJ4nd8GAfBzoQT0rIsUsX/OgEwvlo/mSWsys9xAp/3lqaBRsQ3xD2id5QeoiYLV56Vh97ePeuugexWW3FPLxJndv0KGTE0JKWSxvV0GN5YPzh/2suE0OaAsZwngY5soCAzA0bR6rT+zknqc7SSQO1BW8juC+Gc6rDUIsX0YTU40CCMzVos/6Lrr7mWFiF2rbuialxHxyuOjKuIfKRZ5eZER6qgHKlia9KGnwvdVO7BK+ilNLERRpMGhVDcmI29BOslyehk2zf0pSZqEY5XKLujsa+qW8QnopW/Iy0F3snoySOzF2Wz83M6w29qGvRPaKozzoMxQH0Tpunz0vt58bfpJ4epqGOpLXgmR5W48mCGY7tNoPNjUq7FoqrIjztyXcoLfV2BvZCYUji9bRoiBdnG5cwoIIyH22y2KY56Ga1i9eZsHzaMkhbZXtC5J572u6eAylckncQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(136003)(39860400002)(396003)(86362001)(31696002)(44832011)(6666004)(316002)(2616005)(38100700002)(2906002)(186003)(26005)(8936002)(478600001)(83380400001)(956004)(53546011)(5660300002)(36756003)(6486002)(4326008)(31686004)(8676002)(16576012)(66556008)(66946007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWtGRkRueFBROFNYdmJQY0NneVdPWTdBTG4rNmJ4SEptYWxwcFlMR1pjNWNY?=
 =?utf-8?B?QUpjRVVIRHg3b2hEdWRSRyttUVpQbUFsRjJza0czellGbk83eTlBa1Y2QlVC?=
 =?utf-8?B?NWYzdzBvYWh2Y09XZzhCQWdHdHdqLzFQc3J2Wi93b3NhRmlsZzBnbytkOHEx?=
 =?utf-8?B?emNsb09ta3BOREVCLzVLMndHS3NVRWNTajdxa3Q1ems5TEZCbWJDRUNVS0E5?=
 =?utf-8?B?MFJqaGRMU3hEWFVIWk1FTUxZZGJvdlFudjZLenZFTU1mWUVrZU94UWVhM1E3?=
 =?utf-8?B?MStvS0hmcHhwZXpYbXZOZ2l1ZWxWMDU0T3hpR1BPeFJDNEd0OTJJeTh3aGdH?=
 =?utf-8?B?RmxDSmd1WWxmbFB1ZFNWamtjWmZRQjZHNTRGLzRXcDl6SXhWM1liZ0pOSVZN?=
 =?utf-8?B?MGFmc2JCSzhzSGxJaE1YSUlMSXR2RlFneFM4OEttU21wRGRVMWNQM1l3Ym1E?=
 =?utf-8?B?YjhmWmtJSEsweWJmSkNUVFk1NGt0Mm45MTFsSlQwelovR0dFcjFWdGJsY0or?=
 =?utf-8?B?ZmM1STVzSUMwYWdSSnE2SnhYUTU1VWx4bDk4Q0ovZHIrZ2xPRXlwaWozVm9E?=
 =?utf-8?B?WVpzendJZGk4RVBNZzVPMW9OQkhyV2V0NVFPV2lKay85OWhET0Zsb0Z5eW1I?=
 =?utf-8?B?dkxFNUpPeVZVbk93UW43YVpscjFEeXhyNkJxT25TaTVDTzIya0FjR3dpanVy?=
 =?utf-8?B?MkVLOE1NeHFrcGNBS3JhTktPL3p2aWkvZEJGelVLb1E4UFFScHR1OVZScVpV?=
 =?utf-8?B?TnM5UldQak5zTkZDU1VkODBjYWNIR3dXQXNoc25rb0NSMEx2TlR6c0Y1MVFU?=
 =?utf-8?B?bXdsM2M2NWFMSXNHWnF1TTRXbHMwVzZuUUgyZWlWdGZtWEJjRjNtMWdpbEhT?=
 =?utf-8?B?VmlLK1htazhZYUdYbnk3N0xJTUMrNXJXTnpaOFEvMHlxbFRnaVJrVnJNYXhY?=
 =?utf-8?B?S3liZUxzZXNCOVZzdERVRis1YTFNNEtWZHdxZTJzZzNpM0VEdlNQOVVCekNp?=
 =?utf-8?B?YjRpakVpQ3ZXdW5iTEJuMkQ2a3BtdXFEVTVWQUswblUxUnZBTG9zNWdWUy8y?=
 =?utf-8?B?bEN1MlllckxKT3RvbW1tQ1ZiTk9VbjdKWlB4ZnJvQ3VUNFVOb0lmdjZXaGxX?=
 =?utf-8?B?RHZ4cXJPQzk1REltV0tCQXhITUY3dDNoMGR1VlNkT21MV1lQNFlWZkxHQzRK?=
 =?utf-8?B?cEloclZWUWFKSXNoZmdvK3FIS0NMYThVeXVIaVJhbEpGRFBWMHAvS01rbjkw?=
 =?utf-8?B?dnFIVHB5aXhqb2lvMVRzSGVXalRsUWZtMVE2MWQ4L2xGQWZEMk5icVFvaFQx?=
 =?utf-8?B?Rkl5dHowR2lOcjZIeGtGb0dQMlhOR1FyNjY5VTgvZC9rRkZBSW51cDVyaWNQ?=
 =?utf-8?B?UmJpVHNERFJ5STFPRUZ4dCtTRTJuelhGN1l4V3RDS3VQTzNJS3JEbUh3R2hP?=
 =?utf-8?B?TU9EL3RmdDZIbUxoVnl2djJpVHg1M2t1L0JpejFFdTUzMnBsYU10czZvVW1y?=
 =?utf-8?B?eFJFYVZQYzgwVmNOSkdydW9FZ0haVHdqMlp4ejY5L1RVbXorTGEwUUNiUmJG?=
 =?utf-8?B?U2IvK1c2STR3MklCeE05WUtnN2tyeHRzREsrSG9CSWlnTjJ3NGxOaEZHRmZa?=
 =?utf-8?B?aXpXT0JIWVFBK2xjV1E2aW45K0E3ZkRHNjFBQjRRVXVhWk84SW5yZEVFZjhp?=
 =?utf-8?B?MWVlQ282bitvRVdPTWNYTXBDT0J3VFh3OGR0V3R2cGM5bHJORkZ0czNaN2wx?=
 =?utf-8?Q?Sw0G4pAAsMZV8PREB1Qy5IMqvbH3j2+twPU7hPv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e3bf43-2d03-44be-f59a-08d95c179a48
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 15:57:49.4252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cptGSJtc0Z/8odzBEMdHVFykWTDatqSHJOjNqaS7Q0KLskRi8ih3pmn9eCoDs6Is97fQmsJctnoJimKQgKf2Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5153
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100102
X-Proofpoint-ORIG-GUID: g7LzF_GPOzqoCNdDxJj8Ox8MIqh3cQOd
X-Proofpoint-GUID: g7LzF_GPOzqoCNdDxJj8Ox8MIqh3cQOd
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/08/2021 18:24, Qu Wenruo wrote:
> [BUG]
> It's super easy to trigger NULL pointer dereference, just by removing a
> non-exist device id:
> 
>   # mkfs.btrfs -f -m single -d single /dev/test/scratch1 \
> 				     /dev/test/scratch2
>   # mount /dev/test/scratch1 /mnt/btrfs
>   # btrfs device remove 3 /mnt/btrfs
> 
> Then we have the following kernel NULL pointer dereference:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 9 PID: 649 Comm: btrfs Not tainted 5.14.0-rc3-custom+ #35
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>   RIP: 0010:btrfs_rm_device+0x4de/0x6b0 [btrfs]
>    btrfs_ioctl+0x18bb/0x3190 [btrfs]
>    ? lock_is_held_type+0xa5/0x120
>    ? find_held_lock.constprop.0+0x2b/0x80
>    ? do_user_addr_fault+0x201/0x6a0
>    ? lock_release+0xd2/0x2d0
>    ? __x64_sys_ioctl+0x83/0xb0
>    __x64_sys_ioctl+0x83/0xb0
>    do_syscall_64+0x3b/0x90
>    entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> [CAUSE]
> Commit a27a94c2b0c7 ("btrfs: Make btrfs_find_device_by_devspec return
> btrfs_device directly") moves the "missing" device path check into
> btrfs_rm_device().
> 
> But btrfs_rm_device() itself can have case where it only receives
> @devid, with NULL as @device_path.
> 
> In that case, calling strcmp() on NULL will trigger the NULL pointer
> dereference.
> 
> Before that commit, we handle the "missing" case inside
> btrfs_find_device_by_devspec(), which will not check @device_path at all
> if @devid is provided, thus no way to trigger the bug.
> 
> [FIX]
> Before calling strcmp(), also make sure @device_path is not NULL.
> 
> Fixes: a27a94c2b0c7 ("btrfs: Make btrfs_find_device_by_devspec return btrfs_device directly")
> Reported-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

  Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/volumes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 230192d097c4..5156254a9655 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2079,7 +2079,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info, const char *device_path,
>   
>   	if (IS_ERR(device)) {
>   		if (PTR_ERR(device) == -ENOENT &&
> -		    strcmp(device_path, "missing") == 0)
> +		    device_path && strcmp(device_path, "missing") == 0)
>   			ret = BTRFS_ERROR_DEV_MISSING_NOT_FOUND;
>   		else
>   			ret = PTR_ERR(device);
> 

