Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21B5797F4F
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 01:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjIGXri (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 19:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjIGXri (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 19:47:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F00C1BCB
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 16:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1694130449; x=1694735249; i=quwenruo.btrfs@gmx.com;
 bh=jezaeQ91Qpo0JKbe4GlySdkrlEFxruYkGT4JqejQedw=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=oTqocwwBU1WlThaDL5sOTs62TVMsQrWDoSQ/hYPhxMTjww8IgsaIDSpO2OYoLMR9hc1lbJy
 Lx0szqkuu648lXUQ9Fwjd1adsdYodWAcaZEhuNO6gGN9TAkolZ4y8szvwQRtqAxBGJk2CzaIM
 rRcL+zeeFRX23sJPNGWvV/a/WtpkX15+jINA+t1MjPkpDYlPCc4vIciy+r8tJgsjTXjuKp0og
 xEVfZ49OXCC2Aux7yPp7Wt8rwVuIWhDVh14D9u/qU5Bh3wf21eJD23WhVanL7NxmDKDBXg2M8
 5kj9fpodZ0XWb2pwI9zW9ParE9/QaGgG2jJmGoS6y+++llnErEsw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhU5b-1q0gJX2sz5-00efvV; Fri, 08
 Sep 2023 01:47:29 +0200
Message-ID: <6ef75605-bd7a-4fc6-bb25-7d48724b642f@gmx.com>
Date:   Fri, 8 Sep 2023 07:47:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] btrfs: move functions comments from qgroup.h to
 qgroup.c
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1694126893.git.dsterba@suse.com>
 <a8e34e7713822d76e71f39e8b9481a79076ea9d0.1694126893.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <a8e34e7713822d76e71f39e8b9481a79076ea9d0.1694126893.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5G+4fVPSdSvCoynAv/Hgy3snS774kHAqpxU/BxbGkD7uC/BHWuH
 PSRq7xPe5oUB3rWoI+tx+fNs2PRxbL88cyW9RVxWUD30MOB++vMgrBGHC+Z6NO+3VeN9FrF
 Bnpi9hsl24EOfsb8MYddJ2otf3EmQrAFEG2ZamZjFlXWodc5r0FwzTg6kNcllPbJuvHoiuY
 zP9sF74GXNfTB/PBWlYhg==
UI-OutboundReport: notjunk:1;M01:P0:4qi7zkVa/UM=;miIPjlusHuStHMY67zCVZggB9cu
 CErwWQudvWU7un4fqi6oB/7Ws9UqgXugwrXlLUjcLUf8jJjwR7Pmmz2Ma3VWLfiZbZYhWDVxq
 zrdWEHz8tPjtvfLirLvqkFMQ/WP8KLBJfkjkybnvSDFz6cnPa+t46xKbjr626IDIqREsmAF9E
 po8+R3ggWea+e3Hbgl1f2crNG9F+LIOYdlfHi9WEoM399t7S54M4tG/mxRPCaoo1Fv9eQhp4P
 rlBNTkR+27J7x91A/teSHmBn2KuFg0oeIx1GpEi2zC3WO2FGP9IYZwFWBeR6WUo9Yl2AvpfMD
 OWYVCjUHD9sVDCLXi36WtaQjIQgk//9YMb5CVRpQSLFi4/XMach/k6t72zmCn0sZ3TK3POhBi
 6YyRuGDPFiLPBAOYOR8C0ZY2NTR4Wn6UeR7vZRotJ92UAGfolRwy1o1IZw+xTC1Ae9nPfosbk
 OWlOJpNx//pL1A1/rwade1V880SAIvkdA/RYHv9EiFHI6ujkOCKQAuvoBu27CuRru1MXprwmF
 kYd8egR4vX3OWOPcPxgBl1PYrDnluio1qlNBzZ6mC9IuY8gpjubCee6ZGpm/RbKQRfO8YqhUU
 ks5L2e5+JBioictij1DDIOalTwVN49a2uEmGDVOIA7XcdO+dvAm6PtPQRGPpmloT8pCxWDydp
 SfhWQlDGZQPz4hNNV7qRiuQ+qOzQ8haWvYJRdu+4tE+fCvlKk4oY7x/EQLUty1K+Hewh/WpbX
 OVG1dS9sSJ7wIl4BP0Zyj4KvDiHRMCfRzafu2HkE1OFiqYf8g3+AyqqrJhmslU1b1tbgcHbpA
 34tExy4SRSeOkVxn4013eTwzbgsB+CHzxNW7c6Xp6KjaPet/u8YXZs14W8g3yccSqBLnv7kNp
 ycsG2DqzdkoTS5j7kF9MUvcR8oKUZOM3075CX8+QRRajcpAiYNnXEOHBnf5lfaE8cPsPnl+Yc
 6C2ywNAV8uRjIZtzRWfZl6aOpgY=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/8 07:09, David Sterba wrote:
> We keep the comments next to the implementation, there were some left
> to move.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/qgroup.c | 71 +++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/qgroup.h | 76 -----------------------------------------------
>   2 files changed, 71 insertions(+), 76 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 127b91290e9a..a51f1ceb867a 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1793,6 +1793,17 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle =
*trans, u64 qgroupid,
>   	return ret;
>   }
>
> +/*
> + * Inform qgroup to trace one dirty extent, its info is recorded in @re=
cord.
> + * So qgroup can account it at transaction committing time.
> + *
> + * No lock version, caller must acquire delayed ref lock and allocated =
memory,
> + * then call btrfs_qgroup_trace_extent_post() after exiting lock contex=
t.
> + *
> + * Return 0 for success insert
> + * Return >0 for existing record, caller can free @record safely.
> + * Error is not possible
> + */
>   int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
>   				struct btrfs_delayed_ref_root *delayed_refs,
>   				struct btrfs_qgroup_extent_record *record)
> @@ -1828,6 +1839,27 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs=
_fs_info *fs_info,
>   	return 0;
>   }
>
> +/*
> + * Post handler after qgroup_trace_extent_nolock().
> + *
> + * NOTE: Current qgroup does the expensive backref walk at transaction
> + * committing time with TRANS_STATE_COMMIT_DOING, this blocks incoming
> + * new transaction.
> + * This is designed to allow btrfs_find_all_roots() to get correct new_=
roots
> + * result.
> + *
> + * However for old_roots there is no need to do backref walk at that ti=
me,
> + * since we search commit roots to walk backref and result will always =
be
> + * correct.
> + *
> + * Due to the nature of no lock version, we can't do backref there.
> + * So we must call btrfs_qgroup_trace_extent_post() after exiting
> + * spinlock context.
> + *
> + * TODO: If we can fix and prove btrfs_find_all_roots() can get correct=
 result
> + * using current root, then we can move all expensive backref walk out =
of
> + * transaction committing, but not now as qgroup accounting will be wro=
ng again.
> + */
>   int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
>   				   struct btrfs_qgroup_extent_record *qrecord)
>   {
> @@ -1881,6 +1913,19 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_t=
rans_handle *trans,
>   	return 0;
>   }
>
> +/*
> + * Inform qgroup to trace one dirty extent, specified by @bytenr and
> + * @num_bytes.
> + * So qgroup can account it at commit trans time.
> + *
> + * Better encapsulated version, with memory allocation and backref walk=
 for
> + * commit roots.
> + * So this can sleep.
> + *
> + * Return 0 if the operation is done.
> + * Return <0 for error, like memory allocation failure or invalid param=
eter
> + * (NULL trans)
> + */
>   int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 by=
tenr,
>   			      u64 num_bytes)
>   {
> @@ -1911,6 +1956,12 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_=
handle *trans, u64 bytenr,
>   	return btrfs_qgroup_trace_extent_post(trans, record);
>   }
>
> +/*
> + * Inform qgroup to trace all leaf items of data
> + *
> + * Return 0 for success
> + * Return <0 for error(ENOMEM)
> + */
>   int btrfs_qgroup_trace_leaf_items(struct btrfs_trans_handle *trans,
>   				  struct extent_buffer *eb)
>   {
> @@ -2341,6 +2392,16 @@ static int qgroup_trace_subtree_swap(struct btrfs=
_trans_handle *trans,
>   	return ret;
>   }
>
> +/*
> + * Inform qgroup to trace a whole subtree, including all its child tree
> + * blocks and data.
> + * The root tree block is specified by @root_eb.
> + *
> + * Normally used by relocation(tree block swap) and subvolume deletion.
> + *
> + * Return 0 for success
> + * Return <0 for error(ENOMEM or tree search error)
> + */
>   int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
>   			       struct extent_buffer *root_eb,
>   			       u64 root_gen, int root_level)
> @@ -4050,6 +4111,10 @@ int __btrfs_qgroup_reserve_meta(struct btrfs_root=
 *root, int num_bytes,
>   	return btrfs_qgroup_reserve_meta(root, num_bytes, type, enforce);
>   }
>
> +/*
> + * Per-transaction meta reservation should be all freed at transaction =
commit
> + * time
> + */
>   void btrfs_qgroup_free_meta_all_pertrans(struct btrfs_root *root)
>   {
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
> @@ -4119,6 +4184,12 @@ static void qgroup_convert_meta(struct btrfs_fs_i=
nfo *fs_info, u64 ref_root,
>   	spin_unlock(&fs_info->qgroup_lock);
>   }
>
> +/*
> + * Convert @num_bytes of META_PREALLOCATED reservation to META_PERTRANS=
.
> + *
> + * This is called when preallocated meta reservation needs to be used.
> + * Normally after btrfs_join_transaction() call.
> + */
>   void btrfs_qgroup_convert_reserved_meta(struct btrfs_root *root, int n=
um_bytes)
>   {
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index b4416d5be47d..12614bc1e70b 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -294,80 +294,16 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info =
*fs_info);
>   void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info);
>   struct btrfs_delayed_extent_op;
>
> -/*
> - * Inform qgroup to trace one dirty extent, its info is recorded in @re=
cord.
> - * So qgroup can account it at transaction committing time.
> - *
> - * No lock version, caller must acquire delayed ref lock and allocated =
memory,
> - * then call btrfs_qgroup_trace_extent_post() after exiting lock contex=
t.
> - *
> - * Return 0 for success insert
> - * Return >0 for existing record, caller can free @record safely.
> - * Error is not possible
> - */
>   int btrfs_qgroup_trace_extent_nolock(
>   		struct btrfs_fs_info *fs_info,
>   		struct btrfs_delayed_ref_root *delayed_refs,
>   		struct btrfs_qgroup_extent_record *record);
> -
> -/*
> - * Post handler after qgroup_trace_extent_nolock().
> - *
> - * NOTE: Current qgroup does the expensive backref walk at transaction
> - * committing time with TRANS_STATE_COMMIT_DOING, this blocks incoming
> - * new transaction.
> - * This is designed to allow btrfs_find_all_roots() to get correct new_=
roots
> - * result.
> - *
> - * However for old_roots there is no need to do backref walk at that ti=
me,
> - * since we search commit roots to walk backref and result will always =
be
> - * correct.
> - *
> - * Due to the nature of no lock version, we can't do backref there.
> - * So we must call btrfs_qgroup_trace_extent_post() after exiting
> - * spinlock context.
> - *
> - * TODO: If we can fix and prove btrfs_find_all_roots() can get correct=
 result
> - * using current root, then we can move all expensive backref walk out =
of
> - * transaction committing, but not now as qgroup accounting will be wro=
ng again.
> - */
>   int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
>   				   struct btrfs_qgroup_extent_record *qrecord);
> -
> -/*
> - * Inform qgroup to trace one dirty extent, specified by @bytenr and
> - * @num_bytes.
> - * So qgroup can account it at commit trans time.
> - *
> - * Better encapsulated version, with memory allocation and backref walk=
 for
> - * commit roots.
> - * So this can sleep.
> - *
> - * Return 0 if the operation is done.
> - * Return <0 for error, like memory allocation failure or invalid param=
eter
> - * (NULL trans)
> - */
>   int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 by=
tenr,
>   			      u64 num_bytes);
> -
> -/*
> - * Inform qgroup to trace all leaf items of data
> - *
> - * Return 0 for success
> - * Return <0 for error(ENOMEM)
> - */
>   int btrfs_qgroup_trace_leaf_items(struct btrfs_trans_handle *trans,
>   				  struct extent_buffer *eb);
> -/*
> - * Inform qgroup to trace a whole subtree, including all its child tree
> - * blocks and data.
> - * The root tree block is specified by @root_eb.
> - *
> - * Normally used by relocation(tree block swap) and subvolume deletion.
> - *
> - * Return 0 for success
> - * Return <0 for error(ENOMEM or tree search error)
> - */
>   int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
>   			       struct extent_buffer *root_eb,
>   			       u64 root_gen, int root_level);
> @@ -435,20 +371,8 @@ static inline void btrfs_qgroup_free_meta_prealloc(=
struct btrfs_root *root,
>   			BTRFS_QGROUP_RSV_META_PREALLOC);
>   }
>
> -/*
> - * Per-transaction meta reservation should be all freed at transaction =
commit
> - * time
> - */
>   void btrfs_qgroup_free_meta_all_pertrans(struct btrfs_root *root);
> -
> -/*
> - * Convert @num_bytes of META_PREALLOCATED reservation to META_PERTRANS=
.
> - *
> - * This is called when preallocated meta reservation needs to be used.
> - * Normally after btrfs_join_transaction() call.
> - */
>   void btrfs_qgroup_convert_reserved_meta(struct btrfs_root *root, int n=
um_bytes);
> -
>   void btrfs_qgroup_check_reserved_leak(struct btrfs_inode *inode);
>
>   /* btrfs_qgroup_swapped_blocks related functions */
