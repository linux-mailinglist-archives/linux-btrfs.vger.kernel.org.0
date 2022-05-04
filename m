Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC2751AD3C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 20:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377264AbiEDSuT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 14:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377269AbiEDSuQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 14:50:16 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CF216586
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 11:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651690000; x=1683226000;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=q4e0PglqISNfvFS2abZSbvoeKtSTONH5sERayCmhSBc=;
  b=Dw7arGUgYFE3pHjjTGdQfmDyETmwFCntB7sZu1wx1tWL0wQeo8V1NWC3
   3bZJjkuaWMqwr8jFhXenVbnQ8ZtoPH4SVGzBIdrwrj0fzkqRbBbf4U8SJ
   Pwh3BlqTuVuFQaWkWUfsJgdgVD5BnJ3bZWqs+gQoTkavGXsTaXOhZb2qP
   MdBBn8kYnWt5lO+NE8WQ0OsE3UGQ65uQqeqDNN38oS7C2YDUdKbsEI11l
   12PXMVdSwFuUaYrCS+hNOj+13hdUwWb7UK4rCMl3odbscMXnAOacRko5P
   /lmC4ePajfkFdXcy0TdqjYt0QPe6Q4zQ6NaWTXd1vMdo6Ymz915d0RVQT
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,198,1647273600"; 
   d="scan'208";a="303744825"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 05 May 2022 02:46:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltnYppd4vaZdovsUrAykamjMiypr0OxfdUVE5C24AEPUIrwNG1PQauzF5ucl0cXjbXJM1BZBXdTSqaQzQDHOgWl/eyZssmaMJfo+n72nGLpdBHNdyLnF26//sE+zFKfwTOdDsch6O/QO5/XMCsHvMC8jlHLR3C/e985cyAEZk/4nkSIYLv+Q574Et6g19QiFyBZEDkKkSd+SDGA2IvXRguOPvezir9PVB5gP41VqI1IdrX0KajwoANldl8a185DujVoZM9ROrB3vuE0F5ZbHuZJPBz2dvojnkhJf0spopyCYTOsrU63K7bLinUsqVhZIVTF1PByb2ty0iZhBS6N18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOTzyYK+QBe02IiER2Y71Uwwwlwb+t97rfNJ9+HDg+8=;
 b=jIYsvcMe2aTf25YtpX7pS4O9issQoh4Su6+9WZa5OJ00LgRyiejOTuAmSF53QFYFevSyZ9xWPjczStERo8By1XREGN9RoatJqCe/wZRRWm/ouBZZA90vxoKOmXmP5WCyfzviRZegU/EnTYFVcp2bWgQIAYt8DO0SFFeF1lPyzgJXS6l9qdrT++Asr4dd5b9Okp5QF3c0PeFdLic0bxLTT6orQc9pcTKAZF8l+fb2FeNJQlAyLoJHeTDTSvs2OD03nMUOI7pj/qgIsry1FWhS80mfRsmFst3UFc3/7hZ5ZHkUcamw7dXOWgEwaI6wloL0kZ69knf1oI1w/F5RQi1m7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOTzyYK+QBe02IiER2Y71Uwwwlwb+t97rfNJ9+HDg+8=;
 b=mGsse0eZztghcnDt1jHHkg9UnvoKBo0VOooQxRb+eDUVlLADg961QAGBP+/UBubHd7gBIX5Q/3R2xHwR+P9O3NIX3t3VP3q2bfA0GGib7b9GcUiXx2NjtxdxIq7OTmAIGlSpLutG6e6lfQXENEncHbolIBkCnRfNTlIAQoKgRw0=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BN7PR04MB3777.namprd04.prod.outlook.com (2603:10b6:406:bd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23; Wed, 4 May
 2022 18:46:36 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8db2:701a:a93d:9b93]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8db2:701a:a93d:9b93%9]) with mapi id 15.20.5206.027; Wed, 4 May 2022
 18:46:36 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] btrfs: zoned: fix zone activation logic
Thread-Topic: [PATCH 0/2] btrfs: zoned: fix zone activation logic
Thread-Index: AQHYXzJNhbny7NMsXEih568p9pi9P60O8UOAgAAe5gA=
Date:   Wed, 4 May 2022 18:46:35 +0000
Message-ID: <20220504184634.y2vjlgetotrcpea6@naota-x1>
References: <cover.1651611385.git.naohiro.aota@wdc.com>
 <20220504165559.GT18596@twin.jikos.cz>
