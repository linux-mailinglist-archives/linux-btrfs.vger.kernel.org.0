Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EA1760DE1
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 11:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjGYJCB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jul 2023 05:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjGYJBn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jul 2023 05:01:43 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DC0212F
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 02:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690275677; x=1721811677;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s94inDM/KNtBAzrNmiKQpCam3E7VwW7+aA55VFikiYQ=;
  b=EqXxSSVvyB4B/uVJlC6YxBsjIo6O1Z+cudFQPBslMOkjmrk7egsekCs4
   hXjkasesAqCgrh8CENrCmHupROcIa+BpjEFuiXg/IhTy3q37hfeSoIS6f
   k0jMh5V5b4PsEudIU411cptKOvCie2KRpI55UnszpxvKPe1JIsdd+JM7C
   qEhJL3+JEMhzwX3TyYp2J4iBMcLM5S0DJz3U8F/2fHqCv3mM/v69lSELG
   hpJhDkPww157+PAI6pfTi6y4YuuzPKGurkow0JdlPlOlguotXKrs0V27T
   xzrG0w1m9of5io30vgrRvy7/APTCRH5+hSPJg2ZYjcT5C3TqXdaPa02Ew
   A==;
X-IronPort-AV: E=Sophos;i="6.01,230,1684771200"; 
   d="scan'208";a="243650308"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jul 2023 17:01:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ge5QtBL8GgYfoaZK181sUh6zjlHp1poGxNU+u7efaT5L8GQDyJm3jg+4GWhdTyZXiKR6MeO4xn46MSQy+0zAAUupNe7iHnno3oxAgfPuoK6O/SfNQx1pJoq5NSmon+Hv1YLT64fAVvrTx3KxInLLstWNaazpJjKJNOMUdIxz1hMiK7XQEh5K7S1TghIHVj2UxA5LwiDdTckvSycEbft1co7kUKRO6cSD4WVhX18yhhP+B9FfJTzlqRQarQjtRfrcERQXTOAhbFp/hWFgc1S1wTQblOopKmn5KgvOpgbAZoGyDPg4mdY3PLDghyhHYCp/i5RcDwdahYiExqpg81sWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s94inDM/KNtBAzrNmiKQpCam3E7VwW7+aA55VFikiYQ=;
 b=PD73Bhk0HL9oyPmL/bTlVZrgkN8QxWfLqrdIJM9ERmcAWa/LW2UtCKMvZ7dR6tC32bKdE45T+oLdcoRvaZAUlHGN6mbgMp6voCi3x3j+0j9Fw59++xToyv4M7Ovk6XBwG5GVU09Tj/QGxtoqqPkGrSq3MmGS2g1sAHt4y5sjgi+BI9xjOgU9AuBsnqjxInNzVwhStv2dm//r870E8rAf1xahsBt2/z5jLkA8DZly191degwasEzHVU7Y0rd06bul8LQ6WpVNDL8+hVknOFLEC14IiSHnMvABcRrxzZhezCGSf8qLwbbnu1VzlHChWd3/FCtA3KJC9abzrNFeJJvxXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s94inDM/KNtBAzrNmiKQpCam3E7VwW7+aA55VFikiYQ=;
 b=av5yIiMNh6LvP4wLpuLaKxocfkzd5pkO2GI6CLGe9WKVEkmsFPnnp6PtOwql4+cf02ea7r0vhhgKOZKEqGzE1QAXjemhG5hTDU2cckvfp9Y3cYMV4Z9OXNzvIwACW5836JdNaBTPQVZ4Zw0TWO+VqR3n6rHrk9vRLqMKoGFGnH8=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SA2PR04MB7692.namprd04.prod.outlook.com (2603:10b6:806:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 09:01:00 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::95cf:429a:bc0:991]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::95cf:429a:bc0:991%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 09:01:00 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/8] btrfs: zoned: update meta_write_pointer on zone
 finish
Thread-Topic: [PATCH 3/8] btrfs: zoned: update meta_write_pointer on zone
 finish
Thread-Index: AQHZveX91oxQ/65fx0uWwxu1lkx4Hq/JBJsAgAEsqIA=
Date:   Tue, 25 Jul 2023 09:01:00 +0000
Message-ID: <wuufln7y2df2k4dkoy3qmhmy7iapwhcvzzyqq3ot6ebp6wuknm@m3bh252ogzex>
References: <cover.1690171333.git.naohiro.aota@wdc.com>
 <61507f174fbd62e792667bec3defed99633605bd.1690171333.git.naohiro.aota@wdc.com>
 <ZL6TFrca5TfyVYCO@infradead.org>
