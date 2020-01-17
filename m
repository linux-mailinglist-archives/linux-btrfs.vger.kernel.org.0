Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7C94140C6F
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 15:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgAQO2K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 09:28:10 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40653 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgAQO2K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 09:28:10 -0500
Received: by mail-qk1-f194.google.com with SMTP id c17so22801262qkg.7
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 06:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=auqSf6Z7GdtOJcVAPVLclIvNjAWYCx2OboBszHGf08c=;
        b=Dvmx8lg8HaMed04MNHOR8s16ZyiRwaOVI4Pk7vJ0/Myque6Hn4XGh/Q/R7Yws6+CDP
         ec9Q4A0ZXU5RJ91uZk5cpemgbwo22S/CI+u01NohOZoLbtL5wdmn73OtCdt1sJtMejsa
         lumb5+sjA3pq9IuWTOy8geXJszm67H2B5SATTwyFxNRyrOwXxWrUFIImGUEQSBSlrY8W
         mx0fdSPQqiJGhQZ9MY2ChHhIs8gMKJaLeHin39/reDI/XZ5fHc5xhOVLQ3xgrdtt3W+O
         kjExNlU4Js1Q6NeZY9Hbi2P0s2EChj9Y9ZFeQAr89nyzEIZlch4uJcQV5SnXeaFoN1to
         XOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=auqSf6Z7GdtOJcVAPVLclIvNjAWYCx2OboBszHGf08c=;
        b=ewBb8La7VcIgS/yvw+2KbTiMrnQaafC8+UVqU3DlTcAlD1AgJlDjryYG7zQH2xe7A2
         ePHXJEaKs54JE2S2HaBQPz5EnXtVhGyZf561bHpCjGbUeWqHcwGBmOZ2G5VR2txA7wzz
         JKOteJM7InwV2uKB3HR59x0vA9M9tRPR/ftDbu8WFrPivnayyC6TnhkH97gpnRezVUJw
         nIo8FV2OXj6P6fcUiTCd2FaCSJf14XWDWTzIu6BhH05WIfZSgFASKk1J5n/EEsi2ZUgT
         w+mhij2vzqaXOZBFB5XED+R4bOtfuQNLfW5B0FJ8/v8bztZTHqCXsCVabxMvTqZBL/B+
         c8Cg==
X-Gm-Message-State: APjAAAXPodzObbvgGYyqzoKuOPN9JQIndGSzAnbp7YVSr9ncQgYUKLMQ
        DaADewCmG5ZfDlGjCkVU4pMVnKl94B0s4Q==
X-Google-Smtp-Source: APXvYqxj+c2SfKxNXCr/PnxR/tdSBrSFfmPq83/aE4whwBK9qSE6TAF+FM0o8YFmr+VEpWX1O/wC7A==
X-Received: by 2002:a37:e408:: with SMTP id y8mr38344529qkf.39.1579271288266;
        Fri, 17 Jan 2020 06:28:08 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s1sm11636433qkm.84.2020.01.17.06.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 06:28:07 -0800 (PST)
Subject: Re: [PATCH 0/3] btrfs-progs: Do proper extent item generation repair
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200117072959.27929-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4205b62a-e72f-6b6e-b112-83588462675a@toxicpanda.com>
Date:   Fri, 17 Jan 2020 09:28:06 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200117072959.27929-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/17/20 2:29 AM, Qu Wenruo wrote:
> Before this patchset, the only way to repair invalid extent item
> generation is to use --init-extent-tree, which is really a bad idea.
> 
> To rebuild the whole extent tree just for one corrupted extent item?
> I must be insane at that time.
> 
> This patch introduces the proper extent item generation repair
> functionality for both mode, and alter existing test case to also test
> repair.
> 
> Qu Wenruo (3):
>    btrfs-progs: check/lowmem: Repair invalid extent item generation
>    btrfs-progs: check/original: Repair extent item generation
>    btrfs-progs: tests/fsck-044: Enable repair test for invalid extent
>      item generation
> 
>   check/main.c                                  | 66 +++++++++++++++++
>   check/mode-lowmem.c                           | 74 +++++++++++++++++++
>   .../.lowmem_repairable                        |  0
>   .../test.sh                                   | 19 -----
>   4 files changed, 140 insertions(+), 19 deletions(-)
>   create mode 100644 tests/fsck-tests/044-invalid-extent-item-generation/.lowmem_repairable
>   delete mode 100755 tests/fsck-tests/044-invalid-extent-item-generation/test.sh
> 

If we have a generation > super generation that means that block is from the 
future and we shouldn't trust anything in it right?  I haven't touched this code 
in a while, but that just meant we threw it away and any extent references that 
were in that block were just re-created.  Is that not what's happening now? 
This seems like a bad way to go about fixing this particular problem.  Thanks,

Josef
