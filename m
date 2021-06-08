Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B61139F4AC
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jun 2021 13:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhFHLNQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Jun 2021 07:13:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41572 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhFHLNP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Jun 2021 07:13:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 158B5NG2130705;
        Tue, 8 Jun 2021 11:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=6+Xsw9nPMHS8D8wWGDuBnhPPAgjnIroIdr08jM5GyoM=;
 b=jt3BS+HN8Ghjb6xvz6D7r5nQoMdH3B8OTbamrab09k977KlPhAEzeVeMJelsZWVbBZap
 PIvQ4IZAfJOPCyy4UBOPHjFFZhr2uKQhNOun/kXgqcUQvBqd0m+QoHQCMvKq41Z9lKVh
 jLwTOaBWJy74/wOSo2rp/fUXSy5lnjHY+75+d997cYAUO//eFzXQ4q/NsEnTynnmYahE
 FLId/07fVD1yTUBzfuNnMHHhBWG3MK9rF1wCHP93cTeH0NcrqimfC0IQniWj0D1iyHdu
 Ipyid3avB6aGPq+45dEc85TJVuehiE2AkRRv8cMjBIParozLJAy23e4TteF2gRlx74KU AA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3900ps5ppu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 11:11:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 158BAMue191522;
        Tue, 8 Jun 2021 11:11:16 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by userp3030.oracle.com with ESMTP id 38yxcun3w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 11:11:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9QfZ0xSxyncTbIpc4Ayt+BLTHJDUSGJ27I0aUXh2k4aBR18yJ1L8AG5I5TU7Uxo9aA5IkEto+x9KcYVdoKzoW4NcwFex5essPgne5xlZxVgqft6krm0MzFStrIYXavgX4fJLQJj1e2SyrbMuUvG01dHMMG/782XrPWHYW3FVatOBs1A0DSy2r8xuKK9hf/OMHifAfomjhhrmiOSquC0fKihI5eLozqvUgMRMSiR7JQ+WpTPXioJIjNp1kCrR9xEdnIUA8MotxnphDeeuEOnIW+R+Fx9cBlJPaLZkwLYfOfhyZTxdbD1+spWo93JpM7zua5/ONo+UdcAoziv8KpvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+Xsw9nPMHS8D8wWGDuBnhPPAgjnIroIdr08jM5GyoM=;
 b=eNVz3Tm7UhciBELBqv3lemHVaujQme7g6F5UULRf2MmvhlY7gJyXHgepGoAQ2kxdB9XdhuO6GG4brqlGlEcN5BEjEl7XqlJnORYO0+f5HL+OiBj4yMmOT8TvQpAN4+X8FFUZO6qNE/sYqGJJtG2OVG6GhkkCmHD7O8qUFUJA8cxixjxmzzYDDLOGjZx+15wZKQY3HddgkiWzqyvH4inNUATpR2SHbuMTO1hCeGUxSRAy4CjVxn3d80VHpJWUAcvwixRGYMprYwmyU4iReFllHg2CMAaPOSLo2dDwY9KtRwnIIhtTKeezfCICDUc8FXd/DVOg2IU6a2DXQC5Az/aNtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+Xsw9nPMHS8D8wWGDuBnhPPAgjnIroIdr08jM5GyoM=;
 b=nGqI1siTLnpdM/s7oP5gdMwvsFDBtmrf7PXJSRpUzUBy52j5QHrYMzo1jYVKA03Ui6NYsrsys2QYuvMuUFErZ8yL3OZNYlYRzt7obIZig37nK75ZQ2nNWrFgEmmKCKmO/adf3nRTDa3GX/d6tt7LbUHFwlzr2BCsZ8U49RBwots=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3967.namprd10.prod.outlook.com (2603:10b6:208:1bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Tue, 8 Jun
 2021 11:11:13 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%7]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 11:11:13 +0000
Subject: Re: [PATCH v4 00/30] btrfs: add data write support for subpage
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210531085106.259490-1-wqu@suse.com>
 <55ba3489-98de-3a69-8912-3a32e73ffca4@oracle.com>
 <a1a2aebb-759d-35a2-ade0-3a0119346166@gmx.com>
 <b1eed283-af02-8052-40f4-b671ee17ac6f@oracle.com>
 <d973de78-ae22-b3b6-be6f-b023a60ee90e@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     anand.jain@oracle.com
