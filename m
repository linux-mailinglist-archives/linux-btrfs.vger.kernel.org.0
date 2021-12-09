Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7A046E717
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 11:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhLIK4T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 05:56:19 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:7223 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhLIK4T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Dec 2021 05:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639047165; x=1670583165;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=K112xQLcX3rP9x1r6FV1z8Iv3sXzYUce+bCsZdxdI80=;
  b=nP2oHRnCOFuTzYKcb11dOM+c0U3f3AjEVCU3KnNBbgvi0sj/4z1z56Ds
   8LvN7I6TGty41zs47N23i36XBHGghVL+wSsK3fAGZLZIQeRpCnjyEMw90
   a3w8bsZYlQXcs2t0hcsDXuBMM0rlBPa96hupsLEj5DnzMACMibXHjgGrx
   L4TZEe425/e1gQA7vtaflODOXNPJq3sHNdO6mA6PgvG8+HQ/64kXOZp2j
   WPCmjbs6ERUN7qPb7C10CUIpaOjcS/qiotreUXHcGdNSFS2L44oiRKAhW
   gh5bqAuZncq7Ll0eR584YC7f+N2Y1e3SmAyg+ezOnc6el8smdqEZtfNg+
   g==;
X-IronPort-AV: E=Sophos;i="5.88,192,1635177600"; 
   d="scan'208";a="187833979"
Received: from mail-dm3nam07lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 18:52:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEX8yk0L/tdI0ICr5C23RO6UUjQlt3UOlpgFCERCik12UN9cPnnpwm+rmR6kymq5luWz73Gkl2LZ+Wqu5XYpYXxrbnJL8yHyI2ZbMzoQ60XHHbd+ycgUBQ4KQk9bcIX4ZYzVjGacvS/eEEHAYjyHh96mhFni5U9YejjS25cbMTtPz/1ZEniHxN1WbhH0rm3i7Z9eEd2M6TSUzTH1kWaGiY5Gi1/R4GnXuAAsU9kOFGr3HBe14bV4Gf4YRsBm/aH1KKABCfauo5Obi3/dqGpGOnc3ETE3V5x/PVq1U45OVpQKrsGSA6LYCWGct6nAunYkQHFNMFSwAqCP1aEFP+Qh7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVDXWK/TB6tvvdmS6uGBCjbNA7aQk+nCZLQZhQF76vM=;
 b=RgnKi/+ZX0Q6farD3fQ1je+4ksDggAXVk2MUy9Up/lliFZZR0D2CEPfqTLB7hfeJaIZJnDJcKaF0P0vV5XsDGlCx72m4Ec3BZVL6rcWUof3kc+VDja/K0XuYVLdotIi4XUZon1HzefyznQfrLI/k6A/nz63RBOahLHc1hUil/nDeIeZCpfnnHMxag4XJm/f/lohOhBnIn2PWzxV2nj+WQE91aa+MGyxxpjiqVVrLZCIYpyiWZiuU7n0ygPP8QJINxgljBdG3Ff+MBoB4nWSeLV8xwjoNfBAsaeTezgGWwuVTFxSCYN7/GFbgs4ALEfMkUUzNFmkr/cAVe1ge2C/Cxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVDXWK/TB6tvvdmS6uGBCjbNA7aQk+nCZLQZhQF76vM=;
 b=Q8pyJI3Oi4s1essHc2kgE4LSc1BNkimRVvO/tVZQYTUiKqZpvxMsQzvJPHctza57mdPVoxOwP+MdQzN5fu0WMCn7LsVvJ48XzJODYyjiLnpQ2flb1KpCDKy+QH6MIBm1ZS9aJwo4GvLc3GxIsjZ2HO20iG42fF+F9w6sTTTecYM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7717.namprd04.prod.outlook.com (2603:10b6:510:4d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.24; Thu, 9 Dec
 2021 10:52:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c%3]) with mapi id 15.20.4778.012; Thu, 9 Dec 2021
 10:52:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 00/17] btrfs: split bio at btrfs_map_bio() time
