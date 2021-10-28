Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327BC43DA79
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 06:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhJ1Emg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 00:42:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:63160 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229488AbhJ1Emf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 00:42:35 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19S1r6NX027774;
        Thu, 28 Oct 2021 04:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=19c4tAdN7jrCxEgJq7w2j+c4TPD6LwO2bx8Kv1naOwM=;
 b=1N+X99cfKDs59JQ44v6RfGUE37dYOKtx/W0PXQhUcnG7juqjPvCXMzOz7kOUsdZvmFKk
 Qm21UzsAsmUwtltD2hlDJ2DQafw31meFgUY4Bdzyx63XouoevNbQ77keJlOjpSChMnfZ
 ntuXdNg9WfQHbJBvwGYBinylCd9RPlUSqwrn7N/fjRgthxzxxy4xnJaCr6gTu1EkJ2OK
 2PUj+t3yMdzEUxCpAEe2bVnwXmxNZwazCcDr009XdA0yuAD3f7IiRfEOj/MCXDbt6tHo
 VJ7/sSQzsGGPCvyKAbuX80Ds04MiZuvkjKyGt+rObKKWmBDISEGOjB2NsKKk7q01NqNH 5A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3byjkf0bpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 04:40:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19S4VIu4109258;
        Thu, 28 Oct 2021 04:40:05 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by aserp3030.oracle.com with ESMTP id 3bx4gaxqnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 04:40:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYuz1pixO2gTJurAR++I3BDm+2EYw8wHByUCB1r+nO1opq4niQBdr9QBint3R9E0g6GCRNj6xQ1quImwdKQn7a/4wMqxtRDAWct4q633LRxDIYuAx9OXZ2TSw1sMFqg8bef43fznHl9th6FuclsMRjhEvCWLbpVQ2OeKQ0Aecyht37sYayTG6l0DhYkGWlPux0/0WbLlD94XneCbdAY9lczodESjN0YC7TIIEVSeRnyI4rlwikQMVXnNPIqDeBNyIYhCySLjIhvVkflVYCY5yXk0TalbPXCy3sDXhHOBtPi/k9zyLiIkfG8sWo0o36SkSH+iHLMJjDdlPO5+p3XgGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19c4tAdN7jrCxEgJq7w2j+c4TPD6LwO2bx8Kv1naOwM=;
 b=MTF7p3kSAlbNGHtpBNLmlmI51Vp/Rlfju3WHp3NIJBz2hfolkVEHCmn1L4vHTmS6MaK/8PWSRlynuBFxjX0sI1Tc+WD3bqFTInQjB9rC8tf6yVcwmJMkd6q5Lru0DxJi7Gu8u2/lnmRkRCFmvDn7bwsROz0ljs2BPL1P48+/D7SwK3cy0owQqPWTmwwkI8ZcEZnkyylZvy8uLNzRKYBcrwCUAnenV+V50wPJu+okPqSBv//S2ZsJbL3Sn5n9VWxM9Rc/2n/KCfKG/xuOR2pOf9KLcb8QzbAUFjz6TPfurSQnaBeFtvLfDUusxvjbZEZ4ejGYKl7IC9nn075hDheWog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19c4tAdN7jrCxEgJq7w2j+c4TPD6LwO2bx8Kv1naOwM=;
 b=u+64GTjKa3mD0eT/SKSMrUxbrwBdScc81k16QaU55ISB+v4Z8LMF7cEOE8yXh0H7GgAn0NzaEHYs7un68NISOcBkwftj/bVcX0Nvad9fuI9kcj7nFO3cXQ1nD2PqvZxerWabRIWRoiMFvgoaXZU9qjg+FaYypX1atkTzpiDjTpQ=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3789.namprd10.prod.outlook.com (2603:10b6:208:181::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 04:40:04 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 04:40:04 +0000
Message-ID: <58acdca4-a716-7144-e75c-0810bac754b4@oracle.com>
Date:   Thu, 28 Oct 2021 12:39:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v6 1/3] btrfs: declare seeding_dev in init_new_device as
 bool
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1632179897.git.anand.jain@oracle.com>
 <d0e619aa1de4c142d5b12a41045cc60df0d1c8dc.1632179897.git.anand.jain@oracle.com>
 <6fea27d3-1eb7-4725-b894-1a742d6e5c3d@oracle.com>
