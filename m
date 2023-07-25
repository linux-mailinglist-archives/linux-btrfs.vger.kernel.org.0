Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7701D76099C
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 07:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjGYFpT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jul 2023 01:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGYFpS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jul 2023 01:45:18 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D171BFB
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 22:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690263890; x=1721799890;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5b7FvooOY4ki4izNRlrX96UaC2X2LaKRXJ2cH4sq6X4=;
  b=VPH7bhzzWnbnYoiMyvnwhd5VUomkhj88vZT2fao9RPZ8lrLFmZYfRZv5
   D1T8E7jQxacrjPvsenGi4eZN2dA1+dlLUlQpvZpHICskUHcn/VHy8jnzm
   +fKTY9u+aj9XNoImcfIwNuoY4gHK+CUHlnBeD4ZAhULif5NGMq9PISu4o
   BAkEBFE7DtgdBe49/qG9snGsj2XMg2vvvof6Vh5pJwRMI6nLkD6Cd/VAq
   PmjXgMXK/xrb0GRy2jNvxWaDxn4xCoGbnJy4XlO1tLRZUgnqg3fFIUEjr
   XPy5siOKdnH4Z8dF9Vf6H200s2Gel62/36WRhrlADKa7PldikW23pBWU9
   g==;
X-IronPort-AV: E=Sophos;i="6.01,229,1684771200"; 
   d="scan'208";a="238787062"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jul 2023 13:44:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSCmUgDzRup8H3z4ltAF4gwFV51xorap3TXKsCt84MBQMYKk6lgl/hcxCqmzvzMXhX2bf/2N+ZFPYglBRSu9EJXkTyepQqHwvICKmpXLcw8TFRDxNe9UZdjpj2aA455Z29XHhuu8sU9jJieFsiGzy4y2LmSDH1BXXvJMwedTvqdvKa87vwecEax/nOkvLxZoLRq0Vh1TquO9yb1WIKogdjzxXDm6Z+3tY3YIOJ+cYUNpxEWaQn437pu2h93183UoZnn5Erxd7YJkrGoiLvXZO3/77Fc2hBCHy82F6/aqig9oBps6G8JjpHg7vm1NSUiOXKrJuzciWlf9zsD0Hwb0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prHAxiIBp/tDTky+rQDKqJPT3HwI8npYOHygG0cyNMI=;
 b=LpqFgOb9UhstZCPWc7cWNZIJwnN5a+Fysi9T/SyZtI7WHWA9z+5HTss3F4sy7CLEm/mRmzs1zFWDcVW95k2AcmkF7SYpgWpQN0K6Ph1RtjMe3XPqSFypVprOzXMxxg6y71r6mYFvE/oZ8TCSjoBlMc0WEwlwq2fBxCa4aua3iFk9thbEKj6/toPykT4eLeCGhoIdnWYEDNd0XEKVOmlgs1Zh2F+/3UoML/Be2uPMLBIRWckc6GaQZEJW1hree9woAAuY2ObynEC8pCXtrWkM1gUXJ52xen4bH3T7c3ccyfcy9XGZAMW8+b80JDZv9nQhLwXFTqbh9Jnmf8vdw8CnzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prHAxiIBp/tDTky+rQDKqJPT3HwI8npYOHygG0cyNMI=;
 b=LIQP6yNjWx16go2LMFdB0QqppdpLuT/IFLQ2Aw1M06q4/j5+CgsOzaTkxhfzG6bb+vs10v4BkVBM3wOVg9muNQUkK542b95bAHivOdsHFQRo6FvRzR6VBuZBQdxIrBlD2OPKl+UMp4QN/+l/Orn5WJzhGz/7ZGn4t4urdQTnupw=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CH2PR04MB6710.namprd04.prod.outlook.com (2603:10b6:610:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 05:44:18 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::95cf:429a:bc0:991]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::95cf:429a:bc0:991%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 05:44:18 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/8] btrfs: zoned: introduce block_group context for
 submit_eb_page()
