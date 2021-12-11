Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D486F47131F
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Dec 2021 10:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhLKJTV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Dec 2021 04:19:21 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:52456 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229455AbhLKJTU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Dec 2021 04:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1639214358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tRj1tG9UiYiZNzJx03a/LE5G7/derm/GT399p1c+DbI=;
        b=H0dj4201sP7IJtnlM1d3p7iHq4IKPhqIwb+hcIq7E1q+PWPly49OPqblUshLEhlxbZEs2k
        qLfjfKIweqmKT8Zbbeyc8RyfsnLmF19HLc2ChDORg1qHbWUpFR6SqBPM5uzP5wrcBdymfs
        FJQVjsT3bngXFurA2meVgsp+3kaeNCY=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2059.outbound.protection.outlook.com [104.47.5.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-WHELnvv5McGoqmqG76eALQ-1; Sat, 11 Dec 2021 10:19:17 +0100
X-MC-Unique: WHELnvv5McGoqmqG76eALQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edTQS0K7D58IRS/b25S7Etwpc7dWqubJS+Ib/HT447lInEAHZ4stC6oQalZBygNwSvS6imc21tlg83yYtWgNmXC2/d9SEDNahMsxCr9m/zQgZP/zR7V/oHnTISnut0kIFiELM+vgvmTvycyToEAh9YMNdpGhBEz0BNSfHEAZ0Hq8CZttFr25LyotZxMyEP01Si2t6oVjQsFjvExgPjKLQNA8tee/2L5s62plUjWIVw/fpDhJgtQZdC+DdwS44lbWcY9xWJC80JltjdO65rzvQUeCSgmyTR4/dYaVwKYyeXAhe+JBRNLJ+HpjfK7EK7g3mp4iGdo6OPNF1vb8Hnb4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yKjFZx6RZTPFj5b0QY2FLwyiNkm95HJNW45B1cK5Dg=;
 b=GtVyv6++n0dMxGP2f5O7wf+U8qbEVuyCqu7oZImdMZf3SqdQIjVCX1XTpsoMGdUooN7iqr5mY+YS5pm6ks/OTDflHlnDJ4uXVgVDCNpGXT8aQ2zOycNZ0qzHaZ0/sZ2cd42b2/9tqUmd5u8VO0d3qBm1FKu3tmAVwdACT733HYW6P9Zbk1r7+Pb8PQWbJTWjOdrSmtQVNCjc17wqxysGx3SiXvVDTAUjrfeNY9Bn9Wv/qMSrGsZvsS/ih9hXk5vxkn4iyyFOPWwwXyFkuXnfb4T/OI/vXy61fgnEMbw7Q7as9NUyB6gdlUIpAEMaaPEQpm7zNbJSkZftNDL+Dz7DJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DU0PR04MB9443.eurprd04.prod.outlook.com (2603:10a6:10:35b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Sat, 11 Dec
 2021 09:19:14 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e%4]) with mapi id 15.20.4755.021; Sat, 11 Dec 2021
 09:19:14 +0000
Message-ID: <114dbcbb-c0ad-6ffd-f9ff-7aff031d03b5@suse.com>
Date:   Sat, 11 Dec 2021 17:19:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: filesystem corrupt - error -117
Content-Language: en-US
To:     Mia <9speysdx24@kr33.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Patrik Lundquist <patrik.lundquist@gmail.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@kernel.org>
References: <em969af203-04e6-4eff-a115-1129ae853867@frystation>
 <em33e101b0-d634-48b5-8a32-45e295f48f16@rx2.rx-server.de>
 <c2941415-e32f-b31d-0bc2-911ede3717b7@gmx.com>
 <69109d24-efa7-b9d1-e1df-c79b3989e7bf@rx2.rx-server.de>
 <em0473d04b-06b0-43aa-91d6-1b0298103701@rx2.rx-server.de>
 <146cff2c-3081-7d03-04c8-4cc2b4ef6ff1@suse.com>
 <884d76d1-5836-9a91-a39b-41c37441e020@rx2.rx-server.de>
 <em6e5eb690-6dcd-482d-b4f2-1b940b6cb770@rx2.rx-server.de>
 <3ce1dd17-b574-abe3-d6cc-eb16f00117cc@rx2.rx-server.de>
 <em2512c4e9-1e5e-4aa0-b9fc-fb68891e615d@rx2.rx-server.de>
 <CAA7pwKOrgt6syr5C3X1+bC14QXZEJ+8HTMZruBBPBT574zNkkQ@rx2.rx-server.de>
 <emb611c0ff-705d-4c01-b50f-320f962f39fb@frystation>
 <embddc7343-8fdf-4be8-87d8-644e20ea86c0@frystation>
 <em686698e8-bf89-4064-a66f-3298bb32ea05@rx2.rx-server.de>
 <29fcb603-506f-d721-5214-2870ce2f8773@rx2.rx-server.de>
 <em7854e1bc-eb3d-43a3-abc7-c6ed3e1a167a@frystation>
 <em329c1cbd-db83-4106-9767-8e487c7e9095@rx2.rx-server.de>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <em329c1cbd-db83-4106-9767-8e487c7e9095@rx2.rx-server.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR13CA0134.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::19) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR13CA0134.namprd13.prod.outlook.com (2603:10b6:a03:2c6::19) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Sat, 11 Dec 2021 09:19:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b327c8cb-07db-45f1-c733-08d9bc874cbc
