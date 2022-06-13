Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDEF5492C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 18:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386385AbiFMPJg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 11:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386532AbiFMPI6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 11:08:58 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6131D106A7A
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 05:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655122878; x=1686658878;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nJonfs764dTMUaNsyK4lfxcvUNZmw22Y0nsEqXHJrcY=;
  b=Ovaa83n+FrrMykXFE8a97lJrqPDkmLwNDT4xoBinbsi61qeGRCxDTJ0t
   1olA2Lx3GomUdOZNDMJVa/SdU8KkAg9+aGnwuoBk7tCOb6lNuxP7e1I2l
   oFtaLi5QrYfy/MECD1Yiwrv32kqER3keei+BvkCnl08J073OX6PvDq7eD
   YzsilPknvRZBOeMUDHLxKD9gK8BmfFl9Mkk7aLH9miBirgXOkynt0avUu
   YJeONVco8PQp8EU8QVhbYQf+wbf/02mNlpk8wti5EW7R0Vz6CBz0iBF+u
   dO4/hcSBFIy8FWRQaPVHKSKmt5/OOBHzF8U5FMqdnKeGmTvkajfr1UajD
   A==;
X-IronPort-AV: E=Sophos;i="5.91,297,1647273600"; 
   d="scan'208";a="315057683"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2022 20:21:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+5w3KTIKFOdFooO/KLP24fwzEKoxDwl0hzhs4Gb86s0qx+a7JtHGlphr6oZIMhJm9ZfiHwdhfTpKrgkZ8e/Aeis3wXGsz+nnWo/QVGPbObZ9bUpweXxzDn7xaLdH2YCKYXf44+mYPvt4NOR1ybXvPOgKhNelO1mv2XLQtAH4MNAq1dwwt0JPH3+PJ2zMN6wH080Jja0NM6n66Yujbikwj9w+9onOlQQWEWcroxsGi42xN7tndMnsdOPEZXQ/7sECIQ3oBZ7gXbEC3q4a6kKzPLknh0ymrUr8p0gy266AY0aTMXrr15WZan4pcoYiNNF5yAFptxqvRFsr57uvYd5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IId3YGpBe5Df8jN06SjYJyBU0ifOBs0RzVfzZCZAHyk=;
 b=cBv6T/p6LBnn+dMO0azompDf97ljSIjPjn7LBf7JvLO9oNcOFcAdqRc2QlPGePQ+IwCclZGdP7RdYmOCnyIzAh5X1F8siYH8bV3SVytMw7QieRwCoFRbQVT/76dJaGyEx/phNZnzvc1Zq2fTA2QMJncsEfP3Ce1NxoAcXd5oyO74dsHR+fz4yEMiN30JbjZ40hAzRK988PrrEpJ4iVPA8TArZ9G9ND4j+VNWQz5gCBR7AEIdUXZxke/EufYRgPGgoDLs5RwYgQwyEP/baFg3LTaQpNlr901M2Tdo18YT7VwS7QgaKpZuN6BvHs643+bfNygG6N9Cvdy9eHBkNIFwDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IId3YGpBe5Df8jN06SjYJyBU0ifOBs0RzVfzZCZAHyk=;
 b=sKxi49D5A3X9Xr85/MMKns6upHS8mJlBQ/wPD3idWoieKGAUbU0bmMoOnLkYLAwm5fkfto1ALPB59olU47L9Zaf3dO9l2QyE5NfU9GmfTR52+o3VafAUfhuW99BMvhepLMEeTCbigtHJ+stjg0G7ErUOqfSDNUbEO1ffJd4yZxk=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CH0PR04MB8082.namprd04.prod.outlook.com (2603:10b6:610:f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Mon, 13 Jun
 2022 12:21:13 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::456b:ac5f:e71a:7164]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::456b:ac5f:e71a:7164%9]) with mapi id 15.20.5332.021; Mon, 13 Jun 2022
 12:21:12 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] btrfs: ensure pages are unlocked on cow_file_range()
 failure
