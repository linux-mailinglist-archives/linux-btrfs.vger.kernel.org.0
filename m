Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7C0A7EBE
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 11:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfIDJDX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 05:03:23 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:34922 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfIDJDX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 05:03:23 -0400
Received: by mail-ot1-f43.google.com with SMTP id 100so19900838otn.2
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2019 02:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PLHGmyHqFkzdOkZTmXwhEFcqiFZwwzZ6b7SLngTltRs=;
        b=N51nkzo04i2MlwZ5n57LyN+9a1x+gpgLrmE9esQ2t2b9pwhVwPar5XVmeVZc8hScQ/
         iqgwTKwDKLER76hzEdFFXfzjgpuccQIAzQVPyZgnzFnKQ64ES564F6sunvYcar0+Sqhg
         Z14Y7zV5Ll6P1juPUDQNy7XoAc8ACzKUo3KnZU4VleD6C9z/UwbkqmfC31qb34mkD9Qu
         CGBaiN7d+sACBXNLXJo8PuLyBWcrzrwEZrfZmazTTY6rkFjJSfIhDepZSE3SopWdIxTH
         CZU1xGeCIJragmuBWnV8IB+sahCJZdkLV1FWRoC61MisfvLKpVeHxCgAyH+dSifulJOo
         lfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PLHGmyHqFkzdOkZTmXwhEFcqiFZwwzZ6b7SLngTltRs=;
        b=BQ9hE694VCre/M52+g7+0ve1N/ZwppVSHnOuh3EPf4J8AQ5vcxUtOzXpmid5Y+jxZ0
         1worobt6SEIIrevF6+DS/8dAoWXI/NTTGwOQYKOTdI3bXMTzALFwdUJL3lNt5EvAKlC8
         f76+hAzSjdAF7sLSd1xaNLGq3tisJEW5YBEEx+0dv8rcakD95YMB3j+mvYlbhsuiomSu
         JH3rxy+j+xOIPHGmCOsvzrFWbhYvyz8TIYuG9pUYVi9wOcXfr6q27J+vFnc6Q+Fepgm6
         C8O4EWcC4K9FcT4h9yTTQFW6NN106mV1U4G0VaMBT0C6b31Oz+8dCBWd+g60XiDFpTa4
         FASA==
X-Gm-Message-State: APjAAAU5GQz1I2mdaT5PH2E92iNSLQY4dnoVjBeF5ee9Ostffeo2Rj2W
        UOm02rwg7X5g/pbN0BtRed0kovp3GCGeSL+ToTxkoEqU
X-Google-Smtp-Source: APXvYqytTOaj0HQ0WrphE07RL2cQlBNCZuCGzmJF/rR/CJbH3i2V3V+ZoFqpEhwkT7b1gz+U2P4loCeL86nXfIDx44E=
X-Received: by 2002:a9d:4d0e:: with SMTP id n14mr7421821otf.285.1567587802331;
 Wed, 04 Sep 2019 02:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <7d044ff7-1381-91c8-2491-944df8315305@petaramesh.org>
In-Reply-To: <7d044ff7-1381-91c8-2491-944df8315305@petaramesh.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Date:   Wed, 4 Sep 2019 12:03:10 +0300
Message-ID: <CAA91j0VLnOB1pZAbi-Gr2sNUJMj56LbBU7=NLYGfrPs7T_GpNA@mail.gmail.com>
Subject: Re: Cloning / getting a full backup of a BTRFS filesystem
To:     =?UTF-8?Q?Sw=C3=A2mi_Petaramesh?= <swami@petaramesh.org>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Michel Bouissou <michel@bouissou.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 4, 2019 at 9:16 AM Sw=C3=A2mi Petaramesh <swami@petaramesh.org>=
 wrote:
>
> Hi list,
>
> Is there an advised way to completely =E2=80=9Cclone=E2=80=9D a complete =
BTRFS
> filesystem, I mean to get an exact copy of a BTRFS filesystem including
> subvolumes (even readonly snapshots) and complete file attributes
> including extended attributes, ACLs and so, to another storage pool,
> possibly defined with a different RAID geometry or compression ?
>

As long as you do not use top level subvolume directly (all data is
located in subolumes), send/receive should work.

> The question boils down to getting an exact backup replica of a given
> BTRFS filesystem that could be restored to something logically
> absolutely identical.
>
> The usual backup tools have no clue about share extents, snapshots and
> the like, and using btrfs send/receive for individual subvols is a real
> pain in a BTRFS filesystem that may contain hundreds of snapshots of
> different BTRFS subvols plus deduplication etc.
>

Shared extents could be challenging. You can provide this information
to "btrfs send", but for one, there is no direct visibility into which
subvolumes share extents with given subvolume, so no way to build
corresponding list for "btrfs send". I do not even know if this
information can be obtained without exhaustive search over all
extents. Second, btrfs send/receive only allows sharing of full
extents which means there is no guarantee of identical structure on
receiving side.

> So on a practical standpoint, how can one backup and restore a full
> BTRFS structure ?
>
> (I know of tools like partclone that may or may not do the job as they
> usually lack behind recent BTRFS features, and may not be able to clone
> BTRFS RAID setups for example...)
>
> TIA.
>
> =E0=A5=90
>
> --
> Sw=C3=A2mi Petaramesh <swami@petaramesh.org> PGP 9076E32E
