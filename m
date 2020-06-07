Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526D51F0C77
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jun 2020 17:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgFGPlL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jun 2020 11:41:11 -0400
Received: from us-smtp-delivery-177.mimecast.com ([63.128.21.177]:59270 "EHLO
        us-smtp-delivery-177.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726610AbgFGPlK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 7 Jun 2020 11:41:10 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jun 2020 11:41:08 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=exactearth.com;
        s=mimecast20170822; t=1591544467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=We1zrLoUJALjTTPzbtDzbw0LWKZGoexUB9B45JKOi0I=;
        b=l4lw6Nb44f9hfo9gQq5yWan58ZyJFgMiMCfqf23IZpoT54aa3C6qIma/ptZ8oVvL4KAGLy
        7kUMETFBUVVcmcV2uc4Y5zCF133prIjE0NXFwBnvk3A4mNsuUayQmf5kQKnjmJJGDixRFx
        ax+1vkXYZvtmObEUloCeWVqdqNdQp/E=
Received: from CAN01-TO1-obe.outbound.protection.outlook.com
 (mail-to1can01lp2050.outbound.protection.outlook.com [104.47.61.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-CEkHzAstPbeBIsKj0LH5LA-1; Sun, 07 Jun 2020 11:34:29 -0400
X-MC-Unique: CEkHzAstPbeBIsKj0LH5LA-1
Received: from YTXPR0101MB1902.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:d::20)
 by YTXPR0101MB2239.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.23; Sun, 7 Jun
 2020 15:34:28 +0000
Received: from YTXPR0101MB1902.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5426:ece9:d50a:66ba]) by YTXPR0101MB1902.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5426:ece9:d50a:66ba%6]) with mapi id 15.20.3066.023; Sun, 7 Jun 2020
 15:34:28 +0000
From:   Walter Feddern <Walter.Feddern@exactearth.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Help with repairing BTRFS system root volume
Thread-Topic: Help with repairing BTRFS system root volume
Thread-Index: AQHWPODlm0qfoM50FkacHV8sdoMKAw==
Date:   Sun, 7 Jun 2020 15:34:28 +0000
Message-ID: <YTXPR0101MB1902BC1A12C18F9670DA3EBFF9840@YTXPR0101MB1902.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [99.255.88.102]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93100195-99d5-4cd4-c05a-08d80af843f7
x-ms-traffictypediagnostic: YTXPR0101MB2239:
x-microsoft-antispam-prvs: <YTXPR0101MB2239EC01FDF56FC21F3DE9C1F9840@YTXPR0101MB2239.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04270EF89C
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6T1OvX0YgyhsmtTna5C/011vi4eQ3wQz3rbfSo4iIGg+z+eBcCxzMDJUWREH52VLkeOs5gCH5/nJH953GqXoVOCb+54PhGA/Y4NNVewujOyZrknaHpvPUy45hMnDmLvHc+kFpUZel/5vTiR/AdLPDlsDAKTeoOGUdZl+/pqsTwM2Btxe/XUkrCGJZD6Exz9tiZ1n7daRMDSlE0tEpjkEHY7BOW1by+VSwMH84Zhcikah3RzgytruKmFaVAWjca//gAnFpCOWrDQPQH+usa5GnP0iskMT2QZeKmwP+N22DNOa+qRyqQTt+eoTZddfrT5rdylo1hB8HyDHq19D1V+qgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YTXPR0101MB1902.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39830400003)(376002)(396003)(136003)(346002)(316002)(508600001)(9686003)(83380400001)(66946007)(66446008)(6916009)(55016002)(66556008)(64756008)(66476007)(76116006)(7696005)(33656002)(5660300002)(6506007)(8676002)(52536014)(26005)(186003)(2906002)(86362001)(8936002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: pTJlo+6OxnMafyHHXJK/C27y+p9JSNzVVwkWdKzRo/WMj3UaFn9MkaCMsAK0t7MfyWZPsqhclSNwqfpVVULCkaawkwTjp1gGCcOcArjxgCS+GI99Gx9PWozu7626znWKH9xv3F2bARlSU73Tbn7bcQ0H0Pn3DRAeHTkrNoDGYLG1/s7+aA+HaFyRRI/RJ5nLAuylqclD4ryLY6h9fwFxEGQhlZhurnbCIqCDdi6rwGPMgr/DxoRwEw1XN5w6PiqioGo+AAxl26476/TiKsY0/378YHEEu/+mBIp4qeNO+hpnpMMQIhnY+iiR/Pu67SfjeoFxFnc55WdVIv90s7KbjeQknWue87CbKwCichquu8Xw8pmDXL3GHawHBBpBJwKhge0CuOAZShSC8tQKUGjHllYuRySlcKg3r1pXbquk3tm285IPCUyD+KncyCXOdVinXFnp/CDuwRQsRdOg2B166+SYiu9G3+gOT2gKYwyBF2I=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: exactearth.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93100195-99d5-4cd4-c05a-08d80af843f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2020 15:34:28.1022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d7f8dc13-764b-415a-9104-adcbe2da14b6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wjnbWUe+Y3vEdbCK/H7LKtHvnJrcCjMQy/l3uv113sPotZ1U1nuF/hMWmJ7yI1fFMKFQoH3litcIdo7hz94R35/K/jn6taN9RlsjtLrb2PI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB2239
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: exactearth.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a system that is running opensuse (42.3), that will now only mount i=
ts root file system in read only mode.

