Return-Path: <linux-btrfs+bounces-10681-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43B09FF6C7
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 09:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 844F87A1311
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 08:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6403A193402;
	Thu,  2 Jan 2025 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dRjq0MlV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC20D36124;
	Thu,  2 Jan 2025 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735806107; cv=none; b=tjKr1QJG8oQNWKYQVcbg2wk7TFrQDNmuxI4xmDkZAPMVm2sGuGE0Zq18b+Qy6fRwx9TYuBHRA/7ogovVtyvc/hYiqwJimbPZacHRIEennmRUkK52zzR9MCKwGRNm67aplX0jV1A/ezqNIPyEiZS0Yw3DToA68ZPm4LA+GYa5JHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735806107; c=relaxed/simple;
	bh=m58uiayIUqCGJ6O4rdASK8pz5po67u8CVw5Ir/QuBkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFeBTJCmuYWUSeGQThzDDK1zq0giArE4Irm1C3s9SaPfHZtbNIzkfmHZTaU4WG4tvxhFfyo+x2s73TgzakTUNkGDrv/lH93FYxF0groIa/RU42jZLND3HjuuzxrkGIbYTYD9gjcZ0vC0P1fvEk1QUYCootSszuAdTo9AZ0PwwSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dRjq0MlV; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1735806100; x=1736410900; i=quwenruo.btrfs@gmx.com;
	bh=3clGO66SN82wg2+0Em6jYqSBppmhrtyHJc40p3pmzAY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dRjq0MlVuZ4zjwgECMW3/xGstDwD7mgMZEFnMK4leGH+uSgUqgTpuisdV9jFfhau
	 /rozv/nPnN+fEUFdZcXIn3GpuNMXCokDP1Vy40XyZrjZDN/D14UYmwMFf6a5f+ncz
	 i+nGtlngv+pbkTI282HHnb22wz/XZWlhrKeQV+7plp+E2HccmXf5to00qqeJvCcRH
	 kUZfO4UBNepyPutbvXzpcbvz+BEJVXj/bPujR/h/yyoTawrlQR7MYWVb2d3ta/5hp
	 qX1tLDqdJ/W0HbCaTJH+WQhroUiwF07J8VGnyHA8QxleI79hJXk0Y+gxDdSQr/4Tj
	 w2o1eeHm53vmPzUf1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mdvqg-1u0wmj1eKM-00aDfl; Thu, 02
 Jan 2025 09:21:39 +0100
