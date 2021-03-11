Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C8B337D85
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 20:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhCKTTS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 14:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhCKTTM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 14:19:12 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DCCC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 11:19:12 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id n195so22829627ybg.9
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 11:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H9Y7Lbqfgr33wai0OtzDfyVvAmAQ9+GL/hqzSldrjPE=;
        b=HcA4cWy3X3pIPyG6gb8CNnoiSohGy7oNRWUl5Hex66X+QuHUsPqYnpz3IN6hR5YIXi
         FkzqRN2guY4J+eSeltG89+WKvdiWZi53/f4b4zNQZimaiPfcmVnSIsPpiqwb38lN76TW
         miluGqKyxLLM2mqfBMLv9tAjr8F/xkKB2DjgXS290R8m/g+YhPvBQ7aqhGghFrMOz8Nt
         g2N0qclNHHGk9VhlYAgMZ9LcM1JZ0GAeoLLIuiGNP4bhbBD3XOWNR+Lo3DTACyWVHBpD
         3Aiv5+1zZ2lwWXU5RRYhCcFZZ3gwZm+6H1vyfXnWcJW1g+oxVwlgciYeO38zMb6q6kAE
         cgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H9Y7Lbqfgr33wai0OtzDfyVvAmAQ9+GL/hqzSldrjPE=;
        b=hxN4RvLkMQCCYrJ5cBxmQPvoVMp3XxsNiXy05BASDj+OZxCY24koBkffEE2Tjb9GFn
         2cEPLksQWnZYewjvQamlJsfJfTtzhy4WxFo7v7kPzjP+AW2PQPEQaYF26SzBhmcf9l48
         bs1ZKbGs99r6JxaY9wDhS6EXJziK6hadRBYH+6D9n/0KEfzZK6NnhD/JBblY8Lya8yHd
         M2HbJT4JNtVbg/QOrILgOywoCfhDAhYrQmj2BMNxuWIgtx2R0txPGmMebDCL9gFoFbKb
         2VcqOG6eUsqcOIIwyU8aj0q4/LOyIYVpP+k8KKIBaJBNCX20h7Bvs464McTIl8QMZawg
         1BfA==
X-Gm-Message-State: AOAM53321vyW5N4+4JH9GJJtzAmNW+Sv9zYQTSchMQVrgeYmfQgNpYMT
        5aVEP7hIJPjbf1Bo9vuGZlMZO2gra6h1aNxGr9g=
X-Google-Smtp-Source: ABdhPJxMpgiD6/FJYuK+rAYAjW2FCQxNUWOGn0D2ZuZgAw/pJ8WVJAKRtIpdd5amkAZ6PZOfAjEgfx4g2xJwlQRmlws=
X-Received: by 2002:a25:c60c:: with SMTP id k12mr13742054ybf.59.1615490351429;
 Thu, 11 Mar 2021 11:19:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1615479658.git.josef@toxicpanda.com>
In-Reply-To: <cover.1615479658.git.josef@toxicpanda.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Thu, 11 Mar 2021 14:18:35 -0500
Message-ID: <CAEg-Je-8nu2AJmaBy_FWEPVJku_D0qif3fQ2ZQJLbVjEmdGYXA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Handle bad dev_root properly with rescue=all
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 11, 2021 at 11:25 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Hello,
>
> My recent debugging session with Neal's broken filesystem uncovered a gla=
ring
> hole in my rescue=3Dall patches, they don't deal with a NULL dev_root pro=
perly.
> In testing I only ever tested corrupting the extent tree or the csum tree=
, since
> those are the most problematic.  The following 3 fixes allowed Neal to ge=
t
> rescue=3Dall working without panicing the machine, and I verified everyth=
ing by
> using btrfs-corrupt-block to corrupt a dev root of a file system.  Thanks=
,
>
> Josef
>
> Josef Bacik (3):
>   btrfs: init devices always
>   btrfs: do not init dev stats if we have no dev_root
>   btrfs: don't init dev replace for bad dev root
>
>  fs/btrfs/dev-replace.c | 3 +++
>  fs/btrfs/disk-io.c     | 2 +-
>  fs/btrfs/volumes.c     | 3 +++
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> --
> 2.26.2
>

I'm very happy that my freak disk controller issue yielded some good
fixes for Btrfs rescue mode code. :)

Reviewed-by: Neal Gompa <ngompa13@gmail.com>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
