Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C783514851
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 13:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358561AbiD2LkK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 07:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358574AbiD2LkF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 07:40:05 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F6CA6222
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 04:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651232198; x=1682768198;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o9XkxIbNV+ciL8Pztq3J+6m8NOJWc4KS1KiZDYqYUlg=;
  b=A73tSLQ1baQuV0Cw0KKOZ4rFL6Ry69uT38G47L79V5IXShqd5UUzUZ/Z
   97QFpFetBTMgmVdfrrHhj5Otu9Bw6Qohq1tRatt5RD+XoerlTKr2uWIpr
   +y8LB8FdB2MOAgx2evH0qLcEKSIPXERWGR1XTUjkZ2RV71T9OLXRp8MiZ
   X5EfAvW53SrF1sJe2XGC3beXSDQYG93OdXo1FRdHPj4nQD6x1PcNKoIAZ
   jkiXIwrtnClpBen/n1QSSMkuSJYQffT4pqllCFnUaeJmXXWrSwpNM5ir8
   L7O9s/qbhu0YmoRFB+CPzX97Ebll3wQjY2D31aQzJikrlkC1twSoY/dzA
   w==;
X-IronPort-AV: E=Sophos;i="5.91,185,1647273600"; 
   d="scan'208";a="199163853"
Received: from mail-sn1anam02lp2047.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.47])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2022 19:36:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZF1jyL01wGqU4bk2cjeSKkJQcoHfxsyBi96ikZkuPWF6L5H3CJEW7x5xt2NPDTP0wdInwY7CMC9Nnv2dFnQg1zBc+kRNWTsJ4TL4VGT/pdYvb0VUHKGC5sfCyWaBdYEvoj6oxD14VU815FAfhKhvvO/VdEnI2CJSTz3YWqiNupr40o8i9OodyIJJdH3sjm7fY/XtDrprm4GDvducpiyUySfEFTYuggb9mxMFqmv2r2IT4Gooj/hPPvVJt3q2d9DxD6E7A5WbymZ8MCq2ojFpEnK078SfsL3p2ooPGolP41A2F+bJGzVEtuAA99rT3XUYiaM4SFBQEYrh3YX4ywwfMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTeTv+Y4P3fK11ao2v9y9uMiuLG5o8wf9SU7v7DGT7U=;
 b=kniP+9KyqHRU4tHUAWzs4gkmyZlyzL1EqwgLYDpuFGHtSqBgVFvkYz93/Kh990JhbnLV56SbYx5xF8HCDQ8iOQsnUO04mwVD9VnezqOeZ12xYpy/STr6CnUICsH9xIcXZJWp33AYpOJ4AzHVupu1uKOiBefJ0oJ+HJMlUPHX9dKyS7twQYLv7yYMltZfwYt5bKJ8OfI4E7TUX8wAbYCmGneTlrrhHnyniUyW7vKeUvmuygfY+NwVFtcR3SE5vDdoZIDZxoi5tx1V5av3wBYbB22Ocbj0rdfQLRxUxNkmHk0VdyHtCW8PNSL0BXbRVZNwjIAk1c5rnSkZYMmL5j/ZQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTeTv+Y4P3fK11ao2v9y9uMiuLG5o8wf9SU7v7DGT7U=;
 b=Lau/iSmjN2aFy0l99cv4znrPirF3E+Rd9TwuXoagm2TGFRIgWs2jpNHpEV9oaN4aHgXKTPzNpznEOsGPGeThJzbbiBcJRcre/TcEuK+IWy4Xy6upaJcTE3U9O0DWigNJtsyt1/VURzNdAgOOPvKKcZqcFNGjq1mPI5LMf+Ps1TM=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CY1PR04MB2172.namprd04.prod.outlook.com (2a01:111:e400:c616::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 11:36:36 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8db2:701a:a93d:9b93]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8db2:701a:a93d:9b93%9]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 11:36:35 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Inhwi Hwang <dlsgnl1@gmail.com>
CC:     Pankaj Raghav <pankydev8@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Question on file system on ZNS SSD
Thread-Topic: Question on file system on ZNS SSD
Thread-Index: AQHYW5JxZwSax1EVVEqAFlGup7qbaq0Gv92AgAADvwA=
Date:   Fri, 29 Apr 2022 11:36:35 +0000
Message-ID: <20220429113634.orbbcut6anmzzs6w@naota-xeon>
References: <CAGy3qQDeMHQMx6ULiw2uGfiJWzumpyb1jhKgizF5UsRppAoRPQ@mail.gmail.com>
 <20220429112309.nz2x6zdi6qvjqcip@quentin>
