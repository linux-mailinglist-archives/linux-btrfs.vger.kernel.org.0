Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B990495CD7
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jan 2022 10:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347989AbiAUJ3V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jan 2022 04:29:21 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:11734 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235199AbiAUJ3U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jan 2022 04:29:20 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20L76HM8001018;
        Fri, 21 Jan 2022 09:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zZPHxHB0vfbNwwJ5cV5QVnTjD+AFCbHzID8b7qF+4Pc=;
 b=gLypcU9WRxbrJXXOXGm24QnLStELdfOYZ09zLC4Gv3nLgNp0j10zsB+1Bjl7+OQy+7fW
 QK2wID20K08juK1jkHfmMRfgOj2ZxU1pWDwA74l6kBZTJGzoWNATGN0KHWMhGAvf80HS
 Y3Hd4j1BGlhNqq5/7JIg9riKQtEUnzL9OBeJzi4Or8nJ0UTARNSJ4ZTLw8UUn2BPhQ2R
 rjWELi+Elm5ZdspcnrLBv3SA8w+ua08e5pNlOdiH8cRbfMd8GilFpISM8j1KexDhK2wd
 8HAbPmqSNIAaCMWmZ/Ob09SXRSKmghEqN7QrtkK8BxoUU3AzMZ2AaRkbLtReNufr25tF rw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhy9rt19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 09:29:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20L9GXM1153455;
        Fri, 21 Jan 2022 09:29:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by aserp3020.oracle.com with ESMTP id 3dqj0stcsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 09:29:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuVGEvwwMZdkw1bov97/SRdQcS+xOaiSAvvZB2T4D1WJgx5PmySzvSaa+HTYzQqIqMfWvTkADnlP2ZMwFe+ddUETJ0slCgZ/aX6DppEwC7pWqR8udrXuXaoelczg+DgKcc+MzsUZXAGVe5R2aGzGkQINGgjDDWLUpL/q5k0gH2V8yDi311SBQg6AT6vPXHTSKXxPvRNK3UDvaz4O6pKfg7Jf5NfyGv0wCt3/+wHRsMlyEsvpHXr3xZqfOiDHeA2OtpFYwryvG4C3hbthy9g/8cIbLJwCBzfeS3F71EyUKEEA6HxD/Pa/hXlpbsOypWnKIh6P7qUZ22eNfy1h9u1/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZPHxHB0vfbNwwJ5cV5QVnTjD+AFCbHzID8b7qF+4Pc=;
 b=Lhq57P7X/HCcbPs32df6F3/a4YrORD00YGwoeyPZPsGh4OMb+IAJZAO4F1X/TEjEz/fRbsRbq2s8NkM+j5rMcCh55Cmh/ls0Pt0lBpvCRCR/Hs0UrHptSMZRtlTmayOAOv68Xhx4PGqxOykPNaYg+GIhtgl6qPKzLqSP6YBSffWo7LvPURz5Gd4Y7o7KmSq6sxE+7QPIVCSa1d6I75kbj8beByIGVf4Z3BniEqE6mC6jwqYXP7+GjZvpuquLLLjLSaK2T9+JzpODeDFvCdK7Aq1tM4nAUcsyIu5cCrMAKg7Z2PXhgAfGexBZkSTSSBKK+RNvl1BzvDqk5iLhS3AShA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZPHxHB0vfbNwwJ5cV5QVnTjD+AFCbHzID8b7qF+4Pc=;
 b=VsoDVXSYLqT5e7C3s0xeq6KlOCpJMoGfFhVeRZ48kD+tgSK6XoFwnttepzkK5LFENsBx1ZmlhslWE0mIRHcuLEMpAh4Za0SvSHRRIq6ZbEcIvqZbSinZK/nZxNvkLYDr7LclhacvVeHu2rJdjC2eQEEpD9OaAj8n/JESBT4cDXo=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (52.135.48.88) by
 DM5PR10MB1963.namprd10.prod.outlook.com (10.175.87.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.12; Fri, 21 Jan 2022 09:29:13 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 09:29:13 +0000
Message-ID: <5f0ab29e-c557-d67c-06a6-9dcb7d850cb9@oracle.com>
Date:   Fri, 21 Jan 2022 17:29:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/2] btrfs-progs: read device fsid from the sysfs
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1634598659.git.anand.jain@oracle.com>
 <98a34772-990c-5e8e-5402-a6d857fc0292@oracle.com>
 <4a7ddf8e-f283-a2e8-3c96-c67ae4b3bf5b@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <4a7ddf8e-f283-a2e8-3c96-c67ae4b3bf5b@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0181.apcprd06.prod.outlook.com (2603:1096:4:1::13)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea36c54b-6b0e-4fe2-0999-08d9dcc07c7c
