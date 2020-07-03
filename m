Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A10E213A9E
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 15:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgGCNGz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jul 2020 09:06:55 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6588 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgGCNGy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jul 2020 09:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593781614; x=1625317614;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=r8Wr4JaFCG2MQoFSLIiQNX5PrfqqGsHjKOvxqTCEGany2K05FClhxliS
   nh9VS5Zs3IZ6TUvT/d3GpkaeW6mNv5rXpXHtvtPM77KKJRG1elkZM4q3s
   zg/wf3Ib2EQeNsS59pYAOVXErgLAdpGy3jRCAumNGZr7XLqbqY+N+FMrq
   LV6i/ZJOS7MsDq6wAJniFFuwFqmEA/MDgIf7yLPYDlm7juiBcho/ENn34
   fwfQXT0yn1gpiEp7hz1CXtsOMu+ztg0l5Q2a+TliICn9yZ2lVOvl0Ej2v
   8dHBIIKBTVXD0Zvj4u5iftEmefulRLWpaIdH+0yoXpwVC8q5FpAebU5wk
   A==;
IronPort-SDR: QG9atdXxcoN6+ViaGZk4irfhzVswe8oQx68eh83Mjsx6vThS917DzK+PE13ZB50dr1wmcYqPoD
 ctZatUN/oI5/dvq6FvAUJzeVNPQHmnYd2u3Cxocz+dE4vBPe1X+Cqi+2oIIZc39Y8JpagjDrUK
 8RfrotPRYKr0iI2ZLhMh3GqXdQTZvcJp/sQUaxSPk8EOKxP7X7lo9ubjlbS/osFBi35uepBuxi
 dlW/y61gRnu7T9hnOQI6AcPX8IzaxOfQQt5eRYbMab7eXtznsbWOXy56a0K5YDs8ayIXRI+NvF
 uA8=
X-IronPort-AV: E=Sophos;i="5.75,308,1589212800"; 
   d="scan'208";a="145908950"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 21:06:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYvxgCRFgTUZLxQGHCr3lQ5BdZ/CaCcPZTjAHq98U9QaG/jVUrnOY6gxIm9CWVhKY0wS6YqnOG3lKUWcRKzgKQ9C7anS0yjid2Gi6d8b30c8Hs5yeBxQf2SZQ3SsBKlG+4OtApnwkVXEdR1c45wQYM8k+hfamrcKoTApxMjqCP4fXelZePgzf0u863J6gGx7ll0LoJ8CdK045N/uqBL0Bw+1H6igzGW/tWgLzxvg/tsMTbvOMp7Ez54+RZ/ar8Ujfr2LK1MDJvBOoTyQvuem2sCHVszgXI6ThRGUmNfaxx/cfY2XEjXCCp/y3Efmug2/0G4i1fzLyKKOvLZdW/T8+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=lVjjtusmGJ5YiWGpvAD9u7rVMvJSHPl91tW5vu07j6hiQfR+N2YB318enPbSotGp7vpHyEBqnbacjTPZd3MNGURw32Iz4aU/QA9Nat1qhtoppT0mlrT6+cFbFcX1fWU4SF79Ujj44jY29XE1YyfF/FBhncooWAJb2XQbAojb5S/7xekuouhARIqjr+mJVMi5asOTp5NgGW6/Rg6RV6cum5n2eAhhjHnsKESmmuzXvGw45IoC91XGRttbKPYjuFgjPJ7ijx8WWdExC2CPzaa7xcNSoyDdCxF7hT1B/S/B/xT5aWwx957r0l1+RNEWQ3rleE6Op6u8hbFDP/1/FcK1KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=pjf1fFwwdVBCKKapWzmJzsU/kftZgx7IB/sprqiHsLwhG68bYdCO+K5RQF5YgDaDRPz+CDkz3BqWGyW+ovdKeZrDIg2ysl7+BawOjvVgLUO0NGrXw1b249kCyHD13zh/ohRfiwsp+7Qy7wftlbp9CTJKPVHQOVmYZyoajWhqAjc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3518.namprd04.prod.outlook.com
 (2603:10b6:803:4f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Fri, 3 Jul
 2020 13:06:53 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 13:06:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: Record btrfs_device directly btrfs_io_bio
Thread-Topic: [PATCH v2] btrfs: Record btrfs_device directly btrfs_io_bio
Thread-Index: AQHWURIFP3ZL0pxuTU2J9U6b4n1r0w==
Date:   Fri, 3 Jul 2020 13:06:53 +0000
Message-ID: <SN4PR0401MB35980A0EC4BA7EC5AD3DFDA89B6A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200702122335.9117-4-nborisov@suse.com>
 <20200703081427.11984-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c8e3cf5-341a-49a9-4c25-08d81f51f4c0
x-ms-traffictypediagnostic: SN4PR0401MB3518:
x-microsoft-antispam-prvs: <SN4PR0401MB35182F12AA9C3B88B16B23CC9B6A0@SN4PR0401MB3518.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2EhTdP1TFy9rNmUoxjOHuCM68fO0wMitoza1bMn+0IwWO/eGCZTd6xI9TUjE/N18eID4gtTlnIufMekdh+PIVWIlwChyPoClYkoTSnOd9vMnLdSm7MPEeqrx6kP8ZbZbrpHoq89UE+UGaCVJmfED+5akcSzrNRwmgvLOA8ZheJjNHne6YtumDWiu5qFW3kXyMcrNtIbAkliJtT3JuF+CIamaC6JaIsmDf9Cttg6hP0TlNvSBb/2Fjh6a73pGXW41xbyO7A5xvs0Yg0hxTFtIVLg8S41tjycHRy2SAjfaSRIznnDuloSG724TDF/8ADNOMtR7lXxC/oq+O/ets0CvIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(19618925003)(5660300002)(33656002)(52536014)(8936002)(86362001)(478600001)(66446008)(64756008)(66476007)(66556008)(8676002)(66946007)(91956017)(76116006)(558084003)(4270600006)(9686003)(2906002)(55016002)(186003)(6506007)(71200400001)(26005)(110136005)(316002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: h6rZoQ6me49kPPGCXEChKnZC4jiDa1Ei+K4LxwhEvcJHCTmY+OU6atLEQ9hPPbeYA7bbFNDkt6YzrgwFpISsi8muxTDhgUrbg/r4k7vmxrU73bIx9eHaE2KTGnJXrcVgSXGbAeI84MssFE6FndOpRcJ+xp4PShQe93uTQUmqlljlcVJEDENtLLZ7Hv/8im8gI2HdTOavqfhwcUEAWWdu8gJWNfciNnIaefoFAaswW8uVfeNbuJzxLaBFpUm0ZDuy9B2HPnFSqo4PhHjHmTBvUq808PGqdzXpKMWvgOq75lL7BI0tpyBXhax92c4dAbLB4//FlC6yJD6bw82Tk3OHVH2kL96J3W51GDBYBEEA+7b9q0GA+VphtbNod5LvtAcWQ8aINd5pfrXTG18k+orPpkS9Q2wVoywaBc+rB4MmZWkVwE3PJppfY+e0JhffIbUt6j3NgNfC1KeRpIFAiQoHnZ/mvrObjnQfnmu6SMGUYrRTM3Es+1HaPjm5OauO8crm
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8e3cf5-341a-49a9-4c25-08d81f51f4c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 13:06:53.0338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zKeeBr5Y14GjYZBDbai30KG36+XHcderT8xvkqTSxxSdTmjrB0rpjUTkFemNTIddK01BkKwKno5zsUDweWCt/UZU9qc8GEnvRYj37nd5hJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3518
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
