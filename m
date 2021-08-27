Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A243F9525
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Aug 2021 09:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244445AbhH0HcW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Aug 2021 03:32:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35796 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244198AbhH0HcV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Aug 2021 03:32:21 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17R6IkYp015048;
        Fri, 27 Aug 2021 07:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wwQnaTWZF6y3jVh+0VX8AP6yHXtIAupTb7jAxonmU80=;
 b=Cyv+5qQ37UA+iPpe8Q1oGQa1/u4Z/+RYQjedYTXisLoPzyqU5Igz0VOi/goFH3l4C04q
 QZJKIDyerahUGzPXAQdvMsy2UN2F2hltfFDIPQOlyZx4aEe2niB78jLOtAsTyXmHMUWo
 IGBmGrIIfx3scAD+/Q2ZaHwQQkTbCll2LH6OYGs0BEPJFnTWOnIafN1QUAU6aNJarO+7
 tEJ0CKDAYt/t9b6ymVVMKMOwG37aUwFldaWlK52rPrx0j689jhuRSfznyADCUXWJkiQq
 w0Xv79VG5q1USX4flJzg4yKTmHBzoPA/077JuBeDbhjmxqTsMteDAU0KXapYkfZzmRw5 sg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wwQnaTWZF6y3jVh+0VX8AP6yHXtIAupTb7jAxonmU80=;
 b=My12w72vuPVySOCeqUejkHPHbuWy8HZYMq8hvkV0WkWA2Z+UCC/y2yUNmNIXv5znAPTo
 oyZ12Rarftun+AixL4HXi4iO5NvG1bUZeggZ81o3CK9wSAW0/421aO4vzSdxDDNSQ69u
 1KUeOOXfQ3NvavF/TVEGzHUUCn7LoHEmLw8TZ1PlISVcd1/8lWOh4DZxbLvJhymaILyo
 XU6UxPLxebFDRHm6Vus7Btd/qLmdIZoTz3/A4G39uVow738zoQZEBavRMRQ4gml/ot2j
 qRUqK0hp6X2dG26PLY55NP5eC+X+GquVH2eM/1bpipmFaNlx8bxCb7M0K5qsuZNtOKyA Jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap4xv2tv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 07:31:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17R7PmPB022251;
        Fri, 27 Aug 2021 07:31:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by userp3030.oracle.com with ESMTP id 3ajpm46mv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 07:31:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQ9Xd1j5DbzhWVTvqGRL7A+1nzb7Uutnk2vmxXSaEoa1EwWR6xlvNWQzKfF2kx2riyE5NPGonXuqyB7bdQ32HyQWqZKcVfuCLpVWUuXQS4+A6gOgYISaGrED1CH3CaWVc+tHpuvjVYFn0+N8UKecLuW58YmaxTqtiNcS1DSKXL6/b5hUZv1t7VjpyEeQ+jMZQMtP6qXXXgIvQnA9zPnq3KTnLonn1bG+q11JpD8vEPliLm/LubJcXf4eYLkXajqeyAcAnAWVKFpK9NlQBFJ1qSOZpDfVxGy+zp3Zka9a1vf7WDW7EkwSTvKy9unc+MGqwc5meNjnyFFthM47rLFsqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwQnaTWZF6y3jVh+0VX8AP6yHXtIAupTb7jAxonmU80=;
 b=mQzV733hhUpx3X3p+FgQE388PT8fcj6dlZh6u8P2c8nAmtvYZBKFv9ka33NS3+giFaD+N4pSBreZ8qph8I4iDBHEVZe4R5/UOUL8sTgEND7Bi15Hi3QqGsxjTDY5OqaHayfMQeczMWKsv+5RRQzxBq5NkHQZatfKL9fHVHbcmRr5jfcOGT9h9kjMIU48so7NqD7ZrI6FCICrki99PwSzs5NFvikGy6JQj0xaoUBCR8YV76hQrWPvEqrWM3R1ZtZ6Z1ESr6oSs0aeYfUxiv57kzmivpDDmXwck48WaaY1iCGhIGzWfZ/3zwpSDm4Hz0LkshqdtPyJmgJuOZmDczJlFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwQnaTWZF6y3jVh+0VX8AP6yHXtIAupTb7jAxonmU80=;
 b=zoLVomeV4y1hnUJfmj42k6PvOD4w3LcWsIIoJpm8TldhD1kgDMao7v7EE66THku9GGqnNHDweMrqjBRy9V85cLChCP3GIjXMR3TtM68TE9Jh2GHV2H73dtgZB5fDKdb4BKZS9c4AkKDdDQU1QLfzunlBElBY5vrA+1m6scvB3EI=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3774.namprd10.prod.outlook.com (2603:10b6:208:1bb::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Fri, 27 Aug
 2021 07:31:23 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Fri, 27 Aug 2021
 07:31:22 +0000
Subject: Re: [PATCH] btrfs: fix max max_inline for pagesize=64K
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org,
        Alexander Tsvetkov <alexander.tsvetkov@oracle.com>
References: <bfb8ebd29d6890022ddf74cea37d85798292f6d4.1628346277.git.anand.jain@oracle.com>
 <20210816151026.GE5047@twin.jikos.cz>
 <d418c51c-abc5-d08a-aa20-7781cfe1741c@oracle.com>
 <20210826175314.GO3379@twin.jikos.cz>
 <14e03a46-6ba3-9b7f-30c0-0be0dee5b4c8@gmx.com>
 <fa092236-9bad-89a2-539f-bc332ac0a3f1@oracle.com>
 <8ea8ac80-3b13-77f5-f2c8-d4e0b044b20d@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <837dc4fe-f2c7-50d8-f708-df6914656443@oracle.com>
Date:   Fri, 27 Aug 2021 15:31:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <8ea8ac80-3b13-77f5-f2c8-d4e0b044b20d@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0129.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::33) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR01CA0129.apcprd01.prod.exchangelabs.com (2603:1096:4:40::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 07:31:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ece0dce-0b68-455e-88be-08d9692cab7d
X-MS-TrafficTypeDiagnostic: MN2PR10MB3774:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB37742225A64615F726BDDF4AE5C89@MN2PR10MB3774.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sX5mDSQXq4CKDRoXEJZODTu7CupZcJHv+zlnQeaXlay8D2sO5/jgREzSLCI4jIgt29bwx0hUSypwIqbaOiJDxyRXcBITvKOUlMAYn4kR938R2m6+UIFuOBeY5T4S+foiO+fOrV/1KoVvFgNHsOMfEzOZmohi4ehQthZWBXeZ2Ea3SjRAeb91y7/2oDrcK77UDZLGw+hlNXuPzWFr9kXcS9EB0oZUju1bKobJFLw4B39OCn5tNrON107pn4xnFhldAGeG3bdT47wiBvZBvcaEY4RIY//i6SZ5ruEyzkRZYDd7PlEpWrBptwfSyWpRsKO5MYIAD0OI1M5dns9b2GhwdrsHjtKr0jj1TT1Biqhy2DrH8i2rYffkMUU+mEDSs9P26g5QER/mxrZciBl+3H72Q2rGFV/ckmByN4RfrPoyrVJSrapDFsqCdKCCjHEaMi9OQRiibOwgjv/4rTrhsdAmDxyj5wIOMpBHzs6okLibldcFP0nKIUV82SNiUxKYdRC3MBESfQRxef5Gce9qb2tC1jOEgdtbFfryNgKUU0MbC0GSjYtiHfNJxv0xDodIru6jKHtrJEFY5AbsQnEM0ZFzmaCXTyMj9JyKN5Vmnp1bgKhsTyFRvpgENouBUF+xmpx4XLhFQLxxb4UPwzKzzeO7DPWlAos4B4pGR3dechAixPLsiBk6vY5d914KHNxr1GRpgbjDW5s71JNyCdPWCvejyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(396003)(136003)(346002)(86362001)(6666004)(31696002)(83380400001)(31686004)(6636002)(186003)(8676002)(26005)(8936002)(6486002)(36756003)(38100700002)(478600001)(44832011)(5660300002)(956004)(2616005)(66556008)(66476007)(66946007)(16576012)(316002)(2906002)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUIvaTRZQVR3cmJtc284cE5nazcraFBrcTZZUFQrWEk5RlU5UUFHaDZKczVC?=
 =?utf-8?B?b0MwRjNWZzBFM2owVTBvU0hXdXQvNmZQS2F0azcxRmZKWGRwVVA5QnI0RWhu?=
 =?utf-8?B?TWo4UWlBMXp0cVY1cysrdWI3UkVPRzhOUG53dE8xQlZkSENsVnlRaFRucFNj?=
 =?utf-8?B?TFlXbkZOK1ZjSk9MVWVwbzlTam8yRzgrUFJQU1gwY0dhekdKWTdwRmZNQUg3?=
 =?utf-8?B?TXY0WWUvaVRoZVRZTXVnMi9MRm9WRGtIMVVpMmtpd3p2dDI1aFB5UmtVazRj?=
 =?utf-8?B?Y0l5L3ZtamdHZTVpWGxFOEhZTk9iSXZHMUF5OERydHFnQWg2UEcraVhOenVS?=
 =?utf-8?B?L0VPeGhFek5OVkt1cCtZbWcxdXkrZ1F4SmtDSjVvSFV3L00zWm91ZnFnMW9w?=
 =?utf-8?B?WGhISTJzZG5CYkJGVG1ZYVdIWE50cUEveHBiUTBSYWVPM05vTFQvUy9GTXda?=
 =?utf-8?B?ZXdOWmR4alJKQjRSWUtRazg0Zy9yRUg2dDI4djdhcXhHMzBIQkVMZnBoUloz?=
 =?utf-8?B?Q3U5UzJmanhJU2FwalRjSm1HdXBXVEJyYUxTampTU0ovV3dBa1IxOTNsdmNh?=
 =?utf-8?B?N1hSM3dnUUxqeWNuRHd0ak0vUG1CblVvc3JmR1hzTWFiU2hLRm5LckpqMTF6?=
 =?utf-8?B?cnoveEtnV0QyUkt2M0ZINkhJanZxQjR3d0VENUtzRlNLdmk4bnEzS0VvdGlM?=
 =?utf-8?B?alBHMnFYUG80cFBFUHc4REJ4b0c4L3M5TEt0eG5yd1RXcFQvSnVkU3FveHFm?=
 =?utf-8?B?VVM1dGcvcDRIblg0N2l3MUMzQmtiK1phY3ZLT0huMDFRVytRR2s3ZE82b1dk?=
 =?utf-8?B?SkFzWE5vVXoya1hoZFZXa1JpZVNrMjgzekwyanBCRXgvY1c5aHMwd0FkempT?=
 =?utf-8?B?YjB2ZnlGVWxPaTRPckN3eWZNVW8xSXpnTDBrWXRPeWxiNEF5dlFnMGNMT2hO?=
 =?utf-8?B?c1dLTUR2clpKV0k0bmxMQzllMkkvcWQ2UHZQUzY3VFBObVUwK0Q5eU0ybDBz?=
 =?utf-8?B?RTM0ZkwydnNOcmx0dERpeTJ0b1hHZUZTbVplODNiZVRsalNQWnE3eWdmYXkr?=
 =?utf-8?B?TFBSMm5PbkxobWhqaWppT1BUdFVKQTlBYzdtbnhiUnVNWEo1MjQwMVdDRFRz?=
 =?utf-8?B?VVMyTVVOR3crdlJoUnZlaEtrcVRqZno2bmZGVmpBVGpmMXJnZHdhVXVrVjFF?=
 =?utf-8?B?azJmTGlyNUhmK21KdWFaUnJ4MXQwWnhjTlFGSU01SnRHYmNzMW9JRU5tVVRM?=
 =?utf-8?B?Ykp4Uk5SUXpnN0ZNWnZES1lFM0tFRTJoRGFJRS84Q1RmcDEvc3orT29YY0ZT?=
 =?utf-8?B?UVJyMXlGOGRIdkFreGFsR29tbzZyTC8wVnVaY1pROVdlSm96SXJDRjB5NW9T?=
 =?utf-8?B?OGZycUhhM2V2TDc0bmk1cFRReVlKTzhLVjRYVmJZcVlkVWJwbFFNUkE4U3ov?=
 =?utf-8?B?eWJBZ0ZUa0hJMmdjYkFaRGw4WWora1E3NWlack1sRkRYaEtuUVBRdGlZa0RF?=
 =?utf-8?B?bEVDMWhmcldhZ3YwOVV6U3BCaXNXTnNralR2NmdBS1FpMzcwOGFEcVdTeTcr?=
 =?utf-8?B?cW5CTWR5SVBuV2VDOWJzTCsvcHBmNjFib0MxMmdibVA4bTBHRXFDVnp2QjU4?=
 =?utf-8?B?NVNMQ0Fic3RFRCtPR0Qrdk9JdklUMjBSN0tMYW81MUxhVE1TN2NmcjI3Ylly?=
 =?utf-8?B?K3B1aDJwMkRrNW9VdTkyNXIvSmo0TGpJM2MraWFtTFhWQkxPYVhqSFZacnZ6?=
 =?utf-8?Q?Rv34xk9yqyC2cA22Oz+iPw5yrjdV4GKVqyxeh1G?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ece0dce-0b68-455e-88be-08d9692cab7d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 07:31:22.8155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzwjgg+VYGUk8Kxu20t6NtEKmYyv3RHL1cCUY/RxAoFa6i1iGXgONE20EHqrhMMw6RPj+c8gGGPFenIkwIQf9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3774
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270049
X-Proofpoint-ORIG-GUID: fZz2yZ3Uj2Jjx1DEBBdwRI-v1iyOw7Ac
X-Proofpoint-GUID: fZz2yZ3Uj2Jjx1DEBBdwRI-v1iyOw7Ac
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



>>>> Yeah, I'm more interested in some reasonable value, now the default is
>>>> 2048 but probably it should be sectorsize/2 in general.
>>>
>>> Half of sectorsize is pretty solid to me.
>>>
>>> But I'm afraid this is a little too late, especially considering we're
>>> moving to 4K sectorsize as default for all page sizes.
>>
>> I am writing a patch to autotune it to sectorsize/2 by default.
> 
> That would be pretty good.
> 
>>
>> To test this, we need to have a filesystem with file sizes of various
>> sizes (so that we have both inline and regular extents) and run rw. It
>> looks like no regular workload (fio/sysbench) can do that and, I am
>> stuck on that. Any inputs?
> 
> Is that a performance benchmark or just function tests?
> 
> For the former one, I guess you can specific the file sizes for
> fio/sysbench.


  Right. Performance benchmark.
  I just found, in fio, you can specify a range for the filesize, which I
  am planning to specify 1K to 10K as it is the most common file size in
  a Linux root fs.

  sysbench does not allow to specify a range of file sizes.


> For the latter part, it's pretty simple, just write a bunch of files
> with different sizes, and use fiemap to check their block range.
> 
> Inline extents should report block range the same as their file offset.

  I didn't have a plan of writing a functional test case for this,
  but now I am reconsidering.

Thanks, Anand

> Thanks,
> Qu
> 
>>
>>>>>> Please fix/reformat/improve any comments that are in moved code.
>>>>>
>>>>>    I think you are pointing to s/f/F and 80 chars long? Will fix.
>>>>
>>>> Yes, already fixed in the committed version in misc-next, thanks.
>>
>>   Thanks.
>>
>> - Anand
