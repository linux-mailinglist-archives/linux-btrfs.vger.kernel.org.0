Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063F74E9871
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 15:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbiC1NmC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 09:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbiC1NmB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 09:42:01 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7EA22508
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 06:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648474821; x=1680010821;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9Ah+ofZgj+QknJAjix+HiSNsK1tbCkkRX6c/QoNraKU=;
  b=JLCsqn8awGKBVy/o+hZ9nD7xDyQQQdMwSa48MW1F2Uf5gIX04Y6OETvZ
   yf2HkKrsSGzMH/PGOBRd7ZMAYsnuno0VVFhe0fskUcwDDv/39D7eYgWPA
   8vRoMXm4U7tluICLqhFMaqvJCbi/EKgIOUPIxGk6xmBnHWFQW2v8XMbxH
   1HH1PvrVAVQDrJlTaOyJTfelGQ0zs3FwSVu/i4xst8Zy3ILqWzuF8vfpE
   f2eAC+PfeCN7NjynMqb0Nfvt7Lxf8fy+XWJ+JTtFvEksdFJO84WpbKSii
   mjv14CljLzG2xD2J8p6/sTE5F32k8d8UP7gqT83SbWtENaAyDEpPd54vg
   A==;
X-IronPort-AV: E=Sophos;i="5.90,217,1643644800"; 
   d="scan'208";a="197361312"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2022 21:40:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5Z/x3fHR+amLFsR7lSzcO8lRKDZR05rNanoogN7FPYVAT1Jyw4rhU/40aRbz13FW1JLzzu5KGuLxbIT6T5qB3XqhdHzutMhmFUzuQglaztGbKsHvA9bl5SdqpWNvd8PLW9/oYCafIdxr3vNWIYTFXtXJ9oBWbuWvokzupRoc/kELI+1HJ3I2GNAxwNV4XRsge1QSKkadioxyvg/iKsISRm4cM4YbSGJFwC6YptjDeIfjdmsGIJs/vSsgT3kybrReinrNNWzbOuRj37O0vTLC4m12wUuevcBIVcYYkphDfch5KM5Bz1Q2PzCiF/EMPxNsnZ9HClqPfriYs9997UJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0nEGyC3exBypgYQ6+eXQ5ZW8f+xKM/cn3j8JQkjJ70=;
 b=mjoOpMOKIOs+YtLoqC4obJ1wvDdqNTIUgNiBC7UkbsMzPkeJYbaoix0rnjn4pFh83CD5eyDlQspxuegektu3AxaWMZtI5OLRvrE912LLiSAlISic5lQ8boJoZWtUb0nWyJND6L5CXaylNXtlUDh5NSWgsyJLDsfVU9VYS85C9fTy3yek+ASVGIY2VPWaVlVlrQyxV+LjigqVZxZ0Nzl4LgU8e7+3SlePPqo6HYsue69rZdXZh2u7xzKM7p0/0c30BEpBHV+62+TUqRrDNmAX+XiK4KodybaQt2r1dbRU9rDPVzlwES2g2Oo70oTmCoaFjTVVB848GGStCc9+t9hGdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0nEGyC3exBypgYQ6+eXQ5ZW8f+xKM/cn3j8JQkjJ70=;
 b=umYanXTyIdRWItfD0FE4w2n5SU0RLa//8Fd/ZaSsJyHxUSife+GzAe2r05DQxutwapQDqj+4UGJ7IMZy2EJUv5wVoCOFtlwzAZ7Z01mJnlHGfS5a3YhwPqo1XNZLE39szn2D7Dd2Nl+lfokBWAccnGzp0VNyuWocYQALDc2LsSs=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MN2PR04MB6302.namprd04.prod.outlook.com (2603:10b6:208:1ac::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 13:40:18 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f%5]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 13:40:17 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix outstanding extents calculation
