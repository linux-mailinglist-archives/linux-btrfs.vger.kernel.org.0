Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7C4529BD3
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 10:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242063AbiEQIK0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 04:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbiEQIKX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 04:10:23 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146F83C72F
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 01:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652775022; x=1684311022;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G/DtYCEHWT7aF1CPttd4tjP6vHRXj8wReoKTGmMbQSY=;
  b=mzdmALwmA45jbTb9cjqtuym51pPZZtx2YJg5G9GYHTJ0CShc2BlAqJO1
   DGCss8ADoBJBJoB6w6+bqzL60a6BWWjdJy2gX8hG95/I6IAgKh1y7JjBU
   T0M2bmqPtmosJBzn9CgZ5NmfnQfOuWaKtybc/dqaXAYd+YuMLWj8KNPd2
   ZzL8Q/alcCmpsl1xkF1571j8YzH8riVtFi8NiX4VazarhidUq9xd9LT3H
   YFeC1tACkUMEceQrLjQ19jyeeVJHPeaW5F/fen8IXuPkeI38aDqD6KthW
   yHD6z4tbf0I4Yv49dzacSUc3TKhu9hF7HQYriAAs7abL92oglxFVYtesd
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,232,1647273600"; 
   d="scan'208";a="199353790"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2022 16:10:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNzPyQ9pW9BviTsXQ7RT6QxYhzDk67oCrshKVhS/RfSc2stGVs5XqBG4J8AGWv7iKIlGM81o27/AoM67ZZjO7vD94QVFj3O8XHeoahHJDtI28NALJmKOdCRTROJwE7KMiUwPSlnV0U3u+ca3ovVXhQfoaYOFA8N0vSq3rh2TSQwmdGaXheAaJBZ/2KpyvxgwH1K+juhO1PTFBArUj95bkFGCnISIOF0ZEJimE0BQp7CjCBysw5t/QKU1Tus3GGgkeDxH4NE4AMCTIPf8y0dLUTonjIhfAM2pKXCiuc8n1iJg5CsKQlKqJxdCOEIgBT9e1c5r4DzKS6gWxcUOnaOVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lERCZvjJJiFs1j738oFh16mEhPv579bw4HGnI5zlR7I=;
 b=A0X9E9rTp85xJvRdpeTuaBMXzn3PG+ttohWMY49+pJnu+gS17YaHgp1jhgjYEVuLApogO87Wu/zuJaHOAwhxn1+VminwQe9VlZ4AtFC3goorGnWdW9lEATsPqLRwOMCeDoo4oTJI2ayxiBIBxZLE0pK+kY1VQBs+ZjYUSG1xqm1emoh9sStoNF/n81YujDxkkPm+B9b7hdZIW6+KJuZ4nKczyZ7zAksE/vK6txCj2oOkRXWc2FzzUyTWlYSEw4CZe7d5+xt73wgPwJRgM+pba3gxHXmDRNppEqotys+oAE711l7ytr/w+fXEawMWDnK4BGdSpVTnYIhNIvw/k27L/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lERCZvjJJiFs1j738oFh16mEhPv579bw4HGnI5zlR7I=;
 b=yCUfyH8OoZSNq+wKlCPdghxg0mYuSN+G5Vs1H0lf+u4MztglhpcCBWhyoxO1tLdO83h3oftQxfE3dbvVY2pfIeQcw+vS9Fl+nvZJ4LYiuOpE15SCdTuwlc0WcKwXjBVXdCKo2kaxTPkRh8MF5Q9i/nPKVZ9rZvitbXnDXVR8Sz8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8077.namprd04.prod.outlook.com (2603:10b6:408:15c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 08:10:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 08:10:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC ONLY 5/8] btrfs: add code to delete raid extent
Thread-Topic: [RFC ONLY 5/8] btrfs: add code to delete raid extent
Thread-Index: AQHYaTGzxFAMBdfaGEiUgbBInU4byA==
Date:   Tue, 17 May 2022 08:10:20 +0000
Message-ID: <PH0PR04MB7416FE34CF8A665F960691179BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <b018704727883c27c3368f1cd3ba84daf682b733.1652711187.git.johannes.thumshirn@wdc.com>
 <d16c5465-2c24-1ce1-9b51-be85cd96259b@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ae2c09f-6ccf-4f83-8b4a-08da37dcaf95
