Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247332E70AE
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Dec 2020 13:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgL2Mms (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Dec 2020 07:42:48 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:36614 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725964AbgL2Mms (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Dec 2020 07:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1609245700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJa8NSop9PQOvtu4sgnab9K7tXBclRzoyCA7Fxc7oMI=;
        b=APRO34GJq4nMloBRbNaGOUblSU0MuRanI1EK66J5xmIDT2csFWmV+mUN1u8hQxBkkNMsnO
        TfBerPz6lqdK3uzYLbHENIi6LtMpeetpJ0hbG91N1k3+4sPMGPKl6jGPKacxNUvqZUVz07
        q9Y/La6A/WafREO1TSgXYcVuq9p9+P4=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2111.outbound.protection.outlook.com [104.47.18.111])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-18-AWsynYZeOYaef1RhZKRFJA-1; Tue, 29 Dec 2020 13:41:38 +0100
X-MC-Unique: AWsynYZeOYaef1RhZKRFJA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZI/GU2QPGZQlixwtqxGrZeeuEnmo0Ps1i/VlR/BXpIrOwNA14H1eQv1dtQqilrBZI3H2FTVG1ioAYyrVYNLD4cR4dtsQhcbziCJ5PJoqkR9D2xfsv1nhoub3etrKI8MPPFTT9pBsDbn9CYu4AtY46GxjngtMOhxedxxiOD2yXRljYMOrq+W1wrh4s7GMV//19KB+1YlQ+Ny8FejRnuwb0CQoUSYr0Y6tR8nYhz0iGTdPlY/rLfd23gcaGegqYoGcx9mxmjWxjd04DEuHz9Bb0fbx0hXF8Ox8QHPUfg6W/Ef38jr3MYMoMfKKcLUL4TbQ8NX2V+6yJvOolSSNVkduqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85ItITi1wl7vWZ7E/6yvZxh4s/CjX4kvBKludhfvGII=;
 b=GTsiX1XaH220qfbld670fZpF+K31u4aW57gEmqyRIV+c0muhsV00+nyHxHZTFIsWzzdsbba/vto5O47eUHJbCFQBqs4fKV9aQiZT++2ZIM11jyRaQx4fxySsIvRlGf3o1hR3w559+J1Ecd3Y2gWGZd94sOSjilgh/4bjolRlL95VvfNzYryDkVR43yowtMJBxc8jrJN3D/t8Qyxi/vfGzKSjEk92nIzt1VzQMckz3bepFOPZjK5F4Oh1VA0AC/XcbSEIW1RSAQDblg2eTtVGn1MSTN5p77LO37D20oQm/OVfyx1KQrpaHvzHOzaUN79lWGKwOYmcwCJvpjrv0apoCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PA4PR04MB8048.eurprd04.prod.outlook.com (2603:10a6:102:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Tue, 29 Dec
 2020 12:41:37 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::397a:950:d8c8:d709]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::397a:950:d8c8:d709%6]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 12:41:37 +0000
Subject: Re: [PATCH] btrfs: relocation: output warning message for leftover v1
 space cache before aborting current data balance
To:     =?UTF-8?Q?St=c3=a9phane_Lesimple?= <stephane_btrfs2@lesimple.fr>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <82e6288d-7b37-5797-13d9-f786afb33f5d@gmx.com>
 <90cf0737-6d33-94d8-9607-0f9c371c82aa@gmx.com>
 <20201229003837.16074-1-wqu@suse.com>
 <6b4afae37ba5979f25bddabd876a7dc5@lesimple.fr>
 <4f838a67672053e268ffce77ea800a8a@lesimple.fr>
 <e811efd8b2936a559d665e7303ce0873@lesimple.fr>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <43269375-cefd-8059-5335-ed891fdd26fe@suse.com>
