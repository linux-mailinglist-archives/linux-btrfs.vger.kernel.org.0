Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30B236E816
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 11:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhD2Jgj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 05:36:39 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:22545 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231501AbhD2Jgj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 05:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1619688952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=noFwe16OAthSPbD9GWQXUS3klHOoKVa4SfJ0fbvRHtM=;
        b=lVHhu3hHiwDzYYE3TZFkwq2MirYQycF86j9wB7SfhZIqu8gurrdtfUi+DZsSBn6Xq9nJVI
        ChEgvPyJ8CaQIaCIV/qvIny9XwMlkPryyYBs2Ur1so9IgzK8SAJSNy9BYBPuDI/PZrPuf4
        5mIMpL/n51a+eurbx/IsZqzM8Dhi5wA=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-23-JUE0ydMSMRSgECJN8INmIA-1; Thu, 29 Apr 2021 11:35:50 +0200
X-MC-Unique: JUE0ydMSMRSgECJN8INmIA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtGBZ3PxyMl7bgiNlsoyD+nsmj30StfqZECH1g5UrNc6MO88E/8SlylukpwKzjRgUQZrp+TUb49HxGo55WyOWBR9rxiBEojNNon9c/HPQHV9cGMuYrooZ17pN+dzHn/jblPz8OlrF4l+ltFdqNIKzSM+M+PUuZKbPe/2TDc7rbSVIJJ+aMruNgVOsx56Xg81phyuQklKtNaYGWGTs0HIQfjnmpVGWNrV3FbwxXQsuyKjDYBMO1m31Z6lkqe7p4KKUHEapkNAqkVpTRI1NMmM+C6nq0Psp+ROhVszrFKwMrsOuygcSi+9ub4Jq7RKTrQbub6Gpq4svmvbsH97KCKBHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Crgh5gZvxt6rgz6pByqgz4SlhBbxS6aqmWxMHprshWs=;
 b=ByAI5v/8CEH50JypyN/p8Rn5zoZmWx6NtAoIVNd8rwRjYAW0IHTA4wqaoyqB57s29Ugbop6Be1zGU8/L5K3toJ91miIgU6EK4lqlf4d1OuQPtKB3H97wRv2tQNWLT9xNSuSpSraqTswDwL9DJISIUVyuNAIiXpajh5jOnGEl697Em08Zj3BhUwDwG6yQnoyqjK7iEpAUIjNqsDrA2BaT+ygl1lCn8LdFrW9Lmv1+/YQLEpIMt67zObRJ4jp2jiLXWMY0Xu3vT58g2M4uUcYjIDpoUjwIe6LZFfYyqjSufixAHmrlXV/TxefkNsCy4DlYhbNB4T9VIh9mB8Dkoy5lSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB4456.eurprd04.prod.outlook.com (2603:10a6:20b:22::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 09:35:48 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7%6]) with mapi id 15.20.4065.031; Thu, 29 Apr 2021
 09:35:48 +0000
