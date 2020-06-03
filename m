Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F761ECE8C
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 13:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgFCLih (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 07:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCLih (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Jun 2020 07:38:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B26C08C5C0
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Jun 2020 04:38:37 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b5so1426144pfp.9
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Jun 2020 04:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MR9tHEhWg6r3pW6bA5yS/4uhCahdz9NySIjLZ9tV2tE=;
        b=XpIcKN5B7/Vb3M59ZR/fnY1ijicwDgIZKo8aRkhr3hbnLqxgfUVzfL29L+J+Nnxt9P
         TS1FKLhLWdAAM86C+wc/M+L6deeDPjhkDYrRw138rIAW2jrJm42zf4Uq3EDsr3QsCz/+
         BtGBlk3yKiCbW+qP+3rizXnvibfpgMqjnaW346835cE1/M9/MJlqjSDelMYiyo+YeyTX
         buLJLrIr3sk7/oHs/VG0FPw8+yGxDQLCpZbMKNlpkt/b79twdWCJOnRncXMgZ4E4rT9M
         g/RRJEqKj3cuQSDGPxbDcq3e1Jj/JyIbKRkksm86fPP2ChL3rNHJL88/OKsoRk/HXXz7
         zscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MR9tHEhWg6r3pW6bA5yS/4uhCahdz9NySIjLZ9tV2tE=;
        b=MwGiI+ifLMgzodkGm69nXXjh0PmHKGwtEv/dZi4xXwjt0VNyhysMlJupQ3iMgA4ban
         5pDDuLcB7WolBzf0srsJpiyYFPqw90aE4VyqJLyxHpnoP+GXpsv6D2E3E+/9/jaaVny0
         oxX5GBj2VJvJ7GnqVy9xllsIMpZdCUWZR1tD1LEx2hFzScLnKfGVL72AByrAQaeE8Pey
         B/Gs0B0cqvqMd4c5dpVe+ZBLi2XojsLyllOfeUNVH10DCM75fUjxoqtoItwfpcX+IVCv
         XVDW68IqX18TwUnQwX0ke9sWwmqGhaTEC0MkilGZnCi7ZSV8FHXovGNoQ+PcIjhdq2+4
         Qv3Q==
X-Gm-Message-State: AOAM532n1cr4hgsiOoaweM8uDsBMKbHeTAyv5F37j5M7OFzvOn5cvPyN
        B4VlP3yUwR4W8t+lWuvPQS+tIP78bH4=
X-Google-Smtp-Source: ABdhPJx3MCrPEcXO6fles0rmMHPnY3oAJNiOg3ZjvEEPjK8+Zj3EQWu/PGxGJhrl8QUqgcqjJZouaA==
X-Received: by 2002:a17:90a:c588:: with SMTP id l8mr5551615pjt.178.1591184316495;
        Wed, 03 Jun 2020 04:38:36 -0700 (PDT)
Received: from ?IPv6:2406:3003:2006:2288:b572:d48:357a:4003? ([2406:3003:2006:2288:b572:d48:357a:4003])
        by smtp.gmail.com with ESMTPSA id y23sm2506775pje.3.2020.06.03.04.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 04:38:35 -0700 (PDT)
From:   Anand Jain <anandsuveer@gmail.com>
X-Google-Original-From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH 2/3] btrfs: rename btrfs_block_group::count
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20200603101020.143372-1-anand.jain@oracle.com>
 <20200603101020.143372-3-anand.jain@oracle.com>
 <CAL3q7H7g6DA7S27RM8o=uG7wbXbvKYKvc6ot2qnnaY1A73kPhA@mail.gmail.com>
 <f01398d6-2a0a-95e3-9372-2029626a3447@oracle.com>
 <CAL3q7H50fugFVM5Hq7fEg29SjmUi+jfetMBS5LCph9LRP525ZQ@mail.gmail.com>
Message-ID: <bed5d4b9-928d-6f7a-87f5-34bbeff08f2a@oracle.com>
Date:   Wed, 3 Jun 2020 19:38:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H50fugFVM5Hq7fEg29SjmUi+jfetMBS5LCph9LRP525ZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> 
> Why rename at all?
> It's pretty obvious it's a reference count. Count/counter is not an
> unusual name to use for a reference count, it even has get and put
> helpers...

I understand as the member count is in btrfs_block_group so prefix bg_ 
looks redundant, but prefix bg_ is still useful. With out the prefix, 
the grep ">count" *.c didn't help straight away to verify where is 
block_group count used. At two places we missed using the get helper 
which the patch 3/3 fixed.

It's ok to drop this rename patch if you find it's not inline with the 
rest of the codes.
