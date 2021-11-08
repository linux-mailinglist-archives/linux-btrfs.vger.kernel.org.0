Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0F7449749
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 15:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240665AbhKHPAt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 10:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240661AbhKHPAt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 10:00:49 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F52C061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 06:58:04 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id t34so5202278qtc.7
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 06:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1iTH52PoatbH36j10aSxNhRbDGtUV+w28nMQhKGaWig=;
        b=8HFpi1nc2+ksLfAfFQKMBf5GrCa+JLk0GZ7D+W9sfORrHg1syqWjBWEcJSXkTXWUAq
         ZyLxktIUxjQ52du8ASdR5Hplz2wZgAHTa06svOFca+k3xKcNUMdEE+GVs7J+4xyh93Md
         GqbvA9Lg20fBJtRNBmh3gz+vmg5PzZvwuNCRjobvn8d53Uk3c5X5dbOhe7zUA2cg8Cu+
         05RU4+axJJFe2oIGMIhbQxX1HcED5ktGUjn3YHgGIcqeL7Dhi4lZX08UZ4z1EjbRjsin
         qurdhB/Z5OC43xxI9lGRlWfN6ANYwUZH8ShApiG58l2XN1u/SFblOBqxgcNtv2o7CuP/
         84Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1iTH52PoatbH36j10aSxNhRbDGtUV+w28nMQhKGaWig=;
        b=MtWA4dW6Trgve/czGPEc3Y5GYJ71Uq9ZYSCSWjsu7kAYi/162DRnG/EJcD4p/25n/i
         2vCNdooPWQRKvqFWzcNaMk1jnJMgSHnXgwuj0skpbJV4fNaOcYb4SrDKWjsZy67OLbQF
         sAHIktcO7ovApzZN6a1+Gw4BaTcy5PT1OJr1HiJVaJjWRmVvEouMUyhffeQHQ92wPn96
         Nq3FP6Z8qNm7DHiRpe9EgG1LrNpfmG9Pcb0GTcJBnQUyO0m+irX7vUln4hwGtI6n2/Lk
         FrVMQNYRckfZzxulrfiFsNpgFMN6JGAe4QnSl/UQYP9cWqrEnndTEuNUZ79BK0q7Sfqf
         ylcg==
X-Gm-Message-State: AOAM531uV6bGb2YjDzGWuoIW4zpeYzP1Eyl8yvhYH4sfx+cuUnNldtGC
        I89uTPVR3Vn8n3zL2G7B1vwMigbiDBcikA==
X-Google-Smtp-Source: ABdhPJwZR+vdd6UvrHU9GP10/FNY7kfSwJZ1J6Oy3bmFLq181BEJujzv4v3S1j5pp8Weozl0r9GozQ==
X-Received: by 2002:ac8:1e95:: with SMTP id c21mr59059qtm.412.1636383483989;
        Mon, 08 Nov 2021 06:58:03 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g13sm10223998qko.103.2021.11.08.06.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 06:58:03 -0800 (PST)
Date:   Mon, 8 Nov 2021 09:58:02 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] btrfs: allow device add if balance is paused
Message-ID: <YYk6+u3VyWwENFTI@localhost.localdomain>
References: <20211108142820.1003187-1-nborisov@suse.com>
 <20211108142820.1003187-4-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108142820.1003187-4-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 08, 2021 at 04:28:20PM +0200, Nikolay Borisov wrote:
> Currently paused balance precludes adding a device since they are both
> considered exclusive ops and we can have at most 1 running at a time.
> This is problematic in case a filesystem encounters an ENOSPC situation
> while balance is running, in this case the only thing the user can do
> is mount the fs with "skip_balance" which pauses balance and delete some
> data to free up space for balance. However, it should be possible to add
> a new device when balance is paused.
> 
> Fix this by allowing device add to proceed when balance is paused.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
