Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B51C6257D4
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 20:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfEUSzJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 May 2019 14:55:09 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:38003 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfEUSzJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 14:55:09 -0400
Received: by mail-qk1-f172.google.com with SMTP id a64so11749666qkg.5
        for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2019 11:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k5xaw96/dfaoDX1daZgouVzHGykgESQleSuEqXdRJoM=;
        b=jFu5O98nLl3Ii6ATga0L17p6fzdQi3AZBt+tz3FnyXUO+FVXHX2LpIBC+/RKSUYwBE
         vM4/bQfDHqf0/pap/shvaRN1dbN46/GBLo1+Q/pVs08Zgc1J5ekgl3iGt8kCs4tvDT0e
         yNvJlHDN7/2MSqt/qD4y8xT+81KDZIjURYZptM5NqeKIxood+08RCPQTMqGDlZnytKuf
         fkD7SR7Gm+EYlNIMsHnmMQwAZqvWRG60e4j9YmEWsjoLMEq+3ZJTU04ta3r9zzOVXfJk
         ODnLwte7obHihlHQ7uHHHk+t3b9DWeOW892BKHsDbDJB04Lb1tyCPA0iAFa08pSjCmjo
         ukBQ==
X-Gm-Message-State: APjAAAWFu4iPfK0FIMrwyb2siy7/NIuB4z5II3axiGcl/7dNw2o35GXR
        DZCbhdr7TvAw3BFkzaRAWlWVZUl0junRoE4fxIg=
X-Google-Smtp-Source: APXvYqwFYb7MTqr7itDgsrm+BZMTT1UgiFT6j1UXP8KS/aowOxOSd103xJhIwM9rROS8dGrWSX9YxZsUevJ5ATTuce8=
X-Received: by 2002:a05:620a:12da:: with SMTP id e26mr22850981qkl.132.1558464908183;
 Tue, 21 May 2019 11:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <297da4cbe20235080205719805b08810@bi-co.net> <CAJCQCtR-uo9fgs66pBMEoYX_xAye=O-L8kiMwyAdFjPS5T4+CA@mail.gmail.com>
 <8C31D41C-9608-4A65-B543-8ABCC0B907A0@bi-co.net> <CAJCQCtTZWXUgUDh8vn0BFeEbAdKToDSVYYw4Q0bt0rECQr9nxQ@mail.gmail.com>
 <AD966642-1043-468D-BABF-8FC9AF514D36@bi-co.net> <158a3491-e4d2-d905-7f58-11a15bddcd70@gmx.com>
 <C1CD4646-E75D-4AAF-9CD6-B3AC32495FD3@bi-co.net> <CAK-xaQYPs62v971zm1McXw_FGzDmh_vpz3KLEbxzkmrsSgTfXw@mail.gmail.com>
 <9D4ECE0B-C9DD-4BAD-A764-9DE2FF2A10C7@bi-co.net> <CAK-xaQYakXcAbhfiH_VbqWkh+HBJD5N69ktnnA7OnWdhL6fDLA@mail.gmail.com>
 <ea5552b8-7b6a-2516-d968-c3f3c731e159@gmail.com>
In-Reply-To: <ea5552b8-7b6a-2516-d968-c3f3c731e159@gmail.com>
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
Date:   Tue, 21 May 2019 20:54:56 +0200
Message-ID: <CAK-xaQYT_m2UV0w_MLbpGAb-ckyVc1YLnGdpX42eQRj1JZf4WA@mail.gmail.com>
Subject: Re: fstrim discarding too many or wrong blocks on Linux 5.1, leading
 to data loss
To:     Milan Broz <gmazyland@gmail.com>
Cc:     =?UTF-8?B?TWljaGFlbCBMYcOf?= <bevan@bi-co.net>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Il giorno lun 20 mag 2019 alle ore 18:45 Milan Broz
<gmazyland@gmail.com> ha scritto:
> Note, it is the root filesystem, so you have to regenerate initramfs
> to update crypttab inside it.

Good catch. I didn't re-mkinitramfs.

> Could you paste "dmsetup table" and "lsblk -D" to verify that discard flag
> is not there?
> (I mean dmsetup table with the zeroed key, as a default and safe output.)

This weekend if I have time I'm going to re-test it. It takes a lot to
restore 4TB.

Thanks a lot,
Andrea
