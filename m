Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FD02CD12E
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 09:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbgLCIWN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 03:22:13 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20836 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388109AbgLCIWN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 03:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606983732; x=1638519732;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=k247qnD2GTBkvUttgD6zi2Co51ocRp2h0EfK/adyqgVN/fxuqGGvkYQp
   huQVkwAd/x3bcFO8N/P3Td5acT5RmrQrUF2T6Q1gKwPG0vUqpzezWK/Ij
   XwOscRE3n0DhaF63jMJpH0bAk2LaJgOJ5qM004HvRhTjlqrBXCvWue+4X
   W4WPsic2a0912Q5XhRHsPD6yjhIV0jz6gTEjYO+PeF5Jsm9UoZ/LAZ6wT
   7Jyu+/MAV8bhw0JhYEzaerlOxEABdugoVxNl1jKn11g7RAOFxdJddO1bK
   NDNOGML/Oe9yjOkbD1a7fnXlG4NnErnnCLEKGcAQxPtWgQzcP/W0K3xKH
   Q==;
IronPort-SDR: o6m/7Aa3pW01BFSlykVzb63rjEvZpgrN8ctK3X8TMbUguLHlZICvOCkYGcsddMN0Llqdv7n4bd
 RhoiYxsPjjsBIBi9M1kf7Ktd7/gNVnBoZG9q0YhGbvtcaXPNh1i0KDe1OCRvfLio6SR2yrQ+u7
 xXYDlooqWwhZy6LW6D5k/6Jixzp3s7sBahbxhqa22G2IDEGAJQb++p1BZ4WKSeju2obuDdERRz
 c4OQVJs16dYpYyp1D9u5itH8DRALtQmqn/of6DvfuscMKrY8Ca0Ux9TKPFiNi7rQYyOnHOI3zS
 x/I=
X-IronPort-AV: E=Sophos;i="5.78,389,1599494400"; 
   d="scan'208";a="158709350"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2020 16:21:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kN1k1ZDCvYg8DSPeB5dGt9egadHeyfIKnEcUCetqfxkUYT5+9hmToXtF5ErcnYYnklOihSj4m1/HMcT3aoATdlXN9HJt+xMPFXAdnm7dw3OS/t30ip9Dhf7tRYWRHOxWiSwUoeBGNk+PxcGEjyp5KCf5ftEonbK/7EKHOaykVhwfdUs5hZJ1OlMUDFZhG1DwogtK3DEz1s1k+xaymjKoDwalbs1sb7seiVFYK+ZmVfl8QTXQi/4FzKf96hDIarBVibjjDEK8wZhjN/nMzoxNxcLbDHLXrVjz/utEj7MDPkZaY9XvlgDO9sMJWKb4oyijWDhQyObybHyJ4EbVeAR/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=O/rNvLpK39Dr3nrFTl3/JU0reXDknmnToELoalGigU/HgkZAVcAMqf8gWjeOFcfsHvQbv4/ux3DsEi2VNTTKt+bskp87fm/Czo0ZeRe2/lbXi/i8Bo2KHSOqow8cERVt7nup06HKr3CbXenOwiT3GE9p2mVpkBEhD65NXYVzNizPYdsVD1mrJFYq4waYTS2QCqZpyij3IpMuTB+dKsyUbbwgHbUN+TB7r0q3WniGmXAaLLwcOS/vcncKdxxg1t0dRdIJnJKhArJGQn8OvlKfzAJdIDVWDN/XDYVckZoMzChWZ7xyOOl/ZnSHtBwZ09cFEpR/XNd91pILSfhqadLPXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ca2ElQkyqtAG+v16wimWXixHF0T5+QK7WPQoJ0pNvdyHM7ocQdWsSV8rmnhsy3rel4/57SvaVd/KPEhdycXYcVglGvSqz4/rY9+jnFNKxYFRcuROEgplyZqJ9fCyUj+AsAMTM6i1SEPrKOa/NGPg4jalqGo+++W/eQ/5yf6RZNE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4047.namprd04.prod.outlook.com
 (2603:10b6:805:46::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Thu, 3 Dec
 2020 08:21:06 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.030; Thu, 3 Dec 2020
 08:21:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v3 02/54] btrfs: allow error injection for
 btrfs_search_slot and btrfs_cow_block
Thread-Topic: [PATCH v3 02/54] btrfs: allow error injection for
 btrfs_search_slot and btrfs_cow_block
Thread-Index: AQHWyOScBBg6CLrCb0WccPtvr9a7QA==
Date:   Thu, 3 Dec 2020 08:21:05 +0000
Message-ID: <SN4PR0401MB35989B83339507D17063B43F9BF20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
 <c0a4d7f83ba50576a4203f0169f2232dbe009d3a.1606938211.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:155d:1001:ddc9:a3a2:6218:d6d7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 781460bb-1be3-4c75-6194-08d897646182
