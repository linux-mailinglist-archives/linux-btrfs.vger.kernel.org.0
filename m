Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB674EA8E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 10:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiC2IDA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 04:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbiC2ICw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 04:02:52 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8911F1E3DE
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 01:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648540870; x=1680076870;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=shNXIuwUbzHsEqGoCjx4aYRqTlF8/dzBXqDjKCEdCOQ=;
  b=HhW68KIgl/Dwjhu9mbuJNJzMPWBT0aekfhdGQv+ZK2OefkLOiaEK2loG
   3gXWJl/dyVtkW5JqC/YHE2GeSvGmEpdsD5wZqlnxMSBwoul/8MWMSyslI
   7q8OqaIwG5h70W83hfo09DDO7Adql7T1vGQrkmg4jIGhEAP9KfvJaO0qd
   3KrXFD04d9UlQ3BuM0SWTOgys1hZ48nGKS1QoeZ8BagbbEn10NVxcVQdB
   UsglxicQ5qdEdz7rj4Z4LjKpgrCszEi8nRTy3EZDirteF6+alsqGdiOVR
   U9rDyed1MvwDTKOUO4j13+VHzI82or23O2/eLCVC0hKriTpNst8lO4JPh
   g==;
X-IronPort-AV: E=Sophos;i="5.90,219,1643644800"; 
   d="scan'208";a="197433898"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2022 16:00:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAAZItt9J2pxOc+nzD6Ei0dnyeYZxJNpKr9FO665F1TZeUgpyFn4+HG7J9gpcfIEVveYwmg6znsibrjZyRvYoqe3gA1cY+YVfEXdyVIbBjnLHKfLM9unkEQ6vZ4wWwMkF7DPmbBF5PZkpZyBkOrLyg1IHkenyRXAfoPNioyKWs1jQJtXolbk3WhmF56XIQUG6L8eESVn7Yv9Ov04IMeBWdc4yJEffQiIrWsDTps6tujqfveve1TNmWJzpvlH/dSUVW6imHhjXgjjkhmAdqZ8uwuhHwlTsO1WjbLSCGcn3peIE0kJo14ugKFQLxkyf0JPeR1Qma48gRQ8vWsY8m8XFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cpo0tqiuqbEu2ZEi8cI6ZMKXkGsRNSb5G3aLV1o8eHQ=;
 b=JeAvV3Ueb3G5GBgub//6FLD8Y2p0Z+JiRyHV20XskOhOY/6pB0AnhSGcLKkdz8CV/b8LGeZ5r6XP//j7azH2w2sZYvemmG1JfMleVAFxf5ayBcI4llhpmpI7yd1XE2/DrZJHohWzsaS0teIGVxNiPnKCbuWAIWIrmMGX+ZaEidCfuJ6wxGCZQ7MrVpLQzu/DIRqF0P604y6KtBqLLCCYQvgRCZbB4J1cH7F434G/gUpg38V5uf4JssUa/rTmP1UPF45Kurjj/LP/6f3clwvRud7cWGMhT4GNCCjK6S74R7OFKKiFqIZcKAeBRsJz1wtEvoqmOlKF+xxTlKzbeNfnjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cpo0tqiuqbEu2ZEi8cI6ZMKXkGsRNSb5G3aLV1o8eHQ=;
 b=uw1PpIgTu4g9u3OEvuWiNWmylaHR67oDf2Eexn26yV1sbobxoTU5s0F/1419L+g5V4cd36bBs8kTSSc5Ipavnj+d5ASfg4+d/AF351JvYtZ+P9h8e/Z6n8faaJuAqqLd5+ZDhuixDJuhhJQdLcj+zTCw5SPgQBV4Bmh6vbHIzOw=