Message-ID: <de8702eb-b800-48bb-ab56-ce4f048c755c@gmx.com>
Date: Thu, 2 Jan 2025 18:51:34 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] btrfs: btrfs can not be mounted with corrupted extent
 root
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+339e9dbe3a2ca419b85d@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <ea0254d9-e285-4f4d-be87-07aed832ebcd@gmx.com>
 <20250102063026.12223-1-lizhi.xu@windriver.com>
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
In-Reply-To: <20250102063026.12223-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iIlCuw25etEpQLGUg8h9EZc4Zflkg320OS8/nOM/80ryXm0EQCk
 JgvfJ6BY0RViNqdxJXIWcHophq+WRxZ60WVuGgDdz1UbX7e3iGb2luC540ErYtytwdNlcoy
 xJGvZuge6DJBqS0N2ALy/6MNbv9epCHSKJtYC6Bu4YLdJAGYmtyZl9eFiHIziXihIhssNeu
 4PzZqbh3F0T+qxtA8GpNA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Fx66LjGtMF8=;rxVClCocszImUG2IWhNTcp1L6Rt
 nPzDkAq/ZTJpUQSSDaC1L1oarf3OpLAPk54jZGWq5skED7Dq+RQ8MUTAHTY1vboiUHXI8CTiV
 kdt5Ko2mLedo4B2VW+0MfODwNctVNeXNiO9QPtgKqc3tFuAFBhb1cPNuzVEkhK6KJECL1E0xo
 9oWteiibgBHSLYzZ3zu5F9O3gegQf6fRp0qBKPQRZlIKiMwytZPFsoFIiQIpZbFek56EyAq00
 Bj6QH3IWodrIs9x0cZRE9XBCUqmGJaT+5fXFI5QvhLCZWdmnlhkdHHQUFdP0n7RKjL83r8NPg
 484TRgyYdhtfJAP0QUjia8u2XX/4TwXFDQGNOEI/89+i7xkX17wT/9ZrnPprqqbOBerpjdxAr
 jwslRGQS7ECP8iJCNZPaSUXiKLr2DOmHeWdHbnDGGqK02kLyR0xkLcFjzjis/4rsvb+9LVFw5
 MUucr8PZteJxm6uFyIyJkBnjplR+LKUCSss/icdzN4BWyk1yom2JKz6cEPf4FAa7m8f6k/cOj
 k+4jB0PLe4mWgDYjJ2r18cerfZjo5vwquL8rx5/VlqMYMfs0aJgx/80eBgg8aW8IIhvrDUpxF
 gPZyiklCZpckpOfoMZY4QPtEFigs1EVTii5e/bMIgGu0MHF5LfG1c7pe4ua1YUGY3hJl2eftf
 zmeTY46FmFSyyKNz1dhOEACOcIxv4KNi+2IWp9qGijpjMZaEpz4HqfVsyzjkWUArpk+6Qvyaa
 olU9GjSwsqdqSRn9msMyBwT8vNbOcH+/P3Gn4Tv+btNEVUUFaIIzyCA6a4I0EOJH9NWv4tBY3
 8dhHsPT9ak7zwVb5vA/Y4xDoy9yYs8PulX7hko4N/pYfYP1VZoNz6nfPJxj66Ka5pW4aA3uZy
 /gbWmM5+MLzuYavF9ekCJd1jHaeOaO1ZwJIkNUfpe6DbbQGkDIR22Arbp2ZRclURdoJnCk77r
 v2236iKf0DSIBGL5JWALbxaxE4tZ0oRIT6NqtWiu6gRagCAjcwrxgHWtWDKm1VIp5JE/otQeU
 qI+2q8kOqPrG4UOY3gOZ0rGB98gbmSFGzidwyDfm6bgkWvzYw7vg8tyJtqbz2L5FCm9j2WbG3
 h5aRqWWzMv/fzZRU7Fp1czgi9uMSlP



=E5=9C=A8 2025/1/2 17:00, Lizhi Xu =E5=86=99=E9=81=93:
> syzbot reported a null-ptr-deref in find_first_extent_item. [1]
>
> The btrfs filesystem did not successfully initialize extent root to the
> global root tree when mounted(as the mount options contain ignorebadroot=
s),
> this is because extent buffer is not uptodate,

The "not uptodate" is only the symptom, if you check the console output
carefully enough, it's because the extent tree root (and must be extent
tree root, any child node won't cause problem) is corrupted (csum mismatch=
).