Thread-Topic: [PATCH v2 00/17] btrfs: split bio at btrfs_map_bio() time
Thread-Index: AQHX6kkvn7e4gQGU+UGEWJCojwlgqw==
Date:   Thu, 9 Dec 2021 10:52:44 +0000
Message-ID: <PH0PR04MB7416374BC39FEF504430C1D59B709@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20211206022937.26465-1-wqu@suse.com>
 <PH0PR04MB74160D826D891E5E543603769B709@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8f2508c-c7ce-4a61-7f9b-08d9bb0207c5
x-ms-traffictypediagnostic: PH0PR04MB7717:EE_
x-microsoft-antispam-prvs: <PH0PR04MB77177EA88DEF5EA2E50E5BA69B709@PH0PR04MB7717.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:27;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j/imVYN/KKzizc4ea/JAFgXsFhE5kv3pDXSRTAXMaH/nIj3C3T2pip93GvpA9ne2v7lDP+D+DHJu1wUtQ+w1lkYONGf1yurmLvZuc1tiaESWbmXND7qbDsY/lEXXRDuQJGm7h92QDXK7y5ESqXX7sKR46jUYKudSiq1vfhYSAjUFN6G9b8xe0VZUiF5vvS6GGREargZV5mklnmjJ+nlQEJ2n8VtcL/8OX1pgYODrQzZ6nADce85S3ier+Lefh9WkwVkFstaOjg1NQa5jkfKGaF9+eRSu13GJfCSjB9LSEkavfuW06cei5NmtMskgPJfEUfcz1HEQRlPQwV2VE8XqxarXDveBE/3tag2pq3Yq/A5e+tL+8k0atvS5ciqQPqTGcXfKhPJ0meUAXnktcMPthn2P/Kk8kQVokfZJrBHdsKIAbb4Zg5MbDoYKvNND98VkdicoRjtrZcCDbK/F+xcXXO0+zP3bD5JASX3DCwCGjX43hSJN4tOn1JjIG6erHBcd4fnvg8Pbcjs36LG2OaeFP/fpzrwsx0j0bs3lemGtmw2aoGKVCDZxgsjmExgbSVKzQezkQOO2op6gOIfCKNIpQk7iwApqX6Cg1NYwXqM2SatzOP24lFIJ5FqdsNV7/Fym1RDx6XIf3cOzDii+exXUdEKUGC5Jg9hVxxmk7XgwXgWRqjo8FshYnXcTkht5wmlJhaRh91cZ+RGfAjc6ts3KzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(83380400001)(2906002)(6506007)(82960400001)(508600001)(53546011)(8936002)(91956017)(122000001)(86362001)(38100700002)(76116006)(5660300002)(66946007)(64756008)(186003)(316002)(66476007)(45080400002)(110136005)(66556008)(38070700005)(55016003)(33656002)(8676002)(9686003)(7696005)(52536014)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pDpVA12ApY00Yz1VZfMgIdpNj/AccuXLE5rxk6RzJKxpb6QVMRS4d3GKrKuF?=
 =?us-ascii?Q?RX+FMlnhIDaQWmRxizlT0nta4vHlM/xjRlCQA1MUlRGBUL5Opk0xJFe/L6H4?=
 =?us-ascii?Q?RgQ6w4BOZG6XH9TrUOY4Km39GFG2vRQ5wRgxhFyI5ZzQY7D9ukMDHIxBhhLH?=
 =?us-ascii?Q?nJhnsTkJ9IYcZn042fEph1WhOFK6QZUOhKuEM4Ou28y3IfXBakyeazA6orOC?=
 =?us-ascii?Q?DVihxwo1/7cdEoaswO/Rc42xXFV0DN7c6OLe4SrS5Q+e8n9h9c59HSSQK12R?=
 =?us-ascii?Q?Q/LEffBS+PQOjoINL49nyKPwUSJjNgoec+3muvbtTcrDClEFmk5BPB/H4dBH?=
 =?us-ascii?Q?tYOC2499ZMbzrSjRY7wPqSH9GnCpKHV231UkP4KAAO4tb9zkatcZEvUxHTH2?=
 =?us-ascii?Q?RnGLJb52tkW5kcDYfQmxvkbtcl8ehF8DSMdHVHcmTH4XvdoL9jcP1ovRwHJ4?=
 =?us-ascii?Q?g36pJXksMuFsMDjMtIaHORJd3asZLOZmzUFB2EuusDc6lUTc+SRleXXpXCZh?=
 =?us-ascii?Q?ZLpbWdJ+9/2a2dlOkxy2qTKER7ehIQsrKJiuWrlZ77R1KykFRXlYK0lJCGtE?=
 =?us-ascii?Q?+c8msiGFVtInrxGk+GNXYLT29bKEBWTkLu9kwpvRy5SrC5rMmeJORvCqduGM?=
 =?us-ascii?Q?LG7AcPyJrvAnlL/srqd8gnqBUYoeL9ZkKoU/aanw4ovtwXJyTtkHEyf+yFik?=
 =?us-ascii?Q?48RSmgu8ZQUJQjBlK0y4DLWahAGL06YNDnclvVhWAVLOmu9KJNFxrUbRGAEe?=
 =?us-ascii?Q?fJ/q3ABclJcRs3RpPiXmKQYVXjg9WkSAt2Gp2hleTSpdOAzlnR6ejQ1dqQ54?=
 =?us-ascii?Q?3dSi31RbzIsFk3bMvyOfMa0fARejYTJRVXO8rmXN2aXKdKF8UW6Vq00fTBzw?=
 =?us-ascii?Q?oluTEwlDfQSe7eWqy10/m4Ws0fK5bj+BMZeSeQlQSAZgJPlh8FLuYHSJzmlR?=
 =?us-ascii?Q?7lx8rZ9aV1I6iyZMzUpMea/OjLmlaf4pkqlczSynEyEjlHWkCWD8XCozxkxO?=
 =?us-ascii?Q?lZ5RIw9pG318wfWhGKsce63U5OAMQ7QuepbJqtLKYuGNGYdGLuQpxE6HtXXZ?=
 =?us-ascii?Q?GEMtA70ZI6M7ZWW00DlUDc8OfJvu99AgkqP07m/BtrGhRClRTEuXsZtNJjyU?=
 =?us-ascii?Q?ArWHwWAqNYSQOhMNOUL1KRQ+gvxW6afecuvjj/VK1oPDoSvnglMPFYTOE9Ed?=
 =?us-ascii?Q?+GiGWO4PcoNvKfrDymLeUWDrVd8ZwpYxAM20YellOWmdvth+ZhZAE/13PzQm?=
 =?us-ascii?Q?tFD7sSUcI2hLOcxrQ2gw8XtGNc28T5bcrrBvPj3rCHPfS9YKOkp51+zE2ybk?=
 =?us-ascii?Q?u+3CQWXwwhzb08kNaKHdqRPd6nGYfdcN6WmsIFT5ySvi5B1TSafADIsxm6p0?=
 =?us-ascii?Q?TfEHdCjEd1SlXtR2/BIh+mR2N++o80XmR8wFqPvFDKI7G5GW/dnZTeOL2zaz?=
 =?us-ascii?Q?An2IAEu1iLV7waSkDFRBl8rU3BmbY6hSoor7RLWEDCBsFQTcasYlN4eQLzTg?=
 =?us-ascii?Q?5ryxtZKM9mrBFxAHq5rjCkStQK5c9XRjpgyuvYgVeMx84c1uEUDvSxd5sw2b?=
 =?us-ascii?Q?gILC0PmZvdZ05fW3ctFqyd8tSuU2jF1EdGbEX3qNk3j5mSg4IgSy9cT6TnSL?=
 =?us-ascii?Q?qX03CWn5qN4dYr6mvU4WkKa9vmML9lm4vmQvVqhZTvf6Vrighls7DrBUoRNe?=
 =?us-ascii?Q?DnJwOoHVZS8E948V4OOsbi/wVz6/M5/cTcd+lYsbimQ60CU6Djx2OeD6OWpO?=
 =?us-ascii?Q?M8YEIZ7SIpeSdYjyTwjTphEWhOX5Am4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f2508c-c7ce-4a61-7f9b-08d9bb0207c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 10:52:44.3213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OZ7G98SvTXRJVPKI3vuxNlIWP3g1D2LYpivpLvtaS3yKbfyF68NwXDv4jdHgq73Zc2OXPYrXvhWbick878l+Z0C7c+Rj3pTfwXmyK0t6pO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7717
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09/12/2021 11:07, Johannes Thumshirn wrote:=0A=
> =0A=
> =0A=
> FYI the patchset doesn't apply cleanly to misc-next anymore. I've=0A=
> pulled your branch form github and queued it for testing on zoned=0A=
> devices.=0A=
> =0A=
> I'll report any findings.=0A=
> =0A=
=0A=
Unfortunately I do have something to report:=0A=
=0A=
generic/068     [ 2020.934379] BTRFS critical (device nullb1): corrupt leaf=
: root=3D5 block=3D4339220480 slot=3D64 ino=3D2431 file_offset=3D962560, in=
valid disk_bytenr for file extent, have 5100404224, should be aligned to 40=
96=0A=
[ 2020.938165] BTRFS: error (device nullb1) in btrfs_commit_transaction:231=
0: errno=3D-5 IO failure (Error while writing out transaction)=0A=
[ 2020.938688] BTRFS: error (device nullb1) in btrfs_finish_ordered_io:3110=
: errno=3D-5 IO failure=0A=
[ 2020.939982] BTRFS: error (device nullb1) in cleanup_transaction:1913: er=
rno=3D-5 IO failure                                          =0A=
[ 2020.941938] kernel BUG at fs/btrfs/ctree.h:3516!                        =
                =0A=
