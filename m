Return-Path: <linux-btrfs+bounces-17741-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8F7BD64C3
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 22:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4D24207FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 20:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197782F0696;
	Mon, 13 Oct 2025 20:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ViWIhUlL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4666E2EE5F5
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 20:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388956; cv=none; b=GR4xUMorrOsilLmJ1f8Z3gbUV5IO8tSOx0u1mjGWPXD3ryNRPfmWk28GE/fVmTo8EavBSrx87waAItavQ9rxhRO0XiN9PP+GNunM8Rz26JoKjB59IzXXA6kDIpS87p+/BJ7kKFfIIus5H5KGxabDBbyaRJsCVTZb5uj8+/KGD5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388956; c=relaxed/simple;
	bh=B4AnAwXujnBJICuycnAPSOPtXauAcjFAsHSXCSYzfrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BC0WXngaFDJ/WmXEn2jHjDk5OPv4JkSc2IOrXiQ/8hJ9eIMF13NPPTyMOLSol9iIO72UB/qIVkNgjqV+AGotaEZTNyBtZpO+ILumV9QJMAs5UCwPgyzlqTH+ZMGG51E2egneNRiUbUngD9t5bLlF4Vf5ZFy85e0SE6tF3VPHu5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ViWIhUlL; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760388952; x=1760993752; i=quwenruo.btrfs@gmx.com;
	bh=xK9/3p1XXS+k/em07tIQUx82VpFSHhIn/9FqR18SiSc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ViWIhUlLhBSR8MzJPYfUWFi4RFsbOYOk80fShar0aS5EDr/Etyj4clQW9eByA8iY
	 TDPJWdIrxKqrpl/ozMlxyiAhqX9Jg1lw64YUH4BS00vDxN7VHy/3EI299e+4m46Kl
	 waRfuZDESpCXeXWD9PFgUcUVxZeJsF9DOUn8EZSwMyi+wcR4hxFmSs8FwWPC3lGay
	 xlrf2o/Ga3N+TS7XaiSPyROGDeIHItrWCkwJlhm7DlcgiSvoiVDxq13dcPuhg2TBc
	 /iidOsLeLjWvGHzUQtUEiWLOM1BkmxLRS1j8Cg34YrCviczMcczJu1Hq2HJDZWZlv
	 gGDxQyDAsLd6vj/Lyg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6sn1-1uAF9k3ed5-00quNy; Mon, 13
 Oct 2025 22:55:52 +0200
Message-ID: <57850928-f636-4e32-82e8-e169b93039cb@gmx.com>
Date: Tue, 14 Oct 2025 07:25:49 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] btrfs: avoid repeated computations in
 btrfs_mark_ordered_io_finished()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1760356778.git.fdmanana@suse.com>
 <00cd878ee1a57343f7a2054041293c93761ee326.1760356778.git.fdmanana@suse.com>
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
In-Reply-To: <00cd878ee1a57343f7a2054041293c93761ee326.1760356778.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vB2WQLmflWp8PcF0Ay7Myw64FYCrbo1Dtjgt2kbm47UiwWKPP7t
 rmAaIaofwvmxIopNQ3CsspaTV4aAdsWCgj8RjlBd24NS9FdSqvK7dobtqB+8OGZoCBe5AA6
 pD0H6tOqkO/Rp5eLIxdiuGLR3zXbsgE23Yk5WpiFf+tzs3BRpjInCnf+uuCd2PchYSqZ4O5
 tcO9gVNYYMy1z8CbZW13Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2yqdt+q31nI=;1/V5jB17tJJ8bZnOgW53+PdhM7Q
 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
 8JyUm/Oi/gwsF0KRq1V+UtqgCU=



=E5=9C=A8 2025/10/13 22:35, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> We're computing a few values several times:
>=20
> 1) The current ordered extent's end offset inside the while loop, we hav=
e
>     computed it and stored it in the 'entry_end' variable but then we
>     compute it again later as the first argument to the min() macro;
>=20
> 2) The end file offset, open coded 3 times;
>=20
> 3) The current length (stored in variable 'len') computed 2 times, one
>     inside an assertion and the other when assigning to the 'len' variab=
le.
>=20
> So use existing variables and add new ones to prevent repeating these
> expressions and reduce the source code.
>=20
> We were also subtracting one from the result of min() macro call and
> then adding 1 back in the next line, making both operations pointless.
> So just remove the decrement and increment by 1.
>=20
> This also reduces very slightly the object code.
>=20
> Before:
>=20
>    $ size fs/btrfs/btrfs.ko
>       text	   data	    bss	    dec	    hex	filename
>    1916576	 161679	  15592	2093847	 1ff317	fs/btrfs/btrfs.ko
>=20
> After:
>=20
>    $ size fs/btrfs/btrfs.ko
>       text	   data	    bss	    dec	    hex	filename
>    1916556	 161679	  15592	2093827	 1ff303	fs/btrfs/btrfs.ko
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/ordered-data.c | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 8a8aa6ed405b..dfda952dcf7b 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -483,16 +483,15 @@ void btrfs_mark_ordered_io_finished(struct btrfs_i=
node *inode,
>   	struct btrfs_ordered_extent *entry =3D NULL;
>   	unsigned long flags;
>   	u64 cur =3D file_offset;
> +	const u64 end =3D file_offset + num_bytes;
>  =20
> -	trace_btrfs_writepage_end_io_hook(inode, file_offset,
> -					  file_offset + num_bytes - 1,
> -					  uptodate);
> +	trace_btrfs_writepage_end_io_hook(inode, file_offset, end - 1, uptodat=
e);
>  =20
>   	spin_lock_irqsave(&inode->ordered_tree_lock, flags);
> -	while (cur < file_offset + num_bytes) {
> +	while (cur < end) {
>   		u64 entry_end;
> -		u64 end;
> -		u32 len;
> +		u64 this_end;
> +		u64 len;
>  =20
>   		node =3D ordered_tree_search(inode, cur);
>   		/* No ordered extents at all */
> @@ -535,10 +534,9 @@ void btrfs_mark_ordered_io_finished(struct btrfs_in=
ode *inode,
>   		 *	|
>   		 *	cur
>   		 */
> -		end =3D min(entry->file_offset + entry->num_bytes,
> -			  file_offset + num_bytes) - 1;
> -		ASSERT(end + 1 - cur < U32_MAX);
> -		len =3D end + 1 - cur;
> +		this_end =3D min(entry_end, end);
> +		len =3D this_end - cur;
> +		ASSERT(len < U32_MAX);
>  =20
>   		if (can_finish_ordered_extent(entry, folio, cur, len, uptodate)) {
>   			spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);


