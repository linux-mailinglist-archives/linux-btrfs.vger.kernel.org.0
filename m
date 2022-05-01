Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A4D5167BD
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 May 2022 22:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343516AbiEAU2X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 May 2022 16:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239469AbiEAU2W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 May 2022 16:28:22 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCE33EF36
        for <linux-btrfs@vger.kernel.org>; Sun,  1 May 2022 13:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651436696; x=1682972696;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=KQ2XOQKmKNTb4x/h/lg5fHl0HVyAlJi/riTvZjDRkde+iklrF4uQLXm/
   JdBMWCbQkCSFSMLqLGbJC59OfZWb0pBbnMjxpT3QEctf0zvWzLceUHIbm
   jn6VJig5aEMM0CXo1x2me9fiDPMUbfoP4kSBR8DmSmz/UDnLtAEBHEbD4
   SlneFwivGHFxuzEBZURQ/o9GCFc2LnQMsTwK5jD2XD9AgPj2nKD/gjZo4
   RAMzquVhtHXKdGfD5dIEAo+Tih3HUcsoKX8ygm17fyNu2+hJUJvEBRRNh
   qMtoHMrduwob5fAOaRqosXWLMrtxb33+W204Btm09T6eB7JO8hBo82YnF
   g==;
X-IronPort-AV: E=Sophos;i="5.91,190,1647273600"; 
   d="scan'208";a="198125135"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2022 04:24:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWYqTAtRx7XLwzQYvRwCmWeku0/8yeo2Q3YbGVIqLHERt1HAtk90MEI2fOWNLiLM+eJngYdpxCPyvc68zx7TW9sl/f3dCtBGh7xLKvCw/b7DBYyraxquvtqZZQLN+tSo9fMeu6RbYx5m6PK6DoB1G4OBINMGHUEZSaBUcNfZO17nodXUWBRIyp6J3EkCsZqdbQ4AXD5VFAi2wpBhTUie1Jd9G6Tm93WnCUQn2Yk7z+JcgmMbwX62KI8Tn0ne9giYjKW0/Qk4195uhCucbmh6104P2Gok8YpA8gjk87hPR0wQvLLxE5sJFL1eQgdqnY5dmb0P79fAAF6loETQxeAlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=JYA136HvhFVXZILWTRlpGWDSMLsyvFVd3X/uOnd6nkKCTEdDpUUjjHDgXU/csc7brsEWpDcWsfpUtsTBTDWfgfckE8uKZggFvqpph78bVmgJublYG84UZJmvW9v5f0Pz39Rd6VUJIiTpf8aN0wqff6vaj/qYEj+OZaRLtEbxmbaNHCVtEydNbFCgNYDFw3RZQugJVqpK5j7Kj8P3Ov2GSTze2TMeqo6g3aEHvFEIPZ/CdOgoWi9CC76UBdnVEZfUg3/zc1SoZMX5BmVuv/ZQQBGEJDVN8jENMZgcUqO7DYdS8ni95T6S3+yLczAF6jBOQJS0ySMn4AQmzgiw9WEcuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ykfXexbgN0bvsxujzraLomZDseh2DXYr4pyDywST5GW/h2aiC4piDie9MoZuyBITEuusAIDRzpa4kbyOL++6DUTkpfcvl72w5ibpw3nYGSJfYgJRi6gedn/WHK5WBuxys+L7ZTBoLha9W2o/9IYibehIzpb8vhA1UW2ylLCJQBI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6689.namprd04.prod.outlook.com (2603:10b6:a03:228::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Sun, 1 May
 2022 20:24:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5206.024; Sun, 1 May 2022
 20:24:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/9] btrfs: remove btrfs_delayed_extent_op::is_data
Thread-Topic: [PATCH 2/9] btrfs: remove btrfs_delayed_extent_op::is_data
Thread-Index: AQHYW/do2mze3jtZQEKurjzg74pq3Q==
Date:   Sun, 1 May 2022 20:24:54 +0000
Message-ID: <PH0PR04MB74168E5942F0B4D3B6A8468A9BFE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1651255990.git.dsterba@suse.com>
 <a6dec14ab56c4a831664d4864d63782679c0e5bf.1651255990.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f90199c-a96d-4b19-0d9d-08da2bb0a722
