Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4076A1D12A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 14:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731601AbgEMM3V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 May 2020 08:29:21 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:62845 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgEMM3V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 08:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589372960; x=1620908960;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GVl2gnbGioJpKMQ/P87ig07ShgR7nvDTr2Ej2vwNut0=;
  b=BexmQPtge4ZslvRdKSMgYINbbo0lxJ51iQrjbVno04YA/DBcXQHikUX9
   +6Fu2bq1aQ0TERNny/VMHSFte3q0+KgzFml7kTvRzjItOUa/s6lpwRrAf
   DI3AECp94eWV/Q/BVNSTNOUwlbba7z7/lzAEUZsWaT0oSHqGIWBiEb5GX
   fARkMsGyNgilxux1n6PcHi8BxBnIgREDxlwFZ2bbomRU0eNP60dwY/yT6
   EgK5cvGLivo+FrwdE5j42wPrDeF32GhkmsjBhzNgX20QrGnuLvYtd+p2V
   +oYBMuq3Dz/9ymQD6apv91aDDT084GQFevJJX0WlcL8+niq2pne3j+YtB
   Q==;
IronPort-SDR: fx9X4O2NSFjIaXeOnC3ejzN/5Yg8XdZyqdbFv5UT4K3xjpk003BcWAbGvj0hXm72lfE9dJ335c
 xqgw4cWDOxu0xo5FAjgZkD05ogWJ1IgjPtlDJoK3Ro/Ih8pmPspmGgQGHT0s8KvP/0qBd+cRyU
 VmRpgD9sBmyKf0JqEG4L9Jy1kGv5RomHwTlLAhv6aUzCJkkoipudCmcxvn/X7vtE3D9rqbiY+0
 CzBn8otDxWtq8VeKv2qgo2urwlRys7hyppjIIEYxIZ61l+Eq6g2WOcRcQJj0DXYLGBv50NeGkJ
 X+U=
