Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFAB436779
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 18:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhJUQV1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 12:21:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13210 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231933AbhJUQVU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 12:21:20 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LFIPmh017614;
        Thu, 21 Oct 2021 16:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kLDKsYuFvsRQlU97e5axnhpZAAN8n20Dp6z7qF7aD7g=;
 b=e74a2+y4hSn/lvR41iDoNPFR5ZfZ07zF/CRd+pIdnH251TWAbzq2964sHudetaNTXDbd
 j6QwhNsXFFLVN76RY/WGHCYoFF8xfO7pIKrurbi5zkXfHduGdx1WqObqVnuEK6cuGc7/
 q8LnC6yh0uZtkFquOc2d2JK0YxTebuzxR5i7pQ7Ds5hcw2yE+h4GOz9iR6WFmRnQbAxY
 WnroszHN35qOfLp3XmsLbpbdpCmgrBX/UU6oz05YUBW+GHQ/wudKoegEKF3q9K2/HGWX
 MVZcrBHh06iJkiBLOV7NPUj+a6+Yxc44vOzA+yIqHkD5eovjTEVMMMGTuWiLfAlcCF8L Fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkwj76tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 16:18:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19LG0v1u119983;
        Thu, 21 Oct 2021 16:18:46 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by aserp3030.oracle.com with ESMTP id 3bqmsjeffn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 16:18:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhDyx/CWeQ6zAx9OS56OFfOsP0V8RurrsVTuFUOUmGRO3E8MYv25w3CIwRloZonGMowRa3mPEScFfoa4z32KDUYTQirvQqFKJJ8exmPKDiznIq+Z1pWl/cdkjV7FitLjJ5mibisrjpkJiVDWJE5NaWa+rm2IRA3CbhxIS2G9huZGC0rL8GS+9B3BCJ54t1Xm3/YJuTbG5SE3m2Q/z6hyJmvd0OqF+rTpqfXvpdDl76CAzRqol7zVwJhM+/lvFDBWzE9PX9V/+gNDT45mqxr15yDzoHKRXJI72rUesH5qdzRf6pL8aIAEagSiCFNb+Dj9InjfoglLVBYysalzLUco/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLDKsYuFvsRQlU97e5axnhpZAAN8n20Dp6z7qF7aD7g=;
 b=IMwouWKWwaXPOWNapgMCLu9oC5RpyF6a5D96AvFQirECnvA0nwikVDfgXeobzT02i3QtXQF9p1HfQov/2P0IkFrGWa9kFc8bFywV8b+hUED5wfHH07Ftqrys+KMJUKiMIa/WPc8b2rNmyusBPJir/uQr2okdyHWwPV2wtikWYcEkDQD2bM8zZnHrCnZAL3Jk6rcDOMmCijBv7FNreAi6F4xXA6KiAUFNsHsLrEVvQbqb3us0GapxEhBcT7eXt0dv8tbuFdfk7RJMsu/XHrOW1UBkhaf5XRdsCKmu57p7jEomAMSUUDvNVMzURAat5MzIECpW7PNiI5NbrqHGRQQFMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLDKsYuFvsRQlU97e5axnhpZAAN8n20Dp6z7qF7aD7g=;
 b=IuB11CRxkds8y1BBbP9IWtGt19luK8Acs7FYeSfe7rTXpEXpBw+Dev3u5wW/Dg+3fewlsjwRTV5fFVIyeLXcZpFENpCc1tu+m7K1xZVV8IvfaVYPz+rmvtcN3PdHwbPXiV/Bp03v9AFmEpf+HiPYG9gg6nAe9pw0RbLPzrA9W0k=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4045.namprd10.prod.outlook.com (2603:10b6:208:1b7::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 16:18:44 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 16:18:44 +0000
Message-ID: <d436f663-2b9b-1625-3de6-1b29130de8bd@oracle.com>
Date:   Fri, 22 Oct 2021 00:18:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [btrfs] 0f80799866: WARNING:at_fs/sysfs/file.c:#sysfs_emit
Content-Language: en-US
To:     dsterba@suse.cz, kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <f748bd08259e2b770a5d9f2355c58c33d8566d16.1634598572.git.anand.jain@oracle.com>
 <20211021133538.GA16330@xsang-OptiPlex-9020>
 <20211021160648.GD20319@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20211021160648.GD20319@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Thu, 21 Oct 2021 16:18:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bcb32ab-0e88-4626-990e-08d994ae7436
X-MS-TrafficTypeDiagnostic: MN2PR10MB4045:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4045298432F642576444C1BFE5BF9@MN2PR10MB4045.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RBMpppS9hJlyj544tfAxa+I0V734oI6GxKXlmVmFOK7bZOlMGp3c7ktW/dtISgXcx5eECvb3MjWrqqQ6rgXoxpcBt4ox0ZZ0RNGk3oeHo7GBNPnEWSX77ngsN06H6/ekxOXeTQFOkOclOB4DoO+PEBn17NQ+EWRCVQrOG2TQBrTej1MnX3OrxiuKInMnyuJP4u0fV/A9I+2dMzRZ0AhXnVkiieYh2z2iiRwuxhzHxLeYT6P+RcA0L/YLk1qeZWr/R+b87Xn02zlnviAdSqJhOFcGxZenEiIaP8j94D5MYm9ZZ5WNZwVXg9QNQr5N4+YGDyE1H9BSLs1o5hrb4Ka8J5C1t2GiJbDHtzTCbfgnKDfKkGBYb+tP4MrdeljIELg/5HD+wT96Q9b2Kco7R9Wdc68T4zHZEUXAEuoULFhEqRvGHmqzP6Xc8wiczLWk/h16IcbTwsY+pEW4rmmXqlBNS+9PGwbdNealb91KW74cXXiIXU3ihw4AcxddB7YxevmEb4kbEHWjbyjdMqJSj8uajo4NPjHlC3YJb+GDd2UJTsOZ5Z86VpVKEyObrHA9rQc34kPXTZLrVPEyvYRdr2+L7aWttvN8OGXx6Mnc+kFpxUikkBelGOb81hDOO9eUrpZgKefAkU5xoidbjPwM0UdTBEQeL4I/6Kn+n9cCt8u9f1rPN/xj6S4KS3R2d5F/hqqaMY693iNYnYDX3XjAaMoX3j5qILER4/eNsTkqutS/fzs6ur3JGIXY9viEa+h/ntXgIpVskhS+Ec6pRDVwyRkdj6IzXUeyKrMIN8PPTo8g7jUTTd02i9WSEXFZffTkg3AvkjcV3n4W/mPnAtyAkMcgVAHPJHSDIbQy9bLYQDPvYtODm9l2dgPAifjc0VH5+c4q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(8676002)(6666004)(956004)(2616005)(2906002)(316002)(66476007)(66946007)(16576012)(26005)(508600001)(5660300002)(8936002)(4744005)(38100700002)(36756003)(31696002)(83380400001)(44832011)(6486002)(966005)(66556008)(186003)(53546011)(110136005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUR0UWRJQUJWcm9nTzgxaGFZRWtXOUpmY2tmeGZsOFlYYkIxcVB0dnBGTG9j?=
 =?utf-8?B?MGVGSzVLcHBHM2pNOXgzaThwUWVGUndzejU3V3JXSUJBMjkvK3RZY1hzWjZ1?=
 =?utf-8?B?dm9EbGZ6cXJER3Z4cUNzc3VzSTZmaXJjWDVJSDVQY3Y3M0NFdVFVMUVGUmRJ?=
 =?utf-8?B?eU51c29STTVqRWN2TGlQdzRsL2JHdUg0QzZxd1Nzbm1ha1pLNWh5QnlxampQ?=
 =?utf-8?B?dUNISm9laGgwT3Y3anBGaGQrek5hOWQvbmhNWDRnKzQwNVB1ZldIem1CWENx?=
 =?utf-8?B?VlJIaEVJVms1ajRjTVdwRDVIeWFSODREbjFtQ3ZEZUFTTVBWMXF6dWNvWjNW?=
 =?utf-8?B?cDBScnlCVVB3eXlUSlQ1WGtTL2twVThra3NmQTdYaUplRlNYSzRIdTk2eE15?=
 =?utf-8?B?dXJ6dGtVa0ZRSVgrUDUvb2g0U0VFZ0kweDVHYmFQR2w1RzYvNnBQRGpPLzdM?=
 =?utf-8?B?K2kzNXpDUjM3OVdEaFoyYlU5eEhwdVNyWnhaY1VDOGw4ZXdFV3BhUVEzQXFl?=
 =?utf-8?B?czAzZkVud3ZCVGpHdDQ5Y2hLU2RwOURRUGdtNFNQTGFXZ1ZjQTdZdnNlNGdV?=
 =?utf-8?B?bUtrYU5nc3J3dm5vZXE0end3WklIekFkeVR2cmxWck9SWm9pakwyM2h3Q0tG?=
 =?utf-8?B?c1FmZXN1amQ2Y1I3Ym1nRUtsZis3RTdYLzVOTm1yaDI3TkVSci9zelM2WGhT?=
 =?utf-8?B?bEZqWTh3M25MUUNNeDVnUkdkQWZwelR3Q3dPckZ5UDJ5alY3WndVdmV0Ulpr?=
 =?utf-8?B?dy9lRGJQdjNLVVZHSjM0ckowZ1FaSzE5am50UzREYVVTT2p5OW5mUUVwb2RQ?=
 =?utf-8?B?VnpyQW92aEdNTklTU0lRSzFraVQzdjVFTXJmemU3UHZwak5rN0VqZkpJQ0dH?=
 =?utf-8?B?YmxWVDExSWYwaXMrc28zMW55SkNNYlV5Wmxad1hMU2F5VERnV3gzZWV4MmJD?=
 =?utf-8?B?RUdzOXhZenQyL0pDWFlsN2ZQWG15L25tZExlOTBCQWJ0d2Nyc1NWeVhDblN0?=
 =?utf-8?B?YVNwZXkyV2dBc0crSnZrV3h6SW9QSnhLdmVuZWtGc091U0RJV0h0V2o4Vzh2?=
 =?utf-8?B?cjVZbkV4YlpvYndSTHJodlBTY3ptNG85bEdBT1U4L2hyWGJ1V2d1VlYzVGNR?=
 =?utf-8?B?dnVFTjAxT01HbXRFYmVyNmNXT3EwTXRzcmFNV0Z4cnA2R1BYTytIQmd6aWk2?=
 =?utf-8?B?eFRsZDNMakloZm5yS3FsMnVhZEx4TmNCK3QrYXh2dThIYWlCcGhiTkc5cm1R?=
 =?utf-8?B?eGl0eUR3akdmYUdmQU9XWmRKSW5QTEdmVTZQRUsvNGZ3Tjl2L0t5Wmh6M3Nv?=
 =?utf-8?B?QVNPbWN3K3VTY3h1S2k4RUsyY0NBd0JqWWxBTStQa0dhT2F5SC9EZkNvWkNr?=
 =?utf-8?B?eEZsdnplUUhLc2Nud0dsTE1Ic09jcXFLcmx6dlFUcVJ1Qlp1aDF3M05hMVRq?=
 =?utf-8?B?NnFxTHJPNjdiVWI1RURSU3pSQUdTRTM4WUloZXFVZU05TW1TdGcvSTZxRjAw?=
 =?utf-8?B?WHdVZ1NCZGpZV0szckwrNktqaytmYXF4eDFzUnJKbFhHcUhXQXd3amM4SDFs?=
 =?utf-8?B?a0tyUVhINHBtQzlSczdidUY4MCtRZGw1T3NkdmhSTVhsV2VVRzhIVEJlbk5a?=
 =?utf-8?B?cnhHSGdNYTJUNWpoSDcvVTl3MGkrcDlKVWtRVmdHUXhOQUZoeC9yMlUreEpC?=
 =?utf-8?B?THo2TlhpL3Z3RHorTVRmOEgxd2lHTUQvZ0dBbFRUeEFYL2w2eGNzYnJBaTFW?=
 =?utf-8?Q?bCSFybE30F5x+D+2B6AACqaZfQDycuCglU6fJZZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcb32ab-0e88-4626-990e-08d994ae7436
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 16:18:44.8852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4045
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10144 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210082
X-Proofpoint-ORIG-GUID: neY5RAX1B-hKWc6BBEAP6DyklEVXN06u
X-Proofpoint-GUID: neY5RAX1B-hKWc6BBEAP6DyklEVXN06u
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22/10/2021 00:06, David Sterba wrote:
> On Thu, Oct 21, 2021 at 09:35:38PM +0800, kernel test robot wrote:
>>
>>
>> Greeting,
>>
>> FYI, we noticed the following commit (built with gcc-9):
>>
>> commit: 0f807998661ecadb74638c18cbaff8785bb46f8d ("[PATCH 1/2] btrfs: sysfs convert scnprintf and snprintf to use sysfs_emit")
>> url: https://github.com/0day-ci/linux/commits/Anand-Jain/provide-fsid-in-sysfs-devinfo/20211019-082356
>> base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-next
>>
>> in testcase: boot
>>
>> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> I wonder if it's related to the 32bit host, I don't see any crash.
> 


We are hitting this warning:

int sysfs_emit(char *buf, const char *fmt, ...)
{
         va_list args;
         int len;

         if (WARN(!buf || offset_in_page(buf),   <====
                  "invalid sysfs_emit: buf:%p\n", buf))
                 return 0;
<snip>


The input buf wasn't page-aligned because it wasn't part of the show().