x-ms-traffictypediagnostic: BN0PR04MB8077:EE_
x-microsoft-antispam-prvs: <BN0PR04MB8077E399508942D63ED6F8419BCE9@BN0PR04MB8077.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r7jnikjAz4BHx/Ioqn8uw24mH9ISrKTvAyyL7a0wni1TQG2bf2EYz99V3YclmuCCu9kX9rUOzq+unuKmN6dpdD2FfHjma8tuecJayJRwoOQeE9xbk4IicUaphoqXKu+Bz4z2jo8z3PaoI4XlUhQGrRBbnb/fVFbIhdm7GkdNBLu7TG7/Qz26CIixs062Zd2EB8BHDQo15tXvsXfdSWkjDzbRwKKF1unSNgo0FX7ffevEnPtgJIjvlgmhAQz7b/o1KF7cB7ei6oNE1deSBjSAH41h41T8u+0RIxKesDzjbLyX9cevA7kpg7q/uZ0bQK1ZhMpTdwG9YTzBQF4+XLOiQPT9XFPoPQpe+wXgm8rZwL3lFVCazFvNpzck6PPCvyM2n+89pnDxFkFUTxKfVlCHlz/xOHQYwrvCdxagN3bjr722QkznoY3CQ8bZ08ptIPGVWLTgZt97uXTMD2d4rtNljMiOI+sgWeyf1x7V2WDoCgkkT6WScUr/PJScLRPR1/Em75UxUMhcFTABHFRQiwf0fKPofOjXQA+Hj+BsFou8K8+6N4N011QcL7tDsDDIQOeJ2FO+/podDPjYKjgxklfukqNizWcZC/t7s88kqPU1VpMMpkNwEO38+d4t9D6noEWwCtgihPSNfN63KReOevrlV02NB8p3CcYHb1eF9wGufLqVAOk5rNQC7EahoZ5lxXzb9k3JO+JlYWXjaC1MSS3bqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(38070700005)(2906002)(33656002)(186003)(7696005)(508600001)(82960400001)(6506007)(52536014)(83380400001)(53546011)(64756008)(86362001)(316002)(38100700002)(110136005)(122000001)(9686003)(55016003)(66946007)(66446008)(5660300002)(91956017)(66556008)(66476007)(76116006)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f0miBvreO51+zWw6doQJXwI3BHEarcWISIPHNXWLvVP5zf53M7HVuW7ciu4O?=
 =?us-ascii?Q?0/18ZvZpBRCDDSIL4gp5ABYr4uY9sZhpCY3sDGj6SzzAZwoYYy7aCIk9O1Li?=
 =?us-ascii?Q?FedWIGtA7rznap8t3dyODF0yDESdhzsPS8XLTOciIXMujacWLBINCgoisO1g?=
 =?us-ascii?Q?q/3/bK8h2brWJQD9/CV7ByXkJLbPdVS1MfgZAUE3XQPtDzuXd6iwIE2q3EdC?=
 =?us-ascii?Q?V2DFpjNPWlAKHa/ka3aqMlf8d22ZTZpN7vOKOcbfMYbJcMDj04uAHb8f4pOj?=
 =?us-ascii?Q?P0oQE6qrnIf6bLxYH3mfUYtYFmUaZt/rDGfZ5Jrlen/mLPChLdj/69IeSjH0?=
 =?us-ascii?Q?+hUPllcnsjoXIi0PI+49nMjObszaDWFIUkIXu40FViWWIBrX+Wrk5aKKt5Cm?=
 =?us-ascii?Q?AfEcLCXbWhmQLucdyB1QuxqXidC9exiefXSho6qeuYAMfKBarUMdws2szIyB?=
 =?us-ascii?Q?+EUx5eWp2idBYtm5Bv0iImriXKll6hDD0m3HTIRfM8ZW9ikioC8WbwKXsiRN?=
 =?us-ascii?Q?bQP48ZtN20MXQ2GULRAF8Ocdoim1cX++NsveTxA/DqVQ7xQ+lm0dCZPU/2wL?=
 =?us-ascii?Q?WvQR08cTnuQPD4uoiR8Koe2WruTOf/BOHGQRMscNo21W0dbm+R3inaE92b2H?=
 =?us-ascii?Q?AgMFDHPl6IOZqMlltMVPzKbdpQF6hHYQWOplTV71+aFu4LZDoed/fJLZynH+?=
 =?us-ascii?Q?KorgYWsF+uG7Q/+Ehequfxy4cdcm+4nSfDgEhlxeekvs8URHpl+fv5Oe5lDZ?=
 =?us-ascii?Q?GSftdNkQAuTaYb5rMrgj3g3Ya/iCOfHMU/EVd31uAI/Na74wd3NhTP7x670x?=
 =?us-ascii?Q?dz+RfdMeiPuI44eBwoR/99cy8p2BrfYXNhPlEskt9pxkPpDXXSrQCcWn18wC?=
 =?us-ascii?Q?sVspFCLkrbaWVCTFtIzOCFCj+hZ3aJ5IQnw8n7NEjTH9OvA9su9AXMoqBnB5?=
 =?us-ascii?Q?DyiMAarQurKJziWPVSQ9OvuCppYPbg9e5O5WEcsYMe2rVOhrtGjNRVpfrWmp?=
 =?us-ascii?Q?cIm7b5YvGFNAM0E4MrvvgkttMG6OnzXd1tEe3w3zpLW2qUiwULO0QmAl8kv/?=
 =?us-ascii?Q?BuRD193fGLh3bZpaiFYK9JHbh/cOf7w/qYZLQZqCRLrKWb7aNV4SDTS0Skos?=
 =?us-ascii?Q?qKw87MlkDlgVUBiN+YVVaiDSopqYSANl7h6F6Joc3pps+lEjyS6R118lC+O7?=
 =?us-ascii?Q?AcYbPkZin0VGLW5tn7Zw0B0Nm7jW1lFuoPQRMKjMGpAVO1F6bo/REBxiHM95?=
 =?us-ascii?Q?YkYxzupG7rvRyBc4dPNYH7NxSsYHypXszbZw3g1nT054MrdXKJyxnI1HtTyK?=
 =?us-ascii?Q?ydFMclYTA8ZtoUyAh0XA7D8LlcKpNKqLfhOzyAJhNy4VqE+nG2hStR2gJM3t?=
 =?us-ascii?Q?H2nvihKDQcnKVExm8ahp9evchtgZ9XPA58RvGXUoPVhUAZ9dlN534gAoBKig?=
 =?us-ascii?Q?SaMDY5LI9fmYCdB8lIygu8QDeTC2/jP2ZqncAOgGOmV6QErBdQWvuJ+cwRjh?=
 =?us-ascii?Q?PRJj/l2EfKerapKaGOZSbFyU0Dj3JwnwkdavXJiz/IL2TNusIiJyGLevq0+g?=
 =?us-ascii?Q?ebbEK/es6fCjBYgxhuBZ3rzjwJsPuSYiZUe/pBBITzecDaFZdhGm/1D59zj/?=
 =?us-ascii?Q?0uACpxSA6E4iAs52nincK9E1P3s531+qN68GCGJzFk62WS0zkMKhSMmtRuCr?=
 =?us-ascii?Q?XZFepyzIyiC5cZRtwemFkWI7RazYmJolrIsNrFUoIycW+uozEt4EperCNKSU?=
 =?us-ascii?Q?YVy/AWckS4UVW64XCozM2PV1zEBml//9Hoe1Gv6R1ReeZiPneH+0xIO5G8Si?=
