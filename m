Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336BA4CCA50
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 00:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbiCCXyt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 18:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiCCXys (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 18:54:48 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8596015879A;
        Thu,  3 Mar 2022 15:54:01 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223KEiEO017339;
        Thu, 3 Mar 2022 23:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : cc : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YF/I75ejKiZyfXpCdtMvFFSOPDHiUTV05h9x3crw7c8=;
 b=unvtbgw8aqAnFTbjbFk0YMeQ/2LjHe4bb7NxvF01znjSsu+TxnGnfPfXlaDPKjD20Ccb
 1K9A9W7Kpmx68IKhbuL1FXnc+6vHaX1TlWXdQGN5BnLb2B2nmBbh7kdE3tlQn3vAyxNg
 jen1Kh5HDpm9hRW4HobyGdyjviwq9gel2UlDRYi40j+vVhQEvIOHz9zIw1RowviUQhR1
 IOw+xiYvmJufAYBF3xFzNi22uWIe4l13JXrKsAnMFitQ1Gv+yg/9kMnej0sT3HlkXO2h
 yYDMGdou2kRMwP6fAS2D8SS7KhpDeIu7fXGOIs5lK0aJifq9ux4UM4mQS16iO2udHs3L pQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hvgdc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 23:53:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223Nb9nW164498;
        Thu, 3 Mar 2022 23:53:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3020.oracle.com with ESMTP id 3ek4j7y80e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 23:53:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPw0f3ZmxAUu0BlwQCtopHgYRt4IiCwQrSM4W/OsfSPEFl8FKBZhBvAbStZ2sJgDYdtTyciNUcFGJQoxRKVOL9aF+BdZ3t2HZZtmyuObSngBTktUmsGcItK5gFsHMjjloVGlE4bJN+pdc2NUjDmiDWLw0ixUlXYP2ZrDULjcr6vIkreee0cTdTUPXRud3HpOUR8RRe2u4Zi1zKU80R+/W4gducZEeE3YO+v9xHTnyVkoYUrNepPrYY7zwbegAlIkBrm3HZGIXwsypS7JGr7mam4Z2eFe5IeZIyVY4ooC4/nfOmDPwLm+g7yqe9TWVM8QWbOqsR/ua8jB3zZpd2mMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YF/I75ejKiZyfXpCdtMvFFSOPDHiUTV05h9x3crw7c8=;
 b=XQXfkENjU3XVwPV6P/bATGdGwLALLiyzjLjlo44rS0uNBm6kxFf2ubt7x8bc+gOpuRrm8PTg/ymt9HkamSPk98YRoYYi4f6556yefY5YthNBLhB9XHzioYd/udjpiQ5EBxEZNAvrrPu5ZaQJBti6jKtrJn7YJMh8LpKlYQ9A8d7Pi19gYTGFQod9Xvgeg0O9pKfNIDcfek6mfO7vZ+viLd18RZkpmk5ZA83bXr3KfK1ERa4H+V0jv6i3CRekDLVFvgilrYHIOwF9RItim+m34RzrkXc26jJ+2uegxrdAI+NkNo+dPNwcpz0SEz3B9wkXwTrxeiOUWCmZBjgv3iZiSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YF/I75ejKiZyfXpCdtMvFFSOPDHiUTV05h9x3crw7c8=;
 b=tEavoo6yZlBOF65pTupNbPNjO9RClMKHfauY6g9A2J6jv0kSCZ2XHQyLww1BeBJ1FcqqRfFs8lngrCMy65a7S2okHeBT2drHFd5yJlrqcvKUROyFSFDSVo+00T6RknkHdebK6+79WP5RV/3qxLatDLSYF5c2iqCF0sAxUSbQmQA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB3985.namprd10.prod.outlook.com (2603:10b6:a03:1fc::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 23:53:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f%6]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 23:53:37 +0000
Message-ID: <e3f0ab62-3d1f-a316-2d7b-a0b791120f87@oracle.com>
Date:   Fri, 4 Mar 2022 07:53:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] btrfs: don't access possibly stale fs_info data in
 device_list_add
