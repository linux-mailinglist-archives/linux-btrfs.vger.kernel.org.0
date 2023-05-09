Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469866FBBDC
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 02:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbjEIALq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 20:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjEIALp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 20:11:45 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D3249E4
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 17:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683591104; x=1715127104;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4rCdw8Pckv+LcYXcZIXZL7w4w9qF7aL1ZFgjlfzOkRo=;
  b=P4s1nE6Exzw8jDNBItEUI9rRcdPzZfe15OSKagrCp8wFsFLIlNt98CBH
   GKUHmWWuC88pq0c9vPOIN3ewfSZjFRznq4osO3wVII/oRYv8FKS7oy+Jt
   ha+bpDNFjOm2uV6r4JrBBqQAz7NY4MgYkLdEpf99f3gO4Tp0cXEKZ2bLf
   uiSpKgrGH93QgK2D4vTpkyKLS+a4ifZJNhiYSf5DnGzAx4D5CZhzjRujc
   Yc1V7qUKfwi9zvLPQcDVKySGhwwKl6Sx0A/AfVP180cJqGLhk/lGHjU6D
   Tjkf7GDka3XkpTSZTt+0jVfM53m4QlZfElsbEyXbIIj44EAGXdjsZevLD
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,259,1677513600"; 
   d="scan'208";a="235158774"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 08:11:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRtqNZipOcSes6lM4ApdQHrCjfAZyPj9uVmU60ZgIcW0H398VHA7nMdfLh2qOu0mLPnZGvTGH/DfvNRonpXGQA9r36AjieWnBH7Emid5WFblK+GSU0AOD8bGomgCF0eSBRZCazdKu4GPF89YiP+AZh17ovcFwZox9tFHEkmZ6wAy/L3TLeQWpWbSWAYKopE/hyQxb4Vtp/1rGg5iNziU4A+BSBQLEwG+fpOU/LCYShlDIEZAokVmMEbPlqtTFy9TgShj9WwPcfi75a+7wBRkaoaX1P4h+GgiBh5xsV21xYW8sHD0rTTltpKErcBXSk/sc3+rl3JUNLVfZGXzjTS+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWeQf9l27LncFPQiJpLl+JtRT7e6Buwp3SiCxqjyHrk=;
 b=R14IstYzXpKVfs7aQojT2zBTjl8OqEI6G7IVdSYZrX2pJvj/xHbtKDqJ/jCTLNmPjk3O+Fkj0mkAJtgBjXSE6qvMOun/NBVVyMvAdt3alxSqFgmxFPlXtTCfN4t8ULHrrNCbOlPYUZiDimnsE1ioYcf4kcsP3sCof2vhDchJkUdAQBDDIm+179TxDWNgjI/7f09r+OBnRlp+ejIBMcnZo4L4Y8R/jPA10O1GQ7rh2eRXLfr4F703kZ+5lp+7AND+G/R/cD3xXjqLOGwXad4G6A2U7CzNoUDCPhKbwiYQmnv7kr15F6ZTAQNyjcx3HtMF5GXdk/haUfky8/RdZ0SlwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWeQf9l27LncFPQiJpLl+JtRT7e6Buwp3SiCxqjyHrk=;
 b=cCEA7sHH0qVMcaGGrICxRgWhjCRJilkzgZbNaT5Drjn2tXnUp2QzWYvEBldEei11nPH9/ExeTMFWchLkrkFsRi1uHj+8BbUaQbrh0kEK7BkL47s//mjvOMLFsMECOWNtiiijnOPTE/mq5FDsGuWoq/2MlyHd0Z6/frjB3Uni8V0=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7326.namprd04.prod.outlook.com (2603:10b6:a03:293::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 00:11:41 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::b52e:3dc8:52f:b0cd]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::b52e:3dc8:52f:b0cd%7]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 00:11:41 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 08/21] btrfs: return the new ordered_extent from
 btrfs_split_ordered_extent
Thread-Topic: [PATCH 08/21] btrfs: return the new ordered_extent from
 btrfs_split_ordered_extent
Thread-Index: AQHZgcdxCw6p4FUFE0O/Yxn13Z+/fa9REhgA
Date:   Tue, 9 May 2023 00:11:41 +0000
Message-ID: <kcocbxnziztad2fxg6tnwioknxrvjn22tfj6x6pd63knmx2byd@v7hp6ij5nxei>
References: <20230508160843.133013-1-hch@lst.de>
 <20230508160843.133013-9-hch@lst.de>
