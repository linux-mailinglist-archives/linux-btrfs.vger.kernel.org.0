Return-Path: <linux-btrfs+bounces-194-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B50B7F0FB8
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 11:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4251C21176
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 10:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C0012B6F;
	Mon, 20 Nov 2023 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEFIP7s/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEC18F
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Nov 2023 02:04:11 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so5959957a12.2
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Nov 2023 02:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700474650; x=1701079450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOZWXfNIBSR9UAof2XBOOZDoB4EdIQoDa2kHewO/zDA=;
        b=gEFIP7s/AqQ/9MmUcKvO6wLo4dAqTnQVXm6+eA/lcchQFpE91SM3t7YWFSD22SdEjY
         LFWhUAd/HfD+HdLfQSsulOHrmW+GVM6CLv8qPQfrhIgdv0HF54rbA2rgOU05KrAgEFUZ
         5V9zVCKScwQ2w+5MckVtmxTXE6Z6F3as8+SpxPC1WT1lG6niFQkZ2HmsVJw33RYM++5h
         3wRXMuKoUEo3SplOXSQNIP/sy4jVXUkFMIUWSpU3sMuXbCI+ukqErYjw/fnaVmqWCaqh
         FbwKGQ0qEAdmXWFMvaolWmxiiyWRu70A+K9yfjdy0Kfffaa2xRpl2mpsmkgdk9MYhOjI
         i7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700474650; x=1701079450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOZWXfNIBSR9UAof2XBOOZDoB4EdIQoDa2kHewO/zDA=;
        b=tbMah/ps33ZrXD9XLKHv5nBLgFUtAnUhq4FUsynMDGL3WZZGCp+mAWL+zsOvjTnebu
         2t+gYifsJX4N7nIvFMGYRHvGKlnYgKcZdB0BtAFzPuxcCXdfWMEEchOdlHu7jBKsHW1Z
         K0ghlRWYFSmHYvEV9AO5JCG0mzJ1Y1Wp7/4ovvtzm7kctVj536o1hj3OI5VjPU4vDbxb
         dtZsxd5IxWHm8579aKZtrtNrU2BT+3hUNd6jWh6D/N1LWVbvuuyMazXp6uJDlnhyHz6s
         7YjnjTvwvcT0x3TNSmZ/6sRFiTQY6hMDQNo5E1zdtAilx5q3TzL2U0Yvm4czDr/v5No/
         c9mg==
X-Gm-Message-State: AOJu0Yx9R99C+xeny3bxOc+UsQoM0vvAkoMB66Tm3BUnN43bK14VsCRO
	tU42kEbZiR5pGK/c2IPMu+yeO91ojdrhjHBr8f0=
X-Google-Smtp-Source: AGHT+IFI7y3mbHJsvjpRpS04A64dAPi7N8UWNMQ6A96Oi0wDUS+tJEMgGlK3QgG9uVg+KCvmu8eUxgRhvEVPLpysZog=
X-Received: by 2002:a05:6402:5178:b0:544:a163:f21d with SMTP id
 d24-20020a056402517800b00544a163f21dmr5161370ede.4.1700474649479; Mon, 20 Nov
 2023 02:04:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de> <CAMthOuM8ES2+tX=+mYSjsHs-7v=gH1i_x=9NMJWaD6A4E3=_Hw@mail.gmail.com>
In-Reply-To: <CAMthOuM8ES2+tX=+mYSjsHs-7v=gH1i_x=9NMJWaD6A4E3=_Hw@mail.gmail.com>
From: Kai Krakow <hurikhan77+btrfs@gmail.com>
Date: Mon, 20 Nov 2023 11:03:42 +0100
Message-ID: <CAMthOuN9UZNFMGRsjud4ipy6y7g4MfEramyBdgRzwXoAejNVWA@mail.gmail.com>
Subject: Re: checksum errors but files are readable and no disk errors
To: Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resent due to Gmail silliness with HTML format...

