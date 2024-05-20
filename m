Return-Path: <linux-btrfs+bounces-5109-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68698C9B1D
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 12:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E453280CE7
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 10:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF31E4DA10;
	Mon, 20 May 2024 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="O6DdkQL+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C2514285
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716200446; cv=none; b=mCi9WGX1Mtp2wMYFFEOtZZsORxhr2sp+rnKk1b+J0vS89bXKLDVilPrSkmQvLo2/5FmJtIaZ+/eJAPm8X9dxdOGXs8cOobwFL4r/53e+pNbGkYbZVfC8r048COJpHiKSr4oMV3TC3Vr7thbVeoXrnoKH3xeKYkoPVO61moyE/RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716200446; c=relaxed/simple;
	bh=7sbg6l/oMi8rly8YZP8sofmVh6vwF7pauXwSmDDG9Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rt9FNtB2oiWaYxjNCmbhwg151Uxzcvyue5NEB0WmT3etb8H7GRfdLe53Kn9ZQdkLUR7iw0aajwGWiVQB8u25tbpI7kQ3ikOKOUkZ9BFS0PZjhIjmxdI3Fn38TWZ6+st6lXWAibi9bY71LqqrrpVffMcL4ExM/m3MzOwC9xU6LCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=O6DdkQL+; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1716200435; x=1716805235; i=quwenruo.btrfs@gmx.com;
	bh=vjZMO4YouaN3nKQmuGjexdHIJ621I3XkZSIz+IP9pVg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=O6DdkQL+Mvud9N3XivqNZxcC2kzu8vXc429n2SCmnBItafhdPVaUo8sgTcr8sw2z
	 k/G3JysM5tdm38DMj2venp4JPVF+ojaw11iqDm0y6/CeSO1zbUaqWtdB4DB2xhLGz
	 ZvIslCbtxPeWKb0P++U4ccifItNvd8WPP6HMuOyT6pShYADl6u3Mb88PexEDizoyt
	 KHOwzPccKC5YPLeNZVEF3oNHddrS6JWWwK3jTm5/vSK3ne089AySwQt5jTqDvl5QP
	 b72GtgMIy/iukaipbAqcIX8swW8kzgcslD6MaXqo8wj423B2IDD0P4b0OpYTxQOSw
	 IpwjltHab7qwaKFcxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAfUe-1sFZhS3MKG-00ACbn; Mon, 20
 May 2024 12:20:35 +0200
Message-ID: <e50e7918-373c-4349-a81d-e8b0dd0c0a88@gmx.com>
Date: Mon, 20 May 2024 19:50:30 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] btrfs: ensure fast fsync waits for ordered extents
 after a write failure
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1716053516.git.fdmanana@suse.com>
 <3aac8d8b6e6caab81b3726ff857684c08fb2346d.1716053516.git.fdmanana@suse.com>
Content-Language: en-US
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
In-Reply-To: <3aac8d8b6e6caab81b3726ff857684c08fb2346d.1716053516.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3UenVKs7/GCpTSYrhFTLb2JIzAULpvfgKjOWXc1jv0pA6ScqM82
 0EvKqX4PUmObCWh+9g6RJajK9o5oR1DUKQPUsB8XPYHw6/XgnkH5wkldv6T88YCHVBMXemW
 ULsxpXmQWOZnHW0L2dF0RDI3E1NIi6RKNTT7d2fVe8oMU9uZpszBvsXrZ4e9F7MhTHThjz5
 RAWkgZM4M45iDI6gP/H5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bh3Dd4Dd1+c=;35DTrkwnuVsdgDa9ZlgCXd0GMPG
 K8OV6g7EZZNul5RaHy+vg88zIgRfUBZb341RBPH+W4kISIMnAA1Qi9OTyTnfS3FJsIDRkM+LF
 ovNiZe71MxarImtYw3nU/oYN1XJFJB82XhbZd/j1U04bGYkfq+xUdTCzkm5OduwojfGBboTMu
 Av5Cxl4L66ggAwnt6f0Fl4mbqm3qrrE60eOYZ/VIHZ53526h8V079PKh4fEpuX7x1+sgFM4Hm
 sEX03LQrfpMNxQ0VDak5Gc6QslTyb5YsvepKiCW1ChzFLc+kX/8WFk0uDC+LYcYoJY4dFPPkO
 ZvIOGDPSnVz4i3ZLkdY2nUEs6Gy9re969aaqrbwzaSd596wRG1Mq8PA1Kw0Nit9f54d41Ot3P
 QLPvvxRgKquYxzSb9HAbQ7QHGaVPJtnP5i0xISs8P6GapNrfgkUDfZMqMKluGhi7nGJ/hmuGQ
 RpcEzUCIxC+LO71+4ZUeZfKUaxhl0zFto0XW9tJmrbia+vRkzwYj7voSe7zv1Ie0QMSbWc9M2
 pJMoDf8H6+7o7pgObo/KEjFpYPQlyvNrXq6OrC7GZJALxP4x00FOJmBkqZK/+ZmLoSxo+bVUR
 J8ZYEoYGYP4/Q1BTvn8kDTs++I7seI3S4MTOvGPMgFMIg5vksAN8CmzoZO4zNzk38prwPx0FR
 sdpmwJy5zVpiBb1TdvXqqCSGClJu3lMXdNAhEbrrpRZ+ooS9bWRg9iZlGGNh4YxNOygs02CFb
 75cPqjQIgCZMsxMetJM+cnBMQ6Iw7KPTb0ZYVbFLKBMHExn/czfts4RPuQRTu+Tf5+bMoPtDI
 U0zkI4Hs1wWR14elZN95XjcBDe8DfocJ89wCRNPW7LjrU=



