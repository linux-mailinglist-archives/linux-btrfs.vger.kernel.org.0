Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAD51C23F5
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 09:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgEBH4C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 03:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726741AbgEBH4B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 03:56:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAB8C061A0C
        for <linux-btrfs@vger.kernel.org>; Sat,  2 May 2020 00:56:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so14517614wrx.4
        for <linux-btrfs@vger.kernel.org>; Sat, 02 May 2020 00:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0j+Xh4CjW5ElVZzS7RRjztVExT/WMDWx3UfbLAIyv0I=;
        b=xL3OK+QXgtHg0Fr0cK/Ygfyq24tDbc9mtq04BHW/fVBqAKsBVOAMJ2uxtu6KObUEzL
         npAl56R3xuFCAKO2oViGzzfF1ja7/oxyTkmwiKOOy/3C7YAd/VgnZ9xuiTK/yp5KFlZZ
         70WhqctAPTP7YNDR+LhusZcRXsZtbLMLutnJKWdaOzEZlg0QOPpQtJmPX1YzICBLSUk1
         SAiUDWurFEA3SNfpgdF84Oup8WVPCPUdWvHHybcf+ncGjQ4yd6dQscd45s1jKWnBvxr+
         JvcqjDyQDd7tYiCs8vko/LjHHLiTpi/thJ7oq6P6yybzVDgTaSiYAHFytuPdIioeEaOQ
         y8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0j+Xh4CjW5ElVZzS7RRjztVExT/WMDWx3UfbLAIyv0I=;
        b=WqxTZeEQ6qrkMAwupxsJJvY7JqqnsLfNJ2bFwqXf2dvBIVsA/0j5xA4SB/yoNg0TOt
         /o1bMH6fS8ydf0Fxso1HMso3vMhOF8jUu3pRyIu7H83Z+O6k+GC1gk2/q4AN90bfCSz6
         aXhgudv0NWc3ZQC+LYQvmcH4frzi6bJgavmggoa4ba7ZNFtHq6MbLE4wpOjqsUaINTga
         D6XB6qy8b3myVZMdEXj1Om6kD0bfoC4a3nL8mTHAxPurEPPKyKYO42mAMgcWZMsFg/np
         aUkY+geXZZ15VsTtSaFHcKrIKaIRrSIISKzshubthkYYafj3pC5OPv5mRrA6idpStRaF
         ntOQ==
X-Gm-Message-State: AGi0PuY/YXZ7/Ae6Q2HguXQO46/6OAFt4Pqa9OLRVARRmjaSUz8zTyYZ
        RKZDBfH86pJZMVMTqFUEpFNME51AE/XIljtB0JVJMTwp
X-Google-Smtp-Source: APiQypLzicTRwdexF8tMb5Ud9mLgpDlSuX+eLkH7p6fT7xioefa+8hU+CPD1ztckBiP7xJNbDnBa0FXaTMlb82WH1nc=
X-Received: by 2002:a5d:6148:: with SMTP id y8mr7927737wrt.236.1588406160116;
 Sat, 02 May 2020 00:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhjAp1zghNnRpbA2WypBU9+Azeui8kTQiTj+DfbK-iX-z71WQ@mail.gmail.com>
 <CAJCQCtS7mbjEVchwbJS86ujAW+TrKHBk23oYtTNQnruiUr0XSg@mail.gmail.com> <CAAhjAp33Kan3Aco1CWBVh54tatexNs3w=qJqLHq6yQjxzRjjjQ@mail.gmail.com>
In-Reply-To: <CAAhjAp33Kan3Aco1CWBVh54tatexNs3w=qJqLHq6yQjxzRjjjQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 2 May 2020 01:55:43 -0600
Message-ID: <CAJCQCtTTwD1Dq0h3JMPXi1z+yTA8SGFbvft+VLAk_24pGDp0Pg@mail.gmail.com>
Subject: Re: Can't repair raid 1 array after drive failure
To:     Rollo ro <rollodroid@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 1, 2020 at 1:59 PM Rollo ro <rollodroid@gmail.com> wrote:
>
> Am Fr., 1. Mai 2020 um 19:52 Uhr schrieb Chris Murphy <lists@colorremedies.com>:
> >
> > A complete dmesg please (not trimmed, starting at boot) would be useful.
>
> dmesg is spammed with btrfs warnings and errors, so all earlier
> content is already gone. I can increase the buffer in grub
> configuration and provide the complete dmesg next time.

For the current boot:
# journalctl -k
For previous boot:
# journalctl -b -1 -k

> While looking at dmesg I found this:
> [Fri May  1 16:25:15 2020] BTRFS warning (device sdc1): lost page
> write due to IO error on /dev/sde
> [Fri May  1 16:25:15 2020] BTRFS error (device sdc1): error writing
> primary super block to device 4
> [Fri May  1 16:25:15 2020] BTRFS info (device sdc1): disk added /dev/sdb
> [Fri May  1 16:25:49 2020] BUG: kernel NULL pointer dereference,
> address: 0000000000000000

This might be related to the device vanishing. The actual problem(s)
happened before this. This is just the consequence of the problem.


-- 
Chris Murphy
