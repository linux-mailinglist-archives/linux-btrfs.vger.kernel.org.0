Return-Path: <linux-btrfs+bounces-17111-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EABE2B94BD8
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 09:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43001902B0D
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 07:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27662E92BC;
	Tue, 23 Sep 2025 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="BgSIY7jr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4B53101A3
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 07:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758612099; cv=none; b=GXBG4x++aqOpUdN4RrGRnrWELQK0WY+MzVQ+16n4qtkgmtRuHV2QbACDsGGeqI7yjQPuirFGCT69ip6T4GHcuGF59xN1qMz1wH6qXM1NSdKVA9R9VFNcsjgt3kOPfcv6DxNZYJ58G3MotgBnjkjiKpiOwZ3hBGttFY/R+KpM3jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758612099; c=relaxed/simple;
	bh=Q1YEZUNBg6tHGmIliEe5Ae9aN+a2/Em9vJWFrSioYy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qkNwVhaaN134cvvbFcQAZbhH7WLgy2vo/cU6aIBsCPD5rlbpHRJ0YaCHMsVTyoFJhfm1kMlhnji9o+V+w+3kL5RW5KK/M+cxqu2LjcnThlLRpX13VpNhg7Wkjyu7nH4lOWOnZIVO3VkBDR8HPAku0Tl/li9MHxfkoFlbZHODmy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=BgSIY7jr; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1758612094; x=1759216894; i=quwenruo.btrfs@gmx.com;
	bh=u7AEA1HRX0zMdpiP/NdmTcEfVkSFtlBSJcGeF7mHfdc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BgSIY7jrtjBLVp/g3R7j7ZZu2WVi9ouXMHkI3Afbp5oQfA8fdilap2shH6cROqU9
	 ijPT/xmfDzWYCvsd3EB3yE9SqcZoIEVAY9f75d1zzzJzJ9sGQUWO4yGi5TypaGBnq
	 yWjCKUR7lztivOthFf96eDAAI9eJ0T/uCE5ZdYH8rXHERUUv87tMulC5qrccd9nQo
	 JXt3lWY8GImcQ/mKpUpKyWwN4Ehkq2ZYCDPTdKvEApGWbqQSmfUXsZFBLQt1W++4i
	 o+mGHniyflyMQ2PJbMyxpbsUtTqC0e6vXL2lByVURA6MxX87B+rj02sk7Z45OBC/O
	 i9ZM37lbzcKpcMQSMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MysRk-1u5IHH1k4g-00rcca; Tue, 23
 Sep 2025 09:21:34 +0200
Message-ID: <d8ea72ed-b351-4533-9d3e-e5e8e0e97bf4@gmx.com>
Date: Tue, 23 Sep 2025 16:51:29 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Support] failed to read chunk root / open_ctree failed: -5
To: Justin Brown <Justin.Brown@fandingo.org>,
 Chris Murphy <lists@colorremedies.com>
Cc: Qu WenRuo <wqu@suse.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAKZK7uzqNj1336MijN2De-R9+rdjw_Zm6=b-Q1jCCDQb5+fmXw@mail.gmail.com>
 <27b4ca8f-de3a-4b9f-b90d-c6260ba81f9c@suse.com>
 <CAKZK7uxiRmDxk-1goC4yj7QZPSmL-=GAoAuF=OdekbSNVrG8fg@mail.gmail.com>
 <23d859bc-19f9-4cf5-9405-03792dbf2e7a@gmx.com>
 <293aab80-89e4-44fe-b588-977ab24dbf51@app.fastmail.com>
 <CAKZK7ux=z2OT2psm8C06RTM+D4CweQe8dQZxEZ4SNeOwhhfA0g@mail.gmail.com>
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
In-Reply-To: <CAKZK7ux=z2OT2psm8C06RTM+D4CweQe8dQZxEZ4SNeOwhhfA0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BhPEqAqoJW+LNFhXpZgnO3GdIz/AmAWkVchYnWK1sOzxTgqTme2
 XvX0RVLTA+8VlgNdIiOe/WRJKRbVfNmA9+7PMiOUXvmwVrG1AyDYdk5xk5T7Ci8hG9/iALn
 NHL8Q3YslQErm9T9Y0h8YLhAkvUM6Tav51AVagKlnpc7zITSwKy1qPqkbxhUHreFw1Kq3Fo
 bJGBzynLDCt/4QDrJFtQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iQNhjK3nAdQ=;0V1GRtKWfEWBSloKd/yauJs2WVS
 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
 1IyrmqMEZlLm+eAZmIK



