Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59116363C61
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 09:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237708AbhDSHUp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 03:20:45 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:54419 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237682AbhDSHUk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 03:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1618816808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W1WKP/4nuZKhXrMOVjz/q+kXKfMoOsJlvxVIwUMcxU4=;
        b=jD5956p5eK67KN6nLQP9a6Jof5llIclR2GV10CKlsAeCGmmsaSVec302WhvUGBgVBRZS7Q
        MLf0e/CP1V+AeZES1sd7QQ4W32Wkzqy03A6lFXff0WmFgUd35UVxhhkBug+bAagNZQtV0W
        hZgdjf7mTaMy793Zz0XvLuZ0IWB0778=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-29-haRZna2fOUy4Da99EgCbHA-1; Mon, 19 Apr 2021 09:20:07 +0200
X-MC-Unique: haRZna2fOUy4Da99EgCbHA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeMaQ8UWjSEs4hAAyVWd+zyKboN1Bs+qXQFL261rkZQNI4kcxTMyZrgTRST/9pjOdbE/aGKv0LNUPCoK739H39yku0gpYdzrbSMv/wX80r1IxAYnDd73OkbZ855fh/whONIVbHmYi/Huq4/TAwIolEt1MGcWgYXNzSOAtfbKCK7j2hfzDCBbddrQw8CzPAu6JsN4JwooxbHFICqH8jZUi5BiZCD3yd0SvWEoFOvkpQHprFYggMxrC2DIJdXAWisXV6F6y5bzywDyPe2vsauYA6xart/IAl25NUoiOwuibVfsrrm1ifAipUO2L0n3UAZfPrWlNRXZim5wKeZiL+PTxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GYcr2+lBalG+8ZVP8FdFF/2nyHU1gke0fKCs7AU/hU=;
 b=i4H2j4q75YF1oCLSbeVySDsKlIeSqS7bVWh/MRj/LlUUGX1sRyiC9hvJC9tDDna6+P09ybvyPR4YkRXk08SvYigPQIskU7fDKsLLw0CMnc6Xk+ZiUkYEQkOu9jKWoRBhvc87pmHmpc/PelPuiPFPdFGvNfU18Pb7GgrykLXt8098BuT6FUaTwoWhczpc096CyE9ucTBBC/F4FgSt/zx0pbq1slvEonVgqn7Ggo+al+rroRBDd2HZu98UOpmwBg0OtyZtbrMXOziRPY4U92HdF+C3+FKbto+dN/rxUklzbQ2r0ptrAzgCZ8wQ/J+Vh2sZPLFjQIl+qG5kAYtWWukrEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB7927.eurprd04.prod.outlook.com (2603:10a6:20b:2ad::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Mon, 19 Apr
 2021 07:20:06 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7%6]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 07:20:06 +0000
To:     riteshh <riteshh@linux.ibm.com>, Qu Wenruo <wqu@suse.com>
CC:     Ritesh Harjani <ritesh.list@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <a58abc5a-ea2c-3936-4bb1-9b1c5d4e0f77@gmx.com>
 <ef2bab00-32ec-9228-9920-c44c2d166654@gmx.com>
 <20210415034444.3fg5j337ee6rvdps@riteshh-domain>
 <20210415145207.y4n3km5a2pawdeb4@riteshh-domain>
 <8bdb27e4-af63-653c-98e5-e6ffa4eee667@gmx.com>
 <08954bca-98c1-1c9c-54a8-74ba95426d7e@gmx.com>
 <c06a013e-0f7d-21f5-0bd1-9c6c22024fd8@gmx.com>
 <20210416055036.v4siyzsnmf32bx4y@riteshh-domain>
 <a5478e5e-9be4-bc32-d5e1-eaaa3f2b63a9@suse.com>
 <20210416165253.mexotq7ixpcvcvov@riteshh-domain>
 <20210419055915.valqohgrgrdy4pvf@riteshh-domain>
 <93a2422e-6d5d-1c97-49ad-d166fe851575@gmx.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <03236bad-ecb5-96c7-2724-64a793d669bf@suse.com>
