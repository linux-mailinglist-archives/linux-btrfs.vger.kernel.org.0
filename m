Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170326C777C
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 06:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjCXFrY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Mar 2023 01:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCXFrW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Mar 2023 01:47:22 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DD7DBE8
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 22:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679636841; x=1711172841;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=X4G7biWyapGU+QTpryNeFHt+EYfkF/tgKrF4dJFs5xc=;
  b=i++DpK14hUDqKhu/2Vknlr2/SbXJvemD4gzCflQlcvLDFFAjIz9OzL5H
   YVU+0Mekm3zZew36n7lWFAVsfW9y+yOSkpHC6DptX5cQkI0Ll6u6SAsKd
   KXnMeuyFD8B2ExM7A6quwEEd8VQf4YXcagNYXyD66XE1VBKVJgeETKkm3
   qdceV4FcDq2peyJh9gOv3OF64HOHK8AnQRImBE+lzEmoJskejzO5t/CI9
   nDaHdgAqnC6vmR6DF06YMPCV8BWKO2Ox/h4SshhiHPJiS6C5/IX26kt1Q
   eh30ThWcQy2c+wQJgipRYkD2gNdvqcTOjlqpF37/shUTObBj5UXyINx4f
   A==;
X-IronPort-AV: E=Sophos;i="5.98,286,1673884800"; 
   d="scan'208";a="338460299"
Received: from mail-bn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.41])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2023 13:47:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q02V2vjOkJiVhxo2zGvByUHNZPLv8UlCedm5SYhe9USsu4IsY0ikTbciIQN5jxIlpKMe0rc3zrbu17DaH5YBGOK2iW+KQLKUZSPeI95UVji7jysxllcfTxt57bVSK+wsTcg0TwEmYsuTJxufw+hp+LhEVs7tzx/BsELHhGVZSNgNuwd2OrVvlAqyAEA1/AGBJgNQU4dl6MQNtPV6YPSBgzazuSlxYpb7d8q7bbcBo42j55Zqm6rFAJrjubHysa4u6OauLPY3TA8tuZ7EGRItU3zaqa12z2QyXaELNtN7YN6Fq/hVL40mv9pitOc1uQea/mMBbEVdOB2ZBBkMfwPPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyBlTphmCvA8j1X7Q/jJ5yAL/+vL2xcqpVTUbV1MiEY=;
 b=Twn+WRzjUrfC43czGet0X4L1bs+lLBS6fFxUSG4zXRxy0q2eCwge4osnc5MpAZLBB/D1QIIyhg5ZnyQ6FEbzjxq8zikryTez72h99C6Pq2P6q66cF/8zfWwiwnmb/AGa6C8ZErg6cLpAGYN1fY9OluSMihq9Xd24WoyYF3kOEOo6uDxyhV4+zbnBAYITqTf3MD+OlEu3Beou7E/O11bJ6/pAhyrrrrenHUFSgRowaDtYA44oWRtAo1f+YfWuIeO8D208Eq6lH/VH/Gg1TgunK6HAcRCpsmj9w9eCiEoh7ssxug43rKjgcRIc3LaA41MW9GuXi3Qkbaq2m4N+H8XBQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyBlTphmCvA8j1X7Q/jJ5yAL/+vL2xcqpVTUbV1MiEY=;
 b=kZOlo+4z8o5wmlS3XTKoiyWKEuf2OsjJn00W14r25UXoNl8gSfHfM4RJr+7Nbf5z3j7/7dS4uEp7kTnTjCoot8Ee6mPuY5kmFeXBY9UVQTlDccCj2QUzUIHE1Vq+odibp9umFttOCHS7H1UA9pfPAkVGR/5OMURq1dD6OiT7HIg=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM8PR04MB7910.namprd04.prod.outlook.com (2603:10b6:8:4::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.38; Fri, 24 Mar 2023 05:47:18 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::2e44:805:e7e7:8544]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::2e44:805:e7e7:8544%9]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 05:47:18 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Boris Burkov <boris@bur.io>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 01/11] btrfs: add function to create and return an ordered
 extent
