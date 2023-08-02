Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4BC76C249
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 03:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjHBBfX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 21:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHBBfW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 21:35:22 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BDE1B7
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 18:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690940120; x=1722476120;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jYcCHecqPB9rtPydKvkIBmkKjIiNItkKgLtOi8m2AVA=;
  b=Cve5ZF9J0vgAJsMeop8wDuWIfwTHIYMv32TwKfxjox31fQWZw4ua6YXF
   Luh+kh7On9yjLlp8npe1/UVjLinNWVNDpjg7iN9F++4bn7QESbHY1zmO5
   Kp0nU7k0q3LFTa759PPT4A7u+b1NoZxTd+8dqjmnSRa3goNxjDMzdxWGG
   KCUmO06mYLagqlM8bm6t3e1ENn0Cxyn8Nj9okAIacloOSfTcpumrHfnyR
   28gtefk9lP8wmxIDrBuTrAGN57MRhzYPVMEHVmbWhIZZcB0eKss7WW3fi
   gn+xB5u5P3cW3RLD5kggKN/7XftcZ1DTj13T2yw8pp7Ilrz+GBXjRLpjp
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,248,1684771200"; 
   d="scan'208";a="239701734"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2023 09:35:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mF1EoZ3FmYvliuRT/AqBQo+jmzteip9Q0sjAFKThx5ERaPW9uvacTFQfIBwpe57cP3Lv28xWINaOli3OyWJObZuUCZ0VAIupN8HQ/mKCqd6IQh2nzVWbdHoqu6OATXImPKngBy6HCWuCMYY/wpyuA76sCpfzmoIW2ZCou2aOtZoZxiwSL0ob/tdQR3Pv4ymbx8k0qYzED1IcXKULz2T6ploEqzYYKMbmBgJv07jXDTXCWS6vmUgze2DMAVN9EvL6y6zyT8i7Xl9AmKnHaVHEKJSx0POaKbaYut7+Z4N3VYXW8xkdChSVBa97BnovMn9CLwfsgqaCDDdnC2MBqE+LnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqTgEDG6Pt45n0MbVxIwvFV7Aq8N7zy8LnAUzR5zA7Y=;
 b=MdMz+Mb99GB7lbOOGgERotsD9I+XniQrKkgdQjxtSAUbZIquDsOT2qKxH9En5gMWfki185AhDcjVXE7RaKQZhigSXKyHO1ljchybrvIhEoeySpqhvsMLfIZgn1JJtTIzBCwUEpaitcQbkLPtjYN8qouPGia2qrRbfFziahGB5qZ1OmWs0Dl4ziFi20f2So17X2YhbHwLCAHCXRqzQQHN3Cxtje1Zn61C+am0UnC+jA/NESFczx9ffgS7y5NXifYSrIkcG2LagtxxNYJZwl4sqtjqb1NNoLDIk8fyG/u01NGISICtcxR/bG/e3Pb+ZmB/3/p40bcO4JEoPc/rcNvLKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqTgEDG6Pt45n0MbVxIwvFV7Aq8N7zy8LnAUzR5zA7Y=;
 b=fCXgiymYA3eR8YyLCCE8nuzlqt64Q6Fi+/D4qEtPSTvNk1kYaX22+Gk0Xld5SXwzSivFC3ouVgbydBELkuPxwlUxpRnmd6+YG4oc1LjhZ57fe1AYlNOBeG8vR6VZqKSWZ30ZpSs3ltxKY7Nk04w6lWspuT1JzXF3J56oDxDvmac=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB6953.namprd04.prod.outlook.com (2603:10b6:5:24a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 01:35:17 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::3899:f57:20a9:c783]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::3899:f57:20a9:c783%3]) with mapi id 15.20.6631.043; Wed, 2 Aug 2023
 01:35:17 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH v2 04/10] btrfs: zoned: defer advancing meta_write_pointer
Thread-Topic: [PATCH v2 04/10] btrfs: zoned: defer advancing
 meta_write_pointer
Thread-Index: AQHZw9LpyyY+NOZVmUWYuKdFbQBmAK/VFCYAgAEnYQA=
Date:   Wed, 2 Aug 2023 01:35:17 +0000
Message-ID: <xewivnyuatkwiokoi4tbn7x6vtub6uf7ofgzyulzz523qemzsw@c2ukrge7hqxe>
References: <cover.1690823282.git.naohiro.aota@wdc.com>
 <b33f5b9b41cf80665f8df12c7094e260a38938bb.1690823282.git.naohiro.aota@wdc.com>
 <ZMi7DOBQMf2qJwEi@infradead.org>
