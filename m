Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2724D046D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 17:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbiCGQqL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 11:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244304AbiCGQqK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 11:46:10 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68A992D09
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 08:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646671514; x=1678207514;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RcoTcptuFGq1qglzN02XfEdyZQDGXL+iLZQfks1ywMg=;
  b=eANd4gJIFBXI616DE5otMPqvoHJTllImJ6Ud5g/awlM7jKrFuDLx6+Wv
   OtCHKDl5nvprP58tTQTcU2Rw61nP93/FQp+ry2/xkjUCUpoNPNAiekvCP
   CSdiqiUjA0bP5J8gXPYWF3DvfOvsWvtGFa7Ar/TDxjOa5Mpum/IDiaSPD
   Wecfu7eNQFmzJP3YALng9DDdUMUK6P6nR01uOD4O+Aw8LMlhecuryiji3
   KSGDRoBAwZ7FUa+1hdRp6vTBzUQknuezS4As002uZhpUzmMni5mhHDaQk
   5MdK/S9HIx0bIyacPr7m1p42ftV4AhpTy/KrlHy1AvNaFoMjj0R43d/AJ
   g==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643644800"; 
   d="scan'208";a="199524757"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2022 00:45:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdZkdgZVOspnbs7HI+/kOafZsYgkNxuGv6N0gCEy44eIK4qOs8mfXIQgljoy2fFyBBd8uS7Wj6Jn85ZgI4Kt42aPCzB+KOIoWxhY3DLWPQnAeBECY5bKvBc26fIi6X0Me/IAIiV+YoTvakUAmgGAidMyL3eE1W7+bqCE426nh0n1NIRBvNsN1RAZrsya9X6v73CmhsK2yvvI+3snjt+0sDn4aE5KfmGHZ5cBOxbZYwJs1NBBO90lazSKzMSLSibUgVIGlAm7XUIRzehDuR3tN/4norYn9jVPt6m4FICjom9Wytwmp8Z17U7A6E+nQB//5B5a27a39gz+LLLHzBcd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0QCfHC5Ve1z+3sqdqnsObkgFIiQgkzqacMZrpeJOy4=;
 b=kQBwL5vDdrump0g7w6w+pWvP2bTZeOxQZ2+yMYMu5y7gfkdQ8wZU6lji3NBB0q+MlCQ/+xw51yERnScIp761JGmhXQP5pU/j/z4xeOwrjOWmVfNxUYEbu0B22dPbHOBnQOHqQinMWVbCcZcgIGPOZ7WdJouTX/F2LO2hwY3OYgshcBvGS8ZJUJH+WLEfa4KQSKSw4OhtmaTmO8+SYo5OoMKKa3tJrlrMkPu5KoeNLQmQAsJ7Nct4yCy8uZq7J/FVQyfk5VSbiXbML77pM4xP+CsrTPi9j3/nmZHXdDgYahPEob6Kzg3Ju2Vmk+g+s56d0QJImVICPJ4EyMYYzd7Biw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0QCfHC5Ve1z+3sqdqnsObkgFIiQgkzqacMZrpeJOy4=;
 b=ZGh0CjwBofsiWJ4tUpu7rQBs3gbvR4utj9+fbto3mI8fIZ0bAvxOpeKWQcgIfAHTQGD55i8rp8jXLs4oDdu+ywU+bqzfL/2tbshsONmnLEBmATbhJ6A2EgoaKJd/V+hsgJD1RwzGhR+9LHyPKM04rVfJieHwT1ES9S3T5Vs8iOw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MWHPR04MB0209.namprd04.prod.outlook.com (2603:10b6:300:9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Mon, 7 Mar
 2022 16:45:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%4]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 16:45:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     April Kolwey <cheapiephp@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Error encountered when working with loop devices on zoned btrfs
