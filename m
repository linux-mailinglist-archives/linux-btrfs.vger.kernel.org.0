Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043E230F334
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 13:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbhBDMdH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 07:33:07 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48516 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbhBDMdG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Feb 2021 07:33:06 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114CKOqB190238;
        Thu, 4 Feb 2021 12:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Fj6gToatyDOgCymQOgNc2FU9ZMGK2tZ9fM53+v4RV5c=;
 b=y2Gl2StJ82IaSsue5AGAWsvE26JZgcuk1VWBohbp4uJnRV02j9uj3YNdpEXvQMIXtfO6
 wFNdSfAbPTUemq1boYmVCItlZijKQENb5lWQ8DXfEMHDoKC4nbqvxR+IKx/lCF3L23ug
 UcftS2W5FWMscU+xGuA/qFPpg39fYCbeqE/U3AWW7lAtNCOfMVmglR5FQ/vzVTc0sW3Q
 1tZGQMlAHxGthNtcvcM/hyynIE9pJx7iqd9PyQB8OZQ4Y0u0ebfOFu2tEwUeAmvlythS
 G3j/8WeJOrQhvjGbHvCRfAYIOKc7gmdjCIllhcZ+6CnFAFmg7/909XDUfAkbV4jALzKc 3g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36cxvr7prh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 12:32:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 114CEego072894;
        Thu, 4 Feb 2021 12:30:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3030.oracle.com with ESMTP id 36dhd1a4ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Feb 2021 12:30:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwYZjWBS7Br/+HOI5Bxnse6NTwrftxd/c9j8U/hNtxEY4oNwfigw6IYS10aOfRsL8iiWwtQykAtTjccaJN7Pu5j3qvfjJvs4hk+0YIzrM8nwYgruHrjYGjRS8/cFG53VTXfevIxAn1V1Yllo2Vpu3iMgDQmAl36scvP8S0Rk8UeiWrQuv54GSVcEyWUldkgdrl8IJbeaFa9RQUuVUavm6893hKS+ukluqGKn/7bP0NQzHTPSlBDJvhuaBVWK7rS0BpkseS8CwfPqNY5ZFokO5akWUJp8iJbHtsTQUY7ptLAf6wJHlkBhNjjxt2R3abUjxUEizeTwupBv/Gyhg3IlhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj6gToatyDOgCymQOgNc2FU9ZMGK2tZ9fM53+v4RV5c=;
 b=OkhOLnVsthjhL62jcm5vWAw4PzKkB5w305BnI02j6YdL1DXA2TVmaVNEP6RgYdtzOcAAsug3PZmDporUWutxBTjjGbHoAHkBEoswFbi25Y9ZQtuxMIhu+lZEZywMmAFqE6fhL5UVP26InlnSvRXa+HETbW/4a6IaQfRISzV7llHSqvv8UsuKrSrKdgeh31nc6aJuMqf4eKksJg/XF2nzQ+b0pZEjgsABjPHLdONQL68dadLcK+U0VjVvXrMM7r+ELpULTf7xih1/5z7EZUZOsBJXVs27XUcWgJ6setFaOKR9/YL5yfgPsimkP+UJURelUyUAuXP2nP6oSj0K0YAHRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj6gToatyDOgCymQOgNc2FU9ZMGK2tZ9fM53+v4RV5c=;
 b=inympqKs/2V/jcwpP132smYDyIULv+LJQ2nheo4zA8SVTf7LYV7EmQvgOBJDYDNy3zheCv8sDnjA85B5hsCzNI/usoeFRH6JoKnKSZ5aVGBxWDaMAnRXb/ZUblUT8DIqRtBQKxOWvPDtrytaz/N5AAA4KEU3/z/YkJ0CLgkUYXg=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN0PR10MB4840.namprd10.prod.outlook.com (2603:10b6:408:12b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 4 Feb
 2021 12:30:12 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3805.028; Thu, 4 Feb 2021
 12:30:12 +0000
Subject: Re: [PATCH v4 1/3] btrfs: add read_policy latency
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, mrostecki@suse.de
References: <cover.1611114341.git.anand.jain@oracle.com>
 <63f6f00e2ecc741efd2200c3c87b5db52c6be2fd.1611114341.git.anand.jain@oracle.com>
 <20210120121416.GX6430@twin.jikos.cz>
 <e46000d9-c2e1-ec7c-d6b1-a3bd16aa05f4@oracle.com>
 <20210121175243.GF6430@twin.jikos.cz>
 <28b7ef3d-b5b9-f4a6-8d6f-1e6fc1103815@oracle.com>
 <9f406301-c16a-72a5-4ff3-d3bda127895e@oracle.com>
Message-ID: <34cecc3d-235e-2f47-0992-675dc576b5be@oracle.com>
Date:   Thu, 4 Feb 2021 20:30:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <9f406301-c16a-72a5-4ff3-d3bda127895e@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2406:3003:2006:2288:e4f7:64fa:960b:70be]
X-ClientProxiedBy: SGBP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::17)
 To BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:e4f7:64fa:960b:70be] (2406:3003:2006:2288:e4f7:64fa:960b:70be) by SGBP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Thu, 4 Feb 2021 12:30:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5fdd1c7-88b7-4a86-f03e-08d8c9089dcb
