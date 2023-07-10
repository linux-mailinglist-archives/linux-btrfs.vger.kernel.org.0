Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7D274C962
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jul 2023 02:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjGJA7i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Jul 2023 20:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjGJA7g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Jul 2023 20:59:36 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B4B102
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Jul 2023 17:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688950773; x=1720486773;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zUljtFFH7sF7lmLrHsDbny6XhvQ1ZiEo/iy0Mt7PKFc=;
  b=qXFbxFyUG5n5eQbT/wl/BznT+J7e9AReDChqMTCzKxXRoko7iOs4Xur2
   r7bnEJlhsKmgoDX4+W0+efi1nC/hIz7NaQYgu1fhO0EhYeyAsn8YsR1zM
   obLFFIXsSaVIsHyu14nPOWS0qhGfBMm5mRyT6RwrNS5QVXrdvAao9drTx
   iJcJcEq0qsIeGlTmzUOOhJ1EsXHC6LVQhH0XrZHO3PL7N9kQFS8PWcq1+
   R+jx/6fzo++tH5eWNpvcPpJKQsQxmk8ecnu6xqRpzIF+VWQbHulz3eZ52
   NOJNNKOwyZymoPQJZseU1HyIXi+6XMAEmpmgBSAu6AjEvJlZg4bOieBN2
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,193,1684771200"; 
   d="scan'208";a="237331900"
Received: from mail-dm3nam02lp2047.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2023 08:59:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1oXl0BFhN+8YSABTBQH0hq9dcxuL4oCcrWEHPKLOGE4H1Mu+tV4cWHoT3AQ8OLB1IbkxbcVpHbzz0DzQpE6whooeaeNxGaAQOo5QteVnTSk993GVr3POFsWMTx1qKNmhqpm0uz2jsVfHWW4pWCnZH+G5yDZwoI0VEoZMoNtYcIJ5Fx41vrjuAKMg1iRuQsFowKKWUVoHfX114RnO5oeV8dAuEBUM/RAsPOCG/edB55EFvGQz+rskuGaTG9nZCysDHlHm/Ob1HRj+5lySxwWKFIlLSPJP3ajx5Q2XyB1t4fHDCyacbFskwUYBItSTpztBDqcMYB9ke/DN2Rmmig7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ah068H9k9HteHfjZF6rzKZz1XXp3nzNOuXBaWGk8zro=;
 b=jlK6Mh86GLDNl2FPGjX3P8xep9XMQj3qfyHVCzGE9fgOjwyPbAYWosBhh9UsyptAH10V9SQF0qkve9mIcjxFxQgxXeZUZztSVo9pkYq9saJuQEe3/NJy8HcT4GPcGE3qa10vmWp1kn9EhbueRu94uRuyHJw8LTUJ7OxSsWlUhjikOvhw/n26D2cTX+GdNUzAe6UqFTAhje7TDwzmWo8Yanbj2Mu6V1LkMKsPvS+9BZ6v6NeECqkOlwJVeF6cLMtZQqDYvbaBHQkZK3qNHfUj/Ho4MBvVZsEEG0Yh+7hunVSZ5q29zHDOMkocZx69FODbCAb/kMMcFaUSS+qF4Kc6Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ah068H9k9HteHfjZF6rzKZz1XXp3nzNOuXBaWGk8zro=;
 b=qEHTIdQNK09fJud1qp21fDpUPc+LtSOi6bGVxuehjt1bYPXqJQswkqOTkBw1b6GJJikfbuCu0rOJgJMu40J/WFD0ineK/W+qVjwos97KK10A1k7IC8efmv5AN1IABygiMA32WNuL3kQUZw/HNySjhaKnQ6RMiM+BWhSiQf/q/s0=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 00:59:31 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::cab3:8b01:da1d:61e]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::cab3:8b01:da1d:61e%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 00:59:31 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 2/2] btrfs-progs: set the proper minimum size for a
 zoned file system
Thread-Topic: [PATCH v2 2/2] btrfs-progs: set the proper minimum size for a
 zoned file system
Thread-Index: AQHZsCIeQWf8ir9TWU2VaOAJGDS0m6+yM0wA
Date:   Mon, 10 Jul 2023 00:59:31 +0000
Message-ID: <g6g3wgbfbsl537m2qg7p2nocf35f323jt2enhikgtl2aha2hjw@p2ann7qeue4w>
References: <cover.1688658745.git.josef@toxicpanda.com>
 <c1cfe98ea6c2610373d11d4df7c8855e6e98d3dc.1688658745.git.josef@toxicpanda.com>
