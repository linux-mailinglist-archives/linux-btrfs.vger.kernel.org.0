Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28061315FBB
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 07:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhBJGxG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 01:53:06 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:45778 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhBJGxF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 01:53:05 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11A6qDjt178575;
        Wed, 10 Feb 2021 06:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xSRmKBkOaYA+jFYlSwkZqdhcGm90+Ox+q9DTN7WtxX8=;
 b=K/IAp9wIBxvkAqLHYwmWB8maf8qJJtHZtW6N4KovtoNeJ/1i4izqR0T1oGO34oEuWgX6
 1W/DFWaea0undazt+mURfzhEtKyPz2ECUqfLspiH0s9KPWdldRacqWUn0j0che1QmBmX
 zaeOtzG6bgXoJwGhhmx2UyHS/N+VuluCBJY3yIASwuNTbj6CIBQo+1OlITwpxGGR6l6I
 JdooUZfJngpMqV4j2oNY1HOw5Aqef9qcBHlO+MylXSMANFNIz+RZsCI1aR7KQdl/WR6P
 K16bGdgLP6zcYzFOeU39Fjn8swsNW6HoHIPhD8BpXjbbzrNHcKl7EEVlQsn9yfkrJYqM TA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36hgmaj9qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 06:52:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11A6nw6M109471;
        Wed, 10 Feb 2021 06:52:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by aserp3030.oracle.com with ESMTP id 36j4pps342-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 06:52:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOB6oOYrQOjZoTSmdLNKRK1aeecCVNsiJHg3a8rCuU9AtzCIgV/Gxk9o3govI0oZVxfDkvqIy+c8p6juCQ6duZMOLRip6emuoCVjF7EIirJCPc0CithiD08B7rsKooGn9GmXKAbvyAbHSIRxtm03g6LvoCXddd5eb5wLOrC0LjL4Ea2ULbcjv3UZ8HWBYkunseAV+SEqiUaMCzRt9c8DlmdYlofz0amhugmoV0XXe7oJXIYcNMsSCP5AXDNmRmNf20uCg43nEpsLP+luMf1ajf8hV5HkosCgHJiU7yVUX+kZPPvgHdITtkGLknWcp5v4xn3K26bCoSrvWRqUBmR55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSRmKBkOaYA+jFYlSwkZqdhcGm90+Ox+q9DTN7WtxX8=;
 b=bUfHkxPxD9xMR1sztwM/aw2ts+rFPjdu0UjTKkNjOEaRzsuUL4ph6vg5TCx9mapTGDuLHH2P8FNw9+ICb7MXhvJf/8g0ZHGsmYdZAiVlVslWU9GQkLPU2DATEH05+YtyC4Ag6zDvOOk7wSS177OfUst6wDpS5ZUo6TD+S9Jlwg+BGEHab61RNNV0XhjKo6vv9jooQdJ9bn50LuoWprIj+0mxo9LiYGpP/tVbA66ehSlnGexo8V06nZJ5qMVKJtm9e74umLpuOrUg9K7V/i+QAarhlKzJ4qpV3zSDtInf84BD8KcOJVa1DfxnyFp4WQiTMTCa5s17RN+MzjL/CPQeyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSRmKBkOaYA+jFYlSwkZqdhcGm90+Ox+q9DTN7WtxX8=;
 b=NWlnbow6vHEwT+zdosAL3exAUCPd0mgQcIirjAaJTjRkThPPc3eD8UdWXkk15osBSjdPSP1Wcpb/6vWYV6eY777YHcG/T7gdq7coAIlxgg1Rft5AdOcxMzglMfJ0xCmdgURgzDuv3kIuMoD4eRfDCzVbjz5uTH9Y+yoGcWfrzN4=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN6PR10MB1345.namprd10.prod.outlook.com (2603:10b6:404:45::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.27; Wed, 10 Feb
 2021 06:52:11 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::9d63:7b79:33d4:a802]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::9d63:7b79:33d4:a802%3]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 06:52:11 +0000
