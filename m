Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38BA31D7C1
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 11:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhBQK6f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 05:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhBQK6d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 05:58:33 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D58FC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 02:57:53 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id v3so9180799qtw.4
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 02:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=iPbnd0o6SnGa10UY3fkqL6E/HPZ38/zAjDwBfMTZzsw=;
        b=jsHtghX1oVqbq3IJJZpgPjcC6DpDx/j09B7x07C+A5bcz9Hj2sO7dkw7ata+s7jOlO
         22soMTSizVBDH40mN1APqeg25SoOX58bwugqQmDdpTLZTbT4zB+Gaix5qxoy2knG2YXn
         OJS6OXWNj2fJyabMCYLqC2P/yR4eIHE8s4I4X44XfxBRyKNjyQy//o3NS9p+jzaNaZJW
         d5RX2Zsx0qDPL5QqxRc6h8ERkU0vyD1YOrY4pNS4v3iL5UuTM6/co2T0m71613BGdB3d
         IHyqbmKj8RY8Uto9GyTDNIVUeiP7xSkabX2lZ6OBX4VLj5v2qay4y1INhOw/O/39GKwP
         KY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=iPbnd0o6SnGa10UY3fkqL6E/HPZ38/zAjDwBfMTZzsw=;
        b=Cczd3BGmtwTMgYJinizoOnLN7qw/57Dv/OaGTJ/gt7MQYTQ01WV0lpOmKoiQBzAn0v
         GSqe4bnLHxMT0R7I1kuIQMmfRDbnm5a/GNc1SDWeYZF3qbldtYl/qQW6mY/u5j5AlaI0
         SNsnIDf1+ak8S6heYXo9gcRLjJtwMKcLQFbklRs2X9ncB66WDy8DQjgXmqhrJertlLK4
         5MzQ8js47/V1UrsgV1ILNIg1+2hj8hjdtd8wRhvJvcdJfuWM7tDKKz04JWHD+F2zJgDv
         wf64A0i7rKALjlnRUo7NBNK7XaIGyzPEVaHb1PJbNumn9XpBItMuBhOlpnf0VeFaWPKE
         208w==
X-Gm-Message-State: AOAM533s/ZKGBqctSNgFQsHXPWpCTmrk2kIsc+LXQP1kUnONXJuqLlGs
        GzZwdRtFcjeNSDQ6Ago4h50tS9WXJ0am5gjsB8w=
X-Google-Smtp-Source: ABdhPJzCl3RQAZ1WJbbQChw/ZqnDI6wABr5wqz/I3UaY3RNy2XtAIvPdzk+9Iw+QS5bPHjJItZ8x/kWxiyyXgEoSM1g=
X-Received: by 2002:ac8:6d3b:: with SMTP id r27mr22861307qtu.21.1613559472383;
 Wed, 17 Feb 2021 02:57:52 -0800 (PST)
MIME-Version: 1.0
References: <20210216162840.167845-1-realwakka@gmail.com>
In-Reply-To: <20210216162840.167845-1-realwakka@gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 17 Feb 2021 10:57:41 +0000
Message-ID: <CAL3q7H6S2mGUjE-gU5opb4GT9ojxhn4EvbGjZfedytyBp6iQOg@mail.gmail.com>
Subject: Re: [RFC] btrfs-progs: format-output: remove newline in fmt_end text mode
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, dsterba@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 16, 2021 at 4:28 PM Sidong Yang <realwakka@gmail.com> wrote:
>
> Remove a code that inserting new line in fmt_end() for text mode.
> Old code made a failure in fstest btrfs/006.
>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
> Hi, I've just read mail that Filipe written that some failure about fstes=
t.
> I'm worried about this patch makes other problem. So make it RFC. Thanks.

Fixes the test failure indeed, thanks!

> ---
>  common/format-output.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/common/format-output.c b/common/format-output.c
> index f5b12548..96e0dfef 100644
> --- a/common/format-output.c
> +++ b/common/format-output.c
> @@ -124,9 +124,7 @@ void fmt_end(struct format_ctx *fctx)
>
>         /* Close, no continuation to print */
>
> -       if (bconf.output_format & CMD_FORMAT_TEXT)
> -               putchar('\n');
> -       else if (bconf.output_format & CMD_FORMAT_JSON) {
> +       if (bconf.output_format & CMD_FORMAT_JSON) {
>                 fmt_dec_depth(fctx);
>                 fmt_separator(fctx);
>                 printf("}\n");
> --
> 2.25.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
