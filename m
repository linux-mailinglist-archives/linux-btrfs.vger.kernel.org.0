Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7B941C1A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 11:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245010AbhI2Jfn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 05:35:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:59555 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhI2Jfm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 05:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632908039;
        bh=t+vIshTN6bAJAxI/Eo5ZyOZpCm4eJuWu0qpoHDdeD24=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=PniwSWKvAYmnMvR0iqdurZyt2ICFfaYcqfmmlsd0PKqHOzI4w6P8cGnn3D93LWC6P
         DiAfsv2YRwV5N792Gma8hnuOlXuwfd5MjkTCy68WpEN2IjQpi+/UhicFaXbleZ2OJ6
         48rUaISPsgDdxFbaCAcbDqqgDnZoNzk3PCOZT2UM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3bX1-1mwuKT1G6t-010bEH; Wed, 29
 Sep 2021 11:33:58 +0200
Message-ID: <99b58a1c-7cae-5311-1747-d51c4b5415a5@gmx.com>
Date:   Wed, 29 Sep 2021 17:33:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH RFC] btrfs-progs: receive: fallback to buffered copy if
 clone failed
Content-Language: en-US
To:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210928235159.9440-1-wqu@suse.com>
 <CAL3q7H4OqEpAEWhGUH4okvOedhdK0dChYHdJkYrv-1vsAqKAow@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H4OqEpAEWhGUH4okvOedhdK0dChYHdJkYrv-1vsAqKAow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hkqLWVXyUqkOuWjN8G+ujEbbkFBYcAPM4oeAKpTu/Bv//Evht66
 dwEkiEEIDV76PWx6aEeaofVNv5k4aIoprhMHOH914vyA264/CXpZSXPG8e2XwxUe8Avh4/8
 O3cG/0WN4OziZ3ZUkkuEavGElKvQ0yukaRXR4LRKchiGXNzAnBRqHbGpA7fab+3+PLpcSXc
 BJz8NT/32l6I9lWng0cTg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2PT1yLCIKq8=:IUiAHN2auUzhAS3BFzGsvO
 WJXpe3+fYgr9XuL/dKjSsQaaE9Fu7J3ore/jefXb9J4fkW+IjYidX9rXkmozP39v15zjxQ+ZT
 XizrmohA6cf12Ve/dwRGJHdSU4fbFqVgeUrD6vNd5PnelWnb5OheSPoIwS/gOxy9sYTDK4WCw
 pQEfcQKsDpOJSYujRuYBcNLaCc25rdLsJSKl2BLfD2/nZD+GEEGW/th7tRK0U+cG/haOMri6+
 ycSnExTDY+IPVarVMh0tOBJpOyn/pkNgJ+k7dGZUN6Osgx9g113FC+3v20RNUNF/v36w1KE92
 Y5NTYKWvmHXk8T5oa5zmCMpyyYJnQMiHma33VeciSZy0fEAEVYm+tCxTNTfJAXR2ShrLrh3aP
 7sOlNT8A8I+jgzs3r9RLlZmOEa6zi6MAJJG0T41RxcwVIgaZ+R0tzr8oiAHwzemacuw1aLY0I
 GKBh22uAHH1yLfZjfh01scR7W4m6+0XZzzmSebmdHyjrwV82GU1RsJt5oF2OwWbbU+DySPquU
 JS3G+iAJ/Y07wK+E/oE86faOhNT6qIKOfgxpRhL6xLIL/hxjFLez702wv08RHnLWCyQ9EkW5m
 gzlw5ylDmQlrg8hRrWdV0UTM+oFkHQB2m41PtzY38VvEYaVGwEQAVyg3QNo6j2uIi8tPL+J2B
 QkADXSXVPB2CFsVkI0fM2HmxN7EeNs7dbyMBP8965nQArp9zxuYEVUiGnBVbDLAS/y2t0mKQT
 np5LLGJaVeUL4nPADbmd+KKf92qfdZ0And1O55b9EiqeUC5vHToxeefpWXyHdzwJ03pFvPV37
 GsNbI7FpnMcqPhMGUHPKxJX7rm7+tIA4KbqJrAviYyE/MyYCwKiPMGK1ofIHLhM4Rr2x5N+Xr
 uPBy5h94qzLPMU6OemNudZFBDiKITt8vSB/nNlhpl5cIANr6XC3wEdpexMXQ8hn9K/rIkxahI
 Dsh67XHJFAKYu3txjXNvzfNfFwblROJJedAWStzeQ8qAD/NGmx4tB1h2PRgfkg67AjVg3XAeD
 K+xkkfM0jeAv9b4yMPa8DxqGagXwVFMJRZv7Ny3J0SIbAmljCFuU96STRx/GNOfKG6e3gP4Hv
 7ZJ3lNwbK1AAdg=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/29 17:27, Filipe Manana wrote:
