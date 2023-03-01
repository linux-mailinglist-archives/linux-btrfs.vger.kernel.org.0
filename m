Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48916A6AE1
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 11:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCAKgb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 05:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCAKg3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 05:36:29 -0500
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01on2063.outbound.protection.outlook.com [40.107.107.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E611222794
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 02:36:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBGlnSK0P2JrcM0XBr7MozG6fhEVzL31ngYxGr1UvPZQF44/QlNVsYHmjzfjqmLanKJ9SWRwKPbozk+EIEWMgpt+ObeNhRj0m/LK79m2ozjF6M91mj/AfkOuLsY4FpeSGatBv8069UXP30PmgOp1c2Fdke82pNNb18/IOK/w+Bg53OZpGwlcZ4infLlwJekNuWv0GM4XA4ImnJYOwS2yYiA+EDa6X/sRuq+2GfjwLYfuVlGzk74N4AHTwJbz9uI8Fn0yJH915TQ3NWvvxavpFAUdg5Xg15Brmi2BvcrGgVMuaM0sAJHmNS8SwOcDC255cW3UFwF93Ve+jwZ8vMkh3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXTeVpwDZTBJhgABwYpJpV2vNwpfcsd5GXfg2hKpetE=;
 b=TodcQ/RJIFUpxlJKv+0dFY5paz8Wzgn9UKIEjhSmXob3FiYXsDi5PulSY6C9TDQN3poCzDs8jGD/vUnX2F5Pqr5PkSkLxhg7pA75hf5nlLS9e5Ps/kQExc3aVh0Vg1CDJ5OrD/CRD3mAj68Ev+Akmbv3KMoKQt+TZm5Vm8FZrEeKfcmagk7qO52L4iNYx4IoXD7EtjFed5tWXz0KEWEtSyslNoRu1I4OPtH2zOtXpUB9mUce3oL0/dExvz2WWFSahfNhQcsWLescSeURLUmoAfY5K0+1YOPxyjD/PFlIUdmFjJhoLCQdyojHfxqIF8HCxJvOcR4+K3OiKEsx5WXjbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXTeVpwDZTBJhgABwYpJpV2vNwpfcsd5GXfg2hKpetE=;
 b=DxEw7vACGaovKibVXHWxGfjX7WqIDD/bPe3O9q9AetBTWFRHK2MuOjq5mqlG8aDFDc4JrB116hkOdlf/i1+2L6thmmxpauopPUHnjUapWzrf4FLz6dXvH9YE8f6dORhyIGCHaDZUjTM9/m5lTsrQ7UFXt/aNyZDJ2RRMyZuLu5o=
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com (2603:10c6:10:4a::22)
 by SY4PR01MB5801.ausprd01.prod.outlook.com (2603:10c6:10:fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 10:36:24 +0000
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::a227:e4e8:b45c:cb8c]) by SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::a227:e4e8:b45c:cb8c%3]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 10:36:24 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: [RFC PATCH] btrfs: relocation: add a quick in-replace conversion
 optimization
Thread-Topic: [RFC PATCH] btrfs: relocation: add a quick in-replace conversion
 optimization
