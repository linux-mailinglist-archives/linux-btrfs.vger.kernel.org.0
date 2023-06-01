Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD7F719216
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 07:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjFAFRc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 01:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjFAFRb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 01:17:31 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6CD129
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 22:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685596647; x=1717132647;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rTbELxjN6f3VPr8OnGcvGH4nRPzoXJuwyaepRFnIboo=;
  b=GamJtcE8PVFS0qk45p9VNiJdhGaENMBpSF0KL1BZJQ3D6J/MSYmUB1Ix
   3h+osMeVu2OwGG5PLVBTNBSV1djCAxnJG1YNamNQMfEUV/F0I28Q54K4f
   ZSQoFngxMlMJ3FpHl6k5vM9ph/yYoPFh094+cRpSjJl5xyXnAeHw6gOLI
   Q7xEe4DWNyOmTaJdgr2TkB/KV7eKPekzXlXm3Ez/9PHhdEBacUKnF9GJ2
   ivi2F5mTVilB3o+BS5K+inQP9M6ZWtf+hY99gT4zkGN6iZv4Ir0ted2Yn
   MsaGmJRtza8d6xTvnxL2m7ALL77WvKoAaYXAzsuYZ4KkGkJeaWcDN9jU8
   w==;
X-IronPort-AV: E=Sophos;i="6.00,209,1681142400"; 
   d="scan'208";a="230274411"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2023 13:17:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9CEtjnwN+FHTlthYcj7t2ILusZj8URJ/4GIrsdK9E8gsU5U+8O4x7Tjg4FTqOVSeXFByH94qNBH/tSQzXarMCgGHyqAJNidHXSnp8b503Nj8sWfFT+KaWtsYmkEpxEj8LSh1tsyRy1wflX5PeZtp63tVhIjmvE3Oxl1q+Zw5B9HEXdgbHVoO27nNau9pQSx8tpqoiqj3SvqqKVz3D5OSgt9xAn4xZ1/Qvkl6HeZF48ovrnUt6ne3EDJBCkKxb1l/AU9dW7AR+nXvQXGCQ8CM8AcjD1XZzHVxXvX5tiV62U0y163Ch8/GL411DOJoPYce4CEOKHSmW9+I7ZrNfGlPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtb+1umzwCxm1KwstATEVTj642Ho6VGFoePS918E7sQ=;
 b=HVoylf5KfLQ4n4JCFH5qz2+Z3HuVGdaqP8y/b4q1fg6VOD3yqrnNbviEJIzeVx/GsnaoBc5QWHTlc3LImkyHlANJHjPxK0qo1kvUPjBXiPLqAWwz6DXBFxBV4hgNl3Yzy9wImHVViLItc00RBgbkPbj4QIoTHngCQyLlWh+DTubRiin9T9/QQ0LtTiqs2Lawo+NBcZx0GNuqRW60q0+cxjNrc/JfpApKzIe3McYbxPKSooyf2I5dABlUGJb/ALBf8w3OWNs2viNk2lbRsuBbI5WIXTL3RQkI4WtKoVAKl1UoUbO2JUV5VqljsDDgMSjIYm4PdJOEuRIAFdwY4f9ziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtb+1umzwCxm1KwstATEVTj642Ho6VGFoePS918E7sQ=;
 b=OCdQtyM/P5LyOIncF6TL6kaUdIv4FRUIm1OJsa3w3iWEvOa91mpWDBHplOAbrIi8/Krf6x8RYXj7Wi3hoTyXVjtyyXxTk6rANknnKML4vv8OY98ovPW1NhpltQlXP2Hv5mIY+Fv9zprBm+a0tuozB68W06m5xTv1c9FP1PYrhKM=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CH3PR04MB8795.namprd04.prod.outlook.com (2603:10b6:610:180::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 05:17:24 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::b52e:3dc8:52f:b0cd]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::b52e:3dc8:52f:b0cd%2]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 05:17:24 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: new scrub code vs zoned file systems
