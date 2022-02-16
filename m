Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1704B7FA2
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 05:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245734AbiBPEoD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Feb 2022 23:44:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243573AbiBPEoA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Feb 2022 23:44:00 -0500
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01on2049.outbound.protection.outlook.com [40.107.108.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11195DCE06
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Feb 2022 20:43:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOU7fLm6KoUSOSFhvalvrRfiXFIA1UA0qgo0fXP8tqodNIz/h0slbhl5Wnp/1MjWaJygx82Bm0slmO8veOi+qHHdQtaDSvZmBohy7q8KgV3Q2nNWS6McTGIslOSi9rbWyU10RMn7uRCRDWsmaXB6EsyDNmX+2pO2y0KsjRKFMVmdIZ+K42Zv8g5W79D5xERb10WCxA75lRWe4BMku/ULfvQ969ZAOFeMip9petbhLm6DNGVAKAi9PFszS5df3OtvQsDUoeUtRD4acZ5Bu20gSfSPojfNXD/YiGwlgTY83xKB4SW/vzyCd3hINdKXg76wv9m+HV4VEHxsWwO67yBPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1oH+lXLxLtNckGhrRnznyhQVTYB+hwL2mkjXRNl4+4=;
 b=lURWINPLV4najceObhsBZdM+ZNNVNRHAfBRZ4nf1BjHudv8H5jes07I/8gLNrSWKsLLYVHqScDzgiDbsvo7LQ3oNPj48vboaqttMxa1aPjineLm7ELBrYc4pjOVyJ8foaqTQjmDTDd4n27xTmjm0RzJGcRYemrp4ZWM25uNPycw55+6aEi5CJu+SASJQtl8DpgfXObevPIRvNSVMigiEgXtrp9VMgFxXG1J6NnneulPXEFBeq2nvDVFAZ4/d3a/Guw1X4yy5M9f5o+kkJj5Jor6g08bhNgvHD/UrkgCezUszvTT9kz6NDN2mQVssCEORndUW5QPL7PE4kt1N7lVC8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1oH+lXLxLtNckGhrRnznyhQVTYB+hwL2mkjXRNl4+4=;
 b=O8YZed85zd+1ko4XMu//IuBUe/2HZBI05Vejo4gzN13kcPZAmzUD8EvVCJiJHWmSBFH7f4UBWL7SElfKy7/hoItacWYhCDtgr0RUK0ShaiAL83yXUUM3ryL/Bt00Y/CUrClJ+55EWq0tLvrAdWO3VZ2TxmC1V96QtSG7SAn5RZ8=
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com (2603:10c6:0:2b::11) by
 MEAPR01MB4677.ausprd01.prod.outlook.com (2603:10c6:220:13::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Wed, 16 Feb 2022 04:43:44 +0000
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::1140:be98:7c93:495c]) by SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::1140:be98:7c93:495c%6]) with mapi id 15.20.4975.017; Wed, 16 Feb 2022
 04:43:43 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     "kreijack@inwind.it" <kreijack@inwind.it>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Boris Burkov <boris@bur.io>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: [PATCH 0/7][V11] btrfs: allocation_hint
Thread-Topic: [PATCH 0/7][V11] btrfs: allocation_hint
Thread-Index: AQHYEvPTT98AzBINNkK8YeEka7f/rqyVE4SAgABdQ4CAADPJAIAAE0hQ
Date:   Wed, 16 Feb 2022 04:43:43 +0000
Message-ID: <SYXPR01MB191845786070C7B5E9A67F8D9E359@SYXPR01MB1918.ausprd01.prod.outlook.com>
References: <cover.1643228177.git.kreijack@inwind.it>
 <7e5e75ed-86b4-a629-09c9-29202f93b4b6@inwind.it>
 <c43c5945-3c3a-0dee-a998-9e76c3eb0289@gmx.com>
 <YgxvUC86zumH3OF1@hungrycats.org>
