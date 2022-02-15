Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11D54B72BB
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Feb 2022 17:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241371AbiBOQKa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Feb 2022 11:10:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241375AbiBOQKW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Feb 2022 11:10:22 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2892BDE62
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Feb 2022 08:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644941410; x=1676477410;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=G1pMcrZ4RVsV/yzFju/cO2cVmS7zR8y7P+kmB/QSgXXxY23Iq2IF2w4y
   Mt/JOm7Aflr8ef8IhTa9SEfvZGCTfMnFJlyKR5KaWS/jzYVBE7/I5hVXk
   Fp56I7FfMycifN5RUIrwsZkQzQQ9uOXacJyG9zw+ZPb9nb5jAwtKQFppR
   gXOZH1ctSMxaOIoO7V91vIJOuF/AgWEwoSAaGw7jlva75hKGidFrzl+pO
   XM0OqzbbpXMJdBlpoFdAguVo4JJDKsJtBdabJM98gZdk4tAIpo7KOORRI
   4y/OJ95R/8ekY8PhwTd62WN28z0uNuy5o1wRvYG2VegyfkEc8naEyq0vQ
   g==;
X-IronPort-AV: E=Sophos;i="5.88,371,1635177600"; 
   d="scan'208";a="191949512"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2022 00:10:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccSGhgTQ2FGC28mTRc6kPfB/6k3QMWTBO2Mc2/0j0gk3nevKq/+0/QpH7p6JBylouWezLHtDePEaijWtGXot9GE9EBvc2W+XtubsnFVtpZD/bcyQDVUHfhcB+d5f1URw/NTsoTdn+qIeFQK4A5lnu/UhNXfmZ7J8v7LvPY1nq+uZRVwQyYobAhsA7/U6fnaRld1ULJBFpUZ2HOvkMIUZKRcK4511hWeo2oMjLe3v95i28kIw4UqHYzIzE2GjRgqd8Q2D/zZtx6Wyt/91pH1o55yuddMVywUn/hUDEken+qyDjix/Qntq00nKBBEXUVTC984Bz2qbXL+jXTEw2IBX/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=HpzQ/1D3pXF/rnoLVq6iaJ8EoN9Xu4STrIJ9+NwrVe6LdwVj/2ZceqN0mZQe/ILjdb+42oi09nn8CMUztQjZ/q5ChPN4WUE2bdD70VHFuru2JKA8G0UKpyxuF3yvhXv6uJ+C32KyVERNpOogpuPFGP0u7vR8IjYD0HwKdYY9YZdA9e/K6R5UtyjGoc/bgZS6kbey7n3erWhgXnid6EG2fyl8b9Zxye80ihOHcWaT7RVQHtWj8e7C6gbTllXcWYD8UFMblABlY3qH0t7u+ht7L4j2eplpJ+mu1NHzB9/8u0vhuuuB5501e68ebIbDjBZg7+brdfWmZGCdrUX/nE2Bsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=R0WhnrRTbEeCEixfqRUyZw5F8fOxLJNUR1Sf0p58x4rm5KE3WxOma25fiTxpIVstK2QhQQSTTViHmFiJu9K75LzVLTEJnaV5ygBvR4nQCtqjnLe7Y4ZJL0nMKzfNbQWmoOqyhhskMsewVBlTyaP5SMOU36KJ2YL0l7JE5ntHkD4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6212.namprd04.prod.outlook.com (2603:10b6:408:58::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 16:10:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%5]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 16:10:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 1/8] btrfs: make search_csum_tree return 0 if we get
 -EFBIG
Thread-Topic: [PATCH 1/8] btrfs: make search_csum_tree return 0 if we get
 -EFBIG
Thread-Index: AQHYHs/dFwFgOSsu9UiXFNm3svGVGw==
Date:   Tue, 15 Feb 2022 16:10:07 +0000
Message-ID: <PH0PR04MB7416D2FF3B0EE9AD4898B8949B349@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1644532798.git.josef@toxicpanda.com>
 <772083c44ddbae8edb2d52ce2292f8a2dfc08ccb.1644532798.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33e3b263-84cb-4ceb-b2b3-08d9f09da28e
