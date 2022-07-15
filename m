Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE60575D3F
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 10:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiGOIPm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 04:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiGOIPl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 04:15:41 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677A56BC0A
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 01:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657872940; x=1689408940;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=yKVNcnWja7Ud/e9UKiHsqUAYGb04XqlndS1t6fF5I6U=;
  b=ZlkEUl8MeUP1nyfPO8VaHxAPgfGmCz9gLzWk4GikQf7Bnjj652kOG6e/
   E9Ds3zCkGBC+pSLbm0DhUhENlUvbTV/80EzFo6pVicUVP7L2/xvQ4rJ2p
   96c1gfzCAKcmdYNNBpD7r2ha9r/djqGe5BCsrM8C2VIcXH5AFp0WXIolq
   Sa+HpCOLGUgpFMSz+vKiHTo1hC1khBmg7gEtHm2Pe3eVA34dV0iiv1lSy
   hsyayjuVhJNhxs2rODLWRqm6d2oZ3PqzkbkY7H8YTRpiP0TWfL/Bh0Hz8
   eke+qSkZGpuiGa4l2BuiSbGnD+mpaLWa1l6iHITMkumssDFjYRMV2Hbmz
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,273,1650902400"; 
   d="scan'208";a="310156230"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2022 16:15:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/LV+v0lRzjKHP1O+OsWgO42rkcwEWplReSEKgoA0mtqLP9NT59ArswvfVIsmtmy/6+FguSrOso3rBCZBmSmBx854CpnUmWwgxuN0pgQCuZTaGwMy9drwEW0xOgdii3S4wrat8DUk8SAkudo/KTQbK8GBY8kPJmc0yUxZXD6zrIAyOFBPeh0oI/h13Bwpj5VL00LJfsHZ+esF38Au6ZsAPC2d5Eyl6hepiQDNLtqMOMhzy9NxHf+sAUHVnAOM9wcj9+pYlZnDE+R9bIZQ9Znwver3gIgD8a/1trJkaoDuy/DLI164SdoVEUEL3DaY7y3rlivhiSjt+tOSHf/d6EKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKVNcnWja7Ud/e9UKiHsqUAYGb04XqlndS1t6fF5I6U=;
 b=ajEoARU3L7GGoLzJ0TMuaISjSjgDVtNSohJQvOerj1GmrxJtTg2zgdq4gjz2SxF5eXpTh9/aFiKqj1oW+6YTvTcW3cQWhmWbXbz4Edl10H6r98bWf7gyOoO+acDUTdCSI3fDHvSRj0RZJ0HXuOiSASu1YFy10HJWV2copWAW2GkcfpvUTv54D/XDcQ+UGF6w6k6dZBzFJJ2OkXeuv4P9w5aILxOPGzrtLWlNJnPtTzCRqPv9xtQFuVFxGnEXqxGGm3jqwEcOyjw+skakuSELTuLZL3/YjJut2wYZjHkLWEGX1sOzpzOWk7GB6Oq+JLNM6ISMnnJby8frqea83MH3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKVNcnWja7Ud/e9UKiHsqUAYGb04XqlndS1t6fF5I6U=;
 b=rvRQxGcBtrIznc5IAZ5OBPlubyaCHVtaZK/moM7f2DoU6/gxuh7Ij/Vs3P2qj19qgeAVZN+WcqAG3Mydj5mcrm0G2nnPsb460QHyVOs1Wh7BvkjZBa4eJzkif5YRd5DXa6HBaE8mvLh17g780rEUzOzeeR2Nm1BrEOwf4KYD3p4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB5126.namprd04.prod.outlook.com (2603:10b6:a03:46::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Fri, 15 Jul
 2022 08:15:37 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 08:15:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/4] btrfs: output more info for -ENOSPC caused
 transaction abort and other enhancement
Thread-Topic: [PATCH 0/4] btrfs: output more info for -ENOSPC caused
 transaction abort and other enhancement
