Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F8D262D55
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 12:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIIKhm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 06:37:42 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10434 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgIIKhj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Sep 2020 06:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599647859; x=1631183859;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=p3cbeZGunABECWWQLOq/g5mKqhDT+TgHcAu0CY1obrE=;
  b=YdBXAV190dqe4HQDVeXSXWiRVaEXWkLzsFV31/MInWmN3ym7ABKJLKCk
   R4K2bxHsvmsKT5lkEI/w256WpwftICBUnmKBHsT+8EQADzwxWCOoCTCmP
   0vzaT8/EoYY2ha9hHqmV6YD0drnQKunh+huOr59fVGlqBs7shl1itafIo
   O34Lxgu2J9eiWHeCybBb/XfWxdYjKGZ8g2DsN2kLwp821jujFvj3qoGn/
   hwJX4Q+07oLK6K509ZaUJ5TxmlGLoIt5njl/irmY5GvP3zEm4QQcHBZ+G
   9oTTsiGRQLsNGfgKnGsypH4YfxZIVzNpDv8jQRyNQ5/yy0SW/nsO9urhc
   g==;
IronPort-SDR: Hp0KtavAllmDSDaQ6lGRpOPrzxHdEmO/eIoI9FuE8ZxeXVY2uMqLWwN2qpb1pjkOyKdUKqxwH0
 9qus8PoRCCj3OOItfpZ8EM4Yf/EDFh4rnICrZxn0DaTOa1cdZp5PJL6XxVi991CtkBGqIdAk5/
 QKapcycLovWXuH8pzDqmlBcsFdIvg1Ol7JTcCGmd7BNCHMDSDTGPBl5PQjQw2OLIiKT9J6xZp0
 c+07085JzMRP4nJSWont4aTXgSOVXnRkeQjGiwvUPb53UC6PyvkJ7wll/fLJh9+UJlkrINhioV
 6SA=
X-IronPort-AV: E=Sophos;i="5.76,409,1592841600"; 
   d="scan'208";a="151272376"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2020 18:37:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUw0Ik/vhVO5vBSm/pNjhL3lT65DAMEjln1EarY25zN8y3aSRppfjxKdTEaoKk7zBOh4wnmL2caw4g5U5jmDxTgT6Wi9cKgOM1zC3v62cMyZTGukjPUFv7m1rAyL79+k+25QQ1yhSpWaH9wE3edZsHMq/QrUGmpUZTMIevcCi9OIjVHSFNzXlWxN+ETloByzBFJ6440/cwZrJ5gAAYF2YcV2vNmjf7FsV9rnVSjQJFyz4QbcFx0HbJf21J19uakvLMqKheOiejfEkyMxPSlHQ4n6IyAWgni5IG2a8RbgAwHncivTMcI9UqKviXSdluRuxan7cC8HgskCPuOs2TAQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WO89E11CB7x1zfkgAPqWM2cYdCtleKFa4bCw/zoC6zE=;
 b=afhEvkOAD15jUOj8BAAnrn0fyEqVhFETGU/yUpkeRus1gpGEHoUXPUPmGMBk1Xoh4+kMrYpOFWxHCinbjxo6ebnPxuyiqBSxGKrcME3dt+FEonZRw8t9ZSL7Zp+jHncvBsiHwculmt+9iK4s8KxucRzAQy6wKCfmL0fj4rwQ0nWCsvGkpPXKcq6fy/fV0Ylf0pZCgDNEXxHd6APGqfmNXk8NDF5HTnU5JbT/VcPEDDzMIKoKRhCC7P+DHn6TD+DGY4GcK9MmQwYJKlxmTapQKnZM+QYrxISiIn/8OnH6y48iZtV91RPogsA2O8e5jXwCzG3dWDFQkBSm/+XX+Gyj3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WO89E11CB7x1zfkgAPqWM2cYdCtleKFa4bCw/zoC6zE=;
 b=q0O7WzS8+cLWj7vXV4sAat6ugjF6WgTJk2qL54FBvB4/PBvzyhkPqZ4N8OX3C23+248GuDxV7sr52rOnQ6v24dkDk9F06rwmX9SzIO7vjuWr7mj4XZ3OoZM2ztu/sE3734VPARzH3My/tOJJderY+IYQbmKMv//CjyqFZr1x3mI=