I know this is an old opensuse, which means old kernel and btrfs version, b=
ut it was required by a third party to run a specific software package.=C2=
=A0

This is a VMware virtual machine, which gives me the luxury=C2=A0of making=
=C2=A0a clone and performing repair attempts on the clone.

Here is some info to start:

# uname -a
Linux CDCESASCOSO 4.4.180-102-default #1 SNP Mon Jun 17 13:11:23 UTC 2019 (=
7cfa20a) x86_64 x86_64 x8 6_64 GNU/Linux

# btrfs --version
btrfs-progs v4.5.3+20160729

# btrfs fi show
Label: none uuid: d3c0c1f3-a750-43bf-8126-a3078736fc81
Total devices 3 FS bytes used 62.01GiB
devid 1 size 17.99GiB used 17.99GiB path /dev/mapper/system-root
devid 2 size 20.00GiB used 20.00GiB path /dev/sdc
devid 3 size 40.00GiB used 40.00GiB path /dev/sdd

Label: none uuid: cc89ca31-e61b-4cc1-8b9a-7809f4d34e65
Total devices 1 FS bytes used 61.38GiB
devid 1 size 2.10TiB used 86.02GiB path /dev/mapper/vg_data-lv_data

Label: none uuid: cae3256040c8-461d-8a9b-66d6507afe6c
Total devices 1 FS bytes used 59.03GiB
devid 1 size 100.00GiB used 60.01GiB path /dev/mapper/vg_archive-lv_archive

# btrfs fi df /
Data, single: total=3D75.95GiB, used=3D61.17GiB
System, single: total=3D32.00MiB, used=3D16.00HiB
Metadata, single: total=3D2.00GiB, used=3D866.34MiB
GlobalBeserve, single: total=3D180.48MiB, used=3D0.00B=C2=A0

Don't have network running, so I just did the tail end of dmesg that seems =
relevent=C2=A0(may be some typo as had to take image of console and OCR it,=
 could not copy/paste)


