Return-Path: <linux-btrfs+bounces-5091-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894738C8FB4
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2024 07:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0DADB2118D
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2024 05:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BA99479;
	Sat, 18 May 2024 05:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="pTvrEYhR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C778C07
	for <linux-btrfs@vger.kernel.org>; Sat, 18 May 2024 05:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716010095; cv=none; b=QT3hJh0r5jnvMhpc2i/+9fRhxsW7CHM/c6DoPrefTa4abb4OxeoZgkazcc9FKSOLpLAAJDS2pmcH7/8e8sL7jqBzokL3oCYVxb1U1Y4l/8h6xwVrxVMfJPShv1JUSkRdpMfnb1Xt0niUSj3p3vD4U6WWmeZoFTjNaaqFDyrDdjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716010095; c=relaxed/simple;
	bh=TKPDhvp4bQPfEnvX+7A6XhIJm5rbbCCky9829YQEsdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=db9IqGSQNJIiwOP/i3epi0ciLI0ZJhqXyJE1JZoIJW16IHuWL6h8cx4G1KJF7TTKv2xFBaJearColsi87/V2J0GYyrSWNpV8mnDn8s5TPClyPdMTx77mZj+bzB4SSm3184j1BzRziDDDsB92a86Zgc7VeIwAtgHKzf+uy+lbWCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=pTvrEYhR; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1716010085; x=1716614885; i=quwenruo.btrfs@gmx.com;
	bh=ilZ4Gl/G88wuBamU627HfNLmnq4mccsudWZ/X9nUr1c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pTvrEYhRvUjQZYbDbjOHY5CTymyOonm5gj2U5cvafbAwtO2Q7fJs7Ny4PmyMhrK7
	 qcNXkeE8ue02XhsSAhkmrAk6jL3NoyHKKGsY85eCixiFSsVvS5t3tu9JUB6Th75sQ
	 lmK1uAdenzku6Bxayrnon9mROvAGop22wPOKhqWioG9z4sNognn0k1wtkU0zvSjg2
	 lkUNfYb4occ0d8G76tTHLflsr6h8UX6Bn5Gn9pSZ5/S1JiztBGZcVXYYIP6Sfn7om
	 jxSC+0pDn97Iwmn8p1Vv3bLepbe65AbCMhWegv2LkLZu3U8+/KHMe/T1rjiVIQ5Qv
	 6DzCqlJm1M99PoCSfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmULx-1sqZyH0rz7-00lSdT; Sat, 18
 May 2024 07:28:05 +0200
Message-ID: <487495ec-8c14-4654-89b6-7b74c4e41be8@gmx.com>
Date: Sat, 18 May 2024 14:58:00 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] btrfs: ensure fast fsync waits for ordered extents
 after a write failure
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1715964570.git.fdmanana@suse.com>
 <bc50545a6356d32644de712bbd0e6128276596a2.1715964570.git.fdmanana@suse.com>
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
In-Reply-To: <bc50545a6356d32644de712bbd0e6128276596a2.1715964570.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6YJiUTixReFczEnPXCycS+I1uWg1dUFotSQhKYY8rRWWJlgcPhJ
 o3/xfEPNCclzHm7je/Lfo+QARs39yzZ67hH3wElrFNIEmH0iq0QFClDOfldFEDnLdE5vWjt
 eoRo7pikiikLbG16XHFmDXu9BJ7pVQt/dJyiRsLWa3R8t2DUDdkWfsB5xtcdHiCcz0tqJPY
 W3wpv7G7oFSrW4lTW3U0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iR37UfRjXD8=;YXbH7ElETGnS4toEIegzHOfVZbT
 j4lJBosgGbFzXd+pQfE/55IclTJqxHjILv/mBDnTWE6Av0RbGE8g+QvT9PyPA8Bj7GEVkY3M5
 0z/OWXdx2KpAhx3B/k/MKm2bnTo15HtAkg92+rcClbqS7aNAPbmcAgn5ayk05HRvoAqDYhIa0
 EgfPdGhc3K1krl1tlrpNZBrnXzJ4EiRH/VkUDlih/tANWqVdWtDwVdw67Is2JK6ne2ZpIRXcE
 OX+XwjJA7wcTE5iSbVXUK1biza3l5XIEAbFxjcLFSjHWwtNnwHPKBSg2wlWZxs57E2yZi6lvI
 AabeZQYJVbP7GkxaB9OxNU8t+Rno4QbECxsCWLoXxZTaI5uTYtonEHkeDalUgGB3e11jrebNN
 HwJ01OfVAq0wec2suY4zwm/KyEIFR+jNbv+6FlunalUVdogbjOQZV5iNKPUZWgvnvpWgLGdmi
 1YeoPLk2CVcGHkMbdIcN9T9S/L57nMOas7jhfh4S2jA3cWJcoWVvZlgqUbIzMQeRp8LGBEBrf
 lYHm0mZ4490KK9MYNvT+NScDKdeYII+FzXkLui6s/gh+FvNN7GU59JuhHyTJ+phmXy0Q5D32m
 yaPvl1gBr8rbSXUbdwhHCwwkQwrrh1cqGqsDjSoCyE5M9pMaD5Bw1LDbtyRTdrXlNe9mvkIos
 5c8BHTmskH3+fwjl4EcEQhk+p3Ge9uYtnbq0xhMQnNv83RHXZMSMwg6r+vo13sBhSTpOniFfy
 7RM8TmlQ6DMKGHHAToXMh/4CSZ6lth9Qsy4GDFkLucyYqHdIJLpGIUtiPFrVoFbHzObxR9RJg
 sejHvGfuOsnYdCpteQheUTSY0Lg2dlaFSl9VMnAzdXXo4=



