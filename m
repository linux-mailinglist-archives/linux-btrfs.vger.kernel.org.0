Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2B9562B21
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Jul 2022 07:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbiGAF7c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Jul 2022 01:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiGAF73 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Jul 2022 01:59:29 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29E36B27D
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jun 2022 22:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656655168; x=1688191168;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=GbVnEhwtelwG0wjAKBhCZ/sQr+mie6MkHsuf1TP80JEQAFalNxKUSqlh
   xG0sdxff+IM67WX1rRrL6+DmqdOlJ9weEQ93KDhwhBmhStVV9oApC3fh/
   bKIQgXvQS/8iZruwSiWlfwApGrivHcpFqnazgWs6de5gEyiiN6n17weJ0
   3mdyC3pHMrg4e5g6uOiZdpiLgQez7veGqvK2XDfCIkJFbUlsktA4ISlVV
   3O63PpIaoK7xV1HQo/NcAWW7VP/yx3Q92pQ3koNHF7SE1cjV30inlyJN7
   Me0dPaNYmfEboT2f81uK1C34XKPI3thHqSEiwNLA25cYcvXUdj7jLvzj2
   g==;
X-IronPort-AV: E=Sophos;i="5.92,236,1650902400"; 
   d="scan'208";a="209439710"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2022 13:59:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4SURr6PlhTl1kKthsl8wlGrXYJB0OlEEm3JMqghG7Y+6c1MQrw2qbDlvdCULq/RgDQdHHvxO15HonT2pIuiEccWhpNzUQhLRw0DKdbw/7aT+y1R7txLQzwSnOsdmvpOMaON85vOVTDlzvG3awu221b/WAW0kbIzHygqcj/Z1B5Q2xHgO2kmvYe+9oBHR/STTr6OGc3Ftlr8fjDXU7pSfkGnwBxqUO65cDwY/a/ffAjkneIARnL3D5JskMnqdZ+wLumr7pDS/FFXWwPIseG6vAzUaIwQBlruNS0IKTKAJRVknKyHfkMO7K5UBBJMaUkhXiwCr6RvbVIVW/E0Q7Mxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Hf5HNFY+S9iOsfreuQs63cgOId1vQCsn6e8Ij5lEsl63I2jnBpKjkMJHMnBJEZwHE4axfuICJvErXUwIPK6tfVxwcwd49PzIbgQyOI/eZW/XXzOBhNFEK764dMNqNCvgFHu6yDp34WgrY36T6JNWXApsNJtrezqoRGzF/cjtNitLf2lmwggQunTM+3oD6hNmTBeQcQTppWXc5fx1R9dhpX4olCpEJ+WFcUZfxnMbR62661TpZULcbfy3EtzyQCG/AdgGceQ9gTgYWBymYi8k0XemZzcJ0wXr1KVX4GIHz/QW/a6H4Mo/bl6xXZz4H9cayjq4MymrDMoifVB0asOkjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=edj8+mHA/1uqWmn7LWxKlkwp9tt6KtxGoMcO9O351A3knl7EU9z2lMuPeEUvHBHYYhZWAWTLA2K9w8gD2jafRrTlhShQuRxW2dR6JTuhyhbJh695b9HdeLMy9YWlpzBpd2GGb10+S/fJ3oqfjdnczSlKwmU+pHlWbU73WKNIjuI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5659.namprd04.prod.outlook.com (2603:10b6:5:170::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Fri, 1 Jul
 2022 05:59:25 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d%9]) with mapi id 15.20.5373.018; Fri, 1 Jul 2022
 05:59:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: fix a memory leak in read_zone_info
