Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB75056C93B
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 13:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiGILiD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Jul 2022 07:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGILiB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Jul 2022 07:38:01 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EB05926B;
        Sat,  9 Jul 2022 04:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657366680; x=1688902680;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2HOTkZnxySAh5vFXseZBz08uXR72gPlGujJSudDPzt0=;
  b=O8CXCKacoYP4L4AwGw/t0wKKvus+CxP9jj4M1L1ElYf4ogJFZRlBPJrm
   Ru/3eAfagNysdFH6HUmxagEc+3Zxn1ZhxsWb5YOrLIGdOkrUyEg4Opo63
   sYaDERuvjJ1GGzQ7avuEvSD1GAYRYZzLVnfQx+kUFqeoFHZIyquSshGIz
   DW24EqcywJE2eM0vX2YudoVeOizCDzQgsZXIeO4Hg+3ki+pF0JMc84CHU
   X9U1BxOqRUl9T7QRMYPgYSkPmmiNLLyeiwCUpFGLq5AQ2GgpbYZCQM9hc
   M3YNjMRCyeiqBcLxNwoQCxujHJT3qyYn+GktM4xurWmyd/k0R8w08DDMX
   A==;
X-IronPort-AV: E=Sophos;i="5.92,258,1650902400"; 
   d="scan'208";a="203896020"
Received: from mail-dm3nam02lp2042.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.42])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2022 19:37:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSIlrRAXagEAq9jPWEEDiULZtYrKLM1hCCnPubWtbIpOdaPZZiLuqzuC3S4usGB8Y0q/7H9tOjQ0F3gacZxkmvGOnFSVCi0vaahakSJ1NO2Nqk7nFa4YYsEzSm7s178l5DHmIPKh/EPO6d2nlYjdk5ByRsnF3psNwziveTHYfhm71U1jnGngqarLIt6ZOPKguMSKtMD7+RnoOs4ZAKD8Klp5AkUc1AEN51xIJ+w40RvpDISnAsqAr/7w/5seoMRNXBHT4v9spVIEI3Jo4r+CXYZsypsQZzLlKFF2M3mf+xAznZhsgUxLqPhPFCh21GzltYnrQ52+R6SrRrXJM4cV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzfzQrBiht4jKXU+MfC/3zQyq9kEjqvkBrG0woCiClc=;
 b=C13H2XUg/DUwpT4VP4Pp43tlHzyDcmcqrPVtcxZy4AHjaODgJrf1Kq95/QwyAq9Ugvs3xmwGlOlZTvceRzSPI5YLev3zAGuHrOT6qvTJ1clt3zkXXwqLLXRo8fSfY9G6poPna3PBNHfC2QYT09DHenFbwroEKyL/Q2zEYXcXZsr332bh2EovB65nMCMQWwnttGbdHLyftYur5g//0OL6PofPpEACo7P1y7RgeZjSmnNzBVtIW3KA8PHnSe21aG/DZWu4bqtuFSTjW48StaYjbGobnsLtClxpHCVYNrixos+cuyqHlzHo4tkI19moTCSWgWHuL4RpMu6QWFFmJIeGMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzfzQrBiht4jKXU+MfC/3zQyq9kEjqvkBrG0woCiClc=;
 b=pi151njEavlAvFvMaOgVA2in1VThg/M6eWVeEHyewyuOr7qZzaFZRmSpt53YOR5Lvk8Nx28ngmt3hiMDtmSMTLRPM69ydGG83qMj5OBc9/ZwsO96hbMfLM2KbWpxdT69IlS/BcZKuH/0RxaOGxbN8r1B1bcVt83bZInsxguXFhc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6737.namprd04.prod.outlook.com (2603:10b6:a03:222::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Sat, 9 Jul
 2022 11:37:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.023; Sat, 9 Jul 2022
 11:37:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 04/13] btrfs: convert count_max_extents() to use
 fs_info->max_extent_size
Thread-Topic: [PATCH 04/13] btrfs: convert count_max_extents() to use
 fs_info->max_extent_size
Thread-Index: AQHYkyF2di/CBAYuVU2sb6AbFYikpA==
Date:   Sat, 9 Jul 2022 11:37:58 +0000
Message-ID: <PH0PR04MB7416533E17C3D3AD155B6E469B859@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1657321126.git.naohiro.aota@wdc.com>
 <8492f9cc951b3324d6b9989c194fd428c799793e.1657321126.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc0f1935-2808-40e4-cbb9-08da619f78fb
