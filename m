Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C443B5CFD
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 13:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhF1LPA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 07:15:00 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:62904 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbhF1LO7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 07:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624878752; x=1656414752;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mXoxRZ7pXfWIrvENXIB2Bi40nbIep3/vmXrlPxYMvnE=;
  b=Eoh1zsGMpleRU8+9lpc08f22gv7lmfo2XEOBDnMsfJlkz07Kq1A8/69n
   usRmUB6NjvDjQtTAGDV01je8UDRiuVYVIKyy1YNo76anuJor26TPUqsFV
   xFhvI3aln7Nhqy9o+vcfh2UNIcgaWQ5Hlb4p8eV/j2mxeKn9ePkTnD50b
   8VKNn+Ml0UR7cgbxJ2uzkgoPXJNkRNMkpkaD3GNtst8PbE9CNL/w8Xf70
   FraFMKt0KnPbw7k/d5mgz+6vZUUjzLvd0FxITg4V58wLGunpLyiugNkS2
   bbGcBevIuaD5wMDaVD5EfjMmNXOwYHdfuxDHVMKbv/dPVjwxY2hw6Vb03
   w==;
IronPort-SDR: tLnqbQAMhwBvQ6L642CX9HGNXz7DklpUbccuhFEzwy11fw5LoR4h9pgIJzspo2I11u9cuYrhgN
 vCzBRXXc1colahjrWmeDHLmWWoxLaHhJCCCRyIyQibBuJNFNom39At2skee5b/LWHPEsNA0ASs
 w9zhw3UUf8U4TysHM0H/+kqcumBAbLLSvlijH8iBKTiFjj7Q31UOxNBMKyHRA+NQXaDS9yECuW
 X0nvSHyisCmdblD/PrHKU0mJ6EeKBE1i7b7ieCdfC2iRoQmM19+pIt3OKE3IS3Sz9dA7LuBiUe
 GuM=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; 
   d="scan'208";a="173087089"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 19:12:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxNGP4XyZZMcsr+BTQy5FYZCDJJjsZztoaeRVrgXFPvuJxbLi4doNIH1ZmAJgkmx8IOjIRTOQrGr2d8Z3Woc7XDXPu/LhUBhzForBtwyR4LtHdb8p1tEqZWUnXAXgLWmcglrwr7swb5zvf5jRT7MFYAlJNtklZgJCMZSekBHp1Olh3BlXUsuajgLp4xQ/YGg2x+hDd5lpazxF7nAzyO7nnu5grvzzavYG9GHV1D2NIqYM8sy6X9bT+/IHoDdJvDh8AXG+dbkl4f+7OpVJDm6Y5sKDHGW0OsFC8Nl7LsyeZD/RiYg/j+bAq16F1Vda60nyXUKztnZeesPfVx3lG+0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXoxRZ7pXfWIrvENXIB2Bi40nbIep3/vmXrlPxYMvnE=;
 b=in1Una7ct15SN/u86VXAzR0JEM30hehPBe7EhaGzroH5M/g4mYAHgi3rC3NNuJhmnsGoGyYnVpCU9EMUHT+Pifx3pa7+vzXUFqOUG1Q39emGetf/c7aqjuQHolVet0jZDQbWvS+ctw3ucsF2X7PE37Ap7AqDdhAkN6ExLbmZGOsVJ0tAh64DHBZuvunmQSZ+KzSIODrVjDtIIPQA0iJiUcUsVa3y12E4Nu8LAc9R9X0uF/AU70otTL0WaLncPVxHCK+2yu58MuezR0Y9zZH14HRzfL5/sA02M6QIzc3pcVv8FBLm4NP/z3FonqJ/tfuY9P2lO6NkHZmz/TenMv0EwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXoxRZ7pXfWIrvENXIB2Bi40nbIep3/vmXrlPxYMvnE=;
 b=pXsMJAk//pCtWO5agZnPjMxZ6PzBLkJAOfbqSHjZqe9e5yjXIOzIgZFWgQQ4cZV0WtjPgAr9wqSNoeAG0tLiZPLrC8YsnI7Eh0se/cdZCf19ghwxeNuEZxYAUH6WoTQEzHnlYnTDAf3tcd0mFfoPwxB4vvK1Rov8O6e1pMg+5Ag=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7640.namprd04.prod.outlook.com (2603:10b6:510:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 11:12:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de%4]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 11:12:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: remove fs_info->max_zone_append_size
