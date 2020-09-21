Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E6B271F25
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 11:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgIUJpB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 05:45:01 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34479 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgIUJpA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 05:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600681500; x=1632217500;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ORAEmVPOJ63Cvt0JaTxrArxURPAD6Lt1lW2Lwkybk5Y=;
  b=TUOd8Y3mtaYOPshV4iMFBiQLMUyDpoLUDps4h+mj+XD/OMtWc65p+QnH
   AWN2ZSN1IERsrioyjhs9XBBKwYan7CjAMWJ/R3X9YYZz37zI1C35a8X6H
   cxH7lPSEXYfCeW6BfUTog4RWlR3/YwwQHuijtXG/Fth0EMwtVwAkLzrJA
   ts9YOmXTqZR8GTbJeRiwfzZSFMiEuriuCgd4JxLj0ITxy+w9ELxhCcle3
   4PKo9zXG7zs/dBj87A/hAWQf0VS9X1f5laFxenYSHiz0Ue+DuBFBKzBeR
   H43VfbrxbsdBZ6x4TntPiqCrXcbj+zSa8ZzXesNgkW1CMU/YrfkZAwAF+
   A==;
IronPort-SDR: AH45RnUzKu6KZWTKcQyrN2MmGznQ2Kx784js2dVbuA/P3Mr2D7ht+YLd3k4rzAdWf5emJ5z9eV
 C25S5FVPf/C0sL0je42IZAMsZ/E6491rVEgmx7/tHW+T1Qt9azzya1L6VXy/su/cD07eVmxK/L
 FcoWKld3uAz6GBZ7Wk7QG70ogmAd01/IgNzpT5qIlx0mYVJjWwor+t+abf4dhii2rA8TtrPann
 4thqF2sYmwArQ7aS6yrW8f/mHWgU5qWHQl2lealLb9MYkg/afn+k2kfLUaBiL1h/2zIG93sCh0
 YkI=
