Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57BAA1504E0
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 12:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgBCLGI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 06:06:08 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:58534 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgBCLGI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 06:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580727988; x=1612263988;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=XqexVmN/5hw3hAxzrXvD0sIusHWgnfRUVk4l6pi3Ikg=;
  b=dKTedXV3blLMx8UdBhBgij/AYxAUS5npWmQNe1mIhTG4rCV80FDxjCi4
   JMGtbN96rNYgwnwYbBy1vgn/H1EFalUBk96ZBUqkYd4YGnImLE6FiMxdf
   oDGml+p3TKZW9q24FPI9/NTmYKOrg9y5jN8RwDUL+3aO/hOX0cQwjtKGn
   +ukyaWR8o6D3N8L8Nc3Wg/F89x/D2O6h5aDwtWRVB4kXZsrqZZ/U9gKP0
   xMzSUfIHx9OIxzKnDrcABHkthZ6rZgILs53Gcz/pboJJ/yLPDyEh7UB8u
   GhtKRZRLCSl9/NSYgbegIcCxIIIyDs34Kq8QveaI94qHM3qSZfV0g77CI
   w==;
IronPort-SDR: 5Bs2J6wRowH0Fk9QeeyaXjuRGWu82YuRHWiBLRKd2jpbZWtUo8EzcxA7rv+iVy2OkpS/23Db8S
 uKRdzGKwj5/OqaRJKALXuz0XW2MfG9fc/mg+e4f0ADRuocjnAcgmggMVCcSBJHXALzCfal7OI5
 4qGn/JrUfNl52xF9B7HxWNzBFC3ipvKUiOh1f5G84s2Iu/UIOoTwvm5/w05pvrQSBBCzGDuaZx
 z36V9GuBkPCeVKwtvvwJZVhvA24Hm9cGe1z6tXOQnFY+B0pNOuoM5rFHnpU5Fuqn7fJKq9cI6e
 Mq0=
X-IronPort-AV: E=Sophos;i="5.70,397,1574092800"; 
   d="scan'208";a="230704248"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2020 19:06:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGkFaxub/OSHqA+0cle8Uup16lzPHgTWRbHV5yMjcNidtKVfIz7Wi8NsQeL0kZ3DO214TiWKXBLF5Xni/77pGUA6Jr+tmOqFMTXJcJ7Nehr0gxZaqUevSr+ceMf/KJVe5d1B4lZ9Le1d3AZa22B5ccJB5EgTgom+gCUADFMh0RF1Mrxj4tdE64kKKJ7bLyOCaKhXLskopefiDv0yp2LIPRzAl7Sp+Y2vW4WMGDqceX/n5/J8/tWXZZ5/sptgkCFd4OUUQRk3YvVQtmuzZRaKo+iALXLW/y8Pf0SmtdJHZJqS+GPzfmnN1KljTUGulH1aAg8uQ8xPgWITLcV0wK1R9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqexVmN/5hw3hAxzrXvD0sIusHWgnfRUVk4l6pi3Ikg=;
 b=WzpGERhAq1qn7sLjVTaMVJQ6SjJvVuBLhJiHgSfRbbGcw94b4oBzhrtWpfVBO+/5mqJupA0oqaXsafERLNvjsnGdm8DL0CNTo/UITOfaw4U8V6ZpSMGe8JWW+dGkxQi4Zv7EHmQeCHHWpc+DARkMxsb9AgG00ZmaB3/Ksu/HH6k57W1LvxTy2M60+Mn1bQeQ64Ykv022evAhZThKv2zizBOvuCA2oCsjFbLQ5H2qDn1VyzKd2rnkP9zq0ah0ZhrTjEHQYjS72pwh/7MZ5PFtbWVBQUe2LZlMbtC58MWqE1+WlYiCc4sqItcHrXIRzfIOpz+68fIgXMc/6wX/Sf21Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqexVmN/5hw3hAxzrXvD0sIusHWgnfRUVk4l6pi3Ikg=;
 b=neVbHmd+GM4fBGRlOB+s6Z0gdku0r/I/mbEt8vbwAVwrObpDgDU/wtJf3fT6RwYPfNlRH3Pdevnt/h4VHdr1I5Umh/SdJHUHkKaKhE13P67KdSzuCD8/hh/D/4uNQcDdvphXkTN7Q34BinSX4yeUgj1jK50ADKAE7zM8vUO+2MM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3597.namprd04.prod.outlook.com (10.167.129.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Mon, 3 Feb 2020 11:05:55 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 11:05:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 03/23] btrfs: handle U64_MAX for shrink_delalloc
Thread-Topic: [PATCH 03/23] btrfs: handle U64_MAX for shrink_delalloc
Thread-Index: AQHV2Ibih8Itv/f4b0CQDKnKvqgp/A==
Date:   Mon, 3 Feb 2020 11:05:55 +0000
Message-ID: <SN4PR0401MB359869E79393D140D49D1E8E9B000@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
 <20200131223613.490779-4-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.208.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d8f2d15-51d4-4a51-d806-08d7a8990a7c
x-ms-traffictypediagnostic: SN4PR0401MB3597:
x-microsoft-antispam-prvs: <SN4PR0401MB35975EFEF8AAD73920F0FA099B000@SN4PR0401MB3597.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(189003)(199004)(19618925003)(86362001)(8936002)(8676002)(81166006)(81156014)(71200400001)(6506007)(2906002)(66946007)(76116006)(91956017)(52536014)(33656002)(4326008)(26005)(66446008)(64756008)(66556008)(66476007)(186003)(5660300002)(9686003)(55016002)(558084003)(7696005)(4270600006)(110136005)(316002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3597;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KzaXkxS3V/rVZd1ulzy0eNvfG8FaJeKxeFURCF4mIZzI/YUjNnBLnCmaNCFH9FEUPY6cBfg8sXBbOZr4yIMRa109unUrPvp47AuRaFEIcnDR0AisK8GtjMPCvvYaHz34cswoMzwuxnUvI94mpeXlVmheT45DTkGsnEmB3W6R8PmlgMPQIgUPmefGLa2YhNf5+okeXcpMqJtyB1NBeBf+1TmlxHhmvkFH1ZaNK3Tptr964om8b5UW1IiGPr3VvtI2ISLu1/No4Opo64YY4/H6MxLuLxLMgHsHwZ1zXpWsAQKbeLohrC0Ix65DLbmu+cOQM7XDn2F7X+tUnozUdPgXoPWhHe0Ny+D10TaulENnhnefvi1oUS2rbDvql41hj2F6kqi8csIquGc7gkYd757hTBjRB5MCQHb34BQmdaJrXI/wgJuay5r99uyiQ0QJOftU
x-ms-exchange-antispam-messagedata: KDjxxyqvTrZv2FYhCKs6AEQwQklK3D017qzmACCB7fZarKivehIwPKQUoSm48sjQFDVIPZwxLpVGoFJm3XKQWlPZH3NeZ8TXRVzo3U2xn4D3G/SiCsn9/QURHmt80PuvjksRM95QfeW64wHltxEoGQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8f2d15-51d4-4a51-d806-08d7a8990a7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 11:05:55.4911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1qeY/2I62dTuAotUBZT0EkejRiTysv/aWKfkdoSpe0EFgXF6geKpvnntEw6hdtTLszEfUU/JOnvbdbzFHN1lybNS6hfQhB4lvHoGVBLoN4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3597
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
