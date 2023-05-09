Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26BA6FD2F0
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 01:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbjEIXFd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 19:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjEIXFc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 19:05:32 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A903E1BFE
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 16:05:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0q5+vzN3DbGvcgHtY2bo2SqiP6zaTnZ6IcTw+PDWoBrbxUS/goVwQ2O+bamxTlU1h/ql3UXrY30zyiAe8DbIC6Kyx7diDCzzBhP7TiuTzKRGn6uQ6eLAVCLpltSMDCR+FYpD31cqZ14x82F8vQERFHwd3igOa9H9As4IwGhLvLEUGAs9TBrU8T6IQK/adopjn9oIvKXlLmnkXmjY7n732i7SFd9nQSQWWsaIvgkDDAamR5NWs6Gc+I00qZcKGP94LzuCCq4bp3gt7Wf67EPXnk5dSaARsz41GO1odHhXuw+eFvoVFKx86g1P1Ts7QmJUV1kHXTP04B/bLnevh3CNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwHvSLi0b2RtCYNV5K3wGD2XwcCiCdfloRmdFT67qXo=;
 b=Rhpmxn9ONHiNsjDfak7CsBNZq7CP4ev/3OrmgKpVpsC+5sO9sqgh0KUtPKGN5rsU2Y0XNS+YaTN08x2qpIPb1vktA7A6bNy8CEZaX9ZmPQj42jyoSx1Sbrzdo5tFKSNXzbjJUSKBbk1USIHcJTYqGZuduVldpwsuYZec4YdGdENL1ExW6fPINgmoNwFkz9pJNzXWfrR4E1g4J1IlEWc0dYUrJZpSHCr3obVj0WK4C3BiuSo7/HKTjoesZdrxNmpZEa6sxUu5ygZYO36JToULUim08+HrKVdaC7s0eTs5eCppfUBQdiRTew8CyDJ6O7m8A54oqULbnXp2AJvz4mo/Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwHvSLi0b2RtCYNV5K3wGD2XwcCiCdfloRmdFT67qXo=;
 b=uU+oF9jwn8EtLHmJa+lc/Hy7UpQFcH8ZCT2rDpWo5Hevlm64FhuVsJ9pVSRadChINXQ6Pc7/JZtSOWE2ht5MIJxDbNkSbRufayTlWmwd6jnUQAM1d6Ie7PHv8Vrb7IdAsy+4wBFIsXKX1GDkWuWONhhWOst/+86HpJs+MpMlgENVen39Jsv+AZD36UDybWbNwHd+VK20bZ4zU/wRI06cVEOSIjVGsAZwemlBCVfkwHbCipMdupr8nnWakI5yc2FXTpZfdJWxOxhZLt4zliB5Lx6se9d5ns1Ut14RAzKajF8ppiGONxDwvb+bkNMSup8NtCtbJb0mUluy8vCOnub44g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DU0PR04MB9635.eurprd04.prod.outlook.com (2603:10a6:10:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 23:05:28 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2%5]) with mapi id 15.20.6387.019; Tue, 9 May 2023
 23:05:28 +0000
