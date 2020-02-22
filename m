Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6D1168DB0
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 09:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgBVIs2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Feb 2020 03:48:28 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:5751 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgBVIs2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Feb 2020 03:48:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582361307; x=1613897307;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=dRu6EdL6fi45LbNzCUGmwzJrhIeo+eI613lNVy4MqWDTtqwuV0uP04BN
   DsK+c78IwBO0M9Xdu3xQpiujnl4aSExHEZ5b3Vsjog0luAv9hrkEIFEja
   bhkzZISaZZ7RP2nW1JDPtGze9ITXIWy4fS5z0NN9FdJcfSbTSEnxHOiKv
   rF8U/tF5O9JgvuyUyuB8MA+JrGLUr7JBiHR8jWi31ehg/mtbmC6MVfn9q
   3dU+GGs+dudi3oK249G9BBNkFS9OamzJxmyMj1vhMKUb6k/hSZGqp5yip
   qroqtqXF+IelCaWPM4wREDzt5DJYpbDaKpCekm2jq1YoXffODQUQj93jZ
   A==;
IronPort-SDR: PLpbzdAIQceL5FLnv0SJYQI1uFWnrXOqWrxuJ+dlKc+QW9HmrOCZlZMXZbq5VVGJZOZB4q5+c4
 t4AoK5+n+NZlT79CzqQz/4vBkbm1pWha+RqwoE1gCW7AoMckGckEN59IM262Pxed+LkE6vlQRT
 BHnTS8jRx2lFTqvsX63HXtRRMuYtNZ5oJ6p7rI+B23Ba00DZDCppzvQRf7qGzK7dn2vyLxXSXq
 A/5qSevPypennkNwY2HG0ijpgi+E8azlX47vinCTXlY8qNU5wgsi7a5qMypf+85JwUKhDe48Gg
 ss4=
X-IronPort-AV: E=Sophos;i="5.70,471,1574092800"; 
   d="scan'208";a="130440068"
Received: from mail-co1nam04lp2051.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.51])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2020 16:48:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W70ZNOFHJtKSwao0cOfXv3WaKBKmfkSsCnPbpH+yvi8Blhy3aFJel+yUdkNoTvAT8rb29NNpwDyyxteAnHf42nL6xOufTIcKB5b6fshB7h637lleIkfuL9R6/iPx5JYz0VMQcdnweBIs3fd3D9OEi8QaqgamX4BwzQySA5nS79NBKMwtV4xrE2FdXg1TzwrF5rAqKS8k5iuPYZaRsPDFmdTHhwuI4t9CuhCBCYBxJMIasx96xg0WhwWC4uEnFRClYT2Otg8d046vvM8RYPJTHp0rJooGmWbJ++bY6OSLmJE2EqbvQoy3DZP6zqTYpCBFUVrI/1nwkufkxo9YkWlV0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=FmEnb9xQ6qvE71ZeSN8SudGD+UGTzAfgBbgBXnaKtx02hkluKsz3+iXZ0JOXoSO2rRq3M7nLXAF0pqNnh6gTo0985yuxSMDhPdhwyCAaybTkxvVwyP2RGbP9uY2o07t740DJwI8UrHCrcvw2stKLCkM/vksHB9UK2mVRfXn64CAK6wiPQievr+ooNXO+fup4AMo9IQB4KBO9gXw5lkoUwYuQMRNOAoukGGgbmvMlZEv5owashIXmndh0/CMd4MZbCvGqPED3yYHHZwy1qlBgaqplU9K3LJHMXxX8JBQnAUEikafCRYyg9cnC/b1sf+Xp5x9Bg0FlwvA9UbR8Z5cwEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=htIZ9iJt4KUVs8NIGqMmdh0WeLtci0nhzsasEjLALbAXPxSlHhpTmFZD7IS2icXINCEX2OAi0VsSOezVHfYjmBgDqENrGTrc4mRhl9XUjv6VtFQ5On7GvdlMY1YOTf1jsNJaCq9djOp9yZKUgCdK86CXuNk7uoKh3c/IvdN/gOI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3583.namprd04.prod.outlook.com
 (2603:10b6:803:4e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24; Sat, 22 Feb
 2020 08:48:26 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2750.021; Sat, 22 Feb 2020
 08:48:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 08/11] btrfs: replace u_long type cast with unsigned long
Thread-Topic: [PATCH 08/11] btrfs: replace u_long type cast with unsigned long
Thread-Index: AQHV6NRmyNSBRqFCnUqJudY9grNz6A==
Date:   Sat, 22 Feb 2020 08:48:25 +0000
Message-ID: <SN4PR0401MB35987738155356BA2F36461D9BEE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1582302545.git.dsterba@suse.com>
 <f21f18a03a86c32c44e60f9b08d67cc7ff0ea272.1582302545.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.212.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53deab91-e2db-447e-e249-08d7b773fb40
x-ms-traffictypediagnostic: SN4PR0401MB3583:
x-microsoft-antispam-prvs: <SN4PR0401MB3583B487FF9671C3869BC42F9BEE0@SN4PR0401MB3583.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03218BFD9F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(199004)(189003)(52536014)(81156014)(110136005)(7696005)(81166006)(316002)(19618925003)(186003)(4270600006)(26005)(66556008)(66446008)(91956017)(55016002)(558084003)(5660300002)(66476007)(66946007)(8676002)(64756008)(9686003)(6506007)(86362001)(76116006)(8936002)(2906002)(33656002)(478600001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3583;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lzgpSkGvxwzgpQFWnspLTEb2MBrAxugstXSVUrrm6gzv8UWtzA0KTzaZODRd/trlz2ZK7NGkQsbxLhtP2uh52t0oAvU1PplOJ6IDe6fD2B/H4gOVZIoz2drBY0O9zIbG4rcGqYM9zPK9wZLI4q+kiYWIOfDP63HLTWII4Er0R9uqS6gsaaejs7u8PbQnlUzfHwKrvw2E6Mf6Bs7mCkOwb7U2S9PUDI8j6xJaRF0U9wreKjKNDKWRQHtY7O5LhBQRMN8mF93FWlApNVWcCIWs89oCOC6XwBTiFgUq26AOgxl67XxeOHmx0CPS0dmFNcnOXlJysxTGWOZyyV8TwlUoDLCBmOH+0bMQ1bl/KOL7a70VPxuyZGcnst7svjLEv2LHiQWCHLFlKc9Z61epdlAcCZCCAnWSxbNzX0ALk9EcpJtrcrk15nKO4gB93C4qP6O1
x-ms-exchange-antispam-messagedata: Qt0gI079EdXo2yDcuaNJ8dgQS5hx90w8SviJFFM5LPlsqegqfFAmr88/6X4R0eIMmLEfdYiN/NG0W1JseDjSoc08dwu/d7F7jUbhfXuKN01YMsRUiHWQCrjN9MTm6SqatCcOO7z8iyGu10JojJTpig==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53deab91-e2db-447e-e249-08d7b773fb40
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2020 08:48:25.9080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 50P9I0wutjUNKafuP0cy3GDR4KecrsdH1BmBqoRbx8GCf7VF0GQjDC8dMl33YLHCuIi0XAYhQ1IUocpjh7fFCXp0mlAkVVOEiB30VEmEGIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3583
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
