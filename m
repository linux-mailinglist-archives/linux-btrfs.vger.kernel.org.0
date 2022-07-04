Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11800565739
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 15:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbiGDNcC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 09:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbiGDNbe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 09:31:34 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E902BF7
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 06:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656941226; x=1688477226;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eLH7FWeYkj6oMwTW6NbcEzpo/IMlW8umApfAGHmDLjQ=;
  b=ATAkoynUtkmuvOk9bZgLX3+WC90VCIuF6r5V5xO1JJDCv85pU/vz7CUq
   eCgVeTWB/u2FTgMWz5PWhZP1u1afuGk9co2PfCsdYqO8ffHOZa3lY5V4Q
   8gVKcZJ6njaXYE22PK9H52CfH8+t5bWFvL9eIRkxDy1GEH9mPqleXnunN
   2Upus03WMu4vO5h1wV++fZ+dlWaQt1zvQe/+juP3b2RavjEGX+P2KIBZi
   Em7DHlXmP3bBVzOpTXMvZjl6JAYEMml6eSdmjwbnNyFncmd9iGN1OpFQE
   sJ0HhKPmhIxMt60joLgnD8d6S/Wg4d+nNF812cx5GFw1ij2Myyt6vOfMi
   A==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="309091347"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 21:27:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkT+REISYvzi4IhaR7oV6TFF5wSSrMZ5czXY1NoxaesXDnRJ7J4QUsWt8lU88okTqCm6M3BFyTWpaeZbdWO0rp/IjLweDZLIktxz8xNMuX8P7s4SrZ3AoZ2gdVnbWN0loR4t9S9WnqqXKu0Rb0eEP2RVy88GJ8QjTVl8VnC1tCtmTLAWQSoLJTMLqmIGFgZzlHwWbRxVytgqlsDlwiFoHygRzV81g/rM/ucIZ8GS5zuNBH/uONt5/E9iyiwJLnRFpvMbW66maKM6uD/qBKf9+V2d0GgbVMD+fdRPmXF35UC5XqqVItqlXXmr7WJOSZhjNlRkcnFkzhTNeNx5IOu5DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qs8qtbTksciIFk20BX73+Ex9R8O/CfFaaubkJbuHAU=;
 b=lviUJmL0ZBxzC4uu4fpJSYJ88RYzt2tr/yIb3+CzU3dshBNdSZhgkjNUrvywv+lptq/2+Qai2ayWbc76WsjXL7BpqEoJbht7Vu9VMbxr79cfn6ZDFN6ulb0CmoSUSwd2HlBQuTsVAZuBQof4d4ojQHyghdQ36zxkoIOH4SPU/427hdqraqV6xozccUwGOagZak/uJkaU2AItjLpNiyBzXXnlhX2WUnVvwhbf2Ll5DWBbQpRIosaavY/tVQO507gL6roBpOgscFWna1W3hfjHIS3nn59winbJsYJk+dBhhgwycbNy/PHhcp9YA+tIkITMX77qUOmsE6/BZWU5kgtYLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qs8qtbTksciIFk20BX73+Ex9R8O/CfFaaubkJbuHAU=;
 b=m8Bqv/mQj6o7smnfqV/sKjP+eJ4nNQ/jST5CV8Q+Uzj/Z/ZciPeAElbwYu+82ZMe+dyL9PGESSaTZXhZmOdC7BGXYkvpsVDYsJG0BlxlOnP70jeQsVncoW03VbTUnF9vEi7KNMqWbePH5fgE+KZuz3MIf0JWfG0jXR10aG0FQL4=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BL3PR04MB8028.namprd04.prod.outlook.com (2603:10b6:208:347::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Mon, 4 Jul
 2022 13:27:04 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::9865:ab44:68b:5d5e]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::9865:ab44:68b:5d5e%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 13:27:04 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/13] block: add bdev_max_segments() helper
Thread-Topic: [PATCH 01/13] block: add bdev_max_segments() helper
Thread-Index: AQHYj2LA7yvSiQoku0+iCKheJrOP661t3/oAgABUv4A=
Date:   Mon, 4 Jul 2022 13:27:04 +0000
Message-ID: <20220704132703.szvlx323jyvlyfy4@naota-xeon>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
 <a3eed5d77f1cd3c7768780356f1528f9ce6e540a.1656909695.git.naohiro.aota@wdc.com>
 <YsKjkIGBeUV/h6eD@infradead.org>
