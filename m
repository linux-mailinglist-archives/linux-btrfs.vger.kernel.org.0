Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCA429EEBD
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 15:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgJ2OuK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 10:50:10 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:33491 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgJ2OuK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 10:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603983161; x=1635519161;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=iLpjL14gNxnFUU5XDA3Mt/gRwhZKRzgkrLr9S+Chn9c=;
  b=f5TtbWh6Q6DlTs1Jc7UoTCWSu7ixlzIJb/bns1oBJfYHaAjYufSub6jw
   oZoPz98K2LRc6HUOoupZ0GnalbnVepmdP8XSZTvbFf84V39MIyMcFbEj1
   JRmrkKWTJz9g3WLsxSrIqFHkUqlfTIPOjbUti1RiPufhvEU4CDCBN0s+l
   eFsKE3Snwozzy9yLCJ/ILG4O/GW2oI897sEBbwUIfa25ICdFVFiYgGFkA
   vxZRuyRqOGi3wEJTCHRrgypIqKXaisl+3Vxyk2UwfJuRMgIwhgTXrCWz7
   AWPKu6QY/qXO05HqdMW7acopsFxp4iqylCVGm56frmicr3irG/mhHEQ2Y
   g==;
IronPort-SDR: FJkr+9VEh3Cq8nxt6axZrk+DSacpkAUcxLtJ0p8VOchbLgSdAJx4TiaV0rpUY7uVdwsKFxARB/
 H+Vmfund7xejrzVroKGpe2wLm539IjcanfW1ZDxrMDFGpptu7fto84HTnplSp2l5PRIZn4qA6L
 JuMPVyQrCrgoIodkgW1xSuszYRZB/KArRDT6Xf04b59GuoWOyRHme5NrzmptL5nquQDYNiQ0Cn
 JYfFEIdPvgVDQ7fALdmY4z1IaGm0gvmije0VU2YbFP2qaE/I09uUw6t+GBH7WnWufHlSp1UmVh
 qbc=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; 
   d="scan'208";a="254778618"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 22:52:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVVX3PXHikldS7VLhL93pPgXOQ3BtEERuy3Luu9CTAWHaspS9qVxTmg3gFS8GFbrEpuBnDT3lNJ0+zxTyeVR6MetDTxar2jnT2f8t4jIAbgJ4PscHTpLDDEVxgqz0+44q4kvkRaqbdv0YRXMFdSQoYnIm+xbLIMOevBmDf92rFaGfENrnoCkyyjOQvFYmxZUhCyiXf3vEkZmKG2pAt6OG7xodj6zOZqlaaVD+br2d9lFQMS6ZPB8KO/e66XPDvSxvpCjxRE/86fRuez6uTDuEm9ZYPgL3MC49c/AS1LBMTcQ/3VJVqkkCcFbhJQONDArLBOwFWWsHG5GrWN7HVgkPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLpjL14gNxnFUU5XDA3Mt/gRwhZKRzgkrLr9S+Chn9c=;
 b=WCr0PBH74mKXLRpVJYdIUNaiMqZTj7nAaJGb58JIceoeb1o+TXJPUm9HKfQYouFA2kK2wNfkQKSXaBERxcMN6e6hQBK5sjY5sErxFu696t0ZOY/FwzU9FT6SdlNfelW7/rDqfuVj2w/mF9lC329+aNz19Tq5CxJZPmLtiPes7I3DRGQip+qFOack0BKzGc9UJyi4fX1xx27S8Ll9hXTOGymGd89eDIsaJCKrCEiao12hWYCf9IRtBtWkNAhbQO35wTXidXRfgs7MxB+9MS47AlF2R54hvgMCiCQd8d01fOMbeoHf12GG1s2eHtpKseD3pqukuurQUkjM2zaivIAMHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLpjL14gNxnFUU5XDA3Mt/gRwhZKRzgkrLr9S+Chn9c=;
 b=dtwJflEtnBV7pzipvcxt/GPGpYKQj9lG8FQ9UlfpOsg9a7XSj5HN4ezqWTC19GjRMZitl5iPAU54eJeBHnG+GgyVaqXjhXjggoQ/b+YkqPj0X8scclxBVHChjkWAIhpkST8fG0qyUFhBl4eRrXMSGpFPsXxXU/g8GFoxn1VIFYw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA0PR04MB7212.namprd04.prod.outlook.com
 (2603:10b6:806:ef::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Thu, 29 Oct
 2020 14:50:07 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3477.028; Thu, 29 Oct 2020
 14:50:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 00/10] Sectorsize, csum_size lifted to fs_info
