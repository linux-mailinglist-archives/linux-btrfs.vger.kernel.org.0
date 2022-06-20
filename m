Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3796550E8C
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 04:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiFTCWr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 22:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiFTCWq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 22:22:46 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C9BAE66
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 19:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655691765; x=1687227765;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T9kiTZSRnl9AZy92+fE9ibCa+7bXS6oHDw2BwpRnoHk=;
  b=oxPSovs8Bh8dRPn8BcYYF9GngEOLcxpk0jKmAZkewN6GHCnSd20hRXqQ
   DisLxPlF3cGsS/N9uxQwiw5zXVRe6xlDL2zQZ866OadjtuoGO6wEP95VM
   reUAJW/RYMGV7vXXVVJBuXSRpnkjdOX6GnNlOHvsLr1P/jzPNeTzCKhPu
   I1nwew7DeC6PjOTr5fNl+YfvbDrlK+yJDecLDhjeLCk7lvoHLKt4kJ8HL
   RE4IPqk/iq1HoSbFTSibgsCDu8C0gxZ71akSsZlJPrIwvzGDoa0dsZV5r
   bMYq1LOcWXV0T4TV7qz8/ON29vLb7ZrlAZUL3v5aHd2mP2OBGgYl3iV+L
   A==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="307898508"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2022 10:22:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iu0zPf+czLFlVqFbRzAkDX+NHLgJOqzk38vDVVwR8RgNEhMVYjeZqcwEJMZzIXFp9Iel3BZ1Tz9z7hv42KiXrPRy8vLUKSihBjwiqRGfbDgV8yL7eQxgWMCp7P/d+h8tkY9FkaEFRV+4ar0Jhu2HaOuPa47mNIZ1cZ0eNgh/9EE3nNYfFexbHHx9UHjjtpeNP5vdYW/KrmuUXLV59BUO2p6K2fJOSqEtJkrHWgbccmsAdjM2TYDSdaagc3mchygMLD2bM6exb4giZuH5nok2CmWw9MYDQwJ+vnhS+cdHWDnXr8CNew9DWONYm3/kTnWMNJvcv8Hr2+JxM82/MG8PEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7ujAlTk4J2A7mGvEMXwF+MY3bMTNpDC2hyR6HrXysY=;
 b=Oavv8P+ON86OG9eKkVJYmBo6sdKQ+FxE5JtGW+8UeMbRsF4UpPMQpClvgBPK3vVU00d3G7NtLI2dP/piJs+oqPV2H1JflbnQbv/lihbh69WosbTl8xL3Oq0ZnWuKVsK759HGVRv4prPkmfMxv7QX9wVPzSyghZWFHortgo7xZPoUOXmIyN4TLSBOI969Ib2fr8jwn1DRMIzYE30N6nRt+LnPGZ68U/NlpGkEObipeXGphUP/Ua+3UaVtG0ZiIJMjASBosJiQZHJqORZv8jH1RLjV2i7AKJnVnra47jSaxJCJrzRDFRI/Utg5dOdX18GDI5THi9DGOVC2GxFpf8+dNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7ujAlTk4J2A7mGvEMXwF+MY3bMTNpDC2hyR6HrXysY=;
 b=dIJU2ZE3W/+MEXL8SoiwJp7q4N4UIXD9EMut2bCg5u9L44Q0DM8zrpOjtP2dymT6BxuwJCWXZWxB2oWAHsnTX1QhQgoCnnayK1zEq+0C2KQwis4NiUIM4EBxpsmZN7dNIfCfnNieWOH9URQwcsEOrh2+41lBQhFANf5O/GQcdak=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MWHPR04MB0576.namprd04.prod.outlook.com (2603:10b6:300:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.19; Mon, 20 Jun
 2022 02:22:42 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::456b:ac5f:e71a:7164]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::456b:ac5f:e71a:7164%9]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 02:22:42 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/4] btrfs: replace unnecessary goto with direct return
Thread-Topic: [PATCH 4/4] btrfs: replace unnecessary goto with direct return
Thread-Index: AQHYgZgw+RQEKJ84HU2EarRnVKSjqq1TYooAgAQzggA=
Date:   Mon, 20 Jun 2022 02:22:42 +0000
Message-ID: <20220620022242.6rkmbbs2qiz63g7q@naota-xeon>
References: <cover.1655391633.git.naohiro.aota@wdc.com>
 <7ccae9fc6975246cbb2be58c83d9ca6e3fcbb123.1655391633.git.naohiro.aota@wdc.com>
 <20220617101318.GB4041436@falcondesktop>
