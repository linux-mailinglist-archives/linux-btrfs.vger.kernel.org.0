Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05AF4168F6B
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 15:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgBVOw7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Feb 2020 09:52:59 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:35021 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbgBVOw7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Feb 2020 09:52:59 -0500
Received: by mail-qt1-f181.google.com with SMTP id n17so3502075qtv.2
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Feb 2020 06:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VmfGaEYlXvFI/57ko6XK9r8dC5LCUQST1tJrraBFupM=;
        b=B12SbEfI2qVXooba+/W1+uYMkCUEPt9+klhvHZtDGtQ/KD4c70+DGvzrz+DEPCvdtW
         SDrwnJx8NbTtNr/zap3tEy6xQ74Ng7J0nr/y/bTrf/p+k3/0cxhfhVQim6dFoaBbYiie
         Ac9gEYMAE+tvUBl1IVQIK3c0Gp9y938XRMZHGMucf+3u9/rsUgdm1zt6y3uVV5sWZoxd
         +agA+iaZkpUg2D9vh7PggrLGOffhVAQCs/JcaAzOhgFdbuOM22rbneKX7hilwOQPqNba
         ksXQTaMoxSQ3JLqO/f049HoldScBqItessZDXIPgyz91Mya/tCIc5F86Ewg7P84LKEkT
         KZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VmfGaEYlXvFI/57ko6XK9r8dC5LCUQST1tJrraBFupM=;
        b=JPv2Ah0uAsQUAfH4l5J1WgwVIRVMLHaf1PlW19IuDkRCk/5aW/e5eHVnnNlYidSAGB
         0yu579K6947QgUqGQpRhAqinbqPnNsGeQ0ZkmH1SEFjgTdZCMsJWKKmtulMc/fNSca43
         i3UC9GioAeW6dwVEC7icv2YoQ6HhFYJRIWL1CWEoOuVQqgPPBJXwTHaut7QDc/GelMjb
         HDUvBXliJWIxaWtVUG5ZZUm5MaMwDeZ8NZoiHIXgVcHMfIqM2AhBkpEOprv2uGmA3kRj
         b85RyyTR9M8zP2VNj26S4Wokm7q5fmDrSSwYF/H12pqKHlThkgwv1LIeO/C6K7ap8+GJ
         LZTg==
X-Gm-Message-State: APjAAAVPj6iSRm9ayY5pNt5voFqDlgEM9MTZzIMTSErRjr+MGgS+4tlv
        2GSI2rV+AhJZQnd1QS8pT5f1uA==
X-Google-Smtp-Source: APXvYqyTyDRXsSFmKWv3PAA4vVwougDaxvgepsp3bNLuLf3t5eB4bWdoPj9OxOaXJpNNOGAOe/GHSQ==
X-Received: by 2002:ac8:38e6:: with SMTP id g35mr38283737qtc.120.1582383178329;
        Sat, 22 Feb 2020 06:52:58 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s19sm1929081qkj.88.2020.02.22.06.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 06:52:57 -0800 (PST)
Subject: Re: btrfs filled up dm-thin and df%: shows 8.4TB of data used when
 I'm only using 10% of that.
To:     Marc MERLIN <marc@merlins.org>
Cc:     Roman Mamedov <rm@romanrm.net>, dsterba@suse.cz,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200219225051.39ca1082@natsu>
 <20200219153652.GA26873@merlins.org> <20200220214649.GD26873@merlins.org>
 <20200221053804.GA7869@merlins.org> <20200221104545.6335cbd1@natsu>
 <20200221230740.GQ19481@merlins.org>
 <3e94351d-6f32-1036-ab24-0dc1b843c969@toxicpanda.com>
 <20200222000142.GA31491@merlins.org> <20200222010637.GB31491@merlins.org>
 <20200222012312.GC31491@merlins.org> <20200222145134.GV19481@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <71dc4b69-cab4-596c-530e-c7059a19f998@toxicpanda.com>
Date:   Sat, 22 Feb 2020 09:52:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200222145134.GV19481@merlins.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/22/20 9:51 AM, Marc MERLIN wrote:
> On Fri, Feb 21, 2020 at 05:23:12PM -0800, Marc MERLIN wrote:
>> On Fri, Feb 21, 2020 at 05:06:37PM -0800, Marc MERLIN wrote:
>>> You asked for a check, it's running but may take a while:
>>> gargamel:~# btrfs check /dev/mapper/vgds2-ubuntu
>>> Checking filesystem on /dev/mapper/vgds2-ubuntu
>>> UUID: 905c90db-8081-4071-9c79-57328b8ac0d5
>>> checking extents
>>> checking free space cache
>>> checking fs roots
>>> checking only csum items (without verifying data)
>>>
>>> I'll paste the completion when it's done.
>>   
>> Ok, faster than I thought. btrfs check came back clean
>> I added spaces for readability.
>> So this claims I'm using 9TB?
>>
>> Is it possible that I'm hitting this problem
>> 1) I did really fill the filesystem (well not to the filesystem size but
>> to the size that dm-thin was not able to give blocks anymore)
>> 2) I deleted/freed up the space
>> 3) btrfs needs space to free up the space, and there is no space left,
>> so it's unable to mark the free blocks, as free, and I'm therefore
>> stuck?
>>
>> found 9 255 703 285 760 bytes used, no error found
>> total csum bytes: 9 019 442 564
>> total tree bytes: 17 533 894 656
>> total fs tree bytes: 7 411 073 024
>> total extent tree bytes: 379 928 576
>> btree space waste bytes: 1 769 834 145
>> file data blocks allocated: 9267682025472
>>   referenced 9272533270528
> 
> Ok, last call before I delete this filesystem and recover my system to a
> working state. I don't need the filesystem fixed, it's fairly quick for
> me restore it, but obviously if there is any useful state in it for
> improving the code, that will be lost.
> 
> I understand it's the weekend, if someone thinks I should wait until
> monday to give some other folks the chance to see/reply, let me know,
> and I'll keep my system down until monday.
> 

Go ahead and blow it away, and I'll add "dm-thinp failure mode" to my list of 
things to look into.  Sorry Marc,

Josef
