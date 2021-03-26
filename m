Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65ED734AC18
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 16:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhCZP46 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Mar 2021 11:56:58 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21995 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhCZP43 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Mar 2021 11:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616774189; x=1648310189;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=YLZ2+1WR1YMeDzAVARxY3PdpBKtzbT+FxdySWj1awjo=;
  b=LQRzA/W7zy2z9Hw+loMSvCgI50wEFmZ7mCK2Ec+6bgVKtWSySJWsTmPl
   pFJL3nRCkHhtroQl80wbVqIhLIFM/nicRZHtRuLEiidQZa/dTTMFJPi+Z
   CC5Qa/0QvtrRsGn8CBLw9rcvpTgyT+ODHF/p5eeCPqOIJurWLlvyH/zdY
   PoWS94mKLRu85hvUMAuQfcrwwx5B7QiJw5smv1KLP8WIQqGzH5EyLKXLa
   AD0rotcXYTxz2e4CiUlHHF8mR1nQasEmlY0U/VGNeHFRpnwyI/isWJ+oM
   AvckbQr75x4DLoEh6QutHKyvaViJMfuSMoEWU4/O7Afhyt3ycbVmDQZOR
   Q==;
IronPort-SDR: zL4WMYiYwb4BOv4CcvTR3yx6pKOMdCibqUzuxwESHBI3rG1bk7gOdvWHCzPYZcAhlv0lFA72tq
 AxGCYJMFt0LnoFmRFShhwjdJSwc2PnHwZjnlmYxmRb9uMRWD7CNZgVMIm+FsRRhMxpBBdcpSzv
 kV08VtSyP022vVNg2L3zGLb3pmt5V18rR1XfSSD0WweoYr9xzItRcZ2njsATduFsYdEiEdLWe2
 YnExV+J7qm9cHxITkWcilFkXv9y6KQ6M6iUe06mY7qWQKYYPFd1kLtsSjFUWUgAeuVwDFvT1UL
 3So=
X-IronPort-AV: E=Sophos;i="5.81,280,1610380800"; 
   d="scan'208";a="167577090"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2021 23:56:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mp/KYsUzH+DbtZx9uKbY5+KyewYBA+JtfI95vRy4mon6VooyGXZRa+rYnxeSlKaaxLAk0M0gNHMg6GxX+mWnuTWPfSWcbUr1/x6RNRKHyE+mWd6DhJD+aykwN3yUQukslx4NO1vU0r4pBM/P8uuz349cQiPucR/FRmruCBbm/cDYzEva3uRRbax0j288IZVnEJ2e0YUPvXzVSCO+y/6RPWmfEvY90JBAC2htfGo3olscjXqm2NOdEnvQJriVoYuYkg8IuyMDklaLTUZMdCUAqR6f/1s12O40M/Imq/KiSR+b30FR8wPeja9tTPjohmC9k8Bxjcuf3Mf/3LSCHDFtRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fx2Os9aXjaBpewWzeIcsQMkSV8B0dQTZceVmhPU5lw=;
 b=dIODDikkuPCEfKLykR9FgTA3jpK2iCCOzYCCM5DjsYgGzaq3cZbgH94lLZYVnQ5omQz+VpF42lSxvGidcdUrYzwaFdLucDD49BWXKGj9Sgl1gKptsLEKyXPYmvlCkn6HBhYBDOhasOxyD9Ne4E8io6VK0rNz1VknIcNPsgdvc5mF+WJTmI/mvtPeMcXg5o9sIyzv1Hp+dkoFBK5SylxrW7Yp94fZ5WPwtdlFPbzJbdGAnyEXdMnoJtuBDr1OKTjO1ocYTkVqlcLWfcSY93QyWWXHM9BD8I19SYrZEcZiFeF/ZpajKKnuyioiAHU0JitPU/xaRjwrVPxa8lPutEpm6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fx2Os9aXjaBpewWzeIcsQMkSV8B0dQTZceVmhPU5lw=;
 b=Y2YU/8NyewHg9XpE+XGVrcfOkt5bVMPTE6S7VpSrzD0C7RHcnC7CtRwiH/Ak8q6UAfrmR+VF2Wv/QMKSppFfYaZsnhxj7SGZwh2omtwN7wJdinJtQNS5EoEqo606yOHkxUv5z+N4Nn/zwRqsT3jSyAYv+b4zVKBml3ErKYk1OZU=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SN6PR04MB3808.namprd04.prod.outlook.com (2603:10b6:805:48::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 26 Mar
 2021 15:56:26 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::d5c:2f7d:eadc:f630]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::d5c:2f7d:eadc:f630%6]) with mapi id 15.20.3955.027; Fri, 26 Mar 2021
 15:56:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: zoned: move superblock logging zone location
