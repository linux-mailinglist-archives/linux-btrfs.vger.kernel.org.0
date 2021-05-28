Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BDB3940D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 May 2021 12:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbhE1KZR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 May 2021 06:25:17 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:29924 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbhE1KZP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 May 2021 06:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622197440; x=1653733440;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=q8m+HFaoVXwJwJKxPAERc7eYAvCOG+ELyESQqcxLeb8=;
  b=YkjdH4aZ4rvhjl89G/oYGgQDw/QF9K1CHMS4WGcBGRyqDGhtFm72SvvG
   mAiPz5EAQcYTownduO4au/Ei9WYOz9sHhnvHmDZ2SgkxsSje2lgG2I8FH
   x0hFBDNCnikD0LEUPBGNs4czUCfUlKAnEJe5aaTea842M4NOwI2CU0tVe
   UmldPmgn49ziNH61DIy8JhGqzktCDBmjkEDof6KzCUkPdPVI2NQ4tfIzt
   XF2Dx1JYSM1k+BSIbsKMSJtME4IBq6TFpckjtkzrTnj51ZsQMeglgUNGp
   rWy2Kki5XyWNr1aN/TwC5ZlxL0gEuPESWPRYE0JUuH3hUWHssZRGgh9zL
   Q==;
IronPort-SDR: CtiDnFqzw9y7fgQ8MQXBmVsLZ6e/5sRofCIR2buzDlm0zumg4wKFz0yl2okzf1CMJi1xOLdA9b
 RPg1YhgXUzc07GSG++5Fj+5ItKNW0x5+4knzKccnRmgM9Mxvns0peBLBE7d4ERx5mBmGQNeBbp
 xKwAAn7N4XRwDpnkI8pAIpLUO8Pyr1SOfuWRvbIrUAJawYKfLn9UF9lzRICZC1KgPpsJOf+FFF
 2jSzjW0vD8zQ1WvL1yMBtgszNOWhpENIUaJGhV7hYQpwVOFPgPROqu9bSUhT33TdheV/m/t9Du
 o8E=
X-IronPort-AV: E=Sophos;i="5.83,229,1616428800"; 
   d="scan'208";a="273710141"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2021 18:23:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTVRgG1rYaauzaRiI1nvO7Ot1+XY+cgGGFsTBXpY5Rgycxo0AXQovE94YCGXLAIvmzWtplHUQIklNniCRLA3srXLxq+IBRMLP/RinJhAIH5cCZOL8lGA9/OVKENPKI2ifXhka6oxl2b4NCmQL3xWy/04D3sWBdscNx2gJOGFv/LqDwJBSu7vG38kvi6bt/f9jBKcnGhYJgvnMbGn19BV6sdQZc1tgbd4uQXiV30P3XQuwHkxu5wqKmFg0N3kRC9y/wCSaE5wqZNHNwerUHyNlceTFDdpPGdxxbGmdUKOJn0i92NQjW98FyWEHiAs3HD9jGtie861snesLx5esFlHjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ6xvFH/AYOtltVffjzCCRLuxcJj2fUaqs70QVmIePs=;
 b=cYwhj+X3fnuqkvuT7lHWheB0hrf418Io7FBNU51Toz/e6dPPCHM1d6t6LEqZ44P8YcEl+q3ajiZdqMYIFmbccAOdjR0emw2Zbqb3GVki0FWkDrF4Q7mmT0V84VpE6Rwi3mmsMwmWkD6UvpZFIcUrSIHynTyTkxZhy6C9ADzJzehg04n1lumsEv0tK7Fbj/sxNL1N2gyWPv2dIsUR/IFqNNUpW54WyFkWRMsZHHjHfs+gdvUf4fI2EADROeW+iULhogKhjLBUO4DPavNOKGgW+hdjZsvn5HB4LAurjj+VRm1rVGZQpVEAakF778ubuMOoGfE6qwfhtADqmjE7NFfxOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ6xvFH/AYOtltVffjzCCRLuxcJj2fUaqs70QVmIePs=;
 b=PydMTIPG+PyEH/NEckQM4VUF/3PxG4V6eo2ESa4Kg1gZ+55v+LzjCEQ1p816zm1NIQEOjC40CwU69cEMT12B1w4PmuXJuoTyJiMD1rcCsv+OeijOEaZAxy9LmcuV7X1g6zOpyMAw1RceiA90Mxduby6Gr7751nfxe8l7Us7G7Gs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7142.namprd04.prod.outlook.com (2603:10b6:510:c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Fri, 28 May
 2021 10:23:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 10:23:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/7] btrfs: defrag: extract the page preparation code into
 one helper