In-Reply-To: <ZMi7DOBQMf2qJwEi@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM6PR04MB6953:EE_
x-ms-office365-filtering-correlation-id: bfd840b0-3033-4ead-6d16-08db92f8ba43
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eDIGzXRD19RnUCwGK7j8XIBfy2B99JGqVV38e5ifm/McrsWkntWJrxiK9sJEYGgk0ahaq02BDLRnUD1amP8PtznGmcjPHQvfCW2ltUKSgVXDbMV02o7ZZUvV80MevecFc4XtRHf4zZCvUb/dF8h0njLFGVyMB2q+VQOzGK2fOij/zE3FhQM3mum7/E1DqakxfqDaGfvhZMRPfr6gniBflrDZNIYb9hMjoEL/A80JCYlsHXkfTWy63dqvC7UNqde76CMPqCgW1DtO8rtLS1bNkiTHNtE6aKpqoxocezbfkE2bElDQnKeWN+pq3QGF7sC183zeb1boIoVEr2rUubAbz2tS/HImmhejlhrailzsqGI3NBRuAC4vs7KZvuL4lOxdCXXaydNonicH5ZBdu8MRWuEvmJTlRAVGmvS4XItPcdQ/C4AuBDKA4yul9SGPosQHAetnsOYFYRzukGtODEvwlPkV7eT1cBYRxskDe8rj372u39z+3hXRqtauSCZnhNmjra31RGepwcJR8zLmfJRHejPzl5w/tLmoFV3B+9So0BHxCRnGmLwdnDl6jtAE6iIul+ALWf1qVF0Y7ph3o09uEcdcGUNO3PbcFP4uctHyxP50xaj7wxpOkbtNsmvPD/Yn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199021)(66476007)(66556008)(66946007)(2906002)(76116006)(91956017)(6916009)(4326008)(64756008)(6486002)(86362001)(71200400001)(9686003)(6512007)(83380400001)(478600001)(186003)(66446008)(82960400001)(38070700005)(26005)(6506007)(38100700002)(122000001)(33716001)(54906003)(4744005)(8936002)(8676002)(41300700001)(316002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OG9sKg6bNgXdMimuTUSu2uOi3bowcUXmfmNzqjJG8o/+P1aNZI1svCOhjyv/?=
 =?us-ascii?Q?nrcnJksmKVCi/dTD8udtXW0KBHhQ92ZRszmnZxQJydMFdByRgnpgH/6VrRFX?=
 =?us-ascii?Q?/dLqzilSBCbxS37q/C0SVEEH5r28OSyJfzNZqe2sqZFNA5PTexcvw7L135F/?=
 =?us-ascii?Q?2p5aSuqnKRYhanE9uz49DAM8shrCPJEPJdDkQ/60fT24L/RMRIoXaXPEWD3A?=
 =?us-ascii?Q?G9eNuPju7LHWzFGTJy+D+jDRXJI+svo/ZVc3XwZ9miPgIdb2JGFhwQyMVCl3?=
 =?us-ascii?Q?SdzV5N70iSlmk7njZHJ+9C22BJa8//m1HRj+1UNqGJMsSkQfeDCuxf1gHQF9?=
 =?us-ascii?Q?PQJCLQ5isQZEu6rx08gDNwAus3JaJgtNoe84cYjCwj5f6+DPe7UAF2OHqx+W?=
 =?us-ascii?Q?0OlZuUQn07A3uNyRRXrUWjVDPNDWghaSX9AghT+iBGLxcrnFjZLr+sKw0Bxu?=
 =?us-ascii?Q?21BRA7ZhwyVprW7kXFyZp88BseCAAq+371LaRjGY/9FrfkF+fOMcpxjOhLxm?=
 =?us-ascii?Q?56GLrPtHaYAj76bMfaDevJqiWJA68qEd3doENrD8dzO23gM88meihsefIyBw?=
 =?us-ascii?Q?WppLYl8NiXKi/UAfX+6QVqVnBNddaXtIVGGgO/QX46rfJOWKDbbZJ/sHyyBX?=
 =?us-ascii?Q?N1/I/q5UZPQaNvqHlguY8Isnc4PFsn2pD3h9CTwJJmVq2fqrcRN9rc8nFrks?=
 =?us-ascii?Q?GyZvatRQzuaGTOMvUmVJ7RASqHWVq1kj4B/qHrV54yGU/rYUzP51lpGMkqS4?=
 =?us-ascii?Q?64xitfHsASOGn+HWJB9GQZJUkAVjl5x7OQxfQkR2jF1NbQ9w9rI2yU7OjoCq?=
 =?us-ascii?Q?nTIzUakI054867GSVPQdChHgS4QOeSpUIi0EuZBiqvVOMfAU52Ixtc+yXA58?=
 =?us-ascii?Q?QI+SmSzoAgUuFHMRIgFlF7cFXCbQUyaWbNnTYHhxovdXDVVHAj8nElsNAiQF?=
 =?us-ascii?Q?olC3y2One6bSMbQir5MRN06tFtUHq9y81Nx0bgIJClTe8vQ5Bzdle7wuw7hj?=
 =?us-ascii?Q?D/XXmjAQJiTJ3xFynRuegEVfujRogedQpiEjK3oAVc/nk4voL3Vnsfl8XrDj?=
 =?us-ascii?Q?NEui22qHvClvcEQBK3E8AmMSxQ186mqqWshNjSIWn2fJP3wagaOoyGPlzGiW?=
 =?us-ascii?Q?nQOJ8mkx4PNAkZTwDQ0PUjFnQMXU1gk7u+3VGw0TFzhpSvTWQzXMP5mq0bBz?=
 =?us-ascii?Q?qofLIjTaDKLqy8I+GIcQiIczpAM0mCCkk6NKT8s3jCDcytiEYSOtjTtTJOPl?=
 =?us-ascii?Q?d4mXW78BRHeVVgasEgJH0nw9+pWxp/cyzH4gZhOgNMNucdwTNi3aY6QStvNB?=
 =?us-ascii?Q?74j7cQANgq9+2ZEgEvHgKq9hq0Ed/AW6YBYSBFBvaJopqTp7fjx9YEID0o5Q?=
 =?us-ascii?Q?fsDhfJi22XKhpkOPxqzbaZeLX+qZfC9WGkRT6H8mKweH0vIkgPJDxNnxTraK?=
 =?us-ascii?Q?31kCsT/aS/QO2/V72aP0dknvonSU625qxxuRtOK//oOaecLyQN4+dh1DGsJk?=
 =?us-ascii?Q?XbwPrfTvuxJZJG6i6ey1VmzZgs3AXupEI8hdfC7l6DTg85e12g0UusL/kRsZ?=
 =?us-ascii?Q?s5UmIj9MjBQgy0Y9goxflFZTSKTGaAlIgplpxYWJFlUspXaV+r7MAzewRVJA?=
 =?us-ascii?Q?MA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <68E010E1DB3D4549A10D1BE92C74FC5A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FjEjux0MRGMgQZXlQAlfIOFyDDBN25gbeZEVXvc60g0gP0S+XjAZ61ekt0kXHi1bOwhZYIHIwhDwEmdf5vA4DIWwZs3jmG/UhKAbnLk/jETRx+41T7rQtyqdZF6VFjaT6yjxH/Dk2vbhthR5sFzxYU8KqRx09G+ZVv+HXrPmm3P8Yy5v//y4bcxfKOa2X1MEV9kCFVHM4IbNb14dWcA8wqsaRezdRKEFFuUIAa/FYIPUltQpS/Y0FnPS+czqFwtUpqqYBGlAgAJy50gkAJPf6nBhTpGN7HCHXNqLNncohFnEcLty/IQm4L6dTs2JJ+CBTeaulbkY8snBbWCWZWOI9V5cRa2tZCjnKqrQoa2hewpgVVKs6PB+2Qvh0stgXg6Lakf8Vq49gqdjzTKGTkymGv+gKjeZQtTjRbliBv4rPAqlgyVqifAaJHth3WBjrLOv0w7IYh4zrppWqNE3yuYLM4my2js5LssvGOA5BZvbAQH8Pq0I1yaTzpM0aHuBsasy3XEdU8tw/a97GQRQ/u/nnEMmtJsWb8E48binAph7xmpYbeqLMn8wvj9ECpwtO0hYzqcPoX9ptA2NWgM8/qdouv5C2+8XGedPTPbdPdEf1oycZk4r7Whl0Bhxy46JJmAalFokJmr0tM1k60ejtPD7L90KXY8hhUyyAijkJD7J80bdwBI1CMYYjhPOy7lonpmVYza/F0JoALU2oacRmbHEJ+9j0moaZCt0eEqCYy0oyAGkrROGNJxMve+y+4CE9RanJCIVrN5F4vE9XQkxMXG2DwZTI+sTdNT8WL//nKJT/jsWvF2Y/vgiZykhH5I8dKQ6sedxJmBh5bR4UCX/uM4cD7DTM3oqtdaDUzehf78ePjn/kS34NjquknRp+EI2+hPq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd840b0-3033-4ead-6d16-08db92f8ba43
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 01:35:17.7299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ullToKRqlickl0b5qt8/efY20HpZZLDLVFjhCfkfX5VuaIJQds11f2pcyky7htBtZEFJueMs+GLiGmh/Pf1SNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6953
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 01, 2023 at 12:58:04AM -0700, Christoph Hellwig wrote:
> On Tue, Aug 01, 2023 at 02:17:13AM +0900, Naohiro Aota wrote:
> >  	if (!lock_extent_buffer_for_io(eb, wbc)) {
> > -		btrfs_revert_meta_write_pointer(ctx->block_group, eb);
> >  		free_extent_buffer(eb);
> >  		return 0;
> >  	}
> >  	if (ctx->block_group) {
> > -		/*
> > -		 * Implies write in zoned mode. Mark the last eb in a block group.
> > -		 */
> > +		/* Implies write in zoned mode. */
>=20
> .. maybe ->block_group should be named ->zoned_bg to make this
> implication very clear to everyone touching the code?

Indeed. I'll modify the patch 2 and add a comment as well.

>=20
> Otherwise looks good:
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>=
