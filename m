Return-Path: <linux-btrfs+bounces-9104-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AE99AD5D4
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 22:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB90E283EDE
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 20:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5B21E2612;
	Wed, 23 Oct 2024 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="eVuZWGM1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2288213AA2B
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 20:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729716809; cv=none; b=Juh83X5DlqM7N4qLNxVEPXZs0/qjy02mcn39CvlpGirCKBYw2pTodb6pVd/i92q7+XXhfvmXkvTUWhNn7tyzSeqp52cNam06OOGPg6xqncrkcO4raJBTumyZ0l4VpEniVEK0f94DIdVh0jnaSKfN2/kpMO90doTNZAuonzeQ2Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729716809; c=relaxed/simple;
	bh=nfTMr5aK56YUWe69BNDyv1L13mTMgc8mL6ZlNV3oKIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dP5574OytybcXhz5wWB414rFO4RCm1rekWB7nSuIl1cFYvwVOfEVLYxgVE/hYKdk8ldmL+9PI051UL2Bsq0Y/lB9qZ+RWvkEbQmLbUdqlpbXLAiNEIw61STToT6mK0iBIXBlFjW+r5z37RjrtW1qHcxUb2l9qTKK2mnR4mKAjGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=eVuZWGM1; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1729716804; x=1730321604; i=quwenruo.btrfs@gmx.com;
	bh=+DZQvhaDmGYoFCfmRzjDXxSHamn6MVXSy0UH3z4+8rc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eVuZWGM1jAOhiVT/rskapeG962Rt/T85R7nV06jD1WkaSvHRaYcHcctialR4be+r
	 NDNa3JXQVrPwwCxa6u80nzKQf68Z8Tu2rV0o2TIMWlssxhK2rj/WExQB2wMN9/rY+
	 xd+67APe4QmMnRjQ8Rm1MLEaF9uQy+yhg1mkMdo/scuLnCGzs1GAlQmA8xybbJ7AS
	 Rn47ILnb8DURc4452C4oh0Bo53NyVZFJOsa1rTSSUBdN4pBYlIAJCtmc7MvkZIxPF
	 D6L8T3TtXOu2eeehrkMPrGOEIXQ9ST6LSW3soTfqtjLKMvMuSPjywJwW8/C701SMp
	 z/m08bC2RRUxHriSQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mlf0K-1tmMa12hrm-00oYs0; Wed, 23
 Oct 2024 22:53:24 +0200
Message-ID: <08e45ca0-5ed9-4684-940f-1e956a936628@gmx.com>
Date: Thu, 24 Oct 2024 07:23:20 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: fix mount failure due to remount races
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Enno Gotthold <egotthold@suse.com>,
 Fabian Vogt <fvogt@suse.com>
References: <a682e48c161eece38f8d803103068fed5959537d.1729665365.git.wqu@suse.com>
 <20241023163237.GD31418@twin.jikos.cz>
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
In-Reply-To: <20241023163237.GD31418@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8sqmwNIoGe7RCcC58/r+iD5mDc0sSBISIcKKzYES/QCVlQCn2ag
 6xEnWOwj8cQbuvlX19uKY9Wdx1IQi8BPQccupbsOxjdEjLJaeE/PodWwb2Payq3mDNs5B1+
 P1c8qTJMrTb4S5+aU6vq7/8cmFYQeZu1C2fPcPWlmCs32SNiTRoeMAn6603fgpav+gby4RW
 xZhax/ZaF6xjiBW1mZhkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2OzW8KBUYjw=;WUAyl0jfEuxMMuDi6rlxnPaYVtr
 LmC+uezP8jLFimDb5TBWg5OZbeTQ4SAqEhZFWNiyeo4H0nrZtt+vBaXLGXNjMRJeT4qNBRIy0
 Rklo1Z99Kkk7ndXgBx8uS+oToAEDrajmlE+SH8D1Qx4s4kW+j0Vx1joapkK4dPjmLNHSN7Yc6
 pB8ENinJnOCLe3Y6hwvMl1E3tDXxCDiphqDwAbW5M6kxPhDe26YkHf4nIj6W8X+XDC2Br0/BY
 K0/gYWEgsCv5X9LzVNPxGTvKImgkuUCbFpiYJLLv3QPztp71LHisOMyWeq/W4xvVUZslQpWrY
 az7/MIVlO2Q9YT4rctdw2DummuchQS8t+pnfPYsVvgG73I5Fos1yBzQp6zSYaJQfQ4phtBgo3
 C/lFRKmpKbZUUbgREe9sPXtcw5GX4lxiYlqopRmpzCOJtKyVzARUJBiFW1DEjzLQXh77tIDIo
 NSX5ENcIB8VCTJK7Ni5TGVLQqKcm0ExsukUVQKNtE0NnQEiww3jX6Clx3yRD+KS/anehTfmUR
 nkMErhE7UrYyA0yIZAhOwtN+AX+gKuRLMmqd47Eq6bTxDecMnQcsR8X3aSzLVJ4rH35nAWsp1
 dxCp40UIElHd4Hi2TcXeHzDYkN6xjaYEkYgY14X1QQYVlM2U2PzuPegGN4MD/vcyTG5m8DR71
 d/QH6yFaRik/y8oW/MjHtxMTcND1o7UfwXfIgP9ZIdHiLpTfjEbOhbMijuKd25l+B8L9q9Tzh
 9DREz8+2TPPramXdc276dM5PeAfDNcRJomecDkR5/s2Wl5ywCzaDh2bk5WsWTtnscX/yTMQqZ
 0VhSGp0EAYq1wcBPopOjNehA==



=E5=9C=A8 2024/10/24 03:02, David Sterba =E5=86=99=E9=81=93:
> On Wed, Oct 23, 2024 at 05:08:51PM +1030, Qu Wenruo wrote:
>> +	if (!(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONLY)=
)
>> +		ret =3D btrfs_reconfigure(fc);
>
> This gives me a warning (gcc 13.3.0):
>
> fs/btrfs/super.c: In function =E2=80=98btrfs_reconfigure_for_mount=E2=80=
=99:
> fs/btrfs/super.c:2011:56: warning: suggest parentheses around =E2=80=98&=
&=E2=80=99 within =E2=80=98||=E2=80=99 [-Wparentheses]
>   2011 |         if (!fc->oldapi || !(fc->sb_flags & SB_RDONLY) && (mnt-=
>mnt_sb->s_flags & SB_RDONLY))
>        |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>
>
Weird, my local patch/branch shows no fc->oldapi usage, thus no warning.

The involved lines are:

-	ret =3D btrfs_reconfigure(fc);
+	if (!(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONLY))
+		ret =3D btrfs_reconfigure(fc);

Thus no warning.

Thanks,
Qu

