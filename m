Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41603525E80
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 11:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378663AbiEMI4r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 04:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378747AbiEMI4n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 04:56:43 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C5C5DA7E
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 01:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652432202; x=1683968202;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=d+4P7c2ZeDOGCLKQOOxLiUE3FaANg8dfgckr+LIAQD5ZxAU9+kYqpn1/
   opGJl0GmP93srTCvjk6rt+7oCDu9HLA3Sq12pC9mYZjPC/X3jcCsu31Pf
   z2I7j+FDkzE/Na183Eri3KTu1HCUESEx3CS5Ry5wMS6TSJRKmuF/0Qa28
   E6vT/oB5/U1hZEhAWqFJzQQLrb6s/eDyaRENX9a8Sg2TWRplG6wsly11T
   IMxurBQNjWAHB6+egCp+yoloKJLOLM9lsknM1wKsaRT7Kf+SPJ1L8aVZg
   QC7UV/ndqHqf6Q64eUwnWXzgsp/4eJkRagcIJt5lKAHt+nzNC8kt4lt1M
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,221,1647273600"; 
   d="scan'208";a="199077321"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2022 16:56:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKnYeQJE2zhYMgVjpWaaoMwMlUG8vsbqTK27GszXkMsl7KRxsnK/BycNqxSjdFaoDd5wwlMxtz3ZxaJWvGkSXqhXtqdnP9bv2PmEOu5xRxnczmjSlwI5lRa1p+XEHy+BUG85NJtSdvTpEumGIA+IF9qDdovDWO9aG4QZp51+WOmnaZ2RI6D9IanCopKDeFfgZH4VcojtU+7gA+mlo2mq80Pm11v7qZq9sqjgEr3h8p1vFkbNhLfX+qP7YBDNkKe5dReYYreTIZKZuCBsYqZlAUTQhDp0uceGNpP6WQZ6Ps5oHr/fZ7j28uXo33VggX4zT0DP2Td0XJxQGdxP1SxWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ES9rNcTRhU8Z4heRFM36xzQxlQxhtl7PQDNDV0yCSwfmsBlkESmjw38Km7BB1Hs4SdFIisJDC/NCVb8xGtpu89x7DlG94478diJwq23vOgHYJJUzJ+0i1e+gSqhkPhFmrgllK8Qo3+6eo1wg9BYjGsQWDGTNZaq+MNwVjPRKTLbyd75sbm9G1FRZV6e+S94J1nWuPSFtXko1S9Dndri5dSThIoftVD2gWsMT6sXUi6lroW5ZYJ55xa34WdTU76Nm3beuLUlHgHMf/F8KgjTmswm8lPBhXPhsV8VIv7M6U5RwXu0BkLL08xjBfbWyLowXb8gIrGvCVhJ3oNse/RXNJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=O+NZ6k6glDBvTwmQ/0+EkP6Nb1bi9mIVenik0kumK+s0CeQXbm6EKEo3EN2Ap/Ey09/KWyaRs3N8E9o/+CISQGl/UwJkAFOGDLJc9BSIJsWPjh6HmoxRgFJh9cdkblWNCJQLOQ92BJZ8FtvF7WSmzaWurPs6WzW5KFcVOCg4KfE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB3956.namprd04.prod.outlook.com (2603:10b6:406:c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Fri, 13 May
 2022 08:56:39 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.015; Fri, 13 May 2022
 08:56:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/4] btrfs: use btrfs_raid_array[] to calculate the number
 of parity stripes
Thread-Topic: [PATCH 3/4] btrfs: use btrfs_raid_array[] to calculate the
 number of parity stripes
Thread-Index: AQHYZqROXKl2bBvFE0CUk4VCn9SnrQ==
Date:   Fri, 13 May 2022 08:56:38 +0000
Message-ID: <PH0PR04MB74168D0946512BFE1C8A7BBC9BCA9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652428644.git.wqu@suse.com>
 <8ffa25e5ce1c3728217aa3c833039aca449281a8.1652428644.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ca92a2e-e722-4a23-50e5-08da34be7e0c