[ 2020.942344] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI                 =
                                                                           =
                                =0A=
[ 2020.942802] CPU: 1 PID: 26201 Comm: fstest Tainted: G        W         5=
.16.0-rc3-qu-bio-split #30=0A=
[ 2020.943043] BTRFS warning (device nullb1): csum hole found for disk byte=
nr range [5092880384, 5092884480)                          =0A=
[ 2020.943576] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.14.0-4.fc34 04/01/2014=0A=
[ 2020.944424] BTRFS warning (device nullb1): csum hole found for disk byte=
nr range [5092884480, 5092888576)=0A=
[ 2020.945191] RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]          =
                                                                           =
                                =0A=
[ 2020.946076] BTRFS warning (device nullb1): csum hole found for disk byte=
nr range [5092888576, 5092892672)                          =0A=
[ 2020.945833] Code: e8 ea 1a a0 48 c7 c7 20 eb 1a a0 e8 1b a7 43 e1 0f 0b =
89 f1 48 c7 c2 9c 9a 1a a0 48 89 fe 48 c7 c7 48 eb 1a a0 e8 01 a7 43 e1 <0f=
> 0b be 57 00 00 00 48 c7 c7 70 eb 1a a0 e8 d5 ff ff ff be 73 00=0A=
[ 2020.947374] BTRFS warning (device nullb1): csum hole found for disk byte=
nr range [5092892672, 5092896768)=0A=
[ 2020.945833] RSP: 0018:ffffc90004c8b890 EFLAGS: 00010296                 =
                                                                           =
                                =0A=
