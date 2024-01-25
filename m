Return-Path: <linux-btrfs+bounces-1774-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8DB83B89D
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 05:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3B0EB23810
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 04:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EC7D2E8;
	Thu, 25 Jan 2024 04:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="VuW7+8Ig"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5918830
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 04:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706156503; cv=none; b=ISvdF0SykrnpbOLE2f5GzIpCALTgxZdDLSWMTtvOHvlx6hQ/O0Giu4g+DHTIOr+ifxKOFYbpyrRkzUOpNfbQ8YYh5rIRcDRiKgAzOGahLlD83JZ9zMj0nuWLOhILBpy88N6ghf1FghBqU50UI/8zIW7/0kFgo2JsGm2Vq4fyQvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706156503; c=relaxed/simple;
	bh=RFDYPjvqDBvQblu2SnwDL+ZTZmsj8t6R7+yuO4mCoyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bblPoyyHiLp7uhXoHsQCaXecPgNRiFNg7DNBrE+Rhv/pvryXX8CJiej1aVNfRPKRukQwJqOaGVPkmmMh8DiRBiHNSLGenttU8qOnmOCUv1gCbMsEs9P0mgGIM881ipmUz8KUSrQgiHYsBnyoYTQqk1PVr4+KG6F5wmjLhg1MzXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=VuW7+8Ig; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706156498; x=1706761298; i=quwenruo.btrfs@gmx.com;
	bh=RFDYPjvqDBvQblu2SnwDL+ZTZmsj8t6R7+yuO4mCoyU=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=VuW7+8IgZCszjWBDvy97G0khATXb0vX320HkIFoQ5YQGaNXy8w3Qt5Ts+64GJGfz
	 nW+2LqSEDeYGCvPQ88Z1bNhSw+JuJnl1aFOkBxwhdtCktcksErX1/r6/KJKO7rl9c
	 Hz0MeiMbqIWsQGDLsu2xlM3JAi7+vnZXqWkbG8e3bAsHPeDr01F/4Dw0e+3MCVL43
	 TLnTQNHaodxjCi+07aw6kbDH1dBBuZQUmzRIG1SnagcUJVWWJzrb05Eeva6Xepp4P
	 UHvRDJ0zXBx7KEIEGFrO5jZFqg5yWly3znf89HBJ5mcZOQmpyJ8DyxxD1rmLD3rLY
	 86WqHBCtUfJsb0SV9Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([61.245.157.120]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N6bk4-1r1hUN2Me6-0185jF; Thu, 25
 Jan 2024 05:21:38 +0100
Message-ID: <5186824d-3d1a-42ac-9b6b-6773105ad560@gmx.com>
Date: Thu, 25 Jan 2024 14:51:34 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] Error handling fixes
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1706130791.git.dsterba@suse.com>
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
In-Reply-To: <cover.1706130791.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wbBPDZ9WFVvdi3P0zilCmyEfGXykjwFqkmqxxEYo1pJCfAbmP10
 1EiOe0L5Rw6IPqPTnXvGkRocv8D1cgrc/zk+KFhYQwsCfS9ayFDKiLb+ugZds3c8TUkPCzu
 zvtGd1mzg03a+ug/Wb9bRsNXHsxsIDvX5oKASODbVNMI60BYU+595p7Wuv/GqR5/Oy/XBpM
 5M/h/0D3O2ZuBmon7ydGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pc2h7dSYUNg=;8GKbKKEKOHmsoGq/Vwlg2pxZb0k
 JpfkVXnvGJmoBZbVgTbt1zF9QqU1SynBuPlTLwNBp3LYW6dJRDmZ3YeJMVuqY1jAIo7MvwwmH
 LnxKA0VnU/34IIOvF8vL5u415b7rhIA/F/jJEKT/O7Td5GIZ2q0TktCX9xEzr7hBE6KjzSJHg
 hqz9L7zwdwDfkW8Ko5metOi31LS6ECctyHRrN5l3vDRtZkY+0JD+uAwSBdJ4I+LZcFzpeqCvF
 WpeI46CpqfOgdiBxLXms8OlgcMt//fAV4+lvsLTJsIBZBL/WVBjXLR/L/GFzduYzSr0Cf/tvO
 Njl0v+5JDvOaNF4KKxKNxoIIfb+YSrEcZO+7o1YVwsecY1HPFnSCetZgs/9gT8BhDxDw0friZ
 3pvPVeGEd+K3awzRcuFJ0Y3IFlU9JOwSQoCSXyC2AE9s5qHIRJL+WqJAjaXqh/iSBvXbGQ4JA
 txA5J+NqyaJ+bYJyBs667TWmrm7u8slGMwjIGs7EhO3J4qsfOeSuKwVr6uKsAB/SOfDRB/+Nz
 ykZNXVdb29hZKui2rMrPZlesixP6JViIJVxzwjbcV/dO9sAfv4wIe2q/K+dJBZbGP+f3/E0LI
 ZYXr33+b1rDor4NZBCeW5NJ5UlFBUhpvbTn2xemxBX9HH8pmw2HHcd9iNKl26qHpOAVtX2g8w
 ZSHtHV8Ck+pDJCXCCttfR3Z22RoEyP3J7Lfv2q6PLA4h4HdtPOrjZbl5aczvZSbqD33EZ7WW1
 O7/COwjjbzDuaF+tXd0KFdl0GZT74CCbHrMpg/ElkkmaVK5CTwzy91y3OePNxW/DMho5zVN1I
 yng3TmDQvrxvnjzBgmjUyXAdD5RMfW0X8KvLfdRzHy0Nh6H+49slqk/zgMW/CCcYpoFCcIL/J
 AaRWoTP7gTSHBBmwIcjKC7rqc8tJDuxVJFlVsGKuJbnJKkhljoQgukJVvInZhLCRecZPuIrSU
 IwOq0A==



