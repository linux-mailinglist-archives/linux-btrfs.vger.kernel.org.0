Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087D553F6BA
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 09:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiFGHAN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 03:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237390AbiFGHAC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 03:00:02 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF46DE2749
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 00:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654585201; x=1686121201;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=361myENLwAAwj1ucCiedaTwVBAFRnLWoISzChi4kUS8=;
  b=KtEOVTU7ePOINBDNIaFcob25BbVnrH0uTejrB1xnHYJxqZqNrQ2A/jrc
   Ttt9cPlM6hmUF7hfyhQE6EVVtJ6pi+jow4WbaEMH08tkhB0ktdHn4lfPh
   a9NPaJ1EOqDOay0SimP8gffiwWIaT/dUFM17+w+xO1g2qwMQ8ZijseatA
   VB1sgo9gKmLkojsb5c2a1naXIelr9f+sU7uQE/9TLiNM39SfSuzsVHfiv
   XDkKZV2wB8Ce6/dkLx2+sF2RkVTdc6RsRL4dwY7TzRL26IhLZy6i1fszG
   MJwHqW2UU/5b4S2yVuMolV9hMDafTPXtyQm5ynfoRWNJnUqgi3FALCNq2
   w==;
X-IronPort-AV: E=Sophos;i="5.91,283,1647273600"; 
   d="scan'208";a="201190439"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2022 15:00:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GopYyfSbZS+ggSrneK0Xt3U/tiUlJJpuMSpxrTWbMer+7mefw/P6PptPz6S6zc1AmY/EfIGNWeQMGgvZs+xC1/tGhfHZ6SL/Nm64qJia9lRHkaF1bBLVrJVP/eK4rXlHubLUSIe0Gx+EhUptVFDiuV/M251A3C7Hib0cRH4rFVj9d9FdbreEAnths7c27XYc8ZBa9mjCs8c70J9HCwZY2tI0ELTgGbPxi0Sw1o/NbgeQvIMPW1OZS3p2yZZ4jYUxRJ/s7iK4xkOm72DMdVSWR/PLrgqd6fZ5akPRTzXhwnOX5Y62uko0hWv1Hgi9EzBqANcBcUp1MQlf6KjBzh7lrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKGVoNttURi/J81Mf27OOEAGfM7URL6wAtuSdF7cFAw=;
 b=Wwb0LxNwdgjo+lrtcTeFYnfkLPZ46p61u/23qWgZRYFhGfbSNCLjESKX1e9vMYjhqYXnvaBjWSMaD1H7gn7obt3+iU1h+tgzjOVsuFbXbY26SfyJgNSOayLxRb2A4p397UW8IkZOpTA2TVl+dat82oSZtWpGgkaLPv45Yg4vZVfQ45qXW6G0JwTECUanwGifvTpWfZ+yYwGMMr3wCpyyZgOOYu64BcylioKAuoHMI1BUZuzHVB7b9fozo8Wv6bhU09MFQ1K4vf5YgV0nQPwAmiUOb86e6jFB4R6bZuKw1p1AwT3fHP+hwwV1cs4sHsjjiLmhN5Q3quWg4Bxf2l2Nnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKGVoNttURi/J81Mf27OOEAGfM7URL6wAtuSdF7cFAw=;
 b=KQ5ZHfw6kgz+QGrsghvWqKV2hm72rrDhzsbpaw/hAMW2opfsWyHkYl2EWvbqFTxCpgTNIIpVCCJZ3Eg2kUVXApulVWAa+1QvXE3PjmF+mXUvay+xZMRok+6H08Y9IoYFbn2VUV5e5J9hEzUI5FGsDEER2hbQImxau/5q8ejA6nY=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SN6PR04MB4670.namprd04.prod.outlook.com (2603:10b6:805:b1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Tue, 7 Jun
 2022 06:59:59 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::456b:ac5f:e71a:7164]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::456b:ac5f:e71a:7164%9]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 06:59:59 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: zoned: prevent allocation from previous data
 relocation BG
Thread-Topic: [PATCH 1/2] btrfs: zoned: prevent allocation from previous data
 relocation BG
Thread-Index: AQHYeb5po457rAZcikGLMXFLuzDX+a1CpWkAgADfgAA=
Date:   Tue, 7 Jun 2022 06:59:59 +0000
Message-ID: <20220607065958.mqsufhfyvumvtu6s@naota-xeon>
References: <cover.1654529962.git.naohiro.aota@wdc.com>
 <fd9c3af9cf148b18e6be8e301e1ff4414495d73e.1654529962.git.naohiro.aota@wdc.com>
 <20220606174002.GD20633@twin.jikos.cz>
