Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C547F1CD08B
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 06:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgEKEGE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 00:06:04 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:39521 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgEKEGD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 00:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589169963; x=1620705963;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=oBK1BOtbaF9L8wW8YkcbS5Jof1sUwzNNM62aw4At7ik=;
  b=e/X4oXCSTkYRxKq/yYHn8gcAB9HcHPxTT0Tdk2koPRP8LwRh/yJj9izn
   cnt8TfXgDhiGdsMghJepvZuWaMkyRq4WLK2xY+RXwxEZjzZ8LInE00aKE
   GLwrjzYTWTcA39ozOPhfcgeYikWpWQoBs+wFUwzq3gSMrORPAmimwVMt8
   MA0Ac1yP+pVjJv8LAMUK4BmjNIAsKJWYu5gjDVngHCa0ylL/qs3nx7KI+
   Q56eGTdJnLLY0GW2k1PKmeSvQufkhu7zULV7LiOcj28kAciYzyzwBvKWF
   oiQ9wr2d8dH6eJBZCH++Y+2L1hCf/uWmqojKgrdwM2jlZKaZzXMZO5MPu
   w==;
IronPort-SDR: 8aWafuH//GbDpHtbg6yo0LUYKNvG8KwSL3h6oMTiCSI6HeMTSW1x7HGWkDu3MrZ5JznjRXxP9H
 TlsU7lOQDBlbbs56PFqsNGbIfWuQQ7K2NbaR1VJs7jb7fhooHJmbuMsefX/1FXqzI16sE8EsWj
 lobfF903zs/WIvXAiz4/yB2uoew0+fbB+HvnFHR62U7iLHt5LIC8yXeAJucILlFttYE9kV2bO/
 LxA34qkWl7LahGVALfjgXSHSEj14LxEmE/hrg9KNOMIFTffMtpeZkgY6bfiTrXOWE6cBM98CUU
 asI=
X-IronPort-AV: E=Sophos;i="5.73,378,1583164800"; 
   d="scan'208";a="137709522"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 11 May 2020 12:06:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhu/Gnahj23qMuoxv0YHMQHKxqajsOWvBUmn1oD3EZZCsdrHXFRb1H6wwC1y0SlhQuHhRUHZtc5CZlNtP9LUmSdlGhlYbqKkhgwmIhVvHx8NyIkfLuECU8OCubX/ikL9vXD7guOuctfmGYYkPLilXd8Jrujo1LEUs+x1usfmdVyOQJTVEmNtqjSq6soV0CPoxhs5vb8shKH7vW5JsIj4ExeWEtX3aZl4G5J+xdT0mC2xtfuegrenvdYq8jjWnHoGx2QTsSbYLm9UwCaLHWP0EYIU5ado/lDAFCcUEMFs76SAFX4JCc7nAse1OZZpVux7B4gSHJN/pZKl5Fgbb2qdkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2V9guAK5cc7kzIDOYyW2UCHbi2rBhnrqWl/CnGtWcI=;
 b=NoU5Lrxt4sCf0kEgWMgAKwCm2yvPr9cDxCKlcDdYytUGZ1peZcalZqEszWjGCu3Yvp+HikFCC496jLsohLzULGvzYm/O9vRSzTw8HES7cYZhyD+/dZLeXnepN7V6YXLefOiTHN1loE6yDjz7j4jTJo+pbvPvy/vB622gpZEz3DF+jb1L8Dkeoq7hAZEjcMjnbHuqKnQs0fendxmDDCj+a1EJwiKtJGDmRiqry64WhGHmSQzkc1tpBZsrYEER0xizirHEVlF0/u8VG73UoPQsehyslqqkQt4lggbIjh46HBirQ3WuGmE+GeINP1looMFrz9sCjX3P3McKrSpwryNBVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2V9guAK5cc7kzIDOYyW2UCHbi2rBhnrqWl/CnGtWcI=;
 b=af/XLhn+uOUZOMupxWSbNmZpmcOYe9IMHWknCFMfMlE325jfR5IJaTaU9ydtHNxdFl6twiGfrKDLt3P2tu1x3ED1uSVgh0Zrrdzaj+ypLYmIAiGmRShykKEhnkCEG5zI1qA+nf0BuP2kXj//iJ9TCi/scPNWwf/kxNCA3syIMwM=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6280.namprd04.prod.outlook.com (2603:10b6:a03:1e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Mon, 11 May
 2020 04:06:00 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%6]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 04:06:00 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Phil Karn <karn@ka9q.net>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Rich Rauenzahn <rrauenza@gmail.com>
CC:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Western Digital Red's SMR and btrfs?
Thread-Topic: Western Digital Red's SMR and btrfs?
Thread-Index: AQHWIEIpWSRJsaa3yU+OC7FuJNpSVA==
Date:   Mon, 11 May 2020 04:06:00 +0000
Message-ID: <BY5PR04MB69009A65502C25E208317161E7A10@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <CAG+QAKXuaah3tkhQLd7mD3bx+pc3JZdXkUg6yr0R8=Zv2vXnhw@mail.gmail.com>
 <20200504230857.GQ10769@hungrycats.org>
 <f7ae0b64-048d-3898-6e2d-5702e2f79f47@ka9q.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ka9q.net; dkim=none (message not signed)
 header.d=none;ka9q.net; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4a8f30e8-13f7-4a24-c782-08d7f5609d94
