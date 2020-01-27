Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA3A14AB87
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2020 22:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgA0VUc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jan 2020 16:20:32 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:40234 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgA0VUc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jan 2020 16:20:32 -0500
Received: by mail-wm1-f47.google.com with SMTP id t14so88301wmi.5
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2020 13:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:autocrypt:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=NpouDXwGMmLkr99oXl0lwciIW7fDimjt9yd2sErNkLE=;
        b=ntYKuYmfEPBNXeCZdanYjagCOg2NSk++HoLey47817R2ueVRJRnY75qEsh06CGPNXI
         TfmKUBbVSMtrOrzi8CdpXGHNIbXqaZbyxwDNJvilHRYvI/NDRDw9y2IFl2hKPh5o7mny
         GmWcOaU5cNtMG/gkdWAeK8HUMIXOKma3HJAwdyruOoFeTXbKC5l4G/heIOfcL+vPhIgK
         FBYpHzE8jlp8Kq9TvN09S/aGhfkJo5p3LEuKdyX98+UI/83+nvy79ftasE/3lCZ67DhT
         AIJtx0s0QzpAyxvo1/4x8iVvv1rKZOjl75vbNP6B3Gn6nvvAxYJ3GgsLfaaheoQwCWxB
         qaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:autocrypt:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=NpouDXwGMmLkr99oXl0lwciIW7fDimjt9yd2sErNkLE=;
        b=BdIExdHkW0CW18R423zrjDNBU3ZVsiLSApzAOKZT0uhFiSnNkuWx7J3pD3URzoJCa7
         qAHEKBPQHDacud/Fe1bd77RC/ykG0PtPeGBXz0juYDW9dGAVY+7N1SAcypoDlCzQaFhI
         VocYkV0JZnoAjUmNq2y3+7PCFAKz3SdPCZj7l5S01f8z3spOgrhG+P8GW2XQTkAdvtJF
         1PvA/Zhl3gJqNnR7284hmSqjoSQ4C6g8R6U4m3sXQWP3mMo9rMD/xPaMONdwa67RuNAZ
         Q1A0heqEg9DF10t9wepBZAA4e4RkQle1wLJgXAX3G4/YGHFjWZTNYqrSmrsjCIlm6gyZ
         b8HA==
X-Gm-Message-State: APjAAAXAkcnqxaHwe69cnSuGWcyUVVugeotJ+0Ly3glix13Y3l8QYJku
        IyL3rkf5S4PSJw6FsZdCnFhjbB5XWH8=
X-Google-Smtp-Source: APXvYqw3AP3ulyYFd9x1tyuhVZIP2UFvVPz/3Hbm62E1y3Y2EmCkjjK+sqWY9IOBc7Iwh5gf7YM3Mg==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr562076wmg.147.1580160028769;
        Mon, 27 Jan 2020 13:20:28 -0800 (PST)
Received: from ?IPv6:2a01:e0a:1f1:c2f1:ddd9:9aa9:1459:42de? ([2a01:e0a:1f1:c2f1:ddd9:9aa9:1459:42de])
        by smtp.gmail.com with ESMTPSA id y20sm92209wmi.25.2020.01.27.13.20.27
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 13:20:28 -0800 (PST)
To:     linux-btrfs@vger.kernel.org
From:   Pepie 34 <pepie34@gmail.com>
Subject: Endless mount and backpointer mismatch
Autocrypt: addr=pepie34@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c541f131-c60b-4957-0f86-3039da69f788@gmail.com>
Date:   Mon, 27 Jan 2020 22:20:27 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.24)
 Gecko/20100317 Thunderbird/2.0.0.24 Mnenhy/0.7.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear BTRFS community,

I've a raid 1 setup on two luks encrypted drives for 4 years that serves
me as btrbk backup target from an other computer.
There is a lot of ro snaptshots on it.

I've mistakenly launched a balance on it which was extremely slow and
tried to cancelled it.
After two days of cancelling without results, I decided to power off the
computer.

After the reboot, even with the skip_balance mount option, the mounting
is endless, no error in the kernel message and it never mounts.

What I have done so far:
- mount the volume with the ro option (fast to mount, data OK).
- scrub in ro mode, no error found
- btrfs check
In the extent check  there is plenty of errors like this :
=>
ref mismatch on [9404816285696 32768] extent item 6, found 5

incorrect local backref count on 9404816285696 parent 5712684302336
owner 0 offset 0 found 0 wanted 1 back 0x55f371ee1ad0
backref disk bytenr does not match extent record, bytenr=9404816285696,
ref bytenr=0
backpointer mismatch on [9404816285696 32768]
<=
No errors in other checks, though checking "quota groups" is very slow.

What should I do ? btrfs check --repair ?
btrfs check --init-extent-tree ?
btrfs --clear-space-cache ?

Will the "init extent tree" option break btrfs receive with old snapshot
parents ?

Best regards,

Pepie34
