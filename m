Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7338C5AD2CB
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Sep 2022 14:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbiIEMeF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 08:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbiIEMdp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 08:33:45 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B5D61D74
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 05:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662380844; x=1693916844;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=e0b0Rqg3R1cpqwT71Pkaovromose8SIKN1V4kygRots=;
  b=S/PY/McFOWl3WivVpGP0IzstE9UT7iK9Qj6jp70+WwV7fLMR5lJoRluT
   GBzAaS1aelHM/nNJ7davYpZr/BB8KbwYkI/T7OxwHRFMzjDeYyOSbb/Jo
   qwBugICHdmx809fDWCvgieBVGbStWNMiA5/a3WUTNmNYwlF/EEbtzwSzi
   ITWsIoqcy6XHAjEvHeM1OUAbEiypzzWkVtQ1OgcpNG3YdiekeyILaxdIF
   Acf6LPsi9K11M9db1/gVbCoyszWn4bEXHE/A7xpwblKkwlfmcBh2x6iRf
   An6P0GH6svjJsVlgRLivQY6TwK3bi1OgwC8EbgoZBOkfuhtX8kokV9ntt
   g==;
X-IronPort-AV: E=Sophos;i="5.93,291,1654531200"; 
   d="scan'208";a="208954323"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2022 20:27:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KF9H0At6lx+lJ98HinsJHEiyX0PMtmF0dxyrfjll7aT3FBMfE22GHmQf9Q+FR3+4Q53EGVdxG8URkt0yKPTL3EVAMyAFBeA2x/JbYfaCDAPY9Vx7jcNpd9G7Xwz3Oop6pq/cl+ulQJ1rKpR+Rk7307vTAwn/iYrrZETz8MUoOQL9gEVyAZJMp2IlvJ+T0+it91uLlDPjPimMAqjRVgegM29Ip2ejLNz9I/KeX+FlnB4MOdh0/htnvNBEqrXWlYl9WORM/9boJkRTkEyzZGg/sUm6OU0FwqazhUbcFf1HYXtPWLNDE+j60MTEfvHF5hVFY5WdtzzQRqS5+A0N4thWow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxayl+529DDPRuAqFVxByIIFLZtfoBX8a4RTES2qv4Y=;
 b=HZH0Pg8HVeaqC7JRhPIGt7YLPY96OHf010kC9IybP5kw1rqX1hN5j716w1jAq2XXbTGDGm1fj0mDLKZCswbqzuCYdzz+DXB7+jgvR9R1nt9+ZLGyQunzggvxnK4cQ/zWlQBV2iJDmSBf9QlwEuLQ7oLh4caAOcTGpDcxkX206Ur3+2QgeAJL5SdwjwqY1ypG7ejak904V3/5lBBvWirBvwk04onBk/+NKHoeDdC/VlF18LtpENwvhosmKmzV3hRMi65SWHd5a/kV+/Z803LjY1r4cWndzv8lXjMz358tc4UI3+eHg5sOV0T6lIZymxPdMQ1mUhHJh4zweUBFQcRnTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxayl+529DDPRuAqFVxByIIFLZtfoBX8a4RTES2qv4Y=;
 b=qmS1mF50/eSRfCJGCjbqHhzugboMwATnfcOnY+fJtAWWLQsjZu8/hc4+z3bBrynitJQdcd9Dqf0wTblv1H/aMLbxOZCkMmwJKj1lL/fXHeqjCkSJ58O5pNpmGFRCkd/bCnU60w0Obz/c+nmj6eAtFS87c4WZM6pRQCc6A4GVYHo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN4PR0401MB3663.namprd04.prod.outlook.com (2603:10b6:803:46::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 5 Sep
 2022 12:27:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 12:27:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 01/31] btrfs: cleanup clean_io_failure
Thread-Topic: [PATCH 01/31] btrfs: cleanup clean_io_failure
Thread-Index: AQHYvwlC+KVP75Ui5U+WQq4EYbqlnA==
Date:   Mon, 5 Sep 2022 12:27:20 +0000
Message-ID: <PH0PR04MB7416008B86CA59C082081FC49B7F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1662149276.git.josef@toxicpanda.com>
 <7d5c4a3ca2ceb19fb3c84d5f3e716828cae0fb86.1662149276.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c593968a-8969-4a49-13cd-08da8f39faa9
