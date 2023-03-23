Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47A46C61EF
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 09:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCWIiF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 04:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjCWIhn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 04:37:43 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9682833CEC
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 01:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679560586; x=1711096586;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/0c8TjG6kQJruzCrrJxQ0y3ArRhgmlxRNUtBa+1yYm4=;
  b=m1A37t6j4Ujg2Ila6a+ezZKLY3anvvnXkhYMayjRfucf1DxhOJ1qhFCJ
   B7ZjDWkO/t2n3L7D9F8qlntgtyFGevukFQtGEGgACGAsOyIwmf1zO4GQK
   dFUGlaIzxKTp0Ah2kez21FdDrEJgJnFMyyZVLRBnxURyo516xmtWszd3B
   grzUsnxmyFd4cRxyv1rdVLsCe408pIIWJOtn58CItPG6qdsvt/yzNjc20
   xh//ba3KS24VscTw2md+0DxS3n/3w6GFEwKXMMaazEsu1ziu14x9Y+CER
   w7NNSp0wTIhZDxAiqjRFXsewtX/thNPHP7b4vYdBGEM2gBTdAvA5UjV1e
   A==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="224593745"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 16:36:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnEGtWlCN3xpOjiiFkdnw4tCnlYvI861VDHVk/Y66Hu0FlFZf46cZzSyCAXfq4GSEUkpR9yPpx0zONpzhDxTd/eJBwF2NMobpJCaUH3UwOEu5xG+poCIqopXf3m5b9Z+DI/KC91JUyv7bS+QswJy5UCJTQgzHYpBTkPCocBWSzzp/ByV0UIRcqujcWlV+FtwkZJOqo2FF9FrOf28fMfWSoSvwUkNq0mHZh9kAm6uthsRJqXOy//vjcnMcil2bXpp0PutWylHMZHuSnX4gXluExRZGifjOIRCpf+FuRPxynWocCbn/cu9d+0YCoOOcAwHOhPH93M+d4dqWgb/WiA1kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Z35PH3it8TakfmLYKjefb6ZWKQEqNMhuEY4FOr3i8o=;
 b=aaKIt34BPJEfV3E60dh4cIBB4W/8vIdJ9POrZo2OsLO78uw/vQBsFqqjAH9sXKauvblI4Nu0FvfKAL8TWGhdfY78aGQAaYm+oTppW0LzwHl2xoFHOi9b+3jO0+/XIiNwUEnAlzbogbi4abekzrEp7F1eXM1uiYzx/zrzmnFhhD5MSxYDdP206wAtJmgoluecbsIHzxqkoqWXLb1j6QHIE8Ov1dTp1WWckYOU9ZE/b9AsNfNqJ9yy3vhCTJl73L80Wp3k38ZMxPjvN5mTLm8YAbcqGN2Q61BHgtDqu6FUWgz18vGYsrSe99BmlmmxzeBtFDOinutwi8PRkvQdUM4DEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z35PH3it8TakfmLYKjefb6ZWKQEqNMhuEY4FOr3i8o=;
 b=eE4f6trrAZAJyEyzXLgk80BmWTVEM/Wm50a/ya5XuiuXnwUlQztC75dbcmGBwZz+w/4mXebLmLeNHnhdJURGHC0sXx6eMpSdJZjnnwZbr9Y2/vultMc/h9as8SQNe9rocVdFFQZoRE0HTxnXXiOkKYNSzs1VohWkH14WmQF2oxw=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CO6PR04MB8361.namprd04.prod.outlook.com (2603:10b6:303:140::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 08:36:09 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::2e44:805:e7e7:8544]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::2e44:805:e7e7:8544%9]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 08:36:09 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Boris Burkov <boris@bur.io>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v5 4/5] btrfs: fix crash with non-zero pre in
 btrfs_split_ordered_extent
Thread-Topic: [PATCH v5 4/5] btrfs: fix crash with non-zero pre in
 btrfs_split_ordered_extent
