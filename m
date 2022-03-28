Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7914E97B2
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 15:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240706AbiC1NPv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 09:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbiC1NPq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 09:15:46 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7BD1EC62
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 06:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648473244; x=1680009244;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=yxc8bj3Rt34wMr6SoWIH4dzcD/iOhsvXN9A/gnPEbNg=;
  b=Ehr+aeIcMAMhl5bBTcAUUeus9u9fafn2wX1E3GKBL8t1v6IvUETDbS8g
   WNrDFxiVF+w23zYokfVQuVun4ZOw+f43SZw43TYDAd58d4OoUEnXaWnfz
   6sFtE7qwbmKpfKQEI+7QmgUCBRTNa18WhxyPpwTzhJUdWMMzmb6qGhBEc
   2+R0t6xh9r45IJwKw2QhrnQj04h2POcTKmry+a1XX73uvTC5DwinRUYRD
   49gcsoXUGtnsywWgLMWVRSKzyy2AHEeNQYefuXLF2PNp34Be3mduFROW1
   xOt9nKp8B1We9kK4aNxDnUdmilsZF/XHjeGJWLJkiE/NXUWnJPXlSWnRb
   w==;
X-IronPort-AV: E=Sophos;i="5.90,217,1643644800"; 
   d="scan'208";a="201289671"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2022 21:14:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lz3m4cAYeXERCKWdIIhZOV7Fz/MFhNbtR0cJAnN1xDrLLs/jPeYYSjj49leRuKEsthb3KX+txIP30olO/kbiONsyZFr1vSoi636iCAwRS70qxIwPFGGBg6f2mlRRObH6r+ODCKYrFXE9xpy8G+3pJn+IpbAHYgnpmf0w4BY4C1OEjTvOLNuQ0thz8bsc0vzqkGS+6ukNBUhivSWXI0II6FEDuqa2EegUvt3fmyL4oVeOqwmgNCSQ9Kr2mWtx6YfLOn4Uuew2z78SWMpCpIw/qYlAP6gUNllYwD7P80/KSeHE22qZlu/o1V9REKeJzyDQIQcfr3lBOHR9RZK+q3Hn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxc8bj3Rt34wMr6SoWIH4dzcD/iOhsvXN9A/gnPEbNg=;
 b=dhtML+DxvWBgnJktDJrHrhsyfL5AprLtFoG4JNldtWu2D95ubtyqTrRadQMhEgpqAEKasL7lr2JqH74YIhyXunlP8KC78jnueg5sZM6S3eyEFYMH/FPi8irtlEG5JeK5XncNPZrRanm25YuFFVmYC1VJuuqfgdXplCfCC7oC4vOGbwoEufksyxc+/zTmqzAtfL6WiDf4Dm7BkttVXGmDc9Dn8urBne+ezFC5hMTZZFv/gO/vMyslygZwafanxTT8mOe7wAEzYoOzbHnlcftTXGKR4Ol/nN6Pg6nN77xu1uj4iJCYWyS5cGJ4CDCL3HDXv/x6/vglJ9ja1ttjEF09vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxc8bj3Rt34wMr6SoWIH4dzcD/iOhsvXN9A/gnPEbNg=;
 b=MQJPp+H4shMml5hCHAoQL4MzBVXD3HagVSbjF00s+FAKQbP8ks8B50Gl0vhQA+0TGczKWPmELslV6UY4Lw2xv8zRmvaVIe6xOMtckEQ9SM9YoRiT4jgbl9tb9q1WXotWUYks8D/cWTCkYbZry4fwYSYUX42iq3peb3ErdTc2Y1w=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB0740.namprd04.prod.outlook.com (2603:10b6:404:d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 13:14:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 13:14:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix outstanding extents calculation
Thread-Topic: [PATCH] btrfs: fix outstanding extents calculation
Thread-Index: AQHYQp/pD+O+D6y0/Ee6vtk2aMtoZQ==
Date:   Mon, 28 Mar 2022 13:14:02 +0000
Message-ID: <PH0PR04MB7416B28BD43CE79E2D6A75349B1D9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <06cc127b5d3c535917e90fbdce0534742dcde478.1648470587.git.naohiro.aota@wdc.com>
 <YkGzTsQtFNI9s7Ji@debian9.Home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfef2472-e48a-44f7-cf14-08da10bcd440
x-ms-traffictypediagnostic: BN6PR04MB0740:EE_
x-microsoft-antispam-prvs: <BN6PR04MB0740D3D3FCFC6883A09CB29A9B1D9@BN6PR04MB0740.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PrQqexv/UyxHQthIVSSs09dLxVxp0hsYiGJwUopKB4dOocbqaGqBwCMZ2jfEosklRoloM8RU0z7Lu3zg6YShaGsWEPwKUbDiHBuhT3WEMCKG2yaN3ChINQRf3WDS+cZ/IrWbi2aTx4xjSJ4PoxG0WfvQ2a3tS9Qu7Srnc/rVgRTl4h+3W1iD2hL4JoESEHjM6sbH0YgfjUjWALhYTK2zzmZGjv8lY4SI1ZMUjhmJyDlLNLDm95hXUoI+P6JDx211Jod3XMGHv0Vqmf2mljEogPU3Seqqm/neRpqzflf1GCeKJXF//QAw/Ru73CF+VwM7FDzOGkWpZEJBK9iEpWHfOCF5RzHfR9XJ0vVhfn3XEcWtr04xhkxVEJrcqu0OkMZU/5UnAESe+wTKhgIwvm2FIYarzd3Ru6k0Gcv7Q9FBQVfZwo0wzUlBr0mIJ5CbPslFO/qG7vgb6Dmx7Tajvubxm+o41vXDvCJFaN6NFX9b0+/gEmXfYF2KsdDMdIJYsrU31jVmYRdNaobc8lllHuvywAAmxrqTZ7uJWK4nvGfXMRN1NziQPcZM4mLm0iYy1/N1mRUGZKD8AjYOzFMGHPppVJNXxi2afTcU6YKo7JL0iS0nnVTNvtQrelUYIEfhbgyA/Z35BN/fDqdXI00H2ZwGU+oCKnpjOF60GeXBWQqmNaeuCDpj+G1MF4h8hcQcqBrdKvA+zUUgcZG4A1wEYHFkYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(2906002)(7696005)(53546011)(6506007)(38070700005)(9686003)(33656002)(55016003)(83380400001)(66946007)(38100700002)(82960400001)(508600001)(8936002)(52536014)(316002)(4744005)(86362001)(5660300002)(122000001)(71200400001)(4326008)(66476007)(66446008)(64756008)(8676002)(110136005)(91956017)(6636002)(76116006)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F2d51ujuJr4IYx0tGkVkIQPHXke4q2UDi3E+3osZK6uYVxVIFCEKtoKfNhsO?=
 =?us-ascii?Q?22UMxkz5ilGyNrvtV+E0EWGjZR7AwBmGGZkD07YDXtTqI9LjBlitLWAFkSvw?=
 =?us-ascii?Q?TjOqoKXzu+hUunmsn2bFMZLjTkPUTHzBgaw/z582cDh1g8ZkB5ogtsAlwWYR?=
 =?us-ascii?Q?ZoQVQJBSG/xoB4NNkjuPTAZfLR+K2zdShMKNmlo+4ksfE7s7rXEgWuI6YR4m?=
 =?us-ascii?Q?S0/IO0cJL8ylX5WAx9ahOVust7GdTMoH+B4TDlWd54oQV3bqLQbOha9ZM+uA?=
 =?us-ascii?Q?kWjdyNL55xrMUHjWliblQ2J4DZDaNZEz7+cV4MUXd5JgjJ2buOCLzmmg9dtB?=
 =?us-ascii?Q?IYuhGpx0UPekFw+64NHijwQJCY4s+RQ2u9UYVNzHYCEu7WoWiV93i/0eyGeM?=
 =?us-ascii?Q?7vajEBbe2WWOxJdtwhtgSDeeplGiHaJk/QOCdhbwDGgUAk6Z4ViduO//9up9?=
 =?us-ascii?Q?hBJs6RL1qJR7/iY5ljaUtLc+EXmBi4hKZVnEQsLjnddbnc1CrTnvFN7SQndH?=
 =?us-ascii?Q?v26mBdO0mOZJwNn25PoOLaeGdh+zjcWgzDUVXei72G14QaboaPIdYzTHC1v1?=
 =?us-ascii?Q?Yqp7hSvlWCWpLUxL7r0yXNZn254D0StV8My1etbL6qDifBSgh2gLFUN3L2cj?=
 =?us-ascii?Q?pWPSteFOQzkYXL9Hc9QPUJURP81rnFj5ieItfhpI9hyirch2S2xEVOBfBErS?=
 =?us-ascii?Q?m9th55ZA2YrHq8jBq4To/eU2/R9HokpT/m15NjEkTt2+FyPDPCq26Jnz5g/A?=
 =?us-ascii?Q?fLeSQT1GlWG0GqkxqHVQoK7jYNosKR9oSslh3inI4Akig8sgFclkk5WK5DQi?=
 =?us-ascii?Q?0s85zL46aqR8BcLbxNHBuYGdNjwuSzNpoKES/BnU2yqqZPAD8R2QVqAJnXjO?=
 =?us-ascii?Q?zEC71Z/iyNHMJ3ADyDQrV2QeYl1WCN15bjr9vwCWdoxzOSr2CxOn0iKH3Bz0?=
 =?us-ascii?Q?3VbrwqhZuZboAzhY9Wb6vIiFImIqNEWwJh8mCtXi7/OANwhQUHQYrvYDT72Z?=
 =?us-ascii?Q?CyZ4TI1iwVCpgVAsFSFyCuTS0sQD8Cw6oef5TInDelOIMAdoXPBFJHTc8sne?=
 =?us-ascii?Q?g12KdMc0Oo/HVrFWq5oYKE5D/bQjRrYgCmA/D5s719PHPTmnMRrAEj22DDG2?=
 =?us-ascii?Q?xhEGRliIOVVat82e2ndCHJ/+asVuUnbba0rwi2o3KGk1TVwgXD97uw5XSGIQ?=
 =?us-ascii?Q?0fPCULVUaPCIWxiUffptwvfY+i+xOjtSywZT6V4ao0Z7byYMkRIXEx40DACm?=
 =?us-ascii?Q?Ua7WvODyx10yNjKLU+26G4jSeFuy6xZc9qy9EvvBHNBmfG4v3WqtavZ3MXyS?=
 =?us-ascii?Q?A5579y0bnwkS21LXHltws4uXwySvht08a72v4vkGfdrVCc+jYxgXrmLht8WC?=
 =?us-ascii?Q?NBB+xoF87kzhLPbyH9EVwHltfhSgrjYaxUCL/Yd4TV/2tawRUxRCZKFIxWqm?=
 =?us-ascii?Q?SFblGFvzVNDSUTDe7CPkpxDuJGsOLI2AKvxK+Tdeo49Sjw2V/3n69xgvmS8u?=
 =?us-ascii?Q?yq3SDOlJcUUfesXBB6ZjOWnpgRfklbCAaKBmGUxNfASASHEmASL9l9SXg4FT?=
 =?us-ascii?Q?iGK0xKNsz3r5ZBg+roM60NUAmCFsvzfE5TPCnJhGx8vvrwXnJBFEyXQBHOWx?=
 =?us-ascii?Q?2eE0M/WnR1uUg5FJMGqPGh2UYBrWi2CajkCeo//9mHXSdCiNToK3lGK9BzUT?=
 =?us-ascii?Q?8cuw8nLD5YlkbsUPVinSXVAlNZFblolkgNtJwsJdUolNRgzYLVhBvtSh/Jf+?=
 =?us-ascii?Q?zA0Ouip7gWDPdZBi/ZiMaupwyHDkvhHGpGDOsVo7S21Q1WwmyFVZU31NkDDp?=
x-ms-exchange-antispam-messagedata-1: uPy9ZgEY4e0jnsW19dDiL4hR7rqnsGqenaEP/yat7I/hCDmSlbw12JO0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfef2472-e48a-44f7-cf14-08da10bcd440
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 13:14:02.3341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NqfbTq23pt+fcPa6iiV6zYCEZYBye8UPYsBM5D9rjh4bNETp345jI/E1Mln55gJ9wK+CdBGQmaadCUpRRMN/h8c007aG61hIM4eRYnO8v8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0740
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/03/2022 15:09, Filipe Manana wrote:=0A=
> On Mon, Mar 28, 2022 at 09:32:05PM +0900, Naohiro Aota wrote:=0A=
>> Running generic/406 causes the following WARNING in btrfs_destroy_inode(=
)=0A=
>> which tells there is outstanding extents left.=0A=
> =0A=
> I can't trigger the warning with generic/406.=0A=
> Any special setup or config to trigger it?=0A=
> =0A=
> The change looks fine to me, however I'm curious why this isn't triggered=
=0A=
> with generic/406, nor anyone else reported it before, since the test is=
=0A=
> fully deterministic.=0A=
> =0A=
=0A=
I am able to trigger the WARN() with a different test (which is for a diffe=
rent,=0A=
not yet solved problem) on my zoned setup. With this patch, the WARN() is g=
one.=0A=
