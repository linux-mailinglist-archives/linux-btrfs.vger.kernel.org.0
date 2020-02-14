Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25F7115D420
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 09:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgBNIxn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 03:53:43 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3200 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgBNIxm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 03:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581670422; x=1613206422;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rj1jGXFHCgpx+mTBKFlIF45XVxcqimS4dxcFlTwEVXY=;
  b=WE+rTIgFxi89v1McL0iUKIJ7di93lzw6sWDSUlg8Mj50O5vWFvCaQ2gn
   PkCnuk8KS9UKoRjcHPJI6WRl6h1A/nPeBAd4QK2Ju6UpMbuEYcuEKy7SF
   iwp1O5cQ+i3Q1GeOzzsiCoNdDs7ibxBZpMuMZxeZTtT65WyAuyT3Q0Qll
   RDXsmqNjdwkeTu+Mu6/iEexokqGOrrG3bchcoyOin/BZlFcxOg7an/aj9
   27WH3Uh34htDTC30Wp7KejA2mKmlWwtwuW2YtyO/wma3GRDOK2Hk77a3Q
   JbwbbGyY0azyvvq3Fj8h1eRufV+P1U7494D1hh2cX0hnAen0Al6bp2B0Y
   w==;
IronPort-SDR: 7QVQ0Eb/eY2nbwPLepbwLhpS2VSH/d0vIZAVQCKApRYmnvgtotcwxxW9aD86X1+aPZ7pdAVLIb
 C+6d4/yZJkMdTrsTyXDxCl2HZqx48cw3ZsKU+6vs7DLvMVJTNKZuCydaYehrHtUm6Q+i37fDse
 crorL+sRvdhMHOfK1Zjz4n2B1R0p0meT02Dk0smsn5e/shRV7N2epfo3AUp4X7G4ced3zc1dGr
 gv+RMVWLGHD07Qp8lerdCGXmelxy5C00s8/j02WhhSFXvwB97CqjqpCLlOUdfXb6tH/BKTXNki
 88s=
X-IronPort-AV: E=Sophos;i="5.70,440,1574092800"; 
   d="scan'208";a="237878367"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2020 16:53:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHfNRjP2ZYixZjl+IgAXiL1opC4FxsMUTl5drTnu86jrYlLK+4ecbosHzMjoP2voOzBj3RS8ShXhkiz8lyhWXjFcUdi3+H7fU7T5PQZHoPZQzcgXK+golNRvVVgG7vgYyIVgBtaKtvVc4ytFRqDSho5RXd/uIuPpbXa3r0dwN1Y7YG9XYBCo/k4jFmoFPeR8MczdUeJ0plryUOwhki0U3MiitjsxqTn+TMk3GlZsgedM5nRQVFZjvOfKhpWsONqn4wpTUq7Pu+V/bfvoXm/3T06p2ZYGA5xEQ0JeM8iM3mCUuQ4mhzQ7y9WKyS0GJYxLCYWcthJzFr3FtSGU9kMYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jp4K8yJqKPdWRUk6kXESmx13gjiJzYlCWYzISDNcoZU=;
 b=FPac7Z7G6JC4YNij66IAVFLTg9vcMSs1DRJ7vgy+sxqd2UbfEF1+Y3Og1z+aPX9p7skY06zguI+4Kj8KFSIasESYZs+vTeuyevAHzFRgI4JIQ0/NIjgLmEBKA+8JLITKi2WrrWyrjOm1y3vIV0Uf+HtGXlvdzOePJVCDfI+EqadxSSMD297juL/oL73VLxiC9YNzzkEVe3QHTzqJAJubWfay7v26zXT0KBwc34VCbG/eN5My5fPnsLttcOPD0NI8cDbxQHg06J+Jq2TKZjU2oHLoRKfBdKu4WTSqj5BNFHt5hOJWvl3uiiCcwrNakzfGlCjygQnUYV21UGVW2Y+8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jp4K8yJqKPdWRUk6kXESmx13gjiJzYlCWYzISDNcoZU=;
 b=UnzBv5qVkeVIEwgPpIlV0t1uGI0c2aVMpGjs8+EDt8XKfDAMIh72+S9RMaECkwTMs3/0YEfom+mFxk70Um+xrhVB9e9q0shY8juZ3LemnNAgz3a8Bpa1sucXjZy8ynyOR5h0K9l4V77rNAWImrK5uxxX8SaoPiw61YrKa6BvvkA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3519.namprd04.prod.outlook.com (10.167.133.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Fri, 14 Feb 2020 08:53:40 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Fri, 14 Feb 2020
 08:53:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] btrfs: backref: Introduce the skeleton of
 btrfs_backref_iterator