Received: from DM8PR04MB7765.namprd04.prod.outlook.com (2603:10b6:8:36::14) by
 BN8PR04MB5908.namprd04.prod.outlook.com (2603:10b6:408:a9::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.19; Tue, 29 Mar 2022 08:00:53 +0000
Received: from DM8PR04MB7765.namprd04.prod.outlook.com
 ([fe80::61e6:a275:cbb2:1bbc]) by DM8PR04MB7765.namprd04.prod.outlook.com
 ([fe80::61e6:a275:cbb2:1bbc%6]) with mapi id 15.20.5102.022; Tue, 29 Mar 2022
 08:00:53 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: fixes for handling of split direct I/O bios
Thread-Topic: fixes for handling of split direct I/O bios
Thread-Index: AQHYP5knnL8PuJerMkexqmSZKOU+Y6zWBwaA
Date:   Tue, 29 Mar 2022 08:00:53 +0000
Message-ID: <20220329080053.ri7hzhxy4yeknbgr@naota-xeon>
References: <20220324160628.1572613-1-hch@lst.de>
In-Reply-To: <20220324160628.1572613-1-hch@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de91fd90-db60-4ebc-ad62-08da115a3f7d
x-ms-traffictypediagnostic: BN8PR04MB5908:EE_
x-microsoft-antispam-prvs: <BN8PR04MB590841FAC8AFF3C033B519058C1E9@BN8PR04MB5908.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PZ9/qFIKSrIrFvSFLLLzetF5/71YsPhf6F6fWo2RePj504CEDeLHZa7gYbiPao3MzSW4nL9NMcj4GhEnRppQBJNeIQqAdaHvjavZG7Kg5rSAOmhmJ7wM1m2+Npc8epeFiN3fLS6dFGEOdzbqw4YU/p99w1zsDFhu+iy3UCZPZEpr2/FxBaUV9q2udCLWR1A2jxIV3ppuanEGyl8u6/9LY/WfXguDy9uTW+A9s5zuYbD/5TCqaMmxXvNl/SF7LqEXu6zdvNJRen/uoehE1p5dWhbPh+y/XVFxA+QIEhOcl25f395ndXUyNN1WqBUlwSWEqoQvK2eeaCCMJmOsPAF7h1Wyw8D9oc8g1t0dUFNG7x0RoNaEyjCYfntuBN7/ixvuH+xHtfZ5y/bcKo3Bma9GqowQfrcDx9sZMlTcmeXV8IvDySGwyZPiKDqJIplLEe9k4UtqqRvJ5hVyLU3Eex8uis7Awj+cmejV5RkUC/BzbMp3GUTm48rFzCq+sauMX+g/4itP0PnCfC5JyU2HU8c66Ct0rk4yvaa0hN2Nn4GP7/1+87B/gIAmX+GzMNIDZjALLZ4/Ifihi8nXdSjwzAPabcL+ed4zVn1bfFo/1/HRvgXAi8GsRy8bMRAd0FVNsjnD3TRU+kqOTBdk5XXTEA9vm7n1+aNflJ2sFO6AU2zmBACdndckWjx4P+Tykix5jKcIiVWbj9n0M4YdG7j9WxXe1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB7765.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(2906002)(6916009)(4744005)(8936002)(86362001)(8676002)(316002)(66556008)(91956017)(66476007)(66946007)(66446008)(76116006)(5660300002)(64756008)(4326008)(54906003)(38070700005)(83380400001)(38100700002)(33716001)(6506007)(508600001)(1076003)(186003)(71200400001)(6512007)(26005)(9686003)(6486002)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xQ4OwbFc/basGb6t0eCIEVZejVpDA7SWQMsIRMwbAlyocfciKLlYMU1Z/krX?=
 =?us-ascii?Q?ZkGcpPYbQq3WK1NOaJ8OOqviH1oKJspQI8HjRTn307jCtF5VdpYdKsPORv3o?=
 =?us-ascii?Q?5N6qSUIqq7QtRtmDNA+3pW+M41LWhEiRGWs6D0tOUTs/0bMDzrL589n4iiRG?=
 =?us-ascii?Q?xtvrMkFsZd8a9y38ga1G4gI9BryrwmAZsh+VUepsw9khl/UZ68lXKCc2YCjL?=
 =?us-ascii?Q?SPpQWMxyu1AalsKgQRULOGDFxqysJAnJzcFUqhHxIyA5wQyYCxN5cJeRchJS?=
 =?us-ascii?Q?1zjbXoMqe+1Uooi/CkPH7by52J7oouHLp29Xk3gNQz8BYwgjkD2UoGq4FJBY?=
 =?us-ascii?Q?hc6WZ4Lqb3nSBDbbnDjcQfXuxmlrjRiy2AF+/7S6hILfAshf5x7biJRBrPVC?=
 =?us-ascii?Q?PBST+j9YQkkUKAtJROcjw+buuQv8HH00R0l8ehiyHpH8HFXgbJRC0vq2O0/j?=
 =?us-ascii?Q?q7V9C8DZieW2w45oYd6F7ZUg+8uriOczjxDHuSYojviqGzsq/4fZTf98cZXE?=
 =?us-ascii?Q?onf59PuGeAfV+sZ1rArx/ead97tqfmmGbbj5hZ7J3LJsFX9fFZimx6CAHusl?=
 =?us-ascii?Q?wp1ZpbSB1n3l/XW5xv+TVK3c7/wEoeK/uXYKOcKycqphE7diULbRc25JJS1H?=
 =?us-ascii?Q?jrt6OSseSHtqSosNKNAPubpyTFBJOogw+nJmNTtCmkLy6nIac38RmSKVUgWK?=
 =?us-ascii?Q?17Spa9N6Ec38yPmqo+TpbiKY6h9FWSN6E1AI1JJEBlCIPkCAUjAimELageZq?=
 =?us-ascii?Q?NM9JhkwQX9Y/LsGXpoFILncNZJzxgLgvUMPKPo0pFaobSfDlYNcuW7pQa7L4?=
 =?us-ascii?Q?aoNzXsGAE5F944Y+y7nHsFYvXWwNda4JeMnmgDujJM7ySOTZmpzXzu3DNQEu?=
 =?us-ascii?Q?V5ZxbwCLUUEdzsea/lvif2g3YWDZdHhLJxOg6tdVMYOwUF803/+hn9Bin59z?=
 =?us-ascii?Q?NAwERZiZ1vaPxrs4ILm4+snu07pFKCyTd5L8Ku3Pl8fDw6kF70SguJGbYY8u?=
 =?us-ascii?Q?xMh3uQfKjuyIArTtiuqFPjc2vrthSZOeQ6OfjROJ1vPeuzDEl5OfTEdcQ57m?=
 =?us-ascii?Q?ygFyelXUnErKxgajqSkcX5wCDYHtbTkvTxWFVQofKiFIBoct1pRxynvF69P+?=
 =?us-ascii?Q?BXNjbvVYjVVgpKuUpfIYMU2VMGH45TDlQ3MJmJmJfQvBJh3Sa559d1RGWVJ+?=
 =?us-ascii?Q?QeNNbEWjlsZ9YLGf+ue0LxNONvD9shyJpn9xDJ6H3598tKkVyVoVIoJJoDs6?=
 =?us-ascii?Q?aAxfDKtmGcd3DVxXbDOba8C11YFBfrBCadN5YSFmM4Uueq2T0G95EKof7axL?=
 =?us-ascii?Q?97l7G2zdT46Az+6r68OqButOSC348oopmhzf3CTkTIQWeXOZCC5JqNa+VE11?=
 =?us-ascii?Q?pvfWiWoBbSoVJ7LNvOaUIWln/qqoZydrLBKaTMwdR+qygbDIFzU1iyh2/Zlb?=
 =?us-ascii?Q?bvaCgmKbQ7qjsfbhBO+JbXtSGNF8Y5gr7S6EwoHCxQLS9AzDAWrBek0kBxrx?=
 =?us-ascii?Q?gylEpu4OHYf5ZV0NoMUtYoTyqkBwEOkSD55SkHpzdU6+9W6osGuayKBgkHXU?=
 =?us-ascii?Q?oK69Z3B4jO/w3dzcvHdDSxsrrcTW0PHhOt4m+872fV3ZQotNU1Wr5rA/6fEF?=
 =?us-ascii?Q?2Q4gJjl8m4sekKj7gdmd9L3iQqQPe9xru66Noy43ZQnvcUlqcOAj14ppLHGt?=
 =?us-ascii?Q?u33GQM32CXFfwPKq4XBvqQK+Mx7akVOARkaN7Rp7YtyhLMkRN/SeK0sFmsdJ?=
 =?us-ascii?Q?mJA2o+gWbTCkafQ0Yc2c4Zp7jGdMZVs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F7ECD6D849E0DD47A82EDF437636AD44@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB7765.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de91fd90-db60-4ebc-ad62-08da115a3f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 08:00:53.5495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nW+955Aqv9IrD1sI8wMew/oK96BkKAemKKjZId1ee8nHkj4uJ7fGu2DzsCmqm5dia3thlKD14N8jrpU5r0vrBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5908
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 24, 2022 at 05:06:26PM +0100, Christoph Hellwig wrote:
> Hi all,
>=20
> this series fixes two problems in the direct I/O code where the
> file_offset field in the dio_private structure is used in a context where
> we really need the file_offset for the given low-level bios and not for
> the bio submitted by the iomap direct I/O as recorded in the dio_private
> structure.  To do so we need a new file_offset in the btrfs_dio
> structure.
>=20
> Found by code inspection as part of my bio cleanups.

Looks good to me. Thank you for catching this.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

> Diffstat:
>  extent_io.c |    1 +
>  inode.c     |   18 ++++++++----------
>  volumes.h   |    3 +++
>  3 files changed, 12 insertions(+), 10 deletions(-)=
