Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5192C2BE5B
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2019 06:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfE1EbN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 May 2019 00:31:13 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:44424 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfE1EbN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 May 2019 00:31:13 -0400
Received: by mail-lf1-f48.google.com with SMTP id r15so3959767lfm.11
        for <linux-btrfs@vger.kernel.org>; Mon, 27 May 2019 21:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uhO7eAHn3/d75pfzL+Up6zgQ3OL+KN9y2b9e1duLuS8=;
        b=kfL3OdD05eIWhG3qXIcFkUmSuSL8/MSAFLKqFrzAJdC1YX9PeIvHrgK4FZpJ8igDfC
         E/fRn5BtqwOLi8K3flnMGPq0m/WZbN/fpjLoh/C4uZVUg1EPWdS1tkbhy8cuk5Juzoj6
         yKKr86H7KBeY6nJBxb+0KD4L+8yQDoJQkkkWwF6WduxsHIv8alYAX7BFn2haGM5wbq+s
         RhPCxrxiERjKyBU4uH89dx7p76Y9+ndGNszkN2iF2RAVGPr5OB+fp7wv4DtEBdJy+eFJ
         +EQjKJ2jwr5vP6B1t7UfQyjVZ5VHHmA7aTFYiHbvgEpEyHh6RydIigQRfGdL47Hozymq
         k6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uhO7eAHn3/d75pfzL+Up6zgQ3OL+KN9y2b9e1duLuS8=;
        b=ZrZz8ckUUibh6FW5gA/gnKkhOhgFcGLGTnHUyZBKOX47ADinP5/vLTESKoB7AaRtv4
         k6WPSUTVGAZi8xA5viVFxWqOZRYfCKo93zOPKM/OExhLO59n7HskZvWSycJbtbCHflJf
         oTFs8sCDmjmYkFjlywjUnDS21gpR2b/KChgaBVnUv8wH4lb/UDPsWuPbKDoXXzz0nleb
         ntLtVxtMUYVw9J8efxpEVjO5XJHqPoyvppBT0ZP9dFBWIpS8DBmgETJ/v1jCufHqhQcQ
         sfgof1k/tPyWRhWI7wYqUiEKfoXBJFk2J1nD5mJ7UJYbUvL2PKgIlpQDm6KDGC2AEAUF
         RUAg==
X-Gm-Message-State: APjAAAUIizLa6KwJpw0S3SDQtppprygWVMllHEhXlkbkQqqfpkbz+WCj
        GfhGnu32G63/mvEm3YgSgPwio1yF84IObY+r9aS0fw==
X-Google-Smtp-Source: APXvYqxlFDKxSSZw/wFv+WJOh16RInL4JEpMEl0STkQNBtxL9hdR0qQzP3w4D2Qspz6Ny8ZBH5J4lnSi4YPWt8eUmiE=
X-Received: by 2002:a19:f817:: with SMTP id a23mr24252862lff.123.1559017871178;
 Mon, 27 May 2019 21:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <5406386.pfifcJONdE@monk>
In-Reply-To: <5406386.pfifcJONdE@monk>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 27 May 2019 22:31:00 -0600
Message-ID: <CAJCQCtRS1vvaczdpkYjkzWHWZgPxyq_B7XR9tY5yHhGAaBU7qA@mail.gmail.com>
Subject: Re: parent transid verify failed on 604602368 wanted 840641 found 840639
To:     Dennis Schridde <devurandom@gmx.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 27, 2019 at 3:33 PM Dennis Schridde <devurandom@gmx.net> wrote:
>
> Hi!
>
> Yesterday I upgraded from Linux 5.1.1 (built with GCC 8.3.0) to Linux 5.1.4
> (built with GCC 9.1.0).  The next boot was extremely slow and the desktop
> environment (KDE Plasma) never really started, but got kind of stuck in the
> startup screen.  So I switched to a VT and pressed ctrl+alt+del.  The next
> boot stopped early with following message:
>
> [T445] BTRFS: device label <...> devid 1 transid 840641 /dev/bcache0
> [T599] BTRFS info (device bcache0): disk space caching is enabled
> [T599] BTRFS info (device bcache0): has skinny extents
> [T599] BTRFS error (device bcache0): parent transid verify failed on 604602368
> wanted 840641 found 840639
> [T599] BTRFS error (device bcache0): open_ctree failed
>
> How can I recover from this?
>
> The filesystem should have several snapshots (created by snapper [1], on every
> boot and hourly).  Will they be of any help recovering my data?
>
> Best regards,
> Dennis
>
> [1]: http://snapper.io/

What happens if you revert to 5.1.1? That error suggests the super
wants a newer transid than what exist on the filesystem, which
suggests file system metadata was dropped. It's not certain from this
information what caused that: device, or some layer in between like
bcache, or Btrfs.

-- 
Chris Murphy
