Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41CBAD99B2
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2019 21:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436681AbfJPTIQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 15:08:16 -0400
Received: from mail-il1-f182.google.com ([209.85.166.182]:43908 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436679AbfJPTIP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 15:08:15 -0400
Received: by mail-il1-f182.google.com with SMTP id t5so3761299ilh.10
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2019 12:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=roA2P6Uk9LefEELhm2+9HJqtaOEQFVDlGsuqvvAomD8=;
        b=s0AS+2Njgc8b7As2ut06BbayDHHUlLv23XQYaz5EuidK0hHVrNTUz9ogXkCW+Tj7lB
         fXKVElfJM29WECe/s54J/7kYsR4DwjE9afqz7UEgC0co2xVDpBlLn+et0n6I5US9TyCN
         6lOoDg6rlJOP5RNGGl3IplWT6A1oEBndoI66eO9cdvDz8dOWDKVZmfTFa9cb7/gdLmip
         pJDF54lJNp0Wuf2XZfvVUMnfX8kVEjcZhCiJeD7gtg5MFXlg+d+q5GcSoQ7zvevxnm1Q
         222fbED9glWtqmioQDnq5g5ydz/4isNAJUGqKFcL2X27EOwjV23Rt5vNcUyfN3cMdcMd
         NCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=roA2P6Uk9LefEELhm2+9HJqtaOEQFVDlGsuqvvAomD8=;
        b=iFk2qWhA417q2JSMkREPccqNpRsyKPdHfUYfK/w///8DshA3htJzxJP+QzEwcpEOul
         e5Q33ZF0W7RntFf7q+GwyGiNya+/SAaocP1cNe5CuLHxR29AlSRrLMMuhD+U7fS8N0ct
         HMZVJ3kHVbC9nivITnVenMKGB+3i2QHlMsLO1CFwd1Uo73++tzQTtSmMaGMh1AEcaYYA
         ms3o6efuIvxb1AkzddxnX90d7zdkq8myzm1pLPSVghSWX39PQFgs5GJbutTyD5E07aJc
         UpqC65dSTlUKOB8Snj1YmoqZ+zRF3Toh2UCSjqsU7ItL7g3Y304d0D1GjcRYYoJ/8FXG
         iIBg==
X-Gm-Message-State: APjAAAWMkvGDeCAgHu6V19fBRBO9e5LwgHNPJ80jbCWrineEGS8IJpj9
        SVE91oiYw8CzECPYi1hTsbuVWHPmESkT4D597iGBal/IMbY=
X-Google-Smtp-Source: APXvYqxdBNtOhoLftEsi98QN6MwLJFITbORDxLDySFSCQ5PqKMo9TMGdw9apgm8Vn4cUjpAwoTNLbOp/1ubC6h4qsiY=
X-Received: by 2002:a92:2c03:: with SMTP id t3mr13395114ile.271.1571252892203;
 Wed, 16 Oct 2019 12:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191010172011.GA3392@tik.uni-stuttgart.de> <CAMthOuMV7MgB4b87RsijYr9e0UsjMUDNk+QRXeauFdb3cZcTjw@mail.gmail.com>
 <20191011061544.GB3648@tik.uni-stuttgart.de>
In-Reply-To: <20191011061544.GB3648@tik.uni-stuttgart.de>
From:   Kai Krakow <hurikhan77+btrfs@gmail.com>
Date:   Wed, 16 Oct 2019 21:07:45 +0200
Message-ID: <CAMthOuOT4aER7Bnyr8p9+6cThPRBqVVA-3heBNGaUF0JC7yhrQ@mail.gmail.com>
Subject: Re: rsync -ax and subvolumes
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Fr., 11. Okt. 2019 um 08:17 Uhr schrieb Ulli Horlacher
<framstag@rus.uni-stuttgart.de>:
>
> On Thu 2019-10-10 (20:47), Kai Krakow wrote:
>
> > Actually, you could also just bind-mount into /mnt/btrfs, bind-mounts
> > won't inherit other mounts but will still see pure subvolumes.
>
> Next problem:

The other problem first: As already pointed out, there's "sudo", and
for the job you're trying to do, you probably need root permissions
anyway. OTOH, I don't see the problem why you don't just statically
mount subvolid=0 into /mnt/btrfs-pool permanently. Either that way, or
you could use automount. It's easy with systemd:

$ grep btrfs-pool /etc/fstab
LABEL=system /mnt/btrfs-pool btrfs
noauto,compress=zstd,subvolid=0,x-systemd.automount

You could create an intermediate directory in /mnt to allow one
specific user only:

/mnt/for-user/btrfs-pool

Then adjust chown/chmod on /mnt/for-user to limit it to just one user
(or group if you want), that is: remove rwx from the others.

Apparently, with btrfs, the "ro" flag afaik is not per subvolume
mount. But I'm using systemd to limit access to read-only for the
service doing the backup:

$ egrep '^(Read|Privat|Protect)' /etc/systemd/system/system-backup.service
ProtectSystem=strict
PrivateTmp=yes
ReadWriteDirectories=/root
ReadWriteDirectories=/srv/laniakea/backups/jupiter.sol.local.borg
ReadOnlyDirectories=/mnt/btrfs-pool

I'm using borg instead of rsync (because it is much faster and storage
is used much more efficient), so it needs write access to /root. If
you're using rsync, you don't need that. I used rsync a few years back
for the same job, it was just too slow and resource intensive.

