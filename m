Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AFA3B1458
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 09:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhFWHG1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 03:06:27 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:52276 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229964AbhFWHG0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 03:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1624431847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eTMYTwYaVBtNYOYQR2c0KY7S1/zCp4dMBgQLkChlS3w=;
        b=fGnUWiR6LC6vYU3NXpikCaG4yvUo7iGBuHjD4kxxd6NWEVV1qLnmnrDvSQNtwPj/qCrKD6
        0DPCUq12MZcstwdOuPrpSp3QKH9TGtdg9ZKGALkh0eBqb06uNwlAnkww6g2vliH1+SqW7F
        t9PTfvpYc1GkfcwSCX1/Ez4nFuNJnh8=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-35-5U7wjuRYNhC4lt6MgJalTg-1; Wed, 23 Jun 2021 09:04:06 +0200
X-MC-Unique: 5U7wjuRYNhC4lt6MgJalTg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJuly8iW2Ye2otSZQXF3mn3Fvpq+S19W5kjJtGkYMZzXvuv8nZsQYAXJ8qUKfLQGAA5zw6mNuC88CGANFEzbqbt/H6tGPhpFOyMwvKjatRFuvIcOG7bKpaQO7+xSK55yR6wQPBH7fv4P+u3g9IbeuZc7DbGEtW/0dbpak7D84HSR+cBWC4m4Wiwpg7AULHbQgoODow5pR8Cfh89iDwq14a2vHszvcHBZh/vPH47UTufcsy6ciKCfahWo6Cx+Cu+fIfbuegU8c1Qh+Wfd+Ws1LVjPG+fcgaEE0hqMd5HyvTlWLoLz/bBbQZ3eNy+Qk8wzkJ1Nl87ioPtL5OR74hT5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EV/vF8sEoOEgLVgeJ/Dkz6WZVMDk2FeMYZQ/m1byUec=;
 b=FBsq/5btf3HAPX1TC7m4niZs8eseQuSsMCuSxj+/7crOCab5xUF0y0MchXQuxUFx87m2EpIUR2+EFIvjwqSTaSV4ZIGI2CP2u/iX7BFW/JXimBm9O3h7RbasUvQ2uR4VFePToGDiK+fGBlj+JqpddDRmTQgU60J11jtRP/b91lR9hRyDCDtP1aLqgUrnegPIPNHXKS+9JiudO/ZvhEQMROMaFf7OE77d9Vc2QzVpYfrdjVA2YkcwNW36x+sixihf0Trw9NBIbYz5XTsRYEC7dIpQENuDkYgzcGGoj+9ZUFZC/cWJjyxeCM9h9i1HUTuejMr5EIN/+75w/4ahTNZGDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM7PR04MB6775.eurprd04.prod.outlook.com (2603:10a6:20b:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 07:04:04 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10%7]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 07:04:04 +0000
To:     riteshh <riteshh@linux.ibm.com>
CC:     linux-btrfs@vger.kernel.org
References: <20210610050917.105458-1-wqu@suse.com>
 <20210623065636.l7uqokq7dcf6m5tc@riteshh-domain>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v4 00/10] btrfs: defrag: rework to support sector perfect
 defrag
