Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED10362383
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 17:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245206AbhDPPHA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 11:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244789AbhDPPG7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 11:06:59 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAE1C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 08:06:34 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id ef17so7913999qvb.0
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/1VrAuemsPVvss++t4IyDcXngBqMQ/K4u2jHyrYVjGU=;
        b=A6nDkQ8FUwtV7yXkaQEFpchEdfkFvHI7HtNSTKs+cdIUEe2jcoUC+uQfbheZ6xpp8v
         gwMvFpRgK/4o56QzfuNEt0I0NsoIsGvcYIHtZQkh5wteSAWlCmtfKCiXJoetfWznnxtR
         XgMCg17QKJLJNrrJt5xE+UDw500ykaGNRyHzcnqj/sO9qa2mVhIKFXGWKt4Mf2aU4f+p
         JHirGLq1B85dM69ES4Qh9NO8/NtIinjWnvSdA28lBMM+cwNklUFCjsIEK4MpgQ/0ArEK
         IcNFYQEjeOrdgLpp0FN8DlVzQxTH/n5zh4lpB8v+FVgZMpknCQ3mvQYbEWwJNe1z8aSZ
         BMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/1VrAuemsPVvss++t4IyDcXngBqMQ/K4u2jHyrYVjGU=;
        b=DtcvNhi7YGE7AjNMgL7RJlXDeNIxx1dmwKQQLwhDdbmktLUjAV8AUVndszGQZ80x0l
         Iwe4eKjti3n66N/asF8qJ5seYUgbvv47r1dc3uFqv82z8TV9q/W8JonLI/ex6GswHLNo
         nWBGbVuEEMgDyfj3FiQ6aGkoOEFe30ZoETM7I+sPbhK7NIKjqmp+gE5SeApi7WTu4kNb
         fHN2S0ioeTg8qfXxl0O07SVpOO/U6EhERk1V5EBZvvEI4pL9IM/Ho62pf4x7qgZmvw2+
         kM7J1lBKPkwQOS6VHnyVZSSUBtbh5nTaSCn8ZJ7qcwa8L1D0QMwQH28h/YkUQrJteet6
         WDoQ==
X-Gm-Message-State: AOAM533N/neqFOvVFJb39D35Fod00Z6hqGPfdUwxR9y7C4I8euWCha1e
        qJejWnCJyHiMeksj7Y2SozSsLAXWpYQ5Ag==
X-Google-Smtp-Source: ABdhPJwurbXMjpiVetSWkyXAC5i9Iptet0RF1CvY8t8aSgm5FXBl5INms5+YJ5tis8ChOcYEM7mYag==
X-Received: by 2002:a05:6214:11a2:: with SMTP id u2mr9136145qvv.52.1618585592999;
        Fri, 16 Apr 2021 08:06:32 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a26sm4225243qtg.60.2021.04.16.08.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 08:06:32 -0700 (PDT)
Subject: Re: [PATCH 15/42] btrfs: refactor the page status update into
 process_one_page()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-16-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <60007dc7-8e7b-955e-a16a-90221fb3aaaf@toxicpanda.com>
Date:   Fri, 16 Apr 2021 11:06:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415050448.267306-16-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 1:04 AM, Qu Wenruo wrote:
> In __process_pages_contig() we update page status according to page_ops.
> 
> That update process is a bunch of if () {} branches, which lies inside
> two loops, this makes it pretty hard to expand for later subpage
> operations.
> 
> So this patch will extract this operations into its own function,
> process_one_pages().
> 
> Also since we're refactoring __process_pages_contig(), also move the new
> helper and __process_pages_contig() before the first caller of them, to
> remove the forward declaration.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

The refactor is fine, I still have questions about the pages_processed thing, 
but that can be addressed in the other patch and then will trickle down to here, 
so you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
