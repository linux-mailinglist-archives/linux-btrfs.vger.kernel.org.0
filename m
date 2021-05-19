Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2437C388DD3
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 14:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346070AbhESMRY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 08:17:24 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:25907 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241057AbhESMRY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 08:17:24 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 May 2021 08:17:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1621426563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nRBmtk7Mj5Jdvbzh73bI0sjegRYB2jzf9u+ejNNnHFY=;
        b=Y6C6bCKDAFZjc44WHkVyJ1cw1JM3Jprcsi3ebj/F11c0EGjswsR8zDNHfEtwbxfrwdY737
        TMG3Jw2NpdtJ1EoP+IaerVliHtstjXS94t36OLczPsNKxLf7G2y5qJsC345a+RX8eYLc8m
        6p4JzzgtTkhjWdCIEkV17wJMXi7S2Ds=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2053.outbound.protection.outlook.com [104.47.0.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-18-Btqez4f9NdyvO8j4Egys8A-1; Wed, 19 May 2021 14:09:25 +0200
X-MC-Unique: Btqez4f9NdyvO8j4Egys8A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KM5qPn4EP5TLGG4ZkHaJq8nT6jM4weIxc0i6MSpy757i8iwP3BJxi+Vfgni1Y5/I4hjDjiNxBMjxwrpT7M/ZhisL4JWD4FP6RFCPfPacaBe7L04PG8wVr8J7Mf07cQbUJuKPmkberl3IHTHHV1P4YEPa6IaGsIDchk5ouCTjd63sGGzJCPFxVH937MPuKsfE5Uk9a8fc2sGLxZXoUChu1IV2qDQcgekofBMhfx70NZdvoLbavo0ooRkMgLALuvACloS90YN0q37mrN7bcFrzVIHWfH6WqVaMxCP9FtRrfkV2IOvVd1ICv0WMF3Jz+Xvm0LqEUmsVSqg/b/GqGawXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CniqknFmCXRKZpFqWAHapAvtkBy+SEG33d28uSNGvvM=;
 b=dw12mXWHLTu+NKANLndcLiFg7OfnDLp+YtuhaVIOv7UOSfXdXBQF+LgpKR6PxSBfC6bZQcSouQr3hiZYFvfeeuetQOMCxoSvf0XohwtP9Tfslt0Zwbs55nPo7+SBN04BY8sOrnusnqLwg62f/OucccEqZkmhm50ns8l7HxVBET539U0FFlOlYUtym9GLBywkhJVDfD4AMpq6c2iM99mU6vkLt/TolcQpKkl/chwIG2Qdxma1Y7vdD9PGZPeCoue0tIXOIH96wghMYEbIvo6gh+PkEUfeVIfJ3CXwM4MV/gHwuSpDp1TerKWPsEMwfqZ10C/OHbbrf8PAibNaPitspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB6182.eurprd04.prod.outlook.com (2603:10a6:20b:bb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 12:09:24 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb%7]) with mapi id 15.20.4129.031; Wed, 19 May 2021
 12:09:24 +0000
