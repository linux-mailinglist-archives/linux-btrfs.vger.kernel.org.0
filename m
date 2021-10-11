Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC098428AC1
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 12:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhJKKak (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 06:30:40 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34051 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbhJKKak (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 06:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633948119; x=1665484119;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=N/41uZdkvwrzUJeAX01PqUFqnweNBdpdy7eavoq2buI=;
  b=mVCBkZkQXQTH9rQAurYjaL33SWUaKHhzW2Bt0VoUlqn2VAbbYT/Xpm7s
   s/lnxf/l1Mo5bPH75H9u//KfCkgL+YnxxtdubvLB+H6VZBRU7t1nAiqk7
   /ZPPGcFbW6K4tcsu9ZgF9OUrOVVyFq5P1VEkDGQYtTIki1ASzPNvBTN9k
   uSQ9y7WOlghbwOA9jkAHwjFfuOMZJDNflRSJZEFY7y1ODDsrweNrxFt2X
   Ra/h0HJfc0eAyBRopq4mN5Qq8JY46L+maRvv2pqqqqO2yn2jiOvbreKQu
   mYEQwMsQXY6YeKqvT3btORdUxbAhO9xHf1ZNSWH9c5SV1HgJyaZrXgHTS
   w==;
X-IronPort-AV: E=Sophos;i="5.85,364,1624291200"; 
   d="scan'208";a="187255853"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 11 Oct 2021 18:28:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSFNVHOj7zljaSyIELcDV6oEQBNcO3QujMZ17G5MOPbilPhasW+fkc/moToPo8iwQZJ9bhK9njjeehkuFrwKYeHfFBZvizPBMqUEHOHlUrm1exwJ82+prM99uIbKeVQmmCxZPENSQLCsqKuTp/dpBxH7fmZ5klZn/aJnNNM8HnYdLh9U4C8X+YKSxAy19FBx9YDIEDsy/B4fHuYxl1MkXb5ZsjKxHsgOFksqmL6c4ZbvGeGwtkhMuT1QyT/nMqIcbucT3UBuDtG8VujabixDZzshCs5w2/sBAnQPU6eU1y0I84Fdrv0Rmzsxx/UjmZDdAzMufySXyjjnFEvuqbXW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7jxiXWSCQV+dtcsHxHuebAQQ76tzZogK90ABzqAqDg=;
 b=gsY+YpvVINQzdueyK4Mcc/45AKnkH2F8Fy3gn8rVsLc3s1T2URNBN3PYK03s4W9VI8XAkGdfy238XDerl6LIF5guv+L21R53GkluvumgrVkw/5hVFjVpHi/o9dl+AAyVE0BhXhCI7hPMbcZ5tM+FOtNKtGJRDZfIm9/x754UfzRCNIFl9MY4H5Ibz/TE3e7S/E5zwu2ciGXraQNi7/8N5ytXMEUU8BmYJ7FbUV+llI2ymXCRp6ZncWksFIU4pLxp61K7u5CVALzAjc/TlvxxdIVZrWD+aB1A7rVRMvnEiniYh2awO9Bhx2O88sTFzg7kxcIG/9wY4XzdSmdA14PIcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7jxiXWSCQV+dtcsHxHuebAQQ76tzZogK90ABzqAqDg=;
 b=L1sAKUaMmT7LQG8EaInCm5PxgnJvwo2/GWD2PwFuj+uIvk+9juQZCo4FYO/5K9fro2wOzuSiERTU47xFNzvfQW1bEoqMWWvjGz0UPdZURIqgi58vOa7CYxB679/8XTeHbMe0hphM8c7KoQkQRsTQSaTAfEI5CztkmEgxQ63S8Lc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7525.namprd04.prod.outlook.com (2603:10b6:510:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Mon, 11 Oct
 2021 10:28:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195%6]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 10:28:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Sven Oehme <oehmes@gmail.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: Host managed SMR drive issue
Thread-Topic: Host managed SMR drive issue
Thread-Index: AQHXsXGwJGr/oBwu5kOQfX1ME0hbsA==
Date:   Mon, 11 Oct 2021 10:28:38 +0000
Message-ID: <PH0PR04MB7416D33F5C5D2C3954F65C4E9BB59@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <CALssuR3SQPev0f2GYo0s-w3pk-jP-GGPZiX2vx9597NQBW8gUQ@mail.gmail.com>
 <PH0PR04MB74162F06A2AD5D8379F2682C9BAA9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CALssuR1wcChWwLt1wVoxhf=ufWdKtBHa7FXn-m9mkJcpPGbfOg@mail.gmail.com>
 <PH0PR04MB7416408BFBD494211A4D86B69BAA9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CALssuR1JZqaBLf_aCMRLm683cww66wc_p+hgCpCENMiQkVoSRg@mail.gmail.com>
 <20211006154828.bqiwik2b6jaqxcck@naota-xeon>
 <CALssuR3UeNmx0PnwUT8ZR0bOd9iAGjvgmv9u8yfHDnfpChKb2w@mail.gmail.com>
 <20211007032239.iwrtygcavadvvb62@naota-xeon>
 <CH0PR14MB50764AC8659E9378C65D6DE8F4B19@CH0PR14MB5076.namprd14.prod.outlook.com>
 <MW4PR04MB7411E69C4D7FDC0121FA159F9BB59@MW4PR04MB7411.namprd04.prod.outlook.com>
 <20211011102305.GC9286@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a94acd2a-37bd-4207-99e5-08d98ca1e36a
x-ms-traffictypediagnostic: PH0PR04MB7525:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB75258876C59772D2C1D781E19BB59@PH0PR04MB7525.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CM3hF7SvoWHQ1TWqFQIu2/o17rZcvynS4VrNDGWynhGcwGbrQGcmvHzDW8cEuUl1ph2KtTL27q4Px564dg59sTJwqUgNhwPDIvPiUAklynksm63DuFhgw673pn8sMPuCR0gzJZefOBLdcIAYaeCQqzqq6mI9weeATb61ij+72YDWizdNANzQHYmrsLk5d8O7gE3YTFz/LhNQDMjBaibuvLiu0IVDMftAzGNKs4Cn9rWuaXt5ZtVxZN5/B4jx6cCMWp8IrU6mwz1jrGlGnkdBBP2/5PhnPNAi84agN55SUvJuUEZdWvFLCqiYDBT8hOhKZ/95Jxppb3b4EuALUgQeZ55e4qA4UKJNFM7erNC7uRN4dGWkxJO9DkxnrH7DRCee+DO+H2n625iKpHISNB4a7I6W3BU0wHih2CWdUMld9bqHC/ntfgkmgonX2aD896lOrJ0w55Ez1RzPyg1etGnrKkNUgbxXCVNAL3fSrfI5RyQGtYav+eslkw25cfJLZ6OQWmg54yuqNEBk6u8ks3LU+2oQbaQ+wbhTpF7YQOTebX+8UiFWxHET3pQs7YjOK79lKWpTp6ge1Z2fjgB3xiopF87/Jv/w54/h84nD2QmQdLiWZybrf8FZZhbJX1Mn08mDNiu2V/MegPVBNPIrO0yJ9hEipxtw4qjNfAfdjgvNu5FeSt4dDKzjkZNQT0NNbN+PZOgb24vZqn4pFhrcLfTz5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(55016002)(45080400002)(38100700002)(122000001)(508600001)(38070700005)(7696005)(52536014)(8676002)(8936002)(5660300002)(91956017)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(83380400001)(86362001)(33656002)(54906003)(6916009)(2906002)(4326008)(186003)(6506007)(316002)(53546011)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?isyUwkmtIhq9cHyp+Qf8YpKgyLLq9EK6Q4kUlOKADr9fHu59B3TCzpsCwBdv?=
 =?us-ascii?Q?r/RpqmNi6YWB3D60l+rz4oIK8vqk9xYgelhtKOctH7Ri6nuX5HNSPY+Ck9iq?=
 =?us-ascii?Q?azQQxH0JtiPprxgM2183W+dgFMnCzdhWV5tRwjQJc2WPMPQkR93kHX4hVgOi?=
 =?us-ascii?Q?dZAL5AgwPHtFx5mc11pcCVCbkiVH72bbDUQ8XXvztUtgxn0v9HndTId1cS3x?=
 =?us-ascii?Q?ScT/eadzCUsL8vQsSFQsk21zsQpsxK2OSS/fyivbq3b+KcjNl2s+kZAWzDHS?=
 =?us-ascii?Q?rjepmnODrNWDXb0VLIkoVhDntthjvyF0KValncoDvf84xkBMBG5PYCfNbKra?=
 =?us-ascii?Q?Hq1qBAiz020Ld7hLtl2J6JkAW/gQlqxHbPaPIax9/ahLdudn6v4icwClQv2t?=
 =?us-ascii?Q?n4BOYlNhMdaiXDStvAeujnkxWxzsDw4H2nNGBQXs1XOTV8FJoWiOzrvuMOdn?=
 =?us-ascii?Q?qNHb1lOtquTTfkjmWH0e3e17ZUfX4FFD8gALLJ3ao74zSe1qP2bner5xD87h?=
 =?us-ascii?Q?/hZAz55rXRbOqxhucxHv62o8ylTe8BhcmvLF+qLCMclB3L4XTekS6s7MPEKl?=
 =?us-ascii?Q?/W06YS8XcGHNiVGrTj8RwU9WEs/Us2CJIJN2iEmdfkNoWvucOeyXNmrQyfRQ?=
 =?us-ascii?Q?RPGOHNuxQQ2NG1mNOC23hc0JiDGESMGj6FEXRyje04rSg30h39NSgZL5uyET?=
 =?us-ascii?Q?faMfYvc5cMaxoUDSS4ZYJ6cmz5oN5sPCKlIopoLhZ3spanmgHmCwRzNo0N/K?=
 =?us-ascii?Q?f4sjv54HwCpw2X1UEWuDI0eCDrtV1+CcZeTI6axekDMIw9RI5ANPdFJcf1tY?=
 =?us-ascii?Q?pgFeJO+EbOLRI4H2VQ13Vk15FOtN/CtJP7/hr2wutTwQm7f7ixnPkp90PEnq?=
 =?us-ascii?Q?rc/hBTUi3p5r9Wh4uBe/bEVkwdWJ611W6HYX7UpxMFH0nO0B052RrQ4uCFHo?=
 =?us-ascii?Q?qn2eI+ejqC4XTFTowP8bamnCW5rl1Ny+zT2Gnt5Zl0fKgWxS22fmcKXpqIFa?=
 =?us-ascii?Q?nnk9XzvTzkZEVQgm8aM8p3qcKCr3f+gnMH19+ZCJLP6ykXrHvqdPEZDTBa+E?=
 =?us-ascii?Q?5DSfcMX0660KM6BnVYsJWnLuSZbIwsykIcwS6tXY4Tv8mgrkXySNaX3o2Cez?=
 =?us-ascii?Q?RYKrqVsT5Ft5B6YSEDs4AQsWz9Y63cSooChPDojFodU75wAKFN/AOk2uM6FI?=
 =?us-ascii?Q?58KsPwMRYJPWnqg0vn3490b5TTVYtn6gLqkT6U+Zw/lwGK6Rg3TvWP/aFu+G?=
 =?us-ascii?Q?INS24X3qSn+I+s7VlfGoPySAbCDHoDGfpnyG6duXMW6x+u8eKLYeHLHuS0jr?=
 =?us-ascii?Q?0IRdQDxpf+suR/Cw+3N107NO/lGSxIFR7QvsrDq0MgsHdp8RxzAPIJyfanaD?=
 =?us-ascii?Q?FjlrpxzKq3mi/I05P0F/xDEmEjy0DwpGAf8mK0d8reptwm83cQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94acd2a-37bd-4207-99e5-08d98ca1e36a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2021 10:28:38.1140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W6m/SBV03MGSj3l6cuCQSRtneR1TNwXBLvsnHH0vV1V6LA338/Xdgkwhkk6Xp4fvfQAka29wdEBiBarn4xiAiCgKKSQJzMj1628mg9adBSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7525
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/10/2021 12:23, David Sterba wrote:=0A=
> On Mon, Oct 11, 2021 at 06:32:35AM +0000, Johannes Thumshirn wrote:=0A=
>> [ +Cc linux-btrfs ]=0A=
>>=0A=
>> On 07/10/2021 14:18, Sven Oehme wrote:=0A=
>>> Thu Oct  7 06:09:30 2021] ------------[ cut here ]------------=0A=
>>>=0A=
>>> [Thu Oct  7 06:09:30 2021] BTRFS: Transaction aborted (error -22)=0A=
>>>=0A=
>>> [Thu Oct  7 06:09:30 2021] WARNING: CPU: 8 PID: 73260 at fs/btrfs/ctree=
.c:491 =0A=
>>> __btrfs_cow_block+0x3d8/0x5a0 [btrfs]=0A=
>>>=0A=
>>> [Thu Oct  7 06:09:30 2021] Modules linked in: vhost_vsock =0A=
>>> vmw_vsock_virtio_transport_common vhost vhost_iotlb vsock xt_conntrack =
=0A=
>>> nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack =
=0A=
>>> nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user nft_counter rpcsec_gss_krb5 nfs=
v4 nfs =0A=
>>> fscache netfs xt_addrtype nft_compat nf_tables nfnetlink br_netfilter b=
ridge stp =0A=
>>> llc cuse overlay nls_iso8859_1 dm_multipath scsi_dh_rdac scsi_dh_emc =
=0A=
>>> scsi_dh_alua intel_rapl_msr intel_rapl_common amd64_edac edac_mce_amd k=
vm_amd =0A=
>>> kvm rapl efi_pstore ipmi_ssif joydev input_leds ftdi_sio usbserial ccp =
k10temp =0A=
>>> acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler mac_hid sch_fq_codel nfs=
d =0A=
>>> auth_rpcgss nfs_acl lockd grace msr sunrpc ip_tables x_tables autofs4 b=
trfs =0A=
>>> blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async_me=
mcpy =0A=
>>> async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipat=
h linear =0A=
>>> ses enclosure hid_lenovo hid_generic usbhid hid ast drm_vram_helper =0A=
>>> drm_ttm_helper ttm crct10dif_pclmul drm_kms_helper=0A=
>>>=0A=
>>> [Thu Oct  7 06:09:30 2021]  crc32_pclmul syscopyarea ghash_clmulni_inte=
l =0A=
>>> sysfillrect sysimgblt aesni_intel fb_sys_fops crypto_simd cec cryptd rc=
_core =0A=
>>> nvme mpt3sas ahci drm ixgbe raid_class libahci igb smartpqi nvme_core x=
hci_pci =0A=
>>> xfrm_algo scsi_transport_sas xhci_pci_renesas i2c_piix4 dca i2c_algo_bi=
t mdio=0A=
>>>=0A=
>>> [Thu Oct  7 06:09:30 2021] CPU: 8 PID: 73260 Comm: kworker/u98:0 Not ta=
inted =0A=
>>> 5.13.0-rc6-fix2 #3=0A=
>>=0A=
>> Hi sorry for the late reply, I've been to a conference.=0A=
>>=0A=
>> This is already fixed in current btrfs misc-next, but not sure if the fi=
x is =0A=
>> already in Linus' tree.=0A=
> =0A=
> Which fix is that please?=0A=
> =0A=
=0A=
The series from =0A=
c4153d4049f2 ("btrfs: introduce btrfs_is_data_reloc_root")=0A=
to =0A=
98e467cfa9c2 ("btrfs: zoned: let the for_treelog test in the allocator stan=
d out")=0A=
=0A=
As far as I can see they're only in btrfs-misc-next as of now.=0A=
=0A=
But I think the series is a bit too big in terms of code change to go into=
=0A=
5.15 this late in the cycle.=0A=
