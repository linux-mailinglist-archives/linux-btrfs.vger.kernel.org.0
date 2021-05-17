Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B112386D99
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 May 2021 01:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhEQXW0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 19:22:26 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:41427 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231318AbhEQXW0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 19:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1621293667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gs8wkSG8T0iTR41BCxQXpIBka0ap4K2WLj1L3iTGdUY=;
        b=PoJBr1E1FW0TjCx710ftJ1zJPhKFRnzXqxe98aWtKVRShu03HCh+71He4nVkq5wlhz+BkY
        Lr5Nsnwwk/qlax0gQ87cBXj/mN1IytB1wSlimBcs54hLgQE6efeTuEiTbiTDbq+b6Jur1r
        M8YTwn/VtvspQn/xxQdOAg0xQ8Alxow=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2054.outbound.protection.outlook.com [104.47.14.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-15-yrVDOxQxO4aLA8D0jTdBJg-1; Tue, 18 May 2021 01:21:06 +0200
X-MC-Unique: yrVDOxQxO4aLA8D0jTdBJg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dS2U3wRSUG/ny/o9vCD58y8Q2wxFFXjlvzSwzpdCHgv6VfzekpD5fP77cN+ODcrVB8251bEAWghh+sDsBmXUCyVxDLNb37iqf+s/BHYs9QdEH+NGFEdhcaZTh06OF5Fq3e+//TMp51lAojRmQs4RJQEWPII/CeVQ9vQzN0xq+I3qz+YE7wbzCjOv9hX3VbKGZaRoTdhPMsYS5K/uI+JMYhWIj0fkTdFeO6JaCc5qhATCbMfsYCBB+Th5aSHOClG3l3np9nMwXQcGUgX7OAi2TFt0+9lwI6qmlCIUZsyZ594NHcLEvfeUBU1409MIlCimEUC9dvKvxuaXbXYkV3Es4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SraoKzTLf03zPdsJQTWMC/bqEHOgOWbIYpooOb5G4A=;
 b=DL4DYPMIaxBkZXZY5BfcfNzb216p2t5wYQnKGpbUROQ57A0tT+wnbr4O3D9PDZNnm+wyb73XWhRI3SMch84Xmq6aDYkSZbRGbDSnaNWiYLPrbI06MG+LlDWxiE+rZJBhtGXU39EnAlwUwdomVU9yRWMruJUvmVShBYntpCeMQLNMEqZjOOfzu66gvnrjidfevPYTNXhtXmGOEwa5/5m3y5RvXuh8I6yiZRCSgCvew5FGwRjRH7Oywn5hA2iiepjOKKbC205OdYOWzIiEp2YiHQcv3INkxZzjZ6qDP4BEHMsIvvqUmeqA7tBNzA+ElNBjGiK1JHgz1RrzKxagoWGoSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB8167.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Mon, 17 May
 2021 23:21:04 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb%7]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 23:21:04 +0000
Subject: Re: [Patch v2 00/42] btrfs: add data write support for subpage
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210512221821.GB7604@twin.jikos.cz>
 <de2c2a25-a8da-4d69-819e-847c4721b3f4@gmx.com>
 <36e94393-d6cf-cc3d-d710-79c517de4ecc@gmx.com>
 <20210514113040.GV7604@twin.jikos.cz>
 <b2490ac7-7bb8-238c-1602-043bfcb09c8f@gmx.com>
 <20210514230554.GB7604@twin.jikos.cz>
 <2df5629d-cd3b-5da5-3917-ab66970cd8a0@gmx.com>
 <20210517132231.GQ7604@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <957ddd7c-6c5a-f1c9-dbca-4de3fbec9cf5@suse.com>
