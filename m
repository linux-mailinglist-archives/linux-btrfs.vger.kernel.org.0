Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815503B855C
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jun 2021 16:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhF3Owe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Jun 2021 10:52:34 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36782 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbhF3Owc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Jun 2021 10:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625064604; x=1656600604;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Xt4t6cHLcuEUGTNhIoTVX8Mldtehd0nFhSQeY4tyxzs=;
  b=kAGU62mS1CLQnDnaE1ly0spQ/uUm12/c3h/hS+F4/HyH/0lphb8iN1jy
   DcLf07311y4wGq/rKXJNYf58aZQVEKwQMcItMgF1BeJg1AFqGdtcqibOf
   YDJQ6tXtZ1/kvAoHo59BAsMOiJrYGbmPBgWgJLvBGXpDzezdr6uWWzERw
   yKrj0S0F9ZSahxlIDnqpO2WeEKQIpHAlmTcta5gTcq9/qAsTqJzXAv5k7
   X+1XuP12bRX/EUb/Pwo+aELUYFu/7OTX65+4vgo/M9J9KRLb/YrX84xQC
   ojuPiZ4CY5uEXH1rpDtQO7b2YC2Ftr2Mngim1S9c7kQ+6o2yqdgenLpDg
   A==;
IronPort-SDR: IVEQWj5r8spzz74gMYoFG6ZUJMmjeuiCO8m0WCWRf598I2UxP44nyTMs1uZpkINiC5P/j5AB+D
 dXsg1ETHZcHEKfjcArfJ33w9HhcNBjtLZgliSkDRTDp1ayCR2Jzjhzy6iWiqzgkFzek//QFfPj
 VPfaArcAknMjmeppWsKzOHGis5DcPB6Z4QXuwXHRmqHKaAJOwCesxng99qLtSJUq8DkWTQ9Qjz
 cPBmdM+tBmS/XhN6+wPCC8m1pJUdaXuMqgVB2Y30BD8S1q3Xr6l/xkYdAZgigw5xAgQADp1fI7
 mLY=
X-IronPort-AV: E=Sophos;i="5.83,312,1616428800"; 
   d="scan'208";a="173910420"
Received: from mail-bn8nam08lp2040.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.40])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2021 22:50:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izwBy32d8KcSdZ36LBViPYEONpe/WfFR9uJjNluU5vcJEqXsMUmcuHDF/YpQU2YdxbUuic4dnNAATbc+1j1WsgEJsxWM2IsZihgDoDbRPNNmPW5CgOO8Dv8JH7rZiz9NtuksvlcqyyYICfMgdzmBwcvy2vnVqoMIBWXkX6NkjW0psYJlEwpjzTx1vZyLV+dEVrCEl88fF5x8Mvo8CfgyYeYkrM4igllzlLzHczKAcUPSeCkTATewQvrUpwRMRt/oosRizl7uDsGaZ5FBFsnu6zHvPEywv+rvqxDL5NxLHh3wYN34JCl8OV57R9FBEGEeWK90lcY0L69rxLsdHw56EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt4t6cHLcuEUGTNhIoTVX8Mldtehd0nFhSQeY4tyxzs=;
 b=HmNwmqQTLzI7TasxtksuxDHQaZyWOSVl9Z+czDSpkE8RQ2VH85UQQbF7qeYYyM/CdpLby9zivY4+RsX5kDBIv3DQmZUJa9FFzciRKhnIM9uI43xhayL6zv6GsmWAFQLa/Um3SARSkmeAl0XS1uTDOeYyp8DKlAKDGQ9SKO57VhzM9tnuWn9o4jVSewHQsOQScS/tahvuk6pyil03cT4TjnlLGrxtygcDV91yj0ELb7I6CvQjWjNr0B4cUMBWFYyFhL+hfbQlpduIeedmAhSncAYEK52M7snFoTnzUWMpo484Cg+DpI2dN5E6IcCR77iI3oU6K3FthhmD6NQttlG/qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt4t6cHLcuEUGTNhIoTVX8Mldtehd0nFhSQeY4tyxzs=;
 b=ivUPMWhLdR6HwZQT2Wl5NByf3kseI9kLcQpEDCCtdt4LyRQoGTU8bftXWD5iPveEwD1IfYIFEnY04AhvYUT/Xzbn3KWx2mJRn5v6OuRq97cOrb/j425Mp334G0uS+93/P7xeVitTOa6V/OEDpn0AkupfokCJN8eyqdlC1KX9PUI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7479.namprd04.prod.outlook.com (2603:10b6:510:51::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Wed, 30 Jun
 2021 14:50:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ad2f:e5e4:3bfd:e1de%4]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 14:50:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "fdmanana@kernel.org" <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 0/2] btrfs: eliminate a deadlock when allocating system
 chunks and rework chunk allocation
