Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0493730175C
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jan 2021 18:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbhAWRpo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jan 2021 12:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbhAWRpn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jan 2021 12:45:43 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A52C06174A
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Jan 2021 09:45:03 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 989DF9C0B9; Sat, 23 Jan 2021 17:45:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1611423900;
        bh=HH2RjYxCIVuHkq/vfjtRpBmpt+TmthxwdpNBxYXBI14=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qwihbv/hDUBnVM88G2kUVr8eRuarS5L3BMpYBbPMfttqu3XCXGatoeTpwpgQywfzl
         azQ9zFvnYBYSy0BTFWJ/wz/KdCCDqcqnA3j0609WyhnC25SYWz14IFBKr1zj47YinC
         gmFKryB60MlilXOs3zf0eDRjr3TUapDkkXN+gXhqxkiQZpT/iQ2OzwElAoW3lbjKa9
         l1HOBFNEx1z38wvt31RDvJ3SQ8zx4RpCNOYDB3FynrSgH4rx4ZQ0jJt9lSgRFxAjHs
         rffUX9SCLh4cnR4d2nq7dR4o6GXBWH4t6LJ6pt6WzbvY7LmZ6aRIPYe9T2pTiXKrG5
         /wPjs1JrWPl/w==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.0 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 648B59BBB5;
        Sat, 23 Jan 2021 17:44:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1611423893;
        bh=HH2RjYxCIVuHkq/vfjtRpBmpt+TmthxwdpNBxYXBI14=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VtVKIKOijFcrdMyadmybZpTOXPhL5jNGhDyoPPytGUpRdt05gLeGKKPbxCUKi1zEf
         lIMlVp9r+r6USQpNj5fC7qqVg8MML1wMnsaRsa443Gwf9bmHIfAu71xoHqb0hXdYhg
         gb4w/GsmeGfC1iWuXeD0e4+CekZ2w9/8TwziRsXs8IMqUjCZemYmOVYPlGaFipr7OG
         tpKCTavcZsgZKvmGNiUmkSzPu/kcaoXAolDsP2I1ke41gG/8v5BbgbvfaM5Sffdj4L
         LnSKMamT2p3LgghGGnScwTvs5rohmpqgVEpmSkoUZCI1+/gpHctjAFoGq1+oMXjDVv
         jpZwZqj+MckmQ==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 34AAE1D892B;
        Sat, 23 Jan 2021 17:44:50 +0000 (GMT)
Subject: Re: [RFC][PATCH V5] btrfs: preferred_metadata: preferred device for
 metadata
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Goffredo Baroncelli <kreijack@inwind.it>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20210117185435.36263-1-kreijack@libero.it>
 <30cd0359-e649-dcc7-e373-4dd778fbf70b@toxicpanda.com>
 <765cec4e-b989-081b-2ad7-e2d1c9cf7f55@libero.it>
 <20210121185400.GH28049@hungrycats.org>
 <89ee4ab9-64cd-b093-92d2-02eee4997250@inwind.it>
 <20210122224253.GI28049@hungrycats.org>
 <7b73eb0f-1b59-e6dd-5420-ef2d31a9fd62@cobb.uk.net>
 <20210123172118.GJ28049@hungrycats.org>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 mQINBFaetnIBEAC5cHHbXztbmZhxDof6rYh/Dd5otxJXZ1p7cjE2GN9hCH7gQDOq5EJNqF9c
 VtD9rIywYT1i3qpHWyWo0BIwkWvr1TyFd3CioBe7qfo/8QoeA9nnXVZL2gcorI85a2GVRepb
 kbE22X059P1Z1Cy7c29dc8uDEzAucCILyfrNdZ/9jOTDN9wyyHo4GgPnf9lW3bKqF+t//TSh
 SOOis2+xt60y2In/ls29tD3G2ANcyoKF98JYsTypKJJiX07rK3yKTQbfqvKlc1CPWOuXE2x8
 DdI3wiWlKKeOswdA2JFHJnkRjfrX9AKQm9Nk5JcX47rLxnWMEwlBJbu5NKIW5CUs/5UYqs5s
 0c6UZ3lVwinFVDPC/RO8ixVwDBa+HspoSDz1nJyaRvTv6FBQeiMISeF/iRKnjSJGlx3AzyET
 ZP8bbLnSOiUbXP8q69i2epnhuap7jCcO38HA6qr+GSc7rpl042mZw2k0bojfv6o0DBsS/AWC
 DPFExfDI63On6lUKgf6E9vD3hvr+y7FfWdYWxauonYI8/i86KdWB8yaYMTNWM/+FAKfbKRCP
 dMOMnw7bTbUJMxN51GknnutQlB3aDTz4ze/OUAsAOvXEdlDYAj6JqFNdZW3k9v/QuQifTslR
 JkqVal4+I1SUxj8OJwQWOv/cAjCKJLr5g6UfUIH6rKVAWjEx+wARAQABtDNHcmFoYW0gQ29i
 YiAoUGVyc29uYWwgYWRkcmVzcykgPGdyYWhhbUBjb2JiLnVrLm5ldD6JAlEEEwECADsCGwEG
 CwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAhkBBQJWnr9UFRhoa3A6Ly9rZXlzLmdudXBnLm5l
 dAAKCRBv35GGXfm3Tte8D/45+/dnVdvzPsKgnrdoXpmvhImGaSctn9bhAKvng7EkrQjgV3cf
 C9GMgK0vEJu+4f/sqWA7hPKUq/jW5vRETcvqEp7v7z+56kqq5LUQE5+slsEb/A4lMP4ppwd+
 TPwwDrtVlKNqbKJOM0kPkpj7GRy3xeOYh9D7DtFj2vlmaAy6XvKav/UUU4PoUdeCRyZCRfl0
 Wi8pQBh0ngQWfW/VqI7VsG3Qov5Xt7cTzLuP/PhvzM2c5ltZzEzvz7S/jbB1+pnV9P7WLMYd
 EjhCYzJweCgXyQHCaAWGiHvBOpmxjbHXwX/6xTOJA5CGecDeIDjiK3le7ubFwQAfCgnmnzEj
 pDG+3wq7co7SbtGLVM3hBsYs27M04Oi2aIDUN1RSb0vsB6c07ECT52cggIZSOCvntl6n+uMl
 p0WDrl1i0mJUbztQtDzGxM7nw+4pJPV4iX1jJYbWutBwvC+7F1n2F6Niu/Y3ew9a3ixV2+T6
 aHWkw7/VQvXGnLHfcFbIbzNoAvI6RNnuEqoCnZHxplEr7LuxLR41Z/XAuCkvK41N/SOI9zzT
 GLgUyQVOksdbPaxTgBfah9QlC9eXOKYdw826rGXQsvG7h67nqi67bp1I5dMgbM/+2quY9xk0
 hkWSBKFP7bXYu4kjXZUaYsoRFEfL0gB53eF21777/rR87dEhptCnaoXeqQ==