Thread-Index: AQHZXPJAy1jowYPsCUy7GMCQYrQ//q8ICyIA
Date:   Thu, 23 Mar 2023 08:36:08 +0000
Message-ID: <20230323083608.m2ut2whbk2smjjpu@naota-xeon>
References: <cover.1679512207.git.boris@bur.io>
 <b8c66eeedfcea2c068befcd40de6a95cf5d64d7b.1679512207.git.boris@bur.io>
In-Reply-To: <b8c66eeedfcea2c068befcd40de6a95cf5d64d7b.1679512207.git.boris@bur.io>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CO6PR04MB8361:EE_
x-ms-office365-filtering-correlation-id: 1f065434-2ffd-414a-0b5a-08db2b79a6a0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C3VGOZghhKoqEejPAyb8891aGhrERy8LOdhZ0tzR/iDYUiMAwWdrU3CwyQv3wMsayVsF/nzGTbEqHnoUHA6MURi0XQr2vQ33c8XaPKsM9xwwXDyKtNNFi/vYBU1dJY9CQyA143NS1DHoFmKYM3JsgqWT+G1HWCSLr1JYnCzmEC6gIcuSAC1jdzZmb7b0ZzV8S/WDG1r2iOgI2ngeM/8Cq8WVWTVWMO84WNatlW2vRqO5SSlhgQCPxlZcvidMk1p2Q4wUV3jzIR/oKHWShjHH8EfOKNHxkf/A0dQKmKVV9p2FHSCOCFQ8+uiQTvbMQUtH2uwakK6ILgbbdMlsiAbIMTQGeJnFanfyTVxtVZmuXq7CQQNeOckuBdCgkGUXILMAGKfW8j2B1PgJV0jcZo+43ShBMRwdOyLfXsRIvnpy22fJvdHouEDSzLiEpHbDBOWamaagGMuW0mnFr70hTRLUAPVnX60Imth7yjcED0kSVYRd6VkwwirXENBZ4aqEh0wvhateV/QGtZuBbp5BDinYnvO1HZnPBqSimSukoIAScvzkGREbCbdEiFqOFfgSkvmxM9ljvwbAlRrLsZ1U2y7Se0BnfBNxzF9o3TfrwxY4ozW7cz8/R1GmqWNWoYGu+fxq29lwK4bXMlPU2LMWYJfOLANOYhDcNm+Oc2SsQxbKV2jU17pA9ro+3szgmbAp0DM+do99cizT6duuFj4VvQ229g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199018)(38100700002)(316002)(33716001)(9686003)(6512007)(1076003)(5660300002)(26005)(478600001)(83380400001)(38070700005)(54906003)(76116006)(66946007)(66446008)(4326008)(8676002)(6916009)(64756008)(71200400001)(91956017)(66556008)(66476007)(2906002)(6506007)(8936002)(122000001)(186003)(82960400001)(6486002)(86362001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wOUtvwZ6t8jNiElo+2EF70F39LhAm4vkdFkCy94AXB+vSgH6KdH79SsSRZ34?=
 =?us-ascii?Q?hqhYnFG1rih2lIXBiEiCOSez3ARCW/89wvN9LjiMg8MSfJ2VB9vd1S4h4D4E?=
 =?us-ascii?Q?wz9UiE+jPT4W0JyrKyfTI2In+P5gG0VKOePi0xotVFwXgkdk+Ks42HmL2hLn?=
 =?us-ascii?Q?Ze5icssTnT8kgZW8RVCZYEV7qR9NEaJrrY4x2WYCw2UPp/UZ/yT7maeKO7uw?=
 =?us-ascii?Q?KW5QQMAjUgCCqQ1K8IxZqE7ymwMOa3mn8Bfwj9dzogp/KSNsi+3g8/L0AUa3?=
 =?us-ascii?Q?EJxqBUZleu6p12w1tlgZzQrXxApy0P7nevrBO1KsGl9PXQxKn5/QSNirAlio?=
 =?us-ascii?Q?+ddSauokUs6/D1neucY2v8/K/PBYgeDwhXUaADJhOTyvIErAddSU+L3c/Iie?=
 =?us-ascii?Q?gzO5FPuWeidH4SHzn4Jsr8zPYIHoy2azP8nwk5yx3nwlFP7Xf+jviAwh77AB?=
 =?us-ascii?Q?yBQery5ug4jIci3aluxvzm3td2BwdIlm6LEyx7A5s0Zdu8+5Y+j+lRf3fYAx?=
 =?us-ascii?Q?3vapjSfcf755pmceF7967xi4701G/NqDS9coTgqpP6+NGtEKkvvBdKevYLNt?=
 =?us-ascii?Q?FixMcS3ZvZFilCmG5ZI2BGI4ZQknE74dI92IFffoSZWzYr63aJxWgBv5e+ex?=
 =?us-ascii?Q?o2qC0r7mTZKYrsqBSiNJhcjVGh26ypd8nUhXQY8IGCbeZjtO1rTxwGuoZjr8?=
 =?us-ascii?Q?0/ODX+/j+uT49qWADIBmi3uha7n10ZnpeljjVKjt4i8H5MIQ5ABa+VsQdZYU?=
 =?us-ascii?Q?bojs+w8ihyvGpiYgnIoSADmLSPJE2i3z6zKDfKK3eaO2HQzdDDKNOnluR9Nm?=
 =?us-ascii?Q?BUUfVT9VQeJyNA+43d46ceCdx7Yq1v8MnSG498xbpawPnkiLca7Qumxkj5g+?=
 =?us-ascii?Q?FEH6J92hA8cz44s+X6OGutijpJBalvXZjyGFyNm0bwgVDSmHbap7BOgSmIiC?=
 =?us-ascii?Q?dRHWIBTi3XhHtmcDRQnp1ABavqFm2CDU5FfSnlBD1pLG37dehC90Vp5yVdFB?=
 =?us-ascii?Q?mbEdJ87Mi9z74nenDKcxRvzsopTBgBplBgQJx9Y6wX2jZHNVNPMnHYXl1i1R?=
 =?us-ascii?Q?sUpCiKv51KB6K+P+uvLRZAdBIfhpjc9K7bdKNv/c1loBKw7v1ztI6RL0zE/Q?=
 =?us-ascii?Q?9QIdY401yVhmu4cwaYSv4thORjq1+TpycgUL1Zo3fiKcE5Tbpe8PiHtjq2hn?=
 =?us-ascii?Q?il2/532Qd5f5vPIWzmCfosj9NKlZ4gQ92bcLX1yuqt5Ksk4DUfd9Ee9AD8lL?=
 =?us-ascii?Q?vmdvjNfpqFvAuPKoCbHjiJD/dGs0CrvMp8MvSPetXxm4g6YOD5j9/7Fae0JM?=
 =?us-ascii?Q?GbPPw2QraNYCC5HPhxUUW9abivpcupyKXe4yMfXTRnpcQlWlJs1PdNE3yjh6?=
 =?us-ascii?Q?DO6QQmdn90VtOOhZMD5TkskNIIbBqNW/ZQhXzW8dK0tD+9TdoEuFHjHwakT8?=
 =?us-ascii?Q?Yf6IotEZIrtGbsnMHt2WzZUNpvpGYehJuv5PzsvVSxfcs+RMlVDXluslz3IK?=
 =?us-ascii?Q?2PsM2pFrT/xx/jyZA57yJaEfbiKQC7Ph9TzF+MYfdNfsZUiNREbYMDTTwGyK?=
 =?us-ascii?Q?d+SIXoR1KDzKp8Hz6rZXAhFvyLj3Qq1YHbi+5FtOleBEMcMpdULWL89AW3xf?=
 =?us-ascii?Q?qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7428F02B14B11F4C874A16B1D74AEEE6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xq0dgAKKMELmmsaCJgwGu3Bt3KwG7+eh43HWMb+myJeI6hyhto1qAso3vInU1XK43GrkXLJpl00XQRZY4jyBtLA2JOK8IXvMQ0RBlCz3x3FwBWZ8lcT8/0pAgEwrzc9g0QrOIftdTV77svvvFzqCoTt7NkQGJjcZu21ZV+HBjykv+79fkmsakFj5o+NdijNkXlrVAN/rfZABc6uULcp9fQYlbaQttzd0LfjEhwh9r6bgpdhMFPquYSTPOjuC3BnJWJeGoRcQA+FKdSNnwEwgBwlITIbTI+SONq8K6Aak+FfHvjc7w4dxxMrlkg6s3Kbg2N/4tY0T5gBSAC7UCDa74YE27w7lFzxCiJ+m4S9cuRbFvn8EPHAcQitgla81hdp6Y3/7M5bVVimXZ699Khlj+blHqQhFNWdaO67cvNvE2jkPVDLbkpLel7em4P2BUEIYioxNODbbTLR3Svj7flsniT1HOkySlb0sXxjpXMMebWQVglriTFyhETKK0KCqneMhwiNlcTsI0DKKmPkKxOYw9ia6+nAI3NTpodYsbC1NjM5G1I/if+Eaw36/NbwmObo9gTVN+A858xZz8RjKAOmF3eNg+DJE22Lg3fHfmnez2JWLrWF4usVEfnfs70j+klU7N5oX/kcEyTfkEiTQVKo7cq9XvjrrX+8x6ODS8Z90rn49HTik0sGs/XK53VOSSGcFQsicuwAnGqMfZfDExQiAR/UOKPMrDRtEe7e6eCBIJbFykmlvcCrPcVJlzZsaeqDAE1mEiGcboctg/vH2/dW9grzvmaBZ7++7YIfLGFMhjY2yXBoTb3kDY/T80SGhFzdN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f065434-2ffd-414a-0b5a-08db2b79a6a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 08:36:08.9444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qaB0FHeQhrZkOofZsruvcMX6HQlUYqTR69YoW7285BXlndkukLH8OeTXKorP4D+MOmOhzZiqcFSVpePxU4YTAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8361
X-Spam-Status: No, score=-2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 22, 2023 at 12:11:51PM -0700, Boris Burkov wrote:
> if pre !=3D 0 in btrfs_split_ordered_extent, then we do the following:
> 1. remove ordered (at file_offset) from the rb tree
> 2. modify file_offset+=3Dpre
> 3. re-insert ordered
> 4. clone an ordered extent at offset 0 length pre from ordered.
> 5. clone an ordered extent for the post range, if necessary.
>=20
> step 4 is not correct, as at this point, the start of ordered is already
> the end of the desired new pre extent. Further this causes a panic when
> btrfs_alloc_ordered_extent sees that the node (from the modified and
> re-inserted ordered) is already present at file_offset + 0 =3D file_offse=
t.
>=20
> We can fix this by either using a negative offset, or by moving the
> clone of the pre extent to after we remove the original one, but before
> we modify and re-insert it. The former feels quite kludgy, as we are
> "cloning" from outside the range of the ordered extent, so opt for the
> latter, which does have some locking annoyances.
>=20
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/ordered-data.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 4bebebb9b434..d14a3fe1a113 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -1161,6 +1161,17 @@ int btrfs_split_ordered_extent(struct btrfs_ordere=
d_extent *ordered,
>  	if (tree->last =3D=3D node)
>  		tree->last =3D NULL;
> =20
> +	if (pre) {
> +		spin_unlock_irq(&tree->lock);
> +		oe =3D clone_ordered_extent(ordered, 0, pre);
> +		ret =3D IS_ERR(oe) ? PTR_ERR(oe) : 0;
> +		if (!ret && ret_pre)
> +			*ret_pre =3D oe;
> +		if (ret)
> +			goto out;

How about just "return ret;"?

> +		spin_lock_irq(&tree->lock);

I'm concerned about the locking too. Before this spin_lock_irq() is taken,
nothing in the ordered extent range in the tree. So, maybe, someone might
insert or lookup that range in the meantime, and fail? Well, this function
is called under the IO for this range, so it might be OK, though...

So, I considered another approach that factoring out some parts of
btrfs_add_ordered_extent() and use them to rewrite
btrfs_split_ordered_extent().

btrfs_add_ordered_extent() is doing three things:

1. Space accounting
   - btrfs_qgroup_free_data() or btrfs_qgroup_release_data()
   - percpu_counter_add_batch(...)
2. Allocating and initializing btrfs_ordered_extent
3. Adding the btrfs_ordered_extent entry to trees, incrementing OE counter
   - tree_insert(&tree->tree, ...)
   - list_add_tail(&entry->root_extent_list, &root->ordered_extents);
   - btrfs_mod_outstanding_extents(inode, 1);

For btrfs_split_ordered_extent(), we don't need to do #1 above as it was
already done for the original ordered extent. So, if we factor #2 to a
function e.g, init_ordered_extent(), we can rewrite clone_ordered_extent()
to return a cloned OE (doing #2), and also rewrite
btrfs_split_ordered_extent() o do #3 as following:

/* clone_ordered_extent() now returns new ordered extent. */
/* It is not inserted into the trees, yet. */
static struct btrfs_ordered_extent *clone_ordered_extent(struct btrfs_order=
ed_extent *ordered, u64 pos,
				u64 len)
{
	struct inode *inode =3D ordered->inode;
	struct btrfs_fs_info *fs_info =3D BTRFS_I(inode)->root->fs_info;
	u64 file_offset =3D ordered->file_offset + pos;
	u64 disk_bytenr =3D ordered->disk_bytenr + pos;
	unsigned long flags =3D ordered->flags & BTRFS_ORDERED_TYPE_FLAGS;

	WARN_ON_ONCE(flags & (1 << BTRFS_ORDERED_COMPRESSED));
	return init_ordered_extent(BTRFS_I(inode), file_offset, len, len,
				   disk_bytenr, len, 0, flags,
				   ordered->compress_type);
}

int btrfs_split_ordered_extent(struct btrfs_ordered_extent *ordered, u64 pr=
e,
				u64 post)
{
...
	/* clone new OEs first */
	if (pre)
		pre_oe =3D clone_ordered_extent(ordered, 0, pre);
	if (post)
		post_oe =3D clone_ordered_extent(ordered, ordered->disk_num_bytes - post,=
 ost);
	/* check pre_oe and post_oe */

	spin_lock_irq(&tree->lock);
	/* remove original OE from tree */
	...

	/* modify the original OE params */
	ordered->file_offset +=3D pre;
	...

	/* Re-insert the original OE */
	node =3D tree_insert(&tree->tree, ordered->file_offset, &ordered->rb_node)=
;
	...

	/* Insert new OEs */
	if (pre_oe)
		node =3D tree_insert(...);
	...
	spin_unlock_irq(&tree->lock);

	/* And, do the root->ordered_extents and outstanding_extents works */
	...
}

With this approach, no one can see the intermediate state that an OE is
missing for some area in the original OE range.

> +	}
> +
>  	ordered->file_offset +=3D pre;
>  	ordered->disk_bytenr +=3D pre;
>  	ordered->num_bytes -=3D (pre + post);
> @@ -1176,18 +1187,13 @@ int btrfs_split_ordered_extent(struct btrfs_order=
ed_extent *ordered,
> =20
>  	spin_unlock_irq(&tree->lock);
> =20
> -	if (pre) {
> -		oe =3D clone_ordered_extent(ordered, 0, pre);
> -		ret =3D IS_ERR(oe) ? PTR_ERR(oe) : 0;
> -		if (!ret && ret_pre)
> -			*ret_pre =3D oe;
> -	}
> -	if (!ret && post) {
> +	if (post) {
>  		oe =3D clone_ordered_extent(ordered, pre + ordered->disk_num_bytes, po=
st);
>  		ret =3D IS_ERR(oe) ? PTR_ERR(oe) : 0;
>  		if (!ret && ret_post)
>  			*ret_post =3D oe;
>  	}
> +out:
>  	return ret;
>  }
> =20
> --=20
> 2.38.1
> =
