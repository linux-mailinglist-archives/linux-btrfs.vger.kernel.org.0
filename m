Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874754E9847
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 15:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbiC1NiV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 09:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiC1NiU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 09:38:20 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A286DFF1
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 06:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648474597; x=1680010597;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lKL8RpmhW6irIBqFiRjzvMX5+Szgqqh5wFnWVvuwgKk=;
  b=h91USB3pOD3YCzPbcmw3IVYRH+C+SeYWGVFZLz5X5mAN9p0wGTComgIm
   VoQ2XZ6R9x6K7yl2o4mJGfT4FE2Bl0xwNGjQrWKG++1/8P+RYD+bc+GFA
   HjG3Z+s3SLqkMjfWG4B4wG6QHZshyxus87p799k+ebG/wnO9JQ/gXAcyM
   SbNz4E5RhCFYEfykwyOYMofXLPVmvvy5KvHA7OHHA23QN2VOX41KqBiuL
   Q6sqIBCTDS9dJG0fQ6OR/CAoGlkRvYDYCyoL9QTPloW1nBkeMHWlO5FK4
   yDzrY7XbBZWjp7F2NkJOmcih0457R899tW1PsjwEUh1u4ZXeGrqCX3k0k
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,217,1643644800"; 
   d="scan'208";a="196449858"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2022 21:36:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enoFpBB62Om7XKAbII15BwvudswXwv6UBxW+U+RnrNKQgG3ELRnPBolWcZcyXcMl3kKPx/BDqgxoxKvqQwdm9V8QuiNFsTPMwL4QrUbmDpze/cONA1zXsixF0pDAzdHlqu7Ac6EgyHAacA8B1zW8JiRpa64/hnGsD2cpjRo0AWQlHxXiMyRFoKlTY6b5rnKQHKuJ0b7nUPtQt3twSxTFPASzqabbgRARj9j7LC5dTiljMFsj7UGYgTGvKHBRmp2y5PK59Qr0OvfuNrl8zXyzJW4OV1dLxYE4WcriAzkmp271RmJdy2ZeRn+BGc3TnlHIPeFNAD5UksyvVSWtX1C53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06Noa0lkSP2gpgzdUFzkn7yTIzDaulzGxM5ZJBamNNg=;
 b=SkeOsKuMwgpdUUOghnibC5GHx2K/Q2bugYN0J1576fvnHM1hIPanJ46eTxT5n9ix+w3YTqvDmx1OblqlBH+BoYPRi0F9lSBCQ4KAvfBlZ7mQZbqGYcFi4llQxHbxG2QrJMnhRUY46F8YB/kjEJrE5Vv/Bvi8DUbbaz+3Z4LfiaLNn+LcHzVVsbQ2Oc6UWPLTCAHl3MzxUcFZFgW1rcUG6exaa/sAogeDRE0ETuxGcJmzvw9QqyfgwvWgWYM/5+8vQ3V3xXNK/Xjb3Y/gMujQwlnRejjRS4sw4J/NeiLN/xAWXYB/CPr6dVTLiR/H4oEwPEHF/PmVxqE8nhQqJ5d39Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06Noa0lkSP2gpgzdUFzkn7yTIzDaulzGxM5ZJBamNNg=;
 b=rtIzB3G58+M06pLsnhP2CNjAh1Cu4ONN2Zz21YWmeOkWRTR/puCYwJQ41Bh87z1mFXx/Vt5L9mhdr/CeZnLNOV1OZ1VKlaRaHq3gsYVGE2gosvt7KvlpTB6jSO7xALa37BMurryRUys+Ng4TPJ29lQ0NHb8tahWZBw3ccDFK/KQ=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MN2PR04MB6302.namprd04.prod.outlook.com (2603:10b6:208:1ac::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 13:36:36 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f%5]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 13:36:36 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix outstanding extents calculation
Thread-Topic: [PATCH] btrfs: fix outstanding extents calculation
Thread-Index: AQHYQp/baUxN9+HTdU2d20e48ORwUazUyDYAgAAEOYA=
Date:   Mon, 28 Mar 2022 13:36:36 +0000
Message-ID: <20220328133635.saheqkncmgmh2xn2@naota-xeon>
References: <06cc127b5d3c535917e90fbdce0534742dcde478.1648470587.git.naohiro.aota@wdc.com>
 <YkGzTsQtFNI9s7Ji@debian9.Home>
 <PH0PR04MB7416B28BD43CE79E2D6A75349B1D9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <YkG2WL4Fa096+6xt@debian9.Home>
