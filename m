Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7A0553FCB
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 02:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiFVA44 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 20:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355898AbiFVA4o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 20:56:44 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF72C313A7
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 17:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655859389; x=1687395389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=v2eROkmqJnxKRIb/UTEy4ak4IrgexzgubRoxOZzT46g=;
  b=UIkbz5BqdshY/HAS6RIg7JwVFPqSfoZuvyCdVNyEi7dazdaAAQj1ramV
   ojmDt1vviTSUBllm9IQXZ+r+rj2Do3SgC3XdMNHYO/cX3zN/z8oqjCNMh
   WO8sYc5bUu+YarhYzeUvfOUFdsJa2azPf4DlKkLrFMPfam3heiz22ITZO
   Itrcd5qLnrYfbfiyD+zg5l/7Z3MHbA6Dd8U6I1yvWT2W+QuKVqu8Z1yQF
   /bkddzZBkmanYWsqbqn2gnUXC4erL5JL/lffT16e4xbf/fqVyuEk63JlM
   zCDg269uvM083lj67vzxi2s4US7HzWaeJJ2AW5jdNuCgP8USlOZy8Of3C
   A==;
X-IronPort-AV: E=Sophos;i="5.92,211,1650902400"; 
   d="scan'208";a="315876750"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2022 08:56:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAy1lQN6+Yx+nRtFy2WPcvDQrjYbNjb1nKlX1XI/Ag9qaJPPfFqvbcUs3v5cDv08jfGiGMozcJj3q9E4Ifzl3naaVy/FXFfR5SOj0Tn5JNaTbHjHn3bQMEAzg/aCxAZcjAGW9d8KFBLfOhW2l0bnWppcxTzcxu8/wFW6ig1ZKkEJGI5uSz/S+famx++fANck0BYqmvpW9mn8KYjkVrmgcBI8gMT2DHZPdWLcnlxANyVxU1RiCCfpap1FkTx+Qz384yj65Rs/lSh+Ke6ypl2kKqZLNcUQ+Znn6aWSTG7WlaKdru3cPNV92cW+cwdfcrlXf7/gAlt8NQHBy8zh9YYMWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BU2ATasHHDQPN0W2VI7TLCZszwst1y3rEJ8fm2F74c=;
 b=XPU0XLPhUCyKirjf8+AOFW6TGOjPObgrGs41q6sYsuphYIae0mfOcPCIX9pWyg0n520fbF+274cWKg8xwIli4tQmp6YTMvPwq6v8Y5PDajcqaUkKavYFLV5GXZQwik7UGVA9IHpS4xzjS+pCY0hRd+um+yLbFKYRYi0LJQ53rZMWXjtxLYCGK9SioEPr7R55VzO5QRoXgiZZtJAzGcD52Hpmx87ZlSDvAhPjErm7/P/xEZNr1vRC09blO0Pa/9KdqbfqSpfpcLtCksJa0gbSDMrOwe9O2wAdBbmD3TdVaR7jVioWdW/Uc2UuQ8W60uaBah/Ux+LR0rySKxtIPTBn2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BU2ATasHHDQPN0W2VI7TLCZszwst1y3rEJ8fm2F74c=;
 b=YAgm9bwo22Y2qK0z1snLZgZjBrLOPs/jxaCWy12wSRNsz6BFZHBCl/tDnBW9jKWtaJIUieYB4eoUU5vdEZVsgvsOaJ8Ct4qJnO6nnPjvzU8CucPTwWxJIXsStv3rCCbC9ap7YKwzLOz7khipDm9F+HBafih94VYIpmT/Z7RszbI=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SA0PR04MB7179.namprd04.prod.outlook.com (2603:10b6:806:e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Wed, 22 Jun
 2022 00:56:26 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::9865:ab44:68b:5d5e]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::9865:ab44:68b:5d5e%5]) with mapi id 15.20.5373.015; Wed, 22 Jun 2022
 00:56:26 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] btrfs: fix error handling of fallbacked uncompress
 write
Thread-Topic: [PATCH v2 3/4] btrfs: fix error handling of fallbacked
 uncompress write
