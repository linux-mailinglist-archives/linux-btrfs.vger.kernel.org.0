Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90CF40825C
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Sep 2021 01:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbhILX4x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Sep 2021 19:56:53 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:50981 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234094AbhILX4x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Sep 2021 19:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631490937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G5h4XFkdJorhg62lP3DqnueD7DVtChk9x7E1mhOlhvs=;
        b=ixtG5MiTZMgy8azhBDQ30v7Ev4HnbdYT20ul/yCQxwvsvEq/PCBhUrRWUZ9o0T7A1AClrb
        xBo9mDW/W3i89DbPK4We8v8C0qwWfcsU+7YOPO47KvkjXi56MsR1m9HUWw8YKXlJz0/wi+
        qk4KlQWAVAGoKjWkdxHP8o56po76VtQ=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2059.outbound.protection.outlook.com [104.47.4.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-7-qK-tj-YqP2Ons9rllwIM4g-1;
 Mon, 13 Sep 2021 01:55:35 +0200
X-MC-Unique: qK-tj-YqP2Ons9rllwIM4g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJ/qXpL/+MWyvRJwgsfrsGtkUPR8rguCA03loGFpt0R7jRxJxYMLvWnEg5VJhl0Bv6YO6XpiZsBmOJM2/tZHYrY2Yl6qkpoyBknE75Bj7CS8lZQFwzbLlTaKUCjutatgQz9a55FnI4Nzm6qz7yBkGa/ttMBwHyxYXINunlq6q6JL/nVLIQVvBJGX/G1E82+94tG5IMpDxeG7TPh3rgi0usUA2wNPf3/z3KtXiKEogH3nNT2nqoKILDu3yshVBQCxD+887DjNlavoOKlCamA0sqWldImilI1lc6xXyg6ua7u9oLFySTobjWiD/YUIG8DkAb3IjhJ8VEWvS+qPnoziUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=z/900lBWE6o0S4k3n0MnyAPRGwe0MXzywxwVzImsKko=;
 b=Sqhp6wEOQ5cEtWGrC1N37pnjHoMTt25ddNZjjH27Zupyc2rG1j+dErnSytx6Vp4UkuUxscSWeSsMgYLSAd/iPesrVQ/veRgs0SpHWyHYmfJy87ibTaQEpTYsM1Fq93bhspmA7KtZ3CiPtP+M9kfqjdDwRnB1iWKArnOJfTjhtlEtC0HZvHgFzmfzcpz2I1sP6GvoDfJCy3cjqANjMMGXKxffXDgGFb1Xqoy8/rEHeXyYx000ekG5v3W6aiGwg3hE4gdZp9zVayYEWzdbqH7aDx6p62a8DTDjCuimDG/z/65cogiEXNPrRrWB4CwvqkkXHqVTS9kHPd7dNYqPh9Sq3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB4741.eurprd04.prod.outlook.com (2603:10a6:20b:3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Sun, 12 Sep
 2021 23:55:33 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%5]) with mapi id 15.20.4500.018; Sun, 12 Sep 2021
 23:55:33 +0000
Subject: Re: Unmountable / uncheckable Fedora 34 btrfs: failed to read block
 groups: -5 open_ctree failed
To:     =?UTF-8?Q?Niccol=c3=b2_Belli?= <darkbasic@linuxsystems.it>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     linux-btrfs@vger.kernel.org
References: <0303d1f618b815714fe62a6eb90f55ca@linuxsystems.it>
 <22ac9237-68dd-5bc3-71e1-6a4a32427852@gmx.com>
 <02f428314a995fa1deea171af9685b9a@linuxsystems.it>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <5a1cc167-0b9d-8a89-11e4-cfe388bd2659@suse.com>