Thread-Topic: [PATCH] btrfs: ensure pages are unlocked on cow_file_range()
 failure
Thread-Index: AQHX79OicLLdJYq/w0OUjXttGMYXaK0nK+QAgCc0lQA=
Date:   Mon, 13 Jun 2022 12:21:11 +0000
Message-ID: <20220613122110.6pg6q274wy4er7ri@naota-xeon>
References: <20211213034338.949507-1-naohiro.aota@wdc.com>
 <PH0PR04MB741660777362929B7E3D11DB9BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220519133850.GA2735952@falcondesktop>
In-Reply-To: <20220519133850.GA2735952@falcondesktop>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a98ae76-2773-4d3b-e59f-08da4d37342a
x-ms-traffictypediagnostic: CH0PR04MB8082:EE_
x-microsoft-antispam-prvs: <CH0PR04MB80824B2DB819BB60BD16F8D68CAB9@CH0PR04MB8082.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R5kTfSxiditM62B5zL5DQhL/e1HuV0nI5C6mBKTi//Ro8R0zlf4bIEjtJvgpOX/MoPnJFvQVQRJmgiZH0nd0FKN6IiOnFvzgMYT5q5FD0gva60dKKH4R41mg89zq8jzXNtX6LrsKMR0Rj0x7W8LwtzGBf7UPpTTPGwXHLF4xHegNbLbPiUJvFWkR3sOGgVGrj6OhE8QdbWgUIujvUORa+SeAc/YuIKqIun2K5qzQVpQGNpkn4l8x7fRy3fPql11QvYP8OEr9KS/WYUUZmioLUngtf0rwH5iG0kMl/Gu7+RsaB7phGwNVnAVAzG7o+hZhlFkjreCd1TleWIjqJp6F5010WmGEVNoE/Jrtd7i2RyU7Gsi/jbFBpzkPcoHsngPT5atlKLZb7vQ5naxuISGRJKwWUcfMKdpIYQKAnBLrXWfgVPnodoshxj5kQAa/wrca+w8/7kx+hx6bKqtP90DUoC1/e96Utbq5K2BJjLPZE2XIEKMlWEGtk0lDGVySj5m2zpwlhYo+kpgZqbHX9eCfCM9/3iWEo+5t2likgz6KLasQkHu67MpXTEQpWvlY+H4nGriLa5o1lAaLGG7RFEuEJv4+wcLZwMgJ93CVMQCRJX6jiauSNy3x6qLUU7TYYqC49ghWx/r94MkRClCjaUydthcIPuYcOyEnEUXVVMlL4ED/SpTDhLFBnvMlP6oCjr1ZUAFt1+dcbFgbxZtDrx3DUQAqz1SXbU5TG40usXLJCfhgQ7xOyVo/ks/fPGQVXLFJyZ7XHayifzdiCMZsQF87iFmc/44Hh8uRGWpxtDOTf3U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(366004)(53546011)(6506007)(64756008)(33716001)(2906002)(83380400001)(71200400001)(5660300002)(966005)(6486002)(508600001)(8936002)(86362001)(38100700002)(1076003)(54906003)(6916009)(38070700005)(122000001)(82960400001)(316002)(186003)(9686003)(26005)(76116006)(66446008)(66476007)(66556008)(91956017)(66946007)(6512007)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kQvRfeB0ZARLGbYMWwpZxGNQ0TGqDybVxiO/dwv8GkBZuYzt0/pipkd1ES4a?=
 =?us-ascii?Q?DRL1JfQuY9r5TvuEDFYeHHe3cAwadLuLSb8PtoNljIuoZkx4eRe2VLc4v5sk?=
 =?us-ascii?Q?nJlxwQ5b85p48FGjc7YUbMqA2OFKWT08HJU3UBQENZX2hs5B2NMFdczOYog9?=
 =?us-ascii?Q?16f4C+rCW3BtJciKlrdc3w2qJz0fnucJen2FwdLxaj41+Swvf0lycJMUWdHX?=
 =?us-ascii?Q?6mJsH8I7JS9Oi87l7GZ40OS3hpCv/Ad/7wZMnB2M0d8Nr4UdO6pUXNodQdqH?=
 =?us-ascii?Q?RIsanxCFNpsK9erqiXgs0yFqQelU/aoKIVVZNHq2eRNXrPS4xWUMIrCq3+wh?=
 =?us-ascii?Q?aRdSZpxSBA6K7Ff8RieukbG3S15V8DlXINeGj9P3f9s7Agh+N6YwK9oAC9Lz?=
 =?us-ascii?Q?OdxU9pMCMpZ+1//zAyE36BiwVzRzpBKcNdqWsRQa2XC7oPpIGf5RAJSFDoKo?=
 =?us-ascii?Q?svG6qArXLxfAUIJYZnfuy3h1zoMvLg9ZcXmwapAsx/l3mbyqqcyCEl544XmY?=
 =?us-ascii?Q?nBI1i4+Kyh8fMtowmZbSQ91A0V2uv9+d2Ff+Ms/hCFbC1tYYKWY/y1HJkmq+?=
 =?us-ascii?Q?119UUjupC3lQNh1D+ag/CIbbfLejj5gmVLCbpfClLnLQxMbOJZZg54O0hoos?=
 =?us-ascii?Q?3jpDDWNiuFoq6jizrZyZSYqHsH0sXpCoDX1m02pdsSKzRHgxJTH3Pt3rrrSd?=
 =?us-ascii?Q?V0DIyWs4sQSRN0Ei9SKhmxHYt2VweTYY29PWur33UD98O8zeb408sh0adeE2?=
 =?us-ascii?Q?80XFEBye/GHOKgaEm1Mn68Pb9KnZcgA1TIWmbDkIfozyDcN+s5kfpFwG1O3A?=
 =?us-ascii?Q?T25/t8lV6UaJP+42CKWY3lfy3orVzJawXdFf7ey0x9u7WXJ95dG23o2gaIu+?=
 =?us-ascii?Q?lRFlhjiaw0QtX5jYjWii2i2LoMITCvSKm13TRI7gURCEigJr1XvlM4pB0koo?=
 =?us-ascii?Q?dOCLpKh+T7XmcT5PBfmFubTW4s3pv33CRd/bEJnnFioNhRDZD7IQjNUt0kRV?=
 =?us-ascii?Q?eb6VMb/anOH/NjX6QRG90F/+zGY9elFld2keeWYRThNWYR8c0RkoMHHyzrip?=
 =?us-ascii?Q?tOR8j89UqpL5Jfnyuh+UdnwBqRf3NGnlpYG2SEKqn2SemH3mhJuw9NIE39ql?=
 =?us-ascii?Q?Fu/xNYXuuwTLaRTvE8Bu1DzeMEr2FnvMJAa9l4ZeLlIR9eG+VUSu1xqBdu3I?=
 =?us-ascii?Q?uaCQsHZTLca+1kGICfUWcGU3JViIE9DojqNTuvcDw/cTkCRkP8YB+o+ojh4U?=
 =?us-ascii?Q?B2S8v9nYJJkQj+CHH4eIXFL9S4NHw8mzfP8pPO/Jonj4aF1Vo99E4Gz1CBnZ?=
 =?us-ascii?Q?xEAVyyGUapiogOcVfgZ+kW2R+KVOO5lY4xJji2Z7LIkkstl41EC56/Hy3ccq?=
 =?us-ascii?Q?Zm9zaQf+zgu8QpyIi76quSpOziKF6joywZreWoIy8ctygSswcvnqzAJlihbt?=
 =?us-ascii?Q?ToTjsqFd/zwRuox42Jt9SKllLDswOjQhwlHfAJm5bFzwSUarlTVK+sR/TCAY?=
 =?us-ascii?Q?9iyg4ixvYwWVTGDqJaQ6HdP/9WZlsujrWiIHKPGHWUIMQEAZsjsfZmS3bu5q?=
 =?us-ascii?Q?ILsDv9UZRc4duxpnqPB6kE+w3ruwObwqOLlh0pHZJ1da/juR01neh5b7NUXN?=
 =?us-ascii?Q?K16qOzplWxtkabXDGcmuSPL7SZDEN2E0m4793Q5Vb4OAq37I8nuiYtdc59V8?=
 =?us-ascii?Q?P9GIH6BorUL6EYxdpRKWZgBGx2JtBSeutvwRYgOU0dxlCql/0MH7kvYkiAx4?=
 =?us-ascii?Q?o8ABj/cwDtR49rV4qnP4P7qWA5Zimc4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <522AEED28430C84D8A6A6A46EBAB2A5B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a98ae76-2773-4d3b-e59f-08da4d37342a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 12:21:11.9643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJ6Iz7ano+NaGAxflweWgm9RHYUzSYvAhrCuZdjHCR1zJ2jP2WknxCQYiGRfXlF2/ca5T2t2LW4ja/AkFB4M0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8082
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 19, 2022 at 02:38:50PM +0100, Filipe Manana wrote:
> On Thu, May 19, 2022 at 12:24:00PM +0000, Johannes Thumshirn wrote:
> > What's the status of this patch? It fixes actual errors=20
> > (hung_tasks) for me.
>=20
> Well, there was previous review about it, and nothing was addressed in th=
e
> meanwhile.
>=20
> It may happen to fix the hang for some test case for fstests on zoned mod=
e.
> But there's a fundamental problem with the error handling as Josef pointe=
d
> before - this is an existing problem, and not a problem with this patch o=
r
> exclusive to zoned mode.
>=20
> The problem is if we fail on the second iteration of the while loop, when
> reserving an extent for example, we leave the loop and with an ordered
> extent created in the previous iteration, and return an error to the call=
er.
> After that we end up never submitting a bio for that ordered extent's ran=
ge,
> which means we end up with an ordered extent that will never be completed=
.
> So something like an fsync after that will hang forever for example, or
> anything else calling btrfs_wait_ordered_range().

