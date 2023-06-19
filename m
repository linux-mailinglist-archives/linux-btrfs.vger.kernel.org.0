Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E045B734B1F
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jun 2023 06:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjFSEfl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jun 2023 00:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFSEfk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jun 2023 00:35:40 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A69C9
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Jun 2023 21:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687149338; x=1718685338;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=beVCpxVUNiJ4VXnfB8V3tVk0/ZogsHTicfBV+KQTeHU=;
  b=que4K5edRzoOWbrYqQmWpfJEqcpnmN8VwevwIArgf3DCT8KxnStB+w8B
   HkzlaoVzEsBsJQlsaOqb+dXsTGjpvh4CAAV2leZnCMSW/s3BYSqNmZt4W
   wIqxCEGQXpbxZEd2B2JBq1nWdxTfMQV5UF0URNuW7f166C2WA1FxO88RV
   6sVJZISM3NpKp2gxCFj59dyE5p/Adi7BpGYkN2eue6IfP3mGJQDdqJUIx
   eSkCdLziIUNN6E6KQVPj2kyQJszY5/zuXonqHs7fxjKu2f7bEDRNG80mr
   enGk1Zx5ifehPufKA8eKKmM9s24Zseoy36Gs4i+yuTFG1djYrJ359EGJy
   w==;
X-IronPort-AV: E=Sophos;i="6.00,253,1681142400"; 
   d="scan'208";a="236229309"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2023 12:35:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3iSLxyqeyQgJO8UEj/SrbsA0eljPdLGCUJYH5b+LuMKHytqyHSB24VmNHKZUesO1fikGtZgAv4Cq10taCQdfXFvu3nexxAs2SRTxadaGDxIwrpo52UK6Mh7t5qlmam5K9AdjAHCmuP5otgrj0aP1Wh3zWJITIDo+8Ns2Ui2fmRhhURxuC+McYBoM9C/V3HEHXLBN+GnjC0qfAroman4/zr2vze0Q4Bq8L8FL2KLn0uExDGEDZnipZRjPGDB+4qvIQpY0igAFr4wOP7JkMtbOL/LKzQYS9ivI8PstRYlZxCiQ1b6Lp+mcVYoHWK8g3BXklKiLxP9TCLUTSQmbbrstg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kU9b5BkdOmShvV4kkR5/3AdxPKG6MmC31yryE55Svdw=;
 b=W7AbyylwznOvFypE4rD4tohPQVjlxtiE1qgxQ3xL45vz32uloDc0cbT/1VaGlR9EELKuNLLiADVXCX0UpAX7NUAjUsp5HyZhHdtkOE5ofc/hg/S+U+xjW9wmm7l7EKuxG+CC0DAjdHTcB8L8MRhVZtVF2nMKPsJWfiBGt4va60BNWeenXerpDgdAaIoqJ3o48x/V4TyWh55d+QRiDWt6wFjWU7ogjE7JnsmpKDIjyDRoz+QGQrKhcamghmraTaigYNq75VLY2GWVw8/ixctgy7wpGVtmss92PCd721jKQ7JJcqK76LGaiYxkKaMN4k3pvhc37FUWQ2C+ftwY3RMUbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kU9b5BkdOmShvV4kkR5/3AdxPKG6MmC31yryE55Svdw=;
 b=zdf53+iFt3KNRQ+M7y4DW68yfesVyURO/TXUS0oUBA6YjyfnmNzjdg/9owtrMgiH5ExDb5Pc8VoYDxKxwztqkiytD58cBANC4cR4/8FNVm7vM8lUofCIXyowRiuuMc6oXJcU1jYnlyTd2EQUVUObqz0VISbH3BjFw9tI4hn9Gxs=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB7114.namprd04.prod.outlook.com (2603:10b6:5:243::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 04:35:36 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::e9d9:ae8:fb59:5f01]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::e9d9:ae8:fb59:5f01%4]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 04:35:36 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: do not limit delalloc size to
 fs_info->max_extent_size
Thread-Topic: [PATCH] btrfs: zoned: do not limit delalloc size to
 fs_info->max_extent_size
Thread-Index: AQHZnUAc/ChoELfa0EizJWklxAILA6+IMiqAgAAJ+QCAAVEVAIAAPteAgAfIa4A=
Date:   Mon, 19 Jun 2023 04:35:36 +0000
Message-ID: <6nv6aat5dwpr6a75atima5ujcrfqktlrn4yyasyv756vwtpheh@u6vqo6fb7xwm>
References: <a2f4a2162fdc3457830fa997c70ffa7c231759ad.1686582572.git.naohiro.aota@wdc.com>
 <ZIf74wFg7NmvmQxn@infradead.org>
 <jmbvm4co36av23vly5e45hhyeth42ebl5ulqc7uw5cc6qdu6bf@x7i66logd62j>
 <bvtfl35llmzudy6lpiaqlw62n2wctgfy26ejwcqtnl3aoagisq@waq5rpmq7d6u>
 <ZIlTu1GtnyDs/EPP@infradead.org>
