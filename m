Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476FA30DCB9
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Feb 2021 15:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhBCO2L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Feb 2021 09:28:11 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:48560 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbhBCO2J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Feb 2021 09:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612362488; x=1643898488;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=T/4WrHP5DQJuzyxmOK990XNNEginC0shJysASazRa6I=;
  b=AhX6w/J4WpUyvloISbV1EqfGNSbVlycfXLxOUJXEnBJxlo/kJipwD2I5
   AnVeksV7xAgwpj6Km5nbWo3SAgQTTcgtsDcpv4MLGmZP6cSwkE58M+Kvf
   phZgSdAyRZTAEoqwKltbUkYQfJnr6TmskiA8HSGEhugov2Ygljgr3bopP
   PWh0SzTOklcT0bJBTVDDFAYFfNbr5AHApFZaXaUefWSVehwxV19B0G1bw
   wY2S6wav29kDxrjMU3u+i7xLayG2Y63BYsy9/vLxXX4xlnvBHCA5T0p84
   FXOie08QoL+4tr85bVWUaxHFFYPq2rGJA9Cbyx/BGSbrDGvyAJH+GHUGP
   g==;
IronPort-SDR: dUg2paLC2tPQEgrcgvXZooNW+2oJTz1MV0M58Uepwn5A0tmKhk8MFUuPE/jjjPfxd2KLaasMSC
 4iTuxUQvmtTyTdNj2x0dE8MBB9g9/MTjp9CbyhS1s7tjrDEUHEbIQlgnpyCJDlRMbZhNELcfXF
 XBVMvPwv5CwxIPM1nvPGPrJdxZVX2PIqL1RLczSIhXdR9WzyYRylAS+liP769hdnY9cEprjffT
 US8OaOMnJzKWYtiY+ekTZvP6jAHhsBfqcYO7mxW6GSidZj7FFpicr2gxB685KvNjSz4mdwwq2q
 A9g=
