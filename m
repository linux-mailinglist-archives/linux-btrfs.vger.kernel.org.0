Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A8646AB5F
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 23:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350071AbhLFW1a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 17:27:30 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55428 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242901AbhLFW13 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Dec 2021 17:27:29 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6M5UV2016363;
        Mon, 6 Dec 2021 22:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KfGk11NtZzXH6DJoBvCNUFXlj9l0//JfrNbhjsPKzU0=;
 b=ioeVOG2M+ekx7ARqp7Ggo+zFE3174Jf5hvNZFMd4s1HmV5pwAEFCvPRFyOAer5G19k6U
 FWPzJp98Dr/0GOgH0o5f+1tziwMLv99fNc2PwIAk+RmNC29uEFLBoMW/647II9DJlLCt
 5hh/0StKNCqwbVVfAcqR4BhTkPSWnOcnDnJKMkZd4PJ/GLAFmUXNkoplHvSXW4WzhYij
 X609ko2vo4ZDIoGO6QVM+9B8V6ZERHwQi/h2nH9t/H7CrL/waCL4UR+IS8M2REd5s7J/
 Q/DPG25aKl/I7r/MZTrEwRd3fBgfjKbmuLYWwe97WD9M/lP3bfum70+R2RjRtjaawnyi gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csctwkq4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 22:23:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B6MAd7d168922;
        Mon, 6 Dec 2021 22:23:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by userp3020.oracle.com with ESMTP id 3cr1smtq21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Dec 2021 22:23:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPNTMEMP+3MeZSKhurauOy5GPMD/rFy4HjKVBdwexalr3ej0HMeh5VD6EHdwaZ14BpgsjWYAy8HHbJ7Z7y/SjDEMExFoqep2DnesmmqYQzEI4Znyq6FPkeDjb0PKRV4P9XriTKoDdC2TwZZm61zAnj4JYYEoJmoWNbeoW8uGoscDS/vK79ASBuzoiD4wlujDOQp5/VhmT1ClQzZXUIIZz1wL5LeCsJCRydFkZVM4j6lBoiVQ4m9HBImQTfPB+Ols23LAeDQ9j8FRoTbCpp3sckA6oBMXUB9F1wzCNl1bf7L458DzWuc3A9DwAwZx8AmzZTpnVViQO+62OATrbelaqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfGk11NtZzXH6DJoBvCNUFXlj9l0//JfrNbhjsPKzU0=;
 b=g61TDE43uqLMm+knOu9DMb4rOlndith+nU5W1TCitQqDuXIVmGSNXYq1Fa3ebcZNDFJuU533CesA0P/TdD0qvXaCVJn0NEbN/aTjYE7Sx7hRanA1EEdetVrLNMykrna9l1ITFmxc3ThKcE89BAc16Ti0tNb0wqEpLft3K2tBG0XupckkQgEa6CftneaLypWmh6rNrFuFGrbrk8MeVXIJ8A0w5Jom5oFIYg/lAHLCZN4Dnc3OmFcTd5ENsCA6JfenKGmLPvfaIY9aNBmOJYD72LaLV92XN1crWhhelMic5bKmZ8DEXyxGjbzxvPTGgriIfmjOkv4TJLSBcSTtrD072w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfGk11NtZzXH6DJoBvCNUFXlj9l0//JfrNbhjsPKzU0=;
 b=U7e8l5oRsQUGg2L4PHfquhGGn/1X0vwfpya/xIlJJBY3gSFOMHyPY9nZAfUjRQ7G8wi5F0sSvS5KhUhh7cSjdvkUv9MMoQah/pZn2wNfRrJy5jbPo98GLjQu+FVt/8DWtGhZ3Ab4NHBfflgLYXi49azmytffsLFxFXs2MkMKNuA=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2996.namprd10.prod.outlook.com (2603:10b6:208:7e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Mon, 6 Dec
 2021 22:23:53 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%5]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 22:23:53 +0000
