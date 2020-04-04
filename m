Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3AD19E532
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Apr 2020 15:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgDDN3f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Apr 2020 09:29:35 -0400
Received: from mail-qv1-f51.google.com ([209.85.219.51]:41643 "EHLO
        mail-qv1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDDN3f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Apr 2020 09:29:35 -0400
Received: by mail-qv1-f51.google.com with SMTP id t4so5071575qvz.8
        for <linux-btrfs@vger.kernel.org>; Sat, 04 Apr 2020 06:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nbkdf84tQvNRzSn27OvC7yhmR9FLcyTWMvyRQOlyCc8=;
        b=GNKJdlnzJMuXtrNlUu7cEKP0CTbESQFlgjhlHTBDxsbkRL6AZnWRR2UjtaLlof6utq
         gtqkI3G8TU960+pWbEGqvqAvLR/h0dNdTOE4t+/NJHHZEE1Ohrrusegq6LBom13XoIVo
         yPQNcuSeB0VN+4wlbP/H39AvsB/J42t6GjD6yOrfoi1SFsc5oubwehpdN/a5jaeWS6lG
         gjyqc+DC77OEJrb/GW3GDgoZdQennfGK+u0k+ZozXYSx9hKfZbW1vjXAnnVRwh8O+a0S
         6zaBdOj2cKwSyN/mpmNxTua2IgCCmvEKeEu5XNp8P4PmtLxo3RJTIKXdMVQ94me7+8zn
         FkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nbkdf84tQvNRzSn27OvC7yhmR9FLcyTWMvyRQOlyCc8=;
        b=mLtFGxG5JPjl1Wy9XO1V8bPvnJ+O7QV8NykHBkXfm7Rv+4t51QpvQAnwWIYeQliOc5
         Hx54ZemqpJzRKWIOXRrb8Uv4cTsO1lMZfcOQQbsDM5e/aFuxy8U9RnohU4nWrFFCQxK/
         hZ+puCC918sibIliUe/gHRTD3ny/aq6wqYq36cpxl9YWUT6Vdhp+IhSparoBfjXQPoh5
         6LPg0Av+4E0CAzxEyQmlUVhWxe51ARmIili5bJueCZ0YJg6wJLQXtpdNa+/VPbcBgBfT
         aMV5SaWqUvw3aAGLjkHfT5f8l5wmtpishUg9Ig4bNQXznMBmC4EXWxaj2MnsA9HQAS6H
         9ttA==
X-Gm-Message-State: AGi0Pub+jDRLzz2qDwu3779WqZbXXfZQekhDk8ABJJ8jFY81H203zFr2
        p9R/y5oj0/oW18MUghQKInZ2/8dbeM+P9cYppUT1S3lB
X-Google-Smtp-Source: APiQypJHYK0hKy3uVtYs8JenP1mdFMv6LPBeEnJkN0O5xPaLT6FtsZPzcyQQCiArf9xFZrwcIf8WyE72sc5mH+3f9eo=
X-Received: by 2002:a0c:9aea:: with SMTP id k42mr12808824qvf.91.1586006974218;
 Sat, 04 Apr 2020 06:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200331212850.17871-1-dsterba@suse.com>
In-Reply-To: <20200331212850.17871-1-dsterba@suse.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Sat, 4 Apr 2020 09:28:58 -0400
Message-ID: <CAEg-Je8qbqKnznfL78bWc+oyvCBFDANqbp+jYHMcTmgi+SUfNw@mail.gmail.com>
Subject: Re: Btrfs progs pre-release 5.6-rc1
To:     David Sterba <dsterba@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 31, 2020 at 5:29 PM David Sterba <dsterba@suse.com> wrote:
>
> Hi,
>
> this is a pre-release of btrfs-progs, 5.6-rc1.
>
> The proper release is scheduled to the next Friday, +4 days (2020-04-03).
>

Did something come up that prevented this release? I was planning on
landing btrfs-progs 5.6 in Fedora so that it'd be part of Fedora 32
Final along with kernel 5.6. Could a release go out so that I can get
it in by Monday at 5pm ET?


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
