Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47D7207325
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 14:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403919AbgFXMRr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 08:17:47 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:47256 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403917AbgFXMRq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 08:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593001064; x=1624537064;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=EBgLgF2VWqjEiKpxj/QX5aiKFk9a/km22LwNyQdppmU=;
  b=Y/St/6/AQyvNDnh/VZKdbIgVsFOp3JxhOcUu24/Ipmfixir6bKo1D5ZD
   XGgqukoqhMmDIH0VPMy585OcvHyzaRSGiPmQM/GqOOhQ7ttiPn3ALYrz+
   LCHwCbva+SckeAS7kLAt4GOZ8lKZMnd3XDnJmgA5kYNlMugzKpMCmyxHe
   8CD9fkfDreryn/6Jlma3cye0PmvXGxhXzdbGfTJDijTB6zlUzxY0T41D5
   rukmEoyq7RdR4yO2+F4QQTz5drObMY5NzHwOYWTT0HDYHCG8Ee9POnGgv
   xFXugDOwwEOBuuvyXx4w571U5MmxJIM1PhJWmJ3+4vbad6LJcNx67x30+
   w==;
IronPort-SDR: sDc5EPowyIi1Lp39G6wWDUf5PN71MuaAZpFqDFX1+xwjh5Av46i2+qpz9Ct3dTxyvsgnM68Y7K
 uoXD5ZO9wNXKVbpycOSZP/5UBjwrcNED0OYgR1vhvsBodg0lTKjiLHBOr1aMR270AkmcQQLuwG
 GskqlHz5VMu1NvIqZWmPo7ETMeO0qG9d21c8duYBjC74Uch/cT6xrt9aLog+ntq3J/nKXb5Da8
 v8+fGRaydg8VI9boeU0FhqxCFLy/hdoH11Cy1lI4dGY6+0Prhdimdoi+nyQPeZtlFvD38CbdWs
 ++o=
