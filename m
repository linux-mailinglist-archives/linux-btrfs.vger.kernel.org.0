Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424905A20F1
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Aug 2022 08:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbiHZGhR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Aug 2022 02:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244874AbiHZGhP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Aug 2022 02:37:15 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DF1D11E5
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Aug 2022 23:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661495833; x=1693031833;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TXD5bn9WOY6Hx+JVBkdVOUu3HWW1k3GFCkWk2Hs7otU=;
  b=YSB5YlDFA+j45MZS4/JZqXTevuAwc0QHPsdv1iwrFgybzTa2GIJ+GXkB
   ulOCIEvZh1lMxf+R0hgNWSHz5vDCIjLsbqyHVsa4CspYL3qA/W/xrbSvN
   gjWsO28MV1BR2W3I/MbU8yOd/aKN+wGsqEOnalnILM6Y0zbVtGCrVKvIV
   LAAqstpXLa9Od+77r3QSkiBstQYD3fmduw+VQzmosGN2WPqMQ1j0Pj7cO
   l1W12PokTld0XjfdOvFSPKsDGUihzQ8UlzcH6GY+w7seMi7oma9RA5s6l
   qFCR1dLDuTnHLKT8XwV1yQT7T12HZfnEWV6t6b/xWl8bRZvYAAMKbH/cy
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654531200"; 
   d="scan'208";a="313998700"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2022 14:37:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMlT9TCVRzzT2/jKscWvE9vTRndl0sAhZI3Ei4Oc8Gn93Mzab8HrGx23jg/03jLfF4eWbxfUBlIqq7P+2IBZyleR/qGXsSjcq0nE+w2NLoAufLi5Xe4f/qgsTm2D4Tags9Wr/2I9lYKTGO5fBenTuw02hTQDPKW/ATwLh1hGiz7FyIyFCxDRzR7sJktiIKsM8k8jJoF6VdkR8hKemECffI4XQa/VYH9NZ6HDjnFeJHn3ZVL9c1E0Pf3sAgsVCLOlkZ7OUKa3a6blY0aXgc/1IiUnyizJdY7yWslrY02CJRYoQdwFtcnYKKFeG0eP9IjO6bIV0W37GBgv0h8A46RLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b60dETq6E6R5nyuXsuFg3cOH4L4DjrbixLQw3P8MFak=;
 b=G5myeVF+7nt8fTJWpxRJoMgYJdDKro/qCzZEgwFfnm/ro9i8Jnpr/XmlMBrLvV8Xgv0QfIo9lExf7MIyOhkxJz4nnM5Ouj5+ruN9yiiOK4Xcg4zN9a/CLJU70mw2vw9ZRcXfLI7TUlnG07Me9hNPIUmPqz+bmpLgFcZUFEKb/d49JwGv8NYkHh2iAMMapDrNBjdV+Qv98dhCIPuhALKYdaEkidrPLNrRE9NdcleYOqWtgwUZpEc8kSZSIkCSPJCYWjUrtzJ55wriDDPnW1ggjMg9Ti6XWVp6/tcszec73KVHAi17dM7IthnMxzuFvjwlPpSaD7OUxQH2WfTg7f5JCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b60dETq6E6R5nyuXsuFg3cOH4L4DjrbixLQw3P8MFak=;
 b=Xusq25DOve+PatxEumdXThstZk46hJd6uWVIslo4wIP5SOhJidcA6NVgxdtcIUQsJtqLYD6TAu02Sj9m4UgWTv7ThbnRnCkI4Dz+fmtASvkt7vz1Ou9H20UStq24nrDSMg3zX3abetrF27IAmVFZ89xHZ5Or3+4mrjelD6aUibI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7429.namprd04.prod.outlook.com (2603:10b6:510:8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Fri, 26 Aug 2022 06:37:09 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633%8]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 06:37:09 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: set pseudo max append zone limit in zone
 emulation mode
Thread-Topic: [PATCH] btrfs: zoned: set pseudo max append zone limit in zone
 emulation mode