Date:   Mon, 19 Apr 2021 15:19:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <93a2422e-6d5d-1c97-49ad-d166fe851575@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR01CA0014.prod.exchangelabs.com (2603:10b6:a02:80::27)
 To AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR01CA0014.prod.exchangelabs.com (2603:10b6:a02:80::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 07:20:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8b50113-eae0-4db6-0837-08d903038eb6
X-MS-TrafficTypeDiagnostic: AS8PR04MB7927:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB7927175CF7B89BBF7A0DA146D6499@AS8PR04MB7927.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rAFbTSxhp9PuKDhRGHq+741oKYMzmiVTyjNaO6KV/pXNSTUqyosRqdVIRlWvZ1lpeWlq5TyI7rABWmRUffVDpV1Do6xhDvLTJhwuxfYXN50Tx4qYOaHZqoif3dywW1O7vFLLwv5ZmuAxbpwJksOC8lmXB5Nq4YC2TffFZlJ5Z/rJLsjMYWvfnlSUvkO4pxfSbd9Wg2YqWHhu6iqzRlKUGv6muc+qSYmyHb+Rv87GdljiJXBJ8sfCsitm2Fx6e5toYBIKRJtF8BCec0GFc7lAkeYnrp/vSWHjHzbazUimV5G+lo0U2wpjzJV5iS1wa3AwHxoXnEOgsQtajZiT3ldhhHMqFBS4362jMWm+0AvcciEQiYTIBKszxMQrshxIdIq5wfYD5uCZ7FTR8VM2R2hE+engrUK0IyEYwwrDPoAH7fPXL578Jl+Caa2Djl4jVd6CLsNUf+7VEAHKsag792uKWGdN/5tGgsEEofvQ4SbcX9ucPWdnNOWhx7x+qvmBQGhrqoJ30oPYGuHRgXUNpVh3FJtJvJolAaAZZos6VN7yaQ+ObIsj4RvMUjvvcLo+CEwEH9fgn+MsoamJTbYZvS0c9C5NgJZLxDPJF7cW8bap2lzlCJ0sC6bQn4Fr2kfY4y5bjSqmea4BuW234sh1BGiqoHzF0LNMMmfM5C+Zx5f7/MPEzWNzmZqez54TgphCHR/zFRBgbjDcVPPnuClYjPYTeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(376002)(396003)(39860400002)(8676002)(2906002)(38100700002)(38350700002)(8936002)(478600001)(16576012)(30864003)(52116002)(54906003)(16526019)(110136005)(5660300002)(31686004)(2616005)(956004)(83380400001)(6486002)(36756003)(86362001)(316002)(66946007)(66556008)(4326008)(66476007)(6706004)(186003)(6666004)(26005)(31696002)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aUpGh0Z+StlWolDFqZXscePW/Cd9MXydzYXV7fEyNnacfVUOeFjN4EWY4k0M?=
 =?us-ascii?Q?3fi0t+NjVWq6PGR6oqndX9BZvCwnvq+dAL57/K8Na1GuhdySTNokZqyFFXK5?=
 =?us-ascii?Q?8TE/2QhsxCqVkwwJMRzG1vK4OPIx+bC7evvu5HdD/SXKIs5o+t8Ut3fo3yjF?=
 =?us-ascii?Q?Qqe4wL/bIf0v3YxAs8iHJ09F5nE6RKaFGYuN+uwDb0h3l6+wx24KLnh+GuwI?=
 =?us-ascii?Q?7/tmtGgKlWAS7UQvzHlgrhbaWm0ZIUc2cizD3/nLWZbu61ZIbRG5aq/3qU8t?=
 =?us-ascii?Q?uR2jIKOsqGGq7mM2s3SbmlHc/0sLIId+a01LLfz3tQpdzMkWBrOgwm0JWgIC?=
 =?us-ascii?Q?8Cl/8aPpfEeWRnKxgqgP9J1ejVfkfqbNcOncHDeaF3GQHgCLEY2Z/L+Z3bEd?=
 =?us-ascii?Q?GKa4zMOKviFv+B2B+LBtGMxS2YolBPeyQB+A23BIQxpE4X0n0d+n+rSMFIDD?=
 =?us-ascii?Q?FhF5mR+cWCWSBVBw9tX6i33I9XfJwDKZ4Ze1B+kzo7398bdnP5V9bb8frNyD?=
 =?us-ascii?Q?EkduXgnNnbiU1l0mlpM8e+9ZbPtmpp6ycZRZJCeTuCSjBdYSsjNTBg6HAFMy?=
 =?us-ascii?Q?8uSkxQoIVySm7I64jeugGd3TE39a3HqcTq/f2hj5Q4ffLEcHYJ3L0EAmpoKt?=
 =?us-ascii?Q?b1uTDqc/eFEE8AE1OQqmJrLLIQDoiy1LF0zxe98Lkoqr2zMzbZgbLTPfRBKN?=
 =?us-ascii?Q?4kNrjGoI/Fnjc6EzmyPnIFUHUTcEKbt55KSGYK85KOk6QvtsTOQQ7Cp6379d?=
 =?us-ascii?Q?YC964S1du22b0Fl3Mxezdp2SM+Ecm8xD9jMF6W7xsNB2H4nsom8vl9o5xDO9?=
 =?us-ascii?Q?nFBjsCoPeEBx7Vku7iVo8hjR42Wk6XOY9oEoeAPBE4Zz4hsRHJe8Ya68NZs5?=
 =?us-ascii?Q?kbmtXYTQhy7uQvtbR4YFQPUBv4mOzxNrdZAEDX+WvusKYQXAX4uhJnd/hVxx?=
 =?us-ascii?Q?Md9TgwHU8v/0cc9EMeY0jJcHzpAIhuR05zg/RjWHCfvhYPUf5Hlme1xoQGa9?=
 =?us-ascii?Q?jvexLDSG1PCJwO6gersji5ZUokZjbXob+1q0Vvv8dupLyzV/s/3WaVU03flb?=
 =?us-ascii?Q?0Ysgc0WcaN/wmuBOK84tvl2QeCoXpB9SWDAp3NJy6HWlxNKeLfmgc0FZo87C?=
 =?us-ascii?Q?lzIlDF13hNVY4Fo85/NkRykPvSwvOWWSIcpHA6OurlyJZwv8pnYSxS12pf7g?=
 =?us-ascii?Q?14MkcdxIXGB8vSS/XuCyo8UuyLzcpl1xGJXt7C/u6fh+xNyRSnvQ5zlOmZJn?=
 =?us-ascii?Q?TUO6AFkSPOGb93w74uMMaqGCIUbfzxiiPRcskn5anLySrfiNG23oG+3qCLAl?=
 =?us-ascii?Q?M0CjaRiT6ZR0XwFPu+4JzMEv?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b50113-eae0-4db6-0837-08d903038eb6
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 07:20:06.5119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JuvcuPxje40W/4QGAsidXMXMApw0PsA2mzmvDG4OqukbWK9yfd8e8+gAgMgAb7p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7927
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/19 =E4=B8=8B=E5=8D=882:16, Qu Wenruo wrote:
>=20
>=20
> On 2021/4/19 =E4=B8=8B=E5=8D=881:59, riteshh wrote:
>> On 21/04/16 10:22PM, riteshh wrote:
>>> On 21/04/16 02:14PM, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/4/16 =E4=B8=8B=E5=8D=881:50, riteshh wrote:
>>>>> On 21/04/16 09:34AM, Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> On 2021/4/16 =E4=B8=8A=E5=8D=887:34, Qu Wenruo wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2021/4/16 =E4=B8=8A=E5=8D=887:19, Qu Wenruo wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2021/4/15 =E4=B8=8B=E5=8D=8810:52, riteshh wrote:
>>>>>>>>> On 21/04/15 09:14AM, riteshh wrote:
>>>>>>>>>> On 21/04/12 07:33PM, Qu Wenruo wrote:
>>>>>>>>>>> Good news, you can fetch the subpage branch for better test=20
>>>>>>>>>>> results.
>>>>>>>>>>>
>>>>>>>>>>> Now the branch should pass all generic tests, except defrag=20
>>>>>>>>>>> andknown
>>>>>>>>>>> failures.
>>>>>>>>>>> And no more random crash during the tests.
>>>>>>>>>>
>>>>>>>>>> Thanks, let me test it on PPC64 box.
>>>>>>>>>
>>>>>>>>> I do see some failures remaining with the patch series.
>>>>>>>>> However the one which is blocking my testing is the=20
>>>>>>>>> tests/generic/095
>>>>>>>>> I see kernel BUG hitting with below signature.
>>>>>>>>
>>>>>>>> That's pretty different from my tests.
>>>>>>>>
>>>>>>>> As I haven't seen such BUG_ON() for a while.
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Please let me know if this a known failure?
>>>>>>>>>
>>>>>>>>> <xfstests config>
>>>>>>>>> #:~/work-tools/xfstests$ sudo ./check -g auto
>>>>>>>>> SECTION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- btrfs_4k
>>>>>>>>> FSTYP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- btrfs
>>>>>>>>> PLATFORM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Linux/ppc64le qemu=20
>>>>>>>>> 5.12.0-rc7-02316-g3490dae50c0 #73
>>>>>>>>> SMP Thu Apr 15 07:29:23 CDT 2021
>>>>>>>>> MKFS_OPTIONS=C2=A0 -- -f -s 4096 -n 4096 /dev/loop3
>>>>>>>>
>>>>>>>> I see you're using -n 4096, not the default -n 16K, let me see=20
>>>>>>>> if I can
>>>>>>>> reproduce that.
>>>>>>>>
>>>>>>>> But from the backtrace, it doesn't look like the case,
>>>>>>>> as it happens for data path, which means it's only related to=20
>>>>>>>> sectorsize.
>>>>>>>>
>>>>>>>>> MOUNT_OPTIONS -- /dev/loop3 /mnt1/scratch
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> <kernel logs>
>>>>>>>>> [ 6057.560580] BTRFS warning (device loop3): read-write for secto=
r
>>>>>>>>> size 4096 with page size 65536 is experimental
>>>>>>>>> [ 6057.861383] run fstests generic/095 at 2021-04-15 14:12:10
>>>>>>>>> [ 6058.345127] BTRFS info (device loop2): disk space caching is=20
>>>>>>>>> enabled
>>>>>>>>> [ 6058.348910] BTRFS info (device loop2): has skinny extents
>>>>>>>>> [ 6058.351930] BTRFS warning (device loop2): read-write for secto=
r
>>>>>>>>> size 4096 with page size 65536 is experimental
>>>>>>>>> [ 6059.896382] BTRFS: device fsid=20
>>>>>>>>> 43ec9cdf-c124-4460-ad93-933bfd5ddbbd
>>>>>>>>> devid 1 transid 5 /dev/loop3 scanned by mkfs.btrfs (739641)
>>>>>>>>> [ 6060.225107] BTRFS info (device loop3): disk space caching is=20
>>>>>>>>> enabled
>>>>>>>>> [ 6060.226213] BTRFS info (device loop3): has skinny extents
>>>>>>>>> [ 6060.227084] BTRFS warning (device loop3): read-write for secto=
r
>>>>>>>>> size 4096 with page size 65536 is experimental
>>>>>>>>> [ 6060.234537] BTRFS info (device loop3): checking UUID tree
>>>>>>>>> [ 6061.375902] assertion failed: PagePrivate(page) &&=20
>>>>>>>>> page->private,
>>>>>>>>> in fs/btrfs/subpage.c:171
>>>>>>>>> [ 6061.378296] ------------[ cut here ]------------
>>>>>>>>> [ 6061.379422] kernel BUG at fs/btrfs/ctree.h:3403!
>>>>>>>>> cpu 0x5: Vector: 700 (Program Check) at [c0000000260d7490]
>>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 pc: c000000000a9370c: assertfail.=
constprop.11+0x34/0x48
>>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 lr: c000000000a93708: assertfail.=
constprop.11+0x30/0x48
>>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 sp: c0000000260d7730
>>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0 msr: 800000000282b033
>>>>>>>>> =C2=A0 =C2=A0=C2=A0 current =3D 0xc0000000260c0080
>>>>>>>>> =C2=A0 =C2=A0=C2=A0 paca=C2=A0=C2=A0=C2=A0 =3D 0xc00000003fff8a00=
=C2=A0=C2=A0 irqmask: 0x03  =20
>>>>>>>>> irq_happened: 0x01
>>>>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 pid=C2=A0=C2=A0 =3D 739712, comm =
=3D fio
>>>>>>>>> kernel BUG at fs/btrfs/ctree.h:3403!
>>>>>>>>> Linux version 5.12.0-rc7-02316-g3490dae50c0 (riteshh@xxxx) (gcc
>>>>>>>>> (Ubuntu 8.4.0-1ubuntu1~18.04) 8.4.0, GNU ld (GNU Binutils for=20
>>>>>>>>> Ubuntu)
>>>>>>>>> 2.30) #73 SMP Thu Apr 15 07:29:23 CDT 2021
>>>>>>>>> enter ? for help
>>>>>>>>> [c0000000260d7790] c000000000a90280
>>>>>>>>> btrfs_subpage_assert.isra.9+0x70/0x110
>>>>>>>>> [c0000000260d77b0] c000000000a91064
>>>>>>>>> btrfs_subpage_set_uptodate+0x54/0x110
>>>>>>>>> [c0000000260d7800] c0000000009c6d0c btrfs_dirty_pages+0x1bc/0x2c0
>>>>>>>>
>>>>>>>> This is very strange.
>>>>>>>> As in btrfs_dirty_pages(), the pages passed in are already=20
>>>>>>>> prepared by
>>>>>>>> prepare_pages(), which means all of them should have Private set.
>>>>>>>>
>>>>>>>> Can you reproduce the bug reliable?
>>>>>
>>>>> Yes. almost reliably on my PPC box.
>>>>>
>>>>>>>
>>>>>>> OK, I got it reproduced.
>>>>>>>
>>>>>>> It's not a reliable BUG_ON(), but can be reproduced.
>>>>>>> The test get skipped for all my boards as it requires fio tool,=20
>>>>>>> thus I
>>>>>>> didn't get it triggered for all previous runs.
>>>>>>>
>>>>>>> I'll take a look into the case.
>>>>>>
>>>>>> This exposed an interesting race window in btrfs_buffered_write():
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Writer=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fadvice
>>>>>> ----------------------------------+-------------------------------
>>>>>> btrfs_buffered_write()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |
>>>>>> |- prepare_pages()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>>>>>> |=C2=A0 |- Now all pages involved get=C2=A0 |
>>>>>> |=C2=A0=C2=A0=C2=A0=C2=A0 Private set=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>>>>>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | btrfs_release_page()
>>>>>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | |- Clear page Private
>>>>>> |- lock_extent()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>>>>>> |=C2=A0 |- This would prevent=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |
>>>>>> |=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_release_page() to=C2=A0=C2=A0=C2=A0=
=C2=A0 |
>>>>>> |=C2=A0=C2=A0=C2=A0=C2=A0 clear the page Private=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |
>>>>>> |
>>>>>> |- btrfs_dirty_page()
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 |- Will trigger the BUG_ON()
>>>>>
>>>>>
>>>>> Sorry about the silly query. But help me understand how is above=20
>>>>> racepossible?
>>>>> Won't prepare_pages() will lock all the pages first. The same=20
>>>>> requirement
>>>>> of locked page should be with btrfs_releasepage() too no?
>>>>
>>>> releasepage() call can easily got a page locked and release it.
>>>>
>>>> For call sites like btrfs_invalidatepage(), the page is already locked=
.
>>>>
>>>> btrfs_releasepage() will not to try to release the page if the=20
>>>> extent is
>>>> locked (any extent range inside the page has EXTENT_LOCK bit).
>>>>
>>>>>
>>>>> I see only two paths which could result into btrfs_releasepage()
>>>>> 1. one via try_to_release_pages -> releasepage()
>>>>
>>>> This is the race one, called from fadvice() to release pages.
>>>>
>>>>> 2. writeback path calling btrfs_writepage or btrfs_writepages
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0which may result into calling of btrfs_invali=
datepage()
>>>>
>>>> Not this one.
>>>>
>>>>>
>>>>> Although I am not sure which one this is racing with.
>>>>>
>>>>>>
>>>>>> This only happens for subpage, because subpage introduces new=20
>>>>>> ASSERT()
>>>>>> to do extra check.
>>>>>>
>>>>>> If we want to speak strictly, regular sector size should also report
>>>>>> this problem.
>>>>>> But regular sector size case doesn't really care about page=20
>>>>>> Private,as
>>>>>> it just set page->private to a constant value, unlike subpage case=20
>>>>>> which
>>>>>> stores important value.
>>>>>>
>>>>>> The fix will just re-set page Private and needed structures in
>>>>>> btrfs_dirty_page(), under extent locked so no btrfs_releasepage() is
>>>>>> able to release it anymore.
>>>>>
>>>>> With above fix I see a different issue with below signature.
>>>>>
>>>>> [=C2=A0 130.272410] BTRFS warning (device loop2): read-write for sect=
or=20
>>>>> size 4096 with page size 65536 is experimental
>>>>> [=C2=A0 130.387470] run fstests generic/095 at 2021-04-16 05:04:09
>>>>> [=C2=A0 132.042532] BTRFS: device fsid=20
>>>>> 642daee0-165a-4271-b6f3-728f215c5348 devid 1 transid 5 /dev/loop3=20
>>>>> scanned by mkfs.btrfs (5226)
>>>>> [=C2=A0 132.146892] BTRFS info (device loop3): disk space caching is=
=20
>>>>> enabled
>>>>> [=C2=A0 132.147831] BTRFS info (device loop3): has skinny extents
>>>>> [=C2=A0 132.148491] BTRFS warning (device loop3): read-write for sect=
or=20
>>>>> size 4096 with page size 65536 is experimental
>>>>> [=C2=A0 132.158228] BTRFS info (device loop3): checking UUID tree
>>>>> [=C2=A0 133.931695] BUG: spinlock bad magic on CPU#4, swapper/4/0
>>>>> [=C2=A0 133.932874] BUG: Unable to handle kernel data access on write=
 at=20
>>>>> 0x6b6b6b6b6b6b725b
>>>>
>>>> That looks like some poisoned memory.
>>>>
>>>> I have run 128 runs of generic/095 locally on my Arm board during=20
>>>> the fix,
>>>> unable to reproduce the crash anymore.
>>>>
>>>> And this call site is even harder to get race, as in endio context,=20
>>>> the page
>>>> still has PageWriteback until the last bio finished in the page.
>>>>
>>>> This means btrfs_releasepage() will not even try to release the=20
>>>> page, while
>>>> btrfs_invalidatepage() will wait the page to finish its writeback=20
>>>> before
>>>> doing anything.
>>>>
>>>> So this is very strange to me.
>>>>
>>>> Any reproducibility on your side? Or something specific to Power is=20
>>>> related
>>>> to this case? (IIRC some page flag operation is not atomic, maybe=20
>>>> thatis
>>>> related?)
>>>
>>> I doubt if this is Power related. And yes, I can reproduce the issue=20
>>> fairly
>>> easily. For now I will exclude the test from my run to get a overall=20
>>> run with
>>
>> Here, are some other failures that I noticed during testing on Power.
>> Thanks for looking into this.
>=20
> Thank you very much for the extra test!
>=20
>>
>> 1. tests/btrfs/052
>> btrfs/052=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [failed, exit status 1]- o=
utput mismatch (see=20
>> /home/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/052.out.bad)
>> =C2=A0=C2=A0=C2=A0=C2=A0 --- tests/btrfs/052.out=C2=A0=C2=A0=C2=A0=C2=A0=
 2020-08-04 09:59:08.328299552 +0000
>> =C2=A0=C2=A0=C2=A0=C2=A0 +++=20
>> /home/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/052.out.bad=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 2021-04-16=20
>> 17:18:17.762928432 +0000
>> =C2=A0=C2=A0=C2=A0=C2=A0 @@ -91,553 +91,5 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 23 05 05 05 05 05 05 05 05 05 05 05 05 05=
 05 05 05
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 30
>> =C2=A0=C2=A0=C2=A0=C2=A0 -0 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=
 ff
>> =C2=A0=C2=A0=C2=A0=C2=A0 -*
>> =C2=A0=C2=A0=C2=A0=C2=A0 -2 02 02 02 02 02 02 02 02 02 02 02 02 02 02 02=
 02
>> =C2=A0=C2=A0=C2=A0=C2=A0 -*
>> =C2=A0=C2=A0=C2=A0=C2=A0 ...
>> =C2=A0=C2=A0=C2=A0=C2=A0 (Run 'diff -u /home/qemu/work-tools/xfstests/te=
sts/btrfs/052.out=20
>> /home/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/052.out.bad' =20
>> to see the entire diff)
>>
>> ^^^ this could also be due to below error found in 052.full
>> =C2=A0=C2=A0=C2=A0=C2=A0ERROR: defrag range ioctl not supported in this =
kernel version,=20
>> 2.6.33 and newer is required
>> =C2=A0=C2=A0=C2=A0=C2=A0total 1 failures
>> =C2=A0=C2=A0=C2=A0=C2=A0failed: '/usr/local/bin/btrfs filesystem defragm=
ent=20
>> /mnt1/scratch/foo'
>>
>> 2. tests/btrfs/076 =3D> looks a genuine failure.
>> btrfs/076=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - output mismatch (see=20
>> /home/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/076.out.bad)
>> =C2=A0=C2=A0=C2=A0=C2=A0 --- tests/btrfs/076.out=C2=A0=C2=A0=C2=A0=C2=A0=
 2020-08-04 09:59:08.338299786 +0000
>> =C2=A0=C2=A0=C2=A0=C2=A0 +++=20
>> /home/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/076.out.bad=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 2021-04-16=20
>> 17:19:33.344981383 +0000
>> =C2=A0=C2=A0=C2=A0=C2=A0 @@ -1,3 +1,3 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QA output created by 076
>> =C2=A0=C2=A0=C2=A0=C2=A0 -80
>> =C2=A0=C2=A0=C2=A0=C2=A0 -80
>> =C2=A0=C2=A0=C2=A0=C2=A0 +1
>> =C2=A0=C2=A0=C2=A0=C2=A0 +1
>> =C2=A0=C2=A0=C2=A0=C2=A0 ...
>> =C2=A0=C2=A0=C2=A0=C2=A0 (Run 'diff -u /home/qemu/work-tools/xfstests/te=
sts/btrfs/076.out=20
>> /home/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/076.out.bad' =20
>> to see the entire diff)
>=20
> This is really a compression related one. Since I hardcoded to disable
> compression, the ratio is always be 1.
>=20
>>
>> 3. tests/btrfs/106=C2=A0 =3D> looks a genuine failure.
>> btrfs/106=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - output mismatch (see=20
>> /home/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/106.out.bad)
>> =C2=A0=C2=A0=C2=A0=C2=A0 --- tests/btrfs/106.out=C2=A0=C2=A0=C2=A0=C2=A0=
 2020-08-04 09:59:08.348300020 +0000
>> =C2=A0=C2=A0=C2=A0=C2=A0 +++=20
>> /home/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/106.out.bad=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 2021-04-16=20
>> 17:49:27.296128823 +0000
>> =C2=A0=C2=A0=C2=A0=C2=A0 @@ -5,19 +5,19 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 File contents before unmount:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 aa aa aa aa aa aa aa aa aa aa aa aa aa =
aa aa aa
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> =C2=A0=C2=A0=C2=A0=C2=A0 -40
>> =C2=A0=C2=A0=C2=A0=C2=A0 +1000
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 File contents after remount:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 aa aa aa aa aa aa aa aa aa aa aa aa aa =
aa aa aa
>> =C2=A0=C2=A0=C2=A0=C2=A0 ...
>> =C2=A0=C2=A0=C2=A0=C2=A0 (Run 'diff -u /home/qemu/work-tools/xfstests/te=
sts/btrfs/106.out=20
>> /home/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/106.out.bad' =20
>> to see the entire diff)
>=20
> That's a similar problem, compression needed
> while compression is hard coded to be disable, thus clone reports
> different value.
>=20
>>
>>> these patches. Later will try and debug what is going on.
>>>
>>> But if you need any debug logs - do let me know, as it is fairly easily
>>> reproducible.
>>
>> For tests/generic/095 can you pls retry reproducing the issue (with=20
>> yourlatest
>> patch) on your setup with below configs enabled?
>> 1. CONFIG_PAGE_OWNER, CONFIG_PAGE_POISONING, CONFIG_SLUB_DEBUG_ON,
>> =C2=A0=C2=A0=C2=A0 CONFIG_SCHED_STACK_END_CHECK, CONFIG_DEBUG_VM,=20
>> CONFIG_DEBUG_STACKOVERFLOW,
>> =C2=A0=C2=A0=C2=A0 CONFIG_DEBUG_VM_PGFLAGS, CONFIG_DEBUG_SPINLOCK, CONFI=
G_PROVE_LOCKING
>=20
> Thanks, I'll retry using the extra debugging options.
>=20
> But I have a more solid explanation on why the bug happens now.
>=20
> You're right, prepare_pages() should have the page locked by calling
> find_or_create_page(), so btrfs_releasepage() shouldn't sneak in and
> just release the page.
>=20
> But there is a small window in prepare_uptodate_page(), where we may
> call btrfs_readpage(), which will unlock the page.
>=20
> So there is a window where we have page unlocked, before we re-lock it
> in prepare_uptodate_page().
>=20
> By that, we got a page with its Private bit cleared.
>=20
> I'm trying a better fix like the following diff.
> But I'm not yet 100% confident if the PagePrivate() check is enough,
> thus I'll do more test before sending the proper fix.
>=20
> Thanks,
> Qu
>=20
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 45ec3f5ef839..49f78d643392 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1341,7 +1341,17 @@ static int prepare_uptodate_page(struct inode=20
> *inode,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unlock_page(pa=
ge);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 }
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (page->mapping !=3D inode->i_mapping) {
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 * Since btrfs_readpage() will get the page unlocked, we
> have
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 * a window where fadvice() can try to release the page.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 * Here we check both inode mapping and PagePrivate() to
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 * make sure the page is not released.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 *
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 * The priavte flag check is essential for subpage as we
> need
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 * to store extra bitmap using page->private.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (page->mapping !=3D inode->i_mapping ||
> PagePrivate(page)) {
   ^ Obviously it should be !PagePrivate(page).

Thanks,
Qu

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unlock_page(pa=
ge);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EAGAIN=
;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 }
>=20
>=20
>>
>>
>> -ritesh
>>