Thread-Index: AQHZTBkc/bu9qFumDUmuKiYoVacWi67lumWg
Date:   Wed, 1 Mar 2023 10:36:24 +0000
Message-ID: <SYCPR01MB4685A69A98C3D3CFEA23038E9EAD9@SYCPR01MB4685.ausprd01.prod.outlook.com>
References: <4cb0ec4c8bc6b6aa1777c7d4f7ad1f0de975f6a9.1677659834.git.wqu@suse.com>
In-Reply-To: <4cb0ec4c8bc6b6aa1777c7d4f7ad1f0de975f6a9.1677659834.git.wqu@suse.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pauljones.id.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYCPR01MB4685:EE_|SY4PR01MB5801:EE_
x-ms-office365-filtering-correlation-id: 0234a1fb-7817-4aac-4dad-08db1a40ce67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lol0rT36uj4/f3p3MjS6/LmaKMc9QkKveFSSXY6TJ1QHzdWmauv1rUx6h2PKHg39Iy0fRXp4xSnHB8KJqpcOB7KyB2FIiWUgjaUymYp592+37n1/SlYPScM4/fzp/nK2+pngkfHH2JwwUQ/Gp+q4EN/5ewDiHxPnAMT3H4WwG90V+FrsGvEw0zdZ5vriA2dzrxANqAkQZK6bwGCk/8JzTywIkPiIcrVBnu2jZ7Lg+X9LRvUClpWkC2GYfOXWhGkoI/jhiZR54A0BFDLRM5sO1v7LIiNSo0zZhNNoJnZidJiAPpa11RuBadd3+V3XgDC5jG1TbDgpQAxVRCvzgN+7ByRIQDhXWgoqpNsZ65lE05fzV6otf88VZW+pQ3wDSg5KCfExPHbUMLa6LDsDRLPPvYV+u4THEXr5FHbGltNoYJVgexGocBVrQ5ANuqopR+vieFh0vvlX80AX6YGebXpAtu4RZjPsCteICFwN93c6f5TsyJn6A/B3Wc9KZX+A+9F9MX+w92mEyvgyMOswz/Jg8CNqF0bp03paPC9Hcic9/HmR6sv6l+6W/Hw8M3LeHkFwufeLe5rYwHR9/peomquAVJKpKftLuc2dyegNtJ44IfSl+Th0+RWPErzkwY/ryXfpyA/411OtAjSbKnReYDJopnJW9sfCnjIhh0u4DZOevBiA4nJXywpcBjlIHkBWBc/hiKIFc9+TmXZ4LEi5jSAynw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYCPR01MB4685.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(396003)(366004)(39830400003)(346002)(451199018)(86362001)(33656002)(66476007)(66446008)(66946007)(66556008)(64756008)(55016003)(41300700001)(5660300002)(8676002)(8936002)(2906002)(38100700002)(122000001)(38070700005)(7696005)(52536014)(478600001)(316002)(71200400001)(76116006)(83380400001)(110136005)(186003)(26005)(53546011)(9686003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?otpcUXCob2K8f7nQFLA2Md220Pr+D8KpdkueuHbuyU8rmThTqp5JEjFwOAYM?=
 =?us-ascii?Q?S6tWlklhy4yB5r42FNDfR/Xq5pSH+xmCb1fXt5v7CQ2BvEGLs1HZK8sjb5Kp?=
 =?us-ascii?Q?XPLY//CHWIhciZ2St7/MyCQCxn42et2EYoWfGJxfz0h3l8nMJ8IJcQT7Ytom?=
 =?us-ascii?Q?US6O4hSdADur9kStoQwOvhzSEEb93HRaLLweRjH6fFq2N5mcwowKc8I+uZ9r?=
 =?us-ascii?Q?msj3bouCwqEWn7as/Vi6ujMsgQrJgByBjAyLLcd7uQ4+0td/d+JK6vn7PQW6?=
 =?us-ascii?Q?HGftXBv4zAqgrNcq/zjpWarR64M2zKUoM7HG3r8VkawD5OsOkk0px2mgdRiQ?=
 =?us-ascii?Q?d7rrr4SZeuUGSiSTzE39FSnUDyG4UrLbRBigd3eyh8smkj7XFSl+giZ/ilC9?=
 =?us-ascii?Q?GUrKDP/cCz0hvQWIx+6/JK2zPB/jl0dMpWgjV/1EkchAlPtBruZgBgtgM15W?=
 =?us-ascii?Q?Jp/d5Vw/vtfC8v9w2HURuf5UyrlX7DtFhGvtkxeGH0+Oy7+Ntax3nmRtyvOs?=
 =?us-ascii?Q?apwLhl96AQxDBHrXHMsuHHpQLlZzB7wQ2NvV23XeuHzWaScmOzF6WCm7Iljt?=
 =?us-ascii?Q?pBFY7azd9PFigpxZipSlITU7jUm0XDshkK0HlxlSdpsrVAPAycNB8XTvF14r?=
 =?us-ascii?Q?eJ8XajXhv/bhW+QMr8GbVWLL1aA5OtmuiffSpivG91SfE/KdFzbcDr5vCOYc?=
 =?us-ascii?Q?N9DSM35jKCtTIN+NQt4lOrmGdKEeL3lyMD9nJUbcBheA1p/wm7uYa3eaNN3M?=
 =?us-ascii?Q?Pi1hJdNiwJS3U6Eq+NkJkfeBQthk3rFRlJHWxgukkUnhwFFa4I2ZyV/w68uE?=
 =?us-ascii?Q?TQAF0t/sEco62vxt69BdqUNQhX8NHKMORWmxlBbLADEKkZEKIPfyB+EAUkH5?=
 =?us-ascii?Q?N5Fb9rwxGMNwm8W8v181PBTA2Q9ddjYeJO4jyGJ9bh+tDDVRLGXAgj89cFUg?=
 =?us-ascii?Q?mFVMyqCCh3rgzlAS+vxHLpo9D25KG6SWHrk8GwLKSakHdckgSU6pYbqplEYD?=
 =?us-ascii?Q?cv/f7xsWl3RWeDcKvlXO/8Zbuda3TlS/eLzG24fF/fAfs+hMtC6k8NJgfwt2?=
 =?us-ascii?Q?5fwDWPj2VreEBo758JUDN2scS3VfaEO0AIu+hAIur5OhPkhZlSAgKW0Fi87e?=
 =?us-ascii?Q?q2SREnJKYgUfa3fsbWNKSZT6UIe0Kbuq6t9jZg7KdqVe4VQLXnwJ6mHYGW5q?=
 =?us-ascii?Q?wK5w/YLMqZSnjPk830rLBQcpNxB8wInuNjIRpjybWqPf+rbiekrS7ST1LTrr?=
 =?us-ascii?Q?P0wM/e+Y/FNXmM/eSPiFblnb0mwlQiWlbMxSVAWWXDybaQrF4GBaBo3zUNtp?=
 =?us-ascii?Q?HwMyffKcSaD7mPl2O/38HqncHAxRm8awUM5pcbNMCNQYOS+nFpxbcn7z3Wsj?=
 =?us-ascii?Q?BN25Tv+RaOrXIrktoPQ9ViktLWCTnkJ5EDOMTElV2/vZLUQAMm4LZnaJEgKR?=
 =?us-ascii?Q?hMqus1F7gUUtL+ep0EdXx7aKlVmlpOJV5bwYcqAPUahuN8W3JQjhh7sMGpPy?=
 =?us-ascii?Q?Nu1j5I7NM+k8Ov8PH7EKUvLKts3iB08U3ioJCNIOjBxbgTxLn+4SjADDJ22S?=
 =?us-ascii?Q?qw+DTdnAW5MpiLH9qOL/PzRU6a5AFYEH7KGvJ7sy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYCPR01MB4685.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0234a1fb-7817-4aac-4dad-08db1a40ce67
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 10:36:24.5537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3E9eaVlgue115RjrAG9h+Sn475ikbjW+HxTz4dGYoIuOsD3ahM3sO65iZTvs1+7x/r9OC/9jV3OSCIvHrjgbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4PR01MB5801
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> -----Original Message-----
> From: Qu Wenruo <wqu@suse.com>
> Sent: Wednesday, 1 March 2023 7:37 PM
> To: linux-btrfs@vger.kernel.org
> Subject: [RFC PATCH] btrfs: relocation: add a quick in-replace conversion
> optimization
>=20
> [BACKGROUND]
> There is a recent discuss on why btrfs balanace can not convert
> RAID1C*/DUP to SINGLE fast.
>=20
> After all, RAID1C* and DUP are just SINGLE duplicated to one or more
> devices.
>=20
> [ENHANCEMENT]
> The basic idea is, we don't need to do the IO intensive relocation, but j=
ust
> drop the extra device extents, change the profile to SINGLE, then call it=
 a day.
>=20
> [IMPLEMENTATION]
> This patch would implement such quick path for conversion.
>=20
> It has the following requirement:
>=20
> - Source block group profile is RAID1C* or DUP
>   Other profiles are either stripe based (RAID0/RAID10/RAID5/RAID6) or
>   it's already SINGLE.
>=20
> - Conversion target is SINGLE
>   In theory, RAID1C4 -> RAID1/RAID1C3/SINGLE is also possible, but
>   for now let's only allow SINGLE target.

What about the other way? Ie. SINGLE -> RAID1C* Does that create two new co=
pies or just the extra one on a different device?

Paul.
