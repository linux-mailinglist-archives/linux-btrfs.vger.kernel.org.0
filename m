Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A46A30489D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 20:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbhAZFnw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 00:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729992AbhAYPfk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 10:35:40 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0EBC061221
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jan 2021 07:21:03 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id z22so9874215qto.7
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jan 2021 07:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KQ3e8JmmQ6qyTMfl+B0Nwei3vmsUrXM2EseQEPtv8wE=;
        b=lconq4aPIAJXwRFYa8/AUwayICocuWwWDGg6t9TAngID364njjRzcq7Sx7xw4K+HaD
         EwHLEefiGwu/dHRx0sPd9n1vFFUi9z8FCJrF9F3RfwsBAUWk/3DgA79eaxFPs3ciSV6v
         bZZUrfF40CpHLaNo5Xr3wMK/xm7U3qMrqIXmEdTantcofrRxfJnOX3v7MHMr6JqErfYQ
         mnlg1CsIvw46s/AK2FVkz7geBWvDPL7M1jsM1LlqdLbGk5G3cuONRN7V2gduuhAXwnbQ
         u5g4J+gSom+EfrylLyWhVHuMlqsVi/ElZCG8Q+6iPhHMdB94Cd2t0cJ19icyJrwuVJQh
         G1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KQ3e8JmmQ6qyTMfl+B0Nwei3vmsUrXM2EseQEPtv8wE=;
        b=agfuI+LC6NyFfQFrmAfKPOLYjPhCcD7FL7inZuPVe5DXy916m6C5BXZlEqjyE2tors
         XT47pnnrUmG5JAqNJfzubplvjrfAcgySy/L0OArotudlJAvfb7jP4Qiwe96hXFaku0NN
         HzYUrPla3xdaucqlZ51xJgP+8Mo6kdv7mgZZ77UTa3S9KKXn5Jlh027wBEIX34fhoQl+
         55635dKOP4jUCrOyh2n+G5ulFTqXL0gO0cx7GRVdXlrO2ttpdiiFOjHrd9T0152TXJW3
         njsLgWuWrPpiCYtvBU0HamMOFKgzvGu7ubFYaYwxnnuEq8qn350XuHk9LHJhcF95BxyZ
         M0AA==
X-Gm-Message-State: AOAM532kaMpTdkxlSrZcitm6gRgrTiHuubgNVmOOqHq2ZwXIIJjq5F2E
        yVbk9pui6BJWG5lGz8LcQi+Lyp4V/DquApX2
X-Google-Smtp-Source: ABdhPJwsmiq7LoiwNkwYAnoQvTRT4V99cdNecrr4u3LQLa/d8zE7Af2qdr9vORaAb8hWMNW1vO3khA==
X-Received: by 2002:a05:622a:20e:: with SMTP id b14mr921833qtx.148.1611588062869;
        Mon, 25 Jan 2021 07:21:02 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 2sm9704573qkf.97.2021.01.25.07.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 07:21:02 -0800 (PST)
Subject: Re: [RFC][PATCH V5] btrfs: preferred_metadata: preferred device for
 metadata
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <20210117185435.36263-1-kreijack@libero.it>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ef8a85ac-4d77-1842-2969-fdfa8b2691e8@toxicpanda.com>
Date:   Mon, 25 Jan 2021 10:21:01 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210117185435.36263-1-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/17/21 1:54 PM, Goffredo Baroncelli wrote:
> 
> Hi all,
> 
> This is an RFC; I wrote this patch because I find the idea interesting
> even though it adds more complication to the chunk allocator.
> 
> The basic idea is to store the metadata chunk in the fasters disks.
> The fasters disk are marked by the "preferred_metadata" flag.
> 
> BTRFS when allocate a new metadata/system chunk, selects the
> "preferred_metadata" disks, otherwise it selectes the non
> "preferred_metadata" disks. The intial patch allowed to use the other
> kind of disk in case a set is full.
> 
> This patches set is based on v5.11-rc2.
> 
> For now, the only user of this patch that I am aware is Zygo.
> However he asked to further constraint the allocation: i.e. avoid to
> allocated metadata on a not "preferred_metadata"
> disk. So I extended the patch adding 4 modes to operate.
> 

Ok this discussion is going in a few different directions, and there's a lot of 
moving parts here.  I don't want Goffredo to wander off and do V6 only to have 
us go off into the weeds on random particulars of how we think this thing is 
supposed to work.  To that end, I've opened a design issue in github

https://github.com/btrfs/btrfs-todo/issues/19

and filled out what I think are all the questions and points we've all brought 
up throughout these discussions.  Everybody please weigh in on the task, laying 
out what they think is the best way forward for some/all of these questions. 
Once we have an agreed upon design then Goffredo can go and do V6, and then we 
only have to argue about the code and not the design.  Thanks,

Josef
