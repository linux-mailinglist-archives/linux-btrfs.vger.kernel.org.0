Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C540E4A9530
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 09:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357159AbiBDIfT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 03:35:19 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:47135 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357145AbiBDIfP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 03:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643963715; x=1675499715;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=jfyihiFt8XuT9TWjalN/iqHqXgHwpnTI1MdPYIeBOpy9k9IWuYrHxu0z
   EXcqqjZDLHnphU1/OVHv3J2pRhH71JYbLPzNGn3MGz3BBXuuQJoBfrdQ7
   rXlnD/tKlL1ZiaRRxQNr7Cx5gIgw9Pw5Bc/cudqtg0hFG3rLGB5kflZWe
   pX1Q8klt2KiSj/28W6rp9mP1CbLycQzRi0V2hjOQdW1uJWXJEtZ1j/KbH
   pKryErt08ZoEfuZiUotm5Vk+c0XNXzike5/p8q3NcVhFeAQoQiL0Drc4U
   L5FvtbD/bNAr/ebVYcjWhguEwaa243UA+ngU7wSC0l30xTIggQDiH2gS6
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635177600"; 
   d="scan'208";a="191088704"
Received: from mail-dm6nam08lp2048.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.48])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2022 16:35:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igQeKbZ+cD9hA2K/5aUCO24I8am4EENiuh+nOsNLVbKAMuqCmacyx3zmEql3YUt2WC8pytGcdKnF4iT714+zDfaVfFgcOLvi/pojXq65gdXwuXTSGQ6Ysh4lOh64h+ZD37ZAx/z6ZjTjRRCkb/RGQc9ES2ZDlYsWk9E7UxUEfxptdOvBUWw9yCC2z4sbNiL82mT8gDojpYQBTZJR687+H8PdvDZw28vaCiELScdRsNCy0xRrRqVWPxEwOM5npd/OEWPGMSzLON1SqkLaJOAkZCOeBdK/YZIj+2gPiA6H1208vXi7JP/Fnv1MAFG2wkT0tpkU9MqftyqASoVAEUNWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=L18jG3GXa70lZbQbFyMmtqoiXm4wfXu54nlWbZywhC0Egkad4fxZZCHnMEI78JjqAE/vP6F/pKlOFttYMKAfSG5psh3TYQoVVYXyVgVcBwdXoHlDVXWo/ZlXw0ZrQTcZVzxvOBHNLgqQua4soD3YsksMAZuMy51z/4InRpvlpYQBPy6Xhl3M3OeA7w7okjBmHCp1UEfKWGl4ke3xKn0oqPo0HGcWZBCKuvT+XY7KElc9TlVhJXJIQ/0ad9JKTQO2fcSk3p1IW2PKsU/mh43zRLRp9vrbWjPrH+kO82N6kd2bp8Ry6mkybXomi51q/sjRRPV/R12jDTBjECIri1B5jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Rl5Zj/jB7wccPAEUtBtO2lUsiZiYMrt0gwAf3oUnGe5wtVFC6oWtC89eLKoWXMew2jm1AC8lJ4lzfbjAlr6Yj2PS7yxiHbGTUjokOLzj6Kf4wS2RUWLEzTcnzx54VqQ0rIbqIgEAVyx4nMAjl8NukvEyHRY9YtdYOLlrn7Mj0Jc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR04MB0557.namprd04.prod.outlook.com (2603:10b6:3:aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 08:35:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%4]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 08:35:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/5] Speedups and check_setget_bounds reporting updates
Thread-Topic: [PATCH 0/5] Speedups and check_setget_bounds reporting updates
Thread-Index: AQHYGSNQbgvQjUvz1kSG2UA6lZ78tg==
Date:   Fri, 4 Feb 2022 08:35:13 +0000
Message-ID: <PH0PR04MB7416B210EF648E7A82210EC29B299@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1643904960.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 094a17bf-c827-4488-59bd-08d9e7b9435a
x-ms-traffictypediagnostic: DM5PR04MB0557:EE_
x-microsoft-antispam-prvs: <DM5PR04MB055763462667EA125F10C85A9B299@DM5PR04MB0557.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lVmLWYN5i+jgDBx27EdrPGLpQ3KDAwiWQSojmx0KqgSHArPhAYb1jimPzpxuELffFGmFhRFrkSlUjE3E5FFe4D72NqqhqD497oI7ZbU2MXgxg1ez8cGxi9F1G2OSh9HVaGLX4LxDvZmVXknZg0PWKKYmqy2FwzJjkTL7BdXvUgB/uIrVK7v0BsNtMdOL5YopjtNkwExEMRJog4CuuXW6BIA3CWf78XSzOaWunGL8fswAVcjAcLIhGz7T/dA0QAuc6ORrCCRcg5NOaZdhO7p9M8XaA+niUhVbAtOwn/WKb/o42q9iZ/PQ2uL8SsXgEV27udgf2s5DmExiq/9k3NafsLx7gBczjOHPaYS3PuBH3CoF2oHGl0qg3h0BnDjSWyYUXUWScKEyAAkLIANkjXASK11vh3m/zQzDkWUVYuuQNvhWfUXasCLVNxne+N53AeAkHcL/hCa6cIbSeuaSvJzZ4t07vBjSqKiR93sBFRl7BWhHHZDJgwdN9GkHyAemgcx4om3FcGsWexP2XR3t4cyjtKR7o9O0H3zK7G3HkymRnPxcksHx3t88SD2fnfA/tN8ImrpUyx0fNr6LznYupWqsK0cvLDX0O896ozS2eG1H2dI7qt8kBpXLVzJmF0sTbPuwke3l7AmfMxnc2fyZKb4TqQIToNXUhrEyBr4oIQCvS3RZa6k02YVSDw97AISg+dsrN19GA3mKqJHjRRlrX83NCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(19618925003)(186003)(2906002)(38100700002)(110136005)(508600001)(38070700005)(82960400001)(66446008)(66556008)(71200400001)(66946007)(76116006)(122000001)(316002)(86362001)(91956017)(4270600006)(8676002)(8936002)(9686003)(7696005)(33656002)(52536014)(6506007)(558084003)(66476007)(55016003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dbhl2t/u4xNo2MusMfR433Hb+dTlojeGFL9qKJmonlxLvo8/Yf6r+8adqFzk?=
 =?us-ascii?Q?wL+YWxtTPDGIzJ/C8PnnlnSzlyaVueidjKeJCjyHyMQqCaUjZbt0Iu5uGcU/?=
 =?us-ascii?Q?bDaELJ7rmzIcnXvX7RszhXxNnToa90VJLaLKEFt9CgJUd0lVK6rmgMdsAHW7?=
 =?us-ascii?Q?VUH4MwG1/KZf6TUDvyD956n6I76IW1yF3mCRSZoFa6AwbCVm7lNhlY2f1c2M?=
 =?us-ascii?Q?Ps/oFjTGllARsRMjqWzT6+ls5CpuXOx49my5OamFzcrWhzziA9OVylBDgq0x?=
 =?us-ascii?Q?RklhDL5lFTCKQr+ewI9BgbEolg8dLcUpS3RS8rVkx8tvvmPN+Ue7zuILEo0Y?=
 =?us-ascii?Q?BObIUDRt7ybKcY8wImUOTdiDY7x6ypz9d8UkYlIXtluhGsEnnlfR6yCM6tc2?=
 =?us-ascii?Q?TzgkOCrzcZLzMRqFsR4xnlmyFdwe/YGgzfPvXKFgY2qgZUvZrb3kLivB9IyS?=
 =?us-ascii?Q?Mch2LzQN/MOHCbS5kl7dsh5rYaU56pUrxFntWZX69iVNgPIaPtmxP3UMGg1D?=
 =?us-ascii?Q?26IvGTbDe+am+AyQJa3NgY5vlpfKaBZi90UQLE1mwKhMnpqq/ACVWrKm6enC?=
 =?us-ascii?Q?Gr8bHlwLiM6t2cD1jkA6DRl8b+RJ8DpWZPoraltR+iw8u2FOlMk8ka3YMNG4?=
 =?us-ascii?Q?X4Fk1J6Q0JzFQUqqZCBKNDRC3lTJU7UPoi2I9MZLF3hLb1Pj1mVCuVqaHLg1?=
 =?us-ascii?Q?BDqqdLtdPK+OAi9phjCZfNjVclwX+g2bwgWnfxhtVmXAaIXC+ZiOvhB5pde+?=
 =?us-ascii?Q?MmMfUz6WDtGUiNngIxIYbc3WJgHSDb2r9E0poqmY7+NpQ2rsFU9A1ccnqpVR?=
 =?us-ascii?Q?4yxSdPebyS10+UItKsHXpiV+24NsgBYP7t8vEK/XJLETGgZEYdj2W4+2513R?=
 =?us-ascii?Q?Wm7fLFdWEwXDoOFf1i0CTkaC8yfmlVfxIaPBKTNKqtMeokyN0NCMJmEXArLh?=
 =?us-ascii?Q?ADuP3z0V6zp8t/E7fDK7anyU1TvSYm6o4Wkc6/7WTdIoTwteIVNc7Q9Hq4Za?=
 =?us-ascii?Q?ph7XA65j+hjGM7qK8RqRTvjlM6pUyzdJsFfXwkEuKLir6HS4SRf14/euaqQC?=
 =?us-ascii?Q?IULXcvqrqk/uR7Zb2tp5HWqMuNqQnkdxIEWyD0Hf+HbLY7q3O8+cpDXt+wey?=
 =?us-ascii?Q?aN6vuH9TYb4xvzGy2ThV7mQByW9PhSMlVb/uykhDTSD7RbuaDdBHd589v9Mp?=
 =?us-ascii?Q?Xf4TiL9D8zBSQ+q31XrS4FOd5qCGxFrRnpBT22wIYMA0BHqokoSRTMp2QXDz?=
 =?us-ascii?Q?Tp4Otrfa/B8iis16EdAzJaTgQCkYibDih9vchXK95I04lCeFN4h+IZFVlbvY?=
 =?us-ascii?Q?B26naF36oUcDWv14B4ATNADjm6opH9Ei5fvZc0TsBgxjmqV0GRsz2NidreVc?=
 =?us-ascii?Q?9+fqJK3pgO5kXrJpnpRA2vFdTxW07XS/AcQ2jFnPPBdsd2UIxS8a7iOhSjiF?=
 =?us-ascii?Q?ZkQaCa9gnvnhgxCE3Uj3X3jJbQ5+TF+8E2rpihzl7jon8AmJq12kzZicOr2N?=
 =?us-ascii?Q?KdeS9z5YxyC/0bsTzihyFboDkJwDB1qUjipVuFuZDpTjZIL8xbbORxoVAGgM?=
 =?us-ascii?Q?vk+LYMBtFTrVHMoBOWPUKoOsLBQeDGimWl0hz/WAM4FM6DrU14KbjPO1OdsZ?=
 =?us-ascii?Q?eVKgwsf/HxvoW9SdIg77tayFobJfZdQMEnBb4A6zBLr8wOuWV7CBL34Rryph?=
 =?us-ascii?Q?438SRlcb5EeeIMfoq7p2Wsao4mctswU8X+nex7pcMUlGyd2OEZpLKkPh+xrn?=
 =?us-ascii?Q?BQu8r0ho7aBNnpNzualeD9vEDMB0VX4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 094a17bf-c827-4488-59bd-08d9e7b9435a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 08:35:13.3347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qIZIRE+FBDfKgHeyvmSXY1t2j9C3PDNGbeLX1l8rzKbv38oKnMEtPiv0hAa3ATOhEI5sR+jvAeiRbIGRIwu3pAEhya9iXa4Ie5Vr8MaoiAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0557
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
