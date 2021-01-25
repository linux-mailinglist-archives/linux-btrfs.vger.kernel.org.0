Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4B4301FDE
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jan 2021 02:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbhAYBWY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jan 2021 20:22:24 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:42069 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726660AbhAYBVc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jan 2021 20:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1611537610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LmfI0EXTx2Jx9ndiChRw4rv2onYBUEc18LkiRlQa2Uo=;
        b=Ky0BhL67b5w1KL+e9gnQXnBFAYk3P5vGd87vkTacLz3oWuhGL2YvSeDQYwDDz5S5T1WdMj
        NnMhB+4Kt40Cebb+0nPucSMtJ49btuTBIuDBzDTPg2vKBRmj/P7QekLRmz1rOPa/x/LN+4
        HBja1lViEfgjdFLhmMK51RpdjKPz5wk=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-8-XrCmprVGNOO0mfyFyIP3Yw-1; Mon, 25 Jan 2021 02:20:08 +0100
X-MC-Unique: XrCmprVGNOO0mfyFyIP3Yw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjAs1HwRAet3wyM5CPR+G6so4FBAx9tR9xI2FZmgLadOOpzEqX+CUmA0FkfuzL4+LoarYrzvNR75ePAM1I83BmCwsT5t1qvyzbqXUbGs9CLLowQrHpfDGG5Pr64eUfXMSfA7RbkNpHis+i+Iglp/rdNjh7SFyMZLKSyYTtEaUFpya5hF9xdM2suOX45reDWQyP7pjHi4GVwSXxTOj2A/onq9Eucvke0GqLL/WEpHdFYNlbYvCXPmkXDzMPYnnQgj3xk0gpNJwO9+7OK49XEE1zG+tZHVihFFjoDRzbSDLImCvbU2j8C4jxSUblQrYovhSXaUZQyNbIQ8VQ4qIgMoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEXJcgHPpSDd1PxMd9jJquP4vqPFaUAfqHDB8LuJcR8=;
 b=mr2GBh8x/soFlxsOljwwbW7dpB+BqcnzCdFP7hV0hkBhM/qUgsl23yklNTL7THdJpbuf7KjFbhfeyFv/ZB9PwIH8MlXv1yERQrA/XBCMU6QGbWpjlDOP8LVpYGhLAczPhX9BxbsbKWpnU4pEnNWT7Wkham5lH8KTGujGljtc+ldfq3uldczzhKTdCKc6QXZy+EWHJaf/hAe6Y3hMjs0VkcNCXciMqQZBM30gyUuOjCJsQDW119Vjz6eVP028zM5xgcfJorfvrfUpsSAjlJoJtRtXoUMsEhYuQVoB9Rem3WJ4GweAzDdgOfuA7yanINR7fgbGZETCarAmhSRfXLRJDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2382.eurprd04.prod.outlook.com
 (2603:10a6:800:23::23) by VI1PR04MB4590.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Mon, 25 Jan
 2021 01:20:08 +0000
