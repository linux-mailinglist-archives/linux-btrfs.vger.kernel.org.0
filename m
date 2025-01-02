Return-Path: <linux-btrfs+bounces-10678-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E2A9FF621
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 05:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897B63A2F77
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 04:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C569E18B494;
	Thu,  2 Jan 2025 04:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="b/Ravbo9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE6C45027;
	Thu,  2 Jan 2025 04:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735792974; cv=none; b=ZsXwF8cgtxJJ/VdzZOTZx3E7rWpDVpT4V1RVaDoyJsWwLP1pOJBGzsgB7j6A3m09PRt4XlaXZjtsRvUNNgrCfG/QlxIBhKvgyFKvvq2wi6CKw2oR2jga3UL8X/TbiJnQ8kiayGx9FX+J/mGNPL87V6sYPEBz3HUfzfWOq9UYEmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735792974; c=relaxed/simple;
	bh=7FFyhP17hEzNWfBJQrMCJyI7AV6d06n1b2NcrSkbZYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g8Oh+hT9Ojqx/sWn5eTdrsIcf6jI/95ZVg98tvrUvAol4yhoQvKPjXaI+OluleHR+N3ERbrhyqDcXYPUJw6MEOx1ecdfAhHv1tSAEZfZ3d7sIesNu7xhtuUrL+7Dp/dVox6FiO0lzbTfwXsn2M0fhjZGm4bQ8HNlk/u+c2mVmeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=b/Ravbo9; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1735792959; x=1736397759; i=quwenruo.btrfs@gmx.com;
	bh=krtVzv+3HaPLMkB/lA6qPbR0q5bznYGsreH+aMwyMZg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=b/Ravbo9frhiqwLuWy7ki3fOiLzQWk2uz0OqX/eIaQ54OK4DhWKVFYSahwvWnJP5
	 ZJ1my5XVI54BFcpMw8rQBm/wvZgwHl4X/DTdnYRZ/dfkj6eHNNK6Oo331hnesIqsX
	 ji7mgFccl15Dqucd3iZ/yHJLIXI9e+7LwosHoMxiUTlQzzc8R7qynbg5ovuEJWFI/
	 KjuraOjCnwdpc1Ll4aNsvi4XoXhyDGlMtRhG6rrJs02RSJq9X5lL/o4FrC6Ypfgcj
	 2boUDFhjtKtxTgiQazDbT3PP9F4HCXTnHIkKmYItAvV04IzPjfEzA4KRf8xPf6eX/
	 Bohts54Ojd+qqtEaNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbVu-1tGZhw3Xv4-00GMIQ; Thu, 02
 Jan 2025 05:42:39 +0100
