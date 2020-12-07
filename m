Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC742D0B13
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 08:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgLGHYM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 02:24:12 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:47303 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbgLGHYL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 02:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607325851; x=1638861851;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Ao66EPI6h5ERgpkZEwF1ZZ9saCL7UOrMQoDHOQBsbgQ=;
  b=HFaOC0OfgUNlOOsgM3/hM/UO4fIGYGTJzZIzjebzkjg4ORYItEVZ2uaH
   jZLrkUlhB7kTWGrkZcAJd/V3L7dq3I+U5cmRWGg8QSHWuxSjJYLCxP4/I
   11g+JyUtn73Sd38ttF40eEtdTmmjwQ7WZqj7RzjvdLs2vlXP7CObEgC93
   T0P5JB7s+AU8FAfn8ILAevLShu5qcnRmGG1KkVh+kTUUzgUA6sYRW5iQ+
   KvnTStzY7C38g0imI2fDgskU4shr7Tum21UXJGlB53V3e44yj6waKUa5+
   mkbtATotvz8YpYrDlUVqh96PFtpfy0kdx/juJy7N8nSi29f7EahfDol94
   A==;
IronPort-SDR: qI3ioRfr2J49AaJGxeCWsCtapRsj5UQ3osi48LMrysVg8yQaRXyLBomARCC3BVjq7KfUwmq4Uc
 1j3yxAbU3vgEdkxRCldxl+zj0xhDh+N7RDAHBAYeZZJ5L8iiCTBXKJtEWQZ1XeafA3Z9XzdNMO
 TINXqhnHmbpaSvvtyQxYIY6XOhKkB8dN8gFmwZAkxVKwyomZYKUMiJ7NG/2fNTT56rcz1cTxIQ
 bGAWHK+6My/FW4PR7YDmrTYf8p77+uZYAHnmO9XmUQnDso9m0BdPS5mDYpnDvZTuz5RqLgqTCB
 EIk=
X-IronPort-AV: E=Sophos;i="5.78,399,1599494400"; 
   d="scan'208";a="154549258"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2020 15:23:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJ75qPQMDuCfwmDxcwPdiX/itfOsJ7Cgb8ORhocNy3jBu3ld0EC+0CmsAnz5sW2Iwuifto1x5zWrqtFb/Mm2Sw2cXyAl5XixtdW0tk5mKIqW+oFWbeVEv7n4z2i3gHn4VUuqWj16Kvj8UIeIJaoOjV0eu6KIxMKdwmVCi66jvsqhp5j9Ut3PKof74HOXHDl4hYcF3kQD7upNHrbtoLp/jCsGDqdyEQeYjsEQs49jdIxH6Shyh9/RCo/DW5X4Xo7KaV0HScUNaOgioGd7ektz7aX/NTQg+sSkPUJsHzoKnGqNiPJuIcE0pWNb+Hl9NuaTDcEeUXktf1oj35z0oBy5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ao66EPI6h5ERgpkZEwF1ZZ9saCL7UOrMQoDHOQBsbgQ=;
 b=HAeavnASnGzHEC5g1tHTKgBGE+GgD8B6jGfNgEI6KBbFibYRAHVCR3NtZ5O4bfmIGTuRjub/uTKIj+3oBNGpzA2NL+v9jw3tbPZXHTnwy0WSxc780vmCeaoClVnqach79j+kbivI3Z8Nsy8R1tMI6m1r26ArU3qkWBLFP79dL5ZjJvHDi91VFm4V/ko3T1PmLXzBMM9FcHu5eQI3ybzELrQS+8r+z02gF4w4WKFODZPEhlrrK04odt/C8dKPaOKv001QvGvz1pn3tackAMuGl6TQ/BKdRJsuGxrAOihr0XyJGACl9C40//hHJfuTgWYx1c9Kx6olGAHWfP0UNx8oug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ao66EPI6h5ERgpkZEwF1ZZ9saCL7UOrMQoDHOQBsbgQ=;
 b=G6+KNyzZBaqAkwQ3+WuoUcl0MLgXM0s1IDcZppF48snmr2eNmrq0B8wjpkaNs/dOp1WHBqfSJWttX2FtOE7WxL7I2AFQea3xQvUxEKN1IPWUT38zcAoeb/LfNmwKJs6jQCfEXgjxBsNLb88XYhlJzSGQXqHDN++7dR/3bX9QI2s=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4605.namprd04.prod.outlook.com
 (2603:10b6:805:b2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 07:23:03 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%6]) with mapi id 15.20.3589.038; Mon, 7 Dec 2020
 07:23:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Sidong Yang <realwakka@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: scrub: warn if scrub started on a device has
 mq-deadline
Thread-Topic: [PATCH] btrfs-progs: scrub: warn if scrub started on a device
 has mq-deadline
