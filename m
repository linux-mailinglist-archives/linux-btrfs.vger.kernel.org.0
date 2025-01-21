Return-Path: <linux-btrfs+bounces-11032-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35415A1864C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 21:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D530C1884FD9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 20:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0BC1F76D2;
	Tue, 21 Jan 2025 20:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ibjdyvNe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D2C1F78E1
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2025 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737493075; cv=none; b=jBntqfOjgRtzDrhCn5oyXxuKHwRct9vAmWIQob59Nu3vIM/Tdkl0zGgLvSzaKrqicAqb+p6Vl1i1YbEbaIoYxA+Ugy5I2asn3EI2bIABZ62bkAFO2n17xSWLIeEoGpghQ4rFfxbo9vyHS+lo7tE/HzKLVmKEifPJfLO0/fa+WCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737493075; c=relaxed/simple;
	bh=JAcdlYwcEfnA9aoE2Dy9rVeO6Z5JZqgXeUK16m7lj8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JxiQaHoknVRWgkdtS6kidCyry2RuBEaTxY5pTua7pvc8Ay+SN69tr83+hW3+PEJCeE1o3q9/DATUc+CcvRTa2EjCFg7K+egr2+CP5xhrejr+vlz5alIlq+XZH+p3djGda8IerHCnzDP6bYggeJOgGmgW8rFbqeORsMYxOoQszyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ibjdyvNe; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1737493066; x=1738097866; i=quwenruo.btrfs@gmx.com;
	bh=PHWdqIGgWNoaIl82DeiuLKfFBPpBwdHrfAwH1GSs6Ks=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ibjdyvNegeZldn/JWbZUVAJWUhxj8hxIR58CXwt/wMQu/YdYJhuwufgN+naPXCvC
	 A97MFd935tPx11dOyv0U6Gld1oKHyIfh4iRy5NGpJ4BQkyEw/Xi3NC/Odwf46FQGX
	 DrIyuTEVb+IT5j6u/k0ctN2YLBfvGl1Y2hFgSDaqFmsWOb6Ycrdr6Tj5kCzkkR4wC
	 COwvagfOljPJhvsfWg5SDqRFqPR7ebp/808cNUfw9rsKO4RP1IO4Iy1QmQMjDfgba
	 /uGj/Q2tht2z7TckCKN+h+0CNjxpjz0nvxzYkVt1ldJntTtTYb8jfUkXPDP/UJ1vZ
	 Goi8/VVpD0w3IYW2Gw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUosT-1u17Vr1Gbp-00RX3k; Tue, 21
 Jan 2025 21:57:46 +0100
