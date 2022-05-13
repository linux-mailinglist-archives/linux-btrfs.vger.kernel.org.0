Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0A5525E49
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 11:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378590AbiEMIre (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 04:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378596AbiEMIra (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 04:47:30 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2738613C4F9
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 01:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652431647; x=1683967647;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=DmCBjx62LncsIlKMkEX8avdT7Ecz8O/B7QCUsg92cyt8nKk5giRXj0np
   Wan7biO7KXFDZ8GDqWzD8V8sTq8C2Q0haNi24zSXM3+uW1Hcf59q2SEuT
   jKqGwUxJ4jvldODBn4lZ9hOj1SS8RYqqIgbZahSdDRL8jadr39KMVhRUG
   qDRIzJebNPq4U/aY7ySZHCUrD5P7vM4ds+uh7dqISyByH2wgVeb7gvVlL
   hRAbY2U2nGkN3oRwYuC3+LWRbiphR/aT469dDsUPL79aSLRyHYoZkJhCz
   ujw1bt3mMMmSrieh3mnNuOJBt5eEVGp/c0kB/0PdohZ/yFDoxp56kWyS8
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,221,1647273600"; 
   d="scan'208";a="312228221"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2022 16:47:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRUBVfy40Nh6G+39JxVlvt/o7LhBeAlS1H0TsDrfFpoGPVSTNBYgP8d63q3KEqgNfxt+YsmNNvUjTPLF5FrQ8UyPqH4vjjW9VyxuWifIvcuwsJgaU4cLzlN3HZfOdYBR4/BQyJKyqnD8f1azkBxZAkzjcy20d1SEwER+XGXBapL1nXkDNSHNA9SvU4VMebF5bv+QPLNGf7qrQeJ1glVS8/6HBAI+PoYfyIM6KTGtQDkNoKJjjOuUgVIoe10JNXqmk+UxBSNhJXIE+WnVXc/QJc7EMfxuZg0YUnGB1z0pHGMjTn7BTEDCVc0kNDJiaRmDQ2jPT9XdTzYVDeAYU0Z4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=WbnRiKtK5A3ABya6zGmUY75bncBh+zLuYDoNaJZN6utfgswDPaKXiFWaRUoQ5/BQFp6Q19sh8e8wwHMDCSKQfGZ0C83AxcmPES2S+XMmBeSeBaHKUjKJ44fJn0F1hafr8dg08CPagbt3uKF7KQ0+RWBmNs9qbrg8JMOoj8UTc7h70LtTZR2LxCIWUbjk5V841y+7z+Hz6ohPKhKPaxsFTD8t6EhOTdIT0dvo7tP6Ezv2FvT6R55M8mMTdxEAvo/d8ZhBfW1hEgDIKPTroRGEuhyTCUnqcy8c+u0/nj3euIpqNtLy9SgsaXb1nM1a1iIeWoi1xZ5aiD4WgRxWAa4CSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=uDJahaMCYYMFniT1YBy74YkSCqm2s2k9PDvDCEY9dhvFM/A5QkM1JsR5SABkiGuZxcVDksOZZVvBPyq77G2sYCjKG4+F2+5HUp5mVgxApqEPmyPJQvAC4vqmD5mPnHcTyjeY8RvbUKQyBJQVTcyKFHJUolkLxO+kpIdFI21bk2I=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6743.namprd04.prod.outlook.com (2603:10b6:610:9f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 08:47:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.015; Fri, 13 May 2022
 08:47:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/4] btrfs: remove @dev_extent_len argument from
 scrub_stripe() function
Thread-Topic: [PATCH 1/4] btrfs: remove @dev_extent_len argument from
 scrub_stripe() function
Thread-Index: AQHYZqRPljGKcxHW10uYdvpUodJwJQ==
Date:   Fri, 13 May 2022 08:47:23 +0000
Message-ID: <PH0PR04MB74162CBCE1BE1C883632DB389BCA9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652428644.git.wqu@suse.com>
 <550645c92bf0b903b98d6bea5a779b30dc4a6793.1652428644.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d0b3925-661a-42c2-c75a-08da34bd32f7
x-ms-traffictypediagnostic: CH2PR04MB6743:EE_
x-microsoft-antispam-prvs: <CH2PR04MB674326BDA7F75A585CC1D5A09BCA9@CH2PR04MB6743.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WmnLanQtIuyv0VK1xFftxhRVEYvlq/pp/uIB1YEbDhQUAZ8Mxak7Bw4j+zGI81FUgeBrX82iEW0kur0B5+DwDGOcMxgoc1/v2wQ4FQyw5u3iDH7amInNU8wKIj7kIDuOUqgRz0jLofX4oxFL/r60lxDyjaU6/lqwaAv1QE02njKRYFY9uuTE9fCMMqpVnlfhrabcNXBTmZRDRGOAWUFoqx0zwXvjsbTWZS0o55IP2cADiZKoVJVNJcFInHpIlmqcOomki2fcidrkta499hjhyWGSCfWjBW0Ea8eQSH38vwXUuLJxg3RZqEvNu7l3MykjLZ3OrMZYuRm8q4A+XGCpVJA8ipJMEkTVFPFiYyQDHYxm8b5LO6EKqRk4L9TL2Wtv2cvVWX7QJrXQbXRBxCgDE1dsZyIEcH0c4L02k5+vsQK8uDhAl9djX8JUbSozFbmovJ+0fSYbGca/t68TS34X4Jf/D93O2+c0/tjwyQo20kw/K5fuuCt+qLts8gQqII/rnoOtSYWDgbaEsG9XnpOC1bDbcmGRoJlHB5EAU5HH4sTodtKWFd2okxrFxgLvmHbnuHebmqVCHliwMhWzIbLTgXkJYkGf8Rwik5YlOkIRlQKPqs3OMxyJlbWr4uNBJoWJE6rBjXGh+QpXU6GkksEHe5AazJK4fN9vel1jKWT7dJ1KfmV0v7PMA4QjoMSFf4DIh4tWifnjbcRmzNi90L5gVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(86362001)(8676002)(110136005)(316002)(91956017)(66446008)(64756008)(38070700005)(66556008)(66476007)(66946007)(508600001)(82960400001)(71200400001)(122000001)(38100700002)(186003)(33656002)(9686003)(7696005)(6506007)(26005)(4270600006)(19618925003)(52536014)(55016003)(558084003)(5660300002)(8936002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6EV5/qUpKTX9vih8QwpKtvjgXJhLCSb9rdzFdHl28848PXA/2Tgogc+p5tub?=
 =?us-ascii?Q?3OPKyAtC/4F4NcGWEw1M9kFP0wCWxJrWDTNxNEi1SYl2zm9lShHQmrqHWGES?=
 =?us-ascii?Q?XltR5Czgbjb3tie5SLS5kY4I3mflYaL8BU3CD7Df+irmcy5wMrds0eRHSg2K?=
 =?us-ascii?Q?ifhmKSmI2g7bhSgFNYSXEz7oKho2oLuD8JSwaD19/o+tTEBF5+7vIfi7MBCg?=
 =?us-ascii?Q?/jQuMqCtM0Tw7lIPN5ILHaMCue7jVFSKG3v5e22spV4q1hvSL1GC6drg/h7a?=
 =?us-ascii?Q?Q58OHOziE+TkSPm/cI5v4oeG4tKH+JztOzZVudbqpKWo8w0QEgMznLRbrZEF?=
 =?us-ascii?Q?XQJa808/tglZ1wdCEdp0NpFRX1AnImSzKTCybBXT9Vep1yUkb/wD3VPsT36P?=
 =?us-ascii?Q?TMDD/kRHgNbdYPO98ansa+BuROzJ43NDIbeIDtFwmkEzErhWGIsbq8nWaDYd?=
 =?us-ascii?Q?eloAD63snAJJle08lJ4MZOsLE5wyscLOM8lveeWoXdTPi+Q2PSxLPgST+piR?=
 =?us-ascii?Q?FR1yaaGQNZpneWddr8HESYIOSgBTU7STFS+RnP9Ov1c7J26U/q3qmhBzNyPj?=
 =?us-ascii?Q?8DVytWhefrdylS2bB0eV+z6Wa88dyV+6UvuucRZjS/ffFNhI2axWVT0D5O97?=
 =?us-ascii?Q?NIbh7pNsWeFVyG/HeSBgMqoOHywPfz8qFPGWAI2QuRSLOYZTLVf957R/SpRs?=
 =?us-ascii?Q?U49+Z37n9RSKQVAyWZLoo21/rPVJi/MVnC+4VKUsXsKnSE3em7TVFE91VjpY?=
 =?us-ascii?Q?vq9cCVrCMPKG3RZ/rGf35EDlWqd+zaAKQM+uiuOrw0UzkSCE9NPcMqToeXN3?=
 =?us-ascii?Q?Sc0OmIP3yLzNNnJcFSWBrc15aE+jPp1zqSpjiudekzW5anMe1z/yIlyZcWMn?=
 =?us-ascii?Q?h5XDvP0ivlhTZpuQlmVCn4HHH4ZGz+RU1N+fxel79PUJgRvmgzBI7ClVI36c?=
 =?us-ascii?Q?avi0cOYsUJ3EEScFPmq6WvI9+IvbGn5BDcF4aV4fw8/KCaO1awDOknEVUkPB?=
 =?us-ascii?Q?9LX9fdSFYmnCbOY3UJrM2I6GzOrd1A2tkx7QOovlcqQw0y+xOnn3DbCfFLCO?=
 =?us-ascii?Q?Gl8QBaygeYowU/JR+FIfP03eAjhSgLcfPh5r2eN495GNa9qvXJywt2LuFjvg?=
 =?us-ascii?Q?QpfO0IKEqBePdFICNcmyfslVumyWCe8Eevnv+zKQsDKN4tfFjZuWaWHpM3Bx?=
 =?us-ascii?Q?ioQJu2Vcba6o7xj/SdGcCi+FNGboF/s/shW/2nLR936oCpthBBbadW1ztMdG?=
 =?us-ascii?Q?zCENFw72gwftE57nX4L8trhixb2VIEHXk69eugD2KjGNcCnaDbiBUuSfjkJ3?=
 =?us-ascii?Q?7d0UXPaOMS7lex3ty0m3xt/26fCe+uYG1TKXwS9imOEP7ZHd8gHd00xuvyr4?=
 =?us-ascii?Q?YrQomICmAI1hFT1vAVG+vwpdqPZblDWxmPM3lyGfkuDfQrNaqjjphg02lPiw?=
 =?us-ascii?Q?M7fl1f21pBnEV8+h5Az9o3T+SRkeaD82tiGBzdR+BDoDzFoLICj8DrL2eH6r?=
 =?us-ascii?Q?ykniT6G78+8fmrGKGwYIDc2RY8s4rd+58op5fOUzr00cqcXHZz9mT4ZjffaV?=
 =?us-ascii?Q?UN5Xz9I/2twgorVFRglh5p7nq2+Em8KlDfUP/+z0uvMaDgRDglCe8C7AHS3H?=
 =?us-ascii?Q?iXjY4EAMbdJLB42J5VGCuDl/YN8u9nVwJkXVd0tgnUPkk81UH7+6wY65OHxG?=
 =?us-ascii?Q?SBbJpTjHtDu9sWFGrIQXn8SU1TJKpHGffNIOP3sAxejKa3ipmT/+7oT5mvyS?=
 =?us-ascii?Q?coswyadP3nHeYPVJuYQpb8kJQxbdHQQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0b3925-661a-42c2-c75a-08da34bd32f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 08:47:23.4752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2wJ9J3f8GN9ml9wK/Q1xQId8ylSyuc5x9EwLF7RqTXwB3rKW/lch27DSO5FHPK8871m2PX3if781gBM+owgvkn1ZMsP1vqsrdLEH6Hn9DdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6743
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