Thread-Topic: Error encountered when working with loop devices on zoned btrfs
Thread-Index: AQHYMQm4ge6G1zs9z0yS8YtsJcosiA==
Date:   Mon, 7 Mar 2022 16:45:12 +0000
Message-ID: <PH0PR04MB741614E5AAE23D4A8AB2810F9B089@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <CAFkGwLgySb_Bs_e-Ou+58o4Y4W7QGBCRk0aqZ8kk9LqRqGiBdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a80e2a5-aa3c-428b-f94b-08da0059d94e
x-ms-traffictypediagnostic: MWHPR04MB0209:EE_
x-microsoft-antispam-prvs: <MWHPR04MB02095F7DDE0A93334B2691BE9B089@MWHPR04MB0209.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /wvT7SB48LkaZoeHGk1n2v1khwhfk4rD9HBsgjwgeWwtL/DudAlHQv/MsKHMrN21hYuEs1e10cATzpctj9LOK0bz6oC2aAwka1842A1Pd0VT1hjn0K9vL9m4VHk0mNG02kvhIjS8bOEssskADvwWJeANSmiGHLlajP0+EMHXKRqTdkn5U/0LAyP6eB1+/kL/TFCkRDvbqDFjHwSrBq0L2PH/+LVNKYPWbFjMDaSFTAzeQDtQeUbPfNNELBkbja30cA42vbYk4EG3T2urS1WkpG22DZDDxPZq8795iJt7fxTHwsvjqwkZf9RMektvCs1XUuoWe//Vlu7FmnXI7hZWr/VzPVqwni3dEJQrB6dJpQcQ+fzc3tU9M8Yh+VPT435XiiGWPG7Rwf4A437GQfrORbQzydAJccci69Xsl4dpJsIdbi8GUeX/kN9gxRvE0cOnosdcYDEAS5kA2wUxWW3E/zHWcQye841ZlOz9S30pO1tGYX9Zm03T5G8aDUI3AaoMv18cfpaE3tuXnm4VdteNJZ/E+RQGXQP+6sF2lDjVrVlTxmbHj2Q8hNwVFPlC3fj5r2EWrZ2VplDrpTMDMs8XB2yoGs2GbZpLsu9RfRnt/YYLrKI2ox+PcdDsxRqNjxhuOeh54+299fa4FlkO4IaGn6SdLaID+k9ERhIphvJPUejyWckM3ekK8h2mMOt57PSlsq2FjAQrmqP3oFXirHru4AexIwSfAaNX2/3G4yyf1nY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66446008)(66476007)(64756008)(66556008)(66946007)(8676002)(186003)(26005)(86362001)(122000001)(2906002)(38100700002)(82960400001)(38070700005)(55016003)(52536014)(8936002)(5660300002)(7696005)(6506007)(508600001)(110136005)(71200400001)(76116006)(9686003)(316002)(33656002)(53546011)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n5dAAD+FQurQG38woll5eSkEl4b58lhzaxq1BmU6eNEI1TQtfbjfZzYH/1wt?=
 =?us-ascii?Q?JY9m74l1R2FWXZLHMrUmnj7oD8YFd+cBB0nWDzMjvMpccNdRsznoc7tbUKZX?=
 =?us-ascii?Q?B6kd8DNDMjEhswSzBB1x+cgSlUlWPWJcrwnZjZ7x8EbBmaRpMT3rVaUlR4JL?=
 =?us-ascii?Q?dj6irF/cUx49jMHKtX+BJmPquZ/kQerCkbpVSHCGaWpfTfWs0wyPG1Jrp5jg?=
 =?us-ascii?Q?uoL3x9+qTk1gB/L7UZoVUptGhJQS6OC853/0CzEbg2iglu2Wa/NBUUuyLjQY?=
 =?us-ascii?Q?YaFrmM7orrBNktlEWnSrCGhT4v7fYY3qc8GOcLkqXyRSCxiw5aJ8rljYF90D?=
 =?us-ascii?Q?Ds1HQV+IwGW2xuyMNVcVvDOVmrff73RIxw7XcuPC+i64QFSOlYOR6VZB//Zd?=
 =?us-ascii?Q?fT1tRvVh41mCOClZno5789C1w/JNeoDrNR6YfSeMPDI3Ec47VOjbOxoUDDc9?=
 =?us-ascii?Q?XWKZg0aIxgeY/npibLZFsDnBfMx2ulgZfHP9kIP3oTcmSGCl2CQttsftQU6w?=
 =?us-ascii?Q?dkHAO8LtnQjXr9DTIDNrA+ZUgpxlVVi3CU1bDbJbTdiAoJv26BwwZRyGnaOi?=
 =?us-ascii?Q?sC7IzgQGU564z62i4OnVeFGISE6WpSo8Nymqqg43kG8lUyCj0ikwBBNWD5HX?=
 =?us-ascii?Q?2f6x3G3FOFOjkT0d8vv6W6tvd9MO5Zu0WIGp+NYMWsF1pKYhGt0gNpW2COB1?=
 =?us-ascii?Q?wS55kmsAZhY8P1OOLDH2eW4PjYdPV8VUT90enPDd46GkT48i1IAQMg9G1QCp?=
 =?us-ascii?Q?WOT6ymDNs8iwRhPKMvQveoP0VXXpJU9QrdrzOpemRAB1cmcrLZifipDwwhbs?=
 =?us-ascii?Q?iY1g/xeACkuflYfzBCXOL8yIQsEWZpALo292Q/MqshVvrAyvn/E2VU+XjcV/?=
 =?us-ascii?Q?IfimcFw5uIZE1gThCbyn8y8u3hiiKb1xZwdgRrWJCN8q3DZSO8WPp5ErG/wC?=
 =?us-ascii?Q?3EmNORrtJkyAXgkLmZwrtTWpIJRrRlaA3L0f3Y046SAJ0BM2Plra6GTyhg4k?=
 =?us-ascii?Q?5Zp6RsEl8NENc0oNZ/QbQzKLlHY9439vMITSpkejq9CmBGzYlich3nz06Iem?=
 =?us-ascii?Q?EmMlLmo3XKMIUQsN7pRLBUmAd/B1VKqIYBkhCOeXVPUdcbOHRslcesEXjX0M?=
 =?us-ascii?Q?LCd6XG3kOPx2cUKa86ZaykBpb+O6gP6rzlUIw1E8HZlG4CxsAozh2WTdhQi7?=
 =?us-ascii?Q?2uRdnbQ5DHgLwLZHrcdW4HephmnKrGQ8FVDBr3DZgHGQnFZeChH5nlOrhc+9?=
 =?us-ascii?Q?x+VtsGTRJSOnVoDK6/H+QA27pguZ2txIHqfMG552Awfe1JeYFbAJmh09tqbx?=
 =?us-ascii?Q?QPBM29o087IBREdHKvthnMRcCBmertuI2bCjAp1iiTrfv/I72jsbnE0MLwSc?=
 =?us-ascii?Q?EHecJqwZ2AKFCPno10HRyGz6Sp9v0YOJUPYZ0W5//tg7ywf0iV4GZxAr6yOF?=
 =?us-ascii?Q?u1SAFhF26yPcWjL4Q8+42vsqEiyVcrMzxusQ5GYaDSPUhiw9RXI/eC+iilB1?=
 =?us-ascii?Q?l508W7bRNZQhZda54gkFVB3P13oVSepMcRHdeop4MSIkptPGUqIzJLXaGDuF?=
 =?us-ascii?Q?KZArT1+dGOHzgZ34n+FVrIkEyc67k5LO5aXaqVf4xxyohlWf+qm37PkIIbP8?=
 =?us-ascii?Q?a3RtYZLKscT85y6nhHSq8g7XgoqxReqYA1WYpdjmLbeq2hMQLJoEFEsTpzxm?=
 =?us-ascii?Q?bUzW/ghPRdRRddPL6rDikGjtSEo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a80e2a5-aa3c-428b-f94b-08da0059d94e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 16:45:12.3005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WlYk7K7S3ysxqj25oorJvVi9nEMc7AG4sWURsPAF2fYbZsFXA0i0r5Mhv7bpIJZzjtBNOWOI+CjLl9x9Y9sUiDUoTFhjKMl8cw76eHwesqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0209
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/03/2022 04:24, April Kolwey wrote:=0A=
> Hi,=0A=
> I have a box here running 5.17-rc4 (slightly old, I know - but I don't=0A=
> think anything relevant has been touched since then) with btrfs in=0A=
> zoned mode running on an HM-SMR SATA hard drive. It's mostly been=0A=
> working fine, but I managed to get it to act up earlier today when I=0A=
> was doing some rather strange activities. Specifically, I had the=0A=
> following set up:=0A=
> * FS mounted as normal, no special options, not at /=0A=
> * Three 2TB sparse files (created with the "truncate" command)=0A=
> present, alongside other unrelated data=0A=
> * Three loop devices created, one backed by each of these files=0A=
> * A 4-disk md RAID 6 array (operating in degraded mode with the 4th=0A=
> disk missing) on top of these three loop devices, and the initial sync=0A=
> already having completed=0A=
> * The array formatted with a GPT partition table and ext4=0A=
> * This ext4 FS mounted at another mount point=0A=
> * A large (~700GB) file being copied from the btrfs volume to this ext4 o=
ne=0A=
> =0A=
> This ran OK for a while, then suddenly went read-only with the=0A=
> following errors appearing in dmesg:=0A=
=0A=
Hi April,=0A=
=0A=
Thanks for the report. We'll look into it.=0A=
=0A=
Byte,=0A=
	Johannes=0A=