Thread-Topic: new scrub code vs zoned file systems
Thread-Index: AQHZk77Fzy8DdBvrZka6eWlKoRbYIK90WyyAgAACsACAAAFQAIAAAYIAgAAJWYCAAAPKgIAAxt0AgAAqPACAAAWeAIAABKoA
Date:   Thu, 1 Jun 2023 05:17:23 +0000
Message-ID: <gn6vj3mlwsm53iu4ktso2dts4ifyxaky54ivb22laq3mqy27lv@guvvxohmkxy6>
References: <20230531125224.GB27468@lst.de>
 <546fad79-f436-c561-8b9b-0d9a7db09522@wdc.com>
 <20230531132032.GA30016@lst.de>
 <821003e3-b457-90ba-e733-8c2fdd0c3b3c@wdc.com>
 <20230531133038.GA30855@lst.de>
 <a59b2274-9d64-f11e-f726-9283f560a495@wdc.com> <20230531141739.GA2160@lst.de>
 <134e56ed-1139-a71c-54d7-b4cbc27834a9@gmx.com>
 <20230601044034.GA21827@lst.de>
 <dcc61893-c48d-e8d9-3161-7f7b965b8e8b@gmx.com>
In-Reply-To: <dcc61893-c48d-e8d9-3161-7f7b965b8e8b@gmx.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CH3PR04MB8795:EE_
x-ms-office365-filtering-correlation-id: 4fd3bf44-7f9a-4864-14b6-08db625f7baa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e8xdUezGTCsnmTo5Q7+PnDVRufdFCvDlmpg259ku/lJ2llvT3lwq6ZU57SeKvgFjTt5Uzdhshik1FunnCXw3CphYMQgc4iIv4RmXUK5rRPmulPjOYjy6NiTvE8770qcy7Ew6XERiKGmzS47RMROvuSiVPMZyayVX9ECwzxIDnYhPDHmIy9HF37yTvM26LgcybOByvbTq9R5yAcV952K/8Str31nShk530+DNnUmEwe5UJJTFDv1+trnA/vyq6OTT+FI7e5kL5AsknU99xNtYRCL25kzbytofZHUSsfzW8NeAOFR2NvdcVf6Z78Keb9lDq3PKlR/FXof5tS5Yxz1lYdihpvDeFa9u10CBWYwZ3SeHndjhwdNxazUD2e5HKN4QMmvYC9dfTgpLR8gCWT9KzMuuBiCzYP5QoFnkpe231P+pSVEQlBFSNm1K2cZIBFI0WLM2uUA9iPhDX9MaoeyTYBDpYz8VR8whSIdURHoml1SNaV9RqC4bbeT/a4UlPAGKFCB00bmtDORhg6UR4G7y3HoIWMCHCqdw5OhX4h1yfrA8X0Btfz09/kD7x4OVFE6zmPf0r87LVaTYuni50G2uTd3pxkQ97WkDqztI4/rGkxLmTTbZr3R0WMBydLrUk2fn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199021)(91956017)(76116006)(66556008)(66476007)(66946007)(6916009)(64756008)(66446008)(4326008)(8676002)(316002)(41300700001)(54906003)(5660300002)(8936002)(2906002)(71200400001)(6486002)(478600001)(186003)(26005)(6512007)(53546011)(83380400001)(9686003)(6506007)(33716001)(86362001)(82960400001)(122000001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OWsGqbaawUkA6bqBzRzMW7j9/eBRYPHgd95mj7+gHX1k6CqT+roRE4oah6QD?=
 =?us-ascii?Q?IldsZH8nM/JRtJ40Cb/PjJG3QvgGLIJUNRlGieGvPF1XzOgJfOMESrODMaJl?=
 =?us-ascii?Q?5Tg33lIVFaQ8BddvYjFEclFafq+cehxIfw+2ncPhX+oysfuqGruAq7BCzVep?=
 =?us-ascii?Q?n0O9JE/pggx8IOVOvrcpsS3iXtLAkWxQIpCwzLzr5jm+HvdaT0zgFkyTM6XK?=
 =?us-ascii?Q?KEp73sHp8AR7ZaQGDzacJqDLGKsLkAzZCF1RB7twajpRXVFRWxfdnMmZMR0e?=
 =?us-ascii?Q?5y8VTT4Rn8LWbhnaDR9/0PJ8857Zk1Y8WrlZ1GlNxcF24gmglx0NPsQI1uDF?=
 =?us-ascii?Q?p1Zfo3Dl31wz+K75D1fNwLyWrGyZtFeUcDlVL/eDe9AMMsmNmVwY/LEr5wEm?=
 =?us-ascii?Q?oC/mWCfLa+Yo6Kjauxtoi0+8nCwDYRhWy0iDEhUu5/Itk+CRTi8gyvChGt2y?=
 =?us-ascii?Q?PJmSPmIE4p70dvrGK1zeiAiEXic9ySnqIBN84bOLKUv4vm38vLRuY7ZRwSDZ?=
 =?us-ascii?Q?UimOIu/DzqK6qwcW6eBRf+LUtHsZc4iAM4OyMIoSHp3i29KC5DNn22Omq7UO?=
 =?us-ascii?Q?Dtohk1Q6x+o+dbqlN6bkZJ+RYluQ8rEItd7i2lemGCmOB3jr0x1ECHlgpQhy?=
 =?us-ascii?Q?RV/AbSgTRhP+hNjboZKhFqYyRoNSi8pRj7pMVj0y9h3avfcsvYKJHeLQBAlo?=
 =?us-ascii?Q?pc6zkYRB27FccAXgvXL9LZg+/lnmxoMpqfPGUw+7Pl9mvkBwpIp2HH29w5o4?=
 =?us-ascii?Q?eeRoWGlIpT4KdmI2WLAu7s1aM98+fZ5L38eQgdLGGdioEAyZKj0mneIUBffS?=
 =?us-ascii?Q?zgy0/f607L/eGqut9t59Zh71v1lqq1U+vITA/v1QKUn1mEy5G5UdHfaBxac3?=
 =?us-ascii?Q?WAfjsIPtJYzp7/zN8Is4CBt+jyoZLsQdA3QPFQhaoH2APs1Psn6FuKUz2vvG?=
 =?us-ascii?Q?eU4vMVaWciF8b14AE24lTYnqpU6O2yOKwNgKb/esr71RcFpNd5QLiCNq3tnk?=
 =?us-ascii?Q?Fc2A2c4YwebGf9F5IiHTsNoz+7MVaZY5yqaY66nQA2Ob7xC+tdpx9uNASifR?=
 =?us-ascii?Q?W4I1ISBHJSgTjQ6TBnXKN3SFYIkxvN7m0C2kYlx+BKDpP9o7uZpecORGuw9k?=
 =?us-ascii?Q?Dc2isZ+DHOewrWB9lw17N/Y8dPKdZd5IjpdnXIoPXDCe2dS5yBVfwiGOtbDA?=
 =?us-ascii?Q?euB5sE8pc0mE+gzk8jxcoyctlFPumLfv1L68Hov7Tl/R/uy1pjmQzaH08JU/?=
 =?us-ascii?Q?iCcGA051as8OJHCsXEe7Myd+JesHRsTVaKv4JTaJAARAncTt2lJRFx1qMDyi?=
 =?us-ascii?Q?I2E6nUHj3U+NhM/hai/lgEFGW5/TRPu+LViA3eHKkXoHaQGLQs74el55o7Zx?=
 =?us-ascii?Q?TNRTCv0JX/VMeH4djlLNOGVDJ7k3fRvgKxuToZ9d9HHQd36med6et4e3uidi?=
 =?us-ascii?Q?Y40lsLBj8kI14LQAakaMQOCMoXt8Ltk5crvYxPtHh65vlWdrCM89q5ZCztul?=
 =?us-ascii?Q?YGK7oFZp3IeAUhNKHbSxTOocvCbvyjM8DQvgIjMpZ4LscxWCfh/2OgtCA0iT?=
 =?us-ascii?Q?Yxfzd2WO9OxrtCvCeGnd/I5vAuIXhzklOeyY1QYR4K1Do4aOFciF+gX0msNy?=
 =?us-ascii?Q?9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9E77FE5E1F27E34AA246F17F6C63E497@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hb+1r7aomjdFbTMeTfiI0fnMJ+TJ9WGXXZtN3ArEfg9pn8vPsAYbJZ6/Nqh07te9saWraHVhoW71FoOgis3TbLSRDjmbUUqjNZtalPzunfZYWUKS9cbitpnAO+1QmnctQOKR6r/IoTG006q/SkmVb6kL16HcE1+IvtcXtVrHo4RCb4KjmlI1Ec5bfVdXDDJxxbN7Ag+BuJ98kv2ppINbgEeGdG1hyikWx2if3JvI9Rmovqs4LOk8sx7AH3LIFVhkyL0FdZbSGjWKEs96zoeuESywbnYwwPW1ujsHsfQbmBtMp6vKKDmO6j0kTJZUVzpI+RZ0dencXpvAADShYz0Tb2iAbg9xqbXbSKNHTXt8EoLTb9aYEvF6eStjuA+ZlJ6GtQDpbMpLGFxfIXY93yvSqfMKzw+0TYXrSMFFKAbnZoo3GBPi1GrqpDa637rfbs/j7Ehmllrzr2gxq/2kvL7Kmr+GF/800lJUNIJJhWFZyuBTc5vIlElHM4Es3p4l+4j/DyClUleZuf1WvVV61qllmpBpjO1T0Rh0T9byMe8fzwuWRmzBcDjl0mm3kukv1BC9VwC+Hbe8QlK+HgPqEGTbQACtMqVHgTtJcpduokUz6nSwz6CbTeXSdhIzmGbreBzDH06yoUSkpyY693aOGZ1g0NjN8VA9g/rWTHT/QonwI+dtDj2c85LWDXv5jEMiZBZ7eWLBnzhaW+VMd1j1+RnUqO1ac5XADanSBSc0yNsvsYkN9SSw0s1apmz70wmrFNL4PZUNv79HE6Wlh8sMpq1aJge1K+msVJB7forV7akHyjVwyqqM0ZGkCRaYG6wLd/g3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd3bf44-7f9a-4864-14b6-08db625f7baa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 05:17:23.8986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JX+fiF8oKPFrVtcu+xc3Z/PPEqFc1U1K8FS5na2//okFyXiZsVwWzb8200qarbVPyJ7a0N97kTShaWjAjqRXtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8795
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 01, 2023 at 01:00:40PM +0800, Qu Wenruo wrote:
>=20
>=20
> On 2023/6/1 12:40, Christoph Hellwig wrote:
> > On Thu, Jun 01, 2023 at 10:09:24AM +0800, Qu Wenruo wrote:
> > > So far the various wrapper around the write operations work as expect=
ed,
> > > and hide the detailed well enough that most of us didn't even notice.
> > >=20
> > > E.g. all the zoned code is already handled in scrub_write_sectors().
> > >=20
> > > The crash itself is caused by the fact that end io part is relying on
> > > the inode pointer, that itself is a simple fix.
> >=20
> > But the reason why it is relying on the inode pointer is that it needs
> > to record the actual written LBA after I/O completion.  So it's not
> > just a case of just add a NULL check, it needs a way to adjust the
> > logical to physical mapping from the dummy added before the I/O.
>=20
> That's all handled by scrub.
>=20
> For scrub we're doing the writes just like metadata, with QD=3D1, aka,
> always write and wait (and know where the write would land), and for the
> gaps we would call fill_writer_pointer_gap() to fill them.
>=20
> Thus we don't need to do any adjustment (unless you're talking about
> RST, but I believe that's a different beast).

True. For the dev_replace, we need to place the moved data at the same
address on the destination device as the source device. Thus, we need to
use WRITE command to ensure that.

So, calling into the record_physical function looks strange to me. It
misses some condition to use ZONE_APPEND?

> >=20
> > > But I'm more concerned about why we have a full zone before that cras=
h.
> >=20
> > I think this is happening because we can't account for the zone filling
> > without the proper context.
>=20
> I believe it's a different problem, maybe some de-sync between scrub
> write_pointer and the real zoned pointer inside the device.
>=20
> My current guess is, the target zone inside the target device is not
> properly reset before dev-replace.

This must be a different issue. Are we choosing that zone for zone finish
to free the active zone resource?=