Thread-Index: AQHYhTpRDJV6X7tCmEOKAVwGoEQi261Z9eIAgACldIA=
Date:   Wed, 22 Jun 2022 00:56:25 +0000
Message-ID: <20220622005625.egeljuu2o423wv6y@naota-xeon>
References: <cover.1655791781.git.naohiro.aota@wdc.com>
 <7347f1de449c3a3f36690b816c2ded133508c5c2.1655791781.git.naohiro.aota@wdc.com>
 <20220621150414.GA23327@falcondesktop>
In-Reply-To: <20220621150414.GA23327@falcondesktop>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c17106d-97dd-4f3e-52b8-08da53ea08ba
x-ms-traffictypediagnostic: SA0PR04MB7179:EE_
x-microsoft-antispam-prvs: <SA0PR04MB717951338FE74D99244607828CB29@SA0PR04MB7179.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iHx+jAIvPHS8nJbfEhTwPS7eDMO1pXydtGWBsODwqEAAMuTAI4Zn4K4vxza+ZqXiHol0Gv10i5S0P3ek0u2bYgYpMDESbYD7Yf+C4iOUd6qDmOPvj0zyIfISSZqD/0bWuyen1FMWwPkx3WVzGddiBA1q2tPTyuldQhodv9RIeMsMi3c1eqQEkimPqw+F4j+jszou41ROjOv4b4lnW1maKpaQhuol4aRePV8mS3/taHv5yKrdmz5QGMfJlwhJgkbkwxoZ/fD3xd00SBqfoBj/z2dbYUUIJS+MCc9DfJaQ+WrAJ19fVdgLLWRY/iuuQSwlJEkJzum1H1TLQu6pknb4lOwyjGBZgg0NTUpd0/gdD4r4ju1+bNLNX+puF64IYMBJVIIFU1HrSKdrrptfw+2iHsgZ3owBUe1YjPQF3jOiOpNWgoW56RX9yfjuQKyaXSb2AiL4JepEDz6HEWeRoLA1ev5PS+u7BfkEF46ufDewHggyUOH5i0xZKDRv5SW5a5Aoi1EK8sDznlQzgS3J0UhWiJHEj0LxtKBTWruDJLUZik2kowWl0Govmu+xloK0CKRqpyf1B0NrTeCziujnti4E4h1ORFfw+JmPzuk45ROgWQ/mJR0noyyKgqiyeUFiL4KBmE3e0crSAdevXt2vv+RlJoCzMg34OOQv2PxzHmtuPAsRboavyeRGCXrIp2bD5MH+/ClEw5D+klD8Ynx4ER0ZvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(39860400002)(376002)(346002)(136003)(396003)(38070700005)(122000001)(2906002)(8936002)(316002)(26005)(186003)(82960400001)(6916009)(91956017)(33716001)(86362001)(66556008)(9686003)(6512007)(6486002)(41300700001)(66946007)(76116006)(66446008)(1076003)(4326008)(64756008)(8676002)(478600001)(83380400001)(66476007)(71200400001)(38100700002)(6506007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JoyH0LqXv0VpgEehoxymwae4hrIOGLjRZmbifrO8GqJ5heXQW7KUmqw7Cnjj?=
 =?us-ascii?Q?qzSJ6Mk5FCa+YsE+i8hV1whAx/PZjQyh/mEToWjLHOPJD+I9lW90exW24x6w?=
 =?us-ascii?Q?gfgvlQc+EU0ozbvaXC0NbYRSYUNP8QwPqRz+HtQx/8+psiszcNLXYHhc2ckt?=
 =?us-ascii?Q?Aqm3qrB+PXxkXk1ZFOqjr8IckCal7L4w7JhwqvCg+udIyjXFdOoRQE56riW9?=
 =?us-ascii?Q?Kdg9fY6I+yuyPo3ELatSLsaU1Iso5ry2YHjoo8ID2ZR0DbGM8G5MBQ1D8KRq?=
 =?us-ascii?Q?iU9y3g2EoXbLp0q0yGhLgeYICvUuUV/3KRQH1J5EqZAVyA+iWoOxxzaKhBFu?=
 =?us-ascii?Q?gEAnykkWIAOp+PXhzbmoDM3KgO0jN6A01a+ODXgf39BM+0rNaz6pm67t62dz?=
 =?us-ascii?Q?tkgQXi5KpsHTkCxWERM5unnj08oEM5P/IhY/Y22Yl+vrkMJ5Bawsl5gF1cfC?=
 =?us-ascii?Q?qJRt1Xixy+c4DQp0Crxu53Gh7Uiwh0nHgrDpLj9yq1XIoTftRaNsM0D+rM3X?=
 =?us-ascii?Q?HyiFle0zRdAkEXyUkSofU9yttd/MrGfFX9DrDY0emwXB2hQiTnFAdNXzr7Yv?=
 =?us-ascii?Q?qUXC6GOnnmxLn/hPqMLoTq+dWLgbkl7tELIrg2fcLyhNtKpABFQnG7h9EZWv?=
 =?us-ascii?Q?d6wKaNDwlBBkHG70UMzHls+PoHwAWGC/zo4nuTebr1vVlhm4wQ2wKXOampIU?=
 =?us-ascii?Q?nHrNwJcYFKAuW0Kuc3Kz3Yu26iGM4nWALywhwOMguuUnwknLOvXGxePQezqy?=
 =?us-ascii?Q?xcwg55xKTT/eaLDMX0LLRvvLPlVPrbwGmRTrvponB0EyCwsmiSgiJbawcc5k?=
 =?us-ascii?Q?YTi6OoTSxVPoNC92iNuvWbLqc8eQxBYuvRZLQyaEF8WZ4cJctosztBiMvITB?=
 =?us-ascii?Q?/kmdH1TqYcKptn7NF+s13LyYuC4BUwBj5Dzoevc06PLvKczk7NB37/xhb3rt?=
 =?us-ascii?Q?uLrz13VbEb2m9wnEVdvyEn73suHd6FnCbaX1NbZrgiy9R2Qkc9WjWHvlvTUg?=
 =?us-ascii?Q?eeXVJnudmP3EC6ULllP47tyRpMf0n5YhSsTKVDtaOQgra6oyfdrIIk69ipNr?=
 =?us-ascii?Q?DnCbaNInbCYl6WtdBwsqomQuP+aUJELYYroq8Bw0aUB5pLeidYPLCwz3V80X?=
 =?us-ascii?Q?PPh3pb0wbvDZ0ASpJYwSsW7AQLFgNXNUfTTnH/diO4SH223YVqFbNzGJJrKi?=
 =?us-ascii?Q?nKesf9ltQRXOR+9j0CskerJTOWocr8FeEztte6c0nzwYnwWyn0d+xpjso8cW?=
 =?us-ascii?Q?AbMb+t5Dor3ri/dIii7At/BjuzdhuiB2HUlC9qCLU25+dfCCC0RGeXgNbNA5?=
 =?us-ascii?Q?5NSENFNquz8kVsfOA9xqXMDljXAa8uFuXdZ+DtEmuzsDZ/8Yq2BQnJp7f+IV?=
 =?us-ascii?Q?AOSIuns0Zm4eP8xTSazF6ipNXIjLjp6x3U1UqrT/eVmt6YAz0hI6PQNt9bME?=
 =?us-ascii?Q?2lMypQqMU/fncCUud/C3KlKgd0vs6boZSqWjwV+xzlDfopK9B4df3MPLuzOx?=
 =?us-ascii?Q?OTZRa5h+X9rXzZfH/m5GYKP8tp6NcHIDWQnDBUmsF3uQ+6SrZWhsszJDr7lM?=
 =?us-ascii?Q?bfvmgMwEESn+O+evlE09worPRW5UkO3zVlobbhwsBFt+NiK9n+c/TZqtyENP?=
 =?us-ascii?Q?jgsXjPGD+fZLQXvrjGEbsXcjYDcjzRj5Ni/OvKCnZ0n1xeDz3/CiaPQ9fgd5?=
 =?us-ascii?Q?dv5BORSzCujlqC8DuQLK9PvM5YdLTysbcQmshrTty9MdrY95kX8zvPzDcbnP?=
 =?us-ascii?Q?NwQt1bApwssu9rKlgiAo4mHGPpLuskY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ED3EBCCE75007A479D00CB493F9034BB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c17106d-97dd-4f3e-52b8-08da53ea08ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 00:56:25.9915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sdaEYbTGv4KAt2S6G+3Vtkhzg+0Q5F5uxn6OVw5V0UKybsAyfB8FErSvU8sdMcLgBhu3TqAEZmLbxrkJtsvltQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7179
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 21, 2022 at 04:04:14PM +0100, Filipe Manana wrote:
> On Tue, Jun 21, 2022 at 03:41:01PM +0900, Naohiro Aota wrote:
> > When cow_file_range() fails in the middle of the allocation loop, it
> > unlocks the pages but leaves the ordered extents intact. Thus, we need =
to
> > call btrfs_cleanup_ordered_extents() to finish the created ordered exte=
nts.
> >=20
> > Also, we need to call end_extent_writepage() if locked_page is availabl=
e
> > because btrfs_cleanup_ordered_extents() never process the region on the
> > locked_page.
> >=20
> > Furthermore, we need to set the mapping as error if locked_page is
> > unavailable before unlocking the pages, so that the errno is properly
> > propagated to the userland.
> >=20
> > CC: stable@vger.kernel.org # 5.18+
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> > I choose 5.18+ as the target as they are after refactoring and we can a=
pply
> > the series cleanly. Technically, older versions potentially have the sa=
me
> > issue, but it might not happen actually. So, let's choose easy targets =
to
> > apply.
> > ---
> >  fs/btrfs/inode.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 326150552e57..38d8e6d78e77 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -933,8 +933,18 @@ static int submit_uncompressed_range(struct btrfs_=
inode *inode,
> >  		goto out;
> >  	}
> >  	if (ret < 0) {
> > -		if (locked_page)
> > +		btrfs_cleanup_ordered_extents(inode, locked_page, start, end - start=
 + 1);
> > +		if (locked_page) {
> > +			u64 page_start =3D page_offset(locked_page);
> > +			u64 page_end =3D page_start + PAGE_SIZE - 1;
> > +
> > +			btrfs_page_set_error(inode->root->fs_info, locked_page,
> > +					     page_start, PAGE_SIZE);
> > +			set_page_writeback(locked_page);
> > +			end_page_writeback(locked_page);
> > +			end_extent_writepage(locked_page, ret, page_start, page_end);
> >  			unlock_page(locked_page);
> > +		}
> >  		goto out;
> >  	}
> > =20
> > @@ -1383,9 +1393,12 @@ static noinline int cow_file_range(struct btrfs_=
inode *inode,
> >  	 * However, in case of unlock =3D=3D 0, we still need to unlock the p=
ages
> >  	 * (except @locked_page) to ensure all the pages are unlocked.
> >  	 */
> > -	if (!unlock && orig_start < start)
> > +	if (!unlock && orig_start < start) {
> > +		if (!locked_page)
> > +			mapping_set_error(inode->vfs_inode.i_mapping, ret);
>=20
> Instead of this we can pass PAGE_SET_ERROR in page_ops, which will result=
 in
> setting the error in the inode's mapping.

PAGE_SET_ERROR always set the error as EIO, so it cannot propagate other
errors returned by cow_file_range() to the userland. Thus, I choose
mapping_set_error() here.

>=20
> In fact we currently only mark the locked page with error (at writepage_d=
elalloc()).

Yes and at submit_uncompressed_range() with this series applied.

> However all pages before and after it are still locked and we don't set t=
he error on
> them, I think we should - I don't see why not.

No, we unlock all pages except locked_pages in the error case, and yes, we
set the error only on the locked_page. So, that will make the other pages
to be writebacked later again (and make tons of the
btrfs_writepage_fixup_work). That is common among unlock =3D 0 case and
unlock =3D 1 case. Should we change that?

Setting all the pages as error would be good to avoid the tons of fixup in
this case.

> Did I miss something (again)?
>=20
> Sorry I only noticed this now.
>=20
> Thanks.
>=20
> >  		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
> >  					     locked_page, 0, page_ops);
> > +	}
> > =20
> >  	/*
> >  	 * For the range (2). If we reserved an extent for our delalloc range
> > --=20
> > 2.35.1
> > =