[ 2020.949774] BTRFS warning (device nullb1): csum hole found for disk byte=
nr range [5092896768, 5092900864)=0A=
[ 2020.945833] RAX: 0000000000000071 RBX: 0000000000001000 RCX: 00000000000=
00000                                                                      =
                                =0A=
[ 2020.945833] RDX: 0000000000000001 RSI: 00000000ffffffea RDI: 00000000fff=
fffff                                                                      =
                                =0A=
[ 2020.945833] RBP: ffff888139612700 R08: ffffffff81ca4a40 R09: 00000000fff=
fff74                                                                      =
                                =0A=
[ 2020.945833] R10: ffffffff81c35760 R11: ffffffff81c35760 R12: 00000001300=
3fe00                                                                      =
                                =0A=
[ 2020.945833] R13: 0000000000000001 R14: ffff888101a8c000 R15: 00000000000=
00004                                                                      =
                                =0A=
[ 2020.945833] FS:  00007f04d5acf740(0000) GS:ffff888627d00000(0000) knlGS:=
0000000000000000                                                           =
                                =0A=
[ 2020.945833] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033           =
                                                                           =
                                =0A=
[ 2020.945833] CR2: 0000000000d7e008 CR3: 00000001bb7f0000 CR4: 00000000000=
006a0                                                                      =
                                =0A=
