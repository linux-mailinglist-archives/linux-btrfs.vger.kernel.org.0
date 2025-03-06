Return-Path: <linux-btrfs+bounces-12065-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F25A55905
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 22:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670463B2DEF
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 21:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F73827602E;
	Thu,  6 Mar 2025 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kCmu9r5P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1FF249E5
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 21:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297420; cv=none; b=aStompEbqdV+/25HG0q1oM5HOrRJldi+nkaQjFiKN2xqMqJS6/e/fy/AKU16mHtELCnOyJTqRN0UnSkunAzEj9b7PmCc+JMc9BW9RDpSGQPCZRoPC1+CSICuukqOGwaiRTjhj4qBdUbbm4zKq/EllzYEy22fGCX6t9HM5S1i2H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297420; c=relaxed/simple;
	bh=LIQIi4feTXkwvo8Q6veOe3YZG4D+86iohM7JyPW4xtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d5fGK6u8hFHFw40Pc+NwVDxrvGgXOf3TrSgn9tNN0UXtLtybH2w20uLoL6w/DqAY+Ize0ii7OrPGPzQzTt+66KSHdRg43D6i9R4RCu4ppBBG251sxrqDig0RlsUjRxLuKQh5q397y5pmWpgEcSkCntCbmTtJlo1AMqNABvTpUTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kCmu9r5P; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1741297411; x=1741902211; i=quwenruo.btrfs@gmx.com;
	bh=jFxR0lsQQICj3jap4sgJFENq4QujCpsgVExwcJQ/MHY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kCmu9r5Pey6nmZgUIGNRoJ8xxxN1eMb81y0OMjRhtYcobiqeow5WauPsIbluY1/0
	 yCRePlz+JVtvoNC7yaRCd3Mkpuro+tgfq7F+qvLBvu/JsVrfrwZpuw/oe/VErVRGO
	 lZs/D0PWBtzbSM5D9kKAGIqWrEtHrc9w8Q0SbOVJ7FBtg5YN6f6cZce9tJ4eI2BgP
	 j6oJ9ywLPwk6YLlod+XqdWf+SiDfVGXyAuhOejN282WnprsDYv3BR8iOcDldZiI+U
	 9uQeCU4lp73QO3WMZlhH362w9V9A05VyCXSekRbqWoRsA2LUufCWYIyTVY82jDY2x
	 uJZacDbB+H4JjQxqSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N17Ye-1t5o402aUc-014Ezi; Thu, 06
 Mar 2025 22:43:31 +0100
Message-ID: <70f71adc-e7f2-4645-bdcd-8f0235c26ad9@gmx.com>
Date: Fri, 7 Mar 2025 08:13:25 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix non-empty delayed iputs list on unmount due to
 async workers
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <b07f13dbfadfdb5884b21b97bbf1316c45d06a32.1741272910.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <b07f13dbfadfdb5884b21b97bbf1316c45d06a32.1741272910.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zmQwM5IWrUDidQ8l/vfdDsYOH6fi/F2cJAiWDG520CkYISnQ4LX
 /O8V/hRd3b2d13tO3Am6TFj7vhKGw+CGUbF9c533KLWOchz8Kt/FzvUNA4ptNoWTS8Fnh0C
 3tMb2UpspbMli5PFcKgFpT9Vu50CiGTZDAxy15yXr8RvP+ZljXP6L1EZfwcfx1N1QYRww8w
 kLd7K8THJPtQ/H4bTDxeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VYccr2Tzb1s=;p2T4cX40+WQ+FBcObRKo80bRgrg
 8R4SwePDpmihQFbi/M1dnKMoz/Qpzl+SeU16wex4JfipcMUzFJGp2U7PLwh8XsGRZ56aznB6s
 p9IgpV8KWdngyCACuvC5EPxdr2WA+lrgC7kygRi9MjvMv2IaXwWg28sbi2Tz6f/QdFyoCpiG+
 13WjJIf0VYQ5BkptrQyvZxjzG5Bg4wQ6nWCfAXqs0gOT6uQPyBNrPVrXXNmrdfQk62OqjbhKo
 pT1kT0SPhKGiXeiurmCF2HfV4ED/UgNS3k5dKDv1zFX69GNf+OJMv1Z1oKaYgq4ZomfcEaD/F
 Zct2PK7daHpZE9+LK0cnTp2PYOf7csLmKtxgEJo3GPMnIHXiZxuuIIPYxeFOKOQe/DzziluhL
 cA7mkFo0tqvc+oCN695dD4ZZAeJqwwtBVyWUOs2hORd/CtjGiKa/Rw1oSXiSssxrUWystau7i
 uI+bQU8TaSEiEzxU1JPvyvzE+XlJaLvHx07deAZN1wXnmgk2PQZo3ZlKm8M2cZQC6ghhFO01X
 GanF7m3fexTeYCaz/tCBBaAzaLARL4fxLraRqvyOEJ6ey9h7NVaVltw8D94XhzGo+m0LdDPfJ
 WvOADRjhi81zgcHR8bVf/FExBaNI0k4Gfq/35CbVQmVXqGTP4ILQVfft5Nb3znBe9KuUH6Dw5
 ZQtkrRL+qd1tlXfe6Y4+2nNT9599KlV8N7XZSuFfAFnM78CZB2zHIA0ue0R/HyB6dcudImk3Q
 2qoh+BZ/puK8yt+0I5EZEfa3TfxByWacBWX64bz5JSvQG/w314pVLGfN0IfIMHkoG4eOFujrq
 uD1YuXusG9utQ3+2WuAVrJhGS9MGXjb1R+w/cmM5j7i4bnp782jDFpwoOUYqMTSZ6q7DA4gQP
 r4Azb+Jry8a+uReSvxJcrpn3OZnn7e2hjP82EEL65NW+Ki67oaCoi/Qwrq+jMYtarcmE40S57
 jCAVOEoRlb2bgqriG0ZzynW5FIts2NasfBxJHSFP2tyGsTvdQnq/Nomdi8ZrLG9nAl2tJfVJT
 Ij1rJml7wxv9YjwIrTCqE2dh6pAFfyq3iSmcNKddMeoDfczTF2fHJ5TDsQ3xO++oeROzaEtCa
 stCVDl68sEBddHwmWV5Cfe5ptl6WL9+hPa+nJ7AnCGkaZLRWofgVPXJMDzgygHEGp+DPkOykZ
 i6oYq7FSAVf35UHE4OTUs8AtBNENfkFIufl17/+t2+3pL9LYWFD9119mU51qReCGx66LlEsQl
 RmEryczI+Y0BnaJ67a51fqU2j9Txe1KpwTG4D0UoHnpG2erUtCjr5EjQs10dkdvf1wdFQE0th
 muHnZrXXqe+YesDN24HdLaJJ2awScREZdesr5zmpZgTbFRrX6RVpCucwiLr7F2YzScNZy5XDf
 G/p4MjUOMcmS+8vQBgeTYlhd2SLY4ZoFHaFK0HzRqB4r/ThRT09vJRZgTt



