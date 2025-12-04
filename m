Return-Path: <linux-btrfs+bounces-19505-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CEFCA241E
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 04:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4505230454DD
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 03:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1642BEC2C;
	Thu,  4 Dec 2025 03:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="flMF+fkH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780F9398FA8
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 03:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764819083; cv=none; b=CVh3YjK8B8o6bjxEONMM0ks2w49Ebes5KVegT03ZOwFB72rIo6GO0XXNPTxSaLAIRsit0MgX8gYAXFoVus9TMVFrM8L8jPhhXSBKdiIO0wpVnsrDH6AE5UcdbNKfPPWR26Z3T9MCeN1Aa8+V0lmaIKbqgdK8VzX1dhgigJsJ444=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764819083; c=relaxed/simple;
	bh=Xwd+vQbU6CuSubAHko/ptjnCGIoFwYXneU3IxKTJaU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Bbn+m5EupMlTmZn/38/34ltw4PW9mBjKBlCmek8IanErLdhDrGb9ihKlgDbJeMg8U9xQOkeWGg0dOCwRTFDSN9epH4o2HV7v8ZhPdcmNAliCxCxDnjvrDOMfFwtnBpnBqnAZQ9srPg1RTqnrb87jyvvvhDuwUkUK3iezE/FIR2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=flMF+fkH; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764819075; x=1765423875; i=quwenruo.btrfs@gmx.com;
	bh=8t7Sy9qzZDnctFaVAcwXGIEXAv/GVyhw33dyLDf+iHc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=flMF+fkHc+yoXLfnIy9WdUrV4CsEPIHymgb2wwYdHp/KAMyVI3Nmz48GQ6hh3m2M
	 n85JwQQW+f/tjJSOJ3r2LXESGnJszZtWUVJGPIZ8eUIWmVmI9Av9IuONkAPYlct2e
	 e3Dmz5jiQ/sv/GhfduBWhvlhX/ZXfKN1FVOTUsBatKtqHqD4T1JYGFN5r14QTlPVK
	 FT48UIv4EwGHMxD0MNnmCBOB4UOh2Mic9dcmU++UhK82flz06+AKhkaGXGjl+WEHw
	 aTY0M75IG5ISJj8oKrOw456BuKsc5OluG6VZvRO7oa9rAsEeT9BQrNKDrZZAxsDDL
	 QwwLvAM7dCvCU8n2fQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmUHj-1vrIP52TDN-00d2NH; Thu, 04
 Dec 2025 04:31:15 +0100
Message-ID: <05ea4e9f-87aa-472c-a239-7f4f9faa93e9@gmx.com>
Date: Thu, 4 Dec 2025 14:01:10 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs: fix qgroup_snapshot_quick_inherit() squota bug
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1764796022.git.boris@bur.io>
 <f9b72f1440cd4c4f63dbe224256afb65c0671a4e.1764796022.git.boris@bur.io>
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
In-Reply-To: <f9b72f1440cd4c4f63dbe224256afb65c0671a4e.1764796022.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uE+YBwOljFkDdow/jhLM0wQQsXmBHtxEgFoMQdhgIgc8xE2ne5H
 cUifX8zkft+92eLPHW3CXBdWflK9ADEzIELpG2Q9CmK7zzgkQ8WGl3y/nGWCcSsIO2bYkju
 9ighrsyCJ55CAcpWb7csV3ZlNfpO6z6Yalr/Z8XlHGPxLY+hr9Ebom1MrYXyAEIJn+uYtQL
 Z3D5SFX0KPqRtcUgVIzGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qjsWBp4hNmU=;7Rl7ixQvDxy/7lfEg5QKi17cfEJ
 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
 pVyciEea/zaqxW+XNKLJhWICZL5e3



=E5=9C=A8 2025/12/4 07:41, Boris Burkov =E5=86=99=E9=81=93:
> qgroup_snapshot_quick_inherit() detects conditions where the snapshot
> destination would land in the same parent qgroup as the snapshot source
> subvolume. In this case we can avoid costly qgroup calculations and just
> add the nodesize of the new snapshot to the parent.
>=20
> However, in the case of squotas this is actually a double count, and
> also an undercount for deeper qgroup nestings.
>=20
> The following annotated script shows the issue:
>=20
>    btrfs quota enable --simple "$mnt"
>=20
>    # Create 2-level qgroup hierarchy
>    btrfs qgroup create 2/100 "$mnt"  # Q2 (level 2)
>    btrfs qgroup create 1/100 "$mnt"  # Q1 (level 1)
>    btrfs qgroup assign 1/100 2/100 "$mnt"
>=20
>    # Create base subvolume
>    btrfs subvolume create "$mnt/base" >/dev/null
>    base_id=3D$(btrfs subvolume show "$mnt/base" | grep 'Subvolume ID:' |=
 awk '{print $3}')
