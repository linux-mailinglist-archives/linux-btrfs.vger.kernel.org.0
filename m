Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AAA3A0DF4
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jun 2021 09:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbhFIHqA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 03:46:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36812 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbhFIHp7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Jun 2021 03:45:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1597hvam191495;
        Wed, 9 Jun 2021 07:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=LKh8CTf8XA4/+BCmw42uuP45kTPBtRM0WRBQJo6D6xM=;
 b=sD1H6QZ+9YDNGIX983J55k/ZEU3DE2UBVb6RRWd3N44hVQ9NEjyDZTRx5VLPeLcFVliv
 kcORswwhDIF6ccIwCuaZRlcx1j+LlmLvCeKtIzNCyTaI4lNXKW2xe+XQRXdr7yCAT0/c
 VJnA0tdNrkkCXEKeuOf3W7hvH3S10oC/Dorw/lhlSwZZy2EhUC/hFOUqgvTQBxITq1dX
 iAIrpH0nKVpQE+UV5/QiLleC+aaNxxBEOzwvfRjp3H6rLlLBcNpJdpQacQAZmiWf5nKu
 I/O3kgOgrXVWEjBJTTnHl54TsTA6qii1CuQ9O38tAIZBueh+Te7868+aOJCjDRibL0Lr 0g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 39017ng8up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 07:43:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1597eSst142340;
        Wed, 9 Jun 2021 07:43:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3030.oracle.com with ESMTP id 38yxcvesj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 07:43:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaBubEzHZuKujYj7bOqM8J6PrkJ9I0a4S7007syODjsL8L4QLRP9NzwiEoFMZgKI99qMlPZ2wDLr4c6nquXYP8xn80o3GXAaK89yYYRoldlHa/uW2elLhCfB+4XoObiosn3b5s+O19sDXBT9M0bQ5wuW1XKwX3SK5Kc0SYmT7u1wdoXhLhpm6Ig4f2/gvRXaLvjfz6SHyucBC4EbgQKDjPSQMmtmqfUMobl/WYP24Reevdv9gRjRhIH+WVbQHdjnqIiwuXU4vaORvdtBRXzZp3pWN8kLkSaq4rd5Q78KqdmD6avQADH2VSSbbRe60EoUGn+JPXBnVmj5wc+8sPdLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKh8CTf8XA4/+BCmw42uuP45kTPBtRM0WRBQJo6D6xM=;
 b=ZmK0q7xeNRfknfsxdRjJn8jVmrtvZPhjjMts8SO6h4JySf42i4X3T9jdDDLsWYfUq1lOLzEBuxj8lvo/qTDRaae5Lq9gfuQOVSwNJiQP3lnNN9STzhhGi8v1muHHwnRevEGnuCFzpojQiLYOblESiaGj0mkDJTgXybp4UxN8Nihtz52VFHeUHL5p5Wzk7b33sPVtzKkNB40YQt04txymilp4Z36sgwwQWV8ClwDlj1YEXovAhgfYa/ab0yicVQGO8Bzd3UYmjWK7gRxqSqWkyzebYAaQsTH7lYNHCub02th3hHm0votU9OMtfiZzoNm4NJYPXAqBwBrg62VL567YCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKh8CTf8XA4/+BCmw42uuP45kTPBtRM0WRBQJo6D6xM=;
 b=MNww81m/y6vFfl1PXooZeawlgLKxCQJd4z3Wsmad45Jk6pOED8unIF1VCdjp37L7eSE/eoUrO/8HlRK4hOILX1PHODqyGDf07CK1hVSdm4f7YkIEoHM04elq0rmgVMMASt0VsRTfnY3UfR/MKtRFW6tFm0/K36mCxGALytef46Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5025.namprd10.prod.outlook.com (2603:10b6:208:30d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Wed, 9 Jun
 2021 07:43:54 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%7]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 07:43:54 +0000
Subject: Re: [PATCH] btrfs: sysfs: export dev stats in devinfo directory
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210604132058.11334-1-dsterba@suse.com>
 <5aeca0cd-c6b2-939a-6f83-7ea5722076dc@oracle.com>
 <20210604142105.GD31483@twin.jikos.cz>
 <77708664-a7db-50e0-aa44-6cbb3fb90070@oracle.com>
 <20210607185556.GL31483@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <8e255fb8-9dc2-57cf-f6e8-d1c23aa43563@oracle.com>
