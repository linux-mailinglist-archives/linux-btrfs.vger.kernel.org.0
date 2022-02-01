Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E874A5EC4
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 16:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbiBAPAc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 10:00:32 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:35475 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbiBAPAb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 10:00:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643727631; x=1675263631;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Ji3TGhJzDny8rGT8CoH5M2xumaxfAigUvDKGoXJlaO8=;
  b=PADDJpaVxyHVFXPOhLgAOo0WqfT1IRJhI/JqUHWvA1yeSdmy207dV33J
   Vz5c6NtK5MIcmTQqw3JNLQsgamkTGOGVWChKJHEkzDNpQaEw63GRCj+GO
   j2QmgpC4wyuc2LV5l1HDv3j9NvrDPCgWRnxx11OzTUCggbIWjENLJDJo9
   epDnXPzIWqqpDDrzd+6S/seEg/9GYke8P+h9TBDeeBUGvv9qU96Q+Y+4Z
   +9UvkQVlR5Jc3SpnFitZw2mAvIGB8kaDXiGDCegVDZ0PQD5eoNn9bT2NS
   Yt6defcxm5zTXo27whfLuuhCDrV9B67+IuxrbU2Et6lGEO+zkNZsa9NaM
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,334,1635177600"; 
   d="scan'208";a="192883796"
Received: from mail-mw2nam08lp2176.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.176])
  by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2022 23:00:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IssH7kvweSZpgBgU5rgknBaKLt/CImm9d+gk1vyGmQUbdNZSWTc8d0d1ADLyGwRErqQLQpX15fX7fxCt4jl+OyBhjDmXkGHlANhWSNJdN61VHT79QHy5Ltv9o5h1ofb9uYOw1o6Nd+qAV6Vg6fA+VBKUDduOjVQ4GYbq5welBoa8bf92GG1bz5xj4oND1hBZY0nsUZkmavCq0m/RL0QU8KM2nDDBLtMAUuoT6sW/xyJ0s82TYAouF6/Rrx0ob/WhCOa/wr0dTj8ndbL61tMcx1qc21ap/W0CE5P+c9b2CoyVwa1x8KDXVChBOKGDAZVnI+bpNidG2aA8nqgLeDG/+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ji3TGhJzDny8rGT8CoH5M2xumaxfAigUvDKGoXJlaO8=;
 b=bu02gxn1iJWlq3DT9uf/miNTIVHUw1Pl4QkTgryslg5qZJ8RGMJweTE/K0OQndh548QaxZoT4iLF+othhLzTtwUN7MX62yZW9alJ6xX4Hl/xZG3Xc1qH1XQvrNSjG9KVbRXBmwnndxHAPQfClummsnPj4b6nscVB3l51Gxs2fbIrdvp+lPRytUV6dQ5gjfkPZsXdMDZ9jDwbDYWeZr9SwpssApRwqTg/v6WieNWXE2P6TBeaX8/TMVIl7G7GM1MTgj1u5i0LCQgloTz14c4A0ii1d+ZOpjtbFr1qyk0GtE6IfouwREF06hBDDUvitWtVB7j5NULkaRgrhv72QiC7OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ji3TGhJzDny8rGT8CoH5M2xumaxfAigUvDKGoXJlaO8=;
 b=xb1qyvfjD4Ex02NkrBGSXZzgqmP2Yeikft2bMKj8S2D9iYNMYpYxI/OIWjwGsyxC1y+2/aeTnMQHOgWoiPwvuluHrI7wCisFET7cooVFHXTCLo49GRec41jiA4o0nTqtedssEjpoxTssetQNBw1YxjtFQBe5coqoQpQEGu/pmv8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7485.namprd04.prod.outlook.com (2603:10b6:a03:328::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Tue, 1 Feb
 2022 15:00:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%5]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 15:00:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: replace BUILD_BUG_ON by static_assert
