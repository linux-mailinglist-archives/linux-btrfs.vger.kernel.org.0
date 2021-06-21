Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CE93AE843
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jun 2021 13:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhFULmh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Jun 2021 07:42:37 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:56173 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbhFULmg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Jun 2021 07:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1624275621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q4pI6Hwzex5leuDegDY8xBHk1FKbwl2/+w/3YogocKs=;
        b=eZCkYexp/IqBuhXrinh+E3MhUz0PEOUyiTmCIq16AGVorHferJoA+0WKM12cwuL1WY0yOr
        jQd82w9JVSAGIaI+djY4UKiSzdbZP8Q7uONNN84F9I5M7hCEIDYwfjKv962+Hgb0ntvipa
        HjuXGWufSel4EmWl/MeAo3i/+oLZnJQ=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2055.outbound.protection.outlook.com [104.47.12.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-35-XFSN4tNcM_WADTnr8WmYFQ-1; Mon, 21 Jun 2021 13:40:20 +0200
X-MC-Unique: XFSN4tNcM_WADTnr8WmYFQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ur2+ag5jOCQkRPi2aJ8uHiHJ0CdA21DINTWXoPF3l20hM8k6hUk9pc7nGy2xlPWIbdAHRyBbM688FB6BlfBPTBKJJo4He5OAvw5UCPI5oWOGY/LKimlfxt2HOBJHPlHHQAXEnudz99upi6QMTkEc0vrntB2FXljJ/XHRqTQ9IlqtmDj0fJK1fwUtlzFEC7HokbwcZsYtl8JAhNKE5amx/Z6wzbVR8e9RvQorzluD5TTDQczOBdc+KlfxHeRMSAtUWZ9vvgi0ELIuEzJLBgsQ3Gyr1Ipr2j2aTkoRWooM7T0Cl+4Igz5Z5nqoreN5n/Z71ceBx/t71gdiq2H7CQLpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEoiAKTzFA/Fa1MW8COOIMyy7ETeat13ICwe+drsJxQ=;
 b=X0bnxxCtOpvOqVWZqTPT7430vIg0Z4+6tiAadSvs9a1vuTiocd5uryutw7M1nGOWFj/tTiiv94sRgn1eFvtkIDEz09XL5tR0nAaFW2eOtQpAN4UmH5OHDqbbL+CvaUyFoLtYMQToDxxCm3jxUslS+7nntXCbXytzVnkvsP+KQ4t1X5GqY5kNf15iQ6Wm/pDVh4g/nJaX5khvL5Dfgic74HQVo2+nXpvkoia6kGgv62L9JZ1DOUbm5M7AlF5Srsp31hUQSjalyi136d8EdGcxmO/L5wervsygBEoaep6s/+RMzyTx6onFLqOSZIpH+tURTb7zK4T5cjqtFTPgDmnM3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR04MB3249.eurprd04.prod.outlook.com (2603:10a6:206:8::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 11:40:18 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10%7]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 11:40:18 +0000
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Qu Wenruo <wqu@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <e78add0a-8211-86c3-7032-6d851c30f614@suse.com>
 <0a9ae22c-44a0-6239-f61a-fa516f2a0de6@huawei.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: Please don't waste maintainers' time on your KPI grabbing patches
 (AKA, don't be a KPI jerk)
Message-ID: <47c66bc9-3fb9-5b02-0a89-4a51ce8f9943@suse.com>
Date:   Mon, 21 Jun 2021 19:40:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <0a9ae22c-44a0-6239-f61a-fa516f2a0de6@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:74::19) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR05CA0042.namprd05.prod.outlook.com (2603:10b6:a03:74::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Mon, 21 Jun 2021 11:40:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0d62247-d154-49dd-c12f-08d934a95835
X-MS-TrafficTypeDiagnostic: AM5PR04MB3249:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR04MB324923800581FA205DD575F1D60A9@AM5PR04MB3249.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VvUIv9b9xmEZwu2zzPQzuibtqGRV1sbYnM5VLx9efBwuuMVr5qmPjhXaXTwcbfdag98ReaTl718Hj79phOgrO0N11gpE3OcgZfAzAC9G4vYhnn/09JJ+7Z1EHpa2qOc+FyjKMNgGdZMie6cGGdHMHNtr9Bj0FmnUhNTC3hKup7227IF3TunP9KJoJfS1/MsOqJka1u4FvAGR656KmQSH1mX8IealzEwQS537zQlOj01VFQHpwJfOwreVfK+SZOGb6/TAjjGOC1EwXG+VEssDaQx7SwyD46pGp2BZNBM2LOA3CT82OprHX8kPLKRtaSZX8CqO2N7624E2OGgLCWqSE5qKHNdq452YvuP6g45j9PHq0bLavou/Wx4aZuEQQzE/rZFf9uqtOP1UOrsjHn3RF6s3grJtHMKOsOMM5ZFvpGjQsS+R5JCyLpbI5HqvFOIS0vtJr8U7hZj4tXYUhEZiBe6+801ZIJHfhAal9G48L0P9teawDOu876MshISNuNtkNtMg2uTXpsJDV8k/NFwq69HWyyWLEx589H0NDtil9tMOXqm7toZgm6Ow9UvA3jgOWULBzrPcBlLhEa+ok9ZHKuYUiyXA0WNMbaIVrY1kO5+PjXARZ8/aIBTGwNn4igYpol8UnQUTlV1L9G0yy8Ynd7NDRzZBf9S8ps6JBRxGIBso42/5/FrstugFXwbguoEUxdn8UD0eg+XBMaUcrnoeCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(346002)(366004)(66946007)(53546011)(16526019)(6486002)(6706004)(86362001)(2906002)(31686004)(186003)(16576012)(8936002)(6666004)(478600001)(31696002)(83380400001)(316002)(36756003)(66476007)(8676002)(5660300002)(956004)(38100700002)(66556008)(26005)(110136005)(2616005)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JfsxGoCaN1tCHBPTMZe143pSbl9aKraUDRAaD2B6Y9zl6MuVY9x0Z2Rxf9TL?=
 =?us-ascii?Q?7zkaPlcWmDwNAbKKXO6XLwfM+thkgMbU/tayjq1ioR7/72jLucfN1d1EwaQi?=
 =?us-ascii?Q?IZCiPxqeANg1cMfjuXFOZ3jnPp8VCEQVCbVOZEIgNjXHaIwOnPxdwhyH29T5?=
 =?us-ascii?Q?JfF2ulViMgPvZJu0ZVQ85pF4+/Q743pw/B+YXQ8M82xJjt260mBN6vltAkL4?=
 =?us-ascii?Q?KCEJrXedbR4QqEhV4rOOGZosF0wz75ikBNIep034uus1AHL0wV4FOm99OEfx?=
 =?us-ascii?Q?NyBp7IAcBfJPUeqts4zlgTfxpsdSqsvbag4zNIf0j65KXDU2hhLt/ZvFrHU2?=
 =?us-ascii?Q?a8WTCLanw6vsG4fp7uMFi+wAlfIH11hfUCN8gXzY0pEnvV71ADplx6Np6/2G?=
 =?us-ascii?Q?kGG5vRRdVCLdmBxzxUhQfCnjUDsIFPwt/xwDQWKiXM0s/bRZfd+1HH+BaVnj?=
 =?us-ascii?Q?a0yaL7uLxhz7PKU/Vnu2qKORkhKMVqdm7JsBIO2AtJjgbZV6Z21rQZgCrqU4?=
 =?us-ascii?Q?xyeKXmt79Op+m3Nateefc5ecEMEA79Xh1Y9QPHkvf3UmlIWlp/pclbDbY6Fy?=
 =?us-ascii?Q?o5ITgi4xds3lYx0s40bCfZMoW5nXjxlONLW6v5UpvvNmTi0OZE3S13eF2Vmz?=
 =?us-ascii?Q?ydp1ZRINO8Z3il1gGU7rAm1ojSdx/6+qa9tMVw+rO0fkRTyb7jY1sKd/L75R?=
 =?us-ascii?Q?jx8/cqq8BPN3oTP+rVHbWbsgBpH8tCUULAzZgQLgB4aG901FeCjZk4e6cby/?=
 =?us-ascii?Q?/8jPbaI56SnmxPLuEUjNkSo3uPlrUXnZ3SOElLk2hHy2tqhvZzFiOOG23H3k?=
 =?us-ascii?Q?+LKQOws9wPbVjvjsfocKLcmQYdznX0kMBeHkV5rv9xsigvTQvb9Jlmg1WcHh?=
 =?us-ascii?Q?x3hOK9o1CxvXfDYQXdFTfKYWmJJgZDBwm7Ja8WtIVuIUwZhPayskCquFEnxL?=
 =?us-ascii?Q?SqJJRxItnE1LvqLyuUOeB5VEW5sVJl7xgbTgrIaMnjOdS0cmAEFVE73w00jx?=
 =?us-ascii?Q?CcITOB0EP8PmwysZcurvvoBiVYUx+sFP07P4XTMB5BroHUThXan95smwiCJZ?=
 =?us-ascii?Q?bGxFP58zIO7BVmZZeRX4nEobCU1nav77eVJykzVt/XXs6Z48ERF3Q3Gbf5ZN?=
 =?us-ascii?Q?MLTs5JZdeaTp60qBJEet46Uwce13VXuRDwHUZFqZJK2lSPUv5NiyNUgH1JkB?=
 =?us-ascii?Q?dBjiqArc2KcSiSXcMyr1Z12CGekUNqrJaexk8oWmQyijFWgeOruYvjcfeQsF?=
 =?us-ascii?Q?P3G/25MXx8bIGc8n2AXSmSSyRLJJ70gLl8WIDy7Uq5Ty8Ji48buycoWoXkX7?=
 =?us-ascii?Q?QuouIXIw4rCCgKFgDu9SapU9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d62247-d154-49dd-c12f-08d934a95835
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 11:40:18.5159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erTPMbRAVM82Vi5B7fMi3i59AUbI23EJcTqS7kOEG9DPoALQgWfaGOIO893tYoXL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3249
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/21 =E4=B8=8B=E5=8D=886:56, Leizhen (ThunderTown) wrote:
> Hello, Qu:
>=20
> My contributions to the kernel in the past have mainly been on optimizing=
 the performance of the ARM64 SMMU driver,
> including the iova optimization, strict mode optimization, and the lazy m=
ode optimization. Also working on the
> development of some ARM SoC drivers.

You indeed have done solid contribution to the kernel in the past, thus=20
better could have been done.

>=20
> When time and effort is allowed, I also contribute to other modules of Li=
nux kernel, trying to find something can be
> improved, and some cleanup work is being done.

I'm not saying cleanup is not important, in fact we have routinely=20
cleanups of typos/grammar for btrfs. (And I guess mostly caused by myself?)

Please at least merge all those small fixes into a larger patchset, and=20
with a good cover letter to explain the reason (and auto-tool to do the=20
change if possible) for all the involved maintainers, so that all of us=20
are on the same page.

>=20
> In the future, I will continue to make more and more important contributi=
ons to the Linux community.

Even without checking the git log, I can easily think of some big=20
contributions from your employer, like EROFS and F2FS.
Thus I don't have any doubt about that.


If you guys just want more ideas, there are tons of better things can be=20
done, for both newbie and veteran, which IMHO can benefit everyone in=20
the community:

- Better kernel CI/Zero-day testing
   One of the better example is Intel LKP, it caught quite some bugs.
   (although sometimes not that reproducible)
   If you guys could have such facility running for not only upstream
   kernels but also maintainers' trees, I have no doubt it will be well
   received.

- BUG_ON() removal
   I'm pretty sure there are quite some code using BUG_ON() to handle
   errors, especially for -ENOMEM (just handled a dozen in btrfs).
   Can't imagine a maintainer don't like this (of course with proper
   commit message)

- Error injection tests
   Especially when combined with above BUG_ON() removal.
   Any everyone can also learn some tricks from BCC community.

- Better code refactor for super long parameter lists/super deep loops
   I'm definitely not referring functions like submit_extent_page().
   Although if anyone has better way to refactor such functions, it would
   definitely be a good move.

- More comprehensive metadata check for various filesystems
   Not sure about other fses, as they have much less metadata usage.
   But we have almost member by member check for all metadata, it may
   be an interesting idea to enhance other filesystems too.

- More upstream phone/tablet support
   Especially for guys even running upstream kernel on RPI CM4 like me,
   more ARM devices with upstream kernel support will just be more
   happiness.

   Not to mention this also means super long time support, way longer
   than the lifespan of those devices.

   It's super sad to see just less than a dozen phones/tablets got
   upstream kernel support.
   Even more frustrating that those mainlined devices are already pretty
   old and slow for today's standard.

   If you guys can change the trend, it would be wonderful.

- More testing on extra page size
   Well, this is more or less related to my personal work, testing
   btrfs subpage support on 64K page sized Aarch64 platforms.

   Despite of my impure motivation, tests on new page size would
   definitely help everyone.

   (Looking at some M1 chips which doesn't even  support 64K page size
    at all)

Thanks,
Qu

>=20
> Thanks.
> Zhen
>=20
> On 2021/6/18 14:31, Qu Wenruo wrote:
>> Hi Leizhen, and guys in the mail list,
>>
>> Recently I find one patch removing a debug OOM error message from btrfs =
selftest.
>>
>> It's nothing special, some small cleanup work from some kernel newbie.
>>
>> But the mail address makes me cautious, "@huawei.com".
>>
>> The last time we got some similar patches from the same company, doing s=
omething harmless "cleanup". But those "fixes" are also useless.
>>
>> This makes me wonder, what is really going on here.
>>
>> After some quick search, more and more oom error message "cleanup" patch=
es just show up, even some misspell fixes.
>>
>>
>> It's OK for first-time/student developers to submit such patches, and I =
really hope such patches would make them become a long term contributor.
>> In fact, I started my kernel contribution exactly by doing such "cleanup=
s".
>>
>> But what you guys are doing is really KPI grabbing, I have already see s=
everal maintainers arguing with you on such "cleanups", and you're always d=
efending yourself to try to get those patches merged.
>>
>> You're sending the patch representing your company, by doing this you're=
 really just damaging the already broken reputation.
>>
>> Please stop this KPI grabbing behavior, and do real contribution to fix =
the damaged reputation.
>>
>> Thanks,
>> Qu
>>
>>
>> .
>>
>=20

