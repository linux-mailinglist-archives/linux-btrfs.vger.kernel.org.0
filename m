Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E985F39103E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 07:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhEZGAF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 02:00:05 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:59796 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231657AbhEZGAE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 02:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1622008712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MaX/seYswDGyiBjYBa7hEJ5hkj/comCkuNwlBjbyhEo=;
        b=d+QRFF6BIht6kqh6zNIY6XgQxHnocU+c+DI5bk/a0tZJPK9ExlrCCIgDwdTJP5RIcBhty8
        gWemQx9pItxuZpcMapVreHZCRLTNO/eUyiVEWuiHFB+A3+RhyNJRnefw5LNpwQlUpe5YtX
        Hz0tfrIaLpjUzCE6B9IWju+qWG0vT8k=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-6-VwA0rU0XMeWXmf7Kfo0gSQ-1; Wed, 26 May 2021 07:58:31 +0200
X-MC-Unique: VwA0rU0XMeWXmf7Kfo0gSQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiZlYSjoi03L6eYsdQohsRt/64U8LMn3j4qpjgvbb559jZTSvtyzZniCBR9KWwiT+V6ycqdeVwOQ4oc1JSATswB5Bq3nbBDgamcJqHYD6MBTjlcj/Aw6fCiatP4tqQnF2P93l3Cg/joIuN8InwkN102MsB8OlizmAKAYEFCpvqdt+ky8+uFUH6fliJsJEkWpwo70ahMv62j2n6w84FHoBC8I0ekH2460OR/dG5CRoi0A15eFNVhyywtCy76s6SjnK84c3jYjotExckwjjwrgsPAbd7oDNjmV1VwSMZBJUWZqdCqFQDtCUvL3R9mOxjTMnDosQ1J/6qSNTsLp9lOg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzwOkLSQDEY74/4bUrZx5vwcAIlomfn7xI+tLQOSc40=;
 b=n81S92y931S8F5+WQKthrrWP5ijGV6zWwEzLlbBFC70/6dryOmGRRPRK2Q79vt1ELKusycd7riHtEVnTry55QF8I/ZFCVx2DLtEhA73x2N+UWgULBYY2tVSnZnh7v+vkM6Rvk1xQyJQSQcdG64exG/CvOIhxfxso5SBobO1qUP9HiINbLx7xEQZi8boeby7Jh0hNaOJi9DKwQqodTuECiaIj9FY6JcNyPD5TAnTa79uIsoFeEZLJ23sOpmL8OBw/jXUKxSw1cQuRaj5RXo/mhhrYcuenmi7a4G4vMItQOqqZQwWt2BRsvVzj6RJR0bBlW10c5UVr8jqyHHut196r7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB4040.eurprd04.prod.outlook.com (2603:10a6:209:50::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Wed, 26 May
 2021 05:58:30 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb%9]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 05:58:29 +0000
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
To:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     linux-btrfs@vger.kernel.org
References: <51186fd5-af02-2be6-3ba3-426082852665@suse.com>
 <20210525044307.xqfukx6qwu6mf53n@riteshh-domain>
 <ba250f72-ce16-92c0-d4b6-938776434ea2@gmx.com>
 <1a2171a5-f356-9a2e-d238-0725d3994f45@gmx.com>
 <20210525092305.3pautkpiv3dhi3oj@riteshh-domain>
 <5a3d0e6c-425b-9b6a-ffec-9243693430c5@gmx.com>
 <181af010-af18-9f78-4028-d8bb59237c05@gmx.com>
 <20210525102010.hckdsumqfil3vnsu@riteshh-domain>
 <82070e33-82f7-3a54-7620-b4a43bdaff50@gmx.com>
 <20210525130227.ldhbj4x7sryr63bk@riteshh-domain>
 <20210526052902.qsaodegp6emjg5bl@riteshh-domain>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <6b706161-ab53-29e1-d8bb-f5fd779f1722@suse.com>