=E5=9C=A8 2025/9/22 10:37, Justin Brown =E5=86=99=E9=81=93:
> Hi Qu,
>=20
> Thanks for the response. I ran a readonly check against all the
> bytenrs, but it doesn't look great:
>=20
> [fandingo:~] $ for i in $(sudo  btrfs-find-root -o 3 /dev/mapper/cm |
> grep '^Well' | sed 's/^Well block \([0-9]\+\).*$/\1/g' | sort -n); do
>             echo "######### $i #########" | tee -a /tmp/btrfs-check.txt =
;
>             sudo btrfs check --readonly --chunk-root $i /dev/mapper/cm
> 2>&1 | tee -a /tmp/btrfs-check.txt;
> done
>=20
> Full output at https://pastebin.com/aWKsc9AH

Something is totally wrong.

The chunk tree is not a hot tree, and your initial find-tree-root runs=20
show only several valid tree roots.

The newest one 22233088, the run still results transid mismatch.

If metadata COW is working correctly, even if we lost the current=20
transaction, the previous trees should still be there (unless discard=20
happened).

But it's not the case, so it looks like something is totally wrong.

So I guess something really bad happened...
>=20
> There are a lot of repeated errors, which I guess should be expected,
> and a lot of the same numbers repeated. Decent amount of errors that
> look like this:
>=20
> ERROR: root [3 0] level 0 does not match 1
> ERROR: cannot read chunk root
> ERROR: cannot open file system
> Opening filesystem to check...

BTW, the level 0 one is too old, even if you apply this PR which=20
addressed the level mismatch problem, I believe a lot of chunks will=20
still be lost:

https://github.com/kdave/btrfs-progs/pull/1037

Thanks,
Qu