In-Reply-To: <20220617101318.GB4041436@falcondesktop>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3846961b-55ff-4fd2-c734-08da5263c186
x-ms-traffictypediagnostic: MWHPR04MB0576:EE_
x-microsoft-antispam-prvs: <MWHPR04MB0576C560CB8EEDB54A4320CA8CB09@MWHPR04MB0576.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KG7i0q4W2zZpsmS19TUywr1iAct/0mjFAc5g2z1ru4E/rxw8fjReRxQNQC5zcSMm+xgXzxr3YmVRPvBi7zIkglEV1W/ZTW9AxWcZ4Ys5O1ppZMf4wRf8I2W8WUZ5EHjcvi4ju+GgpNmyBdPtjROjAAgXwh15UUXlPXh2EbaFiM4Qo077ryIvBYJfhcQtPdtoby09/T7CFFiATTsWqnrvjlBsaYWzoy3yQ5AlYlgLYoqxAiexTA3JI+9vjKwdZ/v/ICa5ej/WWPMle2h4QiC1K7E+5Qeb5KkRWykFjFOWVO7EXt7p3PDXY96BQlLg6l0zduwolzvPiOUKBhx81ttA5rWwfj2abgcz5T2WPp7AdwsJHTpPzN90EjE7jgbozrXAnb+/IbezyTU69hv07ysaaqWhQVY1R4MyhH+6KojF2LJM5YaOxGInFJF/ITZXc6fRtK49bDV6I9AhWPhqpof/K4R6UoSD54BXpBeuYHb52GS2ChVAb4DrN27FhxSp/EOUrXgS/ebpu9OO/L/bvX5cd7tUxjDRjxOcRbnKeRJDGpOhtJzoV/o+27oubN/p85Ag4w7LsDvSdHUTpFvIyX4KS7Jwnuwv3sjJOaTulYj2ocwke1e3JKxatWXkrKc//MUGky+fhK11atPRHC2dBn+r/gZF3jRUhBbnQtzkaHr260xLl82iziZ8+SElVkKrKlnC4PjGtiOXLSXEX6ou6/W5qA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(346002)(376002)(396003)(366004)(136003)(478600001)(186003)(8936002)(5660300002)(38100700002)(316002)(33716001)(122000001)(83380400001)(41300700001)(1076003)(86362001)(6506007)(71200400001)(4326008)(6486002)(6916009)(91956017)(76116006)(66946007)(66476007)(82960400001)(38070700005)(8676002)(26005)(6512007)(9686003)(66446008)(66556008)(64756008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?daw0716MsFlOJ9dn+Wbc0UiAd/MCw1xG0oluT6T7LLUS40BiepzaSAPV7CCr?=
 =?us-ascii?Q?P14GtU77iMTmU9WtqYZV720CMJ36z47KbGxZvQmRL1TDI9A3m0EUJq6Kd4go?=
 =?us-ascii?Q?P76kuZ/oSa8G06kB7AygjpFjHlf9IXrJFcOKcYUfyOZx7oepb+CPp90nE1Cd?=
 =?us-ascii?Q?WgtxU6ZfmtIXDJKY6EkYstHDQaIbzZ2kgB2ru3qT/bWdJm7cCfGxwN24ochX?=
 =?us-ascii?Q?PctDsHO4lUXoBVAQzy/2x5wTYSlUzOl/Q7DMf8e3gqxOyBG0Bt37waJG2yH3?=
 =?us-ascii?Q?sfoSJFUWD7rHa57e04d040KKtlFrFm9964SKrIYHSiM25Im2mpefgpb/C2Yt?=
 =?us-ascii?Q?KeEAD7gybljO/ubMQzFvNUqWrK2IDm8Whk2ZkofqQvYx3G/qep1lud7IRf9N?=
 =?us-ascii?Q?1VR6esOPRKl04WT2XqvNv/yW5xsw6mcCBOEnJYeNlljJfUrPuqhAnANvlP7k?=
 =?us-ascii?Q?f8Ltl8ne5Cl04APC9A463jCdOz+113/B+41WYyU56Fta/SeRtorgTmfz2v/Z?=
 =?us-ascii?Q?Dg10O3FHjRrKBI1rMSoU3vipC8DbTqzGoCC/h4cvULf4/Qb+p8NqmMRFKXAs?=
 =?us-ascii?Q?i9FNjsuQ9v2bBQNZx814qdmXubzmzSfpONJKPUNOlkxgP6gCdKrTWArOoIcn?=
 =?us-ascii?Q?gES2RnRtYV+L07fXGFc1Ht4W+bByzRm8ct1YGdks1p+xn3MjvrdeQSdw+jkt?=
 =?us-ascii?Q?NxC5jLz/2VgD9kZlufaF6iPSiXI49QGvMHfsecqGjZGwmdZo3aIqrzmg4Fyi?=
 =?us-ascii?Q?RI6Q/VYNWd0LBk3aoJObG0Q0ypffTSE4L+SorDjp28mDtRQRmoXnsXQfvjD6?=
 =?us-ascii?Q?f4jjOa+MjE52/nZ9VEy7ydw03rWEHkchuJ6uX/p8rQiSL+Rd9OTkNNkd4Msd?=
 =?us-ascii?Q?GT6fCGWLBua7pFQfiEVdkZmeinZwYFNeZm3bCgJH8MYJQn9NnR2T7trIucDD?=
 =?us-ascii?Q?lIjlUbXUtjGUCyZql88h7MEfqNZh0lAgYTP61X1xGn5KqEIIz/83LyvQWtfF?=
 =?us-ascii?Q?J6n6Pst1K7o/SMCFadlT0J9QP6kbs1WMDUYzPdUL56HqpDbV2lcI4sieMiZ6?=
 =?us-ascii?Q?/LhIsKtess0rWfL63W4H3bpU9GLqjPcENGjim1Zbz1ZLIJY+eEUDjDn7y5JQ?=
 =?us-ascii?Q?g3yvnYErRgrhMoRefQqlABoVr+8c1l+e7SYIYACo146qDcHsdpZ4SI2ps7F/?=
 =?us-ascii?Q?3dVVhRLEzbO01X/jsPT+ekZVXQ8Kk8fMZFD6s2iXnhZcoCcnibe5v/lp7XSJ?=
 =?us-ascii?Q?1OGxmC2VJhCmYteV1jHgbWQ08mNuv0CPDxL2AHrquBApWBu/QXcUlZICi59v?=
 =?us-ascii?Q?Ewp1dJDXJOZBd9zX4rw2+fABytAzpgO7W+H8DR8wuR1/f+CFSgG4Rz+gQiYa?=
 =?us-ascii?Q?5KMaeYrtRVQSNSGJWYjmAMC31RFOIDPM73MGWcvOrl23ClZS3kedPK60nevF?=
 =?us-ascii?Q?dyxFzUQkDUB1qcmIvXUo2+pMepO/qeh3IhYr40MEDgauxnxfESsixdDM11Ax?=
 =?us-ascii?Q?2Fi/ih71zQRxEks3aAdp33SU9wX4IfuxZeBBCiOvcIVyvamGd0SdTUAISNG4?=
 =?us-ascii?Q?+PM+c059ShDI8Gk8BzA78wRXLH0Z8WE5Szy1rKl+qj8ckqAR/k//6wgj65ve?=
 =?us-ascii?Q?k7ouSNyclpS50FiZvYu9XJrUwqw6dl9oGwLA9TThT8ciiL5qAVpY5wOfCW4l?=
 =?us-ascii?Q?cBHDuPq1HSqBqH/Ejv3m02x66QmMu7aD8TRTAsqikM2Udgx1me+tzSvVgpXi?=
 =?us-ascii?Q?jRI76dynq8pYK34rwcmlQUSlMTBJzVg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6E9D929BE0041D45A1E66CFED85DF4C7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3846961b-55ff-4fd2-c734-08da5263c186
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 02:22:42.8110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /DuT0wQBfd5pR+6/iOcviZGMChrOYzqWgVRnr8NJUUHYZvtqbVfi20Kztzb6keo4loXrEjqOL/xd2JyVflV+kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0576
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 17, 2022 at 11:13:18AM +0100, Filipe Manana wrote:
> On Fri, Jun 17, 2022 at 12:45:42AM +0900, Naohiro Aota wrote:
> > The "goto out;"s in cow_file_range() just results in a simple "return
> > ret;" which are not really useful. Replace them with proper direct
> > "return"s. It also makes the success path vs failure path stands out.
> >=20
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>=20
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>=20
> The subject is too generic, just adding "... at cow_file_range()" would m=
ake
> it much more clear without being too long.

