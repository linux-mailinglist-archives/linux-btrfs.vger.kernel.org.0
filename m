Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB7C115427
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 16:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfLFPZK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 10:25:10 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33812 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfLFPZJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 10:25:09 -0500
Received: by mail-ua1-f66.google.com with SMTP id w20so2981949uap.1
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 07:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=muTGlo9cQRFxe6ApxEQVt3EbdQGlv86TRbLwgBhocAk=;
        b=mcscmRdw/HaSRDvSh4d9/XTW1l0aoRwR/TS+oQLEYDHpnSUMgm2eSxjByb8UGFE/bi
         yoViVYAxEUKHlyu8y3gv9NV1VD++TYokwkicmIJuJWe+Q44jNhdGWaVVpPi6tw9zbnqt
         dwK4x8Rb1Rx7Lpx1X8a/OYX3CLHozV+WfbHB+Dx4gXHCqikIp7GOG3uBwyCjh7jiZf5j
         eWPjonWAeU2s/JyLwDHNkTVKua1/4zk1PHFAbKfFsz+bEAY89yF1oecS9Yhcxu4jx55k
         hXlycC7mY0FeW0PAO+D2UYKFXEFmjODXtqSbVFYboFz7h3RP/qK++HpLTVUP0GaCuZw5
         JTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=muTGlo9cQRFxe6ApxEQVt3EbdQGlv86TRbLwgBhocAk=;
        b=dgyhOZPWljfE6QSqy8dlApfEwjAgVr4a0hjpIOtUIUf6V1gX/b7arVBg6wokkpP1/e
         SOusAa9DLxLKEIaLdqmLzaMrEXffDXCJR8VrQQqozV+lRHeA5VYEwbeWNfWtE/4qNhAF
         73M6wOHk25jYi1VNMtpKXvleUPXXq/Najc3lDZFU0aWBGOEVF2hnZBQISpvW0SN0y4xH
         QzjHEdMD7M1IKolFpIXRjcpejo/MJXOmnuLfi/4kZGAvpYqbrGZbrctmDWuLcgnNPTMo
         3GRqLzmR5Da4eK0vjuc8IJCY++8kkagAoL/km/yD4yLewPPQ0VwJWoqugWZWQTomvRgF
         c/og==
X-Gm-Message-State: APjAAAWps5fnEoTdPzcAqZefW9T2i89l0oneH9GCgrSlpGANqNV8kdBq
        jOtLk19pSyVS05tqSc8gb+Kmwd0NcLnuCXvSLfI=
X-Google-Smtp-Source: APXvYqxMQO2TmMEGRkIXv+8VXs50JeF20HCsUhotIrJYJf9Zvpi2nTf4k5BaboNwZKsXde412uMh/RxXP43K4rcGWkU=
X-Received: by 2002:a9f:368f:: with SMTP id p15mr12576152uap.123.1575645908747;
 Fri, 06 Dec 2019 07:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20191206143718.167998-1-josef@toxicpanda.com> <20191206143718.167998-6-josef@toxicpanda.com>
In-Reply-To: <20191206143718.167998-6-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Dec 2019 15:24:57 +0000
Message-ID: <CAL3q7H7dJ3okWO8ymsa_nOTb=9ZE0Wxixn2veSFmMh_rWrNy6A@mail.gmail.com>
Subject: Re: [PATCH 5/5] btrfs: do not leak reloc root if we fail to read the
 fs root
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 6, 2019 at 2:39 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> If we fail to read the fs root corresponding with a reloc root we'll
> just break out and free the reloc roots.  But we remove our current
> reloc_root from this list higher up, which means we'll leak this
> reloc_root.  Fix this by adding ourselves back to the reloc_roots list
> so we are properly cleaned up.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/relocation.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index a857fc8271d2..c5fcddad1c15 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4554,6 +4554,7 @@ int btrfs_recover_relocation(struct btrfs_root *roo=
t)
>                 fs_root =3D read_fs_root(fs_info, reloc_root->root_key.of=
fset);
>                 if (IS_ERR(fs_root)) {
>                         err =3D PTR_ERR(fs_root);
> +                       list_add_tail(&reloc_root->root_list, &reloc_root=
s);
>                         goto out_free;
>                 }
>
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