[ 2020.945833] Call Trace:=0A=
[ 2020.945833]  <TASK>=0A=
[ 2020.945833]  btrfs_lookup_bio_sums.cold+0x3f/0x61 [btrfs]=0A=
[ 2020.951120]  ? kmem_cache_alloc+0x100/0x1d0=0A=
[ 2020.951120]  ? mempool_alloc+0x4d/0x150=0A=
[ 2020.951120]  btrfs_submit_data_bio+0xeb/0x200 [btrfs]=0A=
[ 2020.951120]  ? bio_alloc_bioset+0x228/0x300=0A=
[ 2020.951120]  submit_one_bio+0x60/0x90 [btrfs]=0A=
[ 2020.951120]  submit_extent_page+0x175/0x460 [btrfs]=0A=
[ 2020.951120]  btrfs_do_readpage+0x263/0x800 [btrfs]=0A=
[ 2020.951120]  ? btrfs_repair_one_sector+0x450/0x450 [btrfs]=0A=
[ 2020.951120]  extent_readahead+0x296/0x380 [btrfs]=0A=
[ 2020.951120]  ? __mod_node_page_state+0x77/0xb0=0A=
[ 2020.951120]  ? __filemap_add_folio+0x115/0x190=0A=
[ 2020.951120]  read_pages+0x57/0x1a0=0A=
[ 2020.951120]  page_cache_ra_unbounded+0x15c/0x1e0=0A=
[ 2020.951120]  filemap_get_pages+0xcf/0x640=0A=
[ 2020.951120]  ? terminate_walk+0x5c/0xf0=0A=
[ 2020.951120]  filemap_read+0xb9/0x2a0=0A=
[ 2020.951120]  ? arch_stack_walk+0x77/0xb0=0A=
[ 2020.951120]  ? do_filp_open+0x9a/0x120=0A=
[ 2020.951120]  new_sync_read+0x103/0x170=0A=
[ 2020.951120]  ? 0xffffffff81000000=0A=
[ 2020.951120]  vfs_read+0x121/0x1a0=0A=
[ 2020.951120]  __x64_sys_pread64+0x69/0xa0=0A=
[ 2020.951120]  do_syscall_64+0x43/0x90=0A=
[ 2020.951120]  entry_SYSCALL_64_after_hwframe+0x44/0xae=0A=
[ 2020.951120] RIP: 0033:0x7f04d5cce1aa=0A=
[ 2020.951120] Code: d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00 00 f3 0f =
1e fa 49 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 11 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 5e c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24=0A=
[ 2020.951120] RSP: 002b:00007fff31411768 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000011=0A=
[ 2020.951120] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f04d5c=
ce1aa=0A=
[ 2020.951120] RDX: 0000000000000400 RSI: 0000000000fab2b0 RDI: 00000000000=
00003=0A=
[ 2020.951120] RBP: 0000000000fab2b0 R08: 0000000000000000 R09: 00007fff314=
11507=0A=
[ 2020.951120] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00400=0A=
[ 2020.951120] R13: 0000000000000000 R14: 0000000000000400 R15: 0000000000f=
ab6c0=0A=
[ 2020.951120]  </TASK>=0A=
[ 2020.951120] Modules linked in: dm_flakey loop btrfs blake2b_generic xor =
lzo_compress zlib_deflate raid6_pq zstd_decompress zstd_compress xxhash nul=
l_blk=0A=
[ 2020.972836] ---[ end trace ceb9e45abcff5d95 ]---=0A=
[ 2020.973244] RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]=0A=
[ 2020.973773] Code: e8 ea 1a a0 48 c7 c7 20 eb 1a a0 e8 1b a7 43 e1 0f 0b =
89 f1 48 c7 c2 9c 9a 1a a0 48 89 fe 48 c7 c7 48 eb 1a a0 e8 01 a7 43 e1 <0f=
> 0b be 57 00 00 00 48 c7 c7 70 eb 1a a0 e8 d5 ff ff ff be 73 00=0A=
[ 2020.973854] BTRFS warning (device nullb1): csum failed root 5 ino 2411 o=
ff 770048 csum 0x0203b7e3 expected csum 0x00000000 mirror 1=0A=
[ 2020.975411] RSP: 0018:ffffc90004c8b890 EFLAGS: 00010296=0A=
[ 2020.976383] BTRFS error (device nullb1): bdev /dev/nullb1 errs: wr 1, rd=
 0, flush 0, corrupt 1, gen 0=0A=
