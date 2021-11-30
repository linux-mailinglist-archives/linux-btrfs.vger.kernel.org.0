Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA7D4629FF
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Nov 2021 02:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhK3Byj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 20:54:39 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:45952 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhK3Byi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 20:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638237080; x=1669773080;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ONJex1mfGToCgOeryXl67WSohX3ZWf3Y0ghKnxpZpSk=;
  b=VQIBEwl8eL59bYJn3mf8M/ZgsMZzeZk/tkY6itWa7AQFkIjhfgV2CYd3
   3LST3LRP7oe1XOuaYCRc2OvJ0cD8sB8d5lPlAu+ZjBroyysLKYqywQJoJ
   TQwfGOC/KaYPhAnBap8nZscyLhccNzQY8lU1mrW+DtOK8xuse4F2n40LX
   +v4pheacO94mj2piOSl8cePewGvSCQ17PC7S6nyDhVZ4BPBLonPa/qXbf
   HErkBzhK/9d6cWD96w/GtsmodZn9TX5SahAcNn4Tn5n92zvo8pfVZgNRb
   o23AZiaQTQetn9Fi/mcNASFZ6e0SDBYT88Tw+G1P4ZD+fGUUr5slaCV4O
   w==;
X-IronPort-AV: E=Sophos;i="5.87,273,1631548800"; 
   d="scan'208";a="185996886"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2021 09:51:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T17rjeOEajv1bXvJTnqyD9fjShMgwqGxG2ws/AVoGpt8QFhXNa33pP4lZ4p0Wvkj0dnH6NhktgnslYvoHTaFo8Ph3g6CXECHmI3qXUM1QHcQUeZKChsHBomm+vIZAHe88XHARCzJ+XGb6d8hp3jzFShJkw1knG7RyzyuDoa8qZ4A36Ev1QJeGQc8Qd7VgJLZ3A1WHwktlhN42KeyXmdhrFRAvYUdwshGLKK/EonOgfCtot+9xgzJkdgA0CpZ2zAqknImjtw2G0E6vYeU+RWJKkJi/i5bLYmKd9scF5bw78AGtiWVPZsckLrehaODmbRd4/oBKrqYckpJm+0YsfeMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONJex1mfGToCgOeryXl67WSohX3ZWf3Y0ghKnxpZpSk=;
 b=ItmfhmUMxjwoDQYIPfY1/ODBDg2A1MQ/Wqhbv1Wt+OPlmvSAmRNrbyyv8/iX3TPPoJoY6QG5wWonbt9zPKpt/fMEZSLMRHsahBqUAzlqt8xmizeSLp6/hsFZhV1cL6j4GSHbVbr5na/UD0mih2ojqQy4BLiRnPLiFo6xGGYSPtv0LiHj/jc48fatmQAaozW3oTdnL5nD58Mq9Q8XxomqCQWq3IafHROVpSKu4ORc2a1QayhRhJRsj9bPKvY0/QNGqPCUzKveqi5OAbyPi4toXsotUktxSRe+Nfpd3G7vHd2Q7ef9Lt+cwaGeeLsQj1SbtFn0Ri2XjmR0GVnHL30fcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONJex1mfGToCgOeryXl67WSohX3ZWf3Y0ghKnxpZpSk=;
 b=oT/McNt4c6jwRsBcHm1J2SZG4QE8lJry31uE4OZQ4rx/R8JtaMKgEpgv05OrCXtt1gJefir2yxWE3wtq0mQO6EZ36UytRirBca33dvB4C5aSYexR4pQTMWRK/MAlYrZbT9l4/l7Fj43MdECEQPfFwAgiBOFAOJrF6RjPkUeatDg=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8341.namprd04.prod.outlook.com (2603:10b6:a03:3d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 01:51:19 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::4d43:a19:5ad0:74ca]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::4d43:a19:5ad0:74ca%8]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 01:51:19 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: fix re-dirty process of tree-log nodes
Thread-Topic: [PATCH] btrfs: fix re-dirty process of tree-log nodes
Thread-Index: AQHX5MvA/+z/V3kvnUyJVmnnWwCHmqwbT/AA
Date:   Tue, 30 Nov 2021 01:51:18 +0000
Message-ID: <20211130015118.sh7j5l32knw5gpu3@naota-xeon>
References: <20211129024930.1574325-1-naohiro.aota@wdc.com>
 <PH0PR04MB7416D41D2F6FC7863439BD8C9B669@PH0PR04MB7416.namprd04.prod.outlook.com>