x-ms-traffictypediagnostic: SN6PR04MB4047:
x-microsoft-antispam-prvs: <SN6PR04MB4047FCFE6D68822C2D1424759BF20@SN6PR04MB4047.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GeLzRzJYQwgnmZVhHeL3Ss7vmqnUaKjpXkfm2Rj8Jw5DvLz7nDaelYu+XUMpSwWG+d91miBGpN1gShSq5fLCAKARJb3daTlpSAsDcN0XTnPnqSd4h7QLP6hJOG6FczQFbW6fO6Z6BaAaB2zRioZqm8uo9Mi/kzap0wtM0uCYzvNtXWC2GFUj3etN8ja7bENCJLX3FDvSV+ImRJBnpqwu/oPOj06AeaqRJ3Iq6LVopTXCpOWN78BhnERFKIBDQ7CP0e90edXee+A6MfnZ+5jU7SazeD+WbwFBeclgqs8KybuLvoGLpSATmOv7Qhj7ye63SV3/8MEISbgJpKsbeXA91Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(55016002)(86362001)(52536014)(558084003)(9686003)(71200400001)(64756008)(66446008)(66476007)(66946007)(66556008)(19618925003)(2906002)(8936002)(8676002)(33656002)(4270600006)(110136005)(316002)(5660300002)(186003)(91956017)(6506007)(7696005)(76116006)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IGTRWB5TTnQ9dbwg1gRy2s28clhxYThUSXi5gn6wTurW7RPWsYPih7JVFVmA?=
 =?us-ascii?Q?HmOZx6c3YCxOGHXbKVtvSRYuDHf8b5wcd3zar25NQPrlOgi4ODJaiU/ai8Ut?=
 =?us-ascii?Q?KsiKciV9F4xPORYkxIWw3xVdH96EaVnz4PTxrrMbZlnS8oyB60fjKseP8jDw?=
 =?us-ascii?Q?YxA2RwsOABgnO90DMLm6IBY9q+Qcbu7FFxJ5qjpgAWU0oGu6LDmLQkC25N+Q?=
 =?us-ascii?Q?JbBWzk9dWJS+Yn4spFgyBKXZlMY2sMIDaDkTnXcp39+x68hX4k6/eKY76jPV?=
 =?us-ascii?Q?amdIhuwQT1AU1J84TN9d7G+svwk5DpvBwlwUXhdgfunJYN570AK4dkwUJl1y?=
 =?us-ascii?Q?UULL7MqWBOuH4x+ANgKjqudK5cy7Y/lqIPW1K6Ay35sj59nKJYo1t8XBNkY+?=
 =?us-ascii?Q?8JvH3id0+hp8nekcAz5JbB7PjdXlxIul6raBvit3NXMNaosQ001ZEW5rAvTf?=
 =?us-ascii?Q?9x7h2xn9dX5Fh9JcWfANoGiewYRSg4iK3U4maBFJ0JZQqwdq94Oilz2JXuA6?=
 =?us-ascii?Q?j/bueq0hEGPbecvAORMsjIs6keQsakg3mjbAbe9f5duRsrwjicI8gpZbSVju?=
 =?us-ascii?Q?EsBFX82DHPoYvvXEKE+VQu2sFXDVzYfjFxYbu4kvfW4c45bAupCshvd1PCyd?=
 =?us-ascii?Q?5Ct/IwGXptyNqrS7GrXd7lx/4VueRk60YhzJusZb1M3duQM8mOzYscaHTOkY?=
 =?us-ascii?Q?gvBk50+xIlsGl1iZpwgsZgGGi1BjBUnb2cFWxKNK9LM/dJ5GYk5UBVCSDpjS?=
 =?us-ascii?Q?XrIM1pkPiX8GFi8Kzlc+E0OD+q0UwNUZip0y6cJuVfuCvbowTKL/l2QBSsDc?=
 =?us-ascii?Q?z53T8FP+Y5I01q15aUH3X/o6HV5hcKIHdIPgyUR1+OfDQHtVkGohpkR44O2z?=
 =?us-ascii?Q?uYOEqEUxUrSH6VxZKfj/zeHmN7VwIvFViK9jRVrKGBmofMpymUWdacU7Ylst?=
 =?us-ascii?Q?J482Fm+FPB2rwrE2bieiX+10vGJwUpfF2Se49P+K2JIl9jamA5wPyLcbT0ay?=
 =?us-ascii?Q?5Xl6t7+wyON8P0Ruk5CLcRn2h7R9wxl66pQKmMeKoOgRpobeYcLqM9ekDU+a?=
 =?us-ascii?Q?FJYpU2OT?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781460bb-1be3-4c75-6194-08d897646182
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 08:21:06.0024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9snffV7I1Wdoj3Y/+gG08cUlfybkmp4ggzWWtIAdjz3PhPAYGo8majlvSNQoePd0mp4GpvBf+UqfeAZ2w+bMWc/xmvG+bw9AhFNg49rq8hY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4047
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
