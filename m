Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1ACB3AFA26
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 02:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhFVA20 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Jun 2021 20:28:26 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:55645 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229640AbhFVA2Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Jun 2021 20:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1624321569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7X/z9ymioBpmgIc8rjXoA8M+fiiBuE1uHE96/WAe6wE=;
        b=PUk97oWWBnt5TuR1DadplI6Jeshu7Fn9ZoZQOFp0Ao/Z8DPhChG4dXo9n2ycFgw7RmDol3
        qqNU0EufPpNP8ytT9xZGBw9FijIjdplzS5bdZRT3Jvt/S/gIfUkzRlJdPT01hzT3S9IeVV
        kXjwBqzFJWTU2NHDR2Jly+PQSBKQcwQ=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-23-S93vhZVOO0ucSnhD8T7jjw-1; Tue, 22 Jun 2021 02:26:08 +0200
X-MC-Unique: S93vhZVOO0ucSnhD8T7jjw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8GSFqOw2VU7E9JCAAwknDOU+judL93ENQWLnyL8OxifvHfpUe8ZMYSh9/TaDNpT3ANm1jRyzspNLL17wDdreNLG0CpRq4qOGdZFEtyWh4dBFzDh/Tr8Ndn+xjtMw3uQ/yrJIuwLnOf/21zoYAHLF4saliWlPMKwyISGyc6vHEMxZ9ke39xJt8uaeei54OlgHvDZZqbwCh2nvqXgAq7vEoCRFugJhucoIV25IkE9S5nTY3Od033Gy7PpadyzFeoZQPsrVPaiHw8VXDXKy6487NjoFwqrBMuFCBaV6j9ugfJquw9RV4mS8DbANIg9TfH2HZigsReyZSIMcP5j3FJFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kutx0rgH7xxyKZlmCBxK8BaTV7EWDjlCpEfW9TVowCE=;
 b=lBrwOYh8b95EiK+XaEqW5ZDgL26wuUmN74vF6MUZsa3K0yOYL3PVlnZNN9ApoYq64bvAKqv6XOxpvezIS4UuTJyeGAuKXXoEtFHOPaAs/nCvPlzQ6LSEkOJZZ6kyJ0QisZCsIav+1pbebydGjEZu4841Bue3yu5C/ptSt8JCuuD/OZscnDU0ghHsHZajJw6tgKoLbuM3zgSJ48bY78rajLFU4leEaz1sxVbWdYsRwlNfvPVVyfAv6dRbaB0NxL3u8WE35gxkW+WFfokW6s78h/6X5nfEkmWkB9M9KKbQ1vtaRMRuk9rNvVWGdcbVnw+pfWDKYE4Qg1X59EXkfb6SOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB5205.eurprd04.prod.outlook.com (2603:10a6:20b:1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.22; Tue, 22 Jun
 2021 00:26:06 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b4b5:823d:f2fd:d10%7]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 00:26:06 +0000
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or
 rebalance
To:     Asif Youssuff <yoasif@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
 <1b89f8a3-42a4-3c6d-aec8-1b91a7b43713@gmx.com>
 <CAHw5_hk9Uy-q=9n+TvtiCtLH5A08gVo=G4rUhpuQyZwzuF68dQ@mail.gmail.com>
 <60a9b119-c842-9fea-3fb3-5cd29a8869ef@gmx.com>
 <CAHw5_hmN3XTYDhRy4jMfV4YN6jcRZsKs-Q_+K-o3fLhC9MXHJA@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <06661dd5-520b-c1b5-061e-748e695f98a6@suse.com>
