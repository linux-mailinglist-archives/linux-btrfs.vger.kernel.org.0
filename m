Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400C645D7DD
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 11:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353891AbhKYKEG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 05:04:06 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22750 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354387AbhKYKCG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 05:02:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637834336; x=1669370336;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8Gywvh0l73LPzc1v9UGGra51vXZMOSG9rADKWY4u6ws=;
  b=Alp4cvIaBQcAHZn0kKZqzNVhkyzA840hcGvYbpwdrO9Je9pyieIMC7fI
   2FzgZ2BuDJ5AFnlMkaI9O3dJItsZofYD68TICcF8v/RD7H5NLOhiQ1MQr
   /jSFUqhKlonmVF++VCWgo6/V65dgfGSpZNDs5wCtbI9gg/nwn/IuGYqe2
   fuHVSkhbMXZxLI79I2Z41kyqO5LALKiswqANxriUYNhhDZFIrOO5lLCY2
   1+jPviw1St2J5+K31IBQNBvJ/s2LxMQaPRWOhvh96l82XtpIOLInAw8ud
   eO1gmAsBXRuD/PYePP3WcMDAdnqrqzQg5l8LDBvfMrQdqhD2/f5puuwD3
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,262,1631548800"; 
   d="scan'208";a="187623166"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2021 17:58:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bG35J/vgdGdDbTZRS+5a9UpSVmF7T1wjI4IhkKCa5QvlXjVHaf0yWImYynx1eJHGO1M2NbsSpomE/858L3ast8N9LqNgtZjki14O5b4ZZLD2AcI0oMxJE8B0ipT9J/1lM3qlyQG89wPqj/jsJtAVmWec9jDFmH27C7SD6m74ompyV538vYJyeJg/GNbQMz7qAsyPJb9hY8BVTaA7PVwhYjV8XZNq6eYKsXPs9xAgXHPtU2nWFLxLXs1yBn2vJsaPHk/q24EWuvuc2W7bN9FvhpyUpMPiKlID12uie6nKScv0n247JGle6nyE/Jb4OJoDeDxfm19lDKpvQZdUno1BrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sh411RQ8STcFvwhlOReds8qu2+6lJAYgpEFm/ldEQjs=;
 b=VD6hPeDzAH5D0Qyczd9mkjC8Ifp+rUNYm/hQveVFaMkXA+WP2lmE3A3GL9qxTjI0OeLulROQERbcXQkpnZ1vAtbSHA60+OskQhxJsISTwBR/PIrpTHCvmotjhANxJ6xzQ13hMs79QeC5vK82j5NpSDsmZGxzw+dxHX7ROlxRqMtFR9fUZ3AkMkqMk5OuX/p7sOCBGpqIFQWwqyzBuDbacwnf+K8K7I/Wc91HlXfLQPSJCNyDbJiYKuBAEr29HZKjp2nnSROQjc7vncq6yDOQ4vL1kiuHYVnd+X4TFvzrMuHD4pTzOVHSAJsKVcdCW/Cp1EVBMHDjDmq30Yn+mjEQ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sh411RQ8STcFvwhlOReds8qu2+6lJAYgpEFm/ldEQjs=;
 b=uhKwRBUo4FDKACbl2gV/UQ1WjAfaOBia/wTwTjmXhj8UO7WVCuyg00ItGU487Ask+H9WIS5+Lnl0T4qIdWvhegxsBhFbxwAAHGZbSTmJKY/w9Hb7KAf6ehkZZ5+bDKt2XeYvTf/U6e9PcLp+VbNj3YhiXZ+ESMYJN+01nm42vfQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7559.namprd04.prod.outlook.com (2603:10b6:510:59::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.25; Thu, 25 Nov
 2021 09:58:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3418:fa40:16a4:6e0c%3]) with mapi id 15.20.4734.022; Thu, 25 Nov 2021
 09:58:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 00/21] btrfs: first batch of zoned cleanups
Thread-Topic: [PATCH 00/21] btrfs: first batch of zoned cleanups
Thread-Index: AQHX4RX8W/TUtbEyr0uD4VCaj+XJGQ==
Date:   Thu, 25 Nov 2021 09:58:52 +0000
Message-ID: <PH0PR04MB74160E2D32E5DE0C3524BE4D9B629@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
 <YZ5ppVSi6DAuw/A2@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf614315-ef22-4096-5bfc-08d9affa2f71
