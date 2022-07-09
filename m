Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DA656C935
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 13:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiGILeH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Jul 2022 07:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGILeG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Jul 2022 07:34:06 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85CE5926B;
        Sat,  9 Jul 2022 04:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657366445; x=1688902445;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=UFnLfR45/jQoERKUSFwJr6ppt7RY5PCHGguOmEXfaFzjbTMOGYqBIdVj
   R50+8P/UXhS2uGzFaovweCMjbNZa+S+3mehdqEmjptANukr4GYn0iOhoS
   PHfkfvBn7xF5YpFntIk3UD0Xq/0Y/kgwS6qo+fgtbsG9Z0jFfLF4hSLM1
   Qlt69z2ZiFYQC0bQsbsSbclHMbHz7HAaxlMw3gO+BwRUWV7RosDIqGuBG
   i2MSIFghyiLWZHapLtWEC3WJa4+FZVYzEGNQ98yxiUfdz+6bKcAnP9qdZ
   r1KlCNfW91q2C64XA+eCo3IA4tEN2izBgLbvlHyWvVzPoHraENBC0eqxt
   w==;
X-IronPort-AV: E=Sophos;i="5.92,258,1650902400"; 
   d="scan'208";a="205952380"
Received: from mail-bn8nam04lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2022 19:34:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lw3UFHw4OkWBI8t20tjzK1yXMiVuQL1N0UBwtY2BmJ8orCOwAz4ltoY53L+jfeSt0HgtQCQ7NAiIPx+JOK+1qQHws0cZlWBQawtCnMY+n6LNxyRlKw+6vIJwJRA2h1/++F3jR7bCOg/O1Da2rmsiiRxzNxLDE2eGQjm+qb6rCvoMQxEIIdNTX8nKTu0LihfJXWWj2xULidXauJHNej06yx2VRr+K6xORttLgjM8LJeb9xP9uQWQV82S9BRA9O8BnmCo3hGB04OFt/xKYBa1PCpOFiEbQU6RvjsZL4NXfy8ecT97bXHlI+1M+v/+RVt2XmUL2dM+I3i0s55V8wW6QvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ix21QudT+bi6CYHIl650VQOjg2IzAEHQIgE8ahIeADNQZ0nR20qE+dMWcaHjebG+PDtWYghDWL1t70Dokh7yk5M6VMISu92GrC1c5QzT41ZXuSNjBnaqqvp6Tkvj9qE67MMEEORnPXmuT4DnGJHdiu0qOChKjFAHCyNh303yuktPoZoe5Pcv0iQWd0dmCjQ7WMTnrqGIwbfLdpEYYlJW8R1CC4y2l6f1gkQeaeC07H4P1hRi1/n0cEcXWNCubaVNMlziqQi8Vg4yOuXV6ywZsBbF3Nmrww7Gsq50gykmjjclcoN6iEbmTWyUFzlcL2eBwbr9WDiKd98yL6Vqkesj2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=S0JtkCCkobHQU9xARlhYRij6c5QzX1PGw46I7tpxRr0gaNukuwLBLmJxG/izj7WqfeaMC7gylWrvo0/EnwBbbnU7htEizJ+uuz6lduPH618vPrJsCXKjkA4iEgqb69BdKvB+Wh1TYSMM9CHqtEIA5dnr8uUCTnnz/12TqEx9qfo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB5031.namprd04.prod.outlook.com (2603:10b6:a03:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Sat, 9 Jul
 2022 11:34:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.023; Sat, 9 Jul 2022
 11:34:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 02/13] btrfs: zoned: revive max_zone_append_bytes
Thread-Topic: [PATCH 02/13] btrfs: zoned: revive max_zone_append_bytes
Thread-Index: AQHYkyFqeMrCNOBWPUaeWyqFGrIONg==
Date:   Sat, 9 Jul 2022 11:34:01 +0000
Message-ID: <PH0PR04MB74161CE6E1DDB17CE39A4D879B859@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1657321126.git.naohiro.aota@wdc.com>
 <edc9b4fc4e5bed2f442c6d581071f58727833f12.1657321126.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 142091a7-8e46-436a-0110-08da619eec0c
