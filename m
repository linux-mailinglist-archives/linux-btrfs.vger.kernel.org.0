Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3131F4F9A
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 09:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgFJHv6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 03:51:58 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4390 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJHv6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 03:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591775535; x=1623311535;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=YbVD+8hwHrt6CHhnPNt+NaMRlO8Q2zTXPD9NFglhZRM=;
  b=ZLWehRZ0SwDmO4rDa78CbrwTrjPsIIOIsILlkouI4NIQwkgllGylKCIB
   J/sdmhGZio5oLNaQQlFxg3H32rYvAAwL0NV/HRjI9ALrZzhlQbCM+oI0p
   BhjxuwMrsBq6iYki8rwnhllG3EN/qhk+CGr/Yw0m6GD9roWLqbjuWjW4c
   OyHjwWv8PGUgXVphPbFCzPaZ6qOiFFmEFqzRrfFxcccuJFkFmtswqEyL6
   W3Qgxg9UGOBPx1HCBb4i5g3w1SGoLvQtjVaHsw7AL04/iAZ2RjrujhxN5
   UzPA0LiMOCN6jyIUr9hYshpY9aUWZmbOxd9xnE5NhBIeiE1zBse7lBQvz
   w==;
IronPort-SDR: B65Sz0XW91l4hJhORxT3D0GcEqSevt6bSOnKsqhdKwolt6XD0t9bF1PgXxSS4PEjYLFysqfrH6
 5rSul6MK1Hye6fkpFUmZRj6TmVAelpuE1o+ThxNtsWiN+w/BETUkKeUjNxQcm+TVfNtysP/f8j
 8KkTCV6AWsSn7d3+J9L3aW35hYKYvntplB4AGs/F+QZ14fgJSaYCyF9IWZul1rJHtfJVLA6+y8
 txX19NwJVMpraUHXOYDZlnLFkY0J6WFSLP2cfMYsqB8498g4Cmbl/azVpJPQm1eQq5H/bK9Iu5
 tbY=
