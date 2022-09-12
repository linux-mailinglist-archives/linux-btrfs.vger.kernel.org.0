Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3CC5B5D17
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 17:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiILP2d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 11:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiILP2b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 11:28:31 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934472496B
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662996510; x=1694532510;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=hDYThWu3b4BB/0dJ9MMQu/SeZgXzCYn2a9CLsrTWziaLrfad2vgx0EV+
   WgNmzlR5+ajqNjYhV/cK+Y6QHXYoLKPR4QwHNVBmrBlpyeLadV5gpmOyW
   KXDwAmX9c/xMPytqrSa+/WCemdP7eZM8UUSzW30surR5tv0IO1VER1kV6
   JicVBWmhfJJMeb+1udYKUzC4OhUqb8y6sR2eczh/itLts2UpZn6UY+r6Z
   aja1tfVHfD390EhzIjffE9/lXxdmrWDiDyStPivrBScaD4E1/RMEIaQQM
   HAf7rcePIQpWPldQWaEX3TnhWlAP7LuPXXNMg4XFN6ob7wojArYCO5bd5
   A==;
X-IronPort-AV: E=Sophos;i="5.93,310,1654531200"; 
   d="scan'208";a="315418688"
Received: from mail-dm3nam02lp2047.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2022 23:28:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FU/2QbwMo9AoRZhFlytzjGxO2SIjdXwh1yOb9zAgsZNjtpYBN+rjkov3cOlIg7KdWgK8Qjt9EBhSeozSYsb4VQrRvhE5nGI0zC65+yTajHQJ/t2qmzmjFKG1d/80ZI1ZYjCZTaVZh5uK8a4ySWJ1wGpK5hrFBzKARSk+0iW4vskFaHGGXwZ5Ldq9DMopvMzz6mFzuVmvUpWUVCEKsjL2blSru8P27zMmwRnEv9KEwn3Vnv72DymyrLWR6qmOb47x/xIGj/baJyRaFIYWvouLSAMpSe2PJ3WIswUmJZ5FBmN8QZOgqDvMQ1sKeedHID8LcH9HNyGLJ+6MpJOaQZWlfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=RkU2tNwY0lsEcckSnwzExMH+CF0EvmT27nsnvKBo4T2cOg/fwTV3uzagAqR1QHc4GTrxqp66cd2iYOUvxImOM12rkUvou+aa/v9Xhzt8kHChoEemzbOLVhLB8Rx9EkHaDULXhvY8GDq0rcbi1Yn8kVJTR6VyhdXN9+CW9lEus4NLIOzZq9AxIU+2mqsEt2ar9sGk9YBGfpjX5ii/OAJDdME29yueTl8EX0vSde/C0P1mIb8fOpZAbl2Io56/qLTJDRuI3la5OwUXJTJlkUbz8DaCbgicFCAoSLZF6PHkG/yi/AZGe6rzXHV2boB4n9qBAU7nOHO/MppHbwk4PMwySg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=RPPhaXmT90zE7voCmvpojI0EtLOg1HbhBnw8kwP94ppZfBqd9HAs7rXpon9zJvq3zrPhGuon4mrIvg7hhJdl3BMATIC2dYjrrOxvBWa4k4ZuXtI8zm6TActRaRijPJW3PI2FCmriKjnrorNYJQwEPkyWtKtXq/T92o7gDLfH9nU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5465.namprd04.prod.outlook.com (2603:10b6:5:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 15:28:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 15:28:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: move repair_io_failure to bio.c
Thread-Topic: [PATCH 2/2] btrfs: move repair_io_failure to bio.c
Thread-Index: AQHYxrGXToj5/3Wa60enLCpVej27Hg==
Date:   Mon, 12 Sep 2022 15:28:15 +0000
Message-ID: <PH0PR04MB74164A15569BF589775F17819B449@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220912141121.3744931-1-hch@lst.de>
 <20220912141121.3744931-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB5465:EE_
x-ms-office365-filtering-correlation-id: 4fbdf89f-a93c-4c25-5f42-08da94d36985
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2M12VulMxG5bqoI/k2pB8GY/ETmRWIQnFsoEEUHQJJbOh747dYinAYrMeBtmPMU5k8cQKF4Rq8TYXNXVUu4sfA2EfOjibJgl1ZoSejmfdzlV4fZowkRABdsMR8eDluyVQaLvhpYPXK623cL9mRzkvuBInY+S2p3H9lIkUeotjmc97EJxjEnyktP+L/7pJuyOyLvoLejpPd9CzBvmf4s8glfQEjKIOxXljYBqRJf6IG+oALCKa1QDD18lpvcTyy+1AN+/GEajutcdV92X1u/PdT3bYPprqDOCHPfo0jwEts0pkq+Zg8binjktgflkbX1qhP90T8dbj2kFKUT3WHvefgIL2FWhrLhcO6+55yU8h3oZktRfAeA2UOT+WYpobLq4UTc4o1hw07aIpHDk3KRAtWieloXpN89PnAJKtHny9WjsnIWJsf/PAwBGCun7YGsTcYMNcG2x8qa2aZvUxFLSOU7dFszrmE4D2aTazL15E50XB8Hh7Jfe7nFVP58jPsO2xWHlU3SoFnjRGf1wuklh3OmVjsmOqYameMFcc3JJIVkP6BW5fYUL2cwzKOsfTd3q503La9jf5YATfLmY7P9fFxhOW9FbL+ZUXrGH59+AP/1L79FjQlSWym3MNv+bLW9m+DvuEUpXeWs6S0IM++ut9ZkSNIq0uDaOx4lujeKDu21C+Sx86bckFdFr/f5IW7u68M9VNILk2DwwgKjHfM6iZeYm+Ir1lyJ0B0JWPrnvFucn9XDobR/dYKMHS105F3oA1HbYfyVQXuGyYU+LfgSncA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(19618925003)(33656002)(122000001)(86362001)(38100700002)(82960400001)(55016003)(6506007)(66556008)(38070700005)(186003)(110136005)(4270600006)(54906003)(558084003)(71200400001)(4326008)(7696005)(9686003)(478600001)(2906002)(316002)(8936002)(52536014)(5660300002)(41300700001)(91956017)(8676002)(66446008)(76116006)(66946007)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Odh0EP1lbP8m3AoYY1LZ8VRQJ55Fqfzd2R+ZDqWefgFD8/+3Mo1Dd1oLygKs?=
 =?us-ascii?Q?LW2LKyB5gkgJLI6xGD35dK7gX9tMGcVNmAMAVeSDAYP0mUq666R8RoT74t0v?=
 =?us-ascii?Q?MpQQCyAkEgzqngaWvgoHo9GFrfiKATDkf1b/8azVZVddGln3WtVH1kWtayDH?=
 =?us-ascii?Q?+MbDL0QEkNO1gS/arKMnC8T6HMbCBWjYi0sBB+t2Bn0qgvYoZPpv1eXNAP5W?=
 =?us-ascii?Q?Owc+wGxqsfDQqVyYkx4OkcAnx5SLIt3ZBAZQVKbt/NTuGQXZiSWcOqpXOjS6?=
 =?us-ascii?Q?2ZHvW9L3U4l+g3+5V/3Q+CnNKF+r+8HIOTtZjCa6v8AUNrIALkGKZBLDDMb+?=
 =?us-ascii?Q?fe4bT/FKpQ3MHBbPMeXc/sJorbFx/u2bE6f8Ue+6P7Xqpp7t0K4m1vVsC0PD?=
 =?us-ascii?Q?QdJ8bxNzEo25mSYuMuX6S+hzkvf3x8I5DjGC9asw8OmfmozYTAY4w3gfz2JV?=
 =?us-ascii?Q?yVf+0Yfq84QHqURLZ4Gc97890hRM8QwBeVQF5BeiIoeG9U8m25ttRSwW9WuY?=
 =?us-ascii?Q?iGCviGI5wwTfqRa63xfyNntLck48Yb03fMg3zE14waBNfn0kWWr3GRvIbSOH?=
 =?us-ascii?Q?LlKQPENnUAOZwM4RJR0Gpss4Nd1DJoAyyxke95oCTKizZEtqqR8bzJL0x+EJ?=
 =?us-ascii?Q?qu1OUXlI9eARHfxd2TA/PHyxhML7zHih6AaEYFZW/oGbQ3sKYjsJPphwc29t?=
 =?us-ascii?Q?YssHaZuvCCB0+sRyS0CcMqyJiG05fbiZJqkJnAZzxHU1UeOzUeyrBfNoVQ6y?=
 =?us-ascii?Q?bSV8TpqrXbiofqxbz65TvG5+uU3mKLmgT50nNw5RoRVx3AyPl55w1rJi+E6+?=
 =?us-ascii?Q?xEMyJll3+P/C9ei8gGjGGPZJ32WIOc7bqGN8YnKsl8ucf+3wl/njg8Rv2dgt?=
 =?us-ascii?Q?dnZ1lySFTMTsxdfworxVrp5SJ8JmHiJNFPfNkziA44rm/t1oJjzVnBEvE8ks?=
 =?us-ascii?Q?sy6TglyRI2mvAPh0qzQ6qZn/yAqCJvSmq3mVnpBUE/2ayZ8oq5/uCAYpX0Se?=
 =?us-ascii?Q?ltLh5OhfTnYCMVZGbOE+lD2hzmLdYd1jnn0g0bAcqGKNrmemXVHH3E5o9Aw3?=
 =?us-ascii?Q?X/BpNdhrZpy880otPp45hG3s77jnHY5x5iMIOM1JhTeAMGSCLL+AIK7j279V?=
 =?us-ascii?Q?gVirW9tLlQXZwyJTb8Z9Dsy0357BZbMI0LMo2mRd5mNZGHtJ1wORZyEbAnSC?=
 =?us-ascii?Q?VmvODHBrKkaQN6N9Z9YmDF7MTzg4Dqve8JVFxyjGEIJ3JSaTKy+IVzcEnJzZ?=
 =?us-ascii?Q?xphY5yy0ca8Dp35XQSJKlnNSoNglMfKZV8LycD5qO76jz0Y0ewzb9k2/4wTt?=
 =?us-ascii?Q?vPK/aTOZa6R4q7ICkjHu8R1QPuyEWivHZAwBznzF5GFyt3HK6ndS7IKNjiMd?=
 =?us-ascii?Q?cddb0QJGWX0KvvFd4CE8X0iNhjnd0l/h7fmDaPbkyi/s520k6icALVKayOVm?=
 =?us-ascii?Q?n5jrmuMbvGqDnJWzmPSyxhS4jwNi1CYsUeSadJve3KlsiGOTvPxg3g1M4BW2?=
 =?us-ascii?Q?LWsd3d9QCrn69TwxjuqifQu6dH0tcTwyPSu3Ngc4HuG/jdFDxeW6NuMqv8J0?=
 =?us-ascii?Q?rtulCW8xoeeeumANr6OCNQSMxAqrxfqVMUlkXmtgbMMbt09MdYx1M/BuYVO7?=
 =?us-ascii?Q?RAjNTDlZWRR5dDscjO+NWS2SOZL5WhfxS7OlsHeH8avG6VnB69Wvj3DtAw3J?=
 =?us-ascii?Q?cIeKxPJetGyFzNKQZiSrQO5OoMM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbdf89f-a93c-4c25-5f42-08da94d36985
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 15:28:15.5392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wzwxJo0MACDYeJtMl9e9VsVV+CdPCcoeTEHHe/lZEprGlcQaOd0k8vyrkT6HBmFbU5z1v7M4j9hS+2Bu5XJN78jgthLprdDCXgq5WDvsMbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5465
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
