Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9E030657B
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 21:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhA0U4f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 15:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbhA0Uzj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 15:55:39 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1F7C061573
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 12:54:59 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a1so3337148wrq.6
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 12:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4XBsjGqD/mkOspWQa9iqEM0CskiqJl03yDu+jpP1tmg=;
        b=myCWwzgK+YiGSJtIaVT3gsBvys/YWweSgHaIskUvz/g1VNvNuvIxpt18jeZmzejYig
         1I/CvmT9LT+fc01PhjK1oCTj+r519J9H00HqZ9XDXO7J2eiMFbagGAMybkHt1lhZQQWi
         ZMUFdlewQkskGgjYsWM6XqJkJMdrnCgolKdc8YgaLvlwMOO1DD2Nk+Wcu2TcdkBYi+WV
         2XY6hrSKaN2rLN21U7CyAkJaxmqkZXvOAURdGUuffZx+thvBlC3d5an2v1ipKVa/S0DO
         DnsDvH7cVgxN6j9i9KiQ86fh/zLVS01JV+E4eyt8NmykScfIEZaakxxX3rM/VIE41k6J
         1gQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4XBsjGqD/mkOspWQa9iqEM0CskiqJl03yDu+jpP1tmg=;
        b=I8guGSIrurUztTY8bm0+BIalIycYbW6lmJpfnJgMZGGpOV9OjgdQ5kkUiHfnT+jzMR
         Jw1E2R3qvOpbJ4S8GaP+KE+q4Ll1kaOj2NXZTkJ9uZbxbhPWGkcxM88Hk9xwOIWWf0qx
         ixmZZCjGKy+lhLTi6o6vMbP5dm2orgtwgykS4C/hvBZHENgkmEZjogoL927xHXqTzxlC
         BQx7W8xbAfcP2ZE/DKfmMPQjnz7vNj+fYdH4zz6wn+5pzozkJis1N5Me9v/MjkLJAIR8
         zfLKkyJ1ZDnhtRRxwhBubCFNOQh5DW7IKWwoWo6oJuXOezwdoWccR27NyCtim8mZyZE6
         entQ==
X-Gm-Message-State: AOAM532HihYttTBnyqVeieCulcARgFMJvpqwUwqd7gJQFwHokXAnyPLT
        uJQnQ7LnIkHqyLQ9vy2/mbcwvTV7Gsvddx3ihDh4SWzBdgg4vQ==
X-Google-Smtp-Source: ABdhPJxI3PAY9sCB5bOEGVkrD5leHIplQWTn0jCaRcS9UesEYHuqK7EtOTaIzUJVYuvRu+TuBsiMHUUxS5Y69fszi8c=
X-Received: by 2002:a5d:6686:: with SMTP id l6mr12904767wru.236.1611780898115;
 Wed, 27 Jan 2021 12:54:58 -0800 (PST)
MIME-Version: 1.0
References: <cf9189c0-614c-26e8-9d3e-8e18555c064f@rqc.ru> <CAJCQCtQFniOd53+3FFoOo4UM8CzY_vranrrHiWH86HugNvaOpw@mail.gmail.com>
 <688790d4-4412-4570-8490-4f8f70e3b5a1@rqc.ru>
In-Reply-To: <688790d4-4412-4570-8490-4f8f70e3b5a1@rqc.ru>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 27 Jan 2021 13:54:42 -0700
Message-ID: <CAJCQCtQzqB-_MOFGd_YQ6jfkGxJwWvBXFSA-5Pn=KuoB+r51sA@mail.gmail.com>
Subject: Re: btrfs becomes read-only
To:     Alexey Isaev <a.isaev@rqc.ru>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 27, 2021 at 6:05 AM Alexey Isaev <a.isaev@rqc.ru> wrote:
>
> I managed to run btrs check, but it didn't solve the problem:
>
> aleksey@host:~$ sudo btrfs check --repair /dev/sdg

OK it's risky to run --repair without a developer giving a go ahead,
in particular with older versions of btrfs-progs. There are warnings
in the man page about it.


> [sudo] password for aleksey:
> enabling repair mode
> Checking filesystem on /dev/sdg
> UUID: 070ce9af-6511-4b89-a501-0823514320c1
> checking extents
> parent transid verify failed on 52180048330752 wanted 132477 found 132432
> parent transid verify failed on 52180048330752 wanted 132477 found 132432
> parent transid verify failed on 52180048330752 wanted 132477 found 132432
> parent transid verify failed on 52180048330752 wanted 132477 found 132432
> Ignoring transid failure
> leaf parent key incorrect 52180048330752
> bad block 52180048330752
> Errors found in extent allocation tree or chunk allocation
> parent transid verify failed on 52180048330752 wanted 132477 found 132432

Yeah it's not finding what it's expecting to find there.

Any power fail or crash in the history of the file system?

What do you get for:

btrfs insp dump-s -f /dev/sdg


-- 
Chris Murphy