x-ms-exchange-antispam-messagedata-1: 5azGw79OpMReNwuY//wO8Ee6wOxyn09xQ6S9vibyMp/xIMSMcd5/79RW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae2c09f-6ccf-4f83-8b4a-08da37dcaf95
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 08:10:20.4023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qTnKJ1P3RX9Yik2GtgoNGTQEiauIeE2Ob6hz6k+X9K7RPkl/7loMfkhsRLgIsiDFHg8F2186blEnkP+qEeNCtjgxih6CQvGYHNWb58nAc4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8077
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/05/2022 10:06, Qu Wenruo wrote:=0A=
>> +	ret =3D btrfs_search_slot(trans, stripe_root, &stripe_key, path, -1, 1=
);=0A=
>> +	if (ret < 0)=0A=
>> +		goto out;=0A=
>> +	if (ret =3D=3D 0)=0A=
>> +		goto delete;=0A=
>> +=0A=
>> +	leaf =3D path->nodes[0];=0A=
>> +	slot =3D path->slots[0];=0A=
>> +	btrfs_item_key_to_cpu(leaf, &found_key, slot);=0A=
>> +	found_start =3D found_key.objectid;=0A=
>> +	found_end =3D found_start + found_key.offset;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * | -- range to drop --|=0A=
>> +	 * | ---------- extent ---------- |=0A=
>> +	 */=0A=
> Thus I believe we don't need those complex checking.=0A=
> =0A=
> The call site has make sure we're the last one owning the file extent,=0A=
> and since raid stripe is 1:1 mapped to the full extent (not just part of=
=0A=
> a data extent, like btrfs_file_extent_item can do), we should be safe to=
=0A=
> just do an ASSERT() without the complex split.=0A=
> =0A=
> =0A=
> Thus, I guess to be extra accurate, the 1:1 mapping is between an (data)=
=0A=
> EXTENT_ITEM and a raid stripe?=0A=
=0A=
Unfortunately not, as we can split extents. I've found out the hard way tha=
t=0A=
we need this. See btrfs_drop_extents() for details.=0A=
