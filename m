Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B9D572E57
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 08:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiGMGlU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 02:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbiGMGlT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 02:41:19 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24F8DE19E
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 23:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657694478; x=1689230478;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=u8zLXEGHp36+Zi3AB3qIcVf6/L+xOvpzoXubcHLgPGg=;
  b=FIbD8fspOGeVnxTZx3GudnYropMrTG3xp3uKXW6PRxUWBDni9mvkD7NU
   6g7Kr6X66b0+smeFA7H0e3oWOfG7ThlGnKVUI3oMztWgGD4Owk+6m2BS8
   WoWShBMwyZBlgld1ufKpuHcEH2ms1CESfOXwO4sacM2CMn+H78IT1Ez7h
   eXJzct37MBlBOSy7riXf7GZDNMwrysWKNC3f9Hi1Uwcmi9mts3GQksrFA
   n8q57JEl3yHVZe/gP/OMc9XVp9wupe+f18efPnnXf1nYmBUgF2Y49c2ZK
   FbkEgvIwrY1KTVPqG4KC1KMzDcPUe07lKg0Vb79AgntMcT7xZXdojTKOH
   g==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650902400"; 
   d="scan'208";a="317711393"
Received: from mail-dm3nam02lp2048.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.48])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2022 14:41:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jn/BSuuUIS/AQtbIgwLqnO5/pVkShcqHmvjIUQOxKxNa87ky/63p3D1Hos0Hs2aXaE0CQy0GCUJUa4yfDoroWXuvxR1LHTRzxEJYRO9CQ1UlKmkroQm5cS9rqE+cs++EZniBGn6C5OPTYrNIMsWKdMgElNwlGaEOm3m74L807FRn3nWmXK9Yv33P6uvW1AM4Mx7PIpwYLkbhsAqYrLeSgY4LVrzaGZLsoOX1Rwb8CRYagKQHf5+Z/qXMdeNRffNP/BFnPM181UXLpx4QV3q3qqTm1MFZtlrlJ5aIx8UVNo2/gX9RILpEO1G3dX6HkWS+vh1Y08Al5sq0RpN/nDK7Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrFsyuZQ82lPOpOyebUx6yvFUdOhHk7HvkypcQdqzKc=;
 b=f2X2R7JAUtHGMuUKjOfdLD8Mf60ZY8rqE7wtZta7IDLRdZMr6efuvTvjCC1ZZv5RuQQWhdNDWpC60P6wR3zVKnPEEpL/BTEK0a3lnPkiQZonvRmXd217si26O6HIJVoNYf+SDjucdi1gAY0Rf1OvyTv7evkfiGh37ABOVUXuC00w+tSZAVAgtvH2SNVFvpk/AlBMXbiNbSiWm24709DULB91/thYIafOfOID8TyKyzFwrErvawl9a/RfPopW2agHRgLoAwELE9F+c5obMWTlAprZiynrgjtWz5Iqnw9pOo5xi6HJY69d9IECVxUL9u0I84E23kMck6C3xnwpXnYmXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrFsyuZQ82lPOpOyebUx6yvFUdOhHk7HvkypcQdqzKc=;
 b=chCK1c0ENuNsi1V0RA8P0Kh/Ndi9Sl5ARZDJX2uiPs0VX2XD8hlbHzycRdCecvssyQPjvkb5d3FXKDDIqZpkEaXeJq/0blZNFz4QMLkAl8gT7okYaTS29evfrKyWvCeKZM05KDJ1h8im+vx2cAhB86nz+qF/8HDku31bVWEHxgY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6667.namprd04.prod.outlook.com (2603:10b6:5:247::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 06:41:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 06:41:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/11] btrfs: remove bioc->stripes_pending
Thread-Topic: [PATCH 05/11] btrfs: remove bioc->stripes_pending
Thread-Index: AQHYln/J4vRfMX6mtUK3Ptb+nH5WAw==
Date:   Wed, 13 Jul 2022 06:41:16 +0000
Message-ID: <PH0PR04MB7416092A597A3B969586999D9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220713061359.1980118-1-hch@lst.de>
 <20220713061359.1980118-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2c00fd1-2085-4dae-8b60-08da649aafb2
