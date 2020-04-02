Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5ECC19BFEA
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 13:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388028AbgDBLKr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 07:10:47 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43587 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388009AbgDBLKq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Apr 2020 07:10:46 -0400
Received: by mail-ua1-f66.google.com with SMTP id g24so997219uan.10
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Apr 2020 04:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=5nEInFvz8zmqBRfoyBzP4O7wH6Iwc4xIMTJMbYHYexM=;
        b=UjjqWSGXIHzbr5UKsXbfRf9+ftMdN1KRdnaWnSG61iKo6tH3MS/7VNZUByLuyT85Of
         lMmdQOFCpIre0Gp3tRlV/rjlXXrakLOYk6zH/Z8HGExyXdLxBWS9JjSUlt+J3IJuYmyr
         Lvi1RtElAYyI2cUJWoMQfhelqAcNmTlCt7UjJqzGBnXFZ9GHHVZrLbzkPV+kJcvtWinn
         BKjo5kjj0ml29Vir50m+QrVb3tYwkBzN2DfVBHBrdgZ2C92LLiqs/+Gfy+GoA0GNENoh
         LL4dIlxip2cCZz+xFmNbniWYVBRc36/ePrzvVPSfJ9+LaIuwqgymF4BZxcWv28wjLJ9m
         FAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=5nEInFvz8zmqBRfoyBzP4O7wH6Iwc4xIMTJMbYHYexM=;
        b=fAaqIAYlFF7GRUoLfJq2cgkwuSQYCfc7+fH+ftpHTaNiSx+8I2voZQToXGWBh6cLZW
         HmlVtRbLvyiWmFcB/2w/mMk9Nen9bYQUcILYlkax7C4zJGACs0c8iSyOHKJaLOpVmExZ
         YUlkpE9RYO37spUjge/e9x3CmWl8k4fllu3+gCLjbducnQmLrPLh4uoBcwy4PdP6gpTB
         tXJYqRSSJxmF2jdq5qa5ZefT04YyWr/YyKWVFr9kz4B3IKv+ZmPtFMvUioZ7ex49jQp2
         awxR5vkezvDR6bGQLH/feDjVMvOGTlBWgSqGaVkqlhf2Nr+VUQLCUf4JuOKRUZRqnbuI
         HMqA==
X-Gm-Message-State: AGi0Puaduh7pT3z1eqvnSktWHuxShrzC7lPV0YYl1w06hUKilZJUWbQU
        v/MIHRMGBfy5pX6OeIzSVO7R8r00Q7k5sURgJI9MLZh+
X-Google-Smtp-Source: APiQypIulNUkRrMejES9EUp7URN4n6xLMIa31Bj5adCaKp1TV/OFqT4pJrhbCsisfdlf3OtRbiiVxLnWgTHQPH7B9WA=
X-Received: by 2002:ab0:e5:: with SMTP id 92mr2007327uaj.83.1585825844994;
 Thu, 02 Apr 2020 04:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191119040827.GC22121@hungrycats.org>
