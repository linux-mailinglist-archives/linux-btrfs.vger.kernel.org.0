Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465334E6EFC
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 08:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347483AbiCYHhd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 03:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344704AbiCYHhc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 03:37:32 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC6B4E3B1
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 00:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648193759; x=1679729759;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BdkaUrSMfc5uQ4gnvF9Si08b8jz41VaUCM6XiEpwyvs=;
  b=ItEnSIjSDaQxgCWhnBDiTKltPQg7QhB4ruz8/f4nBJbarfozpxlc9oh3
   B20VI6nzr16s3Dlzs798XOp1aqZ+S8P4HeaV7ya+Qbe5kOLGHbB6TG8Ed
   +nn/qpRMaGl74wZe0Wbf0uMHVQle9c8rcSHE2XUf74A2Zz8R2vl/aIOG9
   QLm7exkvZFGmDzZYZZsZ2iuXQwTqbRG6uSn6cWuExMeJsL4ooYtvtYTW3
   yDTzIj/qy12FtB35dQCtbSvkFkqT7775dY/4DonjqhWQ0YcQSaOYyeMKO
   TvPlLpc/mOkYT561hJgmF9HLFjAQRcJO602zN8ytXb5S3kEESDHVJTRdf
   A==;
X-IronPort-AV: E=Sophos;i="5.90,209,1643644800"; 
   d="scan'208";a="201094203"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2022 15:35:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyG/6bZgyr1UOHrjSa8W4TjS20g86JwV7l9DhqxQ45wCGPMlCCA6Ku+mSnFhov7MwjGW0W6KifwPoCqtcM04XpvaE30FuHdJabHVRc36YQr7d3RclncJqT5zy3rMnZMbbebFM/uep+JLvfdlFGhBi14ZBvdY7xC5FrdkThHEf2+Whx9ZLtxyq/aAvYLo7hNfyUCCqTGkaH78r7lj0GFZZ17iJQXQj12lXhuhnZ//77iaqvJBLg//MAz5MaA8yDw71KVNy9Tnm2dpC5dgxYtmhYnbcsisvMllte1nKkLotWSGZ54J7QKeYDCX0gT4w3PFyng3+bLGRBIRiQV5ROj3iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKqiHaYla6fK8Y8wNelDPNXXKgbWKPDO1qnNwdx8nvs=;
 b=io0CovKvtD58veQtcCBWxY1oNaILIoHpce1LR87hsKkKrKluEx/6rws/Y2bOzizsDrZywepTwBJn7oXDaolxdrJ7xRg5gShM8kgcHn9Lotj+49NMmKOw3DCjIIxU9whC6vLTcwl9gBoA4gJ8UAxYefrWQmJ0BW7RgTBkWBnVgF6RO9A4SZWIriI3FYqRcjrf2nZPZ7sDyIcYtpL4Ba5FTdQD2D6++QW4GXpxWAiBUPtKvecR++zpu78CWZlWqgXH6mSq/TAOZTslhaNKl9c66Hmf960rgBEasacn1J0NM/y80RDneNhTZl5p1are8OmIlSw66pJqJafGLPZHxqRh1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKqiHaYla6fK8Y8wNelDPNXXKgbWKPDO1qnNwdx8nvs=;
 b=IutAJERwsA7q3Oof3KBIdUiKXEjjTz6oG+O2ppArSicplsyuujva5ix9ZP3LNkFQB5hSQb3v4YaRpdPNrMeYrOtqxG8i/gM0RcHboZDvLpmSz4WbajUwKJW8dDSxgpeC2aoVA1CSZ+ux5Fw7NCGAxmEGsq4FnOTnSIf+6Uxd+gY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB7055.namprd04.prod.outlook.com (2603:10b6:208:1e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 07:35:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 07:35:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs zoned fixlets
Thread-Topic: btrfs zoned fixlets
Thread-Index: AQHYP5/1rzi6qY/5nU2idTZoXHQiyw==
Date:   Fri, 25 Mar 2022 07:35:57 +0000
Message-ID: <PH0PR04MB74167494E27155CC7667BF969B1A9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220324165210.1586851-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c06f1ffa-0c9e-40dd-6626-08da0e321a0f
x-ms-traffictypediagnostic: MN2PR04MB7055:EE_
x-microsoft-antispam-prvs: <MN2PR04MB7055FEE246F577806B59563F9B1A9@MN2PR04MB7055.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: itwFMrm4x0123Jux+Kais1fbyG0YA10fGGMq5umJuQmqY0b1O5PQyEFR1mdwYTkglKGjzRD1f9rfMHbOeRJ5XFMnBo8qxTWWQ+JhFFAtjMIqD3LTZkCpGg4/d1YO3NeC+wuXDU+2acZa05f66ZcciKx7lc5pw1P4M03HNSeft0N6Ow+7KS2cyyEyzV2MMzUNi/OJ8nLpZMq7NXUnFDaKItHn1AocVwM6f2Of3H3YfTJnI0LxBv4Khv1GIMr1Cv01OnGwfZ/X2xdBxYkV/R5IpLPG0uk7vp+pMwxuw9+xOnGiXvS5g98VrOxwZO1Blm9R3c0OBrie/Y+eoSRML8JgNVbcbB5Su5RrJtYWNSejHRvlY54mbkKZx92+Ji0X8zHUtadH87Vu0qBbyfwR7xjlZCZb5PDx8fu+JD/90zgAFsBTwcv5LLfO7ZlyaR1akXeFW3auUK+CAvHWCzkHT/lkIfyph5ApTNru7Z8ECtmaq5fOCXpJDtC2iOikWMKxhq5qPyRXDMEmrO/h9hUM9RNPMYDUObQhrPf6pWrT8gnX9JihkfQuc2eSdc0BcaGF6TTx1h5FxrwJMgr5VSlrjZq+mwg3T74CX47ZjNLr9aOcs05UeaNdIH3uoDlC4qo9DVgorKoMbfpj9HRyty54ih/DOigAy88ssMtiBQub6ZsgWLKNdTmhJ6/cULEJdDyW6WGQluoeebAZaFo6dC/LjBkjnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(4744005)(2906002)(71200400001)(7696005)(7116003)(53546011)(26005)(186003)(33656002)(83380400001)(9686003)(86362001)(82960400001)(38070700005)(122000001)(38100700002)(55016003)(3480700007)(5660300002)(4326008)(66476007)(66556008)(66946007)(8936002)(8676002)(76116006)(66446008)(110136005)(52536014)(6636002)(316002)(508600001)(91956017)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Njyp6lmybMGEkACsEbSsyWzB44OoO1TU2MuVjBkc2mjUiP2yCBHvmwdKwocV?=
 =?us-ascii?Q?fRYl12jsOfBbk/F88AlDCmSz+ZHNT8mttFdgFd/qvZ7L06ydnsX1GNnVIrql?=
 =?us-ascii?Q?F9Q4I1Q7z8ix0oOBROTjVvADS0U9Cik81kpbGUT+Eosyw06YteanXpYIjMh9?=
 =?us-ascii?Q?OrTzW+dPkprIyZIQ+CzxS2IeHfeycFIE9QE90tdhKD/Mk+TeRd5Hv0jyLDYN?=
 =?us-ascii?Q?MQ9trF3GkA0f4c6qVJes195VBLSvKTKo019eC+9tk5ajfkptDb/UOonNtgap?=
 =?us-ascii?Q?LT6VHDoAfc9o3yrDHEjkfScAYuJDvYOFXeSrI8drh+lbNW4L004aZLbbra8v?=
 =?us-ascii?Q?h0QHjGlP235PUMROmOlROZfvsWWGHLRLvD69DpFDGe4BIgFapgmi0DpI/EYP?=
 =?us-ascii?Q?vpuYOcVZniZerUa9kN1mablGPW56RU2s04YGb04rC2kDk2ZsteNgSdiPR/yr?=
 =?us-ascii?Q?flhzIEoMGtUbAmjacokoaxL3sdIwZOyEbfV0Qpt1DeKCvWWqQt8unr41EINH?=
 =?us-ascii?Q?qjPQRVasWjcBv++M/0RDGyRM4T6MRjOt5xsEe3CNwMHfY0iAqLYc073o07ea?=
 =?us-ascii?Q?/WGT+w8PL3iWyCNYm8qNYmpIArV6pg4e5Jwlt++xXsMIawlc/TogepAZPdxi?=
 =?us-ascii?Q?ZWLeaz5gAGyg6Hy/2d65mS33apaxMVCUhl5rxbWfd4QzgC8iT985h+i1H2PW?=
 =?us-ascii?Q?hbbXkVavuV1zClof04tLn+ujBmG2Zdd3j8HUYellxyTLTuVxgzSJIfyXq7nh?=
 =?us-ascii?Q?Vyt0MZ0f6Hk6wghhwIZP7DKLLE/O9EvOnzPClcOAfjxQxRnKWbHYt4+53mdJ?=
 =?us-ascii?Q?V0LaREVGHZDABcK9KwslapbSzYqrA9WA2WSc+nQxAQBh8VxKqQm8GW0Bwznv?=
 =?us-ascii?Q?lYKn0SVsLRzV/JLrk5mIpa3/jWIeGTaGY+nGv/og+cO1rSALD8wugVFUhjO7?=
 =?us-ascii?Q?xG5KD6OJSBoLbD/2QHOESc3nflHprz4+YsqL9vbRNjuyF9CEHUh/+zbLLujU?=
 =?us-ascii?Q?Q9CJLcgWyuJhV62uauOrtNMbGbwP84oVcKunJmnaWXkGc6m226gNBWiaozvX?=
 =?us-ascii?Q?pohcscDGP3///zd4lF8AEIpna3zp0mX+hedTnuT60ZWFtH4D8q+2vsYoJrOE?=
 =?us-ascii?Q?Qp0r2lPS6mq7cOoRxI3oyuEtpEbqP26QOPVCO/hxvCGz374+yl7nia7DW428?=
 =?us-ascii?Q?LLr8sulvoscrwD2EvKjaQYW5oLxe3Pi+piF8tgdj0anvxP1laHkoj4yOuASk?=
 =?us-ascii?Q?kum6tnnS4WokBD0Ry97vqhYALl0JOfcSZDfU+VPsCK5Zg3eGFGJDmw5BQthk?=
 =?us-ascii?Q?TDQM/zQZLsruKfYjKAZBAblCDqkxjlgqzwYk46aGTO/L0rNGHCuXZjfT9Oz8?=
 =?us-ascii?Q?HepcjQsWQ9PFKYNEUM0OfSL7/Vr55vzWBgUm+O/tc+XJ/yWTYQWOyeMidrHl?=
 =?us-ascii?Q?MhdJ4Z3x8DzVmyFSGR/3nO+7LUZJBGaey6bEhOSf9eALEMyaah+dm/hWtmGM?=
 =?us-ascii?Q?MiX9t0u96OvdSPs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c06f1ffa-0c9e-40dd-6626-08da0e321a0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 07:35:57.3467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1QGkorWf44HpcbBwy+rJgVXR0krYpiAhEyD3/BB7O6b7U9mFn63r9p6obCN2EknXzGj1sXC2HGRKsyYFuugckWwem6yZzdBSiborSjtFSdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7055
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/03/2022 17:55, Christoph Hellwig wrote:=0A=
> Hi all,=0A=
> =0A=
> this series fixes a minor and slightly less minor problem in the btrfs=0A=
> zoned device code.  Note that for the second patch the comment might=0A=
> not be correct any more - AFAICS 5.18 added support for the dup=0A=
> profile for zoned devices, which means we do have a real issue now=0A=
> if different devices have different hardware limitations.=0A=
=0A=
It's not a problem, as a) DUP is not spanning multiple devices, but=0A=
only used on one device and b) DUP is (as of now) only used on meta-data=0A=
which can't use zone append.=0A=
=0A=
