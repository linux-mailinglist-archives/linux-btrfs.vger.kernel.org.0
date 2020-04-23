Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14201B544C
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Apr 2020 07:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgDWFmi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Apr 2020 01:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbgDWFmi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Apr 2020 01:42:38 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31FDC03C1AB
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 22:42:37 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x23so3743937lfq.1
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 22:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wj/2rmWWkfM0zSAjkOrp18fglx61jovBIDPlrAz5AKo=;
        b=LGFtU4Kze0KIeFdF5ACjF2naUAYAgLNna+QlLjje4zUbgter5bY8PW+mwv450Exs3k
         7kIDJ2uO0iDCczn7rfQ4FtCx97Rk0vYIdvbdHGHRmAmKrHmJXXRZrSYJ9W/SyRXA/fKa
         rJ2xLfR/Z8t1HEqpgzXuVoN1XQBJlnr3NCeGLQ4xEcmJUEXiMwzsPJpNNG+8+QPUxKvO
         aRbDDraPLgk2WPvWRioGzgScvnDmI7ZhB/aCOiti9qNy+WeGo185Z7qlRs27/bGO5p5R
         6SjycTWMBFCbGbAGJesc8cQOGGtPfrnLlhERm37QTuJLIzk9O9Nfesi8Tcmg/XMGvvnE
         gG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wj/2rmWWkfM0zSAjkOrp18fglx61jovBIDPlrAz5AKo=;
        b=KihknwytdFpb6XS9JKJ4UpOIrq1CF/+SLryuC8An/6qUwsueYd+wxd8wfGMIEEI629
         jgOEJfT7ewSBXceHv2ipxBqQ5nvplHMD+n+rfhDhIq9RV48dFchi5CvC97pIvT7ItbPf
         2uoPAs0EjADN68rG7vaMgZIy9zsuVYmdqmLtsjqwz6dkKj/dk28UDHqRbYqOvPdZPx5M
         MHUCRM3VeJEuGSXG/T6lLT8qqwKf2MnBNmgghdf1bxrqODcI5iPesNpIbkzFsAbtu3XE
         v/rQCZmjAKAR52GoPjFIVMban6fh3V37BUeYehsnfBWOn5cmddJUDvpbEutNm0YhFsXC
         4N6A==
X-Gm-Message-State: AGi0PuZdARifvB2ZR6oB4o/mXCSB2aPW8R2IeauBkt1EiBOH0bB1xeS8
        4SmGTT3m668Z/UJTfW+up3NiaM2z
X-Google-Smtp-Source: APiQypIPeZT0LeSZeWnfYHnugBb3HRqQe4sW3efYxPHCv0v55Ys6srKNpO9jfaNntnndca4PXexISw==
X-Received: by 2002:ac2:58f6:: with SMTP id v22mr1280235lfo.146.1587620555878;
        Wed, 22 Apr 2020 22:42:35 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:48ee:3630:6817:757e:9dcf? ([2a00:1370:812d:48ee:3630:6817:757e:9dcf])
        by smtp.gmail.com with ESMTPSA id d22sm803435lfe.75.2020.04.22.22.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 22:42:34 -0700 (PDT)
Subject: Re: RAID 1 | Newbie Question
To:     Chris Murphy <lists@colorremedies.com>,
        Stefanie Leisestreichler 
        <stefanie.leisestreichler@peter-speer.de>
Cc:     Hugo Mills <hugo@carfax.org.uk>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <be4ee7ea-f032-ee63-2486-030b2f270baa@peter-speer.de>
 <20200422104403.GE32577@savella.carfax.org.uk>
 <d59a8a2e-2aae-0177-a0a8-6c238776814a@peter-speer.de>
 <20200422110646.GF32577@savella.carfax.org.uk>
 <e000c0cc-132d-04ad-dcfd-d808efbff76d@peter-speer.de>
 <CAJCQCtTrRshj-oQrJEgaAR=wmuUtTT0fYsFAM0W6QtwUBBgw-Q@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <93197ca4-2c91-8c16-b8df-90a26577b25c@gmail.com>
Date:   Thu, 23 Apr 2020 08:42:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTrRshj-oQrJEgaAR=wmuUtTT0fYsFAM0W6QtwUBBgw-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

23.04.2020 00:13, Chris Murphy пишет:
> I haven't looked at the wiki in a bit so I'm not sure if it points out
> two common gotchas:
> 
> Mismatch between SCT ERC and SCSI driver (used by libata and maybe
> also usb) timeouts. Btrfs needs explicit read errors on bad sectors to
> do automatic fix ups, same as md.
> https://raid.wiki.kernel.org/index.php/Timeout_Mismatch
> 
> There's no automatic degraded state for Btrfs. And it is not a good
> idea to add the degraded mount option to fstab, as it can result in a
> kind of "split brain" corruption. In the case of member device
> failure, at startup time the mount will fail and you'll need to
> manually mount degraded and fix the problem resulting in the need to
> mount degraded. An alternative is maybe modifying the current btrfs
> udev rule, to timeout after a decently long period of time to ensure
> it's really a case of needing degraded mount, rather than merely a
> slow or transient effect that just needs a delay so that all member
> devices are available when mount is called. But I don't know if udev
> has a concept of waiting. For mdadm this is done in the initramfs.
> 


mdadm starts per-array systemd timer via udev rule when the first member
device is detected. When this timer triggers (it is expected to trigger
before normal systemd device wait timeout) timer starts service that
effectively calls "mdadm --run".

If btrfs exposed filesystem in sysfs immediately when the first member
device was detected and also checked "mountability" every time member
device is added, similar mechanism could be implemented. Or dedicated
service that makes decision ... the primary problem is that currently
there is no way to know how many devices are there or whether these
devices are enough to mount filesystem even though kernel does know this
information.
