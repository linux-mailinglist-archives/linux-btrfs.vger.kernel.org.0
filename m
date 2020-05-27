Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1643F1E4233
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 14:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbgE0MZj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 08:25:39 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:40907 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbgE0MZh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 08:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590582338; x=1622118338;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ctQAxgvugJODM/Wd0CLRROC2KxRevpXXbmBSI45yeAI=;
  b=hNu67C1jeqK5akqdOhaXGpXabp+sW5R9uAaRSnbMVq5ZAdj4kQgJIqxy
   SthROX/UK/dnTz2gdGCRoVoMwfZ0CP8xRBeExiAdpv4O9C3HU4lvFWvrP
   DCPadL81/7MlD3kguPE/skvhqoiyU/886T0stv15DE4IoVrb6NAU8Ism4
   tD62lCa4wGEATZN+P+WwHnGVvRjFjmGR9o0IdnsMmF+VAeFk5UGLZvaAy
   P6idkpXfjEK7RVnMPclIG5XUJ17FsN2fC6Clt8KCtEUk7L7+sxNU276Vo
   R8eNrfwC7F8nKmVga288SGBd8eo6OWeH8aXtBuyltp2tI193WJWm2pALX
   Q==;
IronPort-SDR: WQZwOLW6iOd3gJAvmuj7YuGiZsvz3JlztOylFaBrF3w4NFWuD7Xl7oGKG63sCq0Pc2kjKp9/md
 ZpuRXdIzMUuycDHQnam6dYAL5XqpbCX78hKO7CjJMOFwgDx6MbXN0Nve9+CwuaBy4WAclQZUEx
 s3/L4Hl7cEUPyJeRyPMQhpjprVOtwEa94klhDT25OcgxeXUsIF2Ool4Ed3zMY200jDB83IeDCl
 RjUyP8w2rybYHJnP3XRGT9zZT3Rt0xuOdHxFgY53q1QRDJTJOxFbto+9BCbX9V90fCBSxhZR43
 EQU=
