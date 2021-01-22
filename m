Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE9D300353
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 13:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbhAVMhB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 07:37:01 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:28087 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbhAVMgu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 07:36:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611319009; x=1642855009;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=kF7hUFh3ig30POKUs1UOR8+sIp177OOtltc2USozR8RSN1U2jANzOv06
   m1VHDvRy8DHACrMlyEIkhN64VYPOFq6YoA4zkPUYkVLi7kZC+tnUpoAPq
   A92bgkEIw4YiUBFZkE+7auNEyyGMHfQ7VzVCme9LSgTA1dtbUbNCWJPAm
   h81Y1672BCmuvWuGKbImapP3ufzDQ7CLVebI9MnsOTtqs6nget4RGaBUI
   oNSfzWAg+O74Cm255xjYAKPv6BK7mmq7AYs9OwUBU9Bx7tSYkokCBf6Mv
   I1pAtkHxyaULOxTaZM451AgsCDoA9Hfv+/Obv5ykbEx9AmgKQnR+tOIux
   Q==;
IronPort-SDR: HLqf2OHK31Lm5t5e3TY6OmfRSoaBk9nkUJhIH7jtzIB8PBwbpwMxvzwSSo7aswyyR2EJTJ/7Xh
 jrL1uGjNaP4A6kjfNN2mGqFdH13RdSm7kH/gQlOrFURGK32XqvpUHcnfIPqxDGKRiZP8u/i0AN
 8xdmJsV9Y5rpGTxET0sV8Vy+MvaSop1k0oECSVme1N1iBghB50fQnbsVjd9Z/2FvPVcGxNRZdg
 llr3YFMbODIRELFjWvUbVNzvr+1+quX7kBOGio1b1xxK5A2pSYrCLAN3BXsaXc1t1dCX+SJpoT
 sD0=
X-IronPort-AV: E=Sophos;i="5.79,366,1602518400"; 
   d="scan'208";a="268415470"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 20:35:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYM5Sx1jG+DNonP1DcxwQQNeHiSRNwG4jw6G+FXQ3oZSxH82fHyYNYGd+JmxrWMqpt30asrGtm+4TnyCSJe5s609rb4nwy0ex/8bcsyCiWKsi2rpn4earZAre+zVQ+aC4smsTWooyLJzVv7uHzWjWdZzv1TpKYHNlyPHkJ8dSt6ZJxHUlQwxwU9bzkHrbDelcqqWLsLJvDd1WrffCmEByfJJtCPkosT801Gt3eFkFI82r+MV9gatmXWHk1mCK41agGFPPz5L1g0H0dYnu23M9cQCFB8GRKFteOOgqfGGciUZYJnQl3UwHrJEQO0yBt3/7YWKS/3rj8d01/6bwKDjBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=TB32yeGHEeTkE5k9WggztBYeuePLhS+Z8RobDtOSmc/op6bQGcLKyXIU5OnqWIlsZJ1Xonzhc3+NJQfoKwWlnjOTFE0SHuNdFUs8zOFSpRRc8cKGkALBt7WzYxqAXaYDPNNRYm5w8bBesloGgKGPyDucpc31Dhp5eYsHNhb4TGKLmxKHHz0aq8Nmz0zGY2+/P+eiEgTjgZIjOXbjF4s6AbfekQ8EOj/6fFKN35sK6rEDeyeSUNgqg5Wzcmlnzr73CwM6X5IX7ppYpEmfdWYQhf01xB3Uk8oW8nCCN783U1NKCz2FbSTA0uy8U8oRljrGeKxPvjQJwlYjuOOCOGidGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=vCRHcjiga03I9nfAjNRLetL82WFRunnpKpUkwndBE7Srd5w46IAUITFJISptgvyXtt1psDkrMMo0rblCLwLle6qgyrGBQ+aUBrZQF4eEEOaV8xARBdb9Fi0pWIy5g+T0RdwTXT+ND4/3Q7PX7j7Kj7T+0fviQM6KhsivlWbBiAE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3680.namprd04.prod.outlook.com
 (2603:10b6:803:4e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Fri, 22 Jan
 2021 12:35:40 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e%3]) with mapi id 15.20.3763.014; Fri, 22 Jan 2021
 12:35:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 02/14] btrfs: Fix parameter description of
 btrfs_add_extent_mapping
Thread-Topic: [PATCH v3 02/14] btrfs: Fix parameter description of
 btrfs_add_extent_mapping
Thread-Index: AQHW8KfBB/PGJFpi4EOZF8xET1NNvA==
Date:   Fri, 22 Jan 2021 12:35:40 +0000
Message-ID: <SN4PR0401MB359883F6012777B8BB43ACD09BA00@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210122095805.620458-1-nborisov@suse.com>
 <20210122095805.620458-3-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a61:4cc:4501:d881:6dc:68d2:9b00]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b19174a-c1b5-4df5-f239-08d8bed23a8b
