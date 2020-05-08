Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260EC1CB03F
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 15:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgEHNZe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 09:25:34 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:40935 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgEHNZd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 09:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588944332; x=1620480332;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=M6ikkGIW+I9nIRtVG2MwcvbfwWkmtN1pxLBv6MjUiyDUyb1UwqQct4U7
   tLCtdfCJFbmp+0EOkFms6C+/LuMMmib4Mg3Nc2cKkcYmjUiFeXD2UZmDq
   J3GuXl3Jftn0GxHrR6goAvQGip04I1PZRJs8nUbZ90BfxnsRWZVkrx8pD
   +2mK/J8u09GZdZSyg4wPdbSs8WEu1kllwTgNQaC9m3ILLn1pVr1ifM1uX
   KbdhU4H1duCvUponQnDToQ1Iv2PY+uR+T6Gengqm/brZVrZ+lj6EQHM72
   8Wbi+bCBmJwO4lubjrzMd1miExDnpxRF/9clzEqg/8J3hUvkEwJ0+mkLl
   g==;
IronPort-SDR: NY/BZfqx8uQS3hEbVb6NKNPKwGxQaEMktYKyJq8iUPlQHNXhPX7dm5Jd0xgUmdYbEvUALfsf8B
 K8MWa0eJMwRcxzULpLwF6atn3KIHn/gir5463zc9bSDOxWZlS+6BcI1jcUwf6s4rZ1avqwNOau
 oAWX2Qiucu4iOncj50o+end4E09vdyJ8dNvJJREPjSlEMYuy5tcOQunAL3V1vJhQFddBpA5Wt5
 Qe22B+eKvgKk2jH+BbZV9TvEEXSjVuihyiQiBLmz+0FjOawOjgiMPTbC5lYKjN/CtG1k9gv9ZM
 JG0=
X-IronPort-AV: E=Sophos;i="5.73,367,1583164800"; 
   d="scan'208";a="138657784"
Received: from mail-co1nam04lp2051.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.51])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 21:25:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkv1z7sBuqiQEH9b/va7YfAgp3ZsAWVOAxPsFsFmV21D3C7d7lWyF0yEleU1V5E5yJLyDZD8/Z3ULU3H4aIdj2NY19U01PPgt1wUYRgaf8ZKT22OJUtYhYUEWSv1rvJXPIp/EJR1bM1Np7DY5oY/it6UR1xkRwVPzvwC8W6EvCqTvB+A9Z6uj9r5UWDd5aQINhfjT3df6tTDco5f709Vu+IAVjqE6KCqnKl3nebuQpZXWFnfA6cgA4XBpdSHJ6LCMPqSfJT3fPr48g4vJENDUI7IeT943sH+fuv98biGkhtsPrtI0tcMLZLYA5K1vvxygNYN5AMfCBYmsSJ06qGidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=HGC/HMbsEvWihZ4XQu+aM31NUZ5Kulhqg/FC6MpnImhYRN5mOpfM+vj46uibMgoHF3xr5/r4nwRPkwjcZ/rw1VAL55UDgOFhcCT1wZm7R7Jdv6MUMqHQcnd1ItzTtFBfbeZInd25OyBq2Eu78Dnt9pJrqpB7HGaud9ODw441f7+Ugy5j5beYGszUzhVGigPNSuK2rOPLISAdqEc52C5Cg97eCxTk3ekJB+4BYRSW24/dbnvkDKiKITnXRV7H13SLLvc8iij8ukORIlJFWLJ4wx4YOeKx0G3K5Fl2mg43OlQ23VbIApFtlEgg7Vc4hHpTDoSzpd/yEHpx7cV53bYr0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=z0zS8EqOE2i0XZAAi1jjWhliMvYLsKa6foAeqfpUlzGZK+0Eb0K7RJnF7/GhsCFzEm4e8Kn5oCz8mbJbPO85/uaPz5NJo633PnyPn4ETu+U90PMJKqvYPd5PDWn/ZFLrNswc36c1e0qxkc5w9jVEBqKhBGy+v95OSpBMEL3FhmA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3662.namprd04.prod.outlook.com
 (2603:10b6:803:47::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Fri, 8 May
 2020 13:25:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 13:25:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 03/19] btrfs: don't use set/get token for single
 assignment in overwrite_item
