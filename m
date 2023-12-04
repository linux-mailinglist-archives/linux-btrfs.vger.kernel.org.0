Return-Path: <linux-btrfs+bounces-592-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5AC8040BF
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 22:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D991F210AD
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 21:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC633364A6;
	Mon,  4 Dec 2023 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="UfEmkD2a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD2A107
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 13:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701724082; x=1702328882; i=quwenruo.btrfs@gmx.com;
	bh=1GD3BTJjBndMNGGRpJS8YYYLu1N3Xzq88d0uyilZ++4=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=UfEmkD2adCAEZec81y0f96WNlj4uBj31waihP55FdEwml+rZ5Np/MYr+4ebO8Dau
	 mYRCdjQ7/mqFf5AjlvhAHsb4EnsaHBrhgxtTXOqviiX15XAEHvsn5GSH27Z1P5lrW
	 FNbJ1O3ls7ZVE2X/lz7e6C6tY6g2kEFd+eZOFngPo9t6XnHL3YKBfqJLmznK0uNCO
	 VeE9LE6kRWTyl6M7xJ5MLK6gIaBuS84cCgQBEJtgmzd5X7S7bg349/Qnt/uh0j6bf
	 7S9WyMq8OeRMiNK6MbiuSFkkedHdbzBt5t3bI3s6yirm/oUlTZXAP/nwfRj+72HXh
	 kefAzdL2a9W5LqLEIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZkpb-1qmtcM3r79-00Wn2k; Mon, 04
 Dec 2023 22:08:02 +0100
Message-ID: <23711b4d-4190-41ef-b325-a11cfc752ff1@gmx.com>
Date: Tue, 5 Dec 2023 07:38:00 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] btrfs: free qgroup pertrans rsv on trans abort
Content-Language: en-US
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1701464169.git.boris@bur.io>
 <07934597eaee1e2204c204bfd34bc628708e3739.1701464169.git.boris@bur.io>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
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
In-Reply-To: <07934597eaee1e2204c204bfd34bc628708e3739.1701464169.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FfmKhARZ9NR0rWk479LPe9/KceYCinZtKoK/5NkfbupEP5BWvor
 hjGO9sOnDacL08b1i6qlJPW5mDRqvMiBqoD90fnek2qWJ00R+UYUsMyggdsh5aUu6nRFoZN
 OS/8obqRkMOsbCJep80yhyq9ccp7nPDAOlejeOZJ4b6GX38zXFlf19JcJrINdQjuxd13fqV
 ITOBbOgvI66LGyYn6qRxw==
UI-OutboundReport: notjunk:1;M01:P0:CCjb2Pw5jsE=;waB6Fx5UkHaaDwEEOXLiK/srCkQ
 YPs5eYC5slSYysEXphFYTpuhqk4xDL00b7ybcKsWUbWL5B1Jf6g8V6rrjislIgSezhON6uRwJ
 u6A9H5St4uq0toHJ/qrLrE4Otr13bfnYmNC6CaFLP0g1z2lHTSei1G+9fQlLlqGgK43TqYAcF
 Hx72JSh2P++oARMl/OvOKk20UeyiP2x5YeBWQCS3VF7lwp7anHLqRabgeRyYkLv+FQwIJGEdA
 fHGfKoBz46Xu4CkVnRSFLkPbzeO59OJXjELGarXT/Ku1BlXQEb9wdyYArw+mb9e6Ct3kyrFMe
 UDRqex4l6Wt7QPCPQcAuDFOeKxKFjtIXn3fv/FIuTbE02hsHCB3aC4Kus3A4Ux9n0mCJwNST+
 TqYf1QoWW4uqqkyOvljetzFVq8q70lfR861Ms/heU87xLBORX7UtJAKYDzPOU4NM1ioIHUfuL
 mhaNdYG2MvBBelVoAC4xOgAG5PdA/V+SprYw3m5eNQXw+ZSudkXLdyoRU+DcHPTwBcapKntd7
 juQs7Ng6XjImRrzxIxdtkCg6skxs3G4JggvlpsZbFHwfHmtqUIHN2Fk4Wsx4FpzsGqAklRYFX
 oWBZ78gVDNbve2HyDNKIeW1NpncPp9TEeI8wUEXgfBEY8MbSiEFRpFqCZCVj0rFd1JRswOID7
 TXSBYob81O3ZOYC1gp6RfQrLQnWXkw1Kp2aVB99s/PDoRAy33Od3ySYH8RBqkfW3LVISif8ZW
 QbSwxB5pIfb/w6iNBSoJgOOKT0Haw543GHyqdDGi5hSP61Kk9nE5G4YtCIx/X5NwommlAHcBd
 cu6lb+Knku6Q8lkhN13rseM5VYNaJh2DZGZoDYZgEq4RGoYTblb/BU4Dq0a3UJIfYQ1QnrPRg
 Q68fHWfr+CkCNB2YnnZx8i9yt6e+Sp/p24ffnqw3ehamClp5kQaKr6mWI7gqegsGPC6ux4VRc
 CqFI4oWE9D057QLJK8jsKDkKmw8=



