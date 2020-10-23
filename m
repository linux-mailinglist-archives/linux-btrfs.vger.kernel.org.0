Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB82297323
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Oct 2020 18:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbgJWQFC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Oct 2020 12:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbgJWQFC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Oct 2020 12:05:02 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA04EC0613CE;
        Fri, 23 Oct 2020 09:05:01 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id m65so1298643qte.11;
        Fri, 23 Oct 2020 09:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=yTCzHYPdYLHi4diF0/ruypHQOAN5hiU4l+mxBwYTpSg=;
        b=U56fv3G986zLG5e6YTDZtvFsFxHixRc94+EX7ZsEXRAC3z32AAxZoAaqmoLSIEtW5d
         lCsaaeLcduBsnkvzq8juEGN3qh8aBqgAYcRuI24GeU2LB8DutntYr+bWqBdo0Ypb6Q6r
         P6xn8Gicjo1EMABvneLbcnud4Qkgr63VoxITmCtRaVCnR4ELkFxydi+iRqLV8d234zL7
         erwF8Z8rymec75UNTMCP6UYHlbVIqASlRmip7Od+zj/J+mf+xnGGkQf832/SHkAXiFN+
         A5CEMpPNB4AvrSDkCdrDRbLDd0r4fbd4G46MaTlADVqf0rI5spRc1v08/wLhTQ57KHg0
         5bcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=yTCzHYPdYLHi4diF0/ruypHQOAN5hiU4l+mxBwYTpSg=;
        b=RO33nDhmvqX4ctbastTvks+Uew/7EC3RN1EKbLg2eWPYvmgTy0Gc4BgJ1G6AlVabsV
         AKCuVM2/Rd5jO6VtEabFNj3lJhIrZKU0dt+ZFFErlhaV/DGz0bNSAqh7AXyz0/lSLY0s
         FSjoJ4M7PulyIIC4390BMQO2FPQ4gxMUxNlc5ozrY1ez8WlyJW+xjtQe4lGRb18eI9/b
         GuDJAIL21LzGnUWm89yf+9i6sWpJqmdKmwcl8FNStSuxVH2J9z1V+xfISFJWzCVTYSaP
         hJlPhHWopVo1SmZgoyVLJyZY3CQbi8kWJqhB7AIdZL2IZY/iOQht5qxDkdj4dlFFA4Fa
         j2Wg==
X-Gm-Message-State: AOAM530tDa366TngHgqE411t8XD3nuWZ7K4m5U2B1eVR0aWyepYngwo5
        js1TQSOuzs/STYK2DdrQ+AoxwYJGnGywrdWwWAF9h3VeduM=
X-Google-Smtp-Source: ABdhPJzpRQW5DDJGHG/Fp9yI6f+o6nmwgmeJ3Jitcvck408lzBuKltxIzRLXkssn7z8h89qEacwk572MReQubQ+nemQ=
X-Received: by 2002:ac8:5743:: with SMTP id 3mr2932690qtx.259.1603469101013;
 Fri, 23 Oct 2020 09:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201022184924.42kt4pqgngfclc6x@fiona>
In-Reply-To: <20201022184924.42kt4pqgngfclc6x@fiona>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 23 Oct 2020 17:04:49 +0100
Message-ID: <CAL3q7H6=7Wm5Zw=M5huUthtG-NDMbjxTqHkf3u9st-8wuxK5eg@mail.gmail.com>
Subject: Re: [PATCH] common/config: Allow environment defined btrfs mkfs options
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 22, 2020 at 7:52 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
>
> btrfs does not have options of defining mkfs options via the
> environment. Use BTRFS_MKFS_OPTIONS environment variable to set
> MKFS_OPTIONS for btrfs.
>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Looks good,

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Since this is btrfs specific, in the future please cc the btrfs
mailing list as well.
Thanks.

> ---
>  common/config | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/common/config b/common/config
> index 285b7d1f..d83dfb28 100644
> --- a/common/config
> +++ b/common/config
> @@ -410,6 +410,9 @@ _mkfs_opts()
>         f2fs)
>                 export MKFS_OPTIONS=3D"$F2FS_MKFS_OPTIONS"
>                 ;;
> +       btrfs)
> +               export MKFS_OPTIONS=3D"$BTRFS_MKFS_OPTIONS"
> +               ;;
>         *)
>                 ;;
>         esac
> --
> 2.26.2



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
