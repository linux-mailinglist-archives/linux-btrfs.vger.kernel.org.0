Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6525D4148D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Sep 2021 14:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbhIVMbH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 08:31:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8392 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230171AbhIVMbH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 08:31:07 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18M9mA8a027984;
        Wed, 22 Sep 2021 11:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vN7512Vf0Mpo+9j6LffLPrX3CnhAXsTfgSLqEdWP1js=;
 b=QEJmuN6FEmmf230tagPIH8B9ozB+Cs7naQvCNaR/FqeJ08zXP6j1Hz6Uxx0k9VELEUU9
 B+FlbVaWKYk9qQWn+avXub9Zg3ABBZcpBqOIKPDNEfelBuKvTqiWJ1fF+ZRwD5D5Clkd
 p+uDbNts6DPeXvY1N3PGERB21UTCgKjQqzL8xD6Vi+pnwtIDetwx3oRSTy1eMcmFs9xg
 cJeZtgVcJ8rUMIhTQyX3MZc8sPmxs3ViASf02reOWJC/AGKwckWEO48Q7L+cxYHVPayc
 Bac4MAoErJ1+GJ9Ztu2stohSclKZIMfElhHcq9lt31I3St5kpETkLREdNLlYvFgt6+SC Tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4rb65q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 11:29:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18MBQ2As185721;
        Wed, 22 Sep 2021 11:29:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3b7q5w2d4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 11:29:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eO5F1h9jXCFIOQmCydROvNimIqZ2C1dA8v7RqBLuQBnurcl8M1Xpx16QNZy55qg3WRu+2+zQGPuWSXXhKYYVeceQ+P/PlH0Xc8FNrcfp91tRpHtBZXPAN2C/dscKtl7DvEfDpcG0C1HT/dX6JvgGI239ng7ZeWP9o2MDG/7Xe7xZcILjjRUiIsh+unZMZl0H5FY2RF0W96/Pltaknpub05Dnpem+3UrJQQviPNmk6AWX+kR8bZcSKaApNpRXwlXKWhQlvcbf1sVoVavsH3yHjLVMZN6AdQ0JZl9UhP8lhVlnf9CmKcYQqUtWSIVe0nOZl4gK5Rcdhv2m/7/QuaMnBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vN7512Vf0Mpo+9j6LffLPrX3CnhAXsTfgSLqEdWP1js=;
 b=Qez1qTIC+XichdTTqKN6t9sA9BtKbXCwqy78cswn/iU15IFO8rgg7WIyjTP5cNhXCrRDEbu7ynmAnlMG1AjojGS1NmmHEFe2seLYKF0auBDm/QLiU/Dzw/leajrBXVQkz9gHpKLFkXQnGJrbRuXqqG4SO5P2TwVHEMXHFyNHKpD6NgcJW2Z0q4cCOBry0lLLuh7se8r1rVWCqMishPKrjV7/6z5K7qVqK7KSNecfQyI269C2Np47eBKemewKJRqdvkGeHkONHrg+W3tN27u+mmCCixoIM8XSaApLVpqotgk/ZKfZaq2fTeFp57ovTM9w+YfJJbGSpS2zXSa+ASx3QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vN7512Vf0Mpo+9j6LffLPrX3CnhAXsTfgSLqEdWP1js=;
 b=v0LA1q/z0yLRAoPqYi00aDUNcgnxY+jdECW7vNw9f8NKHxiMI0vGHbsoPfSmUsS504AlOkkITp9f3DgS1Chcpj1h37mfIYyxXrHopg3qdSt6eiLvMM00xiiBmcRt6+HN7zG+mCA6vpR4CEOXhBioU6+ibsMEn89sJT3+T8UmfSo=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2771.namprd10.prod.outlook.com (2603:10b6:208:7b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 11:29:30 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4500.018; Wed, 22 Sep 2021
 11:29:30 +0000
Subject: Re: [PATCH v6 2/3] btrfs: remove unused device_list_mutex for seed
 fs_devices
To:     Nikolay Borisov <nborisov@suse.com>
References: <cover.1632179897.git.anand.jain@oracle.com>
 <457af6350aa51333fc584210d8dc5ca7e679f3f9.1632179897.git.anand.jain@oracle.com>
 <1c79bfe9-20b9-6ec8-285d-0e653215a94a@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <55a8c670-3865-e45a-593c-d9b318ba505c@oracle.com>
Date:   Wed, 22 Sep 2021 19:29:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <1c79bfe9-20b9-6ec8-285d-0e653215a94a@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0100.apcprd02.prod.outlook.com
 (2603:1096:4:92::16) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR02CA0100.apcprd02.prod.outlook.com (2603:1096:4:92::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 22 Sep 2021 11:29:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd2103b8-2196-48ad-0b7b-08d97dbc3e37
X-MS-TrafficTypeDiagnostic: BL0PR10MB2771:
X-Microsoft-Antispam-PRVS: <BL0PR10MB27719247BE40B8B0CBE01232E5A29@BL0PR10MB2771.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8Ru22cDiKOZTlTtrTpAfeVcAlC0e+BYpkwfh3iOSLn2G23DXLw+oSL1HaeFrrI1Fyk22xeGpyJYqXNgVrt8c65J273YBEUJtXWDTTNSMh8HdZUChQhPyYbVn2S+LO0G4hGJ1mZruldOP6KrHVGSA/lukwsJr/eWPJRAcW4mqrm7jZo5C8KgNP0TjizHHGYJaKSbKoxD+NS5EYCAm6kLOBrjxt53FzSYJxLmEP6/88X2B79mbEGoRIq4iHGspdQjqAh8KHr24rndjEr4BFeO1IkksS/WU0xJUXpQvF5nZFX1U0TfwKenoLMtANfutaF5nQsfXs9UKSz/GYULKZ5SUCjSZGRb8obF4AGRmOV7zA6RP5qiuOdXTcxxI+TtaqrvwHdpXzrobZnw8VorO7dpUTYwkmWX3qO2EbMhZSBKV8sujXNTHQ4cJTY+j0g1C/XDTc/OE7nEVzjDgWFJCZxZy7OIP9lVeH7FZsg2gs33OlnLj58DdXSEEO5LaMyPIi0p8bhsWwm0gnz/nATkcZ0PPhI4gDyGRz2i1E5FpEWJXcpq6d77F7KVe5jwn7Eiy2yh2VEynxt1zM386yXw8tU+idWFgJQ++Hc2IpUojEKRW9TVpXqGtoVFseAyeWOrXxasIypnLhN1uUHedi4QUZNHwn0pHzB7W2uTK162ieYWCjDa2xTN0Vbj2lgEPZPir6af4Nfvn+9k9UW2ZLrY0AcGew9N3C7h7D/hAeB+E5UCtuw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(16576012)(316002)(31686004)(8676002)(6486002)(31696002)(6666004)(86362001)(8936002)(4326008)(956004)(66476007)(66946007)(44832011)(2906002)(26005)(53546011)(83380400001)(5660300002)(186003)(2616005)(36756003)(6916009)(66556008)(508600001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q24vcmx5VUZPdlNKQkF5elV1VHgyUkFKRmFBN3JNN2NPOEpQc0FkU1FZNlFv?=
 =?utf-8?B?N2lHK1lhSW9OS2dKdWxXSUh1b3gwbkRBNERDQWsrRk5RaDIrZVNjdGx5WnZX?=
 =?utf-8?B?LzV1bWVtNHNod1hrbUo1K05tOTBIUXFsZFdqZFltbkx0U0ZudjBLM0FHaDlw?=
 =?utf-8?B?Tk56RFoxbmEraHk4bm9ZTzdLYkV3SklJa05BemIxbUdUSExhSXdDZVFlV3pB?=
 =?utf-8?B?ZTFZaDN2cGNadzI5MDBTSHVDTTBTVXFtcCt2VTNOZmF3aTNoMU9oNkhyREVr?=
 =?utf-8?B?VEg4TlUzR2FZMk56VkhCQVNnYXVqUTl1WUhVWEtDbTI4QnRiaEVyUEJGcjZF?=
 =?utf-8?B?S3FDRUEvSXNjUFB2Mlhtb1JMdUxsUW9CSGszdmcwaDdid2xKN29TeUd5QUpl?=
 =?utf-8?B?KytFYWdMNUhGQ01XVkg5U3UrdFRHamhmZ3BtT2daY3cxaU05Tm5IZVdLd0RR?=
 =?utf-8?B?WDhPY3gyOXFVVUgrb1U1ODNxY2Ezc0d6WW95QkxGMlBWRXl6emVWcVpVSlR4?=
 =?utf-8?B?N1lXSGNBOXRrYlFncWFMeGk3eVpxMFROeWoxVG1VODdwa0Jua2EvQVNReEtz?=
 =?utf-8?B?QVFmTUhZNGF3Z0lNampLQjhEc2dzS3RBSmdQTjJpTkE0RUZnb29wQWt6cEtX?=
 =?utf-8?B?VE16dC8rV2JkV1hkQXB2MFI3RlpLdUxIa1VFWi9sQWhhY3Q0WjZtVFFaQ0Fz?=
 =?utf-8?B?dWwwM2hwUVYzTHpmR1ZaNTlpZzFGMXQvWCttV0JldlpPZUVuQU4xMGdsb2lI?=
 =?utf-8?B?VnJyTmh0bkJCOHYvSVREMWlMY2RTT20vUkNvNlRXWk5sSit5S0hzZzdVQ21G?=
 =?utf-8?B?Q2ptTkg3MXFleDJ0U2MwaWpMNlFhWi9MaWMwYWV2aG01ZDhSbVpSYnVHSTVO?=
 =?utf-8?B?K1llcGxaaURqTTB0OFQ1R1gzQktWOWRZK2hVQVNIU2d1aThEUndzQ1Bmc0Vx?=
 =?utf-8?B?Rm1ISHVCYlZGMnpkQjl4L3g3NUJ0Q0cwQkZyNWc4V3VSS0lTUEhhcE5RM0lX?=
 =?utf-8?B?Sm5za2pyMjFCbWM4TThBNjI2Wm10Ty9ZMnZtMjBPdHdDNUpGQThLNFZ0UnNi?=
 =?utf-8?B?bUJCT0pHT2lGZEE5TC9PcDNMMVVxL2dFclNMVW9RMklETGVONkxONWJFTDZP?=
 =?utf-8?B?Q21ETTdZOW9VYUZUZXFvTFhlZWIwcThxeDlPUGF0SGhOeDlmcTZqRnhmT0tS?=
 =?utf-8?B?c1lHbGVFZE83OXJocXNiWnAyODdqSXJYNmVPOXlzamc0YUhDN2liTFRoMlZD?=
 =?utf-8?B?bklFOHVqZ09HR2w0aHdmaGc4dGhXblBPMngxbjhHK2prck9pNWtva2NwZ0xn?=
 =?utf-8?B?VDRlRzNCRmhSNFNOZXNLSnNQR2ltOWZPNzZyZVpuWXNsMlMxdWtGTGZvNE1q?=
 =?utf-8?B?Q1pudkd5M0VNemZSZGVMMmE3a1RTa0VoQjVqZlc0NWxvY0lSZGhhYUxKc2xs?=
 =?utf-8?B?UDM1RStKcmlwU3EwYkJnRDlONFdwbVVadXh3R2huVzdTSHVMOU5nT2tianRi?=
 =?utf-8?B?aVVVYkRRV3JtT2hUeWpHUTIwTDhhV3FDeWQrVlFHbUNrQ2FTK1Z5VmxSUlR3?=
 =?utf-8?B?V0J0dUF0ZlJ5V05UOWgzVWtpbDFpelp1TDhQU1MxRnc4Nm10dzh1OS91Ym9k?=
 =?utf-8?B?NWZFZTdTS3hDN1gyY2xRLzZRQnlSdGlJaStEYUxnYXFuVktQeXViVkN4bFcw?=
 =?utf-8?B?NmRzeWMzUEhOTitnOFh4OXpvQ0ZoZ0llZzBLKzVGQytuWEtsQi9VdVVzQ3d2?=
 =?utf-8?Q?REnKaji2QCtPSmkmQk8IRZ7HQOYRY2B0kIOk1OT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2103b8-2196-48ad-0b7b-08d97dbc3e37
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 11:29:30.3492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5iI8pImI2lXsuIX44ijcX5ONlFY+FeI+5Jg4Mt2qqffElKxfebEUuE55EU096ouQbhNym4qM98Cy93w+25YDxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2771
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109200000
 definitions=main-2109220080
X-Proofpoint-GUID: Y6vaZKYfZGMKDH4HQyvdcW1M_VqFG3yp
X-Proofpoint-ORIG-GUID: Y6vaZKYfZGMKDH4HQyvdcW1M_VqFG3yp
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/09/2021 14:44, Nikolay Borisov wrote:
> 
> 
> On 21.09.21 г. 7:33, Anand Jain wrote:
>> The btrfs_fs_devices::seed_list is of type btrfs_fs_devices as well and,
> 
> seed_list is in fact a list_head which points to btrfs_fs_devices, so
> that sentence is somewhat misleading.
> 
>> it is a pointer to the seed btrfs_fs_device in a btrfs created from a
>> seed devices.
>> In this struct, when it points to seed, the device_list_mutex is not
>> used. So drop its initialize.
> 
> Even if the device_list_mutex is not used in the seed_devices it will
> have whatever is the state from the original fs_devices so
> re-initializing it to a sane state is the right thing to do.
> 
> We don't need this.

  I agree. Maybe at some point, we should have a separate new struct for 
the seed's fs_devices, as few members in it aren't in use.

  We can drop this patch.

Thanks, Anand

> 
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v6: new
>>   fs/btrfs/volumes.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index c4bc49e58b69..e4079e25db70 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -2418,7 +2418,6 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
>>   	seed_devices->opened = 1;
>>   	INIT_LIST_HEAD(&seed_devices->devices);
>>   	INIT_LIST_HEAD(&seed_devices->alloc_list);
>> -	mutex_init(&seed_devices->device_list_mutex);
>>   
>>   	mutex_lock(&fs_devices->device_list_mutex);
>>   	list_splice_init_rcu(&fs_devices->devices, &seed_devices->devices,
>>