x-ms-traffictypediagnostic: BN7PR04MB3956:EE_
x-microsoft-antispam-prvs: <BN7PR04MB395638A9D4071FA3B25563B39BCA9@BN7PR04MB3956.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YYpzTbAS907M7Bsynz61wYDbBwXlwwp0P0piiYeKjErlQI337sggaAmnwoahif/4beq8T9prrlZZY5oSEgVdW9TZB5Wy3lD2ZYYweY60SysMcDp6cABqP0QKySJLbm23hY5VU0ADYzUrrCQ9SwrAgYgyBpXa+txsGMTfjuylCH/rwD4YN1uSzF19sowdDeMZgeDXasGP+6b9kt1xgAa6pE7uyhyxoQpB6IDwKbsDPwD24HtbL+vCwHNlCizgvGxwQiSq+L4ujTagFlolj9SzL8S7W9ix/1alc4h4mQNQY74sh2hHyfzgh4+IbCSqLza3QCsV1b7PPAjdN6vyEXNADyeoiUuZTVjMb5cJ++WzZmXFnQ5VE4+IAihqlD+M+AcVjEPtQPeiMQ1ut+YG+pqf1q/YuZb/t6CvsGjdx5nXLXBQ2J2pL337fpurOc0eXpj6Qbbm0N19o/xs6T1Hft9/V9jlV4/osxRPqoWiCMncZchC3FLKjOGLn9ORZ57JtDG1cvMZ/OX8E6kjzw+BGa2zXpn+Ys/D6e8JxrfptOkWecbdGT7RT+xtoEoIgD4ijN//hWjY2qVUyOn9Mh9Wh3m6eceDJDXUV2ZpN5isrhcSPcpLPzuUlqesX6I/WNHLO9KvztIsDZxmpNhy6Xf6CIWRNR0iYBfgW/rvKFDGlwv681Tl1QpcGPcQY1oZBV9ZCWFr5tNNii+/I/cx1ZNEeWrd1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(82960400001)(55016003)(9686003)(122000001)(186003)(26005)(76116006)(64756008)(66446008)(66476007)(8676002)(66556008)(66946007)(33656002)(5660300002)(52536014)(110136005)(2906002)(558084003)(316002)(4270600006)(86362001)(508600001)(38100700002)(19618925003)(91956017)(7696005)(38070700005)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yH8VyexMEqfac4tR5TB+Woj0OlKKMkrvdkjI/iS5aBMcKfLElumHiM8FFebq?=
 =?us-ascii?Q?7wdWpobP5y0fZfM104cMVZu4knUQIKndLUOja/6Sf69/wVgZp/kSP+ZsF/Y7?=
 =?us-ascii?Q?EWxD+UXzyygOQ9MrYHhPUeqthhIFdEDFzEugc/DgNUIGCmUJG1hWw51A1JDV?=
 =?us-ascii?Q?yqmjdTihXzkYESO4q4+7Mjw1hd9cK04cf7WiJKr+68YPy5tEZyfy8sxWeflG?=
 =?us-ascii?Q?9+pkHlcNINb66f4gKtaEtEF6DeQDsVyMGlgJ4p8mVZ1O7tuRxpfXeWojoI7s?=
 =?us-ascii?Q?fEdr8K26OiFdyBstO7OWIrJ/Bp+bXL+2i0/WFFJTwWxrL2x0CyF1RZuZmTy7?=
 =?us-ascii?Q?IfmbE4Hrvcx2HEc3jCRutc8bkZ3Q+T4WokxTBYm3m8tNkoqHJIoTHjgr3Fos?=
 =?us-ascii?Q?RqhYpBwiUAeq1h+mwDvCWPDGpecuIFCrIBEwSQ4gSmKKJDjtz9MIYNbTuIPw?=
 =?us-ascii?Q?+kOCa3LSTOimI5OwW5sf5Zflg6nExnS1zmSpSjbuHS/CSfvGgGfly/014aaL?=
 =?us-ascii?Q?idbwLsPmXJZPszcYXIUOodnTmJq3P+QkPglApdmkYgj5hAIARa6bKpuhS/zk?=
 =?us-ascii?Q?7jBAHKtqvQTAMMql1eIYqi3k8fYq1Sa7EeTjAdZ9Ma6K0+nIjSXVh7Nomrmc?=
 =?us-ascii?Q?agJPX6hPrSSpV4Q3EpLdFj2vFoeHtvukYP831T3nb4Rca85UCGYfOdGzoVkO?=
 =?us-ascii?Q?ipMxcUQdEASBU+E7lqQiNrdD9EPIfKCCx5ZoIO1qFCY9SliQKSGB2cP75sE6?=
 =?us-ascii?Q?2HOyV2YhTXVTawuczCHaPvvi1J/B5U7VQdiuFb8N5Tsg09oWMZ+jrpzlQoFl?=
 =?us-ascii?Q?ptS4q9ju5sDHsOCgE0CLmc3PtN+a3mu4T+HLs67Zsc1dYFNwYB83z/MSc2Uf?=
 =?us-ascii?Q?o6/drbGJP7FNuHW5tWW3vGxtqMmeXrHeBjshIE3AKRF6+2uXnuX7k2ZUVdaA?=
 =?us-ascii?Q?8ab70IkdCqKk0e43e80Llw3FNJm19trv7daieW0xEDTh8czggwl11q5kv0q0?=
 =?us-ascii?Q?gFOLb5N4koEMDCfJ+quPQnH55ZH06oYNCEYsR/ms6RvaDTJsiG/3CCfY+WIr?=
 =?us-ascii?Q?FBIioQeYGedwYoAanPVOMmO5UlI4eM4K0RdzV3akqZcLOxPqidjByOM38X13?=
 =?us-ascii?Q?3lp4dz59fjuUNGtngKuD0Y4wVwQtwRsffRVGCdlJkyHVLuXRtmPSmn/TBj8x?=
 =?us-ascii?Q?d3uaYvj/nW+I6I11NfkEcrC/dgR1vSs4aFJ0TatIrt5W6dhwxJOlcB+70tT0?=
 =?us-ascii?Q?zl0HkZwmgKtVQNVNBS4hmQJKuNI1hV7I7sulEPvZmVRtJM+AfC/eCwmqR/Kz?=
 =?us-ascii?Q?wxcWVH0T0jzKroZtW1dzDGJQFY+VU3qgyH00+dbh6Q033As1NTxbGuoXcZre?=
 =?us-ascii?Q?gzjHTriIMmoAwVby9TBi+cQ1oFCdcZ6Pf3puApt581gcjF2l3Xz0TWUjyI1u?=
 =?us-ascii?Q?AWu1kKje9esTqjGl6iB3JdOtIOXY3SRX3lU+opbZJahnl92d2DYVtdP6TpGr?=
 =?us-ascii?Q?+2nrNh3+nhcoxjJa3fUCd7LPFQ4RPBMg7Hm4Ss+vfE0V8zeRxxq153xpBqx5?=
 =?us-ascii?Q?BOX1iGKLTbSkwn4OJ87yiJmOEu97jqu3SKRCCCKMN+Yq5SgIMUdOOlVsjMDO?=
 =?us-ascii?Q?WvClX0df8/fYu+VpTu6DHYOdIpYucCf23Egiort8adD9Qt2zFvm/3vletIqL?=
 =?us-ascii?Q?FKHBwPoGi2BTp7df0pHx4la0Px1QuvOXwURDY54CWAX8SuydR91YzfqN2IUo?=
 =?us-ascii?Q?b/qKF93bVGE7GSnxfARIsq9+KToUs1c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca92a2e-e722-4a23-50e5-08da34be7e0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 08:56:38.9019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o2m9jsCyCmvbosr6WH3amK6zQKXEri6lfMBI68Gp3QgEaDqmxaTWC3riVmLfKDWArbV/qvKmEpB2/LDNwgmA2k5Mep/g+CMdZcmshx7Sg3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB3956
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