X-IronPort-AV: E=Sophos;i="5.73,495,1583164800"; 
   d="scan'208";a="242527026"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2020 15:52:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjyjVMLr6t8kiTUnlgUq6zxzzXwLLz4nAq+zmxh1hEypQG5sDFByS4SEr59RxeJs10v4cgOOdYsu6aSb25lyr9hsexAX4rHWJD+zEyMT3+El/3BN8GZZcROGTsao2hzxhMYqCpWzkQ5K7ir4MzHrOYgZYwuJQXMkop/BTzpdR6O93VyVpqqo9qva/m4YKJPZboVsBX+Qo6864noImaBmORIvvpT7Nytos1Wche0yo8W0/B4osIkXpRSUbKt4dYvqGax3ffjUvJVzZvhLHgq0itx0pfNIXKOPzE/Y41IZidfGtVVWr7rc0vygWpHJgPptGJUsjoZ1UAvlDWBVAnIhdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbVD+8hwHrt6CHhnPNt+NaMRlO8Q2zTXPD9NFglhZRM=;
 b=JU5NxMvOWgXJhZxlFs4ueSkEOhgG367gzzFs/Auojk2/BkSzm6sK98lsL+0x+r1xZ46BSJKuJ2J4frbTvtI6fQPfth0ioM4EkyE7TQGSTgEv06Xk9ywkMD5w3Ue5SwpbwG3naYlLg8PURnemYHDccI7rjSydrvUQ4ikjnuz15IKglSqlGnPjcBoTROg3DqU3rcWyR96MCJzY+IgnShwZAqHey6D53ZVfhBnYrh3u+7+cwL3AhdHGU8jaU+Q9z/+UlULSYcQvBIqx14dI1INdp0/+ep54biMB70aof85K7SSVWAb7A4e0jmrDoHtPlPGbJBOmTxaCMGX8BDxVr8bMeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbVD+8hwHrt6CHhnPNt+NaMRlO8Q2zTXPD9NFglhZRM=;
 b=fEq/FZsx0aWgnmqlxnMWMw5wYlRCNsc68FXY1QU+QyoIcKHoLjAcuMw1Mp6X2ekYOwWmIauIq8HXi25lHYOOmAKbQykzXKPqN2wUPNImdNHcwMgJE41ExdM07wAlJxgYSUeTXl02j+esSQXHViRPL5FO0fCLQv7aCPtly575Whg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3614.namprd04.prod.outlook.com
 (2603:10b6:803:4b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Wed, 10 Jun
 2020 07:51:56 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 07:51:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: add little-endian optimized key helpers
Thread-Topic: [PATCH] btrfs: add little-endian optimized key helpers
Thread-Index: AQHWPpceRFLQizgXNkeOWFVe/rES9Q==
Date:   Wed, 10 Jun 2020 07:51:55 +0000
Message-ID: <SN4PR0401MB35987DAB480E00C23708C7019B830@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200609194926.9343-1-dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [46.244.197.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da9c0067-f2ab-43d6-e26f-08d80d13259a
x-ms-traffictypediagnostic: SN4PR0401MB3614:
x-microsoft-antispam-prvs: <SN4PR0401MB36140C87F58F9C42231C9E499B830@SN4PR0401MB3614.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0430FA5CB7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vzCqiTtD1MSVFS818Rka1+okQ81BburWzAVNzK+O0e0eVt4lbeB8xfbvsMweQnrTWPE6sd3VJ394iwQ4RfqZlsRvXVeLT7TmPNuBsiQGFScXHl8aYxRhYJfjXWAnkty1Xf1qs59ln5Ymxmf8dr3iDzxDnwL8hllBThNmLyA66NdywMn4aLQyZS13DIwvnCLSz+d/p0FQfrMOOIP1ZtU892DsNAhgc+OoWjHhzxNqK57h+bF8JVgKT8+Rr8VZCKKkZXHkei49gc2A/RJ+vxM0nIqGXUnmiuVbR+qEQ3SJubCxfjk6z2PHGm7S+G584iLC4YI0J9ynkx2eUalB3O76VQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(5660300002)(6506007)(26005)(66946007)(66446008)(91956017)(66476007)(76116006)(64756008)(66556008)(33656002)(52536014)(86362001)(71200400001)(7696005)(186003)(316002)(55016002)(2906002)(8676002)(478600001)(558084003)(8936002)(110136005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pB9QMMvr5qL0wEZOnLLcjopvpU7RYX26oJtrGUJemP99Nw8sUS6F3egz4AvQiuLbQIbnuORCMb9K74oUbJBNFtvX8bUHGs5LVCjYKSV9/f1TPbI27padn0uUNNw/b2nGWsMuJDj8+iI1fdrnmx4fnB+5wv6eaqA4b42lOP6PIBkBd3MbiMuFkSNuSTweJTICMCuPKbPMLif+1ry5qsos5rwiDtJb5wNo4Ysx0r5IZpIw6bXE9Pc3ezqPkTARo2AIj+A6kvnQkmr9pO46MZyaswKWMFgXMzVTGKL1IcQvvIOSzyA2MXuoE5mu2S7JWBkx+HcnsIcs3mcHG3sUEoZO8nEybZn+hacuqOuke/J8r39XgZ3k9HuXCrCOBn6maHr1HEpkVg7yD2ArRmJpcCKbTVDSNSEProck/H/ZPAR2neznHUkQ+oeRG28vsLQvt3Vqn1dDIXp7tb8AB/OOusNeq/m/WuvUZMJeb/MsdyyZHAsAcbI2tLTMPiRVy8O4snXP
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9c0067-f2ab-43d6-e26f-08d80d13259a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2020 07:51:55.7923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lELE2015yEYSXXaDL0nk2Zc7EBS2aq3JibrrILZJ3qY6omzwbMzAB7CLZ8XBrRl1jTgw92XfHpgU0YFdjYNdqiS5WyrBQLRF/5jbkXTduII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3614
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

One question, why endianity instead of endianess?=0A=
I think the latter is more common (in fact I had to google =0A=
to see if the former even exists)=0A=
=0A=
Otherwise=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
