Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1660A5B9C7A
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIOOBq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIOOBp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:01:45 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415C39AF9F
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663250503; x=1694786503;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=XXF86qvW2QJhJlvc6K3VZR8gNCz0LhvlSwpTElPrFKv8D54ozMfQL+MJ
   C+el97/JFHv+Jg+33KJeXWceC3Vn3xGFpSdtp4cekrwygY5ebYVqOfvmV
   s4xFjPAeYKNBVDI98iVHHF5fYX4AAuFi8LVrQljPV6odlc5R/eHkS5PxS
   MR79WZSoofwXP1tqZBucZJQWd7TnuZ/A6KuSx+iQs6vQ32Flov44oZucj
   dR5uQRN5I2SjRqNz4Q2S92hVqxrqwdplIVA7VBRW6yQ0EHTz6AQOYAeTQ
   96HzJnkWyxyBbDbxDhl+S1G5cPuOMcfdWpWRJVfitDADTU6eZENDPZV+z
   A==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="209838507"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:01:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZqELiF4p2Xdb6DWGvxoDwWAZJL8P/uZr2nTmbUMWqlxQakqRVURtoaHGhp0jWX5VCXqKiPApSOZ/z2Gdq+QyfZsnvmNUw5No4Ma+WryJooXx0Fwx6o3ePBttc2vP8ClxhCqb1Yppqds/V4ASsH7lX9fCMTp6LJgcy3MRCWJNlXqxFeGsc2/+zuSgb1zAm8ZKHSJDmL1uNh5Ju+rBkh7/936Jy5ikfhxe2bBiDfm13WUmnHYPGVh43rKEot0mhvJxKwIyQXjZx4m2Sdf/eUFMyh1MsgenbPYUs0nwGGwkDLjc+dpCJAZJmMHX9tf1ebUCJwArzdBqwmkzxDQEELTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=CzZ5wLX6QvJV3Wx9Ey7r5cRqiqfsjweHkaMfGXkc2qTv9cbFBJu/KSsJx3nq1UrChKkTM0jgLttoTgkbIO/CQw+AwUcJEGkxllotQXO3zpSyZ8pgBkg3YL5PnkiQDKZh+DjbTi0UoUAbd7GQ/D1hIP3E/G4WnObO6gh6krIWSKWwjBH/Xu9jyXxRtbjXk7+96HDC1mw5I6Z/JJuCEXahwVXSJlPc5cJ+hA39vBd2QS8n+OXMPzxIR9/q8MbI7Yh/0nM7IGyevRAoi3DZhi/+HxDSiEoz0C0Z/Sq1FrdoNKVuJYMyV1Cq4vk1ec8xbxy0wxy6X2r6khmCSs+N0rbc3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Wt6cVBtNCi8//Uw+hCn1xtaXiiFWq6h+MQtEhEezzYwR7vp+9dXoMc3Lo0w5XTSD56pgcqxtz4FPoUqkJGgvhII2Q7Drz04hbwgV0Oq5CvIlgpa8gB6W4LCYxYivBw0rm8AxEZtGd0LNqky1Z9gf6mYiyU1zReywG3vL3kknCJg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB7952.namprd04.prod.outlook.com (2603:10b6:408:157::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 14:01:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:01:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 07/10] btrfs: move btrfs_zoned_data_reloc_*lock to
 extent_io.c
Thread-Topic: [PATCH 07/10] btrfs: move btrfs_zoned_data_reloc_*lock to
 extent_io.c
Thread-Index: AQHYyI7euJ5q+fqD5E6nQa7tzjv6Lw==
Date:   Thu, 15 Sep 2022 14:01:23 +0000
Message-ID: <PH0PR04MB7416E9610B99A1D5EA7029849B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663196746.git.josef@toxicpanda.com>
 <9ff2cb480bba029fb169a15919bf96a87b37a919.1663196746.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB7952:EE_