X-MS-TrafficTypeDiagnostic: BN0PR10MB4840:
X-Microsoft-Antispam-PRVS: <BN0PR10MB4840EC0246155CC8AC9A997AE5B39@BN0PR10MB4840.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJsc96cugjttnMK3N87WhO9RlorlTEYOZZ37ZtdSWKyVC+vyoFahS2LDEImKju1y7Aopk1cHkAsg6OL0n6KF1/7rpUpgTvKWZKpVrxRwwwdNJU0dHnClxlnoJTGkh2uUwCDJCjlaG5z0qakoC+GZnkxojlGPv0fVrF9R1lHaSrEunudbQqyfMbw6uQfKWhkq7WSDo1LPPe9qV7AzyARLjOW1hCb97Jvnhrfu1K2KDQQC6jrh+/Eh6DnUI/UtQ3Bsxu0YzSq/PWY61MfKPCkdqf6UpxEntUSAOrvCXv/4y6HKaXShgo65UoIJ/c+cfrerhnbAIEMbcMNqgH/PXMivzNNTR6KANobQ8q32Sbc97o58ceuQEyqnx7gY6matoiLLgm2Yo8XNIr7o4ugjE9lk588ZWIZj+xg1ze0Ev/sWtfvffVcihMSfxLT0ssJ6KON+rjaUQ8YdZurtlR9msPlDM3r8LJzkwyOgnMjQENPJFLxC2JivApPzMXXH8bPaZl5sGQf7LRgASX8zaHWb0UZwXEOQqeGFl8jE8R0q8mWxzWur+bzp5AuFvRpJ8YPaoskc+UWhvbdaJ9KRCqYr01Hfl0z9RBl3VtA11I3CTl70CaU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(396003)(376002)(366004)(186003)(6666004)(31686004)(6486002)(316002)(16526019)(36756003)(44832011)(31696002)(8676002)(5660300002)(53546011)(66556008)(66476007)(66946007)(86362001)(2616005)(478600001)(2906002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RWllSWxubDVOTW5ZMlN1dk9YWFNad3lmUjJKZVFkTWE0ZTZ1cG5jY3NnMGVF?=
 =?utf-8?B?czhhNUF4QWNvdEtoZ0RhN2hPVGFEcCtvVW9UdGgrdXZrZUd0R0xPY3hzZmc4?=
 =?utf-8?B?aCtBNWZiZEpRTVpMQXlkN2IrSzFXSCtYa3dDa3E4TFhhRUlXRUkxOXdKczNM?=
 =?utf-8?B?Q25Uc2laanRZdnBGRW9QYTZEWXQ1Ym1QSXh5azVucTdETzBVdDE3c1ZhY1ZJ?=
 =?utf-8?B?SDhiUzUxY1ZBOHU5d2ZyNkg1SWFqeExFd3d0MzEzOWxBRkJyejJHUlZoTUlN?=
 =?utf-8?B?VGs2M1F0MVZSOVNnOFhSSFFTaDk3VVQ0UkFiTjFLS21xQ1Iycmx6VERRUGRq?=
 =?utf-8?B?eVgyakhsczRRV3dLa3JoU0NaeHZYZ0FSWExSVUJkOHFNSXpaT3o2bzBvdGdS?=
 =?utf-8?B?cXFBTUk0ZDUzR3YwV0w3YmpwaFpTWko4cnM1TlJ2Mjl3TzRMSlpHa1hpZ1ow?=
 =?utf-8?B?NXFGV2JRWGt0ejRIcW5XYlpOY0s2eU05bzRvWGxNUy9hQVFQcFZTLzJTRm4w?=
 =?utf-8?B?YlFwMi83b05mQlZrWHp3dU95L3dmeTJhRy9KeUJiOTBibkszVTBuS1AyZGlv?=
 =?utf-8?B?cW9ETEVtbDhiK0thYWdsVkd4K2p4cWdwK2Z3bUl6UWtWWUtJWlA4bGlLQXFF?=
 =?utf-8?B?TlJIdlFadDVvV2pVTHlWeXNKeGhzWUoxVUlIT3NnQlNIaFh4WXNjdk5VS3B4?=
 =?utf-8?B?L29oVytaZkpUdm9vcXJCRElpYTQ4Tlk5MllIYmpCV0JTNzFDU2JRTTVEd2g3?=
 =?utf-8?B?aGtEWUdtQlRKUzVYV1pBdFJ3dXlKNTZTcTVkdkVJc2J5WGMycXI3NTFMS2N5?=
 =?utf-8?B?UUFjR2xRT1hoOUNkak0wNWwxdm1WMFVaa0RyVW5VZmZ5T0lwaE1RYStQTStM?=
 =?utf-8?B?eStNbk9WUDFhckJ0MmtkeW1MbWtxb01Jakg5VzJTa0NIK3lZYzZ5WDA0ZDNJ?=
 =?utf-8?B?ZVRvSWxoQXNlcnhXemErck9lTlRaNVJQaWFoRDdLU1NIYTJObDJpUS9LUThz?=
 =?utf-8?B?b2l5TmNBbUhEdzlxcm9PTGduMEJOaGdobHBXazh5Rm1hMWhoSzRjZlM1Mkls?=
 =?utf-8?B?eWZLbXl4Wk1MZ3QreWtCc0VEZGwzRG16UkxPbzJmdktoSEpxYUFlaVVvWXhB?=
 =?utf-8?B?bFdKdUQvaXd6WEdya3lwUDlpODF5cWFNYWV4T1dmRmRRRklYUWJHM2dMaHQy?=
 =?utf-8?B?UXc4bGZ4NHgwa3NnQlBTZ08zaWN0OGJyR2VJdEFrSmNMenVtYnJnZUorVjlk?=
 =?utf-8?B?ZUFVWlhmY25SQjc2dnhyTFkrWTR6aVBQbnp1NDNDSHBmcStPTkVWY0dWaHBh?=
 =?utf-8?B?cnZTZDZ3YmZaaU1zOVYzUFJpb04xRmpZZ2hQbGhEOEZDWkhQR2pkMzV4ekp4?=
 =?utf-8?B?MzI0Y0hrbE0zdDhPeDZ5eVVjZ3UwRCtMQmlpdXl3TWhRdmpKZHhoeWRyOXdk?=
 =?utf-8?B?M3RVNHpvcWMwYndEcW84UjJwcVhReXdCWDNndDJydHhtTktFck5BZTVBL0Uv?=
 =?utf-8?B?amZESGczSlVMcTdlYVJLUTU3a01XeGlTaTk4dmNvVEVEM3cwaFIvZVZiZlFs?=
 =?utf-8?B?U1ZNME5vVUdsVm9IRnB6MjZvOXc1VEtPa1k4VmVvK24xcDc2ckMrd2p5RDRB?=
 =?utf-8?B?R01EYnQ0UmhLZXRiN0FKZlEyalRZMGRzb05GMTJJcU9rRld5bGR1U3M5QU91?=
 =?utf-8?B?SXJ3c2dONi9TVjkyYXFEdlR5NXdEQUxUYisxQmtPMzlHY1pZUjUveUZDd2hK?=
 =?utf-8?B?bHJBMWVqbE9mTmpWcjcyb2lLRGpUa3ozN1cxMGp6QmF6Z3NVMDVURWp1RjJi?=
 =?utf-8?B?Ty9pYjFqQ0xMZXZTdHVPU3p4Ny9nYTNQSm5VRVlDZkNaUUcwRk94QWREa1Q4?=
 =?utf-8?Q?DWm8Qwtj12RpM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fdd1c7-88b7-4a86-f03e-08d8c9089dcb
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 12:30:11.8654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N529XG/Jm7Z2zKgeGQFU7Q5Jo02XBkg1LoNIRYM1b9S2uG9/Wwesk064HfwbzPM/g8IaJRdm10WwrFCN+Lj3lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4840
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040079
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102040079
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hi Michal,

  Did you get any chance to run the evaluation with this patchset?

Thanks, Anand

On 1/30/2021 9:08 AM, Anand Jain wrote:
> 
>>> 500m is really small data size for such measurement
> 
> I reran the read policy tests with some changes in the fio command
> options. Mainly to measure IOPS throughput and latency on the filesystem
> with latency-policy and pid-policy.
> 
> Each of these tests was run for 3 iterations and the best and worst of
> those 3 iterations are shown below.
> 
> These workloads are performing read-write which is the most commonly
> used workload, on a single type of device (which is nvme here) and two
> devices are configured for RAID1.
> 
> In all these read-write workloads, pid-policy performed ~25% better than
> the latency-policy for both throughput and IOPS, and 3% better on the
> latency parameter.
> 
> I haven't analyzed these read-write workloads on RAID1c3/RAID1c4 yet,
> but RAID1 is more common than other types, IMO.
> 
> So I think pid-policy should remain as our default read policy.
> 
> However as shown before, pid-policy perform worst in the case of special
> configs such as volumes with mixed types of devices. For those special
> mixed types of devices, latency-policy performs better than pid-policy.
> As tested before typically latency-policy provided ~175% better
> throughput performance in the case of mixed types of devices (SSD and
> nvme).
> 
> Feedbacks welcome.
> 
> Fio logs below.
> 
> 
> IOPS focused readwrite workload:
> fio --filename=/btrfs/foo --size=500GB --direct=1 --rw=randrw --bs=4k 
> --ioengine=libaio --iodepth=256 --runtime=120 --numjobs=4 --time_based 
> --group_reporting --name=iops-randomreadwrite --eta-newline=1
> 
> pid [latency] device roundrobin ( 00)
>    read: IOPS=40.6k, BW=159MiB/s (166MB/s)(18.6GiB/120002msec)
> 
> [pid] latency device roundrobin ( 00)
>    read: IOPS=50.7k, BW=198MiB/s (208MB/s)(23.2GiB/120001msec)
> 
> IOPS is 25% better with pid policy.
> 
> 
> Throughput focused readwrite workload:
> fio --filename=/btrfs/foo --size=500GB --direct=1 --rw=randrw --bs=64k 
> --ioengine=libaio --iodepth=64 --runtime=120 --numjobs=4 --time_based 
> --group_reporting --name=throughput-randomreadwrite --eta-newline=1
> 
> pid [latency] device roundrobin ( 00)
>    read: IOPS=8525, BW=533MiB/s (559MB/s)(62.4GiB/120003msec)
> 
> [pid] latency device roundrobin ( 00)
>    read: IOPS=10.7k, BW=670MiB/s (702MB/s)(78.5GiB/120005msec)
> 
> Throughput is 25% better with pid policy
> 
> Latency focused readwrite workload:
> fio --filename=/btrfs/foo --size=500GB --direct=1 --rw=randrw --bs=4k 
> --ioengine=libaio --iodepth=1 --runtime=120 --numjobs=4 --time_based 
> --group_reporting --name=latency-randomreadwrite --eta-newline=1
> pid [latency] device roundrobin ( 00)
>    read: IOPS=59.8k, BW=234MiB/s (245MB/s)(27.4GiB/120003msec)
>       lat (usec): min=68, max=826930, avg=1917.20, stdev=4210.90
> 
> [pid] latency device roundrobin ( 00)
>    read: IOPS=61.9k, BW=242MiB/s (253MB/s)(28.3GiB/120001msec)
>       lat (usec): min=64, max=751557, avg=1846.07, stdev=4082.97
> 
> Latency is 3% better with pid policy.

