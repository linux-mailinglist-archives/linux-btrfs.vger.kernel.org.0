Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3E31CB09F
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 15:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgEHNja (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 09:39:30 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:4387 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgEHNj3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 09:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588945168; x=1620481168;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=J7e4iLyP7kuNvpqeGASYtEBFSyY55P1TYolJnQ1uOwHIGPIwTcEGNYFp
   mnO55aGCYJjooAGpzJxbTwpw0/QS44i6Um6NKxoVBFUdas4lP4AlRBmq+
   2AkbCiosS9LksdUNZiDLzXXbYDhTiNwmiDe2I2/M6Gax+DiTj+pDqN/N+
   2kr1bkyV9neUgKANSWBHsRz1plkDJVSuhTa+dYWuNtNp+iC/o2GLL50AX
   7nEg6MtQ8kDlAvkbbZOQYpzOsVSFx87KeTaQLzn/1F5hxEQhRFh8flson
   EsNPk7vmDUvKZ9QpoMwZSthrtpsos7+juwcGf1ClAohoFbFfowMu1WZ/a
   A==;
IronPort-SDR: tODF40nY1t1+uJEOVvdKM70tTUkoo7ra8Tq/f7amCj3hfAryZApk8Ph6na+Cz3z62NcI/bdrgc
 hnpynZc3PbUN+RtstAg4sIbr18gcPFfvoTM7P0A2AXRIKmrDcARZQww+ykOYZD5TkuM5fOcRCX
 fNUpIh0qP+TwLqw/WWyv2D7q4AA0mfekkkTB1B46B5+QD3TJE1G2P98aRBMvEOYCUlgK1SMygP
 RZBhbctE1F3JQ6dkbqLtaMErW4pvQsz5HxiFpJ9tKb0lbQWz8pE+ihoa+oT4TymhC8UD+zoGdT
 fls=
X-IronPort-AV: E=Sophos;i="5.73,367,1583164800"; 
   d="scan'208";a="246117252"
Received: from mail-bl2nam02lp2051.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.51])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 21:39:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwshasWX+a4+2HS/Gv7W8FS+CcP11OEP5aycUr0NFkE16abzmjhWguGzjhQU6oNk75+86objUJDA53v+UChqnO3w/GXRhmpdedCkLR2bkoPYze46tDAtgIGAq98pnBsV4CpfPOihrZt/THTuf0S7O632cuQF7R8uCIC8lBA3lckd85OlzpWNmHzW3iczxLsaSCLQ51TkKW3gJ9fpEqvV7rKPVk2pMzPORu9X9KoFoJnytKRhjWWEVqGPyo/5qdZIwYVzoevP9k9mTHicsDqpChEf0/RlS9l/obYRvbsoe3s+ER1Q6sd7j/eskE1UUDFSllNKCUnx/IOXUnldLxE/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=aA2AOb/0tcxqsxB2+395tr4J80hTiVxeL2ZkcBycZHyRqmhWeqFvgC/eLHFBMjYJZEJlKrEin+Xvr0khhLK07GTkvys0vEyg0mh0lf2vODeUAmQrtph3Xj0yuT8PL/DJKErUuLtyeVnoZYQ9e4hhcBLcWQnNxw7mWM6U+LZB1ockdvlbn0730dEUFRnw2Mntvy1x+Yczy17JCPJlLo7xti1BpaI6oHzvBQLn7V4Rc7UH1tfuDhNoZdGhmtmv8PJTeKqFfooQysKO8y5uUaVPJDA4UaVeM9j2qtyikvfMDZ4bwWRNcL5Zu1YyNJKQNqIPTrmsh2D0pJ2ezNLlML9uWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=OcAKqXHGp8HYmnl0QRjoGu7eck7u/EjvUrjIH2cJ7rXD3/5oahrkHZwbri+rOXPmDZlYS+6tARXn8oNop+xhyKhFITu9c0eienY8vFsIU3gkXX04/iwnxXP4xvbyauKdKTqFyqn7ZTre3c4xEvqWN0rlu1fbZU3GTQhgiTunSpM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3663.namprd04.prod.outlook.com
 (2603:10b6:803:46::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Fri, 8 May
 2020 13:39:27 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 13:39:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/19] btrfs: add separate bounds checker for set/get
 helpers
