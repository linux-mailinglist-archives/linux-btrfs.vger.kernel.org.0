Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80015783796
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Aug 2023 03:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjHVBs7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 21:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjHVBs5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 21:48:57 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AC4132
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 18:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692668935; x=1724204935;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=z0W43MfzbM/BTxvlyh/1Mf5CtMFQD9/MBXzos86K2FA=;
  b=C443nnrXmaLMKahtiOQfTJiQBOLx0m85tFWT2nRZctYwTmYa1C6Zr6FB
   ZJzpyb3yLxmd3KC1hyaWM/JBuU09MXVDoKtfJs4fe4ZZGBdaKIyjKYj7O
   vciH72yZhu+6XtUjMdZaHTYlL6MuiNbZ/JsssSsBHz2wGEdw5KZMi/o1c
   GurGK9HBCrEWZ4ccmIHG4zdbOd0WpL8PGjlENGaJNWxORYHqXvh/Lyzv3
   nZ9rz1Or/tItWBCjNSwGVSN3QsJ0mHSWUIf1xfJkV7tK7dNjjzlVRcksu
   RTp73ANOyY+AcBLcdT/WzLhkPcVQRr/Olz8eTj5N65G+haWS8hgXZKF6g
   g==;
X-IronPort-AV: E=Sophos;i="6.01,191,1684771200"; 
   d="scan'208";a="240016357"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2023 09:48:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibxp3JPRsf55LyyZHqfMw0sv1/6seTK/shamUSOp2bKS+QmyIco1tsAMu3KM1Jn6w7d35OELm/NdZNXkXcadsCRlEvIeNcvFe3Eq9VSpR/WWCFVnipYKa0IuX/5TkJLy7oTwHgxHWCniJgGiTHeSWfYMgHJWo1E0WyvagpUXywhbibfaCGTVnJW9GfGUJsOnKL7qWp9DYYD1RSN49mMyNxnxzIR375HEtcmLr7I7/K/Ou4KBw0MgPaf7GMmToLfWObtnvbQ0t/7JNOX+xLsEa+vBJyENsz+kIJwy4f+UzHozTTtwGVbCMR6W2hRlXKNTlMBRpYzKvs78h42UaHTsQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ri6d4JXtp8JliT1DFobiRGGCMuxiCg0EAiXNoM+oej4=;
 b=NCLq+1UEPhuFcNC2x+uO9p3kaIvc3kN9Acnme9VwZtCo5mJisv4EauKsPmtHlrFFeOCnCul0yEHuVSSsW5q/7vm/U5GaATqvhSXt8DhnLTXPj7Fmf/PWZftLyd+m2r1NkTLu/tpbtn1guAuQiSNawRzSGGV7w2tXp8bcWz+5P6EwhhzyM6Va9w2CJUKMnGjET+za2SESZsHiay4FPCsarRxPbheJclNdQxgtzhXbI0+Qp71NQcpHqZFg9ql4MNL1x3iWSjYLvm0TbTZxErPQAR6dLcMBvCy+RlvxvhUVX9Rh/X0cwdd3aPK1adIEmrExxPRdK7v06j7kpySLP/5ZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ri6d4JXtp8JliT1DFobiRGGCMuxiCg0EAiXNoM+oej4=;
 b=JSHSHCvPTMo3VAr6SK+7+vnowV5XlkbODKbSRNoLBMa+2LLCOoMW+1TnNE/ezcwI9aJibgap1Lw37No6hVB3ANgvySg/3O/nmHgnHVbLSsuO2Rw8XguQPcFJnv5DQR5jy63uC1bsYmqFu+kFeYlUb1MOMNxwX7ACl7X/Do9E/Fs=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BN0PR04MB7919.namprd04.prod.outlook.com (2603:10b6:408:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.14; Tue, 22 Aug
 2023 01:48:52 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::275a:b2f9:29b8:e60d]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::275a:b2f9:29b8:e60d%7]) with mapi id 15.20.6723.013; Tue, 22 Aug 2023
 01:48:52 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     David Sterba <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: skip splitting and logical rewriting on
 pre-alloc write
Thread-Topic: [PATCH] btrfs: zoned: skip splitting and logical rewriting on
 pre-alloc write