X-MS-TrafficTypeDiagnostic: DM5PR10MB1963:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1963720D1136C791588975AFE55B9@DM5PR10MB1963.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LqIQiknWMu+IHsdQl+cC2GcEUriQLyMZV+y6sRkdeLZ/BOCoY/gQbFs8uqr+FkUBY851lHSlU/frgNsoJZURI2DO70Opjh2mbQfjhsyHhDLomxthDNBddd8V7mTfOG8IMGVPJz2MY5mCwizOcPhY/P2BeyAlkDVxVWkvKRfZv43PEd6vrxGgeCgZU94uyc7sOkODkgWdMiBoDol1Vh6oUSmhTQqkRZ0LSYuOZ7MM3orYX0HGUDE2USRRq4U7Jpg7vttqu9UrxpHW0uihsF773DeJAWaFc5jkVqgoP5PewWoXec6B60YRP//lknZqiKJH7LWkQ8Qi4Ep73D1c/dO6SgpMWwX5p3pejY3e5Pz+36TjhF9sWGxpVmdQTZg8kYY4M47YsEz/nv9oBt4MhWBMS5vgWseJh0uu+tib/jG/w7WM8HdlyWs51Rl3LgsRzgpxLfruPTqqAdn/qxaFRariQ711mdAv/jX+D1HPR0bdNfFPyE0yyZBEz1UZlCqYjiggnCrFqNa3msBA2g0Nn3a5OiWBW8UM+0NquXTigzouQjEMJcJnYdV35WPNfpkLob62KYm7mTVObWaHNP+8peOfTNIuKezb6nj/ZVFNRJSQAOqVzvZiZbRbxZhavDlutRStFTZFwV2xpLHeJJXg2rtWKy/Szyxo9hC+1gQ1IuBumBibgwCPF4R98sDWdFZ+liVCwb+0iqBHh4Z0eQHMDRV9eOKyhJFzFH2m5qhNU0rEn7T6T53Y4CVTfL2t5Tu+KPcB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(6512007)(31686004)(66556008)(4326008)(6506007)(8676002)(86362001)(316002)(110136005)(8936002)(186003)(38100700002)(53546011)(66476007)(6486002)(5660300002)(26005)(83380400001)(508600001)(2616005)(6666004)(44832011)(66946007)(2906002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXRsaWYvaDQveVVjb09WaHhDbDhyVVRVN1paaFB2KytaUWE1ZVRacFdrdGo1?=
 =?utf-8?B?d1VFSDFUS3JjOFk5S3dORi9RRVhrOEcxd0Q0eVRQcEEwRGtPc0JqUkZwS0dq?=
 =?utf-8?B?akkrYjFweFVWeUNnTmlzZzZ4UFpNSzBncEpjZG1Qd2dTbUhlYWwzd1VjNEo0?=
 =?utf-8?B?TVFQQ21qamNDWmZpY3JQT2NEQUlHeEswRTFCcGtJTCtSU2R3RWFWb0pLTmtq?=
 =?utf-8?B?SndOQWh6NnhDK1FwQWI1NGhSYTVDZ25KK0xvUDFpbFhPbjJzY0x5eEpONDB1?=
 =?utf-8?B?WmtQejJ5anRMbDRXTU1oajJHZWpCVWxzN0dzbVRTNlAzWEhEbG1oRnljR29Y?=
 =?utf-8?B?L0RReURrSzZWT25tOXByYmFhVTRkb25memREQWdEOFNaS2NxNXFKTzdjaVRJ?=
 =?utf-8?B?WDRNY1JSRjF6MnNCVFMxcWpHMDNxTWR4cGtYTDd6QzRmeExGbjZ0V2JMUkNw?=
 =?utf-8?B?MkhjSXRYcnVzdWxaTDVYdk9mSlI3ODVSekFBc1UraHVJc2Ixb3A1a3UvWTVD?=
 =?utf-8?B?akZkMExZYTVDUG1XVjFVV2xYYTFaNG56Q0NRMEU1M1BFUU5KR1V6d3lJdGhh?=
 =?utf-8?B?VW03Z0IxRTVPMk4xQzRTNjJpcFZwR0tBVFZmZ0VPMGtjMkN1R0JNWlhPWXp5?=
 =?utf-8?B?d2ZsWVVseDF0VFplK3ljOG9LMlp2aGplVnlTaWhQRXZ3M2tLbGx0NDlteUxk?=
 =?utf-8?B?R2JzLysycWJTM3MxelE2ZUhYaTlETHZBVk03d3AzamxJcjY4cnlydnZzWUlp?=
 =?utf-8?B?aTVJNDRpQityenhnRWg2RFIvb1ZXZ2JDUVpxdFNibG4vWCtaV3BlcGk2RDNu?=
 =?utf-8?B?LzVRbGF4R3dwc0tsdldvTm9MdXdESGgyenJKWW4vbHVxY09JN1pnTU41cHZH?=
 =?utf-8?B?ODdGQVU0NVUrYUxFQjlRajlGU3VIR2pTUjBzdkVYeGJRTGFnSlNiTytRdjlF?=
 =?utf-8?B?Q01oV1ZINE42ekJRTk5iKzd4anEwZDZZZ3BlKzUvdWJNek04aEV6M085STdQ?=
 =?utf-8?B?SkRpWkY5YkRsQmUxQ2UxVFBtaldwT0NTZXdxTWV3QXhSWGFzemtLdm8yQU5B?=
 =?utf-8?B?VitGL042alFQZnFWN3lpR0g1RVBuK2pnMTZPdktqMnA3Q2F5ejJtaFVxdDMw?=
 =?utf-8?B?UkZPV3lzZVVyRFpub1FPc3hlTzlta1ZKL2VZS2EwVWk3YXZ1Q0xDdTY0Y0lz?=
 =?utf-8?B?M0R5WmdpQUtsYUdheUpkMWkzdVZXa3hJaTloM2t3T2JXL2VuMVBLZjE1TWt1?=
 =?utf-8?B?SHJvL3hYWjFJSklHa3c5K2k1WmhZMWJ4Qlo5cVdoeDN2RFpWQUJtK0xKeE1T?=
 =?utf-8?B?YzloQ0V1OVFQUS9VR2Jxd3ZnY05PTnovTzdNb0RubXlSYVJmY3gvdUd4VEJK?=
 =?utf-8?B?NFhMS1ZMUVNJcWRlRmlTUE1xVXVJM0M1RHhvVlQyNHJpRW1UN2RwZUlEa3BK?=
 =?utf-8?B?R1J5dzRyamRUS1VVeDJVcjZtZVBlRlpZeGwraGtURXFCelU2Z0JxUkdYUEho?=
 =?utf-8?B?OHZtSlhXN3pTdEgyclNsckt5QUpZQ2EvVjlhUFE0QkdwSXl5UzZYR3NQUmE1?=
 =?utf-8?B?bjVGclFxMUNVT3RtaE9XNnRRRnVrNjZkMDhKMFRsOXdENElEOE15UDdxZXVo?=
 =?utf-8?B?ZUlQWU5wWWpidzNna2NNcUt3c2ZnL29uZFdhcjJIbjlIMTN3eVk4aTJWeWs0?=
 =?utf-8?B?Q204alA0Y3JHeVBWMXJJUytyeHdjTEJ4VVd6TmFucDJ4ZzUwZG5yaWVQYk1y?=
 =?utf-8?B?SW4zRGQwQkFWSlJOVzdHckh1eWNWUzJObk8xSkxpbUkrVnhiNjVTTTJkamRD?=
 =?utf-8?B?VmRZRlF2eUlMKzQ1V3FxRFh0YUZ3L05QWHJua1ZhejNHcGtwM3Z4dzhxVmI2?=
 =?utf-8?B?WFpsb3pIZkpDUm9BMlhDMitra3RHL21sTHdmUUdnMXhMMmdlYXhiKzBKY1hq?=
 =?utf-8?B?ekRId0h4cnc5YmZjZmdPRW9OUll5UzUrc3NDMzBvSzc1SXp2QVArQk14cmhk?=
 =?utf-8?B?cnR6K2gzbWtNamZZZ1RrS3V4ZTk3Rm5IemhtNCt4VTVOb3lWdlRxT1FOVkRC?=
 =?utf-8?B?OHNnbzBEZTRRbk5VSmxGWk5qZnViNUtNSW9icXhLOStRbHZOYjMzeXZLNEFa?=
 =?utf-8?B?TWhRQTNPbGZQcVkvMmdDRURQa3dna1JxYWRob1h3NDJGMFk4R1NqWkRtUGN4?=
 =?utf-8?Q?52pRo4rJIO04ua3fsRzNZvs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea36c54b-6b0e-4fe2-0999-08d9dcc07c7c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 09:29:13.4189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQH6biiXvm/Rv7tEUs0ibbXp8ti7cDkpaAgEj7wW63z9ToKRMhec7odKciEGljMAnu231Z92Sb4iFZr4J4vjJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1963
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10233 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201210062
X-Proofpoint-GUID: SKxbJBl-fDNk8cyUk1ROv5SWcfSljN9M
X-Proofpoint-ORIG-GUID: SKxbJBl-fDNk8cyUk1ROv5SWcfSljN9M
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/01/2022 23:19, Nikolay Borisov wrote:
> 
> 
> On 6.01.22 г. 2:04, Anand Jain wrote:
>>
>> Gentle ping?

   Gentle ping again.

