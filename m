Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8F94EBA41
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 07:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbiC3FkO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 01:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiC3FkK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 01:40:10 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C80B63A2
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 22:38:25 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id c15so26199161ljr.9
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 22:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+op4kYQLYOc7+1jVcMfDL6zEMtvMY5xmHr7nEgfrHJI=;
        b=ikM93CvdQc3LRMCUgNOHilZUMhnGdMlTQqvruoptSOl1uhR72IPOhwlu8SbWMyzOum
         7rQcM8b5cIQ7C2c+21pzWulyk0EuWRsGSgZAPJDYO99yoNqusrRr0r5ZHkr2umrzdd32
         yWWhnGk4CRx8Qkbk02nFIPFs5BerDaLXRslBISL0cj5WC0UULAG4R9fnWLKHPWqGGxtE
         pGxDSLk5elshY92y/gs3eJzlZf8ofz+Nq8QG0/bPrQnmH9zDnnfDinWr5QgWwERV8/sU
         vO8n3K6EJg87ril1t49Dpbw66vTRV2MfghOpNM+kiPOYxHqSgqzadZXdSAJMNM+VsmPC
         1jRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+op4kYQLYOc7+1jVcMfDL6zEMtvMY5xmHr7nEgfrHJI=;
        b=424IZK4jR4PazOxIhYLbV6ITpNXs8Mj8Hb9Nvr30nxoAKXYKQITO+ehkcDXPiDblmH
         J4B27xsxucR96u5InUayItpW2l7dUCB9asDGPtox7tDwpeHRadsi1h8bJn6I7tbsMB/E
         5VWba91a32heHSCID+glg3X/VV0zmYmNr13SWwoRVRchtvNkI2QdHLxB8ZzDqZQxMcge
         8/jii4ClX9niaYuU78RK04XAP9jdMb60LhKXWpj/obmF+sOiSMbfiWkl/SDgibbldvQ7
         0YwZErSNy6naWOQEuNXS8/Qzf/jJmCougLqnqBMByAeZndhVxES+F1W0UpCpjYg15qua
         2LaA==
X-Gm-Message-State: AOAM532b+2wdg85e/L0kPfCYCAcGXUJ4mQuJMSYzsmzvxamVUljOFepa
        8WDG74AM99RysU2TPnwSMHGTqXDGyvt/gJheN9Y=
X-Google-Smtp-Source: ABdhPJz1bWr2FYyYEvbuPZaA0aI0o7osoTWdKJEWjtMwvlJfnVCguB2sSrO2y5Or1NzmVAYnHTANrw==
X-Received: by 2002:a2e:b88d:0:b0:249:86c0:fbd8 with SMTP id r13-20020a2eb88d000000b0024986c0fbd8mr5519350ljp.247.1648618702886;
        Tue, 29 Mar 2022 22:38:22 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:3ffd:fa46:42b2:52e1:1c7d? ([2a00:1370:8182:3ffd:fa46:42b2:52e1:1c7d])
        by smtp.gmail.com with ESMTPSA id f15-20020a0565123b0f00b0044a29f8ec94sm2210571lfv.95.2022.03.29.22.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 22:38:22 -0700 (PDT)
Message-ID: <dffec23f-bef1-30e2-83fc-b3fb9bb5f21e@gmail.com>
Date:   Wed, 30 Mar 2022 08:38:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: 5.6 pretty massive unexplained btrfs corruption: parent transid
 verify failed + open_ctree failed
Content-Language: en-US
To:     Marc MERLIN <marc@merlins.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Chris Murphy <lists@colorremedies.com>,
        Su Yue <Damenly_Su@gmx.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Su Yue <suy.fnst@cn.fujitsu.com>
References: <20220329171818.GD1314726@merlins.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <20220329171818.GD1314726@merlins.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29.03.2022 20:18, Marc MERLIN wrote:
> Howdy,
> 
> This is the followup I was hoping I'd never have to send.
> 
> kernel was 5.7 (long uptime, just upgraded to 5.16).
> 
> One raid5 drive failed, and as I was replacing it, another one went
> offline, but not in a way that the md5 array was taken down.
> I shut the the system down, replaced the bad drive, the 2nd drive that
> went down wasn't really down, so I broght back the array with a drive
> missing.
> 

Sorry, which drive? You had one drive that failed and another drive that
went offline. Which drive you replaced? Which drive is missing now? The
third one? The one that failed? The one that went offline?

> mdadm --assemble --run --force /dev/md7 /dev/sd[gijk]1
> cryptsetup luksOpen /dev/bcache3 dshelf1a
> btrfs device scan --all-devices
> mount /dev/mapper/dshelf1a /mnt/btrfs_pool1/
> 
> BTRFS error (device dm-17): parent transid verify failed on 22216704 wanted 1600938 found 1602177
> BTRFS error (device dm-17): parent transid verify failed on 22216704 wanted 1600938 found 1602177
> BTRFS error (device dm-17): failed to read chunk tree: -5
> BTRFS error (device dm-17): open_ctree failed
> 
> It's a pretty massive array that will take a *long* time to recover from
> backup. If there is a reaosnable way to bring it back up, I'd be
> appreciative.
> 
> gargamel:~# mount -o ro,recovery /dev/mapper/dshelf1a /mnt/btrfs_pool1/
> BTRFS info (device dm-17): flagging fs with big metadata feature
> BTRFS warning (device dm-17): 'recovery' is deprecated, use 'rescue=usebackuproot' instead
> BTRFS info (device dm-17): trying to use backup root at mount time
> BTRFS info (device dm-17): disk space caching is enabled
> BTRFS info (device dm-17): has skinny extents
> BTRFS error (device dm-17): parent transid verify failed on 22216704 wanted 1600938 found 1602177
> BTRFS error (device dm-17): parent transid verify failed on 22216704 wanted 1600938 found 1602177
> BTRFS error (device dm-17): failed to read chunk tree: -5
> BTRFS error (device dm-17): open_ctree failed
> 
> Worst case, if it's dead, I'm still happy to try btrfs check lowmem to
> see if it has gotten better.
> 
> Thanks,
> Marc

