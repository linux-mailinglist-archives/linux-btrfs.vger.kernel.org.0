Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432444393C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 12:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhJYKev (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 06:34:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56390 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhJYKev (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 06:34:51 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5BEE61FD34;
        Mon, 25 Oct 2021 10:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635157948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ogm607LODmcgnpFdWOXl4Mcu+0BQj6ydglqgt86Tt6k=;
        b=uQH2IYmK81CyIoF4qN/fCb3n6Esxhu2dGqQmA0c5w1lxd4JQOPoRu6coZX5gv1Jm+ltw7H
        DKh0SNDDyzF8EOdNz+xNtuWMQtI6mpwcpIYUClhdQq5q4SuRXpej5LmZ6O3Ov3WsbVgbht
        2xn/9OI0wmq7VSK3keskxYu9Z2SrTFk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B3B913A86;
        Mon, 25 Oct 2021 10:32:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /9kACLyHdmGXeQAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 25 Oct 2021 10:32:28 +0000
Subject: Re: Filesystem Read Only due to errno=-28 during metadata allocation
To:     mailing@dmilz.net, Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <f2ed8b05b03db6a4fec4cba7ed17222a@dmilz.net>
 <20211018140936.GA1208@hungrycats.org>
 <aefefca716de925195a0190a8d583a1d@dmilz.net>
 <20211019132631.GB1208@hungrycats.org>
 <537ba7e11aae3e2c2cf28f546268c356@dmilz.net>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <a875f5f2-5d58-39bd-87be-74f5322ce035@suse.com>
Date:   Mon, 25 Oct 2021 13:32:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <537ba7e11aae3e2c2cf28f546268c356@dmilz.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 25.10.21 г. 12:53, mailing@dmilz.net wrote:
<snip>

> Thanks for all information!
> 
> If the chunk size (128MB, 256MB... 1GB) is in relation to the FS size,
> is there a command to determine the chunk size for data and metadata?

You can determine it by dumping the on-disk data structure via btrfs
inspect-internal dump-tree -t2 /dev/foo this will contain the currently
allocated blockgroups and their respective size.


> Should I expect BTRFS to start allocating bigger chunk at some point
> after filesystem extension?

Yes, this is mandated by the code in init_alloc_chunk_ctl_policy_regular
function.

Basically data chunks are at most 1G in size, metadat chunks are either
1G or 256m depending on whether the fs is larger than 50gb. But a chunk
can never be more than 10% of the writable space on disk.

> 