Thread-Topic: [PATCH v2 1/3] btrfs: backref: Introduce the skeleton of
 btrfs_backref_iterator
Thread-Index: AQHV4w7AawHM4rC3gku58k/EoZpqqQ==
Date:   Fri, 14 Feb 2020 08:53:40 +0000
Message-ID: <SN4PR0401MB3598D637DBFE9DC79FB1A4419B150@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200214081354.56605-1-wqu@suse.com>
 <20200214081354.56605-2-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b70b15bf-69a3-4d65-b2aa-08d7b12b633b
x-ms-traffictypediagnostic: SN4PR0401MB3519:
x-microsoft-antispam-prvs: <SN4PR0401MB351996881087F906F8B997C69B150@SN4PR0401MB3519.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(199004)(189003)(5660300002)(91956017)(76116006)(86362001)(316002)(4744005)(33656002)(52536014)(9686003)(6506007)(64756008)(66946007)(66556008)(55016002)(66476007)(71200400001)(66446008)(53546011)(8676002)(7696005)(81166006)(2906002)(81156014)(186003)(26005)(110136005)(8936002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3519;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MEG+1nhVwW7jLsKdwPEzJxPmp6Y4MtP4ACXaZ0++EPJfRguvH9AbrhGUX49ur0DqR0X8y2aiDe35Z6vY6wweKnsFq1rna7C54XcE87lqHI/gcGOC+exD/3aomeJDQL13bNGZyDkJo75j48Ea4mysNHLsDAUX/PsFurIkiBOTF/1n5Cu+L9XJq5u/DvpOopUEk/dzvzTBu+wxU8AsWqlF76vIUHvdeCLhSYO/UiMHR+3xwv4z0UrrMn5EdoOJ6eudtjZfmlswkvRB5vvLyGARNEkdDbitel9ZB0atKK2BjuloFDSoO+RfDodprK0Nj5L2f7gWtN+P0Q6Zwoul5F/H2otobuig52HDaODjnOOsvSlE2FMy6hphJF+DWhSSMbieQPo+aIdi8VPlTXwUW1zTbrKmTNWt9ACnMbEWQqvWcKDYyFkWeY7o2TLRjCKPXKXa
x-ms-exchange-antispam-messagedata: gwZlcDk6/pJ3YVORnuYe2Rm9xwZLlZCmZgYlcNHhfOv8ONbt2bFlS+Sv7wdnwr74hdXM1On0SOVzrIgiRcfaRskafulCxtzd5voq0w4RnRiyVZrgMAbZTNj3FL8lvKoijNexHxHoBbn+yyMZKvkIHw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70b15bf-69a3-4d65-b2aa-08d7b12b633b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 08:53:40.1572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8q7wOC8ynSBZ+D5vL7/Korm1LUOrJIQYDzuzR3R77JAhL4rbiNelLovxAQ++qwghGqt6l6jP+e78IpRDIOaxDnm9EULjYDBTDdfdxsinEkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3519
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/02/2020 09:14, Qu Wenruo wrote:=0A=
> Due to the complex nature of btrfs extent tree, when we want to iterate=
=0A=
> all backrefs of one extent, it involves quite a lot of works, like=0A=
                                                 Nit: work ^=0A=
=0A=
> search the EXTENT_ITEM/METADATA_ITEM, iteration through inline and keyed=
=0A=
   ^ searching I think but a native English speaker might want to double =
=0A=
check on that.=0A=
=0A=
[...]=0A=
=0A=
> The idea of btrfs_backref_iterator is to avoid such complex and hard to=
=0A=
> read code structure, but something like the following:=0A=
> =0A=
>    iterator =3D btrfs_backref_iterator_alloc();=0A=
>    ret =3D btrfs_backref_iterator_start(iterator, bytenr);=0A=
>    if (ret < 0)=0A=
> 	goto out;=0A=
>    for (; ; ret =3D btrfs_backref_iterator_next(iterator)) {=0A=
> 	/* REAL WORK HERE */=0A=
>    }=0A=
>    out:=0A=
>    btrfs_backref_iterator_free(iterator);=0A=
=0A=
=0A=
I personally like for each style macros to wrap these a lot, but seeing =0A=
the loop is only used once in your patchset I'm not sure it's worth =0A=
adding it.=0A=