Message-ID: <c385d55b-c77c-b831-03ac-d4b4c8a6243c@oracle.com>
Date:   Tue, 8 Jun 2021 19:11:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <d973de78-ae22-b3b6-be6f-b023a60ee90e@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR06CA0111.apcprd06.prod.outlook.com
 (2603:1096:1:1d::13) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR06CA0111.apcprd06.prod.outlook.com (2603:1096:1:1d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Tue, 8 Jun 2021 11:11:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b48084d8-9e03-41f4-ffd8-08d92a6e20d6
X-MS-TrafficTypeDiagnostic: MN2PR10MB3967:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3967ADF48DA30B7053502590E5379@MN2PR10MB3967.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZsWxAvT5t5wSLIxcpIBXcXCUKHvb98bYkD7FMDHq9WUrI2m1VI1UXIm8BeefYT5YZi+u91h0MX1g5rEpIZqldC8MFN5ewPUco/tOUvFyLy0IHi9VO0vY1v2b0i8FI4jhNvc3OVa6VL6zLw6BGRsl8GIux2Z7ZA776HL1BU6C6A8Ywznrg/Y+0P05E28IVFA3bOE20hcipW9FXeKVxnC6wN+p7U8WUoBoidq8gX2akrSE0Th5hNjUWYJUdP8joDHFi56z5kfgCRsrNPvngSFiC5ZcZ/8bRgcPa902xGUvqIHBcdFXDHdGmFM+0mtyMF6/nQiNV9DCVlV5d6bCwNAcReWuAF1cZxyarDGYI4c6RdEOlf+dRZS9DsV7fj+Yu0FOzgR40yrq5xc9n7XNNZPLCySjtU++D7ifO9VPXe4zVrMK60n1EdZdWg2ixtfp0dNw9CACm3JYRLkWzukbgoXdTkvWBs01IHv9b/wXaU5TDjv65sNZIIBglEN/+8eX7HE/0P5AbYhNZz9jeCgT85jRrHjJz7pzRN/eQX1zH5ssBbx1PGXbY+ZYr0IFlfXRdlwrLMQiFb6SCdTZze0S+8fmq7qRRRh3pYq/661bedkeDi1GJzHkPgX5ko6x/IDI1Ai3ZO2UyoJ4MXL4oc65li0K/wSIJiJysgcHVYPQbtre3c+B++bw/Xnknpg0HdOjyIk0t4lQj1jjUZm8c9b/7ZRIE5uaZQqNBgUeF04eDiW007WsOXeMckuY1LSb+FbUGCJeb26v3PzzDNfTod6vUuzQT68D03Ggjk8PCRXpydAkSAWyzw+BQNsHGSEggKORv9xcD0QEU3xWGzAUhAgoWVQjL1moKx0Fim00ODbxCyU1+0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(39860400002)(396003)(53546011)(36756003)(107886003)(478600001)(8936002)(8676002)(26005)(956004)(966005)(2906002)(16526019)(2616005)(38100700002)(66556008)(5660300002)(83380400001)(66476007)(110136005)(66946007)(31696002)(6486002)(16576012)(6666004)(86362001)(31686004)(316002)(186003)(4326008)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEdnVDgrVUJhR2kraVBxbTNnYkR6S0FETlZzS2YzL1dXVXlGQkVUeDViK250?=
 =?utf-8?B?VEFzdmpzTVIxY0hOWGszREQzZ1ZDU1crcDNUQkJac09SOFBveCtjQUNEczBh?=
 =?utf-8?B?ZElZMjRUaHR0NUwrWHpQbWNPTEN6NXBabGdvakRmdW05RDV5TGtDS3J5YXBr?=
 =?utf-8?B?L1VsdDNRQzg1ZEdRVlNkT2ZUR3RUeXdxSGFTdTZkYUcrTjV3M1RUb1RtbExz?=
 =?utf-8?B?Y2ZGQjZTalJ2bFhpYjBzQmFNWHV4SENSMy84UkV6WlRRNUpCcUJ2NS96K3Fr?=
 =?utf-8?B?M1hxQkVJQUhIQlZ3OVRYNnpxTmlDVzJlWHN0UEFPOFhSY21wbzNETjJHTkEx?=
 =?utf-8?B?Y2JxY2FqWlhWa3c5NG1mbVp4RGcwK0Z4NkdNOWcwUGloZDJyTVI3R1R6SGg3?=
 =?utf-8?B?ZVh1eEdLbmNsL3NZY1Zpc2tvbjJJY0hkUWpoa3BINFR0dzFqTXVJQ3hvZkpk?=
 =?utf-8?B?cVBZUDVPZ3dUWXF4R3RvZEdMVlhMWmd1SURQYW9XaXJTQ1I4RU82Ny9DVVdz?=
 =?utf-8?B?U291QjRHR2xiQmZ3QUY2VzFpa0ZBYTBHOTNCenU3VzlGUWtqVW5aYVhjRGhD?=
 =?utf-8?B?K1dyYThYUGlYV1hnUDA4MEM0OWZFdVpRM3Y3NjV6YkhOMDdmMkJObERySUdk?=
 =?utf-8?B?Uk83VzBJRkUvbU5iSkFxa20wbTdOdnhNWmUvTVBUQWdMVUpoUnQ4ckRxQTFq?=
 =?utf-8?B?alhLYkRmem9nZlU2UE1mZUlNYmVtVzdSY0MvQTJDWEtGczdMT2RYcVBBeEJa?=
 =?utf-8?B?dlFFMEtZbnFGY1NPUVdDc3VSVDVweTAxeFVjRUVzZUpSeDFqcEZxUlA4dGdI?=
 =?utf-8?B?dEp6cExwazQ0MjJUWW13aXdOWWtZTUh0dS9YR3p1U3c4ZGxDcXFTWEV5VTRX?=
 =?utf-8?B?VGxZNXBuWHdSVVh3cWRFUDYyRjcvZUxxaFg1TXJ4Y1pNMEVhOUtGbzhXM3Nm?=
 =?utf-8?B?UEZJbHdyZjNxUC9mUlBZeDZLVEw2THdLdHdWWHdMMkgwTHhRUHhvRDk0dS9j?=
 =?utf-8?B?cW84OURzbHV6NGZCcjRJWlovTktGYVJnZVhHRHlUanBoZlJIMmU3bGxwcUxt?=
 =?utf-8?B?VVE3S05kbldYWFNUcFJsb2JHUWdZNDZyakhyOGRxb2tTTDQraVlqSWVwV2pz?=
 =?utf-8?B?N2N1d3lpNGRpQkZEd1RoazZXdU52Y3k0eHNLMnhJZysvMXZoTWxFWWYwY1N1?=
 =?utf-8?B?T1dObTBiLzk1b3MvU283RkVzZmZERlJ0MlJzQ1NOdkNxSnZTaGZuelQ2R1ox?=
 =?utf-8?B?TnJkVmJiR0hLWHZwQ2JHTHVOdlRVdDlEckRxMSs1Q3BnR1ZyVjZpWmdLZlMy?=
 =?utf-8?B?Rk5KbTJ6TVdTTVZ0REh6VWNRcTQyUFlaeW9lRUpQZVhPZzN3cndxK3FxdmRC?=
 =?utf-8?B?d1phNTcvek80Sy9TVldjUFY4Yk13VFA2OHBHTis1akM2ZldVNXcrYWZIdDg1?=
 =?utf-8?B?azNRVXI1cDAxRFFnVXV6ZUp4UngydHg4WFNKTGtvRjVNRzVaeXpoWnQyQWpx?=
 =?utf-8?B?ZURCK1UxVU1xUFhGT3dhbUVsRlpDNXBVZGdrZUVYK05BUFBjWHNrQXRiOXYx?=
 =?utf-8?B?RlN5bi83RHBrR00xRk9nNURmeStuTjlHN2tTL3ZQMXlVdW5LdzRKb2QzckIr?=
 =?utf-8?B?STZreS9zb0hZQXdNejhDOEhRM1ZXUUp5WG05SWV5U0hZRDZ0cXRtVEFvL1Fs?=
 =?utf-8?B?UzNjbFNBbXBmVHpVYnByVmp4QlI2a3lCWmx5VzFxaXMwVWVEVmRTcDNwamJs?=
 =?utf-8?Q?rwAKCTDiFtRfkRjdKjRMAcbAb76t2mKLtvW4B9g?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48084d8-9e03-41f4-ffd8-08d92a6e20d6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 11:11:13.6540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNu0oUWNUdKX41bjWzc7wL7fS3eNlpqQlKj3m9UBAQ4jDRJFrTgjDKCCDvdVwGWVaroYTQ0sqAUqafFStHNFyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3967
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10008 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106080075
X-Proofpoint-GUID: tisSYUPaeGdY0lyTRwPbB730QFrtMf-P
X-Proofpoint-ORIG-GUID: tisSYUPaeGdY0lyTRwPbB730QFrtMf-P
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10008 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080074
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 8/6/21 5:50 pm, Qu Wenruo wrote:
> 
> 
> On 2021/6/8 下午5:45, Anand Jain wrote:
>>
>>
>> On 8/6/21 5:02 pm, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/6/8 下午4:23, Anand Jain wrote:
>>>> On 31/5/21 4:50 pm, Qu Wenruo wrote:
>>>>> This huge patchset can be fetched from github:
>>>>> https://github.com/adam900710/linux/tree/subpage
>>>>>
>>>>> === Current stage ===
>>>>> The tests on x86 pass without new failure, and generic test group on
>>>>> arm64 with 64K page size passes except known failure and defrag group.
>>>>>
>>>>> For btrfs test group, all pass except compression/raid56/defrag.
>>>>>
>>>>> For anyone who is interested in testing, please apply this patch for
>>>>> btrfs-progs before testing.
>>>>> https://patchwork.kernel.org/project/linux-btrfs/patch/20210420073036.243715-1-wqu@suse.com/ 
>>>>>
>>>>>
>>>>>
>>>>> Or there will be too many false alerts.
>>>>>
>>>>> === Limitation ===
>>>>> There are several limitations introduced just for subpage:
>>>>> - No compressed write support
>>>>>    Read is no problem, but compression write path has more things
>>>>> left to
>>>>>    be modified.
>>>>>    Thus for current patchset, no matter what inode attribute or mount
>>>>>    option is, no new compressed extent can be created for subpage 
>>>>> case.
>>>>>
>>>>> - No inline extent will be created
>>>>>    This is mostly due to the fact that filemap_fdatawrite_range() will
>>>>>    trigger more write than the range specified.
>>>>>    In fallocate calls, this behavior can make us to writeback which 
>>>>> can
>>>>>    be inlined, before we enlarge the isize, causing inline extent 
>>>>> being
>>>>>    created along with regular extents.
>>>>>
>>>>> - No support for RAID56
>>>>>    There are still too many hardcoded PAGE_SIZE in raid56 code.
>>>>>    Considering it's already considered unsafe due to its write-hole
>>>>>    problem, disabling RAID56 for subpage looks sane to me.
>>>>>
>>>>> - No defrag support for subpage
>>>>>    The support for subpage defrag has already an initial version
>>>>>    submitted to the mail list.
>>>>>    Thus the correct support won't be included in this patchset.
>>>>>
>>>>
>>>> I am confused about what supports as of now?
>>>
>>>  From my latest subpage branch, everything work as expected.
>>>
>>> Defrag support is in another patchset, which can be applied
>>> independently.
>>>
>>>>   /sys/fs/btrfs/features/supported_sectorsizes
>>>
>>> [adam@arm-btrfs linux]$ uname -a
>>> Linux arm-btrfs 5.13.0-rc2-custom+ #5 SMP Tue Jun 1 16:11:41 CST 2021
>>> aarch64 GNU/Linux
>>> [adam@arm-btrfs linux]$ getconf PAGESIZE
>>> 65536
>>> [adam@arm-btrfs linux]$ cat /sys/fs/btrfs/features/supported_sectorsizes
>>> 4096 65536
>>>
>>> It still shows 4k as support sectorsize.
>>>
>>> What's your branch/HEAD? And are you using 64K page size?
>>>
>>
>>   I am on misc-next (which contains all these 30 patches). I don't see
>> subpages supported. Is there any patch I missed?
> 
> misc-next doesn't have full support yet.

Thanks for clarifying. I wasted too much time figuring out what's wrong 
with my setup. It wasn't explicit in the cover letter.
In that case, there is no regression in this set (plus with a bug fix 
patch as below). My Apologies to send this late:

  Tested-by: Anand Jain <anand.jain@oracle.com> [aarch64]

My test setup config:

Last commit on misc-next:
-----
aecab60cef1a (HEAD -> misc-next) btrfs: fix embarrassing bugs in 
find_next_dirty_byte()
3f3a096a4d67 (origin/misc-next) btrfs: remove total_data_size variable 
in btrfs_batch_insert_items()
-----

PLATFORM: Linux/aarch64
$ cpunr
32
$ cat /proc/meminfo | head -1
MemTotal: 16411904 kB
$ getconf PAGESIZE
65536

 >>> From my latest subpage branch, everything work as expected.

Let me try to apply on the current misc-next. I am targeting to test 
this with sectorsize=4096 on a pagesize=64K.  It will take some time as 
I need to get back to few other items as well.

Thanks, Anand


> 
> It lacks:
> - Relocation support
> - Bio split support
> - Various subpage specific fixes
> 
> Thus no subpage enabling patch.
> 
> Thanks,
> Qu
>>
>>   $ cat /sys/fs/btrfs/features/supported_sectorsizes
>> 65536
>>
>> Thanks, Anand
>>
>>> Thanks,
>>> Qu
>>>
>>>> list just the pagesize.
>>>>
>>>> Thanks, Anand
>>>>
>>>>
>>>>> === Patchset structure ===
>>>>>
>>>>> Patch 01~19:    Make data write path to be subpage compatible
>>>>> Patch 20~21:    Make data relocation path to be subpage compatible
>>>>> Patch 22~29:    Various fixes for subpage corner cases
>>>>> Patch 30:    Enable subpage data write
>>>>>
>>>>> === Changelog ===
>>>>> v2:
>>>>> - Rebased to latest misc-next
>>>>>    Now metadata write patches are removed from the series, as they are
>>>>>    already merged into misc-next.
>>>>>
>>>>> - Added new Reviewed-by/Tested-by/Reported-by tags
>>>>>
>>>>> - Use separate endio functions to subpage metadata write path
>>>>>
>>>>> - Re-order the patches, to make refactors at the top of the series
>>>>>    One refactor, the submit_extent_page() one, should benefit 4K page
>>>>>    size more than 64K page size, thus it's worthy to be merged early
>>>>>
>>>>> - New bug fixes exposed by Ritesh Harjani on Power
>>>>>
>>>>> - Reject RAID56 completely
>>>>>    Exposed by btrfs test group, which caused BUG_ON() for various
>>>>> sites.
>>>>>    Considering RAID56 is already not considered safe, it's better to
>>>>>    reject them completely for now.
>>>>>
>>>>> - Fix subpage scrub repair failure
>>>>>    Caused by hardcoded PAGE_SIZE
>>>>>
>>>>> - Fix free space cache inode size
>>>>>    Same cause as scrub repair failure
>>>>>
>>>>> v3:
>>>>> - Rebased to remove write path prepration patches
>>>>>
>>>>> - Properly enable btrfs defrag
>>>>>    Previsouly, btrfs defrag is in fact just disabled.
>>>>>    This makes tons of tests in btrfs/defrag to fail.
>>>>>
>>>>> - More bug fixes for rare race/crashes
>>>>>    * Fix relocation false alert on csum mismatch
>>>>>    * Fix relocation data corruption
>>>>>    * Fix a rare case of false ASSERT()
>>>>>      The fix already get merged into the prepration patches, thus no
>>>>>      longer in this patchset though.
>>>>>    Mostly reported by Ritesh from IBM.
>>>>>
>>>>> v4:
>>>>> - Disable subpage defrag completely
>>>>>    As full page defrag can race with fsstress in btrfs/062, causing
>>>>>    strange ordered extent bugs.
>>>>>    The full subpage defrag will be submitted as an indepdent patchset.
>>>>>
>>>>> Qu Wenruo (30):
>>>>>    btrfs: pass bytenr directly to __process_pages_contig()
>>>>>    btrfs: refactor the page status update into process_one_page()
>>>>>    btrfs: provide btrfs_page_clamp_*() helpers
>>>>>    btrfs: only require sector size alignment for
>>>>>      end_bio_extent_writepage()
>>>>>    btrfs: make btrfs_dirty_pages() to be subpage compatible
>>>>>    btrfs: make __process_pages_contig() to handle subpage
>>>>>      dirty/error/writeback status
>>>>>    btrfs: make end_bio_extent_writepage() to be subpage compatible
>>>>>    btrfs: make process_one_page() to handle subpage locking
>>>>>    btrfs: introduce helpers for subpage ordered status
>>>>>    btrfs: make page Ordered bit to be subpage compatible
>>>>>    btrfs: update locked page dirty/writeback/error bits in
>>>>>      __process_pages_contig
>>>>>    btrfs: prevent extent_clear_unlock_delalloc() to unlock page not
>>>>>      locked by __process_pages_contig()
>>>>>    btrfs: make btrfs_set_range_writeback() subpage compatible
>>>>>    btrfs: make __extent_writepage_io() only submit dirty range for
>>>>>      subpage
>>>>>    btrfs: make btrfs_truncate_block() to be subpage compatible
>>>>>    btrfs: make btrfs_page_mkwrite() to be subpage compatible
>>>>>    btrfs: reflink: make copy_inline_to_page() to be subpage compatible
>>>>>    btrfs: fix the filemap_range_has_page() call in
>>>>>      btrfs_punch_hole_lock_range()
>>>>>    btrfs: don't clear page extent mapped if we're not invalidating the
>>>>>      full page
>>>>>    btrfs: extract relocation page read and dirty part into its own
>>>>>      function
>>>>>    btrfs: make relocate_one_page() to handle subpage case
>>>>>    btrfs: fix wild subpage writeback which does not have ordered
>>>>> extent.
>>>>>    btrfs: disable inline extent creation for subpage
>>>>>    btrfs: allow submit_extent_page() to do bio split for subpage
>>>>>    btrfs: reject raid5/6 fs for subpage
>>>>>    btrfs: fix a crash caused by race between prepare_pages() and
>>>>>      btrfs_releasepage()
>>>>>    btrfs: fix a use-after-free bug in writeback subpage helper
>>>>>    btrfs: fix a subpage false alert for relocating partial 
>>>>> preallocated
>>>>>      data extents
>>>>>    btrfs: fix a subpage relocation data corruption
>>>>>    btrfs: allow read-write for 4K sectorsize on 64K page size systems
>>>>>
>>>>>   fs/btrfs/ctree.h        |   2 +-
>>>>>   fs/btrfs/disk-io.c      |  13 +-
>>>>>   fs/btrfs/extent_io.c    | 563
>>>>> ++++++++++++++++++++++++++++------------
>>>>>   fs/btrfs/file.c         |  32 ++-
>>>>>   fs/btrfs/inode.c        | 147 +++++++++--
>>>>>   fs/btrfs/ioctl.c        |   6 +
>>>>>   fs/btrfs/ordered-data.c |   5 +-
>>>>>   fs/btrfs/reflink.c      |  14 +-
>>>>>   fs/btrfs/relocation.c   | 287 ++++++++++++--------
>>>>>   fs/btrfs/subpage.c      | 156 ++++++++++-
>>>>>   fs/btrfs/subpage.h      |  31 +++
>>>>>   fs/btrfs/super.c        |   7 -
>>>>>   fs/btrfs/sysfs.c        |   5 +
>>>>>   fs/btrfs/volumes.c      |   8 +
>>>>>   14 files changed, 949 insertions(+), 327 deletions(-)
>>>>>
>>>>
