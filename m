Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A931FCE05
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 15:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgFQNCV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 09:02:21 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19886 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQNCU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 09:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592398939; x=1623934939;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=k5AFg5Idy/CEX2dHyboTSOP2QJKAZtWvXXkI86eE2hA=;
  b=J/dEswV1zodCEf06ktciEImkGsibpIc8nQwLRYLPT/5Lijc0/RVvhr0Z
   3zYFsAIUSymc/WE3JplHAlSduhJ6Htg7VwrfUMsKaI/o+wRe0plpZy4WC
   e0ySlvV3x8KMaVWnK87ICLbSIxLWtCwieWNQ+kJendY/+/xAbAdofPWVF
   ZlLFxSdt6F7RH5oMw1mdRJnZ+YL9q41wEggHeUqoD9tfbLV1CX1jxdfoK
   eM7aVQUeNv1ApqpbYii69GKSrV8Bh49bcjcsCXUqIz1zJamgLnLYNhYLU
   Dos/MXk+i1Wa+at5e8DyjOHTBPiqtNSjRwVKbQAY//j8p6thWPB+xkHwS
   w==;
IronPort-SDR: kLlWp4OJ/WRlQFVC5/lzI/VNbmd03Q4wcx7Litwg1CBV80aKmCk69eP3VvS7gvknuPAWpDyMKZ
 hOBhQbhyfvv3CVlWK1VaVQOLxiRwLg6C/R2TKceC5keKcc4a4+kIBgtK3lY7vHuelZzjvjTpqo
 F4F9qm6IGL7b1P9TlRURjHSleISK4ZywcYftVYNq8pgw5K5eln4JRJmEkemIEUGVHEp80YuSwE
 O/6396KzFtDpsRlkIfTUaChk7GMgXksiGefaxoGRvGAz3w+0A9YoB8TByf/DJ/xzHynklTJnAQ
 3ag=
