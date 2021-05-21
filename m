Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D27D38C0F2
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 09:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbhEUHsV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 03:48:21 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:18100 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhEUHsU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 03:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621583218; x=1653119218;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=lPaD/WcNtOU6gym1yr1plb0a7044c+HgNEr+VUmRFsn8SVE+8ySoLwCh
   Jq+iGp7vHZzVKgKZ8e890uuHyR1BdfOkJrGLjJ4DgJ5asvJ+EGlX6XbRl
   qdOmw/6c6wzUGzfCZhQcxV5G9ax98xWXrEvauvckE+wel/G5lBoa1Bs5h
   8seXJtdemqoZ/yYeCz6aGwEG5KJqluHB9G/ldoKk5/0UQrpzjtx/jiKn8
   RUpLE+la2rFuLK6NAQvIvbc3JKUjvWMh2IumVtzYcvqSVF1L+64Jgfwob
   PaU+vpIm0z5f6UBeFgltjcnkpArpYiRZBmPqCcPyUzAptWuhrhrvx1yRC
   w==;
IronPort-SDR: C76XRrulTVBmmfpy65WXE6igp/LGy5hKE92g+q6Ws6jUAwgeX35/zOaIO96p/gEfnSCn7C59mY
 OC8CBnOfX53g31iR1NSrAUzONcUJelDakyt7y3m6p0Jfvz4DTaWwnXjxLT+qX0zfSawqe1SOdC
 2YiRcAaBJrWc/C6R+M4qj29+e5A9h8n4nK7mmuJ+XtXtt4ujURXYYkzu3nJ36vtddKTPH7k7xS
 e/1FTsO8P2Pg9iVRUzORPkU8/XVkG/97DZ5Tm+BDeYGCJol8XegLMv5+cLsWrymiIrPujX4zoN
 G48=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="168273761"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 15:46:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MChF6DNYJ6+MhJqoJFHhldYl88cRh7NQZTxb0HOUw1Xcocn3etQNnO5+MpdjGJndwubRkUkUbTnz/I1b3NEeDzPLJbZezVtWQyFXUmZBH0lmKbhAmZ9bQuaweAvWLaMM57ulyqRNptWmuJHLOikyrJ3JZB7dv8WETw1GIpJiU1DUlm49h2s6TOOzbvwq8KKFiVGGrZVmxXcgTxOsD6fB6RHQBNhlaMJRyrN/x8T56XZYkcjvDSX6on0M3/X7tn2Nvo4l8rLeWatLcT7qJ/eMfAnPclZuDDKijufd45udZBdGQG5D7NQ8rsQVAzWVK2tVxHVXCV7x7icdP97WfQn1Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=GvofNVByhNGdve3cn9PhqKOWSkeoQv4RbxlEXMVsiYJNo5sFTFiM0mC0Ym9JbsLli48qr31jrMQ12EKZdaEFVvQ8uPGAkWOOdQgwVH1RU2sPhiQvvsQ0ypB+88c9JVLYY8hcEqAwJ9sDAxUh32TAWrPlXOOiuYxhT/E62UiU5RXgXtOVaP1FeLFJmsPSlMIPLULz738EAHUfrYS8AJxHihQGvwy86D1lvY5679/bRdpIQnMrbyIYNB+LLPqa+FxRyYUZHTFvDb8a3ZqqoZUpb9I2DJgfS1tRQEXU+Igu4NtP8nhLSVVKAZR5YEq8YRJ9FmkjImRVyYjfo2yUyRZscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=nWCQcJScyoHhp8cuGin4KROfYkikWsRmPLilANMPAKBGb6xlGapW6DEZeTABV1DhZcOD380PMdDYwntqLSPuPn7G4LS9LkPkazucOrg2xQvPXIUuVLRWsUCgmNkeoJEDfG4UQMwCN+nNhnCBmXhIGDUsuEikDyn48dHbyLwkYR0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7558.namprd04.prod.outlook.com (2603:10b6:510:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 21 May
 2021 07:46:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.033; Fri, 21 May 2021
 07:46:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: fixup error handling in fixup_inode_link_counts
Thread-Topic: [PATCH] btrfs: fixup error handling in fixup_inode_link_counts
Thread-Index: AQHXTNJIMtTgfNYHLEqP8HPYGTLGHA==
Date:   Fri, 21 May 2021 07:46:55 +0000
Message-ID: <PH0PR04MB7416360828F3D582A1C6D50E9B299@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <3490883fc4ea908bcefbf2507ba4c7235c2464e4.1621444381.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:f8bd:921e:9aa5:6d21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6654a5ce-e08f-4b8d-8225-08d91c2c9b1f
x-ms-traffictypediagnostic: PH0PR04MB7558:
x-microsoft-antispam-prvs: <PH0PR04MB7558166168664EC73014AE069B299@PH0PR04MB7558.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VeMuok9lTKCIfinNQz+9gor9T2Tsl6EadlzOIZ2DfwDFwO29R3AMTRBp2xgBUXtXdeZfUC3s6EQXhRn+3UG75GCG8WtRqaKET4YzbHSuYphgvgRCgDKjK74fuDMs+td0LtvypzZ5wUof4qkJa1C9bkvGTr5sHJApGxIpSYtEeYx175IlRMwUbd1iVEm0UU0TAUOodnB6TqMA66AoIJDmNjvpc8ArngeOozcAwWodin4BZMm6hXB/Smc4kw8/pUJOkfoY8ft7oabuQT9JxK+48SAw/nV2QlYAckWtKMK4L0uAvzDEjTdiZTlFOTjvTxvo3/l7pzNeFD0Zk7ZfeB1VFrKZcqLrG+ulkTWZjTFQunYb7r3v+/qQGJotF+78bPSb33rIdyZyWj96SWjNxy0C44hf1YitWvXvSwH/wEbYRxpQELiz43kHRBHLqaOVbQLHljR09XLGVzM/71j4DlxTp3jg5CjF1K4wOvFQlZfEsVPiU5bv0eYWMBkgjQErDSLwI8ZZMJ3/C7TaOBFY1yiFAQR4M1cLLoZZgjwjQbtMMjx886yMkJZ7Kw2lT+/Bz1iqJcdU+PJYBYP9shPX5L+Qt208xjpN8JswuriTzZtgsCU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(33656002)(478600001)(316002)(110136005)(86362001)(7696005)(6506007)(8936002)(91956017)(8676002)(66946007)(66446008)(2906002)(66556008)(66476007)(64756008)(76116006)(122000001)(186003)(52536014)(55016002)(4270600006)(5660300002)(9686003)(558084003)(71200400001)(38100700002)(19618925003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?59tiYLeGOnYD7bR3KRnaL35kmHM8p+uyIAQA0WdZYAiNelK9e28S7lgJCXDc?=
 =?us-ascii?Q?7EwqhpoD6l647HOkcIv2+87Bs1tqnY6AXaA+w5NGOSrmDD/s1jXqlMfbze+K?=
 =?us-ascii?Q?kjOtrp72hJJQ+hggXa858BoMuyAcTy0RdGBNjo39sbA2JGumroIr+VboUT1f?=
 =?us-ascii?Q?5uoGf7x0GD1oc9Igj11GClzjafcTdo+qwXUdK71qpMQPB9hpsgWuH8DZklxc?=
 =?us-ascii?Q?bnLl7Z49b4G9SuLwzVZXUSOe3d6O9AUv8de7a3Do6W2kLi9+Ex18AAzZuOsC?=
 =?us-ascii?Q?ZiKhXGthYbzjAK4+ypLI7BxZw8/chPe3Zdtd/6FyUKMDdRYz8lEujTHCUnmP?=
 =?us-ascii?Q?sbWIz7A61SXIQrOvgsG7SXABKpxJMjM/1rTOSDIurJO2I05mLqX9VFEAEf+J?=
 =?us-ascii?Q?3wY44PMnOJ3fxjB0uscnUfHLEHwmYyKGTvJod89dHGsUfdtOhCtmUGJn0iFc?=
 =?us-ascii?Q?IuhGAckHt+lkSHPQ9HzfXcNQIGOgCSP6zsO0Dxl+WQ4i6HiQTKIjRp8jMF35?=
 =?us-ascii?Q?pkyBx+160JNC0ecPDFvGwaSdmwB55gTQ+gJgOQrKX2vcNl2IhXSgtP1k5N5t?=
 =?us-ascii?Q?7Ncb8QgM7pW77k1KNhmi7PP0/knoQPB1HIZ7n0CN1w+l1fv/oyS5HwQ18uG1?=
 =?us-ascii?Q?iyHW8IUxmeTyVyPMKfiqMPEVP/ZGHqt8sKnN4VH+ASGIIe/M9yCFEsVZQLMk?=
 =?us-ascii?Q?TPoPgVzjO5hCwawunAs9hRgXIuwjuz2nwGRgoUzdWdFVWT7rdb/9oSudmvzB?=
 =?us-ascii?Q?KbXiecUUphpqnTDF4MoYSFs8QLM5DYQtJMVhpXw1nbrWf3EMX4HBgOjU92JI?=
 =?us-ascii?Q?0au1O6heRks0TvmWOmc6P+keS01AgFWE5cCa+PFcrL6Y7MWEvzNTqIqV2Fns?=
 =?us-ascii?Q?/lJLF7Qeu1d4kGkoYwSI9FFluEDRKwphoDd2+3MP2UECZQHNYxCic8+kPRCy?=
 =?us-ascii?Q?/WRPqFiA5FHFyJX2pwXwNkYwntS409n5TMCYqEwTa9UY+MymMeqvKnRSk/xL?=
 =?us-ascii?Q?lSdMZ05QTmfmP2U1zzYp7umTGkDhyhTNBGRoDMfkU3vkL/SRhMG4gvbM+4Bj?=
 =?us-ascii?Q?8EdAFBHRWwIH8StNjS6eN4e7tE1ZgfEJQYAzwDpk45Wqtr3CZMYIy4wm70xk?=
 =?us-ascii?Q?X8HjSyt7H8CNfqKlrqSY6l3BZH7PfFvplHgkOY3Z2Jkz9oXcM7NiyLcxOfus?=
 =?us-ascii?Q?N9seEMeLVyZW8JpwIyVQLh7wuXMm98WehZZX4VjOxGolefej/dlyoeFhiiTK?=
 =?us-ascii?Q?EnT4j/OdPowFw67UoP51cklNJGOCT1LFmqqZfYVHv3wSd26n0uYVsRoBEnUo?=
 =?us-ascii?Q?JN3lUuGd4UeQ6Dtp+ptc4VG6q0b2srt2wc/RtFLT/tMTwXtpGC06HStt7QM8?=
 =?us-ascii?Q?Mb9LGAKC2mku86F71i48gUi73Du5pTIFpYrLooaxgQDyaKc0pQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6654a5ce-e08f-4b8d-8225-08d91c2c9b1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 07:46:55.5053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PPfan0tGzgDxDvkSKZdf4812v3ij8FttsNQxWsi+vkCKVGd2e65C9IIPfaYRewOUfERy7sFgLufmfbwIGqr7ik4iD6N9oOqZ+pnpvtDrRlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7558
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