Date:   Tue, 22 Jun 2021 08:25:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAHw5_hmN3XTYDhRy4jMfV4YN6jcRZsKs-Q_+K-o3fLhC9MXHJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::28) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR05CA0053.namprd05.prod.outlook.com (2603:10b6:a03:33f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Tue, 22 Jun 2021 00:26:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0b20562-3ccc-4d0c-b2de-08d93514532d
X-MS-TrafficTypeDiagnostic: AM6PR04MB5205:
X-Microsoft-Antispam-PRVS: <AM6PR04MB520517BA74596AC4CA3DAF51D6099@AM6PR04MB5205.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +cWQIS/hakEeO/8S/8GrfUSlv5sdt9wvUHIUHK2ImeoukT/AeIHh3CBuDlabKzgubcBUgYfsClvefi/iTVzDDYGULaGq4wW3Qn5E+70ePQByUDbCsp1+ygVK7RhOxRQe+TM0P1HsiVMvMllAlhA04UVLs86MgduZYUQNk/v23vDeMiJN+1rkxRv9WpFxiMm+tzAu+s+kJiTYuEe7p3FxyOWT+/U2Flg2Ogcq2jq2vrVnQDa4+Nh7KEUbOQ3wTvubCAaqUWlNrKAqEAlrSmXa4mie00llLLqpKqqHAg38YKnMxfacH1ljKMyu3/DYtky9O4SDMiPNF2j2QRCkVvlzQMyN4Z3G7bRtk7KMyUNhzpEJ13xKANhBeD2ygW02mbL++R38t3aqu4tHdekoxB8GjnZ3EsQw8fQBtmcOV+mVuYGjwL/b8ZiT/Za5Qa3tBTsCYjaKLdFG1nn/6gYoxTh1GMsYfT0CsW5DembltoJfGkjtRLuSoziuC0gKcBt4IfPZTTEhkwAeLVPDc1Jng71FArzRSdN6B9oJt/x+1M8nFtMa9RaewT07M6Mmd64oSM3fj7v5FlGibujEQUPYYpPjcCBWwAHN94xSl8Kbfw5X+8Y/QiGOUCWGl7pEjgsW4Cb4ccMBxvqzrnO4K41N3AUTabbfOlbmzxfWoQ1vhW4XLC7/TvHwD0Ey1stqEFC2vtbWEPJH3tbzRj9xLhGl9Fp6hs97RE2BhNa4c6I84PzyEu4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(346002)(136003)(376002)(366004)(396003)(36756003)(110136005)(66476007)(8676002)(66556008)(26005)(31696002)(83380400001)(38100700002)(2906002)(31686004)(86362001)(66946007)(2616005)(8936002)(45080400002)(478600001)(4326008)(16576012)(186003)(16526019)(6666004)(956004)(316002)(6706004)(6486002)(5660300002)(53546011)(518174003)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zR7gjmRpWbfImsKJfP98rbN7wBj5JiNLnyfDEuM19nIiPRBCUsnjB19GjMm3?=
 =?us-ascii?Q?A1Esm8MsC0yGIiUiGjU2Ju7TpTcmL5XFVDXqfhjWBm79AqyZvuH+GLrEqBYQ?=
 =?us-ascii?Q?m9iSdKKBFZi6aHtxKZ8AoCQVMN5RZgKDareWOzMQKka1VL96ne0sBrfz6nwi?=
 =?us-ascii?Q?KOuSKnTMaZ3yecPJS9D7JCfqaXvHgEGXf7uTXMJr13jh596f6Gw5Vkr+Yugx?=
 =?us-ascii?Q?D9s/54FthF/345FEmCJ5F7OyeMRHpvX8kmnW+h3kMKoiu8oKOnypC8ZsYw75?=
 =?us-ascii?Q?RWIWOktkutw2F0RVnUKjwJEaV7d3fVFtIlxloen2qh7NeI2ZEb6j8Svb4EsG?=
 =?us-ascii?Q?man90/Ei/FeIB3ylupCSk6fMsHjyMxs1jNwNTWN0DGJaRm8EFF19q+7iJbgo?=
 =?us-ascii?Q?dYATZAN2z7LLgzkMvZIljxZrbOGhUvL9YqbKnSrgiKEy/Kgxe/Xo9xU7P7v9?=
 =?us-ascii?Q?+winnmzOXzMd+Zid85INrJvz2hiaFDfkL2nvzl6D0TEdWg8Evb54LJ1vYXad?=
 =?us-ascii?Q?t7UElnZ2VPQ2IVj2wcSMweRpEpbq/FC4F9iOhVW0bFIEHiAHA7W2bvzrociD?=
 =?us-ascii?Q?OB6yFrewKm03zLcRSDelg4qpRxMSmd2TouyqBBm058Zz+FoIobODrH4yoRo1?=
 =?us-ascii?Q?OacAZ1wIomC2Hi9ntcbUvhs5wo++p6ZM9FzhXykaC5x/2ognqt2na3hYn/7D?=
 =?us-ascii?Q?0GD2QIT203UBWWp4rfYFd6QTaqyUxGsR1s0kd0hGTBSsr2i4uOJvAMoA1Jgr?=
 =?us-ascii?Q?PEbSD4TQA3g/uuTjtquYTnb4CDiSsDdHaNDwDFbKoPT1NFl23B+lrrXjZaoS?=
 =?us-ascii?Q?VE7afmO5kCym5bJa85Df4zhJTYnipLlIZXi8ooQTR8NtMj6Q+eT+kmbZ9gjB?=
 =?us-ascii?Q?YhG4Gx65rQrT9UFbI8L/94ufcLk/RAqTexdDnDb10VSFfUklc2LNLKZ3jNMQ?=
 =?us-ascii?Q?HEj6IGVv0e3eXaNGAq981SG0PGYwl3zEBmrh1aW4gpEDByFv2hrorbgKNB32?=
 =?us-ascii?Q?7gSnouRinZJgo2kZh9TMn+VYCX9x74zWIfwQEALMfSp877uihCASHLUiykRB?=
 =?us-ascii?Q?cKfsvUMljGj9V9lN6X8MY8pZJaPCxMsDGTXTzOERqBWoVjyqNL5kp2u/5QnX?=
 =?us-ascii?Q?XBYxjjrWjpf4OvuUiBN4L13QK1fPk1F0REsZcyI7MhsXT9jeUhYo5uezKq9V?=
 =?us-ascii?Q?4l1wtJ+1KVX2mXQ19pBfxTiOLyIjYdZhjwb1sqaYpPfUc6r8AGl7HkdQtbgE?=
 =?us-ascii?Q?GBgG3bqHsj63F/z1PnK9d6sKIP7y/yoOuvToWQEo/zg1JUpS4IrlUmBtQSgk?=
 =?us-ascii?Q?sb2YR5PH29AiOgChvH+LcZh8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b20562-3ccc-4d0c-b2de-08d93514532d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 00:26:06.1668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZSXlKhehbDwy1WOrbzaDxRWh2RuiXfySb7JsjyV5JEhQBZ9wH4xOrp+KwIJ4p2/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5205
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/22 =E4=B8=8A=E5=8D=888:12, Asif Youssuff wrote:
> On Mon, Jun 21, 2021 at 7:36 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
>>> I have tried removing snapshots, but the disk continues to go ro -
>>> after remount, the subvolumes are still there. Is there a way to force
>>> a sync of the subvolume removal before the fs goes ro?
>>
>> Maybe you can try "btrfs fi sync" before remount?
>=20
> Tried deleting a bunch of snapshots and immediately did a btrfs fi
> sync - still forced ro pretty quickly:

So that's the worst case, metadata already exhausted.

Have you tried to just delete one small subvolume and then fi sync?

It's possible that too many pending subvolume deletion can cause too=20
much metadata space usage.

Thus if you do it one by one, there may be a chance to commit successfully.

Thanks,
Qu
>=20
> [ 1810.858326] ------------[ cut here ]------------
> [ 1810.858334] BTRFS: Transaction aborted (error -28)
> [ 1810.858384] BTRFS: error (device sdf) in __btrfs_free_extent:3216:
> errno=3D-28 No space left
> [ 1810.858493] BTRFS info (device sdf): forced readonly
> [ 1810.858405] WARNING: CPU: 5 PID: 10137 at
> fs/btrfs/extent-tree.c:3216 __btrfs_free_extent+0x7be/0x920 [btrfs]
> [ 1810.858500] BTRFS: error (device sdf) in
> btrfs_run_delayed_refs:2163: errno=3D-28 No space left
> [ 1810.858635] Modules linked in: veth xt_nat nf_conntrack_netlink
> nfnetlink xfrm_user xfrm_algo xt_addrtype br_netfilter xt_CHECKSUM
> iptable_mangle xt_MASQUERADE iptable_nat nf_nat xt_conntrack
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4
> xt_tcpudp bridge stp llc ebtable_filter ebtables ip6table_filter
> ip6_tables iptable_filter bpfilter ppdev parport_pc parport
> vmw_vsock_vmci_transport vsock vmw_vmci overlay bluetooth ecdh_generic
> ecc msr binfmt_misc input_leds joydev ipmi_ssif dm_crypt
> intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp
> coretemp kvm_intel kvm crct10dif_pclmul crc32_pclmul
> ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl intel_cstate
> intel_pch_thermal lpc_ich mei_me mei acpi_ipmi ipmi_si ipmi_devintf
> ipmi_msghandler ie31200_edac mac_hid acpi_pad sch_fq_codel ib_iser
> rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi
> scsi_transport_iscsi ip_tables x_tables autofs4 btrfs blake2b_generic
> raid10 raid456
> [ 1810.858782]  async_raid6_recov async_memcpy async_pq async_xor
> async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear
> hid_generic usbhid hid uas usb_storage ast drm_vram_helper
> drm_ttm_helper ttm drm_kms_helper syscopyarea sysfillrect sysimgblt
> fb_sys_fops cec mpt3sas rc_core raid_class drm igb ahci xhci_pci dca
> e1000e libahci i2c_algo_bit scsi_transport_sas xhci_pci_renesas video
> [ 1810.858857] CPU: 5 PID: 10137 Comm: btrfs-transacti Tainted: G
>    W         5.12.12-051212-generic #202106180931
> [ 1810.858865] Hardware name: Supermicro X10SLM-F/X10SLM-F, BIOS 3.0 04/2=
4/2015
> [ 1810.858868] RIP: 0010:__btrfs_free_extent+0x7be/0x920 [btrfs]
> [ 1810.858973] Code: 8b 40 50 f0 48 0f ba a8 48 0a 00 00 03 72 1d 8b
> 45 84 83 f8 fb 74 32 83 f8 e2 74 2d 89 c6 48 c7 c7 98 0c 75 c0 e8 15
> e1 f6 f7 <0f> 0b 8b 4d 84 48 8b 7d 90 ba 90 0c 00 00 48 c7 c6 c0 52 74
> c0 e8
> [ 1810.858980] RSP: 0018:ffffab4702a43c00 EFLAGS: 00010286
> [ 1810.858986] RAX: 0000000000000000 RBX: 0000000000000030 RCX: ffff95e57=
fd585c8
> [ 1810.858991] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff95e57=
fd585c0
> [ 1810.858995] RBP: ffffab4702a43ca8 R08: 0000000000000000 R09: ffffab470=
2a439e0
> [ 1810.858998] R10: ffffab4702a439d8 R11: ffffffffb99542e8 R12: 000157fe7=
4a6e000
> [ 1810.859002] R13: 0000000000000515 R14: ffff95de8a0941c0 R15: ffff95dfa=
a212200
> [ 1810.859007] FS:  0000000000000000(0000) GS:ffff95e57fd40000(0000)
> knlGS:0000000000000000
> [ 1810.859012] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1810.859016] CR2: 00007fd6fc652718 CR3: 0000000278610004 CR4: 000000000=
01706e0
> [ 1810.859022] Call Trace:
> [ 1810.859031]  run_delayed_data_ref+0x96/0x160 [btrfs]
> [ 1810.859130]  btrfs_run_delayed_refs_for_head+0x184/0x480 [btrfs]
> [ 1810.859225]  __btrfs_run_delayed_refs+0x8c/0x1d0 [btrfs]
> [ 1810.859320]  btrfs_run_delayed_refs+0x73/0x200 [btrfs]
> [ 1810.859474]  btrfs_commit_transaction+0x68/0xa20 [btrfs]
> [ 1810.859633]  ? start_transaction+0xd5/0x590 [btrfs]
> [ 1810.859783]  ? __next_timer_interrupt+0xd0/0x110
> [ 1810.859800]  transaction_kthread+0x138/0x1b0 [btrfs]
> [ 1810.859905]  kthread+0x12f/0x150
> [ 1810.859916]  ? btrfs_cleanup_transaction.isra.0+0x290/0x290 [btrfs]
> [ 1810.860020]  ? __kthread_bind_mask+0x70/0x70
> [ 1810.860031]  ret_from_fork+0x22/0x30
> [ 1810.860045] ---[ end trace 64a07c4b91899089 ]---
> [ 1810.860052] BTRFS: error (device sdf) in __btrfs_free_extent:3216:
> errno=3D-28 No space left
> [ 1810.860172] BTRFS: error (device sdf) in
> btrfs_run_delayed_refs:2163: errno=3D-28 No space left
>=20
>=20
>=20