In-Reply-To: <c1cfe98ea6c2610373d11d4df7c8855e6e98d3dc.1688658745.git.josef@toxicpanda.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CO6PR04MB7812:EE_
x-ms-office365-filtering-correlation-id: 792df0c0-5224-4056-c425-08db80e0eb40
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +guo75qyYf2YI9gA5GoKxC2lr9ATt4hxe+beqbTrlixU4yP2eRsnLhcBEbaPq2jatlu1ltOkBM3J7EsnJaDEj6w5V6r/4s0WuVhU3n5O6m8GZkyIonvsf0sgpeohCB7Q2/8EMFofyKm3DRKI3oICHql9EbCrW8/Gi7HpvHXzOBhs/Ap9TJsGIpq1+KYM/QAsApCil85NlW9rqaFehHXidxUoziuCFX3HlWeM/JnhS0HOB/Oz+fS9uMQyKEbPacUKwK5Ip3FV/vUrWoOrFf+i9VGsMhs36+Rua6GmpCEvod0/anwPBzEiSv2h1Pzi2iAxWf/kztnA6nREN8BzNicnd6nj51XOSTCDL9jy9kgXwE9m8akdk242OJ82fbRdYjla33LaoBvTI/S3H+fJ/2X+2X/aLGwDiZY1fUDtPumGGGV2PUMqNZIGLCJlkWq3IkPiAcAa/yEMIvCq/XJ6+oQhXbImka98YI2twd3keMcii84I/XILf0NEckno62rbr3Ad+yl8U8F7L5Kyxbc9qgT5Xa4lAP+pgsFOZFZcNJe964QrE2ZvPRKkMl5+MbMA/Cd3pKlfUhbmITodNenoSZ/c48LhEhdfLS6cjVGN4JhZgmbt/1E9NYy6HQYBcRTQFfip
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199021)(6486002)(478600001)(71200400001)(54906003)(91956017)(83380400001)(86362001)(38070700005)(2906002)(33716001)(76116006)(6506007)(26005)(9686003)(6512007)(186003)(38100700002)(122000001)(82960400001)(66946007)(66476007)(6916009)(66446008)(66556008)(64756008)(4326008)(5660300002)(41300700001)(8676002)(316002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pkLumjt5QT28d0qJGAirzbz1FNSxNlcGDpdbbUoh08fyuwG+hbh9TTCkW6S/?=
 =?us-ascii?Q?DRyIZwdTKRMlGuIe46bNIVMC0KzsFER2NUBs1TlWJy0e9Yo8KWea40/vjFf9?=
 =?us-ascii?Q?lTXfOg6lOx0EEA5/ZOLfr7VMPDtclxd2R4PdRYcS0bbDIhR53eLtYv9/hNul?=
 =?us-ascii?Q?sAzEqLdvK1Z2RUhP1FCxOVci0q6YQLxYZM6imuUi/Wp8Zkagkmi54dBfal3I?=
 =?us-ascii?Q?ufdredd4+vaGSeJIswLH4BOMB1p8dGorNXFcI9cDWFlBnE6JTo7pu/mX3Ykt?=
 =?us-ascii?Q?Zm6/k8plv6Xz+6wNJ7hi3Nsn2wzSjWU8ynPS98oNVD23mdV8duWDARDWqMVk?=
 =?us-ascii?Q?yJGrVMQ9mHV//WNXkB9agdSfI/qjbsNNm3r1m8cS6t/0DENkf24+XAIqPPxo?=
 =?us-ascii?Q?1dxRspZgnGEw4y3BSmEnLQtCp6Sltf1K2KiN6a9y9ZzJipqNaVPiKMD1y+Jh?=
 =?us-ascii?Q?LVgiQiv8h75MASMyuVBwZfJKB8uj2SfX5MYHkC4JXHon75g7X+bufqx30oAW?=
 =?us-ascii?Q?Rl4+sCmgQ3P/ysFEb8vdS25c2/2dZJqDGpb8mwJR0iQm11bgAxH9S3tDM6nm?=
 =?us-ascii?Q?b1Shd+dm8xJgj1SMzwHoDcDG1rr2UvQkUoLTIcpbpc/ssJdFcgUjzz8a1/w6?=
 =?us-ascii?Q?O8q09PtnWiWmrG6khJkwtJG00/w6+lBYbLx+Eux7VFrucejlecsqkrjLbifV?=
 =?us-ascii?Q?hyQCtso3NgLtlpf9mexWPtmNEEXKw4YHplWk7fnm97ciVSZfZ/1gZkrI4K6q?=
 =?us-ascii?Q?nYdBgULf4eyvbxM9GRN5AZSMnK8BhfHv3ffWYWHvL7LgEtqDZtap4fCRjUoT?=
 =?us-ascii?Q?D4G0erS1xdNfmkUbxk/+qUdbrMwo+sQI6a4dzwo4h5higog7HiDjD7akK9DZ?=
 =?us-ascii?Q?XUqwptUajXVplUt3PzcTTNAqvpywD/cm19wMnrHbgt97kkO94jw5cHbEqiRX?=
 =?us-ascii?Q?8JQzR7dNS+YjJgTOSsnM2rf0OJ0cvif3kTgEjyWB5rD1S+1dWPHKX98Bn5s8?=
 =?us-ascii?Q?T0s+Za949LkrIWVbyP4EtCeGpkKVEQej5M0mguHiAjHYTKcInRe40B3EzksA?=
 =?us-ascii?Q?ZSCFGwj8ZOycdZ5BBLglhUhZlcf77puNIt6HurUk8KCvNZtMN5AMK5wswPq/?=
 =?us-ascii?Q?OB/nZX1gA+8CEEXRIYEq2Pqlz+7rNOETdTSX6Fupzp6exYn10sxo8tboxoNV?=
 =?us-ascii?Q?H0BYL7n19EqhUPk3jMr3ZK3RkTZEbx5Unbnu8qBmCC1C5az9m0Gn3QglB56J?=
 =?us-ascii?Q?TlfTTl8cClTtO0N32ElLLhshj/TBeNAEQeU3s1UlQbiGN/aIqcG6aNCg3mAe?=
 =?us-ascii?Q?wWFFGjMr2wZSE8BIGlTCd0vmA0DcU5Ke+Fd91xTuP5c5tjNp0vc1gFXyEn1N?=
 =?us-ascii?Q?lQLFw5MVYZ2dUcdYGZsuirM4upg3bHyjx5nyXAvHNe4E6TBcRNSoqnD3l3z1?=
 =?us-ascii?Q?KPaRzuIiTveIcxHUW74cwAkTZaAEYlEmXIkY5sbtEZpNUL00V4t2w+67FKPZ?=
 =?us-ascii?Q?EmG7EiGSn3W+c/bgPC3GvAqlS7peUmMYHRVojRekvfVJSDlFppJOa4QPsgqs?=
 =?us-ascii?Q?shY9aV8qj3QHQDDeUEFCMpmXzPC/hkmLkLI6UFXOo4e5BHUFhgu34jZLYRNH?=
 =?us-ascii?Q?WQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A6C48CB3AE77D646BEE042338B38BAA7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kq+SpEgxuGhnCFL9KB4tuTPrh/xXWzgRWE65TQpVF5ivJdHnShm/6I3WL04HXfRqlfvaNGHJrLUxfkWuz3qJy+ubjenb7Tj6lkX/XeVHLRPTmCW9eY8vkbyG+IgU9YG5jfZTln80ubsGFZaANNIPmTe/ntqQ5zk1mNZKen9DNyjYw6hwjV6Jxikt3gEe7tIQneDO/y/VxfNTqv1YNAyEIY3CRteN6M8Wz9SjbhB81v+AWGBudfH6cbwsnwpOWfbyvbtA6Q/P2WlsE1SkJ2XA7tvqUCS5VIKa9m804mFWe0koZxWsof9QvFE5uGMx7i/pdeep6sbDskLUL2WgDJmwpe0ZRAltROPjITH1Al34+3QggGiv1rNvjwsYpfi8O0qj5bHhgw7eiS7UoLW5qGwUe8d0WiZVFAMB/RJB/JYXi659kjSXd6Z+iq3j1pNVA1NkM0Rg17z0GipTP0ID0Urb0hGQfSnHbZfuNTzWCcomtNoBUUt6Wu6rObj4Q1h032SxMpeFuf3mca1JlQVg7GdaXYDAU7FcXRJS/zaDg7cBAFeWjJ3FYZVguCKgYbgdA2AkE8DtnikbxH662UEt7j0aOiIXE14GaK5tT43b4G04wMVruonlM0EdzIHA8eROF6b5tcGyQEtfmfyVayj3Xo7SIjH6qQv2mBf+QREzTKDHPols4b9SoVlgD+7wu/mdyeuooZUzVd++HADvjMjccZMk1wGTwyiz2D6VSCGLTspgBBgKqOK4RMyqOY6tdHXqaS/H+mEOtNtTnbgEQ7LcWeDvCHKAQ15evsEqGK2TSiJw/yqTTPUXk0+6NQBJeviRYTWVqj1RX8dX/EvmzafsSnXHgA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792df0c0-5224-4056-c425-08db80e0eb40
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 00:59:31.0811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fCJD2gIzuudqSsd1fbmJR9KhmEkwka8JGQY4zaZf9qxHsa37oceaLQ18rIea53btxnVt6H+Ut2DnU2YznR2nAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7812
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 06, 2023 at 11:54:00AM -0400, Josef Bacik wrote:
> We currently limit the size of the file system to 5 * the zone size,
> however we actually want to limit it to 7 * the zone size.  Fix up the
> comment and the math to match our actual minimum zoned file system size.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  mkfs/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 8d94dac8..c7d7399f 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -84,10 +84,12 @@ struct prepare_device_progress {
>   * 1 zone for the system block group
>   * 1 zone for a metadata block group
>   * 1 zone for a data block group
> + * 1 zone for a relocation block group
> + * 1 zone for the tree log
>   */
>  static u64 min_zoned_fs_size(const char *filename)
>  {
> -	return 5 * zone_size(file);
> +	return 7 * zone_size(file);

When we use DUP profile for METADATA or SYSTEM, we need two zones for
METADATA, SYSTEM, and the tree log BG.

>  }
> =20
>  static int create_metadata_block_groups(struct btrfs_root *root, bool mi=
xed,
> --=20
> 2.41.0
> =
