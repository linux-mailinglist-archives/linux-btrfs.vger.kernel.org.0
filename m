Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4356773F9
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jan 2023 03:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjAWCN5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Jan 2023 21:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjAWCN4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Jan 2023 21:13:56 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D89A13D76
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Jan 2023 18:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674440030; x=1705976030;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CNV4NG4P6Eg5zxmOf8vG6eZFKvhtltq2E3muc1cXiZM=;
  b=OichUEV8ByHnRnuQOkBcsmaZo11DclqZB00myiVt77fSB6tx98EUUyu9
   5EmGtK+qVs92M5dTXV5cc92s6/sSEUA+7Uh+SYqIaJtIspxIj0zy7QK37
   BOJ1FCVHvlx7WGr83vOnvqG/w4dD847E5wc+D+9WHABRKfl0JTGD+s1kT
   Bkj49hhBtKQ+P0SLmpkZfkwdnbmh8+td2SYCP0DXizMVlkG+ubIv26Tad
   1h5IPR+TPw9Ppz9hhfiH60U8+fFigN74+0Z0+96cHlT8BhtW2NYT60o0y
   SyyEovmjEikd6vq7B32Xw6v2oHTn3kS4MO/lm4GU/DqqAmeQh6HcMI0P0
   w==;
X-IronPort-AV: E=Sophos;i="5.97,238,1669046400"; 
   d="scan'208";a="221584565"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2023 10:13:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d70g8/ungO3sAIJf1U9gg86ghJNjfkjuyU05uMD1dVMEKcwt4mwfJkKHOkbQnt3KkxFeLPCu82oJKQWCloLQNTjkSZcok12XlngsBRWHq4Lw96IGtLMVJE1HdhvQEB+WSXcqNXQYuYPAh9IDpmRfZ4i47Emn1uzEZyy2z45vvCss8fZAu+gy5e3EYPo0TrBCIjygcmmLXg0zgrjUPx9sqouQK4Yrc55lTFbTDwpVIshPbsntLEmsc4L/UnfDiTwWdJ0nJ5J15IM2AMsdCIRcr/UqzEIhTpBvfB6X8uRAZ5dzoBG9BUYtjmHX7RQvJtG8wImu+9+zhzmPFMeyh+7i6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35iA8IY5fap7sw3wekvBWSbkk3muwxBclJtpzu9F6Hs=;
 b=a0Xbtwob97Yh6y1qgkUnfb0nNK591FJI4HbkElfWmIbVFMjoZgmBmMEKhtEzrWbHt5pJqL0oSKYSjU2r5m8/AWZFlF52XUGri0BN/7+bYi0+98uhsG4A9AMGchjR1faHWJsXsQWsKWSAq/rmSkQPP4U2A9WMYcWvJ6kGnUqthzbPfR4hGP5LsM8HDbIDwxH9bOvhHG3Ry1AwdY2ZeCIzBq8JtDbkj4hB2uYlDyl2H7hPB18DmbpqS6dupIK7Q+TmDBLoYRLHgg1OKZ6om0PU7xMJA66W8VFvfnSuq9QqCZZpDVUcmm0v/d8akKEzny6sckB2349mL0B8p0JUKKhqKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35iA8IY5fap7sw3wekvBWSbkk3muwxBclJtpzu9F6Hs=;
 b=x59a7OLYAACfkoSC5KlNayKn4/b1yEA5RxnrIKoguun99UgwXaRawbaIpM4wB6qrQmJ2dcOeF/AUZSbHL0KPBfdfJaavf7Sk4O8BFVz/KhS8qCIjfLrRGyZJIwPX/y8tN5CttO9MlpWROeKhd4OpCcIXzD8AmkKMc95rm1kNGig=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BYAPR04MB4327.namprd04.prod.outlook.com (2603:10b6:a02:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 23 Jan
 2023 02:13:46 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::c080:1687:4429:ed73]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::c080:1687:4429:ed73%9]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 02:13:45 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/9] btrfs: more optimizations for lseek and fiemap
Thread-Topic: [PATCH 0/9] btrfs: more optimizations for lseek and fiemap
Thread-Index: AQHY9cPqVfDtAIM+a0yo62/Je674uK5ruiKAgAAYl4CABHf8AIA7amYA
Date:   Mon, 23 Jan 2023 02:13:45 +0000
Message-ID: <20230123021344.jnxjlwhh5cod5evd@naota-xeon>
References: <cover.1668166764.git.fdmanana@suse.com>
 <20221213091107.aezonr65mivb2ijq@naota-xeon>
 <CAL3q7H7pdt0jbmGMV7mr0V6kT2_-VYF=6B-TiGke5Nkos_TfzA@mail.gmail.com>
 <20221216065336.abwmu6zk7yvkwfgw@naota-xeon>
