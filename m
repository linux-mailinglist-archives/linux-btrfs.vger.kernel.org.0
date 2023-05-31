Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BE371859C
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 17:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbjEaPFg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 11:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjEaPFW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 11:05:22 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992DAE54
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685545506; x=1717081506;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DEyQxUbkr2m/+t4ubztiROniEf/ZK2eyaCyzr9pHYPs=;
  b=p4mhvpXXxKb4wfiY16FWQLADmzeyaW9ukdI9Tk0w6EC1VXVplrqCZGUC
   OKebjPNq4zsmmIbsuPSHJR6/PtC2IR4t584dC0yV5NVGmFaNq0jNAV5EU
   5wXZLGbDs6twaHJmr6wQZcLJLCTNK5p8fEudzMsJg984sZc1j7K3ql5ou
   BY3It8sbr92I9+k7XjTFNLv6fSzjG5NH/R3QL+AhFSijND36QNchVR8BK
   0mhS+S5JY5cRhNGBj4y1Qj9/qqiLm8QweoR0WHDeAx2JjfCIXhzYkedho
   f8fic1xO9JthnbGMH4nrIYYM0iyhiLV6+TF1gwp/duJ5nhlmqTOcs3xkP
   w==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="344194924"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 23:04:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjMy+s1QEq/vJD7CLVXr1DC4hmn0LuW5Sz1zrgL9kHEz8rl04wxNsJoiYBkZ4AgVW9jYkHOhcTH0B9E5OVNbMtN31M8+R2r7dLhyLW61kdQkrIH+wT1WnnBKOkIijs8yCmBjILaY8f+y2XWzMjX3QL+/hZ6F9LP9PWMg7uMka25W/HCtstdPJcFhMy0Y6/4g1yW9oxgbm5ILh6bcSboEsjUhIcYffwPfcFbubgVZRoLxcLyN1VyD2AG/FBXwpKxJE2pWZGKlnZd4JOAoTeaQLGcjbR39zrGlggSIMuUhJGzTYax1u7h5aEudIOyA2M3SxBkqzzbeOHZFaMNkObQPGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34mRic+0CZqHqj1vf8IXniZQCI5yH1p4WX6IxIIo44o=;
 b=kdGia5Dj5xP10r0IYt+Ja6AAwAy60D637YY5oDEnxdnwtjL+OzCu02jtLWiBKM6aHLwNrHTs7CzUhgXU3FkH4e5+DAK9JUrsrnG/Tip32FryzEqcRiS8PdWrp7ZrNF0i56jy3g+E5U7/gEco15zQXHjzUVdImgIS3691DS6XHWCS6wAGqipkuSxtrkbAGCY2z7+td2AIN7nUDv+D7VHLLlkjhbH43ENP5BS5hhhircQaUuTaz1/CJFBBzjY754KTydkckO6v42HS8PpccHXT/XL12G/TyPO6KT8jbb4DZFYHT19VVGWPfUGuaE8u5+AZTxVwESBNgPu4bQuOBSwDlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34mRic+0CZqHqj1vf8IXniZQCI5yH1p4WX6IxIIo44o=;
 b=nOa278zb/6paxq6DaLmuot+D9H4iqQdsGAva1h01qQ5xqmYsBDu1KqlQoskCF83ObTl29WJL7d4bD9psSuDxj0WgNRozi/jsQCgYIc8oYTIzySoOcDsI0smGE8RU/PZI7DFmUzn3qRoGYJ+B5yPZ9yGHz4BmwVDy/wngfmysZWk=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM8PR04MB7894.namprd04.prod.outlook.com (2603:10b6:8:26::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 15:04:28 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::b52e:3dc8:52f:b0cd]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::b52e:3dc8:52f:b0cd%2]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 15:04:26 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     David Sterba <dsterba@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: don't hold an extra reference for redirtied
 buffers
Thread-Topic: [PATCH 3/3] btrfs: don't hold an extra reference for redirtied
 buffers
