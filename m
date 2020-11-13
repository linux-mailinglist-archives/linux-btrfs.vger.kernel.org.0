Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0992B2459
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 20:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgKMTSz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 14:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMTSz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 14:18:55 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7015C0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 11:18:54 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id i12so7478530qtj.0
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 11:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jlA7LCd7cfs5nJLzUrIEDROX0rLKeW23/VuTBw/oSyg=;
        b=G6q2SN8CjkQnBtnfLjXEABpTxk4BJpGUQP9YfUz9WGGy9/QcUcis256+dD4VPlm5Pm
         56NB8HdDZydsSra781NnAxV2uObwrF9QVMENmtqJ21HivaSr3b9zFawaYOJwijtzlnAB
         kpgfMSVbktZnyEjO4MLmJo/DwBsYdQZC2AIFUElN1CSBKBmTRyOFE5R3zJvOp64fDlw5
         gPPAb0rk9TuVMCeuDKfMPHEzGmH3ZRBjmoT4iLooBKdmEw1HlSvRsFeT15UWAzoPuau/
         aEvh9hlN5YBoJByp8GXeZJhenVUYxVTtj+Lu4o9FLzNlhYbgCGku0A++9PP1OnBKBlHN
         YNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jlA7LCd7cfs5nJLzUrIEDROX0rLKeW23/VuTBw/oSyg=;
        b=G1i/K05KPhHSRbvl2+6rySJa9GCTd3Qchumb/TYUT8oU3ON7gn7xxR9D6g3WIk6Wg4
         tfPYCQHMPJc3lPfQsOEWVWpKJZe4Ym5RrW5qUemuSIGbgt4VI+HieCMdvm53f8JCvu9C
         D4wM1FsD8v/v0/HdBxWT1jHGaSLaNmnkNtv+tb/Qs5PbE8sUNxLJ91GSAY7tikYJ4jQ9
         Ci/0il2dn7Ak7R1DCR5ArqU7GT4TCTEf7Pf38Eg3e9jH729jZFr3jRqHMB/49FKT8A0C
         GtoA50I1M0AAVBNtcxCcD/6boNHEBkl/xSgRPswc5Ql2//SrshNS/4P/Am90rtyxns1F
         vKTg==
X-Gm-Message-State: AOAM530kcD+FBj57+oWi/8wmLRUTKXwPUjjEMBGuPVkpp183xzTLwrgQ
        V881OmsMBnpt0TXVz4I33ZgVm4sMskh4kQ==
X-Google-Smtp-Source: ABdhPJygzEDOu3R1JK6J7al3G+w+kBVoZo3VYTpO+ZlXVaSlWrA2J7kYp+DEnNd4C7DJLS+o2AXGqQ==
X-Received: by 2002:a05:622a:1ca:: with SMTP id t10mr3562942qtw.40.1605295133858;
        Fri, 13 Nov 2020 11:18:53 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r19sm6929606qtm.4.2020.11.13.11.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 11:18:53 -0800 (PST)
Subject: Re: [PATCH v2 04/24] btrfs: extent_io: introduce helper to handle
 page status update in end_bio_extent_readpage()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-5-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9abe522b-3dfc-3e57-889f-ea945fa79b44@toxicpanda.com>
Date:   Fri, 13 Nov 2020 14:18:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201113125149.140836-5-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/13/20 7:51 AM, Qu Wenruo wrote:
> Introduce a new helper, endio_readpage_release_extent(), to handle
> update status update in end_bio_extent_readpage().
> 
> The refactor itself is not really nothing interesting, the point here is
> to provide the basis for later subpage support, where the page status
> update can be more complex than current code.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
