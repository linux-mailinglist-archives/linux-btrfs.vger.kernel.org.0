Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5D13D06D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 04:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhGUCR1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 22:17:27 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:23245 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230451AbhGUCR0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 22:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1626836280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ehoKNfOcQVTqU1Y7eSneb73VXCJurD5UftJmIOzXgdY=;
        b=E+mH1aNu5TFp4COdqVbE0y3QvPSCDD88tnvjD/zWFUfjW5KaPcrUOvldwiEw+bKsDK1kys
        hcSmIzC3nMD9IEcEOI4msbGAfpqsHuPIon8/JLjEBRUVP2y1/w7dkTnjIQpelRpmoANc1A
        4w4Z8+9NNEn4hWdtUg6EXuHqnM/zsSM=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-16-PR-VT8tYN6GLjB_61zyIow-1; Wed, 21 Jul 2021 04:57:59 +0200
X-MC-Unique: PR-VT8tYN6GLjB_61zyIow-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7XU45rjC9/2Rd5TsWkcb3Z7EGodbfsLdsiI3QF03PJXZXx8JRWE/Yul8orpZfdRykglu2/jjyMZlcFA5/IO6H/pi+iOl5ys73Of7nCeySKvgk6CPPRTeiEsjlFAmH0DCIHadmDhEMVi9yJJZ8kL5z2Z8DuOCnJZcVfCU9WW5Vbh43+Ks4VbCh18TNry1SHOO4bPX7x5hFR46VxiMd7oNigYqhVXmH/Dtgtlk8VBvj14Jtw5TUyFMr/SGahtM7eMwc2w5tkElFPKPYPxdPcScfoyDf84gI706NbIQBjZ3vaC6PLRzi9okNW+mJz5V7BFtYptH/hz1CmjW0cpuoEENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6E388/LV4aJks9cOsZ9aWmsRxZRQLgMBdvWGCULvmxA=;
 b=jKvf0TqU1kdEU9C2LKBEJ3ttwulXsen7URABqeqO+kmJQ7ukY8VwxhebdiH0HYGgRoRbTOJtP2qVrM+nF6IaMyeCvMOr8A+v0tRaQHfMnjYfVMZbgzU1+K8mpHZhs81IFRXBQgbOyLmxQMf69oDREr/YfgqV9hpfJggga0XGqms1YQeJU841+bxasE6DUoVr5dFLFMcJATD3PJ+B+4OEPQB4A/q2EPYl9/UyTBvAtu/wSGOvkPLGHNG4jsx6iri7tfmv7/SQB59Etblk447m+inoqj+tU0wnQy/IjEQ6swGCbioE/XemtYZKsGP+NaAWgvZSipsffsLnKEbk6jQFog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB6517.eurprd04.prod.outlook.com (2603:10a6:20b:f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Wed, 21 Jul
 2021 02:57:56 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 02:57:55 +0000
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Dave Chinner <david@fromorbit.com>
CC:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eryu Guan <eguan@linux.alibaba.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20210720002536.GA2031856@dread.disaster.area>
 <3f2d4ebd-bf75-b283-45be-3fa81e65d5bf@gmx.com>
 <20210720021437.GB2031856@dread.disaster.area>
 <cb2bf09e-91fd-2976-4366-4daf29664890@gmx.com>
 <20210720064317.GC2031856@dread.disaster.area>
 <20210720075748.GJ60846@e18g06458.et15sqa>
 <3fd6494b-8f03-4d97-9d00-21343e0e8152@gmx.com>
 <6b7699a9-fc5e-32d9-78c5-9c0e3cf92895@gmx.com> <YPbt2ohi62VyWN7e@mit.edu>
 <f37bec82-85cd-b818-8691-6c047751c4a6@gmx.com>
 <20210721011105.GA2112234@dread.disaster.area>
 <ff57f17c-e3f2-14f3-42d8-fefaafd65637@gmx.com>
 <DM6PR04MB70812AEDDAB6DE7951F4FBBDE7E39@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
Message-ID: <ef333cb5-52ff-98da-0cfa-d89c39359c0b@suse.com>
Date:   Wed, 21 Jul 2021 10:57:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <DM6PR04MB70812AEDDAB6DE7951F4FBBDE7E39@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::13) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR13CA0068.namprd13.prod.outlook.com (2603:10b6:a03:2c4::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.11 via Frontend Transport; Wed, 21 Jul 2021 02:57:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4ec7fe0-b91b-423b-2657-08d94bf356db
X-MS-TrafficTypeDiagnostic: AM6PR04MB6517:
X-Microsoft-Antispam-PRVS: <AM6PR04MB6517A0BBAF8C68D325839872D6E39@AM6PR04MB6517.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dw+aJlIsTD/XSnAvUVaQT82LIwzsiGhL1VnUjB9B50c8iD+Ysx5bh6HrWc97VKXCa6OwHhqkq50fLU2/k7DGNI9LRrqrcx4l4BwbCnLlrY3ub/fCYJ4ZJKhi5+tTN6b4HvhaWGI9Y4gm8ElIxsQxiIm/PMo+ibKs85NjkP/cyzAWGwnatU9gF3jJDjYlKgPqvzsEqj1eON2lAQDkEcXFBRaMDG8DfoMqQWhqLVvL9jnJOxnBDwgcmo6W3jvWaoSZZ2x7vAb2PdHxzrAnqneM5DCMupxMs1M5aibZaE6/CxFXzKrCnQ75gQytcCHNKxm7Qn2MlTxNsiA5s5nF0/ThXWdg+gHgwYKPzd56q1owr6GGosFkU5sc/AJQmEcUTtjZGP5sYsI9GYzBjcfx0NEuQu3JRMcFG4BTJ+pVCXy4u+ROiFJj1KxsLIrq7CS/wWJJTFwhyJAL23dRgX18U9lef6c+4Jm35L93baM5H8BHzZVrBbrEkPd5BbLEeN2/NLoVm4aWubLzDupFzfa+iLghSgn+SJTMH/Lc7nTyblPjpmDPTnnmugEgGSz1A+6roQwz9RNy6VueHBJkbOtLe+c5i6a64tKnS/ai0daemywW//u6ugaylN6QEzFFlj+GJ7ymbrQApucGPeGbRSJUia6o2Aeg4Da47ZGcz0ESKX6S/Iwq5O6G5CUtPLHzseSEzDeMY0sG9hearqVhySfv04kjAj/J6lFQH0tmG5VYsl+VZts2JG15RnfCiOkZnHcDApD6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39850400004)(396003)(366004)(136003)(4326008)(83380400001)(66946007)(8676002)(2906002)(66476007)(478600001)(38100700002)(66556008)(86362001)(36756003)(31696002)(6706004)(26005)(31686004)(6486002)(8936002)(110136005)(54906003)(186003)(316002)(5660300002)(6666004)(2616005)(16576012)(956004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nV/lwrxIxPkPiSQoQZBCLr/MDRZpfwVk/JKe6QDNODVAYDgKjiu/xEksLeEI?=
 =?us-ascii?Q?K/A1xgbP3Wu5VBGy1ZsBWTSztmKizRrc/nGf0R7nznEClJHlGb0As6hdGiEu?=
 =?us-ascii?Q?mxfrmWtDtvrLkhz7wJaTTAFPezXw5lcjpmA+QkkjbXgroAQ54zi3HWEPwpPe?=
 =?us-ascii?Q?Uukc0kGkDhTcYgzrQ9xHVq612Dsw8QN1wII6ElMi+Nx7MD8OxyRLw9uNpGPQ?=
 =?us-ascii?Q?QBiL6gMS7fj1PbsB1fi6XAZyF9P2iPo81AEOw4NASgycmaK7vPyAo6XyGPfB?=
 =?us-ascii?Q?temH7lPZE24ZNRUvodP8S0ipvH6qATqqMC6aMAtCi2P5HRbrpRXoLxEBhx9G?=
 =?us-ascii?Q?TKx2L+chLW5iAfbVDM0zY38/GrM7c+kqNrPbVi14vpke/mk9yPRt9P9gq3Z0?=
 =?us-ascii?Q?Qtxy16W5Ixv9++03LEweBX3Q2Yz2lylle1To77374WJQwfxXmVoMgdomPWXc?=
 =?us-ascii?Q?EEVNSuJ7+Axd+1WI9+XWpOcH3N54mmboKDX4JybT7wj3hFa0Keg9l4P7JFEL?=
 =?us-ascii?Q?es9iSzMKCQGhBdDmycLXWkKmlbbeVAOe4qJ0ZqeUTz4+A/nrlqlW9qgOS3Wn?=
 =?us-ascii?Q?ld3f/YNVgeiWA8L4DAe1CwWPHMfP5OPYi/u62xkYkkaDZH/9HTi9l6D4UMxY?=
 =?us-ascii?Q?FbCUX+/MxHWCdSsf6DnZAU86M8AefIycCQK3HkCIYastZ+HVIR0uxwJoRdxE?=
 =?us-ascii?Q?vV2rmPWZ225S7tQq+6xA61El0UTvrEuXIIGjYoS3XJwlUN+5sDp5aXyirsNk?=
 =?us-ascii?Q?9d3RLuySLVevXHPj9lteltfwI5tgrQEm9jvdLcEBAPRGvbp4FUSPuGMbelPr?=
 =?us-ascii?Q?EKYFzJGYHhbvOP499c0eidqHvhy3Yky0PZm5nbMF7lgcWf2gLIQdfZcQaLUm?=
 =?us-ascii?Q?QgWlYMzXfbDnppUu/cOC/SzvywqNRAGS5sgqMiSmeE5IdLaMiTNEq/yD5wg9?=
 =?us-ascii?Q?oVPo48+EOQl+OXALD3agBjc7MixuQ5K0WGNblTvtN1EAFiE6e5wLTvQO+Waf?=
 =?us-ascii?Q?C4gC3Rjo42jjePxNJSHjgyfpo8d93RXn3pLP/SB55HNA55pDY7SY2H6OWU9b?=
 =?us-ascii?Q?dbpNMCcY2ijzBuXENh9tOhBOVOOOrwDFHBCetEs2EN1j53b/0CostIAaNrGJ?=
 =?us-ascii?Q?MXz9LWcyyO+uDe61aCTv/QZOiinsuj55aF6U+wH5sBJVlekdqbK3LsMsgMVl?=
 =?us-ascii?Q?GfMmMUFq3160E+rEMWg4aWWxT+BlKx/eoNtL35IbGrApkWz7vApz+7haYKFD?=
 =?us-ascii?Q?WWzAHuzG+S/e+LLQQOZ8j7tyWVanSukps/LVZiN67Nca3aG0gmCkpR22VbVQ?=
 =?us-ascii?Q?DAhK7rlnjYaMzt07wW+F3DGL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ec7fe0-b91b-423b-2657-08d94bf356db
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 02:57:55.7946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NzvPQW8Q9s+1J5uDtfTvPmAF6d3t3XGcEJ7gcqGK84oHuRR7/gccfofoxLKNbjkt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6517
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/21 =E4=B8=8A=E5=8D=8810:23, Damien Le Moal wrote:
>>
>> I'm pretty clear about the hook I supposed, it's not for stable ABI or
>> complex framework, just a simple kit to make things a little easier.
>>
>> The single purpose is just to make some throw-away debug setup simpler.
>>
>> Whether debug tool should be throw-away is very debatable, and you're
>> pushing your narrative so much, that's very annoying already.
>>
>> You can have your complex framework for your farm, I can also have my
>> simple setup running on RPI4.
>>
>> I won't bother however you build your debug environment, nor you should.
>>
>> Sometimes I already see the test setup of fstests too complex.
>> I totally understand it's for the portability and reproducibility, but
>> for certain debugs, I prefer to craft a small bash script with the core
>> contents copied from fstests, with all the complex probing/requirement,
>> which can always populate the ftrace buffer.
>>
>>
>> If you believe your philosophy that every test tool should be a complex
>> mess, you're free to do whatever you always do.
>>
>> And I can always express my objection just like you.
>>
>> So, you want to build a complex framework using the simple hook, I would
>> just say NO.
>=20
> I think that Dave's opinion is actually the reverse of this: hooks, if we=
ll
> designed, can be useful and facilitate adding functionalities to a comple=
x test
> framework. And sure, the hook infrastructure implementation can in itself=
 be
> complex, but if well designed, its use can be, and should be, very simple=
.

In fact, if we really integrate the hook into the fstests to the=20
standard of Dave, I doubt it can be that simple ever.

E.g. if the hook is going to inherit all the fstests shell macros, from=20
_not_run() to various _require_*, then it's completely the opposite what=20
I want, and it's not going to be simpler than writing a proper test case.

What I original want is so simple that for start hook, it only accepts=20
one parameter (for the sequence number), one environment variable (for=20
the temporary path).

That's the level of simplicity I want, no complex calls/probes just a=20
proper test case.


Yes, a well designed hook can do that without problem, as it will be=20
superset of the simple hook.

But then when one is going to do complex things, and reading the doc, it=20
will be way more complex than the original purpose.
And I hate to even have such possibility to be complex.

Ironically not to mention the maintaining effort involved. E.g. if the=20
hook is going to inherit those shell variables/macors, then any changing=20
in the fstests itself will affect the hooks, no matter if there is any=20
real users of such complex thing.

>=20
> Implementation is done once. The complexity at that stage matters much le=
ss than
> the end result usability. As a general principle, the more time one put i=
n
> design and development, the better the end result. Here, that means hooks=
 being
> useful, flexible, extensible, and reusable.

Hard to say.

I still can't yet get used to the preamble change introduced recently.
(The group list not properly updated)

And it's pretty clear it won't be the last change of the fstest=20
infrastructure.

Hook won't be more stable than fstests itself, and it will take time to=20
maintain, no matter if there is really users for it.

>=20
> And one of the functionality of the hook setup could be "temporary, exter=
nal
> hook" for some very special case debugging as you seem to need that. What=
 you
> want to do and what Dave is proposing are not mutually exclusive.

Yeah, it's a subset in theory.

But then that's completely unrelated to my initial purpose.

I won't object if someone is willing to do that separately, and may be=20
even happy if a such dedicated, simple hook can be provided without=20
reading the complex doc/design of the framework.

But putting tons of unrelated things into an originally simple purpose, no.

Please do that in a separate patch/thread for the complex hook framework=20
then.

Thanks,
Qu

>=20
>>
>> And you have made yourself clear that you want to make your debug setup
>> complex and stable, then I understand and just won't waste my time on
>> someone can't understand something KISS.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Cheers,
>>>
>>> Dave.
>>>
>>
>=20
>=20

