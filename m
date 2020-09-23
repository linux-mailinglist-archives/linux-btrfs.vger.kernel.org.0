Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9455275F3A
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 19:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgIWR4f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 13:56:35 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:43196 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgIWR4f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 13:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600883794; x=1632419794;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=gMMpwPMKt0mWsYZizkr/xuNTYxnSbhPyRotPkSFs37SX1hpHduXcPKXY
   Xw5S4IEym5aaWOhypAxSw/QAtlIdrkQSw54OSKyuDbUStSt5GJCnt8l9M
   6HRg/WpY3+rNFNCr+0r1jR4p0XQPK7aNnm4gWJ3+/mHticgdynAeDBbGR
   r+jYd/6hJKqcPaPWADphZ85n5ORsql9fap1EcV+RbiwAkHyBBRaKc8vwB
   ki6XQwUFbz7cOx5Rq34EhYdD+vgfrarn9o1v9zqWHbe+BRr40sRY8KSg+
   ZGCnr3K2nRKEwb9AB3FodRZGoZQhZOmKvHKIopwIkez4gAK7jHpxQq+S5
   A==;
IronPort-SDR: OlFlq+jDfOLy/78yWsM0+0JPjB0tmHHXL0bWKUrSq4nuZJp8lJA0TSNtN0GPm0Nnflk6NkFNaO
 P2nj3TRcmqZp1iPosKBVM0kTJHkLMQOMQxAXvuKONv46UHD++l7vDP5gWoDvBCkKxcBp/8NFk0
 d3rKpwC3IDac6+R450eDHQqOiWeXGaD/hT2J7seWBQE740YrPoByV8MjXWVzcrGio7YLdj6puk
 d9dFQn+nTzYwiMPraMiXx3Y+oa8T9W9+G1TaJf2CkGatLJAAhx6eKTvspkgPlNCLNmA2YJcpqn
 z3o=
