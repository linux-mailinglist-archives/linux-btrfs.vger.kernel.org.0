Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9C36A845B
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 15:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjCBOp7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 09:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCBOp6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 09:45:58 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7517011641
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 06:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677768356; x=1709304356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/ThFIR2RaRoHuzeady/bNGftshsb7RsPR8UvTgHBZLk=;
  b=GZfDjMl76KZjEJwLIC8bwt6+QHdxQZcmBlInPZhF/OsdpfdnO0o1cuc6
   JDQ+NJY9sjJXBmNGgtnuxj94VBe+f/ZIbx4lPHtg6PTSlrpw7FPgkY0tu
   8rpxyDeAIa4kXDqZs9eyMlV7WM4uUCLiryxTwUP621yiMsgo6W2fFWsMy
   OMiPBJyhRz8nuuyKcg8x3t2swR20bKdytAAEi8iMxRT8X25b4gJPf1CHL
   8tOKwvTGFvEU0dpEqkaI9UOeRd7ztxqIoMvjO5DhQwb5WdI5Ybj/lzotg
   47MzKhg1eWdEKy7VZBDq6yuG7Nkkp25QoevVSkjg7NGwCTPtYVT0t4LjH
   w==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="222921332"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 22:45:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQn5bZZXhKZn7iUNADZcgIrkcNHwjo2KLlw7EOFHxEH9iG+svLYGR7a+HKJTnf8eNg1eakxGUZ0NYhPEn/ryymuro1UJBoGrJ1XuJDMdKtC9WeoBDdkk1WzOG7H654uHBUJec+eISkBv6EO37j6CjZOxOrX87iF3jgALJ364ID0Al8PRlbKKVBJ3M9KqEa6GY2kD0lPcAJSSuF1/wG9xci6hZZbltE4nyJSTgt/tti2R3Qz42l6mgKJzfpPShF2zBA+8OQ1xDmoF1phBQpRirnxnanK+NPBCEQZv3xEiBkr/YGHVyYLfoNU9jnRhW0uhdHkJw0YM9gMen6/CSCu7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ThFIR2RaRoHuzeady/bNGftshsb7RsPR8UvTgHBZLk=;
 b=SFNyRAArEAliZzal1rs31NmsQ5CeuyZNsi0h4p/RuMSK234BZOUkEGMIC3JqAJdI0K9c785LqYRMVRYXkNPNDk1734iNEHx+1FNkDA/ct+5t+DY9wLJIBYIbhUwogXCrV4exsjm32/JQu72wFDCch7ysviOmm8Q58QIITLb8HMk8sdxHq6RZxEpUxle4EJXLsfnxmwcNGkVPIwMj9Wobr2xJfTV4jwqWTF5xhRRByUeKe9s55N7DFt8tY42IJdSYRaFU8hoONL8shNr3wt50iB85HXPUUy+jUEkRJx4JT2rmTGbn6+QyXteAtzNfb2jyEXcYZ1QdTMKCMfvHE7IWxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ThFIR2RaRoHuzeady/bNGftshsb7RsPR8UvTgHBZLk=;
 b=lFwQIRvMvvvrR1e+mK+r8JqCkSmRtJQkO7hn9774NMpxk+KdBrut0lYR/Td2tTLCBYAy6o9gmyE8aefXUNdScUIeI72BfP3nTtK3zjfv+KizHdo7xMfdUwmYPcpJ7lfEkwfj6Tr1B5+ZWXu5e3Um+W+av4SGVgGHDVkys0kpK+c=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SN6PR04MB3919.namprd04.prod.outlook.com (2603:10b6:805:4a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Thu, 2 Mar
 2023 14:45:53 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::2e44:805:e7e7:8544]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::2e44:805:e7e7:8544%5]) with mapi id 15.20.6134.030; Thu, 2 Mar 2023
 14:45:53 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 1/3] btrfs: rename BTRFS_FS_NO_OVERCOMMIT ->
 BTRFS_FS_ACTIVE_ZONE_TRACKING
Thread-Topic: [PATCH 1/3] btrfs: rename BTRFS_FS_NO_OVERCOMMIT ->
 BTRFS_FS_ACTIVE_ZONE_TRACKING
Thread-Index: AQHZTILnwoAbNibpP0iUeEj3VsUy567nklkA
Date:   Thu, 2 Mar 2023 14:45:53 +0000
Message-ID: <20230302144552.5ht2gu3szqoctnz7@naota-xeon>
References: <cover.1677705092.git.josef@toxicpanda.com>
 <5cb6fa87af8959b0ee9b33591968812fc6b4ab87.1677705092.git.josef@toxicpanda.com>
