Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0518931CF94
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 18:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhBPRtz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 12:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhBPRtt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 12:49:49 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4BDC061756
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 09:49:09 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l12so14261409wry.2
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 09:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=hr0rdHMZmolBtvThpYX8F47EmZTO33KvwcYJC73JYiA=;
        b=VT9UNpWDYBNcyzhHxrk0sjTeU0VzXm9ZlI898KPk78IClZImpc7WFbtBa0GP08HETy
         Npr5cUXahf8I8gyrR/x5V7vAtghO5bNL/62WIUwBXwsQ8YAq5HgTf9RBMxSebAfJnJQL
         gVJ5czdaH41W1ulRdt9AkFzk+FfSSUyfFCVb4G7pRDN40i6AdrOGRNe3wkRKNMrUCHWI
         JaswBk0xv98nTJxDVJW08voPvLV7otDwestPUHQv2EE9Ajf85Hc7csqtsy1AeNWJPweC
         4XZdRmHwoN882AOmGdvvkny8Fajm1qeOtocI3cxWB7xI+5KwWMhw9s2a7f26AsEV2ou+
         s7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=hr0rdHMZmolBtvThpYX8F47EmZTO33KvwcYJC73JYiA=;
        b=k33C7R9b25g8dxLg7FaHitudX59lqiQwsN+dJot1C1ATIcME6hTjwqJ7n3p8V9Ddoq
         DqvUep/+xAnUarfiKrcXJ4wzp8zMCVJZBOFDfDIlbzubHw+/PO+MmXBDPmrn2CQ3X/ep
         asiJp3n0fodP99h/zMH2VRRllzQliCvtqXj0kuY1EAZQzbBi4KPxNEnGNynQDzg7aZPZ
         15JnCUmxXUR7Pkw0cHRq5dkjGGk5Rff6v5OS3SfWHs2vojWscQJMNTlkN5YdzaRWrmpi
         leLT7Ue7fgnLBqgG66StYOvzkBEA68Dx6YyYgJh/QEdg6jCevwTIRl2ZwgAntQhRzJt+
         5WMg==
X-Gm-Message-State: AOAM5307AbP4go2H6+M+BP2GbUW5TgTaOHrVVArtfYOcKDmQAy+oKzJ3
        VhVr5pYXbpC6U/JHUelcRhpGBHqYxgvxbg==
X-Google-Smtp-Source: ABdhPJx+c6+XU6ZsE3+FFpIh3r7P0iCDs/wXFTR//iBGY/vfNdkKy+BWmfO2bppZ58LlmjTIfAd0FA==
X-Received: by 2002:a05:6000:1543:: with SMTP id 3mr25060627wry.254.1613497747709;
        Tue, 16 Feb 2021 09:49:07 -0800 (PST)
Received: from localhost ([141.0.156.136])
        by smtp.gmail.com with ESMTPSA id y6sm4840120wma.10.2021.02.16.09.49.07
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 09:49:07 -0800 (PST)
Date:   Tue, 16 Feb 2021 17:49:06 +0000
From:   Leonidas Spyropoulos <artafinde@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: performance recommendations
Message-ID: <20210216174906.iv5ylu3p7jn347kb@tiamat>
Mail-Followup-To: Leonidas Spyropoulos <artafinde@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAFTxqD_-OiGjA3EEycKwKGteYPmA6OjPhMxce8f1w8Ly=wd2pg@mail.gmail.com>
 <e70bbe98-f6dc-9eaa-8506-cd356a1c2ed8@suse.com>
 <CAFTxqD9E2egJ22MorzXPAHaNDKg5QoEBK=Cd4ChOdT6Odiy6Rg@mail.gmail.com>
 <aeed56c3-e641-46a1-5692-04c6ae75d212@gmail.com>
 <CAFTxqD-SpnKBRY9Ri9xWFfNgWuHYVggYwCPdyXgF6ipUAzxNTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFTxqD-SpnKBRY9Ri9xWFfNgWuHYVggYwCPdyXgF6ipUAzxNTg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Laszlo,

On 16/02/21, Pal, Laszlo wrote:
> Hi,
> 
> Thank you. So, I've installed a new centos7 with the same
> configuration, old kernel and using btrfs. Then, upgraded the kernel
> to 5.11 and all went well, so I thought let's do it on the prod server
> 
Since this is a VM can you clone the disk / partition and attach it to
another VM which running a newer kernel and btrfs progs?

This way you can try debugging it without affecting prod server.

> Unfortunately when I boot on 5.11 sysroot mount times out and I have
> something like this in log
> 
> btrfs open ctree failed
So before that `dmesg` doesn't have any relevant logs?
> 
> Any quick fix for this? I'm able to mount btrfs volume using a rescuCD
> but I have the same issues, like rm a big file takes 10 minutes....

If you manage to mount the disk in a newer kernel and btrfs progs try
creating a new file system to take advantage of the new feature (on
creation) - then migrate the data and follow the recommendations
mentioned already.

Cheers,

-- 
Leonidas Spyropoulos

A: Because it messes up the order in which people normally read text.
Q: Why is it such a bad thing?
A: Top-posting.
Q: What is the most annoying thing on usenet and in e-mail?

