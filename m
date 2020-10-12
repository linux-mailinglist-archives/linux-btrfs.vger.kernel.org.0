Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35BC28BF82
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Oct 2020 20:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403907AbgJLSRK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Oct 2020 14:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389885AbgJLSRJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Oct 2020 14:17:09 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613A9C0613D0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Oct 2020 11:17:09 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id f29so3953119ljo.3
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Oct 2020 11:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PTcFu5pM9o8oef016c4gUqfKl32IGdrPtMe6PcdSI/g=;
        b=i8aLfvMlCJ91neDUXyEjG1iEZ0oyK46yDrb/d5dc9a4eQForyopPLtiV1r7EZhK+/H
         4DAvXsl2KG2gx9x6ix6VLMHNCKvb5shJzme1uSDqa9slKNdBzjRR2ws+JW1QJilIzYL3
         URo29EzDeoj9EH28LkZdiNoqMQ4TOLAk7ohpuhJtkrEqs/GidztInXdrXzielNly6Osd
         L0gPo7jJd7/Zoa8cUzs94Pap+AVeYxz/qMBBCvrIYp0nAqnzoWIO//4sQTsEJdcdcSuE
         oQ3J98UtvaToWeuXKmLWQRK5WXbt3V8Nkdjx92szex43eIwqJdeXZfUEz6JysofezDm0
         fAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PTcFu5pM9o8oef016c4gUqfKl32IGdrPtMe6PcdSI/g=;
        b=UsDFWijVD8HavskPIZbW3VRMsyovL1b3Q69HA2/4UNNxA1cfzrWMUyippWXoxdGytp
         b4MS0aHLjEwec6RTUH2NWBev2kvkiuTt7ki9PY+frXN1/l9KLapoxgPYj5giiRikqb3/
         fCm0ypZR89p/X8DsH+1Asy+oi2unOyCNqd6TVkiFHuwzRmdFmkTZMDYrJueCDJUC3gDT
         24reKu0itDFKsDRO2uP4zoY57uIiTW9KJUEpV+reiLPq8uaYm45actRv0PGZPxU+AYT1
         eYlLM3f6XSW87ZTw5fO3un2V5LU03Zng+IVZeDkJsT3aE6nZq01YVmkTOEM0WQBuJgnl
         p6lQ==
X-Gm-Message-State: AOAM5317mX+Zv92YLOhoCSqDKdIygqJkfizA5Xy+EiitLL4ONXR/x5b3
        OyiEFP6ag/gGYovoDyNDsoA4m8vkJWg=
X-Google-Smtp-Source: ABdhPJzweHz+CP6PR/OQlhGJtli21Ww9cL5Qsy6KCTeCYY9EXLnrqkiBCMbwHerAuVzfQwfH+Tb64Q==
X-Received: by 2002:a2e:6e12:: with SMTP id j18mr9770525ljc.389.1602526626626;
        Mon, 12 Oct 2020 11:17:06 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:149f:8c95:f6b8:78b3:383e? ([2a00:1370:812d:149f:8c95:f6b8:78b3:383e])
        by smtp.gmail.com with ESMTPSA id q8sm1128473ljg.105.2020.10.12.11.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 11:17:06 -0700 (PDT)