Date:   Wed, 9 Jun 2021 15:43:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <20210607185556.GL31483@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SGAP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::30)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.43.161] (39.109.186.25) by SGAP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 07:43:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84d48a3f-7460-4022-e99a-08d92b1a54ea
X-MS-TrafficTypeDiagnostic: BLAPR10MB5025:
X-Microsoft-Antispam-PRVS: <BLAPR10MB502526FA2107DB6AC4DDCE95E5369@BLAPR10MB5025.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YEOxjr5bRcWvnqd4Zt5GR4ghkzSDtZ+VLnWPieyHxvue1zaZuAeKv/+suC8R9DTFdjNPT0EuBxtu1aQgakPxI924dIOj2h44iA4MPdOmwGXqYoERyjimT/EoaWid7DM/WG9MLmAiyI7GckigQb4yKkLSasb92KMzPtNAaj1AYZlMRGtf7gxSf9OTAOeWozyd8L6fSJWGl7ZaR9lvSB1xi0rXZwrenpK+my43Upz5jSnKMl2fCNHgeITMoSfBhWTKdQtYaU0HXVfg7Qx3/4c3ids5G7uJqJlOHoT94dX71xCuCHRYSfe79hFSU+zffKpXLFexNESavPjgqtxXWtvKrjO+QhoE7uXvGtDp0pgwEJe1BND1wFRnTtpam7WsJNDsBtGABpEYSdSqd7tlO5/rGBc5oh2pGhAZn+gn3AZy+c5FqjSCn5DC61nWmUrmg4gXYuHJrLlwVM3c/UeTwIJ9iAMgu62SC7HycMgrdgrJ6esEz6EgVHv9D1lB36VQS8BDRUaSAhlJX17g2cDcRHzU2zfam27dPUTeUeKch/v7RJOD4Osp55XyYBQoRZ8u5UTd2/hy49qfIxFkTrSa5N+5xhGKcVcUCR9luv7Pqw4ajZQag9Z79JIhp3oVAjWkU3lKCE8F4h4x27E57MuKEgLF3m/YZUzOYFFJPvnLo9hmApK4fO7qF8DXC6XVD3BfHOrIiDWi6Ho74JU15WbcINE+irpW1vg+XMhFxg4xgIx3EunqjkaOY1ucMKXorC9/CwNmtX5I0Pe9n063g0hGpt4wwU18nKsLI5uEFbKMvT9soZuHELdJso6eylL0Xb+rv8rM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(136003)(366004)(376002)(31686004)(6486002)(16526019)(26005)(44832011)(36756003)(2906002)(186003)(66556008)(38100700002)(83380400001)(66946007)(16576012)(53546011)(5660300002)(66476007)(6666004)(478600001)(8676002)(2616005)(8936002)(31696002)(316002)(956004)(966005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEliYzY5RXJWeExQZjVJRkNkNUx4NEM1Z3VJRU0yeTdsZElEbnBuVS9hWUpF?=
 =?utf-8?B?NE9qWm83cTY1aVhwaGhjY0x3SkZ1TEsrbkcwZUtxdW0rNkNvb25CYVF6bWJi?=
 =?utf-8?B?L2ZKRnpFZExPRzIxTWlzRFhzK25PbjZ4NzlPb1FHbFRVc1dPYWJjbDcwYWhV?=
 =?utf-8?B?M09WakFwMTJXaU4yUXVFRk0rYm0zZFJVYVNneWNod3NLZW1TZjNTUDZQaDhj?=
 =?utf-8?B?SWhHQlA0SWtVajNsdjB5N0ZlN29NTVRNY2NtTFo3OWl1cDhaQUtsTFNxSFcz?=
 =?utf-8?B?TjVYY3RBa09EYWZYaHhqcjdKUnFSQmNNcjZZUml0VW9LTmt5V3Q3UEt1WnYw?=
 =?utf-8?B?Y0pFR2U5bEFGZSsvYmVCc2dKK1ZvTzNMOVNlSFphM3FGRjl1TTYxUG5sVjBM?=
 =?utf-8?B?YS8vb2dXckR3YTZ2UnpHeHdNMDc1SEZpOG54VW9PTzN4Y3R3ZWU5THFUcS9h?=
 =?utf-8?B?WjRqN0lZQ2t4Y1pTM29heFI2NGMrRmI5clN4eXYxdEkwbGVwRC9TMHc5b2JC?=
 =?utf-8?B?enNpT0Q5c21GZm5IOVFVZ2pKNjNrZUh0Z1FUMUVXQXFpRnlSbWZFbWx6bUM2?=
 =?utf-8?B?WU1Xd2pQajB0b0FoQmQvcU5VaXl1bjd0aFk4SjBlREVvdUc0eHJkMyt2SUMr?=
 =?utf-8?B?TmdQSmRZQlpVa3ltY1NYRndRTzVOaDZ3aWhldGkzYjRUL05rQklmUThCanBi?=
 =?utf-8?B?SHE3VjBsTktCWEF1b0UvdGwxTHI0VFVZS1JNVkJ1MVdIc2ttbWdMWTE1cEQ4?=
 =?utf-8?B?Z29pT0pQbVRYNm42VmxocFlUWHhhRE94dTl4b3NWQmI4SFVaT3FPV1VyZXJD?=
 =?utf-8?B?ZlB6ZXdsNmZxd2J3WEJVWnpqTWJKZHRvVGhqUlBGc1QxRENkOHJwRkk3SHpM?=
 =?utf-8?B?ZVpwNkFQdnFCVVJIenRZT2YzWVNxbHkzY3dQeHExZUdEZzVKbEJCNW9uLzVn?=
 =?utf-8?B?SS9QNCtXM0hQZVI5eGM0bktBRkpEOFIzVkE3Vnp0R3lzbThSSktxd05neDNq?=
 =?utf-8?B?QzdNcWhJTkI1aVJ6YUVaNHUweVJ6RnpkMlVYbkZEUU9HaS9SWE5nOFZvRjUv?=
 =?utf-8?B?SllVOVlkS0I4THZ0V09LaGFXdG40TkpRK1lObmVHck1IeE9jOWU5blhONVRS?=
 =?utf-8?B?NXVEeHVMZ2RTdGdVWkVGWDNWNy9QSzFNd3g0cFFXM3cvM0RJQXphWm95WGdp?=
 =?utf-8?B?NFA5NkE1R0VqeFVHKzAvenlkWERSMS9RbVp2bjdNQTVPVkRxNkoxZUF6S09j?=
 =?utf-8?B?ZERIZ0gxN2hFS2JpWFl4Sm9ZeFdGa2xOdExGanVGNmw2amg3TDFKVW9Kbyth?=
 =?utf-8?B?dUkveldpSVB3TmFmMFlHRWhTQmpsZGNoUDJReGVNdmdKNXBPNHdsdGo1N2NZ?=
 =?utf-8?B?WFYyUkplQ1RpSW0zSitHUmd3MmRHMnBFMUc4RDlPVFhMNkFqaFlXU3VPL2F2?=
 =?utf-8?B?MnI2RHBMdW1QR0UyV1NKZGx6Q1Rzdkl1UHF4SHdEZFQ2dm4vRXRiVVFhaVZZ?=
 =?utf-8?B?bEt4YktONktJN0RXMUVPUTlDZmllK2w1Tmk0djVjYkpId2tNei9CR09Xd3Ez?=
 =?utf-8?B?bUtNZzdnakdpSllDYXdUTXNTSDZhR0xzZjlhZlN2OE0vdHVIOFQrd04rWS9M?=
 =?utf-8?B?M0lqSHVqNWZTWmZmRXB5UU9KV0VVTFI4elRiT1ZYWjlQWUtUU05zUkYvYzRF?=
 =?utf-8?B?TkZnVDVuRDZsZmhodjd0WUZ0NVJicVgxakdpRllHbFowbU9mTVFJSnZsY3dZ?=
 =?utf-8?Q?RVnYjHILmm3Yw8CjgTX4KSgp+uT6ERWZKt9OSsp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d48a3f-7460-4022-e99a-08d92b1a54ea
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 07:43:54.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTbIIAROYElYiI6WMLhMHh/ncmEhIpdrTMfp/1cNf4q8RroW0+GPJDoeFJFMc25Lboheu1qaPWMdLkni+/lG3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5025
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106090031
X-Proofpoint-GUID: 3IzMR7DGHAni_zWNubEPQvsfZ-6CHLpb
X-Proofpoint-ORIG-GUID: 3IzMR7DGHAni_zWNubEPQvsfZ-6CHLpb
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106090031
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 8/6/21 2:55 am, David Sterba wrote:
> On Sat, Jun 05, 2021 at 06:38:16AM +0800, Anand Jain wrote:
>> On 04/06/2021 22:21, David Sterba wrote:
>>> On Fri, Jun 04, 2021 at 09:41:09PM +0800, Anand Jain wrote:
>>>> On 4/6/21 9:20 pm, David Sterba wrote:
>>>>> The device stats can be read by ioctl, wrapped by command 'btrfs device
>>>>> stats'. Provide another source where to read the information in
>>>>> /sys/fs/btrfs/FSID/devinfo/DEVID/stats .
>>>>
>>>>     The planned stat here is errors stat.
>>>>     So why not rename this to error_stats?
>>>
>>> I think it's commonly called device stats, dev stats, so when it's in
>>> 'devinfo' it's like it's the 'stats' for the device.
>>
>>
>>> We don't have other
>>> stats, like regarding io but in that case it would make sense to
>>> distnguish the names.
>>
>> My read_policy work (which I suppose is next on your list for review)
> 
> Yeah, it's among the next things to merge once the current features
> stabilize enough.
> 
>> made sense that publishing the io-stat information locally from btrfs is
>> a good idea. So that it provides clarity if the IO is skewed to a device
>> or balanced. Which is even more essential in the case of mixed device
>> types. For now IMHO,  /sys/fs/btrfs/FSID/devinfo/DEVID/error_stats
>> is harmless.
> 
> Agreed, I thought about the same, gathering some regular io stats, so
> the error_stats makes sense.  > There's still one open question whether to
> do it all in one file or in a subdirectory error_stats/ . > The sysfs way
> is one value per file but for the stats


> I'm more inclined to follow what
> /proc/ stats do. It's more convenient to monitor stats in one file read
> than having to do 'cat error_stats/*' or with filenames as 'grep ^
> error_stats/*'.

  Agreed. I prefer one file from the convenience pov. Also, block dev has
  one file, the reason to represent it invariably at a given time [1]
    [1] https://www.kernel.org/doc/Documentation/block/stat.txt
  IMO the same applies to btrfs too.

Thanks, Anand
