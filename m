Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51D5718BB26
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 16:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbgCSPaf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 11:30:35 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42226 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgCSPae (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 11:30:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id g16so2119177qtp.9
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=piJgabZNNEBZJmGwRlg29lvqD2YkWgECpmEuTsKGPMQ=;
        b=PLN5XIkkmM5UljdP3U5m6EgUq7UW4paH4uqmUYf9KSQMOTAm7wNaMRh8DZBKF4Nacp
         gRzrFI4EmNz0EsluOs409ErTONuUL17znElvtPGfee2hNkW7mLlZ/HFMp5rWuxAgU9dc
         3hs/zE1HWRe/TzBNppEq/Jk70qtHuvsVdXQvzkCC4uv54/EKspzImhDc3jRqV6VFaqCS
         jctHDO0ryq7xTDnQWXwGpN0vSZ5YwhPc8FA/DTtnEPh3lsdGl5mhLyXYm/vdFMvaxqbx
         2MWxScl8I9ZTXXoY8ciD1kSsRFLYP+tAPjfJLJPcc4lXzb3y2sw29PLFRa583pMGpfgp
         hdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=piJgabZNNEBZJmGwRlg29lvqD2YkWgECpmEuTsKGPMQ=;
        b=cuhMUU+bxd/SuGhwqn1vJAn4p4Hj8KTatqbvJNjW3wF9DCatXbgaSP/dFThGbnoL2+
         MQbiRgQUnz3lGss5Stq6jlAebKPVBsx7Bh4PDUL18MRYkZ8IuIaA/lsaMsYjxo9oE4v4
         utflaukzhFr437SeEy63I1qmUqt6ks1AaQ/gC2KWhnFQALqvbR75xutC6kxFY6hMkORZ
         0LZ4JUYrkl2MSEZH76gEejHqYMCx+0zLcAU403Nb5ROMup23KR4ZZT7egaj8JvkY+gfY
         7nd4CxH9smzzAci3Ue3AZkPjlWvyj8ZjbcrgMnHRlXjMApE25zNF32zowXX8wyaUiYBM
         ymBQ==
X-Gm-Message-State: ANhLgQ3LPzHFNQi3O//8veu2RDSGWILarFkMTOC+v5FAwdPhRS3/aL7Z
        e8FqaI6xe2O3QACQCiVV4Pz1JcPIAJg=
X-Google-Smtp-Source: ADFU+vuMX8C2fy2dHCtbdbjGJ2QyzEdZ+Vs2TLSZ8KPxIouptrW6wWtbPvRTvkmqb9KnM/NIkOLqsA==
X-Received: by 2002:ac8:5395:: with SMTP id x21mr3305766qtp.321.1584631832700;
        Thu, 19 Mar 2020 08:30:32 -0700 (PDT)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 69sm1662672qki.131.2020.03.19.08.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 08:30:32 -0700 (PDT)
Subject: Re: [PATCH RFC 07/39] btrfs: relocation: Make reloc root search
 specific for relocation backref cache
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200317081125.36289-1-wqu@suse.com>
 <20200317081125.36289-8-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <dcfc1749-e351-402d-aa17-6a6f829fb3cd@toxicpanda.com>
Date:   Thu, 19 Mar 2020 11:30:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200317081125.36289-8-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/17/20 4:10 AM, Qu Wenruo wrote:
> find_reloc_root() searches reloc_control::reloc_root_tree to find the
> reloc root.
> This behavior is only useful for relocation backref cache.
> 
> For the incoming more generic purposed backref cache, we don't care
> about who owns the reloc root, but only care if it's a reloc root.
> 
> So this patch makes the following modifications to make the reloc root
> search more specific to relocation backref:
> - Add backref_node::is_reloc_root
>    This will be an extra indicator for generic purposed backref cache.
>    User doesn't need to read root key from backref_node::root to
>    determine if it's a reloc root.
>    Also for reloc tree root, it's useless and will be queued to useless
>    list.
> 
> - Add backref_cache::is_reloc
>    This will allow backref cache code to do different behavior for
>    generic purposed backref cache and relocation backref cache.
> 
> - Make find_reloc_root() to accept fs_info
>    Just a personal taste.
> 
> - Export find_reloc_root()
>    So backref.c can utilize this function.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
