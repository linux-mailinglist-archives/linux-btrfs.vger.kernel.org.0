Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4F476C172
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 02:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjHBAVR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 20:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjHBAVQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 20:21:16 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD8526B5
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 17:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690935639; x=1722471639;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u5YSLoPBQ7bcw0JXrJ9lWphnRh6Yw61Tpn9qrDnFPOQ=;
  b=jxj5W+oCsOUMzX3LiqaCZLNedYiRLYA3kcfa5hAgRAsb2uVpkdWkcRoS
   kJ7vVxacegDT+jw7jYa9XtXhbqchzuqC9aEreyLp5/8vmZiyYUTrPVpTb
   bGJPoxmU4tg0jwxTL4GjV05DI3tZWyAn4Umia090B3aOn6N6fL/8NWbSL
   LWm7g9NZPmUJAR1HVoJYvaDB+mhk65quMkQgZL+RimQ+KEZVBAzmrlyDy
   AG+Lw2eFgtgZy9bQedx6WgaV1OGy0z65Zsx7bVpBGMvTwhPn7jEDwphhM
   c7CO+boPI4ZrQgyBQhlhwQRw+XUHqGYxxDiMI/5Qcc5DyRGhtq+r3ew63
   A==;
X-IronPort-AV: E=Sophos;i="6.01,248,1684771200"; 
   d="scan'208";a="351846347"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2023 08:20:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODgDSdwn7OjJ7eejt35TlygsGQAY0CVh2hjRDvuTZKoDNog6/FPURZJl6mO8QWEeOfxe3mFps8Tat8xqaDj6nMkU3Vsiwbg7IuBE5I+Ox4nVYi58GlbVA+e131ZJTY2QHukqRkGwpwPRnqTlcCS9jGSQfZeP7vSy7Wp6Ww7rWxDN5l+G9VIVFHHf6SS0WeStUVoYDwYZiDiyN8nY5MquxPLuCAt6wvUjNRrnCHfec9dsh1h0mfoxnRw/xT3D/Evk5WjINI3FurJTfAgLz/5U3mkau8PZa57uTtgINrNiFWLvEIRlYPNWroz6LCisgm5/4rWfGFHU7FzQmGFAY7wQGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5YSLoPBQ7bcw0JXrJ9lWphnRh6Yw61Tpn9qrDnFPOQ=;
 b=Tf/jgDqqN0Xpg7ZGDleDCEb5H6CCFGkVWhoHlS9Y4GoUbxccoBObINxuHHSzv5oq8zB8JE3iYqBJ79at/zNzfZLPmptA9PpU1qQpgmdF9B4Ei/0+k595oQY5cte2HTYu/aYiCPcbpcCirBhpW8qBxBPMxB4l2jYuT/F8YRylai26ssvEOYTk/DfUJVm8L5YuG6Y86FL+l5xSVoszdYXEvFW5nYu7MFtduaiiawezgjGLPb2wvzsIt0RzgfTEV4+ERn4BBsCTGeoIRA8icEZ53q+eMSI2qdKAP2li+dos1ts/pbNEpIcLoU1Zwm0864cfXgmDjSPuws9TKVN4RVnNeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5YSLoPBQ7bcw0JXrJ9lWphnRh6Yw61Tpn9qrDnFPOQ=;
 b=FEbd7HqfnYkQ2PMGo1jXnFfiEMFh7D6ZnzwE5tKGEcWRbV2buHaGe4ofYZV6L3advipnunwQwSrIbvuJP8S0ARM67RvKfDX4dvn3txgT6k+fAmw5zijnMA2dhMMjC/clzEaxCODatndPkSN3cpkjs6R0Lw6atnLSrryzXovAFoQ=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SA0PR04MB7209.namprd04.prod.outlook.com (2603:10b6:806:e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 00:20:28 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::3899:f57:20a9:c783]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::3899:f57:20a9:c783%3]) with mapi id 15.20.6631.043; Wed, 2 Aug 2023
 00:20:27 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "hch@infradead.org" <hch@infradead.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH v2 03/10] btrfs: zoned: return int from
 btrfs_check_meta_write_pointer
Thread-Topic: [PATCH v2 03/10] btrfs: zoned: return int from
 btrfs_check_meta_write_pointer
Thread-Index: AQHZw9LpYmiKM2IKJEy8f2bNQAy8k6/WJp8A
Date:   Wed, 2 Aug 2023 00:20:27 +0000
Message-ID: <lltj7hasnymffwpndvsxosyezpqfnqeq4birsfuunblw24uxty@rcyrsee7vr2z>
References: <cover.1690823282.git.naohiro.aota@wdc.com>
 <ae37ac63b97cdaa01a5fe15cd5b4607620776457.1690823282.git.naohiro.aota@wdc.com>
