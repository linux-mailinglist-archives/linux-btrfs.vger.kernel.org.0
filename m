Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8323377B9
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 16:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhCKPaK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 10:30:10 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58080 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbhCKP3l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 10:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615476581; x=1647012581;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=aT8zYRKgkc8bHzQWePUDNt6tSiyAtx+Malq4Q1hoExM=;
  b=hWPPsS3sUQ83Om3zdLcJruFxo1GNy5uqDYp3Rjjz8k9Jv4OM9vJDAdYv
   IDb9inkneoZm0H+ta+wDEek/gEFHzH6ECi5e6/XfFTq0axbO783DXwJGA
   jZQZBQ5dKonfNc3ZfUheGwxpVDto9LD0SRCrWX5KEbB+BOJmhsKDGRwRu
   d5UdWZXcAL2H4FyjL4SwukOEVF/nMUaNZJOMBGmbVRHKgKVgeZH1F1szX
   q9ulDSGh3NZIXm4ppHe59ZxwSR1CKkySbU9q70bH/kgilH2inhRq+or20
   2+KvLqRMs4xmKh1inVK+4fxi5i4sC9JnVSVhQiZQ3S5FUNhtNwAi5i//2
   w==;
IronPort-SDR: p4zhigI9uhxctvQoqBN9c3UuAO8+hlXqLwbY44UaGxEh0JTHG9y858Ac9JmiuyDJEhKp1H6cc8
 j+8tz8nqRyVONaNeqxN+poC5G69xQHElTGn3T85eVVKigr2fOtrYuX/uqe8VUTyKUMOaAmPDbP
 fYsNt81mydVDPcBabd9DSijpnJLi/ay6iJlfG+WkPGAl4w55fBffXf3cG5ssdMUrxfP5vWmFaa
 ewOkRmoMvYYZNiipIiq0rzJGYycjqaXeBwoeNamnuFekd9i5v1tSdiBsrzCMocHtuLEdikC1au
 TKM=
