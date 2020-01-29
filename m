Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5001C14C49C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 03:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgA2C0n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jan 2020 21:26:43 -0500
Received: from mail-vk1-f173.google.com ([209.85.221.173]:40742 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgA2C0m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jan 2020 21:26:42 -0500
Received: by mail-vk1-f173.google.com with SMTP id c129so4270157vkh.7
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jan 2020 18:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=1ldY5o07z5AtStZp7m4FN974k+7oyjD/uX3rCcWKlTw=;
        b=fs4o8kZ8HzQUpK7a8nJpPY3OnQp43esLh5NzchOBLr+suyMlmpXCCn/6Ox5rxUWTnk
         jep6LDrDh43II55CvEnQ+fhR7tgDp/DuWsC6YMsXaJvORxkUWZNYjYb768wXgDTbU9Gh
         k/eEPxG9AwyReuebf0Ga1dPzPmOeYgdW9hvUPLu0OMkvlorsc+f5CPWbLLaWur+gd86T
         Z96Q13boxyTqHqUZFNZiAUOduawrD5JtFGqIFlNiefchK8Nt4BcGtLWib1nmETB6mAjL
         A980JPusuErk62jA9Rf8+MTvSh3uIprZLhLU+/zjuMTNVSNFBSaUuO6ET3ofxwJXmsPr
         E3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=1ldY5o07z5AtStZp7m4FN974k+7oyjD/uX3rCcWKlTw=;
        b=C9He1r1H9u3Z1USKWw3Nmo9bDUokr1t+9ZCKWXKkn2VKN2hc2i9N/yxyC3pQyfnVpH
         QPXLC8n8EgtDgMAkbpPwhDrkBraOmsYKpAGsNylofVAWCCk2PftBzemCT7LLOcA7yEgl
         TPTtHONriOqoeKLVZ06uckmTe1zTjBCDNUihJGvQr/U6YTedDsDmg6rEWIQr4JtdXP17
         IZujmDosBdz6eCUUEdkUr41vwKBoGIbWfogKJlEbe5hMYq/eHdKuMlZEZxm1glXB8cMP
         qD961Ho2iMq3E+48rG5+Blxuk+tgR8wbIQj1SWWoqpgsDqLoDg61667pnaN8Df1wGriS
         HCHg==
X-Gm-Message-State: APjAAAXQPlM1WlqJirNl5rEduHsIgdNnUx8idfU8r6rBFje0lyAy9jBE
        J/pq5EjC6vi60PuTIOToOpyLB7sQO8S5BRYLNkVsf8Dr
X-Google-Smtp-Source: APXvYqzL+0S1icm+41B9b7au+jwva4Os0h1RManmY7D6sO25UEM3pHpn2qej2WOhwtLR65zEAlE62SQfI5/YGsvs28I=
X-Received: by 2002:ac5:c15a:: with SMTP id e26mr15102209vkk.62.1580264801539;
 Tue, 28 Jan 2020 18:26:41 -0800 (PST)
MIME-Version: 1.0
References: <CACurcBt_M-x=5CYhVUCiJq-yiUQF6-2a9PhWtmjfpJUYtAxt0Q@mail.gmail.com>
 <6c605879-0a52-337d-f467-82c7f0b04d76@suse.com> <CACurcBsv-D6MtunKrfY7ZKwxebfwGRejjfev7aUTgxwUzOG=Sw@mail.gmail.com>
 <CAJCQCtTCJpMSLYKQD+phEnF01iPL27dimrjsHyaCA=Xc76TniA@mail.gmail.com>
In-Reply-To: <CAJCQCtTCJpMSLYKQD+phEnF01iPL27dimrjsHyaCA=Xc76TniA@mail.gmail.com>
From:   Robbie Smith <zoqaeski@gmail.com>
Date:   Wed, 29 Jan 2020 13:26:30 +1100
Message-ID: <CACurcBtvP8hMsA+wVEbzQoEz6tzgPicesR28v=ey+oH4WEvcpw@mail.gmail.com>
Subject: Re: Unexpected deletion behaviour between subvolume and normal directory
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 29 Jan 2020 at 06:11, Chris Murphy <lists@colorremedies.com> wrote:
>
> On Tue, Jan 28, 2020 at 5:44 AM Robbie Smith <zoqaeski@gmail.com> wrote:
> >
> > It turns out that I made a mistake when deleting the files: I typed
> > `rm -r /library/Music/*` instead of `rm -r /library/music/*` like I
> > intended. Substitute "Music" for "newmusic" in the examples above. So
> > I deleted files from the subvolume by mistake.
> >
> > Now onto my next problem: `btrfs restore` is only able to recover
> > files that weren't yet deleted by my monumental stuff-up. It appears
> > `rm` went in alphabetical order, so I've lost only those artists that
> > started with A. B, or (some) C. However, systemd in its infinite
> > wisdom decided to automount my library drive while the restore was in
> > progress, and I suspect the space_cache mount option kicked in and
> > wiped the files forever. `btrfs-find-root` wasn't having much success,
> > but the undelete script here[1] is finding the files I wanted, so now
> > I'm just gradually working through everything.
> >
> > I think I'll be able to recover most things.
> >
> > [1]https://raw.githubusercontent.com/danthem/undelete-btrfs/master/unde=
lete.sh
>
> If you avoid writes, there's a really good chance of a complete
> recovery. Even the metadata writes showing deletes tend to not be
> overwritten for a while, at least so long as neither the ssd mount
> option, nor discard mount option, are used.
>
> Space cache being updated could plausibly overwrite portions of data
> block groups; whereas space_cache=3Dv2 is stored in metadata block
> groups.
>

It's a HDD so there's no SSD-specific mount options used. This drive
is (generally) only written to when I add new music or videos to my
multimedia library, and most of the files had existed on the drive for
months, if not years. As soon as I discovered my mistake, I made sure
there were no further writes to the drive.

It appears that the undelete script was able to find everything,
judging from the file names=E2=80=94btrfs restore wouldn't return a partial
file, would it? What exactly are its checks and balances to ensure
data integrity. if any? The undelete script didn't restore the
metadata (owner, perms, times) so I'm hoping rsync won't clobber
everything when I copy the files back. I don't have any means of
ensuring all the files are OK short of listening to the entire
collection for the nine weeks or so it would play, which is
unfeasible. I have tried just playing a dozen or so tracks picked at
random, and they played without errors. I do have an offsite backup,
but it can't be accessed remotely and it hasn't been updated for a
while.
