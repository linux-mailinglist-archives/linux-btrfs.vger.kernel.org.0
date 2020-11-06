Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21ABE2A95CF
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 12:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgKFLyK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 06:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgKFLyK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 06:54:10 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D118C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 03:54:10 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id h12so512627qtc.9
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 03:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=u82o8Dc9k74OlZWM4Bt77lqHCnUR+XanSkFm8dXDvGA=;
        b=KPY/rw3KeK31pYFCoM1G40uoGsxl9CgDUggLyfQ05wUzrtAUXfPa1ZCgqu1IWTM4Ot
         GfstoJY2Pq1SWJnE544rcAk4TsLMBQtgD2T5BUeBLL99h1FNdK75ZqLfLXVPmmnb6o2B
         cLoCkLnwIUUjHZ8ng+Sp+/TB6+slIQ8ZwTwFkgDZ+814AUL6z7gx9DCZTPNhf+W5VTwN
         v8KzpE5gV0ecmqQWzVSVrVWIEGoQiFylnidlXTa6mL57x7dWl0iE++GkwaaWo9CBGvgQ
         orQtqW/JEGpjypMgPDF8CyN+Jr/ROIwDqno7RQ/dV6HEslp2H49Ldgl4aRDtWBGqtTM7
         xYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=u82o8Dc9k74OlZWM4Bt77lqHCnUR+XanSkFm8dXDvGA=;
        b=ISfJS1u3SVea4ra4ty/FFGjGUeHMegQYGoU6wnCUaDnDFIdBO4ReApAtG0NPAUevKX
         D1MA+hF2GC4pcHQCSOtH3rOzWUy/hLX/0qPcXW3IZ/w4d7vTV+Bsd8LWshVUH3pl8y80
         5vRmof/WJEZ6Kj9fqF1guYFp+BL96y6M8t9ANM6NeVTFdCzpZz3QlA1HeIncoX/RbwMB
         X7mUWZAsemhRCf00wzlLKK1IDr0or8oQWyugOTdN/KgtaFgkpBwCn10ZtTW7V7RcKMil
         0LC+7w0FVBooEAb293Fqc/Hxw6eCaKW4VJqp17TdMERL2zK4RsCP5lOIoxUma50CXqc5
         ntLw==
X-Gm-Message-State: AOAM531OoutqxdHChyF5LgLv2gIVTsCCdpeRuEzx5/DqXDXvLy+TCXto
        eGd30vRmUqyutuHPzTU29uiRyQoJSa3uVTsYIVlNXAynk58=
X-Google-Smtp-Source: ABdhPJyApX6vh9zcUEtzQbR7Drzs74zj5xuS903tJNQjyXcliaJ0bRHrECrkhPA8PRDneh865T1GgbFmoB681Ht5hyM=
X-Received: by 2002:ac8:5942:: with SMTP id 2mr1058131qtz.183.1604663649418;
 Fri, 06 Nov 2020 03:54:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604591048.git.josef@toxicpanda.com> <96eb2106d6b5518d4c5db34aec50d12860d702e7.1604591048.git.josef@toxicpanda.com>
In-Reply-To: <96eb2106d6b5518d4c5db34aec50d12860d702e7.1604591048.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Nov 2020 11:53:58 +0000
Message-ID: <CAL3q7H7XgV3evbMYSut7CdPmO0UkfFw_nN+-0E8YuFUYtiSH7g@mail.gmail.com>
Subject: Re: [PATCH 08/14] btrfs: use btrfs_read_node_slot in qgroup_trace_extent_swap
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 5, 2020 at 3:47 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> We're open-coding btrfs_read_node_slot() here, replace with the helper.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

I couldn't get anymore the lockdep splat I reported before (after
applying the whole patchset of course), it used to happen very often
with btrfs/033.

Looks good, thanks.

> ---
>  fs/btrfs/qgroup.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 717b1a6e13a6..21e42d8ec78e 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1892,27 +1892,16 @@ static int qgroup_trace_extent_swap(struct btrfs_=
trans_handle* trans,
>                 struct btrfs_key dst_key;
>
>                 if (src_path->nodes[cur_level] =3D=3D NULL) {
> -                       struct btrfs_key first_key;
>                         struct extent_buffer *eb;
>                         int parent_slot;
> -                       u64 child_gen;
> -                       u64 child_bytenr;
>
>                         eb =3D src_path->nodes[cur_level + 1];
>                         parent_slot =3D src_path->slots[cur_level + 1];
> -                       child_bytenr =3D btrfs_node_blockptr(eb, parent_s=
lot);
> -                       child_gen =3D btrfs_node_ptr_generation(eb, paren=
t_slot);
> -                       btrfs_node_key_to_cpu(eb, &first_key, parent_slot=
);
>
> -                       eb =3D read_tree_block(fs_info, child_bytenr, chi=
ld_gen,
> -                                            cur_level, &first_key);
> +                       eb =3D btrfs_read_node_slot(eb, parent_slot);
>                         if (IS_ERR(eb)) {
>                                 ret =3D PTR_ERR(eb);
>                                 goto out;
> -                       } else if (!extent_buffer_uptodate(eb)) {
> -                               free_extent_buffer(eb);
> -                               ret =3D -EIO;
> -                               goto out;
>                         }
>
>                         src_path->nodes[cur_level] =3D eb;
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
