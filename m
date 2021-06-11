Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8909B3A3D71
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 09:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhFKHow (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 03:44:52 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49862 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhFKHow (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 03:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623397373; x=1654933373;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=W6Nhh3ix+FBy+IjORZtf9O4w7nGJfu3vP4VjadqcdTA=;
  b=THhvkZqw+3Hd0cEIY97YeR3iBErYOgRYAYdhF/rAhjnmJ3sORgYyVr3r
   i3Ba0/15uBqfW2up+ZbZOxUmhMBjWRYF7hI5ZcWXFsHBzNcn1k+4CmLMh
   kRdm2GeqI8rBMsT3EIX0uB80koHPoepBdPN0IE7cbLL0hOM/jxTHwRjUd
   T85YjUeNOJCKesMFgK/fjLVYRhVqFm58m0AFl2OvqQ43E23YkyTIcM9be
   c1HY/0R/TSHSTsHQLrP/dVKefx3uwmyblpqo9GOSacKma+O9TWUWsmHJz
   42cjeIFcKQteWFHySuqDbK48P3QDXegzF3vzIApcyMfIMoR0F4q7pYP24
   w==;
IronPort-SDR: I0WRKVqgsUE554M7ApKdr+1w+bV9KmM9aB7Qt8aJgCT9GJGiv9S6h7z2JEYfqWuADGjD9B6keX
 gfJ1j9fhvc4asHsn7lmF+NyxSpQ6QreAq2B9tYKCTFJqrzzFz4EIyW4eimhdIlG9mgqW6jBlc8
 xqvxQ/gWNRI2Tda8VBnWEvz82uND6jTmNMWkex7Ov0OranlrsMfe+IReutcm6uTl5EdqPoEDGO
 1gH3HYIaORwPJMJMxE2zHFaL99pTRtv7ExIjpWMmn8mt5jPeMjqLzmwxT9JpbCYFEXN3DBHLT0
 o80=
X-IronPort-AV: E=Sophos;i="5.83,265,1616428800"; 
   d="scan'208";a="176332277"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2021 15:42:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lf3661P47VOjgk9ZZePA+efynVSiiBBJZskevv5gPpCOFnyKJUlrg+sHe96IL2fk0H8x7EL1p2V0WOWZjcqP59pq/86+wlNNlpBQ66JbWg92QHMNnO8Xdxzrt/nX0E6ZK0eOtM0hS8+p+x37e/QrAy8UJe3g/q718DjK6O18/tUmZs4zwU0h+vUdly3xnWUJ4Ei53r2bz8xONWNzdnW6wVffN5zQmzKYcItdxelbjiqdMhCh59NTHP2SacO8qNBK3cVv8NNE5vvqgiFM0MQKzpVPTeUd4H+fBm5bxIxbZqIzM9rckdg6zufcEHODiJgvNuUkhcR+uiUb9UCVQCgdUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJT+8Wjohu4j0g1AIWXpUjOzKXOGYSOj+CycPmokxqE=;
 b=RuMTHZ5EUbY9Hm5t7YVqMR/szGCsi/aNbVwHWMWpi8yViy1MILXpcns/oulPf23jPrVubxmW2M2UtgtH9PCWZhu+xWhf2zpaYIOPYEw/WsblZ1HO1MbM3T7Ne1MwStxP+OY7NSCw4h/N5WzEQKspSU36uDDdtwv50ZIMP6Vz+mA4RGdPO9iDuJ30YGF3iU9sIdmywMMFdeSxphGLyyeIYwvLJOZ+lh7LUFt+2k/TSUJOgsihU696LDwd/bhF5IbAOJqAfPi8fV8RVz+BypvMmUkKFtfYfDWN8/w7L1B0nwGWLhfzltTBIc18vvAJkivBBt3aq2u1c5MHRYWum2qBOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJT+8Wjohu4j0g1AIWXpUjOzKXOGYSOj+CycPmokxqE=;
 b=LeACjql2n8SIs111ry/VEM9qu8f/07qRWK4DQXcH7LcUSE0PRXwN3qYHtz2IouTrmnbFonbAdKxS/yk3zdv4ZVnw4bIBBkg0t3ohdBhfEgEG+yJL7lQ5MqOfrcAxKbfNgz+BD1h/i7zy53K1PAkS++UHJNU8I6mB2mxcH9TN7VQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7334.namprd04.prod.outlook.com (2603:10b6:510:b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Fri, 11 Jun
 2021 07:42:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4219.023; Fri, 11 Jun 2021
 07:42:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 7/9] btrfs: make btrfs_submit_compressed_read() to
 determine stripe boundary at bio allocation time
Thread-Topic: [PATCH 7/9] btrfs: make btrfs_submit_compressed_read() to
 determine stripe boundary at bio allocation time
Thread-Index: AQHXXmGjYvufKdMyQ0a3deHiNu7p7g==
Date:   Fri, 11 Jun 2021 07:42:50 +0000
Message-ID: <PH0PR04MB7416B38BCA52ADBB748E31109B349@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210611013114.57264-1-wqu@suse.com>
 <20210611013114.57264-8-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:141b:f301:e91f:9de6:cb32:f149]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4295b40-ecde-4885-55e7-08d92cac83dc
x-ms-traffictypediagnostic: PH0PR04MB7334:
x-microsoft-antispam-prvs: <PH0PR04MB733400C25FB8956B4E09763A9B349@PH0PR04MB7334.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gDu7UGTE90IM0FBHEpFh0YBCxk57r0820LAWKvVzPaG2g8GpiGgEms6N3IHQ44/sTDATyQHl5NjBFADrUaXNMBrUo9/3dZC/9afLxQIQaST7Tm6um8qL/VgcdFFumQyaThRBeoFbKj2Aj4eUXcPLo+LQIUoeaHVPlDg/AvJk/u1t+WpokvLPK3F1mocm5DjA0qyjbub+XuQ3rrIy50Xl7VO5bTUQwR6wAZE4Td78O2hWk5+9UNqKbsGkf3bjOEC0NQPFPSKP5bHw5FQm3wVAAa+faDXYa/44XGa6ue3zg96g/O/ktHdz1CuBhPFbLQg3FXsxn7nc7s1lYzR/ldRBrg2flyTuETTISEJXOQO989dHPJd4Yfrl/mlHCmch+Tg+zWYrVz43Zv9KIKK+Gm5/6owlIrKq7moSBQtKFV09+R9B3vh/KqlVIBofSikNtpxITWiuVSDqIAc29fx0Ew4niUPp1EPlA+Itb0egl+hRqW/vDQO/KOPFOU62WuAH3mBmJxUvNFQOrDDSOcCfI2jL/f3Poccc3otyMD7gMXV25iZ0c+1A+PufFBuKOOzI/ayuib6kqJMJ68ZpXK2qFOmvanrXEKAyX1TG4aaJnUHZ5DQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(122000001)(66946007)(8676002)(91956017)(110136005)(6506007)(186003)(2906002)(76116006)(316002)(55016002)(53546011)(9686003)(8936002)(38100700002)(5660300002)(52536014)(66446008)(66556008)(83380400001)(64756008)(478600001)(66476007)(33656002)(7696005)(86362001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+Acx1YLFf6F2D+plTjwYafwp5APqEQjOA4JueS6J+DgOvV5+yfzP4E4u2yOl?=
 =?us-ascii?Q?OK8xWI3B4KJBVKqDY04dowpUUcr5RS3tGIQbxUoClfaBW3BWsYgQGQctMQVo?=
 =?us-ascii?Q?3JavOh2W6JYavOzv9VHTvkIVAu4CiFe/VXRLwvx7JE7+kxWneH0qWSAmkIe4?=
 =?us-ascii?Q?Kg4W2rXTxP9u18Rc36kj3HZfFS1zf03jmgMtvpOtSRuu3KmnALNWQ4w0SgvB?=
 =?us-ascii?Q?EfhPWRgl3EwOnpcDu1QCfHPspeckdgXygNqd0oNr0InrpOAh7VmkE3BQuVKn?=
 =?us-ascii?Q?uJxAqa34AmpfPN+NcZcwT8bm9PFnOdC74cm79CFxeQko+V6GXZlQ/2h/tIDv?=
 =?us-ascii?Q?bdbuDxCclcD62CdJo7Nw9tfPitx+fMJz8fEIfCizBk+fbTGC6urSDZEo9aTU?=
 =?us-ascii?Q?TPVBbNvU373SHIfOTUiovVRE1USZTuegCySw3j4ypOtIHtURk7NK8uMQvZlD?=
 =?us-ascii?Q?10eN3SKEae+ECSBACKIlJDV2Kg5SCXJudgBSN1aRL1y2tievNxSkUPvBQA1O?=
 =?us-ascii?Q?+Qn8eLATcMeCBd9+3zHxXGmrtiRGvERReFleBgKYdWawVvCDT93tRuMrOvzF?=
 =?us-ascii?Q?gJfkQFZhqdhA7DgEC5gZYJqBdvnsl3aobXT/R5F3vXXpksb/AL8g5hZub3BF?=
 =?us-ascii?Q?320XhD+400Cpcmq1kx4Zj5PSeRTcojRWeu8v7H+FIJdwjTiC4+5tW/kjTCgZ?=
 =?us-ascii?Q?UV4KY9OPvgyxntabWcHHjcdMIusnLZAH4IRJZuFIPxRoqbg3F6vHA7jrwJB4?=
 =?us-ascii?Q?vx9dGUTl4/m/fYJLHenGtu9KkqwnPWbLbS/Mu9XDtXxUK8XvBWE1DrgO5YLn?=
 =?us-ascii?Q?Y/i9lDmkujgHPUWXFx65FZ3n+U1ZamXP7vzts0NhmHuUOCCHnCfnZ7/cEsrq?=
 =?us-ascii?Q?6w6jm7cpBxCgbzBS4STCRJ+i/70H3ztg5V6NlO06qF48c6IQMpoWW6Ern8K1?=
 =?us-ascii?Q?vWORF3OR+a/vtwGVqVH9EbUyuKiyLc2Uk4fkqT8gPF+H9hB4NOum7N75z5u+?=
 =?us-ascii?Q?PgOGIIRKZhj0c+llnD3kGS8u0TAjdlgE2zLk81kz1qBHRLWYCBiqxCOSvWLW?=
 =?us-ascii?Q?U812CSygJAFYhbC4rBnItk+e2DRXZUwESOoYVeMn6BL+IrmdwMqBbAt33Iv5?=
 =?us-ascii?Q?BGDIIkfOOuVbm8pXWo4ZwZkeSeLgVH1zsrgQKvQLRMN1hA5BJLwLwEZmElmR?=
 =?us-ascii?Q?VpCzpF8vQ1U7owyrsUqvjuKdY63RWVqQL5aGAL7mbz6mMfbmBaG7lFAQUlLg?=
 =?us-ascii?Q?/IeU+YXCphvXow37HwsFOe4U57yLCRAfum9qO31ZNz/ohPKRpGnQDtFTuJ6z?=
 =?us-ascii?Q?EapVOMUyp64MjdOXkYWA/2U5dMChkUcENUDxcdbyGO5VPQYuHwzurGrgQzss?=
 =?us-ascii?Q?pCntTvXd+5FUzCfmolvnbIJOUlUl1l6zVWw0A/J1BspHD2eX1Q=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4295b40-ecde-4885-55e7-08d92cac83dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 07:42:50.5837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +V8Wu3uqVK1OeD6nj9gxatOdzFSgTzWATeVC5DOWJ88/QE5owm+F0AbQM9dZXzLv60zKz/JpuNsXvnLCmdoUM+6vBqBXAqtb03pJFxicVe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7334
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/06/2021 03:32, Qu Wenruo wrote:=0A=
> @@ -443,7 +449,6 @@ static struct bio *alloc_compressed_bio(struct compre=
ssed_bio *cb, u64 disk_byte=0A=
>  	bio->bi_end_io =3D endio_func;=0A=
>  =0A=
>  	if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {=0A=
> -		struct btrfs_fs_info *fs_info =3D btrfs_sb(cb->inode->i_sb);=0A=
>  		struct btrfs_device *device;=0A=
>  =0A=
>  		device =3D btrfs_zoned_get_device(fs_info, disk_bytenr,=0A=
> @@ -454,6 +459,15 @@ static struct bio *alloc_compressed_bio(struct compr=
essed_bio *cb, u64 disk_byte=0A=
>  		}=0A=
>  		bio_set_dev(bio, device->bdev);=0A=
>  	}=0A=
> +	em =3D btrfs_get_chunk_map(fs_info, disk_bytenr, fs_info->sectorsize);=
=0A=
> +	if (IS_ERR(em))=0A=
> +		return ERR_CAST(em);=0A=
> +	ret =3D btrfs_get_io_geometry(fs_info, em, btrfs_op(bio), disk_bytenr,=
=0A=
> +				    &geom);=0A=
> +	free_extent_map(em);=0A=
> +	if (ret < 0)=0A=
> +		return ERR_PTR(ret);=0A=
> +	*next_stripe_start =3D disk_bytenr + geom.len;=0A=
>  	return bio;=0A=
>  }=0A=
>  =0A=
=0A=
=0A=
If you're doing a chunk map lookup on allocation you can kill above btrfs_z=
oned_get_device()=0A=
call and grab the block device for bio_set_dev() directly from the 1st stri=
pe. Otherwise we're=0A=
doing two chunk map lookups for zoned btrfs after another, which is ineffic=
ient.=0A=
=0A=
