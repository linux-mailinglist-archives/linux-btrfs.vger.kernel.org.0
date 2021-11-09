Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F413644B490
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 22:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244996AbhKIVWx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 16:22:53 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18943 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240650AbhKIVWw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Nov 2021 16:22:52 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A9KGEjH026636;
        Tue, 9 Nov 2021 13:20:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=vuz/WjhYrJHftCpBsxZ6g1qczUAxhr3reJ8fUtrwhdk=;
 b=jtSUVv1eeV5YMgEsOfC1ygmQtU3Zx2LBMLPqxr4A/a2WPlHOwN9SZpK3hTdFuQGfI4n7
 plsW+lk8Wn7p0XPxFov/oKudnnQFD8xqoq8jtC3DNYcAedul98Wn0y5n8ZonvOkBPTKF
 bgh2UAW3WASDstt5jKo/nL9EZLhT5B8je4E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3c7w04j7qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Nov 2021 13:20:02 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 9 Nov 2021 13:20:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVvCaBtuvmMLMeC1xdj72gQ68q9XI8uLLsvmWv7t9oUgqrTElNQisBRGY9siharc5SbshjOnasiZTl2p3itZwasLO75Of/o2eD/4GcuqqiUX5F+NrQ5sePKu7R/vs40vpAcXDJ31axPlVOa+NP5H1bpjPvJn7zFUSQRbACqHO/UUaDQ8dRYSs5J+X8BKgU9fosCx3JwTu04mIkKJVKk7nthIQzgZShnbs/9CvcGw4xTEJtUshf5nWDpniNPnd/YWNeDdTqz5LGcGOm9JXKeJvHwIk76qIgQYxffWScOZM8g071pMG6EDn7m9PKjW3kKRu7fAXoHmJsqxO3yMc+oCiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuz/WjhYrJHftCpBsxZ6g1qczUAxhr3reJ8fUtrwhdk=;
 b=iuUXz3DcOzJYiz0af6vDUUrRD52KuZxjqjztMtqX6ORDoKaJ/4U3W72XUqnhMOjhDS3Df/toRLqFofzeux/veyt/1LjVSYvyoc9t2lbnAaV9CGnCXy11hsTEdrN4alDvTLL8jrucKwLlv1gK/kREK3n6G1VaWVKVZhLhuH7rTGz1vF2gIjZ4yJNOlQ09Fi9Y5VX47rDJFLqVuVcWm89o9c8Wd9rLD4jb68ftuZQShMd3l4MKFROZXE13EG0OEXl+ZEPLjt4DqWOnOtZkvD3g6lNHVPlL/PxGkYHCzoe7ShJtZAE2+yhglSlnRQQIimGLNBpVADilWdMq1nDYjyRFUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
Received: from MW4PR15MB4410.namprd15.prod.outlook.com (2603:10b6:303:bf::10)
 by MWHPR15MB1295.namprd15.prod.outlook.com (2603:10b6:320:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Tue, 9 Nov
 2021 21:20:00 +0000
Received: from MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::6d16:2cb6:9c06:c719]) by MW4PR15MB4410.namprd15.prod.outlook.com
 ([fe80::6d16:2cb6:9c06:c719%3]) with mapi id 15.20.4690.015; Tue, 9 Nov 2021
 21:20:00 +0000
Message-ID: <caf2d757-8a5c-7665-56ca-bf05346d00ce@fb.com>
Date:   Tue, 9 Nov 2021 13:19:55 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v4 4/4] btrfs: increase metadata alloc size to 5GB for
 volumes > 50GB
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, <linux-btrfs@vger.kernel.org>,
        <kernel-team@fb.com>
References: <20211029183950.3613491-1-shr@fb.com>
 <20211029183950.3613491-5-shr@fb.com>
 <443789f1-1b62-80e6-a88d-73e1fd11233b@suse.com>
