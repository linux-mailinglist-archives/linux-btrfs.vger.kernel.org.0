Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6E12323B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 19:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgG2Rt5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 13:49:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48857 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726336AbgG2Rt5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 13:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596044996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5XCD70yhAJXwOmf9H1vZrpLTzrxGYtsoip3J7/JKllY=;
        b=ep0QCwsaz4UFj6thUi35RARvcfdEPzO2DvdFhxKP9gQZvjUApISHK3ID/QJ3+4FgFGYB/i
        jl898H86roO3pPisDsfCbrEBxTXp7+DdWzUx6/hEiTxigRpG+NGGFWKyWr8/nwOSIC4dST
        1N/V6NG+QUPCgA3RhXR6yO0xZtubdG8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-Qf18UHbuNqSeVOQZhyKcNw-1; Wed, 29 Jul 2020 13:49:53 -0400
X-MC-Unique: Qf18UHbuNqSeVOQZhyKcNw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDD9A18C63C5;
        Wed, 29 Jul 2020 17:49:52 +0000 (UTC)
Received: from Liberator.local (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CBA387B03;
        Wed, 29 Jul 2020 17:49:52 +0000 (UTC)
Subject: Re: [PATCH] btrfs: indicate iversion option in show_options
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200729164656.7153-1-josef@toxicpanda.com>
 <48ad9fc0-dbdd-60f3-c1ab-f0152f6e3230@redhat.com>
 <e8a98d4d-505f-de47-d469-c0cdaac5351c@toxicpanda.com>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <c6ecb493-e769-0db0-7d44-5bfaf0b89fad@redhat.com>
Date:   Wed, 29 Jul 2020 10:49:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e8a98d4d-505f-de47-d469-c0cdaac5351c@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/29/20 10:47 AM, Josef Bacik wrote:
> On 7/29/20 1:42 PM, Eric Sandeen wrote:
>> On 7/29/20 9:46 AM, Josef Bacik wrote:
>>> Eric reported a problem where if you did
>>>
>>> mount -o remount /some/btrfs/fs
>>>
>>> you would lose SB_I_VERSION on the mountpoint.  After a very convoluted
>>> search I discovered this is because the remount infrastructure doesn't
>>> just say "change these things specifically", but it actually depends on
>>> userspace to tell it fucking everything that needs to be set on the
>>> mountpoint.  This led to the fucking horrifying discovery that
>>> util-linux actually has to parse /proc/mounts to figure out what the
>>> fuck is set on the mount point in order to preserve any of the options
>>> it's not actually fucking with, so in this case iversion.  If we don't
>>> indicate iversion is set, then we get iversion cleared on the mount,
>>> because util-linux doesn't pass in MS_I_VERSION as it's mount flags.
>>>
>>> So work around this fucking insanity by spitting out iversion in
>>> /proc/mounts so we get the correct flags passed to us in remount.
>>
>> Hmmm:
>>
>> # mount -o loop,noiversion btrfsfile mnt
>> # grep btrfs /proc/mounts
>> /dev/loop0 /tmp/mnt btrfs rw,seclabel,relatime,iversion,space_cache,subvolid=5,subvol=/ 0 0
>> #
>>
> 
> Ugh that's because we just set it unconditionally like XFS does, but don't actually pay attention to noiversion otherwise.  I'll fix that separately.  Thanks,

FWIW,

# mount -o remount,noiversion mnt
# grep btrfs /proc/mounts
/dev/loop0 /tmp/mnt btrfs rw,seclabel,relatime,noiversion,space_cache,subvolid=5,subvol=/ 0 0

-Eric

