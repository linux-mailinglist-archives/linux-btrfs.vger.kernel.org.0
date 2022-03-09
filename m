Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01194D298C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 08:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiCIHiS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 02:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiCIHiQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 02:38:16 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFBE1637EE
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 23:37:17 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22949hwc021319;
        Wed, 9 Mar 2022 07:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=u+iAWQ2UOTguNjhVjjs1Wc+/BceNSti64Ny5Q31o8vE=;
 b=zKlYjlsMs2u7NYPZdvYtcf0YpXZdVfa/Fln0Y9dyoYTVzgCujxBs1tC/Ifqs9VQLqRHL
 seD40sTQ9LZ8pu1bDcLYThlSXtT71VybFIeIlNyxrUuqhpUrsIxoTXgU/FKXQlb292j1
 88NGJtNRGANT2ncyrZowSwWsjKuAsnGuGCAlIKbaw9leYDx8YMFf4PSX9DaJPuVCjxHZ
 8eX3/HOb2TKQWE27ND3A2prvgVCiUqUEDNMpi+5x6Y5ETJriB0lY/qo4RamREAmNDnNb
 cYRywSNIcCXybrRp8hwe5vKOzf2cD27qw66FafQnoGYkx2J/rKhiCVhJDmwE9RH7PECp 4Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyfsh9cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 07:37:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2297bDGp088955;
        Wed, 9 Mar 2022 07:37:13 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by aserp3020.oracle.com with ESMTP id 3ekyp2t0g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 07:37:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+VxnI+fQht/wLFprjPEvPiQ3DyzHl20AwsshuDU97hBF1MaW6WlqLCeA0CrXsf/8Cf4lZIobn4n8OnhbPpGuRfNDaP3RLrprrkuAOdB2nk51aAWJSUNHINn13ea6RPe8BG/w/PkNPDxZPXOczpBJyN8RfE9qToQ0KHDsvoooU0XcFKYbT2O4W3/lZsDpocVuugxIvY8YByeMlRisFfuroEvN/D8QryzxNsPFFh5yczoHAapknfq6pOcMZ4dRiT1QkaQEqKpI6Q+Ao0Pu+oJ1p1GzzP9A/Cf+XFEOB2CDN5zvBU/JjNHlO0h/i06G+PyMXRFqhIaTQkgrCIAqHmjLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+iAWQ2UOTguNjhVjjs1Wc+/BceNSti64Ny5Q31o8vE=;
 b=GhViEwN16vfLjWbBGyc4dDBHjO17GkaoU6gL4WrOWs6nh0jbrvOnFazRh8plQqpmbVIoqIBMdb+ouQgQDuojs3lmed4gzHL1XKiOlT72jTQAqbcWb27q7Xm+Jy+iLHk99/WK6kjizHQGrkyobncRgKSp67qc9zSyj/P+h+TMc0JeStcmj3aVvZouWMJM4vsDfO07pDUyuF7ybMG0+ka+1IKatQBb8EYKPlTjjAoIHEOw1ALVF3ftz0xqD5abDbkuvY4aa7/Sn4o40Cm2LAzqEkSSjJ9WsNUrfAPigMIev78S8muhnkpzo9IEIHbiEZ3BcCBLKoQgdv1zhOX0RpLgRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+iAWQ2UOTguNjhVjjs1Wc+/BceNSti64Ny5Q31o8vE=;
 b=i0is+AGh3dCkZcEdmSMeajBvx/LaISzW8lNUndXAu6WmiAJ5tUUdYTa5bgi6FrX3cUSLsEjkgXfAsZ0rlGpLGGL4VG/L7XaNbAq1E1XuP4EF2H8iYNfkhCYPIeU7sa+o98/H/B+xq3busUczzC1S1ZYSz+nez8iSplgSUAJ/4qk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BYAPR10MB2423.namprd10.prod.outlook.com (2603:10b6:a02:af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Wed, 9 Mar
 2022 07:37:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 07:37:08 +0000
Message-ID: <5990aa9e-9082-613c-4ef1-27568d36329b@oracle.com>
Date:   Wed, 9 Mar 2022 15:37:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
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
X-ClientProxiedBy: SGAP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::21)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcca58a9-4312-4e52-aefc-08da019f9d50
X-MS-TrafficTypeDiagnostic: BYAPR10MB2423:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB2423E8A998DAEEAAD7B37670E50A9@BYAPR10MB2423.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xpsSvrw362rvpnHhwBXzOwh3Bgvei4/Ud/iRg36gw0oyruA1Cw2vlYhZDAfhAzh6YTrZXmIoGqmf6FVlUSMEfSMtEWEb8YeGXbxZG1YUBKkXbg9wNbjjHGCfjEHcNbZvaGurjzz82kKvXOpt5YhTzuZgDSScqZ8YQA1u52CAAD1SkBJUon0O6DibpUptqTyIKE2YgWWiGwOXSDAUd8V2NYkqQcbolNpxBbmYoZ8bUwQWgQpEY6UBo3fA0xZOqQG2sfk++Ad3rujnix/bIIUlZA0S51bTuat5pkTAD1YQ/+nWfUsI0qhrcbpw2tGnkwlTh2Bc3PUwXRDoj/ooyLULgCn/PfQKixicCeqWd9L6Beb3tRaGxOPqeUOCp593VGXLUHUyr/Dr2Fb8rYrTeMrHpGyAg/vdN8MKm9fohKybM6ygXZDlhFMBtCZow2i1Rqyk2k2BAdbWBoeHHspk+p0OKuszyyGpGcsEtD0Mo11u11muH+QghB7gxxm2cANvKIF1HsupeMWRxuEgPK0dLUnHiQxUMqQkfGiErUSiG08W71CJ+Gf1SygvrHwe+W5M6FKz/PNWqZJ0ECZ3an1ZDKT3DR3F9A9uwAx4oE6UII72Cbcq/uWTlpEn1kTci7Xvm4R8zeO2k0jCy2lDiCXVzHewEt56h/xwtMoi6ee6ebmUAagDbPO0/aFavKAAh+VbAEzUKOGByhFDuv4nGtC8zVVQA7NrTwjT7niRv43pzEdxAxA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6506007)(38100700002)(66556008)(5660300002)(31686004)(66946007)(66476007)(110136005)(31696002)(8676002)(316002)(36756003)(4326008)(86362001)(6486002)(508600001)(186003)(2616005)(83380400001)(6666004)(53546011)(44832011)(6512007)(8936002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkFNc2pFUUU1dnczSHhJSnZtYXpSeGFBeXpjWm5LVmZCNUtCSDlJTWljTHIw?=
 =?utf-8?B?VWdaNExzZXAxU3dBNnErYVYxSFBaSzBpYzk2TW9SWnREbzJQOFNsbEtyUFVP?=
 =?utf-8?B?bFlGdVdHa0ZoZWQ1QXorWnRSdmFLZmxvZWVvaVNSL0cxSGxTSmtVMEJVLzg0?=
 =?utf-8?B?Z0c3bnlVZ0tIditUM2tCUUxma2dNbEYyMHRhRzIyeDFReUxOelhwMFVnb0lw?=
 =?utf-8?B?akdDTVV4Y2JqMjUzRSt2NzNJcU84MDBmSkZOT1A5TEptNW5yay9CYmVlZEkv?=
 =?utf-8?B?ZGEydGNFQndkdldvZjdHUUwvL3VkZm1tNkRnZDJnQ3RhakxLOWVFSkFDbm1y?=
 =?utf-8?B?SnA2dFQ2TnovV3AxbDdLMEdtVVBvQjlDMmRtNVBOR3pPUnJ3L2lnZjUrUTR0?=
 =?utf-8?B?TWNqVmxhWjlSV3U1a2ZjejZQMjBiTVJiOENaOFdTK0hwbUVLZEwxcmJTYmxI?=
 =?utf-8?B?cXhydzY0c1pvUTlGYTF2Q01aNG45WUxCSk1PbFdjZ2ZSRU5mOCt6aXdXVit4?=
 =?utf-8?B?VnBGQ3FUSkZOWU9FamVMR3VFbCtSRmZZMCszVWt1Sy9IZ0VvaGV1NWUyeUlE?=
 =?utf-8?B?a3B2bEg1V1F0OVRuZGxuM3d2aHI3WS9iU1lOUW9HaGtmSk1rWjcwSmZWRmE0?=
 =?utf-8?B?bWRTQU1wdUVsZVFxZGtRN2JQdDVxQVNnVVBKRnAxckg0WHdUQktDUXYwM282?=
 =?utf-8?B?dkRlSnRhSkhCUEUyNmUreHBiYXU5SENuczQwWFVNMUZ6RjRnRXVVd2VZQ05J?=
 =?utf-8?B?NHJRUGhpR1dwclk0S3VBOTZ4RnlUc3FqNmZmdmZVY01IMnZiMmhRSlN5QVF4?=
 =?utf-8?B?QnF4RDZFVGtzTnNXWU1vakl4YlM2cCtrd0NBSXBqeXptbDVnMEFkeUR1bEJ6?=
 =?utf-8?B?QXhVUC9Jczl0bTZ0cEhFT3lRMlB5YUJPUmFhMXV0TVB4V0hROGpCNUxKb2pI?=
 =?utf-8?B?UTZCemNickhINGJiZmpvSUkyd3REU0pxd2piSnhyM0p5c0Z3Nkh4WmZzTFFJ?=
 =?utf-8?B?TkU0ekViQ25WSHQ0OUgrU1FCTklNQnFUblR3a3BCZFUwZWMzcUhNQlFMQ2J1?=
 =?utf-8?B?VUQzUm1tbWtkVEZLek16QmFqZ0pRU2xMZUFRQnRaQy8xZS9yWG50SHYxTmlh?=
 =?utf-8?B?MTNhaUxVVUU0a1B3K1NSbXF4Z0ZGTHV3TzdERUxWdVRmN3BFUnNhcVhnUTBT?=
 =?utf-8?B?ZlNQdHNWc0ZGSDZOODJrVFlyNFBudHBLMUZWTXQ4VUJuMWROclNVUll3Y0cy?=
 =?utf-8?B?alczOVZUSVJYTkZkQnpNT053RUlveDR2bUVib0pRWEY4eDljU1hHWmY0eG1W?=
 =?utf-8?B?UVI0ZXQ3YWNybVFVa3c1T1hMVGVVSVJiWHBmUm5vWUVTYlphQUErTlE0N3ZJ?=
 =?utf-8?B?QzlZbDJSSmViS3hYTFlzMGRTazRvV2F0dWsyMDVPRmFsamZRbmtJRjV2NWli?=
 =?utf-8?B?dzFsVGZTTGxiRVJDdWpWVitoK0RFd3VKajVMcGQySkZaWDJWRTRPcUNDSnBI?=
 =?utf-8?B?ZmdIQmdJSlNNWFg2NXR0bGZBUFRFY0tVNEZYVG5lL2g0UHhTeVhYU2lxQ0JP?=
 =?utf-8?B?NlZVMy9DUCtGcFl6L3dVMjI2b3RjT1lhTGlTMWZRaW91eThYQWtZUmdLRGg2?=
 =?utf-8?B?LzdoZWQ0YVJUOXNMZytRSkp1Y1ZZelR3TlNTNEVTQlllVEErK2s1L2Q4Q2Fz?=
 =?utf-8?B?UEJ4SWYyYXR4SUtJSEtVT0pnSzNaemdqTEJhR0pJR3dUK3BSaTJEdndPSklX?=
 =?utf-8?B?YUNNMlMxbDFmdTBYOVBleHF5TE1mUzhCMTFDZUorRHZQRlk2UmJ1OXBXRmsv?=
 =?utf-8?B?bjE5Kzd5dzNJVVBvd2IxVHhlbEs3bTRNZGdvNnBGS0J4TGpIRnRPOENxV0VP?=
 =?utf-8?B?S2J5RFZFVHI1N2FWTFVXS0NjbUR4bUNwL3JVaENDTnlKQmdTMnRSM0pYTHhC?=
 =?utf-8?B?OXVodzV5TGJLR0tlc0kxbkNYbUMyR0wzTnNHd0s0OTQxTDhjQk52TGNnNVM2?=
 =?utf-8?B?VDB3WEl6UnNhekwvU1hyMUVYRGxBRk51cG5rQ0Y1ZHpNWlNCbEFzVlFMenZY?=
 =?utf-8?B?aE5YZDdZL3dhbGFCTzhYNFhNbUVNUmE2S3k0LzVwdlphZmJyMER2aEFyNkhm?=
 =?utf-8?B?WU1aOUlCS3ZiSlZKaSt4bXp3T0FVSlplZ1c0TGEvWFIxM3dQUEh0TnFtY1pK?=
 =?utf-8?Q?t82LdTX55+SqpNN2agEpV2s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcca58a9-4312-4e52-aefc-08da019f9d50
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 07:37:08.1615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qRn25XzEL+YkM58WgCBfVHPjLB/IxZVgmB17YnLGGP3NgxEOQMWIHdFRvCQovoV+O1AH3kL6Asj89Wo0DFQrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2423
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203090039
X-Proofpoint-GUID: eER40p4NHX7A1-ffPF3juQk_-6VQiqm-
X-Proofpoint-ORIG-GUID: eER40p4NHX7A1-ffPF3juQk_-6VQiqm-
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
> 
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


  Sorry for the late comment.
  Why not use dev_alloc_list and, chunk_mutex here?

Thanks, Anand

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

