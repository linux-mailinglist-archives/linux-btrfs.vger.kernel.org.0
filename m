Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9961C516B
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 10:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgEEI4w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 May 2020 04:56:52 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10336 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgEEI4v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 May 2020 04:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588669011; x=1620205011;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ktpmxeIgq5Kaer8kr6QoveMa53LtNu1HSPWz6pcH/8Q=;
  b=edXuzQfrUEku+XP0QJOqp/kkAW+QpoPydecoTo5dlMQkpVZi+5brYld6
   OVi14K7noQodTQzyDL07EM83fnWZQjPMqQ4LipMa5R+Ta8ZJj5hTkCEj2
   G7kz0Ys3m7Rm+1sFYrsKHU7EZtxHmtfqtFnQG24cnhNuxDDHuME9rfEzh
   33VyTkQwIimeqbKDoRy+kJJMfGI6axJW06jJv+ZnNiFymje99LcCtKtmR
   KjTTK7Q1cq9mUuo+gHTT2RJQqwKDcbeTDAgcreacOCdAG/ECsIlYmTkD3
   /Bj5FJ3u4XNpl5T6OJe/Fp96NyJE9ysGhSky1WmU8iRr9aiK8K/jlvoW6
   g==;
IronPort-SDR: qTD4ROrXW9WPtBe8asONmD3+AdfJEfDn+D7r7xrJg9HVvsd9C/e5hX/5m88NPEcCcpRY31pJRA
 lMRq8TLqATgzn84JbjwDsHQqi/zppo8XbomzDB8j3c7w5ywfojbsw9AJFcegFahiln3fR3/T8Q
 92cF56pN2PZ3tRcw/4hB++okDJ6QZfDmBbdWuBMRoOTPFNsXD5uV4f3yJvcCuhFNOLb7Oa5/O3
 wDJcAnAMrOanplk/nIWPedxyyYTR3g9FuwQ077zLGdEDVYZH/hLJs6yExv5+bQvrwbXNDd/DpQ
 sLA=
X-IronPort-AV: E=Sophos;i="5.73,354,1583164800"; 
   d="scan'208";a="245790274"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 05 May 2020 16:56:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCPExXtR4Fpj1qHDnSV9fcTATD4R99ghLzeMsDMHmTChcd0OFtq9jJmV6MoHyoBE4z2ZW1jeikJCIGU14m4iyEH1ib+IDTAZoT8MTs4+UVzp7lpfM7d6l8KHKJ7x4QZwaVauJIeCKlwpbJzeZ9vlQqwgj3u/k4I86Q9M+IuHnB3Lab3niogX3U6qFafbi82nOspFrnV7x0UMpd32bB8HRteXYjoUoJrQgE+pPjdqXCDmTuWuKgbBEK+b5+k3eAH4T6KOaMWqNVpCXmhsszq9Zmti0IrtO0G2ugDK/Mg5inkKL3WdGtcn3rG8O4lCIluk+ylEnBDkViVfugx9lhFRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktpmxeIgq5Kaer8kr6QoveMa53LtNu1HSPWz6pcH/8Q=;
 b=A4W9wCh87/5VDcA08COdnBZ51ZqWK085weD4mou2eekGUzduSGNla81Qr4SMrsXseCNV8r/MBE6p9S+8BKogPCx2tIrIii1fREaawPeNahs/FgmIt2QEeh9Hd9bLevE5xd2XhXWUPbiMc09UvXc/+0wVfeHRqeU3I0UGaTGJgHINS/ZdV+yY412ffbibGft8NPprWQ/2DUq303MrJrqICFbTSXBLHQD+3JvSqXEbIqBMrzkkIJ5Bk3GVNj1D03u5H0X3n5x0yKueq08igCF/RFGaiqEc3gypCheYFs19doKk9VG5kbieyJdX1bOFVb2HjmLZG9FGIQCfCKjmF8QE4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktpmxeIgq5Kaer8kr6QoveMa53LtNu1HSPWz6pcH/8Q=;
 b=HW0zsKtsm3RCZTPCDtD3jCelsUKOqHimc5KpQ+3hpHeAABnKHoT+aWsUjwiPn8OuZwYDjxtLV4BFyDqeuxLyOVrOSDl68ncyJlabHkkxdkM00MMVGFSBhX9weyxag/twfqIk/U0l3TGXm2FbiskOJHfsjSbFkj1658XQeGRjaBA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4SPR01MB09.namprd04.prod.outlook.com
 (2603:10b6:803:43::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Tue, 5 May
 2020 08:56:49 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2958.029; Tue, 5 May 2020
 08:56:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 3/7] btrfs: block-group: Refactor how we delete one
 block group item
Thread-Topic: [PATCH v4 3/7] btrfs: block-group: Refactor how we delete one
 block group item
