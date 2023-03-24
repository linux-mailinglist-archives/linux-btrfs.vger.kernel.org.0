Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABA86C76B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 05:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjCXEyH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Mar 2023 00:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjCXEyF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Mar 2023 00:54:05 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B621EB62
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 21:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679633644; x=1711169644;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/75j5F1gYZgWA/gadsI5covELBl2Gt37PJjQX8yhWOY=;
  b=pn1/p2QPbe5mHUO/syswk8CCl3HnxvKn1aFJlkhxldlGrlopiO9lVpA5
   tsS9cpL9zaYe1wy1sIWwyzZdpYfAOqCBiIj0xpLUfXBwuAGHQv3XV2/dd
   MBldJtjWLW3rd977Drf7spSyaataly88+h2OCzuIYjmNpfzG79KiGWjFU
   R5jWh0sfixP7aLyzsL48VGYUhGTzN7F/cdDrnFwTgrtMkR/6UUxFI6MEk
   JvDb1C9xWL+/umEm7oC71ZAItLYKl8M9fQ+XysWhZBqszLMo9405Ix75P
   LMDybP77VfSuVEbdhoyB0vbH4/WzLXxvjiATFSfStSH5pZPnQffyPDolh
   g==;
X-IronPort-AV: E=Sophos;i="5.98,286,1673884800"; 
   d="scan'208";a="330817759"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2023 12:54:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhdztK6Q8urZ6IEWweyVUQUsfx3Ili2XSto9HM+go3tAlkt1Y3Skj9C2xIgUANbYoIucBr5dsm+kuSzxj90jkzUxaC/Z50WdZoRJf/+Ye7XWQJshXr/y7VwYJF2QMH+Q5IVOehndaDDnF1jH2MpNRZ9P+Ak4Kz+cX0r3O0MBl3aH+og03XGuOW3tv8dp4XH27D+xYoXXnsvhwkHW7oY0Q6TVR1Y27FmNu77aahCe94e3rmUNiPsP2e7NeqSvGB7AiHNQ8In/bIErOrTEtaPN0NtOrmmUsfj+ZWEZeGXXIQ2KCWqKaNBY42u+Ix5dwm0ALytl9t7AZ8hzGYB1BPuJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/75j5F1gYZgWA/gadsI5covELBl2Gt37PJjQX8yhWOY=;
 b=jTydrWItIdgVrzBUwMZ2VpvWXlsIGOeLnDWegdIdg8IaLM8w3/Ni2URH1uADr4FHtUoTgV50jSAESBlLrI/SFbGczj0Vdo3D5HAo6M8cz6X90NTstCk/wkk7Mq6WbY0TzjqbhFBfOhIvVi7xFKtKNNkxCvhpbJNbLjwiCdjzRnxnVEkC67kkH1SmzXVg2Tx+c+ZZ5u5NzJaZPRPfbAwVdE+qA+0W3R3/kx+MQBRexD9TY62/J6uRAk7Inq7uBUXezoL7LPfhV2f93uBgpz/h63Ty9Hv8Vwb6JS70KdHZlE3Wh+dj6uYTWZvRLiWIaD9cWzOmSkCDaZ3T++wCw4eW7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/75j5F1gYZgWA/gadsI5covELBl2Gt37PJjQX8yhWOY=;
 b=c9iWow5BQOanwGJp6zdhuZnwKHHVru6XohCi4jaKGrie6ROyQRPjHq09ZYnavBu+z8g4SKWnQkzUBeoNvKhsgr7cMz8OR7HjeIASFdd145XySc7EUz2XkBnPUektq/0F0cf9GuaSIpVH/sxOnh1Pk+A29HrqCEL+ymyqR2XEVo8=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CH2PR04MB6693.namprd04.prod.outlook.com (2603:10b6:610:a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 04:53:58 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::2e44:805:e7e7:8544]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::2e44:805:e7e7:8544%9]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 04:53:58 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/11] btrfs: pass flags as unsigned long to
 btrfs_add_ordered_extent
Thread-Topic: [PATCH 02/11] btrfs: pass flags as unsigned long to
 btrfs_add_ordered_extent
Thread-Index: AQHZXfjixrFrNuc5CkOco6Bc5o2keK8JXVUA
Date:   Fri, 24 Mar 2023 04:53:57 +0000
Message-ID: <20230324045356.na4etywcvl4mtp53@naota-xeon>
References: <20230324023207.544800-1-hch@lst.de>
 <20230324023207.544800-3-hch@lst.de>