(Sun Jun 7 14:32:25 2020) Workqueue: btrfs-extent-refs btrfs_extent refs he=
lper [btrfs]
[Sun Jun 7 14:32:25 20201 0000000000000000 ffffffff8134c867 ffff8801393e7b5=
0 ffffffffa034f022
[Sun Jun 7 14:32:25 20201 ffffffff81086c01 ffff88013942c418 ffff8801393e7ba=
ll ffff8800ba87b840
(Sun Jun 7 14:32:25 20201 0000000000000000 0000000000000114 ffffffff81086c7=
c ffffffffa03526d0
[Sun Jun 7 14:32:25 2020) Call Trace: (Sun Jun 7 14:32:25 2020] [<ffffffff8=
101b0c9>] dump trace+Ox59/0x350
(Sun Jun 7 14:32:25 2020] [<ffffffff8101b4ba>] show stack_log_lvl +Oxfa/0x1=
80
(Sun Jun 7 14:32:25 2020] [<ffffffff8101c2b1>] show_stack+Ox21/0x40
(Sun Jun 7 14:32:25 2020] [<ffffffff8134c867>) dump stack+0x5c/0x85
(Sun Jun 7 14:32:25 2029] [<ffffffff81086001>] warn slowpath_common+0x81/0x=
b0
(Sun Jun 7 14:32:25 2020 [<ffffffff81086c7c>] warn slowpath fmt+Ox4c/0x50
(Sun Jun 7 14:32:25 2020] [<ffffffffa02a7132>] __btrfs_free_extent.isra .68=
+0x2a2/0xdell [btrfs]
(Sun Jun 7 14:32:25 2020] [<ffffffffa02aa822>1 btrfs_run_delayed_refs.const=
prop.78+0x342/0x1360 [btrfs]
[Sun Jun 7 14:32:25 2020] [<ffffffffalZafa56>] btrfs_run_delayed_refs+Oxf6/=
0x1f0 [btrfs]
(Sun Jun 7 14:32:25 2020] [<ffffffffa02af bd9>] delayed_ref _asymc_start+0x=
89/Oxall [btrfs]
(Sun Jun 7 14:32:25 2020] [<ffffffffa02fad27>] normal_work_helper+Qxd 7/0x3=
70 [btrfs]
(Sun Jun 7 14:32:25 2020] [<ffffffff810a@a9b>] process_one_work+0x15b/0x460
(Sun Jun 7 14:32:25 2020] [<ffffffff810a1676>] worker_thread +0x116/0x4c0
[Sun Jun 7 14:32:25 2020] [<ffffffff810a6d54>] kthread+Qxd4/Qxf
(Sun Jun 7 14:32:25 2020] [<ffffffff81653005>] ret from fork+Qx55/0x80
(Sun Jun 7 14:32:25 2020) DWARF2 unwinder stuck at ret_from_fork+x55/0x80
[Sun Jun 7 14:32:25 20201 Leftover inexact backtrace:
(Sun Jun 7 14:32:25 2020] [<ffffffff810a6c80>] ? kthread_park+0x50/0x50
(Sun Jun 7 14:32:25 2020] ---[ end trace b467872b3b221ce6 ]---
(Sun Jun 7 14:32:25 20201 BTRFS: error (device dm-0) in _btrfs_free_extent:=
6983: errno=3D-117 unknown
[Sun Jun 7 14:32:25 2020] BTRFS info (device dm-0): forced readonly
[Sun Jun 7 14:32:25 2020] BTRFS: error (device dm-0) in btrfs_run_delayed_r=
efs:2990: errno=3D-117 unknown
[Sun Jun 7 14:32:25 2020] BTRFS info (device dm-0): delayed_refs has NO ent=
ry
[Sun Jun 7 14:32:25 2020] systemd-journald[726]: Received request to flush =
runtime journal from PID 1
[Sun Jun 7 14:32:25 20213] fuse init (API version 7.23) [Sun Jun 7 14:32:26=
 2020] vmxnet3 0000:0b:00.0 eth0: intr type 3, mode 0, 5 vectors allocated=
=C2=A0

Thanks in advance for any guidance.

Walter Feddern
Senior Systems Administrator, Programs and Operations | exactEarth Ltd.
260 Holiday Inn Drive, Unit 30, Building B, Cambridge, ON N3C 4E8
office. +1.519.622.4445 ext. 5880 | direct: +1.519.620.5880=20
email. walter.feddern@exactearth.com=20
web. www.exactearth.com

This e-mail and any attachment is for authorized use by the intended recipi=
ent(s) only. It contains proprietary or confidential information and is not=
 to be copied, disclosed to, retained or used by, any other party. If you a=
re not an intended recipient then please promptly delete this e-mail, any a=
ttachment and all copies and inform the sender. Thank you.

