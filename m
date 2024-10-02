Return-Path: <linux-btrfs+bounces-8432-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AE598DA58
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 16:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D516D1F21743
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431111D014A;
	Wed,  2 Oct 2024 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GN9Rtipd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EFB1D1E94
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878515; cv=none; b=rjjPvw/gbge9aI6CqaFe/Kh8zW3cU3I5cEXp4ezgQTiw0i3w0ZHHWDk5z9lR4HYJ6AOX1Em/Fc5gdvjovfuaHLHoX+RggHIt3LldRboUloNOpX76zL69sNTVRMx2t2rLG1VIuWkbkRpF3k2gfLVkeeonwGPXA/1u1QTBDt2q/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878515; c=relaxed/simple;
	bh=m7k0FdDg+PRZqs1bXmFg3J4NVw1RZ7RCtz5SamL5KkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNOsuQuN5FInVsYJKOFok8m0g/aNsoozalDIH6XRox2zi6lXnZWxBMyxLvq1QhwSSZrY85nh9nMfOa5IoV6wLEGjYCAXmyCAg7139I17dlHSS273GQx6ofYvlI38l0shg+xhB+1MBPjzegM0a2Oso7dbKeO7RJ+jXcdIFkYquiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GN9Rtipd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FECC4CEC2
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 14:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727878515;
	bh=m7k0FdDg+PRZqs1bXmFg3J4NVw1RZ7RCtz5SamL5KkU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GN9RtipdD95vyYLAAGDdRNJirtr1NR97rEGUIKjgLGmqfHY0CxlDMf2zEiJWKHAKW
	 UqerCAWhktpIqKOK09iKvLZ8RFr+/CtSQh29b1RhcfVAMToWvtja/5aHmusdmUK9UJ
	 UHiftSx+r/ZPalu2tYjkLm9WOp/BIfWfREaKCgvD8pcAQS29+4Pahqqma4n1QQ8RSu
	 1SOtLmNSAj0r4GItEg3trb/nXRyvgCQVlj4YUsno44fRX7+YW9UFMYWBZDwSCX22KC
	 5TKM4wfjZ4k2i7ewtPxyqASztQTS3Jyz2aI/IWi2vkdwgRX2kT5mBhcu80l3jrf+Co
	 M8JTDZU95rP9g==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a83562f9be9so138129566b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Oct 2024 07:15:14 -0700 (PDT)
X-Gm-Message-State: AOJu0YwHkZx081QkB/EVyLt4+RRBYEy7z7GKwYjrQSHtStc95LtnaStH
	EJOZ5EdLYcbZtp+0fnErWPBLL19fbER8Jvoxi6zf4Ou5mPsVbr+O1VSm8BShkK7JU3sBJKT6g6k
	jeUcPuHV2DMlS62hmJqQGTNamnlg=
X-Google-Smtp-Source: AGHT+IEqbcsUzyItvOyQg1PvTaPPCpqMI00oYMYfCyYy72gEB/gcTVPiS6lTFXHzHvxMQ88HxJO1DpbneqDXYiS7Mbw=
X-Received: by 2002:a17:907:2d88:b0:a86:83f8:f5a2 with SMTP id
 a640c23a62f3a-a98f823cbc9mr292212466b.19.1727878513468; Wed, 02 Oct 2024
 07:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727222308.git.wqu@suse.com> <3b02eabf87e477dd25e21a4c2cf7720e530d7531.1727222308.git.wqu@suse.com>
In-Reply-To: <3b02eabf87e477dd25e21a4c2cf7720e530d7531.1727222308.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 2 Oct 2024 15:14:36 +0100
X-Gmail-Original-Message-ID: <CAL3q7H50O_LA8vje8JSH+xVM07VA55G286bWtUwfCdpzfVavfQ@mail.gmail.com>
Message-ID: <CAL3q7H50O_LA8vje8JSH+xVM07VA55G286bWtUwfCdpzfVavfQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] btrfs: avoid unnecessary device path update for
 the same device
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>, 
	Fabian Vogt <fvogt@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 1:14=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [PROBLEM]
