Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD61C1FC24C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 01:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgFPXbM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 19:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgFPXbL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 19:31:11 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CC7C061573
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 16:31:11 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q8so339744qkm.12
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 16:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5621WnD/MB4xqMMPPpabksRjTPhmVPj5Tx/AAWjU6ok=;
        b=PE2tqX31htRbkQucNDh5s7OSUK8OitJB3cjS82yk7RZwLAttImpPc0tUz4COij1EM/
         3RW11LN8+8ItV6ylAtIHXcq3E+uUTUqhIIKHh+ORygrMZnw62Gosnv9x3pKkBU5lBXzy
         XAyP9Ay1xanPOSu5S2CD8skOzFAHpNCbiZs4eVq2V6aMzntEM/gmMjXZXb31mksldIV3
         WbkZVpP6FopUAF6FU6DuVpeQxMUZrJGvntWSISvbhCv1X1Gdb1qBPJg6SPad+OfRgRJZ
         QcY3e2IxzdH3dQ70iahSnu1JLNMtvQzCO1wyVI/LaORbGRvq/aK7LtEV+o8zSC/RY6ZD
         Lb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5621WnD/MB4xqMMPPpabksRjTPhmVPj5Tx/AAWjU6ok=;
        b=IZrxnCJ1hqF2wAVJ9H0a/vMWD/HkaNElr/MNOLXHKe5PCs6ZWZ4q/q8ZuISW4dxIAt
         vXIFllUcnEUgfYG/DsJeoUdCkQlWZCWVgM551gy/nuLsoHk3i/maxFyj/LitHkk9wKjq
         uA9rvBkTpOCZy4VZ1hJAN12YIpa3b67LmywlkR2x4IM6o17R1gZczkINHGwDBo9n9epf
         la2oV7vZG/1TyMZF+tRDB1dFSCJtkNmfj7sUpGOv+nfuUQFdaYpPsDDj02FrXljUixCd
         mw+jSmvDZtfrQFB4lXcRpS5AHEnChERfRjdkKWqrEsmt6kGfXXjGDVkhqA4MEhV5JtWU
         oBOg==
X-Gm-Message-State: AOAM532UfBSp4l9dcSUXLtElnYY727Xr80kjc5QIjUXoZkxq9bJqJRpA
        PBDIjy+ZumZYh++k1vL1C0UdvAlumDNZRQ==
X-Google-Smtp-Source: ABdhPJy00cstSrHO1Rnok1Q+ImIptVTZ1vbdUtMkoq0rubyRbcGVqIb3jtAdPF0flBp6xIJTnwnPMw==
X-Received: by 2002:a37:448:: with SMTP id 69mr4355327qke.362.1592350269367;
        Tue, 16 Jun 2020 16:31:09 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e8::123e? ([2620:10d:c091:480::1:458f])
        by smtp.gmail.com with ESMTPSA id x4sm17090096qtj.43.2020.06.16.16.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 16:31:08 -0700 (PDT)
Subject: Re: [PATCH 4/4] btrfs: free anon_dev earlier to prevent exhausting
 anonymous block device pool
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Greed Rong <greedrong@gmail.com>
References: <20200616021737.44617-1-wqu@suse.com>
 <20200616021737.44617-5-wqu@suse.com>
 <605ee3c8-0afa-5c00-9c66-fa385c20ce99@toxicpanda.com>
 <20200616224840.GI27795@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d1be2720-afa0-80a7-6472-6f7fe05feaf9@toxicpanda.com>
Date:   Tue, 16 Jun 2020 19:31:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616224840.GI27795@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/16/20 6:48 PM, David Sterba wrote:
> On Tue, Jun 16, 2020 at 03:23:03PM -0400, Josef Bacik wrote:
>>> By freeing it earlier we reclaim the anon_dev quicker, hopefully to
>>> reduce the chance of exhausting the pool.
>>
>> Why isn't this happening as part of the root teardown once all the references to
>> it are gone?  Thanks,
> 
> This is where it happens now and is correct. The problem is that deleted
> subvolumes keep the id allocated until they are cleaned up, ie. all the
> dead roots consume the id though we don't need it anymore. Creating and
> deleting snapshots at large will produce a long list of dead subvolumes.
> THis patch will return the ids at the earlies possible moment so they
> can get reused.
> 

Oh ok I misread, we're doing it earlier on purpose.  Alright that's fine, you 
can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
