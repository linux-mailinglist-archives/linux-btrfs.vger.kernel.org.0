Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00A33CF167
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 03:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbhGTAzz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 20:55:55 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:54833 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377534AbhGTAK2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 20:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1626742261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=67EV8bXIEKx9vInbNzENYQ5k6lCkGFVgrbVFWwaGrAY=;
        b=W6vkJqbz+Xk5QB5i/y9m3TI7cxaaxSQqvcuAcQNUU/ruA6o9PpJg6yv84r2cgUqYz35dt+
        t/vo91OBrk4sXDnjK/ZEsgfO7ULB+h0mSIy3sZ9k6AAjbEzmFnmaqvXWwkJbHQ0Iok+aom
        6AfXgAKbBIXcEojZFqgY1nbzKXoU/FQ=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2059.outbound.protection.outlook.com [104.47.0.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-17-0u7vJuzJNtu43fKM3CbGkg-1; Tue, 20 Jul 2021 02:50:59 +0200
X-MC-Unique: 0u7vJuzJNtu43fKM3CbGkg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHV67rJ3px3i7T7555GsLK1XijcOvGysu1SZ2PKFOvMfPMUs2RU73JPnhigKrM3dBwPxaqUW+ySS/scDU1KDNn7T6L/kkpOFEl5kPWyYtjZQq+Ar8bV6RW96ib8+FzlgZr5wNs4R9RZpA1MNXXeUkF4w3PMQl10/MrSlJS/X88iuXC42VQHk6beXfnyPu+uDkhVuaRu93BZqD4zxpE1x9vd+LFT4qnr4Ae1rUuw/CD7PovR69KxHzPYURCaEWVIw7fIDCBVZ3666q341iaXJI+q69wp1gEJgyCADXcSf47pfiduj//0oMaIdnOCYjrj96LVx5faFD3SQnhEPZWtf6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oc1bZUnRrI0UxklHv3qEFa1fVRsW4KXDFH9kuRABiME=;
 b=OMohkQAISZH4q3OStIsv79bi5V/a4CjfCrhtke6N/z+DvgufBgXrPK+wzgXdEdKcWpvROIEqqjqakSj+uU/QvQaKX7UrntGZRBiNhvG2M+q6ge/Nt55o9lopa2ACXFmNJQkk0tYxyJi71WlMDkjm0ude3mcmVkbL/XOXrfG1Th0J6Mai8KCSHAsJTvHjX0MB81fzo1J2+AYohSl56L2YxrO7dKHik6IngS4aPtpo2sf81CYiRvJOitjac4Z68H0Z6fzwFZR/PcKqDFZRaxuEoD7A5LN/J1NVAm/Y9NTHYzHeexCqOCdJKdCfRAn23NOE1nmaJVnW8AGsNeiSW+3EJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB8069.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Tue, 20 Jul
 2021 00:50:58 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4331.032; Tue, 20 Jul 2021
 00:50:58 +0000
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20210719071337.217501-1-wqu@suse.com> <YPWF5iqB0fOYZd9K@mit.edu>
 <8588de9d-b4e9-0d4a-4ea4-41a6673ddcd5@gmx.com> <YPYcFx6BI7lVH/S9@mit.edu>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
Message-ID: <433f0eca-2c9a-667b-1431-545db4c45587@suse.com>
Date:   Tue, 20 Jul 2021 08:50:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <YPYcFx6BI7lVH/S9@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::17) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR03CA0004.namprd03.prod.outlook.com (2603:10b6:a02:a8::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 00:50:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cd04106-24a2-4a0c-a62c-08d94b187035
X-MS-TrafficTypeDiagnostic: AS8PR04MB8069:
X-Microsoft-Antispam-PRVS: <AS8PR04MB80691079478494ECDE1C6B6CD6E29@AS8PR04MB8069.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTbjCwJ2K7hqyZjBNBOwEmOMK2tgftMhe87OTRGfEG/r3iOfO5TCxWkl09uzpfYMnSzEkt5H/aM0lUZtZsqRg8IFkvn2e+bXVRLJYRkX7PEUu51744WnCtzLQQVFr1WHgCk0dS5WMhSKiXzJGvrCTsiV165+kZlOEPSlo9R1HgyafFMq6V59ebDKYunj5D6SlCuu+4rLbArb0W8+QIUKrmBZIVrqokpB0XbPRB3jlVpzrZN1Sihm6XVZJZ5ZY5gRFwTog3702Vs2ClvQCn1qevF/JxiyrKhO32WiU8QxJWETm63f6j3/tbo6BBgx3KtXgJRZFhUwgna0whQxZp+qtvq+o90aDDGq6TTQ6aXRmQNIpARQFRiYEiJsJEebugkJWUKeDhxQORjJ7JDp1Fc+M3KYJFNRou2gRhZgkS7MVEvipC26qUuKZdnxHkgtM3FbosHaOmKfgOBj26T+7Frb0e0+MqgLvjTpiVTl2VFg4K/uLSqUL/6S3B6VbwrXy0AfZRknVA962N+rQFZEbTwd+lrUy+lpj1LfzSwkzCrWHHdu2ZfQCiqPz4O0qdpqn0t+0w0ABZG2E+f26wGwaY9B83Cct2MTh5gRoE994HE0WTK6jiHTUcge5AosBLzxIbK6ckQ+TQVxaHUeZeAEHX/mTA4h1xIU5QgWj345kVSRBLn+hv3pmlr28ET531ukfIbylT7d2a+Hy4GS58MvewJ6u0Gw6x3uR5qPQ3EY4APpbyuKhNk0sUtVrJ/3qJ1sg8M8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(366004)(136003)(376002)(2616005)(31696002)(86362001)(956004)(38100700002)(110136005)(16576012)(316002)(6706004)(66556008)(66476007)(66946007)(478600001)(26005)(2906002)(6486002)(6666004)(186003)(8936002)(31686004)(36756003)(5660300002)(8676002)(4326008)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NoRQQWF4MSFORVk0RX2fQD0+5k5V4BdPMscWm8GgFG+rUiVxs/3yUNcGdq8t?=
 =?us-ascii?Q?pE8AMibzFCgkRryhgrl8Nv865U7F6yWlPSMWJ1dML9A9onhw5mPMfbX9CcZ4?=
 =?us-ascii?Q?ZeP3VO/lE/l4PJHGtL6EGvsG3Ec1B5jexJEl9NyVS2embNq7B+0sJRFl1FxH?=
 =?us-ascii?Q?nsBgeR/zEBNbxif5W2g7xH7SN49L+ofI2HNaFNf6MGnHY5hKwYVFrLDOWZXB?=
 =?us-ascii?Q?hVE/YkRjTtJfl6KvtVDhnjT5fu7P0Nmow5BYCYoyiUrGanJAFD0Nqm8KgLDy?=
 =?us-ascii?Q?yWsjkmmtWIhaMxh7INX2CwMppWUnrTGk1eluWLImB4T8RR/G2l2eNRMTyNle?=
 =?us-ascii?Q?LhWar9MIdmg05QKkEXz00zjyy2t6BY1lR2341HPZvdQWVhv6A9VC6rdUefdp?=
 =?us-ascii?Q?FpEFlE1CLiCnABuPdnY1VG59jxnOM5QtKPa2Di8uc9DY5O+mBiGLpmo4H4Np?=
 =?us-ascii?Q?SeUxCZXsA7Waw2LrWe26hpJ+vWL+a8UhC+5bEPDGCyaR8wCw1kafHn5M4L3D?=
 =?us-ascii?Q?ICiuiBaV5Du3iZOREBTxk2v7vuu0A1ZC3gFf++6DL8IxQ7qgivCtePV0U/FL?=
 =?us-ascii?Q?+E3txN/iigkoLEveBogNt6ae6MmVZWXcaYVXZfAAbLQ5o5LDHtlfNKOfoBxj?=
 =?us-ascii?Q?kC9njx3XkRHndTOwCbHdtu5Ip7AdpEBIyJM23CEiHs69EbxU7WSzYaO9iV8c?=
 =?us-ascii?Q?8oERb6ZM2KZekq+2E9qjotzTDO6pIf3A/1TNr59Is0gUMx/+Zhm+0XV8mPaF?=
 =?us-ascii?Q?q6EFPhHxyNG2eHw4Gp+VMuA22+HM6WHzGZxK7LmxXCfaDwiyggepd/Iu9FAT?=
 =?us-ascii?Q?inaLu7krip1djKh5ADF/KFptgqbYs9iyhnuxAAJ/ie6mXRSM4c79KXt6G6+j?=
 =?us-ascii?Q?uWPqM+p92le4L/+AUZ7257ygcuTCduDzEACI/urCUQlHqYUK3qMheLvMpBtk?=
 =?us-ascii?Q?XXrARY3as+3lYEJWAdlZIo0vD1btC6X8rdMqtZG+M5oLtRC59/UQk7//AiIn?=
 =?us-ascii?Q?xew1XsBw6SNnXsjQKWOTsNSUfGTnP6Nwr2De837UAqSrwVs/OOOG10Guf0XE?=
 =?us-ascii?Q?RSg5Q69zK1dsqXKJyQgE2AfYxPnNTJlooc4AtBUwfekJN2UUhn8ZAjsgrN+Z?=
 =?us-ascii?Q?o20OMoksdWsqBSr8qU3BDTEIR+d1QD1rtd88GgkfxYwgc0G+miAUjZCgKq+t?=
 =?us-ascii?Q?7EgFXDSQWM8iz5eD1lpiuTzx2KU1iBDgpPT4e+uQKdyzx6rRuzOYY7lje/Mo?=
 =?us-ascii?Q?2ytux2gCSfvbdTwIGSYh2j/uQ9v6aYASOwU1iFfyKfIkg/SVmYjUWoPZO7Bv?=
 =?us-ascii?Q?TISgz/q7bwtCmrdE0unAj2W2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd04106-24a2-4a0c-a62c-08d94b187035
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 00:50:58.4712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTnDgqv8J2O0yTqWteHaRr0WIxwkBSxV9Fom52DolRjnIO5mM89BhdJfGJbC6MeM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8069
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/20 =E4=B8=8A=E5=8D=888:43, Theodore Y. Ts'o wrote:
> On Tue, Jul 20, 2021 at 06:06:00AM +0800, Qu Wenruo wrote:
>>
>> I can enhance the next version to do that, but that also means any error
>> inside the hook will bring down the whole test run.
>=20
> I don't see why that would be?  We just have to sample the exit status
> of the hook script, and if it matches a specific value, we skip the
> test.

That's what I expect to do next.

>  If the hook script crashes, the exit status will be some other
> value, e.g., 128+<signal_number>, 127 if the script doesn't exist, 126
> if the script exists but is not executable, etc.

That's the concern I have.

If something crashed, I really don't want that to affect the test case=20
itself.

E.g. if some setup is half backed and then crashed, how to ensure the=20
test can still run without problem?

But I also understand that, only developers will utilize this feature=20
anyway, so it's should be the developers' response to make sure the hook=20
runs correctly.

>  So we just sample $?
> and if it is, say, 83 (ascii 'S') we skip the test; otherwise, we run
> the test.  How would an error inside the hook "bring down the whole
> test run"?

My original concern would be something like error injection setup.
But that could make the test case fail anyway, thus it shouldn't be a=20
concern.

Anyway, I'll add extra comment to README.hook to explicit say, if one is=20
using hooks, it's their response to make sure their hook to work as=20
expected.

Thanks,
Qu

>=20
> Cheers,
>=20
> 						- Ted
>=20