Content-Language: en-US
To:     Dongliang Mu <dzm91@hust.edu.cn>,
        Dongliang Mu <mudongliangabcd@gmail.com>
References: <20220303144027.1981835-1-dzm91@hust.edu.cn>
 <20220303182431.GW12643@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>,
        syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com,
        Josef Bacik <josef@toxicpanda.com>, dsterba@suse.cz,
        David Sterba <dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220303182431.GW12643@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 618277c1-01cc-499b-7a64-08d9fd7108ff
X-MS-TrafficTypeDiagnostic: BY5PR10MB3985:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB398549022B346D9302FFDEDBE5049@BY5PR10MB3985.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kwNdXU5pCO6S5j2XB7SFx5NyOGKqXFPDWm+Nqldo5g+SB5rLuqSwr4iIQm6ZP3dfqc1twob7d7BI0WAEthsk/fdRFL3DKultIKgir0anQvhny4Fju1V9i8SF+evU79ZDMZL4Krel3Xf96h4HMPB1+fQCIcvVXwDI+h/52BVOlNuVxsY3P0GFiPvkLGW+zshuOK7X1J94MBKl7QglKMhIFKwD3q7ZyPfXULaCvg0+JZhgtGX/gRABjhX9Sx0yyz/qJqXiYjweItyj7I08fwkzYYlHbPrAD4IszfMgIkSG6HN4zZdq70r8x6IEtnBMwxUCVF2VTaojQE+0rKW3gkR5b8Gqt7OYA64RDy2m3dzL5NyIFM94TxmfWsUmNMuPWOApJy2DYCMwMwxJWOF0AXJ77eBrqjpIBKS8pr2UaOf26++J97M/k+KWW0Jsqnl+y+ldZA4UuLJo1qcBkvl/LwaAkLGusvh3tJo/W3cjhGEkiXbTkPfi0yZSRMk74iJIwySa6X3qi6jj2eMkey50AjUhtRy12+YndQut5/P0HvJgSAUjnCkSafQ6LCygJGv1jnuz91e8kU6rXX5OiSi5LuLHPljKpuCnwoH4VLlNIsUdl0e/xn6PiuH7hf5iEOR2QFjAtC1AzrWayhtGoLXuSl1WvzyTstonCUBuk28vaSJ51tkq+RqNAY8rruzRTaC9Gvw3Cwt2QKJGp4wcQiLvda33jSLeticX7jPYSFZV8brPztw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(508600001)(83380400001)(6486002)(2906002)(38100700002)(53546011)(6512007)(31696002)(6506007)(6666004)(44832011)(4326008)(54906003)(316002)(26005)(2616005)(110136005)(31686004)(186003)(86362001)(66946007)(66556008)(66476007)(8676002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG1GWmJIVEFzQ0hCYTBYS1oxUmtPUkRHNXVYNWR6ZGRyZzNLRkJUTmszNCth?=
 =?utf-8?B?UUZSYktaczR2c1NZandKZkN4Y0ZKd0tRaWVlTUVuTXhYT25VY3Z2eTdiQ0My?=
 =?utf-8?B?aG1QMHdzL09rNDF1cmNPdEQ3QUM2ZGRiaGE3Y29FT0xxUkNwVTY4d2tCWnBa?=
 =?utf-8?B?ZnVpNEFkajh1ZEVhOVVpTElLQ0I2Y3daNW0wTk5qcDN6N0czTGNEQmJDWDQ5?=
 =?utf-8?B?NG1oVjNvbi9ncmpoM0tCcUVLNXVZQmJhNTdFbSthSUlLTEZyNDF2Q1ZOVnhq?=
 =?utf-8?B?cElra2szc0plemQ1T2hIQ285SnVVaHpNVXphQlduVDkzQXpTeE5JeER1c3lY?=
 =?utf-8?B?L3gwVmx4UDhWbEMwK3A2T0x3QngwZjJhUGxhdnBOek5wZ1pHVnNLdUpHbWpp?=
 =?utf-8?B?VmQ0YitRa1VOWVlwbHpIQURvTFhKZThnZ3FsY3NUb1gvKzl0SnY4bmRIQU5w?=
 =?utf-8?B?RmllUHpSYVhKSFVCeHB2M1NWYWtTVjluMnZpc241bE5FR1REMVFXMStnRzFL?=
 =?utf-8?B?KzArT0lMbzVIZlBFYXNmenh1TGwwWWZLSUVoZmszaHJuajBQOGtnRGFnU0tr?=
 =?utf-8?B?TEFRUVRNZG5pbFhrS1czQ1d3bmtOOTN4ekRBR2lHZnlXcGdmaHNKbWNxT0hp?=
 =?utf-8?B?czZIdTBsTjdCbXpoUUVDNDVBRTVoNS9JQXl5QU9GQkY2R1pqbUJGbkxRZ2ta?=
 =?utf-8?B?RDhoMjVPMm95ZzBmU3ZIcGoyUVc0SlcyaU5NQkkwQ1JBUS9wSitLYi9ERVlq?=
 =?utf-8?B?MmV0L0svWG1lRm8yMzltZ0ZTRkdyeE03UWtqZVlNdHJXUDV6d0Jlbmhtakti?=
 =?utf-8?B?TlJDSm5Fd1BFL1NRSTlxTVgzVXRTcmwxSlBJWUtOQ1c0bTA0NEI2R3BxK0M3?=
 =?utf-8?B?UU9aN3hyTGIwVG9BVWMwcER4c2k0aVRPVDN4TVVHSW8yUnZsK2FHeTZVMHVs?=
 =?utf-8?B?b29hS29RdEpneXM1Z0tXOU9vVlFSSWQvaW1vUUw4Q21yWnhaSE1PVmtsbXhs?=
 =?utf-8?B?TmR3MU01TEUrRmNXZkY2R3l5aFoyOFlzZGhUNjJqSVJsamFGZFRYS095ZlVU?=
 =?utf-8?B?Y09zV2M1QllMM0F3Rm5EUlg5a3ppNUEwcDBTWXdFNVZZT2pTa3c0c01oRm5h?=
 =?utf-8?B?ZDdYUGpDTWFDWWdaeWs2eTN2TmdMQVpKbVlRbTdXWkhPRjUxc3VVcEZHZ3lG?=
 =?utf-8?B?QzE4SWQ5YVRRSXNkdkZRY0dTS2xiVlVpcEIrckJLQ0M0QmNwTDgxbTRZa2NS?=
 =?utf-8?B?RFltdGJOK3dUdSsvU2pTY1NmOHc0SXRvd01PSUEydWxuY3MwVHFUQWhITlJ0?=
 =?utf-8?B?UFgySnllVFNLYlN5WXJYZ1o0Z200ZUFPVERUTG5sL21zM1RNUTlTZHI5aHRL?=
 =?utf-8?B?WUtUemljV1E0OVJGK0tPdmtVNFpsWFVkbHpCRTc3Y3F3T3NZeXRwM3J5OS8w?=
 =?utf-8?B?eHpoY1R5czQvQkdZYjZROTF5NDVOK2krME9BZDY2MGFkL012TmRwWnJhczF6?=
 =?utf-8?B?Z2hPRU91VjhSczhkYmllSzBQUTE1RFpNYktqNVF4Uk85Qm8yN3d5b2tMa09B?=
 =?utf-8?B?WGFDTkxpQlJJSjJJcGswWjZkS200R0h2L0EybGVnRjJyaFhJNDVoNzUyRHAw?=
 =?utf-8?B?RjM1TmlXeXlJMjdKcE5vcGpCYzZqMXNFQmVBNGp2VXltdE5iZDliNzd2UkdG?=
 =?utf-8?B?dWpoM0doa01nL04zTWFmVjBVc0lhM3M0WmpxZ3JIcDVZSDlUMU5NQ2hEd2hW?=
 =?utf-8?B?SXUvQisxQlNxMzYzWlpObUhDT3Z3bnNQd1lTcU5FOGRSZUpGT1hKNUxDamFD?=
 =?utf-8?B?K3ZlNzJMb0xhZEVFZ2JRa2VGOEU3WXFjWlV0dHQrbWJEN0FSZ0NsbEhJZmZk?=
 =?utf-8?B?SGp2enVYNjlQc0xvTFJmUUtDdnd3L0JPRmpGaHNuNEJNMGtna3Z2VmQ5QUZU?=
 =?utf-8?B?ODQ3aEcwR3FVTC9GOS9lOExXVW11VTJDbTFqLzkwM281V2R1VldRMnlZVlFp?=
 =?utf-8?B?STJONHFKTVMxZktEd1BwU0hzSCtKQWczT3JVbm03TGJQZ0U1Wm9QeVVyaGcw?=
 =?utf-8?B?QlhjaXJVM1ExMDlxSlpnRWFPbDZSRzFtZCtKZm5HY0VEWWw5V1NLQWVkN1NG?=
 =?utf-8?B?UHJ5RzNFMmphaG1hTFBia0hnMEZFWGx4TFBVYVJuM3lRYWxhUnVBZU4waE9z?=
 =?utf-8?Q?yQcS6yUG21UGfvMlpPvee7U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618277c1-01cc-499b-7a64-08d9fd7108ff
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 23:53:37.7291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouXl7gX0wrI82wy/tYPN+i7E/fJd/NEtNQAe6a0Wcn6HwaIvacXNZJbHCC1HhAmE27f1pitR/J49pIHhluedDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3985
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203030109
X-Proofpoint-ORIG-GUID: QdRJ3zO2MI6zYQeldPxiZRgx2t6_ABEL
X-Proofpoint-GUID: QdRJ3zO2MI6zYQeldPxiZRgx2t6_ABEL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04/03/2022 02:24, David Sterba wrote:
> On Thu, Mar 03, 2022 at 10:40:27PM +0800, Dongliang Mu wrote:
>> From: Dongliang Mu <mudongliangabcd@gmail.com>
>>
>> Syzbot reported a possible use-after-free in printing information
>> in device_list_add.
>>
>> Very similar with the bug fixed by commit 0697d9a61099 ("btrfs: don't
>> access possibly stale fs_info data for printing duplicate device"),
>> but this time the use occurs in btrfs_info_in_rcu.
>>
>> ============================================================
>> Call Trace:
>>   kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
>>   btrfs_printk+0x395/0x425 fs/btrfs/super.c:244
>>   device_list_add.cold+0xd7/0x2ed fs/btrfs/volumes.c:957
>>   btrfs_scan_one_device+0x4c7/0x5c0 fs/btrfs/volumes.c:1387
>>   btrfs_control_ioctl+0x12a/0x2d0 fs/btrfs/super.c:2409
>>   vfs_ioctl fs/ioctl.c:51 [inline]
>>   __do_sys_ioctl fs/ioctl.c:874 [inline]
>>   __se_sys_ioctl fs/ioctl.c:860 [inline]
>>   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>> ============================================================
>>
>> Fix this by modifying device->fs_info to NULL too.
>>
>> Reported-and-tested-by: syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com
>> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
>> ---
>>   fs/btrfs/volumes.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index b07d382d53a8..c1325bdae9a1 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -954,7 +954,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>>   						  task_pid_nr(current));
>>   				return ERR_PTR(-EEXIST);
>>   			}
>> -			btrfs_info_in_rcu(device->fs_info,
>> +			btrfs_info_in_rcu(NULL,
> 
> A few lines above this is also NULL and was fixed by 0697d9a61099
> ("btrfs: don't access possibly stale fs_info data for printing duplicate
> device"), so yeah we probably need the same here.

So it appears that device->fs_info was garbage instead of NULL OR
fs_info->sb was NULL?
Because we always had a check if fs_info is null in btrfs_printk()
further the commit a0f6d924cada ("btrfs: remove stub device info from
messages when we have no fs_info") made it better.

Thanks, Anand
