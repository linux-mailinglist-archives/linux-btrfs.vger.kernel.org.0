Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3862D0B5D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 08:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgLGHyd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 02:54:33 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:23965 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgLGHyb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 02:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607327670; x=1638863670;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
  b=GiO+U1ZKV8NHERr+e7Wmc9KjxHbEv49bn2oKWQAtvjxqYiIjXVUJ8ngq
   V0jqm0i3g6JL3Eq5C4qRHzT2RrPc0HHeb5wPoStMgiwn5fZHP52aqyaC1
   saeJtHGH6yBRaAx9uaOH48PzyLQR74awuWEACW5H/n1A6Ip1r6SaMFDBR
   k5Tg50mqTe6g/KAS3OHWSO22WNmZPqYoyTjahC90XDCfHQan5DzZlz75R
   5B5QvybfXkjLXgC+h0H+wLIMSjIRx8WI+QkH9fEnwko9iZWw+9wBREHRJ
   p7ztgBosxV81lhPKS8Ee6KNYkh7WCYGKvX6JYtmWckASNf7DBhetZeBAz
   w==;
IronPort-SDR: wbbOoq0PQk57PXUKVJiWa5219T1tlhdmOusefz5rMu3l95iHzqUQ0Djw+5SHCDJYPweW3U3Z6D
 ZQxTyWLmMEE9bnVtwAI3OvkMExZaWKOJVqV946Yl5kNReKbobRn4wNCm15dd/+dezQfH13zQLR
 aCvumi3fTcOW3HGpAuinZh3dcU8VfGWqH2cm5H5VbmKpGIWGH0RSspDglFHFseNujeBgU6DNd/
 zxin6iHhvbHsVc1rWGB4GeHN6BlR4N6H8qaAVhUQl1nAP7vjR3TEPSJy6ZdeNBBRuLJnoAZLhr
 gLU=
X-IronPort-AV: E=Sophos;i="5.78,399,1599494400"; 
   d="scan'208";a="264733433"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2020 15:53:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5Q3p02VdOT9ifFVDrsoYy+vjsmqq0nrzps0GBxA05L1knh+U5mFpdnfEgDLrEZowjuIpB3lXgcMuaaoKCLCBM5sJNZywKYEC86jKA8013SVpG8dS/zFrWC5dttxj2UIc99Puk7Nz2KR7rve9yJcP06U+Wsdjgb0aGdx+eSB++WTgvOHQWjfhvVoQ4MAzk8qF7AN+fPxHJohOubvGQxwhkQKlYIubWUr43zSPEDUMZeft/jJkfOHAdVPMOWTC2Jt2fV04e0qm73ErVEX0XUbDQSfNy8MfiKAvkam2tDft70PlEldbTbrvVsxFiyWpcuDqNqu/dGq7uIhKoNM1Xm8ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=HarTtuI2yggMDvhzdu3SawbaeeHCVGPpoJKmrGlvA5YEVCcQsQSyn2s7b/d/m2vRAYLGFnli+HMDlnNdhVAQdazy0DaA4by/tsNmVm/kjgx+2duxfMoLXkdKwaPJSfAfFZuA/8yUaJoexus00KhLigDeqgQyXHwievfmvAKtBhY3hDv4CxV3xwrjOWBYliwbAmy2ubcE/Nox3ciz/MFZndWNCoosEgrGnKYOVI/hhVEO1FG08cvS3/s/qwFqcwC+sGdgGASXSrtFE/2/sa2WDQqAhJWoomSPI9k08tU0h1ShR2QbCR8NAhlLLn0hQVVOAJKiwEByWdR518SmyMBAQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=TmhOLB/FSyDLS6Hq0jfNfAXeNP6BAJxJzsqj5afYjJKH55f1HuapUvBVmtT8dF5YIQ/ZZr1KejXYsroJ+zFZYxGVKLyGzFGayE8ghNR1MAis+EuTq0UL+AgiT3HwoqqSnc8v/kOqsL2H8NgXjaUO5mLvrNmTRhmNNERu8YJfJ94=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5405.namprd04.prod.outlook.com
 (2603:10b6:805:103::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 07:53:23 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%6]) with mapi id 15.20.3589.038; Mon, 7 Dec 2020
 07:53:17 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v4 08/53] btrfs: pass down the tree block level through
 ref-verify
Thread-Topic: [PATCH v4 08/53] btrfs: pass down the tree block level through
 ref-verify
Thread-Index: AQHWyaIc76KkXoMn7kqsWf0y4Bk9Ng==
Date:   Mon, 7 Dec 2020 07:53:17 +0000
Message-ID: <SN4PR0401MB3598E38E4D860F19FD39E08F9BCE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
 <b35ee6a7fda2a597baf0073b9e82d8371eaf54ef.1607019557.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 670e6d6a-eafb-45a3-91d6-08d89a852896
