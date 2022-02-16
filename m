Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154A94B835D
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 09:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiBPIuX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 03:50:23 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiBPIuW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 03:50:22 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2392AAB22
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 00:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645001411; x=1676537411;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=ZBeA5y3oudRjhYiBiIEqzF3Rlmrtkwobn6ZFykqKTOe/gQ1rcZLCGpMO
   C7cODcJqfX2pKNkPrM9SEams1u0u1XTTkFfPxpa/8+koeZANa9SNMsnnE
   fIFKSOnndnIdEOTm0EVSJd0PSpGklt+ZRaKFJulf6C+H6cZ6myhgZdWVI
   SAV5oI/xBwqUNZ1QQHldse2bzVSux1atOizu3ydnbj3rDgNJnktSOSBnP
   RlkxXq4WEHc5FXTiGBpfKnUifMN8XLPaFuUb4H4o4zCDT5/kgn46myvIK
   BKAdvELlmT4gKkZTzyJeUXhqd7KPq8W285ydi058S/BdBt4T3juSRu0Q2
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,373,1635177600"; 
   d="scan'208";a="194055935"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2022 16:50:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPaYqw/tAh71VeQ2AIp6ui3mtqXmR1H6bjoZ3nBVk/jkYmgNdCDYmRFtckocSgwSCEc/3y9HIqFPfASG+gfCuzEtaoQ+uF222z/fva2NXIumCZQvCtt/jrewfKDFa3h8lGfvMbLcn4qwCMcBGvM2f0bEYp63rpAOcj7EK8MqE7I1DqLDLy1zRCKjoZ8lXNuGLtOWDU+D15RDLZMIlivDajocvEBhaShhRv+LX8StZoVmchtQEM27XsQzHy0sKMl3e9Js5lx0pJ2m9U1Zgj9XHgVPfQ44lNWczr1f/vOzYxUdz9BH2uaBMFWO0zFbTnzY1+TVYGPmQ76+3vGYYA1t+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=fIxqsccno35xT+C0OtDfDnOPU+vNlwK0K2ZhIWgWS3pU6Zaxi1LGkDFflnPwsOXbbYWDDibJShz6HgEqZFHml1RCB3sxvK5gvgOlBPFBVeWPfPNkiOOyEM/t27khecGN9eP7BQK4yGpLxFbIQ7wK9YY5CCjZI17C9c5UcsDxz+W/RWByx6my/DbfLjG58+3pp6EQKXn0rdOWrPlpb1+p/S0hYWeqUJGVtdQkk1T99BIlKif+hOJup5DqznUMRazi7iQvyhoIs2Veb0uH6uk3H/b8f5Y5Hc2fgUwNwpXwILWBdgN9hXEh8CAvNMuT/citppE1+zZOfzU6z9Z8ROg7hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=y03uGMgYP4yTSnV1vBR1mbFVJIZvnWB99zeJbczmPK7eMmUFPIBckAOw5lGp2TraxMUiXi9QiJZMEaTtTXDGm3CsYAC6kbbcyVS+ayKpFaWnKn9JRf/7LRs1hHLsUdde+tBSAOq7n7KcrJ0DMoNYHCPZiyzPZr5ty9vYVbRhdYc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5530.namprd04.prod.outlook.com (2603:10b6:5:129::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Wed, 16 Feb
 2022 08:50:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%5]) with mapi id 15.20.4975.019; Wed, 16 Feb 2022
 08:50:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 4/8] btrfs: remove the bio argument from
 finish_compressed_bio_read
Thread-Topic: [PATCH 4/8] btrfs: remove the bio argument from
 finish_compressed_bio_read
Thread-Index: AQHYHs/beULpQH++ikqGMaNTGvXN/A==
Date:   Wed, 16 Feb 2022 08:50:08 +0000
Message-ID: <PH0PR04MB7416EC94EC01AAB146C905FF9B359@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1644532798.git.josef@toxicpanda.com>
 <a0c1fa4b70e7cfc5d22afbc8695ce72e336a8f0a.1644532798.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 631d9060-18a7-413e-0e8d-08d9f12955e7
