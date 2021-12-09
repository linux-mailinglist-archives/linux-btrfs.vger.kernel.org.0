Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9926446E639
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 11:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhLIKKf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 05:10:35 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:64270 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbhLIKKd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Dec 2021 05:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639044420; x=1670580420;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+vfOIjW/RCaOSHBiAIG4xoBiUT/R8JMiOy+1aKYLCSI=;
  b=DYqF35gWg/qhPumGlF/MyfjIcuo4WaBazyukiAOSReWF/4M3Jvn8rrIF
   XhOrNJvhP4+ZM9WCdpabWe7ESrUX0UaWDIo+9ZEP59dAPSq5SoYNYl1oo
   zhDMGslWhjwKRm456NgNPHADjuUUQiiY/iIeO2xd5rttgYUO8Zkaepb+n
   NGBu+r51rzIF5nrRI0qK4TSOAnqvZ9+vk6wMaHqhBFs0XlXfVTYCUObun
   mjL33Pne8cc68RG23aVGW+V5Ma9bJGKkvwgtNAhrcxdxxAvtL/IUF1o6B
   ddlbqyDc/qnDa1YpRWQbV360CW9onPH8OxMMpEcFiupFfVPlzeidptYVn
   g==;
X-IronPort-AV: E=Sophos;i="5.88,192,1635177600"; 
   d="scan'208";a="299674005"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2021 18:06:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvWhZRuJS6jt8nypkuS4+othYTxrA/to+p18Ila4tyl23ziQZmyIFgj7frpTuyLANj55ym6xqymmEOrjb85mSNtHRNtUhHHTHN75yNjJ7LEJtlH5eaEeKftoKQpqP+SGh6swHKzsK4Mly4ru88rcrrs2sV9AEH62H0UtfQdiUbiIP7unnmDIiJ09W6LPd4ahbnGi+PWZaZEOyINIepFiyUS3iaY2KQ1VXbXZ01ia6VWXf2ftZJ036eZ/TF33r92habERO5zZoVkGMXo1Dwq2uZyiAYPJlJQGEb5SjlZBdtn79axFUkDgMTsQ0h1qdK8zeZU7VXCjJGUeRQuLTb3Mnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PX5dU3sGfDRKe4wgkamYVq8y3JJYmFhdXrKAC6M1fBs=;
 b=iBVtOak7Rsuh7OQrxVHXIhi+Aw+aK2dkoOObesW/YjX5v/W+6e7jrxfBCunkRWh1Fyo47py0Cf8ElyHyTFTlKleGZV25lc0w4mnjQwCTqAaIaDtlH6ncPupGCrwYp0elGEBRuCdlHyiasL6ml+UPzVSxrkXCEwRApOXIBhCysnGPlcNtYNvBzDc3ep9SymWWsaBzlgQHzqZQboJQs+M8x8QcQMixq1y7GvLvEJhi2aOzPVBhHQ/CBTlqovbH2jo0u8Zwh6e7p52qLF9yBeIZFvXliMcqby/058VbVzo15g3pHtNQpM7RVqGjEHVdyCIsTX07LgIgq0S8+GrBDYHpQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PX5dU3sGfDRKe4wgkamYVq8y3JJYmFhdXrKAC6M1fBs=;
 b=o+cVJPaZ7A4SscaeOuzocbA6x73w1080GwRBuAS83Yv3vvgcx4xxjYlc1iLP/ueit+BUd18UjcIBKMyhnQx5WaD0zYEVc5sAkFXFA2Zzs1XhqvmVabKi0328sfG7cSc/ZDZKT1MUK4eDbqF9rg8QRhf33Uy4o8MgSD/LGsf+fpw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7320.namprd04.prod.outlook.com (2603:10b6:510:18::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Thu, 9 Dec
 2021 10:06:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c%3]) with mapi id 15.20.4778.012; Thu, 9 Dec 2021
 10:06:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 00/17] btrfs: split bio at btrfs_map_bio() time
