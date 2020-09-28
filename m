Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A495B27ADF9
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Sep 2020 14:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgI1Mhu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Sep 2020 08:37:50 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26959 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgI1Mht (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Sep 2020 08:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601296669; x=1632832669;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qu/8eyR2xxY1gD5+vGtWDvY9b21AZtP2ZYAAHFxAZPY=;
  b=VD7j0FF2itX6lKyCuNIzfwE4KE6373uTviOUCM72eIfYrQN42E8Aqd5F
   PRPWeafnGk3y/qNt7AuR2hEKaYvbZ0FdIm2va4gfNXaZ4AGg/2sBIQvpF
   KxwD6SqOomUCTJhec1kAmqamKfZqBqmF0XC35T9Sa9xEkmnWg9HlDktfm
   6aKSiNUdGkBtuIz+OcZ9a2VjfG/kUp7Huiqi5yKmIw9z/ZN/kSlvCYzY1
   WyIwbyQ+abruLJzVSry9ltt/8DH2h7enVTlII9Xgf93acGwKonjcmVrNP
   jhooXyYS61AjViaK+OCy2x90S8eum2QLwh0Ryc3Rkj+ZyOxmzRPuDFkj5
   A==;
IronPort-SDR: YcQv0Ig/XYLEZocrsSfHH4uU2GPpkUBkZNFdsChDxTX4O6hzR03fflhH1ahpQuRutRH5Pgx2yg
 dQ2YW9b7Ec1swnEK2Kz1CrMT9ZFFxoPxrH5bmoI90pQPojrw5M6FVNOjA39Q48nrF6nIhyk/c2
 TBIaUlcTEE8IO/nRUoHenw3j2qxVQma4a54RIa+q/bDF0zjQkSr+ZYfMx3a7R4LILa9/THHXim
 PW0U+ZZiaOa6PliKrAGj/ajykhpjbL/Zb/WcZKOLNVia+LVfAwyryA2NgMhbNvZgC7tx4rKecS
 DbY=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; 
   d="scan'208";a="258163431"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 20:37:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQNWtNLvmO22j2EDzqjNSU7Ga1bjgCfk8SMPRQYhnw0EkN21XE4d2iMvxp2LDdrHSpoOXIoLE1hKuL2rGVLlWiSFAkNRA3lBmFfBMfy7nniCZJ/4+qaIfoN7njDLRCsCaWTwZg0S+2rhnnNeIz/B35pOuPb74lfWxEmcqJgzKDRz1ie8SMr5XcnI1QYzcSbiPGH6lI5QMdUS//eJ8Vk4M9vJt1OxUiBf575RYTYRvt/x07i+4HQn3xzKQ2wwTrZaFiYttEIVDgE/1Fo6eMQpHmiwGt98kOnfN5W+e0OBJCKYUT18AK6kB/U7kWxd+NbPAq+E609W09nu5nMC4PUrTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbUPsYes3UTNlxy4A208pNuZXdpDKEpnxhYzCXm6SVg=;
 b=VtUkjxuCdWTbZWYFlr5MKdC36AOXhJHCkhYB68ZxrR5842h9xVhP3LJh0wpy9BP/8CvzleGNM8SImmuGlnWv3h6KvfSWX/icug1Nf3F2hEDjVpNQx4HhBa3ydRHAvcu5pmOMY3y6Y2I5fIgnztPu82hRY0KwukcW2t/Ahz9G63nRyHMSCRmf7tF00yNqmMuTZfEFEXPoaRKutSqZ/B7pZeIQQr+ZGugL487Jkb5S2kLaNuII0UpKsPqw+oExaw4+2q4FHVbOwUv6DjNzLm8Yv0VUzpNltQIMAaFsKDb0IWRm30YRKWKNeoak5zargVExAQ39XRtFElXn4jTCIQI/ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbUPsYes3UTNlxy4A208pNuZXdpDKEpnxhYzCXm6SVg=;
 b=Cpx2VMVjJ6J4F44qgjdP/g4uw8G4V3dsyGd5VSzcIK/IXFQH6EZwdoTSMh5WBUGT27gKbVFTAOjO0Bq8t3uRBNNcRZ8vbUvaqcnjJztHzW1Vif3ZawFb/4ehAGC42Tzk1o/H/cs3NjzOEPKC1YRr2CunyRsvePKue2CGI6xz6Ls=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM6PR04MB6411.namprd04.prod.outlook.com (2603:10b6:5:1e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Mon, 28 Sep
 2020 12:37:47 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::7036:fd5b:a165:9089]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::7036:fd5b:a165:9089%7]) with mapi id 15.20.3412.026; Mon, 28 Sep 2020
 12:37:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 1/5] btrfs: unify the ro checking for mount options
