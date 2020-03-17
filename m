Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B56A1890B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 22:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgCQVm5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 17:42:57 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:41263 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgCQVm4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 17:42:56 -0400
Received: by mail-wr1-f50.google.com with SMTP id f11so10923757wrp.8
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Mar 2020 14:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QVFYrpFR0oMouUJgN0zBItapwy5WhlESQhE9+NondGk=;
        b=yFfzjQYFgeA0jGNhNZcVEDdQRCmTH/AsLfrKR/K25uVVDIHYpmTDDEVvMEp8siUd6B
         OrOzNvE5VZ99klyLN9P9lSHIwJIHfIRn7N1sP56qvEOJHRff6cKRL+KCWxOH6OEow3Dt
         KYWtUHN9RzSzfr9mfeEE20dNCZx/Ya8dlfPufFqDFXo35TstADIjnfyQCq+Sgfu1NE1S
         Zi17X+MdA0IPlhW+MSGAao+Zm2CAmm0bSpdYkRXPD/FDbomrJonqMQFsUSpEksksqHVJ
         WROY8EGfCi/UMrfC6FcgpKJ0XcMkoI9IYlV5iT81wnYgNhehSnTPoaI0MolEJYsw73LT
         jdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QVFYrpFR0oMouUJgN0zBItapwy5WhlESQhE9+NondGk=;
        b=MizZrwFVmcExY4fbDhkHEozD7R2FVvBBUG5DE4lKxVFuuizm4nA2cLh5JYIJmK4fLY
         uxn1GC6zouUkyAEb+uXcJL/vDHA7S5YpW5OZaL2u63tggtUjpnl0JB01Xs3aC0WEru28
         tiH5ptC6ekB30JjJebhktvIB9TApOPkzL2Qczd1X/fJPRbF1UPUUydPDjazz8eokPgPO
         g0r9VLBN2jhsUZB3MwK8DVaz4Dw2tojerVLDGMIkziTax6PwPYSbIlv3gJ9iMq3fEev0
         1zEHsaNDm/kD3cJi+XOyD62lX9LpAm8cHnzhL59gs+VYcJ71grj/JTen2JmmE0XQ0Wdw
         ObxQ==
X-Gm-Message-State: ANhLgQ2SWKyngq1PnTAuYi81zDh/D+nLM0ysBcIzBsBZz6eWeISBizG1
        0IQ73fnQtWoDroNdiVDShCDvJ6lSk3+FGsHtK2kLoA==
X-Google-Smtp-Source: ADFU+vt4xxbKuNZTb5dLcEG+w2gTD8QIhhZggco8W//LMKCKxt+9N+Vxzo4sBClNlcr6uwnSngKgaP73lJBP75iFyxU=
X-Received: by 2002:adf:f94f:: with SMTP id q15mr1044593wrr.65.1584481374699;
 Tue, 17 Mar 2020 14:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <1794842.PFUSC7HjHz@paca> <CAJCQCtRJV1ug8L1Q1pJ5ePJdnFP-osekbqzuDb8QSTQ5b0Tm1Q@mail.gmail.com>
 <6003403.r5gNk4GDqt@paca>
In-Reply-To: <6003403.r5gNk4GDqt@paca>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 17 Mar 2020 15:42:38 -0600
Message-ID: <CAJCQCtTDRRzn1YPAogb7oeNXayj2+y4ZYmCbaBaxfVRjWgb55A@mail.gmail.com>
Subject: Re: Errors after SATA hard resets: parent transid verify failed, csum
 mismatch on free space cache
To:     Stephen Conrad <conradsd@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From the original email I see: btrfs-progs v4.20.1

Can you use something newer to do a btrfs check? v5.4.1 is current but
I think v5.3 is probably adequate. Whereas btrfs-progs 4.20 is a year
old. Please post the entire output of the btrfs check (without using
repair).

---
Chris Murphy
