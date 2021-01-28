Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4E930754D
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jan 2021 12:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhA1L5o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jan 2021 06:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhA1L5n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jan 2021 06:57:43 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4087CC061573
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jan 2021 03:57:03 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id v3so3828238qtw.4
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jan 2021 03:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=d2CVxSRpD9O/ECFMDpw/eF57daE7LflIYe5NRsS7Spc=;
        b=GPViY9DgAgXeVHlp9dzYhIUmySt0UT6IFHHVaxeP8Fwj5RuOYiJiIW8tt6H8NCHxff
         ZrBoIcb3wV+rKq0D8FDH/tBrZfT1ryVNN3Os2NHQBeXkjg8pVOGpSd3iHzHN10WZo6pO
         CCqQApVMAfhJBAVB6IcxDcJR9q6k7b/2Ahxtm6UIrOJ7LsSLVbyo7m0s4S82j5HOS7B8
         NMhVpSbEUTEYmDLbklPHNMa+DHO7I77mVYsJ5VA6Mb3zZtbqaxSBA51LXwxcz0ns6AYf
         Hqlzgv0xVoWF0NzyH6qgzvBPS7Xzf+9Uj9N7b/sYrxFnHuwxKrUtJ3ANkcFxmqd9uQSN
         4QeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=d2CVxSRpD9O/ECFMDpw/eF57daE7LflIYe5NRsS7Spc=;
        b=Uz1GL3CftdqdzoLyOMDowV1K4f02iwuyRZrXp1DwJF9H/S6oe2PrTz/PEoVD3UpmxW
         eiWWM5iILh0ZepUJQ7D+2xnEmoIQZPCzAwU3HiH3Oid6QOQ/wsv8wAIS0SGH0hdKCFzq
         rX/PVyK2A1vnFW0W1E12LPC6CR/clYzzZFPU2+5+hzzMbaIl68p7ot9A9y7fSV4Azopa
         qPB1XDfeGpnX2ooAS3RgiTPzP6OnwIrbh1xTfMsn+ssrHk+6UwAeM9rVYSiAtEEw8FO6
         vOExDMkXhQzYC8Nn3S7GF7A/Symr591eSe/oiiS07EOnL69LKSJZpVPqGRn+Iv7ekelM
         J3fQ==
X-Gm-Message-State: AOAM531j627Xls7eiL1CRnlDwion9ElZdpEcUXXlUiIoRVAXk7/j2IS7
        I8yq3hhz/Z2VhHk9CDMUeqGHEluIlW3UbuyP+ekqEbuwRzE=
X-Google-Smtp-Source: ABdhPJz73Zj8vKdsdBZ22OuNEFSvV86OLTtKoIVTXuWPB6MtnjjJocI5ohqzpGdt9RrvIq3Is7cuxRyxJ9CfSkrtEko=
X-Received: by 2002:ac8:7762:: with SMTP id h2mr13811037qtu.259.1611835022378;
 Thu, 28 Jan 2021 03:57:02 -0800 (PST)
MIME-Version: 1.0
References: <20210128112508.123614-1-wqu@suse.com>
In-Reply-To: <20210128112508.123614-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 28 Jan 2021 11:56:51 +0000
Message-ID: <CAL3q7H7EKXEroFBV-FVk0y-+fxqS72bJT_fcGiZd6=Fa8sA6pw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add comment on why we can return 0 if we failed to
 atomically lock the page in read_extent_buffer_pages()
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 28, 2021 at 11:29 AM Qu Wenruo <wqu@suse.com> wrote:
>
> In read_extent_buffer_pages(), if we failed to lock the page atomically,
> we just exit with return value 0.
>
> This is pretty counter-intuitive, as normally if we can't lock what we
> need, we would return something like -EAGAIN.
>
> But the that return hides under (wait =3D=3D WAIT_NONE) branch, which onl=
y
> get triggered for readahead.
>
> And for readahead, if we failed to lock the page, it means the extent
> buffer is either being read by other thread, or has been read and is
> under modification.
> Either way the eb will or has been cached, thus readahead has no need to
> wait for it.
>
> This patch will add extra comment on this counter-intuitive behavior.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/extent_io.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 7f689ad7709c..038adc423454 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5577,6 +5577,13 @@ int read_extent_buffer_pages(struct extent_buffer =
*eb, int wait, int mirror_num)
>         for (i =3D 0; i < num_pages; i++) {
>                 page =3D eb->pages[i];
>                 if (wait =3D=3D WAIT_NONE) {
> +                       /*
> +                        * WAIT_NONE is only utilized by readahead. If we=
 can't
> +                        * acquire the lock atomically it means either th=
e eb
> +                        * is being read out or under modification.
> +                        * Either way the eb will be or has been cached,
> +                        * readahead can exit safely.
> +                        */
>                         if (!trylock_page(page))
>                                 goto unlock_exit;
>                 } else {
> --
> 2.30.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
