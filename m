Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023535A0B96
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Aug 2022 10:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbiHYIdc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Aug 2022 04:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237861AbiHYIdY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Aug 2022 04:33:24 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CCAA74CF
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Aug 2022 01:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661416397; x=1692952397;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vbM2Cv9wOMR38nNo2ma2T7jbXFsSHvOCgbL5z6O24GI=;
  b=M3MZ4chEtVAPE2doSjTtHuXo2XRFpVUwLo3hv0q82oF1Rq+6XNdqJcoB
   OHebD+wV3uPDMTNwTYGIO85yfrou2y9JUheIVzxTpFZ/ZjKzd8wA13OSc
   U0XKRxlF0FjlXEbMZD9CzFTWR4Q2+yIEkRk5GA+UQIdsdwk0qYTKBjCtV
   UXHIpAbCh0WEn2eLkBhrq8I4M17xYYGMg2wiByBisrQQWAlxFZXw8TZOI
   du5R4PXGR10RSc47m2E8Ep+tTUXB3MIHrFMMFh9jAVE/D8287vHpe+LVS
   1HBr2QaKMXc0eNV8SJZd3qDMSaksTfApnQSiYyRQmkOsHeNAxHexxlji5
   A==;
X-IronPort-AV: E=Sophos;i="5.93,262,1654531200"; 
   d="scan'208";a="209618847"
Received: from mail-dm6nam04lp2049.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.49])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2022 16:33:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eewu/5zposzhABs0Yhgwk7yYtMebYjjhvxnc1OkI42RG1LqrUlUwuXeAne5b30p+PhK9q60fb2BYTegIq7CYX4G4gw+Hbauv9zqwS3KO9VdlIY9AOQCxc0pEhRc4jHomwzk+8pUOen2FmHFAsKC6c9X0uwtCZNqANxKnLkGtjqQhY5i0ta2G/EokO37jJf/qKdrd8jRkorke8NdN4NgFa4Juame7zigB2U1Bo6I5ygZ/wuEcOhuGMq+/A+tbSAdaP5oNtY60LLs3phsmQ4w6okR6R9UugVvb1HXekQ6jRadzv8sTANAXz3ysLEz0Js4LDfw2e3I69NtxT5Dfz+kIvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbK64EOIxs2eehSXCCZmb7Es8qiM6fYIDTE92vnQ/H8=;
 b=C4txOc/XYdBgH/vr+zJdRlN5SUtPgShP5o/D/YI3r+RITn1EUG++o1AhfGy/D4rla/9RcYgo4bl3DAXrVcbQyVAl4tZ4X9idW+cR4rzGYiShyHBaUaMtH2uUPHWj0m+Vfu2DaA2hfYNMClR7pDi127ra4H+97SS1Oe3XZ1//9A7J/EtPktZu/osvCzzMNPpcvkj/fNa989Bi7w5IxIKJzoy6Ph68bAfT90pqZBkzoNN4RS7+cSPxnbPVjkd3FpLWxhwiGJzSSWTiWlxxEcAfWW8Ndt6Exm44Kjwgy0znS6/4Mm/kKQgYv7/mVOfipGabJYWCpM4Z3ubBq7221wFT0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbK64EOIxs2eehSXCCZmb7Es8qiM6fYIDTE92vnQ/H8=;
 b=e9pS67BRlepB6YV4eru8bB2iZs2OR3HV//mOuj3KTUVxXBJ5bQYGexJjoOEz7/KI3pfa9WdLboAKkM4MeMY4IlSRZ56zdkeradoiDdlNEdXZtd9elQJSy77xmu9uHgVVF+K+3tUJ3qQPXrLvOELeuUz68wLTPsaKyqNZZ0tL9Tw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB4043.namprd04.prod.outlook.com (2603:10b6:5:b3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 25 Aug
 2022 08:33:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%6]) with mapi id 15.20.5546.023; Thu, 25 Aug 2022
 08:33:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Li Zhang <zhanglikernel@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] Make btrfs_prepare_device parallel during mkfs.btrfs
