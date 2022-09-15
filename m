Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A445B9CF0
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiIOOWe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiIOOWN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:22:13 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FBB46D96
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663251716; x=1694787716;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=IlB6JuAfJx6M5ezWFrcS8YvShh4/KKvOzLt1WCxDvEOknCwarMvoQ/sV
   VrC6vLgPim47pMEqf4mmgvVkakRYVmaAfbV3w0nixqYqLiOwtfGr2TVCL
   xqFn1PD8DrkJTis6UUN2aBFNGLwAJoYfrHTmNM/RKfqgwdn7gT4unXn8i
   5LFtmqzsO4Qq2wtR8KMRK2pgG4skTDu5pjpNv2CUlrQmUUbWtLY8W6SRw
   soNV+KkOXUqmK90AIaUUeSoAXih+dLrYjOaDDGTSpFIcRW92tCWyplo8C
   sie7tXksZxRyb5ymCyVf1j2DCysUkEOY43p/Dt9MB7G61vFQ/T3KId0XC
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="211891864"
Received: from mail-dm6nam04lp2043.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.43])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:21:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSvftP4vYduVzaeUFf+CoiA9UV61Iy9Ox5Kx506ETVXi5TEfi8HacmjkRZ1EUbPiQApGIU3feXIIn5MbMDHEGt8uptbP9fTlttKTw2WEcyCi3S5w7i+LnwLIanM1Za0l+S0eGUnSbrLWKTg4ye4U+lUeVtvfLYE5AYJtxCNdmmB0j74cR73h4719q8J6o44HIhJBzUYk7BizIqBxjMhpWlgFousug1VCe3Xbzu4HmAfUOBfkXJT59QlhnITrCuI+eA2Qyu4eBT5pEjL8YfL2Xk2+AvMxaiyPeeRQhTuq85Lf5LdjVm855L8EbQclIg+YZTJthkpI/wWvHgzf7NeW4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=TT6CzTRSceC7fd0Smx7qrlvPfWTqK4Y7pvpL4KRH5PpMaz29Vn1Q8Im7iMzwW1ekkUjCaOw035nfNkuT/OVlD9jW94vOThSkiG00v3F7xW3FMUzizyj5jTwLvpDJX9LfiFDwItVaMyug+pzh0rcmWxjmjCdSdfexceYF3M+BFYEQuBq/AxAyHmdLYpsEUIsdGKp4nH+26LP5p2hUB01Vn/QL8ADFhjqlOC6+5G/m5uJf7kneyUberbeM0nwAiCAlIJBLDHcYFcBcV1uEZ/LzsG/YMQo0+D98rcfb/EccF9j/MaU6S97Qybj6fQjwF9cV8k8FAzxkSMQJMSwO69Dpmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=TNJhkJwhrb6PSo+bOJWInp8JWBANkF6ATqze97ZfaX3NY4MgUodQCGwH34DJ2GsxXdOFQRCqusGg18C4WMcBMOzphYRQ5Uk4DjTYaTMb6rFxv1/G9bWRENTb6nCCUNLCLEyOuKd6NQMxr8kUSEnK6bYCWx459zySuoq5y+nT+ew=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB0984.namprd04.prod.outlook.com (2603:10b6:910:59::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 14:21:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:21:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 11/17] btrfs: move flush related definitions to
 space-info.h
Thread-Topic: [PATCH 11/17] btrfs: move flush related definitions to
 space-info.h
Thread-Index: AQHYyEu5kYCxqlJLdUqWmqSPzc/unw==
Date:   Thu, 15 Sep 2022 14:21:50 +0000
Message-ID: <PH0PR04MB7416C86ABBF9230BB69C45289B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
 <a946709036f0527dba6ec810e9cd61b19d267d6c.1663167823.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CY4PR04MB0984:EE_
