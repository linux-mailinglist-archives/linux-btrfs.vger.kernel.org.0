Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2781D50835C
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 10:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358861AbiDTI2b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 04:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245432AbiDTI20 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 04:28:26 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB23634BA4
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 01:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650443139; x=1681979139;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Sn3Yzvww497XF4oew9Ky2q3RQg1Uk9Ugu+FzNwcQgpw=;
  b=DL9UhQofET7GeRtI3NO8QX5jHMQf7hYvFo++ttPMZT++rog7fQ2bEl8/
   sOoVZnnclTZ9p4UDHrRmZcNQQLo+ne76X35+t12LqTgPZraqmferu25eW
   vjBdDiGc/6e3i6yl1thfJf0kYlGz5s/j1XsvfGIQ25I1pTq3SjXSar7Xs
   SuZMg7E1fAXU6AJvScOwClkIPxcPZjaLpaEBSfDG5Xaf09XdVlqD0Y4Of
   q+zM8v6mwi071PraeuxRA6hbzn5H0mch0rfwoE6dQkdJKnOq+BPh1mppX
   2urIo582nXdAR7SQsAq5MK3zKTxfRDYs79GKv+DKdF3mG2RGAguW7MEp7
   g==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643644800"; 
   d="scan'208";a="197203614"
Received: from mail-bn1nam07lp2042.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.42])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 16:25:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmghxMtS5V7zZ24bP7nze7ZU+RQDyeiE5iDYrOs1KDp2FG38u01ZdlZuPuML8pR0YvDb+XLayYcI+FSTVtGSsOSrrCcX0PWas1c1wMxoPRE2+1/icTDMs3RrdHaMZrVwyoqRDyS//sZ9dThwMkfwvtiXtr9uFfC1j4oWr0Ps8D2LR/QYDs4TvKgvJJUNYBR13jvnnR3/cBPVmdsAc663IN7JX0BLEB/ascrTwU9l+cjVQVRT7Y+phXnyz3hecM5LPVDk5jnkTU17KRV0FEN2Dt6tA4j3S4/T7PPVSdOcbPa0bCY0VtNi2j4oMTiAzW5uMKco01Qhxj9HVMymfRBpFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+Kk/sq4ZG9gS0w3M0NANvROhtBmxsKYDLUUOY2KJQw=;
 b=eCCppujUl6PsKC7Lv1VDLb+ep90qyVeV/N3ktDwhqjmjOu4BgREH/PAzz5hUv17IEMpDpWlBhNMR9qgj2hI1YPg1j+hX2Hf+dHliEYIPo5KbMeOYHdGuXiwgJNYIPdMKkNiRdGhG49KlftPtajU0yVjgEXSpckCJz072pnV4kw4Qn6tbC6c6jUSLslO1PWqv0xVbTFWA/TXyJk2RVJuOgvzRHsNG70lYEc5zDWmYMI2qYatbMyP1EXAco7OKoAivMff5+Lma/DPgSS0yBjxFEEbg1R9mIezU8ujuZCKbe7lrqBlOhzQDYB1dJLqeH/yd3BF/0dRX0wsETO9waJIA4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+Kk/sq4ZG9gS0w3M0NANvROhtBmxsKYDLUUOY2KJQw=;
 b=AulNXjStMe8tXOYk16urANaLFtiRF8j4gK8A/YfIjVDiGzE8m1FKidDNak9fGra0rOKPq4ybdJ6ya+RzOpp9IFOGsMA8ESj/LHN4lBZLLg0FbayE7gmKkVpTmolyyKzHLIAGpLxJ+DpVu0pMVA354nlDCTS5b51bTmjcFqLkC9Q=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO2PR04MB2360.namprd04.prod.outlook.com (2603:10b6:102:d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Wed, 20 Apr
 2022 08:25:36 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 08:25:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] btrfs: use ilog2() to replace if () branches for
 btrfs_bg_flags_to_raid_index()
Thread-Topic: [PATCH v3 2/2] btrfs: use ilog2() to replace if () branches for
 btrfs_bg_flags_to_raid_index()
Thread-Index: AQHYVI3mBuv3zVdth0in1hAYTZXm4Q==
Date:   Wed, 20 Apr 2022 08:25:36 +0000
Message-ID: <PH0PR04MB7416E7100B6C5EA70446C09F9BF59@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1650441750.git.wqu@suse.com>
 <beb111504cb32088bcf4fc6bc1ef36004d0761cb.1650441750.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e471ca9-7a45-461c-eb38-08da22a75867