Date:   Mon, 13 Sep 2021 07:55:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <02f428314a995fa1deea171af9685b9a@linuxsystems.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR17CA0053.namprd17.prod.outlook.com
 (2603:10b6:a03:167::30) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR17CA0053.namprd17.prod.outlook.com (2603:10b6:a03:167::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Sun, 12 Sep 2021 23:55:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0652c73-43e7-490a-66a8-08d97648ceb1
X-MS-TrafficTypeDiagnostic: AM6PR04MB4741:
X-Microsoft-Antispam-PRVS: <AM6PR04MB47413E9445A1261F94F44284D6D89@AM6PR04MB4741.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ouD4SCgT5UUUP3AQfVskvyC0H02z4ZfFQufhpG2gmLWDOcr79b/TatOHbFtpHkRTzSq29SozSYedsqfOChuZZSnSFh2ZMW1VzDGFUF7Lvgk70qKVjsZ3/951/TWqqchVwP31p1Ae8POHALp1UJxFdjE0QVyEuy1ovcYrR/TZb70SfaweTqnWoXiS2DdR24RoL4uWajqoIC5lctwNdaswENRoMBR9HjVpIqQpleoqdvwFzBkajOuKPSjULtnzeQ18CE/YPCrp/VFlxTerYqWxDnqj9kEUCRL65zXHcWTxzLWBOslj5zuDgDcSFfAefL5Ty6W2Z96byCcQWHVYc2b3Vzr751bIH5OHneT6n8g7dJoJmcBSHsCtadYPc7MIP7aNIQ+/u0nHpAVSyVsIdaw1F1MEZniuxqGrkqRlEMZwqhjP7QDhQmFbclOSXNdR22g0SDOF1J2/+Naq+Wj+26u3kndpwjETUtMfT7YVjKyjx5seRbaEQ2I/QuwoZ2wB5MAYnoxS+wieg24KwmBzqymz/Y90NObBRaBwqQrZcOadSKZo8PzBRhdbRknPRTsp/JrPxH1P1f0RsAYwdtdfMVljhFEhrXxTwyiBSHnkFRgWd1vD6/mIQ8ct13rgVstAzUK0rhAnRRbhlzhzYuZWKxQrlLmwuhhikQDEm9tLhq7dxGarmPwdi9zJi5D8qi5JpYg0p5sXjUd3iTFGdNHBhSd3/n1QB5v1BQVKUsF+xlDQtykOcBK2pP9SoDyIJSad8Evn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(39860400002)(346002)(36756003)(186003)(110136005)(6486002)(45080400002)(66476007)(478600001)(6706004)(66946007)(26005)(956004)(16576012)(2906002)(86362001)(31696002)(6666004)(4326008)(316002)(66556008)(5660300002)(8936002)(8676002)(83380400001)(2616005)(38100700002)(31686004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e24X7FIAfOiErdV+Bwqw1m0MfjfCKxBW0ZZRSWuvU1GUpMFTyTr4194QtxBA?=
 =?us-ascii?Q?r3iJTQQ28Z0MTHjinm/5kditSf5dSKT1aWrKZMKzDCux1vMnZVgAKbLxWjUo?=
 =?us-ascii?Q?Fy7iuAH2GxFTJSJWfbPa4lkNWxkAtcsP3wwNC23wnMADkbUVZURI8ooWTSGs?=
 =?us-ascii?Q?3WQMJ8acNzKtjVYzRl2hT1bmjtiSbCcLZc/ZcJaA/NN0oCB3tb8C/ZsBtSxE?=
 =?us-ascii?Q?/cX4LdV3NfKfQBvd+hMDUovyhOH0PJLKSHTRh267sgjlktv1CHTE6g5qcJJO?=
 =?us-ascii?Q?iAdb0poHI40S13G1NvUUWsrYmmtwKcCbK9IcDCEInuWtKOFCJHykp6YSG2ZG?=
 =?us-ascii?Q?gN9vTbVlpvFWv093nHwW3wKa17SzicSHFN7aZcpS5Qtas6mp0YARV+srmNuH?=
 =?us-ascii?Q?5gJZYDILHjREPwwM64sTkvRhvek8MYWMMvIkQHJnmKTQQZ39SqLFkYpzjSX/?=
 =?us-ascii?Q?apUALzrH5fDPwkx1TFmRCpcxP3XFqA17NEZw5THnN8vd4gkEY2Jn0VGsh2nM?=
 =?us-ascii?Q?DX76tN14RtsqZqFcfTR/yJfo/9QohiR8hH9g1xJa9p58NiMuCxmnzxgqCEzT?=
 =?us-ascii?Q?Y/XpxRM3oYEXvleycbu8xu752G4g28YHkiElLVz1vfPEvXj1GhFkcW/lPAFg?=
 =?us-ascii?Q?Ku677ybjpux/1vFB98jyLA4OuiTYiGw7xsv/lTKW1ROmrpOvVnmaLnWNmqLf?=
 =?us-ascii?Q?il5Gbis1DVGeOb+SDke1ZbxSq8VFy9DBsgku59FS/n4XORT4hPzabff4ODWW?=
 =?us-ascii?Q?jEyHtenrefTQOTsX2NfpU1+mK0AcvsnZGNCIrtboWpy4k6MT4jTN6dBY5jzY?=
 =?us-ascii?Q?db5Vvp5Z53CxM0uZRMMsNB6bnImeLn3tY2fL99Y9CJpC5HVr9ULcZhSMhOfT?=
 =?us-ascii?Q?M3D0WddOwEOG/UcFsOtxN31xedIrRn0S9mRy56rd79eKcLU9/i2knvbtzQSq?=
 =?us-ascii?Q?f5Kq+KilfiOly0aYYw87oop7f1Mn81uOMLczSa1wX1EpGBXI3s2UbiVlzRjN?=
 =?us-ascii?Q?5IIwK9vnxSr87X7yFJQJJjga4mwT+pIW1mo5uotH5FPihheoPe9c/UV5FGLg?=
 =?us-ascii?Q?9TZn8RX+IBNsNmqOxPGG7yjxW9y0uXZw5tcsAnBgn1EphNX/D87lnc5+q77L?=
 =?us-ascii?Q?TJQpeH0t7gk7qFhiAxEgg0tK40+JVwI9AnsOYJRUJxQJg8Iq21+M2YEiSyWy?=
 =?us-ascii?Q?Lnk+VHPXx+Pu3xo84YcSnRsLw30l9dSxMLqpTkpYrVVdVhZLzOa7a6JPG5SK?=
 =?us-ascii?Q?igg9VemCTEPSOvFPJ+576cZab8PqzhH/YoQGhtpZdLjwcY1xMMeSvt69AuUi?=
 =?us-ascii?Q?wJVjOviW9NUNYv3PQzJWudij?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0652c73-43e7-490a-66a8-08d97648ceb1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2021 23:55:33.1561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsg7N52kZVvzagbZIYlasNEJDg9+bW0IL1N3UqukEuBTB/W2/bzrhK2R2Q1LJyB7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4741
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/13 =E4=B8=8A=E5=8D=885:23, Niccol=C3=B2 Belli wrote:
> I think I've managed to recover the vast majority of my files:
>=20
> $ sudo cp -a avd var=20
> /run/media/niko/3ea0705c-21c9-4ba9-80ee-5a511cb2a093/nvme0n1p6/
> cp: avd/Pixel_4_API_30.avd/userdata-qemu.img.qcow2: recupero delle=20
> informazioni degli extent non riuscito: Errore di input/output
>=20
> $ sudo cp -a snapshots/home/375/snapshot=20
> /run/media/niko/3ea0705c-21c9-4ba9-80ee-5a511cb2a093/nvme0n1p6/home
> cp:=20
> snapshots/home/375/snapshot/niko/devel/beach/client/android/.gradle/check=
sums/sha1-checksums.bin:=20
> recupero delle informazioni degli extent non riuscito: Errore di=20
> input/output
>=20
> $ sudo cp -a snapshots/root/3004/snapshot=20
> /run/media/niko/3ea0705c-21c9-4ba9-80ee-5a511cb2a093/nvme0n1p6/root
>=20
> $ sudo cp -a snapshots/images/3/snapshot=20
> /run/media/niko/3ea0705c-21c9-4ba9-80ee-5a511cb2a093/nvme0n1p6/images
> cp: snapshots/images/3/snapshot/OSX-KVM/mac_hdd_ng.img: recupero delle=20
> informazioni degli extent non riuscito: Errore di input/output
> cp: snapshots/images/3/snapshot/OSX-KVM/BaseSystem.img: recupero delle=20
> informazioni degli extent non riuscito: Errore di input/output

During the backup, have you checked the dmesg?

I just want to make sure that, the errors are all csum mismatch, not=20
something more series like csum tree corruption.

>=20
> The only valuable thing I've lost seems to be an hackintosh vm I use for=
=20
> development, but I can create another one.
>=20
> [ 2213.532522] BTRFS warning (device loop0): Skipping commit of aborted=20
> transaction.
> [ 2213.532526] ------------[ cut here ]------------
> [ 2213.532527] BTRFS: Transaction aborted (error -28)
> [ 2213.532565] WARNING: CPU: 2 PID: 3061 at fs/btrfs/transaction.c:1946=20
> btrfs_commit_transaction.cold+0xf2/0x2ef [btrfs]
> [ 2213.532609] Modules linked in: loop ext4 mbcache jbd2 ses enclosure=20
> scsi_transport_sas uas usb_storage cmac ccm xt_conntrack xt_MASQUERADE=20
> nf_conntrack_netlink nfnetlink xt_addrtype iptable_filter iptable_nat=20
> nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter overlay=20
> bridge stp llc snd_hda_codec_hdmi bnep uvcvideo videobuf2_vmalloc=20
> videobuf2_memops videobuf2_v4l2 videobuf2_common btusb videodev btrtl=20
> btbcm btintel mc bluetooth ecdh_generic ecc crc16 joydev=20
> intel_spi_platform intel_spi mousedev spi_nor iTCO_wdt mei_wdt=20
> intel_pmc_bxt mtd mei_hdcp iTCO_vendor_support intel_rapl_msr wmi_bmof=20
> dell_laptop i915 dell_wmi dell_smbios dell_wmi_descriptor iwlmvm=20
> x86_pkg_temp_thermal intel_powerclamp coretemp sparse_keymap snd_ctl_led=
=20
> dcdbas snd_hda_codec_realtek i2c_algo_bit snd_hda_codec_generic ttm=20
> ledtrig_audio mac80211 kvm_intel snd_hda_intel libarc4 snd_intel_dspcfg=20
> dell_smm_hwmon kvm irqbypass rapl intel_cstate iwlwifi=20
> snd_intel_sdw_acpi drm_kms_helper intel_uncore snd_hda_codec
> [ 2213.532656]=C2=A0 pcspkr psmouse processor_thermal_device_pci_legacy=20
> i2c_i801 cec processor_thermal_device snd_hda_core=20
> processor_thermal_rfim cfg80211 i2c_smbus processor_thermal_mbox=20
> intel_gtt intel_pch_thermal agpgart snd_hwdep processor_thermal_rapl=20
> syscopyarea lpc_ich rfkill snd_pcm sysfillrect intel_rapl_common mei_me=20
> snd_timer sysimgblt snd soundcore fb_sys_fops intel_soc_dts_iosf mei wmi=
=20
> int3403_thermal i2c_hid_acpi video dw_dmac i2c_hid int3402_thermal=20
> int3400_thermal int340x_thermal_zone acpi_thermal_rel acpi_pad mac_hid=20
> nls_iso8859_1 vfat fat crypto_user drm fuse ip_tables x_tables btrfs=20
> blake2b_generic libcrc32c crc32c_generic xor raid6_pq dm_crypt cbc=20
> encrypted_keys trusted asn1_encoder tee hid_multitouch usbhid dm_mod=20
> serio_raw rtsx_pci_sdmmc mmc_core atkbd libps2 crct10dif_pclmul=20
> crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd=20
> cryptd rtsx_pci xhci_pci xhci_pci_renesas tpm_crb i8042 serio tpm_tis=20
> tpm_tis_core tpm rng_core pl2303 mos7720 parport
> [ 2213.532705] CPU: 2 PID: 3061 Comm: btrfs-transacti Not tainted=20
> 5.14.0-1-git-11152-g78e709522d2c #1=20
> 4337bfa7fd23c500813a836e2184863944fac299
> [ 2213.532708] Hardware name: Dell Inc. XPS 13 9343/0X2GW3, BIOS A20=20
> 06/06/2019
> [ 2213.532709] RIP: 0010:btrfs_commit_transaction.cold+0xf2/0x2ef [btrfs]
> [ 2213.532746] Code: 28 48 89 04 24 48 89 c2 49 8b 44 24 28 48 39 c2 75=20
> 30 0f 0b 0f 0b 48 8b 45 50 eb a1 89 de 48 c7 c7 c8 e7 6e c0 e8 2f 4b 3a=20
> d9 <0f> 0b eb a9 48 8b 7d 50 89 da 48 c7 c6 f8 e7 6e c0 e8 62 ba ff ff
> [ 2213.532748] RSP: 0018:ffffaa6401eebde0 EFLAGS: 00010282
> [ 2213.532750] RAX: 0000000000000000 RBX: 00000000ffffffe4 RCX:=20
> 0000000000000027
> [ 2213.532751] RDX: ffff9be716518728 RSI: 0000000000000001 RDI:=20
> ffff9be716518720
> [ 2213.532752] RBP: ffff9be577d1c8f0 R08: 0000000000000000 R09:=20
> ffffaa6401eebc10
> [ 2213.532754] R10: ffffaa6401eebc08 R11: ffffffff9aaccca8 R12:=20
> ffff9be55293b200
> [ 2213.532755] R13: ffff9be6d303b000 R14: ffff9be577d1c948 R15:=20
> ffffaa6401eebe78
> [ 2213.532756] FS:=C2=A0 0000000000000000(0000) GS:ffff9be716500000(0000)=
=20
> knlGS:0000000000000000
> [ 2213.532758] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2213.532759] CR2: 000055d4b013fbd0 CR3: 0000000065a10005 CR4:=20
> 00000000003706e0
> [ 2213.532760] DR0: 0000000000000000 DR1: 0000000000000000 DR2:=20
> 0000000000000000
> [ 2213.532761] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:=20
> 0000000000000400
> [ 2213.532763] Call Trace:
> [ 2213.532767]=C2=A0 transaction_kthread+0x12e/0x1a0 [btrfs=20
> 1ccea181fc519646bf0a24aa8f854515e5e21f83]
> [ 2213.532799]=C2=A0 ? btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrf=
s=20
> 1ccea181fc519646bf0a24aa8f854515e5e21f83]
> [ 2213.532830]=C2=A0 kthread+0x132/0x160
> [ 2213.532834]=C2=A0 ? set_kthread_struct+0x40/0x40
> [ 2213.532836]=C2=A0 ret_from_fork+0x22/0x30
> [ 2213.532841] ---[ end trace a9ee4fb88980a146 ]---
> [ 2213.532843] BTRFS: error (device loop0) in cleanup_transaction:1946:=20
> errno=3D-28 No space left
> [ 2224.518838] BTRFS warning (device loop0): checksum verify failed on=20
> 21348679680 wanted 0xd05bf9be found 0x2874489b level 1
> [ 2227.041189] BTRFS warning (device loop0): checksum verify failed on=20
> 21348679680 wanted 0xd05bf9be found 0x2874489b level 1
>=20
> This error is weird instead, considering it's mounted ro it shouldn't=20
> complain about no space being left.

The ENOSPC is caused by the fact that we fill dummy block groups by=20
using up all its bytes.

But it's still a problem that why the kernel even tries to commit=20
transaction.

>=20
> By the way I didn't get any kind of I/O error while restoring avd, home=20
> or images with btrfs restore: what's the difference with ibadroots?

For btrfs-restore, it just ignore all csum errors.
While for ibadroots, it still does csum check (with all the other sanity=20
checks in kernel)

Thanks,
Qu

>=20
> Niccol=C3=B2
>=20

