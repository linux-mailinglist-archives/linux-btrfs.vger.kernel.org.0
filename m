Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394D4352083
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Apr 2021 22:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbhDAUSK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 16:18:10 -0400
Received: from mout.web.de ([212.227.15.14]:51537 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234834AbhDAUSJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Apr 2021 16:18:09 -0400
X-Greylist: delayed 9430 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Apr 2021 16:18:09 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1617308289;
        bh=wst3OU2HI77ezHVkNcAfXv1GqX7QM8QJzGoCMp5FTcA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=tAvkWnrRvs5+7ylMQALiULz5PEPcIWwR5I5TvLOTyZ+EIVsfgOWzuvUztiP/wR+jn
         bpeuKYf8UBqvbgdiV+KaS79cDnnYkELgQPDYB1GVge7qxT8hszE0bTAS0L6z6otNuB
         FVplRG0T7t8dBiLbKf9h768x8XZs5WgM2I5HVWnM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [62.216.205.36] ([62.216.205.36]) by web-mail.web.de
 (3c-app-webde-bs39.server.lan [172.19.170.39]) (via HTTP); Thu, 1 Apr 2021
 14:36:43 +0200
MIME-Version: 1.0
Message-ID: <trinity-1259f92e-a84a-46a2-8524-330103dff745-1617280603213@3c-app-webde-bs39>
From:   B A <chris.std@web.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        btrfs kernel mailing list <linux-btrfs@vger.kernel.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Aw: Re:  Re: Re: Help needed with filesystem errors: parent transid
 verify failed
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 1 Apr 2021 14:36:43 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <0fd32582-2e87-c446-c312-9c1d9f4a3fdd@toxicpanda.com>
References: <trinity-ed62f670-6e98-4395-85c0-2a7ea4415ee4-1616946036541@3c-app-webde-bs48>
 <CAJCQCtQZOywtL+sz1XBC54ew=JJaLsx=UkgmeZi3q-ob39vgjw@mail.gmail.com>
 <trinity-10b6732b-bd13-45e0-b795-66e3c9a869c4-1617003257785@3c-app-webde-bap09>
 <CAJCQCtSp1cmA6iVmRfRXrxzo7pUA8eSUGwzuifbZkS=p0deO0Q@mail.gmail.com>
 <trinity-a06881cd-b3d5-4055-b151-f8ad46e425e1-1617007367803@3c-app-webde-bap09>
 <0fd32582-2e87-c446-c312-9c1d9f4a3fdd@toxicpanda.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:OgxB7C267OfKXiom7wZfg9F9wjpsUIFUy0z9UIYfs0eDm4ts5lBb4DPp+2jA5HFSG3n4v
 I4WB45km3M9a4LmgZIOn6MJTUx5pKOOcq/SzhBJr4pkDyVimnpxm7+pPU9wtfTkd0plOhWEwHvXY
 3A68zSrj7m6kLkIBZsA3wLOcuMxO9ploI/eCqj/k/VGetn0WncKWmMsT1APK4eAAz+Rcxr+HOYiE
 0JkAZFJHo4KZu/6hKzrodpjWUF5Czg74yFZ4BU2wCPHWnvhhIF5euXqFhrfUxZrIUg/EJTPgeugh
 VE=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KXuYEGr9hEs=:cXvoRAb/SRd8AcuAv2vaOg
 ReuWvamy1aj6683Y3HIZV15yx6VibJuEdlj1QO19pjE8fUbE3P0dXYD0pjwpMlJRqMcKCYYwK
 f3wJwOYMFTxFkVZ0C4XyFLOxcGATsOKJAkNMD+Z/0DieDk5sB2WO7q1strkIAVJ9AD5HguA41
 CuD0cFTKRm7awkrbJv71QHcQ1asHjUYcncQ+zWqNY+TcD9tVkdKKLc5mNS7KkyUAVOgCC5ys/
 lxiFjDmQkSdoAMneFjXDFTi9QAcGYPeEintgxsl0r1dg33tmOnmQm5xCudSrbGDHrgR/CzwSt
 eBWT7qULswBFpvVxEb5nkvpLZ5YavZEjvmbjGlNon5kvzECsS2Gy/oRDDQ+6HBhAL/IWGjHf0
 lxkx24V+cN/kAK/57kyFd+0l4yzUJbyGK6M7EFfMZBYo9AOG8WmKUVPLD3OsQEABtZcqaReEf
 P/su1rFZvrUorQjpIGbNvAE1kKBwUxWOXESaWCcieSLZk60recW8N5rFLGbGoiAbzR8T6fRP2
 udegQnKmvLRS0bXQ0iAjLhe/aIcb0VIQJJg93L3UOJEwaYvJcKpgZapLATQaiYp09JuIIs9K1
 kCJTGxjKhFuy/lRnEZqaxhpW9kqdaAsmhV0C+rJDXxDcep+IfflitLMphIv6eut3F85imRcGj
 RlOXhBd1td6SBYOvNOzozXkPyfTrqWY0uRq70i+dLu2gGczqQQnqRhsTmYBD8Vom4Y3pdnihR
 Ik1emFkmr025xJ6mytXRO3NpohYf24aG2Nl9Xe1NgAA/Pr2OF564xNEU5bk8BPgxnfsv6Osdj
 D2YhEObhBzb1zbe4pAjvpoN4k2nvG9fMRrbGbVL5qyJweOPs2SjH+I1xJXhYfZe3+edrEXQNG
 eYCF6qAleS1IWR1BaUeKGYg0PszxDbeXtuZMm8VmbpcnFLpFq6JyEmcqbiym14
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> Gesendet: Montag, 29=2E M=C3=A4rz 2021 um 13:36 Uhr
> Von: "Josef Bacik" <josef@toxicpanda=2Ecom>
> An: "B A" <chris=2Estd@web=2Ede>, "Chris Murphy" <lists@colorremedies=2E=
com>, "btrfs kernel mailing list" <linux-btrfs@vger=2Ekernel=2Eorg>
> Cc: "Qu Wenruo" <quwenruo=2Ebtrfs@gmx=2Ecom>
> Betreff: Re: Aw: Re: Re: Help needed with filesystem errors: parent tran=
sid verify failed
>=20
> I'm on PTO this week so I'll be a little less responsive, but thankfully=
 this is=20
> just the extent tree=2E  First thing is to make sure you've backed every=
thing up,=20
> and then you should be able to just do btrfs check --repair and it shoul=
d fix it=20
> for you=2E

Sadly, it does not:

# btrfs check --repair --progress
enabling repair mode
[usage warning]
Starting repair=2E
Opening filesystem to check=2E=2E=2E
Checking filesystem on /dev/mapper/luks-ff6e174f-4cd3-42a7-8ee5-47005dd077=
dc
UUID: 1a149bda-057d-4775-ba66-1bf259fce9a5
repair mode will force to clear out log tree, are you sure? [y/N]: [1/7] c=
hecking root items                      (0:0parent transid verify failed on=
 1144783093760 wanted 2734307 found 2734305
parent transid verify failed on 1144783093760 wanted 2734307 found 2734305
parent transid verify failed on 1144783093760 wanted 2734307 found 2734305
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=3D1145025249280 item=3D14 parent =
level=3D1 child level=3D2
ERROR: [1/7] checking root items                      (0:00:00 elapsed, 26=
57 items checked)
failed to repair root items: Input/output error

> However I've noticed some failure cases where it won't fix transid error=
s=20
> sometimes because it errors out trying to read the things=2E  If that ha=
ppens just=20
> let me know, I have a private branch with fsck changes to address this c=
lass of=20
> problems and I can point you at that=2E  I'd rather wait to make sure th=
e normal=20
> fsck won't work first tho, just in case=2E

Since I do have plenty of backups and it seems like the filesystem is stil=
l readable, I think I'd rather delete the filesystem and create a fresh one=
=2E I don't want to take more of your time here, unless you do want to know=
 more details for testing your changes=2E Thanks for all the hints so far!

Many thanks altogether!

Kind regards,
Chris