X-IronPort-AV: E=Sophos;i="5.75,275,1589212800"; 
   d="scan'208";a="140797179"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2020 20:17:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kd10zp1AXrhjR0Yi6ZQqnWgw2k0lStO9cT8rAEkNCoV+Y0TSRkEoDQ0m13510ZWli/cj/WMLWigVd3tl5YcoxIUjU1JuxgAU61urIrraqX7y5DofAxd6wJauocqnGYb6OFEpS6QLyfi0Hf8xX/0f6rf+B3coMgWH27EZKpzRzvkSRLrLGkHLJAcQnJaOQJI+lcG6OQuHC6kSOWaFCMjsKbMR4qg3jdyMMd7RGUSdqL/QFO8cm1wdoSS80rhBocR+LzB6NuTwkdTocqtoErrbaFjsG9g4e72WiCzoTENNQgBJDOcptxoP1vGRGvUFvLxcJfqW2b3Wf9l8QJH8/USdvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPJsC7TxvRdEn7OvlbZtTgQiNtVXxLgDcYlQiRT+H2U=;
 b=gDcKswxyLHKiruFfu52wUME5ZTqG6TTOCdyg5VJLiqQHiViYtRs2HGZUIa01HKPMtH59W1MX3SBJ5tl+pa+tfkvhm3NnQ2ck0U+Zghfm4QcXex6VA7VIUu0rZanxAM5YDk/AQfD5t8NKE47ZrK0FQkHhej9po8f5FBF8/vjXMwF0DYXRB3tA7Et1MdJVByiVi9GuwhAm6I9tuwM1li+XFHgp2ntAuMvzN6cjyhC02uuy1R2papY1sKGnU3CsRr196BWqY8wRktF9TsCI9FKUEeFtVn0t/Lz9kO6M8dmkHfcxLODWPDhKZM83uH/KzmOZ59OAwWuDkeyIRczopzHYkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPJsC7TxvRdEn7OvlbZtTgQiNtVXxLgDcYlQiRT+H2U=;
 b=ud9ID+vlfFMDAdp8skN8/uFGvEuiW0gj6VmHBQa9WW0Jx4z23f3Y2d72q1zwECjyAYUJWyccKtcELZewBDJpbXmWjoYq9rHpDbFpp3E8ogHgh2bhvPyhU4j5amR/AY7N3t019XjSrB3RTQvxB8umjgATKPl+TngGleUfpRVlEsA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4318.namprd04.prod.outlook.com
 (2603:10b6:805:2e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 24 Jun
 2020 12:17:42 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.021; Wed, 24 Jun 2020
 12:17:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Hans van Kranenburg <hans@knorrie.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
Thread-Topic: [PATCH] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
Thread-Index: AQHWShFCK43KMhBSekKBmLU/7X0PZA==
Date:   Wed, 24 Jun 2020 12:17:42 +0000
Message-ID: <SN4PR0401MB3598B67E6E8DDC2AF970A2E69B950@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200624102136.12495-1-johannes.thumshirn@wdc.com>
 <8add89b8-c581-26c3-31df-e5e056449dc2@gmx.com>
 <SN4PR0401MB3598F71C1984D84EA673B42D9B950@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <18267791-0fb1-52be-9538-ad32940bc451@gmx.com>
 <ff3e46ef-b6c7-7dc9-0e95-9daf07ed9760@knorrie.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: knorrie.org; dkim=none (message not signed)
 header.d=none;knorrie.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:7422:e91d:655d:8b17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4a4c6dbc-8553-4495-02c5-08d818389872
x-ms-traffictypediagnostic: SN6PR04MB4318:
x-microsoft-antispam-prvs: <SN6PR04MB43185BD0D52085D9C565340E9B950@SN6PR04MB4318.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /sL+XzgOinuo+8MENhxhwNYXdJlMh2XOQY1xbfuFgftx3lVXa0yLcTFHJlAqdM79xlL0s+3ZmPiKFGhJqEvOeGrv50GnnrhcvxYsYhhlWJwHxLx74ZMjf444uviqc1DelSaeQslKsTEAowthO93YFYKubNKvgV5IGqA+8m7wT//ypS2dRZsq7UohHd0IRd5QaCaoglvzNRr4pwQdBSgKup/xowi085NrLzf+3P2sM0cmw+gjMyDHBCOHBVwtjArJn1ccvbh4HaTwuxoeDVVgMMh4aWXAjY29LRx/wZ3Vy0JIOJdS618sWzJFIxV3VvnMLeZ6CyQadZxW0zAa1Vxw5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(186003)(52536014)(76116006)(86362001)(66446008)(64756008)(55016002)(9686003)(66556008)(66946007)(91956017)(66476007)(4744005)(5660300002)(71200400001)(7696005)(33656002)(478600001)(53546011)(4326008)(6506007)(8936002)(2906002)(8676002)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 8faGr3JrQbWnyRS52CTL5EOs8aEzi3WZMC0kYFWvjrRVIC/Kcw/4H6iac2RhufcexcmNdavd7OrR1gMB/qB68plNLDSn+suixRBD7Fhf881TCxq444GgVzDM/NMbzji/sbLX9WgspMve0B8EFRBj33zf/40KtoXZ78IjRhX3pn+ma+VocaHdlLmcbaCkTHkHk5TFFPss6uAhSNkxrMRvB9nFzDt4Rz7oeMztiEnqQgPZsYAHvF62PPf6UMIEv1QyGJZt7Miq+QxX1QV1eFNeM3q05vmLhhN06u0DBR1hGOLRMy4bwm2cB4D22PNYOgBLCSzd9id6u0boiodsskMgum4W6xwOBdYHwZnAqhLrKUDu7/Od2eu6Apx3W98D//woeC5iucTKHycY2PCxVL8mWhAyrkqI5je8IA3vt01YMzXZTDOZNzD8zTpVnxli3FFlVckZ2xxvoNULFH32Vf9LC3SpgeMNABanOSa4dGm4WRb3lN7Q1k5a80oyRLkHmYqlYeZV70vawYnw0Nqv2Cwr1vsjFUupsVRxa+KHAIfGvdpY0r2H7wTxXuZThIo5iaRn
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4c6dbc-8553-4495-02c5-08d818389872
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 12:17:42.6030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hxg/yaZ7pDdBpLf8rx1NYFhA9inCa1K0Q5f7vaEyBlw8QjrQtgcoNxg6YFzNrCeXekYptwtyaVyQQ9oZ+tJKA+Ii0H7KCisTTzq+BZPnA7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4318
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/06/2020 14:14, Hans van Kranenburg wrote:=0A=
[...]=0A=
> Random idea... What if an imaginary me likes building kernels with=0A=
> random features from the future (e.g. on top of 4.19LTS), and the next=0A=
> feature added is to show the value of the new flapsie field.=0A=
> =0A=
> The 'version' will increase, but I decide to not pick the new csum type=
=0A=
> patches because I don't need them, I only pick the new flapsie feature.=
=0A=
=0A=
Then csum_type will be 0, which is crc32c. But this works by accident.=0A=
 =0A=
> Now, how does my userspace tooling know that the u16 flapsie field has a=
=0A=
> meaning but the csum_type hasn't?=0A=
> =0A=
> ("You shouldn't do that" is also a possible answer...)=0A=
=0A=
While it's a possible answer, I admit your concerns are valid. That can be=
=0A=
handled easier by a flags field.=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
=0A=