> which causes the failure to
> read the tree root, which in turn causes extent root to not be inserted =
into
> the global root tree.
>
> To prevent this issue, if extent root is corrupt then exit the mount.
>
> [1]
> Unable to handle kernel paging request at virtual address dfff8000000000=
41
> KASAN: null-ptr-deref in range [0x0000000000000208-0x000000000000020f]
> Mem abort info:
>    ESR =3D 0x0000000096000005
>    EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>    SET =3D 0, FnV =3D 0
>    EA =3D 0, S1PTW =3D 0
>    FSC =3D 0x05: level 1 translation fault
> Data abort info:
>    ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
>    CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
>    GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> [dfff800000000041] address between user and kernel address ranges
> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 1 UID: 0 PID: 6417 Comm: syz-executor153 Not tainted 6.13.0-rc3-syz=
kaller-g573067a5a685 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : find_first_extent_item+0xac/0x674 fs/btrfs/scrub.c:1375
> lr : find_first_extent_item+0xa4/0x674 fs/btrfs/scrub.c:1374
> sp : ffff8000a5be6e60
> x29: ffff8000a5be6f80 x28: dfff800000000000 x27: 0000000000000000
> x26: 0000000000400000 x25: 0000000000400000 x24: 1fffe0001848ab0a
> x23: 0000000000000208 x22: ffff8000a5be6f20 x21: ffff0000c2455858
> x20: ffff8000a5be6ec0 x19: ffff0000db072010 x18: ffff0000db072010
> x17: 000000000000e32c x16: ffff80008b5fea08 x15: 0000000000000004
> x14: 1fffe0001b60c031 x13: 0000000000000000 x12: ffff700014b7cdd8
> x11: ffff80008257f234 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : 0000000000000041 x7 : 0000000000000000 x6 : 000000000000003f
> x5 : 0000000000000040 x4 : 0000000000000008 x3 : 0000000000400000
> x2 : 0000000000100000 x1 : ffff0000db072010 x0 : 0000000000000000
> Call trace:
>   find_first_extent_item+0xac/0x674 fs/btrfs/scrub.c:1375 (P)
>   scrub_find_fill_first_stripe+0x2c0/0xab8 fs/btrfs/scrub.c:1551
>   queue_scrub_stripe fs/btrfs/scrub.c:1921 [inline]
>   scrub_simple_mirror+0x440/0x7e4 fs/btrfs/scrub.c:2152
>   scrub_stripe+0x7e4/0x2174 fs/btrfs/scrub.c:2317
>   scrub_chunk+0x268/0x41c fs/btrfs/scrub.c:2443
>   scrub_enumerate_chunks+0xd38/0x1784 fs/btrfs/scrub.c:2707
>   btrfs_scrub_dev+0x5a8/0xb34 fs/btrfs/scrub.c:3029
>   btrfs_ioctl_scrub+0x1f4/0x3e8 fs/btrfs/ioctl.c:3248
>   btrfs_ioctl+0x6a8/0xb04 fs/btrfs/ioctl.c:5246
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:906 [inline]
>   __se_sys_ioctl fs/ioctl.c:892 [inline]
>   __arm64_sys_ioctl+0x14c/0x1cc fs/ioctl.c:892
>   __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>
> Fixes: abed4aaae4f7 ("btrfs: track the csum, extent, and free space tree=
s in a rbtree")

I do not think that's the correct commit.

Even before that commit, inside scrub_stripe() we directly use
fs_info->extent_root without checking if it's NULL.

And pass that extent_root into btrfs_reada_add(), which later calls
"rc->fs_info =3D root->fs_info;", triggering exactly the same error.

Before 42437a6386ff ("btrfs: introduce mount option
rescue=3Dignorebadroots"), there is no error path like this at all,
because btrfs will just refuse to mount such fs with extent tree root
corrupted.

So please, understand what is really causing the problem then submit a fix=
.

Thanks,
Qu
> Reported-by: syzbot+339e9dbe3a2ca419b85d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D339e9dbe3a2ca419b85d
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
> V1 -> V2: exit mount when extent root is corrupt
>
>   fs/btrfs/disk-io.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index eff0dd1ae62f..beb236c7fe1c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2167,7 +2167,8 @@ static int load_global_roots_objectid(struct btrfs=
_root *tree_root,
>   		found =3D true;
>   		root =3D read_tree_root_path(tree_root, path, &key);
>   		if (IS_ERR(root)) {
> -			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS))
> +			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS) ||
> +			   objectid =3D=3D BTRFS_EXTENT_TREE_OBJECTID)
>   				ret =3D PTR_ERR(root);
>   			break;
>   		}
> @@ -2188,7 +2189,8 @@ static int load_global_roots_objectid(struct btrfs=
_root *tree_root,
>   		if (objectid =3D=3D BTRFS_CSUM_TREE_OBJECTID)
>   			set_bit(BTRFS_FS_STATE_NO_DATA_CSUMS, &fs_info->fs_state);
>
> -		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS))
> +		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS) ||
> +		   (ret && objectid =3D=3D BTRFS_EXTENT_TREE_OBJECTID))
>   			ret =3D ret ? ret : -ENOENT;
>   		else
>   			ret =3D 0;


