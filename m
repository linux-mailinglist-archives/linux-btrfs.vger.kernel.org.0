Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406B037F51F
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 May 2021 11:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhEMJ7B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 May 2021 05:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhEMJ7A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 May 2021 05:59:00 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142BAC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 13 May 2021 02:57:51 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id a2so24916487qkh.11
        for <linux-btrfs@vger.kernel.org>; Thu, 13 May 2021 02:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=KlvL6v5veICTpq5n4vcPMBpQ1VYvaElthmGz0KkGWyc=;
        b=u076jrZ7yn7vC16z8KX+wO6ks0bv2j+r2lMRjBn7ktYAlWfmomg04ZUWQWJBBcimrO
         +V9jwlUbFa347+XnYy+xd4vpiQtZwHXwT4PpRnhKn8HEOKiRfSxlzCy3BHPbUCcaF93x
         GyLApBY+wxHIOE+aNcwUuLeAMCZCXDc1d9ifQ2jhChWFeXjh4bEfkbz26dvJqU1cjhSO
         x3fbJUTqG4l77EU+qgRgoDIOFUJg+X/XQnkUFRaMbVgqBcixK/xTtTxKiRL1ljlDfBP1
         kuw/kxD3tVI8HM3P2l3QmsAkqKQbANVMW90xJ7RHtrAIPUAHonPV0dBRzGjvGASM4SYz
         JAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=KlvL6v5veICTpq5n4vcPMBpQ1VYvaElthmGz0KkGWyc=;
        b=Lgow9IPY8ZJogOCZ8sm9wBeF6Wlozj3LmMnmTRy7iPEkiqzUUeHdpksg/wFMeOHqTa
         cOJH5f11ThQ9rP5bsrFSLCYvIqzzbX+a0/lexFoaio1UBH3aaLLcivi62qGDMSxqT542
         Ifa2N80fo+ZiQFA6ZeBf0XCTWTDdfTI5rQXTMMYZfW2XiFnfhmSqS+Mo9o8wrmsZYjw+
         3BvftbYkOBMMhrtZ8Hf6Ej69xIsROXaAMpE9Rp1hHpqCFIG16ATwYCUUwtRk9y0KaFrs
         X5Q1Xlgdv5kbb5ediWC+79kPJdTDf4/O8uR+g/Xr1oAaxtSBvAwa5NjTSrap96mWXE46
         PlCw==
X-Gm-Message-State: AOAM530Y5aOw8lxzpcT95VvcieUFtI18vD1f9Qs/Q/e/kyNUecA8N3wB
        wnEUL/Kv8Y2VAhUvWXd9896ocKVExbzlmhdALFU=
X-Google-Smtp-Source: ABdhPJw06j8AGbwodGMjk4j9TllzI2VXK1gmoChaedXnzIKCRf8dsb9QGSMahJBfWMLu6bq434MOjZA8XSh1ivB2tR0=
X-Received: by 2002:a37:4017:: with SMTP id n23mr35608460qka.338.1620899870258;
 Thu, 13 May 2021 02:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <93c4600e-5263-5cba-adf0-6f47526e7561@in.tum.de>
 <CAL3q7H7mFmNhhCUTeYG_56gsz1p2G_sN=1GuPBjdbB=sC-EQyw@mail.gmail.com>
 <ad414944-2418-3728-ac1a-5d4d37e37ac1@in.tum.de> <CAL3q7H6WmvatgNpGA6pqPBfe6TjPViwwCJo=wrjBOZRN0q0LuQ@mail.gmail.com>
 <ef9ea56e-fb47-f719-137b-ffb545a09db7@in.tum.de>
