Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4591E44BD71
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 09:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhKJI7n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 03:59:43 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36150 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229781AbhKJI7m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 03:59:42 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AA8WD4f028365;
        Wed, 10 Nov 2021 08:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=A6vBu22qHOYLHz3CttlxWMf3hDgR+/N+LDoI97bTEN4=;
 b=gzauFP0mZCvTxNKVQolkG3VtTvFtL5NI8QUDG1QIU1snucD4waoi9XSioG8Myg+8CwG+
 txIyjUwCdVUBonpwCMyildsWw2KMpYQGb5WHM0+GvE20T7uJSBfM1Tf9/bVO58lAoZtB
 gJ+OHucZ+wCFQt5ZNHbxrM9kT5C2PC11XSCfyAQ62hmmJzW7iUt+s7Q20Rj1knrjmXQW
 AZa/nRUTNYGkXooppENs/wGKb6E/rpeetRgIzI15wJwIzzCgwjcguke8IoG2+WqR3YoU
 JDYjVuq0aNYtMMP73bQAz/xQ6MAuYkXQ3jU0A1QR6OteEG6VVeK5PozzgPwQcXzI51/8 kQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c85ns9g93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 08:56:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AA8q464106849;
        Wed, 10 Nov 2021 08:56:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by aserp3030.oracle.com with ESMTP id 3c5frfa477-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 08:56:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTc2EPOEs5tDEfRE7+f4vshXbXmkElGsaFtU1sxX4NXK/O3Jgtqet7RgPx8tHXmoa+lmbQelSEvcvdJXLE1DqptvUkyppulN9kesFyzC+xBJLNoTZxXk+FPQdTmkKH01KeFFYFWrB8E+PrjivDMW6NSMZi5dRZfs4ueDIxluCeIUPkP31xVXU7FUol7QASU+PFIlxT9U2Wq8swrGgEHL2kvZrULFVPA6GEKOamqcn0Dbi8LVRccbYwCvWsjif+8esUQ4/DdDxliq1MRCAfJ5jDgxAoAJrLq8RTcUZlj50ZQ4augvonEjuyJG2thYxt8Xz6sam+VcSGIE/PiSR4kuCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6vBu22qHOYLHz3CttlxWMf3hDgR+/N+LDoI97bTEN4=;
 b=nqQhJu11YfXpm/OXcEw6w+idd5qz3xz/afaP6y1uI+mwuPkW3/62jHAAuE85kKeusoHkdqmwemRe4BmwtLtITbE9LcmJV85xvRZVf2U1BSgMfzFm82Y8qOgRUrJDvRsjFigCMJBBCybhbIeZBN3iQT7XGp2b3gGDTjVWSTiZM2U4dnDWO+Sv8TFWbep8lEBbbbyLJgBFKVLHi5UcN/2ZC1NP5fAHXYppB0sNr0/0oXl9w07wwKqiQo9hIbOGQHGFR0XJeWPotiXS9LmbIj61gg3nGp3WNQkyfjyUJwqGzZLCUk9Pra4UOFJOhAkWthOAaxw6hKx8kl9GjlkWSzWgQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6vBu22qHOYLHz3CttlxWMf3hDgR+/N+LDoI97bTEN4=;
 b=bW/UpzGdrFmh4lQLxvKsKONT9IQCKGOMiMZ3p4K5vcYVZn8mOGAuRSi2yMj+dk2IBC3rC+fXCy2qduoSwiEk+Eu1ItO0DAYMp7+tWrq/XnJHC79OXI5ic/gTaWGCfSzzo5bchkxHFhRrrhJvnbQFAjntrvie4/XrkdSicU+jYDo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3982.namprd10.prod.outlook.com (2603:10b6:208:1bc::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Wed, 10 Nov
 2021 08:56:49 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038%5]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 08:56:49 +0000
Subject: Re: [PATCH v2 1/3] btrfs: introduce BTRFS_EXCLOP_BALANCE_PAUSED
 exclusive state
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20211108142820.1003187-1-nborisov@suse.com>
 <20211108142820.1003187-2-nborisov@suse.com>
 <ec5447a6-b9bc-17ac-11a7-4fc14e1c6a82@oracle.com>
 <e6b4d90e-5e5a-37be-24a8-f493451a889b@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <6b09a082-fe67-a6da-7322-1822425e14c0@oracle.com>
