Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7112F3B9FE1
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 13:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhGBLjE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jul 2021 07:39:04 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38301 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbhGBLjC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jul 2021 07:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625225793; x=1656761793;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vUoYx26049clT+cXiwlsnrtTKX/owQ8JCpu71caUlUg=;
  b=gEbKk8S1HK9QYcYnoVHi+FmQ6OehdQcjO7LYiDJzNarCV/GFsct5Cfvi
   rWzYXjENWB1/3qO/Bsob7ilnTaM1EywysE5Q61iBsJIoA+lpwoHfkietv
   vjHr71LzcpJMNx4YRGrpGyt42yBYnO5J1rgEE70KO0cK0xFmI+ZPGZU8U
   kGrfg1fWZocP4mJ0U07UK8h2V4NcFXjD7yOYIPk2xhazZPrh2g2A7aM6e
   EiQQEiBDxt44Y8NOmkAnj2KvtL7GpUHVwc2Lg34VFO0coRnNAjWEE/HBO
   i7gBCWLZixdfCXI4jVXc9FVQuJ3xlcWkmpe25Y7E5g1vEYncf4wNnSPtB
   A==;
IronPort-SDR: EktbioQCuadSikahYJkkUPS9DRd9wa4DgGdfPIeQjx1m09GW2+9uQO24MCuBINOQPFuXEqIEoY
 rXQUEv7Az4azcSXOSqMjX6xyEZdDKtftF8l5k4CflodfFWI0NIf1QI9qlfMqyapbK8mIu/YFY0
 eA0CBdKUCpub+R2HXm5YwRRzFynT3rzlU4WP1ynZfizHzF06kkz7yBKRUEPjBjk95VOhgkDXMg
 fgYEd0wy0+nOCI3+tqPD7QiINp4+1rkDKODHqp7MmcY009qX44HRFGJygsbwI5eSmwgtPuisOw
 IZ0=
X-IronPort-AV: E=Sophos;i="5.83,317,1616428800"; 
   d="scan'208";a="277353076"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2021 19:36:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6jlD/daDsAUSFRu7rxNfD8dspMklAT8XJfyssZJqwDAccnQSKd6IOWNV2i9LICOYPf7qlWdhe1+o8nBkh1F5KvDtSKn/qp3qgEh0+OOQOOaCFBU7bdH95/pil/61qobKAHJnhur2Cn6dgwFxzHz42csvkXnlqGr+MjPMS0oZsrdonyXrsFb5HGuUMPN45pkXYGP/348IgqU/8YQbUkoKgpF3GVnisv3FLSAUU2Jzz2Ti4t0Sfaw8Uah1/M8aIR9ZnNOd4RI0a/lOLoOkRE6Gh+FWsk/ouJQkQpYkwi4067JIr+aQWeHzOMGwdAIOv1ReiWKcGSlyZEfoudnbFqqGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPB1L0yaQKCqEhHfm7NIb2cD/eze8mDOezeOefiWPiE=;
 b=WnGPXEdDjH7ZyTr1L6ipcMfHWaIPGhhdYD+8ctPU65a3QRdhp8qZicOcPZJgEv+Y+HRSb4b7WnYpRulJ/aHIft6IQ/HHLY28TZtIFt7uGUUPebTwb2jjxei8L0dXJyH61hc4tt3yWeR5NgwB6DUtAMnyrxgLCr5oI1MPrHRRrE/FOwtoBQGXdpWUyfEFPfYNYwYBDsyKc5RVttyr++mnLRn7sdEyBw4RvWcbUiZ8RQLLOUddbRu5/ITYxTEyZg1MfoaekK7ZMNMtLL/MnxHPGxBIIbfwpw24sFD7JFkZ5ASCDmcJrp+JKQXQDey20fJ83+VGZDJVEDxKevb1aXfXFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPB1L0yaQKCqEhHfm7NIb2cD/eze8mDOezeOefiWPiE=;
 b=zC10sx1tYnTRewnFxsMqxX/OddzEpQvXXnU8UNSuve7mA1CI3gx672hqvXzncmAYmKlxAtb3ccIigWF7vBjeFcE0LuKbYX2Zm4AUufQqlHPq1djqLIRvZFqfB+LfIUw008HJdJdbRqXgEFScHuaMnkyKe0cpV99DYU4z4bP3/gk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7496.namprd04.prod.outlook.com (2603:10b6:510:56::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Fri, 2 Jul
 2021 11:36:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de%4]) with mapi id 15.20.4264.033; Fri, 2 Jul 2021
 11:36:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Neal Gompa <ngompa13@gmail.com>
