Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705201FF114
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 13:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgFRL5y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 07:57:54 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:55668 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgFRL5w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 07:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592481470; x=1624017470;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=R2dRABAqWtYQMRSwSS6N5wKiCWoREHXjqFOecjSZd14=;
  b=TxStD3pv5cdf3Z1/m9Aqf/EOMLvJ8zmhrdjosmlVejz1llQ98dK8kfEW
   58mDNOhkwmXkyGpZXsK1q/XdEyovw29zMnoqzvHV4OpHb2YZZerLnBu/7
   RH8uOGGi+BiFW749UON+W7t9yigUdtzPdsSiygB2PhCN0mii4IJHBYTbc
   4Y2a3kZrD3H50yNkadf2m2jzpZonb29V4OJ3PVcj1XBnk07i22y6J0CX8
   wPm+SqcxUdUhVbtFjU6VN3areFLfUk2wY0SipqKXK8y4nPemGx7JzkeUo
   StrDx1eRwhHXHsE3UnRmPfy4/VIWTV1YEmEOmvBOuxHVnSA21SrED0RAQ
   A==;
IronPort-SDR: u/R6U4iOKo3b7nuHTBexls6LDZnQf+82Cr+MjWhtEpSaMCyZhedzykCXNTgIdSbDs/vCQPtVyl
 f9VENzOLNHWytvgdwxG62602vMZoKdvR6c8WmOG5VKjMQzQn1HaB5spupfu2SiJgg3vuzSc5dP
 koDTKS0SMl9cXTJsXCxorUy6krYjKxbeuhAQpop4rptEnlHknxgGaqH86MRsB2m08co4b+AGbV
 vuiwvhiYtL6akh5HoaYKlNYG6GAbln2Tur4B2rNE8Zp7kST2BHujUMK372YoAbPVqzaKZ/lGQy
 bcw=
X-IronPort-AV: E=Sophos;i="5.73,526,1583164800"; 
   d="scan'208";a="249494550"
Received: from mail-sn1nam02lp2052.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.52])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 19:57:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpXn3poKJ5cttouDnidCzQZYpCzjWQPtE8e3VZAO09aiYvijqdrHi01Z2v7eEGvqHbszfguhHZmtPgIh3jz27+5RVUDd1sM8EEH5bOpcAXm16RQgFbOclPJHe6pQLwnanFo9yPK1Wcs6WABo1NUVp3m/JCZWHwFB5E798ROliBivJpVpHfyYKf+GejZ7/s8h/HNhNZKHcJdD6fsNdMTXnmDDLEmyBEMCRrU+7UtV7/SlBXGMUJ2G0K1M5NZxb6rsyuFTN5ttMIzUDhQbrteoZCSmjLMOoQMzvPQHGCj7cm1H7F+h3aIaWy4RQs6/Ub28S1KHWrChoDK0tikKT9FxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ky6wx8hDiby7RgIMxbSU+XRpQwkF5GDNziCgNpvZ0NY=;
 b=ThcsvqJJ5YOMrShmXljyYw579GV+8M3Ot1VXryxoxUfLU3C78/h+VcvQdO4I1k60zSW4xA5ax1kucugRXEiddhms71ElnDOwOyKGPW8a2v0uybriRY1Qg7uyeoU0dUc0jfHDhvaZNK4Lvcp02O/G8rKae+g113JptTCeY9hXU/7GeEXL3wYwkoJw6hmuKgUDopP3SjOfZCqxwpo+mo4ruN8kXpwZLAQ1SiQW6txSvAasPq4iI+nD8JlL9OlDZpCzi2TUACRdPxXYXQtE4rv8XTnkymkRNzdzpURKG1qBZQ7XBltMnhvM1lZtFbkuuicLor/FwLX114LYRaebLaWrUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ky6wx8hDiby7RgIMxbSU+XRpQwkF5GDNziCgNpvZ0NY=;
 b=cong4b9XNABqODcrGjv+g6fQAdC3tPJBIDqXQgTQ3RbaATir7XgdafIxNtELBbZGeyAWRZHiZK9vQ8vJsK6DaRQL9IF9OiAFMPLYMbUQqbtzqg9nimavwxMH+fEf3nytstKZ9lzecqqJgWawtTZ2o8iS/WzOkKH/BKlyhUdLJ0M=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4784.namprd04.prod.outlook.com
 (2603:10b6:805:ad::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 11:57:49 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3088.028; Thu, 18 Jun 2020
 11:57:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] btrfs: add comments for check_can_nocow() and
 can_nocow_extent()