Message-ID: <24522e9a-8cfb-73ab-2332-c7e0c6b9677c@cobb.uk.net>
Date:   Sat, 23 Jan 2021 17:44:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210123172118.GJ28049@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/01/2021 17:21, Zygo Blaxell wrote:
> On Sat, Jan 23, 2021 at 02:55:52PM +0000, Graham Cobb wrote:
>> On 22/01/2021 22:42, Zygo Blaxell wrote:
>> ...
>>>> So the point is: what happens if the root subvolume is not mounted ?
>>>
>>> It's not an onerous requirement to mount the root subvol.  You can do (*)
>>>
>>> 	tmp="$(mktemp -d)"
>>> 	mount -osubvolid=5 /dev/btrfs "$tmp"
>>> 	setfattr -n 'btrfs...' -v... "$tmp"
>>> 	umount "$tmp"
>>> 	rmdir "$tmp"
>>
>> No! I may have other data on that disk which I do NOT want to become
>> accessible to users on this system (even for a short time). As a simple
>> example, imagine, a disk I carry around to take emergency backups of
>> other systems, but I need to change this attribute to make the emergency
>> backup of this system run as quickly as possible before the system dies.
>> Or a disk used for audit trails, where users should not be able to
>> modify their earlier data. Or where I suspect a security breach has
>> occurred. I need to be able to be confident that the only data
>> accessible on this system is data in the specific subvolume I have mounted.
> 
> Those are worthy goals, but to enforce them you'll have to block or filter
> the mount syscall with one of the usual sandboxing/container methods.
> 
> If you have that already set up, you can change root subvol xattrs from
> the supervisor side.  No users will have access if you don't give them
> access to the root subvol or the mount syscall on the restricted side
> (they might also need a block device FD belonging to the filesystem).
> 
> If you don't have the sandbox already set up, then root subvol access
> is a thing your users can already do, and it may be time to revisit the
> assumptions behind your security architecture.

I'm not talking about root. I mean unpriv'd users (who can't use mount)!
If I (as root) mount the whole disk, those users may be able to read or
modify files from parts of that disk to which they should not have
access. That may be  why I am not mounting the whole disk in the first
place.

I gave a few very simple examples, but I can think of many more cases
where a disk may contain files which users might be able to access if
the disk was mounted (maybe the disk has subvols used by many different
systems but UIDs are not coordinated, or ...).  And, of course, if they
can open a FD during the brief time it is mounted, they can stop it
being unmounted again.

No. If I have chosen to mount just a subvol, it is because I don't want
to mount the whole disk.
