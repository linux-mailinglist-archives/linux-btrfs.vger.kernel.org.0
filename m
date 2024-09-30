Return-Path: <linux-btrfs+bounces-8347-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A3C98AFBD
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 00:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1761C219A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 22:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F77418873D;
	Mon, 30 Sep 2024 22:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gcIZskkq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7EB17BB38
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 22:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734668; cv=none; b=Uh33VYPMkPBawu4gD2zeTA6Rv9wqvDNH4OqixrDrsQTPg5PLqKiwVVDBqx4HQQBeOO5DHN7TD6AzKw2SnYz97I8T7dsr6fjUq79/nqbppQNJ0xdgBaVCCEJf8WS/PN6BUoNNUNbhap5miar6CnbfJRzEV/8rGEhBbd5ddtA6nFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734668; c=relaxed/simple;
	bh=hy7DGl8wj26l7Jh6eDksuQDT/vQKbLLy4IgQW6llNvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SHUtZxmo7WjMMUuh9vqFi45DsAGumGa7EOC+pT0l9U3pIXav/jzJAj11/iI6OokNRqUhJnzSxL3OzD3f9ip7vs1O4oq41vS9YLJ5yng0aVyml/JOrJ+xTlFxJ6doVReJRAnjCJ7SOqWSdxeJ+Md1xnrDK+nJQr21HeQ+TV86e0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gcIZskkq; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727734658; x=1728339458; i=quwenruo.btrfs@gmx.com;
	bh=Bnl8AK1DoWsVcqTdGriiGk/c4cww8Pj5WOMKGmGWN0k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gcIZskkqiLQgM2qQqoQsuBfTNWaEuoPe3XfA/zcSosfugKVMK0go9oXL5/pW3TTA
	 rQOL43M8/+kvAiIp6o21/4cmSSJgA4bUiSMrZUuyjPPysinVBMC8hJ/yvrpSMDW0e
	 x0CJ3atdAvTwpQbxayq3MRbgKNR/fvVLlFY6KOYd6RYudp9r9+Oj2QJv+jbmkQaPN
	 9Yne+EXsJMeAiUovce0ZYqF+xmtdLRSqa9kjKzGeezFdOGyJIBk9oIzsHRr8tXUGK
	 TLea1s6z+iHkS6yHhRvznbIJ9yXOWX7Wp1gGiFT3h2G1i/zkTMDA4mW2ycnYuH+5v
	 1ine7bCzx/1zTcjCog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwwZX-1rxPAo3uXL-00uG5X; Tue, 01
 Oct 2024 00:17:38 +0200
Message-ID: <76f9eecf-dacd-4e83-b278-2028c5cf6082@gmx.com>
Date: Tue, 1 Oct 2024 07:47:35 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: send: fix invalid clone operation for file that
 got its size decreased
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <5a406a607fcccec01684056ab011ff0742f06439.1727432566.git.fdmanana@suse.com>
 <794af660cbd6c6fc417a683bfc914bbf9fb34ab0.1727434488.git.fdmanana@suse.com>
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
In-Reply-To: <794af660cbd6c6fc417a683bfc914bbf9fb34ab0.1727434488.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8EtH17MkLcTIgGExAtxqVERCkFGviLzuPcdRVLwUgVUwn+bvhoM
 Rq292xFrAPI29FTRTAfiiwQ6HHyhuhOFPolC8q1/mOdRhVcrovt1MV9rBksd3B/JQdR51v4
 E1uXEYUMAhFMNP3nAdswbkenjtWWMFUlj9F3HuqrR7X2BmgmQbCQ4B0/AkHzNashgmXq4hk
 q4D4is2n3EnrJWSPhLEpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Vbx6f7ZY4ps=;sHIYlNKznreOuzDPzwiERnOw8bT
 p3zTjcRwBf2ZzFrvv2Aj9nY0avehulSBZYODZqAThcjT36tqIw/2Vc9WDV/Pgltqzam9YhO2o
 tpL2AS1Dpa4w7QhZRDnwI75Y9eZPmq9s52ea3YYiLoDRz2pfl9J9wmd+VrXSodsN9+LqhKv1u
 znbGHDmojRkLDiLXrhEPBjf5YFsJSOSxa7EyL2wFoCVLER36mrvYGA8q070IIn7gXpkz6r9Oo
 w60y8VCZudKJBevUWCEyWYlusiS/PEg1xaSRClf/E6UbmGvptZqKB8QqXvtLned3w4JKk55yd
 b9qc6XV7HGhY01uO1fa43Y1pKIkvQKAw4lvInzYqWRIqtAZ0DaLzSRQ6uGH71oReMbMobTw71
 ei51Tk0rTuwbh5cr91iX7oLHDVwgMuYVx9Rk54HAg4sCO3Ocm5waSM0RcoZs873H3wn9uQMz+
 gXS62YTriRRuCBinPzXewTUfrNjIWsw+kjlhTV6OKXJ27cQb11vh6NiRCMp9Ajp4+nsL1rtUH
 p2dMCIJonGZ7D7UBd9G1Qejzb2fQU0EKJ6GR4rCmRbz1R5xWVPo2eTm5gwyv/egWdNvaaOD/6
 i1N2MKgjAFQzlGmObRu2Qe7+614akNMRDHSd9/ZneIiGaur7Iyq+NiHzZLHNzZLViXHREk698
 P7djbDr0U5DFkzIto+mcR4ZlCMLoWf3cdbr8EXrR2ulJHrAsci0Do0ToQBbx2VqZsrf/LBhp1
 pg/Vsli9CMthjgHTY2hhsuDKh7Kwcd7XZ7Qh6NyIhSEGWKmzGveVzRnHVWOSrrvL2XcYt3U8O
 Oh3Q0sDDLlmOL0ZjXDYc1vOnjdZ/UK06DQuYQr2h6Jrvk=