x-ms-office365-filtering-correlation-id: 4b3f140e-3524-4be6-7e3b-08da9725a196
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6VzdgJjOQ5ejtQ9hpbuA0z6CgLafcttTqFqorWd0tgr2pC3y/GcWT5+LiYTDD7FYGqkeCVn0//a7MfjMaM84odqSA7nBk6tC5r609JtiwKkHQlmv7ajY+so6fVyj2zXm506nxE03Jw6Rih4owxmokqI0PQgm3UDE20Jtzx0P8DiWmfP+hNSEWrP6mG/1Dtrznw5nhkyGxn9NU/YEEpbh5pPt3iYz4w7GyTaaW6irFMe4FD6oj7q+D8TFUEs3kqGmCZ27ZmGpXylL355OlYADBuAAwUSsA5THF9JXU+Q38lUPUR6hY+V7FbCr9B0Yol35BmBVXAUy6vVG9f+90iicEYtnH2obzdzCroRZWwtqXP1I1h4S4nDE7atIuM2oirx3lio/K9E3T/4dq8Rkard7z25dRhjRkI0lPa7TSteBNp3Yvts9lLWCwh3IGeQnP4VUXfC93KoCXnZ7pZHNFF5zsjng+COpK5quJ6kB7CEm6jPyRIKJWxO6CYMBUrpJ6hPRi56aNleHbBfalEoxcSczo07dB5k/zdxvKubQ1S8rXy6x7KaVDsWjH0IL4doGdu0hEyavHZ1ts8abrCoPtuJzSt9CytGoeBuDCW1FXGhIQ4Zl3JdX0y6jvPurM2txfDRKSBIkRYxnGmUnb0uq1XYxRMk+dwY3xKd0G4LspdB2ENUCnU4Yc8pOB3s/nhY5kBAMARMl848mCAtJCJtRf0/apJ5q4P4Q/I9E9UeTrOE/QYoh3cYC4PfJKy0AMC0bLcJCYTe+GfoIbu7tNTvFBYBIOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199015)(8936002)(64756008)(55016003)(82960400001)(5660300002)(8676002)(91956017)(76116006)(66946007)(52536014)(2906002)(66476007)(66446008)(66556008)(9686003)(4270600006)(186003)(7696005)(71200400001)(316002)(6506007)(33656002)(41300700001)(38070700005)(122000001)(558084003)(19618925003)(478600001)(38100700002)(110136005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t2s80Ggq4VzwxOQnfelDMR4tVlixpOZKSsH2Chbp+p1T6P9iFSQBze8/dXZk?=
 =?us-ascii?Q?6CXhSMeQ4E9jDh7YJZwrQHTXUeGW4ypii/gE2QSFZpDyGg8KYuSUzjchZjcx?=
 =?us-ascii?Q?4ovyqnaqlnpbGXIHfEtN7UQtuy2q3juFsm33jdOyBJuc9BHtXEf/SzruI9wh?=
 =?us-ascii?Q?64nRXYPJs1WhUq0gEGCfKJu8xTQF7j8U4mS6v/8y7hbi89uh3fFU8+aRpw98?=
 =?us-ascii?Q?yNpoEvCSzv80x5OxIeEJfzpklUdIivkZjrl7Iepo5rpJloAR+8AsqlMVFZI9?=
 =?us-ascii?Q?AhcBfxsZ3ArKWx3Y+hg0hbw4NJCmTT+6EM8MSnDrUBJcwm/gSoIPK+KiVcpj?=
 =?us-ascii?Q?YiLEEy+z9mkVUSiZDzeYQIJhMKs1yqXqmE97XpKDvdCtVqvtdpS862Bds54r?=
 =?us-ascii?Q?tkJehA5r6KSFa3fkMfuibl1UtovuXuzp+3K4jtDm9117J6S08e5i5rrWNhFv?=
 =?us-ascii?Q?DQ/cGU8PF7NW03vI/YWV9Xkpv4NsJlDnjhLP2xn06MUbW8Q1BlTsCuq6deCJ?=
 =?us-ascii?Q?aEvI1rgFD+aFG1v96OWBKI5RyoVxW36J60ScCDUp69KfajwVyVq5EsqLATOu?=
 =?us-ascii?Q?rTsB+f3n7bxP16hY44HvMPeLaZjzbFB8+m3Vn6fXhv3+3ka/5qDQ+YbbVCyv?=
 =?us-ascii?Q?SANwGc68Z2LyqdtTyx4aFNYz1spaTz0Rru3ANGoFa8o8Q0+ZuI62ZWH6snxD?=
 =?us-ascii?Q?cuIK7QK1LKxWsh7jmnk7MI/9rU/cVin3cC+Ax54tA05RywgIJr6lV9OS8+ck?=
 =?us-ascii?Q?bXNcsHEj9ykFYIeXE0rQP9xlkEsrU0e7IAq0R3vmLSXx/otkOGQRbFiNFaTN?=
 =?us-ascii?Q?HT6RJW5reZG1nTMDbyTFKsVMMGTeXVts4tMXoJkdsV/KrcgjBoK+Hx6Gc4P9?=
 =?us-ascii?Q?QGIDOS/39fL1gukv23IZ306iFgL5EIjShptJPcmWUQTWlyMnJ/y5BMZ6sEV+?=
 =?us-ascii?Q?0ifpaRYgERLrjGgljf/Zw0Brp+XWI+5NyDQDGIaIE+85qqruOvDymu9oSKIK?=
 =?us-ascii?Q?ACEydTMFtf+rTe3hZtKUIh3WvfcHZopzSWKAsej8YQp/zWe72T6hxhp/S/Wx?=
 =?us-ascii?Q?VmIkwOpFPle+zNP6FHiXGhk9njOZDoRN5TLwOTU/MjNB6CkSgsk4sDH8k869?=
 =?us-ascii?Q?iMT+GeELf0XhUaL8uu8PYQTeDjOf3iq7XK6U4mPKbinhKeCNmd2Q7W6EPox0?=
 =?us-ascii?Q?Bbw5wzyHTJT2FoVqjW5NARzrL/oWY3cl1xR/MU3AmcaX1AeA4dyvlFV1abO8?=
 =?us-ascii?Q?p9DfzImGJYbG+5/+Oq8vhhzaK2F04+Sgeawr8HyA0lmAm3RJijwJqdsO+cqf?=
 =?us-ascii?Q?PINhMB0Y+ZAcP4FXIHGoj15EioiGksvQbNwfPmRDaKt5b8H9F6RAj9a5bmbo?=
 =?us-ascii?Q?JUukqomW84HxDTpWcVq36qcUmL7+45D0Yb90yr4V8XOWWMGf879oUVloSnI3?=
 =?us-ascii?Q?XXQnfn0rYuTuHs7x8G5hqcXQkNYLGddZIjH0QGQepxwFmNwAbvuwMlKBrDzC?=
 =?us-ascii?Q?m4Kgs16TAc+n4wH2eYNb5P9e6yJBhrKo0EwALxgplBPnnTE1QUzK34xsJBjV?=
 =?us-ascii?Q?EO/xgiDEK3djl9VgXDSBmuSjZfEnNM/wQNqfH7GHvUYDDwcuFKbH2eNC6yIS?=
 =?us-ascii?Q?MSnbNXlOussTPa2nkVA/FCsUV4CakrCnZqmpWReAT1ThkqAIcM0nZ78K5whl?=
 =?us-ascii?Q?SkyKPQ2YpsIxvJOobChV/SuIr8M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3f140e-3524-4be6-7e3b-08da9725a196
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:21:50.6768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /0Q+GVF6xdCMyOAGdOcIRGdduXpq38GPkC59LqkDBZwRJFCpRXrfi4xPdLcBCjDyM5Ibztnqn8t3qMD2WuEQygAqfL77IWdmn5pZxQ2rkj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0984
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
