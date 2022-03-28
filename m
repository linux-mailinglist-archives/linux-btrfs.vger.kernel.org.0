Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0355D4E97FC
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 15:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbiC1NYd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 09:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiC1NYc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 09:24:32 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FE046161
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648473772; x=1680009772;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=JkEo2o1/cQF9KyLZCyfYFQ3xFgVUHGMpYFJbddQZORc=;
  b=m0eArJ03+OEwEyiEpFIOaAX5nXVtS8VDZ5pSCtgFwlNRupX14EY1h5zR
   RuXelMeVBjjOX7CbDOBZQe/WzpI0MpwoDryvumDY/tCUhJbgP9SjE9thf
   DP1RyRunkpBmkLKZ00TzvGY2oRV1cRvxO4X2Xu4y1dzXEVycxgIOyUEGM
   sTtNmTCX03s/co4pIJ8QeGIONau1DOAOcpOQ2pTv23/2oXXziE5xvqQIE
   DvX/NBgqxGeL8TFQUbfpf8mA9p3uHR2KgocE5ItSZtdH+t8g2fUP4Qsrt
   jjr8OYcqHEFdktI55brOQR0WCScfG5R/4gGJWQX4jJFqy2NkFg/dI10k3
   w==;
X-IronPort-AV: E=Sophos;i="5.90,217,1643644800"; 
   d="scan'208";a="197360330"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2022 21:22:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfysz/PrWYE9y8Ui5cfU3JkagqnxdxQ0TtFcGTHIrdRG6KCvXaFaHiyitY+5ceVzwx+Z2EBonSPuYwOFnVuEobAIZFg9NAaeiUQTAOv4NuV1gAoLHZbqwOdWsi5YmdB6RBTCeQyABzNwLA+eWZV+SzuRQMvbDj2V6tMC3CoQIrz08C684YWH2/jMUPsp244zZy8ARRM9/R8sFDu/2POzgr2VkfJJQr+e3jwZss3fD2Yh8ACTiKQv8oxO5W2HrVIspQiTZaIZynoRY4ao4EfsgCj+rchSiID+6HETh5wRW6LsK7NBZjkWxcoEtUGi8CugX5/4/1lKqOJdBKX61x4IPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkEo2o1/cQF9KyLZCyfYFQ3xFgVUHGMpYFJbddQZORc=;
 b=QOEM8v+ZTv9nOy6V+BiHBzl4TYxB5JohLKnpbBAJkPfIhJSjP0/ia2OoDIwORRxprH03esXEOzYdZ+dmUnb2azvQndnFveZXq80Pp7ia72Yl/aRu/tMysRfTicFfGgSbAILqUto5W+xB51b796ve0z09cCaeoQvuZn6BzvPv3y+P5xDWi4ExFTh5if901IRZl0rCVXictlkCoZrfEO25ZeUMXpvdI4aXTmCRnxLTg+alMNxDLYruWYflLDyWexLi191HXFjedxdsPY8X5DBOOy9uDmz1Ph1vqfHJ+2y3hQ0TM/bPpqX5xATGi510JVKaw+uvseIMKa3T7IAQInD8EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkEo2o1/cQF9KyLZCyfYFQ3xFgVUHGMpYFJbddQZORc=;
 b=HeOqJ/e6Qt6NLAi8dDUuvjLGfgfZD1n2rAoR7y49yZFn1YHcovj2o+idj6/8mh3PlfLoZIRt+392C3ZGQNCXuDx8QvVWLITQm7z7i6NqnMf+f6FlM5gQtbkFF4vu4EznaMWhUVmnA3wEDTKbkAvq6oHKLm56VnQWpJprhIUeseA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB5523.namprd04.prod.outlook.com (2603:10b6:408:50::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Mon, 28 Mar
 2022 13:22:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 13:22:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix outstanding extents calculation
Thread-Topic: [PATCH] btrfs: fix outstanding extents calculation
Thread-Index: AQHYQp/pD+O+D6y0/Ee6vtk2aMtoZQ==
Date:   Mon, 28 Mar 2022 13:22:48 +0000
Message-ID: <PH0PR04MB74166A73E81838A15A8C74AF9B1D9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <06cc127b5d3c535917e90fbdce0534742dcde478.1648470587.git.naohiro.aota@wdc.com>
 <YkGzTsQtFNI9s7Ji@debian9.Home>
 <PH0PR04MB7416B28BD43CE79E2D6A75349B1D9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <YkG2WL4Fa096+6xt@debian9.Home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80f60e5e-a26e-4b0c-3d73-08da10be0dd9
x-ms-traffictypediagnostic: BN8PR04MB5523:EE_
x-microsoft-antispam-prvs: <BN8PR04MB552378C7356D354C43FD05249B1D9@BN8PR04MB5523.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Eikxb6y3F4Hmq/NbGE9c0NbZbIfvRqTJDMcQJfg5CzMXInkY8b6chCPUkD5zXZErsZGMNsDGb2sR0vghFIjVyv+DsS/MlYiVRqJ6/XRedpfPu1TlY6gBjp/TL0SLbbVp/b58RRqG3jqSzhc2PHuEtih1RCBvpy3GwrU22vQuegQCpRXs9gEqH50iCMosTArLs32uP8XOVBbvIZvqvfQOPzjJU96Cc5DEGESPMPWtPSyg4hWvAw8VAvZ1Kwgc95XxI5s2cxKO3WpUEcZ45KbeKFEeQVFckeiESZ9jeC7LqF/i0u5HHPqQdUnfzfadpdTCjk0F4wKlb3NzgOwb73Fic/BPEIqkRWWpNJ8ADHwE8/luZdZF3VENblm0H51N85TvGCAlOxUSKVwgsqbV8C3ysynG05lAF6mjKxT4H+iPd1kQb6IGK02AILZaIi43mXr2m4u+Umw5Ivo4qchEePxWNHVHiQAdgRGIGQLUZnAyI3hI53ic1kJLm3Kcgl8Zv2GSghaOiGj8+JkqVORWMFEO4o94i24/PaQkOG/SfI5w4Jx9KyjN8Dt6gJrRgbmB9bn6Xl+y0Ra+Q2NVCiSPOvyTD8D05PWo68scbpFRfpG4g+b2vPp4Rvm5QvpFx6KJnHGAtm88SFAueix498mAIZV0CQsKJhmJbWa57CvZ+kSNkXyu5dgPq6oWAJ2YQh0GA/1n4S7ZEiznAsC75IQJKzKBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(4326008)(86362001)(33656002)(82960400001)(66946007)(122000001)(71200400001)(76116006)(508600001)(64756008)(91956017)(66446008)(66556008)(55016003)(66476007)(6506007)(7696005)(53546011)(2906002)(38070700005)(83380400001)(52536014)(316002)(9686003)(5660300002)(8936002)(6916009)(54906003)(38100700002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EbAJlI48SBGof9Ax8Gy0rhOykHYiz70SfaCXrQpS5aWPEiCqDL0YuPll2Luy?=
 =?us-ascii?Q?g0xaW562uRFGJ/9t9LT02M5KHkD82SFWwG/x5wT7ChjAu6xVNgPVRaHglnVI?=
 =?us-ascii?Q?EHd8V3ZNbcpuDVRUJp288rp6LT51hVY2MPiQaccFm6gpMGQ2jo+Ox7fKNPiw?=
 =?us-ascii?Q?vT7ilOU4OAmtS4cUSIhxO3tYIWailOhHpRe4lKIRgWZ1yqjw5bnWUJy8TdLs?=
 =?us-ascii?Q?4nmw16n3otAR1cE+p/Yu3Q0o8SW3s075uzBInHmYmI5Bi/6XZxepPARe886L?=
 =?us-ascii?Q?Yf0KvZk4rvaGpZBzayZjd0ddiMwAXLqHCod0r8WPFVcR1fMZXhfQJ1GfiwHE?=
 =?us-ascii?Q?chPdA/Ku6dHkUinOo5mMaRmSJilR3DkQQ8I7oJV/JLbzv7jadwl6qaLyFHuS?=
 =?us-ascii?Q?AIpiyXuEb+ao7lq40h7hxZSBPfI+oWHhGKf5oO32vA8t7p9aRFeZfQYhdW3K?=
 =?us-ascii?Q?cSiYQRQraOHjyKiG63OOSfgXT6ImH5GfxxUQ2gDzTy1RqnSEElYadIQMZYQO?=
 =?us-ascii?Q?ugH/13iw7idFGSr6U/lkuw9yJUmYCxGuTY66w2gYqQMEP4Yce3ayff2wG90s?=
 =?us-ascii?Q?i4uQ9jjIZj36TZWtR/pJqFW8hoaH7BCXMOhhjuNpNAC9eYTCCJIuBwSe8AcJ?=
 =?us-ascii?Q?N7bZmcE3BRIBMjHZjPIthuZbuJ06PW2qmEVXXu8ZOVBk0q4cL6I4W8giTLNs?=
 =?us-ascii?Q?nr5an/tH0Mrzx2+Q1H415bNLFapAeONn4o4nnC3qiDWY2CbhlMuuBeTKDxMW?=
 =?us-ascii?Q?G5+S7h8NpQ7nhMeuC7gSQTcbEAcFthwW5jxS1ampj3RqhM0qg1XKbxDUDsY8?=
 =?us-ascii?Q?c0SbSb2CP8BT9kOYoMJxXtaRQWTF3CM8va70VwcJNOYx1SQg/5o5DTOJyEwb?=
 =?us-ascii?Q?SFevJV3dfAZ9M33JsjYRU+GLq/c5/UVK0eqo+UacPRvm8Hcv1IiQo4OaWN/v?=
 =?us-ascii?Q?aWR8cNkZ+SW0my+Muxy/Ejo5IPrQrqI3tv6A92pmt/o/tA+vXAnyPzJFzNlv?=
 =?us-ascii?Q?BHo5zLw37bGqVTXdi+oD/BpHvqtiA2rGQjPsRRt2VMRhBupAXvFOXjRWPmPD?=
 =?us-ascii?Q?KBr2RcZpk5dIKudw4a+kT1hiFdDaT2sZr78ejvo9OGW32M08C17sIem/FRkL?=
 =?us-ascii?Q?BXXhyiuNgj8CHLJqx+tMdxNGW6J20RfELKfbJVK9g+dTYM2Aj3sBC+G0Hoix?=
 =?us-ascii?Q?Y0YKQCj9efPd6qKdAWeW8W1JIoUJR1hwPGTi1KNUh2T1EQwEkTPOa1O+wX0v?=
 =?us-ascii?Q?brw+K7w4jxPcPWTle0M59ySVTS8Ipz3rIRhpywrr+6+HcJEqR7yI8zbQuDg/?=
 =?us-ascii?Q?pz4V4Dx/Ajet34U/mfbuIobluX6as6j1qrm+7oRV9V3aQ9Udkb8jYmp3BcPa?=
 =?us-ascii?Q?Z0s5k9r2/Njxbg9yCKBlG8IipOH/MWt4D/dGC4OdROcEPcN3r4081on8zKaX?=
 =?us-ascii?Q?3IPIw5JlvHXaWicKlGDTCQEbo1Eofu+fdQ6Xx/fZHetT7cuTMg3kU3cpMcQU?=
 =?us-ascii?Q?yoo3U9+wvjR9ObpfiLATEegWDY13NKLQzs4CTX8GlW7QWuAlJ1JTDtJMo3SK?=
 =?us-ascii?Q?PNVO+jQHFumnfsrh03jFa232PQomYTzkeDDizkVI/Yshp7KWvQhBQtGTMNqn?=
 =?us-ascii?Q?ZS3W3vpABLa2L0qt0Nx4R1B/OalJPNpu4gmwWjSKFkvOJjuNedZVbFjbDSdT?=
 =?us-ascii?Q?XI/UWIYFpymDRiEnz3za6w8KpkJNppC8D8u2ZswrCWhEcnyhiQiPpYs+uoI9?=
 =?us-ascii?Q?RRySNNM3p0xOmFLf++YWhsyxSSACupslfWEs4AyvkCBLVtIVSjHvWodzWNmc?=
x-ms-exchange-antispam-messagedata-1: aR/SbajiofZWXGuLXfO7lEFVGknivAJLfp6QcO3TUiAlIKV9a9cvcjVR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f60e5e-a26e-4b0c-3d73-08da10be0dd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 13:22:48.7112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxGApUfaApfs0p0m03kviyfZz7KQ2aVLNXhblaVbChP0LAG9whOfD6okYedrYBV3vBEVHuuWHp3qDM6rGVFyBirVjgW11Q21ZPfs1YtKNJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5523
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/03/2022 15:21, Filipe Manana wrote:=0A=
> On Mon, Mar 28, 2022 at 01:14:02PM +0000, Johannes Thumshirn wrote:=0A=
>> On 28/03/2022 15:09, Filipe Manana wrote:=0A=
>>> On Mon, Mar 28, 2022 at 09:32:05PM +0900, Naohiro Aota wrote:=0A=
>>>> Running generic/406 causes the following WARNING in btrfs_destroy_inod=
e()=0A=
>>>> which tells there is outstanding extents left.=0A=
>>>=0A=
>>> I can't trigger the warning with generic/406.=0A=
>>> Any special setup or config to trigger it?=0A=
>>>=0A=
>>> The change looks fine to me, however I'm curious why this isn't trigger=
ed=0A=
>>> with generic/406, nor anyone else reported it before, since the test is=
=0A=
>>> fully deterministic.=0A=
>>>=0A=
>>=0A=
>> I am able to trigger the WARN() with a different test (which is for a di=
fferent,=0A=
>> not yet solved problem) on my zoned setup. With this patch, the WARN() i=
s gone.=0A=
> =0A=
> I have no doubts about the fix being correct.=0A=
> I'm just puzzled why I can't trigger it with generic/406, given that it's=
 a very=0A=
> deterministic test.=0A=
> =0A=
> If there's any special config or setup (mount options, zoned fs, etc), I =
would=0A=
> like to have it explicitly mentioned in the changelog.=0A=
> =0A=
=0A=
This I have to deferre to Naohiro, he was the one who was able to reproduce=
 it=0A=
with generic/406 (on a non-zoned fs IIRC)=0A=