Message-ID: <058486d8-70fb-4885-8f80-57aecea1847e@gmx.com>
Date: Wed, 22 Jan 2025 07:27:43 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: avoid start new transaction when cleaning qgroup
 during subvolume drop
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <a1d2ce906be6a35c652b8792074cdb48b6d3c9ac.1737462738.git.fdmanana@suse.com>
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
In-Reply-To: <a1d2ce906be6a35c652b8792074cdb48b6d3c9ac.1737462738.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fjd0j2CtBKq3HfxLs9qV81GDFfdrJ1qyTePwSbKQORxCeHPMyrk
 bBm6wYWxh5ye3suueX5zBk0iguH4RQi1dskwtcHcO5PMsCBqvPEfyzp+fmuzs+gCd1Ej0cQ
 ln0MZ+SfbWYb9Z9NyKGqSvgKGLuwcHw+ZnMP3hdx8dYgJWjybSb7+FB8e/w51m2AxH3Rfhz
 BCcAFYFZ7gRLD5chda59A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7JFAs4WlQps=;kgcf6FjEhiLyFAcAVm3g8p4OE02
 GD2Dg2RaW26C3cSU0w2h3VDI9rqs6y1B9VO1PnSXZnsmQeU3zyAidjpRFJIKlgXtGY5TfiTI3
 evyR61MRFUxmTcT3GK3U8qz6KPnQN7hJQa91u++/WI2+Vdr43x+TQjpwm+qIsLnNaNZvE83FP
 n7I8HNTHYACQ9WQOrEot2yFI06BeuYWmkzOTuUHqTnxHt/onS3URigw5d4Llbmu24WtdHljtT
 zr7F/tZMpEQ+Zi+weNvpKmKN47GzDYdFtIL4bw625O0mvo/tbKCfnHXMMjZFVh0rDLkG22Utt
 aoJskW29pe9mVBXbvOx/hHrKJJUyCMTgh6oFsG23glLJ2ViQyUISTN2Dw0xti595B+346mOvK
 96j+i1YM8CiGxzym0QAraRpsKGmkvbdL1k9MknXcQ7PdDqc1SkVMl7nKBIW1/1OYMWrh8681C
 fNsOx1NkilxgqBBaZUs6rSzg7whj6umhGcKInfchskrJnvIjH1bcm+Ng26INPntvYQCOzJYMy
 XShy5jUlFUNkVut7AcCRkzWzj8hbnd4i4cM+R5Hmk4TMgs775W/B90uJSW6FAFKKEki3+DFZy
 +/qvrO5/RlZMXGozM5oYZASZJWmG4XeIKJUspHl8Pjy5AoqeeEfQWX5+oyrCVggjHKRx5fNWD
 yoUnVzeGJACF0JKMpSnlrUKpkx7lnk4zkIPB1H497gj+mnLfa+tiWmDQ2kEBXEuVK8y0WL66e
 rh2HtS9QfTHnQrexnViZaDSLD0zvoaOafmJCW9rWkT++1D5qeS6xtv3jAQKld+mqU5XYohvT7
 m7aEda19HxzvrzpdQZK8y2EGrLWVFK81qR9EI/4SVlC0Qo+auHtU20a6nrTrdnvdicsjIiOEn
 wityJzTcF/+D4CWj+hcZoY4E11O5pjBtZJdEjGh/RVoj7dLz2kRIOe9zsGK/TOvMfjVM9+JqE
 rhnGVLGYpPw7F0nvoDaw63UcfICq4/ZD2zQpfVWF+a59oNHia+/s7caQZv4fzqAfGukrG2G/1
 SMG9UEdMavgp2gUUrk+84SSJSn9f4d/omOf49rmJkmpsolj0F1hMC0JKZhxhyw0Sp9FApQNSd
 GByfgExnayi+WOzDqT30SW3WWmX4EqRFPC9WgeuiVW/VnyjoBT5h+pF1+OQxig6xqy72MwAVZ
 Vfb9EuDmG6LnJ2ja6eS6/lqbyhLDpTwbjcM9z+SI1sw==



=E5=9C=A8 2025/1/21 23:03, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> At btrfs_qgroup_cleanup_dropped_subvolume() all we want to commit the
> current transaction in order to have all the qgroup rfer/excl numbers up
> to date. However we are using btrfs_start_transaction(), which joins the
> current transaction if there is one that is not yet committing, but also
> starts a new one if there is none or if the current one is already
> committing (its state is >=3D TRANS_STATE_COMMIT_START). This later case
> results in unnecessary IO, wasting time and a pointless rotation of the
> backup roots in the super block.
>
> So instead of using btrfs_start_transaction() followed by a
> btrfs_commit_transaction(), use btrfs_commit_current_transaction() which
> achieves our purpose and avoids starting and committing new transactions=
.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/qgroup.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index aaf16019d829..f9d3766c809b 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1880,11 +1880,7 @@ int btrfs_qgroup_cleanup_dropped_subvolume(struct=
 btrfs_fs_info *fs_info, u64 su
>   	 * Commit current transaction to make sure all the rfer/excl numbers
>   	 * get updated.
>   	 */
> -	trans =3D btrfs_start_transaction(fs_info->quota_root, 0);
> -	if (IS_ERR(trans))
> -		return PTR_ERR(trans);
> -
> -	ret =3D btrfs_commit_transaction(trans);
> +	ret =3D btrfs_commit_current_transaction(fs_info->quota_root);
>   	if (ret < 0)
>   		return ret;
>