Message-ID: <1c9a0f23-e94e-a7cd-f3d2-3675566fc40a@suse.com>
Date:   Wed, 10 May 2023 07:05:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH RFC] btrfs: fix qgroup rsv leak in subvol create
Content-Language: en-US
To:     dsterba@suse.cz, Boris Burkov <boris@bur.io>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <c98e812cb4e190828dd3cdcbd8814c251233e5ca.1682723191.git.boris@bur.io>
 <23f9b436-223c-918c-a3fd-290c3ac3bd7e@gmx.com> <20230501170930.GB3094799@zen>
 <20230509222959.GJ32559@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20230509222959.GJ32559@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0383.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::28) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DU0PR04MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: 86901899-82a2-4eba-d862-08db50e1e18b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E+AnNC6HAYvYyt/dAS+9rzGAUTMHhgZQ7eI6dEBZl5Pw6eZauH52OWfpSBsy8f9Yjr3XfNTvH0YG9SNq95muhZCNYQ9OYZri9kv8RP4wa6NiWneFu77WWdnVYnTZjAMd7pupMZDBbWMFUy6T1AhTPzyjSycfygzKnrZt6T4jVZ1MyRVbFiJOkErlc2whNgxmAGk4YaYDuAP9+5fzqZax/cYNPNJzaqH4WsqxJ+bPHEDu8vxXdrn9HktEiZN39/0EDKZQu3Z9kRbNqfdDoXQp20VRZ+D9Zu/zg9QK3ffuXoeL7TWg8gfSwaCVmHVpRnz4uIH+jM78ZOA9yRTrVjlRGMLDpvJxTQtUO9ZeDWyAq+PVVBeQm5F4FGHUzGqta6OAWonidkv3p2cApPewkcg2zB8RmsCUAQVN6/sTckBiN4qZNSXC5844QAQjzaU9jhtCXHZPhEDpr4i5tXc05CvMjraBX1c8Fz3iqbGxli8tGn1nYULQr3DzGTPJD21KBjNuwARji7j+ILRJ5E1Pqyb9qUFw5WwstVReT0booMah9k/LHOSJT3rVbyQ0lOe0g/qX3iV/hTer+wQ659UOHSNMJMKMHhL6G4BLgRhAJZeZV+XW+ChmQcfYMxqGBOa7xh39q8tsS5ws38L7hkbywr8y6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(366004)(376002)(39860400002)(136003)(451199021)(6506007)(53546011)(6512007)(186003)(478600001)(31686004)(83380400001)(2616005)(6666004)(8676002)(966005)(6486002)(316002)(86362001)(41300700001)(5660300002)(38100700002)(36756003)(6916009)(66946007)(66476007)(8936002)(66556008)(4326008)(31696002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTkvY053TUlGYzNiVlVLY3NvbWtRZ3NJZEhhUzVRMnprbWlGQVdxWGltc1lk?=
 =?utf-8?B?TXE5SDY4eU1tdk5HbW8xQUNrYXlyTmJaMHdIbjNaeURrcjZFTkRFZlRScDUy?=
 =?utf-8?B?c2Y4WDIwMmNCa3IwVU9QZWpPK2lqdmE5anhvRG9IZ2hrVHlZWUluRS8rVzUv?=
 =?utf-8?B?OFk0QnBmVm1EUys3Sm1iVVNINXpGYlQwNVhSaTc2ajI1M25PZVlLeEZRM1Zm?=
 =?utf-8?B?eXNZdUxZT0gyV1AyOHkvQ2dBVDN6cnZ4YlhLRHN0RWE4YUtPQ3FRdENabWlj?=
 =?utf-8?B?YTdqRXVhYWtuM1lhQlNGNDRyRjROQU5henRCMFJ4Q2pBRWZ2RTJ1TGx2Q0FS?=
 =?utf-8?B?eFRoNEpHUS9BbUJTN2pERDVpTHdUcDMxeGE4MXRERkUxUHZuWldDSngrYWZB?=
 =?utf-8?B?VEVtdzdLMVVpSmFlRjR5dTI5d3F1N2ZDZm5Lb1ZleE12MkIzWDNRYWlSQi84?=
 =?utf-8?B?bytIR3BPNGs4N281cm9FNndoZmhTdlRzVFVBVmJaWkZIOTZRMDV6ZkZoZXUv?=
 =?utf-8?B?MWpCQjlqRk1MOWZhNE1iNVlHelVPZEEyZkVyRjZXeG80b0ZPY1lCS0pUblNB?=
 =?utf-8?B?aEFPdVR5VlUrdGxyVVZYNGQ1b3Y2U1hFVmp1Y1NKcDlnc2k0NUF0ZDZhL1B4?=
 =?utf-8?B?Q1NiMkp2MDNjWkEwQ3U5SHplTVp1ZU9kYTVDT2ZXNkZHVTkxdUNyL0RhYkU2?=
 =?utf-8?B?WFI0TWFuY0tMNDk4Tm9DK1ZFNUFDUGRybjNQeFFXMFVjUUo5cGFoeFR2YXZ4?=
 =?utf-8?B?RVdwZ2QwU0YrN1V6ZDdQd20vZ0dkVDk3OU1PTUE0WXRleGNEekYyekhybnFy?=
 =?utf-8?B?dEdaUGNtK1NLVUFCbCsvV3JNKzU5VGVxazczaUNNOXBocUFOaW5oazZaNENI?=
 =?utf-8?B?Y0hKVnBQekliVEczdVpwOUt0Qks0a1NLMmorUHlQZ3JzQmtLVFgwZVZKYldP?=
 =?utf-8?B?T0V5cytYM1FTcHFQZXl2UFFMNlV6ajVsWFRyakNVQUtXb0ZsNXRWTXlTSGlY?=
 =?utf-8?B?Q2NqQ3JZMHl6Q1BWa0w0eEREUXFuOUFCWmhqeTlxcUVaS2NxZ3lqTEtSOE9H?=
 =?utf-8?B?d0tvNDM5MGQ1NDVEbVNEZmx4SEF1b29oWm16c0lKZ0w2VHRybWV5cHgyS2JI?=
 =?utf-8?B?ZmhMTVRBd3pSekczSWZveEt4K3AwU2dZWlJyMkRFMnRLaEVuaHVHVUhUSUdu?=
 =?utf-8?B?bFJuRzJsczZWeXBiRDB5SStoQTVMUGpjYjlyYlJpbWRuZHVTOGJUKzBFamRT?=
 =?utf-8?B?SXo0RnZ1dW1jRGdvbWlnSFhGck9HaEJxN2JOT2twK1RDdmlWNXVTbytxNFlv?=
 =?utf-8?B?bzBlVDNTK0lUZEtBZVNsT2RxeHVPVm5vSlRsdXN1bTVEMzg3c3RTbzJHT0F1?=
 =?utf-8?B?TWJyMDVpUWtMRHF1S3Q0M0F6eVdTeVJnWkdPaXIzRGlGUXAzOTBSM0lXVFY3?=
 =?utf-8?B?UlgzdHY0OWlkS3NtRUpHcExTbSttM2E3NkFmZ1dWQUM1dTJZa1RCT2NWQXU3?=
 =?utf-8?B?Q3lweGRUaEZSelZNcGxpR1A3MlhKaXBHWlFCbFF0QmwwMVk5QzNJRkRlUFFm?=
 =?utf-8?B?dk4wRFhlbVNhQ0orYjZPSitzSXpLR1VGQ2tSZUxidXMxZmppVnlkTzZPMnVK?=
 =?utf-8?B?YmdsN2tVZktGbUZRMWN4KzFrUFh1WGxYU1ZiRXB0Y2xxaGo0SXRDRVpPRTZL?=
 =?utf-8?B?SG5ZZHE5ZjhkZHdxRlNiVE5RUHJLbEdabW10SHNNY1JDWmpVZnlXeVRwVTBi?=
 =?utf-8?B?eVJPdm9WVjJ3YjU0bnlZK0Rhais3SncrMWhIMmIzVHRJN1VsSkdWa1VzYzFv?=
 =?utf-8?B?cklWY3FtdHNHSmdIQTJhT2ZtWGVmRW5TYjNNeDBRd2JVVGRUSXk4RkxLM1JB?=
 =?utf-8?B?ZWt6VmVkVHo5VHk5TUxEUDRLQlRUeGVJZDFjSllJYUZqWk5FY2lZd1lubmtz?=
 =?utf-8?B?LzMxYXVsSXkwVnNRUDA0ZTBMS2dOblhOZGFaTDVnWVhRVDVBRGVyL2V0TkFa?=
 =?utf-8?B?WGtXV0pqYUNVeG5VdXZDR1RkNU93UkpuUUU5MGU3SVo4UWxJZG1Ob1Z4NHpN?=
 =?utf-8?B?alJqWHA5VS9uYnpSb2kydWhiUDY4RHlKclNJZHY5eThFOWxSRFVhdGFKRDZu?=
 =?utf-8?B?clFSNXJZVTRCSTY2NGxLdVRmQkxnTmR2RytWMmFXbE1pMUFhc012MS9Wck5r?=
 =?utf-8?Q?nltOi0kHvBKLgUs2s5MmZLw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86901899-82a2-4eba-d862-08db50e1e18b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 23:05:28.7243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOKDW41jHKjkaxASSkXYbteCJXphqbfKj8hFy/WLYLsFpT03FtOkmQVCjaIRM/UA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9635
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/10 06:29, David Sterba wrote:
> On Mon, May 01, 2023 at 10:09:30AM -0700, Boris Burkov wrote:
>> On Sat, Apr 29, 2023 at 03:18:26PM +0800, Qu Wenruo wrote:
>>>
>>>
>>> On 2023/4/29 07:08, Boris Burkov wrote:
>>>> While working on testing my quota work, I tried running all fstests
>>>> while passing mkfs -R quota. That shook out a failure in btrfs/042.
>>>>
>>>> The failure is a reservation leak detected at umount, and the cause is a
>>>> subtle difficulty with the qgroup rsv release accounting for inode
>>>> creation.
>>>
>>> Mind to give an example of the leakage kernel error message?
>>> As such message would include the type of the rsv.
>>
>> Sorry, missed this question in my first reply. The leaked rsv is the
> [...]
> 
> There's a lot of useful information in your reply, can you please update
> the changelog and resend? Thanks.

The proper fix is sent from Josef:

https://patchwork.kernel.org/project/linux-btrfs/patch/e65d1d3fd413623f9d0c58614a296f0ab5422a05.1683057598.git.josef@toxicpanda.com/

Thanks,
Qu