x-ms-traffictypediagnostic: SN4PR0401MB3663:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iuZFF+zSERLhwqkvccZ6AAF8hXeOLF1fQzmZx+2VwSQ+f4GItaLkeOIaGaM2BNeNGgN3AqzDnf73e6RMejKJn3DMlaZxmgc9a+zJKtvNKVaTJrQBh/wN5Hc+TmlZMuQTFAnIgUWJg5y08SQW6B6JTXGN21Zpa6AZLldjgfJtS/dug/3Z3s+rwuGCNaJmzOSk2fyk9s04PK6FeMjSonlAI6pYSAAZimJqKn3EOGJ8OuGUrqX1lj7FQ1r1ME1YYrobyl0SDxy7jE3kdH14CKkRPXCdp1UBMgRJi0AV/PXS48+JZUo8J7lGilkE8L6/ZcWtVTsXnUzpJN5s3CMa4u1j776Ptv5aObrfRCZRNZ65DDuGDUlBiOS907lleJ9pqjK58+pFFO4gYMIoqzm0GXa3Ood/iYsfmd2eo7BFFIEaC8mIlMXfg+Xp0EQpGui4WkqpPpthnsnPjXd1Q1j06ETemDnlw11z4v4fymR7Pns/xCAuXjFapU84DKK0g8Wa9mtqUnvSqOEQSFPCSJI+s2B/cWQxUkOZ/p7+bDKAP1TDlzAV+Y0w9jd05oPC9SDZHzXapn2YO5MfUao+05K5vXFWIawwNUaaK5EBtN/KplTLjOOaJDwOkq/zehvBztcBsBHKTSFZWeK1h0lI068QLPL0evgjT05wgKkkwCSa08D0pwLoGh4uHo0IRvTENnh1Ic3pri2itFGMO6vLg0QD9+MkWwrPGjTuY7uDkHD8OfHw0Rde5HlqybxfAFgxmm/pGErMJKcbXgPFUdyKlcMpsP9QqjdpF5gJClHIyk/B2ToxZYc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(52536014)(53546011)(2906002)(71200400001)(316002)(33656002)(6506007)(9686003)(7696005)(4744005)(186003)(38070700005)(86362001)(82960400001)(55016003)(966005)(83380400001)(122000001)(478600001)(66556008)(8936002)(41300700001)(66946007)(76116006)(66476007)(5660300002)(91956017)(8676002)(66446008)(38100700002)(64756008)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hHCi86B0XhNJysBs2MTS9yzpBF/WhJyYzSOVBZZcJvaOOcou/H8+McZ+pVrW?=
 =?us-ascii?Q?hgJyLRIvgH4lgQjdimD1F7HiceNqN2ZHSo9fkLlrZVPnepjgIzoZkyOdeFsL?=
 =?us-ascii?Q?xEkbuhHTjaem34tmOLtwuPQ2OsfHGcQAMS4ldJV90ThRWiO41iNo1ulkTjCZ?=
 =?us-ascii?Q?9g9CQSk0nLGl/JgiuvJi/461kFv+nPkz2fZs2Y1XMHXczoYRlc0s7kaqJ9UP?=
 =?us-ascii?Q?tuuRjb0mzL9OHVd6hccV2ZIPvD7tgrGCodhV7wG/MiA3nFE6PzJXQIIe5uWB?=
 =?us-ascii?Q?TOh9DbTv08UtyV7aIPPjXXpn6D3SRddbUGkgmqaedSSAxBEOSFGxWEcqwGKv?=
 =?us-ascii?Q?29G3V7LJkD89/OeLU8RbCox+6YlBD1Ffnv4R3QgejAEdYr/HwuqDDQ/imeXS?=
 =?us-ascii?Q?RBNa4Zld4q32AyN/SFdc7F16RW5E1KJw0QTDBj6l0xrvlxE+N5dv2vF14ReU?=
 =?us-ascii?Q?lZ01Hby+3PoMHW5AFuM8AaKVDBCN4J40nXt6QkOFkJh6hKpUecbEtF2wD8C7?=
 =?us-ascii?Q?z8wrO+Dr26iQBkUWS2lHC8muJLVPvzHklCARj99+XxnmmS/9iy6KM/fdYZaf?=
 =?us-ascii?Q?GH4QQJk2GnEL+h4sByEB8/UK8p+p1DeumKbyrwPon2QGv4R7mU65voddcOOR?=
 =?us-ascii?Q?lQY4lHbrdHxSr+HU4LQB1U+VuOKm73qFBOIQe7uqSONIrIprmo9UVK+Z+zlx?=
 =?us-ascii?Q?mWsVyGi+nzHWVP72m0zkZIwmZe8/Mt+XFj0Q8uTX5dzS+A8zwqdphWEBrEsn?=
 =?us-ascii?Q?/Go4DNb7tACdxhabcyBncYIzc33YGZL5S4KZk/q/yckGPDOeQMxLB7nztnxZ?=
 =?us-ascii?Q?GciIm0ZKj6UmUFwWMCZfne+KQxYcyIzl6+xJyLsIZhGzl3fN0KbvFIKVY5Uw?=
 =?us-ascii?Q?K0idtTYWO2Qlr3h6pALcPdFMnWep5YV+hT8rSrZfSYseI41Yard7c8qAvIDk?=
 =?us-ascii?Q?zk5wMTZur6YCMU72+V3P48n2CUQgX6Sd/rwRxXkUn2lbultiIYGO4Ein+vkN?=
 =?us-ascii?Q?Ai5tWKtURWbXWdupBITve7YbG+V9C9iVnOJX5yZDU24GxpRgLHhgJnd80JlD?=
 =?us-ascii?Q?A2rWnNVXLaF34jRlpVeek7ti/fX1OVdPfxwM0V9kajdZcfSOTij3iYcGFjcw?=
 =?us-ascii?Q?i5RhSjIVxkHYBQx4ZF7ikcPr1VlMh2Rqy/QiC1YDyk7W13KK/f2Cq4YpZo0o?=
 =?us-ascii?Q?FBj4vjgB4Q8fdr+x5qVvV6ywGghNArIXxSBKMwCzS+koyZ6ofpgqz5EM0Ltg?=
 =?us-ascii?Q?G4shUzDr6x/MUaPurSW8a6InU0zfEHRK1A97168cdXXCu/qOKM9VjTf1Q/mj?=
 =?us-ascii?Q?AYHDumQpJHBdISW3wJm1FXjdW3CYsUtze+hu6fobmDQ7IrioScL5LA1hn7aF?=
 =?us-ascii?Q?drl+Wcx+0aAlpG3IXGtWHIrLkxO/rMPEanMVNozf9Z2hCbIFjDVcWHf6yWzG?=
 =?us-ascii?Q?Y3aWmqv/rxy4XlehRU84r4zx3ysIa/FJey66A4q5zerHJ03n8kuK185eB8up?=
 =?us-ascii?Q?C6TXu7ULKX9bw4T++IIi/5DWAJ85TADvnhmb+mKr++s16Esr82JO4OKbu+N3?=
 =?us-ascii?Q?V939qfdaxv9RM5Uw/XW4thwTmL/+AkqgZjquewYNGbLO9OZYDZ5FbT4+9x87?=
 =?us-ascii?Q?JXm4OnPle9p4vnVpRRnsGW3K1xh2lZm2rgvGpCXiD9eUY/6MtQ/VFRxNEUcz?=
 =?us-ascii?Q?S9cU3rB6H7MdbgbgeS8vf0FtESU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c593968a-8969-4a49-13cd-08da8f39faa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 12:27:20.7482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LzzN2IhdEk8TfXbKlk6NL233M0k/RNSjQGrKpHzgOjRQdnb2quLHEboinxWRnUkt/CRrkwMO/ZP70DkW//qi3WcjzBo8uGL3v1fqlr5qIXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3663
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02.09.22 22:19, Josef Bacik wrote:=0A=
> This is exported, so rename it to btrfs_clean_io_failure.  Additionally=
=0A=
> we are passing in the io tree's and such from the inode, so instead of=0A=
> doing all that simply pass in the inode itself and get all the=0A=
> components we need directly inside of btrfs_clean_io_failure.=0A=
=0A=
=0A=
Just a heads up, Christoph's latest series is completely removing the=0A=
io_failure_tree including clean_io_failure:=0A=
=0A=
https://lore.kernel.org/linux-btrfs/20220901074216.1849941-5-hch@lst.de=0A=
