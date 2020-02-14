Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7880915D43F
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 10:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgBNJAR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 04:00:17 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:42811 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbgBNJAR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 04:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581670816; x=1613206816;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gsCVaVamtA8IsZMF6Cwduzyki3g2qlOgwozj93G00eI=;
  b=Ss2vpvtBSkYe+UiVAwNJj0RI0CEtOlhWdsimSAEY+bUj1fuk3vXqKW2T
   KPW7a3o8P9ujKjBLjck2bk2VzNU8OC2gjWS6hxpdFwuOL9d9Y3Xmjh5RC
   ZoC0fMDQ7Ne+44sr9VibUu5Lk3Arhbdbv6OYbFB9h5r16Iu09Rnio7/ng
   klkN8hUR7GItw2qX61nZyvwmSWWc1nXuDemb5MyilS52IkkO4VF9oUMIe
   4xMIMv/GEffCle68L3aXTJpToT/0/Z2Q3+iybhvj7pC540JugMAiQe9AG
   RltvuPzVoguuh7uGyaOwrLHQZlFp6G3i62J+hLfuFKOYCP/USIhQiQVm7
   g==;
IronPort-SDR: mpc+dHnR6C8011iJT9ntdZDpbLCo4Ta16KBiaD7woErWsHc0lWIaVxU2P5hJiCcCKOpTDuL3i5
 ytXXlzoIOFKHUXK0l1Z5afxJ6B+QNyRtIp7zRGWgqMFYJCfZcLKGHJ3rONFiGOeq1pA3fH1KCQ
 4sKFYibnCdk+Ypi/OE+gAU0p0dOSdKzIYcGTGCfrRaDkneKWP2qiV1aqaXeo5TSBVljHnsNO1O
 Xd2oPTpVKN/7wqLGqJi/QgUcnqbm5vQbtZUB3aRyJJtu6s7EMLqfXnfgZviX+QfYnq5A2w9ll5
 5Rw=
X-IronPort-AV: E=Sophos;i="5.70,440,1574092800"; 
   d="scan'208";a="129853126"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2020 17:00:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YREOuFH1ea6Uqq3TTJLo8ISyLlxAPQ93QB7uruJptlegNti4wyXoAANZTEVLaqZBFmbNhFnN1+YpMSRust9IiP81meZqHQumkLWrT8GPwTJiGiOXB/PJ2fuQYQ3Ow+48zbt0zmr/5JY01aWCak/U4zYaoKZBZVlO+Tffdq9LRLbwBtqsKgHI6kypVMY2YY+cAZTz1FfjuoJi1JdZb5/W6ExdkTlL5Uie2tVoAyUFFCQl1LuQpEVbLjRbzisyVbYUWNVktsBX2Qc2JiX1b9jlGc/I+L7RKwuKys6CdO5TgrkKJX/o4QoqY8bSj9M8xfVw17BujyfReXkgw65/RM0K7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAYS385k3VPn/HzClMCnx7UQFBrDNbzNicjDvAF7YKg=;
 b=iDO6egaOrXU1NdBl55tcovVeK7sZBda9lRzomzdlm40wmkdoqRNnwhoGnPZBEnBLIZT733sEG9F0SIqs5G/kATLhomThgj9OFTFrNmZW7+b9uOBQwvCJsBS3Za0q3MsBKDqzpSdf8rWS69FxLgHfyS6iofiNeXdbL65x7budywb2XpqhAmbwfSaowEi9A/JR9kVcBcVE7qVqYQnLnT0wyO8mFLQ6lUxkRMxFQ5jod7yMgV+izfRTXK2x4+6/Gwu4jdJk/gRHAe6xSeprmqb2dZvhFi2bGc3Sqw7Yc57cuPcDlEj0AR+x+p94KHxIDQ1VeDJ0zf+2BYzh/xQNW2VS3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAYS385k3VPn/HzClMCnx7UQFBrDNbzNicjDvAF7YKg=;
 b=fSsWxfIcK+VeBcNIeHttPyif73NB5/FlPCYyw3E2BonIeTYY5A9JKrSlGK5/Fl00dYjDehJyPkAy+T7stFMOia0cChNCBHf/WTr2E1tPF/tJ/Z5qEkU7mxlYbGFbMG95xu503ejxs3G2YTjtF3r55r8qZH8i1zniu2m7xegMdBc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3582.namprd04.prod.outlook.com (10.167.142.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Fri, 14 Feb 2020 09:00:15 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Fri, 14 Feb 2020
 09:00:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] btrfs: relocation: Use btrfs_backref_iterator
 infrastructure
