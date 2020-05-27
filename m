Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1401E49DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 18:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391002AbgE0QXh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 12:23:37 -0400
Received: from smtp-34.italiaonline.it ([213.209.10.34]:36028 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389927AbgE0QXg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 12:23:36 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-34.iol.local with ESMTPA
        id dyq5jdMXbtrlwdyq5jIVD5; Wed, 27 May 2020 18:23:34 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1590596614; bh=g8Ku5O/40HtYzFfiOc5Binb+S+M5czPEDtUGJEkUoy0=;
        h=From;
        b=QVLefxGJGpkGwnWLiMDdky62ocgjPj8zlYT0K8XgLoqJ37NQB85iKgR+ksMTpcw8A
         /s1EBSdH3/gFsFxnzcuBYnVJ1GDuqOu5CRcGkB6X0Hk3ml0nDAAxLKcTq2gz7lgvnX
         KhpR9WbKeiLLT6iUMUBN0anLNKsccDIX/jFN3dPZJpqxAUGdfVKpzviJEhOaPCFS8c
         IFIGmFbbLaooAeisDfCLzx+QJlq9o5p3N2ERe2nzUaQYUfvwB9bQrzTw4/eoEXZyBI
         Mw8BezPPFXTifTcUHLBu2fWEXiznKE8YNGPkJw3/epUi10KVjV8f6Guk5zhfRE/JRY
         LvG6rz3M4C/hA==
X-CNFS-Analysis: v=2.3 cv=TOE7tGta c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=a22f0UI6pZJV7TnBnioA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: Planning out new fs. Am I missing anything?
To:     Chris Murphy <lists@colorremedies.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Justin Engwer <justin@mautobu.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAGAeKut52ymR5WVDTxJgQ=-fZzJ+pU8oVF89p4mBO-eaoAHiKw@mail.gmail.com>
 <CAJCQCtSyJp0LiaO246NcEX-p7rk8-h1NocW4o4rJgN=B1Kwrug@mail.gmail.com>
 <46fa65a3-137b-3164-0998-12bb996c15ef@gmail.com>
 <CAJCQCtTmcRfrZEtdnUgF0CkFFWDW-d5-LtM4SFKO4F7Xr9ai_A@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <0d3b740d-a431-cca0-3841-a85e49ffff9e@libero.it>
Date:   Wed, 27 May 2020 18:23:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTmcRfrZEtdnUgF0CkFFWDW-d5-LtM4SFKO4F7Xr9ai_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHN/SKvycC4NvMyfmY6L3DPhTrzESoWxiARINZvO9uuaGXvQGNahmOh0uwO6g7cHVP6sqoi0o820RJ06b5lt5cVsuAGaGGdQaSNtApLCFA0wRZOoVB2q
 XyVWu7YD23Hxn2kRZnyrIMhM+FJr8tTN+cjodZPlsOw1WDE/aF2q6G1pS+PlbnOKoKSaNdDjQa6NLsHOMSTDd02cmdBRysefVPpglyqEU30yVECb3WlZBxpv
 dN2qsxWoDqDv71mSVnQHrvNHju46H42CKcS/zMV5/Pk=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi All,

On 5/27/20 8:25 AM, Chris Murphy wrote:
> On Tue, May 26, 2020 at 11:22 PM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
>>
>> 27.05.2020 05:20, Chris Murphy пишет:
>>>
>>> single, dup, raid0, raid1 (all), raid10 are safe and stable.
>>
>> Until btrfs can reliably detect and automatically handle outdated device
>> I would not call any multi-device profiles "safe", at least unconditionally.
> 
> I agree.
> 

Checking the generation of each device should be sufficient to detect "outdated" devices. Why this check is not performed ?
May be that I am missing something ?

Of course this could solves the "detection"; the handling of outdated devices is another story..

BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