X-IronPort-AV: E=Sophos;i="5.77,293,1596470400"; 
   d="scan'208";a="257819796"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2020 01:56:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PO3bXXGbFfzI0EcpeHp07RKmGgcZJP3y6EEM4LYjmvOISEliR/y9ZL0H4cgyznmtIfbJ5xYnwQGmPwyqRURcU0gyOiL31CeP5/G0sGqBaONCgGm/mR9j3u352vJGb0o8mdLaPyc64vdawtASqGZXDPfM5v62SYWr8OqJattK4nW0hT4f+hIE38hf/zDvYlakb2RSNzNKmUJGJVLkdgnpWDkYlGYAZmvgM11LnW8MsObJq0Si8AdjAFp6GKZcjyIOqw5mzGkA3h1USRY+fLeiR/WFgFWFCD/O6FFJIvE6UMP6fNaFHwTg+AHFazFg3vEW+Uu/UomWIFQkVgN7JgXCjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jYQxEZaD4LJu3ObxRQ5dD5wlcYCpjOfOsPb7a/buJbGpg1tecc2fMWT4O5PIff2UM0vwRvJN3EAyJToadSnnkcho7ylYm3CliNKbfydgscn2lqFt1vA9o+PFgYXjoGdelJ3xHirha4DgLvzG+MBJXutInmM6YaF6MSaaGr5o3kLLIpCY+q402NzmrSpOXiqo3pygpOoHbzvNCrb6U+McM1JbT8YT3WEdrpOWYkVIZ+wgKnJR3YgP5kxtTydSfL61ERLyHFUwCNdXIR+yIfzItQfkFOJNjBoalojKGlQNnM4fbTd6R5Mvh4LRYpWqK5kOihBNk4es+9BZhP9rrTLy3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Bfqyh/P7tI0wwZ839RHgLkw4YeXN/Ob/2Kv28M1xls2nM8Q6OpaEdjMby1dYloJDTslpYSwS7pKcx56mBY063f1M0SRkarcxiqiUTdc4GQUVwmTGaKIFLf2FYukPnKH99AFvVnhyXQkAQBrYGIjAyGgSu/W+oqpZepXVwXEHUIM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4606.namprd04.prod.outlook.com
 (2603:10b6:805:ac::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Wed, 23 Sep
 2020 17:56:33 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.033; Wed, 23 Sep 2020
 17:56:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix filesystem corruption after a device replace
Thread-Topic: [PATCH] btrfs: fix filesystem corruption after a device replace
Thread-Index: AQHWkbYTQ+UpJ3h2rkepM11McmRIgQ==
Date:   Wed, 23 Sep 2020 17:56:33 +0000
Message-ID: <SN4PR0401MB3598122F5C3CD616AA4EC2309B380@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <09c4d27ac71d847fdc5a030a7d860610039d5332.1600871060.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86e0bf5f-0d6f-4a89-ec07-08d85fea0202
x-ms-traffictypediagnostic: SN6PR04MB4606:
x-microsoft-antispam-prvs: <SN6PR04MB4606B03FC4C5659DEB1CE12B9B380@SN6PR04MB4606.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WOZMWNh9uBXNqaKdSf2ug19rLwJ5QAJ7gV9TQzSpxg2rGJ+W+eNN2Ww51aLfOMk8gWGSe4IBZ1GHePIfvwhzVRHmH76qs/N9NZSemUkfzpLuCzTSCGAIaxwWGlR9vvAmoGV0xUjAnP4/rzMRmW4ghD5gPIMC89uYS2Ca1HPqD0XhPbi9VUJPsk0HoaU1f9i1trM1Xke54IZGqGdFpaKKjD5ElLtm62HQG0F482JbmE5qdI34npiZzNDdu0BvTqlacfwLG5i2/+OwHX1ADbaBx2DXygXsN2ysrcgUe9hOwTVbvd4xWEN0OdBi7NQCZLLMiGUMPvNly9b/7wxsqMc6Og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(316002)(33656002)(6506007)(478600001)(186003)(86362001)(110136005)(9686003)(8676002)(55016002)(26005)(52536014)(66556008)(2906002)(4270600006)(19618925003)(66446008)(66476007)(71200400001)(64756008)(8936002)(66946007)(558084003)(5660300002)(76116006)(7696005)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Mtg4WHtPmCFEtPGYf1oq4Dgr/gqTKKNmj5l7G+yYEUN0hqCkhXtCUW8Wt5id8522ashyw8lKAY0j8Q4QGbDqSRzm7bpce4wm/C/ZXuIIDdiaYWnGBpHPSpZ0dnoSJ1VYigpT+9CiDDktDz7R8HCZE+fphKjvqF4tcSvYh/eJW7IZbt8Q3vpQaBXBPO5zdtnHPFaY+dRFOdqXl4h8zt2PDBP33IB8L/Vf/71KDXhyRoLz07XEj2gPdf4woKRd1aWOZZksVdXLm0ONRDi6tAsiIq0bSotTsY5hb4y5EUAMsV/ZSo/NUGsCjbzodJPXGekQbqqEfg2gNjK64Hg/sGlysNEQpYgX9ybfZXp4winJcVJJwQCS9VoaVF1VCBJ/oJTe/i9bkwbSn6OZ94oZWPlScwORXNwY9Mb0rjj9ed8pGucj7/v7hRTnflPEtzmrZ/i0vwTP+0qYx0wOAnGGRWVGBzbBLU1iVbChHZxdMjf385k5nkt0xzH8nEC4evJapE7ulx7TCeOk7ERauhE+OpjfiOUYFbm3B3ozoAynP6y31rKkszK8rndjQBj7uaKN9YGdZOn083zVp7Zn0wvhdS/y+w6xPXZ09qDA6OfKv1WcW2QOk4etw/Po9s9La8Y/hftp4Toe5RmSyvXUKkfaE/b4Qw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e0bf5f-0d6f-4a89-ec07-08d85fea0202
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 17:56:33.1528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: afr19vArG8UxF1xWJt0v8M0cX3RvG8/GwNpFUxDq59TpeN4D/PZztGf8THYRjfFoWVax8wtfQHF19lwXytcKUhZu1LyqtanNJvnE6R0m9QA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4606
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