In-Reply-To: <20220504165559.GT18596@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c189800-4c75-4592-0260-08da2dfe6aa2
x-ms-traffictypediagnostic: BN7PR04MB3777:EE_
x-microsoft-antispam-prvs: <BN7PR04MB3777EE954160BBAA5F920F7B8CC39@BN7PR04MB3777.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6C5fPVDlMR7WVMDNSxpdXH/rvBYgZGfbfUhL2pAlrmNPxNUztVdr1S6szmBK0s3w19GqZC630KZpvZ9/AO6lGZgwtmtB0jnaeegS+ABPU/OGR5riHB4XIlQBWCx5lOzoZqRvV5RkPtLaa+349j7MmjENluTCRabJiFycP07DBGFUaCiaSSFEjA04PWdaknoO2+jBKqDuEPlaFUUfN5vC0f8Oisf4/l6BKjqsndXlP6E3O0XZlkJwW5n/6YaR6jzCA/hIV4mG9b/QjaPT7rR5q3xBZdfD/EFNycnLyDxrZAFbhd5E72MX30jS9v8Q6VDuRU5SAVlEHDT0QWOdtRbT34ZJk7TogBmAoc5Z1QUuk5vmzX+OMpJYCT1vHHuEkz/h4WaZsOJMz8Lj6xlEMuTxxEde5knyuCpgb+M6qohVOMz5MQHmZWe9ZfkxJIZos6+SO5ctuqAf6P7z5u5U5B4FHib3GpCrUdVpnIsVRUdxQ0+ScPrh9cTTJb5Iv9mWyXyJ3+g07/78dUUtIBYyBDaZ7gPKJTMeLOTMgi3m2qvpQveQmr/tBAfS0FS0x0ZuemvSAqZGffzyznQRzdS5LGDgsbzOD+QSD2VMzmR5sD2uaHlgUnfkuNDt8p1c5u7/Whk85ht8ihT+LXP7dZgkYDL8/xDInZ9uXC2UdHACCflXKGBpNpo5WlwyrFDlo7G+w91Ug1CFH5bcLd2c4rDjdMLp9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(38070700005)(66476007)(9686003)(26005)(186003)(38100700002)(6506007)(2906002)(508600001)(122000001)(8676002)(1076003)(6512007)(83380400001)(64756008)(110136005)(66446008)(5660300002)(6486002)(82960400001)(66556008)(66946007)(76116006)(8936002)(33716001)(86362001)(71200400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kzt1uYdBsmSMEGC2/bJqw3FkzArn+Kphru7eFc8pb6uZN2JGMt/rfoLT46W7?=
 =?us-ascii?Q?nrMjwwLhljNoKOrRAwfD5kLfTHW0bQaAtjnAxa0JVU8aUev89l6mkXx9YO0G?=
 =?us-ascii?Q?0s72WuYs2CroYNqHa00py+fb1qhCXZ+1/brcfzdy1Ysl9n2gtfpq64PZkrbc?=
 =?us-ascii?Q?Z9XnVBtAnBPAB2HSdjFveR0ksjWYzqunLr0Jz2sxJ9DtCwyEx+WD+N7zgyLL?=
 =?us-ascii?Q?l9K2jWgdv79knRFmV/64H50tLaN5b0sKxF5bidwkz1PWu3FhscPq2gDVDtHo?=
 =?us-ascii?Q?7y8fcZ4Uy3WESewZoeZNzwyXoSGhMi3PCS4qbz413nJuwvDcfuMlThjc64iN?=
 =?us-ascii?Q?UPb3F6KowRDRLiOfe+AwYOsUj6zHP8R4o55vj8Y+1Nh07ATMtUlkUDqPLC56?=
 =?us-ascii?Q?07msE5E8pX66EYt4ziHYEtVx/EkX3hOBbxf/2wK5luqBSUVmx0Z0N3hO8E2y?=
 =?us-ascii?Q?bC5Zogs6MQ8usQ8OG6cgYCNBWE5QGFG6NbMxxdayjfxCagGZkn2EJr7IS1/D?=
 =?us-ascii?Q?ugqluSUM+YvvzPmv9COvpIZXGh8pxucpVNBxCGjQf0DUU8cT4YOloiPtC6UB?=
 =?us-ascii?Q?ywfKEMq8jSSW9jn+EFDfHGsz39uZbZPG3bGi7HosOeV2ADi8IcGZcn7i9Z1U?=
 =?us-ascii?Q?Ms7LJVCcGC5WgByZsePTsMOppeQVasri1iZO7RjYRTZD5uSy5WSSQje4YRx1?=
 =?us-ascii?Q?ZJb4J8UJWI6pbScfpkYkC4jbdRFqCf3REXX2WVTQaioamuoMnoXZHwijaHml?=
 =?us-ascii?Q?pvZ7qyBvGihrXlSRTjtF+i2fu7ZGA8/5xAWAzN+fuQULyx4lr6Qia0ZRz+qS?=
 =?us-ascii?Q?adwmpcPy8vcin7RQwrZNiZVtNZxybdS8GxeB1UIy3Q08XJdfRMGyqv+O8BnC?=
 =?us-ascii?Q?AtJ1cOakLtU7PIbJR5ytJnk5Z2n/5ZHuSn2lu6IMqAFtbH17YBfdEi3VP3Kg?=
 =?us-ascii?Q?JrFN/Ny7VSsufeXGwHaZY+GE60V8SbU58Wzpv9jXvFaQK1eG2X3ikh+ndBYC?=
 =?us-ascii?Q?XsXooAJqRjT1nTjsVVl1T897AiXM4N6r3DcWvviE96myTqZiwSN82DjiH5dU?=
 =?us-ascii?Q?Y/Gt5X60MGfDkUwTKzg20hxKGLou50UpdZog0f/5OyQGEPcmNYE9TaQJHcos?=
 =?us-ascii?Q?pmARC8cdDqoTyaqR1W5/Z2TtSt2Gr89irhA06c2wFOVSuStwoKtcy2UAJV18?=
 =?us-ascii?Q?THHZ5DM4PcXollrMsdiLrgUvweuVBeufOU6eb/2ngImd/VK38bTex2pd0Q3X?=
 =?us-ascii?Q?VkHySMRQ8voqW3fzqDP5QA1aDvmcmqMfsPj40aUpynLafjP512evClehZx7a?=
 =?us-ascii?Q?BUuZrigxdtJAoSVMg1eZ3iVbJStrgG05shD/bLuBX6qrcp0M3/c3b8q1GVkV?=
 =?us-ascii?Q?jF6NPK4BiEpPhlP/9B8B6+VJv37sKDwvQvEUlRdDxCtxOFHPg8A6YJWOsG6u?=
 =?us-ascii?Q?QxSsEhDU9QSzWCizewk9Mhj4mD+vE8PkJgARnVIhRWuLi+V9RjRdPGs4Dbt/?=
 =?us-ascii?Q?9QWxC7Ey17IUhOxpkOaeuobLDy1UCw6/sz0O9XvLW04+uli2TrcBK1Jw6+Zs?=
 =?us-ascii?Q?RoMq91a3CXBN3mHYTJVgnSx9I6WMWb6ieopqOdjd/vf2YVWS/5Idf62s7LlO?=
 =?us-ascii?Q?GZTTfOPI6rZc/rRtNbv0s0G29g7dfW8G+vc5F80SewvmrVPgsSkF8V8NxIW5?=
 =?us-ascii?Q?zVBDMANfncSPsAwf05TUpslJ7iDq+1VniLiFKFacxFIhm5vRJ12YHC1O437W?=
 =?us-ascii?Q?7y5SlvVwBw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FE26D118223DF2489CD7C16DEEA38B72@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c189800-4c75-4592-0260-08da2dfe6aa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 18:46:35.9666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sWzHN+7R2wg5Qh5/hdjwiJyuv4QEwiRAYkaVJJawmd9P3OhluUFdDUdgUmRUU4dimvFY86iwDYqnK7eN/xISeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB3777
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 04, 2022 at 06:55:59PM +0200, David Sterba wrote:
> On Tue, May 03, 2022 at 02:10:03PM -0700, Naohiro Aota wrote:
> > btrfs_zone_activate() "continue"s on seeing a devie without max_active_=
zone
> > restriction, and it never set the block group as active if the block gr=
oup
> > does not contain a device with the restriction.
> >=20
> > While it still return true and make the allocation works, it is confusi=
ng
> > for other code and it is waste of time to iterate the loop every time
> > btrfs_zone_activate() is called.
> >=20
> > Also, there is a non-changing condition check in the loop.
> >=20
> > Fix them with this series.
> >=20
> > Naohiro Aota (2):
> >   btrfs: zoned: move non-changing condition check out of the loop
> >   btrfs: zoned: activate block group properly on unlimited active zone
> >     device
>=20
> There's a minor conflict with the other series fixing the zone finish
> but this 2 patch series is a clear regression so I'll take it first for
> rc, not sure about the other yet.

Oh, sorry for confusion. As noted in "btrfs: zoned: fixes for zone
finishing" series, that series depends on this series as they both touch
the btrfs_zone_activate() function.=
