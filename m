Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E94451581
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Nov 2021 21:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347170AbhKOUj5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Nov 2021 15:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347480AbhKOTj7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Nov 2021 14:39:59 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14FFC06120B
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Nov 2021 11:33:15 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id g28so13619200qkk.9
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Nov 2021 11:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GMcmCPPNkqZXuEK/w8V9ah5eSf6E1mq8BDWrVP/doXU=;
        b=vQHvYM/HwFOME5YzsvaBFRKnZNLrr0JWRzo1y1VGk+o6rvRw+2uB6bVK94ns1hq2Rb
         846cdeO3oDrUUCRDhW6R3cucon0l4REmuEgyr6R9IR5Rw7NtwdMnhSh43kuDcqCza6YK
         QZTBtmdZaCJqv2ClhDqAX43QL3dBLGrdXNLeUnknVEW3IOymkghIQE6Nw3ly+YJ0GLzI
         EjvYFQ8BJkWUlH0N0v0Zy09ZuMqTEoiOT1pl4ATbl0Gkh3EKPoO0Oc7nwc00GRrNbA0x
         vR9lFYG3Ur1vU9uMXKw2pS/a970+SslJ8t7/aT3bURy6/ppLYsp49cQllnxFj/zPHmo4
         RaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GMcmCPPNkqZXuEK/w8V9ah5eSf6E1mq8BDWrVP/doXU=;
        b=A67g/NtWRhOWHoivnmGazbyApDVEmjH8jJu8ndlcktN1gmwejCns7m5TLNxw/YJwOA
         dUhmxXfIUTcdecq06suq/DX7UWpU3ysRhqNLqeAtN8AZbT1kKqZbFZhCrS4qKqR7rFys
         ce46RPY1LSqs70JA6qVKjErVWH5w01DgxzZF5Llqo2Glv4omYDTV0unseru0KJ6eG6lv
         a0dWfT0rhhrglZ3pBtIxQNAkIebaFwLPbm4HK6TautfTgfwTlCbSQhm/jg6mV99IbuJ4
         XddXTbYcm1r18xD85ozODVOCE9C2jgCku2IbyXVwyQIZl6VGZTWRqZYyCEjDHv3XckCh
         EjAw==
X-Gm-Message-State: AOAM53334W3f+qGz4/e5W/7SRmeQXoEG+o4o3ppY86ZrAwKOndO1y+z2
        6HUd1+eDsJPGRghGtB2HUx4A8Q==
X-Google-Smtp-Source: ABdhPJzyDUv1Dd4go1GgdAkSGeaMiOEHT0h/DtxXE5N/yA6e3BN4juWzgkDp9kWIliViAxunK+ti/A==
X-Received: by 2002:a05:620a:1350:: with SMTP id c16mr1273828qkl.229.1637004795016;
        Mon, 15 Nov 2021 11:33:15 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f10sm7616607qkp.135.2021.11.15.11.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 11:33:14 -0800 (PST)
Date:   Mon, 15 Nov 2021 14:33:08 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Stefan Roesch <shr@fb.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v4] btrfs: Add new test for setting the chunk size.
Message-ID: <YZK19Gz87ymUw9mr@localhost.localdomain>
References: <20211102212329.3708782-1-shr@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102212329.3708782-1-shr@fb.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 02, 2021 at 02:23:29PM -0700, Stefan Roesch wrote:
> Summary:
> 
> Add new testcase for testing the new btrfs sysfs knob to change the
> chunk size. The new knob uses /sys/fs/btrfs/<UUID>/allocation/<block
> type>/chunk_size.
> 
> The test case implements three different cases:
> - Test allocation with the default chunk size
> - Test allocation after increasing the chunk size
> - Test allocation when the free space is smaller than the chunk size.
> 
> Note: this test needs to force the allocation of space. It uses the
> /sys/fs/btrfs/<UUID>/allocation/<block type>/force_chunk_alloc knob.
> 
> Testing:
> The test has been run with volumes of different sizes.
> 
> Signed-off-by: Stefan Roesch <shr@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