Thread-Topic: [PATCH 2/7] btrfs: defrag: extract the page preparation code
 into one helper
Thread-Index: AQHXU2kr2Yc02RPkgkSlWG5h2LgViw==
Date:   Fri, 28 May 2021 10:23:39 +0000
Message-ID: <PH0PR04MB7416FBCA389AE72610B6DEB29B229@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210528022821.81386-1-wqu@suse.com>
 <20210528022821.81386-3-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:15a4:7fd8:aff0:9452]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9fc96f2-1a32-409d-c967-08d921c2a979
x-ms-traffictypediagnostic: PH0PR04MB7142:
x-microsoft-antispam-prvs: <PH0PR04MB71429EFFC76CEE9209662E429B229@PH0PR04MB7142.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yM30JOrQ3OasIym9DaU6ccINgeyDVJd+U1ki+4XGGiW+PPFYG63m9l1a6FZmlJA4IKJsTeO06RJHa8XkbWhMWl3UwYAJzARHOF+GyF5FWmlczcBxD8wR9YnhDgkHs8Ii6mL6ofPxt5y4lLyQdq0NECDFEuUFxpH/1U+RsUV7EiUg/VlcmxdKTmsVatu6qGNuO8veoP7tCkwIBM2UmHtBYC66FxDlQZZjoSy2eJEh9ihMo8G111oogH8FtUKe2Fz9Bvjjn23Yd1hJYcgtHPawFjpdPNPz9o77sVTuMzcrIC7XyDC/RQIqxH3JMApeN4amipAZV/1X5xfbodMGbvE7Cwq+BhfPRr633VsKnplmaQn/2W7COp6vEjSynja4ksSMY9puPt0G5u/fLnhvfkIy6DztKnpMUtvn4qY5NcHWKbSjksg1GkgboRiLFIsYcsYPEHnvNGJI9hxiE7Gb8hi9KJ+7vtd1CZxOppRu9p2Zjn2ic6ejw4L/F5J6ETUTxWQFaW7X9mXNAsb93czjenL0Wzu5RCfjknKvMzJbl4BRYcEjMAPAECm0L76Ooq34xHBzRR6/QmlNENm28C3UbUnGv0sE0R0mfZ6EYdMz41vDTPY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(9686003)(52536014)(5660300002)(91956017)(55016002)(66946007)(76116006)(64756008)(66476007)(66556008)(66446008)(6506007)(8676002)(316002)(33656002)(7696005)(478600001)(53546011)(83380400001)(186003)(71200400001)(86362001)(8936002)(2906002)(38100700002)(110136005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nm3P5NkIcEVM6SJYwZ+ky3fUU+ze50TLGXGQFt4JAlKkKP/0AQIVA6WsIo53?=
 =?us-ascii?Q?tIIxrZPVE6iBd1JIaX/l0XEGZ4+h+/TW4iPvsKDYt97jb51ikQat+hHwwd73?=
 =?us-ascii?Q?VAR9yl426RLhguN7utIiMqv3D7jxxLp+SmIq7M/U8SihvPZ5XXuD+NyGtrTP?=
 =?us-ascii?Q?AewlSnduq/iafz6AzWBNhHPCtUNo5Nkclzy19BJ4OHWAWOmDtjEoj1gG8lbe?=
 =?us-ascii?Q?PdzfAUCPUFwcAVFK5qtPQF7TVdeHRb9S3gT/jNTSpXDoKrX7Vea3TFAYNDL/?=
 =?us-ascii?Q?FvJ3jmtl0APQnTIyk98+0lgLtDva0JgfC8nKqX1NNKVwAzxTd/TwsQ05u+Lm?=
 =?us-ascii?Q?mRTeX+/JFZ29KNkfAh/ia+z/agu5irK9eF6mHMnCur6BS8tLAZoIdt3844OQ?=
 =?us-ascii?Q?4lvRlvFAEuRTuqbHKuJi/S948ZP6qXff/ndZEJmqEeKERiGyGELxG4JUv3q9?=
 =?us-ascii?Q?NyDWlT9QGksSTpIw+KLWLZmBmATU3R49z0t8Oq8jSvljzrnFO/f/5Ag1hDEb?=
 =?us-ascii?Q?B36CUjYu7f2mRpmldtsUGu8txIQ67gSpWQkx6bAC6CeULnzqkxvw7IXnRsA9?=
 =?us-ascii?Q?kw7rZHe52P6Bpinl81tJs3qb5rc2oEpD35GgJkBWJGQdROui5s5jwqOZQzNu?=
 =?us-ascii?Q?oyZ0ibWjKNNkcvdPC7e4T6gT5XUalCcWdsruvmfh1rZ0Rs59c92TNFpr3Nfb?=
 =?us-ascii?Q?gxHdmC4gt77ER9uH71wJZqjzkaRfqaZF39drB0QZWLYJ8cOnPDaqYB1kPAiY?=
 =?us-ascii?Q?BYCCrhDJhBl6f8mY4e3B2xHrdudOIxxO/bh85w9C8L/Q39VP3Ls8/4qMrXlL?=
 =?us-ascii?Q?7OTuWvuyTPZFQCYpr3J4Wx+dcYjyJvjHT2Y40+aUE1mXqNnSVcoZiGSyAA+9?=
 =?us-ascii?Q?NyJkzwBNknS71/Jq7A0CtYrgJXPS7sxHAl+/xE3tAtl1yGzmWltphG8DkH3f?=
 =?us-ascii?Q?5RbQ54pQsP4nkNGIGl2B0tiy8wX2GFDoG7utbJRxU6gt5+g5b0Nf/NRcISpL?=
 =?us-ascii?Q?VMapoqaimlCPQ+9zBCH+FLgMRxP5kvk+KjS/Zifih4/rE7zhRA61VpvG0XGU?=
 =?us-ascii?Q?p7n7ZnrL166ipX2zLzU2pwfRyVTpcky850KPU5mf/tVE8nW3lKnILgQx9ZRv?=
 =?us-ascii?Q?N53hF0vy/ozI3nltzMPu+aqDRJ076jCfDeaGET+7S/c9B4G6MTV2T+91vVyQ?=
 =?us-ascii?Q?tc2jnU4w65HRLBtt4zyt557PNdNSlhxMYjafanDR62vOakvTuZS8HtTWzPLf?=
 =?us-ascii?Q?Opkw+IffY6GeiIe4bAbyU39R+nDDNhOJg04UK0WR3IWWUTy9mSu3QdDgBk/Z?=
 =?us-ascii?Q?HIMNeqf9EJINY/lbKiE0RR2HGHsKE3d5HWvxtAfOtJo6v7Zg9knzoCYahsMp?=
 =?us-ascii?Q?4snp3v4i9aii3y9kaxftqriLCE3sPrbBdm2y9gFHy7Rrzck8bA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fc96f2-1a32-409d-c967-08d921c2a979
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2021 10:23:39.9263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1T+IKCJHx7HPOryVj5VGb2HesfDJ4jYz9R4b2pnqwCLLjfFn9okyHTEcWTldQ5uyYxW5X3vGrOM4ZauNsg2jlyVrsznbGZh5LqYr5NCjif8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7142
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/05/2021 04:28, Qu Wenruo wrote:=0A=
> In cluster_pages_for_defrag(), we have complex code block inside one=0A=
> for() loop.=0A=
> =0A=
> The code block is to prepare one page for defrag, this will ensure:=0A=
> - The page is locked and set up properly=0A=
> - No ordered extent exists in the page range=0A=
> - The page is uptodate=0A=
> - The writeback has finished=0A=
> =0A=
> This behavior is pretty common and will be reused by later defrag=0A=
> rework.=0A=
> =0A=
> So extract the code into its own helper, defrag_prepare_one_page(), for=
=0A=
> later usage, and cleanup the code by a little.=0A=
> =0A=
> Signed-off-by: Qu Wenruo <wqu@suse.com>=0A=
> ---=0A=
>  fs/btrfs/ioctl.c | 151 +++++++++++++++++++++++++++--------------------=
=0A=
>  1 file changed, 86 insertions(+), 65 deletions(-)=0A=
> =0A=
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c=0A=
> index 67ef9c535eb5..ba69991bca10 100644=0A=
> --- a/fs/btrfs/ioctl.c=0A=
> +++ b/fs/btrfs/ioctl.c=0A=
> @@ -1144,6 +1144,89 @@ static int should_defrag_range(struct inode *inode=
, u64 start, u32 thresh,=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
> +/*=0A=
> + * Prepare one page to be defraged.=0A=
> + *=0A=
> + * This will ensure:=0A=
> + * - Returned page is locked and has been set up properly=0A=
> + * - No ordered extent exists in the page=0A=
> + * - The page is uptodate=0A=
> + * - The writeback has finished=0A=
> + */=0A=
> +static struct page *defrag_prepare_one_page(struct btrfs_inode *inode,=
=0A=
> +					    unsigned long index)=0A=
> +{=0A=
=0A=
	struct address_space *mapping =3D inode->vfs_inode.i_mapping;=0A=
	gfp_t mask =3D btrfs_alloc_write_mask(mapping);=0A=
=0A=
> +	gfp_t mask =3D btrfs_alloc_write_mask(inode->vfs_inode.i_mapping);=0A=
> +	u64 page_start =3D index << PAGE_SHIFT;=0A=
> +	u64 page_end =3D page_start + PAGE_SIZE - 1;=0A=
> +	struct extent_state *cached_state =3D NULL;=0A=
> +	struct page *page;=0A=
> +	int ret;=0A=
> +=0A=
> +again:=0A=
> +	page =3D find_or_create_page(inode->vfs_inode.i_mapping, index, mask);=
=0A=
=0A=
	page =3D find_or_create_page(mapping, index, mask);=0A=
=0A=
While you're at it?=0A=
=0A=
> +	if (!page)=0A=
> +		return ERR_PTR(-ENOMEM);=0A=
> +=0A=
> +	ret =3D set_page_extent_mapped(page);=0A=
> +	if (ret < 0) {=0A=
> +		unlock_page(page);=0A=
> +		put_page(page);=0A=
> +		return ERR_PTR(ret);=0A=
> +	}=0A=
> +=0A=
> +	/* Wait for any exists ordered extent in the range */=0A=
> +	while (1) {=0A=
> +		struct btrfs_ordered_extent *ordered;=0A=
> +=0A=
> +		lock_extent_bits(&inode->io_tree, page_start, page_end,=0A=
> +				 &cached_state);=0A=
> +		ordered =3D btrfs_lookup_ordered_range(inode, page_start,=0A=
> +						     PAGE_SIZE);=0A=
> +		unlock_extent_cached(&inode->io_tree, page_start, page_end,=0A=
> +				     &cached_state);=0A=
> +		if (!ordered)=0A=
> +			break;=0A=
> +=0A=
> +		unlock_page(page);=0A=
> +		btrfs_start_ordered_extent(ordered, 1);=0A=
> +		btrfs_put_ordered_extent(ordered);=0A=
> +		lock_page(page);=0A=
> +		/*=0A=
> +		 * we unlocked the page above, so we need check if=0A=
> +		 * it was released or not.=0A=
> +		 */=0A=
> +		if (page->mapping !=3D inode->vfs_inode.i_mapping ||=0A=
=0A=
		if (page->mapping !=3D mapping ||=0A=
=0A=
> +		    !PagePrivate(page)) {=0A=
> +			unlock_page(page);=0A=
> +			put_page(page);=0A=
> +			goto again;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	/*=0A=
> +	 * Now the page range has no ordered extent any more.=0A=
> +	 * Read the page to make it uptodate.=0A=
> +	 */=0A=
> +	if (!PageUptodate(page)) {=0A=
> +		btrfs_readpage(NULL, page);=0A=
> +		lock_page(page);=0A=
> +		if (page->mapping !=3D inode->vfs_inode.i_mapping ||=0A=
=0A=
		if (page->mapping !=3D mapping ||=0A=
=0A=
=0A=
> +		    !PagePrivate(page)) {=0A=
> +			unlock_page(page);=0A=
> +			put_page(page);=0A=
> +			goto again;=0A=
> +		}=0A=
> +		if (!PageUptodate(page)) {=0A=
> +			unlock_page(page);=0A=
> +			put_page(page);=0A=
> +			return ERR_PTR(-EIO);=0A=
> +		}=0A=
> +	}=0A=
> +	wait_on_page_writeback(page);=0A=
> +	return page;=0A=
> +}=0A=
> +=0A=
>  /*=0A=
>   * it doesn't do much good to defrag one or two pages=0A=
>   * at a time.  This pulls in a nice chunk of pages=0A=
> @@ -1172,11 +1255,8 @@ static int cluster_pages_for_defrag(struct inode *=
inode,=0A=
>  	int ret;=0A=
>  	int i;=0A=
>  	int i_done;=0A=
> -	struct btrfs_ordered_extent *ordered;=0A=
>  	struct extent_state *cached_state =3D NULL;=0A=
> -	struct extent_io_tree *tree;=0A=
>  	struct extent_changeset *data_reserved =3D NULL;=0A=
> -	gfp_t mask =3D btrfs_alloc_write_mask(inode->i_mapping);=0A=
>  =0A=
>  	file_end =3D (isize - 1) >> PAGE_SHIFT;=0A=
>  	if (!isize || start_index > file_end)=0A=
> @@ -1189,68 +1269,16 @@ static int cluster_pages_for_defrag(struct inode =
*inode,=0A=
>  	if (ret)=0A=
>  		return ret;=0A=
>  	i_done =3D 0;=0A=
> -	tree =3D &BTRFS_I(inode)->io_tree;=0A=
>  =0A=
>  	/* step one, lock all the pages */=0A=
>  	for (i =3D 0; i < page_cnt; i++) {=0A=
>  		struct page *page;=0A=
> -again:=0A=
> -		page =3D find_or_create_page(inode->i_mapping,=0A=
> -					   start_index + i, mask);=0A=
> -		if (!page)=0A=
> -			break;=0A=
>  =0A=
> -		ret =3D set_page_extent_mapped(page);=0A=
> -		if (ret < 0) {=0A=
> -			unlock_page(page);=0A=
> -			put_page(page);=0A=
> +		page =3D defrag_prepare_one_page(BTRFS_I(inode), start_index + i);=0A=
> +		if (IS_ERR(page)) {=0A=
> +			ret =3D PTR_ERR(page);=0A=
>  			break;=0A=
>  		}=0A=
> -=0A=
> -		page_start =3D page_offset(page);=0A=
> -		page_end =3D page_start + PAGE_SIZE - 1;=0A=
> -		while (1) {=0A=
> -			lock_extent_bits(tree, page_start, page_end,=0A=
> -					 &cached_state);=0A=
> -			ordered =3D btrfs_lookup_ordered_extent(BTRFS_I(inode),=0A=
> -							      page_start);=0A=
> -			unlock_extent_cached(tree, page_start, page_end,=0A=
> -					     &cached_state);=0A=
> -			if (!ordered)=0A=
> -				break;=0A=
> -=0A=
> -			unlock_page(page);=0A=
> -			btrfs_start_ordered_extent(ordered, 1);=0A=
> -			btrfs_put_ordered_extent(ordered);=0A=
> -			lock_page(page);=0A=
> -			/*=0A=
> -			 * we unlocked the page above, so we need check if=0A=
> -			 * it was released or not.=0A=
> -			 */=0A=
> -			if (page->mapping !=3D inode->i_mapping || !PagePrivate(page)) {=0A=
> -				unlock_page(page);=0A=
> -				put_page(page);=0A=
> -				goto again;=0A=
> -			}=0A=
> -		}=0A=
> -=0A=
> -		if (!PageUptodate(page)) {=0A=
> -			btrfs_readpage(NULL, page);=0A=
> -			lock_page(page);=0A=
> -			if (!PageUptodate(page)) {=0A=
> -				unlock_page(page);=0A=
> -				put_page(page);=0A=
> -				ret =3D -EIO;=0A=
> -				break;=0A=
> -			}=0A=
> -		}=0A=
> -=0A=
> -		if (page->mapping !=3D inode->i_mapping || !PagePrivate(page)) {=0A=
> -			unlock_page(page);=0A=
> -			put_page(page);=0A=
> -			goto again;=0A=
> -		}=0A=
> -=0A=
>  		pages[i] =3D page;=0A=
>  		i_done++;=0A=
>  	}=0A=
> @@ -1260,13 +1288,6 @@ static int cluster_pages_for_defrag(struct inode *=
inode,=0A=
>  	if (!(inode->i_sb->s_flags & SB_ACTIVE))=0A=
>  		goto out;=0A=
>  =0A=
> -	/*=0A=
> -	 * so now we have a nice long stream of locked=0A=
> -	 * and up to date pages, lets wait on them=0A=
> -	 */=0A=
> -	for (i =3D 0; i < i_done; i++)=0A=
> -		wait_on_page_writeback(pages[i]);=0A=
> -=0A=
=0A=
Doesn't this introduce a behavioral change? previously we didn't=0A=
wait for page writeback in case of a parallel unmount, now we do.=0A=
=0A=
=0A=
