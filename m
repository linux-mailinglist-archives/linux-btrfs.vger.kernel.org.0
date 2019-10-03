Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22606C9E33
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2019 14:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfJCMSo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Oct 2019 08:18:44 -0400
Received: from mail.render-wahnsinn.de ([176.9.37.177]:39062 "EHLO
        mail.render-wahnsinn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfJCMSo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Oct 2019 08:18:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with robert.krig@render-wahnsinn.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=render-wahnsinn.de;
        s=dkim; t=1570105112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jK3zUHg9GG2rEr4fns1LeqkLAc5l/aq97RevNOqEt6w=;
        b=GI2/tqweOnFa5gbSKHRH5ll37VQT9+aqqxMBQUC1+Lw2xkFRoodn2+fsLojlKkwETGhrba
        LHJzLDk+Ke2NBYQFRogD2kUGdWKE4Rc2vRz/gs2YuEk+TKKoJpN/xH48CR7aDxv7eZXtwm
        FDVZxBo/onACdRFVZm01Mw9pOAra65ZCtBqyyf9T8NbXSzdlo4zHgbDAAgtaR/TEVWHVd5
        DaRUkehUqC5ACwWwzn6OZT4tiZout7WqP+X8V6x8bVQ4hPV0Tynv1FL+1KqZVaOmyBKS2W
        Qg8+hHRYP34lisNlS7CGfA02tHojF4Pf5vo0rFUt3XYDrEFdujOtKnXe1bvMVw==
Message-ID: <498f23ebd3889618cb3faedf04c72ff059553121.camel@render-wahnsinn.de>
Subject: Re: BTRFS Raid5 error during Scrub.
From:   Robert Krig <robert.krig@render-wahnsinn.de>
To:     Linux Btrfs <linux-btrfs@vger.kernel.org>
Date:   Thu, 03 Oct 2019 14:18:32 +0200
In-Reply-To: <273d41c4d05283aaa658d9c374e7c43199b0aac3.camel@render-wahnsinn.de>
References: <804e7e93a00dfe954222e4f8dc820a075d9ccb79.camel@render-wahnsinn.de>
         <0fdd1282-f370-b55e-0c3f-486ad8673bcd@suse.com>
         <3616237f8d39c87abcc9b118b8441cfecf36eeb6.camel@render-wahnsinn.de>
         <CAJCQCtQcKRN09wpbSmguNQ8bSq5VZEk2JNwLOWcsAK7YYJD2YA@mail.gmail.com>
         <273d41c4d05283aaa658d9c374e7c43199b0aac3.camel@render-wahnsinn.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=render-wahnsinn.de; s=dkim; t=1570105114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jK3zUHg9GG2rEr4fns1LeqkLAc5l/aq97RevNOqEt6w=;
        b=jLlQhG86dw+8kxNLkNkeucqjqU/LqsM8/157LlUyuU2SbaMz1lW6uJWgbKtjiHJotCHqZA
        RAjzvb8SLh3fT6o8sS1DRcFPrs9Yeb9CZlNReuarDm0LmZmk483vZfuzF3GO8mhLSVLw5P
        X4PN1ixJgy2eYedOqhULD5Y0+JOfcpW6gHF79sRIdLnNSAhMQEXyaVW0wmESrivpAwFC2L
        cUZoAeB2kiMtJwL3VbPbaPtanIpYqxnLm1DCZ85HKLPUmic36mLeY+MKOi0tBF37Nouw8n
        bBkCPwgaeuYeGtJgdRsJ1+Ag46AErxFq+StnQ3ehp6VbMhtH69ZCdEl/hZDUmg==
ARC-Seal: i=1; s=dkim; d=render-wahnsinn.de; t=1570105114; a=rsa-sha256;
        cv=none;
        b=hC3ehZdfXyV+WinhZ9IyQDWzEdzAUaUjBApsHRKVRmwch1ZE8cFP8GqwGQJDtPtX0ol97I
        rUBWP/VqurANPuqiRvjEA0GQ4vY9O14AO1aegh6b+UL9d1xSlK06MH8NybVVbBu2SOmxmG
        iAZtTzjNbPyD9k4WcW5Hmu/zmJ/yhS0+wNjoYwXZcLOq9VKtH+fc2QbowsDutw1anbnr9v
        BiwCxDNa+bVjV82LPZJ4XG9o7+JG0r4Cy3aPsfvNBPRZuLqZ552beF8pFo3L4irJlywtBF
        vMbq5kFQcVYQhGWCuCzkF+FUrDE2Tu+OCA7QME7fQSl9ZyaFBkEIvwF9RY2l1Q==
ARC-Authentication-Results: i=1;
        mail.render-wahnsinn.de;
        auth=pass smtp.mailfrom=robert.krig@render-wahnsinn.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

By the way, how serious is the error I've encountered?
I've run a second scrub in the meantime, it aborted when it came close
to the end, just like the first time. 
If the files that are corrupt have been deleted is this error going to
go away?



On Mi, 2019-10-02 at 12:17 +0200, Robert Krig wrote:
> Here's the output of btrfs insp dump-t -b 48781340082176 /dev/sda
> 
> Since /dev/sda is just one device from my RAID5, I'm guessing the
> command doesn't need to be run separately for each device member of
> my
> BTRFS Raid5 setup.
> 
> http://paste.debian.net/1103596/
> 
> 
> Am Dienstag, den 01.10.2019, 12:10 -0600 schrieb Chris Murphy:
> > On Mon, Sep 30, 2019 at 3:37 AM Robert Krig
> > <robert.krig@render-wahnsinn.de> wrote:
> > > I've upgraded to btrfs-progs v5.2.1
> > > Here is the output from btrfs check -p --readonly /dev/sda
> > > 
> > > 
> > > Opening filesystem to check...
> > > Checking filesystem on /dev/sda
> > > UUID: f7573191-664f-4540-a830-71ad654d9301
> > > [1/7] checking root items                      (0:01:17 elapsed,
> > > 5138533 items checked)
> > > parent transid verify failed on 48781340082176 wanted 109181
> > > found
> > > 109008items checked)
> > > parent transid verify failed on 48781340082176 wanted 109181
> > > found
> > > 109008
> > > parent transid verify failed on 48781340082176 wanted 109181
> > > found
> > > 109008
> > > Ignoring transid failure
> > > leaf parent key incorrect 48781340082176
> > > bad block 48781340082176
> > > [2/7] checking extents                         (0:03:22 elapsed,
> > > 1143429 items checked)
> > > ERROR: errors found in extent allocation tree or chunk allocation
> > > [3/7] checking free space cache                (0:05:10 elapsed,
> > > 7236
> > > items checked)
> > > parent transid verify failed on 48781340082176 wanted 109181
> > > found
> > > 109008ems checked)
> > > Ignoring transid failure
> > > root 15197 inode 81781 errors 1000, some csum missing48 elapsed,
> > > 33952
> > > items checked)
> > > [4/7] checking fs roots                        (0:42:53 elapsed,
> > > 34145
> > > items checked)
> > > ERROR: errors found in fs roots
> > > found 22975533985792 bytes used, error(s) found
> > > total csum bytes: 16806711120
> > > total tree bytes: 18733842432
> > > total fs tree bytes: 130121728
> > > total extent tree bytes: 466305024
> > > btree space waste bytes: 1100711497
> > > file data blocks allocated: 3891333279744
> > >  referenced 1669470507008
> > 
> > What do you get for
> > # btrfs insp dump-t -b 48781340082176 /dev/
> > 
> > It's possible there will be filenames, it's OK to sanitize them by
> > just deleting the names from the output before posting it.
> > 
> > 
> > 