In-Reply-To: <ef9ea56e-fb47-f719-137b-ffb545a09db7@in.tum.de>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 13 May 2021 10:57:39 +0100
Message-ID: <CAL3q7H7xTSbyEBz9vqZc3tnqcccWTxLENLbvSX11LU7JcBXKuA@mail.gmail.com>
Subject: Re: Leaf corruption due to csum range
To:     Philipp Fent <fent@in.tum.de>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 11, 2021 at 7:19 PM Philipp Fent <fent@in.tum.de> wrote:
>
> Thanks for the explanation! I wasn't aware of these ioctls.
>
> > strace would be clear to me, which I'm more familiar with (or even
> better, bpftrace).
>
> I've attached an strace output that decompresses to about 200MB
> logfiles. I can't make heads or tails of it, but I hope it helps.
> I have never used bpftrace, do you have any pointers where I could start?

There's some documentation and examples on their github.

>
> > I just remembered that 5.13-rc1 includes a fix for races between mmap
> writes and fsync that could fix that
>
> I tried 5.13-rc1, but I'm running into the same csum range issue:
>
>
>
> Linux version 5.13.0-rc1-1-mainline (linux-mainline@archlinux) (gcc
> (GCC) 10.2.0, GNU ld (GNU Binutils) 2.36.1) #1 SMP PREEMPT Tue, 11 May
> 2021 15:34:19 +0000
> ...
> BTRFS critical (device sda): corrupt leaf: root=3D18446744073709551610
> block=3D507430633472 slot=3D5, csum end range (293918547968) goes beyond =
the
> start range (293918416896) of the next csum item
> BTRFS info (device sda): leaf 507430633472 gen 18451 total ptrs 11 free
> space 5016 owner 18446744073709551610
>         item 0 key (18446744073709551606 128 293837238272) itemoff 15923
> itemsize 360
>         item 1 key (18446744073709551606 128 293838544896) itemoff 15863
> itemsize 60
>         item 2 key (18446744073709551606 128 293838675968) itemoff 15563
> itemsize 300
>         item 3 key (18446744073709551606 128 293839527936) itemoff 15503
> itemsize 60
>         item 4 key (18446744073709551606 128 293872295936) itemoff 15263
> itemsize 240
>         item 5 key (18446744073709551606 128 293913763840) itemoff 10591
> itemsize 4672
>         item 6 key (18446744073709551606 128 293918416896) itemoff 8351
> itemsize 2240
>         item 7 key (18446744073709551606 128 293947658240) itemoff 8347
> itemsize 4
>         item 8 key (18446744073709551606 128 293965193216) itemoff 8287
> itemsize 60
>         item 9 key (18446744073709551606 128 293965848576) itemoff 8227
> itemsize 60
>         item 10 key (18446744073709551606 128 293966176256) itemoff 5291
> itemsize 2936
> BTRFS error (device sda): block=3D507430633472 write time tree block
> corruption detected
> BTRFS critical (device sda): corrupt leaf: root=3D18446744073709551610
> block=3D507447197696 slot=3D0, csum end range (320352133120) goes beyond =
the
> start range (320352116736) of the next csum item
> BTRFS info (device sda): leaf 507447197696 gen 18451 total ptrs 3 free
> space 116 owner 18446744073709551610
>         item 0 key (18446744073709551606 128 320336326656) itemoff 847
> itemsize 15436
>         item 1 key (18446744073709551606 128 320352116736) itemoff 831
> itemsize 16
>         item 2 key (18446744073709551606 128 320352247808) itemoff 191
> itemsize 640
> BTRFS error (device sda): block=3D507447197696 write time tree block
> corruption detected
> BTRFS: error (device sda) in btrfs_sync_log:3136: errno=3D-5 IO failure
> BTRFS info (device sda): forced readonly

Ok, then it's something else.

When I run you reproducer I get an error:

$ ./runMssql.sh
Starting MSSQL docker container...
9943b714ed210a2937d5fce27ec110981b471e6e9f2c619629cb66501621ebb5
Loading TPC-H schema...
Sqlcmd: Error: Microsoft ODBC Driver 17 for SQL Server : Login failed
for user 'sa'..

dbgen.sh ran successfully before.

Any idea?

>
>
>
> Curiously, the second leaf range overshot by only 16KB....
> Let me know, if I can try anything else.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
