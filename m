Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A3F3057E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 11:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S314396AbhAZXG7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 18:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729553AbhAZUdT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 15:33:19 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C023C061756
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 12:32:39 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id v126so17297200qkd.11
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 12:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=egq9BDg2YlOhTlTZq3syetqtbgqu58WrhupSsqsQaMg=;
        b=Bmr3Lkb7q2wAB7vA1qfnOMJXWPgvhIQrezVRhT0yjBNh7u6M/B3xn4MP1o3CCSf9+0
         dkgXmizizOGrp6l4MJVGMAI+/FMhCCMCiUogZOukCrN754bHLcB9sRH1SRPngzpVnDhz
         1fDVURg17nDR3JJN0mQXrh12/NUC0yxXlCGGILqpGHKjq6s1m12e8qgoAVgWC0kn3e2n
         EtKcYnvRBhd2L1S5CDagowCMTdZSeSBKwz2fkWr8RKl4BvzZFury+NK4PvqF3St7FRU4
         SRbzx0bdR2sayp4Hzbhn9FXGmqWWdMrEspgj+OPN8KmV1hkGPDntUBte0AIaoV709otw
         S63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=egq9BDg2YlOhTlTZq3syetqtbgqu58WrhupSsqsQaMg=;
        b=QMniujHSixmjnwO84mXtSGee+l+leP0bS6XvndMkKGVP+bMhNlRizVcjxeoBVw9SEO
         p4tHGqsnco9FS06yqNEOFOvfVcIWkaQrsg+IlhYJrjLnqDY8dWh7D2JYXvQrnU23rL8L
         mlSRLVDV6Mdx+TkTQV1UPZmLnHnc5WzokkLcoaCaC42LZqc8Mt4Ud+E85HndyqwhDTx4
         ffLt4F33L0bb2BGl9GYhErRrjidboXEuMj10ff5bTE4KCU7dMAkRetDshuuJlIHNTzQW
         9Qst03K184+QYnUqsXUBvagu2TClif+QWzR8sbnM+89LVID5N6Av3Oi1GUkjlQ+J6GAJ
         xygQ==
X-Gm-Message-State: AOAM532Wu6VJzHn7N9uxODfL4UcZC/AadPm1FwQNAL6aXYC18xH5tcVg
        f/dDLSDczXhjnuXnVWM4Ms1DUg==
X-Google-Smtp-Source: ABdhPJzS3BWhyfPXaAIBD5qsnbLY9P38gkDUedqLqEDFgYdCkVo0vsBECiAbiH9gyMYq2tL0KuPEoA==
X-Received: by 2002:a37:8fc3:: with SMTP id r186mr7567969qkd.228.1611693158377;
        Tue, 26 Jan 2021 12:32:38 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t184sm14945263qkd.100.2021.01.26.12.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 12:32:37 -0800 (PST)
Subject: Re: [PATCH v3 01/12] btrfs: make flush_space take a enum
 btrfs_flush_state instead of int
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1602249928.git.josef@toxicpanda.com>
 <397b21a29dfe5d3c8d5fec261c3246b07b93e42c.1602249928.git.josef@toxicpanda.com>
 <20210126183624.GU1993@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ea66a2e1-6cd0-8ba9-42dd-a062e31e2dc0@toxicpanda.com>
Date:   Tue, 26 Jan 2021 15:32:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126183624.GU1993@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/26/21 1:36 PM, David Sterba wrote:
> On Fri, Oct 09, 2020 at 09:28:18AM -0400, Josef Bacik wrote:
>> I got a automated message from somebody who runs clang against our
>> kernels and it's because I used the wrong enum type for what I passed
>> into flush_space.  Change the argument to be explicitly the enum we're
>> expecting to make everything consistent.  Maybe eventually gcc will
>> catch errors like this.
> 
> I can't find any such public report and none of the clang warnings seem
> to be specific about that. Local run with clang 11 does not produce any
> warning.
> 

IDK, it was a private email just to me with the following output from clang

s/btrfs/space-info.c:1115:12: warning: implicit conversion from
enumeration type 'enum btrfs_flush_state' to different enumeration type
'enum btrfs_reserve_flush_enum' [-Wenum-conversion]
                          flush = FLUSH_DELALLOC;
                                ~ ^~~~~~~~~~~~~~
fs/btrfs/space-info.c:1120:12: warning: implicit conversion from
enumeration type 'enum btrfs_flush_state' to different enumeration type
'enum btrfs_reserve_flush_enum' [-Wenum-conversion]
                          flush = FORCE_COMMIT_TRANS;
                                ~ ^~~~~~~~~~~~~~~~~~
fs/btrfs/space-info.c:1124:12: warning: implicit conversion from
enumeration type 'enum btrfs_flush_state' to different enumeration type
'enum btrfs_reserve_flush_enum' [-Wenum-conversion]
                          flush = FLUSH_DELAYED_ITEMS_NR;
                                ~ ^~~~~~~~~~~~~~~~~~~~~~
fs/btrfs/space-info.c:1127:12: warning: implicit conversion from
enumeration type 'enum btrfs_flush_state' to different enumeration type
'enum btrfs_reserve_flush_enum' [-Wenum-conversion]
                          flush = FLUSH_DELAYED_REFS_NR;
                                ~ ^~~~~~~~~~~~~~~~~~~~~

I figure it made sense, might as well fix it.  Do we have that option for our 
shiny new -W build options?  Thanks,

Josef
