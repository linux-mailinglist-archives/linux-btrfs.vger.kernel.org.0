Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D893C415B40
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 11:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240232AbhIWJqf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 05:46:35 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:20254 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240221AbhIWJqe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 05:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1632390302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1WaMiEypD0yNJiC4pndHVkBl6bkihr7N1k5I9DTdKSw=;
        b=IZYSrNbOPxeHN8U4tKlpx2BYLkAVbIIUnQMyc+ohc8dJrtI8HPzAZobn3t/3Z7w0wMBV1b
        4jc1lxB2yuc0ECZFEp0RwyAWTps/GnK/H3eibQH2wXsh5UfmcXfTp/lyXlFgOgFiUnCNJF
        +BpVVCyuQHE0d/NQasa6K/Foxdd0caA=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2050.outbound.protection.outlook.com [104.47.10.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-28-Mvnxd3-2P8mVSg8_0yY-SQ-1; Thu, 23 Sep 2021 11:45:01 +0200
X-MC-Unique: Mvnxd3-2P8mVSg8_0yY-SQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij6XD9jjW+x6A+tU+Bo8iIQ2u0+Tk+NcinV6miC3bZpIw3dWKp0f2HwB52my9qE9LDWCF219wkCJP2NQ9R75RnSWSFKI69PTlEkag9i4HMfFD0mttXQEvsPKgzDLhKOga5bdAP05HMUg+s0OXID1K9KzvaOnyc6iQKCc381ouC0uDcNHjFyr2m2ujSGI91wIuQE7Bp3B0BNfxdycuZCkj+ZtVNkltG9UNDvmCuq1ojasmkvJvYYctPOMCLv+8a5frufpErZ7vnlwEBNHORn+CnBb98coUOBBHAsiQS9DAWcqbpryNN/b/56dN0PRZBvhhqQBR0vTyubMEi1QgzII1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1WaMiEypD0yNJiC4pndHVkBl6bkihr7N1k5I9DTdKSw=;
 b=jjPzylWh7KSRAK3Wp3ToM4KBxPIfj3teqw/Y2sZDdUGINHB811S39NuDTY8H0kuCyTiEmAjAWX9Ta7t2iZwJB4xFW2sBOc3YdjR/Txx0FwG612F7qW0VT6p68X0QChnjN8yrDVCd7F/1Hz/AHnMuCwiC8+QJzCvN6qoR9W/0DHfRF6w4E9MiPSOcTLVPiQ0dwcvU36h2Jxx8P5eFD91LiFH/dkpvIXtPH5x4oMIFbM7Ga0jcFKmbpbiFD10gu1VAbkFQ8WknHjx9ag0UgOVzKQwCNmnN5sFwUOQXy9g7drOKyXOiISCfvEKG1rM3diKKFMsG6p6hPzOtKjbUXxDMgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR0401MB2563.eurprd04.prod.outlook.com (2603:10a6:203:36::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 09:45:00 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%5]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 09:45:00 +0000
Message-ID: <529263b6-4ff9-1bf6-8566-ed1ec648a539@suse.com>
Date:   Thu, 23 Sep 2021 17:44:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: btrfs receive fails with "failed to clone extents"
Content-Language: en-US
To:     Yuxuan Shui <yshuiv7@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <CAGqt0zz9YrxXPCCGVFjcMoVk5T4MekPBNMaPapxZimcFmsb4Ww@mail.gmail.com>
 <e45e799c-b41a-d8c7-e8d8-598d81602369@gmx.com>
 <CAGqt0zyEx1pyStPVTSnvsZGYKAGEv9yUunv-82Mj6ZED3WNKRA@mail.gmail.com>
 <CAGqt0zy6a8+awo6ifUn4x+WxN=c6e8PnuMW5kYRodxOQ6vwU-A@mail.gmail.com>
 <72d66f13-6380-7fcd-3475-8152caa965c4@gmx.com>
 <CAGqt0zz+=nUYbNwLSPYwzYcNLgyxsWT22p+jwwFpAOcyAHAWgA@mail.gmail.com>
 <e83029f0-8583-91b9-47c8-a99d4b00a6ae@gmx.com>
 <CAGqt0zykaioT1LJAtOM8Zc4eJBXxTEy2ugBrLpgZ=BzCJzixXQ@mail.gmail.com>
 <CAGqt0zwchNdLKz4_qHrdbuxx7RWY9YbdiZ4KBYJcrwWa3sxBZw@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <CAGqt0zwchNdLKz4_qHrdbuxx7RWY9YbdiZ4KBYJcrwWa3sxBZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0138.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::23) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR13CA0138.namprd13.prod.outlook.com (2603:10b6:a03:2c6::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend Transport; Thu, 23 Sep 2021 09:44:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d587f81a-ed63-4696-1823-08d97e76cf45
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2563:
X-Microsoft-Antispam-PRVS: <AM5PR0401MB2563946A06F1B49E32BCB7E7D6A39@AM5PR0401MB2563.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2gdS+8Gh6xAud5OS/W5isLppQmvVxeUQdfEO1RY4ztTUQcOAuB1lZ5z+zWVFRAlrSrmUG86Ew0KWFUNkVQMtYPY5UvIEgrAWEAGALQNKOLVH3eZeshLOE//XTZoK5uUcr/Gv9a7vJHkopZdUmxQZacKsgV7zh7jGzRJWtlksQ2EcGRe8p0+Dfg/ilwyb4Ykurbh7yqGRo+bvdLln2+OM92TYVuBjQXmOEDc0hmNPXUrclOHjpmA/fyYX7nMBHOAYNFvQaJNdQ3iWDatXMyHE/cVbDQ5a/0A+YrVfGwI9vcP70WTPnqL119Hg1jtJ2bFmB9elaEwuQWG7mfTHG+TlOgEOEoLH9GzdqKzmW7KuskcmbMFov6ogTnalHQ2bAjcIEj7rKneMaWb1CalyJsnzL8vZABL8LjVqEbY1R3lCpe6g7IhAxpCjP+XDFtLEBAWGPzshUeN0py+7YxLGaPiWErUWuSp9WTMaLZcwbGnP7o4xh37+cIhUaPbpYltPiuiRD0xIGgoZjcLGNtpESIMtu1GaRAYsZF5a0LlVGWKX4wcl/x8sAr1qV/D32Tns/v7PROYnHwblEch8gXOV3YPv327gN3Zili4wwjUeu35HPOztUsYzgjM6/T5MgVdNr5QmQRqtPrBI4a4h1nqZKh9ixfW8BDC5tkzYYFlZn5/4Am3f+12b41VJ3U4OFzQd9xLNTdHsso4BaEzKz8PbJIIzG2XWeq5xhxORbePTLnOM36hUGBaCA3jsp08/6zxTyYqd2I6W7jQXKAgtUZvF9q7oX3vwZrry9I/5TepqqYcqnkiWom8Xul+kwSryb1MpMICx5aO67tz3tKX9Mbm8OWoiUdJtX+4EYGGtp5Vk8GLDShAYw3HsuKFgH/WYpWdpE5Wa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(86362001)(83380400001)(66476007)(66556008)(508600001)(36756003)(6666004)(8676002)(2616005)(956004)(966005)(38100700002)(6706004)(66946007)(2906002)(6486002)(186003)(8936002)(5660300002)(110136005)(16576012)(316002)(53546011)(31686004)(26005)(518174003)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blJLR2dpa3Z6ZHhpSUFhSEtxZ3VWb0NEbnhwT0MxSlI5UFdHdDBVcTFzV0Y2?=
 =?utf-8?B?OFZra2dKRzB0RUVvRldSVnh4NXVVNEM2L1dUblpXL2l3Tld1MG5YcmovSzFU?=
 =?utf-8?B?Zm1BN0NCdlhsQVJ5RC9oMEhnZHc0MSt6eDN3aXhuSW5kNVlYeXBPdEdsWWhL?=
 =?utf-8?B?TXBQRG5GRjVraSsrYkZKcHoyREFxTngyRzU5NVdVclRFTVg2bTNreHBvMEFM?=
 =?utf-8?B?SFd3WEptWjVHWVY2WnV4QnRlSTY3TU5PWlh5elFsUy9pbE1CM0d3SXdPcFo0?=
 =?utf-8?B?NkphMFRoenNCNTExY1JFZzBRTjJYS0sxMWVVTlFCd3Q0VEEyTjBva0lwMkNR?=
 =?utf-8?B?ODRFd1BIOW5jR0EzUyt2SEc4bHFUR1c4MGRMZyttNmdYeHdjRklRNXgyQ1R1?=
 =?utf-8?B?amRwZWF5S2tGVFN3ZXowcjBnUy9VeFVzbHpMQzVzMnRsOXRxMURFV3NBaTNl?=
 =?utf-8?B?dDlmekZGbVUrWGZhelU1ZHRhVXF3cVQvdlA1aDdKdSt4d3JEKzVoZnl5eU5y?=
 =?utf-8?B?NWIxNVFiUHVma2p0RExuTm9tVW9SVUV0T3FESEVWK1hGaS9wM1k0TWF1Nys4?=
 =?utf-8?B?aUU1YWdLaUhxTDZnZDJCK0luN3Qydk1qdldORXA2T2l2YjNqeVFNdFpEamtD?=
 =?utf-8?B?bUJGdE1OZksyVldJSm83TW5VUWsxSlhhdkg4VmZYcncycjJuRWE4dUdWMFkz?=
 =?utf-8?B?K05Xd3JqVVdPT0tWRUJ3b1l3SFhMVGx4a0ErcisxMG5sQWROQWdNbGdFUCtV?=
 =?utf-8?B?anFyTmRHeWdSNGh6dXNLSE5MMlZsUERjSTl6bktKZ3lzY1cxakhHK3o2UEJT?=
 =?utf-8?B?djJ1ckV4NlBjb0llemJWSStvTFNsaDBqY1dTb0k5MFkvaldSZk5iV21RcFhK?=
 =?utf-8?B?U0tKU3YvMDduenpLVUtqVThMTS9raHZkR0pKemphb1NESTdGWG1JUFlBcXhq?=
 =?utf-8?B?UjJtMU02dWVEcXJoVnlhSmhkaUpMN1R1RDk5b2U5RGJNM2JBcFRId2lMdlJq?=
 =?utf-8?B?M0FmUjRLRXFFYjd0aDZIQ05pOGNmSTZSZEVuNXRBNjZoVnZZQXlROTI3V0xl?=
 =?utf-8?B?Sm5vbW5mV0ovYkwzZ3NpWnJvRnpWb2xBRVRvUnI1LzRHSXE3VGdXaGM2S1l4?=
 =?utf-8?B?OXNXMXZhRXJodXdEYXRaT2lMeXl5UWZucUFrV0tpMjVZQ3poVk9ub24vYVVl?=
 =?utf-8?B?MmxpNytTQ1RHT3AxekM2bnpjZTJPVnlYS3kwL3I3cW9GYWhkdzJ6bUs3OWNu?=
 =?utf-8?B?eEc0UDE0Z2I1ZnB4YlM4RjJjRDk0bHNJTW94NEJtMDRaWmVSNWN0aWxzbzhW?=
 =?utf-8?B?WnUzL1gxMXEzamdRUXhhQ3hhTU4zOTBjSjhRWWUzT1NPV0J0NGJCS3NTYXAw?=
 =?utf-8?B?S1NXcTQwZjlDajNwMEJjRkVkOTRSRXR0SEJ1ZEtWdGRjOHQ2SUlkSk1YSlBE?=
 =?utf-8?B?NUM0WXlaWEtDcmdxYkZuOUxzYUhDSFd4ZENvS2VHNFJHMkVvY0EzMmJaa2tv?=
 =?utf-8?B?YWJyV3QrRWQ4bEdjdXNXWUZLOGw3c2FMZVVkc0ZwSGxEMGxTQkFDTURvc0cv?=
 =?utf-8?B?Tk9Vci9QTVBlLzBjV3R3Tng4ZUREVUQ1YkVJQittSW9zb2dpeGVYZ3RYRlh3?=
 =?utf-8?B?Q3N4TjBZaFhsOVJ2cFBCVmFJZVg4dnVoWEVFdjl4NDd2M0xza1NhTnl3RXUz?=
 =?utf-8?B?NkhjUlprakdoNXVsTEF0TFNPSnZqb2Z6KzY3SGZBNmMrdlAvcUJMRlJtVXRV?=
 =?utf-8?Q?nTpICHgYrWQn4t6xYWEfkPFSpfnpyEtLmo3aZ80?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d587f81a-ed63-4696-1823-08d97e76cf45
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 09:44:59.9523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1LtIj8z6rLGzk8ZhGmZXbNZP4nc8LhEoKkMxfNA6VAe59j76eQhcwslGmFoYPQO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2563
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/23 17:43, Yuxuan Shui wrote:
> Hi,
> 
> On Thu, Sep 23, 2021 at 10:38 AM Yuxuan Shui <yshuiv7@gmail.com> wrote:
>>
>> Hi,
>>
>> On Thu, Sep 23, 2021 at 4:28 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>
>>>
>>>
>>> On 2021/9/23 11:09, Yuxuan Shui wrote:
>>>> Hi,
>>>>
>>>> On Thu, Sep 23, 2021 at 3:32 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2021/9/23 09:40, Yuxuan Shui wrote:
>>>>>> On Thu, Sep 23, 2021 at 2:34 AM Yuxuan Shui <yshuiv7@gmail.com> wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Thu, Sep 23, 2021 at 12:24 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2021/9/23 03:37, Yuxuan Shui wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> The problem is as the title states. Relevant logs from `btrfs receive -vvv`:
>>>>>>>>>
>>>>>>>>>       mkfile o119493905-1537066-0
>>>>>>>>>       rename o119493905-1537066-0 ->
>>>>>>>>> shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h
>>>>>>>>>       utimes shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include
>>>>>>>>>       clone shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h
>>>>>>>>> - source=shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
>>>>>>>>> source offset=0 offset=0 length=131072
>>>>>>>>>       ERROR: failed to clone extents to
>>>>>>>>> shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h:
>>>>>>>>> Invalid argument
>>>>>>>>>
>>>>>>>>> stat of shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h,
>>>>>>>>> on the receiving end:
>>>>>>>>>
>>>>>>>>>       File: /mnt/backup/home/backup-32/shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
>>>>>>>>>       Size: 145904 Blocks: 288 IO Block: 4096 regular file
>>>>>>>>>
>>>>>>>>> Looks to me the range of clone is within the boundary of the source
>>>>>>>>> file. Not sure why this failed?
>>>>>>>>
>>>>>>>> The most common reason is, you have changed the parent subvolume from RO
>>>>>>>> to RW, and modified the parent subvolume, then converted it back to RO.
>>>>>>>
>>>>>>> This is 100% not the case. I created these snapshots as RO right
>>>>>>> before sending, and definitely haven't
>>>>>>> changed them to RW ever.
>>>>>>
>>>>>> Besides that, I straced the btrfs command and this clone ioctl
>>>>>> definitely looks valid, irregardless of whether the parent snapshot
>>>>>> has been changed or not. The length looks to be aligned (128k), and
>>>>>> the range is within the source file. Why did the clone fail?
>>>>>
>>>>> The clone source must not have certain bits like NODATACOW.
>>>>
>>>> lsattr doesn't show anything. The entire file system is mounted with
>>>> nodatasum, though. But I assume if this bit is the problem, send won't
>>>> fail just on this particular file?
>>>
>>> If source and dest file has different NODATASUM flags (one has and the
>>> other doesn't), then it will also be rejected.
>>>
>>> NODATASUM flag won't show up in lsattr, thus you need to use "btrfs
>>> prop" to check.
>>
>> I checked but I don't think "btrfs prop" shows the NODATASUM flag. The
>> flags it displays include ro, label and compression only.
>>
>>>
>>> Considering you're mounting with NODATASUM, I guess that could the case.
>>> Your receive target is inheriting the NODATASUM flag, while the source
>>> file doesn't have the NODATASUM flag.
>>
>>
>> Interesting, but the clone is within the same subvolume that is been
>> received. Won't the whole subvolume get the same flag, since the file
>> system is mounted with nodatasum?
>>
>>>
>>> If that's the case, I guess we may hit a new bug for receive, that we
>>> should also update the dest file's flags before doing reflink.
>>>
>>> Could you remove the partially received (and fialed) subvolume, remount
>>> the fs without nodatasum, then try again to see if that's the case?
>>> (It may need to change the destination directory too to remove the
>>> NODATASUM flag)
> 
> Yes, the send/receive worked without nodatasum.

Mind to provide the full send stream dump?

This indeed looks like a bug now.

Thanks,
Qu

> 
>>>
>>> Thanks,
>>> Qu
>>>>
>>>>>
>>>>> If non-incremental send stream works, then it's almost certain it's the
>>>>> received UUID bug we're working on.
>>>>
>>>> I haven't tried non-incremental. If by received UUID bug you meant
>>>> this one: https://lore.kernel.org/linux-btrfs/87blnsuv7m.fsf@gmail.com/T/
>>>> , then I don't think this is the one. I don't have duplicated received
>>>> UUIDs on either end.
>>>>
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Btrfs should not allow such incremental send at all.
>>>>>>>>
>>>>>>>> We're already working on such problem, but next time if you want to
>>>>>>>> modify a RO subvolume which could be the parent subvolume of incremental
>>>>>>>> send, please either do a snapshot then modify the snapshot, or just
>>>>>>>> don't do it.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Sending end has 5.14.6 and btrfs-progs 5.14, receiving end has 5.14.6
>>>>>>>>> and btrfs-progs 5.13.1
>>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>>
>>>>>>> Regards
>>>>>>> Yuxuan Shui
>>>>>>
>>>>>>
>>>>>>
>>>>
>>>>
>>>>
>>
>>
>>
>> --
>>
>> Regards
>> Yuxuan Shui
> 
> 
> 