=E5=9C=A8 2024/5/20 19:16, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> If a write path in COW mode fails, either before submitting a bio for th=
e
> new extents or an actual IO error happens, we can end up allowing a fast
> fsync to log file extent items that point to unwritten extents.
>
> This is because dropping the extent maps happens when completing ordered
> extents, at btrfs_finish_one_ordered(), and the completion of an ordered
> extent is executed in a work queue.
>
> This can result in a fast fsync to start logging file extent items based
> on existing extent maps before the ordered extents complete, therefore
> resulting in a log that has file extent items that point to unwritten
> extents, resulting in a corrupt file if a crash happens after and the lo=
g
> tree is replayed the next time the fs is mounted.
>
> This can happen for both direct IO writes and buffered writes.
>
> For example consider a direct IO write, in COW mode, that fails at
> btrfs_dio_submit_io() because btrfs_extract_ordered_extent() returned an
> error:
>
> 1) We call btrfs_finish_ordered_extent() with the 'uptodate' parameter
>     set to false, meaning an error happened;
>
> 2) That results in marking the ordered extent with the BTRFS_ORDERED_IOE=
RR
>     flag;
>
> 3) btrfs_finish_ordered_extent() queues the completion of the ordered
>     extent - so that btrfs_finish_one_ordered() will be executed later i=
n
>     a work queue. That function will drop extent maps in the range when
>     it's executed, since the extent maps point to unwritten locations
>     (signaled by the BTRFS_ORDERED_IOERR flag);
>
> 4) After calling btrfs_finish_ordered_extent() we keep going down the
>     write path and unlock the inode;
>
> 5) After that a fast fsync starts and locks the inode;
>
> 6) Before the work queue executes btrfs_finish_one_ordered(), the fsync
>     task sees the extent maps that point to the unwritten locations and
>     logs file extent items based on them - it does not know they are
>     unwritten, and the fast fsync path does not wait for ordered extents
>     to complete, which is an intentional behaviour in order to reduce
>     latency.
>
> For the buffered write case, here's one example:
>
> 1) A fast fsync begins, and it starts by flushing delalloc and waiting f=
or
>     the writeback to complete by calling filemap_fdatawait_range();
>
> 2) Flushing the dellaloc created a new extent map X;
>
> 3) During the writeback some IO error happened, and at the end io callba=
ck
>     (end_bbio_data_write()) we call btrfs_finish_ordered_extent(), which
>     sets the BTRFS_ORDERED_IOERR flag in the ordered extent and queues i=
ts
>     completion;
>
> 4) After queuing the ordered extent completion, the end io callback clea=
rs
>     the writeback flag from all pages (or folios), and from that moment =
the
>     fast fsync can proceed;
>
> 5) The fast fsync proceeds sees extent map X and logs a file extent item
>     based on extent map X, resulting in a log that points to an unwritte=
n
>     data extent - because the ordered extent completion hasn't run yet, =
it
>     happens only after the logging.
>
> To fix this make btrfs_finish_ordered_extent() set the inode flag
> BTRFS_INODE_NEEDS_FULL_SYNC in case an error happened for a COW write,
> so that a fast fsync will wait for ordered extent completion.
>
> Note that this issues of using extent maps that point to unwritten
> locations can not happen for reads, because in read paths we start by
> locking the extent range and wait for any ordered extents in the range
> to complete before looking for extent maps.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

So a new inode flag without touching the spinlock, that's a solid solution=
.

