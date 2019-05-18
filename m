Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00E902216F
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2019 06:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfEREOw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 May 2019 00:14:52 -0400
Received: from resqmta-ch2-01v.sys.comcast.net ([69.252.207.33]:54274 "EHLO
        resqmta-ch2-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725294AbfEREOw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 May 2019 00:14:52 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 May 2019 00:14:52 EDT
Received: from resomta-ch2-10v.sys.comcast.net ([69.252.207.106])
        by resqmta-ch2-01v.sys.comcast.net with ESMTP
        id RqaDhaY0ALJtxRqcOhkQYw; Sat, 18 May 2019 04:06:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20180828_2048; t=1558152404;
        bh=0OcCHr9RkLA3qkco2iBIKV3IQMFeIStU24wDd0okLOE=;
        h=Received:Received:To:From:Subject:Message-ID:Date:MIME-Version:
         Content-Type;
        b=fAGnrP6YbVf0Xl3ISwmY2i/E/COGCd3hV81Ma9hAye+Ah5C0Qygz2mLRmmjQmgCnh
         lRB9rzBNWjEAmu1wMllEmvOz5pbU4V70MafHOtNjpXCc21PQiUnjHRRAFNUX60RLF9
         eb8SsyeI8foEwLe+jefEhvCmv+Nso346rTzIPGKB7ls0qJ+gHgQl77/4mFxXPvD2Su
         +UmM4R58fFqe8fjVWyqsnlmjx1MLO4KcqqjUJZmEF3H3s/Cyr5hVqHFtMzU8miwhkL
         GjktbR7sr/IF96qHG4aLImMBK/mYdHmRk7SYbx2OZ+4Mt83l2LVuNHo9GvXNMzsyO9
         lWne7Yjq5n8dA==
Received: from touchy.whiterc.com ([IPv6:2601:601:1400:69b3:5588:da99:221d:2c69])
        by resomta-ch2-10v.sys.comcast.net with ESMTPSA
        id RqcKh68HSjSzwRqcLhSUYF; Sat, 18 May 2019 04:06:44 +0000
X-Xfinity-VMeta: sc=-100;st=legit
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   Robert White <rwhite@pobox.com>
Subject: Feature Request: Directory property to upconvert mkdir/rmdir to
 subvol create/delete
Message-ID: <a108b077-ff18-7c6d-ac5c-ea666de48084@pobox.com>
Date:   Sat, 18 May 2019 04:06:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Howdy,

For several reasons it would be really convenient if there was a way to 
mark a btrfs directory such that the directories created in the marked 
directory would actually be automatically converted to subvolume 
creation and destruction.

NFS4 particularly pivots on file system boundaries, which it seems to 
include subvolumes-in-place as such boundaries.

doing this to /home is another opportunity if you have transient 
accounts created by scripts/programs you cannot easily change.

Other uses include creating virtual machine sets via tarballs and such.

It would also be super useful in apps that create large cache 
directories that you'll eventually drop in bulk. /usr/src is another 
place where large directories come and go under installer control.

The core logic would be to upconvert any legal rmdir to a subvol delete 
if it's applied to a subvol. Yes, this _would_ remove non-empty subvols, 
that would be the point. Then any mkdir in that directory would create a 
subvol instead of a directory.

Normal files in the directory would be unchanged.

And a normal directory moved into the directory would remain a normal 
directory for obvious reasons.

And a subvol moved out of the directory (can you even do that?) would 
remain a subvol for equally obvious reasons.

It's implicit that the non-superuser create/remove subvol operation 
would be legal for such a directory.

Programs could be rewritten to do this explicitly, of course, but that's 
a heck of a lot of impractical patching.

Anyway, just a thought I've had repeatedly that I finally thought to broach.
