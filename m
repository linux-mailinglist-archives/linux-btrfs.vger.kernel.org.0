Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27CA2124A8
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgGBN2n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:28:43 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:27036 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729270AbgGBN2n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 09:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593696523; x=1625232523;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=W7wz3aJ+X5DfhxnAC6w0K7JkBQWaHDojVuWbtSIO/2iKw3s6ElQOI+d9
   bj5KFloIEFLE7Qv1JebEH7aqdWq3/2tQqbR9z8ilKwOEujL3jleuIr9/0
   3NHRYFRgqnIubIaL6OYByohYcnITrJQsX5yoijp9SwS8UkmKGPBf2NQ4Q
   oUofOhNcatSIjatK0ayFMsJ769B1NXUEArp22rB/KTpdC/6XCHvL+O6ga
   qCgFPaMHXSoVE/0MJzLeqPZbyUaA93Zqw6YqMjRXdbjV8m+2cDYkhh5wb
   T0jI//Kc2vFjydNw9JQ/r/304B1TZqRCgrvdkvrAkpUaiMBFMeHDJTYIc
   w==;
IronPort-SDR: sTIS5dxNRtJoQRLv5E5BPSIxcVFYBZjV0RPGnBWBPSq3TP1DK7KCprd2ZRrB8WZ4k1Sdg6UvNg
 4gqykLNJJw+pjtOGZ5/LUmRzEGLz1IbQZDY62h1x8c3B2VOXg6YtcWSN8hcHtDpG2rRbFgyfBZ
 4907hDDFgajnvmn1i65we+ZjB1M0D79Ed5ebATXEsfFmN0qXKeZ2ueJn0z7UCw/FRdfW8Py+OK
 Ttv8rdvPiSr0DtVmh1NJHDzMz3bmhLBfP9GjgvBqkTViUXmj5T1m8JCu7M1DBkWZ2YzmWaXFT8
 ugQ=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; 
   d="scan'208";a="141680963"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 21:28:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXFfXaiv215Qz4btzKUpHKLmqMv+cIVhAj1VrR6rsAW7VICod0U0vWWwSAVPIO/8v0gC31cxkW4uHcTj7fccd7fCwM/AXbR8PStubzDberfD+U/EVnyA2fCPMtR7EEzzsVc2pcfqcvfBVyTthec1L6FjEe6nVoVz4KIoE5DXxNbEijkXUnUAjN5J6rsdo1AQO62fDW56X2z7aSQsUsAKnap4a9PqFc5JifkWs/QVLH9+lOGsTazhKxE7nNG//CYAe7J50IImS1pFs57r1kzfdNTJPTF98c8q6bfSzbZF1W82YXeZAEKnYn6M8wB5wv9T6o409nYbFSbYGbqBCI/mTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=WlO2aS3a1E//mbc5PozGBa/RhveOFNbk4CaRVybYZprmnJomVfD4LvircrPZX8IBSZgyPh6iu3tEwiL1YxhqTQez+QKjSbJFrBMraFnw+vqhifr2gnuwbjUPAWw0AMwiy+DXLU7uKN0wqMHEbOfEfZ9V5FCu2KHFhS671qtuVpZlTmKHSLAo4WY7lCQT/hE6yqXq8Rhim8GA4LJggpPmJLAJDkq9bUWw3oZn10vASRUXCLTX4b83vooXh6yAAdP5x8KxsyrfFJ7LJzHHNJlQxmoGSFh7gkDj7b61qRMiVnBb7ND08iW/I2Dnn5QmICnEeczG1VOxA6ueU3FutC7AwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=RGQyWp9EIMdFR8X/Djg2B9YhAaFZeX6aDa1Be2NZghWjF2PWRJBnxAez3Go2xxrIEZm5FLxuXz/oiS3vh5wd1RStYMOlhAJivttJPAa0No77x1yLGtGEM+1DceIgnRZ9rZH3/YSgl/n6aS1BkaWczDGtSWo/zToYHgeiEi2IuYo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3807.namprd04.prod.outlook.com
 (2603:10b6:805:43::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Thu, 2 Jul
 2020 13:28:41 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 13:28:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 7/8] btrfs: Increment corrupt device counter during
 compressed read
Thread-Topic: [PATCH 7/8] btrfs: Increment corrupt device counter during
 compressed read
Thread-Index: AQHWUG5773ipkp0iakylDwtW9zPbIg==
Date:   Thu, 2 Jul 2020 13:28:41 +0000
Message-ID: <SN4PR0401MB3598AE9D501A333DE622CB149B6D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200702122335.9117-1-nborisov@suse.com>
 <20200702122335.9117-8-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6fb2202a-7e3b-457d-b38d-08d81e8bd5fe
x-ms-traffictypediagnostic: SN6PR04MB3807:
x-microsoft-antispam-prvs: <SN6PR04MB380784DEF7A41AE87B4B3FFC9B6D0@SN6PR04MB3807.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 27f3PpK6hpaVHAT7ciU2J7Ad3lseie4zAHi0xCJTfwjBAuS3tTLfEXKrJehb0pyzQsZTGmzn5vmF+S2bqwXP9+6WZU7i8/BSa8reQIUaDcJ20wCZc7aggRzC9T5KO0IaJQPja0/dkDErDYBuOGEe54JIGXWjNlxjzKy3fXlYV3AhoqQu25maPh62ZGPMEBnxXcr1WACgHHWkX+a+xkxF5ynKKF8bY2pRoCK3FRGZUEeqitBj2lifbQM87GUCjU7+arRRlivFlDqC77OmADbQz8WtxOeloJRMQZMcGqpZHYhn0SrhesJk7ns8Madj4nwjdtJc4IeghpN/87UPtv63iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(66446008)(52536014)(110136005)(66476007)(558084003)(5660300002)(64756008)(66556008)(6506007)(8936002)(33656002)(19618925003)(4270600006)(71200400001)(2906002)(26005)(8676002)(55016002)(66946007)(186003)(91956017)(86362001)(9686003)(316002)(7696005)(478600001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +UznwpDK9PSSYxRkmwoZtGH/0TUjNte7QyYCa1uBJeFot2RT1ZORpWWZ2jx/jK2Pdyolkz/RhDI8qExG8fpvl0QFWwYkgILe5mCzhx1mtg2ZYrA92kKsJ8KHEuy1QNI9HmiEENfoaPADBBzZmZOlhFu7OPF+sRAqDpr0l/IFAtnqTZ38wT4inkzm7Mf+Fmvmgw8PyGe/erWdwJDBm/MpgILdeNrTpla7QMcgUqKirU8B2NoaE/PAM+Jh1+uj5ORsBfag20dbk4p/2oYbzNbzQvlxPmCtTS0xkLZWCP183nhJVFnc/4WET0T573300Lh3UovczKvbUAVWzssGuxy8cPGPzKw/vLdwJeXU3DVpIZLsZdQfN1323OzPVo8kBQX/xxIydbSZGkBme5V44c+vBHWVG4kuSEJPAHW0JZWAz4i273AkYdfKn4ciuZaFOprLCZPSe2oExMHl3UCt4y+PW1r5Yx7FjGp7OcauNvsKV7C66UinMrhrvQ4ezr74DHDf
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb2202a-7e3b-457d-b38d-08d81e8bd5fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 13:28:41.1172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iA8e7lP3sCBV4oeJaGeaOLU91xMwv+I6KwtFeduzOK2ZcRJyJCZBXbOJKf3LBLmG/ZnHXVQAyggHxThywg6/rAc+pyAStL8C7PCZew6vdjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3807
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