X-IronPort-AV: E=Sophos;i="5.73,441,1583164800"; 
   d="scan'208";a="138938417"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 20:25:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UX13I33oPEQNz1HC5pbalGwz1HB+QbWF5xjuGvgQ45xBKen1CE03GTzWsxSnWBGjBcRMr6Pmvmmcs76V00b2KrqJqrDdyQ3TnfbiYrnGhtq8gF0nJUdgZ4MNkEPOrC0MXkHdkiBCWA96i9IoNElOhBcITCsfZ+taZGTLIXSAbdEJMkPL3OJw/l1OC2FEkdMzb2BgNSkZA0wlzXI+jxxJmpG+VO9/hQoOBBt/50MfPe4wPRZrI9LyRfp49BNhbQfMIY+WFmE9Vo05L4YeaOMhiCTDlhQD4MHjXx7gdUMluJUMJuhqCSjAloQstmervAQJEW54UZeYFrV/v/PwV2DJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBNJC8vnMmk7yiYTb6AgzJvdwmzPNMg3Mknlv/OufJk=;
 b=W0TcBeVTvW4wFBItMU07entojc8mIwBH6WHnsfIvYGRdrkGLxIWMHgGfvlTkjdGzaJD+DqQfWmY7P63i5HnFX7wwashRq8UkSTQW6SDoAnxuJQw3dJlH+n7MADljiJ3IaqLfSbkwHKVd5IZtwE85vZMWPD8sTINVeMQnIVfwKZVm4JA9L+bVbjy0kfEM0suJgdEGMJ48k7OLeP5IOvkUcKT2zJ+JCEWVd4X4zhlAYbb05+5cUE4J9+aKMeeSvIoOYzThyeXgvOawfxJW4E2RJbyl5tY6yggHKShsmElUI7KrR35to+wM4YCMbuvxnfKyfu4l8vZ4+5YFmy2Rrun51A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBNJC8vnMmk7yiYTb6AgzJvdwmzPNMg3Mknlv/OufJk=;
 b=OqX9D60DOuHucKNXEsa6lL3MRVzlF6uFujFIxcBNeuUhyd04tEDJL54+otJQ3J/wQcCL2EF7GYgCTwDS6AaALGORQgtPNNLaNnezGsxG59oUaw7AayBvsjYMMAkmBWzX2seBBE4yZIN23EV45bnCMUhmhT/ObslgKhnCqsd94LE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3663.namprd04.prod.outlook.com
 (2603:10b6:803:46::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 12:25:35 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 12:25:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Open code key_search
Thread-Topic: [PATCH] btrfs: Open code key_search
Thread-Index: AQHWNA8hqY5plwE1gUuhgwgCTdFgPg==
Date:   Wed, 27 May 2020 12:25:35 +0000
Message-ID: <SN4PR0401MB3598A1745DF9F32092AFD2269BB10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200527101053.7340-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3558f648-6e0b-4c34-471d-08d802390e71
x-ms-traffictypediagnostic: SN4PR0401MB3663:
x-microsoft-antispam-prvs: <SN4PR0401MB36634E6B30A1F0FBE3B1BEC29BB10@SN4PR0401MB3663.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nK/StI1s2VXuyTs8Qu3W5stqLfsvH4iMtg8/njT+FQvWVJ/BXF+xW1+FLHPcPMJDPB/gnbur5QaBFZyOc35ILB+BXCbo7wQzJAoeL8qrJpladFENkJwkMfYwkieiJ/o9Zp44WanmVe60Xbchdxf2WPEA4KCm6KpR87l7JRrk2FuuSBlXmJcEKeHCF0e6NL2T53gUyh0fAeJxouOZeU4Yfu3e1h0BFbT7ZeKUSPKfrWhMQdoNUgh+GfP7qCmUiMxISJeIWF4EkN6OEQ3mlh/ILGIeomWn8tyuGFflzNepS+9EESV4HM1bbt0CVnRj0rwph9ijqAwfJ3t2BIC6D3poEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(86362001)(71200400001)(5660300002)(76116006)(91956017)(64756008)(55016002)(6506007)(66556008)(66946007)(7696005)(53546011)(66476007)(66446008)(186003)(26005)(52536014)(478600001)(110136005)(316002)(2906002)(558084003)(33656002)(8936002)(8676002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 0oW/nJr7OvnqF1+fVvOSmd/byZeVvq7zBxx1LEyGL7njmhRjitdPdcDP4ITEcKbGSei2AvjdI/Xc56XIluS2ibeQ6xyEmMa7D5dUXlVAgchOm+eVtRe6EuaCiXOaAUpp2tFT3inZ1XvSuobMu0LkP2WU/YwFRBD2NBaEJpSvaTntTtMJQ56Jh6PDa4a7sITZSqG3Qmpor/aXjV3rX+rxWH8XrPKCJ72ilk48SjdvFapFJZ+4rIFUy57nNdMvaGIm+wlTA0rQ8F/tHjiiGDrF2k/Am2u+zFAoA6bTuBAqFEYM1WX/WMudm3lD5SqFREC97JPTj7eL1+znhp/ZHgM9UK8cBEbpGd+kASNP4RGNPMM0m1NAei7i3EqlaPRYDSym5kAhznmgR/nrEgEjjAvFST3pYqEvVNOYOjEWyO9HVAVaV1eU/johYNZDYmX6A2Wn4M0A94RBc0eAI0cYdYkxuETuqm6Weu1ez2GmFswxtM/RRRe9dsAM1V0e4bPNE/Dd
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3558f648-6e0b-4c34-471d-08d802390e71
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 12:25:35.0671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Soz2wlc8+16qi15jiS4ly9pi0BsmtHzNN/7g3qa+ep7YSFNMt3uJsI+vn7cwQnUD5BLYg9v0H9gvs9yFGmw9yGDbmsxo8C67sgt5kMyFPPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3663
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27/05/2020 12:11, Nikolay Borisov wrote:=0A=
=0A=
Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
One nit though:=0A=
=0A=
> +			ret =3D btrfs_bin_search(b, key, &slot);=0A=
> +			prev_cmp =3D ret;=0A=
=0A=
I actually find:=0A=
			ret =3D prev_cmp =3D brtfs_bin_search(b, key, &slot);=0A=
=0A=
a bit more readable in this case.=0A=
