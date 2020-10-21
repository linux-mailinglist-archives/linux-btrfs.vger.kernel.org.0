Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9506C294E2E
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 16:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442408AbgJUOCV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 10:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408618AbgJUOCV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 10:02:21 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEE2C0613CE
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 07:02:21 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c5so2178770qtw.3
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 07:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jCXw5DxX5Q5aO0dafN8Ge1oFw5VL8CA83A/tPcRt3TI=;
        b=nXdjop4w79YofwFvmwKejOMit6qO48h8+La4/17JswwjapXVM6Ji+riumymxZzQBcn
         UD5oe9ly52JoW8Zq3gIEXwduCjXhsb5EkASJcxUAskss4qznA+1fFal8BUfQ9SIgv+w7
         FqKNlcsdoN6OEyVG93D5B0vyDyqXk6c638oFNzNgICMl+KWpcBOLwcnxK3E727ybfCFu
         dbEuEnDGTQApaNV7R9h07eW89rnM0W0lRwIJFcZTHtEnvfBfztgfbaa4PtmDxRu2zkA0
         Ote6B3kzDbOD/CzAmjpYrCY5G/fdYMjtkuRcXMtmN8+pecAmQGtrVOK1E5U8UBhVI85I
         TSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jCXw5DxX5Q5aO0dafN8Ge1oFw5VL8CA83A/tPcRt3TI=;
        b=NI3WemXXbDcgXaQmQSed1zXpG7HPCHJGxSUeLhoacXw2Fpj0ko9Ds9XATmTzaPJSEL
         rap1O8cKzVs4g3IOUeX/pq6F+fD448n8MRGEeQI1ms2Mtqas3nH3x5bK1f8LVyZGS5mt
         pXI6QLjMHj+FnPdkjYhD/YaRrx0S/qhTt+fkXVNzSQiDjGI9lnr9Naa3WMfcManr4ySZ
         /TjirEgr4WHxVeuyP8H2AF/Noee5Ce3JEQ6Xn0oyRO/TFcBMnB6Ekgp0DzfK7TKBurOm
         5r4gj5XbNIaRRIxmYdB9SfOnRRddAsiDKNMb16GEtPX/wCp44YqfHVb6ARbEy3w79ISs
         1V6w==
X-Gm-Message-State: AOAM531ep+5vLU4jyxYW38nz9al9VVdesh/kiX3xGXJJmg/ETb6bPY8e
        kN6JJIaz6eLJQH7quPrMydb5xg==
X-Google-Smtp-Source: ABdhPJzyCXC+WHFHO28BaScz2QXJWdBF82xKUtOopm+7RkQsE1FYUYPfLEKwWWoU6rg+tfBGvS0lYg==
X-Received: by 2002:ac8:5185:: with SMTP id c5mr3243897qtn.349.1603288940645;
        Wed, 21 Oct 2020 07:02:20 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v39sm1204332qtk.81.2020.10.21.07.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 07:02:19 -0700 (PDT)
Subject: Re: [PATCH v4 5/8] btrfs: show rescue=usebackuproot in /proc/mounts
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1602862052.git.josef@toxicpanda.com>
 <007ef6e4d542210148bc373d3a432d801e83019e.1602862052.git.josef@toxicpanda.com>
 <20201020160302.GA6756@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2f36a56b-7956-55b0-4adb-7fca3ead0f19@toxicpanda.com>
Date:   Wed, 21 Oct 2020 10:02:19 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201020160302.GA6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/20/20 12:03 PM, David Sterba wrote:
> On Fri, Oct 16, 2020 at 11:29:17AM -0400, Josef Bacik wrote:
>> This got missed somehow, so add it in.
> 
> No, that it's not in the list is intentional, see disk-io.c:
> 
> 3348         /*
> 3349          * backuproot only affect mount behavior, and if open_ctree succeeded,
> 3350          * no need to keep the flag
> 3351          */
> 3352         btrfs_clear_opt(fs_info->mount_opt, USEBACKUPROOT);
> 
> so it would never reach show_options, but the question is if it should
> be in the list. I'd vote for yes, it maybe made some sense for a
> standalone option but now that it's a one of rescue, it should not
> randomy disappear.
> 

I think yes, especially since it's one of the rescue=<> options.  I'm not a big 
fan of mount options that don't get shown afterwards, we still probably want to 
know that the fs was mounted with the special option after the fact, rather than 
just clearing it after we're done with it.  I'll follow up to remove this part. 
  Thanks,

Josef
