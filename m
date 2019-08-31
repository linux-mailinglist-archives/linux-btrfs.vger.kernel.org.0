Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7AC4A467E
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Sep 2019 01:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfHaXEZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Aug 2019 19:04:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34905 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfHaXEZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Aug 2019 19:04:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id g7so10373490wrx.2
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Aug 2019 16:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ii7ujd4WkzESDMLCYvqwXAshifDYJbeUwnLvG8y/Jbc=;
        b=1nHzegiW4rKYDCTsPVDIFHbvhjBphRG+fp0P/WHKkq4qCfXXkojPAEc2oF1LWmmNea
         bQzJXzehvqQoeO6d5vuqOBUlWwCLBw7dKTqJiEn0hgeEH01MEkOq4t4RWWepPDi4vBjU
         roehkfg7+HcJ/TxKEvUv7FN57+5/i+2U9x3M+5z52d1p4dhdNASFU+NHmSBcj2d36y5D
         FKb0Q0tDVgwd/JNDB7R6x3+tlum5SjqI+4vXSYlaEE32vqImJo7PkTtOvAqb3w0j3oCp
         idEH5wmEEXKiFUyBX34y2PBeTZiLKUJ/yCOn0X7HRDBSM7GZaeJz2R4jaRDMz3jzTcKJ
         uMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ii7ujd4WkzESDMLCYvqwXAshifDYJbeUwnLvG8y/Jbc=;
        b=Z8iErxCE21NQYKsNLwnJ78dOWZtVMPhrlbQo1r2in08gc+wSjd2VyRTUZdzKAax4mz
         QmKgXweH+zsbGh4a2drVhaR8dySQgQikJQnWFnG0myg1OVB4yoRKi4iKlBBxb1kyb8qO
         KqeQr5W2wA4bWKqAe32z2vuKb3Cep3kG/rhe42Ppkh7Jh/C6GuMcCSOMueefEOZBPBiz
         jubowOClwHI9g7xVPFRaNroSAKWUQhzscm5yzq6x04xQO+OWlHmcy4CvHyqqUhtjjAW8
         br/TjzjfKbzYZ4lTn56T82gYrWvRXga3qpuotmU//uUiggn3cbqImN+QH9YPhExZeb1S
         Ikug==
X-Gm-Message-State: APjAAAW9dbErIzEPJiPIO2UyrKaFfvaG/uJjIS4VCpFr/E0j0k6pIRd6
        X08zAqBUlb4SMhN889rRfl+ztre03Fqa5MhZVCXYwBhxDL4=
X-Google-Smtp-Source: APXvYqyXTb7JuErNusdK9OGGEMUJJKhRiL60O0MF+fTcB6OMY2GxnpDlkZpbkXAcyTB7YYLMzTSOpWPj1s2SrmR4klQ=
X-Received: by 2002:adf:c585:: with SMTP id m5mr10366409wrg.82.1567292662775;
 Sat, 31 Aug 2019 16:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <bdd368bc2e910523525c54844c5c47dd877f1a0d.camel@math.duke.edu> <98252ab04af29eecf51b6c9ecb7f258df56c93ba.camel@math.duke.edu>
In-Reply-To: <98252ab04af29eecf51b6c9ecb7f258df56c93ba.camel@math.duke.edu>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 31 Aug 2019 17:04:11 -0600
Message-ID: <CAJCQCtQRDfMb6=RtT5rNDSj_QT_nJXYx3C-Zzi9baPykHTrDDA@mail.gmail.com>
Subject: Re: block corruption
To:     Rann Bar-On <rann@math.duke.edu>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 31, 2019 at 2:26 PM Rann Bar-On <rann@math.duke.edu> wrote:
>
> I just downgraded to kernel 4.19, and the supposed corruption vanished.
> This may be related to
>
> https://www.spinics.net/lists/linux-btrfs/msg91046.html
>
> If I can provide information that would help fix this issue, I'd be
> glad to, but I cannot upgrade back to kernel 5.2, as I can't risk this
> system.

5.2 has more strict checks for corruption, exposing the rare case
where metadata in a leaf is corrupt but the checksum was properly
computed.

> > Btrfs v3.17

This is old. I suggest finding a newer version of btrfs-progs, ideally
latest stable version is 5.2.1. Definitely don't use --repair with
this version. It's safe to use check --readonly (which is the default)
with this version but probably not that helpful to devs.



-- 
Chris Murphy
