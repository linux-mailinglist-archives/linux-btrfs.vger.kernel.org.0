Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDD42836D
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2019 18:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbfEWQYm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 May 2019 12:24:42 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:37911 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731207AbfEWQYm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 May 2019 12:24:42 -0400
Received: by mail-lf1-f44.google.com with SMTP id y19so4863697lfy.5
        for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2019 09:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hODQoQ2qyWAbyJwliLkBJvyeW+loPpahssLQ9Pq3n84=;
        b=j3hIUr2N37Syxml0rPMe/PMczUT3InbtomSqkKbu7cXmLxqAArarq8vjka9h8XfYsA
         pKZHr4CXSbu16nkZs/1aQpl6MHKUQKGCtToJBNePadrRc/ubXe4fSaXG7ydipShpZxzv
         dc53mYV4pvnyvmaDC7jSUsGj8Bdoqg8bN+uKPyWE47AHQ+FmKJfcq3DjoU9tws+pZqdk
         ki3RNLaLwlxCQZ/cI9CcS9uK4T5mFH2L6/rmgxdFMPBxTHxGGL9EdCxHnTDCwlgDMmnL
         HgFQowUrGJ6qeFkjxuRKU21DNNt9l1/9Ec9XLb9TYMwU/a7FJgHgIXUINeN5h+Nsqqps
         ZylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hODQoQ2qyWAbyJwliLkBJvyeW+loPpahssLQ9Pq3n84=;
        b=jads2eniK9+NRoO4AFZuJqnvUKA9ixfubcto9WEw61KztwbfpsZXHxTpZp/jt/g3D5
         hyKeKhfR4QHj9twK/GtnR5rKIX2V+OZA5b/CI1KTBUF0DEMFphxlEaG8EPpxZ5fil3Ah
         PSXQutWcwtdQhlKVihNy7wtZYak+NW2+yhSwTBkdDrzp2rH7qXdF0Tr9bsPU4VgKxYUs
         gW9Z+b1ovuO/BkcvYFQ+xlowSHzQrWx3Fpyvd+vDPFASZmagL3Y9j4VgfJG75MZRbLRw
         04J5A9xEUEHrPnlcAHCD6zjFlo9Yh3ezvLlYQb50AG4XZ2im+L6yU28qcc1LdQ1tqGVz
         gmCA==
X-Gm-Message-State: APjAAAUL+7rbHS3lyNS06+Se71EBa2EVwLbgvwl2bI8NXtx5sf4n7XGZ
        uORtzbSvhM86oYNs9mjyBLBWUGB50GSdv/81mM4kgw==
X-Google-Smtp-Source: APXvYqwj0c6aBAloPvPThdYViSEw6GlAzHmdci0AL1RYSoyJSldCQVfrMKSmgmWDB0kzWnJMEqcM7JmmiWX6lHzhvoM=
X-Received: by 2002:a05:6512:245:: with SMTP id b5mr9977072lfo.24.1558628679565;
 Thu, 23 May 2019 09:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAN4oSBeEU+rmCS8+WwriGz0KoPR=Xa6KvjH=gGriFaxVNZHf6Q@mail.gmail.com>
 <8ccec20a-04b1-4a84-6739-afd35b4ab02e@gmail.com>
In-Reply-To: <8ccec20a-04b1-4a84-6739-afd35b4ab02e@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 23 May 2019 10:24:28 -0600
Message-ID: <CAJCQCtTp5d+VxsQmVv68VdmCsxSVpi-_c6LJjS_T=xx3GXz9Fg@mail.gmail.com>
Subject: Re: Citation Needed: BTRFS Failure Resistance
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 23, 2019 at 5:19 AM Austin S. Hemmelgarn
<ahferroin7@gmail.com> wrote:
>
> On 2019-05-22 14:46, Cerem Cem ASLAN wrote:
> > Could you confirm or disclaim the following explanation:
> > https://unix.stackexchange.com/a/520063/65781
> >
> Aside from what Hugo mentioned (which is correct), it's worth mentioning
> that the example listed in the answer of how hardware issues could screw
> things up assumes that for some reason write barriers aren't honored.
> BTRFS explicitly requests write barriers to prevent that type of
> reordering of writes from happening, and it's actually pretty unusual on
> modern hardware for those write barriers to not be honored unless the
> user is doing something stupid (like mounting with 'nobarrier' or using
> LVM with write barrier support disabled).

'man xfs'

       barrier|nobarrier
              Note: This option has been deprecated as of kernel
v4.10; in that version, integrity operations are always performed and
the mount option is ignored.  These mount options will be removed no
earlier than kernel v4.15.

Since they're getting rid of it, I wonder if it's sane for most any
sane file system use case.

-- 
Chris Murphy
