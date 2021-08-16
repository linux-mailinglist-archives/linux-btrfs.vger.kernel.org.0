Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667933ECF36
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 09:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhHPHSD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 03:18:03 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:46817 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbhHPHSC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 03:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629098251; x=1660634251;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GNPQUpSo33X7Kpse1naadKqmbDug7sJVy07LcD82gzw=;
  b=hu6HDW3YX1O4xmGFnd7ZgR4R6TZ8Jcgpj1vQar4zx7MrFGlUrlG/bw3g
   IVeExQc98s1KyVvgTw6IRogOFoq1nttiJ1EO785FnNjyLDROBA+GHkv7S
   MVlPXix4owlNRYjtZFR3lmUYIrKZAcwlaP3Ftp8867Ijz58jS9ZY+cdYn
   0EFOde52MlqZAAVkl5aqvxepGHSsKh6mw/W574H1yzdmH0dKFzdjKAH5c
   skcdfkuo1pMdOwj1IsuQ3w+uR73A8LFT94ugNU5gb+j9bc5gIIFcxZfhZ
   dgWqcdHPFDsSnK/joznb1spmvZC8c6Kh2ngSL+f7cJnnWc2NzDnM2q6e/
   w==;
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="176529026"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2021 15:17:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hm3G/Ejb0JoMdTGk2+W4wm4R4yQyiepgQU+UlPKs+LU4lmZAamXAv0Ve/wsnMJrgCKDIsj5jRvjo7/ZGW+ZAjSx0UtJ7MTyFRtkISXs4V/eJerCSWUamcPxcacZTtsoGhUfSemLnbCjS8ae3GV6KqmxjErAALOtCn8S3XdvKhXm45DTxwjULYCX4qhjZ/fX6W7JcjL7pCQgV23UvWFmgxO+M7w4Ft+9F5m74Hss8bngLdHGEpMRFI6FjQ8f33/6QLf2LXm31LfHQNJVBci0RHEzvssQbeh+yr+PHYTw/pJaZxpFk54faNEC9Y0eC/essoOt5im7UgW5732I6ocB1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxmSAG2Cd4MAyiFzr23/th9kn3c+MuK4g4arejhVXW8=;
 b=P7pxSQZ8Leo2QT1UuRKIN0NZ2UtvvUx4xrwGXGfCxKRRJmwxyUHIHxaXlvemPiToQOUr497T9oKa+ESTzJ84RiUEOawTL/tjEqbX9y/sJwtlnH3bmsCE5tv89aHacgRKdPDWoFlJUFrVt2oLroYkH1ua1rA438NnfCQMd1a/dDqjbNE2tdYg5+jcNRNw+BcUgcAMkKS7SGG/hxmxItnRhJcUDiwjwAouheO2ndfX59K54kFEJfUJgQnQ+4+4dKX/ZR0bHWsXvKFy5SzqeRw558S+baCp8fuMMX0irpjbsgLRHHJjh736uRx9VNOjfinaLZtVfaPYey73BD23L08LEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxmSAG2Cd4MAyiFzr23/th9kn3c+MuK4g4arejhVXW8=;
 b=f8ZnNGoBeA2371OqyOuQqnRgJfo+SodHVV85KMhVv6QJTIxVmomwF2dWTom66InM9YyGFsVemJ6imfHHq6/TCcvuSpVjuRzGkVQVsCyHdBClpbSOhZvswlJwjVOPKKBUZJpyz9ZKqOH1FH/uhCY7ZarPzRf3Ba3tbDvvNmPMcf0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7239.namprd04.prod.outlook.com (2603:10b6:510:16::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Mon, 16 Aug
 2021 07:17:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%5]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 07:17:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: 5.14-0-rc5, splat in block_group_cache_tree_search while
 __btrfs_unlink_inode
Thread-Topic: 5.14-0-rc5, splat in block_group_cache_tree_search while
 __btrfs_unlink_inode
