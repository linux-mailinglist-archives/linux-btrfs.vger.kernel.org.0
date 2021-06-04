Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCDF39B5A0
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 11:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhFDJOw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 05:14:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45998 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhFDJOw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 05:14:52 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4939E219F5;
        Fri,  4 Jun 2021 09:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622797985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zg82xsskpBEPuu/jfxoQjwLs+XWcFGem7XD7XTLcm0c=;
        b=iF94tEebxHtxFk/SiNXdWvUn7hAl2v9zChpvefGV9DOjN61XHu03KhJsTJJTr0hBTHJnyD
        fXnyNm8HC0tRCZgIWjNgmwmqEfqpISihDXgyF8CUEz3kgzO0HTVJtUT2KuKHhWamszNOuX
        B+hau3VBMPIyH5Pfx010UB8Imwj7+qM=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id D8CA9118DD;
        Fri,  4 Jun 2021 09:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622797985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zg82xsskpBEPuu/jfxoQjwLs+XWcFGem7XD7XTLcm0c=;
        b=iF94tEebxHtxFk/SiNXdWvUn7hAl2v9zChpvefGV9DOjN61XHu03KhJsTJJTr0hBTHJnyD
        fXnyNm8HC0tRCZgIWjNgmwmqEfqpISihDXgyF8CUEz3kgzO0HTVJtUT2KuKHhWamszNOuX
        B+hau3VBMPIyH5Pfx010UB8Imwj7+qM=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id KvW1MqDuuWDBZgAALh3uQQ
        (envelope-from <nborisov@suse.com>); Fri, 04 Jun 2021 09:13:04 +0000
Subject: Re: [PATCH] btrfs: Remove total_data_size variable in
 btrfs_batch_insert_items()
To:     Nathan Chancellor <nathan@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210603174311.1008645-1-nathan@kernel.org>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <123f5904-9f0a-aef2-3c9a-ce36dd85b571@suse.com>
Date:   Fri, 4 Jun 2021 12:13:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210603174311.1008645-1-nathan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3.06.21 г. 20:43, Nathan Chancellor wrote:
> clang warns:
> 
> fs/btrfs/delayed-inode.c:684:6: warning: variable 'total_data_size' set
> but not used [-Wunused-but-set-variable]
>         int total_data_size = 0, total_size = 0;
>             ^
> 1 warning generated.
> 
> This variable's value has been unused since commit fc0d82e103c7 ("btrfs:
> sink total_data parameter in setup_items_for_insert"). Eliminate it.
> 
> Fixes: fc0d82e103c7 ("btrfs: sink total_data parameter in setup_items_for_insert")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1391
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
