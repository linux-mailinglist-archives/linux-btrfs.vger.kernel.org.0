Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250FF3CA3A2
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 19:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhGORO0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 13:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhGORO0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 13:14:26 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ECAC061760
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jul 2021 10:11:32 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id x24so5022190qts.11
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jul 2021 10:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gt8IWz3s/Z6rGBM43VggF3uEvuMAIWCnGxDOv7aZOek=;
        b=092+7dbfqpBf37fousTXrCwc9FEkCzasJiawZKQA811oMgRc+X2vE7EZHDlzpFNaVP
         j4uRtbvyGUhTA10t4rY+3vqUrttEHsIHbCfi5g3lFtOHrTGK+GCtoDvWcg8VaP8y5Tx7
         e4KUjZjaRXxcZZGABIEbIJtqGgVZfXcB9xePgnpAMVS81U83qTDxSAMuGRnlOtSFTeTw
         1hZaLBUR0V7HqSeDYeOil4pmqmYceecG/2CcPgk1GCxX36pYuVeOkLPWlwH9/1Ef/FI9
         Emmrejd0fvvwRXlSO3iU2NH+2CkG8DBlw+bRLsRYb7y6+7OcfDQmwG36+39OwMcRyNRc
         JwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gt8IWz3s/Z6rGBM43VggF3uEvuMAIWCnGxDOv7aZOek=;
        b=hZYploo4gc0qwHhE7Kr38PiqyFmNZnrg7fhMldZCI/wEhcvpJ9Q7/AxV5m1+MW+bxs
         dQgexWxwB9kqqURAY5x46sJEkaxSd9cHKyN4xtOtQWbQi/FMMVFvolcidCDE7uh1p2r3
         PLuPDQEjk+gFkqfmC8iqZa2jeoSfgHy78HfOSDm6lX/LGopmJxeorvG+i5QJWiqRANoi
         X9Yyc/4sNa2VVZ03QP8ITYWZnKwYVBepKd0Xm0R3ZOf7gqQLfhG2wlwqbYu7lrK6kQpc
         MU2jEKbJ003JBaZSIhj7ye9EYu/h033ilsN5GkQtrS657qC9gh6FxeSilUE/nU8wBXFT
         W9uA==
X-Gm-Message-State: AOAM533zdDW2qofBS4coSNzLU3swB0c4g/JmULM5R3GnqpvHt30VGoQD
        ZnRodvGvTOXJzu8nzLe1XdQU0iR6Qdnmboyz
X-Google-Smtp-Source: ABdhPJzsD80bOcToZIMWo0TVhp5XEFojQF5XcL7xkZ4EMKv0Qwl9FGTt2twDo8RkG4v7IHwWQgUmJA==
X-Received: by 2002:ac8:6619:: with SMTP id c25mr4863950qtp.127.1626369091197;
        Thu, 15 Jul 2021 10:11:31 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e8::11fa? ([2620:10d:c091:480::1:7357])
        by smtp.gmail.com with ESMTPSA id a62sm2799805qke.108.2021.07.15.10.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 10:11:30 -0700 (PDT)
Subject: Re: [PATCH/RFC] NFSD: handle BTRFS subvolumes better.
To:     Christoph Hellwig <hch@infradead.org>
Cc:     NeilBrown <neilb@suse.de>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-nfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Ulli Horlacher <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
References: <20210613115313.BC59.409509F4@e16-tech.com>
 <20210310074620.GA2158@tik.uni-stuttgart.de>
 <162632387205.13764.6196748476850020429@noble.neil.brown.name>
 <edd94b15-90df-c540-b9aa-8eac89b6713b@toxicpanda.com>
 <YPBmGknHpFb06fnD@infradead.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <28bb883d-8d14-f11a-b37f-d8e71118f87f@toxicpanda.com>
Date:   Thu, 15 Jul 2021 13:11:29 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPBmGknHpFb06fnD@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/15/21 12:45 PM, Christoph Hellwig wrote:
> On Thu, Jul 15, 2021 at 10:09:37AM -0400, Josef Bacik wrote:
>> I'm going to restate what I think the problem is you're having just so I'm
>> sure we're on the same page.
>>
>> 1. We export a btrfs volume via nfsd that has multiple subvolumes.
>> 2. We run find, and when we stat a file, nfsd doesn't send along our bogus
>> st_dev, it sends it's own thing (I assume?).  This confuses du/find because
>> you get the same inode number with different parents.
>>
>> Is this correct?  If that's the case then it' be relatively straightforward
>> to add another callback into export_operations to grab this fsid right?
>> Hell we could simply return the objectid of the root since that's unique
>> across the entire file system.  We already do our magic FH encoding to make
>> sure we keep all this straight for NFS, another callback to give that info
>> isn't going to kill us.  Thanks,
> 
> Hell no.  btrfs is broken plain and simple, and we've been arguing about
> this for years without progress.  btrfs needs to stop claiming different
> st_dev inside the same mount, otherwise hell is going to break lose left
> right and center, and this is just one of the many cases where it does.
> 

Because there's no alternative.  We need a way to tell userspace they've 
wandered into a different inode namespace.  There's no argument that what we're 
doing is ugly, but there's never been a clear "do X instead".  Just a lot of 
whinging that btrfs is broken.  This makes userspace happy and is simple and 
straightforward.  I'm open to alternatives, but there have been 0 workable 
alternatives proposed in the last decade of complaining about it.  Thanks,

Josef
