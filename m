Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABC5777AD1
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 16:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbjHJOeQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Aug 2023 10:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbjHJOeP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Aug 2023 10:34:15 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AA026A0
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Aug 2023 07:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691678055; x=1723214055;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6EDRFghhbUdu4SPalPW6ga32q+JgV2ZP5QM0UOfQzMg=;
  b=GU67qQ0Sl4XmfoNXNrApzvhOj90bHVHhIFQdYRR30tLfxO5qNXO0af51
   DxtER+qXDQiQ5z12qiPYa45kkfpkYaDMELdI2MrY+KMkaILdWXJmL5pdK
   XVLpBWJNGoQH80cL4z1wMpfAEMeJniAQ+oydpdwm7fLCeuK9zEaW39PZf
   6pdSjJEiV7hPresDcmY70EuLIqhs49qH5Zj7TSGJy7VEg94/F4C25f++J
   yVz4q4dBttZHm/QSfszBJ5sjHf3Zg4aRAdzB9nZ/7b0F/gv9vFdGUaA3i
   rT9l3M4F3A3lLGuwz++YZdyEcxlpKgqFlrvxhN9toiOn6CS6lvo8DgQBW
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684771200"; 
   d="scan'208";a="241040309"
Received: from mail-mw2nam04lp2171.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.171])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2023 22:34:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTP1QLgmE05iWUEXVcp1ZJ+YepRuvLwrp3ex8egxS69uO+Un3ktCZPfVrYBkvMuhCC9trup5QUc1HRUK8PaSTWLT+T22itL0XUZF5cpisLDHNWkdmtuqDtV0ZBSjNvKoaUH6mnNZw8noYawk9eyR+wXRc9Rxn/R4IHXbmxbqCe9afxkZfVfIHbEbJg2Z9qsK4mpM3DckAjy3rTyLwWnEfeD6b0hYVRza/hXwZ+ddENSS8Cul2e/BOglwtGDuHRRNI9KdSHLI2FQbrBIyUH0gRs4/swh8GOJxh6v3zp57y+8C/nr1sFAEcjJ6oP7oF1ixFZLHrmXV2rJsJfT7xKgitQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IjZtwiJ1/QbPiOtctQH7Zenb5FD80n7eHH184aSDTY=;
 b=gget72Cr54dDb4xG7/kELcdklvDLoauhCGljg0Iu5/m/Sk5nGJW6f/5AMINbTVVtarbW/22890nIzUhOQOgJR0i+X/Hv66EkYB3IB7PTv7kmcgyHtfPDcpeZJkHTWIXL09fUJDgZ20nMl08gF0TnaHfEnPtvF920ndM3/SzmzSPHH6IzV9SxEkSjpuMEOiLOtfNskxDoQEdE4XSzD8ZEsUGb5xk8hNzF/CMFZXkSUq9KFwTRq0XeXWhMsZ68SGw0WK8N3/N9CRWJvgeFILtllUT8v/NAgitVMe80hgAVBONeCD2cqs+y2MXMiq2tpt9GutphvHUQ/MsiqNCxNJ0yVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IjZtwiJ1/QbPiOtctQH7Zenb5FD80n7eHH184aSDTY=;
 b=NGHWVrNvoS9ZerWnWOqFOX8wkpUYN6/fMCqqf2Hc3OO/Mx81PUuuBjTlHv3fk+XB5W1OzVf4GuUlCY+oXoO4XZUkzoeBaYDxF31AJxjBwiNVDgafkQh4IgZVR/29yy3q1C4GfetHXN6xUKOoAv3F3O7QZRq9ul6JM9ASiNRltZY=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DS0PR04MB8743.namprd04.prod.outlook.com (2603:10b6:8:12b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 14:34:11 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::275a:b2f9:29b8:e60d]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::275a:b2f9:29b8:e60d%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:34:11 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH v3 00/10] btrfs: zoned: write-time activation of metadata
 block group
Thread-Topic: [PATCH v3 00/10] btrfs: zoned: write-time activation of metadata
 block group
Thread-Index: AQHZyUoEGx7rPXcD/U+xC2mqEdFRKK/jjFUAgAAQhQA=
Date:   Thu, 10 Aug 2023 14:34:11 +0000
Message-ID: <v5fdkjdl3j5fndg6ujsoegwv2e7bnay6v6tcs26nsjgqbalde4@g2hmta5ed3vo>
References: <cover.1691424260.git.naohiro.aota@wdc.com>
 <20230810133458.GB2621164@perftesting>