x-ms-traffictypediagnostic: SN6PR04MB5405:
x-microsoft-antispam-prvs: <SN6PR04MB540591317E0768495B2E70E79BCE0@SN6PR04MB5405.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zgNZhdVFIVh+4Yk8mM1B0rydQmrYpnj9Y8cIP3JkDmDB2gBA6gDUaA04/WzNli2CdRKKuE75zNFEgwiv8lfmOzCAW76yWVzB9J+BUoD2J+A8fvdw+bZvQxk5avPfapHXcjw4tFkTJU1ANDwPRjqNulUvNWBc+VYRl402JVUAjeLY2/0ZuyWrj52/69YJbePI3EPHSOIaZhS1D0ZrGo8+MHbwVLBdCvezE+axr6JUR7bu84VD6nPR3GXSa5UicEI35FBrpzpkbX5LDkdG0QRt8dAb5azRDjlxhCiU0eUx1uqkaKTAEbAHeafgEn7IrFpS6khlAGFLNaPfngBWjt3T6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(558084003)(8676002)(66946007)(52536014)(66476007)(186003)(478600001)(26005)(6506007)(7696005)(66446008)(66556008)(8936002)(71200400001)(91956017)(76116006)(64756008)(9686003)(110136005)(55016002)(33656002)(5660300002)(86362001)(19618925003)(316002)(4270600006)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Xo+eMSnjGQPGcUvkezzPEDxSwrwvQ11pmAGFe4EPY4LafjmtTOu4d9nl8XMs?=
 =?us-ascii?Q?rREuKr4NwFXfXmmNoPAyjVlXI8pjVNiV9RQ2uirUztKmPp7ZoMu6TFjpU9Ev?=
 =?us-ascii?Q?i078SJf4EIkQI2prGn44DG63RtzbjbhVjRJ18AgfxeO4qir5WTlOCIANGlne?=
 =?us-ascii?Q?pMxpKXHpG0WOg7pmHhlzwFg8yOY48SmgTUiH9e3j4a+AOJ16cf+2JC8i+RND?=
 =?us-ascii?Q?voYav/dC035ms+paoCthVde6+e5MaNOlUDu9tldrUK07W+JoXAK8EwGu9Nug?=
 =?us-ascii?Q?QnI9LSMQl5F8Iq0Z48uCKUtrGWxWqgO+wsuDCk4MBY21tdrlJ5q7/gxkAf5P?=
 =?us-ascii?Q?qekbSIY+RndFXs1UFTVM0x/xbQQ94AmbLkmLQhg6gDcT4yx0dMRvqpQfvYyv?=
 =?us-ascii?Q?AJHHNXAAQglTjX9lK4v+synh3O/EKdGIpNT0sQxOtTz/C3sG51K02v1e4kI5?=
 =?us-ascii?Q?0hYBfCUpKCZO5rUzvETncJSagRuPbwli1NGDrVRmiTm4FKcmzi5Aep94kvDm?=
 =?us-ascii?Q?PdkfJxkHbdoW1/x33grc55hF7zFscqAt/1fq1wKP3z8TE7mZlSbinhjlCSb6?=
 =?us-ascii?Q?Hbq5xadcIvUre9AmrcXyGIgjmYxLnuyFGdvjQKTALxyRibAUlmX1Enqlj2iQ?=
 =?us-ascii?Q?5BoRdGZVS+KSkj9TMOPp8C2RDIjiNjaBhPbVG9ukNJo+JBPoK3TpcxOlGjMw?=
 =?us-ascii?Q?iJQ075r4M9k4BMeAr5S5ADQO02YwTbfh6mHjrL88r8fauhIMVsbG53ZCbue5?=
 =?us-ascii?Q?mbX6hhZTRAx7mHIicWFRjCk358FY0H1Zt/M18OBT5/joQBQC4rDswkyPsSfq?=
 =?us-ascii?Q?3uVngj/6bAsLQjo4edHS6DMgYN45qv6vVkGx4W/3xS6JepeJwWlMP+SU9YE3?=
 =?us-ascii?Q?mE+V9caH1P7P16wOckm/AY4gEvaql1OXZstxE/zWeRg2uHvMHc1Zw+VDjvCH?=
 =?us-ascii?Q?ff6Oa9UGNU2OETXeG+Ajl50F160IKs52tFlva0TFV/8wj9/Qx7BwngTxv6aG?=
 =?us-ascii?Q?c/Vw?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 670e6d6a-eafb-45a3-91d6-08d89a852896
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 07:53:17.4100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leQwEPCoG0e+emFQhqUlAl0TeHH6XCuiUJqBZciHuQbT6BB9Qs2YVd74bv/BEGWAjJ0aCdPXuaRws4cD7563MZ9f/8HpcNMq98rmlmkrww8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5405
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
