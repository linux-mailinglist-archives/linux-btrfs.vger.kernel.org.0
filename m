Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD7E3E0A9D
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Aug 2021 00:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhHDW4C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Aug 2021 18:56:02 -0400
Received: from mout.gmx.net ([212.227.17.20]:50673 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230236AbhHDW4B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Aug 2021 18:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628117747;
        bh=dwkUdpjKZAXybQHLpcOn9ebJ7ImbAAYw6bY4v7WCEaw=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=Hnkwnh4N0BCCu+xrQ8lfvFDBg2lgs/2+AV9mC1iWiKJoZX5SuDFyILx6SleCrUh9w
         rTsnSoghCWUneqBnzkP2PdYfnZemoGB9GsTTV9eMQhDUkA8UbJKDOzqgoR2iPzpgz+
         8r4L71JJUYP4NZCWW8F4skefq34g0Pi5/pQk3zuc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiaYJ-1mpPVt0e3z-00feuw; Thu, 05
 Aug 2021 00:55:46 +0200
To:     k g <klimaax@gmail.com>, linux-btrfs@vger.kernel.org
References: <94bf3fad-fd41-ecc0-404c-ccd087fca05d@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Files/Folders invisibles with 'ls -a' but can 'cd' to folder
Message-ID: <c11aea64-0f94-7cb1-886e-f6bc5050d7f2@gmx.com>
Date:   Thu, 5 Aug 2021 06:55:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <94bf3fad-fd41-ecc0-404c-ccd087fca05d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0y4K3XTrEH7+nfgUgCzNQoB+UK+6rhoyo9HVJL43mW9XOe1Q1wG
 e7onBB971IO8qG0qlb3J6CUDyy9Ic8nbkMJxBWqg9sZe4lD1ahJ/iyqn2+Rk3F9S4jMGaMw
 mTO5jceuFwzGaF0vdFuH/N6LM0aklK9CuSIXXhU9GbhtK1joZ6Ul6kHKZmmiTrhC1Qv34zy
 sVU9BRBCYK/MqrlH/E30g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2MPB+XHazr4=:I/muApGJY7KGIcOFqM3ih9
 JegKcMzsbzbr9Qj79YjeHllEOGCu2vMZgnm6GM7mwzzDUgUfZB5ySNw/wFpxR2xSgWwNJxZNx
 DaEazDrJFjdWpb31usRnTbDSudNjQWu9otATlrOEkiPwV6yAGGSH/9ECs1hN2tTi+uzRygq2M
 coRS0cTqnlhfcjOesy//Bc+nCcjBStqS7WT7G06aMD/ylRex5+XgC50yckEFdwirqj5/wQy8l
 EgPrlg6yBa0DD9vfdZIAX+bzmFhWM4xxShy0A9CZHj4XHo8vdiqPTSAlw6uUpi60z6Cm3c9pZ
 w2NB8WaECcT938qcSrF0kYuSfubRU3z+abm0XKw2dIKXnly8YuktaMjJkMFViz5pBJbMkuSaC
 nZeL2x+oNu1fI5fw3Q+cgcLDEl/z37+LQ8PyzIDKkwnBHXj5WhuTODkWjrmxPOj6epvz71dYB
 tLwXH/9ROugA5Hvw4Dfn1NshlMHXEzdqsrWW+qLWPJS322/U+AwdZWjZH3qPdxWnrSI5hF5yi
 9XpeS0nasfXbVSfDzInDcrJrp78DPmAeIjoE8ozzj6c3YMlN5rngm0eg/EvWRngdv/4VKF7TN
 xU8YIOXBzAmZSoSRW+xXnn0VGabgLtvwY6QfLw8gbWATYcet4/rLJSaMnFliks9YaRcTxl7xO
 nEW/0O/v+5vQ1PowWm/ok4HKKnliN2J2d+d8BMjHAUwpv7XGh2DSpPvOON+uXNihjXvCNXA0B
 /C+PJKme4V22oJGyoKhx0aMYg8IAYfBGebSnZdOC8C0QtTJSdwLsvxZh1hjQYGYuzfPqftcOL
 8mSVq4r+87tEnlWWjpbBXCKsLETVYiXqYi+iz6VF7z/E6LzGTM0KPbIqtUbV29qA+dddNlauM
 iGMhu7BGrxbAvGwZlEeOmjGDVpO3kh7E8A738WuRj9QABE5b6qIISocGRAy7t4k2emgiLc+m/
 LdB4eAiradD8NW6Yqne3fwg5rbQCXB8HH/whB5nQtuyYqvus6WcaoJDW0huZnBxpAtNz9lV4j
 fqnuT+atVIRwoQ6Xv4sKTQ0oo4jA3ATrmG0hUPViIUlIG8CI7nPW2lmjkvQPqENuWBKwArMor
 +6LaOg15lBSpUXI29wpKXEbZuMDS7fHJI2tgVH6KWssxtBf4G1vjGtzUA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/4 =E4=B8=8B=E5=8D=889:19, k g wrote:
> Hi
>
>
> As I say in my subject, I'm facing a weird problem with my btrfs
> partition (I already sent this message on reddit /r/btrfs/ )

Sorry, reddit is not really the go-to place for technical discussion nor
bug report.

>
> It's in fact a btrfs partition in a raid5 synology system.

We don't know how heavily backported the synology kernel is, thus it's
normally better to ask for help from synology.

>
>
>
> 3 days ago, the volume 'crashed' (synology terms) ,however SMART data is
> ok and I don't have sector relcocation errors or CRC.... I rebooted
> several times , and after dozen of reboots my partition shows up , but 3
> TB of 10 TB are missing, I made a scrub but it did made my missing files
> appears.
>
>
>
> desperately I made a 'cd xyz' in a directory (I remember some of the
> folder names) and it works ; and inside this folder I can do "ls" and
> all files and subfolders appears .
>
> I made a copy elsewhere of some files and these ones are not corrupted
> or bit roted.
>
>
>
> I don't want to make a btrfs check --repair of course.

But "btrfs check" without --repair should be the best tool to show
what's going wrong.

Alternatively, "btrfs check --mode=3Dlowmem" could provide a better human
readable output.

>
>
>
> Is there a way to "relink" indexes/root or whatever it is called to
> bring back these files/folder visible and accessible with a safe command=
 ?

It's not that simple, from your description, it looks like the dir has
some DIR_ITEM but no DIR_INDEX, thus it doesn't shows up in ls, but cd
still work.

This normally indicates much bigger problem.

Thanks,
Qu
>
> I'm planning to backup all , is 'btrfs restore' will access to these
> "non visible" directories ?
>
>
>
> "I saw similar case here : The Directory Who Wasn't There : btrfs
> (reddit.com) , but I can't find a reply that solve the problem"
>
>
>
> cdly
>
