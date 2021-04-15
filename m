Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F636361215
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 20:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbhDOS1H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 14:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbhDOS1G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 14:27:06 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BFBC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 11:26:43 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 130so12020110qkm.4
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 11:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iZp0l10FBDkG80ZKuhlrCkXWsKOJk2IZ8Di1viOlgF4=;
        b=NgstqnFsfORiGc7NZWg8GAh5H7vjXwo4WnH9xVmuQCqbJVE8fPN2r+7GWSOS6FZIuV
         ZnlY36HVYn9WySBiTUK3dk0x0xUwWrvBvt9FjJXKE773rxMJ0sYLSmMlJGTP4exF2Qrc
         nP7RNLsfvdOB1OCXAYTj0EqK8BAPUu2z3Wnho1tn1S0PDPTaPO58ja1Kj35Y1qTO4gc6
         ipU3ilSaxQRZBnRtdpZbwDgzXllTKguafCeMFmydynqW0jFfYmTAAVCNIvBrMVDtSPm+
         OC2vkixWCqEZgNo4oI601IWGXeDwJUz3faN0M/rI/IwpL9w0pZa0+9Qkbx2Ej3rV7a6J
         QM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iZp0l10FBDkG80ZKuhlrCkXWsKOJk2IZ8Di1viOlgF4=;
        b=NWIhhpvGGhGTUXEdvC/NE83BTXUQezKhnsYfgt/Zez9gwJnbpZ8zF7yPRDuMi8XgT/
         ZeqyfGSdj/me8n9YX4Qp9tjep3ElN1RHG6QL8gtjUg0Pgg87YzempUF9eow9dD2zJckc
         09z9CstLljGTkN85FpIDRfQwwLlPuElr8STgUJth9QFFGZu7qJbsAOJqihuVpy6reTuZ
         bBbaIJhXfCuwPFFYAWxt+G1nSSV8dQNBiNx4ZsdjwdVD7lzQCW87sFP6eQmbibpbSXMX
         QSSms3tuDL1JiR19OGf7yNztzFlpyVUGC6Asq3vEC6PN5HIHqLDmWOBPSywKWlNqluLl
         UWiA==
X-Gm-Message-State: AOAM531yGtc8eijV6LaRttmko+uVmEV8YhOLqpVyAn7BJeG1Xi8ID5Pn
        RxS7ES6mWR95T/+laCgLZBXHlg==
X-Google-Smtp-Source: ABdhPJx7/SAff69YzHQHyZrHMSatdH0gnJYHx5iUrJNLK7umq+0Fn2YYtwNsnm3mVX5MQva4XfRw1A==
X-Received: by 2002:ae9:eb4d:: with SMTP id b74mr5103895qkg.4.1618511201792;
        Thu, 15 Apr 2021 11:26:41 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c9::1288? ([2620:10d:c091:480::1:2677])
        by smtp.gmail.com with ESMTPSA id l12sm2393424qkk.59.2021.04.15.11.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 11:26:41 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] btrfs: rename delete_unused_bgs_mutex
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
References: <cover.1618494550.git.johannes.thumshirn@wdc.com>
 <160b0452ecb4a810b819e0eae68bd9ef507cc813.1618494550.git.johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a68bad93-fd70-b83f-1594-fbc9ecaddb83@toxicpanda.com>
Date:   Thu, 15 Apr 2021 14:26:40 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <160b0452ecb4a810b819e0eae68bd9ef507cc813.1618494550.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/15/21 9:58 AM, Johannes Thumshirn wrote:
> As a preparation for another user, rename the unused_bgs_mutex into
> reclaim_bgs_lock.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
