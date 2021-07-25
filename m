Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B653D4DD2
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jul 2021 15:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhGYNJN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Jul 2021 09:09:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48418 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230029AbhGYNJN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Jul 2021 09:09:13 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16PDmGlQ010137;
        Sun, 25 Jul 2021 13:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=f7+w3XP/tlxVhhDhiui6e0y4OTls5edv3NN7d81SkZ4=;
 b=MKag3+akm1trlsuYlYli3q7cWJ6pPnJdmN8VIutTN0rlhZ/J4/yJDasypTJgbniVTxlO
 s3MUvwJMRBSFaBdEdIYXBMIJmZVsLrPPiev3kaP6FCsxWVr2GKqqPAhZhewatg9CU+1T
 qOQUd1+vCuhUuZvqZihzyYWOsGT0qw4Blb1dhgJYh07EgXTiO965RQ1Qxo3Vu/X7zefO
 s7OVftq9vF3qj8DpFwtB/YsCearDLxk9ZfzqcltNXuQdy+0/acS6nXusJy1cTcU8P4au
 haOg6Efr6LGyUudjtYHzXuhW+PtqpPZMzv7vAFdfN8M1U4KlGOfS5wfjRL5uu5qFM056 7w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=f7+w3XP/tlxVhhDhiui6e0y4OTls5edv3NN7d81SkZ4=;
 b=SGTlNxj4FlTZV/DrIUEswC233crAdn6MoKUNyIh3Unr6T5k0hhsHwweEZ/JN++gVrA96
 +D17yaEEyHAOcHpG1qJXNKJ5I6xurdi0vDFW0l7C5ZzE0N5NLBw/GbU/LEQZWMaXd8lo
 1hirWiUHW+zke99Q1LyTG72G4X712zcuNgXQ8kXgoe6ZihowJvTFBKkpD/sOSYi7qSay
 ewhsDJFCBvy35+WNLSGX2wskqtexF/lDgswmlYy344TnPTMxrZMdWj1UxYaLD00K7mM9
 jSKfygeEipoQbKHhj6jtvuUtWSpi6daCQ/Ok4yRHNTkl1lfnDem4fJksc+uOQ+C8Ey1R Bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a099c1gxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Jul 2021 13:49:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16PDkc8f153689;
        Sun, 25 Jul 2021 13:49:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3020.oracle.com with ESMTP id 3a0vmrakbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Jul 2021 13:49:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfE22kadDoSq2l33SWvYeS5pQs/Ypx1yQcKqiyeWnK45gfvA5n8lyTJ9lESYuCUbqATV2JZUX8M90OGMV6HyJOD04wEqtqiEoj9hdrdPN0aU7saCE4NmRKxVrU58C9KqakPFMRcK0KcIr7L4AigPGhYepisBa2PacQSOcAJGqIGJArFdOuSrlS8jZpYwWr0M80XJyp3cOvSlSYzMzOwK9NhooS3bRQ5k17LgbWpVMadaOcCNQtBisDSjGyo5p4VNLQccHfdhSoRn08oARrktbnpXo9q20RFdq6tImwkOC2bedrCfP6KrMFiQmLoqzWWswpM1CAnzNPyH65Rb704R6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7+w3XP/tlxVhhDhiui6e0y4OTls5edv3NN7d81SkZ4=;
 b=S2sJZdejq9ihTE2aeQENFs8oJTiJ7DAHWjQ/1bht9L+HTnAl55jGI60pNXv/qqFRgkVdWooSyDIjcP1cFAcMgBNEBbr+vbBW6w8l595Q/Gyu94x2MpSDC7Q0Ec18ZJpN80muUb7QhG82bg+KhjHQBLfKeqjF9HJ+c/CbfrnS7b0NuX1KOESUsVPXRte89h5ZUd7cTBuvM5zTtL7Ucj1qHb6ZtYOxvHgcd5jMJSIuOCwbbh5wTPXvzT51Fc7enjxwNQ+0EJBBUOFF8Gkd3b6vVY8OrkIenXL70+NTAQwRS1g8pchCqY3ytJFIQs9n0fD+PSaDwvujYCjaYQSB/K5H5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7+w3XP/tlxVhhDhiui6e0y4OTls5edv3NN7d81SkZ4=;
 b=eCBV5ZN/HbxV32Vf6rkD9S4l4rVlAuw6V+XoHRHgK8N0+SI7jpNYOMdes2PPxbKNmrG20gb3XaVa9fVdg/U2Kem9yhUkitC/n62JRdmiAmWx2NZqH2af27xeoKcR2tPJq0dGjBew+xfiE1U6SQ1+Fbmi6CT29xrGkMtlBxoYtlM=
