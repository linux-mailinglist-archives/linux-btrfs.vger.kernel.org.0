Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE46259DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 23:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfEUVUi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 May 2019 17:20:38 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:43243 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbfEUVUh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 17:20:37 -0400
Received: by mail-lf1-f44.google.com with SMTP id u27so25070lfg.10
        for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2019 14:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AlLJqEA9IXK1zD1L1N98zwILACBJsa7O5nx/MyniDww=;
        b=RlWTE6UqY1RwGkv8KiAT1gIshgZ8wV4KEzPGU2vRob1Rsk4cUMDpfnKUGEs4e06TYV
         h534DTflwtskMWx7hk5Qk2FBWLTeO5DSQgdOVdZ0Z0Nenu2uWOMfU1BXjArW+Z+5/U0A
         s2ZDaG3vJfduyTwSh8Zgk8dsB1qeuhLF4YqvVMzxqGJdgxs0jWxpyZJj91+RLSLw4oZI
         wuK+xP2m/HYhHqYO0qNqP95ngg8uyXukkkY7SKJRkcdDt4UDGTyZicpFD3DX6WOxVO//
         t6GasqnmgsD89WmDTgsC9pY/7oIJNaDP6ULqIi44PM9rgH5QMBqjGHFb+bPdSCJZTH5G
         NAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AlLJqEA9IXK1zD1L1N98zwILACBJsa7O5nx/MyniDww=;
        b=Dsay88z2f3a0w7D+VFaGpbPlDKxPX278CmkQ0q6UrVVTex2ewp7goL2N7Hb7H4rinN
         N+tatLbO3ZQNpSrC79sTDLL0NRVXblDsQ+xjiGdvW1vBU36IaZeQj+jULmOvM2WTpC7R
         v74uCW9ikbkgVBS/OlSb2laPiPagEuACJIqecMnGIbpOKBbMlA8OvfoDFo1GyvMzZUjb
         aT0/ZZ5aiqiaX3QdpAxBLi5Q1q1csr7KK6t0r7+/FeOE4GKjErjfTApSuk8UXvvTrwmb
         qXNzhNVWba/q7W0kM5YrE0WI6gjGI2s6fqOtzb3w4W20hzgkUahQA17kYdzaNuCRjm4z
         xSnQ==
X-Gm-Message-State: APjAAAUYCHTWmlSSWGfkTmdzbAYTPjBcEl58xJgmgNuFw6N3AVI/pWAn
        eduf8Dr8sGIG3Y6OAYFONsusHHFMos/me7H+p6IeMQ==
X-Google-Smtp-Source: APXvYqyRAUUx2Wv+s36whehumXtSCQ1Uvn1dYhJznkkrOF9xeucn7kNblgTtAqwcbJuwuarQVcLxVoCu9+40MZNFv30=
X-Received: by 2002:ac2:4acd:: with SMTP id m13mr3540179lfp.38.1558473635686;
 Tue, 21 May 2019 14:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <emee6c041c-adec-4106-b8f6-c4665299ea29@ryzen> <em20253d9b-ed68-47a7-946b-55c040417fd6@ryzen>
 <bd91e229-90cc-f30e-1709-d8c55818af1a@samba.org> <em24499f72-5f4d-4fc2-8998-b81b877d8d3f@ryzen>
 <5bbcabdc-ac46-7481-64a8-b515745d72b4@samba.org> <em1a6d365f-4482-4553-81d9-dfa58a31f5d4@ryzen>
 <8954cf73-77a1-f313-6ea1-d9bdb142dced@samba.org> <emea02ad50-7e16-4771-9d78-37f0cde2bb16@ryzen>
 <c3c6eb4b-2af1-57d2-44ec-0596a2ac9c78@samba.org> <em093fdc1c-abb5-4cc9-b346-ea270deca7c1@ryzen>
In-Reply-To: <em093fdc1c-abb5-4cc9-b346-ea270deca7c1@ryzen>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 21 May 2019 15:20:24 -0600
Message-ID: <CAJCQCtRGZwZYwDpS-Z0H9VvihsRUkv_csS-vtEz20cD7WKYVOQ@mail.gmail.com>
Subject: Re: Re[2]: [Samba] Fw: Btrfs Samba and Quotas
To:     Hendrik Friedel <hendrik@friedels.name>
Cc:     Rowland penny <rpenny@samba.org>,
        sambalist <samba@lists.samba.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 21, 2019 at 2:01 PM Hendrik Friedel <hendrik@friedels.name> wrote:
>
> Hello,
>
>  >> In my impression: Yes. Also, this problem seems to affect also zfs
> and
>  >
>  > I'm mostly interested in the claim that ZFS is affected.
>  > I haven't followed this thread carefully, but what exactly is the problem we're
>  > talking about, and how do we know it impacts ZFS?
>  > [Something more than a single one-liner in that bug report?]
>
> Indeed, I only find that one line. I can try to find out.
>
>  > Is the extent of the issue that quotas won't work, while enforced from Samba
>  > against a ZFS volume?
>  >
>  > Can someone perhaps enlighten me? :)
>
> The explaination is:
>
>  > That's because the concept of a btrfs "subvolume" completely
>  > breaks the POSIX idioms that smbd depends on.
>
> And wouldn't that also be applicable to zfs?
>
> >  At least I hope you can understand why some bug reports seem to take forever to get fixed, it is all down to priorities, the highest  priority ones get fixed first,
>
> Yes, I understand that.
>
>  > What I was trying to say was (and failing, it would seem), this is a
> two way street
>  > and if OMV cannot/will not help you, then it is hard to fix,
>
> What is OMV specific here? Isn't the problem fully included already in linux (=kernel) and samba?
>
>  > especially now that Jeremy has pointed out that it cannot be fixed as is. Now this
>  > doesn't mean it can never be fixed, throw enough money and man hours at it
>  > and a workaround can probably be found
>
> Here, I could imagine that linking with linux-btrfs would be worthwhile.
>
>  > but this would undoubtedly entail OMV getting involved
>
> Why? OMV merely writes the smb.conf...

If project C wants to use storage technology A and B together, then C
is best off helping upstreams in order to make downstream integration
easier. I don't think it's anything beyond that.

Anyway, I use Btrfs and Samba together just fine. But I mount a
particular subvolume to a mountpoint and then Samba shares that
mountpoint. I do not have any subvolumes nested within the shared
subvolume. That might explain why I'm not affected as Samba only sees
one set of inodes, no duplicates, per mount.

From the same Btrfs volume, I do share other subvolumes, and therefore
there's a repeat of inodes, but they're each in their own
mountpoints+shares. So far I've seen no evidence of Samba confusion.
But I also don't use quotas.


-- 
Chris Murphy
