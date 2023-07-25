Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DACA760DBC
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 10:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjGYI70 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jul 2023 04:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjGYI7X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jul 2023 04:59:23 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643CE121
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 01:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690275562; x=1721811562;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dJ1NMs6hWkujAYbXFWD0S7Wxg0vSQgENrr27EZQuFPs=;
  b=Ug+/M5NSIFHWEXUEJE00A5VcOD/G0/h89QHTUnQb1fRSt+0E0f/XHww8
   y7f/OF4rGzDTlrNnRKXVELHJyvcjNNefeJiwVrOeEda2HyiCmh5+Wm0sc
   44Vc48q1F7kP+vH2/20dVKttvMr2wqybXNZ9fME4kjfF36Xvh5cPwNeva
   7BHZg8IzTCyVKurgoy2db9VaiJ7x/r5pCVlSTZoKkL0pd/IFZIyaWmysD
   WQ1SCfzznh11kTMKMnPPtOW+wDn8xnUUnMKO6JWPOe1JUOXPtzq6AVTtg
   nHAaDlKYYYVVqgkRNn2piL5R/8og647H4yUPjGyHGtHD12homIATnNq55
   w==;
X-IronPort-AV: E=Sophos;i="6.01,230,1684771200"; 
   d="scan'208";a="237354513"
Received: from mail-bn8nam04lp2049.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.49])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jul 2023 16:59:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3frGDHFEYX0+7sgbEvBs0gzohLgYL4jaOrpk0xBJAiR4LntKF0fGtDDh/xxvG6g84eL6kXAWyUSgoxZGmSG7ItfET7LirlxxPcgBIdMz04eN4FNleNAGWGDhN5vErMcvWN34Z2RdhSrheHV+2see8rKz4b3ukb6jiJ26Q2f/B5j3Qihb3YNi6BXLNwCMIVz9UEKiGa1s79mVRgI9KcHOQMxV5Gcu9MJbpcPx/rENYyZrfSbo7ANPjn7RHOOlpn13c3vC5sz7r3yerJDy1KpKzzcVq+wbNKGjBrNZF9S0Wgb9L42LFymSNSHaA/yFmyYdZG8LYuB/KbTgpviYOWNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xa/827sXWwT6s23Hf754NZ/JEytl9ZOQyxEqszZGYkQ=;
 b=ivTWbN2npta/a8ZXMDHubashpAf58t5/P+ovwd9F7O0IbUB0no2VD96+pJ3p4lCIkXhmBl15t0R8aUcKTyRd7sn6Yej4uKyZLqh44HzPJrLr8YoMbQ7awNEt9T89K41bhp4gsCt6ueGpI6LXsQDAG+PzUX+KAUlbCYCsyjkI2AThYI4yDo6dpRR+MK6OWZTjISI5C89O8kkgJrDKqrsblgwdyqcxBZGCjZT8lAK7Hp8Ptc2wEnHWOOvRc33iQHm1U2UigiuQGkhiHmVZrpgOTCvkEfAjg4YNmHxSNISggLfTlKhuxqH+1lAyfpndwO1YmXmkoKnBF1C6XA7PdX7puw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xa/827sXWwT6s23Hf754NZ/JEytl9ZOQyxEqszZGYkQ=;
 b=Oc5nBZgiuzWcPxlZ8cVRIdwVRCY42h0JjiB0TERC2PFpV9NCicC4th6wdYZWsIl1kuFnOv+CM5OugveDb1XLZIf7wc62U25+ERmzsbvUwmd8vGwvyBcwj42lB2Zn0UW3muvrJZdyQ7eJvb/XPo8GuRjPI0PIZKCgi+yt7Mgr4ik=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SA2PR04MB7692.namprd04.prod.outlook.com (2603:10b6:806:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 08:59:18 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::95cf:429a:bc0:991]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::95cf:429a:bc0:991%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 08:59:17 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/8] btrfs: zoned: defer advancing meta_write_pointer
