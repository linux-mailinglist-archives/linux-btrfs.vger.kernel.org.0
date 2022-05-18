Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D0052B8DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 13:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbiERL3L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 07:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbiERL3J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 07:29:09 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA51D1737FA
        for <linux-btrfs@vger.kernel.org>; Wed, 18 May 2022 04:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652873349; x=1684409349;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=kWuDF8mm8J4vKIMLBLs/fju6EMIox6Ax5xeD+WGwSr8=;
  b=gkYC9cnnrEfJY9ZNHMoKsnCIEXDT8ugEqK+m9D1jZHgaI7B7aXQDaDEN
   it4vdlS5boflKtWGP7D6oF78SlaHf2GaEsH1PTZ+BxvYfBbnrkdlbLZ8s
   TmicwWjzZ9mGU3IrXbN1RCvUQlHXeVAGvLZXYcROSYRsolGPd0+JoJgEJ
   GlmyHjfcErjKClNO7ai5g4JzAU67Da6y3eyfsQ3C5E77eNJ/GfFiFPqC6
   U3MarISs0IIBPLKZodR5ZsHCCB1iXfkvCWcTkOC0dwWBA9KtJ+VDJKhRQ
   icBt0M9KoP1p6m53D4dbuH5AkyD0XU+uie6a8UeMvNu4HaNc3wx5K/sP0
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,234,1647273600"; 
   d="scan'208";a="201524056"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2022 19:29:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EU/qxOUGiTWEyq51ij7FH523JXKShbcZgHztf8dBqpw548JmwnawlKAKwi6LiX+rKPP44XA/N1C30UrYOIiMshMwgcLdW5Zlr2R7KkabJkJd5DNsY7SO0J1c6xwF9zXTw2gmRsnR7aL77lVMEukc1/W3gAw2S5MwwbTYwspHbl/wfRPPfXaIrn+qioOk8Bi4xpui7DKuqPFHfEytJ2qlExElkAc/fSkJYMMEfEIMyz4RAjXA7oLyXJlp8ja5ZkpzlQD412uKPJlco/aR63DvsDWmMR8WVrWTrMABqcpmJxcAknmm7kRJkGVkyg04ICuLvYp6xhziNkKr62w5ujPHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWuDF8mm8J4vKIMLBLs/fju6EMIox6Ax5xeD+WGwSr8=;
 b=VdL0pRbmMtuF3/MpY6UVmazkraln/BLgzZ5hhHAxbCoLpEMJpifOYMh5Fk0/ih4oCMd04EuS/KV8V4w1045/b3PjOkbDTp3vmuMFPWh0XgI8Tox/J13w1nTI87eXfzAitS4Ko343oW0Wwe6GRZ4xrY8+W4OPhoqZZvMBQMPvY8u7vFjO9hzwFBfVP6O0owN1O/UAXTh8wn5COfzbCBXfRm4tBYPov9JMseve33hpJmHVSOBjWKZEeHcXeuk1W3UbWWxWtjzubYHO6OoN+609ENr2bBqeycjZBA5kW+Jo1bIoJiaXGVZuij8zMRdveHcbDp0JhDGgWg666fkfp13WNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWuDF8mm8J4vKIMLBLs/fju6EMIox6Ax5xeD+WGwSr8=;
 b=XuoSNicWwaUFcaoKeDsGhWe9Cy6Tvg+xUisxqMeMRWNRicAFAWV5ESQPksvjc3MfWRxHjwFJe6vrlbezzDayFTNfwcg9CIzW7Enue5/jqqydjPcJvB47T61spprOdJVgg1gEQnaiVabI/Cbrzl3ydM7NlNA42LsRJnPDab7eHKs=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SA1PR04MB8271.namprd04.prod.outlook.com (2603:10b6:806:1f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Wed, 18 May
 2022 11:29:06 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::dfc:dff6:4f94:78e0]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::dfc:dff6:4f94:78e0%4]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 11:29:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC ONLY 3/8] btrfs: read raid-stripe-tree from disk
Thread-Topic: [RFC ONLY 3/8] btrfs: read raid-stripe-tree from disk
Thread-Index: AQHYaTGyleh77VsKp0OYSKTjOAeG6w==
Date:   Wed, 18 May 2022 11:29:06 +0000
Message-ID: <SA0PR04MB741858084F504990FE654F879BD19@SA0PR04MB7418.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <2ccf8b77759a80a09d083446d5adb3d03947394b.1652711187.git.johannes.thumshirn@wdc.com>
 <6ddec77c-2aa5-d575-0320-3d5bb824bd04@gmx.com>
 <PH0PR04MB7416E825D6F1AC99F8923B659BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <ab540ece-37b4-7cb5-216b-dad26ee75ccb@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b34c6bb-e8e9-4b8c-e031-08da38c19e8d
