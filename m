Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACBC4128F32
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Dec 2019 19:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfLVSAP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Dec 2019 13:00:15 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37290 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfLVSAP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Dec 2019 13:00:15 -0500
Received: by mail-qk1-f193.google.com with SMTP id 21so11929886qky.4
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Dec 2019 10:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=whAmw7IzX5T1xRn3vL2g6AMbt2vqY23+bk1HjeG36n4=;
        b=KSRi/XEKYmP5cLxCFkpsjngj1/lzOi277PA2di0kS5gJGE+7SWGV/s+OUk1GlKw/J+
         rktfSjmHEAQmMoztE2xvHMigln6A4hnQp92qt6uEnt/k4kHQymXIpJnL7B43mOTd+iHI
         47K7ZQpXQ4Z2bjv7gIVx2k+2KFKUZzLAhGwFNaY64yVMG2r7Sl3NIZ+0eS80mehknHVF
         qvOSu7iprfAfG7Bi7FrCCJx28qvoK9c64h0j9H4BjtSSebVDyBTuxu9Wgfnvc9zkdc0C
         EZl30NPWADXRC9DeODEGfZO3u+hJHlShGcfNc+vyR++fB/hGrJ+JbbvzeqYvKlpBtQrt
         +1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=whAmw7IzX5T1xRn3vL2g6AMbt2vqY23+bk1HjeG36n4=;
        b=X7ealHcU5EMSyMcutDkx590T67gLdDfg0RIPpPh5b51giafDntMLr5AIJcVq+PQH1t
         H7YZLkHnMMCdSsJfR2ZnKGc87ilZB7klocz2EEq0l90mtI1lMX9OkNItk5hkoiGfWkSx
         rHw/DKk/wMjq3X/aU0cJxaTeYqgkMFhOGVwfB+M7vh66MhlGn/DvWg4yHYVRnTlpwYF4
         eE/E5Y64qcLVVbx6fqdsN0x2CXxyF9hYCsCerb8ysgA1aHTWKJpP6MnvkmT6xxN5XIjN
         9wFQGY+Oq0RVjD3d4regscsI2JnvmKCpz8WKY35V3mmRxaCgPFQPGW15pwOBJ9/4fIvZ
         FdHQ==
X-Gm-Message-State: APjAAAWpq0buEAnVQdwF9kyunEwgO7DiADDXmRpGJgQb4T+KUnKDaqAO
        RunToRVINvo2jsoAj6m7NSO7GesI80L0SQ==
X-Google-Smtp-Source: APXvYqwvG76Xtgb2ggigb9Rkzo8k5piG1WVuG7UrqaQduuFLS+NIQs7SjAUq8Y1zclU7HJzlhYE77g==
X-Received: by 2002:a37:ae07:: with SMTP id x7mr22747335qke.28.1577037612844;
        Sun, 22 Dec 2019 10:00:12 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4a6d])
        by smtp.gmail.com with ESMTPSA id u5sm4535166qkj.127.2019.12.22.10.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2019 10:00:11 -0800 (PST)
Subject: Re: fstrim is takes a long time on Btrfs and NVMe
To:     Nikolay Borisov <nborisov@suse.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtTQ-xkWtSzXd14hb1bmozg3U8H2pxQMO7PqEJjymCcCGA@mail.gmail.com>
 <c246f5e9-c9b6-8323-9e2d-26f17051df6a@toxicpanda.com>
 <a6b6cfde-d5df-b68b-cd57-edccc970ad64@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5e910a0e-2da8-72a0-fa36-7d48f2454ca4@toxicpanda.com>
Date:   Sun, 22 Dec 2019 13:00:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <a6b6cfde-d5df-b68b-cd57-edccc970ad64@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/22/19 12:49 PM, Nikolay Borisov wrote:
> 
> 
> On 22.12.19 г. 19:43 ч., Josef Bacik wrote:
>> On 12/21/19 1:24 AM, Chris Murphy wrote:
>>> Hi,
>>>
>>> Recent kernels, I think since 5.1 or 5.2, but tested today on 5.3.18,
>>> 5.4.5, 5.5.0rc2, takes quite a long time for `fstrim /` to complete,
>>> just over 1 minute.
>>>
>>> Filesystem      Size  Used Avail Use% Mounted on
>>> /dev/nvme0n1p7  178G   16G  161G   9% /
>>>
>>> fstrim stops on this for pretty much the entire time:
>>> ioctl(3, FITRIM, {start=0, len=0xffffffffffffffff, minlen=0}) = 0
>>>
>>> top shows the fstrim process itself isn't consuming much CPU, about
>>> 2-3%. Top five items in per top, not much more revealing.
>>>
>>> Samples: 220K of event 'cycles', 4000 Hz, Event count (approx.):
>>> 3463316966 lost: 0/0 drop: 0/0
>>> Overhead  Shared Object                    Symbol
>>>      1.62%  [kernel]                         [k] find_next_zero_bit
>>>      1.59%  perf                             [.] 0x00000000002ae063
>>>      1.52%  [kernel]                         [k] psi_task_change
>>>      1.41%  [kernel]                         [k] update_blocked_averages
>>>      1.33%  [unknown]                        [.] 0000000000000000
>>>
>>> On a different system, with older Samsung 840 SATA SSD, and a fresh
>>> Btrfs, I can't reproduce. It takes less than 1s. Not sure how to get
>>> more information.
>>>
>>>
>>
>> You want to try Dennis's async discard stuff?  That should fix these
>> problems for you, the patches are in Dave's tree.  Thanks,
> 
> But aren't those only for inline discards e.g. when you have explicitly
> mounted with discard. The use case here is using FITRIM ioctl, does
> Dennis' stuff fix this?
> 

I definitely misread the email, I thought he was talking about the commits being 
slow.  The async discard stuff won't help with fitrim taking forever, there's 
only so much we can do in the face of shitty ssd's.  Thanks,

Josef