Authentication-Results: syzkaller.appspotmail.com; dkim=none (message not
 signed) header.d=none;syzkaller.appspotmail.com; dmarc=none action=none
 header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4820.namprd10.prod.outlook.com (2603:10b6:208:30c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Sun, 25 Jul
 2021 13:49:29 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%3]) with mapi id 15.20.4352.031; Sun, 25 Jul 2021
 13:49:28 +0000
Subject: Re: [PATCH] btrfs: fix rw device counting in
 __btrfs_free_extra_devids
To:     dsterba@suse.cz, dsterba@suse.com
References: <20210715103403.176695-1-desmondcheongzx@gmail.com>
 <20210721175938.GP19710@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+a70e2ad0879f160b9217@syzkaller.appspotmail.com
Message-ID: <24c7304c-9a38-278b-0ae5-78edb225cb4c@oracle.com>
Date:   Sun, 25 Jul 2021 21:49:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210721175938.GP19710@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0108.apcprd06.prod.outlook.com
 (2603:1096:3:14::34) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0108.apcprd06.prod.outlook.com (2603:1096:3:14::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Sun, 25 Jul 2021 13:49:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ccc470c-e13f-4773-9091-08d94f7305b9
X-MS-TrafficTypeDiagnostic: BLAPR10MB4820:
X-Microsoft-Antispam-PRVS: <BLAPR10MB48200C565E1290A934F2AE1FE5E79@BLAPR10MB4820.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7amejw0nMR1zr1hBbjckWW6y9vWVpOY7LGQVjTa2ds/Ocp6RwbtVE3oEggMlhl1y0GEM0vs0iimpZN2z4HXe3CDTwGbW3ea0mLsUEd7KHUQiwPop0ljturmmU+HjX95YeSQHuKmHxkkgSsJS7mMEEWpzYgBj0pB8TCBRoF0FxeYpiGrvHhjQ8ld2kI6CHyezCXy2SpOC68aM7L9zgmFzJZUIcGt0DcaeXWM1VONydEg4nFoh/jKOgX6SZgeWkNnHbUaGrQhAhntMsJmb/3BHB5haigFJQJJIUBi5tVxYa2WuhylsKoI1+MTCmD9djBdCFRa/M/xVo/lfBGV6cDA2j4nX1cidqZnFVUqu4ikLv2XDxKAB5YCM2l7tlDiRoFuQepS+mjeV/TPkfxHvIaD2sFKzHCwECyNub5eV7DmWzfOVr/f4DSW0+0a2LFKTH26jxJdPFtSgKP2ahCYVS+X6B0t83eBc/ah7z/sAEZTYr79L2FIe6Slljpx70hgndpUtG8YU0lDhDfpN96hO+17MwG1vHcEBqeAoUUonGHzxBFY2ZpJ9WSCfUu/v6oO0rZg+nbaih+0dXPb9zDjMer42yfLVmH30srcZ7NxVRiF9HoKLaizKtmqcd1nAIC1hHy/nvMRf+vqzJr0/zloBHi0s42BJnlLG3AuNFbhBnqItaBmi1KkP2kmWPCeWe1bmX2ygROAEm2q2JmQBaaYfiiWAKOZiWLMVwwsKHYkwPuXTOXzXdfzsM391PrAYwbDI4KoRivmGSR42Pxh4MWUkvrQFSF1f+8VoleOKPD3KN3NjGtoyclnWasZPRK2e0hsV24v/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(136003)(376002)(346002)(31686004)(7416002)(8936002)(6486002)(6666004)(83380400001)(36756003)(8676002)(16576012)(316002)(86362001)(66556008)(66946007)(66476007)(478600001)(31696002)(44832011)(4326008)(53546011)(2906002)(5660300002)(2616005)(956004)(186003)(26005)(38100700002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzVnN1dqb2VvTXl0bXVmOGFNUTVZWXlqRURDeEdNb0RzdStkRFhJbTN3NHAw?=
 =?utf-8?B?blBMbEoyanBId1RUcnY1Wi9Uem5LOVFFOUhBRXAvK3ZmUGpmUXYvb20yYXBQ?=
 =?utf-8?B?TlQ1RFNGSUJiZEdVMnZlMkc1QUNDd0xWdmlBdFZTTGV5VTBLYkNheHByOC83?=
 =?utf-8?B?dWsxSktzeHdQcVZiRXBtQ3FqR2JRSnF5ZWp3aVlCN3RHc1B0Tm16R3BkTXdH?=
 =?utf-8?B?Sk91TE9sQlFmcGZ3SWlqZ25sbWFmUFJuVUU4STBEbFZnbEJ2cGp2bWtXdElo?=
 =?utf-8?B?RGgvMDd2a0F2eUZ3RUxINUh3bnlpdzdWczdRMUFqQUI1ZWdtVlVwSVAyZ09E?=
 =?utf-8?B?bHRwbjNoZU5FM3UyL1phNitlU2dUdlliL0xoNFlWd3VzVDNDdlV6aFRqRTA4?=
 =?utf-8?B?RUx2TkpvWHhTellxd1JhbFlaeGd1UmZwdTN1WWhzY0s0TEFIR1BsZU16RC9N?=
 =?utf-8?B?VFFpQ0psSU0xUEF4czNNc2JGSzlFWkZsTHRxSUZtVEdXNHBZZWw1QmZFWjdM?=
 =?utf-8?B?S1hYbHFtUTZrZlhrMm1zWWdEakFaUjRQN05QdnhUQlFQb2h4Qi9MMjJaclRV?=
 =?utf-8?B?OGdURkN1Q3I0ZmQ3MUkrN091Rmt2UndXWFdYMTdRb05nOG1QeWFPcXpoMXUr?=
 =?utf-8?B?eFhIUmxMOUFORTI2MGVKRmJyN3NTTkF0NXdkZm9iUHBKRTJUM3R6aVBTaEJE?=
 =?utf-8?B?WjNKaE8zcHB4TzBBdUI4ejJDSklvS1hQSHkwNFZmT1l0YkltaUh6SEJmMVRl?=
 =?utf-8?B?MzA2OVl6bklHM2llamRoNm9FbjFQVklSOXZlM0Y2aWVPVkw4dG9tS2pqdmJk?=
 =?utf-8?B?RE1VUUFScnp5ZkkvU2tBQVk1YU16TnkwMDhvNzhVc3JqOGh2UHB4MTlJUGY1?=
 =?utf-8?B?bVpBU2hWWUVwRGVYWXpXeTBZbm8weUNpbTJvd2VsYm90aG9BNFIxTWV2Ulhr?=
 =?utf-8?B?dTNOT1EvZkcweGxzNmEva0Y5ZzJRWEJMdVN0RnljMWxINGd6THdIUnYyQ3lZ?=
 =?utf-8?B?ZVdUSXQ4YTRLWk5JS3k2OW1na2hlUGhOSDB5SEN5dHlIZ3JQRllnK2NEQ0t6?=
 =?utf-8?B?b1ViVUNsMWxIRWFvWGtOMmtXVnN0b2c1RlY0bW52M1VXVFdyeW5MamNBWkdF?=
 =?utf-8?B?THRCTTI1RzRIaDZOQUVQcFBQWmgxMTBieTNucHFnOTNvSDVrNGE4bDlFNUhE?=
 =?utf-8?B?Yy9Pc2hVNCtCMHlkUTdvdTkxd2ZHaHBVU0FZMUdvUUNpbjF0UEQvUG84bkhy?=
 =?utf-8?B?UFRCelg5TDkrdFp6Tyt1dEYrRXNncGtEb2x0d3B1WFZqODZqL2pERkhDZmFC?=
 =?utf-8?B?ZWFpVXJYcUluVGhoakNCTStaUlA4aEpzQ3dlWFIvWTlQblRGSldNNWdDSERU?=
 =?utf-8?B?am9TWHZDMmxxRGVVY3h5OVhvUlI5YkplWnZhMGxGa3E3blVaT2NjUm94clp3?=
 =?utf-8?B?b2ZjWWRxTEd2d1FvOVhYOGk0RzlyZU9RVUt5dkJqVFVSMlVidHAyS3ZyNzJj?=
 =?utf-8?B?NEllbHNDL25rMGYwNnMxTVExaXdKN0dXa1Vsa0hQdGJkRCt4Si82dXcwS0tX?=
 =?utf-8?B?b0VQQ1JDMi8xblNyOGNGNklZQWd2RDNBZ3g3SW11UUNVb0I2d1V5MmNvT0Ns?=
 =?utf-8?B?SWJxemY2MEZGQmtNRGg4bmtycnl3SXhNVFViYzU5QnQwemlXTXJ2REUwZU9v?=
 =?utf-8?B?SE42Y1hKLzZMcHhkMWNQK2s0aCtDOXFZYTdZWURIbXNVOXZhUjZCanVUb1Vt?=
 =?utf-8?Q?i5YgAnCgyjQKNXh/Kk1GETzakZkvDEyfLOha01m?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ccc470c-e13f-4773-9091-08d94f7305b9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2021 13:49:28.7059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sc3Wr+hwnqHbofC/Y7ufoSJZ5Sp88m+6NwybLx6J6lmLsoHVcnJTaaOQdKQgp/3/mEQzLgll7DOYRApuHcjMPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4820
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10055 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107250099
X-Proofpoint-GUID: CgwrumhTt-E6OMXFV83qloy1BwdU6L3h
X-Proofpoint-ORIG-GUID: CgwrumhTt-E6OMXFV83qloy1BwdU6L3h
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22/07/2021 01:59, David Sterba wrote:
> On Thu, Jul 15, 2021 at 06:34:03PM +0800, Desmond Cheong Zhi Xi wrote:
>> Syzbot reports a warning in close_fs_devices that happens because
>> fs_devices->rw_devices is not 0 after calling btrfs_close_one_device
>> on each device.
>>
>> This happens when a writeable device is removed in
>> __btrfs_free_extra_devids, but the rw device count is not decremented
>> accordingly. So when close_fs_devices is called, the removed device is
>> still counted and we get an off by 1 error.
>>
>> Here is one call trace that was observed:
>>    btrfs_mount_root():
>>      btrfs_scan_one_device():
>>        device_list_add();   <---------------- device added
>>      btrfs_open_devices():
>>        open_fs_devices():
>>          btrfs_open_one_device();   <-------- rw device count ++
>>      btrfs_fill_super():
>>        open_ctree():
>>          btrfs_free_extra_devids():
>> 	  __btrfs_free_extra_devids();  <--- device removed
>> 	  fail_tree_roots:
>> 	    btrfs_close_devices():
>> 	      close_fs_devices();   <------- rw device count off by 1
>>
>> Fixes: cf89af146b7e ("btrfs: dev-replace: fail mount if we don't have replace item with target device")
> 
> What this patch did in the last hunk was the rw_devices decrement, but
> conditional:
> 
> @@ -1080,9 +1071,6 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
>                  if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
>                          list_del_init(&device->dev_alloc_list);
>                          clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);



> -                       if (!test_bit(BTRFS_DEV_STATE_REPLACE_TGT,
> -                                     &device->dev_state))

This condition was wrong.
The 1st roll of this patch which is here [1], has the details of why. As 
shown below -

[1]
https://patchwork.kernel.org/project/linux-btrfs/patch/b3a0a629df98bd044a1fd5c4964f381ff6e7aa05.1600777827.git.anand.jain@oracle.com/#23640775

----
rw_devices is incremented in btrfs_open_one_device() for all write-able
devices except for devid == BTRFS_DEV_REPLACE_DEVID.
But while we clean up the extra devices in __btrfs_free_extra_devids()
we used the BTRFS_DEV_STATE_REPLACE_TGT flag isn't set because
there isn't the replace-item. So rw_devices went below zero.
----


> -                               fs_devices->rw_devices--;
>                  }
>                  list_del_init(&device->dev_list);
>                  fs_devices->num_devices--;
> ---
> 
> 
>> @@ -1078,6 +1078,7 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
>>   		if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
>>   			list_del_init(&device->dev_alloc_list);
>>   			clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
>> +			fs_devices->rw_devices--;
>>   		}
>>   		list_del_init(&device->dev_list);
>>   		fs_devices->num_devices--;
> 
> So should it be reinstated in the original form?

No. The reason is the same as above.
Only the rw_devices decrement line has to be restored.

> The rest of
> cf89af146b7e handles unexpected device replace item during mount.

> Adding the decrement is correct, but right now I'm not sure about the
> corner case when teh devcie has the BTRFS_DEV_STATE_REPLACE_TGT bit set.

BTRFS_DEV_STATE_REPLACE_TGT is set (on BTRFS_DEV_REPLACE_DEVID) for two 
reasons when we call replace through ioctl or during mount upon finding 
a replace-device item.

> The state machine of the device bits and counters is not trivial so
> fixing it one way or the other could lead to further syzbot reports if
> we don't understand the issue.

I agree. Also, a good idea to convert this sysbot test into an xfstests 
case.

Thanks, Anand
