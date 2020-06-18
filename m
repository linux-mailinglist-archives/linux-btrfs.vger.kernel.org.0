Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A364B1FF177
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 14:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgFRMQm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 08:16:42 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:31850 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgFRMQj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 08:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592482599; x=1624018599;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zHNzbpXBADmGMcLPPrsc01cSqonj4S1SN/wkRU2ifo0=;
  b=ZMFyjrIpSNGwyzJVxI0ouhO4GpL1USiqFrHlVCUKCLmCvSme4Y3Dw/Ap
   Aw2JKTslF4oZIIAbM8tBC8JY53Ee5vm66Tb81ihV8kHYtmIEKxVnWqAwW
   ILUEY2qM6YmenQOJgozhiN+p/mV9gYz+bi3XgC2CW1882v9BhhuyFBqYD
   tWR502n2Jwpl8f6NtPzsvtrQ7D90ky4Avw26jrXYLczxg3NIYSCk6DwBD
   zb05DoZdhlebV/OuPufjqvRg2R3EbdQAoilnI+say+PMqbWbINKHHEMQE
   lU7vBhupmMbA6j/RATBrUoFML7IJkD7imwFkG8ODSq8mCcCD4nrB372+c
   Q==;
IronPort-SDR: 0qmP+CGRMFHg0kXEbwYj2I79mXSmvFY7L1ZQp6FHmBc55WqJ3pRrkt4JfqcSnuIuDchpSU0NYg
 sp8sKVXxNjsx+es+JjA8o+uKp7tnC9Y3NwlK2R/OBrq5F9UPiEEhUeQuXSTdKLsBI/7UhCLMd5
 xxlCnGCyTPNcTrjyz9ybUfCTlqfTZEIxQ+UmNl+iGX5Uw1gX5m1kFJ4sWjuHTMY5V4p6NyesYh
 g+qSx3bvsXelY6uC1TcG+v1N51XEjR6Pg1LQ7k96jNzZTAL55Uesz89m4GnU3NeqqyfhApt7ZY
 v/c=
X-IronPort-AV: E=Sophos;i="5.73,526,1583164800"; 
   d="scan'208";a="144633321"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 20:16:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDZ5ZN2SBCNVhlKF1AqXRX1jXt/wMIJgx+glMisQGvZwbgO1kjFb+5qotbTt+78UJMKvU9f9W/Wkft+XuxaUnrxt7p8PQm9BZEiQJxLliNzPLL1iS7anGQLUC9ch/xEDHdqk19WHBrak2qxVw3dPfkjCSwlx+zH99eDGSyQXl5s5BUlac3liFIvEZLK1ZpwGe8UeeGIvwMhxH0eGzffz29DnLWEH/fQgxa7hWyQbqdxEcwWQzlRu3aCARS82Z+iRD4lBuIy20Ve/bZeB+APHGLDnZy+DR4HAsLmJOaPNFyAvwkruF911dkbS6Q95pse6qYXhUcAIgNW8EtVzyOZUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHNzbpXBADmGMcLPPrsc01cSqonj4S1SN/wkRU2ifo0=;
 b=QXZA+1c8sJIhesqUEjbXkXbeBPHOlhxXEU6Vvdb4wbhVvcOJm02zJNtb2fxDFM+idEnqcK/q19xrZ5Yol7C/IOXRdclEms6bTVe9n9Y/OcHKAbt31Si02dtIJQTr+r+B2dIMUaSMaxDMvLwgB1ZasQoMW0BUku1Zu4tZiveC/qFjcAgJy9siFBhsNfIlLH0Yf2Ek5dVtOh/ALQZixwfAZok7h//tkDW64qfaHU+iuCUgfdyEo+baJRc7ljpXqhzd2WVcHWRye02wwV/LdxtdHheZMGKO4F66gP7MvX5W6qA9yQGIAJhcnPtmPjSAj6M263IA6BblgvnmV626SSLPXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHNzbpXBADmGMcLPPrsc01cSqonj4S1SN/wkRU2ifo0=;
 b=T8zRsWVH8z3lw4p5ft+c/2rGd4gnzLJn1k8x8HJFV/cQrt+3fBMwoXk4U7/0Gw7o4OiVC1nW7X22Jwm6fO9lJ2raBJ0Jo6UmMgef8V3n7wk3q+2rGRxRAt5BiPUko39wCdvKxJIWE7aR9gG0pUaMpFOKjTdnRdcJRKzZVKRPDyM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3518.namprd04.prod.outlook.com
 (2603:10b6:803:4f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 12:16:37 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3088.028; Thu, 18 Jun 2020
 12:16:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] btrfs: refactor check_can_nocow() into two
 variants