In-Reply-To: <20191119040827.GC22121@hungrycats.org>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 2 Apr 2020 12:10:33 +0100
Message-ID: <CAL3q7H5PLnheO7zE=3PMRz=KwXXqpmS7rR51o+PftLLH9mAPrw@mail.gmail.com>
Subject: Re: RAID5 fails to correct correctable errors, makes them
 uncorrectable instead (sometimes). With reproducer for kernel 5.3.11
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 19, 2019 at 4:09 AM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> Sometimes, btrfs raid5 not only fails to recover corrupt data with a
> parity stripe, it also copies bad data over good data.  This propagates
> errors between drives and makes a correctable failure uncorrectable.
> Reproducer script at the end.
>
> This doesn't happen very often.  The repro script corrupts *every*
> data block on one of the RAID5 drives, and only a handful of blocks
> fail to be corrected--about 16 errors per 3GB of data, but sometimes
> half or double that rate.  It behaves more like a race condition than
> a boundary condition.  It can take a few tries to get a failure with a
> 16GB disk array.  It seems to happen more often on 2-disk raid5 than
> 5-disk raid5, but if you repeat the test enough times even a 5-disk
> raid5 will eventually fail.
>
> Kernels 4.16..5.3 all seem to behave similarly, so this is not a new bug.
> I haven't tried this reproducer on kernels earlier than 4.16 due to
> other raid5 issues in earlier kernels.
>
> I found 16 corrupted files after one test with 3GB of data (multiple
> copies of /usr on a Debian vm).  I dumped out the files with 'btrfs
> restore'.  These are the differences between the restored files and the
> original data:
>
>         # find -type f -print | while read x; do ls -l "$x"; cmp -l /tmp/=
restored/"$x" /usr/"${x#*/*/}"; done
>         -rw-r--r-- 1 root root 4179 Nov 18 20:47 ./1574119549/share/perl/=
5.24.1/Archive/Tar/Constant.pm
>         2532 253 147
>         -rw-r--r-- 1 root root 18725 Nov 18 20:47 ./1574119549/share/perl=
/5.24.1/Archive/Tar/File.pm
>          2481  20 145
>          6481 270 145
>          8876   3 150
>         13137 232  75
>         16805 103  55
>         -rw-r--r-- 1 root root 3421 Nov 18 20:47 ./1574119549/share/perl/=
5.24.1/App/Prove/State/Result/Test.pm
>         2064   0 157
>         -rw-r--r-- 1 root root 4948 Nov 18 20:47 ./1574119549/share/perl/=
5.24.1/App/Prove/State/Result.pm
>         2262 226 145
>         -rw-r--r-- 1 root root 11692 Nov 18 20:47 ./1574119549/share/perl=
/5.24.1/App/Prove/State.pm
>          7115 361 164
>          8333 330  12
>         -rw-r--r-- 1 root root 316211 Nov 18 20:47 ./1574119549/share/per=
l/5.24.1/perl5db.pl
>         263868  35  40
>         268307 143  40
>         272168 370 154
>         275138  25 145
>         280076 125  40
>         282683 310 136
>         286949 132  44
>         293453 176 163
>         296803  40  52
>         300719 307  40
>         305953  77 174
>         310419 124 161
>         312922  47  40
>         -rw-r--r-- 1 root root 11113 Nov 18 20:47 ./1574119549/share/perl=
/5.24.1/B/Debug.pm
>           787 323 102
>          6775 372 141
>         -rw-r--r-- 1 root root 2346 Nov 18 20:47 ./1574119549/share/man/m=
an1/getconf.1.gz
>          484 262  41
>         -rw-r--r-- 1 root root 3296 Nov 18 20:47 ./1574119549/share/man/m=
an1/genrsa.1ssl.gz
>         2777 247 164
>         -rw-r--r-- 1 root root 4815 Nov 18 20:47 ./1574119549/share/man/m=
an1/genpkey.1ssl.gz
>         3128  22   6
>         -rw-r--r-- 1 root root 6558 Nov 18 20:47 ./1574119553/share/perl/=
5.24.1/ExtUtils/MM_NW5.pm
>         3378 253 146
>         6224 162  42
>         -rw-r--r-- 1 root root 75950 Nov 18 20:47 ./1574119553/share/perl=
/5.24.1/ExtUtils/MM_Any.pm
>         68112   2 111
>         73226 344 150
>         75622  12  40
>         -rw-r--r-- 1 root root 3873 Nov 18 20:47 ./1574119553/share/perl/=
5.24.1/ExtUtils/MM_OS2.pm
>         1859 247  40
>         -rw-r--r-- 1 root root 86458 Nov 18 20:47 ./1574119553/share/loca=
le/zh_CN/LC_MESSAGES/gnupg2.mo
>         66721 200 346
>         72692 211 270
>         74596 336 101
>         79179 257   0
>         85438 104 256
>         -rw-r--r-- 1 root root 2528 Nov 18 20:47 ./1574119553/share/man/m=
an1/getent.1.gz
>         1722 243 356
>         -rw-r--r-- 1 root root 2346 Nov 18 20:47 ./1574119553/share/man/m=
an1/getconf.1.gz
>         1062 212 267
>
> Note that the reproducer script will corrupt exactly one random byte per
> 4K block to guarantee the corruption is detected by the crc32c algorithm.
> In all cases the corrupted data is one byte per 4K block, as expected.
>
> I dumped out the files by reading the blocks directly from the file
> system.  Data and parity blocks from btrfs were identical and matched the
> corrupted data from btrfs restore.  This is interesting because the repro
> script only corrupts one drive!  The only way blocks on both drives end
> up corrupted identically (or at all) is if btrfs copies the bad data
> over the good.
>
> There is also some spatial clustering of the unrecoverable blocks.
> Here are the physical block addresses (in hex to make mod-4K and mod-64K
> easier to see):
>
>         Extent bytenr start..end   Filename
>         0xcc160000..0xcc176000 1574119553/share/locale/zh_CN/LC_MESSAGES/=
gnupg2.mo
>         0xcd0f0000..0xcd0f2000 1574119549/share/man/man1/genpkey.1ssl.gz
>         0xcd0f3000..0xcd0f4000 1574119549/share/man/man1/genrsa.1ssl.gz
>         0xcd0f4000..0xcd0f5000 1574119549/share/man/man1/getconf.1.gz
>         0xcd0fb000..0xcd0fc000 1574119553/share/man/man1/getconf.1.gz
>         0xcd13f000..0xcd140000 1574119553/share/man/man1/getent.1.gz
>         0xd0d70000..0xd0dbe000 1574119549/share/perl/5.24.1/perl5db.pl
>         0xd0f8f000..0xd0f92000 1574119549/share/perl/5.24.1/App/Prove/Sta=
te.pm
>         0xd0f92000..0xd0f94000 1574119549/share/perl/5.24.1/App/Prove/Sta=
te/Result.pm
>         0xd0f94000..0xd0f95000 1574119549/share/perl/5.24.1/App/Prove/Sta=
te/Result/Test.pm
>         0xd0fd6000..0xd0fd8000 1574119549/share/perl/5.24.1/Archive/Tar/C=
onstant.pm
>         0xd0fd8000..0xd0fdd000 1574119549/share/perl/5.24.1/Archive/Tar/F=
ile.pm
>         0xd0fdd000..0xd0fe0000 1574119549/share/perl/5.24.1/B/Debug.pm
>         0xd1540000..0xd1553000 1574119553/share/perl/5.24.1/ExtUtils/MM_A=
ny.pm
>         0xd155c000..0xd155e000 1574119553/share/perl/5.24.1/ExtUtils/MM_N=
W5.pm
>         0xd155e000..0xd155f000 1574119553/share/perl/5.24.1/ExtUtils/MM_O=
S2.pm
>
> Notice that 0xcd0f0000 to 0xcd0fb000 are in the same RAID5 strip (64K),
> as are 0xd0f92000 to 0xd0fdd000, and 0xd155c000 to 0xd155e000.  The files
> gnupg2.mo and perl5db.pl also include multiple corrupted blocks within
> a single RAID strip.
>
> All files that had sha1sum failures also had EIO/csum failures, so btrfs
> did detect all the (now uncorrectable) corrupted blocks correctly.  Also
> no problems have been seen with btrfs raid1 (metadata or data).

