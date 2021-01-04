Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C302E9D51
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jan 2021 19:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbhADSpl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jan 2021 13:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbhADSpk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jan 2021 13:45:40 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532DCC061793
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jan 2021 10:45:00 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c133so179274wme.4
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Jan 2021 10:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jfhl2ar7VrCyhA0bFR6nNYBhbjQ+TQJDuRi4G4O+Otw=;
        b=JHw6D1P0MDvpk7TKogMJYYLziXJtQUrzAAQuMd8oy8AKK2McNdBwHmqU0ENIU+++E0
         oAft9+T8v8uSeosCae0QrTadMVRSU+UrpJdD6ccP3d0foE67FcaVuFizGxPHdfjf3zjg
         82h8cb6Ql77h+H3OKp5kDUEJOmsSltpcG6AfFyssa4RnyBLB3KKqljiezxWalZS3dWwV
         8VSPbEZPE5qmK6KYB6dwO/P59gTMonNhrX4+m6KSb4TbZhf2nB3SyrGv7soqKkScNefu
         Ilxp/aJaEUYYfx9RYnATkbpLWZTjdLzVsnxPkPiEe159eBWOooGIedR7axO1qz4daHsw
         kxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jfhl2ar7VrCyhA0bFR6nNYBhbjQ+TQJDuRi4G4O+Otw=;
        b=ipCrkIHiTV0is2FVHALZvSf0jLenLoTkWftQ9B514wAMbR0Wa4ZJlUBzP5P7/cgJCu
         5SeZSbZs3642NeNXHP5ZpO+R+MZ6dLEMUC/rG6kDxcnsXmma3yRiLlPegM60Jy8uekFV
         2NJwsRjjhnHE9HYlfsUiVLLdqz35DDkUHwNMN9B9vSUZ25gKfU8su7gL+aCl6dUNzapy
         5sJbEKYDbI4dK1kstHkAn3ajozRRF6nmpQ/5ogUW0eOUR8vkQ1xqWjN+0uQXzrnBQSvC
         /uQB8MBtzpezySkvsxLA3KEzZfTery4UpyyOwmiq0tTajsjiR7h0CaiwVdko0yiJpPTS
         Xtqw==
X-Gm-Message-State: AOAM532HgDWJLdIqmrhgRlNtUF68jyubG9CqWazKEt7TBtN1k0O6ltBv
        C8ttXVBfm+wubg/hz44cBy3PP4sfC2VuVWIWNXjqKg==
X-Google-Smtp-Source: ABdhPJwpQxGwGPrjH2ZSFL8x0FKsCllmEJxwIfZ0lVhfnMO7gv1XOREfKfBcd+N4MehMksfaOpK9xi6BXPwL9Ym/TOI=
X-Received: by 2002:a1c:9692:: with SMTP id y140mr230571wmd.128.1609785899115;
 Mon, 04 Jan 2021 10:44:59 -0800 (PST)
MIME-Version: 1.0
References: <1bdca54c9a0c575288f2c509246e5a96@tecnico.ulisboa.pt>
 <CAJCQCtTMmU5oWbvY0vOpWgiS6UvH2ZrrLhnaDivC4o2FnbBvag@mail.gmail.com>
 <b694928becd337a5f57e6f459e5774d8@tecnico.ulisboa.pt> <CAJCQCtTm_zdyn7mXOgT6adaRgCU2-42hdSeADkh2T+dXo4nbag@mail.gmail.com>
 <9c5093af29f2a1918829cfbdebec1103@tecnico.ulisboa.pt>
In-Reply-To: <9c5093af29f2a1918829cfbdebec1103@tecnico.ulisboa.pt>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 4 Jan 2021 11:44:43 -0700
Message-ID: <CAJCQCtSUgXmfe+XoXA+gnaZaTwn5NQ-9rr2yy-Zc5ntTQnYQRA@mail.gmail.com>
Subject: Re: tldr; no BTRFS on dev, after a forced shutdown, help
To:     =?UTF-8?Q?Andr=C3=A9_Isidro_da_Silva?= 
        <andreisilva@tecnico.ulisboa.pt>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 4, 2021 at 11:09 AM Andr=C3=A9 Isidro da Silva
<andreisilva@tecnico.ulisboa.pt> wrote:
>
> I'm sure it used to be one, but indeed it seems that a TYPE is missing
> in /dev/sda10; gparted says it's unknown.
> It seems there is no trace of the fs. I'm trying to recall any other
> operations I might have done, but if it was something else I can't
> remember what could have been. I used cfdisk, to resize another
> partition, also tried to do a 'btrfs device add' with this missing one
> (to solve the no space left in another one), otherwise it was mount /,
> mount /home (/dev/sda10), umount, repeat. Oh well.
>
> [sudo blkid]
>
> /dev/sda1: UUID=3D"03ff3132-dfc5-4dce-8add-cf5a6c854313" BLOCK_SIZE=3D"40=
96"
> TYPE=3D"ext4" PARTLABEL=3D"LINUX"
> PARTUUID=3D"a6042b9f-a3fe-49e2-8dc5-98a818454b6d"
>
> /dev/sdb4: UUID=3D"5c7201df-ff3e-4cb7-8691-8ef0c6c806ed"
> UUID_SUB=3D"bb677c3a-6270-420f-94ce-f5b89f2c40d2" BLOCK_SIZE=3D"4096"
> TYPE=3D"btrfs" PARTUUID=3D"be4190e4-8e09-4dfc-a901-463f3e162727"
>
> /dev/sda10: PARTLABEL=3D"HOME"
> PARTUUID=3D"6045f3f0-47a7-4b38-a392-7bebb7f654bd"
>
> [sudo btrfs insp dump-s -F /dev/sda10]
>
> superblock: bytenr=3D65536, device=3D/dev/sda10
> ---------------------------------------------------------
> csum_type               0 (crc32c)
> csum_size               4
> csum                    0x00000000 [DON'T MATCH]
> bytenr                  0
> flags                   0x0
> magic                   ........ [DON'T MATCH]
> fsid                    00000000-0000-0000-0000-000000000000
> metadata_uuid           00000000-0000-0000-0000-000000000000
> label
> generation              0
> root                    0
> sys_array_size          0
> chunk_root_generation   0
> root_level              0
> chunk_root              0
> chunk_root_level        0
> log_root                0
> log_root_transid        0
> log_root_level          0
> total_bytes             0
> bytes_used              0
> sectorsize              0
> nodesize                0
> leafsize (deprecated)   0
> stripesize              0
> root_dir                0
> num_devices             0
> compat_flags            0x0
> compat_ro_flags         0x0
> incompat_flags          0x0
> cache_generation        0
> uuid_tree_generation    0
> dev_item.uuid           00000000-0000-0000-0000-000000000000
> dev_item.fsid           00000000-0000-0000-0000-000000000000 [match]
> dev_item.type           0
> dev_item.total_bytes    0
> dev_item.bytes_used     0
> dev_item.io_align       0
> dev_item.io_width       0
> dev_item.sector_size    0
> dev_item.devid          0
> dev_item.dev_group      0
> dev_item.seek_speed     0
> dev_item.bandwidth      0
> dev_item.generation     0
>
> This as nothing to do with btrfs anymore, but: do you think a tool like
> foremost can recover the files, it'll be a mess, but better then nothing
> and I've used it before in a ntfs.

No idea.

You could scan the entire drive for the Btrfs magic, which is inside
the superblock. It will self identify its offset, the first superblock
is the one you want, which is offset 65536 (64KiB) from the start of
the block device/partition. And that superblock also says the device
size.



--=20
Chris Murphy
