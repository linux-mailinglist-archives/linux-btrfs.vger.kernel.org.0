Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07B21CAA3E
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 14:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgEHMFx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 08:05:53 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61403 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgEHMFw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 08:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588939552; x=1620475552;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=VwxwcJF0muJ9RwhfqRYp1btnS18TTV4a53XWFApvnXgdc9/gw+lJe1m4
   662pawFdHqah5hPzcCC1uKwecrlcH4ImoQ0uLARASgWe1N/9b3jMCYrMY
   w108z880BNJhDyTuww3O0vcdBXuqIG1IdAFIIcqAkme5qOKADL+/NhtGM
   M8ir5HnM2SkUuL2adKa7+m6Ja7o3sRIXaqqR1MbQT5WXQASjw9rLifExC
   aPwp7H/ZJKFYQbs4omAbGSUqDo9lNjUsBfposGAFgKccDKXuAiL1RT8Ln
   cjKUdEZzLGUAw1Otg7SQE/KTPPhNwyxT2s/QGZo3Le3RBEMmyqN+VMOH7
   g==;
IronPort-SDR: hY9G12D9UJ2iq7pO+CSrM74UyGBq8CPpkRdfXQAcGmYORD2ULJ5zIqd+75imyDcQRTMqRoABfn
 PUmOPoANN0ezCfsE9ahIYBBWtyz+9bku6MPltbH0NVCUP354x02RaaoNZgKjQuo3W34o5JUOoT
 s1hGHn89JRIQGXYuOHfUWPEYagC4Sked3hwu5q68joc66WQLOADgR2BMqZzn3HSWruEdvfd9ab
 i8AECMhGJSzyLhNMOsTrtKmhf5zHjMlDHwEpCC0dRcQXvKY2q8R2DiXXRj8rR5J9wzNcUoyZIO
 hhw=
X-IronPort-AV: E=Sophos;i="5.73,367,1583164800"; 
   d="scan'208";a="246111351"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 20:05:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4uumDR7VKO4b/kkDQz1lkiYw6QQutEthMumg7kNUl2Q1XRaDiqwjWK/5AsJcUxTnNnt7nMg5perc5xvqFmuA/NPjnpzZK9TDxY019pWDkALBjmFNMPaFVlps+d4Xc1ESV81FUIAz9df5x5DE6kC3BiQxKFNy2ishWi0Vpqi63In2or1aYg2VvwFbNrQRnnNM1P0l+nEWhX6qTK6wCbAR55AX7loLdFFHrYYgtLPTnIITviRVZVw17cDMuCNWVRckHeMskIYmDSmQ0awfBZ2cOh+1FKnSp4WVe1Ha+FOUZRw31AY82hRA0JYJpSjNaKMOQnT5z+NgSsIsQzlGqmeYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=DuhX1gLhLnjoKmTmEPEaTYsGGNTghuxBNm6JHUnINgKZKQl+YhaDvBBvPx/zwTtj0U6yeXKwnWKLjN+qt1zJy+V8M+awY07EqDO9Sm5G+FUgLS9n27U1s4MMrgrym9jZSbzisTef1ntyyhGQN5wAIp9Ty20eAT5ujaJUkpyUSF9ChvHNDf/ahtL4aHNVpF1Y/3bphlksCC1cFYPQbc1OvsSgD3y3XxPP2W4BiJreQ28GLVOvW0Y182iJBbge8Nao4yWKUnxHXiYH/wSbtZwytOnMgfNlhWgjjsRWrt8A3z1s67ePlxc3WtKRSbsr+2/zVReGQCOiUfxHXAcwKK7Pbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=0JKz+sH1S47roLC/tbpFQCDY53gUAPaff7vod4IaL9XY+Yc1uMjKzq9NZr2UZKptyNNLOQfCCQnoykM0gT6RyMrGqzY4BN3leev5pZEiAZTxCdhCubIVYTaJ4mHKF9iZdtkRY5D2QbiFSNGNHaeqU+z+j6NDtLut7KffIAHfY+8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3567.namprd04.prod.outlook.com
 (2603:10b6:803:4b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Fri, 8 May
 2020 12:05:51 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 12:05:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/19] btrfs: use the token::eb for all set/get helpers
