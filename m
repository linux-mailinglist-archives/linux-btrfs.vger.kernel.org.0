Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C673C95D5
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 04:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhGOCU7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 22:20:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12590 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231165AbhGOCU6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 22:20:58 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16F2GCsj022372;
        Thu, 15 Jul 2021 02:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nFfH5s0UuazvGX0OiK89rYvXbVTqYGK7JUV0dDrsZRs=;
 b=Jlar/r1y2Wuxbh3rKAigiCH1URrXd9FsMiFutW6wTw4TljUXM+sfY/FIqCZAajG5sTyr
 008Q3mnJ4xtfwbynAmgHGdA2DbllvOnNZxcH6wHmccJUo3DoEd19HQrnHbDNHShjMP56
 U8MaaApoSsTDtmu0yNSPxeGMiYbY+eCquAvYSavF6r6ybB8HBz5n6pPCuEKMb2GBxS16
 dm4SaSXh1f8MsFgB6Uh4cuu6jLMAFIZxbD91Sd625lH36vIjnzOqoTBjKjdk95gJkk/M
 t3XYU+dmHn/E1fvS2Ui+Fy9jw+U03wUPoclhHb43NvQDe+YFCu5Bcu85rRFKx3yiiofN fA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nFfH5s0UuazvGX0OiK89rYvXbVTqYGK7JUV0dDrsZRs=;
 b=HTXwnv8h1IT2ZKE0OPRgVsLbDrTF0DaXN8EWzxmkHw3Hp/tVCO+G42pTKpqrj/yjoW+L
 dMQqa99wymj+SEiRQaI6sEuQ6rQaeI7rk4sx0f+nyidPaCG0Y7RjcfZ+6Vb2up2OcA13
 SCypAPYIMAfCM8tj3+tqMoEPP+Txx6mNl/g/WSlsQjKsuL+MzVOubjDYGivdd3uMfjNS
 PZFjuONd3ryi3kJmaHSXif5CfqTC+yIKuWs5cv3mgKjxIqxhUzLfjupUHZeWvyvlpv2m
 2l4443jvsV3M4ECYDjZyFiUzK7aSl15sRj7IT7WGVgws0GdCv12Rr+DW8KfY0p8bauzY fQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39t2tj0ypq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 02:18:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16F2Em1G032484;
        Thu, 15 Jul 2021 02:18:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3020.oracle.com with ESMTP id 39q3cgh9sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 02:18:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nv3nztlFe3X2v3GS72leMzbZX189A1b3pGW1MqTj6Nm0gnVbbqBtRq2xPUfHjYZmPptD/NcrWvG/fPWyn1Qn2s5SwvyRtDHwxTqlxs5sxlk18YfPppPmZsnpsId2OQIp0x5fWPSKxxvLj4XD2gQAAL+7kd1CxiRGhyxsz0BUKTb8OUxao+4h5lhow48w6Rfpn6jl5cFzAPKIbFUK6gbTAz/5eeIRUEIbmCFlus51Uk7uGDmgoYCV+vC+rYzUESHii52gjfHg5uPsK7DaLWiInplmrq8n3MEAqmKx2lIGMqHgrm5AXdHiByVc0So4jsnaM699lD9eQ7sgDU5UM7yJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFfH5s0UuazvGX0OiK89rYvXbVTqYGK7JUV0dDrsZRs=;
 b=lgo+X3gupr7ieB13Xm5YwTl2k5jCnwu4eb09eEDODWah9vzVXKQcOUwid0RaMqVfUNj92yb/aaTwqYgvFfi/oqMKfbR4TEJuBjl9FWKGRtcNXZ0R/WZYL4bqwxyHJGZBo7WM1xxudbqBg9PeKIjVrNnnIM/GEsxtI6DYjhZy7LNwAXb7nLh1k7V7v03E+aMdnA6inC83GP8TnkEiWwLfYtCN3oit6C+hkqEGI7NreFfqs68p+5CFA8pC0t/qCeS9fwV7JSVuxHCgm3A2O6njuHy6SeW1d6ol1ohhTH6PRku3YNzgGI/j2aL6WY/xUlT/ilvsZRIoO7rhzmvSn3gynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFfH5s0UuazvGX0OiK89rYvXbVTqYGK7JUV0dDrsZRs=;
 b=QYbDfEQZmz8t6gFmZwHWbUikvg9kli/Hnv7u4P6JfSOMapawLvCDtp6srA2QlK1x36CzdwC4egPM/pIG6UOljFhHaySLdfQKVKbG1q3Kmb9RrjjTe16/hqdOS9GXuh71A48CxhRqDKs7ZB5O0Jmf9RoqR8BJd7JhiuO783xvJNE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4286.namprd10.prod.outlook.com (2603:10b6:208:1d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Thu, 15 Jul
 2021 02:17:58 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%3]) with mapi id 15.20.4331.022; Thu, 15 Jul 2021
 02:17:58 +0000
