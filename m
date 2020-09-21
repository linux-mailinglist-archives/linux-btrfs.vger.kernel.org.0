Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FC627292D
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 16:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgIUOye (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 10:54:34 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5623 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgIUOye (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 10:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600700074; x=1632236074;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Rkch6rk3L/xamb9ezDYRTYmga7M8wV/YyAG26sMPBsc=;
  b=H6aKlswU/UYjByuEdWgtgWwEo4FNRWz1DSO1R/DGS1h0QtsPZ2BIt5II
   EonQlyafCBe1h9RTLcv2fq+rVGxo8SAhL1+0g++Db3ADZvW6bUKzD/+JB
   OOIT09fwpHDDx3b77iMaPrNL1+wdbAlQrVJYdvqk9LzPcA8Ana71shXrA
   uswuegHasrcr2R7g97hemmEdJsV6be+Q8I2DMd4aw9M1okkxSyqWPEEJX
   4jND8ME5QnmPWUTKiKeQ9/zv3gObB4dBqyivZn/nQxqwmmDyCDGQ59QPK
   xJ7Biot3aSIE7RxKolhUjeT1i5p3S6+TfA1T3hpNQo3tkDfa7CZXMTr68
   g==;
IronPort-SDR: 8wu5BEALAa9Nmhz8Y2F7tOpALBc9Sn2reAT5nctzMKEAzJY0DaYxgXYlAts+XQAge4gzmjUiWr
 vAhoI+sA803JJGb++Qx8ul+U7e2mlm+8tnSfVbxGnmTluXCqD22mSQAu5+7JbCS3w6O5fXyTKq
 Iy036Dk8FL9HqMkqvnrrLsBKRu8WfBxZxrcQgDHcUepYIOJMossX5jPXgDB7ZJBhimOAqzITho
 t7hwpdFaffJNbghsmGCzw/mu7a9UnUMmmNyZJ/hdoYBaC0muFaXgPZw5zp2IWMVQBTffXFVRc1
 nLk=
X-IronPort-AV: E=Sophos;i="5.77,286,1596470400"; 
   d="scan'208";a="152267584"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2020 22:54:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jl0i35gK07+1D56ekk6kkR6yE8FUnz/Gl0FdISYSGoRszgh2dovVGLCG5AAGD6xaa99PRDVnnXUPGG1IpoxkNX5HlhJShlFDCeUaQuJAci78wxDpV7xUnsx1LGl+RnXrV1ADXcbvHP5ldbHYVcb1EII07LfkC0lGe5q+1wQjIhxAaxX5Ebzib+dWsk7HQ44SIYWkqkshkYGxKJ6mpC5eaVv2Rp6BS10uOwwED1db2DCClN+Sw4mogbPwdgVJN7ZW9zn1N8KiMmhUCLzJHTTccPe2h4dTHHR6ETW9/eTq8/PAO94eoV4FwvaNliAY8p8j5by7zX6X5hZaKugKRx9BPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWp5Mdf0Un04M87BAMmYKVNoujhhlwl2kR/8I0mUPhk=;
 b=JbjEdmfzsNjQ5NX7dROhZXE3dIuG2KOYY+1+iCKW32AWGVAUiChyEF4sGFbkc+7czOU5y71tZCp2KmmTQuRWS3z73MiNZUETbcTWuSXR5+CK5/8HoNtrUS/07Z+Ga9VYcl4IDZKTPaM6bXe+1sLIprlrp6nPvkCrKS443lEdQaJdrumEeJABYe0dyimAbE4Bh9K/nBBe31uJDB/DLqX9+q1RL0NksLCGfUjWPsLwsSIfj4ixwPEuRraDNC1DDPK7DXEWFiUQpidav2NtVXoQE1iOIPznzhAFCnaROzSH6R4HzjiQVow/HqCVNc8ZKGccZ7NRPoXN+EKVoi7SfGkFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWp5Mdf0Un04M87BAMmYKVNoujhhlwl2kR/8I0mUPhk=;
 b=hhe4YnwSPejaPdTkzav4xxik458ho+SOTwVO4+wBONmn0SvSwNmgu/DocwEJbm8Del8KDXuWyM22wT06NHemJz4HfSAhSh5dG984m1BmEm7hR1fTyFL2EXG70+x5QMbWLow3Mbc1qNddcdGkpFzQ4b6nB7+m70zlxHGXMQGJGuM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3886.namprd04.prod.outlook.com
 (2603:10b6:805:44::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.21; Mon, 21 Sep
 2020 14:54:31 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.033; Mon, 21 Sep 2020
 14:54:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/7] btrfs: Don't call readpage_end_io_hook for the btree
 inode
Thread-Topic: [PATCH 1/7] btrfs: Don't call readpage_end_io_hook for the btree
 inode
Thread-Index: AQHWjcB9STJkRPkEvUuXIliKGpwjNA==
Date:   Mon, 21 Sep 2020 14:54:31 +0000
Message-ID: <SN4PR0401MB35980BB42D5961A6F4AF68789B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200918133439.23187-1-nborisov@suse.com>
 <20200918133439.23187-2-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9765c547-e11f-44b5-5243-08d85e3e3f3e
x-ms-traffictypediagnostic: SN6PR04MB3886:
x-microsoft-antispam-prvs: <SN6PR04MB38866F53817DA6525980DBE09B3A0@SN6PR04MB3886.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:161;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bGmsZ66WCv8smeIpOygVbsLypmzdGjuBHUlBETe7ZclchubN10ok+6pxs7VFlw8wh0HgTt1QYN2kdtzd5ZgdmuO68IDm9xEsThH12liYWkGcgFqQ+b8TtRIAilt70GKJpgLSwq3Zz/53305rRbogw5FxPzTfqVgCW7ZcSKiWr7qMIPtLzcWIRq3SIaod1+gkcSWwOgbf0x9iFkmj7X/ye69ZTp+1L412tkE/9hKw/D54Oqtc+AZW7wAC5wBb4Bd6LcmF09o89mb1lLtNlKz7lNPjNbVZdbxfFyzqXICTh/ybV0sV9jMtUuu5NAcUYQDv3WrDgoPdlNFKHM0iA7gu29+FEEagJmrj+wbeaRZb4yCbwp4Ft7TdziRmUlyXXNom
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(4744005)(26005)(186003)(53546011)(71200400001)(5660300002)(6506007)(86362001)(66446008)(64756008)(66556008)(66476007)(33656002)(7696005)(76116006)(91956017)(55016002)(52536014)(9686003)(8676002)(478600001)(316002)(66946007)(8936002)(2906002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: p5GNQkLHO77F/gaygdZlEfMUkMswfLixfFbXzi4Ex/AwmEaBgzUrwDk9CKTfFNEUYYw79CqbaNqh8abzst1i4OQHcS6REQxistRixHdaDmOsoJOuE7WQq1iikXEAulJXy5gs75bC6B7Qk+ticqrkr0hyxRj6tew/Wvmo8WdrtZXAH8BRcNRhEbR5HpqnnhCMxQB+9ncheE8I0EJPa39t4R082pOFG6HprJ/suE7LhUx8BmjHFGcN7VO390UxqrVStIaTO0MWIwvve8BLZHLgYYSQpC13LE2dhWnF20s40NxdbbgJkZRIDxQk0O7sywbo21HkWqmTQ5JM/610+jmBG0AaJWrhMRVY2rL6ByjxRtkhBjlS7KPBxt6YqPjmZ2HU8mLY3xF9A/Cn6U22rF+dB+05e9lBERVCVHYW6JNf1roRkUI5Ejln/Yj3fpdA1p7XQ57FjzQhiUiH72bMVWLQ2HMxIlD0F4bgOfg1tO/ODSz/msqv9xdnMhY8Do4GWKkT39kkgvwegjJ42cS8fJWIYl5zHCU1y+pSW3HxkYvzaD8DQSJKLxd6IpYPRCUhYNGvuX0ygQpfSYZxzQJpFCZScwuza3wzr+AY5BXYxbZhkK5XxTUHEbvLDU4ztC7e0DHmWdOU5OEzw9ftMuRpjmnfjg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9765c547-e11f-44b5-5243-08d85e3e3f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 14:54:31.4297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NcPTdkISwmgDEoFpq0njOnglRNtaoqPjI1X71GYM4tGJH7ch5vQd2GslYi2aijEjyACGbgrPsRNi++4OifkItJu0Jw6pcW2F6SY7Bpy7Y0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3886
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/09/2020 15:34, Nikolay Borisov wrote:=0A=
>  static const struct extent_io_ops btree_extent_io_ops =3D {=0A=
>  	/* mandatory callbacks */=0A=
>  	.submit_bio_hook =3D btree_submit_bio_hook,=0A=
> -	.readpage_end_io_hook =3D btree_readpage_end_io_hook,=0A=
> +	.readpage_end_io_hook =3D NULL=0A=
=0A=
[...]=0A=
=0A=
> @@ -10249,7 +10248,7 @@ static const struct file_operations btrfs_dir_fil=
e_operations =3D {=0A=
>  static const struct extent_io_ops btrfs_extent_io_ops =3D {=0A=
>  	/* mandatory callbacks */=0A=
>  	.submit_bio_hook =3D btrfs_submit_bio_hook,=0A=
> -	.readpage_end_io_hook =3D btrfs_readpage_end_io_hook,=0A=
> +	.readpage_end_io_hook =3D NULL=0A=
=0A=
After your patch both implementations of =0A=
extent_io_ops->readpage_end_io_hook() are gone, why don't you kill the=0A=
definition from struct extent_io_ops as well?=0A=
