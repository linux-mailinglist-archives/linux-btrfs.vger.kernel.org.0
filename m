Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2E871433B0
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2020 23:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgATWIp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jan 2020 17:08:45 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:42719 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgATWIp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jan 2020 17:08:45 -0500
Received: by mail-wr1-f44.google.com with SMTP id q6so1087440wro.9
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jan 2020 14:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=C0ZPTqQBNeE4tajxhl6CHNCxbwp+4xU89H8axgNUjVQ=;
        b=sr6eXf4HgQpDGo66lYd5MFN/mgas2GDTYB8msDfAAMjaMuX78N1YwmP/V0Rep3Ph0+
         ghdxgcIEFb+c+VU/5UW8Rg2BmIoNGQ+A5Smrx+VlJUMjMjUjepIKIqO7boE8XWwnIZEK
         ab1/OtOld6O9hrkvpgs29KMl9R/KrEizCBYkB8tZsGyFSgjJ5LOiLSKhRxB4GPUOixLZ
         VI2043Nk72RFDc3Dp9lRMmDKua1RGKHKX+wBmakrZyLnnxgjQHMIyC/eIvJXZ2TNhyjR
         M/FCxSz/gBFvKg2ZSWq0S/3tLirBlaZJifM0uNGpEh65u1lsGJOBaucq1LYb1i8iGPGR
         lu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=C0ZPTqQBNeE4tajxhl6CHNCxbwp+4xU89H8axgNUjVQ=;
        b=HgWG5szKFIDXEzgpfcKSK/sIBQOtAs0ebNwQ6q0HFKW23G2cwugf6e9RXAEN9N7ESG
         oG8O23tAN1pltJhJdhhIIZuZLMR10PZ1kLn4VVHRE6BEMoFJTIZVFjE33xGHwd6ZZBZN
         GE8tk3KPPdXSbawmqgxkJh2LftWzDMYKVkLUQUNG6T5d2SFLtvmhzy14BGo7EG6o7GOY
         2Bf4qPxveNWvJlUHcjaMguCuPKmj5AsSimu6H+WLS0bBM+CDcpRucW5NPwDGxIDnmgoO
         Xxr5S0nznGOXiZ2f38vTi7yM5y6H3aTvXDaQwGB0zzePPnxjFwfJm2ja9A/KW8Kot5s4
         +K9w==
X-Gm-Message-State: APjAAAVeWWzdk8I1WEOAeATJU1kmuyS9E2mP7+ueQEIeoci7EhSDF3LS
        TKGN11d7Qj1OrI9q0KUpWp6Girti
X-Google-Smtp-Source: APXvYqwu1mNowMyAUDi+ABfWjt7+dOSdGFdef0+8uv421aH/bd3PKou64mni1l10NqkLt6cQEilicQ==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr1504945wrt.15.1579558123328;
        Mon, 20 Jan 2020 14:08:43 -0800 (PST)
Received: from ?IPv6:2001:984:3171:0:126:e139:19f1:9a46? ([2001:984:3171:0:126:e139:19f1:9a46])
        by smtp.gmail.com with ESMTPSA id n187sm1002252wme.28.2020.01.20.14.08.42
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2020 14:08:42 -0800 (PST)
To:     linux-btrfs@vger.kernel.org
From:   kjansen387 <kjansen387@gmail.com>
Subject: btrfs raid1 balance slow
Message-ID: <6bc329d9-6dc5-a4bc-e7c4-eccd377823eb@gmail.com>
Date:   Mon, 20 Jan 2020 23:08:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I had a btrfs raid1 with 2 4TB SATA 5400RPM disks . Regular disk I/O is 
about 2MB/sec per drive, ~40IOPS, mostly write. I had ~150GB free and 
added one 2 TB disk and started the balance:

btrfs device add -f /dev/sdb /export
btrfs filesystem balance /export

It's now running for 24 hours, 70% remaining:

# btrfs balance status -v /export
Balance on '/export' is running
1057 out of about 3561 chunks balanced (1058 considered),  70% left
Dumping filters: flags 0x7, state 0x1, force is off
   DATA (flags 0x0): balancing
   METADATA (flags 0x0): balancing
   SYSTEM (flags 0x0): balancing

I have searched for similar cases, but, I do not have quotas enabled, I 
do not have compression enabled, and my CPU supports sse4_2 . CPU 
(i7-8700K) is doing fine, 80% idle (average over all threads).

Is this normal ? I have to repeat this process 2 times (adding more 2TB 
disks), any way I can make it faster ?

Thanks!
Klaas

