Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CD54D7E07
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 10:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237815AbiCNJCX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 05:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237814AbiCNJCS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 05:02:18 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84381427E4
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 02:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647248459; x=1678784459;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=WSRsD5D9ZjXi/VNqCldWT4I90O7kfig0WAeYnFCo3XicfHRf5OcYzDn6
   3hcXtRh+3uisfwsmVmLI963Zd4RQnPQxvdiY2ECB1PB8vFvnn7cX/Apgc
   lSA1K7kbVzjVRINVFTk1VcJw5rQeSTvq0Zd/2SewhctX366lHR6LfbU4q
   /oZGNXXSntLU/17w1yyvG1Xgn8xSETu24ttXnGbrdsNfJi11kl9mULytE
   9Ryne50Xu0GASqKk4hGmwfHyWbj7AkmufUtzfnUBVfDDj5SusQbnj/NO9
   cFqtIOobUCti0M1AHmIaxn3cV0vDwbGFXv/w+mHdzSSKL5mAl3xBQOcFD
   A==;
X-IronPort-AV: E=Sophos;i="5.90,180,1643644800"; 
   d="scan'208";a="307246167"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2022 17:00:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8D/Phmj30JQtvdzDU5FOiQ0WRScP96EXw3zH3u5Yb/WDlXOsHHtWzAtJdXU/9B7V5DEZWh+AEwFzFjOJ6SPGeBCDzI4jkKvO7mgFGRfuzr9Drkpu9d06murk+lXoPzUb+m8fxbVn8Bk4ELKWvnd6xv+xFGhGxvd+qiLJCMJDCtL9nJZFk3hnD5KK7El8RlUP4yI1HiHFeh4n6iiBl8EZ+GFdBgz2q7+5ihLeiZBA9ExCIox/ICi/QF2AZZnPnwLHx7jFH/MMUYnlZfiZipvkt44Ytk0szhM02YZSeBfguIj/qZ8Zn/L/9Pab1gU91rOCeyoqEpoJpDtmWnLLxAduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=M/Nrf6QXeiOBcRAhu59Pf8ejPYbogJogF1adAx9DUCjRa75YS1uxoUM3eqtIMbgm7gbRtr/n26B6tTr+p6hOfYaxkAxAGfqaAQ5P285ocaNByfgS3FbAzducQ1mQRvUrWx6N431aeysUKdOaif763cEtTs6qLm+U+sJBmbXls7VxsdC6mNZRFO57YXgpvsiXkWkwfAdqzxmJMg7unwcgXDUVdycR24y3KR8srMaguZc2kI3X/x+6tAmSKoOboDk1Uk1gdYZSUnTgjpWQWZ2J2jbFZyueiojaHzTq9dOK5eEETU9H7XrvBcYNf0xoqE4U8vYE0iXXKtVUurCTH9zRRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=SRq8qHefYxT1HwSSV0a0G4a1XfzdqOgZ2Pa8JKRGvbxTEsuGrOSWzES4vYrcMdQh6NOeQ+61O4pxEbYz/F63rZQY8VNhOup7uAcVyjqz/XNDj4xiLguy4itgIb54228UBeFNes3YjAlcDKDFo3F/04kK8ObMViNLIWogKmOMG/w=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7902.namprd04.prod.outlook.com (2603:10b6:a03:3bd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Mon, 14 Mar
 2022 09:00:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%4]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 09:00:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: btrfs_dev_replace_finishing use fs_devices pointer
Thread-Topic: [PATCH] btrfs: btrfs_dev_replace_finishing use fs_devices
 pointer