Thread-Topic: [PATCH v2 3/3] btrfs: relocation: Use btrfs_backref_iterator
 infrastructure
Thread-Index: AQHV4w7Hm1V6+DxUT0CNbGIJidtL/w==
Date:   Fri, 14 Feb 2020 09:00:14 +0000
Message-ID: <SN4PR0401MB3598CB039EE0C0220A06F6039B150@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200214081354.56605-1-wqu@suse.com>
 <20200214081354.56605-4-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3adcbd88-a72a-46e9-f1e8-08d7b12c4e86
x-ms-traffictypediagnostic: SN4PR0401MB3582:
x-microsoft-antispam-prvs: <SN4PR0401MB3582A78C2AE562115787B7309B150@SN4PR0401MB3582.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:431;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(199004)(189003)(55016002)(81166006)(52536014)(8676002)(66476007)(6506007)(66946007)(91956017)(71200400001)(53546011)(76116006)(81156014)(64756008)(4744005)(66556008)(66446008)(110136005)(86362001)(7696005)(5660300002)(186003)(9686003)(26005)(316002)(8936002)(2906002)(33656002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3582;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6DaSMOSgNdzs23mzEMWzBuQCx1w8Hob/3HK6Bqi77K4HcH7sjAquY5Dv2f9gUp+uZimfycvL5K6x4yfjWmWe/CKnH3mwDvjJLuiSHsz2uqVHryKyj9a28Cx/rasj/KPBq/7+qulhK+/zTCJEsS5MtTbvkZR9Ptny+2QeBBBV+u1aI/rKtDrw3grsOK5l7NOsNjbSo8ULtKxJylzF0uRglAAWtnyLcViijecZ3atUo5jrQQ2dVcB6Iz9CqJsHvJ/dvH2aOckyZ03KIA45lZ4+o/er+arkwnutinYkaggY5PGBDUxFiKvT77c7RSLWMeQ/zQZjSt9GaY3QPxbIJ/MGNMLU6D/HBG5sG10DIQovuT5aD/bhY32JrT6AE/8Bdd+oaxt/hgFsDLORqBVBjHAqFGA24kMFFIxanBlABV1AMff5ZLKZm3Z0gD8m4M/+blQk
x-ms-exchange-antispam-messagedata: hOGE+CZJTqzR5zjoOUE462+jrFERHxF1IdU6GprqHnTrfihY5xoE9kvULBe2+euQCenPZC7Vh5rRmQ1cUinKs6J3zOhvnDbUs29RaLgbVXhlIPn6jlZzr53a7QCWhdb0tRaRI7jMnoK7IlZdsz33rw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adcbd88-a72a-46e9-f1e8-08d7b12c4e86
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 09:00:14.9069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: opFJmKjRSv+y4AxYA8/rRqONz+wPgBwNckyZuLkJ+8TM9XaAqWCXilOVIOcEvPhSuzfAR/lw/IW6BAI6iDJkm444cIUYC3HA0eoWdPMY00A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3582
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/02/2020 09:14, Qu Wenruo wrote:=0A=
> @@ -677,9 +635,6 @@ struct backref_node *build_backref_tree(struct reloc_=
control *rc,=0A=
>   	struct backref_node *exist =3D NULL;=0A=
>   	struct backref_edge *edge;=0A=
>   	struct rb_node *rb_node;=0A=
> -	struct btrfs_key key;=0A=
> -	unsigned long end;=0A=
> -	unsigned long ptr;=0A=
>   	LIST_HEAD(list); /* Pending edge list, upper node needs to be checked =
*/=0A=
>   	LIST_HEAD(useless);=0A=
>   	int cowonly;=0A=
> @@ -687,14 +642,14 @@ struct backref_node *build_backref_tree(struct relo=
c_control *rc,=0A=
>   	int err =3D 0;=0A=
>   	bool need_check =3D true;=0A=
>   =0A=
> -	path1 =3D btrfs_alloc_path();=0A=
> -	path2 =3D btrfs_alloc_path();=0A=
> -	if (!path1 || !path2) {=0A=
> +	iterator =3D btrfs_backref_iterator_alloc(rc->extent_root->fs_info,=0A=
> +						GFP_NOFS);=0A=
=0A=
btrfs_backref_iterator_alloc() can fail and I don't see where a=0A=
iterator =3D=3D NULL condition is handled.=0A=
=0A=
