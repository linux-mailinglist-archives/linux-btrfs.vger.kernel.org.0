Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED835167BE
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 May 2022 22:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345289AbiEAU2z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 May 2022 16:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239469AbiEAU2y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 May 2022 16:28:54 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B49931DF8
        for <linux-btrfs@vger.kernel.org>; Sun,  1 May 2022 13:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651436726; x=1682972726;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=mxbm5RPBl3Ck57896kmp724FJsrj0qd8A7NjHO+XhEcnHeqEB7TFNklx
   ooBGR4OYMpBglkrh0WUAwAKY6Pe2Zqiv9oUGCAaK3fBmowGE7RhgfsY20
   gIJIfLsoXaMVxW5e7e93kU3jjGIJ0zGS2Rf4lV4mVT1r+tboVjyVrTQ0l
   Rv/6J+Dnko3+1wk/MEBNYVDmsBSZkkKhr8v0NGFd+GET9K2GzPPae5bwV
   Szi/LfN85BbscIv3S1DV1P90rYYw8SuofU3pOc5bLUQs+g/EHemU1into
   TXnhBdqVhdMgqTAOFUDF4NlLpgEmuNf9D/C9Pm92UiJIwra4o3sHWKN/M
   A==;
X-IronPort-AV: E=Sophos;i="5.91,190,1647273600"; 
   d="scan'208";a="199286987"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2022 04:25:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbLQRXnsIDkRORByu09a1cLk3B720Ew7HM3R8v3NveymGmRtQy1FgfP1DSsz27jUlYRKR0gzqz70kJ3pl/zlNj+H6OTqE3pVsAyVcSO6ulIa7Ydb1l7r5kqAAQgZTj4osYt8ggfIBJ+iF0ryxCC7aulLE8rI4absb0JQ6ux+tYuyOBqtgW2J4eF9g0xUhQvqrXFXR1Ew86t31Wl8QyXbo3cVDmznN60aq5lt2daCJevcsQm6dwipKjblnm2zmfIGJ71MW0W+C/jahwLRk1BWjqyeKhG17E1/CSIGOfMbsNfgjqTeW2deZdSLRHZNtgGJ6ftWaqQ2JQIn271Cf0/+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=dqo9JaDYKXeiVkSgjIyhX0QpLUtR+PFDm9fYguwIX2vJEJ4Pikjwb5QwCfm8aSyuTGvBoOLXpFI8YjReh6w75QwnTacKIUVKcW5b7/iZ112ztlMHgtxVpqukOMKiutbDgD0YxXpaXt7xPmQ25TnAICFQo1FI4dKp/HwISfctdSguM+XV9t0MMX+zasej2zpn3ngNUPy3aV+P94TsgXqUGW6sx4Wgo/M+PLkGoq0r+G9agnqRjIAMqjFHG7NFF2sNKd22GNOff2jQKZcOmMm8NjBjfGEBEqTWMjNaGjIw8WZVU6YkEyAQBd6H+rvXd5uMLN56OVMKxOOww92PnOJUMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=tfpQua/ufDNZdcydZZ3vB8gnQNB7ZNqL2s/78D4ACWMxS3ZP/0cqbg+BDPbyE3xMJOwAypUTUHzR/JF2lfYHlHhvdj/S+heoj14D2eQ0ByJY79FKj5fQ+LhnRZaN72ITkgY5yk1v1eGrW3bd+uC9eGHAbKfa712fiGRp02ZwUl8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6689.namprd04.prod.outlook.com (2603:10b6:a03:228::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Sun, 1 May
 2022 20:25:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5206.024; Sun, 1 May 2022
 20:25:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/9] btrfs: remove unused parameter bio_flags from
 btrfs_wq_submit_bio
Thread-Topic: [PATCH 3/9] btrfs: remove unused parameter bio_flags from
 btrfs_wq_submit_bio
Thread-Index: AQHYW/dn7DupFzdZyE2dVwdkm2+lxg==
Date:   Sun, 1 May 2022 20:25:24 +0000
Message-ID: <PH0PR04MB74161AE3236D7C861AE1D8809BFE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1651255990.git.dsterba@suse.com>
 <6455730749fdad4022bb7138bd9108692a3697cb.1651255990.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2767e1db-a9b8-4280-6c5d-08da2bb0b8ca
