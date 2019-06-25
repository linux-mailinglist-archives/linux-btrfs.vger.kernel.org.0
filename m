Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6810520BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 04:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfFYCuJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jun 2019 22:50:09 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:50655 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbfFYCuJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jun 2019 22:50:09 -0400
Received: by mail-wm1-f44.google.com with SMTP id c66so1204174wmf.0
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2019 19:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iNLE8Hp72KS23kyT7KOxOfz9fGghpkbCxSQyLEfyl2Y=;
        b=EK5dbUzWc295764xepwfeGsiHAQHZyjvfTX3jpH8zxC6Bva4+FsiLUDz9NEPf9PvaB
         XX/6AvQyV4h84FwwBwRNAvhGddv+gA7uMWb46OZ1iQnBSIGf+HpnALequIgRBsblJlGF
         46JjitwRfDLUhcRqvYtTKwf6XXG3091Cz1vY/ZhsKzc0cXW3UoYzMmzRGU2a0b7wruwx
         bv+2zS7oIoeJV1fJPrODmfM0csToR5mFD8tdqdriZprjRa1+lJ8nNB/nqgR2g3v4kAqM
         vAtSmwrhJczBIb6x5CNLD7v1pfM270UoVDzKacBoWmKoLE9KIfAlXq9Si74mFyrKb09p
         dXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iNLE8Hp72KS23kyT7KOxOfz9fGghpkbCxSQyLEfyl2Y=;
        b=WGWldLuHDT7ixphIw7PRI7To2uZ4O4mjfBU3sNDpr/iTFe/BhTnvhE/UR27rOPzR44
         3JQxFtq2lv+FGW5pYYWlk2j+sY7Reet0yNBXHA4sp4Zl0a9k+a5KpKfadXr7bZHM7P8X
         VLtxuUftsbSAeYmTUMrqDO9awxmxYRx6MiJarC3LDLK7WDGskk3gOmUmPpTCoWIwiU3v
         fOuVxWJnUHtbk+uq0Xz48hkOq4uUz43E3dsB93FxoSWZYF44eBDuusdGN9g/gBLmv2me
         XmFXcfkXCVGmlmEcTEz2ArIW4wODmhYuyYRbJdNyNQvtY45p1LsGO/7JC/qMStvMBWVU
         /QbA==
X-Gm-Message-State: APjAAAVtbU6xUu/71z/OA6FvSm2hvF214X44ZOTvdCNYH9qKnQvN9Hmj
        v2wYmCLr2JFsIK5sYiGG2EdKYVppxZOnFt5GTq/Aew==
X-Google-Smtp-Source: APXvYqzHU6Rgti1NQ9Hjyo5wLQkixjN2ESP1eSc9rDapgBPnfd58DeY0bB0kw8a2FNQLsQLqON5M0CTsODFAtX+8x3U=
X-Received: by 2002:a1c:2c41:: with SMTP id s62mr17905534wms.8.1561431007337;
 Mon, 24 Jun 2019 19:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRNn9WFQc2VHc8uHg-Uoe7iKq0zOu6qA1OjBBP_O4385A@mail.gmail.com>
 <e55aab31-58c3-e736-d95e-9e5324fa0b5c@gmx.com>
In-Reply-To: <e55aab31-58c3-e736-d95e-9e5324fa0b5c@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 24 Jun 2019 20:49:56 -0600
Message-ID: <CAJCQCtT8SE5TYkVniJxhK5ZpE8OoE6c9AVPzs4baHn8C5y5X5w@mail.gmail.com>
Subject: Re: 5.2rc5 corruption, many "is compressed but inode flag doesn't allow"
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

False alarm, not a new issue at all!

I have a different system on kernel 5.1.11 using Btrfs as root with
persistent systemd-journald storage, and compress=zstd. And I never
have problems with it, so I never run btrfs check on it, until now.
And yep, same problem. All the journals that have been rotated, are
zstd compressed, are nocow, and btrfs check complains about them the
same way.

root 257 inode 62526 errors 1040, bad file extent, some csum missing
root 257 inode 62734 errors 1040, bad file extent, some csum missing

Turns out this is just btrfs check noise. There's definitely no
corruption. These files still pass journalctl --verify which is
checking its own internal checksumming in the journal file.

I don't know what's best practice. I think on any kind of flash media,
I'd rather not have +C by default, so that the logs compress on the
fly, and also rather not have defragment on rotate because that also
just increases wear by rewriting everything. Yes the journals are
heavily fragmented if they are allowed to COW, but I don't think I
really care about legacy files being a little slower on flash. *shrug*


Chris Murphy
