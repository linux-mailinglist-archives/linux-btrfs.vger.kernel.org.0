Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD4F61371F4
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 16:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgAJP6H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 10:58:07 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36749 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbgAJP6G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 10:58:06 -0500
Received: by mail-qv1-f67.google.com with SMTP id m14so945602qvl.3
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 07:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xQfP37HdIPUovpEAqmt0zuu85kdPmggq5HzsKM1HjgU=;
        b=gWs/X1nVClx21wJWG0HUyWqq7OzdUSttj+/LuSXMb889SgLAYqEoBgQTZCkOMOGoG/
         d87B+tS6IOop653YteBXz8IvotFyOZxvfbM3niYk+lgY3MprYuiEzR9tQ8mJwnjWQN2b
         EtnRBlyvhR8UaeJ5OgrW7bGKPRYg60ZOiMc5TtlQCNFOzB673GmX29PXR+KIxG1jFAEc
         4HJGANeKaWkMNhusUoQiX22S5C3u01nlW1nIqod40o2Dk6s4ljnE7VxVAAXNZPA/OTkW
         fttHuCcfeot1Sjc6uAlYFB6/bnq6QmtagtQTDzLbW02rXWwuB5uu3hNBir0iCOubhnvL
         MoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xQfP37HdIPUovpEAqmt0zuu85kdPmggq5HzsKM1HjgU=;
        b=Sg16Y73oi3qa/eNEhnW/8th5eVGwILtCAYC9rKRRQOw85wqmKPhFGvRO4Tq/JAw2Qz
         OXqASLShuW7gEpNymVwyuc3iZ4sq+Uj69EsiBYiC141FSIO50lxwnN56uOwQ2N4R+QwR
         K31GtRfFG4NkMbfm1zhbnG6/2u/SCDTtLgPCOi5j4SAwuC0XRxcgKJ6UnxyZs1NKPPub
         AqyItQEnOaES/vFFSVlzo7xTIB81U+F0ShFh4jnp6+8Z99UKJELoCD4xhR4hXI6mG0VP
         /Q8D2nVzd/W6LYw6LIWC2vg+HL+xHLsc7bMXpMIBZ532NWfuwxBbd3HepvxbyBeCREvy
         tC6w==
X-Gm-Message-State: APjAAAU8IQ4RjYbrK3aHY46mw45fOI053xax+w4GOQPimx1IdAP97FZr
        tr1J4wZMKMkfTIFWa2UekMY4IAcnIOPU1Q==
X-Google-Smtp-Source: APXvYqzSf5I0U4sU7QQb9Nu6gO/JHhDtg2lmCaXPxjKrSRnRqXb7R/U+BhlTtIgq7T44TPECJTMt/Q==
X-Received: by 2002:a05:6214:8c3:: with SMTP id da3mr3234023qvb.249.1578671885645;
        Fri, 10 Jan 2020 07:58:05 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4dc2])
        by smtp.gmail.com with ESMTPSA id 13sm1027691qke.85.2020.01.10.07.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 07:58:04 -0800 (PST)
Subject: Re: [PATCH 4/4] btrfs: Fix split-brain handling when changing FSID to
 metadata uuid
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200110121135.7386-1-nborisov@suse.com>
 <20200110121135.7386-5-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4acd7424-1279-c988-51e1-02112b8d6c62@toxicpanda.com>
Date:   Fri, 10 Jan 2020 10:58:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110121135.7386-5-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/10/20 7:11 AM, Nikolay Borisov wrote:
> Current code doesn't correctly handle the situation which arises when
> a file system that has METADATA_UUID_INCOMPAT flag set  has its FSID
> changed to the one in metadata uuid. This causes the incompat flag to
> disappear. In case of a power failure we could end up in a situation
> where part of the disks in a multi-disk filesystem are correctly
> reverted to METADATA_UUID_INCOMPAT flag unset state, while others have
> METADATA_UUID_INCOMPAT set and CHANGING_FSID_V2_IN_PROGRESS.
> 
> This patch corrects the behavior required to handle the case where a
> disk of the second type is scanned first, creating the necessary
> btrfs_fs_devices. Subsequently, when a disk which has already completed
> the transition is scanned it should overwrite the data in
> btrfs_fs_devices.
> 
> Reported-by: Su Yue <Damenly_Su@gmx.com>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