Thread-Topic: [PATCH v3 1/3] btrfs: add comments for check_can_nocow() and
 can_nocow_extent()
Thread-Index: AQHWRUUT1geF5HZVm06wlCKuAvaZYw==
Date:   Thu, 18 Jun 2020 11:57:48 +0000
Message-ID: <SN4PR0401MB3598829DD37CA07C8B130F9B9B9B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200618074950.136553-1-wqu@suse.com>
 <20200618074950.136553-2-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0cf8333f-d9cb-40db-ee15-08d8137ed273
x-ms-traffictypediagnostic: SN6PR04MB4784:
x-microsoft-antispam-prvs: <SN6PR04MB4784A71DC67950873460D9BA9B9B0@SN6PR04MB4784.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Dw+s7yr3WSOhNw7gC6c1F5ODj/Q//NPPBKhIm3NqtQAfF8y639soB6etnmglorgNp19RLXp5QrHMAYahjCjtIYAu4/Pgjs5JDGDMu5JZoPjP5IhpcN7H4WAzaW1nePl+fp7Z2GzgB38jI+lcv4OMKTCaWuZkGN8bV6pnm+alTORyqKyl8WIWEDOPbXGukUYt7M6NWePyraSvlddqF+WRr9Y3NI+LsIGlt67i257G5G5cZU250Guog1Yhc+dx9wiHXNJLmirt38rp1sSCKiUUK0Ws6HXiMkp5gF/q4e78c5EriEJYqKESv1hlvRuhh6U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(86362001)(186003)(66946007)(66476007)(66556008)(2906002)(66446008)(76116006)(64756008)(33656002)(52536014)(91956017)(7696005)(6506007)(53546011)(26005)(316002)(5660300002)(71200400001)(478600001)(55016002)(8936002)(8676002)(83380400001)(110136005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: s2jtLCXNHuJWm/nYTaGqooZ1z78hu6zVugHM1Adgpmp2QW/cpcKenFAp/CU9spstkd7RnKXZMUDdRhQW6mjQexvcA4fQENi8kgoVSYARdjP1lJtCum5RDT4L5hZPWhX8fXydocvj/1P9gMB6keUvmXSB8M0T8WBUGvZQXeVGkpRoBctg6c1PPRk50KeisNECdZBZCHxa+yxf59RtAC1Kkee0kDu5PIOgtINVzaELrMjiLvgIi5/JmrUphyRa/xZwsZxsH7Go4amHjQ3/g2Z7TRB1uKJy9oq38qqkGIxdduGeyOIE9myHLmTWQB2G+rXBv+gIJb01y9MuNiujCu2HUO/PzeeIeMEOF0q/JG78eDVAaT+1KBSYkutTKCVRQG50LScg2cZvv+covxL3aNWtl9d07muUJrb1YHoHktPpa8kR4oUCZF4tjVtL1VqDBhODqSrmrf2nUEf6tF3ORG2Fl2VrKNbUIefYvtNI31lN5YGTtoVOM7mwzZ9AVOD9Ftg3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf8333f-d9cb-40db-ee15-08d8137ed273
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 11:57:48.9046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FBd2sRMjLZv+QusxsHxXJbV5s6Uyoo4/oOfcvEoT+rQYN0evp6ARZ6u3Q7c3Mc89Gwkb3deoaY7bfxiPKonvKGJ0WyTHwNPca+0Sz7VYf9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4784
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/06/2020 09:50, Qu Wenruo wrote:=0A=
> These two functions have extra conditions that their callers need to=0A=
> meet, and some not-that-common parameters used for return value.=0A=
> =0A=
> So adding some comments may save reviewers some time.=0A=
=0A=
These comments have a style/formatting similar to kerneldoc, can you make=
=0A=
them real kerneldoc?=0A=
=0A=
> =0A=
> Signed-off-by: Qu Wenruo <wqu@suse.com>=0A=
> ---=0A=
>  fs/btrfs/file.c  | 19 +++++++++++++++++++=0A=
>  fs/btrfs/inode.c | 19 +++++++++++++++++--=0A=
>  2 files changed, 36 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c=0A=
> index fccf5862cd3e..0e4f57fb2737 100644=0A=
> --- a/fs/btrfs/file.c=0A=
> +++ b/fs/btrfs/file.c=0A=
> @@ -1533,6 +1533,25 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode=
 *inode, struct page **pages,=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
