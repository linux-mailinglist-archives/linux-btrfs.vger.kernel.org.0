Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2A9550423
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Jun 2022 13:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiFRLFW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Jun 2022 07:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbiFRLET (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Jun 2022 07:04:19 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2D5193F4
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Jun 2022 04:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655550257; x=1687086257;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Vow32LlVCH3ejlYuFogSZSDlnbxL8L2mBDj+9UjW/KZtdeuIgeh00W4F
   W/tUbDS6cozUJeAnOyZuF5Kh010wYoeB0W5Rg36W4b0aBM4nV/CU1Vdgo
   I9IdYNNl/qm+dYKj6BdDGBWq+EBZ0qGLftCI5HMxBgGIeDyERYL15o0Ua
   3SgqM7f6NWOvQhsMwms4F4jsncc2GeQ4WZEuGII3XA5cbq5vfv63O8BWQ
   blGn9eVdXEsPi7XU9AqnGPIdLQRST76ifhlNjKrsfM41yciz3SjzdOJKx
   68gtc+vkT2P7rfH3KloU2bSE6hPY7998a9/qx1XssmycAGvRWlrV4+PF9
   g==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="208368031"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2022 19:04:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7uXPVi46PttEgXFdACJJd3v7V+SaZ05gXSjanqMmdBBLdvV+TT2MoxmiHV53CV9bi8qQ4ei3etMudl74STWoBaCQCbopCDl1YJAeCdPMD3pBaOwtErHPGdlDEHIMqzkOweK+jXUdTytkF13AtuYi2E4BZRivDcc9clDZi2eFotvTjXSHoQ7pIWPMsEsM/0kVR1Y5BjFGQfqTDZx6RQEQRU0MwBxg3JOGoSBvjxe7CIh6RGHjH7t/bZ1vDxMz/8Ch9zAkWrH3nk6cC9CygTnmFIUXNFyMGLX/LssBg8tQBV0LX+1WDDFbfZCp9NCQd+ygY69EslR8kmC0jw9x3EhJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=gIyLdq1f0tNxq80nPJDglMLzhd0r5ujuG45thVgK9NrfVZtTizPM38AasVy21R2CeKjP5khUnNzBpOAOqdBgJRzwiMiqt6DPTw5tfoILKbYphoG7qpF80Juo50Izi2jz/NMt5TdsJ5p27YfZRVs3MJIB4ml2jGBKLHkOC8CJfDVIe3ohLzSU113lCtN+OUnMwUzyBjyKex+hIl3ObIqLOJE/978QoQZqfgZpDt8NRszzQMXJGdG+NZN+zzJLFhGFmQDVG6x1O898ImMhJMC7tgR+Iui4/80EiFPkO1B/JogGtFi2t5ZDgn5y4/we/NjVxBu3A5Kdycsx1RGmvQEoWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=JL1+leclQDv60k+lKftAoRzdBPyNjheG6cEriykh+rKAdFh9sxxa5n/HoFEcgC4oPugDk699LCSfFSmJgPBXUaci3f5ftJze4VQZxSDJg2AeRJ7B2bQ7WwHbsSbgOSjXo/EhZf/xRzAbD0LM0/f0FB6wiL7CurUImfh6Xyv2uNc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6428.namprd04.prod.outlook.com (2603:10b6:5:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Sat, 18 Jun
 2022 11:04:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d%7]) with mapi id 15.20.5353.018; Sat, 18 Jun 2022
 11:04:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 04/10] btrfs: remove the raid56_parity_write return value
Thread-Topic: [PATCH 04/10] btrfs: remove the raid56_parity_write return value
Thread-Index: AQHYgjGo6mI5FzyDeEWO15q1ri+Euw==
Date:   Sat, 18 Jun 2022 11:04:14 +0000
Message-ID: <PH0PR04MB741613CEA3101D5AA66052049BAE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220617100414.1159680-1-hch@lst.de>
 <20220617100414.1159680-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9a66c97-a92a-4010-78fa-08da511a4825