In-Reply-To: <ZIlTu1GtnyDs/EPP@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM6PR04MB7114:EE_
x-ms-office365-filtering-correlation-id: db79aac7-0471-4f11-1589-08db707ea050
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y/thPCuO2816MS0gp+q8vlqtDxCZvW0myOIic/M+wXCN/pVRRDar4SWqo0rILLg28JFaplIAraRqeDYUKzWgh4bzNli4n5fnjQqVxQspPH+9tKMBDHkXk+5pH4TJ5v317sDVvoY4Op/4PXkpjl2JjGlI/WNHvSXOhYB/M7S7N+elqA8cbs1AkYz2AQcjOKEeXh5G6oAvvnDw7AfPUWlM4V9ddD3Bahicz9+e3oT6ia6Png/2k2G123B0vzkoLqKL8uLA/7UggxlQK5KOtFvR4krQlP/N+NlelHQgRgK1lY3gFhi1GBkxX/+4uc4Txw6ddAJKX+izagIVZlyLpmjqrD6wEZzDhJfNGMYskkDgWv5D12a5TrVB/kJtcRARbfD3O/3WAIH/pWO0K8E83b+TnNM3V08eaywaX3El+sgTXazNqO8H4BDp4D0cvF9KXeDeoFmiSKycR8I9wOaKB+sQIF7KURpM1EmO5WaaBZfD6J2Qtp5QS75cLmIHqxFWeql2G2nPazR+oR8tLCidbiquHjpQLBs5H901+B4juc//f2wTSgux3QU67ioxsPmsngnNuGkYgSqU4tagSpIzOM7WJR25O1hidt5Pt5Ghs5hvUqQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199021)(66946007)(186003)(8676002)(8936002)(66556008)(66446008)(66476007)(64756008)(76116006)(5660300002)(4326008)(71200400001)(6486002)(316002)(33716001)(38100700002)(478600001)(41300700001)(26005)(6512007)(9686003)(6506007)(6916009)(91956017)(122000001)(38070700005)(86362001)(2906002)(83380400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PvBTjMIylJJXV4qHnzJmWgS8zj3ayx/AdbX+ByxJQdv7DAe49KB7dGotTIvB?=
 =?us-ascii?Q?J1UWUaRH0JrFdrUqfAQcfakrqMcC5AYeEBgECRtIqPl8TZ6Mt3mHyUPQtKnW?=
 =?us-ascii?Q?AZc+hukOb2fFrYezsFGxTcyB68axRv5tWJmtmwqQ9D7kROkoO0Lzltc/+F2M?=
 =?us-ascii?Q?5gaPbIJHw6lWUumTup3heJYLl87v7W4opPuQ+8OKxOCjtCq+WX9oCK7a/BxQ?=
 =?us-ascii?Q?EzcL/JglpcZBtCyfw17ydZvbZC7DNd2aojPxEKWLx3D6uGyV+1hvb8Oaf4oc?=
 =?us-ascii?Q?xqeR1jIc7ImN3qtg8WVgW0DjSSGGDBVRMQz79IrdTLPxdrh4XedZ4XFkpNCf?=
 =?us-ascii?Q?/cwysuXawghpAi8YxPUngvbAl5Tybw5lRfjNyPusQI0OxrQrAr+62NewJXdJ?=
 =?us-ascii?Q?kDZcm0uHHcTIaGWCdr/tvrsR76CRgvNoeaWc0zIlR5e1DfwagTAaOSmjeWJM?=
 =?us-ascii?Q?s1n9LXVJrfKuwQ68Elu6WBaZ4Rj6CXtOeBs334k84IAAnMG2r5BgS9HOn2O6?=
 =?us-ascii?Q?xEHKDdkJKEl16KszWNUKZfSueWjnheR3GvbXcxWIesHQ/R2o0VdbHyalxrJx?=
 =?us-ascii?Q?T+2fR91hPh7JDmIMoV+GX6C8RpaA95U4MawTwqeLU1khdrVZAAtsCi6WhHIU?=
 =?us-ascii?Q?cDirBhb6SoVjPu0o9dHOmRfDNPzZTf59c/sZppYlYPWMfBfFmP51erJR5FVd?=
 =?us-ascii?Q?z8ovxBI5gxzz1vd5zmaOOECkj9Ips0oa11ndOH1RVYIveLotLGw71x9FbSoV?=
 =?us-ascii?Q?kV07KCMEbpEoI8/9xrWL4j+tK8ai/Ft68ADqTjsisMV1og8pIhOiUsBakZTx?=
 =?us-ascii?Q?+VrPN8/1/xb24VfaD2SfWFvwix94iGTvqHo83FTKqkAeR7+swq6dcKbJTuM2?=
 =?us-ascii?Q?MDJ5O0jeuki6fvAdkqtokcOlsDkjmjOi9FjSW09yMfh48cbTn5zukHfUUNyg?=
 =?us-ascii?Q?cQA7fhArcGy4J6zQZ1sceVhcSTRGgoOf0faSkQU3wWVhqQQwx8kUlXJe0iEH?=
 =?us-ascii?Q?weFqrDJ5xBqc7tkCR1dWxugaDvdHE4OPepTF2Dwcnu1vb6R1RjMtpFNUMmSL?=
 =?us-ascii?Q?FR7hMhq2CT0lNy2Jv5O0u4raUBSxCKv0xQ2v4U+/ilqG07uimcIU1BDBTOtw?=
 =?us-ascii?Q?blu/YEPRvGcwMmGwmoTGDHohTba0YxIil3LL/tqPYTcbGoyAiXyFnNs9jl2f?=
 =?us-ascii?Q?LiDSyMQwek2zARjWDXCzwaLLID3ceKOJ2ULIKYalmBrQJXApinHzUjKSNLvc?=
 =?us-ascii?Q?gC4ZtgahIg5Ookj01k2sORM27HG1J7Pq/JNnFzhB+71T9nkeCTix5HKVBDmX?=
 =?us-ascii?Q?+sh7b5B0JqogjCG1F9e9ATMRulF8G64dhEM07cp9ffHQdrRXBBYoauPSWvh6?=
 =?us-ascii?Q?KF2/fNOAo6KWJQgnACPRGk2XbRU7GncPsY9OXFQ6dudhhjfqPku8SbFs83NF?=
 =?us-ascii?Q?TcXNJMURBTAvKG3nON05+ExVr1yFq4P8N+tBY2H52S7Ph2MLyYQ2P+nYxCBu?=
 =?us-ascii?Q?9gGawdpUItpCSVkOTlRSs/2b23Yeqj2NCM3Go5YY/a3IGGZjetDZoQmKncnU?=
 =?us-ascii?Q?KzObAttwTurWFjDFxmM1nH625y5ZS9K3W7+9L0hZieLdet1yR0rS8FPmcr7C?=
 =?us-ascii?Q?Bg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A0C2ACD3C662454B8A8EDB0DD2A43591@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SWCqp+r4gTTbMAmEDjqVJz8cnx6C+aghe+/3xk1/VuaPRPPY99t9OhfZMz/uPZIom8x2LjAzVhdqSd1n1Zbrl+9+yGT1n/SmevIhC5eS5Dfa6OIoVk2sYlhO6WaW6UlxRU31djHR1hQPxTo7gyZiwABlAbmu2p5GBW6j3z2ZyN539udZJCSw1CIh4Jglm9ZAQPXn1N7Pp9WmrotR6PFTJWQvX+yWLDnQAz+PhJq8k2WSVGGlrPJ2fTJolhtYLa+XuHTirteMvgoQeVaoQfTrpdTJ2ZtfRgs0xoAYn2LNISofEnysZRRZPTLaGRg/RUz7WQXRD4MohRGFlDgk56hE1SdPa6QOEelUdY//oU91ctx+4aVQGUfVPUFQfTMYW9es00EU+WEtZUoI2XYyv0SWNDs5lUH2X5OCpgWiHtAKVKWSacDsy3Anbnq9JQW6cLH7QLKeoCA7cA56SfsY7EptnqlKSzNx6hV8eUOLTsYh0B2nggEnuF8QChRmutax2liciUD4RuKh0ZL/yGS6/1xw8GyIYepbc4x9yIHVo2ntownkIFaP4dmIbOIDc5gxlySm5JEjNTcxniusdO1C5mLSmmpaDOAxFDNu2W9QibBZta3wK/9Lo+HrMjvDfkO0901fCYYLjjCPP1FGaxtCFqa6bPGRvKAzTJEWMdKp/h6gxPyu1xTg8h4oVWfXr+wBBzcLh/RYJN5ugqUs4VEGwrFf8+V7s2VkuiP0+zjxyrSKGy66uOUsdGC9QCLHZncAl4+GTuuCoAJT3HWBANnihilb9rPDGzILlhUQbpbR4H0nq6+RD4EoY2LjZl6IxXp8mrUa
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db79aac7-0471-4f11-1589-08db707ea050
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 04:35:36.0782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W+ZFw9nCLANw9rbbfQGSH54GWztc5X1WNIa8y64EEBW5FgRZnuzhjgYq90/xTjJ8azD7bcm8ON+SwnSVyZtG+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7114
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 13, 2023 at 10:44:27PM -0700, hch@infradead.org wrote:
> On Wed, Jun 14, 2023 at 01:59:35AM +0000, Naohiro Aota wrote:
> > On Tue, Jun 13, 2023 at 02:53:04PM +0900, Naohiro Aota wrote:
> > > On Mon, Jun 12, 2023 at 10:17:23PM -0700, Christoph Hellwig wrote:
> > > > On Tue, Jun 13, 2023 at 12:10:29AM +0900, Naohiro Aota wrote:
> > > > > This patch reverts the delalloc size to BTRFS_MAX_EXTENT_SIZE, as=
 it does
