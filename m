Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B1E72D828
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 05:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjFMDfq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 23:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjFMDfo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 23:35:44 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAAD188
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 20:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686627340; x=1718163340;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JSP6QjtgKs43+Jzw1qV9Y2K84yRw0H3/yGre0/44NG8=;
  b=riQaoo4OZJRXel7wMXDLDkCj0vAE9HgArrZqOeSkQyh8ldMtGO+ERHZl
   qTE09bowkf8UcLShNGOn1Q+5XCucfe3AHzrqJeZLasG7dqWnNIa7EkdmC
   LQYU+YYQN/LoOwQ+c9O3QW6j4NDli8k+pcRfWfrr5I5eEtXM7n5whjmCL
   V/+HWb3RirKBtJ0eeRtZzPNxfLSRQTl3BQo8JIK01IBVW+oSvcDPo5bPV
   a8ocmse/vrwVLjiUOJdaDCmCLlFZgEQHjR0tHzjjftkX45Rqr6Ghlcxtz
   rDRwZebaYz1n5S2yzhh42/m8Q2DB+40ZpMfvFOrFZ7Mts+t4grqDZIKnG
   w==;
X-IronPort-AV: E=Sophos;i="6.00,238,1681142400"; 
   d="scan'208";a="233576070"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2023 11:35:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIj8Mlz1mnVHC+XFpJQi1PAAu6XOlceu1N2fdN8GHpkuPfvPq2alL0Q0p2y7JkGXzDd5gHiJFteoZz2UkqZ54Pk7djOs9+M46VwHOziKyybsU0o/em03iFMuuWE88QtiVSo1ZpJuyR8RQgot43vRNGDBi7aX+6Z8TdhUT0ovxIvXq8zeyRAZqhFYpFiA5eTAhM9nwWxTK8jCBuf6v7o4B4ssfzl4N4XR/pA46l8wsXwlsphP+mlkQuefgVeZ+0kaJbMmxBPcbKUuGINyUvFgH0lBmzyjqjS9cMfZ3r/Um3Hupix0RshyDfGVAdAplU9LCn5ch3/pBYaAc/W5x1/ilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPMfNMFD85sNg6dJ63MXmMkxPD2PdouKTlqj2bETp8I=;
 b=gC1/0sgj6pDWeHnQzT55SygXZ8XxG5Y4Xw/dYcy7FABjbFwqXkuqMbPSbh0xsYU4JfYqBoqn7x6EJd8B/wrU+xRs5JxBiwZ0VaBXWV1nUgvi0ukw8E08idp2j7naQ6gN3/8o6e6Jq31QiVeB6XW67/6wFfENUjA87iJlVPVR0pC6LTPRTTnfmrLnarMez66SX+oj69k0XK2nU2Dg/YGJ9m655RUZI0SfP2miubHNDizCj9fCOcm7zE7aHwXY6gqwLJEq1xsQ9QVETywHqE7BUPxt2CClvkUytLSPMziaddf43Se9QcwvN52tzqonP1nIM3BcmLULQDnRR0lh0g78lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPMfNMFD85sNg6dJ63MXmMkxPD2PdouKTlqj2bETp8I=;
 b=pXR2oSO0EWUWttb+pMZDAWv8mVwRMvuZaol6y0VN/nzWwnqcUPC3Qsk/RXEqosvRa4vY/sgr6aWaYJFnE63MQqlFOCRsJ4xlpaJlr1xi3ICvC5xAuqJB4+KT5g0QBl510cVBMk5OeBRAwAJMt/Vv6aQiCJkhDTP5jHMWY1HGGzE=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BN0PR04MB7920.namprd04.prod.outlook.com (2603:10b6:408:153::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 03:35:36 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::e9d9:ae8:fb59:5f01]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::e9d9:ae8:fb59:5f01%4]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 03:35:35 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     David Sterba <dsterba@suse.cz>
CC:     Naohiro Aota <naota@elisp.net>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: do not limit delalloc size to
 fs_info->max_extent_size
Thread-Topic: [PATCH] btrfs: zoned: do not limit delalloc size to
 fs_info->max_extent_size
Thread-Index: AQHZnUAc/ChoELfa0EizJWklxAILA6+HvlaAgABXYgA=
Date:   Tue, 13 Jun 2023 03:35:35 +0000
Message-ID: <6mbxhojhmgfdfwl7vbpmwvsn46xs6gawmyinjdqg4bypelpfla@wilm2nznx7zk>
References: <a2f4a2162fdc3457830fa997c70ffa7c231759ad.1686582572.git.naohiro.aota@wdc.com>
 <20230612222249.GI13486@twin.jikos.cz>
