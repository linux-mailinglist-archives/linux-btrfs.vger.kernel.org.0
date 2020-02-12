Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C50315A997
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 14:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgBLNAt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 08:00:49 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37413 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBLNAt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 08:00:49 -0500
Received: by mail-qt1-f195.google.com with SMTP id w47so1465438qtk.4
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 05:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7BmwdnzAzGd2waR4gsKbgJ+i3N8XJRUMBJhbx+3826E=;
        b=dvY2/TRAptWMkEx3lMad5J9OwLtWHYvHHyTByX2fREHTSnHAcyizPhjO/6EKUUqKcL
         TK0AWYeVGB3+p5kP0BjRvbUT9tR+MmjlBRKhrGdSiMvL4xJ8elE0E6gqJDdWT7HGJpJe
         dtSthcCB9yUe0/xtDbjSJAEsS0X3wMlxhhUhqLD0g54smGws8/1i82w+WX2tNQySd8KP
         uNZ64Y8LE4otCw46CT0qydWnookkABmsttlc6uM2nG1tlNbupy2a7vYiEVn4SCUZn6kj
         /TYXDurhCVIyiE57Mt2Aganby2nNHCansdYjh0T01pt/TyHFv+F8bX0+Wv0fpJqWCx6C
         jzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7BmwdnzAzGd2waR4gsKbgJ+i3N8XJRUMBJhbx+3826E=;
        b=rgMM2I6WS2+y7Crqs0tu6+VBDwhLLCG1cvl9KKsyejsSjqIsvWgX41m7fJK/Obr4+e
         y3lRN5l/4PvC/vMwnFtgbGj4ezLXDfWGVWysaHg3b66QVnCnAZ3pvmHaiiXgOxIgZwpP
         L8SdgdcE3tYXcvZLwoxgfi2Ajp26lNR3yaztmOBZgxqsj+ravkZ4e+EKDAlU32d+i82o
         RsdmZIZMmQXzi4gsithzTSaNbIrG2msqVclCdEX4gkKcVgcGUc4CCwsGOi/9JLIgKyaf
         wM5iX2qtcRoN4/lIgCdvn008b73selm5BpCnb5+yG30WbmDHmkUWcn9kLS8+5E/oQACW
         ZcAg==
X-Gm-Message-State: APjAAAWKvhFIwh2pX6XWvY0oDUP7C1pHv0zKcf6bH0X6PrNgD0HxMnfJ
        jOoZDpBoPoLFJB0dy4VIitjVUCY5Mow=
X-Google-Smtp-Source: APXvYqxzgMp42SdYeV15sZgffsccT5LlUszTguzvv02Gq9hU6Crrh5vwxLE97iiuy7rWVoJTbdq8Fg==
X-Received: by 2002:ac8:7159:: with SMTP id h25mr6885638qtp.380.1581512447835;
        Wed, 12 Feb 2020 05:00:47 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::de08])
        by smtp.gmail.com with ESMTPSA id r12sm122497qkm.94.2020.02.12.05.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 05:00:46 -0800 (PST)
Subject: Re: [PATCH] btrfs: relocation: Remove is_cowonly_root()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200212074331.32800-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e4dfd024-d014-b637-4d9e-7a8b1e155bbf@toxicpanda.com>
Date:   Wed, 12 Feb 2020 08:00:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212074331.32800-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/12/20 2:43 AM, Qu Wenruo wrote:
> This function is only used in read_fs_root(), which is just a wrapper of
> btrfs_get_fs_root().
> 
> For all the mentioned essential roots except log root tree,
> btrfs_get_fs_root() has its own quick path to grab them from fs_info
> directly, thus no need for key.offset modification.
> 
> For subvolume trees, btrfs_get_fs_root() with key.offset == -1 is
> completely fine.
> 
> For log trees and log root tree, it's impossible to hit them, as for
> relocation all backrefs are fetched from commit root, which never
> records log tree blocks.
> 
> Log tree blocks either get freed in regular transaction commit, or
> replayed at mount time. At runtime we should never hit an backref for
> log tree in extent tree.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
