Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2E432C52D
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 01:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444298AbhCDATj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Mar 2021 19:19:39 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19697 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357571AbhCCLKq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Mar 2021 06:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614769846; x=1646305846;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Q32QRsRtvtObYYuTNzLNG3+HC5lh3SmW+ga9yYvPHT4=;
  b=I+BqW/elW4Nn6B+j/2M4ZrE/8yp4lLAgxfU12lIDCIjRmk2pSGFLvxfn
   sU8dBd3yCGxP1FzpeX/IwECLDFA6Mnh5XtqmC7ME2VcQkyoakktjxE6kM
   DWkLLrHU/BmykgkoqsZwbpKEvI08ZNJUJIS9XHXnfNIJchT8Ls0kZZcJA
   oPCmqQuPEv0aF0TFpWcYc/sCFzkPeq09khy9ZvCqloSXREsJAOtmW2quH
   2osYWpzMU5D1GnfqibG0jTZSv+blPrnMtk18bPmHSHsA4IiW3Ul6I0XI9
   QkHJk8g2FuSnTFo+pe2WyjNX21EL/rBrhnw6bxDCcOnun6zb1fRitZF9U
   Q==;
IronPort-SDR: CvbOVsPxnS0aUoUKNwG/JsVU1bpqu3e+Z5HM1nT7BC3pr5DLQMLWDmVyn8MZi1rl/8fiLiMeCR
 FxaYjtg0JiSA8Cx72cv8y5OcFkdDO1pWCMqMi2qY9qQfjaX/kPZy8d2NDI7XT1+r6H2N1TOvtc
 Wk7vH6k5vULrorW/fSqxj0Rqn/qvULn9l8/d62XZyppkQd0XDveuwK+22QUElx1Yuv45nySEDb
 TvpKlM/Lu6YVaIfnqunZ/3344FtKbuAL3UAuTZ5uyPPf6lht5NNGBVj8hG65YKoqC97EayvRH6
 x1A=
