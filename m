Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E176A437A3A
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 17:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbhJVPpK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Oct 2021 11:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhJVPpJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Oct 2021 11:45:09 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B54C061764
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Oct 2021 08:42:51 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id b9so7915690ybc.5
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Oct 2021 08:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=b0LfccLNyHx7KhunxY9/5x/ug/RRFZF2rC8gmoKeVLk=;
        b=KeOgVPlX3jLM3QZ4QlpE47lLiyzavn+uCMz9fNaNyJPv4AdftZKpiW09TP9twphg9z
         bbCFhMekumUdhdySXUZ/2x6N4uJJh5Ocf2zawmPQcscaZhBE+kehx4kq+h9JtkQY7LeL
         450F3+sl2Ce1n/U9LgLINaDYeB2CK2XflhXJVeo32CHZknPm+M+znz0WCNh2aGU8UBjA
         u7aNM/7mV6y6D/9gGbCfgKH8X6SqnxU7M+jbldgHqiqCO/lc85eGgd6j9irMwbPrsvLp
         ZEXiIRcg+2sSqhFeDIlLWNg4K1CtoGMWAotVa29XuoO8o385MMxCbi0iwn/6ZoaNbIkx
         zzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=b0LfccLNyHx7KhunxY9/5x/ug/RRFZF2rC8gmoKeVLk=;
        b=ivnkxiXJ8qRfvGATQwxoH/DQK+z5gc7gNQWtiztiGpbjtq5YAMi4FBvbRBHObrW1yC
         aoOpiJ+blv3BjnWRRgtjGUtCgDOQK0B120LoU5R4LeqNRM31MGh+XNFltogXZ2PzSxu/
         S6BAygaIGB0XMlT1xHpt/4DMboL8V8PH549ofCcigs9tb6EaasAk++74AOWx/HSBxcTi
         BOROjsT0zLxw4sH8epwuTfJP1nApkPX6VdG66ziGxXOUbyapOACgWwsyH0qli8RZOMMX
         YV+LFPNe3jrtM70gnIxcfeXqKv2OJ60yUcKDZlQY+UYA8fiNtaXSc98SEnsZqQLM6LZ3
         ETyQ==
X-Gm-Message-State: AOAM532YMzmPngwWlIVbNBAsoDBFVGU3OaFQAJ3UGKB5JceO3/QfNpku
        YmhrAI02jfs5sx8psh3KFfw+9Q0EYF//0WHRKXs=
X-Google-Smtp-Source: ABdhPJzfH2jnCxXT1luhsZTgyXe8gTyY8hViB6q6i0vO0yiK/lODDaptSlZIGtzOVuJF3Z7U2bCH4537hOlXCzhalfc=
X-Received: by 2002:a25:68c9:: with SMTP id d192mr496707ybc.476.1634917370221;
 Fri, 22 Oct 2021 08:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211022141200.GK20319@twin.jikos.cz>
In-Reply-To: <20211022141200.GK20319@twin.jikos.cz>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Fri, 22 Oct 2021 11:42:14 -0400
Message-ID: <CAEg-Je_j=3JgTon1NpNF2PzzWHMracyOWAYHv4CBGoq420f2oQ@mail.gmail.com>
Subject: Re: btrfs.wiki.k.org and git-based update workflow
To:     David Sterba <dsterba@suse.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 22, 2021 at 10:14 AM David Sterba <dsterba@suse.cz> wrote:
>
> Hi,
>
> I'd like to change the way wiki contents is going to be updated, and
> would like to get some feedback eventually.
>
> Current status is quite unpleasant, the number of active editors is 1
> (me), with other occasional contributions. I somehow feel that the wiki
> concept as community editing does not work, specifically for our wiki,
> or maybe in general, anymore.
>
> I don't intend to remove the wiki, it's been linked from various places
> and people are probably used to looking up the info there. What I'd like
> to change is how the updates appear there.
>
> I think the first hurdle is the separate registration. There's 1 new
> account request per two weeks, but no actual edits following.
>
> In addition to direct wiki edits, I'd like to provide a git based
> workflow, on github. A separate repository would be clean but IMHO
> harder to discover, so the idea is to reuse btrfs-progs for that purpose.
>
> Selected pages from wiki will be "locked", with a disclaimer that they
> need to be edited via git. Then in btrfs-progs/Documentation will be the
> raw mediawiki source file. Edit this and send a pull request. I'll do
> the sync to wiki periodically.
>
> The manual pages are now synced like that, so this would allow us to
> also use the asciidoc format as source.
>
> For me personally using a local editor for writing documentation is much
> more comfortable than the browser textarea. If this would motivate
> someone else to contribute too, it's worth it.
>
> (Other option researched: readthedocs.com, git-based but it has a
> different structure than wiki and is on another site.)
>

It'd probably be good if we could eventually convert it to
Sphinx-based documentation like the rest of the Linux kernel
documentation. We could use readthedocs or reuse btrfs.kernel.org for
this.




--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
