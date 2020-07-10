Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8E221B88C
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 16:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgGJOYl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jul 2020 10:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgGJOYj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jul 2020 10:24:39 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7442BC08C5CE
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 07:24:39 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o38so4516031qtf.6
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 07:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=grYXm3jXOLNE8vyKFwG6ubC+vwyXThtnrtCZ8d4rJsU=;
        b=a4imYuTTDOGSd8LLHjaoGfsq3daP4iqD97nkHJoG2az+79hcSiJWKJ3xqajwKwTtPz
         OJBPRoHKcFCjnsGUU01e+iC7Lb/Ji39gb1DnTwR4XKoew6fy5UiF1JfHJ5y6stoKlaMZ
         0TBLN22foi4Nsh3gETkfdiMTOUq4kSsfop4AyMIfm+pK8DJwBb+tZDvUb8rvbI4tHFZu
         r6x0jYkK6mJfTmcjHKWvxzeYPJ7ps3TLVCNvXvDcMkCJymztiTZsDhKbGwNJNFgLQHjm
         sZ0YUe24kzbMI1PfdH3bdUSBw4D6AW6mSrq+oJGuRMceeyQb0phA3vRvN6UNs9/wWd/9
         BZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=grYXm3jXOLNE8vyKFwG6ubC+vwyXThtnrtCZ8d4rJsU=;
        b=WeQpV3CKBN+Xmzju7FIIolAwTtzMx4fKpFwFtG7rqG0OyYcdO0Wk9i5OqiSVWJh7qt
         TWtZ5HEDejX9uIUwB3L6vkZjE/UCKBxwP0VryfconXptL9fdCaz2IaNc2g3RuHafBKmA
         wmrGsXVSNJv0QTgFKp7F3j7ny/KyY7VQnprH5WE4a4ORVatLszTQJvfXhHRyMY5mbWAT
         bk7mJ6P6ZBc+4GjJ+ScfwspTeI35YqHP61JbBGst1eCYLpWFjT/2cFOVONGxMseEmedt
         qmkbMrfhpZb2gmh3eKgMze0569k0Xp0whIXptTjnIMB+schz+P8TH0/PsVv+zDRatWO7
         /h0Q==
X-Gm-Message-State: AOAM533iVUB1Vf25NGe9toph06Nj4GAXz4nk03xgf2OEQoxhnAkectht
        bhbz8qc4q8NWmsc3z/IfzV0ZWb1zmS54KQ==
X-Google-Smtp-Source: ABdhPJwrGPNHpN9ZXFL+m/JXK1YAopsRXTLRABprm/bV2MOjICW8zfu3spIW4qShcpNWYmURdrQ9nQ==
X-Received: by 2002:ac8:2672:: with SMTP id v47mr67176718qtv.330.1594391078369;
        Fri, 10 Jul 2020 07:24:38 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u71sm3920877qka.40.2020.07.10.07.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 07:24:37 -0700 (PDT)
Subject: Re: [PATCH 0/3] Two furhter additions for fsinfo ioctl
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org
References: <20200710140511.30343-1-johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c2311f5c-3c2e-16bf-dc4b-3f077530d5cf@toxicpanda.com>
Date:   Fri, 10 Jul 2020 10:24:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710140511.30343-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/10/20 10:05 AM, Johannes Thumshirn wrote:
> This series extents the fsinfo ioctl by adding two new often requested
> members, the filesystem generation and the metadata UUID. Both can be
> retrieved from the kernel by setting the appropriate flag in the ioctl
> structure.
> 
> The last patch adds a compile time assertion on the structure sizes, so we're
> not accidentally breaking size assumptions.
> 
> The series was tested using the following test tool, strace support will be
> written once the kernel side is accepted.
> 

Applies and builds on misc-next as of this morning, looks fine to me, you can 
add the following to the whole series

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