Now let's get to your job:

> root@ptm1:~# mount | grep sda
> /dev/sda2 on / type btrfs (rw,relatime,space_cache,subvolid=453,subvol=/@/.snapshots/128/snapshot)
> /dev/sda2 on /.snapshots type btrfs (rw,relatime,space_cache,subvolid=270,subvol=/@/.snapshots)
> /dev/sda2 on /opt type btrfs (rw,relatime,space_cache,subvolid=259,subvol=/@/opt)
> /dev/sda2 on /var/log type btrfs (rw,relatime,space_cache,subvolid=264,subvol=/@/var/log)
> /dev/sda2 on /srv type btrfs (rw,relatime,space_cache,subvolid=260,subvol=/@/srv)
> /dev/sda2 on /var/tmp type btrfs (rw,relatime,space_cache,subvolid=267,subvol=/@/var/tmp)
> /dev/sda2 on /var/spool type btrfs (rw,relatime,space_cache,subvolid=266,subvol=/@/var/spool)
> /dev/sda2 on /usr/local type btrfs (rw,relatime,space_cache,subvolid=262,subvol=/@/usr/local)
> /dev/sda2 on /var/opt type btrfs (rw,relatime,space_cache,subvolid=265,subvol=/@/var/opt)
> /dev/sda2 on /home type btrfs (rw,relatime,space_cache,subvolid=258,subvol=/@/home)
> /dev/sda2 on /var/lib/machines type btrfs (rw,relatime,space_cache,subvolid=1235,subvol=/@/var/lib/machines)
> /dev/sda2 on /tmp type btrfs (rw,relatime,space_cache,subvolid=261,subvol=/@/tmp)
> /dev/sda2 on /var/crash type btrfs (rw,relatime,space_cache,subvolid=263,subvol=/@/var/crash)

Ah, that funny OpenSuSE structure...


> root@ptm1:~# mount -o bind / /mnt/tmp

Bind mounting the "/" mount namespace will exclude all sub mounts, and
OpenSuSE uses a lot. It would work if subvols would be embedded into
the normal FS hierarchy.


> root@ptm1:~# find /opt | wc -l
> 564
>
> root@ptm1:~# find /mnt/tmp/opt | wc -l
> 1

Expected given your mtab.


> I want to copy everything from /dev/sda2 with rsync, but not from other devices.
>
> rsynv -avH  / /mnt/usb # copies also /proc /dev etc
> rsynv -avHx / /mnt/usb # copies ONLY / but not /opt /var/log etc

Try this, pretending you mounted subvolid=0 to /mnt/btrfs-pool:

# NOTE: do not use "-x" here:
rsync -av $(findmnt -nr /dev/sda2 | perl -ne'/subvol=([^,]+)/ && \
  print "/mnt/btrfs-pool$1"') /srv/backups/test-backup/

Or:

# NOTE: you should use "-x" here:
rsync -avx $(findmnt -nr /dev/sda2 | awk '{ print $1 }' \
  /srv/backups/test-backup/

The first example may explode if your mountpoints contain funny
characters (like "," or spaces). I didn't really test, I did just a
quick rsync run.

Both examples may have surprising consequences if source and
destination is the same device. You have been warned. But that's not
really different from how you used it.


> And yes, it must be rsync, because I run this command often, for syncing.

That's not exactly explaining your use-case: I don't see the
correlation between "often" and "rsync", but I guess you mean the
process should be fast because you want to run the command often. But
then again, there's faster software than rsync.


HTH
Kai