Date:   Tue, 18 May 2021 07:20:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210517132231.GQ7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR13CA0200.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::25) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR13CA0200.namprd13.prod.outlook.com (2603:10b6:a03:2c3::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Mon, 17 May 2021 23:21:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1577dbd4-43a3-4f71-3fd1-08d9198a7116
X-MS-TrafficTypeDiagnostic: AS8PR04MB8167:
X-Microsoft-Antispam-PRVS: <AS8PR04MB816714180244FBF785B8EF6DD62D9@AS8PR04MB8167.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yGtvNjgb7Vo2QSpPc8VD6gHgMcsYUhAAqSVQO9Eaz9I6TzFeYHkN5A8hoSJVojymNaCUc15k6IiJ8RgeK/DxzePHVnZWgICrg6uYVs8B8MflzxGiluXXl9GuwoPP5y0NVNVYA+wqUFI7odqnbpR82dCGjHrGAumfrq+NgI9UxEQzDMLiDLW0ehKA7ZMZO3YBuqC7jUPMVk/Q3sal9y5FSqH2A+ZlO6Hb5fn2sCWy4uwpYSsldEI88rE4/C1igqV/a+3Jm4OIAy/xt+ymP9bjvU9Iqq3ck9oO7SUwd6VAZ/FQSXQQVQfZLwEPYRaSh+HhF6nsg56d0Ng7gSCMY+9QMOaGszCEGumOkcvuLyGl+4VzNTYM8nwg7UtoDc+e8l5HeefL+g0Aso6cfAProF+xIt319DJP4k0/2+RelZLhr4qzWCiQET+rpXuwm16IyPX7bBq7oX/L5VkbBpkGranJgd9TKV3i0H1RG0g86qoe/bYq9id/fhKEEvUzSP9vs07I6S3N9Pq/iz9wqNtbkoxsfp4Cl6f020+wHIlrITMbnAuM662lyxB3wqcVNaLPNRCQ0jcTDxkFRHxnGOaJElaqvGdd+QGD+ngPN1dkQu+gGwquCyL40cbwBU21JMd+aoGOJEyxJP6ped6/IXgP4+poU54b7agB3kxbUNdog9td+QYh/j4kyoV2ipZmSVxpiGIMiRQ2bGPQZbiOiuZUVqOkJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(376002)(396003)(346002)(26005)(6666004)(36756003)(6486002)(83380400001)(6706004)(2616005)(2906002)(66476007)(31696002)(16576012)(316002)(38100700002)(5660300002)(956004)(186003)(31686004)(8936002)(66556008)(8676002)(478600001)(16526019)(86362001)(66946007)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?clI14mkDwAkn3zZJSFXWaOiJtjy9GO1S+HRGC/XnBfhnv/vNm4AR11IpqVMz?=
 =?us-ascii?Q?Ch/bqVcHNLys6rPoYpzcwTsGXUT4ePl4HAmCDOokd9cplTksjzwta0kstf7j?=
 =?us-ascii?Q?aNcFTsNt6gPFUGWFlWR2tpIHllwl1kR7Q8iDLPE30WrNslPhMCC8qjGAtMhg?=
 =?us-ascii?Q?MZZOSrTdenAbWbKOFbgxJcnP805LVYbmFy9W+IJblGiykOgWBDLMBvUeqyvT?=
 =?us-ascii?Q?VGWmpfR24ailEVUn7RM8NxBLQjGduSwD4ueeGyyN5kxJnLzzf8vsBhFVIKDN?=
 =?us-ascii?Q?PycHHf42nMx77n7IV5D2zHftmR1eVnzHsjbQ/LeRqp5Ha9upZoegqSDxJeoY?=
 =?us-ascii?Q?PgPOOG/BOfwuLxlmxKAQrazx7RBi5BAsEbq7WZsRYS7kAEK38LQTa20ego+l?=
 =?us-ascii?Q?ougrhV/gfpxZKr3gnLNUjnXDSKmxp6FE+eBVPR4W5DJlXGKoxg7O85ZXDpt8?=
 =?us-ascii?Q?0E+HDaU0SDvc7KT5OtmvNfWyr3UGL9vkZF5Jx08PuA/GUcTzpfKF4yM4Zj3W?=
 =?us-ascii?Q?330xDC4afx+dJbwc5amvaz14tXjQbXQjWSOvwLn+Y83VKnGDZPDDZ7HKzln3?=
 =?us-ascii?Q?Z+0yl6PojqHFORFV6NKLDTj4NuFg8Mn3e4WyEHVrZPKKUX15+ISQnv2rhlbS?=
 =?us-ascii?Q?yaGwpq6tcAyvJhO8/HC6cT8kzzCuVvOSjfkIvvzZIjqu+tWslI6ZeMrrLdr9?=
 =?us-ascii?Q?TUPhYzfALsJDrYrF1592T/kqyNfDNFmSba5YAc8sG7hYnWzJkAJdL4Xf/mPH?=
 =?us-ascii?Q?s2vmSXsn5TRnSsAEUt+HzacbJms0AfR9RthbafVOITXcF/zhkJ4UFrgHO4m3?=
 =?us-ascii?Q?Nqcu6ohPOeePBGka/lAz2faoCdKfERHkaFxTInA2bYf/VQ6yNQ43MUV5jalV?=
 =?us-ascii?Q?fY0ohFmvv0w1wxvghcEVumVrs5/Buapz93UCmai2DlcEqJt38g+8/RPFznhD?=
 =?us-ascii?Q?CQUlr6Y4PdeHkLBARlcCLzm3jy9lUx3oBbFycrpQwVZXZUnJXf6rCHJ3yCen?=
 =?us-ascii?Q?J7/re4lzZi8njp74Pz5mncLdAfjEwtSWmvnZc8O/rwKeQdnFKHKfal5qcoMi?=
 =?us-ascii?Q?+9tI5KVPZSUGVcZIZXayYidnAJfyTyImqP/aXkVZs2y+U1ZMQ5lZcrQooz1F?=
 =?us-ascii?Q?gAYytZFJljCMBcaTawVk6x2OVvGvSXUQorJVEP1sZPcA6lxDWM6yONg6jwK8?=
 =?us-ascii?Q?rUr/1wvYYa09R/CGVUQ9yxym30EwMxx0Wo22PNhqVc2agJtjOH6KwL+MAcVn?=
 =?us-ascii?Q?wGmMOzLghg35N+pao2hEfGrDK143gp+vGH0+cHvxEbDmaL0gOJueW9v/9ff1?=
 =?us-ascii?Q?8j08jV8g7x3phuNPnyUxMBu0?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1577dbd4-43a3-4f71-3fd1-08d9198a7116
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 23:21:04.7780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxYmTek3XFsGV53mlkFQlyTKBEUa7KpjDVqrwwUw2aCpxUGOSr896eA04dpDoOc7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8167
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/17 =E4=B8=8B=E5=8D=889:22, David Sterba wrote:
> On Sat, May 15, 2021 at 07:17:50AM +0800, Qu Wenruo wrote:
>> On 2021/5/15 =E4=B8=8A=E5=8D=887:05, David Sterba wrote:
>>> On Sat, May 15, 2021 at 06:45:42AM +0800, Qu Wenruo wrote:
>>>>> [27273.028163] general protection fault, probably for non-canonical a=
ddress 0x6b6b6b6b6b6b6a9b: 0000 [#1] PREEMPT SMP
>>>>> [27273.030710] CPU: 0 PID: 20046 Comm: fsx Not tainted 5.13.0-rc1-def=
ault+ #1463
>>>>> [27273.032295] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
>>>>> [27273.034731] RIP: 0010:btrfs_lookup_first_ordered_range+0x46/0x140 =
[btrfs]
>>>>
>>>> It's in the new function introduced, and considering how few parameter=
es
>>>> are passed in, I guess it's really something wrong in the function,
>>>> other than some conflicts with other patches.
>>>>
>>>> Any line number for it?
>>>
>>> (gdb) l *(btrfs_lookup_first_ordered_range+0x46)
>>> 0x2366 is in btrfs_lookup_first_ordered_range (fs/btrfs/ordered-data.c:=
960).
>>> 955              * and screw up the search order.
>>> 956              * And __tree_search() can't return the adjacent ordere=
d extents
>>> 957              * either, thus here we do our own search.
>>> 958              */
>>> 959             while (node) {
>>> 960                     entry =3D rb_entry(node, struct btrfs_ordered_e=
xtent, rb_node);
>>> 961
>>> 962                     if (file_offset < entry->file_offset) {
>>> 963                             node =3D node->rb_left;
>>> 964                     } else if (file_offset >=3D entry_end(entry)) {
>>>
>>> Line 960 and it's the rb_node.
>>>
>> Since I can't reproduce it locally yet, but according to the line
>> number, it seems to be something related to the node initialization,
>> which happens out of the spinlock.
>>
>> Would you please try the following diff?
>=20
> The test btrfs/125 hangs and does not seem to proceed. I've run this
> twice, same result, so it's unlikely to be due to the machine overload.
> The setup is a VM, 4 cpus, 2G. I can run further debugging patches if
> you need.
>=20
Unlike the generic/521 one, this one I can reproduce.

I'll look into this one.

Surprisingly, this btrfs/125 is not in auto group, thus it never get=20
executed for my x86 VM.

Thanks for the report.

