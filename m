Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4960D145D26
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 21:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgAVUcV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 15:32:21 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39098 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVUcV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 15:32:21 -0500
Received: by mail-qt1-f194.google.com with SMTP id e5so668099qtm.6
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2020 12:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=PM9ADgWdLn8Cx2tCnTs/r6GFxjRxfFcdOsZKiOfzPdQ=;
        b=xuswSbEoogjQRyJaNT+5RhFWXwP0SDGU/plhWqAEbvXyzLOJLDhiod9nJK5ZMy+UCT
         6jp2lpSiVORXT4iu3S+D9Q32+jbrLWSnZjZx2FxXes14+X6vB2/3pQFl6bazVTAcvJQH
         DR0za6PnWRxucZknLapt136/h7bhXdjHXdreEM6EXdoRu+tC3C0Ygzni6JyKJoSyE9Yd
         AHdJcaV+T/ophby2Y3MEqo3gHw708qtiHMIRWc1NLEA0wjjJw4SRNmuRXdwF/jUpvoYJ
         pebrQZttr/7JuCQ1CveIH5Wb9Tuh1VkNHfBr0bvqD0vmpIIE4nvDmEjsTwXJPHz10dfE
         RBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PM9ADgWdLn8Cx2tCnTs/r6GFxjRxfFcdOsZKiOfzPdQ=;
        b=XCzl2880hxr4oNd4yOnPH8R1ACk4O+bxRYCo9tHcAd/G8fgQmTwtA7hmaiNvccls86
         bPu+j++5HLydkFx3QqQEtZuScw2o4P8z5zPNhcjsbyUw2WqC5NhLis6NNfObAV3BBP6w
         Xy+rY9nR6ipMUx1Iu2ZivEPwOOpjHMGj0lFkWVaqvMjI3v8Q3KyULnLLQX7/3GWS9Tfx
         eDxsb78GGGh8dUfR8IpNeSlg49506x5pZ16VoJXdY/PFUS8cgL96LVTYzwlTmzaA1FiB
         3EtybjOsSfV0FAtQMhzKR60mwZXx6/xsNWV5/jMW2fXQLrcsh3w8f8soyovprtOkuhdN
         FoJA==
X-Gm-Message-State: APjAAAVdiOgs4lj36AQPKprxJPmw6GdffRVis5CBjz/de1UnCYF+o0R0
        YfjdgqFyH0SwqlWkX6tKNvOMLS/HxjYyDw==
X-Google-Smtp-Source: APXvYqyrrxqHu7FGux0wTQZdgZzcCjt1LW+88w3qVWITIqSuwI6OujbrhiB+fGwukkAfy6cCtrv/pg==
X-Received: by 2002:ac8:67d8:: with SMTP id r24mr12705106qtp.128.1579725138270;
        Wed, 22 Jan 2020 12:32:18 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::7e55])
        by smtp.gmail.com with ESMTPSA id 124sm19180399qko.11.2020.01.22.12.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 12:32:17 -0800 (PST)
Subject: Re: [PATCH 2/2] Btrfs: don't iterate mod seq list when putting a tree
 mod seq
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200122122354.30132-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0e0ebc11-e0e1-c283-3e71-881ba78ed3bf@toxicpanda.com>
Date:   Wed, 22 Jan 2020 15:32:16 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200122122354.30132-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/22/20 7:23 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Each new element added to the mod seq list is always appended to the list,
> and each one gets a sequence number coming from a counter which gets
> incremented everytime a new element is added to the list (or a new node
> is added to the tree mod log rbtree). Therefore the element with the
> lowest sequence number is always the first element in the list.
> 
> So just remove the list iteration at btrfs_put_tree_mod_seq() that
> computes the minimum sequence number in the list and replace it with
> a check for the first element's sequence number.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

This looks like a prime place for list_first_entry_or_null, but I'm not married 
to it

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