In-Reply-To: <ae37ac63b97cdaa01a5fe15cd5b4607620776457.1690823282.git.naohiro.aota@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SA0PR04MB7209:EE_
x-ms-office365-filtering-correlation-id: 769bee69-7c71-4598-36c9-08db92ee460c
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1XO51ubX7EOFgzrbYDxoIWj4a1n33dh20LQomV2odswzGGpMa1fb7etdRFsy9aG6ZsGP3i2sI5UDk6fe224wD9EAt0JFoDOg1ZTO924uKX6MIOP71UoJBYFYXi93MtVserkyPeovzmjPO0Zntw/Sf1tC3YLainzy0HX1HIPgPI4EsC5IjG7rkXhrA32P5ROLSoImHBXK7rB2AJXUFiBFA/GhII73IHNt4FWRUPyWgG6B038v+K+W/115t/Dft/U2L6vse1XCxVzoAsMOUxsgPTSEJw7TyamjHcwluUBXAhK5S/W9kOxVW2dWlp/jkDI2Ftn3pACk7SvRTeGnehKxmcMYwBb5pkzyaOYcZe5Xrt3yy8e6SslyD5XguIi87GmG5A3ONUOMMpnyIRHyeXYqCU0nUdg/WNWZqUN43iCJ5PhYugbf4jmU8SAHDLaQsNic76fGx9TZs4oAQXfAvlyFEGVf4CdFsg5J1Hg5zZ60iyRYydVDAXApAjV8uCGTWfP6xZeF49l95lQKO8eVuLYM+XTS96nBZTf8tJMvaoZdvVrRhy/DBrSVuxYVMI6wb1xR5pyWo8OHkTQZ+jczurTjnxuryQhbIls2xcdGwhj9ihNvWcJgGY5KLzCd09Gv7tR1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(186003)(6512007)(9686003)(316002)(86362001)(478600001)(122000001)(54906003)(38100700002)(76116006)(71200400001)(66946007)(66556008)(66476007)(66446008)(91956017)(64756008)(6486002)(4326008)(33716001)(6916009)(82960400001)(6506007)(41300700001)(26005)(8676002)(5660300002)(8936002)(4744005)(2906002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fBZUHL5ly4Urhdmw7BouR19ts4Y+fc8xa9XojP2/2erHGUUCS8fSh74hE2Sx?=
 =?us-ascii?Q?33Y9HTJt+qA4oCR9DLXe8XAGEqfPyhA2l/Zoyg2QpbItskMzeSXtW60zrXoH?=
 =?us-ascii?Q?LbcNfmjKsM542JvXKeirpP8PzM49uX/dIwuassGuiQ4LwBXPdvvS/yQv+yB9?=
 =?us-ascii?Q?VsLDjuyNVVky/v42HRc+bYapJGiLd2We4PZdNavmSW+ecVL5roIYxzYmZiWN?=
 =?us-ascii?Q?L97wjVqJQj09sXviAu0/B+7IRkoGjHSgxoeIXhpJHodEGksiaTkOXoB6XjVD?=
 =?us-ascii?Q?6Yr6pUD+244RkxjypTdAT7E7wszbGZQNTVVE8AFBQveWRU9kjzqCekgpZRgV?=
 =?us-ascii?Q?NX4YaE2UBwqGcVG1c9TAIhNCSGkDgSHlHfcTmGsqPXUXnNMxvipwdOd+bAKG?=
 =?us-ascii?Q?TXKJu9MgMbgJzWiELBgo216ieOSzxdshi5dFWBGJizpPvjjfjhKrFhoKTHvM?=
 =?us-ascii?Q?9pYOmw4DpqhWAalCtwljnSzVR0Ag8vRu2gSf1PFV0NqcU3BzzVnECdW0KRom?=
 =?us-ascii?Q?0bilimKLbEXgb/bUIcMKEK+W9UyUWKgcxDfmzZXD70AqJJW9BYEvohGyz0uw?=
 =?us-ascii?Q?UUnEicZ0dkoB/fAzYOLso17Pc5P3iDxltaYb0OBzx87zSkvkLxG7C5LogT+D?=
 =?us-ascii?Q?lsKZi0iznUC4g/zvqRhSU2CcuMt0hMdHsxqxsWb1A/VtII1SswgOZn92/ILn?=
 =?us-ascii?Q?RvlcXQ5+7zF0oro6Aqbjvwlbj38aH7gA4DE0/a7197NUdy04zupQS6VnL76p?=
 =?us-ascii?Q?vie8Li6oRvW5nx08ZnbLeO5z9gwrtU0v6GAwuI7E2RBT77Y4DNPUi8ocsDvl?=
 =?us-ascii?Q?yvOB4dBAxew2F9C21KI6JM4oeUt9Qgc2nRb+yS4V1CJuWW4HlH+ZuFVFHpDE?=
 =?us-ascii?Q?CRoQ7/XIlbfc2yT/kKn2SoP9J197miG7lVnr+JNBom4TyWhIlcHp+kFYInrq?=
 =?us-ascii?Q?IoddXqo9fqsoJqICHypOJCJOQfEgo2qk96si+UXqUkhsevLABzzCL/6QTmFl?=
 =?us-ascii?Q?HobYTwgeR8AGOseJCtlzDBVp4lREXzvOJbdRd+attWQvj1RmaMcoxWwqXJlg?=
 =?us-ascii?Q?CCdNRKgbCqJDdhBCimnvcEneNQzNcuuMSbxjGzXHRgH5v0sb/PowW3HI6+3F?=
 =?us-ascii?Q?9T6aq93gFwiZDkRXsR2B6K1hFXnNqdIHnA685pK1d3IrH5sP85sH0seArwVM?=
 =?us-ascii?Q?WvPTbONA1BGH5RB1CLm8LdyHJGMqMwLcmIjrL9agyiHR66EzfKjD958I0gZs?=
 =?us-ascii?Q?rMKidojQoWGFaIKoO50iNx9O9dQ5jyZHofgpP1anQoxXE9VOvmQqQctEygWK?=
 =?us-ascii?Q?k1UvjFJWayQJLIDXMzzvRMFgA9oywHk5hrvgge7JcrUbJC63bRhOLwq/WpBq?=
 =?us-ascii?Q?nhgcAK4H2MCrVBJOEn8uRVMrINI7eSmb5nHRYKs5yLU2NGSYYy8p+bT54ACs?=
 =?us-ascii?Q?nk1V3zEP7eHDKOrY+tIHADEDxGmErl+MHEpuO50UVXUtnBKTF3o61ghzFlJP?=
 =?us-ascii?Q?VmIwg3H3UzKgDM62xy4dMKFbm+BPQUtLDnrnzsrCDi3Qg/F223s7HemCGopT?=
 =?us-ascii?Q?iwAaMSjHX4jwbWKihXS5Lka+QjkXHVgbPAElSjLLqgfkvQKbcaWcmDHKyzhG?=
 =?us-ascii?Q?Aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F4E811A9F4E42F4692B59B4ECF61159A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: r9q9QUyQ+WMpb1DPdN9VbX4ogLWFvUireJaf4xJUwP/PlRLhDKY4SYwufi6LZAG4zgGvIOvqNcoLMDJ1l1UDES+m64hYvJVOAOQFkwrDPzSNSwfRccQ/AyzwPoCWEMSbXZy2fdUK2jUSNZzx5QYlvbu50hBWliNSmfGXEyXSOh+Abwvne3xAm+lgswuVmQ1ZXfb2ZerH/oC72ZyX4BA7p3ets8XI6jEJJ0X/5RqmxLsgI3raytEz9U8HEAWuqK6Ni2pbD9OWB9v0uPvWJTlx12/fQEMFMnwtRaxUNZfLb4iwK69x2K4wRszSnCJrg27spIGfFZ6KvQY7bz6ahRvpNhbZBMOz05qt7dmCU16mrf95n+r2cyiy+y5eeUHS1c6utv8L+X39hSTVfpXo1yTmIpvdcc+HzBi4m1/OZaBbwc3HwhpihXqPREuGd4C4GC1YcmiwPNXLUKNdiA6ifaiqI8AUo2dVNcjyz+fpZkgwr/u2U8Mg2VeCcEXoPOyNdupxKSIkMMuijUK0mkbamp7+JY4iMFtC+/1w04NayFSUtD6U+5TjQoKwE86uJ67I3b/4N02B7wjY0/qikV6OQUh38RNE5mPDtF5ZbXnMxiwVGMdfK0R8KPsSZtWlwJv96MWsjsXCn1sZXuxro3z8tz1B3CUhy23bdwywL/WkxIPyENLjRu4zVuOY0ICVGF9kMO/0uMDT6cC88oXgV43DCmOTtDINYItcy1U+Aerr1Egm1bdxfP3xVAT7WQIXs/LeV6Ug1LHCuxh5dPlEH71AN9uupVHGNPRQHjmmyQnQ35Za6AXspimAgMLrBUtugFAnrCa74PU0FnYNmHE4Iymada8bk05MgH1MCVuyg/ZkTjkiqfFtoVtS7yqUz1CSrBhzO6rd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 769bee69-7c71-4598-36c9-08db92ee460c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 00:20:27.7691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DmMcpoNMq8uqbLdBKDfwGx9rQUT88IMO3RdklpF5DVOAVvRKgTljwAesEVmwu43Ig3OxjDW72mqTuB1S0sQHlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7209
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 01, 2023 at 02:17:12AM +0900, Naohiro Aota wrote:
> Now that we have writeback_controll passed to
> btrfs_check_meta_write_pointer(), we can move the wbc condition in
> submit_eb_page() to btrfs_check_meta_write_pointer() and return int.

Oops, I forgot to sign this. Just in case,

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=