Thread-Topic: [PATCH] btrfs: zoned: remove fs_info->max_zone_append_size
Thread-Index: AQHXa/3nofQJ662Nl0esv0zax9Zs8w==
Date:   Mon, 28 Jun 2021 11:12:31 +0000
Message-ID: <PH0PR04MB7416A143777E98CBB3A0B5689B039@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <fb36e9a074e51af822fe97f2759e62394ec17eaf.1624871611.git.johannes.thumshirn@wdc.com>
 <c6e645b1-ceb1-bbd6-a58a-e6b696f6be8e@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.159]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3746f34c-5d2b-4457-8d98-08d93a259fbf
x-ms-traffictypediagnostic: PH0PR04MB7640:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB76407F4360059028B0D28C939B039@PH0PR04MB7640.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DX0FMkMF5zjIEaVwOClw14usF21DVleXVZEWbe97TKSNpOXMlGQ+pA0Ej7i2yXHx1JoHpythR/phituRq+dHbR3hFEI2RL7+yn7KOkeReWwTJAHkd13bBtEgWbwsue0EAEk/UwRRJW1bYL0gSCy4Qvvz8vrxWObE6mwFSwKEXfPNZq3/tT9XVy0eqzITFG+47+9lmDqC8fe/ZM/P85UeqIL4VrRN24sEZ+wATTsP4/ilfCgHOpdfkRvkqjNzqecsDD9RAF/I/b9QbsK9GFc9PdWbkYT32pi/759MdCxiT6KZWTXIOvrHJPv5FRitApzhxi6nbqBv4kkcj0VESVjaSvDM2tMi5fl538IJmDEjWGp+KKJw8U2+kEfHbYEm6M3ZzIfPYt1GOKJufF1yP3qxxgrX3kC4/zOd7BJojbObKnCGQWjeDJqVskm0ufo2p5LYlNbNH6DnIozOBEbPxgEj3le3XKxhErAIKiu1OZI+LbV136lNenXbJ73aZZnLBta2HCQEXiQeOQXyViXCYYo75v9ww/QBsK20LhmLTLEo+WrK9cQqlirA8e8ZZWfOjv+h04xB5KB4JX4n/w0I8ZQy8DaNu10UfBRrzDVDvLd70WskH6PndfiTNkHDRfxCNiL3KpfFiJxyGFfGhb+9Tqq93Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(4326008)(8936002)(186003)(76116006)(91956017)(86362001)(71200400001)(8676002)(54906003)(7696005)(33656002)(110136005)(316002)(55016002)(9686003)(122000001)(66446008)(26005)(83380400001)(478600001)(6506007)(4744005)(53546011)(52536014)(66556008)(66476007)(64756008)(5660300002)(66946007)(38100700002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yYw/A1s/owwUvgF35r814ZIPGbZbrM00yGSdpV4B97yFo7MDcQVi9Q3Ziw2g?=
 =?us-ascii?Q?kIcYQreRBIO29XUOIXY9cL2HYVx8ZdFJejK29blDxYjeqQx2dWMWGcuuSDNE?=
 =?us-ascii?Q?aWKk5xx/GMnIHYxbXu8JOjdE9fhjznz+zjhN11e3W+k2ihOhn5PPQ/H7EijZ?=
 =?us-ascii?Q?DW7O9SgH6MIDEXZDwsqJAAnzddFiuX8RsBGfDkCCGSqaUIhx+jW6DcwzQPLe?=
 =?us-ascii?Q?w2RGZgEIiZUSWxjdLplCheC5jFhLERafOeRrGZJOtlG4oDcoo63s4NUYEfda?=
 =?us-ascii?Q?o6Ypoo/LyrVW6UGv5wfz5Adeu9PFDpJzU94+pXNRi5OTHkJlEtQ/G5FCNMzu?=
 =?us-ascii?Q?9GxGFOnRwrAzrLzGSo4pUl6HWJixG5TSUeV3neg2GPTMaxAPonp1JBqK1PGA?=
 =?us-ascii?Q?LPJZrmvbHxcRPddHR0ug+h+yEj+fx9jYEE1B60yhH0pOm4qt5Kiq0RI1yNxV?=
 =?us-ascii?Q?yHtN2GjnBohG+fv6zAmTRh50korEt8PAsR+kj/qXJvX045rwY6GiETleOeuO?=
 =?us-ascii?Q?ViPp58P7aA0XCrzHiLIn+jhqOZ6YN1U80tWHuDjBwMcq7sLddNBJVtH4xPQx?=
 =?us-ascii?Q?GaR/TAJGk2Iuz7LaI8xgs6A5dFx9wY18QUJOewKDG2VbetnvKY7YpsvhSk+u?=
 =?us-ascii?Q?lZQGiDYLF5aPh5byxbSqbL1IuzdMTGT0432G5sogrX5UvCAxMAGVC7+KrE1s?=
 =?us-ascii?Q?OG8W/IzJwucWP37H4txTojdY88dIeR7n/8FF21ooLk9MZfEvTHIEU+JuzWw5?=
 =?us-ascii?Q?gsB3d4H9ErDqZjZTo+lHgPuF2LaXyjnTQhX3yiuSt6MOy+0wHBHL0OOKBx/c?=
 =?us-ascii?Q?AD9xIG2KyZRxFTvkiB1I0BfdtP0L38QvCyPi/mPWhoWrEVuxyvjo56fYFY9g?=
 =?us-ascii?Q?FH+Dmod2YU8CbPQWpQVp1a1MVH0r350PmEK0lSEzBSN1O5Hg0WexE7x1OMG9?=
 =?us-ascii?Q?MRd8qJVRBNrqHAo3vkJDybCy/MmK0x3hF/OQLNSWB/hd+qGF2/4xAnzUEe5/?=
 =?us-ascii?Q?/IyZ5EOunwHsY4t517tvmc5ZeAr+uTQ+hOm6+YsDWa2HCOF7/NYvXvHv73dX?=
 =?us-ascii?Q?Iu7PilVdUV5jcJxlesnsWz3sMlt7Kr1cL3X6BJLvBlnf2DUMVxocntZTc3WK?=
 =?us-ascii?Q?cBAb/uniJNLW6kNR0TaTyQ/2jAb3UX1KWQzb2gJ6EXzROWC5u0x610/jcy2o?=
 =?us-ascii?Q?vaqgYgj/5a3tQp2IBSF4/gL164uRwjYb6AhOx5OQqx3xi/otvpAPKJE5r7z0?=
 =?us-ascii?Q?RrtaxRPcCJ9XD6L/obe/WdrnTkndmzFitfT1DfhspYUnGjzU4dPdvf33VX68?=
 =?us-ascii?Q?vTC0e+kuUFoCJ3coXNvN7HRrkUNWfXelbjMyDYZ/J1NTgg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3746f34c-5d2b-4457-8d98-08d93a259fbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 11:12:31.6673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xBcZeo3C0+rx25Ae9uHWNDYdzkWnQNcfU4qkdXQehPP4b8y/NzHKfCWom5gdlvrJFnMSpxQELJE6gbSqCSLEtWx23xA7tMAvSWAuQJSut1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7640
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/06/2021 12:39, Anand Jain wrote:=0A=
> On 28/6/21 5:13 pm, Johannes Thumshirn wrote:=0A=
>> Remove fs_info->max_zone_append_size, it doesn't serve any purpose.=0A=
>>=0A=
> =0A=
> =0A=
> Commit 862931c76327 (btrfs: introduce max_zone_append_size) add it.=0A=
> The purpose of it is to limit all IO append size. So now, we shall=0A=
> only track the max_zone_append_size in=0A=
> device->zone_info->max_zone_append_size, which is per device.=0A=
> =0A=
> btrfs_check_zoned_mode() found the lowest of these per device=0A=
> max_zone_append_size but it didn't do much about it.=0A=
=0A=
Exactly. We don't do anything with it, so it's completely unneeded. Also=0A=
as the max_zone_append_size is per device it doesn't make much sense to=0A=
track it globally. It is basically set but never read.=0A=
