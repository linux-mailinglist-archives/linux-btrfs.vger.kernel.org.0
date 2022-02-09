Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8714AFEE4
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Feb 2022 22:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbiBIVEK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Feb 2022 16:04:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiBIVEJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Feb 2022 16:04:09 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6CEC033255
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 13:04:11 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id y129so9668067ybe.7
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Feb 2022 13:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tdi62GSkxUrAtmOmpQlE0lAGL99BmNDqPsZdqWU8TTM=;
        b=C8WecqHugBuP9UvePOHJxmVr7DM85aghJJldVJxuGKL26lY6yYEj/CPjslUmKh3Oe2
         hJr/3FzJ4Yi31sy2JH4+Z5YEwIbcqQr1CHTAkBjSzCC179iaPJVIUm6tgjTHAjNV3K9F
         oIGT4Iv3gnqrZt+LLSlEbIuls9rcGms11RZPKKkyipxU0tXrw2csvQXuLQGK0OXlK8f3
         zDtNoaGzNKXqZsOWEbigOoOW6w3JqWNB/yThyyyTfER8kxQRUSSVL0i4pM1HhVX+IqZM
         RhBOtmpnRpjXZ4+7NsJwMu7o1hukfoRL/DiPWu8XDfc5vvsFcwdIgUArRFy8H5AFqgwG
         ocLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tdi62GSkxUrAtmOmpQlE0lAGL99BmNDqPsZdqWU8TTM=;
        b=Ev3UTWVOOXOAIWzfzkpQ3XvmZ2X1vutZC66Sj3HjFjVI55r5RynMblK9aqMPfECcna
         i7SpgrWbrVSE2zUQn/N2UQT+2mn0gFUYY33TQ1TFZalPNn8q+saSWEVhQe1SvITj5ZMN
         /RaQDdL0ndjPQXMTOWQPAEVI/KGwEuqDVIpZBzgDc/mjKxJ4KoM0piLY8kboN/J0rMC7
         4Y6cz+eeVzPJYIwPF3AnFt5EAOlh7tf2BmE0raEqZMoT6Cp7+YAhPEaBkMi1W+VY2dBd
         eIahsauanilFYI/ngfBnVudF0/rsWiPmJ1O4lGPvdmmTC6z3RJG8gbLVBCIMeJzJuWfW
         E9HA==
X-Gm-Message-State: AOAM530/dMB7uJhZEYnKBwAyr1xpnY5IBNJcyBemVuF2DnrCk7hqGNNR
        4PSvPNh+KAMbtzn6a5M43tbauoei17HDWaIeunYOaDaFIjJ4y0aO
X-Google-Smtp-Source: ABdhPJwOBNMrEW2mtv9dUcZtgP8wtea//jbffy2uglclzmZj/5dbDB5ImWbU0xYxuEmEbiVb/dCVx23zGWwpugVFpJk=
X-Received: by 2002:a81:2ed6:: with SMTP id u205mr4229480ywu.23.1644440650453;
 Wed, 09 Feb 2022 13:04:10 -0800 (PST)
MIME-Version: 1.0
References: <776a73dbf91d4518a36b465ac9ac2d5a@hemeria-group.com>
In-Reply-To: <776a73dbf91d4518a36b465ac9ac2d5a@hemeria-group.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 9 Feb 2022 14:03:54 -0700
Message-ID: <CAJCQCtQB8HkHDV8jYJUMroaGsMOfCNf3TH_7mO2qz_Oqw-zPMQ@mail.gmail.com>
Subject: Re: Root level mismatch after sudden shutdown
To:     BERGUE Kevin <kevin.bergue-externe@hemeria-group.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 9, 2022 at 5:10 AM BERGUE Kevin
<kevin.bergue-externe@hemeria-group.com> wrote:
>
> Hello everyone.
>
>
> After a sudden shutdown my btrfs partition seems to be corrupted. After a=
 few hours of reading documentation and trying various repair methods I fou=
nd an error message I can't find anywhere so I'm sending it your way hoping=
 you can at least explain what the issue is. The disk was running with linu=
x 5.16.5 at the moment of the crash, my recovery environnement is a linux 5=
.15.16 machine with btrfs-progs v5.16.
>
>
> To retrace my steps a bit:
>
> - I tried to mount my partition normally:
> # mount /dev/mapper/SSD-Root /mnt/broken/
> mount: /mnt/broken: wrong fs type, bad option, bad superblock on /dev/map=
per/SSD-Root, missing codepage or helper program, or other error.
>
> - I then looked at the relevant logs from dmesg:
> # dmesg
> [ 2118.381387] BTRFS info (device dm-1): flagging fs with big metadata fe=
ature
> [ 2118.381394] BTRFS info (device dm-1): disk space caching is enabled
> [ 2118.381395] BTRFS info (device dm-1): has skinny extents
> [ 2118.384626] BTRFS error (device dm-1): parent transid verify failed on=
 1869491683328 wanted 526959 found 526999
> [ 2118.384900] BTRFS error (device dm-1): parent transid verify failed on=
 1869491683328 wanted 526959 found 526999