Thread-Topic: [PATCH v3 2/3] btrfs: refactor check_can_nocow() into two
 variants
Thread-Index: AQHWRUUTafZBr9Wos02gKYnIZRraLw==
Date:   Thu, 18 Jun 2020 12:16:37 +0000
Message-ID: <SN4PR0401MB3598A324B910017E234C31CD9B9B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200618074950.136553-1-wqu@suse.com>
 <20200618074950.136553-3-wqu@suse.com>
 <SN4PR0401MB35988624F5193F3102ADB1579B9B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <de3bdf98-0786-7c28-9ce2-1a9df889a213@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79631c58-75c5-41a2-30fa-08d81381731b
x-ms-traffictypediagnostic: SN4PR0401MB3518:
x-microsoft-antispam-prvs: <SN4PR0401MB3518D1615690E5DE599A6F5F9B9B0@SN4PR0401MB3518.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O2WftT+X+VtkXwTSkl2VYTiQZOvyWVMJxDceZGC4mI+YTMEZUoRcuocTnySALXQHNZfQi9c6UXgNF2/jFPUHjnDPdSVjJw4q2nivJ5tP7ybxyB4wnGsBTGSmN10gOJc2Y1Oh+2pclvGZmORiwIdGrcPvT5i/HgPJGskSyhapk/kT/1jLQPAqPHvPkDMGb6Od/UJG3OBRPKEUnfAcuc3/KA6ZRS9d9TJKW2x45lK67q8AuPILFRU+jaC2CygEQ54RgR+8WgT7qWCZgdugVbOQ+hV+5UIBf9N15VpGVZ9G4ZqKyQI+KI20W8EA4dm/2a3W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(110136005)(83380400001)(66446008)(66476007)(66556008)(64756008)(66946007)(91956017)(76116006)(86362001)(55016002)(8936002)(9686003)(2906002)(478600001)(8676002)(316002)(186003)(26005)(6506007)(53546011)(7696005)(52536014)(4744005)(5660300002)(33656002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wJT89iyNATrbl+xPxiaawiuOol39W7XgV+Y5Fxgp9fnGwpR/9m8EQ6/jCLBBlTQhLG3HeJGev8q2J8xnQfvUsw+10dF6oSrl5dXJqAqEVO/5VUccwLKcNKv6c9BFfGK3VqqzF6+XiaVrL8MXowkOjtAtdmNT6PuK78F2Dtep77B8me8uQP4fgwrjxVULnQU2RUalqGrjcsvaK0tO8hTxrgvHQ10e03ZDdsZbWpdtEZs/6ww9oPlxPSqRLpOMaYqIcXVxSSrMw9aouf3dnqRR9gEXa0cKaFzOPBbURG6DLjhEGBE7i68rbulDAjXTAnHd+YyEIiuCnfnEq4MUTpo0JtzdRPulJsqpCNeU/EoyF+T5G9TI+gHC5MsgzLyNLk07osUQgaBbvsNqpZi+AZ2yA+25xE66+5h50QUJT8d/psh4l0pMWKcqEYAKBt+L37LDf+RLvwIeWrSKlqHKJgCC7mjG+p50mvkC5aQa0Djzt+tx4gIlEB7ubC9nQgMMGpeE
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79631c58-75c5-41a2-30fa-08d81381731b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 12:16:37.4406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J2kZtt04qTlrD0Ss+mbJwCixYKpo2jM+6YKCkegouX1YB/KBM+XVq/zmPfVenkBATzjmNi51IzXQGNWXxvqo1Cak4h2rtak6XLf9ENi1ox0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3518
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/06/2020 14:09, Qu Wenruo wrote:=0A=
>> I find that try_ naming uneasy. If you take the example from locking =0A=
>> for instance, after a successful mutex_trylock() you still need to call=
=0A=
>> mutex_unlock().=0A=
> =0A=
> Yep, I have the same concern, although no good alternative naming.=0A=
=0A=
Yeah, there's only two hard things in computer science, cache coherency, =
=0A=
naming things and off-by-one errors.=0A=
=0A=