I'm recently revisiting this patch and I think this is not true. The
ordered extents instantiated in the previous loops (before an error by
btrfs_reserve_extent) are then cleaned up by
btrfs_cleanup_ordered_extents() calling in btrfs_run_delalloc_range(), no?
So, btrfs_wait_ordered_range() never hang for the ordered extents.

Well, there is a path not calling btrfs_cleanup_ordered_extents(), which is
submit_uncompressed_range(). So, this path needs to call it.

Or should we do the clean-up within cow_file_range()? It is more
understandable to clean the extents where it is created in the error
case. But then, run_delalloc_nocow() should also clean the ordered extents
created by itself (BTRFS_ORDERED_PREALLOC or BTRFS_ORDERED_NOCOW extents).

> So on error we need to go through previously created ordered extents, set
> the IOERR flag on them, complete them to wake up any waiters and remove i=
t,
> which also takes care or adding the reserved extent back to the free spac=
e
> cache/tree.

I think this is exactly done by btrfs_cleanup_ordered_extents() +
end_extent_writepage() in __extent_writepage(). No?

So, in the end, we just need to unlock the pages except locked_page in the
error case.

>=20
>=20
> >=20
> > On 13/12/2021 04:43, Naohiro Aota wrote:
> > > There is a hung_task report regarding page lock on zoned btrfs like b=
elow.
> > >=20
> > > https://github.com/naota/linux/issues/59
> > >=20
> > > [  726.328648] INFO: task rocksdb:high0:11085 blocked for more than 2=
41 seconds.
> > > [  726.329839]       Not tainted 5.16.0-rc1+ #1
> > > [  726.330484] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" dis=
ables this message.
> > > [  726.331603] task:rocksdb:high0   state:D stack:    0 pid:11085 ppi=
d: 11082 flags:0x00000000
> > > [  726.331608] Call Trace:
> > > [  726.331611]  <TASK>
> > > [  726.331614]  __schedule+0x2e5/0x9d0
> > > [  726.331622]  schedule+0x58/0xd0
> > > [  726.331626]  io_schedule+0x3f/0x70
> > > [  726.331629]  __folio_lock+0x125/0x200
> > > [  726.331634]  ? find_get_entries+0x1bc/0x240
> > > [  726.331638]  ? filemap_invalidate_unlock_two+0x40/0x40
> > > [  726.331642]  truncate_inode_pages_range+0x5b2/0x770
> > > [  726.331649]  truncate_inode_pages_final+0x44/0x50
> > > [  726.331653]  btrfs_evict_inode+0x67/0x480
> > > [  726.331658]  evict+0xd0/0x180
> > > [  726.331661]  iput+0x13f/0x200
> > > [  726.331664]  do_unlinkat+0x1c0/0x2b0
> > > [  726.331668]  __x64_sys_unlink+0x23/0x30
> > > [  726.331670]  do_syscall_64+0x3b/0xc0
> > > [  726.331674]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > [  726.331677] RIP: 0033:0x7fb9490a171b
> > > [  726.331681] RSP: 002b:00007fb943ffac68 EFLAGS: 00000246 ORIG_RAX: =
0000000000000057
> > > [  726.331684] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007=
fb9490a171b
> > > [  726.331686] RDX: 00007fb943ffb040 RSI: 000055a6bbe6ec20 RDI: 00007=
fb94400d300
> > > [  726.331687] RBP: 00007fb943ffad00 R08: 0000000000000000 R09: 00000=
00000000000
> > > [  726.331688] R10: 0000000000000031 R11: 0000000000000246 R12: 00007=
fb943ffb000
> > > [  726.331690] R13: 00007fb943ffb040 R14: 0000000000000000 R15: 00007=
fb943ffd260
> > > [  726.331693]  </TASK>
> > >=20
> > > While we debug the issue, we found running fstests generic/551 on 5GB
> > > non-zoned null_blk device in the emulated zoned mode also had a
> > > similar hung issue.
> > >=20
> > > The hang occurs when cow_file_range() fails in the middle of
> > > allocation. cow_file_range() called from do_allocation_zoned() can
> > > split the give region ([start, end]) for allocation depending on
> > > current block group usages. When btrfs can allocate bytes for one par=
t
> > > of the split regions but fails for the other region (e.g. because of
> > > -ENOSPC), we return the error leaving the pages in the succeeded regi=
ons
> > > locked. Technically, this occurs only when @unlock =3D=3D 0. Otherwis=
e, we
> > > unlock the pages in an allocated region after creating an ordered
> > > extent.
> > >=20
> > > Theoretically, the same issue can happen on
> > > submit_uncompressed_range(). However, I could not make it happen even
> > > if I modified the code to go always through
> > > submit_uncompressed_range().
> > >=20
> > > Considering the callers of cow_file_range(unlock=3D0) won't write out
> > > the pages, we can unlock the pages on error exit from
> > > cow_file_range(). So, we can ensure all the pages except @locked_page
> > > are unlocked on error case.
> > >=20
> > > In summary, cow_file_range now behaves like this:
> > >=20
> > > - page_started =3D=3D 1 (return value)
> > >   - All the pages are unlocked. IO is started.
> > > - unlock =3D=3D 0
> > >   - All the pages except @locked_page are unlocked in any case
> > > - unlock =3D=3D 1
> > >   - On success, all the pages are locked for writing out them
> > >   - On failure, all the pages except @locked_page are unlocked
> > > =
