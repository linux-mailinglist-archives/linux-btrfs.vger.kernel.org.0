Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0854D228AB
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 May 2019 22:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbfESUGf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 May 2019 16:06:35 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42736 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbfESUGe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 May 2019 16:06:34 -0400
Received: by mail-lf1-f66.google.com with SMTP id y13so8727181lfh.9
        for <linux-btrfs@vger.kernel.org>; Sun, 19 May 2019 13:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7YyD5llOaY/nMWLfxx8Ia7+PAc+xy0/NB4noGnhEmVk=;
        b=EF6N9q5XER64NoDfoNsXTNC6vfWcSrrUwIcQsOZNXxhtyZ1vvUqgLeF4Jg4IQg0tpp
         M1v7eVb+l29p/ZpqKCF1zmX46dt0Z276iI/dmgOISR5VoZU1nffhPJCn2XT7tLUudl8F
         Q1as8Q41Pq14EghLUqI2ybDmz40RmKlf423mtKD15z5za65HTzFKvcKsZfl+TXMKLWuT
         R8s8GOECAHI8SmaSRWPWtp4Ax8/KA47q8FRvXdVtaaUCvZNPAgMADoJPABtXTIZw0YMb
         WBUfHXeyRgEUE1wsKm9nbcLE7LTu4uM7oyyxwpqyqx+XHDFJmmcOXaVQxZbghmDnlX/U
         5b/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7YyD5llOaY/nMWLfxx8Ia7+PAc+xy0/NB4noGnhEmVk=;
        b=FYf3lwjSQP0T+zB7KpjFwODYOSHeCgSXpjG1P79p3EH5zFxq6qrFynYfxHJahy7Gk2
         A1nnpb4yvcJRH/81x7KNeW/AEFalsiYGj0Y7fkHT8nTF54Pt8i8YKcpKiSkWmAPbHlqv
         D3pxWOo1JpIa+4zh+/9WX5wDQZC/nu5At+VkcWk4ZjaNG/x0P3DqpAfe8VyTn9x0jFkP
         N1606kG6a55cA+TbedxfmLPLoZxuA1plRtt9Eg/81cI8SQ7oRydBcQtEzKdPXBbDgt5n
         36Onh+R9EEfpNHrtAFpa/ztJd4skssnc1QEP4iTWBDnEP0TSpC/7urWY3vet2gCOsixo
         oClA==
X-Gm-Message-State: APjAAAW3RRzSZY5M9HfqnFWVQy2EP8S9u22u1wEz8h/vS/Ov5ZtsMZ3y
        w3+R6cgwCAviXGQQvs0yWAjbCsg6
X-Google-Smtp-Source: APXvYqx8W9N20YgDNGaBf9TUGrfJlrHmyTFOvMnSCR0I80A4lJottLxICQ3SqKf2EUH6ryb4e7i7DQ==
X-Received: by 2002:a19:c517:: with SMTP id w23mr17525117lfe.73.1558296391432;
        Sun, 19 May 2019 13:06:31 -0700 (PDT)
Received: from [192.168.1.5] ([109.252.90.232])
        by smtp.gmail.com with ESMTPSA id b28sm3483594lfj.37.2019.05.19.13.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 13:06:26 -0700 (PDT)
Subject: Re: Btrfs send bloat
To:     Newbugreport <newbugreport@protonmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <clzY4RoSOURzgBtua3TjQ4WXJzgY3EwTyiaYwt49zFAPIi_jO2nAQ8O2saTwpqHH9x0ISw9AVbWOvVR4hFDIx8_dzlWKAzHwcOtEuwaXzJ8=@protonmail.com>
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
Message-ID: <275f7add-382c-bf6d-4cf8-f9823cf55daf@gmail.com>
Date:   Sun, 19 May 2019 23:06:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <clzY4RoSOURzgBtua3TjQ4WXJzgY3EwTyiaYwt49zFAPIi_jO2nAQ8O2saTwpqHH9x0ISw9AVbWOvVR4hFDIx8_dzlWKAzHwcOtEuwaXzJ8=@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

19.05.2019 11:11, Newbugreport пишет:
> I have 3-4 years worth of snapshots I use for backup purposes. I keep
> R-O live snapshots, two local backups, and AWS Glacier Deep Freeze. I
> use both send | receive and send > file. This works well but I get
> massive deltas when files are moved around in a GUI via samba.

Did you analyze whether it is client or server problem? If client does
file copy (instead of move as you imply) may be the simplest solution
would be to use different tool on client. If problem is on server side,
it is something to discuss with SAMBA folks.

> Reorganize a bunch of files and the next snapshot is 50 or 100 GB.
> Perhaps mv or cp with reflink=always would fix the problem but it's
> just not usable enough for my family.
> 
> I'd like a solution to the massive delta problem. Perhaps someone
> already has a solution, that would be great. If not, I need advice on
> a few ideas.
> 
> It seems a realistic solution to deduplicate the subvolume  before
> each snapshot is taken, and in theory I could write a small program
> to do that.

You mean that none of existing half a dozen tools to perform
deduplication on btrfs fits your requirements?

> However I don't know if that would work. Will Btrfs will
> let me deduplicate between a file on the live subvolume and a file on
> the R-O snapshot (really the same file but different path). If so,

btrfs does not care because it does not perform any deduplication at
all. All tools compute identical file ranges and then invoke kernel
ioctl to replace reference to range in destination file by reference to
identical range in source file. So there is nothing that prevents using
read-only data as source for deduplcation of read-write data. Whether
each of existing tools supports it (or makes it easy to do) I do not know.

> will Btrfs send with -p result in a small delta?
> 

Well, if all data is replaced by reference to existing extents in some
snapshot then delta to this snapshot will be small.

> Failing that I could probably make changes to the send data stream,
> but that's suboptimal for the live volume and any backup volumes
> where data has been received.
> 
> Also, is it possible to access the Btrfs hash values for files so I
> don't have to recalculate file hashes for the whole volume myself?
> 

Currently btrfs does not compute hashes suitable for deduplication. It
only stores CRC32 checksums. You can access checksum tree and at least
one tool makes use of it to speed up scanning; but it then computes
second hash to avoid false positives.

Recently patch series was posted to add support for different hashes (I
believe SHA256 at least); these would be more useful for deduplication
when merged.