Thread-Index: AQHXkMWH4LEUBsz7Kkeh3XpihpIKRQ==
Date:   Mon, 16 Aug 2021 07:17:15 +0000
Message-ID: <PH0PR04MB74160F856BD39F9942E8C51C9BFD9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <CAJCQCtQEp1a=sf8hO7zL5PHz-7NLjMv-A2nXGCEkNCos+nVA6Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: colorremedies.com; dkim=none (message not signed)
 header.d=none;colorremedies.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6c6e2f8-4c16-4870-f83e-08d96085e048
x-ms-traffictypediagnostic: PH0PR04MB7239:
x-microsoft-antispam-prvs: <PH0PR04MB72399779A77367D3634AB0539BFD9@PH0PR04MB7239.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9B8Gz6+G7w3ELWusT/RRsGIxoKw7z8v8Gk9tj0v8qY5pA7m2CscX+UWlyt0wVsedqAdkILwiCr8woULhUeulRPZl5wnBMMLHKciFsUBbDSnZjE3AhI1B8e80Vy/O7eqWcVgmRuU8VHB9RsXa3flyEvzy7ShFNBS1XRRzttCeKDyrfB9UIXolCFpFOGC9yKmvUm2+Z0thVEFSaL9XjJPVjJt0EuaktHgFe8dStAKwdJO1s6IdUwwexjRqpDXgiI7pXeeMMJZuC78QKsw3dfrA57wM/+UqqD8m9xKRyYq7IEynCniCS+9JRUeu3EpaCI6ialt9DhIg1EkAC/Fx2tFYlXXa34jH4C4LPcf8gCLf2rQ96AIOpByelXHL+h1NAxND5I/pqRgtGD8kunxJqg8ruTN6Y9f2KZcdpaOGYmTdhTbGFAS5crJwirWwrMZZsSMKw1vQeVZUNfRfYuSDG0qhEvAUgd3PnmkgsRIq/7OxQSDhk7NdTZkvEYYw2nLfzC7y1tPbA8VjTMjwaiW70GMKZsBXjnavJ14lPyEBgJ/8nAclNzlDfAYh8rQkCcLHX3xGlWDWYtlA7hU+qO80c3Frk7XdO502Svh7m94PNF/JpqwnL7UqGezy3UCrGp++uu7AZfJRUwJk4a9hWAYHeB5aJrMtM1OLNhwmELj23IOp3ZuSkW6fUzfeWUSWPzTS4hXQYpc9J4sPYoQdAFV9n1YMtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(38070700005)(186003)(33656002)(110136005)(38100700002)(2906002)(122000001)(7696005)(316002)(6506007)(53546011)(8936002)(83380400001)(66446008)(4744005)(478600001)(8676002)(86362001)(64756008)(52536014)(5660300002)(9686003)(55016002)(66556008)(71200400001)(76116006)(66476007)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tA3FGJEZQLLzKG0e9ehWAkG1mqnRu16s/54o5KeQnLCB/N56PbFFqdDJli0+?=
 =?us-ascii?Q?AeNN4h/926SmKfp3zFcxaL6vO7KJQuYoYaYI/0WFx1sNrikjsR5IhoMpjN0T?=
 =?us-ascii?Q?cRlZXfJCEZEdtPoT+yTB1D0jfHYmlD3fkSop5Cbs0evrT8Gd1tJEfXtSMmni?=
 =?us-ascii?Q?D5XgKz1cDJLtfMRDeC3z2tKVClmlLfeRSkd6YJWeeGQYnx22DZG0evM71J6o?=
 =?us-ascii?Q?0q3Xr5BFe2rU7mqZy1cCwsg2CID315XwCk4GNiHE0mgt3LUr5eVqmqU3axdx?=
 =?us-ascii?Q?P6EzqEin9CR9NvOSwhwhZIW/cJQ7pdvH0RcAVW+z9EUzVjPxMLnEqwibp1XD?=
 =?us-ascii?Q?tNA/KI0b7DlYmydKqJdgDo/1fkCGz20K5+2m5k8QXzZpeh5zh/dncbBDX5NE?=
 =?us-ascii?Q?2iwNmYLKHkYxrDq51VSz8ID5z/hZ3+fvIFL3STD3wLFhcQEOf7l+eMAmC5w+?=
 =?us-ascii?Q?2iuH4Z56CJ74sYQBOkpHCFoyiXejiBcDou4KAIznnMR+s2ga14Hej0Wn5pWW?=
 =?us-ascii?Q?5A6v5bsMnIIMBbvJ0lfEILuLUo2lq6EXHVSnSAY0OgspPiCI6fHukCx/fzj1?=
 =?us-ascii?Q?BIWJPSnav277XJC4MeFjhCx3gFY5Ve+AmyClsFbjTh1hvcrEXldbFC4tKBem?=
 =?us-ascii?Q?0Psro6TzmBcHUCl+n7lKtq74mahQBhPVo+OpRXp5K86eZ/LY9UVPGjSlpBEm?=
 =?us-ascii?Q?FIFrjaKc9E1KS8mrEl7lPHC+iTwBQUBaiIuFpJUJGQxP/InAqIS4P1oi5KDc?=
 =?us-ascii?Q?fj1tZ+FPgeEZyjXs0m/UEZXNUAg9/vZcNifGUmhIw4cjV7KzguzptijylTDY?=
 =?us-ascii?Q?QhpJGvIJghZKsMAVnbEO0Rz1+kHdRFznxLdpsPW+xzVONvL0eqZLutMO3XpF?=
 =?us-ascii?Q?fxA5p+sDqsFJWCH1jc2zZGqUEdnQZcDgVRA+ul3aPxPcv1IUtUQV0CGtLBZI?=
 =?us-ascii?Q?chAnXyRwQk0dpSYIE/2wulbLun4H0jv+DLu58oNwCOPCfhLok563wR1S5n1J?=
 =?us-ascii?Q?o6oxQmjGdLIy8Gfa95qTrQfzuNboBX9l8T9jDrFLPIvMgbsPDYp03B2gDaGm?=
 =?us-ascii?Q?1FzF/vvhMonSK7pxX8cAMlXknWkRZGSRXhweetl4QswGjIwtaONf/ojWb7gU?=
 =?us-ascii?Q?5kFI6SOUwY9DHgJvc3qaEbpwS6+EZT22zg6C+ZHpu5QIB/yoQvVhG8u0AhUa?=
 =?us-ascii?Q?QZrM861HIFS65HC4nDYgevXja89M2VhPO6+bw2m691/oy0ukae9xCzakLIH8?=
 =?us-ascii?Q?nTCBPU+hi5dFmVCYHIGC+gfvfJy6vlSkd9atbrW8CJ/bK1rJHDvS/rGREHwp?=
 =?us-ascii?Q?++W6AvKdMRGFF9z6Wk96PLxgRmCB/lfvMCN+2EbjibQ6sf8DxWH/qAgor4I5?=
 =?us-ascii?Q?bjsiMvTkplyDcsDB0NnwyoCng7Sj?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c6e2f8-4c16-4870-f83e-08d96085e048
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 07:17:15.8037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jlH73pUzCDcnSX9AXb7xfXYbFYfcsm0XSoGvVCCc+bByK9IsiTvF77ZAyCGljIaFfbi/cd3Rjt2WTH9uS8AAi7ckrPa9bSjCco01DmBu7dA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7239
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/08/2021 06:33, Chris Murphy wrote:=0A=
> I get the following call trace about 0.6s after dnf completes an=0A=
> update which I imagine deletes many files. I'll try to reproduce and=0A=
> get /proc/lock_stat=0A=
> =0A=
> [   95.674507] kernel: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!=0A=
> [   95.676537] kernel: turning off the locking correctness validator.=0A=
> [   95.676537] kernel: Please attach the output of /proc/lock_stat to=0A=
> the bug report=0A=
=0A=
That can be "fixed" by bumping CONFIG_LOCKDEP_CHAINS_BITS.=0A=
I have it set to 18 here.=0A=