Thread-Topic: [PATCH] Make btrfs_prepare_device parallel during mkfs.btrfs
Thread-Index: AQHYt9NpDkp3mThM6UqLJhTeMttUdQ==
Date:   Thu, 25 Aug 2022 08:33:15 +0000
Message-ID: <PH0PR04MB7416C9F9DF5B4959DF2E8DB69B729@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <1661357103-22735-1-git-send-email-zhanglikernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcd43666-b19c-40bb-19bd-08da867474bc
x-ms-traffictypediagnostic: DM6PR04MB4043:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IdlbNQ+JfIG1jXu60qLN3DbVGrzHy0bePAesm7CfSre6wXdtoirnwLjVcxJYFngq0utY8OVzaX9lR3zytgD+9naOA2muiEiBomrgsOf18MmFSR4/h8YPuIcvkJ1NtBko0iw/saWr+ASeQrT/1LGOhjHfjaJNL9NIui5k6yHkvcvUpLpWbuodQo0p2vgfs7/rmEJQs8MJ0Pb9q9gZCFxcXhJIvmLcPzfFeC0OK6lMgQctyGRvr+A6z47cZaReBzMLMisUxFE3dIE6F1F7dceEutsO0Dijo2uaHHnDVpMmMxzUL/zlQjlm1fuorTKnjStQA8vej8/ZctsXmpWmIasIW1+cwn2BEG+0GO0UipK8r7Gl3nWKz1roWSXKe0NA3pCuOf9yYcjCiPdQHHu/UH77ZqYHc9z0Tmd2Y62HkEZefF0iEQaPZ17obkDBCyDr+ICqFg9gUBhHtf5kGfZJKrza3QP+BBhqxewWcf2dmPaA3yRwmbm7zX9prJOBZFz48pkXgxaZhNYuc1gTKagjPRNovsdEMBq8fcbLp89d9YrZ8CbT7MoR2pY41CLh8qQ/e34UXRzpEbfVszDz/J8/IxlA/Dq8dr+gbJGAm4XdlMgPk0bmj3NCvvosuMqXaVgxSbi0T2HPJCEdRwfSLCEfCzsvtGm9QPzbM4SiMIgLYQXFkiHaPRUSnZtgopKyGIEJvOt3x+U9H9m/e0Pl1tJ2oG1nJfrrMRy02CUvcSmB9yYCRsdD9Fh7TsxrJkB+5zQK+9qPwEoziK1C66BjCHd23f4nIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(478600001)(71200400001)(316002)(82960400001)(186003)(110136005)(38070700005)(41300700001)(53546011)(7696005)(38100700002)(66946007)(26005)(9686003)(122000001)(66556008)(66476007)(8676002)(6506007)(33656002)(66446008)(4744005)(8936002)(5660300002)(2906002)(64756008)(86362001)(55016003)(52536014)(91956017)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fgM9JmZ2gXKi3zYD+5rPHKCmfizH5CrK5/zwH59JtKUX7xgeIYF0qrrt2MWq?=
 =?us-ascii?Q?N730YQRiU46g0pl7ySho493NZbq2CvRhRVABqaB3OtUAvNvMADg89ou0JUCS?=
 =?us-ascii?Q?/whjz8vpfiF7DYGsepQvSMFk/DDweuUbwl/DOFfbY6j+RX5LQNFR5cDERTDv?=
 =?us-ascii?Q?xZofYBhP5pgIRjRkYm0BbdDaxc54/RhamkiRz26K/ikWOX8dbFPwZ4+ENHw7?=
 =?us-ascii?Q?Gw7bNbOjeilJ/mTZcR00vtdh7M31sgXv5FoQhBbV9T5tDmz+AlJ0L96KhsJv?=
 =?us-ascii?Q?qSOsK9/HGrqgOS33Yriq7/ARGAm4vvtYLZS3Fj70DUuOfpnMWjzUwyOZsrah?=
 =?us-ascii?Q?8IMjItiIhkVyrvJSHpOAfq6AeoA3bKr/I1QJj1McWZPvrT0DgngyTfQ6RI3w?=
 =?us-ascii?Q?CVpZ8vZjIbRtVrCWpaBg1Yi5A7eCJBUeCCdU3WiBeK2cfhZx8Qh+4rWl0Vwd?=
 =?us-ascii?Q?KqDfnVRMi7ccy4Xb+FwKeHSy9ELgHgBSW9UiES5nogEu9X5Mup9y/FE8U2AD?=
 =?us-ascii?Q?twIOO6QAxAOkmv6bfRbr1stj7WrAp8lsecXnfqCKVe5kyXy3zchFgOakzXz5?=
 =?us-ascii?Q?ZS637HNtPQBlOiXGSgd9r5Z2qvDDO5K5jhSw6R7OZ8L9nLHB0zsV6/CPxJZw?=
 =?us-ascii?Q?Y3TJLWrgkQhMfWPyTtRqa/jQxcKha8Eor9zgagACsPtFftIxNZC9NAz2ncpf?=
 =?us-ascii?Q?+wA/Hl6y7n8a/NW6CxiZ6JwosOQupe1/ZhFXMzQxdoa0q1K5RkPglh8icGbE?=
 =?us-ascii?Q?uLyqMB9/zxDWL06X1lIQ81/A79hLDt9YIglwDX7EtXmXM2Aqwo4ws3CwD3Lb?=
 =?us-ascii?Q?XlYWcYOgdOm3Ha3ioachuK5fmuLNCY356j54Oo1MonSdQ0atLUbgErXHurlK?=
 =?us-ascii?Q?3pnQ2YEClxkNbdgCbmdH9P+NMBVHGeCib2jFzyvVo4jFs89y1Amdmx2hGfML?=
 =?us-ascii?Q?SM83+fX5N59bC++sarzdo0k1sJH+iN1EnQ4L1Qnrh/sVxl79gPY/czkYTeZY?=
 =?us-ascii?Q?gN1DjlcnR1ge26D/97t57hmf504LKqxJT7fc4A6WZ654nHZXPMqePhLahu81?=
 =?us-ascii?Q?4Lm0TPc+jC/c7QFhhbnUxg2W1z8oeSyCzRuQDVHp1rm4mL57x5XX2vXBLTqC?=
 =?us-ascii?Q?pbMaM07XHRUzlflyU3nWO41SOs5lekCrGPAoAcXWN1ITkoeaiO6GKRE6vLV/?=
 =?us-ascii?Q?YuGRgsFdulAnPjIdcWvadbQQp6Mq7O5AzmKXpn64Pob0/QdIY68s5j2JddEe?=
 =?us-ascii?Q?ikXkSMnojoTv1i1KPT5k1vRw0nsZLbAFzA9pDVHFjc+nWcUeZH8Bz0fWsw6M?=
 =?us-ascii?Q?lQEoldACs8T2KlKkxCtSS/CrIJVVQDTt8FtQfYW6DlXDhFga9sYMAwuTzuMo?=
 =?us-ascii?Q?KgJoDGA14pQ9WtcgUQPdxob8V7NXpCHEbMhkrh0ULo5nMWHe+7iX5biSDkyG?=
 =?us-ascii?Q?WB4rRHfSdKjSDXuJsavAQpExmC3ZLJHGfwEvobM9/igCqoOpfWjgOntuXKee?=
 =?us-ascii?Q?IarMAyQRdTBamXNobaut49ZT7vhZwnoM/GnHdTjcw2aYYFUKy4NyKTSf0Rt4?=
 =?us-ascii?Q?Hxj4JcZi75J9NQzistqgHCeGFfLtdQTQVwkdNRI3k7lKALA6x0POfSEUle3w?=
 =?us-ascii?Q?4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd43666-b19c-40bb-19bd-08da867474bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 08:33:15.8846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JDILhkpsjbySSsVlEQFUiZ52cwA30L+wOumsGDDmL6EhuY+7WdYO3yOmvqBKkIdiicl2xGvMeazvoocsgqjzCOhNlhCHmgT11N+Ij/JEvXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4043
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24.08.22 18:06, Li Zhang wrote:=0A=
> [enhancement]=0A=
> When a disk is formatted as btrfs, it calls=0A=
> btrfs_prepare_device for each device, which takes too much time.=0A=
=0A=
That really is awesome. I'll throw it onto my 60 zoned HDD test box,=0A=
once all devices have the same open flags.=0A=
 =0A=
[...]=0A=
=0A=
> +	t_prepare =3D malloc(dev_cnt * sizeof(*t_prepare));=0A=
> +	prepare_ctx =3D malloc(dev_cnt * sizeof(*prepare_ctx));=0A=
=0A=
That really should be calloc().=0A=
=0A=
