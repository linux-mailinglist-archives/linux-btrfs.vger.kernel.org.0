Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085683A85CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jun 2021 17:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhFOQAm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Jun 2021 12:00:42 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:11668 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbhFOQAI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Jun 2021 12:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623772683; x=1655308683;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=XM1NE6yC1Y6fpFxZedQW5o86zdHLGEDWUD8BFkM6rF8=;
  b=rcLPXjYVkA0x04ow7+ibs/rDh+3Wc8mFdnShp1kx+Rt4DlTy9CsjJg0T
   duMOJmM8rGuKtErUEhrI4wEQLIG+DU/GmAW7/EylsF9+DRDn4fEqr0ylm
   ZF562IjzTanWto0Gz8+Gc06aBykoa1mbh/zpchLGbrzqZk9jtySI4wRYL
   ydJYym8oiUf1mUPcPsfke3A3seSyB44cBoCvvqv4MNUObauUIL9Q9/V1O
   sdAQ+9676q68pZsjesrhuuFW9NFvd2ARtm6eBFsGfd052Kjt4yByvSE/W
   RhRJ3RXCFl3CFvEuRENPaz+UgJS48aFhtxOFndRiD7jabML6KhXvGugfk
   A==;
IronPort-SDR: 9Fs5TitmCZbtFbLIPGYaH/3qlDHp2sNun8R4+Ntr/qIDJy24Quj/GBqI32giATBdwbuVpfwkNi
 KcepVkLHSbyrt8NiMTJmqFMDQuu/9kdDxMudBKWFmnpjB8hO1ZsoHsf+gzY7eZ4wXERPpXeFHL
 GAbYHf0kX2D3k7c9/luyhSRezsVtb/J4UlVuY0rSevVZnSMm56UV6m5vG4YB3Uw2L+6GlEsyB1
 8Fp78VXSivHxg7aQF0q3ftlpRkfYXb42YvrpPWML/CBErE1DqzGkDbXgMdcKi/SdhJ61iQbSOv
 ebc=
X-IronPort-AV: E=Sophos;i="5.83,275,1616428800"; 
   d="scan'208";a="176766888"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2021 23:58:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfymsvS1cjMp9Ee9RzGxs8OLm3wnElK/sqcpQ8jubR+3I/PF++n8fPHIu5J2h3XV5fl8Ct8WMAI3uGKo3KbLZuXmA02d9ie00WigQ93+63YZ/5xBU9Jr8HLD1V9G+Y/RakGUjjalNI2taVbqQa07UAJxOanAZkRjY50/8pBMtPtarlEPEZza6/Pq/mt8XwLHiFD4GEVxTGK/3A6etcR+tPT/wR3ByIZ4o0rxI0/XfpzFJ6jRxCznzausMHrHN0kBWnLPXk8XZR4zTgGqlYetdRuQAbWEWO0vz79fGw9S5h5NeuIKa0KUpCgN8RjrrD/BNV8rKuE0YjDvLMi6XhNXtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPxAokJ17KsCJy39aouKPsrl2nVYyiruooLoerfXcwk=;
 b=oeCUT542Qx26hoqpgSb3KxX/rLmXWelQy+a+6BRWxsQ0NzuJJIKRztGZz7o27/pLAEZL35dicVXmjlCdD/d8noePYwpwS3ZMjqzCuSdHeX2G3CUIDu+HxJn8x6Uys6wZrP41yMGVjK0obiWdZYIOu1XUs1Uyt5hYsYlwRn2lJ/+TXNm2SPNvkwHeO/9mKA10HZWsOADOgvzlUNDqCMVN690e37mZ8AsNgmbtZ9B/rdr2ZdLBmj2E9+MwMUY1i+0CNKAtqJKtblO3/iuxTET3sG2W8ncBY9k9U/4QqmAQJR740tUT3mTXXyQ68JbGsLFSTQNlo9cEDiuFP1vE67GV4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPxAokJ17KsCJy39aouKPsrl2nVYyiruooLoerfXcwk=;
 b=ypKjXKVKgWXn06B2dPWo4OqLotJZj5bTXwMKyc29i4o6nHSZmTqbfaM5vIV+E4X9KpL/m2qpCG2KCsfnVmKJeoSGUa+hQxqXJwtjXDNWJ6o1uBmOjt5XvlsV20c/QJkYBN/1Ys9g9vDcTyTZ2NdEO98yLy/Q2pEumzqrACM+hqw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Tue, 15 Jun
 2021 15:58:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 15:58:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 6/9] btrfs: introduce alloc_submit_compressed_bio() for
 compression
Thread-Topic: [PATCH v3 6/9] btrfs: introduce alloc_submit_compressed_bio()
 for compression