Thread-Topic: [PATCH 06/19] btrfs: add separate bounds checker for set/get
 helpers
Thread-Index: AQHWJKz3Cc7aBza/7EOnDgnjfPofMQ==
Date:   Fri, 8 May 2020 13:39:27 +0000
Message-ID: <SN4PR0401MB3598D438AF158BA9879B59BF9BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1588853772.git.dsterba@suse.com>
 <dc6452dc6971a0d1064216d9d1ad9cfbe4f3521b.1588853772.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9634e410-8782-4bc3-8d54-08d7f3553a5c
x-ms-traffictypediagnostic: SN4PR0401MB3663:
x-microsoft-antispam-prvs: <SN4PR0401MB3663CEF71A641E90A66D26479BA20@SN4PR0401MB3663.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PqRv/GvsqzTHMNmvpkEuZx842KBYD8wySvETHccduBimQeteqghtBcHLZcXO+YK0ovggAvSDISjLQ5G0GzXLhC4BRRQ4as/ltWC0VsHLFSiA/gS7ZhBvG+YP9Ndie+BZGyuXQp7y+nIF3WfxZwo7ODRph9oKTdwrHboZtd/1QUgp1dGuexrResfsgU/VyEfIek/8flOesB9+ocoj+eNuQFuLeNbyI88px6mirXeMgm56SqOkIMjLkXWKURmkLcxpERdWYDpct1cdgM/1lNwQia3OilsMAq16u9jiUS5TL0dRNdbzE+XCUZjwjRIzZeNHtR3EIUDhzR6LiUsL4eD/7Rp1SB1pz9YhPvkymG8rkcSmrWhfo2MQ5hc3JFf5tRaNxIZ/cvANCHCFOXuEFnquCZQwbbuEj9KQEBbTOsOgTlr4krPTYA5k5GMccBRzbEgVzCIOa4lIrKe4dzTnOY+jg0ux5qjQOLNp9jRS6CSgk92IsE9yCLEpBuy+86ZzT8OFpR9EY99hHuayblv3ZreuVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(33430700001)(55016002)(19618925003)(33440700001)(110136005)(91956017)(86362001)(83300400001)(186003)(71200400001)(558084003)(9686003)(83290400001)(76116006)(8676002)(66476007)(66946007)(64756008)(66556008)(66446008)(83310400001)(83280400001)(33656002)(316002)(83320400001)(7696005)(6506007)(26005)(4270600006)(478600001)(8936002)(2906002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vrcA7xfHLArdYyHhGSkzXn3d7Qj/LK7tU8gvXfflgvdPtm5dSDquDBAAHfQhCxJa4PHP58jELrNo5UMxWbSActRTvnpiQzSp/lkEfmk6Y88mwkD8Ss4BdJRJoRzpJpD4u4NsWjm58jVC1WqBLZL+A49fnR69m/8ZOky+eMgX8lt2+HZy3dUK1m07l2XD6WrvHhUfLqigFb81kEUBRBMqz0+57Mr04xFZGc8fZHTDtGi2NLONlymMgzXm8EHevimGOskULMoY5nspO1nvREmqd52fC7SEd+LOqrYjQ38wCnWSikgGAtbXV4wAY1O5J9ruqQlwcSK02XiYreyF0yVAPwA5ZETIroIloSw3Btq2V0wYT+id8XXF42KO6yiE4VAelwVQwLMsiPVVjsinOiJ7OA5kJoMYs/gJHiImtMfOjy5qQXLnVb2+5rUhpJz5fkemtaHXvUgmt2x+VApBI/s+MujwLedHvzfSt4rhk4laAJpMthneFIGsdeqcg4hW98Y8
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9634e410-8782-4bc3-8d54-08d7f3553a5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 13:39:27.2018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2gQKA575/6ISMXNzehTVp9rZJJIYOxh7LY0XshHJF/6rio2sE5OTdCWwMRYD7C1b/jk+Unsgahko7vMoB5piJYbYZ7kHme/k8/ecLX4FRQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3663
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
