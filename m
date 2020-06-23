Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE5C204C80
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 10:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbgFWIfa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 04:35:30 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7914 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731567AbgFWIf3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 04:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592901329; x=1624437329;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=D0d7nkJZHnDYCvoxehbww7OdsGUW+KlNDmZn/03Khwx1LMKtx4F8/1XY
   sHQCfbNQH40dA8zusyScwJRg7QmRkQwrJWOoA9qQl80k4YZQbkK4YiOU0
   7I9neP7OwPzgiycezmM1Zc1cTEkNLbsY9cVQmJKAYXJ2yPCNgCN1kGnRg
   fZqgpKRzmoCqqDjnzMVOK5so0fR05n4uAIVJf954F8OJ/Tkey8sThSePW
   0SD1CyaimGrjNYILzSLxGu80Oq/VBBjQTXj08vHIPeHz+cID0yoiNtdfc
   Q99QAQvsQ/WgcLFbfUSpuTeAeBKm0loM0eSOBhVyxLvYIeCwhd/wUwTXo
   g==;
IronPort-SDR: rIniXTH+rGBRpn9p1KRj4EUkMhHF3kuvcSB4fubpdr/shReJFeRHTzQDXWDx3g7Az4liFa/BNh
 1oJYncLK1zrO/9p/3zRG9w82khUjQvVn8ZeLGm+aoHzc4xUInPKmQoWvu7A4Dt8FBnMqLg+Blo
 4e8TPjkUxcsSIXkaDqIAn4u1PpRSwXvN0TEyJf+zV/sfj4/vmGFLy/ssJM45X8jr0ennTgA36R
 D9qFg1Q/ydT2fuF7m5qbf3vlTOurjIhPLG7+lYs9hQaRhTQrDxludZBaJZ0haNkaIajScs3EIi
 PpE=
X-IronPort-AV: E=Sophos;i="5.75,270,1589212800"; 
   d="scan'208";a="140680546"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2020 16:35:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0aYNi8pcdbTLdZFi45vVuz5TrKqfz/pr7pN+u6bFxMrjylpC9YnHVE9lHKy8tNMDFgLYFAw7jYjvloCsMO1j8okNGTP/TUyuBgC5/rUHsNENgaK7+PSvuEOcP+QeBv9NnfDK4YK5lx78crZk4AU1blGoSj1lHdCeOt0xs5fl8vRe9Y73wKcOinTnao2CbTa4kq2JqRNtdrMVPfigrcLrT9zdIP9BMTrGUeTWoiD/4l5/BGPC74hwECH4shmj7c/1dtJvNULRrFJpr7f+/wWfGMye1iB0RT0b2KCoCVIMQjsCrwJt/aYJWPmLwaKm79cOfyshDfDaAUkYPL/3GddRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=e+Nw3MG7dLLPGo9Uuihz025eamSJroTWh23vEZuZ+Pw07hv8R+flsdk/JgfABI/NBT5+hjZ7iAaO8mi9eF0J9LNnLdxRUU2lh6Of54nSHst+XubXNFWRPuSiIbfmKFKI4t5UJstzuSa+9YT/liEMxf9dSR4NlpAZJII3BmiLW5Z1KeZ479e795keqQ9giaZYPwE9qZK3tR2lRoAfjqai38XFvpkdRjfTsnoE8WYQa8LQlpEwYL6du+tYkLLEwldY5zHfrnMkY89Py/4OMr1flAr4Vq56OlhNGJ9bDx3JGbDkGFx13Cn61nrw3ZUM2epoDrv2j4j5XfmJinyl1zxQ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=W6Oadrxi9k8TU6dh+vZwwO39eWJZ15cfGbFXM9FALJygKHFxZqfpK5H6RWLLmRX+8FuJ1gnSVmj997SpSyhpiQHNHG4K9zJN+Anfx4url3YKw5KKoBuE/+O+b9eFbSdQKscc9dMBDGDyj2Ue0zOd/yWz25C/eDfeA9SHpSpcHFg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4319.namprd04.prod.outlook.com
 (2603:10b6:805:31::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 08:35:27 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 08:35:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] btrfs: add comments for btrfs_check_can_nocow()
 and can_nocow_extent()
Thread-Topic: [PATCH v4 2/3] btrfs: add comments for btrfs_check_can_nocow()
 and can_nocow_extent()
Thread-Index: AQHWSR40Laxkpyps7USnigG2I96ZbA==
Date:   Tue, 23 Jun 2020 08:35:27 +0000
Message-ID: <SN4PR0401MB359889A8772AC226F5EB3FAB9B940@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200623052112.198682-1-wqu@suse.com>
 <20200623052112.198682-3-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ba62ecf-70ee-4a1d-66c0-08d8175061ab
x-ms-traffictypediagnostic: SN6PR04MB4319:
x-microsoft-antispam-prvs: <SN6PR04MB431936664F442AED5D4AF4AB9B940@SN6PR04MB4319.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xrhY+pG8JKwK9ql5HcTkuJ1PCfaV5sL3UQTtsHeNN5HrV3XyDtHmu2OjWJM6NANWP5lDKFtAMhWKG4iDPqKOW1PLpiFkIfDe+vpI2L2DHC/LG3TDOHDwb+7o6jxY+3QSlO7ULodHW+84crJvLpG5YtfXcaMWRij9xN92KsL+IfhKjRsAXSuctNXNFlYUvOfU0cbEggs3sO3S4JG/VDiu/eCBsnB5fu+3j359gbbJa7YSHkTp03U2fgOElB803jX1V4qA24TntTqoiAn3BlHbDwDGIEUoFqQ43c8jGh/e/dltZ6o3f1gFhsfshXtQJpc1135zDE+6uKYBpAotZeueMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(316002)(9686003)(8936002)(19618925003)(52536014)(110136005)(8676002)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(26005)(2906002)(478600001)(91956017)(5660300002)(6506007)(55016002)(71200400001)(558084003)(186003)(86362001)(4270600006)(33656002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: QgDWsmChDGrRWXsUcUinW7jdG3xdif4YD9KlDHTSFhZInJKH5xIocT8Iq6eALY1j/IAoPjrG0OeH6OaM3j6FA/SU3WyhWSOJDARTJiDoy2eMapXf8a3l2SR9e4gUw/AACcMJxL/5b8OAS/uGwmyHrEjjPhFzuQo7zWRMLBbyOoFbSPzDkXouQaixm8jZsBqyRry7/E/o4cbaRzliZwWF44ppDuf0TFisDf/HYthQsMDw4067uIyty7tf89rnF9BBQ6zc0PFqbtavYur+SS1TrJ8oafO7C5UHs/rJHFPrTRFRIOUKikTvJaZ1hijEORwIXGMMd4SCA9620ADX6jw7WejPyENrrrgwwWvA9tfnt52jdvmCWdoslSYv+MXizs4+bytBjmPNaC22Zf2Lk1UCFJ05FXnz99edQauU6XdLdwhBhRrvhI5MIEO+8WxhYoh9nJOs0dBJXxiV38gt+xNCvsfw373zR/v/X8fwE0hbzXEDaHIPORZ9hIBujQHTOHCa
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba62ecf-70ee-4a1d-66c0-08d8175061ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 08:35:27.5003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QhFsaNMi+l/GYKfBHvvz47cOQw3aPeEga1oxaxpmrt1BoYK7pHKhpG3amgSIziMb2VMkO/563ChcPnQwxLNw/M9+ejV0IzEiiz7cufHw0S4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4319
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