Thread-Topic: [PATCH 01/11] btrfs: add function to create and return an
 ordered extent
Thread-Index: AQHZXfjgX5Hw3wGLTEy86xWXkP9x7a8JbD2A
Date:   Fri, 24 Mar 2023 05:47:18 +0000
Message-ID: <20230324054717.e3we3azhj2ava5qq@naota-xeon>
References: <20230324023207.544800-1-hch@lst.de>
 <20230324023207.544800-2-hch@lst.de>
In-Reply-To: <20230324023207.544800-2-hch@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM8PR04MB7910:EE_
x-ms-office365-filtering-correlation-id: de3284a4-615d-4092-75e1-08db2c2b3a95
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BDCh4XujBbztURSmwntzAUhst6gzE50HeQ+PFU76kiHO1J/oNVTj6jIQcrhpMfny5T0qLFeHvjGtdcv9SoeoSBfa3KX1pUsaGI95Q6+oWWDjDbahpX0safSngXSjfkTNdLEhNLzytQjN3gaImjQMq2jAPOhoggOZwMrfTycEPS9e2/f0avtL55jKbYGN+6j1ELMocd337QKZkLIe+u0ezNg9yC2ppWq5OcE/rFwqPfqFLTuAT1JSY1QFJHEg8XGDO82gNk5itZgptYm+ZS2XtMvtzFl0L8dRcv2IQzY8fvwGR0otIBQFkRWVOi5S3VbrhasKsxigxqo7fn3iI/Bp5KMexqzDxDcLa3xDKT9hdfd2elQCW61bQfVn4rmvdVk4gMbv2UNip53nrdFFfar2EsBiYmTC2HtNyWfMKvugQptoYc0tT6psTNUnFEZJknaRqt0zEVK4U7XsG8yr2CAN6PvqvaD2mEkzbE13RBGZTpcdNHMsLIxxCffUYHNrw0hEBSv+IWh/5kl7KCoxq8YhjFm7oZCGpyFaCFoOJ5svy7okxJ6BSaO9j4rL+pb/E8lEYTgXIP3Dk7vA6DH6UDni1+FyIachQu2Nd+Wrsv/oVCY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199018)(82960400001)(122000001)(38100700002)(1076003)(6506007)(186003)(26005)(9686003)(6512007)(8936002)(5660300002)(4326008)(41300700001)(2906002)(478600001)(38070700005)(966005)(6486002)(86362001)(71200400001)(66946007)(66556008)(66446008)(91956017)(76116006)(110136005)(316002)(8676002)(66476007)(54906003)(64756008)(83380400001)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oj1hhKnxBg9xBhqvLY/b6zpJE28RxDqkP/dv7bMvoljVQzJlOjZeU53C4Ga1?=
 =?us-ascii?Q?CO3772rlfufPOJGiG9KEDLHE4XpqKcZ4dWDmXEuYZQf7JbEKSrTg1O0QBKSV?=
 =?us-ascii?Q?2+gdI4AjjfQirM0bj78ZOs7I/P19fThgvhlDKIZTVu32GqJrX09SjM2y5Zjm?=
 =?us-ascii?Q?re4fvTHwY68aXYn4awkvi7yaWQmaHg5r/lmOlFIO378qmYSsmTF7CAXZb7Dw?=
 =?us-ascii?Q?n4M0cH3nr2wrzSpzDw5ZjAjrFj2t0xZgdYM8+P21rTnbdfEXz4e58/1Tklnn?=
 =?us-ascii?Q?LLiyVa9aXREpB9Q9c9uoEM8XJuE+6aszHtEOgVttzryKMJKHqGt0efjyx4b3?=
 =?us-ascii?Q?ZLcN0SsJ6tvY5W3rf4LthCG0LlrGF5YaThLAL6QTpmNtSom/rdw9QUB81QNr?=
 =?us-ascii?Q?Oe3x5Ppuu+cfN+eestHvaCH1qhjyJsBuXkNu3cEt4pC2JbQlzdSpRqBMQc1A?=
 =?us-ascii?Q?L0W6Ihafy8od8kMRscKDqnrGM0T5OM7nQnWO7AL/ewKIH6c3jieQMTCesmDy?=
 =?us-ascii?Q?f2WsqBYGwxC/YJsSjTja5NOrXwWa2dpSePf2ImB8wcpStemk8GrQCsHii9Lv?=
 =?us-ascii?Q?jv3DUsa9Zy8QNHgOl0nzsNaNrH9L/WMpyMCEqK7j/ptVf/K59mfKtliKwIgZ?=
 =?us-ascii?Q?E4yBnkCtjnSGdIrr87KgimP4mKeLDG0qGWCQ8kT2dkjiWUkB8yZdQvlLUbN1?=
 =?us-ascii?Q?fzRKFZtUkmDxDHe5Yodh2BeYktXeoxWpKNzT3QjrhJA9Z0svBkxqVR5VCTQq?=
 =?us-ascii?Q?jgpEREQKQ+VNSZdxwbK1uN/AEXHB8nNKUpob9UX6NQOj/aSkTQgQYjX33cms?=
 =?us-ascii?Q?Ve5TlnYodHMRRv4xAD+J/5hAci1pK8R2wKgasLRFMXDJHC55gJCWeiY3r/eB?=
 =?us-ascii?Q?afD7AN7rZmRcxydpT++BIft6IrVwgPikN1GINUIOI3dq72QMEO26K3x3M4Wc?=
 =?us-ascii?Q?kgKHwKooJHvns0Ih7Z/i09l24Eac7S2wKwaB5BUOWSKJ7/EwG692RlNxoqhr?=
 =?us-ascii?Q?2Df9C3wlJLRsF9j50tOmFEm9yXr7/m8XTkTasIFmCQsk/E2gZFGeYb4EDgZq?=
 =?us-ascii?Q?A1KoGhuhwKK8/7coJIAzE5un2zGPx2Sqmn1JjqJGVQiyaxaF69NGj4TLwY2f?=
 =?us-ascii?Q?Uk3ZDnsnIa7ed7p2xWZJMRKEV17NNseAaCYCFxKOHJ9iHTWq/wPQssQRwLfR?=
 =?us-ascii?Q?Z/a4G/LzB/znV3JjaMI/BbBxurhwN9A4+mGX6VDSJ2BvObtkbOLnkWSMgLjY?=
 =?us-ascii?Q?s2Pf1wc3ONd/vkLF7zKatjOw7useqG7YfRTlvfYMsKgYls4IJ1OAhMijlldL?=
 =?us-ascii?Q?00pzjy1wve3WwGbZJLhXI6PvqN1vofdXeaZLZyuITsIfARQC7AnUFP2UJ0AN?=
 =?us-ascii?Q?E3h4NXnWienEqny2uqeAGL3mchRuD4M0pgab8KQxr5FHu3NqECbTkMvVVyKv?=
 =?us-ascii?Q?cp4Hg3s2TiuYsHSZZbhR1BNmIjOUM77O7PgNpuvOjaOSIYg75QMmbOxht//e?=
 =?us-ascii?Q?/JUplH03hFw91D5mVZEMEnX/lVEDHEDWt9WdaamlX5MreQ3wEKMJgXh6opWh?=
 =?us-ascii?Q?w6l0SQ7KOSvRYrssZHYu6fn+HBbZEgZWMFQJgWK8WxLZERAK+XDzTUqn09uj?=
 =?us-ascii?Q?RQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C0D9AC33A2D6554D976768420A57DFF7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8hhEoNUUWTCaWKRzSNE+qDJ19RXpfVuaz+DXVKxjbEJFIcYPkAON6UZQKakruo9vb+KeFXS7F+1ACttxibvGAYT4sanw4YPiwwdfwpjaF6Q7QQVWoUcf9EaFz8gd7pJmqrDQPsRNBZcWMybnk+hXv9WE442k3oJTPyfhOjOkUFrGMtpn2Ua6ooTs6vpk4rlHD03Ph67co3cbQpCH4R4wOe9EqXjkUPQ71hCeJkJKxuh0S149xl8smWv4Clf8u2fNDGN/pKnR77vi13a3cfp/6/OOlv/K/aaw/VMTYHYIygsaNXrago2Nd5Q5XrIwoWhKgDx3+9G/Df48yJ5ODeFO0Uwlx5ypslRwF+uO91ECt9AspPgiqWDhspC6BpP5EzHbLsm13UGt7mkXN6eqnRCdQblacIweuPgDofb7BICsVGQzYK0H0ovcPf/Y0Z3IVXM+CVRJOSpWoBvRmFr3iWNx37D38F46oWmX9H8uKQalQgt/J6jjshCf7gro528Ag2zPdAWKe4431OlAqdRCXY9RW2Kj49R4jwWS0JQKsZULxx+vAxwve9oisVWYKZ5bbNjDSV9ptWuHCMfMpEIDzyI5LIMRSm44yIGs0kmrk87ra6ShylEXOpBVTusImyPholHY8vjAurXTmqYpQZh/EOYyAdYmps6WImz0RkKup8IDJYS4at8H+81WV6mih2+MgMFhEOz4tm130kQp9pi23xS3qhav9Xc0Y2MTkoQKLlWmmx9ombmsipS9nSsWFjQAlDAd74Bq5HKqMxk5K4jbjR+DsvM6teB7nsEPHwJFi2onG5E9Y7K/004jU7/RddRPSSnh+p8XL1J1t59FGvn8VeDpBMuw4j8Jbuo954IN3ia9ROIn6D2EXRntvs/fkAPv4yvqIemX2Ni+21ISh0K9hmFj/A==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3284a4-615d-4092-75e1-08db2c2b3a95
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 05:47:18.0663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A0zMfvILYRAGIoWQUxVTUiD5+Lp5kyG+kBmQKxCGlCpd8bwUsvlRaiZsvJp4ll72Vrv4t++82jzOMF4gKx0UFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7910
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 24, 2023 at 10:31:57AM +0800, Christoph Hellwig wrote:
> From: Boris Burkov <boris@bur.io>
>=20
> Currently, btrfs_add_ordered_extent allocates a new ordered extent, adds
> it to the rb_tree, but doesn't return a referenced pointer to the
> caller. There are cases where it is useful for the creator of a new
> ordered_extent to hang on to such a pointer, so add a new function
> btrfs_alloc_ordered_extent which is the same as
> btrfs_add_ordered_extent, except it takes an additional reference count
> and returns a pointer to the ordered_extent. Implement
> btrfs_add_ordered_extent as btrfs_alloc_ordered_extent followed by
> dropping the new reference and handling the IS_ERR case.
>=20
> The type of flags in btrfs_alloc_ordered_extent and
> btrfs_add_ordered_extent is changed from unsigned int to unsigned long
> so it's unified with the other ordered extent functions.
>=20
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Boris Burkov <boris@bur.io>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/ordered-data.c | 46 +++++++++++++++++++++++++++++++++--------
>  fs/btrfs/ordered-data.h |  5 +++++
>  2 files changed, 42 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 6c24b69e2d0a37..83a51c692406ab 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -160,14 +160,16 @@ static inline struct rb_node *tree_search(struct bt=
rfs_ordered_inode_tree *tree,
>   * @compress_type:   Compression algorithm used for data.
>   *
>   * Most of these parameters correspond to &struct btrfs_file_extent_item=
. The
> - * tree is given a single reference on the ordered extent that was inser=
ted.
> + * tree is given a single reference on the ordered extent that was inser=
ted, and
> + * the returned pointer is given a second reference.
>   *
> - * Return: 0 or -ENOMEM.
> + * Return: the new ordered extent or ERR_PTR(-ENOMEM).
>   */
> -int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
> -			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
> -			     u64 disk_num_bytes, u64 offset, unsigned flags,
> -			     int compress_type)
> +struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
> +			struct btrfs_inode *inode, u64 file_offset,
> +			u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
> +			u64 disk_num_bytes, u64 offset, unsigned long flags,
> +			int compress_type)