x-ms-traffictypediagnostic: SN4PR0401MB3680:
x-microsoft-antispam-prvs: <SN4PR0401MB3680C5227353AA79F9A776519BA00@SN4PR0401MB3680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +mYem5LMefzZVPYdZQtOXDRfOVQ0ZX5noaDbkMUGBIkhNkfEkuxpVc8UQBaDzzT2HaueJpyv2MvBgX0dwCBtnvFsyJcHGETzO0ZKVIBDjxL+D6Id9VsRmzgRw76SYUDMcoP6rlvQo0zx3BBDgZof0O1Fv1tKTjeSmbhwORv+iFTTI8ybB/9InWMeV1ZjGmA50Q9kLGFDB4BWtit9Q9ZFclI4bBDTstiA/FgVsudK3MkXNGZXzBY93O7fGH1P/jSTnJ6uFX1Vr5fzf79MFCBx4bDnIh0c6rQ8RbpkvafmwKZ6yqe+NaGiGwrt7hmA8K9Y+L/+G3h9xkKUKxBjYiGhwMxBjdX3idLSj6wJ3ZXZ+8/YyON1HSXk0FTt/gzbFcpyYf8fdzS+so50eWrfZOelFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(55016002)(8676002)(558084003)(2906002)(8936002)(91956017)(478600001)(9686003)(71200400001)(19618925003)(64756008)(110136005)(5660300002)(6506007)(86362001)(33656002)(316002)(7696005)(66946007)(52536014)(76116006)(66476007)(4270600006)(66556008)(186003)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6swcW+6p0nXQCQPxr2FqenIQKfgdf8SxvDA+QnLs4IaS7Va10/OXAkPqVodG?=
 =?us-ascii?Q?EOmW8/YaSLJFkPoo0txQZGUF5e203lAFV1yCnpmk5dGMYddag22R0P97n8wn?=
 =?us-ascii?Q?fFCqMQea3u0CzgaX3AE9mqygxmkg11wlU10/OKBlnJf4iujFxeJyOlVf9N6Z?=
 =?us-ascii?Q?yr0WMAApGmYOKGSHcyc0a9JPEuaZlte5hDcbkMXZZUNjDimVndtVsYeAvjRV?=
 =?us-ascii?Q?NC2StMMvuovbRDIhiY5n6swza0iZolFjeftTxAKOfQU4O67AG7OVKlPf6Pz1?=
 =?us-ascii?Q?bJIBy9qCnfflJQybnGUYbBnvR7tsgSEUWzrX9j9Ndw4c9bVgtXE5hZKwq+MP?=
 =?us-ascii?Q?AIaoBcKYa1tbyzINVrEU+ABrp1246XNvFgmEDL74kbvCVARw4CoxV0AB4PHi?=
 =?us-ascii?Q?g1j5eqVojsU/AG/tLUCFPLy3r0XGnLPbB7YWMKCJG3Q2kZKHW6dnDXsygg8f?=
 =?us-ascii?Q?fOuBqLkRJY+32Q9SG/Brb9ElGNKtG/O0MZblvAfOfvwa2nGPuNp+U7GcIb1N?=
 =?us-ascii?Q?mrEIZwm+dvesv9OEYEpeFF205soOVt1QqRw4tmcmpLmYX6gMWDIuytfcTPOF?=
 =?us-ascii?Q?6X2DnyJVxKbgOoq05oo0tgbvOmsN+QE8zjV5+aMpseBXudzCpJW+r96Ez77r?=
 =?us-ascii?Q?6H01hvBGUquDeRGjnMaQ0Serak7amJvwHotegcsC8jiULekqPxHT29APcoQK?=
 =?us-ascii?Q?G5rrkceCbNUlZyM3iOqhiCOh+J8ZUHbPO5ksHpe9CU/KW2UzfuRV5Opj59hC?=
 =?us-ascii?Q?vfkgdNfF4cEomZdFRS/rJUFh/yFw3BX65w0pY1cdGbMUHpPXVHsQzeaDSDel?=
 =?us-ascii?Q?9R3Rv8wx3COlzawScFKp4NgKVrmOhMa56T4M5jXp9OYyqS3kbp0vU1DrT+Wh?=
 =?us-ascii?Q?nrOuLnKCEmgnCFu5tLC/T90RPXENQNfWKjrZ0zfkj3vNVhTbUhyc26a+GGsL?=
 =?us-ascii?Q?zO6iwiHvbGJT3VxFPRll3vqRu51JpqDttukaKlase/gksq8c2xOdIyakdQY7?=
 =?us-ascii?Q?GcpkDRHTqb7nbHrd/8vaZrjxzkNTNBhPGnR7fLVDQCkVd852DXaTTkSI+kAH?=
 =?us-ascii?Q?T31qhXHU?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b19174a-c1b5-4df5-f239-08d8bed23a8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 12:35:40.2817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2IF3HLar5D+hH6BeWQ21bdt3H85+XmfpQXrVzCZ6TF76thuNmD/z/5w4VdFY60jC4TAEXKfxzZH21v/keBmhvqmbwobLKu3HgvdM66qlLwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3680
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
