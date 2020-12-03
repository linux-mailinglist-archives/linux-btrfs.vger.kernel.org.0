Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9F62CD19C
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 09:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgLCIpw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 03:45:52 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:17462 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbgLCIpv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 03:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606985152; x=1638521152;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=NnKXqUOUef7kGoGQ4xk/VS/EwmJrWvp1pR+aPlteTH5zIrY90OIpZhm9
   8Siy+LJiThc/CKTPbgI7uJ95esFC54/Rq3siF1KbefdZNMoUFH/3AMBAx
   8I9YcN279F65LVIalosARYX1bpsnGQycEcooo8Z8hyQpCKa2VVgEcLwsl
   qJzPrGocqcGptsa3KuoSzStOq6Spb7QmhHgCS5GhxkKis5/jzNb4NDONF
   9l1G5aV4J1tgR4hMdJWNA0nJ3V9FBjGRVCS0/HpXnAZb/33ssGkh6Agi8
   m8Uk961Y9ivdcUEyZuZW7X+VIDfROHtSD0CSADd5Qp/LAJ3cwh25D2ruf
   w==;
IronPort-SDR: Ha/tQazrtXqKaKAT2ZqS2znZlriSJhcEj6dcULYb5h6nLw1vt3EK+2u/X7rg/SDvVPj89aYve/
 r14HhRCqvhjvA/h+lwB+6srzXRc8/hcXWCykQO/xZ2h1IDKpsnnpV7UPCOA522qvBeuhl1Hmup
 YzY0RTVnvxR8jlF3wA5f4ja9pqL5LPGGmel/jPy/m31dxfRR/F1SpI29U4BBkG2nwgybdmj+RE
 19qB8NcaHeaZqB2iVK+UsUL3rW7s5Y9Pi7W4efer+y6fVsQ6G1jk61NYaJrFnxRZr0u2EhTOui
 ruw=
X-IronPort-AV: E=Sophos;i="5.78,389,1599494400"; 
   d="scan'208";a="155443784"
Received: from mail-bl2nam02lp2055.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.55])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2020 16:44:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtSokbIiIkIfZqaAQI8Nzb9oQ9FiNuOQwQE5HtKJqyAxW3NwhC1+q7rB38b41/uNj2qUl9tiy9gLgfc8S2OVrgif6h/K7jjO9RoXc+aBRfac3bdBogoeYlqc1/t/UdglSg3rnY7Y0HLawzej5B08hlVO3oyY7BeGvkRiVm+FgGwc7wxQwSYsaB23UD+7xrzu8xyZFfLkOb7CR2KCb5CqnRithT7mq40WgFcvM8Ja++pV31V14PmrXA2L4HWwd77NvIU9vHTp3ximXAR5j89PAQfFIZyqTZDvoTZXyA1i/gsn83JAP33LyDA8as+k9BmDfdxYjAuouJlq9MR9veUlFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=N8lIdoEXphPIfOBtm8gcJ13hYSlcq0M/0Ene/uEWXN5PNhmyWu0wPVQyNfqBE53HW6T9+SPRNG2VRPQ2+oMA2pJWHdqM7kkmVBngpfoU413sYadaycdczX9mTscpAAu/bpBfQYt9VOaqqWIblxiUSH3wVG9ZsZrBrFmDHwjhPRN34wBochy1dNkVLMokDeHSItU91+n8MSP/C3l/7puBvqqFM+UgiDQEvWVoJGEvt/G/hZ1J34VO8vukAxXU0x7FQ+Ir7KrpD1uy5qAlSSouo554EGzr8/oZdwz/27NytQ+n+nfvZGyZxwYjv8K98sKzmn3Xl+7HxcAMtjH0si9P7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=bh8aXnlhabFRpg/a4IBfZflS8PPSOKoGWys5u9a7APJjJzmUFjwgSXR/gg+TRo6A7R3XGGMqjuB+PsEnbmGAYL8DT+vdxsBacdFMFMxWVSOXM9jUHNsKYwVrr8lU4G6xei8tNAuJkE/Re5lNCHOJ2aW80rXks/TpMAxfQMr3NzI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4606.namprd04.prod.outlook.com
 (2603:10b6:805:ac::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Thu, 3 Dec
 2020 08:44:44 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.030; Thu, 3 Dec 2020
 08:44:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v3 05/54] btrfs: noinline btrfs_should_cancel_balance
Thread-Topic: [PATCH v3 05/54] btrfs: noinline btrfs_should_cancel_balance
Thread-Index: AQHWyOT0u2PcmNjEKEqyubyxyA9Odw==
Date:   Thu, 3 Dec 2020 08:44:44 +0000
Message-ID: <SN4PR0401MB35985EBC64E23D0EC17EADAE9BF20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
 <4657a485af5665a07682c4d7a5eb14ef241995a5.1606938211.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:155d:1001:ddc9:a3a2:6218:d6d7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0f3d0da2-bff5-466d-c074-08d89767af32