x-ms-traffictypediagnostic: BN8PR04MB6212:EE_
x-microsoft-antispam-prvs: <BN8PR04MB62125F7C700727E92AE02AC69B349@BN8PR04MB6212.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S2rvxJHW/dH4vTck6MDpVMttv45Ze7HAXRB77oZ5j0GGUpN/g6Ab/BBuk6gkQMhxv2VQ41PXVR1f/51ktLaAhN8r3cSwRNAcD7DXiW8reSL4GUqc4/kh9SHpAdfFO9iDhgmLXEoQqdqafa496rMGEAZv+OPOsDzAEXsL0eba+d2BGv2/FjkjU608g/6y2+kWXt7L00I1D/wqUdw4MF/qbRVxniHY7ZOSnpgxYc6YNkNQzKjsL8cKXTVH7NtVn6ZuHv7riBPmsIBxLlFf15zN3LtpOz6f7ovrLpvwYugF6RQwRo+Z/T8Si9KUEYfF24h3nOjyxjw5IxC+a7MqO2KuSKLCU1fTgTl1vD/Glkd2eDXXEcF84dyokk8nsI7YcYOd4bRXwrw27te4n5PLguQw+AKVFvVqjfGtzDQsMI/IdcH9PAg0z9ln6uANakR6GRClvNzum+v8ubauVm3+9dcefva3OfFPv2riVkcxbWGulr9Ii1nEH9lEu0fnhwk6fRWXRYzFZEloA0emFYbxAkz2MLkSrZmn6L+7OaFynb0LMberrrmt9xj3Rk//4ZSODvX9tRXyxiY7q+uVMO59BW4STDNyA4xadN0rYTIkF5iYmc+Ao6K95WURvgGaAHHAGSpE+lKcXZ4PwoGmcdtXMS1UiCrazdwkkeJWnvUJ83TU4lCVs7D7M/HtdLA7mmmjROzNWSN620ri0rXMOU1caLNFgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(19618925003)(64756008)(8936002)(38070700005)(8676002)(86362001)(66556008)(66476007)(66446008)(82960400001)(2906002)(7696005)(76116006)(66946007)(122000001)(558084003)(4270600006)(508600001)(55016003)(26005)(6506007)(9686003)(186003)(33656002)(71200400001)(38100700002)(91956017)(110136005)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i0ICHlkhcuty88dv0bXEZBsjDPUrcQclKjAfiuEeGp6agEvKwIIjnx5BG1HM?=
 =?us-ascii?Q?msvuYoEVp0J4zT6Au+R5bj+qF+/wFb4LGCuIeTd5h8j3vKNscWvSLvgXNHc9?=
 =?us-ascii?Q?9pNS5D+HurczNe5uQMjiX2pmME7MRFL3ojwYkKrywkZCrteiYUn7bErD9FW7?=
 =?us-ascii?Q?UTBBq89T1x61hvHCk7zp5ivOXsGVj+O/G66iWD+DyoBwofhmGcah+Iuz0ibm?=
 =?us-ascii?Q?0jlrQJB2izdRPMis31JZwlosEFgOwUzg/RWFF3dpWTL3K3B34Fe3cwoZj1ca?=
 =?us-ascii?Q?spolFfsjhPzT6M11wiwmIBCqeieIML3BVk9hSKDamIeKEZM4zG2D2yB6VcTp?=
 =?us-ascii?Q?7qHzbmmi3XQSGQtcVSXp6hMvjZjbDE3aeQUFlLqlAbgQhsDGJ+1Sp+FsvkLp?=
 =?us-ascii?Q?oqqIKRRzdISTJJlkiWwbS47SkdKfih24adJdfs9XmhPxsFSA4Pa/kZw/sCh0?=
 =?us-ascii?Q?KjuXI7WFe+IE62QPnaB8yALNxVI7hNceiWCzYdIQjVG0N7Ps7jwbMqS1Em0n?=
 =?us-ascii?Q?Uo+Dql1cazjhs+O+v88rw8OZ1RDWXJrjH+LG5cMjyCEcpogjy7hqvNMbnT8p?=
 =?us-ascii?Q?ta2qsUMtNgu88GXE6O69ZU8i43yQG6d9cim2W8fO5cXMpjdgCNXixyIq+X2Y?=
 =?us-ascii?Q?ZfyurToy4wx8qHx+0LiC2YL6FsoXsmP7Uv4+1n3xJ1dkMlRSOXDFjoaf4H8P?=
 =?us-ascii?Q?/XDXBuDfETPt5o6yY7+Pnu0pZgjZcRUuYG3D3uPwtuMJ+cAIFsj4atEB/SMt?=
 =?us-ascii?Q?OK0GWE6PlcQ/k3pM9iunz01/DhDH6+nsCHlJDzT2EeHHJLzv0uJMWFVlc0+v?=
 =?us-ascii?Q?xFsms4/AulvprRUmF5Xt7LR4QLeflMoyPMj850l/5QmJ3j3qo2VBubtjl5Ft?=
 =?us-ascii?Q?XgaTaEA1ktvk8OlOsvCoJ+uYYTXpkySXyC3FfhB4eSQHUCcN9SAWUgwxO9qr?=
 =?us-ascii?Q?nvJ5V+8Ztvw1Fex9XGtGL5CH95pvWkXN72LVbzZ7J8eRgTz5djtNnGOccWyk?=
 =?us-ascii?Q?SkzyEb19wvSt7pmwp2bTre4S6tT8TZFcGh2rQWkjTrJIJF8sOrwYOeVk6nwh?=
 =?us-ascii?Q?PXxzcqbT8Dn2WtAg35J6DZCtjIUfgf6mNVu0fZWlO/dSINJzC5cjZowjMvhH?=
 =?us-ascii?Q?7LfN+uTTKhStpgpejQYqPfrL4oFjxz6n5bJ9xzl5T41Lohn8paNbFB7MdrdM?=
 =?us-ascii?Q?uMRMvxdPPNnzi10fcpsB+zxO9IUtLR6YKDzm+R6C0tHnTx6U0zVUaVwHe8bM?=
 =?us-ascii?Q?7N39NddtfoonoZ1uZvqDsCtq2Jc8xn/R9BedmArMJcytnOMZdg72O05E+qdv?=
 =?us-ascii?Q?F4ykpUMxuWQ2oL4Z6yPo35Er17SACTbPN6veUt5WEuojSFoQj5YjhFqTBw30?=
 =?us-ascii?Q?fselYtqqgNqy/9zpmURV6a7Uv1O6t1lFYkMNNb/iDuo2Kmy2wA+IH6xoanvF?=
 =?us-ascii?Q?Jnm28a5GTXRo/uWErbWDxVRwQAcs00Zdx/OatT7ljTvSvXtjVz3xakvSZex0?=
 =?us-ascii?Q?RoI4XnHacOgzRYiiLUUS2UvcVeFtMNQTUi0BKDanfd2HHvKSvnjryHJ0k4Zo?=
 =?us-ascii?Q?SWasFo2qk6mgof3ICBDbg8/8+QDaxKLMb15MAirZEc4kKLGV0WV1AnIP54VT?=
 =?us-ascii?Q?ckm+cju8qbDt5h0cOi0fXGOVuir2GGUdo30Q2vCo70sdQukd9+X1UWxozTjC?=
 =?us-ascii?Q?nkF75VbeWSBKwWukVQSOOixWNKU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e3b263-84cb-4ceb-b2b3-08d9f09da28e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 16:10:07.6113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6A6ON+vKifrdbse0aO1f0yBeEje/I5WJ0hmnYQqs2R/IMGtLmBoHLaRgWX1G23fGKF1HqRCmQGVhhyiP4A2f198BATZU/4lpemmPgXSlUAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6212
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