Thread-Topic: [PATCH] btrfs: fix a memory leak in read_zone_info
Thread-Index: AQHYjJr7H+V3Cc5Hz06uDYmsIjNa0A==
Date:   Fri, 1 Jul 2022 05:59:25 +0000
Message-ID: <PH0PR04MB74166597F90452AB03D0059E9BBD9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220630160319.2550384-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02074e41-5c18-4054-840e-08da5b26da4a
x-ms-traffictypediagnostic: DM6PR04MB5659:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vWip+Wdi6NVVQVoH/B2uik2sv6V8ggCg47gikLqfAZGrpb1jX5Z1j/WhqzoiIVoGWW/THwHPrUmSuT9lzpIQPVRrYWiNxZEj16rX28N/NzO2OSiUYeAEBUuhtZ1w/0gwVMae0DMSRIm6EBsV7h3Og0Gal7oR1zhpm+40x7E5qpQJsiqTMwNXC4x6Wc0CNIC5093IWKCQDEcKi6GS0LRzuaCU2u+igIfL6IfXvQjr+dXnvTKUt5wD6WBTo3gqBuL9WRXc6LZn4vqNiqegSH4CPW5ut0NR1CcTsMu5Ay6fPjAwsIg2UBJo8C2ZBHJPuJifWJbfqynAu0FFVCKhRw6Wu/DbylV2VaPw1veT4c+lEUejIB19dhypUgpTgy3bJ/6cZWGnf65X0hbWMe9pK01JPj1ggS1hw/7D3W0I+9EWDgoVTWjhprSxQJMOL99hSwofX1OUp0HLSgonpQ1woZe3Yg7KkjO2Hy7siYrofXjnDb7q3LMq0GkOcfxWX3baIe42RtDM5dm5jD07ZMRuaWLzoARYvA6GY11rbN/WeduHU+5io4KtE1pmJ43IORXm+B9WhESbAQxWqLHJ1WT108NE5YdYVEwSvsD2TYgu4plYz2/Fn4LlhnJZP98CIU31kdAzt7doRmqnCFPaX4sfEhGH+iRWYDZ/up6zjhkgl/gGOx83+stpAMAxkiXQX4kkBwnoqIOwxLuMJP8KQLy07CUsyUputcB9eWUvufTMnWxcUePCye73w9IQ3rPzvNAhi80xyscnmmnc19vMPeSiFLGl0HBMMLB0dycp/tp2mFLAXHOzokNBrmho5Qutyia9kzBy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(33656002)(38100700002)(86362001)(478600001)(8936002)(2906002)(122000001)(186003)(55016003)(66476007)(5660300002)(110136005)(54906003)(4270600006)(316002)(9686003)(66446008)(82960400001)(66556008)(66946007)(8676002)(52536014)(4326008)(71200400001)(558084003)(91956017)(6506007)(19618925003)(41300700001)(26005)(7696005)(76116006)(38070700005)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UvG9ylwmlLERWpblNtTxrbWs9jzf0gbnzs14doPeRKSw+Bs8JK1UuAsozhuK?=
 =?us-ascii?Q?+Lbhrolfu/dQDlG5I6sHurO9H8v3m9mxYZIezRWdrtZwzTrMTkEd8rzvrCZZ?=
 =?us-ascii?Q?C5R8OUiejGYiTlQ+5zxvtv6oE9/++ebN1j7RzfJDid+wYJJQ1qCB/maNEhTX?=
 =?us-ascii?Q?RSKiJYLPdMerukO0qrg1DJy2+1zet4h/Sjt0wFUoUml7cGbbn/MtuSiWNkp9?=
 =?us-ascii?Q?NE+x03LyBnSrtTr9mz9YO0nwgXejOis8hBlx8A+SMaVE0+NNZJQGkjEKxQh+?=
 =?us-ascii?Q?bwlZO8Z6trOyzLr5788G8u3nXHFuhMIVkQO3ZgCKqc8GhO6v/Qh2vgf8GScR?=
 =?us-ascii?Q?zLbZSPjT6j9kk7Ewdns9G4SlAzskEEidvGEuOUEHZyucotouUMpXMD7lIUCK?=
 =?us-ascii?Q?rmk82CG5WfHeEFeF4VbBWYj1GMgy8fpSMatu8/XdvPT07Is6X39yCwCl2Iqv?=
 =?us-ascii?Q?6gwZaC41w6hARlfb/koBPcHa14t3LnMr8fjLufyv3Fs2BMiSAPEa3LLEWc1O?=
 =?us-ascii?Q?0QymDU8eX5hkVyOJt4afb/bjhFNkr5LNKtB/QJP8LrLiVjmEN5EKCgIeaqyW?=
 =?us-ascii?Q?MNj2JpbtcGRAVnB2EQW/wBphtYknHVxyKFhwKjPrfYuBeeyxRL1pZuzbl624?=
 =?us-ascii?Q?ihXKrij0szrllTubSdtc7QNjgUKMKonYIzv+Mtjp/hC7SJsskPYs+4Vl6CmI?=
 =?us-ascii?Q?HO81BOTG5gPP8UW3MktiudDfmpK7PCs9+/67Etootxowp3rLTRgK9P3sVOHW?=
 =?us-ascii?Q?pVNnCn99BZeKdYjDkhlfThjH128+VEstbor+ckduUItKzWbnnaN77aOyRU1S?=
 =?us-ascii?Q?DY5dsVJBsvck744oUyTilZ+TrI3h9xCdZghXGFd36qM0UPAMGoKRwGsQw4i5?=
 =?us-ascii?Q?D9xluTxMQueXQm6FAEvS50uMgvWtH6uLQmMQ3c1As+JobpvVvZRjoPEQqRQ8?=
 =?us-ascii?Q?vG4MYlAQQWkGRJZ1O5Iw1hHz75ulDBa7ISgWwV0CSxa8vJbL7wQO5iGABnQE?=
 =?us-ascii?Q?00IcP/x+Ci9PS/e12x7/7KhoH3zw5w61k9/8gAjA69kO0zHZ/jGD0XzDNCrs?=
 =?us-ascii?Q?ubg+FcZIh31Y5wr2Zs1KiGWFmpWl7iox+17zg9goVi1G5IkiaxKPARLX/oZH?=
 =?us-ascii?Q?VCalT69+Tf4kRiTmORFu9f22LVfsmhEgc1b13lVeMY+TcQPVSoBFukq0fTDZ?=
 =?us-ascii?Q?ed714SKMx4hWh9v8XlVddcSQkRvkKIwWmePWSuj51wJO1cDjHk5yu/S2WvGU?=
 =?us-ascii?Q?WH70z7ofEXfl4UWkmjjPymTObljWDnlL5xq+1swjVlyYRjMEQy1sgxizYhqA?=
 =?us-ascii?Q?tu+C0eR/nylSiuXsb/2PD7dTclOxiBfqvcWfcbUHZOConKiNZlb4zP5ENodI?=
 =?us-ascii?Q?madpJAdXdvgWhAkgcGJRfcEtOgBazEP0nkZ9AiIlvmNh7omC1rOK6c0d88qJ?=
 =?us-ascii?Q?AzLHlxwVurHuC/hUoD5/Xi+LDJqyC43tq/WW6gZ23v8XfY2DxYzUsD6cQ2D7?=
 =?us-ascii?Q?56S5W4LrA+lFER/ISRtimoprqMbDpmHJgbJy81ho3YViGLYhMr5R2khcIt60?=
 =?us-ascii?Q?vtVoWPboHUcP1zYNg45DWcU+cg5dU3KCBRryq05JUYOWwAnbRgHs/EMecx70?=
 =?us-ascii?Q?ng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02074e41-5c18-4054-840e-08da5b26da4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 05:59:25.5079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V1/lwdU4hWGDgtLVkJw8cY2Zy4tJgNeSolwU5hF23VdSMaa+p6mTU3lqM2MPvRC466r21GInDaNlVxXNxgqPwQUHX25oe1MLTV3WwqNmV20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5659
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