x-ms-traffictypediagnostic: BY5PR04MB6689:EE_
x-microsoft-antispam-prvs: <BY5PR04MB668954A3CF8D7FA61589569A9BFE9@BY5PR04MB6689.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: whnRECIZ0sp9G9HeGNn9jjMy/XC0me2eZ9sjKGWl3ageeSJ1sfUXSHeNXUEx2ropgSrzSt93NPHW0hYt5Ky5vSTNEICpfyurHL8t6RDcErzVs9mz3rthaoGdix6wFTim65brs3CcZok7U2GeAuHq29vfU19ujSm8KbRBeR9U8xDvAM1YwAAGbFvSn9aXsGuHm7T+4J7t1Phvpa7btqNGCOSyBdp4c0y9Lc1xsaTjKarWA6Oxi/ueZgqlQm0jy7n1wxhDcUMccpJ/GTrAMmQHf4NOwsVcHS70j5DgZNwum2XkmYk/XWs097zP7Au4qA284GBom6suPrrMsTWSTtY1njtRls5IEds7pTWltfSxVst2aEJT5dWWn9/kH4mPcTnO09kPGqnK5zlQzwYi8h6rDagev/kijcF2SUM9EDz253pAZuRubo6+rj/s3/P0pWdrQWAqKsONdS+oXTrm7HhHZB+JI5Uh0Hjn0Qaa49V76/3VtpUyLixXusYQSGCvFL/DojUzFZ6p4slFkLPS5yslP9zSrsJoAbCpqKxGSi9hASyw9qRZb/jCPTF7nWz44XytkbL4dVnSo6wwfQ2svah6xMsRJC8upyc1f2ypKcPo/mnazx0gJbzy/DXdGgqlHAug+F8FYMlcygVoA+82GkEeYrhIgRC2nkuBCrKPqQ4/Sz0i1+RXq9WKpDeCbuNXyYEkc3XGBvpR4kV50Fa1UkvHQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(26005)(110136005)(38100700002)(52536014)(38070700005)(2906002)(6506007)(122000001)(82960400001)(86362001)(4270600006)(71200400001)(186003)(9686003)(508600001)(7696005)(19618925003)(558084003)(55016003)(5660300002)(8676002)(91956017)(76116006)(8936002)(33656002)(64756008)(66476007)(66446008)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ds5yYZ0OaYHFuSrcxeTrO+vR/ysUn0HR+ixeYpjSlJW6hGTULr5i/R5wE8tV?=
 =?us-ascii?Q?kB6ulrmBWvhwQ8rUTDQW+booXDVgSmc6FxDep0oM4AbENUYviwxR3gI1hoqB?=
 =?us-ascii?Q?j77dnAvTqCV97OjjuYuCD0X0J8nHkF4jVfamGi124Q/cUFEKyKVK8/p3Uh1k?=
 =?us-ascii?Q?K48/0HgsFiSXxwuqug+DVa5BFD9z7lG+i+XvKGLOR+SgpI9Y2WaLU51CZFfR?=
 =?us-ascii?Q?3fXx1eVQMlEvIpN/s9ToP8qbQayF0fgcC0sXDze6rzJnuBN8BR00XrS6MFSr?=
 =?us-ascii?Q?oTXCoVA77pGrXcbLsU5LSkyFmoIUY6GtdUHX9fpsBcX4fV1BySTtgnhUx9iI?=
 =?us-ascii?Q?tGjBp4Wks6VZ+Vir3N4dHuXkJXGmnrqvDy6d68D4zscdcjvWkzpMWvPJyD23?=
 =?us-ascii?Q?PCJ5YlGaChlcliOTqH70yh4GgwWXh4keV+3hU0LiZuADSwYibO2/fBu0Lxn3?=
 =?us-ascii?Q?SaLE6OszQp5dZAQRSTzB8sQ//dtHbzxZo1On0j5gpMlPOiZhj4zhIUiXUoPn?=
 =?us-ascii?Q?RYlvAhSPyoSglKOcgAUgUiDDZpG/nPYxDWjKO9xM0jwxsMVgLo9CZNbFOrGB?=
 =?us-ascii?Q?RvfnGSQZ0ComU6dpeCUMuuDVNOZ1s16WIWaB1w2oWgloZEfhzLcn4smJNgVN?=
 =?us-ascii?Q?nlIgdh8RPzjRxtNXotBH09iqTe4sNkWMrLjrgOxUwqoe+qms5EV8OiJcuOVW?=
 =?us-ascii?Q?1IeqBergp/OgKLMh2xbF6Lk+Djhr3PJfBKbxSmjLY/v1LGbXM+9ZdsVK2kzo?=
 =?us-ascii?Q?yQ8fU/6MT3dXSQuBDnR9ik+KaSYtR5Y/IogVrNOHBU0ZIMX2+ZyyEijpnh+C?=
 =?us-ascii?Q?c9rWRGxaC9gNyyCnwYoZ/UY/peLlKXrmY9ehzdTUuP/FdZoEhYoGygx5Kt/G?=
 =?us-ascii?Q?mhHD6Cq2D5JwrU3+dcI9fOLtkNiacjsWA/aEceAvMmW8F9G5WqMp9+V2HajG?=
 =?us-ascii?Q?tvNOjcqGyGEr1dR/98zMRSJRSxUL+7MkC8P82BJBJBQjHnNA4Y2zXWcku//1?=
 =?us-ascii?Q?LmoKMrTzlfDB+m78yBr0Eu4jzJdqSWAMHpXMPPq4uYcId6tt+Wx8DrPEjw6A?=
 =?us-ascii?Q?zuj7rTh+lf1knGfQA1hEOUl5qZw1hJClPgcXiuKJiWl4t8aBu//Zu4egmgqT?=
 =?us-ascii?Q?vh5jtIPuyhVCzqIhfOBDPrAuz1ORxQw4rtkcKR8wj88HObWrL7aXvz7sytpr?=
 =?us-ascii?Q?ZQsCBnednMMto416HK8d4J1cZDmCoq7dU978BwG7i4M59SXIgfPf3gjocdOy?=
 =?us-ascii?Q?eq+juMYB1VoQkPRlf/UzAUU48Yxcm8TjmNh00NqSpXPvc2amXyQtxykOIeWA?=
 =?us-ascii?Q?1jvm1IoMVUylFhXXwSQbqkvkcwU+d1yT/5Lu0w94+aIxv/XXHTB/t3oaWi31?=
 =?us-ascii?Q?x0Z3//z6Ljx5uExyfk2aygsOob++YQ2kRsM7lmniM2kxPc/75Pvp2qSuZURd?=
 =?us-ascii?Q?w91cxWb6lcvguPs8PqXKiFGkywU2N4su032ieaZT8zbagRC+CCQ7jagIQ1sj?=
 =?us-ascii?Q?IfpmvAenMr/ZodBjlSbCxhi93SOiL3fKjLNjFxArOrD4UgqnOt9IxIOb4C5A?=
 =?us-ascii?Q?LpeqrIFqJOOK4kn6L9o6j/NKzB0mdJly0EJ+n1xpGvycrKwInvq6uMTnkqvA?=
 =?us-ascii?Q?0jkauxsnrImrKq3BD1+mKxPkcdcRBr+xxBQNDdqlKfcFLIoQEHG7zRfHlMXh?=
 =?us-ascii?Q?2Jsds6ohyvsVA6dPsi3ypcOngD7yyCAGgejVWgmx+JPEYXv9Ph0rl329omem?=
 =?us-ascii?Q?L0yjExkWaojjGmaRJ7VvivA/V+ViBOI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2767e1db-a9b8-4280-6c5d-08da2bb0b8ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2022 20:25:24.0702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zSjTL4kqsA+eoFepeXHvIYls31M1DKoE2jIZNpKjroFrru6AbcZOQQ7alHJwCBlsIUnL+22A1d/UctHb8X5QSQ1hL23A4LlIcN7/jBwS/8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6689
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