In-Reply-To: <20230508160843.133013-9-hch@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ0PR04MB7326:EE_
x-ms-office365-filtering-correlation-id: aa019538-54f7-4329-bcbb-08db5021f708
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SD+vzOR2wj/0tMzRPkfIyBwLtfWOE6f0pn4q21goKOEWaOrjW2xXTv31kqOxF8iOdFhlFWllpBeiWU8TdtjXmD1EOdJdRQI898du/Ud+D3x7wj5SkH76Wx4RIPlA/GZwOvuhTi1cnXNye5uTlslaGltMDM+W7o6mm6PbzNEnza44x25Kjsg+JN6BlIaSHgnc45cJMJMPq2sWLKZnDSW3yOYcUJYJgc5MN46Ttz9S2KqPZvdlNA8Gdmf3gS72EeiIkEDhzVb0o6Asw7HFpB/kFQ4WZtFWZQZuZ/2wSsu6k/XcsVvoMGn+KNYw7f1l6UbMROY3Cvfi4SkNddFgg4rIBrGtc3AGJaznLmkbSn6awwnBRRreeF/QD6XIBIxl2qduaMGdsjYz1PkgsvrjncAYUU6lJO1PqSSg3XJvTEYkK0Kq0h3mumzt0aTwLxSwNb0cslnz70qRYPT7ACZiY5045btsEQuknIN9130Me9Dmht2n46s3PBhUV1mSSQKJRRwvmX9orATFq3qxgmJAkO9DSMrYpW7uN+B0atnZ38dWocBN81f444dLx0TZvGSyYz2Ty7ElhuHRqy/lk+l6pG/7xodzcAZoSd7UiMvZDm1Vssx2xkhcBd/+ltwD7O3v62Px
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199021)(2906002)(316002)(54906003)(478600001)(41300700001)(8936002)(8676002)(71200400001)(66476007)(4326008)(5660300002)(64756008)(66556008)(66946007)(66446008)(6916009)(91956017)(76116006)(6486002)(6512007)(9686003)(6506007)(26005)(82960400001)(186003)(83380400001)(38070700005)(558084003)(38100700002)(33716001)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lfZGV/3haq3rcPHt+6iMMI/InMSE7q/Nq/EDxNos85kkL+Z3OCdnlKFX+B0A?=
 =?us-ascii?Q?CzdtYnxXr06CKaVZPUdyl7fCJJenOs3SY3l+t+yd2xIEdqaFvQtysC2E/n/o?=
 =?us-ascii?Q?V1ZfFyj+IJc+nTTwasQED73o44ODgPecGX28He20PXLUlb5apADMLWFOPlie?=
 =?us-ascii?Q?1rgxyldRSGk18dFejYJhEEwP+ab6JiwSQbYwUmC18dJCepL7tUYDOTCm6C8k?=
 =?us-ascii?Q?Ms1RG1JP+JiN8NSBigD4cpnxxF5CK83qWGLDcS0KqzAAl1txeVDZXI9w0lef?=
 =?us-ascii?Q?yz8OB6gcRd7V6Ed6T7MpogAEh50mCF1VGI6b2o2FKoFPDiYZQ5FaO50f6Fb3?=
 =?us-ascii?Q?As+HatamaPjPJTlLAYsrRqnvX8WLCKWXMmhDtT+/+bXVMevt9S2ibwepRGlq?=
 =?us-ascii?Q?qGUUOrwS0Iyr1LkFrdXKn6yf2bLFQy+vyBNY5wlytEtXSPDGP6QlrCIGFA6A?=
 =?us-ascii?Q?yja0G++j9LYbBFn7bGd+zTHyzNXJP6A66J9aPct2FqV+RRmarEzlZk3ig8Oq?=
 =?us-ascii?Q?Jz1ReangQu23vnr9Zp5xUn+5cubx6M0BpHipdl4g1A6W4nNvdpv3vt0VTk7W?=
 =?us-ascii?Q?J+xmw+DKk49t9d8YporfQPgkXyZ9zL9jiDtsbCTfPKtAAxVjiFJzKXRFfoeH?=
 =?us-ascii?Q?IQBbnj5ObYOect4ycuLM84ciWswWIZ2Kzcie+PWg6tTRhjyaCx+2Ko6Eypxa?=
 =?us-ascii?Q?o3EtPFTwmR5v8wK1k1OWoNp8JVwQvLyDAcM9eC0L0TnPD2rI6Sh9Ds1HSV8F?=
 =?us-ascii?Q?OQT6KLc7yLxoyJ+DZnix8seZ1EwcuzW/24UcIPsxsSIM07ntunDVSlhwV0Ly?=
 =?us-ascii?Q?ECmbL4OP03/OukAemcX95MdHK4TskYublrw7FRMmiRu8MGgIfV/rSdb9M2KI?=
 =?us-ascii?Q?7x0OuJg64LeovFdEyrqZlCNKfdCjgA66Y1Mqf6+tTTR/X+GuvQlTzYnCBogj?=
 =?us-ascii?Q?yLjrt3dUHUuCBFxVhLuBFEgd5BFvPuyI3cmxFm01GIINtqRIn09eKnhmtmh5?=
 =?us-ascii?Q?ql+CshCKEGpqRgqxIdsSI8v3Lcso0rmf5W7eICBvVLWwRzzxrCt86mQcYSgY?=
 =?us-ascii?Q?AHZ8PcQoBMCTZb5MHub8k/G+b3ZwJhWi3tQQ//5yYOXmeM1EgsPzuUPHOEBv?=
 =?us-ascii?Q?EeOAUkYVw8/qL2Rg6W9YFOmE3VWNItGIjlbsBl0z2bE5/wu3Xyz46Cru+ueP?=
 =?us-ascii?Q?r8Pa13Hh0av2jU0e8SvkyYILkPTjCNUsftML2qzy9ZRP+rJEfFKfRbcDq8IR?=
 =?us-ascii?Q?No7PVmjiuGCAwAygL4QQ2BogKa9HxMvmFsb8aLTFrLp2EePpYSF47bGwwJj0?=
 =?us-ascii?Q?z7Qj+fEs9ga7xLxMRgbvzdolw45vXQmqkmZtjtgMxKq2fwWrA/wS2zr6DtLJ?=
 =?us-ascii?Q?ObXXsDTGTefehdpM4mVogB+jFC6bseC/6X2ivQTZXnOh40CSDjKeI29sbcRr?=
 =?us-ascii?Q?RpHVWGyheFfp6Zzas7B13x0kJa74tssa93fPkPsKK+wwSfbw00ZfKQMBJMPC?=
 =?us-ascii?Q?JNKbr4gD7T89N1WR/aJQkaYfUDgtldU2auQMlaiLOsNYf5ojyTtNy+uB7tUp?=
 =?us-ascii?Q?8mhGH1bm0FbOibpXKnQIB0883WiFPoFxdEKoJcEe?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FCF4C6B947EC0F43BF9EB47098FC0AC0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: o8N+qKN0YVjoNIPlkG3fHGdEARQlCuZQH9DaJbXSPstJp97kZCd1I9jRTSSmyHCUsD5aDmB+KQWBrH/3+S9lR+Y+62QK2XiU3t1gfzXZX78ARprhjYh/ZlHlLkDpB7xzDUyM5waQcKEiZdVe+No+SvV9bU+D02A/B4lEWB1bgMDNbUmSMxKk0Pnf3jHhV/RoiqVboyGdld4pOnSh39akJQiYLz5rPml9obZOYA1bjS/9k7UxCQ6s2nQ2+TRrprww41C6WuLfSyr9UUJAQnLWecjRloTEv5xBchEKbXbdwylm+aU0DLE9Hl9iOnwupQZrIeIlpbxyBBPbDkY0AocoUmraS+6S72zH6TLQOi0oNXRrJoVRSR3aA5ygimuOe7F1hYAQlcoU8qlPzMPyhAffGJJqUakZUNff6OOOPpEq6qKyKX17lR4u2bUEHW6hEky+94azIUvfI9Nbx72rJGAMh5lXhv40D6MGqajnM2YOjlmXjJGOdERHkWnQB/EdbKkp6c/mRLxtbqAN8f8fldMb+lbQuLp7N0ZwYSmCK0b4lgwD0nK2lynbquouY+SKMeHFKKGawrctDLzjmoFRx2JydLonALQcAlzV8DUV5/x8HSOl4mdKXJKbHMdirsSMPsI5HB/hWlir+5Ino7V7sfnZIUiUH7+gRtgina3PosXf8QNuomeYiAwDtt+4E4qIVyGrF7aeGGzwwNzsOktlcjYpPhEyGBu6OsdLOFZiryOITjz7b5m/Gdy+K6g29xAWraCagluOjA+I7bhP8qjNQCMgUs1coL5jUdeUjOjCsngGdtv6VBBOwFHam4ggKZrkmpyQKvSFJ57fCbwRQ1tmNObnlykmguKAYjOLmLofD1sBt1fc3T8Ix4VGZOiZB5oJ0+r4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa019538-54f7-4329-bcbb-08db5021f708
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 00:11:41.1151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lHp9P7M8ICMuZFvU5lM4DUrzjIVbxUEN/zB/dVC3LOPi/ibo8GKD1uHfYUEhrQPeHbwXWo2ywOwVHseuxCNqJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7326
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 08, 2023 at 09:08:30AM -0700, Christoph Hellwig wrote:
> Return the ordered_extent split from the passed in one.  This will be
> needed to be able to store an ordered_extent in the btrfs_bio.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=