In-Reply-To: <20220429112309.nz2x6zdi6qvjqcip@quentin>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 486c582e-d68a-4508-0208-08da29d48477
x-ms-traffictypediagnostic: CY1PR04MB2172:EE_
x-microsoft-antispam-prvs: <CY1PR04MB2172DE7224C9CC64C157ABCD8CFC9@CY1PR04MB2172.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KEohugD4aMZYpnCUmcSYJ2JvuT/g8TLQ4p0iOLxNZdoqUBefLK+5hTDIffA9oMWMsf6QvEgLNvcCAsi3YUgi9O4ttkqOauJNbuhL0pHlCxgNkxSxVowT+o3uSdfZNAjLGof15eiQb5AUL4fmyEiW3M0yx9FtBo+crbOG8MptdLAjD25snK7QYZPNunPXItMs/oVpj0k52A8kEfiM2WiIfAPsVw+t8INfdakxMqXzZ+aFwBcmxnxoEmc/zKpWYY5FXg4adf9Id3T2+1IIsNRgoZ0v9v8x7v5GdKy3NJnYeFcLS8mIMXcc3akbnbMc/S1Yuo3/QBLi3v2f+8n43W6HVOl9azbRx7hFkRsO4oydoR56NLi4rbMyp3z0/v3yZ8a4fS3INEOm2HqjPCVzinY3Jcl4+ahMElokTjN5QkucUGAYNQqMoGLSTvE7liGlMFFugzKgMrwQdHVnZL6WUtNUsWbdnUVRjUEYHSV1lmTtUtXCyx+OKKAPiRoDdy40bOI5s/Bg28H2Z/TsZ6e0vZrmnjGCRX6BlTgpEOUcBXnE9r75a2g1B2BQ8gkSw3pnn0eqhCQIO/QFQoq1ljqBk+IU5gmkjpk72jfTSzsSHU/dFP5NM4aJ3a36sLU81jnlpC+c6xGBHTMyh/SwYMMQYl+EhWw+L1cxApIPQB0enZ7deEDBzHpDj0egLiZ83H38zAvML/wCNe5meyY/LPWF8D8uPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(1076003)(316002)(86362001)(91956017)(186003)(66946007)(66556008)(64756008)(8676002)(66476007)(66446008)(4326008)(8936002)(33716001)(5660300002)(26005)(6512007)(9686003)(6916009)(6486002)(83380400001)(76116006)(54906003)(508600001)(71200400001)(6506007)(38100700002)(38070700005)(82960400001)(2906002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5kc/wvwuTcXNCq/ildoqB3Ckd2yWRz4yLaKddPXSSjKZZ9VuegxAHKgmT/DH?=
 =?us-ascii?Q?o37XUsFBC+HeWugp6aBEi4GGiRMRITkcx7/HEpJ+/74Ie3R8HVfaY+90/bg5?=
 =?us-ascii?Q?8ChOj+WKb7hk4ofykdZW/kvXLHjMi8lkt2+TUCkPom5bFqUxViz8elD9Wz+0?=
 =?us-ascii?Q?nwI9AFy29vzcKrqM9TLPEXUl9oqtHOgb5VYamdEx2j4P879pxFLOaaKzxvA5?=
 =?us-ascii?Q?Z6oC698Z8/9SO7ebcvLqXJB8X168AJmiwEd2732pD2C9VrDmx9IwdK01YcFT?=
 =?us-ascii?Q?kphLqo8pJiRCKY1CBcIjN95IvA63UTHXNQosi6yxB5UyL8gHhRA51dnBBqu4?=
 =?us-ascii?Q?9QVrwNCgv8UjN8uIp0Ovg4hpBcegvfxob/f+kBgSgoLSqWI+LIV8f2JdGMtM?=
 =?us-ascii?Q?5EUyK4YJI7pQTbCviBL6q4/zZmf/8OhM4EdvuIn6nCCe96z/3944qkSdobY+?=
 =?us-ascii?Q?D9qmaidK3L1Rl3PJ1oPNgZj58SqrjvShqjPB2eMcnr31dtkmuIS4fiQHEKWD?=
 =?us-ascii?Q?ynSoc1cz0eemwHPBqFAnUHjfgY1FRKkhSIoqVhaTdUuLrdTCUnOLFLSodR1Q?=
 =?us-ascii?Q?ccw4PDgMBCuov0CXIfE9h7YFchWJFoimFSdBq2CfgmHwmDDp+OYtFqs7nsGD?=
 =?us-ascii?Q?lvDsb4/B2j6Xmba0Up25DetXKJrtBx82ZHxFLC81maYgq/4jRU4ogROY6CZz?=
 =?us-ascii?Q?ci+tYN9WUuY/7uIAgcZUXsWFH6yvn5CCX3uy7Y0VicCUwcaXgb2VFoIZ8sGi?=
 =?us-ascii?Q?gf2LCGDoAAUaUGt7cNJifiO9NcqiG0eHfIUjN3gtC6QFXIWobRzmDerljnLE?=
 =?us-ascii?Q?mz4zla2NutMs+DkjM78I1Y7erD7L8hLvgEqYJcDJVXC5dez+AczPMpq/zOHb?=
 =?us-ascii?Q?Cg6toSSgrhemevOVm4OyUihrXeigt+RE1EPz6zWbdeAKLt68KQxe4JH6NSp+?=
 =?us-ascii?Q?klneGRtZZZu8sgHcn9SgyBdj4WcoVDA8zMl3nVGA2mFNyFFvOGhFs/eTow71?=
 =?us-ascii?Q?2IaNTnLhtiSyNuEBzbxPgScCdfAspAGkoyIM2lAZA5xGguK7JkdRB5cBR0Y8?=
 =?us-ascii?Q?MG9AUIFd7yBc9qZwn0U3WhMutNP/r57FuGj62Y22LGTeWtXqSgFy79wiAW/a?=
 =?us-ascii?Q?+7dSV1GKfv/S0/zAar2n1n1jEu3fs3xyNxsiyGBFf//qq1byhYLaXNQ8Iqrf?=
 =?us-ascii?Q?2kXHTQ0VFkd57S+hM6Mhf1WlzTyZhjWDq3kLfmEmgFcbqSJtPfS/BIidsNe9?=
 =?us-ascii?Q?PYP4Kgqf0QL84c6L65ejCSuKtdKFRABB+xN2D/Orz22KsUDuFJhsBzBAkCEE?=
 =?us-ascii?Q?jbJyCNfvrwz7ccecRrQKr5BD1lmMnRnrzImEDAozXx/uunQNeRSLrISJl+mZ?=
 =?us-ascii?Q?IgZVnoGD5YAJnYXLG19c8AiOWHhgE4CXvsohC3//mzdfci/7oEa9+osURqsR?=
 =?us-ascii?Q?IUts9r987dvRY3wdBxyaydyB497VIpH3cT+VTB2DGenllu7vmfzwMjkSiwK4?=
 =?us-ascii?Q?NMwTYsiAsFAsyobXlAMwZI2GctoBVMYLYlVRbrsLDisHnWxg2cGip4I2CESf?=
 =?us-ascii?Q?eoaam1so3mGsOL2+RMBa9eFob3NgIiW6cj67+zfYgAK9f4W0WZwn6ym1o2UF?=
 =?us-ascii?Q?UGdgWV0ZB97KXPqsht2BHsQTLJAZ6oZPdHI/KFrjkv2ZLsbf94DY4JjyjTk0?=
 =?us-ascii?Q?1DJk6Lm/w3/ilGwbbyWWDj7jCgwZzW8yVIRjL6IIRh6YZJYjKuemAUnz93PP?=
 =?us-ascii?Q?TTtcx/iWguP+8pLCyE/R0XGC5J5T/DQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9DFAF6030089DA4DA14FA421F82003B4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486c582e-d68a-4508-0208-08da29d48477
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 11:36:35.8387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4hkLuBooe2lCkrY3YjvldNbikn5HifC2YDA63PEHFXMl99HoYVcEU5enHXHit0U/PO3UE6vapkhQ9aMBsEZusg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2172
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 29, 2022 at 01:23:09PM +0200, Pankaj Raghav wrote:
> On Fri, Apr 29, 2022 at 03:26:45PM +0900, Inhwi Hwang wrote:
> > Hello,
> > This is Inhwi Hwang from Seoul National University Distributed
> > Computing Laboratory.
> > I've contacted you to ask some questions about the file system on the Z=
NS SSD.
> >=20
> > I read the documentation of BTRFS on zoned device(Zoned - btrfs Wiki
> > (kernel.org)).
> > I want to check the performance of BTRFS on ZNS SSD.
> > I attached BTRFS on a ZNS SSD(ZN540),
> > but a basic write test using fio failed and raised errors.
>=20
> Could you also post the errors you are getting?

Please include dmesg as well.

But, I suspect you are not using mq-deadline scheduler.

Could you check which scheduler the device is using with the command below?

$ cat /sys/block/nvme1n2/queue/scheduler

> > fio command : fio --filename=3D/mnt/nvme1n2/test.txt --direct=3D0 \
> >                       --size=3D10G --rw=3Dwrite --verify=3Dmd5 --bs=3D1=
28K
> > --output=3D${OUTPUT_NAME}
> >=20
> > Best regards,
> > Inhwi Hwang
>=20
> --=20
> Pankaj Raghav=
