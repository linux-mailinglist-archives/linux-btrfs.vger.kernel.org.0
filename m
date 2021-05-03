Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9F43713A2
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 May 2021 12:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbhECKa1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 May 2021 06:30:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51656 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbhECKa0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 May 2021 06:30:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143AOI3W189619;
        Mon, 3 May 2021 10:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=O30fk1sLbSGhv7KdOjWWDsZZ63W8nD3xdyx/sFHOEgU=;
 b=SpE9wVNidBXcuwnGJUGN8fJZbb6g9hmgdBth0XgNslL6bu7As+qoaUkzW1w7W2jst9RZ
 06LHZGKxgqFBU+SnbQMFD7o2ejUp5J7DzxB4zFsoB+ovnntR4Hxr3mjlfZUJfeP4MC9e
 syir+8cteFeatgtEy4yyp9vesVD3nk0j62q++kiavgl3U+Le9WVOid5IelWysj8fjwPt
 n/v6Eg2RDtHfY2rl08shzzIIeRqbLuz0EP7yfqGt6bbXIi6WdLTi8dWaADpJGANVrmAq
 sKUDCR0z6C7hGpe1QO1aXEJ37+TN8jP+dRO7rV0K9SFcdCCPCaCSdowBeJ24OJ/WOZ9x Zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 389h13t34h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 10:29:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143ALDRm191567;
        Mon, 3 May 2021 10:29:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3020.oracle.com with ESMTP id 389grqh4tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 10:29:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hM8VVEtaIrvDEPh1o9+hgtNEQL1qu1WfcMvbGw6AC4DbMpaiHtfIcRc9XO6Xfr6Kop+4BpnAT9Y5V3Xc86TmUOW2+BPCSP5ZIXzdyLqoESv4y5votFGGqOQ9p7Q5RCuDgSVKHMqX5Tpa4X9oS7pxvgysSaQCbNxN+lX61uM+Wx3OQMFc0I6QV+yFECb32uyEnPGmimxET46TpSaZed1Cy7n7aXwAVJ4CaL6pIxPdhLh6oaMbqffb48PLf93t3vB00Nyj+DImESJ7kc21x6aeSyyLKaLUAj3CZln3HiFudIaSK36KIhrxbBMiOdXotLQ0ggPB2dQOnLm9oOkyVR8c/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O30fk1sLbSGhv7KdOjWWDsZZ63W8nD3xdyx/sFHOEgU=;
 b=MnN/W3Mi86zAwWh2lGNuA2lYobD1IF+0xocrZs8PbUKsoyWs9+hkVTt6mgfbFQG2yyRBakShdsY794QKwY5q9tcgL0LXt5wHuAnCBNfS3EYX5qoR/PF7VDerVfoKHjdSYfeX7Dj8dEGcasJWkTX/0LpLuKHB/lvDjr/1gnMW4czP2T2wOQhcp5LDfuOwvCd08Y0Yv5Q8HU+TQWFleqrkWxpVWsRujpeMP4LxIgxPOBxLIvz/myJ6Ky7kJWRnJ/1N8fT66UBvNCwB3NFICCAMxxMUp99uKMPNwB78ngbhUMVbYIup/58n9v/hG5gbGs9P5ECZMKwnKpdX8Cap7t8Vbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O30fk1sLbSGhv7KdOjWWDsZZ63W8nD3xdyx/sFHOEgU=;
 b=ettWa4tnDPb8VAj3K3PB7hAlGL5V1yW2s2fOc5iczk+Ro2DCJMjuu75NqgwWr1zOErExCW12CniBXVrEZ92ZE3bb3SGZNkQ9Ig+wJ6lG4GRdsA7F25yPfYCSbIehdumm3W87YwTyqqgDWCNOv57td9I4mMB8B4eeHUXLvZFvQRM=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4206.namprd10.prod.outlook.com (2603:10b6:208:1df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Mon, 3 May
 2021 10:29:25 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%9]) with mapi id 15.20.4087.044; Mon, 3 May 2021
 10:29:25 +0000
Subject: Re: [PATCH v2] btrfs: add fstrim test case on the sprout device
To:     fdmanana@gmail.com
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe David Borba Manana <fdmanana@suse.com>
References: <96fe1c0c8747d24ad6c45bc3f0a5551b8e1ebbde.1619793258.git.anand.jain@oracle.com>
 <7ff015576992de7e8d6ff554c27c420a9ffa1595.1619800208.git.anand.jain@oracle.com>
 <CAL3q7H79zG9rm-kOu7rys=ev0Ja_fuTNoYvdz0q6hwgqyQrhkg@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <8e6a5e5c-5cab-aea3-6be9-8223020084b8@oracle.com>