>>
>> The related kernel patch is already in misc-next.
>> I don't find this btrfs-progs patch-set in the devel branch.
> 
> And what about introducing a test case for this change?

   btrfs/248 did it.

Thanks, Anand


>>
>> Thanks, Anand
>>
>>
>> On 19/10/2021 08:23, Anand Jain wrote:
>>> The following test case fails as it trying to read the fsid from the sb
>>> for a missing device.
>>>
>>>      $ mkfs.btrfs -f -draid1 -mraid1 $DEV1 $DEV2
>>>      $ btrfstune -S 1 $DEV1
>>>      $ wipefs -a $DEV2
>>>      $ btrfs dev scan --forget
>>>      $ mount -o degraded $DEV1 /btrfs
>>>      $ btrfs device add $DEV3 /btrfs -f
>>>
>>>      $ btrfs fi us /btrfs
>>>        ERROR: unexpected number of devices: 1 >= 1
>>>        ERROR: if seed device is used, try running this command as root
>>>    The kernel patch [1] in the mailing list provided a sysfs interface
>>> to read the fsid of the device, so use it instead.
>>>
>>>    [1]  btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
>>>
>>> This patch also retains the old method that is to read the SB for
>>> backward compatibility purposes.
>>>
>>> Anand Jain (2):
>>>     btrfs-progs: prepare helper device_is_seed
>>>     btrfs-progs: read fsid from the sysfs in device_is_seed
>>>
>>>    cmds/filesystem-usage.c | 47 ++++++++++++++++++++++++++++++++++++-----
>>>    1 file changed, 42 insertions(+), 5 deletions(-)
>>>
>>