Thread-Index: AQHWyzejHW6Ri+MjBUuw45QEtiWblg==
Date:   Mon, 7 Dec 2020 07:23:03 +0000
Message-ID: <SN4PR0401MB35981F791C9508429506EDA09BCE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201205184929.22412-1-realwakka@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c8a9bb0-60de-4fda-1cdc-08d89a80ef62
x-ms-traffictypediagnostic: SN6PR04MB4605:
x-microsoft-antispam-prvs: <SN6PR04MB4605C718CE395435CC1848939BCE0@SN6PR04MB4605.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KW2dXnjdl3ipq2WCIDvUiGqTlc4MCesSgRZQlcuzWpT/3X7sjskn6zc36i8bKD/68PvVJKdcO0LKNkxDTCsLjnPvXverRfkYlWUYi+1l+JQUh8vzWI7/5fPv7FudwLpkty+SUwUZpbrR6dq67u/DIYf1BD3tFZ+3kbgX15JIxbWCGn8I8jX5vUMTm9aSSywuWu23UWYv8rpkQTZ1zK+zTpTleppRR0wwKqJ2KUlS2B4BAMtlVSiHi8BLufwgZZk/8nUTHMAmdzTMa9RhpYgo36+5EQRPR4Xw4lk85DKwH4MGixsyjyoLcHOwomZz8fgi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(66556008)(7696005)(66476007)(5660300002)(76116006)(186003)(91956017)(66446008)(2906002)(53546011)(52536014)(478600001)(66946007)(55016002)(6506007)(64756008)(86362001)(83380400001)(8676002)(9686003)(33656002)(8936002)(316002)(4744005)(110136005)(71200400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?60lRAwZvxMiXVHSCHtnDdOxbvecFqCUhmnHAHS/IRTbrYWixleApZ1zH48lF?=
 =?us-ascii?Q?V/YhYhgO4ztQFmvBk/Io8DfTD0WJw7YduLYUrstyDb4a3LgAPfCdBek1C13W?=
 =?us-ascii?Q?fWlxqyWDS8QmMhnFSJF8A2pFNbUFVKPwvWR2OVns25WupfYAUU8bOLspSd9Y?=
 =?us-ascii?Q?Yx9ApWe0IB9rANFBpG+8Jk3DBnyOYwN9cgRelSXrSEjWCv6vW0l+Ki+ZZWiA?=
 =?us-ascii?Q?bFP2GooKttaliDwCoO2ZRiJUYfnZGGUB8268EKaGCmJF8pmNk5STg82CXZfO?=
 =?us-ascii?Q?qbzAujRixetYnzSs9aEuZcyrOaumDwyJdsp/Wg+aBF2eGjvlfoiJW0peJ0eA?=
 =?us-ascii?Q?CzGtACSyqxDBeTpvRaFvgPADwj+kLUVYwimx+PWgPQNNiPpTk0PPIMMoMeaz?=
 =?us-ascii?Q?N0aM/eBzXacpPsHbn84h0DhoTpxj/1BR3fpRZIQCVtZMPNPz+kua1EnphghX?=
 =?us-ascii?Q?R9yK4Hu2XkJaIbPW84dyZxXGsHW4oM7NaY4RHSSC31epEMSu5AOG0jBIwL8v?=
 =?us-ascii?Q?d3dxQcX6XlzdYe2d7yImmGVVIz1e2aifuw/IgVhi7wV0rfXdHVEiGfyO+AKT?=
 =?us-ascii?Q?dlhtm13/jKsSdcWqpEzu+GUzqfj04d5+czwocEpaZSp9vhoHS8fv+d6XZ3Fd?=
 =?us-ascii?Q?TeyEj9bR3at451K/KiKpOv8AdTRkzCs3K8eHuhyGP8nC4/30JKE2BdZ1aMdK?=
 =?us-ascii?Q?8IXVcLjf/5C0Vtz7oZcq77NostBoEkgLIkaAcMDnHLah9p7QjhGWbkstnes1?=
 =?us-ascii?Q?TTYtwSYBofQyrtouRRTh5xlRiBG7rRjwAyigwdNReLSl7YW9Bh+iYr3yWC4h?=
 =?us-ascii?Q?gHc2r45AckkrjIq4xLsJOnfokZnJUF3SLmhEU5JI4udL/TF5YKjlkPFPQ8UM?=
 =?us-ascii?Q?40nSX9x6J5qUcm6ooas6oqMI6TCl6nQKQOQQwRF0CB5w06khojVpREK+jtw0?=
 =?us-ascii?Q?U1B6+aPeqcB7URa5AY3SihrB+Nh6kaZoL0yPDw2U6bBvH3sbGh1JMaBkE50a?=
 =?us-ascii?Q?EZIJ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8a9bb0-60de-4fda-1cdc-08d89a80ef62
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 07:23:03.4261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6L1gikZ8A3eBiriQsAUvraDjxHiPX2pS3wjGQLFPgM7VNOUYn19VppFYdFloTa9EnnmI1yBDMDR+nkTJw/6iKTNkTdkIB3m+mTKhX/lYO8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4605
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/12/2020 19:51, Sidong Yang wrote:=0A=
> Warn if scurb stared on a device that has mq-deadline as io-scheduler=0A=
> and point documentation. mq-deadline doesn't work with ionice value and=
=0A=
> it results performance loss. This warning helps users figure out the=0A=
> situation. This patch implements the function that gets io-scheduler=0A=
> from sysfs and check when scrub stars with the function.=0A=
=0A=
From a quick grep it seems to me that only bfq is supporting ioprio setting=
s.=0A=
Also there's some features like write ordering guarantees that currently =
=0A=
only mq-deadline provides.=0A=
=0A=
This warning will trigger a lot once the zoned patchset for btrfs is merged=
,=0A=
as for example SMR drives need this ordering guarantees and therefore selec=
t=0A=
mq-deadline (via the ELEVATOR_F_ZBD_SEQ_WRITE elevator feature).=0A=