Date:   Tue, 29 Dec 2020 20:41:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <e811efd8b2936a559d665e7303ce0873@lesimple.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::22) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0047.namprd03.prod.outlook.com (2603:10b6:a03:33e::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19 via Frontend Transport; Tue, 29 Dec 2020 12:41:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca207d96-f5c5-4174-cb1d-08d8abf71531
X-MS-TrafficTypeDiagnostic: PA4PR04MB8048:
X-Microsoft-Antispam-PRVS: <PA4PR04MB804856AA9CA53BC47D03E184D6D80@PA4PR04MB8048.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GSS+rRI8UvuKnHp39GrajF0V4DCThOhrDz3i1KHmWvIPewPg5jzKj3lzSVy9/KQDXAUSs4VUCj3X1lDX2Y8qUFZJexX9flhDA9MProJdgModf2pbQkz7w7nabonGLwFtLGYmjLT/5Ddu529hE/l77mvNHgQ8NIoeNhq101YXhy9/3dh+OBDFaK+O1H81v5NakPwUDayrm8xRSkXl3S7pLGbZKdyqbios+2RY/A71e28TrWDTATlIhclBBYJ6d9Lz831ZlbfgzkseJ/rPmnOjm5PiM1bTtXOHDITdGVTRT3cRGCdhWnchu9YdpFwb+DYDk8QV4Nol4nIbsE7lwFphtXV3L6EtGoyRkyfEHP3j3cbK8WHq/0NDHj9AcxMiUoLyUJikG4au5QLEXpgR9wTkGnVpuC0RVtUfvvrf2P25Egm2AX2mKJHt2yZgUcSOWI1AEHnx7yY/6OCcHqN42kRWncmWN+6LYrjFYHqGHhA+J9QW11JAmgWLDUDLUI9KDfiJEARp9C+j+gm9VwXVoz3Uzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(39850400004)(366004)(376002)(16576012)(66556008)(6706004)(956004)(66476007)(86362001)(5660300002)(2616005)(6486002)(52116002)(2906002)(316002)(36756003)(66574015)(186003)(31696002)(83380400001)(16526019)(31686004)(8676002)(478600001)(66946007)(26005)(6666004)(110136005)(8936002)(518174003)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hSS+ovaKpHbPp0Bx31a5Mci3vDMhhPdB4HrPHT/5faLC7mquJhI3Uzc2catW?=
 =?us-ascii?Q?WHzWZcMlRsLpDkFb3Kp8uPqJJevvFiIK5PVIAfkMTtlT8RA3ZuS9Gs/v7LxW?=
 =?us-ascii?Q?jE0rJZgIdyIFPER/jgc+/mOIqDZOqvieK1zMjJ4G/5r/LPJH1HZXU8TkFcI4?=
 =?us-ascii?Q?+k3H/LoQEcSxvqKUJ1BYTa0VVlRakdjwrct9oijUoIQZYjF6EjN2DvT67vZc?=
 =?us-ascii?Q?cyKuIzq82B9JVCuLHTMwelYoch35BfRmE2yuDXOxsFq9E1NhlV/r0vgtgvlj?=
 =?us-ascii?Q?UCwbr8cpR1iCcyP71QUbtTEfEQEj9v1kkXCrP/WYBVOkbkskCFs+C27pv/IR?=
 =?us-ascii?Q?jsGn1o8qq8fIdO+84yKmy71PRwdh3FBDA2cW/svIZxKXn46iI/HTRxRsUoxg?=
 =?us-ascii?Q?5TB0RNLn2V9crDX/qnzmHKbIWWblhIk12oqgVzp1k0IP2+G8KgcRBZxEzUXi?=
 =?us-ascii?Q?SW2kzHIY5bA/8Foxkzk5C6faUu0IquC3DZSTb3cGlp1curyb+NEmdU/8lCR8?=
 =?us-ascii?Q?ZyayvLvth5V1gZ7BN+Yq8FQmGcNES714dF7PIOUMJ1sjtki+OMvElUywL+iu?=
 =?us-ascii?Q?u7Z+Tq7t0hXBrO8BMeZoQh9uXT9JrN98XJID11eUgmliE9tbzIpbpioo8RRJ?=
 =?us-ascii?Q?QpVgPUWAVkVzm+gYFy+U9OOIICz9DwalodZjabdNuzjrr2/sqEp3D9WlxmCD?=
 =?us-ascii?Q?r5PDccRN6jz8o7+Kl6B1Osl+yItEVKi5A8KSNPak1uVTTb/ZfSS24qEXCHuU?=
 =?us-ascii?Q?EnKjWu1KIud63MaOZlQijeoa+bP9whHK9xWwH/0lVbNhn0SEz+tVSKqjcPWQ?=
 =?us-ascii?Q?qznM4kEpeGn7iyUFKWnOnz3iBKAbsI+xae4zpTGP2yrSbdcgQNsVBo6OOhqN?=
 =?us-ascii?Q?lLAGjtCs1CS/3ttaerAXsgN/P69xgI6nKcUs8Cs5jSqQ4fJEXT4XetPJ+EZG?=
 =?us-ascii?Q?NbkO+NkpmvxSv5SX91Jb/EslJpo0rirr1qnSimdGSQVU59EVdwKYjzRIq+7R?=
 =?us-ascii?Q?uadV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2020 12:41:37.2965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: ca207d96-f5c5-4174-cb1d-08d8abf71531
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1h2h9yUekRptczNFTLqL8SaTZSkqZaC+c7R+7dy/xFiAKWJMP2cssat/Xr57B0D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8048
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/29 =E4=B8=8B=E5=8D=888:30, St=C3=A9phane Lesimple wrote:
> December 29, 2020 12:32 PM, "Qu Wenruo" <quwenruo.btrfs@gmx.com> wrote:
>=20
>> On 2020/12/29 =E4=B8=8B=E5=8D=887:08, St=C3=A9phane Lesimple wrote:
>>
>>> December 29, 2020 11:31 AM, "Qu Wenruo" <quwenruo.btrfs@gmx.com> wrote:
>>>
>>> # btrfs ins dump-tree -t root /dev/mapper/luks-tank-mdata | grep EXTENT=
_DA
>>> item 27 key (51933 EXTENT_DATA 0) itemoff 9854 itemsize 53
>>> item 12 key (72271 EXTENT_DATA 0) itemoff 14310 itemsize 53
>>> item 25 key (74907 EXTENT_DATA 0) itemoff 12230 itemsize 53
>>>> Mind to dump all those related inodes?
>>>>
>>>> E.g:
>>>>
>>>> $ btrfs ins dump-tree -t root <dev> | gerp 51933 -C 10
>>>
>>> Sure. I added -w to avoid grepping big numbers just containing the digi=
ts 51933:
>>>
>>> # btrfs ins dump-tree -t root /dev/mapper/luks-tank-mdata | grep 51933 =
-C 10 -w
>>> generation 2614632 root_dirid 256 bytenr 42705449811968 level 2 refs 1
>>> lastsnap 2614456 byte_limit 0 bytes_used 101154816 flags 0x1(RDONLY)
>>> uuid 1100ff6c-45fa-824d-ad93-869c94a87c7b
>>> parent_uuid 8bb8a884-ea4f-d743-8b0c-b6fdecbc397c
>>> ctransid 1337630 otransid 1249372 stransid 0 rtransid 0
>>> ctime 1554266422.693480985 (2019-04-03 06:40:22)
>>> otime 1547877605.465117667 (2019-01-19 07:00:05)
>>> drop key (0 UNKNOWN.0 0) level 0
>>> item 25 key (51098 ROOT_BACKREF 5) itemoff 10067 itemsize 42
>>> root backref key dirid 534 sequence 22219 name 20190119_070006_hourly.7
>>> item 26 key (51933 INODE_ITEM 0) itemoff 9907 itemsize 160
>>> generation 0 transid 1517381 size 262144 nbytes 30553407488
>>> block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
>>> sequence 116552 flags 0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
>>> atime 0.0 (1970-01-01 01:00:00)
>>> ctime 1567904822.739884119 (2019-09-08 03:07:02)
>>> mtime 0.0 (1970-01-01 01:00:00)
>>> otime 0.0 (1970-01-01 01:00:00)
>>> item 27 key (51933 EXTENT_DATA 0) itemoff 9854 itemsize 53
>>> generation 1517381 type 2 (prealloc)
>>> prealloc data disk byte 34626327621632 nr 262144

Got the point now.

The type is preallocated, which means we haven't yet written space cache=20
into it.

But the code only checks the regular file extent (written, not=20
preallocated).

So the proper fix would looks like this:

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 19b7db8b2117..1d73d7c2fbd7 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2975,11 +2975,14 @@ static int delete_v1_space_cache(struct=20
extent_buffer *leaf,
                 return 0;

         for (i =3D 0; i < btrfs_header_nritems(leaf); i++) {
+               u8 type;
                 btrfs_item_key_to_cpu(leaf, &key, i);
                 if (key.type !=3D BTRFS_EXTENT_DATA_KEY)
                         continue;
                 ei =3D btrfs_item_ptr(leaf, i, struct=20
btrfs_file_extent_item);
-               if (btrfs_file_extent_type(leaf, ei) =3D=3D=20
BTRFS_FILE_EXTENT_REG &&
+               type =3D btrfs_file_extent_type(leaf, ei);
+               if ((type =3D=3D BTRFS_FILE_EXTENT_REG ||
+                    type =3D=3D BTRFS_FILE_EXTENT_PREALLOC) &&
                     btrfs_file_extent_disk_bytenr(leaf, ei) =3D=3D=20
data_bytenr) {
                         found =3D true;
                         space_cache_ino =3D key.objectid;

With this, the relocation should finish without problem.

Thanks for all your effort, from reporting to most of the debug, this=20
really helps a lot!
Qu