Thread-Topic: [PATCH 01/19] btrfs: use the token::eb for all set/get helpers
Thread-Index: AQHWJKzxXhuglG77tUmI5q72vuB6Gw==
Date:   Fri, 8 May 2020 12:05:50 +0000
Message-ID: <SN4PR0401MB35981A43AEE995B63D6C93DE9BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1588853772.git.dsterba@suse.com>
 <497d0a07704cdb36c1d2711ff9506225f1874671.1588853772.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [46.244.194.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65ce3921-cbed-456e-819d-08d7f34826d5
x-ms-traffictypediagnostic: SN4PR0401MB3567:
x-microsoft-antispam-prvs: <SN4PR0401MB356712AA7202FF667E6415A09BA20@SN4PR0401MB3567.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: alRupLbCSTRILVK97UXpTFKE1vVpakNTBRLH2sZehS3Qep6q/IHIELjmdE1zwIZELf5RmiLCqiQVddlR0bpF51fCU5YQwxOpegjXNPNOB9Bmu7PaMcW+qNNuE2kM4c8iYEWtX9y3xVzHyeQmvNvy5Yhwhhx9KvCR937ML8SerVT1w1Jynuhsjlt6i2v0dF65OHL5S+yiPIG/yn8EwR3xHRrVnPc+UeEg0Rs/t5ALoWFeDHnYv36Bm7hxz3LIOSw4QRbTIlT03RYSB82BZ6x5u34znZiqvea+CyUhAieke5F1tFoN4mkYa9+xx3wyTwLXJScLW4IkDXgDCBwZ4tij7V3yC0h2ddtWvxSADhZYRrsh9tIqvnXPeaJiYMLdym9CGMgAuUp9YTzqABw5UNQMoS6imdmutoqT2XQ7PA206/ia6cZDNPTvyXl9vyZevbvyoZ8cFaNeyOBP6KzJl6Zbd9CHRlpch+d1MyIHkPesd0MzNCq1rOQBo2oRalR/6nnlYs+pe9nScBgbCCO/SQ4cBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(33430700001)(64756008)(5660300002)(558084003)(66446008)(2906002)(55016002)(71200400001)(6506007)(91956017)(33656002)(19618925003)(52536014)(8936002)(478600001)(83300400001)(8676002)(4270600006)(83290400001)(83280400001)(83310400001)(83320400001)(186003)(7696005)(110136005)(86362001)(76116006)(66556008)(26005)(66946007)(316002)(9686003)(33440700001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: LX6E1IGc1OZ6plDsix6sWm/8kjKqW14eBxw5GexzXnKPR1C0DayEyzFxh3112uOkupLAAHvzjP7nJ+7TlnnQ2p+65QHgJzQI5MFxEBJFKNiMtMSHRsK/5A0TEMTMxLFmDHMUUs11Q6vRkZKiLcg8spp2hQNeuZoi1dmIpyHiq97OdC6AF2/LbsdVhbUb4lPNgdLLZEd09RxATLHu7A1ebPh66bQR2OQqd0T4jaaDdqduHB0NG4ZfR4bXkDAkDgTizdZ5LhVsMl8haQj6vthBG2yw+EBoJdA1UsZchVEgj0Uj3FFMPlzmZ+zbaEBarPi6OjBuHhqa89u+/FNu7TSTvb037h2AhuskYK45x3+6SCSNzscMLacSj/spEShclOcvCrbcj+LA5WKkyNLW8UF2o3m0RGaRPNwepRBrp7R4zRTQIG10Hu+LvoseFNYIF+5KC0RrJ2JlyqQ55Dgi6jrkFzu4tuVvMk+TjoBkYz78UnY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ce3921-cbed-456e-819d-08d7f34826d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 12:05:50.9976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vmgJ53PJeSmLQlt7zGW+TYcDFcIh5VfxJocVDqEYNBjsRvQ/y5x3uvwS9Cui+D3zyWOMsgC4rfk22V8cdKB/aWYnFzU0Sp0E8L8+xy0gYGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3567
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