In-Reply-To: <5cb6fa87af8959b0ee9b33591968812fc6b4ab87.1677705092.git.josef@toxicpanda.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SN6PR04MB3919:EE_
x-ms-office365-filtering-correlation-id: be3749be-7950-4e76-44c2-08db1b2cd2d4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v4bDEVYTv55SbPSf8YMfNabT6UPjVvI11KHPsHbypjE3SW7eXcE0iwT7ObX8mhjzv74zZPqfGI8m1M3URqYsUZEyiZhDxqSM6R3ps4I8ALcfdjfZS7MZyXEJ2W9B8x8Tz3u8iyQuLQiR5zwLexinR/AEo39MM/75Os2tUkV5t/s0T9AxPE3/ivlHFKkfTbO/gSTx9ZssKXwD52v2N7l2iwCIAkB9HS7jH6ZjYx9iO0WVyOIkGuPhqCJlWoX0LM2sHYFdVGY5KGjmdMbeKqH82UNcG8mjjzX0hvAKsgLZW+dCvNrRPF48t/+0xs9s6CQw72P9EBw3zaMJfowbQ+Ca+9pptbWSCl1x5ik5GPEzM5F1VhQX46u9cS78zBSlDjzPL3aHvUJUiYDBY8YbrN0RHtMvet3UwzGi1yM+c8hsnUhXnInF8l6WJsGm9/Jy9bB8YzyWH6zXkmrBpFntbiE9VQNChsL+PHWNGK1rCD8folwMiIJswbQL6BGBunE2hBiADlNsZskHSe53iMlDDnRNO+X9ALy8rRfjydUVQPWOY8GiXA2kebcXbHa2nMa80XIjlHMkzbIHSVGm5EVchRYBFIM2d0JqttAtnL2JQqKSNtoneOMRprNBvfFCjeEQ3sMUk/4nFh136Bp7JyA8XCDe+Vium3IV/uw+2+XWEoGFovtPNaGswVDoNDdex/ZHjUFFgOw1MwNr26VdJiU++ktqKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199018)(38100700002)(122000001)(38070700005)(86362001)(41300700001)(66946007)(66556008)(82960400001)(5660300002)(6916009)(4326008)(4744005)(64756008)(2906002)(66446008)(8676002)(66476007)(8936002)(91956017)(33716001)(1076003)(9686003)(6506007)(6512007)(26005)(76116006)(186003)(316002)(71200400001)(6486002)(54906003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tdbIywUzosOBkLaks5+1X+8vc069qm0mskjvyRN1nZYITuU2DJcYhCwoL+11?=
 =?us-ascii?Q?Y2ZZ45VC+KWJkengdRgN2jmBCw6KTaTYacTG/J1NndGq74wiFPTzIupI+Ol1?=
 =?us-ascii?Q?QF0aaTfOwR4T7qRXzO6vQQjVK5YcuHHgEIsHJfD5EiAeF2M2EkoIJnc8REHz?=
 =?us-ascii?Q?JXBfM9YiRnNy3x8+v6yvOAXI1fbq3iBGrceWkzif6YzB8HMmtnehtacbI6BS?=
 =?us-ascii?Q?ZY2bw5S93VRXsNl4G3zBh/X94GZjCndOyacjF4C22cdv6dj1YCBlOem058+U?=
 =?us-ascii?Q?Q2Hveh/7GuzfqMb41Z8jV4Exh24FPxDc8/VUJavmaWdxxNcfjuDM0cXAJS2q?=
 =?us-ascii?Q?5lT1R/GPjBNrEDE+quZYixhO7j/YqQ0cQf9YnZGe30KrR/WhBHfeXe+n7q0d?=
 =?us-ascii?Q?vNEaRAsybOiIYsF8sGk9JHL15VifzQpEro9M+lNgdHTM8U91/nRHmOKKTObZ?=
 =?us-ascii?Q?SnxgLouftf2bU9MQzlobzUG/1LW48k61SjRl7t+1VbBQ4iYJgyBxzhKfJf+u?=
 =?us-ascii?Q?o0yUIMz5eBImJeyYoqCLOCifeZtAg2kXs5flVn1vFYMx8Rdt0sId0Dm11LHM?=
 =?us-ascii?Q?PaVLw5qZ6Zh00EdrZd3+8+zkvNyEAF9O3VyD3Zj9gw0CedeLlBZ0CE8pSXly?=
 =?us-ascii?Q?FYdDX3IhGPGvwJO8RXNKuAwks0qzAy+eGcihBa0vxaHe3SPOGLY8H+xXuThv?=
 =?us-ascii?Q?iPTIb+xI6pARCt/E4fH9um8QMpjp8LEpcq6glegtv7c20O6N2UFtzwlDZc08?=
 =?us-ascii?Q?DNAusWg/PkQldVWmoMBZFyngJtAvi2Fyv8yphG8PXiJd2mXy/xD7SkLiNhvy?=
 =?us-ascii?Q?vWAheJFqzudArVLb0+01/QNxT5me3Xp/PE8AmdkwMEq0cdiqZmgrGSbT93vB?=
 =?us-ascii?Q?PAT4HbAw3TappA1kZhRillXumN64RYCEU1Uc9Qh/V2EwTbLA8xis7OE67ep7?=
 =?us-ascii?Q?hCITXwxm25BWQ+B/7gCC82qQV0ya4Wtn0kHh1izpvcE6T+pNaLmga2bmKSU+?=
 =?us-ascii?Q?84wyqWc2QTcGJww5G+Io6fko8dIvG6klP4UtHCpNuEHL8/NGEUPTDASFH4J/?=
 =?us-ascii?Q?i9d1fewryXroXFfO1+nphIMweAHKLHZFNOumcfv5sNycjky0AAcQa2cnId2A?=
 =?us-ascii?Q?cyMYRRpQDAIMWK3wmi898wyhd5ioWwaoGVeuNvEBGKnKHtgNUB4oSK+7Ddkg?=
 =?us-ascii?Q?hCMIXR33yF6yYgy3Gxrvf2IoxULXA9mDSqG8mT/cX1fU04FYIlZeMY37Qn7j?=
 =?us-ascii?Q?fWtx2PzSzZ9v/kIXhKilfrWfgptdMnd8qLpn+k9QH9agSmZHtexkE6CFpB5n?=
 =?us-ascii?Q?n5tUfngdUBEmx571APEOtv8KjMuMgpQ3E/eZ8s0Z8R0YnfyPQm0Rfk/21P4w?=
 =?us-ascii?Q?JzXuId+8/GXb3uIA86NkJRKn+fbJTrIOCj/A1FqFKOD9CSAZZXLRuyJI5fn2?=
 =?us-ascii?Q?tNoWRJ+PY02+RxZ0WhyK5Oz7IY0V0jKstz+dfl7LXgAMEKzacOLP+EoqJabn?=
 =?us-ascii?Q?4a01EJHBYmjrw+REg4c1dA3WTpVelpeBSdVEfYYEKuSCL7Nv1Oh7cedTTbH6?=
 =?us-ascii?Q?vBBJNffMd/fWJSYgELCHVQXUISXCaSmsipzu1iQj0BcYqupQTib2Xy2ss6Om?=
 =?us-ascii?Q?DA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7917B909D62D39459087F8AAB6AB4A89@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JIfNTs++cQgMWIv+exmpWF9MtOKhNzYQnBygqZybByH147mYjy5RfQjaN+fh6iqz1o8QiG0FAMGIGo4mmok298EAs3Q13R4zTwUX4jEF4RijsytGFKXV6zRQmAFJWSL9qLmS6qn8GjTc+qhkPRvw0BYtu6JtqPY5WS3FBAluu0EtjiLtWmsy9I01zoNJekH4Q3UIBmlxWOFSnv4H73RT2eiMIDGVPJbBWVPs0D0pip2MLGQEl6ptISuf01vokqrQeyenZiJrSg6840OLudUyX1OmR3HxfWF3qimK2IMq48UyroMLGtkgrnwoLiXWp/vQuxiiwo3x6oZ3j6Y7pAuuEkgZjeIjkK83SBay5JgCP02izRRhvqJA3N8k0XwSMIEVeUl5bO75STlw4bFHKeKDUn3uYSIgP7uOys5+x3pMhL14dLLFAJ5IFzxzKixdpb7GJNNWPTSS+ygkWg4iYPC30A9LE6zCMB+y9vpa40g9DuCOIxO+h/i/M6O38kLcXdYlL+Q/EWeDDoC/CUFszRUrq6y+m2hM2orxY6OC5JMaV9xf8yOnu6tbyUrWT++GolrbT+E51LW/kqBs6r2cMXwZItu0Vo3jnmKGH1KADYH13o9xeAzU4GXgM73iZ3MV3PKFYUtXXHV2LEdCPQyvhfYtU8goh5LMEapWx49AjemCflv2TzWFHgStM1QoiiPs3UxnRh3f4LFubjMMJeEM9NFuhvqrfqy3RgFLNp60X+ikE0gwO/ctzZWxx/QglTdBJHhGdkN5HHFx1vERAvOShdtaMRVGkYx6VjzXbaHLn/mr5e3+yFgOIeyFrBxhPgDbWeieywyhIwj54jIG7afRwk6Edw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3749be-7950-4e76-44c2-08db1b2cd2d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 14:45:53.2537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IdFVOG/d1H7yLfHomc4PZs7YEvZD5Lmv4gzO69sUqM+hevmPw5FIW0CszXq6V0kdUa2ACWieNkbiwlvBc5FhOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3919
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 01, 2023 at 04:14:42PM -0500, Josef Bacik wrote:
> This flag only gets set when we're doing active zone tracking, and I'm
> going to need to use this flag for things related to this behavior.
> Rename the flag to represent what it actually means for the file system
> so it can be used in other ways and still make sense.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good,
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=
