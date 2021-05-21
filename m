Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D5938C564
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 13:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbhEULIN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 07:08:13 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:25361 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhEULIL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 07:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621595208; x=1653131208;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2Y3Yl5fuWbZDZGnCfO+TaiXETfM11ajIfqumE+PqIZ4=;
  b=EIELfOBX9orRw6Tf3/Snaler067P8Tltu+d7Uqmmyj9DC3ZP8mVzhPb1
   UbDkslha9b5JNOpSQ+2Vmd/ZctstGtBIMs+3k6mOBgzjxGha3fS2FD1sD
   2xhVEOybRcLTFnLRB3bJTIA/2UfAENk73327BAjwo1gvAMxT6na+tsPSk
   axTMwtF3nw0ksmcSH3UKRzG/eHX7nRjkb2E38Wy+GkGfC43L/VFR5tETB
   d0OYqVuJP/GFvAAGYwEdfaC8Y9Ay2jtM/L5znDXeTePjBdzuPcMTscDMj
   J6jk/145D01MJ1ewd9JVGnrt4jTCLgUsKqjHIolE3EclThrnk0+3A8swg
   A==;
IronPort-SDR: 81Q+PUQZ3ZeVCwPg9+wyyCSUNIRIUTxPUtAsZd76BuuTYQtCrOt5LDA6/WxpZjb1TtpqMhs6Y0
 aqGA1PGf+8ZXaj8Jkqbudgo+yEVWe6J5vXsz+dgGouosD4BEC+8gwm0xcS3tHqCFXd9or+5hQK
 Da3QAqd00xMztmZH8hdtu/woP/qCSZg6Q0lgLoTf1Y6nDUxnEOZ+SL24oWBC4Cz0XuZSeLlrZm
 MP2QzUU3QUe5tfmGNuI/yXNCg6BImn/uNnIriKv27LDNTRHh2AXlEAWhSwuzDtL01VqZejsu+b
 CFs=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="173637406"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 19:06:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8qqAsgc/en9/aIGTleMxPlcINGJ5Yu4LvjWQ/AsfYPTZndvVr14+didihaC0XBirvq4Uk2SIxlVChwCwerNtdNtURbLicxhogSDQ23sG0F+RlP/LZ4uW5Ksp1Q3RCWXWL7OVbuSSp3DJgTg6GHYXvsPIqzhPlVCE7VrhHDc8y335u3G3Fry0Gi5klOfddTXVRwN1n1vcqUuAe0iAWtIr5e3EAJCOUkl8aZmQ1jVwWBSS6Doo9iN9wvAhwSIh2YFtpE/HZaW565qaEEnQij9q7NukB+iwUFqj2OhpMJMq36XZ+/RqTu047Etm8qaGQHzuE1rtWLCVUKn1BdeURt7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtbhFzHYAc5IqpcbaEgHYzCZ8Nq1Yo2cyuL4agaF+Uk=;
 b=kU3Ll1majsZ5RzWCRGXsN1MhATb8jhv1VDh8E0+S2gbSCx7w/2xSLIJJZPmakbdm2maNdfaSdwClOwomtAcKMG1593ndI78vS8EN+s12LpByFkRCiblRFJMymFSqIZilGkV10w6dvSEaLWV4Tf8dIQAbbgVGjlQDZ9qhV16MKmoYkrLQc43yxiyo7f56Yx/HHzn48SxT1XjJl2Zh4mNFtRNP1Jn229/mKQkFBOo7ccene02aO/lg/P+Qyln0w6gcLDbxr0WdsLMAalClzZu/s3H7osEuYHlfJDEpHdySbGsAd4ZEdtfP9my7j+Zx3hUgVl5MbZSI8yrORFBRNKpPTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtbhFzHYAc5IqpcbaEgHYzCZ8Nq1Yo2cyuL4agaF+Uk=;
 b=P6LxZGOs91uiehkRQm19GF3dwe6PRjJF/cT/QR8FdTHG0h5tGPnq5c4ZzmqrMbxUEN+BXk4prGmd7cNLS34r6q07C+Bp/aZu6CVYonr7gUUdgmtBP2Y8IOO3vpyOIQPiWvOC6ZH27f+lMYZSIVZ6IAC7Qf/UViFZ7HNcPzfpg4M=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7478.namprd04.prod.outlook.com (2603:10b6:510:4e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Fri, 21 May
 2021 11:06:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.035; Fri, 21 May 2021
 11:06:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [Patch v2 05/42] btrfs: refactor submit_extent_page() to make bio
 and its flag tracing easier
Thread-Topic: [Patch v2 05/42] btrfs: refactor submit_extent_page() to make
 bio and its flag tracing easier
Thread-Index: AQHXO7mkv3Nh0Q47vEOMyi5jVkkaDQ==
Date:   Fri, 21 May 2021 11:06:47 +0000
Message-ID: <PH0PR04MB74164E271935D134458F6C289B299@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-6-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:f8bd:921e:9aa5:6d21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91e7b7cf-a638-430c-92a6-08d91c4886be
x-ms-traffictypediagnostic: PH0PR04MB7478:
x-microsoft-antispam-prvs: <PH0PR04MB7478187BE8D69386B39897C39B299@PH0PR04MB7478.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cS5MBOx6BQRr/hjLpEDLQHz+EHwmPsDfJB9URUM6EyW9ZP7zn4+PUp/dsAq/9T5vaku4voHDpHg2/QAhAk2fLcXUPy+K4G0S1p5mntNY0iCB97w94UFzQIYo2KV9HVnw5NLDyQ2K1n6yH7RKZPAG1bouvME6AXmcuT1YFb2V91M5p0VcIaDnTa0amGnrelhQ98Gy4+Nbr5Hq1veJ5n+/WV7wfukSVz/L4cmT5nFh8rgz+onRRRsbJ+Pk8rxMgDKUPA6BwRTO7zg+UNRrAYeDuu5cYc0bcbjhbJAclLI9iDGUjR4yUR5dUQoJlbM+8AMAG+vJni65Tbvg50jwU6/w2ey07R2D1+djyTr+W2EN0ZIYjQ+7Q7l0pMZeq0Cmiim3Wx/XdpZrYXRECf7HesDqaLvvgn5XxxocFxCnUxAS90N2gtmangk5YeyrLohsF79Y19t3LkXjve327ax2hpAas/9/bItOh7c4NWmnMyN5C7a01/5pz32u3AFnbcfb0LEYTwZBFK5OG2N3xARcwmjHOSb3hbdu9gKF8lSpwZCq9Y0jP3EG49B2i0sRoT/7nDgvHw73vVfwDDa5C32d7ar2e3BznUYOz49Uc6aYAA9INv8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(38100700002)(86362001)(5660300002)(83380400001)(9686003)(52536014)(55016002)(71200400001)(8936002)(33656002)(2906002)(110136005)(478600001)(6506007)(53546011)(122000001)(8676002)(66946007)(76116006)(66446008)(66476007)(7696005)(66556008)(186003)(64756008)(4326008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iea4q3CtMG0I8G4P6r4nwc5/hQHY+nEm097WKZprxImtlHvyYTAvp/cyvBwJ?=
 =?us-ascii?Q?yzFlt/12BAlPnSUoLgQHS6WnUvjf3XRAnISFv7u0MADP8wlEro+gp7GXm1Oo?=
 =?us-ascii?Q?aPNcKTIVBkSU5c2x3Xwp2E6w6nG5H4gM1XsopqZFLuPgvcoNxUgOLIfsAbtg?=
 =?us-ascii?Q?QpaR3MXAQBG6nu9zf7EgschP6hoS1V8R6Ainqi8gmuFDC6vHr9DLklgbiySG?=
 =?us-ascii?Q?5HB5qABIaS/eclNHvgUkXk+iLG11tVOUlaBHxFtZZ1PFEdD1e4SKHN9XbwyC?=
 =?us-ascii?Q?QE85dKtK9tMhK+4YHz4jodA/bt0i87uQTBkdJUc/ctKxreELRF+woYkkWLgU?=
 =?us-ascii?Q?KxLRRxiPGDLEmUhyHXhCoA6BFmhGkP2DccCDORBpv4aJGIBxknvcdNNFYZ5c?=
 =?us-ascii?Q?82CseSFMUq+wCHLg8jMkxyRIj7sWrtcv+2cZ0cqjdm2nbl6B9pDikdJPfN8j?=
 =?us-ascii?Q?mR7v4Xiu3LiJqyPXOBoMPPRviPALx98AC+eJwhOGpNo4oBpc4dNjSNzz7wf0?=
 =?us-ascii?Q?qAp0l+eDF6GBC8Qm6ZDLTUR9rZg5+y4uXVirTqBfvq9AlSBiuCYwHMZciBpd?=
 =?us-ascii?Q?f+UZBsyTY5L9N/DxGblnvAWfY3IJuaZEMBCX1EqGn5eYPtx9z8GKp2PiYLUr?=
 =?us-ascii?Q?N1pnxtrXLHR/JA8d00a2K+X88TqawxxQ7f5Y62Ry7bPiUHmtLRcnG6S4N1/e?=
 =?us-ascii?Q?LfV0bVZIow1GrTod1Fff+JPrkSLs4Cx9d+WPdj4tojN2vwQJl1sOiE+3Vj1k?=
 =?us-ascii?Q?FhEAwvnEoZgBY8dcRMvg46qdnahfoTVNUgeeC9ADG7rLWnWlqk+Z8nx+XjO+?=
 =?us-ascii?Q?pycgZSRK2CbwPMQ+VvCh4soNIvXi+7yRu2o1NTw2ECrQhEVgfgF8lmkNA8iL?=
 =?us-ascii?Q?f3W5QM1oERbdtSKwycLz7HIJRvkUW+8VIG3gVX1iMamXslxuBpn6L82fCpWW?=
 =?us-ascii?Q?UR1+qT/6AVhPHcdxqdqi5DI0fPqU/oxZXr6/tzcqytNNkpzb+V/gCJr/Aqxf?=
 =?us-ascii?Q?+Cq1z1MImA5cSxwMFs82Vo9+hPSy/8pXof7PwoqrO4pQffp4naGXCQgN8F34?=
 =?us-ascii?Q?P2tAJu4k+dIgVvNC30LbFOpumAsiAgLLfvJnxo3M0d4sJJfCRByAGvLxVqF5?=
 =?us-ascii?Q?MKHh2K64WHmgM5vbTlPij7qf5B7++kYz2johJTwWWzrjTyErBwsV3rtSGZmg?=
 =?us-ascii?Q?bmVLFvEfO24Lt+rJN5p5aAdyH68v9xcNX798N3JTyiNptajEgz9vF9+fkFpI?=
 =?us-ascii?Q?zpMFZQYkKGlvIjak/DCZUg0/AWUzJ1FKXZpwLaLCsGAanp+32TWFB5W5Y9QQ?=
 =?us-ascii?Q?lLFe2UcWva/Ea+BPOK+WySwI0g+rgAh9q53d6gxWXUpUS+FDtZH4TMAT7ZnM?=
 =?us-ascii?Q?OXOFQLmBm4SaDhN0VNvVjuusCPFuXLLx+jbJQSX5KV8C5yXUwg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e7b7cf-a638-430c-92a6-08d91c4886be
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 11:06:47.1942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yy0QGgxTMFDshaKlm2uPEYa+ywp4uVMkvgoaEeR+4iuMh7aqpJeaRlXEDG+QSST4SSjEbLR8TGRRIB0lk24ERlKRKSdcdL8smDOWe/CqF10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7478
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/04/2021 01:04, Qu Wenruo wrote:=0A=
> +static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,=0A=
> +			       struct btrfs_inode *inode)=0A=
> +{=0A=
> +	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;=0A=
> +	struct btrfs_io_geometry geom;=0A=
> +	struct btrfs_ordered_extent *ordered;=0A=
> +	struct extent_map *em;=0A=
> +	u64 logical =3D (bio_ctrl->bio->bi_iter.bi_sector << SECTOR_SHIFT);=0A=
> +	int ret;=0A=
> +=0A=
> +	/*=0A=
> +	 * Pages for compressed extent are never submitted to disk directly,=0A=
> +	 * thus it has no real boundary, just set them to U32_MAX.=0A=
> +	 *=0A=
> +	 * The split happens for real compressed bio, which happens in=0A=
> +	 * btrfs_submit_compressed_read/write().=0A=
> +	 */=0A=
> +	if (bio_ctrl->bio_flags & EXTENT_BIO_COMPRESSED) {=0A=
> +		bio_ctrl->len_to_oe_boundary =3D U32_MAX;=0A=
> +		bio_ctrl->len_to_stripe_boundary =3D U32_MAX;=0A=
> +		return 0;=0A=
> +	}=0A=
> +	em =3D btrfs_get_chunk_map(fs_info, logical, fs_info->sectorsize);=0A=
> +	if (IS_ERR(em))=0A=
> +		return PTR_ERR(em);=0A=
> +	ret =3D btrfs_get_io_geometry(fs_info, em, btrfs_op(bio_ctrl->bio),=0A=
> +				    logical, &geom);=0A=
> +	if (ret < 0) {=0A=
> +		free_extent_map(em);=0A=
> +		return ret;=0A=
> +	}=0A=
=0A=
I have kmemleak reports on misc-next for each mount and git bisect points t=
o=0A=
this patch. Aren't we leaking 'em' here?=0A=
=0A=
> +	if (geom.len > U32_MAX)=0A=
> +		bio_ctrl->len_to_stripe_boundary =3D U32_MAX;=0A=
> +	else=0A=
> +		bio_ctrl->len_to_stripe_boundary =3D (u32)geom.len;=0A=
> +=0A=
> +	if (!btrfs_is_zoned(fs_info) ||=0A=
> +	    bio_op(bio_ctrl->bio) !=3D REQ_OP_ZONE_APPEND) {=0A=
> +		bio_ctrl->len_to_oe_boundary =3D U32_MAX;=0A=
> +		return 0;=0A=
> +	}=0A=
> +=0A=
> +	ASSERT(fs_info->max_zone_append_size > 0);=0A=
> +	/* Ordered extent not yet created, so we're good */=0A=
> +	ordered =3D btrfs_lookup_ordered_extent(inode, logical);=0A=
> +	if (!ordered) {=0A=
> +		bio_ctrl->len_to_oe_boundary =3D U32_MAX;=0A=
> +		return 0;=0A=
> +	}=0A=
> +=0A=
> +	bio_ctrl->len_to_oe_boundary =3D min_t(u32, U32_MAX,=0A=
> +		ordered->disk_bytenr + ordered->disk_num_bytes - logical);=0A=
> +	btrfs_put_ordered_extent(ordered);=0A=
> +	return 0;=0A=
> +}=0A=
=0A=
This hunk makes kmemleak happy again (for the range I've tested):=0A=
=0A=
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c=0A=
index 3c920ca0ffa7..dfa8e5435ab7 100644=0A=
--- a/fs/btrfs/extent_io.c=0A=
+++ b/fs/btrfs/extent_io.c=0A=
@@ -3233,10 +3233,10 @@ static int calc_bio_boundaries(struct btrfs_bio_ctr=
l *bio_ctrl,=0A=
                return PTR_ERR(em);=0A=
        ret =3D btrfs_get_io_geometry(fs_info, em, btrfs_op(bio_ctrl->bio),=
=0A=
                                    logical, &geom);=0A=
-       if (ret < 0) {=0A=
-               free_extent_map(em);=0A=
+       free_extent_map(em);=0A=
+       if (ret < 0)=0A=
                return ret;=0A=
-       }=0A=
+=0A=
        if (geom.len > U32_MAX)=0A=
                bio_ctrl->len_to_stripe_boundary =3D U32_MAX;=0A=
        else=0A=
=0A=
