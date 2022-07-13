Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B25572E63
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 08:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiGMGrX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 02:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbiGMGrW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 02:47:22 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F020DF3BD
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 23:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657694841; x=1689230841;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=MBnHZtqVV8NbO5pl31UGHfYPWx0cTeBTxnv+y253thY=;
  b=CLPcXqwx4JtbxjHJvOCAQ8Fvarh5gaA6Rsgf41sBygetNZ1QyXL/5n+l
   uc327HpXm9C+thp7AlbBpIkR7jKpq43nztsFHMnjS4jTOP12j7BBI+czW
   uPPzdPUXdCl/e3JbOICAY8sc+9HFfkjLs6ZHFArSVEQpK3TmtsJJZLwQS
   F4CRM8CXMLrD0IajiTgYgaFYYIjpORw+9Eh+8B0B8aywhDBQaVs/grzqW
   JeKddFSORlmDdqcxRdZHR/SLLuCKtDhnYbGwjuXhkOfD8ynKihBwAWb7I
   YFiw74MlT84As+nd4+vOkMuchcSPB0oSFN8w7sRQ0TfARr5u1lAnYySk8
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650902400"; 
   d="scan'208";a="206267443"
Received: from mail-mw2nam04lp2176.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.176])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2022 14:47:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pths6FrFB/S4TJe5Wszy46coMmYSPK/DfjtACt+eUR4+wIUptAHnvrumMX0vqF3nVq+a82upiEiJoXSc0ggwSxdZY/TghNPvjOFF+T7rgToDcljqVFXJC7US4jLwOsdEx7iOvn4wOzkJgMyYGvanjldU63nWncQehvvVszBgETGR89xlWirYP0+J/XdBWNNejeAaHOdl9NckDLB7R3N9iddpseI9wiWFwW7bMBsr+UQzpRYhiat+Sbfob9chr3sQr5Qt/SECtTxlHr2ZHnCOViZkGsvunSlwh5UeRwRpR20v32AVXpV8/GrTveZriHEdKoDD2OOhsrVXoAmiuBQ4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3Tsp8mZahnN7G6qIqemV4ic6E4r5tTBXXwMTjPO6Ss=;
 b=iFKktvdFedJjPgC/yA/9gYWWfiiWPsVD3kBg0uH0AOBaxe2R+JDzbfy7YtPhKvjXmDkv1onVjETZyVC6Imm43ghE4czIetByvLLqx/RQf+k/M1+Us30aLR0ykDEB004RKygUcDRlDc2QumL+j/WDKW1wsoVTyHOOqoApJySqHSqDgXdCbUeeJ2OQONDuUbh4+S2MzqslPAarpijeC639I3E3aRmXpEvH+jsPoymOr4G3kRSTh1x9JKv1Og5xhSH65YMz6QrDGApbXtZKPLWwjpHaNNctMaxOTh6Da15bc+iIouK8+/U/UuD2pr+H6RNrt2GzNdRjaGEYQKwv9JmSzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3Tsp8mZahnN7G6qIqemV4ic6E4r5tTBXXwMTjPO6Ss=;
 b=ddxcT8jqLdTsYIzAPDtrRfj4JyPOuJXB9Cv/Um0h3Lir3aXQSmSiAGWhsL7sxmRMRCkHAcy4FdAqx8cbJo19gwkPCLW7YZfkXMP9pG5z/jvvQqvM4u0S7y34a1tEetRLqc6PGngpI++9dOyX6f9aLg2nTJpQwFmsFkg1JLN13RY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB3893.namprd04.prod.outlook.com (2603:10b6:a02:ad::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Wed, 13 Jul
 2022 06:47:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 06:47:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 07/11] btrfs: give struct btrfs_bio a real end_io handler
Thread-Topic: [PATCH 07/11] btrfs: give struct btrfs_bio a real end_io handler
Thread-Index: AQHYln/OJr5jvbHuy0un9kkr+YdldQ==
Date:   Wed, 13 Jul 2022 06:47:18 +0000
Message-ID: <PH0PR04MB741607BE824ED888120C58B19B899@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220713061359.1980118-1-hch@lst.de>
 <20220713061359.1980118-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d500169-f4a4-42ba-d61e-08da649b8782
