Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349573B5B74
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 11:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhF1Jkl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 05:40:41 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:58029 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhF1Jkk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 05:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624873096; x=1656409096;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=upyUiNnTd9n4rCFM3+3zp2wWsvIjp3hZwNU0FC07k3U=;
  b=T2XAHfjZZvUQDN7dxamr+rCzhmOUIkUufWxtZpOWbo6e2x9kYJ+xNFP9
   rUI6QW57THKRyOz36pzvtk1AlYJAUjQfmTWm7skSBsJ8wBcnmdRyfJus8
   xyUHdSIzRTEAftXF0XXeXZM0KFbZ9BaAGSzG+6Qd2f/FdaJFam/5AhbZ7
   GftBW6W8vPgrmlZTS9bwnYBxehC/GTaGkYWWt1wyJbkMnECczMXYCpTn3
   8qxxlC5RqgQBp3MKIFVVkymQYbLUPtodMFuC+GAyWswCjNhIH/OrCufov
   lv4ScrIuV9e1qiGnHaUQEnabwJUNGGkr+qsLhlA7N4gXkmpwRK3AR0wsp
   g==;
IronPort-SDR: /SWPZ1Hvn/xFxGSNwGxTGdjwjxiFVTxSfbTl5LFT5zVuhKr0BURdIP+oyS1U60mTR9xu5SEuAO
 mROh8Kf/hyR8gm3vjsL41MGY/j7+QZSndmYMMBu6IHHc6H16nSKooIBpyA6SM8gyKsuwJQg9qr
 TeHoAZ2IaoO4Lod8vj+hoICSSis6UUnazq5UG5F8y53d+PGG9IajFHi3K5dwV91t+EJZpGZitR
 B5Kx/sGjEQ8fwoeEvFHLN5BQoJVddZqDYdk+BUZDKcy6CNhfAI1mfYhknOB+Ryh15KS7bLkAEo
 O1w=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; 
   d="scan'208";a="173652053"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 17:38:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9Oq/1INtVtloU6nTadDm6zN7vxvH7I3rQp93MpBzVAz7F8f1NiMJb5HQQbxjwexojAGR5/7CexdX2y7JDnTkiM/xRt4ly+y0/7zekK4XK3oX+peC8TeYgVpzcGAzCK4RNQyg9x7lnl2HMnNd95m6J+oSxV/0VJSU4BNceE9df9+QNsiNcEPuBd9ZxDqMgq9FWCUVI5xe9+o4f/Ma/Ru2/wA8X4KMiMf/r1UW0CoY6I6cngSR/fFiwCW9tJIO99MPh79H9qRMLVnIqEHpq6qs26EMb6lHzc92rmL3zmvQvCoe3JWYTEMYMpqrcO97z0pOw57bN6U86tF+fm69/C8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upyUiNnTd9n4rCFM3+3zp2wWsvIjp3hZwNU0FC07k3U=;
 b=E37AN+1CBBuBj1yCXC6VjXXvfguEomj+IbTpK7rfeQe07XogyiwZOurQFvRMZrLCosAbV7Cl3EkLO2mRhN1MHPYPZUKs/2GOOthU/4uOxQ8UQR5JaYZtJQVHMVuP3ZIkA+bh3TwcLvLqzKnlyelJuvJvX8lX/eqSncTXTTYXVAtN0382cZe4rVsPV6zSReQunC3wyjuMxRoZzuZBuamuADj6V7hVkhCRu65VhvD8ZXREEvOGUzcUAjONOON2/SUfliZfD4aSB+14F2+v2jKLpijJtdW3MQRanV78b7rdpRIMa3mJpKRYX6ZhWJI3uQHx3t6xyRiBlpumHP7tOJv2Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upyUiNnTd9n4rCFM3+3zp2wWsvIjp3hZwNU0FC07k3U=;
 b=VxNEvvLGrrEfNikGCnbJmDPzU2yc9g+xV4+SSaAUVbnwvub1sGFW9GoXox/HTeA6uMQnuoqFLf/ik0JzzEp1+4yDiTc+9Qf87dQMKJ/1VTWU/VfzifWah6Dn/qqM5IQwufk0T2jDqFY5MkxVnabPkSOjVCn55BJhGly6zgOdS9U=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7142.namprd04.prod.outlook.com (2603:10b6:510:c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 09:38:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de%4]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 09:38:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "13145886936@163.com" <13145886936@163.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        gushengxian <gushengxian@yulong.com>
Subject: Re: [PATCH] btrfs: remove unneeded variable: "ret"
Thread-Topic: [PATCH] btrfs: remove unneeded variable: "ret"
Thread-Index: AQHXa/qIqdKxYIUS30ab6TzZwixt0Q==
Date:   Mon, 28 Jun 2021 09:38:12 +0000
Message-ID: <PH0PR04MB7416F1BC157F848540DF37389B039@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210628083050.5302-1-13145886936@163.com>
 <ee06042f-da1a-9137-dda3-b8f14bf1b79a@gmx.com>
 <DM6PR04MB7081A02339DB3ACC72F86261E7039@DM6PR04MB7081.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.159]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e6ae401-fcd6-4ea9-7cd5-08d93a1872a8