Subject: Re: Tracking Previously (or to-be-) TRIM'd Blocks
To:     "Ellis H. Wilson III" <ellisw@panasas.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <a75c093a-ce4f-d4cc-8659-22072d7468b2@panasas.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 mQGiBDxiRwwRBAC3CN9wdwpVEqUGmSoqF8tWVIT4P/bLCSZLkinSZ2drsblKpdG7x+guxwts
 +LgI8qjf/q5Lah1TwOqzDvjHYJ1wbBauxZ03nDzSLUhD4Ms1IsqlIwyTLumQs4vcQdvLxjFs
 G70aDglgUSBogtaIEsiYZXl4X0j3L9fVstuz4/wXtwCg1cN/yv/eBC0tkcM1nsJXQrC5Ay8D
 /1aA5qPticLBpmEBxqkf0EMHuzyrFlqVw1tUjZ+Ep2LMlem8malPvfdZKEZ71W1a/XbRn8FE
 SOp0tUa5GwdoDXgEp1CJUn+WLurR0KPDf01E4j/PHHAoABgrqcOTcIVoNpv2gNiBySVsNGzF
 XTeY/Yd6vQclkqjBYONGN3r9R8bWA/0Y1j4XK61qjowRk3Iy8sBggM3PmmNRUJYgroerpcAr
 2byz6wTsb3U7OzUZ1Llgisk5Qum0RN77m3I37FXlIhCmSEY7KZVzGNW3blugLHcfw/HuCB7R
 1w5qiLWKK6eCQHL+BZwiU8hX3dtTq9d7WhRW5nsVPEaPqudQfMSi/Ux1kbQmQW5kcmV5IEJv
 cnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT6IYAQTEQIAIAUCSXs6NQIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAAoJEEeizLraXfeMLOYAnj4ovpka+mXNzImeYCd5LqW5to8FAJ4v
 P4IW+Ic7eYXxCLM7/zm9YMUVbrQmQW5kcmVpIEJvcnplbmtvdiA8YXJ2aWRqYWFyQGdtYWls
 LmNvbT6IZQQTEQIAJQIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AFAliWAiQCGQEACgkQ
 R6LMutpd94wFGwCeNuQnMDxve/Fo3EvYIkAOn+zE21cAnRCQTXd1hTgcRHfpArEd/Rcb5+Sc
 uQENBDxiRyQQBACQtME33UHfFOCApLki4kLFrIw15A5asua10jm5It+hxzI9jDR9/bNEKDTK
 SciHnM7aRUggLwTt+6CXkMy8an+tVqGL/MvDc4/RKKlZxj39xP7wVXdt8y1ciY4ZqqZf3tmm
 SN9DlLcZJIOT82DaJZuvr7UJ7rLzBFbAUh4yRKaNnwADBwQAjNvMr/KBcGsV/UvxZSm/mdpv
 UPtcw9qmbxCrqFQoB6TmoZ7F6wp/rL3TkQ5UElPRgsG12+Dk9GgRhnnxTHCFgN1qTiZNX4YI
 FpNrd0au3W/Xko79L0c4/49ten5OrFI/psx53fhYvLYfkJnc62h8hiNeM6kqYa/x0BEddu92
 ZG6IRgQYEQIABgUCPGJHJAAKCRBHosy62l33jMhdAJ48P7WDvKLQQ5MKnn2D/TI337uA/gCg
 n5mnvm4SBctbhaSBgckRmgSxfwQ=
Message-ID: <462966b8-092c-d726-1b97-c47601025ef7@gmail.com>
Date:   Mon, 12 Oct 2020 21:17:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a75c093a-ce4f-d4cc-8659-22072d7468b2@panasas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

12.10.2020 20:51, Ellis H. Wilson III пишет:
> Hi all,
> 
> Another performance-related question.  We use fstrim to TRIM our
> SATA-SSD backed BTRFS filesystems at daily and weekly intervals,
> typically with a 1MB minimum size specified.  Without such thresholds
> the time to complete can be extremely onerous (approaching 10 hours).
> 
> I note that (via dstat) after a short blip where low reads/writes are
> being done the throughput ramps to 86GB/s.  While fast, even in the case
> of an empty SATA SSD that's been previously trimmed and nothing
> additional written to it, it will take 47 seconds to trim and will be
> largely unresponsive during that time even if the underlying SSD does
> little to no actual erases.
> 
> Are there any plans to track previously trimmed (or to-be-trimmed)
> blocks as ext4 does, or does such functionality exist in a more modern
> release (we're running on roughly 5.5)?  Apologies if this is an
> old/previously discussed topic.  My search-engine-foo is failing me.
> 

Do you mean this one?

commit 8811133d8a982d3cef5d25eef54a8dca9e8e6ded
Author: Nikolay Borisov <nborisov@suse.com>
Date:   Wed Mar 27 14:24:16 2019 +0200

    btrfs: Optimize unallocated chunks discard

    Currently unallocated chunks are always trimmed. For example
    2 consecutive trims on large storage would trim freespace twice
    irrespective of whether the space was actually allocated or not between
    those trims.

    Optimise this behavior by exploiting the newly introduced alloc_state
    tree of btrfs_device. A new CHUNK_TRIMMED bit is used to mark
    those unallocated chunks which have been trimmed and have not been
    allocated afterwards. On chunk allocation the respective underlying
devices'
    physical space will have its CHUNK_TRIMMED flag cleared. This avoids
    submitting discards for space which hasn't been changed since the last
    time discard was issued.

    This applies to the single mount period of the filesystem as the
    information is not stored permanently.


> Alternatively, is there any way to instruct BTRFS to take it's time
> issuing the TRIM commands to the underlying SSD, or break large
> contiguous ranges into smaller ones to improve QoS for other commands?
> Right now it appears BTRFS goes as fast as possible and can leave
> userspace processes stuck in D state for extreme amounts of time for
> more aggressive TRIM runs.
> 
> Thanks,
> 
> ellis