=E5=9C=A8 2024/5/18 02:22, fdmanana@kernel.org =E5=86=99=E9=81=93:
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

Thanks for the updated commit messages, it's much clear for the race windo=
w.

And since we no longer try to run finish_ordered_io() inside the endio
function, we should no longer hit the memory allocation warning inside
irq context.

But the inode->lock usage seems unsafe to me, comment inlined below:
[...]
> @@ -478,10 +485,10 @@ static inline void btrfs_set_inode_full_sync(struc=
t btrfs_inode *inode)
>   	 * while ->last_trans was not yet updated in the current transaction,
>   	 * and therefore has a lower value.
>   	 */
> -	spin_lock(&inode->lock);
> +	spin_lock_irqsave(&inode->lock, flags);
>   	if (inode->last_reflink_trans < inode->last_trans)
>   		inode->last_reflink_trans =3D inode->last_trans;
> -	spin_unlock(&inode->lock);
> +	spin_unlock_irqrestore(&inode->lock, flags);

IIRC this is not how we change the lock usage to be irq safe.
We need all lock users to use irq variants.

Or we can hit situation like:

	Thread A

	spin_lock(&inode->lock);
=2D-- IRQ happens for the endio ---
	spin_lock_irqsave();

Then we dead lock.

Thus all inode->lock users needs to use the irq variant, which would be
a huge change.

I guess if we unconditionally wait for ordered extents inside
btrfs_sync_file() would be too slow?

Thanks,
Qu

>   }
>
>   static inline bool btrfs_inode_in_log(struct btrfs_inode *inode, u64 g=
eneration)
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 0c7c1b42028e..d635bc0c01df 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1894,6 +1894,21 @@ int btrfs_sync_file(struct file *file, loff_t sta=
rt, loff_t end, int datasync)
>   		btrfs_get_ordered_extents_for_logging(BTRFS_I(inode),
>   						      &ctx.ordered_extents);
>   		ret =3D filemap_fdatawait_range(inode->i_mapping, start, end);
> +		if (ret)
> +			goto out_release_extents;
> +
> +		/*
> +		 * Check again the full sync flag, because it may have been set
> +		 * during the end IO callback (end_bbio_data_write() ->
> +		 * btrfs_finish_ordered_extent()) in case an error happened and
> +		 * we need to wait for ordered extents to complete so that any
> +		 * extent maps that point to unwritten locations are dropped and
> +		 * we don't log them.
> +		 */
> +		full_sync =3D test_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
> +				     &BTRFS_I(inode)->runtime_flags);
> +		if (full_sync)
> +			ret =3D btrfs_wait_ordered_range(inode, start, len);
>   	}
>
>   	if (ret)
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 44157e43fd2a..55a9aeed7344 100644
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
> +		btrfs_set_inode_full_sync(inode);
> +
>   	if (ret)
>   		btrfs_queue_ordered_fn(ordered);
>   	return ret;

