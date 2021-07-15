Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575C53C9DB1
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 13:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241922AbhGOL0M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 07:26:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2596 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240366AbhGOL0M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 07:26:12 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16FB6Rvc002666;
        Thu, 15 Jul 2021 11:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EMbg5NClAsgxmZf00tOcFc9g4B/nxJL7cEQV9pON6XI=;
 b=C2frMgY3YxZRpCDfHVcuLi4fiwUMs8NWGc2H//HoOZpZ286Eix653KCzmUwLNjdj08KS
 Q9AZI17S8xValiwnXcrnuspvjdmwQrS5LEnYxkt9ligqJdQAap/sHblbsk+M9LHfiLDi
 GMuHXDRbxEc1blmXVAqLyhdXH3lm5saw4ITS/Y1kxIUD+MG2OxGb23crUmpcFem6dev9
 ZjBBGdoHK8BJ+Dn2dYqC6IAJmtvAmdOYPSTMZSlDdRQsN9rB9hVXJvbnKKIARe98f/Ev
 jzSToTwi4zo4vYTovvkSfwAG175HRXkDvSSF5s1iyUgaTwRVa3c9jTlo5mhPQK/I4ccN pA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=EMbg5NClAsgxmZf00tOcFc9g4B/nxJL7cEQV9pON6XI=;
 b=vcii6cp4Kgtg/mGwE6MLctmhjkFj/+/3D+orar3j8sKzwcxfah8Rjyf9C3MvjDsTXWxI
 eshLDmIwJ9psIByTdq7cFV5/GBpX26uKAFX2i9IcctG95iT0+g8slL3FwzPft0L7qUEL
 lZAM6oHyWaxti9qj2du3POnuAphWU4HwKVGBu0y3S42prSwjBaS1LSHXUbZyIYfVxsBG
 40qL7jAUESUIJQH9cEuYVzkSxxm8LYquSva/ykSiYPmIz8RObFClmeLuPnkNeRdhyyo3
 YJFGzmC+Es9tlSeSSbeqtn/ME4+lQ7JTjnU2HPankaavovwl7Q/jQRjn/2Q7js6CbWVJ 0A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39t2tj1t99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 11:23:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16FBAcVv143872;
        Thu, 15 Jul 2021 11:23:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by userp3030.oracle.com with ESMTP id 39q0pamnej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 11:23:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJtq3jtLblgduk0WgzY0hBBw+gTcSES7jNJH0B8AQHJQkkS50Nx4Ygd1+HEPdH1vgVXA0WAeO3eI3VYSPBe81XSXmf5QY8eYPqRnzOhYnu9/CN9MQ/ATSnfF69edQBc54xtjhnW2o647uKoYeAN8RtWhpzPnuRqkBDS1GsjZ9yvhNAIZjbrRRcse3eejAMctLf/TJOKk9NHdzDwh1pjlURMV44c80wokNc+aGqly7GL7zPZcS0uXRrxvciZh1M633uZ/+EaQLqGWmyEStQILIPZGCdReshbh2ttGTX5ieD5vYXTbz8utVpZquY2p3GDuBAAGyjYfqW6b+IEKqfv+bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMbg5NClAsgxmZf00tOcFc9g4B/nxJL7cEQV9pON6XI=;
 b=m3XH586XitawU3gSLP8oqSRzm/dgxMs8/fEGEcFtH89zJPS2LoCCLtNNT1cMF0u9LhpDXGPmUbUMF2COhN3dfeBcelxnjZQaH06rFvXftrhvOCe78kI22UzYJpx225bWcedkWuRmSSdXiEv7zPieX5Y1u5EE0+WeUC/OvDfu1FAAj4LljSXm0pvjBzpdugSb753OaWlZ9lzhNfdVm1kjeKkWY6O10y+yURwa/IXN7T7hn0cB0ous4ycgYccaxhzDsKORpfXtugnzwVw2UxcEnv9Z6R8KR2O1SgrM+cVVToaLor4TA1B3Ctg+TCQ8/JZkxu1phBA46OZT1yQ38jfSbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMbg5NClAsgxmZf00tOcFc9g4B/nxJL7cEQV9pON6XI=;
 b=W++M/5qJEj9PqQklswdViCIbn8mDpUTwP3ZXgrdU0RmBN3lVOgH1OPWV+e4HhNt12RsdCzEFbRJgYLLFZB7tzhdhF1NeE1W2E6GGNO+mUQ6Kg6Ae7AjPS7L0JyeztfQ45WBE9JI9c5l0V1WWOj7hc3XRtmWYiMMJ7zSxtaXtpmA=
Authentication-Results: syzkaller.appspotmail.com; dkim=none (message not
 signed) header.d=none;syzkaller.appspotmail.com; dmarc=none action=none
 header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5169.namprd10.prod.outlook.com (2603:10b6:208:331::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 11:23:09 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%3]) with mapi id 15.20.4331.022; Thu, 15 Jul 2021
 11:23:08 +0000
