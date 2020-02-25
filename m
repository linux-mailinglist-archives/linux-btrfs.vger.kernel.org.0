Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B47516EAA8
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 16:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgBYP7k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Feb 2020 10:59:40 -0500
Received: from tartarus.angband.pl ([54.37.238.230]:39526 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgBYP7j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Feb 2020 10:59:39 -0500
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1j6ccT-00020J-5S; Tue, 25 Feb 2020 16:59:37 +0100
Date:   Tue, 25 Feb 2020 16:59:37 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     "Franklin, Jason" <jason.franklin@quoininc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Hard link count reported by "ls -l" is wrong
Message-ID: <20200225155937.GA5446@angband.pl>
References: <051c9f6d-5765-e2d1-9aae-aff70e0f2bb4@quoininc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <051c9f6d-5765-e2d1-9aae-aff70e0f2bb4@quoininc.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 25, 2020 at 09:59:49AM -0500, Franklin, Jason wrote:
> When using "ls -l" to view a detailed listing in the current directory,
> I get output similar to the following:

> drwxrwx--- 1 jfrankli jfrankli  38 Feb 25 09:54 Desktop/
> drwxrwx--- 1 jfrankli jfrankli  36 Jan 24 10:37 Documents/

> Notice that these are all directories with a hard link count of "1".
> 
> I have always seen directories possessing a hard link count of "2" or
> greater.  This is because the directory itself is a hard link, and it
> also contains the "." entry (the second hard link).

That's an implementation detail of filesystems on truly ancient Unices
(from the times before my birth -- and, with bearing kids at age 14 being
semi-popular these days, I could have been a great-grandfather).  And there,
indeed, subdirectories and ".." (not ".") had been implemented as actual
hard links.  Heck, you could even unlink() them with nasty results for the
filesystem -- remnants for such unlinking (but not the lore) can still be
seen in "perldoc -f unlink" and "man 2 unlink".

> Any immediate child directory of a directory also adds +1 to the hard
> link count on other file systems.  This is because each child directory
> contains the ".." hard link pointing to its parent directory.
> 
> Why does this not happen with btrfs?

Most filesystems emulate that behaviour.  For btrfs, such emulation would
have a bad effect for performance (the kernel would need to either count
subdirectories every time, or store and keep updated such count), thus
this value has been skipped.

And POSIX allows such behaviour.

Heck, if not for POSIX declaring some fields (st_nlink, st_rdev, st_size,
st_blksize and st_blocks) as not required to be meaningful, ext4 would be in
a violation of the spec as it gives st_size of an empty directory as
non-zero. :)


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ We domesticated dogs 36000 years ago; together we chased
⣾⠁⢰⠒⠀⣿⡁ animals, hung out and licked or scratched our private parts.
⢿⡄⠘⠷⠚⠋⠀ Cats domesticated us 9500 years ago, and immediately we got
⠈⠳⣄⠀⠀⠀⠀ agriculture, towns then cities.     -- whitroth on /.
