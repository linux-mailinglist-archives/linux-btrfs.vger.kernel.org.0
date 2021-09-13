Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E18408ACE
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Sep 2021 14:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbhIMMPZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 08:15:25 -0400
Received: from mail.linuxsystems.it ([79.7.78.67]:39166 "EHLO
        mail.linuxsystems.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236646AbhIMMPZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 08:15:25 -0400
Received: by mail.linuxsystems.it (Postfix, from userid 33)
        id A668B21037B; Mon, 13 Sep 2021 13:58:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxsystems.it;
        s=linuxsystems.it; t=1631534300;
        bh=Y0M7vjgcVU+ZQYZPO9dojKmczHTuGZjexcOq0pVFKO0=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References:From;
        b=G1O1NqZH3znFE8ovJ18wAbHw+qRIutlyePVpqtPFRaG3qBu2rHj2MtbByU2bj4EVc
         zCHW54fuTalrNkTzZUCbo9DjwGyzF2pH+e/4Iv1toQDvl3KD14vTZ3UvUTqpQE4XZW
         9ydZURiiuXigEBIpIwY35EpqeiPsZUL1V0PEqZZQ=
To:     Qu Wenruo <wqu@suse.com>
Subject: Re: Unmountable / uncheckable Fedora 34 btrfs: failed to read block  groups: -5 open_ctree failed
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 13 Sep 2021 07:58:20 -0400
From:   =?UTF-8?Q?Niccol=C3=B2_Belli?= <darkbasic@linuxsystems.it>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
In-Reply-To: <98a6a966-cee7-cddd-3c53-fa2e209ed180@suse.com>
References: <0303d1f618b815714fe62a6eb90f55ca@linuxsystems.it>
 <22ac9237-68dd-5bc3-71e1-6a4a32427852@gmx.com>
 <02f428314a995fa1deea171af9685b9a@linuxsystems.it>
 <5a1cc167-0b9d-8a89-11e4-cfe388bd2659@suse.com>
 <75440780864f97ea54d12ff95a395864@linuxsystems.it>
 <98a6a966-cee7-cddd-3c53-fa2e209ed180@suse.com>
Message-ID: <f278527ec652f21aa3b280e9886bc96f@linuxsystems.it>
X-Sender: darkbasic@linuxsystems.it
User-Agent: Roundcube Webmail/1.1.5
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Il 2021-09-13 04:05 Qu Wenruo ha scritto:
> For those errors, not even a single dmesg error?

Nope.

> Anyway, if you have most data recovered and have dd copy at hand, then
> you may want to try fully recovery the fs to RW state, by some
> aggressive method:
> 
> # btrfs check --init-extent-tree --repair <dev>
> 
> This command will try to rebuild the extent tree completely, it uses
> existing trees to rebuild, thus requires the fs has nothing else but
> only extent tree corrupted.
> 
> This is *dangerous*, so the final call is still on you.
> But if you really hit no other error messages during the full fs
> recovery, then it looks like only extent tree is corrupted, and may
> worthy a try.
> 
> BTW, since you're already using rescue=nologreplay, you may want to
> zero the log before rebuilding the extent tree.

3 and a half hours later and it's still building the extent tree.
I gave up and made a new fs from scratch.
