Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A58272717
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 16:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgIUOdh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 10:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgIUOdh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 10:33:37 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AF9C0613CF
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 07:33:37 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g3so12428253qtq.10
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 07:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lZmS0sYnIpamTgh8yRO0ppjbopWuzXTeah1Q4hCrqYo=;
        b=1SjJ9A2ppKXtKOz7pJHIZRli9YXJT3NnWIbKq+xIAW77C9lMzWpRDYahbM4Tn4sS8R
         CCwCMvcntBTT0/OyUPD7cW7vgzucbRtScvQ8z67U0A9rkn3wEljJZp5OJrq2N9rWoty6
         rl1YsOinyYrqHjLf39NaAntXWSl6pXM1zf0L27nMPF09UQvozvCQwxJ+M5J/IWvGpaJi
         b5nWD00kTZmGfoYwa1o5uxPopV4x0bFDY+h7PZtLm89h8eWjY5xKq1wsfVtDc+N+LyzV
         wRn2+EfaQo1A28DEApapn0QC0nLH65lASd7u0kfxaiouPvB8h3hzXI47zmZYGEe+m45J
         jlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lZmS0sYnIpamTgh8yRO0ppjbopWuzXTeah1Q4hCrqYo=;
        b=FmXdL7R3vj1uvug39Xe9QBJiIgPn7TG4WpaYQVGj/2h+6QRHjojM52FG1dpOh6iuz/
         GsjBNEi6PeHoC8itDwiCzsYwvOZFeuqCpV+JN4PF74zooc12YGsAUb2o41pUBkBIYZvW
         Vn1twk/aMIyNq73cXt/wlhi0Dq0gwkm6Dsuspbqv3mKMxAfC+WqRt0BxiykPaGXecwAn
         X9DvkYXDXYscs+4OiD8pXxjGUrehPn9pk42gcv9iqu4TFeAEUE60d1Y3501NdrTosUAc
         WyyYb4zwBK9riQK2apVrQcu0jsKRTW8Y6LUPmDbDsX3djw+oWn7eAPNk3OwQzVoQgaZE
         U+zA==
X-Gm-Message-State: AOAM530KGHHiRCygM/LtPfMnhFJU1mVt2xMI/nOIHpbyQ6MwPFjwyYCL
        xRqZLNcv4dAFYnlVIX0Gt7FpRA==
X-Google-Smtp-Source: ABdhPJzExD1Dmg3FMfUX+RyZujSDrDqu+a6oJRSy+NFAC/kOmjoi5kFTYBK/20T2+8RX9ZDBljO1FQ==
X-Received: by 2002:ac8:4e4e:: with SMTP id e14mr34517003qtw.49.1600698815759;
        Mon, 21 Sep 2020 07:33:35 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v131sm9575723qkb.15.2020.09.21.07.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 07:33:34 -0700 (PDT)
Subject: Re: [PATCH v2] btrfs: remove stale test for alien devices from auto
 group
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Eryu Guan <guan@eryu.me>
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        fstests@vger.kernel.org
References: <20200921143035.26282-1-johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6a74a0c3-038c-e079-8243-ce14bc0aec2d@toxicpanda.com>
Date:   Mon, 21 Sep 2020 10:33:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921143035.26282-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/21/20 10:30 AM, Johannes Thumshirn wrote:
> btrfs/198 is supposed to be a test for the patch
> "btrfs: remove identified alien device in open_fs_devices" but this patch
> was never merged in btrfs.
> 
> Remove the test from fstests' auto group, as it is constantly failing.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