Thread-Topic: [PATCH] btrfs: replace BUILD_BUG_ON by static_assert
Thread-Index: AQHYF3oDz/goFZE3SEuSSsfHVZcUI6x+yfCA
Date:   Tue, 1 Feb 2022 15:00:28 +0000
Message-ID: <4f1a4bd5f75ff96917fac66d76d8732ff5956440.camel@wdc.com>
References: <20220201144207.11721-1-dsterba@suse.com>
In-Reply-To: <20220201144207.11721-1-dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.3 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23403588-6b2a-4021-eee6-08d9e59395b9
x-ms-traffictypediagnostic: SJ0PR04MB7485:EE_
x-microsoft-antispam-prvs: <SJ0PR04MB7485888BCADC536444B6FB8C9B269@SJ0PR04MB7485.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cvYkNakOl2aQ5pYXgt+oy0NTq6OHIPJWtJLVG2zPgLzpR9nLRZ+1o8qDNEbBx0LAWcXQ8WaSw0r3LeunGphd4UhHNgHX7iopC++LI8gu6mbSIrz3mq150lCcVhBuTpjt4IIZ4iv4u2Vow2lu5GPjUG9MX4TlCKAoMuThjXj6jCNEjSBH+p8rXP8WI369siwoNEjFRTUTEZW5wjOIc6DG80oU84OQbv2j55fCw8WpP/JjKCZ8Jotl2Pgs+jUVlqofEkdbdaI2i7J7j81xPaWL30W1wZi2Z/sXLAWU2aVLd0MoH+0rl8CPl76+i6mE9m4WnsH6MMOzUPpwk9Yby4tDI2UB5PVwlNRQuHrcMyuD4PgHWaEyXVHSi9H/V0+zsM24egc0EmNAO1EMn+Ug0xn+XZGG+/eJ7eigib0VoSg4sgig7l++l7bAl0oJnjeY7qn883A+0RDssXu5+ubx5xGrPUbJ8o9OReKo8KpVR7MVMbpKJNw/OIP3hCtFtxT6WLzZzBCMJnqCcqNYw6SjqZCrQv3tYzlokT9auOt2t1nFifT4e70mJoMRFfkA00p7lug0+p0jFeH0nA0bmc6BIqHJrIe4BFGYnDw21dbc+E81KVGxxdBV3zkdciatwYQMgyg+tzBipQdsEIhpuJVx7vRc6S6OUptSx1W+3bGtn1ciG5VTPaKTro6eM5KxvaxZSoQpmmvKLWTuKLn1n28cGMJpsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(91956017)(316002)(186003)(26005)(4270600006)(6486002)(36756003)(19618925003)(2616005)(2906002)(558084003)(38070700005)(86362001)(8936002)(38100700002)(5660300002)(6512007)(508600001)(6506007)(82960400001)(71200400001)(122000001)(64756008)(66476007)(66556008)(66446008)(8676002)(66946007)(76116006)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OpWrbfzEmaktOWRJodE1P/oP6oncshwim4ptYyx3aFI38XiX6PZgz8PzEt?=
 =?iso-8859-1?Q?fJMeKz4M+6KFBsRCoMG5JteWPeMib9rRJ7RehB/MHaaSG309xkIR/iD0s6?=
 =?iso-8859-1?Q?T1BLrsGgpCaEiAg1k1j2W4HrldrsrZhoqMPJfAwP/uECLnIUxHH8pYFgnM?=
 =?iso-8859-1?Q?ENLlORtPGEeUYXV3h67rm6seNkI7WD8n+wYB2Jf2Hu07Ox62gAfZYH+SjL?=
 =?iso-8859-1?Q?c9XVEKtijlDH305oZKB6fLZ8I/rvlLv599yVXmyzBdheBVkexQOR5e5eb6?=
 =?iso-8859-1?Q?lMC/fT5shW87UsHmkliiZWS3Mhq/m2933YZIOCkZQUgabkpXcK5VW5orQ8?=
 =?iso-8859-1?Q?1zscXO39QKR6jLrrbDMvYCvX9WT1ftekvPgzseYQwF27v8Q2pgFoxfIazT?=
 =?iso-8859-1?Q?UwYHOPx1NQSXul1vZUm6nYirRN6/WBa1dLBTgNqi3ljsVvE5YIgXsdi+mL?=
 =?iso-8859-1?Q?HGPU4TTMCu6/AyEEFGEyLVcr0NsRmmSgldaoHieXSO4IcXhdCktOgIJgZI?=
 =?iso-8859-1?Q?ZM8pc0SVsOupfoLXxVmiB5/emVjnWACMHXqA987ZOYRr5p5PRjKLCEIhj8?=
 =?iso-8859-1?Q?BB1O4rzCzJBgRACKf/z3mGkabmLacgmQdXhuML4tJoASuQ+6+Yvtlgvt/u?=
 =?iso-8859-1?Q?14Orkn62n99SA3bMvIjxPbYXMjrBB3EUntO/tQ4u3aeq1nW7RM6Xui/BSa?=
 =?iso-8859-1?Q?I68aKitU4aWK/iYQsM8J67dQBiWLvGHLdTtXLAb2toCJ01CPcovAPYRvO9?=
 =?iso-8859-1?Q?lJ6f5v8MY+Y6pFuKQWLHv38UzmgNhx6PKGbOfZA+aViZO5fzoiM4SSEa8i?=
 =?iso-8859-1?Q?l4wOgV7/VmDFe3m6q2E6ohFxqs7JYAq1DCztclQvbnyiX+tVHaXJy2s8Is?=
 =?iso-8859-1?Q?ORybuW1j8kh5FKb+K0mUlGk4QXPE2QeJ7y/6+6Kws7YsT7f3mF5ewhXO7J?=
 =?iso-8859-1?Q?4jZq90Rqs7NR5baE917FfX7HzbLVrdAhCEAwBYKnhcHrkUfmu2EQKupZVd?=
 =?iso-8859-1?Q?N7G0U5Tlqe560bNhIq4ndVG4wVC1uFZkFAXYE6eEe6EGCJfzovVb6qwwzb?=
 =?iso-8859-1?Q?MjomHSoS49oHWBi1sf+c4479LhObzEu5BnDpFd/LsnK04bPasFuBmGMKMD?=
 =?iso-8859-1?Q?46tQU0Ln84l2d0gnJlkfY4RYJ7D+0DibphlTDcbOa73rcaqK2PWeyeMz+I?=
 =?iso-8859-1?Q?vFERivG6YG42FbYsQrmUqmhX0np+Olw8zFq301FD+gaczLGxx53mqB31MK?=
 =?iso-8859-1?Q?vfv37kOssk5h23Q8SdYPGJwBdMDLqIqdWrrW5are3CkVZAogSyfvWsJQy9?=
 =?iso-8859-1?Q?HpOxgWYst4tLlpv1xsOEjSXh9jnJEcj6jXZeXB/l4Gxm44odNMvRsFm70y?=
 =?iso-8859-1?Q?34NOLi5IIRy8gDgjQgKTDpb19wjCsX90ohRp5mECB3uPHfwY2m8mAH53t/?=
 =?iso-8859-1?Q?xxYpVOyjjRC0NTrWmRHKdG2zr4Ac4Ls8p9HkREs2I7ow2/1P64X+kd9CX7?=
 =?iso-8859-1?Q?F6h2bUu+JzxJy66b6sE2hQgngWHfavO3va4AFM7D8gQGnLunqXM/lpnhXY?=
 =?iso-8859-1?Q?Ibuyfd9Z8L4s1Xzrx5dmNcoTZldWJu8FWUqUEmxHQUiaIBJRjigp+ekp+e?=
 =?iso-8859-1?Q?QbXeJLOnaTfYT0qQ/+++SBUugTyUJKbplt/qqbKWBtggpPVS6AGMVWzR0a?=
 =?iso-8859-1?Q?1mLSV6kOE0jewsa3mAItcg4vmQ4grcAkzcZJZvnwYhZhgslM1Rm1dRPDy+?=
 =?iso-8859-1?Q?+uc8Q0fjN5uzXlwvtDpNTsnjI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23403588-6b2a-4021-eee6-08d9e59395b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 15:00:28.2861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxZAy3l3HAS9n2lou1y43RsC+EAdrB0cDOaMppZYFpBjVFrzQxpQRk93Q8UBRZqu76EMNsaKJZFiEsLI6L1fehdp7QMRiO/lRw6lZP1kq4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7485
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
