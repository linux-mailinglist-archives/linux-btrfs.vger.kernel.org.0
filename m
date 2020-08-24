Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021D024F277
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 08:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgHXGT5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 02:19:57 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:47332 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgHXGTz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 02:19:55 -0400
Date:   Mon, 24 Aug 2020 06:11:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1598249520;
        bh=d2QOCZUCUG6sw6whnn7jTEdVI2MlLwUjMyGKvuILyos=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=IurQ/2jG81jDqYiFIyrQqBFJteSr4FrxRzizPkh7FX4P7iydjHOgqv/bTu8XZekk9
         SRzB0m/o3RJFJsiMH/bBkBT1axwKfzYVfKk8ohizOa3GFCGaDZW5O5GCaycYSbSARs
         /yaYtmwSXalOEcRrdpNrhpH32ZXVi1+tNogIuC/E=
To:     Chris Murphy <lists@colorremedies.com>
From:   Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Reply-To: Andrii Zymohliad <azymohliad@protonmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to fallocate failure
Message-ID: <Yy8-04dbNru1LWPcNZ9UxsagH1b0KNsGn7tDEnxVOqS812IqGiwl37dj4rxAh05gEP8QoNJ5F_Ea6CZ8iZgvnupuq5Qzc38gl69MceWMc9s=@protonmail.com>
In-Reply-To: <CAJCQCtTC2yi4HRqg6fkMrxw33TVSBh_yAKtnX-Z1-nXSVjBW7w@mail.gmail.com>
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com> <CAJCQCtTC2yi4HRqg6fkMrxw33TVSBh_yAKtnX-Z1-nXSVjBW7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Chris! Thanks a lot for so many ideas, I updated this snippet with mo=
st of the commands you asked the output for: https://gitlab.com/-/snippets/=
2007189, more details inline.


> I don't understand why homectl is fallocating just to activate. I'd
> expect homectl only uses fallocate for create and resize. Can you
> confirm the exact homectl command you're using?

Any homectl command that requires authentication. For example:

    homectl authenticate azymohliad

After typing password, the output is the following:

    Operation on home azymohliad failed: Not enough disk space for home azy=
mohliad

Here is the part about fallocate on Systemd mailing list: https://lists.fre=
edesktop.org/archives/systemd-devel/2020-August/045074.html (from the same =
issue discussion). Andrei Borzenkov might give more insight about it (if yo=
u are reading this and when you have time).


> Preferably if you could post the results from:
>
> ls -ls /home/azymohliad.home

    269111212 -rw------- 1 root root 432439787520 =D1=81=D0=B5=D1=80 23 18:=
20 /home/azymohliad.home

Also, added to the gitlab snippet.


> When you manually mount this luks file, what do you get for 'btrfs fi
> us /home/azymohliad' ?

Added to the gitlab snippet.


> Because if that file system is 403G, and sd-homed is trying to
> fallocate a 256G file to be 403G, that's +147. And also in your
> snippets from '/' btfs fi us
>
> > > Free (estimated): 176.17GiB (min: 176.17GiB)
>
> The fallocate should work. Has this home file been snapshot or reflink
> copied or deduped?

I haven't made any explicitly, but I'm not very familiar with those concept=
s, maybe sd-homed did it implicitly.


> filefrag -v /home/azymohliad.home | grep shared

This one is 18k lines, uploaded here: https://gitlab.com/-/snippets/2007301


> Here's the thing. /home/azymohliad.home, the file, should be the same
> size as the Btrfs on that file. Unless it's been subject to discards,
> and is thus sparse already for some reason.
>
> Is it possible the file is being trimmed then fallocated then trimmed
> then fallocated? This could be new behavior in sd-246.

Idk, I guess it's better to go back to Systemd mailing list for that, but j=
ust in case I've added "homectl inspect azymohliad" output to the gitlab sn=
ippet. Here's what it says about discard:

    LUKS Discard: online=3Dno offline=3Dyes


> Grab this debug file from upstream btrfs-progs
> https://github.com/kdave/btrfs-progs/blob/master/btrfs-debugfs
>
> sudo ./btrfs-debugfs -b /
>
> Mount or remount the file system with mount option enospc_debug, and
> then reproduce the problem, i.e. exact same homectl command you're
> using that's failing with out of space error.

I didn't quite get what information I should extract from this.

Here is the btrfs-debugfs output: https://gitlab.com/-/snippets/2007302

I remounted root filesystem as with enospc_debug, reproduced the issue with=
 "homectl authenticate azymohliad", but it didn't print any additional info=
, nor any additional logs in journalctl.


> For sure my top advice, is since you can manually mount this sd-homed
> home, freshen your backups now while you still can. Later versions
> of sd-homed create a subvolume on that LUKS Btrfs file system, so you
> can snapshot it and use btrfs-send if you want or however else you're
> doing backups.

Thanks! I'm unfamiliar with snapshots and btrfs-send yet, but it's the perf=
ect time to learn.


> There is a homectl option that might help, when activating, --luks-discar=
d=3Dtrue
>
> A consequence of this option, however, is it will make the backing
> file sparse. i.e. it'll punch holes in it, freeing up space on the
> underlying file system. You should read the warning for the
> --allow-discards option in 'man cryptsetup' which is what 'homectl
> --luks-discard' is using.
>
> Also, this option will fairly quickly fstrim the user home upon
> activation (last time I tested it on systemd-245, some things have
> changed in 246). And that will erase all evidence about why you're
> having this problem in the first place.

Gonna read about this too, thanks!



