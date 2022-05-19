Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A052652D51B
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 15:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiESNwj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 09:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiESNud (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 09:50:33 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5512337A97
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 06:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652968206; x=1684504206;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=iGnSsXpBD3GeWg04Zt68aXdWgsAeIKEr7WLpvF+HLnU=;
  b=ROY6qvF97XvH9gTTwr2hvTbHH+Z9DSGgrVzlzlTqUaKUJVr192A3txQz
   TCTF1eQSkxC8k+BtrbS0pI6ymgaVfkeBFdF/CWCtkk2FGjnZXxHiRvRXj
   uOezbn75PqhVbSFfmFd1zNzD2GhrTdza70bXXYgk9mXcJ2Gub58BMWwNM
   dJV7hexIeZPQ9UucIt+ju3PTiyxU0HPXl03x7uG8hMV2mHjdFGfu9L/9Q
   rrxphGcMWZjC6DpwW/LQSuDDReq/bFO77pmisVlpjXNMYpM6+N+fnqx4Z
   K1HSoyOatWizN8dppPMJyV6ilorhCJ676rOXyvEdSGZr3VoBZmBmJrfjq
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,237,1647273600"; 
   d="scan'208";a="305017503"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2022 21:49:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFDXqc+fJTfHclNcMrwHviYorwYf6VI+z4dasT7NnG0DdzOrTXMmT7+m0iyzZ+WQ2PuYN9fXD4lHDIjRFn0m1yMTKsVjC1CrJq7h+2oUlCsvPHIoyRzbFzeGgzKj6M/Arj7CnvBxfs/avA5BnXRvF/kwQ83Ic4/9N5tQ3pRd7FQmmWDFfOf+7et0wyEz7JJvaQHVR8/pB/vMr9voerTSXvTj3uajmiRU0I+boG/SGS1GVzfDa77EafaNpt8wM0V1W878Ioxr02vRJueKjOayx52j8U3W7H39ERCdITKnM7pyNRtSTizRDG+Xtu69JC47XT3sQXJMv3Q72v/YLac0MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGnSsXpBD3GeWg04Zt68aXdWgsAeIKEr7WLpvF+HLnU=;
 b=jpoj4oSKPamKm93wvLhg+1VcZNCrBghXS0IyV3Fq0Z9uz5E4Nam4uyDvr9f0hA8IH3CArqpcmojtF+Rgn6qRw2FNZDadoQA5P+pNV2+OdL0EmEuZKRHDZVNASR0nEmS0U5nKNBR6DsUw/A5ZgcBrjKzWC3fGXZPtH4W5p6ciCah6rNORWNrSlT0LnC5j9ITTiye5viBE6LN4RjaxdRmZzRR3Cv+ipR9si+64ANsL37DR9UmsuuoOO/FaXS5SFGdYQ0OKLvHWV65X6sM8RWMIZ6nZtTIEaxwkgzPxM0uDe0dy838Ijl06HsVU/dG9xBa8yWprTZkw121pbKgYJwB+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGnSsXpBD3GeWg04Zt68aXdWgsAeIKEr7WLpvF+HLnU=;
 b=u7VRsIsAgK7oUrWKzfHL1PvKuHw3zxSHpTCLOD50c7LwI/69dyTGm5hlevpPTaS/VSAurrjhVTjgSSLkirDSqbLP02ljkCYMtlPUSDeyC8/PwtRIOqscMGHiSLLVyimWWZLV/hwChl3UkubG5TgFkjnt8X31s0TFxqP7YioFYN0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB4531.namprd04.prod.outlook.com (2603:10b6:208:44::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Thu, 19 May
 2022 13:49:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%4]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 13:49:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC ONLY 3/8] btrfs: read raid-stripe-tree from disk
Thread-Topic: [RFC ONLY 3/8] btrfs: read raid-stripe-tree from disk
Thread-Index: AQHYaTGyleh77VsKp0OYSKTjOAeG6w==
Date:   Thu, 19 May 2022 13:49:09 +0000
Message-ID: <PH0PR04MB7416361C433278AAECFCF6A39BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <2ccf8b77759a80a09d083446d5adb3d03947394b.1652711187.git.johannes.thumshirn@wdc.com>
 <6ddec77c-2aa5-d575-0320-3d5bb824bd04@gmx.com>
 <PH0PR04MB7416E825D6F1AC99F8923B659BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <ab540ece-37b4-7cb5-216b-dad26ee75ccb@gmx.com>
 <SA0PR04MB741858084F504990FE654F879BD19@SA0PR04MB7418.namprd04.prod.outlook.com>
 <a1b876ca-6e6e-39df-ab70-0dd602229f0d@gmx.com>
 <PH0PR04MB74162E6BE1BB1F9519C440199BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <a6540b7b-409f-e931-dbfd-98145b48581c@suse.com>
 <PH0PR04MB741655C18EA13F9152DAEB509BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <e66ba88c-52f0-3db9-7284-f7a161542634@gmx.com>
 <PH0PR04MB741660F84BFA0F9C4E0204A79BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <e0ba76bd-72c0-fa6e-212f-92e060d79d42@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 667580b2-7cb0-4cd9-962e-08da399e59ab