Subject: Re: [PATCH RFC 0/6] Add roundrobin raid1 read policy
To:     Michal Rostecki <mrostecki@suse.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Michal Rostecki <mrostecki@suse.com>
References: <20210209203041.21493-1-mrostecki@suse.de>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <4f24ef7f-c1cf-3cda-b12f-a2c8c84a7e45@oracle.com>
Date:   Wed, 10 Feb 2021 14:52:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <20210209203041.21493-1-mrostecki@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:a91e:934b:cf95:4132]
X-ClientProxiedBy: SG2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:3:18::36) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:a91e:934b:cf95:4132] (2406:3003:2006:2288:a91e:934b:cf95:4132) by SG2PR02CA0048.apcprd02.prod.outlook.com (2603:1096:3:18::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Wed, 10 Feb 2021 06:52:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8f8933f-b52f-41d2-7f20-08d8cd9063f4
X-MS-TrafficTypeDiagnostic: BN6PR10MB1345:
X-Microsoft-Antispam-PRVS: <BN6PR10MB134557412F6ECD4A50B7B000E58D9@BN6PR10MB1345.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUollG35+Vi6pdbBxbvNgZJgrPN1jjs46SeTJc/tk6/OjwZMA601tWAVm50oWF0nFrAepU65kDGnBlYEaaM6S9Ko2cdt5y73z95ZdwfScWCH2ch2HPpRsrnt+mQ7adgm1TrdXNYRjl8lU1AlcbI82mKnUK2bLZ7dVixsCLmBErBji+ch/FqPH6oaAGDVH6MoDXKynu6u+e07efKvESTI9FJ8BTkkImXf9u4zwnXyIkywJjupyRmiCbvxbzjGt9cw9yV5fx80y2pXYTys/bIXmisbMVbah2PyNhCEfybQOLYrtpzL5ornuHzcc7P+MMNr010QrnRPC+Q4yfZhpsdwpfJzKnALvZ7wvOPSXeGU65xHHixiufYLlRFC4QZXeyhxZvKmnv6uFJJyT8cDDI8fgiFEd+gdoINz2G/giIntC2Nv5Hh4LCarRZzJIaM4B0qHCl8Byq6QJ4cNTDhWm60z7caKzHoh07wh+yHimh4G8fz6ui20/EvtVpM4bSpb0KZM7UF7N1irewgMzBZhqBY8VGDH4bZbbREoTEf3cTWW0Prb6pkdftFDtc7KiIWHDpIzvmYJujGtuA2dVRH11941oCYi6en6tCh57o+RgedhyeU+CsP9YlT+kEpxLf4FSI04my4Oq1r2jBgqpbklShBErsREKz3tv8TXpDftk85TMNibqYbfiY8kVjjm6ajKN4aE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(136003)(366004)(346002)(53546011)(4326008)(44832011)(186003)(478600001)(83380400001)(16526019)(31696002)(6666004)(8676002)(66556008)(66946007)(316002)(66476007)(2906002)(86362001)(5660300002)(36756003)(8936002)(31686004)(966005)(2616005)(6486002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SFNobTBodDUwZGFENUljeTQzV2U2OUpmS3RqcGQ3TlZxdGc0bnRzNWkwZXVV?=
 =?utf-8?B?MGlGQ005OTBLRDJpWTBJV2xGeUUvM21yV2I3QzhZSy9hN1RRV2xjc2k0Tlh2?=
 =?utf-8?B?d21STGxxcXhod2Vvc0wzeGFxQWI4dnV2bGFGYWFHUjJOUGlDaWlBZ051cUk0?=
 =?utf-8?B?TGhNTlkzRTNCbStBcnp2aEpaTmgwcXV0Ym9nNStycmlqeDNaaEc2cGczRzBC?=
 =?utf-8?B?TngwU3lyYlQ3M2hEaWVINXgzckFlSG1sMzBrU1lOb1AwRHhIQ0VOZXRzdWcz?=
 =?utf-8?B?WGhzd3lwOHdNUHlXUlpOSDFIbjNsRHQ3UG82N3dncXhmcFpyOWVTaVNkSmNk?=
 =?utf-8?B?TVRDR2RYWk1YTkpLSkc3NkloOENSOXVEZzltN0UrZUdXREc2bzE4clRmQk01?=
 =?utf-8?B?eEIvYTFqL3BqS2c4YTVZdUUxbC9lMmJRdXhpbElrcmJWbTkwWmdjZW10SkRO?=
 =?utf-8?B?TEgya21pVHNrTFJXckVpeVNRVVp3NXNaVHA3Wm1WVUsvbFpxb3ArRDNvbUgx?=
 =?utf-8?B?QUdmdWNTaWtIMTViREErM1BVd3g5dnBTVHpCVTUxWFdpM28yVjZrZXpQTTZG?=
 =?utf-8?B?cXQ5NU9SL0NHUHhOZ3FjOFo4M2pjckwvbFptbGk2QzJKNDdDb2pMWGdxOGlD?=
 =?utf-8?B?bG9JV0FPdmY3aE9tM0xPVGV5cGs1YU9zeEorTmNOVjZkYkkwNG5PbHZDMUxu?=
 =?utf-8?B?WnJEWGd0bHlHeTJ2QXFoNHQ5bjcrc0pnSWMwTm5HTXo3OG9CTUF2Qk8xMWN5?=
 =?utf-8?B?Q1BCYXZia2xlRnpRbng3KzRiVjhwZjRpOXJadFoxazVxZk9EWU5WWDJud0sx?=
 =?utf-8?B?YWVOWDNPSjV1NEcrV1YvVEFJT1BURTZKc3FrckgrOG9qOTFRamtjckRXSVhK?=
 =?utf-8?B?NFhHU3ZnYWhGOVRwK1R3aG1GZzFua2k3MGVZK0ZTaXd3RzBTN01oZ0xaNmFD?=
 =?utf-8?B?bE9rZzFNQjVHL0JFQS9mV3c1QVJ1azVlUWZHMXNtVS9nTE95Z0VlRGl0WlNV?=
 =?utf-8?B?c3RBSEJqODlCNkJtRlF0VWFpWWhYdmh5V21ZR0NLYTFHSTd3Q3RrbW43QUtK?=
 =?utf-8?B?VHZ2NU10UXVvV09GajRseUMrd2hWUW4yamtlb0lVZEh5RlJPZXhKa1FQaUNp?=
 =?utf-8?B?eEFzT1lmZGtpQ3hwd2RjK2Z1NGpXNCtRVSs1Ym84QmdTNkVnV1JIOER6SWEy?=
 =?utf-8?B?eUJXckc3VVIxYnFMY0pTMHBnQkFxUUZEZlFwMUJ1cmNrdXVmN3I0NWdhZUQy?=
 =?utf-8?B?ZlNyc3R4QkNZRU9XMzVqdUdDc2tPVlhybEFQd2g3WEdIWitnWXpBQVlpTzNC?=
 =?utf-8?B?MUdMS2FEbGg4M1JuekRUazkxYVl6eE5CVkFIc3JYcThVSlRvdVNDZWIzdlBR?=
 =?utf-8?B?M3laK1VCa2lCTjFrOXp2VW9uZkpLOWFwSDBkNkMvRGlWWlJLMzhQYVlKQzFh?=
 =?utf-8?B?R2pqZk1jM05kdEY1TlBUczBWYVRDUTFQRWhFajdXRjRUS1BzNU9PVzNSbC9h?=
 =?utf-8?B?T2xqdGhYVitGSWlQZTQ2S2JkUVVNSUZnQUlpVC80KzNJcHRlaTJiaVhvSEhT?=
 =?utf-8?B?S3FBVExBQlZRbm1FTnNhQkg0dXlzTVVzTFpOV081RTZyZDdWVU5GVlg5dmFM?=
 =?utf-8?B?Ti93TURCMkdnZGUzckVmVnBpWDBiMWJSb0RwSEI0RWdQak45SjdIeFNVdzRZ?=
 =?utf-8?B?d1FTOW1xZlllYnRVNi9WQmRwaC8wY2lpczVsTWFvaTh2TUFmcngxNUNuRWo2?=
 =?utf-8?B?QTU0NjhMNW5UazhCMjh3aHJ2czdiZW1aUzkzbHNDb28vK1duQXd0cmZ5M21m?=
 =?utf-8?B?RW43MVMzOEV4ODhMdFJjeVlGL2traWQzcnZudHRQdFlqRGczWUhNMUlub0o2?=
 =?utf-8?Q?WK1cj8kWHbHBn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f8933f-b52f-41d2-7f20-08d8cd9063f4
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 06:52:11.2306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjc2ZsDNFrRGUTGCyBx5uNXhHs14Cm/CB8+xvmGEG8+fsCW/Y7tkg60cQV2ntZYQiBfT5AJxn+7NB7WdhIE98w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1345
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100070
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100070
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/02/2021 04:30, Michal Rostecki wrote:
> From: Michal Rostecki <mrostecki@suse.com>
> 
> This patch series adds a new raid1 read policy - roundrobin. For each
> request, it selects the mirror which has lower load than queue depth.
> Load is defined  as the number of inflight requests + a penalty value
> (if the scheduled request is not local to the last processed request for
> a rotational disk).
> 
> The series consists of preparational changes which add necessary
> information to the btrfs_device struct and the change with the policy.
> 
> This policy was tested with fio and compared with the default `pid`
> policy.
> 
> The singlethreaded test has the following parameters:
> 
>    [global]
>    name=btrfs-raid1-seqread
>    filename=btrfs-raid1-seqread
>    rw=read
>    bs=64k
>    direct=0
>    numjobs=1
>    time_based=0
> 
>    [file1]
>    size=10G
>    ioengine=libaio
> 
> and shows the following results:
> 
> - raid1c3 with 3 HDDs:
>    3 x Segate Barracuda ST2000DM008 (2TB)
>    * pid policy
>      READ: bw=217MiB/s (228MB/s), 217MiB/s-217MiB/s (228MB/s-228MB/s),
>      io=10.0GiB (10.7GB), run=47082-47082msec
>    * roundrobin policy
>      READ: bw=409MiB/s (429MB/s), 409MiB/s-409MiB/s (429MB/s-429MB/s),
>      io=10.0GiB (10.7GB), run=25028-25028mse


> - raid1c3 with 2 HDDs and 1 SSD:
>    2 x Segate Barracuda ST2000DM008 (2TB)
>    1 x Crucial CT256M550SSD1 (256GB)
>    * pid policy (the worst case when only HDDs were chosen)
>      READ: bw=220MiB/s (231MB/s), 220MiB/s-220MiB/s (231MB/s-231MB/s),
>      io=10.0GiB (10.7GB), run=46577-46577mse
>    * pid policy (the best case when SSD was used as well)
>      READ: bw=513MiB/s (538MB/s), 513MiB/s-513MiB/s (538MB/s-538MB/s),
>      io=10.0GiB (10.7GB), run=19954-19954msec
>    * roundrobin (there are no noticeable differences when testing multiple
>      times)
>      READ: bw=541MiB/s (567MB/s), 541MiB/s-541MiB/s (567MB/s-567MB/s),
>      io=10.0GiB (10.7GB), run=18933-18933msec
> 
> The multithreaded test has the following parameters:
> 
>    [global]
>    name=btrfs-raid1-seqread
>    filename=btrfs-raid1-seqread
>    rw=read
>    bs=64k
>    direct=0
>    numjobs=8
>    time_based=0
> 
>    [file1]
>    size=10G
>    ioengine=libaio
> 
> and shows the following results:
> 
> - raid1c3 with 3 HDDs: 3 x Segate Barracuda ST2000DM008 (2TB)
>    3 x Segate Barracuda ST2000DM008 (2TB)
>    * pid policy
>      READ: bw=1569MiB/s (1645MB/s), 196MiB/s-196MiB/s (206MB/s-206MB/s),
>      io=80.0GiB (85.9GB), run=52210-52211msec
>    * roundrobin
>      READ: bw=1733MiB/s (1817MB/s), 217MiB/s-217MiB/s (227MB/s-227MB/s),
>      io=80.0GiB (85.9GB), run=47269-47271msec
> - raid1c3 with 2 HDDs and 1 SSD:
>    2 x Segate Barracuda ST2000DM008 (2TB)
>    1 x Crucial CT256M550SSD1 (256GB)
>    * pid policy
>      READ: bw=1843MiB/s (1932MB/s), 230MiB/s-230MiB/s (242MB/s-242MB/s),
>      io=80.0GiB (85.9GB), run=44449-44450msec
>    * roundrobin
>      READ: bw=2485MiB/s (2605MB/s), 311MiB/s-311MiB/s (326MB/s-326MB/s),
>      io=80.0GiB (85.9GB), run=32969-32970msec
> 

  Both of the above test cases are sequential. How about some random IO
  workload?

  Also, the seek time for non-rotational devices does not exist. So it is
  a good idea to test with ssd + nvme and all nvme or all ssd.

> To measure the performance of each policy and find optimal penalty
> values, I created scripts which are available here:
> 
> https://gitlab.com/vadorovsky/btrfs-perf
> https://github.com/mrostecki/btrfs-perf
> 
> Michal Rostecki (6):


>    btrfs: Add inflight BIO request counter
>    btrfs: Store the last device I/O offset

These patches look good. But as only round-robin policy requires
to monitor the inflight and last-offset. Could you bring them under
if policy=roundrobin? Otherwise, it is just a waste of CPU cycles
if the policy != roundrobin.

 >    btrfs: Add stripe_physical function
 >    btrfs: Check if the filesystem is has mixed type of devices

Thanks, Anand

>    btrfs: sysfs: Add directory for read policies
>    btrfs: Add roundrobin raid1 read policy
> 
>   fs/btrfs/ctree.h   |   3 +
>   fs/btrfs/disk-io.c |   3 +
>   fs/btrfs/sysfs.c   | 144 ++++++++++++++++++++++++++----
>   fs/btrfs/volumes.c | 218 +++++++++++++++++++++++++++++++++++++++++++--
>   fs/btrfs/volumes.h |  22 +++++
>   5 files changed, 366 insertions(+), 24 deletions(-)
> 

