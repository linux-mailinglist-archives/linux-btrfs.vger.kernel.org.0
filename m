Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF739221EA0
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jul 2020 10:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgGPIlV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jul 2020 04:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPIlU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jul 2020 04:41:20 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5993C061755
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jul 2020 01:41:19 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id rk21so5713536ejb.2
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jul 2020 01:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ePof5wCzuT/mMHtRgUDVM1EIUctWdkAXKM6Kz2g0iK0=;
        b=K87a2W3M1tKldsF/dcPQZVPxvrrBTMLgnpMnwDbT8sQm6pX70EhwpbfmXf7SFXq4NB
         Sh8CRS6/unuz9krNhTtqR9t9K6PhkcN6U1IlTTCCu7Jii5M4catQhAaVYm3sbbGJ3Xen
         SnCBJmoS73Uo1Ok8Y8MpNOJQFRqMOFjEQcPl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ePof5wCzuT/mMHtRgUDVM1EIUctWdkAXKM6Kz2g0iK0=;
        b=bQ0YzZQq08MuHS3hyxpsuQ9+Y0Dsx6HJx5P2nCaDhNvo7gv/8rPCN/oJM1Cug0vlWP
         BH8fYHU44a42JquE3ETMk6/VHffH/iiXFcAU69wuA8rPXZCpfJaynsIlSICqEtYqCDTl
         HEK/KX2rvkspTyaWEiP5QxfP3xtyreuiieQ/AFvqPKAe15nsyijosJ7Wc59myDvPnLUe
         /kuV8kqiELBrercHdFTMpQOis4HGIBGfvqKwmZTncxCFS1a5MaQaelwxBjtwyCyjlqR/
         EySX6sjaR5wMihvoXl6z4TpSxQYxqiQC/SFxf/vxF6oqrwrHglO/vj8ceGE6Eax9FziJ
         B1AA==
X-Gm-Message-State: AOAM532GPsJYDi8RZPUincUXIC4uouxbxM1fde+0sNNH0JTluaZCjT8T
        uQ/EDFe1v1yM+w8KQ6+j2LQISpW0UlbAPA==
X-Google-Smtp-Source: ABdhPJyKGM3tTyGDH10ixkWvGSjmxZo18x2ghnb9nUjKkUChbuDEeI7bqfjBC/MHX8AnyUUCPVcDrw==
X-Received: by 2002:a17:906:7694:: with SMTP id o20mr2646459ejm.289.1594888878419;
        Thu, 16 Jul 2020 01:41:18 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:a5b1])
        by smtp.gmail.com with ESMTPSA id d12sm4728934edx.80.2020.07.16.01.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:41:18 -0700 (PDT)
Date:   Thu, 16 Jul 2020 09:41:17 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] btrfs: qgroup: add sysfs interface for debug
Message-ID: <20200716084117.GD2140@chrisdown.name>
References: <20200715134931.GA2140@chrisdown.name>
 <e973ae45-c746-95b7-d176-180d47ecb2e2@gmx.com>
 <e6cc556e-c830-fa28-486f-e23d520fe98e@gmx.com>
 <20200716004031.GC2140@chrisdown.name>
 <ecb9e5b9-5026-ff4b-75e2-41b156c431b2@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecb9e5b9-5026-ff4b-75e2-41b156c431b2@gmx.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo writes:
>
>
>On 2020/7/16 上午8:40, Chris Down wrote:
>> Qu Wenruo writes:
>>> Would you please provide the full call trace (especially the address
>>> causing the NULL pointer deref) and the reproducer (if possible)?
>>
>> I'll try to reproduce it again when I have time. I didn't have kdump
>> set, and am not currently running linux-next, so until then, you can
>> have this crappy photo that I rushed to take earlier before panic=30
>> took effect :-)
>
>The linux-next is using an older version of that patch, which has a bad
>memory allocation inside atomic critical section.
>
>If you're unlucky enough, it could cause various weird bugs.
>Thankfully, David has exposed it and the latest version in btrfs tree
>should have it fixed.

Great, thanks! When I run my tests again on linux-next I'll be sure to reapply 
the latest version of your patch first, then.

Thanks,

Chris
