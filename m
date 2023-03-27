Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AB06CB000
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 22:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjC0Uau (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 16:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjC0Uat (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 16:30:49 -0400
X-Greylist: delayed 339 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Mar 2023 13:30:46 PDT
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [213.138.97.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8F01FD6
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 13:30:46 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 65FE69B853; Mon, 27 Mar 2023 21:25:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1679948704;
        bh=VELczHQHgavQfy4fjuqsDj9TE/qV8hmn3Ufe5fnUQEQ=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=iHL+BxuQhgQx8Iv0hUAZGrb5Jhn8N5++tvn9w1N4j5H1ZZWeyTdlJFvBYX7ksDDZL
         MrslzgJ8kZ3bU1vQ0hnNfNQTCObWoHpfgHCKzUru3bSGJ7FUD1mcu7mCMcPEbMq4lz
         3kyh+YcKLrUPTHLM84Gd9bZN020pjYoDYekDSb6sWMdp4NxDuBuVdOpr2YFge4JWpU
         QQC55uEnvFGGxv/SyW908dJurQBg22Ve4fX71PCMZn1C6de8DBfoWIGD2SBJp9A00W
         TL4QZaHXWs1SLAFzh27p9CeMaamMCLOoJu2l4tu0MsYQjiDPB+K/mWEBLDxOdHUB6+
         Yvz9VWkdvJj/Q==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 233109B6EE;
        Mon, 27 Mar 2023 21:24:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1679948684;
        bh=VELczHQHgavQfy4fjuqsDj9TE/qV8hmn3Ufe5fnUQEQ=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=LvxlWcOGaShZdglAJwbFQWV+R4D7OOZBZ+Hs7sQEUK4fVl1i3FwK3Ju/OTFf4ZD+d
         mbYByBIDvEQbgr7R6101FeI1CQzWETj4zzQjVJAdaHJJHPesUV4a30CbScQxjg/xtr
         f0NfHGg5d4RaZ15LEJy9VPzZ1iNN+qpPxliuYDQQMkAfJJ/qMN6fUsTi88EOlMwGwO
         yaakycNoxQkk3QwKGJOtFURNtoF6KRLt6J8taHHQoAYl6ZR6X/Do6oGn9wgKspzLCO
         GbzSB3aOdYmTlr2HRS8kO069BIqJiBqUZv3WL6Nphj68vklP9phKviXUoJGoKWb9VQ
         64NMUps1UiUAw==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id BDA482FCB74;
        Mon, 27 Mar 2023 21:24:43 +0100 (BST)
Message-ID: <30d48950-fc53-60fa-8fc1-61dbebf47102@cobb.uk.net>
Date:   Mon, 27 Mar 2023 21:24:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: subvolumes as partitions and mount options
Content-Language: en-US
To:     Matt Zagrabelny <mzagrabe@d.umn.edu>,
        Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAOLfK3WuXuVKxH4dsXGGynwkMAM7Gd14mmxiT2CFYEOFbVuCQw@mail.gmail.com>
 <ffca26e0-88e8-1dc7-ce67-6235a94159e1@gmail.com>
 <CAOLfK3UZDNO_jSOOHtnA+-Hh-V6_cjsL36iZU0a+V=k80KDenQ@mail.gmail.com>
In-Reply-To: <CAOLfK3UZDNO_jSOOHtnA+-Hh-V6_cjsL36iZU0a+V=k80KDenQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 27/03/2023 20:50, Matt Zagrabelny wrote:
> On Mon, Mar 27, 2023 at 2:25 PM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
>>
>> On 27.03.2023 21:48, Matt Zagrabelny wrote:
>>> Greetings,
>>>
>>> I have a root partition btrfs file system.
>>>
>>> I need to have /tmp, /var, /var/tmp, /var/log, and other directories
>>> under separate partitions so that certain mount options can be set for
>>> those partitions/directories.
>>>
>>> I'm testing out a subvolume mount with the subvolume /subv_content
>>> mounted at /subv_mnt.
>>>
>>> For instance, the noexec mount option can be circumvented:
>>
>> "exec/noexec" option applies to mount instance, it is not persistent
>> property of underlying filesystem. It is not specific to btrfs at all.
> 
> Agreed. My email was more about subvolumes and the mount point has the
> "noexec", but the actual subvolume doesn't - so there exists a path on
> disk where folks can exec the same file by circumventing the mount
> option by directly invoking the full path under the subvolume.

So, create the subvolume inside a non-world-readable directory? In fact,
I always create all the subvolumes inside top level (subvolid=5)
subvolume but that subvolume is not normally mounted. /, /tmp, /var, etc
are all subvolumes and subvolid=5 is not mounted at all (or can be
mounted with a mount point somewhere not world accessible).

Don't make the mistake of thinking that subvolumes have to be visible
anywhere in the filesystem except the place you mount them.

Graham
