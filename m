Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4693B9897
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 00:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhGAWfW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 18:35:22 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:39980 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230213AbhGAWfV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Jul 2021 18:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1625178769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RUzL76i2CXk/KkJiIpcr6P04Dx1MVmZssbty3olu1IA=;
        b=kUSb6T53So3x7r6vZcDOf0I0YTgmDQVKBGW4Z0kTIU+glFWH8jVPvw2YoD0XVXkZVUkPBr
        N638mel31KYIWQ3YNf/jyKBnFKOHDtn4/TZi2u4PjuQxN4ubL7j4Z8q6olTcWp0LlsXLrb
        nFzlXSSPf1iNMizPCNsy111/4L5xm2M=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-30-536HE7eHMlO08HVyfCs4Pw-1; Fri, 02 Jul 2021 00:32:48 +0200
X-MC-Unique: 536HE7eHMlO08HVyfCs4Pw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUGQ0VKGn9eKn2KSV/CyHtNCfdtReL/ENkgqKNiPnmba7IEEbxWKcJoN1iWvkHQoXkkovDQBckKs/QE+GRGl9+KmJfsl9J7Fk16Yo0RphoAkwyqbPQOS2TotraRhEokZ+wSl4BZ2Cs7Txm6CkhroEqwUMTnW9XqKwfHFrwTP3qtWQNkq//8l+1r7dcTm+PHGr8gENfjQunzaapvJeY74tEWP9Y48hOGax3dyJOeuqOFhEBUkHLwT20OaXUlZEynr7a57EY0UFvGcFGP0cARJkgtx8339LeAndvuUtsmpLLZronF6lJtGpjjCy9kCak10XDO8gJqCA/FIvbxkuIzNnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EoXlorf9YljHgzDqE4x7HvxZQ/AwMn8vtHTWCjIYAI=;
 b=av2PQ2aR0kxF15NmF+WQ0MLgHdAofZobmNtfjn9ND87+LRQk/qaKkMQg18Xn0ZUDa60nzlq2js/cLUxkwIMYNNbG0hs/H7NKO6oT6Z2lViugszj9t85/ylHdT1D7G0oJHfXKimPvut/lOQ0LEBosZlYJQrZNXDplC78/o6X8IH32tsPud9CWOGLx3kGGoil65ob4QoLIApLVJ2k3i3Fg/8d7BNpbfBqU8bgGB84w1cqHtdtsV0LbUgw1nb8UqaYzmFynu+Tp8PfPW/W67cLZ33wO7Do6b+X0YA5GnUeNRN07A5zH/PeVceQ0lfSiSMRslnLv6fzWcc5rpaegAMgYag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB7671.eurprd04.prod.outlook.com (2603:10a6:20b:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Thu, 1 Jul
 2021 22:32:48 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10%9]) with mapi id 15.20.4264.026; Thu, 1 Jul 2021
 22:32:48 +0000
Subject: Re: [PATCH v4 02/10] btrfs: defrag: extract the page preparation code
 into one helper
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20210610050917.105458-1-wqu@suse.com>
 <20210610050917.105458-3-wqu@suse.com> <20210701165815.GZ2610@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <604fc4c5-0d09-73a0-276f-c41d64efb495@suse.com>