Message-ID: <a213d8c4-da08-3b4b-6b35-9ede297e9038@suse.com>
Date:   Wed, 23 Jun 2021 15:03:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210623065636.l7uqokq7dcf6m5tc@riteshh-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::6) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0271.namprd03.prod.outlook.com (2603:10b6:a03:39e::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Wed, 23 Jun 2021 07:04:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e146b185-3eaf-4643-a50d-08d936151637
X-MS-TrafficTypeDiagnostic: AM7PR04MB6775:
X-Microsoft-Antispam-PRVS: <AM7PR04MB6775C3B46F903DDE974C15C4D6089@AM7PR04MB6775.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s+7UhuTgsgJ8ie7uGxAuQWI0TgffZ72Rzm0O59obkjA92976USeuTRblyS088l+xG794wF9PSaabE7eSoAwAyjRtkBeyjMDJBuBj6XKsNKBmft+tTfaJeMe+feJDnBAOhq2DgKlclo0ha8+6+Slch6tGrGckxNy2nRVKySsLvuRLVnPdV5xDfvIf35T8GnT1zb3K8xsg0/6a0S2Y6KWNeL2s00kzyPnKBLRa2ujIsVlBa+MRYwBGuMBNhWuXzkfR8jP2LNueH7XtdO8LZ2JQfuILj9Hwgl1tKQ/awql85pMmGqz3+alMyFf5UnDaZt8cBzmaO0eYqF9IQVKOkXSWHfGBeYVjAG83Qc0dxnQUsa0NjObXP4JML99+l/uOHzG5kesLJLGHfgo/fzGDFOruef6dLqbN2hGjXwTkzfJhe3r3p3yxn2wQOdzv1lyq1zp742mqeNmk5R/v68jDO97TdFwuPxwMClAXvjmPLw1sk7/wwENwYt2LKwXexzIWQcNkRd3hPHNdGgD9VYp+SjWprNv/TWjM8ro/zc65OyxsCxhRZMLvZK5meIkPDyrWZbJMce+RFE6U6OpTKfcf3duSzxZcGCwUW9PtMDtKV618LeW0weiWiotaBy2k4WyjaX3evbYOu5S0dZe73lJfcBe/8j99WBoQ/bpGCghS9lULmjjAEbo4XTXYNQvmQL0Tx0FlBIWXynK7XddnN+4J6ZR/CJlciCRazeBULrb4CLdSHzQrH1f1Jw/ig+1QIGiM/xHzD8r3GLouJd9jRIhoxn1WV8o+Qg8xCNtNz/TqZFhp8cJiI8xARvPrxi2L355XxPDV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(376002)(39850400004)(366004)(4326008)(31696002)(5660300002)(83380400001)(66556008)(45080400002)(31686004)(8676002)(6486002)(478600001)(966005)(66476007)(66946007)(6666004)(86362001)(8936002)(16576012)(16526019)(956004)(186003)(316002)(6706004)(2616005)(2906002)(38100700002)(6916009)(26005)(36756003)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HgY/il7D+XJBfegzEXFVC9C8V9OtxoBnyi27MHu2uU5R41VCevE4mYZ8/6hd?=
 =?us-ascii?Q?Hh6PMs4zcA6I8JDrmhsFp78hKOmBu0mnNtzQBbqyQBuD31zWbBZ+zo1VPOhi?=
 =?us-ascii?Q?Ee94luF/Yry4EdcP3DTAn6R5zVU2+hdXot2wB0XlMZ7JA86PNUhxXi9YJ1DD?=
 =?us-ascii?Q?iqxoMJUGvh7SInVAwhKtp/RK2J+ES0iIZfWtxJP+4Y5U9RhUVIwwTX+W2+Wk?=
 =?us-ascii?Q?Ho/XDwm52goVaNdliEhYpAKZh+sv3C2Vf/NTRUPPrQNL9GMMUXkDmiRuQBqG?=
 =?us-ascii?Q?URZhe1aPBWzYmC6BYyCFKDhEbpnvKI1D4kc9XhD5zNBt66n+ipTQT6C6TluN?=
 =?us-ascii?Q?009Y1jPNbyoZb2TsFIM1QpWyI3+5mfNLlJqiktD8WsX6v48LYbRWkINC4f0O?=
 =?us-ascii?Q?hAWfQB7tgKWFeJrdRinRKW1tjiF0EZJvAPiSIBpX+fr+uc6HKf/tI4Kv8TDb?=
 =?us-ascii?Q?advJZ6ZZzjkeyK/mgn/MlyJY83y0X5X6kq/OSHZYwwltBKrq2kkJWHgeA+3z?=
 =?us-ascii?Q?VRahtYKpENoyv7+jnPV6aJMvpLQq5ta0wgP8XNnvAVFJzEj3dDn/xk56DY1I?=
 =?us-ascii?Q?o0IT8pb9LEWTGNHRH9Q10LBYRttROzs64UPlg7RmhtACbnjVy+bgEmIDtkP1?=
 =?us-ascii?Q?ULFy2Iz0iMhEQLvnn/4hKGiDskJRHFOLL/Tzd2QahVuahxZAN5fx1bSCmeq2?=
 =?us-ascii?Q?IeCg8D32OoNQ9DNGUHXySAEZKu/Ee+IHMAnihA284RO+jSiATCooF8oSQ4Aa?=
 =?us-ascii?Q?iAIEpG4fQ4VgUF6I1MvzPm7ZX86d3qLmdc4xelt+LVLm9bLY+X20IA+Co8cO?=
 =?us-ascii?Q?TL+nvXsdu2SQduDMT7FbkjOkPk5KUv6TZwlH0AjphGNL/AxFWXe6LYBzw8/R?=
 =?us-ascii?Q?TP8FhRGUN1vJ4FntoVVPsUVHVsNc1TruHgBlJSMaQNM6iqVMfDuxLr1dIZF8?=
 =?us-ascii?Q?TlCT1LFMQF3zA2X7o7GbhRqI5Zf9RfAtd0blDmly8VPLzDOH6eEYB3go3ApG?=
 =?us-ascii?Q?OfkJCzsUYB/UahN51HGTVlClSXVdALJARDHd6nUulDplaMTByfgdvld/fKK0?=
 =?us-ascii?Q?quCEWpaLfiPBU3SMGxGeBYRPUgthEDa4i0x0WDc0Jn1O34C3BZT0NOz7bXiG?=
 =?us-ascii?Q?dFiWf+BTplviK6aOwi7tfuoQGLbH90eG4dsMfb6Gq3GGG8Z52rCq2fLqHHun?=
 =?us-ascii?Q?1tuj8CQhn//RnFGw3FBcIUNAUCyRkJXz46dUuXmMDgEci/SQFs/FuvUjL32U?=
 =?us-ascii?Q?6tdDuHqxZfAra4tY2AFa5RzUFL4MFXVBWhPcDxZTPwn/DBn7f9yrVTcYlxdd?=
 =?us-ascii?Q?frBtQuLKwoPMUMog8VC6q6Vt?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e146b185-3eaf-4643-a50d-08d936151637
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 07:04:04.8537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klRypPRY33z2OzM0lerGA/0YgJph1P/uR2fCRC+piAqEsMpDbuLXj4jsTwl9vOZb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6775
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/23 =E4=B8=8B=E5=8D=882:56, riteshh wrote:
> On 21/06/10 01:09PM, Qu Wenruo wrote:
[...]
>>
>> Thus I'm wondering if the check timing is even correct for the existing
>> code.
>> But at least I can't reproduce the nbytes problem on x86_64, thus no yet
>> sure what the real cause is.
>=20
> Hi Qu,
>=20
> Sorry for getting back late on this. I was using my test machines for oth=
er
> tests hence this got delayed.

No need to hurry, this branch is mostly in archive mode, no active=20
development working on that yet.

But still, thank you for the testing.

>=20
> I did test this whole patch series from your github https://github.com/ad=
am900710/linux/commits/defrag_refactor.
> I didn't find any crashes (as you also mentioned). But some tests did fai=
l e.g. btrfs/072.
>=20
> Is this(btrfs/072) what you are referring to in above (random test failue=
s with subpage
> sectorsize)?

Exactly the same thing.

>=20
> Please do let me know if you would like me to try any of the fstest in lo=
op for
> reproducing any error. Or if there is any other tests that you would like=
 me to
> run?
>=20
> 1. output from btrfs/072 test.
> 	_check_btrfs_filesystem: filesystem on /dev/vdc is inconsistent
> 	*** fsck.btrfs output ***
> 	[1/7] checking root items
> 	[2/7] checking extents
> 	[3/7] checking free space cache
> 	btrfs: csum mismatch on free space cache
> 	failed to load free space cache for block group 22020096
> 	btrfs: csum mismatch on free space cache
> 	failed to load free space cache for block group 1095761920
> 	btrfs: csum mismatch on free space cache
> 	failed to load free space cache for block group 1364197376
> 	[4/7] checking fs roots
> 	root 5 inode 323 errors 400, nbytes wrong

Yep, and I even know how to solve it if you really want.

The diff should solve it pretty well:

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index edf597ad515f..40d6a46e43f3 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1235,8 +1235,9 @@ static int defrag_one_locked_target(struct=20
btrfs_inode *inode,
         clear_extent_bit(&inode->io_tree, start, start + len - 1,
                          EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
                          EXTENT_DEFRAG, 0, 0, cached_state);
-       set_extent_defrag(&inode->io_tree, start, start + len - 1,
-                         cached_state);
+       ret =3D btrfs_set_extent_delalloc(inode, start, start + len - 1,
+                                       EXTENT_DEFRAG, cached_state);
+       ASSERT(!ret);

         /* Update the page status */
         for (i =3D start_index - first_index; i <=3D last_index - first_in=
dex;

But I don't know why the timing calling set_extent_defrag() is not safe=20
enough.


Currently the branch is not a high priority thing, thus feel free to=20
ignore the branch and above diff for now.


> 	ERROR: errors found in fs roots
> 	Opening filesystem to check...
> 	Checking filesystem on /dev/vdc
> 	UUID: b638db59-981c-4502-831e-038930e65cf4
> 	found 28282880 bytes used, error(s) found
> 	total csum bytes: 15196
> 	total tree bytes: 442368
> 	total fs tree bytes: 331776
> 	total extent tree bytes: 36864
> 	btree space waste bytes: 163191
> 	file data blocks allocated: 37101568
> 	 referenced 27430912
> 	*** end fsck.btrfs output
>=20
> 2. btrfs/124 (- I guess this we have seen in past w/o your changes too).
> 	[ 2565.969989] BTRFS info (device vdc): balance: start -d -m -s
> 	[ 2565.970727] BTRFS info (device vdc): relocating block group 151348838=
4 flags data
> 	[ 2570.693594] BTRFS error (device vdc): bad tree block start, want 3182=
1824 have 0
> 	[ 2570.725804] BTRFS info (device vdc): read error corrected: ino 0 off =
31821824 (dev /dev/vdi sector 21192)
> 	[ 2581.579592] BTRFS info (device vdc): found 5 extents, stage: move dat=
a extents
> 	[ 2581.818799] BTRFS info (device vdc): found 5 extents, stage: update d=
ata pointers
> 	[ 2582.086796] BTRFS info (device vdc): relocating block group 976617472=
 flags data
> 	[ 2598.759264] BTRFS info (device vdc): found 6 extents, stage: move dat=
a extents
> 	[ 2598.991059] BTRFS info (device vdc): found 6 extents, stage: update d=
ata pointers
> 	[ 2599.274253] BTRFS info (device vdc): relocating block group 943063040=
 flags system
> 	[ 2599.525191] BTRFS info (device vdc): relocating block group 674627584=
 flags metadata
> 	[ 2599.788734] BTRFS info (device vdc): relocating block group 298844160=
 flags data|raid1
> 	[ 2609.746593] BTRFS info (device vdc): found 4 extents, stage: move dat=
a extents
> 	[ 2609.989663] BTRFS info (device vdc): found 3 extents, stage: update d=
ata pointers
> 	[ 2610.234642] BTRFS info (device vdc): relocating block group 30408704 =
flags metadata|raid1
> 	[ 2610.234889] ------------[ cut here ]------------
> 	[ 2610.234970] BTRFS: Transaction aborted (error -28)

Yep, I can also see this on our Power8 VM, without my patches.

> 	[ 2610.235172] WARNING: CPU: 3 PID: 26186 at fs/btrfs/extent-tree.c:2163=
 btrfs_run_delayed_refs+0x108/0x330
> 	[ 2610.235364] Modules linked in:
> 	[ 2610.235426] CPU: 3 PID: 26186 Comm: btrfs Not tainted 5.13.0-rc2-0039=
3-gc0e4bc6f271f #43
> 	[ 2610.235547] NIP:  c0000000009f0bb8 LR: c0000000009f0bb4 CTR: c0000000=
00e5fb30
> 	[ 2610.235665] REGS: c000000078fb7320 TRAP: 0700   Not tainted  (5.13.0-=
rc2-00393-gc0e4bc6f271f)
> 	[ 2610.235802] MSR:  800000000282b033 &lt;SF,VEC,VSX,EE,FP,ME,IR,DR,RI,L=
E&gt;  CR: 48004222  XER: 20000000
> 	[ 2610.235961] CFAR: c0000000001cea40 IRQMASK: 0
> 	               GPR00: c0000000009f0bb4 c000000078fb75c0 c000000001c5dc00=
 0000000000000026
> 	               GPR04: 00000000fffff5ff c000000078fb7280 0000000000000027=
 c0000000ff507e98
> 	               GPR08: 0000000000000023 0000000000000000 c00000000c286580=
 c000000001a11050
> 	               GPR12: 0000000000004400 c00000003ffeae00 0000000000000002=
 c000000045e4e088
> 	               GPR16: c000000045e4e000 c000000001334eb0 c000000012654000=
 0000000001d00000
> 	               GPR20: c000000012654000 0000000000000e5c 0000000000000000=
 c000000001662dc8
> 	               GPR24: 0000000000000014 c000000009ec9800 c000000009ec9b48=
 c0000000410f6e08
> 	               GPR28: 0000000000000000 0000000000000001 c000000012654000=
 ffffffffffffffe4
> 	[ 2610.237012] NIP [c0000000009f0bb8] btrfs_run_delayed_refs+0x108/0x330
> 	[ 2610.237111] LR [c0000000009f0bb4] btrfs_run_delayed_refs+0x104/0x330
> 	[ 2610.237213] Call Trace:
> 	[ 2610.237254] [c000000078fb75c0] [c0000000009f0bb4] btrfs_run_delayed_r=
efs+0x104/0x330 (unreliable)
> 	[ 2610.237404] [c000000078fb7680] [c000000000a0c4e4] btrfs_commit_transa=
ction+0xf4/0x1330
> 	[ 2610.237533] [c000000078fb7770] [c000000000a96e74] prepare_to_relocate=
+0x104/0x140
> 	[ 2610.237657] [c000000078fb77a0] [c000000000a9d524] relocate_block_grou=
p+0x74/0x5f0
> 	[ 2610.237770] [c000000078fb7860] [c000000000a9dcd0] btrfs_relocate_bloc=
k_group+0x230/0x4a0
> 	[ 2610.237886] [c000000078fb7920] [c000000000a56a60] btrfs_relocate_chun=
k+0x80/0x1c0
> 	[ 2610.238002] [c000000078fb79a0] [c000000000a57d3c] btrfs_balance+0x103=
c/0x1560
> 	[ 2610.238117] [c000000078fb7b30] [c000000000a6ab98] btrfs_ioctl_balance=
+0x2d8/0x450
> 	[ 2610.238232] [c000000078fb7b90] [c000000000a6eb90] btrfs_ioctl+0x1df0/=
0x3be0
> 	[ 2610.238328] [c000000078fb7d10] [c00000000058e048] sys_ioctl+0xa8/0x12=
0
> 	[ 2610.238435] [c000000078fb7d60] [c000000000036524] system_call_excepti=
on+0x3d4/0x410
> 	[ 2610.238551] [c000000078fb7e10] [c00000000000d45c] system_call_common+=
0xec/0x278
> 	[ 2610.238666] --- interrupt: c00 at 0x7ffff7be2990
>=20
> 3. There were other failues, but I guess those were either due to mount f=
ailure
>     or since no compression support yet for subpage blocksize.

Yep, RAID56 mount/convert failures, and compression related output mismatch=
.

Thanks,
Qu
>=20
> -ritesh
>=20

