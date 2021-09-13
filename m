Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6A5408613
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Sep 2021 10:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237849AbhIMIG4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 04:06:56 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:25255 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237797AbhIMIGz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 04:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631520339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdS/mtWKojkVu2aQA8kdnZtUCZeA/qqcFT37m1Ou6qM=;
        b=MIJto+MXZB6eOu/Qg7Ensc0dyRg8z4M6GLTcGqYIDC11/w1crtBKmG84arS8ioza6JnyQY
        JFjFmYawh44PfA4iuizSIsbctRDDtsP4UfBju6TJ91KbSI9ZEU39w5rqOpxYEQ37mWJNp9
        oSPRdZCAPSMRZToR1XvED2hcBqbMSNs=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-20-L03Q_pXXNDOPA6ho-Sb7Cw-1; Mon, 13 Sep 2021 10:05:38 +0200
X-MC-Unique: L03Q_pXXNDOPA6ho-Sb7Cw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPUs/TqMlwcZOi8N9d5GlIXU3NRTr0hcGVC8YJw9I0aIxzPs4Jy4N40FmHO6VqxSxEYv980di0AADxR2RKLh7mXkqRIhE8q7bgeAeQ8p4KucettH0quZvIcGxRyQVBvdteNHixsV1nadJPa+hxlB/Avy4p562qWhaA7KV1uExec6YeQNGIHvakv9PuDNqEIqamYV36ckQpt14j73isky0jgqfWfddiNZ52DOcJLgX5a2tWxlhhOziV0NMUB1+C4/TLKvfw8+PRolJc6NbdkZbo4WoaPRTWgefwsm80lIBvBbKVRe42tRE5TRHfkj5+5uzhntZuZn2xy7CvMPsZ5v3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=spjl96AMoMCnf/2WeIEzneR3jOn7hhekDYKlABrcv1k=;
 b=TrvNxqzg8dFru2pcI8W5DV+d5MPDhhmxFkF3ZFm65siy2OAe3jQdcv45sVVPzpfoaJ7RJ/bhQ5a52whSZE549XVAkkVtnanN7g77Yxr8Wamww+8m7iSUd9JvIZ4pgJPBWielfVy9jR6KbtZO48W47fi98LpQ6fRzsvNgIb6ET5oLJy4KiMbmRQ4bGaK5SxPR7KRe/RYk4YU997JOok3qdB0cUGvizXaGP8zWZKpb+wssJlA/LYSZMMT99RIuum1rB7cxzOkCboDqNO5nNQkXHVUf9SBGVfZGaM/lhz6BrI1STkqnlXW8Cp/di4HzyAiXCENXaiOm033OfpVHYhNGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR0402MB3784.eurprd04.prod.outlook.com (2603:10a6:209:23::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 08:05:36 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%5]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 08:05:36 +0000
To:     =?UTF-8?Q?Niccol=c3=b2_Belli?= <darkbasic@linuxsystems.it>
CC:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <0303d1f618b815714fe62a6eb90f55ca@linuxsystems.it>
 <22ac9237-68dd-5bc3-71e1-6a4a32427852@gmx.com>
 <02f428314a995fa1deea171af9685b9a@linuxsystems.it>
 <5a1cc167-0b9d-8a89-11e4-cfe388bd2659@suse.com>
 <75440780864f97ea54d12ff95a395864@linuxsystems.it>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: Unmountable / uncheckable Fedora 34 btrfs: failed to read block
 groups: -5 open_ctree failed
