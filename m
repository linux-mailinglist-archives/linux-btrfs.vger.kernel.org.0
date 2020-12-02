Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13B52CC78D
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 21:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbgLBUNg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 15:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbgLBUNf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 15:13:35 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEFFC0613CF
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 12:12:55 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id 4so1347281qvh.1
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 12:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tx/wZtYAkK3705oCKGNtRXoQqp3vTr5da/ZIN/jpYbY=;
        b=xIZru6eyjnFuXuFFsOlbwVtu1OueSJJcCMgrtUrmkQ2LadcYhLGICnhH+cpF2juBlh
         G74RTR46Ngfv1a39m4nFrfCdlYa5hMCDMX6oQxwbQlUPLQPk7oCMY7GTIK9dokGF5crZ
         9j8k+Hpt5mw/w3UrmaBViGo4ErObW8OD8z3outUZslmmbUhbK66GDTEiMnWDwsihI7HK
         4C5wTlDknyIiKSnJ4ZjTzlKjfFMvJObdhlbaormLz04J1UQAHFexCpMfN7Uyhx4/IDo0
         /L2iLBQ+w8Tx7U94B1wOIzeaP8l9m3/O65KJOfX7kposvh3rdqsbiGNPWObgXJzQWKnz
         quWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tx/wZtYAkK3705oCKGNtRXoQqp3vTr5da/ZIN/jpYbY=;
        b=Vhup9CLd/HowtOKQI9EWxhCHbQRbXP8xWfajlIq6itQjNfcw28vFdMD7ib+svnkda7
         TkQCBFy5MCXEClXh0cj1vTj1DbTYHjbTRbePgV5oUXQskssnJND4NFRgikoTfPmNYoSR
         0/9BJS/0b0jULeuNBPaWg1ASpCfO/th3ImqutDuhuaDEre9CtwU90qiMAUI/DZUepolz
         9f2f8DbIqqdtlIW+iYfFl79ZemYj3R18Rrs6DSF+bgoUvAmrt/U+1AMvvLhxaXH9cWMa
         0hB1iD24iV0vxIaM8+mF8xei5vopILSFVTqrcyOv7GtG53JDsJSdcmjGwHNP0sdpTvX/
         ZAzg==
X-Gm-Message-State: AOAM5307WMfYXKxOWnlYxbROZ81MLusba3RFsoKCo2MXoHIPuaoREDEl
        zWTlQrX0YPiHYcEIuMWsuNxL1V2TWZrqug==
X-Google-Smtp-Source: ABdhPJy1UUdFxo7+Yl6R/selhy+krN17nzI59sIqvbzZeCVBdovE94kMuWxah/JU6kS420osd452Cw==
X-Received: by 2002:ad4:42d2:: with SMTP id f18mr4412295qvr.23.1606939974525;
        Wed, 02 Dec 2020 12:12:54 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n21sm2948070qke.32.2020.12.02.12.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 12:12:53 -0800 (PST)
Subject: Re: [PATCH v4 0/3] btrfs-progs: Fix logical-resolve
To:     Marcos Paulo de Souza <marcos@mpdesouza.com>,
        linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com,
        dsterba@suse.com
References: <20201127193035.19171-1-marcos@mpdesouza.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <70b01d44-efa5-5de4-cbaa-5b31f84c289a@toxicpanda.com>
Date:   Wed, 2 Dec 2020 15:12:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201127193035.19171-1-marcos@mpdesouza.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/27/20 2:30 PM, Marcos Paulo de Souza wrote:
> From: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> In this forth iteration, only patch 0002 was changed. Previously the variable
> full_path, which is passed by the user, was being overwritten in the inode loop.
> Now we create a temp var to store the mount_point when the lookup is needed.
> 
> Please review.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