x-ms-traffictypediagnostic: BY5PR04MB6689:EE_
x-microsoft-antispam-prvs: <BY5PR04MB6689D0230170EAC7FA8C877F9BFE9@BY5PR04MB6689.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NL/Trmq/C9sCUHbUSUVgjeB83j+zFvWiQ/GIYfud6eWd6t525bRUCbjYIIDDKbHzROV75ZhgoIvd0U+C/FZ7gu3BId+2JQscKckk01teFS7shhqUMhmmHO5zgNUPkLLRFlwccr5NSO/8FYTPsr8dIY2hc34ZLmi9o01OJ6aJzcVbkvqoqzxtAJ2g8hNyIrOKz5w91SUtTWQT85i/OOJFRd6IIbD3xTnhrpkWrEouASurT7mwKqufq2LN5yu5nzlr4xLPXR8rfrj4mdwH4sm0myTPvs/cFyfALR4/BbffkVHSDa8Y19Uj3xZwPIiaTtS8/Bse2PwTaiqaVqEVgZGJp7FerEZNwzI7UIBea3+NzII/NLFKc+E3RerEuOitPKIxVAJlj6uHt7JIR9bY+BXiAz9P4Rxoolo/a4dACRx/+9lRssEjLLLCnb7Ahq4Zg/ni5yArp374SeIeHJwQm2HmKlROZtQegSdL3mC86GyHq3TuwmOLi65jQ4gk1wTOA79WqD7PqnHv1MsmoqxCLvkB8R4ODOvTIIAHLc8L0pkpsIosD7J9oVlI3x1x0rq4Cg7PyuXLeJNoNrIKBV1MaUemA0WyDIndI5J8795WBA0pjAGgLiJ47o7zMMhNBcZLinEB8QrDCt9GVdzXuOfkfd9NSxxl4vbQxUVtMt9btizcKcPm9Huq3nWxT5CLUHlIq7YBFFeaQsA37mkg6Zk9wrDJMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(26005)(110136005)(38100700002)(52536014)(38070700005)(2906002)(6506007)(122000001)(82960400001)(86362001)(4270600006)(71200400001)(186003)(9686003)(508600001)(7696005)(19618925003)(558084003)(55016003)(5660300002)(8676002)(91956017)(76116006)(8936002)(33656002)(64756008)(66476007)(66446008)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V2uEMirCeFHbdOY3Utb5mcAVtRfmVHPTbE1wXLkzy6uIO8lEoLe4mwRucnyB?=
 =?us-ascii?Q?nQ2RVwDjlCSFLsEGTuucUueBOuaZivtQpplqin94HxDwAxuQ3pXhk4ixT83X?=
 =?us-ascii?Q?XMMrO9uJUHa+lraMWVcrYnTscx12HDobyOxu+rBbou1KqtCnvbq8auJabYoo?=
 =?us-ascii?Q?8Y7PuBiTPK46Z/JL8mBtCSUEpjKwZyNTumqWskr8ig5ib3j7PZ4giERPF/pj?=
 =?us-ascii?Q?RymWfQHhEKvRYmlizdne6pYCcqQvpT/Ndd34gE98uDYrMvi1TlKQm4gFSquL?=
 =?us-ascii?Q?7/xOVhhn7yfKIqYMdAKLgyCp3Gr/6wBXeu91gqLfmAtr1/uRQMcJ8oVAmT+o?=
 =?us-ascii?Q?MCGzlSLe6zixxW7PDQHsa8vLOUjOynFqgFnh7N9Q7DhFL2eEQoGJBjiR5Wgl?=
 =?us-ascii?Q?XQStvyr4JhYeat0yggr/G49OuRCWdwHiZU/o7qkNqNozCcVDIqWowUj7gcuC?=
 =?us-ascii?Q?tfB6xU34VvIw7/eSmX/VMR9RbZ+Xgkc69L2Z5tacWWpq3oe8tKczUHpGmVAz?=
 =?us-ascii?Q?nmJ6KF2ML/mA29k485UCU5Yt41i/0YH1KX3NDU9RGqad0LQZSRzilyiDHEbe?=
 =?us-ascii?Q?TAloP5FeYpGlKBJDpKxvjsaEWYqQM7hxjwLi7A2SKDXD+0PnrF8Il/Y6DScc?=
 =?us-ascii?Q?0UrKPz5q/zwYt+J476GkFreyurt0SslmH0YtHxrY9gcn+LKBFUkmqQKJyWdl?=
 =?us-ascii?Q?FaFRMoecL6XBfh/2Fb0ZXZkUtgOczO03KDkfwQdC9y8WMk4vsD2/+YhRMFR3?=
 =?us-ascii?Q?rxfIKpzis8RpxJVZNCLqE03c2jU016+BKCxwdGktUT23g6E80LCn5C9w3+ev?=
 =?us-ascii?Q?FROW0o9lB4h+6qoYKLgCCTQlGL/A5sD63JfQ4fZODbMmJTYVdnSEVoAEk0pn?=
 =?us-ascii?Q?2/sXN+nc6jszl81KugQ4oYSeqqXrFcTNg+EEbWp0xbxWH54P0SRPfantGYvG?=
 =?us-ascii?Q?TJZdYrW0qDYjJt/wGut/WRN07cvgs9bs+pnkxX4BdtGYkIiuwWYNMH0PIrlU?=
 =?us-ascii?Q?Nz+PCsUhwCor34UyfDFb2pvNOkCHYn1A6prM/yITRWkUGN4ytnp2A5FURH/j?=
 =?us-ascii?Q?kgZ1kKU3yo5fQQkl72BetashQjGB8ia1b8qZ2NFQaVIN3hDuY2tHPlWTsoOx?=
 =?us-ascii?Q?S3Sn/Oz7oGNh0/mUjhiLQNHKzAbuv4zW87kBejqNQUkbnfmN4Sv2kfAc6qct?=
 =?us-ascii?Q?9Bah4IB8aaJbhw5ibW+GBz9tM7LKyFKYcu36NvMECh7jvXSDzYozhLrAQMPR?=
 =?us-ascii?Q?kIZQa2mCdNCaAl0pmMSJOS0f3wv2pIxOlEt+TCfaCviFkSJT6j8bKsPMD3PP?=
 =?us-ascii?Q?mTXFjJBCGILJzOeOaVfedPK75wkfGLIvFCvLXRNiWnkfzb8O4eTbscRUASSs?=
 =?us-ascii?Q?jH/U/egdIP2ZY2GkcdJ5ii8aRDxwsNySHqnKPiNcdAhRBvHEqwsNgXTOkDec?=
 =?us-ascii?Q?AFBDzheUeXY71pF414pqhLIeT6xFt5Air3VhZryjDhtSBaPTNeyYERfRTKUy?=
 =?us-ascii?Q?RwAdOl0tGgVJ+9PJmaumRCm1alVN+9E6+Tx9LUHpCRPmEV/sv2A1RPhbvWe9?=
 =?us-ascii?Q?k35A+X2dxLT8YzeUItL9dqmBQDGqxRIIcSlxBQWhl8LRpdnC8zrge5n9FwI4?=
 =?us-ascii?Q?ICEPwnuBuNOLpxVNurBNokKy/mFsU7sq7dTCrfstfCqaefGWj8tvB6QvE8ot?=
 =?us-ascii?Q?k+Ayh4l/ILELb3Az8qVGR8wJTk4AbYLwWYrhzvOt387hMNfNKd4srpdwN8XT?=
 =?us-ascii?Q?CqvrUREwMG+ftXd+sGP92SDUw9L+Vuk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f90199c-a96d-4b19-0d9d-08da2bb0a722
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2022 20:24:54.4143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dFj46LpBvb+i6G216klW4g8+fZY9SB07TpXp/F2/4XeSv8/la99p7EJk3juLy1BRGJtUFxwYXWjSs5K0mcVzyYlAZVh7Wu732EzjjDcWkGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6689
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,TVD_SPACE_RATIO,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