I'm sorry to write a comment on this late, but isn't the function name
confusing?  As I suggested a function only to allocate and initialize a
btrfs_ordered_extent in the previous mail [1], I first thought this
function is something like that.

[1] https://lore.kernel.org/linux-btrfs/20230323083608.m2ut2whbk2smjjpu@nao=
ta-xeon/

But, both btrfs_alloc_ordered_extent() and btrfs_add_ordered_extent() "add
an ordered extent to the per-inode tree." The difference is that
btrfs_alloc_ordered_extent() returns the created ordered extent to the
caller taking a reference for them...

However, I can't think of a different name, so it might be OK...

Other than that,

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

>  {
>  	struct btrfs_root *root =3D inode->root;
>  	struct btrfs_fs_info *fs_info =3D root->fs_info;
> @@ -181,7 +183,7 @@ int btrfs_add_ordered_extent(struct btrfs_inode *inod=
e, u64 file_offset,
>  		/* For nocow write, we can release the qgroup rsv right now */
>  		ret =3D btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes);
>  		if (ret < 0)
> -			return ret;
> +			return ERR_PTR(ret);
>  		ret =3D 0;
>  	} else {
>  		/*
> @@ -190,11 +192,11 @@ int btrfs_add_ordered_extent(struct btrfs_inode *in=
ode, u64 file_offset,
>  		 */
>  		ret =3D btrfs_qgroup_release_data(inode, file_offset, num_bytes);
>  		if (ret < 0)
> -			return ret;
> +			return ERR_PTR(ret);
>  	}
>  	entry =3D kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS);
>  	if (!entry)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
> =20
>  	entry->file_offset =3D file_offset;
>  	entry->num_bytes =3D num_bytes;
> @@ -256,6 +258,32 @@ int btrfs_add_ordered_extent(struct btrfs_inode *ino=
de, u64 file_offset,
>  	btrfs_mod_outstanding_extents(inode, 1);
>  	spin_unlock(&inode->lock);
> =20
> +	/* One ref for the returned entry to match semantics of lookup. */
> +	refcount_inc(&entry->refs);
> +
> +	return entry;
> +}
> +
> +/*
> + * Add a new btrfs_ordered_extent for the range, but drop the reference =
instead
> + * of returning it to the caller.
> + */
> +int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
> +			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
> +			     u64 disk_num_bytes, u64 offset, unsigned flags,
> +			     int compress_type)
> +{
> +	struct btrfs_ordered_extent *ordered;
> +
> +	ordered =3D btrfs_alloc_ordered_extent(inode, file_offset, num_bytes,
> +					     ram_bytes, disk_bytenr,
> +					     disk_num_bytes, offset, flags,
> +					     compress_type);
> +
> +	if (IS_ERR(ordered))
> +		return PTR_ERR(ordered);
> +	btrfs_put_ordered_extent(ordered);
> +
>  	return 0;
>  }
> =20
> diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> index eb40cb39f842e6..c00a5a3f060fa2 100644
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -178,6 +178,11 @@ void btrfs_mark_ordered_io_finished(struct btrfs_ino=
de *inode,
>  bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
>  				    struct btrfs_ordered_extent **cached,
>  				    u64 file_offset, u64 io_size);
> +struct btrfs_ordered_extent *btrfs_alloc_ordered_extent(
> +			struct btrfs_inode *inode, u64 file_offset,
> +			u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
> +			u64 disk_num_bytes, u64 offset, unsigned long flags,
> +			int compress_type);
>  int btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset,
>  			     u64 num_bytes, u64 ram_bytes, u64 disk_bytenr,
>  			     u64 disk_num_bytes, u64 offset, unsigned flags,
> --=20
> 2.39.2
> =
