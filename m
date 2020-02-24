Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA8016A8D0
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 15:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbgBXOu7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 09:50:59 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:40165 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbgBXOu7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 09:50:59 -0500
Received: by mail-vk1-f194.google.com with SMTP id c129so2549892vkh.7
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Feb 2020 06:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=6Jqf4au/i5XljKZI5LwrDda2/XGSVf52mThr/63V0kQ=;
        b=QqDL1DBbMHqQQVSy+vxxKMM2nnb6jaIUYXE/b4cYw8bTZX9/E383peMT+UJAFsJwQZ
         xldnuCoeq2/OOs0AG9HC0TXP+kS5QBbMDqpUpyH5/z5KeF61gYbAUHsB4keey6YZ8OE0
         tPwkz3S5gyehqEry9MVrvXBHaYME3HebcaD8xEGAQBSLV8FzxoooK15go5hKGjS4HSkK
         YkU74qwT5Hhob0hhzVNs4geTyvsm4sv4WX0z//7oNB6R2XX/jwNN+dbkdyWApY9fKavg
         l+qxNYieNtCAj4Oj54dTY9fInXONFyv0P+uOOJP9+yVb/WJWgCmy0FuU0CeDNfpfthL0
         MaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=6Jqf4au/i5XljKZI5LwrDda2/XGSVf52mThr/63V0kQ=;
        b=ZUxfmXG4cd77vNNxHwI+IRxGsLFmenkYz6OjiR9ryTmfLMu+6dJI7Va4qcV65JSQcs
         cgrE77yfMsV93EoC2E9o3la6ddXPTLRn4kJws7vn8UTC1VUARNKEKqjPkvSHvvK2sj3f
         P+32xEWUUcdW4gOONKm6V5Tb4iNEt527uXMxSzpWZC043h3n+MNN6Qk9+Ag2wIHOF34/
         kQqdGemXUuYTfAsu597Y3oN/uKxY7YLdZiNdKuJRimcPoXC6oDMHsgwGmAqnMgo5dz5B
         82hiidF/e5V9jN0wD9mwYk0kxLIsnzyyKPySe/PZpRr1OGsvii0NbpUxeioaDv67q62W
         ZH+g==
X-Gm-Message-State: APjAAAXV+BNo9xaHMDgvYjjK0OazMzeevZC6gd9sQNm+09nexo69WMsS
        s6IVTZjxLkuGNTMiEDXK+KnCcNND4NF82SfDwKwJ4EA4
X-Google-Smtp-Source: APXvYqzu9eFj4Bei53uhrQy5PQ9o1aRIHXJcp4WepUlEMLkftAb9X5hi7x3Xxoo+Xg1KyYQdrvbZWG+66RQUuoSprRw=
X-Received: by 2002:a1f:170c:: with SMTP id 12mr6262509vkx.24.1582555858356;
 Mon, 24 Feb 2020 06:50:58 -0800 (PST)
MIME-Version: 1.0
References: <e52e68aa-1ad5-b186-395a-6559e3212fd3@hale.ee>
In-Reply-To: <e52e68aa-1ad5-b186-395a-6559e3212fd3@hale.ee>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 24 Feb 2020 14:50:46 +0000
Message-ID: <CAL3q7H73VL=Rh4ate0TApDJWgkHhJGxy1ibNQVUQEoWCQ_vWvg@mail.gmail.com>
Subject: Re: Reproducable un-receive-able snapshot send
To:     Tom Hale <tom@hale.ee>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 24, 2020 at 2:20 PM Tom Hale <tom@hale.ee> wrote:
>
> Would anyone be interested in helping me debug:
>
> * btrfs-progs v5.4
>
> * A FS which is reported as OK by 'scrub'
>
> * A parent and child snapshot combination which cannot be received -
> even on the same FS it was sent from. (In fact, many children cannot be
> received based on the one parent)
>
> * Send aborts with this message:
> ERROR: cannot open
> /media/ssd/btrbk/rootfs/TEST/rootfs.20200126T0000/o3658332-53841-0: No
> such file or directory
>
> * Lots of directories (not created by me) in the "root" of the partially
> received subvolume named such as:
> o1101063-3046-0
> o1194908-3075-0
> o127448-2877-0
> o127454-2877-0
> o127714-2877-0
> o128369-2877-0
> o1305760-3109-0
>
> If so, please give me directions / point me at resources to gather
> information for you :)

So, first thing to try:

Get btrfs-progs' source and apply the following patch:

https://patchwork.kernel.org/patch/11053327/

See first if it works after that.

If not, try to provide the full output of receive with "-vv" argument,
so that it dumps the sequence of commands it's executed. That may or
may not be enough the figure out why the problem happens.

Thanks.



>
> [Please reply-all - I'm  not on-list]
>
> --
> Tom Hale



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