Thread-Index: AQHYN0jgmhLgZZDVUk+yfXky7GraCA==
Date:   Mon, 14 Mar 2022 09:00:55 +0000
Message-ID: <PH0PR04MB74164F3E68BE57FD61B913D39B0F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <98ecea7936c8b9abbc5a111942b2f95dc395bdb3.1647218125.git.anand.jain@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e871b72a-7ceb-44c6-a883-08da05992676
x-ms-traffictypediagnostic: SJ0PR04MB7902:EE_
x-microsoft-antispam-prvs: <SJ0PR04MB790204C77FBE0827539C397B9B0F9@SJ0PR04MB7902.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d52kYPORpXdLcelz9rg7CgTiDo9ZR/Z0AptBGiBSgvpIaWrtpHUnZ+uWH/BuTdld+3VOWj36HhgoyMZWUVjHCabCB7nmSr7yLASwTLM1MK/lTHweDf6bxvbsPKOuxAXDBzxe+OSXQrnh9bjJQmJH7HYeLCs22Zm8i+pnsX/Lp5EEEBFnJpa5j9SfSUSDRTdSIUOlQ3lI2gJvH8awic4fP874bQfT6OwFtju/FGMO+Qe4hyrhQgMnXgLwhycUwW5XMxxE+kDRA0VVVPZxaHmXDlKIgOaxqNnU9rWsNzt5FaP/qVNSSyHqicUFF4JuViVziHhy6R2L8nwk+C1bgZpEvPinBrTIt6rHUhRQkrajYidiyA0M2whD/2vMe9PrdKHcjTLcX3pgprPHr2hheduHjRdUsxZVPEeeXvIfAeY+smpvJHeAiI3UcT/PcDGFAIFmYSWZaLhZg0q6yMVm7QC3jRXX425X0oBfGSTDWSobnecIekPatV/2UeW1VJ1SvBcuc8ryL+2ZsYN3IAAnOkF1GmIzEom4zzyW4IQUq6l8d463AwGvrc+BKOH+3v0ccCVMLo2iCIdK1e+8rYP95oqFqnQJxOLy8OuZPvW1fxOOYHaK4Uer3P5+Vj6HamsuwSuI52n0SM404l79XTgGs2OCRbc284MtZ9xFE3u5nER2576Cr2yTuIygA4p5TEfgu6xQW9sxEcZpOobPT/orubFiNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(19618925003)(55016003)(9686003)(4270600006)(33656002)(2906002)(558084003)(122000001)(66446008)(8936002)(38070700005)(66476007)(66556008)(64756008)(82960400001)(76116006)(186003)(8676002)(71200400001)(66946007)(52536014)(38100700002)(6506007)(86362001)(7696005)(91956017)(316002)(110136005)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6fGLKKc7TjwA3W9v7vpVKbEVKnHvdbw5i02BYDAUIWd47OJ6abPeVVDrfTOD?=
 =?us-ascii?Q?ZFNmGAILBCyer4YMr2BYZ1Rl3o/4T1CFzYZa1a3ba+kotUSoSjeo05ghyTXt?=
 =?us-ascii?Q?KB74SGEOVGE5o+KUD1zRQ1j3hOGAhVWn41ncvWLaUcSLjE6vDmc+GEWL0bbW?=
 =?us-ascii?Q?93ex3EjNYN00rN+BiimIDELAA3ojq60qZSHuutYlHCs5Jz3G6ZppHcanbmLf?=
 =?us-ascii?Q?4WkhfnIOnn506u1s7FextbZfrH48KOXRzdafmQAjP7oM6QaFCM3xaXrTQBJM?=
 =?us-ascii?Q?hrui/rDXCUGx5uhiUCbfU0qEXg8TN4cWw4ggD/3Cpft7JR7lPuH90MXfyIfL?=
 =?us-ascii?Q?EH6YIyzAAywhBufRe+9ku+LBujhws3bR00HCAwX8oOGeGNVaftEaEr5TviBE?=
 =?us-ascii?Q?/joOLk+V52zgahjvo33OPfHUmDL5qFrzGH9YUle6RuBNo8CQlhQKQQ4ju07q?=
 =?us-ascii?Q?Am0t16rnQoybTfXfjVKzkZjDFeVN0L73AaxXnnV9Jh9ADEU3uuibRUd0UpqL?=
 =?us-ascii?Q?AjxcBDwyX49WRff7h6FrGIbbXJL/N5CMGWxJtdTxYOTAi3JOYc+LqxaaUReY?=
 =?us-ascii?Q?xnghD+HSARD0jvMhYJ4qV1emiYwKGNY0Ww0oc4WYPITlR+aR+KnvQPd7lO/N?=
 =?us-ascii?Q?kLQIgpta0CC0J/jT6bduF5qJzQDzzkPo8EHdT+JP7J9IovckfFP+a9s7JZ+8?=
 =?us-ascii?Q?+omuNr4iA22V8ZHWx/nv2vqecATC9Pb45woc2xcuFnoyXQ/4Kgw0kZwjmmKJ?=
 =?us-ascii?Q?kDO7Xif36yMeeIgKP6Y/k0TQq302DdXK5CmtXgb1eP4svbgf/LEF9mtJk9Go?=
 =?us-ascii?Q?vvrNg/toBilTWZA6nrKiOejsdRV3zIYoY/bcP5vmItjzUyVNd4rmq1k52Pu3?=
 =?us-ascii?Q?zRi1gw/PgvrjWJUQm8hnFYbApNgJEToeGjS0WL5m5HsyNaNPbBQzzCNlH1ah?=
 =?us-ascii?Q?UecxmJbyo0zBOuMeqs6DaAQt0yBC5J2iYnqYi3oiYjkb3vbpj0WgFyaZTj4B?=
 =?us-ascii?Q?q4GmsY9NZQp/bnrNWiC4w11cOmVgXdPIjMf4sydsUadG0njc65C2t790Rv07?=
 =?us-ascii?Q?oUn2D3oXHZ60dVsJ3Ko41ziC142INnYbxQUHpv4uk7kKqp4nThYHeNSikRwd?=
 =?us-ascii?Q?beC/75HKG9WsBkLoz/XMJVWetgCwU/3IHYNxChqo9cwbZATp3Dzj+Hqj3ZjV?=
 =?us-ascii?Q?ltgwLLd/xji6ncb3oi77o2kShAmUJ60Ky6xUmS0+9oxXFYohZtzcPkJg7pap?=
 =?us-ascii?Q?fZSnywoXa/6vLUEy5D1+S2KihgcprUEvXbrnqtmgRpOLPAM5xTA4tytmvVMG?=
 =?us-ascii?Q?h4hEgxHugaCeJKuGvm+ukEw5sT++iUWkNJRNEblniSadadntnkruqME6i3Fn?=
 =?us-ascii?Q?2Br/kwf4zsTSuRbZOLoEDtAS2Hlx41Alajn819kqovPbiTvp7IeFh7hZ9Lh2?=
 =?us-ascii?Q?mKFNdgiUOnJqoqeNDwwyz0Fx9T7Ya9Ey8NID7hBocvLK5ZaN0lf1zxsm8J97?=
 =?us-ascii?Q?oEWfIdY60+sBrtR7zgJDJYhF0gkS0ta9rknd+GGiN8Nyhnz0hBFw2m7dK8sq?=
 =?us-ascii?Q?yPV/iOqY2TPO37gIYTQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e871b72a-7ceb-44c6-a883-08da05992676
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 09:00:55.8855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xXLGqKxiMtMtsw+kxH9BSJdzwpX2AOkFFldi6K8IuhosPKUkZX2ack5TMhBKkVXjHqKGE7f5yKVL40PNwI1vtWSm6e1tWBb0pl25cgm2xG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7902
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,TVD_SPACE_RATIO,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