x-ms-traffictypediagnostic: BYAPR04MB5031:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5FROgq4p0QTAz4KGzLyYKguxGgVLLPoVdTp34kY61d6DX8ns3nAt9ZjLMRCuO74wKMrbGEQeCQrvAAs0R9q5F+Xc6NOSgCYaBeAGFaAiZk6sYRc95iVvnH94Ce0rPtBaoj6klc0XExc/hw6bja0Xc5VgbIgVOj7tFoJh6dKo3j2j25s4z6MWz7qkS8C/JeRZGfvWHsZsG8baM1H75rp4DxX/VXAQkX+gkta/Q4AL5N2FZf8cO/DzUF9aKiReXd+ZRalMkXdde8O9pShBe30Q4LxItXyGaJxtzOjuc7LjkXGD0LrpuS5mszIA11tuAsNMXTn2Q+jG6sM5vEWQN+dzem0Uk507FBOS8e7WwC5S0rZwLb0d18AdUe3iOTLwK5rNKhuamnmfGZsgXHY21VQ19klv85apzuptEy38PgaHMcERgVSZzTaVsOz1zIIwOexe4ZPnDG/a9MgS0zXf782t+EyFRsSBBbhJwDAobiLjP/0twVRmjdTU4w+HlybH8HVcqwFFuQdVd0x0M5YzteuMaHAEwTndimpWm321mwjvT56Loxj13CvyixJpuiq/CS+94EdFW2Oap11a59bja6ac/RbKLUgbpUEon0Fx4/skWDfoOfhzr7I385KI2chvvmOaC4RHP88MUc+BkqbgArkHQc7Qnrs09XM9BLVp+3wy7HgoB9IW65g/XFkf4YEkmnSl4aRK37t6e+xsiVCegE6R8RFGQw7vd52bsXCACj6udmQDlGJ4MqnQQYmMREEJv+WgpB4cYnnxMqpn95dHV1g/Z06gU3wmHCZJCd7HPkZP9Rp8iin+CtpMMoU0jNrmH08C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(7696005)(478600001)(450100002)(71200400001)(9686003)(66476007)(66446008)(66556008)(8676002)(64756008)(38100700002)(66946007)(316002)(110136005)(76116006)(4326008)(41300700001)(91956017)(4270600006)(82960400001)(33656002)(55016003)(86362001)(38070700005)(5660300002)(558084003)(6506007)(8936002)(122000001)(2906002)(186003)(19618925003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9sFwzghSg3LbFWQtllVSc2OPuKdVB3zuxyaR96ozG7CZThyGTp8p8ok7y2jG?=
 =?us-ascii?Q?AJeGgWrVswecNajv2PwBHFCTGGdnb6+2yzXgaBJYkbzVZrDTVSyWueLNe6kr?=
 =?us-ascii?Q?bWzB3B9Q0aC32wDOWFK6Gs7ejgnncIveTYfEDgFaK8uAwpwp7foSQpMadSnn?=
 =?us-ascii?Q?YQfOoLPpgzR6eiwbUoghE462Zde5nw5LCCjqNHJIsBUfOLiiw/htVuPeXiUP?=
 =?us-ascii?Q?muPdnBSgrEshCZ8xe6jxCAmtA5GBX0wyDw22HzbJ5Y7XDCLnHKx9928Z2wQ3?=
 =?us-ascii?Q?Cao5agPfJ9c/DAsEOe5sxzbq6G6fxbTHHobG0+lXRgWPfq7T46rV1XijsYC1?=
 =?us-ascii?Q?BdM508mzPY3bznRp1RMfzTsrCo6/ss1NV0EA59YPB0mcVYE34feOquoddUrY?=
 =?us-ascii?Q?nWtGpGTayPUAzxrGdMzv5Exifu2dukpFFsW/bpeE+0jJ3LQGCOKxNUBf1vox?=
 =?us-ascii?Q?v9N2fFUHyj79Fs0KhdRJwAArViNT1oWhtlU+nElBfmS5HyQ8thxirXB537CL?=
 =?us-ascii?Q?RlnzANUzEE7soWEPagAqgUL2lk48z0V6Yf4R9VMLZbhxvgDyspWNqz7w8xhY?=
 =?us-ascii?Q?texbDllsdok/8vMevmsPFiuNb7YGtqvY9ysNQiprM+AKlAzfMFbX+WZChn8m?=
 =?us-ascii?Q?vGco9x1kPpQkKQy4xJiedcCrdlREDD7XFzo51fs76KgLdZlywMXlkFEP5PcA?=
 =?us-ascii?Q?23XRHJEv52PluSogrX7I/HH448rgyRtDSQ0DGhD+VkgTlsDMmW4iqglmYh8I?=
 =?us-ascii?Q?ToppasTZH/dPZltnQtlAftD4f7CJPTWKHQZ9s/xUNwcnvMcviG8CNH0Vj41r?=
 =?us-ascii?Q?Picm4XaJgUZFaPmNEUgXSXTSdHfiYbYqNIAoVmfuItnEakXgFG2jXe81pcDg?=
 =?us-ascii?Q?kOCiieN5/T7ZBA981R6OY7QMGDJyUDgdimhPC7lOP7FFBl5jge9ehVsS8IUN?=
 =?us-ascii?Q?6Su/y7TpX10n72KYdFbS0SqFm8T/qup7V5KlN3IiF/1Ezlz1ez2coB+7X0hg?=
 =?us-ascii?Q?a6EtL/xwhyGqH0+0Uk/wNz2ZEi9maLENWCC2f9YkJtxdhvmLGLeMvYv/DvdX?=
 =?us-ascii?Q?9PJwfNPOMmAvVS1QElry0opLc7MVbnBMf54scnC920OBTAWrYvTf9LZgZrXR?=
 =?us-ascii?Q?HNKjxpyiuKvgYIbaQoAwRMfvXVVlNLWxd6NU0Wdnu+eSzTSRezml8VlQ6OAT?=
 =?us-ascii?Q?GWuT6Ucj3nHXua/aA1Ym2o0tHGMGG3LFsnTBJzenJKbgLtnpXG7aeH8mWkwr?=
 =?us-ascii?Q?ES5HM5yHc8qkq+Ew+dwd7mjBoeEVbLIqezCQJpUaNatO7lfmHtsMugQ+mx8C?=
 =?us-ascii?Q?Z66unlaIkRHJIREX6Omd4Lmj4NEufcazhwgw6qUuvxHDH7wv7/fSqhd2dlMe?=
 =?us-ascii?Q?0rRZpmqACH3vp87VGePQZF//IC+m11hCAjrbS9Zau6I7ndEJ+RMZYHAioroG?=
 =?us-ascii?Q?cJu4sid2AozRl2b8Q1TpupGO8Xb1RF60fZAE8ODIpQrTa4CaKKqC6l1buK2W?=
 =?us-ascii?Q?otWu3FKUl8zBB0ZwAolxK6XPVWWH8qCncPUauF42J180GdVLoLdR2MfAdkTQ?=
 =?us-ascii?Q?ThhkR0RMPW+x+inU1uLD3xYLJPyb97m5JYjMbbEwhl8pSRYY47jinMSNDSSz?=
 =?us-ascii?Q?gB/ax+SZGN41j05LEzMtBu30HDPpb55iBGz6Dgt2avwjhCJSsko5+7Rk4FbH?=
 =?us-ascii?Q?2A2yUtAYLgrtq+IbZTeDjQmK4UE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 142091a7-8e46-436a-0110-08da619eec0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2022 11:34:01.8815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wv2Ivmx+C2NBzSiRDAXz+RC6C+rPBHXKL0QNe79aBjnrypOqeicwXk3ngM8+2/DHEdENsVA0JA3D4PXGQxLwqR1sY64Z2VEFstJ3TCkgpjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5031
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