Thread-Index: AQHXYeCemq7URZde4Umztp1o9YJDSg==
Date:   Tue, 15 Jun 2021 15:58:02 +0000
Message-ID: <PH0PR04MB7416F076827A67A7560A341F9B309@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210615121836.365105-1-wqu@suse.com>
 <20210615121836.365105-7-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:141b:f301:b8f6:a609:8f3f:1503]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c83ef815-b90c-4c39-6c7b-08d930165b15
x-ms-traffictypediagnostic: PH0PR04MB7416:
x-microsoft-antispam-prvs: <PH0PR04MB7416B2168BAECDB385B5B8209B309@PH0PR04MB7416.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 83TEPEn4wXZiBDTbcwRikCJBS/gPSsqiLTCg+4dSIEJIHQm0sjtA3L+eXPk/elCBrloqpbydT/z95M1JOckSHZIEpAFoyv2bUYOM87XNnx76RRrEGISR3s4NoL02kSFA8ihflldwzXQncL/QTkcQRJBcu7uenAzMBsQCGcbjDAmBa3cSAg8uJGbmgYCEAZ1aiIc884g8Qx5OzU/QSsX1DiCFimyMv679A841JeTXMaKZfE6CYZhMxVofh5FFm+1H10yKpaaCRWWVbwOdLCznBd3T4xyq3OlxWDbbLMbnKfNitVplUZ+iAI3yZzfJsuhMsKA+F/1fdsYQ+x6qfVXM+5VfhadtXd/gxCM89BKnuWJQ5+1ml3fiyoYOMrKbr/hwou9u8sZijGajZljHWFXsfc3PTgn32PDXljLAiN8k+eirrZlBHYRd08oYEk2CVBmjMfLFgK2lSEELGJG0K9sGpa+YS7LGagfifAMwjGa5p3Rb5QPL0RBTXfIliE8b4zBOqteyMx0wXFQMSGbX+Jers6b7Xnn9PCg14Zhl/xivh/zLbJ6h5w1kTKXxitJbxhAolkziGbYjHPx72WRLKhH2V7WerXOZzG6FW/68s+2gpUA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(64756008)(86362001)(8676002)(52536014)(71200400001)(53546011)(110136005)(478600001)(7696005)(33656002)(6506007)(186003)(8936002)(66946007)(76116006)(9686003)(122000001)(5660300002)(66556008)(38100700002)(2906002)(316002)(55016002)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9vVNLEU/y46Hyu4PkgT1MY6gUaI+EV86vv0e4J0dKiOylrlwFaH0bpDU+Nue?=
 =?us-ascii?Q?i5SA5yDx/msqWJNR9ABAQgeQs1cpdLvCKejI9MBBPmiubchsjgUITMqDRdJM?=
 =?us-ascii?Q?H+8sUqM30JVU2nPPsO4NwFmfOLKRb0zbGPavNYFBsNQBtR/H8tIdJ6XoOYfI?=
 =?us-ascii?Q?IYDYSTDceMpcIBJ7E2lfG6p++l39DsR5SNqsx+139dpnyZsdF+Fg4f+jNpZx?=
 =?us-ascii?Q?68t8a9JacDwlYI6LE1FBe/tAqP4gvQdaU8oe67edmJFWPOAu4wB52caXb0Lu?=
 =?us-ascii?Q?leNXiOAhw2uv6SmBoBWSv3uiqqxlOB5Z5Xy9tv9khBqX0KDYVW7NaM7/SEL2?=
 =?us-ascii?Q?jtZ7dMDbFeXEceqv0OxsPRvtzSOn6GijrNT8YF+DbGr1ewv3PZETCIgJS8+3?=
 =?us-ascii?Q?pnH3GPZwXXKrKJwLiaPgxoe+giGanMCk15/e3V8s+k/EKTaaMHBtilXEIwtV?=
 =?us-ascii?Q?yMnoluxEA+c4rMS4Tpa4UcjFv17Jlhdt8GeYIw6fXyl1aGR4fjnTW02BMWr5?=
 =?us-ascii?Q?fw+0Pwi1HTpr+/fy5FLvdLQvov8VimRwgT4FK7pOHuhvLRklLdbdDqkRffVT?=
 =?us-ascii?Q?6rf0iROm8BJNzkQfy75b6oPDNrDHh95bZprBPCe16bswSP+9+BLwJNfmEz+r?=
 =?us-ascii?Q?Z6o2cx6QlxGbi6hiUHS8KnkbdxatKB4/0ZgRq8b2wRtOirdNO/yGhoVjnqdq?=
 =?us-ascii?Q?+yB4XXWYndE6hpFuKNI0pFnvykH8X3hrgeZDUclqIrnIvUgIVTViArOCnRgs?=
 =?us-ascii?Q?Q36rJ9eeyQEKdoFz9jbayepkjKkrsgdRUDfh3DHFp9Ye81W841OqAFYfCHkM?=
 =?us-ascii?Q?xZs8RVUiH75qn/YClpo/yOTALfq/Zw55T9lJQgVaHi4gYgs5nz2ZD7NOBjk0?=
 =?us-ascii?Q?4k/MJkEnU70jUAC076U8FhlzPeJOdLL+ce7X37a0EwHJhEf1Ja0mrcP/IDmS?=
 =?us-ascii?Q?wH6KJHIehs1a8kitFWs7OT+Qf1oQE/CpE4GVC9F07HQvRG7wMUX3Eqa0Zlvv?=
 =?us-ascii?Q?kPeW5qZF42ndNu66hCSuvfjYcnFQGt7ZOEk/8k5wgtJlTUO+jyBzrHnOlR8Y?=
 =?us-ascii?Q?3Z8kIu6IHLzhtU0SGN7j66d6K9djzO9Yl/0/OJ+qBt0l9l9F02EczReAXs5a?=
 =?us-ascii?Q?LxUaE89bu3FdBoo52twXbhrTJXcq2DfQ6YHrFSm3mNo9YJWpx7gQdM260gsx?=
 =?us-ascii?Q?+0dXTBKZU3vgme438Ljkl4uDFrI45aI3s17pLdac4Ehu3K/HUamGO3H3nZXU?=
 =?us-ascii?Q?0ZqJb6eAEZLkVc21CXJ4yvHr/bFNvDqjKt7+UqCsZBhiNuyjkw9LKBiivqkz?=
 =?us-ascii?Q?aRYoSl69aTT/ZfLKl3IFZ9bI2waNHq2J1vFDkUXWUEtJlmjjCuw/NWbK6W6M?=
 =?us-ascii?Q?C+3bboiFeOPNFD5el1DylxoNJCaVgQPRQFTlup7aYdLYVFD9gQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83ef815-b90c-4c39-6c7b-08d930165b15
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 15:58:02.3537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjyTUgELv5IhwqCBw9VYcNOcmmqcBS1Ybkya/F4ZflJ8sU5DBpzz2K4PxJi8q8lEbV483vWWtZWI50n+pAGJSHfKCGVo0XMqSHZd2sO2ScQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7416
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/06/2021 14:18, Qu Wenruo wrote:=0A=
> +static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 d=
isk_bytenr,=0A=
> +					unsigned int opf, bio_end_io_t endio_func)=0A=
> +{=0A=
> +	struct bio *bio;=0A=
> +=0A=
> +	bio =3D btrfs_bio_alloc(disk_bytenr);=0A=
> +	/* bioset allocation should not fail */=0A=
> +	ASSERT(bio);=0A=
=0A=
Here you write that bio allocation shouldn't fail (because it's backed=0A=
by a bioset/mempool and we're not calling from IRQ context).=0A=
=0A=
[...]=0A=
=0A=
> +	bio =3D alloc_compressed_bio(cb, first_byte, bio_op | write_flags,=0A=
> +				   end_compressed_bio_write);=0A=
> +	if (IS_ERR(bio)) {=0A=
> +		kfree(cb);=0A=
> +		return errno_to_blk_status(PTR_ERR(bio));=0A=
>  	}=0A=
=0A=
Here you're checking for IS_ERR().=0A=
=0A=
> @@ -545,10 +569,14 @@ blk_status_t btrfs_submit_compressed_write(struct b=
trfs_inode *inode, u64 start,=0A=
=0A=
[...]=0A=
=0A=
> +			bio =3D alloc_compressed_bio(cb, first_byte,=0A=
> +					bio_op | write_flags,=0A=
> +					end_compressed_bio_write);=0A=
> +			if (IS_ERR(bio)) {=0A=
> +				ret =3D errno_to_blk_status(PTR_ERR(bio));=0A=
> +				bio =3D NULL;=0A=
> +				goto finish_cb;=0A=
> +			}=0A=
=0A=
same=0A=
=0A=
> @@ -812,10 +840,13 @@ blk_status_t btrfs_submit_compressed_read(struct in=
ode *inode, struct bio *bio,=0A=
=0A=
[...]=0A=
=0A=
> +	comp_bio =3D alloc_compressed_bio(cb, cur_disk_byte, REQ_OP_READ,=0A=
> +					end_compressed_bio_read);=0A=
> +	if (IS_ERR(comp_bio)) {=0A=
> +		ret =3D errno_to_blk_status(PTR_ERR(comp_bio));=0A=
> +		comp_bio =3D NULL;=0A=
> +		goto fail2;=0A=
> +	}=0A=
>  =0A=
=0A=
same=0A=
=0A=
if btrfs_bio_alloc() would have failed we'd already crash on a nullptr=0A=
dereference much earlier.=0A=