In-Reply-To: <20230612222249.GI13486@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BN0PR04MB7920:EE_
x-ms-office365-filtering-correlation-id: 6539cdf4-c38e-4f05-4f19-08db6bbf3f9e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C4gYKgRi/fdYP5j+fJXNnoQjC1482eFmVpQtFwHZGGhdY/zlZPP4QyopPA8Yu1FKr+KzatRKq5BYsyoCfa4W1/FaSB3qgdpZM1pDioN6dfFTloVOPoGZwX+0yQ/u2uz/H3rMjd1DumdFjYBwVd0snwx829kTYZ7yk8l16ZeXrph2datmxxZoaHBhcycjBlYKmN/XNeAOgWvrigOsQjYb9Ph+55cyojxEiTNilUd3skUn2hNf0ZS0iqPsGAIeGsm+9aHaobBghly8lHe987BD8cMcexzLy24nTBT5KmxBdXAFn4R/9OyoLq/9lifoH5kGUzkVtOZGSEiJ1PDqEdifVL/cfO3tBKRwByG+b0Wbm89DQA+UATBeeIDO7sXc2kcQEcwlrswftAG4hx5F3I0T0GWdk4j+gUjDTDA5C3Uwk9vxzUkPTNE7AMaNEezlCMkI/mHehBILAkSRyd4JMkrtVwHinUz/thbcv15Ntzifc9M4amAUU0Ald7Gb1dEKvyHIDAJimPyKmX4AA8hk23R4YHE2C7K1PYO6+5euu3NfPB2GVnNIO+Q24YxoqPGtxPUvHHBZZPshvu0XtY3Q6l0m+niR23JYyvAlpI7hNhXI4iBHEAt5aUrb6DaiJOBBhM+/fRdvUuR4FVedOYwMsdVNhxDeaQzrdH1Y5wjl0rOS+uk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199021)(66446008)(66556008)(66476007)(6916009)(64756008)(8676002)(8936002)(5660300002)(66946007)(54906003)(91956017)(76116006)(4326008)(71200400001)(478600001)(41300700001)(6486002)(316002)(38100700002)(82960400001)(122000001)(6512007)(6506007)(9686003)(38070700005)(26005)(186003)(83380400001)(86362001)(33716001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GFfIdqu67MXAu0rv1YjFnL3Ms/tpfDGqZVV/nLnjpQYFE8F4AamwsUtGazvU?=
 =?us-ascii?Q?H20oANn0toKcFP2RLUpgin1RShcMVhjM6dB6fOVsXHRYGq62KI4eAvysPagK?=
 =?us-ascii?Q?eEnB3AxmEZV6rFJktaqXHk6eK9VDtLPuwYlKCamAk3DxaCAB8uDZxz+RRbMR?=
 =?us-ascii?Q?MY+HiJHISJl98F0MyLggeRwhEU+9WTODxxMzGhfnTRFFefjKYyHNO02OjIIy?=
 =?us-ascii?Q?08otp7pUf++FAh5ib6hjg6YztVOr6cWlZcXnJLg4irh40/385gfY+q7CTvDl?=
 =?us-ascii?Q?1V+dLL0gMAmVMwMen+kU0R2b+v8eoFR1v/gTDrIB6iV9la4aVihURddIEc9D?=
 =?us-ascii?Q?Nxhe/sxJHbZxZvKqkOIh36tEJklH0b9P84fd81vVc2bDepx+VYbuJTrlyipu?=
 =?us-ascii?Q?EDTD47PswnN8e/8HXLPiZQW21o5Um2VKsGZWHhRdhzkglUaaJKnvDPhisY7f?=
 =?us-ascii?Q?AwnOG903j0d2cNZ6LUpfYrIswaq9FzEYbZnPjp0cL96SwIaoSsarT8odIlaJ?=
 =?us-ascii?Q?n7s5Y7S+OCddPwmpwrwqfH3CBTvQT5xTys1KV4gPSGfe17Sqoc67bKx742Cq?=
 =?us-ascii?Q?l01MAUsGZZRP2ur+LqVGNJBk4uTqK4A9S+Y6foWNaXZ+X450LftC6kfbhVer?=
 =?us-ascii?Q?CvN3ppRqR1aSrcNR5aKhHT3EMm0RRO1vgKW9waM/VFadawLpuz1rjs/kppCQ?=
 =?us-ascii?Q?coTDp7HXlVGGfatbEeEZy8ADqGpCIsBSOl19v8yA8EibmRRQ6GK7/fAcwP2s?=
 =?us-ascii?Q?5puLMtVogMRf8PaywN0Ds88GgeSEMfKuIzoHNjs7FjJ6qXV7dHfcqD02+TkW?=
 =?us-ascii?Q?Bfclj6NUssNFQJQe40p/O5iiCHuOvNVZ+7L4KKGjGLBaqijYSRy/YPjUDDR4?=
 =?us-ascii?Q?0+EiH/sXk1Mlz76/nmejRkGLn95hvYCZzmCjGCaU9mzHRhXZCRUdE25O3hbn?=
 =?us-ascii?Q?BJE9zV+3SsS8v1AaZcormJcCk/3bXfXfhceFcd9UWdzy8WR87R7WAI+bjVnE?=
 =?us-ascii?Q?lOdYKjK3NIqjIYd0obPlYhGhK0qp4vuA1Pb9kUX7oI+8i98Ym2fdpOAgQbDp?=
 =?us-ascii?Q?i9WuO9SyZM8d0xDvGwWnZGl8mYtgzLc8Gq3FiMWuyWfVYpsQKu6Fq1jQhAof?=
 =?us-ascii?Q?LXnEKkM+uFE6UDMoeTcDoa8yP4WZDnuDRsShImVtX074TKqo/JRdtCA16I/u?=
 =?us-ascii?Q?hgFfk/OfnyWFpvdl6A6PW5lPgHTGPWpf+uSVYulq8fKmICtTBc9/Q0Y9Vo3z?=
 =?us-ascii?Q?4nQfMb2Um/E+jC4CY+fgjZCetcLmzRA0rKJBLu/rO5XBg++lusqMpQKn9OvR?=
 =?us-ascii?Q?uKQDZOnPSfA02Oc1bBP+iP8L3VFNpm1+MPvBVwn+vSL97cuBnOnuffFzx5EN?=
 =?us-ascii?Q?hMs705ptnFmm2iXt02ZO0ckfLWzAk9bqKbH9vaaN6Sg5bgl3cnmamFITh4wL?=
 =?us-ascii?Q?My7rW+SgUlyHuRnkQILC2bL5NIxUPg7oPVrI1g5YR2+/va/yKczSx3U44OQz?=
 =?us-ascii?Q?I1ToLJUfXAD4HCJSICtlq9OaCnrjSZB+R8dhB+PMiSSFe6G/aow8XvISsSc3?=
 =?us-ascii?Q?Auzt81GbmIJr7twkI3kwvR9d2CPpJo92YB9awHDwTyr4O7H5u5090xi+LW1g?=
 =?us-ascii?Q?hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <462A0F3AAFF274428EBE4918C23746DC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R6PPb1VjYwxKzNJ6AqczHQKMpfdpZO00LPeX5pau0mjh9coOexMRgivIQwhNT/Dq3ibG1VFuJybCTHNK6m1SC4PRm2Bw45R/8XoPINDUmkjurk4HjRpHi3SmU0kLv1KUW/2jmFnep1aaqyOOVFOk+PDqCK+B3eh8DRj7aV1K6cDf1PYS6KELpo0XRp83K3pi64yNSSA4fTnNTFmEfhW8qBBygXeo4JzeVvFhOMmXDB+gDXt9yDDBUz7N0Q2vUmqhD0SdF/GPYLjoggSrTvaf+3icQB6Gt93SEXaV8pmRFhKYPZB5ouQVg3hckXtUhKR1ccuWGoWpemMHcKj2KXSfP9fQE6DysGYYW2oGQ+HHYMjTexrkbnWQznG4ktMEBcuQjUixCUbtoHt9XzhHLmWHGpzS5Sd1+0aaGxCUYPWalxgdHG0E+wc5ENXxkDILZciEthS4a655sClTjX0i2nrgsrtQt3LUVVClR3hM1Ic0WJNQSW8Il3CSg6sApDamh4tos7u5JI+IX+sMUgK8vovKPLQ8PqQRrQGRPzTNgHJnCufAwYtSyl5B6U9FIDVg3EeWfuZJjd2yMHq/F2XKXFnl4lQWvEYcfQqt1HcCi7J3gj/wRbuKlICaOH2Y36AqsnR+1uDq5nrZlpxiJ3i+Lnkz/vMgI+Z85UpI7jjeE59vP+8MRbFyfyBGoXFN2kJ6q0rxDpHRDsjNGsuWzT64IwPJferp7C2mpCWRvGaFkqlB2RibwDmEmfp7eCR0zxMusDBqJrvGtK69xiG/sXUarvzi8leSwxjYUu8qjM84HpEU8dht3nYPvcjRXrqsGytPK5PmQjJDT6yradzl30PrHITpFA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6539cdf4-c38e-4f05-4f19-08db6bbf3f9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 03:35:35.3199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZkkOdvOkjUccoJ9UbtCd9Q8b0Cwlh2cSlcGmKjKYnbJvBMetdfy5HC5hu247NjUhna7QRk/h9fJ491+7WZtEgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7920
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 13, 2023 at 12:22:49AM +0200, David Sterba wrote:
> On Tue, Jun 13, 2023 at 12:10:29AM +0900, Naohiro Aota wrote:
> > There is an issue writing out huge buffered data with the compressed mo=
unt
> > option on zoned mode. For example, when you buffered write 16GB data an=
d
> > call "sync" command on "mount -o compress" file-system on a zoned devic=
e,
> > it takes more than 3 minutes to finish the sync, invoking the hung_task
> > timeout.
> >=20
> > Before the patch:
> >=20
> >     + xfs_io -f -c 'pwrite -b 8M 0 16G' /mnt/test/foo
> >     wrote 17179869184/17179869184 bytes at offset 0
> >     16.000 GiB, 2048 ops; 0:00:23.74 (690.013 MiB/sec and 86.2516 ops/s=
ec)
> >=20
> >     real    0m23.770s
> >     user    0m0.005s
> >     sys     0m23.599s
> >     + sync
> >=20
> >     real    3m55.921s
> >     user    0m0.000s
> >     sys     0m0.134s
> >=20
> > After the patch:
> >=20
> >     + xfs_io -f -c 'pwrite -b 8M 0 16G' /mnt/test/foo
> >     wrote 17179869184/17179869184 bytes at offset 0
> >     16.000 GiB, 2048 ops; 0:00:28.11 (582.648 MiB/sec and 72.8311 ops/s=
ec)
> >=20
> >     real    0m28.146s
> >     user    0m0.004s
> >     sys     0m27.951s
> >     + sync
> >=20
> >     real    0m12.310s
> >     user    0m0.000s
> >     sys     0m0.048s
> >=20
> > This slow "sync" comes from inefficient async chunk building due to
> > needlessly limited delalloc size.
> >=20
> > find_lock_delalloc_range() looks for pages for the delayed allocation a=
t
> > most fs_info->max_extent_size in its size. For the non-compress write c=
ase,
> > that range directly corresponds to num_bytes at cow_file_range() (=3D s=
ize of
> > allocation). So, limiting the size to the max_extent_size seems no harm=
 as
> > we will split the extent even if we can have a larger allocation.
> >=20
> > However, things are different with the compression case. The
> > run_delalloc_compressed() divides the delalloc range into 512 KB sized
> > chunks and queues a worker for each chunk. The device of the above test
> > case has 672 KB zone_append_max_bytes, which is equal to
> > fs_info->max_extent_size. Thus, one run_delalloc_compressed() call can
> > build only two chunks at most, which is really smaller than
> > BTRFS_MAX_EXTENT_SIZE / 512KB =3D 256, making it inefficient.
> >=20
> > Also, as 672 KB is not aligned to 512 KB, it is creating ceil(16G / 672=
K) *
> > 2 =3D 49934 async chunks for the above case. OTOH, with BTRFS_MAX_EXTEN=
T_SIZE
> > delalloced, we will create 32768 chunks, which is 34% reduced.
> >=20
> > This patch reverts the delalloc size to BTRFS_MAX_EXTENT_SIZE, as it do=
es
> > not directly corresponds to the size of one extent. Instead, this patch
> > will limit the allocation size at cow_file_range() for the zoned mode.
> >=20
> > As shown above, with this patch applied, the "sync" time is reduced fro=
m
> > almost 4 minutes to 12 seconds.
> >=20
> > Fixes: f7b12a62f008 ("btrfs: replace BTRFS_MAX_EXTENT_SIZE with fs_info=
->max_extent_size")
> > CC: stable@vger.kernel.org # 6.1+
>=20
> Missing S-O-B, I've used the one with @wdc.com address. Added to
> misc-next, thanks.

Ah, I forgot it. Thank you.

Just in case:

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=