In-Reply-To: <20220606174002.GD20633@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e80d91af-bf65-40f2-f76f-08da4853562a
x-ms-traffictypediagnostic: SN6PR04MB4670:EE_
x-microsoft-antispam-prvs: <SN6PR04MB4670ACB06133C7B7BD6081068CA59@SN6PR04MB4670.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kn91/i9xMa1i4wo2wUFOZ3d5M2fIQliemYajCvJRjeya2p5R+jl9Cdbj7VMnjGo8RckFAQl6Ii56Z2/tRtZXDgjkPinAa6iIGLiTjCU7wO4UMQoed4k5r5nCmtf06goaba56odJ1j1V74IrxIpCaYMTgbfUywAgTtTqRUjqGR4+7EbtRDB0zIhTNafTIv4DlLZYKhNlzQM5owrjXCax08ZH0ZVp1uRY+qJCWvdEO0AGsyl5JbS5lAVdK4rmtvNY9QwhmYvXJE+NiEy7DB4/GN9GqBUWVvLgkkuG91shyRESj0OhuDll+obH2UZm1smFFi2y2bwsH9KhTlDCHeaSKeaBgUeag/pChMkXRwfhWlj553TjLSFLXK79LhqtPWIvflKnvcTLsUH5+P/VhL6/AUWDAe2VyqwpnDI1m0vMBr1KqeeO1G8RkQBQMD5xRO60JmVOyKmp8/hEOI0+FNg+vOfBIt8DUVkovDLKARLvePp+PwrlCraB+zj9yUJZqhn4Gh3bkxTS7zslUpDBKihIa7seT9iG2JE5wZRudcsOtmKOY3Q4et7wSRSCAWw9EVdxhZGPzNb+cjlp3KPlxRLqW/0CKrkZ8Rl2rEMwzhR9SN4rypOLXvAziqrXGRh6/q804QDq0PbDDPTe+jc4IKcnQ4J8xh/aq1i13vw7z1JOv582nFhl9aSjiNvrRi5mrKBKwANk7uIJEm6ykNKxaUMcxyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(64756008)(66946007)(66446008)(66476007)(66556008)(71200400001)(6486002)(6506007)(86362001)(316002)(76116006)(38100700002)(91956017)(1076003)(186003)(2906002)(110136005)(38070700005)(9686003)(6512007)(83380400001)(122000001)(508600001)(26005)(82960400001)(33716001)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dYCcvHSJWxQ74joNq+0xtPwITwMT+vckpgoEZxcEJRxEcTN25PANfuXlO+CW?=
 =?us-ascii?Q?8+Rgeuv/i8l8O/Y0E01+9vDwJyV+pPUVmk0CgYubCHq7oDseRus3dqiY8bnE?=
 =?us-ascii?Q?/L7OQVIEqTnfF3QthQUfJsO7Hxzu4CSYFN6Pkzypbtk5ZEjwVjVVpaJguEyK?=
 =?us-ascii?Q?lAIWrzb81WXo1u8AQ4gVfThB+sRHW+Ozo3log9zg3LMo10t5EhLcOQJWglwJ?=
 =?us-ascii?Q?D43QL54QSjlINereWIY8YTJMhMoCDe6Thf6V08RbnImuPTpZhkfJug9Zu8Nd?=
 =?us-ascii?Q?LTDYF0imEFVtnvee3aVS5QBcL3hUfS0lHrw7INtNg06YDz7vR5k/68atoaH1?=
 =?us-ascii?Q?Xrm4WAPfEL0I60HxOPfdhm5Vdl5Sc8a4GX4wYvoueRAiNW1+Y0qkuAjw2mtQ?=
 =?us-ascii?Q?i86OdYEAxK+XqQ866MxXuoeOV/EGkxJodcVpx/rFqqSmK230laJxImblGWFY?=
 =?us-ascii?Q?jJ+ZbcGcc2uxvohYwH684RoDdgXVy4nWOM4uJUpaZdaIy+oGpAN/enw1dtVg?=
 =?us-ascii?Q?YJFq/c0OoOV6C1G69+x6QeIzGQtY7xuUdEHLblSV43YPfr1EoahwibKvv436?=
 =?us-ascii?Q?IPDF79d938I+EVhi00fXVbmj+dD3FahNgKqqwgH1fkQoW9b8Bzq2hhv0Epw+?=
 =?us-ascii?Q?nMDIeW8980RKYgGPrDoAsDItiQjF7whbCIIFLB0P+QnEaYK71GcKYMvGGedQ?=
 =?us-ascii?Q?Pr2fkpy9xKuU6LexwuPI/8BFUR1FbfZr+Tpb7l1I8VvNHVlp8HtTgYKfFmqX?=
 =?us-ascii?Q?9EfPqEvfIWVvMy43SmLEchSQlHDtDMZNUUWvWICvuPvgGTUPjAKnzlU645rC?=
 =?us-ascii?Q?XWkjqfBCVmLXm8IXnqH+ftMoI6k33aVNL5XKVGk2ANNjAXQ1k7snY0Bdso73?=
 =?us-ascii?Q?CqXm1UzkRTSxelPKUCu3FwI/hBzVeJvlBogXjc7JOUOv21GNc/BxXlKWnhVj?=
 =?us-ascii?Q?HbGCqMPpESh+oCJPJTLrqyvJq3Oxh4vAK+VztaxG2FT7CQE5nPbQsv+QXREr?=
 =?us-ascii?Q?RiGj3QqvMs23hc/moHTYbUk7KHI8Xm4bbV6m14C062rART4NttnM7LUqvkwn?=
 =?us-ascii?Q?CKpoIJTRUXS7bwy+5Hogd1Qe/YdI+tw6vcQaHCYw/0qzagewrqhEYFEq2FXY?=
 =?us-ascii?Q?yD2vk3Gura7jgVu8xaFZgsERk5DAKHV3YJ6Uy5gVoer4ZOJ8VO6dLsukHVLC?=
 =?us-ascii?Q?SI1eL61v1IkdvjEkcloaXaV/JY+jCuGbtKSdLSaylrg6JI6WhZQm/7ES+9ZH?=
 =?us-ascii?Q?ZrNdcDW2/pMxXZ5F5D4RnG/5BOzu3ZMpQOdh0ZyT8CBmL9Z03DewXxoBXMhW?=
 =?us-ascii?Q?4y6fBMVbRWnC8OsObvHDp8U1wOgmKGtXRD5LwLcMbS9tXkrUByqv6ETh5nh7?=
 =?us-ascii?Q?pkB1cOWawGJ8bY7if/VlSUXgLFpMqQID0fqeVASQ/KNyd6y6pzQH6eq3uS8R?=
 =?us-ascii?Q?g5GFkGteQZ3u5ywqGiOefoMJO7cZjP5oyvSG7eW84OS9P8MI4dnY+RRR5Un6?=
 =?us-ascii?Q?N/J+L+91JjIB67Afmas4piPvjd+GjnwJMSoSBS0RGSLal30JAiP+W9o4JrHL?=
 =?us-ascii?Q?l3G6LewNLQj/KGnJHIfSw73hrNijvBWoCr6COBMZiMER07G95fD2bcj8M7zD?=
 =?us-ascii?Q?krtsTSf/QNcY6DFQeEjkL/fc/ncCIrnZOM/2LqPsBCU7KThD7fOPCG7vxOT2?=
 =?us-ascii?Q?tFWa3htleFfsOMaHkfZXV+qVzugGhIaUgwDhtOJrMh8iy9mi5mP2U9aWaAXK?=
 =?us-ascii?Q?W9SuV5pgpePH+bgcFHZIVAcGBn6o/wk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D072DBDCDB277418428D1D311DF65EE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80d91af-bf65-40f2-f76f-08da4853562a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 06:59:59.1332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i+f9xkUwCXjmwJaKNjMn7IBbe035BBeXtcEAsi2gIAwyHqXoIQb7wFHJiL0qKIaOhdqCzJIYqo/6joFW9Bjkew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4670
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 06, 2022 at 07:40:02PM +0200, David Sterba wrote:
> On Tue, Jun 07, 2022 at 12:59:20AM +0900, Naohiro Aota wrote:
> > Fixes: c2707a255623 ("btrfs: zoned: add a dedicated data relocation blo=
ck group")
> > CC: stable@vger.kernel.org # 5.16+
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  fs/btrfs/block-group.h |  1 +
> >  fs/btrfs/extent-tree.c | 20 ++++++++++++++++++--
> >  fs/btrfs/inode.c       |  2 ++
> >  fs/btrfs/zoned.c       | 27 +++++++++++++++++++++++++++
> >  fs/btrfs/zoned.h       |  5 +++++
> >  5 files changed, 53 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> > index 3ac668ace50a..5787b3dd759c 100644
> > --- a/fs/btrfs/block-group.h
> > +++ b/fs/btrfs/block-group.h
> > @@ -104,6 +104,7 @@ struct btrfs_block_group {
> >  	unsigned int relocating_repair:1;
> >  	unsigned int chunk_item_inserted:1;
> >  	unsigned int zone_is_active:1;
> > +	unsigned int zoned_data_reloc_ongoing;
>=20
> Probably jsut a typo, the variable is used only in logical conditions
>=20
> 	unsigned int zoned_data_reloc_ongoing:1;

Yep, exactly. It should be a bit.=
