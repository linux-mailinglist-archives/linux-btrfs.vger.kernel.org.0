Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845DD224741
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Jul 2020 01:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgGQX6Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jul 2020 19:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgGQX6Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jul 2020 19:58:16 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6837C0619D2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 16:58:14 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id p7so5019171qvl.4
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 16:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5lT/0gIkHyLC7MfTw73Bh3GKR2Tx/RSCuzOdXLjn3bs=;
        b=Kw2QorjoW5VDQbPCouhFD44P/krO+H+089szngJOnq4psgPDClbfnCxVs712HPVkEt
         u2Uuq/BaSfnMjYi+n1P3XuRkXuIIzkohL1hNJhQgGAhcTLvXVSo8FElg90K6ecWzTXHt
         ULoriHeIYZQGylN2DVbdF/svqSqnrnghN1gPEcfjtLU3NVUat56ek3qRn0XkTT0R5OoP
         TA921NyFkLVtWlZyPtUf9sVLZrS7khWkz729mnsbXHaWBIGOd7g13kB7DvoproNCL4gp
         oqL83HfbMwzdrvFxIJAkSIV/7YovdyzNI1lKYsDSokHQWmKCVfhO5K808Zm/ml01IT5M
         ceTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5lT/0gIkHyLC7MfTw73Bh3GKR2Tx/RSCuzOdXLjn3bs=;
        b=eF0MWz0+zeP4xNarfCCmDpUYMqV4NyJUJNsVysnSfRJL/PrTKyyXtPwgkCPuFgHetr
         YfDFcdpXJubMARV4kLy+HWOC5GAZpRcuOp80i+A1vNPlktZA/7wE0CUodO8Zupb6Iv7L
         ZOeULrJ7nsh715w1Hkc8RL1NeY9G1rOOViJi+5fzjjcI64/aWu+TVwe4gmzLP70rb7ir
         yQ+SSbcKg62aTe9oUV6JIK5FPixHdfaH0MYEk/WyLSNyJIAQDLy6AopgzGAuN2KZjAaS
         xd/yPkQZhLbXWMbnj2duL5VUopYzNf/0DdT5sgqJ2OchJUdOwxLBVxzFFoDFnsJ3k3dT
         7qzg==
X-Gm-Message-State: AOAM530n7hrP64FXv+xMCk9kgDXInVMgHJMRUjUF3I1hXzh6QXixGyKH
        BWqFCCzv1cndQOzYSiGFSqC54Q==
X-Google-Smtp-Source: ABdhPJyl6mUXXe7Ce8DdYd6acZcaLkFGZotAt/15h3kLmLaDQ+TQfKCNof7oZT+dm0SwPOAzWIiOvQ==
X-Received: by 2002:a05:6214:370:: with SMTP id t16mr11373616qvu.206.1595030294046;
        Fri, 17 Jul 2020 16:58:14 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 15sm11024658qkm.93.2020.07.17.16.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 16:58:12 -0700 (PDT)
Subject: Re: [RFC][PATCH] btrfs: add an autodefrag property
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, chris@colorremedies.com
References: <20200717204221.2285627-1-josef@toxicpanda.com>
 <c9b9d2f6-8e2c-01c2-193f-8f589134d39f@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <99682fa7-4ba6-48df-60a7-a8eaa453419a@toxicpanda.com>
Date:   Fri, 17 Jul 2020 19:58:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c9b9d2f6-8e2c-01c2-193f-8f589134d39f@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/17/20 7:46 PM, Qu Wenruo wrote:
> 
> 
> On 2020/7/18 上午4:42, Josef Bacik wrote:
>> Autodefrag is very useful for somethings, like the 9000 sqllite files
>> that Firefox uses, but is way less useful for virt images.
>> Unfortunately this is only available currently as a whole mount option.
>> Fix this by adding an "autodefrag" property, that users can set on a per
>> file or per directory basis.  Thus allowing them to control where
>> exactly the extra write activity is going to occur.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>> - This is an RFC because I want to make sure we're ok with this before I go and
>>    add btrfs-progs support for this.  I'm not married to the name or the value,
>>    but I think the core goal is valuable.
> 
> The idea looks pretty good to me.
> 
> Although it would be much more convincing to bring some real-world micro
> bench to show the benefit.
> 

The same benefit as what existed originally for autodefrag, firefox isn't 
unusably slow on spinning rust.

> 
> However I still have a concern related to defrag.
> Since it's on-disk flag, thus can be inherited by snapshot, then what
> would happen if an auto-defrag inode get snapshotted.
> 
> Would any write to the auto-defrag inode in new snapshot break the space
> saving?
Sure but that's the case for all defrag, and this is in fact better than mount 
-o autodefrag because you can limit the damage.  Thanks,

Josef