Thread-Topic: [PATCH 2/8] btrfs: zoned: defer advancing meta_write_pointer
Thread-Index: AQHZveX8i9uzeNDGGkqgs3DEVE3Cv6/JBGcAgAEsYQA=
Date:   Tue, 25 Jul 2023 08:59:17 +0000
Message-ID: <2m2mi3l5aiiwugv4s5lrxal45eydjhps6hvsegkh4nz7g6qhwy@agymo4iprypn>
References: <cover.1690171333.git.naohiro.aota@wdc.com>
 <0c1e65736a8263e514ffb6f7ce8dd1047fbb916a.1690171333.git.naohiro.aota@wdc.com>
 <ZL6S6mGdlgQCswQz@infradead.org>
In-Reply-To: <ZL6S6mGdlgQCswQz@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SA2PR04MB7692:EE_
x-ms-office365-filtering-correlation-id: 9bb62910-9d13-40cc-4085-08db8ced6d8f
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CQCJ6qFXqlg9sjSuZgjaF11GvJAJS+RFbwgOoYLl0jGSVfrXjvMZWGcv1HZCjFqZ+fPiZVQ0stKFrE4ast7iue4Qt0rdyVo1ANgPQ46XZqYDfAig2iTiKF2hIrZUSexpyC6MvZ8jju2n3xjk1TOIU8h+CCGvZyZGU1CmZNwNbnPUc1DZhE1RNxVqiWMplGdBT70+yMVzPPuy/8HjTpXZezCOYWZGA83kziF63tmW0TaKMvDrg0AoSot5P7NrLkdsHPj6hN+8CzznEZPgfBCLluUrb4dHvAWk5j2B+VdAKgkMZ8rnnIPSSltJiBcWDycdgHCxKMVL/f4JUJg3FOFBDvN7vAsiWWS+Lyx7UGN1s2AGvpVXvFBEH2mRVEb22PlobyflWJ8kBPcJURDOiQTL/IqgiTj1b9ta+vErEOGNbQd+ACzKp2YGjQwx968BMJxaIR1Bvd4dih3LMkmIwyO6LIxjzNPZ7aa9jfYOI/NZDaL6lw59uSBLSLVV1EPdk0eRn223UivSljyIV/xDsSm2enZpXC1yxHCZNwk2z5cPEYnEWuBtN5ioHoEtG83NhI4oOtyehKSvNbjTR0HacFmrdhSjKmdG86Bq6sEzgLDtxD6WDZ2JAmelRghQDazIg4gU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199021)(5660300002)(83380400001)(2906002)(8676002)(8936002)(38100700002)(6486002)(6506007)(122000001)(478600001)(26005)(186003)(41300700001)(82960400001)(6512007)(33716001)(91956017)(66556008)(64756008)(86362001)(66446008)(71200400001)(9686003)(38070700005)(6916009)(4326008)(316002)(66476007)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IDnTdwEgfyPX8wQW2iCEl67DV7NIzF2oXCoQ1/WaegCqG7ZHzvapuDOSGgfp?=
 =?us-ascii?Q?NE4BMRTVqg9NtRGq/tNWsgy9/Rrw6vtiB+NOZitX2b2kTb+VFAL7cGDdp4/n?=
 =?us-ascii?Q?ISSXSpWmCR80r88RMK+PSzK/xbWveNy/O4o98G9upUm+dKTjxlZ8aSFXAZVK?=
 =?us-ascii?Q?toabfsKmeisy390/21jrkaZfzD0YVmBq1KwvvI2pKkfNu74zlIqlMYTlfaFe?=
 =?us-ascii?Q?TRRCOSQ5C7y1vd9IJX4WJuBSiQBNngHsltLClA/KDB9szuEBgPt6lJBvvyK6?=
 =?us-ascii?Q?n+km274HKEiBWfM3+K2k7K8Humn446cUayy+3Kx+SWgo9RGjJEjjIYoKZhvh?=
 =?us-ascii?Q?IEON6wzwM9iCvFP/qYLZb0HjwclZaIWkP3FUbVlFGP6rRFFGKv3Sb30ZQWeF?=
 =?us-ascii?Q?TY1wBeV1yu/++BWQIc/gCjsrOzu+/S319yoN/vSEg5N77H0UYNwXZ22Ub+HY?=
 =?us-ascii?Q?gG7HrBSBywHAjv/81c1iK5WqjNcUNlG8Ix3TNgyFyerJjhFiCj2uDIfj7S1R?=
 =?us-ascii?Q?HX8rZ1MXKO+FTO8R6aslCcaUf5AOZZXV+4r734++J0RLmc34l5Z4b1csw11y?=
 =?us-ascii?Q?yEtQhYyLEp7r/u55/5M7u5rpLgbEOZvprHrPqy9X6gQ49kXhFXj0JjAikG7n?=
 =?us-ascii?Q?Y+1+IUDhnwY7zkbLt1P/UBHGzf6XeaqNLGQEqtzsARp3VlB0hP/ln1JimQFI?=
 =?us-ascii?Q?ynep5QeShk1J+p+tHpaygiU+6x6Br60yRe3rnD/viR3HYePFyyyCtuIt22Yw?=
 =?us-ascii?Q?tKazPFqp2K1d5cl5nBs5/kS7KGoCVy6xwrgLbjRToglyQc6mx2T+w+g18v/p?=
 =?us-ascii?Q?t8kgcrGo39AxSXGfXiD2EetfqUf1XS66uBRwyPpzik4vgRgAJvlyTUsOKCS7?=
 =?us-ascii?Q?F2XEN3KhLUmAhBKxhDmSjmRjMuO1OsI6aT/7F4tO0d6bnma6SfMVrXNxfF42?=
 =?us-ascii?Q?r15YrquY1X831jWFZQMxV5A4AdqPNPXsFegO2zPvK/WxD+MrAmtYDs/a1jfb?=
 =?us-ascii?Q?SaW2/waZL8Mge0Q5igRPrikNxTtvj67jOLl3wj9pPgtCeVpeqH0c5AUG/lRl?=
 =?us-ascii?Q?OC0eXc/gsjzJiPdnQnh45Bczz1St7d2jXL7aFpWUrxKfSSInfEuUklxxEXY9?=
 =?us-ascii?Q?0p0gMM7k2D84iu1TVUSlCZcR/qjkW6wUsA1i6jUPGwqBJgfAWb1Gy/mWSV5E?=
 =?us-ascii?Q?oVEtpseODU7NKuaNPmW56DPBbGh1bqC+pW0WQ/XRtb8Qc9Asl34vz7jYVcD5?=
 =?us-ascii?Q?CwBmRb42DwkqzeNqge6jkzUyaQvetohMpJ1utocFzSrr2dOiK9AB4xV7EQbC?=
 =?us-ascii?Q?iLbAvmK1JBPWf4v0hWDqjOStLcuqJiTFp8llRrCrQ/wWG0jHZNqgJ5iQWqXn?=
 =?us-ascii?Q?yGP5uegzq5CLc2a+pFb5dNUtIxMHtIrsOatf01twOSrZhsg5fxm91+kCm+FX?=
 =?us-ascii?Q?ceCOfnRXAExtIrR7Ho+HFXW3Y2W5TjuKjgoi9qK8tFJZD0j6obi1V7MuZJiN?=
 =?us-ascii?Q?cScgqMbNoaDeX6Kxw17t+MTYMBd0D9u8g8goBBguzUGCKGQXw108xTaLFDn/?=
 =?us-ascii?Q?NHAy3oMF7bvaB2NXgULPF6vQom4uhb2nHSbOmpPBdAx3dLGEL+avmVySkDob?=
 =?us-ascii?Q?FA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <35924E88D8EE504AB190FB4ACEC8E5B2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6MbtlvT9bJglmOh5MhCBI0UqJSF1jM6RLtan4xk9P9HNNOLgczLz+Kdkr1H8OQTbbo3u31WBLy+q70jGDENKR50X1wSRaZB0RvwA0/8827uSbt/GfrNchUSqte81lqcrWXdH30V/LQzWi1tC8omwIk52ac5U3FwCsxs7UsxcGWHOhqZH1FE7J1QQbCBGGkjkYfozQ/xp+C2iHMDGmnstKbT1V4DnGAN8UTQrh1h07FraxIUysnMrp0PWhzaaUwGxljTPUTOOV4Ye9IIhfAZ98Y3Hihl9aca1PBpe1ywrsDCM08obLspju47iIEzf2g8dx6F8voMU7k2Sw5+g0uM/nfvUZVyrCHEMNGrxyx9kcuCZmyvbZXn2TEdE30+UuU/IIx9YKnfs7MxEq7W0bJzXHy7CqjYprmlljYEKni1RJvh85A5/3jT7g6/wlu7Qjnf/wk+RR4swNIbthd0KgcNPHB8IPwZReb2NkCPhtHi1w0layrzTVviRGOkTRhzUsncASZsEY9EY51HTTYQfGFL6VguB5VnL3TyFHrYZPa+MgPF1fG36TARQsdYibnpcoGy6XwpYb4FeW9rlrzO1TwSm607M/BBFe/Kv5Glfzwjs8Y8l5Y2eJ2cf3ht+TnRyfiKgZkA7bS64xMvhXpSnQBHod+JsZVDu8KPnaysTYatkSETOxyQbXBckV4OyRFrWM0XKuZWhwaSM9C8GT9Xok/LJ38C3szhWgw6yi0uUxflDE4HldAvACVf4Zux3iUAAiqKEL5wt9w5zunThLJH0SPTzjcZ3z1VjRfaT2rcd01RGYl6ikcfyOerRXvV7QG+OS+vJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb62910-9d13-40cc-4085-08db8ced6d8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 08:59:17.5828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SGM5j1/qk0w8XENPjr58S9JI2h1sHVIiRuzJNJz0yAqhKwC63CbLKgPwHHcvbZY5ErkRpPeENolYfNtt686bKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7692
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 08:04:10AM -0700, Christoph Hellwig wrote:
> > @@ -1773,23 +1773,15 @@ bool btrfs_check_meta_write_pointer(struct btrf=
s_fs_info *fs_info,
> >  		*cache_ret =3D cache;
> >  	}
> > =20
> > +	/* Someone already start writing this eb. */
> > +	if (cache->meta_write_pointer > eb->start)
> > +		return true;
>=20
> This is actually a behavior change and not mentioned in the commit log.
> How is this supposed to work?  If eb->start is before the write pointer
> we're going to get a write reordering problem.