> > > > > not directly corresponds to the size of one extent. Instead, this=
 patch
> > > > > will limit the allocation size at cow_file_range() for the zoned =
mode.
> > > >=20
> > > > Maybe I'm missing something, but that limitation also seems wrong o=
r at
> > > > least suboptimal.  There is absolutely no problem in creating a lar=
ge
> > > > allocation in cow_file_range.  btrfs_submit_bio will split it into =
max
> > > > appens size chunks for I/O, and depending on if they got reordered =
or
> > > > not we might even be able to record the entire big allocation as a
> > > > single extent on disk.
> > > >=20
> > >=20
> > > The issue corresponds to per-inode metadata reservation pool. For eac=
h
> > > outstanding extent, it reserves 16 * node_size to insert the extent i=
tem
> > > considering the worst case.
> > >=20
> > > If we allocate one large extent, it releases the unnecessary bytes fr=
om the
> > > pool as it thinks it will only do only one insertion. Then, that exte=
nt is
> > > split again, and it inserts several extents. For that insertion, btrf=
s
> > > consumes the reserved bytes from the per-inode pool, which is now rea=
dy
> > > only for one extent. So, with a big filesystem and a large extent wri=
te
> > > out, we can exhaust that pool and hit a WARN.
> > >=20
> > > And, re-charging the pool on split time is impossible, I think... But=
,
> > > things might change as we moved the split time.
> >=20
> > I'm considering this again. We need to take care of the reservation poo=
l to
> > ensure metadata insertion will succeed.
> >=20
> > But, if we can keep the reservation pool for N (=3D delalloc size /
> > fs_info->max_extent_size) extents even the allocation is done for singl=
e
> > extent, the reservation should be OK and we can allocate one large exte=
nt.
> >=20
> > So, I'm testing the patch below on top of current misc-next.
>=20
> I like the idea, but we need to be very careful to not run into rounding
> errors for the nr reserved extents calculation.  Maybe we should store
> the number of reserved extents in the ordered_extent, and then steal
> one for each split and justreturn the ones accounted for the
> ordered_extent when removing it?