X-MS-TrafficTypeDiagnostic: DU0PR04MB9443:EE_
X-Microsoft-Antispam-PRVS: <DU0PR04MB9443928287904A90ED335A02D6729@DU0PR04MB9443.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iR2nU0fsieOCQZGhxMUKRCMibj7vJeaeXRfpvCmDLhLu6IIfoHzM7jIMAiVWkpspVQ5NHKUR+PMm9ArSY3RfHknufcv3AyrCzB4yBe6tQa8+OKf684ks2G0xwwyOaOb66Bn1M6w7UnDqv5mJ6OFcDAxW5EFj4i5peB/rB4WGT3xlI3Vl48i2sZ0xmV6UdA9kUyRz+ot960cZ28gfy10wjbthfIp9xicRiSCxD2mHwE33NmxrtM1Vl0UDeUBTcYwyXbxw0J7u3M3XZnQHlbQLfTYerXRNEOLV8PmYZLGzoEpVeYO7gO6Vkk5ayXdD6XkH08OGVc22cA+JNcDkABTSKUisY68aoRiliB79VtABMXjf7ZH51Ya0w8BgfaEcC9DItSFHuOqnoxpbsavrQ9VBuSRy6Dj4emm7kxB+JPOPoiaO4qav8SxrKwWjdmOh98BBvPCCz/uO7Rtf9mIzxIWgjt2ZsAIV4A/hOmFOMNJmmKZmSZjeVcZGT9+02pgpogfBA4oAHEaNj37KYFe0pFtcE7Z3h1X5FWeWhmsXz4/FO0Zn/xkfkK3gbtXizQawry1zj6hwPP8zEArjtHivqDyLv5Lbr2p/1rIHjmrHkIJ/c9VDPZA0g3Cey5gBzcSJK5eUrHYBnWRL/0JRTVEFzPuzdGZtv3b1IjIumsdACtVAkM+izM2QSIb3kM6jgeSRyecwp1NV1IjwI1C39nAOQ1WY8yUIBzkkSLSps0oW+0KEUYmBhBfm8rZ/CuBsbI/THsyAtvziYrAzsCPn7JhoVp9QJQIp1EJo5FitqO3wP3cumw9JsdspJECE3nPJq2ykMN6oOOlXHw8xtQyb85ON5FM30QemfTeu6qILoG357zvJsEg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(30864003)(66946007)(38100700002)(2616005)(16576012)(26005)(86362001)(966005)(45080400002)(956004)(508600001)(316002)(31686004)(8676002)(8936002)(110136005)(83380400001)(6486002)(36756003)(186003)(4001150100001)(31696002)(66556008)(6666004)(6706004)(5660300002)(66476007)(53546011)(2906002)(518174003)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XdBK5tlWaOemMMS5WqYvTa5q6gXClYa/aLubfJE4KwDyXkwpcZjNNJbF0DzG?=
 =?us-ascii?Q?HdwXqB+knX1P283Ew9G0pTu43iwYPup9FIejoRtt5+Eva+lEqn4j8uscLNZE?=
 =?us-ascii?Q?gz5UMoKfI1MC/XNZ/PuFUzuepFgWWFotmNXiSOq/gNhKVWDox3zQC+Mm8Q1M?=
 =?us-ascii?Q?7CCJ43QEi8EVE8CKjKS7wA0yvMRO8QSLOn0v6EavxiP4pCajnqKZ32j/ctjn?=
 =?us-ascii?Q?ZFryitgD/6OqvbTXG5B+APfBoLnIMxllJusoueU85h7PpoSv3xOQ3ucFlbn/?=
 =?us-ascii?Q?+KVYcp95fo9uuMqV9iV3CuNpM8gkwz0+iKF4IPOOoKRB3p7Dy7hvlLxyrISp?=
 =?us-ascii?Q?hP21uTqzzmvwaFYGMEfe4FCWyanok3l6zxIVmrWb7mH9JHGRO/Eg3X/mEtG+?=
 =?us-ascii?Q?8gmzoTFaa5tPAdtxZIgFP+p+y/s0bh+pxbOQOhjMvtFOb8wZ0MwtK4It7E/G?=
 =?us-ascii?Q?y8ufOa7DQTQyUw6pjHizf9TV9UpfD1i4YKxPNwXR7G1AIkaAHxc5Pqec/OSf?=
 =?us-ascii?Q?xxrRuwW89TZwFsn6yCteZ/SdEbGyl6n2xve8SER6IGOSSy2AcncHSGpZ/0j7?=
 =?us-ascii?Q?Wf2lJ7u9RMAcqO245XTku2v6UJTew5UUCpuFlpH93fR+lujliABbEbPETaq8?=
 =?us-ascii?Q?VTZU7isTTMZjwdKEm+sh0AY9pbEs5LcrbTWONqmbJW6bC5qDgXFHl64lwv5W?=
 =?us-ascii?Q?t7tolVC8hrp2zfig/bSbCyVVsTbUKhHp33Eu8SF9geB4XaTGxzix2Nvt/QaV?=
 =?us-ascii?Q?mPRn8hROD81jbCeRffIcVlkj3YxMZhSQAOo9MyKTfHIq6aaufZtrncaDuUEI?=
 =?us-ascii?Q?k+pzvz+MysviRP2DHwvnkBAlz0sxEg2JbcmfcQ0fmU8Iyq6ZJpXVfRRPSDlB?=
 =?us-ascii?Q?TqN5js6gSvPuWn5ZDzplOdN1lvpnXc/ytvvWjZXi7xa8JNKTlftQjK5ghQLu?=
 =?us-ascii?Q?Wq/UwksJBqe9qUb//6sPsnnsxfQ+BPKeLaNpj09fPjxfs32vb4P2rpValo8j?=
 =?us-ascii?Q?T4jZ2e6j4mJJRrNYekdUw6pM/Js7osC4ZNnu6bpAbfVIfekAUjNP+jUXFolB?=
 =?us-ascii?Q?onug6H5CYQAtRAEy0BKJiBRmNggvIrtFEsOAe+oi42icFQoNDD/K4c79G8+N?=
 =?us-ascii?Q?xbozFUk2zlQnRaa2Hr/ajrkE2uousRXFv5vj81IPszBKuLcKsiX8YrNPp/h1?=
 =?us-ascii?Q?Hd0G8mUneDWUBPb07dEFWe4k6/veDcUDFSJH/u0ZfoRhZaDR/NGzAmm1YcE5?=
 =?us-ascii?Q?Sf3KEpiT4esMwJtjMQ5Dbv6lUYbMti+lpmt+Kit+qR9+o+7fhN0/TuFqAtzN?=
 =?us-ascii?Q?3ZNb93iCqRsnKs5RLAWXJFEoiTwAJ79QuzHcV34bbmerpzFP4M0LI1/kVhgl?=
 =?us-ascii?Q?69sTlpMNlbxkFMk05UE/WLgbezf2Q3dZo6yZ8vYy5Czl+GZkva5Htznlq+UQ?=
 =?us-ascii?Q?/7c+Qmd1ME6UHF3YDBkjDUVS4+ZXPuLQK/dfrwtzz8PN+t8bPwmg1tXD/TB3?=
 =?us-ascii?Q?Wkegdlz91XvV30ggiK5Pl+IL5kSmZJ3uwJSE7tp6YE+1OlsbvxeMX/lZUDI+?=
 =?us-ascii?Q?FawfBQ1O6bw7SQp7vOw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b327c8cb-07db-45f1-c733-08d9bc874cbc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2021 09:19:14.5557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyxtW8I9NRFqXkEHUszWiT4ZhEaxGOTcG+tp+YHZ46cWudjQPLHamtbQQgFTDwcd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9443
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/11 17:12, Mia wrote:
> Never mind, filesytem went RO again a few minutes after boot. :(
>=20
> [=C2=A0=C2=A0 10.759194] BTRFS error (device sda3): tree first key mismat=
ch=20
> detected, bytenr=3D543379832832 parent_transid=3D1349283 key=20
> expected=3D(468977471488,168,16384) has=3D(468983328768,168,61440)
> [=C2=A0=C2=A0 10.762568] BTRFS error (device sda3): tree first key mismat=
ch=20
> detected, bytenr=3D543379832832 parent_transid=3D1349283 key=20
> expected=3D(468977471488,168,16384) has=3D(468983328768,168,61440)

This is from extent tree, and it looks like there is some corruption in=20
the extent tree already.

Btrfs check is recommended to verify if the corruption is already=20
committed to disk.

I don't have any good idea on this problem any more, if it's really a=20
corruption in extent tree, it's not going to end up well...

Thanks,
Qu

> [=C2=A0=C2=A0 10.764642] ------------[ cut here ]------------
> [=C2=A0=C2=A0 10.764644] BTRFS: Transaction aborted (error -117)
> [=C2=A0=C2=A0 10.764766] WARNING: CPU: 2 PID: 2097 at fs/btrfs/extent-tre=
e.c:2148=20
> btrfs_run_delayed_refs+0x1a6/0x1f0 [btrfs]
> [=C2=A0=C2=A0 10.764767] Modules linked in: xfrm_user xfrm_algo ip6t_REJE=
CT=20
> nf_reject_ipv6 ip6_tables nf_log_ipv6 br_netfilter xt_recent ipt_REJECT=20
> nf_reject_ipv4 xt_multiport xt_comment xt_hashlimit xt_conntrack=20
> xt_addrtype xt_mark xt_nat xt_CT nfnetlink_log xt_NFLOG nf_log_ipv4=20
> nf_log_common xt_LOG nf_nat_tftp nf_nat_snmp_basic nf_conntrack_snmp=20
> nf_nat_sip nf_nat_pptp nft_counter nf_nat_irc nf_nat_h323 nf_nat_ftp=20
> nf_nat_amanda ts_kmp nf_conntrack_amanda nf_conntrack_sane=20
> nf_conntrack_tftp nf_conntrack_sip nf_conntrack_pptp=20
> nf_conntrack_netlink nf_conntrack_netbios_ns nf_conntrack_broadcast=20
> nf_conntrack_irc nf_conntrack_h323 nf_conntrack_ftp xt_CHECKSUM=20
> nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack nf_defrag_ipv6=20
> nf_defrag_ipv4 xt_tcpudp nft_compat wireguard libchacha20poly1305=20
> nf_tables chacha_x86_64 poly1305_x86_64 ip6_udp_tunnel udp_tunnel=20
> nfnetlink libblake2s blake2s_x86_64 curve25519_x86_64=20
> libcurve25519_generic libchacha libblake2s_generic overlay bridge stp=20
> llc fuse amd_energy crc32_pclmul
> [=C2=A0=C2=A0 10.764814]=C2=A0 ext4 ghash_clmulni_intel crc16 mbcache aes=
ni_intel jbd2=20
> libaes crypto_simd cryptd virtio_console glue_helper evdev sg joydev=20
> virtio_balloon serio_raw pcspkr qemu_fw_cfg sunrpc ip_tables x_tables=20
> autofs4 btrfs blake2b_generic xor raid6_pq libcrc32c crc32c_generic=20
> hid_generic usbhid hid sr_mod sd_mod cdrom t10_pi crc_t10dif=20
> crct10dif_generic ata_generic virtio_net net_failover virtio_scsi=20
> failover ata_piix bochs_drm drm_vram_helper drm_ttm_helper ttm libata=20
> psmouse drm_kms_helper crct10dif_pclmul crct10dif_common crc32c_intel=20
> uhci_hcd scsi_mod cec ehci_hcd i2c_piix4 drm usbcore virtio_pci=20
> virtio_ring virtio usb_common floppy button
> [=C2=A0=C2=A0 10.764867] CPU: 2 PID: 2097 Comm: dockerd Not tainted=20
> 5.10.0-0.bpo.9-amd64 #1 Debian 5.10.70-1~bpo10+1
> [=C2=A0=C2=A0 10.764868] Hardware name: netcup KVM Server, BIOS RS 2000 G=
9 06/01/2021
> [=C2=A0=C2=A0 10.764887] RIP: 0010:btrfs_run_delayed_refs+0x1a6/0x1f0 [bt=
rfs]
> [=C2=A0=C2=A0 10.764889] Code: 8b 55 50 f0 48 0f ba aa 40 0a 00 00 02 72 =
20 83 f8=20
> fb 74 39 83 f8 e2 74 34 89 c6 48 c7 c7 68 ed 84 c0 89 04 24 e8 ac 32 cc=20
> f8 <0f> 0b 8b 04 24 89 c1 ba 64 08 00 00 48 89 ef 89 04 24 48 c7 c6 a0
> [=C2=A0=C2=A0 10.764890] RSP: 0018:ffffb84940f0fbe0 EFLAGS: 00010282
> [=C2=A0=C2=A0 10.764892] RAX: 0000000000000000 RBX: ffff9fef80ec9958 RCX:=
=20
> 0000000000000027
> [=C2=A0=C2=A0 10.764893] RDX: 0000000000000027 RSI: ffff9ff2afd18a00 RDI:=
=20
> ffff9ff2afd18a08
> [=C2=A0=C2=A0 10.764893] RBP: ffff9fef80ec9958 R08: 0000000000000000 R09:=
=20
> c0000000ffffefff
> [=C2=A0=C2=A0 10.764894] R10: 0000000000000001 R11: ffffb84940f0f9e8 R12:=
=20
> ffff9fef89d63200
> [=C2=A0=C2=A0 10.764895] R13: ffff9fef82ca1e30 R14: ffff9fef864e39c0 R15:=
=20
> 000000000000d20c
> [=C2=A0=C2=A0 10.764899] FS:=C2=A0 00007fe7cde3b700(0000) GS:ffff9ff2afd0=
0000(0000)=20
> knlGS:0000000000000000
> [=C2=A0=C2=A0 10.764900] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080=
050033
> [=C2=A0=C2=A0 10.764901] CR2: 000055c1340bad98 CR3: 0000000105cc4000 CR4:=
=20
> 0000000000350ee0
> [=C2=A0=C2=A0 10.764904] Call Trace:
> [=C2=A0=C2=A0 10.764929]=C2=A0 btrfs_commit_transaction+0x57/0xb70 [btrfs=
]
> [=C2=A0=C2=A0 10.764949]=C2=A0 ? btrfs_record_root_in_trans+0x56/0x60 [bt=
rfs]
> [=C2=A0=C2=A0 10.764970]=C2=A0 ? start_transaction+0xd3/0x580 [btrfs]
> [=C2=A0=C2=A0 10.764993]=C2=A0 btrfs_mksubvol+0x2b0/0x440 [btrfs]
> [=C2=A0=C2=A0 10.765014]=C2=A0 btrfs_mksnapshot+0x75/0xa0 [btrfs]
> [=C2=A0=C2=A0 10.765033]=C2=A0 __btrfs_ioctl_snap_create+0x167/0x170 [btr=
fs]
> [=C2=A0=C2=A0 10.765051]=C2=A0 btrfs_ioctl_snap_create_v2+0x111/0x140 [bt=
rfs]
> [=C2=A0=C2=A0 10.765069]=C2=A0 btrfs_ioctl+0xbc4/0x2f70 [btrfs]
> [=C2=A0=C2=A0 10.765085]=C2=A0 ? __x64_sys_ioctl+0x84/0xc0
> [=C2=A0=C2=A0 10.765087]=C2=A0 __x64_sys_ioctl+0x84/0xc0
> [=C2=A0=C2=A0 10.765112]=C2=A0 do_syscall_64+0x33/0x80
> [=C2=A0=C2=A0 10.765127]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [=C2=A0=C2=A0 10.765139] RIP: 0033:0x5555e122e5db
> [=C2=A0=C2=A0 10.765141] Code: fa ff eb bf e8 46 3c fa ff e9 61 ff ff ff =
cc e8 1b=20
> 01 fa ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 48 8b 44 24 08 0f=20
> 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
> [=C2=A0=C2=A0 10.765142] RSP: 002b:000000c000eaa908 EFLAGS: 00000216 ORIG=
_RAX:=20
> 0000000000000010
> [=C2=A0=C2=A0 10.765144] RAX: ffffffffffffffda RBX: 000000c000063000 RCX:=
=20
> 00005555e122e5db
> [=C2=A0=C2=A0 10.765145] RDX: 000000c000fa1000 RSI: 0000000050009417 RDI:=
=20
> 0000000000000018
> [=C2=A0=C2=A0 10.765145] RBP: 000000c000eaa9a8 R08: 000000c000ad4c00 R09:=
=20
> 0000000000000000
> [=C2=A0=C2=A0 10.765146] R10: 0000000000000000 R11: 0000000000000216 R12:=
=20
> 00000000000001ce
> [=C2=A0=C2=A0 10.765147] R13: 00000000000001cd R14: 0000000000000200 R15:=
=20
> ffffffffffffffff
> [=C2=A0=C2=A0 10.765150] ---[ end trace 5f3f8ae993a39924 ]---
> [=C2=A0=C2=A0 10.765153] BTRFS: error (device sda3) in=20
> btrfs_run_delayed_refs:2148: errno=3D-117 Filesystem corrupted
> [=C2=A0=C2=A0 10.766038] BTRFS info (device sda3): forced readonly
>=20
>=20
> ------ Originalnachricht ------
> Von: "Mia" <9speysdx24@kr33.de>
> An: "Qu Wenruo" <quwenruo.btrfs@gmx.com>; "Patrik Lundquist"=20
> <patrik.lundquist@gmail.com>; linux-btrfs@vger.kernel.org; "Filipe=20
> Manana" <fdmanana@kernel.org>
> Gesendet: 11.12.2021 10:10:25
> Betreff: Re: filesystem corrupt - error -117
>=20
>> Hi Qu,
>>
>> thanks for the quick reply.
>> As suggested I did a btrfs rescue zero-log /dev/sda3
>> and I was able to mount and than boot the server again.
>>
>> Are there any further steps I can do do verify overall integrity?
>> Since my trust in btrfs isn't that great anymore.
>>
>> Thanks again for your help!
>> Mia
>>
>> ------ Originalnachricht ------
>> Von: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
>> An: "Mia" <9speysdx24@kr33.de>; "Patrik Lundquist"=20
>> <patrik.lundquist@gmail.com>; linux-btrfs@vger.kernel.org; "Filipe=20
>> Manana" <fdmanana@kernel.org>
>> Gesendet: 11.12.2021 09:39:01
>> Betreff: Re: filesystem corrupt - error -117
>>
>>>
>>>
>>> On 2021/12/11 16:28, Mia wrote:
>>>> Hi,
>>>>
>>>> just an addition, I'm now unable to mount and boot the server.
>>>>
>>>> https://drive.google.com/file/d/1QfqCR7oqKbaTxokCGWVmqNCR5vMul7Xy/view=
?usp=3Dsharing=20
>>>>
>>>
>>> This is just log tree, thus btrfs-rescue zero-log can easily repair=20
>>> that.
>>>
>>> This bug looks like something fixed by Filipe, but I'm not familiar
>>> enough with log tree code.
>>>
>>> Add Filipe to this thread.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>>
>>>> Regards
>>>> Mia
>>>>
>>>> ------ Originalnachricht ------
>>>> Von: "Mia" <9speysdx24@kr33.de>
>>>> An: "Patrik Lundquist" <patrik.lundquist@gmail.com>; "Qu Wenruo"
>>>> <quwenruo.btrfs@gmx.com>; linux-btrfs@vger.kernel.org
>>>> Gesendet: 11.12.2021 09:20:39
>>>> Betreff: Re: filesystem corrupt - error -117
>>>>
>>>>> Hello,
>>>>>
>>>>> after the switching to the newer kernel I had no further problems
>>>>> until now.
>>>>> It happened again.
>>>>>
>>>>> [1653860.040458] BTRFS error (device sda3): tree first key mismatch
>>>>> detected, bytenr=3D543379832832 parent_transid=3D1349283 key
>>>>> expected=3D(468977471488,168,16384) has=3D(468983328768,168,61440)
>>>>> [1653860.041095] ------------[ cut here ]------------
>>>>> [1653860.041098] BTRFS: Transaction aborted (error -117)
>>>>> [1653860.041289] WARNING: CPU: 2 PID: 219 at
>>>>> fs/btrfs/extent-tree.c:2148 btrfs_run_delayed_refs+0x1a6/0x1f0 [btrfs=
]
>>>>> [1653860.041291] Modules linked in: dm_mod veth ip6t_REJECT
>>>>> nf_reject_ipv6 ip6_tables nf_log_ipv6 xfrm_user xfrm_algo br_netfilte=
r
>>>>> xt_recent ipt_REJECT nf_reject_ipv4 xt_multiport xt_comment
>>>>> xt_hashlimit xt_conntrack xt_addrtype xt_mark xt_nat xt_CT
>>>>> nfnetlink_log xt_NFLOG nf_log_ipv4 nf_log_common xt_LOG nf_nat_tftp
>>>>> nf_nat_snmp_basic nf_conntrack_snmp nf_nat_sip nf_nat_pptp nf_nat_irc
>>>>> nf_nat_h323 nf_nat_ftp nf_nat_amanda ts_kmp nf_conntrack_amanda
>>>>> nf_conntrack_sane nf_conntrack_tftp nf_conntrack_sip nf_conntrack_ppt=
p
>>>>> nf_conntrack_netlink nf_conntrack_netbios_ns nf_conntrack_broadcast
>>>>> nf_conntrack_irc nf_conntrack_h323 nf_conntrack_ftp nft_counter
>>>>> nft_chain_nat xt_CHECKSUM xt_MASQUERADE nf_nat nf_conntrack
>>>>> nf_defrag_ipv6 nf_defrag_ipv4 xt_tcpudp nft_compat wireguard
>>>>> libchacha20poly1305 chacha_x86_64 nf_tables poly1305_x86_64
>>>>> ip6_udp_tunnel udp_tunnel libblake2s nfnetlink blake2s_x86_64
>>>>> curve25519_x86_64 libcurve25519_generic libchacha libblake2s_generic
>>>>> overlay bridge stp llc fuse ext4
>>>>> [1653860.041392]=C2=A0 amd_energy crc32_pclmul crc16 mbcache
>>>>> ghash_clmulni_intel jbd2 aesni_intel libaes crypto_simd cryptd
>>>>> glue_helper joydev sg virtio_console virtio_balloon evdev serio_raw
>>>>> pcspkr qemu_fw_cfg sunrpc ip_tables x_tables autofs4 btrfs
>>>>> blake2b_generic xor raid6_pq libcrc32c crc32c_generic hid_generic
>>>>> usbhid hid sd_mod sr_mod cdrom t10_pi crc_t10dif crct10dif_generic
>>>>> ata_generic virtio_net net_failover virtio_scsi failover bochs_drm
>>>>> drm_vram_helper drm_ttm_helper ttm drm_kms_helper cec ata_piix
>>>>> uhci_hcd drm libata ehci_hcd usbcore crct10dif_pclmul crct10dif_commo=
n
>>>>> virtio_pci crc32c_intel virtio_ring psmouse virtio usb_common scsi_mo=
d
>>>>> i2c_piix4 floppy button
>>>>> [1653860.041483] CPU: 2 PID: 219 Comm: btrfs-transacti Tainted:
>>>>> G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 L=C2=A0=C2=A0=C2=A0 5.10.0-0.bpo.9-amd64 #1 Debian 5.10.70-1~bpo10+1
>>>>> [1653860.041484] Hardware name: netcup KVM Server, BIOS RS 2000 G9
>>>>> 06/01/2021
>>>>> [1653860.041530] RIP: 0010:btrfs_run_delayed_refs+0x1a6/0x1f0 [btrfs]
>>>>> [1653860.041535] Code: 8b 55 50 f0 48 0f ba aa 40 0a 00 00 02 72 20 8=
3
>>>>> f8 fb 74 39 83 f8 e2 74 34 89 c6 48 c7 c7 68 0d 86 c0 89 04 24 e8 ac
>>>>> 12 4b e7 <0f> 0b 8b 04 24 89 c1 ba 64 08 00 00 48 89 ef 89 04 24 48 c=
7
>>>>> c6 a0
>>>>> [1653860.041538] RSP: 0018:ffffa9ea8040fe10 EFLAGS: 00010282
>>>>> [1653860.041541] RAX: 0000000000000000 RBX: ffff9d51c5fb9f70 RCX:
>>>>> 0000000000000027
>>>>> [1653860.041543] RDX: 0000000000000027 RSI: ffff9d54efd18a00 RDI:
>>>>> ffff9d54efd18a08
>>>>> [1653860.041546] RBP: ffff9d51c5fb9f70 R08: 0000000000000000 R09:
>>>>> c0000000ffffefff
>>>>> [1653860.041548] R10: 0000000000000001 R11: ffffa9ea8040fc18 R12:
>>>>> ffff9d51f0cda800
>>>>> [1653860.041550] R13: ffff9d51e183b460 R14: ffff9d51e183b340 R15:
>>>>> 0000000000000cca
>>>>> [1653860.041556] FS:=C2=A0 0000000000000000(0000) GS:ffff9d54efd00000=
(0000)
>>>>> knlGS:0000000000000000
>>>>> [1653860.041558] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
>>>>> [1653860.041561] CR2: 00007fd3ecdd1000 CR3: 0000000102288000 CR4:
>>>>> 0000000000350ee0
>>>>> [1653860.041583] Call Trace:
>>>>> [1653860.041675]=C2=A0 btrfs_commit_transaction+0x57/0xb70 [btrfs]
>>>>> [1653860.041722]=C2=A0 ? start_transaction+0xd3/0x580 [btrfs]
>>>>> [1653860.041767]=C2=A0 transaction_kthread+0x15d/0x180 [btrfs]
>>>>> [1653860.041810]=C2=A0 ? btrfs_cleanup_transaction+0x580/0x580 [btrfs=
]
>>>>> [1653860.041817]=C2=A0 kthread+0x116/0x130
>>>>> [1653860.041821]=C2=A0 ? __kthread_cancel_work+0x40/0x40
>>>>> [1653860.041826]=C2=A0 ret_from_fork+0x22/0x30
>>>>> [1653860.041831] ---[ end trace af79c203a5452514 ]---
>>>>> [1653860.041835] BTRFS: error (device sda3) in
>>>>> btrfs_run_delayed_refs:2148: errno=3D-117 Filesystem corrupted
>>>>> [1653860.042111] BTRFS info (device sda3): forced readonly
>>>>>
>>>>> root@rx1 ~ # btrfs fi show
>>>>> Label: none=C2=A0 uuid: 21306973-6bf3-4877-9543-633d472dcb46
>>>>> =C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used 186.78GiB
>>>>> =C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 319.00GiB used 199.=
08GiB path /dev/sda3
>>>>>
>>>>> root@rx1 ~ # btrfs fi df
>>>>> /
>>>>> :(
>>>>> Data, single: total=3D194.89GiB, used=3D185.16GiB
>>>>> System, single: total=3D32.00MiB, used=3D48.00KiB
>>>>> Metadata, single: total=3D4.16GiB, used=3D1.62GiB
>>>>> GlobalReserve, single: total=3D385.84MiB, used=3D0.00B
>>>>>
>>>>> root@rx1 ~ # btrfs --version
>>>>> btrfs-progs v5.10.1
>>>>>
>>>>> root@rx1 ~ # uname -a
>>>>> Linux rx1 5.10.0-0.bpo.9-amd64 #1 SMP Debian 5.10.70-1~bpo10+1
>>>>> (2021-10-10) x86_64 GNU/Linux
>>>>>
>>>>> Regards
>>>>> Mia
>>>>>
>>>>> ------ Originalnachricht ------
>>>>> Von: "Mia" <9speysdx24@kr33.de>
>>>>> An: "Patrik Lundquist" <patrik.lundquist@gmail.com>; "Qu Wenruo"
>>>>> <quwenruo.btrfs@gmx.com>
>>>>> Cc: "Linux Btrfs" <linux-btrfs@vger.kernel.org>
>>>>> Gesendet: 26.10.2021 19:28:14
>>>>> Betreff: Re: filesystem corrupt - error -117
>>>>>
>>>>>> Hi Patrik,
>>>>>>
>>>>>> good suggestion, I'm on 5.10.0-0.bpo.8-amd64 #1 SMP Debian
>>>>>> 5.10.46-4~bpo10+1 (2021-08-07) now.
>>>>>>
>>>>>> Hi Qu,
>>>>>> regarding the memtest. This is a virtual machine, I have no access t=
o
>>>>>> the host system.
>>>>>> I don't know if a memtest inside the vm would bring legit results?
>>>>>>
>>>>>> Regards
>>>>>> Mia
>>>>>>
>>>>>> ------ Originalnachricht ------
>>>>>> Von: "Patrik Lundquist" <patrik.lundquist@gmail.com>
>>>>>> An: "Mia" <9speysdx24@kr33.de>
>>>>>> Cc: "Linux Btrfs" <linux-btrfs@vger.kernel.org>
>>>>>> Gesendet: 26.10.2021 16:12:45
>>>>>> Betreff: Re: filesystem corrupt - error -117
>>>>>>
>>>>>>> On Tue, 26 Oct 2021 at 09:15, Mia <9speysdx24@kr33.de> wrote:
>>>>>>>>
>>>>>>>> =C2=A0Problem with updating is that this is currently still Debian=
 10=20
>>>>>>>> and a
>>>>>>>> =C2=A0production environment and I don't know when it is possible =
to
>>>>>>>> upgrade
>>>>>>>> =C2=A0because of dependencies.
>>>>>>>
>>>>>>> Maybe you can install the buster-backports kernel which currently i=
s
>>>>>>> 5.10.70?
>>>>>>>
>>>>>>> https://backports.debian.org/Instructions/
>>>>
>=20

