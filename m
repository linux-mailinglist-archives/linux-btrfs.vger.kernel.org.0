Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2D1D1913E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Mar 2020 16:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgCXPK3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 11:10:29 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38146 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbgCXPK3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 11:10:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id z12so15201712qtq.5
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Mar 2020 08:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3Mb6OC39SYERn4+jqQbdgzMwdI7oKt6SZDsu75ZFerE=;
        b=YBlIasZvArb/84Gfb7T02Xh+FrOn/WGrhga02f6bdipqClvcPVWOGORjEd5/jeQIVr
         awIztdeiUjyVV7FcqiNekm8uSPave9wMJKpQjG10PSwFZkd/TbRXXwPrSMOuxYaJuHKw
         nSGomwQW1b5wkLr93Lac2U7qChinoyh/8VALIfZQkhCnTpBGhGS9IyNtQNeAj21NrxtR
         +AkmX1k80eC9kRba9r8d3WD1mDOG7o191+FWqGx4pfRejFtsCrzzcGrUVfX43IIkkTr/
         9cjKCHzwE8IItZYLeBHmIe0QoT8H+pET+XozaPRPvIIZQNkee/2u/Qv40UCS6sAbZpFC
         73bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Mb6OC39SYERn4+jqQbdgzMwdI7oKt6SZDsu75ZFerE=;
        b=AdzAwqpGDayBuhcpRdGTaOMujc4o2WlK6zImzuPdUBgragANC9L/0RQT+18W2W3i5h
         gq0CQbE8ox05Z46CACbsrgvw1uCxamTVvYG/vAmxWkrg+1lAhjdf5Lpm+TapXW36qSDW
         ZZnk1uxHcnkzEBl6R3AlpEetqNKScBael4r4q4g8mwim1mh+oQga86HzWa920Hs37jg3
         sNPxNdJmS/6k+zDN/WXpuseWlWQZs+iFRfjZNXtZtTq6pm2iYLvUBYi0wBtuawgxCXrX
         JHefTscpfiQ6AyFoIWeywV2H435svrBJ9pEK2qIPYvNwJQiyCHXeld/+ieFeacSkPG4k
         sB5g==
X-Gm-Message-State: ANhLgQ3qqtK08YB5ifuGV4v5Xv5ycQY4TDnaoZYPec6CDStwAsc4cLZC
        t7C3ClPg7Eu77HSr0CTAJk8fR6rtHAnCTg==
X-Google-Smtp-Source: ADFU+vtOJDi+/MxQtEscBnW4110cPzPbuoWhaHWLQZcqjEXEfJflRttH7xNCtPE5hxzuKvm+UxY1mw==
X-Received: by 2002:aed:3346:: with SMTP id u64mr25463741qtd.333.1585062628462;
        Tue, 24 Mar 2020 08:10:28 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::1:7b93])
        by smtp.gmail.com with ESMTPSA id f21sm14802879qtc.97.2020.03.24.08.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 08:10:27 -0700 (PDT)
Subject: Re: [PATCH] btrfs: drop logs when we've aborted a transaction
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200324144752.9541-1-josef@toxicpanda.com>
 <981050fa-a6b4-29af-4bd6-e3c3b929c359@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <54bffb37-63e4-2768-9143-521fd1bef10d@toxicpanda.com>
Date:   Tue, 24 Mar 2020 11:10:26 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <981050fa-a6b4-29af-4bd6-e3c3b929c359@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/24/20 10:59 AM, Nikolay Borisov wrote:
> 
> 
> On 24.03.20 г. 16:47 ч., Josef Bacik wrote:
>> Dave reported a problem where we were panicing with generic/475 with
>> misc-5.7.  This is because we were doing IO after we had stopped all of
> 
> This doesn't seem correct. Before, the log tree would be freed in
> btrfs_free_fs_roots which is called before btrfs_stop_all_workers and
> only with transaction_kthread and cleaner_kthread stopped. I'd expect
> that now btrfs_cleanup_transaction will be called from
> btrfs_error_commit_super. Perhaps it's not "after we had stopped all of
> the worker threads" but simply "We have stopped transaction/cleaner
> kthreads" But then again I don't see how those 2 make any difference.
> 
> Could it be that this is not a full fix for the issue, and it can still
> crash in case it's called from btrfs_error_commit_super ?
No, because

btrfs: move the root freeing stuff into btrfs_put_root

moved the btrfs_free_fs_root part to after the stop_all_workers(), so now we 
would free the log roots once _all_ of the workers stopped.  This is the cause 
of the problem, doing IO while all of our endio threads are stopped and gone.

The fix is to make sure this gets cleaned up before we do that, which is handled 
by btrfs_error_commit_super().  Thanks,

Josef
