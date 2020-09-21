Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD04272930
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 16:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgIUOyw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 10:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgIUOyw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 10:54:52 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4B2C061755
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 07:54:52 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id r8so12517197qtp.13
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 07:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GctM6SRsrDVW4uiUx9lkOFwztwqdMhw4uL0NYvEHfE8=;
        b=C01MwSUCv5eaO9r3RezWx5+E18i3Tpjzkzuzu9sga65YE5g3BMSxzB+E8S1XUx997a
         Ye/U3gsdornVUUHXhYaYR/xTUZZBcGFgNOjSzwUCHJ3xS4M1BPzMfOEBclglzugJGvVX
         g3XrF+XP8gKD65ePk96AaPdsMF/+PTYhQV8AaoB/gQBHeTNRMFvDDoJsBGLiAhvX5LJ6
         CTfth4rQStvy27uw+umslQ9yv8W3sN/OpGSeJMz0B/fD18CD3L0PuQfRPBTGvXuk2I1g
         vyqtJCM0aG9AnXemWkYyQOHPzWaZtMw1BycC5t9E8WPXpVmYGAIJvjiBVRTQ5cCkW/W5
         LMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GctM6SRsrDVW4uiUx9lkOFwztwqdMhw4uL0NYvEHfE8=;
        b=DqAx7J8PiLqKStqdt85VrMagwKQC9dMrVdcyKgfl78yyq59glVKMC/4b8jv67X/Tzf
         IxGKeiUQ0fyZLxQsYhgFKFkN43xATJ85+B9YhvM4t+9shx5LnegfawMRKakzmaQ6yKk9
         ppEwLHlhAstYAfUFuAA8naTylKEI2uva/EP8aSRO0+O1Q3xsX8jqpgUie+v6Kj9TuRXe
         AI19da3kG4c1c9qCTDDTIy+IFUeqX4ABw3q9CN+whGeHj6PEw7nQf8DFAJE22THtCT4s
         6NfnfbmGynUEsSFGt28mBEnHTRzxXHsv80I3aZX/p9POWH6/y2Qd28jsQ/ckXklXrQby
         CT5Q==
X-Gm-Message-State: AOAM530+R7NwN4a/qoJ9ZDLfpozV0IpFOEPOOyXJJN+JkwidXSD/Bn3i
        fWY8xT3nmryW+BZqmNNVeNcVyA==
X-Google-Smtp-Source: ABdhPJznbB5QOFng3IObHGskJNpWrodt3GaenV4XgSSDXAj8mfBYcRevn10i2jGrNrUhf4t4T4Hbnw==
X-Received: by 2002:ac8:7414:: with SMTP id p20mr46363899qtq.128.1600700091416;
        Mon, 21 Sep 2020 07:54:51 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t10sm9085725qkt.55.2020.09.21.07.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 07:54:50 -0700 (PDT)
Subject: Re: [PATCH 4/4] btrfs: skip space_cache v1 setup when not using it
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1600282812.git.boris@bur.io>
 <2e63f1a18438150a8d4029c6b77ec8a661b6a3f6.1600282812.git.boris@bur.io>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <afe3c437-c41e-29ab-c0b9-e48188bb13c2@toxicpanda.com>
Date:   Mon, 21 Sep 2020 10:54:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <2e63f1a18438150a8d4029c6b77ec8a661b6a3f6.1600282812.git.boris@bur.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/17/20 2:13 PM, Boris Burkov wrote:
> If we are not using space cache v1, we should not create the free space
> object or free space inodes. This comes up when we delete the existing
> free space objects/inodes when migrating to v2, only to see them get
> recreated for every dirtied block group.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,


Josef