CC:     David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2] btrfs: zoned: revert "btrfs: zoned: fail mount if the
 device does not support zone append"
Thread-Topic: [PATCH v2] btrfs: zoned: revert "btrfs: zoned: fail mount if the
 device does not support zone append"
Thread-Index: AQHXby0hSgBsQVf6PE6aFWUru2c4xw==
Date:   Fri, 2 Jul 2021 11:36:27 +0000
Message-ID: <PH0PR04MB74162E658904A1B08804576D9B1F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <a6b7c5c38267fb410a4a4f711e986c863790ddf8.1625221720.git.johannes.thumshirn@wdc.com>
 <CAEg-Je-Z0pWzEpe+Ym=gwvH+=fJwSOo4nE9hc2EfCXcQVMKXCg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.93]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95731bbe-d749-4a1b-ccd2-08d93d4da176
x-ms-traffictypediagnostic: PH0PR04MB7496:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7496ED91BCBCAB5ED92EA5849B1F9@PH0PR04MB7496.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:366;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lwwi2ggy2mBftXTn/WWRgok1milTHX0PYV3BYwVvSAEm58x2LDrxwGuuldMdSAykTw3lkKfSlnbYbhRq0lMvVf9AqC4BJS0t2uqkohkN1em2M7VS3snUAkO68zKVpv70DcCeGm9kZ6FMeEhErCyY6Ap4yldV7WKMfrDsuDZr0EITjDvF7Nqf9xjcRoVv+VqeDN79n36HVYsQwBoT2DhAiC6zn0/hvrluELO2Ji46YnXup9fdD9lCZq3KctWi7dP769fWxxXsD633Jurqb6yJBcG699hSGVS5v54aV05PihMJSj+OdmWFcWr14mve4YUQZCnA8mXgOKADFC7vX1+fYXRW2INqBlAZ8o68abwZ2/r6DpN1dh67pMjkfxj71jRbiWoR/hXAXvDQEiJ5sXVm5O/jEA8jbIzr5+9FovIUP1I3dyTmB/U2xdpF8QpMkeWuBgRqPGnlnhtjIw0XQtl63kl0PsXoju8WkwvPouC8bvPyBKmT+p8GSbTBYLvV8KGdB9P7W7TZvxs9jQAfVpiSJebhGezNvK+gXa1OW3M+1zu/2vy4/QGYOmRXM+ddHXSO0ld5ITloKnaODg/BTNZoIVAxV65ZeWquC3wx2KSLnFw21f6ZAsuqHK9haXGdAg6FDtv5kfgf/YIGGF3e1adTlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(86362001)(76116006)(26005)(6916009)(4744005)(186003)(71200400001)(8676002)(55016002)(9686003)(2906002)(4326008)(316002)(66446008)(83380400001)(6506007)(122000001)(64756008)(478600001)(52536014)(8936002)(66556008)(38100700002)(33656002)(66476007)(5660300002)(7696005)(66946007)(54906003)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?40WPdI723cRxAsuD+EnQL/dq9840BkodAQkFTZREZl7s2n/PI+mysHkPGUyz?=
 =?us-ascii?Q?sbB3emNIwbbARVTt22LapcZC3bZEf83+tBzcakLH5xez9TjbKOqgn9KBQ/F8?=
 =?us-ascii?Q?WVCCYW8+gOP3GCkfApFI0cc684zwVVDBb/IEbvkfL0bBahRDAmEb6JfJQKbW?=
 =?us-ascii?Q?79QTeEKbZEF0dQ5stXkT62laA2hsy2nexKHeTZJm56ZkKqYpjddLEKnLQlAb?=
 =?us-ascii?Q?9SWGEDmGtwdwMs85aAO1Fmv7joMJ7Qb8v/AKIEFGP18Zwyh+csLJKjQQMZ2S?=
 =?us-ascii?Q?owvHxEyVzTLVAYNNjIwfFIZLdG4gYqXrPlv1ZQeoS2HoLcsdcw42rQC4ICsu?=
 =?us-ascii?Q?tmTKXZhgaVQPCMxKq/J0afPbV+p7joWwOdvm3PKGsrRY4idaoo/0ycG9S+mO?=
 =?us-ascii?Q?z1n2gp+v6zs+EhRukGtfJh6kWpj6uvLlfFLkfll5pZ+vmG2KT1GV0q6mfxi5?=
 =?us-ascii?Q?jNsOowqZjcx65MxCAfD/zVrSc6e1jyooGmsBUpS2vjm5eE+pTqgTnNWLx7eA?=
 =?us-ascii?Q?mjtQbgv8/tbO5/b3c3jbYrVyzPR5UOAxFdkw0dJcXKmUcMUJ+KaE0nfZWDbu?=
 =?us-ascii?Q?1IKT6xmiq8rITZ2rTRAN2L5x3+BO2xuqkbZDCpHpciEHKhyTYD7NOuhheSxi?=
 =?us-ascii?Q?aiaURq2doTJecIuZxnl9gNJy6FX+f35tx9SuMENg8zy4VOhdXCt1Hu3n7uzY?=
 =?us-ascii?Q?QOow40Hph79Q+girrG95dMTaOaZrtvb59QIvHjs49RfeVh3qltqUeffIqrLN?=
 =?us-ascii?Q?a/NaXz1LUq6J/woiAj6lXU6gSlXuV2ABG9LNASP1WD3hJ89y4K0upoblgUn/?=
 =?us-ascii?Q?/0CkvHHnuhtXpTP+BbBoyDvUMKpG70p8Kz9swvYBKoVJlFjZprX/3SnYAE5x?=
 =?us-ascii?Q?UY1yZUfBL/ddHjjbF/kMSse+6Y+gzr8nXcjl8ppNccvY+OyskFsXnaedni3V?=
 =?us-ascii?Q?VMukaUrF2175pZwS6Hd6YkqcQ57SjGVr82rzSb/oBqCO2KJdTOOOYwnULFN+?=
 =?us-ascii?Q?5sIMnOc/5p7G1q1OzqbHB4n8jiWdPKe9hFkq7Ao+IhDN0+Qd7pGvwldWmJlJ?=
 =?us-ascii?Q?XeEA0cCPQeXoVax4w4kTgXAU7AjIz6VqkbEvBm0IMxxBo2Mzb0uuc6h2WkcJ?=
 =?us-ascii?Q?SOnm81cItYwYQB/jx23BsSA5WKT0kxnsqtiTtb66LFhZoAyUfTSJ2XBK6s+l?=
 =?us-ascii?Q?U/bio6/FGrCSom3w8BkbAr61lP8b0oPuiUGoIly45U+1CM8ZUF0/zyR24pin?=
 =?us-ascii?Q?HEgvTXGMX/B8XEUtLVGZQviTf2AFCB/B9/WjWa+xTbXjghJden1GN1ygkCuL?=
 =?us-ascii?Q?/jopDNtVATZjw8wJwVprEEW/YgxX1b+tc08LqGKRVjfHCA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95731bbe-d749-4a1b-ccd2-08d93d4da176
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2021 11:36:27.9134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4g0eXZ81AD9LV412R5XsJtTuqeuE3pgq9ecyZ0hXIQ7yDtOCADEG8juk9AXFjLTx2e6VHDMN2Gmzz06GCvQsqabCvuEfCgbJR3P9J7sWWaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7496
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/07/2021 13:33, Neal Gompa wrote:=0A=
> On Fri, Jul 2, 2021 at 6:30 AM Johannes Thumshirn=0A=
> <johannes.thumshirn@wdc.com> wrote:=0A=
>>=0A=
>> Now that commit f34ee1dce642 ("dm crypt: Fix zoned block device support"=
)=0A=
>> is merged in master, the device-mapper code can fully emulate zone appen=
d=0A=
>> there's no need for this check anymore.=0A=
>>=0A=
>> This reverts commit 1d68128c107a ("btrfs: zoned: fail mount if the devic=
e=0A=
>> does not support zone append").=0A=
>>=0A=
>> Cc: Naohiro  Aota <naohiro.aota@wdc.com>=0A=
>> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> Singed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> =0A=
> This should be "Signed-off-by", no?=0A=
> =0A=
> =0A=
=0A=
=0A=
Indeed it does, no one want's to hear me singing (trust me).=0A=
