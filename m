Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62143AA691
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jun 2021 00:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhFPW0O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Jun 2021 18:26:14 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:54822 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231702AbhFPW0O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Jun 2021 18:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1623882246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1sgn14pVXzZ7Re6Yifux5yUm/T5ji9L61qxE+YN+mqQ=;
        b=grz/wsDTiWmAYJpjTLxVeJOkmXNZk3W7iMbRxgKmzcX7ogERj08UQjr+AoIe/F2B33FrWJ
        ttIBSy5xy3M3u1jDnAwCYJhIGLMpQu9l2TNEqNnrhLSHQEGLCFYUfluGyfdkZWK01+7TN0
        ClIdZXk8fLrdSJseNS9m/7enb9njQ0I=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2056.outbound.protection.outlook.com [104.47.2.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-5-A9em36bAPECY4Hpi0vp4lQ-1;
 Thu, 17 Jun 2021 00:24:05 +0200
X-MC-Unique: A9em36bAPECY4Hpi0vp4lQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtHxniL8Pdv1g//x0QKFm+zznLy62e7Q0QtMt3e8VGMhVdKhP7ijhawJ3kY3/N7FE8VSzyiMYhdgU1qt0R+eDfysVgxLUcChxbXGgsGLIlsTd91tNL88ZFZ90n3xZgs9GjdFaMQNhnC7dWQ1RKldfnlX8QL24699QGG20hLBrFOzrUB3dPxjZxSmsQ9UQXqJn/RAwVi6C5990wK8T5Rk4Tls8YcmFbo4gNBlq9NQHLbJzCbu6nMF7xDIPQ3jEoitIn1VJSYl7GwvxjVwUfkO63nb0HOZP84IOD0O9pu8C23+7vXuL4KbDzNkkBZC1bf4Jx6fG/1KFVezRMNxChGRWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibrqYBtUlE6ya/j7aG7vJZyvqiuzxzbm1M59v7YZGPc=;
 b=OUS92aIQJO108v00oBcPZ8boaC5EelXrnEvp/BasGqXjSIaPuQaOY9RqpWQeIK85G0FEl7BYs3qW607YdZVqsocmM1PbSXuj/Rbwx7T9awc8UMLuAK9RzT7fDjezl93esXZ2CJRQleilEm96SYYGTjTeuYpd7vlPLs1FMUnCi64vabaZQrMFz710xcfRUYGbHzrwXM2R3CYFE2N7EhA4wI/fvC2gpf5juoMT3qRJrsHkScWRZraxXRLDhrd6fyKqqATxqsD4/JU2p4IukSIfX7SVbbNUmgk8QT7g1OuQeTadpdyBkRHuLxbqLZoYZhbRIEytZDgW3CnkiqmlrU76Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR0402MB2785.eurprd04.prod.outlook.com (2603:10a6:203:98::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Wed, 16 Jun
 2021 22:24:04 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10%8]) with mapi id 15.20.4219.025; Wed, 16 Jun 2021
 22:24:04 +0000
Subject: Re: [PATCH v3 3/9] btrfs: hunt down the BUG_ON()s inside
 btrfs_submit_compressed_read()
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20210615121836.365105-1-wqu@suse.com>
 <20210615121836.365105-4-wqu@suse.com> <20210616140330.GN28158@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <a1638bcb-613c-bef6-0fb5-9ca3b06e119d@suse.com>
