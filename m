Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCAB683316
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Jan 2023 17:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjAaQ5K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Jan 2023 11:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjAaQ5J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Jan 2023 11:57:09 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321E41BAEC
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Jan 2023 08:57:08 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id q19so5095982edd.2
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Jan 2023 08:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+qtkhtL98CdV1NVK9edtuDg0RPZ3RMJQDh/v2w7nLDs=;
        b=TK1/XM5GkBhj2gllP7LwqDI/eruT01FgZ6F+tFrThFpk4FLU6OFbDd+18xlRAU0hC6
         B+Sn3LCCIqoOc8NDuZvCKbQjVcfz0WjdnfPeT+8+d1B8ywTDOK8Py798B7nXl7yIu8SO
         q6rWeKgKVCeUmQzsSUNXSrOYXWztMTTts1I4kx0c8PYCbonRw32/mM2FKRel4COesUub
         eUHjftRybQ9o6cyIYXZ0Kuq9+CBXn6VZjn7a/3AV1VmPJ8HIg+gK5YCbFJYpWSPn53LC
         1dZ/QGxRSOyvRLJnnU0c3sT2k3qlx4AhBDaYYbXlC4oXSK13B5D6Ugse69swr1fz4YjL
         XsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qtkhtL98CdV1NVK9edtuDg0RPZ3RMJQDh/v2w7nLDs=;
        b=zHfM0IwjyAgLnyR6HNkeKZrTr3LobNKXtR7iFXwTTdBBFU/uwpNc/5tmdlR1u6q29B
         LyE/G/+JSWBntIkG4TYJ8cpsBh0bFnQ8/t9CpGbdE31O5z9lK3enxClWWGt/CovwUVnO
         rvRYUReQytddJ18CY0ZIdJWCCIXVdOqtM1+ffyJ5AoDuGuxQt7cO8vzK1Fm2RXavpu9h
         BTjARtFSFFS0l/87RY5LfkopnuGnzsi+6gniI4qfSrgM0p+khDd1NHxZOJACWtie1wtd
         pS0X8PpsuYG8Q7D6QaJnQyN0P5b1t2OLY1k6wr2bAiEwDWPrd341sklHNFZlnlg5WIVP
         I50A==
X-Gm-Message-State: AFqh2krSkQTs13CbDJbNUXZTWLc+193a4k18UWQeIsloE0NfGtL/7qeE
        1/Fqqr/I2IAhq6vpsjtRtP6Cfrnqbao=
X-Google-Smtp-Source: AMrXdXvuwsIJtcNlomkkRY8VNWgGEtFOrDspYP937WEdgWsh8wn2ZhmRW9AFIfVr6BaT6U5Nn1rWIQ==
X-Received: by 2002:a05:6402:4444:b0:49b:67c5:3044 with SMTP id o4-20020a056402444400b0049b67c53044mr14912086edb.4.1675184226716;
        Tue, 31 Jan 2023 08:57:06 -0800 (PST)
Received: from ?IPV6:2a00:1370:8182:1876:37ce:dc59:5b0c:7454? ([2a00:1370:8182:1876:37ce:dc59:5b0c:7454])
        by smtp.gmail.com with ESMTPSA id m15-20020a056402510f00b0049f2109e4ffsm8581034edd.50.2023.01.31.08.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 08:57:06 -0800 (PST)
Message-ID: <c5a798e3-4b58-a074-01a4-def09f136d38@gmail.com>
Date:   Tue, 31 Jan 2023 19:57:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: bug: btrfs receive: ERROR: clone: did not find source subvol
Content-Language: en-US
To:     Ian Kelling <iank@fsf.org>, Btrfs <linux-btrfs@vger.kernel.org>
References: <87mt5y4uyj.fsf@fsf.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <87mt5y4uyj.fsf@fsf.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 31.01.2023 17:02, Ian Kelling wrote:
> on sending host:
> btrfs send -p /mnt/root/btrbk/q.20230126T000018-0500 /mnt/root/btrbk/q.20230130T200019-0500

Show output of

btrfs subvolume show /mnt/root/btrbk/q.20230126T000018-0500
btrfs subvolume show /mnt/root/btrbk/q.20230130T200019-0500

> on receiving host:

Show output of

btrfs subvolume list -uR /mnt/root/btrbk

> btrfs -v receive '/mnt/root/btrbk/'
> ...
> write p/c/firefox-swf-profile/places.sqlite - offset=0 length=32768
> ... (642 similar lines writing to places.sqlite)
> write path/to/abrowser-profile/places.sqlite - offset=42860544 length=32768
> write path/to/abrowser-profile/places.sqlite - offset=42893312 length=49152
> write path/to/abrowser-profile/places.sqlite - offset=42942464 length=16384
> ERROR: clone: did not find source subvol
> 
> 
> On the receiving machine:
> 
> # cat /proc/version
> Linux version 6.1.4-060104-generic (kernel@sita) (x86_64-linux-gnu-gcc-12 (Ubuntu 12.2.0-9ubuntu1) 12.2.0, GNU ld (GNU Binutils for Ubuntu) 2.39) #202301071207 SMP PREEMPT_DYNAMIC Sun Jan  8 18:52:10 UTC 2023
>   # btrfs --version
> btrfs-progs v6.1.2
> 
> 
> On the sending machine:
> 
> # cat /proc/version
> Linux version 6.1.8-gnu (rms@mit-oz) (x86_64-linux-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.40) #1.0 SMP PREEMPT_DYNAMIC Tue Sep 27 12:35:59 EST 1983
> # btrfs --version
> btrfs-progs v6.1.2
> 
> The snapshot was created running those versions.
> 
> I take snapshots hourly and send and receive them using btrbk, which is
> a perl wrapper. This error has happened around 7 times in the last year
> or so, and when I inspected, it was always places.sqlite, which is a 45M
> sqlite database of firefox containing browsing history. Note, I use
> abrowser, a rebranded firefox in trisquel that fixes some software
> freedom issues. The workaround I've found is to delete the parent
> snapshot on sending machine. The error exists for any combination of
> that parent and a subsequent snapshot.
> 
> A few details about the sending machine where the bad snapshot
> originated: It is using ECC ram and reported no ECC errors, and no
> kernel errors anywhere near the time of the snapshot. The disks are 2
> ssds in raid1.
> 
> I'm happy to help the btrfs developers debug the issue, running any
> commands, running alternate software, etc. Note, I can't share
> places.sqlite file as it contains private browsing history.
> 
> 