Actually, I think we don't need to do that. We can do as the following
patch, which adds extent count for the split out extent (by
alloc_ordered_extent()), decreases the original extent counts, and adds
back the count for the left part.

Technically, when the split size is not max_extent_size, the metadata pool
will be short for the outstanding_extents. But, that is still acceptable
because even on regular btrfs we can exceed count_max_extents() depending
on the free space state, and the pool is prepared for the max depth tree.

I'm testing the patch below, but still seeing outstanding_extents
unreleased when it deletes an inode.

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index a629532283bc..b140c05e7770 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1155,6 +1169,7 @@ struct btrfs_ordered_extent *btrfs_split_ordered_exte=
nt(
 	struct btrfs_ordered_extent *new;
 	struct rb_node *node;
 	u64 offset =3D 0;
+	int nr_extents;
=20
 	trace_btrfs_ordered_extent_split(inode, ordered);
=20
@@ -1181,6 +1196,9 @@ struct btrfs_ordered_extent *btrfs_split_ordered_exte=
nt(
 	if (IS_ERR(new))
 		return new;
=20
+	nr_extents =3D count_max_extents(fs_info, ordered->num_bytes);
+	btrfs_mod_outstanding_extents(inode, -nr_extents);
+
 	/* One ref for the tree. */
 	refcount_inc(&new->refs);
=20
@@ -1198,6 +1216,9 @@ struct btrfs_ordered_extent *btrfs_split_ordered_exte=
nt(
 	ordered->num_bytes -=3D len;
 	ordered->disk_num_bytes -=3D len;
=20
+	nr_extents =3D count_max_extents(fs_info, ordered->num_bytes);
+	btrfs_mod_outstanding_extents(inode, nr_extents);
+
 	if (test_bit(BTRFS_ORDERED_IO_DONE, &ordered->flags)) {
 		ASSERT(ordered->bytes_left =3D=3D 0);
 		new->bytes_left =3D 0;=