Thread-Index: AQHWIm/wBSuie6ZMzUeAbwU/sq/ooQ==
Date:   Tue, 5 May 2020 08:56:48 +0000
Message-ID: <SN4PR0401MB3598F0E81F9FAF5BD665B1C79BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200504235825.4199-1-wqu@suse.com>
 <20200504235825.4199-4-wqu@suse.com>
 <SN4PR0401MB35980F5B55AB37C71E789C1D9BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <bd019a91-406b-f913-1324-d4803f9b2223@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0653fa4d-f932-4cfa-233a-08d7f0d23f48
x-ms-traffictypediagnostic: SN4SPR01MB09:
x-microsoft-antispam-prvs: <SN4SPR01MB0961F5E8FD824F6CF02E389BA70@SN4SPR01MB09.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0394259C80
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1CdWBQdnbb3mwh7A7zyBg92MmLDLf234eo/gT9j5J/d1yNGN+CwGS7Dhgy/zeyc8UzW0oAa9nH0sh/7qDFY2iQ6rUrXthSSVDR27bagXdPIG3ChNC0BAe6ATMehrjTWofhBW11cjjLZnX/ewBC7IX1+EbosCzb98cu8BvpeF68QEXMyBv1NbuFUJSAi0u+zhLmzr2VakT/i0wbWhKSkNtfWXdheTTCz6pVEv+Vze2p7zkZ+2yNlyVFSU5/JQiA1vNSqTRPRk631+lY0aC61POYbVNl3tpFHLYDkGsxflz5GDIAZTrmTPUVQPffSxAnJ5sALrEMNGEy7+H3rtHzR6lcxAgEuZ4360SsY21X/r/uRaGEhFqJFIyPia5qIe07R73lU8WlQxgTYhplt1HhP3EX6nsfHMMcEPQJfMtsRgEvvTyvmQpbR6ljD2EhPaKqtasp/wwrnu6Qz6ymTxTIL+EXdGWRAlTdcT8XPFWG/aJ85ZixlzkjBXR1RaAibLN96gSgg62DprnySRWvbPa15syw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(33430700001)(33656002)(86362001)(2906002)(9686003)(55016002)(33440700001)(5660300002)(52536014)(4744005)(76116006)(66946007)(110136005)(53546011)(64756008)(66476007)(8936002)(316002)(26005)(66556008)(8676002)(66446008)(91956017)(186003)(7696005)(6506007)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 35+I7GC9vRM6yVdh4+mFpJyk/Uu3977IEe+jbmnQ77WYkBK1kFR3DmnQzX6aWrqYe6cimwIPsBk83zF9yrllRC0AOZaBD0lkYs1+9A/qNXOWNmyMlQAksnoFobsgp5LRuKNXnUwCUWJKwtejudYkHAeVTy00mvYpIYB6hPYjTUSZmj8uHo4TTSvDQmzw3439DD2rT5y8fNBKFHBChqVa54Nlrdg8ETRUD1Oj24rC20UwbOytuXJoIWYsZ3aCb27eLPFyVLPRP7wCjEbO3PSFu45Ito3dtFKcKvstpAcY17gGuR0otlg5+DZ7dM8UbfvJ2Ufb+Xt9IOfMTrd0JJZNmCLnNzbgwouyvGx+PsHYpuHO1BTzJfZ4QVL/aA2I7WIFiTOb6IgSGJOaWc2W1rxbp6kgETek13Z+K42E7hdLZiRt+XOpaAyT8BGzwTbOuGA4qj87ppwghjIX9QGDDhs/XX952NpUj11YqgeWjkLrEyxcv9NEOMwro5guVOBkFklSWwfXc31r691VKBcJyaAILhoVb3JZPAoao/ZCYxjFlQHypVXuUylcXRYfy9JpZvqVk00RwX2EJs2PhZbAHVIvtPSeYfPFn/ulm/eG1/rWQRcGxs+tEQJaSevpFSJ2M+A2fUkGaA/A/qDLwDNOZTllONtGJf65nehEB4UxD4LB8UU27Skh3Vt5UP8EbIR0srBmYfp5U4JoqwXjE2XlngIpP8BP05mZiTdZ0InkeeyqZg/oAKYpzgYFDwU6MpmaFBEDlG/DXMZXb03Jrew2C+dnPm0QAZB2deCWhwbjous0zrc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0653fa4d-f932-4cfa-233a-08d7f0d23f48
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2020 08:56:49.0066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z2nzs+6iD9s9+ugokQz22IUjlLJV4tGaIBVViiVusCxG7mtRfD11jitZxNoCKdlpKxKWuZD+6L4ouR9KW+NL2od2iQM1XP4g9e8jLiqxHBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4SPR01MB09
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/05/2020 10:55, Qu Wenruo wrote:=0A=
> That's mostly for the skinny_bg_tree (6th) patch, as in that patch,=0A=
> skinny_bg_tree feature goes to pick bg_root other than extent root.=0A=
> =0A=
> So I didn't initialize root here, but leaves it assigned the same timing=
=0A=
> as key.=0A=
=0A=
=0A=
Ah OK I'm not this far in the patchset.=0A=