Indeed, there's a serious problem with raid5 and raid6.
I've just started a thread (I cc'ed you) describing the problem and to
see if anyone else was aware of the problem and has already any
thoughts on how to fix it.

See: https://lore.kernel.org/linux-btrfs/CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKx=
u62VfLpAcmgsinBFw@mail.gmail.com/

Thanks.

>
> Reproducer (runs in a qemu with test disks on /dev/vdb and /dev/vdc):
>
>         #!/bin/bash
>         set -x
>
>         # Reset state
>         umount /try
>         mkdir -p /try
>
>         # Create FS and mount.  Use raid1 metadata so the filesystem
>         # has a fair chance of survival.
>         mkfs.btrfs -draid5 -mraid1 -f /dev/vd[bc] || exit 1
>         btrfs dev scan
>         mount -onoatime /dev/vdb /try || exit 1
>
>         # Must be on btrfs
>         cd /try || exit 1
>         btrfs sub list . || exit 1
>
>         # Fill disk with files.  Increase seq for more test data
>         # to increase the chance of finding corruption.
>         for x in $(seq 0 3); do
>                 sync &
>                 rsync -axHSWI "/usr/." "/try/$(date +%s)" &
>                 sleep 2
>         done
>         wait
>
>         # Remove half the files.  If you increased seq above, increase th=
e
>         # '-2' here as well.
>         find /try/* -maxdepth 0 -type d -print | unsort | head -2 | while=
 read x; do
>                 sync &
>                 rm -fr "$x" &
>                 sleep 2
>         done
>         wait
>
>         # Fill in some of the holes.  This is to get a good mix of
>         # partially filled RAID stripes of various sizes.
>         for x in $(seq 0 1); do
>                 sync &
>                 rsync -axHSWI "/usr/." "/try/$(date +%s)" &
>                 sleep 2
>         done
>         wait
>
>         # Calculate hash we will use to verify data later
>         find -type f -exec sha1sum {} + > /tmp/sha1sums.txt
>
>         # Make sure it's all on the disk
>         sync
>         sysctl vm.drop_caches=3D3
>
>         # See distribution of data across drives
>         btrfs dev usage /try
>         btrfs fi usage /try
>
>         # Corrupt one byte of each of the first 4G on /dev/vdb,
>         # so that the crc32c algorithm will always detect the corruption.
>         # If you need a bigger test disk then increase the '4'.
>         # Leave the first 16MB of the disk alone so we don't kill the sup=
erblock.
>         perl -MFcntl -e '
>                 for my $x (0..(4 * 1024 * 1024 * 1024 / 4096)) {
>                         my $pos =3D int(rand(4096)) + 16777216 + ($x * 40=
96);
>                         sysseek(STDIN, $pos, SEEK_SET) or die "seek: $!";
>                         sysread(STDIN, $dat, 1) or die "read: $!";
>                         sysseek(STDOUT, $pos, SEEK_SET) or die "seek: $!"=
;
>                         syswrite(STDOUT, chr(ord($dat) ^ int(rand(255) + =
1)), 1) or die "write: $!";
>                 }
>         ' </dev/vdb >/dev/vdb
>
>         # Make sure all that's on disk and our caches are empty
>         sync
>         sysctl vm.drop_caches=3D3
>
>         # Before and after dev stat and read-only scrub to see what the d=
amage looks like.
>         # This will produce some ratelimited kernel output.
>         btrfs dev stat /try | grep -v ' 0$'
>         btrfs scrub start -rBd /try
>         btrfs dev stat /try | grep -v ' 0$'
>
>         # Verify all the files are correctly restored transparently by bt=
rfs.
>         # btrfs repairs correctable blocks as a side-effect.
>         sha1sum --quiet -c /tmp/sha1sums.txt
>
>         # Do a scrub to clean up stray corrupted blocks (including superb=
locks)
>         btrfs dev stat /try | grep -v ' 0$'
>         btrfs scrub start -Bd /try
>         btrfs dev stat /try | grep -v ' 0$'
>
>         # This scrub should be clean, but sometimes is not.
>         btrfs scrub start -Bd /try
>         btrfs dev stat /try | grep -v ' 0$'
>
>         # Verify that the scrub didn't corrupt anything.
>         sha1sum --quiet -c /tmp/sha1sums.txt



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