> +/*=0A=
> + * Check if we can do nocow write into the range [@pos, @pos + @write_by=
tes)=0A=
> + *=0A=
> + * This function will flush ordered extents in the range to ensure prope=
r=0A=
> + * nocow checks for (nowait =3D=3D false) case.=0A=
> + *=0A=
> + * Return >0 and update @write_bytes if we can do nocow write into the r=
ange.=0A=
> + * Return 0 if we can't do nocow write.=0A=
> + * Return -EAGAIN if we can't get the needed lock, or for (nowait =3D=3D=
 true) case,=0A=
> + * there are ordered extents need to be flushed.=0A=
> + * Return <0 for if other error happened.=0A=
> + *=0A=
> + * NOTE: For wait (nowait=3D=3Dfalse) calls, callers need to release the=
 drew write=0A=
> + * 	 lock of inode->root->snapshot_lock if return value > 0.=0A=
> + *=0A=
> + * @pos:	 File offset of the range=0A=
> + * @write_bytes: The length of the range to check, also contains the noc=
ow=0A=
> + * 		 writable length if we can do nocow write=0A=
> + */=0A=
>  static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t po=
s,=0A=
>  				    size_t *write_bytes, bool nowait)=0A=
>  {=0A=
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c=0A=
> index 86f7aa377da9..48e16eae7278 100644=0A=
> --- a/fs/btrfs/inode.c=0A=
> +++ b/fs/btrfs/inode.c=0A=
> @@ -6922,8 +6922,23 @@ static struct extent_map *btrfs_new_extent_direct(=
struct inode *inode,=0A=
>  }=0A=
>  =0A=
>  /*=0A=
> - * returns 1 when the nocow is safe, < 1 on error, 0 if the=0A=
> - * block must be cow'd=0A=
> + * Check if we can write into [@offset, @offset + @len) of @inode.=0A=
> + *=0A=
> + * Return >0 and update @len if we can do nocow write into [@offset, @of=
fset +=0A=
> + * @len).=0A=
> + * Return 0 if we can't do nocow write.=0A=
> + * Return <0 if error happened.=0A=
> + *=0A=
> + * NOTE: This only checks the file extents, caller is responsible to wai=
t for=0A=
> + *	 any ordered extents.=0A=
> + *=0A=
> + * @offset:	File offset=0A=
> + * @len:	The length to write, will be updated to the nocow writable=0A=
> + * 		range=0A=
> + *=0A=
> + * @orig_start:	(Optional) Return the original file offset of the file e=
xtent=0A=
> + * @orig_len:	(Optional) Return the original on-disk length of the file =
extent=0A=
> + * @ram_bytes:	(Optional) Return the ram_bytes of the file extent=0A=
>   */=0A=
>  noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,=
=0A=
>  			      u64 *orig_start, u64 *orig_block_len,=0A=
> =0A=
=0A=