x-ms-traffictypediagnostic: BY5PR04MB6737:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aCeqk8UEzRhGoiCkPdlQDlTNhgY2zlfrR7UxFLRItXywqGtohwuNPHpICeDceUs+LuLuhHbZSLkqG0upQVywSmPpJWzcgJ6vg3HLKRa25MD0lLXyCkroUUDDXPxNvHedI5gSuKLe0LYrYcJWmKtAsfeCfuykmuaQdQtkzdEAU1giTw5rZNLcBAxZXTPg/U6P+Q5byCni3h50lL1C75d/4D7MIsOop6tW/VdWg6oBkLVUpvIk9t6LGUfkTogarlp4utKYuPiRon5kX8BTcjnVzVHVMEZWmDvTJ4dhygRQ46ClfwgWkqlgpRkGGUGO978kGEdOf6Nelaxtn6xs80DBTD+B3TfPEEGX5qPhD0GfggI5/097xBZ5fjph8ovVjA+YKwtfuL1q+wm7amcOROK/djgmU4LdgklsYbXZm5P89BB4XbyE5X7mYJJ95uP45AlGjqW/u/fRCZ7g7Dq3o+0A0Cm6wGr7EmHruO5eyXAOAfgv7RIKQrFxTJge1cUqDv59zDqIHfHueTxnA4F9UtaPcfe4YxUMeHb8pkyfUBKC58mqiN/lmXG5xps+iC3s0RM39vV7YreYx+IFsRN/45X4HP3sdJon0AKjotyyBx9H4WmecDoR2V1vtG3+Fh+knzHfvr+fK+uj0eRzaRfrlevSdjscMw+6Cj4kwYOW8Ag0F3fRBnI1Rk/1MeN05iXkxjfJg+b2EyexrRlSzxM81QC9uYAiFy/dPeS6Qrfa2z+M3LQ5kPz4qfgTmsLh/GZoSYHNK65TUPWsZ65oSzGXskVzKB6bg4aiW5MPoTJkjFz9ggzKscwiojFk5OnuPf1STBVs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(53546011)(478600001)(41300700001)(7696005)(122000001)(6506007)(82960400001)(38070700005)(38100700002)(186003)(9686003)(76116006)(91956017)(4326008)(4744005)(33656002)(5660300002)(8936002)(2906002)(52536014)(55016003)(110136005)(316002)(64756008)(66946007)(66556008)(71200400001)(86362001)(450100002)(66446008)(8676002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rVNF2BRaJvq8ut0AQ32eH3PTOB82yGnn+B7dHyL9SpqjC2D4rrpe6Pc01XKB?=
 =?us-ascii?Q?uADaBEc4Pn1wSC/aDgtGM4MzXRC7NeMKmRh2DKQvWQ5GOLL7w8qitacY/7ls?=
 =?us-ascii?Q?vEavwD0pwuImpBg5Gtk2Ef8l2803qOGYnsvk8plKSct8LuCo3gOauri36wVP?=
 =?us-ascii?Q?l//Ck+QQBg22k3ilQhuKA3Q5VBzb3D2ERzKCBnw4LNIvOF8UuwDPV7kJdXXh?=
 =?us-ascii?Q?UNxsr0qbKSGR2kGUCCk0I+QLqdzK9kcyWA1kpcVmrWokJ1iPutPso2RYBHsm?=
 =?us-ascii?Q?v6zxtyFSF6GPbmPWRjPUttd0tTV8I3m/gtOQDVSf4fFi4ywpO7Ci9Z8RyUTa?=
 =?us-ascii?Q?B6ZFpK6G8+IIxsT48wdeC7MmwGYj+gpLCIA9XgQvM4z6UvhsSLu265Q4PP1K?=
 =?us-ascii?Q?6RDjo7Yg8DXxum5Z39Tfy83HbT18f2xTzFvOUWiPc3obgXnmM+WnOABGDFfR?=
 =?us-ascii?Q?MmjPS1WvmNaWHTWna+mOdcxPz7P0Y7hXqE2mKCv0dOuT99sywf7gxvlnWQUu?=
 =?us-ascii?Q?ijOqPF8vJqYSJh2LWmdqAyT8oxh2ZgZaycsb2wfzDVszCWt1Pp2mJ7C+bnrc?=
 =?us-ascii?Q?jEq+aOX0WBq0Gbu5d5e06/2ZKzKoW3vpeMIp3KA3a4q+RWV7WSSVJPxW6oFc?=
 =?us-ascii?Q?GC7k6qOe0zvh8KRGgWEHNqO1DZSBnJZ1z5rYNRAHnMsdWi4i/h2GcGVd1dHs?=
 =?us-ascii?Q?SdKcez0qrwlIJWX6NB28hNlMen2BOah69BDHkGWH3U4z5ib7FDc2GkT+kQF/?=
 =?us-ascii?Q?D8p+7Uih0+qNwAX7TmffOLQWxlbC0RGOMAXHqwye+PL7uUUqIJ8vtObMJJJz?=
 =?us-ascii?Q?/dhGmm7bWpGHzIqYPET9Z/UFe0Y6lskPHVPraUMFlnqkcrQ7nr76CmT/En/d?=
 =?us-ascii?Q?OOL9ihJe5rJcUp9IGauuBxEazW9nHkGl826qRqeBJ5Ah7Z18Wop4TauXyuzn?=
 =?us-ascii?Q?UOJbs5sMv1slpFTQI+WCsiFk33Igd+XeQeNRu2dDu5ssax//ngTuelTfDmUQ?=
 =?us-ascii?Q?HyRUC5x1JEPFaalkFFnE4uc3pxzSdfwkjpJsrCtAoombGbH4nI89ZU4tLN0k?=
 =?us-ascii?Q?TtZBXUsAqi0gau+NmpEpkGsVUxYutMVzpgCAEbcIsFdruHFT7Y287Y0msqMY?=
 =?us-ascii?Q?kF2x13FBglqCmePz2GtE0+wVaSoTeJb7Rp2U8pP7P6Z0V2lxj4b41xtnuirA?=
 =?us-ascii?Q?5pz1mVAZw5Xm1urlgDLu9KvO2EZZlOT5kaaWxWOH/wvaS+DBOFD5uRxc/9Oe?=
 =?us-ascii?Q?7fE3PnCezZP1aA/SzKZ8hsm+4w8Dai6b/q5ED0T7nfV2sd45Jv/elcYGsUs3?=
 =?us-ascii?Q?MATttHlavV9C5rnreqUxPyh1EYg4LPDJgej6EL05zjWDQFiQ9mWzMDvHtgdN?=
 =?us-ascii?Q?79dk1Fj+nEh3iIRtdzfS0JlInnZpYacfWq04upfZKMBFk8M62sNKlW1yNz/L?=
 =?us-ascii?Q?2tT3/dah/4xJXKeuO3P9fRcDuM67SjhkGUigblKhwtOK4OsArzCguLqVZ9i7?=
 =?us-ascii?Q?GilLyBZdXjCvfyaVUb+c8CFi9Qj8kctcI97oz7owfuDavT57xiEDq71cxJvY?=
 =?us-ascii?Q?Q99d7mkA7h+cf39ZEe7n+IiWRZsL2aY5qcrJwEMkEYdiWKh9fg/BjnIgEq5I?=
 =?us-ascii?Q?CsFFreR4qKymDTf0/iaB+KJvCONly9r0iQmmR8LpoumGHvyB5tjPuZPXmg7/?=
 =?us-ascii?Q?aAOeSa1ToQ63e/P8rsBCGGrwjl8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0f1935-2808-40e4-cbb9-08da619f78fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2022 11:37:58.3183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PqSBICOeV6bkVu51tgpaVYSKhCegtZYLg6s7OLdAzQKJsX3DEXjvbCtcs4CZU4WqO1ttnQhNCh9lKJiQ+KtkWEJ1xMJlAGR1Uom2TXNlKAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6737
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09.07.22 01:21, Naohiro Aota wrote:=0A=
> +/*=0A=
> + * Count how many fs_info->max_extent_size cover the @size=0A=
> + */=0A=
> +static inline u32 count_max_extents(struct btrfs_fs_info *fs_info, u64 s=
ize)=0A=
> +{=0A=
> +#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS=0A=
> +	if (!fs_info)=0A=
> +		return div_u64(size + BTRFS_MAX_EXTENT_SIZE - 1, BTRFS_MAX_EXTENT_SIZE=
);=0A=
> +#endif=0A=
=0A=
	if (IS_ENABLED(CONFIG_BTRFS_FS_RUN_SANITY_TESTS) && !fs_info) ?=0A=
> +=0A=
> +	return div_u64(size + fs_info->max_extent_size - 1, fs_info->max_extent=
_size);=0A=
> +}=0A=
=0A=