Thread-Topic: [PATCH] btrfs: zoned: move superblock logging zone location
Thread-Index: AQHXGV/Q9cRb+mZCUkOVzV9kTIcRjg==
Date:   Fri, 26 Mar 2021 15:56:26 +0000
Message-ID: <SA0PR04MB74189A6C1B88D960FE154F5C9B619@SA0PR04MB7418.namprd04.prod.outlook.com>
References: <cover.1615773143.git.naohiro.aota@wdc.com>
 <931d8d8a1eb757a1109ffcb36e592d2c0889d304.1615787415.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:61ff:2d8b:7d04:30ae]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 07da2884-6d45-4200-28a0-08d8f06fb64d
x-ms-traffictypediagnostic: SN6PR04MB3808:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB38081BAB40A24779F550C3959B619@SN6PR04MB3808.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: baPRBekfUrKNU0GzOof6WipRMvHObI5smyDM45v7jG9B/BFZWlKvUEr1c7BNK/C1mz6/zahgvZWy2tmfvVW8ZfsiQQJARkGMG4WBs3R/Qz8IQhHJ7DQTqfVlAHZ78EA647GsiV0xrrGZxwi1iqNhoGltOMf14apvPvj7j2LsL/YOam2UB7czmatqFycawWgFVm+HmGJmanlcjObf4+yr81KDNXO5LF+rKBPbc0Z2+BiDhlpkNxMH0d4/CMVRpds5JZHlnHxWEAfEB0ip1d3LxlhIRk9VxRFRQiHuvRmbYAiWMDJcCsrb3QCK6+NEQRKuy99E/mBhYxBsVhjWP5libdEo5PPdc80EPBIgUbwLbSBzQ+YjUBQ6C+MwAqnVY57QdCXsAI66sJSoQENnSMAYbHQ8J6UovWqCFZDqc8j+5wQWtl77HM7iBTjnqviv5a8WRumTyMy0IxFBi+9N393GJ+vLmYXaorXyhMpMcYgFYs9mka5pv1JT/zpFBIWqbhDHuev1mcs8OR1tNoWD3TUnjqjC+qzg5rAk/9r3iXJ7+VuISZJa7xr4hnj/Ov5afEsmHTMvm/ryE6+iH1jn9LcOew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(71200400001)(66446008)(6506007)(52536014)(110136005)(9686003)(316002)(64756008)(86362001)(83380400001)(186003)(66946007)(66476007)(8676002)(55016002)(478600001)(91956017)(8936002)(5660300002)(38100700001)(76116006)(7696005)(33656002)(66556008)(53546011)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QVeV70eXwSKf/vW3OVjsCxMJ387qUGcqpjBgexYpM5W+ZgrM5H9e82caBUHf?=
 =?us-ascii?Q?Yr/y/aQ2Zbh2sxb52DeLHbFsUaySe971eTKSTX7ahOxdcplMLyzfoHM+QeEc?=
 =?us-ascii?Q?51Nf8HuUPUmLD6LO4E8z1yHPDyTswcJOq1WcBWqQDrnXE8VKw5S3B6/2EKbT?=
 =?us-ascii?Q?xVAipQRblpZWWt/rAJf7eVDRdehnO/xtxLAQ5tktaRBYnfUeYYtGTszJngQN?=
 =?us-ascii?Q?WcSyjDZi3qc6bcAgRJYqXJXzMrhTgsYsBxyWf4b5cbFj144nnIshDHmTB4uh?=
 =?us-ascii?Q?GQoPzgrqgqROpDg19+X+DBsUDu3XoNiDgomPWPbLsp7e3WTunuuTPkbRM+i/?=
 =?us-ascii?Q?eXj4rGrDO2aY2eiIJ5wu8TupLg3kiWDgOveSFN5c+GL8uIdbr4lK1WvO7yXQ?=
 =?us-ascii?Q?LslXxLtDYhkq5yz8I1ggQX4ZsGQJnLJH33GZ5CTMcx/+2W6cznsGmgCJv3+j?=
 =?us-ascii?Q?Qu+JtMV28rLcGVlTRxc2Zsbv8jLAjLQWH2b89VmAmZ1Ow7Avb9z9KulaoP6l?=
 =?us-ascii?Q?qAyRCV0aQYlE5wtX9ARUVMe5xd+jLZfCzxz1kiBGDFdc31ccWQVUnfnbG4yh?=
 =?us-ascii?Q?7CLC6oz8XP3+jmm7noEDa8KPQngIImASPAqw7aApQF8ldUNg24RBfC8leqbr?=
 =?us-ascii?Q?xZNLfdK1Vw4fX7pusOaRbv9JaM7jiSMk8YBIRiIPcjZvZFCITQ/if5nTTYhP?=
 =?us-ascii?Q?3YhTD4xbhaak4rWjvrqt+DuGjplofggTkfmQxzyeGgZ3r6hRSpW7N+VXzTrI?=
 =?us-ascii?Q?HqmbV+vJziNv7bzKyq+1UR6oPPXTc2tjtlDDV5nz9F8BNaG9PQRtJgrr01Xi?=
 =?us-ascii?Q?P15d3155idFrauM/1cS8MZNv/a6igrrjKleYp/2ZFt9VdIR835dZYniQxWBQ?=
 =?us-ascii?Q?1EKvxfn5bGl79qNKfmk0ZzGF2i8hhy3SIU0z4jYbvzCEYkID/RQJ1sqwzEgj?=
 =?us-ascii?Q?RdKrtlmNMTSXMUBNi0NQ7I9mrQldNeFwQwGDOcAbhpSdFzJHSIufkxxsZleg?=
 =?us-ascii?Q?pOzsi3+TJa4bNc4qffZrSasoW/WwaPJMYYw7jxZgumGI0Y1scS4Avrr4t8JO?=
 =?us-ascii?Q?abQY3yQYgjKkgQ4bQolBTQQ1CeVET9zno3S1Zdsh7yJxT46WkRQc/Adtboe4?=
 =?us-ascii?Q?SGMgHb41JAxWNR6SqhXb34tpVDqr5vhFR8VRS3KkWRzlLHgxRKlVGX13YAcZ?=
 =?us-ascii?Q?ig0//QE7tTQjSfZhbTPmCATRmDtLALIdP/86SM6NgJABkwD0v9hDJJNvjnp3?=
 =?us-ascii?Q?WYEZWdLsPsKujIrgJa1DprhJVFu7wj6pfEmEqJnkr6PnjF71amfmV0WidknU?=
 =?us-ascii?Q?koUrCQWUCzzOT+m73EbEQKyDHhPY/BXBVMSKsORnshDFO7qByef4+UVHNHZy?=
 =?us-ascii?Q?hdLpH8cKBH3rsEqcdnozsb7TizXU3UNHCX8o9QCYH6aC1Cc+EQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07da2884-6d45-4200-28a0-08d8f06fb64d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 15:56:26.2515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iIEhLDb8n6xrcqqte5lVQ1j1rPqeApNRPlkhi+WrhZUbVCnPAHULGbSKQu5qUbLuxoTneb4tfVomCWrlM4K7ftF9Yg8ijRSdk6bs4jEAUSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3808
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/03/2021 06:55, Naohiro Aota wrote:=0A=
> This commit moves the location of superblock logging zones. The location =
of=0A=
> the logging zones are determined based on fixed block addresses instead o=
f=0A=
> on fixed zone numbers.=0A=
> =0A=
> By locating the superblock zones using fixed addresses, we can scan a=0A=
> dumped file system image without the zone information. And, no drawbacks=
=0A=
> exist.=0A=
> =0A=
> We use the following three pairs of zones containing fixed offset=0A=
> locations, regardless of the device zone size.=0A=
> =0A=
>   - Primary superblock: zone starting at offset 0 and the following zone=
=0A=
>   - First copy: zone containing offset 64GB and the following zone=0A=
>   - Second copy: zone containing offset 256GB and the following zone=0A=
> =0A=
> If the location of the zones are outside of disk, we don't record the=0A=
> superblock copy.=0A=
> =0A=
> These addresses are arbitrary, but using addresses that are too large=0A=
> reduces superblock reliability for smaller devices, so we do not want to=
=0A=
> exceed 1T to cover all case nicely.=0A=
> =0A=
> Also, LBAs are generally distributed initially across one head (platter=
=0A=
> side) up to one or more zones, then go on the next head backward (the oth=
er=0A=
> side of the same platter), and on to the following head/platter. Thus usi=
ng=0A=
> non sequential fixed addresses for superblock logging, such as 0/64G/256G=
,=0A=
> likely result in each superblock copy being on a different head/platter=
=0A=
> which improves chances of recovery in case of superblock read error.=0A=
> =0A=
> These zones are reserved for superblock logging and never used for data o=
r=0A=
> metadata blocks. Zones containing the offsets used to store superblocks i=
n=0A=
> a regular btrfs volume (no zoned case) are also reserved to avoid=0A=
> confusion.=0A=
> =0A=
> Note that we only reserve the 2 zones per primary/copy actually used for=
=0A=
> superblock logging. We don't reserve the ranges possibly containing=0A=
> superblock with the largest supported zone size (0-16GB, 64G-80GB,=0A=
> 256G-272GB).=0A=
> =0A=
> The first copy position is much larger than for a regular btrfs volume=0A=
> (64M).  This increase is to avoid overlapping with the log zones for the=
=0A=
> primary superblock. This higher location is arbitrary but allows supporti=
ng=0A=
> devices with very large zone size, up to 32GB. But we only allow zone siz=
es=0A=
> up to 8GB for now.=0A=
> =0A=
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
=0A=
Ping?=0A=
