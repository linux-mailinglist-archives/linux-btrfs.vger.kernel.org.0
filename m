Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C74C2F1A05
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 16:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbhAKPtV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 10:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbhAKPtU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 10:49:20 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464A6C061786
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 07:48:40 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id h13so1912544qvo.1
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 07:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9ln6bz3yyd1W5+sBe1fRyhA6q3eWpQ1fyqVKWkHkeXI=;
        b=eNU+2aI4/iuXRY7vZWYfRR0CPwaIrW5wQF7NDgwxbO+S0eoYSOGqjRlPrxuHxx7Keu
         2kpq/a/47hCnP4T7Dpie7E42Z5D3XhESPN1/6e29Z3z8C+QtzTWbX8aiiI4QJyfDOdz+
         DefdZHOzjrP+6oaBFMNfctCQ/xAok+ANAChdY2XnO4NIxToLxOrOVuZsUa8iqXPrZiaM
         Odp/uonVVMx0qGdUPP/UgaTL5QuBUK8FOQsgUsSXFzruqBWfrAKaD5LovEE689l6TRS4
         M6HRMM1PxoG70eDI0O5Nd21GhhNgqdNLsDicnH4FuXIV2pg0e/w/hhwDIPkXID3WcaSA
         q5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9ln6bz3yyd1W5+sBe1fRyhA6q3eWpQ1fyqVKWkHkeXI=;
        b=dR+9LZxVdRjKJDy47vgrICDn3vAGkpuPj8bZjLKQUrO034Njzg4G0dO9fbyR6bpv+x
         /hQQnw22ycn8RvvU6XLNFKfzg/BVaxwiHBaWtrWdoADWWeze2gPaZgkJkE9AM6dlJpd9
         uBusdLTBcI4Cgus2mcAxmAHBTsHrLKtrshKX++luIKqqGVwkx8r47P/EBgQGX/8uAALb
         k2OX3zePk6gs8uHBsrpg3BvtY37q9U6wbTphxBVA5vpVISfU0vJYVz9ZS81js10N2vjY
         4lKWr0cI4IwDKPveEH4XyzAH2MCTXzwCUepZWnxNW9MPWSHP2RVLhElG5DtWySgLgI0A
         msmA==
X-Gm-Message-State: AOAM532lqhYhmWIqsdJCHgW3vnBjYvLDkpDD7W5Vuo1h5Ppz6RmirFNA
        E6j3NX6e+OmvQVfSSTagGBDupO0mQ7ulBc/I
X-Google-Smtp-Source: ABdhPJyuhu5ZPw8yi1s/evXfmjNXN99HU/zI2gp8JHUMQQ3K/UStoLxMf+mfxosg5kTHEDJ67AgEag==
X-Received: by 2002:a0c:9e5e:: with SMTP id z30mr252307qve.56.1610380118402;
        Mon, 11 Jan 2021 07:48:38 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u4sm7868403qtv.49.2021.01.11.07.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 07:48:37 -0800 (PST)
Subject: Re: [PATCH 1/2] btrfs: Make btrfs_start_delalloc_root's nr argument a
 long
To:     Nikolay Borisov <nborisov@suse.com>, dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <20210111105812.423915-1-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ad043e20-10de-d1f6-6361-9fec461dbaec@toxicpanda.com>
Date:   Mon, 11 Jan 2021 10:48:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210111105812.423915-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/11/21 5:58 AM, Nikolay Borisov wrote:
> It's currently u64 which gets instantly translated either to LONG_MAX
> (if U64_MAX is passed) or casted to an unsigned long (which is in fact,
> wrong because iwriteback_control::nr_to_write is a signed, long type).
> 
> Just convert the function's argument to be long time which obviates the
> need to manually convert u64 value to a long. Adjust all call sites
> which pass U64_MAX to pass LONG_MAX. Finally ensure that in
> shrink_delalloc the u64 is converted to a long without overflowing,
> resulting in a negative number.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to both patches, thanks,

Josef