> It is very common for udev to trigger device scan, and every time a
> mounted btrfs device got re-scan from different soft links, we will get
> some of unnecessary device path updates, this is especially common
> for LVM based storage:
>
>  # lvs
>   scratch1 test -wi-ao---- 10.00g
>   scratch2 test -wi-a----- 10.00g
>   scratch3 test -wi-a----- 10.00g
>   scratch4 test -wi-a----- 10.00g
>   scratch5 test -wi-a----- 10.00g
>   test     test -wi-a----- 10.00g
>
>  # mkfs.btrfs -f /dev/test/scratch1
>  # mount /dev/test/scratch1 /mnt/btrfs
>  # dmesg -c
>  [  205.705234] BTRFS: device fsid 7be2602f-9e35-4ecf-a6ff-9e91d2c182c9 d=
evid 1 transid 6 /dev/mapper/test-scratch1 (253:4) scanned by mount (1154)
>  [  205.710864] BTRFS info (device dm-4): first mount of filesystem 7be26=
02f-9e35-4ecf-a6ff-9e91d2c182c9
>  [  205.711923] BTRFS info (device dm-4): using crc32c (crc32c-intel) che=
cksum algorithm
>  [  205.713856] BTRFS info (device dm-4): using free-space-tree
>  [  205.722324] BTRFS info (device dm-4): checking UUID tree
>
> So far so good, but even if we just touched any soft link of
> "dm-4", we will get quite some unnecessary device path updates.
>
>  # touch /dev/mapper/test-scratch1
>  # dmesg -c
>  [  469.295796] BTRFS info: devid 1 device path /dev/mapper/test-scratch1=
 changed to /dev/dm-4 scanned by (udev-worker) (1221)
>  [  469.300494] BTRFS info: devid 1 device path /dev/dm-4 changed to /dev=
/mapper/test-scratch1 scanned by (udev-worker) (1221)
>
> Such device path rename is unnecessary and can lead to random path
> change due to the udev race.
>
> [CAUSE]
> Inside device_list_add(), we are using a very primitive way checking if
> the device has changed, strcmp().
>
> Which can never handle links well, no matter if it's hard or soft links.
>
> So every different link of the same device will be treated as a different
> device, causing the unnecessary device path update.
>
> [FIX]
> Introduce a helper, is_same_device(), and use path_equal() to properly
> detect the same block device.
> So that the different soft links won't trigger the rename race.
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1230641
> Reported-by: Fabian Vogt <fvogt@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/volumes.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 995b0647f538..b713e4ebb362 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -732,6 +732,32 @@ const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super=
_block *sb)
>         return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
>  }
>
> +static bool is_same_device(struct btrfs_device *device, const char *new_=
path)
> +{
> +       struct path old =3D { .mnt =3D NULL, .dentry =3D NULL };
> +       struct path new =3D { .mnt =3D NULL, .dentry =3D NULL };
> +       char *old_path;
> +       bool is_same =3D false;
> +       int ret;
> +
> +       if (!device->name)
> +               goto out;
> +
> +       old_path =3D rcu_str_deref(device->name);

There's a missing rcu_read_lock / unlock btw. It's triggering warnings
in the test vms.

Thanks.

> +       ret =3D kern_path(old_path, LOOKUP_FOLLOW, &old);
> +       if (ret)
> +               goto out;
> +       ret =3D kern_path(new_path, LOOKUP_FOLLOW, &new);
> +       if (ret)
> +               goto out;
> +       if (path_equal(&old, &new))
> +               is_same =3D true;
> +out:
> +       path_put(&old);
> +       path_put(&new);
> +       return is_same;
> +}
> +
>  /*
>   * Add new device to list of registered devices
>   *
> @@ -852,7 +878,7 @@ static noinline struct btrfs_device *device_list_add(=
const char *path,
>                                 MAJOR(path_devt), MINOR(path_devt),
>                                 current->comm, task_pid_nr(current));
>
> -       } else if (!device->name || strcmp(device->name->str, path)) {
> +       } else if (!device->name || !is_same_device(device, path)) {
>                 /*
>                  * When FS is already mounted.
>                  * 1. If you are here and if the device->name is NULL tha=
t
> --
> 2.46.1
>
>