In-Reply-To: <ZL6TFrca5TfyVYCO@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SA2PR04MB7692:EE_
x-ms-office365-filtering-correlation-id: 73bd016e-685f-4526-c5ce-08db8cedaad6
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fm6UZdxXjucuDzqgmOpUcpAa7j6Bi5BfYosmFce4fFU33vHuhFIq/U2mh8ljiD7bxeXl61iAT5ae4Gkj0PpJMp+f20Db2b5zlEOJiXJ1eatdtwcI7caA8CGL3BOUsxQdqE1AdFmfDa8y2Z41CCsXoeeJ2Jm5+R+op1kRMwWfWjzJwkSBo7jhYUHqXRroSNYLLUvhALZcm1oAI+Ibb7z05BUcNN6hJFCtfl8jZE/zyxXw8TyXWZPK82jtjTdlNTVyyoYoigFr/35RwOVBBfys45so6Dk6BtPJUmu1R+MeuR9ntWy8i8hKWX9NNS90hzJY1yaVkxNSzlvMoJmLM2HRpTxizomdvrkhWClSVtuYckt8p06LMolY51iK1JNy8T+uH14y3WTcwvFrQfGNsQeuBK0ird2QSMOyxsi6SHDsYxCnbe4Pv4f0k+YWeQ8DEUblo3dSX9m4PDbT5A2yQbpfC2r8Uo08+uq/e9FktU7UuN3COfKVIzDzc3fVi22oinIaNBMbtwXmiicmHwqIk0aVqg72GuyH45EH+sRlPt/exx8R3fAoLo5q66gD6zAt+872nq+1sCfnJkEGxSgrGnd/QunfzhnBH1hMtNTDG17CIzL7Ieq5JxkTZju3nAC+FK9N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199021)(5660300002)(2906002)(4744005)(8676002)(8936002)(38100700002)(6486002)(6506007)(122000001)(478600001)(26005)(186003)(41300700001)(82960400001)(6512007)(33716001)(91956017)(66556008)(64756008)(86362001)(66446008)(71200400001)(9686003)(38070700005)(6916009)(4326008)(316002)(66476007)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qiWK2PbJ78PKy7qyJu+QOm6vFXimZHScWLrqKM3qf/9qXB3Umzi1UDqQ0/ms?=
 =?us-ascii?Q?C+WBSpP+VKGMgxJRlKb6dIjA6wRt6VRxC7E8UF3TzHiUTrQPDH/ZEacRAgzD?=
 =?us-ascii?Q?8eyAn1icfcP6xyIFHgGeL6q0BfQCea40fOq4FbK9OuH/n15XaQXA4gVUWrJn?=
 =?us-ascii?Q?htb+bNXhcNBmZ3A6zFbR+0lnb+zw13TYE73n4MPCOK6r7YyxCuLxGE/nXQiR?=
 =?us-ascii?Q?AqaPSIQWPLiRGbDsiIayD+E0TLy6r0fpaP6D6VZQWExYqtN0qhKvHpwUSx4K?=
 =?us-ascii?Q?WuGQD7U5wPStrfeswjPORYB6exuArZliHYdSRCL6DaiD/r7hTUTIA+onszX4?=
 =?us-ascii?Q?UwvA0M2NsY30bwBGurLFqcAKFRRIJDxsZ4GXahR30n42+jSLS8Ig+0sLk3DV?=
 =?us-ascii?Q?XxSi9jEZ/iPJ8IPHSJGip0ebdPZu2twrQJcPgVES5M0semXr2x8MQbJEaXV5?=
 =?us-ascii?Q?Red+WAPLhhZUoJ8VCUn7OobJz7HXDs7z1iCBwdqK4yWLC2IaxelRBSWjupq2?=
 =?us-ascii?Q?pXC2hvjs4N/IZEXmPeYIDSZ4kXv3cdZMMX7wx9GAGyk6XSd/FIyM/PADVGnv?=
 =?us-ascii?Q?ONQGa51Ggt5ULtK1zAqboZ3FOj7shRuxmdR//lEaWrPPSVtstqcKs2pd+yvX?=
 =?us-ascii?Q?86nDA8H1fIQw0U/WD0W1psRt01XWY454iWJM7mV18JwvIP/7e2V3zcXcCqwY?=
 =?us-ascii?Q?LcQ2Jsm6Jwy9rcXMFmaWDTLOktvuPdDEzrMaGJLKCqi0JsNHZbt4PgEY3JWm?=
 =?us-ascii?Q?vd6hIJs6mkhMFmsVQCVm8oHeH4YkT9YZ6UD9lYRaVuH6bc7easEhz3cPkOhM?=
 =?us-ascii?Q?U8EHbJs9iyuXNW2w40xP160w7FO+eOl0Akblo4b/91fuB4DKu4Ntete8FWcH?=
 =?us-ascii?Q?6SRj/j1wyA3CxBJwTP9goNkzUuPwFMKGaOmId9Vgvs3z6u1BXl6+1i3KjtOP?=
 =?us-ascii?Q?bXpBd/Yvj3YQVcRjo98TcSvczqRFQSHgt5ZgPweNIOAX/+eR3Ju7bLTMC1pU?=
 =?us-ascii?Q?qVZw4XM9y7/2+TGcrCMprSqVfAyr43X66Px/360mTjyxEnhi0vsdvQVTPyDz?=
 =?us-ascii?Q?By3WdvHegp5GtKaP2lmHiN/k2jxtmGNJaZcrn6D3TYPEozAAuOy43xixCg/E?=
 =?us-ascii?Q?PaV2MoAUWmlzJfunnsLWo4c0+cBG4vKe6QikQGMQ4zoT7jje2Qq1gD8WkQno?=
 =?us-ascii?Q?79xglbh6HvBRZcoDsVTj8a0bhHtDhkhw2vqR1Mzg4EalfOeHaEiohCg6U2Hj?=
 =?us-ascii?Q?UqCyOtvDEGqo7z4366TBw2YN2XpnQFUeUzNmg6rNFo8G0d+//54N/euud5RZ?=
 =?us-ascii?Q?awH2aLBdhOWZWrxq5PHEtVJNU+Qr7Kf5ElT04J+26GqWkbU+tQ3nRzZuTLcN?=
 =?us-ascii?Q?HYCdn/0BchsCLG3MFwRittyAMXEIKugP9zC7bY9F4jc+ajssWcOnIbgkCjeI?=
 =?us-ascii?Q?/w1CiZIMkuHFDzdJmJsyR31aQH+xadwuwOAH0q1pi24UIL0xEvQIHNRWbn14?=
 =?us-ascii?Q?vkYsQq4v8aTFuaFWXLBb1rSOcpTO+CDi45+Uyu6mfU3/ZBxAx/j8IgP317i5?=
 =?us-ascii?Q?rMk6yMI+U6TB3kdMK24QopftTD7YcrNWHjqtvxRDqFiyrVeJ3PSHoiyU/DRN?=
 =?us-ascii?Q?FA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2500300E002A2E4188CC66EF3FE904C2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1cZGLZatbljdXqhD3QMXPPrRkkgE7jx/zjgmQvW0vviSU+IICaqfwkifS+zUwn9POGl02jndgqQd9AGSfg4Yqj5sQ5AbEZq9cdrAMGTXWcT1mHLWALwVFxZzffdvaxTcZ6sym/AmXvJjzj4838ge7Roc/1KETLLtobns3weOV8XpeJ1iI0X4YVwReD090aX2J5WQx5S75cC9S3ncrUDUYzODkgcDgWOE5orFlyuIkCw0Ux3SZsoZq3KbIVX8nFVZl+BB7rnTmAErs1BEzs9BopxYf1dREtPCv4VJ3XwunSbleyWwAPDh0JVnpEQO2Un29jF5OyM9G87wkTunub2SnKu0tlbCeASC1bkizAa+WOakMmd9CpjclVINdmggoo1OaTC2HdaSW2UYsKuNpS6PvKaDAZao1Ek8T2n7H/bJPwy92oLG4JYYL794Pb9MKO38Z6ea88lzhuP++Jog6/3KudPrAr29fZxOfqy3vr7Cpf88xc6BQtQEjOvJiTlUgbw17a0ViSeGeThwMhuZ+C1AeLWfIPYIHDQS3B5DRTyWXotGNTNX/TpyvqoWpn894CZop8dx1FQfF5ErgU1kEYNfD8e4bfAvzfStg84GAP9JIV+8oVANqeV15to/6RSOrHbzQ64oscWH//cM+P1IDC+loiE2bFrh7j8h6JQTsM2bKIRD/pP7djF3aJegcGyFsrHFybGML5RMEQGBNgAQpz+w6d90gsMDRwS1B4ngsFCIMmHeWt9r0LBAvxPeeUYe0pSzEVtdYOqTiIj1tV1m2ZBfqlxuHiCzMQc5Rd52UIxeGEKv5rl5DaqCffxUY54V3hf8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73bd016e-685f-4526-c5ce-08db8cedaad6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 09:01:00.3907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GYovrRt8TT+MpPLqjsVw2wrWjLQu2w5mxVaPfqG1IBlNHCvy8zbH4ZsS8D2RqqIborlnN4n+eimGv8FU9BhxmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7692
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 08:04:54AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 24, 2023 at 01:18:32PM +0900, Naohiro Aota wrote:
> > On finishing a zone, the meta_write_pointer should be set of the end of=
 the
> > zone to reflect the actual write pointer position.
>=20
> Looks good:
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>=20
> Does this need a Fixes a tag?

I don't think so, because there is no actual bug hit by this as far as I
know.=
