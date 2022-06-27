Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8F655D021
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiF0Gvf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jun 2022 02:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiF0Gvd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jun 2022 02:51:33 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CD326C0
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Jun 2022 23:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656312691; x=1687848691;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=73II/K7MzDcF6eTKevQloDgSPuoCZQndVl1ZBWa9OHw=;
  b=jlO3odv2bbTbuNwMeuk7jo/u0Gt6sY9/+eiYfT+68a2R6AjPQ916FuJ2
   QEO82nRhtkWM+HVirmkkRzZvPeJb+qqMIA4ikIo0duzRQKMkefWSPL5H/
   2hstaurldw/xXQVVtXO3vQLEE3bMfGEkRkbbCTn0oDBN1RvRMy1ra1QNa
   WFw9zvJ0XiL05ZlRSDRS8kIeCjsHgTMm69jhdkEnWr78Py1WV88LjQdp6
   re4Z3akLGmLzZ90Guvj0zyqTI/tvLnulYbcKjOqaPrUEBEF1caeuQuBsM
   +y4ZlqcZA4Q6V847P8h6LbML/zRJxhqYTVEj8O4XDc3PqqofZFxyXw7RO
   A==;
X-IronPort-AV: E=Sophos;i="5.92,225,1650902400"; 
   d="scan'208";a="204167786"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2022 14:51:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYvszqq/vd6XH5HsBbZf5lntxWTHCmLTTBgMAnyKXgXHMwFLblmI+cUKFTz33pm+Dg2iHvResouDygPuosTEwZsAiIHNX9p2jWoYq4hgf46biZhzA9TV5416HPqhafeGNcMlDdxT6L4eM6Wk8A8F+4g7DKmiSJUyVbJApQyEiF/aEMTKHU6NLrE90jI+N6gV+Q8KzZG85qKTlwHvXf2XvB2I9CE+XqOkIo5nN/3I+X4VSTx4x7dwbOBzpoiEn4C28EAX6nyRFeEPBkZYZIC08Fdwc6QM0wNiaHFqv1DFb+u9lEbM5rYNsB0FIB8F4Buk0yV0HUVzDRwyRBrFoDzkWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYT0/xfGca1yhutQehvFy3w8vQMMIgFo5kT+ENK4HGg=;
 b=mhX7Bhz25sYV8cWn7QwJ6xA5UNzIgvOsl5ciH2WyzYDqYTTdABaFO6t8jiFoYZ+77lT8HyEXuqtjKIFe0anlKvvi0wrQcLdQYvhnKiRSul99jmTNyjwdr9tLjXUjmto2Iq1Fw+ZRRpKPf38oOlIWdj8nT4GfdsmPyZSeTWo6XRAoVoY8ND2o352+fGIld3ZFKh4sTtfrsOeHw7yzimse+nESsVkG/CGFbODvLFQub+dZGE/KIcMtbKozW+RVZ3Iq7s5rVD9Uogu/pZqYQ1dOkJVVmNeFREX5yB/OvIP4u0m7J1nRd1salK7TH6dZBhTTrpEDO4YIcM6uZJ5hpxFFzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYT0/xfGca1yhutQehvFy3w8vQMMIgFo5kT+ENK4HGg=;
 b=pF75TSBRReNgeq73wnJj5m2AOofM8qLIGim4yXAYwV6kVfZQuLf6tUQU8MDrl7PVY7xCsUsMGnGDXWbr1UfIxr/Uk+HHmK9ecdiLPerma+KtqWj4/LeFF+bGWxd4nozJHGNT56DU0KoMqeMLVKqT/MkthaTNMenIOoYmIqGazns=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR0401MB3525.namprd04.prod.outlook.com (2603:10b6:4:7c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 06:51:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d%9]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 06:51:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: use u8 type for btrfs_block_rsv::type
Thread-Topic: [PATCH 3/3] btrfs: use u8 type for btrfs_block_rsv::type
Thread-Index: AQHYh9Tharb9bw36dE2PvHRW46hatA==
Date:   Mon, 27 Jun 2022 06:51:30 +0000
Message-ID: <PH0PR04MB74165896B1D1967356A84A7A9BB99@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1656079178.git.dsterba@suse.com>
 <2ff62613189d8f58f8da90a1558ad5726172057b.1656079178.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56c3eccb-b285-4383-5cfa-08da5809775a