In-Reply-To: <20230324023207.544800-3-hch@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CH2PR04MB6693:EE_
x-ms-office365-filtering-correlation-id: a5225e21-86bc-4959-c784-08db2c23c723
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: swrpM2W1xnrvNuhtgDpF09QDQqH9B9n+MlK5YxL9QlU46s5vAKsJ2bBNOW/Q+coL8tEcTkMuLUvd0Pmk9POEpuMzxgOQqJ5MHGTa8DMUAaRPEUogD//yX5tz5UY5Raqjyl5WIcOZMvJlep8H/kw6WR7ZhGckB4CePUxR9GSjZIDDEaTZg3YACwG/I6BfFRbJWqdcQNWPKroZRYqvtK9naI2xJnohoJxi75KnKxYyb1lDUvVS1ZxHGyWwa0mZ9IJ5Mt1jyy9UULwL1/A7PhCAp0jWHc2+URhleLN86P3fCB1Kk+GgwVWAi8e7Jx6U66s4jsklSFVQU9AeobT+EBFLoB0/tOiX+FV6sPPymRPiv9UE46G1UjqdK9afEJTgb18sX0QeN74ur+GBHUMmitH0mZ9YG0IKosFEmMg84sBQ8rS4/Cb6RRTwW6JB88p2K4fUUag2YySprSb9iIWJFlIeMCi4wd28htdQXfY9GdaywBW/hs63m4ak8P+owV+IwdunPVZLOv4Q7HVmJvXlMr4mgmT+R2cWajTc24SnkA/pmNzxauajIex6HBgCYviRFrvbGzeHeTy8Lmaorzd/xX0FWWX+uso/qNCzbwNZNK4A+Qo0DWasxNE+lqQ+UGTW6QaU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199018)(71200400001)(64756008)(66476007)(66446008)(66946007)(4326008)(6916009)(66556008)(76116006)(54906003)(91956017)(8676002)(41300700001)(82960400001)(5660300002)(122000001)(1076003)(26005)(6512007)(4744005)(8936002)(6506007)(9686003)(186003)(6486002)(478600001)(316002)(86362001)(83380400001)(33716001)(38070700005)(38100700002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mHWtlqaAf/Al/UrcnLeWJyH2lTXlRs0UsLh3zLxK96lMBZAL+dWOY1Qhp0pY?=
 =?us-ascii?Q?CCAhZkrpFGpQkrjdQHv2MCWeB3gVGDTDYuaQ9qq1tOm5hF2y2XAJ5kQA0irV?=
 =?us-ascii?Q?DxAGkdDLcy/x1mkPGm0gbDIHzr0cwjU3mVofcVQD8Om0qn8gvfi1QjNj/BN5?=
 =?us-ascii?Q?BQHhXy7dY1gOzTngBhMus9y6HvPnGNOOtPyyVpCBUyy962I77tmUj4v13Qza?=
 =?us-ascii?Q?fDUWShHpr0nvlJO3CebV/JICDAcZ7C9Ax9X9T49ynlJgD8ClS87XtTZbf7pZ?=
 =?us-ascii?Q?BYkyAjUCywaJKKDWQ066W46zb/fAMAMDbyJ0iGFkU4P4CXO12oOvXKoSVrSk?=
 =?us-ascii?Q?YGExvgmIWGKR3wZUAlw4CNelz0NrmVMmmyRuz4X9CtBx7ds0J0/VvyUM+fD6?=
 =?us-ascii?Q?llB31WDNviOLawWtjvRgIUdAI/nFOL8z/k/LMHUwYgxYHUwK0ddzu7xrBaui?=
 =?us-ascii?Q?u0NsIWf1Fev6wNnDjYzn7wLAv1Z8d4RM0xLd0qOyj3h3UF3vQAFFIlynbeiT?=
 =?us-ascii?Q?HikjfL0ZaxD2KrLUVUiUkHYYvwOWGS2DDUvf81p8kj5jqr8cbkxvdD2mAPG+?=
 =?us-ascii?Q?mlelIp8oeO+PZN7DG5ZQQTVeXl3pwWyWWDnV3D14jh27/ha2nb3VdltyVgAw?=
 =?us-ascii?Q?CQd6v2HCLA6q1KDIMvWU3W3IcHMBinG0IbNkaimWPmBXGHNR2pn1+IiAtEZL?=
 =?us-ascii?Q?vumdDp3UaosDNe9PO+teulnA0i+CJaUhPi66HR1e/93wqOd4aqY2q4lRn/fz?=
 =?us-ascii?Q?h0pTLEcgFL6VtDPnC+u9FfNP3ytTeFsRX3DrFJUxE0TLJoy59d9RpSuTHvxP?=
 =?us-ascii?Q?e1Ts4vj3XSO1RKJ+NPeCBOFMlT8qgjqds7ZoXvz4VG0/VPeZFDbV65uVQGyO?=
 =?us-ascii?Q?ML4Pkw7rzpdpXF19INTl7bEc9x0Ya/CDxbSH6ioLikexYx/AiLRU3NfYD7kh?=
 =?us-ascii?Q?r2DPLo8yj2d+iF2HOpzlsJOt7neWM/52tXUIxmsmAb8st/vcpv1A1eC7bJ+f?=
 =?us-ascii?Q?LxTFoJxuCUs2wR177TthAJ9edY97nsilvC3NEy4h0iAuWAbO57rNUGOoi1Vm?=
 =?us-ascii?Q?XulWBcS4O0wsZmLFAGupw5udO1EDBU2Kp/76k6/ipimxdu9EuAT6ldVYFgtp?=
 =?us-ascii?Q?WrjT0Zp1ZM7CnLddv9+IvULOpW15Kbi+2BXCPFrMEz3xwGG5jcbap3jp6ZT9?=
 =?us-ascii?Q?KD/krGFhdAy/PSI6yyCXJZyCfLVDOcTpPUwuXi1EO41SwX2shoxWgv308wO9?=
 =?us-ascii?Q?zBrTmXokvtCqSo0FrbY9FD7Ez5xzlloiXJaFElTPwNaCU5DY/KldgNVY+SHn?=
 =?us-ascii?Q?Mrw/spNQDMRkq2vk/QhLtgoMjjsHlHmKobzwolKGzIuAlC/QJUWXY6SLohq9?=
 =?us-ascii?Q?D+JcfK+MebRczFD1gTTDb0wTtXLmdYY7BhO32j5ZyQJyffg/nKn6NKa7haqf?=
 =?us-ascii?Q?N8p7jYi0+FcZlBx+qWAvcyl8LhpklUvyVrgivHguXIHxggQazdhtDZMLAISM?=
 =?us-ascii?Q?sS7ZGsSMkOHh7SjACWMPYHMi6nSFF/Bwm5AXamgpYZSvuAGW4X7HEldsnhRf?=
 =?us-ascii?Q?paoAN9IJhbffo3dlEgOABW3PolYlHG6izTvwdJhd3PIvUo9Pe0TsIK8lIJgL?=
 =?us-ascii?Q?Sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7BD0FE65BCD6C2479B22234CB5A12F2E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9pofKjIV/mel6naRwTAB9F/nI9aFF54fwt6H/yLG2HD+mBoWipivbd5GHoqLBkXSaJbSwdUy/ymlggZlQ0KOf3wEcYf0yXivzEz6fsBPbJhb2f/7PrDLOucub/JKR2iIFZynabqgi+2gj4U3G2poyeyWFKoog87qPNzf0DSPzRrbW9rWNFI7HMWkOKPim2P6p+n3FvvdAG0GmZu4nf/SBxRocL+zim42pqaQNTxcBjzF8hSqw9KfX10aB3+oBoWBg5o0aQ7PM9/FywpyCR0yyImzp3DmZQX5TnLvgOMaa/avyKjGC4avXw+NFenc5fiLB/CLckOgpwc6wfxb6wbwtEldHPugfIXAgsE2tAf33RT2sKAc0Mx8w/kBTpoMX2kS6heKa7jJ/lNpNTAzTx2qVSELjdNa+I8I8O5fS81RmoSINQEkyTjTwE/briknryjPeSxB0f3eIlbHXbHXUNNAeb9tbbPFlFVzxsWAzqPXl1IUijeRrYt+lcizZ422yBuAg1/Wxj5K+kbZUlYpRO6ErVWBafeixym5DzxjcBuUV5ATjiiQoxuanuV6na9ea64vE3xjgGUa4oMiE+tR82FxGb5dmLMFdTbFCeiTKUGF7Kx2MCh9KRpdzBJ7XR6WBI6VeguC4bpBCTZ5D6nL5pP/wOSNuAseKmtMvtuYcEVs+o/KPB4I9/+XDxxZ7bDt2tLP3yze7X/cC+wkaBxWTT5bfIxbh1pUKVsnyZEzDcyvyJO6bKCXEg31QKcvPiCvIRZB7b2a5g3yZ/JIy5bKcvvHt2msvKY60Ir67WsB8DpM2HqJywUU8UtlIWu/fJvoUHfFjSpsDTTKIspY62qgjINkS8shFBOGHBOnI1FpTpc+5XYabAN83Xe9IV3yB4hkNglbpJqNyCD+YMyuZQaw3jbbXA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5225e21-86bc-4959-c784-08db2c23c723
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 04:53:57.9076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1M5K6QV8+YkMMckST+Pb6C0mTnK7OO6W3Yt1GmuoGWd8XssjS3RPwdb/mZcVKqGR/M84IccxCgEQqfDRHc3fDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6693
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 24, 2023 at 10:31:58AM +0800, Christoph Hellwig wrote:
> From: Boris Burkov <boris@bur.io>
>=20
> The ordered_extent flags are declared as unsigned long, so pass them as
> such to btrfs_add_ordered_extent.
>=20
> Signed-off-by: Boris Burkov <boris@bur.io>
> [hch: split from a larger patch]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=