Date:   Mon, 3 May 2021 18:29:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <CAL3q7H79zG9rm-kOu7rys=ev0Ja_fuTNoYvdz0q6hwgqyQrhkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:1b:3811:18ba:4380]
X-ClientProxiedBy: SG2PR01CA0177.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::33) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:1b:3811:18ba:4380] (2406:3003:2006:2288:1b:3811:18ba:4380) by SG2PR01CA0177.apcprd01.prod.exchangelabs.com (2603:1096:4:28::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Mon, 3 May 2021 10:29:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbb6eddd-00aa-45ff-b093-08d90e1e52c9
X-MS-TrafficTypeDiagnostic: MN2PR10MB4206:
X-Microsoft-Antispam-PRVS: <MN2PR10MB42062116AA50B35A479E7FE1E55B9@MN2PR10MB4206.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMmIHmL87Z1yirTBfxli3nC/0HAZBs8bWq9xQY6Xa+pHU5e1QWU0yrLra17hrzdPafwr/972oy3NcDH2WdrRpOQKAbVWtkMURKRndQqs3KlPHPdz4aKY2MqqMYr7Oby0VC+scJtJz4E7fKibAMV5U2oCPuzsgJSzA3Z31qeHdKCf0hMNZK16e4XWoBTovjH9RdmrcPlhOa7l0G1aj5j61m8n6iI6EpRGCiiVsvihxc7f1FhQ0rEPJeLxm+ybxcUVvKZnXTvS45dQQNON5bEP+6uv1zDgeyIYOXz6btARJyKYyQ3v+27kTZFvZAnmo8hZIOc+NZnc1X4OFRts//BJBWfavTdwVWi+wZR89rdrRS99JlYMT2bSFkJNhKoNT5xS8voXl8ye8tFLNkDY1G7bs5RNOyFH5lXmG9CRPVUV43KxbMHyYuhy5AXcf8pJm91a1L5WMbkxvIhFTUtoSt1zOINc+nCnEN8wLmnSRZuAYJ5zuMns7fYCAw4BtcPkZLtylOo3OdgpTOzppQ8j6KqRebY5Y2SFmG38QvVuAkIIwMYt+Mj4IpC8jGRBOOvJIG+rY95j/VN4zQ+aIKyHavr6/vuGTMun5ajZSof3QVr1ViFfE2uVnMR3xPU/OPalUBTfm6PM8mWw3/9iCe+2gZP2yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39860400002)(376002)(396003)(2616005)(36756003)(31686004)(66946007)(6486002)(478600001)(44832011)(83380400001)(6666004)(66476007)(66556008)(16526019)(53546011)(54906003)(86362001)(6916009)(5660300002)(8936002)(4326008)(8676002)(31696002)(316002)(38100700002)(186003)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aUhWenhJYzhnTzBPNU9xY0NjODh3dFlkWFhYbTdSR3pVTFp5MEs5bmRqM202?=
 =?utf-8?B?SEI4WlA5NHc0VmhXMUxSWXMxeDdKR1BYbkRPWE9Wb2JUOHo2UHZ4eG91T3Q2?=
 =?utf-8?B?VFFCL3kza0VIS0N6a3VKUHU1ZWs1QTh0NVA3Z3hzR2VhT3JlWnNhT1hzTzdW?=
 =?utf-8?B?QXFJcjZGaWlDb2ZiUFI3ZHlaZEZPbytPOXd1N1RIT3pYUlZzaXFMQVh3dDhs?=
 =?utf-8?B?ek5lTzJ1TlBuUGtPYkdBNjd2anVkNzFGUEViMCtTRmhWY0xObXJWOWRzMXZL?=
 =?utf-8?B?alNhS3NoV1ZZTC9nczUxeGRYZmxhVmhwV25WVUVxM0h2ZHFXb1MxVE80ck9O?=
 =?utf-8?B?S3FlZHNPTDFrdzg2RUw1UlZMVE1FRFZRNDRzQ2FEWHRXU0JnQm1HR3Y5czky?=
 =?utf-8?B?R0Q2djRxaU9zNmtpcHFOMi9tZ2NmaVdYNk1MQWFHeFpPZnI1MjZOdG9UR0ZL?=
 =?utf-8?B?S1gxRGtrS3hzbjZJTHZKeXY5aVJCSytoYm5hTzdzV1k2VG5HeUpFMHJRZ1hD?=
 =?utf-8?B?NTlHQXN4ZTZUNzVzYS9jTUF6Z3dTQ0RLNXVySjdDdTVIRnhreXBLOERDdnEw?=
 =?utf-8?B?bFZxMHh2MFZkRzJEcENnNEMxWWJybFl3Njk5OVFxYjNNTmkyZmNtZ28yVFI4?=
 =?utf-8?B?c1VuVmNSamIxbjJSUC85NjBoQkZGZ1I4V1dXZmlwQ3lUaU1tSjlnNnVOSmp4?=
 =?utf-8?B?VEtPd3l4UlNrb3I2YzdHSDBFQVZ5NGg1NkErblB3Q0dIT05nSnZWazJiTFZ3?=
 =?utf-8?B?Zit3M0JZdUZuRnUyaGlZT3F5KzFVVFdIS0hHWWZaZXFDOEFjdGpocmEyeVdT?=
 =?utf-8?B?NjgzMFF6YkdGUzI2eDJQYjBsVndCRjJqSjV3WWhyUVdxdk43ZWhZRnUyTW9q?=
 =?utf-8?B?TW81V1REUzFoeHQ4RU5WRjhISm8rMjNDSmFkWDJ6bHViTnhGNlJlMkEyTDVZ?=
 =?utf-8?B?UEVZRVd6UWtsRWhBREtTSVpvSDRLT2tacjVKTCtzS0dYRm9uTk9MWDJqQ3c0?=
 =?utf-8?B?ZDc1a0tWVWF1Z1Y3c2N3R0Nqcm54SDcvSWVzUE9TQUNPdDlRdDFyMW9OSlZX?=
 =?utf-8?B?RWpDNXFDakJqQWJYTmhBZWl0YzRIeCtnOTM1akNhazV2MDFKUEJ3UTlzdG1t?=
 =?utf-8?B?Rk9uc3J4czdSc0NOM0EyZGN2OWRSRmlIcm45aHppTlE0WmRrZE9DQTh1Z0hZ?=
 =?utf-8?B?ZG90RzE2eG04WmpJMzhucjh1RGNrTTA5eEVUOWY5R3pYbUV2emFDMXVJRHl2?=
 =?utf-8?B?T085NCtnTDROMjRJSmFBWFFueEVDNFhpK0N6UGt5aGZxbzkzL09ham5KZWhB?=
 =?utf-8?B?WlkzYURjYzR4N0FGOFB2WVM1bDRDYWNMYlY2YklBd0l1VmlWeE5JU09nWERl?=
 =?utf-8?B?alJEVkkvVmNZS3U1KzlnRlhtdklkNUtNK3FGOE1NTS9qeWxzMEc3SXpoMGhT?=
 =?utf-8?B?UWlOcnUrYnNDdDB4WVRPUU1IWVFGTzRhQW55U1doQU1uRENPN1VlN1AzVERa?=
 =?utf-8?B?S0s5aTJERmVXcE9wQjNsWTV2QkdOZm8vTjR0enN0eGZoZnVWdVVqd1pzbDN4?=
 =?utf-8?B?T28rTXYrMTc5QzYxbjRwT3NBOEFzYUZKZEc0UG9EU2pLejJ4b3l6aXJDb0hv?=
 =?utf-8?B?WEc2NmlMMmZnc2pVWUJGSUtXbU95NTExb3N1TmNPUEhnenhGa3NrQytnUVFz?=
 =?utf-8?B?dG1NU2Jzb1ZqMHl6eFZidkJsU210Q29QTHU5R28yd1ZzRVVDbjNCVUVhNEhj?=
 =?utf-8?B?RkVQU01RZHQ3UDRrVnZHOHZOcjk4blpmZk5FZE84M2NHb3p5QlFYNFNLSCtw?=
 =?utf-8?B?N0Q1MC81N3dBL2pIbnFMNHBJWVJoOXlSQkN6R01GNitQN1VWdnV0ZGExdjVU?=
 =?utf-8?Q?sSmJSsp/7euUo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb6eddd-00aa-45ff-b093-08d90e1e52c9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 10:29:25.3758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ev4UYH3CikJAll3jQoNgSX0Vy+ddnLAkzQ835UOLZoHSPgb9yjV/xrA4PefXLz7XDnMdk2gsvTH5KKWEkZcIWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4206
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9972 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105030069
X-Proofpoint-ORIG-GUID: 15PTKjfMo33mYC3Lns1Bn3_JqjvejtXK
X-Proofpoint-GUID: 15PTKjfMo33mYC3Lns1Bn3_JqjvejtXK
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9972 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030069
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 03/05/2021 17:54, Filipe Manana wrote:
> On Sat, May 1, 2021 at 6:24 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> Add fstrim test case on the sprout device, verify seed device
>> integrity.
>>
>>   btrfs: fix unmountable seed device after fstrim
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2:
>>    Add _require_fstrim and _require_batched_discard.
>>    Use FSTRIM_PROG.
>>    Use _filter_ro_mount to handle the difference in output in different
>>       mount(8) version.
>>    Call _scratch_dev_pool_put.
>>    Add _check_btrfs_filesystem $seed to check the whole seed fs.
>>    Update in-code comments.
>>
>>   tests/btrfs/236     | 81 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/236.out |  5 +++
>>   tests/btrfs/group   |  1 +
>>   3 files changed, 87 insertions(+)
>>   create mode 100755 tests/btrfs/236
>>   create mode 100644 tests/btrfs/236.out
>>
>> diff --git a/tests/btrfs/236 b/tests/btrfs/236
>> new file mode 100755
>> index 000000000000..aac27fac06dd
>> --- /dev/null
>> +++ b/tests/btrfs/236
>> @@ -0,0 +1,81 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2021 Oracle. All Rights Reserved.
>> +#
>> +# FS QA Test 236
>> +#
>> +# Check seed device integrity after fstrim on the sprout device.
>> +#
>> +#  Kernel bug is fixed by the commit:
>> +#    btrfs: fix unmountable seed device after fstrim
>> +
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1       # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +       cd /
>> +       rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_require_command "$BTRFS_TUNE_PROG" btrfstune
>> +_require_fstrim
>> +_require_scratch_dev_pool 2
>> +_scratch_dev_pool_get 2
>> +
>> +seed=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
>> +sprout=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
>> +
>> +_mkfs_dev $seed
>> +_mount $seed $SCRATCH_MNT
>> +
>> +$XFS_IO_PROG -f -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foo > /dev/null
>> +_scratch_unmount
>> +$BTRFS_TUNE_PROG -S 1 $seed
>> +
>> +# Mount the seed device and add the rw device
>> +_mount $seed $SCRATCH_MNT 2>&1 | _filter_ro_mount | _filter_scratch
>> +md5sum $SCRATCH_MNT/foo | _filter_scratch
>> +
>> +$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT
>> +_scratch_unmount
>> +
>> +# Now remount writeable sprout device, create some data and run fstrim
>> +_mount $sprout $SCRATCH_MNT
>> +_require_batched_discard $SCRATCH_MNT
>> +
>> +$XFS_IO_PROG -f -c "pwrite -S 0xcd 0 1M" $SCRATCH_MNT/bar > /dev/null
> 
> We aren't doing anything with this file ("bar"). Just remove it.
> 

  Right.  It can go.  I will fix it in v3.
Thanks.


> Otherwise it passes now with the filter.
> 
> Thanks.
> 
>> +
>> +$FSTRIM_PROG $SCRATCH_MNT
>> +
>> +_scratch_unmount
>> +
>> +# Verify seed device is all ok
>> +_mount $seed $SCRATCH_MNT 2>&1 | _filter_ro_mount | _filter_scratch
>> +md5sum $SCRATCH_MNT/foo | _filter_scratch
>> +_scratch_unmount
>> +
>> +_check_btrfs_filesystem $seed
>> +
>> +_scratch_dev_pool_put
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/236.out b/tests/btrfs/236.out
>> new file mode 100644
>> index 000000000000..01699b8fc291
>> --- /dev/null
>> +++ b/tests/btrfs/236.out
>> @@ -0,0 +1,5 @@
>> +QA output created by 236
>> +mount: device write-protected, mounting read-only
>> +096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
>> +mount: device write-protected, mounting read-only
>> +096003817ad2638000a6836e55866697  SCRATCH_MNT/foo
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index 331dd432fac3..5032259244e0 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -238,3 +238,4 @@
>>   233 auto quick subvolume
>>   234 auto quick compress rw
>>   235 auto quick send
>> +236 auto quick seed trim
>> --
>> 2.27.0
>>
> 
> 