x-ms-traffictypediagnostic: DM6PR04MB6428:EE_
x-microsoft-antispam-prvs: <DM6PR04MB642854089ED58C80F75C916D9BAE9@DM6PR04MB6428.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HWUw7MZn2VmKt98BuHlbefo+nnOpfLNC8+MxMQHj48yRUbhdyspH6qBRiSFlZFMsRKS8Nr5Xqx4M1IunoUi7s4cCIsIOsQK7gm1tWw5AT0pvW3G2gLaiQOCojfVr1Nw4DRmnGNHB5ZvV0sakrcACgng37gY22gDc7W0aAsVk0WLxUmH+NZHPARGRhVixHVtkm7/L2l7wASEq2673fIsgRpP/jnjka4in286P4lq2Cqrkf04HDC1SFy0Eajg4/ZX146gzO9JrPCrkM8RvegMivuxd/qfkq2s7/ZdrZSQpZd+CwsIZkUFIeikLIZrvf8zXQcKtKoNyo9ERhiVEdOSz+jgG0sdjUb7lS+tieFq+Ze+rzOPWPzyAQZxLAYilnaghHPhxK6DQJwwUD9dq861G5GHF76EkHQGSXqKk0HMfKpo1dIcojIsS9bwXxBEC2kHOlBr5X96JKXCjo7OM8Z/tJ6LWoIUcsmIgwb8OMc91XS274LOl+B+mO8o+xG4UZow/Arx0Wmu5EY4IIa7Tu70xHUCcaIoNxILmKBNia6QigBqu0oKGRBgb37x5+NJjAVzxVPWA/zS5xhkGErTlMwxWFTp8X2blmokUuR5HnkutkHOL5g2YTr1pfelkwu2LHJex+++M22/lUx1pdCRahpGOnxq5/w28QesIQT0SNyiTDwWhDF8J2x/KHolLYEL3lZ92nkooT880f7Of7XIeKmkeng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(186003)(55016003)(8936002)(6506007)(5660300002)(52536014)(7696005)(91956017)(4326008)(66446008)(8676002)(38100700002)(110136005)(316002)(64756008)(66946007)(66556008)(66476007)(76116006)(4270600006)(9686003)(71200400001)(82960400001)(26005)(2906002)(498600001)(122000001)(33656002)(19618925003)(38070700005)(558084003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZH47xIwh/2QDo0uypBl4INmSM/UczfGq4BuSSwwhoK/wZJP/tHjV7KMcOUCg?=
 =?us-ascii?Q?ukK/WfQdtbidV3D9K60qpNJCCUJgWLhQPDIE+Z6cMUUY0tiH1kIRsm+VDUrN?=
 =?us-ascii?Q?JRvoVm6f1aaSAMC4KTU5sD+ddAGmzDgFlOCy5CPi73YKjnGLUixlLqgDUoNX?=
 =?us-ascii?Q?rEdE6LoS/mv7tr0263VRAXw5OhVadC4c4dqx2gcokPcEPQLOJKMNM19OK4A2?=
 =?us-ascii?Q?imMMruGAAAM0kfMokRmuz/TwEdgrsCamvZtR3X/GN8LhgQmWvC50oOxssikR?=
 =?us-ascii?Q?2RkETunVXUcWVWGp4XPK8evZK6seF8P59QL/5UyovBWNn3ce7UzUEmVVuYyM?=
 =?us-ascii?Q?Dp8jINCgFxBPN2+sohAVkdoPs4UjdWGUOvbETdii3JlFWV66FsYLGiaPdt9N?=
 =?us-ascii?Q?NLyAKyHwdjiXF96zSZ6xAnginVPJfRnjJyZqtZ+bJzeT35d/akMY8RlPIgCr?=
 =?us-ascii?Q?BdYO1euhFxu5SYv0IVVqL+aZqY6jv4Cf29jQGz7Cx5BGC83cU0fHPYkw/xuX?=
 =?us-ascii?Q?bVir4gI1YzB2Qv6lOFioZ+WR9Ulnvou51o+OoAWR3jpoO599VFKVA0Z3/pwa?=
 =?us-ascii?Q?lsRb3z8xU3Vo2Ah9LBVLL2n1521NmI/QGe7rBz8dSZ/Ig+vWgi/xd0byusuZ?=
 =?us-ascii?Q?+m+/B6cF+ly1Nu3HA7tWFvMBJyZPZXiWrD0IA61jfpH5KZOq/p8/ND0mD0KI?=
 =?us-ascii?Q?2HX6Fv48JWLOoImNm254WP3eK4u+O6ZQHXAdhczUzq8Wsa4JDPcYIQwTOagc?=
 =?us-ascii?Q?N9i/BWY3pa0enTFgz0WRWYIaTEU+1JxUTQPqzlRb6T2dQj0JjUNrmmHpFCAb?=
 =?us-ascii?Q?SwkfUrj5mZ5ZqTFychZ379ZlX7qkuLFR4VgLMCfTm0PXFo2P/onRfHoXKGlN?=
 =?us-ascii?Q?E+2Fw/M33gT44Pl6frG/1Ke7xxe15zn122yz2WNKc9nebbUAgMGvo/1ha9Ha?=
 =?us-ascii?Q?BTLFc9kg2dMxRgvt8W0s2qzx4e4j81gOwiamaJBn7jYz8c4cNdqUDHYJ5Lc9?=
 =?us-ascii?Q?g4/pWWD8ULPtWfr1MUycgdK93XMBQjCHR+5tECRRjLtxSaogIjMukqedJeNg?=
 =?us-ascii?Q?gAAZ1Nm3/SerFseEiIn3lCmSfMcTYHWT78Lj1zT8YIMt5EgPDv/Awj+GaP6t?=
 =?us-ascii?Q?3PkJhCxWG3oyT0JCImQ6SURxS45jdc0N98RwgL+xbooY+0A+kQgcpE1QL/jr?=
 =?us-ascii?Q?72N7Yx3fduL/1pW9ju731UJKn45bnMerAUo4ne39vH64vg+DMC2kllwvbRu8?=
 =?us-ascii?Q?yMaIzIKLnEYzdzHaDvU8XSidjAKDLGWmeS0dsQ1qaxQLXjoHpzapFYHYxi89?=
 =?us-ascii?Q?3/u4qcZ7VO3EkSCgSqgttzeNiW+aHd1E2rwagqeJvJjcCy79lJE7JlIfHxTP?=
 =?us-ascii?Q?0xa1zF3T4DOBD81e09+2E7bmWUGbkT5+E86F0cFIp4D2k2nwDnPgBdcFhxYk?=
 =?us-ascii?Q?ewG7Rz8kq4v1EchnerjnbqXajfYdNve7lbTtaKnlpK2u1PGbpTPlolcwU0Oh?=
 =?us-ascii?Q?+iFkd0IRqWGghwAuzp2ArJHo15i2YVmVAtfgIYN6HomKc0WA0vw3q5rAgstq?=
 =?us-ascii?Q?0txDk6xT3rZevx6xM8tIq3SoSF9wkkX8/xS22YqHTHRg81pxdnQ9pi9HPoU8?=
 =?us-ascii?Q?9fMCTcoprFm6K0GeNTRdQthahWKIW3tkTVJJymkXSbetHjT6nH7Z2uyxQ7YS?=
 =?us-ascii?Q?5n1S4GymtAoCVU5I7qZUU0DH7talqWpoobeZp6ClfAfuQIPMI2X2NQj2s6xv?=
 =?us-ascii?Q?OLVe+d+0vQQN9OWa5gO0cDuvdfUgSzPgN1Re6DgM4jvo2ul+KFle?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a66c97-a92a-4010-78fa-08da511a4825
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2022 11:04:14.7136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I7tjfxCKlh1eRETzhgo9Y7rMxBKOi6JZFxX/yUaAStvvvRUeQWahwhPjS2lGGD+N8hfrHUxrH7bGqNdt9JtWywa4pVzs075uwVCTMi/Bv0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6428
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