Yeah, that sounds better. I'll rephrase the subject.

> Thanks.
>=20
> > ---
> >  fs/btrfs/inode.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index cae15924fc99..055c573e2eb3 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -1253,7 +1253,7 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
> >  			 * inline extent or a compressed extent.
> >  			 */
> >  			unlock_page(locked_page);
> > -			goto out;
> > +			return 0;
> >  		} else if (ret < 0) {
> >  			goto out_unlock;
> >  		}
> > @@ -1366,8 +1366,7 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
> >  		if (ret)
> >  			goto out_unlock;
> >  	}
> > -out:
> > -	return ret;
> > +	return 0;
> > =20
> >  out_drop_extent_cache:
> >  	btrfs_drop_extent_cache(inode, start, start + ram_size - 1, 0);
> > @@ -1425,7 +1424,7 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
> >  					     page_ops);
> >  		start +=3D cur_alloc_size;
> >  		if (start >=3D end)
> > -			goto out;
> > +			return ret;
> >  	}
> > =20
> >  	/*
> > @@ -1437,7 +1436,7 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
> >  	extent_clear_unlock_delalloc(inode, start, end, locked_page,
> >  				     clear_bits | EXTENT_CLEAR_DATA_RESV,
> >  				     page_ops);
> > -	goto out;
> > +	return ret;
> >  }
> > =20
> >  /*
> > --=20
> > 2.35.1
> > =