Subject: Re: [PATCH] btrfs: rescue: allow ibadroots to skip bad extent tree
 when reading block group items
To:     Qu Wenruo <wqu@suse.com>
Cc:     Zhenyu Wu <wuzy001@gmail.com>, linux-btrfs@vger.kernel.org
References: <20210715012430.111567-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <5efd4bfe-2d62-aaf3-cd2d-e6d6e13d42b0@oracle.com>
Date:   Thu, 15 Jul 2021 10:17:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210715012430.111567-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0110.apcprd02.prod.outlook.com
 (2603:1096:4:92::26) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR02CA0110.apcprd02.prod.outlook.com (2603:1096:4:92::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 02:17:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59e9a38d-7be6-4abf-e537-08d94736c386
X-MS-TrafficTypeDiagnostic: MN2PR10MB4286:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4286CA2D13A4B60DAB87260DE5129@MN2PR10MB4286.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CkkAfAwN7xlLo4hbnmVdJuBC2S8MaTftccBWQogTLbMaPv3S7qO1B6PJ7xceuki+Hd0shBdW/cuXKcS26xKmuKhQ2XFkl26YAX20b8NB0wTbqQK8H7l5r7kiyx/nEcRnR/zSMwcNRgX6DroFSVOkWyZKo6y9t5q1Rp2yk+3IgdMbTOaAT+DMXI6/LoM2V1KgnWQlRUtvonS6Gies5WQPkaHdDXn6JRasio+FZGXywzFduTAZEgnxZ2ZY5Bf1+2p8yzvzT+oKtKY4DtUGwTjS9fJHW/OWRhWI/76xSvqb7eTuYNk2JkmXsTPUOjZs06sCyUw/dmzqFfxb/kEs6w0Fdj3Eydz5S1+qYI6E8t6Gav5RKVdC9r1h8wukzsikpxemuLVCD4eyJC64tsrKdTM7gN3nCB5L6gAHFcJ20t2HZomAh+YCzfKwprXZ9cwxEMNosFJZktL6KWuT6TzAOV2ivAeQxJkbAp2taL7qTn+dGPBGM0zexZFMsDEYarIayVv0mnnpRe2EgmrgmgOxYJlRinqDvqSBhK6u+cQfCQg9SHDjIKy21NlNt8whhrDIK5UNwXOVCbbNoaxwcd+8LxKy3RKAXz8puORXsvu6h+mes62OMGB2cAtWxw5Z6GnfTbTxJwOToObDubrLCYmc+rY3gHqGjJu1YMmidhwy8fcWWAeeetsy/WexUF02mMHbBTKoyU0QQfISbfsy88ypicgsQWdzWqNRLoKu8Re5ifHJiWNr5R1mcA01tH9QiEQjr+wqJAu4x79wf19xZvHIZji1YVKp23MGX8AiAnEJpa+VzSyNnyggYtllr2fLrznoD3Yw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(366004)(39860400002)(2906002)(8936002)(86362001)(36756003)(16576012)(66556008)(66476007)(6666004)(31696002)(316002)(5660300002)(83380400001)(53546011)(8676002)(478600001)(38100700002)(6916009)(2616005)(966005)(44832011)(26005)(66946007)(31686004)(186003)(956004)(4326008)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTRQbUZ4N0o5VGhMN1hDUFBEY3FIZDRDKzc3ekVEdDhxcENZSThVTDE1YzdY?=
 =?utf-8?B?RUxwMCt4elcreXM4dWxKTlloN1g4alpFMndGM3dzd1N4czRUSWRWYlBOWDkw?=
 =?utf-8?B?MlQvekVCelNJVmZXTGN1VXY0WlNXSmtqbVJjNWtLMWVzam1LazZGRHZudkxp?=
 =?utf-8?B?SGRxMXRrQjVtYXJGeWZORStaaFYrWCtuRTJXb2hmd3ExeEYrMWx6RzdIeTBN?=
 =?utf-8?B?YnFIdHYxV3AwN25KWlkxbCtnQ0xUYUZlL1VPUGgwdGg0NkJHR1FGWHNDRHFC?=
 =?utf-8?B?VUFRblYyS1Q2RHN2YitlTHNaZm1vZ2pIdmpTc29WTzZFcitKRkVIU2x3MGNV?=
 =?utf-8?B?c0F1ZlFTREd3RXZMcHNaYWpibStWNVZ1WEdNOVdQdmNJTHUxZGc0VUVTT2Jj?=
 =?utf-8?B?c3gvMkYwWVZpZTF1VC9hblF4K3dXK0lFQkRzK1JScUlwem4xQ256Y1liMGhx?=
 =?utf-8?B?TVRSanVKZ3BZakR0VHRuSTd4QzdnczJLQXd4dVN5NEhpbDNIR0xzU3M2RWE5?=
 =?utf-8?B?eFBnTmtDTnJpZVcvVUxkOEFGYkJnSFJSbitNTzZmdjJGc3VOYzNiUFdkTlBR?=
 =?utf-8?B?UklZbkd0clI1Z09lU1Q0T3JXbUJ3bEszVUVGcndDSmkvejJsOW9mektEbnFx?=
 =?utf-8?B?UjV4aHFnT3A3ekt4NlIxTmFyTnhvZWliSnBhbFF6bEhHNmdFM1pxVWRaQlFZ?=
 =?utf-8?B?RGFlb0RXc2ZwOUNhN2tsWFhsdWZBWm1MVnNKOTVPTDQvNTk4YnVxY0NYQWpw?=
 =?utf-8?B?WUlIb0pzajVPeFV2R1Rzd1ZpUTU0MEk0L0JuUERXUGpQRVJhdHhVOTBFdU04?=
 =?utf-8?B?bUZzWlQ5bmRrZ3c0M3JsMGw4bnpmTmZmRSsydnFLSUxOWDI3VWlBeFpPYnhr?=
 =?utf-8?B?aU1hdU0xdURja0k1MVppL0Q4TXorczgzbjFwSU5jRHgvZ1hkNnZoeS9XUEtk?=
 =?utf-8?B?MzV5RysxbVdjcXd2NXM3NDJKVE5lUjk4WEZrS3I5V1Z1cUx3RHZjWWdwQzFm?=
 =?utf-8?B?K1A2YTlGMFcwaHRNbEhrazJ3L3NOcGJYUmwwSEliL2FIcitwcGV2bnNOVFFP?=
 =?utf-8?B?V1Z2Uk1NMjU2VUJSUEVwbDZ2RFc0UCtkWE9rWGhpWmJzMkt0M05GVmVKY0dP?=
 =?utf-8?B?eGx4eG9lVmZuSEFrbFBUWlNCbU1zd24vblJ5V2d3K0xGdXBHY2hhY3N6UU5m?=
 =?utf-8?B?VUltK2hxRCtYVUs2TXVidkdvQ2ZoU2JVa290WGNneWJsbXNuOTZtZDBWWXJ6?=
 =?utf-8?B?VWFJcCtSOTRhcVN5a2VKRjgrdGljeVhwYlZRSmlGb0ZON21Pa2FVdFRGNjdN?=
 =?utf-8?B?RVRWSXQ0WXY5QmEyQmtEQkhjd0QyYTFXZVhkU1dBZWpadDdUWmpKaUlxdFVw?=
 =?utf-8?B?VVlRaWNaMTlOV3Yzbk9XcmloZEVGOVpRdnJNRGsxL3cyaWovdlVIK3kvZmM0?=
 =?utf-8?B?dlZBVjg3OWNyWWR4K1NaWXpJcm5PSXgxOUthUVp5UEt5WTFKQ282Tmx6aWJC?=
 =?utf-8?B?WElTanpYdHFtNHF5MnhDQTdGWndLTWxtMmtXMThLVHJhSjZYdm40b2pRalFk?=
 =?utf-8?B?M3ZYMTBjL0V6TFZ1S0l6UXY4OFpjT1RNUzVuTlNveTJBdERNazNwMi9sZEM0?=
 =?utf-8?B?ekU5R1pWVnc2SXBvVmY5SjdSbTlNT0JtaTBPTE05RG9SL3RqNVE1RlFvSUw0?=
 =?utf-8?B?ajc0V3hCLzBUSE1HVVVSS05nQmZDVXd5VlM3S3NmaVRSTENoRnZHL2J3eGVi?=
 =?utf-8?Q?XAq20i2hztwI5AXijwD0/Wb33+b/4OHOpid1QS7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e9a38d-7be6-4abf-e537-08d94736c386
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 02:17:58.5283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3elWEv9L4dcPR1C+CCGaXYW1M1ypkYayjJN5ZVHJPJk4z+0ycPkyqLD3wVMlI8NAHr1eFiB3wvMrhl3JGrYgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4286
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10045 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107150013
X-Proofpoint-GUID: 8oBENCreecq_mrVhM5LTPeiAMZxv_Idd
X-Proofpoint-ORIG-GUID: 8oBENCreecq_mrVhM5LTPeiAMZxv_Idd
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/07/2021 09:24, Qu Wenruo wrote:
> When extent tree gets corrupted, normally it's not extent tree root, but
> one toasted tree leaf/node.
> 
> In that case, rescue=ibadroots mount option won't help as it can only
> handle the extent tree root corruption.
> 
> This patch will enhance the behavior by:
> 
> - Allow fill_dummy_bgs() to ignore -EEXIST error
> 
>    This means we may have some block group items read from disk, but
>    then hit some error halfway.
> 
> - Fallback to fill_dummy_bgs() if any error gets hit in
>    btrfs_read_block_groups()
> 
>    Of course, this still needs rescue=ibadroots mount option.
> 
> With that, rescue=ibadroots can handle extent tree corruption more
> gracefully and allow a better recover chance.
> 
> Reported-by: Zhenyu Wu <wuzy001@gmail.com>
> Link: https://www.spinics.net/lists/linux-btrfs/msg114424.html
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/block-group.c | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 5bd76a45037e..33086b882fe8 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2105,11 +2105,16 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
>   		bg->used = em->len;
>   		bg->flags = map->type;
>   		ret = btrfs_add_block_group_cache(fs_info, bg);
> -		if (ret) {
> +		/*
> +		 * We may have some block groups filled already, thus ignore
> +		 * the -EEXIST error.
> +		 */
> +		if (ret && ret != -EEXIST) {
>   			btrfs_remove_free_space_cache(bg);
>   			btrfs_put_block_group(bg);
>   			break;
>   		}
> +		ret = 0;
>   		btrfs_update_space_info(fs_info, bg->flags, em->len, em->len,
>   					0, 0, &space_info);
>   		bg->space_info = space_info;


> @@ -2139,8 +2144,10 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
>   	key.offset = 0;
>   	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
>   	path = btrfs_alloc_path();
> -	if (!path)
> -		return -ENOMEM;
> +	if (!path) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}

   Return -ENOMEM; is correct as alloc failure is not part of the 
corruption?

Thanks, Anand

>   	cache_gen = btrfs_super_cache_generation(info->super_copy);
>   	if (btrfs_test_opt(info, SPACE_CACHE) &&
> @@ -2212,6 +2219,13 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
>   	ret = check_chunk_block_group_mappings(info);
>   error:
>   	btrfs_free_path(path);
> +	/*
> +	 * Either we have no extent_root (already implies IGNOREBADROOTS), or
> +	 * we hit error and have IGNOREBADROOTS, then we can try to use dummy
> +	 * bgs.
> +	 */
> +	if (!info->extent_root || (ret && btrfs_test_opt(info, IGNOREBADROOTS)))
> +		ret = fill_dummy_bgs(info);
>   	return ret;
>   }
>   
> 