On 2023/12/2 07:30, Boris Burkov wrote:
> If we abort a transaction, we never run the code that frees the pertrans
> qgroup reservation. This results in warnings on unmount as that
> reservation has been leaked. The leak isn't a huge issue since the fs is
> read-only, but it's better to clean it up when we know we can/should. Do
> it during the cleanup_transaction step of aborting.
>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/disk-io.c | 28 ++++++++++++++++++++++++++++
>   fs/btrfs/qgroup.c  |  5 +++--
>   2 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 9317606017e2..a1f440cd6d45 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4775,6 +4775,32 @@ void btrfs_cleanup_dirty_bgs(struct btrfs_transac=
tion *cur_trans,
>   	}
>   }
>
> +static void btrfs_free_all_qgroup_pertrans(struct btrfs_fs_info *fs_inf=
o)
> +{
> +	struct btrfs_root *gang[8];
> +	int i;
> +	int ret;
> +
> +	spin_lock(&fs_info->fs_roots_radix_lock);
> +	while (1) {
> +		ret =3D radix_tree_gang_lookup_tag(&fs_info->fs_roots_radix,
> +						 (void **)gang, 0,
> +						 ARRAY_SIZE(gang),
> +						 0); // BTRFS_ROOT_TRANS_TAG
> +		if (ret =3D=3D 0)
> +			break;
> +		for (i =3D 0; i < ret; i++) {
> +			struct btrfs_root *root =3D gang[i];
> +
> +			btrfs_qgroup_free_meta_all_pertrans(root);
> +			radix_tree_tag_clear(&fs_info->fs_roots_radix,
> +					(unsigned long)root->root_key.objectid,
> +					0); // BTRFS_ROOT_TRANS_TAG
> +		}
> +	}
> +	spin_unlock(&fs_info->fs_roots_radix_lock);
> +}
> +
>   void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans=
,
>   				   struct btrfs_fs_info *fs_info)
>   {
> @@ -4803,6 +4829,8 @@ void btrfs_cleanup_one_transaction(struct btrfs_tr=
ansaction *cur_trans,
>   				     EXTENT_DIRTY);
>   	btrfs_destroy_pinned_extent(fs_info, &cur_trans->pinned_extents);
>
> +	btrfs_free_all_qgroup_pertrans(fs_info);
> +
>   	cur_trans->state =3DTRANS_STATE_COMPLETED;
>   	wake_up(&cur_trans->commit_wait);
>   }
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index a953c16c7eb8..daec90342dad 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -4337,8 +4337,9 @@ static void qgroup_convert_meta(struct btrfs_fs_in=
fo *fs_info, u64 ref_root,
>
>   		qgroup_rsv_release(fs_info, qgroup, num_bytes,
>   				BTRFS_QGROUP_RSV_META_PREALLOC);
> -		qgroup_rsv_add(fs_info, qgroup, num_bytes,
> -				BTRFS_QGROUP_RSV_META_PERTRANS);
> +		if (!sb_rdonly(fs_info->sb))
> +			qgroup_rsv_add(fs_info, qgroup, num_bytes,
> +				       BTRFS_QGROUP_RSV_META_PERTRANS);
>
>   		list_for_each_entry(glist, &qgroup->groups, next_group)
>   			qgroup_iterator_add(&qgroup_list, glist->group);

