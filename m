Return-Path: <linux-btrfs+bounces-14633-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 067F9AD7E5E
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 00:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33B31896042
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 22:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B7F2DECCA;
	Thu, 12 Jun 2025 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Aw2mgB+M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B0E2D0292
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 22:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749766899; cv=none; b=gfe+HmpriLohs9dcdCCK0Sa3zuFODRRCfArnKSeul8VNFY1guInjZC3ekwgb6yWvH3dsI2v6HjCXnny4gLjExLGSq1ErDrekIvamufoSSZxYsqwSMrhwGR0gPECxswUrTAapsWlezUgn31+prD6QZQFZHkx16YW785BpLFZUwVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749766899; c=relaxed/simple;
	bh=nl033xPtL1UFagsjZmZSd59yLXEGN0NZ36IeDMtNITI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZV4IKPMKK7X+Uwn/qeYuFJ1tQ2LTTtNvGih05PaHj26boR41L4+TJ2DZpf+u28uEn8AbNWhkVjxLDgfqjPLxT1gVfnIUWI7fq6JwIQ/0z5aYQsBzQa1bgaNHO7thymyjnlT+qNO3for2YuIcGZqgaZfFu7mJri0k4XQzCmQ+QqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Aw2mgB+M; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1749766890; x=1750371690; i=quwenruo.btrfs@gmx.com;
	bh=3akd6P6M/3mtZ0hcW4MincjI4X4Vwz6IK01YpA/XU8Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Aw2mgB+M/rdMC1XFJUL5SgKJSbmDbV/C1vqQPI4xgPdflwEDCCmY7yUvQ40jox7O
	 YiF1kPz7LzyGQkKQE/R0KcFu5CH9h5L6uSQS2KVRkVkZu/l7bZs0nqzclNR5GhwGJ
	 117kpVsOyXeJY5L3ooOmizVMdwz+OdQPCjte0pT0xDisLASFUT8Fr5QlwSqnk3x2M
	 m+HN+W7pQx0ltIoTBUq8tDsdTXKZuuyWpUkEwfq5wixltPYRyQsiufsi3hJdhLh8d
	 5reg/K+qPLBye2BWFHudSCkToNtgtFbjks51v/+TLsvlQSEAIHZVJQAbjcwRLMNs5
	 1vs48N7l6aYs5AZ4Fw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6ll8-1uSaON3nA6-00G8hi; Fri, 13
 Jun 2025 00:21:30 +0200
Message-ID: <01b0f70f-c131-4b79-a997-7317176d6269@gmx.com>
Date: Fri, 13 Jun 2025 07:51:25 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] btrfs: use the super_block as bdev holder
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, WenRuo Qu
 <wqu@suse.com>, Johannes Thumshirn <jth@kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc: Boris Burkov <boris@bur.io>, hch <hch@lst.de>,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
References: <20250611100303.110311-1-jth@kernel.org>
 <9093e0d6-d33e-4c4b-814f-9134d568f395@suse.com>
 <69982e5e-96d3-4e60-891c-ade4474253cc@suse.com>
 <1618ecb3-2bc5-4c48-89d5-ba1c9ec788b3@wdc.com>
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
In-Reply-To: <1618ecb3-2bc5-4c48-89d5-ba1c9ec788b3@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tczEk05/XpinZg9aruR610Vvnb9OYTAH360RxqIIQbbPtLzI2Ug
 hlwaEbApge8tyMNum5xlYzRO31XAmA+FkijMEXwddECU1wA1pRl5QeD5NEQbON7EXArG+4f
 fw2w6bK104Gtxtk+n4QUz24wrdAMHjbRMfS1btDH/ep+B/FNMSCTqRmWd8BkmmnRPovfS3e
 2S8KFwD78RgvWx9K5ea4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:odiQ0oz+d20=;qQKWolE8opJU94+BBlAlCjGPMhy
 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



=E5=9C=A8 2025/6/12 21:45, Johannes Thumshirn =E5=86=99=E9=81=93:
> On 12.06.25 00:06, Qu Wenruo wrote:
>> This is at the line "if (fs_info->fs_devices)", so at this stage fs_inf=
o
>> is NULL already.
>>
>> And it's again back to the original comment on the 2nd patch, why we
>> need to close the devices at btrfs_reconfigure_for_mount().
>=20
> Sorry for not running the series through fstests after the rebase.
>=20
> As for your question, give me some time to answer it. I'm currently
> only "working" on this while test runs are ongoing for different,
> more urgent problems I'm focused on, sorry.
>=20
> One thing I've added on top is:
>=20
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 30c928562558..edf335a7382d 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2007,7 +2007,8 @@ static int btrfs_reconfigure_for_mount(struct fs_c=
ontext *fc)
>            * We got a reference to our fs_devices, so we need to close i=
t here to
>            * make sure we don't leak our reference on the fs_devices.
>            */
> -       if (fs_info->fs_devices) {
> +       if (fs_info && fs_info->fs_devices) {
> +               ASSERT(fs_info->fs_devices->is_open);
>                   btrfs_close_devices(fs_info->fs_devices);
>                   fs_info->fs_devices =3D NULL;
>           }
>=20
> So if we end up in btrfs_reconfigure_for_mount() and fs_info and
> fs_info->fs_devices are set, I see the is_open flag being set as
> well. But the fstests run isn't 100% finished yet (and it's only
> been a -g quick run anyways).

Since I'm also working on cleaning up the mount process, I'm getting a=20
little familiar with this part, but if HCH can comment on this, it will=20
be a great help.

At this stage, we either:

- Created a new super in btrfs_get_tree_super()
   This means it's the first mount of this fs.

   In that case, sget_fc() will set dup_fc->s_fs_info to NULL.

   So we do nothing for this case.

- Grabbed an existing super in btrfs_get_tree_super()
   In this case dup_fc->s_fs_info is not touched, but it's still assigned
   to a temporary fs_info allocated inside btrfs_get_tree_subvol().

   And since this patch removed the btrfs_close_devices() calls, we have
   to close the devices somewhere, and since there is no new sb
   allocated we can not rely on kill_sb() calls.

   So we have to close the fs_devices here.

   But I do not think it's the correct timing. Close of fs_devices should
   happen immediately after we know there is already an existing sb.

   So the old "if (sb->s_root) { btrfs_close_devices(); }" is the correct
   timing, and we should not remove it in this patch.

   And the close inside btrfs_reconfigure_for_mount() looks more like an
   incorrect hot fix to patch up that removal.

So overall, I still do not think we should do any device close inside=20
btrfs_reconfigure_for_mount(), but keep the close_devices() call inside=20
btrfs_get_tree_super() and add extra comments on that.

Thanks,
Qu