X-IronPort-AV: E=Sophos;i="5.81,219,1610380800"; 
   d="scan'208";a="162403546"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2021 16:31:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVmI2tg8YqiXvq8+UlbAqnI2d3WSJ06J88Y9b/xN/A4CjDJtLKRkaGhVtZAdCHhVlPEeDU9DcitTljdi91d7EIbALibBwKD0jrXMK0/QEPt8YXMMBWY1/4hVxOlg0rdmGxjO0Zj9hLlv1lEMtnOYJiaabscxw7CQngMzp2p2FptrrDzApCu+62R6qwVGrKRsBp2BMU489C6HabYcp9Awa3FgB9vhNYQR9q0DDkgI5C5GsVVm9OzNqlBk0vetd1ukWNKGjmG/C2n5pgYXYaaNa3YK/LM3v7B6yxKKUx9NaLjUISsEtfmf7JLEUUnrz7K4NoCB1Nj2rqyCdoHjS0bDZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q32QRsRtvtObYYuTNzLNG3+HC5lh3SmW+ga9yYvPHT4=;
 b=eHMBOy0eFSoXL145H8BEoejOaG4tZZeskzO0tA+8MISCr8mbhCgPP8GSxZQ7YBXSB1Kz5kVifOIPJNvUfJeAIG7S7BM3dYetv2q+MPP35MmBv4U1o4cgkXqNTGG7sv7++/UA3t436jHOeh9xDVG8gxu9HWMqbRPOpwQg1emiYBSOaytUdRV8GPSP41CyYF54PsJc5qygZhzpMOt/bFQQpzzkmSOZU21RBauRXdiI1W1dh0T3uPMfIi7UM2oeM0Mz/mAaadvWbs7ePaf63kv17n4ElyE1q2AKe9xPbb42sQnGXVFpYrlmbP4oTBcRSxZSy9lidjNrjfnE6cTfxmvgWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q32QRsRtvtObYYuTNzLNG3+HC5lh3SmW+ga9yYvPHT4=;
 b=SaodQtWqcp/DI/XumiDK9sTP+ZOji0+tFZ4AZ3NkpG5GN5ztQigOSnO8LxbjqznTGj3hVwtnBjGg9+RueEuoxjcLRYb22oWdubM+Aq1Oiunm+BqFowhls7kgX4ok4+0dPyGbHBtyz4mf1d2jwG/hngAIG6HjdpH76ZaJSBMmkbI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7223.namprd04.prod.outlook.com (2603:10b6:510:1f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 08:31:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 08:31:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Don't opencode extent_changeset_free
Thread-Topic: [PATCH] btrfs: Don't opencode extent_changeset_free
Thread-Index: AQHXD/Kh9FGFKPxatUajIduLlGK28g==
Date:   Wed, 3 Mar 2021 08:31:50 +0000
Message-ID: <PH0PR04MB7416DD79206D2FCBECB7C4BB9B989@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210302104440.2318989-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:ccec:1858:7740:59e7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09c5fe8f-beec-46bd-8d62-08d8de1ecad4
x-ms-traffictypediagnostic: PH0PR04MB7223:
x-microsoft-antispam-prvs: <PH0PR04MB7223B8ED7E446129BF07B8A19B989@PH0PR04MB7223.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RXuslMKf9hqz5stq7nMhICdQN4qq2zQadAjqrZEt5rMkW/zYCzrxZhX81vM7RKrkuWOMn3cfdHouI1+CdDZv/mAki2LPbPU22ESisDjXeUk+5Se9VeY2sPZ0fxaZLwrIB3x3Foq0tKx+j90DeKZMKUifeuZG1yMwL0Qg60sHzoCPSQKOH/G1Y3+R/dAw46KTcCzJBTmBhD7uvv4k3Vi9wQ2vzjRDO15UjnJ7ANlUizi1XvhuVtDCzLmUE4SOIjn7gncUMYCV0J/Me4tkVBVdniILVXplgvgH7bJFLTFOKzLTdfVeVs3A/RzgSzD1Xe5CvyYjzwn2CUbJMqTirm0qUvg159k63PXnz7siPm2q+A0pE2HSHazVQQX4RBbQtM3Y2wK7cM/rwCcxn9hxdmqbfX53LgnEQ+dX5NhEC3t79rsrdXu89AWhw+JVstPxLg3TRkMIOKofAr7ljxix/0gR9EIA+j+bDK9U9Wrr+XReaKQeAnkQTIeapf/uBYdVczaF0LRRQ33Yw7WD7+XVFeQ3tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(66946007)(66476007)(4270600006)(8936002)(8676002)(86362001)(66556008)(66446008)(5660300002)(64756008)(91956017)(2906002)(55016002)(478600001)(76116006)(6506007)(19618925003)(52536014)(186003)(316002)(110136005)(558084003)(9686003)(71200400001)(7696005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vc+Yjm/CqPXUkXeia6Caw2s1Qt24lleIpXM/lYPQWZSDZ95ICGcj/5QaOOhN?=
 =?us-ascii?Q?dPPRTVpcBiSWlW3YEEjZBvhwlnszJGh6b+KPiD2fSqNbzDyFiZepqVKuGBhk?=
 =?us-ascii?Q?ApYrnSgf/xK4gJFQoVAyqmtJGqGpz8UOp9GMYpRuDkBDaL09qKVBhGf9L9Jf?=
 =?us-ascii?Q?ZCozeTE6WkjOV4Lss3RyPIOiEgQua090hv/L8kR6IVElVl00oF/NDuzGEwtX?=
 =?us-ascii?Q?CAry04myV10sKnZMwQ/UXWlDp1AcDvfhdRzEl/82mYOU0e8pIgeeJng2eI88?=
 =?us-ascii?Q?cpLsQBqWMI/bWlbfp3ld8nh9krXl3/4hZzidPM51HkF0dbzSpTYLEYPbEfSg?=
 =?us-ascii?Q?N9cKoCmhYdu9HfnWj0j40f8WM5kWMUQKYpcshARl4YMfhya1wywK/WODMVjz?=
 =?us-ascii?Q?UWD6f9mrchgpg/V6BAUVLfNlpIB1sEc54j8gz3DnGr1nC57BV7Co63G6r50+?=
 =?us-ascii?Q?b9LiEDfn5OWHQ4ukPR9zr8VikBAOdA3fxzgNPhWspDSs4xb8I6XB+VJFplMZ?=
 =?us-ascii?Q?H1U892p3FLlIGjoV1Xe04pgZ6E0RXFx2MwcXSXxQ3dfxLoe4hyDCyv4dcedK?=
 =?us-ascii?Q?weZnqnf1tym9j9ecL3Le9oVEeNFEqQKZNU+Nou2V7eDMtYIysJzgn69kMpDj?=
 =?us-ascii?Q?NPJOORm3NGB7NODy6F+pRmFF8MU/rexxTI3M2GGtGSj1KV44/5JbVWXNGobz?=
 =?us-ascii?Q?OmKAiJuooGgQg/2bZ+j5DeukW0d36AaETpML5mLwYCP0A3IPzqzscZfGlQL/?=
 =?us-ascii?Q?hUlVCnbCBUKtjCmr4CUJfXRuqdUZd4tLdk2TV3p8oZ4xBWEyGVrFJMLp6WIu?=
 =?us-ascii?Q?v11JtZ/p5ktCYfKfrozS3yhgkwWzq8eFiTGZi7REd7n9nl4CLgkyJ0sZMI/L?=
 =?us-ascii?Q?hWuNRYdtokrR3uMmAXqNRDKvKJwB6W5I+rxOedxK0GeEIoeldhmqc+yvV46y?=
 =?us-ascii?Q?7LTQKxsq51p/z2JMRsoMN6ZfsNuQbN7fGjgEueIy9HDLCkHDFEGLB+JqGg11?=
 =?us-ascii?Q?vizzQ5BNNOFpxjzIV2epsaG4GW/JIOVtkxKk1M1FmQCJuzze4p3UTLb+ySmh?=
 =?us-ascii?Q?0aZCWxsPlJwJu3NPoIf7kso8NkdepA/ceEu+hEAfC9iXBmNv7v7n7FvGfhZd?=
 =?us-ascii?Q?5WcGouXmfI/tNhWc7FR8ho6RRxAEr/nUoZz9cC60dIggya7OLEfByYv7MZEv?=
 =?us-ascii?Q?+3UBB+BqWPWaJV9ZMyDQHnIA3//HBVRUqK3zBpQc2nJQc5aW9RaibGjMp+D4?=
 =?us-ascii?Q?JZMF2kBVjfM7UuDDokh2nesdYufbbC5zDXXUwupVYgqXSIyZmgu66onX5v2f?=
 =?us-ascii?Q?lo4afzdPdNxYPM5yJ1vLiD5rbEHE0kR1IYkgfKrvn3LTAMkDCw9LgQBch02u?=
 =?us-ascii?Q?futAqSREuRTVyepBYDH8w4j2q/SbnPVvA10CFxNrsDVUOOKVJQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c5fe8f-beec-46bd-8d62-08d8de1ecad4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 08:31:50.5102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rsQH5Vy+DQy0muG2EC2tDvC9sIjxCqWQrWHr9JYj+a+oVcXRd/7wLUewUOIg3lifW7Hml+a5iuCSY1e6J7Eg5ZsXyL/GDpOWSKvWmBvmFuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7223
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Easy enough,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
