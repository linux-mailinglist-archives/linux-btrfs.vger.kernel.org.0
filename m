Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DBD28CADE
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Oct 2020 11:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390721AbgJMJSP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Oct 2020 05:18:15 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:8703 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389649AbgJMJSP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Oct 2020 05:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602580694; x=1634116694;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xcF+bWKL6GNDnoAURaIc10eKVQfUV5uvMRGwLPXC9gU=;
  b=YkeaasIXN2DHedNxT1rr4uUT20SE6BXUWuRGILPX4EEHDNO+uQg1W55X
   C9ULJ3+jyHeNujgdOIjvQkS4I5rm0B3giYO3XMr5bwqEdt0IEQhna+buD
   TRD9ekHJDGpiEU0h2mm24tjt+PJ5nL8U+f56YiN6NX9uu2hMFM/ozSNzI
   ODvxuJQvZ+/apWKt1d+94jDY2z5YL4g4op7xNadaI4P3RijEiGaL9F4Jf
   C9BuAeeNnxGUL98Fd0UA9cqnS4X6RR8WxPOAO52q3IJJ5dwUm3RoSjO46
   ++1r9MSuN5BUZGx35Bkjb71s6YYD0sBTa2CW/LIGoCTm8N2mc8vFier1N
   A==;
IronPort-SDR: zIOGz9hfi8oesnOvdqkI7UPVy2Nk3TLbCVNZkfB1J4DgH5B6oaniPE97EW2KP+p0vi9f3G9zgC
 GI022KRAcjKlbGXk+sxcE88SZgRFPvdHK6Tn/eflgO5m8eWVqBqePGV3mhsJQN6zbo8w99HA0w
 rb/yFhof9mN8xSpFRnXhKShsL7l6cemZTP94/sg/BXwlnXFN5xhTElSJbGUK1yeiVdvn72Em6Q
 e/bmaiPc9L17CF6tOVPw+aq1MbLHQSDm+4qTTJ7GomLfxbipcCKRR8osTAALTvtlLF12paeOg2
 V/Y=
X-IronPort-AV: E=Sophos;i="5.77,369,1596470400"; 
   d="scan'208";a="149626640"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2020 16:59:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPYxXNWqPrC+9J4iLS+ho9Av2luZYi9xZWD3qkO0Tb+4T4rpu6rSyoiNQEIjM/3VM+/D4P1bRp/KqRgRrflAaKgty0oXpRPeZcmz4JxoOdNNMh4eUPdY3Yjh3y8piCu3OkERy4TdK85VHs239QXvO3ok3ZJMMEbYFzX4P4rcV6obtbx62GaFGU+y2TJAPK/47LfoHLOIGp2A+o6x5oFUHonNrZuMZw8wkBqWTe+EafgZReYHSqRyx93rKSX8KXeq0zG83c8/zM8iuasTVAV0gNqK2SY3+B3zoDWdyh1T+tVq+X4p1p5ju4y4MNm38I+IYnJiakFebyCwod3n/jV6dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcF+bWKL6GNDnoAURaIc10eKVQfUV5uvMRGwLPXC9gU=;
 b=gmNy5UYthr2V5jGDbsX5+7xOf7XG3ussYaKUsXqeV6eeC+6k38rHlDzBSH3YqdwEmS9RAsyJDAr+J/iifflP+Z1hBFGANoxpt68c6T/+5OOzOHUf97KR7ZWXbVHSF5FFKNxofQE2Z5qZD7sLg/OOJIe8KJCW50z1bxobGl2Qtep4sng+tsdvV1R8IX75mAEWJbFnQAsLGxfxUxuHIJe0qzf4Paan6duhSrIbL3ZfdoCVMSB+MpBF4ZCXQYpdV/ZKcfN4PEfIetz9Bxt/q/C7hQDg6KqTVENbeSbtnZYB81Ux4jkfd8IjniWG3O2G1bF89MgF8fBQNc1ujmjPxPiGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcF+bWKL6GNDnoAURaIc10eKVQfUV5uvMRGwLPXC9gU=;
 b=M9VhGoedcAZlb5s9mF9DI448M+VNdfuoiRXneW2HHpXsSjS3SqOLrEyfkzlcE1o1nUg2+EW8av9g6xC7QA8cZT12ve6KdeK5U/H+sEFC1Ezlnrn0eui7x7fxzKNiODfiZe9croNPuRA6j39LNBklk0W2c8pexf3BDiQ32n6xjUM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2319.namprd04.prod.outlook.com
 (2603:10b6:804:12::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Tue, 13 Oct
 2020 08:59:31 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3455.031; Tue, 13 Oct 2020
 08:59:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/4] btrfs: fix use-after-free on readahead extent after
 failure to create it
