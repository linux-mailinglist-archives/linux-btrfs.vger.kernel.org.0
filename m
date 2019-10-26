Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81CA3E58F5
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Oct 2019 09:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfJZHMH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Oct 2019 03:12:07 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:46872 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfJZHMH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Oct 2019 03:12:07 -0400
Received: by mail-lf1-f44.google.com with SMTP id t8so3751238lfc.13
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Oct 2019 00:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gpcx5eaQeW9ahdCtlhv+54taVUnJ0VvvPpOdDJQ6s6s=;
        b=KnB0+ybQjR1HAZD+KFylitwTjlf8vzHdSz7gf5SxrGt4QEnY3l/qyi6Z+3cO2inNez
         ryWMjakcaZGYhUd/XCadgFEn4z51oG+QRryHzboAg6S+48gLSORtLoTqlUkF1Z4p3JKW
         6MaJqrWqvjcUwyQH5Blag2SerizKi2n4iKeYyPy2IrZjwJRR08x+HM04WV94SPkAIwq1
         Rpbj6f0KePBiNVHNnL0FE20P7YpVgIIM3mLc6yvKFWWYHTH6/F50hrA8z7AvwNf4vYkl
         WjoQepAXBTlNemvmmqmQZ/j06+bAmMqeYEX9GjmgWEkPXExTO+34QiP+QjZpiq/yZanM
         HEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gpcx5eaQeW9ahdCtlhv+54taVUnJ0VvvPpOdDJQ6s6s=;
        b=Z5Rda9En3XaLXlkR4N8bEl3BTA2irw3YLJy+mbqnAW4fNEz3je4Q/78h9lUNGQtXea
         jY5kw5FEyO7+HFwEs2KLtwKXrgyUV6qB3GG9LGWmu7pTf3duOe6uTTo9CJT4OSk4k/O6
         ekwwiDc1tichzxXbylX1dLQ/qTTLMOiDNaLwAdupfEPCsssAfDwAPBclegUcmzytwOny
         xUpBWzb4LxRn24v7MyhBI9A4JAOLj/M2uLXkMyHJ617+Sqqjj9Xc+SL0VzLtp9UDPL8+
         zDzd9A0VkhragsRL1jlnlPegdFxwmeSKRqsjh2VIio7lIkNWl/hQ+fc+HoOuH4uzhuq3
         jMnA==
X-Gm-Message-State: APjAAAXxBAbku92J+wmqqruLnGcpx6U2g+AaYeTU4kV6oGw4FKXmsadX
        mRq0kI6N8WCChz25NSRQQ2DA9roQB20=
X-Google-Smtp-Source: APXvYqzg4NdE7K5T2W6/Y6I6bRq5NMiAnH/AeOBzaGqjs/zwkg3P/Gdrc0OXhZQk+IqQGeqNVJdgsw==
X-Received: by 2002:a19:23d7:: with SMTP id j206mr5052799lfj.187.1572073924774;
        Sat, 26 Oct 2019 00:12:04 -0700 (PDT)
Received: from [192.168.1.6] (109-252-90-228.nat.spd-mgts.ru. [109.252.90.228])
        by smtp.gmail.com with ESMTPSA id q14sm1976010ljc.7.2019.10.26.00.12.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Oct 2019 00:12:03 -0700 (PDT)
Subject: Re: Does GRUB btrfs support log tree?
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtS1v7waFA=ERafSCSCHmPJVytdFZkJLqNTC3U3Gw3Y7tA@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBDxiRwwRBAC3CN9wdwpVEqUGmSoqF8tWVIT4P/bLCSZLkinSZ2drsblKpdG7x+guxwts
 +LgI8qjf/q5Lah1TwOqzDvjHYJ1wbBauxZ03nDzSLUhD4Ms1IsqlIwyTLumQs4vcQdvLxjFs
 G70aDglgUSBogtaIEsiYZXl4X0j3L9fVstuz4/wXtwCg1cN/yv/eBC0tkcM1nsJXQrC5Ay8D
 /1aA5qPticLBpmEBxqkf0EMHuzyrFlqVw1tUjZ+Ep2LMlem8malPvfdZKEZ71W1a/XbRn8FE
 SOp0tUa5GwdoDXgEp1CJUn+WLurR0KPDf01E4j/PHHAoABgrqcOTcIVoNpv2gNiBySVsNGzF
 XTeY/Yd6vQclkqjBYONGN3r9R8bWA/0Y1j4XK61qjowRk3Iy8sBggM3PmmNRUJYgroerpcAr
 2byz6wTsb3U7OzUZ1Llgisk5Qum0RN77m3I37FXlIhCmSEY7KZVzGNW3blugLHcfw/HuCB7R
 1w5qiLWKK6eCQHL+BZwiU8hX3dtTq9d7WhRW5nsVPEaPqudQfMSi/Ux1kc0mQW5kcmVpIEJv
 cnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT7CZQQTEQIAJQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AFAliWAiQCGQEACgkQR6LMutpd94wFGwCeNuQnMDxve/Fo3EvYIkAOn+zE
 21cAnRCQTXd1hTgcRHfpArEd/Rcb5+SczsBNBDxiRyQQBACQtME33UHfFOCApLki4kLFrIw1
 5A5asua10jm5It+hxzI9jDR9/bNEKDTKSciHnM7aRUggLwTt+6CXkMy8an+tVqGL/MvDc4/R
 KKlZxj39xP7wVXdt8y1ciY4ZqqZf3tmmSN9DlLcZJIOT82DaJZuvr7UJ7rLzBFbAUh4yRKaN
 nwADBwQAjNvMr/KBcGsV/UvxZSm/mdpvUPtcw9qmbxCrqFQoB6TmoZ7F6wp/rL3TkQ5UElPR
 gsG12+Dk9GgRhnnxTHCFgN1qTiZNX4YIFpNrd0au3W/Xko79L0c4/49ten5OrFI/psx53fhY
 vLYfkJnc62h8hiNeM6kqYa/x0BEddu92ZG7CRgQYEQIABgUCPGJHJAAKCRBHosy62l33jMhd
 AJ48P7WDvKLQQ5MKnn2D/TI337uA/gCgn5mnvm4SBctbhaSBgckRmgSxfwQ=
Message-ID: <d1874d17-700a-d78d-34be-eec0544c9de2@gmail.com>
Date:   Sat, 26 Oct 2019 10:12:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtS1v7waFA=ERafSCSCHmPJVytdFZkJLqNTC3U3Gw3Y7tA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

25.10.2019 12:47, Chris Murphy пишет:
> I see references to root and chunk trees, but not the log tree.
> 
> If boot related files: kernel, initramfs, bootloader configuration
> files, are stored on Btrfs; and if they are changed in such a way as
> to rely on the log tree; and then there's a crash; what's the worse
> case scenario effect?
> 
> At first glance, if the bootloader doesn't support log tree, it would
> have a stale view of the file system.

Yes, happened to me several times on ext4.

> Since log tree writes means a
> full file system update hasn't happened, the old file system state
> hasn't been dereferenced, so even in an SSD + discard case, the system
> should still be bootable. And at that point Btrfs kernel code does log
> replay, and catches the system up, and the next update will boot the
> new state.
> 
> Correct?
> 

Yes. If we speak about grub here, it actually tries very hard to ensure
writes has hit disk (it fsyncs files as it writes them and it flushes
raw devices). But I guess that fsync on btrfs just goes into log and
does not force transaction. Is it possible to force transaction on btrfs
from user space?
