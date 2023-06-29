Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26140742220
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 10:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjF2I1n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 04:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjF2I1h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 04:27:37 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019E51B1
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 01:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688027255; x=1719563255;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CGUsMUxoyRtndEjdB0Wjn9oH2TMXLzUn4AgUjTNq2/o=;
  b=KmG7F+zRDiIRYZV16F9Un3dfXPGOgbpRDP/hbZXsyWXJwvEyRo//j/Zq
   HzxtUWzY2tcZEmeCRKOAG0qZc+KoJe+zpvZHvu3Aeg12IVMYo8XonGLj2
   /b2LHNv97Mi4Oqfn/ewELtoyzMn2xdsM7dRRzUD/rXOvBfJCRViSF73V9
   FmA7Dmm+iE/Ptp2IZRn6/DBuqDaj8irOYkwUNbVTsxE9VYGZtoiaUhKh0
   0A6/DJ68aLTOVYkNDPfoanJdRxvjXd3LoX2L3Xu4gci1OBhx7+1t0ZM9B
   OwVNaCUMVaGztiUSaMZgHafTcaxOaxyjwdQBjXpMvRoF89TvZcapGW25g
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,168,1684771200"; 
   d="scan'208";a="348690791"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2023 16:27:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMmN5dTMfcOUdLD/RF0uysyq+w1z8PrJy8whh8K2pbyLhspP+oV5b6P3JwDuxsrX6LYj/3l49EPo7A3wGwE1eXpeC/eeaRFBSWQL79lC0o/Y/KrgBoHXXKXB61BSyB8ZIjWJ7weIpZuia0nTMVNIAR9tIyNnTVa6aKtwr8n/2fTcfw5E9IZgb57qJd6oRzWmFbi7o1W1xNDv47CSnUiAWOa5L+o/62Lz85lKdt2s45gW4xyPut/aUJuwyiBvyhbbwXv9bxWYjtxOo6adWj2MWX7xgUOn09HSsg7QfVka4BVseCHF92flF5chXtqbZzk+1A9FdyJvCqpFrJz7/Tdp+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQWanWQ+k2ASyJMjwRo6J4JkJDm7zcWsuDRvtWikamY=;
 b=B/M4UNc4fSxQP49tEtoAPUel7A+hP7sZ7+dMz9xm9rV4tSviOp5mKfQTJPPFSh+i7hK0t4nM7Hlsbb5B1to88WrP7ZzCH4QHo3Hu3AlsL9CNuc55yGHQ7fkFxCTL3N3u8DF2Qm6WVoZjQoe0aKPub2UvEukNEmMbcSuf3SJLpTcUeh+/7cPgFUJ8zKe8u+qeUj0aVKJgPTqQZc2XnNW1Br8byosS4RKtuFWWeWHgh1T3ZETmpPFcdxAKDNXocud/lYcbYywtLV4zRTQGqizuYOGYZyHcNFYEtbI3TE6JNWvoxMoifuY0Mej0zYqXo4w/VQ12ogK61Eq8tvZDspqJDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQWanWQ+k2ASyJMjwRo6J4JkJDm7zcWsuDRvtWikamY=;
 b=fKq6K7jjCeHLByH2b1hO7Z3vD+EkmDQV4ZtVK49jQvMtasiE1kDvb2AQa5TCpfhguJZ4c5cqZIEhUKNF8z8yRTUEFqHC/TcqKzcnRU1Z19rlDOojjCbcTjmKlBBtLzHHSMvOdKoOHxRgm9PyGLCy9nXdiIqJzO/YZKIVii1fVqc=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by PH0PR04MB7206.namprd04.prod.outlook.com (2603:10b6:510:1b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 08:27:33 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::e9d9:ae8:fb59:5f01]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::e9d9:ae8:fb59:5f01%4]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 08:27:32 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: do not zone finish data relocation block
 group
Thread-Topic: [PATCH] btrfs: zoned: do not zone finish data relocation block
 group
Thread-Index: AQHZqVt8Bkyrwzke6keGGu9HXmtXCK+fqdgAgAHKiIA=
Date:   Thu, 29 Jun 2023 08:27:32 +0000
Message-ID: <ucjwozqs7nlnjkwnesakilf6f22aplfefcvzaj6yylgqkb2mc5@62o3xpcjnyfw>
References: <be28a2d61abdee6846100406b4398ee67c0d2e53.1687913786.git.naohiro.aota@wdc.com>
 <ZJu/zlldO9zfsjj9@infradead.org>