x-ms-traffictypediagnostic: BYAPR04MB3893:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HYe2nVuFmFhMSACm5ZzJx0XHDE/aiQk2WG0ahcddDrfcsxB8PtZnzNq93olTU5982EF/qzR3kqOrITQHAFGvIlvZ48VNchUmZzUrq+y3cJAtf9PvBHkJwIBj0N/vCkV10qnH63rYjo8d+u4CxPeoIKMCH152NjZWvtEpJBhN1aExksF6mJ4GSkG4w/l5nxhvYBmVWWVX0x3NrfHlPLV4xI5OUzrmyu5aKHrhUEmeUKghkvueNzZbQ+BGbghE9rhWs0X4Oi1+tAtal776DIFsBzgSgzX/sAVsen3RCfHos2fZZYuQVbHM84l23H3qDe2RIjjGkbHvPzo0lbrKHMXiH6fdsk2w1A2whmHnuZWkI9Ph/kHnSqHTHSRyFhsORY9fhezbDV4I7SaSSsbZtW6KJ8lGsFSt2cYZ7bVJ0VKiY/w5y0ULfwNs398xHoUNpv2OefCU/WXjGJgThZ6U5GJI4XYgDtSqXeb87PbZ2wiq+ipmGFJM4HWNNd/8VjK7MC5HRuL30PpjgfkuNuH+a2yN/txqSgT/nXuvQLHmJjkObFREoWsDQiWBCweWA2ex5wcQvzRh388cwMvP025HbpVx/Okb0VGfunhN2sZzVBD/dV6MpyOb3CmaOIsq0mJg6BhLVoyPkcQRAPSy9ArAxS03PUqSPdqj/kqvXYGlF8hLGu8Zxm/7HJIivfIbIh2h1k3/Ozbgr1ySjd/8vylpASc9zbDC8kV8No3ipCRzY9k/3OHmNGtCNcMqNTiyn9acJWMHgKLcWv/H8eTM8kS9jNRq1Aq+kA+GI3QnXfS9Qh39Jz5EnauoaXXgJKUWF0Ui5zVk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(186003)(316002)(478600001)(6506007)(38070700005)(110136005)(7696005)(2906002)(83380400001)(66476007)(8676002)(4744005)(76116006)(66446008)(54906003)(66556008)(41300700001)(4326008)(66946007)(64756008)(55016003)(53546011)(33656002)(82960400001)(5660300002)(8936002)(91956017)(71200400001)(86362001)(26005)(9686003)(122000001)(38100700002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6ZU283rj0zE5n9hvNyq5ZgVH6LY/vS8fevRue03TTjtsSo70uOra2GU1QBiB?=
 =?us-ascii?Q?ZEM6P1Br6DTqY+lbOSZvpfC1sMSH5u2CWtlNYhjUYsCpyJuUGZyiaMivwqUi?=
 =?us-ascii?Q?A3iFifZrj/7T0+jU99WXz3UpA5P70P7uFcz4DPNymXc5iW7/pm7i1Txw6TQx?=
 =?us-ascii?Q?8bl0Ag8O/CGt8Wg5FjDHbRhsFX3wmH53qXgypLE72gaR/S4QNSPHolqra2Bp?=
 =?us-ascii?Q?/yaQGJcDHrYQPjFE5YisdLT6zLeCWKsn7M5kx4eDCeenOdekpFgJp/zf5rGH?=
 =?us-ascii?Q?gSIP/TCcHWU5PQ8YgYJEYMvVlzKvdvZJFZqmzZrulU8yXMvOzZdXr+N9Ee0J?=
 =?us-ascii?Q?ri1/Wa0ishgeFKXOqQ7sEfeBnsaUlwEPX3XTXJwPDG4JpYobuTzevz9VqN72?=
 =?us-ascii?Q?ISthOoeJSqzWMy8SeOEiXoNvHfxO5w1aZdi0bEs6Y8mvT6SC3kdHc6WtgorP?=
 =?us-ascii?Q?BydKpHxh1pfTaCj4csK8u2izprAn6jtjamnFO15kbfoK0XrFx02TD1HdfgOy?=
 =?us-ascii?Q?tq+cfO8aY/Jtd7h4inQbWCR7aey2Cx3v8+ZTSESIXmIlABYQHOaiVHcjW6X8?=
 =?us-ascii?Q?6TaQ4EOH+fAFsbQtfFZcDeOpCnLf8EyDGjdX1ZqC64W4jGamRMAYbHZjf/Xr?=
 =?us-ascii?Q?vS4u3a49yKPTbMWJhQ3j+WhK02BcC8UQcuSjwy6KSMvDeSivX0mWd5p0SGac?=
 =?us-ascii?Q?dadOgqoC1D2hJlMDFI3YBteyIYKLSVe0+DRqfWtDjqz2b0ynWH2mw5sENm9l?=
 =?us-ascii?Q?NEoIpPJkHzz/FWOK3vcj6WAMdMjT4o1YzLqo0GR8QDgJrgW/NryGbJwTnBQo?=
 =?us-ascii?Q?h5tqy1uki8yq1kdSqYNRMIORT+HRqEvLi11U1zu+hphJbJOB/2/iejYVt+oo?=
 =?us-ascii?Q?D2q8MMZTNCCnz6IkwH+MlzLzMPu1XJe9vKBRCbB15uoEKbDadM83HKL3eQn3?=
 =?us-ascii?Q?rOfNVAlAF7sKzfzdmj4d+m5zLqZn9aWvp1dW5rSb2r1pnJ/TMBp2UrCZ83D6?=
 =?us-ascii?Q?opHhMkCGPpBQwARBpmu+r+rcFm1/plf1PqvlRwTFD8T7WBDIrbZrvKolYUhj?=
 =?us-ascii?Q?WO9Dh3Y93K1UDRQKhjM6zh4Ktskl4uH8HkrCsIcUes8X4+6T/Hd08VZ9R9kj?=
 =?us-ascii?Q?CSByMj/1EvyGH880xnsNjkDRVi5yWzGm3/xXKFnQV6hZCFWvf0aqmLSpwx42?=
 =?us-ascii?Q?Y5lPzsnKCFpXGTBf1y+Cn3Vpp3R+jwPonz8Njp4x0RKtXRzVMJIx2W3dBUfD?=
 =?us-ascii?Q?DRpQQHRAhBr9VyE5Uk3EsoXVRPOnI79VKIB7xMLteUsRFBUYH39qfKHy7A5X?=
 =?us-ascii?Q?0YQRwxlJiEG52WuTC/Ii3yq9GZwUBtpNvZX+WJRVdATbXzlAM5Nvzs6gDHJ7?=
 =?us-ascii?Q?/EIFcZ/ooxA5H7JTPWCkL7iQq+tnALprVcptCdJ6zcHTQy2R9FL9BkPX7olT?=
 =?us-ascii?Q?rnHArDmcz2IFlvix6meI87h/ZfEIzbVoyJSUumFewAo0MaGi8FL2DXZf+443?=
 =?us-ascii?Q?6+ix78vFzM4VzzDGTtnu1z+T+keLiI/TqJp58FT9Uk8H8f6x1gnHBp7mJ3oy?=
 =?us-ascii?Q?Mza/E3nWDiu99QP5W34FSdB5C2QEYm6G/uk2ASIEjVr0cli+uOplVEdA2Fn9?=
 =?us-ascii?Q?ft7YR3SpHAv5rU96BN4HKms=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d500169-f4a4-42ba-d61e-08da649b8782
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 06:47:18.1928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H4JW4xq3IrBUGl7lzdVw06jHMA+q1f433pXmRptn/3wUv2onelRuw5OJf1+uR2IxcUSU1qfQEEUl868defdO8qeG1ctT0ZhFTj76SfiJd8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3893
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13.07.22 08:14, Christoph Hellwig wrote:=0A=
> Currently btrfs_bio end I/O handling is a bit of a mess.  The bi_end_io=
=0A=
> handler and bi_private pointer of the embedded struct bio are both used=
=0A=
> to handle the completion of the high-level btrfs_bio and for the I/O=0A=
> completion for the low-level device that the embedded bio ends up being=
=0A=
> sent to.  To support this bi_end_io and bi_private are saved into the=0A=
> btrfs_io_context structure and then restored after the bio sent to the=0A=
> underlying device has completed the actual I/O.=0A=
> =0A=
> Untangle this by adding an end I/O handler and private data to struct=0A=
> btrfs_bio for the highlevel btrfs_bio based completions, and leave the=0A=
> actual bio bi_end_io handler and bi_private pointer entirely to the=0A=
> low-level device I/O.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>=0A=
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> Tested-by: Nikolay Borisov <nborisov@suse.com>=0A=
> Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
=0A=
JFYI this one doesn't apply cleanly on today's misc-next.=0A=
