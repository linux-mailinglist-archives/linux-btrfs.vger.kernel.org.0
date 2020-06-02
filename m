Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EED31EB7BE
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jun 2020 10:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgFBI5p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jun 2020 04:57:45 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29481 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgFBI5p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Jun 2020 04:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591088265; x=1622624265;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=TAz45eGPJiD39p1AeDRX1C6vpvhAMsvZta/2FQRrcnLnDcohjkmobOjs
   2lFnWiyPGBcC5ZpSwsqT993sBbAVaVEcN8uf5fE0QSyiVv2c6XCT2zQxc
   o+HaAqTwtL36goDmmFFdO5VVJ3JianDBth8IRUlCkpYFyKt1K82TKzHye
   uyYhqsx1ZtlcMRpMGDVq2PCgZ2YiGqpiBbo1QLeN8IdoR6Mz40jmZoCMd
   XmivcxFcRJqSALb/VyJKanSLk13Q/bslrCcPu+V3GlTTdW/D7ETYKth/J
   PkF1K/caKad7R4124ERiiz1LUC3y2KmmpusBTnHhzPNTfo+9khooq1kCO
   Q==;
IronPort-SDR: RD0pPsY0U1BFKbBa4//oKTSnpetK3DFwuFO7YQb9YN1fn20+UZzsO0LER+VmM2/8/J9lC1VUu5
 RPlguy1oVvDpWUDj0mtwurowKPiOlW+P4bIa3RV+hYpDNRyM6OqD2qVnI2mf2/poop27X94DTL
 Zb34bJnJDOM9dvJZ1SEXfyzcbEn/pxmMdb0slH0yNdUSZ94XMA0B7Nz0yDYbmszJQZ4iQLlGoZ
 xNr9b7Y3pwrJggPbrsYHje6VjxO/fWIzlIl6/U4xJIYF/SQ2lvbtiUjCPvzSMndPO74AkFP2Er
 ubM=
X-IronPort-AV: E=Sophos;i="5.73,463,1583164800"; 
   d="scan'208";a="143341837"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 16:57:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVUhptGKveobQYBxfQtnxzP8oFwhPxFRUPtzWw9+rJCCwE4uehz+3SNHMaoHBYEtt2REbBjrMrYJ8b1eZ5xXPdWAE65eqpvDCqYpZiFKKK8cAAZVtuoJxPKc/D7p4nzLESylIINfraY+VMhNjPFMQTw5JHSgkic6bXAMY9YXvk2vWsvpv6zHsLoHVPdMKxNL4dfFR31VLwyq0Dtx7exp7+pn6+1JM7fpaGiR/nW3gdoDjzOVWyMO7IXjaqNZxWJDqegtw1nHderLzABcl8xww3w0DkNLKAk/rD6hKitX3tpVjLiEZIN6mBO/saXThTVmH9DRwqOwRJ56OwR5BNzkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=APJTRNziBugt4Hny4tXdZbXgpdxtF6gna95NmrT2rSgomFjP+Z4gwWatvWb1tYKw3nppupd43msQKNzK00zQLloB75mCT8H8gGxIhZ79McvQ4EhI2DfzFzcj3kf4mnp7jeXxMSs1D8ABhGenHM2fb9I044sBqSuTrwsb2eP74ZEVKWSpdFqusXFWBEQYXBjHkkV3W2VVBAEgwwOnDlEKpM4Fq6wA+yAYJUyZHD5pzLXNYOi9XNaObjvwWZEKk4NwAS5tX2eBcNHYAf4ONzXik97zHyiY81uuKmgzclOrAUzDorL7zYxCLq+YC0G+6DIBKwV6kSgur1WSRbHbgflkUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=rWgDlnjqu0UpZIXcC4MRhkbhUB+tpouKBxncgj6MQHoNVuT267X/kpxY47Gkqe7fjq0J7rYuOxVLdjxAyqrIZ9awGJ+EgwGlsvkKbPN6A1YCf2CuUwGCjX0hv5GaiovTohc32byQmbQeT0LDW2Rfj8P3T4BIiNN7nuVrZJe/4ss=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3695.namprd04.prod.outlook.com
 (2603:10b6:803:4b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Tue, 2 Jun
 2020 08:57:42 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3045.022; Tue, 2 Jun 2020
 08:57:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 04/46] btrfs: Make btrfs_reloc_clone_csums take
 btrfs_inode
