Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6381E1CEF6A
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 May 2020 10:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgELIpq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 12 May 2020 04:45:46 -0400
Received: from m4a0072g.houston.softwaregrp.com ([15.124.2.130]:60361 "EHLO
        m4a0072g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgELIpq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 04:45:46 -0400
Received: FROM m4a0072g.houston.softwaregrp.com (15.120.17.147) BY m4a0072g.houston.softwaregrp.com WITH ESMTP;
 Tue, 12 May 2020 08:44:33 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 12 May 2020 08:45:17 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (15.124.8.12) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 12 May 2020 08:45:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OI3NtgO5TmdQT6prKnLA55YnlbUHeTE7WSYes9oca7wFJ02VT5/5Jc+to8CMwV/bYiJXt82G1zwRgxnbKmwc0wXfq8dloZ49pEwh2SZiMHugYzThYh2vOl+WGkxLuPJEmTODd5ToRAhrrCjQc0Kd+1x1gj3NdZ7eircyAhRy6NMU8iHzCP3WeWmf7Mg+c9ao8pQoRP4BNZMqtPrvHARN/xre66h2jdhfUFx6rBT55+XUTX0JgUuSX6z/ZTH+TvmSC3+WjlhfgN4lzA/UXWzwqwbveXU6NDojiP3L7pFiRk0uVYbkZX4ZbdHiQ3gWjavvNFTzr1eAhWpx/ZbHcBt4cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRSn4jnHQ4ELqTOTl1SctFuVe9zrC4geHZzeNEBezP4=;
 b=oIH7iajN5tZBtdAyvc4N9xHUthS2naGn1yIrAJ3QenzfMia7vPVAX3s1ES0GVnG/p4rZD7mj+EeA0GdyHG0TM5/tEG8AZLJhkAKGqC1GPIyc0yqMqbM6+ZUg5ynLEtPoDvl8ERtDoia695+UTXP2VuOVTLcP1EGj5bBXqdUmKaksRYOp7yCoDrl8DoCpzwRCO7RnPfmO156RyPcqByzC6QcKgy4JAIxOiMhoQWWCN6Kk2ktM3BgMoT3Iwj/HBSjSX/bg19kD7+NR73IJousS4u6YcgATcAbzPvrhkTfaCnJGhmU7TNtt+7PQvRniAKaR2imiLEw0GBbHJjDVUAo8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from MN2PR18MB2416.namprd18.prod.outlook.com (2603:10b6:208:a9::25)
 by MN2PR18MB2528.namprd18.prod.outlook.com (2603:10b6:208:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Tue, 12 May
 2020 08:45:16 +0000
Received: from MN2PR18MB2416.namprd18.prod.outlook.com
 ([fe80::8cf0:641e:631d:7a6]) by MN2PR18MB2416.namprd18.prod.outlook.com
 ([fe80::8cf0:641e:631d:7a6%4]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 08:45:15 +0000
Subject: Re: [PATCH v4 00/11] btrfs-progs: Support for SKINNY_BG_TREE feature
To:     Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, <dsterba@suse.cz>,
        <linux-btrfs@vger.kernel.org>
References: <20200505000230.4454-1-wqu@suse.com>
 <20200511185810.GX18421@twin.jikos.cz>
 <ce5fe286-fa4a-e282-3b92-564cab62b776@gmx.com>
 <61c92960-038f-068c-8ee8-a6d657739f16@suse.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <483ffe99-34b9-059d-a659-e9e1c62691ef@suse.com>
Date:   Tue, 12 May 2020 16:44:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <61c92960-038f-068c-8ee8-a6d657739f16@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BYAPR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:a03:74::47) To MN2PR18MB2416.namprd18.prod.outlook.com
 (2603:10b6:208:a9::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR05CA0070.namprd05.prod.outlook.com (2603:10b6:a03:74::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.12 via Frontend Transport; Tue, 12 May 2020 08:45:14 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4611353b-c09d-4a36-1ff4-08d7f650cac1
X-MS-TrafficTypeDiagnostic: MN2PR18MB2528:
X-LD-Processed: 856b813c-16e5-49a5-85ec-6f081e13b527,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR18MB2528F1AE5EE1F316C57B848FD6BE0@MN2PR18MB2528.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VdlW9ANv9va4eNW291560sLQoUs4RSSFX6yjEedI53/3Xmc56vqgKDc3T7v8h+N6zYI7I4O45F3Dg1UWTCkH49B1cHnbvLsKIDgYrTjsYbvtId0EXlGmydUEEboHkpYExCfL+iSW1Dqc0X5ArWdt+Vvc9z6Nrg4zWnhkAmfseXdx3lYozVTIPu7d50tQ6uc7X/5sDUCBq2UWnV0xyuFdqvocb8im5rY9CEKL4yEp83XgdArpkyHZ6bbyeAI+RSyyqPmNZe0+pIUDStblTzjDOUICuleJmJw52FsdcBwI+YKMVbjnA1vFSlrWuucnar8wsS/Ve25s472yTOmfpmrEAxLB5/FJ1IFKKXjZxBvZvo9GAlo9AIh6szSOK2fYOOODXs410W+YJ0QnRihSTVZaJrItJlh03oQTqlhYE1rraaApbmo0IoI4MLOOMP9hvokjeIUXl3mjhE4AriNvyN+VwQWz3W6+7TNuWh4jRABS8gvc1v/buu10vAOtt/tmICjszqtVEA3gwAQtf3Pm4PEYPPRemzyyTPOBVYuyRXHrOQp6O0FLhwrV9hhJ2khyTXLT0WvwASp0/G0XHKfpNT/XJGppXKE/jT1mPI/4WoxWR/2SK75IVJnzGz11qlK8y2k2fC9/mTXbf1J0LfedzFuPDgUjjSnbpOCZNfxApSzyVdZyt6BYP40kF3XJU3z95u5sbdZERHKvtCjUO55o8EoM9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB2416.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(33430700001)(36756003)(5660300002)(6486002)(956004)(2616005)(66556008)(2906002)(31696002)(86362001)(66476007)(66946007)(26005)(966005)(31686004)(8936002)(33440700001)(16576012)(186003)(52116002)(6666004)(16526019)(316002)(8676002)(6706004)(110136005)(478600001)(78286006)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 1UjDgS8hbmWKafk+BltKsNXpTJVDTsf99h5zbleYQkOPjMjjtQ+KaU+Yvy/490pL1OCjPf4D1T4oKOZPov2EvFNNa3xrN87GyIBXxhqTakWwMRvLYFFUs/YIFg2Lrw+8cqnxEfecSxP5XP+RTMaB0iDql9x+p6AL8MVIr6hySgSwk2Z5UGbXW7431wpkyAwl1FUDahmBdN9PS8VISaOQIzAIIUSmBf5FBiuzjARCtadsdzFyk2jH7EsfEc70q7eyUGLms5l1uPjUoqNqcIc0i1K4+AeDLbEpkkZBEx6jFuRJhSMt01Laa1ZrnX0+yDm7TK0XpX3f7iUbJGIs0RSIiSx9sN0E+hj14DOCpnO0+8lnhy/NIRsSfTVUurH2jBTpfPFCYnVOyIqcd0DGjpJOnfpb2d1sPlZV44TFKMSduI6jw8rqRngdkR8v4jH8SzJU2mzvhC3Kh18m1gKi0EsYnbhF5orqIVk/KlBXXzKlrYw=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4611353b-c09d-4a36-1ff4-08d7f650cac1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 08:45:15.7594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGIlj6gS+BuFASrfRa6B2X6oCavw/rnFyg5OacroYA4JsbOLRGHRm9HxrLKFl5/l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2528
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/5/12 下午4:21, Nikolay Borisov wrote:
> 
> 
> On 12.05.20 г. 5:30 ч., Qu Wenruo wrote:
>>
>>
>> On 2020/5/12 上午2:58, David Sterba wrote:
>>> On Tue, May 05, 2020 at 08:02:19AM +0800, Qu Wenruo wrote:
>>>> This patchset can be fetched from github:
>>>> https://github.com/adam900710/btrfs-progs/tree/skinny_bg_tree
>>>> Which is based on v5.6 tag, with extra cleanups (sent to mail list) applied.
>>>>
>>>> This patchset provides the needed user space infrastructure for SKINNY_BG_TREE
>>>> feature.
>>>>
>>>> Since it's an new incompatible feature, unlike SKINNY_METADATA, btrfs-progs
>>>> is needed to convert existing fs (unmounted) to new format, and
>>>> vice-verse.
>>>>
>>>> Now btrfstune can convert regular extent tree fs to bg tree fs to
>>>> improve mount time.
>>>>
>>>> For the performance improvement, please check the kernel patchset cover
>>>> letter or the last patch.
>>>> (SPOILER ALERT: It's super fast)
>>>>
>>>> Changelog:
>>>> v2:
>>>> - Rebase to v5.2.2 tag
>>>> - Add btrfstune ability to convert existing fs to BG_TREE feature
>>>>
>>>> v3:
>>>> - Fix a bug that temp chunks are not cleaned up properly
>>>>   This is caused by wrong timing btrfs_convert_to_bg_tree() is called.
>>>>   It should be called after temp chunks cleaned up.
>>>>
>>>> - Fix a bug that an extent buffer get leaked
>>>>   This is caused by newly created bg tree not added to dirty list.
>>>>
>>>> v4:
>>>> - Go with skinny bg tree other than regular block group item
>>>>   We're introducing a new incompatible feature anyway, why not go
>>>>   extreme?
>>>>
>>>> - Use the same refactor as kernel.
>>>>   To make code much cleaner and easier to read.
>>>>
>>>> - Add the ability to rollback to regular extent tree.
>>>>   So confident tester can try SKINNY_BG_TREE using their real world
>>>>   data, and rollback if they still want to mount it using older kernels.
>>>>
>>>> Qu Wenruo (11):
>>>>   btrfs-progs: check/lowmem: Lookup block group item in a seperate
>>>>     function
>>>>   btrfs-progs: block-group: Refactor how we read one block group item
>>>>   btrfs-progs: Rename btrfs_remove_block_group() and
>>>>     free_block_group_item()
>>>>   btrfs-progs: block-group: Refactor how we insert a block group item
>>>>   btrfs-progs: block-group: Rename write_one_cahce_group()
>>>
>>> I'll add the above patches independently, for the rest I don't know. I
>>> still think the separate tree is somehow wrong so have to convince
>>> myself that it's not.
>>>
>> One interesting advantage here is, separate block group tree would
>> hugely reduce the possibility to fail to mount due to corrupted extent tree.
>> There are two reports of different corruption on extent tree already in
>> the mail list in the last 24 hours.
>>
>> While the skinny bg tree could hugely reduce the amount of block group
>> items, which means less possibility to corrupt.
>>
>> And since we have less tree blocks for block group tree, the cow cost
>> would also be reduced obviously.
>> As one BGI (just a key) get modified, all modification to other keys in
>> that leaf won't lead to new COW until next transaction.
>>
>> So personally I believe it's much better than regular extent tree.
> 
> Perhaps it will be more convincing if you could substantiate those
> claims with numbers. I.e run some benchmarks and show numbers under what
> cases the added complexity brings positives to the table.

Exactly in the patch implementing the feature:


          |  Extent tree  |  Skinny bg tree  |
----------------------------------------------
  nodes   |            55 |                1 |
  leaves  |          1025 |                7 |
  total   |          1080 |                8 |

That's 1T used fs with 4K node size, which has at least 1024 data block
groups.

The above number is the needed tree blocks to be iterated to read all
block group items.

Thanks,
Qu
> 
>>
>> Thanks,
>> Qu
>>
