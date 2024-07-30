Return-Path: <linux-btrfs+bounces-6898-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3497942239
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 23:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B371C232CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 21:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDB518E02F;
	Tue, 30 Jul 2024 21:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jjK1VaRB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67689145FEF;
	Tue, 30 Jul 2024 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722375265; cv=none; b=Sk3GJlnB3aPVo97TZd+zoiYBbBL/0nXcIN61uWLl57TmgN6Ks6yU0PGnYKbOueWs6bxBMpLvvzVDA5Hd87rKrQFaJUHnKDnWBzwuc7TuFsm1AhmaPkUeJcZiyP80Hp+rqE3Qtmy8/7anDHqODNvP7lIWmqIq38sJk+xi7xpeiZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722375265; c=relaxed/simple;
	bh=LIOBsl/85bP6+E2DA5IGaWxzQVvGWTObN3Im98feoNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYNdmO1XdJljcK+xKiQeTUXXE+ZVg8TbzAjs+eE+ghVotqn7ZucMuDxs4wJdSShwlHYX2uRWP1xTZU3lWKt0yqQnHEu1VbQKjPH5dBHjXeFuZYzbOXXVDmYyc++FkWoE5P3EbzzyKoG/dc8SsY9LM3NEokPMnuDuT25shopX6tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jjK1VaRB; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722375248; x=1722980048; i=quwenruo.btrfs@gmx.com;
	bh=3h+Bx4fVkN5DxXBKQA+F1qb24RS2zYyz3ea4CUnFaSE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jjK1VaRBJzy+OLNKGhC8ZweIuIQY5AW9M5egv0xXQ2YJ/nNGlc7n2UcmMGZOLyca
	 he/LRx+VGXsB5l6n8LwO//RUhvNYgQyOBujsLxD1616ZHfPk6Gdm6xfck//A1w5v4
	 mqLFI0/2PKpHmjiuqoRjXTcZ1ClTnGeOunzGS8LcbVmGT15W19uaSwJ11pJQ+fiw6
	 yUIhENywgz8XvTkz+7t4iR3fSW/ltJjDucsXzg1BVhZZeljHVTxHAftxHJ9WxT+Sh
	 kziM715D9FqEt9dPGSCoepjf/BH9o/TMZ9pJoKQ6U9BY99+nZ15nNX0ZdfKn7u9xe
	 2raGvYyTYazgh4qemQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MowKc-1ruuJ71R1S-00hED3; Tue, 30
 Jul 2024 23:34:07 +0200
Message-ID: <c7fb2333-8797-4b6b-bc1e-192b2ef82e8b@gmx.com>
Date: Wed, 31 Jul 2024 07:04:02 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] btrfs: fix relocation on RAID stripe-tree
 filesystems
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Johannes Thumshirn <jthumshirn@wdc.com>, Filipe Manana <fdmanana@suse.com>
References: <20240730-debug-v2-0-38e6607ecba6@kernel.org>
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
In-Reply-To: <20240730-debug-v2-0-38e6607ecba6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y9FlMj1vJGNqUnqJw34l5GRGSx2lo/TNWuCNWZ5muAWOjQ2zQXU
 g1QRwBCokuSNRpaJiQTqysbZQ4oqbIupOyn+2aUXIzIy1d0+lANnUkvN+sZd/mchkMIGnco
 AWrg7uBRQpyytDrRyRPiqSBtvRtxfOBtzPlh8fI9nUsIOxI9kQiPAUtb6eHUETLqKEjcMry
 NeVEiHZCsQSpmVwKUJkkg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lET3X0Qb+Lg=;xTu8G8V7HJS5KZ9QL9X2DycDrO+
 gmCLJbAVBEAaeCGDpMP5fbXfQw3X+SL+4j/16T8R94FcP+6vhqb6WhlZ35J/cS3I5jkZ66eDo
 Q0/efyzlDnRKPqo7HJBUltOdJ2UTs/P0xV8YWNJvTCblNPTlM8SBmd5CpGtF+VQqWgR6Gqry3
 XG5RNcC2A8FvRGRrlYLD89Y3KLNd0Tf/G8uvmiTLrCWTIAFV1Y7D2yGhkzTIoZfS2U3CH0aaO
 LHZmmt7bq5QSpAVwGT1HLXSwIb7UCumJekORt0r5KAmEvCJFz2NaakvJj+DVE2akWpxbNZUv/
 uZnlxQcvIJNfhobZxyBy83miGLPGgX14FAzUsKyAUywRenpMq8vziLG01CUteeViFEzRl1qtj
 w+zuyTG8nHTCV9Q8DhUlgj4/JZVN1deH7o4uBPL9ZNW4yCyvZ1afsDz5TdCVZZeUwss44WqT2
 oZy6ZRh8sSvHL9YE77kzb4KjjqaS6r07mx4MkKgMCnfWef/R4xgLwPzjjbMeTKWppbhN0mEO8
 cH8L54OLMBfT5xYL7zXiMg2b2SOXmZcZor7O2aYzIlnPwwag6eRfdvJStpvlNr1sRdxAQNjst
 j8npXClB/MAZXM7Y8JNBagbkWwBc8UbBz7zYmQNp8CDvXFmMpbGSUq4YdAWPtn9zvEAM6fRfe
 Af+hqFCPJOzPMOmXpSQr0SCcY6UKP5q9yJ350rPquCnOv98W+rCnq2j4wfPWMhOuGJVdCIgSX
 X09AfNFdN9Pn833Ms0qe2akUSAiWLSX56GeGhnCYAYa0xz7ZkKygGFd/onqMCr2+FUYr83vBx
 RKexdZXMq0v1OL3BwQZmtj7yZnihNM8Nnd9t+sGqz/8uk=



=E5=9C=A8 2024/7/30 20:03, Johannes Thumshirn =E5=86=99=E9=81=93:
> When doing relocation on RST backed filesystems, there is a possibility =
of
> a scatter-gather list corruption.
>
> See patch 4 for details.
>
> CI Link: https://github.com/btrfs/linux/actions/runs/10143804038
>
> ---
> Changes in v2:
> - Change RST lookup error message to debug
> - Link to v1: https://lore.kernel.org/r/20240729-debug-v1-0-f0b3d78d9438=
@kernel.org
>
> ---
> Johannes Thumshirn (5):
>        btrfs: don't dump stripe-tree on lookup error
>        btrfs: rename btrfs_io_stripe::is_scrub to rst_search_commit_root
>        btrfs: set rst_search_commit_root in case of relocation
>        btrfs: don't readahead the relocation inode on RST
>        btrfs: change RST lookup error message to debug

Reviewed-by: Qu Wenruo <wqu@suse.com>

The solution looks fine to me, but I have one extra question related to
the readahead.

   Does the readahead fail because it's reading some range not covered by
   any extent?

If so, you may want to add an example to patch 4 to explain the problem
better.

Thanks,
Qu

>
>   fs/btrfs/bio.c              |  3 ++-
>   fs/btrfs/raid-stripe-tree.c |  8 +++-----
>   fs/btrfs/relocation.c       | 14 ++++++++++----
>   fs/btrfs/scrub.c            |  2 +-
>   fs/btrfs/volumes.h          |  2 +-
>   5 files changed, 17 insertions(+), 12 deletions(-)
> ---
> base-commit: 543cb1b052748dc53ff06b23273fcb78f11b8254
> change-id: 20240726-debug-f1fe805ea37b
>
> Best regards,

