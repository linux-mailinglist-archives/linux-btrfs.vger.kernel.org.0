Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CDD4286DE
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 08:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhJKGej (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 02:34:39 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54981 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbhJKGei (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 02:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633933958; x=1665469958;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=TXEPUZ+MS4V8+YlRD6NKWLDUH1YSJZG6o1ph+iwiiAw=;
  b=WKowWONDrGm7bwjP3R+OKuWSzLNB0fhTpdsJmA2lJFlUcZy4fSBZaOt0
   fRNf+gbs50+jL4GzcjpG7Z3NtLl3R+3cPvtHmP7qSJ9u2ABehswHdQh18
   B4UDT8CjxSaIhF40N2yIqBX6CVmFI7C0huMjpM/+gCvKtZEMnYTklUALS
   AXE3IKi1ovtMD/oPxUbJ5PdyiK2CdyUic4aw1lX8R8Q4BbFDB/fXjPjv6
   M8E0f4rUmBN3+29fy/NVPQLasrEFeJl7gPlIOK4kNMp2C/EVXHH0KQAAg
   pkkfjCv8dbns1en59jqqOJUrseCdMCZbalPdMhUY7rZRFeyu+AmmOPF5I
   A==;
X-IronPort-AV: E=Sophos;i="5.85,364,1624291200"; 
   d="scan'208";a="181491613"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2021 14:32:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEPSJv2qEsWEgYFE/V2/P7wVLXVX5u20Vhe9d0JXpitrKIawFBZqlu2PwH+ua1MmzIy7RvPALnac52LIFyl7guieWoIAqivYnoT8GpqKUBuUuYWQjB/zfoQBpfjS3+2fShPj7vsf6phRRp9k1yPBk+WIFcLSL2PvVZW6cJunzDY3CHbQza8/YEpH3XHQHB+MSnmn/9osxc+5SiY/mt+VpaFe5zVtzf4wAFEAwjg5A0kYjFxxbIEEeTZrrxyJYylcn0mOh+m2d3GC7XEyCeNqq5ZBMnd0NhMQ69DdK8mx/UkRkUJZHBfdxrWs4nszI/bfmlrPCjUAqQzwxjVniRC1wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVdodr5UNEuIcuMCQbLewcKi1X0ZKnmrpwRqJxqKfM8=;
 b=DaUPzRnEXCBDc6s6P3h60YciML0RNWgbSRrZ92DZnI07KBIhNtiTVlOfP5g4tAzduke2UdNceeolu9IBAMY3dE0JpZd7b39jrjVMEk1yHWMp1AyGhJMttp5AHTIn1Z5kX/n9yNcZqu4iVeDGnXV73AteT6ciAJmkzZTbk1CX08Hxtci20+1WJ3cheQPUxwtFVGL95vGiRnzheWJGtVq0s+EuksJ2DWjmezLhzRrUEn0Nn8vvQnSjXrOFWgnQ4aH0FLlEONrJ9wf87rMzEwcvF3NUd6rxLMN+0mFBIgA/vl2V/24trdYS/1xu1YX7A7RMmQHtoqfCkU2W1jjOCxFegA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVdodr5UNEuIcuMCQbLewcKi1X0ZKnmrpwRqJxqKfM8=;
 b=lNDXLjeW5TQp/Hp/ri5B9AqCrJTEmULP0DXSLlyX6uPM/EoTlKygpMNjagpKIBQ5jbSJs6EWTQqAUYYGV8GyHn/jvnjApF7lNVsO3EfGAfCk45o3MeYYD6SCJNJLhN7Fn+SF7rBb6AKLtnS3Qz2HZelNp/vOD+kkA/TiD1VMCrU=
Received: from MW4PR04MB7411.namprd04.prod.outlook.com (2603:10b6:303:64::19)
 by MWHPR04MB1022.namprd04.prod.outlook.com (2603:10b6:301:45::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Mon, 11 Oct
 2021 06:32:35 +0000
Received: from MW4PR04MB7411.namprd04.prod.outlook.com
 ([fe80::8d9e:903a:90cf:516c]) by MW4PR04MB7411.namprd04.prod.outlook.com
 ([fe80::8d9e:903a:90cf:516c%8]) with mapi id 15.20.4587.024; Mon, 11 Oct 2021
 06:32:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Sven Oehme <oehmes@gmail.com>, Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: Host managed SMR drive issue
Thread-Topic: Host managed SMR drive issue
Thread-Index: AQHXsXGwJGr/oBwu5kOQfX1ME0hbsA==
Date:   Mon, 11 Oct 2021 06:32:35 +0000
Message-ID: <MW4PR04MB7411E69C4D7FDC0121FA159F9BB59@MW4PR04MB7411.namprd04.prod.outlook.com>
References: <CALssuR1Fpz=wXsCY6N+6ApU-1_tBzjj_==+3s2NOws9fPReYDw@mail.gmail.com>
 <CALssuR0D9r5_rXWsL1Qt4ouFdUQdrYY_VL2KMaNJ442bqHREsQ@mail.gmail.com>
 <20210928071002.jzm7e6ndm2qh6x4o@naota-xeon>
 <CALssuR3SQPev0f2GYo0s-w3pk-jP-GGPZiX2vx9597NQBW8gUQ@mail.gmail.com>
 <PH0PR04MB74162F06A2AD5D8379F2682C9BAA9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CALssuR1wcChWwLt1wVoxhf=ufWdKtBHa7FXn-m9mkJcpPGbfOg@mail.gmail.com>
 <PH0PR04MB7416408BFBD494211A4D86B69BAA9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CALssuR1JZqaBLf_aCMRLm683cww66wc_p+hgCpCENMiQkVoSRg@mail.gmail.com>
 <20211006154828.bqiwik2b6jaqxcck@naota-xeon>
 <CALssuR3UeNmx0PnwUT8ZR0bOd9iAGjvgmv9u8yfHDnfpChKb2w@mail.gmail.com>
 <20211007032239.iwrtygcavadvvb62@naota-xeon>
 <CH0PR14MB50764AC8659E9378C65D6DE8F4B19@CH0PR14MB5076.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 785dbab3-f670-4fb5-7ffc-08d98c80e9c2
x-ms-traffictypediagnostic: MWHPR04MB1022:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR04MB1022FAD59B74A690C6ADBBF59BB59@MWHPR04MB1022.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wayUsg7HwZave5M5bfwe/ip5fdRqUGZGrAGs+b4wVS2FnszYqH00GsyYjGx0/qTqWIy0jq7bBHSHY6aaGwpFROcpAswAU55OjFbEfWFHDct6GnYAr5GLb0kzub3RJf8sHIfelO5Qte56x+fLlD4WrtOCPBXRlP2dpNeJhui5HY1X2b5VpI09OSNK/zdI0482mAb/SdvfSnaJWbRAn1QQu+vIAW1DK+m4EftPoZ/U6PgW/ebDm+e//Y8iKLv/4+oxMmSJinnPXwF+uMKcHMRAesd0p0K8DpmpyMOH49P1zpCpqhrdLEa1LJ03iRKpmtBsF1uZ66nt9DHx2NUTpwy1UGZrxZ7DUjFQFw+/Rnd3NisNcwiRnWgbkQTFT+x33n87COn/DsWUQPRCc1I562QHZsHWaor12glqsPCfLkBZ3Oqd13qHdr9HWMLzYFZ+lASPDKyAPWDdSvs94yHe3k3rucJ8nMVi9gJmv0Uvi7JAplAJW5eFMhjS4cjCa9c14sH8r//+k0Az578em0XbgxS0DkyQN2HWsIOUZ/Bak5AW6V4ePGqzHlc2gMgSt/o5D8OZMOfptgz87tVHXbCESMUBnPF6OJN3L9RLaPQn8b6jIHIPEtg0Y9Os7EwGfNxBY7trGP6LzqJOMBaWZEl7KrmGPWzWtvD2p+WYjbGs2PGaiH6igXaAz19joEoE1xqC7xkpE055Wf0paCo4Obt8fXlQfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR04MB7411.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(66556008)(45080400002)(83380400001)(52536014)(2906002)(508600001)(66446008)(6636002)(64756008)(53546011)(186003)(5660300002)(122000001)(6506007)(38100700002)(66476007)(4326008)(55016002)(33656002)(7696005)(316002)(38070700005)(86362001)(91956017)(8936002)(8676002)(9686003)(76116006)(66946007)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D7RJ86plA0nVc1YzaM0QtyTWdXXuf1r0sNWwWlWlPpkSTxwLVhd30WNgrERa?=
 =?us-ascii?Q?JXCpywe3qQmBj5eKF4Z2ijS5Pmj1yCt+xiZ2IBNrE3MJuriH7VYukBovxdjC?=
 =?us-ascii?Q?STS0qeGKDL5kq+nDfvXyNilCYSnOESleXTe29f8Y87ZjnGBeH4m3JVT9EUKF?=
 =?us-ascii?Q?9EOruK9H7Po4NTxx8Vu70e/VSb+q1kiTL/HHYLwqjMlhepEip04QVGPHxa2X?=
 =?us-ascii?Q?2vL/+GsQaSp1ng8zMJ6qdAslZco4fb4vyb15ovHN4AnYcJu7Y9MK1qwOPyAy?=
 =?us-ascii?Q?PQbSOKDACmyQnIxq7OJ5AvWsfOyPbrvbikFOfNERKQDO8RKMp5zWrIUAyYjE?=
 =?us-ascii?Q?Mvel9yoLZef82gsBxKm3JxgaNSMTVhv3YT0beKx4R4RneFR1kef7bf2AT6K0?=
 =?us-ascii?Q?bAUXdv+ttYtjurdXPUSQalEiTA1LrqseOQhnfND78cel/BSOVhzZXmBD9GRp?=
 =?us-ascii?Q?vIbNWAgYsj72lE7T7ZEtKHDopKgveRuL936VLh5Ar+ezpztGI4jYSx/5H/c1?=
 =?us-ascii?Q?SSFPBdzfYANd6bG16c8JseE00tHmBIWgasCoXNorvQRuCU7u9woVd2WpNGqx?=
 =?us-ascii?Q?TorzdMHDvI+IllMfrdWByKUi/zb0LNOytckTqToaXxF+L9MhEsmeAD4UUJ7D?=
 =?us-ascii?Q?CHOnCFsEKr1SaZCiDd1z3rP2aIjZEPWPkqOpkPnnDwPvhLS8KLg+W7AnyclJ?=
 =?us-ascii?Q?XaJF5XRDTIDjjyH4K6MPFiolTVJpxOqzebUbm5SSP4lKTzYbGe8QLoZfOJtm?=
 =?us-ascii?Q?bl63g7FVNLrDqcksy73TemfqMoF+2FkSFkPfdzP5bWwvJqgAYRNusCf36Yvi?=
 =?us-ascii?Q?omjoH28AHE9bsAUJ98KMX5gJXqjmNUzlSDH6VAeVNaOBu347QihOuqa/s4Bk?=
 =?us-ascii?Q?GsVsbE3NYtJZ+ISat7nky+l5UF+j2wUTOb+YP9iMqmXQLaFfcLgDjVXZkiiB?=
 =?us-ascii?Q?PnvZ5tMi6eaO0nwFtmvhJT7JYIMSoPMlLBy+t2+P9XgTebk4VTYtyx+TE5Ds?=
 =?us-ascii?Q?VZnXU+fZNZazSvolHva7ZOZohmlGrYsznLiuWJkRd7f31ueFP/YxFvPCzT4j?=
 =?us-ascii?Q?NYqywL3j3iD1+0sa0P1645rka7jy0TZ7MVoVd64Cx2k9hNqSfnb91SCyflz5?=
 =?us-ascii?Q?678EK4l9Z0/lEuirgPn9cNeF3nVsRTteT+waVevEgXemlqQMjdUXAEE3Koeo?=
 =?us-ascii?Q?18vDKNphqk+QOvFg6JH5+i3RRGEcY1VJZ66F/NFKfrYJLtRGhseJFPMaeYUX?=
 =?us-ascii?Q?nMSKbAs+KL8SE+Np6wrz3lp/wmMXqAianDyi3ghAl3iHk9YNvBjU4c2vikin?=
 =?us-ascii?Q?XZCg2NiCK996wg00n4bjDebvgOW2bfLxPgJ6wNdP7o8K9kA52OQsLOxP1HTa?=
 =?us-ascii?Q?qvq3ovr10erCgZPQXWACxayo4pkcOHYmjF8DVtruTzJBaYxWTg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR04MB7411.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785dbab3-f670-4fb5-7ffc-08d98c80e9c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2021 06:32:35.0447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: niUgtRcqdjAKD9VxIS5wGy+KA/zuoz7bML/LujyAOeq4jRBFSE+zzbiBnhbIZvsnjTAngscpt79aAKprsgaaOl8gqW7chFLAJrNmTM5TQyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1022
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[ +Cc linux-btrfs ]=0A=
=0A=
On 07/10/2021 14:18, Sven Oehme wrote:=0A=
> Thu Oct  7 06:09:30 2021] ------------[ cut here ]------------=0A=
> =0A=
> [Thu Oct  7 06:09:30 2021] BTRFS: Transaction aborted (error -22)=0A=
> =0A=
> [Thu Oct  7 06:09:30 2021] WARNING: CPU: 8 PID: 73260 at fs/btrfs/ctree.c=
:491 =0A=
> __btrfs_cow_block+0x3d8/0x5a0 [btrfs]=0A=
> =0A=
> [Thu Oct  7 06:09:30 2021] Modules linked in: vhost_vsock =0A=
> vmw_vsock_virtio_transport_common vhost vhost_iotlb vsock xt_conntrack =
=0A=
> nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack =0A=
> nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user nft_counter rpcsec_gss_krb5 nfsv4=
 nfs =0A=
> fscache netfs xt_addrtype nft_compat nf_tables nfnetlink br_netfilter bri=
dge stp =0A=
> llc cuse overlay nls_iso8859_1 dm_multipath scsi_dh_rdac scsi_dh_emc =0A=
> scsi_dh_alua intel_rapl_msr intel_rapl_common amd64_edac edac_mce_amd kvm=
_amd =0A=
> kvm rapl efi_pstore ipmi_ssif joydev input_leds ftdi_sio usbserial ccp k1=
0temp =0A=
> acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler mac_hid sch_fq_codel nfsd =
=0A=
> auth_rpcgss nfs_acl lockd grace msr sunrpc ip_tables x_tables autofs4 btr=
fs =0A=
> blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async_memc=
py =0A=
> async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath =
linear =0A=
> ses enclosure hid_lenovo hid_generic usbhid hid ast drm_vram_helper =0A=
> drm_ttm_helper ttm crct10dif_pclmul drm_kms_helper=0A=
> =0A=
> [Thu Oct  7 06:09:30 2021]  crc32_pclmul syscopyarea ghash_clmulni_intel =
=0A=
> sysfillrect sysimgblt aesni_intel fb_sys_fops crypto_simd cec cryptd rc_c=
ore =0A=
> nvme mpt3sas ahci drm ixgbe raid_class libahci igb smartpqi nvme_core xhc=
i_pci =0A=
> xfrm_algo scsi_transport_sas xhci_pci_renesas i2c_piix4 dca i2c_algo_bit =
mdio=0A=
> =0A=
> [Thu Oct  7 06:09:30 2021] CPU: 8 PID: 73260 Comm: kworker/u98:0 Not tain=
ted =0A=
> 5.13.0-rc6-fix2 #3=0A=
=0A=
Hi sorry for the late reply, I've been to a conference.=0A=
=0A=
This is already fixed in current btrfs misc-next, but not sure if the fix i=
s =0A=
already in Linus' tree.=0A=