Thread-Topic: [PATCH 0/2] btrfs: eliminate a deadlock when allocating system
 chunks and rework chunk allocation
Thread-Index: AQHXbOy3bNJFhY2ix0Wefxf6czxttA==
Date:   Wed, 30 Jun 2021 14:50:00 +0000
Message-ID: <PH0PR04MB741603949B19D52F5CD411B09B019@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1624973480.git.fdmanana@suse.com>
 <20210630131010.GL2610@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:156c:b201:ec6e:b732:eb2c:38fb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efaccb63-878d-4cb8-02ad-08d93bd65657
x-ms-traffictypediagnostic: PH0PR04MB7479:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB74795B524F6BF9A1A9F5591B9B019@PH0PR04MB7479.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6/7aeh+r31lopEFXV/B/+QL8x29wSlAVWtjeja6ScbYSlpd5winkMedEDctokjDROr+jVk/Q+nWqAmZ9qAMQybh+qu4n8uJgi8oRvITuS5j+hpTjeaUVs5cI0ZuAQ07TMJSyXgyWyn7eUfsmEo6IZ14DUhoQSkNLeaJZJf3CSXmEka5cCTzxdehfsFDLuuvqE4NGE4mJc9r4i/uEBjYMvMCb2a0Hl6/V1c6VstKqxke9/xuLNAEY9M7Ubrv+Ka9Hb3lFx4Sv5vfrWnbUKJwOxBk2rKcgjAl41EZbkN5UehkEn1UtZdJtb45YLaACEgvxwJEPhBykTyDZEHqdp8B/f92NKevtbeF0HrRP8Z/omDqm5GyVgr2hCttJw0yWgOtAiH/KicmuSOJ7b/HUFYFtjNRzbEwu0T67cbhfCOagODXgJJVWm5pAKYiZI6Wa/WcCgcDMfnhWU4qwiMCrJHzOommmiV8f4lkZQZ1/wnnoSDV84JLfuOnOVzLILIPk1uWa+HE2EAiTneyi7pKdAkAV+UJ+1cevHLfVvISxKMutHe9cOgr/svII26kHgSKWHBufLUtTyy9dUDWRM6UZ9HOUMMpaeLjN+IqRgnXoJo9DXFeg2p2Sz3twxsWKySv6Oc+lQ5gP1OxUwAY/3FeO9jF3EQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(71200400001)(66476007)(66556008)(64756008)(8676002)(66446008)(5660300002)(52536014)(66946007)(8936002)(76116006)(91956017)(38100700002)(54906003)(6506007)(186003)(53546011)(83380400001)(4326008)(478600001)(316002)(33656002)(55016002)(86362001)(110136005)(122000001)(2906002)(7696005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R18+hJuoExV5r21eAlTRZ5mb76U1mgFq8MYVpnWbz8aVEmRilxPE0/wvtP+g?=
 =?us-ascii?Q?cogsEM7r2pCwEh/gdzblfYyCFOWAhASiDdoe32k5ERebgYMxdU8No9Y95S+C?=
 =?us-ascii?Q?WyLcZNXd71zTjNYCcfa6VoGH8sGuWTayap5pHagB8sI+ox7XQ1tdKNZwGaD5?=
 =?us-ascii?Q?16hW+NNVoCv5SL4izTJNanKhtQstPLZ7/NmvU9xkj9zDrBj3EsUSel5BweJE?=
 =?us-ascii?Q?tk2Yh7j/tE3PVH1LHag0hO19f2I2Zb0V8Mj6i+SCfsUoLt3RWgSLZlYuU4qC?=
 =?us-ascii?Q?MOacA3yxEjfJDeYQCsKsALojvvn4B13f0tzE/XRf3nOSNzsrrVvNgb6+Kljs?=
 =?us-ascii?Q?rcMlk3zfKHXflPKUSxO+LPud2GCbjiMhiB55Yo+lPlrkUfumlZYokJNcPd3b?=
 =?us-ascii?Q?DKqWYglvIv+o9UeNKrdUSonL1JMZ/5Vm5mLmsjoK/iGoAPdI5FneGpROw7nG?=
 =?us-ascii?Q?oS1anqgrW3EAhGFGdSc9F2oVNjTaHzmetJo50Siq89G5LMevxDohBI9zpuuk?=
 =?us-ascii?Q?7/Zxvq361j+9NlZFvNtmEGB7gMCrzWDY4XEcJ81cuU7/dMzf+tpSOzbUg/rx?=
 =?us-ascii?Q?N81z/QM4jF2Vb6OKCl0Wn7/pDFvFWpwbXWfdMM15Qz4IER2gtd1ZX42dvn7j?=
 =?us-ascii?Q?rbJyWIoc8L0VS+oH538ZqJGfoHWVrTDw5qL6LMALVEo6LDfXPLEHD93onzm/?=
 =?us-ascii?Q?xHQeBXblDV29BX8kxGvVoi0/19yzqcTrJGqwg0FWGOiYa8/dmg/OrnRMq/mf?=
 =?us-ascii?Q?lNQGwmKVvs0hcql67nifilOFj3dYliOa1ciny1j8fRZuI1lotfYxZUjwTc21?=
 =?us-ascii?Q?nbWlUPDDp2MC5e88GSvndEGIO8EQmBW75uOw/GsAK9C39WpTxrhGPHNdyo7a?=
 =?us-ascii?Q?qnq/h5ugLxQGBp+waCAJCiGrocMtBkg8GYxTG3rt8hPlmcT+JA9ktJ/oAG+/?=
 =?us-ascii?Q?mN0XFa9ZlGNI6+c2C8jHpfGsuRF20JXKYn6EaLdlt1A3DcXKxvILaBdgTmvx?=
 =?us-ascii?Q?B4dIc0dAdkRdq+JALSKqjc/gEa5eSoF90/EKZMPRwQSG85oNY2aGDYJKLvTp?=
 =?us-ascii?Q?ocv0vT/j5jFRJtsN9FOCUsaUpV+5GZLW1gug6EMtG5+NLXyDbA4lBvAgxc/F?=
 =?us-ascii?Q?lF3sLOGLMuec4h90UJWp+QK/m4mRZRwGyyq6N3NQ5KgABW+jmrWZ75IsOfuL?=
 =?us-ascii?Q?X6iU5khdOnaC9OhcDN132ZVcaI1ZXEl33WV6bAE75Klgk94KKy/b1hitPJw9?=
 =?us-ascii?Q?SICFj2lN8G91WhNkFFmq7gTlBD9f81sBAF4dyhn1eV398oLD3Al4bSqn402/?=
 =?us-ascii?Q?/uvwhvhw0WDTy+6/Vm+UWOF/O7448RaCXHNaQ/jttZdmA4TmJF3k1cGUnxje?=
 =?us-ascii?Q?FMK4R1GVbNzWoZQTGAqwXMWFwtDZ8QYfVMpVJxlKyy9MYTVPDg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efaccb63-878d-4cb8-02ad-08d93bd65657
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 14:50:00.6123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: weztqpOlDe9i6EmxNLFQKB/HPYzxIdGhpjWUc1LKx35AcRjQ+YcTftKwc2a2LxY9RLDUgj39IbuhJc4U+IHWGVfDVeEtE7tCvzCIIqIobgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7479
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30/06/2021 15:12, David Sterba wrote:=0A=
> On Tue, Jun 29, 2021 at 02:43:04PM +0100, fdmanana@kernel.org wrote:=0A=
>> From: Filipe Manana <fdmanana@suse.com>=0A=
>>=0A=
>> The first patch eliminates a deadlock when multiple tasks need to alloca=
te=0A=
>> a system chunk. It reverts a previous fix for a problem that resulted in=
=0A=
>> exhausting the system chunk array and result in a transaction abort when=
=0A=
>> there are many tasks allocating chunks in parallel. Since there is not a=
=0A=
>> simple and short fix for the deadlock that does not bring back the syste=
m=0A=
>> array exhaustion problem, and the deadlock is relatively easy to trigger=
=0A=
>> on zoned filesystem while the exhaustion problem is not so common, this=
=0A=
>> first patch just revets that previous fix.=0A=
>>=0A=
>> The second patch reworks a bit of the chunk allocation code so that we=
=0A=
>> don't hold onto reserved system space from phase 1 to phase 2 of chunk=
=0A=
>> allocation, which is what leads to system chunk array exhaustion when=0A=
>> there's a bunch of tasks doing chunks allocations in parallel (initially=
=0A=
>> observed on PowerPC, with a 64K node size, when running the fallocate=0A=
>> tests from stress-ng). The diff of this patch is quite big, but about=0A=
>> half of it are just comments.=0A=
> =0A=
> The description of the chunk allocation process is great, thanks.=0A=
> Patches added to misc-next.=0A=
> =0A=
=0A=
I also have a first positive response from Shinichiro that he can't=0A=
reproduce the hangs in a quick run.=0A=
=0A=
He'll probably responds with his 'Tested-by' once the complete tests=0A=
are done.=0A=
