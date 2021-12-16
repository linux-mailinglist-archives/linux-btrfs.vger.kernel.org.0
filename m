Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C3C4767ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 03:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhLPCa4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 21:30:56 -0500
Received: from mail-me3aus01on2084.outbound.protection.outlook.com ([40.107.108.84]:40103
        "EHLO AUS01-ME3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229934AbhLPCa4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 21:30:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kge3WpN/Oh7T76jsmYTEy6lAPDZ8TpV3Prp0JMS4cMv8tuiuitZrfc5iBge9cRA6CmJgyxn3veNTlBLxN0WoaXoBIVrmC11sfENMl5XfJcqMlDJVLeOfiWZ73ZWQu2i2/mOXucCD+BuOEtcops3KyZ883aT4C58TnuWBx/taf1mky35KsHqCiXQHNSdWlR3RDpOHsv3O0m1OmULyvSI1Ui07AMFOpvlWTRaHggOHKoYHcwS0Bi550RwUk+WJ7lvEeiY5O4bHk1VobtUYZG39J3q/jfP7VbGdHGOBOJ0xHNzhOxCVaShz1hvwT0TZIQttrlO36ZY5V1K1+uqqsmhtnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzCsgP50DAlg/iua4YphhC39muKxpru9pURFokjEr1w=;
 b=lR96WXETsYYmSIOl9tVlADxcUin8S5ihVR7C5sU3k6WtLnPrCTeotTZcN30lZxp73ez0xewWiKwahJeOkffC694Y9X1XtAx8cKZ6BI/FXHXUBCJ4pAS24nFzsd5ecFnWuBI0Jj2IL8LirrL7gOYfE/UFA85PO2w/tCYRlsnacDTiMDejTN29GLrmvD+17o10qGKIJsGbZfOQkUSOM14KP2JOrWHPfZYsSK44hTvQ1R0cFLW9Nv602Va2PA/s/LoaSmWyPJSad+qPUV1pdfQ97tRETmQdhwOr398dEi7N8GtN1HX4Q9cWzsEOubT48jWtKzRiH+JtPF8K2dXXKg2UoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzCsgP50DAlg/iua4YphhC39muKxpru9pURFokjEr1w=;
 b=BMVeTjhDDsuTJv5VSqg7rnqVEUFTN1FotYJEiisLpKKVAvfW5Lw+cXMO63xApuq/efwqQNmsUWqHZhFEVtLKOK4mp2FMC1oiBAbUWvLuYXYk4Ex0dmYsrVPFCaEsr1khPqDQGnaGrFWg8kXZKaSmJqeBluLDuiTHpO/Gm/iyqEA=
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com (2603:10c6:0:2b::11) by
 SYXPR01MB2205.ausprd01.prod.outlook.com (2603:10c6:0:31::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Thu, 16 Dec 2021 02:30:50 +0000
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::1140:be98:7c93:495c]) by SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::1140:be98:7c93:495c%6]) with mapi id 15.20.4801.014; Thu, 16 Dec 2021
 02:30:50 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Josef Bacik <josef@toxicpanda.com>,
        "kreijack@inwind.it" <kreijack@inwind.it>
CC:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
Thread-Topic: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
Thread-Index: AQHXyO1coPsLuEqH1EKv7+lQTcu8sKwwd1IQgACtRwCAABaWAIAAGk0AgAFTS4CAABD8AIAACFgAgAAB8YCAASGmAIAA0FTQ
Date:   Thu, 16 Dec 2021 02:30:50 +0000
Message-ID: <SYXPR01MB191899ADCADD056A4FEB74A39E779@SYXPR01MB1918.ausprd01.prod.outlook.com>
References: <cover.1635089352.git.kreijack@inwind.it>
 <SYXPR01MB1918689AF49BE6E6E031C8B69E749@SYXPR01MB1918.ausprd01.prod.outlook.com>
 <1d725df7-b435-4acf-4d17-26c2bd171c1a@libero.it>
 <Ybe34gfrxl8O89PZ@localhost.localdomain> <YbfN8gXHsZ6KZuil@hungrycats.org>
 <71e523dc-2854-ca9b-9eee-e36b0bd5c2cb@libero.it>
 <Ybj40IuxdaAy75Ue@hungrycats.org> <Ybj/0ITsCQTBLkQF@localhost.localdomain>
 <be4e6028-7d1d-6ba9-d16f-f5f38a79866f@libero.it>
 <Ybn0aq548kQsQu+z@localhost.localdomain>