Thread-Topic: [PATCH 03/19] btrfs: don't use set/get token for single
 assignment in overwrite_item
Thread-Index: AQHWJKz0azTJChRKx0S2OlvYYRq44A==
Date:   Fri, 8 May 2020 13:25:30 +0000
Message-ID: <SN4PR0401MB35985FE3C51FF111BF80DA259BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1588853772.git.dsterba@suse.com>
 <0ef38b64e78028c5b31de4952e8bf683f992c5df.1588853772.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f378a4e-1ad8-43e5-a6d5-08d7f35347a8
x-ms-traffictypediagnostic: SN4PR0401MB3662:
x-microsoft-antispam-prvs: <SN4PR0401MB366204AEE61A495CFBBE34C39BA20@SN4PR0401MB3662.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eNcAD2GUKvKO1T2w2CfP3nzmhk+u1C4i8G6cpSod7Z5davCcCCBYCh52dyP3HNslFg7KKscQKdFEGMHG7Rax2ZyUoKIOX0XvbOFUITuAKTmHJw7BwaDabXG9W96XdRoUQ0PxfSUYCBi0jzq29MqhpQDSioykBBM8RmdRhr6xuxg9BR04VH/DoOsQyNt8y+awyizHgNGDdHOg//NQI48U7KE8JBsVJDTnEersRZI6IOEeJIaUWi2AGTHOISzje3jd6lRair3+I935qUc+YPDAj71bMuCN1MpqwZuthW/jYypydHvqbXdzdam+T9nT6Wjq5kT/6qe0qi6GdRCYv4A1PYKtec0wCgwc+jAagET1ry+CRhDmnC8L2n+PpIw5MbOcO2fr5+5gHb8TTubhWahYFHKf1Yf9cSZMCsfuzWhVipO9B+j+vTAOA9ADsvSMTVav0iqiphScBFWqMjuz6AVvvBx8YHZ5U56SnO5B1nBQ9vQ/ELJNtHJ6Cv43X+xquiwrysCQFw8UOy+iWmMfxUSzAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(33430700001)(316002)(558084003)(33440700001)(83300400001)(4270600006)(110136005)(478600001)(26005)(83310400001)(83320400001)(83290400001)(186003)(83280400001)(52536014)(7696005)(71200400001)(55016002)(5660300002)(6506007)(91956017)(19618925003)(66946007)(2906002)(8936002)(66476007)(66556008)(8676002)(76116006)(86362001)(66446008)(9686003)(33656002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Tj+6Pjfjv+ZxfinZhbbmMvIHz2QSLARqFtFHqxhtVz45q9Drs8tN1kP6LlIkQarunz8EcctJOvSVJI5rixNM/MUJ1GoDc1Uv1C/LYsgjhEBaus4kmWmsmkJXiljasqfdGJT6YhU/8rfkXU4QVnoVeEZoVyxhlH4FiE8woikFb/LhHlDdf6t66+BUoLV0HTJu436cEzFFrs+kUTpCNlo8UqyLBy5lY5vZ+xZ7D2x79QJ+kbVM0rmYw7UkOX3sHFAECYkEWI9z0knSvi0SE8mzaTtp6deA82O2McXMNFof8IeQz6aMNw6wk5ziHuGrThDufTKUnbIQ/MKBX5ECeigXr1E3GGO7PO2SanCbJdbyzpyG0AsK7DvjUdmc147knALqNsEWuc5vnuvfdRUWCBKYbT7suuhGg3V0ejxoKpaYGkdfeh1vmHzligLXpRetZynBnOpydKKXSjqSMwFizzZ/JsZlt+qnGlsxYdOZEDz/uQj97K7CitwlHFJbudNoRGDK
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f378a4e-1ad8-43e5-a6d5-08d7f35347a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 13:25:30.5145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nzf8l68vR1VUjFJDlJEPZQEehIRSmyheKhNOeovKkL4zNlzM18K1ymu+1kE1oeNgANgtvJsRH7kfamCZ2+GwuO7heoTf/NNjqTaycveApwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3662
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
