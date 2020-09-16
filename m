Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BC426BF9F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 10:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgIPIpi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 04:45:38 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:16467 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgIPIph (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 04:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600245936; x=1631781936;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3sFJ6uUg18+wlOlRlnb48vvNRuVw22lTmEB6Om7+Hzs=;
  b=OlKB5MffiYijCpP5Hxc/9bSU1H9Kewx2HlgDkh79IKhXdKl3qvi2Ro65
   MlFHn9hgUpHlBPnEnyGdjekfboaKwRHMViS3iU2hYy3FkkQAZMTmxr/c2
   XyoGJmnicm2D0m7Z3R/lf8sXJEan7ZbgV70uaW5OYCo1F+f5cOh1JSVlZ
   2EYkVbWvEox0fHm9oPM2QW0Kw+c9qzRWgIU+Ao81QUlX6NTRJ187hEF/G
   9646NlHmEfzcSdbO44CWM75kN7bZmFzO6gAUAmb4QYSFpPrakWqDv2v6c
   G//NNAR7cFNQPISMJl4hU6SaDve80QaBSdqw6t58pCNw1ujz1gjAouDId
   g==;
IronPort-SDR: ODfo5XAyXE5GaYR5sbGiT1eeVj7TSbpY8Vk94vMsXe16DtGTSG4ZaeXynAO4rp/m6kAJrjsvay
 lGz96P5dqUxyC1gmfXr5JNQyLOiheUbBIWMqJNNpjyKO2OnhkS/9a95kN58kaqcxp5NQJ3m3bp
 Oq2Y3mQQOjufd8Fpk9BMy0WRuaEKzT3Bno5GI/LX9F0QbVOwBweh9kJ5WwbawQ9TN9braufxJx
 kMgNS6FJCJlULW8Kf6PrAEtOLI7pLCicOvWQQYj06ohGXgJc5pnKZukVwibmJ4vJCq7psnaVnB
 Hc8=
X-IronPort-AV: E=Sophos;i="5.76,432,1592841600"; 
   d="scan'208";a="147425569"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 16:45:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvKOWLMydPMvks/wKtBaePnFiGrem/FQWH08UwuDBjz4Ijw6lCOApV+lrQCBPvZwY6AFRwno93SLGQOKqxDBzatZ3UiiTh5eChjOThVUhkoo8Ge4hqGzPLt2i6aF349zvNpsESGTIvQFTm8kxbN5i1vWp6/Dr6fiQCH80Z9H9a7RmP8xBBaQCpDidUq+5CU98S1nWQIzfCK9gsRpNPAa3LQlxKRSjrumfTpRLb66l9YxGy0jtpytTruki+skaaQqZM1mRcK/+E9ouE/i8CjDLiQULCcx0gbwF19WoUfdrqaVBu2OrDhobLTAcYr40nMFyXa++F7GEWFY9Io+Ur+biA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECzUTV3f3s/tPjGfWOPvKdy3OEUcoXMtx0nU477w7Ws=;
 b=JewUVp4XHsKv9upBVUb/p+8dQXN6ncYJ2rrW5f/9HoB0XmsZ6XZlL+3yEPgBBVytaPJoBPsKscG5fHe3b1g/iJhNQM1hMOr619I6qxEfmoqw8XOX+sowar3+gsuFTHvhZYku8u29w4iPIg/aOS3bcGeeig5pvBdfJOTubeJzPwmP5wNCvzXM8hXRFl13K/mHnGAO2aVOQCKe+Tuoju/FdhNTghRZXNm1QgCZ8YwQt3siuSTA27d3Wk+ZIXUrw2NATua1YbRPMnUtbmAiiXp4J/AGx35Cgw/Mcb33kal0arYZkCBNTFl2MQcdZHbgR5C81r0wcxDZ0xbRoWzfFgWyxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECzUTV3f3s/tPjGfWOPvKdy3OEUcoXMtx0nU477w7Ws=;
 b=T70L/CjwSWQUw6v/ltazwNzjm/sVQoSPB0KpTd4VpIXew7HJd7xg4Kmb7ZcQWgudOK+URpYVNjIrPg6vFXWdsa3lMrdTD0VE59hNFLNJEma/8Rtltkg1HcCx2017Oo10Ju7bWkspA6w42JrolDJKdC+nhBfQ60taHQ2I+sQLPGY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5118.namprd04.prod.outlook.com
 (2603:10b6:805:9a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 08:45:33 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 08:45:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     syzbot <syzbot+e864a35d361e1d4e29a5@syzkaller.appspotmail.com>,
        "anand.jain@oracle.com" <anand.jain@oracle.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: kernel BUG at lib/string.c:LINE! (5)
Thread-Topic: kernel BUG at lib/string.c:LINE! (5)
Thread-Index: AQHWi1Aw47gymd3CJ0Ciy/1hIPgGyg==
Date:   Wed, 16 Sep 2020 08:45:32 +0000
Message-ID: <SN4PR0401MB3598381B90F2B10586B8005A9B210@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <0000000000000bcff305af69ecae@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: syzkaller.appspotmail.com; dkim=none (message not
 signed) header.d=none;syzkaller.appspotmail.com; dmarc=none action=none
 header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:38cf:f1ce:e1ec:d261]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e98b1e9-0597-4665-c9f4-08d85a1cdf83
x-ms-traffictypediagnostic: SN6PR04MB5118:
x-microsoft-antispam-prvs: <SN6PR04MB5118FDD8B301ABEF9895029D9B210@SN6PR04MB5118.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yJ9yV4d/BSXAVpGOLjNUNHlUKnNzSWDmfHwzKEvyEvP7MEZDUZO2/Q5GM+ZiLBTXZvxIHBOvWtd9YnAZH/hRQR/b97qE4tBF1N4n+G/R6npjQEiAXy/gkmUYkeqiet4gOTU76W5DXg+rt7QPLXDLrGz6p0ntqEg4NMTA/745CsLquNx7ymv+vslOYATbrmbXtDL7qmk6RmripQD4QblQZjc7tEvUaW4qLnef9LLs+Ns1lNwPAicjgjlUBSy0OhGJaFJM96OoyXLm7eIQtqoEE2ikC9NCyP8EgPYLIs+rtHyUzEIlKIcPxhB7VRZpu50Ksfmbgo97/IJwaBz14wwZo60GpKQAnMALL0kWWnvI8R0jnoAAMdqX1zBhPgoqLjitaWdWJejdbaPH999BqwjwQ664kKMCT9lX3vtLM6xmOcP37QQOmPaNx4Vw5BbmQN8255NS784u7Buw2bdUeJ27ki8Wp5OqCu6vLeVWC4ZmwPY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(91956017)(76116006)(498600001)(71200400001)(52536014)(64756008)(66476007)(966005)(110136005)(55016002)(86362001)(9686003)(2906002)(66556008)(66946007)(66446008)(5660300002)(53546011)(8676002)(6506007)(33656002)(8936002)(186003)(83080400001)(7696005)(74793001)(99710200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lguesEZdi3GRcqrnqHvZvJiGmJcIxuaX48Y1+TdQ6uWm1tddtEdnSWBJJrEj+1BNAIn1Li0gNUuGHbbcwGn41pFgYIYhPmjlj5z1UC1mc7WcGSJ+nHt5iDuiImeIpm2zaL9b8gq4zzzPSXriOv/wZS4zcNGR80i9oXZKTLzZbFCRBZZh9eXOZOA+2nnxjH/EvAfZR1jgopfMtjKeDK6q4Ov4RgbbEYOBLjB/z03gnEiZJl1fCDNOvLLwaHGEsVbWEIiaCkf1BpYlDDormVl8LevStLbzcK9nWO211beYWMzOtH2Go2erVwJdqyFlthCbl14L+3+Su5ebob0nFhl2iA6zNgEERNYauZwOYme5kphIDwDx6WqE80DQVsKViBYOO/7umswTVrdNXEoOsKqoUkiTISH7UFyMlnGeodx27uD6zyWs3WpEyd/JMKfCdhtY0E8Sfu+Hj7+SVTYXegjlBUWOeNmvBSBrIadI9geQczphFfVZ9eJCIFP/ZPdH7B58zhC+N31XyPk/QO5CrQaJ14FBBoYRjosAdgj0/klXdcSSCyagokGBTr/YZaTWGfisIzJnyaX0naAgIEIhkQtfAOzNQr6Nv2x73r6FFINMQZ0bQmJ75rVGObegw+NKA0EedXH+uPKxXt6UowQsVdUpAsBSs4IUhJTl8Kh9uvVEvmN/BSKRwFDUPKAC31BNPVK/GFiE4ueRsZtofDcX9l51UQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e98b1e9-0597-4665-c9f4-08d85a1cdf83
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 08:45:32.7046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OoTBV4WB5jNk5lB0f1SMzQyPXon7804OF8swQzpDaC3A38l0N9Z1iu4r9OJZAUmNVrwxQcecU8rxOAdC2MmxL7RxR5g2SgjjUYjizdK/25I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5118
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/09/2020 10:19, syzbot wrote:=0A=
> syzbot has bisected this issue to:=0A=
> =0A=
> commit 3951e7f050ac6a38bbc859fc3cd6093890c31d1c=0A=
> Author: Johannes Thumshirn <jthumshirn@suse.de>=0A=
> Date:   Mon Oct 7 09:11:01 2019 +0000=0A=
> =0A=
>     btrfs: add xxhash64 to checksumming algorithms=0A=
> =0A=
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D10aadcc590=
0000=0A=
> start commit:   e4c26faa Merge tag 'usb-5.9-rc5' of git://git.kernel.org/=
p..=0A=
> git tree:       upstream=0A=
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D12aadcc590=
0000=0A=
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14aadcc590000=
0=0A=
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc61610091f4ca=
8c4=0A=
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De864a35d361e1d4=
e29a5=0A=
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D177582be900=
000=0A=
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13deb2b590000=
0=0A=
> =0A=
> Reported-by: syzbot+e864a35d361e1d4e29a5@syzkaller.appspotmail.com=0A=
> Fixes: 3951e7f050ac ("btrfs: add xxhash64 to checksumming algorithms")=0A=
> =0A=
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion=0A=
> =0A=
=0A=
This commit only allowed 8 byte checksums, but d5178578bcd4 ("btrfs: direct=
ly=0A=
call into crypto framework for checksumming") is the one that was missing t=
he=0A=
conversion in btree_readpage_end_io_hook() and a prerequisite for 3951e7f05=
0ac=0A=
("btrfs: add xxhash64 to checksumming algorithms"). So I think it makes mor=
e =0A=
sense to add d5178578bcd4 to the fixes line.=0A=
