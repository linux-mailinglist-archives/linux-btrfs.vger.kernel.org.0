Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9B71ECDA0
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 12:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgFCKee (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 06:34:34 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1727 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCKed (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Jun 2020 06:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591180483; x=1622716483;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=aZvIuR+etL6SyFsGKWBsCMeeedEWM+4nHcduR9IKXgTd0QCmY0X4kF+O
   8tJfhxZ4R9BmQRXuzJLpnmQ3mBto29kOL3ZLnm3xu5loZIXjya7SU0PL3
   llUtJc6mGExlO2uysoH5v0aBXLBZdQ968H9TBxoW1SXUUQ7MVVIJYyk6Z
   SSIusIb34AtZTnjHd6K/WrvCuc1G7dZj1KFtJk5t+xusGMwH+evTgGet/
   GBTHVNY93DdPpEXsgnkL8024SdaFzeUVqzH+IgMZaLI4h3uk4740AHgqD
   5rZNW6aeQ4Bgv6G1lykyhNlmB+RK3ZY4GXp0Y10G3SNanJn/voadH/8Z2
   w==;
IronPort-SDR: xTyZ4uWggOr4XOal02pT0q/xtAN0Bmn2UrGQK8r39iGgtLmFH+0gWh3CwsYPHae0EX+n1kbDlR
 a4QfjHhpBk89JzmNeOANnpl366yKEv82KKM4xiOUJDe1R8cEtq0s9n/QcmOZgZSaQmUYXZSqcw
 qZyNbFzeg/SemdQxOqXmqsJf8jxtpAh92vmhrWSKAOPR7H2+GZYk1NfoC6Ur5dEZuCVc2vE7vg
 xKEFXVwzJwCharfP8FNOqUlUoP/fuKXCNTMGIxCv0gujNvLHn+PbB404gJxK69iaLKULmez0WZ
 1jU=
X-IronPort-AV: E=Sophos;i="5.73,467,1583164800"; 
   d="scan'208";a="241963643"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2020 18:34:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBMvCmXqbFHmuYoTuHvsTUGI7UvdJBXeS33oeun5TBrFJXCT+sMov6586bfvFkDk+XiTAHiRiOgXDaM6BNTtjPPzV7V5BJq1AwNVLQPLsOGsJZdccf79tI2fDuuBPK81132xIXLrIAcnsDC3W8kqS1WlUmmFdvqaQlOPvTP+pUV2ERTHLa0wcPjwwzvE7afPYB5kTrcJuz/bD4tllC6K3XfrvUPUExY8ggNmzsoii13gCPpLh53fSFa3Iw2/KpNnKHbF8eCPQoqHAG9jRd4ghJpd7Bb82UWR3mr7fjOJ9xCnFFOZBM53fHKf0mH2xxPUS+oRcNJAf7IiGYkYXoxkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=BFHLaZH3ALaJiBmNUauyyD6Z5XmeYKr6Xp0kvwgXm9CnzpEJWl4GG4uQHeYHr1B6T7HQEVArfiDrS4zGGYvBz1iGmWdRro9UTmdVvUN0bL43ipjkjUALcSKzbFeNeV6wMtOztbAJ4XQr+IcFJOSGxDZjSqhMOor3/yKWvTdEacxAaPgjo2NPFz6Ofb1kSTTz6iYgYIIpbIiv3E3yqvDZCTo8rRgvMyHMBPWydFX2MS8zBmWfv/ErU8HG27yiExnwb6cQccgSlOjmRmQgTBWXxzkEjWKXvqBBPykwnutCEqZGxXp479cPZFLSQqkzQnq/nQ8sxvmfVsjOLhC+s41nnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ON09/AxhxgkfV7+kh1+kVBzSjg3jDjqxndH2p0ojwKTE2tymKIilsH8SLrwg+dt0zY9JgqTtorsxBmqCCDZGEFKxDEmapm+w/vmw/qnKL3fBQeJXQM953ZdyJhCRTt09yYIi5nwYS61MWR2z9yFM5zbDM0Qkpju7zR7TPAelHsw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3647.namprd04.prod.outlook.com
 (2603:10b6:803:47::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 10:34:32 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3045.022; Wed, 3 Jun 2020
 10:34:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: use helper btrfs_get_block_group
Thread-Topic: [PATCH 3/3] btrfs: use helper btrfs_get_block_group
Thread-Index: AQHWOY9BJAenGnogYkORfZg1u6ty8A==
Date:   Wed, 3 Jun 2020 10:34:32 +0000
Message-ID: <SN4PR0401MB3598A0D2A38E97E8AF166E429B880@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200603101020.143372-1-anand.jain@oracle.com>
 <20200603101020.143372-4-anand.jain@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd2b4604-9857-438f-6c7c-08d807a9b3f7
x-ms-traffictypediagnostic: SN4PR0401MB3647:
x-microsoft-antispam-prvs: <SN4PR0401MB3647673FF459FFD2E0C784D59B880@SN4PR0401MB3647.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DT+mCoDQwUQ6AZsGTXGBScqD2XEx6RjRJqVFK4KI0guGPI6FOXdW/8S9yx2fJV1A8TgbGfZdaGujXdh4SFAsHzArhXfQQ3iYtEcwHRrtz9C8v8TFpFz3Vtv0EvW0I6QhuGsgtLs+daP3BhXPPwd27gFlZP3gCzPoQthLGOcwQ6c1QUBjxyMhQeOE3CX/3ijl0argXk22v7tHmgetz+LFV2mjYAvvviawVooN9MW9L4zAWIJWZouB1T55EBJuopiU+bm6fKM1Bgo0KmgQmOk4mWBHO4EWp7O6xfDe4DRoCqHzn7IzMAaxQRrLAe1iG3dPS6VhyayBn3Vmb5boXV6hQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(478600001)(86362001)(4270600006)(2906002)(8676002)(19618925003)(6506007)(66476007)(5660300002)(91956017)(76116006)(110136005)(26005)(8936002)(52536014)(33656002)(55016002)(66556008)(66946007)(186003)(66446008)(558084003)(64756008)(9686003)(7696005)(71200400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: UVrk4RZwzFXgUhoSjIDMfL2d0fT33EQZPyEJDDosaY3eyvxVsN8tfU60CwXIJagkjNtecVS4mGBPaP7B7VuBNo9hqw9thtsGhIOuln9AW7qslTXs6og7f6t0bD4bmt5CpfG6cLIvFxNOhR1NNv7QYtoBe4ibCyly2ASDrN96LgA98NMEmJWQ92gNrwqLB7vpeEmbtNgTbs564i3Opqr0ov/z9BqDhkl94G+TcpXGtJIZvH7iNO50KQypw+aIY9Iw0ixpmiun99PwYswqBJtVkYdUtT6XRCI4vIFAwRFACSblj/3PAxpT3FL0SbvSQkSmfIj4Mh1nmmFc0wtXwbN1AZZEkJG69GKmN/f0DuIR9DB3uAccY0kA4aPShTvGW+ehDUL9aFOL8OGST71Z3kcNLZshjdj7YJtIRHAwTr3XELymQD+yko6+iXSYJQh3JNU5oETBGl6XVJEFqdzEGg0IaH45unJfv+uSb6CDe8iShzrVUk/f6QHL3IQNwHtQMhdj
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2b4604-9857-438f-6c7c-08d807a9b3f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 10:34:32.2050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SRe/N6l9bfPC2t7nqJxVIpeGn6GHXrDNRlqFV4UOrWSLqbY5A/LttaHKBp4ThOMsvZ3uGXDPjhgWzKUMWiqBM9wkfaRyEhZgnaMz+UTeb2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3647
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