x-ms-traffictypediagnostic: DM5PR0401MB3525:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YFZZGH1VUuPLlavf6mmeN8f245WQelCz50vhZRgw8aoE9sq8BFStrvl52fpFo0IUsPY6lcpWaQyVngjaUZQ/ihzf9Z8tYhievf8/Jq1cY/i2owpn5nUVxpNYYSsEVfapVNkz32l+nUElAuuvm2Ly+i2C2MDZCly5ierBPnpfyEZ7jOjnr4nU7pel7w5ERNTlTe4qPS8g6CysGPHXNE8yi3n2RVtHvah/i7Le/4HJgBEmi36dw0lzRW9FTBuX1vieultsrglzvi5VZ5LmFzwzSC/nIyQ3rg9a7tpRSjg4d84YZymOiVkBKGCFpXB3XX0bFskSrgfA9t7KuBlEacFDzTNBE1fPWwu94K4j18v9NNrZv5hqcTDGxqzJhy2IN/gNVDg3XP1GQkwPRfzR4/dNb8JAcIUn/i21if82QMCGTKGF8WTmM4TbAYfB6coL91p9h58xXBjTtwma44LeaDQzJGZOzUk7i5dTtkbBZFn2lMcNi6rjSOvUeO4IMUlOiTkNO5ZU1trS4dHzIaIuwAI3av4Qap7+XnO2Y3BgN61NdEWmQy8U85jRCM6FuqPgoos2JWbvBnNkqEr8YH35Y4ZGhk8zYlv5YXhD5rAI1GWTp/Oo3e/P+fv89EZnuttQx3sCx3xF7+AWtku4qRESlH6VEENKg18/tCSGrEtMRxBLXIDCv9z0mjNfFX/tX1WotwXkR75q24W0Npepc3qejw9UzUva9VkKrLLQ/gwVwtZX8AJ2tyLSH4mAVCQw/zlUn8hGxhwYgjj/Tf1BduQ8JfJT5coNgZIiS+YxzqR7p7s3xyE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(83380400001)(9686003)(478600001)(41300700001)(53546011)(110136005)(7696005)(8936002)(2906002)(6506007)(55016003)(71200400001)(66476007)(316002)(186003)(91956017)(4744005)(66946007)(33656002)(5660300002)(66446008)(64756008)(86362001)(66556008)(38100700002)(82960400001)(52536014)(122000001)(76116006)(8676002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1/dgVyPv45DvmHa4HPCUvj4QSopiXapKeMxQ7CGAhGM5TRXsYwWVAl9MgFeM?=
 =?us-ascii?Q?9KNbGciDo2/lEytakUZc0t1WfGdjSv9jplvsig/sPWpXL7eaTZ1PwMovLt8G?=
 =?us-ascii?Q?EcI/u1Vlx/0HNDYKwsJBneHHEXl0C/04woKnoPVAAUEkvsq5jXl5EIz0MTZx?=
 =?us-ascii?Q?OG2W5BmNRd+YO1t9Mes1AlS91W0ezTURx+6dGEKcXzjJyTJ7ASbmSe/zBUWs?=
 =?us-ascii?Q?sGZZ4p7cTRxjkNHc7Z/V/BB4JIQ5or/VYmgqx3UrBlrcr6MUudm87aKYuQq1?=
 =?us-ascii?Q?vUR9dSs4mH7SEzge8j1PxmoSV0ewovdHXKwMkac339WgvAvHkZVDwXwY/C9E?=
 =?us-ascii?Q?/2ptBavBMqtL8UO5FLaUJQpy27uXDSbW1NyJodBW6GUxJ5oROQZ+70H5037m?=
 =?us-ascii?Q?m7L6HyDxUJVTXqg15HW5ZP3x9Lks8FTpVamn8JiPYce6L7GyNGbR7F/CDL3A?=
 =?us-ascii?Q?nFOVRqKQ6LvxvoD//oEl90vKWlNehswIfCzl4g8WfKOzpWoIXnLflm8ADEUB?=
 =?us-ascii?Q?ExykkrtPopBXAmGuUsNpcsFDhAxw7YCI5D8ULP36gEA2SCwmYJWDSp3OjGAi?=
 =?us-ascii?Q?qwL846HDe6fMjquXawMGt/6ofRUi70O8QVMgiJMM/zVXtPst8CA8oQU01UZ7?=
 =?us-ascii?Q?FOBUV0h0nkuwaV2YbYNLUzDRm9vaE/FDQHP7MFlCSZRRdN92Opsggi/KR+x8?=
 =?us-ascii?Q?BG1BrxdJMMDHG/6v3MFnyer8qycelvam3RPGS1ry40jjamsfiAvwEPH7PhmQ?=
 =?us-ascii?Q?xUxgU8wNyJ0pZ8grCK233gG2TcnwMHRd0R/C/qlr7lhD2ZwxQ9TqyfuDlavW?=
 =?us-ascii?Q?n4Aj6wlebit6yjPxCiIU1H8FFKaoZCQsTqNIFlfnqFtBUUbHvxEbs10p9Cpj?=
 =?us-ascii?Q?/EZJxXkJWI7uKQHL3btB8RgkNb/d3VlJda0DVUCt3v6sSgswGn0JaoW81rYl?=
 =?us-ascii?Q?Cga+LBFM0Qj8ezNVtU9Ckivi3ZNYmKcbtHFwQLVR9ox8Qdn+TYKiyaFY5yQm?=
 =?us-ascii?Q?s2rqz1Tp+JSqWs/VhLKJMrFKVRJxsH8SrDHTCXbWriWF+2exlinO9fQL4L/n?=
 =?us-ascii?Q?wK1jvwj9AmCvN2s+5ittNu1Sqy728uQ1XifP2AgefyXKYND1iPc9raCWc8iE?=
 =?us-ascii?Q?d8bCJ7SwwU3Ri8Ntu851qelGGoN+RG7zoUEeEFBnnfU3q7KG0Z30S8/mJTBh?=
 =?us-ascii?Q?snXp/rQw8+sPaqQ1BGemIHF5Yu+lPzEEaJEykFRl//TTY33WwhAgZLIRti/h?=
 =?us-ascii?Q?WmvFUAw7xirCxvbvWZoJh9RQ1HfPsIpd3x+NfZU3LOhv+5bPl5BFmBYsMJnm?=
 =?us-ascii?Q?IkkxbMayWfZvFOmdX+JTGViSQLPCZXPCg2DLYS+fqh4CFTKzEA1qu4EKQQ/d?=
 =?us-ascii?Q?NFOiylUo4say3dppOehRGvgOwfaSH1mWmeRk5xZZ57/xZ7qsX6/W0qI7JsVx?=
 =?us-ascii?Q?Z+9B1KpOZk0+Jqw23yIVgkh8LX+XXum0yCbdx5ZuDK1hiunN+noyNPIG43gG?=
 =?us-ascii?Q?quxXPsB3h3Jwwi1qun3g1Fs6NpC/pErMe/hfxqZdBOXKsmD5OFDwoL1VdPtT?=
 =?us-ascii?Q?394zGFHVAyRgLmchJnoHyvXE9BC7vghs8bBxGrBPm6NW41KnUn8nVfmD/5F1?=
 =?us-ascii?Q?CBgpawruoKQZAh6ZYjf7pF5ceTM28XzFgPtpaqKFgEwlI/sgkNXnNXS89EJ2?=
 =?us-ascii?Q?BVf1fzto+7zOkPywdOqOLtKJoY4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c3eccb-b285-4383-5cfa-08da5809775a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 06:51:30.6082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PUzpkbFDhnmdxas0y2N0g6Qq9R0N3lqiu9cPpzyEgloxkO0IJDeqtK3iNt3HrT55cgZKU6WS4XkqYk2EChglp/VHTcPssgPIAv6a/L9QJuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3525
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24.06.22 16:15, David Sterba wrote:=0A=
> diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h=0A=
> index 0702d4087ff6..bb449c75ee4c 100644=0A=
> --- a/fs/btrfs/block-rsv.h=0A=
> +++ b/fs/btrfs/block-rsv.h=0A=
> @@ -27,7 +27,8 @@ struct btrfs_block_rsv {=0A=
>  	spinlock_t lock;=0A=
>  	bool full;=0A=
>  	bool failfast;=0A=
> -	unsigned short type;=0A=
> +	/* Block reserve type, one of BTRFS_BLOCK_RSV_* */=0A=
> +	u8 type;=0A=
>  =0A=
=0A=
Is there any reason to not use the enum?=0A=
