Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138E025B446
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 21:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgIBTJP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 15:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgIBTJO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 15:09:14 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409D1C061244
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Sep 2020 12:09:14 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g72so746880qke.8
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Sep 2020 12:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j01QTzC7yFOHkCs7bnWh/R8FBxwv9rfWU9RJq3vpOQ4=;
        b=U1wwko5Z0MKY8eoh5pzI0RKWDU3sy6xtjrgWeHstpP+MBjNdG5i7I3G/OtF4TaP61E
         Dg7Yv3XWTLf08/9xMsttGTz6/gCgiv73eeEw9Xzd/mThqjXawaFu0hgd6hBS7Lck+KDm
         KYTPG7d78B/Lua5MiH2yL9EcjvkpTyn4+WAh/d6RPpRGeDnNiihsSghZ7qd+4Bcl0NJS
         ZvV8IKD/d8wOvTQ7tr5T53WR5C39rMbfBMaT0i6GplGWgHSWJsp0JxjkM0fsFG8WL9LK
         Z9ZYfojDKG3ds/b2GA1B0S2YyLgBm0URN9XPLqrn0CWf9uC6D7y6BTyUGQUyFIWRIszn
         evIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j01QTzC7yFOHkCs7bnWh/R8FBxwv9rfWU9RJq3vpOQ4=;
        b=WskGiN1pbUfZ22NlJ329jDwbJG/BJBu7e9bmj++QrLEw4uaPwIyyusb3jTUkjVuknZ
         mFA4QlDwkXVxzmSuLKi8dxyleUDivgl7NUHHtZ4is80d6OlFeM9uda8cewIjw+ka9BwV
         czmBXiYF1cL3L2NYMAyBFKwnPZUHlNVPVvuv2EaEVlvO8RhemYan1MlEemEVPJPSIWtE
         PIISSTViANikg36zyjvU7ptJlM0SNCnur2sSmMCb3YTaZ8sM8CTiNPrXlHgkRB9ov86P
         AY+/1XySxRl3Cyk9oN4b5Md08xdM9rWWBron/MXoig/DFHmlJN+PjW5dHeAXXKB6q/bd
         MlEw==
X-Gm-Message-State: AOAM531RgZpkzKBZqbtsuSzv7LO+M4NkMaO1mJhiTZg7s+rFC7dmmVzj
        C56r6ZtluT+J8w1oDv2VrGo5ADKEi3GZ3Is5y+k=
X-Google-Smtp-Source: ABdhPJzUnIBZYOEyAGY4IOnzvk3SclFwXzGP5gY3aCMUTFHKgKNzTuEri+S1r1qOK4+VLfp8AGfFDQ==
X-Received: by 2002:a37:a495:: with SMTP id n143mr8339912qke.394.1599073753198;
        Wed, 02 Sep 2020 12:09:13 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f7sm429490qkj.32.2020.09.02.12.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 12:09:12 -0700 (PDT)
Subject: Re: [PATCH] btrfs-progs: support free space tree in mkfs
To:     Boris Burkov <boris@bur.io>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <0366b5e12a7e6f95d9f274df52f32231dcbe8b05.1599072541.git.boris@bur.io>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <5943a6d8-fecd-c4f8-b07a-f24dbb3d6d36@toxicpanda.com>
Date:   Wed, 2 Sep 2020 15:09:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <0366b5e12a7e6f95d9f274df52f32231dcbe8b05.1599072541.git.boris@bur.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/2/20 2:50 PM, Boris Burkov wrote:
> Add a runtime feature (-R) flag for the free space tree. A filesystem
> that is mkfs'd with -R free-space-tree then mounted with no options has
> the same contents as one mkfs'd without the option, then mounted with
> '-o space_cache=v2'.
> 
> The only tricky thing is in exactly how to call the tree creation code.
> Using btrfs_create_free_space_tree as is did not quite work, because an
> extra reference to the eb (root->commit_root) is leaked, which mkfs
> complains about with a warning. I opted to follow how the uuid tree is
> created by adding it to the dirty roots list for cleanup by
> commit_tree_roots in commit_transaction. As a result,
> btrfs_create_free_space_tree no longer exactly matches the version in
> the kernel sources.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

For those of you playing along at home, this applies to the devel branch, not 
the main branch.  Built and made sure it did the right thing, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