Thread-Topic: [PATCH 00/10] Sectorsize, csum_size lifted to fs_info
Thread-Index: AQHWrf/iZe3NfyFAQ06+YOf1gXF6hA==
Date:   Thu, 29 Oct 2020 14:50:07 +0000
Message-ID: <SN4PR0401MB359889F68E7BF45740CE02CC9B140@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1603981452.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: adff1f12-e53f-49bd-a97e-08d87c19ed86
x-ms-traffictypediagnostic: SA0PR04MB7212:
x-microsoft-antispam-prvs: <SA0PR04MB7212BEA365CCDC2A7B4050D09B140@SA0PR04MB7212.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rSpdTL+Cj/Di0+f6ZZJBk6ckRy8paA2scwg6UqilqlcITklpk1651RcWg3+C6oCMoHrLwg2zAdq9erUhtUahJni4ybX7pS2a82JEWsmGPcegvKzuEygsdscO88xcO2H+1tUva5FoxlhjEOuRhco5Mrfu2BnT5RGZCYgaJiWogdGdpoDSVH/ENp42wiQERzblYesvAdsJFsHCptHLifJvxeupX5XVyiQkLWxB9gy9iAJ7505IftNr1cZ4reNFQlgUxFFHp5o+o2U+rFexfH4NgerYuO1AW53SWPJpncJy9zYY/1I/eAKX1K1DhX4T0lIQypGqxmqZvuipRoPtSqMCGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(478600001)(55016002)(9686003)(86362001)(8936002)(316002)(110136005)(8676002)(71200400001)(2906002)(83380400001)(26005)(6506007)(53546011)(186003)(66946007)(66476007)(64756008)(76116006)(66556008)(66446008)(91956017)(33656002)(52536014)(5660300002)(7696005)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: QiBbaz1OsVR6XZJscmA8wAGDQfcgxu5oV5SdlvbhKFpHAYM+iqUCXD+zv9Q5Q7M2lfUqcOow6uGs7p9Nq+HXAx3aUHni7ZvTrKqTEMrmH2fR6B6GZqpD8f6u9fw2mj4B+vLPFAZg6Igi3REI9lRHqtsuIN4Ixe9EwySj59vPmVnQcG0gI2NqpSVUoCmOx4wh3euoGhGWUm4YQK//bbKFwm+cdcs1cBJWODvs6aF8mMyfkhnAzEnZPxCzWDLIzZKNDp7lGxthVJ7wSmgBYIYGbBFzkUx0IIeaSqeiDEd8reeGxnX9F9tqyKIj0TafqrrvtjVb+U3EPtGdP5QjZ3/8Xe87W+93iQHGkebBTE9BfxMQIWBRPf6VMJBfispjyFNsQzOvR1ahKP1Nj0lrZMPojb9tJlSrd5dofIkvHv5NnPmuVCDLSrzijRk2GqJCA/cr6ExL8Kj9+Uki9NKq2WmEU6bRlsINnjBFrLG38NZQY31R4YOkLMSrTaOZwDI7b1Z3UTMQHnO0sz3Xgj+P7FbpcI8oYJuSz0whVQYvBpFNt5XhRr5pkSuJ/+cUMyGvGN7vuCfCHWtwyQVsR8fHcwK1SRd9ZhEmZknGwFBLWV2ZbpQ/VQgRPv4dlkajC4or8X3EgZ7IpwjSZWCGTC+YV8dGnw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adff1f12-e53f-49bd-a97e-08d87c19ed86
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 14:50:07.2847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fSqHDKokmco/CbbEYBwXIY6IAq2diMOezfwsrqWzxiSkUCgDobhUAqlpBcHNM23rrilr8G8YGD/BCi65M9YEspOns3RUs4Uub3Wd1j+pbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7212
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/10/2020 15:29, David Sterba wrote:=0A=
> Clean up usage of multiplication or division by sectorsize by shifts,=0A=
> checksums per leaf are calculated once and csum_size has a copy in=0A=
> fs_info so we don't have to read it from raw superblocks.=0A=
=0A=
=0A=
Currently all checksum sizes are power of 2 as well. Did you check if there=
=0A=
was any benefit if we'd cache csum_size_bits and shift instead of the =0A=
multiplications and divisions?=0A=
=0A=
