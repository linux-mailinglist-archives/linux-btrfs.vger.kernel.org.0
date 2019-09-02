Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31D6EA4D0C
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2019 03:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfIBBJ6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Sep 2019 21:09:58 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:36561 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbfIBBJ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Sep 2019 21:09:58 -0400
Received: by mail-wr1-f44.google.com with SMTP id y19so12250427wrd.3
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Sep 2019 18:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mzYarF0wSA0aGeDbQDpxvqBpthrsExI7uiwtzFUteuY=;
        b=gszlPlcCJ+omW4IEwykXOBPdLhqJAyYTizly/JgYVA5IKr1ZOdjFr7F6k1foPtrJwz
         FP5uMzs7wNBoSWa70c810g5+KPk01e5eJh5dCpEoWE1f99EQ2nvW9oTK/vtGNLQvoKFQ
         oFXiyhQM/RlzFqzWjb7mWl3TcDoZGRm2I34cWcLWFbgDKYUnR+xQjRrJlhGZ79yh63wl
         n5GtRGqGo5xpk7zptv/lv5EGHeok4tbdd+illVmKrNpfUqiD5kx/OnYcuzawM8vM06US
         +Y5C2crXWMlpcNE0rZB+ZMdAQB0ZV84wHFAn4fLwPK9sY+tqy6rcVYy3G2ISabck4uGs
         KQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mzYarF0wSA0aGeDbQDpxvqBpthrsExI7uiwtzFUteuY=;
        b=YEikdWVtVKkffcop74nt8jYntj3q9092eBS84AEvZ48GqgY3/+C3ytRqxVvQsz0Ay0
         hiBXGDK0aWNSdENtTSU+ivWnooUKBHGoE6EkZ5xDCOC34lJjvXAs36vB5QJL7VylOQ94
         G/IkFYI3oDurluh0dnqJIc7YNH9orZ8dtso6fNXyPhTVN4xdXvXjfCrb3tGFZsgrIOmi
         7+/j4KTC6h2KOlaHjKorDpZBZb2OCGBBob2sZyrgt6pcejgRpUK/CK04+75m4W7J8g5N
         ZJUHDWV4rMvBlU/hzoEL53riaDoesM0m3Ve3vQiR6YA2Z3dA3EEu6NSF7aAnQ9ytQoA1
         WVyg==
X-Gm-Message-State: APjAAAXYD69iiBBp1pSX11vIhrUUuswQkHppk9xJmfxQiyXKhg6GwsOc
        MY7lRnm3Q06lb8Qvc7uHebRUWQ3xr8dTWbIXoPBO5jHk3qSkyw==
X-Google-Smtp-Source: APXvYqz9dF5/y1OMhcz+HO0vtXsPFAYSwhfrzLm0MOVGfRQFC6y+GxzQ1KW652Bw0EjPb+u/kBYsc4DRRSI8R7AsSU4=
X-Received: by 2002:a5d:448a:: with SMTP id j10mr2590146wrq.82.1567386595819;
 Sun, 01 Sep 2019 18:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <0b7bfde0-0711-cee3-1ed8-a37b1a62bf5e@megavolts.ch>
 <CD4A10E4-5342-4F72-862A-3A2C3877EC36@seangreenslade.com> <20190901032855.GA5604@coach>
 <6590a3f4-891d-2b22-ed43-4d2def43f290@gmail.com> <20190902005201.GA12944@coach>
In-Reply-To: <20190902005201.GA12944@coach>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 1 Sep 2019 19:09:44 -0600
Message-ID: <CAJCQCtR7_-vkMR=UHB9m_Hxw1K0dEZh6=5me7PfjH-Lp8f5ZSw@mail.gmail.com>
Subject: Re: Spare Volume Features
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Sean Greenslade <sean@seangreenslade.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm still mostly convinced the policy questions and management should
be dealt with a btrfsd userspace daemon.

Btrfs kernel code itself tolerates quite a lot of read and write
errors, where a userspace service could say, yeah forget that we're
moving over to the spare.

Also, that user space daemon could handle the spare device while its
in spare status. I don't really see why btrfs kernel code needs to
know about it. It's reserved for Btrfs but isn't used by Btrfs, until
a policy is triggered. Plausibly one of the policies isn't even device
failure, but the volume is nearly full. Spares should be assignable to
multiple Btrfs volumes. And that too can be managed by this
hypothetical daemon.

--
Chris Murphy
