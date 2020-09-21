Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901B92728BB
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 16:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgIUOpS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 10:45:18 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:46029 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbgIUOpP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 10:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600699515; x=1632235515;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WfncFfRxNrEa09YkfsnJG9rGRFIG17eYY3mpWiM4Cd4=;
  b=l9wXnMomqhs3hePmPK2iAg1WvMJfL5YajROONONDFi/nM3WUDqbtU+LB
   KJRN5jWg3GTIts7PfwymB/Z+DhfFNnyTVMbDamGyakhX2/4TazjOF3Snd
   vNk97NmvQsqiAKYhqk7jagY4/jH8vF5U/QsLV/jD/Vemh5Nq/jGSCdNeG
   b/8aFfDGuOhWAl1gLlrBDuVQdxc6WyNWo29rI2j9ZQ8fSs3XAlxRxep9m
   i8H/MVLA7sJgi27QuCtIuc7YR9X00m0RYaKMJL25Hptm+OLYcj+5zTX0W
   2ULciwlVagp6gVmwb4OLXisI1Qsl/WTiQcfi4jjde99GCxzy3j2Wrevdw
   w==;
IronPort-SDR: FcJfUsCg9rb9I58TRr+36KmxwLZ90UgDA48awb6eWVPxkVIyFHaXae/5JG2AePbuEl1vyKeX17
 vS1uz71e8xT2XDwpgGbeTFr2VRfJT/01zkiqDDMFAd7WQct+HLjCqevGtF2RGvOsWdaNY8s7rm
 WDkGB3nN3EPi2mYozoquCLJaq8WTsF3MksCANTyFfdzcK7+i6LnqjW2OtoZu5hO9tpu1aAdfS/
 57xQ4sHMC7afP0CGiDIRsDKMjXAf1JrRWUaHohxSjy6YDGonVimMWwiIGtCn5DoajZoFrg14NW
 t1M=