X-IronPort-AV: E=Sophos;i="5.73,387,1583164800"; 
   d="scan'208";a="137577163"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2020 20:29:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KP7ZsHNN3uZYFk3/5axiTlO1XYkqITO0qqrZyl8TefVSUdIQj60IFHGuWZ8Mof8B7Tcid/2G7xglxg4Bw/v4tuR3uT3qFxoHgTqp8ZLofKDoC5Mii08tG7LCYfZN8gxKD8FRSbFMlBFU7a/7Yiz/TxNJkKSTq8jABvedtTu2fiCCwLum/g0Xv0HZx7EC5tI8Qrhe0dK/ZsxGpJNSRkJgkTbEtjnqYn0+W83Tp7KOsVpngT+2LUBqyQe6Lob3Dys5IN2ov5ySH8mkxSr0Adf4cpTjbefN5tPPACtFUFcdcd9y8nwe8PqF6YhGtqXaKwnhFi8gW200HTvnmF8Jzigi9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVl2gnbGioJpKMQ/P87ig07ShgR7nvDTr2Ej2vwNut0=;
 b=YrR8p849q2h7ZdUN4tn38XYEP3AM8FeeA1QyaMOu8KBAWcfVp+fcQyKq7u8yn00m6bEWdJYHFFpAEMh5lh0UwzWHp7YBwXfHFrZfY7mtUGHFltDSDHYWMQKIMw5NMGkkxANc4YSdLbwV8zSGNfVElEXpzvxnYPTxgfebFFtZK5jXTWrvtVDwkRF7QOTif0MmEDHS2eQZfqRr9ngPnjf+ArqYuR2hIcsTDCZYH8NGGOwujPOLhVX3Mu0CbBdo0uST7ez02IkjtsZHrZWaZJ3c8C1i98vOtbZlnekxvW79LEZFv8jPoEnp5iqaeGfOki/BIsz3RURLoQSMk95sML4yOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVl2gnbGioJpKMQ/P87ig07ShgR7nvDTr2Ej2vwNut0=;
 b=G0KcXJ8lcDzmyroLSzv5oWmRmt0pGLLSTfaFWqyykI89/CxIc8Me6dBV/5vSWrXsUjXAZ/JIinUd3wFDhSCrRBFiDamp8u0fbRswfox7gI/ZUh27K4IE3Z0sDJHTJEPgNpvKpusGPWWTATtbBTgPbvvc33baCh7NGeQtGtsgH4I=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3709.namprd04.prod.outlook.com
 (2603:10b6:803:48::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Wed, 13 May
 2020 12:29:06 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.3000.022; Wed, 13 May 2020
 12:29:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Bug 5.7-rc: root leak, eb leak
Thread-Topic: Bug 5.7-rc: root leak, eb leak
Thread-Index: AQHWKGfW6Ky5qVZQwUmLt+jF5CrP/Q==
Date:   Wed, 13 May 2020 12:29:06 +0000
Message-ID: <SN4PR0401MB359859A99040F857B78341869BBF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <5e955017351005f2cc4c0210f401935203de8496c56cb76f53547d435f502803.dsterba@suse.com>
 <a1b2a3320c72e9bcd355caf93cc72fc093807c67e63be0fd59a5fbc1a3a6587f.dsterba@suse.com>
 <20200512230333.GH18421@twin.jikos.cz>
 <SN4PR0401MB3598D62552D8D47F2446121B9BBF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <fa11e7ec-d785-455e-02f9-c45d607c0b52@gmx.com>
 <SN4PR0401MB3598875C33493DDC0D8BA60D9BBF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <2dd7f27b-e505-aee5-2ffa-7e72f4623479@gmx.com>
 <SN4PR0401MB3598771FD08E9C59B695A1689BBF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aa81dfe7-c806-4c69-1645-08d7f7393aa8
x-ms-traffictypediagnostic: SN4PR0401MB3709:
x-microsoft-antispam-prvs: <SN4PR0401MB370970B8CC1FB2252CF0D1D19BBF0@SN4PR0401MB3709.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5n1vP+YMtX+3PhKqXBpTy0esrlCYSJsSL5xghAUbhgvjTJjWPgi5Kf+mUPkQD2tLR9ABDakS8PRDu32x374V7Ys6SAsQ2i1EF7+zUi0reT1c6B2hYeEF0YWkaBzFFXqaCxVVrbgKoR9dffA2WrpWysF53ZDo12Q9c+0qur9OJ8MxVHl+zQYxxCJFVodY/3QIbt6U3y3GqABtsUbbrDljdavjVC8VZxuD/egc3MVCvMCB3mUP6wo+HVEk7uEhH25XNOzqpkCJk8yNz3JIZlzDit9zgFMQtJ/OB45ml4GQuMNlf2GdfFOR/aCDdX4xo/OPDRaacz43tEG5CqwZrTfYFL58+Z9zvAYXSHmjgs15Z+e6Ml9DR2VSHISlxFiANdp16e8imSJSxcIuxueuVAcLqT1xBTT9P14UZ/SbNq6CO5DDkau+lsa32ZASX7mbj4jaPF93KONHJJvK+s0R1f6Tuj/uuQhrhj+u5fxPgr/BZtPIWYP5ZnU3Yu7BOA7JtZ8Oa0imfakh7YygH2eoDSlzEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(33430700001)(8936002)(7696005)(186003)(26005)(91956017)(52536014)(33656002)(6506007)(5660300002)(9686003)(71200400001)(53546011)(55016002)(2906002)(66556008)(86362001)(316002)(110136005)(66946007)(8676002)(66446008)(33440700001)(4326008)(4744005)(64756008)(478600001)(76116006)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: uMB7/HkEx8Qdrx8Y2iCPvNe4PBQ046m7qjz0M7+IZGQMRzfwzZcQG2JFUHdNbITOo7h2tDrDLBLAk5RydWdCE+DnCqZNWRUXAeUDDrF0IUrQGGUySJY59Nzwv7m8cBPYC5MQdPhDFA32zvW2Rs5ZsIxYbuc7FQCLVCKOR06ZKQVQB6fqBuX1I4g3NGidiVPRroDypnn2dVyE33DQvey04g4tg7aHFXxRma9pyjX+1bFAZEBNJFDInmEbzQL2yjTUdt1e4z115s1Js6RjjdoVRjyJRG1+hlOI4B8MdAbDukRSoavg3z4qO4QFfP6wdTeLnwwCu7lMCHaAh2Oatyh/gt7+jUYokBx9sDb2TU39ilP34lpfbAfXRvBs3wLrRH+c8uLu6JNUuynx1uelqHz4BWGZMPjdkILZ/iX4XAI6h9CC4Lyzut1ai3MbuORS93LVeEK1v95WXVvBWW0HdsWMWic/rk1vpCD63mwymfnrg5iGxjf/c95f+dzYA1UUJpvv
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa81dfe7-c806-4c69-1645-08d7f7393aa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 12:29:06.4206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: He2TIe56KohCbCNhquF65ihERxlsQB8xlMcjSVCAEpmeVu3zqSkxnduc2HF/uhoHcQfx/ZGpe6nIxEwTCBHEL8gXVmQR91J6hw170XWgZpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3709
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/05/2020 14:17, Johannes Thumshirn wrote:=0A=
[...]=0A=
>>>=0A=
>> This doesn't make sense.=0A=
>>=0A=
>> That line doesn't even call read_tree_block() nor even any function call=
.=0A=
>>=0A=
>> This looks really strange.=0A=
> =0A=
> Indeed, it does. I have no clue what's going on here.=0A=
> =0A=
=0A=
I just retested without KASAN enabled (to rule out any problems in that are=
a) and =0A=
the test (btrfs/028) passes. =0A=
=0A=
Turning KASAN back on fails the test again. So I /suspect/ it's a race some=
where and =0A=
changed timing (due to KASAN) triggers it.=0A=