>=20
> and lots of these, sometimes with different numbers as the bytenr decrea=
ses.
>=20
> ######### 22052864 #########
> parent transid verify failed on 29442048 wanted 2185 found 3178
> parent transid verify failed on 29442048 wanted 2185 found 3178
> parent transid verify failed on 29442048 wanted 2185 found 3178
> Ignoring transid failure
> parent transid verify failed on 1004077056 wanted 4945 found 4933
> parent transid verify failed on 1004077056 wanted 4945 found 4933
> parent transid verify failed on 1004077056 wanted 4945 found 4933
> Ignoring transid failure
> parent transid verify failed on 1004093440 wanted 4945 found 4941
> parent transid verify failed on 1004093440 wanted 4945 found 4941
> parent transid verify failed on 1004093440 wanted 4945 found 4941
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D998031360 item=3D130 parent
> level=3D1 child bytenr=3D1004093440 child level=3D2
> ERROR: failed to read block groups: Input/output error
> ERROR: cannot open file system
> Opening filesystem to check...
>=20
>=20
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20
> Chris,
>=20
> Here's the output of the backup roots. I have no clue what to make of
> this information, though.
>=20
> superblock: bytenr=3D65536, device=3D/dev/mapper/cm
> ---------------------------------------------------------
> csum_type        0 (crc32c)
> csum_size        4
> csum            0x05e1f6bc [match]
> bytenr            65536
> flags            0x1
>              ( WRITTEN )
> magic            _BHRfS_M [match]
> fsid            e2dc4c13-e687-4829-8c24-fa822d9ba04a
> metadata_uuid        00000000-0000-0000-0000-000000000000
> label            media
> generation        4956
> root            998506496
> sys_array_size        129
> chunk_root_generation    4945
> root_level        0
> chunk_root        27656192
> chunk_root_level    1
> log_root        0
> log_root_transid (deprecated)    0
> log_root_level        0
> total_bytes        8001546444800
> bytes_used        6708315303936
> sectorsize        4096
> nodesize        16384
> leafsize (deprecated)    16384
> stripesize        4096
> root_dir        6
> num_devices        1
> compat_flags        0x0
> compat_ro_flags        0x3
>              ( FREE_SPACE_TREE |
>                FREE_SPACE_TREE_VALID )
> incompat_flags        0x361
>              ( MIXED_BACKREF |
>                BIG_METADATA |
>                EXTENDED_IREF |
>                SKINNY_METADATA |
>                NO_HOLES )
> cache_generation    0
> uuid_tree_generation    4956
> dev_item.uuid        529d3f9a-52be-4af5-a8e8-7bf6108c65e7
> dev_item.fsid        e2dc4c13-e687-4829-8c24-fa822d9ba04a [match]
> dev_item.type        0
> dev_item.total_bytes    8001546444800
> dev_item.bytes_used    6856940453888
> dev_item.io_align    4096
> dev_item.io_width    4096
> dev_item.sector_size    4096
> dev_item.devid        1
> dev_item.dev_group    0
> dev_item.seek_speed    0
> dev_item.bandwidth    0
> dev_item.generation    0
> sys_chunk_array[2048]:
>      item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
>          length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
>          io_align 65536 io_width 65536 sector_size 4096
>          num_stripes 2 sub_stripes 1
>              stripe 0 devid 1 offset 22020096
>              dev_uuid 529d3f9a-52be-4af5-a8e8-7bf6108c65e7
>              stripe 1 devid 1 offset 30408704
>              dev_uuid 529d3f9a-52be-4af5-a8e8-7bf6108c65e7
> backup_roots[4]:
>      backup 0:
>          backup_tree_root:    1022836736    gen: 4953    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    1003782144    gen: 4953    level: 2
>          backup_fs_root:        1006288896    gen: 4950    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1003618304    gen: 4953    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708289445888
>          backup_num_devices:    1
>=20
>      backup 1:
>          backup_tree_root:    1005043712    gen: 4954    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    997343232    gen: 4954    level: 2
>          backup_fs_root:        1006288896    gen: 4950    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1005486080    gen: 4955    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708293525504
>          backup_num_devices:    1
>=20
>      backup 2:
>          backup_tree_root:    1011204096    gen: 4955    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    602931200    gen: 4955    level: 2
>          backup_fs_root:        1023918080    gen: 4955    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1005486080    gen: 4955    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708307161088
>          backup_num_devices:    1
>=20
>      backup 3:
>          backup_tree_root:    998506496    gen: 4956    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    1027489792    gen: 4956    level: 2
>          backup_fs_root:        1023918080    gen: 4955    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1025638400    gen: 4956    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708315303936
>          backup_num_devices:    1
>=20
>=20
> superblock: bytenr=3D67108864, device=3D/dev/mapper/cm
> ---------------------------------------------------------
> csum_type        0 (crc32c)
> csum_size        4
> csum            0xa580de72 [match]
> bytenr            67108864
> flags            0x1
>              ( WRITTEN )
> magic            _BHRfS_M [match]
> fsid            e2dc4c13-e687-4829-8c24-fa822d9ba04a
> metadata_uuid        00000000-0000-0000-0000-000000000000
> label            media
> generation        4956
> root            998506496
> sys_array_size        129
> chunk_root_generation    4945
> root_level        0
> chunk_root        27656192
> chunk_root_level    1
> log_root        0
> log_root_transid (deprecated)    0
> log_root_level        0
> total_bytes        8001546444800
> bytes_used        6708315303936
> sectorsize        4096
> nodesize        16384
> leafsize (deprecated)    16384
> stripesize        4096
> root_dir        6
> num_devices        1
> compat_flags        0x0
> compat_ro_flags        0x3
>              ( FREE_SPACE_TREE |
>                FREE_SPACE_TREE_VALID )
> incompat_flags        0x361
>              ( MIXED_BACKREF |
>                BIG_METADATA |
>                EXTENDED_IREF |
>                SKINNY_METADATA |
>                NO_HOLES )
> cache_generation    0
> uuid_tree_generation    4956
> dev_item.uuid        529d3f9a-52be-4af5-a8e8-7bf6108c65e7
> dev_item.fsid        e2dc4c13-e687-4829-8c24-fa822d9ba04a [match]
> dev_item.type        0
> dev_item.total_bytes    8001546444800
> dev_item.bytes_used    6856940453888
> dev_item.io_align    4096
> dev_item.io_width    4096
> dev_item.sector_size    4096
> dev_item.devid        1
> dev_item.dev_group    0
> dev_item.seek_speed    0
> dev_item.bandwidth    0
> dev_item.generation    0
> sys_chunk_array[2048]:
>      item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
>          length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
>          io_align 65536 io_width 65536 sector_size 4096
>          num_stripes 2 sub_stripes 1
>              stripe 0 devid 1 offset 22020096
>              dev_uuid 529d3f9a-52be-4af5-a8e8-7bf6108c65e7
>              stripe 1 devid 1 offset 30408704
>              dev_uuid 529d3f9a-52be-4af5-a8e8-7bf6108c65e7
> backup_roots[4]:
>      backup 0:
>          backup_tree_root:    1022836736    gen: 4953    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    1003782144    gen: 4953    level: 2
>          backup_fs_root:        1006288896    gen: 4950    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1003618304    gen: 4953    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708289445888
>          backup_num_devices:    1
>=20
>      backup 1:
>          backup_tree_root:    1005043712    gen: 4954    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    997343232    gen: 4954    level: 2
>          backup_fs_root:        1006288896    gen: 4950    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1005486080    gen: 4955    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708293525504
>          backup_num_devices:    1
>=20
>      backup 2:
>          backup_tree_root:    1011204096    gen: 4955    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    602931200    gen: 4955    level: 2
>          backup_fs_root:        1023918080    gen: 4955    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1005486080    gen: 4955    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708307161088
>          backup_num_devices:    1
>=20
>      backup 3:
>          backup_tree_root:    998506496    gen: 4956    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    1027489792    gen: 4956    level: 2
>          backup_fs_root:        1023918080    gen: 4955    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1025638400    gen: 4956    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708315303936
>          backup_num_devices:    1
>=20
>=20
> superblock: bytenr=3D274877906944, device=3D/dev/mapper/cm
> ---------------------------------------------------------
> csum_type        0 (crc32c)
> csum_size        4
> csum            0x58078843 [match]
> bytenr            274877906944
> flags            0x1
>              ( WRITTEN )
> magic            _BHRfS_M [match]
> fsid            e2dc4c13-e687-4829-8c24-fa822d9ba04a
> metadata_uuid        00000000-0000-0000-0000-000000000000
> label            media
> generation        4956
> root            998506496
> sys_array_size        129
> chunk_root_generation    4945
> root_level        0
> chunk_root        27656192
> chunk_root_level    1
> log_root        0
> log_root_transid (deprecated)    0
> log_root_level        0
> total_bytes        8001546444800
> bytes_used        6708315303936
> sectorsize        4096
> nodesize        16384
> leafsize (deprecated)    16384
> stripesize        4096
> root_dir        6
> num_devices        1
> compat_flags        0x0
> compat_ro_flags        0x3
>              ( FREE_SPACE_TREE |
>                FREE_SPACE_TREE_VALID )
> incompat_flags        0x361
>              ( MIXED_BACKREF |
>                BIG_METADATA |
>                EXTENDED_IREF |
>                SKINNY_METADATA |
>                NO_HOLES )
> cache_generation    0
> uuid_tree_generation    4956
> dev_item.uuid        529d3f9a-52be-4af5-a8e8-7bf6108c65e7
> dev_item.fsid        e2dc4c13-e687-4829-8c24-fa822d9ba04a [match]
> dev_item.type        0
> dev_item.total_bytes    8001546444800
> dev_item.bytes_used    6856940453888
> dev_item.io_align    4096
> dev_item.io_width    4096
> dev_item.sector_size    4096
> dev_item.devid        1
> dev_item.dev_group    0
> dev_item.seek_speed    0
> dev_item.bandwidth    0
> dev_item.generation    0
> sys_chunk_array[2048]:
>      item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
>          length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
>          io_align 65536 io_width 65536 sector_size 4096
>          num_stripes 2 sub_stripes 1
>              stripe 0 devid 1 offset 22020096
>              dev_uuid 529d3f9a-52be-4af5-a8e8-7bf6108c65e7
>              stripe 1 devid 1 offset 30408704
>              dev_uuid 529d3f9a-52be-4af5-a8e8-7bf6108c65e7
> backup_roots[4]:
>      backup 0:
>          backup_tree_root:    1022836736    gen: 4953    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    1003782144    gen: 4953    level: 2
>          backup_fs_root:        1006288896    gen: 4950    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1003618304    gen: 4953    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708289445888
>          backup_num_devices:    1
>=20
>      backup 1:
>          backup_tree_root:    1005043712    gen: 4954    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    997343232    gen: 4954    level: 2
>          backup_fs_root:        1006288896    gen: 4950    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1005486080    gen: 4955    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708293525504
>          backup_num_devices:    1
>=20
>      backup 2:
>          backup_tree_root:    1011204096    gen: 4955    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    602931200    gen: 4955    level: 2
>          backup_fs_root:        1023918080    gen: 4955    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1005486080    gen: 4955    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708307161088
>          backup_num_devices:    1
>=20
>      backup 3:
>          backup_tree_root:    998506496    gen: 4956    level: 0
>          backup_chunk_root:    27656192    gen: 4945    level: 1
>          backup_extent_root:    1027489792    gen: 4956    level: 2
>          backup_fs_root:        1023918080    gen: 4955    level: 0
>          backup_dev_root:    1055571968    gen: 4945    level: 1
>          csum_root:    1025638400    gen: 4956    level: 3
>          backup_total_bytes:    8001546444800
>          backup_bytes_used:    6708315303936
>          backup_num_devices:    1
>=20
>=20
>=20
> Thanks for both of your help,
> fandingo
>=20
>=20
> On Sun, Sep 21, 2025 at 7:31=E2=80=AFPM Chris Murphy <lists@colorremedie=
s.com> wrote:
>>
>> It might be worth looking at all supers and backup roots.
>>
>> btrfs insp dump-s -fa /dev/sdXY
>>
>> The supers should be all the same on HDD. The backup roots might be mor=
e reliable for attempting repair compared to SSD where I've seen recent (b=
ut zero ref) trees already overwritten by btrfs. That doesn't appear to be=
 the case here, seems like newer trees weren't yet committed to stable med=
ia which is ... not good.
>>
>> ---
>> Chris Murphy
>=20