[ 2020.976841] RAX: 0000000000000071 RBX: 0000000000001000 RCX: 00000000000=
00000=0A=
[ 2020.977656] BTRFS warning (device nullb1): csum failed root 5 ino 2411 o=
ff 774144 csum 0x0203b7e3 expected csum 0x00000000 mirror 1=0A=
[ 2020.978272] RDX: 0000000000000001 RSI: 00000000ffffffea RDI: 00000000fff=
fffff=0A=
[ 2020.979247] BTRFS error (device nullb1): bdev /dev/nullb1 errs: wr 1, rd=
 0, flush 0, corrupt 2, gen 0=0A=
[ 2020.979853] RBP: ffff888139612700 R08: ffffffff81ca4a40 R09: 00000000fff=
fff74=0A=
[ 2020.980629] BTRFS warning (device nullb1): csum failed root 5 ino 2411 o=
ff 778240 csum 0x0203b7e3 expected csum 0x00000000 mirror 1=0A=
[ 2020.981224] R10: ffffffff81c35760 R11: ffffffff81c35760 R12: 00000001300=
3fe00=0A=
[ 2020.982211] BTRFS error (device nullb1): bdev /dev/nullb1 errs: wr 1, rd=
 0, flush 0, corrupt 3, gen 0=0A=
[ 2020.982835] R13: 0000000000000001 R14: ffff888101a8c000 R15: 00000000000=
00004=0A=
[ 2020.983624] BTRFS warning (device nullb1): csum failed root 5 ino 2411 o=
ff 782336 csum 0x0203b7e3 expected csum 0x00000000 mirror 1=0A=
[ 2020.984226] FS:  00007f04d5acf740(0000) GS:ffff888627d00000(0000) knlGS:=
0000000000000000=0A=
[ 2020.985216] BTRFS error (device nullb1): bdev /dev/nullb1 errs: wr 1, rd=
 0, flush 0, corrupt 4, gen 0=0A=