X-IronPort-AV: E=Sophos;i="5.77,286,1596470400"; 
   d="scan'208";a="149113835"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2020 17:44:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7p0ryXlBqHPdHqhBgTAAnPiW53iwFGpMbdCXQvUmjxz8Bie5hplaq3NilDpvGwGKL2HnwOqZTD3AqsjH/fs0vvbsk9Pdo7XFns4bQsYvqu5rcDYZxEu6WGS2aHrql7xSQOUDNyvdSPv5G0/jPlpCKXen307U+TTBE9gsC7Ks7bRbDx0S2lvv6gkiFbueR0zAwjqfQMV7Jo7HR/nPg0OjheKeDluoUl/ciaWJGnPT4Oqup05sV8C5TCJYOwKPWV9VnxysSylT3aOlG2JGMFB8K6QBkkztlglrUXFcKKoduUNdO6fasw51DnRHLOT6zAeQLYmlwtBMp4G6nxiAuTI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01nzOUWCaGTDkLp+kOSSun0XeiPo6afdb6jAVvsyt6w=;
 b=W9vvrDMPoH+kSQmybQGcYdOj7/72X7qBlO0sKLC/DxZXucE2F4dHXU4pTtkhsaXxAlaE17EqtH98Sy4mYjkCEKQjs5iW8ABhvZGsOxDWoUgVkKD85oTLto+6NPIVcNRKaUZjclpxe6FGOCJ0vOnmG4J1DWNRISDAEACAmjOJU5N8TkiX9klYy7PAeCgsuO17E+6Kasjosvgyer2kSHG9WPoPDu7Ieb9B0jqH9SmZRnhMlTTrvlSDtQwkym3rh9um3XpRsTiNL4cuIA5TWuLdGPV0kJY0eDWz1xBHVWAJOQKhctzLH2HCXZSyE+o3cyCL8KRx/7l2RDygaZEnreaE5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01nzOUWCaGTDkLp+kOSSun0XeiPo6afdb6jAVvsyt6w=;
 b=FQqmhFDX8l7xwWtmD81EAAD0pHrAdv8YIM4HQubjgzPEmndHcFEqmbFUxtADpyqAWeAeUpTRJwf1ujQowF6p0E4SuK4iOBRBXx1cjQQN6LJDIUkbA4twsXO7KdKlOnRKdkEYxeijBbyOa2DRkoQXLNWeTa/DuOmZ7Y1Ue6jPPF0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4045.namprd04.prod.outlook.com
 (2603:10b6:805:47::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Mon, 21 Sep
 2020 09:44:58 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Mon, 21 Sep 2020
 09:44:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: free device without BTRFS_MAGIC
Thread-Topic: [PATCH] btrfs: free device without BTRFS_MAGIC
Thread-Index: AQHWjjAHxGCzaohAWkGL2VfRK7aP2A==
Date:   Mon, 21 Sep 2020 09:44:57 +0000
Message-ID: <SN4PR0401MB3598EAF1774AFCF7D48BE57A9B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <dbc067b24194241f6d87b8f9799d9b6484984a13.1600473987.git.anand.jain@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d6814e77-3be5-4799-74ae-08d85e13009d
x-ms-traffictypediagnostic: SN6PR04MB4045:
x-microsoft-antispam-prvs: <SN6PR04MB4045ED866BFB6C23FFF308D49B3A0@SN6PR04MB4045.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AtzOf/2AvZIzY9qAc318b2ozbC4ame0HcXc3tAlMKyLLkBlnqtmoXtynu52F5OYIqObAPhRdkUgIA9RGPe9MbbSWu/sbiT8tWAXLy4pv5POfjS2vltmJ9FYa9qgniHFtTk5ziHSJxPWy/9kDqiZevS+2qrckF3jiSQMydzDimARA3jQwEEhtlc+TiTv9lHszwYBwDwm5OKRoi+lT00wVzbbDo3Krqd+MOkYAKM7LQH0Jxc7IX7CBeJRn9k7FwQB68u57myw0v3zmckf3wIzHjGVM/4C2/U1F/BHngEXaR1b3KhaFPd7Xj25Mv1/LFJ8ystF2by7GMV9ZI9zL6RX1iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(33656002)(52536014)(8936002)(6506007)(7696005)(5660300002)(2906002)(53546011)(8676002)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(91956017)(110136005)(71200400001)(9686003)(26005)(316002)(83380400001)(55016002)(86362001)(186003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: IPEl2kMHg5DhHQL1+P7L3NQ61436+Fwh4TtVf6swnG/JhixlBOuPXp688dl//9QChQDk1IuoUYQBnDufW1ZH2ijXtBOIcR/xMLsnxZqwvLA4lhw4MQa6GtNU2ZhIQ7M34eZ1cMkpFvfRLUqE8hlTzdCJiOazF1nwQqgnfD4ShcxakxXZV8xvLmcuUenWkZmXPLo4hQRPUhYo914mTLB+9QrUtGP9njZZR0yeSkv/gECv/XvfWZM1jYrWtqPNd/rbZ9SE+XHKyC9DI5DF0Gy+UefTbW9OqZ3RXmBsIq3TXR1swjuX5n6CTIbAkA2vkkE+hQDbRw0gv4MmvqHXxjsAdbTeWi5FoMfgSg9kkfux6FBMgWz3Ss/jrVhQhx9iEb7GBMme0FSXULb8qQOU4mWMxj17TEjOXOSIrBqWQmYsljGAt9VGQZsRrK+vqV61kEkgt/G4kNCAPXpTloIUsESmMaypn2ku6mBv9NWOr0bPTkr/WBE1t2LHgaeCX7bF0lxg350kDm50rsAl++/iXEV7g5TtQFQonqneXjoDfGgwYy+g6a8shhN/L5lDxrg6XXsf4aYw2hxl11A4xTbkOnfvYq+atf2rqK5orMxHVItLBS0SyyCMhmITuobs++AOs3wI+nVkS1Avih+XaR3yny1GbA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6814e77-3be5-4799-74ae-08d85e13009d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 09:44:57.9324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zCR9imyQ6sDIegen47KKRIuTkeilsjaj7Y6o/MxAWNuVtPl/iQVay0GQfW2MHt4w6dFfrKz84yjh/9S4NiIdMRQuTVRVYuh4DJdCZdxyqq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4045
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/09/2020 04:53, Anand Jain wrote:=0A=
> Many things can happen after the device is scanned and before the device=
=0A=
> is mounted.=0A=
> =0A=
> One such thing is losing the BTRFS_MAGIC on the device.=0A=
> =0A=
> If it happens we still won't free that device from the memory and causes=
=0A=
> the userland to confuse.=0A=
> =0A=
> For example: As the BTRFS_IOC_DEV_INFO still carries the device path whic=
h=0A=
> does not have the BTRFS_MAGIC, the btrfs fi show still shows device=0A=
> which does not belong. As shown below.=0A=
> =0A=
> mkfs.btrfs -fq -draid1 -mraid1 /dev/sda /dev/sdb=0A=
> =0A=
> wipefs -a /dev/sdb=0A=
> mount -o degraded /dev/sda /btrfs=0A=
> btrfs fi show -m=0A=
> =0A=
> /dev/sdb does not contain BTRFS_MAGIC and we still show it as part of=0A=
> btrfs.=0A=
> Label: none  uuid: 470ec6fb-646b-4464-b3cb-df1b26c527bd=0A=
>         Total devices 2 FS bytes used 128.00KiB=0A=
>         devid    1 size 3.00GiB used 571.19MiB path /dev/sda=0A=
>         devid    2 size 3.00GiB used 571.19MiB path /dev/sdb=0A=
> =0A=
> Fix is to return -ENODATA error code in btrfs_read_dev_one_super()=0A=
> when BTRFS_MAGIC check fails, so that its parent open_fs_devices()=0A=
> shall free the device in the mount-thread.=0A=
> =0A=
> Signed-off-by: Anand Jain <anand.jain@oracle.com>=0A=
> ---=0A=
> Now the fstests btrfs/198 pass with this fix.=0A=
> =0A=
>  fs/btrfs/disk-io.c |  2 +-=0A=
>  fs/btrfs/volumes.c | 19 +++++++++++++------=0A=
>  2 files changed, 14 insertions(+), 7 deletions(-)=0A=
> =0A=
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c=0A=
> index 160b485d2cc0..9c91d12530a6 100644=0A=
> --- a/fs/btrfs/disk-io.c=0A=
> +++ b/fs/btrfs/disk-io.c=0A=
> @@ -3432,7 +3432,7 @@ struct btrfs_super_block *btrfs_read_dev_one_super(=
struct block_device *bdev,=0A=
>  	if (btrfs_super_bytenr(super) !=3D bytenr ||=0A=
>  		    btrfs_super_magic(super) !=3D BTRFS_MAGIC) {=0A=
>  		btrfs_release_disk_super(super);=0A=
> -		return ERR_PTR(-EINVAL);=0A=
> +		return ERR_PTR(-ENODATA);=0A=
=0A=
Is ENODATA the return value we've settled in the discussion? Sorry I =0A=
haven't followed it closely.=0A=
=0A=
>  	}=0A=
>  =0A=
>  	return super;=0A=
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c=0A=
> index 7cc677a7e544..ec9dac40b4f1 100644=0A=
> --- a/fs/btrfs/volumes.c=0A=
> +++ b/fs/btrfs/volumes.c=0A=
> @@ -1198,17 +1198,24 @@ static int open_fs_devices(struct btrfs_fs_device=
s *fs_devices,=0A=
>  {=0A=
>  	struct btrfs_device *device;=0A=
>  	struct btrfs_device *latest_dev =3D NULL;=0A=
> +	struct btrfs_device *tmp_device;=0A=
>  =0A=
>  	flags |=3D FMODE_EXCL;=0A=
>  =0A=
> -	list_for_each_entry(device, &fs_devices->devices, dev_list) {=0A=
> -		/* Just open everything we can; ignore failures here */=0A=
> -		if (btrfs_open_one_device(fs_devices, device, flags, holder))=0A=
> -			continue;=0A=
> +	list_for_each_entry_safe(device, tmp_device, &fs_devices->devices,=0A=
> +				 dev_list) {=0A=
> +		int ret;=0A=
>  =0A=
> -		if (!latest_dev ||=0A=
> -		    device->generation > latest_dev->generation)=0A=
> +		/* Just open everything we can; ignore failures here */=0A=
> +		ret =3D btrfs_open_one_device(fs_devices, device, flags, holder);=0A=
> +		if (ret =3D=3D 0 && (!latest_dev ||=0A=
> +		    device->generation > latest_dev->generation)) {=0A=
>  			latest_dev =3D device;=0A=
> +		} else if (ret =3D=3D -ENODATA) {=0A=
> +			fs_devices->num_devices--;=0A=
> +			list_del(&device->dev_list);=0A=
> +			btrfs_free_device(device);=0A=
> +		}=0A=
>  	}=0A=
>  	if (fs_devices->open_devices =3D=3D 0)=0A=
>  		return -EINVAL;=0A=
> =0A=
=0A=
=0A=
The code itself looks good I think, at least I haven't spotted anything=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