In-Reply-To: <YsKjkIGBeUV/h6eD@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcc85e6e-ffd5-44df-d0e7-08da5dc0e29b
x-ms-traffictypediagnostic: BL3PR04MB8028:EE_
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: khnZINaBVIv+1/2cvxNvFLzDRQkWD6XcgW3gAJa5qJa2236PUfZBHPeQzabn4fQirNwsaN1btN4cpFGDrhKDXb2fc78U3vQlAfdGFqfcacsS+Nl7xM6DR+BKmzqwj9KZ0OJJKIbtnp5HtTWPzeuxeSx7t5Qg8hAJDG9KkORmRQZhVs9UhMQfVVUeoV6A3Sty8uptLsX2SekFvWoiEKEOVW9RZ7odTkaErhyv0k3mkfDL3p19NfWqRS9cyx8xwo+V6DqdRMgkEpJzU+6r+zQTbWxl5PD2xnI6JpfsZGyV8K2qTDEDblGkmrndgwr6nVQhsbudru/nB8cheu+xH/H0x6vkQ3W3cz71tTUZDGPu6pUS6RhwyZoXM+pU+A+YXyzFsYx+wSk3iTDrLV7LNOtdS3HXGfA5JcVLSctTgyaWdoB7R/FrO7xOxu9Z2A4vwN8601vWBdtvDmvUKehkPBirvtvD6Y1OxkfX77eG8KObLennMY8gvxORmlBv1m8b1VrP2++DRinitO5To+Xy09UGcbhq74ROWoDpOHMwwFhHm3BcL5UeQyIztu8CPIDXpX3jDvcD8DslEv695dT4CkXoVvX67OoeQANQVvYUoKG0oL19FKUbwV2LlVmHotlR6ZRGyYucH3oiQ8Xv6h0OE0ZXaLP1n6dvvwsm3Zsr9CvgBOG7vYuwfm7Hic2OxBxcUV1OrmUVk1tE1nuCCzdHoqaNV55n0P+46VBekGrEYQBxyM6BgINcZylbBVZidugkY2G2PNf2zbjB6K7M25PDb1U8GOhMWBuIU5aPCH9P5GQ8V7I8IAHjgKQ0SSaRsGj7yA92
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(396003)(366004)(39860400002)(376002)(346002)(136003)(2906002)(26005)(82960400001)(6512007)(9686003)(38100700002)(6506007)(41300700001)(186003)(1076003)(83380400001)(33716001)(66476007)(8676002)(478600001)(6486002)(8936002)(6916009)(5660300002)(316002)(4326008)(64756008)(66446008)(71200400001)(66556008)(86362001)(66946007)(76116006)(91956017)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UwyY0oE0s8g4X5e0RP03ejCdV071/EfsA9WelIl8vxLXZLSLeFtm94r34kMp?=
 =?us-ascii?Q?W/71cEqdYOnCc5UHcMrVasrZDmRZSKXSLHjSeiOLZ44ObSBX6dYEUJNaxO4P?=
 =?us-ascii?Q?Zq0wtVV0v4ofklTOEywUdef77O2WszLEXi+iOy9LEv4z7y0WBJeYKyXtSB/v?=
 =?us-ascii?Q?t5FnDRp8KqlZJAuOSEr6HFdTaitqMgpJpG+GXtEhAo9X5ZoJH+R8BVaqXBoa?=
 =?us-ascii?Q?4MsiLuJDfanx9cavpZ1rsTVDmDh9HIBUoKOL9WaaCLRZttvnHEuxzScqdVQ9?=
 =?us-ascii?Q?0pIYMMilPWDJM5a6z6OsydhByFLAX0Qd5XPRd7l7ykMam7lRjh8PrdIh6mR1?=
 =?us-ascii?Q?+BVVPCkszKmzQRuixPI3Z81/tLrPDFQ2ysAlr8uTWW8pNZJoElEwfPktdgSZ?=
 =?us-ascii?Q?7MzBlGX24XEu7nCChIbVxQzdsy0V2Aw9KncCcVRbBoVTH1i5/51Liid6/6jq?=
 =?us-ascii?Q?+8xg5Y0+S7MGEWQK6O59qBW+XItb5ZaqcgHjSYKUiyKhatTpa68pujh+4qGB?=
 =?us-ascii?Q?aX5KRxkBMoQSsowTI9Zklqo2SJTOH5pEOp6RLgp6xtw3w0ruuYT6CjxXEUtq?=
 =?us-ascii?Q?Pt4IrIb/MG72H88TiX1wNHsvR6ddBSerxF6Xp4hPSoQz3dpLhBPgErgLNk+m?=
 =?us-ascii?Q?N4JJYs4J8qTzthOgxkdi6RA6DF4mHNM6BKamEO6Sx1Nc1rk9GMVYJlpd2NIG?=
 =?us-ascii?Q?DSmm4Fa/yrbY/nNwnNffXiYwl4r6xNRvDaetStm13dMTbX09jFor+aUZh9jl?=
 =?us-ascii?Q?QEc8qUoY3Z9U52YLzEKPCe16x1nrXMvjF+ZM9Alru/wKsKdr6nA5QqaqSvrS?=
 =?us-ascii?Q?hcCiZlounTLDcltzJ4MzD6FnFauWiXOJHMcxceI1j60eY0GcUDe5s7kpxTl9?=
 =?us-ascii?Q?3FI5mXm+qfVofwg2f2vDuPhVZqSvWYlKqH8OpjAJxksqdz4FqqXx8QbDzg/u?=
 =?us-ascii?Q?T3eLa1BAgP47v6RWn/Bq7p3eogSSz6GcWnrI61kBGH6JSNnmVU3iSU7Ly5n7?=
 =?us-ascii?Q?ZSjy8XxNXYDBqweDM59IokZMUtzvG7cb2DqD/MCCrlphdYi3yS/DyU8lpAQh?=
 =?us-ascii?Q?8UXsWn/uJUzDbR+tRYlKHI3K+mm5bHHMEfTxe4L5fR1fpZVLuEfkuqwIsf29?=
 =?us-ascii?Q?ntH5/5GETjmfgvodOxgndK6v9hS50uTTOc6U1mj/0FB+NH3C7EDzR68bJu6Y?=
 =?us-ascii?Q?fuyKu+Lr0ch/VE5+SPxA59d8pBgg2H384oe9LXI9iAfmts8m8qW1tO6Xwfba?=
 =?us-ascii?Q?bvYkDfs22G3yhFHfOcyhRKBEimd9dp4amUsa/6y0xQRtCQDd8YvNQTzkLuv7?=
 =?us-ascii?Q?WIif7TUhj+XKOPTqDz+7VFN0KgHFcwg9tATKatJM+Tn8+NSpX6mwFBxN4CJe?=
 =?us-ascii?Q?0QPgJG0tZPNO95Pl/tAZcPm5w7ryacTJYvsamP9bYp+rR6f86FDTNBW2NcHk?=
 =?us-ascii?Q?XKEpQ0CMwG5Zl6FUxEQmhxFC2DcTzhzunEEjPVv08+iFKL6g6pZteum0fNQH?=
 =?us-ascii?Q?R8sPrOk8WDfeBiwgCk921IZwM4kRRwQraJVhyYuPpLBnmzpD3/92xhPXjoBi?=
 =?us-ascii?Q?2gCSg+LVXmVyGeEhSGHHwxGIyL5Iz6nxNBbWQqLJA7cuP9o5491cVi3pj/vg?=
 =?us-ascii?Q?WQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E9DA309E1B1ABF44A2C9BC87FC3F0BD9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc85e6e-ffd5-44df-d0e7-08da5dc0e29b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 13:27:04.2844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f37Cn2I+AXcbU7HUvZ/d+0+2lnWrlj2tSUqmjX+7jhEXOVsCp5rolFdQ/zTns5oTxw78DXQBfkzZ1NoDeX4DzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8028
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 04, 2022 at 01:23:44AM -0700, Christoph Hellwig wrote:
> Please Cc the block list.

Oops, I completely forgot about it. I will do so from the next version.

> On Mon, Jul 04, 2022 at 01:58:05PM +0900, Naohiro Aota wrote:
> > Add bdev_max_segments() like other queue parameters.
> >=20
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  include/linux/blkdev.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index 2f7b43444c5f..62e3ff52ab03 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -1206,6 +1206,11 @@ bdev_max_zone_append_sectors(struct block_device=
 *bdev)
> >  	return queue_max_zone_append_sectors(bdev_get_queue(bdev));
> >  }
> > =20
> > +static inline unsigned int bdev_max_segments(struct block_device *bdev=
)
> > +{
> > +	return queue_max_segments(bdev_get_queue(bdev));
> > +}
> > +
> >  static inline unsigned queue_logical_block_size(const struct request_q=
ueue *q)
> >  {
> >  	int retval =3D 512;
> > --=20
> > 2.35.1
> >=20
> ---end quoted text---=