[ 2020.985915] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
[ 2020.986683] BTRFS warning (device nullb1): csum failed root 5 ino 2411 o=
ff 786432 csum 0x0203b7e3 expected csum 0x00000000 mirror 1=0A=
[ 2020.987157] CR2: 0000000000d7e008 CR3: 00000001bb7f0000 CR4: 00000000000=
006a0=0A=
[ 2020.988150] BTRFS error (device nullb1): bdev /dev/nullb1 errs: wr 1, rd=
 0, flush 0, corrupt 5, gen 0=0A=
[ 2020.989019] BTRFS warning (device nullb1): csum hole found for disk byte=
nr range [5092880384, 5092884480)=0A=
[ 2020.990401] BTRFS warning (device nullb1): csum failed root 5 ino 2411 o=
ff 770048 csum 0x0203b7e3 expected csum 0x00000000 mirror 1=0A=
[ 2020.991403] BTRFS error (device nullb1): bdev /dev/nullb1 errs: wr 1, rd=
 0, flush 0, corrupt 6, gen 0=0A=
[ 2020.992443] BTRFS warning (device nullb1): csum hole found for disk byte=
nr range [5090144256, 5090148352)=0A=
[ 2020.993277] BTRFS warning (device nullb1): csum hole found for disk byte=
nr range [5090148352, 5090152448)=0A=
[ 2020.994148] BTRFS warning (device nullb1): csum hole found for disk byte=
nr range [5090152448, 5090156544)=0A=
[ 2020.994989] BTRFS warning (device nullb1): csum hole found for disk byte=
nr range [5090156544, 5090160640)=0A=
[ 2020.996065] BTRFS warning (device nullb1): csum failed root 5 ino 2427 o=
ff 2179072 csum 0xa9788697 expected csum 0x00000000 mirror 1=0A=
[ 2020.996156] BTRFS warning (device nullb1): csum failed root 5 ino 2427 o=
ff 2183168 csum 0xa9788697 expected csum 0x00000000 mirror 1=0A=
[ 2020.997107] BTRFS error (device nullb1): bdev /dev/nullb1 errs: wr 1, rd=
 0, flush 0, corrupt 7, gen 0=0A=
[ 2020.998140] BTRFS error (device nullb1): bdev /dev/nullb1 errs: wr 1, rd=
 0, flush 0, corrupt 8, gen 0=0A=
[ 2020.999004] BTRFS warning (device nullb1): csum failed root 5 ino 2427 o=
ff 2187264 csum 0xa9788697 expected csum 0x00000000 mirror 1=0A=
[ 2020.999793] BTRFS warning (device nullb1): csum failed root 5 ino 2427 o=
ff 2191360 csum 0xa9788697 expected csum 0x00000000 mirror 1=0A=
[ 2021.000815] BTRFS error (device nullb1): bdev /dev/nullb1 errs: wr 1, rd=
 0, flush 0, corrupt 9, gen 0=0A=
=0A=
Resolving btrfs_lookup_bio_sums.cold+0x3f doesn't make any sense though:=0A=
(gdb) l *btrfs_lookup_bio_sums+0x3f=0A=
0x1767f is in btrfs_lookup_bio_sums (fs/btrfs/file-item.c:372).=0A=
367     blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio =
*bio, u8 *dst)=0A=
368     {=0A=
369             struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);=0A=
370             struct extent_io_tree *io_tree =3D &BTRFS_I(inode)->io_tree=
;=0A=
371             struct btrfs_path *path;=0A=
372             const u32 sectorsize =3D fs_info->sectorsize;=0A=
373             const u32 csum_size =3D fs_info->csum_size;=0A=
374             u32 orig_len =3D bio->bi_iter.bi_size;=0A=
375             u64 orig_disk_bytenr =3D bio->bi_iter.bi_sector << SECTOR_S=
HIFT;=0A=
376             u64 cur_disk_bytenr;=0A=
(gdb)=0A=
