Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B6E48A6E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 05:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346578AbiAKEu5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 23:50:57 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26842 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234039AbiAKEu4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 23:50:56 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B3TJpV027047;
        Tue, 11 Jan 2022 04:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=arP8TUVTlI2Y30189gUgejdVunjSdbzm0pnKtwjFQNA=;
 b=LhzFHSWvoxonaG2sX1dIEw58rjC3NwwGkcPQtaYYqp8odU48hWfY/KlnMIOfxLqTeC0W
 yXOLx2LLrizSuXyrgRp+cwgXNnnjFYbQzoDseqWK7zFNu20vfchvgjK5P5lNUUhx/i2y
 /O6FW2bbBEzFxUDQPEwPKSSuHF5TnB4m+71R+V3MXuZfZ3XQyj7RsBFTHMCJoF/ohS1O
 JGZNur2klE3Vgj5JAaq0XYTQZxqTB5zEIpVDhafb2FnXqJr0AEnP4qVxPDWsHs8oPxbg
 PlGWO3g0XiOlg7/HiKa7FuH2b3HnAv3AegF2glVHLwRFysQPDWJ0L9/SWU7o/INPF2WN rQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgn749y6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 04:50:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B4jd4P101286;
        Tue, 11 Jan 2022 04:50:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3020.oracle.com with ESMTP id 3df42m3fkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 04:50:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFk0hM9qb9QMWaIxT2qsyzdjcY1BXK7pY2dlrhmCx4KKPay4mglzVDjbsD0Qfzwr7ri7i08aBUVAjT4SuZHtIxw7u7uG+MeMtdNbEMqYcKkSYnWQgnGcZZMXuH2mNLBCHwjqoXj/AnsYB33v3Um6SY7kpWo/zqBEkbvdJKjkJ6W08bgLorEByG/8SDV7WrmJ73o3ceuF0AwMUluOap3hQexsI5u+z3kV76opci5XTqLqlCW5QNYcjbjr5l2ZEVWsYl4WtqJqAIt014KGaJ76gur9Wj+6Aismpf/tP0TrWvLige4UFPHbveBoAIidc4gyJ+Qypz/1Hhm8pKhRqFngRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arP8TUVTlI2Y30189gUgejdVunjSdbzm0pnKtwjFQNA=;
 b=kYThzdh3G212leingo3gmq8VvN/mylFlBn9LIUF6IFQtUheYmu4hoPB7u8TK/jSShDzE5Wd174ULkSwF2MQ2pLzK6TJX57plcnSDwENTG5l7XTQNfnNtSUtjC+fvmbhzbxPQh0pii8ufa3pXRWOZ+vmzkFGlHLEuzfmvNC04XCKOOhFnZlJcPLcvU76dvPHNcWvxATs0ud11QujL1SjB1CSnE/oWunHVd5okwx+2aAHz/XQQjLtekoxQ+VnjVCICZqwE/u/QvEUTDKQcVX0mVe0/2CJSHztBk5zc/DbyTZsL+qy7qwij0JNF3HwJGlOONxOTIQayiMhYpYVhBziHbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arP8TUVTlI2Y30189gUgejdVunjSdbzm0pnKtwjFQNA=;
 b=ms6vlvLHRLq0KI2oDV93htqRgI3zwlXwxynCxS2ZxKjBYzvHfW8UGpPnXuvvbhd9FrRvMI2ki9BnbZ/YibVt0yzzJan88+MFwZuy5gYavmwEm8ZE+stL19PONGBfz8iCAXTjCwtWxfDYajJxLbTJJMUUL+UgN+WRwNKwxDJGiXU=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5124.namprd10.prod.outlook.com (2603:10b6:208:325::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 04:50:44 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 04:50:44 +0000
Message-ID: <f252ec5f-8466-bdd1-9960-18c5d1a2705c@oracle.com>
Date:   Tue, 11 Jan 2022 12:50:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [External] : Re: [PATCH v4 1/4] btrfs: harden identification of
 the stale device
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, l@damenly.su
References: <cover.1641794058.git.anand.jain@oracle.com>
 <b1523d512e2e032c38bbb1b0341e95c52a0f08ba.1641794058.git.anand.jain@oracle.com>
 <4ecf171e-86f9-7ee5-e622-a538c96a52f3@suse.com>
Content-Language: en-US
In-Reply-To: <4ecf171e-86f9-7ee5-e622-a538c96a52f3@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f97542e7-ef68-4fd5-f983-08d9d4bded48
X-MS-TrafficTypeDiagnostic: BLAPR10MB5124:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB51244B6D7F41E7813A5BD3D0E5519@BLAPR10MB5124.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0IfJTkNvtlhI6b7I+sbEuUVtqoqh3yvZdVcjlu0y26lSnNItsiEs1OwfQngsenGB5GRhjpukcbft/lHW46rpAjW77WpM953w21Bba7kGZvOTjLV/ibiuwWXgN7nY0ul4Dm1sHt3gP8Cm4JzIyzPthDG9F5oetAcVo4E+OFcEqb0xW2rmPSfcaNznB3FGb5unnkj4oWVwrMxti3GJqJD3NlQQzUL27tJzfx5N4d6+NGLp4QMCEY5Xpz0g1jXCpBQc9bbuZoTVsL6BurLvsKAe4LV8I7iVudVoRlKawpA+PLezAs7LosqzAHeyB98K6hkTgfa4KXBGZVsMBclxX8lpLlEKSO6WK9S0LYC7pWPI+Ui1Qdz85KvVs6GaeneB0tOKZ4V+IPT0cm6ddN7POPEiNAgH90jqmT4beUAWjEbmwvFzxQFb8R5PhFhj6rwRTO/ZfxFNjE7kCLCSBHlZdml2jn/OJanBSomWD0tXQ1+SEyEmIz5pcCArm83OBmLFtrl2XJ+aJOXgVgxnm7bzer4fhexKO6LdVz+aw8HdJTZn4LPx3NymjRZIbC84+JMweqlf8L+FdPv+2vNmk6IdRQbUzf3d83CNLnnW41h+qj5oIiWrsQmgv5Z5DEkXHKKBR0AYTc044sCSoffYbqpYKP4tCeKOu6gksaEwRzfNsNihb43BkytaOS4exHSoyvwYHHiNOrEhZBJM9+p2FRnyPKonY12gZ8C5H23pBsvPDBDHRRc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(36756003)(2906002)(2616005)(6486002)(83380400001)(66476007)(44832011)(6512007)(31696002)(26005)(5660300002)(31686004)(38100700002)(508600001)(8936002)(6666004)(6506007)(186003)(4326008)(86362001)(316002)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q21jTEd5TVVCMXRaUmFwVlJXOFgvZ2VSc2ladEVUdkp0N2FjMmJFY1dsdlQ4?=
 =?utf-8?B?a0lOcjN6Y3dlVHlJSFdCVTVEUWxwK3dNWHUxQ2JzNkF6U1cvTEtlOSs0Vk14?=
 =?utf-8?B?NGVjTHlFbmtYZ1dvRlBueWRQT3pjT2RwYWZxZmtxOU5IWkhMQ0JQaW1TMWEr?=
 =?utf-8?B?UjVNSVduSDY3RWkxSTkvTlNJV3BoWG1CVUtmb3VoTWdJVWQxbHE0ejZYOXhM?=
 =?utf-8?B?bThGVGE3L050WmlmNjFpSkZTVGV0REFWdy9wWFdMRWV3SFIyNEpJd0RWcDdP?=
 =?utf-8?B?R3pGTkN3L3loVHgrY2dxQStReTZuYmRPbHlzTmZHbk12ZWRwb2RiVlFYTDBU?=
 =?utf-8?B?U0NEeStYZDVPLzVPNitOTVoxVHMwR0Rkd2NhQUNHUlpIYnJDVUJDU1NZUXNq?=
 =?utf-8?B?S3RNdEFyK0RYNGZVOG9DZjNvd0VlZGRlRzFKTVJsUWtGanJOcmNlV1ZYd1c3?=
 =?utf-8?B?aEErdHd3cW10MmFwTEpBYkl1a0RaNFFxR2JVeVY1U0lISElCdklsQ3N6djNY?=
 =?utf-8?B?eHY1WVpsUjJ1YkNNa2tKaWtCY1JaS3MrM2VvM2g1cEdITDh1blR5Y3BldkZO?=
 =?utf-8?B?dmtObGhidmh3TEdBaStPayt2YTk4SEFicEpBOXplUm5JNEdLUEo2cEc4Tmhj?=
 =?utf-8?B?SVJ6NWIzYWJpMi81bnRnT1BuSXNkbldTYVhUV2dBTS9hNVk3UjRyWkRqV292?=
 =?utf-8?B?dndDMDR0YzlBYno4OHg1YmJGNG9waDh6cWRDSTBNcEtqZ0FBNzdKczEybGY1?=
 =?utf-8?B?b3A0SFVXOUt5czQyZ2pORXRTN25uNjA2OFRqdThzV2c3bWg1cXhVOEFWaWQ5?=
 =?utf-8?B?OHlaREZ3cnRubHJqd1pSZnl0Z0xHb0tGa1dqYnAxSXhaZi9rSC9Id0ZiQVpI?=
 =?utf-8?B?ZkxqWE5uczVGMWFGRWsyT3MzaTlaM0xta1l2ZWJ3N0ZwR1k1ZXRRaFd0TFZ3?=
 =?utf-8?B?bWpWWlR1NG1yK3FqdXN1emlIVVUvMFpCRTV1elNaQUZWNWRxSzBEOXNGRE5G?=
 =?utf-8?B?MXEvbXh6YTBiZEdyUk1TY0wxNkNDMi9YWmQzSFczcFJ1SFM0UFJWSG5pa2Zs?=
 =?utf-8?B?L0JnMWs4blJ0c1dBZ1dBWFMrQStNbXlBZndZRDI1Y09NYUt0WXFTSE5pZzl5?=
 =?utf-8?B?UVExTHFhYkZCcHB2ZUdsQnd1cDZhL0RXS01ZWk84dW1SekEzbjFZREJ1NjFu?=
 =?utf-8?B?SmtCM0F1NFFyekJyVGR6NnFZcm5SQWI5Ym5Hc0tkNFFEUTNQbkJMRW5oZDBW?=
 =?utf-8?B?SUFRNTc1ZXJrTlZra2ZWRHdpdHJpUWc5RCt5dk9YNjZ6QW9Xem9qWFdRZ2E0?=
 =?utf-8?B?dzlUZmVlbFBlVW9iVENZOG5FWVViNEFCNWJwL1gxSTFwM1NzUmRTa2I2UURs?=
 =?utf-8?B?ZGhWQzVtRnZncEVjaWowOTVIWXh0U3k5VFNxMXFPdDA2YS9WR29GeFg0Q0cr?=
 =?utf-8?B?Wkk4aTByUVJ5Z3NVcGRpYnhDdmU4YndscWI3WEcrbUhGbjdJK3A1czQzcG1x?=
 =?utf-8?B?NW0zK2RXWmk2cFVuWlE1REwzUjhJNzF0ZGhFaHhZSEZBb291TW9yZWZaTnpy?=
 =?utf-8?B?WkhaUjQvalBsMHNoU295SDFvTDVXaDlET3VyR2RFRHordzBZazg4YTFxVStk?=
 =?utf-8?B?NVlIRXErclU3WHFmTjFqWVRWUGhCc3hvdnVSUXhmL3o1b3pGSHUxR0RUV3Bm?=
 =?utf-8?B?T1R2ZUR4d2pkY0cyYTcrVlY2NFREakNCQ3hjZVdYUHRYUkR5Y3FmSmlrSVpz?=
 =?utf-8?B?SVY4bDdnMFNzNjJCTXJPNnFITXlMemdTdzZZR1htTVlTMGd6d3hOQm52ZUxv?=
 =?utf-8?B?UFc0NG52TkZ1VVUzcXg1cUFnbkEyeVJPTjZ2TVF0cm5PUmNXTk5vVUl2ditt?=
 =?utf-8?B?TnJBSEZPQjFCMVdsVUVjQWtPdXBJQXhzeDNCOTJQVEdCYnQ3aThkVjJzQTlX?=
 =?utf-8?B?cW52MUdiTXBwUytmQlJ4V3Q0SjJrTW1yakF5NTNIck9ob0N6TUt5NEVsaWpw?=
 =?utf-8?B?Q3gxdUpZMkFNS0tNZ3N1TWtzUTYxak92cnJCU1VhM1RFWlVjUFZIMGtHa3l2?=
 =?utf-8?B?U0k1WEtxNkFZbllpanpuOEFubTEyYm1SVkRSc0tWUDNRRGlUSFB4MUNLLytI?=
 =?utf-8?B?ZHUzRFkrdXdYWEovUnM4U1p0UXFmZ3VTUE1hQW0vZ1JycEJEaXdLdkJYdnNn?=
 =?utf-8?Q?Fwip88eChk1yX97u0FiXJa8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97542e7-ef68-4fd5-f983-08d9d4bded48
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 04:50:44.8912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joFD7b58X7hY7/p0+nJDr3IttituqZSB3nctsSyRuRNGbYiTvz0XgzuJS+eSktUbf5o0EKhj8ACfZ6xHRh7hHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5124
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110020
X-Proofpoint-ORIG-GUID: Pp7pHO3z_FaPtZ6gYemQE5Np6G3rcYDF
X-Proofpoint-GUID: Pp7pHO3z_FaPtZ6gYemQE5Np6G3rcYDF
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 4b244acd0cfa..05333133e877 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -535,15 +535,43 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
>>   	return ret;
>>   }
>>   
>> -static bool device_path_matched(const char *path, struct btrfs_device *device)
>> +/*
>> + * Check if the device in the 'path' matches with the device in the given
>> + * struct btrfs_device '*device'.
>> + * Returns:
>> + *	1	If it is the same device.
>> + *	0	If it is not the same device.
>> + *	-errno	For error.
>> + */
>> +static int device_matched(struct btrfs_device *device, const char *path)
>>   {
> 
> Again, this is a predicate function, the error return values is treated
> the same as if the match failed. So why not simply make the function
> bool and in case of error return false and be done with it? This is not
> a big deal for the latest kernel as this function is removed in patch 4
> but AFAIR it's going to be backported to 5.4. My question is do we have
>   a real need to communicate the error? Given that errors can be safely
> ignored here making a simpler interface is a better option.

Ok. I agree. It can be simpler to treat errors as false and return bool. 
I will update.

Thanks.