Thread-Topic: [PATCH 1/8] btrfs: zoned: introduce block_group context for
 submit_eb_page()
Thread-Index: AQHZveX8yYW8qBOnok2/xrjejr+dP6/JA0EAgAD3DIA=
Date:   Tue, 25 Jul 2023 05:44:17 +0000
Message-ID: <rjlh4iji3lwx3rvj6jskju2enhqspoipkcmz4ewyltinnqi4gg@sagltivywtcx>
References: <cover.1690171333.git.naohiro.aota@wdc.com>
 <d20226362b9b193d85f63e81ee128ef3062e2203.1690171333.git.naohiro.aota@wdc.com>
 <ZL6R9OwFlwwmrcKo@infradead.org>
In-Reply-To: <ZL6R9OwFlwwmrcKo@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CH2PR04MB6710:EE_
x-ms-office365-filtering-correlation-id: 844dbcbf-eba3-47c9-b19a-08db8cd23001
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k7GkuV6rT1G9gueOQqKJ0a5SlVQUUoy93aU3I3buMblz3ofhGw78ABZ3evFqi3XOkHMa+g2DKRlWZ4U4WOvCF1Hame/8Si7rB/gbEqF99aI1AGDncJOmE61ga2pPcVfTUeOBMmxjBalCtzPFBj+bzn7IiwXyOLZXjblTaSYBKubl/3wu4EGL6jXcOuGZMLJk6abHzG+MwAkk47KLRoHaSaweU51H55Q6ET4p5yrrA/85MWoSGX+WwqOOXs164XO0fNTHabdisaPvgoA1zyuXWWzaeU1ur1RSPXn0+aJ96KE+zt/G9khJeUOru2kqGefoP8DdiukTZneSuKeRGM+al/G5CBcdAude4HWTXp/3oXShbMyg6SW4/4gpfoEKi9VhhzN7gH4skacC9JQyaZS/a/n8tv667JTse+f1EOMV2GP8gHVSxje8qFR7Npkmeqn9UyuvG5Rt6LNjvzlCsOR16XRufzD6Ves7ItP1VsUAS7+4If0NLkZj6NhFGsRQW3aqR2fh4uy8kFRnVpZg3HIZgKSlBXPSy3CnrEzIsS3OYnbpfz7SYzJbaLvS9l8eFACzMf3h/Q+pUCfptnjWiyHrLEZBmPdv1LLK8PeCE1InyMNiOVflC3SbOtRgqrd6dyF7V8L247groXa5QeUHfA3KOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(33716001)(64756008)(66946007)(66476007)(66446008)(83380400001)(66556008)(316002)(6916009)(4326008)(6486002)(9686003)(6512007)(71200400001)(478600001)(186003)(76116006)(91956017)(6506007)(26005)(2906002)(38070700005)(86362001)(41300700001)(122000001)(82960400001)(38100700002)(5660300002)(8936002)(8676002)(66899021)(27256005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?atZUHYRkvO8ICoJWuRZzGBQmv9gcawkaNlJRggCav23S+Oy3Krcf12jxcOI9?=
 =?us-ascii?Q?u8Z8tTxLxkl3DuSFkerOYlLgMY0sokTbZXNgvHm6bNGqigdWrfN+35DpKpYu?=
 =?us-ascii?Q?Kmt5YN1qgAt3KAILvV5sLBANgkREmdZhyv9LmBc53nEQODBzfjkyWc4Zwj7L?=
 =?us-ascii?Q?h3xJrIdnen4Acw/TojGdxkwe/wlFr5zQ3gPDa+yoIZT9gFUwGFRDKXhmzuE+?=
 =?us-ascii?Q?pvsuvU8ePtyEiyAY4OUbY3wQbJLxX+QEd4w1O3fi7lO5DvoJzfFeKRdUZEQp?=
 =?us-ascii?Q?W8rRu3pOfXkAbAR3WC911lzrzczqDE27lkQijPVAq+PKvVd3IZ5hhrbv2uRW?=
 =?us-ascii?Q?PX/m5Ic8qWDP0EBwXYDxQ58e1DgXL2+4gtW98+wJl9Rn7F8x3vKwqUY9SYmb?=
 =?us-ascii?Q?U13xsv5Nvy8JPWvBDq/SBF8edgOl4eqMFNBKo1QMftQzz5hHtAdHvzTFjwHc?=
 =?us-ascii?Q?3q3d3uquOa0RHkwAxfUZc+20UyI1dd6Yb8FsuaeB2F8Z8gkyvtiqIZU0TAfa?=
 =?us-ascii?Q?E5oHHOO3wcWul+zwk/2SWX/0DU1WK6ajgZhf/tUW3dxK5j8B7nLqk4j1U+jJ?=
 =?us-ascii?Q?hhu1ZL6fK4efTHy4LQYDzHKb+Cefdgr61f3I/V5zJrWQSFyInRjrzEoEzMIR?=
 =?us-ascii?Q?DoTA/CFJmcOkLvuzsGEPaGIY0jVzeHpic4OpJN5IB+7QcKNtDUu6qMTNpgRB?=
 =?us-ascii?Q?TcEg/3gDR/hFUrghi6Cmn/0OEV7OSEEjX8Ci+ph/I+/9FMvkg5VVqGPeP92h?=
 =?us-ascii?Q?Qvev8PF9tjBi4I5ZAm4iiVCnsKxS69wU4lKomqnLQzrYec5nkEJ0ay94zUUc?=
 =?us-ascii?Q?7XA0C8uBPosTnWZlkYjIoF/x1sDRT/uoK/4rRCj+tp2XXFr35QXupCFx7eiR?=
 =?us-ascii?Q?RtBEX/jJH8I3yrW5FlJuhENdyimjeXg8N+ygOgWs580dGgmBO7N1ws/jN8e4?=
 =?us-ascii?Q?GAG6XWkPRk8x0OooZv16aevyRQUNOrjrd6Iqml79TQzp5puRhARdIvLTtmR/?=
 =?us-ascii?Q?/f7cUwneboobM6tb5PV85Vgp0CkCSSZh9Qmuk/h6j+ITz4pEJc8TSz7/0Ny0?=
 =?us-ascii?Q?cZqy93tmNzULQZK/o8tyVpbLVHgLoZvveDWgXsQxDwjOv27Lxlh5M4lP0Z3J?=
 =?us-ascii?Q?WLFC3zMj0LPUlgNrq6d754QkqCMsJWuWpl2c3vNqZqEp7phgoJ1Vw3gyF1ds?=
 =?us-ascii?Q?TXeBtw6DnQ+kTa9rtpEU07PrpiNwJCI3Yn2MGx+j/rSCUsNzvj9kX1zWoBKn?=
 =?us-ascii?Q?MjEXHk7wUIgwpNn5UfCJ5OZk9gWaLPXXi4hSPRDwO/k55WqZWWJNSoRqyreE?=
 =?us-ascii?Q?DWTSTLXKab1tRIhomBRtqZJWZ51jrqO4EkpG3nJ0JoM/fQ0gMhkmTKM16G6x?=
 =?us-ascii?Q?Y81Ovy0YqQPHOVjGaNcWIZYQoLJM3gDkay0g6ootc5bPD41f7I+snMuEqH3X?=
 =?us-ascii?Q?dN5eNrIFbMvQdj1JxLfu8lQGg5poiVUtBm2gLgOR4a8SGFjQeJs5dXbITx3i?=
 =?us-ascii?Q?IOUO01lepQvmY73h2L6qOKq8AJcq0JqPN3O5w1g/qnzpjBLlxlvahOGNvfVj?=
 =?us-ascii?Q?TJfGFCY6brjoQOm4nlmvyXCLAcKnJmttqEbK3cp4S/pH7sn3RqBNQSevIIxU?=
 =?us-ascii?Q?aQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EBBAF8FA692029478B83C35B6C88B2EC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: McLvUUyvoO4G2LylwWukXWuM8fstnvrdtNBypeRhsTiBdHaRjTz4SVeOGnBgbbfFEULkTP6mtzcy28h8uYQqW+Oa3tCo8O3NkFjzohkX0xt3kSbSOLXb5BPmtzt5f/aLPQZLT7uVCgtDlLa6eQu72GyhyND8GIADgP1NawBkfIkDb5ny7cYnxMciod/HrS4wONWYj/R+FB2Cv0nUDz0eRxLDuknb1PlW7h+bS26oRKcs/3kftmdHrBiZrSJXA+BGIC4zQgG+s9zc1Nme2WvWNYg3Xq9F6AtAQDIGIge9Y1JvLCGdH/2LpGhm+Or4h7L4QQUyWNgGGh9xHtR45hAMe+phw/AlfnE3gBCJ6BOS1dTCNk79HR8NiZM2aQ5432xOpDPaHgseNwHZj8b474r6sM5Z/xZ1mjl//KtgCLup5ggCUp150uK429TLWfkLggK+wMDJlO3fxmrNo3FfWsw8CaEWHdcqfhM8sBhAJftDpIFj228xQLJWd2piYW05tfFq0VSfuCA5iL0q5gtCPcS7RtzRzMVzh9IChREJhSTtBfa4qovqFCZcwE5OcPuoDIQTmaUZXxgJiFGsdvg1jJ3kLpgFoUXlqQNRb8LreRszVDmb7XekoAJRuDjW3YeiUr29faaJGW+/2dL8ZARLb58F6mWVyslvClJT3gmoshQJK/hQpcJ25MMnLeHtTRUyAW/66geES8xCAfkAFoJmVBHLCDB+srhVGCgFGTLxod/Ocg+eLE9lv36QkVHAfwDH5qSwABRR8xdJCneNTAmFubR9Q7j3pcjAlVihCYD39DYmdiniY5U4ilAXIsLGt/DSdGIl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844dbcbf-eba3-47c9-b19a-08db8cd23001
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 05:44:17.9451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Shb4AHod2kGz+0JTulluf/JPO1hRXg3Y+G6lnau1dAa+hfO2LZwJxJ84Zgv7SnpsOkD723YR4n4I30vRM1RjjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6710
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 08:00:04AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 24, 2023 at 01:18:30PM +0900, Naohiro Aota wrote:
> > For metadata write out on the zoned mode, we call
> > btrfs_check_meta_write_pointer() to check if an extent buffer to be wri=
tten
> > is aligned to the write pointer.
> >=20
> > We lookup for a block group containing the extent buffer for every exte=
nt
> > buffer, which take unnecessary effort as the writing extent buffers are
> > mostly contiguous.
> >=20
> > Introduce "bg_context" to cache the block group working on.
>=20
> As someone who already found the eb_context naming and handling in the
> existing code highly confusing, I wonder if we should first add a new
> eb_write_context structure, which initially contains the wbc
> and eb_context pointers, and which also would grow the bg.  This
> should make argument passing a little simpler, but most importantly
> removes all the dealing with the double pointers that need a lot
> of checking and clearing.

Ah, that works. Actually, I previously used the bio_ctrl for that purpose,
but it was removed from the metadata context.

> > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > index 5e4285ae112c..58bd2de4026d 100644
> > --- a/fs/btrfs/zoned.c
> > +++ b/fs/btrfs/zoned.c
> > @@ -1751,27 +1751,33 @@ bool btrfs_check_meta_write_pointer(struct btrf=
s_fs_info *fs_info,
> >  				    struct extent_buffer *eb,
> >  				    struct btrfs_block_group **cache_ret)
> >  {
> >
> >
> > -	struct btrfs_block_group *cache;
> > -	bool ret =3D true;
> > +	struct btrfs_block_group *cache =3D NULL;
>=20
> .. and independent of the above comment, I also found the "cache" and
> "cache_ret" namings here very highly confusing.  What speaks again
> using a bg-based naming that makes it clear what we're dealing with?

Yes. That is because the original code was written before than
"btrfs_block_group_cache" is renamed to "btrfs_block_group". This is good
opportunity to rename it as well.=
