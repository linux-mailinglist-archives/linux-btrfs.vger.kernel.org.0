Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769D37603E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 02:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjGYAXE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 20:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjGYAXA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 20:23:00 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357A4115;
        Mon, 24 Jul 2023 17:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690244579; x=1721780579;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/Gevenz9MUDMrYAk+hXu3jf+YaSLt2X5dWO0ND66/R0=;
  b=gjPeMElPn91w74tH1/XScCJipy8D97GG2rgEjmmF9I1WO3UVdMZuEfzi
   B+iahXQ0M9OaE/zCXN/rKmqPkQ4uRCSP25QpaQszYTNAliRm0T1XsuK+c
   1xsXENr8cIiE13oXFbbThFbboVkWNG2d1SDzpi5AB5TVl5UtjCGy7piFt
   sPOpr6ZNTCRT+IZksP3QtRUV1eMKAT3lUpnfcyjqKun2XhZ1teRhUJm6V
   hi3InBM6ERu6bl4OBdwgQ793fgyMUPZ94sCSNMd4lbtCKpIoNZ9Q1VCrv
   GATy5JS4BboAt6I8t6NBLLB9LCiP1hJs3MAl8HzDYW69Aymi1xhphMvhw
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,229,1684771200"; 
   d="scan'208";a="239322842"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jul 2023 08:22:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyN7Th7HCcC92HHHGC4WjceDvb3wJwvgJMOKCLPraKToGAykHJ7djUKuL0FsOrzLKXfbpo3tZydod5oOrlqaYysQSnAuUKofwY7RcaNvBTTIsEXXqmKS5dCOB9kRiIHb1lvYPovPizrQa/YAggL1/8x/vlpfqRQUwRKr/hQaL82wuqlQ/49wqlDwY+tkrTIAGuW/vK6dkHecLMtOj6l78yhB1BLzX/Yeblji/WGnOAKv2JcENxEkqWRpR5Toku8NZkATgn+VOrK65fTXC+owTLYUahDiy7QEnuUYZ88rDoXcrSPEjxOEhkuF2h6GuM/RuFjyIUPFYk0S8ebvWYvM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fb5h+QxRE7S7XAPF2WnXsCJU42Hx4kgKxpkuVCMwo8M=;
 b=Q2qCdiL2Nt86DxXGKmR0qK/vCjM1BBEBuKozbcsjJ25JsVi1ndAvScozfH2tbLwYyzyASY113/tEqlMIu8MrSUFXxu5dERCFToRCKUi0md/zEYaEyg+aYsCPNyfq3B1tTOMSaChZBfHtR9YSeYpPLLcmCK6OFbexjILGTzj4IAKuBxQaoncdea0wbRbGTzdQuLZhM/RUMDD0Sqz0NAR+MNhfbND4ZT8Vqpe76QagESYbIPvBJIQne5qM1hRsQFR+bkBjyOKh2gHgwtbg/YobDSmrsbVtn2Csl1emNWFV6SXlKe+F+9jXcgr2zlZZRsUwmJlCdm5UA9AOmQekWPtpDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb5h+QxRE7S7XAPF2WnXsCJU42Hx4kgKxpkuVCMwo8M=;
 b=QXJX/RUo2W1Xtop8WmD8HPFbVw/Eu+gVdrjNuF2CEx77nrx0DCB/93K8QAnc3CesZvHAmm/1rRf2Q3KqWsgMndxESpTXdoOpiQN5s3KM7bXlLTiqJKr0ZolBdc57AxMNRtAEnHFteNZ9G+zFKwQEXfuZwPnlIiaPLInINvDwTyA=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM8PR04MB8136.namprd04.prod.outlook.com (2603:10b6:8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Tue, 25 Jul 2023 00:22:55 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::95cf:429a:bc0:991]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::95cf:429a:bc0:991%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 00:22:55 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] btrfs/294: reject zoned devices for now
Thread-Topic: [PATCH] btrfs/294: reject zoned devices for now
Thread-Index: AQHZvduepXjHXQCS10KL3UE3VgNq2K/I9ZaAgACrAQA=
Date:   Tue, 25 Jul 2023 00:22:55 +0000
Message-ID: <olqvt73droizibdx445my4uekl7gmcmlpkhn6e4oedk3gnmikf@pfpwcncjnxn7>
References: <20230724030423.92390-1-wqu@suse.com>
 <ZL6Ga9zRjBmAEmA/@infradead.org>
