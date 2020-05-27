Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D31D1E4284
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 14:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgE0MjE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 08:39:04 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:31850 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbgE0MjE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 08:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590583143; x=1622119143;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=YPFvawEXuxy/Z//vB/DRw64fJLVo9R+a4EKwGWg39ro=;
  b=hyvN0iZKsUFrdLuIvaDu9d1DCFZAAw5N8TTYqVG/yc11r20hKokQyEbQ
   6MB7cfLROTHrODi1GvMj/O3hUEvn+mM5rcH78TKClN6KiOjrE4KHHO6O9
   pc6KC04UDFJYBOYKZCH4l0iGBSt68s+JMY02Ky94XNuAD69OUd4vscvLP
   Gweu0dPuBN0sPtIiZEo4SM8HTCBn3nenx9m8dnRNYCcGv8A8kU+MrT6xr
   UMXf4gdUbuA0bB8iTDGRi7R5y/gmeA7ccPBMX/CcFT8R4imbXopF5etkw
   HvQsKVYCTpTNa5NTiMqzWoTQUz1r3CzOOFKjf/bgSqIp64A+R3earFNjy
   A==;
IronPort-SDR: S2hwIjRR8pNh6cIIS5WdEzwVWWPhgUzV5Qnyi2gY+7NjcK7JNAnBQwAfgkDYflSIdVKbinAGb1
 iTITjn9I07BaigSfK8S1RQu4vL4hxnCzhexv+qDrFyS6FA2yKDukvRHNVFraQOQVuSAJFpDTmT
 6W4bwq/sFWTWPiNqFqALPoXK1GXooq0zSDrpHwayuwEeoQIgWi75RQyhxHtE6GMAB24U3GwQq/
 g4rBYTjXc8ShFr7W9GIsPOhZTg77ZGtKcY6lJOPk6XOW06t2oet/0apzmsoKK2LVtaF7w55fZN
 V6Y=