x-ms-traffictypediagnostic: PH0PR04MB7559:
x-microsoft-antispam-prvs: <PH0PR04MB75597A1A606736B870C632FE9B629@PH0PR04MB7559.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +DXcnoPJhJW3z2+dUPybYQOPgz3tYoDgsio/97gFf/phoYnLs2mNeX20rrCyb4FzEywJ+UfHOPhMrVqUDl9iwQXRh6a8CeI7yBkl76pVdvXX86ZKYFTsHQA/DIyZF79Gdfdmdo5RQlAlvT7E3aCiKSn4IWIry8f1fsBj9IwMTCV63mAK2ACzWse7OGbhCDOJ3bXiugNT/zOBMIO+cO9vXuM0jxRAbketqwFJrDA8kw47UQ7n7o27236U+Mh/O1wqoO643S8lz5uKdV6LU7YFKuTiFS0ayRZ2f1Bj/ykdQVy48KrutN9Xqam2qY24dCdt925osQbSusPc/XXYPNljIF/9n6rkHHgHTOg8bbqffjSK3NLsaAtJBFSyIEAPh0PY7vYMfXFsdOXCNrXRkhoxSfCMRNO9OFxE2E7pyko39Rc7I4/fAOPA2QPvqFg5jL8m+q8hOYsf20wsqESYjwlsczglq1DS9ixfR0cEsFX9Po6Z4eF+xi4EMI77WOf3zRTm+9kpEmMX7yzR8IGGNAlP+jzIFsBr/+l1i8T2eXDsl61JubGzImtnLTg45azZ9tZpMvflfqUc3jATDFpAAlSpQ3dlPxUuXvKLPtcwH+C9FmNJiJe+9GevGTraAwxdVjCQKH3BW6ngmplowTaAeyQniYPljrvsQzLv+/Y89LDnqwZvZC4hD4NzCU/90+l4+xKjb6C+wRTuDCJK23eLky4V4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(38070700005)(9686003)(2906002)(76116006)(54906003)(4326008)(71200400001)(53546011)(82960400001)(508600001)(86362001)(6506007)(8676002)(316002)(91956017)(66556008)(64756008)(33656002)(83380400001)(38100700002)(7696005)(66446008)(66946007)(122000001)(6916009)(5660300002)(52536014)(186003)(66476007)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B91k4kIPPU0LuPtIXd+BOF+9DdQPJ1o+zEIn2Fn8+ga6SSiYS2t0Rzciw7Qc?=
 =?us-ascii?Q?x8e586ouQ5FsHegjUYcfvhcFe57mSA813pv+3xaW9nDIRazQa1HZysYPWYvr?=
 =?us-ascii?Q?bHoA0HUiXectiAVB/1g9pbSpTrmZJkm0PrJeZkvR77DlhDLMedBFFRj4tyeM?=
 =?us-ascii?Q?4XrDqbY+8wGJf6giP4cFqJjPOyWV81J5gqPZFkqETju6LWYUbTx53ygs+wcs?=
 =?us-ascii?Q?pGxpfWcA0nIvoUbF+pMLUTybWTVVrTZyd0xn3i0vCVyyBU9+cbIhAGWBHCPr?=
 =?us-ascii?Q?mpjaY7wlLAtIqmdSf5n4h+TqUbvMq9rJECtaaA6wJSfqGwZg+R9qfZNllHnu?=
 =?us-ascii?Q?wELfN9X4U6NP4amTzS7DdamGZRS9JVPuIVYeZUQIf3exV+iL+XSZken3PcSl?=
 =?us-ascii?Q?koG2wCVvK76BD1GTi8icwZoqCy4DEMTRA1PJnuc7q+04AIruOoARnAAZ/0GD?=
 =?us-ascii?Q?ZYsc+RDRCNK1340KOj6gp9T38lU1vQD2zI9jDp9Jmb5v+K0FMnpNv3/Dx7Ov?=
 =?us-ascii?Q?sUDzvqIL6pY8UKDzeiVhEE3QWDEAbDsl5Ua3faDZPfo97adT72WI9wDtrlT4?=
 =?us-ascii?Q?0Ib0HMMFu4Yoz5f15/5EXqCQerXy4PofHuA5HnStWe8uSpi9Hpc8WDWaN3/m?=
 =?us-ascii?Q?7clq6z2YeUyiq06LZb0Y1Nd1sL1iiXpSOvGku1wWB4w05YJ0SH8r6evWaDgc?=
 =?us-ascii?Q?RqQbM+NvvcFwmmpmYpOZo6+w5h8L1a4pkqNLGN/0EOLhWIQtyWZTKfrPhgIS?=
 =?us-ascii?Q?d0RqyRoYxUs6tpn/vZPieVap5o2wLrMxEpQLigpVXbhxCdFniUSX5rut28Pv?=
 =?us-ascii?Q?GBoCC2jZuWtTW7Z9TpkT2SPuoyeCs8bBJas/YBMVLSp+VmohOAmnobn25ADh?=
 =?us-ascii?Q?3YXFoyRNWGOGcFBhLtlciiKXhXpeH9LSGHXKGI3xkRCnd6+AFWz7LV0Uwrhj?=
 =?us-ascii?Q?tN9SOLd/ssVkj7mJO6ujjuW/APvDQlZsVMXqquC3elS2FDHC/sQs4NJikJlN?=
 =?us-ascii?Q?7aw+CI2+AFHSsQNkIapu5m4Gxtn2n8DSk7TLuTD0PTIKFhT2aSxLV8/W8+Iv?=
 =?us-ascii?Q?A5dk5u9oARO2/T8WmRy2YfZ8Dr84gBO0UaW0/iUpwMmXbOmRHQH43kUmAJON?=
 =?us-ascii?Q?51ziFfJjkkaM9OBxzOKyalo+q/ZFvWUGEXQKlmNwPIyuwF80kRXlRCT9bBXV?=
 =?us-ascii?Q?UGZPeO43/Ub38YE5X6lmv9l4uappkF59lL4Dkl2VNcsTKGzdh4LW7LHnUka3?=
 =?us-ascii?Q?5cy1mVf5s/6V2vJdYtLFr2cmobKIbJLet6CuZd6vK6GInBCtk8c9/d6H65z7?=
 =?us-ascii?Q?FJt2C/PKiM1bu0SUPeyYeten+AOr+pYRZiJo0+PacVx3XRkPF4KHmHULVg87?=
 =?us-ascii?Q?Hbcuxh8BU1THGevnM5Gk19h2xXOD1S6NJ1kDVx5pJNosjBKsvsVqX6dFe4qY?=
 =?us-ascii?Q?/OW54oB9zOUVNa5tG7A5IZ5OjCrlmYRrDa4EhjOFRe4syuRod98mzPwblJnM?=
 =?us-ascii?Q?dcnQzT9iz0vsMlRj4tztQV5x+VjjNvXYMGf/EVCDprmjs3eVJMG3i8zNV/eF?=
 =?us-ascii?Q?4LxtcJAj3UnrqBxykpKWPloz0lkgZwtRhePp0TsNeZTCwcbiFN/0KvMfYSje?=
 =?us-ascii?Q?3Ju97HAKlyjrThs7AhTrtc5lgJeYZTEGdeEwhiJlE5aGp/gTAqxxbp2gGm7a?=
 =?us-ascii?Q?M3bZtl2EUfmhjVs5wJvpBEkuoOeimGORc6fvqdJlijiUpYAD3vnOu3WQTJVf?=
 =?us-ascii?Q?a/0Iiawf0V3bSXuvtUhzJ0ais/O9PoQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf614315-ef22-4096-5bfc-08d9affa2f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 09:58:52.0924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+RfxoyKEEySIEo7OoKtMjDsup269xcOgAEUUXB1cn2jVtUP9nBvpvcKHl5O2grhsghzjJzKe6QizHl7CobYWtxLMIAy76tcPT5pVJI7lqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7559
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/11/2021 17:34, Josef Bacik wrote:=0A=
>> Johannes Thumshirn (21):=0A=
>>   btrfs: zoned: encapsulate inode locking for zoned relocation=0A=
>>   btrfs: zoned: simplify btrfs_check_meta_write_pointer=0A=
>>   btrfs: zoned: sink zone check into btrfs_repair_one_zone=0A=
>>   btrfs: zoned: it's pointless to check for REQ_OP_ZONE_APPEND and=0A=
>>     btrfs_is_zoned=0A=
>>   btrfs: zoned: move compatible fs flags check to zoned code=0A=
>>   btrfs: zoned: move mark_block_group_to_copy to zoned code=0A=
>>   btrfs: zoned: move btrfs_finish_block_group_to_copy to zoned code=0A=
>>   btrfs: zoned: move is_block_group_to_copy to zoned code=0A=
>>   btrfs: zoned: skip zoned check if block_group is marked as copy=0A=
>>   btrfs: move struct scrub_ctx to scrub.h=0A=
>>   btrfs: zoned: move fill_writer_pointer_gap to zoned code=0A=
>>   btrfs: zoned: sync_write_pointer_for_zoned to zoned code=0A=
>>   btrfs: make scrub_submit and scrub_wr_submit non-static=0A=
>>   btrfs: zoned: move sync_replace_for_zoned to zoned code=0A=
>>   btrfs: zoned: move finish_extent_writes_for_zoned to zoned code=0A=
>>   btrfs: move btrfs_scrub_dev() definition to scrub.h=0A=
>>   btrfs: move btrfs_scrub_pause() definition to scrub.h=0A=
>>   btrfs: move btrfs_scrub_continue() definition to scrub.h=0A=
>>   btrfs: move btrfs_scrub_cancel() definition to scrub.h=0A=
>>   btrfs: move btrfs_scrub_cancel_dev() definition to scrub.h=0A=
>>   btrfs: move btrfs_scrub_progress() definition to scrub.h=0A=
> =0A=
> These last six could have been a single patch but no sense in redoing it =
now.=0A=
=0A=
I've squashed them into one patch.=0A=
=0A=
