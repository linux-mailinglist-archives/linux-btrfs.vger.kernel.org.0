Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0D5CA95B8
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2019 00:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfIDWBn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 18:01:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37226 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfIDWBn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 18:01:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so395289wrt.4
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2019 15:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wr/80xlQJ1UMpPHygEGBFfbD0JPQO2YYr1rqSrxkLl8=;
        b=1y5Gydt2mVYEms2/T0b4qPiqkmoGd6FrhpDR6aRlm44cbFf0LSsyP2HGwKb56v4GZJ
         b/tOLOV3fNdtUG0Oj0qsnqXjFGIS6vNKU9m+rJxSnvOzxHP/5n0eo2h9qHf8xFYwwco5
         aPkAcJwZzdLMg/fl+tWmgI+c9L9Mi+4u6Gvjirm3Pyc6/CaatMDvM4/Xgz3v7fx1E0rS
         xpktkXkPXwcKeUJoitxHotMSuw8X+vMfHfCx/yGGcya++nqzv86ooW3egA1z62hnldeJ
         lK2OHUczZqLrzK+e3Q/ruvrM8OUyYDX8gnENEjJOHNch/W4NVni+KO6DMRgYc40MarPh
         Ywew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wr/80xlQJ1UMpPHygEGBFfbD0JPQO2YYr1rqSrxkLl8=;
        b=IJOvvmILKS/iVUtkc/Fpb2621w8Qf1jb0ZVE6ws47MwbjyoqudvqwZlF2D+69cHBRL
         qaxm57/chPyPmcjikaNDcFuGnrfZOtdzREwzjh2HNQ+II70qp3KOz11zxZbZGlm9KDrf
         tUiTxAXciUm85vL44vC6s0xSOnWez/y8UvIqrjslJXH6fceuJcZMgohc4bAXjiUTJHpY
         LD76KblKOFJCnX8LNlqA1ui+45pB9WXWEnZx02tZchRmfbavmyeCu91NwqqoZ4Ul5Ibb
         P3jtDtmyDLSflSSMlrp2tlXDhzZnVjCKTy2B6I4cidtjaL9aXzHJxaYB29QZvt14RbFp
         xf8Q==
X-Gm-Message-State: APjAAAXgK5hye2kOAuJEwqIYcD0AiJbsYiT6euFOBtPpmtftftMv2V60
        iTuIUnC/ioqImklEjmWfXPliFko2ZK70O3DS4IEz/A==
X-Google-Smtp-Source: APXvYqz9vcWwEUXhogw7cVgvXTfzRRlFNK5VED3IXTghmojcV5dJvGmh4AK1Qda84LQuSFR0e0jrfz2p9qj17XrU9Lw=
X-Received: by 2002:adf:e390:: with SMTP id e16mr2785219wrm.29.1567634501341;
 Wed, 04 Sep 2019 15:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <7d044ff7-1381-91c8-2491-944df8315305@petaramesh.org>
 <CAA91j0VLnOB1pZAbi-Gr2sNUJMj56LbBU7=NLYGfrPs7T_GpNA@mail.gmail.com>
 <20190904140444.GH31890@pontus.sran> <20190904202012.GF2488@savella.carfax.org.uk>
 <CAJCQCtQoKOL68yMWSBfeDKsp4qCci1WQiv4YwCpf15JWF++upg@mail.gmail.com> <5b5cc1fd-1e68-53c5-97bd-876c5cf08683@petaramesh.org>
In-Reply-To: <5b5cc1fd-1e68-53c5-97bd-876c5cf08683@petaramesh.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 4 Sep 2019 16:01:30 -0600
Message-ID: <CAJCQCtR_t8GOCGkrnq6NwSL=RCwrFuUzynKu4RucWTE1qAgjvg@mail.gmail.com>
Subject: Re: Cloning / getting a full backup of a BTRFS filesystem
To:     =?UTF-8?Q?Sw=C3=A2mi_Petaramesh?= <swami@petaramesh.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Hugo Mills <hugo@carfax.org.uk>,
        Piotr Szymaniak <szarpaj@grubelek.pl>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 4, 2019 at 3:04 PM Sw=C3=A2mi Petaramesh <swami@petaramesh.org>=
 wrote:
>
> So the question reslly is : How could I backup a complex BTRFS volume to
> another but differently (physically) organized volume keeping the
> complete structure and being able to restore it preferably in a single
> operation.
>
> If the answer is =C2=AB There's no way it can be done =C2=BB then it is r=
eally
> badly annoying...

It is, but it's also a direct consequence of its features. Those
features actually being used makes the resulting file system
complicated enough that it defies being easily replicated - other than
a block copy of every drive.

ZFS has the same problem, but with some constraints on its features
that end up softening the problem. Snapshots are only read only, they
are direct children of a dataset, not independent. And therefore it's
straightforward to determine their relationship, and recursive send is
possible (-R replication option). Also it has a big advantage of
online dedup, so while there can be unnecessary data in the send
stream, it gets deduplicated on the receive side if dedup is on (which
comes with a really heavy cost on speed or resources).

On Btrfs, if you avoid reflinks and deduplication between subvolumes,
and if you have a rigorous naming scheme, to enforce restrictions on
Btrfs - you can get most of the way where you want, without having to
do deduplication again on the new destination.


--=20
Chris Murphy