In-Reply-To: <20230810133458.GB2621164@perftesting>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DS0PR04MB8743:EE_
x-ms-office365-filtering-correlation-id: e9008f9c-ae2f-4e62-c91e-08db99aedcdb
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fWOyMZpYwKTpVQvwSEnisVBg0XyOkD0R9oEjlTaOq/JP/+DtAvsCZgFIxOOkaB/ZJzrGsGv7XizaiQP33ewHnTNRZDJAhnAfj7p/6frCk2wT/5RQFwQBZx6quUEBq0wUTt/bKPwt+9uwqcuBSd93kbHsV0UC/q4QHIjk8TYQIgROWbsOWO8MnLemHjt5N1m3u9mJybTc0ruBoeD536AHviRp4SjZr5Ha724wtcFYKwbCjS9P5VgxvOzu0IWDbvdXBT8WKQ0vaSJxLwGM4M6H7iS9Jdf4d3+414kyCyF8gZbetyG+pCm9AcW4Ka6eGrMC7dyLFY/4UwdcvZ85BWWoxTbPjlBftHo6lgmDTT2oHO5GEIxEK/H8wOh4PTT95uG1Z1xwNC2rYMAx6hz1JLW1FRkg2zqWKmRDVZx4Tj1ihvhFKNzSpqFB+4Yci5g4hfxxQckSEfY6yv+CbIx8AmGUwSwkGVqM6+Ss2OR8mfhuhM8rEYNU6rVbW+C0gfNRDk7ZV/qdtoz6hu0mAquCDE8DcjxcKi9+1LfYHkj3zx35Vc0KH9NUWAS2WMBRXNtMDtCKVVp9vVRPwC8zHlz1h8djIHBryEjQz+xzasJ9Nyu7Lpmzqz4MAkK6FkwfAV6oyaUr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199021)(186006)(1800799006)(54906003)(6506007)(82960400001)(71200400001)(2906002)(9686003)(6512007)(6486002)(8936002)(41300700001)(38070700005)(8676002)(83380400001)(86362001)(316002)(33716001)(66556008)(6916009)(66446008)(4326008)(91956017)(64756008)(66946007)(66476007)(76116006)(26005)(5660300002)(122000001)(478600001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QmPqDjxJhUOv97NJ12HIN+xq4oQ030t1Vl8ON3esnpegESu7+4QmGwoB5XuG?=
 =?us-ascii?Q?pwfYundN4Vlh82JWSgaZivrPdq1Xx2H3jLntUQpTSQKtI10gfvd/3Vqju0Zm?=
 =?us-ascii?Q?5nAuBfkVtJD4Z2+oTeZBY1xWBMLiwgLb2cDLDbvhU3wWs/iKbTzS0F9SdGjF?=
 =?us-ascii?Q?2bh6vasFeiObU7aONiRuQOGN18nzkASe6qwaJv8v4dcHG3JNcpWnpXoDjc8U?=
 =?us-ascii?Q?n/Pa7952YBbAu7A2VdCNHYiDLewwILYUhqj8eEThRc6Ue6vhJGbt7LMR453R?=
 =?us-ascii?Q?7HvLI9wsyybUyg3tIXlUOJwFjpcq522uWxcVa5lpkkL7IJdIXJsFZIErzwQ4?=
 =?us-ascii?Q?gVi6/ajgzMmmR1jecGYU6kIbcM1VKtlBwNpF/flaovdopqjGpQKolGj+Bfb7?=
 =?us-ascii?Q?jxFVWt0rVSa51dCuxmZfq5pPZGrZyMz3BhC7hLUKIFH6w6efNW6yKleE7KBn?=
 =?us-ascii?Q?lpZNIeQ4do7AWJuT/6wufmO910FG5cvU6iTJolNSlJh3DFKhSmZ20/g2vikO?=
 =?us-ascii?Q?/i0sJturM3jFYTkTEVkVF82wbn2SZQ1jR6rczTN60DOhIhgGQJKcHZF9kjo6?=
 =?us-ascii?Q?Vv5ws/gSHr0mulEpeYwklmYl7am/8HDAzp31bhA1qa7b5Sjzp58nsGpaWXKt?=
 =?us-ascii?Q?KVe+CJtOAS6wix7s7yWgKDalxmCWB1hzLhmItmt16BrwCKdUEk/M3d4vuf6c?=
 =?us-ascii?Q?0fwOYqHAElZZeAr6kqVXGkaO6igkjLynkG4rI9nr01E/aPNQ2opDRSVrVojN?=
 =?us-ascii?Q?k4NCKIfC9g+OFKJop+mdGmBwgQKWDOPP57HrOByXlqSyAINQ9uxImQEamfQR?=
 =?us-ascii?Q?EnOtU9LiyG3So4jTE/5y5l3/H+tArilZ++bTxXuZlWzsi4sJUmEqAs6yVAdw?=
 =?us-ascii?Q?pdkaB/ERq2KYtxdDBxw9K0/yKBRpxBnbwdEZMuTi1TZSznYSLCw29wv6MKWf?=
 =?us-ascii?Q?hJvAqMta+M0YshFCpJ4mgmjJwcLFdp1czGYs7hsX7ZHdo8GP3rKpQUshs2X7?=
 =?us-ascii?Q?fM5azQ0ALEE0n3US7ZlJ1fW5W4NNpuQdJow7+AjO/V7NXME6Wmwl5gHiQzi4?=
 =?us-ascii?Q?zLmhw76/bLcPSnPxA4ogKo2TIXOeVGQSaaXNLDY0qe2AG9aIIHQmvmPfwt6B?=
 =?us-ascii?Q?2/zxDqAOL2dlgqsKGyvnV4HjcMSCh2G4G+6+IDghDLyJ2Bk4EOAaLCPCJnMm?=
 =?us-ascii?Q?WcJrV5dVUE1QPiCY8WasMlA+Pkwu2XEKyZ9CZDMgQzfFnnB37zJgwq7il013?=
 =?us-ascii?Q?E5wJuY0LCqi+kn8POUhnxP1u1xBqgTUbDAJctPfd//u7rSHGbwdwCWKTLF6k?=
 =?us-ascii?Q?ERdmsqxtEn04TGG+Z5Ko7P+Jrrm7ihAyiEdUTYPeOBC9ufi4nHYOaXnkXtMF?=
 =?us-ascii?Q?Cq/eZAyYozrkmhYgR5CnQwJbDqi3UqIu2b6hWURvyoQ8YmGBS2K6KQDcwOn0?=
 =?us-ascii?Q?99rciuXCL4jBuZWVytwxgF//mpaQhz2J6thphectKvYkRUoTepVYO+iDT5T4?=
 =?us-ascii?Q?qQVWXJqHjB1opoHOiqrNCxRshba4JOAAMXYkuy+HQv6QxlPKL64FdzVBPft5?=
 =?us-ascii?Q?2nR4zh7HrtxmDbVWxpuH8j3kKw+ZbTRDvdNxk43D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A77B05C190C6554E9DB4B662C37BD011@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /pnK068NQt0cNzn4newgtFb3ZSUPvaFdEMWu6LBh3mS43gc39TTFq6yoeQasJ0wAo/jKi1BCoMzQNEk3Hi7hHwMB65FA2U9GGdfydJ8wgoAI/bhOIoaGDMY4z+9sPNXBVpLoEt9+SwwLzW5d6a0dQWM4zd9r8VS8ABpLLDpDLJphuu0h1KVxZRad9UAughgYBTUrMyLRVfuCgedoah1yFQFF+2emXsWdvCRUCwFD8AeoXC6FnYKadhVhsP+GmphA8/W4AbUD2BH84CWGF6iJDzV35hswsQri+r+3VO++RjOWgAphTGmBaEVfVCVcGpejsV89mOAI45ittxr6iQmxxnO6OjaFVeiPEwSX1xvz/G9FtXT9Hrafu3/6ArR3rRH6fK4cTkidRCur8z9NPDX8JprE1acpvDVXW1LxmoomRPAFw5kcqZiL1U2DSbif22BfDqTUvfxlJ0vI70WGHvY5ZaaOHW0v+C0f27j4s8++lfolpv0+mH9RM2dGMTZupHhvs12o9HmIkp19IyhXipwmhqBwyW3qDUdvNsBlwx5sWMTeZANf06nEVlAjao0vKNoRMiAsaOQi7lTCa1WnWupW9JWgE3iB7ZWJ+WqRQfXko/cL9bJQE+3fsS5bluajEL9Cs5xVzkFslF9gMYa/lHx4x6y8MMLrP5QfnMF2AnfQVUCOFmJ/Yj35O2wzBX318vQg1G26nh0yLd94i+PAAQHgIk/vj/PcNIweUeNTFzrKXndrcIdi/NwWONoeJWzfa2Vtybq5bk45ZgRhf0I+5gBe/cmJ+/RFifnyXbTDClroACzZUQpKRHv+mzJe7LWLBCcHd+/Fk45LiUKcjs/yd/a06/j0CgG4glOop/RChfM+gjJZt4tuvcjfZxvr9Hp1uv7f
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9008f9c-ae2f-4e62-c91e-08db99aedcdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 14:34:11.1609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sczCC2l3lWwJBzj4yT8+RwHvMjgkZjpj+HsU7AN6+YF6XORmdhze+i1E7D8wSC49uF+37hj4AGOg6Cc3dstShw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8743
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 10, 2023 at 09:34:58AM -0400, Josef Bacik wrote:
> On Tue, Aug 08, 2023 at 01:12:30AM +0900, Naohiro Aota wrote:
> > In the current implementation, block groups are activated at
> > reservation time to ensure that all reserved bytes can be written to
> > an active metadata block group. However, this approach has proven to
> > be less efficient, as it activates block groups more frequently than
> > necessary, putting pressure on the active zone resource and leading to
> > potential issues such as early ENOSPC or hung_task.
> >=20
> > Another drawback of the current method is that it hampers metadata
> > over-commit, and necessitates additional flush operations and block
> > group allocations, resulting in decreased overall performance.
> >=20
> > Actually, we don't need so many active metadata block groups because
> > there is only one sequential metadata write stream.
> >=20
> > So, this series introduces a write-time activation of metadata and
> > system block group. This involves reserving at least one active block
> > group specifically for a metadata and system block group. When the
> > write goes into a new block group, it should have allocated all the
> > regions in the current active block group. So, we can wait for IOs to
> > fill the space, and then switch to a new block group.
> >=20
> > Switching to the write-time activation solves the above issue and will
> > lead to better performance.
> >=20
> > * Performance
> >=20
> > There is a significant difference with a workload (buffered write witho=
ut
> > sync) because we re-enable metadata over-commit.
> >=20
> > before the patch:  741.00 MB/sec
> > after the patch:  1430.27 MB/sec (+ 93%)
> >=20
> > * Organization
> >=20
> > Patches 1-5 are preparation patches involves meta_write_pointer check.
> >=20
> > Patches 6 and 7 are the main part of this series, implementing the
> > write-time activation.
> >=20
> > Patches 8-10 addresses code for reserve time activation: counting fresh
> > block group as zone_unusable, activating a block group on allocation,
> > and disabling metadata over-commit.
> >=20
> > * Changes
>=20
> Additionally you had these failures in the CI setup
>=20
> btrfs/220 btrfs/237 btrfs/239 btrfs/273 btrfs/295 generic/551 generic/574
>=20
> I've excluded them so we can catch regressions, but everything except btr=
fs/220
> seem like legitimate failures.  btrfs/220 needs to be updated since zoned
> doesn't do discard=3Dasync, but you can do that whenever, I'm less worrie=
d about
> that.  The rest should be investigated at some point, though not as a
> prerequisite for merging this series.  Thanks,

I checked the CI log. Yes, btrfs/220 is due to discards=3Dasync.

* known to fail
- btrfs/237: we need to tweak the test for ZNS (zone capacity !=3D zone siz=
e)
- btrfs/239: somehow, tree-log is behaving differently on zoned mode... I
  	     have no idea why it fail. But, I think it is still a valid status..=
.

* need to modify test?
- btrfs/295: overwriting a zoned device won't work. So, this test should be=
 skipped.
- generic/574: not sure fsverity works with zoned mode. Need to check.

So, btrfs/273 and generic/551 are suspicious. btrfs/273 prints some WARN
dmesg and generic/551 killed a AIO_TEST program... Are there details
available?

>=20
> Josef=