In-Reply-To: <20221216065336.abwmu6zk7yvkwfgw@naota-xeon>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BYAPR04MB4327:EE_
x-ms-office365-filtering-correlation-id: 6fcbe692-a97b-49bb-199a-08dafce77504
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qwO00Yp2gauFXLwjJ59QWxDx1xkyANDW5RSLnlTVo89/RYoBqM1KeilwGuUBfi9gG/J/lHYEErovgOh3MdP0kOyZiKJI5vD2YSgz/ChP0tAbNY1Vl7VVfYg1vavi3249r50XZxzfPlFPBlPBcptTihrDAXOhDxWCqAPZ93Y8HWt0MC93u+Tcdm5llrzOMkoMFmipa0UOZyGDKE94n+GLtI+cVSY/qmZZ7ZfEue4eymu2l8tIk0oDb2dxnkjAkiTPP9HJJBjnH7sk4DDNWUm+ty5ekYY8vtlKENgUJXeSRDaaL28Byn6eQhqlAP9o2TazoQJif0X4GUPY/KNnaJPcH4L9Zv4jWpob1YhwJqUhkjB0YPdMxs0KF9gS0v98X04htOr7a3sv2IHqI+a0+3orVLfsQ8I1gQ6MWN6PFkyeDUOGC3MS9j4xb3Jg6rZmb0qp1CUONENctyoKBywyPqnrqQArX5ky5aor5JXuIe7+JV4jYOltkTiRTUX6uoeerl7YanNzjsWSUoy5ILdsqQWI/rCmXyDWvZa12MKYUQKUsMPlgjwefeUgm2FC1tNWqJU8uF9ugaAUf3MGl+VM0ITQXn3DKb1vOIv4Ofu2e6fltLnJn+XdB3b29B8v4HHnMqqiqBzsx8b0AdGu/YBfynfzWfkZa0m2qWiutpVH4N3/abidiLe7uKRd6hiDfzjVmJDV5SnZb6TQMC/2ugdqq/lqsZe06VxUN4aS7bAV4PNRxnn1SoCDDkZN1vKL6JGW6irelU3Udm1sNxUTfUaeBfFqqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199015)(33716001)(6512007)(6916009)(1076003)(64756008)(4326008)(66556008)(8676002)(478600001)(76116006)(66446008)(66946007)(91956017)(66476007)(9686003)(186003)(26005)(86362001)(2906002)(83380400001)(41300700001)(6506007)(53546011)(71200400001)(6486002)(316002)(966005)(82960400001)(38070700005)(5660300002)(8936002)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2cvmnqubINBfeED86rGxAoJKPK7iW42IWyw5MPHj9iCMewMr4McYw6xeCdvG?=
 =?us-ascii?Q?EQkPtVtHlfoCOrvBEBSVy+pCPcCQZy2ORENgXfJqKeTVfQaCZ/UgngO0SD7d?=
 =?us-ascii?Q?JTYRzEEwxaepEuD3iPPW1ZnX6PVFNkm6RFVo+crK4DZOLJU089rWvlYDcABd?=
 =?us-ascii?Q?IVczECv2jI1DotUuuOD3eeo9klF/GWvlXKCW/uvQa3WVHUv1WoCJPrzPEW/k?=
 =?us-ascii?Q?DrqS0muZM96fziTp83/lIVaJPC0EOqaDTiQet4FJVkGjuok9D7Eoi8/KVxMZ?=
 =?us-ascii?Q?2RIeiVI+H9Th91qAcXtxX084AHawSIjN9v2aKF5RLhZIRn4nkW8xwVV3oNUm?=
 =?us-ascii?Q?RpzJ9RcsiFUhLI1cx2TNOtRLaixt5NX0jKuaqtew30gAdH/FoF6ikcaQg/pi?=
 =?us-ascii?Q?QFbUtoNxFHZv1naYiDTP/1+idPBmLGm8Z/URg0MW/n1iP/J6ZNFrdnpjywU4?=
 =?us-ascii?Q?eBTCk1zASuk2buQVgrSBuVZL+NIKKK+kdL49svx1cFYrLWtojUhjrRAPFMm5?=
 =?us-ascii?Q?g38yDN7oIvo3JtRqcJQxElFUAs8u52XMTRRtX0p/86nReFUtyfIoiay7npo4?=
 =?us-ascii?Q?BWh/+TnGkSnen0c5KfU64bIq5QQdzm8Pg5bw03VBfcO8dfjdsIeKulKUM1xw?=
 =?us-ascii?Q?3plJ72tcfb1yR5TfvufnTaXrJicnDyxWxIPXyJRxa4oLljpNmnEgcguSvJyi?=
 =?us-ascii?Q?nXgiWCDR5sV4nu+f9x5KiEu0AauAikyqWdy6Rxptc/hMXqB1X/wXUVUWzpzc?=
 =?us-ascii?Q?mZgEWTUDhysQf3cKP8hZXpyVppoVs5fumTr7ML84heOxjesjhjuxizig4TBd?=
 =?us-ascii?Q?Xw83ABy108uwA8eE51a4F2vaZZQQnDz7+gA3Wu/CTw3GFQ1XzBRw+WL82HUI?=
 =?us-ascii?Q?gTweWHdJ0d6WLFyDO4LQtFrf0XdSwhRyywD89gRBakCOqjKdpGUEVQCnnpwv?=
 =?us-ascii?Q?AI0wKQiTuSV0nn73dFuX6llANMn2pOM09wk+FHn/9NWN+H4suY1Y6VQb6Yp2?=
 =?us-ascii?Q?yjzN50EZdAWFRe7bLa5OLCwsDH/iV78AA7ogY4TWpAijdbkYT2IDofYT0+oQ?=
 =?us-ascii?Q?UBi8StR0TiCsqyrBw/xKF1+XG3glJXhHF45bZpimZyv8W4NHgpr3suGWrDT/?=
 =?us-ascii?Q?Z2pvZ0xZCKJRxRa94SKM301J5E07JnhBzszcjJ6PlYB0VvJMRLenHkgSnsU7?=
 =?us-ascii?Q?vuJMsBkN3pOKyuG+1pMhEA7nkw0dKhCzDNm01uAprgkNHNLx90fgSvSSs1e6?=
 =?us-ascii?Q?eWeB89D9SI0abFrWbBlcFA2MK7dFdnFmZ27SqWvF8RttDQX1+K1fAo2Qc/EO?=
 =?us-ascii?Q?MtLf5i+6kszkUNHwLDAIx0/11rMvStx+JL2vnx30QLeSIG+rnKLbn9tmn8IP?=
 =?us-ascii?Q?FTNBhHqxe+kTubIXZqWHid1jUcWUGtJtudRpapPrmavRYZBvafWGgjLHVQ1Y?=
 =?us-ascii?Q?cvdvdWTItdmUNbRI9sPjgnLlaj9dXo2+Th+ue+NymCCVfpJ9an0eC/Rp18KY?=
 =?us-ascii?Q?mjvL8pRHYlfqD3juwRShdasRgWxqLEiUz15ZQ9/cxD4eNtU07PfKxVpVVxpn?=
 =?us-ascii?Q?m9m+rgVQvA5q5S9XMhHRk4Q+Z7Vfagy68zxv1gXkIW6Kpy99/nEXJlq7kJbl?=
 =?us-ascii?Q?Cw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AF5F98FA68F8B344AF9C32F017556071@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JT6n6hRVDq5ly8M0vCXv7ycRuRsc2Sp6MnLwU/dptPH0ORofCxMAHCi2Fv7e9Yb/VLEy9p26yfXcsRqljaKxwTIF8NGIkwZs+yoT+A9+voZ1DOrrwn412mR9f6j74qgmpLy6EDXir47HidFkPl9i7oE7uwb1139ZGKSJ9THq3jIYYUlhepX18Mu6hfQATRwLt546sbiCTLqgH8fDw+IYC8CWsKr2gdtqGMVx5VcC0wFwKq5DzFAsNoCfoxhHSaKDjbeBmfUU2cFv4/4pt8+VnpnDYnONfah+teejA0g4lddvxeNmsyhmVm/VsIv/446ugeDwTLpXSK9g7GffMSjneI0VRlsWCERUhK4NvgArC8e7EoywT5ku0yZM52d2nG8m6NaqABJAsSq47nYpUhLDVMFgW+XfpGUVh0+vhThg8PbWrhKu/9NPFMtSkFFYbdxjV+42hlQ0zkKNduEP3lqYkaKUX03eIKAsZCWjX0uwZbLB5QN1SNxDnmjqfJpxwhCKXblVimz9JPA0PBgU/yRmL2UJZLUtdWrcilTgas3nZku7Vt1GqwvTtPhfk3wkXNW4fd+jCf0hZXplLXaB9+OlMKv8Es/mUG8kIAqiYAJZQoxuupDlEc0Xugmhz5RDAqmcliyg1n+H8q1PlIJJeKlxwceqcf7IRwiIVs8BFAZqp+paVTn5IooDzW4jpRQD+hzHJ0wl82fDTRTMVbCuXD283Y2jGy6dl5M2M2cYcWZ5EPf7Zbm3yeO385BR0SAhlP6iV5M8qkLs/Q+o2U6VmoLIJRuqOm7MyZuhBVGdLaVoKjrh2lToDpABbNtzI8cKrBhV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcbe692-a97b-49bb-199a-08dafce77504
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 02:13:45.7038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RDox34b0qIbfFJBmh3oFKHI7py0QFGTr7f7eWGqrEFERPT1PJDgNVlo1kX5t7FB7B43dW6P/5Z6xwCtPQTdrxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4327
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 16, 2022 at 06:53:36AM +0000, Naohiro Aota wrote:
> On Tue, Dec 13, 2022 at 10:39:07AM +0000, Filipe Manana wrote:
> > On Tue, Dec 13, 2022 at 9:11 AM Naohiro Aota <Naohiro.Aota@wdc.com> wro=
te:
> > >
> > > Hello, Filipe
> >=20
> > Hi Aota,
> >=20
> > >
> > > Thank you for this series. We had a performance issue on a HDFS write=
 only
