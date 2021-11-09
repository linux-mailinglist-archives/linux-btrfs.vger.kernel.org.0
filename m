Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB3D44A821
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 09:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbhKIII2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 03:08:28 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24916 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243961AbhKIIIX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Nov 2021 03:08:23 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A96J7pK013262;
        Tue, 9 Nov 2021 08:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Qenv+ZK5SZVxvayKqSrC10JptwBHpMXgImiEDzudtWc=;
 b=Opug6/sIofsFU/Ylb6XqhwHR3VEZOs3m+NqFDMTFEEOXB79eLFHj+gq0wMLbDiSs7jAC
 LL4itx/la8V3MQ4DkLJie+n4QaMW8ZH0u/gR22M68ZXM96JxQ0EJvqf1gFONFXjtyn3+
 8ib44Wn4oNtmxoPAoFTu4bbLBou+dVqNUOu6Ijv/1wZS8T/GWrYg75H1zl7c/2Qdpnnn
 j52MHntXFTOxhFCQqnI7xXjTiBjWUygoVJq4nJLHcakliMLJBpHIKkeZfl2Ks0/aZRPF
 76coQIn/YJHAoLKib1bcROvmVW5YqMrlD1SCPWkqhDl25XjvYz79soxtsMaEtjqBNZ3U Cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6st8skxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 08:05:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A985Mdj186246;
        Tue, 9 Nov 2021 08:05:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by userp3030.oracle.com with ESMTP id 3c5etv909e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 08:05:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lfm3TYLL13HNDSsjo3I3+gHltFLRV8fgVjZwsj39RAJHNmdufj0AuooMjIDCbly6pPifD9edYHuLckRVKjZSp5JEZw/+AqA60dwoBJvmYTQh7Cy3d/Wv6/M7CbOXK2nU/y+BruEPlWUHTryfXukwVfYkO3GTBk6/hP66sQbWiNthPttx/t8v7xlCNjydUx+fiJzOFVbZl5674bU9BXvL9xpvR1TXTjDnU1K7GuLibzThBSm2EssrfwqaQTI3i5+/sZWodq2A09bQ+MrTk2Lzo/2VqbYuKHQkAEspHa6KleWYxxhsme0b+8Fy/sy5IJ7VW0dk2ea8N9dsWeOF05UYtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qenv+ZK5SZVxvayKqSrC10JptwBHpMXgImiEDzudtWc=;
 b=f0LNqnD6UJDnCm2ZE8tdgbqPotaGAWHMBTfXCcqeZD68TmArlj0OlWz3LwOfTj5zNaREToUaBvfTASN/QH/9x3GMIqtq+oU6DJ4zOgQYstp41NRyMN4yQh4yOMnX60TthUeDRIGVJtIgPHp0DnCB44mMFJwoFgv3KBbRCNKtoUE03LQ42EYgMVPeTXBSNf0jU2Y70mLYLzTFFU5BHQkK5/FH8htqWNj33KOPGGqFb4PZfKnb8oB8HpV9gJef6UyqV4jw+ddyG6+SuKU95bdfRkj8GA3yctp2VpiVzSaT1lwsPj801ZkG409iCjwrHW8CHAHVaMRC+rZZpS3B4E0eVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qenv+ZK5SZVxvayKqSrC10JptwBHpMXgImiEDzudtWc=;
 b=m/tg+MT2KN3RcN0ERo57Iyr5dDIBeYRuTtnfzkGVMHvovuA0qW6faQdo4evCNLlYyBoC30kw0BoFR9tdUG1iHmEIWLXRKTFCT88hyrPiOxlZD/lG6mi0h9W1ERAQ9gki2AUIleMDz9Be0XMyMkoMzsYNzzhBuhENfn5Ie9BkL2c=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2915.namprd10.prod.outlook.com (2603:10b6:208:74::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Tue, 9 Nov
 2021 08:05:27 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038%5]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 08:05:27 +0000
