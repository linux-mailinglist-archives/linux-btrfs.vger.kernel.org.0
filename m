Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A39C6B1BF9
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 08:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCIHIv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 02:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCIHIp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 02:08:45 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5DA64B1E
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Mar 2023 23:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678345720; x=1709881720;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V4g8/LB3tkfvwo0hdnDYti/+QEcU9ODZZbjujDJFJoU=;
  b=RbLsKnNzaKhUUlqkzil+yQMkNOjd0uDotuHdyqvIqRNifikvP5vm5Txa
   kYICtGN+JQQ1O63/2ZKTk+toQ5YDUQ5+gsT5KZkzsHUNXkd+dQRL0OlJn
   VZcBD/1tVVjAkb/vCguOYlVgpaHbf+ULjOjigtmrpWB6JismjhvZXn7w/
   jZ5mDOxqwtOZnlryqLKqkqfQuOfYAwnCO7tcjNp1ksuZxLP0TolNtdEFD
   MpsonhjJxIn49e3NDmGYmc50Th+T3eCEmdNjecgpTzQfb8XUEwIgDLuIJ
   neMvyljIZP/dvL9sinqCrV5uaQqb2JZ3VdVVA1zszmJVcnNcvq+Zi3d4a
   A==;
X-IronPort-AV: E=Sophos;i="5.98,245,1673884800"; 
   d="scan'208";a="224977553"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2023 15:08:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhgvFxIrASc1xXR3bk3yLsHLUNtK7sR24ACa4DDvL7yKBXyFAQMkrkoaDarunLd9gZMhw4MT6K/12x6oi5mwDby2zY0v16ZSeGr2niu/f5pVrJ8z/1zbaOUVBQOAOdYB1arz+RFWYUP0cH3TcA6uY0OUxGdMEZa/oc2vmFt+9abZ/E73KMH6CbXikNc5RO9RjDSCO89qlsIau23dAZ3QGeySoAcQFqShVeso6+Gwx52tV8YEUpLJbvzVTZmxNOjGk+gchhQs1AUBSjtrkJ/a+E89XjdJrUxltUcHFHdnWxIginLOsuZmW5EA39xCO2Mkpo4KfFGyGCVGjz+1hDCbWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4g8/LB3tkfvwo0hdnDYti/+QEcU9ODZZbjujDJFJoU=;
 b=llH0wNpAIoTjLQPkHXQfWqWYZfRJ7YUBRs2ELQ48k6snrf/6tqdokZ+WNSG8LQeJs6AyYC0WL4cpeELs8Rnv/aGTz283c2OMwIHTdSc3tKQ/aULKYnd65I65pgWXW6FUQCpHlqC+GwrlSO0WUhJPd6/prevbP6EypHQPnUm/pw31A0RJuCoPZP7nRkKRosi+NsaJG6VWg9mE9Bb++df/BD6ouOhaHG7hSbzvJEy72JaGsXi/wZTbjwWvCWjZpiou7Y5+t1R+Q+QZhEpithEBZg2Twkgm1UzeuIyo6LPuWSUPrAS/XZsW89IzlATJhdxI0CjanWk/I8wBykySvtRg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4g8/LB3tkfvwo0hdnDYti/+QEcU9ODZZbjujDJFJoU=;
 b=WKTfh38no/5s2B+b5FfoiieNmSGIacn97G8Q4rQA1ItTAkbRUJ4gyD8+Bj+E2R5uk22q4IHuVk/kgz6vSaTnvmEfXWhDCjbdGlwYloOOwc+p7My2invzILsKqCZo2RhbceQtb64P0nrTr2Fj7FnqnuZuZmBRVZdqyKXX+JOB2VY=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BN7PR04MB4257.namprd04.prod.outlook.com (2603:10b6:406:f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 07:08:37 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::2e44:805:e7e7:8544]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::2e44:805:e7e7:8544%7]) with mapi id 15.20.6178.017; Thu, 9 Mar 2023
 07:08:36 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 13/13] btrfs: add raid-stripe-tree to features enabled
 with debug
Thread-Topic: [PATCH v7 13/13] btrfs: add raid-stripe-tree to features enabled
 with debug