> Hello!
>
> Am Fr., 10. Nov. 2023 um 19:09 Uhr schrieb Johannes Hirte <johannes.hirte=
@datenkhaos.de>:
>>
>> I have a server with two 2T-disks that were running in a Btrfs-RAID1
>> setup. Recently I was running into the bug of btrfs-progs-6.6, so the
>> system didn't boot anymore. Because I don't have physical access to the
>> system, the only option I've had was a hard reset  remotely. After this
>> I noticed several checksum errors during scrub on different files. I was
>> able to delete those files, but the checksum errors persisted, now
>> without any file associated. In the end, I removed one disk (sdb1) from
>> the RAID. Because relocation doesn't work with checksum errors, I've
>> overwritten the first 10M of the partition and mounted the remaining
>> disk (sda1) degraded. After this, I created a new filesystem on sdb1
>> andI synced the whole sda1 to sdb1 via rsync. This worked without any
>> problems, although sda1 still shows the checksum errors. I'm running the
>> system from the second disk now with the newly created filesystem. But
>> now this FS shows checksum errors again. Two files are affected, both
>> are images for virtual servers. I'm able to read both files, I can copy
>> via dd without any error. But scrub says, there are checksum errors:
>>
>> [52622.939071] BTRFS error (device sdb1): unable to fixup (regular)
>> error at logical 1673331802112 on dev /dev/sdb1 physical 1648107257856
>> [52622.939189] BTRFS warning (device sdb1): checksum error at logical
>> 1673331802112 on dev /dev/sdb1, physical 1648107257856, root 1117, inode
>> 832943, offset 566788096, length 4096, links 1 (path:
>> var/lib/libvirt/images/vserv03.img)
>> [54629.309530] BTRFS error (device sdb1): unable to fixup (regular)
>> error at logical 2209355464704 on dev /dev/sdb1 physical 1884523397120
>> [54629.309656] BTRFS warning (device sdb1): checksum error at logical
>> 2209355464704 on dev /dev/sdb1, physical 1884523397120, root 1117, inode
>> 832950, offset 9149956096, length 4096, links 1 (path:
>> var/lib/libvirt/images/vserv06.img)
>> [54629.309666] BTRFS error (device sdb1): unable to fixup (regular)
>> error at logical 2209355464704 on dev /dev/sdb1 physical 1884523397120
>> [54629.309719] BTRFS warning (device sdb1): checksum error at logical
>> 2209355464704 on dev /dev/sdb1, physical 1884523397120, root 1117, inode
>> 832950, offset 9149956096, length 4096, links 1 (path:
>> var/lib/libvirt/images/vserv06.img)
>> [54760.218254] BTRFS info (device sdb1): scrub: finished on devid 1 with
>> status: 0
>>
>> So what is going on here? I'm planning to recreate the RAID1, but with
>> with checksum errors I don't want to go on. System is running kernel
>> 6.5.11.
>
>
> As suggested somewhere in the thread, I would NOT run qemu images with no=
cow. It is slower, it shows csum errors, and it would defeat the purpose of=
 running the images on btrfs raid1.
>
> Instead, migrate the image directory which has the disk images to `chattr=
 +m`, I'd suggest creating a dedicated subvolume for this for better perfor=
mance due to tree lock constraints.
>
> Take note tho, that adding `chattr +m` to existing files won't do anythin=
g but newly created files will inherit the attribute from the parent direct=
ory.
>
> Thus, you should now start converting your qemu disk images to qcow2 form=
at. This has shown the best overall and long-term performance for me while =
other settings (like raw disk, nocow, directio, or combinations) tend to he=
avily performance-degrade over time. I think even with nocow, btrfs won't r=
eplace data in extents in-place, and thus disk images would always heavily =
defragment. qcow2 solves this, and disabling compression on the file tends =
to keep extents bigger and meta data lower which is good for maintaining go=
od performance. You could still compress within qcow2 format (but this usua=
lly only slows things down from my experiments).
>
> Finally, while remounting the new images in your VM settings, ensure that=
 direct io is not used. Cached writeback IO worked best for me and should b=
e safe because the image files are still protected by btrfs cow.
>
> Direct IO is not really compatible with btrfs and should be avoided. Of c=
ourse, not using direct IO means your system needs some cache memory for ru=
nning the VMs but you could probably control this with memory cgroups (whic=
h also account cached pages) if this is a problem.
>
> HTH
> Kai
>