Thread-Index: AQHZgb2eoZXM0oBLu0+mqYCetI5VIa9Sj9CAgAiKXACAGAEHAIAAzqYAgAC1DIA=
Date:   Wed, 31 May 2023 15:04:26 +0000
Message-ID: <lf4rdsuwr74avwruytrngh5e4tre3g6xz2mazhrjeh2g7pjsrr@aofeztgnhdgn>
References: <20230508145839.43725-1-hch@lst.de>
 <20230508145839.43725-4-hch@lst.de> <20230509225737.GK32559@twin.jikos.cz>
 <20230515092254.GA21580@lst.de> <20230530155648.GB30110@twin.jikos.cz>
 <20230531041626.GA32582@lst.de>
In-Reply-To: <20230531041626.GA32582@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM8PR04MB7894:EE_
x-ms-office365-filtering-correlation-id: 2e220cea-b3dc-4393-09cd-08db61e85365
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dfT75xE8cIk6hgIig5NDNFieMtbDaCn55PLQpuYUhQ/X0PgRi7Ma5jpMBKMk2fTI3gQKhNo5I1pIlwtplGuINAeRUTgRdTXyzRxtA4CGNmWi6RxId7K1w/dpT9w+t/K2jYUz6CGobpPvgu8mHTY9v6G79HCzdUYHwm50MOubvzqwn7STxLCmpkQA5TYQ4Xygxf7w0d1Frj8QByGY5D0+Z+4i9x5p+7PgmHWC61jobPreCp9AizaG16EaLbAZ00ZwpRHzsU1QHbMT6W22USgc46xlp62f3o9RKW+oRC80HcyhNMNuykZ1S12VaJqI9+iOA6cIbUsKgggyFUGAH/VTBnAxrFIrbUnk2wEn0tDokygLJ9K70Gc8gDQ8lXk6Ix5Q0vbfBvoQINYimZMJ7QNugbjtCpD4uMsqi/22fcTL+K96uuSSjNFcMNSvHh+msXh0r5xStXeBN0omn6PF4YUJV4cvASU1H5l1LD4LaHnOfr+nU1RzeK22Epa7UI0FGKTvOLhEAmjdfGAklTtWspFkldQVzeJWM7Be1wZtZVxCsme74abMKlNT5bMP16kUwMCcdx1ntfTti/je/bAyfJIUL9XANs0HrK839fQudb7omvaXnFgPl69TBBULKWd79y7or8qW8SsrhDiHMh4Dkjrxbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199021)(316002)(71200400001)(82960400001)(41300700001)(38100700002)(122000001)(38070700005)(6486002)(478600001)(86362001)(33716001)(186003)(9686003)(83380400001)(26005)(6512007)(2906002)(6506007)(54906003)(4326008)(5660300002)(6916009)(66946007)(66446008)(91956017)(66476007)(76116006)(66556008)(8676002)(8936002)(64756008)(27256005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LPe0HoruUZCgn15Q25MifvZDC/lF9igYkZzEByLDvIvojc8JwaHaCCbY5eUw?=
 =?us-ascii?Q?qatJd3TN6Zpg77ZcDbjZloYf/a1b731g86ZaBoG9YgbObBHPN/fBmSeSOhPK?=
 =?us-ascii?Q?YDxS1obPji7fbfN6O0cKKvx8vzIVR5IONzRL2XnB99DAsLh9yslDkBuh9Hx9?=
 =?us-ascii?Q?dI7viSuyXO04uH7wgeBHJjo7xogjaaZ5lWRC00OEWCbWyn5x5I0aCe9FZ3KY?=
 =?us-ascii?Q?bRuzqDZTydc84DOjVjoKbEma3pbdMWx7FVskptYYYK/86Wka7A5HvKA9ZRlT?=
 =?us-ascii?Q?LzRqPPeVtlVXTK8DXopWcj3nzC5Gd3iyGrSvoZbbyAFMHRupoxqrS1jaSolL?=
 =?us-ascii?Q?EIIBDKXskiQFn1diepbQWa77c9Y6X8jGpRzcPPkQLeYtO0siI5zz6yTqsHJq?=
 =?us-ascii?Q?aGWpyILZ3bn4j0QuZkMQU1oGFDe+Bi8HLjDbnMXoM+wuvXQ4oWbn0UdC1tT/?=
 =?us-ascii?Q?l3cy/dXiYEzpdYoXIrvJmQa+W4fMPcFcN5rSa/SUzVFGV1vrkH5eLKzAJwBa?=
 =?us-ascii?Q?1fRcldIINt3fbTtKgwfBdgBJ8Z2x90IqVt0jxkVEiiCozas9opph4sWQhs5S?=
 =?us-ascii?Q?lIzXTiK1ne+d7f/riFc2G8VmJJPrg0uNFlEprjbgaCTfaqcB9b+9ElZlFcMr?=
 =?us-ascii?Q?obytDB3Aw90kJ1EHWrPOfoDfMxjiDIGH55K9Qzh4B16W2nhBPLMYGPBqBL+5?=
 =?us-ascii?Q?/TIckndqvf+TPTmk03c4LdTaGr3U28IGJeBKUYCHAZObd6dhGHA4U4PQcIIF?=
 =?us-ascii?Q?54CPQuULhzDhoVcvXdeydemKMc5Da0/SNGWxSt4gV4JEAytW8oHLgIkDbp4T?=
 =?us-ascii?Q?RXtR+uXVdqflQ7oWfys/V7YKti0ybey+sob6HHC9d+ut3SL4AKUeA2O9mrNp?=
 =?us-ascii?Q?dljzx96Vub9wiBfnKeJazyfiCNATxxAEgSGcXKR+BwiFaZJ8720SzNB5i42W?=
 =?us-ascii?Q?XtFQ5eghRdIvVuAWR3m9SW+X0PORZQWsaDxNkAoyJirozNkOEKzigLfIsZiJ?=
 =?us-ascii?Q?on/uNFT4Ixa1QehpxCEUE48VCG5p6QPIG3hm7eOYBfEMvchwnx6GwhHI8gAh?=
 =?us-ascii?Q?JBch/RR4ZnJaZYe+KmjsdMyMCNf1OoG/koGfttQOjRwwPklPJiks2eOKvC3u?=
 =?us-ascii?Q?IjNaZJzlxM/CYA1MomiIjqMbAkpb3d7K8VU80p7pEFZPnz/9xkZnHgUT4fxu?=
 =?us-ascii?Q?kZDLNcdK7sUT3fK2ynSZIhvDhzaQm7ZrWqfyXxlJMD+JIpiWRZanE1nEyOZ7?=
 =?us-ascii?Q?Ex5YbVgkaODdY+o36zlushUmBgX952oVUefGV0F0oLFKfjeyw2ctIZEQK3S5?=
 =?us-ascii?Q?jBvX5Se5OOUz4uDZeGl7yFuhzCjBOf7r3V9TNx1z1nGKd9+trOXvCxn6inUH?=
 =?us-ascii?Q?NchdCHptYnCim+oyzxfrJ8u4kx93kJhL9/8xtPM4aL/xvXbCK2hd4i0FqHi8?=
 =?us-ascii?Q?6TgVZCl+QM4V9KkXQAyaFs8AV4O4Eb+SwKpLJor+j0cAfrPRV/VBcUBAQmjU?=
 =?us-ascii?Q?amJrhIkGbqrj7CMmfjjgV6VNgt8Pao0W9jczn9ytqYuOQeLsjfxfde0l0JwS?=
 =?us-ascii?Q?hAqCTF9/wrcwplbIvHOx3F6ZBFkCLQGfN6RB+qDRWAt4q/F9Aqqp6w/nj0my?=
 =?us-ascii?Q?Uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <127798B494979242A56A7F7F31F7A992@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Apeu6pTmHj4tfMfmSFo8BTDsHZT1REP4uH8gbSHmFibYVs+VwMmUfxTGb/MtAljzUhu9kksSWC2LHFQ5UEqZXaK7jlWe9Vrr1YbamlKgftNp4FNz+ch7hpmS6XYAfdfhYb426J/ZtVFkwagO/FFqwNtJ7iL9I/wiH6uZfMEHSozssUD9Kwc/in9oWH78rxDAx/jJzpPoqeCNq5l+UPAiCaQywyyEq6cX3X/B65TQRDPw0442DVhRtMg6AYZ16InZ8lRgvpOf+0t3B41ZeMJo2ajN6VmwZU2unkOhC6urrnNw8i0feQ1Uy9Xr0vcLseyWrPn4rZcY8WqAfv4qDK8Utvl0PEZsQUSyP76jpLCS0HAZHxNQFnN1XudMyJ5JD/DnPFAoX35U5Vq7GyC9LYYIbVQQ4XXx2f11+D9VXC9eGSzvvr4eMm8AF+3PeAeB6Op4IKYP77yFxRT31wa3vHw/Lk8yN9FD+hfx4F//HwNK3liGliucL8hGUj4QmKX11+R8hhLe24Am1ZDk0BOLsMTFrG2UkhtdjxPsalp/JsGPFGXtScdto++rnHe7d36AAC/86w2x0qY/rK3yRYYJ8UMWh6ifjzcg8NTYQp/6qsXoB0nOaCBsSGThWJDkLGQgSslXljoM2uiW9c1vknAy9bl1nkvhsx/ZhBEh8DOMLgiI5Zc3SVW/PHpPYpLq23Q28lNiNr+gFxyW/Qjgky5mB3ouBKtucsglWmwiuL/6umPhheIZYCbPcm3/0kUrLUMg/5Y6Vr7SECVaIlNR8PcM+4sdM1ZbrM/Oc55OsaalyY7S+iYOQHcUYXq48OKHVFumVluXWyYU4G7BczlC0viJBBu8vJ9Yjckh8o5iDc+i2v2AVH8blZvniCG7dMiBfh+TzER7AaS6i64em+w9Du41xAYrkA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e220cea-b3dc-4393-09cd-08db61e85365
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 15:04:26.1910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAP52ktBIitNju24p7rR+KoHYdYttlwOpNIfiVwTtIJuflRArEEFRLxlbAHUzRgSSNwgs95+AghfUgzEYjqhNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7894
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 31, 2023 at 06:16:26AM +0200, Christoph Hellwig wrote:
> On Tue, May 30, 2023 at 05:56:48PM +0200, David Sterba wrote:
> > > > I'd appreciate more eyes on this patch, with the indirections and
> > > > writeback involved it's not clear to me that we don't need the list=
 at
> > > > all.
> > >=20
> > > My suspicision is that Aoto-san wanted the extra safety of the extra
> > > reference because he didn't want to trust or hadn't noticed the
> > > extent_buffer_under_io() magic.  Auto-san, can you confirm or deny? :=
)
> >=20
> > The number of patches above this one in the queue is increasing so it
> > would get harder to remove it. I took another look and agree that
> > regarding the references it's safe but would still like a confirmation.
>=20
> As stated, I am very confident that this is safe based on all my
> recent work with the extent_buffer code base.  I'd love to hear
> from Aota, but there's not much more I can add here myself.

Sorry. I missed this thread is on-going.

I ran my test runs on misc-next containing this patch, and got no issue
regarding this. So, the patch should be good.

I didn't notice the extent_buffer_under_io() magic. If we can remove it,
let's remove unnecessary variable from extent_buffer.

Also, I dig into the "redirty" history to make it sure. In the first place,
it used releasing_list to hold all the to-be-released extent buffers, and
decided which buffers to re-dirty at the commit time. Then, in a later
version, I change the behavior to re-dirty a necessary buffer and add
re-dirtied one to the list in btrfs_free_tree_block(). In short, the list
was there mostly for the patch series' historical reason.

So, not sure still I can add this but, for the whole series:

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=