In-Reply-To: <Ybn0aq548kQsQu+z@localhost.localdomain>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pauljones.id.au;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4a8ff88-e265-4290-c189-08d9c03c1338
x-ms-traffictypediagnostic: SYXPR01MB2205:EE_
x-microsoft-antispam-prvs: <SYXPR01MB22059ADEF29D718BED5B5A569E779@SYXPR01MB2205.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GpnoGRoMzQX6UxvzXOeBviQOLWj2QyrkQu+pZet1cGt4tD6d6xfi8lZGZPK7zLNPjrKVAd2hxEg4M8fx7nuX/Lx4r1hx8sJN48UsZI5L/th4yY7eZKzChh14uR0Y5NlCDzPus8ucNLZXxlCkD43uv6ghoSkSEdQLhKLqhEpZnBZWN/NV/JTzQV2N579O6e0N79Dgj9JOu6cn49wVP0nDi7tc3Q1KT2AtU9prm/kZG3DlRCCoojpqQojDNB9gsfaWzByg16GOcPZw9WCwMluM2ZhvBfUU8yCO7kdmJEwBfCA0HFbwa//jF0mPUMmdHi/HjGIiC/wR99aEt6bZZ8hGgwDtkR2XLz43YQPkbWcH93EZPGsx+tFmsMmxD2pBu2hPRwr77ijt+5Qult0bzDnC3rB1yOExHWUBJq/z4loDwyKblYAlnaGdVzrwlPjA3ccTZmBqc2QK+XnBGbV+/b4Sa6b0lHZaip6nGRDd7WaTEFzezKlJodE6YzPsd0RtEVtlQTQunA2fD3neiGeyGAEtpfHroo9KgqDDmKhiQKUit0KwoxbhbBb3YMHluJJVwly9DE0KgrhVrCqenxYvXWKqTX7GHIWhhvmIGMHK6G6w7fjwfbWfBp62Xs3EDi9SRcQTHR+jgaPVkDcWPoK+Tr1AAQrTg9aVQurkaq+yA+/DK7T3tUwNjH7KGuNAiQhMfer99hdi86KFILOJi9+v56G4rA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYXPR01MB1918.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(136003)(39830400003)(366004)(8936002)(8676002)(110136005)(7696005)(52536014)(53546011)(186003)(316002)(66446008)(4326008)(33656002)(2906002)(26005)(6506007)(86362001)(66946007)(83380400001)(5660300002)(122000001)(38100700002)(76116006)(71200400001)(9686003)(55016003)(54906003)(66556008)(508600001)(38070700005)(66476007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZEns8T8b19h+kTOMlF2RdOmXX4T1ZvTDyxNel3dZDR2g31nDsiUkyQEWvGkH?=
 =?us-ascii?Q?4kinxiB0o0JZ2JKBitiihaMHhppQzjcJMwP2t9oOquEaUAtY7Xr/aaVHBGJE?=
 =?us-ascii?Q?cPCnQxE9eSOBs/kdyR4VVvwBJ+4oJCzoOVHV1hR1VlNWlGvtXv7MstXFxn5X?=
 =?us-ascii?Q?RSFu+FDMGio2WO5j2H+iRaO0ypwh3KrUG1RxakAfj17XTbrAObvpBKzD7ZHY?=
 =?us-ascii?Q?rQ1snHdlZ3A47t/HpvVBXlPyWVjXsJb6rtSfdq0jET7kp2fO/1lMbooGsa9Q?=
 =?us-ascii?Q?1PTMD/KfvenitF7F9Lmdyhx27MnczcRNJ+6i0XMJlH58n3oXz6OqjhVIw+IX?=
 =?us-ascii?Q?yOPOfDqplzywOzoMjslbKgcCmK7vTOmfP5CdcVOkUamPuiU6S18reOWzY3s4?=
 =?us-ascii?Q?z+k0vCNl+oVr+t476/u0N2HJVlGgdK6EGqsrZhRBCvxFBX0pQGw2bJhFDt/p?=
 =?us-ascii?Q?ocUEde4nWGElux/tYIBcdgDUVA75rloAbTNysnGKHZiuf7Nd/ljuCNAZEf23?=
 =?us-ascii?Q?1KQaeoAf/ToqbHdl1LxxSi4jgpvkKvVfeQhE3+CUp6ZqCqpggiHGCijkPuNK?=
 =?us-ascii?Q?VsBm9mFgiPexAWMcKrLulEXnCweQvblHz3GxEnxXT9arV6d72Q1AEJ0TojEz?=
 =?us-ascii?Q?OdiFYpgMj2lS+S/7McTwDUPLt6C7WgssG4L7aeO/7EZKNQ4DDs/tCopCgp1Q?=
 =?us-ascii?Q?cAwBvMVxYyCDB+w5iJ9BjYFOwFO06L2OE45sCS1oOAtlPtliitmDdE8xr+VH?=
 =?us-ascii?Q?MEr5mxFu5zb9+g3C08eMckfDpbGaUIrYdkr+21j2j0IDZhFx1nigZxymQr1j?=
 =?us-ascii?Q?CgbWElnB4v4P9sJVReyWXklsYH9c+hzQYNHKZgX7ahZTPNulD11fWiQeZP2m?=
 =?us-ascii?Q?SGWZMtK16g38w2o0FyjaaLguHD2dHUf2Q9bVr1goDpTrB2PecI3Os/3N6mzS?=
 =?us-ascii?Q?4Xdzo4sUEnE3HtDLC/JQh6763SxmdT9I0PhUFyhF1x08ArMu2ptPcqGNFjrC?=
 =?us-ascii?Q?R9KDTpMMRoEQRidIg7ev28bUHUXK8pJZSYVSoqco49de1SlMEoqsecAMiaEA?=
 =?us-ascii?Q?2eHkXRKSzbbUoMtLPKx3o0Ri8be5hyjRvd6tz8zBahMVaUYXgSD6rl2Y32G9?=
 =?us-ascii?Q?e0rnh9LIGkNhS78XKDVKTA/nJcPJEuEvkLF7+MvODkk2dOpCRbwzI0R9vhbS?=
 =?us-ascii?Q?uV3zOR8ycaBSdNGkuuosGF/W/kcbyOgfJPYPeGXNSykMVcVtzdFW3c6W7n+V?=
 =?us-ascii?Q?oKPJHJcj00xuWuJvmkIboG8fEPJJPEu+H1DJp4IUa58O0s4jTv6DzoCQkrGM?=
 =?us-ascii?Q?AlOqiW6pBh1jfrYpw6NkpK8PDJIYCPr7Ah0sQyxYHe5D3jbXllTzcGEo3Pz8?=
 =?us-ascii?Q?06AcKwQ1uz/QZ0puc1xEeNLlrB59FgDqqh1d9fipDtiMRPpE6nNZmXazrD5K?=
 =?us-ascii?Q?l2pYpnUnl3zwBx3t8WGF+FTrxvBi+jEqkaUXefTGzr92RywROeLy9+U640pY?=
 =?us-ascii?Q?C22bf5WHMFmHRvC8N+iwl1O6PK3eYzY4XBbIYocKoqSh1zsr9zGXL4SWF2Bq?=
 =?us-ascii?Q?rW7eYRmXFCLHU6enZB9MWGR1zfoDdwLfKXU/MZky34ES92kFc8Y9Sxpt9F+S?=
 =?us-ascii?Q?Cw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYXPR01MB1918.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a8ff88-e265-4290-c189-08d9c03c1338
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 02:30:50.0974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bgin46skVRa6jMEZCxZFbU8kXpWz7K1NEJajtUy/jwJZ4vY2eOFwKW0ziZVnajzRvR0vbAl8oKeiicc9/tAaAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYXPR01MB2205
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> -----Original Message-----
> From: Josef Bacik <josef@toxicpanda.com>
> Sent: Thursday, 16 December 2021 12:58 AM
> To: kreijack@inwind.it
> Cc: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>; David Sterba
> <dsterba@suse.cz>; Sinnamohideen Shafeeq <shafeeqs@panasas.com>;
> Paul Jones <paul@pauljones.id.au>; linux-btrfs@vger.kernel.org
> Subject: Re: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
>=20
> On Tue, Dec 14, 2021 at 09:41:21PM +0100, Goffredo Baroncelli wrote:
> > On 12/14/21 21:34, Josef Bacik wrote:
> > > On Tue, Dec 14, 2021 at 03:04:32PM -0500, Zygo Blaxell wrote:
> > > > On Tue, Dec 14, 2021 at 08:03:45PM +0100, Goffredo Baroncelli wrote=
:
> >
> > > >
> > > > I don't have a strong preference for either sysfs or ioctl, nor am
> > > > I opposed to simply implementing both.  I'll let someone who does
> > > > have such a preference make their case.
> > >
> > > I think echo'ing a name into sysfs is better than bits for sure.
> > > However I want the ability to set the device properties via a
> > > btrfs-progs command offline so I can setup the storage and then
> > > mount the file system.  I want
> > >
> > > 1) The sysfs interface so you can change things on the fly.  This sta=
ys
> > >     persistent of course, so the way it works is perfect.
> > >
> > > 2) The btrfs-progs command sets it on offline devices.  If you point =
it at a
> > >     live mounted fs it can simply use the sysfs thing to do it live.
> >
> > #2 is currently not implemented. However I think that we should do.
> >
> > The problem is that we need to update both:
> >
> > - the superblock		(simple)
> > - the dev_item item		(not so simple...)
> >
> > What about using only bits from the superblock to store this property ?
>=20
> I'm looking at the patches and you only are updating the dev_item, am I
> missing something for the super block?
>=20
> For offline all you would need to do is do the normal open_ctree,
> btrfs_search_slot to the item and update the device item type, that's
> straightforward.
>=20
> For online if you use btrfs prop you can see if the fs is mounted and jus=
t find
> the sysfs file to modify and do it that way.
>=20
> But this also brings up another point, we're going to want a compat bit f=
or
> this.  It doesn't make the fs unusable for old kernels, so just a normal
> BTRFS_FS_COMPAT_<whatever> flag is fine.  If the setting gets set you set
> the compat flag.

I don't think that is necessary - I've remounted my filesystems a few times=
 with an unpatched kernel, and all that happens is new blocks get allocated=
 without any hints - I like that simplicity and compatibility. As long as i=
t's mentioned in the docs I think it's fine.

Having a balance filter that only rebalances wrongly allocated blocks would=
 be a nice addition though.


Paul.