Received: from MWHPR0401MB3595.namprd04.prod.outlook.com
 (2603:10b6:301:79::25) by CO2PR04MB2343.namprd04.prod.outlook.com
 (2603:10b6:102:12::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Wed, 9 Sep
 2020 10:37:36 +0000
Received: from MWHPR0401MB3595.namprd04.prod.outlook.com
 ([fe80::158c:8261:8a08:30d0]) by MWHPR0401MB3595.namprd04.prod.outlook.com
 ([fe80::158c:8261:8a08:30d0%6]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 10:37:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/10] btrfs: Remove btree_readpage
Thread-Topic: [PATCH 01/10] btrfs: Remove btree_readpage
Thread-Index: AQHWho6LOjjR0UFQx0WXvGoGooxEFA==
Date:   Wed, 9 Sep 2020 10:37:36 +0000
Message-ID: <MWHPR0401MB3595EF09FB771F648F534FD09B260@MWHPR0401MB3595.namprd04.prod.outlook.com>
References: <20200909094914.29721-1-nborisov@suse.com>
 <20200909094914.29721-2-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2866a7aa-a101-4453-cb46-08d854ac5dfc
x-ms-traffictypediagnostic: CO2PR04MB2343:
x-microsoft-antispam-prvs: <CO2PR04MB2343CD9B72896FA55350EB6A9B260@CO2PR04MB2343.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:31;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pMJb493f1tx+3cgjIF7UYYQijnHWruOolyF9T0WJ1bfx/N7xp8Yb2b3whux9/XZGB5/Ew6AQB6K7unenLsuRbkOWsxQCsYIMBmYbKk4UAWktWnCpB7nZNd+PFA5FMOhgBGnzfndV9kwOLPyBN5/aDo5bhIJIgipBqGuIRMo+CM1IHSj3o+5iUsZ+ULiMDRwvS0tWgPEGp6uM5YDMdB0kvUUE0O82anbSLGFXBGTfdwfrNQfKfDQjipC5P/+4eJodZVnT/nOQ0YaZOWUu89xzo1WTLFwfZZkhFpKZA0lTYHgikdT7kePpYpW0PLGeiYM5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0401MB3595.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(5660300002)(64756008)(26005)(2906002)(186003)(66446008)(66556008)(66476007)(66946007)(71200400001)(55016002)(52536014)(33656002)(9686003)(8676002)(6506007)(316002)(83380400001)(91956017)(76116006)(478600001)(8936002)(7696005)(110136005)(53546011)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Vz4VK68aHCxP6ea2VtcOLr19tKaujeZFhTa91DAgJ9ZJ/2jXB8H6D42/U5k/VuQOdTNTUAwaCky6weDXLgdv4A/Fzl0EL2torSHAhtXjsBpfyNnZBbVFylBcfKiIzcxBZCIQ9I/HnN9aYIPthE0DHQG253kld4peD6DIgwUKWYnGNuY0fXHgDt0OzcfGiVuF+g29S+YNWUem24pdcHwHf02paoRC8PrD7opvhxUiXacN8IVoxgsXYpB2j7S9p34GkcZ2z1Uhl8roh2qYitAeiekCIgCYQErILzmXiSS6n4cp2yiaZ17iHkXR3MiXRl/xhpPVAPVTHhGz2i6FMvIwHjS2qZ8iOjhUd0inK8PcWm/Da3qOjUDSQmqwTrml+Islf01AfDkNBVKqJ0J5weto2KH1bjEjJvxvCYyvhmVZxs/Sw/QYVqpl/KVHmGk2rwss/ODAmvC+XUFp43/z1jtGFViggApVSQ5GlZp0D6+CiWKqWjBfBV+3QvzimlYsMvajvsa1IyP5dk0+lVmGCKifk0/E7ue7hOJ1v1EEkF6EsjhPA2DSSVYI1hiwnIGXTQ8CBkQcfEUXPcSmM+vcN178T8zS8TACtj4FXUPqdRh24o+6l8rNJ6vzED8F6BuCmMBCLac7mBP4/7GBrP8gvYHZ6A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0401MB3595.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2866a7aa-a101-4453-cb46-08d854ac5dfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 10:37:36.0521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aa1Hg0t+5TFF1FiMH7M9rCg0Udfl3luzIUfSofDfi7DKcJe+BNbGU0eZh0ebUNS3iibQ53y3sU38UPkU42q6pmRw9795nGd84KPqE7/9Qdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2343
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09/09/2020 11:49, Nikolay Borisov wrote:=0A=
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>=0A=
> ---=0A=
>  fs/btrfs/disk-io.c | 6 ------=0A=
>  1 file changed, 6 deletions(-)=0A=
> =0A=
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c=0A=
> index 7147237d9bf0..d63498f3c75f 100644=0A=
> --- a/fs/btrfs/disk-io.c=0A=
> +++ b/fs/btrfs/disk-io.c=0A=
> @@ -949,11 +949,6 @@ static int btree_writepages(struct address_space *ma=
pping,=0A=
>  	return btree_write_cache_pages(mapping, wbc);=0A=
>  }=0A=
>  =0A=
> -static int btree_readpage(struct file *file, struct page *page)=0A=
> -{=0A=
> -	return extent_read_full_page(page, btree_get_extent, 0);=0A=
> -}=0A=
> -=0A=
>  static int btree_releasepage(struct page *page, gfp_t gfp_flags)=0A=
>  {=0A=
>  	if (PageWriteback(page) || PageDirty(page))=0A=
> @@ -993,7 +988,6 @@ static int btree_set_page_dirty(struct page *page)=0A=
>  }=0A=
>  =0A=
>  static const struct address_space_operations btree_aops =3D {=0A=
> -	.readpage	=3D btree_readpage,=0A=
>  	.writepages	=3D btree_writepages,=0A=
>  	.releasepage	=3D btree_releasepage,=0A=
>  	.invalidatepage =3D btree_invalidatepage,=0A=
> =0A=
=0A=
Maybe you could add a little explanation why we can remove btree_readpage.=
=0A=