Thread-Topic: [PATCH 1/4] btrfs: fix use-after-free on readahead extent after
 failure to create it
Thread-Index: AQHWoIY4LUoA7feslUaQL8m9RgO5Cw==
Date:   Tue, 13 Oct 2020 08:59:31 +0000
Message-ID: <SN4PR0401MB3598AB57C10AE34F084521849B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1602499587.git.fdmanana@suse.com>
 <2db542cfa0e255a78eb25a11eb719caa5760087d.1602499588.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1800f256-d8f2-4e46-af13-08d86f564c8f
x-ms-traffictypediagnostic: SN2PR04MB2319:
x-microsoft-antispam-prvs: <SN2PR04MB2319B40126694C7F731D48409B040@SN2PR04MB2319.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HQBNYqp+riz64R+aR4NhDuTbCdUn+pT3sB9oV1aIVUEyBQqPpyec05WI+ImwkRgtd7DQf1T/hGCxsO3+gr4P77UB5HFYO+YJgOqsHKg/JwinhT+TKPFLaNFYBKsNICxiVW4W/fyrDxK5W11vjAdq2VXjm9NlaHyM1R9eRAWIaPTyE4EKA43ycNCpE3KsELxdk9rRtJIgXdp1n84r325FobJwD0a/cUaTCcsBCydygcV3/HuVHgLz5T+696XT8V+0OrZS1+MhSd4KSQpEh901suqgMdEBYsNeGNSVYWBo88jO3L6nZTWkKxX1bJa4pWKbrbZyXPV36Ma+iEbkUDzSZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(8936002)(71200400001)(8676002)(55016002)(478600001)(4270600006)(86362001)(9686003)(186003)(26005)(6506007)(7696005)(316002)(2906002)(110136005)(558084003)(33656002)(64756008)(5660300002)(52536014)(66476007)(66556008)(66946007)(66446008)(76116006)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: PAwoSoK1CvHPYzZGRAkJTUZmrEsglU45J+DJ3TL+j4NwoN7fdjx3lK457VkTfWM706d0d9+IIRqwAHpNdjJvig7k4rNz/e7n4AF9D346fcAX53ARoI2kHvxJPmtvtYKwkvKX8LEMITEDASTovJoj4FSEL0SiiTY1tMO8pSZQLnrB7CFAoXr9pt8kK+LopSZDSP88cKRgU7GcXQpwc07BF/Tl6KyhARXJc2NDFChoaByoWkjugR8X+MXCJ6+VLTuhxtLVq6j2bVTAYLcVnpSC1oG1Rk9gp4033fclfW6GCHhEYM5JgxsVupw9/yBbq3X36eObhG/JA2TQ8DjI7FJYQiMljmY/e+LFz74g0TGSaKMk3lVYJeQSMTS1H5G3HZ4ElNAgg/SYgpzVVs080rzhTzucvP8Rz4saRQLTo/zCH1KJkCSd4rqO2tsnEo2ERmnI6IYWwnz6dhFMmgxgpoAlbJPbR2K7RJMDLcj9iF2USunIsOmnpQ1JJJqnZeVV3gdHkDYt8zOYUJjHiYoJmigw85enhBJzQ4bSIOx1byUuLCCiqCyBK+hVd4V/mOSGOiWPPX572czuiEJVVFO0mLAiv0BgBa6qTnSjxbZhcs2eAlVJlvEWuuE+q6GZmJWoK2NuN1759XNlbaY6lwbJfjFz8g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1800f256-d8f2-4e46-af13-08d86f564c8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 08:59:31.3951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DTy6HpoV7kYV5nfJLgVzfkwmNySSIpyOCw051V+2TueDpvUrD++57Qlw9Kbg5y91zYCRWm21f+BIOj+P7rEGkkFPqzmNOrR+zkkXT+wmoEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2319
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hope I didn't miss anything,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
