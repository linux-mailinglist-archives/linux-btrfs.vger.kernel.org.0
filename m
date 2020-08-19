Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2974B24A9C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 00:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHSW6u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 18:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgHSW6p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 18:58:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5826CC061383
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 15:58:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c80so3645479wme.0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 15:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OgK1MCgpPhEyKdpI6E11FXxu07NX2wkWvImgYHGvMzo=;
        b=dBee0qDkVpFH3ka/yH/WX+vNUaKq3fpDM4oLXAzn8oOZ++e1UbWyXN83UyU/b1MjlI
         jIECwviGYCbtb3n1bvxaiVbCLh0Jbmn29WUk+UCLl4ohCL/hyShJdaYVGFAWGgWEM1bd
         GklCcX0lWDfpZxe0pD+LrXxivai2hSowbpWQBHuq0RvW5MM9Sc6zq5HXH01G7L67oeYu
         SmJhCEKWzq7Dmh1ZDE5tsRj4oYKvw4N8vs1pllfJ3y/391lxKGEeSA2Mo/ZYs5TeeCEX
         RSVE8i7nq/AXwCxsr01mv3qnsqYEqmuQd8LDyLmk/dSWW57JqkKiVqjcL2uReDtjvBYi
         P8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgK1MCgpPhEyKdpI6E11FXxu07NX2wkWvImgYHGvMzo=;
        b=Xk0GscOJLNPz13cjRqFn6K8OrPLKFgXFJ83ap3HmIBg7xI3tMxMS2X13HtR5SiyPjg
         MYrlamjhSWcgUbqBEAnTltrI2WPSxKfUOtYVxjulnNXIz5W+ELNqXaKzF0N60qym+9KQ
         SJEbTUUmYsw6wMguBGzP9xUJAjGH+wivU9gXKBpanHypzi+o18lrMswAdjItsdbrSDcl
         8CPnAe3SCOoLoEDBDYUqyyCUxpK1n3ZNgtP35HWKdzgqCbU7bo2PVncJpSBqmbRn93Fk
         Y8+8CliUqLH1vUzk+iTy/2HpApoolY/f7ntcSl1dm1pYCRgrIpD4gP9YJtY0OkUAOfn1
         JqxQ==
X-Gm-Message-State: AOAM532BV5SjT+a2qPNgpPWUhbl0Y7HFB6nkHeQ7w8pjaS9LZLsrdIJc
        qvvo7nDkplniU3Y7uOfYApbqvzqic1z6JB/F5eGP9w==
X-Google-Smtp-Source: ABdhPJw9YwL2k9GzSFOCYosgh7Xv8zWbyw62vLe3UoXdWEvjv2XJIeClPdoe5nNbX+PauYRN3G1x1qgPYq9FACKpXSU=
X-Received: by 2002:a1c:5581:: with SMTP id j123mr497261wmb.11.1597877923880;
 Wed, 19 Aug 2020 15:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz>
 <CAJCQCtSfz+b38fW3zdcHwMMtO1LfXSq+0xgg_DaKShmAumuCWQ@mail.gmail.com>
 <29509e08-e373-b352-d696-fcb9f507a545@xmyslivec.cz> <CAJCQCtRx7NJP=-rX5g_n5ZL7ypX-5z_L6d6sk120+4Avs6rJUw@mail.gmail.com>
 <695936b4-67a2-c862-9cb6-5545b4ab3c42@xmyslivec.cz> <CAJCQCtQWNSd123OJ_Rp8NO0=upY2Mn+SE7pdMqmyizJP028Yow@mail.gmail.com>
 <2f2f1c21-c81b-55aa-6f77-e2d3f32d32cb@xmyslivec.cz>
In-Reply-To: <2f2f1c21-c81b-55aa-6f77-e2d3f32d32cb@xmyslivec.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 19 Aug 2020 16:58:05 -0600
Message-ID: <CAJCQCtTQN60V=DEkNvDedq+usfmFB+SQP2SBezUaSeUjjY46nA@mail.gmail.com>
Subject: Re: Linux RAID with btrfs stuck and consume 100 % CPU
To:     Vojtech Myslivec <vojtech@xmyslivec.cz>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Michal Moravec <michal.moravec@logicworks.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 19, 2020 at 11:29 AM Vojtech Myslivec <vojtech@xmyslivec.cz> wrote:
>
> Linux backup1 5.7.0-0.bpo.2-amd64 #1 SMP Debian 5.7.10-1~bpo10+1

Should be new enough; I don't see raid related md changes between
5.7.10 and 5.7.16. I haven't looked at 5.8, but 5.7 is probably recent
enough to know if there have been relevant changes in 5.8 that are
worth testing.

>
> - `5.7_profs.txt`
>   - dump of the whole /proc when the issue happened

The problem here I think is that /proc/pid/stack is empty. You might
have to hammer on it a bunch of times to get a stack. I can't tell if
the sysrq+w is enough information to conclusively tell if this is
strictly an md problem or if there's something else going on.

But I do see in the sysrq+w evidence of a Btrfs snapshot happening,
which will result in a flush of the file system. Since the mdadm raid
journal is on two SSDs which should be fast enough to accept the
metadata changes before actually doing the flush.


-- 
Chris Murphy