X-IronPort-AV: E=Sophos;i="5.81,241,1610380800"; 
   d="scan'208";a="161936745"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2021 23:29:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NK1ML/MFPLiWEXgVYJS4numVqoz9nPR+V5uhqXnN4og6EfT4pWJ8l1KPHRcCIBNOAgizzYtoXcBAqy21utFDasUY5RRYnHxXyylDfkSJuHlY0sze1vVv0I4p/HVi68AlogtgFarLAWKb8/SBMUVjesfFghPIrs+J9bXFTac5WJZmai8WeocgbS8IX5+a8dd/VNU3IzWbS1ko55kvUArOmah1iNQUavriSuy8aRUvuU6j1zXOs4mDjOVkwWFOcViQfdC1s1t/uQFaM8oSY6bvARltrzytZlbjDLxA3hEUr9IQKYnwF20NDsgoS0b1pFkhGt6OdOb0UKV3LNFlcovviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aT8zYRKgkc8bHzQWePUDNt6tSiyAtx+Malq4Q1hoExM=;
 b=XhXzu3lN8bPM4F8XNtLyPIYMP0hSGtgTwNNh1ECT3Ts5E06JgmP/ssd0t6oohJ8eVRrSeuKWdVmRdkDU36X3h4O5HOUf7IsP5BrbVHPzhJXI1HBieXs0liPljC5caUmeJTau+znm1qunOyWlLU/P+WZTGYiy/b+sik6/jb/q++pRtRp9iy1pSyq7NCsJR2WhM5AMkVc+r8qALHehifMJFHEg85h586kBbL9yhM1oyG+If3If/SPLHAmDRo8AwX5puG0+aZCvZvPDDHWn7SU3JKfWXHkz66MJ0mIperKzqbIyhIexaFOtJWnlNpEmNzFHeWODAgL4XDUWXXq9KMiwHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aT8zYRKgkc8bHzQWePUDNt6tSiyAtx+Malq4Q1hoExM=;
 b=NL/OMHLARl42TH2iPooUD7ScCwHyD4PvblorNY2ZcJAcu+wGBaW0cf6tteMJ0+2iyYGyjapYMYSH4nFIQYDKnLkuRY4DuqQUDypIiQKswG9CLy2LNAWiw2YwcBy0MZDt1U6L2ixvhvXANKI4Ire+EDfwzQMsLXfBdSz9NYBwsKE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7655.namprd04.prod.outlook.com (2603:10b6:510:51::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Thu, 11 Mar
 2021 15:29:39 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3933.031; Thu, 11 Mar 2021
 15:29:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: fix linked list corruption after log root
 tree allocation failure
Thread-Topic: [PATCH] btrfs: zoned: fix linked list corruption after log root
 tree allocation failure
Thread-Index: AQHXFok2ZAYVhdUE8UyJaESKvXgekw==
Date:   Thu, 11 Mar 2021 15:29:39 +0000
Message-ID: <PH0PR04MB7416F30BD75603972C269FD79B909@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <b4746dac89274ef11314a6abacc58a27c5935a1f.1615475093.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:d87b:bccb:ca15:1ed8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 90f690e3-fc01-4dda-ea41-08d8e4a27c95
x-ms-traffictypediagnostic: PH0PR04MB7655:
x-microsoft-antispam-prvs: <PH0PR04MB76551A4F83E8C00383D005699B909@PH0PR04MB7655.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Ug+8YqCXf2BmHhn8ROMMdalDziRC/++VqUWrJn65RZL0hPU4rXgs4xqZWEk0qk05Jq9/+bRhGetKmdmsZ0EpIiKkslFoAs7uqwM16zsO6UjNsFInRJLlQLbeUiQdpAw1N81ynm6Mb0d4767yJvZi+JFQc+OUc5/1zaXmevX36w7LULtqBI3AiUdgy6NSmhhRmETmq3zI7nJ3N0ol1U3WyknBtf0eL2ZA6VsKy93Pj8+4zlvUIFTY05AMPzg5Lzqq+vgU/dMnulPHF6xDi9CrpvW0yFKxTey2moYdNChcwJoUhPRjkCtG2SwgxQGxMeYz5bHh00fYz6VntdGVWpJzp4xJw2bDFNVkIZ+nWZc81SPmYcvprPPduHgFS2kX2keV4eeJQcibkPKwcQF0czDhrn9hv+vGKAnftVzyVmRttv/SkOgHy0YPrW2iGt9vvcGK255YS86Ntfyv3x94X9OhXiy8LWyZRAkfX1jy1E4P8BJW1QpJe7FV0nIzWFUVfoR+0kpKNqB8nXr8M/K6L/jHu+E/UUaEXKJApwkAKv1I5xvOYF8Sr1ny8S74m0HumpB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(6506007)(558084003)(55016002)(9686003)(110136005)(71200400001)(316002)(64756008)(66946007)(66556008)(186003)(66476007)(66446008)(76116006)(91956017)(4270600006)(5660300002)(52536014)(7696005)(2906002)(478600001)(8936002)(8676002)(19618925003)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dTgFVp6jGxo4A73v4pJ7WLMbGnn5xh6ws1QRTQo9JltqU/c7pRToZY2roaig?=
 =?us-ascii?Q?h6Slh6LLe0cxdzCo7et/L3+W9Rc0pyHEORklJZ/0EgVoY8AVz9fg3Pwl3uiN?=
 =?us-ascii?Q?IKiFkh5WbxiQWWK1y5uCMwFgZpihLqoEj6iZLUwYWWPFtm3E9KDkG4/cIfOB?=
 =?us-ascii?Q?3CYXTw05AJYir4UU9ZBCtDMw+CiDpnrW85/1e5ryXg2ak6HNsPlhJFHxtrOL?=
 =?us-ascii?Q?u8Bnnae840F4choPJxbTXOo/J0cAM0gxOLu1REm/ayPBhvVsDFcDRPzaZgvb?=
 =?us-ascii?Q?kUOwQVjCaSbLaEwznvRhCmLe+5MsRNxDGej+cD7gCV+sgUwe1rLkFLNhDe6U?=
 =?us-ascii?Q?E0Pd0OmoJ0zkRYOJ/+vXy3f+Pl/55JW5+Ldl7WIROPlfudNIDpPcmUaIC32W?=
 =?us-ascii?Q?O1FI3Ls9hr+fH/qBXVwePwesbb9oMPZ2bdT5snI+EfDrqZws3NWFv/FGEjr7?=
 =?us-ascii?Q?wYAKlbhqEJeZxx8dvsfJ99QGZ2gNTjA3OehkBXa7Es4PdbxpDKL8T08vMyv7?=
 =?us-ascii?Q?VLgNQUUMwzjX1galtvxAWdkqrHBylklcYTE/b8qAkq+jxphV1/D/1868/zRz?=
 =?us-ascii?Q?c21H7EnS+lG16/n+BqoNVmBVaKqa6UnQytVWNoACJ+fVgtgdxbNtP249b+tq?=
 =?us-ascii?Q?sNk+KgjbWkwmsG0eIb5699XvGktN3HuoLzrGhWXsumBhirI33x3iMhNUht/X?=
 =?us-ascii?Q?C75AQ9zrnJamsVJIURV8zbrDlcWS061H9q0QO96Zy3OxFj0c7ayNZstBi8aR?=
 =?us-ascii?Q?/1UcLca2K5taaIhvXfCAaLKBFKagobfS4K6KWdvUd9yOBgq7i6cd5/VbE8b+?=
 =?us-ascii?Q?pkQXjEN3krv0od0EWMascgv7nEA/qYxEXPvP0ZPrL2aXwiLYkXRLHwokdUZz?=
 =?us-ascii?Q?6DM9RqmNJ265H2zOJwLv+CMiiD99OyUe8Ipw1QcL4JbhfegZyFq0QmdrqmlU?=
 =?us-ascii?Q?Bf+W9tyTGYxsUGYmese6novz2GKtKNqr9P1ysC0K+Y/au00S03X6MNrq4Z7h?=
 =?us-ascii?Q?SQH0vHoo5VnCsEDpK0V4MNDeyUIEYN9wjUommPA93dKah3ncXwX8Xp7XlWJP?=
 =?us-ascii?Q?Jnlt1X0b2xOZsbYAT9923QS/h4jAKyR9COOzUeAKv2vN49Dc4PrTyl2PQhUW?=
 =?us-ascii?Q?VlmkIopxTjkDBf+/YewkIvIyj7D9UKf7wHckKLvcc9Tlze/TjNDobK0zgdkN?=
 =?us-ascii?Q?yQOqBk2bI8InKjxr/HEyvdwnpo76C0zVRRpLqe64CiU9y0pOAtPgrpZAoLdv?=
 =?us-ascii?Q?NzIW55dc4cPUTLIobRT1eWDc2cEvSKB/zUw4aaFL50mBgsqFe6n4DQQnT7Td?=
 =?us-ascii?Q?piavtDxPOgQHyLJwI7ANQH/HGvRUD8B3L36qt3LYXH6c5sx9gpYiIr0Z/YRF?=
 =?us-ascii?Q?aYd8hhCUmPAFcTu0BLbGd9Pl87c7GwEhDbjuFrl2c+uxvIkZ3Q=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f690e3-fc01-4dda-ea41-08d8e4a27c95
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 15:29:39.7804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3GMEHHtgxhCkKoyoVIAtIiwrVQC+qh+G//0PRKLOB2bxMgBjRnH3mKERGCKHGdzAujCbgibum6k3axYLF9SX0ZtbOmDFEu8rECZfsKOblek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7655
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good, Thanks!=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
