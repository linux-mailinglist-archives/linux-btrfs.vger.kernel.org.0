Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C155023B991
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Aug 2020 13:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgHDLcg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Aug 2020 07:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgHDLcf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Aug 2020 07:32:35 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDADFC06174A
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Aug 2020 04:32:35 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id v6so26541046iow.11
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Aug 2020 04:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lV9N3W3zCZBwd5dy17yoRjtU3yepruhD7KppPpZZS5k=;
        b=GkIjWLqfi1OLL4R1hyGo6A3u6mAB2jKy0Nyj11e/9QkNCNX831qpJzhiDpsEOZVJdN
         jaUXiJOv+n7f+TjvcHsiixCDF/mEXlcpPA2AWVf41826c/kdamPpzeSzXZoeEKDno9bw
         NcpxO3XLBvlasZm9kBVf8wcUAUSZH41jo8+go39TpZvg5823DPS1+z1+N3cw+/obmu6F
         yagoAW3WRY8scqP8mlX0iGWaV+myD2q9pHdQbsA71048zEWpvsMOQB33HGv6DCXOPgss
         riDVPC2OEtBzDbgR96fMIQ3j7gu0KhjIS7pg/xyFnWPu7sUTMloWvBOMyKVl/H0wTXdG
         xLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lV9N3W3zCZBwd5dy17yoRjtU3yepruhD7KppPpZZS5k=;
        b=M9c2JsosOEYc6JgVF4QTH8/O8jWIGxZltZ9OANr306kIY74tMLDRbFK7L1xV1aYiNG
         JYTqGPz90Fc/yDMhIZ2NJqIpuo9d5+khCdiVab2UYG55F/d3sC/fNhcA2ChS6VoaYiqc
         2J7DK+MWiVFb5vhmqni9I/rumxSwMdELfI0IisiozlUqzEcIJW/0NeVTGe1rB6/wCMim
         NLR3lNTp6pJQaxASk0nclkGkqJl4bdqtUBcr+kOaX4udhm63js75SQaGVRQhh3m8Nv70
         hwXed2NlR6tTBTu57YXND1xtGqPeoLhcTrXG8XzFjWhoZJ7T3evm2TsyMwgvvnKRk8Po
         kLrQ==
X-Gm-Message-State: AOAM533nAiC8k0v62qc8XYWvXLtE19UnhCbF92AQ1zvwz+XuQghdHWVO
        c8PNxTI2wVkXHstO0x5mlPOWFQQZ2aCxVnL5/70HUyhl
X-Google-Smtp-Source: ABdhPJzNavejxY3guz20JyLLTj0tk5dWtgFZXFVUFgAI5VjFE2XReDt7SArhRFGFU/YV40QaHnIXdjts2oAPcrMTqBU=
X-Received: by 2002:a02:84c1:: with SMTP id f59mr5294114jai.106.1596540755073;
 Tue, 04 Aug 2020 04:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200803042944.26465-1-marcos@mpdesouza.com>
In-Reply-To: <20200803042944.26465-1-marcos@mpdesouza.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Tue, 4 Aug 2020 07:31:59 -0400
Message-ID: <CAEg-Je_kW2q67dFqKNtCgm3DNySHZ3XFiz8Z++RUh0Bhur_SKg@mail.gmail.com>
Subject: Re: [PATCH btrfs-progs] Documentation: btrfs-man5: Remove nonexistent
 nousebackuproot option
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>
Cc:     David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 3, 2020 at 1:05 AM Marcos Paulo de Souza
<marcos@mpdesouza.com> wrote:
>
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>
> Since it's inclusion in b3751c131 ("btrfs-progs: docs: update
> btrfs-man5"), this option was never available in kernel, we can only
> enable this option using usebackuproot.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  Documentation/btrfs-man5.asciidoc | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/btrfs-man5.asciidoc b/Documentation/btrfs-man5=
.asciidoc
> index 064312ed..2edf721c 100644
> --- a/Documentation/btrfs-man5.asciidoc
> +++ b/Documentation/btrfs-man5.asciidoc
> @@ -471,7 +471,6 @@ The tree log could contain new files/directories, the=
se would not exist on
>  a mounted filesystem if the log is not replayed.
>
>  *usebackuproot*::
> -*nousebackuproot*::
>  (since: 4.6, default: off)
>  +
>  Enable autorecovery attempts if a bad tree root is found at mount time.
> --
> 2.27.0
>

Reviewed-by: Neal Gompa <ngompa13@gmail.com>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