Date:   Thu, 17 Jun 2021 06:23:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210616140330.GN28158@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR05CA0144.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::29) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR05CA0144.namprd05.prod.outlook.com (2603:10b6:a03:33d::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Wed, 16 Jun 2021 22:24:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f641668-a4b2-490f-6e59-08d93115729c
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2785:
X-Microsoft-Antispam-PRVS: <AM5PR0402MB27858B1A1C6693B4E5243339D60F9@AM5PR0402MB2785.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JchuTc2N92zmnag4eHVnrG+DFWhSHN0eFSBcIHOFvqHvdIsQQcDKkFwvLVyRHCZe0yIzWOqVkS5RZw9h4K/FM2h7CT1zwP5K1vLzb+uiw6L7TGoDsrAiSefXGdYGzYCSHMwAm583Qsxy3hvfA2DtKGKKqk4gP9EnaryjV42H/mUA/qiiK5HDU9pvplkohxAYTrcGfggrHYEkiBr5kOPddUZZc0Ay9ijUljOGl0sbunVvjA8UvlCqjkqHG5BR5rhCnIveopZyPKDM3+D2gIcDL6fEl6wmAZnM6KTH7WhQqK6GxUVGPwolDvPYVcd3x9ZIGwc3rgEUnKvvJma5WGf1FOxObStHXcr5RqIS5IRjeN7CDG++KRxN25+HuChp887rgJVZ+59dkyZslsRtIweYdgMK4zg8cyDns7KnMheFYiZKHg8AKPzEvIeu3cZS7bidlSfE4OBrSVn9me8tFJqx3pGzqHRKbwgaPPJI1B6Nwv8pRjfp3IC9C6bx3Wkl4CFDaCUBjoP9EbMR1PJ+jDOzkn0nkGwEWbDfj5b7rPejtCc/XmFAf2Qe7RkLmm32ioK5yyCvr7dh2zl57KSsZFbhb8zHh/9FrM5GCnXUx3HobQt3EDQkTJYr65dlul7ksgiAxdbdeqvL/zwHHPDfMO2hHb5nYQaz0FGsL8RSeEKzJDBxhCos5Qq1oNF6azjDaaM1N34s3Bpd3fLx6+h11baidw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(376002)(39860400002)(346002)(6486002)(83380400001)(38100700002)(2906002)(66476007)(36756003)(31696002)(66946007)(66556008)(2616005)(478600001)(186003)(6666004)(956004)(316002)(5660300002)(31686004)(86362001)(8676002)(6706004)(26005)(8936002)(16526019)(16576012)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nt/9/NzrHOHIudijjB7lB3IZq5CUMOfMigwRE7SiIrz5DnC2hOggyc3WH5Q1?=
 =?us-ascii?Q?F5Oo8yoCTGgOJY1lumiyDGk6EyRwu1kMQvcXYTuFToW3YPhU1i771n15Ibx9?=
 =?us-ascii?Q?zhd+gWIq6lLi+eVVw7ynS91GwjhrDvDPX+JI0A2son0/4A9GV8I0CXyemFDP?=
 =?us-ascii?Q?wC51BeML2Xs4N1po5J0QgLf3AXI6cWigr6ZqyIComajVMKaw3OBkhM8p0v0g?=
 =?us-ascii?Q?pvMR+5r0Cptmh+AFRQ7jWajvvTYONXj9nyZ2EoQquehv2xZOv2anmBiPjK+f?=
 =?us-ascii?Q?EgaaSL7gcVONoit6bq1JdfEAao1STwb2loNONa/jyvMUaea8XHioyxDx7c6r?=
 =?us-ascii?Q?GJ2MzBorUq60CKZUb7iDxHfztOay+Zl9YofAr5b+6WQ/Q02kAW062+v8FjK/?=
 =?us-ascii?Q?DFTxv0qEbXTSwBX9NiZIpwXZB18a/WtudkNQpxa2aly1yuZC120m5gkxGFhE?=
 =?us-ascii?Q?1poUbLUmihoa6yfApdH6MN+QJM7wD4IX4m+oqh3O8YG0lgkjjsl6quXUpTS2?=
 =?us-ascii?Q?dbxwULCGBN5QcdPGcM7ZPYrx3+rK6qTgTAC+81RfU2SP7l/SwTqWtAo/bymj?=
 =?us-ascii?Q?ktanX++n6tjbHUHN0vSfn8RGloUUCbdd1X8YtTowAPuIo8pP7sESW4XnYlq3?=
 =?us-ascii?Q?n7AyyVdSgy7VjhCFr4gH5sEl0l/hgc5h33AVxNod3C+cQffAHMIFCwbX+7lV?=
 =?us-ascii?Q?3BtMNb4q5f/0nTFja1lzBSjLw2i9FX8iNAtnZ8LQjNhLX56a2vhliI+cX2A8?=
 =?us-ascii?Q?c9rDyUbvy0neHpix7HLGgx8GFxIqUCQXJiglkEPpwyy9tT2yxKYYkCA0WrHj?=
 =?us-ascii?Q?XTVimBmgzD6fHUCWAnajBIoJcH3yPVeVw4BuS+lW/mZ93LX7WucbHNjO6x5s?=
 =?us-ascii?Q?zBDZDsx4xy+e+gxAw+esgPxwOkVq9Rj/20nvyIdLLN49FYBb+wbKk0edqWc0?=
 =?us-ascii?Q?xT6e73btiuPH9ui1MWlhi84NquFQM2hC+y8f5r4wR1msUNZljSi6efImBT7W?=
 =?us-ascii?Q?NZZZT21RXm5k2YiTSHQXRqXV2QI5a7b1kywjKX8nJsDln46DmV2tbsEsyKG+?=
 =?us-ascii?Q?KpgIBT8P/PfE7q/yrRZ1cuGuJky3E+C1AqmH+gmW/lXsLXWA9ztvqdyuagRQ?=
 =?us-ascii?Q?P5mPi0n7hyAV9G6UrhLynaZ2exMfS0NKDZXlxW3HuSxFEeBOvzqFyDmIYPlO?=
 =?us-ascii?Q?yAs6qXqQOsA7+K1GNLmnFIlTj3pV+qcQhEGUdlDUEDf9gnqDre8akVdZIMNp?=
 =?us-ascii?Q?iq7Lqonau2tr3JpsNeIuwOJhTOfoptI/ukkqz2zSq30LxEFNFd1L/QyhcLN2?=
 =?us-ascii?Q?HH6ZyuTgt+1vq3PYuGaINlHg?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f641668-a4b2-490f-6e59-08d93115729c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 22:24:03.9979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6Kw2mDb9QfSjX977qG26JQGu39H9PW7/yWeClQm1Xn/2Blj6Cme+P57qgfPERDF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2785
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/16 =E4=B8=8B=E5=8D=8810:03, David Sterba wrote:
> On Tue, Jun 15, 2021 at 08:18:30PM +0800, Qu Wenruo wrote:
>> There are quite some BUG_ON()s inside btrfs_submit_compressed_read(),
>> namingly all errors inside the for() loop relies on BUG_ON() to handle
>> -ENOMEM.
>>
>> Hunt down these BUG_ON()s properly by:
>>
>> - Introduce compressed_bio::pending_bios_wait
>>    This allows us to wait for any submitted bio to finish, while still
>>    keeps the compressed_bio from being freed, as we should have
>>    compressed_bio::io_sectors not zero.
>>
>> - Introduce finish_compressed_bio_read() to finish the compressed_bio
>>
>> - Properly end the bio and finish compressed_bio when error happens
>>
>> Now in btrfs_submit_compressed_read() even when the bio submission
>> failed, we can properly handle the error without triggering BUG_ON().
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> Please change the subject to something like "btrfs: do proper error
> handling in btrfs_submit_compressed_read", same for the other patch.

Got it, will change the naming scheme for future patches too.
>=20
[...]
>>  =20
>> +	/* To wait for any submitted bio, used in error handling */
>> +	wait_queue_head_t pending_bio_wait;
>=20
> This adds 24 bytes to the structure and it's only used for error
> handling, so that does not seem justified enough.

And after more consideration, in fact we can just remove=20
compressed_bio::pending_bios completely, using io_sectors to replace it.

For error handling case, finally we will have things like=20
@cur_disk_bytenr to trace our submitted compressed_bio progress, and we=20
can use io_sectors to wait.

I'll go this direction in next update so that no size bump at all for=20
compressed_bio structure.

Thanks,
Qu

>=20
> There are system-wide wait queues, shared with other subsystems but it
> looks like a better fit for the exceptional case of errors. See commit
> 6b2bb7265f0b62605 for more details, the change is otherwise trivial and
> the api functions are wait_var_event(&variable, condition) and
> wake_up_var(&variable), where the variable is a unique key which would
> be the compressed_bio.
>=20
>> +
>>   	/* Number of compressed pages in the array */
>>   	unsigned int nr_pages;
>>  =20
>> --=20
>> 2.32.0
>=20

