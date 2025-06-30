Return-Path: <linux-btrfs+bounces-15122-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C56AEE55C
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 19:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41FE13BF845
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 17:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434A5293B72;
	Mon, 30 Jun 2025 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuNY/PuQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2977293B5F
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303244; cv=none; b=K8hNQn1FaYRZjyDeJ+Fi0MmR6OOS1WPxwNmmZ2X2F9Sm7Y2BU0C9kZvix3ZLnCJHplbHPCpIV2HQeoy3b2qG7FZN7g+zRuK4ETBHcsNpMB0lGw+MfGJlImKml7qKcPPP4fdLarvFBcDNBmMKf2/dgBAbuEDrWZ6USBdFBPNqfuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303244; c=relaxed/simple;
	bh=A8QuwjVnwvHe9fQq4JvPXhwZuOxVqlpt+rBtzCbpfgo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=W63irWBuToweFZoeB6rGVMGsY9SZyyvu3ik4rrnFA8F1qM76RG9rcUb97k0Dy/iES0Q4AnbonLrSTapaIZg3hltYCIVARdTLglcIi189FyeTL5H6JkbgMAIuZUKtu1X+dfEgn0Gm+UkbHf5xaqkGr4hARI83NXWjzkCuBX18kyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuNY/PuQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-73c17c770a7so3056369b3a.2
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751303242; x=1751908042; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmLyXLCa6eMeA6QcktRdiOop2QKMbq6LvhQW/p0y9Bo=;
        b=QuNY/PuQzMKQbNlpjMVvF1suPlpvAhKY2qw4JbD9Tp3nUFzANxyoh4v13DPT+SmYor
         gVXitpraPuXorFeaqvyIqwpjN45cF6EvQbnlLAvgWrPddmNcfXlRpmRYio7jvG3bgYiL
         /RD3+KLMSGW0Vqt0n1dOHLbK//3ul9hCHYq8OwKPp0QP8zWZVEldZDxbgGOe12ZGXAU/
         9OKWGU6Mk4nEIq7t1H6cQtOVDr2ID78KFadmI9npE+iTX1a8ul3thixKI5m4cUESiUa7
         D3u0RczO3JyOU3jKXKfOEagVVHhPQTX1ZhRfc83RqUJoI4SjAUJbg2CS/IMRpANV/Ojc
         9JRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303242; x=1751908042;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmLyXLCa6eMeA6QcktRdiOop2QKMbq6LvhQW/p0y9Bo=;
        b=H5G7KiQXgIBu0gZzoGGdbwIgFU56bplbFmpIslj7DMdBYy8b1u/T74dM1VT0xwthpB
         kPDP3Wz0S1GVvMhjsIcFFUSQdS+jG4ahaAPhhmaD4H+2HmB90mVxoHBaDm3LqHWKXzBK
         S6y6yXJ3Z7GSLY2y2iB5scFkHoqzD20Iz1wYTbKp/RipdWv1v33//BYNsVu4/+o+FAS+
         i8FazXg2AOsFgtc4z/RlSbQxrAkKlHAlS0aN1QzI+YjVcMcxdAilnO7KukERwWru79mI
         kY0paTicuni9yxFlDSnmaFB3Ul0PlkjVVosHCLaNZ4a+gPVvZ0Xsxt16+EEksuQYKXyg
         rmEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMyub/8J7XsrBLCgwOlzzOoLukwu+AOQOv5woBtSCsboYWNZ8l2gHWXHb+RoujJe4q+5lsfyYxeGukWA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxrg7a0KJqO8mZ7mM4tkTEXvbcIWeUr2cVlOAVCPYGKAvioz7C
	ZnW+4c0P2GVphp3+uB2/LWHm2NUwAofok7MbS6kCEDpBh+S29tkHJYROPglDPc18
X-Gm-Gg: ASbGncvCoduc7QAd3cVck+ELUCn2Su96leMmmHsBZefj9473ZCE4oof1lXhKW5Y6NJx
	IoxuxFcAKnTaR39EqgCF+S4tblp8cym83v1vbwbacYzHgXLiC266uytsJ4vfvnQCOUFFhVo/PfM
	hz+1wTJCwVJPxTzB9w+WBXzKNjrIRdTtSjeuOp+49IZyYQqMp6179y5eiwPVztSlKH57vN0YxFx
	prbtUA3fFl+l7QF8VL+qO90kmm288LT2r0UiTcgNbh3zvS4ol+IPILFeSdWlu+RjKG4LXgf/Cgz
	EvfbB7Cim3es38nJeWDYErSYUPgYR+jAFtXNE7AyxaLRDQ==
X-Google-Smtp-Source: AGHT+IG8KyG6auY0yzEqPd87FIcZQcrArwCkOVUBl6Txkgtbn8SPkycgx6cOQEu83gx7lh4B1bQT7g==
X-Received: by 2002:a05:6a00:138e:b0:748:f135:4fe6 with SMTP id d2e1a72fcca58-74af6e66678mr19020502b3a.10.1751303242089;
        Mon, 30 Jun 2025 10:07:22 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31da5f2sm8482362a12.58.2025.06.30.10.07.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jun 2025 10:07:21 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH v2 1/2] btrfs: open code RCU for device name
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <20250630164328.GL31241@twin.jikos.cz>
Date: Tue, 1 Jul 2025 01:07:06 +0800
Cc: Wang Yugui <wangyugui@e16-tech.com>,
 David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5D89E5E9-6F7B-432F-89F4-4632A51511EC@gmail.com>
