Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8E5F191E14
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 01:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgCYA2b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 20:28:31 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:35257 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgCYA2b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 20:28:31 -0400
Received: by mail-io1-f53.google.com with SMTP id h8so578370iob.2
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Mar 2020 17:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q8sfHcbBEYcyxhJQGf3bdQbeioXNY9P2M6Dgp7zdLvA=;
        b=cEfdES3ztur7x7dphxummnNc9JlP9kA3MXumjkboH/fR0l9GsC5alIn9cfbnCjFRyy
         lT8DSdqAnKYA7RBCFjMjGZkk4xl0A22igIMvTpDVgKaNW0jNvgJrohxzJwXVn/zwrsSV
         VivhWQuyd+55FnPU1RMqXnANzeHrH9poEyNFZI/Hxuiq9RvOnDmq3iLO1d2w75GiNOqi
         Kk8e+i8tVA6vkIk2qjWGOv/C2Nwz5Yr8hKCOXm8jPtoOBB19Ty+Vx+UjCbGvwD0qF+XE
         4i7+GplQJkXZj9C8dDUusY3Bk5GPGJ5Z5uJ0kJOIqhwGkylks9omFYOnlbiykXrYTrJG
         GeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q8sfHcbBEYcyxhJQGf3bdQbeioXNY9P2M6Dgp7zdLvA=;
        b=eeRHUENyPpgxJtcpIfmNQBeFIZUNR1w5UXwiruBkHPWtXEKBZSHmw5eVV/3TKcL76p
         KIZ5beyAHFzFIpiUTMGMgi/Wm0ntVNksTh3gMB1CBBuoR+BtAyZTvnLqEqJwBnV+H+P3
         NfU3GVjNflhsVP87Ba1qBaJD4/0hBJ2GobyrU84sVoeE3UemGbyniudo+UnyJDs14EWv
         DAGFaIDw83IdOsBJlnmTLcjn7xsRjiOZFJu4ENew/PocPKZASNbhIZfuHz1akvn39cP8
         fP1XFr2ztCRj0D3Wf4WCHalt7wYu+l3MIDgymcJCX+fI/d1aaPPywBCU7oDki0eq3rnt
         eXxQ==
X-Gm-Message-State: ANhLgQ3MqJq6Tl+Zn2jEy7qfWXrUNsy0kSY6FXJDqjduR7grC+KAnMpP
        t+vtqdp6YXn4A/U+tfoYkwRibN4MuGAkl8auyqWrsw==
X-Google-Smtp-Source: ADFU+vs0NdPPqWQETTOrg+cKzuZsLisr7hXngYqSXIr6ogHRNO8/CFeEGagnpxQXSi+G41iIoYFYal//Bg3MEyWjVUo=
X-Received: by 2002:a6b:4409:: with SMTP id r9mr609168ioa.75.1585096109846;
 Tue, 24 Mar 2020 17:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAJiQAnAJS-mSvQcC+8BActs53TZ6id+rc-CCO+DMWD9yJ810Ug@mail.gmail.com>
 <5b73f866-3917-ee20-1787-7f410d27fa23@gmx.com>
In-Reply-To: <5b73f866-3917-ee20-1787-7f410d27fa23@gmx.com>
From:   Ganesh Sangle <sayganesha@gmail.com>
Date:   Tue, 24 Mar 2020 17:28:19 -0700
Message-ID: <CAJiQAnCJL+K+SpTT7qweAf4HLg+FB=mDZPDXqtkPDj1onC=5yw@mail.gmail.com>
Subject: Re: extent generation_id
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you for the confirmation and explanation.

On Tue, Mar 24, 2020 at 5:12 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/3/25 =E4=B8=8A=E5=8D=887:01, Ganesh Sangle wrote:
> > hi,
> > i am new to the email list - and i have a question. Please let me know
> > if this is not the right forum for this question.
> >
> > While iterating the extents for a subvolume, btrfs_file_extent_item
> > returns a generation_id - which is the "transaction id that created
> > this extent".
> > Is it safe to assume that every pwrite syscall will endup a generating
> > new generation id for an extent, regardless if it is over-writing an
> > existing extent (offset) or writing to a new never written (offset) ?
>
> For data cow (the default behavior), all data writes, no matter buffered
> (including pwrite) or direct IO, will lead to new extents, thus a new
> generation.
>
> Furthermore, even if we overwrite the whole existing extent, we won't
> write directly into the existing extent, we will keep the existing
> extent until current transaction is committed.
> This is proper COW behavior, to ensure even we had a power loss, we will
> either see the old data (and metadata) or new data (and metadata)
>
> For no data cow case, overwriting existing extent won't update the
> extent item, thus not update the generation (which skips some metadata
> IO, and improves performance).
>
> But no data cow case is limited in btrfs, even a file has NODATACOW bit
> set, if there is a snapshot referring to that file, we will still do COW.
>
> > In other words, can we assume that if we have generation id associated
> > with all extents of a snapshot (S1) of a volume, then we delete this
> > snapshot, and then do some i/o(write/discard) to the volume and create
> > a new snapshot (S2) from this volume, if we iterate over the extents
> > of this new snapshot (S2) we will see a different generation id
> > (compared to the one we got from the snapshot (S1)) if the i/o
> > (write/discard) happened at an offset in that extent ?
>
> Since the write happens after S1 is deleted, there is no guarantee that
> CoW will still happen for NODATACOW files.
> Thus we can overwrite existing extents, thus it's possible that no new
> generation id generated.
>
> Thanks,
> Qu
>
> >
> > Thanks for the help !
> >
>