x-ms-traffictypediagnostic: BY5PR04MB6280:
x-microsoft-antispam-prvs: <BY5PR04MB62800D4EC538C20BFC587CB3E7A10@BY5PR04MB6280.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nYNcqTCSV4FskzIxkAKF9XvzPxlL0d24iCWYCum43TR0zDwe65PGwHLBUvkTDOdsUpIfrod0BFRN6EhOSYNPX4Zi4EBj7BXIHnyIdIadl578wklTLYlNIQ1uaDCSo6JojBacTCnJzd3ZrBR+v9ot5Dgit3T/TtMbU5YhO1z2ElYUiFKLBDssKdj6gxy2ReNxksWqn//UrNFyJUjht1JdPgK++BRNdzivB2jp4XC01urWSpfJkiDdZ5jtzhvdcmIr0xD6lZ12ZbpGo7I+pk6yJVhmnXYDZcILKWVCLIx88qLnClVVcGPMrGVZyzCfO7P9Kd30Qf+Yf9TM85n3GyZk6GTJff8hkmq4/1AdozRj2iPnN2Wd6IS9nb0fWebM79QwzzDDPE+zXQ6Y4o55Pzy4SBK4r95OGGr+5darw963MUvUd2pYgV+El1h6LeSB9/jLl5LI9qXh6U8nIbD1p76a9nb8g97McIZ86Z77RWWBlhXgxYI5rdescee1xymiMrn3WQvqw1Yzy7vIcSIMDCSk4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(33430700001)(64756008)(66556008)(6506007)(53546011)(8936002)(186003)(9686003)(110136005)(478600001)(316002)(33440700001)(7696005)(26005)(8676002)(55016002)(4326008)(33656002)(66446008)(66946007)(86362001)(66476007)(5660300002)(52536014)(2906002)(71200400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: V5CQDs+20QgLsv5ZiqtDr6+Wzoo/ek4N7Qumqd6j8UwAhAUYZnMWapi0vY9Ryt7l59xGdgNUPSgIBlF6egrokJhNONe1cDyFto6sZQeOR6RXNoY0EMgXPxdF1bqD05fQa8RCXs62ZXAda9Evz7zv0bGpxk6AwfB9sVnWUw4JSYFkV/+OTW0aX1hgzM56WW2muNDNuUXEXXerEj0WEnp1qwP0qrMeAK9mn4r+4PyzABzYh1flZXeeP4iiagjzI8eW8qrg6God7uWznVQGfTgvHUTa1yTeUCvQ07psaT5y+XD8o+lGFiD5vue/H+GDgonkSAiFFp6KWR9qqZLZiCIdQRwHixjwiKa0v0CQjliOFkck0jhMehNRMB1p0Awo6YiKBq+7b8uGR5YQD8MQTOdpu6wc5dvoqmtAWOP3XLPJfKjF7PC0RkTWnwY2e+lPUePMVn4c9PX2Dp9/p0At8QAocqCmafbf11GoIUVCUTwI7K/bjVFKSn2/4zbeimMrBB26
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8f30e8-13f7-4a24-c782-08d7f5609d94
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 04:06:00.4239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UwR0zM7VL7ej/OMa7RJEy7tLEg0adXlUyVzjoEnhjfwnVAkeyaGnDfI7eGDv7yi3tieZ9evySt9aNCdD6byleQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6280
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020/05/10 6:01, Phil Karn wrote:=0A=
> On 5/4/20 16:08, Zygo Blaxell wrote:=0A=
>> The basic problem with DM-SMR drives is that they cache writes in CMR=0A=
>> zones for a while, but they need significant idle periods (no read or=0A=
>> write commands from the host) to move the data back to SMR zones, or=0A=
>> they run out of CMR space and throttle writes from the host.=0A=
> =0A=
> Does anybody know where the drive keeps all that metadata? On rotating=0A=
> disk, or in flash somewhere?=0A=
=0A=
This is drive implementation dependent. That is not something defined by=0A=
standards. Differences will exist between vendors and models.=0A=
=0A=
> Just wondering what happens when power suddenly fails during these=0A=
> rewrite operations.=0A=
=0A=
The drive FW saves whatever information is needed, consistent with the driv=
e=0A=
write cache flush state. Exactly like an SSD would do too.=0A=
=0A=
=0A=
>> Some kinds of RAID rebuild don't provide sufficient idle time to complet=
e=0A=
>> the CMR-to-SMR writeback, so the host gets throttled.  If the drive slow=
s=0A=
> =0A=
> My understanding is that large sequential writes can go directly to the=
=0A=
> SMR areas, which is an argument for a more conventional RAID array. How=
=0A=
> hard does btrfs try to do large sequential writes?=0A=
=0A=
"large" is not a sufficient parameter to conclude/guess on any specific=0A=
behavior. Alignment (start LBA) of the write command, sectors already writt=
en or=0A=
not, drive write cache on or off, drive write cache full or not, drive=0A=
implementation differences, etc. There are a lot more parameters influencin=
g how=0A=
the drive will process writes. There is no simple statement that can be mad=
e=0A=
about how these drive work internally. This is completely vendor & model=0A=
dependent, exactly like SSDs FTL implementations.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