In-Reply-To: <ZL6Ga9zRjBmAEmA/@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM8PR04MB8136:EE_
x-ms-office365-filtering-correlation-id: 511565d7-f5b0-4bd9-8d6e-08db8ca54acd
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m71GWXwAaS+d3DFO4YHf/dgzEWF/79IcyODcbdi5koGLfTlQGxZwVUshelSdFtPSjouiXgANN0T4cAWz9iAePbDHTO5vB+D+/l5gF45+ueGwqnQCjY9qbTbvP6cT8Xi2k/G6Rk8FOXX9/3qnL+MpqCNnXVw5BOlME4EdpalZADiByzFEiGucz+GXSqXzw6K618zCs0Lvv0ND3nMjTfDVWfHLHb/WFm5Dii4+F8a89vx3XlbSRhaSg5onnNMYA9JT909T4qdJukZOa4ZfSdRNWzj8WtcWDcHSUHF9WTrkFharD2A4iuQHOB4v1/U+ofxrCg6/eg2MhLA7PPnIhhI0ukQq52/DAJbx/2B1DeWqqSjG/U3oFr2D060am009DrMZjI/CHEaCHozDPj8KuQfX/lQFQHRodxd4NUqYy5c20/4MFVWNU7HKfmg2TLE4voPbAC6ydoWE2JliqiE3mDI3LcBMMoMKwIX4MZrN6Ta721+WA6h3NYwv8+nb3j0LqCZypeOu8Us4uIhzfuAWM2ZoKQxy4VJ1jEkHBee/HOyR62Ya4II+JmX9YjI0ou3vKDF9sOuAcKTdRzPhmPx3ii+8NtXpR7YYmNiG9kvLD3uORuoM0uJFQ9FjWdLcAswWOTBm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199021)(26005)(4744005)(6506007)(186003)(2906002)(9686003)(38070700005)(83380400001)(86362001)(33716001)(6512007)(6486002)(5660300002)(8936002)(8676002)(122000001)(478600001)(82960400001)(41300700001)(6916009)(4326008)(66556008)(66946007)(64756008)(66476007)(66446008)(91956017)(54906003)(71200400001)(316002)(76116006)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZjfqZKO38DizSM4CxCt0koWYqsTKdkyy/9qPnHP6rbDLi4p4t7/WtPcPqNab?=
 =?us-ascii?Q?41Up7nzhP5JE+89HKFj5Nm/Ba/lCgzdMRserfDaGxdlPR4R8iOmcV80NE321?=
 =?us-ascii?Q?oYGMHYKxYqzQhk1j+T3pXMBJqG14Y3gBTJt1TQBqfHCgeouoGia7g7qvhmmu?=
 =?us-ascii?Q?LpOffAsGOf3qIHH/XYdAtbqUGYv+YQVnYkED3stE13R4FeivN4xN4S7V8vok?=
 =?us-ascii?Q?QcY8IK4lG9BH1GPTwIRiWONSq0wwUNP43f7xBNUEGS4vjJMgn4rX0MDsg1ch?=
 =?us-ascii?Q?ZFURwjXq+DH8O+wfRBVmI3n3i7Odd+WdHkOR48Cx2NjbfBnCGfam4j+806LB?=
 =?us-ascii?Q?EmZdSrwtNhIyHlg8h0E5mezOlCm2qZI0Dn/8ZSKCZ3uH37xAciIJ+i5cd22O?=
 =?us-ascii?Q?rknQfPox4/GBW4nAf60VUfxUpnod5AyDgI43iKCGF5C5scXyeUzwpCPnLS1a?=
 =?us-ascii?Q?+yi6Z1crV/36DHnw8iQcJ+Zyt35a0E4iBo14e25eQPep4F8VFEkn7Fj8bVwc?=
 =?us-ascii?Q?7QT/6GmMbaa8ikPMjW/hqgfsNgahMNb5bKQptBj79nJJdClJ5XLYME0DWzv6?=
 =?us-ascii?Q?ha0Fp3hCWNYvdW/hW9qkCiBM0xDZ9vxvO8Of8jTC3zeiPw+Jxre6ZJE06lcJ?=
 =?us-ascii?Q?sunSRE4gbH7C4jeQ4J9my/qyB17xPdiWj64lUVfi7vL6Y/nWKhsOso5ZGoW+?=
 =?us-ascii?Q?8t50QT5QVIqfpo2kDlha0eoemUPvdJnpLAX1kXiF2FVYgIPXeCvFTJQIH2xj?=
 =?us-ascii?Q?q9pO8r7lGq+aR4hTUVz5c5M2lLUGuhzXqryu3j93iqeVVoUmVYr/Por4V1sU?=
 =?us-ascii?Q?TXt0djuXuh+/qJvu232d9Jn/uUfhYOlAzjCZd1rF6dpbTaaumlqlNr1qSqz/?=
 =?us-ascii?Q?f/XhAc+zo45lol/Vw0+80xsSuIOoMljESAYsZVcKE/LCc/TU5Ks/4D8he29a?=
 =?us-ascii?Q?YEryFKdwsd/DuPcB07pae26EwwxDBjP0YEx6c1xdnOc2LTFqU6o4TV1mqAZe?=
 =?us-ascii?Q?B0EmpvD2+zUH/vaj25iSIo3Mgg+8Rd4ug7aftMfiqDf3q0ToYs7o1fspHHO9?=
 =?us-ascii?Q?faITACBsdJ5Rj+WmpEBuoJwYKQQVqFjI9xTfVxGQmyaOGaSy0xPqcx32Zhrs?=
 =?us-ascii?Q?BERphTpoXzrT+2V1lbV54miHTzwIUWCoFFcAUP7dcPSCjsZClYelrlrC93l0?=
 =?us-ascii?Q?DklkAm0Qf8YEsXu1Sb++IyVTZPBz4fUCa6P76DnZEclHKvbee1kUvv+5yAKy?=
 =?us-ascii?Q?DYq4TMNmx5jgxoMX1uJcQ+hm8+r+mOHwVq9nDpDh0rKulI+12mnq94xo3soV?=
 =?us-ascii?Q?AhhD8qfdBtLH94+XB/aktDHgQBk22z0EhLWMm7XbZ5vNnfa6saarJfTE4WC/?=
 =?us-ascii?Q?w7CRuCuhJev06Afss5EDmTlbuMLoL/R+2GKGLdpyHeAHvirc2ZraNXREQcv3?=
 =?us-ascii?Q?o5TfiXBjwFm8X8gNLhbfIj8XadMrVYQYXtovOyP6tYuNkyUX4rOyfRpTFoTc?=
 =?us-ascii?Q?xpnH7DUys1kWS0Y0y+V7V4kqKmQUDaRNfdAi1V7S40CtGiNmvF8mlyNVAzTS?=
 =?us-ascii?Q?J89V8NqyUXxOBkFBWvvMWoYAF+nZPM54/8pwJ/xiKVfQyZ2WtmgYucdgRw/r?=
 =?us-ascii?Q?oQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D99EA87E40AD9F44AE32D75E70776FC8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fxh7Is8RD4wNZqpcdyJBmNcJxPVCHmd5W79UOoGXpoQhbr2C0w1EvZZYYWZYxQEFgRYo6oKsDYezKs3/ZGJGNT0HeLqe9AjrQkZxQbdZvVRedk9Rpn8j7pnRfs0GuCwoa06h9l+T0Z7f9Pskgjb8vvWim7PZ+GF69+nd+oma6QVAB5b7FZvBCvskNHXsnl6TsajpKzv9WUVUA+juPUlCgK5idfa90Fg3v//PVf2JGrVa8jUOIE458sJVJH5oDUR4Ksok2xTNfevBVYX+9kMQNsAmfNTrmLxExud0Npy4VjtZdYhTu+XXWtfAhOsh5kXp9RUToqX5HsLFg9J/ZytJLv9fw3KhBhfac8zougRtbwGHuAiJXrr+jf/mzI6pzO9Q553z/owWR2GYdoDVNTteQWl91qGrMBv+m6aJpF4OxYsizPmgOaDw9Khr9zCRJoCunHCLsQtiBa/bErNx1OfO+lKlFAlWdyprINx4Rk7D/WvfHO70IQF23E0RnTN2NU4IKezmn7BTqtS8ZbFzVk4Deik7v9/ZRtgTv/RTSidCS2ickT/hwVJo9hkebDoyI503kbfcjK9NIIkP4Dn/9MVSTl1lFSZGeK9ROaFLZxQ2ekH+hpa2t2wAG/9JpkvwVM9Jxc7g8Tt6VDIXPTJ3ZT8H/uSWsfYoo96s65w4tUdDynuGR73ZYglIU77a1MR8tOkyMr+E4/dYdk55qNw6Hxm12AXMSkNRpgFluNYsj0SO84JFQ1VH2kOal3mv6TqvQL5h9FdABrkd4sVyv4n7mMUMhUKyU6d9mDDHNM3WzYvJAlB/rnF8Ste2nEAH1TsHh936eLfWLtz7WzxaF8xMhyHkNw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 511565d7-f5b0-4bd9-8d6e-08db8ca54acd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 00:22:55.5196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h8xd+dTRb2K4unntAMMZJIwfF70s8ak9kLrw288WKikEEC4T0jknESKwe+X+SBKlH3uW44x06izg125sMUpQ7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8136
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 07:10:51AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 24, 2023 at 11:04:23AM +0800, Qu Wenruo wrote:
> > The test case itself is utilizing RAID5/6, which is not yet supported o=
n
> > zoned device.
> >=20
> > In the future we would use raid-stripe-tree (RST) feature, but for now
> > just reject zoned devices completely.
> >=20
> > And since we're here, also update the _fixed_by_kernel_commit lines, as
> > the proper fix is already merged upstream.
>=20
> Hmm, instead of spreading these checks, shouldn't we check that the
> RAID level is supported, and have one single nob for that based off
> it, similar to _btrfs_get_profile_configs()?
>=20

That's beneficial. We need to declare which profile the test going to use,
something like this?

  _btrfs_require_profile raid5 raid6

or

  _btrfs_require_profile data:dup

as the zoned mode cannot work with the DUP profile for data.=