Subject: Re: [PATCH RFC] btrfs: introduce qgroup dirty extents threshold
 mechanism for snapshot drop and inode truncation
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20201119072828.70909-1-wqu@suse.com>
Message-ID: <a610f1cc-c169-6ce1-78c4-0fc16d816ced@suse.com>
Date:   Wed, 19 May 2021 20:09:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20201119072828.70909-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:a03:333::31) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0116.namprd03.prod.outlook.com (2603:10b6:a03:333::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.32 via Frontend Transport; Wed, 19 May 2021 12:09:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbb88be4-2a75-46f5-665a-08d91abef102
X-MS-TrafficTypeDiagnostic: AM6PR04MB6182:
X-Microsoft-Antispam-PRVS: <AM6PR04MB618226B016198BBAB00152C4D62B9@AM6PR04MB6182.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLIkU9V/XkJ+R4PC9InSoKu7l3yBhpM/mF9mb6NprMpkuPL8lHfmBmBYVqBx3SRwuplfpy6siiwt3kjFuiCpzr7DHtIO6wa8ypHk3hRvtB37dhbREGTFXoKDBQJ5xU+ohGvTiCkh3eI+lPpybkdjHDA5NZN/4WwOty1I8WO85pPd8bM0FOX5HSaqAI68vGZlaBDQn9qIG4SgXZ/qAhyeO4RxDtF62TW414TQRcnkndImTI3+tES18pHzOeq2pYQo62H8+kq2q/xJG2ltXra9fN26xI4+UZhsEb+6ABfqriEOoUQpA77ddvO58F/t9c5OTZUxnqBybN4qQhqsZngujh29m5krUyiuNqxG4TXM4Owfp3SugYtdhh3QjFntaWFG9cmKYt5Wjo1zQkPDBpAqn40PQOmK2gx46O1uhl2a+zkzvrVd7ohTrZC+P8VeyQKYloYc31ys2dy0KhzDSOwODjYjMboY2rfOA+DElJ/HHO8G3G+ZvQPMVouie41T1k5381AbR8KxjnW26Q0boJ4WYGyTVr/n4Mx6kYbkp5aqb5RZph68TfO2CVP62Y2H1xvTZUrWE9r0rJFQ87C+8RN/iJVvWRWPESiLZeMJ6tQGEl9Hqw2Ef5xqOA/zCcO/trTYav3YvGlVrav43kD/HAXuy7K6+62cWuJCcUVFulUFRzu6OhlKnMYR7DmdOn1YEWX4KxHAgwMENeiDeqmqvIir3kIpARH+kDrkIZgR08Xw4xU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(366004)(39860400002)(376002)(36756003)(6486002)(478600001)(316002)(16576012)(31696002)(86362001)(31686004)(8936002)(8676002)(26005)(83380400001)(6666004)(186003)(16526019)(5660300002)(6706004)(6916009)(956004)(66556008)(66476007)(2616005)(2906002)(66946007)(38100700002)(14143004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KWYRpSd2jVwmkppOqekmpg5lCEc5IKqHoH+IDNUdd9gpt5BBmRlbsvn+ggPi?=
 =?us-ascii?Q?kX0hW+O/+soJ9ZYM6Ip2MJbicVLPEPLddbTL4jGFUiwa8yMyASRPJQWHU7Fy?=
 =?us-ascii?Q?uaeTDsOZx34de69OBfh/QVXwv4gnbsGy+buAS4B7Fp4pQQFQ5HhI3I4gJTSo?=
 =?us-ascii?Q?BNxsy5hH2F7lYf2cpWDLaWru6pHLbKRztWrybgjmQlt9OYvnjNn3wjZuQTu9?=
 =?us-ascii?Q?taoMxVsgW53Z1/OVtlJnjgKLSmlf8NLk8ITJwE3q/NVENpb524o5pxZql8vE?=
 =?us-ascii?Q?CpGarFVm9u2XAqUv+hPcHUjPX/7GJvVg+lMqqaa7F+Lxt1QtLEdsVi3wlKBr?=
 =?us-ascii?Q?mFw8KZwhHhnYHBtO2h8ij0CQeJswRmRy01EfhOF25QXrM/JwUTvhRqb6djUI?=
 =?us-ascii?Q?2Q1clJpf1yKti8P27V7qMmEmqjrC9nq2rvmvEUogorU4OsjKmbSZh2ZdVbOT?=
 =?us-ascii?Q?lR94QQLYGVad3H4o1ksdnArbUjASu71owxZrrV+kaLx/t8JtaWfUZOGDjnPn?=
 =?us-ascii?Q?50De1XV4O9bGpY0CV6qXyudH0Pi/IXe8+cs0or75PC9v+qQEjLgcWi51dkI3?=
 =?us-ascii?Q?JklC+gtEFOllaXa2Gw/TGEEcBIOiqsRrIyNj6biXYjtnQAvEH9phb28j7KKG?=
 =?us-ascii?Q?Ve1p/IrrRLX536FQdRUM/XfCvOTW9JCNRF+Y4kwMf9HZ3vv/XCHStEZQGlbB?=
 =?us-ascii?Q?k1WZ6GNTF5Bp7Nnh28A2EkEu4vECC7+93w6zKVcIpEN56sbNhEH2a/+Ky1ed?=
 =?us-ascii?Q?+fnriFQIMjmqectrqKSXqkUVnzPOFSlfksxfmbZ7ik+vR4Y1+MF8j30V3Y/d?=
 =?us-ascii?Q?eV971K0UiPY3kzmiCADnhtiifTP4Nbv5kM/RmyrnQFXIkEj9pcZZA2vwNYvs?=
 =?us-ascii?Q?t/7u1jOOrM0Tmm5Y6Wa2kFZF5FgJPqqL0o1t/h0BMnm+mjzceGNc3PAwzMhG?=
 =?us-ascii?Q?sNRORG3hKXFFG8M22Xz8vk69o0C90NMSpyOGJwdV44yOCv42aMFfiQVGdAT8?=
 =?us-ascii?Q?HRjhoMBD5IDwDes4v+WaOF+LT0dmmXT2SdBNsw1pS5wmjU2mfXs7qCKyXAJK?=
 =?us-ascii?Q?9xuqL4tDLD2wKwLKiPhq0eEJQ1rmjMli0tQIDGvXplkEAbC+k4W6thSdP1bp?=
 =?us-ascii?Q?dYuMrU1EKtMZh7mBc7Jbhq/kCvQH3sKUJcg9IrdDgF7+UTCmFOSJz0OzlftL?=
 =?us-ascii?Q?Tcur+HnRJdganQgMHXFNojmv94xf92ERrgn2gss8oDNyI/jSKPCw0t1qUoYe?=
 =?us-ascii?Q?bp3gjB6sHELZnPJF+bsoShwk4FKtwweo80BUgucIuSjUcOq5RiUl1LKyrRXu?=
 =?us-ascii?Q?PQtM7EsPV92hiBn6LIQ2kkLi?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb88be4-2a75-46f5-665a-08d91abef102
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 12:09:24.1022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjBHdHvxF0ubP8vqfkmvUVs3IodPQlVt1nOuoZxsIT9RItasC68Cct1RCqK7Z1dI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6182
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ping?

Any comment on this?

Thanks,
Qu

On 2020/11/19 =E4=B8=8B=E5=8D=883:28, Qu Wenruo wrote:
> When dropping a lot of btrfs subvolumes with qgroup enabled, there can
> be a pretty large latency for btrfs_commit_transaction().
>=20
> The reason is, dropping subvolumes/snapshots will create a lot of extent
> owner change, thus qgroup have to traces such owner changes and cause
> latency in btrfs_commit_transaction().
>=20
> For snapshot/subvolume drop, we don't really have any good way to reduce
> the number of dirty qgroup extents.
>=20
> But least we can still reduce the latency of each
> btrfs_commit_transaction() run, by trying to commit transaction when the
> dirty qgroup extent number reaches a certain threshold.
>=20
> By this, we can commit several small transactions instead of a big and
> slow transaction.
>=20
> This patch will introduce the following things:
>=20
> - The ability to trace how many dirty qgroup extents for one transaction
>    A new member, atomic64_t nr_dirty_extents, is introduced to
>    btrfs_delayed_ref_root.
>=20
> - Introduce btrfs_should_commit_trans() helper
>    Now btrfs_should_end_transaction() will also call
>    btrfs_should_commit_trans() before returning.
>=20
> - Commit transaction for subvolume drop if we hits the threshold
> - Commit transaction for inode truncation if we hits the threshold
>=20
> There is some quick benchmarking for it.
>=20
> The fs is created by the following script:
>=20
>    for (( j =3D 0; j < 16; j++ )); do
>            btrfs subv create $mnt/src/subvol_$j
>            for (( i =3D 0; i < 512; i++)) ; do
>                    xfs_io -f -c "pwrite 0 2k" $mnt/src/subvol_$j/file_inl=
ine_$i > /dev/null
>                    xfs_io -f -c "pwrite 0 4k" $mnt/src/subvol_$j/file_reg=
_$i > /dev/null
>            done
>    done
>=20
>    sync
>=20
>    btrfs quota enable $mnt
>    btrfs quota rescan -w $mnt
>    btrfs sub delete $mnt/src/subvol*
>=20
> I tried several threshold value, the execution time for
> btrfs_qgroup_account_extents() are:
>=20
>   Threshold	| Number of calls	| Average execution time
> ------------------------------------------------------------------------
>   infinite	| 1			| 770.74ms
>   8K		| 3			| 280.47ms
>   4K		| 5			| 146.41ms
>   2K		| 9 			|  72.36ms
>   1K		| 18			|  35.97ms
>=20
> Currently I choose the 4K as the threshold for its minimal impact on the
> number of new transactions to be committed, while still keep the latency
> more or less acceptable.
>=20
> There is another hidden pitfall, if all these extents are mostly shared
> between different snapshots, current snapshot/subvolume dropping
> mechanism (breadth-first search) makes the lower level leaves to trigger
> tons of backref walk, while the higher level tree blocks will only
> trigger less and less work load.
>=20
> Thus this enhancement won't be that obvious to drop such mostly shared
> snapshots.
> To address that, we need to rework how we drop snapshots/subvolumes, and
> it would definitely be another story.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
> - The threshold value
>    Any immediate number is not flex enough, but I don't have
>    better ideas on how to set the value without introducing extra and
>    complex on-disk format change.
>    This threshold doesn't deserve that large change on on-disk format,
>    nor even a mount option.
> ---
>   fs/btrfs/delayed-ref.h | 20 ++++++++++++++++++++
>   fs/btrfs/extent-tree.c | 10 +++++++++-
>   fs/btrfs/qgroup.c      |  9 ++++++---
>   fs/btrfs/transaction.c |  3 +++
>   fs/btrfs/transaction.h | 10 ++++++++++
>   5 files changed, 48 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
> index 1c977e6d45dc..aa516b6a8fa1 100644
> --- a/fs/btrfs/delayed-ref.h
> +++ b/fs/btrfs/delayed-ref.h
> @@ -14,6 +14,23 @@
>   #define BTRFS_ADD_DELAYED_EXTENT 3 /* record a full extent allocation *=
/
>   #define BTRFS_UPDATE_DELAYED_HEAD 4 /* not changing ref count on head r=
ef */
>  =20
> +/*
> + * Soft threshold to commit transaction.
> + *
> + * Since qgroup has to do its accounting at commit transaction time, it =
can
> + * greatly impact system performance.
> + * Thus for use cases like subvolume drop, we need to throttle the numbe=
r of
> + * dirty extents in one transaction.
> + *
> + * The fixed 4K number here means we can handle 2K tree block CoWs (32Mi=
B
> + * for 16K nodesize). Or 16M (4K data extemt size) ~ 512G (128M extent s=
ize).
> + * And during test, 4K dirty qgroup extents would make
> + * btrfs_qgroup_account_extents() to take around 150ms to excute.
> + *
> + * This 4K is kinda OK for the balanced latency and extent amount.
> + */
> +#define BTRFS_QGROUP_DIRTY_EXTENTS_THRESHOLD	(SZ_4K)
> +
>   struct btrfs_delayed_ref_node {
>   	struct rb_node ref_node;
>   	/*
> @@ -174,6 +191,9 @@ struct btrfs_delayed_ref_root {
>   	 * the snapshot in new_root/old_roots or it will get calculated twice
>   	 */
>   	u64 qgroup_to_skip;
> +
> +	/* Record how many dirty extents we have in dirty_extent_root */
> +	atomic64_t nr_dirty_extents;
>   };
>  =20
>   enum btrfs_ref_type {
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 56ea380f5a17..5a7d7c02c1db 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5539,7 +5539,15 @@ int btrfs_drop_snapshot(struct btrfs_root *root, i=
nt update_ref, int for_reloc)
>   				goto out_end_trans;
>   			}
>  =20
> -			btrfs_end_transaction_throttle(trans);
> +			if (btrfs_should_commit_trans(trans)) {
> +				ret =3D btrfs_commit_transaction(trans);
> +				if (ret < 0) {
> +					err =3D ret;
> +					goto out_end_trans;
> +				}
> +			} else {
> +				btrfs_end_transaction_throttle(trans);
> +			}
>   			if (!for_reloc && btrfs_need_cleaner_sleep(fs_info)) {
>   				btrfs_debug(fs_info,
>   					    "drop snapshot early exit");
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index bf4b02a40ecc..cff484bf4f80 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1642,6 +1642,7 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_f=
s_info *fs_info,
>  =20
>   	rb_link_node(&record->node, parent_node, p);
>   	rb_insert_color(&record->node, &delayed_refs->dirty_extent_root);
> +	atomic64_inc(&delayed_refs->nr_dirty_extents);
>   	return 0;
>   }
>  =20
> @@ -2548,17 +2549,17 @@ int btrfs_qgroup_account_extents(struct btrfs_tra=
ns_handle *trans)
>   	struct btrfs_delayed_ref_root *delayed_refs;
>   	struct ulist *new_roots =3D NULL;
>   	struct rb_node *node;
> -	u64 num_dirty_extents =3D 0;
> +	u64 num_dirty_extents;
>   	u64 qgroup_to_skip;
>   	int ret =3D 0;
>  =20
>   	delayed_refs =3D &trans->transaction->delayed_refs;
> +	num_dirty_extents =3D atomic64_read(&delayed_refs->nr_dirty_extents);
>   	qgroup_to_skip =3D delayed_refs->qgroup_to_skip;
>   	while ((node =3D rb_first(&delayed_refs->dirty_extent_root))) {
>   		record =3D rb_entry(node, struct btrfs_qgroup_extent_record,
>   				  node);
>  =20
> -		num_dirty_extents++;
>   		trace_btrfs_qgroup_account_extents(fs_info, record);
>  =20
>   		if (!ret) {
> @@ -2607,10 +2608,11 @@ int btrfs_qgroup_account_extents(struct btrfs_tra=
ns_handle *trans)
>   		new_roots =3D NULL;
>   		rb_erase(node, &delayed_refs->dirty_extent_root);
>   		kfree(record);
> -
> +		atomic64_dec(&delayed_refs->nr_dirty_extents);
>   	}
>   	trace_qgroup_num_dirty_extents(fs_info, trans->transid,
>   				       num_dirty_extents);
> +	ASSERT(!atomic64_read(&delayed_refs->nr_dirty_extents));
>   	return ret;
>   }
>  =20
> @@ -4179,4 +4181,5 @@ void btrfs_qgroup_destroy_extent_records(struct btr=
fs_transaction *trans)
>   		ulist_free(entry->old_roots);
>   		kfree(entry);
>   	}
> +	atomic64_set(&trans->delayed_refs.nr_dirty_extents, 0);
>   }
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index b671ea4d80e1..4ebbf16c3113 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -354,6 +354,7 @@ static noinline int join_transaction(struct btrfs_fs_=
info *fs_info,
>   	cur_trans->delayed_refs.href_root =3D RB_ROOT_CACHED;
>   	cur_trans->delayed_refs.dirty_extent_root =3D RB_ROOT;
>   	atomic_set(&cur_trans->delayed_refs.num_entries, 0);
> +	atomic64_set(&cur_trans->delayed_refs.nr_dirty_extents, 0);
>  =20
>   	/*
>   	 * although the tree mod log is per file system and not per transactio=
n,
> @@ -912,6 +913,8 @@ int btrfs_should_end_transaction(struct btrfs_trans_h=
andle *trans)
>   {
>   	struct btrfs_transaction *cur_trans =3D trans->transaction;
>  =20
> +	if (btrfs_should_commit_trans(trans))
> +		return 1;
>   	smp_mb();
>   	if (cur_trans->state >=3D TRANS_STATE_COMMIT_START ||
>   	    cur_trans->delayed_refs.flushing)
> diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
> index 8241c050ba71..e9857182333d 100644
> --- a/fs/btrfs/transaction.h
> +++ b/fs/btrfs/transaction.h
> @@ -197,6 +197,16 @@ static inline void btrfs_clear_skip_qgroup(struct bt=
rfs_trans_handle *trans)
>   	delayed_refs->qgroup_to_skip =3D 0;
>   }
>  =20
> +static inline bool btrfs_should_commit_trans(struct btrfs_trans_handle *=
trans)
> +{
> +	struct btrfs_transaction *cur_trans =3D trans->transaction;
> +
> +	if (atomic64_read(&cur_trans->delayed_refs.nr_dirty_extents) >=3D
> +			  BTRFS_QGROUP_DIRTY_EXTENTS_THRESHOLD)
> +		return true;
> +	return false;
> +}
> +
>   int btrfs_end_transaction(struct btrfs_trans_handle *trans);
>   struct btrfs_trans_handle *btrfs_start_transaction(struct btrfs_root *r=
oot,
>   						   unsigned int num_items);
>=20