Thanks,
Qu
> ---
>   fs/btrfs/btrfs_inode.h  | 10 ++++++++++
>   fs/btrfs/file.c         | 16 ++++++++++++++++
>   fs/btrfs/ordered-data.c | 31 +++++++++++++++++++++++++++++++
>   3 files changed, 57 insertions(+)
>
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 3c8bc7a8ebdd..46db4027bf15 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -112,6 +112,16 @@ enum {
>   	 * done at new_simple_dir(), called from btrfs_lookup_dentry().
>   	 */
>   	BTRFS_INODE_ROOT_STUB,
> +	/*
> +	 * Set if an error happened when doing a COW write before submitting a
> +	 * bio or during writeback. Used for both buffered writes and direct I=
O
> +	 * writes. This is to signal a fast fsync that it has to wait for
> +	 * ordered extents to complete and therefore not log extent maps that
> +	 * point to unwritten extents (when an ordered extent completes and it
> +	 * has the BTRFS_ORDERED_IOERR flag set, it drops extent maps in its
> +	 * range).
> +	 */
> +	BTRFS_INODE_COW_WRITE_ERROR,
>   };
>
>   /* in memory btrfs inode */
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 0c7c1b42028e..00670596bf06 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1885,6 +1885,7 @@ int btrfs_sync_file(struct file *file, loff_t star=
t, loff_t end, int datasync)
>   	 */
>   	if (full_sync || btrfs_is_zoned(fs_info)) {
>   		ret =3D btrfs_wait_ordered_range(inode, start, len);
> +		clear_bit(BTRFS_INODE_COW_WRITE_ERROR, &BTRFS_I(inode)->runtime_flags=
);
>   	} else {
>   		/*
>   		 * Get our ordered extents as soon as possible to avoid doing
> @@ -1894,6 +1895,21 @@ int btrfs_sync_file(struct file *file, loff_t sta=
rt, loff_t end, int datasync)
>   		btrfs_get_ordered_extents_for_logging(BTRFS_I(inode),
>   						      &ctx.ordered_extents);
>   		ret =3D filemap_fdatawait_range(inode->i_mapping, start, end);
> +		if (ret)
> +			goto out_release_extents;
> +
> +		/*
> +		 * Check and clear the BTRFS_INODE_COW_WRITE_ERROR now after
> +		 * starting and waiting for writeback, because for buffered IO
> +		 * it may have been set during the end IO callback
> +		 * (end_bbio_data_write() -> btrfs_finish_ordered_extent()) in
> +		 * case an error happened and we need to wait for ordered
> +		 * extents to complete so that any extent maps that point to
> +		 * unwritten locations are dropped and we don't log them.
> +		 */
> +		if (test_and_clear_bit(BTRFS_INODE_COW_WRITE_ERROR,
> +				       &BTRFS_I(inode)->runtime_flags))
> +			ret =3D btrfs_wait_ordered_range(inode, start, len);
>   	}
>
>   	if (ret)
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 44157e43fd2a..7d175d10a6d0 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -388,6 +388,37 @@ bool btrfs_finish_ordered_extent(struct btrfs_order=
ed_extent *ordered,
>   	ret =3D can_finish_ordered_extent(ordered, page, file_offset, len, up=
todate);
>   	spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
>
> +	/*
> +	 * If this is a COW write it means we created new extent maps for the
> +	 * range and they point to unwritten locations if we got an error eith=
er
> +	 * before submitting a bio or during IO.
> +	 *
> +	 * We have marked the ordered extent with BTRFS_ORDERED_IOERR, and we
> +	 * are queuing its completion below. During completion, at
> +	 * btrfs_finish_one_ordered(), we will drop the extent maps for the
> +	 * unwritten extents.
> +	 *
> +	 * However because completion runs in a work queue we can end up havin=
g
> +	 * a fast fsync running before that. In the case of direct IO, once we
> +	 * unlock the inode the fsync might start, and we queue the completion
> +	 * before unlocking the inode. In the case of buffered IO when writeba=
ck
> +	 * finishes (end_bbio_data_write()) we queue the completion, so if the
> +	 * writeback was triggered by a fast fsync, the fsync might start
> +	 * logging before ordered extent completion runs in the work queue.
> +	 *
> +	 * The fast fsync will log file extent items based on the extent maps =
it
> +	 * finds, so if by the time it collects extent maps the ordered extent
> +	 * completion didn't happen yet, it will log file extent items that
> +	 * point to unwritten extents, resulting in a corruption if a crash
> +	 * happens and the log tree is replayed. Note that a fast fsync does n=
ot
> +	 * wait for completion of ordered extents in order to reduce latency.
> +	 *
> +	 * Set a flag in the inode so that the next fast fsync will wait for
> +	 * ordered extents to complete before starting to log.
> +	 */
> +	if (!uptodate && !test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags))
> +		set_bit(BTRFS_INODE_COW_WRITE_ERROR, &inode->runtime_flags);
> +
>   	if (ret)
>   		btrfs_queue_ordered_fn(ordered);
>   	return ret;