Thread-Topic: [PATCH 1/5] btrfs: unify the ro checking for mount options
Thread-Index: AQHWkogD6DR4VnBkkUCrp0wy4BDLBA==
Date:   Mon, 28 Sep 2020 12:37:47 +0000
Message-ID: <DM5PR0401MB3591BBA587DD3D36F47FAA549B350@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <cover.1600961206.git.josef@toxicpanda.com>
 <d307f1d95415232dabfb700e79cda73618aa7d50.1600961206.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:dd62:96c5:79f:bf52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9e5e830-85e2-45d4-cfb8-08d863ab4e34
x-ms-traffictypediagnostic: DM6PR04MB6411:
x-microsoft-antispam-prvs: <DM6PR04MB6411A41BC1CE062D7DB61FDE9B350@DM6PR04MB6411.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0LMAs9GxUduCfjqhJEj3nd+FlOctIyugzngQ7NrnCrX3Q8E0KkMyIhdtoqRlgCyBC8k8DWP4Y5xz8dHWVqnE1dTYf6IBQNzfDNfFHJpa3QdchW83bdjYKmQTq+HDU4hE9qm5vSO/V7OWy24p8WEcSsDKRI01noFKE9FPDnTGp28OdzpzE3eEt2RZv97xuSq+YZsHia7PNuThOQiSaQwrMS9pM8DPwKU9+l+wPRw3KWgI8S54fYogSro5NPO6PFL8UzQs2Vblyr7+W3NkVOMdDAXAY2fLv6x0jIrHFbt83Z5hkB6ztI5CIid1vDnOccTjWQb49nLqpY/+tO8eKeUVWX85d6se0S5sem4BDG+k7s3NNfP764XiFHBcE7KAPvsj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(6506007)(71200400001)(52536014)(66446008)(64756008)(66556008)(66476007)(83380400001)(33656002)(91956017)(76116006)(66946007)(4744005)(5660300002)(55016002)(8676002)(86362001)(186003)(53546011)(7696005)(9686003)(110136005)(478600001)(2906002)(316002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: V3OJtZEOW5aD/j/f8PU/COI3zC6zpddX5F20VCTM69Fya6+IjpnI2FJ9elvoNTt2tOoB16Z3T9DZ1nl3Xfg28q003/JFSLka+zvpEjGSz3P5DMBpcUm1/GkP8l9z7SlvK7r93nifmR/k1gWC91sUW9CEgq4vPsjqAPLic07S9K65SWhzzk97Yyqw8dql5FUJui7YtG833jrlf430U9Xz27pkGOvy93AeLcC/f9IRyCg3BomM1DjZf2lvNoTFRbMrfI899mLhsjjZZywXio2d9AHnJ5FimZScuAP3GtmI/s2vAVZZ8BX3m3ROqVv0HXK15/hb6oIgBRdlMWlC19TFvRHaktnKIUrelkdiJBLeHvyUkWTVkYX59D2uTmIuZQT3IF8JNZF8WvcUt9ApJYBLaQXqi7q4qykIGKmTDfURethAOtcoyKTiXZ7AppsIuyzZt3cMSILWclDQqUhBVJ2hZZKvmwwvd5kIqPgio9eJmrqRKL96eSj9VNkzzWDvZ5xpd0UnBf+FzjSMefcolux57DRW2xt7REuPTLqSvvevCms1TsYWXpfVIinz8qCvAVHEQKcvSIZqYNCCLsCOrMCPtgxzNFOvDJiqROHv8g0fJfsz/yOr3zrI2NMk4G2UJuo+AgDmDrqE+CIv1HpCJ/zYf37j9y6MKxuaFLv9HCksNQJRfaRaVM86e7ZzpfZwoJ1U9nE9FkQjGzGZkmCN4MWCYQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e5e830-85e2-45d4-cfb8-08d863ab4e34
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 12:37:47.4087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qwyfba6IX09QoV+r/1jKcBFE6oHPHJztjLw7KIZI5cdHUknNt0g2F9kJLFNsdHXp8OshLxkbW16hpPqn8X8+2gc+zOer85RxZa1DF+GkGfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6411
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/09/2020 17:33, Josef Bacik wrote:=0A=
> We're going to be adding more options that require RDONLY, so add a=0A=
> helper to do the check and error out if we don't have RDONLY set.=0A=
>=0A=
> +	/* We're read-only, don't have to check. */=0A=
> +	if (new_flags & SB_RDONLY)=0A=
> +		goto out;=0A=
> +=0A=
=0A=
Why aren't you moving the SB_RDONLY check into the new check_ro_option() as=
 well?=0A=
This is what I would have thought this patch does after just reading the co=
mmit message.=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
