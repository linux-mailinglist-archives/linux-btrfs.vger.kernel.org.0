Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3817A3F45F3
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 09:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbhHWHqF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 03:46:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:29056 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235243AbhHWHqE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 03:46:04 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17N6EJhC029940;
        Mon, 23 Aug 2021 07:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WRWMl8Olk6T+n1AWgnUcDis8+xc555zmEYSMIixFLEo=;
 b=tTKdUOjNU225JkTWU6doCp+Scxw4IJkWPBCa5HDNeeWUarg48fuVUHkGc0QjKks9Gq/A
 ILqVVUeWmrenda73kdrRlI7afiDNhnaS5vgBZzzbx/eEWyJIIwcMmYk774VJFOwpw9sT
 F4b19KCbQEAUltohv51BvRzDs+ZpErom+f/CntfMWOKxF2meRKEPmYsfR2vhJKPYgsi4
 V8QnKDOO3wFXi1os55w8Ne4hHkAfLKokScpQeR7wZx+poF6k292uHLn0IBKHosg1+P5M
 OqZGoP1yXv+O5lCTf7nU0hPus+zdb5nEMxM6dSKBDK7Avh9Tk05aPvRQl+pjKT7w5VKx xg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=WRWMl8Olk6T+n1AWgnUcDis8+xc555zmEYSMIixFLEo=;
 b=wugypzKI1TiG/S7UdHt60vUycIJxYAQype4E8Xdu+qEZ6x/yd22C2v0XpoLJPR1ajJc9
 o2lcgHkTI2KWCn/zOTXBBQyesMm+cyHJcYsLI+ecBGnP3QuMZd9QS96EYaH0YrFhJ4pq
 V0sBC6E5BKbTez8loQgiJG71js+QzMXte3+CGGBzkK+UF5SusrMwXudyI6VgJw42zEno
 w7topqh2oK3Yk7NUk+YeHbqCuWqIDds1oea3PH2yPue90JZ30wEvv5MY4yfqNybn21Z7
 0ReTEKcJ5lfnhRZKyIZasdDwBpneE5Wo/8ujVCdG2rRhp19SPQFaQ2EGw9OHUk+XvCuj zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akwfm0qf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 07:45:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17N7j8dm071348;
        Mon, 23 Aug 2021 07:45:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by aserp3020.oracle.com with ESMTP id 3ajsa2w3b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 07:45:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgvtrHrS/ZC7zSVPLh1dEzrtoq+bSx+b++IqoweoYgt+m3uTPSoP4vkMLjE6bJMhQ6injiKekWQrmPssNbAcHXTeDbttDXHrXf158GXC9/W4s/NtYvGL33PXGwxm+DMMvQVgUEbxacmJzO+DXaPc+5mgSEed3Od9WArgiWA5RJnG9QXJ9FzNAL3BwkIwrbTBY8J70FcnS4D5o/U1CGrpFqXXx5tCeYM3USvypYZRyr3OZL59uNJc3g41sPyBQOGbODAjLygFIwBaQdja38vrD2e/CYEFbna/FixxnV57iIi1UFrW04UA5EShG+0QJVPI1df4iASvh80fH/joVAksPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRWMl8Olk6T+n1AWgnUcDis8+xc555zmEYSMIixFLEo=;
 b=BIY5i8gVZ2w0YTvBEo01+V2/NLOWtPWEfTECJI/73DEaPj4vn+qIzIebTl5bHnxtXNykrQP4aRMMF2XEPL0utU87cvYyUxu9b22zO1AKRxqU1g7QoKGnzz/f4JzelZ7+ZzQHpv06qSO/8G8WTlUWn8O0hviRClnElAiMb5XR9GthVWwawrgPvPyagCc0crCulXsuMKjpDy01eQIhKb8dCZfaEhWQryfxh2DFwjvFHnkYqLP8wnotROTzvvrsk9QgY581lA5dXwEsIAnObQ5xqNYLEnAUDZBsSNA6G0eVTesees/nT9V5k1tYQ7GrNDSzgNxcv+LB+0xYd8h/kj9OYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRWMl8Olk6T+n1AWgnUcDis8+xc555zmEYSMIixFLEo=;
 b=V4EaaRL4rnEjvFYbqJE7nkn6EXhBfsKumy+f+ejeR6J/T7suAgp6A9JgU7Dc9NylLGSQmfCIs0wKZrM7FRCApXjVulmcoPHxZGIDqoHl3wJ0Z3G8IJGPZ2FU6IeA0Q6k4pq6epGWV8+a7KOjJXINVjd/ZEp62vNsnuSPeVG7/cs=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5315.namprd10.prod.outlook.com (2603:10b6:208:324::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 23 Aug
 2021 07:44:57 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 07:44:57 +0000
Subject: Re: [PATCH] btrfs: reset replace target device to allocation state on
 close
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-btrfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, clm@fb.com,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        josef@toxicpanda.com, dsterba@suse.com
References: <20210820175040.586806-1-desmondcheongzx@gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <77b734dd-d940-236c-4cef-2f3a10a735ab@oracle.com>
Date:   Mon, 23 Aug 2021 15:44:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210820175040.586806-1-desmondcheongzx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0191.apcprd04.prod.outlook.com
 (2603:1096:4:14::29) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR04CA0191.apcprd04.prod.outlook.com (2603:1096:4:14::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 07:44:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6827d814-07a2-404f-79fe-08d96609e76d
X-MS-TrafficTypeDiagnostic: BLAPR10MB5315:
X-Microsoft-Antispam-PRVS: <BLAPR10MB531568361EB0D1ECF516D692E5C49@BLAPR10MB5315.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MUFZNwX/meKHD4CWMxnEd7SD65gUmu1fqpxIY+Q3HIgzyJzy1T9XBcK8E8lRnrXQdFg/fxpWus7Z0FyvFMdvtgqDyBW8sKtP/LYsUFM1lgXDS9/tThktG2X2Ywbp1UDoMC02jW4wyNSZBU67SFagJjwgaiHZYhg8q4aEVheYP4u2GEiCIwLDW8bcMrpDCYNW9fJpL8CrDhmO9iaEaA5CAsvOg9O3pt3jYgMpVeAaY1t1B3G8lobi4tRVBWcFhj1Krny979HTlxdwtVfFih0EB0drUSIYq55x1vzpxd4Y6RqtXtZBwQQejXS777Dl2A3BM3wPHXdJTSPOhMuUD6lSzIIIXVCUHbB/HDaCWOMqGinSh1Xjnb0Taq5irOArjNSDWJUIOHA2h/SbO9DsUftsBrMeGXvAK1hjyh6R30mH0/BOR68Nh9bJp5+0ySRrGRzO2YBcnOLO958xVNwcK+yI2kR19MBW4+ZCyqqrS0jOXTXJ4nDnWPgmYxOSVgWfg2cUtQneFE8bicZAZF9q911Q+nxWEa86H6tvkkFHn0sJfky9S2Gz1t16i5iOKfgzEZoGD+jqpyAu79osK89dDLi4yG+vsqIdHWOZpRWenNmQsrGgC5bRd7yDk6cAq/kwznzv7Nc6uE//pq3mihEfC2PLuq/qcrX80fKkeT6fJ9MOtJffkhNFyUoVkk7D/BQhswMmXiRJvQtMNNcVIHH8tND3wP1Klg/tTyXrkF2mlUgzDsw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(366004)(346002)(376002)(66476007)(66556008)(66946007)(186003)(4326008)(316002)(956004)(8676002)(16576012)(2616005)(6666004)(5660300002)(45080400002)(26005)(6486002)(31696002)(36756003)(53546011)(31686004)(86362001)(38100700002)(8936002)(44832011)(478600001)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE5nQlVja0FlcHN6cHFRRUhYUkhBY3I0WlZSbWE0dDh5eEVaSXU1TE0xelEx?=
 =?utf-8?B?cXBRcGUwSXhjY29yYjI1ZXh6Qm5Jbmx5Mzk4dmJiZGVCTGNYZ09PODh6Wm8x?=
 =?utf-8?B?OXIzT2g1QU0vY3JaT3JuSmF1TlNVUkptbDlEK0dmbExXaUQ5UERqc1h5MHpj?=
 =?utf-8?B?MjVzUzVSUHFQT3FEWW0vL3Flbk9kTHhtVkRQTVBEQkhsc01LMkZTM2hsMnRp?=
 =?utf-8?B?NDlyYzg2TTJVMldKKzM0QVl2eC8wbEptMW1sQnlBT1BQSkdtZ3YwVlNEcXBG?=
 =?utf-8?B?MDZMVkovY0hib2YrSGRpK2Jod3h3S09EL1ozVXRua3ZhdlBKRXByL2F0Q3lN?=
 =?utf-8?B?a2htMi9ZaGViMUJsV0dnSjNyRGlFMDBuZ0lwTUUvMTFocVFsdThJVHVHVWlZ?=
 =?utf-8?B?TzkyVnBuUVRLQ1dvbUpCVklzaDVNWGJ6eTZ6V0lscUdXRG5lZkluMHpoeVdX?=
 =?utf-8?B?anpZS055KzlUMW4vZzBmWTlRNVNLb0RBekkxZDF2Znc1Z0cvazNGZTVWbk5k?=
 =?utf-8?B?V1F2c3lYS3BZY2FyclYrRGVPQVJMVlFOZWxzQlFWZ0VEVU1objc2MW1IQjZU?=
 =?utf-8?B?Mm15RUg3VWNER1JiK3h6Z3RUTjVMNUl2S3IvbHJ6RFgzRENXVXdCYUJ6eTd0?=
 =?utf-8?B?bmtqZk0xMnc5KzhPV3hxcS9TdFY3NGhiTzczKzNsRW5HNXVma0V3VmhySjJt?=
 =?utf-8?B?WEw1Q2hYRkJhVyttQ0s0U2tJMXJjSmhxang4MUR5UGMzZGVKRWZub3dHcEZB?=
 =?utf-8?B?akZUbm15MU0xc2xEQ05ORy8zVE1Jc3lmZUFDQ3ZrYU1PM1h2czRzNGtlTlg4?=
 =?utf-8?B?Vll0eVo1cmtXeEp0T0JSMXU4L2FSSjY4SkhxZVF0OW96UCtwQ3ZOdVhNUE9L?=
 =?utf-8?B?OVBsZ2JKQ3N1eW90NzZRdTBqYkxnUW54dWh3am4zVEU5Slg4UVF0dXdvZzlw?=
 =?utf-8?B?aUVXejM0RzB2UTNPbFZTRFRRcUZ1WjU0SGtqQWlvdlRkamlTTFAxNzEwQi9j?=
 =?utf-8?B?WFBQQUF1bHFFTFI2NG1yR20zLzdRNXd5MlppREREQWZnd2RHeE5DR1o1aW5E?=
 =?utf-8?B?NGxielJLRjhFSjBidGYxek82UzN6RS9BWDBNMCt6NXpJYTJLOTZpaHg3c0dy?=
 =?utf-8?B?RnlYbnUvMlorVUV2N0JIMHVDUWdLTURTM1VsMk04RXF5cHdDN0ppYzlsaHQz?=
 =?utf-8?B?S1BHWU93SUZpQTRqdFN5TVJIL2xSS0NUVHE3NHZmNW1BU0hwc2UrbEpQdmFl?=
 =?utf-8?B?Ynl5aHRVOVRzbFloMVlzZitHbXRPTjlqeFdRdSs3dDZIeUVhSnM4MEp4bkx0?=
 =?utf-8?B?cUViMHlweHFOaWtjTzR4bzYwdnNnU0pzb2RuYnErNWhURHJ0cXBTWmc3V1Zw?=
 =?utf-8?B?MGJYT0RaVzdYd1ROQm44TmF3eDhnem5CWm16ZUFTMW1yclpMMlpuM043REEr?=
 =?utf-8?B?Z3BjcUN2MHQwZUc2dXVrem1jWW9sZXVOMjIrSHdHSFFNcXNmR3pzWUVnWXNu?=
 =?utf-8?B?UnRWcXhqdysvUXIzTzVuNXhUQUk2NGk2OU9oVVlJc1grNEs3SUpSdGVSQlRH?=
 =?utf-8?B?Y053b0NYc0hmS3U2MnNXdEJxMjRHVVkyS3d0bmlRVTlrQkd4eENaUGlVVjhX?=
 =?utf-8?B?T2NkTmhBTXR2YVVGWnRTZjk4WEdOcVZkQ0ZaSW8xNktXc3ZBaHhGbVVxU1hv?=
 =?utf-8?B?b3dIWno0ZGtQRWxENm8wdlVaY1M5QXhab1hNYkJlR1RhaWpFZ25LdEJjUHJV?=
 =?utf-8?Q?14poOe8h6RW0gNH3g5fX70uk9TAd8J6MxapT7JV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6827d814-07a2-404f-79fe-08d96609e76d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 07:44:57.6451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/o5Z4C9MGaKyHqdUHOrUCdRMQPISed9+vgDdZBEOt7MbQahlo9++SXAYd0+R+VnWBsljJIl0XpL3tPhqLfYeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5315
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10084 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108230051
X-Proofpoint-ORIG-GUID: aPytnPs_xvSfQJKgjR6OXgGlBitlGWDl
X-Proofpoint-GUID: aPytnPs_xvSfQJKgjR6OXgGlBitlGWDl
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/08/2021 01:50, Desmond Cheong Zhi Xi wrote:
> This crash was observed with a failed assertion on device close:
> 
>    BTRFS: Transaction aborted (error -28)
>    WARNING: CPU: 1 PID: 3902 at fs/btrfs/extent-tree.c:2150 btrfs_run_delayed_refs+0x1d2/0x1e0 [btrfs]
>    Modules linked in: btrfs blake2b_generic libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compress lzo_decompress raid6_pq loop
>    CPU: 1 PID: 3902 Comm: kworker/u8:4 Not tainted 5.14.0-rc5-default+ #1532
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
>    Workqueue: events_unbound btrfs_async_reclaim_metadata_space [btrfs]
>    RIP: 0010:btrfs_run_delayed_refs+0x1d2/0x1e0 [btrfs]
>    RSP: 0018:ffffb7a5452d7d80 EFLAGS: 00010282
>    RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
>    RDX: 0000000000000001 RSI: ffffffffabee13c4 RDI: 00000000ffffffff
>    RBP: ffff97834176a378 R08: 0000000000000001 R09: 0000000000000001
>    R10: 0000000000000000 R11: 0000000000000001 R12: ffff97835195d388
>    R13: 0000000005b08000 R14: ffff978385484000 R15: 000000000000016c
>    FS:  0000000000000000(0000) GS:ffff9783bd800000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 000056190d003fe8 CR3: 000000002a81e005 CR4: 0000000000170ea0
>    Call Trace:
>     flush_space+0x197/0x2f0 [btrfs]
>     btrfs_async_reclaim_metadata_space+0x139/0x300 [btrfs]
>     process_one_work+0x262/0x5e0
>     worker_thread+0x4c/0x320
>     ? process_one_work+0x5e0/0x5e0
>     kthread+0x144/0x170
>     ? set_kthread_struct+0x40/0x40
>     ret_from_fork+0x1f/0x30
>    irq event stamp: 19334989
>    hardirqs last  enabled at (19334997): [<ffffffffab0e0c87>] console_unlock+0x2b7/0x400
>    hardirqs last disabled at (19335006): [<ffffffffab0e0d0d>] console_unlock+0x33d/0x400
>    softirqs last  enabled at (19334900): [<ffffffffaba0030d>] __do_softirq+0x30d/0x574
>    softirqs last disabled at (19334893): [<ffffffffab0721ec>] irq_exit_rcu+0x12c/0x140
>    ---[ end trace 45939e308e0dd3c7 ]---
>    BTRFS: error (device vdd) in btrfs_run_delayed_refs:2150: errno=-28 No space left
>    BTRFS info (device vdd): forced readonly
>    BTRFS warning (device vdd): failed setting block group ro: -30
>    BTRFS info (device vdd): suspending dev_replace for unmount
>    assertion failed: !test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state), in fs/btrfs/volumes.c:1150
>    ------------[ cut here ]------------
>    kernel BUG at fs/btrfs/ctree.h:3431!
>    invalid opcode: 0000 [#1] PREEMPT SMP
>    CPU: 1 PID: 3982 Comm: umount Tainted: G        W         5.14.0-rc5-default+ #1532
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
>    RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
>    RSP: 0018:ffffb7a5454c7db8 EFLAGS: 00010246
>    RAX: 0000000000000068 RBX: ffff978364b91c00 RCX: 0000000000000000
>    RDX: 0000000000000000 RSI: ffffffffabee13c4 RDI: 00000000ffffffff
>    RBP: ffff9783523a4c00 R08: 0000000000000001 R09: 0000000000000001
>    R10: 0000000000000000 R11: 0000000000000001 R12: ffff9783523a4d18
>    R13: 0000000000000000 R14: 0000000000000004 R15: 0000000000000003
>    FS:  00007f61c8f42800(0000) GS:ffff9783bd800000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 000056190cffa810 CR3: 0000000030b96002 CR4: 0000000000170ea0
>    Call Trace:
>     btrfs_close_one_device.cold+0x11/0x55 [btrfs]
>     close_fs_devices+0x44/0xb0 [btrfs]
>     btrfs_close_devices+0x48/0x160 [btrfs]
>     generic_shutdown_super+0x69/0x100
>     kill_anon_super+0x14/0x30
>     btrfs_kill_super+0x12/0x20 [btrfs]
>     deactivate_locked_super+0x2c/0xa0
>     cleanup_mnt+0x144/0x1b0
>     task_work_run+0x59/0xa0
>     exit_to_user_mode_loop+0xe7/0xf0
>     exit_to_user_mode_prepare+0xaf/0xf0
>     syscall_exit_to_user_mode+0x19/0x50
>     do_syscall_64+0x4a/0x90
>     entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> This happens when close_ctree is called while a dev_replace hasn't
> completed. In close_ctree, we suspend the dev_replace, but keep the
> replace target around so that we can resume the dev_replace procedure
> when we mount the root again. This is the call trace:
> 
>    close_ctree():
>      btrfs_dev_replace_suspend_for_unmount();
>      btrfs_close_devices():
>        btrfs_close_fs_devices():
>          btrfs_close_one_device():
>            ASSERT(!test_bit(BTRFS_DEV_STATE_REPLACE_TGT,
>                   &device->dev_state));
> 
> However, since the replace target sticks around, there is a device
> with BTRFS_DEV_STATE_REPLACE_TGT set on close, and we fail the
> assertion in btrfs_close_one_device.
> 
> To fix this, if we come across the replace target device when
> closing, we should properly reset it back to allocation state. This
> fix also ensures that if a non-target device has a corrupted state and
> has the BTRFS_DEV_STATE_REPLACE_TGT bit set, the assertion will still
> catch the error.
> 
> Reported-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> ---
>   fs/btrfs/volumes.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 70f94b75f25a..a5afebb78ecf 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1130,6 +1130,9 @@ static void btrfs_close_one_device(struct btrfs_device *device)
>   		fs_devices->rw_devices--;
>   	}
>   
> +	if (device->devid == BTRFS_DEV_REPLACE_DEVID)
> +		clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
> +



This bug is reminiscent of the commit 321f69f86a0f (btrfs: reset the 
device back to allocation state when removing).
Before this commit, we freed the btrfs_device at every close. And alloc 
a new btrfs_device, so all the dev_state resets back to 0.

Moving on, we still have other dev_state which aren't reset back to 0 at 
the time of close. But it can be a separate cleanup patch when needed.

For now, looks good for me.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand



>   	if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
>   		fs_devices->missing_devices--;
>   
> 

