Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2943B30489A
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 20:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbhAZFnp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 00:43:45 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:23826 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbhAYMkc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 07:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611578431; x=1643114431;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WX8Rc8w/OaVjEVQpmV1gqbnIpgc9LhG4YdNSLttLnuA=;
  b=YYPInn3uV5xaS75DYHFTBmk4+ntf6DQZMtUQLu6RMWxhsHGnN5v6UUpy
   wGiCRQSJG/bRJziRmuMQMV3N3++rYTuHU03AIBOlWYM/30L2JE3Ouy2pT
   9dg0V4FQKkBI8pG5sZLJhH5lUqQHerCHKdldY9PLNqFn2TfM22Xf8Czh4
   GBlDX6hGCPlmp3OCOU4gXUl0TkK1UvPfBy6NZD8WQuIfToVvR9xNf12F3
   jj1o3kzB40PFEpc0soFBBykMw6pbDSNfu2hphivs6HNx6541kFRza0vYV
   rB9UmVtA7c9wtys8HgVrMNgL/bsUrLfJ6TMYStmnck26YDeFIIxa45pcP
   A==;
IronPort-SDR: i4fgQFv87/dAT8YUtbJTumOkX/74Bpedd9qcbvJLLBu4y7oFRddwgLuOVBtCsxY+se2PdyNdWr
 yjFO5VFijYvRloTDxBfMFi18RYkD+SHblezBFO4qdi5Rj5EvB/6QZNbFSmRB3tncml/SjNi+Vx
 4qUvEsYwyXB+8JyZ2zebZAl8BCXjo04His/K7J7GO7v/wFveaHza7gtZquiDMMj4Py67Qodwi3
 AGmYS9NLCUtEHuf1v0wJXPkXIqpW9qwx3jht858Ht/bhXHsY1isthzzO81HmYJax1MdXVvxP+W
 2Us=
X-IronPort-AV: E=Sophos;i="5.79,373,1602518400"; 
   d="scan'208";a="268612335"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2021 20:35:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4AWMvg5zIJ+UBOybUxxVKuqxSVn4v9yI0Ls6cRoFU3mTIESxEPWOTP8warPmnuXG6nyh07zIHy5PLUd6ootHit+DpSEhPUIqvjl1kQjQ7uZzKP/SHMGLLbaktXAFoRpLn1o7Y/ttpZ5xtKSpVBrkPerNAX4U66qoV1RfT9YzEt+pkko85T4aUJIJ+zX0u58UI+X8SGuGBfsUruVfq6zM565qW94Trp30iBl5DKhejJzCcIyXQMU5cl8GwJ5FFe0lpLYihha4oKrvK8pVWrFkdSmnqovQ0J3FlddmH0giFz0+l7L5ufAcdwZpLvudi4dkFPlcMny/MH9j2jPxtCmlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzJLyddUZNg1DnGQNvNeC5bN8QmfPpdRt0C2+FMBpXY=;
 b=fPNIOINFJ5WxJVWkePMZHketf22F+BgwBIA7+UWqHV2+ywmLjeridaqucadK7WBCC+oB2YsE0KZUEy5BzE6gVzNwPmNzAk1ykp5wo1aHH6S3NMbtqmmrzjgP5BAeaxzgryOXc2fTlCj1Ze+tHrCqB6LHUynrFo51Oqy/kAVpjyRKsATvQuyDLTzDHaCTvravyjK4JsC2pr6k5DVpQAxY3isiENrdnbkis8SrPNMKa9jJXqwh5KsK/3TT/jgl7OpmMBIXH24SrMXoR2o/1o5rwfuQ7ivt8wDqtJCHtkzpXh7gWIYzVdi3a4Fntortdw5+EM2/X40y+FuYwQy7NJ7P2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzJLyddUZNg1DnGQNvNeC5bN8QmfPpdRt0C2+FMBpXY=;
 b=SX6G2yEnnCSyj08jG/5WMyVLR6nxJdJ1YrwYEn+EBZMsexn3VLDajOghnD9vgANqgKaIk5rO3f5bs3EXYWRM8w7OBWkfmBdfWcdi0/qSXuGBa2uSqM2bWJUoKwm92PrQRyCHjS28axePSliquQmvj5la79fzRNVfh6hhYjNPdOg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA2PR04MB7609.namprd04.prod.outlook.com
 (2603:10b6:806:14a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Mon, 25 Jan
 2021 12:35:11 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%6]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 12:35:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs: Remove unused variable
