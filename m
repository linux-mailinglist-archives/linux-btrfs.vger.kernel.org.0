Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B93550660E
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 09:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349460AbiDSHkq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 03:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349470AbiDSHkp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 03:40:45 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB59A237C3
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 00:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650353883; x=1681889883;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=gRqLnulKItekAafU+/Me+YsDqZPkqXte/jedOxg9H6bw1tfjxpJ4HsX3
   0x1UySaWb82ga9dHCWkmb5qTXmc8co8Y59mdCNbXTZAAsoTdnLx6epY4t
   TC1ifw1oUUqkCi1afrFWC2/rCJBB3YKXUzLyycbHYfY7VnFeKSudrKTSH
   BflXQkOdAXhliSIyMjv7dUffl4R1Bsfr4WI8s7aEAbcXdltaoqJIgcqeb
   f57S85rIiiC80ZkLO1QS7ybBQc99G7Dg1qfYiHce3orbINiBSXLOGWO2N
   BR3sn2iu/sjStACYwje+ZZO62SQrTUr/cMUTBUQuiJ/ShTjnlHU33WeiR
   g==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643644800"; 
   d="scan'208";a="310211724"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2022 15:38:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gShSLZjgAQvfRX47Il04o1MTZCMv7mm96nSd/Efd6Yf28M1d22yCDH+KDDXyEcoUg6Dc0AwBBKBa/3zJLImcmYPmEDt+MMnc/0M5eYkbf6ZXYsDJJvb+iMR94G+7OgXyaGGbIKpn7R2uzTpsKJFYeC5eq1ngPlxNAn3G55SUhc5gU64glQg87vseQXstumQkeGKr7bEXiDJxF8qM8ZYucQpe3WsKCX2pmwbM8f56JZpHj4xHk2zhbyEbT/cj/yikFWVOf1aEZtbjupR9DAZjCKyiu0seL+BoGrUX3klRsHOVZ4tUK+wSOanVcVGkoviJ0oxu+nOgTZJ+ztYvGFVanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=gFLlZYEd7j5Zu9xaMl5xWMTK+rPYfiBTmPQtNrCgLl4kkptebCz+hQ4aUuQmyApl+z+qJY0dfJhbuk9/39txDTT/9jA6+4nAr9NkxNb4VH/haXYjdGot16hhqapN/F4FGYP9vP7cDMVwJ57m8NliwB9DZky60Ptst7Sy+OUMPWDJIcnu2RIr1TT/Pf15aB8P2hRttiHRHzI42fXu9tBype75py9dsOsIzC8NHeQeLUFzmtfZzbqr2wQaMzOlg4HaQmUmRjOplX8AfQuKhzKFWVZ97lX6yU3Xt/CXif5vGpdKcOPU/a+RfwGORULizNrXYoAoD4Wk3jod9aCkfOgbFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=a08PGVtySwgYbc3HEy64qnRD0lbtRs9pJWP7623xi8IrrRUFcGon1GNYf1RTMhEbH54Z+q+O4Qd77kqdJAFVMqHjnPKxfTZ6DeWq2uE7QdTFH5ecZHDZt/ukc33as6T4uOqcoC67+1SupKPZzFK7KWUQ8N0kHL29yOg8QdoyXvs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6276.namprd04.prod.outlook.com (2603:10b6:408:7d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Tue, 19 Apr
 2022 07:38:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5164.026; Tue, 19 Apr 2022
 07:38:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: use dedicated lock for data relocation
Thread-Topic: [PATCH] btrfs: zoned: use dedicated lock for data relocation
Thread-Index: AQHYUvQO7L0hp9LvkkaunZOFkOdDPQ==
Date:   Tue, 19 Apr 2022 07:38:00 +0000
Message-ID: <PH0PR04MB7416A75C88F9475337D74C5B9BF29@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <4ebda439981990cd5903e4fba19f199b4eb36fba.1650266002.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcb4cd21-929e-4e57-5869-08da21d787e8
x-ms-traffictypediagnostic: BN8PR04MB6276:EE_
x-microsoft-antispam-prvs: <BN8PR04MB6276C136FCDBE78BA7DBC68C9BF29@BN8PR04MB6276.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WGc8RiMLThom/eias3ubI1PLnsbGoIzVoL+QaMfiWXSxURY+tYzhyHSkUYcLvCLgHlI58upZ6ydrlLM3GCm4XICfbCSioKaAgvv3TrljNfNqmeGrkVEzk/dyn+yofAlDBDAtIIuqLh4tmDDyfOi2Can7Yb0HpQmd4UVHNmlBKe1SyK5nbDoW8f4TgDSxiTKeTs1VS/F9gBY+EEEYOdN5crUNrswa+N+ru4GyFX0U3WbW3YooUIo9hDkVNljTG0IGNShBM8xsAokxwMTWNjZleU2xtwrC5BxdSaco4mGXApKpnMAamSl3RhEhhHmh/CSk5kRJPZhkQ2FmPEezTBzcyThSMOJ+jVJ9DM/VySmM2SHpPXCeqcYjk1C3Dc3PA95BHixaZy2xwf/6exsgfhPMFSjegLUHjpFhBqjRJO5PQwzw1vI4aOmnQ3vI9iNR6I5tjLjYcPQ7slfP/ah3rJoZ7fnjjeGVRhnepz7hDG/VoGcySJ9erNIS0srA7vmgzxcyf0icZfKOWd6O32si/yuNjD7a3KgCAB+o4OjsIK6teCC0+rNREd4GG0Gx44bdXV1lNh7hOaCOadGU2OR9PTP27TzCawUjiB+sz7BK4knoK/JlN9tI0PHU1HvvRQJldjD3ioWqq3XjhGVpBTUUvZR3mv5gwvqZ6cMXi6Mk/pFmCfowu2JL47JXFM4/+LyjJ8qpeevHJTLw2XKOS6ut45uk/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(52536014)(86362001)(8936002)(38100700002)(122000001)(91956017)(5660300002)(316002)(64756008)(66446008)(4270600006)(2906002)(33656002)(71200400001)(9686003)(82960400001)(8676002)(66476007)(66556008)(38070700005)(19618925003)(66946007)(6506007)(76116006)(186003)(7696005)(110136005)(55016003)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SzoG5Pf6YrCbKj7SoIcBcEOYTVU5ZeRJ10ve8L7ShaL+/nE9sLvqQlgrdA1b?=
 =?us-ascii?Q?AYayzddiEisNChlSscDxAgta6AmUav9ti5yxooX8dlQCuvXbgEQ/8HTvAmQB?=
 =?us-ascii?Q?onNn01VybKwfuNgk8t6Ro3zDEcTdjLiDZHQdWXFCIPeuTTCQOR+9FYSUz2Dn?=
 =?us-ascii?Q?zeSrpv+xhy1qg3WtWC66DWpGrDVKC8yCP43sm+Rugd1PgwUKsNlpwfq9J5a6?=
 =?us-ascii?Q?75bwjG0lg6ilVRDb/xi+PPADmIo0DEbzcCkQProVftAMfzcjuq1+oAYs1adU?=
 =?us-ascii?Q?F+4KUegy/VuERvuvuoV8vT5boJGN8UU1sZs6AUR/K7ly+4QkMMp6/c7e8T6S?=
 =?us-ascii?Q?8lnovtV3vcrereKdffvxrJqyilcQSQkGZNeVM3ESK5/ofiZnbXRjASXlk2NI?=
 =?us-ascii?Q?1QgOqV8CuEydiL73tvi2HmfYkmFDBiwg/ccL5I7rbj3LN5ufKjOMCi7495rE?=
 =?us-ascii?Q?sQ6Xhjw3qpmI9WKH0PjOa43IJPHpspNQFWqqyKySwo7K17CvrjiOKNdkgS50?=
 =?us-ascii?Q?W5JJ2GlEtlib90vWANUPRbq675brbvWe+Dr73OmoczGojyfAFz7tSUc/KIAO?=
 =?us-ascii?Q?UBnrBCyjrc5yip1imVpJIAQoQ+3+i+4MHUxujsyXr0Hdq3JkABi5e6WH1eWF?=
 =?us-ascii?Q?jWn0LFjzJNaAZ4+wwrO8jFrFaZr/MLjB7nS1U56PujqPB7zcckJWpe0NtH0z?=
 =?us-ascii?Q?S3zD+1mAmg4U+d3cptdGQ1RsCt8VR1SvK/+51Zx2HKnCbTuk1urAMVDSSj5a?=
 =?us-ascii?Q?qrhOB+A4xED8WCARQkt2gJ9lW6aFFrz4jRcyiuJGrEKipHrnrZn3qi9/FuXt?=
 =?us-ascii?Q?TjRagBs6tVwEJCOgd4/lzDS1zqGq/JYNgAHYwHmsuZW8hiW+ibto/rxDhKxZ?=
 =?us-ascii?Q?ZUw6Eo7PkW3OG24Fv5z/fnw4LRIWUsnq7slO4maiUipAojAx6jysBowEeBiy?=
 =?us-ascii?Q?cXovsYJmAHYilMH7L5RJoyL9nDQvZP8J+t1PKUGa+2tCxQLi//5Gc8NSVzp9?=
 =?us-ascii?Q?cSyst6Zyp0C3O57kkdZvMSHHf1cTQ5VD25T4xWA3ziDtDd73MCxCk18hbLWj?=
 =?us-ascii?Q?W9ogurh/ELJ1SQNSBW+wwgBPf/5wfzFDDsTewvS+QP8pq5XK04Hu9008DHd3?=
 =?us-ascii?Q?Ptux+lSzFKWV85SwKy6KA4QKB5r3sxwYye+ADHfnj3ejBU/pdNOvtSEaWM+d?=
 =?us-ascii?Q?tBmzutsy7fQiyPTqM9pVHtCiNqUERVezeQrudmSlVeLka2SAjzl5s3L2tXBo?=
 =?us-ascii?Q?IowfR/HWgIp2QxKUqq4rwYF2FThj/exPZXmo8cVy7elZZxHHTDSPutH48L5W?=
 =?us-ascii?Q?5hU/kzgRGQN2PTeDX5tiE3m+riKKg0fd3anc3na5ReOg9riZc08bPhjvz9PV?=
 =?us-ascii?Q?yUH2GolzwqczOmqjunCJ+6tfBoc9eXsqdELNWBK3+EHf4QsnPGnJxzQNAGun?=
 =?us-ascii?Q?iEpHxIPqBm2vHN7EvMkz09bL8YN2LGwMMmJeKTrIhquyTR7RrXEbtND+Itix?=
 =?us-ascii?Q?LEP4R4+ticycBQHoA2cZ9LOzwRjuLLP6ZQQsQMWMe+L/de/tcf5Vzv0VGnrL?=
 =?us-ascii?Q?CyULpVi258mvYe6o0e/Da5TOr+pBmQjR5EwHW8NSYJfukCt5lzVad5/LDiT8?=
 =?us-ascii?Q?6V2/6x4OxJG39ontpZt4xihnXG6ngQSkiAihcbcVnohBhmxrD2qCNfLOCVEO?=
 =?us-ascii?Q?2TMzf+36JgUgnBt0JgxPHEG1/5yC/1Uotu3K3EfeGYnBOmERtvpZxVS3YsWs?=
 =?us-ascii?Q?9WD2hI44p/4Z9EjaW/G1vVutvLD/IjpekiJNgvcQ3aGrxVXxWW3rcuYgePGX?=
x-ms-exchange-antispam-messagedata-1: tqfNPdr+yj20sWpZ1k6SULpIe1e8NSzPoJg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb4cd21-929e-4e57-5869-08da21d787e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 07:38:00.7088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9c2AjXW8wPllpHGr/sfBLxFe+JMle1/tmH8PV06AhaB5bKy/73+KsozJcm1J4ZZUZtbVxNJBJQftpZda+rQIPpk4SGNtWagOazn2QijMMBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6276
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