In-Reply-To: <YkG2WL4Fa096+6xt@debian9.Home>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6c3cc67-7866-4389-7fa2-08da10bffaf5
x-ms-traffictypediagnostic: MN2PR04MB6302:EE_
x-microsoft-antispam-prvs: <MN2PR04MB6302D6FF3F583EAE9966BCEB8C1D9@MN2PR04MB6302.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t33IHWO2pD4wF0FF82QiKpkb3uUczyzvZHGAQBuuRUr6OB5KPlP1XZRikILX4ZvBeB8cMLNkTU4ouazetjThezqGTbS2YoRtSVLB/ZF791ifks6c4i+4KK+Y0rjUaawxe0auJoa05/j6oLjHQby3Sk/U2256Mo4JKAMPmf/+mIqBeX/1yTBhX/yNMk2Zzh6ONNakJ3eWqrJfiCdInGJOVSsh/iY4fuFTlewzoIwNMoP2HODrAZJ1s7SNBOExx2V68y4nvrZd9HOIC6Rol335SISD9jPPuQ2qaPwkgmRPVL4Z8aNmQLPhskaSSCuLXftfbfv31NLGs98N2KsGxVspDbvUO97Bg8zZ41MAhW1HMI125miZGovYYHmzSMaAgSUktPQcully+xBwQOSmy/sTCWIlzz+AyBSSGwYZEzTQ9+37korCbWrwlmJ/ZLahySVz6yxjvc8TqZF9QflRDhEunSIDvExhO0cAjbZyqhwOfCjF4HEMAczzJ2/ppoR7E3RLFfjwdfhOR4g5nIvmoRFHtqFCwtaZYCAwFybGM+23s3GNewLpacwqGA/qse7FXZf63ilahak7Kj8FOQKkcM0+NiDngrPNbh1G4VnIh18HBuThIK66soNUcwzWFP67V5SCSLQGJSt6lNHgmQEW9YSKdzMxr+kDNj40ZbVMfiAbJNItRj3mV2b2PlvyDeoZCixR5ouUgckReMHkfzKtzSYnuxrWSRgzDOFxQ32QhDuSIwjz+wHx60MRE/UQI7xtXRQRfzwgMvRAwK0OibPng78amJUeBvec57MRY0zgyGzrJv4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6506007)(6512007)(71200400001)(54906003)(82960400001)(6916009)(38070700005)(122000001)(38100700002)(508600001)(2906002)(86362001)(8936002)(1076003)(316002)(186003)(53546011)(5660300002)(4326008)(6486002)(91956017)(76116006)(8676002)(26005)(64756008)(66946007)(66446008)(66476007)(966005)(66556008)(9686003)(33716001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9LSWI7PjoDT5bU4c/6VnhTeooyECfjhe0sD1n1fG9ZU8WerJ31xu3Uiz04i/?=
 =?us-ascii?Q?K7PgB8fuBUW0NfLL4Zee7YodBxrjbE/TWaTvsZu1lH44uNk9ntICgPpsSocY?=
 =?us-ascii?Q?zvLtl9TvmpPHulh1zPNS26SysA8AQTTUPT4OztqmqicCTzDc6kTmKJYAoxR3?=
 =?us-ascii?Q?PxqX34282xOxex0tjRGd6CL16hT+RQ5vJGG+I+VvLJyIbyYqp39iAyq292FB?=
 =?us-ascii?Q?ue3JdNQQgRi0TYp7Lg0YqDyTpaAvSkgecQii77/v9Lb03iUZllLlZ/lg84dV?=
 =?us-ascii?Q?+UvYyi9Vkp12kMKqeO3PLDeYKmK5KNrtE/0LzHDS07wfwBsSU67iKJfVg61f?=
 =?us-ascii?Q?rmEu1iWJLZC4n2t3uyPJWva42cpU7yd3FdRjF44DLyePD3bkKq6HNtzKJ0Qb?=
 =?us-ascii?Q?26Tju/vdhcNTkvNFhNC7/KRbKqgDijwEbgyHxT+nAA+WVoLPqF6QzXmH9BBb?=
 =?us-ascii?Q?lAft+Wj1f7137isEGSm89a8MfF1ydvMWP4bOoIpXV+2+7y/kyS7RSi2VeH/s?=
 =?us-ascii?Q?ltKvxEJESoQBK6VpddC0Nihh7/lwYXbjI8BnLW3Wi+62SltB0nNcf6yeeJcO?=
 =?us-ascii?Q?EiOHqQWKsC/MLqBbU9tWZAjHrjqn+zvEQ+yLNb4O8/Z9neFbH+W+mxrFBdyw?=
 =?us-ascii?Q?h50bs6do3zC0GS5NAkr4c5eIZQin6NUZ41rj9udRhOi62pXu5j94mxMbwAiD?=
 =?us-ascii?Q?LuMaWS4AfN7r/PeHdTM1fjjZjNPB//V3pY22D64nekShJ0PLY1eqvQymCScI?=
 =?us-ascii?Q?xUaUSKle33p6y7jrAjfACqC6Mf/yeJm+QowOmkXQ+MnFGXhO2hXizn9E6ejq?=
 =?us-ascii?Q?OhyZwWF6lRa2it1A1SuAcluRUMBDhdyyu6kGPiyx8COl/HZOnxD3sBiGmXkJ?=
 =?us-ascii?Q?o+SF5sEGUPHChAUDMf0aAcZn5j0l9D45Ym74aTXXvPeh/hy9STTmoAvE3X1j?=
 =?us-ascii?Q?eBxUvNrJUj4rfL2mI0wphZ1hnmi7yzrja/Q5xWb9FO5rQGqyYDEcjcjbSzlW?=
 =?us-ascii?Q?MAJAHIjKUuCue8T3NqQc1UzGSsPGnMOON1eAT6Np0P2YVb0OjJnizXrQHRsM?=
 =?us-ascii?Q?IRtnxWDzhmGqalU4TmrfJvCDu7IDX0wQrXqaCAVN8tLstqmFkBpldh0YCBke?=
 =?us-ascii?Q?OXlrfJCiSqzgeEoLkiSMl1dW09Q37AJVgSz1q/FO1CTrmIaUFRzj59JTXxhI?=
 =?us-ascii?Q?ja9Yw48cEQ5TMuN0a5KM9C4qLUvKItrik7Wm5DMVMAYZRZ4A7J1aE0hWKoHw?=
 =?us-ascii?Q?p+2ZX9ke6kY72mtdaB4ixDl3mSRzyIlNSgMDSrVAKUrc+nWPoPErir9ARLqD?=
 =?us-ascii?Q?gDUM+FHvV2VFVdVqr0azhNlmnaJ4XuBXxs4ozYJnlHLDjp5K3ZS8YJmuUatt?=
 =?us-ascii?Q?scgnNpqAci1bywNgkgQi8zVza4/uV3ZKbryw+iFUSRM/jCItHWRZpXUosvuf?=
 =?us-ascii?Q?UAsxrWFyyWHX/YYQPuEX6lVKK/vhWsTaT6Wcnpr+o/M31n9GdLSUhOb1dLYQ?=
 =?us-ascii?Q?sJT00qHw/UOa0ho3nvUSZbOpQCtU01io0hi63JlZdo6qw1r2YSBnz9Jl5+mW?=
 =?us-ascii?Q?LkzS12dL4vYbvP40JPHV4oTZEiO8yWftuaShjpUehOd8K/XRsF8iSsz8ridy?=
 =?us-ascii?Q?jX/mW1DGnPv8oDKIZtxdP+xDuFVZHVQoJ9C+5QN07UA5hemixgNG1UriNau8?=
 =?us-ascii?Q?tZ2RFKR/Y7N8gkw+Quh33Rqz35sBXwvs+bTSl3ImdeSBMDazQN62ggEqcmQ7?=
 =?us-ascii?Q?3E5IGZQkKxd2gB3Vda97yqi66sTvxw8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BE88D43168611C4EA0ADE2274F4F65FF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c3cc67-7866-4389-7fa2-08da10bffaf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 13:36:36.0443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVu0XBQIoEWOzJVSsKvdpItI1/773hnEbUgdSO4U3XG6uPL90MmqQtSEs7j3t6B9jbm1m5O/6JW6WVpT3aMxcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6302
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 28, 2022 at 02:21:28PM +0100, Filipe Manana wrote:
> On Mon, Mar 28, 2022 at 01:14:02PM +0000, Johannes Thumshirn wrote:
> > On 28/03/2022 15:09, Filipe Manana wrote:
> > > On Mon, Mar 28, 2022 at 09:32:05PM +0900, Naohiro Aota wrote:
> > >> Running generic/406 causes the following WARNING in btrfs_destroy_in=
ode()
> > >> which tells there is outstanding extents left.
> > >=20
> > > I can't trigger the warning with generic/406.
> > > Any special setup or config to trigger it?
> > >=20
> > > The change looks fine to me, however I'm curious why this isn't trigg=
ered
> > > with generic/406, nor anyone else reported it before, since the test =
is
> > > fully deterministic.
> > >=20
> >=20
> > I am able to trigger the WARN() with a different test (which is for a d=
ifferent,
> > not yet solved problem) on my zoned setup. With this patch, the WARN() =
is gone.
>=20
> I have no doubts about the fix being correct.
> I'm just puzzled why I can't trigger it with generic/406, given that it's=
 a very
> deterministic test.
>
> If there's any special config or setup (mount options, zoned fs, etc), I =
would
> like to have it explicitly mentioned in the changelog.

I don't think it's super special. I can always reproduce it on 1GB
zram device. Here is the mkfs setup, and no mount options are
specified.

++ mkfs.btrfs -f -d single -m single /dev/zram0
btrfs-progs v5.16.2
See http://btrfs.wiki.kernel.org for more information.

Performing full device TRIM /dev/zram0 (1.00GiB) ...
NOTE: several default settings have changed in version 5.15, please make su=
re
      this does not affect your deployments:
      - DUP for metadata (-m dup)
      - enabled no-holes (-O no-holes)
      - enabled free-space-tree (-R free-space-tree)

Label:              (null)
UUID:               b7260fb1-fa0e-4acd-8c3d-0530799a9fd3
Node size:          16384
Sector size:        4096
Filesystem size:    1.00GiB
Block group profiles:
  Data:             single            8.00MiB
  Metadata:         single            8.00MiB
  System:           single            4.00MiB
SSD detected:       yes
Zoned device:       no
Incompat features:  extref, skinny-metadata, no-holes
Runtime features:   free-space-tree
Checksum:           crc32c
Number of devices:  1
Devices:
   ID        SIZE  PATH
    1     1.00GiB  /dev/zram0
