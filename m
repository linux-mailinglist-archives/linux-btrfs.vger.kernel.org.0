Return-Path: <linux-btrfs+bounces-8076-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5B897A8E7
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 23:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0A5B28A55
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 21:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBF1158550;
	Mon, 16 Sep 2024 21:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="oAjFLw7o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A12C9443
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726523172; cv=none; b=S231ZgW9enh0/mFUSbWc+isoDEil8qtc4Rho+xkVNVGzjCwH5Or62NZmKboGaFqVgJ/+fJZZGfzaB5ceY2+JvcunTBOryiu++shZ/OQ7Vx1pVYjAHpMhV5T8nZ2UJ8F1PIOK8M1frFbE7SZ7voNzkEnAmT2MODfGpadoqNmpbOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726523172; c=relaxed/simple;
	bh=/YXWrNSJ6k6swpunjIgvkUr1d8TCoklf/NMBLFEZlCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kqY5HJDLkd8wkSnwZBrTuoZjSUQQSebd80Qs435jGo0Wjd/6lNdzZT1SNoCLWf6TXMijigCGwngZ8rZ6ZsehH1miBD+PL6iGhg7BWIeSnCMrFL2/p3HjHLeWeLEpZW0qd/Yg9tP+MDFHquwr4m9L5bjyog5K4XxHWi40qeLAZ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=oAjFLw7o; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726523162; x=1727127962; i=quwenruo.btrfs@gmx.com;
	bh=UHlhUlXg/T6YRxzf24R4VFeAVgnL5urLNJBFra2/Ab4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oAjFLw7o7SR2l1qhPqRUGTGRhb+4rnCTydktFrW74mP0FxyZ335E43bZrK7Tv9gx
	 /XbjDeDOKwbah6j1n64fKEtKxgNJSgPGo7mCiArNpr8ci5UQCvtZA/08adbylT8YK
	 Z6lsz9keq40zpq3yzzgkOzTBb5l9DxEEdDlz24ErilgMNLNptU2tS2vEtQgvMFUD6
	 /ffoiiOCs7+gvwpznAF8jpKERGA2pw1bpQRDUI0gIpjxaCdcJ5CFE1jmxbnH4pGJD
	 1kSjPqN0NyuGFfeJoGx+nGvQ3DyYcAS10AKlMLl9FnCoyi0PBbnHvGTWvMMlfUZoD
	 wXF+41AsOkLGFMyqNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJVDW-1sWape0xp2-00VuZl; Mon, 16
 Sep 2024 23:46:02 +0200
Message-ID: <8aea5f61-4e27-4eb3-86a0-9dcccff9d196@gmx.com>
Date: Tue, 17 Sep 2024 07:16:00 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix use-after-free on rbtree that tracks inodes
 for auto defrag
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <743f120462032370c7ae8ff899bfd8dbfb0ed006.1726486545.git.fdmanana@suse.com>
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
In-Reply-To: <743f120462032370c7ae8ff899bfd8dbfb0ed006.1726486545.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lzqrlleLJJEcrGg2ddQ8d+mjSa42hMIP8DW2ZTvoi0fv7fUR7ho
 CH/jmVSg1tZaBlzqUDdWw42S+zu3uE+U4WEQSq+6oDiLIxbUaBHb9AvPTnlBYvSBV4INZjX
 ujAMrrQr3CY8i22OmcRQrxwmhdTx43WOZRNY2SBFcnP7yKtlTVRQfk9cHYeWkEWlFxdjo4e
 X23mVcI5Qhs9eFHo92AgQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M6wqKtYk464=;rwLrsf/nKyvykG02BUL5xmJADOQ
 fMsnQw3I1FudOb3t5mrZ/dL6RuXrIgeM0K5tuRngAzKYNWIlX/+C177CUIrVaXd4bsE4rp2h/
 jCIKrN8j0tKC+pnCPmtp38A1wVjA73yIga9p+Gac13bZ9POQNI0A3yt0DLZlathFDS4HfhQW6
 a87PQKFk5wPiSprqRfGq9MlqIQpTp8rxsvNrH6rLAhpX8TPRTCp3/B2hmENeey2PJQ9bE1iVY
 nqwbNcnKZMudAXjLvw1/EO/7dIuuHcIQeMhc9vsPfTDGzjNQl/nC7XzY+QqWS94q6/9svMDa1
 ooENhyskX31AYrxhZnpCxdp0qQYuRhRs1QHa0Z2oOlyIfMEBJKcWmV9eWiGOmctfKj/piCHe5
 76V253l3NfOTwAyihJUvxPbLe7q7ZFEV1oo3Nxjjp9M5y2b2zqpUXB/1Op+slrDHiyRJeiRNc
 JQ+cdjhPieAc9mxXnxJ0jIh0j30+ro2cWVqZ/ukjd+guCqd5ZpFzfaBMWQ8A67L7bjQnxokZn
 HxRQ0zg/2nl9vIJ2cgjnU3EPXoJjapreJgH4PBHV7VmNw7VzOJ1cELPtFpt8v20eicWYfLMeP
 KpmO7EnQjyQpKcolsSRkLxcSPoMgj2kMTBJME2VXDIyPfRKsn0jeOTau92vCmKjpvTBtzfnEj
 x/UNmgZW//JR9wZlT9jF6H0B45Ocae2x1YPnxlZFlMeTrueHi8aCcOWoJlzjpChxmDR4O+e5i
 QWhK0QQN6u+sxjRhaCxaeEATF2Ug0hhpTdvX0/0meLgTADTKntf1pQmjAIyfQ8XUAHbJb0qxE
 wuylG+VZtkrva1a2D69q9JSw==



=E5=9C=A8 2024/9/16 21:07, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> When cleaning up defrag inodes at btrfs_cleanup_defrag_inodes(), called
> during remount and unmount, we are freeing every node from the rbtree
> that tracks inodes for auto defrag using
> rbtree_postorder_for_each_entry_safe(), which doesn't modify the tree
> itself. So once we unlock the lock that protects the rbtree, we have a
> tree pointing to a root that was freed (and a root pointing to freed
> nodes, and their children pointing to other freed nodes, and so on).
> This makes further access to the tree result in a use-after-free with
> unpredictable results.
>
> Fix this by initializing the rbtree to an empty root after the call to
> rbtree_postorder_for_each_entry_safe() and before unlocking.
>
> Fixes: 276940915f23 ("btrfs: clear defragmented inodes using postorder i=
n btrfs_cleanup_defrag_inodes()")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/defrag.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index acf1f39e45d0..b95ef44c326b 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -213,6 +213,8 @@ void btrfs_cleanup_defrag_inodes(struct btrfs_fs_inf=
o *fs_info)
>   					     &fs_info->defrag_inodes, rb_node)
>   		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
>
> +	fs_info->defrag_inodes =3D RB_ROOT;
> +
>   	spin_unlock(&fs_info->defrag_inodes_lock);
>   }
>

