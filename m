Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75EF272467
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 14:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgIUMza (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 08:55:30 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:43642 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbgIUMz3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 08:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600692929; x=1632228929;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rE6v8KsGUurdC//Veouj2zpn19KIwpztN5duHMadZKc=;
  b=NggOSsORz/cch8gzDpDlmuT9+ja/Z3Fcgi65K9DGHbZ6rQzbZgTfakbY
   Ufh/selmgK5EhppthYVCfIAZwuy1AlMA+1d6uqUMu7ogu2YkHO5oMBgc5
   idpiSuAJDNnGSq3Xh+DoFGXc+K5Bzyl/F4slLLJ+FCmfq3W807rPxXi4x
   I2qdouIdH+ZyxHztT99BDcLC2BhdkdRORO1Cp2TE10JPz4eX19dDy0oDJ
   ZjWWntot/29VdCL9X/obwwJx8tqfaj783EiHuOOc5FWtFrlXrJi42bS/W
   aXOQD3PCoo2CTU2bSqVb2i6AYY5Pu1cn+VXnpwF18zlppsopv6De6YWXp
   w==;
IronPort-SDR: zu9veN8kjcZ6VbVT7R4p2J4FVPogaLhEXSCfTXLoCV4bsHKLs10CU8AVpKWamCivzjq2IVub6/
 XcVx+AFqwUzSYXvcfdavEQchJnijcBhK9wqV0cW7eNva+XT789WmEjMixWf5HaSvpHV/qMOl6t
 ajGXNLWYSsSQ79vBbvWbeF3aD+fRpjP7Pmb5uIt05YemYpqbK2bVfddSH/H+81c+nuqPmT91Aj
 tmEzTic9KcHWncA7Cge9EMoM5ysvlD7aH7zawA81GzVbvn5bzzriyEB/bR2X515c9KZ5tAG55E
 zUs=
X-IronPort-AV: E=Sophos;i="5.77,286,1596470400"; 
   d="scan'208";a="147904502"
Received: from mail-cys01nam02lp2055.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.55])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2020 20:55:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVF7apSL6ePt2WvQUX3AqmiipW65cDeaA7EkWm+/hkPn7lwofzE2c/dkdbuyg3CodQ5+ky5Bmdr+AL0uanNKvyrkY9jgxb1FzqFjnmBxe4iUf2kCYe3nR16FTC8GpICaOtQnUz0WejyoIInwnHy2iOXF2nAwaBh+Rn7tHWkP+L8wmxiCvqvdle8I+2IqRDeNinBVli2PeGVQ7UwRXQ7wIHxCDBvKav6EYeyj2Yc0tZ1aZ3q8qax4s5xHkeTJgV6igL0u6AGID2IGpMy6X5h59/OotVeiLhtZsLiJN8mmtPr8OUU/V3RV6mDugpgKrGlz9dGSliqOMMcc3HgJz7PsrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTpnXRRClKbxs5E1EaUMiQk9d4mlSJ0WShckk1xd0Gk=;
 b=f5432d8V8earNNcR6BJd2vbNXrKerpCfneVydpNpwmwElonF0/H6SxsVOuDfE44uwq3MyrkdaR8jnlu4fHCSTNgSP+S3Zz+jdtE+nENfmyLB93gqB/rDWXWVbZczG88UL6Yw3N/IoMJaLXqQeI8fI+pYQ6UQL3yk5vbmVIoQvomSCZlxU+PXqgEl+FVPLaxk7x01+vtwLrJP1YwoW6SRXGTMXwcoyOe8rtdpcLoWY1Y5L0J2z6BS3sZdaJBh2c4sHi1CNqqE7djfG0OACTRmFar5IZv+vTQQtRbic8r9o9SrohLjQhxRHYpzQ3C9F0k7rIzukl8DnP1b1c23p2Bv+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTpnXRRClKbxs5E1EaUMiQk9d4mlSJ0WShckk1xd0Gk=;
 b=XGcH00bYms5MdCkUV1X1cyWHLpYgs+iO4PAwde8LCYPskVNnkk1eOL6xNZ1DyievnjEwT7HS5qEkha4IeLOkfq2TPSo3pqcG1qE7PYQ9hvYULBGovHNHEj/M8jLgjPk52YgEO6TmMU4U3Ve5az8gWXojjOaKTWPrcaJQt1tzQ5E=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2144.namprd04.prod.outlook.com
 (2603:10b6:804:f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Mon, 21 Sep
 2020 12:55:26 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.033; Mon, 21 Sep 2020
 12:55:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "qiang.zhang@windriver.com" <qiang.zhang@windriver.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Fix missing close devices
Thread-Topic: [PATCH] btrfs: Fix missing close devices
Thread-Index: AQHWkAZwfectfW62ykKQzYaPhiJUCg==
Date:   Mon, 21 Sep 2020 12:55:25 +0000
Message-ID: <SN4PR0401MB35982BEEDB051A57AF2567DE9B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200921072926.24639-1-qiang.zhang@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: windriver.com; dkim=none (message not signed)
 header.d=none;windriver.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 06a9c47b-42f6-4d97-93b6-08d85e2d9c5c
x-ms-traffictypediagnostic: SN2PR04MB2144:
x-microsoft-antispam-prvs: <SN2PR04MB2144464C5C7A8AB7A82CE7A79B3A0@SN2PR04MB2144.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:208;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jAUaDJ0MEHCbjN8+enmeWjXH0q190ooH8aug8XEGKaQ6CkdZYdZzTsvvB5twPRHZvERlcbj86jXB9Y/hZjS3XP8ozQJAe1NPnt7hH6bDTU9jY5beV12zL9HbSSGNGX3Y6ummAVYCkt95hDTPtnRzaU8ITXhAES55KI92kvp2ZM5SWgsflIRPCsFRZX6yYohe4yTkheFH0DZD86G2hXD5NfNzFhdmFbRSg4XjJvsiDkXSwKUjEtsInH03RTzZ9mIxJybypNiE0QyGVaDXdcvkqVqfEpnl8a6uvgOgawPlaj9M1pL7QCNoZCYFzXvjAQ8Nd2uzkpWyJaQSNQSBykCV6NS8G4aIvKgSZAyjSZL/DSOdgmHof6grIdTZWwWNKYLzBM0TAszMBUlm9lf5wcvEWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(66946007)(66476007)(66556008)(64756008)(66446008)(33656002)(45080400002)(86362001)(478600001)(91956017)(76116006)(186003)(53546011)(6506007)(8676002)(8936002)(71200400001)(55016002)(7696005)(52536014)(26005)(4744005)(5660300002)(54906003)(9686003)(316002)(966005)(83380400001)(2906002)(110136005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: V9VZDaehV0SCc7PjEI56UMbpqml03/Xt3ZYoLx2lGkMmaNT3GVYKT/Gf0dhS3dG1QeBK4NS5La5GchzlJkw1CDjbOqHJcM4GS54abHjpGiKG9jv4ZmANgbpu2z2SFj3pMZ/8dL5vWmihBSCU+F+OsaB2cWnsaWaTkL2OB20XkjSax8Q6A3LVPmFvC6f1RFTSkx6yyRgEji1R7xQFXlQj7SIDl+zfJn7uLzB6FJv7FzFb55I+t4SBsbEuMpcSrb1Cgq2eZ3IB5yWMR0A4YPXR94anqdHPMm8Idfwu2jrX/rHFa/fNsa/HTiCBezt/vILtCqYfvMB0PMzzrAp6LFYhQLcQqF6odIcO+avFJHj7wuenatCDCxe+JgHDMSxuUSYAF01dPWU8sDyElJ3093bFAWSh5TCE60ew65dLW13stG+7Eu7+ioAj+FnV0BbYcRVdhGpz0crh3zmZgVq1aC1skr0gfj+Wg4pPaxcOq+p2G1EyScq2mh8JXHR6mMC7+pJg6T3oWwCXpMHA5XNV1uzOYoR2sEz7loXEUZO9cQH0U/2IgI8U5XGwlikSY2ZO9ccXutr4PQ47QYAR2cgJtjgSNARsyLQ5cLFdFjzi47w+wWcIYaeef5Pb/mFA6j0Ts5qhNP9m0S6psChDmhRhQSqd7A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a9c47b-42f6-4d97-93b6-08d85e2d9c5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 12:55:25.9868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nQAdbbJSYqHp2v3aTMVpCmbQV215O6yHOt3NsTlmJtx68AdQUb1LDew8HrTT/7C/jZZsELvF9PVMApEep1gx2FiYGxVz75erqf78LwO4Hsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2144
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/09/2020 13:00, qiang.zhang@windriver.com wrote:=0A=
> From: Zqiang <qiang.zhang@windriver.com>=0A=
> =0A=
> When the btrfs fill super error, we should first close devices and=0A=
> then call deactivate_locked_super func to free fs_info.=0A=
> =0A=
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>=0A=
> ---=0A=
>  fs/btrfs/super.c | 1 +=0A=
>  1 file changed, 1 insertion(+)=0A=
> =0A=
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c=0A=
> index 8840a4fa81eb..3bfd54e8f388 100644=0A=
> --- a/fs/btrfs/super.c=0A=
> +++ b/fs/btrfs/super.c=0A=
> @@ -1675,6 +1675,7 @@ static struct dentry *btrfs_mount_root(struct file_=
system_type *fs_type,=0A=
>  		error =3D security_sb_set_mnt_opts(s, new_sec_opts, 0, NULL);=0A=
>  	security_free_mnt_opts(&new_sec_opts);=0A=
>  	if (error) {=0A=
> +		btrfs_close_devices(fs_devices);=0A=
>  		deactivate_locked_super(s);=0A=
>  		return ERR_PTR(error);=0A=
>  	}=0A=
> =0A=
=0A=
Hmm you didn't change anything, so my report in [1] still exists.=0A=
=0A=
[1] https://lore.kernel.org/r/SN4PR0401MB359820738AC6479F9F47FEE59B3A0@SN4P=
R0401MB3598.namprd04.prod.outlook.com=0A=