Subject: Re: [PATCH v8] btrfs: consolidate device_list_mutex in prepare_sprout
 to its parent
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20211013080137.Bbt1omPCnM-ICZCnqrgjTq-2Rj4YbsM6OCm1MMBtG4o@z>
 <YWhNG9SowUp5nTxz@localhost.localdomain>
 <1a168ce1-20b6-aabf-76ae-ea9914264f06@oracle.com>
 <20211108200214.GO28560@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <62358dac-9302-b3ba-8ca3-9c1e42693a97@oracle.com>
Date:   Tue, 9 Nov 2021 16:05:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20211108200214.GO28560@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.137] (39.109.140.76) by SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.5 via Frontend Transport; Tue, 9 Nov 2021 08:05:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9164603b-bfc9-4dba-d6c6-08d9a357b0af
X-MS-TrafficTypeDiagnostic: BL0PR10MB2915:
X-Microsoft-Antispam-PRVS: <BL0PR10MB2915E47FD65312F90F0D36A9E5929@BL0PR10MB2915.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UEjlqPNQS6TekSPf5tYGN4OlhvRIE2tIzUs/9HorNdgWZodMR64kfUmmdNhBwoSdB5Z6kpBp+VF8jxWbFkUh2CQl/cdpCgSkVBE/Rss950M77G1F+sw9ttkKbTwk5lru4uMbfX+ceghY6+n4YD08lcmFlTFYZvSAo52ZJtZc4qb2e62zmniylcbO83S3l3pyNxaJ992z3bcqifI3U+b+p9HuPoQA6RQFZGjF2wk9fmgkx1jgWn2SfQ7Owcy9pNe1SaZ6xRkg695h1DdkuIrxwLlcTd1fYHHFZaM+qLzqg11+j9q6uQlcP6mdn2KyiJ6Np+s5iT7/jryawNRPzRh2HYh6U20MTFPOc03d1Gx+vrr3S5VEVDhmbt7qVUP7ul6Reyva97BHm3OODPr2G+USIeAqx1/7g1W57xoy/39cNwXWck9YZLMJiA9dz2LFXlIXrZ10Zme6pBWed2Iofs91iSBPZR8JiVHUyuDGT6WQkP1g4rXva4i+eSYmglL8xTLCZdGrgDW14Uvk79J1FVJypupp0O5LUKdCFrBr439Bge0Vh+A8yagA1NgKmRCS8mK0zPsUxHds899f+dj4/txBM92T2cQnhwH/JYXRYA7MdBKlxlqreh4jM+Wp0nL8rZswXs4fvw7LJ1BjPhBLBjyb/OZQQDbVIlnm5qHRm+o8k3VGKe4TA+D7fksVjXXLhAJWTCTVY8pcY3fSsOyVUbYIDegWnikbX1QZQCHcQtds390=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(316002)(8676002)(83380400001)(8936002)(6486002)(16576012)(2616005)(31696002)(2906002)(66946007)(508600001)(66556008)(66476007)(44832011)(6666004)(53546011)(36756003)(5660300002)(86362001)(186003)(38100700002)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzF6NUwvLzRna1daTHp3RHZiNG5aMkxuRU1NZWlFRHZKNkdiZGNBOEpwWVVO?=
 =?utf-8?B?MVRKblh3aGJDTUVPaTZ1SmgwWWtuS2tTWVpVRHM0WjdFSG9UMldYUk90anc0?=
 =?utf-8?B?eUFpK0s4YnVpbDZ5MTRqNDBJS1V1ZXUxUitTOEhZVzNUWUV3NTNON1dESzhB?=
 =?utf-8?B?dENMTVFPNHQwQWlzZXFrY3N3alJsVU02b202S0dpS1kwcmhZeTRPa3MxRUIy?=
 =?utf-8?B?dWNOMFQ2S29jdEkydGcrU21qdjRTZDJSdFJSMmdNOWsvamQ4d1JHM3E0bXdS?=
 =?utf-8?B?a2N6MXorVU0xaDR5SlJzd081YUZwZWs5c3BObkxvWFB0azUyRGtOcXRkUkRa?=
 =?utf-8?B?b1llWFUvRXErMFlBdUcxUVVPNzNqM3dNSE1ic0VwMk1SZ0phRWJ2VDQrZ3NB?=
 =?utf-8?B?UTJPYUxXSXgzQkRNUzVaa2ExK0ZhQTRmY3p5WVc1N3RrbVlPdlFkenBPa25D?=
 =?utf-8?B?QkZMYzhNTWZjMzRlZmcvNktBdjE4ZXltQWVUVW5sZkdwUTk2c0czakRXVlBR?=
 =?utf-8?B?ZlFXcGFMdVlaVzlSQ1g3RzBIY003Qm9sUDJTWUhwb0MzSy9FOGdKaEtZSVpz?=
 =?utf-8?B?UkExN2RORnZvNVlGY0R2L3lieVlnZlBTb0ZXUmlEcnpQaTlWNUtrZjQzVGZ3?=
 =?utf-8?B?RU1OYVV4MzhDK2NSbDNNVEx6bGZTdit5U0NwcHhVYk5SRHNGQlA5UWxrYU92?=
 =?utf-8?B?ckZFbHlPbW1OOEZ3ZW9BcS8xSkpnWHBIeWdTZm54b1EwaGxiK0QvTFdFSTNu?=
 =?utf-8?B?YkFRVklCZHhGNkxFUkZiN29ycWhFSW11c3JIZmdRRndETHVXa0JaTG5EeU1E?=
 =?utf-8?B?UVN2eUgxNGVkWTJhVkg0emlkSjUxNGF4QTBFZTI4eFdZK3hCV0tkY2NxdG92?=
 =?utf-8?B?cGVBZWpTNlQ1WUYyd1ZWRU13UmUxZTl0bS9sazliZS9EMzZYQnJUNmd1Q21V?=
 =?utf-8?B?SHNpMkYxRTM5WUtQZTJFWW9OQkloU21rVm1hOENUWThoenh0VVlxdnFnUGwr?=
 =?utf-8?B?eGJydzhLak5lWGZNR1REK01pN2FPeUpaZWEydnI0bGVzalg3a3F1M0FDaXBP?=
 =?utf-8?B?VXJtQVJKKzdWSkFOSkFPT3l3MVE0bDZPTHY1WXBxV2FVbUliZDBZdEZtTkxC?=
 =?utf-8?B?bC9iSmxRbUdvU3lUOHBibjN0bTI3RVJPTnlXeDFEckp1OGRoV2RjRFl4OW1u?=
 =?utf-8?B?UG1GQ2xjeHJUUXVkaW5ncTZtL3BUUzJEV2lyMDhMbTVLNSt6L05mOHdpZ0hs?=
 =?utf-8?B?QlQ4cWZRb29uMHBhUFBGR2hDSkdQZmdRRnVmRmhBNlJFOGdpNlJaV1lHZzhu?=
 =?utf-8?B?WWt4dGxCUFl4c05BQmtFeTJGVkVXZnlwUGtZVVpwZDhCWk1mWUxXa2pac3o3?=
 =?utf-8?B?NVhvUEc5d2RObFVsQitJd0RaU3BtS3BjSThELytOTVU3MXZGOGtKWWdGMmtL?=
 =?utf-8?B?aS9ubFFIVDRyNjRFRHZWK3lEUzJBSDhwRzhCdjE4aVhBeHJ0L29Od1JzbnBU?=
 =?utf-8?B?aHBGM1VQMVd4VWtRYnh6OUh3anRFMlVTNmwzb20xWXRIZWxiMjE2V2greXh3?=
 =?utf-8?B?aFZVQU1IZkdNczVDdDhnUUNjQ2wwZ1B4VGl6dUhSSUFqcEw4cGVVbGNnbGVl?=
 =?utf-8?B?cGUvMmFNd1JQeTgrQmVadG5VYnRLSzFPNlhPMnNGaXM2ODE2Qk1SWDNHYmgy?=
 =?utf-8?B?dTdMV2JqY0wrcEdjUi8veUJ6Z2pvL1gwa0dnQmhydytXZXlNUXlseDJFZGl6?=
 =?utf-8?B?WlQyMisyNUF2TjhwRzk3Y0Z1OHFwWEtaQ2cvQTVhQXFPalJWWXFERnNVb0Vh?=
 =?utf-8?B?Z1hhbi9mK2VLTzlrMUxlRGN3VFVJRkljaDJab1I5TkNCb1RpdnBtVmE2ZnFQ?=
 =?utf-8?B?aDZDMFlBMXpEdHpYRGdDek95eGE4RFBIL2FmK1djc3UzRUFpTnhVcUhuWE43?=
 =?utf-8?B?c0NTNjB5UlBhRGdmNXQzMGJMWldyWXZuTUdib3ZyZ3dIQ1l1bzJFQkdxUkM3?=
 =?utf-8?B?am1LcWp3TFlwQ2szSTlpbGlveitGdGpWRWZsNmN3QkVFbk5CZU5RSkt1MGoz?=
 =?utf-8?B?NGU0c24raWEwUEtZYmNGWFFKVG13blRYT2tJTHNsaklVUUtmazQ5YkFkMm4r?=
 =?utf-8?B?MGpTV0EvYWp4ME5XUkErM0J6QTZpNjF4cVpiWnR0QUVqZ1ZSU3J0ZWZPdHc1?=
 =?utf-8?Q?Uz42T5z9rApiWZhcgslnim0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9164603b-bfc9-4dba-d6c6-08d9a357b0af
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 08:05:27.6210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KAhnKIHVYP/AfYtn83NgPX11utgTUCBlZd/ISk9yFS7TA/BfKqUT6M0DD7HQgSKGgjjKDyjJ5s//o5qePn7kjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2915
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10162 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090047
X-Proofpoint-ORIG-GUID: HxPZHdNHQWSheFkdYR-EfV7agKFX6gsZ
X-Proofpoint-GUID: HxPZHdNHQWSheFkdYR-EfV7agKFX6gsZ
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/11/21 4:02 am, David Sterba wrote:
> On Fri, Oct 15, 2021 at 06:34:51AM +0800, Anand Jain wrote:
>> On 14/10/2021 23:30, Josef Bacik wrote:
>>> On Wed, Oct 13, 2021 at 04:01:37PM +0800, Anand Jain wrote:
>>>>    	seed_devices = alloc_fs_devices(NULL, NULL);
>>>>    	if (IS_ERR(seed_devices))
>>>> -		return PTR_ERR(seed_devices);
>>>> +		return seed_devices;
>>>>    
>>>>    	/*
>>>>    	 * It's necessary to retain a copy of the original seed fs_devices in
>>>> @@ -2411,9 +2404,10 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>>>>    	old_devices = clone_fs_devices(fs_devices);
>>>>    	if (IS_ERR(old_devices)) {
>>>>    		kfree(seed_devices);
>>>> -		return PTR_ERR(old_devices);
>>>> +		return old_devices;
>>>>    	}
>>>>    
>>>> +	lockdep_assert_held(&uuid_mutex);
>>>
>>> There's no reason to move this down here, you can leave it at the top of this
>>> function.  Fix that up and you can add
>>
>>    I thought placing the lockdep_assert_held()s just before the critical
>>    section that wanted the lock makes it easy to reason. In this case, it
>>    is the next line that is
>>
>>         list_add(&old_devices->fs_list, &fs_uuids);
>>
>>    No? I can move it back if it is unnecessary.
> 
> I think the most common placement is near the top of the function so
> it's immediately visible that the lock is assumed to be held. If it's
> too deep in the function, it could be overlooked.

  Yeah agreed. V9 had it moved back to the top of the function as before
  and added a comment so that we don't have to wonder why uuid_mutex is 
essential.

