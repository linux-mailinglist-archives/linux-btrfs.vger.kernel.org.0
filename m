Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DEA4EA381
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 01:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiC1XGR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 19:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiC1XGN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 19:06:13 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF5E641A
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 16:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648508670; x=1680044670;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=fSay8a0e7lnlfkO21nlXPOEv87VwUlAJu7SImynaB5c=;
  b=IdAk5Lb+HExTfmVH4kkjd/ZjsVY8YHxs0NPvUcSSR95+LIz4/x873jzt
   4Y0j4RqNg6c2hhksMM326UUydaMzQg25f4vAMm9kq5Ld+VaMzyMiAYa9n
   W64cefxHeyMz80YuoPHdFwEFEN2lS5icWIi/SM17Arx0r4lsZMN74Iit2
   Ng+kMbYGxhY1jP9V7R0njni0OIZTTcYJhohvAqfxN0HN6U05+QD57tuQr
   d/btVrC+BAydPd2hVmBGImvTNg9xlEt9p3Cv3kq8johzdmEwkIUNKn6R2
   Nq47ZBfs6oO0eMTFERt6NdRw/kvSYt1JaoprbGW5+2VIiXQROuTuWpU+G
   w==;
X-IronPort-AV: E=Sophos;i="5.90,218,1643644800"; 
   d="scan'208";a="195373254"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2022 07:04:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USMUk7wsGM2d+X4MlvRuWrszCrG1++3Xab4sj+kvVRtp0u+DpL9Y7XdLGVfEifJdWh5XQaKgqE8Za4I4NdgDadBBjdDjEzdokIPb4YgLoyhfuWs0fMksiHTLS++33r7dwaMBjVt/F3B2dhEya9dpVzl6ybOx8aVNVWJwNrDFgdepPl9932rnx8fkdO3l1LCdJPDDeFbJcUMpoNRgvb5fHhDC92T70NnicMidYYEsgayKSxOUjd5crZcx8IO1D8KpXGxJH8XCbHEbioom7vx+1Yiy83pmJ2Il4YhAVpwKAs/6RlBrx41SLGJXSvjYj+vB0CFw7429OfG/GOtctTh+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rTxCunhrNVXVQjzSMGkh8a08XTHAkij+tcs84IuOEg=;
 b=M0hczoiBMqChlDq9MpgToPDlz1+bLf0HVb5ZB1UkoipEb0tQ3eHEmxcc+sgGVWywxoPLLhUunGQdP6D3BXdecpj9ULrMgg5FBgbEw7OSiocAlQCrthi4lLTTIZ1FbNFFrvXd+ATgEYAybXuyjNfiqqmoIDJhpVjXIYiKc0YY9q40GSYdbFXkIE4sOZjQPoN6N/DptzrExvYuDu55puLWjQvgdzn+dTjW0Binf9KYkyqQr0W1kevIAHQIT17Fvw1arYRuI0qkla9zxVrMMgFbhfpBlyNFHH3fPzuEyFkz5KfovDdiNngCdyVQ7rYSlzGgnu1i9QwFbaVXDl+Kl9GADA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rTxCunhrNVXVQjzSMGkh8a08XTHAkij+tcs84IuOEg=;
 b=QC/so0IOwn+sflSoHi4iGOJf8caAAS9bz5l1Ed7x6e4bgNW5Hhxd6YsKxVWWNUYC2x53ATszvaV2zzI9JzrTlp4O1oBMiLspeAf0UaU9iukTbWwXfDWjpPsIKzIE5Ljc5XKqAubputQRdXUX4xCkk5iHSTanAiLuZkge3hHp72c=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM5PR04MB3769.namprd04.prod.outlook.com (2603:10b6:3:fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 23:04:26 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f%5]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 23:04:26 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: fix and document the zoned device choice in
 alloc_new_bio
Thread-Topic: [PATCH 2/2] btrfs: fix and document the zoned device choice in
 alloc_new_bio
Thread-Index: AQHYP5+Jnhg0j6SKXU29xkjU4dpmuazVMFcAgABAwQA=
Date:   Mon, 28 Mar 2022 23:04:26 +0000
Message-ID: <20220328230426.n3aanogu7at7hnsj@naota-xeon>
References: <20220324165210.1586851-1-hch@lst.de>
 <20220324165210.1586851-3-hch@lst.de>
 <PH0PR04MB7416CF5DB1670FF12D823D779B1A9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220328191240.GT2237@twin.jikos.cz>
