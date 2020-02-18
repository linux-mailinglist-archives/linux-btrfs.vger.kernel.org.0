Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFFC1627EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 15:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgBRORN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 09:17:13 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46879 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgBRORN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 09:17:13 -0500
Received: by mail-qt1-f193.google.com with SMTP id i14so7339045qtv.13
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Feb 2020 06:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+UCgxyYmsy9OBO3kh/zA2QazjAJ14ZIlvINx4SkM/hw=;
        b=awt3V+d9PrBKzBzdikVmlN5H+FLXC1kyY79D3WFOFDKJbnKpklnI0CZLxSqeLyGOxN
         aeiMkoweDdCw2xze4pOPs9bJYzKx7cNJ8mBSV/xq5bhuydtbaXUHRYiOlmFkVLwL0Dlp
         jfLSBv5Xtsxfk0w8j6VSv0OT+rYjeM+KZNUZNK7JbSvkxg3B+aiTUjEPRJ8Wde+dFZA/
         /BbjI0NQGOHH6YDuKQjNoSGLRmHSla54KaLQU3Po17yG6hHlXMUcHtj+xvOcoXCU28jv
         p48EjILYwHcMFJxgl+hVZN2bMOgsai4YGNAPjji/ImVDammu613T1/K/5UnBUF9v6U9f
         i7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+UCgxyYmsy9OBO3kh/zA2QazjAJ14ZIlvINx4SkM/hw=;
        b=ZpYfZCxFEeAt1Wqlff5KFoVrpouQj7zGx3MW8TyCed+UIE/42s5AtDuJ8iT3P1dceG
         ak/XldUJgVqEW4Y46UKPxxaz+4Tt2WorMpQcdFZQSgL6acL/gR+nthFN+QDMJ1RWunn8
         8MOJ5q5LPa+3WI2DjmjKlDAf+ppE6ReJkiYey0ZIRFWt3I9CkcLFgEphXdA+I8Esm9x4
         XQF005/+B+aGdljNqCcTNx6cEepplmPq7XRjjflK/KR8B7gakIRm8iyFzMkqgrMYx10t
         utnjhOyx6Z7ulrEkVTlFgkAAPSLlaJOtuljFy+YTZHWyfKVlkTAu67jZueLbVz6JoYAn
         dw9g==
X-Gm-Message-State: APjAAAWMlPsuCl9HGW4fDwXfCUFZm8KxlG3piI9+HI+xyY7MsMvue0dg
        /YtLOKgHd5lBgTaxVq2Ller1d3OjERs=
X-Google-Smtp-Source: APXvYqxL+77fmIFQfqT2MiKgUvUTbXZt+kdtNMquU7513VZuZrMc0RX/3sRjLRxKfTknrvV3A4sQBA==
X-Received: by 2002:ac8:584:: with SMTP id a4mr17644492qth.240.1582035432145;
        Tue, 18 Feb 2020 06:17:12 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b26sm1918809qkk.5.2020.02.18.06.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 06:17:11 -0800 (PST)
Subject: Re: [PATCH] xfstests: add a CGROUP configuration option
To:     Brian Foster <bfoster@redhat.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20200214203431.24506-1-josef@toxicpanda.com>
 <20200217163821.GB6633@bfoster>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ad711a8b-f79d-380a-dc11-7e6d1e1e79ba@toxicpanda.com>
Date:   Tue, 18 Feb 2020 09:17:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217163821.GB6633@bfoster>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/17/20 11:38 AM, Brian Foster wrote:
> On Fri, Feb 14, 2020 at 03:34:31PM -0500, Josef Bacik wrote:
>> I want to add some extended statistic gathering for xfstests, but it's
>> tricky to isolate xfstests from the rest of the host applications.  The
>> most straightforward way to do this is to run every test inside of it's
>> own cgroup.  From there we can monitor the activity of tasks in the
>> specific cgroup using BPF.
>>
> 
> I'm curious what kind of info you're looking for from tests..
> 

Latencies.  We have all of these tests doing all sorts of interesting things, I 
want to track operation latencies with code we're actually testing so I can see 
if I've introduced a performance regression somewhere.  Since Facebook's whole 
fleet is on btrfs I want to make sure I'm only getting information from things 
being run by xfstests so I can easily go back and hunt down regressions that get 
introduced.  With BPF I can filter on cgroup membership, so I know I'm only 
recording stats I care about.

>> The support for this is pretty simple, allow users to specify
>> CGROUP=/path/to/cgroup.  We will create the path if it doesn't already
>> exist, and validate we can add things to cgroup.procs.  If we cannot
>> it'll be disabled, otherwise we will use this when we do _run_seq by
>> echo'ing the bash pid into cgroup.procs, which will cause any children
>> to run under that cgroup.
>>
> 
> Seems reasonable, but is there any opportunity to combine this with what
> we have in common/cgroup2? It's not clear to me if this cares about
> cgroup v1 or v2, but perhaps the cgroup2 checks could be built on top of
> a generic CGROUP var? I'm also wondering if we'd want to change runtime
> behavior purely based on the existence of the path as opposed to some
> kind of separate knob (in the event some future test requires the path
> for some reason without wanting to enable this mechanism).
> 

Oh I probably should have looked around, yeah we can definitely use this.  My 
initial thought is to just make CGROUP2_PATH exported always, we create 
/path/to/cgroup2/xfstests and point CGROUP2_PATH at that, and then any tests 
that use the cgroup2 path for their test will automatically be populated under 
that global xfstests directory, so I can still capture them with my scripts. 
Does that sound reasonable?  Thanks,

Josef