Thread-Index: AQHYmBhCWSLW1+kkSU+WN6Ab+6bfXQ==
Date:   Fri, 15 Jul 2022 08:15:37 +0000
Message-ID: <PH0PR04MB7416C30F3588D90E4878E1009B8B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1657867842.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d03f90e-ac15-4e9a-c4aa-08da663a32f3
x-ms-traffictypediagnostic: BYAPR04MB5126:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KlFwJ4v24RBs3Q8ZoZXodLH9P9RX9lO8oFKbKSR19Dm8MyHVbpmjFYzmbBDNCQIVZfoZxzyfnHHazZ3Fa9mK+4c21Y9mrrfn0N4EVwib10hj+f4zxPnsuX3HSKG7RmfsP9RSej/NG9ZNIb8OAa1yHEbn81hfZoXnTM+pjQuVdEBXAoQyQOvZZ5uDMWeweFY9s29FtVPnVbhi08QZsphcbMSxvMxaJp1duYlLOZiPSHla/2zftLkBT1E7u8yWJqDgF8uuugWlJJON7VNZHnFN7as9AXEM9OAAKBKYc0pAbAVkmaBrBzIFRtppTC5qfNyfvSZWguHj2Rok6Sngzay4ZsFpiw9KlZjUEEm5YpKWkgZsAQ42fs2REDRE0VP4Tz/nyjyUUt27CyoRsodXfxlzwdpqOVaIl7EAaKsxVkAXN7vVfoM6GAZKbbL6J0aid3epmz+DI2lcBDvHi/75DA2nNZB8Puy1DzM+AsdBOwrVj2J8m3E29xfmWCd7oNoAD4C2jzdO1+gYvfMgIEpOJzxgFIGTHOmgaf+2tPN2b9E9L3T+g4Z7L3WgxloJK6U8GiMSAhd6KHM1Xo25WqMQIO30dTMM1D2C5CrKqO+/RrUyzvOJaixh5z8t1b33+VsElhZ2DoGqz3XZLJ+2lQcDnkaRPbMfnxG5sSa2vEfPcXrG269K+3BA2ZEnOxu5Ni5kmoklT/rvUYJK8w9AZWu3urQdMZtU/o7CcKIFoxjWfDfujHifsH5XK+Q4hEHIUwRQ9uEw+7x8lYRsxZo8xtJVQmiOqpnYpYzWde9GqxDsEJTqgpbuSt/Cj8HtLAlaXNM1Fxlr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(186003)(316002)(38100700002)(6506007)(2906002)(110136005)(38070700005)(8676002)(66476007)(66446008)(64756008)(478600001)(76116006)(7696005)(66556008)(66946007)(26005)(558084003)(33656002)(82960400001)(9686003)(91956017)(52536014)(86362001)(8936002)(71200400001)(5660300002)(122000001)(55016003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/k8eEdL1KZUz0XvTMNTdvsqlK2rBvwhCYcZNHP9eBS98Rgjr8yd3pNZ8/mlP?=
 =?us-ascii?Q?3hxTLOsEfO3V8Ac+XgbD1AZJ/wCFmZx9hQaNhKlWxUOaMC+HxH0+FMoy5LPS?=
 =?us-ascii?Q?yUPsg49h/XFa5J0kLEUe1lTuo+QHUZd16SV9O4hPbkBGFCQG35lhQth1Irte?=
 =?us-ascii?Q?PHUguJH0XK+S4C/5hNbodLeAjGJYQqYzwChW+c1UHuVgVtLaqPnhdp63QF3D?=
 =?us-ascii?Q?RUOHilAczOVB2lsHPGCiQRNoAAKa1RIOLKLZ7zWmauhLAzQ2ChLFFgfhJUDU?=
 =?us-ascii?Q?4LVGZT2l2LIsaOIZ97Ft9jZWe3rP/0eU9+O1U3VNcQzIXoJ9jSHI9PputUo9?=
 =?us-ascii?Q?YJ8GwDAPbslS7jmxXUCUJDO1+0NlnYe9s9PiKIDluRYpo8EKUi5rmYrZdX9K?=
 =?us-ascii?Q?a3MqF6w0CMDpd6nce77K6u/fvHiZSR649bxNC8EoJBxgi1ldZP0mUtOY+JvT?=
 =?us-ascii?Q?ojxlJe5W8Qx72pvnbUAvwwSUkF5AV96sXaAWnzFnWVlO7YIft3xvs/g+k9IE?=
 =?us-ascii?Q?KK0n+4H9XpuEfsPWHbU6tG6Ben2Ytlw6Ee9ZIdfLmqmZ5+83EasXvBbIpHdX?=
 =?us-ascii?Q?NMXbkZKw+DcF67TpeRWEcDs/6P4oRop+IjWeHAhXnaAHoeQWYqVM4Ij6XaN/?=
 =?us-ascii?Q?UBikImOCuR2xYinvYm67qryeNjTD3aEFpAqxQWqI3t162pI6H9s0CM22uJ/x?=
 =?us-ascii?Q?2lVaik+hLVfoeNZO2SrvxRgk/GTZCL300UPps76+n6k068jN4PeHBiX4QN76?=
 =?us-ascii?Q?z+G1lkT8J9qqLdd13fd+VvIynThHlE350J5I0F+QuBTMoJbjaAiS1VCqNdzY?=
 =?us-ascii?Q?yhfVD6nkus47Qypca+BtwIFXtSWB0C1KKE3bPQcPJk9KyH89QSR7i5uOdJLn?=
 =?us-ascii?Q?r43WiT+BP5aErnavM+Myxr3EVllMiVGyGAXl/2nmrFhdtxjM6pYrP2TGzl7O?=
 =?us-ascii?Q?38nC2exVv27irSD5FfHDSOVp+I+t7dggPxVydKH66Ni+R8YfLzRbrBdurV3o?=
 =?us-ascii?Q?ncAr4WctNsTh/fLtybX5vI1Q/Pyg3vEiSWAoop6zsreMhgFKArWpNC8uhhYe?=
 =?us-ascii?Q?aKbwt4OPYMrCTomfZ3WCEzo73340/mpwTxVja04aDq/QrBzvWam+gcCioVNl?=
 =?us-ascii?Q?iTAa3/rwjE4onqn5h8l9SfBrrGvPJ8GxWsFuXRd2Hss1Vdn9RC4587rlWPSc?=
 =?us-ascii?Q?ns77ytVL8b2lqjI1GNgWP6FR4KrW/kwV0TP6WbxRy7BFK8k/1cqzrfgtvGee?=
 =?us-ascii?Q?ZC6tWBKl88duRR+Yp48k+HJcsLnxqRCbYgpwNyLmM9ftmzNggJC0bJQ2xN5G?=
 =?us-ascii?Q?F27jTZRrAoRZA1MXn6g0l1foIjL3+kTeNGwfwBCNZ9vVBd1JYc1FE631mJe7?=
 =?us-ascii?Q?8cttitsoqF26WPMIxCT4lJzPwHxhBK7D+q84PLmwUGXvZceKWbmKKgk9D+gi?=
 =?us-ascii?Q?NXiMudfYM8DuzDEgEzyJiDb9eEUPmM+YpFrS7OmM+M07Z6DoLQYx8K2k5fLF?=
 =?us-ascii?Q?m1YmzQAh3EGr+PYv6386Q7H0yqRR4yNUCnWbK0BKjx1tVQzsdfxLe2JFherT?=
 =?us-ascii?Q?x8pftTBUOQ3vyH9I7wnqj3JqZy3gTORIxKAGMExsQ0k9JIDzuAxIdsGhvizk?=
 =?us-ascii?Q?fQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d03f90e-ac15-4e9a-c4aa-08da663a32f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 08:15:37.5006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BUDSmzpdEXo7qZ6b52m4r/M89S3/0VtIAGiJlalrh8iUfr9H9DWEM+jKyL81L+HGEqFQFM0vgLeeaMwUzRawAJWNKbr6HJdPvg/f/1SLPV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5126
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Apart from the small nit in 3/4=0A=
=0A=
Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
Generally I think this is a huge improvement for debugging=0A=
