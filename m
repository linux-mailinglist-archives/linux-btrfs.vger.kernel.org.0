Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F7839D759
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jun 2021 10:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhFGIaV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 04:30:21 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:38109 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231530AbhFGIaA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Jun 2021 04:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1623054488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9sod6nNpfL1bIkY2maZlHSbvXgIow7/smhcjE45Jz9M=;
        b=mfX+uauKnBHWNrqxo9o/YrW/5fu+i31BPRyiZbspnCwY/qLnkg+toRGBXlSYUFRT1vkDMR
        gHKHL0c0wzbpAJyrwwPNzPY605f4R9TELgq9DwhnMgU8iN9J6LdpR9CmUCIqntqDSCxO3K
        8PFJT1RarZEaft3tF1ki7i9zSxbp3Zs=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2050.outbound.protection.outlook.com [104.47.5.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-17-E4U7RYR9PzCP3LK2hc2ZsQ-1; Mon, 07 Jun 2021 10:28:07 +0200
X-MC-Unique: E4U7RYR9PzCP3LK2hc2ZsQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8dXiZkBubgzRKmw9HZUxXREkU4nhBf6ImTI8XGs79CBSTkCGX4zA4p2QCBvdShvqRwFLOQcUgnh4A8eIPYwnb3qVZUu42lSWC0ameep2OYXEVlx25Ev/UzKwkzCjNPJyw4p0o1cDBclrha6o1EPtMrrHzWIUl+nAkQGIwkocUBInnirMYp2wKuB4mfaUmzmzETcFf4ayqMcWkAPj3IguwSttOa6MRClHcaM4gtfTad6C96HDLylbJzuutSMNYz80c9UMXhkbI4qs4ZAzdYvgBtLq/+Vg/LEMF+ALAnFgP6R+nd0XW8amQl3BzTnx8kHStcq8Q3AruBHgdMm7uldRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Y3MS8ukdJbz66Hgh0PYK7xtRKBv4DTtY7TXgml5ckI=;
 b=JfzlrHN+DJxrqn46TSlGatNXPm7VBWYfLGx2iVdJojfKCuBR8g8AuQSLoyzbQ2uDY2E7TukH9xkb0G+28U31Mzsql36XWMR5HWuto93mRDjZLdeaUThtZRgX3r551o8BK+T9IL1xqoph5SXdoP9X9R56FWbFD8SynYw3N1uRjgA2mGkfBUSB8ZnfjRwXgIola3o+pjlj9Wy7vA1Ty6AxpXLtDkqkLolwqdngg1jU/PPXjdZ4EjYU9U+cty+w/8xX4uakom8j/NaakAYRGtWY3A0NkL417/IydbbcjWAV9o6gQ7ONWzNWal7zswzueHawkTRRmPpaD28B0BNVQhQc0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR0401MB2449.eurprd04.prod.outlook.com (2603:10a6:203:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.30; Mon, 7 Jun
 2021 08:28:06 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb%7]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 08:28:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210512045330.40329-1-wqu@suse.com>
 <20210512045330.40329-3-wqu@suse.com>
Subject: Re: [PATCH v5 2/3] btrfs: submit read time repair only for each
 corrupted sector
Message-ID: <ff91c259-0a0a-901e-b3bd-dbcc51b3effd@suse.com>
Date:   Mon, 7 Jun 2021 16:27:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210512045330.40329-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR06CA0036.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::49) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR06CA0036.namprd06.prod.outlook.com (2603:10b6:a03:d4::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 08:28:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef55b801-3b28-4c27-8a35-08d9298e2c62
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2449:
X-Microsoft-Antispam-PRVS: <AM5PR0401MB244988B1A48BE0201EE85ED6D6389@AM5PR0401MB2449.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CtArCaPVr0hgi/SLA1un1V8x7Dr71FAs+uevl04IBPwztxuPTKtnaDqIOhNozcfWJles0Pe3l0+rvhzkuUidbRYMzmZL27s7XEreC/Hng2QIEIy3qj6po8Ll2xN3e3MgXUTZmJa1oW78WQmXeXOsw4kOlNAGaueIwAk25QT0NKdYkDHQvoZAz1xWEMOuVIbOz69cveUw0L9C5ALogUhD7GhXdeAyhZL0qwG+fz852KshwrxhcLjBmSkT4gI4PsllVXejIlx7gUMAe8dSAvxgP7YkRGV3fke3FemgUE/2wpSp4pq6CaDBrLXGvqVRQNJbTX5cDQF9zjrb/QqUjZ6Saix93BZtOHGH2Hu5yw61HLYfAQrNQtVAr78ptCFQxn7TwQgPyIkidPjw3U1dFwUvTg2HbDbJpH6ar7U9azaQIBlwvnnFamJl0PFgmRP+qB5F/l2aXpUzmRaD29uglsEntPIqdWqAoJt7i0QkmeI9mG2XJV/lCI5OyfcZi/yOU+erfjonNNEDoZo0oi8ohhCFzs8ciq8/j7hUcWqgqYB5FMDqhnp9R9xGW4wWqLNxTk/r620/qry+PETSJHYmE2CNK88Jssnb5eXlRkSKBT15dYHEn/2/bCuJAfio6B6zAbSfRkJjeA2KeCLgA4VeDtu7H9ReTh7MkqMrkxlQwGUZlBPqqXHkvPprpgfF8ZjZ1iJr7SytQ1p5CNr0dAri50t65g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(396003)(366004)(346002)(36756003)(316002)(16576012)(2906002)(31686004)(8676002)(38100700002)(26005)(16526019)(31696002)(30864003)(66556008)(66476007)(66946007)(6486002)(83380400001)(8936002)(86362001)(956004)(2616005)(5660300002)(186003)(6916009)(6666004)(6706004)(478600001)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GyaT+YWyG5ow3lklcsSpv24LaDZaxxt+bX+ZvxcWAQ5h6iUfABaR7kCbBGgy?=
 =?us-ascii?Q?n+MW4OSXYjq3VG6qkg62QUE870j4qA1tJRvtgQRi38RoZhMEjB1KnEM0YjXK?=
 =?us-ascii?Q?LePV6SLh1HmQ+uRaGBEIvqNQslkN63oEPk4Wa6QWWilB/fHSro+RBU7ZTYuI?=
 =?us-ascii?Q?ruMMJpM7/qS9feheOIfG7i+xrM9KOxl5He+ih4s5EBVgjJ8EkhG6qRcJQmtf?=
 =?us-ascii?Q?qFjyB+dfJuFgMd4VZdwFOui216jLA7sHdDqb+LfnMWw0j8GvDaZUh8dA3g6i?=
 =?us-ascii?Q?n7rSo5qnUei44MqIGKU3mlLFKUsVQdUspTSnOxIAfY4Wj3eJ5Qj7aTJJ9O8E?=
 =?us-ascii?Q?52TT9maMwoVs6l91tuEPWrxPc33gJGzShSor4Yci395Yj3ObEM3Aexu6Ued1?=
 =?us-ascii?Q?d/1Uo+/w+TOFvxGhasbhWfw2VS1bC2wonuBpKi3owkLH+jvq+G9zgckvpOHh?=
 =?us-ascii?Q?k3wYxbiTUR3FBDMLKiMOyoMcSmmi8gXf98kfmvIrS2ovy5CtK11Qh3KyyXP+?=
 =?us-ascii?Q?PXCnnE5cVOWMDNpxspcx0A+zI+Qfi7U8XliIkOVuCl0Yf0LtYHxbIlZOQtx6?=
 =?us-ascii?Q?RsJvJF+wFm2YT2XjHtwVRe8LCsL242dwW+B3ApDtGBZeDDBpCvxHX4kZIP3Z?=
 =?us-ascii?Q?yAAGYQULVVowTOThui3DQ7xLgGo3OQZ+z/63ODMAEkvTmeLCthmUlHa5gT1+?=
 =?us-ascii?Q?mrGmHxVvZSWe4oprvJuRUWw+UIq8kL7Ayl7mK7GlurUPmfwwLGd2B0NiM39j?=
 =?us-ascii?Q?utpOAZfhab82WcHu702+fOyNXHNgXN0EPuZrRfMXbMwl8yczEc9a9aLOS81I?=
 =?us-ascii?Q?NElLdx56f8wERYmLvz8SPR1gTINQtzLMcSXDlODLEwtFFj7EIPBgRDUC+EYB?=
 =?us-ascii?Q?SsdSdgO5OcEbp52Yh5JFyNbCE/k8W+bLBrsRzH+CAvsjkmDaMPOywAj2PXtf?=
 =?us-ascii?Q?MAT2gLL2XCWv6IBnFjd4ZbsYwrnTxlU5a8ik/Cxgm2MDrqLQQoD0+gJ/3BnW?=
 =?us-ascii?Q?ESPeDf8bzhCdWT5QaNa0U/BQcdANcfIs9j6eao7xLcc5u59ONaGZrKRU3KaU?=
 =?us-ascii?Q?ioNSPj5P4bJxs7Sl4Zc6vOZTDEK9wBfioVTxdscPwCTKRORVlL+qr2KYQuWO?=
 =?us-ascii?Q?GrJp+pP2gamCpAvr7HjjfHx3mMYcAT9v1gLRem5eiKaorkDNUzb/l8lM1y0i?=
 =?us-ascii?Q?beCh+x3E9eZi1X/3sgRtA9sbezy6I8fTW872YG5QoYd6K0jbHKMBCYmAmmq9?=
 =?us-ascii?Q?l1MLvZHK8eEIN6c/shEImozEvtgw7zD8W0s7YmDro55SjITW9xbleJ9wQOMk?=
 =?us-ascii?Q?oUIvDkehrDdhWauTK/QgJazB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef55b801-3b28-4c27-8a35-08d9298e2c62
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 08:28:05.9064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+aMWFY5SIt35kQ0pJtK+Vrf+Yat4lIbHeUaJB7FeGoRGvHbOHGE+AfWeVrcY9jQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2449
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/12 =E4=B8=8B=E5=8D=8812:53, Qu Wenruo wrote:
> Currently btrfs_submit_read_repair() has some extra check on whether the
> failed bio needs extra validation for repair.
>=20
> But we can avoid all these extra mechanism if we submit the repair for
> each sector.
>=20
> By this, each read repair can be easily handled without the need to
> verify which sector is corrupted.
>=20
> This will also benefit subpage, as one subpage bvec can contain several
> sectors, making the extra verification more complex.
>=20
> So this patch will:
> - Introduce repair_one_sector()
>    The main code submitting repair, which is more or less the same as old
>    btrfs_submit_read_repair().
>    But this time, it only repairs one sector.
>=20
> - Make btrfs_submit_read_repair() to handle sectors differently
>    There are 3 different cases:
>    * Good sector
>      We need to release the page and extent, set the range uptodate.
>=20
>    * Bad sector and failed to submit repair bio
>      We need to release the page and extent, but not set the range
>      uptodate.
>=20
>    * Bad sector but repair bio submitted
>      The page and extent release will be handled by the submitted repair
>      bio. Nothing needs to be done.
>=20
>    Since btrfs_submit_read_repair() will handle the page and extent
>    release now, we need to skip to next bvec even we hit some error.
>=20
> - Change the lifespan of @uptodate in end_bio_extent_readpage()
>    Since now btrfs_submit_read_repair() will handle the full bvec
>    which contains any corruption, we don't need to bother updating
>    @uptodate bit anymore.
>    Just let @uptodate to be local variable inside the main loop,
>    so that any error from one bvec won't affect later bvec.
>=20
> - Only export btrfs_repair_one_sector(), unexport
>    btrfs_submit_read_repair()
>    The only outside caller for read repair is DIO, which already submit
>    its repair for just one sector.
>    Only export btrfs_repair_one_sector() for DIO.
>=20
> This patch will focus on the change on the repair path, the extra
> validation code is still kept as is, and will be cleaned up later.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 233 ++++++++++++++++++++++++++++---------------
>   fs/btrfs/extent_io.h |  10 +-
>   fs/btrfs/inode.c     |   9 +-
>   3 files changed, 164 insertions(+), 88 deletions(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 8b861227daef..85719947fa31 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2494,7 +2494,7 @@ void btrfs_free_io_failure_record(struct btrfs_inod=
e *inode, u64 start, u64 end)
>   }
>  =20
>   static struct io_failure_record *btrfs_get_io_failure_record(struct ino=
de *inode,
> -							     u64 start, u64 end)
> +							     u64 start)
>   {
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>   	struct io_failure_record *failrec;
> @@ -2502,6 +2502,7 @@ static struct io_failure_record *btrfs_get_io_failu=
re_record(struct inode *inode
>   	struct extent_io_tree *failure_tree =3D &BTRFS_I(inode)->io_failure_tr=
ee;
>   	struct extent_io_tree *tree =3D &BTRFS_I(inode)->io_tree;
>   	struct extent_map_tree *em_tree =3D &BTRFS_I(inode)->extent_tree;
> +	const u32 sectorsize =3D fs_info->sectorsize;
>   	int ret;
>   	u64 logical;
>  =20
> @@ -2525,7 +2526,7 @@ static struct io_failure_record *btrfs_get_io_failu=
re_record(struct inode *inode
>   		return ERR_PTR(-ENOMEM);
>  =20
>   	failrec->start =3D start;
> -	failrec->len =3D end - start + 1;
> +	failrec->len =3D sectorsize;
>   	failrec->this_mirror =3D 0;
>   	failrec->bio_flags =3D 0;
>   	failrec->in_validation =3D 0;
> @@ -2564,12 +2565,13 @@ static struct io_failure_record *btrfs_get_io_fai=
lure_record(struct inode *inode
>   	free_extent_map(em);
>  =20
>   	/* Set the bits in the private failure tree */
> -	ret =3D set_extent_bits(failure_tree, start, end,
> +	ret =3D set_extent_bits(failure_tree, start, start + sectorsize - 1,
>   			      EXTENT_LOCKED | EXTENT_DIRTY);
>   	if (ret >=3D 0) {
>   		ret =3D set_state_failrec(failure_tree, start, failrec);
>   		/* Set the bits in the inode's tree */
> -		ret =3D set_extent_bits(tree, start, end, EXTENT_DAMAGED);
> +		ret =3D set_extent_bits(tree, start, start + sectorsize - 1,
> +				      EXTENT_DAMAGED);
>   	} else if (ret < 0) {
>   		kfree(failrec);
>   		return ERR_PTR(ret);
> @@ -2697,11 +2699,11 @@ static bool btrfs_io_needs_validation(struct inod=
e *inode, struct bio *bio)
>   	return false;
>   }
>  =20
> -blk_status_t btrfs_submit_read_repair(struct inode *inode,
> -				      struct bio *failed_bio, u32 bio_offset,
> -				      struct page *page, unsigned int pgoff,
> -				      u64 start, u64 end, int failed_mirror,
> -				      submit_bio_hook_t *submit_bio_hook)
> +int btrfs_repair_one_sector(struct inode *inode,
> +			    struct bio *failed_bio, u32 bio_offset,
> +			    struct page *page, unsigned int pgoff,
> +			    u64 start, int failed_mirror,
> +			    submit_bio_hook_t *submit_bio_hook)
>   {
>   	struct io_failure_record *failrec;
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> @@ -2719,16 +2721,22 @@ blk_status_t btrfs_submit_read_repair(struct inod=
e *inode,
>  =20
>   	BUG_ON(bio_op(failed_bio) =3D=3D REQ_OP_WRITE);
>  =20
> -	failrec =3D btrfs_get_io_failure_record(inode, start, end);
> +	failrec =3D btrfs_get_io_failure_record(inode, start);
>   	if (IS_ERR(failrec))
> -		return errno_to_blk_status(PTR_ERR(failrec));
> -
> -	need_validation =3D btrfs_io_needs_validation(inode, failed_bio);
> +		return PTR_ERR(failrec);
>  =20
> +	/*
> +	 * We will only submit repair for one sector, thus we don't need
> +	 * extra validation anymore.
> +	 *
> +	 * TODO: All those extra validation related code will be cleaned up
> +	 * later.
> +	 */
> +	need_validation =3D false;
>   	if (!btrfs_check_repairable(inode, need_validation, failrec,
>   				    failed_mirror)) {
>   		free_io_failure(failure_tree, tree, failrec);
> -		return BLK_STS_IOERR;
> +		return -EIO;
>   	}
>  =20
>   	repair_bio =3D btrfs_io_bio_alloc(1);
> @@ -2762,7 +2770,120 @@ blk_status_t btrfs_submit_read_repair(struct inod=
e *inode,
>   		free_io_failure(failure_tree, tree, failrec);
>   		bio_put(repair_bio);
>   	}
> -	return status;
> +	return blk_status_to_errno(status);
> +}
> +
> +static void end_page_read(struct page *page, bool uptodate, u64 start, u=
32 len)
> +{
> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(page->mapping->host->i_sb);
> +
> +	ASSERT(page_offset(page) <=3D start &&
> +	       start + len <=3D page_offset(page) + PAGE_SIZE);
> +
> +	/*
> +	 * For subapge metadata case, all btrfs_page_* helpers needs page to
> +	 * have page::private populated.
> +	 * But we can have rare case where the last eb in the page is only
> +	 * referred by the IO, and it get released immedately after it's
> +	 * read and verified.
> +	 *
> +	 * This can detach the page private completely.
> +	 * In that case, we can just skip the page status update completely,
> +	 * as the page has no eb any more.
> +	 */

Today I hit a super rare crash, in btrfs_page_set_uptodate() for metadata.
Where the page::private is cleared.

This looks like the extent buffer freeing is still involved.

There is still a race window where the last eb we read, get freed=20
between we checking the PagePrivate and we call btrfs_page_set_uptodate().

This means, the PagePrivate() check is unsafe, we need a proper=20
protection for this case.

Thankfully, we have subpage::readers which can be easily converted to a=20
common member for both data and metadata.

For data it's kept the same behavior, but for metadata we only need to=20
skip the page unlocking.

Then teach page_range_has_eb() to make subpage::readers into=20
consideration, so that we won't detach subpage when end_page_read() is=20
still pending.

I'll send out a proper fix for this particular and rare case.

Thanks,
Qu

> +	if (fs_info->sectorsize < PAGE_SIZE && unlikely(!PagePrivate(page))) {
> +		ASSERT(!is_data_inode(page->mapping->host));
> +		return;
> +	}
> +	if (uptodate) {
> +		btrfs_page_set_uptodate(fs_info, page, start, len);
> +	} else {
> +		btrfs_page_clear_uptodate(fs_info, page, start, len);
> +		btrfs_page_set_error(fs_info, page, start, len);
> +	}
> +
> +	if (fs_info->sectorsize =3D=3D PAGE_SIZE)
> +		unlock_page(page);
> +	else if (is_data_inode(page->mapping->host))
> +		/*
> +		 * For subpage data, unlock the page if we're the last reader.
> +		 * For subpage metadata, page lock is not utilized for read.
> +		 */
> +		btrfs_subpage_end_reader(fs_info, page, start, len);
> +}
> +
> +static blk_status_t submit_read_repair(struct inode *inode,
> +				      struct bio *failed_bio, u32 bio_offset,
> +				      struct page *page, unsigned int pgoff,
> +				      u64 start, u64 end, int failed_mirror,
> +				      unsigned int error_bitmap,
> +				      submit_bio_hook_t *submit_bio_hook)
> +{
> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> +	const u32 sectorsize =3D fs_info->sectorsize;
> +	int error =3D 0;
> +	const int nr_bits =3D (end + 1 - start) >> fs_info->sectorsize_bits;
> +	int i;
> +
> +	BUG_ON(bio_op(failed_bio) =3D=3D REQ_OP_WRITE);
> +
> +	/* We're here because we had some read errors or csum mismatch */
> +	ASSERT(error_bitmap);
> +
> +	/*
> +	 * We only get called on buffered IO, thus page must be mapped and bio
> +	 * must not be cloned.
> +	 */
> +	ASSERT(page->mapping && !bio_flagged(failed_bio, BIO_CLONED));
> +
> +	/* Iterate through all the sectors in the range */
> +	for (i =3D 0; i < nr_bits; i++) {
> +		const unsigned int offset =3D i * sectorsize;
> +		struct extent_state *cached =3D NULL;
> +		bool uptodate =3D false;
> +		int ret;
> +
> +		if (!(error_bitmap & (1U << i))) {
> +			/*
> +			 * This sector has no error, just end the page read
> +			 * and unlock the range.
> +			 */
> +			uptodate =3D true;
> +			goto next;
> +		}
> +
> +		ret =3D btrfs_repair_one_sector(inode, failed_bio,
> +				bio_offset + offset,
> +				page, pgoff + offset, start + offset,
> +				failed_mirror, submit_bio_hook);
> +		if (!ret) {
> +			/*
> +			 * We have submitted the read repair, the page release
> +			 * will be handled by the endio function of the
> +			 * submitted repair bio.
> +			 * Thus we don't need to do any thing here.
> +			 */
> +			continue;
> +		}
> +		/*
> +		 * Repair failed, just record the error but still continue.
> +		 * Or the remaining sectors will not be properly unlocked.
> +		 */
> +		if (!error)
> +			error =3D ret;
> +next:
> +		end_page_read(page, uptodate, start + offset, sectorsize);
> +		if (uptodate)
> +			set_extent_uptodate(&BTRFS_I(inode)->io_tree,
> +					start + offset,
> +					start + offset + sectorsize - 1,
> +					&cached, GFP_ATOMIC);
> +		unlock_extent_cached_atomic(&BTRFS_I(inode)->io_tree,
> +				start + offset,
> +				start + offset + sectorsize - 1,
> +				&cached);
> +	}
> +	return errno_to_blk_status(error);
>   }
>  =20
>   /* lots and lots of room for performance fixes in the end_bio funcs */
> @@ -2919,45 +3040,6 @@ static void begin_page_read(struct btrfs_fs_info *=
fs_info, struct page *page)
>   	btrfs_subpage_start_reader(fs_info, page, page_offset(page), PAGE_SIZE=
);
>   }
>  =20
> -static void end_page_read(struct page *page, bool uptodate, u64 start, u=
32 len)
> -{
> -	struct btrfs_fs_info *fs_info =3D btrfs_sb(page->mapping->host->i_sb);
> -
> -	ASSERT(page_offset(page) <=3D start &&
> -		start + len <=3D page_offset(page) + PAGE_SIZE);
> -
> -	/*
> -	 * For subapge metadata case, all btrfs_page_* helpers needs page to
> -	 * have page::private populate.
> -	 * But we can have rare case where the last eb in the page is only
> -	 * referred by the IO, and it get released immedately after it's
> -	 * read and verified.
> -	 *
> -	 * This can detach the page private completely.
> -	 * In that case, we can just skip the page status update completely,
> -	 * as the page has no eb any more.
> -	 */
> -	if (fs_info->sectorsize < PAGE_SIZE && unlikely(!PagePrivate(page))) {
> -		ASSERT(!is_data_inode(page->mapping->host));
> -		return;
> -	}
> -	if (uptodate) {
> -		btrfs_page_set_uptodate(fs_info, page, start, len);
> -	} else {
> -		btrfs_page_clear_uptodate(fs_info, page, start, len);
> -		btrfs_page_set_error(fs_info, page, start, len);
> -	}
> -
> -	if (fs_info->sectorsize =3D=3D PAGE_SIZE)
> -		unlock_page(page);
> -	else if (is_data_inode(page->mapping->host))
> -		/*
> -		 * For subpage data, unlock the page if we're the last reader.
> -		 * For subpage metadata, page lock is not utilized for read.
> -		 */
> -		btrfs_subpage_end_reader(fs_info, page, start, len);
> -}
> -
>   /*
>    * Find extent buffer for a givne bytenr.
>    *
> @@ -3001,7 +3083,6 @@ static struct extent_buffer *find_extent_buffer_rea=
dpage(
>   static void end_bio_extent_readpage(struct bio *bio)
>   {
>   	struct bio_vec *bvec;
> -	int uptodate =3D !bio->bi_status;
>   	struct btrfs_io_bio *io_bio =3D btrfs_io_bio(bio);
>   	struct extent_io_tree *tree, *failure_tree;
>   	struct processed_extent processed =3D { 0 };
> @@ -3016,10 +3097,12 @@ static void end_bio_extent_readpage(struct bio *b=
io)
>  =20
>   	ASSERT(!bio_flagged(bio, BIO_CLONED));
>   	bio_for_each_segment_all(bvec, bio, iter_all) {
> +		bool uptodate =3D !bio->bi_status;
>   		struct page *page =3D bvec->bv_page;
>   		struct inode *inode =3D page->mapping->host;
>   		struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>   		const u32 sectorsize =3D fs_info->sectorsize;
> +		unsigned int error_bitmap =3D (unsigned int)-1;
>   		u64 start;
>   		u64 end;
>   		u32 len;
> @@ -3054,14 +3137,16 @@ static void end_bio_extent_readpage(struct bio *b=
io)
>  =20
>   		mirror =3D io_bio->mirror_num;
>   		if (likely(uptodate)) {
> -			if (is_data_inode(inode))
> -				ret =3D btrfs_verify_data_csum(io_bio,
> +			if (is_data_inode(inode)) {
> +				error_bitmap =3D btrfs_verify_data_csum(io_bio,
>   						bio_offset, page, start, end);
> -			else
> +				ret =3D error_bitmap;
> +			} else {
>   				ret =3D btrfs_validate_metadata_buffer(io_bio,
>   					page, start, end, mirror);
> +			}
>   			if (ret)
> -				uptodate =3D 0;
> +				uptodate =3D false;
>   			else
>   				clean_io_failure(BTRFS_I(inode)->root->fs_info,
>   						 failure_tree, tree, start,
> @@ -3073,27 +3158,19 @@ static void end_bio_extent_readpage(struct bio *b=
io)
>   			goto readpage_ok;
>  =20
>   		if (is_data_inode(inode)) {
> -
>   			/*
> -			 * The generic bio_readpage_error handles errors the
> -			 * following way: If possible, new read requests are
> -			 * created and submitted and will end up in
> -			 * end_bio_extent_readpage as well (if we're lucky,
> -			 * not in the !uptodate case). In that case it returns
> -			 * 0 and we just go on with the next page in our bio.
> -			 * If it can't handle the error it will return -EIO and
> -			 * we remain responsible for that page.
> +			 * btrfs_submit_read_repair() will handle all the
> +			 * good and bad sectors, we just continue to next
> +			 * bvec.
>   			 */
> -			if (!btrfs_submit_read_repair(inode, bio, bio_offset,
> -						page,
> -						start - page_offset(page),
> -						start, end, mirror,
> -						btrfs_submit_data_bio)) {
> -				uptodate =3D !bio->bi_status;
> -				ASSERT(bio_offset + len > bio_offset);
> -				bio_offset +=3D len;
> -				continue;
> -			}
> +			submit_read_repair(inode, bio, bio_offset, page,
> +					   start - page_offset(page), start,
> +					   end, mirror, error_bitmap,
> +					   btrfs_submit_data_bio);
> +
> +			ASSERT(bio_offset + len > bio_offset);
> +			bio_offset +=3D len;
> +			continue;
>   		} else {
>   			struct extent_buffer *eb;
>  =20
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 1d7bc27719da..c49ce96c8b5d 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -308,11 +308,11 @@ struct io_failure_record {
>   };
>  =20
>  =20
> -blk_status_t btrfs_submit_read_repair(struct inode *inode,
> -				      struct bio *failed_bio, u32 bio_offset,
> -				      struct page *page, unsigned int pgoff,
> -				      u64 start, u64 end, int failed_mirror,
> -				      submit_bio_hook_t *submit_bio_hook);
> +int btrfs_repair_one_sector(struct inode *inode,
> +			    struct bio *failed_bio, u32 bio_offset,
> +			    struct page *page, unsigned int pgoff,
> +			    u64 start, int failed_mirror,
> +			    submit_bio_hook_t *submit_bio_hook);
>  =20
>   #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>   bool find_lock_delalloc_range(struct inode *inode,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 1c019b1dc114..6e118b855239 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7938,19 +7938,18 @@ static blk_status_t btrfs_check_read_dio_bio(stru=
ct inode *inode,
>   						 btrfs_ino(BTRFS_I(inode)),
>   						 pgoff);
>   			} else {
> -				blk_status_t status;
> +				int ret;
>  =20
>   				ASSERT((start - io_bio->logical) < UINT_MAX);
> -				status =3D btrfs_submit_read_repair(inode,
> +				ret =3D btrfs_repair_one_sector(inode,
>   							&io_bio->bio,
>   							start - io_bio->logical,
>   							bvec.bv_page, pgoff,
>   							start,
> -							start + sectorsize - 1,
>   							io_bio->mirror_num,
>   							submit_dio_repair_bio);
> -				if (status)
> -					err =3D status;
> +				if (ret)
> +					err =3D errno_to_blk_status(ret);
>   			}
>   			start +=3D sectorsize;
>   			ASSERT(bio_offset + sectorsize > bio_offset);
>=20