In-Reply-To: <20220328191240.GT2237@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06fdc737-4f05-428d-963e-08da110f4e89
x-ms-traffictypediagnostic: DM5PR04MB3769:EE_
x-microsoft-antispam-prvs: <DM5PR04MB3769B11CAB5A058BAA111B118C1D9@DM5PR04MB3769.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: axolxxgYyrTdPngW9MXVD7oBNh1VZUvxMrHgM36Y0muozwFWu3IyY4xxNf3mm0blzse6CH7X2FB8p9YILmraxaWNgyTKW8OVh4iDDPNDrKQf4TzpY7izFu0ZJG30V/YOqmHds1S33XIIibuxfrj6efjgehI0cAziymUhyrSC9H5TRsD+5a00u9WO3nmwVFEPLhbUaF8H0vxFS+Z3zFZXb8Hki0ZRxy0vDUMmq0297UlF/HB4KZMscYtatmIskPfynIsBWqQMNnZj7ikSpmlpq4x77YbZsobnYwPww3WNuG5LtGieQtVQatxp9U95z3DjEWXQM5AhsU+9h1CeW/P7QsImHOvb0MScd2E1ak9PiEEp47QwgWZrSR2tDn+HIs9MBXATvTv5JsvH9d80dUkzGPSH6luPmTwUnTBg6qjVz5PzlYgH/X+32U40aW+n5gD9m8/qV7K43uCZAam7UzTctpRng9Q0wlzr4KG/UPg/1/OOS8soNddy/4nwg10+WR9fDTaDwtaNvPPx2k78M7HOMG9ztLu1gWV7MKeH0sghYDNJL9ULUdu6Elyd1nexZTAF51hCtqxiJD+Y7Z+lUaIYDlUlNWSsF6EJgrv5Pr7i22MxLXqu1DJ87p/V8PWmkHAMpmjZ20jmQK2FjRTtaZ+SbUMwG88wBR1ffiOna3TWLAA7RAErvTM9rKPpEjTDjGECoTWZS/Gxa/M2NmUz2RZ+/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(82960400001)(186003)(122000001)(26005)(83380400001)(38100700002)(1076003)(38070700005)(5660300002)(66946007)(66476007)(66446008)(71200400001)(86362001)(33716001)(6512007)(91956017)(6486002)(8676002)(53546011)(6506007)(9686003)(76116006)(64756008)(66556008)(8936002)(110136005)(316002)(2906002)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GtmJGPnihseJ3OUMChSBWuvnJvHmiJBmWgBNJ4vm5xWGMFtSUHCPqoSC9eYG?=
 =?us-ascii?Q?IbczL2vmIwoWJ00DegFzJq7PtdleQpvKyR+jAkekHp/PRn0inoiiWBfllojc?=
 =?us-ascii?Q?DV4JWl2vS/oGSd82bhRJnuhR+OGgjUyEAwTL5J9z3XsjGwM6l4HGJLKp9clA?=
 =?us-ascii?Q?teYHi7I7P88eDjfsL/NdcRNEsvf5dFUhVmCdXvSKlGj2KMXJPjKr33eXPhtS?=
 =?us-ascii?Q?ATGbN1Wk1DTTmETeUltaUlesi5UTxYQRtCsdxBw/VjZbRC3fdq9znJYkYnYy?=
 =?us-ascii?Q?pZtQwCdEl1dhp5IkrBmqzt5ungv6MFa3tLryUseCOZlFwQB71gal7u7U6385?=
 =?us-ascii?Q?MbPLDo8YW0rMQZNh769UI99K4zvCbdlDm0VKj1k4XxYBCVrjWfyNs6VK8Xdw?=
 =?us-ascii?Q?dC+oYqGEFxo5q2tjaQe9MLdQQ4ftkqi3sHEr2p2z95vGLLYOAYBOg6eUQNzC?=
 =?us-ascii?Q?kCV3YLSc+VYG9VapGon7W2jvZwL8paToWZgA7iJvsfxNgqtOQMMFEMO/mJY3?=
 =?us-ascii?Q?wrE5GbnsWUET8j56e5FyGKDaHiAu7/hM24c4QS37CA2aeHGjSLq/W3cKSID1?=
 =?us-ascii?Q?ezqx1gIIN+QEJWITPlwr9nb3Kw5cQxU3S1jMF+nuPku6zS0EnGNO1qTzVmmT?=
 =?us-ascii?Q?B9iUUVCNMaDfP9ZH3kqllM+XCp+o4NJuqQxvleQSMh39jCIJWXAyMAQ942Jt?=
 =?us-ascii?Q?coOnDlklgOAMcjRpAYhI4yuhonHp000oz+VevVsDsPQo+n5781I4DYgthLuX?=
 =?us-ascii?Q?UzzSLf6165JuDRlCvBDUvxuKxAsgfh1JSOCsj77hMUz+9Sj5dh+U6IslB0kh?=
 =?us-ascii?Q?xxw40eehEawm81cnMR1a6aaYvU4h3c7OyOQFqHJkyibNG4pa56LfjBW7LzmK?=
 =?us-ascii?Q?OYZhxzyEIC2xFLsU7QGqTYTLFhi4BpnoSJoAmBNtmGiEgHsUDWbtTL5LzOxB?=
 =?us-ascii?Q?VWGG/s0QuhpKk64mvKImRmOVBjSIlpYbJTNUZ9xS+fnC3+BKDQUUDI3LJAws?=
 =?us-ascii?Q?IrjXfs7ELr4q1FZWeEo9bmC/mWlb5TDTe51MR8puiZY1T97EaDKEPEKMDQMW?=
 =?us-ascii?Q?a1WoSFIdgoZ2imJEFGCJIviLcJ3Frfb+UucTUpGO0p24f9sQezQ4Gijm8fZE?=
 =?us-ascii?Q?LWVNyRPUdhjQxr+NacyGAH8wV06dlHDSMdfp1PQBlQQTcETC4JWHHRiHCGth?=
 =?us-ascii?Q?nPAzmdXt5ND7wBYtjN+DpvFHfUIjYUtuIm1P8CBGaD3W7pvkqOtjSFUmp6Uu?=
 =?us-ascii?Q?k10En+o2kJ1kztKcqYMvXN6que25o8zHNxaEhaxNWyPJKtv2IIZP78OoZUS6?=
 =?us-ascii?Q?0Lj2y8UHNo7eer5l4fd+1drLYuDjTbUjjvE/Io1yAIatiW2A3MFUnAh6ALI8?=
 =?us-ascii?Q?bwkYBUremKCcOH4KOMTckGYKufjnqYimL0eJMRjdryywIy3z1OFUFZyiICzV?=
 =?us-ascii?Q?s55S6U5/wmU6idUurP6w+Z2IZ39LMPuFWr3VMVbczIY13Zf7gH+4HI12jzXa?=
 =?us-ascii?Q?EjI+M/Jso7KmGJ0AFonbi1M2CmotfYtRtVIfxyzLaWDjr795VTuqob1xFrb6?=
 =?us-ascii?Q?eMRCtAKkKjpT+9kwGYvBONDPQop3crBLpad17OrchgEcT/U3Npeig14B3EXD?=
 =?us-ascii?Q?4kCwyKyf5eieQDNKXgZy7ma8980KPIv3d2jdpddMtLMv1n/dJngQspycAZGb?=
 =?us-ascii?Q?ZAvx709EuQWqIbBIHANa2XUYC/R9ipPyRMk5ZV1zfgR29NaIXzDVYvH1za7S?=
 =?us-ascii?Q?iHM3zHvTk4s8Onb0WTjr52mhAANf+rM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7C3D72B7FC91E74A8BCBDDEB4F99BF07@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fdc737-4f05-428d-963e-08da110f4e89
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 23:04:26.5387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HcD6Wp3W+KSy+aI3nC5JNsEe/TCHTtS7N0ydOuzO6e5MY3isxt/psXG8ftJEERKjkPGOBTcxwowGkr07z/wYdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB3769
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 28, 2022 at 09:12:40PM +0200, David Sterba wrote:
> On Fri, Mar 25, 2022 at 09:09:56AM +0000, Johannes Thumshirn wrote:
> > On 24/03/2022 17:54, Christoph Hellwig wrote:
> > > Zone Append bios only need a valid block device in struct bio, but
> > > not the device in the btrfs_bio.  Use the information from
> > > btrfs_zoned_get_device to set up bi_bdev and fix zoned writes on
> > > multi-device file system with non-homogeneous capabilities and remove
> > > the pointless btrfs_bio.device assignment.
> > >=20
> > > Add big fat comments explaining what is going on here.
> >=20
> > Looks like the old code worked by sheer luck, as we had wbc set and thu=
s
> > always assigned fs_info->fs_devices->latest_dev->bdev to the bio. Which=
=20
> > would obviously not work on a multi device FS.
>=20
> No, it worked fine because the real bio is set just before writing the
> data somewhere deep in the io submit path in submit_stripe_bio().
>=20
> That it has to be set here is because of the cgroup implementation that
> accesses it, see 429aebc0a9a0 ("btrfs: get bdev directly from fs_devices
> in submit_extent_page").
>=20
> Which brings me to the question if Christoph's fix is correct because
> the comment for the wbc + zoned append is assuming something that's not
> true.

While the real bio is setup in submit_stripe_bio(), we need to set the
device destination for bio_add_zone_append_page() called in
btrfs_bio_add_page(). The bio_add_zone_append_page() checks that the
bio length is not exceeding max_zone_append_sectors() of the device,
and checks other hardware restrictions.=
