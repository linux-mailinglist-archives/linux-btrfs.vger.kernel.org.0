Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C4E357E3C
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Apr 2021 10:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhDHIg4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Apr 2021 04:36:56 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:37924 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhDHIg4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Apr 2021 04:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1617871004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sVYSXZbjGmt2XfRYmPW2hqnJRRZE1oTJuKVigbfDE+I=;
        b=hRsFG6R55bgbJvXK8h5coaun4EC/oi7iV9LdlNC8Jcod0/5hWXUZyv/ForwCDBsv/X+7q7
        iy2+AoP2qx8N7X8/RcbnnKgWVdkAlEzGHgRZ7ME36eMHn97EzEYNYRtv40pTk1R6B49WAl
        Ln7ZSK14NUjJf/gawspBKFzTf3v5c/M=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2054.outbound.protection.outlook.com [104.47.1.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-32-MM7sG7JaOt2g6t_WlkvKCw-1; Thu, 08 Apr 2021 10:36:27 +0200
X-MC-Unique: MM7sG7JaOt2g6t_WlkvKCw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jR75xgx3Fx2yqSa3EHZxDp2vjetApE7PcoFZuom8t7sLaFfLhrbKGh8RDZyQCaCGAFJBR6YEmJKqzRtoumxQjhlSO7BLt+FHV4/guNeu7cfk1ewRlRnhrxGf8TbBsxJyscrxMmpvYrbyLvReaAhLKpqxmUMDyBdflaCnymO5ml4BbcnqBveBIjcW4IMmKvGLSR4UnJ/h8pWZ99ppKN1vkKgBF2T1c7e4bziAeJkburpihYcDJPa3jwlcYaUCWUZtXQZaG5W4DqXeQkuF6kkYnrXUq29VEA3LMORDEh2btM3lQCVr0gB083nBUQZz9XbDc8qGsBqY22mI7vdkYSBJVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSTY901PcLSru+twXGnQlWRQa5tM+aCCdP8zOuXB5jg=;
 b=hVMnZP/o2c/c6nRPuUXovAN11VapgodQzxqMH4t4bGSXn/v5P8oP5OjczwtYvjJJwR0Y/dJzQhybTcAN7vSkmaZXTflPX+iIXb0gHDtdA5uMLd6o1btqGOUUQtefXgjPdWj17olVQEi9yyPbZ85IcdKMb/RZsD/QjVa1nMG7rV8fGbofmtC6pMO9ut73Fkf1LaUB5oStAHuECKafh+sGAG8mIYtX3TfzGNmUNvr8Po9uVbOFCC6KBR3pWxMHs8TMWTq2HMWlSsJD0UP5ixppDfCPzb1/ScEJvWqWlcWtsct2NFdQyCPe76Qs2kmv7A2WpFD6tt3lBoLllS868czpXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: rkjnsn.net; dkim=none (message not signed)
 header.d=none;rkjnsn.net; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR04MB3155.eurprd04.prod.outlook.com (2603:10a6:206:4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Thu, 8 Apr
 2021 08:36:25 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7%8]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 08:36:25 +0000
Subject: Re: [PATCH v2] btrfs: do more graceful error/warning for 32bit kernel
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
CC:     Erik Jensen <erikjensen@rkjnsn.net>
References: <20210225011814.24009-1-wqu@suse.com>
Message-ID: <343a2677-8d1f-613d-920c-6e69bbf15bf0@suse.com>
Date:   Thu, 8 Apr 2021 16:36:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210225011814.24009-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::8) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR13CA0033.namprd13.prod.outlook.com (2603:10b6:a03:2c2::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend Transport; Thu, 8 Apr 2021 08:36:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41b5876f-ac37-4058-d409-08d8fa696582
X-MS-TrafficTypeDiagnostic: AM5PR04MB3155:
X-Microsoft-Antispam-PRVS: <AM5PR04MB3155AAF668A13A8F8024C497D6749@AM5PR04MB3155.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUM09/EVpSs5nx16XPRA4uB1CkWiRxM6e5jOrkPxGk20j9Xm7+FpNO2U99ZTrTXRfhosLHQ0jiTviPFZdJWtfo7mPaHT1hFfQ9UY/A/EcvlARSVX7MmUsMLdPd1UirOFFvj+EWtZgNtqTUV07sEXhl5dTVy885XExMXr2uE46QQoF2yE+exzyfvQNJ01KxQM/GZM6+O5KlFHCvkYToq86+yYQJ/tX4eMnlQmD/081w5rovhPcyiVDMwBVS81IrAe41gUX2tfLtLycMcsG6Q9/IT6nwivp0ICWtNlDhxR0aXjyet+Lqk2utHOaRNrntwf4NZ5hutfy232AVBEDUZQfSwjFAeML/WsAJ+ybET2t4KpRzVnx00KM11njUM85y/J7HMBqFdpATQ7Wsv8RCPw/TvSU6dZgTc8rjDcbr51bqx9J/uQmmAAH0mUuzA/fskCmHVOgr3172tZsxTHhvIhz3E3v2otQTxx7psYJmsjFmnjcr+4xWlpPyuEOtqi23dS7Dxw/aqNHMwV2WKm/bNwexHJAEXsYfl+UQr1sc5Za+i12ZuPaujpFaT2TIgej5WzFDdRUVvo3RPJSU+fHAK5/B5YOPMCKUBeqgjc6FLqKsyeDfrS29WXkJXfnaqX21JCkC4LgKNnoVsJCMtkDnxSMRywLkhPThAbk/fxtsyZWa3RjZIcJnQf8N6MN8uMPnyZB4eBxqyyUgq9078+0sWS2UUfo2AwXxMgPrA2asAnZeXNtCuyoCBNBnANbdxh+urkcWVj1S22mvLRfU1p5yLfEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(366004)(136003)(346002)(956004)(8936002)(83380400001)(6916009)(2616005)(6706004)(31686004)(5660300002)(66476007)(6486002)(4326008)(66556008)(86362001)(66946007)(38350700001)(38100700001)(186003)(66574015)(26005)(6666004)(36756003)(31696002)(16526019)(8676002)(316002)(2906002)(16576012)(52116002)(478600001)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?w794dQGGh0uL3LInNc/1TKjIt8ZQZLqpgKoluwDma2ezOUfCi5z3zysZjGgI?=
 =?us-ascii?Q?cmbgiRHtKjfav+snV66mnDy6w/DfUMppzvbzion9Tb9JCysPDw8sI2V0QFHF?=
 =?us-ascii?Q?+j8QOCVA2DDZWsdP/db4lLnsSIpB8eDeNzRZz4vTHAOTkMxj3JWUjzEAqSpR?=
 =?us-ascii?Q?783BZqKLM7JxIqlbXodb10XKETghCeJRUnR1EidiYTx6wbVzQ8kPclWb9wzB?=
 =?us-ascii?Q?kJXMsRWiNRchAF0gUs3bj43gLnLmE4hJKP4/77IEGQwuC6dE5nxcuKOeSutW?=
 =?us-ascii?Q?GDgxlUurSnoaNtjAaswbwsVaF1FuWZ6sxfiIFQpkxB4iGyx3EGM3xqnBQY2Z?=
 =?us-ascii?Q?BURNrE8+DO9Mv3O1TliwNXCejL6RqZ5LXn/2qA94afEwBClhrCkB+vPVLHFg?=
 =?us-ascii?Q?MzqMrA/cetrlhZNzIg/pIVEQHFGWihR9E4Qq66FSJNRaXeztC+0YIlmZ1faW?=
 =?us-ascii?Q?iBdw+YAMmyRbvn6peGZFhJffIt0Q5/TuysSiyDVtS4Ko2PtBoNNJaKQEt2xK?=
 =?us-ascii?Q?2/1o2cdWSF2qqHTynnn2VA2gOvxTdvljy+lau6oQuX5zcBO7ctcyK9V6wCaj?=
 =?us-ascii?Q?DSOuQLbRNLpVRL2GyQ8EEysRPLe+q44D61x6Xhn5B+RiCP88mqLTqHzLvQy7?=
 =?us-ascii?Q?a1VvQxVb+MGXYEr4YipaKN0bnIXk3CZYUL1IestncJq3pXkmGLbcl4AYd9l+?=
 =?us-ascii?Q?z9O4JzwyPytmQqae0V7re8Y7Y6gzjP24hZbg1XDWO0dp3V+MPN2Ir8R3Tc/P?=
 =?us-ascii?Q?kCDT5/AkmswIqdT2+hRTfv/sYwGT1FDa1How7xPr4GDmEuaYY5pyLHL4pIzY?=
 =?us-ascii?Q?/pVlW765D7stOVR2D2ZT8P8aHm8Y78/f6R4UneMKHlfqmuFmRM2X0vmeEc09?=
 =?us-ascii?Q?yltnXOTYVLsoUe2/289YNKWavctjXlbO5XjnxOb1b1kyJ6WigqBvjlB4P5Rn?=
 =?us-ascii?Q?689DP6dVUS9B9KKdWzwpzSkOrrzBeTPyeFD+TfQicmTjtn0dg2rJ0VhMlKdd?=
 =?us-ascii?Q?Ui7iiRwGcP3lnSVseTbkg8FMCmacx5jYeeYrJoMBnYtSsZOxRqrcQtVbfTqx?=
 =?us-ascii?Q?ne85XSyg28QPcSCYra5914rMwRr4Yls7KRuX2FZ9bh7GEt+3P7MrUBq4p98I?=
 =?us-ascii?Q?33zT0Y2DT3HeDQbmNWw+YTeDdcqKRISzcpdPNKzeMgJrb1MZOOTXvIrF+zjg?=
 =?us-ascii?Q?fVzzlfrFNS/iAN0++VUnlV/vDyuaHWgMyoKmCqDlDvkmRl2ICoMSGmEk4DGg?=
 =?us-ascii?Q?hSY5rC1EDN08rCU0bvsE87cK2EC8eIKZSkHPf1lu1wmNj0F47z7mj7GMjUgX?=
 =?us-ascii?Q?JH9u3mdtTZ6BZCHhmJPPMJdW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b5876f-ac37-4058-d409-08d8fa696582
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 08:36:25.6399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJ/xuCdGIlM2kHKIQ6Jp+ccKwtL6EVJ7gaxMieY98Ldmwev7V5HLXmE1B6pfDRm5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3155
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Gentle ping?

Any update? I didn't see it merged into misc-next.

Thanks,
Qu

On 2021/2/25 =E4=B8=8A=E5=8D=889:18, Qu Wenruo wrote:
> Due to the pagecache limit of 32bit systems, btrfs can't access metadata
> at or beyond (ULONG_MAX + 1) << PAGE_SHIFT.
> This is 16T for 4K page size while 256T for 64K page size.
>=20
> And unlike other fses, btrfs uses internally mapped u64 address space for
> all of its metadata, this is more tricky than other fses.
>=20
> Users can have a fs which doesn't have metadata beyond the boundary at
> mount time, but later balance can cause btrfs to create metadata beyond
> the boundary.
>=20
> And modification to MM layer is unrealistic just for such minor use
> case.
>=20
> To address such problem, this patch will introduce the following checks,
> much like how XFS handles such problem:
>=20
> - Mount time rejection
>    This will reject any fs which has metadata chunk at or beyond the
>    boundary.
>=20
> - Mount time early warning
>    If there is any metadata chunk beyond 5/8 of the boundary, we do an
>    early warning and hope the end user will see it.
>=20
> - Runtime extent buffer rejection
>    If we're going to allocate an extent buffer at or beyond the boundary,
>    reject such request with -EOVERFLOW.
>    This is definitely going to cause problems like transaction abort, but
>    we have no better ways.
>=20
> - Runtime extent buffer early warning
>    If an extent buffer beyond 5/8 of the max file size is allocated, do
>    an early warning.
>=20
> Above error/warning message will only be outputted once for each fs to
> reduce dmesg flood.
>=20
> Reported-by: Erik Jensen <erikjensen@rkjnsn.net>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Since we're here, there are some alternative methods to support 32bit
> better:
>=20
> - Multiple inodes/address spaces for metadata inodes
>    This means we would have multiple metadata inodes.
>    Inode 1 for 0~16TB, inodes 2 for 16~32TB, etc.
>=20
>    The problem is we need to have extra wrapper to read/write metadata
>    ranges.
>=20
> - Remap metadata into 0~16TB range at runtime
>    This doesn't really solve the problem, as for fs with metadata usage
>    larger than 16T, then we're busted again.
>    And the remap mechanism can be pretty complex.
>=20
> - Use an btrfs internal page cache mechanism
>    This can be the most complex way, but it would definitely solve the
>    problem.
>=20
> For now, I prefer method 1, but I still doubt about the test coverage
> for 32bit systems, and not sure if it's really worthy.
>=20
> Changelog:
> v2:
> - Calculate the boundary using PAGE_SHIFT
> - Output the calculated boundary other than hardcoded value
> ---
>   fs/btrfs/ctree.h     | 18 +++++++++++++++
>   fs/btrfs/extent_io.c | 12 ++++++++++
>   fs/btrfs/super.c     | 26 ++++++++++++++++++++++
>   fs/btrfs/volumes.c   | 53 ++++++++++++++++++++++++++++++++++++++++++--
>   4 files changed, 107 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 40ec3393d2a1..1373cae2db4f 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -572,6 +572,12 @@ enum {
>  =20
>   	/* Indicate that we can't trust the free space tree for caching yet */
>   	BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED,
> +
> +#if BITS_PER_LONG =3D=3D 32
> +	/* Indicate if we have error/warn message outputted for 32bit system */
> +	BTRFS_FS_32BIT_ERROR,
> +	BTRFS_FS_32BIT_WARN,
> +#endif
>   };
>  =20
>   /*
> @@ -3405,6 +3411,18 @@ static inline void assertfail(const char *expr, co=
nst char* file, int line) { }
>   #define ASSERT(expr)	(void)(expr)
>   #endif
>  =20
> +#if BITS_PER_LONG =3D=3D 32
> +#define BTRFS_32BIT_MAX_FILE_SIZE (((u64)ULONG_MAX + 1) << PAGE_SHIFT)
> +/*
> + * The warning threshold is 5/8 of the max file size.
> + *
> + * For 4K page size it should be 10T, for 64K it would 160T.
> + */
> +#define BTRFS_32BIT_EARLY_WARN_THRESHOLD (BTRFS_32BIT_MAX_FILE_SIZE * 5 =
/ 8)
> +void btrfs_warn_32bit_limit(struct btrfs_fs_info *fs_info);
> +void btrfs_err_32bit_limit(struct btrfs_fs_info *fs_info);
> +#endif
> +
>   /*
>    * Get the correct offset inside the page of extent buffer.
>    *
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 4dfb3ead1175..6af6714d49c1 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5554,6 +5554,18 @@ struct extent_buffer *alloc_extent_buffer(struct b=
trfs_fs_info *fs_info,
>   		return ERR_PTR(-EINVAL);
>   	}
>  =20
> +#if BITS_PER_LONG =3D=3D 32
> +	if (start >=3D MAX_LFS_FILESIZE) {
> +		btrfs_err(fs_info,
> +		"extent buffer %llu is beyond 32bit page cache limit",
> +			  start);
> +		btrfs_err_32bit_limit(fs_info);
> +		return ERR_PTR(-EOVERFLOW);
> +	}
> +	if (start >=3D BTRFS_32BIT_EARLY_WARN_THRESHOLD)
> +		btrfs_warn_32bit_limit(fs_info);
> +#endif
> +
>   	if (fs_info->sectorsize < PAGE_SIZE &&
>   	    offset_in_page(start) + len > PAGE_SIZE) {
>   		btrfs_err(fs_info,
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index f8435641b912..d3f0e5294f50 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -252,6 +252,32 @@ void __cold btrfs_printk(const struct btrfs_fs_info =
*fs_info, const char *fmt, .
>   }
>   #endif
>  =20
> +#if BITS_PER_LONG =3D=3D 32
> +void __cold btrfs_warn_32bit_limit(struct btrfs_fs_info *fs_info)
> +{
> +	if (!test_and_set_bit(BTRFS_FS_32BIT_WARN, &fs_info->flags)) {
> +		btrfs_warn(fs_info, "btrfs is reaching 32bit kernel limit.");
> +		btrfs_warn(fs_info,
> +"due to 32bit page cache limit, btrfs can't access metadata at or beyond=
 %lluT.",
> +			   BTRFS_32BIT_MAX_FILE_SIZE >> 40);
> +		btrfs_warn(fs_info,
> +			   "please consider upgrade to 64bit kernel/hardware.");
> +	}
> +}
> +
> +void __cold btrfs_err_32bit_limit(struct btrfs_fs_info *fs_info)
> +{
> +	if (!test_and_set_bit(BTRFS_FS_32BIT_ERROR, &fs_info->flags)) {
> +		btrfs_err(fs_info, "btrfs reached 32bit kernel limit.");
> +		btrfs_err(fs_info,
> +"due to 32bit page cache limit, btrfs can't access metadata at or beyond=
 %lluT.",
> +			  BTRFS_32BIT_MAX_FILE_SIZE >> 40);
> +		btrfs_err(fs_info,
> +			   "please consider upgrade to 64bit kernel/hardware.");
> +	}
> +}
> +#endif
> +
>   /*
>    * We only mark the transaction aborted and then set the file system re=
ad-only.
>    * This will prevent new transactions from starting or trying to join t=
his
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index b8fab44394f5..19a1bfe6f01b 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6787,6 +6787,46 @@ static u64 calc_stripe_length(u64 type, u64 chunk_=
len, int num_stripes)
>   	return div_u64(chunk_len, data_stripes);
>   }
>  =20
> +#if BITS_PER_LONG =3D=3D 32
> +/*
> + * Due to page cache limit, btrfs can't access metadata at or beyond
> + * BTRFS_32BIT_MAX_FILE_SIZE on 32bit systemts.
> + *
> + * This function do mount time check to reject the fs if it already has
> + * metadata chunk beyond that limit.
> + */
> +static int check_32bit_meta_chunk(struct btrfs_fs_info *fs_info,
> +				  u64 logical, u64 length, u64 type)
> +{
> +	if (!(type & BTRFS_BLOCK_GROUP_METADATA))
> +		return 0;
> +
> +	if (logical + length < MAX_LFS_FILESIZE)
> +		return 0;
> +
> +	btrfs_err_32bit_limit(fs_info);
> +	return -EOVERFLOW;
> +}
> +
> +/*
> + * This is to give early warning for any metadata chunk reaching
> + * BTRFS_32BIT_EARLY_WARN_THRESHOLD.
> + * Although we can still access the metadata, it's a timed bomb thus an =
early
> + * warning is definitely needed.
> + */
> +static void warn_32bit_meta_chunk(struct btrfs_fs_info *fs_info,
> +				  u64 logical, u64 length, u64 type)
> +{
> +	if (!(type & BTRFS_BLOCK_GROUP_METADATA))
> +		return;
> +
> +	if (logical + length < BTRFS_32BIT_EARLY_WARN_THRESHOLD)
> +		return;
> +
> +	btrfs_warn_32bit_limit(fs_info);
> +}
> +#endif
> +
>   static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *=
leaf,
>   			  struct btrfs_chunk *chunk)
>   {
> @@ -6797,6 +6837,7 @@ static int read_one_chunk(struct btrfs_key *key, st=
ruct extent_buffer *leaf,
>   	u64 logical;
>   	u64 length;
>   	u64 devid;
> +	u64 type;
>   	u8 uuid[BTRFS_UUID_SIZE];
>   	int num_stripes;
>   	int ret;
> @@ -6804,8 +6845,16 @@ static int read_one_chunk(struct btrfs_key *key, s=
truct extent_buffer *leaf,
>  =20
>   	logical =3D key->offset;
>   	length =3D btrfs_chunk_length(leaf, chunk);
> +	type =3D btrfs_chunk_type(leaf, chunk);
>   	num_stripes =3D btrfs_chunk_num_stripes(leaf, chunk);
>  =20
> +#if BITS_PER_LONG =3D=3D 32
> +	ret =3D check_32bit_meta_chunk(fs_info, logical, length, type);
> +	if (ret < 0)
> +		return ret;
> +	warn_32bit_meta_chunk(fs_info, logical, length, type);
> +#endif
> +
>   	/*
>   	 * Only need to verify chunk item if we're reading from sys chunk arra=
y,
>   	 * as chunk item in tree block is already verified by tree-checker.
> @@ -6849,10 +6898,10 @@ static int read_one_chunk(struct btrfs_key *key, =
struct extent_buffer *leaf,
>   	map->io_width =3D btrfs_chunk_io_width(leaf, chunk);
>   	map->io_align =3D btrfs_chunk_io_align(leaf, chunk);
>   	map->stripe_len =3D btrfs_chunk_stripe_len(leaf, chunk);
> -	map->type =3D btrfs_chunk_type(leaf, chunk);
> +	map->type =3D type;
>   	map->sub_stripes =3D btrfs_chunk_sub_stripes(leaf, chunk);
>   	map->verified_stripes =3D 0;
> -	em->orig_block_len =3D calc_stripe_length(map->type, em->len,
> +	em->orig_block_len =3D calc_stripe_length(type, em->len,
>   						map->num_stripes);
>   	for (i =3D 0; i < num_stripes; i++) {
>   		map->stripes[i].physical =3D
>=20