X-IronPort-AV: E=Sophos;i="5.77,286,1596470400"; 
   d="scan'208";a="149130760"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2020 22:45:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=io/hNERpyYXcBV8FCUYXOTw6HgE3Ux+e0/P5u1P/PKJAgC45oPNR6xzVxvDUOC7iZwZ/6ruBjUcHVlDtVZpVj28swtxMN6pyHMpCQHYoE+3it6iloExoaVxNx2GeWgzTSbcMSeNYcMaMBKV3ta5EfAoy8grgvb2kGeqzpvwVNenLbKFoI8EeI8QNLayCqHI1v6ZNevFGzzxY94b4xTZafA27ldGIcCWWU4n3fNGQHCuz1RPSOZTMx+Ji6dR5Y7K0f9DQaowWfDYWCLEx3OdpkHvbuMqd3IysXKppVDAg/IaJc0FqUcorQTLifdBnnTP02HCh6c/2YD1ycn8QYi463g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NP8W/TYFyAuVwntbzLDDg+nOW4wowiKKOuxc2+5KhUk=;
 b=VtUTbPOfupvpydyXzDy+TzHyrqEseadypvmOt5w4jS2lzN2TYQ/XW469NLeygmZ8qROPRMvb2kbVDFwAWiiQ6dDH5/k8vwIXz8bggCY11QBLiMF7LB2MKRnAQI60XY7/dLyIiAtGF2Jz7TOVfS7JjQ/k+7aMAAML8wlRoEhsWmQxZxmCtg01g6Xh2Pl+nelpuBMPBxHay41Vb4AVbdNRWscds85Z8Kc7CefN0WNdkX7+TdA6pzLVK6YjVJRxPN5K5fHmdQvul4W/sLI4gCjwATMrhwBtOv8x9narvJwIuPCmogwpyZDImYdPH8QtV2GlzZYOrXdzHOCu0JzcYcq6og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NP8W/TYFyAuVwntbzLDDg+nOW4wowiKKOuxc2+5KhUk=;
 b=oJgeoNhZwdqkTVWYrDWNnjgy0oU8VUa17VfRYGlwxnHsTf06i2rzLpiuZmnX6KxOnbv98GyyqO7g5rxIzVDkPV6ooaK/kt12K3jFUtxPGw8dqlCwvWrTGvuxVQoGZamNdGQDevrEg9O95dzOUz1Y1HeTol4X5+/Gylc3+NFUWKo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4320.namprd04.prod.outlook.com
 (2603:10b6:805:3c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13; Mon, 21 Sep
 2020 14:45:11 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.033; Mon, 21 Sep 2020
 14:45:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     syzbot <syzbot+1d393803acac53c985a0@syzkaller.appspotmail.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: stack-out-of-bounds Write in read_extent_buffer
Thread-Topic: KASAN: stack-out-of-bounds Write in read_extent_buffer
Thread-Index: AQHWkCQKrUkTRm/7FEWwoAj5oIcViw==
Date:   Mon, 21 Sep 2020 14:45:11 +0000
Message-ID: <SN4PR0401MB359806224B7D96A1CAB927A39B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <000000000000df277105afd3b70e@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: syzkaller.appspotmail.com; dkim=none (message not
 signed) header.d=none;syzkaller.appspotmail.com; dmarc=none action=none
 header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5e761dc-a34e-4fe9-1e0e-08d85e3cf175
x-ms-traffictypediagnostic: SN6PR04MB4320:
x-microsoft-antispam-prvs: <SN6PR04MB43203F458ECB33FA7D3EA7429B3A0@SN6PR04MB4320.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qta+oYpQZPwc7iEG1ILieuDKLrO8bAbWT4/gV/ClF/fUdTdd844fQD2LNtulzVrRk+fJFoIl4v4+ma4pXb+8uL37IusErIYv4phoCei7onhENSqKSGOiGHEsdhxglRXeBgkxmhAYAyXmRz9e3SAJRpYecGaiypOkj9d3Q9hHVWfDzhR2q8Pvo0AA6fce7j5HqeZMYVKb7+ay8sxc58170ntbcBqiKrIdntLeIiEHD6zB3l2tv50K6xciJIIQvWMDeLUsaAFSE4R9ly9xXya7HO7ITvMLwcV9hGS2U6cHic9aRNCSnAnrdmjaQjfZF3rhbdrCDnHVLqGzBx4XciklaC/XN8vqDA2f46saaAF9rIth1ORmHOPC1rBgA6F/jxc/usAA4tlyBZpP/MWlzVdyLm8GKMFjBdkd1Elgyd4wCMniRnKzEHT+ZHc7o9JK/2xEs+FHSwe2f052/jY2SrRO/WK1416lZ89rqdk9+53N9Lw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(64756008)(53546011)(66446008)(83080400001)(66556008)(66946007)(66476007)(76116006)(8676002)(2906002)(7696005)(966005)(8936002)(52536014)(5660300002)(6506007)(478600001)(83380400001)(9686003)(71200400001)(186003)(33656002)(86362001)(91956017)(26005)(110136005)(316002)(55016002)(99710200001)(505234006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FX/UzcfTGILFy2h/Iy1rjFPqqqQzMtrcin92JVkdOO14kb96TfOIkzyZ1qh5R1khi6w4j3APoFyKXuKtK3Qmnt3PbFBVDrn+uO141goiLfd9NtKcC4JwngKNC+9vSK0iQDkwCj5zoVyN2XsH7/gub3oTSzmEKds3o+VlX4vPAEXcyxEKa7WsJDqqv38z/fbIFuAORycn9v/43olAgz9/KA+awqZa3MUTmiGVUraF+ZalBLwfkJsXcDj0gJ81VpaNkVMfg7tfuNcJDbYzTLjQnJ5ccd/pr/X6tHZoBfMK+7VSv66acMyr/zkHUl4tC4tIcGAYJQVIITXkOft4GdOQVR9QKK9NqD6JtmycZKQNBmTZYQRdZ2Owc4+diamSU79Vg+kSxRSGhDXrl4PQ5UTLleQnBlloDRqyO9NR1MCWOcF4Um42kUhLgOzOZxUCd3cut9gZYF4K+zJ0Lv9s/SzhobYsJ55U2C36TqIUBWAavSBkSvs0EjbYs2gtlFV6lBFULjH7jtn1Cg71lbctq0JJ+vYN0zpe08I0PDEIKSgGdQ+6e8bvX40YsL56UI5HuroYCnhwB8Dw/ZhYG6TH8YzJ8T++qaiLW38ro5p7OX6k/Gqlid04NGRPabuvswLtX4TJx77PjX4AuQ2BtoUVB+bOvg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e761dc-a34e-4fe9-1e0e-08d85e3cf175
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 14:45:11.4078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3JUIxcGkW3eCGcBfDvUi5UqKufHVP7gK1pxOTkCUQddyafk2mA6ZNsL6mG/PaAxLZTUzOH/K1IFAqbvRRhQxNT0YawWwZbXp+eSlQ1pmPeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4320
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/09/2020 16:32, syzbot wrote:=0A=
> Hello,=0A=
> =0A=
> syzbot found the following issue on:=0A=
> =0A=
> HEAD commit:    860461e4 Add linux-next specific files for 20200917=0A=
> git tree:       linux-next=0A=
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D141fc5d990000=
0=0A=
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df2392812d6c63=
d5c=0A=
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D1d393803acac53c=
985a0=0A=
> compiler:       gcc (GCC) 10.1.0-syz 20200507=0A=
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D16778b07900=
000=0A=
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1216f8ad90000=
0=0A=
> =0A=
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:=0A=
> Reported-by: syzbot+1d393803acac53c985a0@syzkaller.appspotmail.com=0A=
> =0A=
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
> BUG: KASAN: stack-out-of-bounds in memcpy include/linux/string.h:399 [inl=
ine]=0A=
> BUG: KASAN: stack-out-of-bounds in read_extent_buffer+0x114/0x150 fs/btrf=
s/extent_io.c:5674=0A=
> Write of size 8 at addr ffffc90000dd79f0 by task kworker/u4:1/21=0A=
> =0A=
> CPU: 1 PID: 21 Comm: kworker/u4:1 Not tainted 5.9.0-rc5-next-20200917-syz=
kaller #0=0A=
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/01/2011=0A=
> Workqueue: btrfs-endio-meta btrfs_work_helper=0A=
> Call Trace:=0A=
>  __dump_stack lib/dump_stack.c:77 [inline]=0A=
>  dump_stack+0x198/0x1fb lib/dump_stack.c:118=0A=
>  print_address_description.constprop.0.cold+0x5/0x497 mm/kasan/report.c:3=
85=0A=
>  __kasan_report mm/kasan/report.c:545 [inline]=0A=
>  kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562=0A=
>  check_memory_region_inline mm/kasan/generic.c:186 [inline]=0A=
>  check_memory_region+0x13d/0x180 mm/kasan/generic.c:192=0A=
>  memcpy+0x39/0x60 mm/kasan/common.c:106=0A=
>  memcpy include/linux/string.h:399 [inline]=0A=
>  read_extent_buffer+0x114/0x150 fs/btrfs/extent_io.c:5674=0A=
>  btree_readpage_end_io_hook+0x7de/0x950 fs/btrfs/disk-io.c:641=0A=
>  end_bio_extent_readpage+0x4de/0x10c0 fs/btrfs/extent_io.c:2854=0A=
>  bio_endio+0x3d3/0x7a0 block/bio.c:1449=0A=
>  end_workqueue_fn+0x114/0x170 fs/btrfs/disk-io.c:1696=0A=
>  btrfs_work_helper+0x20a/0xd20 fs/btrfs/async-thread.c:318=0A=
>  process_one_work+0x933/0x15a0 kernel/workqueue.c:2269=0A=
>  worker_thread+0x64c/0x1120 kernel/workqueue.c:2415=0A=
>  kthread+0x3af/0x4a0 kernel/kthread.c:292=0A=
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296=0A=
> =0A=
> =0A=
> addr ffffc90000dd79f0 is located in stack of task kworker/u4:1/21 at offs=
et 48 in frame:=0A=
>  btree_readpage_end_io_hook+0x0/0x950 fs/btrfs/disk-io.c:201=0A=
> =0A=
> this frame has 4 objects:=0A=
>  [48, 52) 'val'=0A=
>  [64, 80) 'fsid'=0A=
>  [96, 128) 'result'=0A=
>  [160, 192) 'found'=0A=
> =0A=
> Memory state around the buggy address:=0A=
>  ffffc90000dd7880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
>  ffffc90000dd7900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
>> ffffc90000dd7980: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 f1 f1 04 f2=0A=
>                                                              ^=0A=
>  ffffc90000dd7a00: 00 00 f2 f2 00 00 00 00 f2 f2 f2 f2 00 00 00 00=0A=
>  ffffc90000dd7a80: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00=0A=
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
> =0A=
> =0A=
> ---=0A=
> This report is generated by a bot. It may contain errors.=0A=
> See https://goo.gl/tpsmEJ for more information about syzbot.=0A=
> syzbot engineers can be reached at syzkaller@googlegroups.com.=0A=
> =0A=
> syzbot will keep track of this issue. See:=0A=
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.=0A=
> syzbot can test patches for this issue, for details see:=0A=
> https://goo.gl/tpsmEJ#testing-patches=0A=
> =0A=
=0A=
#syz test: git://github.com/kdave/btrfs-devel.git misc-5.9=0A=