In-Reply-To: <6fea27d3-1eb7-4725-b894-1a742d6e5c3d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0086.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::12) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR01CA0086.apcprd01.prod.exchangelabs.com (2603:1096:3:15::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 04:40:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df925639-f042-4a59-2384-08d999cd025d
X-MS-TrafficTypeDiagnostic: MN2PR10MB3789:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3789A0A4E3ED8467FB84789DE5869@MN2PR10MB3789.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rm8M8Az7RMvv74i270u8tXuqQnFkLX/J85/HC7fVtARN5KPXeRlP5EFU2bYY3xPdkzNXaiCW7+j3g2Gy1r/6yp/xMd81B+t4Sw4f2zEVvnUwp6l0ikKnTe9E3dQD7BcWeBSHBwOTBlUqj88cKIOLzqHwQDQVfq1usDSKb740up35tAgK4XrqRaaNM44ir7LnYPLKc6z+4pTiBn7nUzwZQwmWKPQUNPSHAdLwEBa14K7GIIF+96UgmI1M+6UVcVN4bEL2V/iavm5c5cxCvVe2XGquGZ19IMDVUXs5G8dt96kANNyEo8p9YVrXmSNF0ANFrCkU9fOrWbxVABbKIaFMflCYEaoaK0a3DNSa4SR8FD4XVCbxlDs5T1JwRe/AGVJ+XlF4bDKpr5+6oIsMuutAmIcfqihIsgJK0sAmrh4wGsJTFZky1wdT1PV68zaL3YMWFG611P8nMrps5EHZDvobfY3+ivP7JTUct7z/JxXbP+Xkvo5Et6GMWhzoi5DOqUOd0Uv/YBvO7uxBGEgH06mlVF+inmyfKHR6T9oUcjYVbBl93CTNAmpW9wdUt4jW4etURpTdzWaLSZUmAdG0SXhx1Iuaen5GhUIbX9OG2uQi9jVWKUUEM/ibXkNWMpV3TMU7FwA/ce2cuH0mBDUxWJkM4nViUK2XIr4PuM1m+Svob7knwRa0dOGmyMpQoOAl0ITwEfS7SY7b1ap27APFYHLlSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(44832011)(5660300002)(6486002)(2906002)(186003)(6916009)(8676002)(16576012)(316002)(38100700002)(83380400001)(4326008)(66476007)(66556008)(6666004)(66946007)(36756003)(31696002)(86362001)(508600001)(53546011)(31686004)(26005)(956004)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c09zQXFybU94MndreFQ3UmIwYURkeDFFbHdEUU5YVCtsMm9ZdEJ1ZHVvY1ZR?=
 =?utf-8?B?Y0xjK2UrQ1VCd2JvZllDcFJ4cVBrNDFqK0hkVXJYRDZCcDRsVWRWTnR6Q0E5?=
 =?utf-8?B?T1NmYVliUnJMcjlidFhWNUVlaHUxemVXSnJ5YXhCcStsQ3hiblNwZzVlWWRD?=
 =?utf-8?B?WTBDazF4VTBHZENVa1BGTG5YRHBETWRhNHBzWUh2TlYzMmVaaGlrRlhzdy9O?=
 =?utf-8?B?M0JiUHdGMTIxeFNUREtzaGlPMklmYm9GWnNyRTd5K3hwL3kwYUdyeEhkK0py?=
 =?utf-8?B?UGZKY3FIYVp3UTI3V3VJbElhT29LbUtEeGtyTTZkNDloVHppT0dZeTRoTUZH?=
 =?utf-8?B?ald0WHNyZU1JRXZJNU1HUGY4dE5oZTZLOFZlTHFacXNtNkFvTWtOZW5mSVg5?=
 =?utf-8?B?K2tPa3ZrSmZxWWR5aTlmeEtWRW0rQVF2MlYxUjc3OHk2b1VIWVBtUDZ6T2xw?=
 =?utf-8?B?bG1GUHJkdy85OGZMZVpkbG81RGNoeHpLRmJVUUs0ajBub2xRY3NSRU9lZlRM?=
 =?utf-8?B?bEc1SXlueFpZL3NMeFNFZFdYaktqVmlzeFkyNjNnU1d2UzdJbmwzYXZSR2NN?=
 =?utf-8?B?UmZpOUxEOXpzVlpIMm1BUTBZV0RrMThFc2FPZnpOWE5lNjB1WnBWRUF0MVlp?=
 =?utf-8?B?V1lMNkRxcEhqaXRCQU04Q1ZZMktGTzFLUkx0QitjSG9GTWpZb1J6SlRlSUdy?=
 =?utf-8?B?anpQNVZnUlNZMS9qRnBTQkVFWTIrNzhTa1M1RUM2Rlc4b3l1MEhRZFNMZ214?=
 =?utf-8?B?MGdxdko5WEdOOFhXVUgzc0dMekR3RUZhSnpsU21QUHd4R1hoTVlKRmU5QThn?=
 =?utf-8?B?c09jOFFzUXRhc21KdUJMaTBYZTNOSGpMMnFwUnpTb05uSEF6b0FnbzRzcmZT?=
 =?utf-8?B?dEx0cXZWS1dtN0s2ZHVxb29hNlZpcmlBeHg3NER1YlR2cWZBYkg3MkY1RXRz?=
 =?utf-8?B?NllpNXVwaWN1VE50VTIyRmF2dDNXbTJSNUxtc1B0YWdZRW1hWSs5REpJZ09w?=
 =?utf-8?B?eGMyVG9VT29RUUFZN2lDbUhHc0RPb0k0ZWlwYjI3Qi9MUUNDaGV2N2lYWTlH?=
 =?utf-8?B?LzRCM0hxZGs3NnNqNnluTkd1aWZJMSs1cVlCR1E4bEJIY2lNR0pGdUQ3Mkww?=
 =?utf-8?B?Vko4aHJaenpzYmJMeTBGK3kyYlNncTFtcWhtTWNMNlVmVUZOTFBZaTJSS1Uy?=
 =?utf-8?B?ZHlXVVlaTG9vK2kwYkFsS1JxQXpBdjZvYjAvWW8wSVIxZ3FIa1dlb2FVd2pM?=
 =?utf-8?B?aEtyOCtjaUNPb2tMZjZLMXkzVWhrbEh2eStvdlhUZVR0bDFYclN3eUxMTWlP?=
 =?utf-8?B?ZVl6RHhmeHJrNGVQN0tsdzVZNzhnMWJNWkp3ODR2RWIzaS90cHBJeE0rVG9n?=
 =?utf-8?B?alFyWUF5cEhiNm1DTVErQURKSWZUajhiZDVuUXI5RzJxcEM3cmcvUmFwNHdB?=
 =?utf-8?B?OVdFSzdnRVV6RHduQXVBczhuUS9IR2JGQmI0VTlRRGluNWpINjN0S2M0c0lJ?=
 =?utf-8?B?SVF6bTZIcDhzam9CU21vck5paHMvU3FBY2h0ZTMwaDhkckErMFA2RGRpT01a?=
 =?utf-8?B?NHdwRldPL3JuclREYWRXMEtZOGdBdUdFbkg1aXRjYkFlWGlDTFN0c2diU1kw?=
 =?utf-8?B?VjVPWi8xZXBhSHVIVmlZY0hRdGFYUDZwMytXaE9LTVR2VitIUVU1K0RrMGo0?=
 =?utf-8?B?YnRib216Vk9vU1c2b2tIcjJKMmN0UkdyUVpBa25Bd3dqbkxySk9pZXhDRDV2?=
 =?utf-8?B?UzZtMjV2SmJDWG8rVGZzSS85aVA5SldHKzdwNTBkRlhOMTFKYXlBd3AwSUtq?=
 =?utf-8?B?TlY2OHZIZ0MweXc5MzY1SzA3WHR5L1RFSUErSVVGRm04YzltUkZvdTJldG41?=
 =?utf-8?B?SHFVOURocDZRVjRxMFgrZmY5NDdNMTJtZUtZVEYzSHdVOFNHMjlkdys0YjNh?=
 =?utf-8?B?dXNrZEVVVkxWUHlHbEhESFRycmlkVVkrNnhoOUsrVUlPdXQxWC9Jalg3WGdW?=
 =?utf-8?B?Rnkxa1Z6aDB0VVFOelB0cE1ZUVlKTFEwZTFlR0c2b1lNNHh4SzhDMGJCbXIv?=
 =?utf-8?B?TXJ2RytwR1M2cFhhSXdaN1lKOEhnYlhHZzg2VnFOdDFGSzZDdUd3K2w2Z2VV?=
 =?utf-8?B?bVVSbVo1UEFiUGp3MjdoTTl0aWRVb0wyMGtMbUlUOElDOE01VURXK1ZLMEZB?=
 =?utf-8?Q?O9HdW1/2iK5zCYr+uTR1exc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df925639-f042-4a59-2384-08d999cd025d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 04:40:04.0243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pZeXmZGf5nM01IYx8gajyhUbsftbbM7vHYmOSuxQarpmQboZDZj15WhOWev9Rob1mJM1Ux0TRjXDk0bOaES9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3789
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10150 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110280021
X-Proofpoint-ORIG-GUID: 0HqW5R-l3lX2GF5rdkn6cIAVXvtsmKP2
X-Proofpoint-GUID: 0HqW5R-l3lX2GF5rdkn6cIAVXvtsmKP2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


  2nd try. Ping?

  (Pls note, patch 2/3  dropped based on Nik's comments.  patch 3/3 
separated from this set, as it went thru revisions and not related)

Thanks, Anand


On 13/10/2021 16:00, Anand Jain wrote:
> 
> Ping?
> 
> 
> On 21/09/2021 12:33, Anand Jain wrote:
>> This patch declares int seeding_dev as a bool. Also, move its declaration
>> a line below to adjust packing.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v6: new
>>   fs/btrfs/volumes.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 5117c5816922..c4bc49e58b69 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -2532,8 +2532,8 @@ int btrfs_init_new_device(struct btrfs_fs_info 
>> *fs_info, const char *device_path
>>       struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>>       u64 orig_super_total_bytes;
>>       u64 orig_super_num_devices;
>> -    int seeding_dev = 0;
>>       int ret = 0;
>> +    bool seeding_dev = false;
>>       bool locked = false;
>>       if (sb_rdonly(sb) && !fs_devices->seeding)
>> @@ -2550,7 +2550,7 @@ int btrfs_init_new_device(struct btrfs_fs_info 
>> *fs_info, const char *device_path
>>       }
>>       if (fs_devices->seeding) {
>> -        seeding_dev = 1;
>> +        seeding_dev = true;
>>           down_write(&sb->s_umount);
>>           mutex_lock(&uuid_mutex);
>>           locked = true;
>>
