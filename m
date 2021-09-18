Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B788F41025C
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Sep 2021 02:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbhIRAMI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 20:12:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64138 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234959AbhIRAMH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 20:12:07 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18HLxKCO025247;
        Sat, 18 Sep 2021 00:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=imWhGkQDi5aZndz8DkrdnC9Dyj4dJyc7c+/8XTVnvyI=;
 b=Vn0lNEcqALHyYWBJ7KcRtnAnEhRFzmamVWRZY929vUVyAdIK7+KMFX7CqoCS3Lg2XpZF
 iafGC3EryvlpAgjFzIOIXt55nHDFMnatHH+IW6HeXyhFb3GAprCynD527AbvXiHOTEJ3
 aSR9FuFXX9nqGU/txpH6K1uLcdh+JRDYxGeV+LZ8p9J2X/WtfdNMvyDTORNmA3i7wovY
 pPo97AbeiAdpq4LTOf49cV6rNtIThysPTRl9Jm6xh6Faulm8vQO/4/Jan8DVo31wc+Gc
 qCNxr3zI6OLBuOsmjn5k/f+Rqc3hxdVBN/D9iK4diOINrCf9PnVobfMWS/tKSij3bSqt 0g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=imWhGkQDi5aZndz8DkrdnC9Dyj4dJyc7c+/8XTVnvyI=;
 b=kSv6E0q8UjQyRwkjkQ2DzsjdTHq/c4BQZ5xkz8D1x8fbMSBOQoGLoH0XP4uQtNkB7y6r
 weWNSVOpOuUU+wBBInKe2grWp2mxTx2TWzSQXMw/Tz53JfjjaqrweRCIdKOodqoFSfA+
 YeSlPZbveeO5wzwQ5NoNd4XQvlqVe2q6gAWUqFbU5JIcZqkYOi7Q1msUFlMd3+fohyBv
 pYvyV7s7sK7ZIZfOugO9vWA5Gp1BfNjZh67FxJWqzzW5VyfD7gv2zNSWVkc0LJWE59Vv
 z8hRPmLQKLK/z8+j86pKILGe7u0VqZKmCA4/hSAZlVYmVBgO/r2MPQTd3Jj+3rRU42rE Yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b4px8ayv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Sep 2021 00:10:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18I05KBW005138;
        Sat, 18 Sep 2021 00:10:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3030.oracle.com with ESMTP id 3b557t87hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Sep 2021 00:10:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auR/gxyyADh6uMMMiuWAVQxqt3mzVbQaiqZoHIfLU+WNZQ0HrYsGet1iTWO0Q+mKopePgUdAjcg58Pg5tSKYhSDRmov8ZDn2xpXT7XiD8QnWtUkHJ4riNMXRvHLjMMqneOpKzdnBi8vHCqDafpk987bC3DaePfNdHesnNy7W7wOA0sEKsHUU6wzsCcRoqn9yYxdhZKqsJJy3MzbR2W3oWbVyW76qc9WTFJfdCX22dsP2QHOJO85YzxLT7gaEgiHhGpLJeas6xoew0mSmBm5+aQwV9PxBZoQg2l2me9Dt1yzDKLUOVSCxgtW1FKwy6bXzr5GxGLKvKLlxYYolDC8AFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=imWhGkQDi5aZndz8DkrdnC9Dyj4dJyc7c+/8XTVnvyI=;
 b=msWqvQETNlaVm7FEfejrqkk318IWEvykZZNWFUMepIIShY3Z4vKsK/rJ95fq1MvMjoKOsCd56ut1ev20cyex4Bz0inoWk7ob0n6sWJpahiqIbJJHWdWFn4+prAM2giieb3Ri9MXiKi87aP6lowH6VuQgjzzj+uP1vzI19I5UeuiJ5F1o8uaR/i6rVnwp481RuB+d2e9N9SC0C6MKKyMH0Gz6Gae5GZCjeXna4qCch3CFRexwAINQ0DQsvx2EtjK10bRb6DCBxRzs8OY9VMK9dDtWjxVMDs2iocg7wCyoTUONHEML80JwTyioYfXB2mowMHHdLL5xCuV9V6y/BFSq8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imWhGkQDi5aZndz8DkrdnC9Dyj4dJyc7c+/8XTVnvyI=;
 b=hX9NWllfi1VOZponJMafuo2GZyhZxZ9PvvT6t/05vkhPuKCYqgSUC4sP3kCbnVTHjCbqfoA9aKBOcmaHlFvVVswHg93b+1ytgg5qpSzxdT+lV5kGKzYg/QjES8dvrbNo6DWU48pGjm/xsmy47OhozmoqXCO0IC7WmbGW9TQpO0Y=