Message-ID: <98a6a966-cee7-cddd-3c53-fa2e209ed180@suse.com>
Date:   Mon, 13 Sep 2021 16:05:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <75440780864f97ea54d12ff95a395864@linuxsystems.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::27) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR03CA0014.namprd03.prod.outlook.com (2603:10b6:a02:a8::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 08:05:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b741859a-7f13-42af-598f-08d9768d44b0
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3784:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3784326C504EA3EFE2640C03D6D99@AM6PR0402MB3784.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Anb0LyXRM4TNm/CESJpKc5M8HGY7wW7X/n/qGhP/tmhh9grAPeXvl89+NdRMMXoOXMPzbfCRqgH1TV9svqCDKA7WFh+a2kQ1BDRoqBw3tMdf0pN6WXhX9FysLBhm/+ojgVyMWfzXNEGKeJCUwWFz/TCZRJW5mLGUOeyn4ClXT2m5tcnVwL9NhzQJ/ZPdy4LYltlCkBt14sNAec/U0CZgnZ2i4/7TjxYuEu0t0S91NVfMbWeyHZB+W7W+meCnf9Pz33HF1SmHVepUj7SEg3t/PrU+ky4gz4rhSb8Pmmg7OSh78jecofVcwHXvziJqpeFWixEeLt7EpYClD4fZ6iFngPojNCttWUsdFKVMhf6cwyky3oEP7W3fTaLdJVbayX8w7e/kxq9YnRTd71S0ZabLb6wXY7sCsM8/ZAvkUsGHTwaiK88hC6wbfiaCL+J+l3b0RLXeqQlPmU/8ogOPkmlnUzaDpD7o3RWhGih0MzQ6zw12wCBTKZ7WkqgHhokZCyh3nLUSiyPMPDCqcTSUNhlQvml1Iy+5OPrYx02W6pxTM4lbE2t0fd5ly4hJhUMAhz4SMgmyTgfJW6vdIfDevEfAGZksHGCLq3Ngbkq9mQgYUOv10PtWh+p53x5WbPg+2LMbT/jQ0NoHwmh7aqlI6vLMNKAE1n5iwmbVgycmJbANdISF52XqJIZ5CFMzpiMoGdJ5p1Ct2Nb1Rvd4iebPXHHNJkw6unqK9JvrWKc1Gc096ODSbPqrx/ZBsU1AoxHQfDp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(396003)(346002)(366004)(6486002)(6706004)(4326008)(83380400001)(956004)(2616005)(8936002)(66556008)(66476007)(66946007)(478600001)(316002)(6666004)(5660300002)(2906002)(31686004)(36756003)(38100700002)(6916009)(86362001)(8676002)(16576012)(26005)(31696002)(186003)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JAT0o6siIlBmJwTE9JoZ6dUbbUiv2xZ8emO3DUpgqiFqHeUP7kR/1+rP/sGu?=
 =?us-ascii?Q?onWEzIbtade6rlYVe2r/v/RHJRIh4VursZtKzIvXvAhONXZ4Mwl11zgsTzdZ?=
 =?us-ascii?Q?EPjNlcwdAt3hwD0WDnde3vor0tacwj6wrPLWyR7woj+/l5DlmjwEiaZyyQhp?=
 =?us-ascii?Q?4E5smCCXI6xOTVaOyPXIgxk52RCkx7vrI/pX7rKGYl4CLZSuyQoYMUMxjIZa?=
 =?us-ascii?Q?yIqEGSi2Y4V/bN+b+J0W83PjXxd9Co26Lizm5js/9PLXlvjHD6fsjx5qLHww?=
 =?us-ascii?Q?GUIZa5PXu08iFDWjVLmfRmNMoU6IUs9K7rTHQG5+smvAtCRTYN8O+VJC27kW?=
 =?us-ascii?Q?Ystv2FO59MYOKaMZrfaI/LyH9hSzC91t7SmbrAhlsjHj01vPjLu+odOpmP7q?=
 =?us-ascii?Q?XVNjaHoBJZktc/E0g3GMEf5ih6riDT1kOhXhq0M3caAfQjj1WgGr+EUVmGpz?=
 =?us-ascii?Q?ofjAuwHPiKTj7c3f07hc1rxtopcJebHg389PyUfKPRJT0KZyycwwpY0ioThV?=
 =?us-ascii?Q?9mrDZaA1NMj0rYOv2Z0GTpyM43jnetE3olheITWviY40XphjahwWYe+NU8Uf?=
 =?us-ascii?Q?4mNcyxP6KUAYHhrCe/3axkvv2so7hvoBTRBgAYHlGBe73Pe7JePP6gL7Qdne?=
 =?us-ascii?Q?iiZD64/hmORC03290Zi4q9476k7efYOrjVYxxKa8v2h+nMOEcGgHZYbD+G91?=
 =?us-ascii?Q?m4UQO7IAcoT+WY5l1pzK6zUFNqazdNCVQhyWzyOACZiYApL0E09G/8gkJQ6v?=
 =?us-ascii?Q?dl3lyq/BEEicU/D2ieAl1ThR0pZgyFlx1qQQdc46aiI430q3CCWs0ocOHnhM?=
 =?us-ascii?Q?e2w+3sFnuKlzedoSDsj6Q3fvX7BcHkGrUp1ZbC40HZLRhON28uTE+CKcXjPn?=
 =?us-ascii?Q?CTAdqHGiKOwe6dMTMMqKZOmgKTArWV/Xt3FOi3l81IVlouaPZlOzujbygFR9?=
 =?us-ascii?Q?mC8BJx+dAcYOWssGdFvkfW4mVAAvgAG+Ic0dIWfoPUtPOUyhC1M0pynOJkz9?=
 =?us-ascii?Q?ns6K0vXeZ6ZyzBbbaesq3OYvGUyBR44CrmFIW6vbdrOyWfkfRxtQZkvbwl7d?=
 =?us-ascii?Q?b3HFVeX7bqvE3Q39xODXhHk7xJWk+2xoIHonI0Zb2Qsfc1KUnUwQPnOaeV4E?=
 =?us-ascii?Q?Qm91FmBnTrTA0WZAZ1gxhltSvdIrb67gFsgebiHzbJ9xtBVGObsq9RGQm3j9?=
 =?us-ascii?Q?dD3TNxWT0x3Gt5QxZYu9Ouo5l/n7qKW/WYw7gnLjTzjTCMzXPVDjaERLRRSR?=
 =?us-ascii?Q?UNqWm4A8QHuvxlmJBTb33dxdb88SZP2JcPBDUVPcrOYrss6jovHZhpzBB4eD?=
 =?us-ascii?Q?Tp0euqlpMt4tNYrxtNzB8mS9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b741859a-7f13-42af-598f-08d9768d44b0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 08:05:36.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D58BzCD8cul+0I5pYK34P6OBgS14L75wOqfpJ5xSsYLGg2FBXYCv/d3pVsxouyBa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3784
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/13 =E4=B8=8B=E5=8D=883:16, Niccol=C3=B2 Belli wrote:
> Il 2021-09-12 19:55 Qu Wenruo ha scritto:
>> During the backup, have you checked the dmesg?
>=20
> Yes, the only error was the "No space left" I mentioned in the previous=20
> message.
>=20

Then it means no csum error.

But didn't you hit -EIO errors?

 > $ sudo cp -a avd var=20
/run/media/niko/3ea0705c-21c9-4ba9-80ee-5a511cb2a093/nvme0n1p6/
 > cp: avd/Pixel_4_API_30.avd/userdata-qemu.img.qcow2: recupero delle=20
informazioni degli extent non riuscito: Errore di input/output

And

 > $ sudo cp -a snapshots/home/375/snapshot=20
/run/media/niko/3ea0705c-21c9-4ba9-80ee-5a511cb2a093/nvme0n1p6/home
cp:=20
snapshots/home/375/snapshot/niko/devel/beach/client/android/.gradle/checksu=
ms/sha1-checksums.bin:=20
recupero delle informazioni degli extent non riuscito: Errore di=20
input/output

For those errors, not even a single dmesg error?


Anyway, if you have most data recovered and have dd copy at hand, then=20
you may want to try fully recovery the fs to RW state, by some=20
aggressive method:

# btrfs check --init-extent-tree --repair <dev>

This command will try to rebuild the extent tree completely, it uses=20
existing trees to rebuild, thus requires the fs has nothing else but=20
only extent tree corrupted.

This is *dangerous*, so the final call is still on you.
But if you really hit no other error messages during the full fs=20
recovery, then it looks like only extent tree is corrupted, and may=20
worthy a try.

BTW, since you're already using rescue=3Dnologreplay, you may want to zero=
=20
the log before rebuilding the extent tree.

Thanks,
Qu