x-ms-office365-filtering-correlation-id: 39be4b7c-6769-4a1e-32e9-08da9722c5f5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FPinDrLX/cbmmx6HxfKIKNvdniT6zmGI2sg3A6fWdf8vK6429f/xK2tIuHL3VQxbZyRG3GywkektEdwk63vcRhRzdBmp4MSEJAWuongbjzc0r83a7IvheK+c3YDtFH/qb/v1/+epdzagzjqL+0nBqYPTtTs+yd2FcGpJFmlah51KtYoM/5d+DJcSbaiLnL9PsO7gZBnm0aaGWcOaSyTMrnz89aidAJipLBYldMvhopAgTUVnC4bSEyUT1topxLOuPX4dCjHkcr1tM5LXhtaGfTuFv93GzmqLhC4lxPbEb0dIxiVt0Oe/5NdH6vBEr4cOfZeBzb8KT010DRH6TX+4HTWDMK0V7WyGassBvet7YyvigXk9yJe51Y20gXPnA66N/mv8A/yJip3qcK4qZ3/NuC1YRwnBQgSjz2auLywD/qxSQknrK3ynvojN3933fB3DXnZOo995vVe65krXdPBqlg+4bf4HJwlo6A9wwj+Dn8M9staRdmMmT2zHcDtdUAhSKR2/UBhn+kIhNBJhlgWDWk27AYQdFHbHVbbVV+wNyJWAj672PfmrCR0fL03ldoBFU98d96h1U1TQ3qCyQcWugK/7NCT39pYCq0tcTfL1g8kshDxMrNrlnuhpjSyB5zGcKCN8KP8WwF6W1XQ+7xpAqgE1jM0ZHM9VWJ4oyzfClS5AabhPP0Fm9BP3PxdInMlumVvJMjZBZe2BhAQ2FJHC0aq4z/i8hleM6HdwiHcayteEAmTySE4E8q6KQSXi9xc8LtDxLfwlJKhQSLd5dK2AOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199015)(316002)(38100700002)(8676002)(122000001)(55016003)(5660300002)(82960400001)(38070700005)(91956017)(52536014)(33656002)(558084003)(86362001)(64756008)(66556008)(66946007)(66476007)(66446008)(76116006)(8936002)(2906002)(7696005)(19618925003)(41300700001)(4270600006)(71200400001)(186003)(478600001)(9686003)(6506007)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?98asjnzeXoxcJwwDpzO7eJxsqBsq3vErhkKqnqQvtwLfVGNiO6qcw3lMNrpm?=
 =?us-ascii?Q?ZZUos7U8gzbMFFoZYoywDUK+FOirZ547fsP79gn9vNZjIMcLW5TF9EpkrD8Y?=
 =?us-ascii?Q?87e79ze6snTv8wdq6DcQDbqcGi0/W1lGRA1mFSVlGw0AsPgWrkYE2PbyuDH+?=
 =?us-ascii?Q?VBLCzE2FlFitGzS8ubVLH/MoALidz28N6YOtexIRLjV5AztS8e9wPIXGf8kq?=
 =?us-ascii?Q?LJkBZozgbQ0o5OKmUDxwmsx993SugPlrKkYFK2AC1dwA6MaEHsJfj4YvUFRB?=
 =?us-ascii?Q?JzzGgbQ9V/IJnJOdLquPTd5sIFXKDAfvUXOabR1SJfVs83u8OhQNyvbGJj5Q?=
 =?us-ascii?Q?IJ6lpNu6rXzZEjzTzpGvco8q9sAhUWFV/4TLVDja7hqqvfWZ1V8QbGdjx2pF?=
 =?us-ascii?Q?boJMhBSf/M2+RT+H5Esp53ug44FBWYYZqbxY+vuFl7xPPODxFoAiElrBFi3t?=
 =?us-ascii?Q?el60Sy+Z3xta2r4weQEWJ2ukAMypYrs8Am5WNsK+FFrtUXtE4al1l8Atlk2N?=
 =?us-ascii?Q?aMMl5KL6nevLypabJmTl8I/sCm6UbWcwtfC996XfTFKB8zalqgCayITh0HPC?=
 =?us-ascii?Q?k96PBGlKEStz2vePp8//rmGexyRMQb6ANygor3ObE15quFjPYYOVuhguDzOQ?=
 =?us-ascii?Q?hVdxrzMgku6TJLgBzPeABU4jHpArvyUdfd//n97QoVc6bccsbueGhvwRv7bk?=
 =?us-ascii?Q?lEvJzmf6m6HQHk5+qHtBMO+NzJePHBHcI5OjGYITBklweLq3gXV5qlYWpWv4?=
 =?us-ascii?Q?Y/2eZwNStYpWcqD/55hyNqtcWQNZsUpJtMvgG340H27a4N/sMtcpdYOQbJiN?=
 =?us-ascii?Q?N7KNF/pC/aLiKVAHE7FCVFWo31DzUEr2OOIbvz9lPgkBh5RjfUQdQcNOH0ip?=
 =?us-ascii?Q?Bb87rPfGeHuixVd70bd/iqKvhlZ7ke2eWo4/Gdmqd+e8LErciLtcLHlsSx4B?=
 =?us-ascii?Q?NYcFjmNgbBB4huo+oC6hyPdwWjToMsLofJnvyaLJGximpFdwqMhxS2BQqrCM?=
 =?us-ascii?Q?cgFAfkHJT/Ej0lTWj3W4oH2JpxrDJ06Gl0HtJ2TPN7qLp3+06OE2nLiDmDsp?=
 =?us-ascii?Q?jgHYGG+xjOOe0jgDP8lsBmBG2vUO57Ewp/nZTRNG0AcHQF7rdL/yL/RL7wGA?=
 =?us-ascii?Q?jlyZQdNE9itigNhA+vkVFNJtGQZ7BDWRZ5KkDCuPIvAkPSTw6ctC4yDk3l+e?=
 =?us-ascii?Q?WDaJzyeV4hivEQvsdiEctZbBN+tmCQEHUF1mPP3TTBhv6kzAERuwMecQxZHa?=
 =?us-ascii?Q?Nr2kXR8/CsRhX5U+cU9gCSuXZbnY8LS6tCzD+1ACa6G5rkbCW0OPbgJ3xyJn?=
 =?us-ascii?Q?tlbncOTRGSCizyYaxhcaufALmYFutqmFxOp44Cihg2gd663JvyEk5lL9LV/o?=
 =?us-ascii?Q?d8lxk57qU1ojhq+5N5iX7+CdbuFdNPQRkhZg9jBDeRJepixoCjZVS8b0fQL1?=
 =?us-ascii?Q?atQw+VFUnljUlRrcGSNTtyuNXXD9nFtR6IgJUH0M9ER/Ou309tgCMILY7AG5?=
 =?us-ascii?Q?WWD7tdLF6oXoIjiuGqMpegWPEkpn8McsorBYb2uG8zp0boNnMij/N2RNGGJq?=
 =?us-ascii?Q?/Ua4ITdRdZfN6LYPIqYCOyZCRLvGgLBVUtQB4OO+fnSgj0edI0UEfBju/3/a?=
 =?us-ascii?Q?raJuINqj7wm1HSHC6V66x5UVeQZTkQqi7/KXMWGhqH6ldL3jBpXrmPjqtE6/?=
 =?us-ascii?Q?F50+gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39be4b7c-6769-4a1e-32e9-08da9722c5f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:01:23.1584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBCXS781qCLwpB5stWjoBwS5av/poX3HaLlo9K+pJhSlUivCqHgMDqbkcW4Qre+9+QgZNTBH7v50S/4K3u7unO3Yx9t2m+vK/vFimpNtIeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7952
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