X-IronPort-AV: E=Sophos;i="5.79,398,1602518400"; 
   d="scan'208";a="163475231"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2021 22:26:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8gnh6rv4LjnCACZNRhxhwjpLnky3TB5M5FjLvZOp5b8KOh2wsBrTu0DBzRs6I0gKboW5ehi07FTU+UuEL7K8vAo2Q/ebVFI5DQxVylPsUUNEbEY0ZpDEPXzCprYZ0kJYa59ew9GTNKKeCTHYxanjHqTCoTBCr+dIX2t+v5qwzlAIUGbh95jIg9nGQxWmAWu8OrC3waKfr2x/23vQszjLRM6EpHfw+gqMwkdEV+4wvwnXegKUItW/Fnb1oNDQMRi/NG77Ecc5mum/T6pwiF1BbBX7BEyh9Z2aaMe6UY9R9IyRQS3cC1OU4XfssZ8HExa7jkzIgbACNFnPo8Pvbcyqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PO5lauoZaBPSUBjWcQ62Y1jx/WVcUsBs6FpyMbKGx5Q=;
 b=nh++3YuAbTpVWTeJgJpMKzEdsIqHhxPQygIjPKFGqXq7+cYDhF8Kln+6oTr1mI6p2iL/ygSgkK/WjPR1lR6lEa07TopGzLOKJSRtbBY//lV5n9+BADLiw3MLWeM2ItVBC2ASZ/NfNp8AsPXAz8GOdeAbfvAX8t7GAxPzPx0opN6M5KXZtNCSJBVmn1cYhBqw74gbJmv6uhimlpXo5wqxlus86tOnskxRVJ6BKUJHAdCNWw+ZG7gqTPuOlszmVvzFV3ykbcAh7b8JVs8+9gOZjpHGDBrnjsLFE/O0AhHOkqk+TPyHde6Q/rcNhoJ5DkQmz8msBTAP04zbba6sKJEyrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PO5lauoZaBPSUBjWcQ62Y1jx/WVcUsBs6FpyMbKGx5Q=;
 b=oIJWAwYa/nh8QRDWxbutOtrpUqJv/d0M/qoGR9V1M7/eyTpfmxhjX/v0+FTDVh8ziRBB1BzJbCHxglSPBur85dCnt81ze3MsD1vW4agzBXKcPxG6vgooqMh4K5ahdBiL9N6ZNmZZ9WU6uLdNb3Oult0wUfQCb8hpKtkh+2WhUa8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA2PR04MB7595.namprd04.prod.outlook.com
 (2603:10b6:806:148::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Wed, 3 Feb
 2021 14:26:59 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Wed, 3 Feb 2021
 14:26:59 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [bug report] btrfs: mark block groups to copy for device-replace
Thread-Topic: [bug report] btrfs: mark block groups to copy for device-replace
Thread-Index: AQHW+gqiMTOgTmw7ME6uYHES0uz5iA==
Date:   Wed, 3 Feb 2021 14:26:59 +0000
Message-ID: <SN4PR0401MB3598D6C76962E2CC5925A9AE9BB49@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <YBpk4PZ9hkOl+aKj@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:51f:6b4a:2171:57e6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ac0e274-b8d4-48da-b760-08d8c84fc41f
x-ms-traffictypediagnostic: SA2PR04MB7595:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR04MB7595AA84E23016ADDB977EB69BB49@SA2PR04MB7595.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tK/TTLWZRJX2av0XNiQBnRJZcg1sYiUNMNHLSjQqSrJccwDodmDcPBp4p5BntdDslYC0qsNpFJVxGEq79CdJ7tUGcYTrrHj/zRl4wVlUxrYsCu8herzYBw32zfB9gPC2AVizwn5irj4JmQrHQsBWRZ1N0oR03IRGGZiXWZnyaa5bUE+pJswnnlDhs+XsxVZOLGnjKi8xqVmJRE7JR8C89ksdRFa3geedpRX8nIkFt9PYW6iJ+d27zw3TmPHsx5aImqPYdxmv9oJtzIBQFtGp3pga5hE5eegUn84QnNUawujMbgI5nS59bE1aV9j05HDvBhMhI7sk+seEI05hZOdd5Azw4GSkmH+qgfQX31qYivh9jONfg4a1+H38wp1yIpXfqGxLAAM/WouhEKQBq0EBs2cAEvzeGYH/c5zCFRHocWiNPW8SHtQ8e16AdcSMuip/Z1T/UoRYlMVKnFWWcVHaYJmqbbQGQioMPCh2QcUM5CzMbxj3T+KVD+EbiOyE3h9SiQqrKWiOG49MHOFoav0tKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39840400004)(2906002)(6636002)(52536014)(66556008)(53546011)(91956017)(66946007)(6506007)(55016002)(4326008)(76116006)(186003)(478600001)(9686003)(86362001)(8936002)(8676002)(5660300002)(316002)(66446008)(110136005)(33656002)(71200400001)(7696005)(4744005)(83380400001)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MugQbtd1MumEzU2ZNoTw6MartpGiMatR2jCY3quf4YekJt54l11iK8gbJN55?=
 =?us-ascii?Q?I7Wf/s10miIn8nj9LljiRdNbAcbOifnEBEYAYb/Mb+G7ge5+wlzoEMhl+48V?=
 =?us-ascii?Q?FmIPpewpjBmNuIz+KQY0DaEG3ofOZEy7LIk9Y9AGxfA7lLJ+IeHfIlUfn8Yh?=
 =?us-ascii?Q?jgl1Y2k6YfJpogkVZnrEAJ0HUUIXl5OsLm5sZJ7qqxTmMLPqEBKE0LUAeUWi?=
 =?us-ascii?Q?LKLw4VfivfLxOIuIRJg/gwTRRzGDJ7wWb58M0iUqqOUGK+AgKsI4f+6OFbRD?=
 =?us-ascii?Q?J+OVnMhq1+LhQSVomMcJgxm7/hSQHXX/w5k+KSsqF4yU67qBoel4H+3TBV1S?=
 =?us-ascii?Q?4PR/obBjyr8M1Xw2KZuXoJMikoGSaPVk5DdpzCvE7HvKHgMICzl8Y+l5YvSN?=
 =?us-ascii?Q?+HtIV9uGDTRbQ8evoTKLOVtcSMjZmbF1GHjJ60FbSB+ZvMQYTtD4k7Jjz04Q?=
 =?us-ascii?Q?K5OgInM7N0cx+RTS2FJGbn/jUl0XwoObhymnjeOI3hRT48J4aXm+6gI7dvH7?=
 =?us-ascii?Q?f7QRL0E8qEWMZeFA7y1iw2uecglAFrxUkWZqDj0zcbKC6KKPOw1aa+ASRqs9?=
 =?us-ascii?Q?0uKty7nJa0Xl8AZ3QJ3pgztt7aG+CBS+7P2BVlopRKSa/YKbSaZ8Cx9aNBiC?=
 =?us-ascii?Q?j2IJDLWv+pYAjS8bPkWWZIAi//MRY9wraU/c4q95OIqyj3vPqSx14h+oflM5?=
 =?us-ascii?Q?5e2wS1SX1LAyGx41mB0kZfYUG6yneZGpxAHrduheRLH2c7Th2lPTHfCJVmwn?=
 =?us-ascii?Q?1KYt6agytfP6n6rVxy0CKDYgRyMF/vwJ+6cE52UBfpaAPF8cBQx+67sIXFMH?=
 =?us-ascii?Q?uhEdzTAg4DuGN/QUq/CjqS9VFI/6T6XAMBl6qOpHy1wXVKfg9zNlCQShN1s0?=
 =?us-ascii?Q?wROKqSBXssGeevvsb7eOwIL8C8LyiUNvmUjOgW/MUblbcQrvp8ET2SXaqiIo?=
 =?us-ascii?Q?4xo/pYE91T5/mKS8QtKPTKbK7Vw1f45GyZC770825jInnhcLLcs0A6awO582?=
 =?us-ascii?Q?/pg5oNxFtFR6ofuv5v90gpNIdunfg3CJmdDRtk7h8cPmWPMJj1olnW3xeaek?=
 =?us-ascii?Q?k6rgozAzZVHxK8Kub2HfPXQKfKf+1AoAPDh8DIJboKKXPrSmj5czHZTO3/2Z?=
 =?us-ascii?Q?hlp/BKddKyRuYfvTsCIOKYG9BiHWmZdL2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac0e274-b8d4-48da-b760-08d8c84fc41f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 14:26:59.0300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tr8g2C/ha/dt6G2EA8n+AZorcjZ9szIieoYBmtZ/SHQH4XeJ0D4V/XM0kQdLo2ABgrzRKgIxw+GMuCwW9i6vdPvEUv3tLBhFAz3WU+hL7I0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7595
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/02/2021 09:57, Dan Carpenter wrote:=0A=
> Hello Naohiro Aota,=0A=
> =0A=
> The patch 0d57e73ac5ae: "btrfs: mark block groups to copy for=0A=
> device-replace" from Jan 26, 2021, leads to the following static=0A=
> checker warning:=0A=
> =0A=
> 	fs/btrfs/dev-replace.c:505 mark_block_group_to_copy()=0A=
> 	error: double unlocked '&fs_info->trans_lock' (orig line 486)=0A=
> =0A=
=0A=
Fixed thanks for the report.=0A=