Received: from VI1PR0401MB2382.eurprd04.prod.outlook.com
 ([fe80::9c:2015:e996:e28]) by VI1PR0401MB2382.eurprd04.prod.outlook.com
 ([fe80::9c:2015:e996:e28%11]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 01:20:07 +0000
Subject: Re: [PATCH v4 00/18] btrfs: add read-only support for subpage sector
 size
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210118231744.GN6430@twin.jikos.cz>
 <9193d7a7-500a-044c-5964-593d93aa25b2@gmx.com>
 <20210124122931.GF1993@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <da06a4d6-bb06-1c74-ca85-44339207d276@suse.com>
Date:   Mon, 25 Jan 2021 09:19:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210124122931.GF1993@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To VI1PR0401MB2382.eurprd04.prod.outlook.com
 (2603:10a6:800:23::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR13CA0083.namprd13.prod.outlook.com (2603:10b6:a03:2c4::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.5 via Frontend Transport; Mon, 25 Jan 2021 01:20:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9a48dd8-4fcd-4fbb-aae0-08d8c0cf5a18
X-MS-TrafficTypeDiagnostic: VI1PR04MB4590:
X-Microsoft-Antispam-PRVS: <VI1PR04MB4590498B77994587093B5406D6BD0@VI1PR04MB4590.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mm73qvXaZo7SHjMK8lDLeUh2fkOVQVEt0qtDRWmj3WBWfEhtoGdgCmDOw8TXIjYkaPCpzGqjTpRmTdVcLkjtSrFTP7Dbhd8bb8HrQknDeo6oozPa04S14HE/YhcAX1djkp2a7PhiPtqPefKoN3JnUq9QlC1CKZADQ89pjEnqOnUJZJpOZnqQ6FhTTctc85OoHCAN3Elvh/dtqQL9o6+O9nmNXLhhP8DKJZFNDSKl6fyRhzJEwJ5bNIfBrLHFp0BMyDrAnBLPRwkjpJvUg05vv3Sufjbbj7kT0rHY84y3UXFEKjm9u3Zrihx26n+dIxJNLOftqABbZWZJbkcWnsekSmW2ZEfu64iU2djZlcHSfugX96DqMZPjJWHfihBbm3bMqBa6O/EXTVpjF9lVT5q1y85cnMWcpfb4oqZFusQYANJW782OLxyIbN/yUSyp/O/XaSv93A3H+0VQutTCL2VA7wAe/1k5ZQMuKjqSNBKdktHOW1R1wGxx21ItkE0qrC3j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39850400004)(366004)(396003)(16526019)(26005)(186003)(8676002)(66556008)(316002)(6666004)(31686004)(478600001)(2616005)(66946007)(8936002)(31696002)(36756003)(83380400001)(66476007)(6706004)(956004)(16576012)(5660300002)(52116002)(86362001)(2906002)(6486002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sAXwPA80h/GeGNCHcft3cHHJRXJN5xnMxAR+iojC/EpjniDuDh0wSHThjej/?=
 =?us-ascii?Q?X0ngC4BgsMY+G1EDF9f7Sbn2M1kvmuo93Ex9hRlJL/uaFv5KAA7ZdLtlQVFy?=
 =?us-ascii?Q?9iGZ63moloKMwsZXvB/seNpFg32rV8zekUVRI511m61XCGJatYobJSKSz0tD?=
 =?us-ascii?Q?oGM6xHHRFK6ny7EeORqgf4VBSHMUwA6sU6PR2W5g+zIiBs3MqcnAgci8as6O?=
 =?us-ascii?Q?5MvYFNglSYRnOI9ARHitXwbCctREi8hFAK1UDO51uQLmT3VPR4Z7LVmov4H8?=
 =?us-ascii?Q?WwfLdmB33uDeA80DrGv0XYb4nj5uq/o9WBrjxm+QAEDtVKTTB8yuG9gfLBY1?=
 =?us-ascii?Q?ytwIORVDnbwntAnRvtOwwylaRf1+mxho9OiOR0JUJy0K7qlzue28qEYEDxeD?=
 =?us-ascii?Q?JrsRfv4iTCk07mTjTvNWoyMECaijpNFBL+WBVm1Y1NGWPuQantI4hOpNhGs3?=
 =?us-ascii?Q?vIZhGCSMuv1Qp8SAuy4bqwtV136KWc3rkYONOt5I11AkTILmBHiDy8euJV7h?=
 =?us-ascii?Q?IjIdk7dxbu/Lao+kN41v44Mj/vPCw9aE+UtB9Y+tOPYk4QQ3UfL5C+IupQkN?=
 =?us-ascii?Q?wR7Kf5KeqWcAO28sUOK7HIeeMd+6WvIaXLaLPAr5T1IzOUZjwZz0BmhHHFX5?=
 =?us-ascii?Q?CuTwo7HqtTW3cv2LhJ1f6ogAq182jQ0YhqBly9jlnFP2WjeQeTup2iJwdnBh?=
 =?us-ascii?Q?8INmWdFaqha6hrTKctwYcfizOMqvI5q+zZI/Peb15AvAK//blI9BS5EXM8AP?=
 =?us-ascii?Q?YpcwllOwe6qgTIbIGHRBBZiuSu83tkMrN/Xri1pHsYi8f29cvmWxqqtsfGLA?=
 =?us-ascii?Q?eqfj6ZQ+C4ZWTC128b9RbyPfQJ9gsH22m7jwjFyubg8iiqyLW/KYZG0/e245?=
 =?us-ascii?Q?EXAPejsTvHFavTSc2gpAemJUAU+kAdxz4Y0wlDo5vu8loAFQfBMsI+w9e25Q?=
 =?us-ascii?Q?ejPlUB+AY6+wAn62iBht1aWLeXb5n4rCeYKfMQgfzrkqvvhxepaWxggGH64z?=
 =?us-ascii?Q?ze2BpPwRz2wMgye8soNX+nmyXT0hWOY68lGHUqpHs8fHi/YVBDX37tjRECN2?=
 =?us-ascii?Q?Txp3vmfB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a48dd8-4fcd-4fbb-aae0-08d8c0cf5a18
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 01:20:07.8593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2/LvoPGqVT+N9fO1Ls4umixGwxZeQEi2zd7Vg9IvtuMYrN+19O8SfF/ZxZMDpaG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4590
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/24 =E4=B8=8B=E5=8D=888:29, David Sterba wrote:
> On Tue, Jan 19, 2021 at 07:26:17AM +0800, Qu Wenruo wrote:
>> On 2021/1/19 =E4=B8=8A=E5=8D=887:17, David Sterba wrote:
>>> On Sat, Jan 16, 2021 at 03:15:15PM +0800, Qu Wenruo wrote:
>>> As the subpage support is
>>> sort of an isolated feature we could afford to get the first batch of
>>> code in and continue polishing. Read-only suppot with 64k/4k is a good
>>> milestone so I'm not worried too much about some smaller things left
>>> behind, as long as the default case page size =3D=3D sectorsize works.
>>
>> Yeah, that's the core design of current subpage support, all subpage
>> will be handled in a different routine, leaving minimal impact to
>> existing code.
>>
>>>
>>> Tests of this branch are still running but so far so good. I'll add it
>>> as a topic branch to for-next for testing and my current plan is to pus=
h
>>> it to misc-next soon, targeting 5.12.
>>
>> That's great to hear.
>>>
>>>> In the subpage branch
>>>> - Metadata read write and balance
>>>>     Not yet full tested due to data write still has bugs need to be
>>>>     solved.
>>>>     But considering that metadata operations from previous iteration
>>>>     is mostly untouched, metadata read write should be pretty stable.
>>>
>>> I assume the bugs are for the 64k/4k usecase.
>>
>> Yes, at least the 4K case passes fstests in my local env.
>=20
> I'd done a pre-merge pass last week with fixups in changlogs, subjects
> and some coding style fixes but that was before Josef's comments. Some
> of them still need updates but I also don't want to throw away my
> changes.  (Ideally I don't have to do them at all, you can get the gist
> of what are the most common things I'm fixing by comparing both versions.=
)
>=20
> Please have a look at the branch ext/qu/subpage-v4 in my github repo,
> the patches are in the same order as in this posted patchset. If the
> patch does not change you can keep it as is, I'll reuse what I have.

Already doing this, using the ext/qu/subpage-v4 as base, so all your=20
modification should still be there.

Thanks,
Qu

>=20
> For the final merge of the read-only support, patch 1 could be dropped
> as discussed. The rest is hopefully ok to go, please resend, thanks.
>=20