Thread-Index: AQHYuPAhzmnazZ4kc0CLp12HwjOhHq3AqqkAgAAP/IA=
Date:   Fri, 26 Aug 2022 06:37:09 +0000
Message-ID: <20220826063707.oglrfofu6yjt66id@shindev>
References: <20220826020400.144377-1-shinichiro.kawasaki@wdc.com>
 <20220826053953.jx4yvk3eaflcn74y@naota-xeon>
In-Reply-To: <20220826053953.jx4yvk3eaflcn74y@naota-xeon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec652b8c-4b03-404f-4cf6-08da872d66c7
x-ms-traffictypediagnostic: PH0PR04MB7429:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J1yqGuXIE3Tp25FmgRzuTKryG3UZ8NFCODslowNPhweO5zlc9tTB2Xxfxdk0XDqNBYhIUPJjtHbPCKM52AC0oNo3gAFfbnCErBaKQ9kk/LMzxa/JmJfGQi1VvhfEmcrx0ng4YeH6vepPkXGPRt1i4ffuEPGnFtyW8DKK1sJmdB6/8MzN5iMJeeIK3zjKpH+eJNmfMkrE3iS/sEta3XAnDlOTpb4GMfXTDnyFLAKEbAgbwkUh/1a+GKt3x6HzT2ilERqTeLftjrOsT6BsynmMHH83i7CCfB/qeMiMUfrH+uSOeEi0gYjHDTV0qKj3DEjBxc6ZG8bYiBDdx0x6AWr0hIyI+WOAYnccBympOvU6aCYsQFNMLjJH4v9FNQCZ2IVDKNY+ytkyqyJDDJEwleNn0Bh0VSMNZ7yUglYPtXg+3gaExXi7hN8L9JIfGzic9fqW5CDPQkAloHVHxwINOT75z4driqb9I/Cca/7zMcSMd5flxttVect4cKjIlwSNkL+KfDlkjnLOZ3XkGgq7WN3B45Ozj80DQVCHn9aYHT2K09gEVFAbzS+dC/sf/kGo9J+iRzelvkG/MxUPtEkrtpgQKy+2QNanzVVfICYDKSdZfyvdquaws7KQHeacsMmEvXFubLjeSwSk3g8TtHEz+MYAf6+qx13/sPWFurdnK/4SpNVt2k9OH+KAF1RHus9TBA6mXsjFkpnwocRkxBEfsrwh+mOYdpGkCEtgoJCncCxEEFf8babDL4a0Ox7q5rIRUkU71iPtedgrdVN408eN6jI3kQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(396003)(39860400002)(376002)(366004)(346002)(136003)(186003)(2906002)(6486002)(478600001)(5660300002)(41300700001)(9686003)(44832011)(91956017)(76116006)(6512007)(66556008)(8676002)(64756008)(6506007)(66476007)(4326008)(66946007)(66446008)(1076003)(8936002)(6862004)(86362001)(26005)(38100700002)(38070700005)(6636002)(82960400001)(33716001)(54906003)(316002)(122000001)(83380400001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N7GAoSCrXnn0sSnmDhurVT7eayy51Kq2uJOLEicr4HWXNvoQjLaklL/Kar2t?=
 =?us-ascii?Q?94jUU7AakDn/fl+toSZ0xcJOQ0n/MbTnXQ/07t7S0VjNPLi8TMeXhGjtjYPs?=
 =?us-ascii?Q?JKR3OXS8ALSY3dSWBhw9nn47S30V/Sr8sJ8MO852jlTwoUEOdcaxgExyDnz7?=
 =?us-ascii?Q?4Ub6BdCqbwxxomOHET9SXz0Vjp13OmHr5sKqew0JsK7aoQ+aBnrWKdifMS2N?=
 =?us-ascii?Q?Vx9W5opNTAkH53TPJ4GVFrT1sHFN/ej30jO4suF5aGqNkKCjXkpeqoKTXY4e?=
 =?us-ascii?Q?VHPm5us+vWXjypDqmmjf+HewaodcsljcIXRCQNJOS9zYcCMOliGi1vGSZ2TP?=
 =?us-ascii?Q?aT+wFG5Ix8kw2PYBYtU16oshfWv0IYaqfiGNqrsj8qc216rpeQFDbiQYX3uv?=
 =?us-ascii?Q?aRNbb67iFhVPJXSJw4bCflI7uqpHJcT9ZXodGvBAOC3fwRno0H5mXy+tNjl8?=
 =?us-ascii?Q?VdpGKHUTLH81JITVfjxOTN+nig6OPpwOl7wwj9Hi2gd3AFg5VQia6i7omrNS?=
 =?us-ascii?Q?awsLn7aBH+oH+w/bDmr2NyoqKE+pmwaRf9gEnZI7n0sOSUXV7NAM8LeljbsB?=
 =?us-ascii?Q?xPOO+ZdvbzEzUaOv+2vXk2aVGiT1Cz0z5nEREG+oW03ui2O3+JPvuDFwoNJL?=
 =?us-ascii?Q?2epAnp43ENE3W5IK9HwmqxU1GDpIUIHPDQSlwCxJLDzzB8EzAIl4QHETHBJJ?=
 =?us-ascii?Q?HnAP4KlJXQsdJWxQDl6muY/hghn3ra9sIYr90XwM1gB1KSrlQNKd8zntkaNb?=
 =?us-ascii?Q?tdxaJNGkMfFuxZ3YyG6wqGPGyKwJtI9fTcVWctXQxGDkQUnBeUD+/mCYrcNk?=
 =?us-ascii?Q?BhrgA9Y6sa4nwvDIaZ1HOsRNuJatF0JbWh1gwP93MzJ0boVUjxFzUXtIgJjP?=
 =?us-ascii?Q?AeBbwYIysxpvjAFy94LOGmgcBgpXJ196gzMTnpKNJEq2zFrndWGC5/hDlRFG?=
 =?us-ascii?Q?kuLWdr2UjAq/CFzAeI1cMyJ0xPN/K3CnDNL8dNBGmS+4VrW1Ns3pmeC0rExc?=
 =?us-ascii?Q?i5/zcWw9YgYg5DY2ImgertNmwcvOL0evQTRC1P+XGPDmUHyhCv8ExZxm54L7?=
 =?us-ascii?Q?Y76dj9h80bdnXJ4jcO4aEQ/GZr0GKUVnjeq0jDioOQBI40aE08vCoFvebBoQ?=
 =?us-ascii?Q?Y6N6PtqwMNoMQXw8F9Iy09hojphdOI5kneDUAIiGTU2CuEI1KPjGJp/apTPU?=
 =?us-ascii?Q?KU85UasgwV883MYcEy2WB2F1JWSUfJ5z1ySjkhE1Lg/9Si/L7gnIiy/oiiXq?=
 =?us-ascii?Q?7/uOInsiw04nVcHgVVnzI2cEgBkAMCWiyBbdAQz2Emt4pXgMowmeRHSMbcha?=
 =?us-ascii?Q?DqS+ur0a3AXFk/CAtm39pvLzQpdwOnxin/azFCe3sglmknoiopWL8OA2tL/1?=
 =?us-ascii?Q?iCFfTkgcRpIm+WvO99GGeQfoFmQfwwfxAQDcoBMZZjMPOu9Op5yY8pHk2SYI?=
 =?us-ascii?Q?Ct2dy940NV9Tul6E3kgAPzHtCaVrUmoEuik4eTapkHlLJBVvTiSTWTbp1k2B?=
 =?us-ascii?Q?vdiPzUEzr1QWQoX3xBLvCDpddSgjhENFmy2qLi+kiIYHMbjmh3ZDgnvgUtNJ?=
 =?us-ascii?Q?HPOkvzEr68WLoxZcn6FpoSi4Ip6q21fkLxwOKX1oIQU/0bAt8ddsGyB/rBUN?=
 =?us-ascii?Q?/yXUIRtvro3WpAttUlexMyQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <64BFBFDFB3E7174C9A853B057EBD3EB6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec652b8c-4b03-404f-4cf6-08da872d66c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 06:37:09.3336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RzKKHK1QLGvuE09NS7kN5fXi/EWQJJaTabcE005z/lQgteEoqyXbjKQmezvA3ANxyKr1cfT5OgRsrpfjIU3kLaFpTir/Zk0fgrsdVBL0Nso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7429
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Aug 26, 2022 / 05:39, Naohiro Aota wrote:
> On Fri, Aug 26, 2022 at 11:04:00AM +0900, Shin'ichiro Kawasaki wrote:
> > The commit 7d7672bc5d10 ("btrfs: convert count_max_extents() to use
> > fs_info->max_extent_size") introduced a division by
> > fs_info->max_extent_size. This max_extent_size is initialized with max
> > zone append limit size of the device btrfs runs on. However, in zone
> > emulation mode, the device is not zoned then its zone append limit is
> > zero. This resulted in zero value of fs_info->max_extent_size and cause=
d
> > zero division error.
> >=20
> > Fix the error by setting non-zero pseudo value to max append zone limit
> > in zone emulation mode. Set the pseudo value based on max_segments as
> > suggested in the commit c2ae7b772ef4 ("btrfs: zoned: revive
> > max_zone_append_bytes").
> >=20
> > Fixes: 7d7672bc5d10 ("btrfs: convert count_max_extents() to use fs_info=
->max_extent_size")
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> >  fs/btrfs/zoned.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > index b150b07ba1a7..560dd0a67536 100644
> > --- a/fs/btrfs/zoned.c
> > +++ b/fs/btrfs/zoned.c
> > @@ -421,10 +421,19 @@ int btrfs_get_dev_zone_info(struct btrfs_device *=
device, bool populate_cache)
> >  	 * since btrfs adds the pages one by one to a bio, and btrfs cannot
> >  	 * increase the metadata reservation even if it increases the number =
of
> >  	 * extents, it is safe to stick with the limit.
> > +	 *
> > +	 * When zoned btrfs is in zone emulation mode, bdev is a non-zoned
> > +	 * device and does not have valid max zone append size. In this case,
> > +	 * use max_segments * PAGE_SIZE as the pseudo max_zone_append_size.
>=20
> Using 'zoned filesystem' or 'zoned mode' is preferred to 'zoned
> btrfs'. And, 'zoned btrfs is in zone emulation mode' looks a bit wordy. S=
o,
> how about this?
>=20
>    With the zoned emulation, we can have non-zoned device on the zoned
>    mode. In this case, we don't have a valid max zone append size. So, us=
e
>    ...

Okay, will rephrase as suggested.

>=20
> >  	 */
> > -	zone_info->max_zone_append_size =3D
> > -		min_t(u64, (u64)bdev_max_zone_append_sectors(bdev) << SECTOR_SHIFT,
> > -		      (u64)bdev_max_segments(bdev) << PAGE_SHIFT);
> > +	if (bdev_is_zoned(bdev)) {
> > +		zone_info->max_zone_append_size =3D min_t(u64,
> > +			(u64)bdev_max_zone_append_sectors(bdev) << SECTOR_SHIFT,
> > +			(u64)bdev_max_segments(bdev) << PAGE_SHIFT);
> > +	} else {
> > +		zone_info->max_zone_append_size =3D
> > +			bdev_max_segments(bdev) << PAGE_SHIFT;
>=20
> We need to cast it to "(u64)" to keep enough bit width.

Oops, thanks for the catch. Will fix it in v2.

>=20
> > +	}
> >  	if (!IS_ALIGNED(nr_sectors, zone_sectors))
> >  		zone_info->nr_zones++;
> > =20
> > --=20
> > 2.37.2
> >=20

--=20
Shin'ichiro Kawasaki=