Message-ID: <cf58d20e-1c9a-98eb-7aee-0a2beb869cdf@oracle.com>
Date:   Tue, 7 Dec 2021 06:23:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] btrfs: free device if we fail to open it
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <7cfd63a1232900565abf487e82b7aa4af5fbca29.1638393521.git.josef@toxicpanda.com>
 <fdd4a2c9-00dd-430c-0537-d43734337845@oracle.com>
 <YajuCbMN4H0Ap76V@localhost.localdomain>
 <b25ba451-18f3-073f-0691-c99b10fd8c9a@oracle.com>
 <Yaoy2Ib85CZ/QJXs@localhost.localdomain>
 <3e1ca8f0-e817-6314-90eb-84b10e03ee77@oracle.com>
 <Ya5hiA1MIOTtyFwZ@localhost.localdomain>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <Ya5hiA1MIOTtyFwZ@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR02CA0130.apcprd02.prod.outlook.com (2603:1096:4:188::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Mon, 6 Dec 2021 22:23:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9af2c57f-6969-42da-340f-08d9b90715e7
X-MS-TrafficTypeDiagnostic: BL0PR10MB2996:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB29962B9CDDF76FE4BFCDBF8BE56D9@BL0PR10MB2996.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3inn1Iio0RtS/O01JF5Tozzam0F3UjE0ga0hHLLUWwlMrmSVxXTsAu4h36NK8mLEm8HQI8jt3WohXTWUjARKMZSXRKxkQ3KhoXc+G3Sbi4a3i5rUwTwcm5iKp0mWPM/LV3sDhgo4eg8mFxc5CAxvLgSHCSaQjybNXz4D/dSV7pakLauPms4iAVo/KKBI1vr6KVW11B0/PpfwG4mmhpySV41cl1dkUyeO7vZ3ojZiEJ5wX9hw8xtxU3I/yC7Xvl52o/htK8nztqZzogRlqbpMkH4MJ2y1I5QZfR8hXY5QERP0aTuX3W3QbAQ+4Pol6SPtcKszuUVdU+AsYWmxupB0Q43C9yj7nC/lEQos4Wd4k5ZbtGCQVimUrb8TXNhBRBMdcSWZUheWF9sbubobClLpqF1rLXdfn+1xu185QrXcFTWLzfB8v2LWrINhbCNui1I9kez313h2m+LcmRMXh3xD2pSCK3BwwFwTtYw5XNpfM03onSMlNdZL1l+e2UYMip6D1qG/AGJ54sCMQ3JI9zR0PM4TcYml0uZZudVYY0DHQdErb9OyzYofis8ceUTcwZUJcaUCghz3YGG6wDEDI9w/XhyA8XfDJH5efJCMZZCnwSM2pQHUWNLnoZu0q3TGsbFhn0fD+Z3jKDbMYhxOuLhzk0LlBWwrmLkcM6s5wolWj4ej6pNAmukZjLoHyJ6PC5MoMprAU2WDnMAGlHsAWKnD0mkW28wPCnwt+MZT2U6mbgy8yEw/DApZz1yCahB4dc2I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(38100700002)(31696002)(2616005)(6666004)(16576012)(36756003)(508600001)(956004)(53546011)(5660300002)(186003)(2906002)(26005)(83380400001)(6486002)(4326008)(86362001)(66946007)(44832011)(6916009)(66556008)(31686004)(66476007)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d25mMWNQTTY4eDNuMDhoZmVKRkRlbzVLbVM0UzRFNEJWTDBCbXlmTGhQQ21I?=
 =?utf-8?B?SXhyTFJxenF0dXdreFptci9FaVBEUjFoTzZER3k4bW9ER082VDMxN01Vcjdw?=
 =?utf-8?B?dWZxK3VMNjV0SDRFTnpLK2xKa3U1YjhkeEVQSk4wVzJYSVZoa0VLQ3pPTTIw?=
 =?utf-8?B?MUF1VFdqM2pNN0xpTFF3MnBKd3NFTGtCNS94VGxRcnRHYmFKYitBUjRpUHIz?=
 =?utf-8?B?blJQRGhNc0d0TkR3d2JOOEpVdzRxdEhRTnFmUFNnK3VYNnI3cXZxOHFWSmJI?=
 =?utf-8?B?NUFiTmFFSU9OOFgyWTY0R2ltZTZvOG5xeFRlRDFUcERXNmI1dURKM2JHTExH?=
 =?utf-8?B?TE5sK1Z0d1hZY3NkYkx4bnRkakoxbkd5cmJoRWNzTmdVRHJhVm43VzUxODl1?=
 =?utf-8?B?TTJqVm5TOXRhWFZ4WXAxd0pVakN5RzZ5WTBuRVo2aUkydUZnelBzMlVkT0dL?=
 =?utf-8?B?d0VtK0tHOVM5Q3FlY0xwTytsWUt2dXZ5b2VuUmtodlBvdmsxdEtIWkx0QmNl?=
 =?utf-8?B?RWZqRXhEaHcwOFBKQWd6bWlEK04vZ25qZUNGb0t6V3Yxd3R5MGhrVHRiRkox?=
 =?utf-8?B?OSsyOGNBRWhob3BNSitxWGhDeGN5K3hqMjFaa3FZUTRVZzNXRG1HUFlTNld2?=
 =?utf-8?B?TDhwdk42NGxKYUQ4T1ozQ2V4dWJOQlBnQTZleFd6QTIzVDBpZGZieDRYZUt0?=
 =?utf-8?B?QWxPR1l4aTB0SnN1dGY4YnFmZk9mVzdGYThYbUM4MGpDcVhic3BwZVN6LzNp?=
 =?utf-8?B?aG5KMFZkdnM1L1RzUWlhVnhSSVBrS1R4TmhGY3BENkJoL3NqK1JOOGVsNHlJ?=
 =?utf-8?B?SHpUK2hmWlpIbUxBalI5Rmo2cndYNGlET1lqOFVGV0krSHYwN0N6dDRRWS84?=
 =?utf-8?B?eTBjb2RpY0pXTFV3MUp2Wk5tbmdXWGpKS2xaY3lkOVNIcngvaDMzcHdEbllk?=
 =?utf-8?B?ZXhReUpXVUdTWWRRQm95bG01ZVBzUlBTb0FTcVBxUXhhT1k1dFhXNHlrOExO?=
 =?utf-8?B?enFhT1VvWnU1L05Yd2E3bVFGSm9MRVFvY21wQWdXZE1CMlAwazFBZTJRN0Nr?=
 =?utf-8?B?azc5OTdKVW8vY3BuUnhmbGVVNTFGTU0wOXY0a1IyT0NZR2psVUdBSGxNbUFU?=
 =?utf-8?B?c2xvMWpTaFpIOXFsU2JWNDJFNzZQZERsY1QwbzE1bVlIS0RVMnVjZU5YS3dX?=
 =?utf-8?B?MnZJKzQyV25COFFmdkFHZ0JWZTd6NWtNc3BSbjVNck9pdU94TXYwZXRTbXFR?=
 =?utf-8?B?Nm5HZmVTZFNIVjlIcW9Cd3JlT1BRTlVXMDdqalJGRnZGQXk0RTRmOHo0MW1H?=
 =?utf-8?B?RFFKbGFCMFhRNWtUcCtmcmg5bEQwS2VRMmlsTVhTZ1pSM0U0dEYrMFZ5M1dH?=
 =?utf-8?B?S01jbjBVMHZIRjlISWZlckxheDUvWXVyL3VaUGRYQlZSZUp5eEs0ZzhDdENW?=
 =?utf-8?B?N1h1eityaDNBak8wdDlIRGdNVVppZFFLaEJOK2pQa0prVjBMQ2NLRlcvaXh1?=
 =?utf-8?B?Sk9pV2g1VmFoU2pOdWk2b1RoMHpNRm5DcWZLcGZNZXAxdzZZRlBScm1BYlVV?=
 =?utf-8?B?SSsydzQ4Sk9UNmJicDNFUTBmZUlob3QrQW51NXNsMDFBbHVVS1RmdFZiVGdB?=
 =?utf-8?B?blpUVWFVaDcvdXViN242NEphRlJkVGJIUDVGSEtoczl0M01XdWIrMHhMeXVP?=
 =?utf-8?B?SzhDTEU2WnZKVzE1ZW5sb1ZPbTNPQ0JJTU9HZXN1TFpZZktwWmo2cjNjNG9y?=
 =?utf-8?B?NkszL253ODNKdWlwcUtjaGlweWlEd0VmZVkvZnduU0V4MlFoQVo5eW5VZHh1?=
 =?utf-8?B?TndUSjlLOVQ2UVd0ZUhWbkJqVTIzZFlUZ3FXYWtpNFZLeVh2cEZLVkxlTitC?=
 =?utf-8?B?RHJJeTRUeDNBNlRPL1FNZFZOL1U4cmo1VmpQRzZLamlCTGhxSk41cmduS1l1?=
 =?utf-8?B?TlNOTkREclNuV3pPZzdET3pCbDhrUVl5dndVT2RVSi9JMCtaTlJ4WTh5Y2ZX?=
 =?utf-8?B?Zyt0bWI1RHlQTGR3dnlObUkyZXF6eUNONjFFdW1KaWdmZy9pdTdYOG4zSDVS?=
 =?utf-8?B?b3lJcUVRaHNncXZKeGNOUkp4L1JPaStwZjRsWjdJcUxvYmZaN2wvUk9YeE9V?=
 =?utf-8?B?SGpXd1p5R01sbytsQjlBTnZkeXJhRVF3SWxIYUZENnBnblJBdjNVWTFObis2?=
 =?utf-8?Q?OlE/YtKGnYSPuHIYIpKn8O0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af2c57f-6969-42da-340f-08d9b90715e7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 22:23:53.7705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+YCX3l63S+miP8tqQ0CWH+OS4nvNUX1KchLoD1dTSonRRHnKVF8eUGUnKXiN+4ymSyplj3ZNHIMomSQuNB23g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2996
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10190 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112060137
X-Proofpoint-ORIG-GUID: CSdWCKjCVzJnoidFJ1oieUC2DKsiclEi
X-Proofpoint-GUID: CSdWCKjCVzJnoidFJ1oieUC2DKsiclEi
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 07/12/2021 03:16, Josef Bacik wrote:
> On Mon, Dec 06, 2021 at 10:32:07PM +0800, Anand Jain wrote:
>>
>> <snip>
>>
>>
>>>>    I got it. It shouldn't be difficult to reproduce and, I could reproduce.
>>>> Without this patch.
>>>>
>>>>
>>>>    Below is a device with two different paths. dm and its mapper.
>>>>
>>>> ----------
>>>>    $ ls -bli /dev/mapper/vg-scratch1  /dev/dm-1
>>>>    561 brw-rw---- 1 root disk 252, 1 Dec  3 12:13 /dev/dm-1
>>>>    565 lrwxrwxrwx 1 root root      7 Dec  3 12:13 /dev/mapper/vg-scratch1 ->
>>>> ../dm-1
>>>> ----------
>>>>
>>>>    Clean the fs_devices.
>>>>
>>>> ----------
>>>>    $ btrfs dev scan --forget
>>>> ----------
>>>>
>>>>    Use the mapper to do mkfs.btrfs.
>>>>
>>>> ----------
>>>>    $ mkfs.btrfs -fq /dev/mapper/vg-scratch0
>>>>    $ mount /dev/mapper/vg-scratch0 /btrfs
>>>> ----------
>>>>
>>>>    Crete raid1 again using mapper path.
>>>>
>>>> ----------
>>>>    $ mkfs.btrfs -U $uuid -fq -draid1 -mraid1 /dev/mapper/vg-scratch1
>>>> /dev/mapper/vg-scratch2
>>>> ----------
>>>>
>>>>    Use dm path to add the device which belongs to another btrfs filesystem.
>>>>
>>>> ----------
>>>>    $ btrfs dev add -f /dev/dm-1 /btrfs
>>>> ----------
>>>>
>>>>    Now mount the above raid1 in degraded mode.
>>>>
>>>> ----------
>>>>    $ mount -o degraded /dev/mapper/vg-scratch2 /btrfs1
>>>> ----------
>>>>
>>>
>>> Ahhh nice, I couldn't figure out a way to trigger it manually.  I wonder if we
>>> can figure out a way to do this in xfstests without needing to have your
>>> SCRATCH_DEV on lvm already?
>>
>> Yep. A dm linear on top of a raw device will help. I have a rough draft
>> working. I could send it to xfstests if you want?
>>
> 
> Yes please, that would be helpful.
> 
>>>>> Yeah I was a little fuzzy on this.  I think *any* failure should mean that we
>>>>> remove the device from the fs_devices tho right?  So that we show we're missing
>>>>> a device, since we can't actually access it?  I'm actually asking, because I
>>>>> think we can go either way, but to me I think any failure sure result in the
>>>>> removal of the device so we can re-scan the correct one.  Thanks,
>>>>>
>>>>
>>>> It is difficult to generalize, I guess. For example, consider the transient
>>>> errors during the boot-up and the errors due to slow to-ready devices or the
>>>> system-related errors such as ENOMEM/EACCES, all these does not call for
>>>> device-free. If we free the device for transient errors, any further attempt
>>>> to mount will fail unless it is device-scan again.
>>>>
>>>> Here the bug is about btrfs_free_stale_devices() which failed to identify
>>>> the same device when tricked by mixing the dm and mapper paths.
>>>> Can I check with you if there is another way to fix this by checking the
>>>> device major and min number or the serial number from the device inquiry
>>>> page?
>>>
>>
>>> I suppose I could just change it so that our verification proceses, like the
>>> MAGIC or FSID checks, return ENODATA and we only do it in those cases.  Does
>>> that seem reasonable?
>>
>> The 'btrfs device add' calls btrfs_free_stale_devices(), however
>> device_path_matched() fails to match the device by its path. So IMO, fix has
>> to be in device_path_matched() but with a different parameter to match
>> instead of device path.
>>
>> Here is another manifestation of the same problem.
>>
>> $ mkfs.btrfs -fq /dev/dm-0
>> $ cat /proc/fs/btrfs/devlist | grep device:
>>   device: /dev/dm-0
>>
>> $ btrfs dev scan --forget /dev/dm-0
>> ERROR: cannot unregister device '/dev/mapper/tsdb': No such file or
>> directory
>>
>> Above, mkfs.btrfs does not sanitizes the input device path however, the
>> forget command sanitizes the input device to /dev/mapper/tsdb and the
>> device_path_matched() in btrfs_free_stale_devices() fails. So fix has to be
>> in device_path_matched() and, why not replace strcmp() with compare major
>> and minor device numbers?
> 
> I like that better actually, you mind wiring it up since it's your idea?
> Thanks,
> 

  Sure. For both xfstests and the fix.

Thanks, Anand
