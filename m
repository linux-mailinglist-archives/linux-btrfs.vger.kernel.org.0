Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BA61B547D
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Apr 2020 07:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgDWF6D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Apr 2020 01:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbgDWF6C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Apr 2020 01:58:02 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A995C03C1AB
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 22:58:02 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y4so4918041ljn.7
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 22:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7CbXBzhofKvOV0rxlp9vvH0c+xAID6u4EaPorNjHEso=;
        b=hEh1/2UaI0RHvaYGnLwH03Ng3wQuTN/DruIYAbHl5ulLjttfdpxRlvpoLKDSjYLRAU
         CED4fL7Q3M/O3gQrqxxuzCneuLeF2sXdRFpk0ezYd/g355pxA0HwR46ykTs7/b3VmNn4
         dorPIoyLUVKGrVv5vGBCxhmpYZjgyLBVTcpHfjFLtqskET0C9PtL71UD5TqsPCKlFx4E
         DHMpF0/F5mzsGN6FRYAUSWThajMz5qiS/RWJVfyB/DS1YNX1JMpN92nMJH6SfwlPN+CT
         1DqEaDSw69IXWu3oI/4OW7yWMT5oJBHGNNAw87oFKaWm3J/27KE+3n6zWkDmVI63IfW8
         5tHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7CbXBzhofKvOV0rxlp9vvH0c+xAID6u4EaPorNjHEso=;
        b=DXXwD4mbtOLmb4swVyoZX/kpmIwTsQuBdedZOHI0tUvVjbkD4OAwVoqbL+BUhBFj31
         u5C8GEaxwp3tX1RBCgz5cQLOsi8LWuP5AR5oAGqW+JzOulCCmo4My4TeyGIOmEXebkGk
         nn1hmK20bql6jmrdB/I2/K2gTWXUlv0ttksRfx74QN9jVEpC0mwHv1SIaKhxl/WfBruz
         8zAUdTizOOGwtpwWo7tM/O3FF8L3BV0wDOWhw3IczfiBZlihuxjU79Qx0Z0tP4+q9HwD
         6lShQxKEY/lfuLv329weE9cNa0kkQFYJpoo2BHP66XX1zKNK7G4x2d7KBbppbmqXYlls
         eBOg==
X-Gm-Message-State: AGi0PuaPTGjlxZscwt1GRd5hxVwwHm54jR/1FvU5Im/0Ra1sledfPbjB
        uN3TeNE28bIV0+sDgGRi2j1HCQfg
X-Google-Smtp-Source: APiQypLB6aPDgNzdYOwcNs0yXThlt72XVsHCeKgBkiXus1s1L8LRyu7zukynUoCtQBqb8UZgWIkQ6Q==
X-Received: by 2002:a05:651c:2002:: with SMTP id s2mr1214167ljo.285.1587621480476;
        Wed, 22 Apr 2020 22:58:00 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:48ee:3630:6817:757e:9dcf? ([2a00:1370:812d:48ee:3630:6817:757e:9dcf])
        by smtp.gmail.com with ESMTPSA id e186sm842207lfd.83.2020.04.22.22.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 22:57:59 -0700 (PDT)
Subject: Re: when does btrfs create sparse extents?
To:     Marek Behun <marek.behun@nic.cz>, linux-btrfs@vger.kernel.org
References: <20200422205209.0e2efd53@nic.cz>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <9f96fe0c-cbe5-12c8-67f5-2981c9273c5d@gmail.com>
Date:   Thu, 23 Apr 2020 08:57:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422205209.0e2efd53@nic.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

22.04.2020 21:52, Marek Behun пишет:
> Hello,
> 
> there was a bug fixed recently in U-Boot's btrfs driver - the driver
> failed to read files with sparse extents. This causes that sometimes
> device failes to boot Linux, since the kernel fails to load from
> storage.
> 

Do you mean that kernel image (vmlinuz?) had holes? Or there were some
other files that caused U-Boot to fail?

> So when does kernel's btrfs driver write sparse extents? Is it always
> when it finds a PAGE_SIZEd and aligned all-zeros block? Or is it more
> complicated?
> 
> Thanks.
> 
> Marek
> 