x-ms-traffictypediagnostic: DM6PR04MB5530:EE_
x-microsoft-antispam-prvs: <DM6PR04MB5530E4097F34F4949187E49B9B359@DM6PR04MB5530.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jgcgXMT2hOQ10utt+uT1TC0ZpeMoJNGJflfIC4mSYINp1TSP99jZ8imP1gi+QgWjFc40mXVrmA3QULZDMYUUjZ7GLZgzk5PUvqfREysyR8Xbk/HhNM6W8qXAzZIPdDJdTC+c9di01lOMdFaC5GOu9l0/16ZU/6ttMBJE0IPgjrRBK1nOG9GITbc6pyFjam4xLCVXQ96WW5ls+eIMrIGMDyznd8QWUu2+qZOv2XxKrL6hL1ruvwZ2HXRgL5txwb/YQRkFPzJOLI3GNXn+sCIjfo+IfsYhWuv2mSbqK5uzw1KY6eTNWrirVdTS+7U9mcaDmTH5ZyMzSdld3kYOzX1OShHLXeOJjm7KXZJ6Bz1fIzXUe9wrTQFBgAhzcGdlUjC/0NKQ55/DULQHNSeIIOu4XZRYKI1ycB3anhwnprqROHp2VvRRs0WNgIVbSjqyIYAwJ5CfeEPL1Vg7lndI/uo3BeLz/VKXxFEWk24atyZ1yk/iAwIroOU9qzuSH3d6lffZRX07ldeCyfdos/BkkrKjwQyn55/UTQ0pMWuO9ThH1WGrUd7eEvLEZyigyPZu0kEx1pM6Gc4eBj2MQReAMVP+yLXXVDqoe+5T5F6fXhHxf1r7xqQ8lymfkR0zsM2WzUszr59EpXlyZ/++WR9R31wB/ZsRpXmuUX1sziP53uIfTViGehfgQE1JZycPHvUAVbo0wAn2/HW0rT3lqll3H9Zqcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(91956017)(9686003)(316002)(6506007)(508600001)(71200400001)(110136005)(7696005)(2906002)(52536014)(86362001)(76116006)(186003)(19618925003)(38100700002)(558084003)(33656002)(55016003)(4270600006)(8936002)(66946007)(8676002)(66446008)(66556008)(122000001)(82960400001)(64756008)(66476007)(5660300002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o3vBq/Lmt03sqTC3OFekhbbVrWh07hkD9BaBSoukdOfzO1XBmcMbFmk6n6xA?=
 =?us-ascii?Q?H3SksFRAYRO4uTgTNy9X/Conct31SGC7jBvzMmg/RJWxYbY2XzWV/xPNGKo6?=
 =?us-ascii?Q?izK4LuTZHn5XpRkHnzXQYBBmKlY92kE7RPciehxUtiB5Uid/bJVEwD8Ctwh1?=
 =?us-ascii?Q?bMwHncvCdycQ3X86E2tEIoG1V5j1pb74tRIL8Lor0YjxtGXS+HLQIX90hrMy?=
 =?us-ascii?Q?v6AfKxBcMkYOEli4GBRGzhcuIr0KofN7Q9cFMnMm2PszLKyqqg12L/1Ov7Ak?=
 =?us-ascii?Q?YQGKC2/c4S0LCUCrVIIujT9lJ/W9V3fHmHIdLgWSzpiQpHb0+kXYbLdfsbeM?=
 =?us-ascii?Q?FiiWb/waADYkPU7rz4VWX2t0JnzI0MUw5T4+YvY/oX+b4CpCuqjEeHJYhTmO?=
 =?us-ascii?Q?8z6UXRVwR/g9i8MWuU1qPHbRNdzU1A7NqDHGQtGhJvHFNz3vwao513+Ar7KL?=
 =?us-ascii?Q?gNJTTmA9t1t5P1uGHcqyyG280NjfjpaBBJtDn8G0V6NpmkaDi1I9DmJXvXft?=
 =?us-ascii?Q?QFZi91O9YaO3nvszna4VmL+PeELU9PRKxsEaHrN0GrFCPU5UyeRBG7c36vDi?=
 =?us-ascii?Q?7M6xBm2/0k5BIkLwxn2jTfkRmL+kWVQ8YIMYbHrreLBGnSAJJmgyrMJMlyFH?=
 =?us-ascii?Q?xd/qntjGgz76M3KDAWW2dKlf4pZkGfiITVRG+ub0UQJC8V18a5+fzP57uavK?=
 =?us-ascii?Q?c8UU1DS36fT5jFArZBGp6mf+1sqdOr1o8Wn6882V+Snsqp3IWUTILjFSzsmf?=
 =?us-ascii?Q?p9UrG7FXEH71wnN5B5JZ+Mmg8Yc48+ypEe8c0XlgTcmDHlQaRFmZ0tkAZ2GY?=
 =?us-ascii?Q?TWqkHyUNxbsiV5fqcM6bBDRjkyK49j/i196IJxHQ1Ay8d40GYt1JDFqn1p5o?=
 =?us-ascii?Q?SVO16DrHHFlSA10zflwFMwuqEiXbs3beRyi23F/25atizFMAlfcG5lCcChqa?=
 =?us-ascii?Q?AgP45NBDjdKCZmRKR+0ErS6FR22PL9FAk/4CYJHpjQ6UMLi7LQpX6KXApTYF?=
 =?us-ascii?Q?Gf5YM2MXKysAEwM/aD2J2rqBTYabrDh0z4f2aPri1KFHAPuhLaxewSQjV+el?=
 =?us-ascii?Q?rMHwC+0hIV3kPVjMlYL6sGtRRah/aR1/Fyirwt0iKkOV6D6SkTcg/PAqPE48?=
 =?us-ascii?Q?RaEuKYX/pnOJuZ8EURGHfkFGU/CV3h10NWqk1jh6EZtH349SCyC7/f/e7pc9?=
 =?us-ascii?Q?zp6LQDi1whKrvzIIGMsG7igsXLgBfQwXlRc2ksC8RRezfMC5iq3a1/yOY3sL?=
 =?us-ascii?Q?i3pldLlSq9WPNDRQRogQitVcU4SXGRRhYKDuV9YTw4LVsZbev4dyY6HL8Ie6?=
 =?us-ascii?Q?xKJhQ/fbEcY9n9uG/aP/BfqtlizPj5knTmqa1DFwp7sQovGjaiTGKX58jV/B?=
 =?us-ascii?Q?k9Pq8GBLH8sglreweJ4MuSkq+jsrrDy8FGnDLoYtWKfMPJAMPqXmg3TPY6sH?=
 =?us-ascii?Q?Dhbi7qTvzaTjVwcLc9G2aAYsfSnSgECk9T1F9TvGv4DyS0syyqX4B9apom7U?=
 =?us-ascii?Q?HoskDSa53wsmzV+irH8yPVFkPMDVJVE4RZwVLgx6J1N5YwGJOhZvmH8eIF9C?=
 =?us-ascii?Q?IFhnSEEpgly4agjaHs1hxt9PANIu03SSOsXIW1M4KXRUAeCgv9jXDZSGUrE+?=
 =?us-ascii?Q?TTz3XRj9oVTyVKuur4fREL/Zy2udmG+/rTWfhDBG6NKB0RqahtKFX4lzSvly?=
 =?us-ascii?Q?EbbtD9RA7L7Bvm6ehTO/KmJEpYDhLTig/WYJYGfsrZJBSQABPDezPOpYUcQm?=
 =?us-ascii?Q?G1VkP/cdROory1Q4X3HDhSo6evZzeXE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631d9060-18a7-413e-0e8d-08d9f12955e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 08:50:08.5388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gTM/gGaZejHboTslzsQYJTldjXeB+nP7J6iflgWatG5EL/QrclbcgYUnvFiDvc8wGi1mudl3NEqEmh3d+SBKf4wLtq+SCVcv4PdO4D3wGVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5530
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
