Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C89428479
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2019 19:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbfEWRE0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 May 2019 13:04:26 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52450 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730790AbfEWREZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 May 2019 13:04:25 -0400
Received: by mail-it1-f193.google.com with SMTP id t184so10981255itf.2
        for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2019 10:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=taNO3PtkPrDXbB5doKmtAFrrjpPS5KJ1yQ+80ELswgM=;
        b=mdW9vVVZ/0r2XTfIia8y0TozG+G3Voj3QPGiGYOX95M8p/Yg9/ETX5AwsJoq17T37P
         7eVfdIRNUS+Oi+UECGTrkPNp9Qz2nYXLu4VS0UFiSPZlLTcEK8sLeDNsjR8SvI59X34o
         anXAG1lCCs/tVb8K6b2SV7z4LgzuyL36s5CAAaDrro7kwy9YUljft1wfLX3LSdPhTQL9
         YAxzKb/j9llvlttu1FKLz6Qb441IwTDvE3yHFpNCpnxecHoxuk85kUUVc5k4ZWanTJqJ
         MG0SpJI1RhuUsjYzInQM6wuxUhylpG+Z1SGaC3zLQIsTjfmG8Am1WXM8957k87+4/bMO
         mlbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=taNO3PtkPrDXbB5doKmtAFrrjpPS5KJ1yQ+80ELswgM=;
        b=kWp3Ui9G7l+b2pxm3Tv6hykwMNE40oVRO3hUisVR5/ASuGJPC+taG1cG0BgYtIIXTH
         8NveZGrRFPrr0I/JHQVsOD+ZjY2MlYhpyeH+UK7d36ByqNf3Xz8xYi2vzy0sIgXPK0jl
         vV6BDnbPEyrhZ7pOOp5Q82WAXZhjJSd+YjPCMCDkXCsJU1YU4g4Lfws98Vdw/LVtKdjr
         fHyxm2IP0m1i032gvL9L2CtPidWrkjclO/DV2pF2rph09uZ9j7nMQa+oGJh+8xoFuUTS
         I7+xSZdJg2ExN7EB592FHZWT8qmLYrvFn0RCvfIYhJ4xXr/cT3d7OMjVvBsGOkKHJb+u
         Ev/w==
X-Gm-Message-State: APjAAAVAHKOKZFEG2oq0GtKGvfi3TLfhA5d3IdPk+QiDPnlJ8nePtO2k
        FgvsyAULb/KfVmMxxLlQMIHCFfgWr/BlPg==
X-Google-Smtp-Source: APXvYqwxtaH3B/9RWonTvDdo0tPkvxMwbsA1YmgmNH7WYQFWzJiwKMa8fCpvYwzRUzqCfaMpZoDdmQ==
X-Received: by 2002:a02:2e52:: with SMTP id u18mr65222928jae.84.1558631064696;
        Thu, 23 May 2019 10:04:24 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id c128sm15600itc.19.2019.05.23.10.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 10:04:24 -0700 (PDT)
Subject: Re: Citation Needed: BTRFS Failure Resistance
To:     Chris Murphy <lists@colorremedies.com>,
        Adam Borowski <kilobyte@angband.pl>
Cc:     Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAN4oSBeEU+rmCS8+WwriGz0KoPR=Xa6KvjH=gGriFaxVNZHf6Q@mail.gmail.com>
 <8ccec20a-04b1-4a84-6739-afd35b4ab02e@gmail.com>
 <CAJCQCtTp5d+VxsQmVv68VdmCsxSVpi-_c6LJjS_T=xx3GXz9Fg@mail.gmail.com>
 <20190523163452.GB10771@angband.pl>
 <CAJCQCtTX+=U1B2a9ykqyRYD3=BBaXQTbDa_s=kpBcEiKStzm+w@mail.gmail.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <700e02ac-72e1-3ec4-f161-a3d5160e4f3f@gmail.com>
Date:   Thu, 23 May 2019 13:04:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTX+=U1B2a9ykqyRYD3=BBaXQTbDa_s=kpBcEiKStzm+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-05-23 12:46, Chris Murphy wrote:
> On Thu, May 23, 2019 at 10:34 AM Adam Borowski <kilobyte@angband.pl> wrote:
>>
>> On Thu, May 23, 2019 at 10:24:28AM -0600, Chris Murphy wrote:
>>> On Thu, May 23, 2019 at 5:19 AM Austin S. Hemmelgarn
>>>> BTRFS explicitly requests write barriers to prevent that type of
>>>> reordering of writes from happening, and it's actually pretty unusual on
>>>> modern hardware for those write barriers to not be honored unless the
>>>> user is doing something stupid (like mounting with 'nobarrier' or using
>>>> LVM with write barrier support disabled).
>>>
>>> 'man xfs'
>>>
>>>         barrier|nobarrier
>>>                Note: This option has been deprecated as of kernel
>>> v4.10; in that version, integrity operations are always performed and
>>> the mount option is ignored.  These mount options will be removed no
>>> earlier than kernel v4.15.
>>>
>>> Since they're getting rid of it, I wonder if it's sane for most any
>>> sane file system use case.
>>
>> A volatile filesystem: one that you're willing to rebuild from scratch (or
>> backups) on power loss.  This includes any filesystem in a volatile VM.
>>
>> Example use case: a build machine, where the build filesystem wants btrfs
>> for snapshots (the build environment several minutes to recreate), yet with
>> the environment recreated weekly, a crash can be considered an additional
>> start of a week. :)
>>
>> Or, some clusters consider a crashed node to be dead and needing rebuild;
>> the filesystem's contents will be cloned from a master anyway.
>>
>> In all of these cases, fsyncs can be ignored as well.
> 
> I would not mind a mount option to ignore application fsync and
> fdatasync, while maintaining the Btrfs data->metadata->super write
> order guarantee. I'd expect that would be a more commonly preferred
> use case than volatile/disposable file systems. But what do you
> suppose the real world performance increase is between the former and
> latter?
> 
There's a LD_PRELOAD for that!

Search 'libeatmydata' or 'eatmydata' in your preferred distro's package 
manager, most of them have it.  It's an LD_PRELOAD library that stubs 
out fsync and fdatasync.  Realistically, how much it helps is _really_ 
dependent on the application.  Some package managers can see huge 
benefits because they call fsync regularly (for example, APT on Debian 
can show a big improvement, because each call it makes to dpkg that 
actually modifies system state makes at least 1 call to fsync, usually 
more).