Date:   Wed, 26 May 2021 13:58:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210526052902.qsaodegp6emjg5bl@riteshh-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR13CA0123.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::8) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR13CA0123.namprd13.prod.outlook.com (2603:10b6:a03:2c6::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend Transport; Wed, 26 May 2021 05:58:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e9870ed-f2a6-48f5-2dde-08d9200b4947
X-MS-TrafficTypeDiagnostic: AM6PR04MB4040:
X-Microsoft-Antispam-PRVS: <AM6PR04MB40401C09CA41490A8968D615D6249@AM6PR04MB4040.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hc0k/secox555H5oVPJBCqwq228svxgLp8q0UTEfE/fZwrRXr1NxZ6hCwL91HipqU1jOTyNDhmgTVfZHGM2tnmhZXqMJoTuOjXUscNBNJg1ZK3Gc0wSwgtqyJfs8OSVk3xw4JoIAOZ3iyI2/Gc45MeGqDDkHEI0QMj00958QTVY9/AJ1GM+FkEMZcL1+jgWh/Vc0GASjtfEWe0MGJbTSFo1MPYzhYlWODALw5psQ1KeDKGXKia/ptAI/CVBlHBQ+1S2jdt/hMBTiPafd9CHsiqvJymIdLlqYCxf3Z957TLzUpaSFPAi4aO2XLIekomI6ky94vxywiVZkdY/fEZkrRZ+0uYmDssAWlyFxU+3nQDY9xjFq14zC650NmW+1y4Bhirz2FyWuFlDFovt+SHqmvKJRWTqnb82t7/5d2qfSM5Ks8fjdcUYSIOPxjIA5IuONtevFrzxp8BDKQnc3VyNJPE50VcK2eWZckyu03geIL69Y0xbPDHliVqLkhBg3A5pKeFkpe5enSV1bLS7uIlGW8NdIueE64HvLXWokpaGfzV4dyMIln+9Wwf77nWQ3sVqu7609+1WZcvqZag4+XkQOT2ooPq6v1HYmBZ5K99TtrbnipxOtsvACE4REFCWU5/TJ1GAfQva8Xp5qAJoEyAr8nU/VhwfNGUc3kkMEfAgV1ozuNmYChwO6EyaHR0QJs29cZnMqtnSZus53H7hNozGw2/aIcT3OcLPfErYgDHjA3zIWS5it9hhyNuMj8/l/MQ9i3FBaBlYiMlZvI/OAllcmZsjdVu4AGFUnlb2ITcnmnOgPG9Nk+i2oqeT7bY3OeFVLQ8nvQiN89ViFfGc72uaZPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(346002)(136003)(39850400004)(6666004)(31686004)(36756003)(31696002)(26005)(186003)(8936002)(316002)(83380400001)(2906002)(2616005)(478600001)(16576012)(6486002)(6706004)(86362001)(45080400002)(66556008)(110136005)(66946007)(956004)(966005)(5660300002)(16526019)(66476007)(4326008)(38100700002)(8676002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2M1NMJ04VLDahrYmTWBPej11qzu7yfj9rX2CQDvy5LDEUTdm6ZPk4EKzC7Fo?=
 =?us-ascii?Q?eaVdRgwDiO5xHhXvI3bRDKhAUw58UTTbm949ZTOT0x0UItxqB5bNwiIzoZxG?=
 =?us-ascii?Q?yOP+FPQIA1/88T9oBS4PYmiHEPDzWTd2d6YWMP7c/j7E2Y9Q+alGIAhtwJym?=
 =?us-ascii?Q?xtiH3dkrEDKMh6FvA9tc87PSU6S14Xl3kkfEo4wTilWDm74uJMhAS3mSA+L6?=
 =?us-ascii?Q?2YnEITpmQVcPiSXaJgZG/fRaWfNQwPbu7GYKtqt5O7Ix0Ly5n8awjXzdPWbO?=
 =?us-ascii?Q?wwIEBtgjaiSvEsuaAC0S3slzr8WzSiT2LCuXYlc2dme0XeCbrJuATty+F76w?=
 =?us-ascii?Q?r97Sw3XDryBlFsuSQbnjB9WiuSS/UEAKH+phgT5mChoHmR8A9ZuryCHH47FY?=
 =?us-ascii?Q?T4cEo3ud7+xBQbLAy2JlpTJsQJucnRNte/5QJl45P8vLt1CQEW6IL0YkkE6W?=
 =?us-ascii?Q?B8KTnSzmvwjaJoMSYObI0l4E9ZhwBOrJjQhys3Ny4dhMJbh5GLuf/ypqwDCI?=
 =?us-ascii?Q?8SFTsM/GVjrmu2bibjV7E3iPkonKWQNnuSuPQm4LUNrPfAV1F5L23P2okfmc?=
 =?us-ascii?Q?346/uhmBqXGfejnqK83zB9XYt0qqquMP7msAG7x37ToZhvfbed1qGv0CMI1k?=
 =?us-ascii?Q?78gWZyKnq777e6YZQzomixbV9ZkJpR+3Iv9vZoN1UJZDhsdU/tAXxEWwp9AQ?=
 =?us-ascii?Q?Z/yYEFPFgjf0/liDys6qexg1xCooYw+W5QPdtvv4lvN+H++CDAaxvFRCBDiQ?=
 =?us-ascii?Q?e/OmAIoyBk5laLys4QD8Jq6TJb1mFKMjU7NgXQgkmWa49gP7MqePLD5JTMLd?=
 =?us-ascii?Q?UJBOeJXgh28Vomu8WUnTDNqfp/x5Wim3MbCh4G+VBE6+hcq/KJ4Ojz5xHfyE?=
 =?us-ascii?Q?VOXQmN4AijXEvncshHN2ftBkNSJ/qNPeMCBNLXAs0OIs4N1FB1NwiBCoPKGL?=
 =?us-ascii?Q?uM/sbZDKbQMHj4BsQnJY7oSnBlJicX59G1EWURkFP5tIAYcJoKqtJiyE8gtB?=
 =?us-ascii?Q?BZcSQ187rDzubYeybrr1EGFB80iNftESUo88AShz+r0lKJ3fXizj1h24GuU6?=
 =?us-ascii?Q?5brO5Y2EbhjZ3i/wtxykfPL/cDrXXhD8ALmucuDPdPThTQs6Ih9ak0jz8JLY?=
 =?us-ascii?Q?/77PnRcdWBZR2EdHaqvRX+Q/fufPiE99eUi7y9R6Kfz/8ZC4H3F07MZ6NOoO?=
 =?us-ascii?Q?+dWQYoyHlesTgesGZUvshDmgoTXRh2U/KYcZNQiGocLrBCfuZaE/Un3xWlEb?=
 =?us-ascii?Q?AhySbk2PWZiKb+jJI9e6hedr7NhbaDpQCSAEJQ3OyTDZycOgGL2MR3OWL5Sa?=
 =?us-ascii?Q?zupteyobmXo5gYejmVfmRBXe?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9870ed-f2a6-48f5-2dde-08d9200b4947
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 05:58:29.8046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y00r8H7lKgXTuSnw45cDfMDChSWuioSfHu7QuwqoMBGPvIsy8AMxVzi85uS0q/QC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4040
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/26 =E4=B8=8B=E5=8D=881:29, Ritesh Harjani wrote:
> On 21/05/25 06:32PM, Ritesh Harjani wrote:
>> On 21/05/25 07:41PM, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/5/25 =E4=B8=8B=E5=8D=886:20, Ritesh Harjani wrote:
>>> [...]
>>>>>>
>>>>>> - 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for=
 64-
>>>>>>    =C2=A0 bit memory addresses")
>>>>>>    =C2=A0 Will screw up at least my ARM board, which is using device=
 tree for
>>>>>>    =C2=A0 its PCIE node.
>>>>>>    =C2=A0 Have to revert it.
>>>>>>
>>>>>> - 764c7c9a464b ("btrfs: zoned: fix parallel compressed writes")
>>>>>>    =C2=A0 Will screw up compressed write with striped RAID profile.
>>>>>>    =C2=A0 Fix sent to the mail list:
>>>>>>
>>>>>> https://patchwork.kernel.org/project/linux-btrfs/patch/2021052505524=
3.85166-1-wqu@suse.com/
>>>>>>
>>>>>>
>>>>>> - Known btrfs mkfs bug
>>>>>>    =C2=A0 Fix sent to the mail list:
>>>>>>
>>>>>> https://patchwork.kernel.org/project/linux-btrfs/patch/2021051709551=
6.129287-1-wqu@suse.com/
>>>>>>
>>>>>>
>>>>>> - btrfs/215 false alert
>>>>>>    =C2=A0 Fix sent to the mail list:
>>>>>>
>>>>>> https://patchwork.kernel.org/project/linux-btrfs/patch/2021051709292=
2.119788-1-wqu@suse.com/
>>>>>
>>>>> Please wait for while.
>>>>>
>>>>> I just checked my latest result, the branch doesn't pass my local tes=
t
>>>>> for subpage case.
>>>>>
>>>>> I'll fix it first, sorry for the problem.
>>>>
>>>> Ok, yes (it's failing for me in some test case).
>>>> Sure, will until your confirmation.
>>>
>>> Got the reason. The patch "btrfs: allow submit_extent_page() to do bio
>>> split for subpage" got a conflict when got rebased, due to zone code ch=
ange.
>>>
>>> The conflict wasn't big, but to be extra safe, I manually re-craft the
>>> patch from the scratch, to find out what's wrong.
>>>
>>> During that re-crafting, I forgot to delete two lines, prevent
>>> btrfs_add_bio_page() from splitting bio properly, and submit empty bio,
>>> thus causing an ASSERT() in submit_extent_page().
>>>
>>> The bug can be reliably reproduced by btrfs/060, thus that one can be a
>>> quick test to make sure the problem is gone.
>>>
>>> BTW, for older subpage branch, the latest one without problem is at HEA=
D
>>> 2af4eb21b234c6ddbc37568529219d33038f7f7c, which I also tested on a
>>> Power8 VM, it passes "-g auto" with only 18 known failures.
>>>
>>> I believe it's now safe to re-test.
>>
>> Thanks. I will give your latest subpage github branch a run then :)
>=20
> Hi Qu,
>=20
> I am still running the tests, but I observed this warning msg with btrfs/=
062.
> Sorry, did I miss any patches to take?

Nope, I believe it's a new bug.

Either caused by the new code base or something else.

Please go ahead, this random warning doesn't seem to be that frequent, I=20
have only observed it om btrfs/062, btrfs/072, btrfs/074.

Of course, if you have stable way to reproduce, it would help a lot of=20
locate the problem.

Thanks,
Qu
>=20
> I am testing your below branch
> https://github.com/adam900710/linux/commits/subpage
>=20
> btrfs/062
> <...>
> [ 1466.928035] BTRFS info (device vdc): has skinny extents
> [ 1466.928103] BTRFS warning (device vdc): read-write for sector size 409=
6 with page size 65536 is experimental
> [ 1466.936997] BTRFS info (device vdc): checking UUID tree
> [ 1467.295249] BTRFS info (device vdc): balance: start -d -m -s
> [ 1469.177204] ------------[ cut here ]------------
> [ 1469.177402] WARNING: CPU: 5 PID: 319 at fs/btrfs/extent_map.c:306 unpi=
n_extent_cache+0x78/0x140
> [ 1469.177597] Modules linked in:
> [ 1469.177655] CPU: 5 PID: 319 Comm: kworker/u16:5 Not tainted 5.13.0-rc2=
-00382-g1d349b93923f #34
> [ 1469.177773] Workqueue: btrfs-endio-write btrfs_work_helper
> [ 1469.177845] NIP:  c000000000a334c8 LR: c000000000a334b4 CTR: 000000000=
0000000
> [ 1469.177943] REGS: c00000000d7e7750 TRAP: 0700   Not tainted  (5.13.0-r=
c2-00382-g1d349b93923f)
> [ 1469.178054] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  =
CR: 84002448  XER: 20000000
> [ 1469.178187] CFAR: c000000000a3303c IRQMASK: 0
> [ 1469.178187] GPR00: c000000000a334b4 c00000000d7e79f0 c000000001c5dc00 =
c00000002b15f968
> [ 1469.178187] GPR04: 0000000000070000 000000000001a000 0000000000000001 =
0000000000000001
> [ 1469.178187] GPR08: 0000000000000002 0000000000000002 0000000000000001 =
ffffffffffffffff
> [ 1469.178187] GPR12: 0000000000002200 c00000003ffe8a00 c000000000213568 =
c00000000a1f1240
> [ 1469.178187] GPR16: c00000002b934000 c000000026f4a2c0 c00000000d7e7ac8 =
0000000000000001
> [ 1469.178187] GPR20: 0000000000000000 c000000026f49ec8 0000000000000024 =
c000000022bda000
> [ 1469.178187] GPR24: 0000000000000020 000000000001a000 c000000026f49e08 =
000000000000000d
> [ 1469.178187] GPR28: 000000000007b000 c000000026f49e88 c000000026f49e68 =
c00000002b15f968
> [ 1469.179053] NIP [c000000000a334c8] unpin_extent_cache+0x78/0x140
> [ 1469.179137] LR [c000000000a334b4] unpin_extent_cache+0x64/0x140
> [ 1469.179220] Call Trace:
> [ 1469.179254] [c00000000d7e79f0] [c000000000a334b4] unpin_extent_cache+0=
x64/0x140 (unreliable)
> [ 1469.179371] [c00000000d7e7a50] [c000000000a23d28] btrfs_finish_ordered=
_io+0x528/0xbd0
> [ 1469.179473] [c00000000d7e7ba0] [c000000000a64360] btrfs_work_helper+0x=
260/0x8e0
> [ 1469.179572] [c00000000d7e7c40] [c000000000206954] process_one_work+0x4=
34/0x7d0
> [ 1469.179687] [c00000000d7e7d10] [c000000000206ff4] worker_thread+0x304/=
0x570
> [ 1469.179771] [c00000000d7e7da0] [c00000000021371c] kthread+0x1bc/0x1d0
> [ 1469.179855] [c00000000d7e7e10] [c00000000000d6ec] ret_from_kernel_thre=
ad+0x5c/0x70
> [ 1469.179956] Instruction dump:
> [ 1469.180007] 4887a5d1 60000000 7f84e378 7fc3f378 38c00001 e8a10028 4bff=
f949 7c7f1b79
> [ 1469.180114] 41820010 e89f0018 7fa4e000 419e000c <0fe00000> 41820088 fb=
7f0060 395f0068
> [ 1469.180222] irq event stamp: 1458062
> [ 1469.180271] hardirqs last  enabled at (1458061): [<c0000000012ad654>] =
_raw_spin_unlock_irq+0x44/0x80
> [ 1469.180411] hardirqs last disabled at (1458062): [<c0000000012a1cfc>] =
__schedule+0x31c/0xce0
> [ 1469.180524] softirqs last  enabled at (1457908): [<c0000000012ae818>] =
__do_softirq+0x5e8/0x680
> [ 1469.180661] softirqs last disabled at (1457899): [<c0000000001dc56c>] =
irq_exit+0x15c/0x1e0
> [ 1469.180760] ---[ end trace f937e1c0f5a3b8fa ]---
> [ 1469.537482] BTRFS info (device vdc): relocating block group 298844160 =
flags data|raid1
> [ 1470.963925] BTRFS info (device vdc): found 343 extents, stage: move da=
ta extents
> [ 1471.332749] BTRFS info (device vdc): found 341 extents, stage: update =
data pointers
> [ 1471.656937] BTRFS info (device vdc): relocating block group 30408704 f=
lags metadata|raid1
> [ 1472.015159] BTRFS info (device vdc): found 84 extents, stage: move dat=
a extents
> [ 1472.355357] BTRFS info (device vdc): relocating block group 22020096 f=
lags system|raid1
> [ 1472.689631] BTRFS info (device vdc): found 1 extents, stage: move data=
 extents
> [ 1473.052977] BTRFS info (device vdc): balance: ended with status: 0
>=20
>=20
> -ritesh
>=20