=E5=9C=A8 2025/3/7 02:27, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> At close_ctree() after we have ran delayed iputs either explicitly throu=
gh
> calling btrfs_run_delayed_iputs() or later during the call to
> btrfs_commit_super() or btrfs_error_commit_super(), we assert that the
> delayed iputs list is empty.
>
> We have (another) race where this assertion might fail because we have
> queued an async write into the fs_info->workers workqueue. Here's how it
> happens:
>
> 1) We are submitting a data bio for an inode that is not the data
>     relocation inode, so we call btrfs_wq_submit_bio();
>
> 2) btrfs_wq_submit_bio() submits a work for the fs_info->workers queue
>     that will run run_one_async_done();
>
> 3) We enter close_ctree(), flush several work queues except
>     fs_info->workers, explicitly run delayed iputs with a call to
>     btrfs_run_delayed_iputs() and then again shortly after by calling
>     btrfs_commit_super() or btrfs_error_commit_super(), which also run
>     delayed iputs;
>
> 4) run_one_async_done() is executed in the work queue, and because there
>     was an IO error (bio->bi_status is not 0) it calls btrfs_bio_end_io(=
),
>     which drops the final reference on the associated ordered extent by
>     calling btrfs_put_ordered_extent() - and that adds a delayed iput fo=
r
>     the inode;
>
> 5) At close_ctree() we find that after stopping the cleaner and
>     transaction kthreads the delayed iputs list is not empty, failing th=
e
>     following assertion:
>
>        ASSERT(list_empty(&fs_info->delayed_iputs));
>
> Fix this by flushing the fs_info->workers workqueue before running delay=
ed
> iputs at close_ctree().
>
> David reported this when running generic/648, which exercises IO error
> paths by using the DM error table.
>
> Reported-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/disk-io.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b0f125d8efa0..984145147716 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4340,6 +4340,19 @@ void __cold close_ctree(struct btrfs_fs_info *fs_=
info)
>   	 */
>   	btrfs_flush_workqueue(fs_info->delalloc_workers);
>
> +	/*
> +	 * We can have ordered extents getting their last reference dropped fr=
om
> +	 * the fs_info->workers queue because for async writes for data bios w=
e
> +	 * queue a work for that queue, at btrfs_wq_submit_bio(), that runs
> +	 * run_one_async_done() which calls btrfs_bio_end_io() in case the bio
> +	 * has an error, and that later function can do the final
> +	 * btrfs_put_ordered_extent() on the ordered extent attached to the bi=
o,
> +	 * which adds a delayed iput for the inode. So we must flush the queue
> +	 * so that we don't have delayed iputs after committing the current
> +	 * transaction below and stopping the cleaner and transaction kthreads=
.
> +	 */
> +	btrfs_flush_workqueue(fs_info->workers);
> +
>   	/*
>   	 * When finishing a compressed write bio we schedule a work queue ite=
m
>   	 * to finish an ordered extent - btrfs_finish_compressed_write_work()