Date:   Fri, 2 Jul 2021 06:32:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210701165815.GZ2610@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [45.77.180.217]
X-ClientProxiedBy: TYAPR01CA0042.jpnprd01.prod.outlook.com
 (2603:1096:404:28::30) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (45.77.180.217) by TYAPR01CA0042.jpnprd01.prod.outlook.com (2603:1096:404:28::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Thu, 1 Jul 2021 22:32:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a5621ec-29d1-46b7-b256-08d93ce0273e
X-MS-TrafficTypeDiagnostic: AS8PR04MB7671:
X-Microsoft-Antispam-PRVS: <AS8PR04MB76716B62748436FF07C1944AD6009@AS8PR04MB7671.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hGbR10j6IgPLjk+JdSj/x95NDDDq6Z8J0jnI85am1z8jiHI5wd6Swt5Ogz2pAzqObybr4w5mtiRYLZueAxKjp6LB0pPeeSqcyLK5zU229Nsos8p4DJ79ZSPlu1R34T2hEG+2Y6VpBgktCOU5bpSfPK8Q+Q3ojXPCYH70blHU47CtJ6ebmSex84skTTyl5vimFaepW5f6AZrUyK8pYFsNoh8UR/vOsBc7E07dR/EzhlOlijL/60+CK0rQWIBjrehu3zYrNP51akNLYnjeBuHinlTEIYqzvisAlbS3/teWuVbW5BIJgUo9IDW/B5jz9VLfnrCrmDGNio+CXk4CNPSVmH/QDJLGAWqIIVcgnNG2k75SJZCJbRw2aOJHvHNeySz7GEB1K/J7KULubOML4w00EZCb6K2P+i0dHHIiK6mVujUxP+D15wcoaQojqxr3EgcWjP4Xf9PLnLhHUtFXEckRsHmgjPnZoypEkfYW/mSIcIkJs6ip4buj/2F1L7bCAWAkbPVgDqfxmtj2jmIXyAqMRHz9GqFLdj3G3NSGQQ4HW7xr79yHCfzqsNS29PdxZH61fQtlKXOjYyhpnhB+wDLVKbHkaywI+qiji+jX97xj9DT83ktB9k9WlCcoN+e74EO/mjFj3rp+YqH8jYHC9/k5foWIuBJccd0iBDAh68juCq7mGs5rZwb+ibLOyaPPuKB6Wna9IHJZ4IYgRYmzgKU1O/7+c302NJTE7cvzoboIH/p9bGFcjeRpE6UBAEptB94a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39850400004)(136003)(366004)(376002)(36756003)(8676002)(16526019)(316002)(26005)(186003)(8936002)(6666004)(66476007)(55236004)(2906002)(38100700002)(16576012)(66946007)(66556008)(6706004)(86362001)(956004)(83380400001)(478600001)(31686004)(6486002)(2616005)(5660300002)(31696002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?21/qoYiE4ek7auLnuBwvJTMhSvOsLmEwM6BQ0qau7ioYTiPO1O95JPIAuZaB?=
 =?us-ascii?Q?u55nlF6xNjAWtj0nfj2XQmUFKEljxI/N5sN9+DUM5ziv6UpG87rH4T1j+v7T?=
 =?us-ascii?Q?I044fCj62BsQc+53krk3gmRF2Oxs/YzMJOj5A7I9X4Mbg85l1O4bkJ4Fdt6s?=
 =?us-ascii?Q?ziAzCUufIJaeX22RfR+GGV1IchNsLS07Cd8B4yDWhm8iIppjua5vYRWOQ11n?=
 =?us-ascii?Q?z68+uvcYr+2GOedRjlj/ytpof55CuwRWyfd2lViEiPHm9rZIi2F+A072K6mt?=
 =?us-ascii?Q?9kIF4tYmgO1aD8wQ77nPPCx/N/HA8EX9bae8ql/w2rcggvoCOHUIaEWk2VVW?=
 =?us-ascii?Q?P5pcJL7B2gkJFx3LUudAW3lqhS2iHj6ALtHR2hWO2fwCH5PHFNL3NVv7tEp0?=
 =?us-ascii?Q?D1yIUV0FiR6EtDoigObuAPWO4HXdn5q1fu6oiwD3lEzD6y7ZzQInfUD/fxGf?=
 =?us-ascii?Q?h0XJI5e1ByQuNK1ZdcJlNn7AlAb495EMFQio1VyuSI33AQS9QrUQSxhRgTYf?=
 =?us-ascii?Q?O9in4Ss3LRp5IBIPXDIcAac6aJZTcijc1lcxVY1mrMgibIYfkjZ8/e8hBwO5?=
 =?us-ascii?Q?zugbdtTIfHz5gFPp+ny8SEFD153hYcQ+UiTvaYoqA2d5S14KqqHeyzK6pWgA?=
 =?us-ascii?Q?JvY7vigTuv1+PUJKM81B4MqLIorwjaiPYMj4Icsv5Dk5CHjt3WIaxo0Dzjz/?=
 =?us-ascii?Q?GTGsNV3oy24ZRsTqvyPp88YH7/NwXAx9SeXLLh8UT9q8oGpAYLcDeTS8bSfe?=
 =?us-ascii?Q?RbiYo4zaoV0YG4WWQwzFOkHwKo/N8B4UboKUxvNqfWKVjPYFXYE0pU0Nly8p?=
 =?us-ascii?Q?RxbqeixcWsLvTMZYur5FeULFyb8HugffeYdSuKJWgzT+16664tT9Aptcp17/?=
 =?us-ascii?Q?+q1f6mOnTkRhrOW72CGE7G7qDVWofvOp7q6Pim4z+SPk0aucZvB7yMGbJQXg?=
 =?us-ascii?Q?ijUm3SIOZTPnr5mHw7DeMkrOS8v6FKUmQk0f9ftEf4hbOz4eUe5p8/+fOxwp?=
 =?us-ascii?Q?ebGcctOks+Y8w86pvrEcsFcKFJWPamrSWvfQNQfKr6CuW9BQWfaWxV90ZXAc?=
 =?us-ascii?Q?0UHamnNurwimO+fJbZE561bAkpb7kyuYFVei7k9W3XhpD1s46GusHUujETXr?=
 =?us-ascii?Q?Y656IxsYx1eiAuvqFeSqHPa55WFKnlyRVx/mvquUNipaclbN5mYPP0zHmBTL?=
 =?us-ascii?Q?8iXe1vZEh1bm0ufW8BgUpzkVpH8ibqLhwDJeHTnUJ4bEE1TjpCYtWUHn/yAp?=
 =?us-ascii?Q?AonaaBcgaouf5P4t0n7ldlpqPQ42wMisy7Wycg5H+bTKoAB4RuL9qFvSycB1?=
 =?us-ascii?Q?OgeVZtWPqxXWZSv5wla67Ijc?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5621ec-29d1-46b7-b256-08d93ce0273e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 22:32:48.1971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xv1FG2awkon+fmncTLnR6UchIAcplrzY121Lp0W+OodhPe5V65y6uBIeUuWZmTJX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7671
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/2 =E4=B8=8A=E5=8D=8812:58, David Sterba wrote:
> On Thu, Jun 10, 2021 at 01:09:09PM +0800, Qu Wenruo wrote:
>> In cluster_pages_for_defrag(), we have complex code block inside one
>> for() loop.
>>
>> The code block is to prepare one page for defrag, this will ensure:
>> - The page is locked and set up properly
>> - No ordered extent exists in the page range
>> - The page is uptodate
>> - The writeback has finished
>>
>> This behavior is pretty common and will be reused by later defrag
>> rework.
>>
>> So extract the code into its own helper, defrag_prepare_one_page(), for
>> later usage, and cleanup the code by a little.
>>
>> Since we're here, also make the page check to be subpage compatible,
>> which means we will also check page::private, not only page->mapping.
>=20
> Please split this change, it's unnoticeable in the refactoring.
>=20
Sure, but the defrag patchset is now in very low priority mode, thus it=20
will be a long time before you see the next update...

(And I hope I didn't forgot those comments before next update)

Thanks,
Qu