x-ms-traffictypediagnostic: BL0PR04MB4531:EE_
x-microsoft-antispam-prvs: <BL0PR04MB4531288E0C95C7AD91A0C35C9BD09@BL0PR04MB4531.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qSt+fqEZKJDD78W+1NUFFGndFlU41dRgTr60lfdYLI1OzRsrQ5RE3YftUhR0SxaohLgUWKz4G4KEeDsnaJ5uKAyAHgZxrVfrCxg1MOvQnLIlE84pPMIYfcMxKrjI4cpwpIf9qczDjPQScUVhm4AnMJsZz2BaBya6o06KqWkaIYFXh9zn4Hk3dX496rtcGw10YLDVjsFiJHiDp+sEukctrtkAQE0FfrV+lKiTm6SXGIesaYOZpdd9j0WsVWrrS1wgl//EMFQ+7yG/aysq2obBTMHtcr2c1j0WesuuGJ1SMCqKXfZGWMoXj7N2K1/kLAz8/bFU4U/8TM1DYbeyrPwdIoX4XUzwZ6IPr4BbO/Nu5UF2zqZC193+LSOLZa0e/eNg9Bs7vopsDTWwS0F7C2tIM9o5hqWdmooPx7krSbdAsqtR+k5pBbBXE05bBqhj3fP3fuY+hSte3f316YiHwf9+dPpISnR8IZlrwxgI/zkO8uwd/PqE4cQOAemHChjHqpfEPnrw1NA31+2p8cBHIeVzQ/COW0jEv6exjVtcbHIwufJ3e5JbAYeZU4O4Jn+0Gso/VnQKiO/YEec8+EedKvv8ojYnl2VU0Qonv8f0JJu5IatgcvEEcFpbxK+Nqs+xLKGmjBGkhrhZNX23zqYbaYe/Og3O+65mhTX36ECp2Enp+k3q86oXLYgzn1wQb+sKTcV19rJdkVI/sYlycVeIoR6+Vw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(186003)(83380400001)(91956017)(9686003)(71200400001)(76116006)(53546011)(8936002)(52536014)(6506007)(316002)(110136005)(508600001)(55016003)(82960400001)(2906002)(66446008)(64756008)(38100700002)(86362001)(122000001)(8676002)(7696005)(66476007)(558084003)(66946007)(38070700005)(33656002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6kGl3CDrS4fXwzrvPlNOAnA6kot2G0dK32nzqmlGSK1lHbmjx4egGkRlCK1h?=
 =?us-ascii?Q?IwQX4lFO5mRNQ/G/uysdkgXvfTvhoVygo2jZlyUZbuat8/foiPbQ+VpZqvoi?=
 =?us-ascii?Q?gj6BLc6LFTneOTRtxRBNmXteAMF959edBDyT6tKDW8WH9C8Z+NZYWfl/CpwV?=
 =?us-ascii?Q?JwIV+QA6+pU6nAnxAj+J7gVZ7VS5ZfXYgvpIZuE1uqUH9ZtzqYvXxhp0pFK9?=
 =?us-ascii?Q?PyFcYx3SMQm4OU/0U1hdpdltd0p5wwIVJPONdxi5fRxxIGZ3ctUhXg0gjINZ?=
 =?us-ascii?Q?/YO2Xg9ygqfThxRP6e+He4rKWpxTrB/c9Bp6uz2adsb4exxYNipvAv1Ic30C?=
 =?us-ascii?Q?FeHS81PBOddjG92VdqmnupmgzxYL2NoGeVHRaAQlwAJAt4lUJatCVQ3fLZBE?=
 =?us-ascii?Q?W3azG8wuntVMMBRsOuNHhwYimYpR7tE3Xkc+r3SSWy5Psp62/VloITqkwopi?=
 =?us-ascii?Q?HiwhvSiN+kdGLiubYJd9nXcZ85WkuJ74aKRjmU8rca0p3G+h8XX3KTzG9hvt?=
 =?us-ascii?Q?6RXjff3PnF0n9OMevrn+hCBAOZ1HRfY8+pq4d6g8P09tIyQHu2vDUSUrDm4x?=
 =?us-ascii?Q?HjUAJQ5XrUPw0m0A3rxSiDiZsRN3vbv//X25lcuXsg8lOtUUAci7zjxHAEjZ?=
 =?us-ascii?Q?t7QJogRQfTdS9WQpBpgFGd+o6wyHs30vslBj0kV7lIFBSd3A1l9HpHXUUP8t?=
 =?us-ascii?Q?81b1+6m23xY8S3sxLwz8BXQzxBVCBOifLINKJ4EYrLisaMEhvXD8Tsk5iFr5?=
 =?us-ascii?Q?hVJCDJicjllzW7jo1Ernx/K0eROG2GcU29xyHRstLjTdnj/ATVSgi2Yl/MaG?=
 =?us-ascii?Q?hX4qQQk8RFiKpG7JA03abxu1Hfuh43RQyEh1UQgg/c5j2qqbBBcqFOSY96IN?=
 =?us-ascii?Q?uFWrLQ042PG9JbEjFjcLVlnhrYtasAAyxGsH0ua9R69Q7OZeLFA8xVypsSpx?=
 =?us-ascii?Q?3tYkSsHL1yS4uke9Kt0bPGEq+zMlLrm+OdwdI+5MBwHjdRSsEhv5r1kShqXV?=
 =?us-ascii?Q?9tx5lfh27Eyl0Izp8U1mp86LCvB5rvSknFDByBrW3m9p+1xW2PJOuOBnakTL?=
 =?us-ascii?Q?lVIyLpG/j/fA58CNLHWaHzRALJ6YbL5o3FjOQRhUBU988YatC3x27/4Lc3ZB?=
 =?us-ascii?Q?B3iT2/t/v20B7ZCjb2L2Qm6Pey2U090PBr+RqwlUvqyEfG0/2EZrupXAKMd0?=
 =?us-ascii?Q?OP6nYhG62MNSpNs4utNk8s6bNNmQkKm2B3CreMsXwg7hTSYKRTIfZaNGOskE?=
 =?us-ascii?Q?KcXoUCwLhwhw98ujGg1lPYQO5+vdM7/EKRvndlnJkeTfN08VibSB6/F7mx9d?=
 =?us-ascii?Q?uMR+tVxLuy35qn1KuXcMmv8GAZXLG8OMMlGGDHdWNSc/64Na3AEaLxJZYfAn?=
 =?us-ascii?Q?5Own2GMhSh9AVvDdMK32zAnqxg5SSm4MiCuQF/Bgb6+oLUBM/+YE2mO+DegU?=
 =?us-ascii?Q?qvJI48aEovKUjHv4CZrGgBJbgBd4BqaFC0hihJ2cpM40VMv0cf+nWrXQI1Pr?=
 =?us-ascii?Q?DqJDNpiSpVGQIm3RK9CF/aSoMr2Db9Y41LwJTQb9sJsEM3ej7bss8XLGgV/u?=
 =?us-ascii?Q?tRHTxYZbS7mSah5Rkiae5NE8QC3uqUpLIRk4HXyDuFZ4eQ7NR/LiygmIpU/X?=
 =?us-ascii?Q?6EiseozZlnXfYxrzht5PjMxyxsGyaRqUYWGugk8hplOXwVw0AfsJ2rzQ/7Ny?=
 =?us-ascii?Q?xDe+WtetY4/fAQwlt/ZKPXBfCeoYr2cmEib+BDhmqvsY5W9bEqC59VOSBZ8N?=
 =?us-ascii?Q?fnA+I9q/dRbYNuKRlg5vWO0Yq4P9vNXaJoyWQGfmqVHnEiK9iByFzBkIxDFl?=
x-ms-exchange-antispam-messagedata-1: l9xIYjGNPPWwc+ForthXGUrsgD7MEhlS/z/zRPfo1A9mLp6T7cwxkRFl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667580b2-7cb0-4cd9-962e-08da399e59ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 13:49:09.7911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7IDuUebIoOCkT6wZO+VqTptAxCpMuo9Zvg/Cwmy3OnM0V2tb2wzg7/KHHa1gij4l9GAFat5qQ/LM7HcHlRTTJ4L3fZF3/nQSYiW4lWVkzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4531
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/05/2022 15:27, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> Then let us consider the extra chunk type flag, like=0A=
> BTRFS_BLOCK_GROUP_HAS_STRIPE_TREE, and then expand the combination from=
=0A=
> the initial RAID1*|HAS_STRIPE_TREE to other profiles.=0A=
=0A=
=0A=
That would definitively work for me.=0A=