In-Reply-To: <PH0PR04MB7416D41D2F6FC7863439BD8C9B669@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2b4acb7-ff43-4a71-5685-08d9b3a3e747
x-ms-traffictypediagnostic: SJ0PR04MB8341:
x-microsoft-antispam-prvs: <SJ0PR04MB834198CEEE2EF92200685A6D8C679@SJ0PR04MB8341.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G/aas1MHEh7Ne/H0qOsON1XS+HURjajh88++k4bM3OEJQK2basG+CccKCcQuSRplQDNuR3082A6L4jV75WYyhjNCmRcMMfeoDdT9uSC13P17nhQSX2W6O5f207tbVz9ZxLXL6hZV7o2Kad0m5gRPPVRNMjNm0OXn4/CLsb01LX2frPrEP329Cdu7Ec7T2SjF2aqNNP0woORqDJiO3vz6H4grBgrEOOHI0ZDgwhDQo9VYCeEbEtvFOrdkXGqP9YP+kLllj6Wi/H/wjXlcMn8Eeied1P8AWHFX0ykR+vpXQtIN7PnpnJTFbeo3MDKjL+Xg+az4GTiFka8YxsXdFuT3K9e58rjlJizkIO35HfEDr0bWdn4KLmVQpUpv/1dvxWO3XT6dosJ5SP+/P8qjeqZdYoZ/ohogchoJfqvhRkRJlHl/+QW/wP4vOjIoMdMNDYKTFrJZ4GvsqaYuRxiNQza26RjveTWqXN5fVEBanLEEtG37bOUw5WyUj42/eAgg5H1vTQEoParqcYgBI8GzK2F00XfQFtYbEe1F6558Hne2fAmcpkKLEIjvtfO5oehGHKy+WJ+XFxYBypSk2lnSsAfiAHKfb/fqFCCXB7S+6GO/PtIkDep2AHZ1XICKLwHgQADOvd6G0HuXTwaYNHigTHadkr+vLbpEGKZV5Xr7sDeTYca0NTDAsCZ7/MlWkNjzZJpF+bHDnBydfsW0JCRirlbLdLlTGul8lefFgd5SfuX+sxMxDgSSUoGfAk9gUTeaSzDvlRZKsWiMIqfS7mHUmhnWIB2piQ4Rcy28uonZq9T6DwrAHBXLV8SSo2lATnfDqWx1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(6486002)(26005)(64756008)(66946007)(66556008)(66476007)(66446008)(33716001)(6506007)(54906003)(6862004)(38100700002)(76116006)(2906002)(83380400001)(6512007)(8936002)(71200400001)(91956017)(38070700005)(5660300002)(1076003)(8676002)(4326008)(86362001)(9686003)(186003)(316002)(53546011)(508600001)(6636002)(122000001)(82960400001)(966005)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+EWmFBHHvKoBR5KeEGjQHrjtd89labcx+7nVRgWhzsHdZkI5GZja7vkJ9TD7?=
 =?us-ascii?Q?kUwMLL0sR5jjJw25ZL5Xlz6R3mrP+Dd81iqxo8VHKIwVawxJZ/Hp8VYobAmY?=
 =?us-ascii?Q?XctMxoCJAJ4MHCCMloejTNBRu6S9ySXRVuuq8Y/gxB1P4WsOkescMQI6nr+8?=
 =?us-ascii?Q?rapQfN1r8KMM+aush5b1vKbTHBPwUgE+RMSO9rAFdeQv3AXrWGLgIT0DW1hU?=
 =?us-ascii?Q?pgpl4tYM78GKqKmsB7wNooFK77R4J8xwfiecBFJhOC9GW5XqAXL56X5846Oe?=
 =?us-ascii?Q?JPgnEt7BExgw+v9jtIKk4Df97wsK/ZmXR6egWPOCKxGtTfT3RuLmroachpr3?=
 =?us-ascii?Q?xSE+OpMvAVPPP5FAd2+++aXh/9S8pwQpwpC9sdooSXH0RFQpmOKHO7J8FDlU?=
 =?us-ascii?Q?dTvNXYymkKxRwPbXC58yeVZMH5O4vsvT6WGuV4Z+HYsMCLPem/ws1kkqSk/M?=
 =?us-ascii?Q?ys8EXDNvGGbW8xyAsbTT3+ULI2xB+c/8bsUUEUp4EGgiXz1Pr9/+k1KHj3U1?=
 =?us-ascii?Q?mtikFBUIgHdsJ0aM1ccdDrX/JxUmmcPwDfmsZ8n5xkbSI18AN8nKCoQHcvux?=
 =?us-ascii?Q?fM3Woge1Wp3juYa+HtKsDkcsZ8U1azNkEd3zYnkg0M21STpJSoHuKhD5ku4A?=
 =?us-ascii?Q?3qpnJuvQDnhnMVYMb9mv49OyBgdi/IXeTeLSrwfiUt0AzjS+kuZDBc6X5GxQ?=
 =?us-ascii?Q?9EbmCt9BPBGwRZbV5vu2ibXh1WQGlYo6gh0pgkWMVDwxn6YX3WAU+UFzCO6c?=
 =?us-ascii?Q?WSFzEZmVBhLA4l1iFspspwgijLV76Z5LNCsDTlcSDOl+/dxvc6pHrYYd1BLE?=
 =?us-ascii?Q?Vk73PeNo0nKXPPpiABOkt3/EVCdP5M0hRapd9hCbckB2LX6sTb/p+sIWh4RN?=
 =?us-ascii?Q?Zyzbbe9qhrZsxpueQcpe0oMithb4Yp9mrum181iNbIVFEJgmbEQo/MlQgHz7?=
 =?us-ascii?Q?3I7hsQ28VsaflLAUvI3cKKm3j4vHVe6QE1hOEP+wg964thVfYNXvH3PGnHMc?=
 =?us-ascii?Q?uorIHuNLcz0YQVrqS2Ps3YH+ODHjHQXflPJJHPX9NeEo8Vuh2+4MQW7E5ahk?=
 =?us-ascii?Q?G/QsC/02NkQf9YQ+vjN2MfCMAGD+IjX6DWX54BWzSCRjCnjEpz6osRivzBPr?=
 =?us-ascii?Q?09yTAU4U+BG+akPOSuKyfasQdjGg4bc6jTtzN1dxoPTxrawGCbmEJHpqhxqV?=
 =?us-ascii?Q?8txb9kFA9CBkl3x/OvuzO7aD0j3OPc08OUbfy4pfhacBEMUe8oqvJOxZXfB0?=
 =?us-ascii?Q?lpwQKWE5/+8RFlhSLUh0ddLm1CtHaXTM03VF5YKBlOetlWkm/nLruvuXBG8j?=
 =?us-ascii?Q?Yt/LG9tlGMq3mlmG+qA+O/bSv9fWjgMpGMZQrkiCo4KIl8lUJrCetaPudWqS?=
 =?us-ascii?Q?vsXnn1VpXuil59ZhMTr4EWooFpf86o4NffDSMwvrcUDw8aEtHE8iEAseS8Sr?=
 =?us-ascii?Q?FfZNfDpaiWW1vTKYd7DzsKsRUa/y53CVasnLzr8S1jgZNV7gf07j/xjL/OV8?=
 =?us-ascii?Q?lvc6BNspkixABDBFgWjfV0M7G87m0albMNNxUp3OniTl+ZAYeAh9pgexoh/4?=
 =?us-ascii?Q?vljv7TqWaWb4uj20v8XeVc7+s4f0G0YKjTuv6okjzz3wHT3OaLkynAayARtB?=
 =?us-ascii?Q?1hVhbu6K+ducAL/t59bosi4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <87A90C65C3FFD142B0F64CF42945A0EA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b4acb7-ff43-4a71-5685-08d9b3a3e747
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 01:51:18.9803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R0pFz9XxEzdFEj8PeDhulwwXW8RaWniVQ97+2pTkcOH2RUYdlarbgu3lWqHpPXifwJXZVucIxLX9/VVkt40+zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8341
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 29, 2021 at 07:57:39AM +0000, Johannes Thumshirn wrote:
> On 29/11/2021 03:51, Naohiro Aota wrote:
> > For zoned btrfs, we re-dirty a freeing tree node to ensure btrfs write
> > the region and not to leave a write hole on a zoned device. Current
> > code failed to re-dirty a node when the tree-log tree's depth >=3D
> > 2. This leads to a transaction abort with -EAGAIN.
> >=20
>=20
> I'd rephrase the above to:
>=20
> For zoned btrfs, we re-dirty a freed tree node to ensure btrfs=20
> can write the region and does not leave a hole on write on a zoned
> device. The current code fails to failed to re-dirty a node when the
> tree-log tree's depth was greater or equal to 2. This lead to a=20
> transaction abort with -EAGAIN.
>=20
>=20
> > Fix the issue by properly re-dirty a node on walking up the tree.
> >=20
> > Link: https://github.com/kdave/btrfs-progs/issues/415
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
>=20
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20
> Shouldn't we mark this for stable (v5.15)? After all the reporter did
> hit the problem on 5.15.
>=20

Oops, I've added the fixes tag and the stable tag to the commit, but
somehow I forgot to update the patch file. I'll resend the patch with
your fix with for the commit log. Thanks.=
