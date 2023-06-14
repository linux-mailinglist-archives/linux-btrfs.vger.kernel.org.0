Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB84272F26F
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 04:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242089AbjFNCFy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 22:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242056AbjFNCFx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 22:05:53 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940351985
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 19:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686708352; x=1718244352;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=nLGaqyG7qQdh2JapboSDbcQJXrXG0XmB65meMwzfk7g=;
  b=lpgLst05jC+0ID/7gXsb/c6wC0ouoaCa/gaCzi0oF+D8y60NgF/6B4C7
   0la+scUSn4bC2eh2gbED9hiTygPr+49zjQOMrRwSV2YOIkKj3PfN314fE
   nKCJTOgQzpGb1gS2lnPWfBXiecYQVqCl76/eLZxqRzB98LEDMqWDLPQ3u
   c6tyqEfkCsqGQ4e0wmTrApAhqoaPEb+JYaX4OC9WpxCwmzDwt74+CudWC
   AEMQkwniJaMy4j1Z+/7qBO0z5P4pwlVAoaYVUW+QPnk5NhjPsoeKbfmPG
   M2DUZApHtV4oFskyhjRQJN/iJCEZccnUhMuY2QKhPGc+Zh2Wa3EjdXOvg
   w==;
X-IronPort-AV: E=Sophos;i="6.00,241,1681142400"; 
   d="scan'208";a="235632214"
Received: from mail-dm3nam02lp2047.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2023 10:05:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMHJCqhx9AJ0cISaj2V2XZGER702VOEhVPb4raTiBJIOLy70zYHtI//EcNFJO3VatKeW1TzV5Z18hnq4AsJS1Art9hy2o9vAxxm/ZKCqZbt7HGuFxMBzmCP3vfVfSYcJQ7mThgq2JbhB23cS474N/13Bqht7Etk9yxrNs5zzBLY1yb3g1TDQg0DRpDvMHY0HxQGDOXpdXqu3hkIYNnLyll+BILIlFavbBg9pD+iwSt2HbbZWY1eGGsp1TKVzLkyhAln3CtwyYfU+AT/8gsJbXFKRVSP9TJLkwy/W9uFatw4hNdV/nYXVctjLwyYPwia7J17dEeEvdsdAQEG5re8PIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUUtzNshl9nTNHwyF5qo1MeBTmMSQFwYY3xZdoufybY=;
 b=EgllWLSrBzuf/CBdFl/wKr3ye1+5hA7piNV3siEtyTygtz4HSswL9k2XL1bBJB6qPb2aYw7CN+IhuCgGpOpu4vJ9kd/DRj6nOHBEFS0FfIt2CFNxwN4XNOerGjtVt8XPCX7lAge0jPAWfO6hxeQ6eGpm4D2q5p0dVC50zYsjoVxCS+Q6ZbfLDF2DGnyvkKquTwKcQEtT5ke9IJsb4gN1p6zQUGWNPmDKL7vQIvQ8nWyuutajtoETuOiW3k//V/jJ3jeCzr0a8anDuFiBqL+di+rJnCF8fVyZjSWB/66M1HsgGJFWEx6eke3kk/SD6CRw1dbjmNO9AfZeL3xeRHJscg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUUtzNshl9nTNHwyF5qo1MeBTmMSQFwYY3xZdoufybY=;
 b=RS2gDnDCjoUgYdDAhN9Fc+CL7nEVeYkopnZ7fLdexjJNCHs1KnfJLlXBxn4FhIrfjfHSgYhmCpGdQEckVlplKNTAsvAT9q4/oNHzLhThKJZK3Ba4H/fycOUT5t69THi3Zub7KGb8tpeKfL0P9XvPbE8QKniUFo0Cz0OjcxiNKyc=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB7129.namprd04.prod.outlook.com (2603:10b6:5:24b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 02:05:49 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::e9d9:ae8:fb59:5f01]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::e9d9:ae8:fb59:5f01%4]) with mapi id 15.20.6477.028; Wed, 14 Jun 2023
 02:05:48 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: do not limit delalloc size to
 fs_info->max_extent_size
Thread-Topic: [PATCH] btrfs: zoned: do not limit delalloc size to
 fs_info->max_extent_size