Message-ID: <ea0254d9-e285-4f4d-be87-07aed832ebcd@gmx.com>
Date: Thu, 2 Jan 2025 15:12:33 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Prevent the use of invalid extent root
To: Lizhi Xu <lizhi.xu@windriver.com>,
 syzbot+339e9dbe3a2ca419b85d@syzkaller.appspotmail.com
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <67756935.050a0220.25abdd.0a12.GAE@google.com>
 <20250102040558.3339238-1-lizhi.xu@windriver.com>
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
In-Reply-To: <20250102040558.3339238-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y9HW0U500dBJcUm/ZGkm8l1QiBchGKO7geRHQre3A5q6ptR2Kmn
 x/3sPhF3U64jpiokpRCf02jWvKcNApxWIb3heoBfKjWKQ/7QiIkq7jcLUuhWiWRbsLW73B6
 Nqp15Ro2QcA96cBSSFvSHRUfXouQzMjmjvcyD16VRDqaZDQdiKma3T/dp+tsmM/R7VhJyYi
 E3NF5D1ISNpsDGPopfUiw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8PtOXJHlQyE=;JuXy7CFNrj5dKGO9fcDOeU422FI
 36bLs3z5NF09/HSbKATryHIFhi3XH02532Ntry9KY3BTfX+/POxHXaslq0HSGr3Oh7k3OBaYZ
 vXIu9JqP7C/APkoSWTidrpZgTnChAO6/Z7lWuHceNt+iB/gFA2ETsCsIyLhWL82Lz6RF5hli5
 bJ9njia5C2e7W+P32PSEshmjK95znYMxMJtqRGn/PTxaA++bNCqN/Ehp3fd5EEbr8i0PadL3K
 hBLkyRMWAA8phztqptueb4VWi31XP5eAPM3Qx2e6leRMKKhQwmzJAUL+u6eCZZ6ULdyRTKild
 5117fkpTpvNjfw+jZAZF9le8Wakb0R8+14RKvotaMtL+zqGcDbdxvz8jbvFfJELN4Zj+LPA/Q
 Z2+HNjRB8tQse4tk59daRRQTb0jgCUy1+xvX9gVmUVfW/yhYefCRhZ7cjWN9b4koDrqUdnyFe
 X+tBWctdxDIT8zYbfi95DxHaLHQF6isznXfDMCxoP5FPAnNf/RSmh3UrMGhf5xnuwHA0vo5Eg
 BhuRBX70E9jQN/8/1ovwYtNkRQmZr4RcItMPlSloqZ2Av+iWgvAkpg4CoCPlagr2y2Bk/FAsN
 SZZgsuddb40ABZyWOneaVyq1SQk3Wn9EEG95WWYa1Kq2JeNm8+mPcBN+wMlV3O4jcVtYZqDT5
 7HVCxqhdlJu/6esN7uIpMk4u0i6l1oSCZtZ7HnMDVk7fJgTmcfrPw7/nzt4ZvEZv7AOUzAeot
 GVA/E06MCQ/ieAOOk9kJbAnn8pIVodry/LXaBS9TGFk+4ImCxyePv5ngFqYz5XjzGOb6wWEuW
 i5Rxa6uau07gAvF8WK2mOzI87OWKNP1X3ej9/aVx0zGICGCNI9v1UXZiAyODPNhy95huHqauN
 jf+qc8mxFQ7eR1uC7U7Xu7ycRlo8Akxkuo3c3c1/yEvgmhH+PgFJkpakV2n/5Sy3FPpDCVxe0
 Ee0vFwtM2ZmnH3DhkrwbJSbgxZqLl/UuaKMkMqhoAhKmYxxkvED7D+0zXnWyfidZbtjW8DdKD
 nn4N/LmzzNm5NV3JEHNhcAwur6i9Ke+7Qaduh8yFLF1LiQmet6oPMVOWElHo9QPzJauGUrFVH
 nqi1PBFoFxevA/KtxNayX0RVtFgtyy



=E5=9C=A8 2025/1/2 14:35, Lizhi Xu =E5=86=99=E9=81=93:
> syzbot reported a null-ptr-deref in find_first_extent_item. [1]
>
> The btrfs filesystem did not successfully initialize extent root to the
> global root tree when mounted, this is because extent buffer is not upto=
date,
> which causes the failure to read the tree root, which in turn causes ext=
ent
> root to not be inserted into the global root tree.

Sorry I didn't notice your fix and sent out my version.

I'd prefer your patch to mention that, this is not the common case.
As a btrfs can not be mounted with corrupted extent root.

Such fs can only be mounted with rescue=3Dall,ro mount option as a data
salvage method.

And you do not need to go through all the global root/extent buffer
uptodate things, just mention a corrupted extent tree root is more than
good enough.

>
> To prevent this issue, add extent root check before using it.
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
> Reported-by: syzbot+339e9dbe3a2ca419b85d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D339e9dbe3a2ca419b85d

If you understand the reason why this is possible in the first place,
you can find out the offending commit, where the rescue=3Dibadroot mount
option is introduced.

Although in the latest kernel it's b979547513ff ("btrfs: scrub:
introduce helper to find and fill sector info for a scrub_stripe")
causing the problem, the same problem also happens before the scrub rework=
.

So next time please add related fixes: tag for similar reports.

Thanks,
Qu

> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>   fs/btrfs/scrub.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 204c928beaf9..6080839cec95 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1372,10 +1372,14 @@ static int find_first_extent_item(struct btrfs_r=
oot *extent_root,
>   				  struct btrfs_path *path,
>   				  u64 search_start, u64 search_len)
>   {
> -	struct btrfs_fs_info *fs_info =3D extent_root->fs_info;
> +	struct btrfs_fs_info *fs_info;
>   	struct btrfs_key key;
>   	int ret;
>
> +	if (!extent_root)
> +		return -ENOENT;
> +
> +	fs_info =3D extent_root->fs_info;
>   	/* Continue using the existing path */
>   	if (path->nodes[0])
>   		goto search_forward;


