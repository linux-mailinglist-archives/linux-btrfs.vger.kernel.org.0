Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99089112E26
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2019 16:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfLDPQv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 10:16:51 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40402 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfLDPQv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 10:16:51 -0500
Received: by mail-lj1-f195.google.com with SMTP id s22so8547818ljs.7
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 07:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tmarques-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ph8Y8j+hBTugbQ5VjBbMMYHJb85xngXcGihNKTruvp8=;
        b=m03F9CLHT20EZec5RC1hGlWf5RJqOaS56T+2PVCEACVvmXYZxhWfdwSWbVNTry4uX5
         AgpeebSQw1cT1PYyrJw8h6s8QDfAX3yoBybsE65a2xAb2nozTjSSebvstg7d5Aodk9A/
         im+8Lox5xRQgh1mrntywRaXOcLgHYTnbALx7ElCnr6n9a2yWdoEZgmnazswVa6Qm2agL
         WUReL7vbDhi+eHMcWv5C3CU/Q8UjyZn2/oC8/06Roxj/jNYwc9yimMefDUY/vV0e6OEO
         6gFmugVJDyh0m8LxPzNWQztghLhn7ZZt54fNzZqBwRD4FZ9Ad45ueImVVS5J4BDfD09v
         1cZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ph8Y8j+hBTugbQ5VjBbMMYHJb85xngXcGihNKTruvp8=;
        b=sCE/7g44Z9MaswWgqmV831oLlnFWZqOIo6ntmqkk1MJpVla9eCwTlagpnM+0G5VEmO
         fbVgbLX7S/3FJ6xcGB4Ynagg9+7FUW3cL1xWTk2HS5cVlO+soUFtsuV9/TTKPcdOd20o
         MjjcmSUcl8N2xLBbqeq+64HUS0639f63di9gRt6qLZ6cLYo8wR/TEpPaLtUHaxnE/Y5w
         ll0RyqxDrTsxvQ+1OIfH+1rt7kBpKF8hq0A+EMRwalzwfILLCIJe8DiZTH4cP6j0Zbmh
         yH/Nc2aQFS2BFqUJ9ZjX4/qWq3xG8o9LEC1oEbyjzWFhd6Bd1d3HLi/q3gJ6HaOf7JbQ
         jP6A==
X-Gm-Message-State: APjAAAWCYo53N7XYQFvrTDy9jOTvINzbjCThqxf7MIWsPdcFZKVQlLYA
        qWj8FTGWskVRKIZFB79ZF0CjcIdRzuwjYTqVp3VW4BpNV1JDug==
X-Google-Smtp-Source: APXvYqxEGyusTxQFenQeAqeyiDBcukQzuA74nLsV9McjJGLJhCMdKJT62mwahoCR+bfif5S/XiuEvtIJygpKZYrGOGw=
X-Received: by 2002:a05:651c:29b:: with SMTP id b27mr2262442ljo.31.1575472608883;
 Wed, 04 Dec 2019 07:16:48 -0800 (PST)
MIME-Version: 1.0
From:   Tiago Marques <bugs@tmarques.com>
Date:   Wed, 4 Dec 2019 15:16:31 +0000
Message-ID: <CAF6-ow=qsPEyZEPjNhacX8Hipnk69hXfQOiVQ_x+FajEU67RqQ@mail.gmail.com>
Subject: Can't recover space from deleted inode
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi everyone,

I stumbled upon a bug on one of my systems where I can't seem to
recover space that should be free. This is non standard though:

1) Was downloading an ISO with wget,
2) By mistake on another terminal I deleted the temporary file,
3) wget kept downloading but couldn't move the temporary file, so it
exited with an error (I realized something had gone wrong),
4) I use 'df -h' and notice the size of the ISO file is missing. After
reboot and 'btrfs scrub', can't recover that free space.

Is this a bug and is there a tool that fixes this. I've read the wiki
and manuals and BTRFS doesn't have anything that checks correctness of
the filesystem?

Best regards,
Tiago Marques