Date:   Wed, 10 Nov 2021 16:56:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <e6b4d90e-5e5a-37be-24a8-f493451a889b@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.137] (39.109.140.76) by SI2PR02CA0021.apcprd02.prod.outlook.com (2603:1096:4:195::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Wed, 10 Nov 2021 08:56:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8b8af99-b52f-4aa3-2397-08d9a4280803
X-MS-TrafficTypeDiagnostic: MN2PR10MB3982:
X-Microsoft-Antispam-PRVS: <MN2PR10MB39820B789C301EA2170896EAE5939@MN2PR10MB3982.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PFVnr5/QDUMudDsIdwMEWBBCmHdlLytfqcVp5lfnXifgUcwXXjqAVFwQeNWGNxkTmUcBzeI/gAdCYogmWRG4nA2PGWGi5L1MkYypZvdGpJRKBiri4IgvzOG1VPYXwXh1Yc19MR56uvKp9SwRNRcVS2TYtQ1aldquFepizbVrrq8kjlTZabLzLr55NEXOp1x4tw8zwFXuyffdRU2JmyYXDgg8XPV4jujHSYeRJsTvU7hfeB5eUijMFmPkK+UxmiJvJyLwXW6bSKVUNZLECDLoe0Quu4zcR2M7pxDe3ZlN8c9nZS4qs4S24B9mUb+8ipSouQcTy4qz32UiHkLiN/sdLAGctO3V0wmPMa99b3XZsWE4mJS3Mo7uNbIX+Xwd/zdEQNenfEMgNZ62sgabY+5TgQBKFVhdrgL9ZuTNDI8bTdZyldPD1DFyW9rnwAWdJN5EI2njFptY4ppI9FQfPtLJ1ckvEJ/TNgMQTjwc0rZXwVMagdCnVM6k1VuNOfuud/P+2z1kM1cJFG8whBbSrnxVuSbU+Z6kmGehjQg+Z4+2TdahCfOiB3xCO37KtHTb/1gbLPC25cdO/oy+Ha6d2Fo/dEFYtPZztvq1Kr59jSAvwMwbCdLPolLsva2zZRqsSTAX3B8DQxEhViEVIjLMA6wZHNhTqYRbfW+yOHzBjugYlLi96RHpMQTRGNzDIaiO1Ep7NSqMk+fNdDY6TaSLC+TxyJa49KxYazlro5OUbPW2vkE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(186003)(36756003)(2616005)(956004)(2906002)(508600001)(5660300002)(38100700002)(8676002)(44832011)(16576012)(6486002)(66476007)(66556008)(316002)(66946007)(83380400001)(53546011)(86362001)(6666004)(31696002)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEwrTlJYV1ZOMzdjTko5VTV6ZkF6YXR3ZVlzQkROZldGSVhxRHNXeHM3eGdy?=
 =?utf-8?B?ZUZwRWdHeFEyVktHWDlCMlBNZ0RLakpCZjVJRU1Mb3VkL0FkUnJPU1owVWxF?=
 =?utf-8?B?S0hvQW1oMG5DbmlZVWFaZG1CSXZYMEFFWFJBRFpNY0F6dEd3NFU0YVN0QmNo?=
 =?utf-8?B?eEtaSGQyVVhXRVJHMWIxMXZ4NnlSeVlUeFIzZUdJUXlhdGVzekRIeHp3bUlG?=
 =?utf-8?B?RHJaUU1zWjBVaVpacG9LdU1JNnJVL3I3b3ZTSE5jNHRlc0VOOWwvaEsvaHd2?=
 =?utf-8?B?VWxtNzQyNnAzYWc5dC9GZzJUZFNvWlNyd3Vkb3E4TTFwWkZsTFRxVnlHOERz?=
 =?utf-8?B?akJMMGFIZ2pvSmp1K1dZc1ZFbTNsYjk0aUs4SUNacHJiMEpGZ3RJQjVpOW1h?=
 =?utf-8?B?bzE2Sk5JYWdhMHE0UDUvUWNpS2ptS1F0ZzVTVjkrQS9OQ2txN3pBSllWbkoy?=
 =?utf-8?B?dkh6Z09DNllhT2xXNFYyRWJxVUFoVnFqMjdyaUNLQVpVT1Q5UEt0azJPV2dG?=
 =?utf-8?B?UDRkdEZZdE9pYndRakhJSjBQZ2tHS0d1TmFkN2VWNTdoQ3ZwendiVWtPY2JC?=
 =?utf-8?B?RGZUdHpDTHhkTkVDTW0zTnJESDZwbkRSQ3UxSm95U3ZFbWpCU2NBU1VsWmpY?=
 =?utf-8?B?bDhIN1FSbkdXQ21FWVorU093TERSMWpvS0lZN0lod3NjOWk0NHZVbmJ1a3F2?=
 =?utf-8?B?Y3ZwcFlmNE85SGt5N1MwbmQwS01LdXBKMERYTUhrU3krdCt3SWZaVE9mL1RX?=
 =?utf-8?B?MDFSUE80WXhRNlU1ZHh0WEcwMWhpSWNBLzJ0TkR1SjY4SnJkNWkwODBIR3ZB?=
 =?utf-8?B?WGM3Z2RwWjlTaVdpamtVaUpEVEtpRk5SSkdvK0xaenl3QzlWRkRONGFBTDMz?=
 =?utf-8?B?S2lWM1ZicSt5a3FMSmZpaEZPYVVLdGJ2ZTc2ZmducEQvYUZxaWkrSkEvaEl6?=
 =?utf-8?B?ZHRXL3dWNUVvMU5xUXZDb2hTN3N2OFRrMFZtVS8wcXVSMUtiUU56aDRncTVo?=
 =?utf-8?B?V1l0ZzdSa0ZheDg0aEM2WnYxU3RoS2xSZkVPbllCb25MSFl3THg4ZnlaOTc1?=
 =?utf-8?B?YXB1SEdWSG1zTklkYThjYjdmdmxraU0zYk4wd0xJNWtvY0gyNTl2RXUzd3dQ?=
 =?utf-8?B?bmtHZkJpWjI2RHdUbTJKRVBJMVdPN2pqR2pXWmtmb3RiR09TaXJIK2RhelVm?=
 =?utf-8?B?QSsrSEhiNkhFQkpqOGYweVV3bjUxbWNjeXludDVOUk54OG1JS1BIVE80ek9o?=
 =?utf-8?B?SVZtSHdpazBHQlZlNlMrdjNIdWJXL1c3ZzVaMDd3MU5nVmdiTmYrc3dGaldR?=
 =?utf-8?B?ZHVnWVlCQm5ROWhCdFpOSkMrWjlIRzBzUllxeW16RnppZkMvOTRneWdmZnVO?=
 =?utf-8?B?TWpFSmhDZ2p4eHVIUFgycGxHbFlLY214bVhYSm5LUm9JelVaem9RSGp6cytN?=
 =?utf-8?B?eUhZenppdFphQnEyb0ZLeElqajlXVm1MalRIQU42bi8zcHowZWZPRUpuUVdo?=
 =?utf-8?B?S3pnc0FhOWp3QmQ2MTZHVHRBRXAwT0J2Z210L00xaVNzbzhqb1R0bStIeSty?=
 =?utf-8?B?Tnh2ZFdvazVYUXNldnhxcWtzTU5RekhDY2llZ0szUFNDNjRsdGtlcC9MM2tn?=
 =?utf-8?B?WUg5YUVoK1hWM3VjSURuUW81OUk5a0sxK2Y5WU5jMkZ4MlhJeUhtZmNBc056?=
 =?utf-8?B?MElUNEpBMTF5cTNvQndtaVQvU0w5YVdLL3pNQWZlMWJqNVZEY3VmMEZ1akZZ?=
 =?utf-8?B?ZmhjTVV1T3h6Zy9RV1U2d256aUEzQm5tU1czckJwaUVrOEgyU1BtNWNFVTRT?=
 =?utf-8?B?czEzNmcvMnNMeVFYWUpqQVdYNGtVZUFYZEttQzNhcU13WGZTZnVVcmJLSTVi?=
 =?utf-8?B?U1NEVDhjUk4veVpPNkw1VlVCTnFkQzJsVWhBSk04cFh2dktHT1gyMWFzNFhq?=
 =?utf-8?B?UFQ2K0owSlplK0RBQjZSQzA4dVRlcUJSdldXamNma3l3bXNsRWRRWEl0cHBU?=
 =?utf-8?B?NDBTWTluZE1xT1pNMEh2NEpYdTd4elhUcnQ0bkQ0WGhCK0x6V1I0cmhYYTQ3?=
 =?utf-8?B?aWJrNWQvUXFCN0dld01keHQ4aVlrNnZjZmJHQWFEL3k4a2RqaTgzdklpc2Yv?=
 =?utf-8?B?QVZDYndNNWhPTXhKUHUzYWkraXNKY200KzNXMVM2TFJ6ZEc5RUhTZWJXdjNv?=
 =?utf-8?Q?C02UbPCibMx+QCAGj0De3+M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b8af99-b52f-4aa3-2397-08d9a4280803
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 08:56:49.0931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1BUkdNw1b2OiCiSbCIpKelVFv1Mlsc7uJkt5kMAwWcWejVlaCnVTmAJKWZ2DJr2zCA96tumnYdjKG1EQ9kOJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3982
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10163 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111100048
X-Proofpoint-GUID: rafvrmsg5VoV3siJhyNHbDElXFoNhdZ_
X-Proofpoint-ORIG-GUID: rafvrmsg5VoV3siJhyNHbDElXFoNhdZ_
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9/11/21 11:33 pm, Nikolay Borisov wrote:
> <snip>
> 
>>
>>> +void btrfs_exclop_pause_balance(struct btrfs_fs_info *fs_info)
>>> +{
>>> +    spin_lock(&fs_info->super_lock);
>>> +    ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE ||
>>> +           fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD);
>>> +    fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE_PAUSED;
>>> +    spin_unlock(&fs_info->super_lock);
>>> +}
>>> +
>>
>> This function can be more generic and replace its open coded version
>> in a few places.
>>
>>   btrfs_exclop_balance(fs_info, exclop)
>>   {
>> ::
>>      switch(exclop)
>>      {
>>          case BTRFS_EXCLOP_BALANCE_PAUSED:
>>                ASSERT(fs_info->exclusive_operation ==
>>                  BTRFS_EXCLOP_BALANCE ||
>>                           fs_info->exclusive_operation ==
>>                  BTRFS_EXCLOP_DEV_ADD);
>>              break;
>>          case BTRFS_EXCLOP_BALANCE:
>>              ASSERT(fs_info->exclusive_operation ==
>>                  BTRFS_EXCLOP_BALANCE_PAUSED);
>>              break;
>>      }
>> ::
>>   }
>>
>>
>>>    static int btrfs_ioctl_getversion(struct file *file, int __user *arg)
>>>    {
>>>        struct inode *inode = file_inode(file);
>>> @@ -4020,6 +4029,10 @@ static long btrfs_ioctl_balance(struct file
>>> *file, void __user *arg)
>>>                if (fs_info->balance_ctl &&
>>>                    !test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags)) {
>>
>>
>>>                    /* this is (3) */
>>> +                spin_lock(&fs_info->super_lock);
>>> +                ASSERT(fs_info->exclusive_operation ==
>>> BTRFS_EXCLOP_BALANCE_PAUSED);
>>> +                fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE;
>>
>> Here you set the status to BALANCE running. Why do we do it so early
>> without even checking if the user cmd is a resume? Like a few lines
>> below?
>>
>>      4064 if (bargs->flags & BTRFS_BALANCE_RESUME) {
>>
>> I guess it is because of the legacy balance ioctl.
>>
>>      4927 case BTRFS_IOC_BALANCE:
>>      4928 return btrfs_ioctl_balance(file, NULL);
>>
>> Could you confirm?
> 
> 
> Actually no, I thought that just because we are in (3) (based on the
> comments) the right thing would be done. However, that's clearly not the
> case...
> 
> I wonder whether putting the code under the & BALANCE_RESUME branch is
> sufficient because as you pointed out the v1 ioctl doesn't handle args
> at all. If I'm reading the code correctly balance ioctl v1 can't really
> resume balance because it will always return with :
> 


>      20         if (fs_info->balance_ctl) {
> 
>      19                 ret = -EINPROGRESS;
> 
>      18                 goto out_bargs;
> 
>      17         }
> 
> OTOH if I put the code right before we call btrfs_balance then there's
> no way to distinguish we are starting from paused state
> 
> <snip>

Yeah looks like the legacy code did not resume the balance, it supported
the pause though or may be the trick was to remount to resume the
balance?

As this part of the code is very confusing I think it is better to split
the balance v1 and v2 codes into separate functions.