>=20
>    # Create intermediate snapshot and add to Q1
>    btrfs subvolume snapshot "$mnt/base" "$mnt/intermediate" >/dev/null
>    inter_id=3D$(btrfs subvolume show "$mnt/intermediate" | grep 'Subvolu=
me ID:' | awk '{print $3}')
>    btrfs qgroup assign "0/$inter_id" 1/100 "$mnt"
>=20
>    # Create working snapshot with --inherit (auto-adds to Q1)
>    # src=3Dintermediate (in only Q1)
>    # dst=3Dsnap (inheriting only into Q1)
>    # This double counts the 16k nodesize of the snapshot in Q1, and
>    # undercounts it in Q2.
>    btrfs subvolume snapshot -i 1/100 "$mnt/intermediate" "$mnt/snap" >/d=
ev/null
>    snap_id=3D$(btrfs subvolume show "$mnt/snap" | grep 'Subvolume ID:' |=
 awk '{print $3}')
>=20
>    # Fully complete snapshot creation
>    sync
>=20
>    # Delete working snapshot
>    # Q1 and Q2 will lose the full snap usage
>    btrfs subvolume delete "$mnt/snap" >/dev/null
>=20
>    # Delete intermediate and remove from Q1
>    # Q1 and Q2 will lose the full intermediate usage
>    btrfs qgroup remove "0/$inter_id" 1/100 "$mnt"
>    btrfs subvolume delete "$mnt/intermediate" >/dev/null
>=20
>    # Q1 should be at 0, but still has 16k. Q2 is "correct" at 0 (for now=
...)
>=20
>    # Trigger cleaner, wait for deletions
>    mount -o remount,sync=3D1 "$mnt"
>    btrfs subvolume sync "$mnt" "$snap_id"
>    btrfs subvolume sync "$mnt" "$inter_id"
>=20
>    # Remove Q1 from Q2
>    # Frees 16k more from Q2, underflowing it to 16EiB
>    btrfs qgroup remove 1/100 2/100 "$mnt"
>=20
>    # And show the bad state:
>    btrfs qgroup show -pc "$mnt"
>=20
>          Qgroupid    Referenced    Exclusive Parent   Child   Path
>          --------    ----------    --------- ------   -----   ----
>          0/5           16.00KiB     16.00KiB -        -       <toplevel>
>          0/256         16.00KiB     16.00KiB -        -       base
>          1/100         16.00KiB     16.00KiB -        -       <0 member =
qgroups>
>          2/100         16.00EiB     16.00EiB -        -       <0 member =
qgroups>
>=20
> Fix this by simply not doing this quick inheritance with squotas.
>=20
> I suspect that it is also wrong in normal qgroups to not recurse up the
> qgroup tree in the quick inherit case, though other consistency checks
> will likely fix it anyway.

It's indeed wrong for the regular qgroup:

  mkfs.btrfs  -f -O quota $dev
  mount $dev $mnt
  btrfs subv create $mnt/subv1
  btrfs qgroup create 1/100 $mnt
  btrfs qgroup create 2/100 $mnt
  btrfs qgroup assign 1/100 2/100 $mnt
  btrfs qgroup assign 0/256 1/100 $mnt
  btrfs qgroup show -p --sync $mnt
  Qgroupid    Referenced    Exclusive Parent     Path
  --------    ----------    --------- ------     ----
  0/5           16.00KiB     16.00KiB -          <toplevel>
  0/256         16.00KiB     16.00KiB 1/100      subv1
  1/100         16.00KiB     16.00KiB 2/100      2/100<1 member qgroup>
  2/100         16.00KiB     16.00KiB -          <0 member qgroups>
  # So far so good

  btrfs subv snap -i 1/100 $mnt/subv1 $mnt/snap1
  btrfs qgroup show -p --sync $mnt
  Qgroupid    Referenced    Exclusive Parent     Path
  --------    ----------    --------- ------     ----
  0/5           16.00KiB     16.00KiB -          <toplevel>
  0/256         16.00KiB     16.00KiB 1/100      subv1
  0/257         16.00KiB     16.00KiB 1/100      snap1
  1/100         32.00KiB     32.00KiB 2/100      2/100<1 member qgroup>
  2/100         16.00KiB     16.00KiB -          <0 member qgroups>
  # Just as you suspected, higher qgroup didn't get updated.

  btrfs subv snap -i 1/100 /mnt/btrfs/subv1 /mnt/btrfs/subv2
  btrfs qgr show -prce /mnt/btrfs/

I'll fix the regular qgroup bug soon.

Thanks,
Qu

>=20
> Fixes: b20fe56cd285 ("btrfs: qgroup: allow quick inherit if snapshot is =
created and added to the same parent")
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/qgroup.c | 3 +++
>   1 file changed, 3 insertions(+)
>=20
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 9e2b53e90dcb..d46f2653510d 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3223,6 +3223,9 @@ static int qgroup_snapshot_quick_inherit(struct bt=
rfs_fs_info *fs_info,
>   	struct btrfs_qgroup_list *list;
>   	int nr_parents =3D 0;
>  =20
> +	if (btrfs_qgroup_mode(fs_info) !=3D BTRFS_QGROUP_MODE_FULL)
> +		return 0;
> +
>   	src =3D find_qgroup_rb(fs_info, srcid);
>   	if (!src)
>   		return -ENOENT;