Thread-Topic: [PATCH 04/46] btrfs: Make btrfs_reloc_clone_csums take
 btrfs_inode
Thread-Index: AQHWOCq6T0CI5NZys0KgvPP2l2whzw==
Date:   Tue, 2 Jun 2020 08:57:42 +0000
Message-ID: <SN4PR0401MB35987369C6D08960F5E773169B8B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200601153744.31891-1-nborisov@suse.com>
 <20200601153744.31891-5-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3569303-2159-4f9f-23d6-08d806d302c1
x-ms-traffictypediagnostic: SN4PR0401MB3695:
x-microsoft-antispam-prvs: <SN4PR0401MB369519B4B06F8388613268319B8B0@SN4PR0401MB3695.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J2AoI9wNu50HeB68/fpJxBWA++xoYi9M9M0LP9MTofpYXRadbgW1Kn5x4pFFoIK0/OGblbJ1XLQaDU1rfccD6cK2AEr6n67qwv+oIhy0Ar+KQfEw7yhHyarFhBkyXVLBrsMEn67zoWW0M3SX6vCfUr/T0LVEjDXihkijKCvZwWCZl0IQhzkr1kGcbyK4c5BgSjfGB8YWCWm8AR0K8lKGfE/odVbarC7QKaYQTzxGvWAmj0r+ZBO8pkeKWFDVWH8Sd35GCkvmLaDrtY12nwEWepgm1mbB4tY8fGFTtac5VGuNld42KQnQsic3HZOKKRhGdJ5cAz2LjdszTv4IhcZ49A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(8676002)(76116006)(8936002)(91956017)(5660300002)(66476007)(6506007)(64756008)(110136005)(9686003)(26005)(66946007)(55016002)(558084003)(2906002)(66556008)(66446008)(19618925003)(316002)(52536014)(186003)(71200400001)(33656002)(478600001)(4270600006)(7696005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Jztzkz4i7BKs6C5K6Q49pTf/faEvmj0kPBKgysrLL5dpGbg66CbBuj3nwtWtJZ7YkjUI2Plog88wW0F8FZ0VxTWRxhgevpk75H9WYPQ9hsGr26kxUG6jS6yL7lRZJy6mNYt+rzWLjUvkayMNliVGpGRfUxVBqdsOM7+4AOH5DE5BV/u+txvz4THRrAcmNwo1jv0nehYg7FiegQw1UG31B31reO8f1bElKGtK3x1xx/6Aop7mLA2LmCKVxcCVjEBMeKi0DGWyEBKH+W8tVyoxh0teK7QP9hC8qOFZNaUWOi5WNRuSj2TaZiAWHyvqjuL5D3YIdXC0EWi3JPMaZ5ngJ55XkUhIUP0RnLOpqtNF91mGp6XMWWpooG1q6HtHq4utI80wi2rCCQu3SVFEImR3vQkAwW8CzB0X+nm12DLXOTSSRZT0qtbDD4JKr1/1y2y0l+VSYBbGFJ6iPPUo4kSYYzSAHrrQzzdZ4+ZAGbzXRnNFTTMtHv8nOGKQw4lDpPw7
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3569303-2159-4f9f-23d6-08d806d302c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 08:57:42.5404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ktNhhpIFu4xG1JO3/DnulyHG2wCoCY61D31uSiVtp9AHR1zTlBMARdAIrU7LqcQQPo+RsCItH2jb5f06a70ihA8CFIGPa6E4m/OnaxZDNf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3695
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
