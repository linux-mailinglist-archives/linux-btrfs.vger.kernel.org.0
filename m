Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0AA23220C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 17:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgG2P6M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 11:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgG2P6L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 11:58:11 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D19C061794
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 08:58:11 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k8so3494180wma.2
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 08:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3uaZCxbcIjzF8WhCYnXBVnBeClrHrfXjOgLked0koSY=;
        b=fRaERT+eUM70+AES2y0P5I+BPlg+9rBaoG7K0VXmZo6bxxDpQiZ2lY7lgA328pBtqM
         gpNG3y2Vj84IVVtrGfZ+/DqT6UB3j5K60TnxXQ3zxIh1zfHnIe63vZ4ow/ChP/8ULMb3
         JoEYORiAB4uB5o4C0AqTcxfl+9jw+liqVTcTnoInkT2at/fGDJU99HBc0XQyY7K1lYN+
         JmewF0GAD8+lIlMpxFW5hZexAP39NwD3yJ2JLxiTejREBraAxjSEnaMsrYcHCSZd7fRx
         JhngI1ihJXNzsro6C63AWYeEUzLdOq15XaK9IrzZP/3KlqiOilWDx99bmNzzT852gvbT
         eHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3uaZCxbcIjzF8WhCYnXBVnBeClrHrfXjOgLked0koSY=;
        b=LF8SxGmp3cn0+7UENAX0i+YnVRQzvlzsQUwEfXBnXOg7MV0CjAj7Pt+40VrsOAHdox
         PZquUF8N/XqAxcL4u+mtBulYavZHGMfzpeYj7LNFONDtGg4nxLmMce/wsN2YQRnqi8vO
         KJ/+IOkRLwQVbS7uV7BnvvGSHZ82iGNo8vDyj0OCZe6340n/NQ4inhKVUGK9Kz/xhQFP
         7vpylSOND7p2zgWX/10R8xpm5FkRZytxWccWTg2EGa+P0aeAmYSuk0PFZfSnJGbhoO+S
         DSrB/4SNWt7aHeIAaUPTXvGDcbdc/Uiiiy5z32VjO6VsOWIrRMbcihaBd6pKnFnX72sI
         N0sQ==
X-Gm-Message-State: AOAM530avZJgQPz6asLSTQiisbkJZ7h7EKvnqzS1BNAZuKeVyhWoMRKT
        rKTk+FxsmgatahwGY6szqJBR17Y0KdVt/nvpvRlXvA==
X-Google-Smtp-Source: ABdhPJxCUWz8sZJVOJH49qnf+YrW7UenJmN7ReUWrpr6FDFFQayxa9ydxBPmI2tqYWoQ10wwecWUl+qgN+C40B0eM6s=
X-Received: by 2002:a1c:e382:: with SMTP id a124mr9385087wmh.11.1596038289447;
 Wed, 29 Jul 2020 08:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR02MB58697B26A91E68507032D9CDAE700@VI1PR02MB5869.eurprd02.prod.outlook.com>
In-Reply-To: <VI1PR02MB58697B26A91E68507032D9CDAE700@VI1PR02MB5869.eurprd02.prod.outlook.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 29 Jul 2020 09:57:52 -0600
Message-ID: <CAJCQCtSGR2uoS7cP-NNOXJpaoNkpKQEj77enzgfZBE5MD9ZxUA@mail.gmail.com>
Subject: Re: using btrfs subvolume as a write once read many medium
To:     spaarder <spaarder@hotmail.nl>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 29, 2020 at 1:02 AM spaarder <spaarder@hotmail.nl> wrote:
>
> Hello,
>
> With all the ransomware attacks I am looking for a "write once read
> many" (WORM) solution, so that if an attacker manages to get root
> access on my backup server, it would be impossible for him to
> delete/encrypt my backups.

Ultimately you have to prevent an attacker from getting root access.
Once they have root access they can do anything you can do with root
access, including merely zeroing out less than 15MiB of critical Btrfs
metadata and render it completely unrecoverable. That this could still
happen indicates a need for independent backups. That is, more than
one set, and one or more sets aren't even connected to this system, or
at the least, aren't persistently connected to this system.



-- 
Chris Murphy
