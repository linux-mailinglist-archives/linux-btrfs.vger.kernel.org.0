Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2F02A30A3
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 17:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgKBQ5y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 11:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbgKBQ5y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Nov 2020 11:57:54 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC27C0617A6
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Nov 2020 08:57:54 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id t5so1081916qtp.2
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Nov 2020 08:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XdkbBYk76P5xCeArjTYzsjZMzLTxaLPfvDpQ81WJTRE=;
        b=izksLapj2SCVymtfdwKAnNw9aYDVTHRXCeWcXWxDAtMwfvynpbDA6OvYGYtZZeWBYN
         vAvq6Ov5IxswQACsAmjsnyEbDyyC4W/EJ7KSmTRyqvBflA/cmWgSX6UpTBQxbIrRK6S4
         PXPMUX6xnSar/f/gfAJ/4viMx35P7iqlQYYie7Rr+vsbtaHeHGV5tnkh2qdmQpxworvI
         rE+b80EV/TxyzVQjEB2yl8B9voMB1Pd+UtkH1pbVvkiKwbLnNzh0GOGjs2TwQbcCk0qf
         +kT+LPFSq/VanSN4m49DYDT58WVmw0ls0EhnWYyW8V6dKj6SqbiTVOmeS5vCbgQ8n6G1
         kOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XdkbBYk76P5xCeArjTYzsjZMzLTxaLPfvDpQ81WJTRE=;
        b=XCn+9QDErFx0HHgwI+Y3KIzwgBts0+TT10wcC0AR8cfJlHZmHkHv1Iy+aevLTtwnZ4
         4vJcFunUKZ4TO+erG34GdLr4x+i6usFfNrNK3BsB0Mx/K+PEp0HeGPSvXU0Ti9eSyjWo
         VqrzRDN/hRnrSzykMXXKXGZYw8Einjczef6IARH4qANsj4Rt9EV0CAW+iAir4+io810n
         FuCrKxvPgJaWUhtM3zUjIxseGthVOPYA5sT2voGSuF5MJh+LuIOT6ejauhvWrGLThDzN
         SPaO8gKFG0ivNUdCIurAcNYSLrUw/AdAr1wUG5pf5ZkODzKSKy7O14UEJW6PgZ3eVEOv
         eklA==
X-Gm-Message-State: AOAM530z7hEqkEWI28jXEwK2tPDQe0bNyOYKrNwkBWogC336F+OZ/lAW
        fKWsiSu47a3CcA53SLvlph0DDaD7uws5QQ==
X-Google-Smtp-Source: ABdhPJz8/89JWhdJdHT8xj7BkwgaI0beWHxei2ZPfBZRZZdxv+U5CGcADATlEiCiZA9Ppf72Nh/f0Q==
X-Received: by 2002:ac8:5901:: with SMTP id 1mr15060096qty.173.1604336273288;
        Mon, 02 Nov 2020 08:57:53 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d9::116a? ([2620:10d:c091:480::1:f39e])
        by smtp.gmail.com with ESMTPSA id 29sm8514928qks.28.2020.11.02.08.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 08:57:51 -0800 (PST)
Subject: Re: [PATCH v9 06/41] btrfs: introduce max_zone_append_size
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <066af35477cd9dd3a096128df4aef3b583e93f52.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <58761e4e-c2f1-afc5-24cb-32445e8623e2@toxicpanda.com>
Date:   Mon, 2 Nov 2020 11:57:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <066af35477cd9dd3a096128df4aef3b583e93f52.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> The zone append write command has a maximum IO size restriction it
> accepts. This is because a zone append write command cannot be split, as
> we ask the device to place the data into a specific target zone and the
> device responds with the actual written location of the data.
> 
> Introduce max_zone_append_size to zone_info and fs_info to track the
> value, so we can limit all I/O to a zoned block device that we want to
> write using the zone append command to the device's limits.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