In-Reply-To: <ZJu/zlldO9zfsjj9@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|PH0PR04MB7206:EE_
x-ms-office365-filtering-correlation-id: 62bb5cd7-b106-46e3-f515-08db787aaf83
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KSaV7NMECZIpJA/XhZEQMjvPsy5/7JDTFzZe1oQRBkLtQl++p+EnbEZQlqFb3M2Pjq1kwUEr54J2bGHCFPQ/iDSiWg6h80qCyxjH7xG6x693I2lDc7eHynJqfMZ9FUd8duUWcLtU3bxVatHWS4NMM4L4suGDOT6ZMFxK290mesV8gOCzC06C9BHcDXWSxPYfaMZsBdkYVy6xU5UVkxWHxGbGXsy1ni7E0koHIVrqrcli9oUnhq5uRKXq8mIub5+lMLjXGnR5W340Q4s1Gwh0LHDoZXmirlrJNnwN91tsLzK49Wapb9X2rbsiwZ+5Uw49e8ZoAE97s8+ds8C2gXcbNUo2lf0+/nzFRY/DVS5adY97nR/Pl4UHztISgDMIK71aRVCMOy6eVcA60CGz+YO3TxAeX0z+SsnDQ2yioEWsOR3Gk2pXCFAEe/1OJkKgN3eW2p4ePZ79rDrD71d0+PLF4/u0ve5IZfHSp+f/eCh7zCUVwoAURJ4dJAV4vwDLPiixyMU6kml9LSV8+9QJ6hvjMYXPvFQdfsgrR9lrO78V7aPBXxaLUvPI649gk7asNyeglNMOr4SgGCdfgPuk17P7YeVTDwjFds/ybW92foHymrRztNUaSEB3DitOxLJxaKHn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(6512007)(6486002)(478600001)(186003)(26005)(83380400001)(2906002)(6506007)(71200400001)(9686003)(4744005)(86362001)(41300700001)(33716001)(38100700002)(5660300002)(66946007)(122000001)(4326008)(66556008)(38070700005)(316002)(82960400001)(76116006)(8936002)(91956017)(66476007)(6916009)(64756008)(8676002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dWpwp4gvcH6+Wf+4IDrX5KbHDu35QqjHi4iyCEtHCRhd5/hqdinG7zDiyWhW?=
 =?us-ascii?Q?hx7plsjRP0HbCkLmcotHmfWrk7mS+Nnb1KBONVsji2+nqep0IDuyZnc9QU/5?=
 =?us-ascii?Q?DCusyCcFAxCpm0Q6kssS8Wtw6MU0g79CxDX41bdZCUA04yNGxLyyQNVXzx95?=
 =?us-ascii?Q?rkMQtqfbPM3HAV+ajFqUjsRTj9Y1+RKDk9XSz9in2xMe8Pzm6JCfe6kUFPgZ?=
 =?us-ascii?Q?Y3p+a2vtYs1u4WKK1gw2BRG80dGyzy18Xz4lrWaNn9jCveFGcY5oMdLvFqK1?=
 =?us-ascii?Q?ZTkjd3jehqTmvHGtpCFINPYVppPINYrxLAaugiVU5wr8e7DxAfkVTf1PyNIl?=
 =?us-ascii?Q?TqpVuZgDMGJ55nfkc6VFTye62Va/yKG0u2zEm+hWhZVTSUVostOFbjVAaNFl?=
 =?us-ascii?Q?0ROECTYbbF3m8YteUqktuHRtgaz6v8U5sOIEDvM7a7jtF4Su2os23Wy6yHF6?=
 =?us-ascii?Q?ZC9f1lAo84WhTwOXD1gQhc7IoFfRQHBFZ3xS+nS+kSb5C/6FTsVQV/DkhWPN?=
 =?us-ascii?Q?cj1OagsjhA9F+Z8U7O5P0RLB1+FXBEvyaLkdiI4YGl/sknOPpwl9jbxiWn9u?=
 =?us-ascii?Q?WtgSIzHD32z6H42ZjhYDebLw2dMBeSR70sXs73ic0BhqP9jGHZqxYXfxHAKC?=
 =?us-ascii?Q?NrXF3ZzzM4szm6wHJKUdQjnJbCUcJDmhO5r6p8QCqCpwK5nFr18Hs5XYD8/n?=
 =?us-ascii?Q?LzPSB1DnhBQ8LQWM9xLHNZvmdHEv9Vs0zvxOPeGHapyfrZKJ/WWgvtZp7tsd?=
 =?us-ascii?Q?zI+BLBycL7DtC2MD8RNkK+y/+8QQ4ycnnafCL1YrMWb1bTH3iIIhTB15ow5r?=
 =?us-ascii?Q?6PyA9eBvdgFNE2TrkXo2E5pV7rfCXgPdgsN2wVmguA6KgPqvfQVWV/u8z4k3?=
 =?us-ascii?Q?dJhtKo6wlymYokVrfzSHHc0VQAIcJOvLdjA4N5EO2aUSH1L08f01hr2MYjWS?=
 =?us-ascii?Q?m4aMADQ37DXbhVHYfVluRdYB3sE1Tq+KLvvz1M5DrQFqgHzQ/a0S4e/vZ0MR?=
 =?us-ascii?Q?PvO9WxmDHOhiAAPmx8/0L9HIoDz/c6t34FyrWVVy4wGFJ/xY6rZec1DJpHP7?=
 =?us-ascii?Q?g73DpASZXoP6WhIPQSA7xgP29XuXy/b3oZLgzAXb2dLHwZu2Fnagf2B573Ps?=
 =?us-ascii?Q?Pm4kMteC7Hz1liMtQJNjNZijzcVlp7D/w0aBa4AIQ8pg3nal/UCOUk8n3Qj7?=
 =?us-ascii?Q?lwYmBLF2N8sc229/1YcSZVc3WJ5oiX5G9RL67bgC9TkAlS9O7nB5sY99WY5M?=
 =?us-ascii?Q?NSMGzT86jHf3DTFhNWArwmiUICH1b2kNIlq0kaQS5+KClr9zMURnJ4IfCB6z?=
 =?us-ascii?Q?KoYNpUzVlJjCqfAcKVPmZ7nIf14o1li3xQdkUYQ+RrxSOkW+3dZpKrOAN2x6?=
 =?us-ascii?Q?NxzgFZCe3UlHOxlKk5V8D5KGhrv/a9uT4nDlB6QQQc2Jb77Bq5qawV5L4Csq?=
 =?us-ascii?Q?G0bCheRAzeBotZM/LGJf5mHw0a5Q/63fYTXm0EcyYZC2Nfzn3VtzUNTtxh5z?=
 =?us-ascii?Q?RMHPZcyx8UyEZsMdAdRcg5Q0rrUKz63wJlJmGgQtCtn4wzNM7xzI6JM72Iub?=
 =?us-ascii?Q?nBvAdp1en+oWK106VVu+v8n/YN/M+zOzBAgGBmt47YDYb9Bs2iWwJ4kq1m84?=
 =?us-ascii?Q?Mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DFFFF4B66C6CAA47B714931AD836DCBF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vVemCzqHwI1Gj642kv2MTMIIG7Rg+l6a4kw0i72+BVvbj6VPGKhq2a398ehaBke3Ps/X+t9DC8d+QRhNkU1WSdpE/2wBcU1k0S+hb40iYLUjtOm6dMioptS3inrU0ZcmJ7O3hTy0RgqzMMBAZnZi7XisxRtPbRYtJ870YkU3OgM/pRnKn/SqWDbzlskCmKpvfQ//Qo/YnZkyBpJ2W2eq4d3tI+JIo69OniUg+2rGxbbWcIEKYD0Uwm89V/sajpmPPnA/MihdcfPxPCTKQfwT3/KfO5vmdR2wajolOffkK+F+c9Lny4V4SVpuWDjcONhVEdSOfqUSgDPAvppZK8SxplktANBV+JsmkfPaUuEydTMF25o6R8qJj3e1JJNlCgamns22lgb5nRL6AH3jER+9EAal/kPf7opRkycGxBPcvFfXXnHrh/pCL7TFEsk+VopYkdP527E0d7gAH9h64l3kUFM6nSJfEx9Z1OgEtqaFTaAFXj4CHH+EYPf/XQDSj8wAHjYlVZR+0uh6/isEIhYa2+dBEcbaHUOgKwIN0BxIE2XPczujNQj/Jy9Mty706WZywrC2FzP6CgTdGDIH/fG1KCIOhz8Yp4gL/W6gfYuJjg2ckZxz73IX1RW7a1NSjrblMvo0LPc1jBVrHjAjpid9JgulV+dYtIsE7H5+m3PhdbNEB+pp/FONDrvdN+b0dhykR7bLSVmfuNlm7G5iUqZTpScjR3g5v/FIjrN7JhHtyWVOIQGwVwZdQtAZxvOIQisvwJu0FGnba2ktoUirnspPuh4pFdifUal0wWhnb3A1sPQ30FSOgX5wmeYp12L0g3KX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bb5cd7-b106-46e3-f515-08db787aaf83
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 08:27:32.8546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FMPGEGBivsV3c5Iot/LLcre31lZRXDpX8KU0rdRrXU0d75RPuVuANFRfAKXq/n6RMYN9E8vDcBRzH6CKD3bT3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7206
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 27, 2023 at 10:06:22PM -0700, Christoph Hellwig wrote:
> On Wed, Jun 28, 2023 at 09:57:00AM +0900, Naohiro Aota wrote:
> > If a block group dedicated to the data relocation is zone finished, the=
re
> > is a chance that finishing it before an ongoing write IO reaches the
> > device. As a result, the write IO fail.
>=20
> Why is that the case?  Isn't the zone finish only called when the
> last ordered_extent completes?
>=20

No. When there are multiple writers, we may need to sacrifice a currently
active block group to be zone finished for a new allocation. We choose a
block group with the least free space left.

We wait for the existing ordered extents to be finished. But, there is a
little chance the data relocation BG is finished before an ordered extent
is created.=