Subject: Re: [PATCH] btrfs: make read time repair to be in sectorsize unit
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210429075617.213770-1-wqu@suse.com>
Message-ID: <22b58d01-c3e1-c46a-cf14-3b24987fc1f3@suse.com>
Date:   Thu, 29 Apr 2021 17:35:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <20210429075617.213770-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:40::21) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR04CA0008.namprd04.prod.outlook.com (2603:10b6:a03:40::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Thu, 29 Apr 2021 09:35:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5499837e-c270-4903-6150-08d90af22b61
X-MS-TrafficTypeDiagnostic: AM6PR04MB4456:
X-Microsoft-Antispam-PRVS: <AM6PR04MB4456EF0E5E1422C748638474D65F9@AM6PR04MB4456.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cmtOM1HRSJoHbrzJyXavYN+HU3E87rflRD9a7xF6uHKkho7W0PasYgmbe9IIvpepYNYrcExC3Qngdt+/3D2IApemS51CUIaz2fg9HRPHn4V5WmphEjuOwtqta4s9POi3H1sua3TIJ6V3MOr2KMPOytAZ+wvIsnxnPz3K3OSEBbHmZ2Mh6Cd35Mooa7wR6AwzSwYjZcNbyI0T2aqLXHNsxidhNkEpCib0ol2huT7viXgXFQgHBAoWNFjLL659v9mOyjvosbeMwN0gtxS2yNNqYRj0N4lw4oLZvyH2xS+omPrh7dBaxXSfgrZX8fZBUQlrrnJ7nKM2v+Wm5CktmJuEFQEVKFOKRod1iKNZzrHtgBzOGE4Vqw19Q1uxw8jR9NaBd4zfN4GboOcO2vEnVz8TjXg9va3Ixy3swqxpJg27kT4Xt4yqXMeSKoCAalyR9Pm7Bx0DhwHtCs4q1k2+FmOuB/rd8atXIhUcrt2NJkyxgdJ1ZR0714F4TdU32/wa4apQLDqX82UdiwrDFm/BZ+/1m3tW6R3/EViXAA4FSOt6aEnaIGavNXkwhEW/1+pxd0A1dZHCiu+uG8oJUKjxBbbfWGTiqRQ2yKHgXS2WEmNURUm8yVGbNAEVRc9JfU0ucxFnMIMmBmAxabkjkqgPYNLnPvmpihjlbgaPE2Vu4pbgaqrAxDaMaIMjb5/ficyXKxjGILVKWhC4xxY6siz3WUoNv2vXnOB3w5aT0R7V+HTnRLM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(52116002)(38100700002)(16576012)(36756003)(26005)(66946007)(8936002)(8676002)(5660300002)(66476007)(16526019)(2906002)(6916009)(6666004)(38350700002)(478600001)(6706004)(86362001)(186003)(956004)(6486002)(2616005)(316002)(83380400001)(31696002)(30864003)(66556008)(31686004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?O8aOqKY1CuFqLddhvC/xHtgbBZJJpjgex/MKpwaDzELEcAaz6SHGwgrcbugU?=
 =?us-ascii?Q?qZkNeaU13ZdYkyJcVMTFJ4pPSrxqUsDOkmQ7piggSuTAQtS3pKDY1wR506DA?=
 =?us-ascii?Q?ne9r6MRsdvjNZnXji0iENETcUK5H79BCktOOMtXOTspmFAJVpe4e6ChDgZjX?=
 =?us-ascii?Q?71YGqNr1mJAy0lpgX9A+8cLlXRUqksazgHf8zXX426SF5zndlT64DaN6Hg1X?=
 =?us-ascii?Q?CFqC39tFUvLdFSogJIfXbRVroilrTlqUOPWAcTRQC+5CiHqs+TAtQlOUN+5E?=
 =?us-ascii?Q?CWWx/mN7KOoNMlsvAbLf0vSfFc2nA6DLb317f2K3ciLR7HZjrrYjwLr01Xty?=
 =?us-ascii?Q?V45Y1HQYDuts7R3ALgsK/dOV3sysZanAOuZVLwY1ernpzQLJkWV2qMMKWltO?=
 =?us-ascii?Q?BaLKMg6BwlV32wa5s9TUCoxMoC6jAJxc6jqP4foor2ScZoFs0IeXV2T3ZTYj?=
 =?us-ascii?Q?SqI4GK/oHMR6Snz8+B2KDUOKj6g4qyYI/pIjBLPs25PucVv2Xdg0Jvp70ayh?=
 =?us-ascii?Q?CfgEZsS0KYh5gBC9GZXSFNUcZsryH4XQJgG9VTkjqBpOxgPWdZGT189tLiKm?=
 =?us-ascii?Q?+MwUeFASXRIj2V+knDs1fQk+krsBlFUN0LDj2l2nRCqag/n5YXCQdAvHeRP7?=
 =?us-ascii?Q?V6hn+iE42ZfI4woHtSWxCg2NAaAMmPTtnXlhKBWSE5qzsx+6phyKldBZDj3K?=
 =?us-ascii?Q?BBbGCgJzaG5J9oJYsYwuWNLD5G9SHGRutQjHQcla9uXpAaPyoqtYfcihkuU8?=
 =?us-ascii?Q?DGQTc0kpvi+aO7uc0DDwzmRU6zHGsbdungTqfj/lVC2iKJUuryVjxVLl+p+N?=
 =?us-ascii?Q?RHBLjPZBPVZ6OGuXAEtpzGg+CyylnsxQkslLUovnj5xvVItGo5B0fRJqgnXh?=
 =?us-ascii?Q?BT33eHMogmYIf8ZLvuXvoLA8J5j1tz9PR/o4JGSOCqLa5qUpgHX49oIljnyD?=
 =?us-ascii?Q?JJ2rvhRZVG2BuKaG7jx14T1UgdEStg6k/jJwdOd2dbmFCYZikBEx7Um0Y1Cb?=
 =?us-ascii?Q?whT7dZtsrwfelOac8v2Y6jH6mVj65Mbh0TVVLLt4tVhy57+MtOletlmRZvat?=
 =?us-ascii?Q?jT0jvcyBuoKhqMYKp+H+q0CjyIaRrZbV8gp5pDwjwWE88t3GesjLg8U7CFNm?=
 =?us-ascii?Q?jlTHsCb0rgN5atnx394XqvzJDgQa4Os8/7D9IxdKkJFEOAsLK2F39as8mdgs?=
 =?us-ascii?Q?dfsw1Y4zst92FczStCCvuydtsV/IJWoFmZHTlmMLWrOVd3DLPcQltuP8HYBg?=
 =?us-ascii?Q?sM7WQuwQkABpyBwWHl+91/I56lnIsoHrTD08RYxdoXaYZhhnb+zvNoQtNiiy?=
 =?us-ascii?Q?TQMUwsQyNcqjfe/KmTnDJYrv?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5499837e-c270-4903-6150-08d90af22b61
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 09:35:48.4523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khwyCapBN28Qi07SYlbz+XWmllwpt+cziE4h6klfsyaIDP61T2DcOqKY7V97jGcW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4456
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/29 =E4=B8=8B=E5=8D=883:56, Qu Wenruo wrote:
> Currently btrfs_submit_read_repair() will try to repair the read range
> from the bvec.
>=20
> It works fine for regular sectorsize case, as each bvec covers just one
> sector, thus we can do per-sector repair without any problem.
>=20
> But for subpage case, it can be complex, as one bvec can covers several
> sectors.
>=20
> Previously we hack btrfs_io_needs_validation() for subpage so that we
> can submit the whole bvec range for subpage.
> This behavior reduces the repair granularity, and make subpage unable to
> repair the following file layout:
>                  0       4K      8K
>    Mirror 1      |xxxxxxx|       |
>    Mirror 2      |       |xxxxxxx|
>=20
> As for subpage case we submit one bvec which covers 2 sectors, if any
> csum mismatch happens, the whole bvec is considered corrupted, and
> above case will be considered both copies are corrupted.
>=20
> This patch will fix this problem by only submitting the repair for the
> corrupted sector(s).
>=20
> This patch will:
> - Introduce repair_one_sector()
>    The main code submitting repair, which is more or less the same as old
>    btrfs_submit_read_repair().
>    But this time, it only repair one sector.
>=20
> - Make btrfs_verify_data_csum() to return an error bitmap
>    So that new btrfs_submit_read_repair() can know exactly which
>    sector(s) needs repair.
>=20
> - Make btrfs_submit_read_repair() to handle sectors differently
>    For sectors without csum error, just release them like what we did
>    in end_bio_extent_readpage().
>    Although in this context we don't have process_extent structure, thus
>    we have to do extent tree operations sector by sector.
>    This is slower, but since it's only in csum mismatch path, it should
>    be fine.
>=20
>    For sectors with csum error, we submit repair for each sector.
>=20
> - Remove btrfs_io_needs_validation() and its callers
>    In end_bio_extent_readpage(), we already have an ASSERT() to make sure
>    all bio passed are not cloned, thus that "bio_flagged(bio, BIO_CLONED)=
"
>    branch never gets executed.
>=20
>    Then for bvec check, since we're only going to submit repair for each
>    sector, then it will always return false anyway.
>=20
>    Thus we're safe to remove this function and its callers.
>=20
> With this modification, both regular sectorsize and subpage can handle
> repair without problem.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Although this patch is more suitable for subpage patchset, this patch
> works fine for both sectorsize cases.
>=20
> Furthermore, considering how many code is modified, I'd prefer this
> patch get reviewed out of the subpage patchset.
> ---
>   fs/btrfs/extent_io.c | 229 +++++++++++++++++++------------------------
>   fs/btrfs/extent_io.h |   1 +
>   fs/btrfs/inode.c     |  14 ++-
>   3 files changed, 115 insertions(+), 129 deletions(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 14ab11381d49..1693e62d9f5b 100644
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
> @@ -2503,6 +2503,7 @@ static struct io_failure_record *btrfs_get_io_failu=
re_record(struct inode *inode
>   	struct extent_io_tree *tree =3D &BTRFS_I(inode)->io_tree;
>   	struct extent_map_tree *em_tree =3D &BTRFS_I(inode)->extent_tree;
>   	int ret;
> +	const u32 sectorsize =3D fs_info->sectorsize;
>   	u64 logical;
>  =20
>   	failrec =3D get_state_failrec(failure_tree, start);
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
> @@ -2578,7 +2580,7 @@ static struct io_failure_record *btrfs_get_io_failu=
re_record(struct inode *inode
>   	return failrec;
>   }
>  =20
> -static bool btrfs_check_repairable(struct inode *inode, bool needs_valid=
ation,
> +static bool btrfs_check_repairable(struct inode *inode,
>   				   struct io_failure_record *failrec,
>   				   int failed_mirror)
>   {
> @@ -2602,35 +2604,20 @@ static bool btrfs_check_repairable(struct inode *=
inode, bool needs_validation,
>   	 * there are two premises:
>   	 *	a) deliver good data to the caller
>   	 *	b) correct the bad sectors on disk
> +	 *
> +	 * we're ready to fulfill a) and b) alongside. get a good copy
> +	 * of the failed sector and if we succeed, we have setup
> +	 * everything for repair_io_failure to do the rest for us.
>   	 */
> -	if (needs_validation) {
> -		/*
> -		 * to fulfill b), we need to know the exact failing sectors, as
> -		 * we don't want to rewrite any more than the failed ones. thus,
> -		 * we need separate read requests for the failed bio
> -		 *
> -		 * if the following BUG_ON triggers, our validation request got
> -		 * merged. we need separate requests for our algorithm to work.
> -		 */
> -		BUG_ON(failrec->in_validation);
> -		failrec->in_validation =3D 1;
> -		failrec->this_mirror =3D failed_mirror;
> -	} else {
> -		/*
> -		 * we're ready to fulfill a) and b) alongside. get a good copy
> -		 * of the failed sector and if we succeed, we have setup
> -		 * everything for repair_io_failure to do the rest for us.
> -		 */
> -		if (failrec->in_validation) {
> -			BUG_ON(failrec->this_mirror !=3D failed_mirror);
> -			failrec->in_validation =3D 0;
> -			failrec->this_mirror =3D 0;
> -		}
> -		failrec->failed_mirror =3D failed_mirror;
> -		failrec->this_mirror++;
> -		if (failrec->this_mirror =3D=3D failed_mirror)
> -			failrec->this_mirror++;
> +	if (failrec->in_validation) {
> +		BUG_ON(failrec->this_mirror !=3D failed_mirror);
> +		failrec->in_validation =3D 0;
> +		failrec->this_mirror =3D 0;
>   	}
> +	failrec->failed_mirror =3D failed_mirror;
> +	failrec->this_mirror++;
> +	if (failrec->this_mirror =3D=3D failed_mirror)
> +		failrec->this_mirror++;
>  =20
>   	if (failrec->this_mirror > num_copies) {
>   		btrfs_debug(fs_info,
> @@ -2642,66 +2629,35 @@ static bool btrfs_check_repairable(struct inode *=
inode, bool needs_validation,
>   	return true;
>   }
>  =20
> -static bool btrfs_io_needs_validation(struct inode *inode, struct bio *b=
io)
> +static void end_page_read(struct page *page, bool uptodate, u64 start, u=
32 len)
>   {
> -	u64 len =3D 0;
> -	const u32 blocksize =3D inode->i_sb->s_blocksize;
> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(page->mapping->host->i_sb);
>  =20
> -	/*
> -	 * If bi_status is BLK_STS_OK, then this was a checksum error, not an
> -	 * I/O error. In this case, we already know exactly which sector was
> -	 * bad, so we don't need to validate.
> -	 */
> -	if (bio->bi_status =3D=3D BLK_STS_OK)
> -		return false;
> +	ASSERT(page_offset(page) <=3D start &&
> +		start + len <=3D page_offset(page) + PAGE_SIZE);
>  =20
> -	/*
> -	 * For subpage case, read bio are always submitted as multiple-sector
> -	 * bio if the range is in the same page.
> -	 * For now, let's just skip the validation, and do page sized repair.
> -	 *
> -	 * This reduce the granularity for repair, meaning if we have two
> -	 * copies with different csum mismatch at different location, we're
> -	 * unable to repair in subpage case.
> -	 *
> -	 * TODO: Make validation code to be fully subpage compatible
> -	 */
> -	if (blocksize < PAGE_SIZE)
> -		return false;
> -	/*
> -	 * We need to validate each sector individually if the failed I/O was
> -	 * for multiple sectors.
> -	 *
> -	 * There are a few possible bios that can end up here:
> -	 * 1. A buffered read bio, which is not cloned.
> -	 * 2. A direct I/O read bio, which is cloned.
> -	 * 3. A (buffered or direct) repair bio, which is not cloned.
> -	 *
> -	 * For cloned bios (case 2), we can get the size from
> -	 * btrfs_io_bio->iter; for non-cloned bios (cases 1 and 3), we can get
> -	 * it from the bvecs.
> -	 */
> -	if (bio_flagged(bio, BIO_CLONED)) {
> -		if (btrfs_io_bio(bio)->iter.bi_size > blocksize)
> -			return true;
> +	if (uptodate) {
> +		btrfs_page_set_uptodate(fs_info, page, start, len);
>   	} else {
> -		struct bio_vec *bvec;
> -		int i;
> -
> -		bio_for_each_bvec_all(bvec, bio, i) {
> -			len +=3D bvec->bv_len;
> -			if (len > blocksize)
> -				return true;
> -		}
> +		btrfs_page_clear_uptodate(fs_info, page, start, len);
> +		btrfs_page_set_error(fs_info, page, start, len);
>   	}
> -	return false;
> +
> +	if (fs_info->sectorsize =3D=3D PAGE_SIZE)
> +		unlock_page(page);
> +	else if (is_data_inode(page->mapping->host))
> +		/*
> +		 * For subpage data, unlock the page if we're the last reader.
> +		 * For subpage metadata, page lock is not utilized for read.
> +		 */
> +		btrfs_subpage_end_reader(fs_info, page, start, len);
>   }
>  =20
> -blk_status_t btrfs_submit_read_repair(struct inode *inode,
> -				      struct bio *failed_bio, u32 bio_offset,
> -				      struct page *page, unsigned int pgoff,
> -				      u64 start, u64 end, int failed_mirror,
> -				      submit_bio_hook_t *submit_bio_hook)
> +static int repair_one_sector(struct inode *inode,
> +			     struct bio *failed_bio, u32 bio_offset,
> +			     struct page *page, unsigned int pgoff,
> +			     u64 start, int failed_mirror,
> +			     submit_bio_hook_t *submit_bio_hook)
>   {
>   	struct io_failure_record *failrec;
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> @@ -2709,33 +2665,23 @@ blk_status_t btrfs_submit_read_repair(struct inod=
e *inode,
>   	struct extent_io_tree *failure_tree =3D &BTRFS_I(inode)->io_failure_tr=
ee;
>   	struct btrfs_io_bio *failed_io_bio =3D btrfs_io_bio(failed_bio);
>   	const int icsum =3D bio_offset >> fs_info->sectorsize_bits;
> -	bool need_validation;
>   	struct bio *repair_bio;
>   	struct btrfs_io_bio *repair_io_bio;
>   	blk_status_t status;
>  =20
> -	btrfs_debug(fs_info,
> -		   "repair read error: read error at %llu", start);
> -
> -	BUG_ON(bio_op(failed_bio) =3D=3D REQ_OP_WRITE);
> -
> -	failrec =3D btrfs_get_io_failure_record(inode, start, end);
> +	failrec =3D btrfs_get_io_failure_record(inode, start);
>   	if (IS_ERR(failrec))
> -		return errno_to_blk_status(PTR_ERR(failrec));
> -
> -	need_validation =3D btrfs_io_needs_validation(inode, failed_bio);
> +		return PTR_ERR(failrec);
>  =20
> -	if (!btrfs_check_repairable(inode, need_validation, failrec,
> +	if (!btrfs_check_repairable(inode, failrec,
>   				    failed_mirror)) {
>   		free_io_failure(failure_tree, tree, failrec);
> -		return BLK_STS_IOERR;
> +		return -EIO;
>   	}
>  =20
>   	repair_bio =3D btrfs_io_bio_alloc(1);
>   	repair_io_bio =3D btrfs_io_bio(repair_bio);
>   	repair_bio->bi_opf =3D REQ_OP_READ;
> -	if (need_validation)
> -		repair_bio->bi_opf |=3D REQ_FAILFAST_DEV;
>   	repair_bio->bi_end_io =3D failed_bio->bi_end_io;
>   	repair_bio->bi_iter.bi_sector =3D failrec->logical >> 9;
>   	repair_bio->bi_private =3D failed_bio->bi_private;
> @@ -2762,7 +2708,58 @@ blk_status_t btrfs_submit_read_repair(struct inode=
 *inode,
>   		free_io_failure(failure_tree, tree, failrec);
>   		bio_put(repair_bio);
>   	}
> -	return status;
> +	return blk_status_to_errno(status);
> +}
> +
> +blk_status_t btrfs_submit_read_repair(struct inode *inode,
> +				      struct bio *failed_bio, u32 bio_offset,
> +				      struct page *page,
> +				      unsigned int pgoff,
> +				      u64 start, u64 end, int failed_mirror,
> +				      int error_bitmap,
> +				      submit_bio_hook_t *submit_bio_hook)
> +{
> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> +	const u32 sectorsize =3D fs_info->sectorsize;
> +	int nr_bits =3D (end + 1 - start) / sectorsize;
> +	int i;
> +
> +	btrfs_debug(fs_info,
> +		   "repair read error: read error at %llu", start);
> +
> +	BUG_ON(bio_op(failed_bio) =3D=3D REQ_OP_WRITE);
> +
> +	ASSERT(error_bitmap);
> +	for (i =3D 0; i < nr_bits; i++) {
> +		int ret;
> +		int offset =3D i * fs_info->sectorsize;
> +		/*
> +		 * No error, end the page read just like what we did in
> +		 * readpage_ok tag of end_bio_extent_readpage()
> +		 */
> +		if (!(error_bitmap & (1 << i))) {
> +			struct extent_state *cached =3D NULL;
> +
> +			end_page_read(page, 1, start + offset, sectorsize);
> +			set_extent_uptodate(&BTRFS_I(inode)->io_tree,
> +					start + offset,
> +					start + offset + sectorsize - 1,
> +					&cached, GFP_ATOMIC);
> +			unlock_extent_cached_atomic(&BTRFS_I(inode)->io_tree,
> +					start + offset,
> +					start + offset + sectorsize - 1,
> +					&cached);
> +
> +			continue;
> +		}
> +
> +		ret =3D repair_one_sector(inode, failed_bio, bio_offset + offset,
> +				page, pgoff + offset, start + offset,
> +				failed_mirror, submit_bio_hook);
> +		if (ret < 0)
> +			return errno_to_blk_status(ret);
> +	}
> +	return BLK_STS_OK;
>   }
>  =20
>   /* lots and lots of room for performance fixes in the end_bio funcs */
> @@ -2919,30 +2916,6 @@ static void begin_page_read(struct btrfs_fs_info *=
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
> @@ -3005,6 +2978,7 @@ static void end_bio_extent_readpage(struct bio *bio=
)
>   		struct inode *inode =3D page->mapping->host;
>   		struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>   		const u32 sectorsize =3D fs_info->sectorsize;
> +		int error_bitmap;

Just got an ASSERT() triggered during generic/475, error_bitmap can be=20
uninitialzied if we failed to read the bio.

In that case, error_bitmap can be 0, and trigger the ASSERT() in=20
btrfs_submit_read_repair().

It should be initialized to -1 so that for read error we can still do=20
repair.

Will fix it in next version.

Thanks,
Qu
>   		u64 start;
>   		u64 end;
>   		u32 len;
> @@ -3039,12 +3013,14 @@ static void end_bio_extent_readpage(struct bio *b=
io)
>  =20
>   		mirror =3D io_bio->mirror_num;
>   		if (likely(uptodate)) {
> -			if (is_data_inode(inode))
> +			if (is_data_inode(inode)) {
>   				ret =3D btrfs_verify_data_csum(io_bio,
>   						bio_offset, page, start, end);
> -			else
> +				error_bitmap =3D ret;
> +			} else {
>   				ret =3D btrfs_validate_metadata_buffer(io_bio,
>   					page, start, end, mirror);
> +			}
>   			if (ret)
>   				uptodate =3D 0;
>   			else
> @@ -3073,6 +3049,7 @@ static void end_bio_extent_readpage(struct bio *bio=
)
>   						page,
>   						start - page_offset(page),
>   						start, end, mirror,
> +						error_bitmap,
>   						btrfs_submit_data_bio)) {
>   				uptodate =3D !bio->bi_status;
>   				ASSERT(bio_offset + len > bio_offset);
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 1d7bc27719da..9b78a1d9fcc7 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -312,6 +312,7 @@ blk_status_t btrfs_submit_read_repair(struct inode *i=
node,
>   				      struct bio *failed_bio, u32 bio_offset,
>   				      struct page *page, unsigned int pgoff,
>   				      u64 start, u64 end, int failed_mirror,
> +				      int error_bitmap,
>   				      submit_bio_hook_t *submit_bio_hook);
>  =20
>   #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 294d8d98280d..19dc4afe40e6 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3135,6 +3135,8 @@ static int check_data_csum(struct inode *inode, str=
uct btrfs_io_bio *io_bio,
>    * @bio_offset:	offset to the beginning of the bio (in bytes)
>    * @start:	file offset of the range start
>    * @end:	file offset of the range end (inclusive)
> + *
> + * Return the an error bitmap indicating where the error is.
>    */
>   int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
>   			   struct page *page, u64 start, u64 end)
> @@ -3144,6 +3146,7 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io_=
bio, u32 bio_offset,
>   	struct btrfs_root *root =3D BTRFS_I(inode)->root;
>   	const u32 sectorsize =3D root->fs_info->sectorsize;
>   	u32 pg_off;
> +	int result =3D 0;
>  =20
>   	if (PageChecked(page)) {
>   		ClearPageChecked(page);
> @@ -3171,10 +3174,14 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *i=
o_bio, u32 bio_offset,
>  =20
>   		ret =3D check_data_csum(inode, io_bio, bio_offset, page, pg_off,
>   				      page_offset(page) + pg_off);
> -		if (ret < 0)
> -			return -EIO;
> +		if (ret < 0) {
> +			int nr_bit =3D (pg_off - offset_in_page(start)) /
> +					sectorsize;
> +
> +			result |=3D (1 << nr_bit);
> +		}
>   	}
> -	return 0;
> +	return result;
>   }
>  =20
>   /*
> @@ -7935,6 +7942,7 @@ static blk_status_t btrfs_check_read_dio_bio(struct=
 inode *inode,
>   							start,
>   							start + sectorsize - 1,
>   							io_bio->mirror_num,
> +							1,
>   							submit_dio_repair_bio);
>   				if (status)
>   					err =3D status;
>=20

