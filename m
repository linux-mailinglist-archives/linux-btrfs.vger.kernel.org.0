Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B594D1F84CE
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jun 2020 21:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgFMTDx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Jun 2020 15:03:53 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21165 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgFMTDw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Jun 2020 15:03:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592075030; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ZCAumdcC1tR2yn/AjSFVav8tWKzDcMEV9INwU8E9U/gm1wNRKaeTFW4LvTeWbL49e8fsdqG9jNEmGtABU2RwtmnopYfHpJU2OnqFIDyRa6iKZJRzec0IQjSZlK6D69Bb6BdPK0nzx4z7PTJhnSj463ByrwFZPAAJLbRskiLD3BM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1592075030; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=l1Q5MZHajydBxK3QCFl6r6SHRgX6VVN6kcgCzq6RUJo=; 
        b=hk5kcSCqjgE41PX8lXSYJlbwBt2cqvYAZ5tSu7dKampCVo0nATgl0RARlq1wJYSioKIjpclp32PXtCkJEwoOfdK+5WE0qnRFz8IHVM+8OUlF4PbzmEt50JTLsJmi7HxeTeViuGuttiUOiftMCCZrf0HcFb6o6NsyFg3gim2p8N4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=markus-kramer.de;
        spf=pass  smtp.mailfrom=mk.btrfs@markus-kramer.de;
        dmarc=pass header.from=<mk.btrfs@markus-kramer.de> header.from=<mk.btrfs@markus-kramer.de>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1592075030;
        s=zoho; d=markus-kramer.de; i=mk.btrfs@markus-kramer.de;
        h=Date:From:To:Message-ID:In-Reply-To:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=l1Q5MZHajydBxK3QCFl6r6SHRgX6VVN6kcgCzq6RUJo=;
        b=K7ee3VLig9kmcrAr8+C9CHdo55084NlWB1YGeHQKuAYYEFDiRNlqlN+FaaaIBuO5
        xCRpHBmgAo48nMrVk+1drtslKiLJfBxtBlv7quDlk4wAo3skweTHdZRun/kT/UC+TZn
        RzjZPSCOrP3KmmbAFTyCa1SHtTIbVQJ1lI4P9k+k=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1592075024727867.2086972557695; Sat, 13 Jun 2020 12:03:44 -0700 (PDT)
Date:   Sat, 13 Jun 2020 21:03:44 +0200
From:   Markus Kramer <mk.btrfs@markus-kramer.de>
To:     "linux-btrfs" <linux-btrfs@vger.kernel.org>
Message-ID: <172af10f956.e2fef077303989.3720460216901878669@markus-kramer.de>
In-Reply-To: 
Subject: Better scrub user experience
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi.
I=E2=80=98m looking for a more user friendly way to performing btrfs scrub.=
 Currently, I=E2=80=99m running it monthly via anacron, but this is not ver=
y satisfying. I get problems like hanging system suspend, no retires etc (I=
=E2=80=99m on Ubuntu 20.04).

I think an ideal solution for desktop users would look like this:
1. After boot or when a new device is connected it checks the scrub status.=
 If the file system hasn=E2=80=99t been scrubbed in the past 30 days it ask=
s the user to start the scrubbing via a GUI dialog.
2. If the user wants to run it the scrubbing progress is visualized in a wi=
ndow. This way people also know why their system is slowing down.
3. But the user can also postpone scrubbing to a later point (e.g. tomorrow=
).
4. System suspend automatically pauses the scrubbing.
5. If a paused scrub is detected the user is asked if they want to resume i=
t.

I=E2=80=99m thinking about implementing this as a script that would be exec=
uted on gnome startup and when a btrfs fs/device is connected. But I don=E2=
=80=99t want to reinvent the wheel. I=E2=80=99m aware there is btrfsmainten=
ance but it doesn=E2=80=99t seem cover any of the points I=E2=80=99ve liste=
d. Any feedback on this or solutions like this that already exist?

Many thanks,
Markus