References: <cover.1750858539.git.dsterba@suse.com>
 <1e539dfd73debc86ddc7c1b1716f86ace14d51aa.1750858539.git.dsterba@suse.com>
 <20250630102457.BFB9.409509F4@e16-tech.com>
 <20250630162130.GK31241@twin.jikos.cz> <20250630164328.GL31241@twin.jikos.cz>
To: dsterba@suse.cz
X-Mailer: Apple Mail (2.3826.500.181.1.5)

On Jul 1, 2025, at 00:43, David Sterba <dsterba@suse.cz> wrote:
>=20
> On Mon, Jun 30, 2025 at 06:21:30PM +0200, David Sterba wrote:
>> On Mon, Jun 30, 2025 at 10:24:57AM +0800, Wang Yugui wrote:
>>> Hi,
>>>=20
>>>> The RCU protected string is only used for a device name, and RCU is =
used
>>>> so we can print the name and eventually synchronize against the =
rare
>>>> device rename in device_list_add().
>>>>=20
>>>> We don't need the whole API just for that. Open code all the =
helpers and
>>>> access to the string itself.
>>>>=20
>>>> Notable change is in device_list_add() when the device name is =
changed,
>>>> which is the only place that can actually happen at the same time =
as
>>>> message prints using the device name under RCU read lock.
>>>>=20
>>>> Previously there was kfree_rcu() which used the embedded rcu_head =
to
>>>> delay freeing the object depending on the RCU mechanism. Now =
there's
>>>> kfree_rcu_mightsleep() which does not need the rcu_head and waits =
for
>>>> the grace period.
>>>>=20
>>>> Sleeping is safe in this context and as this is a rare event it =
won't
>>>> interfere with the rest as it's holding the device_list_mutex.
>>>>=20
>>>> Straightforward changes:
>>>>=20
>>>> - rcu_string_strdup -> kstrdup
>>>> - rcu_str_deref -> rcu_dereference
>>>> - drop ->str from safe contexts
>>>>=20
>>>> Historical notes:
>>>>=20
>>>> Introduced in 606686eeac45 ("Btrfs: use rcu to protect =
device->name")
>>>> with a vague reference of the potential problem described in
>>>> =
https://lore.kernel.org/all/20120531155304.GF11775@ZenIV.linux.org.uk/ .
>>>>=20
>>>> The RCU protection looks like the easiest and most lightweight way =
of
>>>> protecting the rare event of device rename racing device_list_add()
>>>> with a random printk() that uses the device name.
>>>>=20
>>>> Alternatives: a spin lock would require to protect the printk
>>>> anyway, a fixed buffer for the name would be eventually wrong in =
case
>>>> the new name is overwritten when being printed, an array switching
>>>> pointers and cleaning them up eventually resembles RCU too much.
>>>>=20
>>>> The cleanups up to this patch should hide special case of RCU to =
the
>>>> minimum that only the name needs rcu_dereference(), which can be =
further
>>>> cleaned up to use btrfs_dev_name().
>>>>=20
>>>=20
>>> There is still rcu warning when 'make  W=3D1 C=3D1'
>>>=20
>>> /usr/hpc-bio/linux-6.12.35/fs/btrfs/volumes.c:405:21: warning: =
incorrect type in argument 1 (different address spaces)
>>> /usr/hpc-bio/linux-6.12.35/fs/btrfs/volumes.c:405:21:    expected =
void const *objp
>>> /usr/hpc-bio/linux-6.12.35/fs/btrfs/volumes.c:405:21:    got char =
const [noderef] __rcu *name
>>>=20
>>> static void btrfs_free_device(struct btrfs_device *device)
>>> {
>>>    WARN_ON(!list_empty(&device->post_commit_list));
>>>    /* No need to call kfree_rcu(), nothing is reading the device =
name. */
>>> L405:    kfree(device->name);
>>>=20
>>> do we need rcu_dereference here?
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -402,7 +402,7 @@ static void btrfs_free_device(struct =
btrfs_device *device)
>>> {
>>>        WARN_ON(!list_empty(&device->post_commit_list));
>>>        /* No need to call kfree_rcu(), nothing is reading the device =
name. */
>>> -       kfree(device->name);
>>> +       kfree(rcu_dereference(device->name));
>>=20
>> I got notified by the build bots (not CCed to the mailinglis) about
>> this. The dereference is not needed, the comment says why. The =
checkers
>> do not distinguish the context, some of them are safe like when the
>> device is being set up and not yet accessible by other processes, and =
at
>> deletion time, like here.
>>=20
>> As we want to keep the __rcu annotation the rcu dereference is the
>> easiest workaround.
>=20
> I can't seem to reproduce the warning with the command, I'm going to =
apply this
> fixup:
>=20
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -402,9 +402,17 @@ static struct btrfs_fs_devices =
*alloc_fs_devices(const u8 *fsid)
>=20
> static void btrfs_free_device(struct btrfs_device *device)
> {
> +       const char *name;
> +
>        WARN_ON(!list_empty(&device->post_commit_list));
> -       /* No need to call kfree_rcu(), nothing is reading the device =
name. */
> -       kfree(device->name);
> +       /*
> +        * No need to call kfree_rcu() or do RCU lock/unlock, nothing =
is
> +        * reading the device name but the checkers complain.
> +        */
> +       rcu_read_lock();
> +       name =3D rcu_dereference(device->name);

Since it=E2=80=99s safe here, can we use rcu_dereference_raw without  =
rcu_read_lock() ?

> +       rcu_read_unlock();
> +       kfree(name);
>        btrfs_extent_io_tree_release(&device->alloc_state);
>        btrfs_destroy_dev_zone_info(device);
>        kfree(device);
>=20


