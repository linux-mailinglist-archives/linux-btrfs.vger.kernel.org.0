Return-Path: <linux-btrfs+bounces-9155-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C0E9AF8E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 06:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76254283747
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 04:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C9D18C92B;
	Fri, 25 Oct 2024 04:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="t/KJmJ12"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD1C107A0;
	Fri, 25 Oct 2024 04:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729830007; cv=none; b=gr7GuFRXHa9Kx/77zDX0zZvW/Sgq74dRhxZgkL3L2ZHOU3lcWCUGWEdPAREJeKdWZjNSrWbFwvqWJknisPc3v2m+ghE9RNHURpfGaKr3revTaBTlB1Z2xyDLLJgyuXGg7qIVJKOyosUVM30fkuduF9KU6XG8M0isAM++w20Lsws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729830007; c=relaxed/simple;
	bh=c5yxC9gJ8KkhHVCenpjsoKbUoejtmfQEzaoOUt1QpSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9136xBpb3xsxuZhTKjrw7o/XAaeRy7+49tGHMk0szXoDoYqqvaIq7BzuUZFtFVHStJtAG6I7o8KM9iyc/mHbtnU/b+Q0QQgHjQPzL7JX00fKUfPBmv0MHMqnqO4wK1FbO8V6LWhDwrsAaVrS1ViPQkmLRD11Nk+1HjYsJGvnO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=t/KJmJ12; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1729829994; x=1730434794; i=quwenruo.btrfs@gmx.com;
	bh=KmMbrajsjNSdrkNV4/WlHQFb+UuzwQPAkDUaveFQEQM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=t/KJmJ12+PhLLpxVqhnsu2wyyoSKGRGj7Wh1+pPpI49HXQW7YTPUpeflQ5nkRrzh
	 BPGCRbTFQ6BMPjmvT1O5mPTkVS/nc+b5Fibk19e0YZbR4IX5lh4gePgXMT97M5gHw
	 LVtbM55iRn7gTjyKzVpUUlSyHwJOD9HPXss3ZLsT0i5POkoT4+GeWAKlLX8EFltML
	 5PK+0VWhYCgJrib3YWrTz4s6LNvpajFH8dKsVwq3z9TwEfryIjanDFLPExaC/aNWc
	 s9yYkyNrxbLaD//Pgxq+1ETibK1Ed8P/nKzC/aHoQ6H2BIAJxO4G9X0H/QqTPlebV
	 b8EOcsrPCatcorjgjQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmULr-1tm5KC2Ngf-00nk40; Fri, 25
 Oct 2024 06:19:54 +0200
Message-ID: <7f0a7b2d-369c-42ae-9054-7436bc98f7c1@gmx.com>
Date: Fri, 25 Oct 2024 14:49:48 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] general protection fault in btrfs_search_slot
To: Lizhi Xu <lizhi.xu@windriver.com>,
 syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <6719c407.050a0220.10f4f4.01dc.GAE@google.com>
 <20241025022348.1255662-1-lizhi.xu@windriver.com>
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
In-Reply-To: <20241025022348.1255662-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rGpeGgQzn4k23Znrv7/bXwiIplg7ZUsDE/Jpsnzl6sW6zQ/wG9J
 mXIH8OVumsyg9oCVwrVEqawJaaZW4GCoIyu9RAkh7qYw9Ov6x2ShCLNi3mcRm9r3HP1AfI8
 YWp5kgm/BDKH1AejYuC9xeUcNtT1ryMnJPvcC27vQscqhM4+BDbh8J1L8ps5tBhv+Srh/1H
 HzvC+w/t8dpuahSDGWtgQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TGlN2lxXdTc=;96WlCGQoCilvlK6fF/9H2DvQeBF
 YmCFhGfbJ+01vEYT6XxXhtKkTKjBgG6BLshFeW/vYIkECxFy9/or8/2izucQAfl9QtkioP5VR
 gkGXIjxkP2E+7H1qzBK6IY6kmkHBIICNbT3Rqno0onLBvvvaKk0zFKPVfAn/e1JP/3pVpLiC+
 vYo32mZjmyrUZtwtan13wu4s83WmMAfgiqKEG7vc2H7RUa3Ao+wOtSfVZEyfVEpTCCFL7kOrL
 l8gR301+LDBeF56XZW8e1KQ+WjiDiQQkJU9EFawLpuo8tBxDTrxBdRHNkvNT8QaHC5bvDObJZ
 89yBU6+K58Ia3M1qIXJefJC5xMNLBI8eIgGfeLGcKV3kIkGhI2JGyZZ/CrbaZZlv1yuAYApE4
 0RXMCUU6Ss4q6Ole58vBUNy6Un9Lwtg2jaXCJwKqkhosAiL9Uq2zZUejlXpl0x1/xWE7JwLPV
 GzT4iWJtWjzcGPA6K2LNul9c6K5C2XmntvPw/WE+Ff4vx4bNFK+AmCrmz6lrLPcA9yJqte/qE
 Jj2yeuEgSQvt1IL7547zcmh3W/MfRL4syZHv9wcgmGBKUAEjmZogAbwOvwqiPFxmnSCoWE3hZ
 v/mdaSkKoz0sUhbePgm+QIWuyocZicd9vpaIlEufhMjvXSTpp/ou24U2SQm5c/h/5oDiTlEja
 VI7QcUbWS6hRjnzOxDpvoENwZ95vr7xQXYBZEkeGux5PIUGRbuqg6pXy6nCcp+z5G7hKySiXa
 9SxNopBQLwdgA4O4DOFn0eLpyGb1gvjU7e3IYqhM/tjMaZEd+bw9G0+goD87oz0+rltrCex0p
 QQFUltS4/OzTjgOiLcqDfSfg==



=E5=9C=A8 2024/10/25 12:53, Lizhi Xu =E5=86=99=E9=81=93:
> use the input logical can't find the extent root, so add sanity check fo=
r
> extent root before search slot.
>
> #syz test
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index f8e1d5b2c512..87eaf5dd2d5d 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -2213,6 +2213,9 @@ int extent_from_logical(struct btrfs_fs_info *fs_i=
nfo, u64 logical,
>   	key.objectid =3D logical;
>   	key.offset =3D (u64)-1;
>
> +	if (!extent_root)
> +		return -ENOENT;

Considering we have a lot of such btrfs_search_slot() without checking
if the csum/extent root is NULL, can we move the check into
btrfs_search_slot()?

Thanks,
Qu
> +
>   	ret =3D btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
>   	if (ret < 0)
>   		return ret;
>


