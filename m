Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7BC168DA9
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 09:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgBVIlc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Feb 2020 03:41:32 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58416 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgBVIlc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Feb 2020 03:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582360892; x=1613896892;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=EtXX9+gDmF90iC/j0NHABP4PnXMUCFLYcURoAZpJgzzz5rVYut+jtAZh
   +nQAaV6DG/J5x51G4/tKHafNIabC3ENDx1e+MnutznguhE64Vnp0464YD
   Fhr629x+kPivtekJ1KlBXLSlR4cxOK0X9znrCWQMWzvSZyV5s2Ezngy0B
   eCCQXBHwYIwgoJXmSJL3nDeav78ibMYWOi9e1u0m6Q6MV+z57lBQ+Rqwq
   /cmPkRSJV2rq98gcWGpdLqU1a83AjxqGpihDbweE2D8mZBGKlv8yGXfA4
   om+8N9tMLGmeQX3L8/fjC+zORl4XuvXz9elOgp7UQR4DS7Y3mSkC61UBv
   Q==;
IronPort-SDR: g7M2KuZPFk2pND10fmiW3VFRfPrPp1tnzk7E2A3w4Eepg9w+61qItuwysb854zbPqBkl03Wgxq
 Jg73q1RuspQGZDCzayAuiOK5xOnFjl+njCPzJNVJKsyLxMddSlFzuRH03aeAL0Mg7mg+KJfWU4
 azbWQEaFHp2t9u0wHFkFTYGJfj2pkswDYapEQNRf8SS8h16XC2Y+X5HuAavYlMpixEgFg76ymK
 qVIyLj5V2Fl+1EBkkaYTtfTpFkj24D+VMa34q2viH2i9Lnft3Rgp+Y5vDqraOHUFUOQpv2/+hZ
 VQs=
X-IronPort-AV: E=Sophos;i="5.70,471,1574092800"; 
   d="scan'208";a="134824807"
Received: from mail-bl2nam02lp2057.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.57])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2020 16:41:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzoH2FJAaD0PqqLT+1x/H3qC8shIhSyIQSoURBnH8YUs8FWQdBpc3upE+3pjhulWA2fbpONuB0iL4ZRYSZ3TFcx2mkYrkJMmWBMdOVwdVn4i7ZDk7T00aX7yna7x1wkcKwH0Jhd1w7W7gnTMJXPrCZhA3Jf3xlazq5vfedHF9QSEujBsn0oLnFDTEXGoyk271uBCJcjrM3w0qR7fhjDhnKT7ZSfL7YXIDGjiRk6rxyEEZIj8dta5hLoQQZO+1Eq22jnu4iYXZ7hRkwvk4MiRQ325PfFYFuXBgi4Acb632fGIdTniMKSrXyd5xtKhthLdW0//Re4jmtA7T7rk0qufdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=i2FB43yBPjt73y3Dj400AijLl2WNA5ZO/YRjLU/0jWCnLSN03oiKvMAurXS5F6AxmvxIwxOyoCMGHjSP4C8ejAKwQIQkeI3XLc0JO0jAmi3071VpvLdfZvpGM4EBFQzDvleId5DIO7TI7oJe2w0rTGY/iGwBYpboNU2APx4JjBRI7djrM2qacYPlRAEnIvLzuBMyqqtMi/KuwKHTU8YAK37OA/5L2/LmRaPqFg6/mAsWIx8k/evQ7QW4UPbmrauAg2u4gXcMrpGdsxI7a4kt0Ae5zwQaTrJlbJMFcqozJzgrRNmQJKKNVQhXPdOnsktFWrOasPnOBzJtvP6a1wqgPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=UyVKC89Yy8YRoKobHitV5bFKuyfvkfGi7GgGM0E6F7DrBSc8NTkLTknUsqRkizCOy2mDITy9+hstuiCEBa+x6+In71G2oqXRAoNvZLz4ePSN4SoYnLtN0GZVgGxyiiM5DJxPCpZ8oOukdhVgZl+q5C8jHOvGgVL9R030x15tybM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3583.namprd04.prod.outlook.com
 (2603:10b6:803:4e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24; Sat, 22 Feb
 2020 08:41:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2750.021; Sat, 22 Feb 2020
 08:41:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/11] btrfs: open code trivial helper btrfs_header_fsid
Thread-Topic: [PATCH 03/11] btrfs: open code trivial helper btrfs_header_fsid
Thread-Index: AQHV6NRgqBjrZuoNZUeS6yhlp7wuZQ==
Date:   Sat, 22 Feb 2020 08:41:29 +0000
Message-ID: <SN4PR0401MB35981B07052E60087C05D9EB9BEE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1582302545.git.dsterba@suse.com>
 <bfd3971603fcea97ddf2a25b635966a0a3bc506f.1582302545.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.212.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a1471cd-6bf4-49e1-a038-08d7b7730350
x-ms-traffictypediagnostic: SN4PR0401MB3583:
x-microsoft-antispam-prvs: <SN4PR0401MB35833085B1D438B7F8CDFF319BEE0@SN4PR0401MB3583.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03218BFD9F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(199004)(189003)(52536014)(81156014)(110136005)(7696005)(81166006)(316002)(19618925003)(186003)(4270600006)(26005)(66556008)(66446008)(91956017)(55016002)(558084003)(5660300002)(66476007)(66946007)(8676002)(64756008)(9686003)(6506007)(86362001)(76116006)(8936002)(2906002)(33656002)(478600001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3583;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bmClYcpwsiqcaY+0nB/Ug/Hvl72FVC0shb5zSkB1AVf1VRPNOeHHL0I0gMyoW/UaZLwY0AWt76Y4gMjS5x4q2sZ5qULZoQAAU74JE+STkLgH46aQuatPACfujAIfiQP5lsliQs6UygwzwlTJmoVR8QFbuUtphFzfz9bZ6xJvdgFKbsASWCIGchpTYJNApiSX5G85ZsC3RO3Gq4SbzMTzWi8UG/qVfmOH1kqzFZ6wJVLGEM+Eu46v+SIAxBVOJ2rIx2dV0N2MwGLKVSRfSf0pmi3aNaWElo76szCLlYwyLhpQk/zG9HnnSKoxcHniUHC2v9Bjhlc/cdBI0R8GKj9tTGPMlB21DwsQnm7rE1xc+VALaMVhLxColIOqWErsaBfpORmtaOnXFZUTv4VeC6fZvsoXht8zyMEcHCQhX1ld1lI/lKbOKRqyWY8sqT/1gsx2
x-ms-exchange-antispam-messagedata: pd8x2JTe0gMAvlrukPzaubqmAn2MMIcpT5l4wOFLwe/BRSTwTVNSgvEhEF6bCSIoXBjOvIsWzu+HL2fd/bb/MBNz9atcUYXT+QXUvc1k65sKidOA0CWgoT89/VOGAJfDfH+0nKv7udq6yxpV09NarQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1471cd-6bf4-49e1-a038-08d7b7730350
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2020 08:41:29.9313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uizGFlqH/9dXDnVR3lHcjjWdRY0wHXrMt5GIWZaYAJ6ExgGZv/dU+l8KiJCk6xOCF7sJRagdHVrP6GP6aJH8TCeSWpH6IHQVVdF5KhToCqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3583
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