Thread-Index: AQHZTOv9LVL2gtC5L0KstAZE2md2MK7yEhYA
Date:   Thu, 9 Mar 2023 07:08:36 +0000
Message-ID: <20230309070836.lf7v5znn4isqwzxk@naota-xeon>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <98922293ba48f88d3a71241ccc8341f5b3f7ca33.1677750131.git.johannes.thumshirn@wdc.com>
In-Reply-To: <98922293ba48f88d3a71241ccc8341f5b3f7ca33.1677750131.git.johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BN7PR04MB4257:EE_
x-ms-office365-filtering-correlation-id: 314a3883-f797-49f8-2a20-08db206d1a55
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o02rvJ3HVRR8XoVmJCFlYbyJ+6nNN6gafwyaMI/2vB0aRdDiqCxtGHsbnzR1aA9c2w8zAW928EYNXEKAPHjapuKoKtvGt+055Vth3cbp2tGdPv7L4dDBSkOS9WU+GDAtxII6/DDYtr0PfY/v7zLstz7t+wA/h5HWLePMaXhmwHpk8AibAStXRJAJuznjYTN3Up6q9eRFH+l7R7Osn4ck8xxP6L+t5EX8p8UvPU+efEn9PhZS10KUkeB/vkz75Ph7MXHUCqj2Oibqcrfdm8NJtjnzOBYYN75mj/fzk4XisDRi3zZWUMGpusiXIl67YxBJn6Uj1F9ZZzrjpwxi7kSOxOL5Y6miOKbMYeAfyQyNJ2deTQ4imfmWWhG1lVyYMmSTp0Yj2P36CK4Xmp813QOIu3BhwUi0BEXABUb5zdaUlTkCfI7KA0KVExKdIDIJ5+aTXNQyqTl5T5ngVCF/9fWf2GFxxEOgW4o5N6GH0MhF7bhcuQ5GgFY59ksXODxJGbA0PrDvQfvdzPrKRuJepL+41kYqI4+u0MdPoI07uFP5N0+sbuh4Tm6XX4kSfotwGHmSNY7x40yB+rp3cw2+3wDUg6IuWM9deRd0rvic7N/yvFIdJr3NFXkKJaHJOQToUgB+H6HdyIjZrizLMOnBAGxxG8g/LwAj1Azf6ZmgEK3To6dqU6Hzfb9GEbaad8c0Rff35dWHuG0cOszgLWFWx9B9LQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199018)(4744005)(8936002)(6862004)(5660300002)(26005)(6512007)(6506007)(1076003)(91956017)(38100700002)(82960400001)(122000001)(186003)(9686003)(33716001)(54906003)(86362001)(316002)(6636002)(41300700001)(66446008)(66946007)(76116006)(4326008)(8676002)(66556008)(66476007)(6486002)(71200400001)(478600001)(38070700005)(2906002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mutjpq6D8+a2fZXzCLbcQPVg7wCjGRUlVKKuv3EP19gBLKEfSHFqlrEjwq+n?=
 =?us-ascii?Q?9LLv4D6GtmI95gH4ZR0hSSIyvdNK44QK8xLN+wmnhGrb+klZ6eyEm1ooVpNM?=
 =?us-ascii?Q?cSQY9cilyCrojbZ5J/MVo4Pk2aEn3Bp57annRe+Gp/Bt7QRPw21+rGXCrxhp?=
 =?us-ascii?Q?esovSV3d4H8TqstPbv2qkYnti6+jPGjS5QoZr8oixkD4psjbRIoKWdVmD+nH?=
 =?us-ascii?Q?l9s0iMbUPNLi6gQRBxfaBWZ/7Tf32PKN771KVLZbnjd+I6SeL1CQWf09l8+N?=
 =?us-ascii?Q?4vLluZAcCSRsZacs9eir2rUAVoLqQC9UV81g/VVHbavR4//5504j2wE+Pl8x?=
 =?us-ascii?Q?CB0y10nwcWT/W4OdZsVvJBMBRhDj7SrmiitpLhKcAJ1M2rSM+Fjpw/sP54FK?=
 =?us-ascii?Q?zeX6kTVmLYv3I5tAPmDM2BEfNwpNo7eyilSFAfH/DHw++Tc+LjaWorm71yAD?=
 =?us-ascii?Q?MO64hw3MhYrZkDjRym/2WeMDmJu+TPeORvodl8lCr77fFEOwmB51nvdVI47x?=
 =?us-ascii?Q?ZXB+3nIkZ3x3auKfry+xDKck61uuEKEqxorZoqhyhL9qKKF+K/BU0wyM/MjH?=
 =?us-ascii?Q?PwK/Tm5+Eg2RarOayPed3Jc5QhytB30RW2F2iLmpjzWTH/YH7olwImP8DeMG?=
 =?us-ascii?Q?hlniCALXbRZA/CdrdTCU16lRQa0oxNqc5tZxYFj223ZUU0aLokQEhdO9xnbe?=
 =?us-ascii?Q?V9GdV4Fclo5l4RRihtB65s8auBEnURb+dP5rCpCQF29slC0tIlB3GNXCvyZq?=
 =?us-ascii?Q?j9TQVpVO3og4cpcrq3UibjDAkioD9VvpxxZC2MrEytRG30m9221W+7dsSF6s?=
 =?us-ascii?Q?Q0++uNj/YQXhpGaf5VU2vw+xhcw4eu7Xh9dvxdkOF8aibKSnBLFuQU9tDE3W?=
 =?us-ascii?Q?s8afrBca1XhjHQJ6SPclPAid/3zvPmF8Ezj52G5yQh4BvlxMun/TfQJiy+Bw?=
 =?us-ascii?Q?bKX7yhO7/bc6Ms7jseTbjJKne+Uq48DNFYXjiE9ZZUHb8/h+k2vKQ0fGiWSH?=
 =?us-ascii?Q?7GJq3ENCmPJp4/Lnz7fuzCqvTrMjJW7aphs12+fgIZChyAIqAZ22md3ArnEv?=
 =?us-ascii?Q?Q5IiqRSVuMhLeqzon3KyRwVlrzzdnIA1auvIH62rjY7NqJygwUD99gWf+NO3?=
 =?us-ascii?Q?VykhGju7jfVcn93YQO3CRhilu8LxjxllkU8WzybnB1ixgq8Qf9ckNwBWOqDy?=
 =?us-ascii?Q?oFh5jxCNXtXmPGrq9Jgexd6w1DkZMC4C6jdMQj8HysIBQnglRjxizu3Iutbg?=
 =?us-ascii?Q?PtRBo3eTlHd/K7pH8v+YVWRbkkiADdMZBMjsKfoyZCcvHCoFG+S377dPrr2T?=
 =?us-ascii?Q?pwYFBTZ7TrDKQOBmSt8DSAr/V/skgsP7kM9T4K+TZw7uZv1L1D32tIZIx3or?=
 =?us-ascii?Q?+rkK6XOT0YcD2JvUrZ4eBSi/cw4MDWHpg1MJTMiA71PI5+OZ/V0MhQLIulL2?=
 =?us-ascii?Q?o/sndiOntFa0FcYXytGMdjoYEzZqytUjOOGRL5PR/V1mamiL/qOV8vsrSjru?=
 =?us-ascii?Q?gKcpFpNqM/1etn7uw3E/kdbBTO32qanTSrwbxShD3bS9O8lJPywozz7BRStK?=
 =?us-ascii?Q?nT22n/iAGLku7sqEQcCx/FVEPSkKXv1gTJQ0DWZaGJI0mgEpNr4c8ueChwip?=
 =?us-ascii?Q?bQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3842051A5B2CF14C9B7103D025C4E197@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rMIS/Ftl7P3l1LzkW3WdOAf24RKuKSYv9/Lq5H9lLXDSkq5AMmPOGhWzop43TB/SbnC7oflbva+S9htVsrhs3frxilgFYbaMTp/6mckxxwAM6IU1rFyQm/1vv0BH1CBJT0VNH7V2kufgLLbLn+8mUSJkFDuPB5owfl4/UBi4RRK+aOtvndmxc8iJACtImztlEWrgiWVMq87/0ilFqjvlHt0sCbzz6fVXvf8bSO7dWJGY+yf/lKFXxcRVHNt49qxLVZ6d5LPxEPieuQ/YIL5FnJ5xnAVmfPYlyhhUNdVoqwWZKY6ocMPKBffYPZqngoPjz79QHUrCGywD8hk/tmZkRfa/55XQeeDCSwmt1BNNEMSblQbHijIrGj6dOuuHpvpYR0oNzEtF8dkWKWEC9uhGAkbP0xmP6SiZDkzZUN2dsP0CX5J9pIY6KuwzjWRUK/2c/6Ho/uOjqgNC5us04sfgINd7bIxG6X5mym3j1wTDJg5ZpxrRihyz3bzX7mABZWOrJB2r75txQR/UEzHO+f13Q47ahzPsz5PIoM28RAjr5JMLARzhdHZwWOXtlMYjvuZfYBDuYMTJNgV+S0BcvAAEZ54RaDg9wlWe9BusojzcrZnmg2Kg2ECIaZhq1aTaBYH5S/66p2B6o5eF7w9hHzdptZimYk+LqFke2G7AHlgWQgP+mvEmIDl3/qqpBirnCvckOc3fqfyn5gU19IfIZ1hLIVwrcw2+JCsYfpHytiwXAwUQGg9wQ5YGuzyLFVf7vU6z8G7OBNyT6NCFkTKER8dDQ+TsCkMcKKHEnDNum2crTiibX2BVyr83IvKtEDt1NaNixxD/+eehZu6CWQR9HZv3rlOGOySKyFdqCOIqV4vUyQw=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314a3883-f797-49f8-2a20-08db206d1a55
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 07:08:36.7746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 39j8FZcpbfnGjMCUuhuGNITibTSOR30WSSBvW4XpCrhh76Xm3HIXzy4aqmwb06QULpwKncTreH0X4BfsKC3P+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4257
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 02, 2023 at 01:45:35AM -0800, Johannes Thumshirn wrote:
> Until the RAID stripe tree code is well enough tested and feature
> complete, "hide" it behind CONFIG_BTRFS_DEBUG so only people who
> want to use it are actually using it.
>=20
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=
