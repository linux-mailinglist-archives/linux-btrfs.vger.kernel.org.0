Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD55294EEB
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 16:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442155AbgJUOmS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 10:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442125AbgJUOmR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 10:42:17 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F84C0613CE
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 07:42:17 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q199so2171789qke.10
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 07:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vet732dJay8KUP6DNbAx8jarhEuRz6UfnIR3pNiwSxo=;
        b=eATMDOpMDw10gEqpa2B1BqZITN339OJDD2EYj0fhIyS5NfYQobZZOgHzD/E5zlYkRj
         gcLLSLIX9j4QyTzUg4dsWSnEGS+XE71y39dkd7TtKwPSrnrq97w3FT8XbTdpeI6JTqJa
         JQImFhqbcGarFqlz7h/C9E7efMhYh35PMLLyPOcX86+uR59G42217L9fEKu4PjWEoWhw
         s/hWQQZKppaSiZHcSw2Ona/v50wz8C8VOoYDRwM434ArEC+bFAm6/yhNMQa44FKagbsI
         lkYBNQoj1PoIcFCqIwy7UaGOVAgvGocjnfT0xmSkEm7KuWeSCzflq5GH3cDeJOfzNHgg
         7gVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vet732dJay8KUP6DNbAx8jarhEuRz6UfnIR3pNiwSxo=;
        b=UVGv42YhOjEvp+/TzS5WNXL6BNYNFPwGBpQgK6jVcCuz3qhbF8Funm8t91oanw/ko5
         c/ysEqFeaIQ978RICENXrmVCIpukn4gho+2fpRKztidGqyXgDE9yysOq50hVRqRKubb6
         VkNbSQEdHWtuMO6zXpzNIXbnMNkYV047Xv0cnLZVfAl+omINZJn0EtpTtEs9a694BRR7
         1cI/A3j/iFcSv9u6XdZurjEjiv53QSFdczAvdYSe6hCvIUsB4dIt/4eQyWwDzyYRfOJY
         fDNtgtSHUZYtd6BQgixPYmowUw0PW6bzEl+7ADC3Xb+0QJvlU8lSe2p9TNttFEvTd+SD
         gKSg==
X-Gm-Message-State: AOAM533ADVwd4chkR3gh+HvGEz8Qxp+pZ3Oj4L0ozLYKtvj1EJK2q67m
        MJe2iTL8Rph17M5NsP4cSj1BQw==
X-Google-Smtp-Source: ABdhPJwkFcdQ4tx8mjwe8d/w1WyqAzpwTldb9T7P2BRhW9aFnAzP7LgqSJB2JBZ21qA8ilqQddzaTQ==
X-Received: by 2002:a37:64c6:: with SMTP id y189mr3324428qkb.148.1603291336450;
        Wed, 21 Oct 2020 07:42:16 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p17sm1286215qtq.79.2020.10.21.07.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 07:42:15 -0700 (PDT)
Subject: Re: [PATCH v8 3/3] btrfs: create read policy sysfs attribute, pid
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1602756068.git.anand.jain@oracle.com>
 <806bf3aaa5cb0243dd2cea6bb79e5ac9ae347111.1602756068.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <78f8abc7-d7de-77be-6e4a-81beb683fced@toxicpanda.com>
Date:   Wed, 21 Oct 2020 10:42:15 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <806bf3aaa5cb0243dd2cea6bb79e5ac9ae347111.1602756068.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/20/20 10:02 AM, Anand Jain wrote:
> Add
> 
>   /sys/fs/btrfs/UUID/read_policy
> 
> attribute so that the read policy for the raid1, raid1c34 and raid10 can
> be tuned.
> 
> When this attribute is read, it shall show all available policies, with
> active policy being with in [ ]. The read_policy attribute can be written
> using one of the items listed in there.
> 
> For example:
>    $cat /sys/fs/btrfs/UUID/read_policy
>    [pid]
>    $echo pid > /sys/fs/btrfs/UUID/read_policy
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> rebase on latest misc-next
> v5:
>    Title rename: old: btrfs: sysfs, add read_policy attribute
>    Uses the btrfs_strmatch() helper (BTRFS_READ_POLICY_NAME_MAX dropped).
>    Use the table for the policy names.
>    Rename len to ret.
>    Use a simple logic to prefix space in btrfs_read_policy_show()
>    Reviewed-by: Josef Bacik <josef@toxicpanda.com> dropped.
> 
> v4:-
> v3: rename [by_pid] to [pid]
> v2: v2: check input len before strip and kstrdup
> 
>   fs/btrfs/sysfs.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index eb0b2bfcce67..07a1a57b2df2 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -886,6 +886,54 @@ static int btrfs_strmatch(const char *given, const char *golden)
>   	return -EINVAL;
>   }
>   
> +static const char* const btrfs_read_policy_name[] = { "pid" };

This fails checkpatch.pl, it should be

static const char * const.  Thanks,

Josef