x-ms-traffictypediagnostic: CO2PR04MB2360:EE_
x-microsoft-antispam-prvs: <CO2PR04MB2360B88B1AE2B9512B3A8D439BF59@CO2PR04MB2360.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ukab/RnNaDwBjXAE6ZRSJF6X06Nmqvoou7O3y47w+wCn7A0HKqTOjHnj/7yI0LwPjVB06poChPNg0JztlrL++htNVqS/e149bbrzxsVZBXAOBOsZ9xRQqXGxjQuKJdWiCqp+HIfRmWTuduatCfBGzerwX/CDzoZmKwrACOXb5nme98WkXvrR3bkAb7QDpx4fgQcznjlgybynOPdfkeXRBBX7elakXjVFAL/GYGEDao4R87HYljuxavmFX9b6JECI/Ie4pEvI7e1A/6llNCX2uFx1yJqoSLdiPZTlXwv+vjgJZ6BRExB6ALWsI/E5A3hQcGQyXSeGDC56Q0/efb32Vwu6qXej5kus90fG8TalOtRZNzWVe1owwn6UZuUwKrNaB9MkplEhVlB5+8NX/H6INpwQQPcfpKpwh71hy62mF05VLJ5YK2L4wTMI2KYHf6ZZXzjvZD+I+g8J9P5DmmK6DK3x3YIxmU5oepe2CdMaPRKg8VcD2ppIE72ARdNuOXvFJdhU5uBCjL2BzQXD49ZUZwZNz0u6ic5VYcnrcVnT1/4wBk7NvHHPTVJa7miOtz5/3e0qpCqHLLouz7Zr+xHQ/1LcLO3RE69jvZShfT7Ue4IDpdnEz4N/fp1p1Xu2lb0TJBmGOA4NdECMOPYMUFS7+I+1qPzVQGcUM3sriDxYBIE/J+ev7cxa4HjCrsJgkNVpN00E3nIY9ySnBKfGxtF5Ng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(71200400001)(316002)(186003)(9686003)(66476007)(5660300002)(110136005)(122000001)(76116006)(53546011)(4744005)(66556008)(508600001)(66446008)(64756008)(33656002)(52536014)(8936002)(8676002)(38070700005)(6506007)(86362001)(38100700002)(82960400001)(2906002)(66946007)(55016003)(91956017)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FXRFe7A1ifhVsTBbFElWW0aic0CQpJIn6tXjME2FYW9i3L37aZwOHTsN/oov?=
 =?us-ascii?Q?jI1dijIX5Ma9kyDWEdphYCEzutVZ9Fh8m3GKgX04KC1fMz1obBUiIPWnKT4m?=
 =?us-ascii?Q?IEBxDRnCqwC8/XcE4gZAnFn9wVq+Co3IWf/ZX6Zsfm2Qe/tdBAs855J1qRxh?=
 =?us-ascii?Q?0dWzM+ONvV9R7Q9cUHaV+m18dmGtI7h5lZeT3n/SxYssXWjdY4Hd80eMnZlI?=
 =?us-ascii?Q?7EVX2AptqdM6Qdjt8Hmw49+p61AvMyRkSjRYMTbg5voteVxI2obqVW6yaGsK?=
 =?us-ascii?Q?0Q3Fo6A1Pk0PL7VWrVuv0hdQgBf5WAZ6OeyNELVXEFw8yAk2FgswLtIKQOKk?=
 =?us-ascii?Q?m0Lbb9Sutt1Ze93skBN23iNhdcpyYP0jlsQXISyGC6DXdXx1vK/bRMHIbE6+?=
 =?us-ascii?Q?xyWcGGxgarveiUkXorlAMyrYet0UaYxU53CwPSckUJfkJeaWBJvjpPrMReG/?=
 =?us-ascii?Q?XdATf2eWaykhZl9dvYvakidzA/YaisogpA2NvgvLc3LrMrc63nGzvX9nAIxM?=
 =?us-ascii?Q?0AJWs9mkYxePB/LRzJwBx/e+o+jVuya9qLtVcn9ynHwnAniGA8Z1ZH2q1dbB?=
 =?us-ascii?Q?+W2GJLGLbO7HoFInUdQPhTBcpKcfxkqFfKTZpCkn4GqRgAYlCSSLfaL7i2KV?=
 =?us-ascii?Q?21+GuAXxt/1JC5kGuO4+HADGJu5PSwxi6SlaDwtKiN/OnlBYU2P8PX20aJVh?=
 =?us-ascii?Q?Ex8E+hnQGE8RFsDi+VlH0vj+HG6XpjHbgE9Pq7cuyOUif9bE+DSJ5F8rFoha?=
 =?us-ascii?Q?vNX0f4QvV6DuyTwOW2y3IzyRT9JSy8vW2mkx3ebUpeKXmkbqbF59jeZx7XYZ?=
 =?us-ascii?Q?SK6W3TQYyvEpC1xkBcOVEvo2rvGlDa2+5LNqTE6o/Dn6NJxKHCZS2suYGxfY?=
 =?us-ascii?Q?wba+o54bcf9thz4uk+LOA9gwf6eK7bILhZQFvfdUtG2PvjgoDqKTYAaJHit3?=
 =?us-ascii?Q?5bSFTcNF67m9u0SeUABKikkKcLU0qP49XteKtXc7VKL2MubEPPiVgxDe87YW?=
 =?us-ascii?Q?B5C6TrQt4nSSQIiHn8YopCsqguu2Sfv6N0kkKX8fgmy/hI47xCw2wwZKWWKB?=
 =?us-ascii?Q?NPa01QYrar65yIMmQJlCHWIx7bNcj+BNqJh9OBpoxKW7WmMBZdLAXh5cHbWo?=
 =?us-ascii?Q?Q7eAeqXSyaQtPZrV3pYoC4fcLuWvz8ncoeRibpzCur9eFXU5GeJaE5aSpnwf?=
 =?us-ascii?Q?edDf11F41qv2ZdDOIa1lAVevvkMuip74OX2uwjPbgxGbLZebkE+D/li73K+e?=
 =?us-ascii?Q?yMli4EXRoQwOU575XBX0jkQP1TzXoaaO83zIB5cfmvBEyQNDxkTOcjqjj8N1?=
 =?us-ascii?Q?oCj1M6JnB8zyBupexB5C52c83YRm6bqmaew4ZUezHv1hT7S/ucwtob70OlwV?=
 =?us-ascii?Q?Z1F5v5YZU+cQGUPIN8aByx7qAkv35ISiYLo16Wq3pMVnCX9adRuxbVIzICXD?=
 =?us-ascii?Q?RhbixWwYfmD6VzvubcCy6Tl981vLD78fxfjv+K/il0NtzfFXiYwmbn5DFRvq?=
 =?us-ascii?Q?khL6LZeScnM3010tHq8my7nA348vGmPv9J+cKoxX5VxtyoBgELyDQgReZfKr?=
 =?us-ascii?Q?TYabgpjpLkQq4oInNKXqYE7CWVsZyzQll7dMKhKh6qrBtwqmNh+7mR5xoBhL?=
 =?us-ascii?Q?EtFOrp+RCzMP/i1GyRgv7AzOFWBs6pEARFnK+nywDxEbYvgiaEws9F+RVn/9?=
 =?us-ascii?Q?bKVuDgjNVgAxuoJpb8iFYa/IdDSH1GbBGvsAQ4MaAaJxA85UNECStrS/XXSO?=
 =?us-ascii?Q?tWLSr1ZzKVjzJZyoaNc7Db5rmkTRJjZL1YfgyoG7ntYOkxC7/7ly6SNOZbUR?=