> [ 2118.384905] BTRFS warning (device dm-1): failed to read root (objectid=
=3D4): -5
> [ 2118.385304] BTRFS error (device dm-1): open_ctree failed
>
> - After some reading about the "parent transid verify failed" errors I tr=
ied to mount the volume with the usebackuproot flag:
> # mount -t btrfs -o ro,rescue=3Dusebackuproot /dev/mapper/SSD-Root /mnt/b=
roken/
> mount: /mnt/broken: wrong fs type, bad option, bad superblock on /dev/map=
per/SSD-Root, missing codepage or helper program, or other error.
> And the dmesg content:
> [ 2442.117867] BTRFS info (device dm-1): flagging fs with big metadata fe=
ature
> [ 2442.117871] BTRFS info (device dm-1): trying to use backup root at mou=
nt time
> [ 2442.117872] BTRFS info (device dm-1): disk space caching is enabled
> [ 2442.117873] BTRFS info (device dm-1): has skinny extents
> [ 2442.123056] BTRFS error (device dm-1): parent transid verify failed on=
 1869491683328 wanted 526959 found 526999
> [ 2442.123344] BTRFS error (device dm-1): parent transid verify failed on=
 1869491683328 wanted 526959 found 526999
> [ 2442.123348] BTRFS warning (device dm-1): failed to read root (objectid=
=3D4): -5
> [ 2442.124743] BTRFS error (device dm-1): parent transid verify failed on=
 1869491683328 wanted 526959 found 526999
> [ 2442.124939] BTRFS error (device dm-1): parent transid verify failed on=
 1869491683328 wanted 526959 found 526999
> [ 2442.124942] BTRFS warning (device dm-1): failed to read root (objectid=
=3D4): -5
> [ 2442.125196] BTRFS critical (device dm-1): corrupt leaf: block=3D186986=
3370752 slot=3D97 extent bytenr=3D920192651264 len=3D4096 invalid generatio=
n, have 527002 expect (0, 527001]
> [ 2442.125201] BTRFS error (device dm-1): block=3D1869863370752 read time=
 tree block corruption detected
> [ 2442.125500] BTRFS critical (device dm-1): corrupt leaf: block=3D186986=
3370752 slot=3D97 extent bytenr=3D920192651264 len=3D4096 invalid generatio=
n, have 527002 expect (0, 527001]
> [ 2442.125502] BTRFS error (device dm-1): block=3D1869863370752 read time=
 tree block corruption detected
> [ 2442.125508] BTRFS warning (device dm-1): couldn't read tree root
> [ 2442.125806] BTRFS critical (device dm-1): corrupt leaf: block=3D186986=
6401792 slot=3D117 extent bytenr=3D906206486528 len=3D4096 invalid generati=
on, have 527003 expect (0, 527002]
> [ 2442.125808] BTRFS error (device dm-1): block=3D1869866401792 read time=
 tree block corruption detected
> [ 2442.126174] BTRFS critical (device dm-1): corrupt leaf: block=3D186986=
6401792 slot=3D117 extent bytenr=3D906206486528 len=3D4096 invalid generati=
on, have 527003 expect (0, 527002]
> [ 2442.126175] BTRFS error (device dm-1): block=3D1869866401792 read time=
 tree block corruption detected
> [ 2442.126184] BTRFS warning (device dm-1): couldn't read tree root
> [ 2442.126599] BTRFS error (device dm-1): open_ctree failed

What do you get for uname -a? What are the mount options? In
particular I'm wondering if this drive is subject to discards, which
currently will render usebackuproots useless. And how old is the file
system?

If ro,rescue=3Dusebackuproot doesn't work, it's not likely repairable,
but might still be something btrfs restore can scrape *if* you haven't
tried any repairs first. Repairs write changes to disk and can make
things worse and harder to recover. You pretty much have to go
straight to the scrape data off the drive step before the repair step
because it is lower risk and more reliable.

The central problem is some lower layer mishandled write order, most
likely by dropping flush/FUA, i.e. confirming to btrfs that flush/FUA
command succeeded when in fact critical  metadata has not yet made it
to persistent media. And there is no way for Btrfs to know this until
it's too late.



>
> - I then tried a check:
> # btrfs check /dev/mapper/SSD-Root
> Opening filesystem to check...
> parent transid verify failed on 1869491683328 wanted 526959 found 526999
> parent transid verify failed on 1869491683328 wanted 526959 found 526999
> parent transid verify failed on 1869491683328 wanted 526959 found 526999
> Ignoring transid failure
> ERROR: root [4 0] level 0 does not match 1

What do you get for

btrfs rescue super -v $dev
btrfs insp dump-s -f $dev
btrfs insp dump-t -b 1869491683328 $dev
btrfs insp dump-t -b 1869863370752 $dev
btrfs insp dump-t -b 1869866401792 $dev



>
> Couldn't setup device tree
> ERROR: cannot open file system
>
>
> I think the "root [4 0] level 0 does not match 1" error is the real cupri=
t but I can't seem to find any info on this message anywhere. I tried a bun=
ch of other commands including:
> - btrfs rescue zero-log
> - btrfs rescue chunk-recover
> - btrfs check --repair
> - btrfs rescue super-recover
> - btrfs check --repair with the tree root found by btrfs-find-root
> - btrfs check --repair --init-csum-tree --init-extent-tree
> - btrfs restore
>
> I'm aware I probably executed some commands that don't make a lot of sens=
e in my context but all of them failed with either the "root [4 0] level 0 =
does not match 1" message or a more generic "could not open ctree" or equiv=
alent.

--repair, but especially --init-extent-tree can make it next to
impossible for 'btrfs restore' command to work. It's not obvious that
trying to fix btrfs, can make it harder for the scrape tool to work.



--=20
Chris Murphy