In-Reply-To: <YgxvUC86zumH3OF1@hungrycats.org>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pauljones.id.au;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3752c5e-44e6-4882-5545-08d9f106e979
x-ms-traffictypediagnostic: MEAPR01MB4677:EE_
x-microsoft-antispam-prvs: <MEAPR01MB4677ABBA4644CAD7A0EEDC4B9E359@MEAPR01MB4677.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FfJuoX8f+YY2kIS3aTT8DjTyS/4S7MnrnTQYPNDot6qOVmvNLmjfj6U07GmU+LoVY4GX4D5mVJeKZozIMA/eoK6Gl6KFCoZMP6QPtZ4wH7uWzTlwgfWeZWfxQavyDtzkl4ma0I2wMibaZXYRpa/USypeRBsgEJ8iN+WcbM0+PHsFQKjsuFJ53e1M0NiOVeS+HTOOLB2fVlWPRExhPK9mVY4TpRiiX5mt4TztwqPMslFhVGPn17TNiwkNLrHUu5LN+e+sMPP44vkpFpvcoKKaV9jWKhrMQzjo6eEn0lxCmz1FZpihgOEZBs5xrP7hTdgZGiBpRs8alxueZ/0dbeeNYRYEsrUqQA/y1sfbNMeFjgN2oVc3Ghyzc0XLKlipb2Jhw4wfv2m5WKTIImpL0MZO7HSmYus4gwtdQ5yDCrgBSWtjH3HBps0ViNeeqv9nFBLqyUSuDksItRUROxgeM42j6WtJ126yv89bzG1UwaPrPkcnEH0ccZRbyz4DvUBCXJ7QIemfvHhkeK2nxqLg8ec1lon0Y9ZUJN5flhYEDwf7HQjeHoFlSGvg6m3qn3kf65tz1HD0OPqpi/zA6wKeqt+SgRZfgyn0VuK2jPfqAIcGSjohtwNt9fb6tUbR+LE6sxU7UdcEB4AsXDSUy1UFHHFQmXlpniDQmnGHW217yFoAFHFNPaj4L3ncVyuAZLozXp1WfIuLhgdbhh+J0Rh6R1ozGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYXPR01MB1918.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(39830400003)(396003)(136003)(376002)(346002)(38100700002)(122000001)(2906002)(52536014)(8936002)(33656002)(5660300002)(55016003)(86362001)(53546011)(66946007)(6506007)(71200400001)(8676002)(76116006)(508600001)(66446008)(7696005)(66476007)(38070700005)(110136005)(9686003)(26005)(316002)(54906003)(64756008)(4326008)(186003)(83380400001)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nFusAwA/kY0t4qMi6rUfSVfrRIzdVQH6UBVdh5r10D7OrYbCI4ZmNBzq9c6b?=
 =?us-ascii?Q?h0b3Qwe+hPZYXStfWUOEiPGm66W3KXHAkie6Tg8v3AmwkubGQhjF+zkmG8+B?=
 =?us-ascii?Q?sKH/AyTIqMbMDiwgePdhHLGZMzeRG0fmJRpzQOzN2twSndt1RqiCKieqqL4K?=
 =?us-ascii?Q?1U9lpTco+zhF05cxDxlfS4iRa4LU1WuUwwnm/63Et5z4wwoc4nglwzgUK4mv?=
 =?us-ascii?Q?8T4H4+p7NG5hufek3JGTKXoqfOeJe4AzsYP9wBjxtS/cVBlxx3Kr8NAV1pWm?=
 =?us-ascii?Q?B+TMkQhjcYVK8vWmF48akgKeT6qGKcFb1MmtCz0ihA/7wLfYXRyevQ8nPFF9?=
 =?us-ascii?Q?tjw/MIdiUEmYYO7jZ0zChcSYSGCU+7MMK6iIZk2X0q6hihWREhKf4L+Q1uwe?=
 =?us-ascii?Q?C/xpb6iif3MjLXZoRjAN09aGepMpp0GFX+ujkIYU5eHBIM+roez1jmCtjSZI?=
 =?us-ascii?Q?zX6W+vX7DMHFFxElsuVjoOLMAk/nE9dRk6VYJ+BqYzGxTqIzJYaM0KYX6PVv?=
 =?us-ascii?Q?R6l+O+G5FbLZwpae5WOSL2fBR91PZQV3Mmkq3/FhfqV82+z5p1ZcnEVTOLfe?=
 =?us-ascii?Q?o8EHHrSy9pMPeRWKkKpgG5uFtQ20XDfE6Ta9BG++byQ7H929Fggj+Vad44KO?=
 =?us-ascii?Q?bIwf2yzkA5s3zdZcY8qx6UXSi19LpJ2RExvPA0ZeePMoeM5ND4ZggVu7xyw+?=
 =?us-ascii?Q?VOMMNhD2fHe2x1RQumpVCDfZc5Yrg+yjptqWpU0LfqsX12QqzpRwFm74L8Zh?=
 =?us-ascii?Q?IIViISnBYX2csqttjAlD30Q7wGJAUNKqiPGEpHHWxIiIVo/y0IAbe31HAmCc?=
 =?us-ascii?Q?D1vRehCtml0VZyV5Xbmsrqaa4SHvDykM0QGrN9qxYOHXjBzSraDEY3qB9BlR?=
 =?us-ascii?Q?rfVkwdKmOhkXbOwOOJwO0yfQqtne9DcRJfxB4Ee93aKy9Wq0IOxPRjEicV+C?=
 =?us-ascii?Q?pfuZfuzy2Xz43j7kykpOebTUtlvpBGVdr58l/gpTpDwFgGwbUcNxP9E3slre?=
 =?us-ascii?Q?CTg4Wdqm5vpoEja8fyTnawDPFG9OhOZVStzFLAM+3i5AU7mxT9JRDl36pL+N?=
 =?us-ascii?Q?BK2BoZjKElqIXPh1R+Z85fMf3MaHfNFoND2QEQeq3sELl3ZcChGmjkb2ZKDY?=
 =?us-ascii?Q?KC4gq09adsf3C17uKIAU4g9dkXSZqzvMId+4c5c1TTALXz7arIZFlkhloUGa?=
 =?us-ascii?Q?86vD43Vak3BceSqABSmE0AdENXwTqIDfXi2OqblG9qEY8/p3eCcRfuU13Pvp?=
 =?us-ascii?Q?Dvf5eOLpa6G0fo3Z/gpCcQC+GpDd+YDLjF7Xr6tz7Z89MwbKZQSjF0LG7/ks?=
 =?us-ascii?Q?bRqHP1SWPl1cHbUa1edV3Fx7E8MRZcCkL66E7eXkqs6zJGp2A1iilluYNWfw?=
 =?us-ascii?Q?XDbTUUg1OWIwtVhfemhYKZV8djex5IzCKR8KJeEaTQud1hIcuE8WKmEcFKgz?=
 =?us-ascii?Q?6pmiSkirWZ+jSN5DZT0ghxBQrt+5pnrAGUFD/C74P66pghR/h91DYEJr5h9J?=
 =?us-ascii?Q?uTryFpSapVHk/CJrVINzC9vNG2gFnI/75FkL/G46R9EGAUzbvVUj5AM3vl/F?=
 =?us-ascii?Q?ws6HjEIFCotuoqb8hbXPXjnddh29vtdxQ6ATvaaXX4yVZuCpaTI6Yh0FYWe/?=
 =?us-ascii?Q?Gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYXPR01MB1918.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3752c5e-44e6-4882-5545-08d9f106e979
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 04:43:43.7526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SlVO58E6AgUWtMhlS4eZjTP0Y/IY1RvS6qXBZO6vQYN4pWo6JiJIek8cno0KT9HcTVZ/0X4w4K+vJNJBeKeFwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEAPR01MB4677
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> -----Original Message-----
> From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> Sent: Wednesday, 16 February 2022 2:28 PM
> To: Qu Wenruo <quwenruo.btrfs@gmx.com>
> Cc: kreijack@inwind.it; Josef Bacik <josef@toxicpanda.com>; David Sterba
> <dsterba@suse.cz>; Sinnamohideen Shafeeq <shafeeqs@panasas.com>;
> Paul Jones <paul@pauljones.id.au>; Boris Burkov <boris@bur.io>; linux-
> btrfs@vger.kernel.org
> Subject: Re: [PATCH 0/7][V11] btrfs: allocation_hint
>=20
> On Wed, Feb 16, 2022 at 08:22:55AM +0800, Qu Wenruo wrote:
> >
> >
> > On 2022/2/16 02:49, Goffredo Baroncelli wrote:
> > > Hi Josef,
> > >
> > > gentle ping...
> > >
> > > few months ago you showed some interest in this patches set. Few of
> > > the cc-ed person use this patch set.
> > >
> > > I know that David showed some interest in the Anand approach (i.e.
> > > no knobs, but an automatic behavior looking at the speed of the devic=
es).
> > >
> > > At the time when I tried this approach in the first attempts, I got
> > > the complain that the kernel may not know the performance
> > > differences of the disk (HDD vs SSD vs NVME vs ZONED disk...).
> >
> > Sorry I didn't check the patches in details.
> >
> > But I'm a little concerned about how to accurately determine the
> > performance of a device.
> >
> > If doing it automatically, there must be some (commonly very short)
> > time spent to do the test.
> >
> > In the very short time, I doubt we can even accurately got a full
> > picture of a device (from sequential read/write speed to IOPS values)
> >
> > For spinning disks, the sequential read/write speed even change based
> > on their LBA address (as their physical location inside the plate can
> > change their linear velocity, since the angular velocity is fixed).
> >
> > And even for SSD, IOPS can var dramatically due to cache/controller
> > difference.
> >
> >
> > For a proper performance aware setup, I guess the only correct way to
> > fetch performance characteristics is from the (advanced) user.
> >
> > Or we may need to spent at least tens of minutes to do proper tests to
> > get the result.
> >
> > For regular end users, the difference between SSD and HDD is huge
> > enough and simply preferring SSD for metadata is good enough.
> >
> > But for more complex setup, like btrfs over LUKS over LVM (even
> > crosses several physical devices), I doubt if it's even possible to
> > fetch the correct performance characteristics automatically.
>=20
> I agree with all of the above.
>=20
> An automatic performance detection/configuration daemon can easily set
> the metadata/data preference bits during mkfs, or monitor the system's
> iostats and change preferences over time if this is really useful and des=
ired.
> It doesn't have to run in the kernel.

At the moment it's all manual anyway so a bit of a moot point until somethi=
ng is merged.
I've been using this patchset since the beginning and imho it's killer feat=
ure is being able to split data and metadata onto different speed devices. =
It massively speeds up large filesystems that are metadata heavy.

Paul.
