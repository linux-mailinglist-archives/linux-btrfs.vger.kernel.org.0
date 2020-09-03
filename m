Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5843B25C5A1
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 17:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgICPqr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 11:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICPqq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 11:46:46 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE71CC061244
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Sep 2020 08:46:45 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id p4so3518099qkf.0
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 08:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4JSzfgjCEvFAE6+lxgY6HTdHX8tYhQbklu4+oUgQb4s=;
        b=X7aJjPANQCosbIWOgpXHu2RiWMC3k6CD8Vtrmqd+Q9QXUE843WgS2P95uts8xTmNHm
         +F93VFx3da630jUaIWXWh6yYonZhPghehFFN8Vg5ud5bqam3Fs+3/+c6PjfXe1SXUGdQ
         XTuVh60CVc/vSF5wHrxKuXEvsYb44KajESMd1jpmVzV5WiSfYvX2aZdiCjepO8DW9oc3
         GyIr93rCJbOvO2VVTX/11BTIktJeiCNXFxKhxYg+9yewo77mlmNWrzXe7zp4MpgFjrEY
         2hhm2DMjHf4WyVcgi3rOVBmsLPtpeg7S+k7q3vXQH/ChP0DlYh97B/MR+noBdHbMRM8B
         HdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4JSzfgjCEvFAE6+lxgY6HTdHX8tYhQbklu4+oUgQb4s=;
        b=UGt4uFg9Q8Kd+H6qQYgFlAQDrVWpUUHdhGZQv0CHa+vsmTJBio1xq1w5mkSsL6i3OJ
         Kp9uSdnrGUneTdWyXOEUOAYHK6PW4qK/MSVNHo99a7khnPAzp6aY8/0XkXJFrTVJoNYa
         4SQC0rEZCC1tkRFLCkPyPXMxq2IIMM+3QtascEqnQjnazbbCaNw3BxuMZQ4bPiP0qu3I
         xFhmonB76Uvk3LJ6sqmESrxCPet6jvS5eIpk4JvhvD2jBiOs9yFNiWOzY8iZjIa8yNsq
         5a+hbwkK++r0xjqFCE54L+zkLU6e5Wxk3dgdGlUm2tOrn1weC5WEHGTKfxbkr7UZa5no
         y5hw==
X-Gm-Message-State: AOAM533cR3ZRQpNVjtB08mEIUmnKCnn9J0MRhBjxxQJTfuOE2lox0dQl
        /ay2wyZzPBXzb2mb7jIFDZS/KQ==
X-Google-Smtp-Source: ABdhPJymGU7Cvzf5wP1VDSf9X17UVgXrgUW/bI5CSEoWfjhPXtjgMgsSG86tjZaDhFzzAYmzqsRcDA==
X-Received: by 2002:a37:644c:: with SMTP id y73mr3811990qkb.246.1599148005039;
        Thu, 03 Sep 2020 08:46:45 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u55sm2435572qtu.42.2020.09.03.08.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 08:46:44 -0700 (PDT)
Subject: Re: [PATCH] fstests: btrfs/161: extend the test case to delete seed
To:     Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, nborisov@suse.com
References: <cover.1599091832.git.anand.jain@oracle.com>
 <71d375fd6409806ff919415bb1947f437a404367.1599132513.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <637723ad-d34c-6dde-6837-508ba68bbd42@toxicpanda.com>
Date:   Thu, 3 Sep 2020 11:46:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <71d375fd6409806ff919415bb1947f437a404367.1599132513.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/3/20 7:35 AM, Anand Jain wrote:
> This test case btrfs/161 does the sprout tests, so after sprout
> this patch deletes the seed to verify.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

I'm opposed to changing tests that are currently passing to making them start 
failing if you don't have the fix.  This makes the tester go try to figure out 
wtf a test that was passing before is now suddenly failing.  Instead add a new 
test to test the new functionality, so it's clear to the tester that we're 
testing something new.  Thanks,

Josef