X-IronPort-AV: E=Sophos;i="5.73,522,1583164800"; 
   d="scan'208";a="249398324"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 21:02:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmLrjgb3GGGGifHEIDEPp8McP7BT+0EDWPBwVSVL+i2gG04jD7blylHHHpFprsTaZQ2MMh3U6dGWgFv11xtOzLbWaB/k5F6l3nLyZTPfxMVvn9YYAXeqEFVFHDoS6cgeR7HXAxVys6LtLhsVNBDbq0Sf3VIh+y7NJyu8ru0uCv75+yctk8ouaJWqiq/YWpviQKTHyz/KVUrkVIrlK36Zq+O8Ew0KJ0Yy6uKz7LPtr4E8Y1+ttedUgcw4FqMs1+6uvYcJskre2jqvPnFLI0YFpSqnfkL8pE4Ln4R2KU2l8U/fyxcOiLNbu4krxJRIQ/vOBqAjwiGLQO7nHVu5DxKh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGiscRaSH1/bqxmw6ypevOFdngTNGlLj2pr7H7b1rX4=;
 b=Ndk4nPj6KfyI3ygdPuY4XveOxcrtV+jMt0zd4fKyT57ahmMKjHcikKSIwSnJ0UR8KvyYPjVrGYtusYvKoiLqf7bVyTk1fDO9aF6l/IS/aog8l6c4N6y2lxk7OCCIVe8L5RE/17u44YCyVkQq/DRk1wCYsUWbb5nzhgVllc6Xi2fTSPGJXCfgPTrzRoPst5uw08qlg+WTatpw7154tMpVA/lWd6tC2EiobdPgIjetR88iU3lmCJet34lfDSBqWQ3lqInryeThMfEHzColgll+lm2U0/F1pgcbd8VW5cIqyiCn8xiUqMi9skNacmKyz3AxfWhiuCXVxgNDJ1rEFbhTJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGiscRaSH1/bqxmw6ypevOFdngTNGlLj2pr7H7b1rX4=;
 b=Jw40BTvJgebRbLuC3uvyeUp3PmT197jl/Ygu50aowxla8/7we4+xZD+LVsnNHYfZHyfeVa/rxHRzpFm21VdDyHH2//F2chFBOTcWUq2rmuvahj5HggF3eJC9ijjJ/iIkN5hW3hMhyWi/juHSJxvq/P6BZKUYiz4+rlVjG+T4egs=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5406.namprd04.prod.outlook.com
 (2603:10b6:805:102::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 13:02:16 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3088.028; Wed, 17 Jun 2020
 13:02:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: Use for loop in prealloc_file_extent_cluster
Thread-Topic: [PATCH 3/3] btrfs: Use for loop in prealloc_file_extent_cluster
Thread-Index: AQHWRIgiWXwJPxiVL0mz2dOVBLpGTQ==
Date:   Wed, 17 Jun 2020 13:02:16 +0000
Message-ID: <SN4PR0401MB35988C7F273C9359252FAE099B9A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200617091044.27846-1-nborisov@suse.com>
 <20200617091044.27846-4-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2f8c283c-e0b6-4418-039a-08d812bea94a
x-ms-traffictypediagnostic: SN6PR04MB5406:
x-microsoft-antispam-prvs: <SN6PR04MB5406B1556EBA5B801F924EE09B9A0@SN6PR04MB5406.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EEBA68f0c2UzoEsG1kS0Cf3VFAkA18hHikCqAxohSDe039YCAZR5OXYktfJUkXi0c3/CQHLQmEPQlDIcbDy4jPw2XLle0hf31nV9v0y9QRdyTrvbHx8GbgsNK4UvB9MnhTuSC35jbiIArOKb75bR7zg3kBLXWfyMAKFWV29yRFG2kdZC2ugM9bKUgHEoaKBEY8uEKMRdGcXIbFAsrOZrBcP8i8V60dtaw2L3TWgOPFHe4mY5RjSB5VEaaHH6sGOF2Ns40zdwAu3m3NFEedhOt4AmDAdfqfczTtRCyCw/PVCB2gkkMObv0cCjC34jmpsx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(66946007)(55016002)(66476007)(478600001)(186003)(86362001)(76116006)(91956017)(66446008)(26005)(5660300002)(64756008)(66556008)(8676002)(9686003)(52536014)(8936002)(83380400001)(33656002)(7696005)(2906002)(110136005)(316002)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: U8G+xn7dr40u8JoGssTFxWtYOVTf9EVedtPYxkZ2DN9fp6NyO5GfFeMXIPUJXvYHfLVqw7QdA5eCXssT+4kyz50wXQjvoHtINkCND1I3dfz+AGNcli9M9irIY6WDCrXSMh7vR2nkzWsmbDt4BMnboJBBq18XvAwvumaH8LGruo2eO+cO5HU11FHS+Z3tGVUncEaAwlQwerjIqqVmQaUcKvJejvC3ZPJJfSZcfMbSbd5LlIpGBzL1UftQJEtnSHUvRh8K1WKot3RrbTW1pvIx6r26RMKYndlWG9jzmLk4dFs5C+rJ5/qJGuiDG8mKk6v74lNGd/NLpWFbnHGYQjAWzY/DeHGSQso9LCX8BogKr5WdKZiZ17SZfk6yuTc4VI4nXEkq6INmBuigaoxE19ep1ZEFlJ+maj3gBtLU5yb914IdUpy5rA7wrsXikbwsl0AtryIZQEBz3q9q3s7ghR2G4Ofcl5VxmzUsMKWEa0TqtOt+GN402OkqbpXMC7Wbpk5Y
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8c283c-e0b6-4418-039a-08d812bea94a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 13:02:16.5052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JduOpFukA9fekr4+ok/77JzWxZe2aLbW2tJ3eE/eVzIUjI8wMN0gH4ZBsD6sUd8CWhNjrq+eUjayuG7EjrS4PHJlONLVHBzwITHm2478IvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5406
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
I've you have to re-post another potential candidate in this =0A=
function would be:=0A=
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c=0A=
index 9235c671bef8..3ebf64578a32 100644=0A=
--- a/fs/btrfs/relocation.c=0A=
+++ b/fs/btrfs/relocation.c=0A=
@@ -2578,7 +2578,8 @@ int prealloc_file_extent_cluster(struct inode *inode,=
=0A=
        u64 alloc_hint =3D 0;=0A=
        u64 start;=0A=
        u64 end;=0A=
-       u64 offset =3D BTRFS_I(inode)->index_cnt;=0A=
+       struct btrfs_inode *btrfs_inode =3D BTRFS_I(inode);=0A=
+       u64 offset =3D btrfs_inode->index_cnt;=0A=
        u64 num_bytes;=0A=
        int nr =3D 0;=0A=
        int ret =3D 0;=0A=
@@ -2589,7 +2590,7 @@ int prealloc_file_extent_cluster(struct inode *inode,=
=0A=
        BUG_ON(cluster->start !=3D cluster->boundary[0]);=0A=
        inode_lock(inode);=0A=
 =0A=
-       ret =3D btrfs_alloc_data_chunk_ondemand(BTRFS_I(inode),=0A=
+       ret =3D btrfs_alloc_data_chunk_ondemand(btrfs_inode,=0A=
                                              prealloc_end + 1 - prealloc_s=
tart);=0A=
        if (ret)=0A=
                goto out;=0A=
@@ -2611,7 +2612,7 @@ int prealloc_file_extent_cluster(struct inode *inode,=
=0A=
                                                num_bytes, num_bytes,=0A=
                                                end + 1, &alloc_hint);=0A=
                cur_offset =3D end + 1;=0A=
-               unlock_extent(&BTRFS_I(inode)->io_tree, start, end);=0A=
+               unlock_extent(&btrfs_inode->io_tree, start, end);=0A=
                if (ret)=0A=
                        break;=0A=
                nr++;=0A=
=0A=
=0A=
This would save 3 BTRFS_I() calls, but not sure how much of a difference it=
=0A=
makes in the end.=0A=
