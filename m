Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFC44123374
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 18:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfLQRZD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 12:25:03 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36821 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfLQRZC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 12:25:02 -0500
Received: by mail-vs1-f65.google.com with SMTP id u14so2997355vsu.3;
        Tue, 17 Dec 2019 09:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=YR0TrjMy/QDn2raZ9wU9QOuPVU0wjj7bHsjH10hwvFA=;
        b=G+rxd+Ou9B5L7sBCpsHc3jNvMIpiQsarlYED2oa0lGmVt3A77yNzFYF/e7B36Iz17L
         N0qK1xuZr5bReIA24FCsmfHEnK15/t29+cyJwjiTXgFGBgib7zyyWhlzJzc329c9wtgS
         yGPvtA0CwpG2tGG7nsJ5RF/sEgj1sGVr78QSWJ6iPE4W4qkzFfgx+Wo6OTfyKjP73wjr
         BSl4/gU02SYwzEownAQx++Y7ip+6sehQtR3kT9q+gsqhrqRJEAOyY6X20NbPSvOldcMd
         rUU98S0dOS8bmi5RVPLtRdtw/FXnqGePQSw052yl9ZEt8nWQ1qH/EYUSp+ivxecT6iKa
         8gLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=YR0TrjMy/QDn2raZ9wU9QOuPVU0wjj7bHsjH10hwvFA=;
        b=hKz388F6wHqXw7NN4Oo5IBe5WOoVikmgblaj9eGW3O+jD7YTykE+HKnLefptZzIHit
         LV6NaKxw007adWdtgHiPV2kw3BeeKn5R+G3DO7KvXPgHMG+qFRyhhqeL9g6PqR0R+u98
         NEOIdq9PuWeYv1HzTPhErDO3lIcWqUCFoM2wlrxhMpQi4qgVs0LyDM8V+sgN39WyBCRb
         xVVyLSCe9SfENPVVhRP27EoNctYmOFmYzIyjMxQubX5pEfaPPNKz53lsNe6AvMvXh6tk
         zUqWyqzp8o/EMRLs1O0OPR8mviL3LlhfWyuwJsBBOC1pyuCaiA9Z8gd8gqLuLjAVKnqj
         guVQ==
X-Gm-Message-State: APjAAAUvGITRGCf1P64+ETIWg7bCM6FWPWOEHKc7/vplzB0pi4TFpWCb
        4o7gt90zPQvSaN1RJROY04R9U75llL4OMI2KqK7FFA==
X-Google-Smtp-Source: APXvYqxlqqprqefLgnhBkSdRxbyYQhfXvNOH2KdF0C6EZUbxXUPoBY6KnYawDflSGTiQdc76Z8mrBHLOKlaVmdWSg4o=
X-Received: by 2002:a67:8010:: with SMTP id b16mr3590765vsd.90.1576603500997;
 Tue, 17 Dec 2019 09:25:00 -0800 (PST)
MIME-Version: 1.0
References: <20191211104029.25541-1-wqu@suse.com> <20191211104029.25541-2-wqu@suse.com>
In-Reply-To: <20191211104029.25541-2-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 17 Dec 2019 17:24:50 +0000
Message-ID: <CAL3q7H50wBGvT1dVFh0MSZ7V=690Eek86pYq_ct2CN2aViGFHg@mail.gmail.com>
Subject: Re: [PATCH 1/3] fstests: common: Use more accurate kernel config for _require_fail_make_request
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 11, 2019 at 10:40 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Just enabling CONFIG_FAIL_MAKE_REQUEST will not fulfill
> _require_fail_make_request.
>
> It's CONFIG_FAULT_INJECTION_DEBUG_FS.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/rc b/common/rc
> index 5cdd829b..2d72f158 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2357,7 +2357,7 @@ _require_fail_make_request()
>  {
>      [ -f "$DEBUGFS_MNT/fail_make_request/probability" ] \
>         || _notrun "$DEBUGFS_MNT/fail_make_request \
> - not found. Seems that CONFIG_FAIL_MAKE_REQUEST kernel config option not=
 enabled"
> + not found. Seems that CONFIG_FAULT_INJECTION_DEBUG_FS kernel config opt=
ion not enabled"
>  }
>
>  # Disable extent zeroing for ext4 on the given device
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
