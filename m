Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748424E6EED
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 08:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353696AbiCYHfF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 03:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353679AbiCYHfD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 03:35:03 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FBF4DF75
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 00:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648193609; x=1679729609;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=cq0jMK0kqGFx20D/y00Xhx42fQcbL7IPjoSlhHRkugQ=;
  b=GyQDGAee3nJFtz8xOcufWLUJMkXT2YjLBiRc5m1n35Ti9/1tLLmOZjl3
   FJeAY38Tfmeaozz3W1/kmPImA9KqXOHgRJH4OtYhfjKEWnW9rT1bh/mfx
   dQAgWnL6cukodbPCAAm8ZDEHQxEcS+Jvxa3P9HNZb8XwEuVqeaZCB7Fgf
   7fr5k3SAolsGt4rNJyfEMHJzs9dFSz0J8nbqARPAATLmp7kwWQxedTRCA
   VEraxMSci7cpV9GwYmgG9Y2z/B/QBT02vrdJ9htCPob/Pw1nOCzs4sRGP
   o4M6SXVgnwBniPNWO/tS09euMg8CP/HyF3j5q2leBPtEw0coshpxGa3WM
   w==;
X-IronPort-AV: E=Sophos;i="5.90,209,1643644800"; 
   d="scan'208";a="195145798"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2022 15:33:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knLmP3o/hvqUA4jzii5ownHY9UFNtg5rMjrN5OOfdE3nMENS6geXP+sPmuMITgBgfgXKtcB/UoH2lVIIJ5P9WmmS/LLank96KAD+6/mUv6xDjfnK5n6pZvTmo7RR3jKPLHDlKH7Sp79Jatk3IYVfpaHk2tX2olwY/4W5EC1twodsK8RTYK4DXtPZvzLN00grhXB9AsqLFvD013zG4daO08pTXzMkVwGKuE1/zZmi2Hd/kU1LtH6PXueVELvoZARfWs0pkxrWBWdkPgCcQ/R1dtL5scq2hB8zmXJu412TrqedP69tTM6O5fRTLizNCAD6hc//C43yuqfQK8os3ATFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cq0jMK0kqGFx20D/y00Xhx42fQcbL7IPjoSlhHRkugQ=;
 b=XNSyw1cAcUjUgjk1F0OeUYoC7sAd1UAc3onjtbJ9zYodP6zqX5BhvcSY22glcrI16YuzLJnJk1enM/+jqvZnjlczz8bQnz/F4KRNWre+iBizIZVKBYqWafuEFH732lM9RZTJLKnE4u2FIvTXiaYDzeh9povewLjmWTuUR8lheGjPX2b+EYoxEbLLsmWD0561i+zdRwddYGw2EH1pWyfsUjCQA0ugOzjUtF3HYFAWp9Ca1q5E3RoWbBLFYkRdt2W8Z5Sb/h28Bi7lSlwkJt2IoHlV0umB05Hl4zOtKU9Ih67rLKRKxIwspBA9cnewGsejwAqLPawVfBP4E9ZQWUSR3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cq0jMK0kqGFx20D/y00Xhx42fQcbL7IPjoSlhHRkugQ=;
 b=kHogXe7rVrOETiU+psYTzrjWCrjjPL0HnqeULhNQM9hnf7jQQoMMDl40nUUvPFT/AG+Th4v+Jk4e7VQPPkXRaYaj2qO4hKTSJ2Yi0dltytjptYyfPl8UOXgpVK957XNAFqoboiy6dNFabc+Ph5s2ncLQYLEjx55lFfg+hT0Tb0I=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB7055.namprd04.prod.outlook.com (2603:10b6:208:1e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 07:33:25 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 07:33:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: remove the zoned/zone_size union in struct
 btrfs_fs_info
Thread-Topic: [PATCH 1/2] btrfs: remove the zoned/zone_size union in struct
 btrfs_fs_info
Thread-Index: AQHYP5/P82+ojoQGYU2KUMU+ijzz3Q==
Date:   Fri, 25 Mar 2022 07:33:25 +0000
Message-ID: <PH0PR04MB741622755155D80EAF5CCAC29B1A9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220324165210.1586851-1-hch@lst.de>
 <20220324165210.1586851-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4edde6eb-91ab-4507-8ba2-08da0e31bf98
x-ms-traffictypediagnostic: MN2PR04MB7055:EE_
x-microsoft-antispam-prvs: <MN2PR04MB705549268828DB1C733A48FA9B1A9@MN2PR04MB7055.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bf5GoGwU7Xae8ow3548N1qMEiCQwishiGI1ETsxnHE0Es5YXQx7+Atgn0OUN0RNvvC2ZdPIWKffvas7vzbVOA9wFMKPW24nJuEmhUo3rx4MXkHSzD5Urt1t8hcp+7+iBAwaJljvplyZ0op9BtsplhruPjV5Gj7w6vmJ2TXLG85L5a8iadYDw5vumT5bSitFsfX6wSKpYVgD6gk2NuBmog5l+fKLScjMQMi7vYEmlGvL7Q5GzRkCP0RsW3TDwy92IZammSRc7gIy50mbhBFKKdqL2bUjgpMDcoF58Svg/e6q/rytANHXr5Y8hiYBpiKKDh5Bi2IS7IvdZjsV0uXqqFG7fDRlS16zXjs66dCDez3NMw7HukGPcho45jpuNscdadp7VI3bXPU07+cdouClPzJRIzu61uBWa8BsBkjCHdDUR5EY/T1ubUzJ0kwdY586++ep0zYjdZXYiYLdbp0gwsSc36WFIHJXxMwSi24m5vpFSrFHe5cMdEwkB2BqSPJGuDG48A9KhJrSSM3XrHwQvG0I6vupIfYjwFTSkBNdzvavndzy2Ka/1vGdDYNUzxyvEVdKUBig/nx014Td0yNPcxWS1kVZuU9B0Bthc5+36vzWHTFEa1q3AfNMLJv5celywgWVc+VIaxIsevAJ/D4m1Y717Z3nPEH2wuT6oVw8tqJuzWXM7oXIwv+YIVW6EpdtCcLhIUodyfmft9YTm7sjblw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(2906002)(558084003)(71200400001)(7696005)(26005)(186003)(33656002)(83380400001)(9686003)(86362001)(82960400001)(38070700005)(122000001)(38100700002)(55016003)(5660300002)(4326008)(66476007)(66556008)(66946007)(8936002)(8676002)(76116006)(66446008)(110136005)(52536014)(6636002)(316002)(508600001)(91956017)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s0hdmyJiG34wMpopXSZiOpTUaxHf4ZUa7DLgeyOV1UVb8Q3NC4LmrbGgfNcl?=
 =?us-ascii?Q?l5B0OiOHogqh3wYnwyGEGiquDoglRGO5F0rQtvSij7jHkMHuN9NneM29zZlp?=
 =?us-ascii?Q?yGupTKBbTnLYaLt8QAsp1qbNFzga2uF0Np0ipbar4Rry8hpQkXXlFXTD2ipb?=
 =?us-ascii?Q?tAVwsaySU1FeVEAJMQQXAkGNTZMFSpT8AWAnND3jK5EyRYBs9qnN61vTD+Bn?=
 =?us-ascii?Q?fIvzI8lMT9nsKqzDlaO2QTyPb+7PQV3jm1UkUDQ2BP9U1VKbkoo8Dx8JWszw?=
 =?us-ascii?Q?n8Dgx3vqU0Q49cAWejthjeo5lIdjv1bTIC95mmO9ZwJhQy7qzT5U5XK4Pb9Y?=
 =?us-ascii?Q?RcDCfjJzCgNa4BVWO5BK2ceb1nxYWYm2WVpBakoQlvfZViQRZL9SeOEnYYWf?=
 =?us-ascii?Q?87kTC6uyK8BaorwY3js/F1AT+7XkVWe56U++kngyQlLuOL6DdmrbVAId1aVM?=
 =?us-ascii?Q?/yoTx/7BQfvLag7sh7q+hj+2g2mnX4OLgquntinu8UYzg/XmY5YzG8Temcq3?=
 =?us-ascii?Q?ODPNwYFhA9Wzdad5o8cOE/zZ1/SRtkMcWhiqZyjDOTd1U/Y3EQmyN5P0CcLS?=
 =?us-ascii?Q?Mn+BlFeLBntTmdEjfniK6fjhO+hqOYNUMlhDsUeuUeA0u1xF+rY2N0FTIkEE?=
 =?us-ascii?Q?ai1rhKuCa6aImi7vttasLzeviLKNYBkR53yOpz3y1fdbLu9PncLeLnqmJ0oL?=
 =?us-ascii?Q?JYvlnRDD6S/AgEUJMBiGvy8Mewz8wrZrpp03OJGfAY1kC9NDDcaQH86jLLpG?=
 =?us-ascii?Q?Tomg80BLV3+Sj4i7AOHiaosrCgZ2j1el1ailQlM0y4Hor4l2M0HEktSuSJjn?=
 =?us-ascii?Q?KqZuSIL3Tm7VvdltUFEegDt3o8PnJBj4B2I2yJerMkV3Hjbk4m2HNbDwyWUu?=
 =?us-ascii?Q?GHmSGoP1buGh3U8CJGdXg5lkNLKWXFHYcjgjL7jIQP++QVWuj4OIsMsxhL3L?=
 =?us-ascii?Q?3ePxYquwPJJ5Yz1SAuxTTDnF5aCuo8B+v3sB7cr28qAf3wRcT9QnYkVtSmCY?=
 =?us-ascii?Q?vXn7GVV2BiwuZBhwj7kXRebkYVVLIZaoZztdelinDfwZstNlrx1vPCanNbKN?=
 =?us-ascii?Q?Oj/etCwHyUFwZ57veSlyXG1bMgXVa+5bHjIrs9MbiqFderJ6WpanPs4war69?=
 =?us-ascii?Q?Dhe5ssfXY0reU2cnoAgObN3uQ7zehvDHmPy6EnXprqHoS7toNj0cQv3FZxzO?=
 =?us-ascii?Q?dC49QGdULR0CyswRXJJgAeONeAINQLvC6wj87xKtVI5WyZ6IUhTlo2Ke8/Fk?=
 =?us-ascii?Q?TFK932eNzc9uYMUEdrIcL0WpepM5+qLLvLG8G33N95DlQKZsX+uQXLG3CKrp?=
 =?us-ascii?Q?0r1VaQ7NhAJ5yAY1ccnSpaDamCG/exqQ+DW7eUCUSxoDgKQ8lJq1XZCQWkEe?=
 =?us-ascii?Q?Wcf53OtezJLmmKhESlbRONFqZ7iVBi1ZG88uH1RNAB4cbgecyi97XjMV/i5E?=
 =?us-ascii?Q?Ew8pgCgIMPQQ1m4zEoq/NfiBhUev3VRTkvYZF5D3uarV40rpQ1TqeXCwUgDE?=
 =?us-ascii?Q?KkfiwggD1mF8HiM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4edde6eb-91ab-4507-8ba2-08da0e31bf98
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 07:33:25.6041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ETyihfQaNBqmCh2YBtKMmjgV84UMd5w9oJm5rNaQNyr4lIc14wV2YLZst7ljEg1Krf0wkJEamx3v5VHTrBw9CE2gm1DAU4C22oiRdi4zeHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7055
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fine by me, but it was explicitly requested to be this way IIRC.=0A=
=0A=
Anyways,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