x-ms-traffictypediagnostic: PH0PR04MB7142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB71428963C67E33BC93F1EC5A9B039@PH0PR04MB7142.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rSxlkGN/wuvYhr+J57fbHmwApQUBvfhtaAzJkGjhiDaY/xXsHCnFJzBLiIlnQODlyyIsVZzcypGMO0OuPwj1TwAntcvpJEkZ8I+MFrRMplWgqsvqMr2p/4rusW75+FSYHhgWm/TZ1zR8k4vAJLIa14msWhbNG5L3ONpssIxV3/4VCPws+Lq3lyKpVb28ARxf8TguZaVRWorZCuaxgDz6YonkqLJEEMbs8n3pJIpZUl2nTfjd8GOqnpqnn4wAANBXzlW9tfyBLi7wfMwmvehBIiGHw/19ADHJkm6SUewhw730HZJab3TlkGmISKg86nNW3fhsxo2eeCgEUbdhZiVBFYGuHjZMuTWobPp6t+gDAh8c95+ouHSD1hJODxWORmatG52uQV7IJUcXGPvqCm+ypLwPGPRjuhdpd5liP48mlrJbIrXcxzd9yOyvZpsr0dGLbUQB7keVOADftDwCyMjkhvg3id12GzfoD4PyTbmh3PaBjA/C6pwrLMKOyGrtesSdf626XZBjKqn6E+Vrgy23Jr1aE26XoN3SUW8s1Wt0WN6ghGoTubmUd2rOtq4nD+CJSHmbvo6yjVwFnNfswvFk/ovxc/HzubFyiKpOu00lNP6mY9tWjER49MytTJ0SD2UDZAJmWn9hUYkhEsu1TzlAwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(7696005)(8676002)(8936002)(52536014)(71200400001)(110136005)(478600001)(186003)(55016002)(4326008)(9686003)(38100700002)(86362001)(122000001)(5660300002)(2906002)(53546011)(316002)(64756008)(66946007)(6506007)(66556008)(4744005)(54906003)(91956017)(83380400001)(66446008)(26005)(33656002)(66476007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?YzZLbnV0dVdSWnpZTEhieTlPd1BmS1gra0VGc2IrK1YrRnE2MXdGN3Z0?=
 =?iso-2022-jp?B?NXNLVlJrQlI0M3liZEE3YlhpWVFYMU9wZEJqNGppbllFTDJGNkVMOXNC?=
 =?iso-2022-jp?B?V2FCRlBFd0xsNERCRlJmT3ZMdXVtdVJudk9jdzFveDA3eFpYSHp3cm45?=
 =?iso-2022-jp?B?T2dsVTRrUkFveER6Y3cvMXd5VytjZEd6WENoTmpTSCszWGpVOE9aYVRk?=
 =?iso-2022-jp?B?ejJrUUlJdTlUa2VyTWMxSGxtbXJYRkpJZjdaejhZSkN5MGZjbEdqZ2pO?=
 =?iso-2022-jp?B?cjRhOTZ4SVVibEplQlRSR2hSNk9pZUdaTGdQN0hZQXZoWG1XS3hiNTNa?=
 =?iso-2022-jp?B?TkkyWWZCUTBpQ01zZ0l4OUhMSGh6Wld6K2ZVc1o5SmQyZDk5cGZqdkV3?=
 =?iso-2022-jp?B?MitGVEJPUVpnZmtsQ0xlUmJaZ2pTSWxsUDJsbTNmTG9YNXA3QU8rRkFG?=
 =?iso-2022-jp?B?ZkNJb2xLSi9xQVh0ekpoVTlLdXFaMDRTSy8vbTFLdFd4VXUvRDl5ajFt?=
 =?iso-2022-jp?B?dHNENDRmN2ZSMFFYS2ExODZyOEQxUDdCR3A1T0hUSXRlZ3d0c2VGdGNW?=
 =?iso-2022-jp?B?RHRZNkYrcHRicDRTQXdtNktmZE92Nm1wMm9EcUxHQnJQSFJTQUV4WHh4?=
 =?iso-2022-jp?B?TWQxbmhZY0ExK2dOUnVJemZzbUdJd3pZOTVKVjRtUFBod29BVHZXa3dv?=
 =?iso-2022-jp?B?ZTRucFQ4NWVXM2FJK0VwN2hYMDV1QkIwdEdFK1dNRDZrSDZOQU5xR1RF?=
 =?iso-2022-jp?B?RWxXRkh6OWZCQ0JjdSt5MDJrMFZCT0RHL0JGTnY3a0ZUdXdFYW12Wmgw?=
 =?iso-2022-jp?B?dXdzdHJ0anpEaUcxTG5BOUNYTHRZcUpCeXNucldiUkhtVkw3YURhKyti?=
 =?iso-2022-jp?B?RDcwTkVOVzZhWTllNjNXeWkxQlR6UlNtdS8zcm5KSW0yUGZHWFdaK1FJ?=
 =?iso-2022-jp?B?V3pkaDJDOWtudU9yMXhURFFqckpUYWZvRERoUUV6TnByL0dVRTA4RWlh?=
 =?iso-2022-jp?B?ZXh5SGhzRkJybWZMTmppeEZtNXgxK2EwcDhjNVhXcUp5TU8wYkFaRWRM?=
 =?iso-2022-jp?B?amkyWURWRjNXcVlqYjRIYWhTdm0rZ2Jma1RKZW9Yb1BDTDRNbENzSWc0?=
 =?iso-2022-jp?B?WmlrT2RTZ1dva3RhNFhpMXk4Y0VSMXNsODlqUlRiYWFlRVBCaHIzTEo4?=
 =?iso-2022-jp?B?eHVGVWF1Z2loQ0dXRyt1WENPUzdHZE9vdkc2blBTU0JkdjlnOFRrNWJV?=
 =?iso-2022-jp?B?N2dMbVA5RFJVVWRtY3NETzYwQjNIV2tQb2MzVUI1MnRrZ0l5NjFOUUp6?=
 =?iso-2022-jp?B?RkNUZ09OcjV6QjJmNmlsOU1VemJKYWFnUFFURUpWZTdUbjJyVkRiS3Qr?=
 =?iso-2022-jp?B?Wm5ld0FVbWozZ0FFdlJlY0d5U3JzOGdDdlc1UjFac0Q0Z0lwbVY5bG4w?=
 =?iso-2022-jp?B?cTVEK1lDNXRKem5raTQzeGU5a2ZJcHpTenhwMklXMElJOEFPcnRvSm9G?=
 =?iso-2022-jp?B?cjg4TEcxMEhmay9SVWxTTURMdjNtRWw0RzM5c3haWGdqaEtIV2wzNmVp?=
 =?iso-2022-jp?B?WGpHM0NuMk1Sbk9yKy9DZ3VnOGdxamxmdldlTUlTMWpnN2hRSFo3VUUy?=
 =?iso-2022-jp?B?ZG80cVV3Y3h5ajgzWFN6UWxKTkY2SWpwS3YzWm5hUFUwNXZRbHFWRGlk?=
 =?iso-2022-jp?B?b3hqSVFRNGRiYTBWbVlvT3R4cElINE1WM1RzL3p5bTk4RFBCTWpQSXlZ?=
 =?iso-2022-jp?B?RmtlVWdyVmh2cGJhYmZqK2JqTVdtVHBKcG1PUFBaWFZxaSt0Nm5UaWVL?=
 =?iso-2022-jp?B?Zm1IcHI2R0pGYXdSS2ZpaGIxOXJSRkxiNTBnZERCUTRreWJXZWNQNVpD?=
 =?iso-2022-jp?B?L1FTSnkvNzVZOVRCbmtCZEUrMEdVelRkVlBBRjhqekVOM3llY0NJeTE2?=
 =?iso-2022-jp?B?SU9NbkVGa1YvRmNrM2VBcHduSTFhQT09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6ae401-fcd6-4ea9-7cd5-08d93a1872a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 09:38:12.6090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +rh2rPC3mjwuAcGQhNhb8RKt8z+8TnJw49pI0SBzzlI8Elk3/6krlOU5ZYr9ZCtW9Vo4WgTLHJFmHusGu6NtFtvYWC6BLB8DHDU1ASQIqxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7142
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/06/2021 11:34, Damien Le Moal wrote:=0A=
> On 2021/06/28 18:22, Qu Wenruo wrote:=0A=
>>=0A=
>>=0A=
>> On 2021/6/28 =1B$B2<8a=1B(B4:30, 13145886936@163.com wrote:=0A=
>>> From: gushengxian <gushengxian@yulong.com>=0A=
>>>=0A=
>>> Remove unneeded variable: "ret".=0A=
>>>=0A=
>>> Signed-off-by: gushengxian <13145886936@163.com>=0A=
>>> Signed-off-by: gushengxian <gushengxian@yulong.com>=0A=
>>=0A=
>> Is this detected by some script?=0A=
>>=0A=
>> Mind to share the script and run it against the whole btrfs code base?=
=0A=
> =0A=
> make M=3Dfs/btrfs W=3D1=0A=
> =0A=
> should work.=0A=
> =0A=
> With gcc, unused variable warnings show up only with W=3D1. clang is diff=
erent I=0A=
> think.=0A=
=0A=
Nope doesn't work here, as the variable is actually used (but not needed at=
 all).=0A=
=0A=
make M=3Dfs/btrfs W=3D1 just prints some warnings about improper kernel-doc=
 formatting.=0A=