Thread-Index: AQHZnUAc/ChoELfa0EizJWklxAILA6+JjveA
Date:   Wed, 14 Jun 2023 02:05:48 +0000
Message-ID: <2ctiwte5bw2mbb3z66tg4lidzrd6qrgcjhewvklc7kq5eqdy65@kwvnoh6ekae4>
References: <a2f4a2162fdc3457830fa997c70ffa7c231759ad.1686582572.git.naohiro.aota@wdc.com>
In-Reply-To: <a2f4a2162fdc3457830fa997c70ffa7c231759ad.1686582572.git.naohiro.aota@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM6PR04MB7129:EE_
x-ms-office365-filtering-correlation-id: 97529cc7-d931-4b53-c7b4-08db6c7bdf7a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CY6SIIlOFiJyrSvQAIybtiOXVMjdoDL3iBw9TZ/BKU6edYaG+KXMHZUEqdPjeFDbE200jsIUerGbJazOMjelM2qGjMVhgUTghVkoGMgk0Y2X/VXYn/Ci57RI5Y21otEoZrO6i/k8LurPGYmQLekpKjBho99C1DcRg9WNEEEy4a57GmLcZQrJe/itKKkcQPLVIYbsMHJbG/7zckOPLPABLk6vkFgf4G8BoNgg2fpWV0yle8f8Qbe3UgABkIDh2Xi9KoMSU6cIY2vfuXm9FE5x5P0w5HsTvi9EaBbSYgJhax/YKN5bavGcQF4kksngNp42URYeOAWLXECDKRb3VS2GdwmA2ODyqfBTQsm+ciTljULNP+I07j/ukcsSbBFQFePs2H14Xw9j7Hu8YnFXmc+q+as29fx8guZNunPKT4OcAx06e07uzoufeY7il03kUA+c3nlL7eaPYRw73JQjCewSLu9iT0ePKbEVhm+4oiCF712h9zloFa0st1o2mE0Cors/WuiqB0hc+RYj63MWwfngtVr+UcR3IISs7ETXaQLpYi247mANALEYt1GGhnh/3mSZa2h6WydrBUzzcYdKU0D+/8gi+70jfb9bi5KJ/CdN1HwjZxdMcds9F34laQKkZrNB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199021)(6486002)(83380400001)(38100700002)(38070700005)(86362001)(82960400001)(122000001)(6512007)(33716001)(6506007)(9686003)(26005)(186003)(2906002)(478600001)(6916009)(66476007)(316002)(66556008)(66446008)(91956017)(64756008)(76116006)(41300700001)(5660300002)(71200400001)(8936002)(8676002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?moIpJb3bhg6IGukTndum75nHSC2Gow7q1VBWuhTQ4hwmz5mkMNHuz+bPYqgn?=
 =?us-ascii?Q?gxCPZsI2WCLjz6zWOJcqE3J2yBtKms+cYT+PJumdzEsm/jvrN00gA8AjzR4p?=
 =?us-ascii?Q?8BeKIAEwEBOGUXLnIUCfQjxWHGHY6asIN9DlqpkdSmCsxcd5xatUsi7C23Oj?=
 =?us-ascii?Q?3SKJl/SC8/hdR2xXBCtwS8qoFKB+L1dL3zxC7nVETYIm0jYO4h7Aon7spFaK?=
 =?us-ascii?Q?MQ8O+sbBgb+NzoQIixDL5ahBwZQUL25C2DFaoAZcVnQxpM/V7epXA5CEpnPP?=
 =?us-ascii?Q?MRRdPBJSVQy0wmdNpmOBNcAMMYdp2+r+SyvjEOhg+er6IpifrUrSdNmjjo2J?=
 =?us-ascii?Q?mSy4OzljXlcULIWp9t7jLtQsG99/Jto5trI3YzAN3q8BK7x6aELJroNnMnWc?=
 =?us-ascii?Q?vYcJj0dcYg3cvqBEExYW/Ta0TVKwiTX+xtDWTgSz7TP4HvB4yqdPYGh3O8XK?=
 =?us-ascii?Q?xIBg2PP3mbVNHQwE1Pl0Xs3PYKHt2IuoAu24XGEL69czcaoAA93FTjsf4tF3?=
 =?us-ascii?Q?eTrWo0n3bCGPwV2R9xwy6a14OiVXq7BL0RNoKDryRPyqs4aPu9Pc0wV+mune?=
 =?us-ascii?Q?Qos2pqe8hwZ5yxfV5Z6hT/qJKjub/9+l2zE2M+PliAgbpmjIZITeERi3B2Hp?=
 =?us-ascii?Q?87nEWl4YyhVdgRZmjVB1Gkt4KJLJ2Q1erQFT0aphUWfVMDWh+ufHCEA+Z/pM?=
 =?us-ascii?Q?bDCihoI/5NvFT9zkjruUGNYU/DP8Jp2aD3SW8rk0CBUW9PRVlIeoc07mKn2S?=
 =?us-ascii?Q?QS2vDtA0Qu7642yQ509SrdV4HBIsx9mlozuUK32FbS/YD4S1S2z6t/yAWvgB?=
 =?us-ascii?Q?COelG3T1JyhnsWrCbDIgOUlHo/zNpb5xe1eLQGPmvvDJLIu7V1vSBU0MiFCe?=
 =?us-ascii?Q?xSFJlEfMPhndSV7A3CvMcMCOblqVOV1+mc8833IKReCJIuMJr7S36eQ8FwUR?=
 =?us-ascii?Q?bnippJoEqA9IedG7M+Bib7qKkI5LF3ORBoQghU+SeLHIsPk3TBR2lksKjkZR?=
 =?us-ascii?Q?B+Bqff3hZkKiqyaZmnB+vPSF6MBHWx3mwuj8yK+Nv4f3lF3xx0iL/Rn9sVrF?=
 =?us-ascii?Q?Rwc7DfWyl7coldoE5Tqz6G7ScgwP9XQggTFHG73734K+16EUHduQtaEm5AL7?=
 =?us-ascii?Q?FJ9UryG7eE2jL/u8mRrozhr0cdJ2Tmi5GwzEpSkeRvEWByGf580j2Xj8n1UQ?=
 =?us-ascii?Q?tX3s+u68isJS+8oEr+K9/0Ua9ozaCWSUL1Y6GHuZaBl9BWvGyOmXliP60g5N?=
 =?us-ascii?Q?qoxN+UgOLqVFE8NG26TNBBtYkp3nt02dpVT/XkFicoNnAVZKvO5XaaL/YBqw?=
 =?us-ascii?Q?/21eBSJQ3QQfWR/FxQ2vFjVo9ZrJzQp7E4qoIrGT2Ljx54JhC2QZpuCBd+FM?=
 =?us-ascii?Q?ldA3NxkapwIOTgSCpLAxkH0uH7x5jkwP62/8XQu3Uyr+ZAwheRu0oiwKO+Fh?=
 =?us-ascii?Q?XCU2IV+HFfu5cPhVfbv7HmyfOCGKgUpOkf0NwsQI17/QUcOg5ZmCoMK++5LT?=
 =?us-ascii?Q?W/pXlKxbxLj16f0F4dMlWQyBe2o5WM1R0LK07wzxQcEDvOYF72FIobOxStFv?=
 =?us-ascii?Q?r8qRHxG6P6h3ooDRsetiqa0Y+a6F/NwbptowzG+il7m2BF4Mf6hqhXpg/P0x?=
 =?us-ascii?Q?1Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1B2BDA6545F65441BBB0CD6B9FE49310@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LzgfQDFWj/8Keizcmw2xU+GSWCQyOqdQp98ehtAKMceRUS5Y5zv1NIdhHaRLBmBdlWxEGfive5bt8fyTR7e+walW6DpmfE/1FSGgrIjHs7lCXJJbaYbh9YiTBzsNUJQ7/xPzC5GtVqP2LyP/tohfD6qs+ZfahKY70mpGgFCWDxV/zte2pyJOUwlDe6+i0swhthiariIcLbfQDYaUkPj5TRBv25ro5aMwv2XM6pqsNKy26f9pNYwdS9mMIOSV5N1ArVG29J6RNxchHqxTCSwnUOVjMO3M6CzL7eVALBddfs5o+3rJNbLNxoSYppQRHvagAi8aniWhQ7cefJnF2hS0tK81H0MJX0kDjtjBCC77COLqT0PA7km5wekh68nK1nZfRWCz65T6zq5iupqf4xsZkW18DcgMElofevdIpHJ5hYkzg7fwqikGjXRxS83CSWNkpRnc1VXHogW9xn4h6KS9/zbSqDsdU3N/TSCMbv7ok2wWwrLIvvY+yySB3RoDugxL0Gjq9gDNGAFB+dEy8tD1pfzPisj37qFYDVOwersN2dDAqqShJ+tEW8wZ0L+yNMzMnEi6ZRA1VmINS8HCq9aKObHY7PRszMTgxCEI/tw+dtZw5NBYhFKtVRSUOOuCNDpPQWfHa5xRxemD8ecFAqp9OnRj173vcBEumOuSCZXiVv1MNzOITQ1HGTZ945uIOOnjbTzzQenfoBfwaBxEQzqBuzI8PcyhxqHNdeyV+0EYSAn5PCQEkO9Bg7dKWg3XXKLD64THHFs7uJ+bCg0FfevdLA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97529cc7-d931-4b53-c7b4-08db6c7bdf7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 02:05:48.8697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fk9MlZQUdrbVkR/uctx1+d+0p7GsWEq5VNkf1f4Oq09ZE9oFuP1hHcEB+2bnN0RuAak4jpopFBVwybFLWteP+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7129
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 13, 2023 at 12:10:29AM +0900, Naohiro Aota wrote:
> There is an issue writing out huge buffered data with the compressed moun=
t
> option on zoned mode. For example, when you buffered write 16GB data and
> call "sync" command on "mount -o compress" file-system on a zoned device,
> it takes more than 3 minutes to finish the sync, invoking the hung_task
> timeout.
>=20
> Before the patch:
>=20
>     + xfs_io -f -c 'pwrite -b 8M 0 16G' /mnt/test/foo
>     wrote 17179869184/17179869184 bytes at offset 0
>     16.000 GiB, 2048 ops; 0:00:23.74 (690.013 MiB/sec and 86.2516 ops/sec=
)
>=20
>     real    0m23.770s
>     user    0m0.005s
>     sys     0m23.599s
>     + sync
>=20
>     real    3m55.921s
>     user    0m0.000s
>     sys     0m0.134s
>=20
> After the patch:
>=20
>     + xfs_io -f -c 'pwrite -b 8M 0 16G' /mnt/test/foo
>     wrote 17179869184/17179869184 bytes at offset 0
>     16.000 GiB, 2048 ops; 0:00:28.11 (582.648 MiB/sec and 72.8311 ops/sec=
)
>=20
>     real    0m28.146s
>     user    0m0.004s
>     sys     0m27.951s
>     + sync
>=20
>     real    0m12.310s
>     user    0m0.000s
>     sys     0m0.048s
>=20
> This slow "sync" comes from inefficient async chunk building due to
> needlessly limited delalloc size.
>=20
> find_lock_delalloc_range() looks for pages for the delayed allocation at
> most fs_info->max_extent_size in its size. For the non-compress write cas=
e,
> that range directly corresponds to num_bytes at cow_file_range() (=3D siz=
e of
> allocation). So, limiting the size to the max_extent_size seems no harm a=
s
> we will split the extent even if we can have a larger allocation.
>=20
> However, things are different with the compression case. The
> run_delalloc_compressed() divides the delalloc range into 512 KB sized
> chunks and queues a worker for each chunk. The device of the above test
> case has 672 KB zone_append_max_bytes, which is equal to
> fs_info->max_extent_size. Thus, one run_delalloc_compressed() call can
> build only two chunks at most, which is really smaller than
> BTRFS_MAX_EXTENT_SIZE / 512KB =3D 256, making it inefficient.
>=20
> Also, as 672 KB is not aligned to 512 KB, it is creating ceil(16G / 672K)=
 *
> 2 =3D 49934 async chunks for the above case. OTOH, with BTRFS_MAX_EXTENT_=
SIZE
> delalloced, we will create 32768 chunks, which is 34% reduced.
>=20
> This patch reverts the delalloc size to BTRFS_MAX_EXTENT_SIZE, as it does
> not directly corresponds to the size of one extent. Instead, this patch
> will limit the allocation size at cow_file_range() for the zoned mode.
>=20
> As shown above, with this patch applied, the "sync" time is reduced from
> almost 4 minutes to 12 seconds.
>=20
> Fixes: f7b12a62f008 ("btrfs: replace BTRFS_MAX_EXTENT_SIZE with fs_info->=
max_extent_size")
> CC: stable@vger.kernel.org # 6.1+
> ---
>  fs/btrfs/extent-tree.c |  3 +++
>  fs/btrfs/extent_io.c   | 11 ++++++++---
>  fs/btrfs/inode.c       |  5 ++++-
>  3 files changed, 15 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 911908ea5f6f..e6944c4db18b 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4452,6 +4452,9 @@ int btrfs_reserve_extent(struct btrfs_root *root, u=
64 ram_bytes,
>  	bool for_treelog =3D (root->root_key.objectid =3D=3D BTRFS_TREE_LOG_OBJ=
ECTID);
>  	bool for_data_reloc =3D (btrfs_is_data_reloc_root(root) && is_data);
> =20
> +	if (btrfs_is_zoned(fs_info))
> +		ASSERT(num_bytes <=3D fs_info->max_extent_size);
> +

BTW, this ASSERT is problematic when it is called from the direct IO
context. So, we need to rework this patch anyway. Sorry for a confusion.=