From:   Stefan Roesch <shr@fb.com>
In-Reply-To: <443789f1-1b62-80e6-a88d-73e1fd11233b@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0252.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::17) To MW4PR15MB4410.namprd15.prod.outlook.com
 (2603:10b6:303:bf::10)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c9::13dd] (2620:10d:c091:480::1:f92a) by BL1PR13CA0252.namprd13.prod.outlook.com (2603:10b6:208:2ba::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.5 via Frontend Transport; Tue, 9 Nov 2021 21:19:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16184f8c-4eeb-4a4d-e773-08d9a3c6afc4
X-MS-TrafficTypeDiagnostic: MWHPR15MB1295:
X-Microsoft-Antispam-PRVS: <MWHPR15MB1295BA9B4702D6635F1E0EF3D8929@MWHPR15MB1295.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pL7PKN5rybl9AcGxFNFnssFNC60Hklqq2uv1nG1wpkcNHtKgOGQORXfF29TQANSDh6bOAAZw6SZNFENCXYcOQod9msIkBnmOR2QGCeteZvr+GzODRtSBOIButIjL0Li7u7vdV44zioMkZ2xmyaSlqTclPo4WLe3PsRDjBCNXynRHxIUsCKmZW0ZQtRl0bNT+aekvsBataTLRRgM7kJnEHs/Msbvdr47ZBmU59GO4ESv5rUh0LVm2ogPXE49pav0Hpq2s9Y0a6DIMV81zrdgKtY47B8b7rZuW8EJvMv/kakkoYyX7Su7KamF5837t/CeqVY7L67Ytnw9d0li88+njOzbYk+0KjvqFhi3+bMa69YmubFrF0WTGdCNDlUWwAzXeLX1In6OQa/c9vz4gO6pOHRpNJaHZds1w5I5tg9Vlu5dKDUoff6N2sDtwJye+iUr5svdja9y9lk/RDi5G5oFJA3vbZVOH4xMBowg6iYaW5rfWJ6Krvcdp8AbKLz033fIMYUknfQ4mLlBKnpjfTv+2iXmXmTZDmmJ4GdBOv7TxTls9rpSWxCcRzZfCWay2JJIath8jsztk05RifnXj0816c24oMk3MxcKZoJHW3BzlQqDfP/DpGvdagzKJn9oYo3zyPPAiO3+iXjH5+twFgQEH99hhv+prIoP9ZTe+e/Y0Sp0dUy+jfrFExh3CJ2zP/nIDl7tQxMhnV1pDcK81iOsZaCAsSR1g31TcF1vNk+xWkNY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4410.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(508600001)(31686004)(6486002)(316002)(186003)(8936002)(83380400001)(2906002)(6666004)(53546011)(86362001)(66476007)(66946007)(66556008)(6636002)(5660300002)(2616005)(31696002)(8676002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmNVZ1JsNUR6bUpVYVZac0lTVVE3M08wcHE5dGNPQ09rZnJiQmhsMTNVMElO?=
 =?utf-8?B?T1NRRWpySWtzSlo2R25KOTNwMVA1c3ZUa2g1Uktzejg0M3hEa2dhYnZGWUlo?=
 =?utf-8?B?K3pRREpxRmhjYjRrNkxtQ0czNWdJcDdPWG9vNGloYUd5aHEzKzhMWDVJdVJJ?=
 =?utf-8?B?SGJ1TW1halJtblU1WnBBL05OZUNJdkFJWW50ZXV0SGw5N3pGZy9UM3JaVGdF?=
 =?utf-8?B?MExKL3hlRHpNZ2lzeWtWU2VEZTMra3UxdDFhcFNOMllCSDMxODFTdHNUMVZ5?=
 =?utf-8?B?dGtzTXhrVXh5SkhVU3M4UWFxaTI4RXlVdStCTXZvZDk2OEdWZERwSytFNjlo?=
 =?utf-8?B?eDEwLzlBdUFjS1hSbG9heFBYRHVKUDBlTXFSWGpWL1FwUDk1S3RlenN6OEcz?=
 =?utf-8?B?dVVScS9UTlZkYlhzU1EwS0dNWFNPSnYycmlTUWRzNVVWY2FCR3JMbmhBdUlj?=
 =?utf-8?B?R2RnQzUxbC91ZDl6L2EzU2tMSzRrWlU4Syt6Q3NCaUNqS2JleTRWaUVZekN0?=
 =?utf-8?B?Wno0TmJQSlovQ2tBV054Y1R6bmR0bnZ1Q2NNU2IxMVp6SDFQbWtkTHdQaEVx?=
 =?utf-8?B?cVE4cTB1cXl5dHMraHk3SmRoSFZDR3Q1ZTQybW1ZODB3RDZndUZrWkhVQWFH?=
 =?utf-8?B?eDR4clA5MXp3bXFvWnRJUU5UQmU5YzhYWXUzZzVUMzhPM1UwOFpyWFJCOEQy?=
 =?utf-8?B?bEhNOEdoSzkyQmlEWkY2SHIvVkVJd0s4UFl5RG9yUVZ2aDRMNURDby9DbHJM?=
 =?utf-8?B?TmZ0VTU4bXdla2xGTm9WME8zWCtvS1pLWUZFeFhqK3A5d0F1T3JxWk9MMzZr?=
 =?utf-8?B?bnQyZFMwS3RoMldKUGpXQk12eXNrdXlheWhSYjRleXZTNURVVUIrVjdqYjd4?=
 =?utf-8?B?NmVnYU4zUkJycXoxa0IvVHdRWGJUdGU5T3dkWkJxMFdIZEFRZDgrNG9EbVVP?=
 =?utf-8?B?OWtUcC9BKzBKNG8yc29QZk41MEwyc0pWazE4a1JQT3pvbkxBcWF1VVJBQThQ?=
 =?utf-8?B?cWgzbGZpWGIwSXhGVWwvNjRIa2tuQlNKaWFZZXpSUFYyTkQ4d1EyUk80TThp?=
 =?utf-8?B?SWtSWk8ySWdvS3lWTmhEc29BbFRVc0RBWFBodU00SXRha29rY2gwVnZlQXJz?=
 =?utf-8?B?WXA3VFEzSXduSjIxTm5Ha3VaQlpoWUo2NjNuOWZqYldKOTFKMDN1L3dlTW13?=
 =?utf-8?B?QUYwMFBxTkdMc09RVGd5OUlJWld1RVB6ejZWUXF6N2p0VHQ1RmhHNjVxR0tW?=
 =?utf-8?B?ZDBWM0ZWZjR3eTBHYWwwczNDcnBHdzZGdnVSM0s1QXREZ1V4ei9jMHZUV2lk?=
 =?utf-8?B?eWV6cFlaakFhclpCdEZTd1JHcitxQkFTZ0xYVHNGTkRjMnhmdXdHdnpNYmNT?=
 =?utf-8?B?Q0hhVmhFY1JYdHFxcnRGNFZ4WDdjRUtVMGFqVmdRR1NSbXpwWW5wOUFRMHh2?=
 =?utf-8?B?cE5jcFBlcFhEUU9xaU5EOVltRUJXVjJ6c2FYRVhaa0NaNTJJc3VIcTQ3WWJG?=
 =?utf-8?B?QVUvWCt5UnllbVdxS3k4Z2ZRMVE5SWl2bzNxQ2NHYzhvV2VnTTRwcUVzdlQ5?=
 =?utf-8?B?L0k2ajhlU0tVL3R6V1hvWkVHdHNXUGc5Y0dGS2RVY05wZWViWjcrVU5KdTV4?=
 =?utf-8?B?T0FEd3U5dU43OEhFTVUwSnZsRk90S3YyN0pCYWM5MFJtOFcwUXcyV3duNno3?=
 =?utf-8?B?QUdmTDFXR014RlZyeTR6S1JtQzBKOE1DMHhhWExDcGw0dHR2TUx6dnkyditV?=
 =?utf-8?B?WE9ZdkduaTZNeVF3bWJxNHJIY0hjZW5CZzlPa0ZscXc5WUxIVG9nTFBGR3J6?=
 =?utf-8?B?SHJ0Ky9tTUZGWkIyTEM1d0tWYjZoVXJ4YnFRKzdLMGJUbjhMdVlzRFZQVExr?=
 =?utf-8?B?eDhQYURrY1FrVTUzbkE2aVo2aHFTemNSSTBkbGpKN0kyRDRNbVNaV0JhL0lZ?=
 =?utf-8?B?enE0NnIxMW9SWHRQcElNaTNzSWM3dGpaSUI4V3JLSEVFRW5TcDdQVEtpVVZK?=
 =?utf-8?B?UWsyWDUrbWdRaEw3eFhmZGhjcVpPVVN3MFJta29LbXR5dmZZRUZha1k2U2Nz?=
 =?utf-8?B?MmwrUUJrRkRFYURjN0tkNjUyTzJReXN4eDdMQjg5RWlaSU9yZlVVRmV1RW5B?=
 =?utf-8?Q?a5IVrvWn8k1rPJu3+wvCRPf8f?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16184f8c-4eeb-4a4d-e773-08d9a3c6afc4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4410.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 21:20:00.0610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTaLu0ZE2BePkkBVCTAD3a5rJhgJK9BCTQGTD7I9pyg2LLFEGzPNt/uWrA1+r4Kf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1295
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 09VKe1cd1WlwU3FdttYk_YvxoVh3aEPC
X-Proofpoint-ORIG-GUID: 09VKe1cd1WlwU3FdttYk_YvxoVh3aEPC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-09_06,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090115
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11/5/21 3:11 AM, Nikolay Borisov wrote:
> 
> 
> On 29.10.21 г. 21:39, Stefan Roesch wrote:
>> This increases the metadata default allocation size from 1GB to 5GB for
>> volumes with a size greater than 50GB.
> 
> Imo such a change would warrant more data about why it's ok. Clearly
> there is some internal facebook workload which benefits from this,
> however this doesn't automatically mean it will be beneficial for the
> wider user base. Also your cover letter doesn't contain any more
> specifics about the particular workload. Isn't 5g a bit too steep,
> perhaps 2 is larger and yet more conservative?
>

I understand that this change is getting some questions and a more conservative
value might need to be chosen. Let's wait until all the reviews are in and
then settle on a compromise. 
 
> 
>>
>> Signed-off-by: Stefan Roesch <shr@fb.com>
>> ---
>>  fs/btrfs/space-info.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index 7370c152ce8a..44507262c515 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -195,7 +195,7 @@ static u64 compute_chunk_size_regular(struct btrfs_fs_info *info, u64 flags)
>>  
>>  	/* Handle BTRFS_BLOCK_GROUP_METADATA */
>>  	if (info->fs_devices->total_rw_bytes > 50ULL * SZ_1G)
>> -		return SZ_1G;
>> +		return 5ULL * SZ_1G;
>>  
>>  	return SZ_256M;
>>  }
>>