Authentication-Results: damenly.su; dkim=none (message not signed)
 header.d=none;damenly.su; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4127.namprd10.prod.outlook.com (2603:10b6:208:1d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Sat, 18 Sep
 2021 00:10:29 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4500.018; Sat, 18 Sep 2021
 00:10:28 +0000
Subject: Re: [PATCH RFC V5 2/2] btrfs: consolidate device_list_mutex in
 prepare_sprout to its parent
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        l@damenly.su
References: <cover.1630370459.git.anand.jain@oracle.com>
 <f00bad4ba0e8fd7f0c46c21118537fd49fd3c359.1630370459.git.anand.jain@oracle.com>
 <20210917153720.GW9286@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <6e62c59b-91f1-c090-931f-96434fd08ac4@oracle.com>
Date:   Sat, 18 Sep 2021 08:10:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210917153720.GW9286@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0093.apcprd06.prod.outlook.com
 (2603:1096:3:14::19) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.81.145] (203.116.164.13) by SG2PR06CA0093.apcprd06.prod.outlook.com (2603:1096:3:14::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Sat, 18 Sep 2021 00:10:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c61cd86-7e88-4fed-93da-08d97a38b8d6
X-MS-TrafficTypeDiagnostic: MN2PR10MB4127:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4127D4040C0E0FA56E81001CE5DE9@MN2PR10MB4127.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1nTA+cfIYqIU2IWu0sc61yKtubHc2lrzGh+dbwKVPJzmGPLBW79xJ9XGDkTq+4V1rKFuAWDjcQBL1Z7KeJvytMqFv934IW15BYJzsJhxvWRKA8Gu2cKOeN1Yev02ZEZbGBdewnBbLe2DarS681IgZ302Z180PUNFbX8UrlyMjC1vUSJBoloNfwVtoqxLqZ5w0Ao683YQ/HdgGIhXoN+84qIYLjnis6bHKnFdP96U+CFNtgiG7JhjhXPRWPFe68EiuYeQrWUxCiYbrq2S0GIa7X/3MTuH9DzMF+cdIFNnqzgWI3nVrrBlzEJwSXfziG2x5qH+vySgHxd1VNLJYRZ3YSSb0pnaJbNSnpubehWOUMjwv5nSc4RvQuhwUxPVpbCFzTgg1QwUX1E+Ae82t+cOFQQi++i/2Mj5pEY1qfVWrQO+3i8VVZnBSdtLFwsg+g18qk/PxyP2Y/L2MFzfWfNpLJ2zgZ+FvDpgseEzzpuh3U0YHJg/VUfD/qcqyhqWFXXczXAeGbkB/3jXSsrPzOy7wTOZ/8t+M2j210iLy9gdssr1bgiI57Z6Ih+80/aX9gwUIbVaQ7UBUk7HkYvWOGEPjPRmGBcPKdSmhpermUm9Pa4AkBLHC+wm9Yqp9SC/p0apFYZ5kjsk0oXxMGFKH0BnYOxniQWyABQ8mbqY+ouCSFbBhuJ7y8bs7rRyWxyld1OdNbP0vNr0uauBdaZZuINvRdbqQSDkygTIBEp/ZXWt2Hc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(8936002)(5660300002)(186003)(53546011)(8676002)(66556008)(6666004)(16576012)(31696002)(26005)(316002)(508600001)(86362001)(36756003)(2906002)(31686004)(44832011)(83380400001)(6486002)(66476007)(956004)(38100700002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlFsamhMOXVmcFNMR3ZZOFJVNUZTT0xkaDdYeVNsQWxEWXREQXI2SlQxWFVH?=
 =?utf-8?B?SHJVRHk1RlNzb0ZRTTdkVGNsTWcza2laMFFlazJJcWZMQkl4UnlmZ3RKWXRn?=
 =?utf-8?B?UWFZbTMrMk9tMjlJYnBiL2JpQjRwRmpSam90SGJEYThRNDhja1BIYnI1Vkdh?=
 =?utf-8?B?d2tDdlNmeWpvRkZHenJKN0pwWm9Lb1hMSkNkNHlqUkVFY0VOQjdUMWQzR3ZY?=
 =?utf-8?B?Z29XbU5iWFVFZWtZRmZsOTRSam51NWRESCtrZjFYWHA0c1R2VWR2TkE0aUdS?=
 =?utf-8?B?dVUrSEJISDYxYVVwTERDalBleC9lVXkyNVVXZk1hVGhuK2hnQmtoOHF6N09Y?=
 =?utf-8?B?U2NiN0dhMEpCTTFKVWhMckJ2QzcyMlU1TWIrOUNnUjdmbkhXditlMGY4SThL?=
 =?utf-8?B?UEFWbU51eG5Mb1AzQ1J3NHlwd1o1RmdjMVBTNUMxcEYya2tUOWdETEZpa0Z6?=
 =?utf-8?B?WGM1TFJoOWc5OHJWcUgyVkdwekpRSDczR3pUQ2UrcWU0a0lBNWRYOVR0UWJl?=
 =?utf-8?B?OG5YQmxvdkFQKytsRWVJbVZVMWdiQ25OK201ekNvandjMEMrdWlyUFh4ZGly?=
 =?utf-8?B?a1BHdTVZRTh4eVEvUGxOWkZyMGV5cnRKdFVGMGM1ZVlQbXJZL0ZmV25KLzd3?=
 =?utf-8?B?NFZKa2o3dXhEUTFxSVJrWXFOL3A4dFNDUit0S3BZTmVZS0Nua3VtMTlncFlB?=
 =?utf-8?B?YW1HcnBpckNqM2xsY1JaSCt5bEV2eGRyRURFYjZULzVlaHlrdXBtb0ZrOUQ2?=
 =?utf-8?B?eEpJanNDQXY0NlBkUFQ3aTQ1K1dPaE55QkYwZm9BczNXYnRlQ2xDTVYzUjZ0?=
 =?utf-8?B?NkVxdjRPMm1lMURzTDdPTDM1YlRBdkdqanNoVFViQktjR2NyUGl3M2hOYk5x?=
 =?utf-8?B?ZG9xQkkwSVNYK1Niai9udE5lckRyRDRVODR4aGJxKzJvRnNxU1VlbUhqemYv?=
 =?utf-8?B?MFFHSndLTlZMazJmNFJGVHczYytzNjZRQ2hSamhiRzVCZHdrWmxRNkhWNTR4?=
 =?utf-8?B?a1lGWHgwdjNzSERhbTVSdkd1QVNLQW5kUDEzaGp2eVdGU0UxVjJrNjVjTFox?=
 =?utf-8?B?MmhWV092b3JLd1JwVStZZmwycmpMdlNhU1Nub1hKZGo0Rnk1b0NjaHJUYjNq?=
 =?utf-8?B?eEVpd0l2MXFPcTVKWkhBRkVjRHh0VUZwbzYwbmJWNm9jN2U1Qi9HSWtJbXQy?=
 =?utf-8?B?K1VmMTA4VzRmWTZYZWhZb0hqMmFIN2oyTHpSTVBuM3I2UXdvNGhYb3dJWVk1?=
 =?utf-8?B?a1ptSjN3cjUrTHhpbHZqaTdBaTBlbHNSQXd6dVpFellVb0hldVFwRjlseGhW?=
 =?utf-8?B?blVTYW91b0JwY2lKK2t5NVd5TFNveGV0TGRmUW1LOTRqQWNOeDhGNkJTWkdX?=
 =?utf-8?B?MjZwb3o0bW1ONlhFRUlNTUtzODhock5LR1kzR0Z2Q1JUMVliWEhreVJOOEs3?=
 =?utf-8?B?RHF3R0YwMGxjQm5YdFhLTHgrZm9WVjJTcHZRWEhLNnZFbUtUWWtIMFBHK05Z?=
 =?utf-8?B?aFQ5Z2hHUHh4WnEwbVB3bzVnNFRXa0ZzR2JQSVFXNHFORzNqRThhWU9wdElQ?=
 =?utf-8?B?VzBuQUh2TDh0WjBINnJmbjhUN3o3bnBtSjVBWlRsWTQyYjJyZWtPZ3hVMzRv?=
 =?utf-8?B?dDhGT1h0emFDazJYWWxZekdjM1hyWGlDUmpnNzJTTUNselQzUDRLZlg2aVJW?=
 =?utf-8?B?L29TVmFvQXJwUnpRWXVzN1NJSEJGdnlrSklUT3lVa0JuMmlLWXpmRGk3aXUr?=
 =?utf-8?Q?eanRcnE6np77jebPJELVY8DBwsSOYHHBnVHkkXX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c61cd86-7e88-4fed-93da-08d97a38b8d6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2021 00:10:28.8429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/mdGQH0GAaI5x1Dq0kjAQ+hooJPHKP4o2BkPCWCgvMxTwxhAQqc+RkUkKYOvy4CAUsnfpz4p3oDSKfkYbrSrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4127
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10110 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109170145
X-Proofpoint-GUID: WBiiMpymjZ3SyFyKR5Tn3-1Xizp0Y8t9
X-Proofpoint-ORIG-GUID: WBiiMpymjZ3SyFyKR5Tn3-1Xizp0Y8t9
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17/09/2021 23:37, David Sterba wrote:
> On Tue, Aug 31, 2021 at 09:21:29AM +0800, Anand Jain wrote:
>> btrfs_prepare_sprout() moves seed devices into its own struct fs_devices,
>> so that its parent function btrfs_init_new_device() can add the new sprout
>> device to fs_info->fs_devices.
>>
>> Both btrfs_prepare_sprout() and btrfs_init_new_device() needs
>> device_list_mutex. But they are holding it sequentially, thus creates a
>> small window to an opportunity to race. Close this opportunity and hold
>> device_list_mutex common to both btrfs_init_new_device() and
>> btrfs_prepare_sprout().
> 
> I don't se what exactly would go wrong with the separate device list
> locking, but I see at least one potential problem with the new code.
> 
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> RFC because IMO the cleanup of device_list_mutex makes sense even though
>> there isn't another thread that could race potentially race as of now.
>>
>> Depends on
>>   [PATCH v2] btrfs: fix lockdep warning while mounting sprout fs
>> which removed the device_list_mutex from clone_fs_devices() otherwise
>> this patch will cause a double mutex error.
>>
>> v2: fix the missing mutex_unlock in the error return
>> v3: -
>> v4: -
>> v5: - (Except for the change in below SO comments)
>>
>>   fs/btrfs/volumes.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index fa9fe47b5b68..53ead67b625c 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -2369,6 +2369,8 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>>   	u64 super_flags;
>>   
>>   	lockdep_assert_held(&uuid_mutex);
>> +	lockdep_assert_held(&fs_devices->device_list_mutex);
>> +
>>   	if (!fs_devices->seeding)
>>   		return -EINVAL;
>>   
>> @@ -2400,7 +2402,6 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>>   	INIT_LIST_HEAD(&seed_devices->alloc_list);


>>   	mutex_init(&seed_devices->device_list_mutex);

  BTW mutex_init here will go, as the sprout's private
  fs_devices::device_list_mutex is unused. It is a pending cleanup.

> A few lines before this one there's alloc_fs_devices and
> clone_fs_devices, both allocating memory. This would happen under a big
> lock as device_list_mutex also protects superblock write. This is a
> pattern to avoid.

  Oh. That's right. Thx. One way is to flag NOFS alloc.

> A rough idea would be to split btrfs_prepare_sprout into parts where the
> allocations are not done under the lock and the locked part. It could be
> partially inlined to btrfs_init_new_device.

  I think you mean something like this...

  btrfs_init_new_device()
  <snip>
    if seeding_dev
       alloc_prepare_sprout
    mutex_lock(&fs_devices->device_list_mutex);
    if seeding_dev
       finish_prepare_sprout
    <snip>
    mutex_unlock(&fs_devices->device_list_mutex);

  I am trying.

Thanks, Anand

>>   
>> -	mutex_lock(&fs_devices->device_list_mutex);
>>   	list_splice_init_rcu(&fs_devices->devices, &seed_devices->devices,
>>   			      synchronize_rcu);
>>   	list_for_each_entry(device, &seed_devices->devices, dev_list)
>> @@ -2416,7 +2417,6 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>>   	generate_random_uuid(fs_devices->fsid);
>>   	memcpy(fs_devices->metadata_uuid, fs_devices->fsid, BTRFS_FSID_SIZE);
>>   	memcpy(disk_super->fsid, fs_devices->fsid, BTRFS_FSID_SIZE);
>> -	mutex_unlock(&fs_devices->device_list_mutex);
>>   
>>   	super_flags = btrfs_super_flags(disk_super) &
>>   		      ~BTRFS_SUPER_FLAG_SEEDING;
>> @@ -2591,10 +2591,12 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>   	device->dev_stats_valid = 1;
>>   	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
>>   
>> +	mutex_lock(&fs_devices->device_list_mutex);
>>   	if (seeding_dev) {
>>   		btrfs_clear_sb_rdonly(sb);
>>   		ret = btrfs_prepare_sprout(fs_info);
>>   		if (ret) {
>> +			mutex_unlock(&fs_devices->device_list_mutex);
>>   			btrfs_abort_transaction(trans, ret);
>>   			goto error_trans;
>>   		}
>> @@ -2604,7 +2606,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>>   
>>   	device->fs_devices = fs_devices;
>>   
>> -	mutex_lock(&fs_devices->device_list_mutex);
>>   	mutex_lock(&fs_info->chunk_mutex);
>>   	list_add_rcu(&device->dev_list, &fs_devices->devices);
>>   	list_add(&device->dev_alloc_list, &fs_devices->alloc_list);
>> -- 
>> 2.31.1