This won't happen at this point, but can happen after the write-time
activation patch. When one process wait for current metadata writeback to
finish, other process can take the same contiguous extent buffers. That
region will be processed by the first process, and the second process see
the write pointer larger than the extent buffer it has.

In detail, consider we have two extent buffers (eb#0 and eb#1) to write,
and they are going to a new non-active block group.

Process A                                                        Process B

btree_write_cache_pages()
  btrfs_zoned_meta_io_lock();
  filemap_get_folio_tags() returns pages for the two ebs.
  submit_eb_page()
    btrfs_check_meta_write_pointer()
      # unlock and wait for the writeback
      btrfs_zoned_meta_io_unlock();
      wait_eb_writebacks();                                     =20
                                                                 btree_writ=
e_cache_pages();
								   btrfs_zoned_meta_lock();
								   filemap_get_folio_tags() returns pages for the two ebs.
								   submit_eb_page();
								     btrfs_check_meta_write_pointer()
								       # We may still need to wait.
								       btrfs_zoned_meta_unlock()
								       wait_eb_writebacks();
      # Now, writeback finished
      btrfs_zoned_meta_io_lock();
    lock_extent_buffer_for_io(eb#0)
    # write_pointer =3D=3D end of eb#0
    write_one_eb(eb#0);
    ...
    # and, write eb#1 as well.
    # write_pointer =3D=3D end of eb#1
    write_one_eb(eb#1);
  btrfs_zoned_meta_io_unlock();
                                                                       btrf=
s_zoned_meta_io_lock();
								     lock_extent_buffer_for_io(eb#0) fails, return
								   # and, proceed to eb#1
								   submit_eb_page(#1)
								     btrfs_check_meta_write_pointer(eb#1)
								       # Now, the write pointer is larger than eb#1->start.
								       # Hitting the above condition.

Returning true itself in this case should be OK, because in the end that eb
is rejected by the lock_extent_buffer_for_io(). We cannot simply return
false here, because that may lead to returning -EAGAIN in a certain
case. For the return value, we can move the wbc check from submit_eb_page()
to btrfs_check_meta_write_pointer() and return the proper int value e.g,
returning -EBUSY here and submit_eb_page() convert it to
free_extent_buffer(eb) and return 0.

But, yeah, these lines should go with the write-time activation time patch.

>=20
> The other bits in the patch look like a very nice improvement, though.
> =
