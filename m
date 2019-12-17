Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69DC21235BB
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 20:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfLQTcc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 14:32:32 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34044 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfLQTcb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 14:32:31 -0500
Received: by mail-qt1-f195.google.com with SMTP id 5so9660352qtz.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 11:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vdYASwOXr/E0fq5ETAzoynEDrWTN6rFOKQlpHl39eyU=;
        b=yQ8dAoGD42enmgcm2mHHfRI3j5A3Gppx7cQCNv/C5tWzg7ymwydRkHZRGtQ+REwHHV
         zvgZCtEj3oI+0TkhePID7o+Z/6/4Zrg6b5LYyOA36YmaB7p3rkntZPZrv0iZuzuy4r9d
         TeA+jrfAzwKV7bTVctyyeC6DN941Rtm44FXLOgo+yTxwWOyOAT4ovbIY0vA75ZQA+6t2
         YSyzkH6r+FcN6EjPej0n4/DELFOulhKlbEX/Y0vg5UWyMHeaqNF/rWFVjv8d47yo6xjg
         lLuJYmEPjlSDYJozyQf+jIM+9tsikvEphYyjkrJonyFEOK5Ly3xkFOpn6wmuinCKGlPa
         QPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vdYASwOXr/E0fq5ETAzoynEDrWTN6rFOKQlpHl39eyU=;
        b=dsuHAL3xT1wiUeS8lRWbtfZYX/FC2eugUXQFdr0EzCBhWAKpfcwn5RljPc6cvUiZRX
         QxOmoNYefH48ZchTslA/l2Frc4rCrXvUNbG1uDBV4yDIbz6wz+7X6JAUNIl2SMRUqqJb
         TfqBCqsdWUe5c3YglsjBClFJ5w1E3aZHkFpNfeved0NJCKm0VDXZkJum34CVwBLnAEZR
         iuNrtRZrlOXSZ1RMp1mDm5vJ8ShMPJKheduWSkZvxHDE927qSUTM0tM/zU6n+5XJdr1C
         2aNMQ/OAFnRN5pIPcq3dD4RuVGeysd0Sk0C2iQsK0HqsqOlV2sPRrTVlhBaIJwyYQh6C
         DWYg==
X-Gm-Message-State: APjAAAXD31uRBg6jevTi5jX1R2KW/uvrDpdoLsXJKZYpEqq/8ca7xYpQ
        F7+opGkgQCVsPfpiHr43S3gHvg==
X-Google-Smtp-Source: APXvYqz0416XOoy+uzKq3aBneMUJvW8ivi4CQpMCv2Y3pSbldeoBqN53t0DkfbwE1aZm4qlNDjtEMA==
X-Received: by 2002:ac8:59:: with SMTP id i25mr6143830qtg.110.1576611150587;
        Tue, 17 Dec 2019 11:32:30 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4217])
        by smtp.gmail.com with ESMTPSA id b81sm7306717qkc.135.2019.12.17.11.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 11:32:29 -0800 (PST)
Subject: Re: [PATCH v6 12/28] btrfs: ensure metadata space available on/after
 degraded mount in HMZONED
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-13-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7fffd68c-fea4-1a5b-686b-4beaa45fc5ed@toxicpanda.com>
Date:   Tue, 17 Dec 2019 14:32:28 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-13-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/12/19 11:08 PM, Naohiro Aota wrote:
> On/After degraded mount, we might have no writable metadata block group due
> to broken write pointers. If you e.g. balance the FS before writing any
> data, alloc_tree_block_no_bg_flush() (called from insert_balance_item())
> fails to allocate a tree block for it, due to global reservation failure.
> We can reproduce this situation with xfstests btrfs/124.
> 
> While we can workaround the failure if we write some data and, as a result
> of writing, let a new metadata block group allocated, it's a bad practice
> to apply.
> 
> This commit avoids such failures by ensuring that read-write mounted volume
> has non-zero metadata space. If metadata space is empty, it forces new
> metadata block group allocation.
> 

Ick, I hate this, especially since it doesn't take into account if we're mounted 
read only.  No instead add something btrfs_start_transaction() or something 
similar that does this check to allocate a chunk.  And 
alloc_tree_block_no_bg_flush() only means we won't create the pending bg's in 
that path, we're still able to allocate chunks.  So I'm not super sure what you 
are actually hitting here, but this is the wrong way to go about fixing it.  Thanks,

Josef