Thread-Topic: [PATCH] btrfs: fix outstanding extents calculation
Thread-Index: AQHYQp/baUxN9+HTdU2d20e48ORwUazUxJcAgAACmoCAAAZHgA==
Date:   Mon, 28 Mar 2022 13:40:17 +0000
Message-ID: <20220328134017.xxi2kssj36z6r2n6@naota-xeon>
References: <06cc127b5d3c535917e90fbdce0534742dcde478.1648470587.git.naohiro.aota@wdc.com>
 <YkGzTsQtFNI9s7Ji@debian9.Home> <YkG1ffqfms+fycA0@debian9.Home>
In-Reply-To: <YkG1ffqfms+fycA0@debian9.Home>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dafd1e44-993f-49e8-1074-08da10c07f26
x-ms-traffictypediagnostic: MN2PR04MB6302:EE_
x-microsoft-antispam-prvs: <MN2PR04MB63020278403F02CE07FE4BCB8C1D9@MN2PR04MB6302.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /UmbCwoTKlBXKFzDVi5Na7jCLeGbnZFv9AJS6wspYk8jG9cJmwx9TjrGNAIQ3P+vbcakVQICNalJct6gTAmc2uhT1ToUcKAuMz+VvBTnJ4UJXA9WVuGT2M5RGFjHIJhG3qVQVkOIfhmzmL9B1W/ZOsyF6Rgw/t2a5dfNW1SAoKduQTcTfl4mhq1LdYI3hBkvrb7aGjNR297gNcOzuflXyISQVHnzg25XOKUVNekhhQV1TSCVKK8iTqRLnrOczQMzERnukArtf6qtMHrQzwmxPcvHw55zK0Ji22zfsQtK2bdDEFm1Fq9jhs/5Pz5OdJUkJZesdPyIUGHfcPC16je0dhespu2bbafs0Rqhl3We029UxAHBHpUBNklrxmjwyDDLZUyLUDtrIDZcpBibazEb8+QpLd/fHAioO51TaL/yL9V7HFbGZ0cGUqe50mi/Dfu8fMI9sYE7O9OWDsSokuCOGaPJPWuoPq4tIfQyCxvEUeoH+BVQrRp+yBiP8eSf2UDpd1rJREb7ZgOhaUj00hNeUpAT9iFM6U+L8HkBRNwtyiTZ7Jg0r5fFQ8TknTtOpPQLX4jKeyYTu+0uzY5W4Es0eW44wRwZG0MWmRAYvyupcg6lR6glxvVahA5Aeg+WBWQNNMxDYtWzJntqF9uK2UNxGKAq7d2MbwzkhOcwxHf1cYxUNzgQ6c+azchY3JbRIEzJTzTN5zNkMuSA3w0eIFxY2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6506007)(6512007)(71200400001)(82960400001)(6916009)(45080400002)(38070700005)(122000001)(38100700002)(508600001)(2906002)(86362001)(8936002)(1076003)(316002)(186003)(5660300002)(4326008)(6486002)(91956017)(76116006)(8676002)(26005)(64756008)(66946007)(66446008)(66476007)(66556008)(9686003)(33716001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DsLPOW0nD7HzhjQUf8++v3k/xgLTSrYcE48lTv8TQLLxBPAKuNXKc3U3UrLh?=
 =?us-ascii?Q?hH4X87WOM2lQg4TKC7Eeeurc3XQVxFIxWqhGLAoup/jYJxCk1gIjNS9B37vC?=
 =?us-ascii?Q?Y8nWdwoLrdd/6JZ7NjdXtwAfXICYkbajGniQYEVV9FFtPUiZZCX3lLYybnk6?=
 =?us-ascii?Q?hxG9V72cI7gL0NqKUkf2tSvFw/yoHBEL5Etgu6LPspUwhZ5mcN8GebTf+47j?=
 =?us-ascii?Q?fdmmCTmWDT0EEIa82mgib92kMVvCWiW8gth2an3nSgK1rloefZigvYO/pvWD?=
 =?us-ascii?Q?bxYJ1OLu1Gn20eLSJd2cCo9CvzmRGjbYH4D6nwEokd8hIxBE25o5VTY8OkEb?=
 =?us-ascii?Q?Ozbzm1/Jn7V2/n11Kn0hmHL1b/qvDPR1orQipDnL/WHdKuIP2lnMho5sEAdR?=
 =?us-ascii?Q?PN+rcGJqUH3+6X4n6n9lcFEg6UOKPpF4nNHHACgQOkRf8SDWJp4ZTwsodCid?=
 =?us-ascii?Q?vQ98Mej8sfKNYYPciflCzodhJDluaY5ASglKx67HRORXTljIw5c3Am44qP1r?=
 =?us-ascii?Q?QMOWbbH9Njjn2ccIygnhtgZeRFrML+c/rPilVeT1Rdc5cXYppFt4d+Ugsz2c?=
 =?us-ascii?Q?slJd+qFzJVXb/Z3VtWisxuMeQARmoDhUxACFxkbjNLt2prDKClrxWcFGpga1?=
 =?us-ascii?Q?60ZNN9FbGfdABIvOQQjGdSSwi5q+k9KC92tqKrC9OTvf5cNXyNrXvB2qPv7t?=
 =?us-ascii?Q?7myoy0Bb3QdgyW2l+OrX3IqWQIUw3LmKqdfl/wLGymGJ+GnYRQ/Pag1QEqru?=
 =?us-ascii?Q?ASID8bscZbZXRAl7H5ANalh9jv3OQKxdHCmFrdNxTmh3MGo8AdgH15dqV0rH?=
 =?us-ascii?Q?XcRkAiLAhifA33bhAccP3rr+RldlLc8EtpoTFbpDlChTunF5cSgNIrIptqfn?=
 =?us-ascii?Q?M1So+YZoxyXnR4oYZQlmd64ZpvJpIb3UbMhDwDKXDVbiQapkcFqerboABMl6?=
 =?us-ascii?Q?rj50waqwtNdA2/AIpStOAA8J5PUkoW2I0uaTsKezWOS0ZcIXJBkRYW3L4FBG?=
 =?us-ascii?Q?Pmb+RGzPy4DrezchboOBUEEF0IImq6H+yz8w9kI7ho6k9nIbtBVepT9E28bX?=
 =?us-ascii?Q?yIEU7i1K1nv3yxOPSAQBwpzDqkGehgu5oP1W0QLWAexOUDl0Dto8sBuCDuix?=
 =?us-ascii?Q?jVZLylIpR/PvetPREG0iU13x5148co7u6wa3b57Nkrg9hmYcKIBmp18f2wYl?=
 =?us-ascii?Q?u7qFdsiNILHC6igD1LUJSXKPZDZt7aIJKuPRXdSp5r34hhMMrFbttNdGNRYl?=
 =?us-ascii?Q?ds4Rw/9GzWHPybvr7iVdKadjKCzaA9Oe67nIbMIN143UBllAcaWmlDOqcvue?=
 =?us-ascii?Q?ZZyGFewfnhpZ34ya3qdsyueYJWjFCz4p/7F8FgdgnybtqOMdjN3yb1vgrCNt?=
 =?us-ascii?Q?LXdc5GUQ0yiNFqmSVDZpvhpLxQwb2XvLXCu5yOaYB7OSuDfT6A+jKAAzCZxr?=
 =?us-ascii?Q?0KH3xU/UYd6cLxOtGSYU5sVDeEi+IML/mEm6/qajEagVyDQI6L/w7sXRHFM6?=
 =?us-ascii?Q?PRBL/froNyIZatsB46Qq/tvoTgqpl9NdRJCXGg7ch4bnW5ZRyL85gNNwFu91?=
 =?us-ascii?Q?W++gOXmC+eFAxlH9R6j+Mktd+jjK0ZV3ka3bHhz0F9Ebin7FUDsJBYvxh1M+?=
 =?us-ascii?Q?Og0CY/dzjfmBTlu9xxveMD7xWtiUWRLd/U0v/qLN+N2i6N/4i9s/nYGQwy9H?=
 =?us-ascii?Q?Q67OtWe8WlqAlozQXXq69DRKoh0N6O+P9VD3X+x8s9ahiogpVQAcZii4q1/z?=
 =?us-ascii?Q?mSWGp/WwVEVuZR4OXHBbCAqBOfoeCHg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DF23233922E4B546A3EE6D72A3D2972D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dafd1e44-993f-49e8-1074-08da10c07f26
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 13:40:17.8531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GJVN4ArKXR36fTd6KPCcfn/SWHjw+CBcHDc3LNQ/HYHFKxrZkVyKUhqX9jctqSQLrddwSfrTxLyGo/XT8R8wgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6302
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 28, 2022 at 02:17:49PM +0100, Filipe Manana wrote:
> On Mon, Mar 28, 2022 at 02:08:30PM +0100, Filipe Manana wrote:
> > On Mon, Mar 28, 2022 at 09:32:05PM +0900, Naohiro Aota wrote:
> > > Running generic/406 causes the following WARNING in btrfs_destroy_ino=
de()
> > > which tells there is outstanding extents left.
> >=20
> > I can't trigger the warning with generic/406.
> > Any special setup or config to trigger it?
> >=20
> > The change looks fine to me, however I'm curious why this isn't trigger=
ed
> > with generic/406, nor anyone else reported it before, since the test is
> > fully deterministic.
>=20
> Also the subject "btrfs: fix outstanding extents calculation" is confusin=
g,
> as the problem is not in the outstanding extents calculation code, but
> rather not releasing delalloc by the correct amount in a specific code pa=
th.
>=20
> So something like "btrfs: release correct delalloc amount in direct IO wr=
ite path"
> would be more correct and specific.

Thank you. That is much more informative. I'll fix the subject to it.

> >=20
> > Thanks.
> >=20
> > >=20
> > > In btrfs_get_blocks_direct_write(), we reserve a temporary outstandin=
g
> > > extents with btrfs_delalloc_reserve_metadata() (or indirectly from
> > > btrfs_delalloc_reserve_space(()). We then release the outstanding ext=
ents
> > > with btrfs_delalloc_release_extents(). However, the "len" can be modi=
fied
> > > in the CoW case, which releasing fewer outstanding extents than expec=
ted.
> > >=20
> > > Fix it by calling btrfs_delalloc_release_extents() for the original l=
ength.
> > >=20
> > >     ------------[ cut here ]------------
> > >     WARNING: CPU: 0 PID: 757 at fs/btrfs/inode.c:8848 btrfs_destroy_i=
node+0x1e6/0x210 [btrfs]
> > >     Modules linked in: btrfs blake2b_generic xor lzo_compress
> > >     lzo_decompress raid6_pq zstd zstd_decompress zstd_compress xxhash=
 zram
> > >     zsmalloc
> > >     CPU: 0 PID: 757 Comm: umount Not tainted 5.17.0-rc8+ #101
> > >     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS d55cb=
5a 04/01/2014
> > >     RIP: 0010:btrfs_destroy_inode+0x1e6/0x210 [btrfs]
> > >     Code: fe ff ff 0f 0b e9 d6 fe ff ff 0f 0b 48 83 bb e0 01 00 00 00=
 0f 84
> > >     65 fe ff ff 0f 0b 48 83 bb 78 ff ff ff 00 0f 84 63 fe ff ff <0f> =
0b 48
> > >     83 bb 70 ff ff ff 00 0f 84 61 fe ff ff 0f 0b e9 5a fe ff
> > >     RSP: 0018:ffffc9000327bda8 EFLAGS: 00010206
> > >     RAX: 0000000000000000 RBX: ffff888100548b78 RCX: 0000000000000000
> > >     RDX: 0000000000026900 RSI: 0000000000000000 RDI: ffff888100548b78
> > >     RBP: ffff888100548940 R08: 0000000000000000 R09: ffff88810b48aba8
> > >     R10: 0000000000000001 R11: ffff8881004eb240 R12: ffff88810b48a800
> > >     R13: ffff88810b48ec08 R14: ffff88810b48ed00 R15: ffff888100490c68
> > >     FS:  00007f8549ea0b80(0000) GS:ffff888237c00000(0000) knlGS:00000=
00000000000
> > >     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >     CR2: 00007f854a09e733 CR3: 000000010a2e9003 CR4: 0000000000370eb0
> > >     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > >     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > >     Call Trace:
> > >      <TASK>
> > >      destroy_inode+0x33/0x70
> > >      dispose_list+0x43/0x60
> > >      evict_inodes+0x161/0x1b0
> > >      generic_shutdown_super+0x2d/0x110
> > >      kill_anon_super+0xf/0x20
> > >      btrfs_kill_super+0xd/0x20 [btrfs]
> > >      deactivate_locked_super+0x27/0x90
> > >      cleanup_mnt+0x12c/0x180
> > >      task_work_run+0x54/0x80
> > >      exit_to_user_mode_prepare+0x152/0x160
> > >      syscall_exit_to_user_mode+0x12/0x30
> > >      do_syscall_64+0x42/0x80
> > >      entry_SYSCALL_64_after_hwframe+0x44/0xae
> > >     RIP: 0033:0x7f854a000fb7
> > >=20
> > > Fixes: f0bfa76a11e9 ("btrfs: fix ENOSPC failure when attempting direc=
t IO write into NOCOW range")
> > > CC: stable@vger.kernel.org # 5.17
> > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > ---
> > >  fs/btrfs/inode.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > > index c7b15634fe70..5c0c54057921 100644
> > > --- a/fs/btrfs/inode.c
> > > +++ b/fs/btrfs/inode.c
> > > @@ -7409,6 +7409,7 @@ static int btrfs_get_blocks_direct_write(struct=
 extent_map **map,
> > >  	u64 block_start, orig_start, orig_block_len, ram_bytes;
> > >  	bool can_nocow =3D false;
> > >  	bool space_reserved =3D false;
> > > +	u64 prev_len;
> > >  	int ret =3D 0;
> > > =20
> > >  	/*
> > > @@ -7436,6 +7437,7 @@ static int btrfs_get_blocks_direct_write(struct=
 extent_map **map,
> > >  			can_nocow =3D true;
> > >  	}
> > > =20
> > > +	prev_len =3D len;
> > >  	if (can_nocow) {
> > >  		struct extent_map *em2;
> > > =20
> > > @@ -7465,8 +7467,6 @@ static int btrfs_get_blocks_direct_write(struct=
 extent_map **map,
> > >  			goto out;
> > >  		}
> > >  	} else {
> > > -		const u64 prev_len =3D len;
> > > -
> > >  		/* Our caller expects us to free the input extent map. */
> > >  		free_extent_map(em);
> > >  		*map =3D NULL;
> > > @@ -7497,7 +7497,7 @@ static int btrfs_get_blocks_direct_write(struct=
 extent_map **map,
> > >  	 * We have created our ordered extent, so we can now release our re=
servation
> > >  	 * for an outstanding extent.
> > >  	 */
> > > -	btrfs_delalloc_release_extents(BTRFS_I(inode), len);
> > > +	btrfs_delalloc_release_extents(BTRFS_I(inode), prev_len);
> > > =20
> > >  	/*
> > >  	 * Need to update the i_size under the extent lock so buffered
> > > --=20
> > > 2.35.1
> > > =