> On Wed, Sep 29, 2021 at 12:55 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> There are two every basic send streams:
>> (a/m/ctime and uuid omitted)
>>
>>    Stream 1: (Parent subvolume)
>>    subvol   ./parent_subv           transid=3D8
>>    chown    ./parent_subv/          gid=3D0 uid=3D0
>>    chmod    ./parent_subv/          mode=3D755
>>    utimes   ./parent_subv/
>>    mkfile   ./parent_subv/o257-7-0
>>    rename   ./parent_subv/o257-7-0  dest=3D./parent_subv/source
>>    utimes   ./parent_subv/
>>    write    ./parent_subv/source    offset=3D0 len=3D16384
>>    chown    ./parent_subv/source    gid=3D0 uid=3D0
>>    chmod    ./parent_subv/source    mode=3D600
>>    utimes   ./parent_subv/source
>>
>>    Stream 2: (snapshot and clone)
>>    snapshot ./dest_subv             transid=3D14 parent_transid=3D10
>>    utimes   ./dest_subv/
>>    mkfile   ./dest_subv/o258-14-0
>>    rename   ./dest_subv/o258-14-0   dest=3D./dest_subv/reflink
>>    utimes   ./dest_subv/
>>    clone    ./dest_subv/reflink     offset=3D0 len=3D16384 from=3D./des=
t_subv/source clone_offset=3D0
>>    chown    ./dest_subv/reflink     gid=3D0 uid=3D0
>>    chmod    ./dest_subv/reflink     mode=3D600
>>    utimes   ./dest_subv/reflink
>>
>> But if we receive the first stream with default mount options, then
>> remount to nodatasum, and try to receive the second stream, it will fai=
l:
>>
>>   # mount /mnt/btrfs
>>   # btrfs receive -f ~/parent_stream /mnt/btrfs/
>>   At subvol parent_subv
>>   # mount -o remount,nodatasum /mnt/btrfs
>>   # btrfs receive -f ~/clone_stream /mnt/btrfs/
>>   At snapshot dest_subv
>>   ERROR: failed to clone extents to reflink: Invalid argument
>>   # echo $?
>>   1
>>
>> [CAUSE]
>> Btrfs doesn't allow clone source and destination to have different NODA=
TASUM
>> flags.
>> This is to prevent a data extent to be owned by both NODATASUM inode an=
d
>> regular DATASUM inode.
>>
>> For above receive operations, the clone destination is inheriting the
>> NODATASUM flag from mount option, while the clone source has no
>> NODATASUM flag, thus preventing us from doing the clone.
>>
>> [FIX]
>> Btrfs send/receive doesn't require the underlying inode has the same
>> flags (thus we can send from compressed extent and receive on a
>> non-compressed filesystem).
>>
>> So here we can just fall back to buffered write to copy the data from
>> the source file if we got an -EINVAL error.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Reason for RFC:
>>
>> Such fallback can lead to hidden bugs not being exposed, thus a new
>> warning is added for such fallback case.
>>
>> Personally I really want to do more comprehensive check in user space t=
o
>> ensure it's only mismatching NODATASUM flags causing the problem.
>> Then we can completely remove the warning message.
>>
>> But unfortunately that check can go out-of-sync with kernel and due to
>> the lack of NODATASUM flags interface we're not really able to check
>> that easily.
>>
>> So I took the advice from Filipe to just do a simple fall back.
>>
>> Any feedback on such maybe niche point would help.
>> (Really hope it's me being paranoid again)
>> ---
>>   cmds/receive.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++-=
-
>>   1 file changed, 55 insertions(+), 2 deletions(-)
>>
>> diff --git a/cmds/receive.c b/cmds/receive.c
>> index 48c774cea587..4cb857a13cdf 100644
>> --- a/cmds/receive.c
>> +++ b/cmds/receive.c
>> @@ -705,6 +705,51 @@ out:
>>          return ret;
>>   }
>>
>> +#define BUFFER_SIZE    SZ_32K
>> +static int buffered_copy(int src_fd, int dst_fd, u64 src_offset, u64 l=
en,
>
> At the very least leave a blank line between the #define and the
> function's declaration.
>
>> +                        u64 dest_offset)
>> +{
>> +       unsigned char *buf;
>> +       u64 cur_offset =3D 0;
>> +       int ret =3D 0;
>> +
>> +       buf =3D calloc(BUFFER_SIZE, 1);
>
> It could be simpler:
>
> char buf[SZ_32K];
>
> then use ARRAY_SIZE() below.
>
>> +       if (!buf)
>> +               return -ENOMEM;
>> +
>> +       while (cur_offset < len) {
>
> This is a bit confusing, comparing an offset to a length.
> Renaming "cur_offset" to "copied" would be more logical imo.
>
>> +               u32 copy_len =3D min_t(u32, BUFFER_SIZE, len - cur_offs=
et);
>> +               u32 write_offset =3D 0;
>> +               ssize_t read_size;
>> +
>> +               read_size =3D pread(src_fd, buf, copy_len, src_offset +=
 cur_offset);
>> +               if (read_size < 0) {
>> +                       ret =3D -errno;
>> +                       error("failed to read source file: %m");
>> +                       goto out;
>> +               }
>
> Normally we should only exit if errno is not EINTR, and retry
> (continue) on the EINTR case.

For this, I'm a little concerned.

EINTR means the operation is interrupted (by signal).
In that case, doesn't it mean the user want to stop the receive?

>
>> +
>> +               /* Write the buffer to dest file */
>> +               while (write_offset < read_size) {
>
> Same here, like "write_offset" to "written".
>
>> +                       ssize_t write_size;
>> +
>> +                       write_size =3D pwrite(dst_fd, buf + write_offse=
t,
>> +                                       read_size - write_offset,
>> +                                       dest_offset + cur_offset + writ=
e_offset);
>> +                       if (write_size < 0) {
>> +                               ret =3D -errno;
>> +                               error("failed to write source file: %m"=
);
>> +                               goto out;
>> +                       }
>
> Same here regarding dealing with EINTR.
>
>> +                       write_offset +=3D write_size;
>> +               }
>> +               cur_offset +=3D read_size;
>> +       }
>> +out:
>> +       free(buf);
>> +       return ret;
>> +}
>> +
>>   static int process_clone(const char *path, u64 offset, u64 len,
>>                           const u8 *clone_uuid, u64 clone_ctransid,
>>                           const char *clone_path, u64 clone_offset,
>> @@ -788,8 +833,16 @@ static int process_clone(const char *path, u64 off=
set, u64 len,
>>          ret =3D ioctl(rctx->write_fd, BTRFS_IOC_CLONE_RANGE, &clone_ar=
gs);
>>          if (ret < 0) {
>>                  ret =3D -errno;
>> -               error("failed to clone extents to %s: %m", path);
>> -               goto out;
>> +               if (ret !=3D -EINVAL) {
>> +                       error("failed to clone extents to %s: %m", path=
);
>> +                       goto out;
>> +               }
>> +
>> +               warning(
>> +               "failed to clone extents to %s, fallback to buffered wr=
ite",
>> +                       path);
>
> What if we have thousands of clone operations?
> Is there any rate limited print() in progs like there is for kernel?

Unfortunately we don't yet have.

But the good news (that I didn't catch at time of writing) is, we now
have global verbose/quite switch, so that we can easily hide those
warning by default and only output such warning for verbose run.

Thanks,
Qu

>
> That's one reason why my proposal had in mind an optional flag to
> trigger this behaviour.
>
> Thanks for doing it, I was planning on doing something similar soon.
>
>> +               ret =3D buffered_copy(clone_fd, rctx->write_fd, clone_o=
ffset,
>> +                                   len, offset);
>>          }
>>
>>   out:
>> --
>> 2.33.0
>>
>
>