X-IronPort-AV: E=Sophos;i="5.73,441,1583164800"; 
   d="scan'208";a="138614698"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 20:39:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aa8wkOaMojAIxYEhKmOozm/IauoF+zDpjRhPChRKB4mDLKzlbzbcOeARXkwH6vG/JMnLR9ftkUXC+2DLrqX+whz+Lm46k4Rq35CaN4B5pYAB6rFvyUyAWTe5BTA4BNgs0Jsbkr2/Qi8q+GDfzfRi1hXPsFlNXZM4aKVA4q3K7RHN/dKvOj+83KQoUeCiBLmXZz6SOfWZoPWKKlpquLwp7dbSLr0FPvgyx6NRYEQzYX62ge6qw7RKD9rBZLPw/F67fgaxpNANRn3SnHKXxNlVxd/oeCYZUJC1RubhRaP0cFb8OBZSXz9x6eIdHQdwEGPMeojHRm38tMWUdcL/5/a76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPFvawEXuxy/Z//vB/DRw64fJLVo9R+a4EKwGWg39ro=;
 b=ZLmtaO+OqlNjDk3WcXJE0t2PTOHBA+Tpj1KA3mV+/RcKNC4q7HOnmU62OkrV1xA7zq9o0MfB3N7ljpG72JWy+C4Vr+RDpAYBblvF3gsf2rPQNp3TltVYj29hqzBhTk6N5k579YjRjojn+UTqe1oCHjZ0TzNggEHXVJc/JdhQaBboDskwsatr2PV2oskQ9mCLbCrXd2qf0JqszmlzFxD66PiYfo70db+kBp/2P5nmBgThrB+b9SvMCL8weywxaQAWXq0zqdzOv0hq7yURqvW02gI38HCnBIAr4/xsO0k4+BEZgyx/4X7CrGj3QWycp4PJXf/6f4V1cJNiBntePy6U2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPFvawEXuxy/Z//vB/DRw64fJLVo9R+a4EKwGWg39ro=;
 b=b79YeIyPPpcyUo3It4H2GB18Z+5tGFeLHq+D5lx2Jy0n4ab3v67iqNLeOZDTtBAgx5k0cnheliDlOC/uyn8MLJvb3W2YgmCk55kqOcGbrr9lNKKeOHVHDnO0RX6mPyan9rAY+eIBn9CQMAS20T/p0Qzhs/XLLFbzIwNTt59gnSg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3695.namprd04.prod.outlook.com
 (2603:10b6:803:4b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.29; Wed, 27 May
 2020 12:39:01 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 12:39:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Open code key_search
Thread-Topic: [PATCH] btrfs: Open code key_search
Thread-Index: AQHWNA8hqY5plwE1gUuhgwgCTdFgPg==
Date:   Wed, 27 May 2020 12:39:01 +0000
Message-ID: <SN4PR0401MB35980C66F84370D7BD778A919BB10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200527101053.7340-1-nborisov@suse.com>
 <SN4PR0401MB3598A1745DF9F32092AFD2269BB10@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <d8b4ec4c-2741-f677-2667-61a249d37fc4@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7f54182-4ba8-4464-c6ec-08d8023aeede
x-ms-traffictypediagnostic: SN4PR0401MB3695:
x-microsoft-antispam-prvs: <SN4PR0401MB3695D193A76E30CAD79BD7459BB10@SN4PR0401MB3695.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5u+jxyzjJKHiaN7YowOr3IFminXMWae/grGPGrNd9QsUMxVDRvHfz0fRT0SLTa37Fd0/sYBGQWgvF/PbJ52OAFOi9mxXZvTp0x6NKJfzRH04qIKfKaeQkx03IlrTMxTIbYD+/pPqiuSg75BysN9JMWPtynqxP3E5j1pnCC0D2Vtmip3sRRI+/UhbIT2DqrHpGAEufNJrpvE3K5JffqX2JErQQLfEoGzVglVkRo4btLxk62W9XdXbndTcL1/636i1b7l0pwILVhf4Ajv0ko0rUsIEG9vPnHRsxGJv/nXDuOcmT92JiCseiommppCSfVtOyFziLpIluh6g20GP/LEo/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(7696005)(2906002)(33656002)(71200400001)(8936002)(110136005)(66556008)(66446008)(64756008)(8676002)(9686003)(66476007)(558084003)(55016002)(5660300002)(86362001)(6506007)(186003)(478600001)(52536014)(53546011)(91956017)(76116006)(26005)(66946007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: GAcA34aZOltH+1f2aLCG02FCVYBckqEZoU28EFrDyhtSIQhGkVsRiR09e2VzUeCnEahBHzxaIFhgdUr8MDbkaBsc9YFkwpUKSB6R5mv1T/QA5ouClx3muCR3cZXrlv0OCWmOJs8aeRWgPe1WYanL3zdz5cHQIrvqES4K3eJ/IrIwa7p7iFgXFE1edTpoLhNWwwpbco32i/ReWs9Ku8Nje7Jf3spqGoaocrpgMouUw2sjZkmYJ02Bgn/7bHLerXa8Po+A0UQrdd3W7wwAykSEPoGqwN64q4xHde1W+NG0FDt9iUYOjjyI9pYVu/n2CbElZRY7iDuhLOUsxdoN9fHYTPTOCEiXub6YY5KLI8Me4GM4mxw6U40MLeqMd4XDFTnXiLtGysdhT7IAW1r9fTGnXKkSSGShyhjdLve8V8tMurV7kGpeX20IiWeMElZ1midJzoDqcfJ+mhrQLnMxwtPtaEzFDydhh6fS6JDmnRVrOE0M5DUXMMvuTrdeyhzfI6Ga
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f54182-4ba8-4464-c6ec-08d8023aeede
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 12:39:01.0212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jxp8Mz2BAyFyxiwf+EBqVDu1lWyUdZu8ErOx9fq9Zm33kk0gP0ASdVyIriFc4MWEUk7bV1qXmA3IlUEujYqlfAih1Z2pxqX4eQfms7CacqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3695
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/05/2020 14:36, Nikolay Borisov wrote:=0A=
> True, AFAIK David is not a fan of multiple assignments on the same line ;=
)=0A=
=0A=
Yes I remember him saying something like this.=0A=
