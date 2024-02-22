Return-Path: <linux-btrfs+bounces-2653-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE8C86051A
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 22:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163D7286198
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 21:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826D312D200;
	Thu, 22 Feb 2024 21:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="K9Co68Gb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248B312D1EC
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 21:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708638547; cv=none; b=iiGabtAidNDhG64dFvoGzz2Cs7JP5NodXldWJtXvF405H6s3vO/2y8wQ8HlTz+HhquW9HSLrBDaVLt63uCM2F3U5YIcvqMH7Rpmq0Rz3NsL8Xulc5AFeLF9FP8svupp6qXGqhRuI8dR9qH5lhKksJ576oxSLiZzTFPQAopVHK54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708638547; c=relaxed/simple;
	bh=4hLIeCkD6/19DNRCRxxJPIw7fPVeg9USkKEgJb9WA2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L0E/qHoh0mO8B/bCbpmi1MV8+mOPhUDzL8YAn9CxMmknm8/trT7+fldrfOUJtrudx7nWh0s5jaqAIzFul/5Ydlom+w2coQg/K5MizVjvzhcnObYa7+IDzFN9tv/235EvfI1vRZTECZMmvL+P5UqS0On/uz/Wftza3Jv+Yc5Nsuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=K9Co68Gb; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1708638542; x=1709243342; i=quwenruo.btrfs@gmx.com;
	bh=4hLIeCkD6/19DNRCRxxJPIw7fPVeg9USkKEgJb9WA2w=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=K9Co68GbLSNXJgT4kZmE49i+Xz0GcJuNXfyaqhQBb6TxNgWVgPOeCmNB+hncnjUc
	 R8KjxxaQq9Zb0AVBcrE9/lu3/LO5/J8uzpdOcE8cEAWYC7Ha7s+mnkpFIlaWGazPc
	 vNh1CibP6QCl5fwdJ9N7cTxbMuh7KTdsSK/XSM3gt035WcPBAe2J34/883WY9u1ti
	 ny8xdvPhS3PcjwzH3XoWC69h3wBhFayx5wWWDA6VTaLbzwbfZV6jP/tgV5YCWpbMG
	 8Lxz/hcfKqw4m38q0dq3DRVauDSp1b6GLAmd6Jfzf0+ozfNhT55t0W/gAdF3o2+Pz
	 4n3MW3qt7fl/RqCpUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MD9T7-1rlpWh01bd-0095Ga; Thu, 22
 Feb 2024 22:49:02 +0100
Message-ID: <7654cae9-d6b4-433a-8d6f-25b9ca30195f@gmx.com>
Date: Fri, 23 Feb 2024 08:18:59 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Simple cleanups
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1708603965.git.dsterba@suse.com>
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
In-Reply-To: <cover.1708603965.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UB0BVrYGbSmkFX1gc0Dxl4haVzAPaYA/gEUBxe8FqP3iOZMVltL
 jSe0Iwqa8UdclzDFgmDuU1YN/uez4xLt9r3M20z/HaB7s/spn7TGbNxrylXpFTF2Nz31IoQ
 9rg0pqlNNix9DpP064G4IsUm0RfQSA6OhXECqbI0/lUoQ3wxnTWRF4aAVGHYs+h8NaWjiRv
 zqQwa11ff2XyX0itZl/rA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4/Elr5PiFu0=;H+r+BWTYUP+m4BIcT/47anN35oF
 lVLgDfEOOSLtT+Td6RU+U7anhZ1AHceN3ESPbwwErZ1CEAFPK7YQqnEo8KVjO89aEbOD6N8fG
 cDq5T7ittmlCOEnx6i+qxTeZJzCmXNKXXJIlpzeMGtbT0DMAVOzBL2QayllvH/+NLLW9rdfED
 Wn75HJiEI5ARmX1x1lTABPH1fpdDGi3HmlrIjABpP3g2DPwtZVFrEV5ZwvfDgCnb4C0vm1C52
 4Ugx6z7aDxRBCQQoVTMIQRj26EyEZQWbv1XyQnwoJSlkxMUBb9NbJud4cVs6oj/JQOZnBd3vD
 BP+z1zq+3q8kUWT1XM7qLpRW6e/4Wzbs54Ds+XZVrO26dUmSMv4E7c0+vrIVMCVMb0BYmxKVz
 RpgqRGyBfmCwAfRiGpv2NO4pnjWtxEoW41foAuWmUecHMexdFzG4e5OGEbSEDnnb6fxc4hFVY
 NFQKtjyVoNes5JRax1ieP15TpaVOC7KffevKIvBNOK8XUxRVRQZtrZ8tEieZV2ndWWdZTRgxZ
 2kIuR6NP/TgFi+daYkuqaJA17qdK9GFTVOUsikQyCx3NfnFvfH3LSFXP6zCHlECx7PShoDf9U
 lV7l4aIejzCHAGtrpT+/BPiy5GFj5Im4Fjs8mHxLqpGm0LgAz1eAEXvshYGIT0Qxk5pBmU9wZ
 vcID7bl9kfvJpGWLH5rOY0B2PCiGpoUel7OBgW5zRZKhwo1+62aHMI77fjWdVXWOKNyFEfDbF
 jke1I3E4+OU0lBNMZHCtIMwq2YgIaIYOqdbkG/mGiI6OE0uTEAcwlo8UX6+My6/2T3WgVysyB
 n14RZZ86sLhsOXop+H8whzZEw2HofkTII+po6kYs3wX4Y=



=E5=9C=A8 2024/2/22 22:44, David Sterba =E5=86=99=E9=81=93:
> David Sterba (4):
>    btrfs: handle transaction commit errors in flush_reservations()
>    btrfs: pass btrfs_device to btrfs_scratch_superblocks()
>    btrfs: merge btrfs_del_delalloc_inode() helpers
>    btrfs: pass a valid extent map cache pointer to __get_extent_map()

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
>   fs/btrfs/btrfs_inode.h |  2 +-
>   fs/btrfs/dev-replace.c |  3 +--
>   fs/btrfs/disk-io.c     |  2 +-
>   fs/btrfs/extent_io.c   | 11 ++++++++---
>   fs/btrfs/inode.c       | 14 +++++---------
>   fs/btrfs/qgroup.c      |  2 +-
>   fs/btrfs/volumes.c     | 13 +++++--------
>   fs/btrfs/volumes.h     |  4 +---
>   8 files changed, 23 insertions(+), 28 deletions(-)
>

