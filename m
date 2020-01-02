Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87DBE12E88A
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 17:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgABQKY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 11:10:24 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46604 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgABQKY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 11:10:24 -0500
Received: by mail-qt1-f193.google.com with SMTP id g1so28068446qtr.13
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 08:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=psGFP/Ou6PrzARkcYX1TAV3dgxEfqgPkgXL/rBtv4xE=;
        b=DA2nFoG0d0RH+lJhYglTJMlo4QZ5Nf2BdL0nlWactLNxC4qzJxUCnFyr707tJuKzF4
         MrgsDAqd8E/EZ3+PkuFc2Pt6xfFFEsF7ZgzAOjHvi4M85cUFvV52rN3rnqOfdqhQ5Dmj
         nBfnZKLB8RPSiJH8BYDUUl//7hWB6OG8aeC8p3XPs4yYcDiTQRtz/iHJW9zv3DnsYFdD
         rviC4L6PexKkauBW20AO9QRvA/LXa3UPb6HA8RTYvG9p8+vkeGEHJncIpkuOYQO/0zPM
         vTxU4v2SfIsEvpGLX53jzm++CoHyg+nIZN2zLwvKFVmCq+e3r87Yajion/sYOKMzeSCX
         egbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=psGFP/Ou6PrzARkcYX1TAV3dgxEfqgPkgXL/rBtv4xE=;
        b=ugAg5aQKE3W2GUXz9MMc/e3KkO+vwjeAIpoHDddwnMYe4K2efHCznUUdV5sWBNEm2C
         WVkOeItDhsJN1x9M2xlBwTZiRhDd2QLFgFkNFLN/sGbegiDc517MgwQaj6mybZ916n77
         mYYjj9dZ7n2XQtQJE6T2/dWR5ZwR+yf5fBgF0bN7H0c2zd+SZE9KBNfLOoU558HD8Azu
         QA4iQzXfxHhl/cqiF93es38DD8KKwpea+ohlBSeVLPUSx2cOXcb/5w4Bw2yVbqFzrsRC
         ClHO7OCGwklajOXjjAEvlwb59LNV4/b3MkZu438KZ2rp3I70aP9CoXdmNDnUvm4ARbcM
         GuCw==
X-Gm-Message-State: APjAAAWepayuZCrNoERbkVbWy7FSP65riZHMU7v/Dc5PiYBoVa+euKXb
        Pnvdmyq1CYLF5AYBCUr1EtOqXg==
X-Google-Smtp-Source: APXvYqwuJvxT0+NX+koDg54P6FWF/EupyBt4INvS5jcOkMhS0K/zDPbfpabm7EkINUHp3ccu/58R+w==
X-Received: by 2002:ac8:31f0:: with SMTP id i45mr61056010qte.327.1577981422917;
        Thu, 02 Jan 2020 08:10:22 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::be95])
        by smtp.gmail.com with ESMTPSA id e3sm15597225qtj.30.2020.01.02.08.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 08:10:22 -0800 (PST)
Subject: Re: [RFC][PATCH 0/5] btrfs: fix hole corruption issue with !NO_HOLES
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20191230213118.7532-1-josef@toxicpanda.com>
 <d47f690d-6c3a-c69b-bcf7-dd1062c2692d@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <12fa044c-fc1f-41e7-75e1-81523b4ada4d@toxicpanda.com>
Date:   Thu, 2 Jan 2020 11:10:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <d47f690d-6c3a-c69b-bcf7-dd1062c2692d@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/31/19 7:25 AM, Qu Wenruo wrote:
> 
> 
> On 2019/12/31 上午5:31, Josef Bacik wrote:
>> We've historically had this problem where you could flush a targeted section of
>> an inode and end up with a hole between extents without a hole extent item.
>> This of course makes fsck complain because this is not ok for a file system that
>> doesn't have NO_HOLES set.  Because this is a well understood problem I and
>> others have been ignoring fsck failures during certain xfstests (generic/475 for
>> example) because they would regularly trigger this edge case.
>>
>> However this isn't a great behavior to have, we should really be taking all fsck
>> failures seriously, and we could potentially ignore fsck legitimate fsck errors
>> because we expect it to be this particular failure.
>>
>> In order to fix this we need to keep track of where we have valid extent items,
>> and only update i_size to encompass that area.  This unfortunately means we need
>> a new per-inode extent_io_tree to keep track of the valid ranges.  This is
>> relatively straightforward in practice, and helpers have been added to manage
>> this so that in the case of a NO_HOLES file system we just simply skip this work
>> altogether.
> 
> Not an expert of this problem, but AFAIK this is caused by mixing
> buffered and direct IO, right?
> 
> Since that deadly mix is not recommended anyway, can we make things
> simpler by just block any buffered IO if the same inode is under going
> any direct IO?
>

This can happen if you write 100mb and then sync_file_range 1mb in the middle of 
the file, it's not just restricted to O_DIRECT.  Thanks,

Josef
