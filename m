Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2DB298EBF
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Oct 2020 15:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780882AbgJZOBo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 10:01:44 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41232 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780024AbgJZOBo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 10:01:44 -0400
Received: by mail-qv1-f68.google.com with SMTP id t20so4274443qvv.8
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 07:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gh8/lEn92L2uRHjmD/+kgBM6vARa26QBPwD56nVoAN8=;
        b=2SxTrAZ98KQ2QExRAVtwuKtr267+oPj1QsgAC9B+fiM2Tevaya8Rp/4nqA9I6Bk41n
         BIChIx1rHqqrSYGtne/d1LFgu9eVI3QuLlY5NxmvThXE4dCFli+LPxd5/wLBQpNk77I+
         /bAAcVfRoKOfIyrc064qelU4ZucAm2HptHEfBGWLhp6fu6txbFVbA40GXJDq5JU2ZmlV
         exUj2CwFTOAC+t/viiSkpU8jkhnWUD45fo7rzT9dNuI+bfO0snQvIocxglebENET8AVi
         aV8vaejLWRim0kzmkgeKkvig8U6ZbH/HT6rlYBy/JEKYyOPEiBL9sMiK0922+ff3tgsP
         5Xcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gh8/lEn92L2uRHjmD/+kgBM6vARa26QBPwD56nVoAN8=;
        b=ttoTq9NJ7bGs7ZCSWftZ3to9Wev+okGbg4aq6VsNfZzTbpE4rsz3oKoCPrc0BVZRIl
         ktGi4RlrKTeSIbaU6judqWfkYqS/sqp3Lic8Zd3lc5LOg6oflomeSHVx7V4Ny8uZjoX5
         NhIg0BegAKXay/SFr49cutDk20j7h4BWarbjuB36XKre9X6uGrOuKzhbpK7Xd6PtkKcq
         uRuWqksulWL7kKBJrXUPwCQnlWVzXdrPayCot1HfBvK6HpqSpT1XEds00elszBiqDZSk
         2z+FdsmoWVEG2/InwFGMLazOu/rUo/FZOHFnimivVoKr4N+kG/NYo62hYgTuun6Bpx2J
         KwSQ==
X-Gm-Message-State: AOAM533UoiAH+V7amvswFDfoD6D9H4E5HUWc2sphRRb4mIyDEXglgCka
        suFde8vq/6woHIp/QFE+5GoFUQ==
X-Google-Smtp-Source: ABdhPJzjtQfOKjEzxcDoaWKfvO5idFpCafVijq/Vt6RyCX8lQ9kCgiJyz9gnJMrtGOSpNEYb16yjYw==
X-Received: by 2002:a0c:fe49:: with SMTP id u9mr13968318qvs.40.1603720902977;
        Mon, 26 Oct 2020 07:01:42 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w45sm6881193qtw.96.2020.10.26.07.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:01:42 -0700 (PDT)
Subject: Re: [PATCH v9 0/3] readmirror feature (read_policy sysfs and
 in-memory only approach)
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1603347462.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4fb5fc91-d2b6-1732-d6a1-193d4bd7e59d@toxicpanda.com>
Date:   Mon, 26 Oct 2020 10:01:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <cover.1603347462.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/22/20 3:43 AM, Anand Jain wrote:
> v9: C coding style fixes in 1/3 and 3/3
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to this series, lets get this in so we can focus on the actual changes to the 
policy.  Thanks,

Josef