Thread-Topic: [PATCH] btrfs: Remove unused variable
Thread-Index: AQHW8mrK0+GCdDCZiE6NnTe67qCmew==
Date:   Mon, 25 Jan 2021 12:35:11 +0000
Message-ID: <SN4PR0401MB35985EDAB5E15338506F762A9BBD9@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210124160321.744187-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4a01ec52-ca2e-4cae-dcd4-08d8c12da83c
x-ms-traffictypediagnostic: SA2PR04MB7609:
x-microsoft-antispam-prvs: <SA2PR04MB7609AD370DFA603945E8512F9BBD9@SA2PR04MB7609.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: akBhC1TREFbA80UjNwA6SJDOkjQg3Y8T5+XeZKxTAiWDKNK92s2O40hRpRIjrk/tfCxh1knaq53MdD/41VtaeHM9vNYFg/fWUzFti6+7p4xA1BBUILxm4qYP8KkLpBrziBHnfuoxuFdL1PmSUCyMV9KIZk74jxzzkSDsUdMFn9itQPZZbHIDsU4lfkt2Y9tKWHxlTPaTbyt485Yh8yjeAi2GdVxQgfH9mUlHQ7TP28z1y0xwV47WZEZOb4Z+4y0p9DHr8PT4xLH8GQ2p8H2aN2L7adgcHerAifNwhvHDsyXXqW2Y6989QQSlYdJ3MKErCNe97DV+ASmyJ0K/uxOvvKCBa107aklCwnM040AT/qNzUROVNwGEXBdbHlJFGLUOOpQR0tQ5kGAsaOS31MtZtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(4744005)(7696005)(66556008)(110136005)(8676002)(8936002)(91956017)(76116006)(66946007)(26005)(9686003)(4326008)(316002)(83380400001)(5660300002)(6506007)(2906002)(55016002)(53546011)(52536014)(186003)(64756008)(66476007)(66446008)(33656002)(86362001)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?oNssBR/60tNyoYmoNbY9XajQG0W+oHbyTsegE4RQoAVM/1K4fX3rIAEo?=
 =?Windows-1252?Q?2yEdiA0nwbXBSiNJeTN17AZ0bLro/45g8/E5Zg0yDdaAGGBOAvfEcgOI?=
 =?Windows-1252?Q?c91v6uDux6Uwp7+67XQt/ZmGj+0SW5V3TkgCjS5Qvkmz15fLiYKgi0+U?=
 =?Windows-1252?Q?7eCLX3ZKDmb0kfeHpq8F3Oylx5YdK7Vg0hASWVUT31IyyvA8C6tdO96o?=
 =?Windows-1252?Q?OmZJR70vWA2cRwBwK0MV7eiWio0Bdtt+Hxi2+KEfQKtTX+l10W8y9JsX?=
 =?Windows-1252?Q?2t9hkpGNq1pGZ3NixJnPRCKscf+MqyOj0nGVBQkXPjxWeBn6I1P+lMht?=
 =?Windows-1252?Q?woUC+QKHG/x8K6rLhvMlqe8f8HtVEPI0AWfnhL8UwWbSAd8JhwXfFRmJ?=
 =?Windows-1252?Q?evWKtb+ky/ngWuhKPFpEvQLvGqAdcWqhw7Ii5bJ6HRRS/1TwBMOwRqZ9?=
 =?Windows-1252?Q?MMdf8kPN4FZZCcjyI01d4oGnfQZTg07NVTTTiQ1cXCFbCb2ZdVcrWTIA?=
 =?Windows-1252?Q?VmSmseU+hUSh+1rdO+Id6ZQBXX7/vtEw5O5k5reICUE7cyp7LCPvGHDK?=
 =?Windows-1252?Q?FKA4HxkAOa0iAFYJ/0HHsvWaAp2lAJptddrqYIgpPq30uIIwIgH4Cou2?=
 =?Windows-1252?Q?MA/g9+aHDeH9g7tuWsczOAXqp1Mw9U6k7JhlIlUdmTwDTUQF7h/bQZ6b?=
 =?Windows-1252?Q?hnOi2X2iuIcEEImI5bHym+OQTsOtE234K4O45kcjjkYJIHHP7yF1ymOu?=
 =?Windows-1252?Q?7Ha9eaXnyO3oFbFkKO6jBmwvhrl1MdEb7FYsiMgVfg30N+8VYUu8PlvW?=
 =?Windows-1252?Q?ugXqm5TWQkUtO5LfFbdEkpR/KqQZ1HajmdJxqiR2qF/gOg4s3dW6Mt0n?=
 =?Windows-1252?Q?OzF89LXX0+koMzTpwyEq5aJFTb/nPF8q3odE2hdJJW6hTxm7hzkT7X/8?=
 =?Windows-1252?Q?N1cIFfnv9ahkwkEydOeWt33X5dmHOLXp4nkso6dmpHVtpQR0Bag3BOPB?=
 =?Windows-1252?Q?RH900dhm9/pjbNhA8ONclVc9q1qe1idVAJ7Xoa0G8dGc1dLhGpg4Yy5P?=
 =?Windows-1252?Q?Q7XPbJdVk6IhZvmd2Q850+wg4A0jEKwdX3KVeKpJVMLdR0sQAIATkGQT?=
 =?Windows-1252?Q?bq5Eu4pAc5Tw8EpvQcZKrv4JFQfAvu7usuxmfu0PZ1tduA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a01ec52-ca2e-4cae-dcd4-08d8c12da83c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 12:35:11.1666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KbsThUSxXVszUKdSYtOH4CR4H2EaoYBztD+JMHq05pY7kSohUgXEQtCitrDDLrL31DcwUEdP5kZNWh/biEcqjhwDOslzkJ06kpR+i850gQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7609
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/01/2021 17:05, Nikolay Borisov wrote:=0A=
> This fixes fs/btrfs/zoned.c:491:6: warning: variable =91zone_size=92 set =
but not used [-Wunused-but-set-variable]=0A=
>   491 |  u64 zone_size;=0A=
> =0A=
> Which got introduced in 12659251ca5d ("btrfs: implement log-structured su=
perblock for ZONED mode")=0A=
> =0A=
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>=0A=
=0A=
Even with the zoned complete zoned patchset (for-v14) applied =0A=
the compiler is correct about this issue, ergo this patch fixes it.=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