On 2024/1/25 07:47, David Sterba wrote:
> Get rid of some easy BUG_ONs, there are a few groups fixing the same
> pattern. At the end there are three patches that move transaction abort
> to the right place. I have tested it on my setups only, not the CI, but
> given the type of fix we'd never hit any of them without special
> instrumentation.

Sorry, I bombarded the mailing list again...

So there is the summary of my comments here:

>
> David Sterba (20):
>    btrfs: handle directory and dentry mismatch in btrfs_may_delete()
>    btrfs: handle invalid range and start in merge_extent_mapping()
>    btrfs: handle block group lookup error when it's being removed

For those error handling patches, I believe for all the BUG_ON() cases,
we should return -EUCLEAN, with an error message.

If possible we should also abort the transaction early (which can be
noisy enough to be caught by test cases, and give better call trace)

>    btrfs: handle root deletion lookup error in btrfs_del_root()
>    btrfs: handle invalid root reference found in btrfs_find_root()
>    btrfs: handle invalid root reference found in btrfs_init_root_free_ob=
jectid()

For those key.offset =3D=3D -1 search case, tree-checker may be a better
solution, as it provides more detailed info for us to debug.

But you may only want such offset =3D=3D -1 check for certain key types.
As I'm not sure if something key types (e.g. DIR_ITEM, whose key offset
is a hash).

Then those call sites can convert to ASSERT() for key hit case.

>    btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()
>    btrfs: handle invalid extent item reference found in check_committed_=
ref()
>    btrfs: export: handle invalid inode or root reference in btrfs_get_pa=
rent()
>    btrfs: delayed-inode: drop pointless BUG_ON in __btrfs_remove_delayed=
_item()
>    btrfs: change BUG_ON to assertion when checking for delayed_node root


>    btrfs: defrag: change BUG_ON to assertion in btrfs_defrag_leaves()
>    btrfs: change BUG_ON to assertion in btrfs_read_roots()
>    btrfs: change BUG_ON to assertion when verifying lockdep class setup
>    btrfs: change BUG_ON to assertion when verifying root in btrfs_alloc_=
reserved_file_extent()
>    btrfs: change BUG_ON to assertion in reset_balance_state()

I'm totally fine with BUG_ON() to ASSERT() changes.

>    btrfs: unify handling of return values of btrfs_insert_empty_items()
>    btrfs: move transaction abort to the error site in btrfs_delete_free_=
space_tree()
>    btrfs: move transaction abort to the error site in btrfs_create_free_=
space_tree()
>    btrfs: move transaction abort to the error site btrfs_rebuild_free_sp=
ace_tree()

And earlier transaction abort is also pretty good to me.

Thanks,
Qu

>
>   fs/btrfs/block-group.c     |  4 ++-
>   fs/btrfs/ctree.c           |  4 +++
>   fs/btrfs/defrag.c          |  2 +-
>   fs/btrfs/delayed-inode.c   |  4 +--
>   fs/btrfs/disk-io.c         | 11 ++++++--
>   fs/btrfs/export.c          |  9 +++++-
>   fs/btrfs/extent-tree.c     | 11 ++++++--
>   fs/btrfs/extent_map.c      |  9 +++---
>   fs/btrfs/file-item.c       |  3 --
>   fs/btrfs/free-space-tree.c | 56 ++++++++++++++++++++++----------------
>   fs/btrfs/ioctl.c           |  4 ++-
>   fs/btrfs/locking.c         |  2 +-
>   fs/btrfs/root-tree.c       | 16 +++++++++--
>   fs/btrfs/uuid-tree.c       |  2 +-
>   fs/btrfs/volumes.c         | 14 ++++++++--
>   15 files changed, 102 insertions(+), 49 deletions(-)
>