x-ms-exchange-antispam-messagedata-1: 02MGA/bDwgnrRMLUsD5P+gMCwGxifRJlR59Gxnh/tOY30GQXT2vvlyHA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e471ca9-7a45-461c-eb38-08da22a75867
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 08:25:36.4122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yNdhrYYwfSzq7rijOog14T/4382AKNoOc1YDXQ9laHy2icOWnAsYdcEbi/vLVDkXvdYrrIROlk0tfusVu8xfxEAx3iRqJl9SegElOWBx3Bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2360
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20/04/2022 10:09, Qu Wenruo wrote:=0A=
> In function btrfs_bg_flags_to_raid_index(), we use quite some if () to=0A=
> convert the BTRFS_BLOCK_GROUP_* bits to a index number.=0A=
> =0A=
> But the truth is, there is really no such need for so many branches at=0A=
> all.=0A=
> Since all BTRFS_BLOCK_GROUP_* flags are just one single bit set inside=0A=
> BTRFS_BLOCK_GROUP_PROFILES_MASK, we can easily use ilog2() to calculate=
=0A=
> their values.=0A=
> =0A=
> This calculation has an anchor point, the lowest PROFILE bit, which is=0A=
> RAID0.=0A=
> =0A=
> Even it's fixed on-disk format and should never change, here I added=0A=
> extra compile time checks to make it super safe:=0A=
> =0A=
> 1. Make sure RAID0 is always the lowest bit in PROFILE_MASK=0A=
>    This is done by finding the first (least significant) bit set of=0A=
>    RAID0 and PROFILE_MASK & ~RAID0.=0A=
> =0A=
> 2. Make sure RAID0 bit set beyond the highest bit of TYPE_MASK=0A=
=0A=
TBH I think this change obscures the code more than it improves it.=0A=
=0A=