x-ms-traffictypediagnostic: DM6PR04MB6667:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VXXsxpAvON7fJagLsEtXeJOQ3XQFzcw1LXJ1N/o2sa0w6lpynGqEuFsQAiI9GeEoqt0/H1Qy2MTxrHHT/YSm4VT3E/5jPn9nuen2je9wiBuERupWMipEtKKdX/wmYLDXT6CoUj+9+xd3/p5ervvexL/GHNvOPHoXfG8Tiiv8OquvlGP8O+S1i1toldUTAnuuOTfQRIRvbQi2zSlpdR1ZwmUzl2cI0V4ldV01OfmQ9+TL6vcPQ5TGosQjvbbSzQ0cVO5GuR5N6ZOjn0BoSMAPJLXg2JeAo5b71p+rnvSCwKEPGaC8gObeloiHfqfpselwcoSVEat4tEbkCU00e8mqDvKKoJb3BvdZizve24ZbjETyxkJ3cxrNBltnaSvKwUonDEW6EITlmyt8AjuNbHFO2MHxL+IaOFNf+ukzgOivLZ9XldgcU+kbTHteFMplW+jMt+L92BeHErLUo9jcgqtoZqdYBD/W0K0WfbqxXMJ7LMTlSCZ2fvSEEu/oQmtR4AYtrrNJDT5Qgwcw9AXH5lgHs+3vQPhOfHXGeSWs1FUdLaKf35yQKmqsTaexyo8yTzZ28MTN4JzadAyb35aG4slCo5THi/S9PQuwRaAajue2xEdn8abe5q19DiBX7OedTeMeEwKbwfdSkbGDwDR3ah7RxVhIULLg290m350ICx680nJHqMKPNlIur4M+YtJvZW6kzwVdEZf/DV+uCWItLrA28BQNEDThNbnBILlQlTqPf7liE7X5ciAbqRZTT8GpI+CL73APEbHRt7PKlecuAtuPf8MiHPo/5MU6s1lb0xewPyzHYQYss9/WNhAz+TzA14+D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(91956017)(66946007)(8676002)(66556008)(66476007)(76116006)(55016003)(38100700002)(558084003)(33656002)(316002)(64756008)(4326008)(26005)(9686003)(110136005)(186003)(2906002)(66446008)(8936002)(7696005)(52536014)(5660300002)(41300700001)(54906003)(71200400001)(86362001)(82960400001)(6506007)(53546011)(122000001)(38070700005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HbHGNHFrnRsrX1agUHp1AdaC94AE0qD9AzOA9t9Q+BmIvmgQN2DC69lEo/GF?=
 =?us-ascii?Q?7tcYJCZT3CvQr5EpXgsabhlnMu0Npmo2iGr6kkqtRfO26e8YptpQTB7sCAvP?=
 =?us-ascii?Q?gv9zwVCr1y7PrhEmgG2gmu0Rf5z9x29cDOkB4ekK2K+iuwauu3G+MbzUBtX8?=
 =?us-ascii?Q?xx33EaaNumhq2+pZOw/3AaV4MaUIPM9LLdf6LXcKFHzywFjJf+uMEL0v60p3?=
 =?us-ascii?Q?weJWVkEG/n88/f0+dU0CIY0QdbVaFUJjzd7+bWgB7qGpToR2UkKXKZy/0nrM?=
 =?us-ascii?Q?vSmiqKz+1qwKuPESyb1VomLRGOXlOQGagRi8ToJMDlJzzeHmtibrh8XaOVyM?=
 =?us-ascii?Q?JmFlS23iTD0WScRNwDtXTNpivckSsrFJhkGQvcJv7wtP7m0KIzgiaKog/bMb?=
 =?us-ascii?Q?DhrXJ17s3pwJ5vrl5qDZf30qAEcFd0Mkx3oYEoIrfKJaVr9aLFpDkgMi1zFH?=
 =?us-ascii?Q?oIMyMoovFqLwRg2rnrqtrnHxRmkj9YiyPb1dl/9Ah6MJ+U0NfUmJEXZR35ud?=
 =?us-ascii?Q?Pjf5Eu+Fz+wxOXz07WslqxYLtbD4Ux6xWrbeiSt29b+nzkk+QL1abt6V5rWl?=
 =?us-ascii?Q?lhbippOZ2hKG/ynPeDL18dcdM2ClmYEt9tK8OAeasKVEPucy/piGR2u1D58o?=
 =?us-ascii?Q?xj4WHNHEIVXsigMOkBPTQIj1aivZByO7OlNzzdrsEavB7gAN1x1T0mktAOQa?=
 =?us-ascii?Q?V/W8vX5OZ7PX74imHGCKYUgL+kTrVmn3TD0RyprVXrq039bSkcupY2oZ8vTO?=
 =?us-ascii?Q?NKXS2aODfLcojTFeIxsM5Q82H1dGTtJzSnUC+MRC2zX8Ukv5C1q5N1rUxoqY?=
 =?us-ascii?Q?EUleElk6uYARKTZayPNXjnzZ6QjcvOiXUcSPYOPiJ4bbqwhzV4ssGrlbBDve?=
 =?us-ascii?Q?w/Y/Ij65i5vrcP6m7lnPC4hwdPTfMuXHQjqgQqXUJcDMs/BwZkSZ1pamPDCJ?=
 =?us-ascii?Q?SlG/wl+Q377s1cRf64azOrgre+a9IfxBAkY077Od2z23Ux2GiQl4xobLspVd?=
 =?us-ascii?Q?bwtf7t75BF1lKY2A89+U/IuiQdahz3msG57sRwtY99VVGAnHVWeLvP+xbO3o?=
 =?us-ascii?Q?J+pXyCifFOxJ0BpIFp9XALeuAb/nD/Q898slhbNbDC3WWybTQ7u4vSYXAyxs?=
 =?us-ascii?Q?rfTcUHb2n20e33RQBGWXd9U7vfIzUOmlrFZCDq4xEujSwsZp2Ll2mmqyKYdD?=
 =?us-ascii?Q?FBF8RBSa126P9oJBlDfp/9ytthvtiyrnHXEFis47w1TdwmVUl+MfrKaSsslV?=
 =?us-ascii?Q?Ok6ts+OAaOQqeinOWWkZ+40TTTw3RVS2tN11gji19hyYeeIdBfAWY7pfItmW?=
 =?us-ascii?Q?0US53fcr4nYJfQvb36vq64UNLQ3WqLaZxnlOEqS1bsqJcrnRW0lYwpG5P0Xv?=
 =?us-ascii?Q?V1WNUXiX733Qy2EuT53cfciOpzH7qn4a0nKjZa3ZPr5M9LHjiTGxOpt/xB0b?=
 =?us-ascii?Q?klHUxLUj6ik/XaHL7xeR2zWUiD2E5aySkUMp45kSvNgCIVYeJJ7s6nrXv3cV?=
 =?us-ascii?Q?FqAbzpQd91QB23CLv/KFaY9BZZc9wIXDI5iwOvvIjrAJ0mTVEwxSrBgbxPNc?=
 =?us-ascii?Q?OlV8O0kM7sTELK/fspWSd4XWgBLpo16wRhyAFJrMFRdYogjZ7/THHvV6FY/+?=
 =?us-ascii?Q?lC8eSr/I91sKWzKeV3GY9DI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c00fd1-2085-4dae-8b60-08da649aafb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 06:41:16.1645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xtOEHUb5++mFi2k2Lg6Akno7/ethS0x6kH6ajEI4V6TvIOxbNIQacnrF2XRu79C8I4sTalYbgMpzfJr9SmUwDrcohOqbC5DvBdstQu8xO5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6667
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13.07.22 08:14, Christoph Hellwig wrote:=0A=
> +	/* Pass on cotrol to the original bio this one was cloned from */=0A=
          control ~^=0A=
Sorry for not noticing this earlier=0A=