> > > workload with the zoned mode. That issue is solved thanks to this
> > > series. In addition, it improves the performance even on the regular
> > > btrfs. So, this series might be worth backporting. I'd like to share =
the
> > > result.
> >=20
> > I'm afraid backporting the whole series is not an option.
> > It depends on two very large patchsets that largely rewrite fiemap and =
lseek,
> > focused more on performance improvement but also fix one bug with fiema=
p
> > extent sharedness reporting.
> >=20
> > In reverse order:
> >=20
> > https://lore.kernel.org/linux-btrfs/cover.1665490018.git.fdmanana@suse.=
com/
> > (introduced in this merge window)
> >=20
> > https://lore.kernel.org/linux-btrfs/cover.1662022922.git.fdmanana@suse.=
com/
> > (introduced in 6.1)
>=20
> I see. These are huge.
>=20
> > >
> > > The test workload is a system call replay, which mimics a HDFS write =
only
> > > workload. The workload does buffered writes with pwrite() to multiple=
 files
> > > and does not issue any sync operation, so the performance number is t=
he
> > > number of bytes issued with pwrite() divided by the total runtime wit=
hout
> > > sync. The total pwrite() size is about 60GB.
> > >
> > > Before the series:
> > > - Regular:         307.68 MB/s
> > > - Zoned emulation: 269.32 MB/s
> > > - Zoned:           231.93 MB/s
> > >
> > > At the first patch of the series:
> > > - Regular:         349.84 MB/s (+13.70%)
> > > - Zoned emulation: 363.48 MB/s (+34.96%)
> > > - Zoned:           326.40 MB/s (+40.73%)
> > >
> > > After the series (at b7af0635c87f ("btrfs: print transaction aborted =
messages with an error level")):
> > > - Regular:         350.22 MB/s (+13.83%)
> > > - Zoned emulation: 360.96 MB/s (+34.03%)
> > > - Zoned:           326.24 MB/s (+40.66%)
> > >
> > > So, before the first patch, the zoned case had poor performance (-12%=
 on
> > > the zoned emulation and -24% on the zoned) compared to the regular ca=
se. As
> > > the regular case and the zoned emulation case ran on the same device,=
 it
> > > shows the zoned mode's penalty.
> > >
> > > This series improves the performance for all the cases. But, the zone=
d
> > > cases have far better improvements and it somehow solved the performa=
nce
> > > degradation.
> > >
> > > Also, even only with the first patch, the performance greatly improve=
d. So,
> > > interestingly, the first patch, touching only the readpage() side is =
the
> > > key to fixing the issue for our case.
> >=20
> > Backporting the first patch only seems reasonable to me, and it
> > depends on the following one that landed in 6.1:
> >=20
> > 52b029f42751 ("btrfs: remove unnecessary EXTENT_UPTODATE state in
> > buffered I/O path")
> >=20
> > (it's mentioned in the changelog)
>=20
> Thank you for the info. I backported 6adb9287e3f8 ("btrfs: do not use
> GFP_ATOMIC in the read endio") and ccd2d08b91ee ("btrfs: remove leftover
> setting of EXTENT_UPTODATE state in an inode's io_tree") on v6.1, which
> already has 52b029f42751. However, the performance number didn't go well =
:(

Actually, this was my mistake. I forgot to add my patch which removes a
performance limitation. So, 6adb9287e3f8 ("btrfs: do not use GFP_ATOMIC in
the read endio") and ccd2d08b91ee ("btrfs: remove leftover setting of
EXTENT_UPTODATE state in an inode's io_tree") are enough to solve the
performance issue on v6.1.=