=E5=9C=A8 2024/9/27 20:33, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> During an incremental send we may end up sending an invalid clone
> operation, for the last extent of a file which ends at an unaligned offs=
et
> that matches the final i_size of the file in the send snapshot, in case
> the file had its initial size (the size in the parent snapshot) decrease=
d
> in the send snapshot. In this case the destination will fail to apply th=
e
> clone operation because its end offset is not sector size aligned and it
> ends before the current size of the file.
>
> Sending the truncate operation always happens when we finish processing =
an
> inode, after we process all its extents (and xattrs, names, etc). So fix
> this by ensuring the file has a valid size before we send a clone
> operation for an unaligned extent that ends at the final i_size of the
> file. The size we truncate to matches the start offset of the clone rang=
e
> but it could be any value between that start offset and the final size o=
f
> the file since the clone operation will expand the i_size if the current
> size is smaller than the end offset. The start offset of the range was
> chosen because it's always sector size aligned and avoids a truncation
> into the middle of a page, which results in dirtying the page due to
> filling part of it with zeroes and then making the clone operation at th=
e
> receiver trigger IO.
>
> The following test reproduces the issue:
>
>    $ cat test.sh
>    #!/bin/bash
>
>    DEV=3D/dev/sdi
>    MNT=3D/mnt/sdi
>
>    mkfs.btrfs -f $DEV
>    mount $DEV $MNT
>
>    # Create a file with a size of 256K + 5 bytes, having two extents, on=
e
>    # with a size of 128K and another one with a size of 128K + 5 bytes.
>    last_ext_size=3D$((128 * 1024 + 5))
>    xfs_io -f -d -c "pwrite -S 0xab -b 128K 0 128K" \
>           -c "pwrite -S 0xcd -b $last_ext_size 128K $last_ext_size" \
>           $MNT/foo
>
>    # Another file which we will later clone foo into, but initially with
>    # a larger size than foo.
>    xfs_io -f -c "pwrite -S 0xef 0 1M" $MNT/bar
>
>    btrfs subvolume snapshot -r $MNT/ $MNT/snap1
>
>    # Now resize bar and clone foo into it.
>    xfs_io -c "truncate 0" \
>           -c "reflink $MNT/foo" $MNT/bar
>
>    btrfs subvolume snapshot -r $MNT/ $MNT/snap2
>
>    rm -f /tmp/send-full /tmp/send-inc
>    btrfs send -f /tmp/send-full $MNT/snap1
>    btrfs send -p $MNT/snap1 -f /tmp/send-inc $MNT/snap2
>
>    umount $MNT
>    mkfs.btrfs -f $DEV
>    mount $DEV $MNT
>
>    btrfs receive -f /tmp/send-full $MNT
>    btrfs receive -f /tmp/send-inc $MNT
>
>    umount $MNT
>
> Running it before this patch:
>
>    $ ./test.sh
>    (...)
>    At subvol snap1
>    At snapshot snap2
>    ERROR: failed to clone extents to bar: Invalid argument
>
> A test case for fstests will be sent soon.
>
> Reported-by: Ben Millwood <thebenmachine@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CAJhrHS2z+WViO2h=3DojYvBPDLsAT=
wLbg+7JaNCyYomv0fUxEpQQ@mail.gmail.com/
> Fixes: 46a6e10a1ab1 ("btrfs: send: allow cloning non-aligned extent if i=
t ends at i_size")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/send.c | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 5871ca845b0e..27306d98ec43 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -6189,8 +6189,29 @@ static int send_write_or_clone(struct send_ctx *s=
ctx,
>   	if (ret < 0)
>   		return ret;
>
> -	if (clone_root->offset + num_bytes =3D=3D info.size)
> +	if (clone_root->offset + num_bytes =3D=3D info.size) {
> +		/*
> +		 * The final size of our file matches the end offset, but it may
> +		 * be that its current size is larger, so we have to truncate it
> +		 * to any value between the start offset of the range and the
> +		 * final i_size, otherwise the clone operation is invalid
> +		 * because it's unaligned and it ends before the current EOF.
> +		 * We do this truncate to the final i_size when we finish
> +		 * processing the inode, but it's too late by then. And here we
> +		 * truncate to the start offset of the range because it's always
> +		 * sector size aligned while if it were the final i_size it
> +		 * would result in dirtying part of a page, filling part of a
> +		 * page with zeroes and then having the clone operation at the
> +		 * receiver trigger IO and wait for it due to the dirty page.
> +		 */
> +		if (sctx->parent_root !=3D NULL) {
> +			ret =3D send_truncate(sctx, sctx->cur_ino,
> +					    sctx->cur_inode_gen, offset);
> +			if (ret < 0)
> +				return ret;
> +		}
>   		goto clone_data;
> +	}
>
>   write_data:
>   	ret =3D send_extent_data(sctx, path, offset, num_bytes);