Subject: Re: [PATCH] btrfs: fix rw device counting in
 __btrfs_free_extra_devids
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
References: <20210715103403.176695-1-desmondcheongzx@gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <283a54bd-8f46-f615-0568-a375a121c2f0@oracle.com>
Date:   Thu, 15 Jul 2021 19:23:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210715103403.176695-1-desmondcheongzx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0224.apcprd06.prod.outlook.com
 (2603:1096:4:68::32) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0224.apcprd06.prod.outlook.com (2603:1096:4:68::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 11:23:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 274d8410-657e-4c8c-7e7c-08d94782ec5a
X-MS-TrafficTypeDiagnostic: BLAPR10MB5169:
X-Microsoft-Antispam-PRVS: <BLAPR10MB516927B0D6B49C3558C11D7EE5129@BLAPR10MB5169.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: coOiPg0cfOpIblgqF6z9UBtnKzN7aegLH2mTgXAMM1LGq2LmaWDGBXV6LA8FAz9+mmu/PizRXZMqbm5g+nQbYhRDiUN/UwTh8LJjpIW7E/0wI3RFeneYh4mJhKkDJUkZW2IwfgZWKxen11E+3ubPGaWSh8wF4oxtnveoZR7MdAW3XWZyGiLtYwNIbXnH6mSWXPkpHcO9ypJD3O5+UdW7d98Z5zU9xTUxgXzR9kHKfD9okB2D2kEHt/meBJnvicflpAH49EuTLRIbfTl0UjDP0/6tIQaxCpAxhlszoh7X7VOuYdibcKLmAaBgrYdFPpYLhoykRL57hgwbNhNlJZ+IZbZdAz0J6KbsK7zHA/6/Sa2ygMUhs6fiuqy2XKd4CfWu583ShpYfBicIa6WzTW68Fg0B/w5R9yx2FmqCHXYpwefUW27Mxy43znTnk0zQM4x1U8Z2JT8s5jCmzM7rp7J9JoC2RPGG2F6m15TVjRy+XeND/jLoSuS5iIwHfP0X+WI1O6Tq2bJ/npr/3pLuJbgc2NtVsQKWtM9hNl9xq4v8XdWw9PzD/s5b61SV1GUzRtMey01o8rIaNtwocLOBDK5MsDU4jmCuIqGq2hhRNlxzPiWCyksnCstq/AwwgTY+4mF+EXN/vRq6rd8bEGgwpVpgRO+A9cTbthPVsi65Df1zULD4pGfr3oaKxQtZyX8IbjZB6rrPpnXBKUdVI5sv/sUOV9Ea0PxeReQhJTpeOfApPVw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(39860400002)(396003)(346002)(366004)(53546011)(7416002)(16576012)(186003)(5660300002)(44832011)(26005)(478600001)(31696002)(2616005)(956004)(316002)(66556008)(66476007)(66946007)(8936002)(36756003)(8676002)(2906002)(38100700002)(6666004)(83380400001)(31686004)(6486002)(4326008)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXNIYXllNDdvSy9NV2YrbEZodGNMd3E3MkJwbFZWL202b3pyRDk5S2ZnOG1L?=
 =?utf-8?B?eWpCTmI4STFxZEgyZHNOcUxqYmJWQzJyRzljV3UrOUY5NzNpUGJRT2pqVS80?=
 =?utf-8?B?TlZ3QitzTThIY2gxa1VRczlKemlYN0hFWEw4MFROdlhoZC9tOUNGNFdySXJZ?=
 =?utf-8?B?YmFRR29VQWlvSE5XRFZ5b2ZNRGdQS0Vva0xhWUJRRHltbnVZRzI4bmRtQ00z?=
 =?utf-8?B?UkZwazF4anhXaDNDTERNN1RONEE2OGdPZVNQdHdkUWlFblJNV1RkMUlDZVQ2?=
 =?utf-8?B?WXJKOEp2YVJwRHdGQlQ3UkRQeVVQVk4ydVd6b3g5RUNZTk42VzFLZ0tKWGxk?=
 =?utf-8?B?alE1RmFMZk9vVzcrSXAzdG5UaDQwMkliQkhWanpIUjZNTExVdXpSS1FNTHIv?=
 =?utf-8?B?aFMzcU5JakZNWjc2cTJtcUVSaG1jV1AzOUdQSy8rdDY5UEFVV2N0WU5KakZ4?=
 =?utf-8?B?bEtNRnBaaGRqM3Q2KzZCeHNVU3BPdmczaXVpWjNSNjlGRkpHbDRGYjFvaEhq?=
 =?utf-8?B?Y3o1cHFEenFzdkdNWXZDenVMdWg3UWNmNTI5WTBCMFhxOStTaVVKU2JqWnNB?=
 =?utf-8?B?cEJuR1dYVTNObUh0Uk9PV2hjaWpvK3JNelRJT2NRVzB3MVZOanZrZ3BFSWE5?=
 =?utf-8?B?WEVQZzVCTk43UnFjQlBteENJUGJIRWpsMzIvZmlWMGlyTUpjUnBJUUlldHc0?=
 =?utf-8?B?VVVXTUtvcm5qejVkczJ0a1lDNWN5SU9YMjJZOStXam5ib1RBQ3BlRUJWV2Jr?=
 =?utf-8?B?TzIzSXNZRUpJdFU0ZE9LajY3NFRRNklyYmVmMElTemNyT09hSDErU0ZxdlRC?=
 =?utf-8?B?WjViTWZYV2huVTd4NkFIK0hpZmc5KzVveFZOUXl0U2NINFF0QXQzNXVEV2hr?=
 =?utf-8?B?cnViaFRvS1cycTdoaTBMNTIxU3pEeHRFTE42STNtaTVZalhzWG5waVRhSnZV?=
 =?utf-8?B?RzU0aC9VeGJoVndhdmxKRlBkU2huQ1Q0Q3piODdrQnlYSEQ4b2w4VDB2ZGh4?=
 =?utf-8?B?LytsbFBuc0tpaldNeU9meVV5d0d2anoxRFRTbU9PazlETHR2Nk5CNGR0RmxZ?=
 =?utf-8?B?bmdva2RJKy9QOE5IUE5PTHRxaXlhNERXS3doWmZBYkRTUFZZcmRMREozb214?=
 =?utf-8?B?N0tEVFkzaUhpbG9JNEVsYkt0Y0JWcm5WVDhmVktpSDZoVFJNTW9pQkxTbm9x?=
 =?utf-8?B?bDdJa2VEYjRINGRaZUhwYm8zMnBCRU1vMEJCU2FEZHdlcVhHNEhnMkt6c1o0?=
 =?utf-8?B?U3JjQ3RtcEVucU4rclpDMGVYWU1UVlFVTlJiNVBib2NSR3NnL0ZRdFBBazI4?=
 =?utf-8?B?ZzIwQ21HdzluZVpaQUFRZTRscUcybWQrYWdrYjhpL3ZNMVNuV2NWVjE5WUVy?=
 =?utf-8?B?MG5JNFlrYUhoUlp0dFFoakF6NzZXL2Y5K2ZndUZXUVIrVk1TU29ubUpHWEcv?=
 =?utf-8?B?ZDlSVmR6Nkp4UW9ZR2ZPUm5PK2dhYmFYcU9VdTh1QUdDR1dLYmJhcXVGcTJM?=
 =?utf-8?B?b2tTODI0YjZFZGNQYXFGNTB4a3lOQ05vNlNzaExrUkRUVWtDTUtmT1c0UTR2?=
 =?utf-8?B?SzNPS1Bucyt2Qm1oWVlSUHowMGdEQW4rTExjY0cyQm5KMFRiSlJzMVVrVWJC?=
 =?utf-8?B?QVcvY2JITnBSelQ3WW02ajJCTTBrdUhiV3hhdHdoTllSalF3R2tVUE5mbE1G?=
 =?utf-8?B?ZEZ5VlgvOU0za0JONFVuM3hvclBLNFFCR1VOdW9XeVhNRlBBc1I4WnVoaEVJ?=
 =?utf-8?Q?LKDEPVEq8V0jPmDbEDQBruuQBSuOKhiZv8wI00T?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274d8410-657e-4c8c-7e7c-08d94782ec5a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 11:23:08.8032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Hnj68osZgf/bJbw6yADWaAA6l+p1UiHKRJbYO3awBOJUvDSWf/QNbAPPZhDIRAHJ3YvwG2HIFjKacXp00XmVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5169
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10045 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107150082
X-Proofpoint-GUID: IP5wYrDjDwMxS8QT-65-2nmibCe-N81k
X-Proofpoint-ORIG-GUID: IP5wYrDjDwMxS8QT-65-2nmibCe-N81k
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15/07/2021 18:34, Desmond Cheong Zhi Xi wrote:
> Syzbot reports a warning in close_fs_devices that happens because
> fs_devices->rw_devices is not 0 after calling btrfs_close_one_device
> on each device.
> 
> This happens when a writeable device is removed in
> __btrfs_free_extra_devids, but the rw device count is not decremented
> accordingly. So when close_fs_devices is called, the removed device is
> still counted and we get an off by 1 error.
> 
> Here is one call trace that was observed:
>    btrfs_mount_root():
>      btrfs_scan_one_device():
>        device_list_add();   <---------------- device added
>      btrfs_open_devices():
>        open_fs_devices():
>          btrfs_open_one_device();   <-------- rw device count ++
>      btrfs_fill_super():
>        open_ctree():
>          btrfs_free_extra_devids():
> 	  __btrfs_free_extra_devids();  <--- device removed
> 	  fail_tree_roots:
> 	    btrfs_close_devices():
> 	      close_fs_devices();   <------- rw device count off by 1
> 
> Fixes: cf89af146b7e ("btrfs: dev-replace: fail mount if we don't have replace item with target device")
> Reported-by: syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
> Tested-by: syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> ---
>   fs/btrfs/volumes.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 807502cd6510..916c25371658 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1078,6 +1078,7 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
>   		if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
>   			list_del_init(&device->dev_alloc_list);
>   			clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
> +			fs_devices->rw_devices--;
>   		}
>   		list_del_init(&device->dev_list);
>   		fs_devices->num_devices--;
> 

Thanks for the fix.

Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
