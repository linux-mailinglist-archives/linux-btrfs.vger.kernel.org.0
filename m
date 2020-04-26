Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E6A1B90BF
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Apr 2020 15:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgDZNyq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Apr 2020 09:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgDZNyq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Apr 2020 09:54:46 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2203C061A0F
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Apr 2020 06:54:45 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id e17so8642252qtp.7
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Apr 2020 06:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=CPS1qe/syAqQ7n3ofZgL9EnuUUhmHXAQsd0xbvpYWp8=;
        b=XvFamCiaN1tNSLNxAqdiQ3ZQ4fgEQvw6uIVYvpkFB5jD5nCeHOsXJqXSLTiAIsUsHi
         Gl3CeQJ47aisYrwXJlU8LyZ+iP7fTvULkknEE9Y5xoVlK21Z0jAdbai1g0BibEFPpDX7
         r/7P5orAj4lWXFmy7P6dNdVgfkuSUR2yVvF9SIDd5zeqAFZ8Krc5Fh2fN03hyLII9pju
         uVleeSpuFdh82J9fywBRmJurC18Zwm6xUculyiok0o9pUriDjKlzGebXAyWtRT+1fdde
         Y2oziMq9YLt0+lKFJcdlJh11P3GJeTqzK4Z/qkSCuFNWP2SR41vb/EbiYXqycOWDtXlk
         he/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=CPS1qe/syAqQ7n3ofZgL9EnuUUhmHXAQsd0xbvpYWp8=;
        b=IFKA+b1JiX75ZS/nq+23KvPhxAMnOPtMVO20dPerDZgi3/YwGoQC0RgEUVAkfKKVfO
         3HeVBK4B4flfKUe/LxKjPeeKnVLcur/PcHmLRI5oybA8weS2VbrhMF+4nBFyZ9mLEEAv
         uKDzDqcBKiPhAwIOS/s7XAmTy+LGRJFKmy6fS48jfZOEXim2d3dXse43Lp+gSmWExkPF
         zb5hw5TenPei2FaORvCedZPkNvcEiEJuVFl6+IDuP3X8m77+/iPIRhkaKb2k0wDpL8ih
         13KnUARoMBT3SGAYzjHwe4EbbZVX++HahAtTYjTvPz6zHltdEeCUJrAYY2P9duqCoxEO
         O68Q==
X-Gm-Message-State: AGi0PuaZqqHK1MlYSJm2WJivhZnlj8rXQCqL+ao8ZUoC18VmfDIkTNHP
        UOem+sgL9VeH6nMCLGpyHOa1J+twvRBHN4BQIDSse2L5Vv0=
X-Google-Smtp-Source: APiQypKknDQRxjvdN4WxBV7E634Sb0SX8RRdZh3bsxGL2DXyCRv/ksbvk1OiEdsh7QAUTOxcoS2xpU925ZpR4JFqVnk=
X-Received: by 2002:ac8:2a70:: with SMTP id l45mr19015442qtl.232.1587909284466;
 Sun, 26 Apr 2020 06:54:44 -0700 (PDT)
MIME-Version: 1.0
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Sun, 26 Apr 2020 09:54:08 -0400
Message-ID: <CAEg-Je8zM4xq7GEG+cphKkR6wjquwG3jv9bbJ88chzrZUEzuYg@mail.gmail.com>
Subject: Btrfs native encryption
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Mark Harmstone <mark@harmstone.com>,
        Chris Murphy <lists@colorremedies.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey,

I was looking into encryption in filesystems (for supporting sane full
disk encryption), and I noticed that there was some work last year on
this: https://lore.kernel.org/linux-btrfs/20190109012701.26441-1-mark@harms=
tone.com/

What is the current state of this work? Is it just the same as back
then, or has there been changes?

Best regards,
Neal

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
