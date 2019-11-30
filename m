Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7924F10DCF7
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Nov 2019 08:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfK3HdR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Nov 2019 02:33:17 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:35812 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfK3HdR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Nov 2019 02:33:17 -0500
Received: by mail-lj1-f170.google.com with SMTP id j6so25196955lja.2
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2019 23:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RlI5WkamD9tWaOuozmJ09gHbWsW/E8n/iI2v5quq0fQ=;
        b=kJaXKI9hebGk7GFBDNwPNm6Q1AfC1ZMZent7uJI8o20sAv+hVrZFBYi/wT5PpRvONn
         i0b6Gy8lcJOEjqplLKc5x/+14uApx5U2FZQ57J7uXxEJliO3DFY8MH0r+SbpxDq99213
         Zrg532seMGnYr5Qv4RBIM7vQbfm0g8svVX/PpC6jGlDJOSQlfaF4lcSyfLWQqAuiHJVJ
         var/SvO38dE6tHb6EVDVtMfAqEfsRi1VrcOb2uWW/k5WbdAFpaIbp9eFzgQOEwj0EY3M
         Q3JrkR6oxw9nZSFryNQFd3Cde28vW3HoJmHNjoLln82025wDbTOUpLAmWTfKXRvpQFWJ
         Pzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RlI5WkamD9tWaOuozmJ09gHbWsW/E8n/iI2v5quq0fQ=;
        b=A6uTU6RjOIB1Sz5nkAqFeK0Dyu3A+h+38ZiHzS69cfR0O+rTWp7e4mnoeIpWq8AIbt
         WooPGZVNXY0juQ1sTm7qp7Ui2ZJbt/9Msyw72f3B/d+QMYFuVTq1+AIyjuzKDzhV2uTg
         MeqqGa1yYiBd/9Lc1ZnPMS9vwnAI97BWnBANDbR/wawr3DklZGovrIZPllnceiJIm8dw
         PIjk9xIbV6YDSuP3kPySFh1xxHrmq38iSK5IpIfshOOOpio0d8GIi1uK+c0hwKaCblOe
         0b5wjCFkZLAixaQPK6hmiXaJs3anMNo+mmvplDrtVsZtpeLdEpCOQ2lE2tPnlltRaVaY
         /Paw==
X-Gm-Message-State: APjAAAV3gNnZCevjoHCUf0+wTjw+687++oADGSBSsNF7ab5Zml+3/OKN
        44cz0+mL+biYLKSjrZfW4WY3ra3U
X-Google-Smtp-Source: APXvYqyLsvfgSbw+T5wDUOS7PgCCWQnGhRyJU4MKu9rUDql+H1rUKawiEWpeZwdB5EIn9+HcRm7DjQ==
X-Received: by 2002:a2e:8145:: with SMTP id t5mr3544997ljg.144.1575099194782;
        Fri, 29 Nov 2019 23:33:14 -0800 (PST)
Received: from [192.168.1.6] ([109.252.90.228])
        by smtp.gmail.com with ESMTPSA id s7sm11316742ljo.98.2019.11.29.23.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2019 23:33:14 -0800 (PST)
Subject: Re: GRUB bug with Btrfs multiple devices
To:     Chris Murphy <lists@colorremedies.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtSeZu8fRzjABXh3wxvBDEajGutAU4LWu0RcJv-6pd+RGQ@mail.gmail.com>
 <a48a6c50-3a03-0420-ad8c-f589fafe6035@libero.it>
 <CAJCQCtR6zMNKnhL7OZ8ZGCDwPfjC9a1cBOg+wt2VqoJTA_NbCQ@mail.gmail.com>
 <CAJCQCtS2CP75JTT4a6y=rzqVtkMTqTRoCvJK9z3mMwLRfKo9Xw@mail.gmail.com>
 <12f98aaa-14f0-a059-379a-1d1a53375f97@inwind.it>
 <CAJCQCtQF6xtBDWc+i3FezWZUqGsj8hJrAzYpWG+=huFkmOK==g@mail.gmail.com>
 <69aaf772-9eb0-945a-5277-40895e6901de@inwind.it>
 <CAJCQCtS6V+f5hq2Cu4r7g9nXB-nRPwUaL+=rh_Ets2mWtHrMcA@mail.gmail.com>
 <35b330e9-6ed7-8a34-7e96-601c19ec635c@inwind.it>
 <CAJCQCtQaq7r2G7Ff--n5g2eVknPtKcQjebj-=eoNjM-18hwhKw@mail.gmail.com>
 <0ce1c050-d90c-1351-ff56-4edc054463a4@inwind.it>
 <CAJCQCtQSgTG=r0+i=M7nKgz5ncqcfEkZmQci5Kk12PmDVzgmbg@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <dbb038ee-46be-16c4-3753-6b366d2aa15d@gmail.com>
Date:   Sat, 30 Nov 2019 10:33:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQSgTG=r0+i=M7nKgz5ncqcfEkZmQci5Kk12PmDVzgmbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

30.11.2019 00:17, Chris Murphy пишет:
> 
> Is it possible to redirect grub debug output to a FAT file?
> 

No.