Thread-Topic: [PATCH v2 00/17] btrfs: split bio at btrfs_map_bio() time
Thread-Index: AQHX6kkvn7e4gQGU+UGEWJCojwlgqw==
Date:   Thu, 9 Dec 2021 10:06:58 +0000
Message-ID: <PH0PR04MB74160D826D891E5E543603769B709@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20211206022937.26465-1-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eed7ed98-87f1-4ab1-6d29-08d9bafba30d
x-ms-traffictypediagnostic: PH0PR04MB7320:EE_
x-microsoft-antispam-prvs: <PH0PR04MB732051107F2EE73AC83F7DA19B709@PH0PR04MB7320.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TkV1wPoyHsW5dJhi4yAW4lAtNCve1EMD7M9w93DdFnwRRZ0d4wPZt2nNrJOPXcFedDzrvJjJ7MqOFcxPMApOhysBBFBJ6mLTglhF4Ztp0sSQJrqR3w0UMs+YzT+OzZPU67w8ZTprapfOmVuSKgf4NQlggWXfvq7p4dPdyHH1hpDvSt6HKrdSKFQ2jfSz1S38x1uo9cG5aL+nYI9Er1Mbzjui3o7kEG4fDhRCTGt2k0ZZDCdRnYZrue7OUvVyw14VQvLLo+Gtu2aGjAgsZyZ/4v00PPDr6dtIiUlBG+yL8Sxhx8LOjQlx4ysbQgu+G0jJpxCiB/5sVmgWnjMgyXwp06mzUTYAUmcsiI3gQrFAPjBAyxb0zr+sQKKheHlgtJUiDGE4ya1GwTdf7UweNVcTPu/77OmRx4mQDwCjPA0cN4sjWIZofWr9x5TbikNqnaz7irrBkx6i2Ibj8ldfW/CPMZLkJQHG63I+0jJSU0bY37/u1V26bkcHQ9d9Czc5ImQfCXCauBuq3xw4X/dX6ufo5VU33HTU24PxPzg4IV7n/Dm70Xex9KcsAePnl3ebmNCDnFZmIs8IkP+nlwMq7rp1amTmMbKNJ1gypzW12ePT0kZGG8qUnIyJ3BVWgqiA2PbHHzQ9ABpaUGmFhYAT0qUu+jL2kY0qLdikyxcaYr6KCfxL7F+Z2/T2E1b8UmtaQQLtHmCWvTDUE23V12kGZM8jZ9VcKGDLa7VobUBKmvs8Y0EVbgiJtcZ3Y4nsdh+eyuH+vBiBISkQxQyFfwGzNb+h6EfK12Aj698BaU7DmZH7N3s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(110136005)(55016003)(5660300002)(71200400001)(82960400001)(8936002)(86362001)(316002)(76116006)(91956017)(9686003)(66476007)(33656002)(66446008)(7696005)(64756008)(66556008)(66946007)(966005)(2906002)(508600001)(122000001)(52536014)(38100700002)(186003)(83380400001)(6506007)(53546011)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zqN7xzV9BHs4Hp84YZut78WiKXVTdMmeGusoxPNDzPg/cm0QGNhyaccIwKGs?=
 =?us-ascii?Q?ghK777tApWzB26iFg4/z19MYARkHJtKAmrvLIM+9qRH/9N8gydrTJERFzVyT?=
 =?us-ascii?Q?jvqUk5JwhGTto3NK/EZxaYghMhvbwTDw/Os0VjX6LbUw37oywT0HWZphlgPT?=
 =?us-ascii?Q?0pBxEou+zhNO8smYKspol+XRT8q4NZv5zdk1TiSRAAkcipCmXBD5HDHACz8Z?=
 =?us-ascii?Q?wh6qwMLgQ6OytfDcRzQsHWe2Nw/n1NsSg0l7QKwM6jjpFhxvgRrGfJSbiIWJ?=
 =?us-ascii?Q?36cunomZpSe0/sTr1/EYyV6LK6iyC8me/SfF+cfySd5DJC/z799xbFAnmUAw?=
 =?us-ascii?Q?D0/jnDJZjUZJT6kzmlRivwZQcLZy9QYnlMtsOrnhmdOofNNdUXGjzVJTfngX?=
 =?us-ascii?Q?2Ghe8bQADE+Wg4L7ceKugjVYyiEo4AZZgjMCsXp+mj3W4/S+9BEGGIYDzwJn?=
 =?us-ascii?Q?M5xPc+1yRrG1axyUzSC4BErnHHA7yT0QAhu5SbIm11CJJHEEeYinjMkSfqN/?=
 =?us-ascii?Q?Q/UBYJ14fmVqdWw2f2+1v+2XTOVb6pR8HXYOd7uW3MSGURVQIbYV0BL8YDTC?=
 =?us-ascii?Q?8/5bW7LzIyNFbS8uvrPq+MczJ9d0hV1ozBL/USrbA5BlQ5IkLmkszE4/fT/q?=
 =?us-ascii?Q?cGeEQxg2d/+kMKZPIaSZkmJ6HRzAMoCnP6YveNvFcoswmNC9uiiiN1cka9l5?=
 =?us-ascii?Q?3ZtilcUrmTWItXVFvClb6dODzfjvhSsMZHKKORdnQA0BFJDbYTs8QtFuhbFh?=
 =?us-ascii?Q?B5h5wvivMMVI9WoF17fSNk6ljSiHDMXjkDf5mqbX9e+eF2YZe/6YT6otEtvD?=
 =?us-ascii?Q?SsTDEz5sYgzB/JTtBhS7SDpUeGM0F3kgm/VXRaWJEADQACoJJ/mQ4x+82eKn?=
 =?us-ascii?Q?Va+7EJil062xwouEzWiuNTQQPItqwRJUeXTxBttQ041dVk2plT50komz6A5I?=
 =?us-ascii?Q?Jeqw2NpmEMOKng+Uby8OsNWbM7UTck+FlOiZPyj2fUwf4yY0V2Sh/IqUJdme?=
 =?us-ascii?Q?jYhZ5YyqJxOZ0MlIVj8w/VIWfLfImJFepMQJ+doLb5Boey3mGcV6oQ0hCWt8?=
 =?us-ascii?Q?4v/p2CYkX2624MuuiMBnsLrKj7L5qS66oOhKbFOoB7P2dA35JXZkOdn+/WkM?=
 =?us-ascii?Q?VuqB5PhYITcIB6swf1komI/A15EbJWePlDzXxUw3v7GF86h6aWCvugVvEkl7?=
 =?us-ascii?Q?kMmJGXRX++8BoIaFDIDIxMZOCmDr2MAnUGntyVOt3LY6BXhY4W1iyVFq14Dj?=
 =?us-ascii?Q?XKajPR9vHdUBCUTh9OAeOR2LLoB+ZSajEVb12WjH36qNDPZybsC+/GDeKIc/?=
 =?us-ascii?Q?8lB6+zcex1CKCeNJ2+oV2mqUoT4a0UyMdSRv5OpQAdrbU5xFZPqR8iKnhNFe?=
 =?us-ascii?Q?QbV9Ap72NX92EcGKaTOD4E3xjWu0GuoxVT9pGhYW16dTAFJzRu3mhQJKuXbz?=
 =?us-ascii?Q?lkHR3i81R/prVH8CTN0k0jRPJD3MVeeibK8CfMy30xpg5W6L9VrjMlEBP+MF?=
 =?us-ascii?Q?xr20AROC+iR5W9Q+KZFzzA6DSheTawHYi14QFgTX++P9YJtcIMxOWPFiJmie?=
 =?us-ascii?Q?yq9v/nq7bHdjB5FkVvHO+3bsdfN6+WDiCVtoaW2mRY9l3F9XBRemPZoCOkrf?=
 =?us-ascii?Q?m16ZavWBcEp0HHM3G0fYbVTpORt5MoEfnVqDMihxyRGsVKwWmgzGNbqr3pKX?=
 =?us-ascii?Q?n1/JJvP4sc3d9qj/luLao4M2yCyt99J0zDy9nR9U4o3H/DPGkgD2ISYCR9l+?=
 =?us-ascii?Q?Jp7TP50aNc6VVfVTw6A9DsIs5b36Nfk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed7ed98-87f1-4ab1-6d29-08d9bafba30d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 10:06:58.2798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2la4aEpTDCWFeANk118p0N+GbeCjEHl1w1fS21ZUlCtdIPeOpwJHv/I0iZUcxmhr1rsLuLcKuF2v63L3ETMLRUqd4LRthFc8uTPdR4FoRoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7320
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/12/2021 03:30, Qu Wenruo wrote:=0A=
> This patchset be fetched from this branch:=0A=
> =0A=
> https://github.com/adam900710/linux/tree/refactor_chunk_map=0A=
> =0A=
> [BACKGROUND]=0A=
> =0A=
> Currently btrfs never uses bio_split() to split its bio against RAID=0A=
> stripe boundaries.=0A=
> =0A=
> Instead inside btrfs we check our stripe boundary everytime we allocate=
=0A=
> a new bio, and ensure the new bio never cross stripe boundaries.=0A=
> =0A=
> [PROBLEMS]=0A=
> =0A=
> Although this behavior works fine, it's against the common practice used =
in=0A=
> stacked drivers, and is making the effort to convert to iomap harder.=0A=
> =0A=
> There is also an hidden burden, every time we allocate a new bio, we uses=
=0A=
> BIO_MAX_BVECS, but since we know the boundaries, for RAID0/RAID10 we can=
=0A=
> only fit at most 16 pages (fixed 64K stripe size, and 4K page size),=0A=
> wasting the 256 slots we allocated.=0A=
> =0A=
> [CHALLENGES]=0A=
> =0A=
> To change the situation, this patchset attempts to improve the situation=
=0A=
> by moving the bio split into btrfs_map_bio() time, so upper layer should=
=0A=
> no longer bother the bio split against RAID stripes or even chunk=0A=
> boundaries.=0A=
> =0A=
> But there are several challenges:=0A=
> =0A=
> - Conflicts in various endio functions=0A=
>   We want the existing granularity, instead of chained endio, thus we=0A=
>   must make the involved endio functions to handle split bios.=0A=
> =0A=
>   Although most endio functions are already doing their works=0A=
>   independent of the bio size, they are not yet fully handling split=0A=
>   bio.=0A=
> =0A=
>   This patch will convert them to use saved bi_iter and only iterate=0A=
>   the split range instead of the whole bio.=0A=
>   This change involved 3 types of IOs:=0A=
> =0A=
>   * Buffered IO=0A=
>     Including both data and metadata=0A=
>   * Direct IO=0A=
>   * Compressed IO=0A=
> =0A=
>   Their endio functions needs different level of updates to handle split=
=0A=
>   bios.=0A=
> =0A=
>   Furthermore, there is another endio, end_workqueue_bio(), it can't=0A=
>   handle split bios at all, thus we change the timing so that=0A=
>   btrfs_bio_wq_end_io() is only called after the bio being split.=0A=
> =0A=
> - Checksum verification=0A=
>   Currently we rely on btrfs_bio::csum to contain the checksum for the=0A=
>   whole bio.=0A=
>   If one bio get split, csum will no longer points to the correct=0A=
>   location for the split bio.=0A=
> =0A=
>   This can be solved by introducing btrfs_bio::offset_to_original, and=0A=
>   use that new member to calculate where we should read csum from.=0A=
> =0A=
>   For the parent bio, it still has btrfs_bio::csum for the whole bio,=0A=
>   thus it can still free it correctly.=0A=
> =0A=
> - Independent endio for each split bio=0A=
>   Unlike stack drivers, for RAID10 btrfs needs to try its best effort to=
=0A=
>   read every sectors, to handle the following case: (X means bad, either=
=0A=
>   unable to read or failed to pass checksum verification, V means good)=
=0A=
> =0A=
>   Dev 1	(missing) | D1 (X) |=0A=
>   Dev 2 (OK)	  | D1 (V) |=0A=
>   Dev 3 (OK)	  | D2 (V) |=0A=
>   Dev 4 (OK)	  | D2 (X) |=0A=
> =0A=
>   In the above RAID10 case, dev1 is missing, and although dev4 is fine,=
=0A=
>   its D2 sector is corrupted (by bit rot or whatever).=0A=
> =0A=
>   If we use bio_chain(), read bio for both D1 and D2 will be split, and=
=0A=
>   since D1 is missing, the whole D1 and D2 read will be marked as error,=
=0A=
>   thus we will try to read from dev2 and dev4.=0A=
> =0A=
>   But D2 in dev4 has csum mismatch, we can only rebuild D1 and D2=0A=
>   correctly from dev2:D1 and dev3:D2.=0A=
> =0A=
>   This patchset resolve this by saving bi_iter into btrfs_bio::iter, and=
=0A=
>   uses that at endio to iterate only the split part of an bio.=0A=
>   Other than this, existing read/write page endio functions can handle=0A=
>   them properly without problem.=0A=
> =0A=
> - Bad RAID56 naming/functionality=0A=
>   There are quite some RAID56 call sites relies on specific behavior on=
=0A=
>   __btrfs_map_block(), like returning @map_length as stripe_len other=0A=
>   than real mapped length.=0A=
> =0A=
>   This is handled by some small cleanups specific for RAID56.=0A=
> =0A=
> [CHANGELOG]=0A=
> RFC->v1:=0A=
> - Better patch split=0A=
>   Now patch 01~06 are refactors/cleanups/preparations.=0A=
>   While 07~13 are the patches that doing the conversion while can handle=
=0A=
>   both old and new bio split timings.=0A=
>   Finally patch 14~16 convert the bio split call sites one by one to=0A=
>   newer facility.=0A=
>   The final patch is just a small clean up.=0A=
> =0A=
> - Various bug fixes=0A=
>   During the full fstests run, various stupid bugs are exposed and=0A=
>   fixed.=0A=
> =0A=
> v2:=0A=
> - Fix the error paths for allocated but never submitted bios=0A=
>   There are tons of error path that we allocate a bio but it goes=0A=
>   bio_endio() directly without going through btrfs_map_bio().=0A=
>   New ASSERTS() in endio functions require a populated btrfs_bio::iter,=
=0A=
>   thus for such bios we still need to call btrfs_bio_save_iter() to=0A=
>   populate btrfs_bio::iter to prevent such ASSERT()s get triggered.=0A=
> =0A=
> - Fix scrub_stripe_index_and_offset() which abuses stripe_len and=0A=
>   mapped_length=0A=
> =0A=
=0A=
=0A=
FYI the patchset doesn't apply cleanly to misc-next anymore. I've=0A=
pulled your branch form github and queued it for testing on zoned=0A=
devices.=0A=
=0A=
I'll report any findings.=0A=