x-ms-traffictypediagnostic: SN6PR04MB4606:
x-microsoft-antispam-prvs: <SN6PR04MB4606F925B73A5AA106E335339BF20@SN6PR04MB4606.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H5lAPwy6UisIeR/Eus8grPAo0otbmVCxpErdAaZCh7Zwhe5aiH7Yq09ADNNR8hh8G59lAHqaRCL8QHDTYvbx3YVsWiXjS7kICGtedmS16pUUp2XWTlX07/6GUUQWe8IzELZ2s1IYJWCPhAdoooPwEX3KkFPyCJ4fBa/dQtOrZ898k6zcTINaTRNdEphOoHAp3snORLygDXrttln3Tdld8c3nTlUNg4rSfcbvkJmWXB0uKLtP8rUM3eCnb1dfSgiXAEBvcL4f+0npEHILvwiT5pOY2hIxlyhRFIHVGjUXrLDHYPHWPgoltAn79pYBWz9GOWRYVktZa5NzqutQOp0UGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(7696005)(8936002)(186003)(71200400001)(5660300002)(4270600006)(19618925003)(558084003)(66946007)(66556008)(2906002)(9686003)(8676002)(6506007)(91956017)(55016002)(110136005)(86362001)(33656002)(66476007)(316002)(64756008)(76116006)(478600001)(66446008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Xm0lHxyR0PlhVMkAi8o4QZXxzT0aqY2n/RrUbaJjOku37RdP8jrftl6BdYl6?=
 =?us-ascii?Q?85EdAF9TzNlneIPCqlreb3fwlY3j8uDt/b0EtbXfmqLNp/XBtzzHRPUbaTML?=
 =?us-ascii?Q?2W6hx9aA6KAplqGnj+OhwX2fakKNcQPKFftxEl91oDYK7taQcQY54a2TjNlF?=
 =?us-ascii?Q?11ABY7Akvi/pEf5bkF1oKkCRu8ZZDDsFOvi7SLBO4qBvCtll7x2o1Q6TmUxE?=
 =?us-ascii?Q?z1fBuoxqWcUyNo56koL0Cra9XZYK5xVcuTLxGxLnTCSt5xAEIf1az0yzuKBl?=
 =?us-ascii?Q?5PiI8/+dJndDnhlUCa/HMeKxVBzi+3OmKH+a97RHhLmG1+NWJqFdJUpG6njV?=
 =?us-ascii?Q?TUNnewMyBSFKV+nXCBM8wpRaf4K6OL4xOIF3ccOIFOeSyIL+ILGr2xTW67yo?=
 =?us-ascii?Q?QgA0tHZ0K/7ZXU1WgEEEaXyYsZe9lBjlgBFgTiqan1OKEnTLHyfLq21S4qX1?=
 =?us-ascii?Q?aUbYDv/BUwugd9L0NeeHNRRUKfZehl/i8RQ9n46YAeEm/HhTnhW9lnR8TOHL?=
 =?us-ascii?Q?WcOLGnt8auO2izAn4gdOlwm8QqL017UBsf7BvxQrfCBsTFAmyF8uXk2j3Brk?=
 =?us-ascii?Q?pQi7hUPkevIGJXyeCH6/trd056j5GRv2VKgVISE2fm1GDFTaHUUsAsYmJutF?=
 =?us-ascii?Q?cbdl2FsjG17SaAgEVU0rTlroZMq/mQ4W+NDE2gHm1UzpKGp0EODnj8HmTfXN?=
 =?us-ascii?Q?RU5kErWDowAi8Q17ZNS2+BMl5BoNtyrtm0ugFtO6D2ulGNn1e6aKWnIcq/IJ?=
 =?us-ascii?Q?Rp3RXxd1jihNCpjtiosrLlXlJRygxoLMU+y45/DJyhdcy/hlpiKa0DbTWjNj?=
 =?us-ascii?Q?c66Pnn+uPbKiYAewXBoSev/hyF42Jgp0nidbhLHE//qKsFzgvbzBYDKtRMam?=
 =?us-ascii?Q?+IubOzYTe0IEqXR3sa9GwpdaEm72PSxdmKTMYKGs0JNkUe7iAR8DhpfKAy3R?=
 =?us-ascii?Q?1kGxPAy/20ODZ2opgwyjDIrUnPwlNmCNzGjeMR8MAEVubBINPth+AOHjsn5S?=
 =?us-ascii?Q?+ktRcKbCKPyjHECbRes2CohPDNJTi17Opk7q8+p0YneYUDNNFPQgC5Sh3W+Q?=
 =?us-ascii?Q?hV6AAONK?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3d0da2-bff5-466d-c074-08d89767af32
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 08:44:44.8750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WhIbe5WnGzSxZnnRL83fcoV4etCwzGf24iPwnUc1FFcUc2x++iCHbqf56SccqPjoC03NDAFBuADl8nzRVG0PDXOLL/2S6oFnzKiHyJj8VtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4606
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