x-ms-traffictypediagnostic: SA1PR04MB8271:EE_
x-microsoft-antispam-prvs: <SA1PR04MB8271E3810AC31262C05B2E3C9BD19@SA1PR04MB8271.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WCyz0pnIx23Symah+43JOtqIcFUFFtASCHtCLWWpWWYzEo7HvpX1D0avIEL+SrUnFe8mq3tu7ZPk7JYZ8q3e7XiIgFzmvIBFj3EFQnQPlsC43LZfjTwzgKaYgoJlIl3Qun1yZbwsxrc4awTi94Uf0IWgMG3futjCLky6T3pUsckSXbT2SmEJy8AhRVaNlPkAk3OES0m8fMlLeNzxyWM5mIRLilOGk3Fl5S4EEg1aWD2nEgN6HsB61sgmaI/9Fh1tH9d+ahrE+3z5GlJW7RrQbbLlfouQXCC0XKbRP782BPkAxZwLLo2ajqLUvnPdU5hZY5f4novCrbpm4rzE+QKCpofW0oLiUCS5iHpLDlcaSOOgJCy8Nf+C3BP5GxsSqow0hYPrn4rBH5KsSetT4s4eEY1sxvv0nTvjODDpi92npv1cbWwcGvLFUg2SUYdjoiRMi22rv4lXfqhJuxvQkJ25oV3qnlDEeKlykZaqnz98bEw/CCGhPHg7WGSD4D9NtkxT/G9L1Nq/d0tmujyL43oGatZNsqCrEWtlC5xFf1iT8A69J2uD1fyvNx6ac87iDGy+fx4THmThhQgRVD150PiDX+SJrGmklsUQZwQUPW9i0Vw6ziZebhD6lK3txxFSjb558zvcgUS6BCI1zIvHBPJwwkc6FaLs7SjYPR9SQIn1q/OrlUQZhKR5aSbBOWoWC3lXvlMlGhpBL9yiU5EyXeYBvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82960400001)(86362001)(9686003)(38070700005)(4744005)(38100700002)(7696005)(508600001)(2906002)(83380400001)(71200400001)(122000001)(8936002)(52536014)(76116006)(66946007)(66446008)(66476007)(66556008)(8676002)(91956017)(186003)(110136005)(5660300002)(6506007)(33656002)(316002)(53546011)(55016003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NQkPFdHpFlxiToyISn8Pg3dOtKvbRoluAtWKrdp0vcIJlZESi7ukS+gN0MDB?=
 =?us-ascii?Q?Oy6Gpatie+8ziBYawac2goQsDOB4ZM5RaIBS+GXHqHF7nQ8il+ZE0fjD2vHF?=
 =?us-ascii?Q?5bkmxLxvRrYtcokTHOSPferkSoNbHWBCjLTx4UkCZGBbDRb1XaIKyBymq9Gu?=
 =?us-ascii?Q?2NIR3xppTZqVURn4W2o+a+A5jJWA5hA+oQ7t7yofqownlJQhpvtJOWH3cNJD?=
 =?us-ascii?Q?C67Kp9nmHNYrZxRQvoc02oeQlA2eMPg+pvX9iLMa9ymHsjZNirqCWDzp0xAM?=
 =?us-ascii?Q?IKQeM7Qwjlof2eh50vH68EitFZOiN7FjCwv9Qgif3kpp8hk0Vi+7jp+oH5Vv?=
 =?us-ascii?Q?xT4qodAibVel0D79HvDDG3FuSQuEi4tKAiqoHYTGwN6Lzm+B2KThWjkAkDyx?=
 =?us-ascii?Q?8Iqsgd0qhNNBw+lmFWnovI+GFwAb7Te0dUYYhhL/aVixXAHPMZRyG30uxT8h?=
 =?us-ascii?Q?CZcauMpsdw38m8nvUTPCIbt1pZR/F7ALBDPxrtk38AXBxPYdjCgRC3sZdgiH?=
 =?us-ascii?Q?vn/DpSbI0DxXmTa92RuPFGRn9kiCbfo/0jfqah5EDPxVHOH1BtVc62pDbg90?=
 =?us-ascii?Q?Olg/EHD3DQfwpZvlf+/TDhcTWvGFUOo2KkRZjxavRtcYtJwraxYMG4tKH3cF?=
 =?us-ascii?Q?Zsc3A/sOSbsbslMSQK5rlJ1oCUYDato7ZofmLxuWx/WiLEIn+cUt9BVtxKG1?=
 =?us-ascii?Q?MVy5ytKUvgjKBVzqgERIO3+Y+v5XNaM5Un9PHKoR6XLdNOjuzPHCIqyw3axh?=
 =?us-ascii?Q?PIg3mbdXjsUcnsbaYUahXuMPI7Ws46jVpc58eiRIZmxQTBHtdaOAIZeoGzT7?=
 =?us-ascii?Q?3pqkHYVYPLTurUKl+R/HHlkd2FI5GJGd/fr0UYlY8FzGDJTc/1gzRYo1WmUW?=
 =?us-ascii?Q?pzXP+MHHXZssLckvQxVhyNBso2ArBUMsm7RAAwzRtl8OARZX5p68tQibIBy5?=
 =?us-ascii?Q?wB9AzIGkUdw3sZMLH3IooCIAnd2cJUdwKCy4+JL1OYOJj43ufc6/T5sJ5ho3?=
 =?us-ascii?Q?IaIbxysW/pc0wl3/HeqrF1yoYjHsUoBc307p4BeTgjwfOUS51HcUTUFgpppw?=
 =?us-ascii?Q?cMZDBLrKhDmPub5fXFI84kO+NbwyPpXnXFPKT0JxHv1uu/QiJj1Lp5u2JIyI?=
 =?us-ascii?Q?hityTqTrSiGW5Fwh2wmk5YIejj+bCHlXI8NmqCwYSH232YmfWYBKwYIy+zFT?=
 =?us-ascii?Q?N4GorhadcxTPQrp10Ta/gFtL6Vp2DxmpN/qKEuGnvcO76Dx/KtsNPtTLxpnJ?=
 =?us-ascii?Q?thQBnYJaJeG8Cm6fg3HarErXrrYm1DQ1zWxyEQOYPdeYQx5coPxY6HKQg8p+?=
 =?us-ascii?Q?GNrGPHgKisF2ESMuBN9e8p+LNYnRIGmSG4vwjd9uHqKhL19Jy+NgI94Yi14d?=
 =?us-ascii?Q?lQ/dN4/DY7m5Hf5QOSCClxABmXB6NNv1srWmot94oZUguMrNNAD6YnRtX7qo?=
 =?us-ascii?Q?ciG4pubcOSZRfFVaJCsSSC4ujOmv00lywhUlTiaH9c6qjgKWKMSA4udmWJzO?=
 =?us-ascii?Q?sdZyGpQA3/PvwOskeaByeSdsde+bDZ48C9ysND6ffKeY6iy75j/cYsPMu/Ml?=
 =?us-ascii?Q?CeIEYe5rL0grYunnXRWbiCXSfEF9dNv0/QzXEP1xAG7HeHfn9ikasumnnvio?=
 =?us-ascii?Q?duEPqMQdOxjDKhDFTV2ET+LnC/AztmKnqbvYv72BxezgIoWV8N1T0xW9HNcB?=
 =?us-ascii?Q?EsiD+j7QIR//elhK1Tz4JosXURB/lPJhcuVmUlF1z1CXebasmXE3g/wxHWmQ?=
 =?us-ascii?Q?rKyUgqWfy7NaSZ2DUZXl9h9OfikaLGIfVf1nUzl9chhzitud3/x83TKiShcI?=
x-ms-exchange-antispam-messagedata-1: KRFXMpzrnGYi7DIWxvr3RvUbo1PwGmGQMr3Y5MIMItZ2DPOIfJC3sotI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b34c6bb-e8e9-4b8c-e031-08da38c19e8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 11:29:06.5975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CJl5hE5XcYLar35ZDmCkyoAVwukgCLeT8J5bYuURX1CAElG156pX61gD8FiWdzjfR5SFv/su9dOuBk6KeNLTfGSa6svnjdm91CufRN8GHHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8271
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/05/2022 10:28, Qu Wenruo wrote:=0A=
>>=0A=
>> Metadata on the stripe tree really is the main blocker right now.=0A=
> =0A=
> That's no doubt.=0A=
=0A=
What could be done and I think this is the only way forward, is to have=0A=
the stripe tree in the system block group and force system to be RAID1=0A=
on a fs with stripe tree.=0A=
=0A=
Thoughts?=0A=
