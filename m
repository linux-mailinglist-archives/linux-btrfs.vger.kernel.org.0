Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F80F1410EE
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 19:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgAQSjq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 13:39:46 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:34036 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgAQSjq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 13:39:46 -0500
Received: by mail-wr1-f54.google.com with SMTP id t2so23708379wrr.1
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 10:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KlBNYqJDpMz7PSfs7VLAkzpHcNduAsao14hlJo0St0E=;
        b=tZJKt+C7khZkSfagkclrPoToinyZQzeAbLv95uQ+cZjJ5VD8ZItDSFHjaDL+SMIfiD
         mPo3rTuF5zD914LuW5CMdNd0B1k7ZiZk9C3HLLo3NgAlGZBsXDZb9nD+WLAjCV9RRrlJ
         /SZLzXtS4xBqqKXwlRB6YslNzKbIUq/0J/QM7dR+gWFuX6VM6eQsvLLDJ3JGqxF8JgZS
         MvtDuZK6z4GDvnZV6LoTB/HgKYUOR6Psq28+440rN9FMWNn39QZ4yXKgJr7Q2WApyLJT
         gWSSJKVrEmVRkKrTtHusYfTwHJ360BBNVvbgs832bQWskzWcYIFtqhLQt/7cY2gMNoDX
         5Hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KlBNYqJDpMz7PSfs7VLAkzpHcNduAsao14hlJo0St0E=;
        b=o/4EO7BXjnt22dgkDluuRVob6HZ9vZo8TbRwVvViZQ/RccT30jH31aZp/7Y/lW0sif
         w/T39eoCO2LKRG7VOZ2BkOI7I3MVe41hplBeNoUkQKVpzUAXDBMSOEJBGNooh3P+xHRr
         yPWxV/D970/fblrCbmYIeKu1uccX6LglQJsUxajT2m2v2XW7YNcmV5UNG+BgIL7Rofpr
         hpJubhdOALUewvfb+bOHxjdXlATHnGieV+4/9rqH7K+WNvW/zyaL3K4I7JFmzbvUjTim
         3DSVwdtCzTZFpKjlNe3n+Rd6xY+DEW9WxrvPfEVnkCpGLidiKdc9NivLlFid+MU5KKwt
         tAVg==
X-Gm-Message-State: APjAAAVtCwH9VeVRqfDFk83HdbCZ8NSGwsUOTErpWH3XUJNjMWrFWahg
        ed4sKQqHZCdCU1GxPEbetff9qBbjXmbZGfRBMEZRI45p148=
X-Google-Smtp-Source: APXvYqy0cioAd8kHhydLG3WM+VwSRF8JraoG5+79zP4DBgQ+sYSZPHiPeOVnAFe/Fn+rYolsfKBlklojAanXkMM83pY=
X-Received: by 2002:adf:fa43:: with SMTP id y3mr4540228wrr.65.1579286383744;
 Fri, 17 Jan 2020 10:39:43 -0800 (PST)
MIME-Version: 1.0
References: <d0a97688-78be-08de-ca7d-bcb4c7fb397e@cobb.uk.net>
 <20200115125134.GN3929@twin.jikos.cz> <5aa23833-d1e2-fe6f-7c6e-f366d3eccbe3@applied-asynchrony.com>
 <20200116140227.GV3929@twin.jikos.cz> <20200117155948.GM13306@hungrycats.org>
In-Reply-To: <20200117155948.GM13306@hungrycats.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 17 Jan 2020 11:39:27 -0700
Message-ID: <CAJCQCtTZMSzNosnognWCyBU+iJ4La=0EG0xBKHEPSDdaAAqt4A@mail.gmail.com>
Subject: Re: Scrub resume regression
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     David Sterba <dsterba@suse.cz>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's no one's fault, it's just confusing. :P

Cancel word origin means more than stop, implies resetting state, to
obliterate or invalidate.

Pause and stop word origin suggests they're interchangeable, but in
practice with digital audio and video consumer gear, stop has come to
mean a kind of cancel. (I'm gonna ignore tape.) Where a start from a
stop will start at the very beginning. Whereas pause saves state and
unpause means resume.

Lightweight change, add new command stop, which saves state, and
cancel is an alias for backward compatibility. No other change.

Moderate change:
start = alias resume
stop = alias cancel
i.e. a stop then start does the same thing as a cancel then resume,
unless new command 'reset' is used
reset = stops, and resets state to the beginning

Heavier change that's linguistically sane, but breaks expectations of
today's cancel:
pause and unpause (alias resume), and start and stop (alias cancel).
The former is stateful, and the latter is stateless.

But this problem should be looked at by i18n folks before changing anything.

---
Chris Murphy