Thread-Index: AQHZ0fC4CtjxiIvMOEWL2zjICWSsSK/00PUAgADAw4A=
Date:   Tue, 22 Aug 2023 01:48:52 +0000
Message-ID: <k3uzcmog2awcj5lc4lyecifjfsznofiymyfkfiscg4gxvr2srn@fro5ludqr7u5>
References: <b9fec5bebe9d5be20c51bf0934a95609830d04d4.1692375606.git.naohiro.aota@wdc.com>
 <20230821141856.GB2420@twin.jikos.cz>
In-Reply-To: <20230821141856.GB2420@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BN0PR04MB7919:EE_
x-ms-office365-filtering-correlation-id: f5c927fe-7491-4e8d-142a-08dba2b1f02b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7EAgRAw0viUuvLH3jOJqfygU07OmoEu3ANyodgn///Ub7+tZu6xpumsy0qt/tEPMCBVmFkJMYQthMpBnorQt8krFFxP0H+kW46mprtuDvewZI4dVLPfynm01c4BySBZgtXMXPt6Y/o6daRt48ScxFJYgyba23u5nptg/uslWHVRWXRPGiKSU1urMemJOE/jw1hej0S2c+0YD4yTG0h63zwgy3bt9Gr2DeDvpOe9n7lufpVIaylIqI+0Y32cdxgRwhWkyrASYc1XsgvhLqvUiiBWoKtcVlRV4h+v3A7TKCFq3QAq510F8/fnMrh9P8vde0ELjet9zwD2AZ2wfhxgE6eHkaUm9KMSmg0Hrlwp0LRU+Qfd6bCuzeFm3RHRpCuvq6UlDgUKZ29hUEi4rGbIwJ0mmo+R6WdrngbPgc6Wy6I1VHRk51oqA+WrtR8ESVUFo6AjuIn8Akiz7wLV5g+yYiU4Ux0h0fyLCF23mDiQA7A/Y5vIdx5yWT1CU4WkjxNADl5EGixxhehySuGnWcrT/s0fOGpSrf+I0FSDL+icgUd/FNmoZpAbTlEA9EOXmM0o3TvwbncFtkscYQw2lFjR7sS9wPkBOJcwtlSyOF+N+NKQNj/SZyfnmXs8ilLqh7Hci
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(39860400002)(376002)(346002)(366004)(1800799009)(186009)(451199024)(54906003)(6916009)(66446008)(76116006)(66476007)(66556008)(64756008)(316002)(66946007)(6512007)(9686003)(82960400001)(91956017)(8676002)(8936002)(4326008)(33716001)(41300700001)(122000001)(478600001)(71200400001)(38100700002)(38070700005)(6506007)(6486002)(83380400001)(2906002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mDKiFodHbtx0O5hYNxgr+azGEq6gXc3YF4yPPtSl+hmYl5FYzfliWks7fs+3?=
 =?us-ascii?Q?PHfpCKfzwBAvRJbBCdJlk5IE7DFX8zS3BtoApxtBDKXdwzC6NDw3tUaPz7TV?=
 =?us-ascii?Q?tNhj1nltVGhvUFQNKRcFSLom+TdCBjVqPo6vd8Qyn/o9hkkNwPyyf2vc0p4s?=
 =?us-ascii?Q?hpX/9CDAdnBfzzMoZxK3dm7/UIHW3jrER+dKjVJFF659VDp54bIfU1O2MiT2?=
 =?us-ascii?Q?kFcuKdRTB5AD5q2nqiMxFoLzWVROP+4S9REhRbGpz2pC1jujHzLJ8VLCGFXS?=
 =?us-ascii?Q?qPjiw3D3dVINO2LSzIrb57A2bNpBoCsZwBMb4prj0RmVJfoILjQL+C6cm7+Z?=
 =?us-ascii?Q?WghTc/lFjkClNQ87CwQRtb7gb8RHw4usGfKToLVd5T1iGL1PEnu6/4qYSO7a?=
 =?us-ascii?Q?hgfVBgkviB5PiwJmBiqRPxgJ5up7GZCSvZY/0YlJkRFC1GX+rLEZ7HjHZxsn?=
 =?us-ascii?Q?UKNrUS42FczYwmvYhaYMIMJMdWiqeGcDEuxMwyG7aQbddinfZw9U+ywgWDtz?=
 =?us-ascii?Q?LjhLPBSNq1pxAApnSsOlhHRyH8ozUd7f4ENVOFkUrzw0zj32aQZTbyKocGwa?=
 =?us-ascii?Q?rT6RPUgkZBoNw/N2rhVUIuoUh3Z+LRyUOzULxA3eHmhxLOhDk6UDN/n6z/Vs?=
 =?us-ascii?Q?Q0nV7O7AKIOp+nkO1RZ1Wp3yW3PPoIMldaELQiO8urWcwl44Da6SUbVWC9Gr?=
 =?us-ascii?Q?qM0xZZ54EW+3duI2Di2dKvcf1i0/Jp/ccrtipwZ3pCoKevPUqveWZ0SoyIpS?=
 =?us-ascii?Q?7s1vaey1i2veHSNCZzKwfFU3OhnDi5Sk82CTL6LlQqMLKuHttwpbt5w7qHLi?=
 =?us-ascii?Q?S+PasbvDMK7HArwGhidJdWUsOVt2tGlBtphHbKWsujsFpPMJw9+J6IyY76WX?=
 =?us-ascii?Q?Bv0NTKc1pZH61HW+nJ/VkCE52CLgyDu6m/TIG1l+4/iZmmlgNpMOPrnmIGQC?=
 =?us-ascii?Q?I8rFRinsmrmgC/1/1sA3JRTrfncBf9g52HlV0ij9DzyCJu7kE6NUEK4J7TGb?=
 =?us-ascii?Q?Q4C/YY4QKVpru3isk1sadfoOouJ8oubhIOJ/X5UdQmpW7h4ouQORAFeIS4GZ?=
 =?us-ascii?Q?COr5HKo4AFe9vu6HumnPdhdgKNTq7kXWQqEEJ8cveFjBcQzmFuOFBSePOWbm?=
 =?us-ascii?Q?fd25jL+j6HBDYVYRbaygZjTgaULWd44VbVPyJg0tCFaOSVFFDXx/9xp7Kyai?=
 =?us-ascii?Q?eUvx4wgrh7cGK6nOb6b2By1QI+DA443UCokR/Wjjr9NvIor8ah5hL6JhotKy?=
 =?us-ascii?Q?5NuIRSQqwDPl/2Yk7YuJ+WlItMeWq2iF62SBx+hNxbid6kBYwTBHjnnodpiT?=
 =?us-ascii?Q?a9McfvHfHQBaCRqk67JOdmKwoNkNqhrHhy3E4YULDFpYpx6JneLrtDzS0sPR?=
 =?us-ascii?Q?GZOCqmtnYo8nfvHInpB+eeNT+V95y8UkDov9BzwQU1LXT+aTdPrzixpHO52g?=
 =?us-ascii?Q?meul+r63m1uswP8d1kdsA5oaIeatnoS7pmqKCJPjV42nhW4QQX2O+wHtdjRd?=
 =?us-ascii?Q?W6PpgBOPNjZfnr5/noYVB+jYWde0ZBivaYlE+58APHgdwpK/UcKo9X1FEkF8?=
 =?us-ascii?Q?UbXRhyCQfHuiQeQkw5fFwvg1tRVTHCNggaUhQbb+AOfHMzEnET7+80i9Yy4e?=
 =?us-ascii?Q?Zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <538BD5D1CAB76C49BACC91005D8231AE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J6UcuLTLS8RRLbdCjkPxk2OHHCp/dLr9jSuRrmkgnOmZVpDN2qixW54EhyqwxXzQBjEPuf/sykYJyfvkcQcculyCBMdg8+lNh41p8tk66A1BFLqdkVyft7FR/5vOp03ppIOvoi9Fy6gpjmmDYYAL8REVRv1/74WtBjRgXKVJ6xwGe8tbbPM8vIiDi/stWGxZEeuDXBboYxzdXXiSkCEYR1D5PCY1Xo4jiZfODIWZUMhnAIVtx15gST+Yyp0Q25Q6qGLeR/l+zsAF7QEBIOw46GCiqQiID5Nrs6QGXrWMiwhHB5NCjmUHID9k1AXP5IUNPCdYFtonhhidfIdN4qbw9iUkIf7QUfD1pFSBpdA39XTyUMJgMggs9zXvuUU53H4SNm/W+K58hwRDcGt/YEOFLGNj40fBuDDDR5IXNDcoWbfBakRmcIO/vs4xTa6Jnksn5xc5IDs1muA1Cta0PLN5R+KY3JQ73HrFcYqy7Jfaz1e4didwCuTUL3nrU2CZINcsuEcYSOT3jdzk8mKyqKw8qhI91LsmsUa2cev+rk3f08PGilPSTSRqraJm2KJBvx7hxLHfRmDRaVeqGAJjSQnfXA1joMaE8L1yYjovHK/LF1yoOdyJT2JJ3pMuyOPC3m6+u37/nxeOqSMY0HuI62NTzEwUdNO6onMAtcYrOqkj3WTZACSn3Ds9ZY7Jk61k6aOsOmoqS1Awom+W3Gojn5FEB6sqhfKNJpcnSuxm/i/+oLtNusHlTYVt9dNTCe3TnETbL9EJ7M2we+ZZXW+gwus1+7MTRJVd+yAVn0dH+hk/5+a8SE1UvylHFX8nRwKmggnq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c927fe-7491-4e8d-142a-08dba2b1f02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 01:48:52.4792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OuQRyK9dawfiXKaDpAsghvXUYyyJ++6zYVt41+loVZjrv3UZ4sXBz6UDKfmClOXFcxIhBY3vVelyQ0ClafV9KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7919
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 21, 2023 at 04:18:56PM +0200, David Sterba wrote:
> On Sat, Aug 19, 2023 at 01:26:07AM +0900, Naohiro Aota wrote:
> > When doing a relocation, there is a chance that at the time of
> > btrfs_reloc_clone_csums(), there is no checksum for the corresponding
> > region.
> >=20
> > In this case, btrfs_finish_ordered_zoned()'s sum points to an invalid i=
tem
> > and so ordered_extent's logical is set to some invalid value. Then,
> > btrfs_lookup_block_group() in btrfs_zone_finish_endio() failed to find =
a
> > block group and will hit an assert or a null pointer dereference as
> > following.
> >=20
> > This can be reprodcued by running btrfs/028 several times (e.g, 4 to 16
> > times) with a null_blk setup. The device's zone size and capacity is se=
t to
> > 32 MB and the storage size is set to 5 GB on my setup.
> >=20
> >     KASAN: null-ptr-deref in range [0x0000000000000088-0x00000000000000=
8f]
> >     CPU: 6 PID: 3105720 Comm: kworker/u16:13 Tainted: G        W       =
   6.5.0-rc6-kts+ #1
> >     Hardware name: Supermicro Super Server/X10SRL-F, BIOS 2.0 12/17/201=
5
> >     Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
> >     RIP: 0010:btrfs_zone_finish_endio.part.0+0x34/0x160 [btrfs]
> >     Code: 41 54 49 89 fc 55 48 89 f5 53 e8 57 7d fc ff 48 8d b8 88 00 0=
0 00 48 89 c3 48 b8 00 00 00 00 00
> >     > 3c 02 00 0f 85 02 01 00 00 f6 83 88 00 00 00 01 0f 84 a8 00 00
> >     RSP: 0018:ffff88833cf87b08 EFLAGS: 00010206
> >     RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> >     RDX: 0000000000000011 RSI: 0000000000000004 RDI: 0000000000000088
> >     RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed102877b827
> >     R10: ffff888143bdc13b R11: ffff888125b1cbc0 R12: ffff888143bdc000
> >     R13: 0000000000007000 R14: ffff888125b1cba8 R15: 0000000000000000
> >     FS:  0000000000000000(0000) GS:ffff88881e500000(0000) knlGS:0000000=
000000000
> >     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >     CR2: 00007f3ed85223d5 CR3: 00000001519b4005 CR4: 00000000001706e0
> >     Call Trace:
> >      <TASK>
> >      ? die_addr+0x3c/0xa0
> >      ? exc_general_protection+0x148/0x220
> >      ? asm_exc_general_protection+0x22/0x30
> >      ? btrfs_zone_finish_endio.part.0+0x34/0x160 [btrfs]
> >      ? btrfs_zone_finish_endio.part.0+0x19/0x160 [btrfs]
> >      btrfs_finish_one_ordered+0x7b8/0x1de0 [btrfs]
> >      ? rcu_is_watching+0x11/0xb0
> >      ? lock_release+0x47a/0x620
> >      ? btrfs_finish_ordered_zoned+0x59b/0x800 [btrfs]
> >      ? __pfx_btrfs_finish_one_ordered+0x10/0x10 [btrfs]
> >      ? btrfs_finish_ordered_zoned+0x358/0x800 [btrfs]
> >      ? __smp_call_single_queue+0x124/0x350
> >      ? rcu_is_watching+0x11/0xb0
> >      btrfs_work_helper+0x19f/0xc60 [btrfs]
> >      ? __pfx_try_to_wake_up+0x10/0x10
> >      ? _raw_spin_unlock_irq+0x24/0x50
> >      ? rcu_is_watching+0x11/0xb0
> >      process_one_work+0x8c1/0x1430
> >      ? __pfx_lock_acquire+0x10/0x10
> >      ? __pfx_process_one_work+0x10/0x10
> >      ? __pfx_do_raw_spin_lock+0x10/0x10
> >      ? _raw_spin_lock_irq+0x52/0x60
> >      worker_thread+0x100/0x12c0
> >      ? __kthread_parkme+0xc1/0x1f0
> >      ? __pfx_worker_thread+0x10/0x10
> >      kthread+0x2ea/0x3c0
> >      ? __pfx_kthread+0x10/0x10
> >      ret_from_fork+0x30/0x70
> >      ? __pfx_kthread+0x10/0x10
> >      ret_from_fork_asm+0x1b/0x30
> >      </TASK>
> >=20
> > On the zoned mode, writing to pre-allocated region means data relocatio=
n
> > write. Such write always uses WRITE command so there is no need of spli=
tting
> > and rewriting logical address. Thus, we can just skip the function for =
the
> > case.
> >=20
> > Fixes: cbfce4c7fbde ("btrfs: optimize the logical to physical mapping f=
or zoned writes")
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>=20
> Added to misc-next, thanks.
>=20
> > ---
> >  fs/btrfs/zoned.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > index a2f8e7440f8c..9e7794c2ef11 100644
> > --- a/fs/btrfs/zoned.c
> > +++ b/fs/btrfs/zoned.c
> > @@ -1700,10 +1700,21 @@ void btrfs_finish_ordered_zoned(struct btrfs_or=
dered_extent *ordered)
> >  {
> >  	struct btrfs_inode *inode =3D BTRFS_I(ordered->inode);
> >  	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> > -	struct btrfs_ordered_sum *sum =3D
> > -		list_first_entry(&ordered->list, typeof(*sum), list);
> > -	u64 logical =3D sum->logical;
> > -	u64 len =3D sum->len;
> > +	struct btrfs_ordered_sum *sum;
> > +	u64 logical, len;
> > +
> > +	/*
> > +	 * Write to pre-allocated region is for the data relocation, and so
> > +	 * it should use WRITE operation. No split/rewrite are necessary.
> > +	 */
> > +	if (ordered->flags & (1 << BTRFS_ORDERED_PREALLOC))
>=20
> Please use unsigned types for shifts, 1U << ...

Oops. BTW, we should use "test_bit(BTRFS_ORDERED_PREALLOC,
&ordered_extent->flags)" instead, here?

> > +		return;
> > +
> > +	ASSERT(!list_empty(&ordered->list));
> > +	/* ordered->list can be empty in the above pre-alloc case. */
> > +	sum =3D list_first_entry(&ordered->list, typeof(*sum), list);
>=20
> I think we should not use typeof() for plain code, it's more suitable
> for macros where we don't know the types, so I'll change it to 'struct
> btrfs_ordered_sum'.

Sure.

> > +	logical =3D sum->logical;
> > +	len =3D sum->len;
> > =20
> >  	while (len < ordered->disk_num_bytes) {
> >  		sum =3D list_next_entry(sum, list);
> > --=20
> > 2.41.0=
