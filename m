Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2703623CD
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 17:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343554AbhDPPWW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 11:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245504AbhDPPWS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 11:22:18 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E49C06175F
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 08:21:52 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id d1so2024835qvy.11
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Apr 2021 08:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=J9yQeD3U2OWqB8p4fZ+nvfZt2snRCgYNinMKNfi9gig=;
        b=llfuZ5h2Glvuw6o8XXR+bHeUEz1+utmKUPbnHe2hVfiVx0Fhj10+NaYiAeiJiBv1QP
         zf1QUl/ney0FibD6nHGLcX6ZyR8yYRJ2lZZS2REVv3B5iD8oCHGMULR9kRHPV32j3Gpu
         cVP11+aFj4W9NRhzrWwcJBHX7Lolx0/RaBMaNK7/CWKVmAEVt2OAurvBVVeHnAmXhKC2
         qGkLhU3IP9SKNdbTd8XKSssUZBxzaeltmq6t1qWRvk0yjfAqsTeisDhXBG9i1Sukb1bZ
         INRiI6ZW0TpgHoftehsRDm5UWLDHvlBOppL61rQkoAelZtYKJQV/XMhJfMcZHJIauidv
         pCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J9yQeD3U2OWqB8p4fZ+nvfZt2snRCgYNinMKNfi9gig=;
        b=WuobA8LIx3RbTUoiSwbtIO5g/Crx6eFLqMklHfeawF79JZOGviq9pc031IzIGlyYro
         6qcsLaifSNKd9p7+AD9B/5xmZ0gveN6msBRhQjz/DMBaP9nt9FXSPdoSSTmFxBnv2J3p
         Gz5d3KmQAf4JrScAcVxG3bYnjhDocVQayA5H16R+Bzn66sHeV7HZVIQtzXbuRFKpaIKw
         NEoQugct/0t5rnpwZi+WkRP3d/EmqevvxTBHBRvw6/KSznnxtw0xwCMsyGafExTTFe6K
         kKBncYA4M/WG4Eflou10oj3lLc5vq0hdEAWkFsl9RFMjd5943rJCNBkBE/HrW01HQX0m
         gDWw==
X-Gm-Message-State: AOAM530m7N1X2rN0/hFt6pFUNhuuH++Ukm6z2quL82vUS6z5xG+fIuJI
        sQsNg7jilTq0rx2xzrEGZqQLvs9fTkeGfg==
X-Google-Smtp-Source: ABdhPJwCvVpFkjTsBARjXlcwilx18WvPIR6U4ICo2XHDvIiPQbsJxYt3ZgvbgM88pJlVCesG61S+jQ==
X-Received: by 2002:a0c:dd0a:: with SMTP id u10mr8937432qvk.42.1618586511311;
        Fri, 16 Apr 2021 08:21:51 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h65sm4353893qkc.128.2021.04.16.08.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 08:21:50 -0700 (PDT)
Subject: Re: [PATCH 20/42] btrfs: make end_bio_extent_writepage() to be
 subpage compatible
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-21-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1f1db19f-082f-2b8d-9b7b-4f62d5c3aad8@toxicpanda.com>
Date:   Fri, 16 Apr 2021 11:21:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415050448.267306-21-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 1:04 AM, Qu Wenruo wrote:
> Now in end_bio_extent_writepage(), the only subpage incompatible code is
> the end_page_writeback().
> 
> Just call the subpage helpers.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
