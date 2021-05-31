Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423CB3958EC
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 12:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhEaK2K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 06:28:10 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:45655 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230518AbhEaK2I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 06:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1622456782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XRNz6URmsal4DWjovooPAlyHJ0riRntwNG0XaTj4O40=;
        b=mxvZFa+89g9RugCc4CuR79U7hkJBhKXJ5/Jd38xbgAbQR8h8du11UjrxM/Vc7ZIe8JGMSj
        wSPZZhGqr0Lv6fhhLMMCoxQE5uuzMWMSbQFJV1fJvte9QkYjqNzjkpeVVm0+mG3OWJtSmR
        +Ao0SNRSqHLhaA608ECYrQMGpUyq1Nc=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2057.outbound.protection.outlook.com [104.47.0.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-15-wqoykhxGNaiTyANCEiUenw-1; Mon, 31 May 2021 12:26:20 +0200
X-MC-Unique: wqoykhxGNaiTyANCEiUenw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCElUKi6mxU3WST3Rj2oC0cjlFXnvzxEx1DLGRKOzO3hEc7YB5MLNZ25zcM8pCSB51klLCmR4uxQmTkBx15qZf7oDkSJMrnnDHLhMPLrv0LaV2YNf3ZHyELJr6e9Ifyq4aSYwDF1qtm629xwvzknAJXSKYRjepHjnc14XT6tVdjSyK/AqGYYG0012/JnHFXZM+H7nXbUaxZdXx2BYXzeYWI0znkkhMWXIZpp6IZRnLHvDJUe6iAiSOoTWmjU8T/gVviQyWdTzDiQH4jMNPpqLybetVsrLj07jXjdPwzgNmHG2Yzp1jqsku2ivhSg3gu+xiQgAxLCsK8hTsTHRPLP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uwAvpw7SB2BTMIeZ1u6cOt7CfsWxWRq1tTiowxXN/U=;
 b=AjxKZrM4DCT2AH8vIZ16K1WpQT77jeMVCMVL0fUXzRdRSzeDX57JRR7Ltc0GETQhDxznRI0dZQVHkS4R4lGRFRRR1tc5zZbJ/gubPUgWWz3x+IBO224xtdi5lCFc2wJwIeelB1Ias+e/K9pUfWBriUYfWiTZelRBsL2c7fxNA/xhwSKl2zdSQJ3SEVqL4W7mtBvGX1fXKmq5RzzDMYahs1TlWxV8JB6SPizWmgMb7UwSAaCpiLT31vCkQli8Sd6jBT5Ymz+s0chsDr/gKy2ZZddpZbJOpkh12rrQOQg6fg0EFw0JkiFOZ7yPjrOZjhUjMC8mm7DwmH/fnVMTmfNUsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB5416.eurprd04.prod.outlook.com (2603:10a6:20b:99::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Mon, 31 May
 2021 10:26:19 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb%9]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 10:26:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
CC:     Ritesh Harjani <riteshh@linux.ibm.com>
References: <20210531085106.259490-1-wqu@suse.com>
 <20210531085106.259490-30-wqu@suse.com>
Subject: Re: [PATCH v4 29/30] btrfs: fix a subpage relocation data corruption
Message-ID: <ae84347a-12f5-3513-6a46-5c34dfdc4062@suse.com>
Date:   Mon, 31 May 2021 18:26:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210531085106.259490-30-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BY5PR17CA0034.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::47) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR17CA0034.namprd17.prod.outlook.com (2603:10b6:a03:1b8::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 10:26:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9704330e-b1ef-46de-7ecf-08d9241e8742
X-MS-TrafficTypeDiagnostic: AM6PR04MB5416:
X-Microsoft-Antispam-PRVS: <AM6PR04MB5416E63DF12FB4FB72844FC2D63F9@AM6PR04MB5416.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1I/CmAyhfqjozH5RnKH3mPeDo6UsYDlqP3kxibT0lAjBsL4KztuxZaTr4AsEDGZ5H4IXLqS59xfCd8/s7xvDSYOuGTvAjuLcZGsEej/k02nFuzZXeOef2ak9H3bX49/uuyJouvNKFpxi1Ve+4d/6fLZgRTxPZnh4ybD5oPSD8kACLzruLfDUHJ3w9nFb8Bgzvt1Ume9dOVjatojTvlkBBr8j6YpbH6Wp/cbfjgbEera3T1Hb6pUok8HJ9qnlebnzxlwnKO6BXi8VM97g/9YmyjIaea1kb9UuTG2Laj9L1bXa70Hu7pgmVzGfD9owFjT99RGSiPcpobg4on2iuQkbcpnyrUVt4sZNvdPqvGaKURVR42Cfrk+0ci8ApK09fCn7/V4LzMHnwuLEGGOhek+NuiI77XfVi1VR7EoO/ffQvIgDi5+L2oz7yt+PgxvpezreddT9gAFinAP6uBHWgQ8XXuu0nw3ao//kqKSek1tt5R0vsfodGxkqbY01FRhFnkftR4sDHSGffDQ+vH3KU09SssfcHvElaYcuLsCZHpd1Ktzpo6eY1d91tDaxwgezVdclKcNgZII/B3wvq6G9RFN6S4fWz6Xw64zldke2GMgbuI7o9qABX6ZzYWSj5nad720wTdBjaH/a0Y6vxGn6Whhd5CtwPlrlpZBuaqa/bGOBOTrHaAhP7Hx0SEDHT63ww1QhhVyCHXkpVXwrQJwKsqPDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(376002)(396003)(39860400002)(6486002)(8676002)(31686004)(31696002)(478600001)(956004)(2616005)(6916009)(26005)(16576012)(2906002)(316002)(6706004)(36756003)(66476007)(66556008)(66946007)(5660300002)(83380400001)(4326008)(6666004)(38100700002)(186003)(8936002)(86362001)(16526019)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ajl1MAceg8S5FCVTkKeuFgT+KBbRZ5VDGfeBel6YCWdLakEOoILAMx4sZU67?=
 =?us-ascii?Q?bG7/sfBHaHnDDORB3TZ09zpK3gHsxpbbHC9Hd5wLfCvAwpngeD8d0xARvI81?=
 =?us-ascii?Q?ikOu0R5IVH73LoAznRYOjnGLmKUZzOO3t97WJwUCQJDApWvP5NuKY6ks6WTs?=
 =?us-ascii?Q?GQZH8P+v4+p4f+TbOZlGYXFOTJFyM6U9Ufarsmh2UHyRzvNuAv2yT2KX816q?=
 =?us-ascii?Q?bylZ+JMMfro++xlu0ndQjof1dGCj0ugpLqHyzkdb73yDhKj8UjXjIu+Nv3pc?=
 =?us-ascii?Q?6hzKPxXVOAyMSdxo1b6U9WZ+b84Evvsq6XkUOVrX50m/a1mrWVVtdxl8R3X2?=
 =?us-ascii?Q?57W3S+Y9a17U2euyHCpDLtWvTmvk4j6+rLXkgoCTdcQe887s7bWmEzDAVisk?=
 =?us-ascii?Q?mVgDv7IdwrNq4M9hed0satqld05CCQt8MzU6faUKLBpIXutg/kOS/Qf0mhFD?=
 =?us-ascii?Q?f5GF2PakGvdTBTd0g9OxKerXnPHobnNIUCm/vesC4/MbzwyPK071xjkMZFqF?=
 =?us-ascii?Q?M1RsbU6nfaToUc4MIKVyaIYlR4fhfbpfuP5V7wiHsXR7L8RPJgxF+8NSd0Xo?=
 =?us-ascii?Q?8Fm2Q2EkDXkWbcxtCd5YsOTA8sukOBJITLfVYsGhzsdrrDB34UIWVTuuiG70?=
 =?us-ascii?Q?5y6NrAvwZ5p+OFfMEejTU13OAoVYHdvNrQYaTlULx5yUti6eKOIsRozQTCD2?=
 =?us-ascii?Q?CdLFTbZ3bMrVlxmXfRerZQyh4V3gkVzRabES6F2KRDbIxYrkFp3YBvhKqBAF?=
 =?us-ascii?Q?x6fHPYSsJ+PPtrutQvf8kdL43VLPCO9QYxJWyjqZHcAQ83nFkde8OEfStN5B?=
 =?us-ascii?Q?NNgElOgEuF2t3I2Yld07w3sBM67jGD21Q/Rv2Dx+u/sUufoVqPamf+Ra0BjR?=
 =?us-ascii?Q?fPxdhWe2RQB5/giBX1kNvPMptoRFKlloK5r1I1niEiW2PHQxxVGi5cc5Lkfl?=
 =?us-ascii?Q?DldnwIxC2yY99j3OdGMV1p902aqHxj5zm0ucnm/y7d2FhlWqWofv7IBUwm1L?=
 =?us-ascii?Q?QJw3ZrBl6TBzfeFl/SnHLi6eGmrw0jmerFlUhOvzlB54tp4f9hDt4d++fW+0?=
 =?us-ascii?Q?uhi7QBnGrmZwmHgB4m/7rVy1e0g+GugHBE6zqhkUyW9yBhJMHOJjroNW9MmI?=
 =?us-ascii?Q?8xGIJtfNxayZZ7rfINNxrGi4C9Ut2wpnqF0thY5lejCkUJWT4EjWQ9IZS/sq?=
 =?us-ascii?Q?tsbhIDuomIuIwoFlrIF/96jaAgi965X8cve9OCn83wrRckx4YloRwqmvRIhF?=
 =?us-ascii?Q?AEGWlesk4iP0HkiUpWaovtt4dBFD9kPHrhM7QJ6sav0EK7FLRljxlYICXYl9?=
 =?us-ascii?Q?NuWqNu54UDnUKIz4vmab/F0R?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9704330e-b1ef-46de-7ecf-08d9241e8742
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 10:26:18.8617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OdCabfh0gaiMRgZRRh12BYslO3ESwNaCutuU2rJFRhQoQvnZSOK+wEAOgKYdkK9x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5416
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/31 =E4=B8=8B=E5=8D=884:51, Qu Wenruo wrote:
> [BUG]
> When using the following script, btrfs will report data corruption after
> one data balance with subpage support:
>=20
>    mkfs.btrfs -f -s 4k $dev
>    mount $dev -o nospace_cache $mnt
>    $fsstress -w -n 8 -s 1620948986 -d $mnt/ -v > /tmp/fsstress
>    sync
>    btrfs balance start -d $mnt
>    btrfs scrub start -B $mnt
>=20
> Similar problem can be easily observed in btrfs/028 test case, there
> will be tons of balance failure with -EIO.
>=20
> [CAUSE]
> Above fsstress will result the following data extents layout in extent
> tree:
>          item 10 key (13631488 EXTENT_ITEM 98304) itemoff 15889 itemsize =
82
>                  refs 2 gen 7 flags DATA
>                  extent data backref root FS_TREE objectid 259 offset 133=
9392 count 1
>                  extent data backref root FS_TREE objectid 259 offset 647=
168 count 1
>          item 11 key (13631488 BLOCK_GROUP_ITEM 8388608) itemoff 15865 it=
emsize 24
>                  block group used 102400 chunk_objectid 256 flags DATA
>          item 12 key (13733888 EXTENT_ITEM 4096) itemoff 15812 itemsize 5=
3
>                  refs 1 gen 7 flags DATA
>                  extent data backref root FS_TREE objectid 259 offset 729=
088 count 1
>=20
> Then when creating the data reloc inode, the data reloc inode will look
> like this:
>=20
> 	0	32K	64K	96K 100K	104K
> 	|<------ Extent A ----->|   |<- Ext B ->|
>=20
> Then when we first try to relocate extent A, we setup the data reloc
> inode with iszie 96K, then read both page [0, 64K) and page [64K, 128K).
>=20
> For page 64K, since the isize is just 96K, we fill range [96K, 128K)
> with 0 and set it uptodate.
>=20
> Then when we come to extent B, we update isize to 104K, then try to read
> page [64K, 128K).
> Then we find the page is already uptodate, so we skip the read.
> But range [96K, 128K) is filled with 0, not the real data.
>=20
> Then we writeback the data reloc inode to disk, with 0 filling range
> [96K, 128K), corrupting the content of extent B.
>=20
> The behavior is caused by the fact that we still do full page read for
> subpage case.
>=20
> The bug won't really happen for regular sectorsize, as one page only
> contains one sector.
>=20
> [FIX]
> This patch will fix the problem by invalidating range [isize, PAGE_END]
> in prealloc_file_extent_cluster().

The fix is enough to fix the data corruption, but it leaves a very rare=20
deadlock.

Above invalidating is in fact not safe, since we're not doing a proper=20
btrfs_invalidatepage().

The biggest problem here is, we can leave the page half dirty, and half=20
out-of-date.

Then later btrfs_readpage() can trigger a deadlock like this:
btrfs_readpage()
|  We already have the page locked.
|
|- btrfs_lock_and_flush_ordered_range()
    |- btrfs_start_ordered_extent()
       |- extent_write_cache_pages()
          |- pagevec_lookup_range_tag()
          |- lock_page()
             We try to lock a page which is already locked by ourselves.

This can only happen for subpage case, and normally it should never=20
happen for regular subpage opeartions.
As we either read the full the page, then update part of the page to=20
dirty, dirty the full page without reading it.

This shortcut in relocation code breaks the assumption, and could lead=20
to above deadlock.

Although I still don't like to call btrfs_invalidatepage(), here we can=20
workaround the half-dirty-half-out-of-date problem by just writing the=20
page back to disk.

This will clear the page dirty bits, and allow later clear_uptodate()=20
call to be safe.

I'll update the patchset in github repo first, and hope to merge it with=20
other feedback into next update.

Currently the test looks very promising, as the Power8 VM has survived=20
over 100 loops without crashing.

Thanks,
Qu

>=20
> So that if above example happens, when we preallocate the file extent
> for extent B, we will clear the uptodate bits for range [96K, 128K),
> allowing later relocate_one_page() to re-read the needed range.
>=20
> Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/relocation.c | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index cd50559c6d17..b50ee800993d 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2782,10 +2782,48 @@ static noinline_for_stack int prealloc_file_exten=
t_cluster(
>   	u64 num_bytes;
>   	int nr;
>   	int ret =3D 0;
> +	u64 isize =3D i_size_read(&inode->vfs_inode);
>   	u64 prealloc_start =3D cluster->start - offset;
>   	u64 prealloc_end =3D cluster->end - offset;
>   	u64 cur_offset =3D prealloc_start;
>  =20
> +	/*
> +	 * For subpage case, previous isize may not be aligned to PAGE_SIZE.
> +	 * This means the range [isize, PAGE_END + 1) is filled with 0 by
> +	 * btrfs_do_readpage() call of previously relocated file cluster.
> +	 *
> +	 * If the current cluster starts in above range, btrfs_do_readpage()
> +	 * will skip the read, and relocate_one_page() will later writeback
> +	 * the padding 0 as new data, causing data corruption.
> +	 *
> +	 * Here we have to manually invalidate the range (isize, PAGE_END + 1).
> +	 */
> +	if (!IS_ALIGNED(isize, PAGE_SIZE)) {
> +		struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> +		const u32 sectorsize =3D fs_info->sectorsize;
> +		struct page *page;
> +
> +		ASSERT(sectorsize < PAGE_SIZE);
> +		ASSERT(IS_ALIGNED(isize, sectorsize));
> +
> +		page =3D find_lock_page(inode->vfs_inode.i_mapping,
> +				      isize >> PAGE_SHIFT);
> +		/*
> +		 * If page is freed we don't need to do anything then, as
> +		 * we will re-read the whole page anyway.
> +		 */
> +		if (page) {
> +			u64 page_end =3D page_offset(page) + PAGE_SIZE - 1;
> +
> +			clear_extent_bits(&inode->io_tree, isize, page_end,
> +					  EXTENT_UPTODATE);
> +			btrfs_subpage_clear_uptodate(fs_info, page, isize,
> +						     page_end + 1 - isize);
> +			unlock_page(page);
> +			put_page(page);
> +		}
> +	}
> +
>   	BUG_ON(cluster->start !=3D cluster->boundary[0]);
>   	ret =3D btrfs_alloc_data_chunk_ondemand(inode,
>   					      prealloc_end + 1 - prealloc_start);
>=20

