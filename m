Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026CF212459
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgGBNOJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbgGBNOJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 09:14:09 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F350FC08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 06:14:08 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b4so25494908qkn.11
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 06:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HkJSVaUv5n/5GD5Lh50cjmXq78Z9n+EsFABjj76A9dQ=;
        b=LV4ia8XOWvGeDzGP2yrfCNfDnW7AdNyj6EdaWpfcuPD/KoGwHu+vKVdWoG5C8snJjF
         4a5yt/9sWV1YWlKaOKETTAubtClIoGajqS8coDMkH3w7O9Zq2dLb/DHwRrANSiXQlnTG
         W790Qe8qR2XJUOg6/3g1ZmfnlZlWdZpMvz7e2NLKaJ5ZtFXfuZL4iMr/InPUPaahIGff
         E6/6mcgcOzzk9QhPjdGxegnX+rXUnf1DNSWM+ATuTfVYaIqkmyc3II5luLwQiaT6X7F1
         PJ8uaLE5g+47vX1tJZ1zOfLqtWMhUV6/wddgPzvXmKMCycG9CFWWVAdM+ZM4vkO0WuR7
         jsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HkJSVaUv5n/5GD5Lh50cjmXq78Z9n+EsFABjj76A9dQ=;
        b=qZjfeikegah4IvBrDmFPChAeBB1ezUK43y7GY+6PGS5NQkhfGrGHRcMVC0vns22+W+
         EKq2KfHFXJOkcVD34hUdRfwiGwRYF/GnYp65S1+73xhGqtevN0/eZjUsIrGE0263HB2s
         AJDqarLxutB6dGROn3o5k5VgCsgZasnHiWKPHr0oPXxApVydCkppxfsueqM4uOfSVvAt
         2pLDe0Zn2h9cT31OrTaJJtRQi6Tt3PvNlBXD8EUIXdlDMHBIn80nyHGmhCKN64LzTb03
         Sfvt8zM0Jr2p1+jx9WmyjCSLWBLoozvpUre5xOt8DHZvoLCxiIhgArzsIQp9Oz4ouA4k
         QqJg==
X-Gm-Message-State: AOAM532htmNkYRnYIqaRvnrnNerXRzuiQDdzgdyD5iFW89jsx62tLbDd
        6TPEQR3SqyjlqXt8LQKCyPeOH/Gx6fo92A==
X-Google-Smtp-Source: ABdhPJxSriM3WTXnceGXE2o2yzIstHRt2E6vUiKz/bmJro0MDsI9JMnVDUhx4NerI/pd5MsowGwWhw==
X-Received: by 2002:a37:a886:: with SMTP id r128mr28751207qke.54.1593695647844;
        Thu, 02 Jul 2020 06:14:07 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k197sm8484340qke.133.2020.07.02.06.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 06:14:07 -0700 (PDT)
Subject: Re: [PATCH 3/8] btrfs: Record btrfs_device directly btrfs_io_bio
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200702122335.9117-1-nborisov@suse.com>
 <20200702122335.9117-4-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <03c8207e-dd21-4792-10aa-772f44969dee@toxicpanda.com>
Date:   Thu, 2 Jul 2020 09:14:06 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702122335.9117-4-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/2/20 8:23 AM, Nikolay Borisov wrote:
> Instead of recording stripe_index and using that to access correct
> btrfs_device from btrfs_bio::stripes record the btrfs_device in
> btrfs_io_bio. This will enable endio handlers to increment device
> error counters on checksum errors.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
